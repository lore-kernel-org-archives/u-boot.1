Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A26AC28B2F
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 20:58:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB3D080F92;
	Tue, 11 Mar 2025 21:58:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB1FF81671; Tue, 11 Mar 2025 21:58:06 +0100 (CET)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id D04E580F92
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 21:58:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-CSE-ConnectionGUID: 0QNlww+mRXWYUaR8qysCaQ==
X-CSE-MsgGUID: eWtQd/npR/GZzENrXcuMkw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie5.idc.renesas.com with ESMTP; 12 Mar 2025 05:58:01 +0900
Received: from rz-ub2404.betafive.net (unknown [10.24.0.12])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id EB3B04038EF6;
 Wed, 12 Mar 2025 05:57:58 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	u-boot@lists.denx.de
Subject: [PATCH v2 1/5] reset: rzg2l-usbphy-ctrl: Add new driver
Date: Tue, 11 Mar 2025 20:57:43 +0000
Message-ID: <20250311205748.2492-2-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250311205748.2492-1-paul.barker.ct@bp.renesas.com>
References: <20250311205748.2492-1-paul.barker.ct@bp.renesas.com>
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

Add a new driver to control the USB 2.0 PHY reset controller on the
Renesas RZ/G2L and related SoCs.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/reset/Kconfig                   |   9 ++
 drivers/reset/Makefile                  |   1 +
 drivers/reset/reset-rzg2l-usbphy-ctrl.c | 113 ++++++++++++++++++++++++
 include/renesas/rzg2l-usbphy.h          |  17 ++++
 4 files changed, 140 insertions(+)
 create mode 100644 drivers/reset/reset-rzg2l-usbphy-ctrl.c
 create mode 100644 include/renesas/rzg2l-usbphy.h

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index fe5c1214f57a..80e83a40bdff 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -235,4 +235,13 @@ config RESET_AT91
 	  This enables the Reset Controller driver support for Microchip/Atmel
 	  SoCs. Mainly used to expose assert/deassert methods to other drivers
 	  that require it.
+
+config RESET_RZG2L_USBPHY_CTRL
+	bool "Enable support for Renesas RZ/G2L USB 2.0 PHY control"
+	depends on DM_RESET
+	help
+	  Enable support for controlling USB 2.0 PHY resets on the Renesas
+	  RZ/G2L SoC. This is required for USB 2.0 functionality to work on this
+	  SoC.
+
 endmenu
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index d99a78c9828b..9d438a755b30 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -33,3 +33,4 @@ obj-$(CONFIG_RESET_ZYNQMP) += reset-zynqmp.o
 obj-$(CONFIG_RESET_DRA7) += reset-dra7.o
 obj-$(CONFIG_RESET_AT91) += reset-at91.o
 obj-$(CONFIG_$(PHASE_)RESET_JH7110) += reset-jh7110.o
+obj-$(CONFIG_RESET_RZG2L_USBPHY_CTRL) += reset-rzg2l-usbphy-ctrl.o
diff --git a/drivers/reset/reset-rzg2l-usbphy-ctrl.c b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
new file mode 100644
index 000000000000..afd647e00b19
--- /dev/null
+++ b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Renesas Electronics Corporation
+ */
+
+#include <asm/io.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dm/lists.h>
+#include <renesas/rzg2l-usbphy.h>
+#include <reset-uclass.h>
+#include <reset.h>
+
+#define RESET			0x000
+
+#define RESET_SEL_PLLRESET	BIT(12)
+#define RESET_PLLRESET		BIT(8)
+
+#define RESET_SEL_P2RESET	BIT(5)
+#define RESET_SEL_P1RESET	BIT(4)
+#define RESET_PHYRST_2		BIT(1)
+#define RESET_PHYRST_1		BIT(0)
+
+#define PHY_RESET_MASK          (RESET_PHYRST_1 | RESET_PHYRST_2)
+
+#define NUM_PORTS		2
+
+static int rzg2l_usbphy_ctrl_assert(struct reset_ctl *reset_ctl)
+{
+	struct rzg2l_usbphy_ctrl_priv *priv = dev_get_priv(reset_ctl->dev);
+	u32 val;
+
+	val = readl(priv->regs + RESET);
+	val |= reset_ctl->id ? RESET_PHYRST_2 : RESET_PHYRST_1;
+
+	/* If both ports are in reset, we can also place the PLL into reset. */
+	if ((val & PHY_RESET_MASK) == PHY_RESET_MASK)
+		val |= RESET_PLLRESET;
+
+	writel(val, priv->regs + RESET);
+	return 0;
+}
+
+static int rzg2l_usbphy_ctrl_deassert(struct reset_ctl *reset_ctl)
+{
+	struct rzg2l_usbphy_ctrl_priv *priv = dev_get_priv(reset_ctl->dev);
+	u32 val = reset_ctl->id ? RESET_PHYRST_2 : RESET_PHYRST_1;
+
+	/* If either port is out of reset, the PLL must also be out of reset. */
+	val |= RESET_PLLRESET;
+
+	clrbits_le32(priv->regs + RESET, val);
+	return 0;
+}
+
+static int rzg2l_usbphy_ctrl_of_xlate(struct reset_ctl *reset_ctl,
+				      struct ofnode_phandle_args *args)
+{
+	if (args->args[0] >= NUM_PORTS)
+		return -EINVAL;
+
+	reset_ctl->id = args->args[0];
+	return 0;
+}
+
+struct reset_ops rzg2l_usbphy_ctrl_ops = {
+	.rst_assert = rzg2l_usbphy_ctrl_assert,
+	.rst_deassert = rzg2l_usbphy_ctrl_deassert,
+	.of_xlate = rzg2l_usbphy_ctrl_of_xlate,
+};
+
+static int rzg2l_usbphy_ctrl_probe(struct udevice *dev)
+{
+	struct rzg2l_usbphy_ctrl_priv *priv = dev_get_priv(dev);
+	struct reset_ctl rst;
+	int ret;
+
+	priv->regs = dev_read_addr(dev);
+
+	ret = reset_get_by_index(dev, 0, &rst);
+	if (ret < 0) {
+		dev_err(dev, "failed to get reset line: %d\n", ret);
+		return ret;
+	}
+
+	ret = reset_deassert(&rst);
+	if (ret < 0) {
+		dev_err(dev, "failed to de-assert reset line: %d\n", ret);
+		return ret;
+	}
+
+	/* put pll and phy into reset state */
+	setbits_le32(priv->regs + RESET,
+		     RESET_SEL_PLLRESET | RESET_PLLRESET |
+		     RESET_SEL_P1RESET | RESET_PHYRST_1 |
+		     RESET_SEL_P2RESET | RESET_PHYRST_2);
+
+	return 0;
+}
+
+static const struct udevice_id rzg2l_usbphy_ctrl_ids[] = {
+	{ .compatible = "renesas,rzg2l-usbphy-ctrl", },
+	{ /* sentinel */ }
+};
+
+U_BOOT_DRIVER(rzg2l_usbphy_ctrl) = {
+	.name           = "rzg2l_usbphy_ctrl",
+	.id             = UCLASS_RESET,
+	.of_match       = rzg2l_usbphy_ctrl_ids,
+	.probe          = rzg2l_usbphy_ctrl_probe,
+	.ops            = &rzg2l_usbphy_ctrl_ops,
+	.priv_auto      = sizeof(struct rzg2l_usbphy_ctrl_priv),
+};
diff --git a/include/renesas/rzg2l-usbphy.h b/include/renesas/rzg2l-usbphy.h
new file mode 100644
index 000000000000..1a46b585f170
--- /dev/null
+++ b/include/renesas/rzg2l-usbphy.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * RZ/G2L USB PHY common definitions
+ *
+ * Copyright (C) 2021-2023 Renesas Electronics Corp.
+ */
+
+#ifndef RENESAS_RZG2L_USBPHY_H
+#define RENESAS_RZG2L_USBPHY_H
+
+#include <fdtdec.h>
+
+struct rzg2l_usbphy_ctrl_priv {
+	fdt_addr_t regs;
+};
+
+#endif /* RENESAS_RZG2L_USBPHY_H */
-- 
2.43.0

