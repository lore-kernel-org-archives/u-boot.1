Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B2FBC19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 12:48:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDE468110C;
	Fri, 28 Feb 2025 13:48:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B9A381113; Fri, 28 Feb 2025 13:48:13 +0100 (CET)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 3209B810ED
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 13:48:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-CSE-ConnectionGUID: mcBYcYXkTQifukw7ooEQdQ==
X-CSE-MsgGUID: biPVIMT1SFiN6LIqSXzoXQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 28 Feb 2025 21:48:08 +0900
Received: from rz-ub2404.betafive.net (unknown [10.226.94.53])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5A34B42F1838;
 Fri, 28 Feb 2025 21:48:05 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	u-boot@lists.denx.de
Subject: [PATCH v3 1/4] net: phy: Port set/clear bits from Linux
Date: Fri, 28 Feb 2025 12:47:52 +0000
Message-ID: <20250228124756.101601-1-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
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

To simply porting phy drivers from Linux to U-Boot, define
phy_set_bits() and phy_clear_bits() functions with a similar API to
those used in Linux.

The U-Boot versions of these functions include the `devad` argument
which is not present in the Linux versions, to keep them aligned with
the other phy functions in U-Boot.

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
Changes v2->v3:
  - Documented devad parameter.
Changes v1->v2:
  - Split out of series adding RZ/G2L Ethernet support [1]
  - Added Marek's Reviewed-by tag

 include/phy.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/phy.h b/include/phy.h
index 36785031eeb0..36354aaf774a 100644
--- a/include/phy.h
+++ b/include/phy.h
@@ -333,6 +333,30 @@ int gen10g_startup(struct phy_device *phydev);
 int gen10g_shutdown(struct phy_device *phydev);
 int gen10g_discover_mmds(struct phy_device *phydev);
 
+/**
+ * phy_set_bits - Convenience function for setting bits in a PHY register
+ * @phydev: the phy_device struct
+ * @devad: The MMD to read from
+ * @regnum: register number to write
+ * @val: bits to set
+ */
+static inline int phy_set_bits(struct phy_device *phydev, int devad, u32 regnum, u16 val)
+{
+	return phy_modify(phydev, devad, regnum, 0, val);
+}
+
+/**
+ * phy_clear_bits - Convenience function for clearing bits in a PHY register
+ * @phydev: the phy_device struct
+ * @devad: The MMD to write to
+ * @regnum: register number to write
+ * @val: bits to clear
+ */
+static inline int phy_clear_bits(struct phy_device *phydev, int devad, u32 regnum, u16 val)
+{
+	return phy_modify(phydev, devad, regnum, val, 0);
+}
+
 /**
  * U_BOOT_PHY_DRIVER() - Declare a new U-Boot driver
  * @__name: name of the driver
-- 
2.43.0

