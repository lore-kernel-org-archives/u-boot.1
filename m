Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7724C02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 13:05:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B33F18073F;
	Thu, 16 Jan 2025 14:05:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=riseup.net header.i=@riseup.net header.b="ooxQxUC2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D8D2806D4; Thu, 16 Jan 2025 10:16:31 +0100 (CET)
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FA5B801B0
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 10:16:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danct12@riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx1.riseup.net (Postfix) with ESMTPS id 4YYcgH1KPJzDqGF;
 Thu, 16 Jan 2025 09:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1737018987; bh=er0LVxSM01hhz8hfLzfnSNbAysUHxiP3G5hE7o2YZWA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=ooxQxUC2Xt3g9OryNB9Ewryqbput9ceeCyeHXc3F459gfI1Vofv4KlzgIcYaTHTlP
 AR27HDz3sUwWDW6wXAis03rVu2L9TqZujPEF6Xd3SzRK2e13Ch3KXu1nKmw5WVwPVI
 mrYz8DiMgv2UgmkOnsJVMrFNoF0lZf10dRdoAILI=
X-Riseup-User-ID: A647D1D5CF1E0CC0ED73CFCD1DAE0FDA601FB22223A66568C394084098BBB2A6
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4YYcgD2nKYzJq7r;
 Thu, 16 Jan 2025 09:16:23 +0000 (UTC)
From: Dang Huynh <danct12@riseup.net>
Date: Thu, 16 Jan 2025 16:15:52 +0700
Subject: [PATCH 03/10] video: rockchip: dw_mipi_dsi: Proceed when external
 PHY is not defined
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-vop2-pt2-v1-3-c9d646b53930@riseup.net>
References: <20250116-vop2-pt2-v1-0-c9d646b53930@riseup.net>
In-Reply-To: <20250116-vop2-pt2-v1-0-c9d646b53930@riseup.net>
To: Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Ondrej Jirman <megi@xff.cz>, 
 Dragan Simic <dsimic@manjaro.org>
Cc: u-boot@lists.denx.de, Dang Huynh <danct12@riseup.net>
X-Mailman-Approved-At: Thu, 16 Jan 2025 14:05:20 +0100
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
2.48.1

