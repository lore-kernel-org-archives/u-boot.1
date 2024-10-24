Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D275CE8E8A
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 15:27:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 711EF8902E;
	Thu, 24 Oct 2024 17:25:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 685C389024; Thu, 24 Oct 2024 17:25:56 +0200 (CEST)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id E19798902E
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 17:25:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.11,229,1725289200"; d="scan'208";a="222903828"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie5.idc.renesas.com with ESMTP; 25 Oct 2024 00:25:46 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.93.183])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 90033400388C;
 Fri, 25 Oct 2024 00:25:31 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	u-boot@lists.denx.de
Subject: [PATCH 08/14] net: phy: ksz90x1: Simplify ksz9131_config_rgmii_delay
Date: Thu, 24 Oct 2024 16:24:42 +0100
Message-Id: <20241024152448.102-9-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241024152448.102-1-paul.barker.ct@bp.renesas.com>
References: <20241024152448.102-1-paul.barker.ct@bp.renesas.com>
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

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/phy/micrel_ksz90x1.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/net/phy/micrel_ksz90x1.c b/drivers/net/phy/micrel_ksz90x1.c
index b64046e0bc72..6515d8feb9be 100644
--- a/drivers/net/phy/micrel_ksz90x1.c
+++ b/drivers/net/phy/micrel_ksz90x1.c
@@ -502,8 +502,7 @@ static int ksz9131_of_load_all_skew_values(struct phy_device *phydev)
 
 static int ksz9131_config_rgmii_delay(struct phy_device *phydev)
 {
-	struct phy_driver *drv = phydev->drv;
-	u16 rxcdll_val, txcdll_val, val;
+	u16 rxcdll_val, txcdll_val;
 	int ret;
 
 	switch (phydev->interface) {
@@ -527,24 +526,15 @@ static int ksz9131_config_rgmii_delay(struct phy_device *phydev)
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

