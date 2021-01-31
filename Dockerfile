ARG NUXEO_VERSION=latest

FROM docker.packages.nuxeo.com/nuxeo/nuxeo:${NUXEO_VERSION}

ARG CLID=''
ARG NUXEO_PACKAGES=''
ARG NUXEO_APPEND_TEMPLATES=''

COPY --chown=900:0 local-packages $NUXEO_HOME/local-packages
RUN compgen -G "$NUXEO_HOME/local-packages/*.zip" > /dev/null \
  && /install-packages.sh --offline $NUXEO_HOME/local-packages/*.zip \
  || echo 'No local package to install'

RUN [[ ! -z "${NUXEO_PACKAGES}" ]] \
  && /install-packages.sh --clid ${CLID} "${NUXEO_PACKAGES}" \
  || echo 'No package to install'

COPY --chown=900:0 conf.d/* /etc/nuxeo/conf.d
COPY --chown=900:0 templates/* $NUXEO_HOME/templates/

RUN [[ ! -z "${NUXEO_APPEND_TEMPLATES}" ]] \
  && sed -i "s/^#nuxeo.templates=/nuxeo.templates=/" $NUXEO_HOME/bin/nuxeo.conf \
  && sed -i "/^nuxeo.templates=/ s/$/,${NUXEO_APPEND_TEMPLATES}/" $NUXEO_HOME/bin/nuxeo.conf \
  || echo 'No template to append'
