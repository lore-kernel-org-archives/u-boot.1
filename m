Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE92C4345F
	for <u-boot@archiver.kernel.org>; Sat,  4 May 2024 19:45:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2663488137;
	Sat,  4 May 2024 21:45:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="WVoaFNd1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7984B88137; Sat,  4 May 2024 21:45:18 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3123288535
 for <u-boot@lists.denx.de>; Sat,  4 May 2024 21:45:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=fdac=MI=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1714851897; bh=Gt/xjKg5U0JD9KC2xvA/Y9hxzZRHlcmW6cfe6lpzi9A=;
 b=WVoaFNd1wuZZ5ZJb9gdO/MBHODtzhRTWzoOSw0CZM/zmYXMaHg9FIYSNL3GbDIJhflIzXrfHY
 Z0Jkt5gq1be9TBA6bZZ8smP7C530MzDDaTlltEoflDDpj6k0OyfT7usGK+EFxzx6/GcY+p10TZe
 hQhNWY7jt0HGXN+DLVIH8WLIdBtQd3/1B6SWHlgjJ3LY6o6BwgGdyPC4KUr/RiPCAHcBxNlVQTB
 ppA/bXbbuoj6Zen1TJ0KLjXetB7G5IzmrATeaeeq0zs0dLIIFS/Z8gG26vGQBj9911zQbD9SvN+
 5lDZFuM6tPu0o5XWcQri5MRpbty5WX+0WXd+4EwHRB5Q==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 10/16] phy: rockchip: usbdp: Find phy-id from the io address
Date: Sat,  4 May 2024 19:43:02 +0000
Message-ID: <20240504194346.2462489-11-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240504194346.2462489-1-jonas@kwiboo.se>
References: <20240504194346.2462489-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 663690352b8e4dad13276e13
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

The upstream Linux kernel driver find the phy-id from the io address.

Change to use a similar method as the U-Boot inno-usb2 phy driver and
the Linux kernel driver to set correct phy-id.

This is based on the linux-phy next commit 2f70bbddeb45 ("phy: rockchip:
add usbdp combo phy driver").

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/phy/rockchip/phy-rockchip-usbdp.c | 39 ++++++++++++++++++++---
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-usbdp.c b/drivers/phy/rockchip/phy-rockchip-usbdp.c
index baf92529348c..8e5821069757 100644
--- a/drivers/phy/rockchip/phy-rockchip-usbdp.c
+++ b/drivers/phy/rockchip/phy-rockchip-usbdp.c
@@ -74,6 +74,8 @@ struct udphy_grf_cfg {
 struct rockchip_udphy;
 
 struct rockchip_udphy_cfg {
+	unsigned int num_phys;
+	unsigned int phy_ids[2];
 	/* resets to be requested */
 	const char * const *rst_list;
 	int num_rsts;
@@ -640,17 +642,25 @@ int rockchip_u3phy_uboot_init(void)
 
 static int rockchip_udphy_probe(struct udevice *dev)
 {
-	const struct device_node *np = ofnode_to_np(dev_ofnode(dev));
 	struct rockchip_udphy *udphy = dev_get_priv(dev);
 	const struct rockchip_udphy_cfg *phy_cfgs;
+	unsigned int reg;
 	int id, ret;
 
 	udphy->dev = dev;
 
-	id = of_alias_get_id(np, "usbdp");
-	if (id < 0)
-		id = 0;
-	udphy->id = id;
+	ret = ofnode_read_u32_index(dev_ofnode(dev), "reg", 0, &reg);
+	if (ret) {
+		dev_err(dev, "failed to read reg[0] property\n");
+		return ret;
+	}
+	if (reg == 0 && dev_read_addr_cells(dev) == 2) {
+		ret = ofnode_read_u32_index(dev_ofnode(dev), "reg", 1, &reg);
+		if (ret) {
+			dev_err(dev, "failed to read reg[1] property\n");
+			return ret;
+		}
+	}
 
 	phy_cfgs = (const struct rockchip_udphy_cfg *)dev_get_driver_data(dev);
 	if (!phy_cfgs) {
@@ -659,6 +669,20 @@ static int rockchip_udphy_probe(struct udevice *dev)
 	}
 	udphy->cfgs = phy_cfgs;
 
+	/* find the phy-id from the io address */
+	udphy->id = -ENODEV;
+	for (id = 0; id < udphy->cfgs->num_phys; id++) {
+		if (reg == udphy->cfgs->phy_ids[id]) {
+			udphy->id = id;
+			break;
+		}
+	}
+
+	if (udphy->id < 0) {
+		dev_err(dev, "no matching device found\n");
+		return -ENODEV;
+	}
+
 	ret = regmap_init_mem(dev_ofnode(dev), &udphy->pma_regmap);
 	if (ret)
 		return ret;
@@ -838,6 +862,11 @@ static const char * const rk3588_udphy_rst_l[] = {
 };
 
 static const struct rockchip_udphy_cfg rk3588_udphy_cfgs = {
+	.num_phys = 2,
+	.phy_ids = {
+		0xfed80000,
+		0xfed90000,
+	},
 	.num_rsts = ARRAY_SIZE(rk3588_udphy_rst_l),
 	.rst_list = rk3588_udphy_rst_l,
 	.grfcfg	= {
-- 
2.43.2

