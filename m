Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21257C02196
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 01:59:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C93D7807F1;
	Wed,  5 Feb 2025 02:57:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LVUs+0BS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BAB38070F; Wed,  5 Feb 2025 02:57:36 +0100 (CET)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BF4E806C9
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 02:57:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5f4c111991bso213685eaf.0
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 17:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738720652; x=1739325452; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+071lnDDFu96xFLso4sHrCSf3yALNc3kLpENeOTDKHo=;
 b=LVUs+0BS//cH5M4Y6BhgHefdj760dG/wIVdqNlfou6WRdW2xTxqS5dRyRdrNBD34jQ
 LpNx98uYLuqaXR3DkOnx3dUoZUEMYahIgPN/BKjdmnRg/jfp9wZvDNPflgJrXDkL7ONf
 RVG0MpjnTaPnTsudPgH7n9UgQVgAV8MgVW4e4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738720652; x=1739325452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+071lnDDFu96xFLso4sHrCSf3yALNc3kLpENeOTDKHo=;
 b=Gj/RHvgdrSNfIkDNCCXg1UewJ4ZBM+YsUtMj05ZTjErdqU81JC1wi3kMCtwfJcamtd
 06p8DTfjswVh0uLtq9fLADxT8tYd956R7ju4CjC3FaACo1itz65dorD6+ZZvr6QkJVhi
 7lR0zwPtPQCOQtx12TVdBgY3LLxxONVXaAWB9vqb6uaTwS3KZDUXZ6x9jkVwrXOWVchr
 2kPRYhaeBaWf3xHMrR5mFx5nTVZ4uGKQMO1SRjULW7CxN/iDvLdKdJChxJdvj5OQdpVu
 Lhp9BfJYf+kqZ+idtwRN+0L6KplODMtEQ633oSsIwKWz+vtw8bwFV1OW3Jg1pOW0oZGD
 +czg==
X-Gm-Message-State: AOJu0YxFf/LmlmJLA6qIT/JDeklxkQsSekKZKdj7hDNl5L2ssgBXRnN0
 ThIOp6aCtuGbi9LINmy7ibvNQa2LfeFQv5drt1oNIA3yjnGLxtSrwzkmOMUSpYTT6G3COgZG9hQ
 =
X-Gm-Gg: ASbGncub9plFQYgWTDxGI8X8jH+RV1YgJ1OKv0z+/3JaMxLDXpsdAPdLchwux6bZz3T
 +aGph+G35KWsDVCn2R3t+BgZzj0jtqB10RNdopgyDA0wuWYkYmZ8ncRpIef6CvXlkM8hb+oHJhe
 0/s7GAI8GQlbWwRaGJAiILOyy66eooso7Qs5vNS0jx0o4kFnKmcAXYf9opAJJl4fj+JcVGyRRud
 X5WuxID/The//vpvOJlFl7w7gEwmevyKTQPiVD5SCVtaOT62O5nnj8vKkq8kQhToRBEMuCwsKct
 PY3UF3M7paOdTcB9RYqsT3ySkAVM79aOMCuPqRPDK89sCYEqxJPC
X-Google-Smtp-Source: AGHT+IGvyc0T5u6UJkJKIPIA+zT4QKEF+Db2coocTJ18K80pLqsPL/AYGfVgAfR8kOTdL4RjP3Dviw==
X-Received: by 2002:a4a:d24d:0:b0:5fb:fe5a:6dd2 with SMTP id
 006d021491bc7-5fc3beb5078mr3293505eaf.1.1738720651629; 
 Tue, 04 Feb 2025 17:57:31 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fc104c2e7asm3543676eaf.12.2025.02.04.17.57.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 17:57:30 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Chen-Yu Tsai <wens@csie.org>,
 Christopher Obbard <chris.obbard@collabora.com>,
 Dragan Simic <dsimic@manjaro.org>, Greg Malysa <greg.malysa@timesys.com>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, Marek Vasut <marex@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Kocialkowski <paulk@sys-base.io>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Tom Rini <trini@konsulko.com>, huang lin <hl@rock-chips.com>
Subject: [PATCH 21/29] rockchip: Provide a VPL phase on rk3399
Date: Tue,  4 Feb 2025 18:55:11 -0700
Message-ID: <20250205015606.2686149-22-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205015606.2686149-1-sjg@chromium.org>
References: <20250205015606.2686149-1-sjg@chromium.org>
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

Add support for this new phase, which runs after TPL. It determines the
state of the machine, then selects which SPL image to use. SDRAM init is
then done in SPL, so that it is updatable.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/include/asm/spl.h               |   1 +
 arch/arm/mach-rockchip/Kconfig           |  25 +++++-
 arch/arm/mach-rockchip/Makefile          |   6 +-
 arch/arm/mach-rockchip/rk3399/Kconfig    |   9 ++
 arch/arm/mach-rockchip/spl-boot-order.c  |   3 +-
 arch/arm/mach-rockchip/spl.c             |   3 +
 arch/arm/mach-rockchip/tpl.c             |   2 +-
 arch/arm/mach-rockchip/u-boot-vpl-v8.lds | 107 +++++++++++++++++++++++
 arch/arm/mach-rockchip/vpl.c             |  53 +++++++++++
 common/spl/Kconfig                       |   1 +
 10 files changed, 203 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/mach-rockchip/u-boot-vpl-v8.lds
 create mode 100644 arch/arm/mach-rockchip/vpl.c

diff --git a/arch/arm/include/asm/spl.h b/arch/arm/include/asm/spl.h
index ee79a19c05c..62844d64cab 100644
--- a/arch/arm/include/asm/spl.h
+++ b/arch/arm/include/asm/spl.h
@@ -30,6 +30,7 @@ enum {
 	BOOT_DEVICE_XIP,
 	BOOT_DEVICE_BOOTROM,
 	BOOT_DEVICE_SMH,
+	BOOT_DEVICE_VBE,
 	BOOT_DEVICE_NONE
 };
 #endif
diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 269c219a6f8..7e6e9411e79 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -250,13 +250,15 @@ config ROCKCHIP_RK3399
 	select SPL_ATF
 	select SPL_BOARD_INIT if SPL
 	select SPL_LOAD_FIT
-	select SPL_CLK if SPL
+	select SPL_CLK if SPL && !VPL
 	select SPL_PINCTRL if SPL
 	select SPL_RAM if SPL
 	select SPL_REGMAP if SPL
 	select SPL_SYSCON if SPL
 	select TPL_NEEDS_SEPARATE_STACK if TPL
-	select SPL_SEPARATE_BSS
+	select VPL_NEEDS_SEPARATE_STACK if VPL
+	select SPL_SEPARATE_BSS if !VPL
+	select SPL_RAW_IMAGE_SUPPORT if VPL
 	select CLK
 	select FIT
 	select PINCTRL
@@ -266,6 +268,7 @@ config ROCKCHIP_RK3399
 	select DM_PMIC
 	select DM_REGULATOR_FIXED
 	select BOARD_LATE_INIT
+	select SUPPORT_VPL
 	imply ARMV8_CRYPTO
 	imply ARMV8_SET_SMPEN
 	imply BOOTSTD_FULL
@@ -294,13 +297,14 @@ config ROCKCHIP_RK3399
 	imply TPL_LIBCOMMON_SUPPORT
 	imply TPL_LIBGENERIC_SUPPORT
 	imply TPL_OF_CONTROL
-	imply TPL_RAM
+	imply TPL_RAM if !VPL
 	imply TPL_REGMAP
 	imply TPL_ROCKCHIP_COMMON_BOARD
 	imply TPL_SERIAL
 	imply TPL_SYS_MALLOC_SIMPLE
 	imply TPL_SYSCON
 	imply TPL_TINY_MEMSET
+	imply TPL_DM_MMC if VPL
 	help
 	  The Rockchip RK3399 is a ARM-based SoC with a dual-core Cortex-A72
 	  and quad-core Cortex-A53.
@@ -455,7 +459,7 @@ config SPL_ROCKCHIP_BACK_TO_BROM
 
 config TPL_ROCKCHIP_BACK_TO_BROM
 	bool "TPL returns to bootrom"
-	default y
+	default y if !VPL
 	select ROCKCHIP_BROM_HELPER if !ROCKCHIP_RK3066
 	select TPL_BOOTROM_SUPPORT
 	depends on TPL
@@ -496,6 +500,16 @@ config ROCKCHIP_EXTERNAL_TPL
 	  Enable this option and build with ROCKCHIP_TPL=/path/to/ddr.bin to
 	  include the external TPL in the image built by binman.
 
+config VPL_ROCKCHIP_COMMON_BOARD
+	bool "Rockchip VPL common board file"
+	depends on VPL
+	default y
+	help
+	  Rockchip SoCs have similar boot process, prefer to use TPL to start
+	  VPL, then ATF for DRAM init and back to bootrom, and SPL as Trust
+	  ATF/U-Boot loader. VPL common board is a basic VPL board init which
+	  can be shared for most SoCs to avoid copy-paste for different SoCs.
+
 config ROCKCHIP_BOOT_MODE_REG
 	hex "Rockchip boot mode flag register address"
 	help
@@ -587,6 +601,9 @@ config TPL_ROCKCHIP_EARLYRETURN_TO_BROM
 config SPL_MMC
 	default y if !SPL_ROCKCHIP_BACK_TO_BROM
 
+config TPL_MMC
+	default y if !TPL_ROCKCHIP_BACK_TO_BROM
+
 config ROCKCHIP_SPI_IMAGE
 	bool "Build a SPI image for rockchip"
 	help
diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
index 5e7edc99cdc..c878f2d3e8d 100644
--- a/arch/arm/mach-rockchip/Makefile
+++ b/arch/arm/mach-rockchip/Makefile
@@ -13,6 +13,8 @@ obj-tpl-$(CONFIG_ROCKCHIP_BROM_HELPER) += bootrom.o
 obj-tpl-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) += tpl.o spl_common.o
 obj-tpl-$(CONFIG_ROCKCHIP_PX30) += px30-board-tpl.o
 
+obj-vpl-$(CONFIG_VPL_ROCKCHIP_COMMON_BOARD) += vpl.o
+
 obj-spl-$(CONFIG_ROCKCHIP_RK3036) += rk3036-board-spl.o
 
 ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
@@ -47,9 +49,11 @@ obj-$(CONFIG_ROCKCHIP_RK3588) += rk3588/
 obj-$(CONFIG_ROCKCHIP_RV1108) += rv1108/
 obj-$(CONFIG_ROCKCHIP_RV1126) += rv1126/
 
-# Clear out SPL objects, in case this is a TPL build
+# Clear out SPL objects, in case this is a TPL or VPL build
 obj-spl-$(CONFIG_TPL_BUILD) =
+obj-spl-$(CONFIG_VPL_BUILD) =
 
 # Now add SPL/TPL objects back into the main build
 obj-$(CONFIG_XPL_BUILD) += $(obj-spl-y)
 obj-$(CONFIG_TPL_BUILD) += $(obj-tpl-y)
+obj-$(CONFIG_VPL_BUILD) += $(obj-vpl-y)
diff --git a/arch/arm/mach-rockchip/rk3399/Kconfig b/arch/arm/mach-rockchip/rk3399/Kconfig
index 04a84e2f6a0..fc55b498111 100644
--- a/arch/arm/mach-rockchip/rk3399/Kconfig
+++ b/arch/arm/mach-rockchip/rk3399/Kconfig
@@ -164,6 +164,15 @@ config TPL_STACK
 config TPL_TEXT_BASE
         default 0xff8c2000
 
+config VPL_STACK
+        default 0xff8eff00
+
+config VPL_TEXT_BASE
+        default 0xff8c2000
+
+config VPL_LDSCRIPT
+	default "arch/arm/mach-rockchip/u-boot-vpl-v8.lds"
+
 config SPL_STACK_R_ADDR
 	default 0x04000000 if !SPL_SHARES_INIT_SP_ADDR
 
diff --git a/arch/arm/mach-rockchip/spl-boot-order.c b/arch/arm/mach-rockchip/spl-boot-order.c
index 3dce9b30898..d580d4fc84c 100644
--- a/arch/arm/mach-rockchip/spl-boot-order.c
+++ b/arch/arm/mach-rockchip/spl-boot-order.c
@@ -99,7 +99,8 @@ __weak const char *board_spl_was_booted_from(void)
 void board_boot_order(u32 *spl_boot_list)
 {
 	/* In case of no fdt (or only plat), use spl_boot_device() */
-	if (!CONFIG_IS_ENABLED(OF_CONTROL) || CONFIG_IS_ENABLED(OF_PLATDATA)) {
+	if (IS_ENABLED(CONFIG_VPL) || !CONFIG_IS_ENABLED(OF_CONTROL) ||
+	    CONFIG_IS_ENABLED(OF_PLATDATA)) {
 		spl_boot_list[0] = spl_boot_device();
 		return;
 	}
diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c
index f4d29bbdd17..305373a161c 100644
--- a/arch/arm/mach-rockchip/spl.c
+++ b/arch/arm/mach-rockchip/spl.c
@@ -61,6 +61,9 @@ u32 spl_boot_device(void)
 {
 	u32 boot_device = BOOT_DEVICE_MMC1;
 
+	if (IS_ENABLED(CONFIG_VPL))
+		return BOOT_DEVICE_VBE;
+
 #if defined(CONFIG_TARGET_CHROMEBOOK_JERRY) || \
 		defined(CONFIG_TARGET_CHROMEBIT_MICKEY) || \
 		defined(CONFIG_TARGET_CHROMEBOOK_MINNIE) || \
diff --git a/arch/arm/mach-rockchip/tpl.c b/arch/arm/mach-rockchip/tpl.c
index 6b880f19f84..cc794a7dca2 100644
--- a/arch/arm/mach-rockchip/tpl.c
+++ b/arch/arm/mach-rockchip/tpl.c
@@ -84,5 +84,5 @@ int board_return_to_bootrom(struct spl_image_info *spl_image,
 
 u32 spl_boot_device(void)
 {
-	return BOOT_DEVICE_BOOTROM;
+	return IS_ENABLED(CONFIG_VPL) ? BOOT_DEVICE_VBE : BOOT_DEVICE_BOOTROM;
 }
diff --git a/arch/arm/mach-rockchip/u-boot-vpl-v8.lds b/arch/arm/mach-rockchip/u-boot-vpl-v8.lds
new file mode 100644
index 00000000000..d2a5cf61581
--- /dev/null
+++ b/arch/arm/mach-rockchip/u-boot-vpl-v8.lds
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier:	GPL-2.0+
+/*
+ * (C) Copyright 2019
+ * Rockchip Electronics Co., Ltd
+ * Kever Yang<kever.yang@rock-chips.com>
+ *
+ * (C) Copyright 2013
+ * David Feng <fenghua@phytium.com.cn>
+ *
+ * (C) Copyright 2002
+ * Gary Jennejohn, DENX Software Engineering, <garyj@denx.de>
+ *
+ * (C) Copyright 2010
+ * Texas Instruments, <www.ti.com>
+ *	Aneesh V <aneesh@ti.com>
+ */
+
+OUTPUT_FORMAT("elf64-littleaarch64", "elf64-littleaarch64", "elf64-littleaarch64")
+OUTPUT_ARCH(aarch64)
+ENTRY(_start)
+SECTIONS
+{
+	. = 0x00000000;
+
+	.text : {
+		. = ALIGN(8);
+		__image_copy_start = .;
+		CPUDIR/start.o (.text*)
+
+		/* put relocation code all together */
+		//. = . + 0xc0;
+		_rcode_start = .;
+		*(.text.rcode)
+		*(.text.rdata)
+		_rcode_end = .;
+
+		*(.text*)
+	}
+
+	.rodata : {
+		. = ALIGN(8);
+		*(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*)))
+	}
+
+	.data : {
+		. = ALIGN(8);
+		*(.data*)
+	}
+
+	__u_boot_list : {
+		. = ALIGN(8);
+		KEEP(*(SORT(__u_boot_list*)));
+	}
+
+	.image_copy_end : {
+		. = ALIGN(8);
+		*(.__image_copy_end)
+	}
+
+	.end : {
+		. = ALIGN(8);
+		*(.__end)
+	}
+
+	_image_binary_end = .;
+	_end = .;
+	__image_copy_end = .;
+
+	__bss_start = .;
+	.bss_start (NOLOAD) : {
+		. = ALIGN(8);
+		KEEP(*(.__bss_start));
+	}
+
+	.bss (NOLOAD) : {
+		*(.bss*)
+		 . = ALIGN(8);
+	}
+
+	.bss_end (NOLOAD) : {
+		KEEP(*(.__bss_end));
+	}
+	__bss_end = .;
+	__bss_size = __bss_end - __bss_start;
+
+	/DISCARD/ : { *(.dynsym) }
+	/DISCARD/ : { *(.dynstr*) }
+	/DISCARD/ : { *(.dynamic*) }
+	/DISCARD/ : { *(.plt*) }
+	/DISCARD/ : { *(.interp*) }
+	/DISCARD/ : { *(.gnu*) }
+}
+
+#if defined(CONFIG_TPL_MAX_SIZE)
+ASSERT(__image_copy_end - __image_copy_start < (CONFIG_TPL_MAX_SIZE), \
+	"TPL image too big");
+#endif
+
+#if defined(CONFIG_TPL_BSS_MAX_SIZE)
+ASSERT(__bss_end - __bss_start < (CONFIG_TPL_BSS_MAX_SIZE), \
+	"TPL image BSS too big");
+#endif
+
+#if defined(CONFIG_TPL_MAX_FOOTPRINT)
+ASSERT(__bss_end - _start < (CONFIG_TPL_MAX_FOOTPRINT), \
+	"TPL image plus BSS too big");
+#endif
diff --git a/arch/arm/mach-rockchip/vpl.c b/arch/arm/mach-rockchip/vpl.c
new file mode 100644
index 00000000000..55a8dabc2da
--- /dev/null
+++ b/arch/arm/mach-rockchip/vpl.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2019 Rockchip Electronics Co., Ltd
+ */
+
+#include <bootstage.h>
+#include <debug_uart.h>
+#include <dm.h>
+#include <hang.h>
+#include <init.h>
+#include <log.h>
+#include <ram.h>
+#include <spl.h>
+#include <version.h>
+#include <asm/io.h>
+#include <asm/arch-rockchip/bootrom.h>
+#include <linux/bitops.h>
+
+#if CONFIG_IS_ENABLED(BANNER_PRINT)
+#include <timestamp.h>
+#endif
+
+void board_init_f(ulong dummy)
+{
+	int ret;
+
+#if defined(CONFIG_DEBUG_UART) && defined(CONFIG_VPL_SERIAL)
+	/*
+	 * Debug UART can be used from here if required:
+	 *
+	 * debug_uart_init();
+	 * printch('a');
+	 * printhex8(0x1234);
+	 * printascii("string");
+	 */
+	debug_uart_init();
+#ifdef CONFIG_VPL_BANNER_PRINT
+	printascii("\nU-Boot VPL " PLAIN_VERSION " (" U_BOOT_DATE " - "
+		   U_BOOT_TIME ")\n");
+#endif
+#endif
+
+	ret = spl_early_init();
+	if (ret) {
+		debug("spl_early_init() failed: %d\n", ret);
+		hang();
+	}
+}
+
+u32 spl_boot_device(void)
+{
+	return BOOT_DEVICE_VBE;
+}
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index a250bde779f..92cc83be436 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -554,6 +554,7 @@ config SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR
 	default 0x200 if ARCH_SOCFPGA || ARCH_AT91
 	default 0x300 if ARCH_ZYNQ || ARCH_KEYSTONE || OMAP34XX || \
 		         OMAP54XX || AM33XX || AM43XX || ARCH_K3
+	default 0x800 if ARCH_ROCKCHIP && VPL
 	default 0x4000 if ARCH_ROCKCHIP
 	default 0x822 if TARGET_SIFIVE_UNLEASHED || TARGET_SIFIVE_UNMATCHED
 	help
-- 
2.43.0

