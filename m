Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB32CD11DD
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 12:10:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21865880DD;
	Tue, 26 Mar 2024 13:08:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711454894;
	bh=a7FYxljJJFsGXM9+7qb4QOL5NXsHlib75S7z5qsL4uE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XUosfrS6CFoaNAX62v6sYATbg+uG4TVqmCumdw8o2cVHQp6Mx9GneCU+58ts8DyU6
	 YoZLuOFvbxTjQrymUIi9Hi0+4ua531hoQ8hZeU2FMTWjc3TqFyxu/YYVIw4eDUS94p
	 JcsbDG/EBiW272h2O30Es3ALJqT9dQZce/yzmdM9hxPAL5Zj64c/TrZxI0ybRgE0d0
	 4k1TKoQkvw2tHW/FhIYTJemKSghjuQg1/qwzgSDmwoZF7Q8goSZF6jW3cBG7Yvvep2
	 k35VE82BvIBHx7ex/lOXQulGaIy4BmXgkpw3BylAKcWlE/ggIIdCA5DtMPeU7lOKdk
	 AGJlSyitoKTWA==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 68A7987FE0;
 Tue, 26 Mar 2024 13:08:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711454890;
 bh=a7FYxljJJFsGXM9+7qb4QOL5NXsHlib75S7z5qsL4uE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=vPescKPCDNdzZyOhvtLg1xw9441rKpUI6xmO+BXZmQI1REIlsgzfG5EFazKY7N38/
 cEjdEVfxkFeBPEdeuj6n4zxKtp/iDW4ha9DZvGXVHNSDVurrYRysKhjRDrRDbl+/Rn
 d7xwYkJEGfjxvfs9mkn0rk0bpsn/lh1YLUhF9XqVETk3BUFl0cz1JpywtJt87nWCAP
 Nvhk2YIAIc0sQ+gJ2XdQn1i2HTFwUFwlwo95fNKfRcxW7EqCJFGBSGWjZpRJig3tMJ
 kPPB/UMtjl/GmpWo71S0/Il8whzMqnO01rbyXpZTJxLzH0IAGCddH//sHWMy4NpT1A
 VJj152l8ryvMg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Christophe Roullier <christophe.roullier@st.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Ramon Fried <rfried.dev@gmail.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 11/11] net: dwc_eth_qos: Add support for st,
 ext-phyclk property
Date: Tue, 26 Mar 2024 13:07:32 +0100
Message-ID: <20240326120745.27581-12-marex@denx.de>
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

The "st,ext-phyclk" property is a unification of "st,eth-clk-sel"
and "st,eth-ref-clk-sel" properties. All three properties define
ETH CK clock direction, however:
- "st,eth-clk-sel" selects clock direction for GMII/RGMII mode
- "st,eth-ref-clk-sel" selects clock direction for RMII mode
- "st,ext-phyclk" selects clock direction for all RMII/GMII/RGMII modes
The "st,ext-phyclk" is the preferrable property to use.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Christophe Roullier <christophe.roullier@st.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@dh-electronics.com
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
V2: New patch
---
 drivers/net/dwc_eth_qos_stm32.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dwc_eth_qos_stm32.c b/drivers/net/dwc_eth_qos_stm32.c
index 435473f99a6..9ee82b54c62 100644
--- a/drivers/net/dwc_eth_qos_stm32.c
+++ b/drivers/net/dwc_eth_qos_stm32.c
@@ -140,6 +140,8 @@ static int eqos_probe_syscfg_stm32(struct udevice *dev,
 	const bool is_mp13 = device_is_compatible(dev, "st,stm32mp13-dwmac");
 	/* Gigabit Ethernet 125MHz clock selection. */
 	const bool eth_clk_sel = dev_read_bool(dev, "st,eth-clk-sel");
+	/* Ethernet clock source is RCC. */
+	const bool ext_phyclk = dev_read_bool(dev, "st,ext-phyclk");
 	struct regmap *regmap;
 	u32 regmap_mask;
 	u32 value;
@@ -156,6 +158,12 @@ static int eqos_probe_syscfg_stm32(struct udevice *dev,
 		dev_dbg(dev, "PHY_INTERFACE_MODE_MII\n");
 		value = FIELD_PREP(SYSCFG_PMCSETR_ETH_SEL_MASK,
 				   SYSCFG_PMCSETR_ETH_SEL_GMII_MII);
+		/*
+		 * STM32MP15xx supports both MII and GMII, STM32MP13xx MII only.
+		 * SYSCFG_PMCSETR ETH_SELMII is present only on STM32MP15xx and
+		 * acts as a selector between 0:GMII and 1:MII. As STM32MP13xx
+		 * supports only MII, ETH_SELMII is not present.
+		 */
 		if (!is_mp13)	/* Select MII mode on STM32MP15xx */
 			value |= SYSCFG_PMCSETR_ETH_SELMII;
 		break;
@@ -163,14 +171,25 @@ static int eqos_probe_syscfg_stm32(struct udevice *dev,
 		dev_dbg(dev, "PHY_INTERFACE_MODE_GMII\n");
 		value = FIELD_PREP(SYSCFG_PMCSETR_ETH_SEL_MASK,
 				   SYSCFG_PMCSETR_ETH_SEL_GMII_MII);
-		if (eth_clk_sel)
+		/*
+		 * If eth_clk_sel is set, use internal ETH_CLKx clock from RCC,
+		 * otherwise use external clock from IO pin (requires matching
+		 * GPIO block AF setting of that pin).
+		 */
+		if (eth_clk_sel || ext_phyclk)
 			value |= SYSCFG_PMCSETR_ETH_CLK_SEL;
 		break;
 	case PHY_INTERFACE_MODE_RMII:
 		dev_dbg(dev, "PHY_INTERFACE_MODE_RMII\n");
 		value = FIELD_PREP(SYSCFG_PMCSETR_ETH_SEL_MASK,
 				   SYSCFG_PMCSETR_ETH_SEL_RMII);
-		if (eth_ref_clk_sel)
+		/*
+		 * If eth_ref_clk_sel is set, use internal clock from RCC,
+		 * otherwise use external clock from ETHn_RX_CLK/ETHn_REF_CLK
+		 * IO pin (requires matching GPIO block AF setting of that
+		 * pin).
+		 */
+		if (eth_ref_clk_sel || ext_phyclk)
 			value |= SYSCFG_PMCSETR_ETH_REF_CLK_SEL;
 		break;
 	case PHY_INTERFACE_MODE_RGMII:
@@ -180,7 +199,12 @@ static int eqos_probe_syscfg_stm32(struct udevice *dev,
 		dev_dbg(dev, "PHY_INTERFACE_MODE_RGMII\n");
 		value = FIELD_PREP(SYSCFG_PMCSETR_ETH_SEL_MASK,
 				   SYSCFG_PMCSETR_ETH_SEL_RGMII);
-		if (eth_clk_sel)
+		/*
+		 * If eth_clk_sel is set, use internal ETH_CLKx clock from RCC,
+		 * otherwise use external clock from ETHx_CLK125 pin (requires
+		 * matching GPIO block AF setting of that pin).
+		 */
+		if (eth_clk_sel || ext_phyclk)
 			value |= SYSCFG_PMCSETR_ETH_CLK_SEL;
 		break;
 	default:
-- 
2.43.0

