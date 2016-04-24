# coding:utf-8

require 'rubygems' 
require 'yaml'
require 'twitter'

# Tweet した時間の算出
def tweet_id2time(id)
  Time.at(((id.to_i >> 22) + 1288834974657) / 1000.0)
end

# File Read
keys = YAML.load_file('./config.yml')

# config set
client = Twitter::REST::Client.new do |config|
    config.consumer_key        = keys["api_key"]
    config.consumer_secret     = keys["api_secret"]
    config.access_token        = keys["acc_token"]
    config.access_token_secret = keys["acc_token_secret"]
end

# getID 
max_id = client.home_timeline.first.id

# CUI Show
5.times do
    client.home_timeline(max_id: max_id,count: 5).each do |tweet|
    	puts ("===================================================")
        puts "User : " + tweet.user.name
        puts tweet_id2time(max_id)
        puts tweet.full_text
        puts "★: #{tweet.favorite_count}, RT: #{tweet.retweet_count}"
        max_id = tweet.id unless tweet.retweeted?
    end
    sleep 60
end
