require 'net/http'
require 'net/https'
require 'openssl'

class ChirpsController < ApplicationController
  def index
    @chirps = Chirp.all.reverse

    @chirp = Chirp.new
  end

  def create
    params.permit!
    @chirp = Chirp.new(params[:chirp])
    @chirp.save
    payload = params[:chirp]
    url = "https://bellbird.joinhandshake-internal.com/push"
    uri = URI(url)

    if @chirp.valid?

      Net::HTTP.start(uri.host, uri.port) do |http|
        https = Net::HTTP.new(uri.host,uri.port)
        https.use_ssl = true

        request = Net::HTTP::Post.new(uri)
        request.body = {chirp_id: 1}.to_json
        response = https.request(request)
        puts response
      end
    end
    redirect_to root_path
  end
end
