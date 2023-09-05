Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C52D9C71153
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 01:13:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9AC18653D;
	Tue,  5 Sep 2023 03:12:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qyjJ9bAb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F5818071F; Tue,  5 Sep 2023 03:12:51 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DE4E8071F
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 03:12:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-59205f26e47so17907607b3.2
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 18:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693876364; x=1694481164; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qnjbsZiNNFIqVuhJA3F++9REfDzX2v7mcEGZ2geYleQ=;
 b=qyjJ9bAbXRgaZn9dqrWdGYlrkCOyZ6hArq2oczs3kE5kzux6naddVaO7AbE0frQ9Iz
 RDWzjgSEL+/wozlJX/YacZqmWbHyiDM29a/JMgYV/ENslodUEjMKB26+ewgLB+vnsFAy
 sVkGGSYjc9ec3L6XmqNKyDFYI1jRetlcyOZHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693876364; x=1694481164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qnjbsZiNNFIqVuhJA3F++9REfDzX2v7mcEGZ2geYleQ=;
 b=jHarUIC1/MBU+B/obQTIx1YsB9w6gdXPD2d1DP633YudZhzFM/lkXEv41C6durbuvW
 tVg0QQpqirrReVKgdxjln5NiufiCZFKNLmIi4cssKcj2oE26AU6sVqKkB+zwvGUMy0Kg
 nSn1WoGronhlqo3y2tWgxnAEGqqCAcSNu9kbPORW0jFS8ADa/V4PSNx/CUbUqAPChcDv
 JWOXFH6ZjbljAZS5MrW9aAnQYGbFxb0ulWnTnEr9TftvaVVWWnOM8fK2JcIDS/bPdIUW
 deyKwXSaH+NQ8JPK59emVMGJiTeqxcFJdVhTDmk6+wIiexCH/EZ+mFLyUSaUYa8wcBAH
 fbFw==
X-Gm-Message-State: AOJu0Ywn060jhUIGkJgVuBDPKCaUFn6roEwZKqufM2WhsIAy0msGR/DV
 i55gCA01+5tpoG7neDpeHU2FTYTqzAFsiHq87RT8QA==
X-Google-Smtp-Source: AGHT+IGxI9US55sscpEQSpjwKCHS9bR3YQum++lV+Qwl0APGVGFJzIZz8lAafmaMoxmmFMat/XAOTA==
X-Received: by 2002:a81:af06:0:b0:59a:4898:8e13 with SMTP id
 n6-20020a81af06000000b0059a48988e13mr6951545ywh.16.1693876363298; 
 Mon, 04 Sep 2023 18:12:43 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-51ef-a95e-1d1c-c7f8.res6.spectrum.com.
 [2603:6081:7b00:6400:51ef:a95e:1d1c:c7f8])
 by smtp.gmail.com with ESMTPSA id
 a1-20020a0df101000000b0057a67df3308sm2868829ywf.101.2023.09.04.18.12.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 18:12:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Subject: [PATCH 2/2] nokia_rx51: Remove platform
Date: Mon,  4 Sep 2023 21:12:28 -0400
Message-Id: <20230905011228.4006020-3-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905011228.4006020-1-trini@konsulko.com>
References: <20230905011228.4006020-1-trini@konsulko.com>
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

This platform is behind on migrations (it is the sole user of the oldest
legacy version of the USB gadget stack and is long overdue for
migration) and with Pali no longer being a maintainer, we remove this
platform.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .azure-pipelines.yml              |  19 -
 .gitlab-ci.yml                    |  13 -
 arch/arm/Kconfig                  |   3 +-
 arch/arm/mach-omap2/omap3/Kconfig |  10 -
 board/nokia/rx51/Kconfig          |  48 --
 board/nokia/rx51/MAINTAINERS      |   7 -
 board/nokia/rx51/Makefile         |   7 -
 board/nokia/rx51/lowlevel_init.S  |  97 ----
 board/nokia/rx51/rx51.c           | 806 ------------------------------
 board/nokia/rx51/tag_omap.h       | 294 -----------
 configs/nokia_rx51_defconfig      |  76 ---
 doc/board/index.rst               |   1 -
 doc/board/nokia/index.rst         |   9 -
 doc/board/nokia/rx51.rst          | 250 ---------
 include/configs/nokia_rx51.h      | 174 -------
 test/nokia_rx51_test.sh           | 420 ----------------
 tools/docker/Dockerfile           |  31 --
 17 files changed, 1 insertion(+), 2264 deletions(-)
 delete mode 100644 board/nokia/rx51/Kconfig
 delete mode 100644 board/nokia/rx51/MAINTAINERS
 delete mode 100644 board/nokia/rx51/Makefile
 delete mode 100644 board/nokia/rx51/lowlevel_init.S
 delete mode 100644 board/nokia/rx51/rx51.c
 delete mode 100644 board/nokia/rx51/tag_omap.h
 delete mode 100644 configs/nokia_rx51_defconfig
 delete mode 100644 doc/board/nokia/index.rst
 delete mode 100644 doc/board/nokia/rx51.rst
 delete mode 100644 include/configs/nokia_rx51.h
 delete mode 100755 test/nokia_rx51_test.sh

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index d137d71dd5bc..cd2ac5cb14a8 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -179,25 +179,6 @@ stages:
           # seems to hang forever with pre-configured "container" environment
           docker run -v $PWD:$(work_dir) $(ci_runner_image) /bin/bash $(work_dir)/build.sh
 
-  - job: nokia_rx51_test
-    displayName: 'Run tests for Nokia RX-51 (aka N900)'
-    pool:
-      vmImage: $(ubuntu_vm)
-    container:
-      image: $(ci_runner_image)
-      options: $(container_option)
-    steps:
-      - script: |
-          mkdir nokia_rx51_tmp
-          ln -s /opt/nokia/u-boot-gen-combined nokia_rx51_tmp/
-          ln -s /opt/nokia/qemu-n900.tar.gz nokia_rx51_tmp/
-          ln -s /opt/nokia/kernel_2.6.28-20103103+0m5_armel.deb nokia_rx51_tmp/
-          ln -s /opt/nokia/libc6_2.5.1-1eglibc27+0m5_armel.deb nokia_rx51_tmp/
-          ln -s /opt/nokia/busybox_1.10.2.legal-1osso30+0m5_armel.deb nokia_rx51_tmp/
-          ln -s /opt/nokia/qemu-system-arm nokia_rx51_tmp/
-          export PATH=/opt/gcc-13.2.0-nolibc/arm-linux-gnueabi/bin:$PATH
-          test/nokia_rx51_test.sh
-
   - job: pylint
     displayName: Check for any pylint regressions
     pool:
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 6d7ffdd1bbc7..1414de68a842 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -225,19 +225,6 @@ Run binman, buildman, dtoc, Kconfig and patman testsuites:
       ./tools/patman/patman test;
       make testconfig
 
-Run tests for Nokia RX-51 (aka N900):
-  stage: testsuites
-  script:
-    - mkdir nokia_rx51_tmp;
-      ln -s /opt/nokia/u-boot-gen-combined nokia_rx51_tmp/;
-      ln -s /opt/nokia/qemu-n900.tar.gz nokia_rx51_tmp/;
-      ln -s /opt/nokia/kernel_2.6.28-20103103+0m5_armel.deb nokia_rx51_tmp/;
-      ln -s /opt/nokia/libc6_2.5.1-1eglibc27+0m5_armel.deb nokia_rx51_tmp/;
-      ln -s /opt/nokia/busybox_1.10.2.legal-1osso30+0m5_armel.deb nokia_rx51_tmp/;
-      ln -s /opt/nokia/qemu-system-arm nokia_rx51_tmp/;
-      export PATH=/opt/gcc-13.2.0-nolibc/arm-linux-gnueabi/bin:$PATH;
-      test/nokia_rx51_test.sh
-
 # Check for any pylint regressions
 Run pylint:
   stage: testsuites
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 71f820e443bb..7b0978447f1d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2112,7 +2112,7 @@ config SERIAL_TAG
 
 config STATIC_MACH_TYPE
 	bool "Statically define the Machine ID number"
-	default y if TARGET_DS109 || TARGET_NOKIA_RX51 || TARGET_DS414 || DEFAULT_DEVICE_TREE = "sun7i-a20-icnova-swac"
+	default y if TARGET_DS109 || TARGET_DS414 || DEFAULT_DEVICE_TREE = "sun7i-a20-icnova-swac"
 	help
 	  When booting via ATAGs, enable this option if we know the correct
 	  machine ID number to use at compile time.  Some systems will be
@@ -2122,7 +2122,6 @@ config MACH_TYPE
 	int "Machine ID number"
 	depends on STATIC_MACH_TYPE
 	default 527 if TARGET_DS109
-	default 1955 if TARGET_NOKIA_RX51
 	default 3036 if TARGET_DS414
 	default 4283 if DEFAULT_DEVICE_TREE = "sun7i-a20-icnova-swac"
 	help
diff --git a/arch/arm/mach-omap2/omap3/Kconfig b/arch/arm/mach-omap2/omap3/Kconfig
index 671e4791c67f..3e3e7bd259ee 100644
--- a/arch/arm/mach-omap2/omap3/Kconfig
+++ b/arch/arm/mach-omap2/omap3/Kconfig
@@ -105,15 +105,6 @@ config TARGET_OMAP3_LOGIC
 	select OMAP3_GPIO_6
 	imply CMD_DM
 
-config TARGET_NOKIA_RX51
-	bool "Nokia RX51"
-	select POSITION_INDEPENDENT
-	select SKIP_LOWLEVEL_INIT
-	select SUPPORT_PASSING_ATAGS
-	select CMDLINE_TAG
-	select INITRD_TAG
-	select REVISION_TAG
-
 config TARGET_TAO3530
 	bool "TAO3530"
 	select OMAP3_GPIO_2
@@ -166,7 +157,6 @@ source "board/timll/devkit8000/Kconfig"
 source "board/ti/omap3evm/Kconfig"
 source "board/isee/igep00x0/Kconfig"
 source "board/logicpd/omap3som/Kconfig"
-source "board/nokia/rx51/Kconfig"
 source "board/lg/sniper/Kconfig"
 
 endif
diff --git a/board/nokia/rx51/Kconfig b/board/nokia/rx51/Kconfig
deleted file mode 100644
index c884543a3d84..000000000000
--- a/board/nokia/rx51/Kconfig
+++ /dev/null
@@ -1,48 +0,0 @@
-if TARGET_NOKIA_RX51
-
-config USB_DEVICE
-	def_bool y
-	help
-	  Legacy UDC device support
-
-config USB_TTY
-	def_bool y
-	help
-	  Legacy tty type of device available to talk to the UDC device
-
-config USBD_VENDORID
-	hex
-	default 0x0421
-
-config USBD_PRODUCTID_CDCACM
-	hex
-	default 0x01c8
-
-config USBD_PRODUCTID_GSERIAL
-	hex
-	default 0x01c8
-
-config USBD_MANUFACTURER
-	string
-	default "Nokia"
-
-config USBD_PRODUCT_NAME
-	string
-	default "N900 (U-Boot)"
-
-config NR_DRAM_BANKS
-	default 2
-
-config SYS_BOARD
-	default "rx51"
-
-config SYS_VENDOR
-	default "nokia"
-
-config SYS_CONFIG_NAME
-	default "nokia_rx51"
-
-config SYS_PROMPT
-	default "Nokia RX-51 # "
-
-endif
diff --git a/board/nokia/rx51/MAINTAINERS b/board/nokia/rx51/MAINTAINERS
deleted file mode 100644
index d2718ebd417c..000000000000
--- a/board/nokia/rx51/MAINTAINERS
+++ /dev/null
@@ -1,7 +0,0 @@
-RX51 BOARD
-S:	Orphaned
-F:	board/nokia/rx51/
-F:	include/configs/nokia_rx51.h
-F:	configs/nokia_rx51_defconfig
-F:	doc/board/nokia/rx51.rst
-F:	test/nokia_rx51_test.sh
diff --git a/board/nokia/rx51/Makefile b/board/nokia/rx51/Makefile
deleted file mode 100644
index 842f9e6a650e..000000000000
--- a/board/nokia/rx51/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-#
-# (C) Copyright 2000, 2001, 2002
-# Wolfgang Denk, DENX Software Engineering, wd@denx.de.
-
-obj-y := rx51.o
-obj-y += lowlevel_init.o
diff --git a/board/nokia/rx51/lowlevel_init.S b/board/nokia/rx51/lowlevel_init.S
deleted file mode 100644
index 44f32f114e75..000000000000
--- a/board/nokia/rx51/lowlevel_init.S
+++ /dev/null
@@ -1,97 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * (C) Copyright 2011-2012
- * Pali Rohár <pali@kernel.org>
- */
-
-#include <config.h>
-#include <linux/linkage.h>
-
-kernoffs:		/* offset of kernel image from this address */
-	.word . - CONFIG_TEXT_BASE - KERNEL_OFFSET
-
-kernaddr:		/* address of kernel after copying */
-	.word KERNEL_ADDRESS
-
-kernsize:		/* maximal size of kernel image */
-	.word KERNEL_MAXSIZE
-
-imagesize:		/* maximal size of image */
-	.word IMAGE_MAXSIZE
-
-ih_magic:		/* IH_MAGIC in big endian from include/image.h */
-	.word 0x56190527
-
-z_magic:		/* LINUX_ARM_ZIMAGE_MAGIC */
-	.word 0x016f2818
-
-/*
- * Routine: save_boot_params (called after reset from start.S)
- * Description: Copy attached kernel to address KERNEL_ADDRESS
- */
-
-ENTRY(save_boot_params)
-
-/*
- * Copy valid attached kernel to absolute address KERNEL_ADDRESS
- *
- * Nokia X-Loader is loading secondary image to address 0x80400000.
- * NOLO is loading boot image to random place, so it doesn't really
- * matter what is set in CONFIG_TEXT_BASE. We have to detect
- * KERNEL_OFFSET from the current execution address and copy it to
- * absolute address KERNEL_ADDRESS.
- *
- * Note that U-Boot has to be compiled with CONFIG_POSITION_INDEPENDENT
- * because it is loaded at random address and not to the fixed address
- * (CONFIG_TEXT_BASE).
- */
-
-	/* r0 - start of kernel before */
-	adr	r0, kernoffs	/* r0 - current address of kernoffs section */
-	ldr	r1, kernoffs	/* r1 - offset of kernel image from kernoffs section */
-	sub	r0, r0, r1
-
-	/* r3 - start of kernel after */
-	ldr	r3, kernaddr
-
-	/* r2 - end of kernel after */
-	ldr	r1, kernsize
-	add	r2, r3, r1
-
-	/* r1 - end of kernel before */
-	add	r1, r0, r1
-
-	/* remove header in target kernel */
-	mov	r5, #0
-	str	r5, [r3]	/* remove 4 bytes header of kernel uImage */
-	str	r5, [r3, #36]	/* remove 4 bytes header of kernel zImage */
-
-	/* check for valid kernel uImage */
-	ldr	r4, [r0]	/* r4 - 4 bytes header of kernel */
-	ldr	r5, ih_magic	/* r5 - IH_MAGIC */
-	cmp	r4, r5
-	beq	copy_kernel_loop
-
-	/* check for valid kernel zImage */
-	ldr	r4, [r0, #36]	/* r4 - 4 bytes header of kernel at offset 36 */
-	ldr	r5, z_magic	/* r5 - LINUX_ARM_ZIMAGE_MAGIC */
-	cmp	r4, r5
-	bne	skip_copy	/* skip if invalid image */
-
-copy_kernel_loop:
-	ldmdb	r1!, {r3 - r10}
-	stmdb	r2!, {r3 - r10}
-	cmp	r1, r0
-	bhi	copy_kernel_loop
-
-	/* remove header in source kernel image */
-	mov	r5, #0
-	str	r5, [r0]	/* remove 4 bytes header of kernel uImage */
-	str	r5, [r0, #36]	/* remove 4 bytes header of kernel zImage */
-
-skip_copy:
-
-	/* Returns */
-	b	save_boot_params_ret
-
-ENDPROC(save_boot_params)
diff --git a/board/nokia/rx51/rx51.c b/board/nokia/rx51/rx51.c
deleted file mode 100644
index 238b9637badd..000000000000
--- a/board/nokia/rx51/rx51.c
+++ /dev/null
@@ -1,806 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * (C) Copyright 2012
- * Ивайло Димитров <freemangordon@abv.bg>
- *
- * (C) Copyright 2011-2012
- * Pali Rohár <pali@kernel.org>
- *
- * (C) Copyright 2010
- * Alistair Buxton <a.j.buxton@gmail.com>
- *
- * Derived from Beagle Board and 3430 SDP code:
- * (C) Copyright 2004-2008
- * Texas Instruments, <www.ti.com>
- *
- * Author :
- *	Sunil Kumar <sunilsaini05@gmail.com>
- *	Shashi Ranjan <shashiranjanmca05@gmail.com>
- *
- *	Richard Woodruff <r-woodruff2@ti.com>
- *	Syed Mohammed Khasim <khasim@ti.com>
- */
-
-#include <common.h>
-#include <dm.h>
-#include <env.h>
-#include <init.h>
-#include <watchdog.h>
-#include <wdt.h>
-#include <malloc.h>
-#include <twl4030.h>
-#include <i2c.h>
-#include <video.h>
-#include <keyboard.h>
-#include <ns16550.h>
-#include <asm/global_data.h>
-#include <asm/io.h>
-#include <asm/setup.h>
-#include <asm/bitops.h>
-#include <asm/mach-types.h>
-#include <asm/omap_i2c.h>
-#include <asm/arch/mux.h>
-#include <asm/arch/sys_proto.h>
-#include <asm/arch/mmc_host_def.h>
-
-#include "tag_omap.h"
-
-/* Needed for ROM SMC call */
-struct emu_hal_params_rx51 {
-	u32 num_params;
-	u32 param1;
-	u32 param2;
-	u32 param3;
-	u32 param4;
-};
-
-#define ONENAND_GPMC_CONFIG1_RX51	0xfb001202
-#define ONENAND_GPMC_CONFIG2_RX51	0x00111100
-#define ONENAND_GPMC_CONFIG3_RX51	0x00020200
-#define ONENAND_GPMC_CONFIG4_RX51	0x11001102
-#define ONENAND_GPMC_CONFIG5_RX51	0x03101616
-#define ONENAND_GPMC_CONFIG6_RX51	0x90060000
-
-DECLARE_GLOBAL_DATA_PTR;
-
-const omap3_sysinfo sysinfo = {
-	DDR_STACKED,
-	"Nokia RX-51",
-	"OneNAND"
-};
-
-/* This structure contains default omap tags needed for booting Maemo 5 */
-static struct tag_omap omap[] = {
-	OMAP_TAG_UART_CONFIG(0x04),
-	OMAP_TAG_SERIAL_CONSOLE_CONFIG(0x03, 0x01C200),
-	OMAP_TAG_LCD_CONFIG("acx565akm", "internal", 90, 0x18),
-	OMAP_TAG_GPIO_SWITCH_CONFIG("cam_focus", 0x44, 0x1, 0x2, 0x0),
-	OMAP_TAG_GPIO_SWITCH_CONFIG("cam_launch", 0x45, 0x1, 0x2, 0x0),
-	OMAP_TAG_GPIO_SWITCH_CONFIG("cam_shutter", 0x6e, 0x1, 0x0, 0x0),
-	OMAP_TAG_GPIO_SWITCH_CONFIG("cmt_apeslpx", 0x46, 0x2, 0x2, 0x0),
-	OMAP_TAG_GPIO_SWITCH_CONFIG("cmt_bsi", 0x9d, 0x2, 0x2, 0x0),
-	OMAP_TAG_GPIO_SWITCH_CONFIG("cmt_en", 0x4a, 0x2, 0x2, 0x0),
-	OMAP_TAG_GPIO_SWITCH_CONFIG("cmt_rst", 0x4b, 0x6, 0x2, 0x0),
-	OMAP_TAG_GPIO_SWITCH_CONFIG("cmt_rst_rq", 0x49, 0x6, 0x2, 0x0),
-	OMAP_TAG_GPIO_SWITCH_CONFIG("cmt_wddis", 0x0d, 0x2, 0x2, 0x0),
-	OMAP_TAG_GPIO_SWITCH_CONFIG("headphone", 0xb1, 0x1, 0x1, 0x0),
-	OMAP_TAG_GPIO_SWITCH_CONFIG("kb_lock", 0x71, 0x1, 0x0, 0x0),
-	OMAP_TAG_GPIO_SWITCH_CONFIG("proximity", 0x59, 0x0, 0x0, 0x0),
-	OMAP_TAG_GPIO_SWITCH_CONFIG("sleep_ind", 0xa2, 0x2, 0x2, 0x0),
-	OMAP_TAG_GPIO_SWITCH_CONFIG("slide", GPIO_SLIDE, 0x0, 0x0, 0x0),
-	OMAP_TAG_WLAN_CX3110X_CONFIG(0x25, 0xff, 87, 42, -1),
-	OMAP_TAG_PARTITION_CONFIG("bootloader", 128 * 1024, 0x00000000, 0x00000003),
-	OMAP_TAG_PARTITION_CONFIG("config", 384 * 1024, 0x00020000, 0x00000000),
-	OMAP_TAG_PARTITION_CONFIG("log", 256 * 1024, 0x00080000, 0x00000000),
-	OMAP_TAG_PARTITION_CONFIG("kernel", 2 * 1024*1024, 0x000c0000, 0x00000000),
-	OMAP_TAG_PARTITION_CONFIG("initfs", 2 * 1024*1024, 0x002c0000, 0x00000000),
-	OMAP_TAG_PARTITION_CONFIG("rootfs", 257280 * 1024, 0x004c0000, 0x00000000),
-	OMAP_TAG_BOOT_REASON_CONFIG("pwr_key"),
-	OMAP_TAG_VERSION_STR_CONFIG("product", "RX-51"),
-	OMAP_TAG_VERSION_STR_CONFIG("hw-build", "2101"),
-	OMAP_TAG_VERSION_STR_CONFIG("nolo", "1.4.14"),
-	OMAP_TAG_VERSION_STR_CONFIG("boot-mode", "normal"),
-	{ }
-};
-
-static char *boot_reason_ptr;
-static char *hw_build_ptr;
-static char *nolo_version_ptr;
-static char *boot_mode_ptr;
-static int serial_was_console_enabled;
-
-/*
- * Routine: init_omap_tags
- * Description: Initialize pointers to values in tag_omap
- */
-static void init_omap_tags(void)
-{
-	char *component;
-	char *version;
-	int i = 0;
-	while (omap[i].hdr.tag) {
-		switch (omap[i].hdr.tag) {
-		case OMAP_TAG_BOOT_REASON:
-			boot_reason_ptr = omap[i].u.boot_reason.reason_str;
-			break;
-		case OMAP_TAG_VERSION_STR:
-			component = omap[i].u.version.component;
-			version = omap[i].u.version.version;
-			if (strcmp(component, "hw-build") == 0)
-				hw_build_ptr = version;
-			else if (strcmp(component, "nolo") == 0)
-				nolo_version_ptr = version;
-			else if (strcmp(component, "boot-mode") == 0)
-				boot_mode_ptr = version;
-			break;
-		default:
-			break;
-		}
-		i++;
-	}
-}
-
-static void reuse_omap_atags(struct tag_omap *t)
-{
-	char *component;
-	char *version;
-	while (t->hdr.tag) {
-		switch (t->hdr.tag) {
-		case OMAP_TAG_BOOT_REASON:
-			memset(boot_reason_ptr, 0, 12);
-			strcpy(boot_reason_ptr, t->u.boot_reason.reason_str);
-			break;
-		case OMAP_TAG_VERSION_STR:
-			component = t->u.version.component;
-			version = t->u.version.version;
-			if (strcmp(component, "hw-build") == 0) {
-				memset(hw_build_ptr, 0, 12);
-				strcpy(hw_build_ptr, version);
-			} else if (strcmp(component, "nolo") == 0) {
-				memset(nolo_version_ptr, 0, 12);
-				strcpy(nolo_version_ptr, version);
-			} else if (strcmp(component, "boot-mode") == 0) {
-				memset(boot_mode_ptr, 0, 12);
-				strcpy(boot_mode_ptr, version);
-			}
-			break;
-		case OMAP_TAG_UART:
-			if (t->u.uart.enabled_uarts)
-				serial_was_console_enabled = 1;
-			break;
-		case OMAP_TAG_SERIAL_CONSOLE:
-			serial_was_console_enabled = 1;
-			break;
-		default:
-			break;
-		}
-		t = tag_omap_next(t);
-	}
-}
-
-/*
- * Routine: reuse_atags
- * Description: Reuse atags from previous bootloader.
- *              Reuse only only HW build, boot reason, boot mode and nolo
- */
-static void reuse_atags(void)
-{
-	struct tag *t = (struct tag *)gd->bd->bi_boot_params;
-
-	/* First tag must be ATAG_CORE */
-	if (t->hdr.tag != ATAG_CORE)
-		return;
-
-	if (!boot_reason_ptr || !hw_build_ptr)
-		return;
-
-	/* Last tag must be ATAG_NONE */
-	while (t->hdr.tag != ATAG_NONE) {
-		switch (t->hdr.tag) {
-		case ATAG_REVISION:
-			memset(hw_build_ptr, 0, 12);
-			sprintf(hw_build_ptr, "%x", t->u.revision.rev);
-			break;
-		case ATAG_BOARD:
-			reuse_omap_atags((struct tag_omap *)&t->u);
-			break;
-		default:
-			break;
-		}
-		t = tag_next(t);
-	}
-}
-
-/*
- * Routine: board_init
- * Description: Early hardware init.
- */
-int board_init(void)
-{
-#if defined(CONFIG_CMD_ONENAND)
-	const u32 gpmc_regs_onenandrx51[GPMC_MAX_REG] = {
-		ONENAND_GPMC_CONFIG1_RX51,
-		ONENAND_GPMC_CONFIG2_RX51,
-		ONENAND_GPMC_CONFIG3_RX51,
-		ONENAND_GPMC_CONFIG4_RX51,
-		ONENAND_GPMC_CONFIG5_RX51,
-		ONENAND_GPMC_CONFIG6_RX51,
-		0
-	};
-#endif
-	/* in SRAM or SDRAM, finish GPMC */
-	gpmc_init();
-#if defined(CONFIG_CMD_ONENAND)
-	enable_gpmc_cs_config(gpmc_regs_onenandrx51, &gpmc_cfg->cs[0],
-			      CFG_SYS_ONENAND_BASE, GPMC_SIZE_256M);
-#endif
-	/* Enable the clks & power */
-	per_clocks_enable();
-	/* boot param addr */
-	gd->bd->bi_boot_params = OMAP34XX_SDRC_CS0 + 0x100;
-	return 0;
-}
-
-#ifdef CONFIG_REVISION_TAG
-/*
- * Routine: get_board_revision
- * Description: Return board revision.
- */
-u32 get_board_rev(void)
-{
-	return simple_strtol(hw_build_ptr, NULL, 16);
-}
-#endif
-
-/*
- * Routine: setup_board_tags
- * Description: Append board specific boot tags.
- */
-void setup_board_tags(struct tag **in_params)
-{
-	int setup_console_atag;
-	char *setup_boot_reason_atag;
-	char *setup_boot_mode_atag;
-	char *str;
-	int i;
-	int size;
-	int total_size;
-	struct tag *params;
-	struct tag_omap *t;
-
-	params = (struct tag *)gd->bd->bi_boot_params;
-
-	params->u.core.flags = 0x0;
-	params->u.core.pagesize = 0x1000;
-	params->u.core.rootdev = 0x0;
-
-	/* append omap atag only if env setup_omap_atag is set to 1 */
-	str = env_get("setup_omap_atag");
-	if (!str || str[0] != '1')
-		return;
-
-	str = env_get("setup_console_atag");
-	if (str && str[0]) {
-		if (str[0] == '1')
-			setup_console_atag = 1;
-		else
-			setup_console_atag = 0;
-	} else {
-		if (serial_was_console_enabled)
-			setup_console_atag = 1;
-		else
-			setup_console_atag = 0;
-	}
-
-	setup_boot_reason_atag = env_get("setup_boot_reason_atag");
-	setup_boot_mode_atag = env_get("setup_boot_mode_atag");
-
-	params = *in_params;
-	t = (struct tag_omap *)&params->u;
-	total_size = sizeof(struct tag_header);
-
-	for (i = 0; omap[i].hdr.tag; i++) {
-
-		/* skip serial console tag */
-		if (!setup_console_atag &&
-			omap[i].hdr.tag == OMAP_TAG_SERIAL_CONSOLE)
-			continue;
-
-		size = omap[i].hdr.size + sizeof(struct tag_omap_header);
-		memcpy(t, &omap[i], size);
-
-		/* set uart tag to 0 - disable serial console */
-		if (!setup_console_atag && omap[i].hdr.tag == OMAP_TAG_UART)
-			t->u.uart.enabled_uarts = 0;
-
-		/* change boot reason */
-		if (setup_boot_reason_atag &&
-			omap[i].hdr.tag == OMAP_TAG_BOOT_REASON) {
-			memset(t->u.boot_reason.reason_str, 0, 12);
-			strcpy(t->u.boot_reason.reason_str,
-				setup_boot_reason_atag);
-		}
-
-		/* change boot mode */
-		if (setup_boot_mode_atag &&
-			omap[i].hdr.tag == OMAP_TAG_VERSION_STR &&
-			strcmp(omap[i].u.version.component, "boot-mode") == 0) {
-			memset(t->u.version.version, 0, 12);
-			strcpy(t->u.version.version, setup_boot_mode_atag);
-		}
-
-		total_size += size;
-		t = tag_omap_next(t);
-
-	}
-
-	params->hdr.tag = ATAG_BOARD;
-	params->hdr.size = total_size >> 2;
-	params = tag_next(params);
-
-	*in_params = params;
-}
-
-static int rx51_video_probe(struct udevice *dev)
-{
-	struct video_uc_plat *uc_plat = dev_get_uclass_plat(dev);
-	struct video_priv *uc_priv = dev_get_uclass_priv(dev);
-
-	uc_plat->base = 0x8f9c0000;
-	uc_plat->size = 800 * 480 * sizeof(u16);
-	uc_priv->xsize = 800;
-	uc_priv->ysize = 480;
-	uc_priv->bpix = VIDEO_BPP16;
-
-	video_set_flush_dcache(dev, true);
-
-	return 0;
-}
-
-U_BOOT_DRIVER(rx51_video) = {
-	.name = "rx51_video",
-	.id = UCLASS_VIDEO,
-	.probe = rx51_video_probe,
-};
-
-/*
- * Routine: twl4030_regulator_set_mode
- * Description: Set twl4030 regulator mode over i2c powerbus.
- */
-static void twl4030_regulator_set_mode(u8 id, u8 mode)
-{
-	u16 msg = MSG_SINGULAR(DEV_GRP_P1, id, mode);
-	twl4030_i2c_write_u8(TWL4030_CHIP_PM_MASTER,
-			     TWL4030_PM_MASTER_PB_WORD_MSB, msg >> 8);
-	twl4030_i2c_write_u8(TWL4030_CHIP_PM_MASTER,
-			     TWL4030_PM_MASTER_PB_WORD_LSB, msg & 0xff);
-}
-
-static void omap3_emu_romcode_call(u32 service_id, u32 *parameters)
-{
-	u32 i, num_params = *parameters;
-	u32 *sram_scratch_space = (u32 *)OMAP3_PUBLIC_SRAM_SCRATCH_AREA;
-
-	/*
-	 * copy the parameters to an un-cached area to avoid coherency
-	 * issues
-	 */
-	for (i = 0; i < num_params; i++) {
-		__raw_writel(*parameters, sram_scratch_space);
-		parameters++;
-		sram_scratch_space++;
-	}
-
-	/* Now make the PPA call */
-	do_omap3_emu_romcode_call(service_id, OMAP3_PUBLIC_SRAM_SCRATCH_AREA);
-}
-
-void omap3_set_aux_cr_secure(u32 acr)
-{
-	struct emu_hal_params_rx51 emu_romcode_params = { 0, };
-
-	emu_romcode_params.num_params = 2;
-	emu_romcode_params.param1 = acr;
-
-	omap3_emu_romcode_call(OMAP3_EMU_HAL_API_WRITE_ACR,
-			       (u32 *)&emu_romcode_params);
-}
-
-/*
- * Routine: omap3_update_aux_cr_secure_rx51
- * Description: Modify the contents Auxiliary Control Register.
- * Parameters:
- *   set_bits - bits to set in ACR
- *   clr_bits - bits to clear in ACR
- */
-static void omap3_update_aux_cr_secure_rx51(u32 set_bits, u32 clear_bits)
-{
-	u32 acr;
-
-	/* Read ACR */
-	asm volatile ("mrc p15, 0, %0, c1, c0, 1" : "=r" (acr));
-	acr &= ~clear_bits;
-	acr |= set_bits;
-	omap3_set_aux_cr_secure(acr);
-}
-
-/*
- * Routine: misc_init_r
- * Description: Configure board specific parts.
- */
-int misc_init_r(void)
-{
-	struct udevice *dev;
-	char buf[12];
-	u8 state;
-
-	/* disable lp5523 led */
-	if (i2c_get_chip_for_busnum(1, 0x32, 1, &dev) == 0)
-		dm_i2c_reg_write(dev, 0x00, 0x00);
-
-	/* initialize twl4030 power managment */
-	twl4030_power_init();
-	twl4030_power_mmc_init(0);
-	twl4030_power_mmc_init(1);
-
-	/* set VSIM to 1.8V */
-	twl4030_pmrecv_vsel_cfg(TWL4030_PM_RECEIVER_VSIM_DEDICATED,
-				TWL4030_PM_RECEIVER_VSIM_VSEL_18,
-				TWL4030_PM_RECEIVER_VSIM_DEV_GRP,
-				TWL4030_PM_RECEIVER_DEV_GRP_P1);
-
-	/* store I2C access state */
-	twl4030_i2c_read_u8(TWL4030_CHIP_PM_MASTER, TWL4030_PM_MASTER_PB_CFG,
-			    &state);
-
-	/* enable I2C access to powerbus (needed for twl4030 regulator) */
-	twl4030_i2c_write_u8(TWL4030_CHIP_PM_MASTER, TWL4030_PM_MASTER_PB_CFG,
-			     0x02);
-
-	/* set VAUX3, VSIM and VMMC1 state to active - enable eMMC memory */
-	twl4030_regulator_set_mode(RES_VAUX3, RES_STATE_ACTIVE);
-	twl4030_regulator_set_mode(RES_VSIM, RES_STATE_ACTIVE);
-	twl4030_regulator_set_mode(RES_VMMC1, RES_STATE_ACTIVE);
-
-	/* restore I2C access state */
-	twl4030_i2c_write_u8(TWL4030_CHIP_PM_MASTER, TWL4030_PM_MASTER_PB_CFG,
-			     state);
-
-	/* set env variable attkernaddr for relocated kernel */
-	sprintf(buf, "%#x", KERNEL_ADDRESS);
-	env_set("attkernaddr", buf);
-
-	/* initialize omap tags */
-	init_omap_tags();
-
-	/* reuse atags from previous bootloader */
-	reuse_atags();
-
-	omap_die_id_display();
-	print_cpuinfo();
-
-	/*
-	 * Cortex-A8(r1p0..r1p2) errata 430973 workaround
-	 * Set IBE bit in Auxiliary Control Register
-	 *
-	 * Call this routine only on real secure device
-	 * Qemu does not implement secure PPA and crash
-	 */
-	if (get_device_type() == HS_DEVICE)
-		omap3_update_aux_cr_secure_rx51(1 << 6, 0);
-
-	return 0;
-}
-
-static unsigned long int twl_wd_time; /* last time of watchdog reset */
-static unsigned long int twl_i2c_lock;
-
-/*
- * Routine: rx51_watchdog_reset
- * Description: Reset timeout of twl4030 watchdog.
- */
-static int rx51_watchdog_reset(struct udevice *dev)
-{
-	u8 timeout = 0;
-
-	/* do not reset watchdog too often - max every 4s */
-	if (get_timer(twl_wd_time) < 4 * CONFIG_SYS_HZ)
-		return 0;
-
-	/* localy lock twl4030 i2c bus */
-	if (test_and_set_bit(0, &twl_i2c_lock))
-		return 0;
-
-	/* read actual watchdog timeout */
-	twl4030_i2c_read_u8(TWL4030_CHIP_PM_RECEIVER,
-			    TWL4030_PM_RECEIVER_WATCHDOG_CFG, &timeout);
-
-	/* timeout 0 means watchdog is disabled */
-	/* reset watchdog timeout to 31s (maximum) */
-	if (timeout != 0)
-		twl4030_i2c_write_u8(TWL4030_CHIP_PM_RECEIVER,
-				     TWL4030_PM_RECEIVER_WATCHDOG_CFG, 31);
-
-	/* store last watchdog reset time */
-	twl_wd_time = get_timer(0);
-
-	/* localy unlock twl4030 i2c bus */
-	test_and_clear_bit(0, &twl_i2c_lock);
-
-	return 0;
-}
-
-static int rx51_watchdog_start(struct udevice *dev, u64 timeout_ms, ulong flags)
-{
-	return 0;
-}
-
-static int rx51_watchdog_probe(struct udevice *dev)
-{
-	return 0;
-}
-
-static const struct wdt_ops rx51_watchdog_ops = {
-	.start = rx51_watchdog_start,
-	.reset = rx51_watchdog_reset,
-};
-
-U_BOOT_DRIVER(rx51_watchdog) = {
-	.name = "rx51_watchdog",
-	.id = UCLASS_WDT,
-	.ops = &rx51_watchdog_ops,
-	.probe = rx51_watchdog_probe,
-};
-
-/*
- * TWL4030 keypad handler for cfb_console
- */
-
-static const char keymap[] = {
-	/* normal */
-	'q',  'o',  'p',  ',', '\b',    0,  'a',  's',
-	'w',  'd',  'f',  'g',  'h',  'j',  'k',  'l',
-	'e',  '.',    0,  '\r',   0,  'z',  'x',  'c',
-	'r',  'v',  'b',  'n',  'm',  ' ',    0,    0,
-	't',    0,    0,    0,    0,    0,    0,    0,
-	'y',    0,    0,    0,    0,    0,    0,    0,
-	'u',    0,    0,    0,    0,    0,    0,    0,
-	'i',    5,    6,    0,    0,    0,    0,    0,
-	/* fn */
-	'1',  '9',  '0',  '=', '\b',    0,  '*',  '+',
-	'2',  '#',  '-',  '_',  '(',  ')',  '&',  '!',
-	'3',  '?',  '^', '\r',    0,  156,  '$',  238,
-	'4',  '/', '\\',  '"', '\'',  '@',    0,  '<',
-	'5',  '|',  '>',    0,    0,    0,    0,    0,
-	'6',    0,    0,    0,    0,    0,    0,    0,
-	'7',    0,    0,    0,    0,    0,    0,    0,
-	'8',   16,   17,    0,    0,    0,    0,    0,
-};
-
-static u8 keys[8];
-static u8 old_keys[8] = {0, 0, 0, 0, 0, 0, 0, 0};
-#define KEYBUF_SIZE 32
-static u8 keybuf[KEYBUF_SIZE];
-static u8 keybuf_head;
-static u8 keybuf_tail;
-
-/*
- * Routine: rx51_kp_start
- * Description: Initialize HW keyboard.
- */
-static int rx51_kp_start(struct udevice *dev)
-{
-	int ret = 0;
-	u8 ctrl;
-	ret = twl4030_i2c_read_u8(TWL4030_CHIP_KEYPAD,
-				  TWL4030_KEYPAD_KEYP_CTRL_REG, &ctrl);
-
-	if (ret)
-		return ret;
-
-	/* turn on keyboard and use hardware scanning */
-	ctrl |= TWL4030_KEYPAD_CTRL_KBD_ON;
-	ctrl |= TWL4030_KEYPAD_CTRL_SOFT_NRST;
-	ctrl |= TWL4030_KEYPAD_CTRL_SOFTMODEN;
-	ret |= twl4030_i2c_write_u8(TWL4030_CHIP_KEYPAD,
-				    TWL4030_KEYPAD_KEYP_CTRL_REG, ctrl);
-	/* enable key event status */
-	ret |= twl4030_i2c_write_u8(TWL4030_CHIP_KEYPAD,
-				    TWL4030_KEYPAD_KEYP_IMR1, 0xfe);
-	/* enable interrupt generation on rising and falling */
-	/* this is a workaround for qemu twl4030 emulation */
-	ret |= twl4030_i2c_write_u8(TWL4030_CHIP_KEYPAD,
-				    TWL4030_KEYPAD_KEYP_EDR, 0x57);
-	/* enable ISR clear on read */
-	ret |= twl4030_i2c_write_u8(TWL4030_CHIP_KEYPAD,
-				    TWL4030_KEYPAD_KEYP_SIH_CTRL, 0x05);
-	return 0;
-}
-
-static void rx51_kp_fill(u8 k, u8 mods)
-{
-	/* check if some cursor key without meta fn key was pressed */
-	if (!(mods & 2) && (k == 18 || k == 31 || k == 33 || k == 34)) {
-		keybuf[keybuf_tail++] = '\e';
-		keybuf_tail %= KEYBUF_SIZE;
-		keybuf[keybuf_tail++] = '[';
-		keybuf_tail %= KEYBUF_SIZE;
-		if (k == 18) /* up */
-			keybuf[keybuf_tail++] = 'A';
-		else if (k == 31) /* left */
-			keybuf[keybuf_tail++] = 'D';
-		else if (k == 33) /* down */
-			keybuf[keybuf_tail++] = 'B';
-		else if (k == 34) /* right */
-			keybuf[keybuf_tail++] = 'C';
-		keybuf_tail %= KEYBUF_SIZE;
-		return;
-	}
-
-	if (mods & 2) { /* fn meta key was pressed */
-		k = keymap[k+64];
-	} else {
-		k = keymap[k];
-		if (mods & 1) { /* ctrl key was pressed */
-			if (k >= 'a' && k <= 'z')
-				k -= 'a' - 1;
-		}
-		if (mods & 4) { /* shift key was pressed */
-			if (k >= 'a' && k <= 'z')
-				k += 'A' - 'a';
-			else if (k == '.')
-				k = ':';
-			else if (k == ',')
-				k = ';';
-		}
-	}
-	keybuf[keybuf_tail++] = k;
-	keybuf_tail %= KEYBUF_SIZE;
-}
-
-/*
- * Routine: rx51_kp_tstc
- * Description: Test if key was pressed (from buffer).
- */
-static int rx51_kp_tstc(struct udevice *dev)
-{
-	u8 c, r, dk, i;
-	u8 intr;
-	u8 mods;
-
-	/* localy lock twl4030 i2c bus */
-	if (test_and_set_bit(0, &twl_i2c_lock))
-		return 0;
-
-	/* twl4030 remembers up to 2 events */
-	for (i = 0; i < 2; i++) {
-
-		/* check interrupt register for events */
-		twl4030_i2c_read_u8(TWL4030_CHIP_KEYPAD,
-				    TWL4030_KEYPAD_KEYP_ISR1 + (2 * i), &intr);
-
-		/* no event */
-		if (!(intr&1))
-			continue;
-
-		/* read the key state */
-		twl4030_i2c_read(TWL4030_CHIP_KEYPAD,
-				 TWL4030_KEYPAD_FULL_CODE_7_0, keys, 8);
-
-		/* cut out modifier keys from the keystate */
-		mods = keys[4] >> 4;
-		keys[4] &= 0x0f;
-
-		/* space key is indicated by two different bits */
-		keys[3] |= (keys[3] & (1 << 6)) >> 1;
-		keys[3] &= ~(1 << 6);
-
-		for (c = 0; c < 8; c++) {
-
-			/* get newly pressed keys only */
-			dk = ((keys[c] ^ old_keys[c])&keys[c]);
-			old_keys[c] = keys[c];
-
-			/* fill the keybuf */
-			for (r = 0; r < 8; r++) {
-				if (dk&1)
-					rx51_kp_fill((c*8)+r, mods);
-				dk = dk >> 1;
-			}
-
-		}
-
-	}
-
-	/* localy unlock twl4030 i2c bus */
-	test_and_clear_bit(0, &twl_i2c_lock);
-
-	return (KEYBUF_SIZE + keybuf_tail - keybuf_head)%KEYBUF_SIZE;
-}
-
-/*
- * Routine: rx51_kp_getc
- * Description: Get last pressed key (from buffer).
- */
-static int rx51_kp_getc(struct udevice *dev)
-{
-	keybuf_head %= KEYBUF_SIZE;
-	while (!rx51_kp_tstc(dev))
-		schedule();
-	return keybuf[keybuf_head++];
-}
-
-static int rx51_kp_probe(struct udevice *dev)
-{
-	struct keyboard_priv *uc_priv = dev_get_uclass_priv(dev);
-	struct stdio_dev *sdev = &uc_priv->sdev;
-
-	strcpy(sdev->name, "keyboard");
-	return input_stdio_register(sdev);
-}
-
-static const struct keyboard_ops rx51_kp_ops = {
-	.start = rx51_kp_start,
-	.tstc = rx51_kp_tstc,
-	.getc = rx51_kp_getc,
-};
-
-U_BOOT_DRIVER(rx51_kp) = {
-	.name = "rx51_kp",
-	.id = UCLASS_KEYBOARD,
-	.probe = rx51_kp_probe,
-	.ops = &rx51_kp_ops,
-};
-
-static const struct mmc_config rx51_mmc_cfg = {
-	.host_caps = MMC_MODE_4BIT | MMC_MODE_HS_52MHz | MMC_MODE_HS,
-	.f_min = 400000,
-	.f_max = 52000000,
-	.b_max = CONFIG_SYS_MMC_MAX_BLK_COUNT,
-	.voltages = MMC_VDD_32_33 | MMC_VDD_33_34 | MMC_VDD_165_195,
-};
-
-static const struct omap_hsmmc_plat rx51_mmc[] = {
-	{ rx51_mmc_cfg, (struct hsmmc *)OMAP_HSMMC1_BASE },
-	{ rx51_mmc_cfg, (struct hsmmc *)OMAP_HSMMC2_BASE },
-};
-
-U_BOOT_DRVINFOS(rx51_mmc) = {
-	{ "omap_hsmmc", &rx51_mmc[0] },
-	{ "omap_hsmmc", &rx51_mmc[1] },
-};
-
-static const struct omap_i2c_plat rx51_i2c[] = {
-	{ I2C_BASE1, 100000, OMAP_I2C_REV_V1 },
-	{ I2C_BASE2, 100000, OMAP_I2C_REV_V1 },
-	{ I2C_BASE3, 100000, OMAP_I2C_REV_V1 },
-};
-
-U_BOOT_DRVINFOS(rx51_i2c) = {
-	{ "i2c_omap", &rx51_i2c[0] },
-	{ "i2c_omap", &rx51_i2c[1] },
-	{ "i2c_omap", &rx51_i2c[2] },
-};
-
-U_BOOT_DRVINFOS(rx51_watchdog) = {
-	{ "rx51_watchdog" },
-};
-
-U_BOOT_DRVINFOS(rx51_video) = {
-	{ "rx51_video" },
-};
-
-U_BOOT_DRVINFOS(rx51_kp) = {
-	{ "rx51_kp" },
-};
-
-static const struct ns16550_plat rx51_serial = {
-	.base = CFG_SYS_NS16550_COM3,
-	.reg_shift = 2,
-	.clock = CFG_SYS_NS16550_CLK,
-	.fcr = UART_FCR_DEFVAL,
-};
-
-U_BOOT_DRVINFOS(rx51_uart) = {
-	{ "omap_serial", &rx51_serial },
-};
diff --git a/board/nokia/rx51/tag_omap.h b/board/nokia/rx51/tag_omap.h
deleted file mode 100644
index b99d6b7de17f..000000000000
--- a/board/nokia/rx51/tag_omap.h
+++ /dev/null
@@ -1,294 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * (C) Copyright 2011-2012
- * Pali Rohár <pali@kernel.org>
- *
- * (C) Copyright 2011
- * marcel@mesa.nl, Mesa Consulting B.V.
- *
- * (C) Copyright 2004-2005
- * Nokia Corporation
- */
-
-
-/*
- *  Code copied from maemo kernel 2.6.28 file
- *  arch/arm/plat-omap/include/mach/board.h
- *
- *  Information structures for board-specific data
- *
- *  Copyright (C) 2004	Nokia Corporation
- *  Written by Juha Yrjölä <juha.yrjola@nokia.com>
- */
-
-/* Different peripheral ids */
-#define OMAP_TAG_CLOCK		0x4f01
-#define OMAP_TAG_SERIAL_CONSOLE	0x4f03
-#define OMAP_TAG_USB		0x4f04
-#define OMAP_TAG_LCD		0x4f05
-#define OMAP_TAG_GPIO_SWITCH	0x4f06
-#define OMAP_TAG_UART		0x4f07
-#define OMAP_TAG_FBMEM		0x4f08
-#define OMAP_TAG_STI_CONSOLE	0x4f09
-#define OMAP_TAG_CAMERA_SENSOR	0x4f0a
-#define OMAP_TAG_PARTITION	0x4f0b
-#define OMAP_TAG_TEA5761	0x4f10
-#define OMAP_TAG_TMP105		0x4f11
-
-#define OMAP_TAG_BOOT_REASON	0x4f80
-#define OMAP_TAG_FLASH_PART_STR	0x4f81
-#define OMAP_TAG_VERSION_STR	0x4f82
-
-#define OMAP_TAG_NOKIA_BT	0x4e01
-#define OMAP_TAG_WLAN_CX3110X	0x4e02
-#define OMAP_TAG_CBUS		0x4e03
-#define OMAP_TAG_EM_ASIC_BB5	0x4e04
-
-
-struct omap_clock_config {
-	/* 0 for 12 MHz, 1 for 13 MHz and 2 for 19.2 MHz */
-	u8 system_clock_type;
-};
-
-struct omap_serial_console_config {
-	u8 console_uart;
-	u32 console_speed;
-};
-
-struct omap_sti_console_config {
-	unsigned enable:1;
-	u8 channel;
-};
-
-struct omap_usb_config {
-	/* Configure drivers according to the connectors on your board:
-	 *  - "A" connector (rectagular)
-	 *	... for host/OHCI use, set "register_host".
-	 *  - "B" connector (squarish) or "Mini-B"
-	 *	... for device/gadget use, set "register_dev".
-	 *  - "Mini-AB" connector (very similar to Mini-B)
-	 *	... for OTG use as device OR host, initialize "otg"
-	 */
-	unsigned	register_host:1;
-	unsigned	register_dev:1;
-	u8		otg;	/* port number, 1-based:  usb1 == 2 */
-
-	u8		hmc_mode;
-
-	/* implicitly true if otg:  host supports remote wakeup? */
-	u8		rwc;
-
-	/* signaling pins used to talk to transceiver on usbN:
-	 *  0 == usbN unused
-	 *  2 == usb0-only, using internal transceiver
-	 *  3 == 3 wire bidirectional
-	 *  4 == 4 wire bidirectional
-	 *  6 == 6 wire unidirectional (or TLL)
-	 */
-	u8		pins[3];
-};
-
-struct omap_lcd_config {
-	char panel_name[16];
-	char ctrl_name[16];
-	s16  nreset_gpio;
-	u8   data_lines;
-};
-
-struct omap_fbmem_config {
-	u32 start;
-	u32 size;
-};
-
-struct omap_gpio_switch_config {
-	char name[12];
-	u16 gpio;
-	u8 flags:4;
-	u8 type:4;
-	unsigned int key_code:24; /* Linux key code */
-};
-
-struct omap_uart_config {
-	/* Bit field of UARTs present; bit 0 --> UART1 */
-	unsigned int enabled_uarts;
-};
-
-struct omap_tea5761_config {
-	u16 enable_gpio;
-};
-
-struct omap_partition_config {
-	char name[16];
-	unsigned int size;
-	unsigned int offset;
-	/* same as in include/linux/mtd/partitions.h */
-	unsigned int mask_flags;
-};
-
-struct omap_flash_part_str_config {
-	char part_table[0];
-};
-
-struct omap_boot_reason_config {
-	char reason_str[12];
-};
-
-struct omap_version_config {
-	char component[12];
-	char version[12];
-};
-
-/*
- *  Code copied from maemo kernel 2.6.28 file
- *  arch/arm/plat-omap/include/mach/board-nokia.h
- *
- *  Information structures for Nokia-specific board config data
- *
- *  Copyright (C) 2005  Nokia Corporation
- */
-
-struct omap_bluetooth_config {
-	u8 chip_type;
-	u8 bt_wakeup_gpio;
-	u8 host_wakeup_gpio;
-	u8 reset_gpio;
-	u8 bt_uart;
-	u8 bd_addr[6];
-	u8 bt_sysclk;
-};
-
-struct omap_wlan_cx3110x_config {
-	u8 chip_type;
-	u8 reserverd;
-	s16 power_gpio;
-	s16 irq_gpio;
-	s16 spi_cs_gpio;
-};
-
-struct omap_cbus_config {
-	s16 clk_gpio;
-	s16 dat_gpio;
-	s16 sel_gpio;
-};
-
-struct omap_em_asic_bb5_config {
-	s16 retu_irq_gpio;
-	s16 tahvo_irq_gpio;
-};
-
-/*
- *  omap_tag handling
- *
- *  processing omap tag structures
- *
- *  Copyright (C) 2011  marcel@mesa.nl, Mesa Consulting B.V.
- *  Copyright (C) 2012  Pali Rohár <pali@kernel.org>
- */
-
-/* TI OMAP specific information */
-#define ATAG_BOARD	0x414f4d50
-
-struct tag_omap_header {
-	u16 tag;
-	u16 size;
-};
-
-struct tag_omap {
-	struct tag_omap_header hdr;
-	union {
-		struct omap_clock_config clock;
-		struct omap_serial_console_config serial_console;
-		struct omap_sti_console_config sti_console;
-		struct omap_usb_config usb;
-		struct omap_lcd_config lcd;
-		struct omap_fbmem_config fbmem;
-		struct omap_gpio_switch_config gpio_switch;
-		struct omap_uart_config uart;
-		struct omap_tea5761_config tea5761;
-		struct omap_partition_config partition;
-		struct omap_flash_part_str_config flash_part_str;
-		struct omap_boot_reason_config boot_reason;
-		struct omap_version_config version;
-		struct omap_bluetooth_config bluetooth;
-		struct omap_wlan_cx3110x_config wlan_cx3110x;
-		struct omap_cbus_config cbus;
-		struct omap_em_asic_bb5_config em_asic_bb5;
-	} u;
-};
-
-#define tag_omap_next(t)	((struct tag_omap *)((u8 *)(t) + \
-				(t)->hdr.size + sizeof(struct tag_omap_header)))
-
-#define OMAP_TAG_HEADER_CONFIG(config, type) \
-	.hdr.tag = config, \
-	.hdr.size = sizeof(struct type)
-
-#define OMAP_TAG_UART_CONFIG(p1) \
-	{ \
-		OMAP_TAG_HEADER_CONFIG(OMAP_TAG_UART, omap_uart_config), \
-		.u.uart.enabled_uarts = p1, \
-	}
-
-#define OMAP_TAG_SERIAL_CONSOLE_CONFIG(p1, p2) \
-	{ \
-		OMAP_TAG_HEADER_CONFIG(OMAP_TAG_SERIAL_CONSOLE, \
-			omap_serial_console_config), \
-		.u.serial_console.console_uart = p1, \
-		.u.serial_console.console_speed = p2, \
-	}
-
-#define OMAP_TAG_LCD_CONFIG(p1, p2, p3, p4) \
-	{ \
-		OMAP_TAG_HEADER_CONFIG(OMAP_TAG_LCD, omap_lcd_config), \
-		.u.lcd.panel_name = p1, \
-		.u.lcd.ctrl_name = p2, \
-		.u.lcd.nreset_gpio = p3, \
-		.u.lcd.data_lines = p4, \
-	}
-
-#define OMAP_TAG_GPIO_SWITCH_CONFIG(p1, p2, p3, p4, p5) \
-	{ \
-		OMAP_TAG_HEADER_CONFIG(OMAP_TAG_GPIO_SWITCH, \
-			omap_gpio_switch_config), \
-		.u.gpio_switch.name = p1, \
-		.u.gpio_switch.gpio = p2, \
-		.u.gpio_switch.flags = p3, \
-		.u.gpio_switch.type = p4, \
-		.u.gpio_switch.key_code = p5, \
-	}
-
-#define OMAP_TAG_WLAN_CX3110X_CONFIG(p1, p2, p3, p4, p5) \
-	{ \
-		OMAP_TAG_HEADER_CONFIG(OMAP_TAG_WLAN_CX3110X, \
-			omap_wlan_cx3110x_config), \
-		.u.wlan_cx3110x.chip_type = p1, \
-		.u.wlan_cx3110x.reserverd = p2, \
-		.u.wlan_cx3110x.power_gpio = p3, \
-		.u.wlan_cx3110x.irq_gpio = p4, \
-		.u.wlan_cx3110x.spi_cs_gpio = p5, \
-	}
-
-#define OMAP_TAG_PARTITION_CONFIG(p1, p2, p3, p4) \
-	{ \
-		OMAP_TAG_HEADER_CONFIG(OMAP_TAG_PARTITION, \
-			omap_partition_config), \
-		.u.partition.name = p1, \
-		.u.partition.size = p2, \
-		.u.partition.offset = p3, \
-		.u.partition.mask_flags = p4, \
-	}
-
-#define OMAP_TAG_BOOT_REASON_CONFIG(p1) \
-	{ \
-		OMAP_TAG_HEADER_CONFIG(OMAP_TAG_BOOT_REASON, \
-			omap_boot_reason_config), \
-		.u.boot_reason.reason_str = p1, \
-	}
-
-#define OMAP_TAG_VERSION_STR_CONFIG(p1, p2) \
-	{ \
-		OMAP_TAG_HEADER_CONFIG(OMAP_TAG_VERSION_STR, \
-			omap_version_config), \
-		.u.version.component = p1, \
-		.u.version.version = p2, \
-	}
diff --git a/configs/nokia_rx51_defconfig b/configs/nokia_rx51_defconfig
deleted file mode 100644
index 8e55069950fb..000000000000
--- a/configs/nokia_rx51_defconfig
+++ /dev/null
@@ -1,76 +0,0 @@
-CONFIG_ARM=y
-# CONFIG_SYS_THUMB_BUILD is not set
-CONFIG_SYS_L2CACHE_OFF=y
-CONFIG_ARCH_OMAP2PLUS=y
-CONFIG_SYS_MALLOC_LEN=0xc0000
-CONFIG_TARGET_NOKIA_RX51=y
-CONFIG_SYS_LOAD_ADDR=0x80008000
-CONFIG_OPTIMIZE_INLINING=y
-CONFIG_LTO=y
-# CONFIG_FIT is not set
-CONFIG_SUPPORT_RAW_INITRD=y
-CONFIG_BOOTDELAY=30
-CONFIG_AUTOBOOT_KEYED=y
-CONFIG_AUTOBOOT_MENU_SHOW=y
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run sdboot;run emmcboot;run attachboot;echo"
-CONFIG_USE_PREBOOT=y
-# CONFIG_SYS_DEVICE_NULLDEV is not set
-CONFIG_HUSH_PARSER=y
-CONFIG_SYS_CBSIZE=256
-CONFIG_SYS_PBSIZE=287
-# CONFIG_CMD_BDI is not set
-CONFIG_CMD_BOOTZ=y
-# CONFIG_BOOTM_NETBSD is not set
-# CONFIG_BOOTM_PLAN9 is not set
-# CONFIG_BOOTM_RTEMS is not set
-# CONFIG_BOOTM_VXWORKS is not set
-CONFIG_CMD_BOOTMENU=y
-# CONFIG_CMD_ELF is not set
-# CONFIG_CMD_IMI is not set
-# CONFIG_CMD_XIMG is not set
-# CONFIG_CMD_EXPORTENV is not set
-# CONFIG_CMD_IMPORTENV is not set
-# CONFIG_CMD_EDITENV is not set
-# CONFIG_CMD_SAVEENV is not set
-# CONFIG_CMD_ENV_EXISTS is not set
-# CONFIG_CMD_FLASH is not set
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_MTD=y
-CONFIG_CMD_ONENAND=y
-# CONFIG_CMD_SETEXPR is not set
-# CONFIG_CMD_SLEEP is not set
-CONFIG_CMD_EXT2=y
-CONFIG_CMD_EXT4=y
-CONFIG_CMD_FAT=y
-CONFIG_MTDIDS_DEFAULT="onenand0=onenand"
-CONFIG_MTDPARTS_DEFAULT="mtdparts=onenand:128k(bootloader)ro,384k(config),256k(log),2m(kernel),2m(initfs),-(rootfs)"
-CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
-# CONFIG_DM_WARN is not set
-# CONFIG_DM_DEVICE_REMOVE is not set
-# CONFIG_DM_SEQ_ALIAS is not set
-# CONFIG_BLOCK_CACHE is not set
-CONFIG_DM_I2C=y
-CONFIG_DM_KEYBOARD=y
-# CONFIG_MMC_HW_PARTITIONING is not set
-# CONFIG_MMC_VERBOSE is not set
-CONFIG_MMC_OMAP_HS=y
-CONFIG_MTD=y
-CONFIG_DM_SERIAL=y
-CONFIG_SPI=y
-CONFIG_USB=y
-CONFIG_USB_MUSB_UDC=y
-CONFIG_USB_OMAP3=y
-CONFIG_VIDEO=y
-CONFIG_VIDEO_LOGO=y
-# CONFIG_VIDEO_BPP8 is not set
-# CONFIG_VIDEO_BPP32 is not set
-CONFIG_SYS_WHITE_ON_BLACK=y
-CONFIG_SPLASH_SCREEN=y
-CONFIG_WATCHDOG_TIMEOUT_MSECS=31000
-CONFIG_WDT=y
-# CONFIG_GZIP is not set
diff --git a/doc/board/index.rst b/doc/board/index.rst
index 0194f0aaa3e2..35dd3bcf5fad 100644
--- a/doc/board/index.rst
+++ b/doc/board/index.rst
@@ -32,7 +32,6 @@ Board-specific doc
    lg/index
    mediatek/index
    microchip/index
-   nokia/index
    nxp/index
    openpiton/index
    phytec/index
diff --git a/doc/board/nokia/index.rst b/doc/board/nokia/index.rst
deleted file mode 100644
index b68c3c613164..000000000000
--- a/doc/board/nokia/index.rst
+++ /dev/null
@@ -1,9 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0+
-
-Nokia
-=====
-
-.. toctree::
-   :maxdepth: 2
-
-   rx51
diff --git a/doc/board/nokia/rx51.rst b/doc/board/nokia/rx51.rst
deleted file mode 100644
index 93502e2dfc05..000000000000
--- a/doc/board/nokia/rx51.rst
+++ /dev/null
@@ -1,250 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0+
-
-Nokia RX-51 aka N900
-====================
-
-The ``nokia_rx51_defconfig`` configuration file results in a ``u-boot.bin``
-which can be chainloaded by the Nokia second stage bootloader (NOLO) in QEMU or
-on a real N900. It does very little hardware configuration because NOLO has
-already configured the board. It is only needed to enable the internal eMMC
-memory via the twl4030 regulator which is not enabled by NOLO.
-
-.. code-block:: bash
-
-   make CROSS_COMPILE=arm-linux-gnueabi- nokia_rx51_defconfig u-boot.bin
-
-NOLO is expecting a kernel image and will treat any image it finds in
-OneNAND as such. This u-boot is intended to be flashed to the N900 like
-a kernel. In order to transparently boot the original kernel, it will be
-appended to ``u-boot.bin`` at 0x40000. NOLO will load the entire image into
-(random) memory and execute U-Boot, which saves hardware revision, boot reason
-and boot mode ATAGs set by NOLO. Then the bootscripts will attempt to load
-``uImage``, ``zImage`` or ``boot.scr`` file from a FAT or ext2/3/4 filesystem
-on external SD card or internal eMMC memory. If this fails or keyboard is
-closed then the appended kernel image will be booted using some generated
-and some stored ATAGs (see boot order).
-
-For generating combined image of U-Boot and kernel (either in uImage or zImage
-format) there is a simple script called ``u-boot-gen-combined``. It is available
-in following repository: https://github.com/pali/u-boot-maemo.
-
-To generate the ``combined.bin`` image from ``u-boot.bin`` and ``kernel.bin``
-(in either uImage or zImage format) use:
-
-.. code-block:: bash
-
-   sh u-boot-gen-combined u-boot.bin kernel.bin combined.bin
-
-The original Maemo Fremantle PR1.3 zImage kernel binary is available at:
-http://repository.maemo.org/pool/maemo5.0/free/k/kernel/kernel_2.6.28-20103103+0m5_armel.deb
-
-To unpack it (from DEB/AR, TAR and FIASCO) execute the following commands:
-
-.. code-block:: bash
-
-   ar x kernel_2.6.28-20103103+0m5_armel.deb data.tar.gz
-   tar -O -xf data.tar.gz ./boot/zImage-2.6.28-20103103+0m5.fiasco > kernel_2.6.28-20103103+0m5.fiasco
-   0xFFFF -M kernel_2.6.28-20103103+0m5.fiasco -u
-
-The flashed image must start with a 2 KiB ``NOLO!img`` header which contains
-size of the image. The header consists of the bytes
-``NOLO!img\x02\x00\x00\x00\x00\x00\x00\x00`` followed by the 4 byte little
-endian size of the image. The rest of the 2 KiB header just contains zero bytes.
-
-The Nokia proprietary flasher and also the open source 0xFFFF flasher
-automatically prepend the required ``NOLO!img`` header and both applications
-expect that the image does not contain a ``NOLO!img`` header. Adding a
-``NOLO!img`` header is required only in case of using the ``nandwrite`` tool for
-flashing.
-
-The open source 0xFFFF flasher is available in the following repository:
-https://github.com/pali/0xFFFF
-
-It is possible to load ``u-boot.bin`` via USB to the N900 RAM and boot it
-without needing to flash it. This is done via 0xFFFF running on the host PC:
-
-.. code-block:: bash
-
-   0xFFFF -m u-boot.bin -l -b
-
-0xFFFF also supports flashing a kernel image either via USB or directly on
-N900 device. Flashing u-boot/kernel/combined image is done as:
-
-.. code-block:: bash
-
-   0xFFFF -m combined.bin -f
-
-Via 0xFFFF it is also possible to generate a standard flashable image in
-Nokia FIASCO format which contains metadata information like device
-identification (RX-51) and version string (v2021.04):
-
-.. code-block:: bash
-
-   0xFFFF -m RX-51:v2021.04:kernel:u-boot.bin -g u-boot.fiasco
-
-There is support for the hardware watchdog. The hardware watchdog is started by
-NOLO so U-Boot must reset the watchdog to prevent rebooting the device (but not
-very often, max every 2 seconds). There is also support for framebuffer display
-output with ANSI escape codes and the N900 hardware keyboard input.
-
-When U-Boot is starting it sets the IBE bit in the Auxiliary Control Register,
-which is needed for Thumb-2 ISA support. This is a workaround for erratum
-430973.
-
-Default boot order
-------------------
-
-0. if keyboard is closed boot automatically attached kernel image
-1. try boot from external SD card
-2. try boot from internal eMMC memory
-3. try boot from attached kernel image
-
-Boot from SD or eMMC in this order:
-
-1. boot from FAT partition
-
-    a. find ``boot.scr`` on first FAT partition
-    b. find ``uImage`` on first FAT partition
-    c. find ``zImage`` on first FAT partition
-    d. same order for 2nd - 4th FAT partition
-
-2. same as 1. but for ext2/3/4 partition
-
-Available additional commands/variables
----------------------------------------
-
-* run sdboot - Boot from external SD card (see boot order)
-* run emmcboot - Boot from internal eMMC memory (see boot order)
-* run attachboot - Boot attached kernel image (attached to U-Boot binary)
-
-\
-
-* run scriptload - Load boot script ``${mmcscriptfile}``
-* run scriptboot - Run loaded boot script
-* run kernload - Load kernel image ``${mmckernfile}``
-* run initrdload - Load initrd image ``${mmcinitrdfile}``
-* run kernboot - Boot loaded kernel image
-* run kerninitrdboot - Boot loaded kernel image with loaded initrd image
-
-\
-
-* run trymmcscriptboot - Try to load and boot script ``${mmcscriptfile}``
-* run trymmckernboot - Try to load and boot kernel image ``${mmckernfile}``
-* run trymmckerninitrdboot - Try to load and boot kernel image ``${mmckernfile}``
-  with initrd image ``${mmcinitrdfile}``
-
-Additional variables for loading files from mmc
------------------------------------------------
-
-* mmc ``${mmcnum}`` (0 - external, 1 - internal)
-* partition number ``${mmcpart}`` (1 - 4)
-* partition type ``${mmctype}`` (fat, ext2, ext4; ext2 is just alias for ext4)
-
-Additional variables for booting a kernel
------------------------------------------
-
-* ``setup_omap_atag`` - Add OMAP table into atags structure (needed for maemo kernel)
-* ``setup_console_atag`` - Enable serial console in OMAP table
-* ``setup_boot_reason_atag`` - Change boot reason in OMAP table
-* ``setup_boot_mode_atag`` - Change boot mode in OMAP table
-
-Variable ``setup_omap_atag`` is automatically set when booting attached kernel.
-When variable ``setup_omap_atag`` is set, variable ``setup_console_atag`` is unset
-and u-boot standard output is set to serial then ``setup_console_atag`` is
-automatically set to 1. So output from Maemo kernel would go to serial port.
-
-UBIFS support
--------------
-
-UBIFS support is disabled, because U-Boot image is too big and cannot be
-flashed with attached kernel image to RX-51 kernel nand area. For enabling
-UBIFS support add following lines into file ``configs/nokia_rx51_defconfig``::
-
-    CONFIG_CMD_UBI=y
-    CONFIG_CMD_UBIFS=y
-    CONFIG_MTD_UBI_BEB_LIMIT=10
-
-Early output
-------------
-
-Early U-Boot output can be enabled on serial console by adding following lines
-into file ``configs/nokia_rx51_defconfig``::
-
-    CONFIG_DEBUG_UART=y
-    CONFIG_DEBUG_UART_OMAP=y
-    CONFIG_DEBUG_UART_SHIFT=2
-    CONFIG_DEBUG_UART_BASE=0x49020000
-    CONFIG_DEBUG_UART_CLOCK=48000000
-
-Note that early output is not available on USB tty console.
-
-Verbose debug output
---------------------
-
-Verbose debug output with maximal log level can be enabled by adding following
-lines into file ``configs/nokia_rx51_defconfig``::
-
-    CONFIG_DM_DEBUG=y
-    CONFIG_LOG=y
-    CONFIG_LOGLEVEL=9
-    CONFIG_LOG_MAX_LEVEL=9
-    CONFIG_LOG_DEFAULT_LEVEL=9
-
-And compiling U-Boot by additional make parameter ``KCPPFLAGS=-DLOG_DEBUG``.
-
-Run in QEMU
------------
-
-Download and compile Linaro version of qemu which contains ``n900`` qemu
-machine. Source code is available in qemu-linaro git repository and the
-last working version is at commit 8f8d8e0796efe1a6f34cdd83fb798f3c41217ec1.
-
-Use following commands to compile ``qemu-system-arm`` binary with ``n900``
-qemu machine support:
-
-.. code-block:: bash
-
-    git clone https://git.linaro.org/qemu/qemu-linaro.git
-    cd qemu-linaro
-    git checkout 8f8d8e0796efe1a6f34cdd83fb798f3c41217ec1
-    ./configure --enable-system --target-list=arm-softmmu --disable-werror
-    make -j4
-    cd ..
-    ln -s qemu-linaro/arm-softmmu/qemu-system-arm .
-
-Using ``n900`` qemu machine requires proprietary Nokia qemu ``qflasher`` tool
-(in reality it is just generator of qemu MTD images) with first stage images
-(``xloader-qemu.bin`` and ``secondary-qemu.bin``), similar what is required
-on the real HW. License of flasher and images allows non-commercial
-redistribution and it is available at maemo.org website:
-
-.. code-block:: bash
-
-    wget -c http://repository.maemo.org/qemu-n900/qemu-n900.tar.gz
-    tar -xf qemu-n900.tar.gz
-
-To generate qemu bootable MTD image ``mtd.img`` from U-Boot binary
-``u-boot.bin`` and unpacked first stage images, run following command:
-
-.. code-block:: bash
-
-    ./qflasher -v -x xloader-qemu.bin -s secondary-qemu.bin -k u-boot.bin -m rx51 -o mtd.img
-
-Instead of ``u-boot.bin`` binary it is possible to also used combined
-U-Boot + kernel binary ``combined.bin``.
-
-Finally, to boot ``mtd.img`` with graphics display and keyboard with optional
-serial console on current terminal, run:
-
-.. code-block:: bash
-
-    ./qemu-system-arm -M n900 -mtdblock mtd.img -serial /dev/tty
-
-Additionally it is possible to emulate also eMMC and uSD card by appending
-qemu ``-sd`` arguments:
-
-.. code-block:: bash
-
-    ./qemu-system-arm -M n900 -mtdblock mtd.img -sd emmc.img -sd sd.img -serial /dev/tty
-
-For more examples, look into the ``test/nokia_rx51_test.sh`` CI testing script.
diff --git a/include/configs/nokia_rx51.h b/include/configs/nokia_rx51.h
deleted file mode 100644
index 54eea322dd3f..000000000000
--- a/include/configs/nokia_rx51.h
+++ /dev/null
@@ -1,174 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * (C) Copyright 2011-2012
- * Pali Rohár <pali@kernel.org>
- *
- * (C) Copyright 2010
- * Alistair Buxton <a.j.buxton@gmail.com>
- *
- * Derived from Beagle Board code:
- * (C) Copyright 2006-2008
- * Texas Instruments.
- * Richard Woodruff <r-woodruff2@ti.com>
- * Syed Mohammed Khasim <x0khasim@ti.com>
- *
- * Configuration settings for the Nokia RX-51 aka N900.
- */
-
-#ifndef __CONFIG_H
-#define __CONFIG_H
-
-/*
- * High Level Configuration Options
- */
-
-#include <asm/arch/cpu.h>		/* get chip and board defs */
-#include <asm/arch/omap.h>
-#include <asm/arch/mem.h>
-#include <linux/stringify.h>
-
-/* Clock Defines */
-#define V_OSCK			26000000	/* Clock output from T2 */
-#define V_SCLK			(V_OSCK >> 1)
-
-/*
- * Hardware drivers
- */
-
-/*
- * NS16550 Configuration
- */
-#define V_NS16550_CLK		48000000		/* 48MHz (APLL96/2) */
-
-#define CFG_SYS_NS16550_CLK		V_NS16550_CLK
-
-/*
- * select serial console configuration
- */
-#define CFG_SYS_NS16550_COM3		OMAP34XX_UART3
-
-#define CFG_SYS_BAUDRATE_TABLE { 4800, 9600, 19200, 38400, 57600, 115200 }
-
-#define GPIO_SLIDE			71
-
-/*
- * Board ONENAND Info.
- */
-
-#define CFG_SYS_ONENAND_BASE		ONENAND_MAP
-
-/* Environment information */
-#define CFG_EXTRA_ENV_SETTINGS \
-	"usbtty=cdc_acm\0" \
-	"stdin=usbtty,serial,keyboard\0" \
-	"stdout=usbtty,serial,vidconsole\0" \
-	"stderr=usbtty,serial,vidconsole\0" \
-	"slide=gpio input " __stringify(GPIO_SLIDE) "\0" \
-	"switchmmc=mmc dev ${mmcnum}\0" \
-	"kernaddr=0x82008000\0" \
-	"initrdaddr=0x84008000\0" \
-	"scriptaddr=0x86008000\0" \
-	"fileloadaddr=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
-	"fileload=${mmctype}load mmc ${mmcnum}:${mmcpart} " \
-		"${fileloadaddr} ${mmcfile}\0" \
-	"kernload=setenv fileloadaddr ${kernaddr};" \
-		"setenv mmcfile ${mmckernfile};" \
-		"run fileload\0" \
-	"initrdload=setenv fileloadaddr ${initrdaddr};" \
-		"setenv mmcfile ${mmcinitrdfile};" \
-		"run fileload\0" \
-	"scriptload=setenv fileloadaddr ${scriptaddr};" \
-		"setenv mmcfile ${mmcscriptfile};" \
-		"run fileload\0" \
-	"scriptboot=echo Running ${mmcscriptfile} from mmc " \
-		"${mmcnum}:${mmcpart} ...; source ${scriptaddr}\0" \
-	"kernboot=echo Booting ${mmckernfile} from mmc " \
-		"${mmcnum}:${mmcpart} ...; bootm ${kernaddr} || " \
-			"bootz ${kernaddr}\0" \
-	"kerninitrdboot=echo Booting ${mmckernfile} ${mmcinitrdfile} from mmc "\
-		"${mmcnum}:${mmcpart} ...; bootm ${kernaddr} ${initrdaddr} || " \
-			"bootz ${kernaddr} ${initrdaddr}\0" \
-	"attachboot=echo Booting attached kernel image ...;" \
-		"setenv setup_omap_atag 1;" \
-		"bootm ${attkernaddr} || bootz ${attkernaddr};" \
-		"setenv setup_omap_atag\0" \
-	"trymmcscriptboot=run switchmmc && run scriptload && run scriptboot\0" \
-	"trymmckernboot=run switchmmc && run kernload && run kernboot\0" \
-	"trymmckerninitrdboot=run switchmmc && run initrdload && " \
-		"run kernload && run kerninitrdboot\0" \
-	"trymmcpartboot=setenv mmcscriptfile boot.scr; run trymmcscriptboot;" \
-		"setenv mmckernfile uImage; run trymmckernboot;" \
-		"setenv mmckernfile zImage; run trymmckernboot\0" \
-	"trymmcallpartboot=setenv mmcpart 1; run trymmcpartboot;" \
-		"setenv mmcpart 2; run trymmcpartboot;" \
-		"setenv mmcpart 3; run trymmcpartboot;" \
-		"setenv mmcpart 4; run trymmcpartboot\0" \
-	"trymmcboot=if run switchmmc; then " \
-			"setenv mmctype fat;" \
-			"run trymmcallpartboot;" \
-			"setenv mmctype ext4;" \
-			"run trymmcallpartboot;" \
-		"fi\0" \
-	"emmcboot=setenv mmcnum 1; run trymmcboot\0" \
-	"sdboot=setenv mmcnum 0; run trymmcboot\0" \
-	"trymmcbootmenu=setenv mmctype fat && run trymmcscriptboot || " \
-		"setenv mmctype ext4 && run trymmcscriptboot\0" \
-	"preboot=setenv mmcpart 1; setenv mmcscriptfile bootmenu.scr;" \
-		"setenv mmcnum 0 && run trymmcbootmenu || " \
-		"setenv mmcnum 1 && run trymmcbootmenu;" \
-		"if run slide; then true; else " \
-			"setenv bootmenu_delay 0;" \
-			"setenv bootdelay 0;" \
-		"fi\0" \
-	"menucmd=bootmenu\0" \
-	"bootmenu_0=Attached kernel=run attachboot\0" \
-	"bootmenu_1=Internal eMMC=run emmcboot\0" \
-	"bootmenu_2=External SD card=run sdboot\0" \
-	"bootmenu_3=U-Boot boot order=boot\0" \
-	"bootmenu_delay=30\0" \
-	""
-
-#define CFG_POSTBOOTMENU \
-	"echo;" \
-	"echo Extra commands:;" \
-	"echo run sdboot - Boot from SD card slot.;" \
-	"echo run emmcboot - Boot internal eMMC memory.;" \
-	"echo run attachboot - Boot attached kernel image.;" \
-	"echo"
-
-/*
- * OMAP3 has 12 GP timers, they can be driven by the system clock
- * (12/13/16.8/19.2/38.4MHz) or by 32KHz clock. We use 13MHz (V_SCLK).
- * This rate is divided by a local divisor.
- */
-#define CFG_SYS_TIMERBASE		(OMAP34XX_GPT2)
-
-/*
- * Physical Memory Map
- */
-#define PHYS_SDRAM_1			OMAP34XX_SDRC_CS0
-
-/*
- * FLASH and environment organization
- */
-
-#define CFG_SYS_SDRAM_BASE		PHYS_SDRAM_1
-#define CFG_SYS_INIT_RAM_ADDR	0x4020f800
-#define CFG_SYS_INIT_RAM_SIZE	0x800
-
-/*
- * Attached kernel image
- */
-
-#define SDRAM_SIZE			0x10000000	/* 256 MB */
-#define SDRAM_END			(CFG_SYS_SDRAM_BASE + SDRAM_SIZE)
-
-#define IMAGE_MAXSIZE			0x1FF800	/* 2 MB - 2 kB */
-#define KERNEL_OFFSET			0x40000		/* 256 kB */
-#define KERNEL_MAXSIZE			(IMAGE_MAXSIZE-KERNEL_OFFSET)
-#define KERNEL_ADDRESS			(SDRAM_END-KERNEL_MAXSIZE)
-
-/* Reserve protected RAM for attached kernel */
-#define CFG_PRAM			((KERNEL_MAXSIZE >> 10)+1)
-
-#endif /* __CONFIG_H */
diff --git a/test/nokia_rx51_test.sh b/test/nokia_rx51_test.sh
deleted file mode 100755
index dca9ef3027b7..000000000000
--- a/test/nokia_rx51_test.sh
+++ /dev/null
@@ -1,420 +0,0 @@
-#!/bin/bash -e
-# SPDX-License-Identifier: GPL-2.0+
-# (C) 2020 Pali Rohár <pali@kernel.org>
-
-# External tools needed for this test:
-echo '
-	wget
-	git
-	truncate
-	tar
-	dpkg
-	dd
-	make
-	gcc
-	arm-linux-gnueabi-gcc
-	fakeroot		(homepage http://fakeroot-ng.lingnu.com/)
-	mcopy			(from mtools, homepage http://www.gnu.org/software/mtools/)
-	mformat			(from mtools, homepage http://www.gnu.org/software/mtools/)
-	/usr/sbin/mkfs.ubifs	(from mtd-utils, homepage http://www.linux-mtd.infradead.org/)
-	/usr/sbin/ubinize	(from mtd-utils, homepage http://www.linux-mtd.infradead.org/)
-	/lib/ld-linux.so.2	(32-bit x86 version of LD loader, needed for qflasher)
-' | while read tool info; do
-	if test -z "$tool"; then continue; fi
-	if ! which $tool 1>/dev/null 2>&1; then
-		echo "Tool $tool was not found and is required to run this test"
-		echo "First install $tool $info"
-		exit 1
-	fi
-done || exit 1
-
-echo
-echo "============================================================"
-echo "========== Compiling U-Boot for Nokia RX-51 board =========="
-echo "============================================================"
-echo
-
-# First compile u-boot-ubifs.bin binary with UBI/UBIFS support for Nokia RX-51 board according to doc/board/nokia/rx51.rst
-make nokia_rx51_config
-cat >> .config << EOF
-CONFIG_CMD_UBI=y
-CONFIG_CMD_UBIFS=y
-CONFIG_MTD_UBI_BEB_LIMIT=10
-EOF
-make olddefconfig
-make -j4 u-boot.bin CROSS_COMPILE=arm-linux-gnueabi-
-mv u-boot.bin u-boot-ubifs.bin
-
-# Then compile standard u-boot.bin binary for Nokia RX-51 board
-make nokia_rx51_config
-make -j4 u-boot.bin CROSS_COMPILE=arm-linux-gnueabi-
-
-# And then do all stuff in temporary directory
-mkdir -p nokia_rx51_tmp
-cd nokia_rx51_tmp
-
-test -f mkimage || ln -s ../tools/mkimage .
-test -f u-boot.bin || ln -s ../u-boot.bin .
-test -f u-boot-ubifs.bin || ln -s ../u-boot-ubifs.bin .
-
-echo
-echo "=========================================================================="
-echo "========== Downloading and compiling qemu from qemu-linaro fork =========="
-echo "=========================================================================="
-echo
-
-# Download and compile linaro version qemu which has support for n900 machine
-# Last working commit is 8f8d8e0796efe1a6f34cdd83fb798f3c41217ec1
-if ! test -f qemu-system-arm; then
-	test -d qemu-linaro || git clone https://git.linaro.org/qemu/qemu-linaro.git
-	cd qemu-linaro
-	git checkout 8f8d8e0796efe1a6f34cdd83fb798f3c41217ec1
-	./configure --enable-system --target-list=arm-softmmu --python=/usr/bin/python2.7 --disable-sdl --disable-gtk --disable-curses --audio-drv-list= --audio-card-list= --disable-werror --disable-xen --disable-xen-pci-passthrough --disable-brlapi --disable-vnc --disable-curl --disable-slirp --disable-kvm --disable-user --disable-linux-user --disable-bsd-user --disable-guest-base --disable-uuid --disable-vde --disable-linux-aio --disable-cap-ng --disable-attr --disable-blobs --disable-docs --disable-spice --disable-libiscsi --disable-smartcard-nss --disable-usb-redir --disable-guest-agent --disable-seccomp --disable-glusterfs --disable-nptl --disable-fdt
-	make -j4
-	cd ..
-	ln -s qemu-linaro/arm-softmmu/qemu-system-arm .
-fi
-
-echo
-echo "==================================================="
-echo "========== Downloading external binaries =========="
-echo "==================================================="
-echo
-
-# Download qflasher and nolo images
-# This is proprietary qemu flasher tool with first stage images, but license allows non-commercial redistribution
-if ! test -f qflasher || ! test -f xloader-qemu.bin || ! test -f secondary-qemu.bin; then
-	test -f qemu-n900.tar.gz || wget -c http://repository.maemo.org/qemu-n900/qemu-n900.tar.gz
-	tar -xf qemu-n900.tar.gz
-fi
-
-# Download Maemo script u-boot-gen-combined
-if ! test -f u-boot-gen-combined; then
-	test -d u-boot-maemo || git clone https://github.com/pali/u-boot-maemo.git
-	chmod +x u-boot-maemo/debian/u-boot-gen-combined
-	ln -s u-boot-maemo/debian/u-boot-gen-combined .
-fi
-
-# Download Maemo fiasco kernel
-if ! test -d kernel_2.6.28; then
-	test -f kernel_2.6.28-20103103+0m5_armel.deb || wget -c http://repository.maemo.org/pool/maemo5.0/free/k/kernel/kernel_2.6.28-20103103+0m5_armel.deb
-	dpkg -x kernel_2.6.28-20103103+0m5_armel.deb kernel_2.6.28
-fi
-
-# Download Maemo libc
-if ! test -d libc6_2.5.1; then
-	test -f libc6_2.5.1-1eglibc27+0m5_armel.deb || wget -c http://repository.maemo.org/pool/maemo5.0/free/g/glibc/libc6_2.5.1-1eglibc27+0m5_armel.deb
-	dpkg -x libc6_2.5.1-1eglibc27+0m5_armel.deb libc6_2.5.1
-fi
-
-# Download Maemo busybox
-if ! test -d busybox_1.10.2; then
-	test -f busybox_1.10.2.legal-1osso30+0m5_armel.deb || wget -c http://repository.maemo.org/pool/maemo5.0/free/b/busybox/busybox_1.10.2.legal-1osso30+0m5_armel.deb
-	dpkg -x busybox_1.10.2.legal-1osso30+0m5_armel.deb busybox_1.10.2
-fi
-
-echo
-echo "======================================="
-echo "========== Generating images =========="
-echo "======================================="
-echo
-
-# Generate kernel image in zImage and uImage format from FIASCO format
-dd if=kernel_2.6.28/boot/zImage-2.6.28-20103103+0m5.fiasco of=zImage-2.6.28-omap1 skip=95 bs=1
-./mkimage -A arm -O linux -T kernel -C none -a 80008000 -e 80008000 -n zImage-2.6.28-omap1 -d zImage-2.6.28-omap1 uImage-2.6.28-omap1
-
-# Generate rootfs directory
-mkdir -p rootfs
-mkdir -p rootfs/dev/
-mkdir -p rootfs/bin/
-mkdir -p rootfs/sbin/
-mkdir -p rootfs/lib/
-cp -a busybox_1.10.2/bin/busybox rootfs/bin/
-cp -a libc6_2.5.1/lib/ld-linux.so.3 rootfs/lib/
-cp -a libc6_2.5.1/lib/ld-2.5.so rootfs/lib/
-cp -a libc6_2.5.1/lib/libc.so.6 rootfs/lib/
-cp -a libc6_2.5.1/lib/libc-2.5.so rootfs/lib/
-cp -a libc6_2.5.1/lib/libcrypt.so.1 rootfs/lib/
-cp -a libc6_2.5.1/lib/libcrypt-2.5.so rootfs/lib/
-test -f rootfs/bin/sh || ln -sf busybox rootfs/bin/sh
-test -f rootfs/sbin/poweroff || ln -sf ../bin/busybox rootfs/sbin/poweroff
-cat > rootfs/sbin/preinit << EOF
-#!/bin/sh
-echo
-echo "Successfully booted"
-echo
-/sbin/poweroff -f
-EOF
-chmod +x rootfs/sbin/preinit
-
-# Generate ubifs image from rootfs directory
-# NOTE: Character device on host filesystem can be created only by root
-#       But we do not need it on host filesystem, just in ubifs image
-#       So run mknod and mkfs.ubifs commands under fakeroot program
-#       which via LD_PRELOAD simulate mknod() and stat() functions
-#       so mkfs.ubifs will see dev/console as character device and
-#       put it correctly as character device into final ubifs image
-#       Therefore we can run whole script as non-root nobody user
-fakeroot sh -c '
-	rm -f rootfs/dev/console;
-	mknod rootfs/dev/console c 5 1;
-	/usr/sbin/mkfs.ubifs -m 2048 -e 129024 -c 2047 -r rootfs ubifs.img;
-'
-
-# Generate ubi image with rootfs on first volume
-cat > ubi.ini << EOF
-[rootfs]
-mode=ubi
-image=ubifs.img
-vol_id=0
-vol_size=230MiB # 1870 LEBs
-vol_type=dynamic
-vol_name=rootfs
-vol_alignment=1
-vol_flags=autoresize
-EOF
-/usr/sbin/ubinize -o ubi.img -p 128KiB -m 2048 -s 512 ubi.ini
-
-# Generate ubi image with rootfs on first volume and kernel in zImage format on second volume for UBI booting
-cp ubi.ini ubi_with_kernel.ini
-cat >> ubi_with_kernel.ini << EOF
-[kernel]
-mode=ubi
-image=zImage-2.6.28-omap1
-vol_id=1
-vol_size=2MiB
-vol_type=dynamic
-vol_name=kernel
-vol_alignment=1
-EOF
-/usr/sbin/ubinize -o ubi_with_kernel.img -p 128KiB -m 2048 -s 512 ubi_with_kernel.ini
-
-# Generate bootmenu for U-Boot serial console testing
-cat > bootmenu_uboot << EOF
-setenv bootmenu_0 'Serial console test=echo; echo "Testing serial console"; echo; echo "Successfully booted"; echo; poweroff';
-setenv bootmenu_1;
-setenv bootmenu_delay 1;
-setenv bootdelay 1;
-EOF
-./mkimage -A arm -O linux -T script -C none -a 0 -e 0 -n bootmenu_uboot -d bootmenu_uboot bootmenu_uboot.scr
-
-# Generate bootmenu for eMMC booting (uImage)
-cat > bootmenu_emmc << EOF
-setenv bootmenu_0 'uImage-2.6.28-omap1 from eMMC=setenv mmcnum 1; setenv mmcpart 1; setenv mmctype fat; setenv bootargs; setenv setup_omap_atag 1; setenv mmckernfile uImage-2.6.28-omap1; run trymmckernboot';
-setenv bootmenu_1;
-setenv bootmenu_delay 1;
-setenv bootdelay 1;
-EOF
-./mkimage -A arm -O linux -T script -C none -a 0 -e 0 -n bootmenu_emmc -d bootmenu_emmc bootmenu_emmc.scr
-
-# Generate bootmenu for eMMC booting (zImage)
-cat > bootmenu_emmc2 << EOF
-setenv bootmenu_0 'zImage-2.6.28-omap1 from eMMC=setenv mmcnum 1; setenv mmcpart 1; setenv mmctype fat; setenv bootargs; setenv setup_omap_atag 1; setenv mmckernfile zImage-2.6.28-omap1; run trymmckernboot';
-setenv bootmenu_1;
-setenv bootmenu_delay 1;
-setenv bootdelay 1;
-EOF
-./mkimage -A arm -O linux -T script -C none -a 0 -e 0 -n bootmenu_emmc2 -d bootmenu_emmc2 bootmenu_emmc2.scr
-
-# Generate bootmenu for OneNAND booting (uImage)
-cat > bootmenu_nand << EOF
-setenv bootmenu_0 'uImage-2.6.28-omap1 from OneNAND=setenv bootargs; setenv setup_omap_atag 1; mtd read initfs \${kernaddr} && bootm \${kernaddr}';
-setenv bootmenu_1;
-setenv bootmenu_delay 1;
-setenv bootdelay 1;
-EOF
-./mkimage -A arm -O linux -T script -C none -a 0 -e 0 -n bootmenu_nand -d bootmenu_nand bootmenu_nand.scr
-
-# Generate bootmenu for UBI booting (zImage)
-cat > bootmenu_ubi << EOF
-setenv bootmenu_0 'zImage-2.6.28-omap1 from UBI=setenv bootargs; setenv setup_omap_atag 1; ubi part rootfs && ubi read \${kernaddr} kernel && bootz \${kernaddr}';
-setenv bootmenu_1;
-setenv bootmenu_delay 1;
-setenv bootdelay 1;
-EOF
-./mkimage -A arm -O linux -T script -C none -a 0 -e 0 -n bootmenu_ubi -d bootmenu_ubi bootmenu_ubi.scr
-
-# Generate bootmenu for default booting
-cat > bootmenu_default << EOF
-setenv bootmenu_delay 1;
-setenv bootdelay 1;
-EOF
-./mkimage -A arm -O linux -T script -C none -a 0 -e 0 -n bootmenu_default -d bootmenu_default bootmenu_default.scr
-
-# Generate combined image from u-boot and Maemo fiasco kernel
-./u-boot-gen-combined u-boot.bin zImage-2.6.28-omap1 combined_zimage.bin
-./u-boot-gen-combined u-boot.bin uImage-2.6.28-omap1 combined_uimage.bin
-
-# Generate combined hack image from u-boot and Maemo fiasco kernel (kernel starts at 2MB offset and qflasher puts 2kB header before supplied image)
-cp u-boot.bin combined_hack.bin
-dd if=uImage-2.6.28-omap1 of=combined_hack.bin bs=1024 seek=$((2048-2))
-
-# Generate FAT32 eMMC image for U-Boot serial console testing
-truncate -s 50MiB emmc_uboot.img
-mformat -m 0xf8 -F -h 4 -s 16 -c 1 -t $((50*1024*1024/(4*16*512))) :: -i emmc_uboot.img
-mcopy bootmenu_uboot.scr ::/bootmenu.scr -i emmc_uboot.img
-
-# Generate FAT32 eMMC image for eMMC booting (uImage)
-truncate -s 50MiB emmc_emmc.img
-mformat -m 0xf8 -F -h 4 -s 16 -c 1 -t $((50*1024*1024/(4*16*512))) :: -i emmc_emmc.img
-mcopy uImage-2.6.28-omap1 ::/uImage-2.6.28-omap1 -i emmc_emmc.img
-mcopy bootmenu_emmc.scr ::/bootmenu.scr -i emmc_emmc.img
-
-# Generate FAT32 eMMC image for eMMC booting (zImage)
-truncate -s 50MiB emmc_emmc2.img
-mformat -m 0xf8 -F -h 4 -s 16 -c 1 -t $((50*1024*1024/(4*16*512))) :: -i emmc_emmc2.img
-mcopy zImage-2.6.28-omap1 ::/zImage-2.6.28-omap1 -i emmc_emmc2.img
-mcopy bootmenu_emmc2.scr ::/bootmenu.scr -i emmc_emmc2.img
-
-# Generate FAT32 eMMC image for OneNAND booting (uImage)
-truncate -s 50MiB emmc_nand.img
-mformat -m 0xf8 -F -h 4 -s 16 -c 1 -t $((50*1024*1024/(4*16*512))) :: -i emmc_nand.img
-mcopy bootmenu_nand.scr ::/bootmenu.scr -i emmc_nand.img
-
-# Generate FAT32 eMMC image for UBI booting (zImage)
-truncate -s 50MiB emmc_ubi.img
-mformat -m 0xf8 -F -h 4 -s 16 -c 1 -t $((50*1024*1024/(4*16*512))) :: -i emmc_ubi.img
-mcopy bootmenu_ubi.scr ::/bootmenu.scr -i emmc_ubi.img
-
-# Generate FAT32 eMMC image for default booting
-truncate -s 50MiB emmc_default.img
-mformat -m 0xf8 -F -h 4 -s 16 -c 1 -t $((50*1024*1024/(4*16*512))) :: -i emmc_default.img
-mcopy bootmenu_default.scr ::/bootmenu.scr -i emmc_default.img
-
-# Generate MTD image for U-Boot serial console testing
-rm -f mtd_uboot.img
-./qflasher -v -x xloader-qemu.bin -s secondary-qemu.bin -k u-boot.bin -m rx51 -o mtd_uboot.img
-
-# Generate MTD image for RAM booting from bootloader nolo images, compiled image and rootfs image
-rm -f mtd_ram.img
-./qflasher -v -x xloader-qemu.bin -s secondary-qemu.bin -k combined_uimage.bin -r ubi.img -m rx51 -o mtd_ram.img
-rm -f mtd_ram2.img
-./qflasher -v -x xloader-qemu.bin -s secondary-qemu.bin -k combined_zimage.bin -r ubi.img -m rx51 -o mtd_ram2.img
-
-# Generate MTD image for eMMC booting from bootloader nolo images, u-boot image and rootfs image
-rm -f mtd_emmc.img
-./qflasher -v -x xloader-qemu.bin -s secondary-qemu.bin -k u-boot.bin -r ubi.img -m rx51 -o mtd_emmc.img
-
-# Generate MTD image for OneNAND booting from bootloader nolo images, combined hacked image and rootfs image
-# Kernel image is put into initfs area, but qflasher reject to copy kernel image into initfs area because it does not have initfs signature
-# This is hack to workaround this problem, tell qflasher that kernel area for u-boot is bigger and put big combined hacked image (u-boot + kernel with correct offset)
-rm -f mtd_nand.img
-./qflasher -v -x xloader-qemu.bin -s secondary-qemu.bin -k combined_hack.bin -r ubi.img -m rx51 -p k=4094,i=2 -o mtd_nand.img
-
-# Generate MTD image for UBI booting from bootloader nolo images, u-boot image with UBI/UBIFS support and rootfs image with kernel volume
-rm -f mtd_ubi.img
-./qflasher -v -x xloader-qemu.bin -s secondary-qemu.bin -k u-boot-ubifs.bin -r ubi_with_kernel.img -m rx51 -o mtd_ubi.img
-
-echo
-echo "======================================================"
-echo "========== Running test images in n900 qemu =========="
-echo "======================================================"
-echo
-
-# Run MTD image in qemu and wait for 300s if U-Boot prints testing string to serial console and poweroff
-rm -f qemu_uboot.log
-./qemu-system-arm -M n900 -mtdblock mtd_uboot.img -sd emmc_uboot.img -serial /dev/stdout -display none > qemu_uboot.log &
-qemu_pid=$!
-tail -F qemu_uboot.log &
-tail_pid=$!
-sleep 300 &
-sleep_pid=$!
-wait -n $sleep_pid $qemu_pid || true
-kill -9 $tail_pid $sleep_pid $qemu_pid 2>/dev/null || true
-wait || true
-
-# Run MTD image in qemu and wait for 300s if uImage kernel from RAM is correctly booted
-rm -f qemu_ram.log
-./qemu-system-arm -M n900 -mtdblock mtd_ram.img -serial /dev/stdout -display none > qemu_ram.log &
-qemu_pid=$!
-tail -F qemu_ram.log &
-tail_pid=$!
-sleep 300 &
-sleep_pid=$!
-wait -n $sleep_pid $qemu_pid || true
-kill -9 $tail_pid $sleep_pid $qemu_pid 2>/dev/null || true
-wait || true
-
-# Run MTD image in qemu and wait for 300s if zImage kernel from RAM is correctly booted
-rm -f qemu_ram2.log
-./qemu-system-arm -M n900 -mtdblock mtd_ram2.img -sd emmc_default.img -serial /dev/stdout -display none > qemu_ram2.log &
-qemu_pid=$!
-tail -F qemu_ram2.log &
-tail_pid=$!
-sleep 300 &
-sleep_pid=$!
-wait -n $sleep_pid $qemu_pid || true
-kill -9 $tail_pid $sleep_pid $qemu_pid 2>/dev/null || true
-wait || true
-
-# Run MTD image in qemu and wait for 300s if uImage kernel from eMMC is correctly booted
-rm -f qemu_emmc.log
-./qemu-system-arm -M n900 -mtdblock mtd_emmc.img -sd emmc_emmc.img -serial /dev/stdout -display none > qemu_emmc.log &
-qemu_pid=$!
-tail -F qemu_emmc.log &
-tail_pid=$!
-sleep 300 &
-sleep_pid=$!
-wait -n $sleep_pid $qemu_pid || true
-kill -9 $tail_pid $sleep_pid $qemu_pid 2>/dev/null || true
-wait || true
-
-# Run MTD image in qemu and wait for 300s if zImage kernel from eMMC is correctly booted
-rm -f qemu_emmc2.log
-./qemu-system-arm -M n900 -mtdblock mtd_emmc.img -sd emmc_emmc2.img -serial /dev/stdout -display none > qemu_emmc2.log &
-qemu_pid=$!
-tail -F qemu_emmc2.log &
-tail_pid=$!
-sleep 300 &
-sleep_pid=$!
-wait -n $sleep_pid $qemu_pid || true
-kill -9 $tail_pid $sleep_pid $qemu_pid 2>/dev/null || true
-wait || true
-
-# Run MTD image in qemu and wait for 300s if kernel from OneNAND is correctly booted
-rm -f qemu_nand.log
-./qemu-system-arm -M n900 -mtdblock mtd_nand.img -sd emmc_nand.img -serial /dev/stdout -display none > qemu_nand.log &
-qemu_pid=$!
-tail -F qemu_nand.log &
-tail_pid=$!
-sleep 300 &
-sleep_pid=$!
-wait -n $sleep_pid $qemu_pid || true
-kill -9 $tail_pid $sleep_pid $qemu_pid 2>/dev/null || true
-wait || true
-
-# Run MTD image in qemu and wait for 300s if kernel from UBI is correctly booted
-rm -f qemu_ubi.log
-./qemu-system-arm -M n900 -mtdblock mtd_ubi.img -sd emmc_ubi.img -serial /dev/stdout -display none > qemu_ubi.log &
-qemu_pid=$!
-tail -F qemu_ubi.log &
-tail_pid=$!
-sleep 300 &
-sleep_pid=$!
-wait -n $sleep_pid $qemu_pid || true
-kill -9 $tail_pid $sleep_pid $qemu_pid 2>/dev/null || true
-wait || true
-
-echo
-echo "============================="
-echo "========== Results =========="
-echo "============================="
-echo
-
-if grep -q 'Successfully booted' qemu_uboot.log; then echo "U-Boot serial console is working"; else echo "U-Boot serial console test failed"; fi
-if grep -q 'Successfully booted' qemu_ram.log; then echo "Kernel (uImage) was successfully booted from RAM"; else echo "Failed to boot kernel (uImage) from RAM"; fi
-if grep -q 'Successfully booted' qemu_ram2.log; then echo "Kernel (zImage) was successfully booted from RAM"; else echo "Failed to boot kernel (zImage) from RAM"; fi
-if grep -q 'Successfully booted' qemu_emmc.log; then echo "Kernel (uImage) was successfully booted from eMMC"; else echo "Failed to boot kernel (uImage) from eMMC"; fi
-if grep -q 'Successfully booted' qemu_emmc2.log; then echo "Kernel (zImage) was successfully booted from eMMC"; else echo "Failed to boot kernel (zImage) from eMMC"; fi
-if grep -q 'Successfully booted' qemu_nand.log; then echo "Kernel (uImage) was successfully booted from OneNAND"; else echo "Failed to boot kernel (uImage) from OneNAND"; fi
-if grep -q 'Successfully booted' qemu_ubi.log; then echo "Kernel (zImage) was successfully booted from UBI"; else echo "Failed to boot kernel (zImage) from UBI"; fi
-
-echo
-
-if grep -q 'Successfully booted' qemu_uboot.log && grep -q 'Successfully booted' qemu_ram.log && grep -q 'Successfully booted' qemu_ram2.log && grep -q 'Successfully booted' qemu_emmc.log && grep -q 'Successfully booted' qemu_emmc2.log && grep -q 'Successfully booted' qemu_nand.log && grep -q 'Successfully booted' qemu_ubi.log; then
-	echo "All tests passed"
-	exit 0
-else
-	echo "Some tests failed"
-	exit 1
-fi
diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 279b3a3504cd..4f3d061bf579 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -188,27 +188,6 @@ RUN git clone https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
 	make -j$(nproc) all install && \
 	rm -rf /tmp/qemu
 
-# Build QEMU supporting Nokia n900 emulation
-RUN mkdir -p /opt/nokia && \
-	cd /tmp && \
-	git clone https://git.linaro.org/qemu/qemu-linaro.git && \
-	cd /tmp/qemu-linaro && \
-	git checkout 8f8d8e0796efe1a6f34cdd83fb798f3c41217ec1 && \
-	./configure --enable-system --target-list=arm-softmmu \
-	--python=/usr/bin/python2.7 --disable-sdl --disable-gtk \
-	--disable-curses --audio-drv-list= --audio-card-list= \
-	--disable-werror --disable-xen --disable-xen-pci-passthrough \
-	--disable-brlapi --disable-vnc --disable-curl --disable-slirp \
-	--disable-kvm --disable-user --disable-linux-user --disable-bsd-user \
-	--disable-guest-base --disable-uuid --disable-vde --disable-linux-aio \
-	--disable-cap-ng --disable-attr --disable-blobs --disable-docs \
-	--disable-spice --disable-libiscsi --disable-smartcard-nss \
-	--disable-usb-redir --disable-guest-agent --disable-seccomp \
-	--disable-glusterfs --disable-nptl --disable-fdt && \
-	make -j$(nproc) && \
-	cp /tmp/qemu-linaro/arm-softmmu/qemu-system-arm /opt/nokia && \
-	rm -rf /tmp/qemu-linaro
-
 # Build genimage (required by some targets to generate disk images)
 RUN wget -O - https://github.com/pengutronix/genimage/releases/download/v14/genimage-14.tar.xz | tar -C /tmp -xJ && \
 	cd /tmp/genimage-14 && \
@@ -252,16 +231,6 @@ RUN mkdir /tmp/trace && \
     sudo make install && \
     rm -rf /tmp/trace
 
-# Files to run Nokia RX-51 (aka N900) tests
-RUN mkdir -p /opt/nokia && \
-	cd /opt/nokia && \
-	wget https://raw.githubusercontent.com/pali/u-boot-maemo/master/debian/u-boot-gen-combined && \
-	chmod 0755 u-boot-gen-combined && \
-	wget http://repository.maemo.org/qemu-n900/qemu-n900.tar.gz && \
-	wget http://repository.maemo.org/pool/maemo5.0/free/k/kernel/kernel_2.6.28-20103103+0m5_armel.deb && \
-	wget http://repository.maemo.org/pool/maemo5.0/free/g/glibc/libc6_2.5.1-1eglibc27+0m5_armel.deb && \
-	wget http://repository.maemo.org/pool/maemo5.0/free/b/busybox/busybox_1.10.2.legal-1osso30+0m5_armel.deb
-
 # Create our user/group
 RUN echo uboot ALL=NOPASSWD: ALL > /etc/sudoers.d/uboot
 RUN useradd -m -U uboot
-- 
2.34.1

