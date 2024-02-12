Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E847CC4829E
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 20:21:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 229F3875FA;
	Mon, 12 Feb 2024 21:21:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QGmwqSQo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3514B871C0; Mon, 12 Feb 2024 21:21:12 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E76A587B05
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 21:20:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maximmosk4@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-511898b6c9eso1736636e87.3
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 12:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707769258; x=1708374058; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DbX3R3pXTrkrkShD6QwtpBZP/JN+ubzdV/a+hTd54/8=;
 b=QGmwqSQolE6y6O9s0ZCa/OIl+lpr4cWG62hR7eqczoHZJYqzUZIw7kFGxbQFBZmNU2
 JIgToiUE917cdrLE2DeBDX+VJq866angsOXquilOmUFzAHOSjCz0RW194vfqwsrrQPuA
 vcgC+mfqI6jxJbP4I8qInrWTqikYrbYia5QHEFqV05HfFiAMvX3FpNN3hejuoPwTK3Ao
 305DKMLSdi4strGDpW/nOKeb/PDTT/fwsdi+IGJQVUogR7tTsu22o12XUOdqZEZZZyed
 kdXwR2wQs2MIPTIsYfB+smdHtu97Sxl/TPerHnCmD/mqxsxL17rRDTVr3rLp1OUkgQPY
 TtTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707769258; x=1708374058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DbX3R3pXTrkrkShD6QwtpBZP/JN+ubzdV/a+hTd54/8=;
 b=hKm+dzda47FjWmcbPhAqjqO5h3WphW4sNvXEq8HUEiTAit13MikJrp7NmIpuEU070Q
 6rPd+FmZug7BrV1xXBzT7EPf4rsNYgKFKdc2S3RejGzi4Naz7CWyAsxXwUHhEea6WCEv
 jDSXqMHb+n3l7EXqQI0SHKGO7opq4UWiZ6Q+Mg6obT2NcT+1eB+AIBy3YiO7H//u5Zvz
 OPoRlpqvwkMCuLv2OWmIvjKqORnTd4WlgvlpWWAicaFITb2LBm+4o2qjLW72L9t8u9QV
 9oONu6EXhMrKzvjyJjqE8iaej17gcfo504gcQ9l7dq3E4zMf75t8beQOgf1fYRzU5lN+
 x+AA==
X-Gm-Message-State: AOJu0YzK5Aag+j4ltNuCzpTRY5sbgK7RtYx7HEY1J9XaIlXapjxgJ/b5
 atrmM3nYLGqhqXhQPITA2+us7jgUVxn/1v53MGMreo3WsUHM5GyLI9CsudVXi18=
X-Google-Smtp-Source: AGHT+IHmfk+hYRVAiOscrnje03mpIWNEafsA0qxk0GiqJwK9p0izLMo3xnm70FB08raRBLdAGaXBIQ==
X-Received: by 2002:ac2:544b:0:b0:511:490e:b8fd with SMTP id
 d11-20020ac2544b000000b00511490eb8fdmr4532820lfn.45.1707769257834; 
 Mon, 12 Feb 2024 12:20:57 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWHTGvIKHmQf+pWwWwjf7N3NnF/sNrC0ts7lN5nPLqfdjdjop4lkadUdAq+BMaR0+rk5g2onNunnDM76gL++Eu/UjE=
Received: from localhost.localdomain (109-252-14-208.nat.spd-mgts.ru.
 [109.252.14.208]) by smtp.gmail.com with ESMTPSA id
 f8-20020a056512360800b005115e3fd531sm1005983lfs.144.2024.02.12.12.20.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Feb 2024 12:20:57 -0800 (PST)
From: Maxim Moskalets <maximmosk4@gmail.com>
X-Google-Original-From: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
To: u-boot@lists.denx.de
Cc: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] cmd: add FDT setup for bootelf by flag
Date: Mon, 12 Feb 2024 23:20:43 +0300
Message-Id: <20240212202043.54427-1-Maxim.Moskalets@kaspersky.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212184303.GM3040305@bill-the-cat>
References: <20240212184303.GM3040305@bill-the-cat>
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
index b7b9f506a5..adf8536909 100644
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
+		if (strict_strtoul(argv[1], 16, &fdt_addr) == -EINVAL)
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

