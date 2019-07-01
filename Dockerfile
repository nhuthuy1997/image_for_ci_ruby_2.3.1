FROM ruby:2.3.1

MAINTAINER thuynguyennhu97@gmail.com

RUN rm /etc/apt/sources.list
RUN echo "deb http://archive.debian.org/debian/ jessie main" | tee -a /etc/apt/sources.list
RUN echo "deb-src http://archive.debian.org/debian/ jessie main" | tee -a /etc/apt/sources.list
RUN echo "Acquire::Check-Valid-Until false;" | tee -a /etc/apt/apt.conf.d/10-nocheckvalid
RUN echo 'Package: *\nPin: origin "archive.debian.org"\nPin-Priority: 500' | tee -a /etc/apt/preferences.d/10-archive-pin

RUN apt-get update && apt-get install -y \
    software-properties-common locales

RUN locale-gen en_US.UTF-8

ENV LANGUAGE=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=C.UTF-8
ENV LC_CTYPE=UTF-8
ENV TERM xterm
ENV BUNDLER_VERSION=2.0.1 
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get install -y libpq5 libpq-dev

#install NodeJs 8x
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -
RUN apt-get install -y nodejs

# Install eslint from https://www.npmjs.com/package/eslint
RUN npm install -g eslint yarn eslint-plugin-react concat-map

RUN apt-get -y update && apt-get -y install ruby-full

# Install bases gems

RUN gem install bundler -v 2.0.1

RUN gem install rspec \
	scss_lint \
	brakeman \
	bundle-audit \
	reek \
	rails_best_practices \
	simplecov \
	robocop \
	rake \
	sass \
	rubocop-rspec \
	scss_lint_reporter_checkstyle \
	strip_attributes
WORKDIR /workdir

