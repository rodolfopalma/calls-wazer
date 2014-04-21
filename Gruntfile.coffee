module.exports = (grunt) ->
	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-jade'
	grunt.loadNpmTasks 'grunt-contrib-stylus'
	grunt.loadNpmTasks 'grunt-run'
	grunt.loadNpmTasks 'grunt-contrib-watch'
	grunt.loadNpmTasks 'grunt-concurrent'
	grunt.loadNpmTasks 'grunt-contrib-clean'
	grunt.loadNpmTasks 'grunt-contrib-copy'

	grunt.initConfig

		# Run tasks
		concurrent:
			dev: ['watch', 'run:server'],
			options: {
				logConcurrentOutput: true
			}

		watch:
			coffee:
				files: 'src/coffee/*.coffee'
				tasks: ['coffee:compile']
			jade:
				files: 'src/jade/*.jade'
				tasks: ['jade:compile']
			stylus:
				files: 'src/stylus/*.styl'
				tasks: ['stylus:compile']
			options:
				livereload: true
		
		coffee:
			compile:
				expand: true
				flatten: true
				src: '<%= watch.coffee.files %>'
				dest: 'public/js'
				ext: '.js'

		jade:
			compile:
				expand: true
				flatten: true
				src: '<%= watch.jade.files %>'
				dest: 'public'
				ext: '.html'

		stylus:
			compile:
				expand: true
				flatten: true
				src: '<%= watch.stylus.files %>'
				dest: 'public/css'
				ext: '.css'

		run:
			server:
				cmd: 'node'
				args: ['server.js']

		copy:
			src:
				files: [
					{expand: true, flatten: true, src: 'src/assets/css/*', dest: 'public/css/'},
					{expand: true, flatten: true, src: 'src/assets/js/*', dest: 'public/js/'},
					{expand: true, flatten: true, src: 'src/assets/i/*', dest: 'public/i/'}					
				]

		# Clean tasks
		clean: 
			public: 'public'



	grunt.registerTask('default', ['coffee:compile', 'jade:compile', 'stylus:compile', 'copy:src', 'concurrent:dev'])
	grunt.registerTask('delete', ['clean:public'])