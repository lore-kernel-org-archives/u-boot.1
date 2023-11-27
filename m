Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B63CAC4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 19:56:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88B39877FB;
	Mon, 27 Nov 2023 20:53:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qKMdTF83";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAC3C87811; Mon, 27 Nov 2023 20:53:37 +0100 (CET)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F68D8780F
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 20:53:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-58d4968c362so1640734eaf.0
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 11:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701114814; x=1701719614; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CBVDXuKsrzfIj7cbbHSPnzacQxJq7O9nr7ZFwYpRu40=;
 b=qKMdTF83E9PNb0SkcOzblB8z6SAMhIn+MckbYwYctlgU3JVbr8xeFjzqV+cybCpjGM
 9sVQGAqX6Mr5jFrumzKkiN6uDk0RpnBO2dFvg6BDcN/K1/h06kwTdI3JmyHARWltM2s4
 8vPE+jnUeLSgPPLnEOzMIR6ez+l6xMCPeHxfT2/C6WbONWzNlukDc9Zf4siwybhUVXZ+
 MTYC9uBBXolKh3Qy4+8Gg/TX2PQZp+BalYhdfFlT4HSkE1Kv6RqEHrTMFM+qVxPUzsjG
 uPx14bBsT/Cc527GCBhNkLj/nT9Eg/hYevS95bmw9BVqu9YPHfdfIcsKNY8A4lQx+aqj
 DJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701114814; x=1701719614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CBVDXuKsrzfIj7cbbHSPnzacQxJq7O9nr7ZFwYpRu40=;
 b=sbd9UJj4nI2MsayWRCP2wSeeS+wCdDY4bnb+8W7sVUpV9TTlZc6OBEkg02So0RW9Yy
 e+NCzuXwiauqv0QFbKGq9FOeTaL19/8MupTr1Z5pKCb0/5GFYl4TS4zVzk9ScM7Y4pLe
 uqeVIk4WhYg8KUHqZ1SfXQAYkEf2m8HhQP6AoBEV6R+1Ohe+c/Ku1Jzoku2Y8Lawaj2s
 Y/DknkiiFNTX2b2xubWklywKgjGHswiJZerbzdpOZbKHy2MgjKt6KP0RqjMszuFfQRjT
 ZFkODXWTkgPBmsF6jOxu7IvEPvgelc/AmbSywAQe26dp3vxdhNazmuPi+OtQpRdqg89i
 cyVQ==
X-Gm-Message-State: AOJu0YwA195II1Jq299mfnTeyqFQG9eu47Cwb9GW7I7blGhGWUMmNAR2
 uPYfzCM2rvQud1nB+UfH+39Dzg79IMR7k73jM2o=
X-Google-Smtp-Source: AGHT+IEd/XvY2N1RsLb5oPLAQm/4wi1Q/2JSYweA2mjGuJXF2AhKgVANF2SEOKDv8yLkVhijPrNynw==
X-Received: by 2002:a05:6359:2e17:b0:16e:29cf:4e57 with SMTP id
 ro23-20020a0563592e1700b0016e29cf4e57mr7534989rwb.29.1701114814026; 
 Mon, 27 Nov 2023 11:53:34 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 g6-20020ad45106000000b0067a2061fc21sm3087047qvp.101.2023.11.27.11.53.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 11:53:33 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de,
	ilias.apalodimas@linaro.org,
	sjg@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Nikhil M Jain <n-jain1@ti.com>,
 Baruch Siach <baruch@tkos.co.il>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 17/18] qemu-arm: Get bloblist from boot arguments
Date: Mon, 27 Nov 2023 11:50:28 -0800
Message-Id: <20231127195029.90951-18-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231127195029.90951-1-raymond.mao@linaro.org>
References: <20231127195029.90951-1-raymond.mao@linaro.org>
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
Changes in v2
- New patch file created for v2.

 board/emulation/qemu-arm/Makefile        |  1 +
 board/emulation/qemu-arm/lowlevel_init.S | 19 +++++++++
 board/emulation/qemu-arm/qemu-arm.c      | 54 ++++++++++++++++++++++++
 configs/qemu_arm64_defconfig             |  3 ++
 configs/qemu_arm_defconfig               |  3 ++
 5 files changed, 80 insertions(+)
 create mode 100644 board/emulation/qemu-arm/lowlevel_init.S

diff --git a/board/emulation/qemu-arm/Makefile b/board/emulation/qemu-arm/Makefile
index a22d1237ff..12821e7083 100644
--- a/board/emulation/qemu-arm/Makefile
+++ b/board/emulation/qemu-arm/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0+
 
 obj-y	+= qemu-arm.o
+obj-$(CONFIG_OF_BOARD)	+= lowlevel_init.o
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
index 942f1fff57..a3892630d8 100644
--- a/board/emulation/qemu-arm/qemu-arm.c
+++ b/board/emulation/qemu-arm/qemu-arm.c
@@ -4,6 +4,9 @@
  */
 
 #include <common.h>
+#if IS_ENABLED(CONFIG_OF_BOARD) && IS_ENABLED(CONFIG_BLOBLIST)
+#include <bloblist.h>
+#endif
 #include <cpu_func.h>
 #include <dm.h>
 #include <efi.h>
@@ -102,6 +105,16 @@ static struct mm_region qemu_arm64_mem_map[] = {
 struct mm_region *mem_map = qemu_arm64_mem_map;
 #endif
 
+#if IS_ENABLED(CONFIG_OF_BOARD)
+/* Boot parameters saved from lowlevel_init.S */
+struct {
+	unsigned long arg0;
+	unsigned long arg1;
+	unsigned long arg2;
+	unsigned long arg3;
+} qemu_saved_args __section(".data");
+#endif
+
 int board_init(void)
 {
 	return 0;
@@ -144,6 +157,47 @@ void *board_fdt_blob_setup(int *err)
 	return (void *)CFG_SYS_SDRAM_BASE;
 }
 
+int board_bloblist_from_boot_arg(unsigned long __maybe_unused addr,
+				 unsigned long __maybe_unused size)
+{
+	int ret = -ENOENT;
+
+#if IS_ENABLED(CONFIG_OF_BOARD) && IS_ENABLED(CONFIG_BLOBLIST)
+	unsigned long fdt;
+
+	ret = bloblist_check(qemu_saved_args.arg3, 0);
+	if (ret)
+		return ret;
+
+	bloblist_show_stats();
+	bloblist_show_list();
+	if (gd->bloblist->total_size > size) {
+		gd->bloblist = NULL; /* Reset the gd bloblist pointer */
+		log_err("Bloblist total size:%d, board reserved size:%ld\n",
+			gd->bloblist->total_size, size);
+		return -ENOSPC;
+	}
+
+	/* Check the register conventions */
+	fdt = (unsigned long)bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
+	if (IS_ENABLED(CONFIG_ARM64)) {
+		if (fdt != qemu_saved_args.arg0 || qemu_saved_args.arg2 != 0)
+			ret = -EIO;
+	} else {
+		if (fdt != qemu_saved_args.arg2 || qemu_saved_args.arg0 != 0)
+			ret = -EIO;
+	}
+
+	if (ret)
+		gd->bloblist = NULL;  /* Reset the gd bloblist pointer */
+	else
+		memmove((void *)addr,  (void *)qemu_saved_args.arg3,
+			gd->bloblist->total_size);
+#endif
+
+	return ret;
+}
+
 void enable_caches(void)
 {
 	 icache_enable();
diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
index 5fdf496a45..60fabb5db7 100644
--- a/configs/qemu_arm64_defconfig
+++ b/configs/qemu_arm64_defconfig
@@ -71,3 +71,6 @@ CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_PCI=y
 CONFIG_SEMIHOSTING=y
 CONFIG_TPM=y
+CONFIG_BLOBLIST=y
+CONFIG_BLOBLIST_ADDR=0x40004000
+CONFIG_BLOBLIST_SIZE=0x4000
diff --git a/configs/qemu_arm_defconfig b/configs/qemu_arm_defconfig
index 1347b86f34..d8a94ad038 100644
--- a/configs/qemu_arm_defconfig
+++ b/configs/qemu_arm_defconfig
@@ -71,3 +71,6 @@ CONFIG_TPM2_MMIO=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_PCI=y
 CONFIG_TPM=y
+CONFIG_BLOBLIST=y
+CONFIG_BLOBLIST_ADDR=0x40004000
+CONFIG_BLOBLIST_SIZE=0x4000
-- 
2.25.1

