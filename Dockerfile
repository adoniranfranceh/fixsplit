FROM ruby:3.4.2

WORKDIR /app

RUN apt-get update -qq && apt-get install -y \
    nodejs \
    npm \
    postgresql-client \
    imagemagick \
    && rm -rf /var/lib/apt/lists/*

RUN npm install -g yarn

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 4 --retry 3

COPY . .

RUN yarn install

EXPOSE 3000

CMD ["bin/rails", "server", "-b", "0.0.0.0"]
