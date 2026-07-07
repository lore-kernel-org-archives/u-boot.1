Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3592FC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 15:33:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1D3984AD0;
	Tue,  7 Jul 2026 17:32:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="a4hMJC1v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B028284ADD; Tue,  7 Jul 2026 17:32:48 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28D50849F6
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 17:32:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-492046a3313so3111016b6e.2
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 08:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783438365; x=1784043165; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OXpBSzlajiZk2ZGSeqyOzkGYKwOnO2ScqTFZehxZSH4=;
 b=a4hMJC1vqgBLEy0759s8FT378Vgi8pn8CIMh53PhOzRvIV4E/SOBrzzpsZk4WxJzu3
 43xn2wTJXAoWtlGwX02YWK8I4nJAq1Ku18IJEVPXWeuR6kBiHNPVPFaa1caMuf7DzH3h
 axknkvQdHA2U78oqhKJiECN7CnssFWbKXBojg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783438365; x=1784043165;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OXpBSzlajiZk2ZGSeqyOzkGYKwOnO2ScqTFZehxZSH4=;
 b=qt11IoUDIma9M821l/SDQOOcJ8tM6vGe/D7stx0gAdcGI1GQyPOHcWrblz6u4K5JWR
 Sz8t7qj0unL41uyXAOAOcN7ufZm7jWo3cIiUJoQBbZFbTVTxqjvkzlQ7x6VIgCr0Qf8O
 fZ9QvtcGPvhntM6sfmkWeA3dmDp6FxyHonib8vY0bUN8YpFenbk6bwd2CX/eo6OG9KDb
 BGhUZIWNRbYqSoM+PVDAvA3rRl0hgUkioXJ7Sn0jMu6HznitwiFR1ccn/RlrZqsaJe2K
 MUJ22Oarw3DXMcFIBn6kebjaUPsSfpy04jei8DG1rsv+w0DCmf5s+mw3ReaL+Rtal0CS
 aibw==
X-Gm-Message-State: AOJu0YzmiloMcpO/PQkxpzGkVj7BPRV5oHD26UURFHRHUD1Cz2puABZL
 bKzt/51S5os0gYXD6+JYQQ1jPa25LxlL8EeLvh5o8pBrPWPVfcGEc3RRyUIcrDjZeEQXJ0QqoNU
 lPfYhnQ==
X-Gm-Gg: AfdE7ckgNs0MzsqKXifqHunCRwC92KPfBXE4WZTEJ6SJQ53QsG7kNy58fc2a8RE3RMs
 3xeM0bxJPNpF/guRxTMFdx4V2YafOMDfFxlcGf/a0Vfqg5kehnfbaWl1nZWkQxsauBg9VwmAQXN
 l8Af6jpbh+PaKOU1fRvmLEh+I+W8HObloPvHHkLftu+88FG+SWb+/8glt39hQaztQaT4CSGMTXF
 4mC2djFG0cEYzh4Q3sqYTQO2pKna3teToP/No+fkXFkEV2o6mVGJ/TT2NvNDheMuxUr+2R4xCab
 1UWtkh4/RMstSzFz1O3fRraifcI2XIEtJ17Bj+2ktZ1Mg5RKZ/M//bSPsltcwTR+YJeJJHc2IuA
 EroNBY9KvrwspeB1AnEtWN2BhuSh1oVp3HsXXwVDyIlIGdIDYv9dE0vcTuxwIoi6SkYINLq0P9A
 UszBR64sk=
X-Received: by 2002:a05:6808:1b06:b0:490:9b13:e9cd with SMTP id
 5614622812f47-49fde0e0d2fmr3949094b6e.24.1783438364751; 
 Tue, 07 Jul 2026 08:32:44 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-497d1b43cfcsm12052218b6e.14.2026.07.07.08.32.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:32:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@nabladev.com>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v3 07/15] rockchip: rv1103b: Add SoC support
Date: Tue,  7 Jul 2026 09:31:05 -0600
Message-ID: <20260707153135.2048115-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707153135.2048115-1-sjg@chromium.org>
References: <20260707153135.2048115-1-sjg@chromium.org>
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

The RV1103B is an ARM-based SoC with a single Cortex-A7 32-bit core
which integrates NEON and FPU. It contains a built-in NPU for AI
related applications.

Add the core SoC support for it: the Kconfig and Makefile entries,
the boot0 hook, the SoC init code, the syscon driver and the SPL
clock setup.

Signed-off-by: Fabio Estevam <festevam@nabladev.com>
Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- New patch, split out from the board patch (Jonas)
- Include the SoC u-boot.dtsi here (Jonas)
- Match the pmu-grf compatible used by the devicetree merged in Linux
  v7.1

 arch/arm/dts/rv1103b-u-boot.dtsi              |   4 +
 arch/arm/include/asm/arch-rv1103b/boot0.h     |  11 ++
 arch/arm/mach-rockchip/Kconfig                |  13 ++
 arch/arm/mach-rockchip/Makefile               |   1 +
 arch/arm/mach-rockchip/rv1103b/Kconfig        |  15 ++
 arch/arm/mach-rockchip/rv1103b/Makefile       |  12 ++
 arch/arm/mach-rockchip/rv1103b/boot0.h        |   5 +
 arch/arm/mach-rockchip/rv1103b/clk_rv1103b.c  |  32 +++++
 arch/arm/mach-rockchip/rv1103b/rv1103b.c      | 133 ++++++++++++++++++
 .../mach-rockchip/rv1103b/syscon_rv1103b.c    |  19 +++
 include/configs/rv1103b_common.h              |  14 ++
 11 files changed, 259 insertions(+)
 create mode 100644 arch/arm/dts/rv1103b-u-boot.dtsi
 create mode 100644 arch/arm/include/asm/arch-rv1103b/boot0.h
 create mode 100644 arch/arm/mach-rockchip/rv1103b/Kconfig
 create mode 100644 arch/arm/mach-rockchip/rv1103b/Makefile
 create mode 100644 arch/arm/mach-rockchip/rv1103b/boot0.h
 create mode 100644 arch/arm/mach-rockchip/rv1103b/clk_rv1103b.c
 create mode 100644 arch/arm/mach-rockchip/rv1103b/rv1103b.c
 create mode 100644 arch/arm/mach-rockchip/rv1103b/syscon_rv1103b.c
 create mode 100644 include/configs/rv1103b_common.h

diff --git a/arch/arm/dts/rv1103b-u-boot.dtsi b/arch/arm/dts/rv1103b-u-boot.dtsi
new file mode 100644
index 00000000000..3b77dd31152
--- /dev/null
+++ b/arch/arm/dts/rv1103b-u-boot.dtsi
@@ -0,0 +1,4 @@
+// SPDX-License-Identifier:     GPL-2.0+
+// (C) Copyright 2024 Rockchip Electronics Co., Ltd
+
+#include "rockchip-u-boot.dtsi"
diff --git a/arch/arm/include/asm/arch-rv1103b/boot0.h b/arch/arm/include/asm/arch-rv1103b/boot0.h
new file mode 100644
index 00000000000..2e78b074ade
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
index 1a2e7847c9e..1969c313f47 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -532,6 +532,18 @@ config ROCKCHIP_RK3588
 	  SD3.0/MMC4.5, USB OTG 3.0, Type-C, USB 2.0, PCIe 3.0, SATA 3, Ethernet,
 	  SDIO3.0 I2C, UART, SPI, GPIO and PWM.
 
+config ROCKCHIP_RV1103B
+	bool "Support Rockchip RV1103B"
+	select CPU_V7A
+	select SPL_ARMV7_SET_CORTEX_SMPEN
+	select SUPPORT_SPL
+	select SPL
+	imply ROCKCHIP_COMMON_BOARD
+	help
+	  The Rockchip RV1103B is an ARM-based SoC with a single Cortex-A7
+	  32-bit core which integrates NEON and FPU.
+	  It contains a built-in NPU for AI related applications.
+
 config ROCKCHIP_RV1108
 	bool "Support Rockchip RV1108"
 	select CPU_V7A
@@ -795,6 +807,7 @@ source "arch/arm/mach-rockchip/rk3528/Kconfig"
 source "arch/arm/mach-rockchip/rk3568/Kconfig"
 source "arch/arm/mach-rockchip/rk3576/Kconfig"
 source "arch/arm/mach-rockchip/rk3588/Kconfig"
+source "arch/arm/mach-rockchip/rv1103b/Kconfig"
 source "arch/arm/mach-rockchip/rv1108/Kconfig"
 source "arch/arm/mach-rockchip/rv1126/Kconfig"
 
diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
index d3bc0689f89..e09dc44a7ad 100644
--- a/arch/arm/mach-rockchip/Makefile
+++ b/arch/arm/mach-rockchip/Makefile
@@ -47,6 +47,7 @@ obj-$(CONFIG_ROCKCHIP_RK3528) += rk3528/
 obj-$(CONFIG_ROCKCHIP_RK3568) += rk3568/
 obj-$(CONFIG_ROCKCHIP_RK3576) += rk3576/
 obj-$(CONFIG_ROCKCHIP_RK3588) += rk3588/
+obj-$(CONFIG_ROCKCHIP_RV1103B) += rv1103b/
 obj-$(CONFIG_ROCKCHIP_RV1108) += rv1108/
 obj-$(CONFIG_ROCKCHIP_RV1126) += rv1126/
 
diff --git a/arch/arm/mach-rockchip/rv1103b/Kconfig b/arch/arm/mach-rockchip/rv1103b/Kconfig
new file mode 100644
index 00000000000..710a86aeb33
--- /dev/null
+++ b/arch/arm/mach-rockchip/rv1103b/Kconfig
@@ -0,0 +1,15 @@
+if ROCKCHIP_RV1103B
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
+endif
diff --git a/arch/arm/mach-rockchip/rv1103b/Makefile b/arch/arm/mach-rockchip/rv1103b/Makefile
new file mode 100644
index 00000000000..2f34853adac
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
index 00000000000..466ab0e8077
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
index 00000000000..2bcbb08537e
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
index 00000000000..a7ff1934f7d
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
index 00000000000..7c71b1092f3
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
+	{ .compatible = "rockchip,rv1103b-pmu-grf", .data = ROCKCHIP_SYSCON_PMUGRF },
+	{ }
+};
+
+U_BOOT_DRIVER(syscon_rv1103b) = {
+	.name = "rv1103b_syscon",
+	.id = UCLASS_SYSCON,
+	.of_match = rv1103b_syscon_ids,
+};
diff --git a/include/configs/rv1103b_common.h b/include/configs/rv1103b_common.h
new file mode 100644
index 00000000000..8e970d71051
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
2.43.0

