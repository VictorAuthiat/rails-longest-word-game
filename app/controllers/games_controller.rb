require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    5.times { @letters << ("A".."Z").to_a.sample }
    # 3.times { @letters << ['A','E','I','O','U','Y'].to_a.sample }
    @letters << ['H'].sample
    @letters << ['E'].sample
    @letters << ['L'].sample
    @letters << ['L'].sample
    @letters << ['O'].sample
    return @letters
  end

  def english_word
    url = "https://wagon-dictionary.herokuapp.com/#{@result}"
    word_dictionary = open(url)
    word = JSON.parse(word_dictionary.read)
    return word['found']
  end

  def letter_in_grid
    @result.chars.sort.all? { |letter| @grid.include?(letter) }
  end

  def score
    @grid = params[:grid]
    @result = params[:word].upcase
    grid_letters = @grid.each_char { |letter| print letter, ''}
    if !letter_in_grid
      @result = "Dsl #{@result.upcase} ne peut pas être construit a partir de #{grid_letters}."
    elsif !english_word
      @result = "Dsl #{@result.upcase} n'est pas un mot anglais.."
    elsif letter_in_grid && !english_word
      @result = "Dsl #{@result.upcase} n'est pas un mot anglais"
    else letter_in_grid && !english_word
      @result = "BRAVO! #{@result.upcase} valid English word."
    end
  end
end

