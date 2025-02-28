Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A53A4C19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 12:48:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E815681110;
	Fri, 28 Feb 2025 13:48:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49DB481110; Fri, 28 Feb 2025 13:48:21 +0100 (CET)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id CA5EB810ED
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 13:48:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-CSE-ConnectionGUID: 2rbf+dAvRgKJYM76aPV4PA==
X-CSE-MsgGUID: VW7bjxs9S9iX2ON6HT0k9w==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 28 Feb 2025 21:48:18 +0900
Received: from rz-ub2404.betafive.net (unknown [10.226.94.53])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8E53642F1838;
 Fri, 28 Feb 2025 21:48:15 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	u-boot@lists.denx.de
Subject: [PATCH v3 4/4] net: phy: ksz90x1: Simplify ksz9131_config_rgmii_delay
Date: Fri, 28 Feb 2025 12:47:55 +0000
Message-ID: <20250228124756.101601-4-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250228124756.101601-1-paul.barker.ct@bp.renesas.com>
References: <20250228124756.101601-1-paul.barker.ct@bp.renesas.com>
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

We can call phy_modify_mmd() instead of manually calling drv->readext()
and drv->writeext().

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
Changes v2->v3:
  - Added Marek's Reviewed-by tag.
Changes v1->v2:
  - Split out of series adding RZ/G2L Ethernet support [1]

 drivers/net/phy/micrel_ksz90x1.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/net/phy/micrel_ksz90x1.c b/drivers/net/phy/micrel_ksz90x1.c
index 727c416fb255..ee8eae1efd92 100644
--- a/drivers/net/phy/micrel_ksz90x1.c
+++ b/drivers/net/phy/micrel_ksz90x1.c
@@ -508,8 +508,7 @@ static int ksz9131_of_load_all_skew_values(struct phy_device *phydev)
 
 static int ksz9131_config_rgmii_delay(struct phy_device *phydev)
 {
-	struct phy_driver *drv = phydev->drv;
-	u16 rxcdll_val, txcdll_val, val;
+	u16 rxcdll_val, txcdll_val;
 	int ret;
 
 	switch (phydev->interface) {
@@ -533,24 +532,15 @@ static int ksz9131_config_rgmii_delay(struct phy_device *phydev)
 		return 0;
 	}
 
-	val = drv->readext(phydev, 0, KSZ9131RN_MMD_COMMON_CTRL_REG,
-			   KSZ9131RN_RXC_DLL_CTRL);
-	val &= ~KSZ9131RN_DLL_CTRL_BYPASS;
-	val |= rxcdll_val;
-	ret = drv->writeext(phydev, 0, KSZ9131RN_MMD_COMMON_CTRL_REG,
-			    KSZ9131RN_RXC_DLL_CTRL, val);
-	if (ret)
+	ret = phy_modify_mmd(phydev, KSZ9131RN_MMD_COMMON_CTRL_REG,
+			     KSZ9131RN_RXC_DLL_CTRL, KSZ9131RN_DLL_CTRL_BYPASS,
+			     rxcdll_val);
+	if (ret < 0)
 		return ret;
 
-	val = drv->readext(phydev, 0, KSZ9131RN_MMD_COMMON_CTRL_REG,
-			   KSZ9131RN_TXC_DLL_CTRL);
-
-	val &= ~KSZ9131RN_DLL_CTRL_BYPASS;
-	val |= txcdll_val;
-	ret = drv->writeext(phydev, 0, KSZ9131RN_MMD_COMMON_CTRL_REG,
-			    KSZ9131RN_TXC_DLL_CTRL, val);
-
-	return ret;
+	return phy_modify_mmd(phydev, KSZ9131RN_MMD_COMMON_CTRL_REG,
+			      KSZ9131RN_TXC_DLL_CTRL, KSZ9131RN_DLL_CTRL_BYPASS,
+			      txcdll_val);
 }
 
 /* Silicon Errata DS80000693B
-- 
2.43.0

