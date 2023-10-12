Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9E94CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 06:46:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D80086EA6;
	Thu, 12 Oct 2023 08:41:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF83E86E96; Thu, 12 Oct 2023 08:40:34 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B8CD86E6C
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 08:40:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=randolph@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 39C6cLdb020001;
 Thu, 12 Oct 2023 14:38:21 +0800 (+08)
 (envelope-from randolph@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0;
 Thu, 12 Oct 2023 14:38:17 +0800
From: Randolph <randolph@andestech.com>
To: <u-boot@lists.denx.de>
CC: <randolph.sklin@gmail.com>, <dylan@andestech.com>, <tim609@andestech.com>, 
 <peterlin@andestech.com>, Randolph <randolph@andestech.com>
Subject: [PATCH V2 7/7] riscv: spl: andes: Move the DTB in front of kernel
Date: Thu, 12 Oct 2023 14:35:09 +0800
Message-ID: <20231012063509.2963258-8-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012063509.2963258-1-randolph@andestech.com>
References: <20231012063509.2963258-1-randolph@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 39C6cLdb020001
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

Originally, u-boot SPL will place the DTB directly after the kernel,
but the size of the kernel does not include the BSS section, This
means that u-boot SPL places the DTB in the kernel BSS section causing
the DTB to be cleared by the kernel BSS initialisation.

Moving the DTB in front of the kernel can avoid this error.

Signed-off-by: Randolph <randolph@andestech.com>
---
 board/AndesTech/ae350/ae350.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/board/AndesTech/ae350/ae350.c b/board/AndesTech/ae350/ae350.c
index 1c2288b6ce..d78ee403e6 100644
--- a/board/AndesTech/ae350/ae350.c
+++ b/board/AndesTech/ae350/ae350.c
@@ -19,6 +19,8 @@
 #include <fdtdec.h>
 #include <dm.h>
 #include <spl.h>
+#include <mapmem.h>
+#include <hang.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -26,6 +28,29 @@ DECLARE_GLOBAL_DATA_PTR;
  * Miscellaneous platform dependent initializations
  */
 
+#if CONFIG_IS_ENABLED(LOAD_FIT) || CONFIG_IS_ENABLED(LOAD_FIT_FULL)
+#define ANDES_SPL_FDT_ADDR	(CONFIG_TEXT_BASE - 0x100000)
+void spl_perform_fixups(struct spl_image_info *spl_image)
+{
+	/*
+	 * Originally, u-boot-spl will place DTB directly after the kernel,
+	 * but the size of the kernel did not include the BSS section, which
+	 * means u-boot-spl will place the DTB in the kernel BSS section
+	 * causing the DTB to be cleared by kernel BSS initializtion.
+	 * Moving DTB in front of the kernel can avoid the error.
+	 */
+	if (ANDES_SPL_FDT_ADDR < 0) {
+		printf("%s: CONFIG_TEXT_BASE needs to be larger than 0x100000\n",
+		       __func__);
+		hang();
+	}
+
+	memcpy((void *)ANDES_SPL_FDT_ADDR, spl_image->fdt_addr,
+	       fdt_totalsize(spl_image->fdt_addr));
+	spl_image->fdt_addr = map_sysmem(ANDES_SPL_FDT_ADDR, 0);
+}
+#endif
+
 int board_init(void)
 {
 	gd->bd->bi_boot_params = PHYS_SDRAM_0 + 0x400;
-- 
2.34.1

