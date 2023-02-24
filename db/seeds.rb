# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "json"
require "open-uri"

puts "Cleaning database..."
Movie.destroy_all

puts "Adding movies..."
url = "https://tmdb.lewagon.com/movie/top_rated?api_key=%3Cyour_api_key%3E"
movies = URI.open(url).read
movies_parsed = JSON.parse(movies)

movies_parsed["results"].each do |movie|
  title = movie["original_title"]
  overview = movie["overview"]
  rating = movie["vote_average"]
  poster_url = "https://image.tmdb.org/t/p/original#{movie["backdrop_path"]}"
  new_movie = Movie.create!(title: title, overview: overview, rating: rating, poster_url: poster_url)
  p new_movie
end
puts "Finished!"
