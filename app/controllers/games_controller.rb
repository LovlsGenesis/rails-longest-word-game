require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    vowels = %w(a e i o u y)
    @letters = (0...4).map { vowels[rand(6)] }
    @letters += (0...6).map { (('a'..'z').to_a - vowels)[rand(20)] }
    @letters = @letters.shuffle.join(' ')
  end

  def score
    word = params[:word]
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    data_serialized = open(url).read
    data = JSON.parse(data_serialized)
    @letters = params[:letters]

    if word.split.all? { |letter| @letters.count(letter) >= word.count(letter) }
      if data['found'] == true
        @end = 'Congratz'
        @score += 1
      else
        @end = 'The word doesn\'t exist'
      end
    else
      @end = 'The word can\'t be processed'
    end
  end
end
