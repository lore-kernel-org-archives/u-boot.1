Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D315C47DB3
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 11:44:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AD3587C26;
	Wed, 31 Jan 2024 12:44:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="u4NSvoKR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC89687796; Wed, 31 Jan 2024 07:02:44 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C171D8792D
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 07:02:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40V62fte125696;
 Wed, 31 Jan 2024 00:02:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706680961;
 bh=Og2O2MqvBNiYgVtwLGZHiX5vFYicati5xVCg8uBEBVA=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=u4NSvoKRNFzQsGnYWgcqIKd4yD4aItYKIACcaOOOwkXpGew/IIunQmSmP2lDIbWER
 rxOms53MOIqFaD3ZwHkCspH5EmNZolN/rW4GScS598Te0qBJusVa2HiT3zwNaB+WmU
 +r/z19PemxRk9V9XCn6sDFmpNMePNm9LygPuMHes=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40V62fNN002172
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 31 Jan 2024 00:02:41 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 00:02:40 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 00:02:38 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com
 [172.24.227.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40V62Utd062916;
 Wed, 31 Jan 2024 00:02:36 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <trini@konsulko.com>, <nm@ti.com>, <vigneshr@ti.com>, <bb@ti.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH 03/10] ram: k3-ddrss: Setup ECC region start and range
Date: Wed, 31 Jan 2024 11:32:06 +0530
Message-ID: <20240131060213.1128024-4-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131060213.1128024-1-s-k6@ti.com>
References: <20240131060213.1128024-1-s-k6@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Wed, 31 Jan 2024 12:44:04 +0100
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
Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
---
 drivers/ram/k3-ddrss/k3-ddrss.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
index 0e77b58edf4d..de1441f94a87 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss.c
+++ b/drivers/ram/k3-ddrss/k3-ddrss.c
@@ -122,8 +122,8 @@ struct k3_msmc {
 #define K3_DDRSS_MAX_ECC_REGIONS		3
 
 struct k3_ddrss_ecc_region {
-	u32 start;
-	u32 range;
+	u64 start;
+	u64 range;
 };
 
 struct k3_ddrss_desc {
@@ -727,13 +727,13 @@ static void k3_ddrss_lpddr4_ecc_calc_reserved_mem(struct k3_ddrss_desc *ddrss)
 
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
@@ -799,8 +799,8 @@ static int k3_ddrss_probe(struct udevice *dev)
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

