#!/usr/bin/perl

#Andrew McLaughlin
#7Oct18
#Doc Processor

use strict;
use warnings;
use Cwd;
use File::Copy qw(copy);

#Enter directory to process with relative or absolute path, for current directory enter "."
print("Enter directory:");
my $newDir = <STDIN>;
chomp($newDir);

#Places all files in directory into an array
opendir(DH, $newDir) or die "Directory does not exist\n";
my @files = readdir(DH);
close DH;

#loops through every file in array
foreach my $file (@files)
{
#ignores the links to parent directory and itself
	if ($file eq "." || $file eq "..")
	{
	}
	else
	{
#Creates table with options, enter number on keypad corresponding with desired effect
		print("What do you want to do with the file '$file'?\n");
		print("Rename = 1\nCopy = 2\nDelete = 3\n");
		my $request = <STDIN>;

		if ($request == 1)
		{
			&renameFile($file) or die "Could not rename file\n";
			print("File renamed"\n");
		}
		elsif ($request == 2)
		{
			&copyFile($file) or die "Could not copy file\n";
			print("File copied\n");
		}
		elsif ($request == 3)
		{
			&deleteFile($file) or die "Could not delete file\n";
			print("File deleted\n");
		}
#Handles incorrect input by skipping file
		else
		{
			print("Next file\n");
		}
	}
}

sub renameFile
{
	my $file = $_[0];
	print("Enter new filename:");
	my $newName = <STDIN>;
	chomp($newName);
	rename("$newDir/$file", "$newDir/$newName");
}

sub copyFile
{
	my $file = $_[0];
	print("Enter new filename:");
	my $newName = <STDIN>;
	chomp($newName);
	copy("$newDir/$file", "$newDir/$newName");
}

sub deleteFile
{
	my $file = $_[0];
	unlink("$newDir/$file");
}