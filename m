Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C31C197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 13:03:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE9DD874BA;
	Thu, 16 Nov 2023 14:02:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10599874BB; Thu, 16 Nov 2023 14:02:31 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44DB4874B7
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 14:02:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=randolph@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 3AGD237h001825;
 Thu, 16 Nov 2023 21:02:03 +0800 (+08)
 (envelope-from randolph@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Thu, 16 Nov 2023
 21:01:58 +0800
From: Randolph <randolph@andestech.com>
To: <u-boot@lists.denx.de>
CC: <randolph.sklin@gmail.com>, <dylan@andestech.com>, <tim609@andestech.com>, 
 <peterlin@andestech.com>, Randolph <randolph@andestech.com>
Subject: [PATCH V3 2/3] spl: riscv: falcon: move fdt blob to specified address
Date: Thu, 16 Nov 2023 21:01:35 +0800
Message-ID: <20231116130136.2796918-3-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231116130136.2796918-1-randolph@andestech.com>
References: <20231116130136.2796918-1-randolph@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.173]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 3AGD237h001825
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

In Falcon Boot mode, the fdt blob should be move to the RAM from
kernel BSS section. To avoid being cleared by BSS initialisation.
SPL_PAYLOAD_ARGS_ADDR is the address where SPL copies.

Signed-off-by: Randolph <randolph@andestech.com>
---
 board/AndesTech/ae350/ae350.c | 25 -------------------------
 common/spl/Kconfig            |  2 +-
 common/spl/spl_opensbi.c      | 16 ++++++++++++++++
 3 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/board/AndesTech/ae350/ae350.c b/board/AndesTech/ae350/ae350.c
index 772c6bf1ee..36375d9def 100644
--- a/board/AndesTech/ae350/ae350.c
+++ b/board/AndesTech/ae350/ae350.c
@@ -19,8 +19,6 @@
 #include <fdtdec.h>
 #include <dm.h>
 #include <spl.h>
-#include <mapmem.h>
-#include <hang.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -28,29 +26,6 @@ DECLARE_GLOBAL_DATA_PTR;
  * Miscellaneous platform dependent initializations
  */
 
-#if CONFIG_IS_ENABLED(LOAD_FIT) || CONFIG_IS_ENABLED(LOAD_FIT_FULL)
-#define ANDES_SPL_FDT_ADDR	(CONFIG_TEXT_BASE - 0x100000)
-void spl_perform_fixups(struct spl_image_info *spl_image)
-{
-	/*
-	 * Originally, u-boot-spl will place DTB directly after the kernel,
-	 * but the size of the kernel did not include the BSS section, which
-	 * means u-boot-spl will place the DTB in the kernel BSS section
-	 * causing the DTB to be cleared by kernel BSS initializtion.
-	 * Moving DTB in front of the kernel can avoid the error.
-	 */
-	if (ANDES_SPL_FDT_ADDR < 0) {
-		printf("%s: CONFIG_TEXT_BASE needs to be larger than 0x100000\n",
-		       __func__);
-		hang();
-	}
-
-	memcpy((void *)ANDES_SPL_FDT_ADDR, spl_image->fdt_addr,
-	       fdt_totalsize(spl_image->fdt_addr));
-	spl_image->fdt_addr = map_sysmem(ANDES_SPL_FDT_ADDR, 0);
-}
-#endif
-
 int board_init(void)
 {
 	gd->bd->bi_boot_params = PHYS_SDRAM_0 + 0x400;
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 25cd18afda..db279a588a 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1081,7 +1081,7 @@ config SPL_OS_BOOT
 
 config SPL_PAYLOAD_ARGS_ADDR
 	hex "Address in memory to load 'args' file for Falcon Mode to"
-	depends on SPL_OS_BOOT
+	depends on SPL_OS_BOOT || SPL_LOAD_FIT_OPENSBI_OS_BOOT
 	default 0x88000000 if ARCH_OMAP2PLUS
 	help
 	  Address in memory where the 'args' file, typically a device tree
diff --git a/common/spl/spl_opensbi.c b/common/spl/spl_opensbi.c
index 9801d38c0b..0a8ee9a7fc 100644
--- a/common/spl/spl_opensbi.c
+++ b/common/spl/spl_opensbi.c
@@ -16,6 +16,7 @@
 #include <opensbi.h>
 #include <linux/libfdt.h>
 #include <linux/printk.h>
+#include <mapmem.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -57,6 +58,21 @@ void __noreturn spl_invoke_opensbi(struct spl_image_info *spl_image)
 		hang();
 	}
 
+	/*
+	 * Originally, u-boot-spl will place DTB directly after the kernel,
+	 * but the size of the kernel did not include the BSS section, which
+	 * means u-boot-spl will place the DTB in the kernel BSS section
+	 * causing the DTB to be cleared by kernel BSS initializtion.
+	 * Moving DTB in front of the kernel can avoid the error.
+	 */
+	if (CONFIG_IS_ENABLED(LOAD_FIT_OPENSBI_OS_BOOT)) {
+		memcpy((void *)CONFIG_SPL_PAYLOAD_ARGS_ADDR,
+		       spl_image->fdt_addr,
+		       fdt_totalsize(spl_image->fdt_addr));
+		spl_image->fdt_addr =
+			map_sysmem(CONFIG_SPL_PAYLOAD_ARGS_ADDR, 0);
+	}
+
 	/*
 	 * Find next os image in /fit-images
 	 * The next os image default is u-boot proper, once enable
-- 
2.34.1

