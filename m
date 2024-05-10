Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F72C25B10
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 08:48:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD36C884C7;
	Fri, 10 May 2024 10:48:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="iyHy37xe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B00578818B; Fri, 10 May 2024 10:48:26 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A41688194
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 10:48:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44A8mMHU003135;
 Fri, 10 May 2024 03:48:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1715330902;
 bh=VTZaVT9yTbB/CyfwQLA9+i7x6/OWoCkqVc+ZtOwhrk0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=iyHy37xea0E/5ys0CiaYpVOc+ENmcER6JIoCwD5vOzxafQUpOSMhW2XnnQPoxFLFv
 r9gjUxfMwgyHKpeAYkuDeai8e2B823t0OsmE0vyK9//d9PEX9foJ18IsQIwwdpIp0S
 5xzaJwit1HoTJhW+XUGsafJjcouyXp1q4JlCLvvA=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44A8mMfR000506
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 10 May 2024 03:48:22 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 10
 May 2024 03:48:22 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 10 May 2024 03:48:22 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com
 [172.24.227.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44A8mA1c107745;
 Fri, 10 May 2024 03:48:19 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <trini@konsulko.com>, <nm@ti.com>, <vigneshr@ti.com>, <bb@ti.com>,
 <u-kumar1@ti.com>, <m-chawdhry@ti.com>
CC: <u-boot@lists.denx.de>, <n-francis@ti.com>, <s-k6@ti.com>
Subject: [PATCH v2 3/8] ram: k3-ddrss: Setup ECC region start and range
Date: Fri, 10 May 2024 14:17:02 +0530
Message-ID: <20240510084707.1903133-4-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240510084707.1903133-1-s-k6@ti.com>
References: <20240510084707.1903133-1-s-k6@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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
index 06c4dba4b857..6cf680972808 100644
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
@@ -552,7 +552,7 @@ void k3_lpddr4_start(struct k3_ddrss_desc *ddrss)
 	}
 }
 
-static void k3_ddrss_set_ecc_range_r0(u32 base, u32 start_address, u32 size)
+static void k3_ddrss_set_ecc_range_r0(u32 base, u64 start_address, u64 size)
 {
 	writel((start_address) >> 16, base + DDRSS_ECC_R0_STR_ADDR_REG);
 	writel((start_address + size - 1) >> 16, base + DDRSS_ECC_R0_END_ADDR_REG);
@@ -728,13 +728,13 @@ static void k3_ddrss_lpddr4_ecc_calc_reserved_mem(struct k3_ddrss_desc *ddrss)
 
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
@@ -800,8 +800,8 @@ static int k3_ddrss_probe(struct udevice *dev)
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

