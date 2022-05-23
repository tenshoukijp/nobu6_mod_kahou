#Explorerで表示した際に、同じ画像が並んで表示されるようにコントロールする。

use File::Compare;

use strict;

my $type = 1;
$|=1;

print "家宝のbmpをバックアップ取りましたか？";
print "家宝のファイル群がD:\\Kahouへと移動するので注意!!";
<STDIN>;

# D:\kahouディレクトリ決め打ち
if (-e "D:\\kahou") {
	# 1000個まで
	for($type=1; $type<1000; $type++) {
		my $targe = "";
		my $mtime = "";
		# bmpを読む
		while (<*.bmp>) {
			# ファイル名とファイルの更新日時をとっておく
			my $filename = $_;
			if ($targe eq "") {
				$targe = $filename;
				$mtime = (stat $filename)[9];
			}
			
			# バイナリが同じもの(=同じ画像内容")を、同じ更新日時にする。(こうすることでExplorerで見たときにグループ化されたかのように見える。
			if (-e $filename and -e $targe and ($filename ne $targe)) {
				if (compare($filename, $targe)==0) {
					utime $mtime, $mtime, $filename;

					 `move $filename D:\\kahou\\$filename`;
				}
			}
		}
		
		# 対象ファイルの更新日時を更新。
		utime $mtime, $mtime, $targe;
		`move $targe D:\\kahou\\$targe`;
	}
}