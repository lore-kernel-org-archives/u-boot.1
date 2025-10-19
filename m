Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA054CCD183
	for <u-boot@archiver.kernel.org>; Sun, 19 Oct 2025 15:10:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FE8683438;
	Sun, 19 Oct 2025 17:10:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="PKnfz0eU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69E19838AA; Sun, 19 Oct 2025 17:10:01 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13B5783211
 for <u-boot@lists.denx.de>; Sun, 19 Oct 2025 17:09:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ad34=45=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1760886597; bh=6ispuN1fql/uZzc6qAUhIqYWxIIhTbb/VZp8LOqF/pU=;
 b=PKnfz0eULMWQUSnQr8C1joUfEMLtomP1uiAVGOy+M0XxJnqxBN7yH0kz/t38Nk4kF4YyEOeGQ
 F0GkpYOIv7YBv2sRR7T3zZPG8WIwk5W9tE7HDtbdRDnicsq5K+30P2UzHM9CFheq5HVV2ZVLgFG
 MlZ05emJ+zBduyKJXXLnB9y0McvAYV8CGI/4PPv/2wh5NBEO7YaBXS53dryGSmQxKvTPHY6cWV5
 l+i18ih1UezRNrWmzqxXg3yIsERBioacu/fsb+tI7HU6LZURrkjeyCnBdv1rDCxuXG18QMZCZwe
 4omG0vQVxDPfZwUyHPq9ez0dcAgzuPn3nqipP7q1WaGg==
X-Forward-Email-ID: 68f4ff435ea0c6742724292f
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.3.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 1/2] phy: rockchip: naneng-combphy: Enable U3 port for USB3OTG
 on RK3568
Date: Sun, 19 Oct 2025 15:09:40 +0000
Message-ID: <20251019150945.823167-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251019150945.823167-1-jonas@kwiboo.se>
References: <20251019150945.823167-1-jonas@kwiboo.se>
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

The USB OTG U3 port may have been disabled early, add support to the
COMBPHY driver to re-enable the U3 port.

This matches changes made in the Linux commit 7bb14b61b7d0 ("phy:
rockchip: naneng-combphy: Enable U3 OTG port for RK3568").

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
index d602f965d6aa..82353ae7678c 100644
--- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
+++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
@@ -399,6 +399,14 @@ static int rk3568_combphy_cfg(struct rockchip_combphy_priv *priv)
 		param_write(priv->phy_grf, &cfg->pipe_txcomp_sel, false);
 		param_write(priv->phy_grf, &cfg->pipe_txelec_sel, false);
 		param_write(priv->phy_grf, &cfg->usb_mode_set, true);
+		switch (priv->id) {
+		case 0:
+			param_write(priv->pipe_grf, &cfg->u3otg0_port_en, true);
+			break;
+		case 1:
+			param_write(priv->pipe_grf, &cfg->u3otg1_port_en, true);
+			break;
+		}
 		break;
 	case PHY_TYPE_SATA:
 		writel(0x41, priv->mmio + 0x38);
-- 
2.51.0

