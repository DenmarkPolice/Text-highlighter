require "colorize"

# Public: Takes variables and send them to the other functions
#
# haystack_name  - Take the first input in console.
# needle - Take the second input in console.
#
# Examples
#
#
# Print out the wanted text with the requested words/letters marked out.
def main()
  haystack_name = ARGV[0];
  needle = ARGV[1];
  haystack = read_file(haystack_name:haystack_name);
  startindex = indices(haystack:haystack, needle:needle);
  print print_highlighted_text(haystack:haystack, needle_length:needle.length, startindex:startindex);
end

# Public:
#
# text  - The String to be duplicated.
# count - The Integer number of times to duplicate the text.
# Examples
#
#   multiplex('Tom', 4)
#   # => 'TomTomTomTom'
#
# Returns the duplicated String.
def read_file(haystack_name:)
  haystack = "";
  File.open(haystack_name, "r") do |f|
    f.each_line do |line|
      haystack = line;
    end
  end
  return haystack;
end

def indices(haystack:, needle:)
  counter = 0;
  corrector = 0;
  injections = 0;
  needle_pos = [];
  haystack_array = haystack.split("");
  needle_array = needle.split("");
  if(haystack.include?(needle.capitalize) || haystack.include?(needle.downcase))
    while(counter != haystack.length)
      if(haystack_array[counter] == needle_array[corrector])
        counter += 1;
        corrector += 1;
      else
        if(corrector != 0)
          counter -= 1;
        end
        counter += 1;
        corrector = 0;
      end
      if(corrector == needle.length)
        needle_pos[injections] = counter - needle.length;
        injections += 1;
      end
    end
  end
  return needle_pos
end

def print_highlighted_text(haystack:, needle_length:, startindex:)
  haystack_array = haystack.split("");
  colorized = 0;
  printed_letters = 0;
  color_count = 0;
  while(printed_letters != haystack_array.length)
    if(printed_letters == startindex[color_count])
      while(colorized < needle_length)
        print haystack_array[printed_letters].on_yellow;
        printed_letters += 1;
        colorized += 1;
      end
      color_count += 1;
    else
      print haystack_array[printed_letters];
      printed_letters += 1;
      colorized = 0;
    end
  end
end
puts main();
