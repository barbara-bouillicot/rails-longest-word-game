require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << ("a".."z").to_a.sample
    end
    @letters.join
  end

  def included?
    @word.chars.all? { |letter| @grid.include?(letter)}
  end

  def score
    @word = params[:word]
    @grid = params[:grid]
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    dictionary_serialized = URI.open(url).read
    @dictionary = JSON.parse(dictionary_serialized)


    @score = @word.chars.count
    if  @dictionary["found"]== false
      @result = "Sorry but #{@word.upcase}# does not seem to be a valid English word..."
    elsif !included?
      @result = "Sorry but #{@word.upcase}can't be build out of #{@grid.to_s.upcase}"
    else
      @result = "Congratulations! #{@word.upcase} is a valid English word! Your score is: #{@score}"
    end
end
end
