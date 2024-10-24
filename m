Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD46CE8E8A
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 15:26:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57AD188FED;
	Thu, 24 Oct 2024 17:25:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E98488FBA; Thu, 24 Oct 2024 17:25:34 +0200 (CEST)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id C5B6E88FD2
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 17:25:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.11,229,1725289200"; d="scan'208";a="222903802"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie5.idc.renesas.com with ESMTP; 25 Oct 2024 00:25:23 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.93.183])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 911704009A0C;
 Fri, 25 Oct 2024 00:25:20 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	u-boot@lists.denx.de
Subject: [PATCH 05/14] net: phy: Port set/clear bits from Linux
Date: Thu, 24 Oct 2024 16:24:39 +0100
Message-Id: <20241024152448.102-6-paul.barker.ct@bp.renesas.com>
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

To simply porting phy drivers from Linux to U-Boot, define
phy_set_bits() and phy_clear_bits() functions with a similar API to
those used in Linux.

The U-Boot versions of these functions include the `devad` argument
which is not present in the Linux versions, to keep them aligned with
the other phy functions in U-Boot.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
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

