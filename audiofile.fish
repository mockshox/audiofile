function audiofile
  set arg_count (count $argv)
  if test $arg_count -gt 1
    echo "URL should be a single argument, got $arg_count"
    return 1
  else if test $arg_count -eq 1
    set url $argv[1]
  else
    read -l -P 'enter music file URL: ' url
  end
  set available_formats (youtube-dl $url -F)
  switch "$available_formats"
    case audio only wav
      echo [$_] wav available
      set best_format wav
    case '*'
      echo [$_] wav not available - falling back to mp3
      set best_format mp3
  end
    youtube-dl $url -x --audio-format $best_format
end