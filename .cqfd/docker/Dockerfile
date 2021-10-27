# Copyright (C) 2021, RTE (http://www.rte-france.com)
# SPDX-License-Identifier: Apache-2.0

FROM fedora:34

RUN dnf install -y npm fd-find java-11-openjdk && \
    npm install -g npm-groovy-lint

COPY check_Jenkinsfiles.sh /usr/bin/
