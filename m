Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 018B9CD129D
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 08:32:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4992E88344;
	Thu, 11 Apr 2024 10:32:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FPrVKPot";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4269787FA0; Thu, 11 Apr 2024 10:32:09 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4808188319
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 10:32:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maximmosk4@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-516a01c8490so439580e87.1
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 01:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712824326; x=1713429126; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=a0RsAWqVfLBrh8MbUhrtAj4WDFa/8zx7Tjc1FdXbimE=;
 b=FPrVKPotQd88EtMNWbycCBlS5/exbd9o19a4JBEJMu5vxSLiRuwP9ZlRRZVfiqhwSV
 zlQJIqU5QeWvuC+bW63fxXegimZ0ZlGZ3Yu0mmq0NLW5c/s6vGEAjkiT65lmUxhfNiBZ
 rhzd/wrZCHKd4t06T3Lh2Xzvb1DkEjPoVl91sb5qrlxXhk9mOmo0WYI9s68eS0TlRjgu
 Z4/JQQpAvEb7Vp2eaZErVSPR9JMCuWlbE0YDgrtGgUDzhLP/dZcFGqTTmbbVyYTsbW7T
 1G7cutIaz+7iB8L+KU0IUQh3QA+C42H/KkWkBcH/W6hxyCOME1MXhYdnLK+jup4TD+zn
 S0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712824326; x=1713429126;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a0RsAWqVfLBrh8MbUhrtAj4WDFa/8zx7Tjc1FdXbimE=;
 b=mAzjVRa0+sxMmXNMptN62nUcdYvUIa4TQu0K8sC58LbKGUnPQ8W/aOqmDS6aYdNRm7
 COo2MOBixgKdj9uoP90DDRBYsYg5q2xyZdZ9AdLalAMEiY+Ht9Db2YRY88nxthi/pheP
 IBZiCGZ9QOMjBXS6TK0GmOhXFM0wG6n9Yh3ZijPqTcdBf+PHK/JPEos2ppTjdZHN+mCv
 jECcWdRN6faYv5yl27cGR5m3CTLg8mgGP7cO5pYOWbfGTjw1Wkwipm5vpDWNLpsPqegH
 jYuUPInoZwtFEZVRv++R4CWXxVKtPESaDWWwiXnHNBpAgRQWFAswwjkSBC7S0HqravOS
 Wrxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJWWj/7UiUqmeJ3E89Qu5T7Y6PmSWgltBrlFOvWzxMWejekapMdw9fGSNw9e2GVm+E+8ybvgqdqltzY0QbE+JVZ+Qd0g==
X-Gm-Message-State: AOJu0YwbTNTM1mcFGh+Yq7db3WgxFnk0mTvAgNLemHr8WbOeEHXoE4jO
 SigI8gcjx0ZKM6K6CxdmUwy0I13RNlRtGBfxaajuVr6PAvZAHjt/
X-Google-Smtp-Source: AGHT+IFlCb6XRzp7h/IE7BpdafUhx/3q2f9o5jEqz/iN/OVnLl4XJOxGVEP6PnYl1BanVMO1juRvGg==
X-Received: by 2002:ac2:5619:0:b0:513:e1b6:40b9 with SMTP id
 v25-20020ac25619000000b00513e1b640b9mr608558lfd.28.1712824326276; 
 Thu, 11 Apr 2024 01:32:06 -0700 (PDT)
Received: from moskalets-nb.avp.ru ([2a00:1fa0:4110:4a8c:111a:1a9f:9667:892b])
 by smtp.gmail.com with ESMTPSA id
 q6-20020ac25106000000b00516d282df53sm143288lfb.253.2024.04.11.01.32.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Apr 2024 01:32:05 -0700 (PDT)
From: Maxim Moskalets <maximmosk4@gmail.com>
X-Google-Original-From: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
To: marek.vasut+renesas@mailbox.org, mkorpershoek@baylibre.com,
 ralph.siemsen@linaro.org, sean.anderson@seco.com, sjg@chromium.org,
 souajih@baylibre.com, takahiro.akashi@linaro.org, trini@konsulko.com,
 u-boot@lists.denx.de, xypron.glpk@gmx.de,
 quentin.schulz@theobroma-systems.com
Cc: maximmosk4@gmail.com,
	Maxim.Moskalets@kaspersky.com
Subject: [PATCH v3] cmd: bootm: add ELF file support
Date: Thu, 11 Apr 2024 11:32:02 +0300
Message-Id: <20240411083202.20730-1-Maxim.Moskalets@kaspersky.com>
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

Some operating systems (e.g. seL4) and embedded applications are ELF
images. It is convenient to use FIT-images to implement trusted boot.
Added "elf" image type for booting using bootm command.

Signed-off-by: Maxim Moskalets <maximmosk4@gmail.com>
---
 boot/bootm_os.c  | 24 ++++++++++++++++++++++++
 boot/image-fit.c |  3 ++-
 boot/image.c     |  3 +++
 include/image.h  |  1 +
 4 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/boot/bootm_os.c b/boot/bootm_os.c
index ccde72d22c..1c92b8149c 100644
--- a/boot/bootm_os.c
+++ b/boot/bootm_os.c
@@ -395,6 +395,27 @@ static int do_bootm_qnxelf(int flag, struct bootm_info *bmi)
 }
 #endif
 
+#if defined(CONFIG_CMD_ELF)
+static int do_bootm_elf(int flag, struct bootm_info *bmi)
+{
+	struct bootm_headers *images = bmi->images;
+	char *local_args[2] = {NULL};
+	char str[19] = ""; /* "0x" + 16 digits + "\0" */
+
+	if (flag != BOOTM_STATE_OS_GO)
+		return 0;
+
+	snprintf(str, sizeof str, "0x%lx", images->ep); /* write entry-point into string */
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
@@ -536,6 +557,9 @@ static boot_os_fn *boot_os[] = {
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

