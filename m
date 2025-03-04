Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70458C282D2
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 16:38:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD4F481249;
	Tue,  4 Mar 2025 17:38:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B81AB80FB6; Tue,  4 Mar 2025 17:37:59 +0100 (CET)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id BE0E080BAA
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 17:37:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-CSE-ConnectionGUID: ofqgLGfzQZy7tZpD4BrKqw==
X-CSE-MsgGUID: zcaxyCrpSayyJiFwdXdP8A==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 05 Mar 2025 01:37:54 +0900
Received: from rz-ub2404.betafive.net (unknown [10.226.93.7])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4FC444024115;
 Wed,  5 Mar 2025 01:37:52 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	u-boot@lists.denx.de
Subject: [PATCH 2/5] regulator: rzg2l-usbphy: Add new driver
Date: Tue,  4 Mar 2025 16:37:32 +0000
Message-ID: <20250304163736.89326-3-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304163736.89326-1-paul.barker.ct@bp.renesas.com>
References: <20250304163736.89326-1-paul.barker.ct@bp.renesas.com>
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

Add a new regulator driver to control the USB VBUS supply on the Renesas
RZ/G2L and related SoCs.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/power/regulator/Kconfig               |  8 ++++
 drivers/power/regulator/Makefile              |  1 +
 .../power/regulator/rzg2l-usbphy-regulator.c  | 42 +++++++++++++++++++
 3 files changed, 51 insertions(+)
 create mode 100644 drivers/power/regulator/rzg2l-usbphy-regulator.c

diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
index 958f337c7e73..8f102a92c23b 100644
--- a/drivers/power/regulator/Kconfig
+++ b/drivers/power/regulator/Kconfig
@@ -478,3 +478,11 @@ config DM_REGULATOR_TPS65219
 	features for REGULATOR TPS65219 and the family of TPS65219 PMICs.
 	TPS65219 series of PMICs have 3 single phase BUCKs & 4 LDOs.
 	The driver implements get/set api for value and enable.
+
+config REGULATOR_RZG2L_USBPHY
+	bool "Enable driver for RZ/G2L USB PHY VBUS supply"
+	depends on DM_REGULATOR
+	help
+	  Enable this option to support controlling the VBUS supply in
+	  the USB PHY peripheral of the Renesas RZ/G2L SoC. This option
+	  is required in order to use the USB OTG port.
diff --git a/drivers/power/regulator/Makefile b/drivers/power/regulator/Makefile
index ca6c89d13b5c..4382d4b3ab9a 100644
--- a/drivers/power/regulator/Makefile
+++ b/drivers/power/regulator/Makefile
@@ -42,3 +42,4 @@ obj-$(CONFIG_DM_REGULATOR_TPS65941) += tps65941_regulator.o
 obj-$(CONFIG_DM_REGULATOR_SCMI) += scmi_regulator.o
 obj-$(CONFIG_$(XPL_)DM_REGULATOR_ANATOP) += anatop_regulator.o
 obj-$(CONFIG_DM_REGULATOR_TPS65219) += tps65219_regulator.o
+obj-$(CONFIG_REGULATOR_RZG2L_USBPHY) += rzg2l-usbphy-regulator.o
diff --git a/drivers/power/regulator/rzg2l-usbphy-regulator.c b/drivers/power/regulator/rzg2l-usbphy-regulator.c
new file mode 100644
index 000000000000..451f04c140e6
--- /dev/null
+++ b/drivers/power/regulator/rzg2l-usbphy-regulator.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Renesas Electronics Corporation
+ */
+
+#include <asm/io.h>
+#include <dm.h>
+#include <power/regulator.h>
+#include <renesas/rzg2l-usbphy.h>
+
+#define VBENCTL			0x03c
+#define VBENCTL_VBUS_SEL	BIT(0)
+
+static int rzg2l_usbphy_regulator_set_enable(struct udevice *dev, bool enable)
+{
+	struct rzg2l_usbphy_ctrl_priv *priv = dev_get_priv(dev->parent);
+
+	if (enable)
+		clrbits_le32(priv->regs + VBENCTL, VBENCTL_VBUS_SEL);
+	else
+		setbits_le32(priv->regs + VBENCTL, VBENCTL_VBUS_SEL);
+
+	return 0;
+}
+
+static int rzg2l_usbphy_regulator_get_enable(struct udevice *dev)
+{
+	struct rzg2l_usbphy_ctrl_priv *priv = dev_get_priv(dev->parent);
+
+	return !!readl(priv->regs + VBENCTL) & VBENCTL_VBUS_SEL;
+}
+
+static const struct dm_regulator_ops rzg2l_usbphy_regulator_ops = {
+	.get_enable = rzg2l_usbphy_regulator_get_enable,
+	.set_enable = rzg2l_usbphy_regulator_set_enable,
+};
+
+U_BOOT_DRIVER(rzg2l_usbphy_regulator) = {
+	.name = "rzg2l_usbphy_regulator",
+	.id = UCLASS_REGULATOR,
+	.ops = &rzg2l_usbphy_regulator_ops,
+};
-- 
2.43.0

