Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9321DC48BC3
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 15:35:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1994C87F37;
	Mon, 19 Feb 2024 16:34:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XBLLhBim";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F38C087DDB; Mon, 19 Feb 2024 16:34:27 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62E0687F51
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 16:33:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id EF224CE1296;
 Mon, 19 Feb 2024 15:33:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D41FC433F1;
 Mon, 19 Feb 2024 15:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1708356828;
 bh=Wx19P1Kc0b5J07YKPfJTyM1uSVUhYwDFJ/31jVKe2Wg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=XBLLhBimwp4Q3ka2QpZBSO95P+AbRN1FQy2gPRxmM5zUkZWpX22fLRWjDZA8bln44
 qdUG9Sq5fZXpvL9erYCWyLnws55v0+lhdgQuSJoXLF1SQLKUwXzhthkxBU9BgOWMFa
 8MuHPanYaiH+jjfITs9czLGoKojy3oscyvd0BOWz+vHoW13UX7Xdl3F6Q2spuW8T+8
 RnfJhb8BgM9I6mL5JamVutJYpyiUi6Ki8uaX2K6fAvLHDFDBBuSUVuu4YhymiKfQOQ
 HlhFF1Mjda8lZGAkA31kpIsEarOAWdLzH2PSh+ZNn3i1mE6S0yKrE6oIfj/SZw90oJ
 kn36jqlCfSB5Q==
From: Roger Quadros <rogerq@kernel.org>
Date: Mon, 19 Feb 2024 17:33:29 +0200
Subject: [PATCH 2/2] net: am65-cpsw: cpsw_mdio: Switch to proper DM_MDIO
 framework
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-for-2024-07-am65-cpsw-mdio-v1-2-afe9aaba5801@kernel.org>
References: <20240219-for-2024-07-am65-cpsw-mdio-v1-0-afe9aaba5801@kernel.org>
In-Reply-To: <20240219-for-2024-07-am65-cpsw-mdio-v1-0-afe9aaba5801@kernel.org>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, 
 nm@ti.com
Cc: srk@ti.com, s-vadapalli@ti.com, vigneshr@ti.com, mripard@kernel.org, 
 dannenberg@ti.com, r-gunasekaran@ti.com, danishanwar@ti.com, 
 u-boot@lists.denx.de, Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=19605; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=Wx19P1Kc0b5J07YKPfJTyM1uSVUhYwDFJ/31jVKe2Wg=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBl03TSsJNCZ2ybLvjMeILbfXdaNEL2JkMUK5wLN
 rBJNh9UVb+JAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZdN00gAKCRDSWmvTvnYw
 k0x9EACiV+RNYN0misHDrUUnfkhr1UmvA2PWYTUSqyi1AouFEzBbn7iX60pI7CLcC0ysjegJU+j
 K2rjQ9Wm6ArZBrdtad7c9yeOVzrWUHCmclHy6sgVbWvBOfigWQ6OY16WP6ZE8xGTxu9VwAAc47a
 qsWpFx1LfSAyvvr9JeekKO7RCZjpegyiyg5UkTnkTEnqdrjf5cpnwMbf98CvItKwER9J6EciXYO
 x/UX/AK4LnpcJEMlh/GoUD1DCVyo8CBF6uj7v8CzJw12Kjt3gCmHtPUjPH9eElyj9O51fIHqnPw
 byTjapM5qMmM4AK97l1AvMr/G5jrbQGtFm0zseeN3Lp4WaHoOSAmkguDIEWhzZ+W6gv6ZiQOKZa
 iI/sNRyDqjjgUr3lx5Mc3oJXbRNM7vsJ95pDZIqbmcD4GUtwB/AkdVF7Qr8Gf1XJMeASrEyeJ0E
 N5RqClNAbVmm90sPh24I6BHGXAlSfSfMVEivemoIuMsKdelg6IeeiyXFKUxNPI5wflkV1KPzBAd
 mRLVxeimBD6zX+gbLWioSgAey1pyYJbbCmWZQtdQqzgjDEbJMf1ef2KICf0GrYNelsmmIRg0XNE
 VOA+TedY8lorsNsSgCxVsx32NasLfxfFz4IAKT2M1y6Tu9O1f+4fm1umLvgoQTcckYNSwcXRo37
 /zVPnJm5I913eYQ==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093
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

Add a new Kconfig symbol MDIO_TI_CPSW for the CPSW MDIO
driver and build it with proper DM support if enabled.

If MDIO_TI_CPSW is not enabled then we continue to
behave like before.

Clean up MDIO custom handling in am65-cpsw and use
dm_eth_phy_connect() to get the PHY.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ti/Kconfig          |   8 ++
 drivers/net/ti/Makefile         |   3 +-
 drivers/net/ti/am65-cpsw-nuss.c | 190 ++------------------------------------
 drivers/net/ti/cpsw_mdio.c      | 198 +++++++++++++++++++++++++++++++++++-----
 drivers/net/ti/cpsw_mdio.h      |   2 +
 5 files changed, 196 insertions(+), 205 deletions(-)

diff --git a/drivers/net/ti/Kconfig b/drivers/net/ti/Kconfig
index c75f418628..72eccc99e5 100644
--- a/drivers/net/ti/Kconfig
+++ b/drivers/net/ti/Kconfig
@@ -45,7 +45,15 @@ config TI_AM65_CPSW_NUSS
 	imply MISC_INIT_R
 	imply MISC
 	imply SYSCON
+	imply MDIO_TI_CPSW
 	select PHYLIB
 	help
 	  This driver supports TI K3 MCU CPSW Nuss Ethernet controller
 	  in Texas Instruments K3 AM65x SoCs.
+
+config MDIO_TI_CPSW
+	bool "TI CPSW MDIO interface support"
+	depends on DM_MDIO
+	help
+	  This driver supports the TI CPSW MDIO interface found in various
+	  TI SoCs.
diff --git a/drivers/net/ti/Makefile b/drivers/net/ti/Makefile
index 0ce0cf2828..30c4c4b6d5 100644
--- a/drivers/net/ti/Makefile
+++ b/drivers/net/ti/Makefile
@@ -5,4 +5,5 @@
 obj-$(CONFIG_DRIVER_TI_CPSW) += cpsw.o cpsw-common.o cpsw_mdio.o
 obj-$(CONFIG_DRIVER_TI_EMAC) += davinci_emac.o
 obj-$(CONFIG_DRIVER_TI_KEYSTONE_NET) += keystone_net.o cpsw_mdio.o
-obj-$(CONFIG_TI_AM65_CPSW_NUSS) += am65-cpsw-nuss.o cpsw_mdio.o
+obj-$(CONFIG_TI_AM65_CPSW_NUSS) += am65-cpsw-nuss.o
+obj-$(CONFIG_MDIO_TI_CPSW) += cpsw_mdio.o
diff --git a/drivers/net/ti/am65-cpsw-nuss.c b/drivers/net/ti/am65-cpsw-nuss.c
index 6da018c0f9..d68ed67183 100644
--- a/drivers/net/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ti/am65-cpsw-nuss.c
@@ -31,8 +31,6 @@
 #include <linux/printk.h>
 #include <linux/soc/ti/ti-udma.h>
 
-#include "cpsw_mdio.h"
-
 #define AM65_CPSW_CPSWNU_MAX_PORTS 9
 
 #define AM65_CPSW_SS_BASE		0x0
@@ -113,7 +111,6 @@ struct am65_cpsw_common {
 	struct udevice		*dev;
 	fdt_addr_t		ss_base;
 	fdt_addr_t		cpsw_base;
-	fdt_addr_t		mdio_base;
 	fdt_addr_t		ale_base;
 
 	struct clk		fclk;
@@ -122,13 +119,8 @@ struct am65_cpsw_common {
 	u32			port_num;
 	struct am65_cpsw_port	ports[AM65_CPSW_CPSWNU_MAX_PORTS];
 
-	struct mii_dev		*bus;
 	u32			bus_freq;
 
-	struct gpio_desc	mdio_gpio_reset;
-	u32			reset_delay_us;
-	u32			reset_post_delay_us;
-
 	struct dma		dma_tx;
 	struct dma		dma_rx;
 	u32			rx_next;
@@ -140,13 +132,7 @@ struct am65_cpsw_priv {
 	struct udevice		*dev;
 	struct am65_cpsw_common	*cpsw_common;
 	u32			port_id;
-
 	struct phy_device	*phydev;
-	bool			has_phy;
-	ofnode			phy_node;
-	u32			phy_addr;
-
-	bool			mdio_manual_mode;
 };
 
 #ifdef PKTSIZE_ALIGN
@@ -622,111 +608,15 @@ static const struct eth_ops am65_cpsw_ops = {
 	.read_rom_hwaddr = am65_cpsw_read_rom_hwaddr,
 };
 
-static const struct soc_attr k3_mdio_soc_data[] = {
-	{ .family = "AM62X", .revision = "SR1.0" },
-	{ .family = "AM64X", .revision = "SR1.0" },
-	{ .family = "AM64X", .revision = "SR2.0" },
-	{ .family = "AM65X", .revision = "SR1.0" },
-	{ .family = "AM65X", .revision = "SR2.0" },
-	{ .family = "J7200", .revision = "SR1.0" },
-	{ .family = "J7200", .revision = "SR2.0" },
-	{ .family = "J721E", .revision = "SR1.0" },
-	{ .family = "J721E", .revision = "SR1.1" },
-	{ .family = "J721S2", .revision = "SR1.0" },
-	{ /* sentinel */ },
-};
-
-static ofnode am65_cpsw_find_mdio(ofnode parent)
-{
-	ofnode node;
-
-	ofnode_for_each_subnode(node, parent)
-		if (ofnode_device_is_compatible(node, "ti,cpsw-mdio"))
-			return node;
-
-	return ofnode_null();
-}
-
-static int am65_cpsw_mdio_setup(struct udevice *dev)
-{
-	struct am65_cpsw_priv *priv = dev_get_priv(dev);
-	struct am65_cpsw_common	*cpsw_common = priv->cpsw_common;
-	struct udevice *mdio_dev;
-	ofnode mdio;
-	int ret;
-
-	mdio = am65_cpsw_find_mdio(dev_ofnode(cpsw_common->dev));
-	if (!ofnode_valid(mdio))
-		return 0;
-
-	/*
-	 * The MDIO controller is represented in the DT binding by a
-	 * subnode of the MAC controller.
-	 *
-	 * We don't have a DM driver for the MDIO device yet, and thus any
-	 * pinctrl setting on its node will be ignored.
-	 *
-	 * However, we do need to make sure the pins states tied to the
-	 * MDIO node are configured properly. Fortunately, the core DM
-	 * does that for use when we get a device, so we can work around
-	 * that whole issue by just requesting a dummy MDIO driver to
-	 * probe, and our pins will get muxed.
-	 */
-	ret = uclass_get_device_by_ofnode(UCLASS_MDIO, mdio, &mdio_dev);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
-static int am65_cpsw_mdio_init(struct udevice *dev)
-{
-	struct am65_cpsw_priv *priv = dev_get_priv(dev);
-	struct am65_cpsw_common	*cpsw_common = priv->cpsw_common;
-	int ret;
-
-	if (!priv->has_phy || cpsw_common->bus)
-		return 0;
-
-	if (IS_ENABLED(CONFIG_DM_GPIO)) {
-		if (dm_gpio_is_valid(&cpsw_common->mdio_gpio_reset)) {
-			dm_gpio_set_value(&cpsw_common->mdio_gpio_reset, 1);
-			udelay(cpsw_common->reset_delay_us);
-			dm_gpio_set_value(&cpsw_common->mdio_gpio_reset, 0);
-			if (cpsw_common->reset_post_delay_us > 0)
-				udelay(cpsw_common->reset_post_delay_us);
-		}
-	}
-
-	ret = am65_cpsw_mdio_setup(dev);
-	if (ret)
-		return ret;
-
-	cpsw_common->bus = cpsw_mdio_init(dev->name,
-					  cpsw_common->mdio_base,
-					  cpsw_common->bus_freq,
-					  clk_get_rate(&cpsw_common->fclk),
-					  priv->mdio_manual_mode);
-	if (!cpsw_common->bus)
-		return -EFAULT;
-
-	return 0;
-}
-
 static int am65_cpsw_phy_init(struct udevice *dev)
 {
 	struct am65_cpsw_priv *priv = dev_get_priv(dev);
-	struct am65_cpsw_common *cpsw_common = priv->cpsw_common;
 	struct eth_pdata *pdata = dev_get_plat(dev);
 	struct phy_device *phydev;
 	u32 supported = PHY_GBIT_FEATURES;
 	int ret;
 
-	phydev = phy_connect(cpsw_common->bus,
-			     priv->phy_addr,
-			     priv->dev,
-			     pdata->phy_interface);
-
+	phydev = dm_eth_phy_connect(dev);
 	if (!phydev) {
 		dev_err(dev, "phy_connect() failed\n");
 		return -ENODEV;
@@ -740,13 +630,10 @@ static int am65_cpsw_phy_init(struct udevice *dev)
 	}
 	phydev->advertising = phydev->supported;
 
-	if (ofnode_valid(priv->phy_node))
-		phydev->node = priv->phy_node;
-
 	priv->phydev = phydev;
 	ret = phy_config(phydev);
 	if (ret < 0)
-		pr_err("phy_config() failed: %d", ret);
+		dev_err(dev, "phy_config() failed: %d", ret);
 
 	return ret;
 }
@@ -755,8 +642,6 @@ static int am65_cpsw_ofdata_parse_phy(struct udevice *dev)
 {
 	struct eth_pdata *pdata = dev_get_plat(dev);
 	struct am65_cpsw_priv *priv = dev_get_priv(dev);
-	struct ofnode_phandle_args out_args;
-	int ret = 0;
 
 	dev_read_u32(dev, "reg", &priv->port_id);
 
@@ -771,28 +656,7 @@ static int am65_cpsw_ofdata_parse_phy(struct udevice *dev)
 		dev_err(dev, "Port %u speed froced to %uMbit\n",
 			priv->port_id, pdata->max_speed);
 
-	priv->has_phy  = true;
-	ret = ofnode_parse_phandle_with_args(dev_ofnode(dev), "phy-handle",
-					     NULL, 0, 0, &out_args);
-	if (ret) {
-		dev_err(dev, "can't parse phy-handle port %u (%d)\n",
-			priv->port_id, ret);
-		priv->has_phy  = false;
-		ret = 0;
-	}
-
-	priv->phy_node = out_args.node;
-	if (priv->has_phy) {
-		ret = ofnode_read_u32(priv->phy_node, "reg", &priv->phy_addr);
-		if (ret) {
-			dev_err(dev, "failed to get phy_addr port %u (%d)\n",
-				priv->port_id, ret);
-			goto out;
-		}
-	}
-
-out:
-	return ret;
+	return 0;
 }
 
 static int am65_cpsw_port_probe(struct udevice *dev)
@@ -811,10 +675,6 @@ static int am65_cpsw_port_probe(struct udevice *dev)
 	sprintf(portname, "%s%s", dev->parent->name, dev->name);
 	device_set_name(dev, portname);
 
-	priv->mdio_manual_mode = false;
-	if (soc_device_match(k3_mdio_soc_data))
-		priv->mdio_manual_mode = true;
-
 	ret = am65_cpsw_ofdata_parse_phy(dev);
 	if (ret)
 		goto out;
@@ -823,13 +683,8 @@ static int am65_cpsw_port_probe(struct udevice *dev)
 	if (ret)
 		goto out;
 
-	ret = am65_cpsw_mdio_init(dev);
-	if (ret)
-		goto out;
-
 	ret = am65_cpsw_phy_init(dev);
-	if (ret)
-		goto out;
+
 out:
 	return ret;
 }
@@ -837,7 +692,7 @@ out:
 static int am65_cpsw_probe_nuss(struct udevice *dev)
 {
 	struct am65_cpsw_common *cpsw_common = dev_get_priv(dev);
-	ofnode ports_np, node, mdio_np;
+	ofnode ports_np, node;
 	int ret, i;
 	struct udevice *port_dev;
 
@@ -862,25 +717,6 @@ static int am65_cpsw_probe_nuss(struct udevice *dev)
 	cpsw_common->cpsw_base = cpsw_common->ss_base + AM65_CPSW_CPSW_NU_BASE;
 	cpsw_common->ale_base = cpsw_common->cpsw_base +
 				AM65_CPSW_CPSW_NU_ALE_BASE;
-	cpsw_common->mdio_base = cpsw_common->ss_base + AM65_CPSW_MDIO_BASE;
-
-	if (IS_ENABLED(CONFIG_DM_GPIO)) {
-		/* get bus level PHY reset GPIO details */
-		mdio_np = dev_read_subnode(dev, "mdio");
-		if (!ofnode_valid(mdio_np)) {
-			ret = -ENOENT;
-			goto out;
-		}
-
-		cpsw_common->reset_delay_us = ofnode_read_u32_default(mdio_np, "reset-delay-us",
-								      DEFAULT_GPIO_RESET_DELAY);
-		cpsw_common->reset_post_delay_us = ofnode_read_u32_default(mdio_np,
-									   "reset-post-delay-us",
-									   0);
-		ret = gpio_request_by_name_nodev(mdio_np, "reset-gpios", 0,
-						 &cpsw_common->mdio_gpio_reset,
-						 GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
-	}
 
 	ports_np = dev_read_subnode(dev, "ethernet-ports");
 	if (!ofnode_valid(ports_np)) {
@@ -940,12 +776,11 @@ static int am65_cpsw_probe_nuss(struct udevice *dev)
 			dev_read_u32_default(dev, "bus_freq",
 					     AM65_CPSW_MDIO_BUS_FREQ_DEF);
 
-	dev_info(dev, "K3 CPSW: nuss_ver: 0x%08X cpsw_ver: 0x%08X ale_ver: 0x%08X Ports:%u mdio_freq:%u\n",
+	dev_info(dev, "K3 CPSW: nuss_ver: 0x%08X cpsw_ver: 0x%08X ale_ver: 0x%08X Ports:%u\n",
 		 readl(cpsw_common->ss_base),
 		 readl(cpsw_common->cpsw_base),
 		 readl(cpsw_common->ale_base),
-		 cpsw_common->port_num,
-		 cpsw_common->bus_freq);
+		 cpsw_common->port_num);
 
 out:
 	power_domain_free(&cpsw_common->pwrdmn);
@@ -976,14 +811,3 @@ U_BOOT_DRIVER(am65_cpsw_nuss_port) = {
 	.plat_auto	= sizeof(struct eth_pdata),
 	.flags = DM_FLAG_ALLOC_PRIV_DMA | DM_FLAG_OS_PREPARE,
 };
-
-static const struct udevice_id am65_cpsw_mdio_ids[] = {
-	{ .compatible = "ti,cpsw-mdio" },
-	{ }
-};
-
-U_BOOT_DRIVER(am65_cpsw_mdio) = {
-	.name		= "am65_cpsw_mdio",
-	.id		= UCLASS_MDIO,
-	.of_match	= am65_cpsw_mdio_ids,
-};
diff --git a/drivers/net/ti/cpsw_mdio.c b/drivers/net/ti/cpsw_mdio.c
index 74cc956785..f1b1eba75d 100644
--- a/drivers/net/ti/cpsw_mdio.c
+++ b/drivers/net/ti/cpsw_mdio.c
@@ -5,11 +5,15 @@
  * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
  */
 
+#include <clk.h>
 #include <common.h>
+#include <dm/device_compat.h>
 #include <log.h>
 #include <malloc.h>
+#include <phy.h>
 #include <asm/io.h>
 #include <miiphy.h>
+#include <soc.h>
 #include <wait_bit.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
@@ -22,6 +26,7 @@ struct cpsw_mdio_regs {
 #define CONTROL_FAULT		BIT(19)
 #define CONTROL_FAULT_ENABLE	BIT(18)
 #define CONTROL_DIV_MASK	GENMASK(15, 0)
+#define CONTROL_MAX_DIV		CONTROL_DIV_MASK
 
 #define MDIO_MAN_MDCLK_O        BIT(2)
 #define MDIO_MAN_OE             BIT(1)
@@ -72,6 +77,8 @@ struct cpsw_mdio_regs {
  */
 #define CPSW_MDIO_TIMEOUT            100 /* msecs */
 
+#define CPSW_MDIO_DEF_BUS_FREQ		2200000 /* 2.2 MHz */
+
 enum cpsw_mdio_manual {
 	MDIO_PIN = 0,
 	MDIO_OE,
@@ -82,8 +89,35 @@ struct cpsw_mdio {
 	struct cpsw_mdio_regs *regs;
 	struct mii_dev *bus;
 	int div;
+	bool manual_mode;
+	struct clk clk;
+	unsigned long bus_freq;
 };
 
+static int cpsw_mdio_enable(struct cpsw_mdio *data)
+{
+	int ret;
+
+	/* set enable and clock divider */
+	writel(data->div | CONTROL_ENABLE, &data->regs->control);
+	ret = wait_for_bit_le32(&data->regs->control,
+				CONTROL_IDLE, false, CPSW_MDIO_TIMEOUT, true);
+	if (ret)
+		return ret;
+
+	/*
+	 * wait for scan logic to settle:
+	 * the scan time consists of (a) a large fixed component, and (b) a
+	 * small component that varies with the mii bus frequency.  These
+	 * were estimated using measurements at 1.1 and 2.2 MHz on tnetv107x
+	 * silicon.  Since the effect of (b) was found to be largely
+	 * negligible, we keep things simple here.
+	 */
+	mdelay(1);
+
+	return 0;
+}
+
 static void cpsw_mdio_disable(struct cpsw_mdio *mdio)
 {
 	u32 reg;
@@ -206,10 +240,16 @@ static void cpsw_mdio_sw_preamble(struct cpsw_mdio *mdio)
 	}
 }
 
+#if defined(CONFIG_DM_MDIO)
+#define MII_TO_CPSW_MDIO(bus)	(dev_get_priv((struct udevice *)(bus)->priv))
+#else
+#define MII_TO_CPSW_MDIO(bus)	((bus)->priv)
+#endif
+
 static int cpsw_mdio_sw_read(struct mii_dev *bus, int phy_id,
 			     int dev_addr, int phy_reg)
 {
-	struct cpsw_mdio *mdio = bus->priv;
+	struct cpsw_mdio *mdio = MII_TO_CPSW_MDIO(bus);
 	u32 reg, i;
 	u8 ack;
 
@@ -266,7 +306,7 @@ static int cpsw_mdio_sw_read(struct mii_dev *bus, int phy_id,
 static int cpsw_mdio_sw_write(struct mii_dev *bus, int phy_id,
 			      int dev_addr, int phy_reg, u16 phy_data)
 {
-	struct cpsw_mdio *mdio = bus->priv;
+	struct cpsw_mdio *mdio = MII_TO_CPSW_MDIO(bus);
 
 	if ((phy_reg & ~PHY_REG_MASK) || (phy_id & ~PHY_ID_MASK))
 		return -EINVAL;
@@ -316,7 +356,7 @@ static int cpsw_mdio_wait_for_user_access(struct cpsw_mdio *mdio)
 static int cpsw_mdio_read(struct mii_dev *bus, int phy_id,
 			  int dev_addr, int phy_reg)
 {
-	struct cpsw_mdio *mdio = bus->priv;
+	struct cpsw_mdio *mdio = MII_TO_CPSW_MDIO(bus);
 	int data, ret;
 	u32 reg;
 
@@ -342,7 +382,7 @@ static int cpsw_mdio_read(struct mii_dev *bus, int phy_id,
 static int cpsw_mdio_write(struct mii_dev *bus, int phy_id, int dev_addr,
 			   int phy_reg, u16 data)
 {
-	struct cpsw_mdio *mdio = bus->priv;
+	struct cpsw_mdio *mdio = MII_TO_CPSW_MDIO(bus);
 	u32 reg;
 	int ret;
 
@@ -361,9 +401,10 @@ static int cpsw_mdio_write(struct mii_dev *bus, int phy_id, int dev_addr,
 	return cpsw_mdio_wait_for_user_access(mdio);
 }
 
+#if !defined(CONFIG_MDIO_TI_CPSW)
 u32 cpsw_mdio_get_alive(struct mii_dev *bus)
 {
-	struct cpsw_mdio *mdio = bus->priv;
+	struct cpsw_mdio *mdio = MII_TO_CPSW_MDIO(bus);
 	u32 val;
 
 	val = readl(&mdio->regs->alive);
@@ -396,22 +437,11 @@ struct mii_dev *cpsw_mdio_init(const char *name, phys_addr_t mdio_base,
 	else
 		cpsw_mdio->div = (fck_freq / bus_freq) - 1;
 	cpsw_mdio->div &= CONTROL_DIV_MASK;
-
-	/* set enable and clock divider */
-	writel(cpsw_mdio->div | CONTROL_ENABLE | CONTROL_FAULT |
-	       CONTROL_FAULT_ENABLE, &cpsw_mdio->regs->control);
-	wait_for_bit_le32(&cpsw_mdio->regs->control,
-			  CONTROL_IDLE, false, CPSW_MDIO_TIMEOUT, true);
-
-	/*
-	 * wait for scan logic to settle:
-	 * the scan time consists of (a) a large fixed component, and (b) a
-	 * small component that varies with the mii bus frequency.  These
-	 * were estimated using measurements at 1.1 and 2.2 MHz on tnetv107x
-	 * silicon.  Since the effect of (b) was found to be largely
-	 * negligible, we keep things simple here.
-	 */
-	mdelay(1);
+	ret = cpsw_mdio_enable(cpsw_mdio);
+	if (ret) {
+		debug("mdio_enable failed: %d\n", ret);
+		goto free_bus;
+	}
 
 	if (manual_mode) {
 		cpsw_mdio->bus->read = cpsw_mdio_sw_read;
@@ -452,3 +482,129 @@ void cpsw_mdio_free(struct mii_dev *bus)
 	mdio_free(bus);
 	free(mdio);
 }
+
+#else
+
+static int cpsw_mdio_init_clk(struct cpsw_mdio *data)
+{
+	u32 mdio_in, div;
+
+	mdio_in = clk_get_rate(&data->clk);
+	div = (mdio_in / data->bus_freq) - 1;
+	if (div > CONTROL_MAX_DIV)
+		div = CONTROL_MAX_DIV;
+
+	data->div = div;
+	return cpsw_mdio_enable(data);
+}
+
+static int cpsw_mdio_bus_read(struct udevice *dev, int addr,
+			      int devad, int reg)
+{
+	struct mdio_perdev_priv *pdata = (dev) ? dev_get_uclass_priv(dev) :
+						 NULL;
+	struct cpsw_mdio *priv = dev_get_priv(dev);
+
+	if (pdata && pdata->mii_bus) {
+		if (priv->manual_mode)
+			return cpsw_mdio_sw_read(pdata->mii_bus, addr, devad, reg);
+		else
+			return cpsw_mdio_read(pdata->mii_bus, addr, devad, reg);
+	}
+
+	return -1;
+}
+
+static int cpsw_mdio_bus_write(struct udevice *dev, int addr,
+			       int devad, int reg, u16 val)
+{
+	struct mdio_perdev_priv *pdata = (dev) ? dev_get_uclass_priv(dev) :
+						 NULL;
+	struct cpsw_mdio *priv = dev_get_priv(dev);
+
+	if (pdata && pdata->mii_bus) {
+		if (priv->manual_mode)
+			return cpsw_mdio_sw_write(pdata->mii_bus, addr, devad, reg, val);
+		else
+			return cpsw_mdio_write(pdata->mii_bus, addr, devad, reg, val);
+	}
+
+	return -1;
+}
+
+static const struct mdio_ops cpsw_mdio_ops = {
+	.read = cpsw_mdio_bus_read,
+	.write = cpsw_mdio_bus_write,
+};
+
+static const struct soc_attr k3_mdio_soc_data[] = {
+	{ .family = "AM62X", .revision = "SR1.0" },
+	{ .family = "AM64X", .revision = "SR1.0" },
+	{ .family = "AM64X", .revision = "SR2.0" },
+	{ .family = "AM65X", .revision = "SR1.0" },
+	{ .family = "AM65X", .revision = "SR2.0" },
+	{ .family = "J7200", .revision = "SR1.0" },
+	{ .family = "J7200", .revision = "SR2.0" },
+	{ .family = "J721E", .revision = "SR1.0" },
+	{ .family = "J721E", .revision = "SR1.1" },
+	{ .family = "J721S2", .revision = "SR1.0" },
+	{ /* sentinel */ },
+};
+
+static const struct udevice_id cpsw_mdio_ids[] = {
+	{ .compatible = "ti,davinci_mdio", },
+	{ .compatible = "ti,cpsw-mdio", },
+	{ /* sentinel */ },
+};
+
+static int cpsw_mdio_probe(struct udevice *dev)
+{
+	struct cpsw_mdio *priv = dev_get_priv(dev);
+	int ret;
+
+	if (!priv) {
+		dev_err(dev, "dev_get_priv(dev %p) = NULL\n", dev);
+		return -ENOMEM;
+	}
+
+	priv->regs = dev_remap_addr(dev);
+
+	if (soc_device_match(k3_mdio_soc_data))
+		priv->manual_mode = true;
+
+	ret = clk_get_by_name(dev, "fck", &priv->clk);
+	if (ret) {
+		dev_err(dev, "failed to get clock %d\n", ret);
+		return ret;
+	}
+
+	priv->bus_freq = dev_read_u32_default(dev, "bus_freq",
+					      CPSW_MDIO_DEF_BUS_FREQ);
+	ret = cpsw_mdio_init_clk(priv);
+	if (ret) {
+		dev_err(dev, "init clock failed: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int cpsw_mdio_remove(struct udevice *dev)
+{
+	struct cpsw_mdio *priv = dev_get_priv(dev);
+
+	cpsw_mdio_disable(priv);
+
+	return 0;
+}
+
+U_BOOT_DRIVER(cpsw_mdio) = {
+	.name = "cpsw_mdio",
+	.id = UCLASS_MDIO,
+	.of_match = cpsw_mdio_ids,
+	.probe = cpsw_mdio_probe,
+	.remove = cpsw_mdio_remove,
+	.ops = &cpsw_mdio_ops,
+	.priv_auto = sizeof(struct cpsw_mdio),
+};
+#endif /* CONFIG_MDIO_TI_CPSW */
diff --git a/drivers/net/ti/cpsw_mdio.h b/drivers/net/ti/cpsw_mdio.h
index ddf65a4686..240c972d69 100644
--- a/drivers/net/ti/cpsw_mdio.h
+++ b/drivers/net/ti/cpsw_mdio.h
@@ -10,9 +10,11 @@
 
 struct cpsw_mdio;
 
+#if !defined(CONFIG_MDIO_TI_CPSW)
 struct mii_dev *cpsw_mdio_init(const char *name, phys_addr_t mdio_base,
 			       u32 bus_freq, int fck_freq, bool manual_mode);
 void cpsw_mdio_free(struct mii_dev *bus);
 u32 cpsw_mdio_get_alive(struct mii_dev *bus);
+#endif /* CONFIG_MDIO_TI_CPSW */
 
 #endif /* CPSW_MDIO_H_ */

-- 
2.34.1

