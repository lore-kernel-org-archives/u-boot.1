Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C11C2C4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 15:29:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 026358780B;
	Fri, 10 Nov 2023 16:29:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="sNGBCdaJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D7B3877FF; Fri, 10 Nov 2023 16:29:54 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B6B0877FF
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 16:29:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AAFTlcM105968;
 Fri, 10 Nov 2023 09:29:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699630187;
 bh=5YSuGu8h0pN+f+GRn029Js8/r3zBkXmAwlOoyR03Xxw=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=sNGBCdaJGcLRlt64Mm/3Hx7Vrqliyxaa90otdLWwp64w0bK+nQttwE9AqcO1AYMaW
 G2rybr3UswbfL/LpsDQcsLpOXbgOv/RXv7gI/NakjBKy32S+6lXUO49iKrAKtPL9BM
 xSYFh1g7osIburYpTBV6sKtPy0fJY3c+hywtoNyU=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AAFTlUN016938
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 10 Nov 2023 09:29:47 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 10
 Nov 2023 09:29:47 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 10 Nov 2023 09:29:47 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AAFTkRI075081;
 Fri, 10 Nov 2023 09:29:47 -0600
From: Devarsh Thakkar <devarsht@ti.com>
To: <u-boot@lists.denx.de>, <sjg@chromium.org>, <agust@denx.de>,
 <trini@konsulko.com>, <bmeng.cn@gmail.com>, <msuchanek@suse.de>,
 <rasmus.villemoes@prevas.dk>, <yangshiji66@outlook.com>
CC: <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <a-bhatia1@ti.com>,
 <j-luthra@ti.com>, <nsekhar@ti.com>, <n-jain1@ti.com>, <devarsht@ti.com>
Subject: [PATCH v2 1/6] arm: mach-k3: common: Reserve video memory from end of
 the RAM
Date: Fri, 10 Nov 2023 20:59:39 +0530
Message-ID: <20231110152944.647535-2-devarsht@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231110152944.647535-1-devarsht@ti.com>
References: <20231110152944.647535-1-devarsht@ti.com>
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

Add function spl_reserve_video which is a wrapper
around video_reserve to setup video memory and update
the relocation address pointer.

Setup video memory before page table reservation so that
framebuffer memory gets reserved from the end of RAM.

This is as per the new policy being discussed for passing
blobs where each of the reserved areas for bloblists
to be passed need to be reserved at the end of RAM.

This is done to enable the next stage to directly skip
the pre-reserved area from previous stage right from the end of RAM
without having to make any gaps/holes to accommodate those
regions which was the case before as previous stage
reserved region not from the end of RAM.

Suggested-by: Simon Glass <sjg@chromium.org>
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
---
 arch/arm/mach-k3/common.c | 17 ++++++++++++-----
 common/spl/spl.c          | 27 +++++++++++++++++++++++++++
 include/spl.h             |  6 ++++++
 3 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index c3006ba387..6590045140 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -525,19 +525,26 @@ void remove_fwl_configs(struct fwl_data *fwl_data, size_t fwl_data_size)
 void spl_enable_dcache(void)
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
+		pr_err("ERROR: Failed to framebuffer memory in SPL\n");
+
+	gd->arch.tlb_addr = gd->relocaddr - gd->arch.tlb_size;
 	gd->arch.tlb_addr &= ~(0x10000 - 1);
 	debug("TLB table from %08lx to %08lx\n", gd->arch.tlb_addr,
 	      gd->arch.tlb_addr + gd->arch.tlb_size);
diff --git a/common/spl/spl.c b/common/spl/spl.c
index 732d90d39e..452bf303de 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -41,6 +41,7 @@
 #include <fdt_support.h>
 #include <bootcount.h>
 #include <wdt.h>
+#include <video.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 DECLARE_BINMAN_MAGIC_SYM;
@@ -151,6 +152,32 @@ void spl_fixup_fdt(void *fdt_blob)
 #endif
 }
 
+/*
+ * Reserve video memory for SPL splash screen from
+ * end of RAM
+ *
+ * RETURN
+ * 0 : On success
+ * Non-zero : On failure
+ */
+int spl_reserve_video_from_ram_top(void)
+{
+	if (CONFIG_IS_ENABLED(VIDEO)) {
+		ulong addr;
+		int ret;
+
+		addr = gd->ram_top;
+		ret = video_reserve(&addr);
+		if (ret)
+			return ret;
+		debug("Reserving %luk for video at: %08lx\n",
+		      ((unsigned long)gd->relocaddr - addr) >> 10, addr);
+		gd->relocaddr = addr;
+	}
+
+	return 0;
+}
+
 ulong spl_get_image_pos(void)
 {
 	if (!CONFIG_IS_ENABLED(BINMAN_UBOOT_SYMBOLS))
diff --git a/include/spl.h b/include/spl.h
index 0d49e4a454..39f2a7581d 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -825,6 +825,12 @@ int spl_usb_load(struct spl_image_info *spl_image,
 
 int spl_ymodem_load_image(struct spl_image_info *spl_image,
 			  struct spl_boot_device *bootdev);
+/**
+ * spl_reserve_video_from_ram_top() - Reserve framebuffer memory from end of RAM
+ *
+ * Return: 0 on success, otherwise error code
+ */
+int spl_reserve_video_from_ram_top(void);
 
 /**
  * spl_invoke_atf - boot using an ARM trusted firmware image
-- 
2.34.1

