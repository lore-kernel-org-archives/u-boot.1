Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16441C77B7C
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 13:36:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3942382F14;
	Thu,  3 Jul 2025 15:36:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pCUeb2us";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7ECD482F00; Thu,  3 Jul 2025 15:36:27 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43A9282063
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 15:36:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 563DaNjQ038439;
 Thu, 3 Jul 2025 08:36:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1751549783;
 bh=Du6GWAKt8ZMY6PGnELlDu7QicFbEU+kW9VEXz8RFwkU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=pCUeb2usXhZvOaplEtZFujHOcFeuU7K5JODoDyYxoEksbmmznEfDAhR7Kwti0bKDR
 iIVcNbqolEPiuCn/H3BCnBWdhjD8iu4d9Yx/BFHVUaIoPBAnVVT/p61v4nv/mJzmi6
 kz2pbwSeTeQ9uWBFsMoyEX49h3viYGIJa8uqiiRo=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 563DaNAc777779
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 3 Jul 2025 08:36:23 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 3
 Jul 2025 08:36:22 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 3 Jul 2025 08:36:22 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 563DaL4s912285;
 Thu, 3 Jul 2025 08:36:22 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <nm@ti.com>, <robertcnelson@gmail.com>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>,
 <m-chawdhry@ti.com>, <a-nandan@ti.com>, <afd@ti.com>, <bb@ti.com>,
 <u-kumar1@ti.com>, <devarsht@ti.com>
Subject: [PATCH v5 3/4] mach-k3: add dynamic mmu fixups for SPL stage
Date: Thu, 3 Jul 2025 19:05:28 +0530
Message-ID: <20250703133533.104758-4-anshuld@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703133533.104758-1-anshuld@ti.com>
References: <20250703133533.104758-1-anshuld@ti.com>
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

On platforms with spl splash support such as 62p and 62x
(CONFIG_VIDEO=y), the top of DDR is reserved for the framebuffer.

The size of the framebuffer is computed at runtime by video_reserve.
During the MMU configuration an entry corresponding to the framebuffer
should be dynamically created to properly allocate the required space
for the framebuffer.

Therefore this patch adds k3_spl_mem_map_init which adds the required
MMU entry by querying the gd after the framebuffer size has been
computed in spl_reserve_video_from_ram_top.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/mach-k3/arm64/arm64-mmu.c | 13 ++++++++++++-
 arch/arm/mach-k3/common.c          | 17 ++++++++++++++---
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-k3/arm64/arm64-mmu.c b/arch/arm/mach-k3/arm64/arm64-mmu.c
index 49dd6fcb23b..b1b287f2114 100644
--- a/arch/arm/mach-k3/arm64/arm64-mmu.c
+++ b/arch/arm/mach-k3/arm64/arm64-mmu.c
@@ -131,6 +131,13 @@ static int k3_setup_extra_mem_banks(unsigned int *map_idx)
 	return 0;
 }
 
+static void k3_spl_mem_map_init(unsigned int *map_idx)
+{
+	if (CONFIG_IS_ENABLED(VIDEO))
+		k3_mmu_add_cachable_entry(gd_video_bottom(), gd_video_top(),
+					  map_idx);
+}
+
 static int k3_uboot_mem_map_init(unsigned int *map_idx)
 {
 	int ret;
@@ -159,7 +166,11 @@ int k3_mem_map_init(void)
 
 	map_idx++;
 
-	ret = k3_uboot_mem_map_init(&map_idx);
+	if (xpl_phase() == PHASE_SPL)
+		k3_spl_mem_map_init(&map_idx);
+	else
+		ret = k3_uboot_mem_map_init(&map_idx);
+
 	if (ret)
 		return ret;
 
diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index fc230f180d0..e72413b9803 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -32,6 +32,7 @@
 #include <dm/device-internal.h>
 
 #include <asm/arch/k3-qos.h>
+#include <mach/k3-ddr.h>
 
 struct ti_sci_handle *get_ti_sci_handle(void)
 {
@@ -224,16 +225,26 @@ void spl_enable_cache(void)
 
 	dram_init();
 
-	/* reserve TLB table */
-	gd->arch.tlb_size = PGTABLE_SIZE;
-
 	gd->ram_top += get_effective_memsize();
+	/* keep ram_top in the 32-bit address space */
+	if (gd->ram_top >= 0x100000000)
+		gd->ram_top = (phys_addr_t)0x100000000;
+
 	gd->relocaddr = gd->ram_top;
 
 	ret = spl_reserve_video_from_ram_top();
 	if (ret)
 		panic("Failed to reserve framebuffer memory (%d)\n", ret);
 
+	if (IS_ENABLED(CONFIG_ARM64)) {
+		ret = k3_mem_map_init();
+		if (ret)
+			panic("Failed to setup MMU table (%d)\n", ret);
+	}
+
+	/* reserve TLB table */
+	gd->arch.tlb_size = PGTABLE_SIZE;
+
 	gd->arch.tlb_addr = gd->relocaddr - gd->arch.tlb_size;
 	gd->arch.tlb_addr &= ~(0x10000 - 1);
 	debug("TLB table from %08lx to %08lx\n", gd->arch.tlb_addr,
-- 
2.49.0

