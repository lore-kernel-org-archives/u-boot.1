Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D5F2FEFB56
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 15:24:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 327F183E8E;
	Fri, 27 Feb 2026 16:23:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B384283F20; Fri, 27 Feb 2026 16:23:39 +0100 (CET)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 865C483E76
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 16:23:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=duwe@lst.de
Received: by verein.lst.de (Postfix, from userid 2005)
 id C7C2E68D0A; Fri, 27 Feb 2026 16:23:36 +0100 (CET)
In-Reply-To: <20260227152046.42DE068B05@verein.lst.de>
References: <20260227152046.42DE068B05@verein.lst.de>
From: Torsten Duwe <duwe@lst.de>
Subject: [PATCH 5/9] pci: brcmstb: Add RPi5 rescal reset facilities
To: Peter Robinson <pbrobinson@gmail.com>, Matthias Brugger <mbrugger@suse.com>
Cc: Tom Rini <trini@konsulko.com>,"Jan Čermák" <sairon@sairon.cz>,Andrea della Porta <andrea.porta@suse.com>,"Ivan T. Ivanov" <iivanov@suse.de>, Stanimir Varbanov <stanimir.varbanov@suse.com>, Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, Volodymyr Babchuk <volodymyr_babchuk@epam.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,Paul Barker <paul.barker.ct@bp.renesas.com>,Patrice Chotard <patrice.chotard@foss.st.com>,Christian Marangi <ansuelsmth@gmail.com>,Patrick Delaunay <patrick.delaunay@foss.st.com>,Huan Zhou <me@per1cycle.org>,Gabriel Fernandez <gabriel.fernandez@foss.st.com>,Kever Yang <kever.yang@rock-chips.com>,Jonas Karlman <jonas@kwiboo.se>,Joseph Chen <chenjh@rock-chips.com>,Elaine Zhang <zhangqing@rock-chips.com>, u-boot@lists.denx.de
Message-Id: <20260227152336.C7C2E68D0A@verein.lst.de>
Date: Fri, 27 Feb 2026 16:23:36 +0100 (CET)
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

A driver for Broadcom rescal reset controllers ported from
linux/drivers/reset/reset-brcmstb-rescal.c to U-Boot.

Signed-off-by: Torsten Duwe <duwe@suse.de>
---
 configs/rpi_arm64_defconfig          |   1 +
 drivers/reset/Kconfig                |   7 ++
 drivers/reset/Makefile               |   1 +
 drivers/reset/reset-brcmstb-rescal.c | 103 +++++++++++++++++++++++++++
 4 files changed, 112 insertions(+)
 create mode 100644 drivers/reset/reset-brcmstb-rescal.c

diff --git a/configs/rpi_arm64_defconfig b/configs/rpi_arm64_defconfig
index 153d7ed301e..38af5029403 100644
--- a/configs/rpi_arm64_defconfig
+++ b/configs/rpi_arm64_defconfig
@@ -45,6 +45,7 @@ CONFIG_PCI_BRCMSTB=y
 CONFIG_PINCTRL=y
 # CONFIG_PINCTRL_GENERIC is not set
 CONFIG_RESET_BRCMSTB=y
+CONFIG_RESET_BRCMSTB_RESCAL=y
 CONFIG_DM_RNG=y
 CONFIG_RNG_IPROC200=y
 # CONFIG_REQUIRE_SERIAL_CONSOLE is not set
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 46ffc103320..b7d2d4b18d5 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -71,6 +71,13 @@ config RESET_BRCMSTB
 	  If you wish to use reset resources managed by the Broadcom
 	  Reset Controller, say Y here. Otherwise, say N.
 
+config RESET_BRCMSTB_RESCAL
+	bool "Generic Rescal Reset controller driver for Broadcom"
+	help
+	  Support rescal reset controller on Broadcom.
+	  If you wish to use reset resources managed by the Broadcom
+	  Reset Controller, say Y here. Otherwise, say N.
+
 config RESET_UNIPHIER
 	bool "Reset controller driver for UniPhier SoCs"
 	depends on ARCH_UNIPHIER
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index ebf3d7425a4..c7a9da3268d 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_RESET_TI_SCI) += reset-ti-sci.o
 obj-$(CONFIG_RESET_HSDK) += reset-hsdk.o
 obj-$(CONFIG_RESET_BCM6345) += reset-bcm6345.o
 obj-$(CONFIG_RESET_BRCMSTB) += reset-brcmstb.o
+obj-$(CONFIG_RESET_BRCMSTB_RESCAL) += reset-brcmstb-rescal.o
 obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
 obj-$(CONFIG_RESET_AST2500) += reset-ast2500.o
 obj-$(CONFIG_RESET_AST2600) += reset-ast2600.o
diff --git a/drivers/reset/reset-brcmstb-rescal.c b/drivers/reset/reset-brcmstb-rescal.c
new file mode 100644
index 00000000000..fc8fcfa8b3f
--- /dev/null
+++ b/drivers/reset/reset-brcmstb-rescal.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Broadcom STB generic reset controller
+ *
+ * Copyright (C) 2024 EPAM Systems
+ * Moved from linux kernel:
+ * Copyright (C) 2018-2020 Broadcom
+ */
+
+#include <asm/io.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <errno.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/iopoll.h>
+#include <log.h>
+#include <malloc.h>
+#include <reset-uclass.h>
+
+#define BRCM_RESCAL_START 0x0
+#define BRCM_RESCAL_START_BIT BIT(0)
+#define BRCM_RESCAL_CTRL 0x4
+#define BRCM_RESCAL_STATUS 0x8
+#define BRCM_RESCAL_STATUS_BIT BIT(0)
+
+struct brcm_rescal_reset {
+	void __iomem *base;
+};
+
+/* Also doubles a deassert */
+static int brcm_rescal_reset_set(struct reset_ctl *rst)
+{
+	struct brcm_rescal_reset *data = dev_get_priv(rst->dev);
+	void __iomem *base = data->base;
+	u32 reg;
+	int ret;
+
+	reg = readl(base + BRCM_RESCAL_START);
+	writel(reg | BRCM_RESCAL_START_BIT, base + BRCM_RESCAL_START);
+	reg = readl(base + BRCM_RESCAL_START);
+	if (!(reg & BRCM_RESCAL_START_BIT)) {
+		dev_err(rst->dev, "failed to start SATA/PCIe rescal\n");
+		return -EIO;
+	}
+
+	ret = readl_poll_timeout(base + BRCM_RESCAL_STATUS, reg,
+				 (reg & BRCM_RESCAL_STATUS_BIT), 100);
+	if (ret) {
+		dev_err(rst->dev, "time out on SATA/PCIe rescal\n");
+		return ret;
+	}
+
+	reg = readl(base + BRCM_RESCAL_START);
+	writel(reg & ~BRCM_RESCAL_START_BIT, base + BRCM_RESCAL_START);
+
+	dev_dbg(rst->dev, "SATA/PCIe rescal success\n");
+	return 0;
+}
+
+/* A dummy function - deassert/reset does all the work */
+static int brcm_rescal_reset_assert(struct reset_ctl *rst)
+{
+	return 0;
+}
+
+static int brcm_rescal_reset_xlate(struct reset_ctl *reset_ctl,
+				   struct ofnode_phandle_args *args)
+{
+	/* This is needed if #reset-cells == 0. */
+	return 0;
+}
+
+static const struct reset_ops brcm_rescal_reset_ops = {
+	.rst_deassert = brcm_rescal_reset_set,
+	.rst_assert = brcm_rescal_reset_assert,
+	.of_xlate = brcm_rescal_reset_xlate,
+};
+
+static int brcm_rescal_reset_probe(struct udevice *dev)
+{
+	struct brcm_rescal_reset *data = dev_get_priv(dev);
+
+	data->base = dev_remap_addr(dev);
+	if (!data->base)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct udevice_id brcm_rescal_reset_of_match[] = {
+	{.compatible = "brcm,bcm7216-pcie-sata-rescal"},
+	{},
+};
+
+U_BOOT_DRIVER(brcmstb_reset_rescal) = {
+	.name = "brcmstb-reset-rescal",
+	.id = UCLASS_RESET,
+	.of_match = brcm_rescal_reset_of_match,
+	.ops = &brcm_rescal_reset_ops,
+	.probe = brcm_rescal_reset_probe,
+	.priv_auto = sizeof(struct brcm_rescal_reset),
+};
-- 
2.51.0

