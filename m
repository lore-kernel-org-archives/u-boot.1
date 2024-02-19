Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC04CC48BF8
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 15:35:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7B2587F2D;
	Mon, 19 Feb 2024 16:34:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MjNJ2XbF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DC8D87876; Mon, 19 Feb 2024 16:34:02 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3EED87F4F
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 16:33:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 15B4960DF9;
 Mon, 19 Feb 2024 15:33:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0717C433F1;
 Mon, 19 Feb 2024 15:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1708356824;
 bh=t2J8pRB1HtoPnsqsFpFPeF7QY0lZxoR9awi151pV518=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=MjNJ2XbFnthWGPH1Sy/J/Fmuw1+Lzw9w11wfjSipggGynKuoUUgjNz2Xqa83oTWfM
 GG1fKOh7zhA5YGLGU7oY8TNvJk6m6CJyY2m8o/D0DaElEZidPubYZHQBmEhBJY5jfd
 rHv0t/vme/wzZQICXEtbuLPbwyme9X+n4pZEcGkmvbib7VnJOjoGhRzRKwdeLJxLMm
 f9UVRcyLUiCBxbBtTKyVyD8slBBJ/tUUW9ChwuTRlpwdDXh07ktrfARRydaMF+mprp
 gkhdMZYnFlza0LE1kleGefKnCBci1/FxlbEKarV45xdQQpnGFv5djepj1yOiozJfJz
 ytVsiH69ri83A==
From: Roger Quadros <rogerq@kernel.org>
Date: Mon, 19 Feb 2024 17:33:28 +0200
Subject: [PATCH 1/2] net: mdio: Handle bus level GPIO Reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-for-2024-07-am65-cpsw-mdio-v1-1-afe9aaba5801@kernel.org>
References: <20240219-for-2024-07-am65-cpsw-mdio-v1-0-afe9aaba5801@kernel.org>
In-Reply-To: <20240219-for-2024-07-am65-cpsw-mdio-v1-0-afe9aaba5801@kernel.org>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, 
 nm@ti.com
Cc: srk@ti.com, s-vadapalli@ti.com, vigneshr@ti.com, mripard@kernel.org, 
 dannenberg@ti.com, r-gunasekaran@ti.com, danishanwar@ti.com, 
 u-boot@lists.denx.de, Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3338; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=t2J8pRB1HtoPnsqsFpFPeF7QY0lZxoR9awi151pV518=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBl03TSaiy3x/HwOsbYrn7CzW2dptdNFlJHCJ/OK
 kF3wJjUDISJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZdN00gAKCRDSWmvTvnYw
 k/4CEACPXwUpJwdwg2jhGZspC9iTWvjhnuiSteys+jif2QW6Q7eGD0JxdcrQ+SVa14eOvjOWzyT
 42FgZwcmsJXyox3cE7QfGy3sOgempf4NLKFf4714MT9Fe6ekz9K2CjRS4XXERW+noPFUiLyfxXr
 GkWB8bjiwtrIUPG/AFLAyTwhh6Dd26HTjqsJDdo8G5xABRqzIzpXj2SldWWiSgSodr7T6BYiYt2
 5d8w8fulNWKKkaYCIbJ0NOtTX8h+GqMhQO7Nw43aKtePFiQFwr+9fQ4TrwLSHcFDDUKpNBFee5u
 Mw4w0o/jInRlbE//yYc336sFMXX77MiaPCCUX05YGitZwZ5vhjUOYUsSU1bpWRoPQN4qkrsOd7r
 7TTfJs+b7RjeRVyBNnhnuiXY2ehfTFWqANM3a7M0H/e2dbjJYC7RZ4yqjn5jgZvqAHuEJADQr+9
 gNps3d4N/PTlsxo5M9eMor/TYHPQHnr2K5RRKcIWmTfmcHckZMCv3kI+Lvua3hl9j1wd7dJi4IL
 Lnzv3MUJPvCzUxB13oYqqTVTeWXMjOW7E44UR3AkGRuy45fvdYC4zkbp03g6otksIJX19e07Sgs
 qeP42PWgDJdyUKtrC4x0txVOGtcKXkqPo5tNX7w8iLoEmHubfLxdIdKN+nYD9el+/yeKcbuQq6y
 PfTCn53jNoQREZw==
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
 include/phy.h     |  7 +++++++
 net/mdio-uclass.c | 37 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/include/phy.h b/include/phy.h
index e02cbdb58c..90a595cae4 100644
--- a/include/phy.h
+++ b/include/phy.h
@@ -9,6 +9,7 @@
 #ifndef _PHY_H
 #define _PHY_H
 
+#include <asm/gpio.h>
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
index e758cc66d7..4500c50430 100644
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
+	if (dm_gpio_is_valid(&mii_bus->reset_gpiod)) {
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

