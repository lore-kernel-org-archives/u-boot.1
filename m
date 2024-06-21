Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7066C2BA1A
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 11:42:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 899A8880A3;
	Fri, 21 Jun 2024 13:42:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h8YDFyG1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 191CF881B8; Fri, 21 Jun 2024 13:42:16 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2106A831A1
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 13:42:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maximmosk4@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-52cdb9526e2so91052e87.0
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 04:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718970133; x=1719574933; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ylrmlyqzqJIfII0LW2DJBwwYrgrYDNH4mEWMQZAjRok=;
 b=h8YDFyG1P/xSZ5qXp1V9CEVXo1cxTNyNDnn1w3+PtZLhyoc8T5dlUkm9iOgo2wFQuE
 sPBkxcMEozrviEKjgAsH0Gh9a+iCyb9Zkrd9r8t3VKLs+rkXxoXbiLGtV6nt4rCZYVfU
 e4BMgwuGg5VCrTSb0Z52oY0DdsvfouySRLlczxzFTIhLz5E4eHBuiykiwlqkLik8FjDW
 jVj6JsYTWRk8D/uY83KUHbo0UX83/NYhWfI5rSYXQ/GCXWH6QNaeVDXwhK7BZdVOV2xZ
 UB+RCEjvslW6zF4+2SK+Q2RV3cO6S0/mhuSTS9HIVQ4CXFVN1nc6RlZLusZiipgRjQ3L
 3Q1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718970133; x=1719574933;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ylrmlyqzqJIfII0LW2DJBwwYrgrYDNH4mEWMQZAjRok=;
 b=Tk2gY7PyMeSyGNTQweyMn4FRGt98zhCxPDfPC5YHoTrhVuCEOawfbg0dArjl/TBWnO
 4OvtAD5IHbMdGxSPMsaHR9EzcyeKvUBUDVWtwG0Ouz7RzG9SojoMRF28sZlFen+uAwkb
 02C6/etW2uCieoVSgPUyckD7NHFYwjluyA7ycbWHEQm+HYeEukBuhX6Ob3k3hBmKcCGg
 6VFPQ5+olAJ6+nDYGxYuywbkJb4l/kjAfYyuzqlJzB9+Jo62fYCr8EYHRI24zS6kdyZi
 NHLbb1YUPN+iHVMPP81dSYMNYKYeGelW16s94TJIQiABC8aGTOyyGu8rf0yKjDQx1WMg
 uAKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtHtb257CvPQOtLMPlZGUjjo10zOVzpxXbwXLw+AALo5NHDwy2lKvrNhW4YJvNIvyGlsdQoAnta3z/WVXw6LtGwAXd8Q==
X-Gm-Message-State: AOJu0Yy8ywVSnEepwYX6sRyy2nE/6PwsWD3rOU6oafQPZ1gLN8eRLidC
 VS01+C3+jt+Igf2qJE2wKimwDtIPxPOTYm3BiLhKwRldbwzrZfaf
X-Google-Smtp-Source: AGHT+IEsojluf8i9Sp+C/I4/mkG9xB1fW1odMreAZOSvYkcdGhJWImRfxbEuBjEmQwmJ1lH7/wsWjg==
X-Received: by 2002:ac2:5f74:0:b0:52c:d5a8:496 with SMTP id
 2adb3069b0e04-52cd5a804e4mr468724e87.22.1718970133034; 
 Fri, 21 Jun 2024 04:42:13 -0700 (PDT)
Received: from moskalets-nb.avp.ru ([2a00:1fa0:4872:4ca1:cfd:f272:7a93:c94d])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-52cd64203a8sm177091e87.157.2024.06.21.04.42.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 04:42:12 -0700 (PDT)
From: Maxim Moskalets <maximmosk4@gmail.com>
X-Google-Original-From: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
To: quentin.schulz@theobroma-systems.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.denx.de, xypron.glpk@gmx.de
Cc: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>,
 Maxim Moskalets <maximmosk4@gmail.com>
Subject: [PATCH v5] cmd: bootm: add ELF file support
Date: Fri, 21 Jun 2024 14:42:10 +0300
Message-Id: <20240621114210.51101-1-Maxim.Moskalets@kaspersky.com>
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
v5:
	used func from lib/elf.c to avoid dependency form CLI
---
 boot/bootm_os.c  | 18 ++++++++++++++++++
 boot/image-fit.c |  3 ++-
 boot/image.c     |  5 ++++-
 cmd/Kconfig      |  7 +++++++
 include/image.h  |  1 +
 5 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/boot/bootm_os.c b/boot/bootm_os.c
index 15297ddb53..6a6621706f 100644
--- a/boot/bootm_os.c
+++ b/boot/bootm_os.c
@@ -8,6 +8,7 @@
 #include <bootstage.h>
 #include <cpu_func.h>
 #include <efi_loader.h>
+#include <elf.h>
 #include <env.h>
 #include <fdt_support.h>
 #include <image.h>
@@ -394,6 +395,20 @@ static int do_bootm_qnxelf(int flag, struct bootm_info *bmi)
 }
 #endif
 
+#if defined(CONFIG_BOOTM_ELF)
+static int do_bootm_elf(int flag, struct bootm_info *bmi)
+{
+	Bootelf_flags flags = { .autostart = 1 };
+
+	if (flag != BOOTM_STATE_OS_GO)
+		return 0;
+
+	bootelf(bmi->images->ep, flags, 0, NULL);
+
+	return 1;
+}
+#endif
+
 #ifdef CONFIG_INTEGRITY
 static int do_bootm_integrity(int flag, struct bootm_info *bmi)
 {
@@ -535,6 +550,9 @@ static boot_os_fn *boot_os[] = {
 #ifdef CONFIG_BOOTM_EFI
 	[IH_OS_EFI] = do_bootm_efi,
 #endif
+#if defined(CONFIG_BOOTM_ELF)
+	[IH_OS_ELF] = do_bootm_elf,
+#endif
 };
 
 /* Allow for arch specific config before we boot */
diff --git a/boot/image-fit.c b/boot/image-fit.c
index f6464bcf62..9253f81fff 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2175,7 +2175,8 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 		fit_image_check_os(fit, noffset, IH_OS_TEE) ||
 		fit_image_check_os(fit, noffset, IH_OS_OPENRTOS) ||
 		fit_image_check_os(fit, noffset, IH_OS_EFI) ||
-		fit_image_check_os(fit, noffset, IH_OS_VXWORKS);
+		fit_image_check_os(fit, noffset, IH_OS_VXWORKS) ||
+		fit_image_check_os(fit, noffset, IH_OS_ELF);
 
 	/*
 	 * If either of the checks fail, we should report an error, but
diff --git a/boot/image.c b/boot/image.c
index fc774d605d..abac254e02 100644
--- a/boot/image.c
+++ b/boot/image.c
@@ -130,7 +130,10 @@ static const table_entry_t uimage_os[] = {
 	{	IH_OS_OPENRTOS,	"openrtos",	"OpenRTOS",		},
 #endif
 	{	IH_OS_OPENSBI,	"opensbi",	"RISC-V OpenSBI",	},
-	{	IH_OS_EFI,	"efi",		"EFI Firmware" },
+	{	IH_OS_EFI,	"efi",		"EFI Firmware"		},
+#ifdef CONFIG_BOOTM_ELF
+	{	IH_OS_ELF,	"elf",		"ELF Image"		},
+#endif
 
 	{	-1,		"",		"",			},
 };
diff --git a/cmd/Kconfig b/cmd/Kconfig
index a2dee34689..613baa106e 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -321,6 +321,13 @@ config BOOTM_EFI
 	help
 	  Support booting UEFI FIT images via the bootm command.
 
+config BOOTM_ELF
+	bool "Support booting ELF images"
+	depends on CMD_BOOTM && LIB_ELF
+	default n
+	help
+	  Support booting ELF images via the bootm command.
+
 config CMD_BOOTZ
 	bool "bootz"
 	help
diff --git a/include/image.h b/include/image.h
index c5b288f62b..9daaee15cd 100644
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

