Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09AAAD60D17
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 09:49:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC2778966E;
	Wed, 20 Nov 2024 10:49:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B9D28967C; Wed, 20 Nov 2024 10:49:21 +0100 (CET)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 6BDEF8968C
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 10:49:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-CSE-ConnectionGUID: Q2j3vbBTT2KsiTuEnEoRTg==
X-CSE-MsgGUID: 8tdKJb01R+W7nrwwNKlBuw==
X-IronPort-AV: E=Sophos;i="6.12,169,1728918000"; d="scan'208";a="225420164"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 20 Nov 2024 18:49:16 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.93.28])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 91B3F41A351A;
 Wed, 20 Nov 2024 18:49:05 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	u-boot@lists.denx.de
Subject: [PATCH v2 1/4] net: phy: Port set/clear bits from Linux
Date: Wed, 20 Nov 2024 09:49:00 +0000
Message-Id: <20241120094903.94-1-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.5
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

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Changes v1->v2:
  - Split out of series adding RZ/G2L Ethernet support [1]
  - Added Marek's Reviewed-by tag

[1]: https://lore.kernel.org/all/20241024152448.102-1-paul.barker.ct@bp.renesas.com/

 include/phy.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/phy.h b/include/phy.h
index 36785031eeb0..510b0a21831b 100644
--- a/include/phy.h
+++ b/include/phy.h
@@ -333,6 +333,28 @@ int gen10g_startup(struct phy_device *phydev);
 int gen10g_shutdown(struct phy_device *phydev);
 int gen10g_discover_mmds(struct phy_device *phydev);
 
+/**
+ * phy_set_bits - Convenience function for setting bits in a PHY register
+ * @phydev: the phy_device struct
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

