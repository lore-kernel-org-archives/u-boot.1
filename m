Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98747CE8E8A
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 15:26:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A560A8900B;
	Thu, 24 Oct 2024 17:25:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 725FE88CD9; Thu, 24 Oct 2024 17:25:36 +0200 (CEST)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 3398D88FC0
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 17:25:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.11,229,1725289200"; d="scan'208";a="222903808"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie5.idc.renesas.com with ESMTP; 25 Oct 2024 00:25:27 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.93.183])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3E9A840065A3;
 Fri, 25 Oct 2024 00:25:23 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	u-boot@lists.denx.de
Subject: [PATCH 06/14] net: phy: ksz90x1: Handle ksz9131 LED errata
Date: Thu, 24 Oct 2024 16:24:40 +0100
Message-Id: <20241024152448.102-7-paul.barker.ct@bp.renesas.com>
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
 drivers/net/phy/micrel_ksz90x1.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/phy/micrel_ksz90x1.c b/drivers/net/phy/micrel_ksz90x1.c
index c48ae6e88f30..4f99b115a3c7 100644
--- a/drivers/net/phy/micrel_ksz90x1.c
+++ b/drivers/net/phy/micrel_ksz90x1.c
@@ -436,6 +436,26 @@ static int ksz9131_config_rgmii_delay(struct phy_device *phydev)
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
+	reg = phy_read_mmd(phydev, KSZ9131RN_MMD_COMMON_CTRL_REG, 0);
+	if (reg < 0)
+		return reg;
+
+	if (!(reg & BIT(4)))
+		return 0;
+
+	return phy_set_bits(phydev, MDIO_DEVAD_NONE, 0x1e, BIT(9));
+}
+
 static int ksz9131_config(struct phy_device *phydev)
 {
 	int ret;
@@ -446,6 +466,10 @@ static int ksz9131_config(struct phy_device *phydev)
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

