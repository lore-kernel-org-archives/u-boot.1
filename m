Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F098BCD11BF
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 16:10:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67E0B87F0A;
	Tue, 19 Mar 2024 17:10:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iTTfrXaY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 221E087D82; Tue, 19 Mar 2024 17:10:30 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28B9087D82
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 17:10:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maximmosk4@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2d27184197cso76050781fa.1
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 09:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710864627; x=1711469427; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Zm3U654Nut1+La4zI7uDUPRY05PZKgPmJr21URirjQg=;
 b=iTTfrXaYArZA427HE7fgdGRUbuwNZ1cGKsxNS9ipdvAEcdS+mllcIny0bg4AT1vum5
 4N6jnWGAwO7opjgfMnrxi9OowfiWOe13g2qG3xhw0Dax0gopdVejFp0uHK8fmnGoTr8g
 smQde92UDKrUVomYlqSAbvXN6dKq6Nzi7w5GugTgq4BUqSspldKMkfgcbURpm2j6fgLv
 WrT74C5lUXTojSHZvhQZ1VV3yWGvyM1A8eY+iWcIlIowHDaZsaV8Zs12ggb/KyenKRF7
 Zvovi4NiXfHUNY1rDw0ZY66wsWzXMZgRy5l2c1ehw5BvW0lAmNz95nKyaL0C0HBa+NF9
 DNBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710864627; x=1711469427;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zm3U654Nut1+La4zI7uDUPRY05PZKgPmJr21URirjQg=;
 b=A8tktwZpLKAzuONwjW56cjqv/MfJY6a/LCf9isf2EcYofUM2/H2qJp0fO3zA6l1hez
 AzUY3JFy0MLSr4kL2y0nF/x7vPkORqukNg7phl3ApRHqbsk5nUyEbt+j+UetcygxzVwP
 8loI5Zc4x/uPH65eltJdqPnYxwPbOwNBknGVTpa62682dXu1+TXxTOK5nqXqvHR6sP3x
 iGQYGF3+p9yl8fj/1x5JrwkjSQjpiNOpLyZ1Pzgu/07r+7ziSxZST6wWgi0mWXtkeZO9
 3GodePmjPuajWkVP68urwLXvYXeKmjLzNYGwL6k7wufO536LT+0E2C5rtiHbb9CofQKR
 5qZw==
X-Gm-Message-State: AOJu0Yy7GmOsgGV/YAP4+M8Q6eVMwNg25C3X0sSbOSQoKWmu8Vpxve0g
 YkNj87usdxbeLn9jEdvJ8f2LyOFTthQuxMU+5WMQ37a1hPBGVa5T
X-Google-Smtp-Source: AGHT+IGjR9QJMiWs71wsytO4gPU2HOEVg/Jp1BYe7JTSo8GioCrBtK2rsJuvMI76EyKnpwmppQbCmg==
X-Received: by 2002:a2e:881a:0:b0:2d4:71b9:4e3 with SMTP id
 x26-20020a2e881a000000b002d471b904e3mr1981493ljh.51.1710864627104; 
 Tue, 19 Mar 2024 09:10:27 -0700 (PDT)
Received: from moskalets-nb.kdtln.ru (109-252-14-191.nat.spd-mgts.ru.
 [109.252.14.191]) by smtp.gmail.com with ESMTPSA id
 e7-20020a2eb1c7000000b002d45cf96cccsm1893961lja.44.2024.03.19.09.10.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 09:10:26 -0700 (PDT)
From: Maxim Moskalets <maximmosk4@gmail.com>
X-Google-Original-From: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
To: sjg@chromium.org, trini@konsulko.com, marek.vasut+renesas@mailbox.org,
 ralph.siemsen@linaro.org, xypron.glpk@gmx.de, mkorpershoek@baylibre.com,
 souajih@baylibre.com, takahiro.akashi@linaro.org, sean.anderson@seco.com
Cc: u-boot@lists.denx.de, Maxim.Moskalets@kaspersky.com,
 Maxim Moskalets <maximmosk4@gmail.com>
Subject: [PATCH] cmd: bootm: add ELF file support
Date: Tue, 19 Mar 2024 19:10:22 +0300
Message-Id: <20240319161022.41451-1-Maxim.Moskalets@kaspersky.com>
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

Some operating systems (e.g. seL4) and embedded applications are ELF
images. It is convenient to use FIT-images to implement trusted boot.
Added "elf" image type for booting using bootm command.

Signed-off-by: Maxim Moskalets <maximmosk4@gmail.com>
---
 boot/bootm_os.c  | 21 +++++++++++++++++++++
 boot/image-fit.c |  3 ++-
 boot/image.c     |  3 +++
 include/image.h  |  1 +
 4 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/boot/bootm_os.c b/boot/bootm_os.c
index ccde72d22c..71bfb34926 100644
--- a/boot/bootm_os.c
+++ b/boot/bootm_os.c
@@ -395,6 +395,24 @@ static int do_bootm_qnxelf(int flag, struct bootm_info *bmi)
 }
 #endif
 
+#if defined(CONFIG_CMD_ELF)
+static int do_bootm_elf(int flag, struct bootm_info *bmi)
+{
+	struct bootm_headers *images = bmi->images;
+	char *local_args[2] = {NULL};
+	char str[19] = ""; /* "0x" + 16 digits + "\0" */
+
+	sprintf(str, "0x%lx", images->ep); /* write entry-point into string */
+	str[18] = '\0';
+	local_args[0] = bmi->argv[0];
+	local_args[1] = str;	/* and provide it via the arguments */
+
+	do_bootelf(NULL, 0, 2, local_args);
+
+	return 1;
+}
+#endif
+
 #ifdef CONFIG_INTEGRITY
 static int do_bootm_integrity(int flag, struct bootm_info *bmi)
 {
@@ -536,6 +554,9 @@ static boot_os_fn *boot_os[] = {
 #ifdef CONFIG_BOOTM_EFI
 	[IH_OS_EFI] = do_bootm_efi,
 #endif
+#if defined(CONFIG_CMD_ELF)
+	[IH_OS_ELF] = do_bootm_elf,
+#endif
 };
 
 /* Allow for arch specific config before we boot */
diff --git a/boot/image-fit.c b/boot/image-fit.c
index 89e377563c..0419bef6d2 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2180,7 +2180,8 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 		fit_image_check_os(fit, noffset, IH_OS_TEE) ||
 		fit_image_check_os(fit, noffset, IH_OS_OPENRTOS) ||
 		fit_image_check_os(fit, noffset, IH_OS_EFI) ||
-		fit_image_check_os(fit, noffset, IH_OS_VXWORKS);
+		fit_image_check_os(fit, noffset, IH_OS_VXWORKS) ||
+		fit_image_check_os(fit, noffset, IH_OS_ELF);
 
 	/*
 	 * If either of the checks fail, we should report an error, but
diff --git a/boot/image.c b/boot/image.c
index 073931cd7a..5b88d6808c 100644
--- a/boot/image.c
+++ b/boot/image.c
@@ -134,6 +134,9 @@ static const table_entry_t uimage_os[] = {
 #endif
 	{	IH_OS_OPENSBI,	"opensbi",	"RISC-V OpenSBI",	},
 	{	IH_OS_EFI,	"efi",		"EFI Firmware" },
+#ifdef CONFIG_CMD_ELF
+	{	IH_OS_ELF,	"elf",		"ELF Image" },
+#endif
 
 	{	-1,		"",		"",			},
 };
diff --git a/include/image.h b/include/image.h
index 21de70f0c9..9a40bca22c 100644
--- a/include/image.h
+++ b/include/image.h
@@ -100,6 +100,7 @@ enum {
 	IH_OS_TEE,			/* Trusted Execution Environment */
 	IH_OS_OPENSBI,			/* RISC-V OpenSBI */
 	IH_OS_EFI,			/* EFI Firmware (e.g. GRUB2) */
+	IH_OS_ELF,			/* ELF Image (e.g. seL4) */
 
 	IH_OS_COUNT,
 };
-- 
2.39.2

