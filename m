Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC4CEF06E2
	for <u-boot@archiver.kernel.org>; Sun,  8 Feb 2026 21:27:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3948D83BE1;
	Sun,  8 Feb 2026 22:26:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CmzDpRyi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C772883BE1; Sun,  8 Feb 2026 22:26:56 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E03B583642
 for <u-boot@lists.denx.de>; Sun,  8 Feb 2026 22:26:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-79274e0e56bso33911927b3.0
 for <u-boot@lists.denx.de>; Sun, 08 Feb 2026 13:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770586013; x=1771190813; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0vrAuH+LYYBSxRzNvbPJKglB1/ZvCTpbxnTOFvk6i3U=;
 b=CmzDpRyiX5zWUmx010jDya0kXjTwek8dIloS9hgGNbbEDUyEZZHoAnAGl/eF7gJQFX
 f9KrIMtEG83QTsNIEfYIyC6Eeo1htkX67pWV5k9wy/J45y6QF/g8yl8iOl/O3QM/V6fS
 wMMQ9yeUUpj0Wjoeg+J0MvJbehPOMK1Gx9DDG/sMwlRzbp6vrZsz53FUqaBzxl/3boub
 BdUKmMDRn4KoXklHLQIsYcEPOp/4XFuwvy1E1YFFZfRXblKbPRUnBs1x0FQVsuANFX8n
 gO+DN+M0kBa2t8U1plGS1DQPkB4Nn+bviCeBF0+jEr7P5KPhCxABZuohBsj1Mm+8n62D
 oiyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770586013; x=1771190813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0vrAuH+LYYBSxRzNvbPJKglB1/ZvCTpbxnTOFvk6i3U=;
 b=p/u92dNfMXjUjJdtzuck1rIl4cM9FcEr4XvlElx6esfQHh5FPNCEQGcKlBY61ktFw0
 cC8YicNwmqEhcNXl+4fPEFe7Z17UZos4rGEaRj3jXxfBBtFfNXlKlAG9g61FKXGRuMHk
 ZALww5WfI4djmgkp+VuRFgnZgns7uMwiXJ+KpuZ/ntKS6Z6dPMCAfPY4HTR9MZP5k8lr
 Qdv89VEfaz5eU4la2FMd2l645HubotAHBBnMOyUI8L5aElEjrsnjT+SDZc6lP/tAP/10
 Pvg6KZGfuk+SXgGdrqdpY4GbFwIsD617gHp0lRxsxXUJbNwoBgbTln4CfmdYl08TcMMl
 TiRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTGEC+YRXYBP3RAu2VF2fmhIOOZLQcO6HVapvGLHfGfj1gnw6MVnbxDA+2NAXX6szc4hQPGM4=@lists.denx.de
X-Gm-Message-State: AOJu0YzmDeBc9ubAylralDkux1/dAqJ7wH3MhBb70rl4Zdb5G98d2Lk1
 2T4RzrwLsKPGW4UXVfkpAXmsAy8uGAW4WFAjFISL64ACrogm6WAgJEnl
X-Gm-Gg: AZuq6aLWD1UJTduv83PLe04lq89xuQqlHWchRc/olvvUbRdLZFwkswkbyzmmrqIh0m+
 oEUp51lslQLwxK4Vwqpu5CcvfzaM3yuswLofh7WzlpgTqw/6/mNdBMOBsM8UABxKxiuPszpXjHo
 2g7R089oeYS7kykdCzmWfKiRjTyE02yfEYBDty6m31jBrkmGlSGthJo1jGIjqo3+40gfldVy5Yo
 JDr8eC8RjKO/XJpJ3ZxSM94AwdwZ7tH60XSFjr37e5K83YzoWLEKkcs7KUkLDgEnFEP0cVc3mC0
 byzLHqATS7PMQZGWaIrLSe3FYUDir20kjujU/MaYzpueJIQCsCbaA5CauFLP4Ap0+2su06azn/f
 Hsjzt2dcgGkChNEvh2EM1D6Ni1D2BUKIsaW78vmohuinPy5ylbD5ysAAEeKf5RUpBt+8AjJXGje
 RWJOwk4c0oBIy4Gp9ZwEYD4SGe
X-Received: by 2002:a05:690c:7305:b0:793:995f:25f9 with SMTP id
 00721157ae682-7952aa7673amr85293017b3.28.1770586012623; 
 Sun, 08 Feb 2026 13:26:52 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:5d9f:efd7:6c6a:abf8])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7952a085999sm75229377b3.25.2026.02.08.13.26.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Feb 2026 13:26:52 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: kever.yang@rock-chips.com
Cc: trini@konsulko.com, jonas@kwiboo.se, u-boot@lists.denx.de,
 Fabio Estevam <festevam@nabladev.com>
Subject: [PATCH v2 7/7] omega4-rv1103b: Add the initial support
Date: Sun,  8 Feb 2026 18:26:24 -0300
Message-Id: <20260208212624.3413494-8-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260208212624.3413494-1-festevam@gmail.com>
References: <20260208212624.3413494-1-festevam@gmail.com>
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

Add the initial support for Onion's Omega4 RV1103B board.

It boots from the SPI NAND.

Tested the boot of a 6.6 OpenWRT kernel and also a 6.19-rc8 mainline
kernel.

Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
Changes since v1:
- Only adapted to the correct SoC name: RV1103B instead of RV1103.

 arch/arm/include/asm/arch-rv1103b/boot0.h     |  11 ++
 arch/arm/mach-rockchip/Kconfig                |  14 ++
 arch/arm/mach-rockchip/Makefile               |   1 +
 arch/arm/mach-rockchip/rv1103b/Kconfig        |  23 +++
 arch/arm/mach-rockchip/rv1103b/Makefile       |  12 ++
 arch/arm/mach-rockchip/rv1103b/boot0.h        |   5 +
 arch/arm/mach-rockchip/rv1103b/clk_rv1103b.c  |  32 +++++
 arch/arm/mach-rockchip/rv1103b/rv1103b.c      | 133 ++++++++++++++++++
 .../mach-rockchip/rv1103b/syscon_rv1103b.c    |  19 +++
 board/onion/omega4_rv1103b/Kconfig            |  12 ++
 board/onion/omega4_rv1103b/MAINTAINERS        |   6 +
 board/onion/omega4_rv1103b/Makefile           |   7 +
 board/onion/omega4_rv1103b/omega4_rv1103b.c   |  19 +++
 board/onion/omega4_rv1103b/omega4_rv1103b.env |   5 +
 configs/omega4-rv1103b_defconfig              |  82 +++++++++++
 doc/board/index.rst                           |   1 +
 doc/board/onion/index.rst                     |   9 ++
 doc/board/onion/omega4-rv1103b.rst            |  56 ++++++++
 include/configs/omega4_rv1103b.h              |  11 ++
 include/configs/rv1103b_common.h              |  14 ++
 20 files changed, 472 insertions(+)
 create mode 100644 arch/arm/include/asm/arch-rv1103b/boot0.h
 create mode 100644 arch/arm/mach-rockchip/rv1103b/Kconfig
 create mode 100644 arch/arm/mach-rockchip/rv1103b/Makefile
 create mode 100644 arch/arm/mach-rockchip/rv1103b/boot0.h
 create mode 100644 arch/arm/mach-rockchip/rv1103b/clk_rv1103b.c
 create mode 100644 arch/arm/mach-rockchip/rv1103b/rv1103b.c
 create mode 100644 arch/arm/mach-rockchip/rv1103b/syscon_rv1103b.c
 create mode 100644 board/onion/omega4_rv1103b/Kconfig
 create mode 100644 board/onion/omega4_rv1103b/MAINTAINERS
 create mode 100644 board/onion/omega4_rv1103b/Makefile
 create mode 100644 board/onion/omega4_rv1103b/omega4_rv1103b.c
 create mode 100644 board/onion/omega4_rv1103b/omega4_rv1103b.env
 create mode 100644 configs/omega4-rv1103b_defconfig
 create mode 100644 doc/board/onion/index.rst
 create mode 100644 doc/board/onion/omega4-rv1103b.rst
 create mode 100644 include/configs/omega4_rv1103b.h
 create mode 100644 include/configs/rv1103b_common.h

diff --git a/arch/arm/include/asm/arch-rv1103b/boot0.h b/arch/arm/include/asm/arch-rv1103b/boot0.h
new file mode 100644
index 000000000000..2e78b074ade8
--- /dev/null
+++ b/arch/arm/include/asm/arch-rv1103b/boot0.h
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
index 92bb4aa62f11..c1faeb974328 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -487,6 +487,19 @@ config ROCKCHIP_RK3588
 	  SD3.0/MMC4.5, USB OTG 3.0, Type-C, USB 2.0, PCIe 3.0, SATA 3, Ethernet,
 	  SDIO3.0 I2C, UART, SPI, GPIO and PWM.
 
+config ROCKCHIP_RV1103B
+	bool "Support Rockchip RV1103B"
+	select CPU_V7A
+	select SPL_ARMV7_SET_CORTEX_SMPEN
+	select SUPPORT_SPL
+	select SPL
+	imply ROCKCHIP_COMMON_BOARD
+
+	help
+	  The Rockchip RV1103B is an ARM-based SoC with a single Cortex-A7
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
+source "arch/arm/mach-rockchip/rv1103b/Kconfig"
 source "arch/arm/mach-rockchip/rv1108/Kconfig"
 source "arch/arm/mach-rockchip/rv1126/Kconfig"
 
diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
index 06fb527b21a0..7bbb1697836c 100644
--- a/arch/arm/mach-rockchip/Makefile
+++ b/arch/arm/mach-rockchip/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_ROCKCHIP_RK3528) += rk3528/
 obj-$(CONFIG_ROCKCHIP_RK3568) += rk3568/
 obj-$(CONFIG_ROCKCHIP_RK3576) += rk3576/
 obj-$(CONFIG_ROCKCHIP_RK3588) += rk3588/
+obj-$(CONFIG_ROCKCHIP_RV1103B) += rv1103b/
 obj-$(CONFIG_ROCKCHIP_RV1108) += rv1108/
 obj-$(CONFIG_ROCKCHIP_RV1126) += rv1126/
 
diff --git a/arch/arm/mach-rockchip/rv1103b/Kconfig b/arch/arm/mach-rockchip/rv1103b/Kconfig
new file mode 100644
index 000000000000..6b5f5b0b9e14
--- /dev/null
+++ b/arch/arm/mach-rockchip/rv1103b/Kconfig
@@ -0,0 +1,23 @@
+if ROCKCHIP_RV1103B
+
+
+config TARGET_OMEGA4_RV1103B
+	bool "OMEGA4_RV1103B"
+	help
+	  Support Onion's Omega4 RV1103B board.
+
+config ROCKCHIP_BOOT_MODE_REG
+	default 0x20160200
+
+config ROCKCHIP_STIMER_BASE
+	default 0x20500000
+
+config SYS_SOC
+	default "rv1103b"
+
+config SYS_MALLOC_F_LEN
+	default 0x400
+
+source "board/onion/omega4_rv1103b/Kconfig"
+
+endif
diff --git a/arch/arm/mach-rockchip/rv1103b/Makefile b/arch/arm/mach-rockchip/rv1103b/Makefile
new file mode 100644
index 000000000000..2f34853adac5
--- /dev/null
+++ b/arch/arm/mach-rockchip/rv1103b/Makefile
@@ -0,0 +1,12 @@
+#
+# (C) Copyright 2016 Rockchip Electronics Co., Ltd
+#
+# SPDX-License-Identifier:     GPL-2.0+
+#
+
+obj-y += rv1103b.o
+obj-y += clk_rv1103b.o
+
+ifndef CONFIG_XPL_BUILD
+obj-y += syscon_rv1103b.o
+endif
diff --git a/arch/arm/mach-rockchip/rv1103b/boot0.h b/arch/arm/mach-rockchip/rv1103b/boot0.h
new file mode 100644
index 000000000000..466ab0e80770
--- /dev/null
+++ b/arch/arm/mach-rockchip/rv1103b/boot0.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Dummy boot0.h for RV1103B — SoC does not require special boot0 setup. */
+#ifndef __ASM_ARCH_BOOT0_H__
+#define __ASM_ARCH_BOOT0_H__
+#endif
diff --git a/arch/arm/mach-rockchip/rv1103b/clk_rv1103b.c b/arch/arm/mach-rockchip/rv1103b/clk_rv1103b.c
new file mode 100644
index 000000000000..2bcbb08537e8
--- /dev/null
+++ b/arch/arm/mach-rockchip/rv1103b/clk_rv1103b.c
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
+#include <asm/arch-rockchip/cru_rv1103b.h>
+#include <linux/err.h>
+
+int rockchip_get_clk(struct udevice **devp)
+{
+	return uclass_get_device_by_driver(UCLASS_CLK,
+			DM_DRIVER_GET(clk_rv1103b), devp);
+}
+
+void *rockchip_get_cru(void)
+{
+	struct rv1103b_clk_priv *priv;
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
diff --git a/arch/arm/mach-rockchip/rv1103b/rv1103b.c b/arch/arm/mach-rockchip/rv1103b/rv1103b.c
new file mode 100644
index 000000000000..a7ff1934f7db
--- /dev/null
+++ b/arch/arm/mach-rockchip/rv1103b/rv1103b.c
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
+#define RV1103B_WDT_BASE			0x208d0000
+#define RV1103B_WDT_CR			0x00
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
+	writel(0, RV1103B_WDT_BASE + RV1103B_WDT_CR);
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
diff --git a/arch/arm/mach-rockchip/rv1103b/syscon_rv1103b.c b/arch/arm/mach-rockchip/rv1103b/syscon_rv1103b.c
new file mode 100644
index 000000000000..545b4d8ebe12
--- /dev/null
+++ b/arch/arm/mach-rockchip/rv1103b/syscon_rv1103b.c
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
+static const struct udevice_id rv1103b_syscon_ids[] = {
+	{ .compatible = "rockchip,rv1103b-grf", .data = ROCKCHIP_SYSCON_GRF },
+	{ }
+};
+
+U_BOOT_DRIVER(syscon_rv1103b) = {
+	.name = "rv1103b_syscon",
+	.id = UCLASS_SYSCON,
+	.of_match = rv1103b_syscon_ids,
+};
diff --git a/board/onion/omega4_rv1103b/Kconfig b/board/onion/omega4_rv1103b/Kconfig
new file mode 100644
index 000000000000..43b126c20e9c
--- /dev/null
+++ b/board/onion/omega4_rv1103b/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_OMEGA4_RV1103B
+
+config SYS_BOARD
+	default "omega4_rv1103b"
+
+config SYS_VENDOR
+	default "onion"
+
+config SYS_CONFIG_NAME
+	default "omega4_rv1103b"
+
+endif
diff --git a/board/onion/omega4_rv1103b/MAINTAINERS b/board/onion/omega4_rv1103b/MAINTAINERS
new file mode 100644
index 000000000000..53d774535bdd
--- /dev/null
+++ b/board/onion/omega4_rv1103b/MAINTAINERS
@@ -0,0 +1,6 @@
+OMEGA4 RV1103B
+M:      Fabio Estevam <festevam@nabladev.com>
+S:      Maintained
+F:      board/onion/omega4_rv1103b
+F:      include/configs/omega4_rv1103b.h
+F:      configs/omega4-rv1103b_defconfig
diff --git a/board/onion/omega4_rv1103b/Makefile b/board/onion/omega4_rv1103b/Makefile
new file mode 100644
index 000000000000..afa0a7f7a932
--- /dev/null
+++ b/board/onion/omega4_rv1103b/Makefile
@@ -0,0 +1,7 @@
+#
+# SPDX-License-Identifier:	GPL-2.0+
+#
+# Copyright 2026 Fabio Estevam <festevam@nabladev.com>
+#
+
+obj-y	+= omega4_rv1103b.o
diff --git a/board/onion/omega4_rv1103b/omega4_rv1103b.c b/board/onion/omega4_rv1103b/omega4_rv1103b.c
new file mode 100644
index 000000000000..9bdec3c396a8
--- /dev/null
+++ b/board/onion/omega4_rv1103b/omega4_rv1103b.c
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
diff --git a/board/onion/omega4_rv1103b/omega4_rv1103b.env b/board/onion/omega4_rv1103b/omega4_rv1103b.env
new file mode 100644
index 000000000000..7ed232cab916
--- /dev/null
+++ b/board/onion/omega4_rv1103b/omega4_rv1103b.env
@@ -0,0 +1,5 @@
+kernel_addr_r=0x00800000
+fdt_addr_r=0x02000000
+ramdisk_addr_r=0x04000000
+bootargs=console=ttyS0,115200 mtdparts=spi1.0:256K(env),1M@256K(idblock),1M(uboot),8M(boot),-(ubi) ro rootwait ubi.mtd=ubi ubi.block=0,rootfs root=/dev/ubiblock0_0 rootfstype=squashfs
+bootcmd=mtd read spi-nand0 0x04000000 0x240000 0x800000;imxtract 0x04000000 kernel 0x00800000; imxtract 0x04000000 fdt 0x02000000; bootz 0x00800000 - 0x02000000
diff --git a/configs/omega4-rv1103b_defconfig b/configs/omega4-rv1103b_defconfig
new file mode 100644
index 000000000000..b1e8ede1cf6e
--- /dev/null
+++ b/configs/omega4-rv1103b_defconfig
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
+CONFIG_DEFAULT_DEVICE_TREE="rv1103b-omega4"
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x100000
+CONFIG_ROCKCHIP_RV1103B=y
+CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
+CONFIG_ROCKCHIP_EXTERNAL_TPL=y
+CONFIG_SPL_SERIAL=y
+CONFIG_TARGET_OMEGA4_RV1103B=y
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
+CONFIG_PINCTRL_ROCKCHIP_RV1103B=y
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
index 000000000000..2e106c8b7734
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
+   omega4-rv1103b
diff --git a/doc/board/onion/omega4-rv1103b.rst b/doc/board/onion/omega4-rv1103b.rst
new file mode 100644
index 000000000000..41c64f40d6c4
--- /dev/null
+++ b/doc/board/onion/omega4-rv1103b.rst
@@ -0,0 +1,56 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Onion Omega4 RV1103B board
+==========================
+
+U-Boot for the Onion Omega4 RV1103B board
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
+The RV1103B DDR initialization is located at rkbin/bin/rv11/rv1103bb_ddr_924MHz_v1.05.bin
+
+Build U-Boot
+------------
+
+.. code-block:: bash
+
+   $ export CROSS_COMPILE=arm-linux-gnueabihf-
+   $ export ROCKCHIP_TPL=<path-to-rkbin>/bin/rv11/rv1103bb_ddr_924MHz_v1.05.bin
+   $ make omega4-rv1103b_defconfig
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
diff --git a/include/configs/omega4_rv1103b.h b/include/configs/omega4_rv1103b.h
new file mode 100644
index 000000000000..8430b0b4d091
--- /dev/null
+++ b/include/configs/omega4_rv1103b.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2016 Rockchip Electronics Co., Ltd
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#include <configs/rv1103b_common.h>
+
+#endif
diff --git a/include/configs/rv1103b_common.h b/include/configs/rv1103b_common.h
new file mode 100644
index 000000000000..8e970d710514
--- /dev/null
+++ b/include/configs/rv1103b_common.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2016 Rockchip Electronics Co., Ltd
+ */
+#ifndef __CONFIG_RV1103B_COMMON_H
+#define __CONFIG_RV1103B_COMMON_H
+
+#include "rockchip-common.h"
+#include <config_distro_bootcmd.h>
+
+#define CFG_IRAM_BASE			0x210f6000
+#define CFG_SYS_SDRAM_BASE		0x00000000
+
+#endif
-- 
2.34.1

