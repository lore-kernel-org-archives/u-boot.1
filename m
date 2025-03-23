Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 471BEC36005
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 11:38:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9644581F54;
	Sun, 23 Mar 2025 12:36:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8333981EE5; Sun, 23 Mar 2025 12:36:32 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 408C481EBB
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 12:36:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FF09339;
 Sun, 23 Mar 2025 04:36:36 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 801763F694;
 Sun, 23 Mar 2025 04:36:28 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Mikhail Kalashnikov <iuncuim@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 15/34] clk: sunxi: Add support for the A523 CCU
Date: Sun, 23 Mar 2025 11:35:25 +0000
Message-ID: <20250323113544.7933-16-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250323113544.7933-1-andre.przywara@arm.com>
References: <20250323113544.7933-1-andre.przywara@arm.com>
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

Add a clock driver for the main clock controller on the Allwinner A523
family of SoCs.
As usual, this just describes the clock gates and reset lines for the
few device that U-Boot cares about: USB, Ethernet, MMC, I2C, SPI.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/clk/sunxi/Kconfig     |  7 +++
 drivers/clk/sunxi/Makefile    |  1 +
 drivers/clk/sunxi/clk_a523.c  | 85 +++++++++++++++++++++++++++++++++++
 drivers/clk/sunxi/clk_sunxi.c |  5 +++
 4 files changed, 98 insertions(+)
 create mode 100644 drivers/clk/sunxi/clk_a523.c

diff --git a/drivers/clk/sunxi/Kconfig b/drivers/clk/sunxi/Kconfig
index f44db76c182..74e89b86301 100644
--- a/drivers/clk/sunxi/Kconfig
+++ b/drivers/clk/sunxi/Kconfig
@@ -129,4 +129,11 @@ config CLK_SUN50I_A100
 	  This enables common clock driver support for platforms based
 	  on Allwinner A100/A133 SoCs.
 
+config CLK_SUN55I_A523
+	bool "Clock driver for Allwinner A523/T527"
+	default MACH_SUN55I_A523
+	help
+	  This enables common clock driver support for platforms based
+	  on Allwinner A523/T527 SoC.
+
 endif # CLK_SUNXI
diff --git a/drivers/clk/sunxi/Makefile b/drivers/clk/sunxi/Makefile
index 7ff71c756e0..dd33eabe2ed 100644
--- a/drivers/clk/sunxi/Makefile
+++ b/drivers/clk/sunxi/Makefile
@@ -25,3 +25,4 @@ obj-$(CONFIG_CLK_SUN50I_H6_R) += clk_h6_r.o
 obj-$(CONFIG_CLK_SUN50I_H616) += clk_h616.o
 obj-$(CONFIG_CLK_SUN50I_A64) += clk_a64.o
 obj-$(CONFIG_CLK_SUN50I_A100) += clk_a100.o
+obj-$(CONFIG_CLK_SUN55I_A523) += clk_a523.o
diff --git a/drivers/clk/sunxi/clk_a523.c b/drivers/clk/sunxi/clk_a523.c
new file mode 100644
index 00000000000..1de95fbaf2f
--- /dev/null
+++ b/drivers/clk/sunxi/clk_a523.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2024 Arm Ltd.
+ */
+
+#include <clk-uclass.h>
+#include <dm.h>
+#include <errno.h>
+#include <clk/sunxi.h>
+#include <linux/bitops.h>
+
+#include <dt-bindings/clock/sun55i-a523-ccu.h>
+#include <dt-bindings/reset/sun55i-a523-ccu.h>
+
+static struct ccu_clk_gate a523_gates[] = {
+	[CLK_PLL_PERIPH0_200M]	= GATE_DUMMY,
+	[CLK_APB1]		= GATE_DUMMY,
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
+	[CLK_EMAC0_25M]		= GATE(0x970, BIT(30) | BIT(31)),
+	[CLK_EMAC1_25M]		= GATE(0x974, BIT(30) | BIT(31)),
+	[CLK_BUS_EMAC0]		= GATE(0x97c, BIT(0)),
+	[CLK_BUS_EMAC1]		= GATE(0x98c, BIT(0)),
+
+	[CLK_USB_OHCI0]		= GATE(0xa70, BIT(31)),
+	[CLK_USB_OHCI1]		= GATE(0xa74, BIT(31)),
+	[CLK_BUS_OHCI0]		= GATE(0xa8c, BIT(0)),
+	[CLK_BUS_OHCI1]		= GATE(0xa8c, BIT(1)),
+	[CLK_BUS_EHCI0]		= GATE(0xa8c, BIT(4)),
+	[CLK_BUS_EHCI1]		= GATE(0xa8c, BIT(5)),
+	[CLK_BUS_OTG]		= GATE(0xa8c, BIT(8)),
+};
+
+static struct ccu_reset a523_resets[] = {
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
+	[RST_BUS_EMAC0]		= RESET(0x97c, BIT(16)),
+	[RST_BUS_EMAC1]		= RESET(0x98c, BIT(16) | BIT(17)),
+
+	[RST_USB_PHY0]		= RESET(0xa70, BIT(30)),
+	[RST_USB_PHY1]		= RESET(0xa74, BIT(30)),
+	[RST_BUS_OHCI0]		= RESET(0xa8c, BIT(16)),
+	[RST_BUS_OHCI1]		= RESET(0xa8c, BIT(17)),
+	[RST_BUS_EHCI0]		= RESET(0xa8c, BIT(20)),
+	[RST_BUS_EHCI1]		= RESET(0xa8c, BIT(21)),
+	[RST_BUS_OTG]		= RESET(0xa8c, BIT(24)),
+};
+
+const struct ccu_desc a523_ccu_desc = {
+	.gates	= a523_gates,
+	.resets	= a523_resets,
+	.num_gates = ARRAY_SIZE(a523_gates),
+	.num_resets = ARRAY_SIZE(a523_resets),
+};
diff --git a/drivers/clk/sunxi/clk_sunxi.c b/drivers/clk/sunxi/clk_sunxi.c
index e0765cbc6dc..30baabaafcd 100644
--- a/drivers/clk/sunxi/clk_sunxi.c
+++ b/drivers/clk/sunxi/clk_sunxi.c
@@ -126,6 +126,7 @@ extern const struct ccu_desc a100_ccu_desc;
 extern const struct ccu_desc h6_r_ccu_desc;
 extern const struct ccu_desc r40_ccu_desc;
 extern const struct ccu_desc v3s_ccu_desc;
+extern const struct ccu_desc a523_ccu_desc;
 
 static const struct udevice_id sunxi_clk_ids[] = {
 #ifdef CONFIG_CLK_SUN4I_A10
@@ -223,6 +224,10 @@ static const struct udevice_id sunxi_clk_ids[] = {
 #ifdef CONFIG_CLK_SUNIV_F1C100S
 	{ .compatible = "allwinner,suniv-f1c100s-ccu",
 	  .data = (ulong)&f1c100s_ccu_desc },
+#endif
+#ifdef CONFIG_CLK_SUN55I_A523
+	{ .compatible = "allwinner,sun55i-a523-ccu",
+	  .data = (ulong)&a523_ccu_desc },
 #endif
 	{ }
 };
-- 
2.46.3

