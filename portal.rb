require 'rubygems'
require 'prawn'
require 'prawn/core'
require 'prawn/layout'
require 'csv'
require 'awesome_print'

# Parse the CSV
residents = CSV.read("./residents.csv")

rooms = Hash.new
residents.each { |r| rooms[r[0]] = (rooms[r[0]] || []) + [r[1]] }
rooms = rooms.sort

# Create the PDF object
pdf = Prawn::Document.generate("./output/portal_doordecs.pdf") do 
  text "Door Decs"
  
  # Iterate over every room.
  rooms.each do |r|
    start_new_page

    room = r[0]
    names = r[1]
    names = names.sort
    
    # Room Number
    move_up 20
    font "./Univers LT 49 Light Ultra Condensed.ttf"
    text room, :size => 375, :align => :left
    move_up 30
    
    # Building
move_down 109
    font './UniversLTStd-BoldCn.ttf'
    text "Keaton's Room", :size => 24
    move_down 10
    # Top Line
    move_down 30
    stroke do
      rectangle [0,y], 500, 1
    end
    
    # Lines
    move_up 20
    image './lines.png', :position => :left, :height => 40
    move_down 20
    
    # Resident Names
    names.each do |name|
      text name.upcase, :size => 24
    end
    
    # Middle Line
    move_down 50
    stroke do
      rectangle [0,y], 500, 1
    end
    
    # Icons
    #move_down 50
    move_up 30
    image './icons.png', :position => :left, :height => 100
    
    # Aperature Logo
    move_down 80
    image './aperature_labs.png', :position => :left, :height => 30
  end
end