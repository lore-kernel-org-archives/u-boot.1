Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CBFBC54E49
	for <u-boot@archiver.kernel.org>; Sun, 25 Feb 2024 22:11:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91BCF87E23;
	Sun, 25 Feb 2024 23:10:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="yOZt1tiR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFA6B87DA4; Sun, 25 Feb 2024 23:10:53 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 217BA87DFA
 for <u-boot@lists.denx.de>; Sun, 25 Feb 2024 23:10:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=31c0=KD=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1708899036; bh=AzFTi2bcYYAtXfClfRKD6v/Yh+iTeLs39b0UoXgmBwI=;
 b=yOZt1tiRwOXYRO3mwXmOiJo897JN79a+B1jEzPSXrDGT/XlOaEYuhCBCO4IIUTSOg1irZCZD0
 XierFKG1DECIT3JlIXV16mU6P9Dsg/amgtgJp8QQmuACEJ6JERBNINdt0i7+i0oUF0bmiYupJ+U
 VY5LPHhscKquVc3LCEo/DcIMMX+gh3zOF15G4QPE6ldeQbs/Ys4bqYQ/cMe+X4ijANkou6hqNSw
 VY/TylYiKqrMyUW8SKJ6oXRxluNhrYpWWde3hoCc0zjTEWW9dGzSbxX8NLmmhqTT0uGKH6/RrB0
 nNeuIgaMGTk7jCCUtbi4Vp99P9HYFnlfmTRXoVLEofxw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Ren Jianing <jianing.ren@rock-chips.com>, Manoj Sai
 <abbaraju.manojsai@amarulasolutions.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Eugen Hristev <eugen.hristev@collabora.com>,
 Frank Wang <frank.wang@rock-chips.com>, Xavier Drudis Ferran
 <xdrudis@tinet.cat>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 1/2] phy: rockchip-inno-usb2: Write to correct GRF
Date: Sun, 25 Feb 2024 22:10:19 +0000
Message-ID: <20240225221024.1974853-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240225221024.1974853-1-jonas@kwiboo.se>
References: <20240225221024.1974853-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65dbbada46c899733a83b3ec
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

On RK3399 the USB2PHY regs are located in the common GRF, remaining SoCs
that is supported by this driver have the USB2PHY regs in a different
GRF.

When support for RK356x, RK3588 and RK3328 was added this driver was
never updated to use correct GRF and have instead incorrectly written
to wrong GRF for these SoCs.

The default reset values for the USB2PHY have made USB mostly working
even when wrong GRF was used, however, following have been observed:

  scanning bus usb@fd840000 for devices...
  ERROR:  USB-error: DEVICENOTRESPONDING: Device did not respond to token (IN) or did
  not provide a handshake (OUT) (5)
  ERROR: USB-error: DEVICENOTRESPONDING: Device did not respond to token (IN) or did
  not provide a handshake (OUT) (5)
  unable to get device descriptor (error=-1)

Fix this by using a regmap from rockchip,usbgrf prop and fall back to
getting a regmap for parent udevice instead of always getting the
common GRF.

Also protect against accidental clear of bit 0 in a reg with offset 0,
only bind driver to enabled otg/host-ports and remove unused headers.

Fixes: 3da15f0b49a2 ("phy: rockchip-inno-usb2: Add USB2 PHY for rk3568")
Fixes: cdf9010f6e17 ("phy: rockchip-inno-usb2: add initial support for rk3588 PHY")
Fixes: 9aa93d84038b ("phy: rockchip-inno-usb2: Add USB2 PHY for RK3328")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 41 ++++++++++---------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 70e61eccb79a..7317128d135e 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -6,23 +6,16 @@
  * Copyright (C) 2020 Amarula Solutions(India)
  */
 
-#include <common.h>
 #include <clk-uclass.h>
 #include <dm.h>
-#include <asm/global_data.h>
 #include <dm/device_compat.h>
 #include <dm/device-internal.h>
 #include <dm/lists.h>
 #include <generic-phy.h>
-#include <reset.h>
+#include <regmap.h>
 #include <syscon.h>
-#include <asm/gpio.h>
-#include <asm/io.h>
-#include <linux/iopoll.h>
 #include <asm/arch-rockchip/clock.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define usleep_range(a, b) udelay((b))
 #define BIT_WRITEABLE_SHIFT	16
 
@@ -61,30 +54,39 @@ struct rockchip_usb2phy_cfg {
 };
 
 struct rockchip_usb2phy {
-	void *reg_base;
+	struct regmap *reg_base;
 	struct clk phyclk;
 	const struct rockchip_usb2phy_cfg *phy_cfg;
 };
 
-static inline int property_enable(void *reg_base,
+static inline int property_enable(struct regmap *base,
 				  const struct usb2phy_reg *reg, bool en)
 {
 	unsigned int val, mask, tmp;
 
+	if (!reg->offset && !reg->enable && !reg->disable)
+		return 0;
+
 	tmp = en ? reg->enable : reg->disable;
 	mask = GENMASK(reg->bitend, reg->bitstart);
 	val = (tmp << reg->bitstart) | (mask << BIT_WRITEABLE_SHIFT);
 
-	return writel(val, reg_base + reg->offset);
+	return regmap_write(base, reg->offset, val);
 }
 
-static inline bool property_enabled(void *reg_base,
+static inline bool property_enabled(struct regmap *base,
 				    const struct usb2phy_reg *reg)
 {
+	int ret;
 	unsigned int tmp, orig;
 	unsigned int mask = GENMASK(reg->bitend, reg->bitstart);
 
-	orig = readl(reg_base + reg->offset);
+	if (!reg->offset && !reg->enable && !reg->disable)
+		return false;
+
+	ret = regmap_read(base, reg->offset, &orig);
+	if (ret)
+		return false;
 
 	tmp = (orig & mask) >> reg->bitstart;
 	return tmp != reg->disable;
@@ -248,7 +250,11 @@ static int rockchip_usb2phy_probe(struct udevice *dev)
 	unsigned int reg;
 	int index, ret;
 
-	priv->reg_base = syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
+	if (dev_read_bool(dev, "rockchip,usbgrf"))
+		priv->reg_base =
+			syscon_regmap_lookup_by_phandle(dev, "rockchip,usbgrf");
+	else
+		priv->reg_base = syscon_get_regmap(dev_get_parent(dev));
 	if (IS_ERR(priv->reg_base))
 		return PTR_ERR(priv->reg_base);
 
@@ -305,11 +311,8 @@ static int rockchip_usb2phy_bind(struct udevice *dev)
 	int ret = 0;
 
 	dev_for_each_subnode(node, dev) {
-		if (!ofnode_valid(node)) {
-			dev_info(dev, "subnode %s not found\n", dev->name);
-			ret = -ENXIO;
-			goto bind_fail;
-		}
+		if (!ofnode_is_enabled(node))
+			continue;
 
 		name = ofnode_get_name(node);
 		dev_dbg(dev, "subnode %s\n", name);
-- 
2.43.0

