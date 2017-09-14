require 'singleton'

class AlphanumericRandom
  include Singleton

  BASE = [*('A'..'Z')] + [*('a'..'z')] + [*('0'..'9')]
  HUMAN_EXCULUDE = ['1', '0', 'O', 'l', 'I']
  LOWERCASE = [*('a'..'z')]
  UPPERCASE = [*('A'..'Z')]
  HUMAN = BASE - HUMAN_EXCULUDE
  LOWERCAE_ONLY = BASE - LOWERCASE
  UPPERCAE_ONLY = BASE - UPPERCASE

  def self.generate(options = {})
    options = {
      length: 8,
      unique: false,
      human: false,
      lowercase: false,
      uppercase: false,
      additional_chars: []
    }.merge!(options)

    throw 'Integer expected for length' unless options[:length].kind_of?(Fixnum)
    throw 'negative length given' unless options[:length] >= 0
    throw 'non boolean value for :unique' unless [true, false].include?(options[:unique])
    throw 'non boolean value for :human' unless [true, false].include?(options[:human])
    throw 'Array expected for :additional_chars' unless options[:additional_chars].kind_of?(Array)

    if ( options[:lowercase] )
      base_chars = LOWERCASE_ONLY
    elsif ( options[:uppercase] )
      base_chars = UPPERCASE_ONLY
    else
      base_chars = BASE
    end
    chars = options[:human] ? base_chars - HUMAN_EXCLUDE : base_chars
    chars += options[:additional_chars]
    chars = chars.uniq

    random_array = if options[:unique]
      chars.sample(options[:length])
    else
      (0..(options[:length] - 1)).map { chars.sample }
    end
    random_array.join
  end

  def self.human(options = {})
    options.merge!(human: true)
    self.generate(options)
  end

  def self.uniq(options = {})
    options.merge!(unique: true)
    self.generate(options)
  end
end
