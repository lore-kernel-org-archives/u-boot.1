Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33211C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 12:50:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B85318848A;
	Tue, 28 May 2024 14:50:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6232D8848A; Tue, 28 May 2024 14:50:03 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 366CC8841D
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 14:49:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 44SCnmdL018960
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 20:49:48 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0;
 Tue, 28 May 2024 20:49:46 +0800
From: Leo Yu-Chi Liang <ycliang@andestech.com>
To: <u-boot@lists.denx.de>
CC: <ycliang@andestech.com>
Subject: [PATCH 1/1] andes: l2 cache driver: fixes typos and cctl status
Date: Tue, 28 May 2024 20:49:42 +0800
Message-ID: <20240528124942.933925-1-ycliang@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 44SCnmdL018960
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

Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 drivers/cache/cache-andes-l2.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/cache/cache-andes-l2.c b/drivers/cache/cache-andes-l2.c
index 45d29f2fbd..bc6f7ed7c1 100644
--- a/drivers/cache/cache-andes-l2.c
+++ b/drivers/cache/cache-andes-l2.c
@@ -30,7 +30,7 @@ struct l2cache {
 	volatile u64	cctl_command2;
 	volatile u64	cctl_access_line2;
 	volatile u64	cctl_command3;
-	volatile u64	cctl_access_line4;
+	volatile u64	cctl_access_line3;
 	volatile u64	cctl_status;
 };
 
@@ -97,13 +97,15 @@ static int andes_l2_disable(struct udevice *dev)
 	struct andes_l2_plat *plat = dev_get_plat(dev);
 	volatile struct l2cache *regs = plat->regs;
 	u8 hart = gd->arch.boot_hart;
+
 	void __iomem *cctlcmd = (void __iomem *)CCTL_CMD_REG(regs, hart);
+	void __iomem *cctlstatus = (void __iomem *)CCTL_STATUS_REG(regs, hart);
 
 	if ((regs) && (readl(&regs->control) & L2_ENABLE)) {
 		writel(L2_WBINVAL_ALL, cctlcmd);
 
-		while ((readl(&regs->cctl_status) & CCTL_STATUS_MSK(hart))) {
-			if ((readl(&regs->cctl_status) & CCTL_STATUS_ILLEGAL(hart))) {
+		while ((readl(cctlstatus) & CCTL_STATUS_MSK(hart))) {
+			if ((readl(cctlstatus) & CCTL_STATUS_ILLEGAL(hart))) {
 				printf("L2 flush illegal! hanging...");
 				hang();
 			}
-- 
2.34.1

