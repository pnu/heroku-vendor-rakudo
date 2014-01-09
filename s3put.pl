#!/usr/bin/env perl
use warnings;
use strict;
use Net::Amazon::S3;

my $s3 = Net::Amazon::S3->new({
    aws_access_key_id => $ENV{AWS_ACCESS_KEY_ID},
    aws_secret_access_key => $ENV{AWS_SECRET_ACCESS_KEY},
    retry => 1
});

my $filename = $ARGV[0];
my $data = `cat $filename`;

$s3->bucket($ENV{S3_BUCKET_NAME})->add_key( $filename, $data, {
    content_type => 'application/octet-stream',
    acl_short => 'public-read', retry => 1,
}) or die $s3->err . ": " . $s3->errstr . "\n";

print "https://".$ENV{S3_BUCKET_NAME}.".s3.amazonaws.com/$filename\n";
