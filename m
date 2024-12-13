Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F3CE7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 10:32:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77A608022F;
	Fri, 13 Dec 2024 11:32:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nT48J1Lu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A583080239; Fri, 13 Dec 2024 11:32:14 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7244F8012C
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 11:32:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BDAWAvO3074898
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Dec 2024 04:32:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734085930;
 bh=yEdl/+gC93JGQAUIBYb4AOlSeoi/bONVRDcEDn94K+4=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=nT48J1Lu65lM/AwJUmaFTITOUccLUQ3eGei2PzX8EEpA6awH8VeAVuIF1QZRBOno4
 Lfo8zLSpK0vaRWJia1sup8byW68IlEWrTqlg8u11AC+lw46yNoOYgWHRFfHbc/GRzg
 Y+QAXzktli32CwQLtOIy9b6naZ3vHLv+rUjXhimg=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BDAWAUR045877
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 13 Dec 2024 04:32:10 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 13
 Dec 2024 04:32:10 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 13 Dec 2024 04:32:10 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com
 [172.24.227.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BDAVpq9067253;
 Fri, 13 Dec 2024 04:32:06 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <trini@konsulko.com>, <nm@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <bb@ti.com>, <m-chawdhry@ti.com>, <vaishnav.a@ti.com>, <j-choudhary@ti.com>
CC: <u-boot@lists.denx.de>, <w.egorov@phytec.de>, <n-francis@ti.com>,
 <s-k6@ti.com>
Subject: [PATCH v5 4/9] ram: k3-ddrss: Setup ECC region start and range
Date: Fri, 13 Dec 2024 16:01:24 +0530
Message-ID: <20241213103129.332246-5-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213103129.332246-1-s-k6@ti.com>
References: <20241213103129.332246-1-s-k6@ti.com>
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

Setup the ECC region's start and range using the device private data,
ddrss->ddr_bank_base[0] and ddrss->ddr_ram_size. Also, move start and
range of ECC regions from 32 bits to 64 bits to accommodate for
DDR greater than or equal to 4GB.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/ram/k3-ddrss/k3-ddrss.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
index 29ce53453c1f..0678db3b418b 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss.c
+++ b/drivers/ram/k3-ddrss/k3-ddrss.c
@@ -121,8 +121,8 @@ struct k3_msmc {
 #define K3_DDRSS_MAX_ECC_REGIONS		3
 
 struct k3_ddrss_ecc_region {
-	u32 start;
-	u32 range;
+	u64 start;
+	u64 range;
 };
 
 struct k3_ddrss_desc {
@@ -546,7 +546,7 @@ void k3_lpddr4_start(struct k3_ddrss_desc *ddrss)
 	}
 }
 
-static void k3_ddrss_set_ecc_range_r0(u32 base, u32 start_address, u32 size)
+static void k3_ddrss_set_ecc_range_r0(u32 base, u64 start_address, u64 size)
 {
 	writel((start_address) >> 16, base + DDRSS_ECC_R0_STR_ADDR_REG);
 	writel((start_address + size - 1) >> 16, base + DDRSS_ECC_R0_END_ADDR_REG);
@@ -722,13 +722,13 @@ static void k3_ddrss_lpddr4_ecc_calc_reserved_mem(struct k3_ddrss_desc *ddrss)
 
 static void k3_ddrss_lpddr4_ecc_init(struct k3_ddrss_desc *ddrss)
 {
-	u32 ecc_region_start = ddrss->ecc_regions[0].start;
-	u32 ecc_range = ddrss->ecc_regions[0].range;
+	u64 ecc_region_start = ddrss->ecc_regions[0].start;
+	u64 ecc_range = ddrss->ecc_regions[0].range;
 	u32 base = (u32)ddrss->ddrss_ss_cfg;
 	u32 val;
 
 	/* Only Program region 0 which covers full ddr space */
-	k3_ddrss_set_ecc_range_r0(base, ecc_region_start - gd->ram_base, ecc_range);
+	k3_ddrss_set_ecc_range_r0(base, ecc_region_start - ddrss->ddr_bank_base[0], ecc_range);
 
 	/* Enable ECC, RMW, WR_ALLOC */
 	writel(DDRSS_ECC_CTRL_REG_ECC_EN | DDRSS_ECC_CTRL_REG_RMW_EN |
@@ -794,8 +794,8 @@ static int k3_ddrss_probe(struct udevice *dev)
 		k3_ddrss_lpddr4_ecc_calc_reserved_mem(ddrss);
 
 		/* Always configure one region that covers full DDR space */
-		ddrss->ecc_regions[0].start = gd->ram_base;
-		ddrss->ecc_regions[0].range = gd->ram_size - ddrss->ecc_reserved_space;
+		ddrss->ecc_regions[0].start = ddrss->ddr_bank_base[0];
+		ddrss->ecc_regions[0].range = ddrss->ddr_ram_size - ddrss->ecc_reserved_space;
 		k3_ddrss_lpddr4_ecc_init(ddrss);
 	}
 
-- 
2.34.1

