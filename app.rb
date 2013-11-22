def freqs(array)
	array.inject({}) do |obj, item|
		obj[item] ||= 0
		obj[item] += 1
		obj
	end
end

def sort_by_val(array)
	array.sort_by do |k, v| 
		-v
	end
end

def output_k_v(array)
	array.map do |k, v|
		"#{v}\t#{k}"
	end
end

def make_ngrams(words, ngrams=1)
	puts "make_ngrams for #{words.count} words, #{ngrams}-grams"
	words.each_with_index.map do |word, word_index|
		(0..(ngrams-1)).to_a.map do |ngram_offset| 
			words[word_index+ngram_offset]
		end.join(" ")
	end
end

text = Dir.glob('./text/*.txt').map{ |file| File.open(file).read }.join(" ")
words = text.split(" ").map{|word| word.downcase.strip}

(1..5).to_a.each do |ngram|
	puts "opening ./output/#{ngram}-gram.tsv"
	File.open("./output/#{ngram}-gram.tsv", 'w') do |f|
		output_k_v( sort_by_val( freqs( make_ngrams(words, ngram)) ) ).each{ |line| f.puts line }
	end
end