Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2F7E7C6F9
	for <u-boot@archiver.kernel.org>; Sun,  1 Feb 2026 00:46:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7623183AAD;
	Sun,  1 Feb 2026 01:45:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZlmJUb+N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE73C83AA9; Sun,  1 Feb 2026 01:45:31 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7234F83BC9
 for <u-boot@lists.denx.de>; Sun,  1 Feb 2026 01:45:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-794c2db2ee5so3452707b3.2
 for <u-boot@lists.denx.de>; Sat, 31 Jan 2026 16:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769906727; x=1770511527; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e6khh0Q9YbeRwfP6J4ImQ7ZY8OT/jqHadt2N/ODQLqc=;
 b=ZlmJUb+NBZqPetN2zRZsH5Plh4N30qhLBXRJEMaQiNkIQ8DTEV9WdmK0hQvBD/guUd
 uaysF5hinFvDbAW/i0FurhR7xWeSMA2TA4QVXMfa0KEhUZbQ7z+Kd0bXZN5Zff7oKWKT
 /WEBl7iUDqUGIbGA6mIQZ2ddpIiCvio8jjLqjx+uZTagSDlx0XbFOIlOQbw8sZcDS8VS
 MXVvBTYtGw2C42iie3ZAfK7Evk6qD8aEuaa7EmFF1FcVS07UWAYg6GQ9iLOjuQlM7nKr
 R2SeBeG0pJ1LsB0ZrZAh5b4ka5BUF3ev+pbesYwtNBDyiLaJi00oSVGGMRuQB8XZCFEr
 D8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769906727; x=1770511527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e6khh0Q9YbeRwfP6J4ImQ7ZY8OT/jqHadt2N/ODQLqc=;
 b=GEdAWSVMEP5kLlvxXEHPLVKcygCnvPCtMegWePHgr6y6VWNDG4K7vK24XpJqazeeL6
 wL8oXdQ0u0gnWfCV/omo242BN5IsqSDZXl2FgnTYKyeQu2xprSw8v+/dAhlATsjIidkK
 nAMZkxOxYf4sXN9Er0lmY+hpiwyGzSn9eeZvuF8sa9qc3uEs5+g8Upf58rOUMGkxVC4U
 Po7JAnxrrzK71yzWIDUwzRMvmrYi0rZZhLHDwtnNjeewN1MLf+vWiwbYup3ngrsjrJqe
 w4GTlifqGSnWIvgtWi5fKdYArNaFmVy+JyHYBdVBE1YVHfvyGGjwIE/IBMuJ8UDB8WjZ
 a4Xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwtpHd7Uko5IXLIw2H/MEohVYY1UQz3AlT1gxi6km/X1VmCmSrrRCTws6ftiWiFSSUF82VE2Y=@lists.denx.de
X-Gm-Message-State: AOJu0YyhaBAquNjOQ33KcbPh8ir07mhFFZ2A6woIYn318YsIJSMCnFWJ
 eRzwwPphjcvJ13rycSyJ9oVT77b8/IkJoKkodoMw4WXKL80qS7QjjjPH
X-Gm-Gg: AZuq6aJa8TEhJpT2+VZRDhWOdMWGVrn3Qi/g+Q39YasJuxuJ51AHboCJy5Tpj1bR5f6
 OZSv4TTGfFdDLNQ3lT3OQ133VGvVNPC/2cxT2C5mOCsh6X8BWxRoy7/6qrRnlQ/6ULwCTcTwa+z
 VhjpZz/NWsJ2J6jzfUfRFyG94NF6APomNcutB+u7p2dKK7PDRxcpMzbfV5YH4CbsQOnw9PAKZXv
 6TfKkf2QqpVMME/u4aWuG6mAY3SC1IzZZBvUMcM9RXv9afXSub4VVX5p4RydwW1Of0vFaq5fSZW
 QPjZkZmXgPYPlp4GkBGWSaYgeF/fPJRXQzhFAxeCQzWaqvx3fOvPgbC9L6OeImCs1Mwz83Wr4tv
 /0MZGjc/WkwH2NCRBYWDpsw8dMoiurgca+xFoEPMvk9met3krHVHt7lqydMd7PClGLHgsi/MKw7
 /pVN0W7eFmWq3eTztkcUwZOWI9
X-Received: by 2002:a05:690c:e3ea:b0:794:c213:28d with SMTP id
 00721157ae682-794c2131102mr14777517b3.51.1769906727072; 
 Sat, 31 Jan 2026 16:45:27 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:419e:8d46:1302:65da])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-794828ad9cfsm52105097b3.29.2026.01.31.16.45.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Jan 2026 16:45:26 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: kever.yang@rock-chips.com
Cc: trini@konsulko.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@nabladev.com>
Subject: [PATCH 7/7] omega4-rv1103: Add initial support
Date: Sat, 31 Jan 2026 21:44:56 -0300
Message-Id: <20260201004456.763107-8-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260201004456.763107-1-festevam@gmail.com>
References: <20260201004456.763107-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@nabladev.com>

Add the initial support for Onion's Omega4 RV1103 board.

It boots from the SPI NAND.

Tested the boot of a 6.6 OpenWRT kernel.

Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
 arch/arm/include/asm/arch-rv1103/boot0.h      |  11 +
 arch/arm/mach-rockchip/Kconfig                |  14 +
 arch/arm/mach-rockchip/Makefile               |   1 +
 arch/arm/mach-rockchip/rv1103/Kconfig         |  23 +
 arch/arm/mach-rockchip/rv1103/Makefile        |  12 +
 arch/arm/mach-rockchip/rv1103/boot0.h         |   5 +
 arch/arm/mach-rockchip/rv1103/clk_rv1103.c    |  32 ++
 arch/arm/mach-rockchip/rv1103/rv1103.c        | 133 +++++
 arch/arm/mach-rockchip/rv1103/syscon_rv1103.c |  19 +
 board/onion/omega4_rv1103/Kconfig             |  12 +
 board/onion/omega4_rv1103/MAINTAINERS         |   6 +
 board/onion/omega4_rv1103/Makefile            |   7 +
 board/onion/omega4_rv1103/omega4_rv1103.c     |  19 +
 board/onion/omega4_rv1103/omega4_rv1103.env   |   5 +
 configs/omega4-rv1103_defconfig               |  82 +++
 doc/board/index.rst                           |   1 +
 doc/board/onion/index.rst                     |   9 +
 doc/board/onion/omega4-rv1103.rst             |  56 ++
 include/configs/omega4_rv1103.h               |  11 +
 include/configs/rv1103_common.h               |  14 +
 include/dt-bindings/clock/rv1103-cru.h        | 489 ++++++++++++++++++
 21 files changed, 961 insertions(+)
 create mode 100644 arch/arm/include/asm/arch-rv1103/boot0.h
 create mode 100644 arch/arm/mach-rockchip/rv1103/Kconfig
 create mode 100644 arch/arm/mach-rockchip/rv1103/Makefile
 create mode 100644 arch/arm/mach-rockchip/rv1103/boot0.h
 create mode 100644 arch/arm/mach-rockchip/rv1103/clk_rv1103.c
 create mode 100644 arch/arm/mach-rockchip/rv1103/rv1103.c
 create mode 100644 arch/arm/mach-rockchip/rv1103/syscon_rv1103.c
 create mode 100644 board/onion/omega4_rv1103/Kconfig
 create mode 100644 board/onion/omega4_rv1103/MAINTAINERS
 create mode 100644 board/onion/omega4_rv1103/Makefile
 create mode 100644 board/onion/omega4_rv1103/omega4_rv1103.c
 create mode 100644 board/onion/omega4_rv1103/omega4_rv1103.env
 create mode 100644 configs/omega4-rv1103_defconfig
 create mode 100644 doc/board/onion/index.rst
 create mode 100644 doc/board/onion/omega4-rv1103.rst
 create mode 100644 include/configs/omega4_rv1103.h
 create mode 100644 include/configs/rv1103_common.h
 create mode 100644 include/dt-bindings/clock/rv1103-cru.h

diff --git a/arch/arm/include/asm/arch-rv1103/boot0.h b/arch/arm/include/asm/arch-rv1103/boot0.h
new file mode 100644
index 000000000000..2e78b074ade8
--- /dev/null
+++ b/arch/arm/include/asm/arch-rv1103/boot0.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2019 Rockchip Electronics Co., Ltd
+ */
+
+#ifndef __ASM_ARCH_BOOT0_H__
+#define __ASM_ARCH_BOOT0_H__
+
+#include <asm/arch-rockchip/boot0.h>
+
+#endif
diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 92bb4aa62f11..4aa2f6f39575 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -487,6 +487,19 @@ config ROCKCHIP_RK3588
 	  SD3.0/MMC4.5, USB OTG 3.0, Type-C, USB 2.0, PCIe 3.0, SATA 3, Ethernet,
 	  SDIO3.0 I2C, UART, SPI, GPIO and PWM.
 
+config ROCKCHIP_RV1103
+	bool "Support Rockchip RV1103"
+	select CPU_V7A
+	select SPL_ARMV7_SET_CORTEX_SMPEN
+	select SUPPORT_SPL
+	select SPL
+	imply ROCKCHIP_COMMON_BOARD
+
+	help
+	  The Rockchip RV1103 is an ARM-based SoC with a single Cortex-A7
+	  32-bit core which integrates NEON and FPU.
+	  It contains a built-in NPU for AI related applications.
+
 config ROCKCHIP_RV1108
 	bool "Support Rockchip RV1108"
 	select CPU_V7A
@@ -749,6 +762,7 @@ source "arch/arm/mach-rockchip/rk3528/Kconfig"
 source "arch/arm/mach-rockchip/rk3568/Kconfig"
 source "arch/arm/mach-rockchip/rk3576/Kconfig"
 source "arch/arm/mach-rockchip/rk3588/Kconfig"
+source "arch/arm/mach-rockchip/rv1103/Kconfig"
 source "arch/arm/mach-rockchip/rv1108/Kconfig"
 source "arch/arm/mach-rockchip/rv1126/Kconfig"
 
diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
index 06fb527b21a0..ece2d3d83b51 100644
--- a/arch/arm/mach-rockchip/Makefile
+++ b/arch/arm/mach-rockchip/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_ROCKCHIP_RK3528) += rk3528/
 obj-$(CONFIG_ROCKCHIP_RK3568) += rk3568/
 obj-$(CONFIG_ROCKCHIP_RK3576) += rk3576/
 obj-$(CONFIG_ROCKCHIP_RK3588) += rk3588/
+obj-$(CONFIG_ROCKCHIP_RV1103) += rv1103/
 obj-$(CONFIG_ROCKCHIP_RV1108) += rv1108/
 obj-$(CONFIG_ROCKCHIP_RV1126) += rv1126/
 
diff --git a/arch/arm/mach-rockchip/rv1103/Kconfig b/arch/arm/mach-rockchip/rv1103/Kconfig
new file mode 100644
index 000000000000..d275230536ca
--- /dev/null
+++ b/arch/arm/mach-rockchip/rv1103/Kconfig
@@ -0,0 +1,23 @@
+if ROCKCHIP_RV1103
+
+
+config TARGET_OMEGA4_RV1103
+	bool "OMEGA4_RV1103"
+	help
+	  Support Onion's Omega4 RV1103 board.
+
+config ROCKCHIP_BOOT_MODE_REG
+	default 0x20160200
+
+config ROCKCHIP_STIMER_BASE
+	default 0x20500000
+
+config SYS_SOC
+	default "rv1103"
+
+config SYS_MALLOC_F_LEN
+	default 0x400
+
+source "board/onion/omega4_rv1103/Kconfig"
+
+endif
diff --git a/arch/arm/mach-rockchip/rv1103/Makefile b/arch/arm/mach-rockchip/rv1103/Makefile
new file mode 100644
index 000000000000..3d6a4c378460
--- /dev/null
+++ b/arch/arm/mach-rockchip/rv1103/Makefile
@@ -0,0 +1,12 @@
+#
+# (C) Copyright 2016 Rockchip Electronics Co., Ltd
+#
+# SPDX-License-Identifier:     GPL-2.0+
+#
+
+obj-y += rv1103.o
+obj-y += clk_rv1103.o
+
+ifndef CONFIG_XPL_BUILD
+obj-y += syscon_rv1103.o
+endif
diff --git a/arch/arm/mach-rockchip/rv1103/boot0.h b/arch/arm/mach-rockchip/rv1103/boot0.h
new file mode 100644
index 000000000000..7d2c975f6677
--- /dev/null
+++ b/arch/arm/mach-rockchip/rv1103/boot0.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Dummy boot0.h for RV1103 — SoC does not require special boot0 setup. */
+#ifndef __ASM_ARCH_BOOT0_H__
+#define __ASM_ARCH_BOOT0_H__
+#endif
diff --git a/arch/arm/mach-rockchip/rv1103/clk_rv1103.c b/arch/arm/mach-rockchip/rv1103/clk_rv1103.c
new file mode 100644
index 000000000000..889ad64b39ea
--- /dev/null
+++ b/arch/arm/mach-rockchip/rv1103/clk_rv1103.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * (C) Copyright 2016 Rockchip Electronics Co., Ltd
+ * Author: Andy Yan <andy.yan@rock-chips.com>
+ */
+
+#include <dm.h>
+#include <syscon.h>
+#include <asm/arch-rockchip/clock.h>
+#include <asm/arch-rockchip/cru_rv1103.h>
+#include <linux/err.h>
+
+int rockchip_get_clk(struct udevice **devp)
+{
+	return uclass_get_device_by_driver(UCLASS_CLK,
+			DM_DRIVER_GET(clk_rv1103), devp);
+}
+
+void *rockchip_get_cru(void)
+{
+	struct rv1103_clk_priv *priv;
+	struct udevice *dev;
+	int ret;
+
+	ret = rockchip_get_clk(&dev);
+	if (ret)
+		return ERR_PTR(ret);
+
+	priv = dev_get_priv(dev);
+
+	return priv->cru;
+}
diff --git a/arch/arm/mach-rockchip/rv1103/rv1103.c b/arch/arm/mach-rockchip/rv1103/rv1103.c
new file mode 100644
index 000000000000..c8fce6f19dfd
--- /dev/null
+++ b/arch/arm/mach-rockchip/rv1103/rv1103.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier:     GPL-2.0+
+// Copyright (c) 2024 Rockchip Electronics Co., Ltd
+
+#include <dm.h>
+#include <spl.h>
+#include <asm/io.h>
+#include <image.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define PERI_CRU_BASE			0x20000000
+#define PERICRU_PERISOFTRST_CON10	0x0a28
+
+#define PMU0_CRU_BASE			0x20070000
+#define PMUCRU_PMUSOFTRST_CON02		0x0a08
+
+#define GRF_SYS_BASE			0x20150000
+#define GRF_SYS_HPMCU_CACHE_MISC	0x0214
+
+#define GPIO0_IOC_BASE			0x201B0000
+#define GPIO0A_IOMUX_SEL_H		0x04
+#define GPIO0_BASE			0x20520000
+#define GPIO_SWPORT_DR_L		0x00
+#define GPIO_SWPORT_DDR_L		0x08
+
+#define GPIO1_IOC_BASE			0x20170000
+#define GPIO1A_IOMUX_SEL_0		0x20
+#define GPIO1A_IOMUX_SEL_1_0		0x24
+#define GPIO1A_IOMUX_SEL_1_1		0x10024
+#define GPIO1B_IOMUX_SEL_0		0x10028
+#define GPIO1B_IOMUX_SEL_1		0x1002c
+#define GPIO1_IOC_GPIO1A_PULL_0		0x210
+#define GPIO1_IOC_GPIO1A_PULL_1		0x10210
+#define GPIO1_IOC_GPIO1B_PULL		0x10214
+#define GPIO1_IOC_JTAG_M2_CON		0x10810
+
+#define GPIO2_IOC_BASE			0x20840000
+#define GPIO2A_IOMUX_SEL_1_1		0x44
+
+#define SGRF_SYS_BASE			0x20250000
+#define SGRF_SYS_SOC_CON2		0x0008
+#define SGRF_SYS_SOC_CON3		0x000c
+#define SGRF_SYS_OTP_CON		0x0018
+#define FIREWALL_CON0			0x0020
+#define FIREWALL_CON1			0x0024
+#define FIREWALL_CON2			0x0028
+#define FIREWALL_CON3			0x002c
+#define FIREWALL_CON4			0x0030
+#define FIREWALL_CON5			0x0034
+#define FIREWALL_CON7			0x003c
+#define SGRF_SYS_HPMCU_BOOT_DDR		0x0080
+
+#define SGRF_PMU_BASE			0x20260000
+#define SGRF_PMU_SOC_CON0		0x0000
+#define SGRF_PMU_PMUMCU_BOOT_ADDR	0x0020
+
+#define SYS_GRF_BASE			0x20150000
+#define GRF_SYS_PERI_CON2		0x08
+#define GRF_SYS_USBPHY_CON0		0x50
+
+#define TOP_CRU_BASE			0x20060000
+#define TOPCRU_CRU_GLB_RST_CON		0xc10
+
+#define USBPHY_APB_BASE			0x20e10000
+#define USBPHY_FSLS_DIFF_RECEIVER	0x0100
+
+#define RV1103_WDT_BASE			0x208d0000
+#define RV1103_WDT_CR			0x00
+
+void board_debug_uart_init(void)
+{
+	/* No need to change uart */
+}
+
+#ifdef CONFIG_SPL_BUILD
+void rockchip_stimer_init(void)
+{
+	/* If Timer already enabled, don't re-init it */
+	u32 reg = readl(CONFIG_ROCKCHIP_STIMER_BASE + 0x4);
+
+	if (reg & 0x1)
+		return;
+	writel(0x00010000, CONFIG_ROCKCHIP_STIMER_BASE + 0x4);
+
+	asm volatile("mcr p15, 0, %0, c14, c0, 0" : : "r"(CONFIG_COUNTER_FREQUENCY));
+	writel(0xffffffff, CONFIG_ROCKCHIP_STIMER_BASE + 0x14);
+	writel(0xffffffff, CONFIG_ROCKCHIP_STIMER_BASE + 0x18);
+	writel(0x00010001, CONFIG_ROCKCHIP_STIMER_BASE + 0x4);
+}
+#endif
+
+#ifndef CONFIG_TPL_BUILD
+int arch_cpu_init(void)
+{
+	/* Stop any watchdog left running by BootROM/Boot1. */
+	writel(0, RV1103_WDT_BASE + RV1103_WDT_CR);
+
+#if defined(CONFIG_SPL_BUILD)
+	/* Set all devices to Non-secure */
+	writel(0xffff0000, SGRF_SYS_BASE + FIREWALL_CON0);
+	writel(0xffff0000, SGRF_SYS_BASE + FIREWALL_CON1);
+	writel(0xffff0000, SGRF_SYS_BASE + FIREWALL_CON2);
+	writel(0xffff0000, SGRF_SYS_BASE + FIREWALL_CON3);
+	writel(0xffff0000, SGRF_SYS_BASE + FIREWALL_CON4);
+	writel(0xffff0000, SGRF_SYS_BASE + FIREWALL_CON5);
+	writel(0x01f00000, SGRF_SYS_BASE + FIREWALL_CON7);
+	/* Set OTP to none secure mode */
+	writel(0x00020000, SGRF_SYS_BASE + SGRF_SYS_OTP_CON);
+
+	/* no-secure WDT reset output will reset SoC system. */
+	writel(0x00010001, SYS_GRF_BASE + GRF_SYS_PERI_CON2);
+	/* secure WDT reset output will reset SoC system. */
+	writel(0x00010001, SGRF_SYS_BASE + SGRF_SYS_SOC_CON2);
+	/*
+	 * enable tsadc trigger global reset and select first reset.
+	 * enable global reset and wdt trigger pmu reset.
+	 * select first reset trigger pmu reset.
+	 */
+	writel(0x0000ffdf, TOP_CRU_BASE + TOPCRU_CRU_GLB_RST_CON);
+
+	/*
+	 * Set the USB2 PHY in suspend mode and turn off the
+	 * USB2 PHY FS/LS differential receiver to save power:
+	 * VCC1V8_USB : reduce 3.8 mA
+	 * VDD_0V9 : reduce 4.4 mA
+	 */
+	writel(0x01ff01d1, SYS_GRF_BASE + GRF_SYS_USBPHY_CON0);
+	writel(0x00000000, USBPHY_APB_BASE + USBPHY_FSLS_DIFF_RECEIVER);
+#endif
+
+	return 0;
+}
+#endif
diff --git a/arch/arm/mach-rockchip/rv1103/syscon_rv1103.c b/arch/arm/mach-rockchip/rv1103/syscon_rv1103.c
new file mode 100644
index 000000000000..c7d7493a03ab
--- /dev/null
+++ b/arch/arm/mach-rockchip/rv1103/syscon_rv1103.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2016 Rockchip Electronics Co., Ltd
+ */
+
+#include <dm.h>
+#include <syscon.h>
+#include <asm/arch-rockchip/clock.h>
+
+static const struct udevice_id rv1103_syscon_ids[] = {
+	{ .compatible = "rockchip,rv1103-grf", .data = ROCKCHIP_SYSCON_GRF },
+	{ }
+};
+
+U_BOOT_DRIVER(syscon_rv1103) = {
+	.name = "rv1103_syscon",
+	.id = UCLASS_SYSCON,
+	.of_match = rv1103_syscon_ids,
+};
diff --git a/board/onion/omega4_rv1103/Kconfig b/board/onion/omega4_rv1103/Kconfig
new file mode 100644
index 000000000000..22f31fe0df9b
--- /dev/null
+++ b/board/onion/omega4_rv1103/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_OMEGA4_RV1103
+
+config SYS_BOARD
+	default "omega4_rv1103"
+
+config SYS_VENDOR
+	default "onion"
+
+config SYS_CONFIG_NAME
+	default "omega4_rv1103"
+
+endif
diff --git a/board/onion/omega4_rv1103/MAINTAINERS b/board/onion/omega4_rv1103/MAINTAINERS
new file mode 100644
index 000000000000..48aa5208b69f
--- /dev/null
+++ b/board/onion/omega4_rv1103/MAINTAINERS
@@ -0,0 +1,6 @@
+OMEGA4 RV1103
+M:      Fabio Estevam <festevam@nabladev.com>
+S:      Maintained
+F:      board/onion/omega4_rv1103
+F:      include/configs/omega4_rv1103.h
+F:      configs/omega4-rv1103_defconfig
diff --git a/board/onion/omega4_rv1103/Makefile b/board/onion/omega4_rv1103/Makefile
new file mode 100644
index 000000000000..6bd28f82282b
--- /dev/null
+++ b/board/onion/omega4_rv1103/Makefile
@@ -0,0 +1,7 @@
+#
+# SPDX-License-Identifier:	GPL-2.0+
+#
+# Copyright 2026 Fabio Estevam <festevam@nabladev.com>
+#
+
+obj-y	+= omega4_rv1103.o
diff --git a/board/onion/omega4_rv1103/omega4_rv1103.c b/board/onion/omega4_rv1103/omega4_rv1103.c
new file mode 100644
index 000000000000..9bdec3c396a8
--- /dev/null
+++ b/board/onion/omega4_rv1103/omega4_rv1103.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright 2026 Fabio Estevam <festevam@nabladev.com>
+
+#include <asm/global_data.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int dram_init(void)
+{
+	gd->ram_size = SZ_256M;
+
+	return 0;
+}
+
+phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
+{
+	return gd->ram_top;
+}
diff --git a/board/onion/omega4_rv1103/omega4_rv1103.env b/board/onion/omega4_rv1103/omega4_rv1103.env
new file mode 100644
index 000000000000..7ed232cab916
--- /dev/null
+++ b/board/onion/omega4_rv1103/omega4_rv1103.env
@@ -0,0 +1,5 @@
+kernel_addr_r=0x00800000
+fdt_addr_r=0x02000000
+ramdisk_addr_r=0x04000000
+bootargs=console=ttyS0,115200 mtdparts=spi1.0:256K(env),1M@256K(idblock),1M(uboot),8M(boot),-(ubi) ro rootwait ubi.mtd=ubi ubi.block=0,rootfs root=/dev/ubiblock0_0 rootfstype=squashfs
+bootcmd=mtd read spi-nand0 0x04000000 0x240000 0x800000;imxtract 0x04000000 kernel 0x00800000; imxtract 0x04000000 fdt 0x02000000; bootz 0x00800000 - 0x02000000
diff --git a/configs/omega4-rv1103_defconfig b/configs/omega4-rv1103_defconfig
new file mode 100644
index 000000000000..b9b017ccc75e
--- /dev/null
+++ b/configs/omega4-rv1103_defconfig
@@ -0,0 +1,82 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_SYS_ARCH_TIMER=y
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_TEXT_BASE=0x00200000
+CONFIG_SYS_MALLOC_F_LEN=0x80000
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x00400000
+CONFIG_SF_DEFAULT_SPEED=24000000
+CONFIG_DEFAULT_DEVICE_TREE="rv1103-omega4"
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x100000
+CONFIG_ROCKCHIP_RV1103=y
+CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
+CONFIG_ROCKCHIP_EXTERNAL_TPL=y
+CONFIG_SPL_SERIAL=y
+CONFIG_TARGET_OMEGA4_RV1103=y
+CONFIG_SYS_BOOTM_LEN=0x04000000
+CONFIG_SYS_LOAD_ADDR=0x00008000
+CONFIG_SF_DEFAULT_BUS=1
+CONFIG_DEBUG_UART_BASE=0x20540000
+CONFIG_DEBUG_UART_CLOCK=24000000
+# CONFIG_DEBUG_UART_BOARD_INIT is not set
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_SPI=y
+CONFIG_DEBUG_UART=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_CIPHER=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_FIT_BEST_MATCH=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_BOOTDELAY=1
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_SPL_NO_BSS_LIMIT=y
+CONFIG_SPL_MTD=y
+CONFIG_SPL_SPI_NAND_LOAD=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x140000
+CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_SPI=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_TIME=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_NO_NET=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_REGMAP=y
+CONFIG_SPL_REGMAP=y
+CONFIG_SYSCON=y
+CONFIG_SPL_SYSCON=y
+CONFIG_CLK=y
+CONFIG_SPL_CLK=y
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+# CONFIG_MMC is not set
+CONFIG_DM_MTD=y
+CONFIG_MTD_SPI_NAND=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_GIGADEVICE=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_SPI_FLASH_XTX=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PINCTRL_ROCKCHIP_RV1103=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_ROCKCHIP_SFC=y
+CONFIG_SYSRESET=y
+# CONFIG_RSA is not set
+# CONFIG_SPL_SHA1 is not set
+# CONFIG_SPL_SHA256 is not set
+CONFIG_LZMA=y
+CONFIG_SPL_LZMA=y
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/index.rst b/doc/board/index.rst
index 7870f1bc2461..d859f8a22bfe 100644
--- a/doc/board/index.rst
+++ b/doc/board/index.rst
@@ -45,6 +45,7 @@ Board-specific doc
    motorola/index
    nvidia/index
    nxp/index
+   onion/index
    openpiton/index
    ouya/index
    pegatron/index
diff --git a/doc/board/onion/index.rst b/doc/board/onion/index.rst
new file mode 100644
index 000000000000..5dab233a861e
--- /dev/null
+++ b/doc/board/onion/index.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Onion
+=====
+
+.. toctree::
+   :maxdepth: 2
+
+   omega4-rv1103
diff --git a/doc/board/onion/omega4-rv1103.rst b/doc/board/onion/omega4-rv1103.rst
new file mode 100644
index 000000000000..942e7ae1b2ce
--- /dev/null
+++ b/doc/board/onion/omega4-rv1103.rst
@@ -0,0 +1,56 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Onion Omega4 RV1103 board
+=========================
+
+U-Boot for the Onion Omega4 RV1103 board
+
+Quick Start
+-----------
+
+- Get the DDR initialization binary
+- Build U-Boot
+- Flash U-Boot into the SPI NAND
+
+Get the DDR initialization binary
+---------------------------------
+
+.. code-block:: bash
+
+   $ git clone https://github.com/rockchip-linux/rkbin.git
+
+The RV1103 DDR initialization is located at rkbin/bin/rv11/rv1103b_ddr_924MHz_v1.05.bin
+
+Build U-Boot
+------------
+
+.. code-block:: bash
+
+   $ export CROSS_COMPILE=arm-linux-gnueabihf-
+   $ export ROCKCHIP_TPL=<path-to-rkbin>/bin/rv11/rv1103b_ddr_924MHz_v1.05.bin
+   $ make omega4-rv1103_defconfig
+   $ make
+
+The idbloader-spi.img and u-boot.img are the binaries that need to be flashed
+into the SPI NAND.
+
+Flash U-Boot into the SPI NAND
+------------------------------
+
+Connect the USB OTG and UART console cables from the Omega4 board to
+the host PC.
+
+Press the BOOT button while applying power to the board.
+
+The string "RKUART" should appear on the console (115200,8N1).
+
+Install the rkdeveloptool from https://github.com/rockchip-linux/rkdeveloptool
+by following the instruction in the README file.
+
+.. code-block:: bash
+
+   $ sudo ./rkdeveloptool db download.bin
+   $ sudo ./rkdeveloptool wl 0x200 idbloader.img
+   $ sudo ./rkdeveloptool wl 0xa00 u-boot.img
+
+Power cycle the board and U-Boot output is seen on the console.
diff --git a/include/configs/omega4_rv1103.h b/include/configs/omega4_rv1103.h
new file mode 100644
index 000000000000..771e3fcf1ad0
--- /dev/null
+++ b/include/configs/omega4_rv1103.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2016 Rockchip Electronics Co., Ltd
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#include <configs/rv1103_common.h>
+
+#endif
diff --git a/include/configs/rv1103_common.h b/include/configs/rv1103_common.h
new file mode 100644
index 000000000000..14dea08d0fb5
--- /dev/null
+++ b/include/configs/rv1103_common.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2016 Rockchip Electronics Co., Ltd
+ */
+#ifndef __CONFIG_RV1103_COMMON_H
+#define __CONFIG_RV1103_COMMON_H
+
+#include "rockchip-common.h"
+#include <config_distro_bootcmd.h>
+
+#define CFG_IRAM_BASE			0x210f6000
+#define CFG_SYS_SDRAM_BASE		0x00000000
+
+#endif
diff --git a/include/dt-bindings/clock/rv1103-cru.h b/include/dt-bindings/clock/rv1103-cru.h
new file mode 100644
index 000000000000..8cc40d8a7c79
--- /dev/null
+++ b/include/dt-bindings/clock/rv1103-cru.h
@@ -0,0 +1,489 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (c) 2024 Rockchip Electronics Co. Ltd.
+ * Author: Elaine Zhang <zhangqing@rock-chips.com>
+ */
+
+#ifndef _DT_BINDINGS_CLK_RV1103_CRU_H
+#define _DT_BINDINGS_CLK_RV1103_CRU_H
+
+/* pll clocks */
+#define PLL_GPLL				1
+#define ARMCLK					2
+
+/* clk (clocks) */
+#define XIN_OSC0_HALF				5
+#define CLK_GPLL_DIV24				6
+#define CLK_GPLL_DIV12				7
+#define CLK_GPLL_DIV6				8
+#define CLK_GPLL_DIV4				9
+#define CLK_GPLL_DIV3				10
+#define CLK_GPLL_DIV2P5				11
+#define CLK_GPLL_DIV2				12
+#define CLK_UART0_SRC				13
+#define CLK_UART1_SRC				14
+#define CLK_UART2_SRC				15
+#define CLK_UART0_FRAC				16
+#define CLK_UART1_FRAC				17
+#define CLK_UART2_FRAC				18
+#define CLK_SAI_SRC				19
+#define CLK_SAI_FRAC				20
+#define LSCLK_NPU_SRC				21
+#define CLK_NPU_SRC				22
+#define ACLK_VEPU_SRC				23
+#define CLK_VEPU_SRC				24
+#define ACLK_VI_SRC				25
+#define CLK_ISP_SRC				26
+#define DCLK_VICAP				27
+#define CCLK_EMMC				28
+#define CCLK_SDMMC0				29
+#define SCLK_SFC_2X				30
+#define LSCLK_PERI_SRC				31
+#define ACLK_PERI_SRC				32
+#define HCLK_HPMCU				33
+#define SCLK_UART0				34
+#define SCLK_UART1				35
+#define SCLK_UART2				36
+#define CLK_I2C_PMU				37
+#define CLK_I2C_PERI				38
+#define CLK_SPI0				39
+#define CLK_PWM0_SRC				40
+#define CLK_PWM1				41
+#define CLK_PWM2				42
+#define DCLK_DECOM_SRC				43
+#define CCLK_SDMMC1				44
+#define CLK_CORE_CRYPTO				45
+#define CLK_PKA_CRYPTO				46
+#define CLK_CORE_RGA				47
+#define MCLK_SAI_SRC				48
+#define CLK_FREQ_PWM0_SRC			49
+#define CLK_COUNTER_PWM0_SRC			50
+#define PCLK_TOP_ROOT				51
+#define CLK_REF_MIPI0				52
+#define CLK_MIPI0_OUT2IO			53
+#define CLK_REF_MIPI1				54
+#define CLK_MIPI1_OUT2IO			55
+#define MCLK_SAI_OUT2IO				56
+#define ACLK_NPU_ROOT				57
+#define HCLK_RKNN				58
+#define ACLK_RKNN				59
+#define LSCLK_VEPU_ROOT				60
+#define HCLK_VEPU				61
+#define ACLK_VEPU				62
+#define CLK_CORE_VEPU				63
+#define PCLK_IOC_VCCIO3				64
+#define PCLK_ACODEC				65
+#define PCLK_USBPHY				66
+#define LSCLK_VI_100M				67
+#define LSCLK_VI_ROOT				68
+#define HCLK_ISP				69
+#define ACLK_ISP				70
+#define CLK_CORE_ISP				71
+#define ACLK_VICAP				72
+#define HCLK_VICAP				73
+#define ISP0CLK_VICAP				74
+#define PCLK_CSI2HOST0				75
+#define PCLK_CSI2HOST1				76
+#define HCLK_EMMC				77
+#define HCLK_SFC				78
+#define HCLK_SFC_XIP				79
+#define HCLK_SDMMC0				80
+#define PCLK_CSIPHY				81
+#define PCLK_GPIO1				82
+#define DBCLK_GPIO1				83
+#define PCLK_IOC_VCCIO47			84
+#define LSCLK_DDR_ROOT				85
+#define CLK_TIMER_DDRMON			86
+#define LSCLK_PMU_ROOT				87
+#define PCLK_PMU				88
+#define XIN_RC_DIV				89
+#define CLK_32K					90
+#define PCLK_PMU_GPIO0				91
+#define DBCLK_PMU_GPIO0				92
+#define CLK_DDR_FAIL_SAFE			93
+#define PCLK_PMU_HP_TIMER			94
+#define CLK_PMU_32K_HP_TIMER			95
+#define PCLK_PWM0				96
+#define CLK_PWM0				97
+#define CLK_OSC_PWM0				98
+#define CLK_RC_PWM0				99
+#define CLK_FREQ_PWM0				100
+#define CLK_COUNTER_PWM0			101
+#define PCLK_I2C0				102
+#define CLK_I2C0				103
+#define PCLK_UART0				104
+#define PCLK_IOC_PMUIO0				105
+#define CLK_REFOUT				106
+#define CLK_PREROLL				107
+#define CLK_PREROLL_32K				108
+#define CLK_LPMCU_PMU				109
+#define PCLK_SPI2AHB				110
+#define HCLK_SPI2AHB				111
+#define SCLK_SPI2AHB				112
+#define PCLK_WDT_LPMCU				113
+#define TCLK_WDT_LPMCU				114
+#define HCLK_SFC_PMU1				115
+#define HCLK_SFC_XIP_PMU1			116
+#define SCLK_SFC_2X_PMU1			117
+#define CLK_LPMCU				118
+#define CLK_LPMCU_RTC				119
+#define PCLK_LPMCU_MAILBOX			120
+#define PCLK_IOC_PMUIO1				121
+#define PCLK_CRU_PMU1				122
+#define PCLK_PERI_ROOT				123
+#define PCLK_RTC_ROOT				124
+#define CLK_TIMER_ROOT				125
+#define PCLK_TIMER				126
+#define CLK_TIMER0				127
+#define CLK_TIMER1				128
+#define CLK_TIMER2				129
+#define CLK_TIMER3				130
+#define CLK_TIMER4				131
+#define CLK_TIMER5				132
+#define PCLK_STIMER				133
+#define CLK_STIMER0				134
+#define CLK_STIMER1				135
+#define PCLK_WDT_NS				136
+#define TCLK_WDT_NS				137
+#define PCLK_WDT_S				138
+#define TCLK_WDT_S				139
+#define PCLK_WDT_HPMCU				140
+#define TCLK_WDT_HPMCU				141
+#define PCLK_I2C1				142
+#define CLK_I2C1				143
+#define PCLK_I2C2				144
+#define CLK_I2C2				145
+#define PCLK_I2C3				146
+#define CLK_I2C3				147
+#define PCLK_I2C4				148
+#define CLK_I2C4				149
+#define PCLK_SPI0				150
+#define PCLK_PWM1				151
+#define CLK_OSC_PWM1				152
+#define PCLK_PWM2				153
+#define CLK_OSC_PWM2				154
+#define PCLK_UART2				155
+#define PCLK_UART1				156
+#define ACLK_RKDMA				157
+#define PCLK_TSADC				158
+#define CLK_TSADC				159
+#define CLK_TSADC_TSEN				160
+#define PCLK_SARADC				161
+#define CLK_SARADC				162
+#define PCLK_GPIO2				163
+#define DBCLK_GPIO2				164
+#define PCLK_IOC_VCCIO6				165
+#define ACLK_USBOTG				166
+#define CLK_REF_USBOTG				167
+#define HCLK_SDMMC1				168
+#define HCLK_SAI				169
+#define MCLK_SAI				170
+#define ACLK_CRYPTO				171
+#define HCLK_CRYPTO				172
+#define HCLK_RK_RNG_NS				173
+#define HCLK_RK_RNG_S				174
+#define PCLK_OTPC_NS				175
+#define CLK_OTPC_ROOT_NS			176
+#define CLK_SBPI_OTPC_NS			177
+#define CLK_USER_OTPC_NS			178
+#define PCLK_OTPC_S				179
+#define CLK_OTPC_ROOT_S				180
+#define CLK_SBPI_OTPC_S				181
+#define CLK_USER_OTPC_S				182
+#define CLK_OTPC_ARB				183
+#define PCLK_OTP_MASK				184
+#define HCLK_RGA				185
+#define ACLK_RGA				186
+#define ACLK_MAC				187
+#define PCLK_MAC				188
+#define CLK_MACPHY				189
+#define ACLK_SPINLOCK				190
+#define HCLK_CACHE				191
+#define PCLK_HPMCU_MAILBOX			192
+#define PCLK_HPMCU_INTMUX			193
+#define CLK_HPMCU				194
+#define CLK_HPMCU_RTC				195
+#define DCLK_DECOM				196
+#define ACLK_DECOM				197
+#define PCLK_DECOM				198
+#define ACLK_SYS_SRAM				199
+#define PCLK_DMA2DDR				200
+#define ACLK_DMA2DDR				201
+#define PCLK_DCF				202
+#define ACLK_DCF				203
+#define MCLK_ACODEC_TX				204
+#define SCLK_UART0_SRC				205
+#define SCLK_UART1_SRC				206
+#define SCLK_UART2_SRC				207
+#define XIN_RC_SRC				208
+#define CLK_UTMI_USBOTG				209
+#define CLK_REF_USBPHY				230
+
+#define CLK_NR_CLKS				(CLK_REF_USBPHY + 1)
+
+// PERICRU_SOFTRST_CON00(Offset:0xA00)
+#define SRST_ARESETN_PERI_BIU			0x00000002
+#define SRST_HRESETN_HPMCU_BIU			0x00000003
+#define SRST_LSRESETN_PERI_BIU			0x00000004
+#define SRST_PRESETN_PERI_BIU			0x00000005
+#define SRST_PRESETN_RTC_BIU			0x00000006
+#define SRST_HRESETN_BOOTROM			0x00000007
+
+// PERICRU_SOFTRST_CON01(Offset:0xA04)
+#define SRST_PRESETN_TIMER			0x00000010
+#define SRST_RESETN_TIMER0			0x00000011
+#define SRST_RESETN_TIMER1			0x00000012
+#define SRST_RESETN_TIMER2			0x00000013
+#define SRST_RESETN_TIMER3			0x00000014
+#define SRST_RESETN_TIMER4			0x00000015
+#define SRST_RESETN_TIMER5			0x00000016
+#define SRST_PRESETN_STIMER			0x00000017
+#define SRST_RESETN_STIMER0			0x00000018
+#define SRST_RESETN_STIMER1			0x00000019
+
+// PERICRU_SOFTRST_CON02(Offset:0xA08)
+#define SRST_PRESETN_WDT_NS			0x00000020
+#define SRST_TRESETN_WDT_NS			0x00000021
+#define SRST_PRESETN_WDT_S			0x00000022
+#define SRST_TRESETN_WDT_S			0x00000023
+#define SRST_PRESETN_WDT_HPMCU			0x00000024
+#define SRST_TRESETN_WDT_HPMCU			0x00000025
+#define SRST_PRESETN_I2C1			0x00000026
+#define SRST_RESETN_I2C1			0x00000027
+#define SRST_PRESETN_I2C2			0x00000028
+#define SRST_RESETN_I2C2			0x00000029
+#define SRST_PRESETN_I2C3			0x0000002A
+#define SRST_RESETN_I2C3			0x0000002B
+#define SRST_PRESETN_I2C4			0x0000002C
+#define SRST_RESETN_I2C4			0x0000002D
+
+// PERICRU_SOFTRST_CON03(Offset:0xA0C)
+#define SRST_PRESETN_UART2			0x00000030
+#define SRST_SRESETN_UART2			0x00000031
+#define SRST_PRESETN_UART1			0x00000032
+#define SRST_SRESETN_UART1			0x00000033
+#define SRST_PRESETN_SPI0			0x0000003A
+#define SRST_RESETN_SPI0			0x0000003B
+
+// PERICRU_SOFTRST_CON04(Offset:0xA10)
+#define SRST_PRESETN_PWM1			0x00000046
+#define SRST_RESETN_PWM1			0x00000047
+#define SRST_PRESETN_PWM2			0x0000004C
+#define SRST_RESETN_PWM2			0x0000004D
+
+// PERICRU_SOFTRST_CON05(Offset:0xA14)
+#define SRST_ARESETN_RKDMA			0x00000058
+#define SRST_PRESETN_TSADC			0x00000059
+#define SRST_RESETN_TSADC			0x0000005A
+#define SRST_PRESETN_SARADC			0x0000005C
+#define SRST_RESETN_SARADC			0x0000005D
+
+// PERICRU_SOFTRST_CON06(Offset:0xA18)
+#define SRST_RESETN_SARADC_PHY			0x00000060
+#define SRST_PRESETN_RTC_TEST			0x00000061
+#define SRST_PRESETN_GPIO2			0x00000063
+#define SRST_DBRESETN_GPIO2			0x00000064
+#define SRST_PRESETN_IOC_VCCIO6			0x00000065
+#define SRST_PRESETN_PERI_SGRF			0x00000066
+#define SRST_PRESETN_PERI_GRF			0x00000067
+#define SRST_PRESETN_CRU_PERI			0x00000068
+#define SRST_ARESETN_USBOTG			0x00000069
+
+// PERICRU_SOFTRST_CON07(Offset:0xA1C)
+#define SRST_HRESETN_SDMMC1			0x00000070
+#define SRST_HRESETN_SAI			0x00000071
+#define SRST_MRESETN_SAI			0x00000072
+
+// PERICRU_SOFTRST_CON08(Offset:0xA20)
+#define SRST_RESETN_CORE_CRYPTO			0x00000080
+#define SRST_RESETN_PKA_CRYPTO			0x00000081
+#define SRST_ARESETN_CRYPTO			0x00000082
+#define SRST_HRESETN_CRYPTO			0x00000083
+#define SRST_HRESETN_RK_RNG_NS			0x00000084
+#define SRST_HRESETN_RK_RNG_S			0x00000085
+#define SRST_PRESETN_OTPC_NS			0x00000086
+#define SRST_RESETN_SBPI_OTPC_NS		0x00000088
+#define SRST_RESETN_USER_OTPC_NS		0x00000089
+#define SRST_PRESETN_OTPC_S			0x0000008A
+#define SRST_RESETN_SBPI_OTPC_S			0x0000008C
+#define SRST_RESETN_USER_OTPC_S			0x0000008D
+#define SRST_RESETN_OTPC_ARB			0x0000008E
+#define SRST_PRESETN_OTP_MASK			0x0000008F
+
+// PERICRU_SOFTRST_CON09(Offset:0xA24)
+#define SRST_HRESETN_RGA			0x00000090
+#define SRST_ARESETN_RGA			0x00000091
+#define SRST_RESETN_CORE_RGA			0x00000092
+#define SRST_ARESETN_MAC			0x00000093
+#define SRST_RESETN_MACPHY			0x0000009B
+
+// PERICRU_SOFTRST_CON10(Offset:0xA28)
+#define SRST_ARESETN_SPINLOCK			0x000000A0
+#define SRST_HRESETN_CACHE			0x000000A1
+#define SRST_PRESETN_HPMCU_MAILBOX		0x000000A2
+#define SRST_PRESETN_HPMCU_INTMUX		0x000000A3
+#define SRST_RESETN_HPMCU_FULL_CLUSTER		0x000000A4
+#define SRST_RESETN_HPMCU_PWUP			0x000000A5
+#define SRST_RESETN_HPMCU_ONLY_CORE		0x000000A6
+#define SRST_TRESETN_HPMCU_JTAG			0x000000A7
+
+// PERICRU_SOFTRST_CON11(Offset:0xA2C)
+#define SRST_DRESETN_DECOM			0x000000B0
+#define SRST_ARESETN_DECOM			0x000000B1
+#define SRST_PRESETN_DECOM			0x000000B2
+#define SRST_ARESETN_SYS_SRAM			0x000000B3
+#define SRST_PRESETN_DMA2DDR			0x000000B4
+#define SRST_ARESETN_DMA2DDR			0x000000B5
+#define SRST_PRESETN_DCF			0x000000B6
+#define SRST_ARESETN_DCF			0x000000B7
+#define SRST_RESETN_USBPHY_POR			0x000000BC
+#define SRST_RESETN_USBPHY_OTG			0x000000BD
+
+// ======================= VEPUCRU module definition bank=1 =======================
+// VEPUCRU_SOFTRST_CON00(Offset:0xA00)
+#define SRST_ARESETN_VEPU_BIU			0x00040001
+#define SRST_LSRESETN_VEPU_BIU			0x00040002
+#define SRST_RESETN_REF_PVTPLL_VEPU		0x00040003
+#define SRST_HRESETN_VEPU			0x00040004
+#define SRST_ARESETN_VEPU			0x00040005
+#define SRST_RESETN_CORE_VEPU			0x00040006
+#define SRST_PRESETN_VEPU_PVTPLL		0x00040007
+#define SRST_PRESETN_CRU_VEPU			0x00040008
+#define SRST_PRESETN_VEPU_GRF			0x0004000A
+#define SRST_PRESETN_IOC_VCCIO3			0x0004000B
+#define SRST_PRESETN_ACODEC			0x0004000D
+#define SRST_PRESETN_USBPHY			0x0004000E
+
+// ======================= NPUCRU module definition bank=2 ========================
+// NPUCRU_SOFTRST_CON00(Offset:0xA00)
+#define SRST_RESETN_REF_PVTPLL_NPU		0x00080000
+#define SRST_ARESETN_NPU_BIU			0x00080002
+#define SRST_LSRESETN_NPU_BIU			0x00080003
+#define SRST_HRESETN_RKNN			0x00080004
+#define SRST_ARESETN_RKNN			0x00080005
+#define SRST_PRESETN_NPU_PVTPLL			0x00080006
+#define SRST_PRESETN_CRU_NPU			0x00080007
+#define SRST_PRESETN_NPU_GRF			0x00080009
+
+// ======================== VICRU module definition bank=3 ========================
+// VICRU_SOFTRST_CON00(Offset:0xA00)
+#define SRST_LSRESETN_VI_BIU			0x000c0001
+#define SRST_ARESETN_VI_BIU			0x000c0002
+#define SRST_RESETN_REF_PVTPLL_ISP		0x000c0003
+#define SRST_RESETN_CORE_ISP			0x000c0006
+
+// VICRU_SOFTRST_CON01(Offset:0xA04)
+#define SRST_DRESETN_VICAP			0x000c0010
+#define SRST_ARESETN_VICAP			0x000c0012
+#define SRST_HRESETN_VICAP			0x000c0013
+#define SRST_ISP0RESETN_VICAP			0x000c0018
+#define SRST_PRESETN_CSI2HOST0			0x000c0019
+#define SRST_PRESETN_CSI2HOST1			0x000c001B
+#define SRST_SRESETN_SFC_2X			0x000c001C
+#define SRST_HRESETN_EMMC			0x000c001D
+#define SRST_HRESETN_SFC			0x000c001E
+#define SRST_HRESETN_SFC_XIP			0x000c001F
+
+// VICRU_SOFTRST_CON02(Offset:0xA08)
+#define SRST_HRESETN_SDMMC0			0x000c0020
+#define SRST_PRESETN_CSIPHY			0x000c0022
+#define SRST_PRESETN_GPIO1			0x000c0023
+#define SRST_DBRESETN_GPIO1			0x000c0024
+#define SRST_PRESETN_IOC_VCCIO47		0x000c0025
+#define SRST_PRESETN_VI_GRF			0x000c0026
+#define SRST_PRESETN_CRU_VI			0x000c0028
+#define SRST_PRESETN_VI_PVTPLL			0x000c0029
+
+// ======================= CORECRU module definition bank=4 =======================
+// CORECRU_SOFTRST_CON00(Offset:0xA00)
+#define SRST_RESETN_REF_PVTPLL_CORE		0x00100000
+#define SRST_NCOREPORESET			0x00100001
+#define SRST_NCORESET				0x00100002
+#define SRST_NDBGRESET				0x00100003
+#define SRST_NL2RESET				0x00100004
+#define SRST_ARESETN_CORE_BIU			0x00100005
+#define SRST_PRESETN_CORE_BIU			0x00100006
+#define SRST_HRESETN_CORE_BIU			0x00100007
+#define SRST_PRESETN_DBG			0x00100008
+#define SRST_POTRESETN_DBG			0x00100009
+#define SRST_NTRESETN_DBG			0x0010000A
+
+// ======================= DDRCRU module definition bank=5 ========================
+// DDRCRU_SOFTRST_CON00(Offset:0xA00)
+#define SRST_LSRESETN_DDR_BIU			0x00140001
+#define SRST_PRESETN_DDRC			0x00140002
+#define SRST_PRESETN_DDRMON			0x00140003
+#define SRST_RESETN_TIMER_DDRMON		0x00140004
+#define SRST_PRESETN_DFICTRL			0x00140005
+#define SRST_PRESETN_DDR_GRF			0x00140006
+#define SRST_PRESETN_CRU_DDR			0x00140007
+#define SRST_HRESETN_DDRPHY			0x00140008
+
+// ====================== SUBDDRCRU module definition bank=6 ======================
+// SUBDDRCRU_SOFTRST_CON00(Offset:0xA00)
+#define SRST_RESETN_DDR_BIU			0x00160001
+#define SRST_ARESETN_DDRSCH_CPU			0x00160002
+#define SRST_ARESETN_DDRSCH_VI			0x00160004
+#define SRST_ARESETN_DDRSCH_NPVD		0x00160005
+#define SRST_RESETN_CORE_DDRC			0x00160006
+#define SRST_RESETN_DDRMON			0x00160007
+#define SRST_RESETN_DFICTRL			0x00160008
+#define SRST_RESETN_DFI_SCRAMBLE		0x00160009
+
+// ======================= TOPCRU module definition bank=7 ========================
+// TOPCRU_SOFTRST_CON00(Offset:0xA00)
+#define SRST_PRESETN_CRU			0x00180000
+#define SRST_PRESETN_CRU_BIU			0x00180001
+#define SRST_RESETN_DDRPHY			0x0018000C
+
+//======================= PMUCRU module definition bank=8 ========================
+// PMUCRU_SOFTRST_CON00(Offset:0xA00)
+#define SRST_PRESETN_PMU_GPIO0			0x001c0004
+#define SRST_DBRESETN_PMU_GPIO0			0x001c0005
+#define SRST_RESETN_DDR_FAIL_SAFE		0x001c0008
+#define SRST_PRESETN_PMU_HP_TIMER		0x001c0009
+#define SRST_RESETN_PMU_HP_TIMER		0x001c000A
+#define SRST_RESETN_PMU_32K_HP_TIMER		0x001c000B
+#define SRST_PRESETN_I2C0			0x001c000C
+#define SRST_RESETN_I2C0			0x001c000D
+#define SRST_PRESETN_UART0			0x001c000E
+#define SRST_SRESETN_UART0			0x001c000F
+
+// PMUCRU_SOFTRST_CON01(Offset:0xA04)
+#define SRST_PRESETN_IOC_PMUIO0			0x001c0010
+#define SRST_PRESETN_CRU_PMU			0x001c0011
+#define SRST_PRESETN_PMU_GRF			0x001c0012
+#define SRST_PRESETN_PMU_SGRF			0x001c0013
+#define SRST_PRESETN_PMU_SGRF_REMAP		0x001c0014
+#define SRST_RESETN_PREROLL			0x001c0016
+#define SRST_RESETN_PREROLL_32K			0x001c0017
+#define SRST_HRESETN_PMU_SRAM			0x001c0018
+#define SRST_PRESETN_PWM0			0x001c0019
+#define SRST_RESETN_PWM0			0x001c001A
+
+// PMUCRU_SOFTRST_CON02(Offset:0xA08)
+#define SRST_RESETN_LPMCU			0x001c0020
+#define SRST_RESETN_LPMCU_PWRUP			0x001c0021
+#define SRST_RESETN_LPMCU_CPU			0x001c0022
+#define SRST_TRESETN_LPMCU_CPU			0x001c0023
+
+// ======================= PMU1CRU module definition bank=9 =======================
+// PMU1CRU_SOFTRST_CON00(Offset:0xA00)
+#define SRST_PRESETN_SPI2AHB			0x00200000
+#define SRST_HRESETN_SPI2AHB			0x00200001
+#define SRST_SRESETN_SPI2AHB			0x00200002
+#define SRST_LSRESETN_PMU_BIU			0x00200003
+#define SRST_PRESETN_WDT_LPMCU			0x00200009
+#define SRST_TRESETN_WDT_LPMCU			0x0020000A
+#define SRST_HRESETN_SFC_PMU1			0x0020000C
+#define SRST_HRESETN_SFC_XIP_PMU1		0x0020000D
+#define SRST_SRESETN_SFC_2X_PMU1		0x0020000E
+
+// PMU1CRU_SOFTRST_CON01(Offset:0xA04)
+#define SRST_PRESETN_LPMCU_MAILBOX		0x00200018
+#define SRST_PRESETN_IOC_PMUIO1			0x00200019
+#define SRST_PRESETN_CRU_PMU1			0x0020001A
+
+#define CLK_NR_SRST				(SRST_PRESETN_CRU_PMU1 + 1)
+
+#endif
-- 
2.34.1

