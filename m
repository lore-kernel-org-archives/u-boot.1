Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D54AC02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 14:23:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AED28144F;
	Mon, 27 Jan 2025 15:22:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="m1mPkbAD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1FC281578; Mon, 27 Jan 2025 15:22:47 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3ACD815B7
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 15:22:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50REMhxX991419
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jan 2025 08:22:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1737987763;
 bh=r8PuKF8Rf7mLax+T65H9u4/Hhn8BftcxZST0KnK5Cp8=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=m1mPkbADZX16mvaVA9q5Vhc91EK6t7FXNxHOT6LR4sq9y/7z43t+oibX6gfcQGs/4
 3KktBisDoUzCrTDMMX4hn4qLJlZelRJUMEC2rSxOQg1X/kd6Gpbyx+nqEUNnmEE0PC
 Z59jZNDfdo2S3ht6VE0wNNTqb9nciIGfcTJV640M=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 50REMhk9056048
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 27 Jan 2025 08:22:43 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 27
 Jan 2025 08:22:43 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 27 Jan 2025 08:22:43 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50REMHfE071075;
 Mon, 27 Jan 2025 08:22:40 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <bb@ti.com>, <w.egorov@phytec.de>, <s-k6@ti.com>,
 <marek.vasut+renesas@mailbox.org>, <sabiya.d@ti.com>
CC: <u-kumar1@ti.com>, <n-francis@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH 8/8] ram: k3-ddrss: Add support for partial inline ECC in
 multi-DDR systems
Date: Mon, 27 Jan 2025 19:52:17 +0530
Message-ID: <20250127142217.1757300-9-n-francis@ti.com>
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

The existing approach does not account for interleaving in the DDRs when
setting up regions. There is support for MSMC to calculate the regions
for each DDR, so modify k3_ddrss_probe to set the regions accordingly
for multi-DDR systems.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 drivers/ram/k3-ddrss/k3-ddrss.c | 43 +++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
index 205dce51799..8429dddeb58 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss.c
+++ b/drivers/ram/k3-ddrss/k3-ddrss.c
@@ -808,8 +808,10 @@ static int k3_ddrss_probe(struct udevice *dev)
 	u64 end;
 	int ret;
 	struct k3_ddrss_desc *ddrss = dev_get_priv(dev);
+	__maybe_unused u32 inst, ddr_ram_size, ecc_res;
 	__maybe_unused struct k3_ddrss_data *ddrss_data = (struct k3_ddrss_data *)dev_get_driver_data(dev);
 	__maybe_unused struct k3_ddrss_ecc_region *range = &ddrss->ecc_range;
+	__maybe_unused struct k3_msmc *msmc_parent = NULL;
 
 	debug("%s(dev=%p)\n", __func__, dev);
 
@@ -863,14 +865,51 @@ static int k3_ddrss_probe(struct udevice *dev)
 			ddrss->ecc_range.range = range->range;
 		}
 
+#if !CONFIG_IS_ENABLED(K3_MULTI_DDR)
 		end = ddrss->ecc_range.start + ddrss->ecc_range.range;
+		inst = ddrss->instance;
+		ddr_ram_size = ddrss->ddr_ram_size;
+		ecc_res = ddrss->ecc_reserved_space;
 
-		if (end > (ddrss->ddr_ram_size - ddrss->ecc_reserved_space))
-			ddrss->ecc_regions[0].range = ddrss->ddr_ram_size - ddrss->ecc_reserved_space;
+		if (end > (ddr_ram_size - ecc_res))
+			ddrss->ecc_regions[0].range = ddr_ram_size - ecc_res;
 		else
 			ddrss->ecc_regions[0].range = ddrss->ecc_range.range;
 
 		ddrss->ecc_regions[0].start = ddrss->ecc_range.start - ddrss->ddr_bank_base[0];
+#else
+
+		/* In case multi-DDR, we rely on MSMC's calculation of regions for each DDR */
+		msmc_parent = kzalloc(sizeof(msmc_parent), GFP_KERNEL);
+		if (!msmc_parent) {
+			debug("%s: failed to allocate msmc_parent\n", __func__);
+			return -ENOMEM;
+		}
+		msmc_parent = dev_get_priv(dev->parent);
+		if (!msmc_parent) {
+			printf("%s: could not get MSMC parent to set up inline ECC regions\n",
+			       __func__);
+			kfree(msmc_parent);
+			return -EINVAL;
+		}
+
+		if (msmc_parent->R0[0].start < 0) {
+			/* Configure entire DDR space by default */
+			ddrss->ecc_regions[0].start = ddrss->ddr_bank_base[0];
+			ddrss->ecc_regions[0].range = ddr_ram_size - ecc_res;
+		} else {
+			end = msmc_parent->R0[inst].start + msmc_parent->R0[inst].range;
+
+			if (end > (ddr_ram_size - ecc_res))
+				ddrss->ecc_regions[0].range = ddr_ram_size - ecc_res;
+			else
+				ddrss->ecc_regions[0].range = msmc_parent->R0[inst].range;
+
+			ddrss->ecc_regions[0].start =  msmc_parent->R0[inst].start;
+		}
+
+		kfree(msmc_parent);
+#endif
 
 		k3_ddrss_lpddr4_ecc_init(ddrss);
 	}
-- 
2.34.1

