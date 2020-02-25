FROM debian:9

RUN apt-get update \
    && apt-get install -y --no-install-recommends apt-utils curl ca-certificates fontconfig locales \
    && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && locale-gen en_US.UTF-8 \
    && rm -rf /var/lib/apt/lists/*
    
ENV JAVA_HOME /usr/local/openjdk-8 \
ENV PATH $JAVA_HOME/bin:$PATH \
ENV ESUM='82f34d0917c068e49cd23a7350ccc592648b31bad45ea89536577493a043eab6' \
ENV BINARY_URL='https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u242-b08_openj9-0.18.1/OpenJDK8U-jdk_s390x_linux_openj9_8u242b08_openj9-0.18.1.tar.gz'

RUN set -eux; \
    && curl -LfsSo /tmp/openjdk.tar.gz ${BINARY_URL}; \
    && echo "${ESUM} */tmp/openjdk.tar.gz" | sha256sum -c -; \
    && mkdir -p /usr/local/openjdk-8; \
    && cd /usr/local/openjdk-8; \
    &&tar -xf /tmp/openjdk.tar.gz --strip-components=1; \
    && rm -rf /tmp/openjdk.tar.gz;
