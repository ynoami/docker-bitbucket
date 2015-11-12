FROM ynoami/java
#FROM ubuntu:latest

MAINTAINER ynoami<nyata100@gmail.com>

RUN apt-get install curl git -y
RUN curl -L -O https://www.atlassian.com/software/stash/downloads/binary/atlassian-bitbucket-4.1.0.tar.gz \
    && mkdir -p /opt/atlassian \
    && tar -zxvf atlassian-bitbucket-4.1.0.tar.gz -C /opt/atlassian \
    && rm atlassian-bitbucket-4.1.0.tar.gz

RUN useradd --create-home --comment "Account for runnning stash" --shell /bin/bash stash

RUN mkdir -p /var/atlassian/application-data/bitbucket
RUN chown -R stash /opt/atlassian/
RUN chgrp -R stash /opt/atlassian/
RUN cp /opt/atlassian/atlassian-bitbucket-4.1.0/conf/server.xml /var/atlassian/application-data/bitbucket

#ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV BITBUCKET_HOME /var/atlassian/application-data/bitbucket


ENTRYPOINT ["/opt/atlassian/atlassian-bitbucket-4.1.0/bin/start-bitbucket.sh", "-fg"]


