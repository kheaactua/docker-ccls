ARG UBUNTU_TAG=18.04
FROM ubuntu:${UBUNTU_TAG}

RUN apt-get -q -y update                      \
    && apt-get install -q -y                  \
        build-essential                       \
        autoconf automake libtool libtool-bin \
        git g++ cmake make gcc                \
        clang-tools-9 libclang-9-dev          \
        rapidjson-dev                         \
    && apt-get -q -y autoremove               \
    && apt-get -q -y clean                    \
    && update-alternatives --install /usr/bin/clang clang /usr/bin/clang-9 2 \
        --slave /usr/bin/clang++ clang++ /usr/bin/clang++-9

LABEL                                                             \
  org.label-schema.description="ccls"                             \
  org.label-schema.name="kheaactua/ccls"                          \
  org.label-schema.schema-version="1.0"                           \
  org.label-schema.url="https://github.com/kheaactua/docker-ccls" \
  org.label-schema.vendor="Matthew Russell"                       \
  org.label-schema.version="0.1"

ARG INSTALL_PREFIX=/usr/local
ENV INSTALL_PREFIX=${INSTALL_PREFIX}

ARG CCLS_TAG=0.20190823.5
ENV CCLS_TAG=${CCLS_TAG}

WORKDIR /bin
COPY install.sh ./
RUN ["chmod", "+x", "install.sh"]
RUN ["./install.sh"]

ENTRYPOINT ["/usr/local/bin/ccls"]

# vim: ts=4 sw=4 expandtab ff=unix :
