require 'csv'
require 'pry'
require 'sinatra'

teams_info = []
CSV.foreach("lackp_starting_rosters.csv",headers:true,header_converters: :symbol) do |row|
  teams_info << row.to_hash
end

def pic_team (array)
  teams = []
  array.each do |row|
  teams << row[:team]
 end
 teams.uniq
end

def find_players (teams)
  players = []

  CSV.foreach("lackp_starting_rosters.csv", headers:true,header_converters: :symbol) do |row|
    if row[:team] == teams
      players << row.to_hash
    end
  end
  players
end

def find_position (position)
  positions = []

  CSV.foreach("lackp_starting_rosters.csv", headers:true,header_converters: :symbol) do |row|
    if row[:position] == position
      positions << row.to_hash
    end
  end
  positions
end




get '/' do
  @team = pic_team(teams_info)
erb :kickball
end

get '/team/:team_name' do
@player = find_players(params[:team_name])
erb :player
end

get '/position/:position' do
@position = find_position(params[:position])
erb :position
end

set :views, File.dirname(__FILE__) + '/views'
