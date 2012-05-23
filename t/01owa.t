#!/usr/bin/env perl

use strict;

use Test::More tests => 9;
use Test::Recent qw(occured_within_ago);
use Test::MockTime qw(set_absolute_time);

ok(defined &occured_within_ago, "exported");

# now is not now
my $now = DateTimeX::Easy->parse('2012-05-23T10:36:30Z');

# manually set the clock
$Test::Recent::OverridedNowForTesting =  $now;

my $ten = DateTime::Duration->new( seconds => 10 );
ok occured_within_ago($now, $ten), "DateTime now";
ok !occured_within_ago($now + DateTime::Duration->new( seconds => 1), $ten), "future";
ok occured_within_ago($now + DateTime::Duration->new( seconds => -1), $ten), "past";
ok !occured_within_ago($now + DateTime::Duration->new( seconds => -11), $ten), "too past";

ok occured_within_ago('2012-05-23T10:36:30Z', "10s"), "now";
ok !occured_within_ago('2012-05-23T10:36:31Z', "10s"), "future";
ok occured_within_ago('2012-05-23T10:36:29Z', "10s"), "past";
ok !occured_within_ago('2012-05-23T10:36:19Z', "10s"), "too past";


