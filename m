Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C605C6FD1F
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 12:09:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E516880BB;
	Tue, 26 Mar 2024 13:08:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711454893;
	bh=78R+XoEMpqz0RT/ksuAwjDc2bO25nnW0HCLwxGN9EbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fC69ZXKqMzvCFErbYw+NSIrMymfvqQIdGAEk5rIIOrvMdT0l16CRmPN9H+mgst2fQ
	 HWEL5QXfWjm1Bmp4CVt6IfvbU3wA/ypeJA7z6e4BL7ZSer/V3d3pdmLYQPjdToV4yS
	 AlxhzoOliz/ec/ZhdGCJIxE8wN3j3ke19OwaSJnxusbV7VY1qDcmM/iyMzX+m4pDmU
	 jlOedbXde0U82Y3cepEZpFEN/W23cWuQBueOK40ZFc0tYVEaQRWRi+5WfUy0rYiOnN
	 DR7dkOMFGXez7jyrL34xAmckwQV92diH8kuv7CwiUjUke5V1Y8ZwhioDPgI2UjW1l2
	 Ck8cSAnmmN66A==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 892A487FD7;
 Tue, 26 Mar 2024 13:08:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711454889;
 bh=78R+XoEMpqz0RT/ksuAwjDc2bO25nnW0HCLwxGN9EbY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=f2ySi7Mowwka+5Bkj0GVc3H5iVR3J39SNG1qqAvli5ju5l/KPqTFbkuGU1MSHVnNQ
 tnT29GQxij3I1NfM4Td34PYte3dAX1ihnBLxCDGnssRO8k9onXIz/zA4bV2ua2+7Sm
 X5Z1TVVbl0tOAeeSoEZR8kMgV6yaUHlfdJZgyiorjduZqOe0DbOry/2fGLVSANxcZw
 hctPcQGq7X1KUDUtCAYM4WTs+tzotUZTHkxDJXI74cn0e+ozbZfl6dJp+3IpD8MIR2
 7cNVAnOpzhekZwjoKM3ax+RlTKLUGzKR7eY2t0CmBmmnGu/sPStvqh61U2IG/ZbdUd
 Zp58FyT3oWjSw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Christophe Roullier <christophe.roullier@st.com>,
 Marek Vasut <marex@denx.de>, Joe Hershberger <joe.hershberger@ni.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Ramon Fried <rfried.dev@gmail.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 09/11] net: dwc_eth_qos: Add DT parsing for STM32MP13xx
 platform
Date: Tue, 26 Mar 2024 13:07:30 +0100
Message-ID: <20240326120745.27581-10-marex@denx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326120745.27581-1-marex@denx.de>
References: <20240326120745.27581-1-marex@denx.de>
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

From: Christophe Roullier <christophe.roullier@st.com>

Manage 2 ethernet instances, select which instance to configure with mask
If mask is not present in DT, it is stm32mp15 platform.

Signed-off-by: Christophe Roullier <christophe.roullier@st.com>
Signed-off-by: Marek Vasut <marex@denx.de> # Rework the code
---
Cc: Christophe Roullier <christophe.roullier@st.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@dh-electronics.com
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
V2: - Drop unrelated clock frequency validation
    - Move "st,ext-phyclk" property support into separate patch
    - This leaves only the regmap parts here
---
 drivers/net/dwc_eth_qos_stm32.c | 41 ++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/net/dwc_eth_qos_stm32.c b/drivers/net/dwc_eth_qos_stm32.c
index 0b13d01346b..5a20fe5bea2 100644
--- a/drivers/net/dwc_eth_qos_stm32.c
+++ b/drivers/net/dwc_eth_qos_stm32.c
@@ -23,6 +23,7 @@
 #include <net.h>
 #include <netdev.h>
 #include <phy.h>
+#include <regmap.h>
 #include <reset.h>
 #include <syscon.h>
 #include <wait_bit.h>
@@ -33,11 +34,16 @@
 
 /* SYSCFG registers */
 #define SYSCFG_PMCSETR		0x04
-#define SYSCFG_PMCCLRR		0x44
+#define SYSCFG_PMCCLRR_MP13	0x08
+#define SYSCFG_PMCCLRR_MP15	0x44
+
+#define SYSCFG_PMCSETR_ETH1_MASK	GENMASK(23, 16)
+#define SYSCFG_PMCSETR_ETH2_MASK	GENMASK(31, 24)
 
 #define SYSCFG_PMCSETR_ETH_CLK_SEL	BIT(16)
 #define SYSCFG_PMCSETR_ETH_REF_CLK_SEL	BIT(17)
 
+/* STM32MP15xx specific bit */
 #define SYSCFG_PMCSETR_ETH_SELMII	BIT(20)
 
 #define SYSCFG_PMCSETR_ETH_SEL_MASK	GENMASK(23, 21)
@@ -130,23 +136,30 @@ static int eqos_probe_syscfg_stm32(struct udevice *dev,
 {
 	/* Ethernet 50MHz RMII clock selection. */
 	const bool eth_ref_clk_sel = dev_read_bool(dev, "st,eth-ref-clk-sel");
+	/* SoC is STM32MP13xx with two ethernet MACs */
+	const bool is_mp13 = device_is_compatible(dev, "st,stm32mp13-dwmac");
 	/* Gigabit Ethernet 125MHz clock selection. */
 	const bool eth_clk_sel = dev_read_bool(dev, "st,eth-clk-sel");
-	u8 *syscfg;
+	struct regmap *regmap;
+	u32 regmap_mask;
 	u32 value;
 
-	syscfg = (u8 *)syscon_get_first_range(STM32MP_SYSCON_SYSCFG);
-	if (!syscfg)
-		return -ENODEV;
+	regmap = syscon_regmap_lookup_by_phandle(dev, "st,syscon");
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	regmap_mask = dev_read_u32_index_default(dev, "st,syscon", 2,
+						 SYSCFG_PMCSETR_ETH1_MASK);
 
 	switch (interface_type) {
 	case PHY_INTERFACE_MODE_MII:
 		dev_dbg(dev, "PHY_INTERFACE_MODE_MII\n");
 		value = FIELD_PREP(SYSCFG_PMCSETR_ETH_SEL_MASK,
 				   SYSCFG_PMCSETR_ETH_SEL_GMII_MII);
-		value |= SYSCFG_PMCSETR_ETH_REF_CLK_SEL;
+		if (!is_mp13)	/* Select MII mode on STM32MP15xx */
+			value |= SYSCFG_PMCSETR_ETH_SELMII;
 		break;
-	case PHY_INTERFACE_MODE_GMII:
+	case PHY_INTERFACE_MODE_GMII:	/* STM32MP15xx only */
 		dev_dbg(dev, "PHY_INTERFACE_MODE_GMII\n");
 		value = FIELD_PREP(SYSCFG_PMCSETR_ETH_SEL_MASK,
 				   SYSCFG_PMCSETR_ETH_SEL_GMII_MII);
@@ -177,13 +190,15 @@ static int eqos_probe_syscfg_stm32(struct udevice *dev,
 		return -EINVAL;
 	}
 
-	/* clear and set ETH configuration bits */
-	writel(SYSCFG_PMCSETR_ETH_SEL_MASK | SYSCFG_PMCSETR_ETH_SELMII |
-	       SYSCFG_PMCSETR_ETH_REF_CLK_SEL | SYSCFG_PMCSETR_ETH_CLK_SEL,
-	       syscfg + SYSCFG_PMCCLRR);
-	writel(value, syscfg + SYSCFG_PMCSETR);
+	/* Shift value at correct ethernet MAC offset in SYSCFG_PMCSETR */
+	value <<= ffs(regmap_mask) - ffs(SYSCFG_PMCSETR_ETH1_MASK);
 
-	return 0;
+	/* Update PMCCLRR (clear register) */
+	regmap_write(regmap, is_mp13 ?
+			     SYSCFG_PMCCLRR_MP13 : SYSCFG_PMCCLRR_MP15,
+			     regmap_mask);
+
+	return regmap_update_bits(regmap, SYSCFG_PMCSETR, regmap_mask, value);
 }
 
 static int eqos_probe_resources_stm32(struct udevice *dev)
-- 
2.43.0

