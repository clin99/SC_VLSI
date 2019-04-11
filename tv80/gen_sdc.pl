use strict;
use warnings;
use Regexp::Common;
use Scalar::Util::Numeric qw(isfloat);


for(my $i=1; $i <= 1024; $i++) {
  my $filename = './tv80.sdc';
  open(my $fh, '<:encoding(UTF-8)', $filename)
    or die "Could not open file '$filename' $!";
  
  my $ofh_name = "./sdcs/sdc_$i";

  open(my $ofh, '>', $ofh_name);
  
  while (my $row = <$fh>) {
    chomp $row;

    if(index($row, "set_input_delay") != -1) {
      my $delay = int (rand 500) + -250;
      my @array = split ' ', $row;
      $array[1] = $delay;
      for my $e(@array) {
        print $ofh "$e ";
      }
      print $ofh "\n";
      
      #my $new_line = $row;
      #$new_line =~ s/50/$i/g;
      #print $ofh "$new_line\n";
    }
    else {
      print $ofh "$row\n";
    }
  }
  
  close $ofh;
  close $fh;
}
