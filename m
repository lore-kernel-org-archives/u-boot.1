Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C44E9C54F30
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 10:50:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E9A2836AB;
	Sun, 25 May 2025 12:48:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KrMSRxl7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D4AC83693; Sun, 25 May 2025 12:48:31 +0200 (CEST)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BEAC82D06
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 12:48:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x443.google.com with SMTP id
 ffacd0b85a97d-3a3673e12c4so812790f8f.2
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 03:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748170108; x=1748774908; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rC7QgqJ5LpbIL0+QQgHwkrBXAv/D7/pgHxaAk+q1Rik=;
 b=KrMSRxl7D1Rh1wutME5Uf8R6CsASjPV0R5NpFLymEqbya8+JmvjHbtD8+uAX1ckpcc
 X62rEcvNgebC5+tHRcbyFhHoaV4gap+In0YfgHj6oXGyfEAb9IRDN7jqndj20tU4iv1b
 ScMwwL/N6oLy2W+1ThbHxKkyeMPvxGbvxw4C8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748170108; x=1748774908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rC7QgqJ5LpbIL0+QQgHwkrBXAv/D7/pgHxaAk+q1Rik=;
 b=XrhvZobFZmWczKQKcFj5iCp6qpc1q5kr88mZz4vrOfUfXJLPuxcAUV+JLHsF5RtFOo
 41CtwFVhb1HD6ouHDgqpxjy8M7swTB4hveihkt3FSFdQJHN5HyUCfjdS9eH0VwR3nPLc
 mXxCVvLo23cIx5lueW2Mj2K1ZPWchAPpJ9RQvoxAJF8j/OsRCLXjHb9xLp43TOPHy9Vl
 aXEHA59YPPcHANWHCLaSv/CNPzQqdinaOkqMzOnXl2lmfeCmK4yhTsB9e5QKyI0YpFZe
 8/nGvlxE9BFK6/fuS3SsUGkbiWJLf7JgGn5lzLlBfSCu0PykA/CiAe70MhIMxnK1/NJ3
 HXvw==
X-Gm-Message-State: AOJu0YwFKjQbLtFLz5bu1YKiP3X6yb8ijl4l8F4qqeA3b6Od61YZrRl/
 zYmIO9N+BS9MFESp5zVlgnApRtHYSK3hEj7/G1VAov4BKDVaVSb2SauKwSR7lwjfVtrJlc+6xjh
 evxu1TPyYxe0=
X-Gm-Gg: ASbGncvg5g3+zrUAquFpVIibIIUmpsHJ628VzNQAIG/nTwm/Bcq968DnXLy/qHOin2B
 W+avyioOICFGtHRzhjFaDfPZNGNPBt3gJD9+T+eyHV+abViEOmawUTdyWP++s7hMtHeVHT4JotU
 thqtoXbsFEalbvUB51hjNDDbhmfDt0YTrIKdkw/KQgO/RLhPrTN3CyCaQZ41pIq8LSHD2SwynB3
 9mqX0HRWSF8vDHHvoUNlY7jHc6lcYzValp0PJ922jPrusGHLEkb8gcaKajmhplx+JRibq7Chk+U
 iaS1u/Ig6ZQKFWvDX4f3ql1JBWRgWZRf6uIEk5HX9pObKsBPG3V5xAeVmhj9qrGoQmftER4=
X-Google-Smtp-Source: AGHT+IF6XqVGhoY3cV7eu6gRKIvmzuTjmWISDYQPpj33tysPDFzv5CA+2HopLM/VdD/uG6aRqzHltg==
X-Received: by 2002:a05:6000:2505:b0:3a3:6e62:d8e8 with SMTP id
 ffacd0b85a97d-3a4cb4a9776mr4242736f8f.55.1748170108111; 
 Sun, 25 May 2025 03:48:28 -0700 (PDT)
Received: from tasman.. (host-80-43-238-15.as13285.net. [80.43.238.15])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4cb450867sm5045047f8f.57.2025.05.25.03.48.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 03:48:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>,
 Daniel Semkowicz <dse@thaumatec.com>, Dragan Simic <dsimic@manjaro.org>,
 Greg Malysa <malysagreg@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Kocialkowski <paulk@sys-base.io>, Peng Fan <peng.fan@nxp.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Xuhui Lin <xuhui.lin@rock-chips.com>, huang lin <hl@rock-chips.com>
Subject: [PATCH v4 13/25] rockchip: Provide a VPL phase on rk3399
Date: Sun, 25 May 2025 11:47:49 +0100
Message-Id: <20250525104801.1440260-14-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250525104801.1440260-1-sjg@chromium.org>
References: <20250525104801.1440260-1-sjg@chromium.org>
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

Changes in v4:
- Add a value for SPL_STACK_R_ADDR

Changes in v2:
- Rewrite help for VPL_ROCKCHIP_COMMON_BOARD
- Skip spl-boot-order.c for VPL (rather than modifying it)

 arch/arm/include/asm/spl.h               |   1 +
 arch/arm/mach-rockchip/Kconfig           |  25 +++++-
 arch/arm/mach-rockchip/Makefile          |  11 ++-
 arch/arm/mach-rockchip/rk3399/Kconfig    |  12 +++
 arch/arm/mach-rockchip/spl.c             |   3 +
 arch/arm/mach-rockchip/tpl.c             |   2 +-
 arch/arm/mach-rockchip/u-boot-vpl-v8.lds | 107 +++++++++++++++++++++++
 arch/arm/mach-rockchip/vpl.c             |  53 +++++++++++
 common/spl/Kconfig                       |   1 +
 9 files changed, 208 insertions(+), 7 deletions(-)
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
index 9210877a4a4..96f73b42a8c 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -259,13 +259,15 @@ config ROCKCHIP_RK3399
 	select SPL_ATF
 	select SPL_BOARD_INIT if SPL
 	select SPL_LOAD_FIT
-	select SPL_CLK if SPL
+	select SPL_CLK if SPL && !VPL
 	select SPL_PINCTRL if SPL
 	select SPL_RAM if SPL
 	select SPL_REGMAP if SPL
 	select SPL_SYSCON if SPL
 	select TPL_HAVE_INIT_STACK if TPL
-	select SPL_SEPARATE_BSS
+	select VPL_HAVE_INIT_STACK if VPL
+	select SPL_SEPARATE_BSS if !VPL
+	select SPL_RAW_IMAGE_SUPPORT if VPL
 	select CLK
 	select FIT
 	select PINCTRL
@@ -275,6 +277,7 @@ config ROCKCHIP_RK3399
 	select DM_PMIC
 	select DM_REGULATOR_FIXED
 	select BOARD_LATE_INIT
+	select SUPPORT_VPL
 	imply ARMV8_CRYPTO
 	imply ARMV8_SET_SMPEN
 	imply BOOTSTD_FULL
@@ -304,13 +307,14 @@ config ROCKCHIP_RK3399
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
@@ -569,7 +573,7 @@ config SPL_ROCKCHIP_BACK_TO_BROM
 
 config TPL_ROCKCHIP_BACK_TO_BROM
 	bool "TPL returns to bootrom"
-	default y
+	default y if !VPL
 	select ROCKCHIP_BROM_HELPER if !ROCKCHIP_RK3066
 	select TPL_BOOTROM_SUPPORT
 	depends on TPL
@@ -609,6 +613,16 @@ config ROCKCHIP_EXTERNAL_TPL
 	  Enable this option and build with ROCKCHIP_TPL=/path/to/ddr.bin to
 	  include the external TPL in the image built by binman.
 
+config VPL_ROCKCHIP_COMMON_BOARD
+	bool "Rockchip VPL common board file"
+	depends on VPL
+	default y
+	help
+	  Enable the VPL phase for rockchip, which selects which SPL/U-Boot
+	  will be used on each boot. With this flow, used by Verified Boot for
+	  Embedded (VBE), TPL is loaded by the boot ROM. Then TPL loads VPL,
+	  VPL loads SPL and SPL loads U-Boot.
+
 config ROCKCHIP_BOOT_MODE_REG
 	hex "Rockchip boot mode flag register address"
 	help
@@ -700,6 +714,9 @@ config TPL_ROCKCHIP_EARLYRETURN_TO_BROM
 config SPL_MMC
 	default y if !SPL_ROCKCHIP_BACK_TO_BROM
 
+config TPL_MMC
+	default y if !TPL_ROCKCHIP_BACK_TO_BROM
+
 config ROCKCHIP_SPI_IMAGE
 	bool "Build a SPI image for rockchip"
 	help
diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
index ae15a9f8a2d..6cf60bc911c 100644
--- a/arch/arm/mach-rockchip/Makefile
+++ b/arch/arm/mach-rockchip/Makefile
@@ -8,11 +8,16 @@
 # inaccessible/protected memory (and the bootrom-helper assumes that
 # the stack-pointer is valid before switching to the U-Boot stack).
 obj-spl-$(CONFIG_ROCKCHIP_BROM_HELPER) += bootrom.o
-obj-spl-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) += spl.o spl-boot-order.o spl_common.o
+obj-spl-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) += spl.o spl_common.o
+ifndef CONFIG_VPL
+obj-spl-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) += spl-boot-order.o
+endif
 obj-tpl-$(CONFIG_ROCKCHIP_BROM_HELPER) += bootrom.o
 obj-tpl-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) += tpl.o spl_common.o
 obj-tpl-$(CONFIG_ROCKCHIP_PX30) += px30-board-tpl.o
 
+obj-vpl-$(CONFIG_VPL_ROCKCHIP_COMMON_BOARD) += vpl.o
+
 obj-spl-$(CONFIG_ROCKCHIP_RK3036) += rk3036-board-spl.o
 
 ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
@@ -49,9 +54,11 @@ obj-$(CONFIG_ROCKCHIP_RK3588) += rk3588/
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
index 5c21b08a5ae..7b2d47fcb49 100644
--- a/arch/arm/mach-rockchip/rk3399/Kconfig
+++ b/arch/arm/mach-rockchip/rk3399/Kconfig
@@ -150,6 +150,18 @@ config TPL_STACK
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
+config SPL_STACK_R_ADDR
+	default 0x04000000 if !SPL_SHARES_INIT_SP_ADDR
+
 if BOOTCOUNT_LIMIT
 
 config BOOTCOUNT_BOOTLIMIT
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
index a84a0f83924..fb6c90733ee 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -582,6 +582,7 @@ config SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR
 	default 0x200 if ARCH_SOCFPGA || ARCH_AT91
 	default 0x300 if ARCH_ZYNQ || ARCH_KEYSTONE || OMAP34XX || \
 		         OMAP54XX || AM33XX || AM43XX || ARCH_K3
+	default 0x800 if ARCH_ROCKCHIP && VPL
 	default 0x4000 if ARCH_ROCKCHIP
 	default 0x822 if TARGET_SIFIVE_UNLEASHED || TARGET_SIFIVE_UNMATCHED
 	help
-- 
2.34.1

