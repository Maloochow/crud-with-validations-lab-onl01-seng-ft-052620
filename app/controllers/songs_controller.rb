class SongsController < ApplicationController

    def index
        @songs = Song.all
    end

    def new
        @song = Song.new
    end

    def create
        if params[:song][:released] == "0"
        params[:song][:released] = false
        elsif params[:song][:released] == "1"
            params[:song][:released] == true
        end
        @song = Song.new(song_params)
        if @song.save
        redirect_to song_path(@song)
        else
            render :new
        end
    end

    def edit
        @song = Song.find_by_id(params[:id])
    end

    def update
        @song ||= Song.find_by_id(params[:id])
        if params[:song][:released] == "0"
            params[:song][:released] = false
        elsif params[:song][:released] == "1"
            params[:song][:released] == true
        end
        if @song.update(song_params)
        redirect_to song_path(@song)
        else
            render :edit
        end
    end

    def show
        @song ||= Song.find_by_id(params[:id])
    end

    def destroy
        @song ||= Song.find_by_id(params[:id])
        @song.destroy
        redirect_to songs_path
    end

    private

    def song_params
        params.require(:song).permit(:title, :released, :release_year, :artist_name, :genre)
    end

end