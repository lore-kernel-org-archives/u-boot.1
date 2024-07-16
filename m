Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E0EC3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 20:46:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7405E88A1F;
	Tue, 16 Jul 2024 22:45:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mail.de header.i=@mail.de header.b="ez21OVJO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD7C5889FB; Tue, 16 Jul 2024 22:45:33 +0200 (CEST)
Received: from shout02.mail.de (shout02.mail.de [IPv6:2001:868:100:600::217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DE4B889FD
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 22:45:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=seb-dev@mail.de
Received: from postfix01.mail.de (postfix01.bt.mail.de [10.0.121.125])
 by shout02.mail.de (Postfix) with ESMTP id E53B2240EC0;
 Tue, 16 Jul 2024 22:45:30 +0200 (CEST)
Received: from smtp01.mail.de (smtp01.bt.mail.de [10.0.121.211])
 by postfix01.mail.de (Postfix) with ESMTP id C93CB80158;
 Tue, 16 Jul 2024 22:45:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
 s=mailde202009; t=1721162730;
 bh=DdEAnAveqsadtFLIqG1xnVBVoUw8w2wBLj0TSBSiypE=;
 h=From:To:Cc:Subject:Date:Message-ID:From:To:CC:Subject:Reply-To;
 b=ez21OVJOKD5hASvCrKeVP8k62emREJ/qYI+tbL86BlRD34zJ0sdlF7eoFeKdNtEJI
 shoAED89LeHjD0m4h2hWjcxRKRG3KD/GCGDuvv5uc5OawYbCopIRe65MINr+TH3gs9
 YQh9YTxFO09YhuYD0e7+SJS9yGpS4fqoqgk/ST3khKa8BIs0US2l5bl4ACB3VP0+ho
 ttvXUpwEYlzrpDvQ0SpYruqd4K6n4mW7zwA6G6BAYebkKl97bTi0AR7r2cEVtYeUKk
 lU5IaQW1Iobs8m4/7kztHIbWZCr7GMyHPPBLjIdSvwj6nfebcZavEkTLCkXZZvaGz9
 QJLot2vWeAgxA==
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp01.mail.de (Postfix) with ESMTPSA id 74A7E240A30;
 Tue, 16 Jul 2024 22:45:30 +0200 (CEST)
From: Sebastian Kropatsch <seb-dev@mail.de>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Subject: [PATCH v2 5/5] phy: rockchip: snps-pcie3: Fix clearing
 PHP_GRF_PCIESEL_CON bits
Date: Tue, 16 Jul 2024 22:42:10 +0200
Message-ID: <f170c88647362d3ed21dcbfa03815a90db44755a.1721161722.git.seb-dev@mail.de>
In-Reply-To: <cover.1721161722.git.seb-dev@mail.de>
References: <cover.1721161722.git.seb-dev@mail.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for
 further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for
 further information)
X-purgate: clean
X-purgate-size: 1856
X-purgate-ID: 154282::1721162730-45DBE670-33151D8B/0/0
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

The pcie1ln_sel bits for the RK3588 are getting set but not cleared due
to an incorrect write mask.
Use a newly introduced constant for the write mask to fix this.
Also introduce a GENMASK-based constant for PCIE30_PHY_MODE.

This fix is adapted from the upstream Linux commit by Sebastian Reichel:
55491a5fa163 ("phy: rockchip-snps-pcie3: fix clearing PHP_GRF_PCIESEL_CON bits")

Fixes: 50e54e80679b ("phy: rockchip: snps-pcie3: Add support for RK3588")
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
Signed-off-by: Sebastian Kropatsch <seb-dev@mail.de>
---
 drivers/phy/rockchip/phy-rockchip-snps-pcie3.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
index fadb77c25c..62b42d1805 100644
--- a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
+++ b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
@@ -36,6 +36,8 @@
 #define RK3588_BIFURCATION_LANE_0_1		BIT(0)
 #define RK3588_BIFURCATION_LANE_2_3		BIT(1)
 #define RK3588_LANE_AGGREGATION			BIT(2)
+#define RK3588_PCIE1LN_SEL_EN			(GENMASK(1, 0) << 16)
+#define RK3588_PCIE30_PHY_MODE_EN		(GENMASK(2, 0) << 16)
 
 /**
  * struct rockchip_p3phy_priv - RK DW PCIe PHY state
@@ -127,13 +129,13 @@ static int rockchip_p3phy_rk3588_init(struct phy *phy)
 
 	reg = mode;
 	regmap_write(priv->phy_grf, RK3588_PCIE3PHY_GRF_CMN_CON0,
-		     (0x7 << 16) | reg);
+		     RK3588_PCIE30_PHY_MODE_EN | reg);
 
 	/* Set pcie1ln_sel in PHP_GRF_PCIESEL_CON */
-	reg = mode & 3;
+	reg = mode & (RK3588_BIFURCATION_LANE_0_1 | RK3588_BIFURCATION_LANE_2_3);
 	if (reg)
 		regmap_write(priv->pipe_grf, PHP_GRF_PCIESEL_CON,
-			     (reg << 16) | reg);
+			     RK3588_PCIE1LN_SEL_EN | reg);
 
 	reset_deassert(&priv->p30phy);
 	udelay(1);
-- 
2.43.0

