#!/usr/bin/env ruby

require "sinatra"
require "sinatra/reloader" if development?
require_relative './web_scraper'


get "/" do

  mech = Mechanize.new
  ip = request.ip
  mech_object = JSON.parse(mech.get("https://www.freegeoip.net/json/173.169.240.17").body)["zip_code"]

  erb :index, locals: { data: nil, mech_object: mech_object }
end


post '/' do

  job_keyword = params[:job]
  job_location = params[:location]
  job_type = params[:type]

  web_scraper = WebScraper.new(job_keyword, job_location, job_type)
  web_scraper.loop_through_job_links
  web_scraper.all_data
  all_data = web_scraper.data

  erb :index, locals: {
    data: all_data
  }

end