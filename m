Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0832CC87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 17:53:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20E3383923;
	Tue,  5 Aug 2025 19:53:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76C91841FA; Tue,  5 Aug 2025 19:53:18 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB9E883885
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 19:53:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 195EA1F0004B
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 17:53:15 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 80522B011F4; Tue,  5 Aug 2025 17:53:14 +0000 (UTC)
Received: from localhost.localdomain (unknown [192.168.1.64])
 by laika.paulk.fr (Postfix) with ESMTP id 974CDB011F0;
 Tue,  5 Aug 2025 17:48:30 +0000 (UTC)
From: Paul Kocialkowski <paulk@sys-base.io>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Chen-Yu Tsai <wens@csie.org>,
 Icenowy Zheng <icenowy@aosc.xyz>, Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH v2 10/11] net: sun8i-emac: Remove internal PHY config default
 value
Date: Tue,  5 Aug 2025 19:48:26 +0200
Message-ID: <20250805174827.3696191-11-paulk@sys-base.io>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250805174827.3696191-1-paulk@sys-base.io>
References: <20250805174827.3696191-1-paulk@sys-base.io>
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

From: Paul Kocialkowski <contact@paulk.fr>

We know about all the relevant fields in the syscon register so there
is no reason to read it first and modify it.

Build the register from scratch instead, with all relevant fields set.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 drivers/net/sun8i_emac.c | 32 +++++++++-----------------------
 1 file changed, 9 insertions(+), 23 deletions(-)

diff --git a/drivers/net/sun8i_emac.c b/drivers/net/sun8i_emac.c
index 8433e7db2654..6e95392b379b 100644
--- a/drivers/net/sun8i_emac.c
+++ b/drivers/net/sun8i_emac.c
@@ -57,10 +57,9 @@
 #define TX_TOTAL_BUFSIZE	(CFG_ETH_BUFSIZE * CFG_TX_DESCR_NUM)
 #define RX_TOTAL_BUFSIZE	(CFG_ETH_BUFSIZE * CFG_RX_DESCR_NUM)
 
-#define H3_EPHY_DEFAULT_VALUE	0x58000
-#define H3_EPHY_DEFAULT_MASK	GENMASK(31, 15)
 #define H3_EPHY_ADDR_SHIFT	20
 #define REG_PHY_ADDR_MASK	GENMASK(4, 0)
+#define H3_EPHY_CLK_SEL		BIT(18) /* 1: 24MHz, 0: 25MHz */
 #define H3_EPHY_LED_POL		BIT(17)	/* 1: active low, 0: active high */
 #define H3_EPHY_SHUTDOWN	BIT(16)	/* 1: shutdown, 0: power up */
 #define H3_EPHY_SELECT		BIT(15) /* 1: internal PHY, 0: external PHY */
@@ -287,35 +286,22 @@ static void sun8i_adjust_link(struct emac_eth_dev *priv,
 	writel(v, priv->mac_reg + EMAC_CTL0);
 }
 
-static u32 sun8i_emac_set_syscon_ephy(struct emac_eth_dev *priv, u32 reg)
+static int sun8i_emac_set_syscon(struct sun8i_eth_pdata *pdata,
+				 struct emac_eth_dev *priv)
 {
+	u32 reg = 0;
+
 	if (priv->use_internal_phy) {
 		/* H3 based SoC's that has an Internal 100MBit PHY
 		 * needs to be configured and powered up before use
 		*/
-		reg &= ~H3_EPHY_DEFAULT_MASK;
-		reg |=  H3_EPHY_DEFAULT_VALUE;
 		reg |= priv->phyaddr << H3_EPHY_ADDR_SHIFT;
-		reg &= ~H3_EPHY_SHUTDOWN;
-		return reg | H3_EPHY_SELECT;
+		reg |= H3_EPHY_CLK_SEL;
+		reg |= H3_EPHY_SELECT;
+	} else {
+		reg |= H3_EPHY_SHUTDOWN;
 	}
 
-	/* This is to select External Gigabit PHY on those boards with
-	 * an internal PHY. Does not hurt on other SoCs. Linux does
-	 * it as well.
-	 */
-	return reg & ~H3_EPHY_SELECT;
-}
-
-static int sun8i_emac_set_syscon(struct sun8i_eth_pdata *pdata,
-				 struct emac_eth_dev *priv)
-{
-	u32 reg;
-
-	reg = readl(priv->sysctl_reg);
-
-	reg = sun8i_emac_set_syscon_ephy(priv, reg);
-
 	reg &= ~(SC_ETCS_MASK | SC_EPIT);
 	if (priv->variant->support_rmii)
 		reg &= ~SC_RMII_EN;
-- 
2.49.0

