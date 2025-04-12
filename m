Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 595F9C369B2
	for <u-boot@archiver.kernel.org>; Sat, 12 Apr 2025 14:31:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABAEF82D88;
	Sat, 12 Apr 2025 16:31:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=riseup.net header.i=@riseup.net header.b="J5RTvSda";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF6FD82D7C; Sat, 12 Apr 2025 16:31:28 +0200 (CEST)
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA47282AE2
 for <u-boot@lists.denx.de>; Sat, 12 Apr 2025 16:31:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danct12@riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx1.riseup.net (Postfix) with ESMTPS id 4ZZbb06RKbzDqS8;
 Sat, 12 Apr 2025 14:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1744468285; bh=9Yfml+4kksTn2mC8dXhVGcok0o9zkNq8rRZ0ZcUOASM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=J5RTvSdaB8VSUWDRbzo5IaNVAz+30Se/0HbmXr+vDbkZ2yh+kf+y2LljWt1th1hOb
 hFp97u1LWWXoS94qdtYyjLjboCO9GZvci0LMMzbZxmH7Cx/zR5N+mzPn2SCAlL/KDb
 ra5hNqdyvBMLm6izj1ueUlqsct/T57kwSibmYDHA=
X-Riseup-User-ID: 860DF611A5B3C3A9B1D6B8E015C5A5B6BD332605162E0FB306EBDA23415E9D59
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4ZZbZx38RyzJtRl;
 Sat, 12 Apr 2025 14:31:21 +0000 (UTC)
From: Dang Huynh <danct12@riseup.net>
Date: Sat, 12 Apr 2025 21:27:06 +0700
Subject: [PATCH v3 04/12] video: rockchip: dw-mipi-dsi: Add
 get_display_timing support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250412-vop2-pt2-v3-4-7c796db335e9@riseup.net>
References: <20250412-vop2-pt2-v3-0-7c796db335e9@riseup.net>
In-Reply-To: <20250412-vop2-pt2-v3-0-7c796db335e9@riseup.net>
To: Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Ondrej Jirman <megi@xff.cz>, 
 Dragan Simic <dsimic@manjaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, u-boot@lists.denx.de, 
 Piotr Zalewski <pZ010001011111@proton.me>, Dang Huynh <danct12@riseup.net>
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

This allows video drivers to obtain display timings from the video
bridge.

Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
Signed-off-by: Dang Huynh <danct12@riseup.net>
---
 drivers/video/rockchip/dw_mipi_dsi_rockchip.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/video/rockchip/dw_mipi_dsi_rockchip.c b/drivers/video/rockchip/dw_mipi_dsi_rockchip.c
index 95e825eb3d6de7ef2836fa029927034394486e9c..d21ea7953a6003fa49da3e22220d3312109f600c 100644
--- a/drivers/video/rockchip/dw_mipi_dsi_rockchip.c
+++ b/drivers/video/rockchip/dw_mipi_dsi_rockchip.c
@@ -224,6 +224,7 @@ struct dw_rockchip_dsi_priv {
 	struct mipi_dsi_device device;
 	void __iomem *base;
 	struct udevice *panel;
+	struct display_timing timings;
 	void __iomem *grf;
 
 	/* Optional external dphy */
@@ -709,7 +710,7 @@ static int dw_mipi_dsi_rockchip_attach(struct udevice *dev)
 	struct dw_rockchip_dsi_priv *priv = dev_get_priv(dev);
 	struct mipi_dsi_device *device = &priv->device;
 	struct mipi_dsi_panel_plat *mplat;
-	struct display_timing timings;
+	struct display_timing *timings = &priv->timings;
 	int ret;
 
 	ret = uclass_first_device_err(UCLASS_PANEL, &priv->panel);
@@ -724,10 +725,10 @@ static int dw_mipi_dsi_rockchip_attach(struct udevice *dev)
 	device->format = mplat->format;
 	device->mode_flags = mplat->mode_flags;
 
-	ret = panel_get_display_timing(priv->panel, &timings);
+	ret = panel_get_display_timing(priv->panel, timings);
 	if (ret) {
 		ret = ofnode_decode_display_timing(dev_ofnode(priv->panel),
-						   0, &timings);
+						   0, timings);
 		if (ret) {
 			dev_err(dev, "decode display timing error %d\n", ret);
 			return ret;
@@ -740,7 +741,7 @@ static int dw_mipi_dsi_rockchip_attach(struct udevice *dev)
 		return ret;
 	}
 
-	ret = dsi_host_init(priv->dsi_host, device, &timings, 4,
+	ret = dsi_host_init(priv->dsi_host, device, timings, 4,
 			    &dsi_rockchip_phy_ops);
 	if (ret) {
 		dev_err(dev, "failed to initialize mipi dsi host\n");
@@ -902,9 +903,19 @@ static int dw_mipi_dsi_rockchip_probe(struct udevice *dev)
 	return 0;
 }
 
+static int dw_mipi_dsi_rockchip_get_dt(struct udevice *dev,
+				       struct display_timing *timings)
+{
+	struct dw_rockchip_dsi_priv *priv = dev_get_priv(dev);
+
+	memcpy(timings, &priv->timings, sizeof(*timings));
+	return 0;
+}
+
 struct video_bridge_ops dw_mipi_dsi_rockchip_ops = {
 	.attach = dw_mipi_dsi_rockchip_attach,
 	.set_backlight = dw_mipi_dsi_rockchip_set_bl,
+	.get_display_timing = dw_mipi_dsi_rockchip_get_dt,
 };
 
 static const struct rockchip_dw_dsi_chip_data rk3399_chip_data[] = {

-- 
2.49.0

