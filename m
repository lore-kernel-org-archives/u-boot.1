Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 353BEC54E41
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 13:25:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B7CE88052;
	Tue,  5 Mar 2024 14:25:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oamnUixF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5F4A8804C; Tue,  5 Mar 2024 14:25:12 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7699C87FA5
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 14:25:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 83DD6CE1AAB;
 Tue,  5 Mar 2024 13:25:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A3EC43394;
 Tue,  5 Mar 2024 13:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1709645106;
 bh=aED05VrAuXQy/0Phcc/T3V06d14uafvQRXfWYMt83FM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=oamnUixFVLAixmpqMb1bjKKsmoHZ0E0R97i8Ege5bwjV7TCdBgFhh3272ghsKlRKd
 a1OmWSQm/eoMRcm/zj6V2s300ctqh0blokGFmwb9hZwMl3V73z6m1XjZxwgifKT9Zc
 cWSYQRiIn0ylIp2Gp0CgK8hIDBNyNCPQBTVOCOlqOlpPvmlI9q/M1bDMFARgB7Qbm3
 tzBJs/Wl552TgCv4tW3IS8d/053h4Rg5ECcLz6gIxiyIXDj7IeBp5FwjAkqQb3xmUI
 c9UMPPzh2hUddClgW/Ln/JICt08ZsHzBR++ybWpJOwFxnFYEhQQJ2yI2H629s/bv36
 gX5llqsLw1yvg==
From: Roger Quadros <rogerq@kernel.org>
Date: Tue, 05 Mar 2024 15:24:53 +0200
Subject: [PATCH 1/5] net: mdio-uclass: Bind and probe generic Ethernet PHY
 driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-for-2024-07-beagleplay-eth-v1-1-e1294a575cc1@kernel.org>
References: <20240305-for-2024-07-beagleplay-eth-v1-0-e1294a575cc1@kernel.org>
In-Reply-To: <20240305-for-2024-07-beagleplay-eth-v1-0-e1294a575cc1@kernel.org>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 Wadim Egorov <w.egorov@phytec.de>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Simon Glass <sjg@chromium.org>
Cc: srk@ti.com, s-vadapalli@ti.com, vigneshr@ti.com, r-gunasekaran@ti.com, 
 danishanwar@ti.com, u-boot@lists.denx.de, Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2109; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=aED05VrAuXQy/0Phcc/T3V06d14uafvQRXfWYMt83FM=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBl5x0r7YMAPDe09iesFMeoVFMX8uk3x/D2KkM3+
 uOh9hhYMpqJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZecdKwAKCRDSWmvTvnYw
 k35cD/92goUGeknIJVsUdlhu70LC0CNDZzirNOxwtyg2YlDnM+HK/XrfcdU3ONEdCPU+zqX/byG
 aTm4HAC/4tQpbyziQ3WZbbWXyB3jFlFhJ87FQXSpqW0bpLVDPP1GviRGfFhDmr9yGRyvIr5w0i/
 MYBN0WJcTc2BoGbva0ipC1zx1jTDI59qZZZ2rVwfeiUNxGUvOParXxWwIGBKvenrgcXfunqjZyq
 O0PtYCb6fb+H13OvBS73Mx+7aZdjHUfiqj4U5Ix8X2HdzotRu8fnW6TGcKFfHBrNm1qJo/LyH5c
 zM1dCpliKY7L7dwe2UHBQXFCwALF1tUdz0hJGfiy/XFEyHle8taUuvDE4iSIX4AuFGZDO2GAj5O
 a3/fmv+uyMbmtrjFNBMUTDXaKfb0Jv3mQboXiLWYKaNLjtmQBDetODSksJvEuteoN0MQgHdY3SI
 aFdGePsnwPqeSj9hIqZOLhjq0Mf5xnrqlGBTq75+mZ5WHlJfuOrWWGsGMyEqcUxCoG1UWCCFx8t
 0q6JEccx/CReA0hxLOlYMOsmlBm0Q5H0npYJHLG4iZH1z/gB3x0TTYCtClJN/F879zVGGHyCOjZ
 ayPv+h8hbmazmQyQVIyIzPA4tKPxBdpsNk0x3tg+LyPH1aRh56y5WPOwXT2DGe6IDc9K4dmbG9w
 CVDN4crqu/Uz5aA==
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

If DM_ETH_PHY is enabled then try to bind and probe the
generic Ethernet PHY driver for each child of MDIO bus.

This is to ensure that GPIO reset handling is done if available
before MDIO bus driver scans for the PHYs.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 net/mdio-uclass.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/net/mdio-uclass.c b/net/mdio-uclass.c
index 6fc7034111..0ebfb2f134 100644
--- a/net/mdio-uclass.c
+++ b/net/mdio-uclass.c
@@ -6,6 +6,8 @@
 
 #include <common.h>
 #include <dm.h>
+#include <dm/lists.h>
+#include <eth_phy.h>
 #include <log.h>
 #include <malloc.h>
 #include <miiphy.h>
@@ -121,6 +123,42 @@ static int mdio_reset(struct mii_dev *mii_bus)
 	return dm_mdio_reset(mii_bus->priv);
 }
 
+static int mdio_bind_phy_nodes(struct udevice *mdio_dev)
+{
+	ofnode mdio_node, phy_node;
+	struct udevice *phy_dev;
+	const char *node_name;
+	int ret;
+
+	mdio_node = dev_ofnode(mdio_dev);
+	if (!ofnode_valid(mdio_node)) {
+		dev_dbg(mdio_dev, "invalid ofnode for mdio_dev\n");
+		return -ENXIO;
+	}
+
+	ofnode_for_each_subnode(phy_node, mdio_node) {
+		node_name = ofnode_get_name(phy_node);
+		dev_dbg(mdio_dev, "* Found child node: '%s'\n", node_name);
+		ret = device_bind_driver_to_node(mdio_dev,
+						 "eth_phy_generic_drv",
+						 node_name, phy_node, &phy_dev);
+		if (ret) {
+			dev_dbg(mdio_dev, "  - Eth phy binding error: %d\n", ret);
+			continue;
+		}
+
+		dev_dbg(mdio_dev, "  - bound phy device: '%s'\n", node_name);
+		ret = device_probe(phy_dev);
+		if (ret) {
+			dev_dbg(mdio_dev, "Device '%s' probe failed\n", phy_dev->name);
+			device_unbind(phy_dev);
+			continue;
+		}
+	}
+
+	return 0;
+}
+
 static int dm_mdio_post_probe(struct udevice *dev)
 {
 	struct mdio_perdev_priv *pdata = dev_get_uclass_priv(dev);
@@ -154,6 +192,9 @@ static int dm_mdio_post_probe(struct udevice *dev)
 		}
 	}
 
+	if (CONFIG_IS_ENABLED(DM_ETH_PHY))
+		mdio_bind_phy_nodes(dev);
+
 	return mdio_register(pdata->mii_bus);
 }
 

-- 
2.34.1

