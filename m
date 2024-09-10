Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD09ECE564
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 10:14:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA55189004;
	Tue, 10 Sep 2024 12:14:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="AoLSM5ig";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B9B588F65; Tue, 10 Sep 2024 12:14:05 +0200 (CEST)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net
 [217.70.183.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1277D89010
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 12:14:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B278A24000F;
 Tue, 10 Sep 2024 10:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1725963228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wz6UKjCMF3UXJyBsQ2hnoox4e+5/D0KbZzdYOEOUH3g=;
 b=AoLSM5ignfbFCciFzoD5XVAZt5ZOkBij4Sun169PoSgtqswbbyZ6m78/7qikHTlBJdupOq
 6BQzDMQZUVETnNilRZ4/hRocj5sTxh3b+rCUivdVb4WBiC7ducOySuMjswSZQBMUO5EKMc
 /E1JSi/n0pBtcQo05Q/56CDxPHmXGo7p9vj6JbnncWnIiiAGDcOVoa2Wd0i2vMGDjBNhtU
 NYRGv7O9miOev7dcyLw50k83Y9X5e3JGDGCSwQ4FAeDSEgk4Iq83M0+p/tDij3Yten6X5s
 +pvWL/3VyUEgfTrplO0lI2iGAkiDQ6GSjvVBHQgtry4CPEguPaERMIpc94xMDw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>
Cc: <u-boot@lists.denx.de>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Ian Ray <ian.ray@gehealthcare.com>, Marek Vasut <marek.vasut@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 5/8] imx: power-domain: Add support for the MEDIAMIX control
 block
Date: Tue, 10 Sep 2024 12:13:41 +0200
Message-ID: <20240910101344.110633-6-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910101344.110633-1-miquel.raynal@bootlin.com>
References: <20240910101344.110633-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
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

This block delivers power and clocks to the whole display and rendering
pipeline.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/power/domain/Kconfig           |   7 +
 drivers/power/domain/Makefile          |   1 +
 drivers/power/domain/imx8mp-mediamix.c | 185 +++++++++++++++++++++++++
 3 files changed, 193 insertions(+)
 create mode 100644 drivers/power/domain/imx8mp-mediamix.c

diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfig
index bd82d2f7044..5f5218bd8b5 100644
--- a/drivers/power/domain/Kconfig
+++ b/drivers/power/domain/Kconfig
@@ -47,6 +47,13 @@ config IMX8MP_HSIOMIX_BLKCTRL
 	help
 	  Enable support for manipulating NXP i.MX8MP on-SoC HSIOMIX block controller.
 
+config IMX8MP_MEDIAMIX_BLKCTRL
+	bool "Enable i.MX8MP MEDIAMIX domain driver"
+	depends on POWER_DOMAIN && IMX8MP
+	select CLK
+	help
+	  Enable support for manipulating NXP i.MX8MP on-SoC MEDIAMIX block controller.
+
 config MTK_POWER_DOMAIN
 	bool "Enable the MediaTek power domain driver"
 	depends on POWER_DOMAIN && ARCH_MEDIATEK
diff --git a/drivers/power/domain/Makefile b/drivers/power/domain/Makefile
index 2daab73eb75..4e45b6bb3aa 100644
--- a/drivers/power/domain/Makefile
+++ b/drivers/power/domain/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_BCM6328_POWER_DOMAIN) += bcm6328-power-domain.o
 obj-$(CONFIG_IMX8_POWER_DOMAIN) += imx8-power-domain-legacy.o imx8-power-domain.o
 obj-$(CONFIG_IMX8M_POWER_DOMAIN) += imx8m-power-domain.o
 obj-$(CONFIG_IMX8MP_HSIOMIX_BLKCTRL) += imx8mp-hsiomix.o
+obj-$(CONFIG_IMX8MP_MEDIAMIX_BLKCTRL) += imx8mp-mediamix.o
 obj-$(CONFIG_MTK_POWER_DOMAIN) += mtk-power-domain.o
 obj-$(CONFIG_MESON_GX_VPU_POWER_DOMAIN) += meson-gx-pwrc-vpu.o
 obj-$(CONFIG_MESON_EE_POWER_DOMAIN) += meson-ee-pwrc.o
diff --git a/drivers/power/domain/imx8mp-mediamix.c b/drivers/power/domain/imx8mp-mediamix.c
new file mode 100644
index 00000000000..63079ff3430
--- /dev/null
+++ b/drivers/power/domain/imx8mp-mediamix.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * i.MX8 MEDIAMIX control block driver
+ * Copyright (C) 2024 Miquel Raynal <miquel.raynal@bootlin.com>
+ * Inspired from Marek Vasut <marex@denx.de> work on the hsiomix driver.
+ */
+
+#include <asm/io.h>
+#include <clk.h>
+#include <dm.h>
+#include <power-domain-uclass.h>
+#include <linux/delay.h>
+
+#include <dt-bindings/power/imx8mp-power.h>
+
+#define BLK_SFT_RSTN		0x0
+#define BLK_CLK_EN		0x4
+
+struct imx8mp_mediamix_priv {
+	void __iomem *base;
+	struct clk clk_apb;
+	struct clk clk_axi;
+	struct clk clk_disp2;
+	struct power_domain pd_bus;
+	struct power_domain pd_lcdif2;
+};
+
+static int imx8mp_mediamix_on(struct power_domain *power_domain)
+{
+	struct udevice *dev = power_domain->dev;
+	struct imx8mp_mediamix_priv *priv = dev_get_priv(dev);
+	struct power_domain *domain;
+	struct clk *clk;
+	u32 reset;
+	int ret;
+
+	switch (power_domain->id) {
+	case IMX8MP_MEDIABLK_PD_LCDIF_2:
+		domain = &priv->pd_lcdif2;
+		clk = &priv->clk_disp2;
+		reset = BIT(11) | BIT(12) | BIT(24);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Make sure bus domain is awake */
+	ret = power_domain_on(&priv->pd_bus);
+	if (ret)
+		return ret;
+
+	/* Put devices into reset */
+	clrbits_le32(priv->base + BLK_SFT_RSTN, reset);
+
+	/* Enable upstream clocks */
+	ret = clk_enable(&priv->clk_apb);
+	if (ret)
+		goto dis_bus_pd;
+
+	ret = clk_enable(&priv->clk_axi);
+	if (ret)
+		goto dis_bus_pd;
+
+	/* Enable blk-ctrl clock to allow reset to propagate */
+	ret = clk_enable(clk);
+	if (ret)
+		goto dis_bus_pd;
+	setbits_le32(priv->base + BLK_CLK_EN, reset);
+
+	/* Power up upstream GPC domain */
+	ret = power_domain_on(domain);
+	if (ret)
+		goto dis_bus_pd;
+
+	/* Wait for reset to propagate */
+	udelay(5);
+
+	/* Release reset */
+	setbits_le32(priv->base + BLK_SFT_RSTN, reset);
+
+	return 0;
+
+dis_bus_pd:
+	power_domain_off(&priv->pd_bus);
+
+	return ret;
+}
+
+static int imx8mp_mediamix_off(struct power_domain *power_domain)
+{
+	struct udevice *dev = power_domain->dev;
+	struct imx8mp_mediamix_priv *priv = dev_get_priv(dev);
+	struct power_domain *domain;
+	u32 reset;
+
+	switch (power_domain->id) {
+	case IMX8MP_MEDIABLK_PD_LCDIF_2:
+		domain = &priv->pd_lcdif2;
+		reset = BIT(11) | BIT(12) | BIT(24);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Put devices into reset and disable clocks */
+	clrbits_le32(priv->base + BLK_SFT_RSTN, reset);
+	clrbits_le32(priv->base + BLK_CLK_EN, reset);
+
+	/* Power down upstream GPC domain */
+	power_domain_off(domain);
+
+	/* Allow bus domain to suspend */
+	power_domain_off(&priv->pd_bus);
+
+	return 0;
+}
+
+static int imx8mp_mediamix_of_xlate(struct power_domain *power_domain,
+				    struct ofnode_phandle_args *args)
+{
+	power_domain->id = args->args[0];
+
+	return 0;
+}
+
+static int imx8mp_mediamix_bind(struct udevice *dev)
+{
+	/* Bind child lcdif */
+	return dm_scan_fdt_dev(dev);
+}
+
+static int imx8mp_mediamix_probe(struct udevice *dev)
+{
+	struct imx8mp_mediamix_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	priv->base = dev_read_addr_ptr(dev);
+
+	ret = clk_get_by_name(dev, "apb", &priv->clk_apb);
+	if (ret < 0)
+		return ret;
+
+	ret = clk_get_by_name(dev, "axi", &priv->clk_axi);
+	if (ret < 0)
+		return ret;
+
+	ret = clk_get_by_name(dev, "disp2", &priv->clk_disp2);
+	if (ret < 0)
+		return ret;
+
+	ret = power_domain_get_by_name(dev, &priv->pd_bus, "bus");
+	if (ret < 0)
+		return ret;
+
+	ret = power_domain_get_by_name(dev, &priv->pd_lcdif2, "lcdif2");
+	if (ret < 0)
+		goto free_bus_pd;
+
+	return 0;
+
+free_bus_pd:
+	power_domain_free(&priv->pd_bus);
+	return ret;
+}
+
+static const struct udevice_id imx8mp_mediamix_ids[] = {
+	{ .compatible = "fsl,imx8mp-media-blk-ctrl" },
+	{ }
+};
+
+struct power_domain_ops imx8mp_mediamix_ops = {
+	.on = imx8mp_mediamix_on,
+	.off = imx8mp_mediamix_off,
+	.of_xlate = imx8mp_mediamix_of_xlate,
+};
+
+U_BOOT_DRIVER(imx8mp_mediamix) = {
+	.name		= "imx8mp_mediamix",
+	.id		= UCLASS_POWER_DOMAIN,
+	.of_match	= imx8mp_mediamix_ids,
+	.bind		= imx8mp_mediamix_bind,
+	.probe		= imx8mp_mediamix_probe,
+	.priv_auto	= sizeof(struct imx8mp_mediamix_priv),
+	.ops		= &imx8mp_mediamix_ops,
+};
-- 
2.43.0

