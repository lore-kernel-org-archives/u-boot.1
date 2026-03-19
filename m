Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 424FE1075276
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 08:29:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DE3283CF3;
	Thu, 19 Mar 2026 09:29:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DEDC83DA6; Thu, 19 Mar 2026 09:29:18 +0100 (CET)
Received: from Atcsqr.andestech.com (exmail.andestech.com [60.248.187.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA30683BC8
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 09:29:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTP id 62J8SvwO014752;
 Thu, 19 Mar 2026 16:28:57 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Mar
 2026 16:28:57 +0800
From: Leo Yu-Chi Liang <ycliang@andestech.com>
To: <u-boot@lists.denx.de>
CC: <rick@andestech.com>, <ycliang@andestech.com>, <trini@konsulko.com>,
 <me@ziyao.cc>, <e@freeshell.de>, <qemu-devel@nongnu.org>, CL Wang
 <cl634@andestech.com>
Subject: [PATCH] riscv: spl: Clear BSS as early as possible
Date: Thu, 19 Mar 2026 16:28:51 +0800
Message-ID: <20260319082851.3262146-1-ycliang@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 62J8SvwO014752
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

From: CL Wang <cl634@andestech.com>

Move the BSS clearing sequence as early as possible, directly after
the hart lottery selection. This ensures all BSS variables are properly
zeroed before any C code executes.

Signed-off-by: CL Wang <cl634@andestech.com>
---
 arch/riscv/cpu/start.S | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/cpu/start.S b/arch/riscv/cpu/start.S
index 7bafdfd390a..c54a194f5b1 100644
--- a/arch/riscv/cpu/start.S
+++ b/arch/riscv/cpu/start.S
@@ -166,7 +166,18 @@ call_harts_early_init:
 	bnez	tp, secondary_hart_loop
 #endif
 #endif
-	
+
+#ifdef CONFIG_XPL_BUILD
+	la	t0, __bss_start
+	la	t1, __bss_end
+	beq	t0, t1, spl_clear_bss_done
+1:
+	SREG	zero, 0(t0)
+	addi	t0, t0, REGBYTES
+	blt	t0, t1, 1b
+spl_clear_bss_done:
+#endif
+
 	mv      a0, s0
 	jal	board_init_f_init_reserve
 
@@ -219,16 +230,6 @@ wait_for_gd_init:
 	jalr	t5			/* jump to board_init_f() */
 
 #ifdef CONFIG_XPL_BUILD
-spl_clear_bss:
-	la	t0, __bss_start
-	la	t1, __bss_end
-	beq	t0, t1, spl_stack_gd_setup
-
-spl_clear_bss_loop:
-	SREG	zero, 0(t0)
-	addi	t0, t0, REGBYTES
-	blt	t0, t1, spl_clear_bss_loop
-
 spl_stack_gd_setup:
 	jal	spl_relocate_stack_gd
 
-- 
2.34.1
