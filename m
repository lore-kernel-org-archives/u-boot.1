Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB6C3C52D7C
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 18:22:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F44C889B8;
	Fri,  9 Aug 2024 20:22:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Dru/6VsR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B03788A6B; Fri,  9 Aug 2024 20:22:45 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02642887EB
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 20:22:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 604334239F
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 18:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1723227762;
 bh=xXe2lYeMixBIAx1ws7ZNfOuU2t6lmk8URoLrJVs6Zg4=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Dru/6VsRclSObexzmMqUwj4VVB1E2JtRlosgY3SFEp4U5CjanQHUzFlfdzY5ir3Te
 2+DLtflYjDhdRHfWEN6o1m50oBoUc0Fh3ecmACmmJjnBi+VQl+ElRh5vMcBqG6AJP7
 u6muCdgYCd74f+qsY/VS+F29DNZ7yDG+BvkSlGTnjROtNNnhq5iw9asDg55NSJZTC7
 iPQ+2g9M3l0J2R710eECsl8D2VcnPa2K5mk1mvrdwMgejQ32laePnQKoQ1m3CVwwjw
 Gc95UrGq5eh7Zvfs8fnh1BP3cZhGQiqdtG9SMFmqoosFxWJqNFe2/H1vujABqT0ZU/
 op7pyGOObQcnA==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-367962f0cb0so1238404f8f.1
 for <u-boot@lists.denx.de>; Fri, 09 Aug 2024 11:22:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723227762; x=1723832562;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xXe2lYeMixBIAx1ws7ZNfOuU2t6lmk8URoLrJVs6Zg4=;
 b=w35mevoEtWj05O3NrEZcnMHiNavt6oM9cI89OIGNJJY2LWYT44RIN5dcUGepHyY6Ml
 sw3lIF4BI6CgzeeaVmTDG3MjrQ+NNW3P+F/npmMmeRBvChYEReSOXn/FG0KENxKfP09e
 EhVn19V3ddHriyfup2uwDSxfiKbCWzLrcg39QH3GmPrn9QlMORWz79v7AHJUXhtInzPF
 9/eova1ZGNRqsuvvXifgIduS7oKipmiIjV6co2DzMHlPyYHnG/oa424rHymXaIbwZnjI
 q/kASMkd9fxAk0c1uOB3cWf9IbztioVE3j16S9kcIlbhEts/p+g9L0uM4Z611MvhKhVQ
 atTA==
X-Gm-Message-State: AOJu0YxcziBB3PrsboqadDSp7ekmqKH6P3iQQa3JtUX1LK8CNYYxT0vn
 /GwoGu+GB3m7Zb1jP2SqqpxIqNeAPbdJFkdPYoajLBNDqMrirx5qoQjinESu/lRH3/Mlhvrk2pc
 SulWnOYhHsuEgNzhd0Z6YxEN9uYqpLS2BG4p2KpFC+V9tdr3Y2G9C86np4/OwQkf1G1bz1HXDte
 Y=
X-Received: by 2002:adf:f60d:0:b0:368:6650:fd16 with SMTP id
 ffacd0b85a97d-36d5fd7fa27mr1923230f8f.38.1723227761647; 
 Fri, 09 Aug 2024 11:22:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTvUb9YWkHSlZQ7TpgcdtJdBcopFuDJOgh359pJwiLb6QZZkK4fVmaxp8hrtHl1DfbFF4b4w==
X-Received: by 2002:adf:f60d:0:b0:368:6650:fd16 with SMTP id
 ffacd0b85a97d-36d5fd7fa27mr1923209f8f.38.1723227760957; 
 Fri, 09 Aug 2024 11:22:40 -0700 (PDT)
Received: from localhost.localdomain
 (ip-178-202-041-098.um47.pools.vodafone-ip.de. [178.202.41.98])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4c36b9d2sm162923f8f.9.2024.08.09.11.22.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2024 11:22:40 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] scripts/decodecode: update from Linux v6.10
Date: Fri,  9 Aug 2024 20:22:33 +0200
Message-ID: <20240809182233.194057-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

For decoding RISC-V dumps we need to update the script.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 scripts/decodecode | 169 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 148 insertions(+), 21 deletions(-)

diff --git a/scripts/decodecode b/scripts/decodecode
index 9cef558528..6364218b21 100755
--- a/scripts/decodecode
+++ b/scripts/decodecode
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 # Disassemble the Code: line in Linux oopses
 # usage: decodecode < oops.file
@@ -6,6 +6,9 @@
 # options: set env. variable AFLAGS=options to pass options to "as";
 # e.g., to decode an i386 oops on an x86_64 system, use:
 # AFLAGS=--32 decodecode < 386.oops
+# PC=hex - the PC (program counter) the oops points to
+
+faultlinenum=1
 
 cleanup() {
 	rm -f $T $T.s $T.o $T.oo $T.aa $T.dis
@@ -60,15 +63,27 @@ case $width in
 4) type=4byte ;;
 esac
 
+if [ -z "$ARCH" ]; then
+    case `uname -m` in
+	aarch64*) ARCH=arm64 ;;
+	arm*) ARCH=arm ;;
+	loongarch*) ARCH=loongarch ;;
+    esac
+fi
+
+# Params: (tmp_file, pc_sub)
 disas() {
-	${CROSS_COMPILE}as $AFLAGS -o $1.o $1.s > /dev/null 2>&1
+	t=$1
+	pc_sub=$2
+
+	${CROSS_COMPILE}as $AFLAGS -o $t.o $t.s > /dev/null 2>&1
 
 	if [ "$ARCH" = "arm" ]; then
 		if [ $width -eq 2 ]; then
 			OBJDUMPFLAGS="-M force-thumb"
 		fi
 
-		${CROSS_COMPILE}strip $1.o
+		${CROSS_COMPILE}strip $t.o
 	fi
 
 	if [ "$ARCH" = "arm64" ]; then
@@ -76,11 +91,120 @@ disas() {
 			type=inst
 		fi
 
-		${CROSS_COMPILE}strip $1.o
+		${CROSS_COMPILE}strip $t.o
+	fi
+
+	if [ "$ARCH" = "riscv" ]; then
+		OBJDUMPFLAGS="-M no-aliases --section=.text -D"
+		${CROSS_COMPILE}strip $t.o
+	fi
+
+	if [ "$ARCH" = "loongarch" ]; then
+		${CROSS_COMPILE}strip $t.o
+	fi
+
+	if [ $pc_sub -ne 0 ]; then
+		if [ $PC ]; then
+			adj_vma=$(( $PC - $pc_sub ))
+			OBJDUMPFLAGS="$OBJDUMPFLAGS --adjust-vma=$adj_vma"
+		fi
 	fi
 
-	${CROSS_COMPILE}objdump $OBJDUMPFLAGS -S $1.o | \
-		grep -v "/tmp\|Disassembly\|\.text\|^$" > $1.dis 2>&1
+	${CROSS_COMPILE}objdump $OBJDUMPFLAGS -S $t.o | \
+		grep -v "/tmp\|Disassembly\|\.text\|^$" > $t.dis 2>&1
+}
+
+# Match the maximum number of opcode bytes from @op_bytes contained within
+# @opline
+#
+# Params:
+# @op_bytes: The string of bytes from the Code: line
+# @opline: The disassembled line coming from objdump
+#
+# Returns:
+# The max number of opcode bytes from the beginning of @op_bytes which match
+# the opcode bytes in the objdump line.
+get_substr_opcode_bytes_num()
+{
+	local op_bytes=$1
+	local opline=$2
+
+	local retval=0
+	substr=""
+
+	for opc in $op_bytes;
+	do
+		substr+="$opc"
+
+		opcode="$substr"
+		if [ "$ARCH" = "riscv" ]; then
+			opcode=$(echo $opcode | tr ' ' '\n' | tac | tr -d '\n')
+		fi
+
+		# return if opcode bytes do not match @opline anymore
+		if ! echo $opline | grep -q "$opcode";
+		then
+			break
+		fi
+
+		# add trailing space
+		substr+=" "
+		retval=$((retval+1))
+	done
+
+	return $retval
+}
+
+# Return the line number in objdump output to where the IP marker in the Code:
+# line points to
+#
+# Params:
+# @all_code: code in bytes without the marker
+# @dis_file: disassembled file
+# @ip_byte: The byte to which the IP points to
+get_faultlinenum()
+{
+	local all_code="$1"
+	local dis_file="$2"
+
+	# num bytes including IP byte
+	local num_bytes_ip=$(( $3 + 1 * $width ))
+
+	# Add the two header lines (we're counting from 1).
+	local retval=3
+
+	# remove marker
+	all_code=$(echo $all_code | sed -e 's/[<>()]//g')
+
+	while read line
+	do
+		get_substr_opcode_bytes_num "$all_code" "$line"
+		ate_opcodes=$?
+
+		if ! (( $ate_opcodes )); then
+			continue
+		fi
+
+		num_bytes_ip=$((num_bytes_ip - ($ate_opcodes * $width) ))
+		if (( $num_bytes_ip <= 0 )); then
+			break
+		fi
+
+		# Delete matched opcode bytes from all_code. For that, compute
+		# how many chars those opcodes are represented by and include
+		# trailing space.
+		#
+		# a byte is 2 chars, ate_opcodes is also the number of trailing
+		# spaces
+		del_chars=$(( ($ate_opcodes * $width * 2) + $ate_opcodes ))
+
+		all_code=$(echo $all_code | sed -e "s!^.\{$del_chars\}!!")
+
+		let "retval+=1"
+
+	done < $dis_file
+
+	return $retval
 }
 
 marker=`expr index "$code" "\<"`
@@ -90,36 +214,39 @@ fi
 
 touch $T.oo
 if [ $marker -ne 0 ]; then
+	# How many bytes to subtract from the program counter
+	# in order to get to the beginning virtual address of the
+	# Code:
+	pc_sub=$(( (($marker - 1) / (2 * $width + 1)) * $width ))
 	echo All code >> $T.oo
 	echo ======== >> $T.oo
 	beforemark=`echo "$code"`
 	echo -n "	.$type 0x" > $T.s
+
 	echo $beforemark | sed -e 's/ /,0x/g; s/[<>()]//g' >> $T.s
-	disas $T
+
+	disas $T $pc_sub
+
 	cat $T.dis >> $T.oo
-	rm -f $T.o $T.s $T.dis
 
-# and fix code at-and-after marker
+	get_faultlinenum "$code" "$T.dis" $pc_sub
+	faultlinenum=$?
+
+	# and fix code at-and-after marker
 	code=`echo "$code" | cut -c$((${marker} + 1))-`
+
+	rm -f $T.o $T.s $T.dis
 fi
+
 echo Code starting with the faulting instruction  > $T.aa
 echo =========================================== >> $T.aa
-code=`echo $code | sed -e 's/ [<(]/ /;s/[>)] / /;s/ /,0x/g; s/[>)]$//'`
+code=`echo $code | sed -e 's/\r//;s/ [<(]/ /;s/[>)] / /;s/ /,0x/g; s/[>)]$//'`
 echo -n "	.$type 0x" > $T.s
 echo $code >> $T.s
-disas $T
+disas $T 0
 cat $T.dis >> $T.aa
 
-# (lines of whole $T.oo) - (lines of $T.aa, i.e. "Code starting") + 3,
-# i.e. the title + the "===..=" line (sed is counting from 1, 0 address is
-# special)
-faultlinenum=$(( $(wc -l $T.oo  | cut -d" " -f1) - \
-		 $(wc -l $T.aa  | cut -d" " -f1) + 3))
-
-faultline=`cat $T.dis | head -1 | cut -d":" -f2-`
-faultline=`echo "$faultline" | sed -e 's/\[/\\\[/g; s/\]/\\\]/g'`
-
-cat $T.oo | sed -e "${faultlinenum}s/^\(.*:\)\(.*\)/\1\*\2\t\t<-- trapping instruction/"
+cat $T.oo | sed -e "${faultlinenum}s/^\([^:]*:\)\(.*\)/\1\*\2\t\t<-- trapping instruction/"
 echo
 cat $T.aa
 cleanup
-- 
2.45.2

