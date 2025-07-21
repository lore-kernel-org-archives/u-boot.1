Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 935A1C83F1A
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 22:08:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3B9E837B6;
	Tue, 22 Jul 2025 00:08:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="v5tDo9gl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC462830EA; Tue, 22 Jul 2025 00:07:58 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 896538328F
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 00:07:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=dd2a=2D=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1753135675; bh=r4BB9K9NJ2Z8gcVnqqDNpsYESC/PjFtbgAVmE3p1h3U=;
 b=v5tDo9glvw9IvBhnSzuAEPAD6RC40CN+3enHbfGP5nQW3/+IqZEu9w8FtmvAiVX/OFFuFbu6V
 LjE+EhCUwpPgVEKbqpmhnK78bPz3Jz5UkHCFLbEmRpUgTEEvaa8vzpzWT91xilt2GJkD1jBmZvu
 UQWww3dVBe0mjAgbg1aEVwnStnXgSTBCQhlcCd+IIDhrCnNwHXB4LZo+fYdiQcMr0sHPjAJH+S3
 vqlUZ4aR6Utc/M8KOVN97PQ5MFtJ6LSd9siputQQyaV5C8KQumRXIxO5HmMp3eojASD1jAYmPxi
 tkULYMXq7NxH54r/pBMx5THb8wPJoDtgTICzFgjdzp+A==
X-Forward-Email-ID: 687eba3a285c522641289509
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
Subject: [PATCH 04/10] phy: rockchip: naneng-combphy: Simplify init ops
Date: Mon, 21 Jul 2025 22:07:13 +0000
Message-ID: <20250721220734.1617117-5-jonas@kwiboo.se>
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

The init ops for Rockchip COMBPHY driver is more complex than it needs
to be, e.g. declaring multiple init functions that only differ in the
error message.

Simplify the init ops based on code from the Linux mainline driver.

This change also ensure that errors returned from combphy_cfg() and
reset_deassert_bulk() is propertly propagated to the caller. No other
runtime change is expected with this simplication.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 .../rockchip/phy-rockchip-naneng-combphy.c    | 101 ++++--------------
 1 file changed, 19 insertions(+), 82 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
index a3038d067d3a..f246c8db2d6c 100644
--- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
+++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
@@ -98,104 +98,41 @@ static int param_write(struct regmap *base,
 	return regmap_write(base, reg->offset, val);
 }
 
-static int rockchip_combphy_pcie_init(struct rockchip_combphy_priv *priv)
-{
-	int ret = 0;
-
-	if (priv->cfg->combphy_cfg) {
-		ret = priv->cfg->combphy_cfg(priv);
-		if (ret) {
-			dev_err(priv->dev, "failed to init phy for pcie\n");
-			return ret;
-		}
-	}
-
-	return ret;
-}
-
-static int rockchip_combphy_usb3_init(struct rockchip_combphy_priv *priv)
-{
-	int ret = 0;
-
-	if (priv->cfg->combphy_cfg) {
-		ret = priv->cfg->combphy_cfg(priv);
-		if (ret) {
-			dev_err(priv->dev, "failed to init phy for usb3\n");
-			return ret;
-		}
-	}
-
-	return ret;
-}
-
-static int rockchip_combphy_sata_init(struct rockchip_combphy_priv *priv)
-{
-	int ret = 0;
-
-	if (priv->cfg->combphy_cfg) {
-		ret = priv->cfg->combphy_cfg(priv);
-		if (ret) {
-			dev_err(priv->dev, "failed to init phy for sata\n");
-			return ret;
-		}
-	}
-
-	return ret;
-}
-
-static int rockchip_combphy_sgmii_init(struct rockchip_combphy_priv *priv)
+static int rockchip_combphy_init(struct phy *phy)
 {
-	int ret = 0;
-
-	if (priv->cfg->combphy_cfg) {
-		ret = priv->cfg->combphy_cfg(priv);
-		if (ret) {
-			dev_err(priv->dev, "failed to init phy for sgmii\n");
-			return ret;
-		}
-	}
+	struct rockchip_combphy_priv *priv = dev_get_priv(phy->dev);
+	int ret;
 
-	return ret;
-}
+	ret = clk_enable(&priv->ref_clk);
+	if (ret < 0 && ret != -ENOSYS)
+		return ret;
 
-static int rockchip_combphy_set_mode(struct rockchip_combphy_priv *priv)
-{
 	switch (priv->mode) {
 	case PHY_TYPE_PCIE:
-		rockchip_combphy_pcie_init(priv);
-		break;
 	case PHY_TYPE_USB3:
-		rockchip_combphy_usb3_init(priv);
-		break;
 	case PHY_TYPE_SATA:
-		rockchip_combphy_sata_init(priv);
-		break;
 	case PHY_TYPE_SGMII:
 	case PHY_TYPE_QSGMII:
-		return rockchip_combphy_sgmii_init(priv);
+		if (priv->cfg->combphy_cfg)
+			ret = priv->cfg->combphy_cfg(priv);
+		else
+			ret = 0;
+		break;
 	default:
 		dev_err(priv->dev, "incompatible PHY type\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		break;
 	}
 
-	return 0;
-}
-
-static int rockchip_combphy_init(struct phy *phy)
-{
-	struct rockchip_combphy_priv *priv = dev_get_priv(phy->dev);
-	int ret;
-
-	ret = clk_enable(&priv->ref_clk);
-	if (ret < 0 && ret != -ENOSYS)
-		return ret;
+	if (ret) {
+		dev_err(priv->dev, "failed to init phy for phy type %x\n", priv->mode);
+		goto err_clk;
+	}
 
-	ret = rockchip_combphy_set_mode(priv);
+	ret = reset_deassert_bulk(&priv->phy_rsts);
 	if (ret)
 		goto err_clk;
 
-	reset_deassert_bulk(&priv->phy_rsts);
-
 	return 0;
 
 err_clk:
@@ -305,7 +242,7 @@ static int rockchip_combphy_probe(struct udevice *udev)
 	}
 
 	priv->dev = udev;
-	priv->mode = PHY_TYPE_SATA;
+	priv->mode = PHY_NONE;
 	priv->cfg = phy_cfg;
 
 	return rockchip_combphy_parse_dt(udev, priv);
-- 
2.50.1

