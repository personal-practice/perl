#!/usr/bin/perl
use strict;
use warnings;
sub say {print @_, "\n"}

say "======================================";
say "Arrays";
say "======================================";

# Declaration
my @array = (
	"print",
	"these",
	"strings",
	"out",
	"for",
	"me", # trailing comma is okay
);

# Array length
say "Array's length is ".(scalar @array)."";
say "Last populated index is ".$#array;

# Array iteration
foreach my $str (@array) {
	say $str;
}
foreach my $i (0 .. $#array) {
	say $i, ": ", $array[$i];
}
say $_ foreach (@ array);

# Array print
say "@array";
say '@array';

# Array concatenation
my @bones = ("humerus", ("jaw", "skull"), "tibia");
my @fingers = ("thumb", "index", "middle", "ring", "little");
my @parts = (@bones, @fingers, ("foot", "toes"), "eyeball", "knuckle");
say "@parts";

say "======================================";
say "Hashes";
say "======================================";

# Declaration
my %scientists = (
	"Newton" => "Isaac",
	"Einstein" => "Albert",
	"Darwin" => "Charles"
);

# Conversion to array
my @scientistsAsArray = %scientists;

# Hash iteration
foreach my $key (sort keys %scientists) {
	say $key, " => ", $scientists{$key};
}
foreach (sort keys %scientists) {
	say $_, " => ", $scientists{$_};
}


say "======================================";
say "Contexts";
say "======================================";

# List context
say reverse "hello world";
say scalar reverse "hello world";
# Scalar context
my $var = reverse "hello world";
say $var; 

say "======================================";
say "References";
say "======================================";

# Simple
my $color = "Indigo";
my $ref = \$color;

say $color;
say ${$ref};
say $$ref;

# Complicated
my @colors = ("Red", "Orange", "Green", "Yellow", "Blue");
my $arrayRef = \@colors;

say $colors[0], " ", ${$arrayRef}[0], " ", $arrayRef->[0];

say "======================================";
say "Data Structures";
say "======================================";

# Straight forward
my %owner1 = (
	"name" => "Santa Claus",
	"DOB" => "1882-12-25"
);
my %owner2 = (
	"name" => "Mickey Mouse",
	"DOB" => "1928-11-18"
);
my @owners = (\%owner1, \%owner2);
my %account = (
	"number" => "16024099",
	"opened" => "2001-12-3",
	"owners" => \@owners
);

# Anonymous arrays/hashes
my $owner1Ref = {
	"name" => "Santa Claus",
	"DOB" => "1882-12-25"
};
my $owner2Ref = {
	"name" => "Mickey Mouse",
	"DOB" => "1928-11-18"
};
my $ownersRef = [$owner1Ref, $owner2Ref];
my %account2 = (
	"number" => "16024099",
	"opened" => "2001-12-3",
	"owners" => $ownersRef
);

# Anonymous shorthand
my %account3 = (
	"number" => "16024099",
	"opened" => "2001-12-3",
	"owners" => [
		{
				"name" => "Santa Claus",
				"DOB" => "1882-12-25"
		},
		{
				"name" => "Mickey Mouse",
				"DOB" => "1928-11-18"		
		}
	]	
);

# Print data structure
print "Account #", $account3{"number"}, "\n";
print "Opened on ", $account3{"opened"}, "\n";
print "Joint owners:\n";
print "\t", $account3{"owners"}->[0]->{"name"}, " (born ", $account3{"owners"}->[0]->{"DOB"}, ")\n";
print "\t", $account3{"owners"}->[1]->{"name"}, " (born ", $account3{"owners"}->[1]->{"DOB"}, ")\n";

say "======================================";
say "Array Functions";
say "======================================";

my @stack = ("Fred", "Eileen", "Denise", "Charlie");
say "@stack";
# pop
say pop @stack;
say "@stack";
# push
push @stack, "Bob", "Alice";
say "@stack";
# shift
say shift @stack;
say "@stack";
# unshift
unshift @stack, "Hank", "Grace";
say "@stack";
# splice
say splice(@stack, 1, 4, "<<<", ">>>");
say "@stack";
# join, map
my @capitals = ("Baton Rouge", "Indianapolis", "Columbus", "Montgomery", "Helena", "Denver", "Boise");
say "@capitals";
say join ", ", map {uc $_} @capitals;
# grep
say join ", ", grep {length $_ == 6} @capitals;
# check if contains element
say ((scalar grep {$_ eq "Columbus"} @capitals) == 1 ? "yes" : "no");
# sort
my @numbers = (19, 1, 2, 100, 3, 98, 100, 1056);
say join ", ", sort @numbers;
say join ", ", sort {$a cmp $b} @numbers;
say join ", ", sort {$a <=> $b} @numbers;
sub comparator {
	$a <=> $b
}
say join ", ", sort comparator @numbers;

say "======================================";
say "User-defined subroutines";
say "======================================";

sub hyphenate {
	# Extract only first argument, ignore everything else
	my $word = shift @_;	
	$word = join "-", map {substr $word, $_, 1} (0 .. (length $word) - 1);
	return $word
}
say hyphenate("exterminate");

say "======================================";
say "Unpacking arguments";
say "======================================";

sub left_pad1 {
	my $oldStr = $_[0];
	my $width = $_[1];
	my $pad = $_[2];
	
	my $newStr = ($pad x ($width - length $oldStr)).$oldStr;
	return $newStr;	
}
sub left_pad2 {
	my $oldStr = shift;
	my $width = shift;
	my $pad = shift;
	
	my $newStr = ($pad x ($width - length $oldStr)).$oldStr;
	return $newStr;	
}
sub left_pad3 {
	my ($oldStr, $width, $pad) = @_;		
	my $newStr = ($pad x ($width - length $oldStr)).$oldStr;
	return $newStr;	
}
sub left_pad4 {
	my %args = @_;		
	my $newStr = ($args{"pad"} x ($args{"width"} - length $args{"oldStr"})).$args{"oldStr"};
	return $newStr;	
}
say left_pad1("hello", 10, "+");
say left_pad2("hello", 10, "+");
say left_pad3("hello", 10, "+");
say left_pad4("oldStr" => "hello", "width" => 10, "pad" => "+");

say "======================================";
say "Contextual bahaviour of return values";
say "======================================";

sub context {
	return ("Everest", "K2", "Etna") if wantarray;
	return 3;
};
my @arr = context();
say "@arr";
my $val = context();
say $val;

say "======================================";
say "File I/O";
say "======================================";

my $f = "text.txt";
# Read from file
open(my $fh1, "<", $f) || die "Couldn't open '".$f."' for reading because: ".$!;
while (1) {
	my $line = readline $fh1;
	last unless defined $line;
	chomp $line;
	say $line;
}
open(my $fh2, "<", $f) || die "Couldn't open '".$f."' for reading because: ".$!;
while (!eof $fh2) {
	my $line = readline $fh2;
	chomp $line;
	say $line;
}
open(my $fh3, "<", $f) || die "Couldn't open '".$f."' for reading because: ".$!;
while (my $line = <$fh3>) {
	chomp $line;
	say $line;
}
open(my $fh4, "<", $f) || die "Couldn't open '".$f."' for reading because: ".$!;
while (<$fh4>) {
	chomp $_;
	say $_;
}

#<STDIN>;	# Waits for user to press 'Enter'

# Write to file
#open(m'y $fh, ">>", $f) || die "Couldn't open '".$f."' for writing because: ".$!;
#print $fh "The eagles have left the nest";
#close $fh;

say "======================================";
say "Regular Expressions";
say "======================================";

# m//
my $str1 = "Hello world";
if($str1 =~ m/(\w+)\s+(\w+)/) {
	say "success";
}
say join ", ", $1, $2;

my $str2 = "colourless green ideas sleep furiously";
my @matches = $str2 =~ m/(\w+)\s+((\w+)\s+(\w+))\s+(\w+)\s+(\w+)/;
say join ", ", map { "'".$_."'" } @matches;

# s///
my $str3 = "Good morning world";
$str3 =~ s/world/Vietnam/;
say $str3;

# m//g
my $str4 = "a tonne of feathers or a tonne of bricks";
while($str4 =~ m/(\w+)/g) {
  print "'".$1."'\n";
} 

# s///g
$str4 =~ s/[aeiou]/%/g;
say $str4;

# /x
"Hello world" =~ m/
  (\w+) # one or more word characters
  [ ]   # single literal space, stored inside a character class
  world # literal "world"
/x;