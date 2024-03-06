Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CE5C54E41
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 23:38:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BC358792D;
	Thu,  7 Mar 2024 00:38:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gXO3dQwJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B26D68785E; Thu,  7 Mar 2024 00:38:48 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5360087EAF
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 00:38:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maximmosk4@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-51364c3d5abso289150e87.2
 for <u-boot@lists.denx.de>; Wed, 06 Mar 2024 15:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709768304; x=1710373104; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Er2eTAt5wxeTCcCzcvh/eUze/dbhtGkrGnfCDwD2690=;
 b=gXO3dQwJyWZbFEsJLvulzTsWg8j3+fYqWPyTB9udzvRD5V3qXrvMDfwfC4pv0t/Q2B
 H5N1qmcAZlHDzLnlWrOjZ5bBNvEiVTHrsq/xrvCVmACHTHsrIytQV/rT12Nd4TJ4XrM6
 dgrzWYWCZLjtTtwMb4mMlba/B+9PfmgDIUrOyMKx3gFeQ1GGaBSs9b7b82p/5DSYUPEl
 1YDSazciqos0Loia5lpz8r6VkJUVVeJX2VFt5tjEwWDZEbE8GOlW85S/mDwk+q2mtnQz
 AqCpCpB8JEICJTikZAZ9NGDggU+w3k0ZLuIhr3aNtw6SNVsGldi9e5xavqgYBktLRyqu
 msFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709768304; x=1710373104;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Er2eTAt5wxeTCcCzcvh/eUze/dbhtGkrGnfCDwD2690=;
 b=uK/T5b8ahUvYZYjDFb7MFrd/rs4OZF5hHrTWGJ7JeO6DGOlQ8997N34Rp/SD1qoUVW
 ElJIDuOx21RdLzNXzfkAGRUHGcG9x4y22KEpBcI3IVNg9ZfNi+GBAMWQSnN9cDudQfw5
 +EVq0vzrBNl/jSdCx3hc0Y3G6WAOa3qIE4Tfaqw8Bc+g1a3CXYmYItSX6P9o0QKxb9M1
 Si3ol2b9wiHsxxJQZtF3Yhye4yLMK+uCGLuaQj0PQpwsQc77kr9eGq6TpsvF7eSGwNpY
 r6/74+wTP8hvZJckXPBlTQjndzQZneVwBWZTp9ZLa+VHgcUyIHxkArX1ldCKphR4gQtu
 nyMQ==
X-Gm-Message-State: AOJu0Yz7dPjtQDFuK+q3gZYrNHlBcx7xmwpmoQR32TI0jmWdJPcBnWJ+
 RRLaY976T7tCr9+QdLSsocQD6dFlbVRsEJX5Hfxg+NAJq5boM7lnQpWXJUK33vk=
X-Google-Smtp-Source: AGHT+IEPuIk4AVZY7oW4nRHCRqI53YuBvf3HtGU7XKkMJXdUCyEr7mbXnjQkk03pppuDAdElatBs+g==
X-Received: by 2002:a05:6512:e93:b0:513:6f0c:e075 with SMTP id
 bi19-20020a0565120e9300b005136f0ce075mr452968lfb.24.1709768303925; 
 Wed, 06 Mar 2024 15:38:23 -0800 (PST)
Received: from localhost.localdomain (109-252-14-191.nat.spd-mgts.ru.
 [109.252.14.191]) by smtp.gmail.com with ESMTPSA id
 h4-20020a056512350400b00513006c81e6sm460251lfs.227.2024.03.06.15.38.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 15:38:23 -0800 (PST)
From: Maxim Moskalets <maximmosk4@gmail.com>
X-Google-Original-From: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, Maxim.Moskalets@kaspersky.com,
 Maxim Moskalets <maximmosk4@gmail.com>
Subject: [PATCH v4 RESEND] cmd: add FDT setup for bootelf by flag
Date: Thu,  7 Mar 2024 02:38:10 +0300
Message-Id: <20240306233810.10107-1-Maxim.Moskalets@kaspersky.com>
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

