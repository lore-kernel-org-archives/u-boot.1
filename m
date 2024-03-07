Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B80C54E4A
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 21:29:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 659A587DC4;
	Thu,  7 Mar 2024 22:29:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gVPxgkEI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE8CF876A4; Thu,  7 Mar 2024 22:29:21 +0100 (CET)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5E8C87E02
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 22:29:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maximmosk4@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2d3f4fef377so18254261fa.1
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 13:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709846958; x=1710451758; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xLchIgs4Y9vYu6rCCGpDHXJOQFKvH6+CiNVo7ReDDKM=;
 b=gVPxgkEI7nVR9N5NxDQMfqTNwv8KI/iYwfQLM8NfCQH7e28gJ7CzDSXF9gEBsujQ01
 JE9BgWrHzZydGBQFO/oHK8rhFkv/sYj4vj/lDVFSNKnAl1QzRQ1GqpexLcJ27miwoklG
 OBuBbTaCmQeeix9PuyQEsP59giLsm345Ahhh9Fi/Sv9m3amQaf1OOK0+ECbCi3BDGdzK
 FGSmjJvutp1H6S4Cn2vTnlGE8AEfXgqhxKBxJF1jldxNaGajroXuCwQ/DryaP170ymAW
 tcp6XQvAQCXRMQSRhztDEXGUcLcc3SN6wgaoqT1jyGoCGC3nVQY6vn2iOBrFg+qgmc+I
 +ZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709846958; x=1710451758;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xLchIgs4Y9vYu6rCCGpDHXJOQFKvH6+CiNVo7ReDDKM=;
 b=adLOCvrQ8jcjWQY2wTIXjKbrI0lHy+K5O4CJPc/4+IYGjbqbpO+KVASZCq/PGOFKDG
 udNqfmkevqbfp33p2adfbB8l/RdwyWsvQdYKZdiEm3KeFDuWlagCtvHZQvQA6l0dZrXX
 5I1rCcCzh32cK8TsW3Rd1+fLKlTNHLbApCCYfbLzUYjQD0KneUq2hwWP+ghLsMxTgQuK
 BMr0ZslswBLFmJNcCOXHn/mio/utITCiLOlPmd2ci36lDvm5BasLfowXQvaC9XKuntKW
 /BVBsoMWYuHn1OI1cTa4obNVwdoOzDCZEjt14HqdhiQ1JKjnVqk3ybHtA9oAfsLSL2Bs
 136w==
X-Gm-Message-State: AOJu0YxRs1s/6JJIG1nyPv6OGd/y8045SotKSefMlmfzAA0bj14gJhTz
 ra/TILuw2UKr/tT9+xAwuaZ+Zu4B1w6jvCUEaqBjUhYpVbgLv5S+nteF1VQ3uWYTMQ==
X-Google-Smtp-Source: AGHT+IG8QlKL3XtOkPp2ZNZ+LPe86+1vCj8/Y+X6HqjXncNhBatQkIVHlclgmK9s4hs1kxytnvQang==
X-Received: by 2002:a2e:9952:0:b0:2d2:954e:aceb with SMTP id
 r18-20020a2e9952000000b002d2954eacebmr2116211ljj.53.1709846957447; 
 Thu, 07 Mar 2024 13:29:17 -0800 (PST)
Received: from localhost.localdomain (109-252-14-191.nat.spd-mgts.ru.
 [109.252.14.191]) by smtp.gmail.com with ESMTPSA id
 v2-20020a2e9902000000b002d0f905ddf9sm3155061lji.18.2024.03.07.13.29.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 13:29:17 -0800 (PST)
From: Maxim Moskalets <maximmosk4@gmail.com>
X-Google-Original-From: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, Maxim.Moskalets@kaspersky.com,
 Maxim Moskalets <maximmosk4@gmail.com>
Subject: [PATCH v5] cmd: add FDT setup for bootelf by flag
Date: Fri,  8 Mar 2024 00:29:14 +0300
Message-Id: <20240307212914.83657-1-Maxim.Moskalets@kaspersky.com>
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

