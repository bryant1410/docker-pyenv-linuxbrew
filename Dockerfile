FROM ubuntu

RUN apt-get update
RUN apt-get install -y \
    build-essential \
    curl \
    file \
    git \
    libncurses5-dev \
    llvm \
    make \
    m4 \
    ruby \
    wget \
    xz-utils \
    zlib1g-dev

ENV USER_HOME /var/user_home

ARG user=user
ARG group=user
ARG uid=1000
ARG gid=1000

RUN groupadd -g ${gid} ${group} \
    && useradd -d "${USER_HOME}" -u ${uid} -g ${gid} -m -s /bin/bash ${user}

USER ${uid}

ENV PYENV_ROOT=${USER_HOME}/.pyenv
RUN curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash

ENV PATH ${USER_HOME}/.pyenv/bin:${PATH}
RUN eval "$(pyenv init -)"
RUN eval "$(pyenv virtualenv-init -)"

ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

RUN ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"

ENV LINUX_BREW ${USER_HOME}/.linuxbrew

ENV PATH ${LINUX_BREW}/bin:$PATH
ENV MANPATH ${LINUX_BREW}/share/man:$MANPATH
ENV INFOPATH ${LINUX_BREW}/share/info:$INFOPATH

RUN brew install -y \
    bzip2 \
    lbzip2 \
    openssl \
    readline \
    sqlite \
    zlib

RUN pyenv install 3.5.2
