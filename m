Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD41C5478C
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 18:36:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1ECE187AEC;
	Mon, 26 Feb 2024 19:36:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PhQtX0Af";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36EE5877B1; Mon, 26 Feb 2024 19:36:13 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4425E877B1
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 19:36:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maximmosk4@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-512e4f4e463so4053930e87.1
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 10:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708972570; x=1709577370; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Er2eTAt5wxeTCcCzcvh/eUze/dbhtGkrGnfCDwD2690=;
 b=PhQtX0Af3XX5raUYgaulEZU8c3zoRQMODm/GRCRWJK9lpx56Ee2oSWgoSnvt+2geDM
 9xC7ZJZFyEwiRv+adKo1qkwsD/1lPFioa1Xl7/r4nGrlH/YwZ4ljjf7e6aPgOIiMLoB7
 +2Qak21UygZdHd0crhwfqRUVbD0ccUxU8qqG9iH5ALVcegkuEe8daWWQzydlLLh7+myW
 2ZXj66Y9E8AYerK//58SJjlyQtt8UB3Fj3EnjJ8Ve2V4k4AdhT76NgOyCPnryyvm4hK6
 170HaCRB4jW71+qzLE/abcjncIGKdT87ujBltYqi2fkQEIiraRnAtBe4MIfzcqOJTVUo
 SybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708972570; x=1709577370;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Er2eTAt5wxeTCcCzcvh/eUze/dbhtGkrGnfCDwD2690=;
 b=NweI9GSNmxVsK6ZCnJN5EovZRr2Tq53l4Lwd6DLOz+NKGy/TmSxjcBGr1ioJ9oFiOO
 TL+8/3CmvHPOsj6wLyUf5i6n6DTXFiuOXLfmNPPl2OZGvN0ZtCGVcolbYcnYNZcy64HH
 Eattw76l7UsiW/4YO+HdMObqumUobX0yyIrufhwpDwlnvOhusxDKmYsUdHpSYEMQECZa
 /hCywhlFXgdQjDlKaoeCv2EsHGycfwxQmVGjP5g79tikLPCxBemUkXEvxVpqrp0C1315
 kaVvKjB79M7Imh2sbFqQzMiU0VOH+WNcqtcQp3sKLxeYgMr4ClQWj76pgGkChoXrEGeo
 wiHQ==
X-Gm-Message-State: AOJu0Ywrb4olWXKO4Ez42+1L0V9LrEoxTlDQYQk6vY/s/M+JhHF+tJKR
 Z4dSs14QqzmUAJ58yrRqdOAHgkj6r87pHnLR5/2tp48KMP9lP5uXU9qeq48N
X-Google-Smtp-Source: AGHT+IFAUyxpJ2DGxfzXbHBYDJMFOQoeyTRssL5n9KhTrvUFEIAYJdF/ZDl2QEaNjBm25+tsxRjpAw==
X-Received: by 2002:a19:2d1d:0:b0:512:adba:2d9d with SMTP id
 k29-20020a192d1d000000b00512adba2d9dmr5366540lfj.14.1708972569921; 
 Mon, 26 Feb 2024 10:36:09 -0800 (PST)
Received: from localhost.localdomain (109-252-11-244.nat.spd-mgts.ru.
 [109.252.11.244]) by smtp.gmail.com with ESMTPSA id
 l7-20020ac25547000000b00512f2a11d70sm910220lfk.283.2024.02.26.10.36.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 10:36:09 -0800 (PST)
From: Maxim Moskalets <maximmosk4@gmail.com>
X-Google-Original-From: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
To: u-boot@lists.denx.de
Cc: Maxim Moskalets <maximmosk4@gmail.com>,
 Maxim Moskalets <Maxim.Moskalets@kaspersky.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4] cmd: add FDT setup for bootelf by flag
Date: Mon, 26 Feb 2024 21:35:53 +0300
Message-Id: <20240226183553.11615-1-Maxim.Moskalets@kaspersky.com>
X-Mailer: git-send-email 2.39.2
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

From: Maxim Moskalets <maximmosk4@gmail.com>

Added the ability to use FDT for ELF applications, required to run some
OS. To make FDT setup, you need to set the -d fdt_addr_r cmd option for
bootelf command.

Signed-off-by: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>

Cc: Tom Rini <trini@konsulko.com>
---
 cmd/elf.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/cmd/elf.c b/cmd/elf.c
index b7b9f506a5..2fa28448c0 100644
--- a/cmd/elf.c
+++ b/cmd/elf.c
@@ -38,6 +38,8 @@ static unsigned long do_bootelf_exec(ulong (*entry)(int, char * const[]),
 /* Interpreter command to boot an arbitrary ELF image from memory */
 int do_bootelf(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
+	struct bootm_headers img = {0};
+	unsigned long fdt_addr = 0; /* Address of the FDT */
 	unsigned long addr; /* Address of the ELF image */
 	unsigned long rc; /* Return value from user code */
 	char *sload = NULL;
@@ -46,13 +48,23 @@ int do_bootelf(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	/* Consume 'bootelf' */
 	argc--; argv++;

-	/* Check for flag. */
+	/* Check for [-p|-s] flag. */
 	if (argc >= 1 && (argv[0][0] == '-' && \
 				(argv[0][1] == 'p' || argv[0][1] == 's'))) {
 		sload = argv[0];
 		/* Consume flag. */
 		argc--; argv++;
 	}
+
+	/* Check for [-d fdt_addr_r] option. */
+	if ((argc >= 2) && (argv[0][0] == '-') && (argv[0][1] == 'd')) {
+		if (strict_strtoul(argv[1], 16, &fdt_addr) != 0)
+			return CMD_RET_USAGE;
+		/* Consume option. */
+		argc -= 2;
+		argv += 2;
+	}
+
 	/* Check for address. */
 	if (argc >= 1 && strict_strtoul(argv[0], 16, &addr) != -EINVAL) {
 		/* Consume address */
@@ -68,6 +80,14 @@ int do_bootelf(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	else
 		addr = load_elf_image_shdr(addr);
 
+	if (fdt_addr) {
+		printf("## Setting up FDT at 0x%08lx ...\n", fdt_addr);
+		flush();
+
+		if (image_setup_libfdt(&img, (void *)fdt_addr, NULL))
+			return 1;
+	}
+
 	if (!env_get_autostart())
 		return rcode;
 
@@ -298,9 +318,10 @@ int do_bootvx(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 U_BOOT_CMD(
 	bootelf, CONFIG_SYS_MAXARGS, 0, do_bootelf,
 	"Boot from an ELF image in memory",
-	"[-p|-s] [address]\n"
+	"[-p|-s] [-d fdt_addr_r] [address]\n"
 	"\t- load ELF image at [address] via program headers (-p)\n"
-	"\t  or via section headers (-s)"
+	"\t  or via section headers (-s)\n"
+	"\t- setup FDT image at [fdt_addr_r] (-d)"
 );
 
 U_BOOT_CMD(
-- 
2.39.2

