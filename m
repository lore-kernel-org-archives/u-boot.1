Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 385F4C3DA42
	for <u-boot@archiver.kernel.org>; Sun, 14 Jul 2024 21:28:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F842885E7;
	Sun, 14 Jul 2024 23:28:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mail.de header.i=@mail.de header.b="A37QGNWg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC556884BC; Sun, 14 Jul 2024 23:28:15 +0200 (CEST)
Received: from shout02.mail.de (shout02.mail.de [IPv6:2001:868:100:600::217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A621E884D0
 for <u-boot@lists.denx.de>; Sun, 14 Jul 2024 23:28:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=seb-dev@mail.de
Received: from postfix02.mail.de (postfix02.bt.mail.de [10.0.121.126])
 by shout02.mail.de (Postfix) with ESMTP id 5B740240D48;
 Sun, 14 Jul 2024 23:28:12 +0200 (CEST)
Received: from smtp01.mail.de (smtp04.bt.mail.de [10.0.121.214])
 by postfix02.mail.de (Postfix) with ESMTP id 3F2F8A03C3;
 Sun, 14 Jul 2024 23:28:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
 s=mailde202009; t=1720992492;
 bh=psONdG7S62mjWocp3Gvwkehr163+a72o1H3sg43G9No=;
 h=From:To:Cc:Subject:Date:Message-ID:From:To:CC:Subject:Reply-To;
 b=A37QGNWgpkH8a/Dp0RgvjLAskDHwL1bnai6UVG60zU3dcuD86ERoAv5v1E2jRl0HR
 1qk9JjWgI+CHJ/vMRbeCUhlXxWEGdhHqLzXZZUu9AGfH1HJOxDXktMrp/DQV59I8hK
 5qRI3UfwBns3Duvg3b9dH7Lbfd1UmVqqMh6Ei0rQ+TXJukHoyXVB397S63GPhe5uFg
 A93klHFqnEgATfoTXchhkeyRBiLW9Y6aeVry1dWCaKwISwMDtAjMa5dbnPa3k23crT
 fo/kS/Eg2FoJHi+52pts/HaQgxKmBLPN0CsO0LmjOvubROLpo8+rQlA+hgVCZtSv6v
 CzUCDyNEg2O7w==
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp01.mail.de (Postfix) with ESMTPSA id E2D0D240A49;
 Sun, 14 Jul 2024 23:28:11 +0200 (CEST)
From: Sebastian Kropatsch <seb-dev@mail.de>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Subject: [PATCH 3/4] phy: rockchip: snps-pcie3: Fix bifurcation for RK3588
Date: Sun, 14 Jul 2024 23:23:42 +0200
Message-ID: <202cee2c0425e64a4d0e8d0f02d16584b75a1016.1720988760.git.seb-dev@mail.de>
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
X-purgate-size: 2416
X-purgate-ID: 154282::1720992492-E37EF338-2A64CFC6/0/0
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

Misconfigured `PHP_GRF_PCIESEL` values are causing bifurcation issues,
for example on the FriendlyElec CM3588 NAS board which uses bifurcation
on both PCIe PCIe ports (all four lanes) to enable four M.2 NVMe
sockets. Without this fix, NVMe devices do not get recognized.

Correct the `PHP_GRF_PCIESEL` register configuration and simplify the
bifurcation logic, enabling proper PCIe bifurcation based on the
data-lanes property.

This fix is adapted from the upstream Linux commit by Michal Tomek:
f8020dfb311d ("phy: rockchip-snps-pcie3: fix bifurcation on rk3588")

Fixes: 50e54e80679b ("phy: rockchip: snps-pcie3: Add support for RK3588")
Signed-off-by: Sebastian Kropatsch <seb-dev@mail.de>
---
 .../phy/rockchip/phy-rockchip-snps-pcie3.c    | 24 +++++++------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
index 1c94875aaa..fadb77c25c 100644
--- a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
+++ b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
@@ -108,7 +108,7 @@ static int rockchip_p3phy_rk3588_init(struct phy *phy)
 {
 	struct rockchip_p3phy_priv *priv = dev_get_priv(phy->dev);
 	u32 reg = 0;
-	u8 mode = 0;
+	u8 mode = RK3588_LANE_AGGREGATION; /* Lane aggregation by default */
 	int ret;
 
 	/* Deassert PCIe PMA output clamp mode */
@@ -117,28 +117,20 @@ static int rockchip_p3phy_rk3588_init(struct phy *phy)
 
 	/* Set bifurcation if needed */
 	for (int i = 0; i < priv->num_lanes; i++) {
-		if (!priv->lanes[i])
-			mode |= (BIT(i) << 3);
-
 		if (priv->lanes[i] > 1)
-			mode |= (BIT(i) >> 1);
-	}
-
-	if (!mode) {
-		reg = RK3588_LANE_AGGREGATION;
-	} else {
-		if (mode & (BIT(0) | BIT(1)))
-			reg |= RK3588_BIFURCATION_LANE_0_1;
-
-		if (mode & (BIT(2) | BIT(3)))
-			reg |= RK3588_BIFURCATION_LANE_2_3;
+			mode &= ~RK3588_LANE_AGGREGATION;
+		if (priv->lanes[i] == 3)
+			mode |= RK3588_BIFURCATION_LANE_0_1;
+		if (priv->lanes[i] == 4)
+			mode |= RK3588_BIFURCATION_LANE_2_3;
 	}
 
+	reg = mode;
 	regmap_write(priv->phy_grf, RK3588_PCIE3PHY_GRF_CMN_CON0,
 		     (0x7 << 16) | reg);
 
 	/* Set pcie1ln_sel in PHP_GRF_PCIESEL_CON */
-	reg = (mode & (BIT(6) | BIT(7))) >> 6;
+	reg = mode & 3;
 	if (reg)
 		regmap_write(priv->pipe_grf, PHP_GRF_PCIESEL_CON,
 			     (reg << 16) | reg);
-- 
2.43.0

