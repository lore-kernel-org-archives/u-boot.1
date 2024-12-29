Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D800FE7718B
	for <u-boot@archiver.kernel.org>; Sun, 29 Dec 2024 20:54:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9E4D80243;
	Sun, 29 Dec 2024 21:54:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1735505667;
	bh=qc/4efbCl4o0QiEGUsnFgNHHEqaleo57JGOgkmFf6N0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mIRds+bg8/ugkH6plW5hQ6hty9FkX8PjFXyuxWjgniAM4y3DF6BeQnhRVApcKHJI7
	 /1CJC0iBjcLz3tzx1qvQG6QTE2kaxgjMdJ2CJYv2t3Wv1jkoiq3A4WQFY7Aohezp7t
	 linxmLpgBrOSYPKxmw6GJ7d/6XTfbjzCOH5kqXmAXG34EBZ0XBK8rsFkzb1NYXgNiy
	 dfhEH2Rmk8YSRbVrSXWfR2p6xAqRyxwGWc+K498DhRCVuo5gfaEu24eu2LT1yc0bTa
	 ODGOCYB3NLvrfkn3/XsHUvafIPH9bNbNDuwivm6/nNieDTL++I+7fh76f4GOP4PPeJ
	 ODZuTySKG4u+g==
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6FE9804CE; Sun, 29 Dec 2024 21:54:26 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7643C8021D
 for <u-boot@lists.denx.de>; Sun, 29 Dec 2024 21:54:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="YTHniROq"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 623AC1047DC25; Sun, 29 Dec 2024 21:54:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1735505662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qc/4efbCl4o0QiEGUsnFgNHHEqaleo57JGOgkmFf6N0=;
 b=YTHniROqlv3r4513kXWrbbkOK8eBtjT9SL5yju2zXmOTB9cTNWTGSiiMPTGVKrwzV2X+tC
 hfvOhRBrJ8psUc3LX1A2CZJRPCJAp1oMtGSqdG7UAixHjEKXjvwyj0QEDdK4f0+w9IZYSQ
 GPvXbv8aD6f2yFSnyGDFIf4kZr4h/tZmixiXMm3ZR0tvs4lb4v7IpoANb0N64tL2yKwZM5
 HSjlMN/rN6J3RtSlnwDzlY+CVpOBisL9T5Sa2UseQlqmFrIzhyMzHXej2qkdfss/lPao1t
 3r9tjrAGQO23Dd/n8jRAy4z4TFsdVA3jE5k1beoEOqyvC63lqsxO1n/KydEvAA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] net: phy: Add RGMII RX/TX delay handling to DP83822 PHY
Date: Sun, 29 Dec 2024 21:53:26 +0100
Message-ID: <20241229205402.157529-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

The TI DP83822 does have support for configurable RGMII RX/TX clock
shift, add support for parsing DT properties which describe the RX/TX
clock shift configuration and configuration of the matching bits in
RCSR register.

The shift is only configurable on DP83822, the other PHYs supported
by this PHY driver, namely DP83825/DP83826 variants, do not implement
this functionality and the RCSR bits used to configure the clock shift
are missing from those PHYs.

The shift is configurable separately for RX and TX path. Each path can
either enable the shift or disable the shift using single bit. In case
the shift is disabled, a delay of 0ns is added to the path, otherwise
a delay of 3.5ns is added to the path.

Note that the two RCSR bits 11 and 12 have inverted logic, RCSR bit 12
enables RX internal shift when SET, while RCSR bit 11 enables TX shift
when UNSET.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
---
 drivers/net/phy/ti_phy_init.c | 48 ++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/ti_phy_init.c b/drivers/net/phy/ti_phy_init.c
index a0878193ac0..850c0cbec96 100644
--- a/drivers/net/phy/ti_phy_init.c
+++ b/drivers/net/phy/ti_phy_init.c
@@ -10,12 +10,58 @@
 #include <phy.h>
 #include "ti_phy_init.h"
 
+#define DP83822_DEVADDR		0x1f
+
+#define MII_DP83822_RCSR	0x17
+
+/* RCSR bits */
+#define DP83822_RX_CLK_SHIFT	BIT(12)
+#define DP83822_TX_CLK_SHIFT	BIT(11)
+
+/* DP83822 specific RGMII RX/TX delay configuration. */
+static int dp83822_config(struct phy_device *phydev)
+{
+	ofnode node = phy_get_ofnode(phydev);
+	u32 rgmii_delay = 0;
+	u32 rx_delay = 0;
+	u32 tx_delay = 0;
+	int ret;
+
+	ret = ofnode_read_u32(node, "rx-internal-delay-ps", &rx_delay);
+	if (ret) {
+		rx_delay = phydev->interface == PHY_INTERFACE_MODE_RGMII_ID ||
+			   phydev->interface == PHY_INTERFACE_MODE_RGMII_RXID;
+	}
+
+	ret = ofnode_read_u32(node, "tx-internal-delay-ps", &tx_delay);
+	if (ret) {
+		tx_delay = phydev->interface == PHY_INTERFACE_MODE_RGMII_ID ||
+			   phydev->interface == PHY_INTERFACE_MODE_RGMII_TXID;
+	}
+
+	/* Bit set means Receive path internal clock shift is ENABLED */
+	if (rx_delay)
+		rgmii_delay |= DP83822_RX_CLK_SHIFT;
+
+	/* Bit set means Transmit path internal clock shift is DISABLED */
+	if (!tx_delay)
+		rgmii_delay |= DP83822_TX_CLK_SHIFT;
+
+	ret = phy_modify_mmd(phydev, DP83822_DEVADDR, MII_DP83822_RCSR,
+			     DP83822_RX_CLK_SHIFT | DP83822_TX_CLK_SHIFT,
+			     rgmii_delay);
+	if (ret)
+		return ret;
+
+	return genphy_config_aneg(phydev);
+}
+
 U_BOOT_PHY_DRIVER(dp83822) = {
 	.name = "TI DP83822",
 	.uid = 0x2000a240,
 	.mask = 0xfffffff0,
 	.features = PHY_BASIC_FEATURES,
-	.config = &genphy_config_aneg,
+	.config = &dp83822_config,
 	.startup = &genphy_startup,
 	.shutdown = &genphy_shutdown,
 };
-- 
2.45.2

