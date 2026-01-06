Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E13C47BE1
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 23:37:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B76483C4B;
	Wed,  7 Jan 2026 00:37:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="dB82aOUy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EABE083FDE; Wed,  7 Jan 2026 00:37:01 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0632383C08
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 00:36:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0cbd=7M=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1767742617;
 bh=9thYRDrtn/09FCFst4zpchL8wQ+jjjT8WONFd4hLvnk=;
 b=dB82aOUyJFfJ/W+SEVf6dokhHoHo7s8ttMqATmbBsvZYyH05j5U6clFjxsar1Sk7OkQfE+M4E
 6XW7REQQHEiMHPC+hNE+KypDLqUyFTtk1c1WffODcmsvxTTkRCrOG8f4W8TwVGhkDAoVoixV+0V
 nt0ZyOadt0DrPPwu5rDMdOHsdGinrpeGDf3z65LM/hSlh+q5DouxdfIH+xZVTJg3zB7zqmtHeHv
 S/Jl6HC7VuX5tcMhtTL9T3urLyXJ0J4rdRdo0UjKkoS5hDbS7g7YEBdL0yz2rQdi0d7/EQQxVm8
 bcx2nJs+DPdIExYdvO833ysXk0G7+8ggqlcF3E2loHoA==
X-Forward-Email-ID: 695d9c936a205f61d11314be
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.2.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Jonas Karlman <jonas@kwiboo.se>,
	u-boot@lists.denx.de
Subject: [PATCH v2] phy: rockchip: naneng-combphy: Enable U3 port for USB3OTG
 on RK3568
Date: Tue,  6 Jan 2026 23:36:43 +0000
Message-ID: <20260106233646.3184154-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.52.0
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
v2: No change, drop second patch
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
2.52.0

