Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D47CCFA18
	for <u-boot@archiver.kernel.org>; Sat,  8 Nov 2025 13:06:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6A1583E61;
	Sat,  8 Nov 2025 14:06:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VZWpOOh2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AA8683E8A; Sat,  8 Nov 2025 06:38:31 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E871B83E23
 for <u-boot@lists.denx.de>; Sat,  8 Nov 2025 06:38:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+dang.huynh.mainlining.org@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B0DA1601D3;
 Sat,  8 Nov 2025 05:38:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B401C19425;
 Sat,  8 Nov 2025 05:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1762580307;
 bh=j4DxIQlU0+1SMOjQzNC1OmSOycXkmUYqThUxQU3XZgk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=VZWpOOh2gNg/cNqrKwJxTX9qbV3wBLj5/+Bca3EJM98Tv7blJPwDtBG77ka5dyTnl
 +ug9vjbLhQsxgd/hrXC8EE7YwZQdBo0W90gpKhZzBg5vGVfOnptX9HAPNf+3MEjSNi
 gt/wzj/qPgxCOJqHQz07ZX5bSJFgYtT8VwjqpeTIQzA9xKw/AEvzWkTKFem8mq7UIQ
 HxA9S/6xQ8DqivLvx/tSJOVVcIl3CZwQ7sRpXmtmkl9UnBbrdAR317Yke8D0d9GRUa
 eU6OpmmthcEtHOLd5KNwZeKcVRU7yPGAI99tqKWX5w4SuM5VEoIDODSVqKP/+/hGMM
 4hS47frFlDdKA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 75530CCFA1A;
 Sat,  8 Nov 2025 05:38:27 +0000 (UTC)
From: Dang Huynh via B4 Relay <devnull+dang.huynh.mainlining.org@kernel.org>
Date: Sat, 08 Nov 2025 12:37:58 +0700
Subject: [PATCH v6 02/12] video: rockchip: dw_mipi_dsi: Improve pixel clock
 calculations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-vop2-pt2-v6-2-d04c699262fb@mainlining.org>
References: <20251108-vop2-pt2-v6-0-d04c699262fb@mainlining.org>
In-Reply-To: <20251108-vop2-pt2-v6-0-d04c699262fb@mainlining.org>
To: u-boot@lists.denx.de
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Alexander Graf <agraf@csgraf.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Ondrej Jirman <megi@xff.cz>, 
 Ion Agorria <ion@agorria.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Dragan Simic <dsimic@manjaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Piotr Zalewski <pZ010001011111@proton.me>, 
 Dang Huynh <dang.huynh@mainlining.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762580305; l=2439;
 i=dang.huynh@mainlining.org; s=20250917; h=from:subject:message-id;
 bh=eRj1vei0RnwjSH7SoTQM5cwl9+DrdSzAnj5A0ccnn/U=;
 b=QmyNioH6yGwAKbsWYYRiE2Bvq7/M2HlPFx6U0x2qpt64KfWU36/f/w6199xZ9+DvuswsbqTwz
 dEat1ZjT/DnAyu3c4hZbZ4xmvEst5zSqb2QnXw2unZoTCuJ1mUk/GVS
X-Developer-Key: i=dang.huynh@mainlining.org; a=ed25519;
 pk=RyzH4CL4YU/ItXYUurA51EVBidfx4lIy8/E4EKRJCUk=
X-Endpoint-Received: by B4 Relay for dang.huynh@mainlining.org/20250917
 with auth_id=526
X-Original-From: Dang Huynh <dang.huynh@mainlining.org>
X-Mailman-Approved-At: Sat, 08 Nov 2025 14:06:07 +0100
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
Reply-To: dang.huynh@mainlining.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Ondrej Jirman <megi@xff.cz>

Calculate burst mode overhead in one place for both internal
and external PHY use case and exit if out of range, instead
of ignoring the wrong value.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
---
 drivers/video/rockchip/dw_mipi_dsi_rockchip.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/video/rockchip/dw_mipi_dsi_rockchip.c b/drivers/video/rockchip/dw_mipi_dsi_rockchip.c
index fa512173510..c47992dfb13 100644
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
2.51.2


