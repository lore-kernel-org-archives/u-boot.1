Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AFEFC02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 01:47:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B386C80792;
	Fri, 17 Jan 2025 02:47:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1A0680312; Fri, 17 Jan 2025 02:47:14 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 7D2B880755
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 02:47:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 568CB2050;
 Thu, 16 Jan 2025 17:47:40 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 844863F673;
 Thu, 16 Jan 2025 17:47:10 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Tom Rini <trini@konsulko.com>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Cody Eksal <masterr3c0rd@epochal.quest>, Simon Glass <sjg@chromium.org>,
 linux-sunxi@lists.linux.dev, Parthiban <parthiban@linumiz.com>
Subject: [PATCH 4/8] clk: sunxi: Add support for the A100/A133 CCU
Date: Fri, 17 Jan 2025 01:45:33 +0000
Message-ID: <20250117014537.22513-5-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20250117014537.22513-1-andre.przywara@arm.com>
References: <20250117014537.22513-1-andre.przywara@arm.com>
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

The Allwinner A100 SoC has been around for a while, and has now seemingly
been replaced with its close sibling A133.

Add support for the CCU, as far as used by U-Boot proper. Linux has some
basic (clock and pinctrl) support for a while, so we can already use the
existing binding headers.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/mach-sunxi/Kconfig   |   3 +
 drivers/clk/sunxi/Kconfig     |   7 +++
 drivers/clk/sunxi/Makefile    |   1 +
 drivers/clk/sunxi/clk_a100.c  | 102 ++++++++++++++++++++++++++++++++++
 drivers/clk/sunxi/clk_sunxi.c |   5 ++
 5 files changed, 118 insertions(+)
 create mode 100644 drivers/clk/sunxi/clk_a100.c

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index ba1b1541437..78fd74f3f28 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -457,6 +457,9 @@ config MACH_SUN50I_H616
 	select SUN50I_GEN_H6
 	imply OF_UPSTREAM
 
+config MACH_SUN50I_A133
+	bool "sun50i (Allwinner A133)"
+
 endchoice
 
 # The sun8i SoCs share a lot, this helps to avoid a lot of "if A23 || A33"
diff --git a/drivers/clk/sunxi/Kconfig b/drivers/clk/sunxi/Kconfig
index 8bdc0944896..f44db76c182 100644
--- a/drivers/clk/sunxi/Kconfig
+++ b/drivers/clk/sunxi/Kconfig
@@ -122,4 +122,11 @@ config CLK_SUN50I_A64
 	  This enables common clock driver support for platforms based
 	  on Allwinner A64 SoC.
 
+config CLK_SUN50I_A100
+	bool "Clock driver for Allwinner A100/A133"
+	default MACH_SUN50I_A133
+	help
+	  This enables common clock driver support for platforms based
+	  on Allwinner A100/A133 SoCs.
+
 endif # CLK_SUNXI
diff --git a/drivers/clk/sunxi/Makefile b/drivers/clk/sunxi/Makefile
index 90a277489dc..7ff71c756e0 100644
--- a/drivers/clk/sunxi/Makefile
+++ b/drivers/clk/sunxi/Makefile
@@ -24,3 +24,4 @@ obj-$(CONFIG_CLK_SUN50I_H6) += clk_h6.o
 obj-$(CONFIG_CLK_SUN50I_H6_R) += clk_h6_r.o
 obj-$(CONFIG_CLK_SUN50I_H616) += clk_h616.o
 obj-$(CONFIG_CLK_SUN50I_A64) += clk_a64.o
+obj-$(CONFIG_CLK_SUN50I_A100) += clk_a100.o
diff --git a/drivers/clk/sunxi/clk_a100.c b/drivers/clk/sunxi/clk_a100.c
new file mode 100644
index 00000000000..b641feb8612
--- /dev/null
+++ b/drivers/clk/sunxi/clk_a100.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2023-2024 Arm Ltd.
+ */
+
+#include <clk/sunxi.h>
+#include <dt-bindings/clock/sun50i-a100-ccu.h>
+#include <dt-bindings/reset/sun50i-a100-ccu.h>
+#include <linux/bitops.h>
+
+static struct ccu_clk_gate a100_gates[] = {
+	[CLK_PLL_PERIPH0]	= GATE(0x020, BIT(31) | BIT(27)),
+
+	[CLK_APB1]		= GATE_DUMMY,
+
+	[CLK_DE]		= GATE(0x600, BIT(31)),
+	[CLK_BUS_DE]		= GATE(0x60c, BIT(0)),
+
+	[CLK_BUS_MMC0]		= GATE(0x84c, BIT(0)),
+	[CLK_BUS_MMC1]		= GATE(0x84c, BIT(1)),
+	[CLK_BUS_MMC2]		= GATE(0x84c, BIT(2)),
+
+	[CLK_BUS_UART0]		= GATE(0x90c, BIT(0)),
+	[CLK_BUS_UART1]		= GATE(0x90c, BIT(1)),
+	[CLK_BUS_UART2]		= GATE(0x90c, BIT(2)),
+	[CLK_BUS_UART3]		= GATE(0x90c, BIT(3)),
+	[CLK_BUS_UART4]		= GATE(0x90c, BIT(4)),
+
+	[CLK_BUS_I2C0]		= GATE(0x91c, BIT(0)),
+	[CLK_BUS_I2C1]		= GATE(0x91c, BIT(1)),
+	[CLK_BUS_I2C2]		= GATE(0x91c, BIT(2)),
+	[CLK_BUS_I2C3]		= GATE(0x91c, BIT(3)),
+
+	[CLK_SPI0]		= GATE(0x940, BIT(31)),
+	[CLK_SPI1]		= GATE(0x944, BIT(31)),
+	[CLK_SPI2]		= GATE(0x948, BIT(31)),
+
+	[CLK_BUS_SPI0]		= GATE(0x96c, BIT(0)),
+	[CLK_BUS_SPI1]		= GATE(0x96c, BIT(1)),
+	[CLK_BUS_SPI2]		= GATE(0x96c, BIT(2)),
+
+	[CLK_BUS_EMAC]		= GATE(0x97c, BIT(0)),
+
+	[CLK_USB_PHY0]		= GATE(0xa70, BIT(29)),
+	[CLK_USB_OHCI0]		= GATE(0xa70, BIT(31)),
+
+	[CLK_USB_PHY1]		= GATE(0xa74, BIT(29)),
+	[CLK_USB_OHCI1]		= GATE(0xa74, BIT(31)),
+
+	[CLK_BUS_OHCI0]		= GATE(0xa8c, BIT(0)),
+	[CLK_BUS_OHCI1]		= GATE(0xa8c, BIT(1)),
+	[CLK_BUS_EHCI0]		= GATE(0xa8c, BIT(4)),
+	[CLK_BUS_EHCI1]		= GATE(0xa8c, BIT(5)),
+	[CLK_BUS_OTG]		= GATE(0xa8c, BIT(8)),
+
+	[CLK_TCON_LCD]		= GATE(0xb60, BIT(31)),
+	[CLK_BUS_TCON_LCD]	= GATE(0xb7c, BIT(0)),
+};
+
+static struct ccu_reset a100_resets[] = {
+	[RST_BUS_DE]		= RESET(0x60c, BIT(16)),
+
+	[RST_BUS_MMC0]		= RESET(0x84c, BIT(16)),
+	[RST_BUS_MMC1]		= RESET(0x84c, BIT(17)),
+	[RST_BUS_MMC2]		= RESET(0x84c, BIT(18)),
+
+	[RST_BUS_UART0]		= RESET(0x90c, BIT(16)),
+	[RST_BUS_UART1]		= RESET(0x90c, BIT(17)),
+	[RST_BUS_UART2]		= RESET(0x90c, BIT(18)),
+	[RST_BUS_UART3]		= RESET(0x90c, BIT(19)),
+	[RST_BUS_UART4]		= RESET(0x90c, BIT(20)),
+
+	[RST_BUS_I2C0]		= RESET(0x91c, BIT(16)),
+	[RST_BUS_I2C1]		= RESET(0x91c, BIT(17)),
+	[RST_BUS_I2C2]		= RESET(0x91c, BIT(18)),
+	[RST_BUS_I2C3]		= RESET(0x91c, BIT(19)),
+
+	[RST_BUS_SPI0]		= RESET(0x96c, BIT(16)),
+	[RST_BUS_SPI1]		= RESET(0x96c, BIT(17)),
+	[RST_BUS_SPI2]		= RESET(0x96c, BIT(18)),
+
+	[RST_BUS_EMAC]		= RESET(0x97c, BIT(16)),
+
+	[RST_USB_PHY0]		= RESET(0xa70, BIT(30)),
+
+	[RST_USB_PHY1]		= RESET(0xa74, BIT(30)),
+
+	[RST_BUS_OHCI0]		= RESET(0xa8c, BIT(16)),
+	[RST_BUS_OHCI1]		= RESET(0xa8c, BIT(17)),
+	[RST_BUS_EHCI0]		= RESET(0xa8c, BIT(20)),
+	[RST_BUS_EHCI1]		= RESET(0xa8c, BIT(21)),
+	[RST_BUS_OTG]		= RESET(0xa8c, BIT(24)),
+
+	[RST_BUS_TCON_LCD]	= RESET(0xb7c, BIT(16)),
+};
+
+const struct ccu_desc a100_ccu_desc = {
+	.gates = a100_gates,
+	.resets = a100_resets,
+	.num_gates = ARRAY_SIZE(a100_gates),
+	.num_resets = ARRAY_SIZE(a100_resets),
+};
diff --git a/drivers/clk/sunxi/clk_sunxi.c b/drivers/clk/sunxi/clk_sunxi.c
index 2ef4f45dacf..e0765cbc6dc 100644
--- a/drivers/clk/sunxi/clk_sunxi.c
+++ b/drivers/clk/sunxi/clk_sunxi.c
@@ -122,6 +122,7 @@ extern const struct ccu_desc f1c100s_ccu_desc;
 extern const struct ccu_desc h3_ccu_desc;
 extern const struct ccu_desc h6_ccu_desc;
 extern const struct ccu_desc h616_ccu_desc;
+extern const struct ccu_desc a100_ccu_desc;
 extern const struct ccu_desc h6_r_ccu_desc;
 extern const struct ccu_desc r40_ccu_desc;
 extern const struct ccu_desc v3s_ccu_desc;
@@ -215,6 +216,10 @@ static const struct udevice_id sunxi_clk_ids[] = {
 	{ .compatible = "allwinner,sun50i-h616-r-ccu",
 	  .data = (ulong)&h6_r_ccu_desc },
 #endif
+#ifdef CONFIG_CLK_SUN50I_A100
+	{ .compatible = "allwinner,sun50i-a100-ccu",
+	  .data = (ulong)&a100_ccu_desc },
+#endif
 #ifdef CONFIG_CLK_SUNIV_F1C100S
 	{ .compatible = "allwinner,suniv-f1c100s-ccu",
 	  .data = (ulong)&f1c100s_ccu_desc },
-- 
2.46.2

