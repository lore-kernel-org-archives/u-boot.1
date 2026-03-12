Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11556FED2FE
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 10:10:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4278A8419C;
	Thu, 12 Mar 2026 11:10:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="WInV0OlE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6199A841B9; Thu, 12 Mar 2026 11:10:23 +0100 (CET)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DD2B841A2
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 11:10:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Max.Merchel@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=viDnG4g3GXdpCICpfEDXe3xDZf7dzSBTR0da2/RE8L4=; b=WInV0OlEyCrL2OIQHLNSLCwz3Q
 TqgEFGnmUPBv6kOU+N5JEz59HfA9O0GvAEKHYptOVbJtkfzvQcj1LgSLLRioBB9AizPHUcPLVKviC
 lRgLslb3U/Wm9JwvDY+JW9Ojxko26jU5uDbZRVo18BTpUZSHmlS2JPgwCTvB9xgXSr3W4c9N0Oy1k
 Z4HvD9FydeExWPprssTr1J6Ak3kGEInuD+f7Fllvox4/7+FRpQJWX7/fKPQzzCOHMbSfC9oFv87j9
 6wopaoygL5g7rZEPuohQ8KycCkJL1bhQEQPHTkUwaSVT7CczYMoMbx9XpYrE7nnaVnW5gtxF/jczO
 BKSCf42g==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1w0czk-000AeI-1y; Thu, 12 Mar 2026 11:10:20 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1w0cnS-000Fyo-30; Thu, 12 Mar 2026 10:57:38 +0100
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, Paul Gerber <Paul.Gerber@ew.tq-group.com>
Subject: [PATCH 12/13] board: tqma6: use runtime SoC detection in enet setup
Date: Thu, 12 Mar 2026 10:57:08 +0100
Message-ID: <20260312095711.3219756-13-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312095711.3219756-1-Max.Merchel@ew.tq-group.com>
References: <20260312095711.3219756-1-Max.Merchel@ew.tq-group.com>
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

Select the appropriate settings based on the CPU type during
Ethernet configuration.

Signed-off-by: Paul Gerber <Paul.Gerber@ew.tq-group.com>
Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 board/tq/tqma6/tqma6_mba6.c | 124 ++++++++++++++++++++----------------
 1 file changed, 69 insertions(+), 55 deletions(-)

diff --git a/board/tq/tqma6/tqma6_mba6.c b/board/tq/tqma6/tqma6_mba6.c
index 32aeb1b07c8..f1b9dc8d372 100644
--- a/board/tq/tqma6/tqma6_mba6.c
+++ b/board/tq/tqma6/tqma6_mba6.c
@@ -33,21 +33,21 @@
 
 #include "../common/tq_bb.h"
 
-#if defined(CONFIG_TQMA6Q)
+#define TQMA6Q_IOMUX_SW_PAD_CTRL_GRP_DDR_TYPE_RGMII	0x02e0790
+#define TQMA6Q_IOMUX_SW_PAD_CTRL_GRP_RGMII_TERM		0x02e07ac
 
-#define IOMUX_SW_PAD_CTRL_GRP_DDR_TYPE_RGMII	0x02e0790
-#define IOMUX_SW_PAD_CTRL_GRP_RGMII_TERM	0x02e07ac
+#define TQMA6DL_IOMUX_SW_PAD_CTRL_GRP_DDR_TYPE_RGMII	0x02e0768
+#define TQMA6DL_IOMUX_SW_PAD_CTRL_GRP_RGMII_TERM	0x02e0788
 
-#elif defined(CONFIG_TQMA6S) || defined(CONFIG_TQMA6DL)
+#define TQMA6Q_MBA6X_KSZ9031_CTRL_SKEW	0x0032
+#define TQMA6Q_MBA6X_KSZ9031_CLK_SKEW	0x03ff
+#define TQMA6Q_MBA6X_KSZ9031_RX_SKEW	0x3333
+#define TQMA6Q_MBA6X_KSZ9031_TX_SKEW	0x2036
 
-#define IOMUX_SW_PAD_CTRL_GRP_DDR_TYPE_RGMII	0x02e0768
-#define IOMUX_SW_PAD_CTRL_GRP_RGMII_TERM	0x02e0788
-
-#else
-
-#error "need to select module"
-
-#endif
+#define TQMA6DL_MBA6X_KSZ9031_CTRL_SKEW	0x0030
+#define TQMA6DL_MBA6X_KSZ9031_CLK_SKEW	0x03ff
+#define TQMA6DL_MBA6X_KSZ9031_RX_SKEW	0x3333
+#define TQMA6DL_MBA6X_KSZ9031_TX_SKEW	0x2052
 
 /* disable on die termination for RGMII */
 #define IOMUX_SW_PAD_CTRL_GRP_RGMII_TERM_DISABLE	0x00000000
@@ -63,10 +63,17 @@ static void mba6_setup_iomuxc_enet(void)
 	/* clear gpr1[ENET_CLK_SEL] for externel clock */
 	clrbits_le32(&iomuxc_regs->gpr[1], IOMUXC_GPR1_ENET_CLK_SEL_MASK);
 
-	__raw_writel(IOMUX_SW_PAD_CTRL_GRP_RGMII_TERM_DISABLE,
-		     (void *)IOMUX_SW_PAD_CTRL_GRP_RGMII_TERM);
-	__raw_writel(IOMUX_SW_PAD_CTRL_GRP_DDR_TYPE_RGMII_1P5V,
-		     (void *)IOMUX_SW_PAD_CTRL_GRP_DDR_TYPE_RGMII);
+	if (is_mx6sdl()) {
+		__raw_writel(IOMUX_SW_PAD_CTRL_GRP_RGMII_TERM_DISABLE,
+			     (void *)TQMA6DL_IOMUX_SW_PAD_CTRL_GRP_RGMII_TERM);
+		__raw_writel(IOMUX_SW_PAD_CTRL_GRP_DDR_TYPE_RGMII_1P5V,
+			     (void *)TQMA6DL_IOMUX_SW_PAD_CTRL_GRP_DDR_TYPE_RGMII);
+	} else if (is_mx6dq()) {
+		__raw_writel(IOMUX_SW_PAD_CTRL_GRP_RGMII_TERM_DISABLE,
+			     (void *)TQMA6Q_IOMUX_SW_PAD_CTRL_GRP_RGMII_TERM);
+		__raw_writel(IOMUX_SW_PAD_CTRL_GRP_DDR_TYPE_RGMII_1P5V,
+			     (void *)TQMA6Q_IOMUX_SW_PAD_CTRL_GRP_DDR_TYPE_RGMII);
+	}
 }
 
 int board_mmc_get_env_dev(int devno)
@@ -81,45 +88,52 @@ int board_mmc_get_env_dev(int devno)
 
 int board_phy_config(struct phy_device *phydev)
 {
-/*
- * optimized pad skew values depends on CPU variant on the TQMa6x module:
- * CONFIG_TQMA6Q: i.MX6Q/D
- * CONFIG_TQMA6S: i.MX6S
- * CONFIG_TQMA6DL: i.MX6DL
- */
-#if defined(CONFIG_TQMA6Q)
-#define MBA6X_KSZ9031_CTRL_SKEW	0x0032
-#define MBA6X_KSZ9031_CLK_SKEW	0x03ff
-#define MBA6X_KSZ9031_RX_SKEW	0x3333
-#define MBA6X_KSZ9031_TX_SKEW	0x2036
-#elif defined(CONFIG_TQMA6S) || defined(CONFIG_TQMA6DL)
-#define MBA6X_KSZ9031_CTRL_SKEW	0x0030
-#define MBA6X_KSZ9031_CLK_SKEW	0x03ff
-#define MBA6X_KSZ9031_RX_SKEW	0x3333
-#define MBA6X_KSZ9031_TX_SKEW	0x2052
-#else
-#error
-#endif
-	/* min rx/tx ctrl delay */
-	ksz9031_phy_extended_write(phydev, 2,
-				   MII_KSZ9031_EXT_RGMII_CTRL_SIG_SKEW,
-				   MII_KSZ9031_MOD_DATA_NO_POST_INC,
-				   MBA6X_KSZ9031_CTRL_SKEW);
-	/* min rx delay */
-	ksz9031_phy_extended_write(phydev, 2,
-				   MII_KSZ9031_EXT_RGMII_RX_DATA_SKEW,
-				   MII_KSZ9031_MOD_DATA_NO_POST_INC,
-				   MBA6X_KSZ9031_RX_SKEW);
-	/* max tx delay */
-	ksz9031_phy_extended_write(phydev, 2,
-				   MII_KSZ9031_EXT_RGMII_TX_DATA_SKEW,
-				   MII_KSZ9031_MOD_DATA_NO_POST_INC,
-				   MBA6X_KSZ9031_TX_SKEW);
-	/* rx/tx clk skew */
-	ksz9031_phy_extended_write(phydev, 2,
-				   MII_KSZ9031_EXT_RGMII_CLOCK_SKEW,
-				   MII_KSZ9031_MOD_DATA_NO_POST_INC,
-				   MBA6X_KSZ9031_CLK_SKEW);
+	/*
+	 * optimized pad skew values depends on CPU variant on the TQMa6x module:
+	 */
+	if (is_mx6sdl()) {
+		/* min rx/tx ctrl delay */
+		ksz9031_phy_extended_write(phydev, 2,
+					   MII_KSZ9031_EXT_RGMII_CTRL_SIG_SKEW,
+					   MII_KSZ9031_MOD_DATA_NO_POST_INC,
+					   TQMA6DL_MBA6X_KSZ9031_CTRL_SKEW);
+		/* min rx delay */
+		ksz9031_phy_extended_write(phydev, 2,
+					   MII_KSZ9031_EXT_RGMII_RX_DATA_SKEW,
+					   MII_KSZ9031_MOD_DATA_NO_POST_INC,
+					   TQMA6DL_MBA6X_KSZ9031_RX_SKEW);
+		/* max tx delay */
+		ksz9031_phy_extended_write(phydev, 2,
+					   MII_KSZ9031_EXT_RGMII_TX_DATA_SKEW,
+					   MII_KSZ9031_MOD_DATA_NO_POST_INC,
+					   TQMA6DL_MBA6X_KSZ9031_TX_SKEW);
+		/* rx/tx clk skew */
+		ksz9031_phy_extended_write(phydev, 2,
+					   MII_KSZ9031_EXT_RGMII_CLOCK_SKEW,
+					   MII_KSZ9031_MOD_DATA_NO_POST_INC,
+					   TQMA6DL_MBA6X_KSZ9031_CLK_SKEW);
+	} else if (is_mx6dq()) {
+		/* min rx/tx ctrl delay */
+		ksz9031_phy_extended_write(phydev, 2,
+					   MII_KSZ9031_EXT_RGMII_CTRL_SIG_SKEW,
+					   MII_KSZ9031_MOD_DATA_NO_POST_INC,
+					   TQMA6Q_MBA6X_KSZ9031_CTRL_SKEW);
+		/* min rx delay */
+		ksz9031_phy_extended_write(phydev, 2,
+					   MII_KSZ9031_EXT_RGMII_RX_DATA_SKEW,
+					   MII_KSZ9031_MOD_DATA_NO_POST_INC,
+					   TQMA6Q_MBA6X_KSZ9031_RX_SKEW);
+		/* max tx delay */
+		ksz9031_phy_extended_write(phydev, 2,
+					   MII_KSZ9031_EXT_RGMII_TX_DATA_SKEW,
+					   MII_KSZ9031_MOD_DATA_NO_POST_INC,
+					   TQMA6Q_MBA6X_KSZ9031_TX_SKEW);
+		/* rx/tx clk skew */
+		ksz9031_phy_extended_write(phydev, 2,
+					   MII_KSZ9031_EXT_RGMII_CLOCK_SKEW,
+					   MII_KSZ9031_MOD_DATA_NO_POST_INC,
+					   TQMA6Q_MBA6X_KSZ9031_CLK_SKEW);
+	}
 
 	phydev->drv->config(phydev);
 
-- 
2.43.0

