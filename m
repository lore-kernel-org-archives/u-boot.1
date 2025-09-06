Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06DDBCA1002
	for <u-boot@archiver.kernel.org>; Sat,  6 Sep 2025 23:03:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4522583929;
	Sun,  7 Sep 2025 01:03:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="x/o/EWEr";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nvGfM2K5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BCC48393E; Sun,  7 Sep 2025 01:03:12 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0866E83327
 for <u-boot@lists.denx.de>; Sun,  7 Sep 2025 01:03:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cK7zd5Zxhz9sRk;
 Sun,  7 Sep 2025 01:03:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1757199789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=y+O5RgdIRd/uMBnLSG95SsybuMM4EDkKJ8FCU/lIX7g=;
 b=x/o/EWErUYBaKy5OH+tBSWdDgtPydd8M/UuiDG47PWz0SiiN+RlTN3OWCDT12c/0uPmmxC
 nkMSONxYCYBiHYx1D4k/bbg4icrk1G5H07+yMIuxlGUhi8pWcQReB7DSQ0pL8cE4HDaL6F
 SxGa32usACFTErrXV/eWVLNh9rBn9h8RpYJflUfyJ5VCT+KodqnhGMNwl0SLyNT/RGmccL
 cExBWxepTlh/vS+Uir1iRgYcdUrKtzxdlsIPMBCBdsuevVoFszsXC3sUKNuosc1x4Y51c8
 Q6f7lnyJ2tVl9QMgr7xQVOh56DDVW3Pg4qvUIx0jilTP2u/ip/3VkJPWCYnt6A==
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1757199787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=y+O5RgdIRd/uMBnLSG95SsybuMM4EDkKJ8FCU/lIX7g=;
 b=nvGfM2K5TxiST9aTteops1FdNqHqLUxQHWZ9+r7HGjo1En+Nl+NH2sF2MigsD4NXlNSgc4
 AUVJBUXQmP0W80u1cjWH1ZcF3uwW0hO4S+NHUjSKPlxyi1IT6ta7vWgDBA7u1IQ/ioQeuy
 av1EQPFLZO7EhEesVyb6TQQvTGPh4XbEXku0KGy6Fo0QRBooyeYM5O23Xepbedl8j2nVk+
 UWYiXSBr2FwcCo181M65qVwa7MHgNf3r5eH7L7RUj6XNbGWono09LDq07+0mzwc25so8DX
 yei+Ez722jJX3mOGKvSVh82y4dbLsFRhSxZZTpAX/TwHjs6qI5aS80VC1pVfZw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Christophe Roullier <christophe.roullier@foss.st.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] net: dwc_eth_qos: Fix support for stm32mp2 platform
Date: Sun,  7 Sep 2025 01:02:33 +0200
Message-ID: <20250906230258.582840-1-marek.vasut@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 40567213a527f6ecc4c
X-MBO-RS-META: epgw87f9n8f3shwopwof9znikhq1nd9u
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
 drivers/net/dwc_eth_qos_stm32.c | 42 ++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dwc_eth_qos_stm32.c b/drivers/net/dwc_eth_qos_stm32.c
index 7a28f2a3e83..e12039c9661 100644
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
2.50.1

