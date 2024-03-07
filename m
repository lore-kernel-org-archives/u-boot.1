Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9194DC54798
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 21:29:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E746487B77;
	Thu,  7 Mar 2024 22:29:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JrHhgIYn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6944A87C83; Thu,  7 Mar 2024 22:29:05 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58670876A4
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 22:29:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maximmosk4@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5132181d54bso1775266e87.3
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 13:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709846937; x=1710451737; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xLchIgs4Y9vYu6rCCGpDHXJOQFKvH6+CiNVo7ReDDKM=;
 b=JrHhgIYnGpd7OXVuROz9+Wn+iCg9vnjDCKSaKGbU/+wt2nZ2hjW3656TPnfZtL7VWU
 LDZkpOB2d6qGV4uFVRLDhp6acc1uNWeM4JPdxCzPnvOB/sfA+E9sOxoFCCgdxJ6JC/Cy
 2knkp2LEtnngMD4B/RSaWgGf+yEbLJPtiYQdrfogFP47yfaw3ocaR0PNtn3+cMa4ltFA
 ICvFOWlSI3kcZtM8axgNi0+Ir6Ds74GxR9M4L/4u/tGQafqoV2f+OVKEA5EvdRefesr8
 u5O8wjqoEUL6NPIlQzwH+VSN4QhjSbtshQBvXF0cQWpNQhr5uhzkZYgKc4+C7ju7ZjPq
 uhMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709846937; x=1710451737;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xLchIgs4Y9vYu6rCCGpDHXJOQFKvH6+CiNVo7ReDDKM=;
 b=aXNDi9CPWMBvfj6rr8wwUd6bddB4VduF5YwIZrpBYbP5o9eTpmShrcIimQ7cMiA5QP
 CaYo/AKnD3HweKEctOtmI8aSAdLuTn7HzX73oJfwyBB7Kt016doZGH3PSnQhcvDRzG7t
 TsgV5C75qSlfjAPwY+3BXy++0dmiH8DGC4Dg5jRdwBzxWqZIXhbiRl2fHGhpOu7bGQwz
 UA4RZmqFAtWAYZEijIB3FHJEk9oxhI61edHyoybV7huXKtMNSEq082xx7ADe/kACO4Ny
 +FwJn6mXa7tsUlPMDkJhjPL23Ga16DNTe4ghKOgnqyOtBg/+Yp5Nk07vUwr2zbsFIlwy
 D/yA==
X-Gm-Message-State: AOJu0YwhK/IeACFzcGj6GcOoc0dl20fkLBhtZrvqO2s/Z60qMMy7UEns
 +iYceuoBZ1H7iQGvVDjsZQoHA5IM4XrMvxDOCLUoYTsJyDrbxaSSfHBSN7M2f+rSyw==
X-Google-Smtp-Source: AGHT+IH9TCcp++WC9SqvBom1iyHajdRktSdIxskbUy1V5eImPQUJShkOjAPmda7bF2AKYRDVjhH9Bg==
X-Received: by 2002:ac2:4a65:0:b0:513:1e31:ddec with SMTP id
 q5-20020ac24a65000000b005131e31ddecmr2406007lfp.40.1709846936847; 
 Thu, 07 Mar 2024 13:28:56 -0800 (PST)
Received: from localhost.localdomain (109-252-14-191.nat.spd-mgts.ru.
 [109.252.14.191]) by smtp.gmail.com with ESMTPSA id
 n24-20020a056512311800b005133e95cf4fsm2368407lfb.85.2024.03.07.13.28.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 13:28:56 -0800 (PST)
From: Maxim Moskalets <maximmosk4@gmail.com>
X-Google-Original-From: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, Maxim.Moskalets@kaspersky.com,
 Maxim Moskalets <maximmosk4@gmail.com>
Subject: [PATCH] cmd: add FDT setup for bootelf by flag
Date: Fri,  8 Mar 2024 00:28:53 +0300
Message-Id: <20240307212853.83611-1-Maxim.Moskalets@kaspersky.com>
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
bootelf command. Enable by selecting CMD_ELF_FDT_SETUP.

Signed-off-by: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
---

 cmd/Kconfig | 11 +++++++++++
 cmd/elf.c   | 39 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index a86b570517..8821e66f76 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -479,6 +479,17 @@ config CMD_ELF
 	help
 	  Boot an ELF/vxWorks image from the memory.
 
+config CMD_ELF_FDT_SETUP
+	bool "Flattened Device Tree setup in bootelf cmd"
+	default n
+	depends on CMD_ELF
+	select LIB_LIBFDT
+	select LMB
+	help
+	  Do FDT setup in bootelf command optionally by param -d, which
+	  allows to bring additional system info (e.g. /memory node) to
+	  the Operating System or application.
+
 config CMD_FDT
 	bool "Flattened Device Tree utility commands"
 	default y
diff --git a/cmd/elf.c b/cmd/elf.c
index b7b9f506a5..df4354d374 100644
--- a/cmd/elf.c
+++ b/cmd/elf.c
@@ -38,6 +38,10 @@ static unsigned long do_bootelf_exec(ulong (*entry)(int, char * const[]),
 /* Interpreter command to boot an arbitrary ELF image from memory */
 int do_bootelf(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
+#if CONFIG_IS_ENABLED(CMD_ELF_FDT_SETUP)
+	struct bootm_headers img = {0};
+	unsigned long fdt_addr = 0; /* Address of the FDT */
+#endif
 	unsigned long addr; /* Address of the ELF image */
 	unsigned long rc; /* Return value from user code */
 	char *sload = NULL;
@@ -46,13 +50,25 @@ int do_bootelf(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
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
+#if CONFIG_IS_ENABLED(CMD_ELF_FDT_SETUP)
+	/* Check for [-d fdt_addr_r] option. */
+	if ((argc >= 2) && (argv[0][0] == '-') && (argv[0][1] == 'd')) {
+		if (strict_strtoul(argv[1], 16, &fdt_addr) != 0)
+			return CMD_RET_USAGE;
+		/* Consume option. */
+		argc -= 2;
+		argv += 2;
+	}
+#endif
+
 	/* Check for address. */
 	if (argc >= 1 && strict_strtoul(argv[0], 16, &addr) != -EINVAL) {
 		/* Consume address */
@@ -68,6 +84,16 @@ int do_bootelf(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	else
 		addr = load_elf_image_shdr(addr);
 
+#if CONFIG_IS_ENABLED(CMD_ELF_FDT_SETUP)
+	if (fdt_addr) {
+		printf("## Setting up FDT at 0x%08lx ...\n", fdt_addr);
+		flush();
+
+		if (image_setup_libfdt(&img, (void *)fdt_addr, NULL))
+			return 1;
+	}
+#endif
+
 	if (!env_get_autostart())
 		return rcode;
 
@@ -298,9 +324,16 @@ int do_bootvx(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 U_BOOT_CMD(
 	bootelf, CONFIG_SYS_MAXARGS, 0, do_bootelf,
 	"Boot from an ELF image in memory",
-	"[-p|-s] [address]\n"
+	"[-p|-s] "
+#if CONFIG_IS_ENABLED(CMD_ELF_FDT_SETUP)
+	"[-d fdt_addr_r] "
+#endif
+	"[address]\n"
 	"\t- load ELF image at [address] via program headers (-p)\n"
-	"\t  or via section headers (-s)"
+	"\t  or via section headers (-s)\n"
+#if CONFIG_IS_ENABLED(CMD_ELF_FDT_SETUP)
+	"\t- setup FDT image at [fdt_addr_r] (-d)"
+#endif
 );
 
 U_BOOT_CMD(
-- 
2.39.2

