Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 464E5C83F25
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 22:08:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B8B083796;
	Tue, 22 Jul 2025 00:08:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="h+76Sb0/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAC0A83768; Tue, 22 Jul 2025 00:08:03 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B7AF837FC
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 00:08:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=dd2a=2D=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1753135680; bh=0sriM07YajA2KH+V9ZhDy+cs9snnGi0fOexL4KpxDGg=;
 b=h+76Sb0/nUMm1yQEtL5MmC3O6/wxuRW0Qoa7TUqBUqGPG3B3afHDabLgey7+LCWrmJidCNuAn
 j5OniFBcoNR3/02++f5+2QkTEShhZZu0ZCXQFTKJ6W0jY1zJRwXdD24RJtL0ekZx9BUFoRMVsas
 ijc+EumTJfnKuOlz2LxP/OB/GtrWq0zOY7F/6m4kqt2WkSfVU+a+dFUdmM2v/xLLYPilU1t/IP9
 ypaQp22Ug64ofUiY+jA6GXARy5vfstRFEg8OoL2Hw8u96QUUz90wyVfleufxymEIjVHvLikyOtL
 CukMqgn9StBK4NnOUP15wpo7xnzBiIudlhOtk0q7/q8w==
X-Forward-Email-ID: 687eba3d285c52264128951e
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
Subject: [PATCH 05/10] phy: rockchip: naneng-combphy: Use
 syscon_regmap_lookup_by_phandle
Date: Mon, 21 Jul 2025 22:07:14 +0000
Message-ID: <20250721220734.1617117-6-jonas@kwiboo.se>
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

Change to use syscon_regmap_lookup_by_phandle() helper instead of
finding the syscon udevice and making a call to syscon_get_regmap().

No runtime change is expected with this simplication.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 .../phy/rockchip/phy-rockchip-naneng-combphy.c  | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
index f246c8db2d6c..7f107a11606b 100644
--- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
+++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
@@ -175,22 +175,19 @@ static const struct phy_ops rockchip_combphy_ops = {
 static int rockchip_combphy_parse_dt(struct udevice *dev,
 				     struct rockchip_combphy_priv *priv)
 {
-	struct udevice *syscon;
 	int ret;
 
-	ret = uclass_get_device_by_phandle(UCLASS_SYSCON, dev, "rockchip,pipe-grf", &syscon);
-	if (ret) {
-		dev_err(dev, "failed to find peri_ctrl pipe-grf regmap");
-		return ret;
+	priv->pipe_grf = syscon_regmap_lookup_by_phandle(dev, "rockchip,pipe-grf");
+	if (IS_ERR(priv->pipe_grf)) {
+		dev_err(dev, "failed to find peri_ctrl pipe-grf regmap\n");
+		return PTR_ERR(priv->pipe_grf);
 	}
-	priv->pipe_grf = syscon_get_regmap(syscon);
 
-	ret = uclass_get_device_by_phandle(UCLASS_SYSCON, dev, "rockchip,pipe-phy-grf", &syscon);
-	if (ret) {
+	priv->phy_grf = syscon_regmap_lookup_by_phandle(dev, "rockchip,pipe-phy-grf");
+	if (IS_ERR(priv->phy_grf)) {
 		dev_err(dev, "failed to find peri_ctrl pipe-phy-grf regmap\n");
-		return ret;
+		return PTR_ERR(priv->phy_grf);
 	}
-	priv->phy_grf = syscon_get_regmap(syscon);
 
 	ret = clk_get_by_index(dev, 0, &priv->ref_clk);
 	if (ret) {
-- 
2.50.1

