Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3889CEE49B2
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 22:17:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 705778678A;
	Fri,  1 Sep 2023 00:16:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.b="IAFBy3Y0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BF128675B; Fri,  1 Sep 2023 00:16:45 +0200 (CEST)
Received: from s.wfbtzhsv.outbound-mail.sendgrid.net
 (s.wfbtzhsv.outbound-mail.sendgrid.net [159.183.224.104])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 638148679F
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 00:16:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounces+31435339-7456-u-boot=lists.denx.de@em2124.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=from:subject:in-reply-to:references:mime-version:to:cc:
 content-transfer-encoding:content-type:cc:content-type:from:subject:to;
 s=s1; bh=PomkGehBG5LFH9ffwETRMlm0emNiF++0IEZik0tu4lc=;
 b=IAFBy3Y08CnCgolMfFUxGbYK9Uim+4ba71HKK3neCwXZCCCDdf/6WZZZN6nw5Vv2TTlW
 akVDYiMNkVsQ+PlSQxKYPiRrSXfj+QR1SBwB4UITAATy6r/VKm5+wN50IABLJvN+d7/0GC
 6V0yt9M9SfcN3E3BONg9lbRHDjQSVujizw95Q06ZAnyG5KaNhQeorFWWAxN9rXWUGDdsGq
 VmUw4rs8nt7vzqfnz19QsAaxQH4Ey9n9gfe582sSaBs/nK2g3K9YL+wwUoTyYnFOoCJq/M
 bKbNd3LduWRuFk6nP5CYyfmAD4atGbVFk17WeEwgWqdLYtoo+JXkvWFXt3c/rUIA==
Received: by filterdrecv-66949dbc98-rr4mv with SMTP id
 filterdrecv-66949dbc98-rr4mv-1-64F11147-30
 2023-08-31 22:16:39.972610236 +0000 UTC m=+5859655.737372949
Received: from bionic.localdomain (unknown) by geopod-ismtpd-5 (SG) with ESMTP
 id IADmaorORHiY7AGtLHe-IQ Thu, 31 Aug 2023 22:16:39.779 +0000 (UTC)
From: Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 6/6] video: rockchip: dw_mipi_dsi: Use generic_phy_valid()
 helper
Date: Thu, 31 Aug 2023 22:16:40 +0000 (UTC)
Message-ID: <20230831221629.1027552-7-jonas@kwiboo.se>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230831221629.1027552-1-jonas@kwiboo.se>
References: <20230831221629.1027552-1-jonas@kwiboo.se>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0hxlTWx0iFLJM6wgho?=
 =?us-ascii?Q?CM4D9qIihyM+88l2hWDN85acQa6I1g1eH=2FZbWmr?=
 =?us-ascii?Q?dBg1YYy=2FRSf1PL4asM8RaDiu1RJk2GQHz5TQqhE?=
 =?us-ascii?Q?u9TmEMulTNW=2F7bMmpwcqbPzzIFU1p0MsKp2kSzb?=
 =?us-ascii?Q?WXvdRocCBEqxDBxKEGREQ=2F75+eusz+ewXSwOOU?=
To: Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Anatolij Gustschin
 <agust@denx.de>, Philipp Tomsich <philipp.tomsich@vrull.eu>, Kever Yang
 <kever.yang@rock-chips.com>, Ondrej Jirman <megi@xff.cz>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
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

The documentation for struct phy state that "The content of the
structure is managed solely by the PHY API and PHY drivers".

Change to use the generic_phy_valid() helper to check if phy is valid.

Fixes: b7d8d40346f2 ("video: rockchip: dw_mipi_dsi: Fix external phy existence check")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/video/rockchip/dw_mipi_dsi_rockchip.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/rockchip/dw_mipi_dsi_rockchip.c b/drivers/video/rockchip/dw_mipi_dsi_rockchip.c
index 0852b53ebed5..1a5ab781e3f1 100644
--- a/drivers/video/rockchip/dw_mipi_dsi_rockchip.c
+++ b/drivers/video/rockchip/dw_mipi_dsi_rockchip.c
@@ -377,7 +377,7 @@ static int dsi_phy_init(void *priv_data)
 	struct dw_rockchip_dsi_priv *dsi = dev_get_priv(dev);
 	int ret, i, vco;
 
-	if (dsi->phy.dev) {
+	if (generic_phy_valid(&dsi->phy)) {
 		ret = generic_phy_configure(&dsi->phy, &dsi->phy_opts);
 		if (ret) {
 			dev_err(dsi->dsi_host,
@@ -559,7 +559,7 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, struct display_timing *timings,
 	}
 
 	/* for external phy only the mipi_dphy_config is necessary */
-	if (dsi->phy.dev) {
+	if (generic_phy_valid(&dsi->phy)) {
 		phy_mipi_dphy_get_default_config(timings->pixelclock.typ  * 10 / 8,
 						 bpp, lanes,
 						 &dsi->phy_opts);
@@ -859,7 +859,7 @@ static int dw_mipi_dsi_rockchip_probe(struct udevice *dev)
 	}
 
 	/* Get a ref clock only if not using an external phy. */
-	if (priv->phy.dev) {
+	if (generic_phy_valid(&priv->phy)) {
 		dev_dbg(dev, "setting priv->ref to NULL\n");
 		priv->ref = NULL;
 
-- 
2.42.0

