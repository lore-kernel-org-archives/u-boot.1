Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A06FC4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 03:01:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50FD087136;
	Mon, 13 Nov 2023 04:00:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="d+uV5qxC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EB1D8706F; Mon, 13 Nov 2023 04:00:17 +0100 (CET)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47D8987098
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 04:00:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-357c9dc1068so9851315ab.0
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 19:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699844413; x=1700449213; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QCoeL3LbXioZjp3qzHhh/BM5vl30TlS6dNOrGBKGidY=;
 b=d+uV5qxCrKHmHL5R13zjC4pI3MFtLbkaGqGc+iKqJIrZ8PVBPxRpyMX906ht/gIXo4
 0C4SQulmiasryrZBWWIpRoeazlPl0iTxX+Uz3c6IIqP68P69+XQoDSV7oykA3u9gHcvT
 Vm3pLMk8r0ed1P/y38VZA14K4kl3oT4DyfNxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699844413; x=1700449213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QCoeL3LbXioZjp3qzHhh/BM5vl30TlS6dNOrGBKGidY=;
 b=MHgbPy74Wg/rLDrbSGMCU/k8lzs0Kv7xqyw1T5W9n9ukMx4UFlqkO1IYmmAIViBbdr
 eKTmmh2l9zyhTL4+R5iDVhhqE/YXntma4AOVdTV7SZft1XjOLeLMzcpa/fmCCUMh9Fq9
 NGxxqTxanpWPbCxkEBV3bQ4crO45PXijvRkGV87ePH2DMhMoHR+e3ep6kHKR4LtjYlBI
 vq6JK6FYdriikKNGWUkQaJA0h6yMZt+nTKU/v41Z60QLNfBdx+u5YdEcVpBLaDbxtpnd
 0/VXCG0xQLBhT1CdF1gZp8xL5P/QeyxYPIffxmPfpPKIKiQK1Dq2Edsb/JgJ/aO0EdWE
 +aXQ==
X-Gm-Message-State: AOJu0YyRGdM8ufG1ctaEIowP9qmxkySp/yLeT3vmIfKPczRNO8YWW6VD
 OLSGtQCIOMv8pkRcX5v88ISWMAjmz1DRvXixBJfrsQ==
X-Google-Smtp-Source: AGHT+IE6bZzzg/V2pDJXUmGpNqIROfMY5WgjOU9v0ufhsseI3DTHrQ0vFfi3M7tEkGnbhttF8ZGFPQ==
X-Received: by 2002:a05:6e02:152f:b0:359:cc98:7516 with SMTP id
 i15-20020a056e02152f00b00359cc987516mr5086132ilu.0.1699844413349; 
 Sun, 12 Nov 2023 19:00:13 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 c16-20020a92cf50000000b0035134215863sm1350914ilr.55.2023.11.12.19.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 19:00:13 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Mike Frysinger <vapier@chromium.org>
Subject: [PATCH 9/9] x86: coreboot: Add a sysinfo driver
Date: Sun, 12 Nov 2023 19:58:29 -0700
Message-ID: <20231113030001.240020-10-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231113030001.240020-1-sjg@chromium.org>
References: <20231113030001.240020-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Create a sysinfo driver to avoid needing a custom checkboard()
function. With this the following information is printed when booting
from coreboot under QEMU:

   Model: Standard PC (i440FX + PIIX, 1996)
   Manufacturer: QEMU
   Prior-stage version: 4.21-885-g2a87ef1eca56
   Prior-stage date: 11/11/2023

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/cpu/coreboot/Kconfig      |  2 +
 arch/x86/dts/coreboot.dts          |  4 ++
 board/coreboot/coreboot/Makefile   |  1 +
 board/coreboot/coreboot/coreboot.c | 44 ---------------
 board/coreboot/coreboot/sysinfo.c  | 89 ++++++++++++++++++++++++++++++
 5 files changed, 96 insertions(+), 44 deletions(-)
 create mode 100644 board/coreboot/coreboot/sysinfo.c

diff --git a/arch/x86/cpu/coreboot/Kconfig b/arch/x86/cpu/coreboot/Kconfig
index 178f8ad18162..085302c04829 100644
--- a/arch/x86/cpu/coreboot/Kconfig
+++ b/arch/x86/cpu/coreboot/Kconfig
@@ -27,5 +27,7 @@ config SYS_COREBOOT
 	imply X86_TSC_READ_BASE
 	imply USE_PREBOOT
 	select BINMAN if X86_64
+	select SYSINFO
+	imply SYSINFO_EXTRA
 
 endif
diff --git a/arch/x86/dts/coreboot.dts b/arch/x86/dts/coreboot.dts
index 0eb31cae42c1..dfce7c2d5919 100644
--- a/arch/x86/dts/coreboot.dts
+++ b/arch/x86/dts/coreboot.dts
@@ -45,4 +45,8 @@
 		bootph-some-ram;
 		compatible = "coreboot-fb";
 	};
+
+	sysinfo {
+		compatible = "coreboot,sysinfo";
+	};
 };
diff --git a/board/coreboot/coreboot/Makefile b/board/coreboot/coreboot/Makefile
index d292b7032c23..75bfbd189437 100644
--- a/board/coreboot/coreboot/Makefile
+++ b/board/coreboot/coreboot/Makefile
@@ -11,3 +11,4 @@
 # Daniel Engström, Omicron Ceti AB, daniel@omicron.se.
 
 obj-y	+= coreboot.o
+obj-$(CONFIG_$(SPL_TPL_)SMBIOS_PARSER)	+= sysinfo.o
diff --git a/board/coreboot/coreboot/coreboot.c b/board/coreboot/coreboot/coreboot.c
index db855c11ae65..e58dce37477f 100644
--- a/board/coreboot/coreboot/coreboot.c
+++ b/board/coreboot/coreboot/coreboot.c
@@ -23,50 +23,6 @@ int board_early_init_r(void)
 	return 0;
 }
 
-#ifdef CONFIG_SMBIOS_PARSER
-int show_board_info(void)
-{
-	const struct smbios_entry *smbios = smbios_entry(lib_sysinfo.smbios_start, lib_sysinfo.smbios_size);
-
-	if (!smbios)
-		goto fallback;
-
-	const struct smbios_header *bios = smbios_header(smbios, SMBIOS_BIOS_INFORMATION);
-	const struct smbios_header *system = smbios_header(smbios, SMBIOS_SYSTEM_INFORMATION);
-	const struct smbios_type0 *t0 = (struct smbios_type0 *)bios;
-	const struct smbios_type1 *t1 = (struct smbios_type1 *)system;
-
-	if (!t0 || !t1)
-		goto fallback;
-
-	const char *bios_ver = smbios_string(bios, t0->bios_ver);
-	const char *bios_date = smbios_string(bios, t0->bios_release_date);
-	const char *model = smbios_string(system, t1->product_name);
-	const char *manufacturer = smbios_string(system, t1->manufacturer);
-
-	if (!model || !manufacturer || !bios_ver)
-		goto fallback;
-
-	printf("Vendor: %s\n", manufacturer);
-	printf("Model: %s\n", model);
-	printf("BIOS Version: %s\n", bios_ver);
-	if (bios_date)
-		printf("BIOS date: %s\n", bios_date);
-
-	return 0;
-
-fallback:
-	if (IS_ENABLED(CONFIG_OF_CONTROL)) {
-		model = fdt_getprop(gd->fdt_blob, 0, "model", NULL);
-
-		if (model)
-			printf("Model: %s\n", model);
-	}
-
-	return checkboard();
-}
-#endif
-
 static struct splash_location coreboot_splash_locations[] = {
 	{
 		.name = "virtio_fs",
diff --git a/board/coreboot/coreboot/sysinfo.c b/board/coreboot/coreboot/sysinfo.c
new file mode 100644
index 000000000000..e0bdc7a5a88e
--- /dev/null
+++ b/board/coreboot/coreboot/sysinfo.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * coreboot sysinfo driver
+ *
+ * Copyright 2023 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#include <dm.h>
+#include <smbios.h>
+#include <sysinfo.h>
+#include <asm/cb_sysinfo.h>
+
+struct cb_sysinfo_priv {
+	const struct smbios_header *bios;
+	const struct smbios_header *system;
+	const struct smbios_type0 *t0;
+	const struct smbios_type1 *t1;
+};
+
+static int cb_get_str(struct udevice *dev, int id, size_t size, char *val)
+{
+	struct cb_sysinfo_priv *priv = dev_get_priv(dev);
+	const char *str = NULL;
+
+	switch (id) {
+	case SYSINFO_ID_BOARD_MODEL:
+		if (priv->t1)
+			str = smbios_string(priv->system,
+					    priv->t1->product_name);
+		break;
+	case SYSINFO_ID_BOARD_MANUFACTURER:
+		if (priv->t1)
+			str = smbios_string(priv->system,
+					    priv->t1->manufacturer);
+		break;
+	case SYSINFO_ID_PRIOR_STAGE_VERSION:
+		if (priv->t0)
+			str = smbios_string(priv->bios, priv->t0->bios_ver);
+		break;
+	case SYSINFO_ID_PRIOR_STAGE_DATE:
+		if (priv->t0)
+			str = smbios_string(priv->bios,
+					    priv->t0->bios_release_date);
+		break;
+	}
+	if (!str)
+		return -ENOTSUPP;
+
+	strlcpy(val, str, size);
+
+	return  0;
+}
+
+static int cb_detect(struct udevice *dev)
+{
+	struct cb_sysinfo_priv *priv = dev_get_priv(dev);
+	const struct smbios_entry *smbios;
+
+	smbios = smbios_entry(lib_sysinfo.smbios_start,
+			      lib_sysinfo.smbios_size);
+	if (!smbios)
+		return 0;
+
+	priv->bios = smbios_header(smbios, SMBIOS_BIOS_INFORMATION);
+	priv->system = smbios_header(smbios, SMBIOS_SYSTEM_INFORMATION);
+	priv->t0 = (struct smbios_type0 *)priv->bios;
+	priv->t1 = (struct smbios_type1 *)priv->system;
+
+	return 0;
+}
+
+static const struct udevice_id sysinfo_coreboot_ids[] = {
+	{ .compatible = "coreboot,sysinfo" },
+	{ /* sentinel */ }
+};
+
+static const struct sysinfo_ops sysinfo_coreboot_ops = {
+	.detect		= cb_detect,
+	.get_str	= cb_get_str,
+};
+
+U_BOOT_DRIVER(sysinfo_coreboot) = {
+	.name           = "sysinfo_coreboot",
+	.id             = UCLASS_SYSINFO,
+	.of_match       = sysinfo_coreboot_ids,
+	.ops		= &sysinfo_coreboot_ops,
+	.priv_auto	= sizeof(struct cb_sysinfo_priv),
+};
-- 
2.42.0.869.gea05f2083d-goog

