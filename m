Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B1D9C00A8F
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 13:27:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6DA787948;
	Mon, 23 Oct 2023 15:25:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E70DB87940; Mon, 23 Oct 2023 15:25:23 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 97C7C87911
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 15:25:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BE69C15;
 Mon, 23 Oct 2023 06:26:02 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.101.43])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A42983F762;
 Mon, 23 Oct 2023 06:25:19 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de, linux-sunxi@lists.linux.dev,
 Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Maxim Kiselev <bigunclemax@gmail.com>, Sam Edwards <cfsworks@gmail.com>,
 Okhunjon Sobirjonov <okhunjon72@gmail.com>
Subject: [PATCH v3 12/24] clk: sunxi: Add support for the D1 CCU
Date: Mon, 23 Oct 2023 14:24:37 +0100
Message-Id: <20231023132449.813863-13-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231023132449.813863-1-andre.przywara@arm.com>
References: <20231023132449.813863-1-andre.przywara@arm.com>
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

From: Samuel Holland <samuel@sholland.org>

Since the D1 CCU binding is defined, we can add support for its
gates/resets, following the pattern of the existing drivers.

Signed-off-by: Samuel Holland <samuel@sholland.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Sean Anderson <seanga2@gmail.com>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/clk/sunxi/Kconfig     |  6 +++
 drivers/clk/sunxi/Makefile    |  1 +
 drivers/clk/sunxi/clk_d1.c    | 84 +++++++++++++++++++++++++++++++++++
 drivers/clk/sunxi/clk_sunxi.c |  5 +++
 4 files changed, 96 insertions(+)
 create mode 100644 drivers/clk/sunxi/clk_d1.c

diff --git a/drivers/clk/sunxi/Kconfig b/drivers/clk/sunxi/Kconfig
index bf11fad6eef..f65e482ba4c 100644
--- a/drivers/clk/sunxi/Kconfig
+++ b/drivers/clk/sunxi/Kconfig
@@ -87,6 +87,12 @@ config CLK_SUN8I_H3
 	  This enables common clock driver support for platforms based
 	  on Allwinner H3/H5 SoC.
 
+config CLK_SUN20I_D1
+	bool "Clock driver for Allwinner D1"
+	help
+	  This enables common clock driver support for platforms based
+	  on Allwinner D1 SoC.
+
 config CLK_SUN50I_H6
 	bool "Clock driver for Allwinner H6"
 	default MACH_SUN50I_H6
diff --git a/drivers/clk/sunxi/Makefile b/drivers/clk/sunxi/Makefile
index 895da02ebea..90a277489dc 100644
--- a/drivers/clk/sunxi/Makefile
+++ b/drivers/clk/sunxi/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_CLK_SUN8I_R40) += clk_r40.o
 obj-$(CONFIG_CLK_SUN8I_V3S) += clk_v3s.o
 obj-$(CONFIG_CLK_SUN9I_A80) += clk_a80.o
 obj-$(CONFIG_CLK_SUN8I_H3) += clk_h3.o
+obj-$(CONFIG_CLK_SUN20I_D1) += clk_d1.o
 obj-$(CONFIG_CLK_SUN50I_H6) += clk_h6.o
 obj-$(CONFIG_CLK_SUN50I_H6_R) += clk_h6_r.o
 obj-$(CONFIG_CLK_SUN50I_H616) += clk_h616.o
diff --git a/drivers/clk/sunxi/clk_d1.c b/drivers/clk/sunxi/clk_d1.c
new file mode 100644
index 00000000000..9dae761de83
--- /dev/null
+++ b/drivers/clk/sunxi/clk_d1.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2021 Samuel Holland <samuel@sholland.org>
+ */
+
+#include <common.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <errno.h>
+#include <clk/sunxi.h>
+#include <dt-bindings/clock/sun20i-d1-ccu.h>
+#include <dt-bindings/reset/sun20i-d1-ccu.h>
+#include <linux/bitops.h>
+
+static struct ccu_clk_gate d1_gates[] = {
+	[CLK_APB0]		= GATE_DUMMY,
+
+	[CLK_BUS_MMC0]		= GATE(0x84c, BIT(0)),
+	[CLK_BUS_MMC1]		= GATE(0x84c, BIT(1)),
+	[CLK_BUS_MMC2]		= GATE(0x84c, BIT(2)),
+	[CLK_BUS_UART0]		= GATE(0x90c, BIT(0)),
+	[CLK_BUS_UART1]		= GATE(0x90c, BIT(1)),
+	[CLK_BUS_UART2]		= GATE(0x90c, BIT(2)),
+	[CLK_BUS_UART3]		= GATE(0x90c, BIT(3)),
+	[CLK_BUS_UART4]		= GATE(0x90c, BIT(4)),
+	[CLK_BUS_UART5]		= GATE(0x90c, BIT(5)),
+	[CLK_BUS_I2C0]		= GATE(0x91c, BIT(0)),
+	[CLK_BUS_I2C1]		= GATE(0x91c, BIT(1)),
+	[CLK_BUS_I2C2]		= GATE(0x91c, BIT(2)),
+	[CLK_BUS_I2C3]		= GATE(0x91c, BIT(3)),
+	[CLK_SPI0]		= GATE(0x940, BIT(31)),
+	[CLK_SPI1]		= GATE(0x944, BIT(31)),
+	[CLK_BUS_SPI0]		= GATE(0x96c, BIT(0)),
+	[CLK_BUS_SPI1]		= GATE(0x96c, BIT(1)),
+
+	[CLK_BUS_EMAC]		= GATE(0x97c, BIT(0)),
+
+	[CLK_USB_OHCI0]		= GATE(0xa70, BIT(31)),
+	[CLK_USB_OHCI1]		= GATE(0xa74, BIT(31)),
+	[CLK_BUS_OHCI0]		= GATE(0xa8c, BIT(0)),
+	[CLK_BUS_OHCI1]		= GATE(0xa8c, BIT(1)),
+	[CLK_BUS_EHCI0]		= GATE(0xa8c, BIT(4)),
+	[CLK_BUS_EHCI1]		= GATE(0xa8c, BIT(5)),
+	[CLK_BUS_OTG]		= GATE(0xa8c, BIT(8)),
+	[CLK_BUS_LRADC]		= GATE(0xa9c, BIT(0)),
+
+	[CLK_RISCV]		= GATE(0xd04, BIT(31)),
+};
+
+static struct ccu_reset d1_resets[] = {
+	[RST_BUS_MMC0]		= RESET(0x84c, BIT(16)),
+	[RST_BUS_MMC1]		= RESET(0x84c, BIT(17)),
+	[RST_BUS_MMC2]		= RESET(0x84c, BIT(18)),
+	[RST_BUS_UART0]		= RESET(0x90c, BIT(16)),
+	[RST_BUS_UART1]		= RESET(0x90c, BIT(17)),
+	[RST_BUS_UART2]		= RESET(0x90c, BIT(18)),
+	[RST_BUS_UART3]		= RESET(0x90c, BIT(19)),
+	[RST_BUS_UART4]		= RESET(0x90c, BIT(20)),
+	[RST_BUS_UART5]		= RESET(0x90c, BIT(21)),
+	[RST_BUS_I2C0]		= RESET(0x91c, BIT(16)),
+	[RST_BUS_I2C1]		= RESET(0x91c, BIT(17)),
+	[RST_BUS_I2C2]		= RESET(0x91c, BIT(18)),
+	[RST_BUS_I2C3]		= RESET(0x91c, BIT(19)),
+	[RST_BUS_SPI0]		= RESET(0x96c, BIT(16)),
+	[RST_BUS_SPI1]		= RESET(0x96c, BIT(17)),
+
+	[RST_BUS_EMAC]		= RESET(0x97c, BIT(16)),
+
+	[RST_USB_PHY0]		= RESET(0xa70, BIT(30)),
+	[RST_USB_PHY1]		= RESET(0xa74, BIT(30)),
+	[RST_BUS_OHCI0]		= RESET(0xa8c, BIT(16)),
+	[RST_BUS_OHCI1]		= RESET(0xa8c, BIT(17)),
+	[RST_BUS_EHCI0]		= RESET(0xa8c, BIT(20)),
+	[RST_BUS_EHCI1]		= RESET(0xa8c, BIT(21)),
+	[RST_BUS_OTG]		= RESET(0xa8c, BIT(24)),
+	[RST_BUS_LRADC]		= RESET(0xa9c, BIT(16)),
+};
+
+const struct ccu_desc d1_ccu_desc = {
+	.gates	= d1_gates,
+	.resets	= d1_resets,
+	.num_gates = ARRAY_SIZE(d1_gates),
+	.num_resets = ARRAY_SIZE(d1_resets),
+};
diff --git a/drivers/clk/sunxi/clk_sunxi.c b/drivers/clk/sunxi/clk_sunxi.c
index ec02a2d0370..1782cffc404 100644
--- a/drivers/clk/sunxi/clk_sunxi.c
+++ b/drivers/clk/sunxi/clk_sunxi.c
@@ -118,6 +118,7 @@ extern const struct ccu_desc a64_ccu_desc;
 extern const struct ccu_desc a80_ccu_desc;
 extern const struct ccu_desc a80_mmc_clk_desc;
 extern const struct ccu_desc a83t_ccu_desc;
+extern const struct ccu_desc d1_ccu_desc;
 extern const struct ccu_desc f1c100s_ccu_desc;
 extern const struct ccu_desc h3_ccu_desc;
 extern const struct ccu_desc h6_ccu_desc;
@@ -195,6 +196,10 @@ static const struct udevice_id sunxi_clk_ids[] = {
 	{ .compatible = "allwinner,sun50i-h5-ccu",
 	  .data = (ulong)&h3_ccu_desc },
 #endif
+#ifdef CONFIG_CLK_SUN20I_D1
+	{ .compatible = "allwinner,sun20i-d1-ccu",
+	  .data = (ulong)&d1_ccu_desc },
+#endif
 #ifdef CONFIG_CLK_SUN50I_H6
 	{ .compatible = "allwinner,sun50i-h6-ccu",
 	  .data = (ulong)&h6_ccu_desc },
-- 
2.25.1

