FROM ynoami/java
#FROM ubuntu:latest

MAINTAINER ynoami<nyata100@gmail.com>

ENV BITB_VERSION 4.1.0

RUN apt-get install curl git -y
RUN curl -L -O https://www.atlassian.com/software/stash/downloads/binary/atlassian-bitbucket-${BITB_VERSION}.tar.gz \
    && mkdir -p /opt/atlassian \
    && tar -zxvf atlassian-bitbucket-${BITB_VERSION}.tar.gz -C /opt/atlassian \
    && rm atlassian-bitbucket-${BITB_VERSION}.tar.gz

RUN useradd --create-home --comment "Account for runnning stash" --shell /bin/bash stash

RUN mkdir -p /var/atlassian/application-data/bitbucket
RUN chown -R stash /opt/atlassian/
RUN chgrp -R stash /opt/atlassian/
RUN cp /opt/atlassian/atlassian-bitbucket-${BITB_VERSION}/conf/server.xml /var/atlassian/application-data/bitbucket

#ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV BITBUCKET_HOME /var/atlassian/application-data/bitbucket

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

ENTRYPOINT ["/sbin/entrypoint.sh"]
