#
# http://georgi.github.io/audite/
# http://www.instructables.com/id/Simple-Arduino-and-HC-SR04-Example/ # sensor diagram 
#
require 'audite'
require 'bundler/setup'
require 'dino'


class Turaco
    def initialize()
        @board = Dino::Board.new(Dino::TxRx::Serial.new)
        @component = Dino::Components::Led.new(pin: 13, board: @board)
        @player = Audite.new
        @tracks = ['never-gonna-give-you-up.mp3', 'davidhasselhofflookingforfreedom.mp3']
    end

    def process

        [:on, :off].cycle do |switch|
            @component.send(switch)
            delay = play_track switch
            sleep delay
        end

    end

    def load_mp3(mp3)
        @player.load(mp3)
    end

    def play_track(switch)

        puts switch
        
        if switch == :on 
            load_mp3 @tracks.sample
            @player.start_stream 
            return Random.rand(15..45)
        else
            @player.stop_stream
            return Random.rand(5..25)
        end
    end
end



tt = Turaco.new

tt.process
