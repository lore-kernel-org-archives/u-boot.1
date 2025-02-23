Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D68C021B3
	for <u-boot@archiver.kernel.org>; Sun, 23 Feb 2025 12:14:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8832880FD8;
	Sun, 23 Feb 2025 13:14:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=riseup.net header.i=@riseup.net header.b="PNy1Eg56";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D37E680FDD; Sun, 23 Feb 2025 13:14:06 +0100 (CET)
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99CE180FD6
 for <u-boot@lists.denx.de>; Sun, 23 Feb 2025 13:14:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danct12@riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx0.riseup.net (Postfix) with ESMTPS id 4Z12pf4f5mz9v33;
 Sun, 23 Feb 2025 12:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1740312842; bh=J7yA32ErQTkYgixRJFHwQD0MwSF15DVesOfQL/DNaQk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=PNy1Eg561eGlRst4b0sdWk2Asz9DRmg+CdcMCut5aRS3ScUT/JlkwYRin8sFaII08
 FJ46MjhlscGsbmVKRU5f01Y7tVWSxbAyxf1S7UV/DsIcTvYu1wtghz7BWZJbihBH4Z
 Yay/5LrhsrbxEG9mYeg08pgjqv+2Jc2NgOKn060I=
X-Riseup-User-ID: 99A73E024427BF90C6F9A02F499B6C8588620A633B274A4567245AEA347D50EA
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4Z12pZ6BCNzJtjX;
 Sun, 23 Feb 2025 12:13:58 +0000 (UTC)
From: Dang Huynh <danct12@riseup.net>
Date: Sun, 23 Feb 2025 19:13:37 +0700
Subject: [PATCH v2 02/11] video: rockchip: dw_mipi_dsi: Improve pixel clock
 calculations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250223-vop2-pt2-v2-2-71350e482970@riseup.net>
References: <20250223-vop2-pt2-v2-0-71350e482970@riseup.net>
In-Reply-To: <20250223-vop2-pt2-v2-0-71350e482970@riseup.net>
To: Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Ondrej Jirman <megi@xff.cz>, 
 Dragan Simic <dsimic@manjaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de, Dang Huynh <danct12@riseup.net>
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

From: Ondrej Jirman <megi@xff.cz>

Calculate burst mode overhead in one place for both internal
and external PHY use case and exit if out of range, instead
of ignoring the wrong value.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Dang Huynh <danct12@riseup.net>
---
 drivers/video/rockchip/dw_mipi_dsi_rockchip.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/video/rockchip/dw_mipi_dsi_rockchip.c b/drivers/video/rockchip/dw_mipi_dsi_rockchip.c
index fa512173510b1ee6f51e6269eb249e24d0e980f8..c47992dfb133cda029eba82e842ac824ceead64b 100644
--- a/drivers/video/rockchip/dw_mipi_dsi_rockchip.c
+++ b/drivers/video/rockchip/dw_mipi_dsi_rockchip.c
@@ -526,8 +526,6 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, struct display_timing *timings,
 	struct udevice *dev = device->dev;
 	struct dw_rockchip_dsi_priv *dsi = dev_get_priv(dev);
 	int bpp;
-	unsigned long mpclk, tmp;
-	unsigned int target_mbps = 1000;
 	unsigned int max_mbps = dppa_map[ARRAY_SIZE(dppa_map) - 1].max_mbps;
 	unsigned long best_freq = 0;
 	unsigned long fvco_min, fvco_max, fin, fout;
@@ -544,30 +542,28 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, struct display_timing *timings,
 		return bpp;
 	}
 
-	mpclk = DIV_ROUND_UP(timings->pixelclock.typ, 1000);
-	if (mpclk) {
-		/* take 1 / 0.8, since mbps must big than bandwidth of RGB */
-		tmp = (mpclk * (bpp / lanes) * 10 / 8) / 1000;
-		if (tmp < max_mbps)
-			target_mbps = tmp;
-		else
-			dev_err(dsi->dsi_host,
-				"DPHY clock frequency is out of range\n");
+	fout = timings->pixelclock.typ / MSEC_PER_SEC * bpp / lanes;
+	if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST)
+		fout = fout * 12 / 10;
+	fout *= MSEC_PER_SEC;
+
+	if (fout > max_mbps * USEC_PER_SEC) {
+		dev_err(dsi->dsi_host, "DPHY clock frequency is out of range\n");
+		return -EINVAL;
 	}
 
 	/* for external phy only the mipi_dphy_config is necessary */
 	if (generic_phy_valid(&dsi->phy)) {
-		phy_mipi_dphy_get_default_config(timings->pixelclock.typ  * 10 / 8,
+		phy_mipi_dphy_get_default_config(fout / bpp * lanes,
 						 bpp, lanes,
 						 &dsi->phy_opts);
-		dsi->lane_mbps = target_mbps;
+		dsi->lane_mbps = DIV_ROUND_UP(fout, USEC_PER_SEC);
 		*lane_mbps = dsi->lane_mbps;
 
 		return 0;
 	}
 
 	fin = clk_get_rate(dsi->ref);
-	fout = target_mbps * USEC_PER_SEC;
 
 	/* constraint: 5Mhz <= Fref / N <= 40MHz */
 	min_prediv = DIV_ROUND_UP(fin, 40 * USEC_PER_SEC);

-- 
2.48.1

