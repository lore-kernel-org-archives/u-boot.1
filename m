Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB54C83F25
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 22:08:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D692883767;
	Tue, 22 Jul 2025 00:07:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="pLprhZSh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 944DD83767; Tue, 22 Jul 2025 00:07:53 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CE32830C8
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 00:07:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=dd2a=2D=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1753135670; bh=DbC9WcR5CLOYlM869P+Z8wWZZWYjPRSV9OGJc1yALN4=;
 b=pLprhZShCHgTrhWXGDOT6wbAIGHfDyxoeHVI3LVOj9DWsQ+1aYK/ekhLNJ6/wWwCg/DUEBFeJ
 M0bYYrz4Rtjv0n1vkOafsluzy9KNAMuwS+ZC76agkWdBXEVdQxZM4sJ6umiK0F93MO4ZoCHdGyR
 BAciomRT/6Z/EDOjyd+dnS6QTQg5qvhFwyH7vWkk3peeUhHsRFGiZpWuHo10FK4rT42pMGa9KpR
 W2z28X7507pPcsZBCVl0lPGDp76wgEW3DGugXLE1QyaH096UfgscVxNmlOoasTUouzMUTofqj/a
 u9lndC5/co/Altt0biUprVzwiGun6aWjeBREO39nTwGw==
X-Forward-Email-ID: 687eba33285c5226412894df
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 02/10] phy: rockchip: usbdp: Simplify init ops
Date: Mon, 21 Jul 2025 22:07:11 +0000
Message-ID: <20250721220734.1617117-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721220734.1617117-1-jonas@kwiboo.se>
References: <20250721220734.1617117-1-jonas@kwiboo.se>
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

With working shared reference counting for Generic PHY ops there is no
need for the Rockchip USBDP PHY driver to keep its own status (reference
counting) handling.

Simplify the init ops now that shared reference counting is working.
This also removes the unused mode_change handling as part of the
simplication.

No runtime change is expected with this simplication.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/phy/rockchip/phy-rockchip-usbdp.c | 71 +++--------------------
 1 file changed, 8 insertions(+), 63 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-usbdp.c b/drivers/phy/rockchip/phy-rockchip-usbdp.c
index 56963c87183e..6cfbef02b4ac 100644
--- a/drivers/phy/rockchip/phy-rockchip-usbdp.c
+++ b/drivers/phy/rockchip/phy-rockchip-usbdp.c
@@ -96,9 +96,7 @@ struct rockchip_udphy {
 
 	/* PHY status management */
 	bool flip;
-	bool mode_change;
 	u8 mode;
-	u8 status;
 
 	/* utilized for USB */
 	bool hs; /* flag for high-speed */
@@ -525,65 +523,6 @@ static int udphy_parse_dt(struct rockchip_udphy *udphy, struct udevice *dev)
 	return 0;
 }
 
-static int udphy_power_on(struct rockchip_udphy *udphy, u8 mode)
-{
-	int ret;
-
-	if (!(udphy->mode & mode)) {
-		dev_info(udphy->dev, "mode 0x%02x is not support\n", mode);
-		return 0;
-	}
-
-	if (udphy->status == UDPHY_MODE_NONE) {
-		udphy->mode_change = false;
-		ret = udphy_setup(udphy);
-		if (ret)
-			return ret;
-
-		if (udphy->mode & UDPHY_MODE_USB)
-			udphy_u3_port_disable(udphy, false);
-	} else if (udphy->mode_change) {
-		udphy->mode_change = false;
-		udphy->status = UDPHY_MODE_NONE;
-		if (udphy->mode == UDPHY_MODE_DP)
-			udphy_u3_port_disable(udphy, true);
-
-		ret = udphy_disable(udphy);
-		if (ret)
-			return ret;
-		ret = udphy_setup(udphy);
-		if (ret)
-			return ret;
-	}
-
-	udphy->status |= mode;
-
-	return 0;
-}
-
-static int udphy_power_off(struct rockchip_udphy *udphy, u8 mode)
-{
-	int ret;
-
-	if (!(udphy->mode & mode)) {
-		dev_info(udphy->dev, "mode 0x%02x is not supported\n", mode);
-		return 0;
-	}
-
-	if (!udphy->status)
-		return 0;
-
-	udphy->status &= ~mode;
-
-	if (udphy->status == UDPHY_MODE_NONE) {
-		ret = udphy_disable(udphy);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
 static int rockchip_u3phy_of_xlate(struct phy *phy,
 				   struct ofnode_phandle_args *args)
 {
@@ -603,6 +542,7 @@ static int rockchip_u3phy_of_xlate(struct phy *phy,
 static int rockchip_u3phy_init(struct phy *phy)
 {
 	struct rockchip_udphy *udphy = dev_get_priv(phy->dev);
+	int ret;
 
 	/* DP only or high-speed, disable U3 port */
 	if (!(udphy->mode & UDPHY_MODE_USB) || udphy->hs) {
@@ -610,7 +550,12 @@ static int rockchip_u3phy_init(struct phy *phy)
 		return 0;
 	}
 
-	return udphy_power_on(udphy, UDPHY_MODE_USB);
+	ret = udphy_setup(udphy);
+	if (ret)
+		return ret;
+
+	udphy_u3_port_disable(udphy, false);
+	return 0;
 }
 
 static int rockchip_u3phy_exit(struct phy *phy)
@@ -621,7 +566,7 @@ static int rockchip_u3phy_exit(struct phy *phy)
 	if (!(udphy->mode & UDPHY_MODE_USB) || udphy->hs)
 		return 0;
 
-	return udphy_power_off(udphy, UDPHY_MODE_USB);
+	return udphy_disable(udphy);
 }
 
 static const struct phy_ops rockchip_u3phy_ops = {
-- 
2.50.1

