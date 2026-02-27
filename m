Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A238FEFB5D
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 15:23:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5E9983F14;
	Fri, 27 Feb 2026 16:23:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30D3883F0A; Fri, 27 Feb 2026 16:23:37 +0100 (CET)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C96983E76
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 16:23:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=duwe@lst.de
Received: by verein.lst.de (Postfix, from userid 2005)
 id 4A0BE68D07; Fri, 27 Feb 2026 16:23:34 +0100 (CET)
In-Reply-To: <20260227152046.42DE068B05@verein.lst.de>
References: <20260227152046.42DE068B05@verein.lst.de>
From: Torsten Duwe <duwe@lst.de>
Subject: [PATCH 4/9] pci: brcmstb: Add RPi5 reset facilities
To: Peter Robinson <pbrobinson@gmail.com>, Matthias Brugger <mbrugger@suse.com>
Cc: Tom Rini <trini@konsulko.com>,"Jan Čermák" <sairon@sairon.cz>,Andrea della Porta <andrea.porta@suse.com>,"Ivan T. Ivanov" <iivanov@suse.de>, Stanimir Varbanov <stanimir.varbanov@suse.com>, Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, Volodymyr Babchuk <volodymyr_babchuk@epam.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,Paul Barker <paul.barker.ct@bp.renesas.com>,Patrice Chotard <patrice.chotard@foss.st.com>,Christian Marangi <ansuelsmth@gmail.com>,Patrick Delaunay <patrick.delaunay@foss.st.com>,Huan Zhou <me@per1cycle.org>,Gabriel Fernandez <gabriel.fernandez@foss.st.com>,Kever Yang <kever.yang@rock-chips.com>,Jonas Karlman <jonas@kwiboo.se>,Joseph Chen <chenjh@rock-chips.com>,Elaine Zhang <zhangqing@rock-chips.com>, u-boot@lists.denx.de
Message-Id: <20260227152334.4A0BE68D07@verein.lst.de>
Date: Fri, 27 Feb 2026 16:23:34 +0100 (CET)
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

From: Torsten Duwe <duwe@suse.de>

A driver for Broadcom reset controllers ported from
linux/drivers/reset/reset-brcmstb.c to U-Boot.

Signed-off-by: Torsten Duwe <duwe@suse.de>
---
 configs/rpi_arm64_defconfig   |  1 +
 drivers/reset/Kconfig         |  7 +++
 drivers/reset/Makefile        |  1 +
 drivers/reset/reset-brcmstb.c | 97 +++++++++++++++++++++++++++++++++++
 4 files changed, 106 insertions(+)
 create mode 100644 drivers/reset/reset-brcmstb.c

diff --git a/configs/rpi_arm64_defconfig b/configs/rpi_arm64_defconfig
index 69e8e72c5d7..153d7ed301e 100644
--- a/configs/rpi_arm64_defconfig
+++ b/configs/rpi_arm64_defconfig
@@ -44,6 +44,7 @@ CONFIG_BCMGENET=y
 CONFIG_PCI_BRCMSTB=y
 CONFIG_PINCTRL=y
 # CONFIG_PINCTRL_GENERIC is not set
+CONFIG_RESET_BRCMSTB=y
 CONFIG_DM_RNG=y
 CONFIG_RNG_IPROC200=y
 # CONFIG_REQUIRE_SERIAL_CONSOLE is not set
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 2fd91d6299c..46ffc103320 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -64,6 +64,13 @@ config RESET_BCM6345
 	help
 	  Support reset controller on BCM6345.
 
+config RESET_BRCMSTB
+	bool "Generic Reset controller driver for Broadcom"
+	help
+	  This enables reset controller for Broadcom devices.
+	  If you wish to use reset resources managed by the Broadcom
+	  Reset Controller, say Y here. Otherwise, say N.
+
 config RESET_UNIPHIER
 	bool "Reset controller driver for UniPhier SoCs"
 	depends on ARCH_UNIPHIER
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index ee5b009d134..ebf3d7425a4 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_RESET_AIROHA) += reset-airoha.o
 obj-$(CONFIG_RESET_TI_SCI) += reset-ti-sci.o
 obj-$(CONFIG_RESET_HSDK) += reset-hsdk.o
 obj-$(CONFIG_RESET_BCM6345) += reset-bcm6345.o
+obj-$(CONFIG_RESET_BRCMSTB) += reset-brcmstb.o
 obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
 obj-$(CONFIG_RESET_AST2500) += reset-ast2500.o
 obj-$(CONFIG_RESET_AST2600) += reset-ast2600.o
diff --git a/drivers/reset/reset-brcmstb.c b/drivers/reset/reset-brcmstb.c
new file mode 100644
index 00000000000..7861f7c9baf
--- /dev/null
+++ b/drivers/reset/reset-brcmstb.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Broadcom STB generic reset controller
+ *
+ * Copyright (C) 2024 EPAM Systems
+ *
+ * Moved from linux kernel:
+ * Author: Florian Fainelli <f.fainelli@gmail.com>
+ * Copyright (C) 2018 Broadcom
+ */
+
+#include <asm/io.h>
+#include <dm.h>
+#include <errno.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <log.h>
+#include <malloc.h>
+#include <reset-uclass.h>
+
+struct brcmstb_reset {
+	void __iomem *base;
+};
+
+#define SW_INIT_SET 0x00
+#define SW_INIT_CLEAR 0x04
+#define SW_INIT_STATUS 0x08
+
+#define SW_INIT_BIT(id) BIT((id) & 0x1f)
+#define SW_INIT_BANK(id) ((id) >> 5)
+
+#define usleep_range(a, b) udelay((b))
+
+/* A full bank contains extra registers that we are not utilizing but still
+ * qualify as a single bank.
+ */
+#define SW_INIT_BANK_SIZE 0x18
+
+static int brcmstb_reset_assert(struct reset_ctl *rst)
+{
+	unsigned int off = SW_INIT_BANK(rst->id) * SW_INIT_BANK_SIZE;
+	struct brcmstb_reset *priv = dev_get_priv(rst->dev);
+
+	writel_relaxed(SW_INIT_BIT(rst->id), priv->base + off + SW_INIT_SET);
+	return 0;
+}
+
+static int brcmstb_reset_deassert(struct reset_ctl *rst)
+{
+	unsigned int off = SW_INIT_BANK(rst->id) * SW_INIT_BANK_SIZE;
+	struct brcmstb_reset *priv = dev_get_priv(rst->dev);
+
+	writel_relaxed(SW_INIT_BIT(rst->id), priv->base + off + SW_INIT_CLEAR);
+	/* Maximum reset delay after de-asserting a line and seeing block
+	 * operation is typically 14us for the worst case, build some slack
+	 * here.
+	 */
+	usleep_range(100, 200);
+	return 0;
+}
+
+static int brcmstb_reset_status(struct reset_ctl *rst)
+{
+	unsigned int off = SW_INIT_BANK(rst->id) * SW_INIT_BANK_SIZE;
+	struct brcmstb_reset *priv = dev_get_priv(rst->dev);
+
+	return readl_relaxed(priv->base + off + SW_INIT_STATUS) &
+			SW_INIT_BIT(rst->id);
+}
+
+struct reset_ops brcmstb_reset_reset_ops = {
+	.rst_assert = brcmstb_reset_assert,
+	.rst_deassert = brcmstb_reset_deassert,
+	.rst_status = brcmstb_reset_status};
+
+static int brcmstb_reset_probe(struct udevice *dev)
+{
+	struct brcmstb_reset *priv = dev_get_priv(dev);
+
+	priv->base = dev_remap_addr(dev);
+	if (!priv->base)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct udevice_id brcmstb_reset_ids[] = {
+	{.compatible = "brcm,brcmstb-reset"}, {/* sentinel */}};
+
+U_BOOT_DRIVER(brcmstb_reset) = {
+	.name = "brcmstb-reset",
+	.id = UCLASS_RESET,
+	.of_match = brcmstb_reset_ids,
+	.ops = &brcmstb_reset_reset_ops,
+	.probe = brcmstb_reset_probe,
+	.priv_auto = sizeof(struct brcmstb_reset),
+};
-- 
2.51.0

