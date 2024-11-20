Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 587FCD44171
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 09:49:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB89F8967B;
	Wed, 20 Nov 2024 10:49:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62ED38967C; Wed, 20 Nov 2024 10:49:16 +0100 (CET)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id CF7AE8966E
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 10:49:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-CSE-ConnectionGUID: 01wLedhVTkOiUj7Z+p6dRQ==
X-CSE-MsgGUID: yw4PMOziQMGzGbK09I9H7Q==
X-IronPort-AV: E=Sophos;i="6.12,169,1728918000"; d="scan'208";a="229404008"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 20 Nov 2024 18:49:10 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.93.28])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 61B9F41A6094;
 Wed, 20 Nov 2024 18:49:08 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	u-boot@lists.denx.de
Subject: [PATCH v2 2/4] net: phy: ksz90x1: Handle ksz9131 LED errata
Date: Wed, 20 Nov 2024 09:49:01 +0000
Message-Id: <20241120094903.94-2-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241120094903.94-1-paul.barker.ct@bp.renesas.com>
References: <20241120094903.94-1-paul.barker.ct@bp.renesas.com>
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

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
Changes v1->v2:
  - Split out of series adding RZ/G2L Ethernet support [1]
  - Add symbols KSZ9131RN_COMMON_CTRL, KSZ9131RN_COMMON_CTRL_LED_MODE,
    KSZ9131RN_LED_ERRATA_REG, KSZ9131RN_LED_ERRATA_BITS

[1]: https://lore.kernel.org/all/20241024152448.102-1-paul.barker.ct@bp.renesas.com/

 drivers/net/phy/micrel_ksz90x1.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/net/phy/micrel_ksz90x1.c b/drivers/net/phy/micrel_ksz90x1.c
index c48ae6e88f30..b33457910795 100644
--- a/drivers/net/phy/micrel_ksz90x1.c
+++ b/drivers/net/phy/micrel_ksz90x1.c
@@ -389,6 +389,12 @@ U_BOOT_PHY_DRIVER(ksz9031) = {
 #define KSZ9131RN_DLL_ENABLE_DELAY	0
 #define KSZ9131RN_DLL_DISABLE_DELAY	BIT(12)
 
+#define KSZ9131RN_COMMON_CTRL		0
+#define KSZ9131RN_COMMON_CTRL_LED_MODE	BIT(4)
+
+#define KSZ9131RN_LED_ERRATA_REG	0x1e
+#define KSZ9131RN_LED_ERRATA_BITS	BIT(9)
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
+	if (!(reg & KSZ9131RN_COMMON_CTRL_LED_MODE))
+		return 0;
+
+	return phy_set_bits(phydev, MDIO_DEVAD_NONE, KSZ9131RN_LED_ERRATA_REG,
+			    KSZ9131RN_LED_ERRATA_BITS);
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

