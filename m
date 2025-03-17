Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A81C282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 22:58:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 622B680F70;
	Mon, 17 Mar 2025 23:58:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kNcZqVpP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17FCE81101; Mon, 17 Mar 2025 23:54:01 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0B6780107
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 23:53:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerio.borin@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22403cbb47fso90779565ad.0
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 15:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742252037; x=1742856837; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YsURhe6DW4pbsqivaSLRhqGkTIeUvTn198ML3wgdbGQ=;
 b=kNcZqVpPrauPLZrHt9+3veyo0icXQdQb2PdJ+VcTlOup1qoE0lxI1SC3BT2+yIluIg
 96yza1n1USF6Awjcgd59/LRrlfZ9hIqT/Y1+ybp0pcq+yzavQHhKvzczUZ9+kF2o6Lm2
 /uu1tiZnYUcKxC4FVxuwqkl7fuxez2d26xrSUdRGQldCSFdPQ1WtfCdcey8Mqwgk/Rkh
 RfyMZylHoXnQj2N8kbfpqXWXpAVDWxDZXZ9xN+GvhjKGN6wLJ/gLw7JuYlZOrh/+XzYU
 23IFPcaMIBQwsYCBPm2ZVRgH/Qeus36LDutSHor0x3rLYW7hMdwQqQvAJiXffcpwYCea
 13oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742252037; x=1742856837;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YsURhe6DW4pbsqivaSLRhqGkTIeUvTn198ML3wgdbGQ=;
 b=FTwFHkDjat1Tx3MfO2ka7FdhyfLGZNd75nIk7QSu2iRjxCkshEnpW/G0O1CkBgpQQt
 fE5camuPf0HEshdQYOTRKGE2L5dbVK8AO+o6gCRRwq0tvmna0tfsJwI7mQt4DWPukKWb
 T4fbygnX5fpEQTQVAdT6UGf5Xzsd1c1euI3XKx1Rzq42fK/GDaCQ4+gDJCtJzPOAhyIZ
 MulkF5werM7OnC8X/ihZoTEe5U4do6ZRC0tHj+gEMz7h1y34n/7FMTy4Tu10VQ7zu7vH
 RPVJMEZ2wOiKaMTqR/SWSab0R28OeTTD+v0Ay1Cv+NBR4GOydAx5uGm4BR/ZHm4TU4qJ
 UDyg==
X-Gm-Message-State: AOJu0Yx72LqlwykWdIxru2j34F1SdvZGnrzL6+6EbnQsQUJVwR6d+kMi
 HirkBQ8E5dJthMYzi4QPLLwbooTPCZvQyaHYv+6ZL28KfmymJdCQAKXXNQBo
X-Gm-Gg: ASbGncvSxuUT2W7jdXdz/vcoR4UrNeArnJjFpPfHFXYCxCv9l/U1ey3PgPtjhbWgItk
 yIZZt/1hh1hMPiPPDfVPyVAYWCL8ADlEBbsWC8XEb408eKAkyylj8/9xwFYInk1m2HTxkArmKga
 nMDBz7kd8Z7wOrE2FYJ+pzKTbQRslcC73sJ4sXf8W9To0eOmGGrDyitMicSh+3xHAjTqq+n/4Su
 pSfVK6CSYeGPan7OwB14YZt12y5176P8nCLeQme/X9PnhDDf/T2mwO9K5uPg/7Pft7V6jNPyvxQ
 v1pXMTYCtSxjMmnWU/LZ4VYoLWVx3jjkw6vYUEboVCtj5ZLhvnG/ZKABsCMCwHb5Mfk=
X-Google-Smtp-Source: AGHT+IGJUR0UR3BEfax1l2HxZRsq6486zf3hcDoPphbkBmU9Vv2pxSL8VTYfo67R6eZMDQh+wwAknQ==
X-Received: by 2002:a17:903:1b27:b0:224:5b4:b3b9 with SMTP id
 d9443c01a7336-225e0af57d2mr159897745ad.33.1742252037057; 
 Mon, 17 Mar 2025 15:53:57 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:211:8d94:b225:aaff:fe3c:dc92])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-225c68885acsm80920345ad.32.2025.03.17.15.53.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 15:53:56 -0700 (PDT)
From: Rogerio Guerra Borin <rogerio.borin@gmail.com>
X-Google-Original-From: Rogerio Guerra Borin <rogerio.borin@toradex.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Rogerio Guerra Borin <rogerio.borin@toradex.com>
Subject: [PATCH] cmd: fuse: add switch for quiet operation
Date: Mon, 17 Mar 2025 19:53:36 -0300
Message-Id: <20250317225336.2891974-1-rogerio.borin@toradex.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 17 Mar 2025 23:58:39 +0100
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

