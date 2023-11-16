Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6059BC54FB9
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 12:49:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47E4087465;
	Thu, 16 Nov 2023 13:49:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 971648748D; Thu, 16 Nov 2023 13:49:32 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3706087479
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 13:49:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peterlin@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 3AGCnCiU098650
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 20:49:12 +0800 (+08)
 (envelope-from peterlin@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0;
 Thu, 16 Nov 2023 20:49:11 +0800
From: Yu Chien Peter Lin <peterlin@andestech.com>
To: <rick@andestech.com>, <ycliang@andestech.com>, <peterlin@andestech.com>,
 <randolph@andestech.com>, <u-boot@lists.denx.de>
Subject: [PATCH] riscv: andes: Fix enable register settings of PLICSW
Date: Thu, 16 Nov 2023 20:46:12 +0800
Message-ID: <20231116124612.117927-1-peterlin@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 3AGCnCiU098650
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

On 32-core platform, hart31 gets stuck at secondary_hart_loop
as the corresponding enable bit is not set in enable_ipi().
We should program the next word (0x2f84) which is assigned
as the enable register of hart31. It should be done in the same
way when we invoke riscv_send_ipi() to trigger software interrupt
on hart31.

The following diagram shows the enable bits of the fixed PLICSW
scheme.

   Pending regs: 0x1000  x---0---0---0---0------0---0
Pending hart ID:             0   1   2   3 ... 30  31
   Interrupt ID:         0   1   2   3   4 ... 31  32
                         |   |   |   |   |      |   |
    Enable regs: 0x2000  x---1---0---0---0-...--0---0---> hart0
                         |   |   |   |   |      |   |
                 0x2080  x---0---1---0---0-...--0---0---> hart1
                         |   |   |   |   |      |   |
                 0x2100  x---0---0---1---0-...--0---0---> hart2
                         |   |   |   |   |      |   |
                 0x2180  x---0---0---0---1-...--0---0---> hart3
                         .   .   .   .   .      .   .
                         .   .   .   .   .      .   .
                         .   .   .   .   .      .   .
                 0x2f00  x---0---0---0---0-...--1---0---> hart30
                         |   |   |   |   |      |   |
                 0x2f80  x---0---0---0---0-...--0---1---> hart31
                         <-------- word 0 -------><--- word 1 --->

This patch includes some cleanups to macros/functions.

Fixes: ebf11273220a ("riscv: andes: Rearrange Andes PLICSW to single-bit-per-hart strategy")
Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
Reviewed-by: Randolph <randolph@andestech.com>
---
 arch/riscv/lib/andes_plicsw.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/arch/riscv/lib/andes_plicsw.c b/arch/riscv/lib/andes_plicsw.c
index db3b61abd9..113be71731 100644
--- a/arch/riscv/lib/andes_plicsw.c
+++ b/arch/riscv/lib/andes_plicsw.c
@@ -22,41 +22,36 @@
 #include <linux/err.h>
 
 /* pending register */
-#define PENDING_REG(base)	((ulong)(base) + 0x1000)
+#define PENDING_REG(base, hart)	((ulong)(base) + 0x1000 + 4 * (((hart) + 1) / 32))
 /* enable register */
-#define ENABLE_REG(base, hart)	((ulong)(base) + 0x2000 + (hart) * 0x80)
+#define ENABLE_REG(base, hart)	((ulong)(base) + 0x2000 + (hart) * 0x80 + 4 * (((hart) + 1) / 32))
 /* claim register */
 #define CLAIM_REG(base, hart)	((ulong)(base) + 0x200004 + (hart) * 0x1000)
 /* priority register */
 #define PRIORITY_REG(base)	((ulong)(base) + PLICSW_PRIORITY_BASE)
 
 /* Bit 0 of PLIC-SW pending array is hardwired to zero, so we start from bit 1 */
-#define FIRST_AVAILABLE_BIT	0x2
-#define SEND_IPI_TO_HART(hart)	(FIRST_AVAILABLE_BIT << (hart))
 #define PLICSW_PRIORITY_BASE        0x4
-#define PLICSW_INTERRUPT_PER_HART   0x1
 
 DECLARE_GLOBAL_DATA_PTR;
 
 static int enable_ipi(int hart)
 {
-	unsigned int en;
+	u32 enable_bit = (hart + 1) % 32;
 
-	en = FIRST_AVAILABLE_BIT << hart;
-	writel(en, (void __iomem *)ENABLE_REG(gd->arch.plicsw, hart));
+	writel(BIT(enable_bit), (void __iomem *)ENABLE_REG(gd->arch.plicsw, hart));
 
 	return 0;
 }
 
 static void init_priority_ipi(int hart_num)
 {
-    uint32_t *priority = (void *)PRIORITY_REG(gd->arch.plicsw);
+	u32 *priority = (void *)PRIORITY_REG(gd->arch.plicsw);
 
-    for (int i = 0; i < hart_num * PLICSW_INTERRUPT_PER_HART; i++) {
-        writel(1, &priority[i]);
-    }
+	for (int i = 0; i < hart_num; i++)
+		writel(1, &priority[i]);
 
-    return;
+	return;
 }
 
 int riscv_init_ipi(void)
@@ -105,9 +100,10 @@ int riscv_init_ipi(void)
 
 int riscv_send_ipi(int hart)
 {
-	unsigned int ipi = SEND_IPI_TO_HART(hart);
+	u32 interrupt_id = hart + 1;
+	u32 pending_bit  = interrupt_id % 32;
 
-	writel(ipi, (void __iomem *)PENDING_REG(gd->arch.plicsw));
+	writel(BIT(pending_bit), (void __iomem *)PENDING_REG(gd->arch.plicsw, hart));
 
 	return 0;
 }
@@ -124,10 +120,11 @@ int riscv_clear_ipi(int hart)
 
 int riscv_get_ipi(int hart, int *pending)
 {
-	unsigned int ipi = SEND_IPI_TO_HART(hart);
+	u32 interrupt_id = hart + 1;
+	u32 pending_bit  = interrupt_id % 32;
 
-	*pending = readl((void __iomem *)PENDING_REG(gd->arch.plicsw));
-	*pending = !!(*pending & ipi);
+	*pending = readl((void __iomem *)PENDING_REG(gd->arch.plicsw, hart));
+	*pending = !!(*pending & BIT(pending_bit));
 
 	return 0;
 }
-- 
2.34.1

