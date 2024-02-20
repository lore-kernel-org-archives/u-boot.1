Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3ED8C48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 13:37:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0933E87FAA;
	Tue, 20 Feb 2024 14:37:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ivtJFDOr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0ADB87FAE; Tue, 20 Feb 2024 14:37:52 +0100 (CET)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11FB387DF9
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 14:37:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-59f7d59d3f1so2704157eaf.1
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 05:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708436258; x=1709041058; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E7He5t8o+OE5Q2mTt9Alibzs2jR8hytRJOgaxlXwPzU=;
 b=ivtJFDOrfih9U3bsYQ8pe+hhn8vRDcMrJDD1wVDlVLrSswKiNK8TJQlkwMhYgwDp2p
 Bbwwq+szwb5Q3sjzxdYQN0e8mRo6c6bebxSZnVX15WIUUapcYaNSZDNmYGYBtabttJbp
 qw+pTaDj2T9zQHiwEtNmGFX9exn+DEoiV9YAe9vgv+g2gEyuMwniY2hAtHkV/feWCR80
 VAHgLS1ICdYesRc8svYyyW8lT3sWkHz+5H12qq7laqLe4zLO/DfJYUPWJeEOHzLSAn19
 SOitzZ9SUdB5jd+DNj+EtA4K9DRj97j5mENUeZedu2UxBwkECOkA7hcG86vcryswCFly
 tUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708436258; x=1709041058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E7He5t8o+OE5Q2mTt9Alibzs2jR8hytRJOgaxlXwPzU=;
 b=bkmLkaPAFiHIkPeJpSaKipPicYQTgbC8AEjDqIz/atHjt97MjvQ9F/tN05QeDq77DI
 fKPn7UTu7ZUjJ1Pab8p7GUN/6pNNjLE1Y+HjZ/cFxhwdvtd6HzPrPxAk35nCyG6/I4nL
 2sH+NGI7iDy1wTPXDMRHCMiU3tmsD5HMAjvDW0zFDZzCJ77XfdgWzmV5pw1XhJm8byJU
 Sfm1xp/Dj7jtkDM4kChiPievXGc2AxXJ4su3TvpoCv5d1bC77+5gApnyWhD16CjR6CRK
 r9DysdxBjrTYLtcxl2WcZbWgY7/ISBckPjOppMfArFkvkaIT2GJRwGPBJelUxvr1jM3y
 KrGw==
X-Gm-Message-State: AOJu0YxArmZkrF3bmTXvi4XgfEVzwc1iWPNS9gsSW5dE1iuIZLH9xRvC
 X/d1AMvGj5/1go2lN9z+vY4FZf55bEi9+Vah+/34p4+mJkFlYCnuvRQqLo1cXTQ7CRIrYd1dev+
 z
X-Google-Smtp-Source: AGHT+IEHMn4Mh0gOdwiCurGBWBtHBKFjCQb6l2sajvhmV3BdrWoLkYCjwRGdHzvHc8RTJDay8KGx6g==
X-Received: by 2002:a05:6a00:180d:b0:6e0:a559:d667 with SMTP id
 y13-20020a056a00180d00b006e0a559d667mr17559026pfa.27.1708434704641; 
 Tue, 20 Feb 2024 05:11:44 -0800 (PST)
Received: from sumit-X1.. ([223.178.209.148]) by smtp.gmail.com with ESMTPSA id
 y12-20020aa79e0c000000b006e3e72a4f87sm5195902pfq.0.2024.02.20.05.11.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 05:11:44 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: marcel.ziswiler@toradex.com, trini@konsulko.com, lukma@denx.de,
 seanga2@gmail.com, jh80.chung@samsung.com, festevam@denx.de,
 andrejs.cainikovs@toradex.com, sjg@chromium.org, peng.fan@nxp.com,
 aford173@gmail.com, marex@denx.de, ilias.apalodimas@linaro.org,
 sahaj.sarup@linaro.org, fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 6/7] pci: Add DW PCIe controller support for iMX8MP SoC
Date: Tue, 20 Feb 2024 18:40:55 +0530
Message-Id: <20240220131056.2962331-7-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220131056.2962331-1-sumit.garg@linaro.org>
References: <20240220131056.2962331-1-sumit.garg@linaro.org>
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

pcie_imx doesn't seem to share any useful code for iMX8 SoC and it is
tied to quite old port of pcie_designware driver from Linux which
suffices only iMX6 specific needs.

But currently we have the common DWC specific bits which alligns pretty
well with DW PCIe controller on iMX8MP SoC. So lets reuse those common
bits instead as a new driver for iMX8 SoCs. It should be fairly easy to
add support for other iMX8 variants to this driver.

iMX8MP SoC also comes up with standalone PCIe PHY support, so hence we
can reuse the generic PHY infrastructure to power on PCIe PHY.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/pci/Kconfig        |   8 +
 drivers/pci/Makefile       |   1 +
 drivers/pci/pcie_dw_imx8.c | 348 +++++++++++++++++++++++++++++++++++++
 3 files changed, 357 insertions(+)
 create mode 100644 drivers/pci/pcie_dw_imx8.c

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 463ec47eb92..b7c7922b091 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -413,4 +413,12 @@ config PCIE_STARFIVE_JH7110
 	  Say Y here if you want to enable PLDA XpressRich PCIe controller
 	  support on StarFive JH7110 SoC.
 
+config PCIE_DW_IMX8
+	bool "i.MX8 PCIe support"
+	depends on ARCH_IMX8M
+	select PCIE_DW_COMMON
+	help
+	  Say Y here if you want to enable DW PCIe controller support on
+	  iMX8 SoCs.
+
 endif
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 72ef8b4bc77..cddbb902095 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -53,3 +53,4 @@ obj-$(CONFIG_PCIE_UNIPHIER) += pcie_uniphier.o
 obj-$(CONFIG_PCIE_XILINX_NWL) += pcie-xilinx-nwl.o
 obj-$(CONFIG_PCIE_PLDA_COMMON) += pcie_plda_common.o
 obj-$(CONFIG_PCIE_STARFIVE_JH7110) += pcie_starfive_jh7110.o
+obj-$(CONFIG_PCIE_DW_IMX8) += pcie_dw_imx8.o
diff --git a/drivers/pci/pcie_dw_imx8.c b/drivers/pci/pcie_dw_imx8.c
new file mode 100644
index 00000000000..b9921644765
--- /dev/null
+++ b/drivers/pci/pcie_dw_imx8.c
@@ -0,0 +1,348 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Linaro Ltd.
+ *
+ * Author: Sumit Garg <sumit.garg@linaro.org>
+ */
+
+#include <asm/io.h>
+#include <asm-generic/gpio.h>
+#include <clk.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <generic-phy.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <log.h>
+#include <pci.h>
+#include <regmap.h>
+#include <reset.h>
+#include <syscon.h>
+#include <time.h>
+
+#include "pcie_dw_common.h"
+
+#define PCIE_LINK_CAPABILITY		0x7c
+#define TARGET_LINK_SPEED_MASK		0xf
+#define LINK_SPEED_GEN_1		0x1
+#define LINK_SPEED_GEN_2		0x2
+#define LINK_SPEED_GEN_3		0x3
+
+#define PCIE_MISC_CONTROL_1_OFF		0x8bc
+#define PCIE_DBI_RO_WR_EN		BIT(0)
+
+#define PCIE_PORT_DEBUG0			0x728
+#define PCIE_PORT_DEBUG1			0x72c
+#define PCIE_PORT_DEBUG1_LINK_UP		BIT(4)
+#define PCIE_PORT_DEBUG1_LINK_IN_TRAINING	BIT(29)
+
+#define PCIE_LINK_UP_TIMEOUT_MS		100
+
+#define IOMUXC_GPR14_OFFSET			0x38
+#define IMX8M_GPR_PCIE_CLK_REQ_OVERRIDE_EN	BIT(10)
+#define IMX8M_GPR_PCIE_CLK_REQ_OVERRIDE		BIT(11)
+
+struct pcie_dw_imx8 {
+	/* Must be first member of the struct */
+	struct pcie_dw			dw;
+	struct regmap			*iomuxc_gpr;
+	struct clk			pcie;
+	struct clk			pcie_bus;
+	struct clk			pcie_aux;
+	struct gpio_desc		reset_gpio;
+	struct reset_ctl		apps_reset;
+	struct phy			phy;
+};
+
+static void pcie_dw_configure(struct pcie_dw_imx8 *priv, u32 cap_speed)
+{
+	u32 val;
+
+	dw_pcie_dbi_write_enable(&priv->dw, true);
+
+	val = readl(priv->dw.dbi_base + PCIE_LINK_CAPABILITY);
+	val &= ~TARGET_LINK_SPEED_MASK;
+	val |= cap_speed;
+	writel(val, priv->dw.dbi_base + PCIE_LINK_CAPABILITY);
+
+	dw_pcie_dbi_write_enable(&priv->dw, false);
+}
+
+static void imx8_pcie_ltssm_enable(struct pcie_dw_imx8 *priv)
+{
+	reset_deassert(&priv->apps_reset);
+}
+
+static void imx8_pcie_ltssm_disable(struct pcie_dw_imx8 *priv)
+{
+	reset_assert(&priv->apps_reset);
+}
+
+static int is_link_up(struct pcie_dw_imx8 *priv)
+{
+	u32 val;
+
+	val = readl(priv->dw.dbi_base + PCIE_PORT_DEBUG1);
+
+	return ((val & PCIE_PORT_DEBUG1_LINK_UP) &&
+		(!(val & PCIE_PORT_DEBUG1_LINK_IN_TRAINING)));
+}
+
+static int wait_link_up(struct pcie_dw_imx8 *priv)
+{
+	unsigned long timeout;
+
+	timeout = get_timer(0) + PCIE_LINK_UP_TIMEOUT_MS;
+	while (!is_link_up(priv)) {
+		if (get_timer(0) > timeout)
+			return 0;
+		mdelay(10);
+	};
+
+	return 1;
+}
+
+static int pcie_link_up(struct pcie_dw_imx8 *priv, u32 cap_speed)
+{
+	if (is_link_up(priv)) {
+		printf("PCI Link already up before configuration!\n");
+		return 1;
+	}
+
+	/* DW pre link configurations */
+	pcie_dw_configure(priv, cap_speed);
+
+	/* Initiate link training */
+	imx8_pcie_ltssm_enable(priv);
+
+	/* Check that link was established */
+	if (!wait_link_up(priv)) {
+		imx8_pcie_ltssm_disable(priv);
+		return 0;
+	}
+
+	return 1;
+}
+
+static int imx8_pcie_assert_core_reset(struct pcie_dw_imx8 *priv)
+{
+	if (dm_gpio_is_valid(&priv->reset_gpio)) {
+		dm_gpio_set_value(&priv->reset_gpio, 1);
+		mdelay(20);
+	}
+
+	return reset_assert(&priv->apps_reset);
+}
+
+static int imx8_pcie_clk_enable(struct pcie_dw_imx8 *priv)
+{
+	int ret;
+
+	ret = clk_enable(&priv->pcie);
+	if (ret) {
+		printf("unable to enable pcie clock\n");
+		return ret;
+	}
+
+	ret = clk_enable(&priv->pcie_bus);
+	if (ret) {
+		printf("unable to enable pcie_bus clock\n");
+		goto err_pcie;
+	}
+
+	ret = clk_enable(&priv->pcie_aux);
+	if (ret) {
+		printf("unable to enable pcie_aux clock\n");
+		goto err_pcie_bus;
+	}
+
+	/*
+	 * Set the over ride low and enabled make sure that
+	 * REF_CLK is turned on.
+	 */
+	regmap_update_bits(priv->iomuxc_gpr, IOMUXC_GPR14_OFFSET,
+			   IMX8M_GPR_PCIE_CLK_REQ_OVERRIDE, 0);
+	regmap_update_bits(priv->iomuxc_gpr, IOMUXC_GPR14_OFFSET,
+			   IMX8M_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
+			   IMX8M_GPR_PCIE_CLK_REQ_OVERRIDE_EN);
+
+	/* allow the clocks to stabilize */
+	udelay(500);
+
+	return 0;
+
+err_pcie_bus:
+	clk_disable(&priv->pcie_bus);
+err_pcie:
+	clk_disable(&priv->pcie);
+
+	return ret;
+}
+
+static int imx8_pcie_deassert_core_reset(struct pcie_dw_imx8 *priv)
+{
+	if (dm_gpio_is_valid(&priv->reset_gpio)) {
+		mdelay(100);
+		dm_gpio_set_value(&priv->reset_gpio, 0);
+		/* Wait for 100ms after PERST# deassertion (PCIe r5.0, 6.6.1) */
+		mdelay(100);
+	}
+
+	return 0;
+}
+
+static int pcie_dw_imx8_probe(struct udevice *dev)
+{
+	struct pcie_dw_imx8 *priv = dev_get_priv(dev);
+	struct udevice *ctlr = pci_get_controller(dev);
+	struct pci_controller *hose = dev_get_uclass_priv(ctlr);
+	int ret;
+
+	ret = imx8_pcie_assert_core_reset(priv);
+	if (ret) {
+		dev_err(dev, "failed to assert core reset\n");
+		return ret;
+	}
+
+	ret = imx8_pcie_clk_enable(priv);
+	if (ret) {
+		dev_err(dev, "failed to enable clocks\n");
+		return ret;
+	}
+
+	generic_phy_init(&priv->phy);
+	generic_phy_power_on(&priv->phy);
+
+	ret = imx8_pcie_deassert_core_reset(priv);
+	if (ret) {
+		dev_err(dev, "failed to assert core reset\n");
+		return ret;
+	}
+
+	priv->dw.first_busno = dev_seq(dev);
+	priv->dw.dev = dev;
+
+	pcie_dw_setup_host(&priv->dw);
+
+	if (!pcie_link_up(priv, LINK_SPEED_GEN_1)) {
+		printf("PCIE-%d: Link down\n", dev_seq(dev));
+		return -ENODEV;
+	}
+
+	printf("PCIE-%d: Link up (Gen%d-x%d, Bus%d)\n", dev_seq(dev),
+	       pcie_dw_get_link_speed(&priv->dw),
+	       pcie_dw_get_link_width(&priv->dw),
+	       hose->first_busno);
+
+	pcie_dw_prog_outbound_atu_unroll(&priv->dw, PCIE_ATU_REGION_INDEX0,
+					 PCIE_ATU_TYPE_MEM,
+					 priv->dw.mem.phys_start,
+					 priv->dw.mem.bus_start, priv->dw.mem.size);
+
+	return 0;
+}
+
+static int pcie_dw_imx8_remove(struct udevice *dev)
+{
+	struct pcie_dw_imx8 *priv = dev_get_priv(dev);
+
+	imx8_pcie_assert_core_reset(priv);
+
+	return 0;
+}
+
+static int pcie_dw_imx8_of_to_plat(struct udevice *dev)
+{
+	struct pcie_dw_imx8 *priv = dev_get_priv(dev);
+	ofnode gpr;
+	int ret;
+
+	/* Get the controller base address */
+	priv->dw.dbi_base = (void *)dev_read_addr_name(dev, "dbi");
+	if ((fdt_addr_t)priv->dw.dbi_base == FDT_ADDR_T_NONE) {
+		dev_err(dev, "failed to get dbi_base address\n");
+		return -EINVAL;
+	}
+
+	/* Get the config space base address and size */
+	priv->dw.cfg_base = (void *)dev_read_addr_size_name(dev, "config",
+							    &priv->dw.cfg_size);
+	if ((fdt_addr_t)priv->dw.cfg_base == FDT_ADDR_T_NONE) {
+		dev_err(dev, "failed to get cfg_base address\n");
+		return -EINVAL;
+	}
+
+	ret = clk_get_by_name(dev, "pcie_bus", &priv->pcie_bus);
+	if (ret) {
+		dev_err(dev, "failed to get pcie_bus clk\n");
+		return ret;
+	}
+
+	ret = clk_get_by_name(dev, "pcie", &priv->pcie);
+	if (ret) {
+		dev_err(dev, "failed to get pcie clk\n");
+		return ret;
+	}
+
+	ret = clk_get_by_name(dev, "pcie", &priv->pcie_aux);
+	if (ret) {
+		dev_err(dev, "failed to get pcie clk\n");
+		return ret;
+	}
+
+	ret = reset_get_by_name(dev, "apps", &priv->apps_reset);
+	if (ret) {
+		dev_err(dev,
+			"Failed to get PCIe apps reset control\n");
+		return ret;
+	}
+
+	ret = gpio_request_by_name(dev, "reset-gpio", 0, &priv->reset_gpio,
+				   (GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE));
+	if (ret) {
+		dev_err(dev, "unable to get reset-gpio\n");
+		return ret;
+	}
+
+	ret = generic_phy_get_by_name(dev, "pcie-phy", &priv->phy);
+	if (ret) {
+		dev_err(dev, "failed to get pcie phy\n");
+		return ret;
+	}
+
+	gpr = ofnode_by_compatible(ofnode_null(), "fsl,imx8mp-iomuxc-gpr");
+	if (ofnode_equal(gpr, ofnode_null())) {
+		dev_err(dev, "unable to find GPR node\n");
+		return -ENODEV;
+	}
+
+	priv->iomuxc_gpr = syscon_node_to_regmap(gpr);
+	if (IS_ERR(priv->iomuxc_gpr)) {
+		dev_err(dev, "unable to find iomuxc registers\n");
+		return PTR_ERR(priv->iomuxc_gpr);
+	}
+
+	return 0;
+}
+
+static const struct dm_pci_ops pcie_dw_imx8_ops = {
+	.read_config	= pcie_dw_read_config,
+	.write_config	= pcie_dw_write_config,
+};
+
+static const struct udevice_id pcie_dw_imx8_ids[] = {
+	{ .compatible = "fsl,imx8mp-pcie" },
+	{ }
+};
+
+U_BOOT_DRIVER(pcie_dw_imx8) = {
+	.name		= "pcie_dw_imx8",
+	.id		= UCLASS_PCI,
+	.of_match	= pcie_dw_imx8_ids,
+	.ops		= &pcie_dw_imx8_ops,
+	.of_to_plat	= pcie_dw_imx8_of_to_plat,
+	.probe		= pcie_dw_imx8_probe,
+	.remove		= pcie_dw_imx8_remove,
+	.priv_auto	= sizeof(struct pcie_dw_imx8),
+};
-- 
2.34.1

