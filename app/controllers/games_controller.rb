require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    @letters << (0...10).map { ('a'..'z').to_a[rand(26)] }.join
  end

  def score
    @word = params[:word]
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    user_serialized = URI.open(url).read
    @dictionary = JSON.parse(user_serialized)

    # @letters = params[:letters].split('')
    # @word.split('').each do | letter |
    #   letters.pop(letter) if @letters.include?(letter)

    @score = 0
    @score += @word.size if @dictionary['found']

    session[:total_score] = session[:total_score] ? session[:total_score] + @score : @score
  end
end
