#!/usr/bin/env ruby

require "sinatra"
require "sinatra/reloader" if development?
require_relative './web_scraper'


get "/" do

  erb :index

end


post '/job_search' do

  job_keyword = params[:job]
  job_location = params[:location]
  job_type = params[:type]

  web_scraper = WebScraper.new(job_keyword, job_location, job_type)
  web_scraper.loop_through_job_links
  web_scraper.all_data
  all_data = web_scraper.data

  erb :job_search, locals: {
    data: all_data
  }

end