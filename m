Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A99CAC587
	for <u-boot@archiver.kernel.org>; Mon, 15 Sep 2025 00:53:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AFAA83106;
	Mon, 15 Sep 2025 02:53:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="VWChVAaw";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="O+tBXbmC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6441C8317B; Mon, 15 Sep 2025 02:53:50 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A5BC8309E
 for <u-boot@lists.denx.de>; Mon, 15 Sep 2025 02:53:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cQ63Z5xr0z9tHp;
 Mon, 15 Sep 2025 02:53:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1757897626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/VlGnNr0/pDUlx5c961u7+Pi+iHILhoFUbhdoYG++HI=;
 b=VWChVAaw6DzA8wj/53WYtORIcL8VCfEkZEpxrl5FfRY4A4prvP/r5wCx35zaZ6UlU1dQc/
 6qIF6tx1uL20vWdJ5nHigeinbjCdE1to7Wi+/SHRsc/16374WGh8/1CuxTIvnnffDNjCN0
 cMYl5dd7c7t4yebxrYY9sujH3I9+9O3ZyItaS4FpMNOTjGDXDwz1/fHv44bGJZAyNVY+ix
 5KohEcexXkPg3ZmYOPYZi/D28fYFeCjf51GqHU2et+fXG3c90NTdug5MxzbzoAff0gThjf
 XzdTOLcg34q/ECbMMCIhMXP+ffjRQgiRszzd7PN65TPcgVfUTnw4jNpdOXWlEQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=O+tBXbmC;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1757897625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/VlGnNr0/pDUlx5c961u7+Pi+iHILhoFUbhdoYG++HI=;
 b=O+tBXbmCYTiSoAwgHxyEE/0j49MEIlhKi6p7n4oQWhGggiBkkXfipxiAZyp+Z0a5HhrWpj
 vQOiliqJitwlltJ7wSOben10L5eKqQ6b4UeBFo1rWoLgzPK7AhnBlh7KFibAauaVmmk4ws
 zmJXQigvI6YMmj7CYrW0gpQbGf9N4uiG5SFKswF4VGiKXCn64dBso01XyrCstCSTcqxy8p
 1k95My3m0/J7PHhW3DPWgUx97vYYJ8Jc0RIedStjKHpDVY5FP7PMNa5LMcdCixo2MbAApN
 bM3MPrdXrcsjcDfQUn0QuCbdZCucc+dlERLsrdETApddjfGuPDofOXVaNuFe/g==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Christophe Roullier <christophe.roullier@foss.st.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2] net: dwc_eth_qos: Fix support for stm32mp2 platform
Date: Mon, 15 Sep 2025 02:53:04 +0200
Message-ID: <20250915005331.222677-1-marek.vasut@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ucnetssy4xc7hr3ua74faqq9a41czie5
X-MBO-RS-ID: 5fcbcd9a7b7440a168b
X-Rspamd-Queue-Id: 4cQ63Z5xr0z9tHp
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

The layout of SYSCFG_ETHnCR on STM32MP25xx is slightly different yet again.
Add missing swizzling to program the correct register with the correct content.

Fixes: 20afca89ed53 ("net: dwc_eth_qos: add support of stm32mp2 platform")
Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: Christophe Roullier <christophe.roullier@foss.st.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
V2: Gate off SELMII bit on both MP13 and MP2
---
 drivers/net/dwc_eth_qos_stm32.c | 44 ++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/drivers/net/dwc_eth_qos_stm32.c b/drivers/net/dwc_eth_qos_stm32.c
index 7a28f2a3e83..57ac528ebf5 100644
--- a/drivers/net/dwc_eth_qos_stm32.c
+++ b/drivers/net/dwc_eth_qos_stm32.c
@@ -137,13 +137,15 @@ static int eqos_probe_syscfg_stm32(struct udevice *dev,
 	const bool eth_ref_clk_sel = dev_read_bool(dev, "st,eth-ref-clk-sel");
 	/* SoC is STM32MP13xx with two ethernet MACs */
 	const bool is_mp13 = device_is_compatible(dev, "st,stm32mp13-dwmac");
+	/* SoC is STM32MP25xx with two ethernet MACs */
+	const bool is_mp2 = device_is_compatible(dev, "st,stm32mp25-dwmac");
 	/* Gigabit Ethernet 125MHz clock selection. */
 	const bool eth_clk_sel = dev_read_bool(dev, "st,eth-clk-sel");
 	/* Ethernet clock source is RCC. */
 	const bool ext_phyclk = dev_read_bool(dev, "st,ext-phyclk");
 	struct regmap *regmap;
 	u32 regmap_mask;
-	u32 value;
+	u32 reg, value;
 
 	regmap = syscon_regmap_lookup_by_phandle(dev, "st,syscon");
 	if (IS_ERR(regmap))
@@ -163,7 +165,7 @@ static int eqos_probe_syscfg_stm32(struct udevice *dev,
 		 * acts as a selector between 0:GMII and 1:MII. As STM32MP13xx
 		 * supports only MII, ETH_SELMII is not present.
 		 */
-		if (!is_mp13)	/* Select MII mode on STM32MP15xx */
+		if (!is_mp13 && !is_mp2) /* Select MII mode on STM32MP15xx */
 			value |= SYSCFG_PMCSETR_ETH_SELMII;
 		break;
 	case PHY_INTERFACE_MODE_GMII:	/* STM32MP15xx only */
@@ -213,15 +215,39 @@ static int eqos_probe_syscfg_stm32(struct udevice *dev,
 		return -EINVAL;
 	}
 
-	/* Shift value at correct ethernet MAC offset in SYSCFG_PMCSETR */
-	value <<= ffs(regmap_mask) - ffs(SYSCFG_PMCSETR_ETH1_MASK);
+	if (is_mp2) {
+		/*
+		 * STM32MP25xx SYSCFG EthernetN control register
+		 * has ETHn_CLK_SEL and ETHn_REF_CLK_SEL bits
+		 * swapped, swizzle them back in place. Bitfield
+		 * ETHn_SEL is shifted by 1 right, fix this up.
+		 */
+		value = ((value & SYSCFG_PMCSETR_ETH_SEL_MASK) >> 1) |
+			((value & SYSCFG_PMCSETR_ETH_CLK_SEL) << 1) |
+			((value & SYSCFG_PMCSETR_ETH_REF_CLK_SEL) >> 1);
+
+		/*
+		 * STM32MP25xx SYSCFG EthernetN control register
+		 * bits always start at bit shift 0 and there is
+		 * one register for each MAC, shift the register
+		 * content in place.
+		 */
+		value >>= ffs(SYSCFG_PMCSETR_ETH1_MASK) - 1;
+
+		reg = dev_read_u32_index_default(dev, "st,syscon", 1, 0);
 
-	/* Update PMCCLRR (clear register) */
-	regmap_write(regmap, is_mp13 ?
-			     SYSCFG_PMCCLRR_MP13 : SYSCFG_PMCCLRR_MP15,
-			     regmap_mask);
+		return regmap_write(regmap, reg, value);
+	} else {
+		/* Shift value at correct ethernet MAC offset in SYSCFG_PMCSETR */
+		value <<= ffs(regmap_mask) - ffs(SYSCFG_PMCSETR_ETH1_MASK);
 
-	return regmap_update_bits(regmap, SYSCFG_PMCSETR, regmap_mask, value);
+		/* Update PMCCLRR (clear register) */
+		regmap_write(regmap, is_mp13 ?
+				     SYSCFG_PMCCLRR_MP13 : SYSCFG_PMCCLRR_MP15,
+				     regmap_mask);
+
+		return regmap_update_bits(regmap, SYSCFG_PMCSETR, regmap_mask, value);
+	}
 }
 
 static int eqos_probe_resources_stm32(struct udevice *dev)
-- 
2.51.0

