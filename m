Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C00EC19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 12:48:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D4E781111;
	Fri, 28 Feb 2025 13:48:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC9DF81197; Fri, 28 Feb 2025 13:48:14 +0100 (CET)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 0F66481110
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 13:48:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-CSE-ConnectionGUID: C07V/lWVSVOioJYYzf/rKA==
X-CSE-MsgGUID: I8FjLoLGSve8TlX5JudXmA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 28 Feb 2025 21:48:11 +0900
Received: from rz-ub2404.betafive.net (unknown [10.226.94.53])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id CA68542F183E;
 Fri, 28 Feb 2025 21:48:08 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	u-boot@lists.denx.de
Subject: [PATCH v3 2/4] net: phy: ksz90x1: Handle ksz9131 LED errata
Date: Fri, 28 Feb 2025 12:47:53 +0000
Message-ID: <20250228124756.101601-2-paul.barker.ct@bp.renesas.com>
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

Micrel KSZ9131 PHY LED behavior is not correct when configured in
Individual Mode, LED1 (Activity LED) is in the ON state when there is
no-link.

Workaround this by setting bit 9 of register 0x1e after verifying that
the LED configuration is Individual Mode.

This issue is described in KSZ9131RNX Silicon Errata DS80000693B [*]
and according to that it will not be corrected in a future silicon
revision.

[*] https://ww1.microchip.com/downloads/en/DeviceDoc/KSZ9131RNX-Silicon-Errata-and-Data-Sheet-Clarification-80000863B.pdf

Based on commit 0316c7e66bbd in the Linux kernel.

Tested-by: Quentin Schulz <quentin.schulz@cherry.de> # RK3588 Tiger
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
Changes v2->v3:
  - Changed LED mode symbol name to
    KSZ9131RN_COMMON_CTRL_INDIVIDUAL_LED_MODE.
  - Changed errata bit symbol name to KSZ9131RN_LED_ERRATA_BIT.
  - Added Quentin's Tested-by tag.
Changes v1->v2:
  - Split out of series adding RZ/G2L Ethernet support [1]
  - Add symbols KSZ9131RN_COMMON_CTRL, KSZ9131RN_COMMON_CTRL_LED_MODE,
    KSZ9131RN_LED_ERRATA_REG, KSZ9131RN_LED_ERRATA_BITS

 drivers/net/phy/micrel_ksz90x1.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/net/phy/micrel_ksz90x1.c b/drivers/net/phy/micrel_ksz90x1.c
index c48ae6e88f30..ce7f2e2cc445 100644
--- a/drivers/net/phy/micrel_ksz90x1.c
+++ b/drivers/net/phy/micrel_ksz90x1.c
@@ -389,6 +389,12 @@ U_BOOT_PHY_DRIVER(ksz9031) = {
 #define KSZ9131RN_DLL_ENABLE_DELAY	0
 #define KSZ9131RN_DLL_DISABLE_DELAY	BIT(12)
 
+#define KSZ9131RN_COMMON_CTRL				0
+#define KSZ9131RN_COMMON_CTRL_INDIVIDUAL_LED_MODE	BIT(4)
+
+#define KSZ9131RN_LED_ERRATA_REG	0x1e
+#define KSZ9131RN_LED_ERRATA_BIT	BIT(9)
+
 static int ksz9131_config_rgmii_delay(struct phy_device *phydev)
 {
 	struct phy_driver *drv = phydev->drv;
@@ -436,6 +442,28 @@ static int ksz9131_config_rgmii_delay(struct phy_device *phydev)
 	return ret;
 }
 
+/* Silicon Errata DS80000693B
+ *
+ * When LEDs are configured in Individual Mode, LED1 is ON in a no-link
+ * condition. Workaround is to set register 0x1e, bit 9, this way LED1 behaves
+ * according to the datasheet (off if there is no link).
+ */
+static int ksz9131_led_errata(struct phy_device *phydev)
+{
+	int reg;
+
+	reg = phy_read_mmd(phydev, KSZ9131RN_MMD_COMMON_CTRL_REG,
+			   KSZ9131RN_COMMON_CTRL);
+	if (reg < 0)
+		return reg;
+
+	if (!(reg & KSZ9131RN_COMMON_CTRL_INDIVIDUAL_LED_MODE))
+		return 0;
+
+	return phy_set_bits(phydev, MDIO_DEVAD_NONE, KSZ9131RN_LED_ERRATA_REG,
+			    KSZ9131RN_LED_ERRATA_BIT);
+}
+
 static int ksz9131_config(struct phy_device *phydev)
 {
 	int ret;
@@ -446,6 +474,10 @@ static int ksz9131_config(struct phy_device *phydev)
 			return ret;
 	}
 
+	ret = ksz9131_led_errata(phydev);
+	if (ret < 0)
+		return ret;
+
 	/* add an option to disable the gigabit feature of this PHY */
 	if (env_get("disable_giga")) {
 		unsigned features;
-- 
2.43.0

