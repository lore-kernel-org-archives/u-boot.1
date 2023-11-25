Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8CA5C4167B
	for <u-boot@archiver.kernel.org>; Sat, 25 Nov 2023 16:27:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A1F887214;
	Sat, 25 Nov 2023 17:27:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="y+7U7Str";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34E8A870D9; Sat, 25 Nov 2023 17:27:18 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D735C87208
 for <u-boot@lists.denx.de>; Sat, 25 Nov 2023 17:27:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3APGR992082143;
 Sat, 25 Nov 2023 10:27:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700929629;
 bh=Zf2jElHQvVliGaDr5CmrWgiDI70VqgQtAYluDqFkwy4=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=y+7U7StreJP/WOZUTKW+WxO5tzlA2p38F2BIn0ea2U73ZbeAfdAwpqCbR5khDS3lB
 RDzm2ZhD2nfOjt0Xh18zg1+8A8hzyFuG57ynNuw1OUTmAYm2tyx6HHOtKJF40HEQ85
 JMcC69ou+VCN2dx2Q266t8QOsKuwk/2Zk6thR05U=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3APGR9Uu031283
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 25 Nov 2023 10:27:09 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 25
 Nov 2023 10:27:09 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 25 Nov 2023 10:27:09 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3APGR8iF008985;
 Sat, 25 Nov 2023 10:27:08 -0600
From: Devarsh Thakkar <devarsht@ti.com>
To: <u-boot@lists.denx.de>, <sjg@chromium.org>, <agust@denx.de>,
 <trini@konsulko.com>, <bmeng.cn@gmail.com>, <msuchanek@suse.de>,
 <rasmus.villemoes@prevas.dk>, <yangshiji66@outlook.com>
CC: <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <a-bhatia1@ti.com>,
 <j-luthra@ti.com>, <nsekhar@ti.com>, <n-jain1@ti.com>, <devarsht@ti.com>
Subject: [PATCH v4 2/8] arm: mach-k3: common: Reserve video memory from end of
 the RAM
Date: Sat, 25 Nov 2023 21:56:59 +0530
Message-ID: <20231125162705.1383401-3-devarsht@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231125162705.1383401-1-devarsht@ti.com>
References: <20231125162705.1383401-1-devarsht@ti.com>
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

Setup video memory before page table reservation using
"spl_reserve_video_from_ram_top" which ensures framebuffer memory gets
reserved from the end of RAM.

This is done to enable the next stage to directly skip the
pre-reserved area from previous stage right from the end of RAM without
having to make any gaps/holes to accommodate those regions which was the
case before as previous stage reserved region not from the end of RAM.

Use gd->ram_top instead of local ram_top and update gd->reloc_addr after
each reservation to ensure further regions are reserved properly.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
V2:
 - Make a generic function "spl_reserve_video" under
   common/spl which can be re-used by other platforms too
   for reserving video memory from spl.

V3:
 - Change spl_reserve_video to spl_reserve_video_from_ram_top
   which enforce framebuffer reservation from end of RAM
 - Use gd->ram_top instead of local ram_top and update
   gd->reloc_addr after each reservation
 - Print error message on framebuffer reservation

V4:
 - Split this into a separate patch
---
 arch/arm/mach-k3/common.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index fd400e7e3d..42ceeb5296 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -524,19 +524,26 @@ void remove_fwl_configs(struct fwl_data *fwl_data, size_t fwl_data_size)
 void spl_enable_cache(void)
 {
 #if !(defined(CONFIG_SYS_ICACHE_OFF) && defined(CONFIG_SYS_DCACHE_OFF))
-	phys_addr_t ram_top = CFG_SYS_SDRAM_BASE;
+	gd->ram_top = CFG_SYS_SDRAM_BASE;
+	int ret = 0;
 
 	dram_init();
 
 	/* reserve TLB table */
 	gd->arch.tlb_size = PGTABLE_SIZE;
 
-	ram_top += get_effective_memsize();
+	gd->ram_top += get_effective_memsize();
 	/* keep ram_top in the 32-bit address space */
-	if (ram_top >= 0x100000000)
-		ram_top = (phys_addr_t) 0x100000000;
+	if (gd->ram_top >= 0x100000000)
+		gd->ram_top = (phys_addr_t)0x100000000;
 
-	gd->arch.tlb_addr = ram_top - gd->arch.tlb_size;
+	gd->relocaddr = gd->ram_top;
+
+	ret = spl_reserve_video_from_ram_top();
+	if (ret)
+		panic("Failed to reserve framebuffer memory (%d)\n", ret);
+
+	gd->arch.tlb_addr = gd->relocaddr - gd->arch.tlb_size;
 	gd->arch.tlb_addr &= ~(0x10000 - 1);
 	debug("TLB table from %08lx to %08lx\n", gd->arch.tlb_addr,
 	      gd->arch.tlb_addr + gd->arch.tlb_size);
-- 
2.34.1

