//
//  Playlist.swift
//  Playlist
//
//  Created by James Pacheco on 5/4/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

class Playlist: Equatable {
    private static let NameKey = "name"
    private static let SongsKey = "songs"
	
    init(name: String, songs: [Song] = []) {
        self.name = name
        self.songs = songs
    }
	
	// MARK: Dictionary Conversion
    
    convenience init?(dictionary: [String: AnyObject]) {
        guard let name = dictionary[Playlist.NameKey] as? String,
            songDictionaries = dictionary[Playlist.SongsKey] as? [[String: AnyObject]] else { return nil }
		
		let songs = songDictionaries.flatMap { Song(dictionary: $0) }
		
		self.init(name: name, songs: songs)
    }
	
	var dictionaryRepresentation: [String: AnyObject] {
		let songDictionaries = songs.map { $0.dictionaryRepresentation }
		return [Playlist.NameKey: name, Playlist.SongsKey: songDictionaries]
	}
	
	// MARK: Properties
	
	let name: String
	var songs: [Song]
}

func ==(lhs: Playlist, rhs: Playlist) -> Bool {
    return lhs.name == rhs.name && lhs.songs == rhs.songs
}