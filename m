Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A6EC10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 09:42:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C56C78873F;
	Tue,  7 May 2024 11:42:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715074976;
	bh=QK8LFtPgGmldq3Jm7/L9ngidE4CJW5CgyHCSGu+d2gM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Q+OJWp/Z53vs2WSmkpa6/oBVbuBSvwAAIUkuTwMQzPlMjxjhFcLPywu9TWw5nVY4n
	 z/pt5MFNsNskhL305hs0gbKcqABiF6o5Hjg/M3SIkWnvA1icKH6rRsgWrmIQg0VPQh
	 YNmSF9aGikyVt03mqCluPGPvmwr6E7RCTE9KCvD4In9SgSNg8UdaICEfVTAWKOUoFJ
	 8Zij9V3egbZQK6rB3j1Am/bcMWgdlEQwb+M5rHr7xqcxbyId3xU+5C03G8HRfuvIXx
	 zSlaRJ20voHtKSfQmtsP6HYf/qA1W8iNYFobDDwgFMKCq07DqX4gSRI9vupzCph1Ey
	 1VB/e5ggyqUGw==
Received: from localhost (unknown [IPv6:2001:861:52:5f60:ff6c:4545:dfcf:4c97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: pro@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 99A5788726;
 Tue,  7 May 2024 11:42:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1715074976;
 bh=QK8LFtPgGmldq3Jm7/L9ngidE4CJW5CgyHCSGu+d2gM=;
 h=From:To:Cc:Subject:Date:From;
 b=RixChdjOfN1GxzxqAvTXG8QrlOZw3OgtIs5V2kiraEA89qZp99iuFFq5FOJzS2Xke
 KtQlGkobrcdcMbxvkYn7/sUoWVOAWoquvcFdeQyToEGICTfLiUaWo/sR23DgbF9Yrw
 Tar9aSNapiO5wrgLSToPB9VGe/GqNjCeGmBeG4wZrl4Vf4GXD6ffvQT+/nB8Cd+9MA
 uI/ju325Zsf6uWxuM/giULduv+Kv7jblfOcdfAaHPc7HDq7FuH9U8PH5ozhwPHYayn
 vGh8P3+QydFtF0Jl2FT2z7Ycs6HaxbWWuRrNu4bruBqEy4f4Oc1LsjBKe5mVaw2mIn
 wTU71BcC9R9IQ==
From: Philip Oberfichtner <pro@denx.de>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, trini@konsulko.com,
 caleb.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@linaro.org, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, patrick.delaunay@foss.st.com,
 patrice.chotard@foss.st.com, jonas@kwiboo.se, marex@denx.de,
 leyfoon.tan@starfivetech.com, epsi@gmx.de, xypron.glpk@gmx.de,
 seanga2@gmail.com, sebastien.szymanski@armadeus.com, festevam@gmail.com,
 sebastian.reichel@collabora.com, yanhong.wang@starfivetech.com,
 christophe.roullier@st.com, pro@denx.de
Subject: [PATCH v2 1/1] net: dwc_eth_qos: mdio: Implement clause 45
Date: Tue,  7 May 2024 11:42:37 +0200
Message-Id: <20240507094237.168238-1-pro@denx.de>
X-Mailer: git-send-email 2.39.2
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

Bevor this commit, only clause 22 access was possible. After this commit,
clause 45 direct access will available as well.

Note that there is a slight change of behavior: Before this commit, the
C45E bit was set to whatever value was left in the register from the
previous access. After this commit, we adopt the common practice of
discerning C45 from C22 using the devad argument.

Signed-off-by: Philip Oberfichtner <pro@denx.de>
---

Notes:
    Attention: There is a slight change of behavior introduced by this
    commit (see commit message). Please test and review if this works for
    everybody.
    
    My implementation is tested on an Intel Elkhart lake SOC, patch
    submitted here:
    
    https://patchwork.ozlabs.org/project/uboot/list/?series=405358
    
    Changes in V2:
    	- Use FIELD_PREP() instead of manual '<<' shifting
    	- Fix whitespace errors

 drivers/net/dwc_eth_qos.c | 66 ++++++++++++++++++++++++++-------------
 drivers/net/dwc_eth_qos.h |  9 +++---
 2 files changed, 49 insertions(+), 26 deletions(-)

diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
index cb329e0cef..6bc9b8fca4 100644
--- a/drivers/net/dwc_eth_qos.c
+++ b/drivers/net/dwc_eth_qos.c
@@ -51,6 +51,7 @@
 #include <asm/arch/clock.h>
 #include <asm/mach-imx/sys_proto.h>
 #endif
+#include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/printk.h>
 
@@ -184,6 +185,25 @@ static int eqos_mdio_wait_idle(struct eqos_priv *eqos)
 				 1000000, true);
 }
 
+/* Bitmask common for mdio_read and mdio_write */
+#define EQOS_MDIO_BITFIELD(pa, rda, cr) \
+	FIELD_PREP(EQOS_MAC_MDIO_ADDRESS_PA_MASK, pa)   | \
+	FIELD_PREP(EQOS_MAC_MDIO_ADDRESS_RDA_MASK, rda) | \
+	FIELD_PREP(EQOS_MAC_MDIO_ADDRESS_CR_MASK, cr)   | \
+	EQOS_MAC_MDIO_ADDRESS_GB
+
+static u32 eqos_mdio_bitfield(struct eqos_priv *eqos, int addr, int devad, int reg)
+{
+	int cr = eqos->config->config_mac_mdio;
+	bool c22 = devad == MDIO_DEVAD_NONE ? true : false;
+
+	if (c22)
+		return EQOS_MDIO_BITFIELD(addr, reg, cr);
+	else
+		return EQOS_MDIO_BITFIELD(addr, devad, cr) |
+		       EQOS_MAC_MDIO_ADDRESS_C45E;
+}
+
 static int eqos_mdio_read(struct mii_dev *bus, int mdio_addr, int mdio_devad,
 			  int mdio_reg)
 {
@@ -201,15 +221,17 @@ static int eqos_mdio_read(struct mii_dev *bus, int mdio_addr, int mdio_devad,
 	}
 
 	val = readl(&eqos->mac_regs->mdio_address);
-	val &= EQOS_MAC_MDIO_ADDRESS_SKAP |
-		EQOS_MAC_MDIO_ADDRESS_C45E;
-	val |= (mdio_addr << EQOS_MAC_MDIO_ADDRESS_PA_SHIFT) |
-		(mdio_reg << EQOS_MAC_MDIO_ADDRESS_RDA_SHIFT) |
-		(eqos->config->config_mac_mdio <<
-		 EQOS_MAC_MDIO_ADDRESS_CR_SHIFT) |
-		(EQOS_MAC_MDIO_ADDRESS_GOC_READ <<
-		 EQOS_MAC_MDIO_ADDRESS_GOC_SHIFT) |
-		EQOS_MAC_MDIO_ADDRESS_GB;
+	val &= EQOS_MAC_MDIO_ADDRESS_SKAP;
+
+	val |= eqos_mdio_bitfield(eqos, mdio_addr, mdio_devad, mdio_reg) |
+	       FIELD_PREP(EQOS_MAC_MDIO_ADDRESS_GOC_MASK,
+			  EQOS_MAC_MDIO_ADDRESS_GOC_READ);
+
+	if (val & EQOS_MAC_MDIO_ADDRESS_C45E) {
+		writel(FIELD_PREP(EQOS_MAC_MDIO_DATA_RA_MASK, mdio_reg),
+		       &eqos->mac_regs->mdio_data);
+	}
+
 	writel(val, &eqos->mac_regs->mdio_address);
 
 	udelay(eqos->config->mdio_wait);
@@ -232,7 +254,8 @@ static int eqos_mdio_write(struct mii_dev *bus, int mdio_addr, int mdio_devad,
 			   int mdio_reg, u16 mdio_val)
 {
 	struct eqos_priv *eqos = bus->priv;
-	u32 val;
+	u32 v_addr;
+	u32 v_data;
 	int ret;
 
 	debug("%s(dev=%p, addr=%x, reg=%d, val=%x):\n", __func__, eqos->dev,
@@ -244,20 +267,19 @@ static int eqos_mdio_write(struct mii_dev *bus, int mdio_addr, int mdio_devad,
 		return ret;
 	}
 
-	writel(mdio_val, &eqos->mac_regs->mdio_data);
+	v_addr = readl(&eqos->mac_regs->mdio_address);
+	v_addr &= EQOS_MAC_MDIO_ADDRESS_SKAP;
 
-	val = readl(&eqos->mac_regs->mdio_address);
-	val &= EQOS_MAC_MDIO_ADDRESS_SKAP |
-		EQOS_MAC_MDIO_ADDRESS_C45E;
-	val |= (mdio_addr << EQOS_MAC_MDIO_ADDRESS_PA_SHIFT) |
-		(mdio_reg << EQOS_MAC_MDIO_ADDRESS_RDA_SHIFT) |
-		(eqos->config->config_mac_mdio <<
-		 EQOS_MAC_MDIO_ADDRESS_CR_SHIFT) |
-		(EQOS_MAC_MDIO_ADDRESS_GOC_WRITE <<
-		 EQOS_MAC_MDIO_ADDRESS_GOC_SHIFT) |
-		EQOS_MAC_MDIO_ADDRESS_GB;
-	writel(val, &eqos->mac_regs->mdio_address);
+	v_addr |= eqos_mdio_bitfield(eqos, mdio_addr, mdio_devad, mdio_reg) |
+	       FIELD_PREP(EQOS_MAC_MDIO_ADDRESS_GOC_MASK,
+			  EQOS_MAC_MDIO_ADDRESS_GOC_WRITE);
+
+	v_data = mdio_val;
+	if (v_addr & EQOS_MAC_MDIO_ADDRESS_C45E)
+		v_data |= FIELD_PREP(EQOS_MAC_MDIO_DATA_RA_MASK, mdio_reg);
 
+	writel(v_data, &eqos->mac_regs->mdio_data);
+	writel(v_addr, &eqos->mac_regs->mdio_address);
 	udelay(eqos->config->mdio_wait);
 
 	ret = eqos_mdio_wait_idle(eqos);
diff --git a/drivers/net/dwc_eth_qos.h b/drivers/net/dwc_eth_qos.h
index 8b3d0d464d..a06390a698 100644
--- a/drivers/net/dwc_eth_qos.h
+++ b/drivers/net/dwc_eth_qos.h
@@ -79,19 +79,20 @@ struct eqos_mac_regs {
 #define EQOS_MAC_HW_FEATURE3_ASP_SHIFT			28
 #define EQOS_MAC_HW_FEATURE3_ASP_MASK			0x3
 
-#define EQOS_MAC_MDIO_ADDRESS_PA_SHIFT			21
-#define EQOS_MAC_MDIO_ADDRESS_RDA_SHIFT			16
-#define EQOS_MAC_MDIO_ADDRESS_CR_SHIFT			8
+#define EQOS_MAC_MDIO_ADDRESS_PA_MASK			GENMASK(25, 21)
+#define EQOS_MAC_MDIO_ADDRESS_RDA_MASK			GENMASK(20, 16)
+#define EQOS_MAC_MDIO_ADDRESS_CR_MASK			GENMASK(11, 8)
 #define EQOS_MAC_MDIO_ADDRESS_CR_100_150		1
 #define EQOS_MAC_MDIO_ADDRESS_CR_20_35			2
 #define EQOS_MAC_MDIO_ADDRESS_CR_250_300		5
 #define EQOS_MAC_MDIO_ADDRESS_SKAP			BIT(4)
-#define EQOS_MAC_MDIO_ADDRESS_GOC_SHIFT			2
+#define EQOS_MAC_MDIO_ADDRESS_GOC_MASK			GENMASK(3, 2)
 #define EQOS_MAC_MDIO_ADDRESS_GOC_READ			3
 #define EQOS_MAC_MDIO_ADDRESS_GOC_WRITE			1
 #define EQOS_MAC_MDIO_ADDRESS_C45E			BIT(1)
 #define EQOS_MAC_MDIO_ADDRESS_GB			BIT(0)
 
+#define EQOS_MAC_MDIO_DATA_RA_MASK			GENMASK(31, 16)
 #define EQOS_MAC_MDIO_DATA_GD_MASK			0xffff
 
 #define EQOS_MTL_REGS_BASE 0xd00
-- 
2.39.2

