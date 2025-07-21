Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FEEEC83F1A
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 22:08:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C2E9831E4;
	Tue, 22 Jul 2025 00:08:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="dUhpObd5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0A21830EA; Tue, 22 Jul 2025 00:07:58 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78120831E4
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 00:07:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=dd2a=2D=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1753135675; bh=29sDlvgh4WExxF8f7IqiFwNiFgoDZArUPxf0mC715ZQ=;
 b=dUhpObd5oCioTY0l+187xNNykWsWqMMi7bMEPr5qys5g+Xh+DQsdxLlBynYMGioJKEEWtJXqr
 aeYcSFMNUiI1+uBr4mCBpQ1Aw9VeoRN/aEOV2s6ZJ3TY+LQJagUCl56XRag6AlCA/ND8rGxY/b2
 +EP4gxD5C/MhW2ZoPJdPdqCfxdBmQmkPh+7ZEFdcGJ4I8X9x09pLtht8u2d26k7XDqisqlHbwIi
 M4G3LR/BgWBFAto+ez74BkUYChPt7RN7owWUxsVT2JRMg6+nGZJHHwRQlmQUsGLYHdSLnxgQd2P
 KCpkHcZk/hrHvQeNPTKDSfLeIUKR+QiaX/3L8r84HMeg==
X-Forward-Email-ID: 687eba36285c5226412894f4
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 03/10] phy: rockchip: naneng-combphy: Fix Generic PHY
 reference counting
Date: Mon, 21 Jul 2025 22:07:12 +0000
Message-ID: <20250721220734.1617117-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721220734.1617117-1-jonas@kwiboo.se>
References: <20250721220734.1617117-1-jonas@kwiboo.se>
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

Generic PHY reference counting helps ensure driver ops for init/exit and
power on/off are called at correct state. For this to work the PHY
driver must initialize PHY-id to a persistent value in of_xlate ops.

The Rockchip COMBPHY driver does not initialize the PHY-id field, this
typically lead to use of unshared reference counting among different
struct phy instances.

Initialize the PHY-id in of_xlate ops to ensure use of shared reference
counting among all struct phy instances.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
index 5145b517aa4c..a3038d067d3a 100644
--- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
+++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
@@ -223,6 +223,7 @@ static int rockchip_combphy_xlate(struct phy *phy, struct ofnode_phandle_args *a
 		return -EINVAL;
 	}
 
+	phy->id = priv->id;
 	priv->mode = args->args[0];
 
 	return 0;
-- 
2.50.1

