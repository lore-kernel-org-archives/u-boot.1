Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6BBCA0EC4
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 12:43:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B0EA83323;
	Tue, 12 Aug 2025 14:43:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="P3EaMKIs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 693F88312A; Tue, 12 Aug 2025 14:43:38 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C619B8331C
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 14:43:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57CChWjj1826412;
 Tue, 12 Aug 2025 07:43:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1755002612;
 bh=XRRBr5pX50YpAxu95glm6o1rcnqzMG4lpdVxtQ0iBj0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=P3EaMKIsjqCgIAYMGyyupFD0HvmiD4TtPVqkIPwOnlb2Dmc8/3AlAKv66w60oL42R
 iTp9SVm6WQSwDVcTTsYouleOBDSYNVThayRIPeYiAvBZpSR/ijooeJAYDaplALbpUb
 4XJ+7XB6G1R+fCFXMlGds5SHQWd+F1DvVDJ6esoY=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57CChWq93814334
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 12 Aug 2025 07:43:32 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 12
 Aug 2025 07:43:31 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 12 Aug 2025 07:43:31 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.235.200])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57CChPlA653236;
 Tue, 12 Aug 2025 07:43:29 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <bb@ti.com>, <w.egorov@phytec.de>, <s-k6@ti.com>,
 <marek.vasut+renesas@mailbox.org>, <sabiya.d@ti.com>
CC: <u-kumar1@ti.com>, <n-francis@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v3 1/9] ram: k3-ddrss: Use DDR address instead of system
 address for ecc_regions
Date: Tue, 12 Aug 2025 18:13:16 +0530
Message-ID: <20250812124324.124306-2-n-francis@ti.com>
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

Let ecc_regions[x].start reflect the start of the ECC region in terms of
DDR addressing rather than system addressing. This will make it easier
to extend the usage of the same ecc_regions structure for multi-DDR
systems as well.

Reviewed-by: Udit Kumar <u-kumar1@ti.com>
Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
No change since v2

 drivers/ram/k3-ddrss/k3-ddrss.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
index 6590d57ad84..7389fd8b82f 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss.c
+++ b/drivers/ram/k3-ddrss/k3-ddrss.c
@@ -752,7 +752,7 @@ static void k3_ddrss_lpddr4_ecc_init(struct k3_ddrss_desc *ddrss)
 	u32 val;
 
 	/* Only Program region 0 which covers full ddr space */
-	k3_ddrss_set_ecc_range_r0(base, ecc_region_start - ddrss->ddr_bank_base[0], ecc_range);
+	k3_ddrss_set_ecc_range_r0(base, ecc_region_start, ecc_range);
 
 	/* Enable ECC, RMW, WR_ALLOC */
 	writel(DDRSS_ECC_CTRL_REG_ECC_EN | DDRSS_ECC_CTRL_REG_RMW_EN |
@@ -817,7 +817,7 @@ static int k3_ddrss_probe(struct udevice *dev)
 		k3_ddrss_lpddr4_ecc_calc_reserved_mem(ddrss);
 
 		/* Always configure one region that covers full DDR space */
-		ddrss->ecc_regions[0].start = ddrss->ddr_bank_base[0];
+		ddrss->ecc_regions[0].start = 0;
 		ddrss->ecc_regions[0].range = ddrss->ddr_ram_size - ddrss->ecc_reserved_space;
 		k3_ddrss_lpddr4_ecc_init(ddrss);
 	}
-- 
2.34.1

