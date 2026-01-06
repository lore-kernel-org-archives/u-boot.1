Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B372CEFD16
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 21:55:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B762A83FEE;
	Tue,  6 Jan 2026 22:55:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="usfoseIa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74038838A5; Tue,  6 Jan 2026 22:55:17 +0100 (CET)
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com
 [91.218.175.188])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2870B83759
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 22:55:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1767736514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gn19fw3O8wegAJaEKDyKFKZSjbqxdvecgZfPMWeicLM=;
 b=usfoseIaJG5A0vflbsTBaFkVCNlHb7EZ9bzKMZszHyukU/Jc5/JfwKSqzVF1nmiP9zr6fk
 O1ZAtCklrWcNHp3gqH2Xc/rrmSHtpapZBGwdhhscpBX+FeJp7p++AUfaGPP+AP8W25r0Au
 3CpDHiYgUkkdyld/V6Fmmt/fT1PeLD8=
From: Sean Anderson <sean.anderson@linux.dev>
To: Michal Simek <michal.simek@amd.com>,
	u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Frantisek Bohacek <rutherther@ditigal.xyz>,
 Sean Anderson <sean.anderson@linux.dev>, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 4/4] phy: zynqmp: Only wait for PLL lock "primary" instances
Date: Tue,  6 Jan 2026 16:55:01 -0500
Message-Id: <20260106215501.727524-5-sean.anderson@linux.dev>
In-Reply-To: <20260106215501.727524-1-sean.anderson@linux.dev>
References: <20260106215501.727524-1-sean.anderson@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

For PCIe and DisplayPort, the phy instance represents the controller's
logical lane. Wait for the instance 0 phy's PLL to lock as other
instances will never lock. We do this in xpsgtr_wait_pll_lock so callers
don't have to determine the correct lane themselves.

The original comment is wrong about cumulative wait times. Since we are
just polling a bit, all subsequent waiters will finish immediately.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Link: https://lore.kernel.org/r/20240628205540.3098010-4-sean.anderson@linux.dev
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[ Linux commit 235d8b663ab9e6cc13f8374abfffa559f50b57b6 ]
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/phy/phy-zynqmp.c | 44 +++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/phy/phy-zynqmp.c b/drivers/phy/phy-zynqmp.c
index 6316f0b7619..e5181c59f29 100644
--- a/drivers/phy/phy-zynqmp.c
+++ b/drivers/phy/phy-zynqmp.c
@@ -454,15 +454,32 @@ static int xpsgtr_init(struct phy *x)
 static int xpsgtr_wait_pll_lock(struct phy *phy)
 {
 	struct xpsgtr_dev *gtr_dev = dev_get_priv(phy->dev);
-	struct xpsgtr_phy *gtr_phy;
-	u32 phy_lane = phy->id;
-	int ret = 0;
+	struct xpsgtr_phy *gtr_phy = &gtr_dev->phys[phy->id];
 	unsigned int timeout = TIMEOUT_US;
-
-	gtr_phy = &gtr_dev->phys[phy_lane];
+	u8 protocol = gtr_phy->protocol;
+	int ret = 0;
 
 	dev_dbg(gtr_dev->dev, "Waiting for PLL lock\n");
 
+	/*
+	 * For DP and PCIe, only the instance 0 PLL is used. Switch to that phy
+	 * so we wait on the right PLL.
+	 */
+	if ((protocol == ICM_PROTOCOL_DP || protocol == ICM_PROTOCOL_PCIE) &&
+	    gtr_phy->instance) {
+		int i;
+
+		for (i = 0; i < NUM_LANES; i++) {
+			gtr_phy = &gtr_dev->phys[i];
+
+			if (gtr_phy->protocol == protocol && !gtr_phy->instance)
+				goto got_phy;
+		}
+
+		return -EBUSY;
+	}
+
+got_phy:
 	while (1) {
 		u32 reg = xpsgtr_read_phy(gtr_phy, L0_PLL_STATUS_READ_1);
 
@@ -489,22 +506,7 @@ static int xpsgtr_wait_pll_lock(struct phy *phy)
 
 static int xpsgtr_power_on(struct phy *phy)
 {
-	struct xpsgtr_dev *gtr_dev = dev_get_priv(phy->dev);
-	struct xpsgtr_phy *gtr_phy;
-	u32 phy_lane = phy->id;
-	int ret = 0;
-
-	gtr_phy = &gtr_dev->phys[phy_lane];
-
-	/*
-	 * Wait for the PLL to lock. For DP, only wait on DP0 to avoid
-	 * cumulating waits for both lanes. The user is expected to initialize
-	 * lane 0 last.
-	 */
-	if (gtr_phy->protocol != ICM_PROTOCOL_DP || !gtr_phy->instance)
-		ret = xpsgtr_wait_pll_lock(phy);
-
-	return ret;
+	return xpsgtr_wait_pll_lock(phy);
 }
 
 /*
-- 
2.35.1.1320.gc452695387.dirty

