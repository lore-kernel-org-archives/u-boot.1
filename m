Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2394C25B7C
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 12:49:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 283018841F;
	Tue, 28 May 2024 14:49:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0255488431; Tue, 28 May 2024 14:49:41 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 786D08841D
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 14:49:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 44SCnRPA018913
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 20:49:27 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0;
 Tue, 28 May 2024 20:49:26 +0800
From: Leo Yu-Chi Liang <ycliang@andestech.com>
To: <u-boot@lists.denx.de>
CC: <ycliang@andestech.com>
Subject: [PATCH 1/1] andes: Use UCCTLCOMMAND instead of MCCTLCOMMAND
Date: Tue, 28 May 2024 20:49:19 +0800
Message-ID: <20240528124919.933294-1-ycliang@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 44SCnRPA018913
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

Use CSR_UCCTLCOMMAND instead of CSR_MCCTLCOMMAND
to do cache flush operation in M-mode and S-mode.

Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 arch/riscv/cpu/andes/cache.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/riscv/cpu/andes/cache.c b/arch/riscv/cpu/andes/cache.c
index 7d3df8722d..bb57498d75 100644
--- a/arch/riscv/cpu/andes/cache.c
+++ b/arch/riscv/cpu/andes/cache.c
@@ -43,9 +43,7 @@ static void cache_ops(int (*ops)(struct udevice *dev))
 
 void flush_dcache_all(void)
 {
-#if CONFIG_IS_ENABLED(RISCV_MMODE)
-	csr_write(CSR_MCCTLCOMMAND, CCTL_L1D_WBINVAL_ALL);
-#endif
+	csr_write(CSR_UCCTLCOMMAND, CCTL_L1D_WBINVAL_ALL);
 }
 
 void flush_dcache_range(unsigned long start, unsigned long end)
-- 
2.34.1

