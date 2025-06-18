Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF71BC7115A
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 12:43:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D278882CCE;
	Wed, 18 Jun 2025 14:43:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="g8COSclP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF6AB82B20; Wed, 18 Jun 2025 14:43:29 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82E7582C55
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 14:43:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55IChPDr242073;
 Wed, 18 Jun 2025 07:43:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1750250605;
 bh=3vvCvgj2YoKO/dJcxyfzqbJTlz7AQQMkSZ2U7QNV4/8=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=g8COSclPkZwEQHtFmZR4I+EzuSYOponPgr8Y4yoSyyQVyXp/YjABf8EWsW7Eoe/nB
 G8NUZGoGywBI7uoFkYvSzTn2U7Jz3oD5WZSwQOrNrSfKaoR370Rq8SdBJCpzzLtOVQ
 3rEO5pqN+M3cNbT+WOXP14OVTvM4LZUSTqRquZXU=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55IChPEI2924992
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 18 Jun 2025 07:43:25 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 18
 Jun 2025 07:43:24 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 18 Jun 2025 07:43:24 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55IChO7Q3485052;
 Wed, 18 Jun 2025 07:43:24 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <nm@ti.com>, <bb@ti.com>, <u-kumar1@ti.com>,
 <devarsht@ti.com>, <robertcnelson@gmail.com>
Subject: [PATCH v4 2/2] mach-k3: add dynamic mmu fixups for SPL stage
Date: Wed, 18 Jun 2025 18:12:09 +0530
Message-ID: <20250618124210.1936140-2-anshuld@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250618124210.1936140-1-anshuld@ti.com>
References: <20250618124210.1936140-1-anshuld@ti.com>
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

On platforms with spl splash support i.e CONFIG_VIDEO=y, the top of DDR
is reserved for the framebuffer.

The size for the framebuffer is computed at runtime by video_reserve.
During the MMU configuration an entry corresponding to the framebuffer
should be dynamically created to properly map the required space for the
framebuffer.

Therefore this patch adds k3_spl_mem_map_init which adds the required
MMU entry by querying the gd after the framebuffer size has been
computed in spl_reserve_video_from_ram_top.

For non VIDEO=y platforms, the added k3_spl_mem_map_init function gets
optimized out of the final binary so overall, the spl size is not
impacted[1].

[1]: Tested on clang 19.1.7 and gcc 15.1.1

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/mach-k3/arm64/arm64-mmu.c     | 44 ++++++++++++++++++++++++++
 arch/arm/mach-k3/common.c              | 13 ++++++--
 arch/arm/mach-k3/include/mach/k3-ddr.h |  3 ++
 3 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-k3/arm64/arm64-mmu.c b/arch/arm/mach-k3/arm64/arm64-mmu.c
index 135f842556d..0d9b4d062bf 100644
--- a/arch/arm/mach-k3/arm64/arm64-mmu.c
+++ b/arch/arm/mach-k3/arm64/arm64-mmu.c
@@ -49,6 +49,10 @@ struct mm_region k3_mem_map[K3_MMU_REGIONS_COUNT] = {
 		.size = SZ_128M,
 		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
 			 PTE_BLOCK_INNER_SHARE
+	}, {
+		/* Framebuffer reserved, size set at runtime */
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE
 	}, {
 		/* List terminator */
 		0,
@@ -57,6 +61,46 @@ struct mm_region k3_mem_map[K3_MMU_REGIONS_COUNT] = {
 
 struct mm_region *mem_map = k3_mem_map;
 
+int k3_spl_mem_map_init(void)
+{
+	unsigned int i;
+	int k3_map_idx = -EINVAL;
+
+	for (i = 0; i < K3_MMU_REGIONS_COUNT; i++) {
+		if (k3_mem_map[i].virt == 0 && k3_mem_map[i].phys == 0 &&
+		    k3_mem_map[i].size == 0) {
+			k3_map_idx = i;
+			break;
+		}
+	}
+
+	if (k3_map_idx == -EINVAL) {
+		pr_err("%s: Failed to find fixup region in MMU memory map\n",
+		       __func__);
+		return -EINVAL;
+	}
+
+	if (k3_map_idx >= K3_MMU_REGIONS_COUNT - 1) {
+		pr_err("%s: Not enough space in MMU map for the added entry\n",
+		       __func__);
+		return -ENOMEM;
+	}
+
+	if (CONFIG_IS_ENABLED(VIDEO)) {
+		k3_mem_map[k3_map_idx].virt = gd_video_bottom();
+		k3_mem_map[k3_map_idx].phys = gd_video_bottom();
+		k3_mem_map[k3_map_idx].size =
+			gd_video_top() - gd_video_bottom();
+		k3_mem_map[k3_map_idx].attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+					       PTE_BLOCK_INNER_SHARE;
+		k3_map_idx++;
+	}
+
+	k3_mem_map[k3_map_idx] = (const struct mm_region){ 0 };
+
+	return 0;
+}
+
 static int dt_reserved_cmp(const void *a, const void *b)
 {
 	const struct fdt_resource *val_a = a, *val_b = b;
diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index fc230f180d0..198ab4e85fe 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -15,6 +15,7 @@
 #include <asm/global_data.h>
 #include <linux/printk.h>
 #include "common.h"
+#include "mach/k3-ddr.h"
 #include <dm.h>
 #include <remoteproc.h>
 #include <asm/cache.h>
@@ -224,9 +225,6 @@ void spl_enable_cache(void)
 
 	dram_init();
 
-	/* reserve TLB table */
-	gd->arch.tlb_size = PGTABLE_SIZE;
-
 	gd->ram_top += get_effective_memsize();
 	gd->relocaddr = gd->ram_top;
 
@@ -234,6 +232,15 @@ void spl_enable_cache(void)
 	if (ret)
 		panic("Failed to reserve framebuffer memory (%d)\n", ret);
 
+	if (IS_ENABLED(CONFIG_ARM64)) {
+		ret = k3_spl_mem_map_init();
+		if (ret)
+			panic("Failed to perform MMU fixups: %d\n", ret);
+	}
+
+	/* reserve TLB table */
+	gd->arch.tlb_size = PGTABLE_SIZE;
+
 	gd->arch.tlb_addr = gd->relocaddr - gd->arch.tlb_size;
 	gd->arch.tlb_addr &= ~(0x10000 - 1);
 	debug("TLB table from %08lx to %08lx\n", gd->arch.tlb_addr,
diff --git a/arch/arm/mach-k3/include/mach/k3-ddr.h b/arch/arm/mach-k3/include/mach/k3-ddr.h
index 0b164ebf5e6..375a1a85945 100644
--- a/arch/arm/mach-k3/include/mach/k3-ddr.h
+++ b/arch/arm/mach-k3/include/mach/k3-ddr.h
@@ -17,6 +17,9 @@ int dram_init_banksize(void);
 void fixup_ddr_driver_for_ecc(struct spl_image_info *spl_image);
 void fixup_memory_node(struct spl_image_info *spl_image);
 
+/* Performs MMU memory map fixups at SPL stage */
+int k3_spl_mem_map_init(void);
+
 /*
  * Modifies the MMU memory map based on DDR size and reserved-memory
  * nodes in DT
-- 
2.49.0

