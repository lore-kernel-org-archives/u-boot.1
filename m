Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A59C5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 10:18:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52ADB8376C;
	Mon, 26 May 2025 12:16:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kMqWF1ut";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DD60837E1; Mon, 26 May 2025 12:16:29 +0200 (CEST)
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com
 [IPv6:2607:f8b0:4864:20::d41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B73C78365C
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 12:16:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd41.google.com with SMTP id
 ca18e2360f4ac-86135ad7b4cso36804139f.1
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 03:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748254585; x=1748859385; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+xnyPYVfxlsBskrEBCG3NmWzOJ0jgHYlMjFhISst4B4=;
 b=kMqWF1utQd1Ba+/UhphdMjfRbqemzL5+LGkbiq6O627egX1wAtATa5CKmVip+Rgqjh
 QIoE4kbJZzdxmidMFrEvvBBjz0ecFObXomGe4NHahmfTKDy+0xDlOKm0+jhxK72lPKDM
 H4+/4RfVq0Tix7HIWRjPVDhiQtA32H0dTlsfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748254585; x=1748859385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+xnyPYVfxlsBskrEBCG3NmWzOJ0jgHYlMjFhISst4B4=;
 b=no1EkOdG+ACfYtbclXICLuZE55wPPK978P0Lb5xXD79NYKElFUuqEr0LLC591F/h7Q
 rQ25ZNEJVpo2//E5tQlrSrFT7rUtkDuw/Bp4hJM2jG9KDR3ZXR41mBCFT6EEk5zI5UQB
 ePt5xh3v+Aucp3JR0U5a7AF7Cl8pIo74UFAIXKCJsuJStnyFpsWkwTG80xJoqz3GJG/c
 +vJmtVmxlhSKoFEtPsdtlmj+xgFm7X/cQzKgk8Lt0xe/uuzGcZ5NKsWDcfeMcL4yRTy4
 dgvEmGY43LC4KxtnY+qNdEruwMlIQ4qsO1avCaFUy54Uji4FGXnOFzdTF8iHSeB0fwil
 /1aw==
X-Gm-Message-State: AOJu0YxuLJL32HWqScPEswIHR2w7VGpNuCfWKdhY+yfoDTYZdA6l+eVj
 Z3eqf3SXmozjddi9hbHovgQ/+h16G89lLtArUM9s5pvPCqU4KKh1lf8RiAaZBgLmo0HAkb5m50u
 LRBphDEoBSso=
X-Gm-Gg: ASbGncvezLVbMsCnSzCn8zX9fM78PUe5IMrleQsUJwSZFKG1TqiUm319oBRRj2yA4QJ
 4rf2roDF17RI5S7zUMzD/lZdh59diV31xwGj95qjTZPU6R6s1SFPuf5vHv8M4mtJKWU4E5rkwKl
 2x863/g9/0TMdtSfHDjPMTlLzlWtOqPxg7BsK4lVHyEIQr5xmCAHQwKMM68wrNOt1Tlcv1ydlKf
 CGxU1iYVwlqHOSNHPAuIt4xnTIxBP/cqyhDzJOg2fjyorjlWpDJCW+GPvSyMp6ibS9PsuXRCBYI
 yEhF4Eil2p92blkevMhLK3eP9jlBW8hw7vy9hvBe55gqx1M3lvvZRClYzGz2P7n7XhWLiM5CC7Y
 quVzPMZZlU+Ri
X-Google-Smtp-Source: AGHT+IHMt2VftD9biowFwNoE813FTrx3EbWL5BS+GeZmpYj+U4JP4jwtZwz5FbuY43P3y9Sfjbxf+A==
X-Received: by 2002:a05:6602:4192:b0:86a:93b:dd63 with SMTP id
 ca18e2360f4ac-86cbb7b3a87mr836459139f.1.1748254584784; 
 Mon, 26 May 2025 03:16:24 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fbcc3b19aasm4679249173.52.2025.05.26.03.16.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 03:16:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>,
 Dragan Simic <dsimic@manjaro.org>, Greg Malysa <malysagreg@gmail.com>,
 Heiko Stuebner <heiko@sntech.de>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, Marek Vasut <marex@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Kocialkowski <paulk@sys-base.io>, Peng Fan <peng.fan@nxp.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Xuhui Lin <xuhui.lin@rock-chips.com>, huang lin <hl@rock-chips.com>
Subject: [PATCH v5 13/25] rockchip: Provide a VPL phase on rk3399
Date: Mon, 26 May 2025 04:14:59 -0600
Message-ID: <20250526101541.3254628-14-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250526101541.3254628-1-sjg@chromium.org>
References: <20250526101541.3254628-1-sjg@chromium.org>
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
index 9210877a4a4..ab1b90bd23a 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -255,17 +255,18 @@ config ROCKCHIP_RK3399
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
@@ -301,10 +302,11 @@ config ROCKCHIP_RK3399
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
@@ -569,7 +571,7 @@ config SPL_ROCKCHIP_BACK_TO_BROM
 
 config TPL_ROCKCHIP_BACK_TO_BROM
 	bool "TPL returns to bootrom"
-	default y
+	default y if !VPL
 	select ROCKCHIP_BROM_HELPER if !ROCKCHIP_RK3066
 	select TPL_BOOTROM_SUPPORT
 	depends on TPL
@@ -602,6 +604,16 @@ config TPL_ROCKCHIP_COMMON_BOARD
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
@@ -700,6 +712,9 @@ config TPL_ROCKCHIP_EARLYRETURN_TO_BROM
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
index 5c21b08a5ae..b36c76f6d69 100644
--- a/arch/arm/mach-rockchip/rk3399/Kconfig
+++ b/arch/arm/mach-rockchip/rk3399/Kconfig
@@ -150,6 +150,15 @@ config TPL_STACK
 config TPL_TEXT_BASE
         default 0xff8c2000
 
+config VPL_LDSCRIPT
+	default "arch/arm/mach-rockchip/u-boot-vpl-v8.lds"
+
+config VPL_STACK
+        default 0xff8eff00
+
+config VPL_TEXT_BASE
+        default 0xff8c2000
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
2.43.0

