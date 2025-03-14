Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E93C28B2F
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 20:10:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 924AF81F69;
	Fri, 14 Mar 2025 21:10:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bOZa/+jO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22AD581F4E; Fri, 14 Mar 2025 20:55:39 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6DC981F0B
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 20:55:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerio.borin@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2232aead377so56179725ad.0
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 12:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741982135; x=1742586935; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YsURhe6DW4pbsqivaSLRhqGkTIeUvTn198ML3wgdbGQ=;
 b=bOZa/+jO658lHbyPPvSusatzbHY0MII9kiMuA/oDG7IRepXbfZQ3u6M+9Vhb2bLXu5
 UWF3iVxtE1xd+J5CDvfqfKUi8GMUEt7pGFuTlkj73CbNtLgaQhmwc9WRU3OceVfAi0gX
 WlBSyFWTA60lGNLiEPnY9TwCPnBv4SA78WJgPwhzYkpBtz0Bpo33lCOVpn1FLl5T9qZS
 0k4eReic+XgoPbiafTomhK3K/lrHsmkMSueuWHOx9Gk1WfnTaQtEb3aDCQtwdLYtv03a
 x3t26soxnqFL+SJLJw7bw7d617Q6SAklvC9++NSJlRCxCmR0ZGjnIVwlo9ULJwg0Yt07
 44Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741982135; x=1742586935;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YsURhe6DW4pbsqivaSLRhqGkTIeUvTn198ML3wgdbGQ=;
 b=wyv+MY1/UxZwMK8xMg6JEN8PJr+ul8X3XxWHSsOjjmOlCRqib1ihS6LKw40NOHIcJf
 MP8lKGXY/tZlTES0CntBUk8v8de2N4IUVm1OyPYGNqSmY+x8hyzyv6KWF+yngH6fw1mT
 mabByPguXWj18tuHa+a+Fo6DObqagmHRUyN7X9UY227HE4/atNj/PEF3AuY4yDLMDFRx
 NQcAjGUEdXhQL1OfBZF6E9QVDHSbKB0tlxSwluTr+ZflqiCG9kagCfiTuNcpw25igFuy
 fEI6mR9URfbokD4JPRnk+rM7D0oLVx91QeEcBdb45ss7Qr8hOP2fyovnX3K7hjB6z7UI
 mbcg==
X-Gm-Message-State: AOJu0YwLao/kPud1eaHws+FXKNZhC04TV/yKyglIH/WEnpB/N2nAxOY2
 dNN8kHqg62XdqNCEglVw7SdeXLuKTEOIVjfGaHKNaC4t2Wpnxd5N
X-Gm-Gg: ASbGncuanyYNa4XOoncgGBzqQE8X/jkTuCn3viAdl3Fl5qqI8hHukiNa72xFoj+yvEV
 C4g0TiGsSFZ8LuyrP7oLsaF74ZXLswfFy/MW3V+kvNluyqmTnGPGv3jLLL7abN33MXnaK2MxwoX
 LHE5kzgCy6GEt74mJ9fZEZA6DRkAT5LjWfDecsqyy4yRJ5RfO2OTtFgWGr0fBZaw4pas+l4zG86
 TuKhEWjZD1OIwrSRZG9KyeOEg8dtg9s9jMAzFZEHcSYUtj0QfNyYEjOYPnCUmAoJjmk/UL5qeLj
 dKpDK7dXqu8NrMKtfFYQXsDgWfNPc5Uhj5a35cFgaXt+kSnd59/JuSb0K/cNio8NbLE=
X-Google-Smtp-Source: AGHT+IFV0+dxaG8+1cF+sd1A76FdWq605xKeZYQcy5rEX9bnFo8l1FjX3c9xqF0fhB93x+ua5hj4Hw==
X-Received: by 2002:a05:6a21:328e:b0:1f5:8cc8:9cc5 with SMTP id
 adf61e73a8af0-1f5c12c8bf3mr4849127637.34.1741982135069; 
 Fri, 14 Mar 2025 12:55:35 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:211:8d94:b225:aaff:fe3c:dc92])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-737115781fesm3253205b3a.77.2025.03.14.12.55.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 12:55:34 -0700 (PDT)
From: Rogerio Guerra Borin <rogerio.borin@gmail.com>
X-Google-Original-From: Rogerio Guerra Borin <rogerio.borin@toradex.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Rogerio Guerra Borin <rogerio.borin@toradex.com>
Subject: [PATCH] cmd: fuse: add switch for quiet operation
Date: Fri, 14 Mar 2025 16:54:02 -0300
Message-Id: <20250314195402.2943844-1-rogerio.borin@toradex.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 14 Mar 2025 21:10:25 +0100
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

Add switch -q for quiet operation to all fuse subcommands. This helps
avoid bloating the console with messages that can be distracting to
users (particularly when the command is employed by scripts and multiple
fuse values are read/compared/programmed). For example, the "fuse cmp"
command normally produces five lines of output:

    U-Boot # fuse cmp 6 0 0x70af49db
    Comparing bank 6:

    Word 0x00000000:
    Value 0x70af49db:0x70af49db
    passed
    U-Boot # echo $?
    0

But scripts issuing the command do not know or care about that output
since the command exit code is the only relevant information visible to
them. With the new switch one can avoid the unnecessary output:

    U-Boot # fuse cmp -q 6 0 0x70af49db
    U-Boot # echo $?
    0

Signed-off-by: Rogerio Guerra Borin <rogerio.borin@toradex.com>
---
 cmd/fuse.c | 79 ++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 50 insertions(+), 29 deletions(-)

diff --git a/cmd/fuse.c b/cmd/fuse.c
index 598ef496a43..5ed221b1ecf 100644
--- a/cmd/fuse.c
+++ b/cmd/fuse.c
@@ -45,14 +45,30 @@ static int do_fuse(struct cmd_tbl *cmdtp, int flag, int argc,
 		   char *const argv[])
 {
 	const char *op = cmd_arg1(argc, argv);
-	int confirmed = argc >= 3 && !strcmp(argv[2], "-y");
+	int confirmed = 0, quiet = 0;
 	u32 bank, word, cnt, val, cmp;
 	ulong addr;
 	void *buf, *start;
 	int ret, i;
 
-	argc -= 2 + confirmed;
-	argv += 2 + confirmed;
+#define IF_NOT_QUIET(stmt) do { if (!quiet) { stmt; } } while(0)
+
+	if (argc >= 2) {
+		argc -= 2;
+		argv += 2;
+	}
+
+	/* Handle common switches. */
+	while (argc) {
+		if (!strcmp(argv[0], "-y"))
+			confirmed = 1;
+		else if (!strcmp(argv[0], "-q"))
+			quiet = 1;
+		else
+			break;
+		argc--;
+		argv++;
+	}
 
 	if (argc < 2 || strtou32(argv[0], 0, &bank) ||
 			strtou32(argv[1], 0, &word))
@@ -64,18 +80,18 @@ static int do_fuse(struct cmd_tbl *cmdtp, int flag, int argc,
 		else if (argc != 3 || strtou32(argv[2], 0, &cnt))
 			return CMD_RET_USAGE;
 
-		printf("Reading bank %u:\n", bank);
+		IF_NOT_QUIET(printf("Reading bank %u:\n", bank));
 		for (i = 0; i < cnt; i++, word++) {
 			if (!(i % 4))
-				printf("\nWord 0x%.8x:", word);
+				IF_NOT_QUIET(printf("\nWord 0x%.8x:", word));
 
 			ret = fuse_read(bank, word, &val);
 			if (ret)
 				goto err;
 
-			printf(" %.8x", val);
+			IF_NOT_QUIET(printf(" %.8x", val));
 		}
-		putc('\n');
+		IF_NOT_QUIET(putc('\n'));
 	} else if (!strcmp(op, "readm")) {
 		if (argc == 3)
 			cnt = 1;
@@ -87,7 +103,8 @@ static int do_fuse(struct cmd_tbl *cmdtp, int flag, int argc,
 		start = map_sysmem(addr, 4);
 		buf = start;
 
-		printf("Reading bank %u len %u to 0x%lx\n", bank, cnt, addr);
+		IF_NOT_QUIET(printf("Reading bank %u len %u to 0x%lx\n",
+				    bank, cnt, addr));
 		for (i = 0; i < cnt; i++, word++) {
 			ret = fuse_read(bank, word, &val);
 			if (ret)
@@ -102,38 +119,38 @@ static int do_fuse(struct cmd_tbl *cmdtp, int flag, int argc,
 		if (argc != 3 || strtou32(argv[2], 0, &cmp))
 			return CMD_RET_USAGE;
 
-		printf("Comparing bank %u:\n", bank);
-		printf("\nWord 0x%.8x:", word);
-		printf("\nValue 0x%.8x:", cmp);
+		IF_NOT_QUIET(printf("Comparing bank %u:\n", bank));
+		IF_NOT_QUIET(printf("\nWord 0x%.8x:", word));
+		IF_NOT_QUIET(printf("\nValue 0x%.8x:", cmp));
 
 		ret = fuse_read(bank, word, &val);
 		if (ret)
 			goto err;
 
-		printf("0x%.8x\n", val);
+		IF_NOT_QUIET(printf("0x%.8x\n", val));
 		if (val != cmp) {
-			printf("failed\n");
+			IF_NOT_QUIET(printf("failed\n"));
 			return CMD_RET_FAILURE;
 		}
-		printf("passed\n");
+		IF_NOT_QUIET(printf("passed\n"));
 	} else if (!strcmp(op, "sense")) {
 		if (argc == 2)
 			cnt = 1;
 		else if (argc != 3 || strtou32(argv[2], 0, &cnt))
 			return CMD_RET_USAGE;
 
-		printf("Sensing bank %u:\n", bank);
+		IF_NOT_QUIET(printf("Sensing bank %u:\n", bank));
 		for (i = 0; i < cnt; i++, word++) {
 			if (!(i % 4))
-				printf("\nWord 0x%.8x:", word);
+				IF_NOT_QUIET(printf("\nWord 0x%.8x:", word));
 
 			ret = fuse_sense(bank, word, &val);
 			if (ret)
 				goto err;
 
-			printf(" %.8x", val);
+			IF_NOT_QUIET(printf(" %.8x", val));
 		}
-		putc('\n');
+		IF_NOT_QUIET(putc('\n'));
 	} else if (!strcmp(op, "prog")) {
 		if (argc < 3)
 			return CMD_RET_USAGE;
@@ -142,8 +159,9 @@ static int do_fuse(struct cmd_tbl *cmdtp, int flag, int argc,
 			if (strtou32(argv[i], 16, &val))
 				return CMD_RET_USAGE;
 
-			printf("Programming bank %u word 0x%.8x to 0x%.8x...\n",
-					bank, word, val);
+			IF_NOT_QUIET(printf("Programming bank %u word "
+					    "0x%.8x to 0x%.8x...\n",
+					    bank, word, val));
 			if (!confirmed && !confirm_prog())
 				return CMD_RET_FAILURE;
 			ret = fuse_prog(bank, word, val);
@@ -158,8 +176,9 @@ static int do_fuse(struct cmd_tbl *cmdtp, int flag, int argc,
 			if (strtou32(argv[i], 16, &val))
 				return CMD_RET_USAGE;
 
-			printf("Overriding bank %u word 0x%.8x with "
-					"0x%.8x...\n", bank, word, val);
+			IF_NOT_QUIET(printf("Overriding bank %u word "
+					    "0x%.8x with 0x%.8x...\n",
+					    bank, word, val));
 			ret = fuse_override(bank, word, val);
 			if (ret)
 				goto err;
@@ -171,23 +190,25 @@ static int do_fuse(struct cmd_tbl *cmdtp, int flag, int argc,
 	return 0;
 
 err:
-	puts("ERROR\n");
+	IF_NOT_QUIET(puts("ERROR\n"));
 	return CMD_RET_FAILURE;
+
+#undef IF_NOT_QUIET
 }
 
 U_BOOT_CMD(
 	fuse, CONFIG_SYS_MAXARGS, 0, do_fuse,
 	"Fuse sub-system",
-	     "read <bank> <word> [<cnt>] - read 1 or 'cnt' fuse words,\n"
+	     "read [-q] <bank> <word> [<cnt>] - read 1 or 'cnt' fuse words,\n"
 	"    starting at 'word'\n"
-	"fuse cmp <bank> <word> <hexval> - compare 'hexval' to fuse\n"
+	"fuse cmp [-q] <bank> <word> <hexval> - compare 'hexval' to fuse\n"
 	"    at 'word'\n"
-	"fuse readm <bank> <word> <addr> [<cnt>] - read 1 or 'cnt' fuse words,\n"
+	"fuse readm [-q] <bank> <word> <addr> [<cnt>] - read 1 or 'cnt' fuse words,\n"
 	"    starting at 'word' into memory at 'addr'\n"
-	"fuse sense <bank> <word> [<cnt>] - sense 1 or 'cnt' fuse words,\n"
+	"fuse sense [-q] <bank> <word> [<cnt>] - sense 1 or 'cnt' fuse words,\n"
 	"    starting at 'word'\n"
-	"fuse prog [-y] <bank> <word> <hexval> [<hexval>...] - program 1 or\n"
+	"fuse prog [-q] [-y] <bank> <word> <hexval> [<hexval>...] - program 1 or\n"
 	"    several fuse words, starting at 'word' (PERMANENT)\n"
-	"fuse override <bank> <word> <hexval> [<hexval>...] - override 1 or\n"
+	"fuse override [-q] <bank> <word> <hexval> [<hexval>...] - override 1 or\n"
 	"    several fuse words, starting at 'word'"
 );
-- 
2.34.1

