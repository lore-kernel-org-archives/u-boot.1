Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14DB6C55184
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 10:57:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9DED460763;
	Tue,  4 Aug 2026 10:57:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8FDfpIZAXPSU; Tue,  4 Aug 2026 10:57:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 35EBE6074F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785841070;
	bh=7j/K28BQJfw0vopubTx0pXk+xCzOI0T5pUPmCM4Gses=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qlpuaqqn2rR0c/ov4pj2L9bKQfeFfLHx48iYJ7S0Ha/3wDAlnB/SwBuVk0ZKf9OrW
	 3mTNAT8mvQGwxr5eexBw2t/tYG4xntZiNFwURfutXb9URtk6yrdCrj9lzGuEgu39qT
	 EejF4Uu9xvP/f1NhOZcG8T/6IIMkMAbnFJPtjaaGMSNdysmC+dmn01mJfYvu5JvzfT
	 KR6em6YCvsSSccahuw0CyrdrQrdyCYUzt3cnw0qhqCOEX/knrw2zmhPhEFgaJjYSz4
	 1hwICQlou4JQjyZ0Xf41Sr9WhTfXC1AzjFMdUjG2ukxTaDPiYvQnXURVhJST715pzb
	 GthhNGRn5XgRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 35EBE6074F;
	Tue,  4 Aug 2026 10:57:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A78AE2DE
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 10:57:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8E2A780C88
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 10:57:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cdfOafAZnSQ6 for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 10:57:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=eb25=f5=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 76C2E80C86
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 76C2E80C86
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 76C2E80C86
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 10:57:47 +0000 (UTC)
X-Forward-Email-ID: 6a71c5a8e481fa9c5d58fa9d
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.13.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Ondrej Jirman <megi@xff.cz>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 3/9] video: rockchip: dw_mipi_dsi: Get GRF base address from
 phandle
Date: Tue,  4 Aug 2026 10:57:12 +0000
Message-ID: <20260804105721.2402406-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260804105721.2402406-1-jonas@kwiboo.se>
References: <20260804105721.2402406-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785841066; bh=7j/K28BQJfw0vopubTx0pXk+xCzOI0T5pUPmCM4Gses=;
 b=YSpXefYjDhBbiTJpNteocuTuw176L/667iOKdpuUQdP+mX6gQj1DxEoBXVhUvCvdV6//9eYkG
 7WZ7y1E75X37FbWlRCKj0x34TacaP6L8eyLOvTgvIlpzeJPGbtcW42muVFqrkNTpZ9GUw1YpszO
 D6CcpF5oszHom7jpiiuSo2zdLkyt94YhsikIc9L6aCV5DMTkb03fBHM5JDW72+++eXODhlgdYxZ
 l8R2l3K/O8kPNxDJvcoPrprLqQX9+Z1pVJOOShmU3/lQu6vYQRbQ6Acs8C2sP0FUJdDuv0wJ51c
 8FD27dxeu3syFrVe/xmcLNbwV/LkBEmZlVV/0QnlzW4g==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=YSpXefYj
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The GRF syscon is referenced using the rockchip,grf prop in SoC DTs.

Change to use syscon_regmap_lookup_by_phandle() to get a GRF regmap
instead of using the inconvenient syscon_get_first_range() method.

This has no intended behavior change, all affected SoC DTs have the
rockchip,grf reference and the values being written already contain
correct write-enable mask.

Fixes: bd6375c5511c ("video: rockchip: dw_mipi_dsi: Fix GRF access")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Please note that this has only been compile tested.

Cc: Chris Morgan <macromorgan@hotmail.com>
Cc: Ondrej Jirman <megi@xff.cz>
---
 drivers/video/rockchip/dw_mipi_dsi_rockchip.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/video/rockchip/dw_mipi_dsi_rockchip.c b/drivers/video/rockchip/dw_mipi_dsi_rockchip.c
index fa512173510b..2e5bcb74589a 100644
--- a/drivers/video/rockchip/dw_mipi_dsi_rockchip.c
+++ b/drivers/video/rockchip/dw_mipi_dsi_rockchip.c
@@ -17,6 +17,7 @@
 #include <mipi_dsi.h>
 #include <panel.h>
 #include <phy-mipi-dphy.h>
+#include <regmap.h>
 #include <reset.h>
 #include <syscon.h>
 #include <video_bridge.h>
@@ -31,7 +32,6 @@
 #include <linux/time.h>
 
 #include <asm/arch-rockchip/clock.h>
-#include <asm/arch-rockchip/hardware.h>
 
 /*
  * DSI wrapper registers & bit definitions
@@ -224,7 +224,7 @@ struct dw_rockchip_dsi_priv {
 	struct mipi_dsi_device device;
 	void __iomem *base;
 	struct udevice *panel;
-	void __iomem *grf;
+	struct regmap *grf;
 
 	/* Optional external dphy */
 	struct phy phy;
@@ -782,13 +782,13 @@ static int dw_mipi_dsi_rockchip_set_bl(struct udevice *dev, int percent)
 static void dw_mipi_dsi_rockchip_config(struct dw_rockchip_dsi_priv *dsi)
 {
 	if (dsi->cdata->lanecfg1_grf_reg)
-		rk_setreg(dsi->grf + dsi->cdata->lanecfg1_grf_reg, dsi->cdata->lanecfg1);
+		regmap_write(dsi->grf, dsi->cdata->lanecfg1_grf_reg, dsi->cdata->lanecfg1);
 
 	if (dsi->cdata->lanecfg2_grf_reg)
-		rk_setreg(dsi->grf + dsi->cdata->lanecfg2_grf_reg, dsi->cdata->lanecfg2);
+		regmap_write(dsi->grf, dsi->cdata->lanecfg2_grf_reg, dsi->cdata->lanecfg2);
 
 	if (dsi->cdata->enable_grf_reg)
-		rk_setreg(dsi->grf + dsi->cdata->enable_grf_reg, dsi->cdata->enable);
+		regmap_write(dsi->grf, dsi->cdata->enable_grf_reg, dsi->cdata->enable);
 }
 
 static int dw_mipi_dsi_rockchip_bind(struct udevice *dev)
@@ -821,7 +821,11 @@ static int dw_mipi_dsi_rockchip_probe(struct udevice *dev)
 		return -EINVAL;
 	}
 
-	priv->grf = syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
+	priv->grf = syscon_regmap_lookup_by_phandle(dev, "rockchip,grf");
+	if (IS_ERR(priv->grf)) {
+		dev_err(dev, "unable to find rockchip,grf regmap\n");
+		return PTR_ERR(priv->grf);
+	}
 
 	i = 0;
 	while (cdata[i].reg) {
-- 
2.54.0

