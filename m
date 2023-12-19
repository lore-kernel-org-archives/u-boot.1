Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62490C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 22:02:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CC4386FD5;
	Tue, 19 Dec 2023 23:01:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HnGDDX+h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33857874F6; Tue, 19 Dec 2023 23:01:58 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F4F886F56
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 23:01:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40c6e2a47f6so52505455e9.0
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 14:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703023315; x=1703628115; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FfYNJhkrXS60p50ANQ1xttvvqk6e8MzW9ajuGsXWQQs=;
 b=HnGDDX+hB85QRDa9yi2HxVrts3W42e6m5kJYnHd40RRXsqeYAzJwH9DnJW+JxLeoTL
 rXGF473saiB65sT3KGdHvFNCwVe42BpFK2+rEbw/xF03mlWFSvQ5TmaJ4NQpQuRLQ0IQ
 pi9vIkgbajldHHB4T6y0+IPNxr+zMaN3IQWs6QBlgYsvcbbxKK9p6cIuLjHyJO+CwXHk
 ASwurU27y+o2X/HYRPBe6qb8ekxx7Ld3beit1dqKWrVrcIZsr3daTAzDy96g7fYLbQqF
 ZI6ySZ3Mui8gsT8pKFGesbDXLdWhIWfiRubQR2EWdoGoclFAb8p2ETWGXn8NxzX+rJCz
 XXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703023315; x=1703628115;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FfYNJhkrXS60p50ANQ1xttvvqk6e8MzW9ajuGsXWQQs=;
 b=MVFs3JU4Re9UnRwDJLfhmi9XHNxm9E+KRxN52vY8KwOJm6JeIFqqm2L6QceNoCByKt
 tXdTxs4uz/pyissDMby0xVzoVPE/lmRHuQbDanQxTaJAoZ/FKD/ZfsnjqUktShUcMIZq
 dAOpbYDEQuMfVhVFGAdVeGsSLaGtLqs34fnqu2W9GKUnGhdcW2uhP9BMKlyY3uDOay1i
 wSvmNki7UUBB5s0MtgnkrLn2TntNl2UxBD8nyR2Uq8BoBXX/3CB6qs6VmnIt1BStWQ2y
 sySoO5/GhUUmVG7JCvQt3cYaF9Wmzd10rH06pCzHVaLrh/iHRKxN0h7ESyWoRWqnAeUo
 CJkQ==
X-Gm-Message-State: AOJu0YwMXMn5wS3ez8ZwjxRYHRvEL/KUdyuTA+IytnbhwflxynPY216v
 JfoMLftJqC5cZLjQH1JsVXPc0LSPiuo=
X-Google-Smtp-Source: AGHT+IEeGk8iPIT7uDNaafGw62Riq3U8kYHE9gbLIThFpYtD+KTpnXeGGoVeM8aPSqfKsZJNtJaLhg==
X-Received: by 2002:a05:600c:a08:b0:40d:1a54:fef4 with SMTP id
 z8-20020a05600c0a0800b0040d1a54fef4mr1070854wmp.95.1703023315121; 
 Tue, 19 Dec 2023 14:01:55 -0800 (PST)
Received: from morpheus.home.roving-it.com
 (2.1.9.e.d.3.3.1.6.1.e.d.5.3.a.e.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:fb11:2681:ea35:de16:133d:e912])
 by smtp.googlemail.com with ESMTPSA id
 n11-20020a05600c3b8b00b0040b3d8907fesm3917816wms.29.2023.12.19.14.01.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 14:01:54 -0800 (PST)
From: Peter Robinson <pbrobinson@gmail.com>
To: Dhruva Gole <d-gole@ti.com>,
 =?UTF-8?q?Ville=20Skytt=C3=A4?= <ville.skytta@iki.fi>, u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] test: fs: fs-test: Move the tests to use sha256sum
Date: Tue, 19 Dec 2023 22:01:50 +0000
Message-ID: <20231219220152.363833-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Move the use of md5s for recording filesystem file integrity
checks to sha256 hashes as they're preferred due to being
less likely to produce clashing hashes. In the process
generalise some of the wording to use the more generic
hash term.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 test/fs/fs-test.sh | 118 ++++++++++++++++++++++-----------------------
 1 file changed, 59 insertions(+), 59 deletions(-)

diff --git a/test/fs/fs-test.sh b/test/fs/fs-test.sh
index dec2634de37..257b50fd063 100755
--- a/test/fs/fs-test.sh
+++ b/test/fs/fs-test.sh
@@ -23,7 +23,7 @@
 # --------------------------------------------
 
 # pre-requisite binaries list.
-PREREQ_BINS="md5sum mkfs mount umount dd fallocate mkdir"
+PREREQ_BINS="sha256sum mkfs mount umount dd fallocate mkdir"
 
 # All generated output files from this test will be in $OUT_DIR
 # Hence everything is sandboxed.
@@ -44,9 +44,9 @@ SMALL_FILE="1MB.file"
 # $BIG_FILE is the name of the 2.5GB file in the file system image
 BIG_FILE="2.5GB.file"
 
-# $MD5_FILE will have the expected md5s when we do the test
+# $HASH_FILE will have the expected hashes when we do the test
 # They shall have a suffix which represents their file system (ext4/fat16/...)
-MD5_FILE="${OUT_DIR}/md5s.list"
+HASH_FILE="${OUT_DIR}/hash.list"
 
 # $OUT shall be the prefix of the test output. Their suffix will be .out
 OUT="${OUT_DIR}/fs-test"
@@ -103,7 +103,7 @@ function compile_sandbox() {
 # Clean out all generated files other than the file system images
 # We save time by not deleting and recreating the file system images
 function prepare_env() {
-	rm -f ${MD5_FILE}.* ${OUT}.*
+	rm -f ${HASH_FILE}.* ${OUT}.*
 	mkdir -p ${OUT_DIR}
 }
 
@@ -254,14 +254,14 @@ setenv filesize
 ${PREFIX}load host${SUFFIX} $addr ${FPATH}$FILE_SMALL
 printenv filesize
 # Test Case 4b - Read full 1MB of small file
-md5sum $addr \$filesize
+hash sha256 $addr \$filesize
 setenv filesize
 
 # Test Case 5a - First 1MB of big file
 ${PREFIX}load host${SUFFIX} $addr ${FPATH}$FILE_BIG $length 0x0
 printenv filesize
 # Test Case 5b - First 1MB of big file
-md5sum $addr \$filesize
+hash sha256 $addr \$filesize
 setenv filesize
 
 # fails for ext as no offset support
@@ -269,7 +269,7 @@ setenv filesize
 ${PREFIX}load host${SUFFIX} $addr ${FPATH}$FILE_BIG $length 0x9C300000
 printenv filesize
 # Test Case 6b - Last 1MB of big file
-md5sum $addr \$filesize
+hash sha256 $addr \$filesize
 setenv filesize
 
 # fails for ext as no offset support
@@ -277,7 +277,7 @@ setenv filesize
 ${PREFIX}load host${SUFFIX} $addr ${FPATH}$FILE_BIG $length 0x7FF00000
 printenv filesize
 # Test Case 7b - One from the last 1MB chunk of 2GB
-md5sum $addr \$filesize
+hash sha256 $addr \$filesize
 setenv filesize
 
 # fails for ext as no offset support
@@ -285,7 +285,7 @@ setenv filesize
 ${PREFIX}load host${SUFFIX} $addr ${FPATH}$FILE_BIG $length 0x80000000
 printenv filesize
 # Test Case 8b - One from the start 1MB chunk from 2GB
-md5sum $addr \$filesize
+hash sha256 $addr \$filesize
 setenv filesize
 
 # fails for ext as no offset support
@@ -293,7 +293,7 @@ setenv filesize
 ${PREFIX}load host${SUFFIX} $addr ${FPATH}$FILE_BIG $length 0x7FF80000
 printenv filesize
 # Test Case 9b - One 1MB chunk crossing the 2GB boundary
-md5sum $addr \$filesize
+hash sha256 $addr \$filesize
 setenv filesize
 
 # Generic failure case
@@ -309,8 +309,8 @@ ${PREFIX}load host${SUFFIX} $addr ${FPATH}$FILE_SMALL
 ${PREFIX}${WRITE} host${SUFFIX} $addr ${FPATH}$FILE_WRITE \$filesize
 mw.b $addr 00 100
 ${PREFIX}load host${SUFFIX} $addr ${FPATH}$FILE_WRITE
-# Test Case 11b - Check md5 of written to is same as the one read from
-md5sum $addr \$filesize
+# Test Case 11b - Check hash of written to is same as the one read from
+hash sha256 $addr \$filesize
 setenv filesize
 #
 
@@ -327,13 +327,13 @@ ${PREFIX}load host${SUFFIX} $addr ${FPATH}$FILE_SMALL
 ${PREFIX}${WRITE} host${SUFFIX} $addr ${FPATH}./${FILE_WRITE}2 \$filesize
 mw.b $addr 00 100
 ${PREFIX}load host${SUFFIX} $addr ${FPATH}./${FILE_WRITE}2
-# Test Case 13b - Check md5 of written to is same as the one read from
-md5sum $addr \$filesize
+# Test Case 13b - Check hash of written to is same as the one read from
+hash sha256 $addr \$filesize
 setenv filesize
 mw.b $addr 00 100
 ${PREFIX}load host${SUFFIX} $addr ${FPATH}${FILE_WRITE}2
-# Test Case 13c - Check md5 of written to is same as the one read from
-md5sum $addr \$filesize
+# Test Case 13c - Check hash of written to is same as the one read from
+ hasheshash sha256 $addr \$filesize
 setenv filesize
 #
 reset
@@ -342,7 +342,7 @@ EOF
 }
 
 # 1st argument is the name of the image file.
-# 2nd argument is the file where we generate the md5s of the files
+# 2nd argument is the file where we generate the hashes of the files
 # generated with the appropriate start and length that we use to test.
 # It creates the necessary files in the image to test.
 # $GB2p5 is the path of the big file (2.5 GB)
@@ -380,29 +380,29 @@ function create_files() {
 	sudo rm -f "${MB1}.w"
 	sudo rm -f "${MB1}.w2"
 
-	# Generate the md5sums of reads that we will test against small file
-	dd if="${MB1}" bs=1M skip=0 count=1 2> /dev/null | md5sum > "$2"
+	# Generate the hashes of reads that we will test against small file
+	dd if="${MB1}" bs=1M skip=0 count=1 2> /dev/null | sha256sum > "$2"
 
-	# Generate the md5sums of reads that we will test against big file
+	# Generate the hashes of reads that we will test against big file
 	# One from beginning of file.
 	dd if="${GB2p5}" bs=1M skip=0 count=1 \
-		2> /dev/null | md5sum >> "$2"
+		2> /dev/null | sha256sum >> "$2"
 
 	# One from end of file.
 	dd if="${GB2p5}" bs=1M skip=2499 count=1 \
-		2> /dev/null | md5sum >> "$2"
+		2> /dev/null | sha256sum >> "$2"
 
 	# One from the last 1MB chunk of 2GB
 	dd if="${GB2p5}" bs=1M skip=2047 count=1 \
-		2> /dev/null | md5sum >> "$2"
+		2> /dev/null | sha256sum >> "$2"
 
 	# One from the start 1MB chunk from 2GB
 	dd if="${GB2p5}" bs=1M skip=2048 count=1 \
-		2> /dev/null | md5sum >> "$2"
+		2> /dev/null | sha256sum >> "$2"
 
 	# One 1MB chunk crossing the 2GB boundary
 	dd if="${GB2p5}" bs=512K skip=4095 count=2 \
-		2> /dev/null | md5sum >> "$2"
+		2> /dev/null | sha256sum >> "$2"
 
 	sync
 	sudo umount "$MOUNT_DIR"
@@ -422,35 +422,35 @@ function pass_fail() {
 	fi
 }
 
-# 1st parameter is the string which leads to an md5 generation
+# 1st parameter is the string which leads to an hash generation
 # 2nd parameter is the file we grep, for that string
-# 3rd parameter is the name of the file which has md5s in it
-# 4th parameter is the line # in the md5 file that we match it against
-# This function checks if the md5 of the file in the sandbox matches
+# 3rd parameter is the name of the file which has hashes in it
+# 4th parameter is the line # in the hash file that we match against
+# This function checks if the hash of the file in the sandbox matches
 # that calculated while generating the file
 # 5th parameter is the string to print with the result
-check_md5() {
-	# md5sum in u-boot has output of form:
-	# md5 for 01000008 ... 01100007 ==> <md5>
-	# the 7th field is the actual md5
-	md5_src=`grep -A2 "$1" "$2" | grep "md5 for" | tr -d '\r'`
-	md5_src=($md5_src)
-	md5_src=${md5_src[6]}
-
-	# The md5 list, each line is of the form:
-	# - <md5>
-	# the 2nd field is the actual md5
-	md5_dst=`sed -n $4p $3`
-	md5_dst=($md5_dst)
-	md5_dst=${md5_dst[0]}
+check_hash() {
+	# hash cmd output in u-boot has output of form:
+	# sha256 for 01000008 ... 01100007 ==> <hash>
+	# the 7th field is the actual hash
+	hash_src=`grep -A2 "$1" "$2" | grep "sha256 for" | tr -d '\r'`
+	hash_src=($hash_src)
+	hash_src=${hash_src[6]}
+
+	# The hash list, each line is of the form:
+	# - <hash>
+	# the 2nd field is the actual hash
+	hash_dst=`sed -n $4p $3`
+	hash_dst=($hash_dst)
+	hash_dst=${hash_dst[0]}
 
 	# For a pass they should match.
-	[ "$md5_src" = "$md5_dst" ]
+	[ "$hash_src" = "$hash_dst" ]
 	pass_fail "$5"
 }
 
 # 1st parameter is the name of the output file to check
-# 2nd parameter is the name of the file containing the md5 expected
+# 2nd parameter is the name of the file containing the expected hash
 # 3rd parameter is the name of the small file
 # 4th parameter is the name of the big file
 # 5th paramter is the name of the written file
@@ -483,34 +483,34 @@ function check_results() {
 	# Check read full mb of 1MB.file
 	grep -A4 "Test Case 4a " "$1" | grep -q "filesize=100000"
 	pass_fail "TC4: load of $3 size"
-	check_md5 "Test Case 4b " "$1" "$2" 1 "TC4: load from $3"
+	check_hash "Test Case 4b " "$1" "$2" 1 "TC4: load from $3"
 
 	# Check first mb of 2.5GB.file
 	grep -A4 "Test Case 5a " "$1" | grep -q "filesize=100000"
 	pass_fail "TC5: load of 1st MB from $4 size"
-	check_md5 "Test Case 5b " "$1" "$2" 2 "TC5: load of 1st MB from $4"
+	check_hash "Test Case 5b " "$1" "$2" 2 "TC5: load of 1st MB from $4"
 
 	# Check last mb of 2.5GB.file
 	grep -A4 "Test Case 6a " "$1" | grep -q "filesize=100000"
 	pass_fail "TC6: load of last MB from $4 size"
-	check_md5 "Test Case 6b " "$1" "$2" 3 "TC6: load of last MB from $4"
+	check_hash "Test Case 6b " "$1" "$2" 3 "TC6: load of last MB from $4"
 
 	# Check last 1mb chunk of 2gb from 2.5GB file
 	grep -A4 "Test Case 7a " "$1" | grep -q "filesize=100000"
 	pass_fail "TC7: load of last 1mb chunk of 2GB from $4 size"
-	check_md5 "Test Case 7b " "$1" "$2" 4 \
+	check_hash "Test Case 7b " "$1" "$2" 4 \
 		"TC7: load of last 1mb chunk of 2GB from $4"
 
 	# Check first 1mb chunk after 2gb from 2.5GB file
 	grep -A4 "Test Case 8a " "$1" | grep -q "filesize=100000"
 	pass_fail "TC8: load 1st MB chunk after 2GB from $4 size"
-	check_md5 "Test Case 8b " "$1" "$2" 5 \
+	check_hash "Test Case 8b " "$1" "$2" 5 \
 		"TC8: load 1st MB chunk after 2GB from $4"
 
 	# Check 1mb chunk crossing the 2gb boundary from 2.5GB file
 	grep -A4 "Test Case 9a " "$1" | grep -q "filesize=100000"
 	pass_fail "TC9: load 1MB chunk crossing 2GB boundary from $4 size"
-	check_md5 "Test Case 9b " "$1" "$2" 6 \
+	check_hash "Test Case 9b " "$1" "$2" 6 \
 		"TC9: load 1MB chunk crossing 2GB boundary from $4"
 
 	# Check 2mb chunk from the last 1MB of 2.5GB file loads 1MB
@@ -520,7 +520,7 @@ function check_results() {
 	# Check 1mb chunk write
 	grep -A2 "Test Case 11a " "$1" | grep -q '1048576 bytes written'
 	pass_fail "TC11: 1MB write to $3.w - write succeeded"
-	check_md5 "Test Case 11b " "$1" "$2" 1 \
+	check_hash "Test Case 11b " "$1" "$2" 1 \
 		"TC11: 1MB write to $3.w - content verified"
 
 	# Check lookup of 'dot' directory
@@ -530,9 +530,9 @@ function check_results() {
 	# Check directory traversal
 	grep -A2 "Test Case 13a " "$1" | grep -q '1048576 bytes written'
 	pass_fail "TC13: 1MB write to ./$3.w2 - write succeeded"
-	check_md5 "Test Case 13b " "$1" "$2" 1 \
+	check_hash "Test Case 13b " "$1" "$2" 1 \
 		"TC13: 1MB read from ./$3.w2 - content verified"
-	check_md5 "Test Case 13c " "$1" "$2" 1 \
+	check_hash "Test Case 13c " "$1" "$2" 1 \
 		"TC13: 1MB read from $3.w2 - content verified"
 
 	echo "** End $1"
@@ -543,7 +543,7 @@ function check_results() {
 # be performed.
 function test_fs_nonfs() {
 	echo "Creating files in $fs image if not already present."
-	create_files $IMAGE $MD5_FILE_FS
+	create_files $IMAGE $HASH_FILE_FS
 
 	OUT_FILE="${OUT}.$1.${fs}.out"
 	test_image $IMAGE $fs $SMALL_FILE $BIG_FILE $1 "" \
@@ -552,7 +552,7 @@ function test_fs_nonfs() {
 	grep -v -e "File System is consistent\|update journal finished" \
 		-e "reading .*\.file\|writing .*\.file.w" \
 		< ${OUT_FILE} > ${OUT_FILE}_clean
-	check_results ${OUT_FILE}_clean $MD5_FILE_FS $SMALL_FILE \
+	check_results ${OUT_FILE}_clean $HASH_FILE_FS $SMALL_FILE \
 		$BIG_FILE
 	TOTAL_FAIL=$((TOTAL_FAIL + FAIL))
 	TOTAL_PASS=$((TOTAL_PASS + PASS))
@@ -580,12 +580,12 @@ for fs in ext4 fat16 fat32; do
 
 	echo "Creating $fs image if not already present."
 	IMAGE=${IMG}.${fs}.img
-	MD5_FILE_FS="${MD5_FILE}.${fs}"
+	HASH_FILE_FS="${HASH_FILE}.${fs}"
 	create_image $IMAGE $fs
 
 	# host commands test
 	echo "Creating files in $fs image if not already present."
-	create_files $IMAGE $MD5_FILE_FS
+	create_files $IMAGE $HASH_FILE_FS
 
 	# Lets mount the image and test host hostfs commands
 	mkdir -p "$MOUNT_DIR"
@@ -606,7 +606,7 @@ for fs in ext4 fat16 fat32; do
 	sudo umount "$MOUNT_DIR"
 	rmdir "$MOUNT_DIR"
 
-	check_results $OUT_FILE $MD5_FILE_FS $SMALL_FILE $BIG_FILE
+	check_results $OUT_FILE $HASH_FILE_FS $SMALL_FILE $BIG_FILE
 	TOTAL_FAIL=$((TOTAL_FAIL + FAIL))
 	TOTAL_PASS=$((TOTAL_PASS + PASS))
 	echo "Summary: PASS: $PASS FAIL: $FAIL"
-- 
2.43.0

