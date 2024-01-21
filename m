Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F245C47422
	for <u-boot@archiver.kernel.org>; Sun, 21 Jan 2024 17:30:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 518888777F;
	Sun, 21 Jan 2024 18:30:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="OelzCR9+";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="pO6L6VSI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA705877F4; Sun, 21 Jan 2024 18:30:29 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE1088773D
 for <u-boot@lists.denx.de>; Sun, 21 Jan 2024 18:30:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4TJ0jv38LKz9sks;
 Sun, 21 Jan 2024 18:30:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1705858227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=wNq97WP7Lkf+06jKBmepE7SmUn5YcCINMfwezqReLWs=;
 b=OelzCR9+s6WOm4HNQfpOyQEMUeYsWjisFN3/JqV2RtQaVIESXNxFm+BzXuQ/W9dcxLorS2
 slQxv3/KhW76pLmyuyDwxhbBln+hcKESQ3OO8Kt3OZxCmI1ds+2hTF+jvlc+An77RPXpxL
 c1n+oWrHnFbyPttVCXfHWXEIL3URlmvt2Z9/5cgb0du9x9k3hrj/wDHII40YOoFwXtfRq0
 fkUtwf/PP5xRaGqaHWaDyhO52Fgt66/hQEciQwB9B+yHFm/n83XDUUpYFyHy9PAyrzG3CH
 2YNVezV6HC87Gnl0VmpkIGtbM5AhQW7bBnMV18O1AmOUGZQUJyf0f7+IiTsocw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1705858225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=wNq97WP7Lkf+06jKBmepE7SmUn5YcCINMfwezqReLWs=;
 b=pO6L6VSIRgLnxhrL0zeBa5W1YUu85oylrHXDfVcyzjBSViJNScYz6sn9vMmPTgiNEKgf+D
 1wYJhE8GRFWEciTnJiG0jkIAEBaHOa1HGf6RXGk5/U5Q4R+UFj6dmGVATvjPkyMz5V1Zxd
 AlXx/3xhVZVURe/o8rd6viGLEXdjRX+b7q4sHu7Yv5yFNxFzVqo/FdGmo8jWJWmTo3/Kcl
 7dXe7vGmlVegZm0WtnrK+O3wIDXYjl0DE4mfQP4UKr5FetKjynniy4/j/A28fPFzoo4xI+
 qQHfqORuAFLyMDC1zeo6DZlEsJ9k1k/NOLkmRPGKY5BeG/mf/RdWsHB8lXTU4w==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH 1/3] net: phy: Make eth_phy_get_addr() generic
Date: Sun, 21 Jan 2024 18:29:33 +0100
Message-ID: <20240121173006.273629-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 9dc165222c0fc0b0f90
X-MBO-RS-META: jkc5e8e68c4wmp6rto1k45ghmtcio5oc
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

Move eth_phy_get_addr() from drivers/net/eth-phy-uclass.c to
drivers/net/phy/phy.c . The eth_phy_get_addr() code is generic
and does not depend on DM_ETH_PHY , make it always available.

The dm/device_compat.h is pulled in to make dev_dbg() available.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
---
 drivers/net/eth-phy-uclass.c | 16 ----------------
 drivers/net/phy/phy.c        | 25 +++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/net/eth-phy-uclass.c b/drivers/net/eth-phy-uclass.c
index 9d1e8d38ffa..237c3b7de15 100644
--- a/drivers/net/eth-phy-uclass.c
+++ b/drivers/net/eth-phy-uclass.c
@@ -109,22 +109,6 @@ struct mii_dev *eth_phy_get_mdio_bus(struct udevice *eth_dev)
 	return NULL;
 }
 
-int eth_phy_get_addr(struct udevice *dev)
-{
-	struct ofnode_phandle_args phandle_args;
-	int reg;
-
-	if (dev_read_phandle_with_args(dev, "phy-handle", NULL, 0, 0,
-				       &phandle_args)) {
-		dev_dbg(dev, "Failed to find phy-handle");
-		return -ENODEV;
-	}
-
-	reg = ofnode_read_u32_default(phandle_args.node, "reg", 0);
-
-	return reg;
-}
-
 /* parsing generic properties of devicetree/bindings/net/ethernet-phy.yaml */
 static int eth_phy_of_to_plat(struct udevice *dev)
 {
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 63b3e46f101..0d1a98bbbca 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -18,6 +18,7 @@
 #include <phy.h>
 #include <errno.h>
 #include <asm/global_data.h>
+#include <dm/device_compat.h>
 #include <dm/of_extra.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
@@ -28,6 +29,30 @@ DECLARE_GLOBAL_DATA_PTR;
 
 /* Generic PHY support and helper functions */
 
+/**
+ * eth_phy_get_addr - get PHY MDIO address from DT
+ * @dev: the udevice struct of the MAC
+ *
+ * Return PHY MDIO address read out of a PHY DT node "reg" property.
+ * The PHY DT node is located by resolving MAC "phy-handle" property.
+ * Returns PHY MDIO address on success, negative on failure.
+ */
+int eth_phy_get_addr(struct udevice *dev)
+{
+	struct ofnode_phandle_args phandle_args;
+	int reg;
+
+	if (dev_read_phandle_with_args(dev, "phy-handle", NULL, 0, 0,
+				       &phandle_args)) {
+		dev_dbg(dev, "Failed to find phy-handle");
+		return -ENODEV;
+	}
+
+	reg = ofnode_read_u32_default(phandle_args.node, "reg", 0);
+
+	return reg;
+}
+
 /**
  * genphy_config_advert - sanitize and advertise auto-negotiation parameters
  * @phydev: target phy_device struct
-- 
2.43.0

