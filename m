Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17358C67861
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 08:37:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F9BC884D3;
	Fri,  5 Apr 2024 10:37:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=socionext.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16F9E884D6; Fri,  5 Apr 2024 10:37:28 +0200 (CEST)
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
 by phobos.denx.de (Postfix) with ESMTP id A6E45884D0
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 10:37:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=socionext.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hayashi.kunihiko@socionext.com
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
 by mx.socionext.com with ESMTP; 05 Apr 2024 17:37:22 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
 by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 565002059027;
 Fri,  5 Apr 2024 17:37:22 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with
 ESMTP; Fri, 5 Apr 2024 17:37:22 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
 by kinkan2.css.socionext.com (Postfix) with ESMTP id EDA90B62AB;
 Fri,  5 Apr 2024 17:37:21 +0900 (JST)
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Dai Okamura <okamura.dai@socionext.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH] ARM: uniphier: Move uniphier_mem_map_init() call into
 dram_init()
Date: Fri,  5 Apr 2024 17:37:15 +0900
Message-Id: <20240405083715.2593568-1-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
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

The function uniphier_mem_map_init() is to change global variable
'mem_map', which is referenced to get_page_table_size() to calculate
the size of page table.

However, uniphier_mem_map_init() is called after get_page_table_size(),
so the size of page table and 'mem_map' become inconsist each other.
After all, U-Boot fails to boot on chip with memory map different from
default map,

uniphier_mem_map_init() should be moved to dram_init(), which is
called before get_page_table_size().

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm/mach-uniphier/dram_init.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-uniphier/dram_init.c b/arch/arm/mach-uniphier/dram_init.c
index 7f2753190c23..e6f1286e71fd 100644
--- a/arch/arm/mach-uniphier/dram_init.c
+++ b/arch/arm/mach-uniphier/dram_init.c
@@ -265,14 +265,15 @@ int dram_init(void)
 	if (uniphier_get_soc_id() == UNIPHIER_LD20_ID)
 		gd->ram_size -= 64;
 
+	/* map all the DRAM regions */
+	uniphier_mem_map_init(gd->ram_base, prev_top - gd->ram_base);
+
 	return 0;
 }
 
 int dram_init_banksize(void)
 {
 	struct uniphier_dram_map dram_map[3] = {};
-	unsigned long base, top;
-	bool valid_bank_found = false;
 	int ret, i;
 
 	ret = uniphier_dram_map_get(dram_map);
@@ -287,18 +288,7 @@ int dram_init_banksize(void)
 
 		if (!dram_map[i].size)
 			continue;
-
-		if (!valid_bank_found)
-			base = dram_map[i].base;
-		top = dram_map[i].base + dram_map[i].size;
-		valid_bank_found = true;
 	}
 
-	if (!valid_bank_found)
-		return -EINVAL;
-
-	/* map all the DRAM regions */
-	uniphier_mem_map_init(base, top - base);
-
 	return 0;
 }
-- 
2.25.1

