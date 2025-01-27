Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6814C02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 14:23:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F0BC81292;
	Mon, 27 Jan 2025 15:22:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PbVQQIU5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C89E81423; Mon, 27 Jan 2025 15:22:37 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D8D181292
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 15:22:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50REMW7K1840253
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jan 2025 08:22:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1737987752;
 bh=dJUsuJjZOE5w3ZB3nC4uFcS6Odl4aFRUUX14ZQrTV64=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=PbVQQIU5msLEz3C4lJxe+9Wl/KOeHSRQV7oa14bMPsK320MFKmRO5qYr19FJRvT00
 9NrsYXeTmU6DTi9vFTwP0AXPV2MUT5vXg9bXlDd5LBHddhwoqLnn15lNffSs/Qbbm2
 EukoYBbJ0VAupv0AEbjsKkJnEeQs8LQNz41qGXoc=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 50REMWSB065630
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 27 Jan 2025 08:22:32 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 27
 Jan 2025 08:22:31 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 27 Jan 2025 08:22:32 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50REMHfA071075;
 Mon, 27 Jan 2025 08:22:29 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <bb@ti.com>, <w.egorov@phytec.de>, <s-k6@ti.com>,
 <marek.vasut+renesas@mailbox.org>, <sabiya.d@ti.com>
CC: <u-kumar1@ti.com>, <n-francis@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH 4/8] ram: k3-ddrss: Add support for a partial inline ECC region
Date: Mon, 27 Jan 2025 19:52:13 +0530
Message-ID: <20250127142217.1757300-5-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250127142217.1757300-1-n-francis@ti.com>
References: <20250127142217.1757300-1-n-francis@ti.com>
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
 drivers/ram/k3-ddrss/k3-ddrss.c | 52 +++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
index ab46098adbf..ea2578cda58 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss.c
+++ b/drivers/ram/k3-ddrss/k3-ddrss.c
@@ -149,6 +149,7 @@ struct k3_ddrss_desc {
 	lpddr4_obj *driverdt;
 	lpddr4_config config;
 	lpddr4_privatedata pd;
+	struct k3_ddrss_ecc_region ecc_range;
 	struct k3_ddrss_ecc_region ecc_regions[K3_DDRSS_MAX_ECC_REGIONS];
 	u64 ecc_reserved_space;
 	u64 ddr_bank_base[CONFIG_NR_DRAM_BANKS];
@@ -711,6 +712,30 @@ static void k3_ddrss_ddr_bank_base_size_calc(struct k3_ddrss_desc *ddrss)
 		ddrss->ddr_ram_size += ddrss->ddr_bank_size[bank];
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
@@ -759,8 +784,11 @@ static void k3_ddrss_lpddr4_ecc_init(struct k3_ddrss_desc *ddrss)
 
 static int k3_ddrss_probe(struct udevice *dev)
 {
+	u64 end;
 	int ret;
 	struct k3_ddrss_desc *ddrss = dev_get_priv(dev);
+	__maybe_unused struct k3_ddrss_data *ddrss_data = (struct k3_ddrss_data *)dev_get_driver_data(dev);
+	__maybe_unused struct k3_ddrss_ecc_region *range = &ddrss->ecc_range;
 
 	debug("%s(dev=%p)\n", __func__, dev);
 
@@ -802,9 +830,27 @@ static int k3_ddrss_probe(struct udevice *dev)
 
 		k3_ddrss_lpddr4_ecc_calc_reserved_mem(ddrss);
 
-		/* Always configure one region that covers full DDR space */
-		ddrss->ecc_regions[0].start = ddrss->ddr_bank_base[0] - ddrss->ddr_bank_base[0];
-		ddrss->ecc_regions[0].range = ddrss->ddr_ram_size - ddrss->ecc_reserved_space;
+		k3_ddrss_ddr_inline_ecc_base_size_calc(range);
+		if (!range->range) {
+			/* Configure entire DDR space by default */
+			debug("%s: Defaulting to protecting entire DDR space using inline ECC\n",
+			      __func__);
+			ddrss->ecc_range.start = ddrss->ddr_bank_base[0];
+			ddrss->ecc_range.range = ddrss->ddr_ram_size - ddrss->ecc_reserved_space;
+		} else {
+			ddrss->ecc_range.start = range->start;
+			ddrss->ecc_range.range = range->range;
+		}
+
+		end = ddrss->ecc_range.start + ddrss->ecc_range.range;
+
+		if (end > (ddrss->ddr_ram_size - ddrss->ecc_reserved_space))
+			ddrss->ecc_regions[0].range = ddrss->ddr_ram_size - ddrss->ecc_reserved_space;
+		else
+			ddrss->ecc_regions[0].range = ddrss->ecc_range.range;
+
+		ddrss->ecc_regions[0].start = ddrss->ecc_range.start - ddrss->ddr_bank_base[0];
+
 		k3_ddrss_lpddr4_ecc_init(ddrss);
 	}
 
-- 
2.34.1

