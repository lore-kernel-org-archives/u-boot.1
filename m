Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ABB5C5B543
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 05:43:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4418B82AF6;
	Sat,  7 Jun 2025 07:43:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=riseup.net header.i=@riseup.net header.b="W8n9fB/v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A24CB81F0D; Sat,  7 Jun 2025 07:43:29 +0200 (CEST)
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A046182AF6
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 07:43:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danct12@riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx1.riseup.net (Postfix) with ESMTPS id 4bDnCx36SrzDqJt;
 Sat,  7 Jun 2025 05:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1749275006; bh=cDlZefonY2oTHG8Ic78LMfFv11lg069bj/xG63/OaI0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=W8n9fB/vsBtvtS/oeXKCUV05O2MFRBP4XoAYE2w1r0y83cDhy2T/kn3NiywYfE8JV
 66r3TNS2YTC7+Oy6t3di8twKaDPOCyVwbShmacIFhWy3JBaPA9Nt3J3ow+r4uTtmYq
 hV/C18XMR7s8v2kLTv6cBsxiElAbhePa0XqP7BEU=
X-Riseup-User-ID: A7B6721642C0EEA6BF0A0FD1BF885EC0156B09F68AD5715DAE6FE1696444994F
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4bDnCt0xbPzJn3g;
 Sat,  7 Jun 2025 05:43:21 +0000 (UTC)
From: Dang Huynh <danct12@riseup.net>
Date: Sat, 07 Jun 2025 12:43:02 +0700
Subject: [PATCH v5 03/12] video: rockchip: dw_mipi_dsi: Proceed when
 external PHY is not defined
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250607-vop2-pt2-v5-3-1d52f7a2cf3c@riseup.net>
References: <20250607-vop2-pt2-v5-0-1d52f7a2cf3c@riseup.net>
In-Reply-To: <20250607-vop2-pt2-v5-0-1d52f7a2cf3c@riseup.net>
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

