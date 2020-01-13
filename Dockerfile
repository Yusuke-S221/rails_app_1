# 基にするイメージを指定、今回はRuby
FROM ruby:2.5.3

# 必要なパッケージのインストール
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
    apt-get update -qq && \
    apt-get install -y build-essential \
                       libpq-dev \
                       nodejs \
                       mysql-client


# 作業ディレクトリの作成、今回はsample_appと命名
RUN mkdir /sample_app
# APP_ROOTに作成したsample_appを指定
ENV APP_ROOT /sample_app
# 作業ディレクトリの指定、ここではAPP_ROOTすなわち/sample_appのこと
WORKDIR $APP_ROOT

# ローカルのGemfileとGemfile.lockをコンテナ側に追加
ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

# Gemfileのbundle install
RUN bundle install
ADD . $APP_ROOT
