FROM ruby:3.3.3-alpine AS builder
FROM ubuntu:latest
COPY . /app
RUN pip install -r requirements.txt
# ... (existing instructions to copy your code)

RUN apt-get update && apt-get install -y python2.7

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN apt-get
RUN bundle install
RUN apt-get update && apt-get install -y build-essential libc6-dev libffi-dev zlib1g-dev

COPY . .

FROM ruby:3.1-alpine

WORKDIR /usr/src/app

COPY --from=builder /usr/local/bundle .bundle

EXPOSE 3000
 

CMD [ "python", "app.py" ,"rails", "server", "-b", "0.0.0.0"]
