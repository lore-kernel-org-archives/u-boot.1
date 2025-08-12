Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED7BDCA0EC4
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 12:44:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DE1E833F5;
	Tue, 12 Aug 2025 14:43:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nAvdiBWm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DDD2832DA; Tue, 12 Aug 2025 14:43:46 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 706448341A
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 14:43:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57CChfEC1398236;
 Tue, 12 Aug 2025 07:43:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1755002621;
 bh=WhQqUX0X54hkICo6FrcMduIObi1pjf/Y3ESGINIZJn8=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=nAvdiBWmRBUjM+HZ9gqjmBR8QYA5t40ZBcylqvzJw6KQoKsYjaW3pEBJvZrXzageI
 l5z4cT9RDcwluyepQTA6BBEBIa5+PtguG9gNDF8bXA+EzHbsaI+/1FXQ1K/fzBWgKK
 gsXhRWmSCcYsLZ42WM83S2Y5ooklI+Z6fiPE4B0I=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57CChfd8300931
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 12 Aug 2025 07:43:41 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 12
 Aug 2025 07:43:40 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 12 Aug 2025 07:43:40 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.235.200])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57CChPlD653236;
 Tue, 12 Aug 2025 07:43:38 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <bb@ti.com>, <w.egorov@phytec.de>, <s-k6@ti.com>,
 <marek.vasut+renesas@mailbox.org>, <sabiya.d@ti.com>
CC: <u-kumar1@ti.com>, <n-francis@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v3 4/9] ram: k3-ddrss: Add support for a partial inline ECC
 region
Date: Tue, 12 Aug 2025 18:13:19 +0530
Message-ID: <20250812124324.124306-5-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812124324.124306-1-n-francis@ti.com>
References: <20250812124324.124306-1-n-francis@ti.com>
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
Changes since v2:
- s/u32/u64 for ddr_ram_size
- Added comment for clarity

 drivers/ram/k3-ddrss/k3-ddrss.c | 60 +++++++++++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 3 deletions(-)

diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
index 04fab6518cf..5f48dda4468 100644
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
@@ -783,8 +808,11 @@ static void k3_ddrss_lpddr4_ecc_init(struct k3_ddrss_desc *ddrss)
 
 static int k3_ddrss_probe(struct udevice *dev)
 {
+	u64 end;
 	int ret;
 	struct k3_ddrss_desc *ddrss = dev_get_priv(dev);
+	__maybe_unused u64 ddr_ram_size, ecc_res;
+	__maybe_unused struct k3_ddrss_ecc_region *range = &ddrss->ecc_range;
 
 	debug("%s(dev=%p)\n", __func__, dev);
 
@@ -822,9 +850,35 @@ static int k3_ddrss_probe(struct udevice *dev)
 
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
+		/*
+		 * As we are converting the system address to the DDR controller
+		 * address, account for case when the region is in the second
+		 * bank
+		 */
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

