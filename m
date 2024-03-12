Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A766C54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 07:05:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFAF487F3B;
	Tue, 12 Mar 2024 08:04:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GlyxFYdb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD57287F49; Tue, 12 Mar 2024 08:04:45 +0100 (CET)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A43A687F3F
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 08:04:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5cfd95130c6so3703993a12.1
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 00:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710227081; x=1710831881; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2i1I6mk/AOHH4aU6BiXOt/0JXOLA5eAFpzeM/n/EwlA=;
 b=GlyxFYdbafaFoXkFx6POtLpiOu+Sgres9pRbw+UXhxW2a8DIGvpQU0xosbXKkoM4v9
 1vaaHnGw1Bsc3nmoFEhPv2UkQFNtND3IpZXTFHpLEIlNEMl6beOsubwNgk43kGhRz/3h
 nMn8Kfbpq4yFqHH0E3huV+uP10PEgMr1rrayZfYvKDxwi2LJg7cSODIF0spk9GaOl4nl
 hoS1e7IAFaty1JH8SRWtSvjXOP8QaYnjuAeKMo8wtsNlyB710kFVeIxpBxesyZWdbn28
 dgglFPrNss9Ior1RtRnsCjqyuDaJgjZCMtK+Nu03mjh8MeGaMaSpCd4mofEmKSDdCGJp
 /4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710227081; x=1710831881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2i1I6mk/AOHH4aU6BiXOt/0JXOLA5eAFpzeM/n/EwlA=;
 b=VvCDto+fqTksc4kHgY3NFHWepPMbhpV44USIXTiKu8DdZrAc0A4/9DLD+jBjtCoOLU
 h3umRAt+mxhdoVWT3GZB4eIFfMDF9dpzvxOznxSn5xFNEC1bpewR/oCdVzndwTwD+ge0
 M+qScIRLh8oAtJfb7GBLb+Tj+y8TVKieJk6PC8yy9Dp9QL71Y/yZRUfRIxNpR0TSwGK+
 QxtiO3gD0CIo6we1CahpezuGV1/A3abIjmwUBaK8swuVx1b4CV9/qpmFv2qEkFwqZYkR
 WZgal9B/0S5rhtwE5OAdMctr27lQoLC3LIO+MQGi9q7yw9I+ICsthIrLrLraQCuAui1S
 hruQ==
X-Gm-Message-State: AOJu0Yzai7Tpm4PuIwlSGuxCq1TM4DwfypxynWTLe5e2gmIyNIs/Y3yM
 lkUagpwmBEe2mWFnudZjWzxKzWfbKdomBDSG/KixH959+AzoESBFgzuOxaxxF3ZXD7Y3dT+wE1M
 p
X-Google-Smtp-Source: AGHT+IG1VjkP+x82rYO31KBB4lTYUso9k6xk2mqEg3o7X5EC/IEybTXS/3HxxgcCRlo8gacu1vlzSw==
X-Received: by 2002:a05:6a20:12c9:b0:1a3:113a:bbd5 with SMTP id
 v9-20020a056a2012c900b001a3113abbd5mr1042395pzg.40.1710227080768; 
 Tue, 12 Mar 2024 00:04:40 -0700 (PDT)
Received: from sumit-X1.. ([223.178.211.249]) by smtp.gmail.com with ESMTPSA id
 e13-20020a170902784d00b001dd0d0d26a4sm6045401pln.147.2024.03.12.00.04.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 00:04:40 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, tharvey@gateworks.com, marcel.ziswiler@toradex.com,
 francesco@dolcini.it, lukma@denx.de, seanga2@gmail.com,
 jh80.chung@samsung.com, sjg@chromium.org, festevam@denx.de,
 andrejs.cainikovs@toradex.com, peng.fan@nxp.com, aford173@gmail.com,
 marex@denx.de, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 08/11] pci: Add DW PCIe controller support for iMX8MP SoC
Date: Tue, 12 Mar 2024 12:33:35 +0530
Message-Id: <20240312070338.86127-9-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312070338.86127-1-sumit.garg@linaro.org>
References: <20240312070338.86127-1-sumit.garg@linaro.org>
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

Tested-by: Tim Harvey <tharvey@gateworks.com> #imx8mp-venice*
Tested-by: Adam Ford <aford173@gmail.com> #imx8mp-beacon-kit
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/pci/Kconfig       |  11 ++
 drivers/pci/Makefile      |   1 +
 drivers/pci/pcie_dw_imx.c | 338 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 350 insertions(+)
 create mode 100644 drivers/pci/pcie_dw_imx.c

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 463ec47eb92..8d02ab82ad9 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -413,4 +413,15 @@ config PCIE_STARFIVE_JH7110
 	  Say Y here if you want to enable PLDA XpressRich PCIe controller
 	  support on StarFive JH7110 SoC.
 
+config PCIE_DW_IMX
+	bool "i.MX DW PCIe controller support"
+	depends on ARCH_IMX8M
+	select PCIE_DW_COMMON
+	select DM_REGULATOR
+	select REGMAP
+	select SYSCON
+	help
+	  Say Y here if you want to enable DW PCIe controller support on
+	  iMX SoCs.
+
 endif
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 72ef8b4bc77..2927c519129 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -53,3 +53,4 @@ obj-$(CONFIG_PCIE_UNIPHIER) += pcie_uniphier.o
 obj-$(CONFIG_PCIE_XILINX_NWL) += pcie-xilinx-nwl.o
 obj-$(CONFIG_PCIE_PLDA_COMMON) += pcie_plda_common.o
 obj-$(CONFIG_PCIE_STARFIVE_JH7110) += pcie_starfive_jh7110.o
+obj-$(CONFIG_PCIE_DW_IMX) += pcie_dw_imx.o
diff --git a/drivers/pci/pcie_dw_imx.c b/drivers/pci/pcie_dw_imx.c
new file mode 100644
index 00000000000..a9e62da69f6
--- /dev/null
+++ b/drivers/pci/pcie_dw_imx.c
@@ -0,0 +1,338 @@
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
+#include <linux/iopoll.h>
+#include <log.h>
+#include <pci.h>
+#include <power/regulator.h>
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
+struct pcie_dw_imx {
+	/* Must be first member of the struct */
+	struct pcie_dw			dw;
+	struct regmap			*iomuxc_gpr;
+	struct clk_bulk			clks;
+	struct gpio_desc		reset_gpio;
+	struct reset_ctl		apps_reset;
+	struct phy			phy;
+	struct udevice			*vpcie;
+};
+
+static void pcie_dw_configure(struct pcie_dw_imx *priv, u32 cap_speed)
+{
+	dw_pcie_dbi_write_enable(&priv->dw, true);
+
+	clrsetbits_le32(priv->dw.dbi_base + PCIE_LINK_CAPABILITY,
+			TARGET_LINK_SPEED_MASK, cap_speed);
+
+	dw_pcie_dbi_write_enable(&priv->dw, false);
+}
+
+static void imx_pcie_ltssm_enable(struct pcie_dw_imx *priv)
+{
+	reset_deassert(&priv->apps_reset);
+}
+
+static void imx_pcie_ltssm_disable(struct pcie_dw_imx *priv)
+{
+	reset_assert(&priv->apps_reset);
+}
+
+static bool is_link_up(u32 val)
+{
+	return ((val & PCIE_PORT_DEBUG1_LINK_UP) &&
+		(!(val & PCIE_PORT_DEBUG1_LINK_IN_TRAINING)));
+}
+
+static int wait_link_up(struct pcie_dw_imx *priv)
+{
+	u32 val;
+
+	return readl_poll_sleep_timeout(priv->dw.dbi_base + PCIE_PORT_DEBUG1,
+					val, is_link_up(val), 10000, 100000);
+}
+
+static int pcie_link_up(struct pcie_dw_imx *priv, u32 cap_speed)
+{
+	int ret;
+
+	/* DW pre link configurations */
+	pcie_dw_configure(priv, cap_speed);
+
+	/* Initiate link training */
+	imx_pcie_ltssm_enable(priv);
+
+	/* Check that link was established */
+	ret = wait_link_up(priv);
+	if (ret)
+		imx_pcie_ltssm_disable(priv);
+
+	return ret;
+}
+
+static int imx_pcie_assert_core_reset(struct pcie_dw_imx *priv)
+{
+	if (dm_gpio_is_valid(&priv->reset_gpio)) {
+		dm_gpio_set_value(&priv->reset_gpio, 1);
+		mdelay(20);
+	}
+
+	return reset_assert(&priv->apps_reset);
+}
+
+static int imx_pcie_clk_enable(struct pcie_dw_imx *priv)
+{
+	int ret;
+
+	ret = clk_enable_bulk(&priv->clks);
+	if (ret)
+		return ret;
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
+}
+
+static void imx_pcie_deassert_core_reset(struct pcie_dw_imx *priv)
+{
+	if (!dm_gpio_is_valid(&priv->reset_gpio))
+		return;
+
+	mdelay(100);
+	dm_gpio_set_value(&priv->reset_gpio, 0);
+	/* Wait for 100ms after PERST# deassertion (PCIe r5.0, 6.6.1) */
+	mdelay(100);
+}
+
+static int pcie_dw_imx_probe(struct udevice *dev)
+{
+	struct pcie_dw_imx *priv = dev_get_priv(dev);
+	struct udevice *ctlr = pci_get_controller(dev);
+	struct pci_controller *hose = dev_get_uclass_priv(ctlr);
+	int ret;
+
+	if (priv->vpcie) {
+		ret = regulator_set_enable(priv->vpcie, true);
+		if (ret) {
+			dev_err(dev, "failed to enable vpcie regulator\n");
+			return ret;
+		}
+	}
+
+	ret = imx_pcie_assert_core_reset(priv);
+	if (ret) {
+		dev_err(dev, "failed to assert core reset\n");
+		return ret;
+	}
+
+	ret = imx_pcie_clk_enable(priv);
+	if (ret) {
+		dev_err(dev, "failed to enable clocks\n");
+		goto err_clk;
+	}
+
+	ret = generic_phy_init(&priv->phy);
+	if (ret) {
+		dev_err(dev, "failed to initialize PHY\n");
+		goto err_phy_init;
+	}
+
+	ret = generic_phy_power_on(&priv->phy);
+	if (ret) {
+		dev_err(dev, "failed to power on PHY\n");
+		goto err_phy_power;
+	}
+
+	imx_pcie_deassert_core_reset(priv);
+
+	priv->dw.first_busno = dev_seq(dev);
+	priv->dw.dev = dev;
+	pcie_dw_setup_host(&priv->dw);
+
+	if (pcie_link_up(priv, LINK_SPEED_GEN_1)) {
+		printf("PCIE-%d: Link down\n", dev_seq(dev));
+		ret = -ENODEV;
+		goto err_link;
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
+
+err_link:
+	generic_shutdown_phy(&priv->phy);
+err_phy_power:
+	generic_phy_exit(&priv->phy);
+err_phy_init:
+	clk_disable_bulk(&priv->clks);
+err_clk:
+	imx_pcie_deassert_core_reset(priv);
+
+	return ret;
+}
+
+static int pcie_dw_imx_remove(struct udevice *dev)
+{
+	struct pcie_dw_imx *priv = dev_get_priv(dev);
+
+	generic_shutdown_phy(&priv->phy);
+	dm_gpio_free(dev, &priv->reset_gpio);
+	reset_free(&priv->apps_reset);
+	clk_release_bulk(&priv->clks);
+
+	return 0;
+}
+
+static int pcie_dw_imx_of_to_plat(struct udevice *dev)
+{
+	struct pcie_dw_imx *priv = dev_get_priv(dev);
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
+	ret = clk_get_bulk(dev, &priv->clks);
+	if (ret) {
+		dev_err(dev, "failed to get PCIe clks\n");
+		return ret;
+	}
+
+	ret = reset_get_by_name(dev, "apps", &priv->apps_reset);
+	if (ret) {
+		dev_err(dev,
+			"Failed to get PCIe apps reset control\n");
+		goto err_reset;
+	}
+
+	ret = gpio_request_by_name(dev, "reset-gpio", 0, &priv->reset_gpio,
+				   (GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE));
+	if (ret) {
+		dev_err(dev, "unable to get reset-gpio\n");
+		goto err_gpio;
+	}
+
+	ret = generic_phy_get_by_name(dev, "pcie-phy", &priv->phy);
+	if (ret) {
+		dev_err(dev, "failed to get pcie phy\n");
+		goto err_phy;
+	}
+
+	gpr = ofnode_by_compatible(ofnode_null(), "fsl,imx8mp-iomuxc-gpr");
+	if (ofnode_equal(gpr, ofnode_null())) {
+		dev_err(dev, "unable to find GPR node\n");
+		ret = -ENODEV;
+		goto err_phy;
+	}
+
+	priv->iomuxc_gpr = syscon_node_to_regmap(gpr);
+	if (IS_ERR(priv->iomuxc_gpr)) {
+		dev_err(dev, "unable to find iomuxc registers\n");
+		ret = PTR_ERR(priv->iomuxc_gpr);
+		goto err_phy;
+	}
+
+	/* vpcie-supply regulator is optional */
+	device_get_supply_regulator(dev, "vpcie-supply", &priv->vpcie);
+
+	return 0;
+
+err_phy:
+	dm_gpio_free(dev, &priv->reset_gpio);
+err_gpio:
+	reset_free(&priv->apps_reset);
+err_reset:
+	clk_release_bulk(&priv->clks);
+
+	return ret;
+}
+
+static const struct dm_pci_ops pcie_dw_imx_ops = {
+	.read_config	= pcie_dw_read_config,
+	.write_config	= pcie_dw_write_config,
+};
+
+static const struct udevice_id pcie_dw_imx_ids[] = {
+	{ .compatible = "fsl,imx8mp-pcie" },
+	{ }
+};
+
+U_BOOT_DRIVER(pcie_dw_imx) = {
+	.name		= "pcie_dw_imx",
+	.id		= UCLASS_PCI,
+	.of_match	= pcie_dw_imx_ids,
+	.ops		= &pcie_dw_imx_ops,
+	.of_to_plat	= pcie_dw_imx_of_to_plat,
+	.probe		= pcie_dw_imx_probe,
+	.remove		= pcie_dw_imx_remove,
+	.priv_auto	= sizeof(struct pcie_dw_imx),
+};
-- 
2.34.1

