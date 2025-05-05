Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F8C5C3ABAA
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 16:59:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B094582A1C;
	Mon,  5 May 2025 18:59:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=riseup.net header.i=@riseup.net header.b="FWKxfY5M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81B87820EB; Mon,  5 May 2025 18:58:57 +0200 (CEST)
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F7E0829E7
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 18:58:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danct12@riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx0.riseup.net (Postfix) with ESMTPS id 4ZrnmY2dnpz9wp5;
 Mon,  5 May 2025 16:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1746464333; bh=cDlZefonY2oTHG8Ic78LMfFv11lg069bj/xG63/OaI0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=FWKxfY5M5BgwUFKLHinJXwCMxBmwoBgfGTH3iGHUjW9X99nrSV9W8fa2t6zGEndgf
 /hbSyjI9jBXTuskxXvHMulaaSDArSt+ZOYViJ3LK/ERQ9/FnaENhrP0DI73UFp12qP
 xgkaNxIcCzhgl1rNixWhUMAdgXKg0BcSUpBxaOP0=
X-Riseup-User-ID: CA93E7DBDB4F0EBA5EAB78FC3FAF14D728F09274BFF5B95162FF83D6F29479AB
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4ZrnmV0PxbzJp9k;
 Mon,  5 May 2025 16:58:49 +0000 (UTC)
From: Dang Huynh <danct12@riseup.net>
Date: Mon, 05 May 2025 23:58:19 +0700
Subject: [PATCH v4 03/12] video: rockchip: dw_mipi_dsi: Proceed when
 external PHY is not defined
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-vop2-pt2-v4-3-3b7c3ab1a617@riseup.net>
References: <20250505-vop2-pt2-v4-0-3b7c3ab1a617@riseup.net>
In-Reply-To: <20250505-vop2-pt2-v4-0-3b7c3ab1a617@riseup.net>
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

From: Ondrej Jirman <megi@xff.cz>

In this case the DM returns ENOENT, not ENODATA.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
Signed-off-by: Dang Huynh <danct12@riseup.net>
---
 drivers/video/rockchip/dw_mipi_dsi_rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/rockchip/dw_mipi_dsi_rockchip.c b/drivers/video/rockchip/dw_mipi_dsi_rockchip.c
index c47992dfb133cda029eba82e842ac824ceead64b..95e825eb3d6de7ef2836fa029927034394486e9c 100644
--- a/drivers/video/rockchip/dw_mipi_dsi_rockchip.c
+++ b/drivers/video/rockchip/dw_mipi_dsi_rockchip.c
@@ -839,7 +839,7 @@ static int dw_mipi_dsi_rockchip_probe(struct udevice *dev)
 	 * NULL if it's not initialized.
 	 */
 	ret = generic_phy_get_by_name(dev, "dphy", &priv->phy);
-	if (ret && ret != -ENODATA) {
+	if (ret && ret != -ENOENT) {
 		dev_err(dev, "failed to get mipi dphy: %d\n", ret);
 		return ret;
 	}

-- 
2.49.0

