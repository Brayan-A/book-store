# Pull base image
FROM python:3.10.4-slim-bullseye
# Set environment variables
ENV PIP_DISABLE_PIP_VERSION_CHECK 1
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
# Set work directory
WORKDIR /code
# Install dependencies
COPY ./requirements.txt .
RUN pip install -r requirements.txt

# Install mssql linux odb driver
RUN apt update -y
RUN apt install curl gnupg gnupg1 gnupg2 -y
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
#Debian 11
RUN curl https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list

RUN apt update -y
RUN apt install unixodbc-dev -y
RUN ACCEPT_EULA=Y apt-get install -y msodbcsql17

# Copy project
COPY . .