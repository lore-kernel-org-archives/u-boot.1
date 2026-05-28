Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 154DECD4F54
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 17:13:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA8B684894;
	Thu, 28 May 2026 19:11:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BzMPr7YF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1C0384894; Thu, 28 May 2026 19:11:29 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 419578341A
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 19:11:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7e568ab0bc5so13501888a34.0
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 10:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779988286; x=1780593086; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sCRTT6fox/4eczkMMTlQY6JoqPPOQCQKzy0SrPTe0WM=;
 b=BzMPr7YFTD9gAS09XbLwLFx5SCbpQcGFB3rTkGi82ImVb4qYHYrKXgCohN+5tlXCWu
 ou92B5oB8m0s4g5Pk8LuQdx6iYoSvnioir84ALYVxbe9m52/YDEjbOLHEb4TnbvDpmkn
 WA0LVyqUe6yLb/RqHdqBCMn5eJVMn7pmGCgBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779988286; x=1780593086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sCRTT6fox/4eczkMMTlQY6JoqPPOQCQKzy0SrPTe0WM=;
 b=W292Y//jqyzU/U533CxPqPYl1e37IG7cdau7naaXZ1cw8YA+dxmNK4c0Zhfke804sc
 3QoDgDOlTbmaSMJVubW/fKKTfbR1lGasVviSz325w4jpbA/+OFSlzqQ3wfuD2KafvTD1
 MHoE03q0OszozBFm3cPkY2vcUJMoUzNqswnHZPBIr4MHNdX4JFyNFn9Dw0cCuj8Bl6Th
 rtHy0IWAhYz0rp9eDq7H9NZdKBrZAmp7Mq4SWyHkdXEHnhiki0Xg63QdAk117FViGzdv
 Mj4ORQnoAcI3uxbOaH/lWLDENvmi1DXIHVGlswqKI3IdRQ9Uz5guiR7SdHPWbPIuLsi/
 jmYQ==
X-Gm-Message-State: AOJu0Yx2DRJLPpM64Wha95N2N4+jmXu7A4g0bKSNWpO+jgoFYr8CSsnG
 EgrBQCrIM3zTfZYGTxGFetPq/ti+HzAMKnE+bv1gfEhrDLRVBQ78xNGFvfYacuY/wKRCzvzMWim
 t9eFkMRKAuos=
X-Gm-Gg: Acq92OGE9DC3SsnPzQB+F10ml83f7hvLTWA35T0ArCOazObruduSd1vYV4icFuZq1FZ
 fpPjT3KIVPcxjNICQby5L9MRTrmcEOvvZ3mzDnBuH4WfZ9ErQMmIKPrVzK8E7JGy6TA2Iugf2hK
 kt+laW0lcQxOPGfrem7bTegJTZTDswnSpJTbaEUdQanZI4JPsQjFEr2ZY/Xs/tZDaxkOIowuQwX
 EeJrZu8gYeBNH5L2VR/i2UjUKH+PU2wn+a5ZNkZ8fwPozQG+fZz1mBxpa2lLhqFWeitMjn3DjWa
 HtAoH8G98QtMmOTSTvdU4rG/REJ456sIkNaPqmW2Xbog6OvGb1iYY57awsO6rJbAE+X14j8cJGo
 wjUD3AlAV8RYbbypPz/w7mwb4mONwTswGw/BMID6o0/F71n9jf89REtjY5NETH0NwMMaVgAx1fq
 eQGUbfc0oze1uV97c7OH4hYInjiRoR
X-Received: by 2002:a05:6830:2b29:b0:7dc:cb0d:9e02 with SMTP id
 46e09a7af769-7e68ab68850mr1071294a34.9.1779988285937; 
 Thu, 28 May 2026 10:11:25 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e606459dadsm14461068a34.4.2026.05.28.10.11.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 10:11:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Alexey Charkov <alchark@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Anshul Dalal <anshuld@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v7 13/22] rockchip: Provide a VPL phase on rk3399
Date: Thu, 28 May 2026 11:10:20 -0600
Message-ID: <20260528171043.910264-14-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528171043.910264-1-sjg@chromium.org>
References: <20260528171043.910264-1-sjg@chromium.org>
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

Add support for this new phase, related to VBE, which runs after TPL.

It determines the state of the machine, then selects which SPL image
to use. SDRAM init is then done in SPL (rather than TPL as normal for
Rockchip), so that VBE can update the SDRAM-intit code in the field.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v5)

Changes in v5:
- Expand commit message to mention VBE
- Move  SUPPORT_VPL next to other SUPPORT_xxx options
- Put TPL_DM_MMC in alpha order
- Move VPL_ROCKCHIP_COMMON_BOARD up a bit
- Move VPL_LDSCRIPT up a bit
- Drop config SPL_STACK_R_ADDR
- Use if() instead of ? in spl_boot_device()
- Drop mention of SPL_RAW_IMAGE_SUPPORT since it is already the default
- Drop mention of SPL_SEPARATE_BSS since VPL doesn't need it

Changes in v4:
- Add a value for SPL_STACK_R_ADDR

Changes in v2:
- Rewrite help for VPL_ROCKCHIP_COMMON_BOARD
- Skip spl-boot-order.c for VPL (rather than modifying it)

 arch/arm/include/asm/spl.h               |   1 +
 arch/arm/mach-rockchip/Kconfig           |  23 ++++-
 arch/arm/mach-rockchip/Makefile          |  11 ++-
 arch/arm/mach-rockchip/rk3399/Kconfig    |   9 ++
 arch/arm/mach-rockchip/spl.c             |   3 +
 arch/arm/mach-rockchip/tpl.c             |   3 +
 arch/arm/mach-rockchip/u-boot-vpl-v8.lds | 107 +++++++++++++++++++++++
 arch/arm/mach-rockchip/vpl.c             |  53 +++++++++++
 common/spl/Kconfig                       |   1 +
 9 files changed, 205 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/mach-rockchip/u-boot-vpl-v8.lds
 create mode 100644 arch/arm/mach-rockchip/vpl.c

diff --git a/arch/arm/include/asm/spl.h b/arch/arm/include/asm/spl.h
index dd462ea6ad8..7e49a70e0bd 100644
--- a/arch/arm/include/asm/spl.h
+++ b/arch/arm/include/asm/spl.h
@@ -31,6 +31,7 @@ enum {
 	BOOT_DEVICE_BOOTROM,
 	BOOT_DEVICE_SMH,
 	BOOT_DEVICE_UFS,
+	BOOT_DEVICE_VBE,
 	BOOT_DEVICE_NONE
 };
 #endif
diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 108713488af..df9bcb26b99 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -253,17 +253,18 @@ config ROCKCHIP_RK3399
 	select ARM64
 	select SUPPORT_SPL
 	select SUPPORT_TPL
+	select SUPPORT_VPL
 	select SPL
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
 	select CLK
 	select FIT
 	select PINCTRL
@@ -299,10 +300,11 @@ config ROCKCHIP_RK3399
 	imply SYS_BOOTCOUNT_SINGLEWORD if BOOTCOUNT_LIMIT
 	imply TPL_CLK
 	imply TPL_DM
+	imply TPL_DM_MMC if VPL
 	imply TPL_LIBCOMMON_SUPPORT
 	imply TPL_LIBGENERIC_SUPPORT
 	imply TPL_OF_CONTROL
-	imply TPL_RAM
+	imply TPL_RAM if !VPL
 	imply TPL_REGMAP
 	imply TPL_ROCKCHIP_COMMON_BOARD
 	imply TPL_SERIAL
@@ -610,7 +612,7 @@ config SPL_ROCKCHIP_BACK_TO_BROM
 
 config TPL_ROCKCHIP_BACK_TO_BROM
 	bool "TPL returns to bootrom"
-	default y
+	default y if !VPL
 	select ROCKCHIP_BROM_HELPER if !ROCKCHIP_RK3066
 	select TPL_BOOTROM_SUPPORT
 	depends on TPL
@@ -643,6 +645,16 @@ config TPL_ROCKCHIP_COMMON_BOARD
 	  common board is a basic TPL board init which can be shared for most
 	  of SoCs to avoid copy-paste for different SoCs.
 
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
 config ROCKCHIP_EXTERNAL_TPL
 	bool "Use external TPL binary"
 	help
@@ -741,6 +753,9 @@ config TPL_ROCKCHIP_EARLYRETURN_TO_BROM
 config SPL_MMC
 	default y if !SPL_ROCKCHIP_BACK_TO_BROM
 
+config TPL_MMC
+	default y if !TPL_ROCKCHIP_BACK_TO_BROM
+
 config ROCKCHIP_SPI_IMAGE
 	bool "Build a SPI image for rockchip"
 	help
diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
index d3bc0689f89..aca0dc699f0 100644
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
 obj-tpl-$(CONFIG_ROCKCHIP_PX30) += px30-board-tpl.o spl_common.o
 
+obj-vpl-$(CONFIG_VPL_ROCKCHIP_COMMON_BOARD) += vpl.o
+
 obj-spl-$(CONFIG_ROCKCHIP_RK3036) += rk3036-board-spl.o spl_common.o
 
 ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
@@ -50,9 +55,11 @@ obj-$(CONFIG_ROCKCHIP_RK3588) += rk3588/
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
index 5c21b08a5ae..e2f235066e4 100644
--- a/arch/arm/mach-rockchip/rk3399/Kconfig
+++ b/arch/arm/mach-rockchip/rk3399/Kconfig
@@ -150,6 +150,15 @@ config TPL_STACK
 config TPL_TEXT_BASE
         default 0xff8c2000
 
+config VPL_LDSCRIPT
+	default "arch/arm/mach-rockchip/u-boot-vpl-v8.lds"
+
+config VPL_STACK
+	default 0xff8eff00
+
+config VPL_TEXT_BASE
+	default 0xff8c2000
+
 if BOOTCOUNT_LIMIT
 
 config BOOTCOUNT_BOOTLIMIT
diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c
index e989c148079..88c964b393b 100644
--- a/arch/arm/mach-rockchip/spl.c
+++ b/arch/arm/mach-rockchip/spl.c
@@ -78,6 +78,9 @@ u32 spl_boot_device(void)
 {
 	u32 boot_device = BOOT_DEVICE_MMC1;
 
+	if (IS_ENABLED(CONFIG_VPL))
+		return BOOT_DEVICE_VBE;
+
 #if defined(CONFIG_TARGET_CHROMEBOOK_JERRY) || \
 		defined(CONFIG_TARGET_CHROMEBIT_MICKEY) || \
 		defined(CONFIG_TARGET_CHROMEBOOK_MINNIE) || \
diff --git a/arch/arm/mach-rockchip/tpl.c b/arch/arm/mach-rockchip/tpl.c
index 6b880f19f84..a350ba56da7 100644
--- a/arch/arm/mach-rockchip/tpl.c
+++ b/arch/arm/mach-rockchip/tpl.c
@@ -84,5 +84,8 @@ int board_return_to_bootrom(struct spl_image_info *spl_image,
 
 u32 spl_boot_device(void)
 {
+	if (IS_ENABLED(CONFIG_VPL))
+		return BOOT_DEVICE_VBE;
+
 	return BOOT_DEVICE_BOOTROM;
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
index 5fa94098e49..4b256abe6af 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -587,6 +587,7 @@ config SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR
 	default 0x200 if ARCH_SOCFPGA_GEN5 || ARCH_AT91
 	default 0x300 if ARCH_ZYNQ || ARCH_KEYSTONE || OMAP34XX || \
 		         OMAP54XX || AM33XX || AM43XX || ARCH_K3
+	default 0x800 if ARCH_ROCKCHIP && VPL
 	default 0x4000 if ARCH_ROCKCHIP
 	default 0x822 if TARGET_SIFIVE_UNLEASHED || TARGET_SIFIVE_UNMATCHED
 	help
-- 
2.43.0

