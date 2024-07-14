Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB404C3DA49
	for <u-boot@archiver.kernel.org>; Sun, 14 Jul 2024 21:28:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A71BE88618;
	Sun, 14 Jul 2024 23:28:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mail.de header.i=@mail.de header.b="GD1ZTTAY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDEA788403; Sun, 14 Jul 2024 23:28:16 +0200 (CEST)
Received: from shout01.mail.de (shout01.mail.de [IPv6:2001:868:100:600::216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D2948855E
 for <u-boot@lists.denx.de>; Sun, 14 Jul 2024 23:28:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=seb-dev@mail.de
Received: from postfix02.mail.de (postfix02.bt.mail.de [10.0.121.126])
 by shout01.mail.de (Postfix) with ESMTP id C2291240C89;
 Sun, 14 Jul 2024 23:28:12 +0200 (CEST)
Received: from smtp01.mail.de (smtp04.bt.mail.de [10.0.121.214])
 by postfix02.mail.de (Postfix) with ESMTP id A5253A03C3;
 Sun, 14 Jul 2024 23:28:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
 s=mailde202009; t=1720992492;
 bh=4QZnwOSiJrdc8CM0gyh5UyGOJnW37wt/Ec1kUfzS5XI=;
 h=From:To:Cc:Subject:Date:Message-ID:From:To:CC:Subject:Reply-To;
 b=GD1ZTTAYS78jPC7JAHVtZX6/VhrKiJU2wMLGjGQ20YcDNZivzuf7wbRA3wxOxwB+F
 DRwVXrrE6Hr2FpLxwIa9XcgD0rbQr0X3yi0l0Lpgl16nUJt8zUo2XZlk8ltFApsNma
 bvXEC6XN/g4fKcG6lKdBWIMAqgIP9SZUjxyevGWuV5n1GKyPJ1W0Rrdv7ezDx4rZHt
 iwJEoIZp5DlkKvCmjxNW+jzPnU3fhu1NMrcPjXqcTQra2MH7hY5Pf5tOmjbdVe+FI8
 AX3IvN+vP0FSNYHtUjg4voAHJwRyzvU3CjX5KPE7ni4a924yKZloESJXpImLUF45TO
 8qb2tnt4o47Cw==
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp01.mail.de (Postfix) with ESMTPSA id 4F4A4240A52;
 Sun, 14 Jul 2024 23:28:12 +0200 (CEST)
From: Sebastian Kropatsch <seb-dev@mail.de>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Subject: [PATCH 4/4] phy: rockchip: snps-pcie3: Fix clearing
 PHP_GRF_PCIESEL_CON bits
Date: Sun, 14 Jul 2024 23:23:43 +0200
Message-ID: <95f198afc2de1fd09940bdea1b55be3573993f12.1720988760.git.seb-dev@mail.de>
In-Reply-To: <cover.1720988760.git.seb-dev@mail.de>
References: <cover.1720988760.git.seb-dev@mail.de>
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
X-purgate-size: 1803
X-purgate-ID: 154282::1720992492-E37EF338-EF821B91/0/0
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

