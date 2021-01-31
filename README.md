# nuxeo-custom-docker
Project to build a custom Nuxeo Docker Image.

## Getting started

To build this image without any customization, just do:

```bash
docker build -t nuxeo-custom .
```

To build from a specific Nuxeo version, you can use the `NUXEO_VERSION` build argument:

```bash
docker build -t nuxeo-custom:11.4 --build-arg NUXEO_VERSION=11.4 .
```

To install remote packages, at build time, you can use the `NUXEO_PACKAGES` build argument, a valid `CLID` must also be provided:

```bash
docker build -t nuxeo-custom-web-ui --build-arg CLID="..." --build-arg NUXEO_PACKAGES=nuxeo-web-ui .
```

To append Nuxeo templates at build time, you can use the `NUXEO_APPEND_TEMPLATES` build argument:

```bash
docker build -t nuxeo-custom-mongodb --build-arg NUXEO_APPEND_TEMPLATES=mongodb .
```

## Advanced usages

### Provide custom configuration

In order to provide custom configuration to the Nuxeo image, you can put your `*.conf` files in the [`conf.d`](conf.d) folder,
they will be appended to the regular `nuxeo.conf` when running the image.

### Provide local packages

In order to install local packages into the Nuxeo image, you can put your `*.zip` package files in the [`local-packages`](local-packages) folder,
they will be installed during the image construction.

Note: their dependencies won't be resolved against Nuxeo Connect.

### Provide custom templates

In order to provide custom templates to the Nuxeo image, you can put your template folder in the [`templates`](templates) folder,
they will be copied during the image construction.

Note: they won't be enabled in the Nuxeo configuration, you might use `NUXEO_APPEND_TEMPLATES` build argument for that.
For example, you have put a `my-template` folder in `templates` folder, the command line to build the image will look like below:

```bash
docker build -t nuxeo-custom-template --build-arg NUXEO_APPEND_TEMPLATES=my-template .
```
