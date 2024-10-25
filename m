Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97CF9D149EE
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 20:16:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7F91890A8;
	Fri, 25 Oct 2024 22:14:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D28D89024; Fri, 25 Oct 2024 19:19:04 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 3D9DA89017
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 19:18:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=leo.yan@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5773B1424;
 Fri, 25 Oct 2024 10:19:19 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 900723F71E;
 Fri, 25 Oct 2024 10:18:48 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Tom Rini <trini@konsulko.com>, Usama Arif <usama.arif@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Boyan Karatotev <boyan.karatotev@arm.com>,
 Jackson Cooper-Driver <jackson.cooper-driver@arm.com>, u-boot@lists.denx.de
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 8/8] arm: total_compute: Update memory mapping info
Date: Fri, 25 Oct 2024 18:18:21 +0100
Message-Id: <20241025171821.624702-9-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025171821.624702-1-leo.yan@arm.com>
References: <20241025171821.624702-1-leo.yan@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 25 Oct 2024 22:14:52 +0200
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

This commit introduces build_mem_map() function for updating the mem_map
structure with copying info from gd->bd->bi_dram, so that it can keep
the consistence for DRAM info passed via DT.

The page table size is calculated prior to mem_map is ready, introduce
the get_page_table_size() function for a predefined table size.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 board/armltd/total_compute/total_compute.c | 44 +++++++++++++++++-----
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/board/armltd/total_compute/total_compute.c b/board/armltd/total_compute/total_compute.c
index 02bb648ce7..4101816317 100644
--- a/board/armltd/total_compute/total_compute.c
+++ b/board/armltd/total_compute/total_compute.c
@@ -14,7 +14,10 @@
 #include <asm/global_data.h>
 #include <asm/system.h>
 
-static struct mm_region total_compute_mem_map[] = {
+/* +1 is end of list which needs to be empty */
+#define TC_MEM_MAP_MAX		(1 + CONFIG_NR_DRAM_BANKS + 1)
+
+static struct mm_region total_compute_mem_map[TC_MEM_MAP_MAX] = {
 	{
 		.virt = 0x0UL,
 		.phys = 0x0UL,
@@ -22,15 +25,6 @@ static struct mm_region total_compute_mem_map[] = {
 		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
 			 PTE_BLOCK_NON_SHARE |
 			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		.virt = 0x80000000UL,
-		.phys = 0x80000000UL,
-		.size = 0xff80000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
-			 PTE_BLOCK_INNER_SHARE
-	}, {
-		/* List terminator */
-		0,
 	}
 };
 
@@ -89,6 +83,36 @@ int dram_init_banksize(void)
 	return fdtdec_setup_memory_banksize();
 }
 
+void build_mem_map(void)
+{
+	int i;
+
+	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
+		/*
+		 * The first node is for I/O device, start from node 1 for
+		 * updating DRAM info.
+		 */
+		mem_map[i + 1].virt = gd->bd->bi_dram[i].start;
+		mem_map[i + 1].phys = gd->bd->bi_dram[i].start;
+		mem_map[i + 1].size = gd->bd->bi_dram[i].size;
+		mem_map[i + 1].attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+				       PTE_BLOCK_INNER_SHARE;
+	}
+}
+
+void enable_caches(void)
+{
+	build_mem_map();
+
+	icache_enable();
+	dcache_enable();
+}
+
+u64 get_page_table_size(void)
+{
+	return SZ_256K;
+}
+
 /* Nothing to be done here as handled by PSCI interface */
 void reset_cpu(void)
 {
-- 
2.34.1

