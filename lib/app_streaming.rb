#####################################################################
#  
#  Mon programme :
#  
#  1/ 
#####################################################################
#
# lignes très importantes qui appellent les gem.
require 'twitter'
require 'dotenv'  # Pour récupéter les infos du .env en Hash ENV
require 'pry'

# def login_twitter

#   Dotenv.load('.env') # Récup du Hash ENV

#   config = {
#     consumer_key:        "YOUR_CONSUMER_KEY",
#     consumer_secret:     "YOUR_CONSUMER_SECRET",
#     access_token:        "YOUR_ACCESS_TOKEN",
#     access_token_secret: "YOUR_ACCESS_SECRET"
#   }

#   return client = Twitter::Streaming::Client.new(config)

# end

# # Démarrage -----------
# client = login_twitter


while true
    begin
        # Create a read write application from : 
        # https://apps.twitter.com
        # authenticate it for your account
        # fill in the following
        config = {
            consumer_key:        "YOUR_CONSUMER_KEY",
            consumer_secret:     "YOUR_CONSUMER_SECRET",
            access_token:        "YOUR_ACCESS_TOKEN",
            access_token_secret: "YOUR_ACCESS_SECRET"
        }
        rClient = Twitter::REST::Client.new config
        sClient = Twitter::Streaming::Client.new(config)

        # topics to watch
        topics = ['#rails', '#ruby', '#coding', '#codepen']
        sClient.filter(:track => topics.join(',')) do |tweet|
            if tweet.is_a?(Twitter::Tweet)
              puts tweet.text 
              rClient.fav tweet
            end
        end
    rescue
        puts 'error occurred, waiting for 15 seconds'
        sleep 15
    end

end


# binding.pry

# client.sample do |object|
#   puts object.text if object.is_a?(Twitter::Tweet)
# end

# topics = ["coffee", "tea"]
# client.filter(track: topics.join(",")) do |object|
#   puts object.text if object.is_a?(Twitter::Tweet)
# end

# client.user do |object|
#   case object
#   when Twitter::Tweet
#     puts "It's a tweet!"
#   when Twitter::DirectMessage
#     puts "It's a direct message!"
#   when Twitter::Streaming::StallWarning
#     warn "Falling behind!"
#   end
# end