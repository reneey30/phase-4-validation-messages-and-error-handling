class MoviesController < ApplicationController
  wrap_parameters false
  rescue_from ActiveRecord::RecordInvalid, with: :error_handling
  
  def index
    movies = Movie.all
    render json: movies, status: :ok
  end

  def create
    movie = Movie.create!(movie_params)
    render json: movie, status: :created
  end

  private

  def movie_params
    params.permit(:title, :year, :length, :director, :description, :poster_url, :category, :discount, :female_director)
  end

  def error_handling(invalid)
    render json: { errors: invalid.record.errors }, status: :unprocessable_entity
  end
end
