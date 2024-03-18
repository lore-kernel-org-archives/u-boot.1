Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D22CC54E5D
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 14:57:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94EA287DEC;
	Mon, 18 Mar 2024 15:57:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jy60WQvt";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="UnGAlYk1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 818B087CB1; Mon, 18 Mar 2024 15:57:42 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 720A387A80
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 15:57:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4TyydJ1gwQz9skk;
 Mon, 18 Mar 2024 15:57:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710773860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=uxPZImsdcQbLNEr2n1EWlHqcr2vBRqVwKEWQ6fVfwYw=;
 b=jy60WQvtsQA0Vm6EwSjYmvKlO8q1m3JA7gbwhIkO11olSuqhoXE9f3KSi89AEOrRTC819r
 3IIH7wEBNuqYgd2VtubjO6pKSdTGcSQKuqe9yyrU65MZhxzcJbfd54uA4x3g2PO5ksXECQ
 Uc7skcDT+5mUJhdREpgKl7z7B4kpXSKP0dJzOSOZdnAzg0buGcfNf1hWPfp7fL6WpKcSFj
 w+e8d3MAochb0iv+PdROTiD7op+ajrHXpIzece/07NfKns8OObSpiUzjlnQpd3v1CIg3ol
 YovF/d+E+OQ645bFgmHNpbuLkZm+EStZLDM3Ah0uR2o2516tIfg0lUYFNQpOjw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710773858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=uxPZImsdcQbLNEr2n1EWlHqcr2vBRqVwKEWQ6fVfwYw=;
 b=UnGAlYk1MjpjfFYrH8pL6RFFJ/6N/xyuli/zfc8pR9pw3c4/JsfDDo2XGcTP9fYoZI6r7U
 XVgpP6cccoNv7iLBErskPtw3pzjLBZAazaAuC6NAAxvUsAO+lhEYcmwepwbiA5M4LUftWk
 UTxgsN/oQI6uV+97eI0ULl4QIYWBPkG9Rh4f2YWE2akEeJTnh5bRX1jNosmTeGY6pyEsVo
 A5rkmmXT6smtAA17L5vas9ZCTVN6EEMfSndt+lcoOK8XXes2BN7dTGD1KOmrWuoq7iZbBU
 RpVg7fY0hMzGEZsl0sOjtHd1gzvoibQU0TYUTGDiXO4un/qSZkCb/gx0rK9a7A==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Michal Simek <michal.simek@amd.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH v3] net: phy: Factor out PHY GPIO reset code
Date: Mon, 18 Mar 2024 15:57:01 +0100
Message-ID: <20240318145720.7990-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: jj3hrzbx7f14ckc344pjtm1nhu8kp4jk
X-MBO-RS-ID: 06593b25c0304f0b051
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

Pull the PHY GPIO reset code into separate function, since
this is and will be reused multiple times. Set up default
reset assert and deassert timing to generous 20ms and 1ms
for maximum compatibility in case those DT properties are
missing.

Reviewed-by: Ramon Fried <rfried.dev@gmail.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
---
V2: - Fix am335x_evm build with OF_REAL disabled
    - Collect RB from Ramon
V3: - Drop stale conditional
---
 drivers/net/phy/ethernet_id.c | 37 ++++-------------------
 drivers/net/phy/phy.c         | 55 +++++++++++++++++++++++++++++++++++
 include/phy.h                 |  9 ++++++
 3 files changed, 69 insertions(+), 32 deletions(-)

diff --git a/drivers/net/phy/ethernet_id.c b/drivers/net/phy/ethernet_id.c
index 6cb1fd4453e..4dfdee60dcc 100644
--- a/drivers/net/phy/ethernet_id.c
+++ b/drivers/net/phy/ethernet_id.c
@@ -18,12 +18,11 @@ struct phy_device *phy_connect_phy_id(struct mii_dev *bus, struct udevice *dev,
 {
 	struct phy_device *phydev;
 	struct ofnode_phandle_args phandle_args;
-	struct gpio_desc gpio;
 	const char *node_name;
 	struct udevice *pdev;
-	ofnode node;
-	u32 id, assert, deassert;
 	u16 vendor, device;
+	ofnode node;
+	u32 id;
 	int ret;
 
 	if (dev_read_phandle_with_args(dev, "phy-handle", NULL, 0, 0,
@@ -41,35 +40,9 @@ struct phy_device *phy_connect_phy_id(struct mii_dev *bus, struct udevice *dev,
 		return NULL;
 	}
 
-	if (!IS_ENABLED(CONFIG_DM_ETH_PHY)) {
-		ret = gpio_request_by_name_nodev(node, "reset-gpios", 0, &gpio,
-						 GPIOD_IS_OUT | GPIOD_ACTIVE_LOW);
-		if (!ret) {
-			assert = ofnode_read_u32_default(node,
-							 "reset-assert-us", 0);
-			deassert = ofnode_read_u32_default(node,
-							   "reset-deassert-us",
-							   0);
-			ret = dm_gpio_set_value(&gpio, 1);
-			if (ret) {
-				dev_err(dev,
-					"Failed assert gpio, err: %d\n", ret);
-				return NULL;
-			}
-
-			udelay(assert);
-
-			ret = dm_gpio_set_value(&gpio, 0);
-			if (ret) {
-				dev_err(dev,
-					"Failed deassert gpio, err: %d\n",
-					ret);
-				return NULL;
-			}
-
-			udelay(deassert);
-		}
-	}
+	ret = phy_gpio_reset(dev);
+	if (ret)
+		return NULL;
 
 	if (phyaddr == -1)
 		phyaddr = ofnode_read_u32_default(phandle_args.node, "reg", -1);
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 63b3e46f101..a7a6fa66268 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -18,6 +18,8 @@
 #include <phy.h>
 #include <errno.h>
 #include <asm/global_data.h>
+#include <asm-generic/gpio.h>
+#include <dm/device_compat.h>
 #include <dm/of_extra.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
@@ -768,6 +770,59 @@ int miiphy_reset(const char *devname, unsigned char addr)
 	return phy_reset(phydev);
 }
 
+#if CONFIG_IS_ENABLED(DM_GPIO) && CONFIG_IS_ENABLED(OF_REAL) && \
+    !IS_ENABLED(CONFIG_DM_ETH_PHY)
+int phy_gpio_reset(struct udevice *dev)
+{
+	struct ofnode_phandle_args phandle_args;
+	struct gpio_desc gpio;
+	u32 assert, deassert;
+	ofnode node;
+	int ret;
+
+	ret = dev_read_phandle_with_args(dev, "phy-handle", NULL, 0, 0,
+					 &phandle_args);
+	/* No PHY handle is OK */
+	if (ret)
+		return 0;
+
+	node = phandle_args.node;
+	if (!ofnode_valid(node))
+		return -EINVAL;
+
+	ret = gpio_request_by_name_nodev(node, "reset-gpios", 0, &gpio,
+					 GPIOD_IS_OUT | GPIOD_ACTIVE_LOW);
+	/* No PHY reset GPIO is OK */
+	if (ret)
+		return 0;
+
+	assert = ofnode_read_u32_default(node, "reset-assert-us", 20000);
+	deassert = ofnode_read_u32_default(node, "reset-deassert-us", 1000);
+	ret = dm_gpio_set_value(&gpio, 1);
+	if (ret) {
+		dev_err(dev, "Failed assert gpio, err: %d\n", ret);
+		return ret;
+	}
+
+	udelay(assert);
+
+	ret = dm_gpio_set_value(&gpio, 0);
+	if (ret) {
+		dev_err(dev, "Failed deassert gpio, err: %d\n", ret);
+		return ret;
+	}
+
+	udelay(deassert);
+
+	return 0;
+}
+#else
+int phy_gpio_reset(struct udevice *dev)
+{
+	return 0;
+}
+#endif
+
 struct phy_device *phy_find_by_mask(struct mii_dev *bus, uint phy_mask)
 {
 	/* Reset the bus */
diff --git a/include/phy.h b/include/phy.h
index ae23814bbf3..90b7e364101 100644
--- a/include/phy.h
+++ b/include/phy.h
@@ -183,6 +183,15 @@ struct fixed_link {
  */
 int phy_reset(struct phy_device *phydev);
 
+/**
+ * phy_gpio_reset() - Resets the specified PHY using GPIO reset
+ * Toggles the optional PHY reset GPIO
+ *
+ * @dev:	PHY udevice to reset
+ * @return: 0 if OK, -ve on error
+ */
+int phy_gpio_reset(struct udevice *dev);
+
 /**
  * phy_find_by_mask() - Searches for a PHY on the specified MDIO bus
  * The function checks the PHY addresses flagged in phy_mask and returns a
-- 
2.43.0

