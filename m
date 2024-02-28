Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578FFC47DD9
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 10:36:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39A1888063;
	Wed, 28 Feb 2024 11:36:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k7cMlyP1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A9F787FEB; Wed, 28 Feb 2024 11:36:12 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CFC988048
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 11:36:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 8C59D61473;
 Wed, 28 Feb 2024 10:36:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C055C43399;
 Wed, 28 Feb 2024 10:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1709116565;
 bh=ZwYfCAgSMH7fq0XfK/UcE69H0dJlhOx/5qTQ+rm6p8A=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=k7cMlyP1vu6FB+VAvBugn1xK+suIZmfki7fQFnL/nKw19w3m0veT4SJ6BXGMlgU7o
 jqGeAuFDxsVRyiGzjLiIAP9xOgAHmQ3lCsh+/keMWKnTgB8cbc1wM2HU0aMKPOo4bo
 RR1GKg9LNbFy5JljJZ4UY5IrMxqK3SA/B0cuarFKThxMXdcTdfawk1JxZVeW/mFel7
 gwFfexSZQtWqfNpd3SUiWzLSjjNpBgd2xUtsnrY8bIW2CHtXWTYU+ChsGHzXfIurCY
 M39tnR6xqSpXIbaflMq4wm8ezPH2z2RUd1ObAGhyC0AhJnDATG/2BL3R+rrnDKwFvZ
 zX2LAw2Z8/JyA==
From: Roger Quadros <rogerq@kernel.org>
Date: Wed, 28 Feb 2024 12:35:26 +0200
Subject: [PATCH v2 1/2] net: mdio: Handle bus level GPIO Reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240228-for-2024-07-am65-cpsw-mdio-v2-1-f74f972eafeb@kernel.org>
References: <20240228-for-2024-07-am65-cpsw-mdio-v2-0-f74f972eafeb@kernel.org>
In-Reply-To: <20240228-for-2024-07-am65-cpsw-mdio-v2-0-f74f972eafeb@kernel.org>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, 
 nm@ti.com
Cc: srk@ti.com, s-vadapalli@ti.com, vigneshr@ti.com, mripard@kernel.org, 
 dannenberg@ti.com, r-gunasekaran@ti.com, danishanwar@ti.com, 
 u-boot@lists.denx.de, Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3518; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=ZwYfCAgSMH7fq0XfK/UcE69H0dJlhOx/5qTQ+rm6p8A=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBl3wyOg8dDxipub2I0v0JZ4uwlzxBYR51ws0thi
 FiNFgFRIjWJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZd8MjgAKCRDSWmvTvnYw
 kwELEADQALoxkIjpd0/EdRptd6Nmdo58cE9a4cWCa1Ara4FrLIXldurI1D2UaWJYjeetcPDdO6v
 KbV+MUk+tZob3dXU7w9oH/k2MoPDzzj5arZE8LajSByroPuewev1FCERSwjK5UuAqG+FR6xLi3F
 KHbvCZZ7itez6wW6eJaq/wRdcxXSh6HgG5RVVLacUSfTA2ASkqDt/9soVQmU4XRrCGzR1hwtZZ0
 Zk/e+eX49/CE+D26OVklOvvkOJgKD731VUaCWi9a8Qa8WZVeWBt4yZWFxvT57mh1S8zwWeU1a41
 wPN/tTAWn3TOr92BaLLc6qD5vqEoWe/rNcy9MUT9+SnmcJNzwXNxSj5NdvCSmrSZql8kHv5iSFQ
 S4c2vljj3g2C6mQOGWxUNnosIJIkPzE2hwnanuWQcqaS88zW3ZV775SbMef/lAP87JhZOerrQKN
 3+xhw/Zi28Px8OJSt+0AZkhPe44T5Lh8a3AWMrO6dtGjwBm4Sm69lbs5G/MLrNTwGDJ2x0CZ9SO
 aqQpAx4nX0q2Iuf5fUe0mwjgPbPo8X+fHGbhKEcCBUgbZRS1w+lqbcDcRP8W84mIx7qiTxLZBAw
 PoPZ2o7IO6QRWSDf405mdSoDfKnEiDdsVTaw5s7OP1AQbLgpJ75h3a789v2nZ3ovbm0H+bUpzs0
 5++2KBxPtRj2s2w==
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

Some platforms have bus level Reset controlled
by a GPIO line. If available then handle bus reset
via GPIO.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
Changelog:
v2:
- Fix build if DM_GPIO not set
- Fix build on platforms that don't have <asm/gpio.h>
  by using <asm-generic/gpio.h>
---
 include/phy.h     |  7 +++++++
 net/mdio-uclass.c | 37 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/include/phy.h b/include/phy.h
index e02cbdb58c..ae23814bbf 100644
--- a/include/phy.h
+++ b/include/phy.h
@@ -9,6 +9,7 @@
 #ifndef _PHY_H
 #define _PHY_H
 
+#include <asm-generic/gpio.h>
 #include <log.h>
 #include <phy_interface.h>
 #include <dm/ofnode.h>
@@ -76,6 +77,12 @@ struct mii_dev {
 	int (*reset)(struct mii_dev *bus);
 	struct phy_device *phymap[PHY_MAX_ADDR];
 	u32 phy_mask;
+	/** @reset_delay_us: Bus GPIO reset pulse width in microseconds */
+	int reset_delay_us;
+	/** @reset_post_delay_us: Bus GPIO reset deassert delay in microseconds */
+	int reset_post_delay_us;
+	/** @reset_gpiod: Bus Reset GPIO descriptor pointer */
+	struct gpio_desc reset_gpiod;
 };
 
 /* struct phy_driver: a structure which defines PHY behavior
diff --git a/net/mdio-uclass.c b/net/mdio-uclass.c
index e758cc66d7..6fc7034111 100644
--- a/net/mdio-uclass.c
+++ b/net/mdio-uclass.c
@@ -14,6 +14,9 @@
 #include <dm/of_extra.h>
 #include <dm/uclass-internal.h>
 #include <linux/compat.h>
+#include <linux/delay.h>
+
+#define DEFAULT_GPIO_RESET_DELAY	10	/* in microseconds */
 
 void dm_mdio_probe_devices(void)
 {
@@ -80,6 +83,16 @@ int dm_mdio_write(struct udevice *mdio_dev, int addr, int devad, int reg,
 int dm_mdio_reset(struct udevice *mdio_dev)
 {
 	struct mdio_ops *ops = mdio_get_ops(mdio_dev);
+	struct mdio_perdev_priv *pdata = dev_get_uclass_priv(mdio_dev);
+	struct mii_dev *mii_bus = pdata->mii_bus;
+
+	if (CONFIG_IS_ENABLED(DM_GPIO) && dm_gpio_is_valid(&mii_bus->reset_gpiod)) {
+		dm_gpio_set_value(&mii_bus->reset_gpiod, 1);
+		udelay(mii_bus->reset_delay_us);
+		dm_gpio_set_value(&mii_bus->reset_gpiod, 0);
+		if (mii_bus->reset_post_delay_us > 0)
+			udelay(mii_bus->reset_post_delay_us);
+	}
 
 	if (!ops->reset)
 		return 0;
@@ -111,14 +124,36 @@ static int mdio_reset(struct mii_dev *mii_bus)
 static int dm_mdio_post_probe(struct udevice *dev)
 {
 	struct mdio_perdev_priv *pdata = dev_get_uclass_priv(dev);
+	struct mii_dev *mii_bus;
+	int ret;
 
-	pdata->mii_bus = mdio_alloc();
+	mii_bus = mdio_alloc();
+	if (!mii_bus) {
+		dev_err(dev, "couldn't allocate mii_bus\n");
+		return -ENOMEM;
+	}
+	pdata->mii_bus = mii_bus;
 	pdata->mii_bus->read = mdio_read;
 	pdata->mii_bus->write = mdio_write;
 	pdata->mii_bus->reset = mdio_reset;
 	pdata->mii_bus->priv = dev;
 	strlcpy(pdata->mii_bus->name, dev->name, MDIO_NAME_LEN);
 
+	if (IS_ENABLED(CONFIG_DM_GPIO)) {
+		/* Get bus level PHY reset GPIO details */
+		mii_bus->reset_delay_us = dev_read_u32_default(dev, "reset-delay-us",
+							       DEFAULT_GPIO_RESET_DELAY);
+		mii_bus->reset_post_delay_us = dev_read_u32_default(dev,
+								    "reset-post-delay-us",
+								    0);
+		ret = gpio_request_by_name(dev, "reset-gpios", 0, &mii_bus->reset_gpiod,
+					   GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
+		if (ret && ret != -ENOENT) {
+			dev_err(dev, "couldn't get reset-gpios: %d\n", ret);
+			return ret;
+		}
+	}
+
 	return mdio_register(pdata->mii_bus);
 }
 

-- 
2.34.1

