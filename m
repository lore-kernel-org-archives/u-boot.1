Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64429D3C93E
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 04:41:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAA88892B6;
	Mon, 21 Oct 2024 06:41:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="W36iHjen";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85E8F892AB; Mon, 21 Oct 2024 06:41:19 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C598891FE
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 06:41:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49L4fFS2037649;
 Sun, 20 Oct 2024 23:41:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1729485675;
 bh=R41EjxKatlelTy2T7oIJjgYTbLUHc955Ih2VyXFOGuE=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=W36iHjenQHORQ/8n4Tyl6PRbP2izR+GmX/ecscE5BbuMcS5onUPMCpMHEPIKX1n7x
 6QISs08kirNkMtAJgBAZgt48xhcXooN8WrcVyQhQBP6iC3CkY1Ycoq8JTACtDhZkSA
 /3R8Vmtvc3n2eJUXkyMbN+Z/BLoP8N10qGpJxIC0=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49L4fF9R080017
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 20 Oct 2024 23:41:15 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 20
 Oct 2024 23:41:14 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 20 Oct 2024 23:41:14 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com
 [172.24.227.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49L4f2tu059251;
 Sun, 20 Oct 2024 23:41:12 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <trini@konsulko.com>, <m-chawdhry@ti.com>, <nm@ti.com>, <u-kumar1@ti.com>, 
 <vigneshr@ti.com>, <bb@ti.com>
CC: <u-boot@lists.denx.de>, <w.egorov@phytec.de>, <n-francis@ti.com>,
 <s-k6@ti.com>
Subject: [PATCH v4 3/8] ram: k3-ddrss: Setup ECC region start and range
Date: Mon, 21 Oct 2024 10:10:19 +0530
Message-ID: <20241021044024.835846-4-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021044024.835846-1-s-k6@ti.com>
References: <20241021044024.835846-1-s-k6@ti.com>
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
index bd6783ebc2cd..66b7f31f4f64 100644
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
@@ -551,7 +551,7 @@ void k3_lpddr4_start(struct k3_ddrss_desc *ddrss)
 	}
 }
 
-static void k3_ddrss_set_ecc_range_r0(u32 base, u32 start_address, u32 size)
+static void k3_ddrss_set_ecc_range_r0(u32 base, u64 start_address, u64 size)
 {
 	writel((start_address) >> 16, base + DDRSS_ECC_R0_STR_ADDR_REG);
 	writel((start_address + size - 1) >> 16, base + DDRSS_ECC_R0_END_ADDR_REG);
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

