FROM centos:centos7
RUN yum update -y
RUN yum install -y \
	https://repo.ius.io/ius-release-el7.rpm \
	https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum install -y python36 python36-libs python36-devel python36-pip
ENV PYTHONUNBUFFERED 1
RUN mkdir /code
WORKDIR /code
RUN pip3 install --upgrade pip
COPY requirements.txt /code/
RUN pip3 install -r requirements.txt
COPY . /code/
RUN python3 manage.py makemigrations \
	&& python3 manage.py migrate \
	&& python3 manage.py runserver 8000