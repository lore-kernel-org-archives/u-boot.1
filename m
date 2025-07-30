Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97604C87FCB
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 13:38:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B0EC82F00;
	Wed, 30 Jul 2025 15:37:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pnSUIQNf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB09C82F00; Wed, 30 Jul 2025 15:37:57 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E810A80548
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 15:37:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56UDbrpj2774097;
 Wed, 30 Jul 2025 08:37:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1753882673;
 bh=whMzsnbb0heWPmgMHoBDFzraoIPNZVABkl/LwtwdW1U=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=pnSUIQNfD/J0qVhIHVNQQD+p0T7Cltd9tK+yvfoTHXZ/vd6mCJg8WWQCdwXBhqhwo
 VZR5fdSaUCmgJMMqR1JBHX088ABIo/Kb3iZpUn+tmS4HnpRFMHbjCye/dvCfZjOY8P
 rD89FkOMBO8IPKvqgBMc30WWn/XqnzvVfIpmNHbI=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56UDbrmR3233055
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 30 Jul 2025 08:37:53 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 30
 Jul 2025 08:37:52 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 30 Jul 2025 08:37:52 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.235.200])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56UDbKNO1315795;
 Wed, 30 Jul 2025 08:37:50 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <bb@ti.com>, <w.egorov@phytec.de>, <s-k6@ti.com>,
 <marek.vasut+renesas@mailbox.org>, <sabiya.d@ti.com>
CC: <u-kumar1@ti.com>, <n-francis@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v2 9/9] ram: k3-ddrss: Support multiple ECC regions for a
 single controller
Date: Wed, 30 Jul 2025 19:07:20 +0530
Message-ID: <20250730133720.3315478-10-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250730133720.3315478-1-n-francis@ti.com>
References: <20250730133720.3315478-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

K3 Inline ECC mechanism can support up to 3 regions of inline ECC, add
this support for single controller.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 drivers/ram/k3-ddrss/k3-ddrss.c | 125 +++++++++++++++++++++-----------
 1 file changed, 83 insertions(+), 42 deletions(-)

diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
index e00711a2235..ee123b3b9eb 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss.c
+++ b/drivers/ram/k3-ddrss/k3-ddrss.c
@@ -176,7 +176,7 @@ struct k3_ddrss_desc {
 	lpddr4_obj *driverdt;
 	lpddr4_config config;
 	lpddr4_privatedata pd;
-	struct k3_ddrss_ecc_region ecc_range;
+	struct k3_ddrss_ecc_region ecc_ranges[K3_DDRSS_MAX_ECC_REG];
 	struct k3_ddrss_ecc_region ecc_regions[K3_DDRSS_MAX_ECC_REG];
 	u64 ecc_reserved_space;
 	u64 ddr_bank_base[CONFIG_NR_DRAM_BANKS];
@@ -576,10 +576,26 @@ void k3_lpddr4_start(struct k3_ddrss_desc *ddrss)
 	}
 }
 
-static void k3_ddrss_set_ecc_range_r0(u32 base, u64 start_address, u64 size)
+static void k3_ddrss_set_ecc_range_rx(u32 x, u32 base, u64 start_address, u64 size)
 {
-	writel((start_address) >> 16, base + DDRSS_ECC_R0_STR_ADDR_REG);
-	writel((start_address + size - 1) >> 16, base + DDRSS_ECC_R0_END_ADDR_REG);
+	u32 start_reg, end_reg;
+
+	switch (x) {
+	case 1:
+		start_reg = DDRSS_ECC_R1_STR_ADDR_REG;
+		end_reg = DDRSS_ECC_R1_END_ADDR_REG;
+		break;
+	case 2:
+		start_reg = DDRSS_ECC_R2_STR_ADDR_REG;
+		end_reg = DDRSS_ECC_R2_END_ADDR_REG;
+		break;
+	default:
+		start_reg = DDRSS_ECC_R0_STR_ADDR_REG;
+		end_reg = DDRSS_ECC_R0_END_ADDR_REG;
+		break;
+	}
+	writel((start_address) >> 16, base + start_reg);
+	writel((start_address + size - 1) >> 16, base + end_reg);
 }
 
 #define BIST_MODE_MEM_INIT		4
@@ -755,27 +771,40 @@ static void k3_ddrss_ddr_reg_init(struct k3_ddrss_desc *ddrss)
 	writel(DDRSS_ECC_CTRL_REG_DEFAULT, ddrss->ddrss_ss_cfg + DDRSS_ECC_CTRL_REG);
 }
 
+ofnode get_next_ecc_node(ofnode ecc)
+{
+	do {
+		ecc = ofnode_by_prop_value(ecc, "device_type", "ecc", 4);
+	} while (!ofnode_is_enabled(ecc));
+
+	return ecc;
+}
+
 static void k3_ddrss_ddr_inline_ecc_base_size_calc(struct k3_ddrss_ecc_region *range)
 {
 	fdt_addr_t base;
 	fdt_size_t size;
-	ofnode node1;
-
-	node1 = ofnode_null();
-
-	do {
-		node1 = ofnode_by_prop_value(node1, "device_type", "ecc", 4);
-	} while (!ofnode_is_enabled(node1));
-
-	base = ofnode_get_addr_size(node1, "reg", &size);
+	ofnode ecc_node = ofnode_null();
 
-	if (base == FDT_ADDR_T_NONE) {
-		debug("%s: Failed to get ECC node reg and size\n", __func__);
+	ecc_node = get_next_ecc_node(ecc_node);
+	if (!ofnode_valid(ecc_node)) {
+		debug("%s: No ECC node, enabling for entire region\n", __func__);
 		range->start = 0;
 		range->range = 0;
-	} else {
+		return;
+	}
+
+	for (int i = 0; i < K3_DDRSS_MAX_ECC_REG; i++) {
+		base = ofnode_get_addr_size(ecc_node, "reg", &size);
+		if (base == FDT_ADDR_T_NONE) {
+			range->start = 0;
+			range->range = 0;
+			break;
+		}
 		range->start = base;
 		range->range = size;
+		range++;
+		ecc_node = get_next_ecc_node(ecc_node);
 	}
 }
 
@@ -797,13 +826,21 @@ static void k3_ddrss_lpddr4_ecc_calc_reserved_mem(struct k3_ddrss_desc *ddrss)
 
 static void k3_ddrss_lpddr4_ecc_init(struct k3_ddrss_desc *ddrss)
 {
-	u64 ecc_region_start = ddrss->ecc_regions[0].start;
-	u64 ecc_range = ddrss->ecc_regions[0].range;
+	u64 ecc_region0_start = ddrss->ecc_regions[0].start;
+	u64 ecc_range0 = ddrss->ecc_regions[0].range;
+	u64 ecc_region1_start = ddrss->ecc_regions[1].start;
+	u64 ecc_range1 = ddrss->ecc_regions[1].range;
+	u64 ecc_region2_start = ddrss->ecc_regions[2].start;
+	u64 ecc_range2 = ddrss->ecc_regions[2].range;
 	u32 base = (u32)ddrss->ddrss_ss_cfg;
 	u32 val;
 
 	/* Only Program region 0 which covers full ddr space */
-	k3_ddrss_set_ecc_range_r0(base, ecc_region_start, ecc_range);
+	k3_ddrss_set_ecc_range_rx(0, base, ecc_region0_start, ecc_range0);
+	if (ecc_range1)
+		k3_ddrss_set_ecc_range_rx(1, base, ecc_region1_start, ecc_range1);
+	if (ecc_range2)
+		k3_ddrss_set_ecc_range_rx(2, base, ecc_region2_start, ecc_range2);
 
 	/* Enable ECC, RMW, WR_ALLOC */
 	writel(DDRSS_ECC_CTRL_REG_ECC_EN | DDRSS_ECC_CTRL_REG_RMW_EN |
@@ -828,11 +865,11 @@ static void k3_ddrss_lpddr4_ecc_init(struct k3_ddrss_desc *ddrss)
 
 static int k3_ddrss_probe(struct udevice *dev)
 {
-	u64 end, bank0, bank1;
+	u64 end, bank0, bank1, bank0_size;
 	int ret;
 	struct k3_ddrss_desc *ddrss = dev_get_priv(dev);
-	__maybe_unused u32 inst, ddr_ram_size, ecc_res, st;
-	__maybe_unused struct k3_ddrss_ecc_region *range = &ddrss->ecc_range;
+	__maybe_unused u32 inst, ddr_ram_size, ecc_res;
+	__maybe_unused struct k3_ddrss_ecc_region *range = ddrss->ecc_ranges;
 	__maybe_unused struct k3_msmc *msmc_parent = NULL;
 
 	debug("%s(dev=%p)\n", __func__, dev);
@@ -873,39 +910,43 @@ static int k3_ddrss_probe(struct udevice *dev)
 
 		k3_ddrss_ddr_inline_ecc_base_size_calc(range);
 
-		end = ddrss->ecc_range.start + ddrss->ecc_range.range;
-		inst = ddrss->instance;
-		ddr_ram_size = ddrss->ddr_ram_size;
-		ecc_res = ddrss->ecc_reserved_space;
 		bank0 = ddrss->ddr_bank_base[0];
 		bank1 = ddrss->ddr_bank_base[1];
+		bank0_size = ddrss->ddr_bank_size[0];
 
 		if (!range->range) {
 			/* Configure entire DDR space by default */
 			debug("%s: Defaulting to protecting entire DDR space using inline ECC\n",
 			      __func__);
-			ddrss->ecc_range.start = bank0;
-			ddrss->ecc_range.range = ddr_ram_size - ecc_res;
+			ddrss->ecc_ranges[0].start = bank0;
+			ddrss->ecc_ranges[0].range = ddr_ram_size - ecc_res;
 		} else {
-			ddrss->ecc_range.start = range->start;
-			ddrss->ecc_range.range = range->range;
+			ddrss->ecc_ranges[0].start = range->start;
+			ddrss->ecc_ranges[0].range = range->range;
 		}
 
-		st = ddrss->ecc_range.start;
-
 		if (!CONFIG_IS_ENABLED(K3_MULTI_DDR)) {
-			if (end > (ddr_ram_size - ecc_res))
-				ddrss->ecc_regions[0].range = ddr_ram_size - ecc_res;
-			else
-				ddrss->ecc_regions[0].range = ddrss->ecc_range.range;
+			struct k3_ddrss_ecc_region *r = range;
 
-			/* Check in which bank we are */
-			if (st > bank1)
-				ddrss->ecc_regions[0].start = st - bank1 + ddrss->ddr_bank_size[0];
-			else
-				ddrss->ecc_regions[0].start = st - bank0;
+			for (int i = 0; (i < K3_DDRSS_MAX_ECC_REG) && (r->range != 0); i++, r++) {
+				end = r->start + r->range;
+				ddr_ram_size = ddrss->ddr_ram_size;
+				ecc_res = ddrss->ecc_reserved_space;
+
+				if (end > (ddr_ram_size - ecc_res))
+					ddrss->ecc_regions[i].range = ddr_ram_size - ecc_res;
+				else
+					ddrss->ecc_regions[i].range = r->range;
+
+				/* Check in which bank we are */
+				if (r->start > bank1)
+					ddrss->ecc_regions[i].start = r->start - bank1 + bank0_size;
+				else
+					ddrss->ecc_regions[i].start = r->start - bank0;
+			}
 		} else {
 			/* For multi-DDR, we rely on MSMC's calculation of regions for each DDR */
+			inst = ddrss->instance;
 			msmc_parent = kzalloc(sizeof(msmc_parent), GFP_KERNEL);
 			if (!msmc_parent)
 				return -ENOMEM;
@@ -920,7 +961,7 @@ static int k3_ddrss_probe(struct udevice *dev)
 
 			if (msmc_parent->R0[0].start < 0) {
 				/* Configure entire DDR space by default */
-				ddrss->ecc_regions[0].start = ddrss->ddr_bank_base[0];
+				ddrss->ecc_regions[0].start = bank0;
 				ddrss->ecc_regions[0].range = ddr_ram_size - ecc_res;
 			} else {
 				end = msmc_parent->R0[inst].start + msmc_parent->R0[inst].range;
-- 
2.34.1

