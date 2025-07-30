Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64090C83F26
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 13:38:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A937180C93;
	Wed, 30 Jul 2025 15:37:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qizRbx91";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0263B830B4; Wed, 30 Jul 2025 15:37:51 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF58780548
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 15:37:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56UDbksC3215573;
 Wed, 30 Jul 2025 08:37:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1753882666;
 bh=sukBbVdoflcl2IospIVQ1K23FeY956SroUPfTu3LrXw=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=qizRbx91XvMZ4xLiH57Cz0K4xTH4wAtljmUsdduRekc7QJxGAF3Sd6jJOsYXTznf1
 yd+opmzQEBn5MlpLgAS0KMFYJd6BPX5HQjSU3hHqF+hxylcSYT6qafGTX1DFYixn+p
 j877Sq4FBimrlPoZoGXyn48vP9lJVCKHEDk9k81U=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56UDbklA2595313
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 30 Jul 2025 08:37:46 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 30
 Jul 2025 08:37:46 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 30 Jul 2025 08:37:46 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.235.200])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56UDbKNM1315795;
 Wed, 30 Jul 2025 08:37:43 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <bb@ti.com>, <w.egorov@phytec.de>, <s-k6@ti.com>,
 <marek.vasut+renesas@mailbox.org>, <sabiya.d@ti.com>
CC: <u-kumar1@ti.com>, <n-francis@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v2 7/9] ram: k3-ddrss: Add support for MSMC calculation of DDR
 inline ECC regions
Date: Wed, 30 Jul 2025 19:07:18 +0530
Message-ID: <20250730133720.3315478-8-n-francis@ti.com>
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

Add support for calculation of the protected regions for each DDR in
multi-DDR systems. Since MSMC is the parent node of the individual DDRs
as well as responsible for their interleaving, it only makes sense for
MSMC to contain the logic for dividing the regions.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 drivers/ram/k3-ddrss/k3-ddrss.c | 120 ++++++++++++++++++++++++++++++--
 1 file changed, 113 insertions(+), 7 deletions(-)

diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
index 2d2558eaa9e..1c2e5e1835b 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss.c
+++ b/drivers/ram/k3-ddrss/k3-ddrss.c
@@ -59,6 +59,7 @@
 
 #define SINGLE_DDR_SUBSYSTEM	0x1
 #define MULTI_DDR_SUBSYSTEM	0x2
+#define MAX_MULTI_DDR 4
 
 #define MULTI_DDR_CFG0  0x00114100
 #define MULTI_DDR_CFG1  0x00114104
@@ -82,6 +83,24 @@ enum intrlv_gran {
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
@@ -121,6 +140,13 @@ enum emif_active {
 	EMIF_ALL
 };
 
+#define K3_DDRSS_MAX_ECC_REG		3
+
+struct k3_ddrss_ecc_region {
+	u64 start;
+	u64 range;
+};
+
 struct k3_msmc {
 	enum intrlv_gran gran;
 	enum intrlv_size size;
@@ -128,13 +154,7 @@ struct k3_msmc {
 	enum emif_config config;
 	enum emif_active active;
 	u32 num_ddr;
-};
-
-#define K3_DDRSS_MAX_ECC_REG		3
-
-struct k3_ddrss_ecc_region {
-	u64 start;
-	u64 range;
+	struct k3_ddrss_ecc_region R0[MAX_MULTI_DDR];
 };
 
 struct k3_ddrss_desc {
@@ -936,6 +956,80 @@ U_BOOT_DRIVER(k3_ddrss) = {
 	.priv_auto		= sizeof(struct k3_ddrss_desc),
 };
 
+__maybe_unused static int k3_msmc_calculate_r0_regions(struct k3_msmc *msmc)
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
+
 static int k3_msmc_set_config(struct k3_msmc *msmc)
 {
 	u32 ddr_cfg0 = 0;
@@ -1015,6 +1109,18 @@ static int k3_msmc_probe(struct udevice *dev)
 	}
 	msmc->num_ddr = ret;
 
+	if (IS_ENABLED(CONFIG_K3_MULTI_DDR) && IS_ENABLED(CONFIG_K3_INLINE_ECC)) {
+		ret = k3_msmc_calculate_r0_regions(msmc);
+		if (ret) {
+			/* Default to enabling inline ECC for entire DDR region */
+			debug("%s: calculation of inline ECC regions failed, defaulting to entire region\n",
+			      __func__);
+
+			/* Use first R0 entry as a flag to denote MSMC calculation failure */
+			msmc->R0[0].start = -1;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.34.1

