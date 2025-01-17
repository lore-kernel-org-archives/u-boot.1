Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E202FC02185
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 14:11:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F8958078B;
	Fri, 17 Jan 2025 15:10:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="LX/Xnk7D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0005480312; Fri, 17 Jan 2025 07:48:37 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6893D8069D
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 07:48:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737096516; x=1768632516;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MJ5ChJkWYXnCVn9EQRDhSisJ/99udz6GPqESuwI+DEE=;
 b=LX/Xnk7DAmiysJoXnugx2MGyo62g9Q598JQvkLyZDRCczVJ8ZAJPOPxA
 3S+/yPK/1ivkCsTV8XJj/cih07Gx7yDgzzvXsEEcJPdci0xzE4027yhjt
 Lg7JLZ1v9o1UMJmbryErsSDaTUvmEtA7RA8v7k6GnBl3p4SO2S9MzLviZ
 zqKViXsBXkKcFe/7kKKoJf28F6QTE7EKjQS66omGnNjhwkPCxzbgDCQdq
 6MBXxJwYiuVw4KSBgfnSTW+SmCaYNa6hG8cANQ27no+v3MfvOwlW7ciu3
 25MfzxXhIfExWHOYIdwzRZG8wDbQLOWMG/I7ipWqWmU+g4gxdeIbIIaB2 g==;
X-CSE-ConnectionGUID: zD4glPeRR5GB5jf5wa6/pw==
X-CSE-MsgGUID: JxP5fakQQPONpcl8cCYj6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="41451388"
X-IronPort-AV: E=Sophos;i="6.13,211,1732608000"; d="scan'208";a="41451388"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2025 22:48:35 -0800
X-CSE-ConnectionGUID: GqSCVeKhRaWf8WJtpp5xvA==
X-CSE-MsgGUID: tYUv8Rp5RaC+AF+mPfZSuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="143009856"
Received: from apgcp0d551112.png.altera.com ([10.244.77.50])
 by orviesa001.jf.intel.com with ESMTP; 16 Jan 2025 22:48:31 -0800
From: Boon Khai Ng <boon.khai.ng@intel.com>
To: Uboot Open List <u-boot@lists.denx.de>
Cc: Tien Fong Chee <tien.fong.chee@intel.com>,
 Kok Kiang Hea <kok.kiang.hea@intel.com>,
 Dinesh Maniyam <dinesh.maniyam@intel.com>,
 Alif Zakuan <alif.zakuan.yuslaimi@intel.com>,
 Muhammad Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan <alif.zakuan.yuslaimi@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Muhammad Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Boon Khai Ng <boon.khai.ng@intel.com>
Subject: [XGMAC error message v1 1/1] net: dwc_eth_xgmac: Add device name for
 the error message.
Date: Fri, 17 Jan 2025 14:48:23 +0800
Message-Id: <20250117064823.23512-2-boon.khai.ng@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250117064823.23512-1-boon.khai.ng@intel.com>
References: <20250117064823.23512-1-boon.khai.ng@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 17 Jan 2025 15:10:26 +0100
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

Agilex5 having several ethernet instance, adding the device
name at the error message to differentiate between which
instance is having issue.

Signed-off-by: Boon Khai Ng <boon.khai.ng@intel.com>
---
 drivers/net/dwc_eth_xgmac.c | 82 +++++++++++++++++++++++--------------
 1 file changed, 52 insertions(+), 30 deletions(-)

diff --git a/drivers/net/dwc_eth_xgmac.c b/drivers/net/dwc_eth_xgmac.c
index d3e5f9255f..cf8227b1b4 100644
--- a/drivers/net/dwc_eth_xgmac.c
+++ b/drivers/net/dwc_eth_xgmac.c
@@ -152,7 +152,9 @@ static int xgmac_mdio_read(struct mii_dev *bus, int mdio_addr, int mdio_devad,
 
 	ret = xgmac_mdio_wait_idle(xgmac);
 	if (ret) {
-		pr_err("MDIO not idle at entry: %d\n", ret);
+		pr_err("%s MDIO not idle at entry: %d\n",
+		       xgmac->dev->name, ret);
+
 		return ret;
 	}
 
@@ -172,7 +174,9 @@ static int xgmac_mdio_read(struct mii_dev *bus, int mdio_addr, int mdio_devad,
 
 	ret = xgmac_mdio_wait_idle(xgmac);
 	if (ret) {
-		pr_err("MDIO not idle at entry: %d\n", ret);
+		pr_err("%s MDIO not idle at entry: %d\n",
+		       xgmac->dev->name, ret);
+
 		return ret;
 	}
 
@@ -181,7 +185,9 @@ static int xgmac_mdio_read(struct mii_dev *bus, int mdio_addr, int mdio_devad,
 
 	ret = xgmac_mdio_wait_idle(xgmac);
 	if (ret) {
-		pr_err("MDIO read didn't complete: %d\n", ret);
+		pr_err("%s MDIO read didn't complete: %d\n",
+		       xgmac->dev->name, ret);
+
 		return ret;
 	}
 
@@ -206,7 +212,9 @@ static int xgmac_mdio_write(struct mii_dev *bus, int mdio_addr, int mdio_devad,
 
 	ret = xgmac_mdio_wait_idle(xgmac);
 	if (ret) {
-		pr_err("MDIO not idle at entry: %d\n", ret);
+		pr_err("%s MDIO not idle at entry: %d\n",
+		       xgmac->dev->name, ret);
+
 		return ret;
 	}
 
@@ -229,7 +237,9 @@ static int xgmac_mdio_write(struct mii_dev *bus, int mdio_addr, int mdio_devad,
 
 	ret = xgmac_mdio_wait_idle(xgmac);
 	if (ret) {
-		pr_err("MDIO not idle at entry: %d\n", ret);
+		pr_err("%s MDIO not idle at entry: %d\n",
+		       xgmac->dev->name, ret);
+
 		return ret;
 	}
 
@@ -238,7 +248,9 @@ static int xgmac_mdio_write(struct mii_dev *bus, int mdio_addr, int mdio_devad,
 
 	ret = xgmac_mdio_wait_idle(xgmac);
 	if (ret) {
-		pr_err("MDIO write didn't complete: %d\n", ret);
+		pr_err("%s MDIO write didn't complete: %d\n",
+		       xgmac->dev->name, ret);
+
 		return ret;
 	}
 
@@ -323,7 +335,7 @@ static int xgmac_adjust_link(struct udevice *dev)
 	else
 		ret = xgmac_set_half_duplex(dev);
 	if (ret < 0) {
-		pr_err("xgmac_set_*_duplex() failed: %d\n", ret);
+		pr_err("%s xgmac_set_*_duplex() failed: %d\n", dev->name, ret);
 		return ret;
 	}
 
@@ -341,26 +353,28 @@ static int xgmac_adjust_link(struct udevice *dev)
 		ret = xgmac_set_mii_speed_10(dev);
 		break;
 	default:
-		pr_err("invalid speed %d\n", xgmac->phy->speed);
+		pr_err("%s invalid speed %d\n", dev->name, xgmac->phy->speed);
 		return -EINVAL;
 	}
 	if (ret < 0) {
-		pr_err("xgmac_set_*mii_speed*() failed: %d\n", ret);
+		pr_err("%s xgmac_set_*mii_speed*() failed: %d\n", dev->name, ret);
 		return ret;
 	}
 
 	if (en_calibration) {
 		ret = xgmac->config->ops->xgmac_calibrate_pads(dev);
 		if (ret < 0) {
-			pr_err("xgmac_calibrate_pads() failed: %d\n",
-			       ret);
+			pr_err("%s xgmac_calibrate_pads() failed: %d\n",
+			       dev->name, ret);
+
 			return ret;
 		}
 	} else {
 		ret = xgmac->config->ops->xgmac_disable_calibration(dev);
 		if (ret < 0) {
-			pr_err("xgmac_disable_calibration() failed: %d\n",
-			       ret);
+			pr_err("%s xgmac_disable_calibration() failed: %d\n",
+			       dev->name, ret);
+
 			return ret;
 		}
 	}
@@ -456,7 +470,7 @@ static int xgmac_start(struct udevice *dev)
 
 	ret = xgmac->config->ops->xgmac_start_resets(dev);
 	if (ret < 0) {
-		pr_err("xgmac_start_resets() failed: %d\n", ret);
+		pr_err("%s xgmac_start_resets() failed: %d\n", dev->name, ret);
 		goto err;
 	}
 
@@ -466,13 +480,13 @@ static int xgmac_start(struct udevice *dev)
 				XGMAC_DMA_MODE_SWR, false,
 				xgmac->config->swr_wait, false);
 	if (ret) {
-		pr_err("XGMAC_DMA_MODE_SWR stuck: %d\n", ret);
+		pr_err("%s XGMAC_DMA_MODE_SWR stuck: %d\n", dev->name, ret);
 		goto err_stop_resets;
 	}
 
 	ret = xgmac->config->ops->xgmac_calibrate_pads(dev);
 	if (ret < 0) {
-		pr_err("xgmac_calibrate_pads() failed: %d\n", ret);
+		pr_err("%s xgmac_calibrate_pads() failed: %d\n", dev->name, ret);
 		goto err_stop_resets;
 	}
 
@@ -485,14 +499,16 @@ static int xgmac_start(struct udevice *dev)
 		xgmac->phy = phy_connect(xgmac->mii, addr, dev,
 					 xgmac->config->interface(dev));
 		if (!xgmac->phy) {
-			pr_err("phy_connect() failed\n");
+			pr_err("%s phy_connect() failed\n", dev->name);
 			goto err_stop_resets;
 		}
 
 		if (xgmac->max_speed) {
 			ret = phy_set_supported(xgmac->phy, xgmac->max_speed);
 			if (ret) {
-				pr_err("phy_set_supported() failed: %d\n", ret);
+				pr_err("%s phy_set_supported() failed: %d\n",
+				       dev->name, ret);
+
 				goto err_shutdown_phy;
 			}
 		}
@@ -500,25 +516,25 @@ static int xgmac_start(struct udevice *dev)
 		xgmac->phy->node = xgmac->phy_of_node;
 		ret = phy_config(xgmac->phy);
 		if (ret < 0) {
-			pr_err("phy_config() failed: %d\n", ret);
+			pr_err("%s phy_config() failed: %d\n", dev->name, ret);
 			goto err_shutdown_phy;
 		}
 	}
 
 	ret = phy_startup(xgmac->phy);
 	if (ret < 0) {
-		pr_err("phy_startup() failed: %d\n", ret);
+		pr_err("%s phy_startup() failed: %d\n", dev->name, ret);
 		goto err_shutdown_phy;
 	}
 
 	if (!xgmac->phy->link) {
-		pr_err("No link\n");
+		pr_err("%s No link\n", dev->name);
 		goto err_shutdown_phy;
 	}
 
 	ret = xgmac_adjust_link(dev);
 	if (ret < 0) {
-		pr_err("xgmac_adjust_link() failed: %d\n", ret);
+		pr_err("%s xgmac_adjust_link() failed: %d\n", dev->name, ret);
 		goto err_shutdown_phy;
 	}
 
@@ -611,7 +627,7 @@ static int xgmac_start(struct udevice *dev)
 
 	ret = xgmac_write_hwaddr(dev);
 	if (ret < 0) {
-		pr_err("xgmac_write_hwaddr() failed: %d\n", ret);
+		pr_err("%s xgmac_write_hwaddr() failed: %d\n", dev->name, ret);
 		goto err;
 	}
 
@@ -738,7 +754,7 @@ err_shutdown_phy:
 err_stop_resets:
 	xgmac->config->ops->xgmac_stop_resets(dev);
 err:
-	pr_err("FAILED: %d\n", ret);
+	pr_err("%s FAILED: %d\n", dev->name, ret);
 	return ret;
 }
 
@@ -1047,7 +1063,7 @@ static int xgmac_probe(struct udevice *dev)
 
 	xgmac->regs = dev_read_addr(dev);
 	if (xgmac->regs == FDT_ADDR_T_NONE) {
-		pr_err("dev_read_addr() failed\n");
+		pr_err("%s dev_read_addr() failed\n", dev->name);
 		return -ENODEV;
 	}
 	xgmac->mac_regs = (void *)(xgmac->regs + XGMAC_MAC_REGS_BASE);
@@ -1058,19 +1074,23 @@ static int xgmac_probe(struct udevice *dev)
 
 	ret = xgmac_probe_resources_core(dev);
 	if (ret < 0) {
-		pr_err("xgmac_probe_resources_core() failed: %d\n", ret);
+		pr_err("%s xgmac_probe_resources_core() failed: %d\n",
+		       dev->name, ret);
+
 		return ret;
 	}
 
 	ret = xgmac->config->ops->xgmac_probe_resources(dev);
 	if (ret < 0) {
-		pr_err("xgmac_probe_resources() failed: %d\n", ret);
+		pr_err("%s xgmac_probe_resources() failed: %d\n",
+		       dev->name, ret);
+
 		goto err_remove_resources_core;
 	}
 
 	ret = xgmac->config->ops->xgmac_start_clks(dev);
 	if (ret < 0) {
-		pr_err("xgmac_start_clks() failed: %d\n", ret);
+		pr_err("%s xgmac_start_clks() failed: %d\n", dev->name, ret);
 		return ret;
 	}
 
@@ -1080,7 +1100,7 @@ static int xgmac_probe(struct udevice *dev)
 	if (!xgmac->mii) {
 		xgmac->mii = mdio_alloc();
 		if (!xgmac->mii) {
-			pr_err("mdio_alloc() failed\n");
+			pr_err("%s mdio_alloc() failed\n", dev->name);
 			ret = -ENOMEM;
 			goto err_stop_clks;
 		}
@@ -1091,7 +1111,9 @@ static int xgmac_probe(struct udevice *dev)
 
 		ret = mdio_register(xgmac->mii);
 		if (ret < 0) {
-			pr_err("mdio_register() failed: %d\n", ret);
+			pr_err("%s mdio_register() failed: %d\n",
+			       dev->name, ret);
+
 			goto err_free_mdio;
 		}
 	}
-- 
2.26.2

