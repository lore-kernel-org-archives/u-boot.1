Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98AE3CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 05:38:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4362486E3D;
	Thu, 12 Oct 2023 07:38:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4E4F86E40; Thu, 12 Oct 2023 07:38:23 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9114586D3D
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 07:38:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=randolph@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 39C5cCEU074513;
 Thu, 12 Oct 2023 13:38:12 +0800 (+08)
 (envelope-from randolph@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0;
 Thu, 12 Oct 2023 13:38:08 +0800
From: Randolph <randolph@andestech.com>
To: <u-boot@lists.denx.de>
CC: <randolph.sklin@gmail.com>, <dylan@andestech.com>, <tim609@andestech.com>, 
 <peterlin@andestech.com>, Randolph <randolph@andestech.com>
Subject: [PATCH] riscv: andes: Rearrange Andes PLICSW to single-bit-per-hart
 strategy
Date: Thu, 12 Oct 2023 13:35:34 +0800
Message-ID: <20231012053534.2859887-1-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 39C5cCEU074513
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

Source hart information is not necessary in IPI, so we could
use single-bit-per-hart strategy to rearrange PLICSW mapping.

Bit 0 of Interrupt Pending Bits is hardwired to 0.
Therefore, we use bit 1 to send IPI to hart 0,
bit 2 to hart 1, ..., and so on.

Signed-off-by: Randolph <randolph@andestech.com>
---
 arch/riscv/lib/andes_plicsw.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/riscv/lib/andes_plicsw.c b/arch/riscv/lib/andes_plicsw.c
index 7518408089..6fd49e873b 100644
--- a/arch/riscv/lib/andes_plicsw.c
+++ b/arch/riscv/lib/andes_plicsw.c
@@ -22,7 +22,7 @@
 #include <linux/err.h>
 
 /* pending register */
-#define PENDING_REG(base, hart)	((ulong)(base) + 0x1000 + ((hart) / 4) * 4)
+#define PENDING_REG(base)	((ulong)(base) + 0x1000)
 /* enable register */
 #define ENABLE_REG(base, hart)	((ulong)(base) + 0x2000 + (hart) * 0x80)
 /* claim register */
@@ -30,10 +30,11 @@
 /* priority register */
 #define PRIORITY_REG(base)	((ulong)(base) + PLICSW_PRIORITY_BASE)
 
-#define ENABLE_HART_IPI         (0x01010101)
-#define SEND_IPI_TO_HART(hart)  (0x1 << (hart))
+/* Bit 0 of PLIC-SW pending array is hardwired to zero, so we start from bit 1 */
+#define FIRST_AVAILABLE_BIT	0x2
+#define SEND_IPI_TO_HART(hart)	(FIRST_AVAILABLE_BIT << (hart))
 #define PLICSW_PRIORITY_BASE        0x4
-#define PLICSW_INTERRUPT_PER_HART   0x8
+#define PLICSW_INTERRUPT_PER_HART   0x1
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -41,9 +42,8 @@ static int enable_ipi(int hart)
 {
 	unsigned int en;
 
-	en = ENABLE_HART_IPI << hart;
+	en = FIRST_AVAILABLE_BIT << hart;
 	writel(en, (void __iomem *)ENABLE_REG(gd->arch.plicsw, hart));
-	writel(en, (void __iomem *)ENABLE_REG(gd->arch.plicsw + 0x4, hart));
 
 	return 0;
 }
@@ -75,7 +75,7 @@ int riscv_init_ipi(void)
 	ret = uclass_find_first_device(UCLASS_CPU, &dev);
 	if (ret)
 		return ret;
-	else if (!dev)
+	if (!dev)
 		return -ENODEV;
 
 	ofnode_for_each_subnode(node, dev_ofnode(dev->parent)) {
@@ -105,10 +105,9 @@ int riscv_init_ipi(void)
 
 int riscv_send_ipi(int hart)
 {
-	unsigned int ipi = (SEND_IPI_TO_HART(hart) << (8 * gd->arch.boot_hart));
+	unsigned int ipi = SEND_IPI_TO_HART(hart);
 
-	writel(ipi, (void __iomem *)PENDING_REG(gd->arch.plicsw,
-				gd->arch.boot_hart));
+	writel(ipi, (void __iomem *)PENDING_REG(gd->arch.plicsw));
 
 	return 0;
 }
@@ -125,10 +124,9 @@ int riscv_clear_ipi(int hart)
 
 int riscv_get_ipi(int hart, int *pending)
 {
-	unsigned int ipi = (SEND_IPI_TO_HART(hart) << (8 * gd->arch.boot_hart));
+	unsigned int ipi = SEND_IPI_TO_HART(hart);
 
-	*pending = readl((void __iomem *)PENDING_REG(gd->arch.plicsw,
-						     gd->arch.boot_hart));
+	*pending = readl((void __iomem *)PENDING_REG(gd->arch.plicsw));
 	*pending = !!(*pending & ipi);
 
 	return 0;
-- 
2.34.1

