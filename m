Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB03EC02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 14:37:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1ED34805E7;
	Wed,  5 Feb 2025 15:37:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1738766222;
	bh=5A+EVT9tEm9Ca6UCKNtTEfcoELfBMccvpFIn0ZGqzz0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SLC+3kh2IJMdMLsqD6GBEWXVomW3+KXLlrP/RTRfTQaSNKBDeBROsBGKkq2nL1wh7
	 +FoGHB+D40LQbPUordX/skBy3W+3U4uzNZCJAgfBLtYWsW3wOn2wPOMRArAaValaCm
	 GXmd7Of8zW7mGSdTN9nr3CdN+18heFRNXsNOaRGxwSYY3CEIsgtecHxI+c7zSJspQ9
	 ii8mWnAILcWATVhMCf8zFfLfovwE4hntQvsNYgbtYEDh7ZH8ZUXUkBY9/2+547hUbI
	 7oXbiCCX4KW0DEIGQQFLVOu0EyzNVrkUln233Pd0VG52x1bND2+W5Ow6wqCtbnshd3
	 y1GWc40AUhJjw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0DDA806FE; Wed,  5 Feb 2025 15:37:01 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D78480562
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 15:36:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="emWRojhH"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2D2241038193F; Wed,  5 Feb 2025 15:36:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1738766218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=5A+EVT9tEm9Ca6UCKNtTEfcoELfBMccvpFIn0ZGqzz0=;
 b=emWRojhH6rWsxE7LnsAsipN007Q9IXE44v69nkArNEWFVBenmeVEJ6TDpytJGdvWm1Dlol
 Lere37Ft9GrMDAE2Y2x2F5ucJLCX7ysd7NHuxNOafmDweHUnpAZfv4PoFEPffoJDwZOvnN
 8skjXGxe5mkqdAiftPQVFz5HEHLLEMCoaUPPPPys6o8abEX6uz8gJxMMtS+zQ2bpIp2F7N
 Fh1aw+2w1LWLaVB7iIz+uxZW4K5o4OItp7jNRajP59yh2FzV8w7RKVZmiAyl5OqlJszVbA
 NFk4myMyVhZVYKH3ZROmgWwqAOHtg2zwWBYwQ1zcAJeazgDtjA0R1yBU0YJeVw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Joe Hershberger <joe.hershberger@ni.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] tools: mkenvimage: Add pure shell implementation of mkenvimage
Date: Wed,  5 Feb 2025 15:35:52 +0100
Message-ID: <20250205143641.65430-1-marex@denx.de>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Add implementation of mkenvimage written purely in bourne shell.

This is not a replacement for mkenvimage tool, but rather a simple
implementation which can be used in environments where mkenvimage
itself cannot be deployed due to various constraints, like hardware
manufacturing plants, but where bourne shell and basic tool are
already available.

The external dependencies which are not shell built-ins are gzip
and grep.

All mkenvimage parameters are implemented and compatible with the
C implementation of mkenvimage.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Tom Rini <trini@konsulko.com>
---
 tools/mkenvimage.sh | 126 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)
 create mode 100755 tools/mkenvimage.sh

diff --git a/tools/mkenvimage.sh b/tools/mkenvimage.sh
new file mode 100755
index 00000000000..f83fac92e5d
--- /dev/null
+++ b/tools/mkenvimage.sh
@@ -0,0 +1,126 @@
+#!/bin/sh
+
+print_help() {
+	echo "mkenvimage [-h] [-V] [-r] [-b] [-p <byte>] -s <environment partition size> -o <output> <input file>"
+	echo ""
+	echo "This tool takes a key=value input file (same as would a \`printenv' show) and generates the corresponding environment image, ready to be flashed."
+	echo ""
+	echo "        The input file is in format:"
+	echo "                key1=value1"
+	echo "                key2=value2"
+	echo "                ..."
+	echo "        Empty lines are skipped, and lines with a # in the first"
+	echo "        column are treated as comments (also skipped)."
+	echo "        -r : the environment has multiple copies in flash"
+	echo "        -b : the target is big endian (default is little endian)"
+	echo "        -p <byte> : fill the image with <byte> bytes instead of 0xff bytes"
+	echo "        -V : print version information and exit"
+	echo ""
+	echo 'If the input file is "-", data is read from standard input'
+}
+
+INFILE=""
+OUTFILE=""
+
+REDUNDANT=0
+BIGENDIAN=0
+BYTEFILL=$(printf '\377')
+SIZE=0
+
+while getopts "hrbp:s:o:V" opt ; do
+	case "$opt" in
+	r)
+		REDUNDANT=1
+		;;
+	b)
+		# Swap CRC endianness
+		BIGENDIAN=1
+		;;
+	p)
+		BYTEFILL="$(printf "%b" "\0$(printf "%o" $((OPTARG)))")"
+		;;
+	s)
+		SIZE="$((OPTARG))"
+		;;
+	o)
+		OUTFILE="${OPTARG}"
+		;;
+	V)
+		echo "mkenvimage version SHELL"
+		exit 0
+		;;
+	h|*)
+		print_help
+		exit 0
+		;;
+	esac
+done
+
+shift $((OPTIND - 1))
+if test -n "${1}" ; then
+	INFILE=${1}
+fi
+
+if test -z "${INFILE}" ; then
+	echo "Input file not specified"
+	print_help
+	exit 1
+fi
+
+if test -z "${OUTFILE}" ; then
+	echo "Output file not specified"
+	print_help
+	exit 1
+fi
+
+if test "${SIZE}" -eq 0 ; then
+	echo "Size not specified"
+	print_help
+	exit 1
+fi
+
+crctmpfile=$(mktemp)
+outtmpfile=$(mktemp)
+
+(
+# Read input environment file, make sure there is a trailing newline,
+# sort the result and remove empty and commented out lines.
+( cat "${INFILE}" ; echo ) | sort -u "${INFILE}" | grep -v '^#' | grep -v '^[ \t]*$' | tr '\n' '\0'
+# Insert one more trailing zero at the end of environment.
+printf '\0'
+# Fill the rest of the environment with BYTEFILL bytes.
+tr '\0' "${BYTEFILL}" < /dev/zero
+# Clip the environment block to correct size. Header is 4 bytes CRC32
+# for regular environment and 5 bytes CRC32 and flags for redundant
+# environment.
+) | dd count="$((SIZE - 4 - REDUNDANT))" bs=1 of="${outtmpfile}" 2>/dev/null
+
+gzip -ck1 "${outtmpfile}" | tail -c8 | head -c4 > "${crctmpfile}"
+
+# Reverse crc32 for big-endian systems
+if test "$BIGENDIAN" -eq 1 ; then
+	# Note that 'rev' is from util-linux and may not be available,
+	# 'xxd' is from vim and may not be available, and 'tac -rs .'
+	# does not handle unterminated strings and newlines well, so
+	# use plain 'dd' to reverse the 4 bytes reliably and using
+	# minimum dependencies:
+	crcbetmpfile=$(mktemp)
+	(
+		dd if="${crctmpfile}" bs=1 count=1 skip=3 ;
+		dd if="${crctmpfile}" bs=1 count=1 skip=2 ;
+		dd if="${crctmpfile}" bs=1 count=1 skip=1 ;
+		dd if="${crctmpfile}" bs=1 count=1 skip=0
+	) >> "${crcbetmpfile}" 2>/dev/null
+	mv "${crcbetmpfile}" "${crctmpfile}"
+fi
+
+# Add 5th byte set to 0x01 to indicate redundant environment image.
+if test "$REDUNDANT" -eq 1 ; then
+	printf '\001' >> "${crctmpfile}"
+fi
+
+# Concatenate the CRC32 and environment block into the final output file.
+cat "${crctmpfile}" "${outtmpfile}" > "${OUTFILE}"
+
+# Clean up the temporary files
+rm -f "${crctmpfile}" "${outtmpfile}"
-- 
2.47.2

