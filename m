Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F19C54E41
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 06:10:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9118287D33;
	Wed,  6 Mar 2024 07:10:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 828B087D7E; Wed,  6 Mar 2024 07:10:52 +0100 (CET)
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
 by phobos.denx.de (Postfix) with ESMTP id 035B887BFD
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 07:10:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kojima.masahisa@socionext.com
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
 by mx.socionext.com with ESMTP; 06 Mar 2024 15:10:45 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
 by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id E7D0D2059027;
 Wed,  6 Mar 2024 15:10:45 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with
 ESMTP; Wed, 6 Mar 2024 15:10:45 +0900
Received: from ubuntu-FMVS04001.e01.socionext.com (unknown [10.213.110.223])
 by kinkan2.css.socionext.com (Postfix) with ESMTP id D0EDBB62AB;
 Wed,  6 Mar 2024 15:10:45 +0900 (JST)
From: Masahisa Kojima <kojima.masahisa@socionext.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH] board: developerbox: fix mem_map setup timing
Date: Wed,  6 Mar 2024 15:11:10 +0900
Message-Id: <20240306061110.2514611-1-kojima.masahisa@socionext.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The setup of global variable mem_map was moved into enable_caches()
by commit a70c75cabae1 ("board: developerbox: move mem_map setup later")
since U-Boot was directly booted from NOR flash in XIP
and bss is not yet available in dram_init() at that time.
This has a problem, mem_map variable is used by
the get_page_table_size() to calculate the page table size,
but get_page_table_size() is called earlier than enable_caches()
which fills mem_map variable. With that, U-Boot fails to boot when
64GB DIMM is installed.

Currently U-Boot on the Developerbox board is not booted in XIP
and bss is available in dram_init(), let's move mem_map setup
in dram_init().

Signed-off-by: Masahisa Kojima <kojima.masahisa@socionext.com>
---
 board/socionext/developerbox/developerbox.c | 60 ++++++++-------------
 1 file changed, 21 insertions(+), 39 deletions(-)

diff --git a/board/socionext/developerbox/developerbox.c b/board/socionext/developerbox/developerbox.c
index ac4415ff3b..062e4a7b79 100644
--- a/board/socionext/developerbox/developerbox.c
+++ b/board/socionext/developerbox/developerbox.c
@@ -125,10 +125,29 @@ int dram_init(void)
 	struct draminfo *synquacer_draminfo = (void *)SQ_DRAMINFO_BASE;
 	struct draminfo_entry *ent = synquacer_draminfo->entry;
 	unsigned long size = 0;
-	int i;
+	struct mm_region *mr;
+	int i, ri;
+
+	if (synquacer_draminfo->nr_regions < 1) {
+		log_err("Failed to get correct DRAM information\n");
+		return -EINVAL;
+	}
 
-	for (i = 0; i < synquacer_draminfo->nr_regions; i++)
+	for (i = 0; i < synquacer_draminfo->nr_regions; i++) {
+		if (i >= MAX_DDR_REGIONS)
+			break;
+
+		ri = DDR_REGION_INDEX(i);
+		mem_map[ri].phys = ent[i].base;
+		mem_map[ri].size = ent[i].size;
+		mem_map[ri].virt = mem_map[ri].phys;
 		size += ent[i].size;
+		if (i == 0)
+			continue;
+
+		mr = &mem_map[DDR_REGION_INDEX(0)];
+		mem_map[ri].attrs = mr->attrs;
+	}
 
 	gd->ram_size = size;
 	gd->ram_base = ent[0].base;
@@ -162,43 +181,6 @@ int dram_init_banksize(void)
 	return 0;
 }
 
-void build_mem_map(void)
-{
-	struct draminfo *synquacer_draminfo = (void *)SQ_DRAMINFO_BASE;
-	struct draminfo_entry *ent = synquacer_draminfo->entry;
-	struct mm_region *mr;
-	int i, ri;
-
-	if (synquacer_draminfo->nr_regions < 1) {
-		log_err("Failed to get correct DRAM information\n");
-		return;
-	}
-
-	/* Update memory region maps */
-	for (i = 0; i < synquacer_draminfo->nr_regions; i++) {
-		if (i >= MAX_DDR_REGIONS)
-			break;
-
-		ri = DDR_REGION_INDEX(i);
-		mem_map[ri].phys = ent[i].base;
-		mem_map[ri].size = ent[i].size;
-		mem_map[ri].virt = mem_map[ri].phys;
-		if (i == 0)
-			continue;
-
-		mr = &mem_map[DDR_REGION_INDEX(0)];
-		mem_map[ri].attrs = mr->attrs;
-	}
-}
-
-void enable_caches(void)
-{
-	build_mem_map();
-
-	icache_enable();
-	dcache_enable();
-}
-
 int print_cpuinfo(void)
 {
 	printf("CPU:   SC2A11:Cortex-A53 MPCore 24cores\n");
-- 
2.34.1

