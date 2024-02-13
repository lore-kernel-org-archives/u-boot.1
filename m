Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ECB2C4829A
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 09:14:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1F03875FA;
	Tue, 13 Feb 2024 10:14:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="icQmQmaU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69281875FA; Tue, 13 Feb 2024 10:14:35 +0100 (CET)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCD8C875E9
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 10:14:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maximmosk4@gmail.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2d0fd07ba8bso19000271fa.1
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 01:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707815671; x=1708420471; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nS4UbSL83oCIuDnU7IAjuo5cSCD/DpBLlvaM9yMfuho=;
 b=icQmQmaUACEsVpbWp4GuPjoOtoKZBB9LFQUcE/eHX+sBV0AB4s8LtbO8ZQ96freV0v
 v3VRQf2NPkqzkQzrDPBGWmN1ZaiKKFuB5ggamrdq27Dn2T82KdbbMxANbF8BDEewjP2o
 cdmF+IZ2G8bWYOc6hgLPc8XYFSKqG3nbKhwhelN4Fr7pL8QhmLsNGk2MFbuIPbG+HpmE
 ipQqhlSXQHAXUw0526Q0ZUw38+ZKOrfIdWDolrw2qWHetb3l26oH2n8IAhpbYF+o/yyF
 CqTp54cIZyGLvXODS1YDxLesofqpkqN4LZsdCs69RGm39spQaqfQ7/5rmy3wTstIwSOH
 Qb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707815671; x=1708420471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nS4UbSL83oCIuDnU7IAjuo5cSCD/DpBLlvaM9yMfuho=;
 b=tE38d2LSj73Y+lFDlGDvtzsNmMX8dXeFj9szUlRebPQ5T0qVfbfkQ/yqY9odo9P/ai
 OtY+EjVqNrk8KSbBJnMnvaa8R8OWNPit6UrvMsP5T68AE6tNCBM9pNeIPfweZQ8xSJm+
 pynOB4xOu45sDDJrr/1nMTxc2UQLNxFblS7FFAeWIVrk+YQ3OUospNQcJL23k+MZZreW
 C9CL4mJp32+do6bIem74m1aQVKCIUXD6ioznpy6Mv/IaVSFKMFXYYAwuu1jM2jA16dFx
 sSpCv2LEcG5whbJX+Mtb0emPXy5ggKfBd6b6NjOwc0CFptfj5gaPfRq3VkWixMBLkAKq
 gyAA==
X-Gm-Message-State: AOJu0Yzkwi7Mg9nXySJFVDy6xRaM2pgJ4wy27tkElGvOY3uY1gg1xumU
 8KcexqmG7E4UlqtV+735b4bWqRKemdOd8c9J6NrE5YNyNAJB1UbC8RQYFztZ4zQ=
X-Google-Smtp-Source: AGHT+IHlrine7OtjJ2GbQAHKsQdet6NOYKALGvyKTzucgh0VDSEtOxKSl3ZHEETZMXeziNSsnFI1Iw==
X-Received: by 2002:a2e:be1f:0:b0:2d0:7fea:2920 with SMTP id
 z31-20020a2ebe1f000000b002d07fea2920mr2787955ljq.37.1707815670392; 
 Tue, 13 Feb 2024 01:14:30 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUsiI10ftgIP+KlZschj0EkpWAcDozwbifw56MhM/zxKA8lVRGQkXIcygQSflO0bfITNbQOHVRDADxXP0FOa5qHCdo=
Received: from moskalets-nb.kdtln.ru (109-252-14-208.nat.spd-mgts.ru.
 [109.252.14.208]) by smtp.gmail.com with ESMTPSA id
 j7-20020a2eb707000000b002d0bf23c0bfsm415603ljo.130.2024.02.13.01.14.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 01:14:29 -0800 (PST)
From: Maxim Moskalets <maximmosk4@gmail.com>
X-Google-Original-From: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
To: u-boot@lists.denx.de
Cc: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3] cmd: add FDT setup for bootelf by flag
Date: Tue, 13 Feb 2024 12:14:22 +0300
Message-Id: <20240213091422.13635-1-Maxim.Moskalets@kaspersky.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212202043.54427-1-Maxim.Moskalets@kaspersky.com>
References: <20240212202043.54427-1-Maxim.Moskalets@kaspersky.com>
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

Added the ability to use FDT for ELF applications, required to run some OS. To make FDT setup, you need to set the -d fdt_addr_r cmd option for bootelf command

Signed-off-by: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>

Cc: Tom Rini <trini@konsulko.com>
---

 cmd/elf.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/cmd/elf.c b/cmd/elf.c
index b7b9f506a5..c525618a39 100644
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
 
@@ -298,7 +318,7 @@ int do_bootvx(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 U_BOOT_CMD(
 	bootelf, CONFIG_SYS_MAXARGS, 0, do_bootelf,
 	"Boot from an ELF image in memory",
-	"[-p|-s] [address]\n"
+	"[-p|-s] [-d fdt_addr_r] [address]\n"
 	"\t- load ELF image at [address] via program headers (-p)\n"
 	"\t  or via section headers (-s)"
 );
-- 
2.39.2

