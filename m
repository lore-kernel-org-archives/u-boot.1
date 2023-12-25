Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADC0C3DA6E
	for <u-boot@archiver.kernel.org>; Mon, 25 Dec 2023 13:06:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53A148753E;
	Mon, 25 Dec 2023 14:05:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4EBC87767; Mon, 25 Dec 2023 14:05:57 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92E7487480
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 14:05:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 3BPD5o81042909
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 21:05:50 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0;
 Mon, 25 Dec 2023 21:05:45 +0800
From: Leo Yu-Chi Liang <ycliang@andestech.com>
To: <u-boot@lists.denx.de>
CC: <randolph@andestech.com>, <peterlin@andestech.com>, <ycliang@andestech.com>
Subject: [PATCH 2/5] andes: ae350: Implement cache switch via Kconfig
Date: Mon, 25 Dec 2023 21:05:25 +0800
Message-ID: <20231225130528.1954968-2-ycliang@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231225130528.1954968-1-ycliang@andestech.com>
References: <20231225130528.1954968-1-ycliang@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 3BPD5o81042909
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

Kconfig provides SYS_[I|D]CACHE_OFF config options
to switch off caches. Implement the corresponding options.

Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 arch/riscv/cpu/andesv5/cpu.c  | 9 +++++++--
 board/AndesTech/ae350/ae350.c | 3 ++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/cpu/andesv5/cpu.c b/arch/riscv/cpu/andesv5/cpu.c
index 63bc24cdfc..50cd31905d 100644
--- a/arch/riscv/cpu/andesv5/cpu.c
+++ b/arch/riscv/cpu/andesv5/cpu.c
@@ -32,8 +32,13 @@ void harts_early_init(void)
 	if (CONFIG_IS_ENABLED(RISCV_MMODE)) {
 		unsigned long mcache_ctl_val = csr_read(CSR_MCACHE_CTL);
 
-		mcache_ctl_val |= (MCACHE_CTL_DC_COHEN | MCACHE_CTL_IC_EN |
-				   MCACHE_CTL_DC_EN | MCACHE_CTL_CCTL_SUEN);
+		mcache_ctl_val |= (MCACHE_CTL_DC_COHEN | MCACHE_CTL_CCTL_SUEN | \
+
+	if (!CONFIG_IS_ENABLED(SYS_ICACHE_OFF))
+		mcache_ctl |= MCACHE_CTL_IC_EN;
+
+	if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF)) {
+		mcache_ctl |= MCACHE_CTL_DC_EN;
 
 		csr_write(CSR_MCACHE_CTL, mcache_ctl_val);
 
diff --git a/board/AndesTech/ae350/ae350.c b/board/AndesTech/ae350/ae350.c
index 772c6bf1ee..bef9e3149e 100644
--- a/board/AndesTech/ae350/ae350.c
+++ b/board/AndesTech/ae350/ae350.c
@@ -102,7 +102,8 @@ void *board_fdt_blob_setup(int *err)
 void spl_board_init()
 {
 	/* enable v5l2 cache */
-	enable_caches();
+	if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
+		enable_caches();
 }
 #endif
 
-- 
2.34.1

