Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A02C83F1A
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 14:16:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47C8583885;
	Thu, 24 Jul 2025 16:16:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="NSSiKA4H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4F1B8388C; Thu, 24 Jul 2025 16:16:07 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F36B83844
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 16:16:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56OEFhcf1963500;
 Thu, 24 Jul 2025 09:15:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1753366543;
 bh=duf9i0YOEo34TZb71HlP2yUVzdSDS+1BWJId7il+5xQ=;
 h=From:To:CC:Subject:Date;
 b=NSSiKA4HT249i8vJQ8owNy2rHiE48TFOcl938oRU8saLAl+OWBEamt2jZX1imMCgh
 KOid4PMBDHqJFIxXz9ePcvvux13vu8baDE8fjQPhv/S6u4AVweUwOgznrflNnxEPq+
 yt0mTuOjSXXpGnVeOPne7G096gHK3C10ZNN0ODxU=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56OEFhKw3585650
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 24 Jul 2025 09:15:43 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 24
 Jul 2025 09:15:43 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 24 Jul 2025 09:15:43 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.169])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56OEFa8B274591;
 Thu, 24 Jul 2025 09:15:37 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <joe.hershberger@ni.com>,
 <rfried.dev@gmail.com>, <michal.simek@amd.com>,
 <marek.vasut+renesas@mailbox.org>, <marek.vasut@mailbox.org>,
 <jerome.forissier@linaro.org>, <quentin.schulz@cherry.de>,
 <kever.yang@rock-chips.com>, <alexthreed@gmail.com>,
 <ilias.apalodimas@linaro.org>, <pbrobinson@gmail.com>,
 <paul.barker.ct@bp.renesas.com>, <romain.gantois@bootlin.com>,
 <lucienzx159@gmail.com>, <skylake.huang@mediatek.com>
CC: <u-boot@lists.denx.de>, <u-kumar1@ti.com>, <praneeth@ti.com>, <nm@ti.com>, 
 <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v3] net: phy: Support overriding Auto Negotiation timeout with
 env variable
Date: Thu, 24 Jul 2025 19:45:36 +0530
Message-ID: <20250724141536.1222764-1-s-vadapalli@ti.com>
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
3532f1f5edf block: Remove blk_find_first/next
of the master branch of Mainline U-Boot.

v2 of this patch is at:
https://patchwork.ozlabs.org/project/uboot/patch/20250723062642.634345-1-s-vadapalli@ti.com/
Changes since v2:
- Addressed feedback from Quentin Schulz at:
  https://patchwork.ozlabs.org/project/uboot/patch/20250723062642.634345-1-s-vadapalli@ti.com/#3550923
  by performing the following changes:
  1) Based the patch on the master branch of U-Boot instead of the next
     branch.
  2) Updated doc/usage/environment.rst by removing the default value of
     CONFIG_PHY_ANEG_TIMEOUT which was taken from its Kconfig file.
  3) Updated doc/usage/environment.rst by specificially mentioning the
     base and unit of the "phy_aneg_timeout" variable as decimal and
     millisecond.
  4) Updated
     a) drivers/net/phy/aquantia.c
     b) drivers/net/phy/phy.c
     c) drivers/net/xilinx_axi_emac.c
     by using "u32" instead of "ulong" for storing the value of the
     "phy_aneg_timeout" and also for the variable whose value is
     compared against "phy_aneg_timeout".

v1 of this patch is at:
https://patchwork.ozlabs.org/project/uboot/patch/20250722060554.352952-1-s-vadapalli@ti.com/
Changes since v1:
- Switched to env_get_ulong() based on feedback from Marek Vasut at:
  https://patchwork.ozlabs.org/project/uboot/patch/20250722060554.352952-1-s-vadapalli@ti.com/#3550426
- Addressed feedback from Quentin Schulz at:
  https://patchwork.ozlabs.org/project/uboot/patch/20250722060554.352952-1-s-vadapalli@ti.com/#3550263
  by performing the following changes:
  1) Updated drivers/net/phy/Kconfig by documenting that phy_aneg_timeout
     env variable can override the value of CONFIG_PHY_ANEG_TIMEOUT
  2) Updated doc/usage/environment.rst by documenting the base and unit
     of phy_aneg_timeout
  3) Updated drivers/net/phy/aquantia.c and drivers/net/xilinx_axi_emac.c
     to support overriding CONFIG_PHY_ANEG_TIMEOUT with phy_aneg_timeout

Patch has been tested on J784S4-EVM validating the following cases:
1. PHY Auto-Negotiation performed with "phy_aneg_timeout" unset.
   CONFIG_PHY_TIMEOUT with a value of 4,000 takes effect.
   => Auto Negotiation succeeds
2. PHY Auto-Negotiation performed with "phy_aneg_timeout" set to 20,000.
   "phy_aneg_timeout" overrides CONFIG_PHY_TIMEOUT.
   [Higher value than default specified by CONFIG_PHY_ANEG_TIMEOUT]
   => Auto Negotiation succeeds
3. PHY Auto-Negotiation performed with "phy_aneg_timeout" set to 200.
   "phy_aneg_timeout" overrides CONFIG_PHY_TIMEOUT.
   [Lower value than default specified by CONFIG_PHY_ANEG_TIMEOUT]
   => Auto Negotiation times out

Test Logs:
https://gist.github.com/Siddharth-Vadapalli-at-TI/b1ee7ea655212c03e77a7eb1b9453728

Regards,
Siddharth.

 doc/usage/environment.rst     | 9 +++++++++
 drivers/net/phy/Kconfig       | 5 ++++-
 drivers/net/phy/aquantia.c    | 9 +++++----
 drivers/net/phy/phy.c         | 7 +++++--
 drivers/net/xilinx_axi_emac.c | 4 +++-
 5 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/doc/usage/environment.rst b/doc/usage/environment.rst
index bb6c351b441..77197d79380 100644
--- a/doc/usage/environment.rst
+++ b/doc/usage/environment.rst
@@ -335,6 +335,15 @@ netretry
     Useful on scripts which control the retry operation
     themselves.
 
+phy_aneg_timeout
+    If set, the specified value will override CONFIG_PHY_ANEG_TIMEOUT.
+    This variable has the same base and unit as CONFIG_PHY_ANEG_TIMEOUT
+    which is "decimal" and "millisecond" respectively. The default value
+    of CONFIG_PHY_ANEG_TIMEOUT may be sufficient for most use-cases, but
+    certain link-partners may require a larger timeout due to the Ethernet
+    PHY they use. Alternatively, the timeout can be reduced as well if the
+    use-case demands it.
+
 rng_seed_size
     Size of random value added to device-tree node /chosen/rng-seed.
     This variable is given as a decimal number.
diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 8d88c142900..21bf983056a 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -23,7 +23,10 @@ config PHY_ANEG_TIMEOUT
 	int "PHY auto-negotiation timeout"
 	default 4000
 	help
-	  Default PHY auto-negotiation timeout.
+	  Value of PHY auto-negotiation timeout with the base being
+	  "decimal" and the unit being "millisecond". This can be
+	  overridden by the "phy_aneg_timeout" environment variable
+	  that has the same base (decimal) and unit (millisecond).
 
 if PHY_ADDR_ENABLE
 config PHY_ADDR
diff --git a/drivers/net/phy/aquantia.c b/drivers/net/phy/aquantia.c
index d2db8d9f792..c29d8facdee 100644
--- a/drivers/net/phy/aquantia.c
+++ b/drivers/net/phy/aquantia.c
@@ -551,14 +551,15 @@ int aquantia_config(struct phy_device *phydev)
 
 int aquantia_startup(struct phy_device *phydev)
 {
-	u32 speed;
-	int i = 0;
+	u32 speed, i = 0;
 	int reg;
 
 	phydev->duplex = DUPLEX_FULL;
 
 	/* if the AN is still in progress, wait till timeout. */
 	if (!aquantia_link_is_up(phydev)) {
+		u32 aneg_timeout = env_get_ulong("phy_aneg_timeout", 10,
+						 CONFIG_PHY_ANEG_TIMEOUT);
 		printf("%s Waiting for PHY auto negotiation to complete",
 		       phydev->dev->name);
 		do {
@@ -566,9 +567,9 @@ int aquantia_startup(struct phy_device *phydev)
 			if ((i++ % 500) == 0)
 				printf(".");
 		} while (!aquantia_link_is_up(phydev) &&
-			 i < (4 * CONFIG_PHY_ANEG_TIMEOUT));
+			 i < (4 * aneg_timeout));
 
-		if (i > CONFIG_PHY_ANEG_TIMEOUT)
+		if (i > aneg_timeout)
 			printf(" TIMEOUT !\n");
 	}
 
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index e6fed8c41d7..9702d042296 100644
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
@@ -242,7 +243,9 @@ int genphy_update_link(struct phy_device *phydev)
 
 	if ((phydev->autoneg == AUTONEG_ENABLE) &&
 	    !(mii_reg & BMSR_ANEGCOMPLETE)) {
-		int i = 0;
+		u32 i = 0;
+		u32 aneg_timeout = env_get_ulong("phy_aneg_timeout", 10,
+						 CONFIG_PHY_ANEG_TIMEOUT);
 
 		printf("%s Waiting for PHY auto negotiation to complete",
 		       phydev->dev->name);
@@ -250,7 +253,7 @@ int genphy_update_link(struct phy_device *phydev)
 			/*
 			 * Timeout reached ?
 			 */
-			if (i > (CONFIG_PHY_ANEG_TIMEOUT / 50)) {
+			if (i > (aneg_timeout / 50)) {
 				printf(" TIMEOUT !\n");
 				phydev->link = 0;
 				return -ETIMEDOUT;
diff --git a/drivers/net/xilinx_axi_emac.c b/drivers/net/xilinx_axi_emac.c
index 4d87e2d1f36..f072ac84990 100644
--- a/drivers/net/xilinx_axi_emac.c
+++ b/drivers/net/xilinx_axi_emac.c
@@ -343,6 +343,8 @@ static int axiemac_phy_init(struct udevice *dev)
 
 static int pcs_pma_startup(struct axidma_priv *priv)
 {
+	u32 aneg_timeout = env_get_ulong("phy_aneg_timeout", 10,
+					 CONFIG_PHY_ANEG_TIMEOUT);
 	u32 rc, retry_cnt = 0;
 	u16 mii_reg;
 
@@ -361,7 +363,7 @@ static int pcs_pma_startup(struct axidma_priv *priv)
 	 * and the external PHY is not obtained.
 	 */
 	debug("axiemac: waiting for link status of the PCS/PMA PHY");
-	while (retry_cnt * 10 < CONFIG_PHY_ANEG_TIMEOUT) {
+	while (retry_cnt * 10 < aneg_timeout) {
 		rc = phyread(priv, priv->pcsaddr, MII_BMSR, &mii_reg);
 		if ((mii_reg & BMSR_LSTATUS) && mii_reg != 0xffff && !rc) {
 			debug(".Done\n");
-- 
2.34.1

