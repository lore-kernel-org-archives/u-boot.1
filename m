Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F441C83F26
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 13:38:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 721E082BA1;
	Wed, 30 Jul 2025 15:37:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rwxehfBy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3AC480548; Wed, 30 Jul 2025 15:37:41 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74E7782F00
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 15:37:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56UDbbLj2774057;
 Wed, 30 Jul 2025 08:37:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1753882657;
 bh=wGwoioubmK5k1gdUddFpmPiS42T9Sk5v4WT1lzCjoP0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=rwxehfByX4UxMUFlb6cfc6bUyAcQo9FGMdzYBHA0HMNN4qKLVCdWvbe6Wb99sAOP7
 p4K/EKfOpjpR0dREj/jtWNL4IIouvx+WsKhdGhDdXNqbr36crDWtVCWRlqp41rwY5j
 KWS7q/y+Eo0PknS8m8wVRtd9TyhlKRB4eaCzxJmc=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56UDbbAe1952832
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 30 Jul 2025 08:37:37 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 30
 Jul 2025 08:37:37 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 30 Jul 2025 08:37:36 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.235.200])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56UDbKNJ1315795;
 Wed, 30 Jul 2025 08:37:34 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <bb@ti.com>, <w.egorov@phytec.de>, <s-k6@ti.com>,
 <marek.vasut+renesas@mailbox.org>, <sabiya.d@ti.com>
CC: <u-kumar1@ti.com>, <n-francis@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v2 4/9] ram: k3-ddrss: Add support for a partial inline ECC
 region
Date: Wed, 30 Jul 2025 19:07:15 +0530
Message-ID: <20250730133720.3315478-5-n-francis@ti.com>
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

Instead of defaulting to choosing the entire DDR region when enabling
inline ECC, allow picking of a range within the DDR space using DT to
enable.

It expects such a node within the memory node, in the absence of which
we resort to enabling inline ECC for the entire DDR region:

inline_ecc: protected@9e780000 {
        device_type = "ecc";
        reg = <0x9e780000 0x0080000>;
        bootph-all;
};

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 drivers/ram/k3-ddrss/k3-ddrss.c | 55 +++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 3 deletions(-)

diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
index a94755c3542..cd117d7eba7 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss.c
+++ b/drivers/ram/k3-ddrss/k3-ddrss.c
@@ -155,6 +155,7 @@ struct k3_ddrss_desc {
 	lpddr4_obj *driverdt;
 	lpddr4_config config;
 	lpddr4_privatedata pd;
+	struct k3_ddrss_ecc_region ecc_range;
 	struct k3_ddrss_ecc_region ecc_regions[K3_DDRSS_MAX_ECC_REG];
 	u64 ecc_reserved_space;
 	u64 ddr_bank_base[CONFIG_NR_DRAM_BANKS];
@@ -733,6 +734,30 @@ static void k3_ddrss_ddr_reg_init(struct k3_ddrss_desc *ddrss)
 	writel(DDRSS_ECC_CTRL_REG_DEFAULT, ddrss->ddrss_ss_cfg + DDRSS_ECC_CTRL_REG);
 }
 
+static void k3_ddrss_ddr_inline_ecc_base_size_calc(struct k3_ddrss_ecc_region *range)
+{
+	fdt_addr_t base;
+	fdt_size_t size;
+	ofnode node1;
+
+	node1 = ofnode_null();
+
+	do {
+		node1 = ofnode_by_prop_value(node1, "device_type", "ecc", 4);
+	} while (!ofnode_is_enabled(node1));
+
+	base = ofnode_get_addr_size(node1, "reg", &size);
+
+	if (base == FDT_ADDR_T_NONE) {
+		debug("%s: Failed to get ECC node reg and size\n", __func__);
+		range->start = 0;
+		range->range = 0;
+	} else {
+		range->start = base;
+		range->range = size;
+	}
+}
+
 static void k3_ddrss_lpddr4_ecc_calc_reserved_mem(struct k3_ddrss_desc *ddrss)
 {
 	fdtdec_setup_mem_size_base_lowest();
@@ -782,8 +807,11 @@ static void k3_ddrss_lpddr4_ecc_init(struct k3_ddrss_desc *ddrss)
 
 static int k3_ddrss_probe(struct udevice *dev)
 {
+	u64 end;
 	int ret;
 	struct k3_ddrss_desc *ddrss = dev_get_priv(dev);
+	__maybe_unused u32 ddr_ram_size, ecc_res;
+	__maybe_unused struct k3_ddrss_ecc_region *range = &ddrss->ecc_range;
 
 	debug("%s(dev=%p)\n", __func__, dev);
 
@@ -821,9 +849,30 @@ static int k3_ddrss_probe(struct udevice *dev)
 
 		k3_ddrss_lpddr4_ecc_calc_reserved_mem(ddrss);
 
-		/* Always configure one region that covers full DDR space */
-		ddrss->ecc_regions[0].start = 0;
-		ddrss->ecc_regions[0].range = ddrss->ddr_ram_size - ddrss->ecc_reserved_space;
+		k3_ddrss_ddr_inline_ecc_base_size_calc(range);
+
+		end = ddrss->ecc_range.start + ddrss->ecc_range.range;
+		ddr_ram_size = ddrss->ddr_ram_size;
+		ecc_res = ddrss->ecc_reserved_space;
+
+		if (!range->range) {
+			/* Configure entire DDR space by default */
+			debug("%s: Defaulting to protecting entire DDR space using inline ECC\n",
+			      __func__);
+			ddrss->ecc_range.start = ddrss->ddr_bank_base[0];
+			ddrss->ecc_range.range = ddr_ram_size - ecc_res;
+		} else {
+			ddrss->ecc_range.start = range->start;
+			ddrss->ecc_range.range = range->range;
+		}
+
+		if (end > (ddr_ram_size - ecc_res))
+			ddrss->ecc_regions[0].range = ddr_ram_size - ecc_res;
+		else
+			ddrss->ecc_regions[0].range = ddrss->ecc_range.range;
+
+		ddrss->ecc_regions[0].start = ddrss->ecc_range.start - ddrss->ddr_bank_base[0];
+
 		k3_ddrss_lpddr4_ecc_init(ddrss);
 	}
 
-- 
2.34.1

