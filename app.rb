require "sinatra"
require "sinatra/reloader"
require "http"

get("/") do
  @raw_response = HTTP.get("https://api.exchangerate.host/list?access_key=#{ENV.fetch("EXCHANGE_RATE_KEY")}")

  @string_response = @raw_response.to_s

  @parsed_response = JSON.parse(@string_response)

  @currencies = @parsed_response.fetch("currencies")

  erb(:home)
end


get("/:first_symbol") do
  @the_symbol = params.fetch("first_symbol")

  @raw_response = HTTP.get("https://api.exchangerate.host/list?access_key=#{ENV.fetch("EXCHANGE_RATE_KEY").chomp}")

  @string_response = @raw_response.to_s

  @parsed_response = JSON.parse(@string_response)

  @currencies = @parsed_response.fetch("currencies")

  erb(:step_one)
end 



get("/:from_currency/:to_currency") do
  @from = params.fetch("from_currency")
  @to = params.fetch("from_currency")

  @url = "https://api.exchangerate.host/convert?from=#{@from}&to=#{@to}=INR&amount=1&access_key=#{ENV.fetch("EXCHANGE_RATE_KEY").chomp}"

  @raw_response = HTTP.get(@url)

  @string_response = @raw_response.to_s

  @parsed_response = JSON.parse(@string_response)

  @amount = @parsed_response.fetch("result")

  erb(:step_two)
end 
