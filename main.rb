require 'sinatra'
require 'mandrill'
require 'geolocater' #can be used for analytics or to require that user is in an area the site services

get '/home/' do
	@title = "Snck"
    erb :home
end

get '/about/' 
	do @title = "About"
	erb :about 
end

get '/products/' do 
	@title = "Products"
	erb :products 
end

get '/contact/' do 
	@title = "Contact"
	erb :contact 
end

post '/contact' do
	puts params.inspect
	email = params["email"]
	user_message = params["message"]
	puts "Sending Email"  
	m = Mandrill::API.new
	message = {  
	 	:subject=> "Website Message",  
	 	:from_name=> "Web Monitor",  
	 	:text=>"New message " + user_message,  
	 	:to=>[  
	   		{
		    	:email=> "admin@snck.com",  #address emails are sent to
		    	:name=> "Website User"  
			}
		 ],  
			:html=>"<html><h1>New Web Message</h1><h3> #{user_message}</h3></html>",  
			:from_email=> email  
	}
	sending = m.messages.send message  
	puts sending
	redirect to('/thanks')
end

get '/thanks/' do 
	@title = "Thanks"
	erb :thanks 
end
