Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4118FCA0EC4
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 12:45:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9485B8357D;
	Tue, 12 Aug 2025 14:43:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dd+Owi7o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B909C832DA; Tue, 12 Aug 2025 14:43:58 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89DDD834AD
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 14:43:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57CChr5m1398244;
 Tue, 12 Aug 2025 07:43:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1755002633;
 bh=Fh7ebWylGZzgDzqGApZEpWauNBzNaBRQdzp1K4dpsQU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=dd+Owi7ovAaooGrYHkrj2RcKqklWSlhaeGcsTFjhgl6AumvdMe5Yu+uPZhjyGc9sp
 eEiJfL4eJ2FhM676+lZIVEdMGCGySKx75WLdcVvCN7BV0Pf7/cnyTJ0kFrb8947XQv
 hU4iHySnINbRn8pKpZmF3R9FWukRov42qWO6KOlg=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57CChrc53466826
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 12 Aug 2025 07:43:53 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 12
 Aug 2025 07:43:53 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 12 Aug 2025 07:43:53 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.235.200])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57CChPlH653236;
 Tue, 12 Aug 2025 07:43:50 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <bb@ti.com>, <w.egorov@phytec.de>, <s-k6@ti.com>,
 <marek.vasut+renesas@mailbox.org>, <sabiya.d@ti.com>
CC: <u-kumar1@ti.com>, <n-francis@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v3 8/9] ram: k3-ddrss: Add support for partial inline ECC in
 multi-DDR systems
Date: Tue, 12 Aug 2025 18:13:23 +0530
Message-ID: <20250812124324.124306-9-n-francis@ti.com>
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

The existing approach does not account for interleaving in the DDRs when
setting up regions. There is support for MSMC to calculate the regions
for each DDR, so modify k3_ddrss_probe to set the regions accordingly
for multi-DDR systems.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
No change since v2

 drivers/ram/k3-ddrss/k3-ddrss.c | 62 ++++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 12 deletions(-)

diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
index cb1863a6e9a..0f428374818 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss.c
+++ b/drivers/ram/k3-ddrss/k3-ddrss.c
@@ -829,11 +829,13 @@ static void k3_ddrss_lpddr4_ecc_init(struct k3_ddrss_desc *ddrss)
 
 static int k3_ddrss_probe(struct udevice *dev)
 {
-	u64 end;
+	u64 end, bank0, bank1;
 	int ret;
 	struct k3_ddrss_desc *ddrss = dev_get_priv(dev);
 	__maybe_unused u64 ddr_ram_size, ecc_res;
+	__maybe_unused u32 inst, st;
 	__maybe_unused struct k3_ddrss_ecc_region *range = &ddrss->ecc_range;
+	__maybe_unused struct k3_msmc *msmc_parent = NULL;
 
 	debug("%s(dev=%p)\n", __func__, dev);
 
@@ -874,31 +876,67 @@ static int k3_ddrss_probe(struct udevice *dev)
 		k3_ddrss_ddr_inline_ecc_base_size_calc(range);
 
 		end = ddrss->ecc_range.start + ddrss->ecc_range.range;
+		inst = ddrss->instance;
 		ddr_ram_size = ddrss->ddr_ram_size;
 		ecc_res = ddrss->ecc_reserved_space;
+		bank0 = ddrss->ddr_bank_base[0];
+		bank1 = ddrss->ddr_bank_base[1];
 
 		if (!range->range) {
 			/* Configure entire DDR space by default */
 			debug("%s: Defaulting to protecting entire DDR space using inline ECC\n",
 			      __func__);
-			ddrss->ecc_range.start = ddrss->ddr_bank_base[0];
+			ddrss->ecc_range.start = bank0;
 			ddrss->ecc_range.range = ddr_ram_size - ecc_res;
 		} else {
 			ddrss->ecc_range.start = range->start;
 			ddrss->ecc_range.range = range->range;
 		}
 
-		/*
-		 * As we are converting the system address to the DDR controller
-		 * address, account for case when the region is in the second
-		 * bank
-		 */
-		if (end > (ddr_ram_size - ecc_res))
-			ddrss->ecc_regions[0].range = ddr_ram_size - ecc_res;
-		else
-			ddrss->ecc_regions[0].range = ddrss->ecc_range.range;
+		st = ddrss->ecc_range.start;
+
+		if (!CONFIG_IS_ENABLED(K3_MULTI_DDR)) {
+			if (end > (ddr_ram_size - ecc_res))
+				ddrss->ecc_regions[0].range = ddr_ram_size - ecc_res;
+			else
+				ddrss->ecc_regions[0].range = ddrss->ecc_range.range;
 
-		ddrss->ecc_regions[0].start = ddrss->ecc_range.start - ddrss->ddr_bank_base[0];
+			/* Check in which bank we are */
+			if (st > bank1)
+				ddrss->ecc_regions[0].start = st - bank1 + ddrss->ddr_bank_size[0];
+			else
+				ddrss->ecc_regions[0].start = st - bank0;
+		} else {
+			/* For multi-DDR, we rely on MSMC's calculation of regions for each DDR */
+			msmc_parent = kzalloc(sizeof(msmc_parent), GFP_KERNEL);
+			if (!msmc_parent)
+				return -ENOMEM;
+
+			msmc_parent = dev_get_priv(dev->parent);
+			if (!msmc_parent) {
+				printf("%s: could not get MSMC parent to set up inline ECC regions\n",
+				       __func__);
+				kfree(msmc_parent);
+				return -EINVAL;
+			}
+
+			if (msmc_parent->R0[0].start < 0) {
+				/* Configure entire DDR space by default */
+				ddrss->ecc_regions[0].start = ddrss->ddr_bank_base[0];
+				ddrss->ecc_regions[0].range = ddr_ram_size - ecc_res;
+			} else {
+				end = msmc_parent->R0[inst].start + msmc_parent->R0[inst].range;
+
+				if (end > (ddr_ram_size - ecc_res))
+					ddrss->ecc_regions[0].range = ddr_ram_size - ecc_res;
+				else
+					ddrss->ecc_regions[0].range = msmc_parent->R0[inst].range;
+
+				ddrss->ecc_regions[0].start =  msmc_parent->R0[inst].start;
+			}
+
+			kfree(msmc_parent);
+		}
 
 		k3_ddrss_lpddr4_ecc_init(ddrss);
 	}
-- 
2.34.1

