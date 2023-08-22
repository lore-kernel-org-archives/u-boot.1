Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B6DEE49A3
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 12:14:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76FDD86487;
	Tue, 22 Aug 2023 14:14:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="n53e56Sc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A11BF86475; Tue, 22 Aug 2023 14:14:06 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05A2D83F7A
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 14:14:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 80307654D4;
 Tue, 22 Aug 2023 12:14:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63537C433C7;
 Tue, 22 Aug 2023 12:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692706441;
 bh=AfWRRdM6Jnrhne+MEUwdSK9/EejXhrl7fM3yplEbUbQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=n53e56SclEet3xDNJXiN7JNtXBKgTUW3/t01GE7xXw7hLHLCrpEjDlhOLE2BThZvj
 MplEDwfrTksRUqRXZf+h0O9Uhp1oFsQTZOwO/SRE3PoY1Yei11iVn/HrSwYWUCpiJP
 3cTfI0GV3bBqnAawajwzuzft3EohSrbNhA+HUc7OtmI0mLotMk5PYIF1+8h197MBVa
 fkS8UUXKdXXqQBIg+OD5xw8i/Wx/6ngN9NFS9VCkchlsrn+lwi4DThmv23C1cN2e8h
 W2E+GIeLbkxwqybQridmEOFHtu4+KHG87sX5h5AyaMIZn/s2pLfzxjv8idRJ/yZMgL
 061lye2mYyD6Q==
From: Roger Quadros <rogerq@kernel.org>
To: nm@ti.com,
	joe.hershberger@ni.com
Cc: robertcnelson@gmail.com, jkridner@beagleboard.org, r-gunasekaran@ti.com,
 s-vadapalli@ti.com, srk@ti.com, trini@konsulko.com, u-boot@lists.denx.de,
 Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 1/2] net: ti: am65-cpsw-nuss: Workaround for buggy PHY/Board
Date: Tue, 22 Aug 2023 15:13:49 +0300
Message-Id: <20230822121350.51324-2-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822121350.51324-1-rogerq@kernel.org>
References: <20230822121350.51324-1-rogerq@kernel.org>
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

Beagleplay has a buggy Ethernet PHY implementation for the Gigabit
PHY in the sense that it is non responsive over MDIO immediately
after power-up/reset.

We need to either try multiple times or wait sufficiently long enough
(couple of 10s of ms?) before the PHY begins to respond correctly.

One theory is that the PHY is configured to operate on MDIO address 0
which it treats as a special broadcast address.

Datasheet states:
"PHYAD (config pins) sets the PHY address for the device.
The RTL8211F(I)/RTL8211FD(I) supports PHY addresses from 0x01 to 0x07.
Note 1: An MDIO command with PHY address=0 is a broadcast from the MAC;
each PHY device should respond."

This issue is not seen with the other PHY (different make) on the board
which is configured for address 0x1.

As a woraround we try to probe the PHY multiple times instead of giving
up on the first attempt.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ti/am65-cpsw-nuss.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ti/am65-cpsw-nuss.c b/drivers/net/ti/am65-cpsw-nuss.c
index 51a8167d14..4f8a2f9b93 100644
--- a/drivers/net/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ti/am65-cpsw-nuss.c
@@ -27,6 +27,7 @@
 #include <syscon.h>
 #include <linux/bitops.h>
 #include <linux/soc/ti/ti-udma.h>
+#include <linux/delay.h>
 
 #include "cpsw_mdio.h"
 
@@ -678,14 +679,22 @@ static int am65_cpsw_phy_init(struct udevice *dev)
 	struct am65_cpsw_priv *priv = dev_get_priv(dev);
 	struct am65_cpsw_common *cpsw_common = priv->cpsw_common;
 	struct eth_pdata *pdata = dev_get_plat(dev);
-	struct phy_device *phydev;
 	u32 supported = PHY_GBIT_FEATURES;
+	struct phy_device *phydev;
+	int tries;
 	int ret;
 
-	phydev = phy_connect(cpsw_common->bus,
-			     priv->phy_addr,
-			     priv->dev,
-			     pdata->phy_interface);
+	/* Some boards (e.g. beagleplay) don't work on first go */
+	for (tries = 1; tries <= 5; tries++) {
+		phydev = phy_connect(cpsw_common->bus,
+				     priv->phy_addr,
+				     priv->dev,
+				     pdata->phy_interface);
+		if (phydev)
+			break;
+
+		mdelay(10);
+	}
 
 	if (!phydev) {
 		dev_err(dev, "phy_connect() failed\n");
-- 
2.34.1

