Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B80EC369A1
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 22:52:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 389078309A;
	Tue,  8 Apr 2025 00:49:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="GCbCr+D+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87D5382FB4; Tue,  8 Apr 2025 00:49:36 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E356D83285
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 00:49:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ab18=W2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1744066169; bh=brQKREzgFTqfTfHyddaUS709+PDXkMEZgr4Q25sVfQA=;
 b=GCbCr+D+y/ODzQLCtTFNRnGG/2IegpZV3kOK2f8Gw4aMhvEZPcEgmgscllTiOkebaLUZ+Grhl
 ZeQHEesqbiCE+nVeIV0QKlc7VGA27Imhfw54L7pohfHpGPviqRR5rOz3KLHLVM9N44A87S0Zrm9
 XyvkV7Pi2KCAwsVBUoX5c0k9etxYQi4bXGxoJ9Dg/reUV6RKkuNXRckmpKqUPSlGSx8hGQr7478
 gHcr04GgAKmWQPDuttnArDwEa8ZgpdcJMPp+Ieg1IIp15SM1utcM6y8+ngfAFa+mCT9sqwhgqaO
 h96KdQpuKMIlBNJJwccNWPLvAVKdqcgomHinQhuJTWiQ==
X-Forward-Email-ID: 67f456769fd75b9b965129ac
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 26/30] phy: rockchip-inno-usb2: Add support for
 clkout_ctl_phy
Date: Mon,  7 Apr 2025 22:46:59 +0000
Message-ID: <20250407224743.2423921-27-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407224743.2423921-1-jonas@kwiboo.se>
References: <20250407224743.2423921-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The 480m clk is controlled using regs in the PHY address space and not
in the USB GRF address space on e.g. RK3528 and RK3506.

Add a clkout_ctl_phy usb2phy_reg to handle enable/disable of the 480m
clk on these SoCs.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: New patch
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 43 ++++++++++++++-----
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 43f6e020a6a0..f40a86bc9dae 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -40,11 +40,13 @@ struct rockchip_usb2phy_port_cfg {
 struct rockchip_usb2phy_cfg {
 	unsigned int reg;
 	struct usb2phy_reg	clkout_ctl;
+	struct usb2phy_reg	clkout_ctl_phy;
 	const struct rockchip_usb2phy_port_cfg port_cfgs[USB2PHY_NUM_PORTS];
 };
 
 struct rockchip_usb2phy {
 	struct regmap *reg_base;
+	struct regmap *phy_base;
 	struct clk phyclk;
 	const struct rockchip_usb2phy_cfg *phy_cfg;
 };
@@ -165,6 +167,22 @@ static struct phy_ops rockchip_usb2phy_ops = {
 	.of_xlate = rockchip_usb2phy_of_xlate,
 };
 
+static void rockchip_usb2phy_clkout_ctl(struct clk *clk, struct regmap **base,
+					const struct usb2phy_reg **clkout_ctl)
+{
+	struct udevice *parent = dev_get_parent(clk->dev);
+	struct rockchip_usb2phy *priv = dev_get_priv(parent);
+	const struct rockchip_usb2phy_cfg *phy_cfg = priv->phy_cfg;
+
+	if (priv->phy_cfg->clkout_ctl_phy.enable) {
+		*base = priv->phy_base;
+		*clkout_ctl = &phy_cfg->clkout_ctl_phy;
+	} else {
+		*base = priv->reg_base;
+		*clkout_ctl = &phy_cfg->clkout_ctl;
+	}
+}
+
 /**
  * round_rate() - Adjust a rate to the exact rate a clock can provide.
  * @clk:	The clock to manipulate.
@@ -185,13 +203,14 @@ ulong rockchip_usb2phy_clk_round_rate(struct clk *clk, ulong rate)
  */
 int rockchip_usb2phy_clk_enable(struct clk *clk)
 {
-	struct udevice *parent = dev_get_parent(clk->dev);
-	struct rockchip_usb2phy *priv = dev_get_priv(parent);
-	const struct rockchip_usb2phy_cfg *phy_cfg = priv->phy_cfg;
+	const struct usb2phy_reg *clkout_ctl;
+	struct regmap *base;
+
+	rockchip_usb2phy_clkout_ctl(clk, &base, &clkout_ctl);
 
 	/* turn on 480m clk output if it is off */
-	if (!property_enabled(priv->reg_base, &phy_cfg->clkout_ctl)) {
-		property_enable(priv->reg_base, &phy_cfg->clkout_ctl, true);
+	if (!property_enabled(base, clkout_ctl)) {
+		property_enable(base, clkout_ctl, true);
 
 		/* waiting for the clk become stable */
 		usleep_range(1200, 1300);
@@ -208,12 +227,13 @@ int rockchip_usb2phy_clk_enable(struct clk *clk)
  */
 int rockchip_usb2phy_clk_disable(struct clk *clk)
 {
-	struct udevice *parent = dev_get_parent(clk->dev);
-	struct rockchip_usb2phy *priv = dev_get_priv(parent);
-	const struct rockchip_usb2phy_cfg *phy_cfg = priv->phy_cfg;
+	const struct usb2phy_reg *clkout_ctl;
+	struct regmap *base;
+
+	rockchip_usb2phy_clkout_ctl(clk, &base, &clkout_ctl);
 
 	/* turn off 480m clk output */
-	property_enable(priv->reg_base, &phy_cfg->clkout_ctl, false);
+	property_enable(base, clkout_ctl, false);
 
 	return 0;
 }
@@ -281,7 +301,10 @@ static int rockchip_usb2phy_probe(struct udevice *dev)
 		return ret;
 	}
 
-	return 0;
+	if (priv->phy_cfg->clkout_ctl_phy.enable)
+		ret = regmap_init_mem_index(dev_ofnode(dev), &priv->phy_base, 0);
+
+	return ret;
 }
 
 static int rockchip_usb2phy_bind(struct udevice *dev)
-- 
2.49.0

