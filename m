Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CBA0C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 20:46:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08F2388A1A;
	Tue, 16 Jul 2024 22:45:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mail.de header.i=@mail.de header.b="I6m7OILh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA2D68881D; Tue, 16 Jul 2024 22:45:33 +0200 (CEST)
Received: from shout02.mail.de (shout02.mail.de [IPv6:2001:868:100:600::217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD6CD889E0
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 22:45:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=seb-dev@mail.de
Received: from postfix01.mail.de (postfix01.bt.mail.de [10.0.121.125])
 by shout02.mail.de (Postfix) with ESMTP id 81041240F4F;
 Tue, 16 Jul 2024 22:45:30 +0200 (CEST)
Received: from smtp01.mail.de (smtp01.bt.mail.de [10.0.121.211])
 by postfix01.mail.de (Postfix) with ESMTP id 65CF680158;
 Tue, 16 Jul 2024 22:45:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
 s=mailde202009; t=1721162730;
 bh=Ws7Q7pIiotMK8jOL5VnqrggrQrAMNQVYSvZPhAuMN9I=;
 h=From:To:Cc:Subject:Date:Message-ID:From:To:CC:Subject:Reply-To;
 b=I6m7OILhKk34iAQH7WSUa35lV2Npi2szKDdWfW1XvyXbWaDjZSnksIJKU6Som3KdP
 D4TLoC60u7GAcChkwkk6qIr/gtqB8fl9GduAgGLLO8T5OEob3tQAC8GNcIUDTQMqlg
 7kG9dckAkDnmSUOaRbm108mgUdVFgLAXbYrDZxR4GlR82wGbUgJHL6MrsIEtgg+MRs
 uu+rTLT/cxrxtFfbrTPf1LyT64k5C81quyqrJAdl3k+UdIlt5f3LnFvEk0rBeiJKCJ
 JvHMvm9ek9RGPXybUVguvaEyuIGzk2smXOsJkAZk5lkK9tEI2LgJ6uyRQK6NAdTApd
 BvuTzNe/tE33g==
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp01.mail.de (Postfix) with ESMTPSA id 1798A240A08;
 Tue, 16 Jul 2024 22:45:30 +0200 (CEST)
From: Sebastian Kropatsch <seb-dev@mail.de>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Subject: [PATCH v2 4/5] phy: rockchip: snps-pcie3: Fix bifurcation for RK3588
Date: Tue, 16 Jul 2024 22:42:09 +0200
Message-ID: <4405be82fdda87ebf9961f95fe3952a624e1f959.1721161722.git.seb-dev@mail.de>
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
X-purgate-size: 2469
X-purgate-ID: 154282::1721162730-45DBE670-56BBCE2E/0/0
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
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
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

