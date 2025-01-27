Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61035C02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 14:23:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D4CF8142D;
	Mon, 27 Jan 2025 15:22:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="r8d46IpA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20F9C8128B; Mon, 27 Jan 2025 15:22:46 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB81281671
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 15:22:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50REMeO51802143
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jan 2025 08:22:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1737987760;
 bh=uH4PSvdIQj8hQCSkJIGwWrOY8+DbvutpgmKBvKM6bX4=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=r8d46IpAgYWzyLfG0zYT3GAQWN2OuhUn2dh2jZ0MDVEdOa/8bYXHiMSwP4O3wt9lV
 sHatoyaw11G0pMwlCh8V1++nSQtsrK8dXy74TsImx75jaiypks/YXD0zS1RdgSsLmh
 xY7CXopuY/G1b2hxrjr4MYA9YG2J8sfcYmkX+taM=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 50REMegG065670
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 27 Jan 2025 08:22:40 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 27
 Jan 2025 08:22:40 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 27 Jan 2025 08:22:40 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50REMHfD071075;
 Mon, 27 Jan 2025 08:22:38 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <bb@ti.com>, <w.egorov@phytec.de>, <s-k6@ti.com>,
 <marek.vasut+renesas@mailbox.org>, <sabiya.d@ti.com>
CC: <u-kumar1@ti.com>, <n-francis@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH 7/8] ram: k3-ddrss: Add support for MSMC calculation of DDR
 inline ECC regions
Date: Mon, 27 Jan 2025 19:52:16 +0530
Message-ID: <20250127142217.1757300-8-n-francis@ti.com>
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

Add support for calculation of the protected regions for each DDR in
multi-DDR systems. Since MSMC is the parent node of the individual DDRs
as well as responsible for their interleaving, it only makes sense for
MSMC to contain the logic for dividing the regions.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 drivers/ram/k3-ddrss/k3-ddrss.c | 122 ++++++++++++++++++++++++++++++--
 1 file changed, 115 insertions(+), 7 deletions(-)

diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
index 51b4c1bf45a..205dce51799 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss.c
+++ b/drivers/ram/k3-ddrss/k3-ddrss.c
@@ -53,6 +53,7 @@
 
 #define SINGLE_DDR_SUBSYSTEM	0x1
 #define MULTI_DDR_SUBSYSTEM	0x2
+#define MAX_MULTI_DDR 4
 
 #define MULTI_DDR_CFG0  0x00114100
 #define MULTI_DDR_CFG1  0x00114104
@@ -76,6 +77,24 @@ enum intrlv_gran {
 	GRAN_16GB
 };
 
+u64 gran_bytes[] = {
+	0x80,
+	0x200,
+	0x800,
+	0x1000,
+	0x4000,
+	0x8000,
+	0x80000,
+	0x40000000,
+	0x60000000,
+	0x80000000,
+	0xC0000000,
+	0x100000000,
+	0x180000000,
+	0x200000000,
+	0x400000000
+};
+
 enum intrlv_size {
 	SIZE_0,
 	SIZE_128MB,
@@ -115,6 +134,13 @@ enum emif_active {
 	EMIF_ALL
 };
 
+#define K3_DDRSS_MAX_ECC_REGIONS		3
+
+struct k3_ddrss_ecc_region {
+	u64 start;
+	u64 range;
+};
+
 struct k3_msmc {
 	enum intrlv_gran gran;
 	enum intrlv_size size;
@@ -122,13 +148,7 @@ struct k3_msmc {
 	enum emif_config config;
 	enum emif_active active;
 	u32 num_ddr;
-};
-
-#define K3_DDRSS_MAX_ECC_REGIONS		3
-
-struct k3_ddrss_ecc_region {
-	u64 start;
-	u64 range;
+	struct k3_ddrss_ecc_region R0[MAX_MULTI_DDR];
 };
 
 struct k3_ddrss_desc {
@@ -914,6 +934,83 @@ U_BOOT_DRIVER(k3_ddrss) = {
 	.priv_auto		= sizeof(struct k3_ddrss_desc),
 };
 
+#if IS_ENABLED(CONFIG_K3_MULTI_DDR)
+static int k3_msmc_calculate_r0_regions(struct k3_msmc *msmc)
+{
+	u32 n1;
+	u32 size, ret = 0;
+	u32 gran = gran_bytes[msmc->gran];
+	u32 num_ddr = msmc->num_ddr;
+	struct k3_ddrss_ecc_region *range = NULL;
+	struct k3_ddrss_ecc_region R[num_ddr];
+
+	range = kzalloc(sizeof(range), GFP_KERNEL);
+	if (!range) {
+		debug("%s: failed to allocate range\n", __func__);
+		ret = -ENOMEM;
+		return ret;
+	}
+
+	k3_ddrss_ddr_inline_ecc_base_size_calc(range);
+
+	if (!range->range) {
+		ret = -EINVAL;
+		goto range_err;
+	}
+
+	memset(R, 0, num_ddr);
+
+	/* Find the first controller in the range */
+	n1 = ((range->start / gran) % num_ddr);
+	size = range->range;
+
+	if (size < gran) {
+		R[n1].start = range->start - 0x80000000;
+		R[n1].range = range->start + range->range - 0x80000000;
+	} else {
+		u32 chunk_start_addr = range->start;
+		u32 chunk_size = range->range;
+
+		while (chunk_size > 0) {
+			u32 edge;
+			u32 end = range->start + range->range;
+
+			if ((chunk_start_addr % gran) == 0)
+				edge = chunk_start_addr + gran;
+			else
+				edge = ((chunk_start_addr + (gran - 1)) & (-gran));
+
+			if (edge > end)
+				break;
+
+			if (R[n1].start == 0)
+				R[n1].start = chunk_start_addr;
+
+			R[n1].range = edge - R[n1].start;
+			chunk_size = end - edge;
+			chunk_start_addr = edge;
+
+			if (n1 == (num_ddr - 1))
+				n1 = 0;
+			else
+				n1++;
+		}
+
+		for (int i = 0; i < num_ddr; i++)
+			R[i].start = (R[i].start - 0x80000000 - (gran * i)) / num_ddr;
+	}
+
+	for (int i = 0; i < num_ddr; i++) {
+		msmc->R0[i].start = R[i].start;
+		msmc->R0[i].range = R[i].range;
+	}
+
+range_err:
+	free(range);
+	return ret;
+}
+#endif
+
 static int k3_msmc_set_config(struct k3_msmc *msmc)
 {
 	u32 ddr_cfg0 = 0;
@@ -993,6 +1090,17 @@ static int k3_msmc_probe(struct udevice *dev)
 	}
 	msmc->num_ddr = ret;
 
+#if IS_ENABLED(CONFIG_K3_MULTI_DDR) && IS_ENABLED(CONFIG_K3_INLINE_ECC)
+	ret = k3_msmc_calculate_r0_regions(msmc);
+	if (ret) {
+		/* Default to enabling inline ECC for entire DDR region */
+		debug("%s: calculation of inline ECC regions failed, defaulting to entire region\n",
+		      __func__);
+
+		/* Use first R0 entry as a flag to denote MSMC calculation failure */
+		msmc->R0[0].start = -1;
+	}
+#endif
 	return 0;
 }
 
-- 
2.34.1

