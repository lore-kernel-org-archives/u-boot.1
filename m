Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69651C48BF6
	for <u-boot@archiver.kernel.org>; Sun,  3 Mar 2024 11:07:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F9F087EF7;
	Sun,  3 Mar 2024 12:07:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ngMkM86R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FF2B87EFA; Sun,  3 Mar 2024 12:07:04 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5323E87E96
 for <u-boot@lists.denx.de>; Sun,  3 Mar 2024 12:07:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maximmosk4@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5131f3fc695so3673515e87.1
 for <u-boot@lists.denx.de>; Sun, 03 Mar 2024 03:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709464021; x=1710068821; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Er2eTAt5wxeTCcCzcvh/eUze/dbhtGkrGnfCDwD2690=;
 b=ngMkM86R1SPxZDfqvcGWDaInh2jGwp/dsAIQh0CJMKeajL2I36v8If05aG7hK3qkl8
 UQY4n4bcYKJIjJ1Y8VnxW2tLbrED7+R2Ohd837L7nzWa8ckzpwqnUklQbB6wltdytIxB
 KlBQP0s0h1vNioTyn6TeO+2O0IkIL0xlS+VUTjRNg5Sna2+dGJX8tV9+bzQ+yz57jNE/
 C0Bs6+2eJsZfHAC3ykQTem5ptnjij3P+nFdo+GdK1K0hRk6M7puo1qf60v4tQXOLtI8m
 VrmsaCcUeAG1imTzbR3tcIE1LngTKPfA8zglFX8PxijCVRQiJGP1PTntbUV4wOhbyuz9
 rliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709464021; x=1710068821;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Er2eTAt5wxeTCcCzcvh/eUze/dbhtGkrGnfCDwD2690=;
 b=Bw2nHMyljMhMfzuCD2Pu0bKWx4L4+qh1nVMMse1ArJnATYFnCwnyx24nR0iIh7C3RT
 n1MGF/kE3jQ7QfOx6oiPMuE9KdFHO8pFPUbFvgBoK92WvO3HmM/c5o+mzCBZXrxsn22N
 oyUVaQzU1sSDuz0v1c0/Ac9ztewAyUPkQizjkw2fgdZyRy9D0z6dnLW4gYftM6Ra0FNB
 nfieTzYHhIlUrVp79ftdhdON7bjgh6IZlvHl9i2NuA4zqyDy4EHertvARH+h2E7gW04p
 mceh3HsYNHtEPiPFlSZETeh5bDy7WIWum+M9rhQiEVuu7ebhyWJmpKK6qRTe1rvaZuSN
 QAcw==
X-Gm-Message-State: AOJu0YzaPDb8aT9dt3J9p5Mbj/SCKtvmlkzl7sVMuxg4AjycCzvX3G7y
 tlL1u1m6RxvMmPoqdOm4JRuh1mcPSJwm324Nh6gA/eZCF6rQNnu8C2Y5KB2c0T/Iqg==
X-Google-Smtp-Source: AGHT+IE1YtG1RNr7/IgXazVJBtqOn2957NgWTJF+l4O1J0Xe4ZJ3iai1ERi+WWIDCnB0YKOk76dq1g==
X-Received: by 2002:ac2:5e24:0:b0:513:2010:6d93 with SMTP id
 o4-20020ac25e24000000b0051320106d93mr3962097lfg.56.1709464021143; 
 Sun, 03 Mar 2024 03:07:01 -0800 (PST)
Received: from moskalets-nb.kdtln.ru (109-252-11-244.nat.spd-mgts.ru.
 [109.252.11.244]) by smtp.gmail.com with ESMTPSA id
 z17-20020a195e51000000b0051320e19a74sm1333291lfi.34.2024.03.03.03.07.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Mar 2024 03:07:00 -0800 (PST)
From: Maxim Moskalets <maximmosk4@gmail.com>
X-Google-Original-From: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
To: u-boot@lists.denx.de
Cc: Maxim Moskalets <maximmosk4@gmail.com>,
 Maxim Moskalets <Maxim.Moskalets@kaspersky.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 RESEND] cmd: add FDT setup for bootelf by flag
Date: Sun,  3 Mar 2024 14:06:52 +0300
Message-Id: <20240303110652.15490-1-Maxim.Moskalets@kaspersky.com>
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

