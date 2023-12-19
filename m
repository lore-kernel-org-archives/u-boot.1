Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F55C46CA2
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 21:11:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 042908753C;
	Tue, 19 Dec 2023 22:11:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jJX1lIZb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 656C1875FC; Tue, 19 Dec 2023 22:11:48 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E050874B7
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 22:11:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3b9db318839so3368471b6e.3
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 13:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703020304; x=1703625104; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wBDau9BdgjGKOalgA2memy/ZBR/c7bmZObWj07OZw4A=;
 b=jJX1lIZbHXhtizlpNKzrMEZtLntR1xE05lIBOyEJLwt+7mb9cwY7NVr8pSi7V4HCJL
 4vkns4HwOv5U5CDlYh0r4vcZvudIijW/tvoe7qyRwntT2zWjCqckFDQuoSmLrcoJmeuE
 Ef+hnDiUFhVCGZ82TsFETKRalIJcMkF5/NqhxBw1Utu2tzJ1NQgkrLyBb94QOvMzFGS3
 WpT8iofY5akisxSGWh9+vkhUtijQWyqdNxxPh57JloeaQOeMZP/D4YjvTfd6iLQ6EyXP
 hHsWgMER8OK/V5+7iyiGo7JxN3ZaC5LcB/frdn1mzNAb9emj4OHayVNXk1MnNXvuc/x5
 QVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703020304; x=1703625104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wBDau9BdgjGKOalgA2memy/ZBR/c7bmZObWj07OZw4A=;
 b=SGDgMZJypZae6QFC+MEzLEi1y0pFSaA+lenfcMfcpVIXW5j7YEyz7l+zayjQLlGw2k
 MfF7gOkv45TkWoFZYtmtHhpbBcUD3VtrP7qJJVEnQQS7AMj+YefB9FyCaJYNluWsDAGw
 Z4zUS8xSfQbPv4kELuuQ12Bq0mJpJ9jQNyz6CSbLZF8SrRm6HfCKmWykxMvIk7hhcX2R
 Jpq/b7uEkCT92/nGSPnsYU5sqcbww5mRPebPKg0Yast63pC1x719i0/5A/Zn993kouvo
 JwkSHSAlEv3m6rtNo8K4NBTW121SlBkaWmwgVIwBj0uu19AoC1GoPOfvwGIEiFZ0jgMq
 6cVw==
X-Gm-Message-State: AOJu0YyItkqmT8Sb4dDXkRpVgGgITUm41eAOAviDB9dQFkGcGSqVlnfJ
 MTNG2x9gq2X6ArJO3+MtkZvZiG5IxPzwvze6LT4=
X-Google-Smtp-Source: AGHT+IE4pCRccBOEcN+oHpHTDA8uw/oebm4GsjSiQaIZ4OCpTNWnCFORtXEYzFwdtbedYs43c6zRNA==
X-Received: by 2002:a05:6808:2111:b0:3b8:b063:6650 with SMTP id
 r17-20020a056808211100b003b8b0636650mr19340667oiw.71.1703020304499; 
 Tue, 19 Dec 2023 13:11:44 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 i14-20020a0cf38e000000b0067a33133420sm10709493qvk.110.2023.12.19.13.11.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 13:11:43 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Nikhil M Jain <n-jain1@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Baruch Siach <baruch@tkos.co.il>, Michal Simek <michal.simek@amd.com>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 2/5] qemu-arm: Get bloblist from boot arguments
Date: Tue, 19 Dec 2023 13:11:09 -0800
Message-Id: <20231219211114.393193-3-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231219211114.393193-1-raymond.mao@linaro.org>
References: <20231219211114.393193-1-raymond.mao@linaro.org>
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

Add platform custom function to get bloblist from boot arguments.
Check whether boot arguments aligns with the register conventions
defined in FW Handoff spec v0.9.
Add bloblist related options into qemu default config.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 board/emulation/qemu-arm/Makefile        |  1 +
 board/emulation/qemu-arm/lowlevel_init.S | 19 +++++++++
 board/emulation/qemu-arm/qemu-arm.c      | 51 ++++++++++++++++++++++++
 configs/qemu_arm64_defconfig             |  3 ++
 4 files changed, 74 insertions(+)
 create mode 100644 board/emulation/qemu-arm/lowlevel_init.S

diff --git a/board/emulation/qemu-arm/Makefile b/board/emulation/qemu-arm/Makefile
index a22d1237ff..0eb262e4e2 100644
--- a/board/emulation/qemu-arm/Makefile
+++ b/board/emulation/qemu-arm/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0+
 
 obj-y	+= qemu-arm.o
+obj-y	+= lowlevel_init.o
diff --git a/board/emulation/qemu-arm/lowlevel_init.S b/board/emulation/qemu-arm/lowlevel_init.S
new file mode 100644
index 0000000000..d72d7c938a
--- /dev/null
+++ b/board/emulation/qemu-arm/lowlevel_init.S
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: BSD-2-Clause */
+/*
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#include <config.h>
+
+.global save_boot_params
+save_boot_params:
+#ifdef CONFIG_ARM64
+	adr x9, qemu_saved_args
+	stp x0, x1, [x9]
+	/* Increment the address by 16 bytes for the next pair of values */
+	stp x2, x3, [x9, #16]
+#else
+	ldr r12, =qemu_saved_args
+	stm r12, {r0, r1, r2, r3}
+#endif
+	b	save_boot_params_ret
diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu-arm/qemu-arm.c
index 942f1fff57..72e0a97567 100644
--- a/board/emulation/qemu-arm/qemu-arm.c
+++ b/board/emulation/qemu-arm/qemu-arm.c
@@ -4,6 +4,7 @@
  */
 
 #include <common.h>
+#include <bloblist.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <efi.h>
@@ -102,6 +103,14 @@ static struct mm_region qemu_arm64_mem_map[] = {
 struct mm_region *mem_map = qemu_arm64_mem_map;
 #endif
 
+/* Boot parameters saved from lowlevel_init.S */
+struct {
+	unsigned long arg0;
+	unsigned long arg1;
+	unsigned long arg2;
+	unsigned long arg3;
+} qemu_saved_args __section(".data");
+
 int board_init(void)
 {
 	return 0;
@@ -144,6 +153,48 @@ void *board_fdt_blob_setup(int *err)
 	return (void *)CFG_SYS_SDRAM_BASE;
 }
 
+int board_bloblist_from_boot_arg(unsigned long addr, unsigned long size)
+{
+	int ret = -ENOENT;
+	unsigned long reg_fdt;
+	unsigned long reg_zero;
+
+	if (!IS_ENABLED(CONFIG_OF_BOARD) || !IS_ENABLED(CONFIG_BLOBLIST))
+		return -ENOENT;
+
+	ret = bloblist_check(qemu_saved_args.arg3, 0);
+	if (ret)
+		return ret;
+
+	if (gd->bloblist->total_size > size) {
+		gd->bloblist = NULL; /* Reset the gd bloblist pointer */
+		log_err("Board bloblist total size:%d, reserved size:%ld\n",
+			gd->bloblist->total_size, size);
+		return -ENOSPC;
+	}
+
+	if (IS_ENABLED(CONFIG_ARM64)) {
+		reg_fdt = qemu_saved_args.arg0;
+		reg_zero = qemu_saved_args.arg2;
+	} else {
+		reg_fdt = qemu_saved_args.arg2;
+		reg_zero = qemu_saved_args.arg0;
+	}
+	/* Check the register conventions */
+	ret = bloblist_check_reg_conv(reg_fdt, reg_zero);
+
+	if (ret) {
+		gd->bloblist = NULL;  /* Reset the gd bloblist pointer */
+	} else {
+		/* Relocate the bloblist to the fixed address */
+		bloblist_reloc((void *)addr, gd->bloblist->total_size,
+			       gd->bloblist, gd->bloblist->total_size);
+		gd->bloblist = (struct bloblist_hdr *)addr;
+	}
+
+	return ret;
+}
+
 void enable_caches(void)
 {
 	 icache_enable();
diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
index c010c25a92..418f48001c 100644
--- a/configs/qemu_arm64_defconfig
+++ b/configs/qemu_arm64_defconfig
@@ -69,3 +69,6 @@ CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_PCI=y
 CONFIG_SEMIHOSTING=y
 CONFIG_TPM=y
+CONFIG_BLOBLIST=y
+CONFIG_BLOBLIST_ADDR=0x40004000
+CONFIG_BLOBLIST_SIZE=0x4000
-- 
2.25.1

