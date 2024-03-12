Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EDCBC54E66
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 07:05:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3928D87F01;
	Tue, 12 Mar 2024 08:04:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eTO2P/Pf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2E7087F5D; Tue, 12 Mar 2024 08:04:42 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFAD187F3F
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 08:04:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1dda8e5fa8dso10746425ad.2
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 00:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710227075; x=1710831875; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nw9NvJbNQ4ELftiZi4emQISR6nOkg6vMZVWtiZwnz5k=;
 b=eTO2P/PfU3nGvCyZFeH92CMURwGK1dzBjxul2GNKi+pJe0GDcvK5CROs4dEY+czHOE
 TJECSFgMGxQdTcivyRjt0cYpcY+axJ4GhTYM1SsaSY6KvW9xozIbAa7vPVgWDoTjcTBX
 1T8UC+6YuSjVcyvyBoY9nlgGZTRG5xXQjlewJzgMLJjzzHzupKedt8Nc6rh58vdWGPeV
 dhR8JRXmnSZQ2CI0MfGiewVWis7a4/aU3IPePsIza+9msT/f+ygVkLC5g4hyCFF0kG9A
 fh5Yc6txBxeYXaofJPAPdkDd8yUMeLbbT2/CYcSc68pctzVTjtk6Etax8VxvoeQ+yBB7
 kUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710227075; x=1710831875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nw9NvJbNQ4ELftiZi4emQISR6nOkg6vMZVWtiZwnz5k=;
 b=k5E/yHlcjPkOgY0ewLdidAcwVqVJr5/YWqUEuRuBtzgVj0653K8Kj4ruLStS+REWfK
 ywbS9evsxhVOwlVyfNoLkju0GXUhRgq9/ZFWYrCD3Aps5aWvYjM5aPgbA8FOuZEex23X
 QS9nCmtjQhtnWUkJn58G2RUD403IMh9EAiBQ4JWa3RxmhQPVRPSqHPSEJ0HsZxz9Gz6v
 QRbtHBC6aNMzghcY+JdYXTR6ZkZnCUB6qzgSFjP0wJi/at37bBM8d+bEVNQYuhRoAcCg
 bBHD3avM2vDOfoUCJm3B9QzAie4OTuMzg0U5Uofdk4135wxk34XMaDpiCKto2n7uLjmh
 V4sw==
X-Gm-Message-State: AOJu0YyDD3v1UyJSCIEEi1jrLISbU5tMJmZam8IMvKSqeIq3PZ8uHn0b
 XbG5e6RergOLrFW0nd02w848c3oWWltOfP//RwC+Jr6tVFIxJ2A141kdpYFzbBuaFNP8IddAk+r
 0
X-Google-Smtp-Source: AGHT+IGRmx+z2Wzut203w2WTsqhLQWWuZ1aa24el9zV407lCm+EPTlUra23fLuA2sW9cGnmHXS8kqg==
X-Received: by 2002:a17:902:d2c8:b0:1dd:66d1:a62b with SMTP id
 n8-20020a170902d2c800b001dd66d1a62bmr9690910plc.5.1710227074847; 
 Tue, 12 Mar 2024 00:04:34 -0700 (PDT)
Received: from sumit-X1.. ([223.178.211.249]) by smtp.gmail.com with ESMTPSA id
 e13-20020a170902784d00b001dd0d0d26a4sm6045401pln.147.2024.03.12.00.04.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 00:04:34 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, tharvey@gateworks.com, marcel.ziswiler@toradex.com,
 francesco@dolcini.it, lukma@denx.de, seanga2@gmail.com,
 jh80.chung@samsung.com, sjg@chromium.org, festevam@denx.de,
 andrejs.cainikovs@toradex.com, peng.fan@nxp.com, aford173@gmail.com,
 marex@denx.de, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 07/11] phy: phy-imx8m-pcie: Add support for i.MX8M{M/P}
 PCIe PHY
Date: Tue, 12 Mar 2024 12:33:34 +0530
Message-Id: <20240312070338.86127-8-sumit.garg@linaro.org>
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

Add initial support for i.MX8M{M/P} PCIe PHY. On i.MX8M{M/P} SoCs PCIe
PHY initialization moved to this standalone PHY driver.

Inspired from counterpart Linux kernel v6.8-rc3 driver:
drivers/phy/freescale/phy-fsl-imx8m-pcie.c. Use last Linux kernel driver
reference commit 7559e7572c03 ("phy: Explicitly include correct DT
includes").

Tested-by: Tim Harvey <tharvey@gateworks.com> #imx8mp-venice*
Tested-by: Adam Ford <aford173@gmail.com> #imx8mp-beacon-kit
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/phy/Kconfig          |  11 ++
 drivers/phy/Makefile         |   1 +
 drivers/phy/phy-imx8m-pcie.c | 283 +++++++++++++++++++++++++++++++++++
 3 files changed, 295 insertions(+)
 create mode 100644 drivers/phy/phy-imx8m-pcie.c

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 60138beca49..8f767877e73 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -284,6 +284,17 @@ config PHY_IMX8MQ_USB
 	help
 	  Support the USB3.0 PHY in NXP i.MX8MQ or i.MX8MP SoC
 
+config PHY_IMX8M_PCIE
+	bool "NXP i.MX8MM/i.MX8MP PCIe PHY Driver"
+	depends on PHY
+	depends on IMX8MM || IMX8MP
+	select REGMAP
+	select SYSCON
+	help
+	  Support the PCIe PHY in NXP i.MX8MM or i.MX8MP SoC
+
+	  This PHY is found on i.MX8M devices supporting PCIe.
+
 config PHY_XILINX_ZYNQMP
 	tristate "Xilinx ZynqMP PHY driver"
 	depends on PHY && ARCH_ZYNQMP
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 2e8723186c0..7a2b764492b 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_PHY_DA8XX_USB) += phy-da8xx-usb.o
 obj-$(CONFIG_PHY_MTK_TPHY) += phy-mtk-tphy.o
 obj-$(CONFIG_PHY_NPCM_USB) += phy-npcm-usb.o
 obj-$(CONFIG_PHY_IMX8MQ_USB) += phy-imx8mq-usb.o
+obj-$(CONFIG_PHY_IMX8M_PCIE) += phy-imx8m-pcie.o
 obj-$(CONFIG_PHY_XILINX_ZYNQMP) += phy-zynqmp.o
 obj-y += cadence/
 obj-y += ti/
diff --git a/drivers/phy/phy-imx8m-pcie.c b/drivers/phy/phy-imx8m-pcie.c
new file mode 100644
index 00000000000..2418388cb3c
--- /dev/null
+++ b/drivers/phy/phy-imx8m-pcie.c
@@ -0,0 +1,283 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 Linaro Ltd.
+ *
+ * Derived from Linux counterpart driver
+ */
+
+#include <asm/io.h>
+#include <clk.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <generic-phy.h>
+#include <linux/bitfield.h>
+#include <linux/clk-provider.h>
+#include <linux/iopoll.h>
+#include <syscon.h>
+#include <regmap.h>
+#include <reset.h>
+
+#include <dt-bindings/phy/phy-imx8-pcie.h>
+
+#define IMX8MM_PCIE_PHY_CMN_REG061	0x184
+#define  ANA_PLL_CLK_OUT_TO_EXT_IO_EN	BIT(0)
+#define IMX8MM_PCIE_PHY_CMN_REG062	0x188
+#define  ANA_PLL_CLK_OUT_TO_EXT_IO_SEL	BIT(3)
+#define IMX8MM_PCIE_PHY_CMN_REG063	0x18C
+#define  AUX_PLL_REFCLK_SEL_SYS_PLL	GENMASK(7, 6)
+#define IMX8MM_PCIE_PHY_CMN_REG064	0x190
+#define  ANA_AUX_RX_TX_SEL_TX		BIT(7)
+#define  ANA_AUX_RX_TERM_GND_EN		BIT(3)
+#define  ANA_AUX_TX_TERM		BIT(2)
+#define IMX8MM_PCIE_PHY_CMN_REG065	0x194
+#define  ANA_AUX_RX_TERM		(BIT(7) | BIT(4))
+#define  ANA_AUX_TX_LVL			GENMASK(3, 0)
+#define IMX8MM_PCIE_PHY_CMN_REG075	0x1D4
+#define  ANA_PLL_DONE			0x3
+#define PCIE_PHY_TRSV_REG5		0x414
+#define PCIE_PHY_TRSV_REG6		0x418
+
+#define IMX8MM_GPR_PCIE_REF_CLK_SEL	GENMASK(25, 24)
+#define IMX8MM_GPR_PCIE_REF_CLK_PLL	FIELD_PREP(IMX8MM_GPR_PCIE_REF_CLK_SEL, 0x3)
+#define IMX8MM_GPR_PCIE_REF_CLK_EXT	FIELD_PREP(IMX8MM_GPR_PCIE_REF_CLK_SEL, 0x2)
+#define IMX8MM_GPR_PCIE_AUX_EN		BIT(19)
+#define IMX8MM_GPR_PCIE_CMN_RST		BIT(18)
+#define IMX8MM_GPR_PCIE_POWER_OFF	BIT(17)
+#define IMX8MM_GPR_PCIE_SSC_EN		BIT(16)
+#define IMX8MM_GPR_PCIE_AUX_EN_OVERRIDE	BIT(9)
+
+#define IOMUXC_GPR14_OFFSET		0x38
+
+enum imx8_pcie_phy_type {
+	IMX8MM,
+	IMX8MP,
+};
+
+struct imx8_pcie_phy_drvdata {
+	const	char			*gpr;
+	enum	imx8_pcie_phy_type	variant;
+};
+
+struct imx8_pcie_phy {
+	ulong			base;
+	struct clk		hsio_clk;
+	struct regmap		*iomuxc_gpr;
+	struct reset_ctl	perst;
+	struct reset_ctl	reset;
+	u32			refclk_pad_mode;
+	u32			tx_deemph_gen1;
+	u32			tx_deemph_gen2;
+	bool			clkreq_unused;
+	const struct imx8_pcie_phy_drvdata	*drvdata;
+};
+
+static int imx8_pcie_phy_power_on(struct phy *phy)
+{
+	int ret;
+	u32 val, pad_mode;
+	struct imx8_pcie_phy *imx8_phy = dev_get_priv(phy->dev);
+
+	pad_mode = imx8_phy->refclk_pad_mode;
+	switch (imx8_phy->drvdata->variant) {
+	case IMX8MM:
+		reset_assert(&imx8_phy->reset);
+
+		/* Tune PHY de-emphasis setting to pass PCIe compliance. */
+		if (imx8_phy->tx_deemph_gen1)
+			writel(imx8_phy->tx_deemph_gen1,
+			       imx8_phy->base + PCIE_PHY_TRSV_REG5);
+		if (imx8_phy->tx_deemph_gen2)
+			writel(imx8_phy->tx_deemph_gen2,
+			       imx8_phy->base + PCIE_PHY_TRSV_REG6);
+		break;
+	case IMX8MP: /* Do nothing. */
+		break;
+	}
+
+	if (pad_mode == IMX8_PCIE_REFCLK_PAD_INPUT ||
+	    pad_mode == IMX8_PCIE_REFCLK_PAD_UNUSED) {
+		/* Configure the pad as input */
+		val = readl(imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG061);
+		writel(val & ~ANA_PLL_CLK_OUT_TO_EXT_IO_EN,
+		       imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG061);
+	} else {
+		/* Configure the PHY to output the refclock via pad */
+		writel(ANA_PLL_CLK_OUT_TO_EXT_IO_EN,
+		       imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG061);
+	}
+
+	if (pad_mode == IMX8_PCIE_REFCLK_PAD_OUTPUT ||
+	    pad_mode == IMX8_PCIE_REFCLK_PAD_UNUSED) {
+		/* Source clock from SoC internal PLL */
+		writel(ANA_PLL_CLK_OUT_TO_EXT_IO_SEL,
+		       imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG062);
+		writel(AUX_PLL_REFCLK_SEL_SYS_PLL,
+		       imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG063);
+		val = ANA_AUX_RX_TX_SEL_TX | ANA_AUX_TX_TERM;
+		writel(val | ANA_AUX_RX_TERM_GND_EN,
+		       imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG064);
+		writel(ANA_AUX_RX_TERM | ANA_AUX_TX_LVL,
+		       imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG065);
+	}
+
+	/* Set AUX_EN_OVERRIDE 1'b0, when the CLKREQ# isn't hooked */
+	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14_OFFSET,
+			   IMX8MM_GPR_PCIE_AUX_EN_OVERRIDE,
+			   imx8_phy->clkreq_unused ?
+			   0 : IMX8MM_GPR_PCIE_AUX_EN_OVERRIDE);
+	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14_OFFSET,
+			   IMX8MM_GPR_PCIE_AUX_EN,
+			   IMX8MM_GPR_PCIE_AUX_EN);
+	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14_OFFSET,
+			   IMX8MM_GPR_PCIE_POWER_OFF, 0);
+	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14_OFFSET,
+			   IMX8MM_GPR_PCIE_SSC_EN, 0);
+
+	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14_OFFSET,
+			   IMX8MM_GPR_PCIE_REF_CLK_SEL,
+			   pad_mode == IMX8_PCIE_REFCLK_PAD_INPUT ?
+			   IMX8MM_GPR_PCIE_REF_CLK_EXT :
+			   IMX8MM_GPR_PCIE_REF_CLK_PLL);
+	udelay(200);
+
+	/* Do the PHY common block reset */
+	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14_OFFSET,
+			   IMX8MM_GPR_PCIE_CMN_RST,
+			   IMX8MM_GPR_PCIE_CMN_RST);
+
+	switch (imx8_phy->drvdata->variant) {
+	case IMX8MP:
+		reset_deassert(&imx8_phy->perst);
+		fallthrough;
+	case IMX8MM:
+		reset_deassert(&imx8_phy->reset);
+		udelay(500);
+		break;
+	}
+
+	/* Polling to check the phy is ready or not. */
+	ret = readl_poll_timeout(imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG075,
+				 val, val == ANA_PLL_DONE, 20000);
+	return ret;
+}
+
+static int imx8_pcie_phy_init(struct phy *phy)
+{
+	struct imx8_pcie_phy *imx8_phy = dev_get_priv(phy->dev);
+
+	return clk_enable(&imx8_phy->hsio_clk);
+}
+
+static int imx8_pcie_phy_exit(struct phy *phy)
+{
+	struct imx8_pcie_phy *imx8_phy = dev_get_priv(phy->dev);
+
+	return clk_disable(&imx8_phy->hsio_clk);
+}
+
+static const struct phy_ops imx8_pcie_phy_ops = {
+	.init		= imx8_pcie_phy_init,
+	.exit		= imx8_pcie_phy_exit,
+	.power_on	= imx8_pcie_phy_power_on,
+};
+
+static const struct imx8_pcie_phy_drvdata imx8mm_drvdata = {
+	.gpr = "fsl,imx8mm-iomuxc-gpr",
+	.variant = IMX8MM,
+};
+
+static const struct imx8_pcie_phy_drvdata imx8mp_drvdata = {
+	.gpr = "fsl,imx8mp-iomuxc-gpr",
+	.variant = IMX8MP,
+};
+
+static const struct udevice_id imx8_pcie_phy_of_match[] = {
+	{.compatible = "fsl,imx8mm-pcie-phy", .data = (ulong)&imx8mm_drvdata, },
+	{.compatible = "fsl,imx8mp-pcie-phy", .data = (ulong)&imx8mp_drvdata, },
+	{ },
+};
+
+static int imx8_pcie_phy_probe(struct udevice *dev)
+{
+	struct imx8_pcie_phy *imx8_phy = dev_get_priv(dev);
+	ofnode gpr;
+	int ret = 0;
+
+	imx8_phy->drvdata = (void *)dev_get_driver_data(dev);
+	imx8_phy->base = dev_read_addr(dev);
+	if (!imx8_phy->base)
+		return -EINVAL;
+
+	/* get PHY refclk pad mode */
+	dev_read_u32(dev, "fsl,refclk-pad-mode", &imx8_phy->refclk_pad_mode);
+
+	imx8_phy->tx_deemph_gen1 = dev_read_u32_default(dev,
+							"fsl,tx-deemph-gen1",
+							0);
+	imx8_phy->tx_deemph_gen2 = dev_read_u32_default(dev,
+							"fsl,tx-deemph-gen2",
+							0);
+	imx8_phy->clkreq_unused = dev_read_bool(dev, "fsl,clkreq-unsupported");
+
+	/* Grab GPR config register range */
+	gpr = ofnode_by_compatible(ofnode_null(), imx8_phy->drvdata->gpr);
+	if (ofnode_equal(gpr, ofnode_null())) {
+		dev_err(dev, "unable to find GPR node\n");
+		return -ENODEV;
+	}
+
+	imx8_phy->iomuxc_gpr = syscon_node_to_regmap(gpr);
+	if (IS_ERR(imx8_phy->iomuxc_gpr)) {
+		dev_err(dev, "unable to find iomuxc registers\n");
+		return PTR_ERR(imx8_phy->iomuxc_gpr);
+	}
+
+	ret = clk_get_by_name(dev, "ref", &imx8_phy->hsio_clk);
+	if (ret) {
+		dev_err(dev, "Failed to get PCIEPHY ref clock\n");
+		return ret;
+	}
+
+	ret = reset_get_by_name(dev, "pciephy", &imx8_phy->reset);
+	if (ret) {
+		dev_err(dev, "Failed to get PCIEPHY reset control\n");
+		return ret;
+	}
+
+	if (imx8_phy->drvdata->variant == IMX8MP) {
+		ret = reset_get_by_name(dev, "perst", &imx8_phy->perst);
+		if (ret) {
+			dev_err(dev,
+				"Failed to get PCIEPHY PHY PERST control\n");
+			goto err_perst;
+		}
+	}
+
+	return 0;
+
+err_perst:
+	reset_free(&imx8_phy->reset);
+	return ret;
+}
+
+static int imx8_pcie_phy_remove(struct udevice *dev)
+{
+	struct imx8_pcie_phy *imx8_phy = dev_get_priv(dev);
+
+	if (imx8_phy->drvdata->variant == IMX8MP)
+		reset_free(&imx8_phy->perst);
+
+	reset_free(&imx8_phy->reset);
+
+	return 0;
+}
+
+U_BOOT_DRIVER(nxp_imx8_pcie_phy) = {
+	.name = "nxp_imx8_pcie_phy",
+	.id = UCLASS_PHY,
+	.of_match = imx8_pcie_phy_of_match,
+	.probe = imx8_pcie_phy_probe,
+	.remove = imx8_pcie_phy_remove,
+	.ops = &imx8_pcie_phy_ops,
+	.priv_auto	= sizeof(struct imx8_pcie_phy),
+};
-- 
2.34.1

