#
# dockerfile for datazoomer
#

FROM ubuntu:14.04

MAINTAINER Herb Lainchbury <herb@dynamic-solutions.com>


# install os packages
RUN apt-get update
RUN apt-get -y install \
    apache2 \
    git \
    mysql-client \
    mysql-server \
    python-imaging \
    python-MySQLdb \
    python-pip \
    libxml2-dev \
    libxslt1-dev \
    libffi-dev \
    libssl-dev \
    python-dev


# configure apache modules
RUN cd /etc/apache2/mods-enabled && sudo ln -s ../mods-available/rewrite.load
RUN cd /etc/apache2/mods-enabled && sudo ln -s ../mods-available/cgi.load


# install pip and python libraries
RUN pip install --upgrade pip
RUN pip install \
    BeautifulSoup \
    markdown \
    nose \
    faker \
    pyrss2gen \
    bcrypt \
    scrypt
run pip install -Iv passlib==1.6.2


# upload scripts
ADD setup.sh /tmp/setup.sh
ADD start.sh /tmp/start.sh


# run the final setup
RUN /bin/bash /tmp/setup.sh


# run the server
EXPOSE 80
CMD ["/bin/bash", "/tmp/start.sh"]

