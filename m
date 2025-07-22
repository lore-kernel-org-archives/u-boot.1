Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC25C83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 06:06:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE0CD830C8;
	Tue, 22 Jul 2025 08:06:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZnzPlzZN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2933A830F6; Tue, 22 Jul 2025 08:06:12 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5363182D88
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 08:06:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56M660bv1428147;
 Tue, 22 Jul 2025 01:06:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1753164360;
 bh=nytaGSi6Qgr0fjF+RACgSeyO7+LUFnxLncAnwB0/t9Y=;
 h=From:To:CC:Subject:Date;
 b=ZnzPlzZNAixVbuq57xj4yMfVZt7CLLDRo87NYaYMMc5W4yvnCcSF3iEHXGz9gQxMa
 UW43JKwP2aPWD+ZzP/hK93FGGQcYKQ6aWyRxx8VaAiFMhSjO9KCo0O5se8bPb+rgYz
 xrW32wi5onQ9KlMluy1p+sNSQTk/tpEiqaiYyF0Q=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56M6605k1892161
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 22 Jul 2025 01:06:00 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 22
 Jul 2025 01:06:00 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 22 Jul 2025 01:06:00 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.169])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56M65tHS557151;
 Tue, 22 Jul 2025 01:05:55 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <joe.hershberger@ni.com>,
 <rfried.dev@gmail.com>, <marek.vasut+renesas@mailbox.org>,
 <jerome.forissier@linaro.org>, <quentin.schulz@cherry.de>,
 <kever.yang@rock-chips.com>, <alexthreed@gmail.com>,
 <skylake.huang@mediatek.com>
CC: <u-boot@lists.denx.de>, <u-kumar1@ti.com>, <praneeth@ti.com>, <nm@ti.com>, 
 <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH] net: phy: Support overriding Auto Negotiation timeout with
 env variable
Date: Tue, 22 Jul 2025 11:35:54 +0530
Message-ID: <20250722060554.352952-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

The Auto Negotiation procedure between two Ethernet PHYs consists of
determining the best commonly supported parameters among Speed,
Duplex Mode and Flow Control.

The time taken for this procedure is not only dependent on the local
PHY used, but also on the link-partner PHY.

While a timeout can be specified in the form of a "CONFIG" on the basis
of the local PHY present on the device, since the timeout also depends
on the link-partner PHY, it might be necessary to modify the timeout.

To avoid rebuilding the bootloader for a given device, just because it
may be connected to various link-partner PHYs, each with a different
timeout, introduce an environment variable named "phy_aneg_timeout" and
override "CONFIG_PHY_ANEG_TIMEOUT" with "phy_aneg_timeout".

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on commit
7598b469c16 Merge tag 'u-boot-dfu-next-20250703' of https://source.denx.de/u-boot/custodians/u-boot-dfu into next
of the next branch of Mainline U-Boot.

Patch has been tested on J784S4-EVM validating the following cases:
1. PHY Auto-Negotiation performed with "phy_aneg_timeout" unset.
   CONFIG_PHY_TIMEOUT with a value of 4,000 takes effect.
   => Auto Negotiation succeeds
2. PHY Auto-Negotiation performed with "phy_aneg_timeout" set to 10,000.
   "phy_aneg_timeout" overrides CONFIG_PHY_TIMEOUT.
   [Higher value than default specified by CONFIG_PHY_ANEG_TIMEOUT]
   => Auto Negotiation succeeds
3. PHY Auto-Negotiation performed with "phy_aneg_timeout" set to 2,000.
   "phy_aneg_timeout" overrides CONFIG_PHY_TIMEOUT.
   [Lower value than default specified by CONFIG_PHY_ANEG_TIMEOUT]
   => Auto Negotiation times out

Test Logs:
https://gist.github.com/Siddharth-Vadapalli-at-TI/697eadcbb26786435df48a834c968375

Regards,
Siddharth.

 doc/usage/environment.rst | 8 ++++++++
 drivers/net/phy/phy.c     | 6 +++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/doc/usage/environment.rst b/doc/usage/environment.rst
index bb6c351b441..7447bb85d3e 100644
--- a/doc/usage/environment.rst
+++ b/doc/usage/environment.rst
@@ -335,6 +335,14 @@ netretry
     Useful on scripts which control the retry operation
     themselves.
 
+phy_aneg_timeout
+    If set, the specified value will override CONFIG_PHY_ANEG_TIMEOUT
+    which defaults to 4000. The default value of CONFIG_PHY_ANEG_TIMEOUT
+    may be sufficient for most use-cases, but certain link-partners
+    may require a larger timeout due to the Ethernet PHY they use.
+    Alternatively, the timeout can be reduced as well if the use-case
+    demands it.
+
 rng_seed_size
     Size of random value added to device-tree node /chosen/rng-seed.
     This variable is given as a decimal number.
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index e6fed8c41d7..0f5c9685b59 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -9,6 +9,7 @@
  */
 #include <console.h>
 #include <dm.h>
+#include <env.h>
 #include <log.h>
 #include <malloc.h>
 #include <net.h>
@@ -243,6 +244,9 @@ int genphy_update_link(struct phy_device *phydev)
 	if ((phydev->autoneg == AUTONEG_ENABLE) &&
 	    !(mii_reg & BMSR_ANEGCOMPLETE)) {
 		int i = 0;
+		char *s = env_get("phy_aneg_timeout");
+		int phy_aneg_timeout = s ? (int)simple_strtol(s, NULL, 10) :
+					   CONFIG_PHY_ANEG_TIMEOUT;
 
 		printf("%s Waiting for PHY auto negotiation to complete",
 		       phydev->dev->name);
@@ -250,7 +254,7 @@ int genphy_update_link(struct phy_device *phydev)
 			/*
 			 * Timeout reached ?
 			 */
-			if (i > (CONFIG_PHY_ANEG_TIMEOUT / 50)) {
+			if (i > (phy_aneg_timeout / 50)) {
 				printf(" TIMEOUT !\n");
 				phydev->link = 0;
 				return -ETIMEDOUT;
-- 
2.34.1

