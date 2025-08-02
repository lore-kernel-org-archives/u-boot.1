Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66AF3C87FD2
	for <u-boot@archiver.kernel.org>; Sat,  2 Aug 2025 09:22:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2476E83C13;
	Sat,  2 Aug 2025 11:22:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="TmaU6uDO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D94E983C13; Sat,  2 Aug 2025 11:22:21 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF9A983C0B
 for <u-boot@lists.denx.de>; Sat,  2 Aug 2025 11:22:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 98F0022B58;
 Sat,  2 Aug 2025 11:22:19 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jumcRWF7jSNN; Sat,  2 Aug 2025 11:22:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1754126539; bh=VD7yGixnrs+skRz5ytoDu518UgzL9ZURUppbKgCUY5Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=TmaU6uDOdjbIE8xWl4oUijjsaXcxugEkyduYLlz86clSQR0ClOiR/uwEY2cCwqXBZ
 38maYtuVHD7L5gL2DBgUZDGmlglEUQRG6tTbKHX8+HPCbdW61A46ain/pxmXBc+EIY
 PvxcYq2hrvKChxA5NPZMUFl9f92j20Yz0Ph2oNcGfYfpGjxh8dBtXsecZ4X7zylYw3
 ou/qtrLTIvRKmjxYIzIH7RXukeqCdLF+viyJXaK0UlNstiGadUrltg9lwT6FFZ5k4H
 n8qMm5MIOxm7cRuN3MhpPjlKNNzaxgjq8LRmBSYsiB4Sy4ofnhEC0uKZ5rVRF59g6L
 GHmESJ8xCTuQw==
From: Yao Zi <ziyao@disroot.org>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>,
 "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH 2/2] riscv: Add a Zalrsc-only alternative for synchronization
 in start.S
Date: Sat,  2 Aug 2025 09:21:55 +0000
Message-ID: <20250802092155.40915-3-ziyao@disroot.org>
In-Reply-To: <20250802092155.40915-1-ziyao@disroot.org>
References: <20250802092155.40915-1-ziyao@disroot.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add an alternative implementation that use Zalrsc extension only for
HART lottery and SMP locking to support SMP on cores without "Zaamo"
extension available. The Zaamo implementation is still used by default
since since the Zalrsc one requires more instructions.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 arch/riscv/cpu/start.S | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/cpu/start.S b/arch/riscv/cpu/start.S
index 7bafdfd390a..6324ff585d4 100644
--- a/arch/riscv/cpu/start.S
+++ b/arch/riscv/cpu/start.S
@@ -151,8 +151,15 @@ call_harts_early_init:
 	 */
 	la	t0, hart_lottery
 	li	t1, 1
+#if CONFIG_IS_ENABLED(RISCV_ISA_ZAAMO)
 	amoswap.w s2, t1, 0(t0)
 	bnez	s2, wait_for_gd_init
+#else
+	lr.w	s2, (t0)
+	bnez	s2, wait_for_gd_init
+	sc.w	s2, t1, (t0)
+	bnez	s2, wait_for_gd_init
+#endif
 #else
 	/*
 	 * FIXME: gp is set before it is initialized. If an XIP U-Boot ever
@@ -177,7 +184,12 @@ call_harts_early_init:
 #if !CONFIG_IS_ENABLED(XIP)
 #ifdef CONFIG_AVAILABLE_HARTS
 	la	t0, available_harts_lock
+#if CONFIG_IS_ENABLED(RISCV_ISA_ZAAMO)
 	amoswap.w.rl zero, zero, 0(t0)
+#else
+	fence	rw, w
+	sw	zero, 0(t0)
+#endif
 #endif
 
 wait_for_gd_init:
@@ -190,7 +202,14 @@ wait_for_gd_init:
 #ifdef CONFIG_AVAILABLE_HARTS
 	la	t0, available_harts_lock
 	li	t1, 1
-1:	amoswap.w.aq t1, t1, 0(t0)
+1:
+#if CONFIG_IS_ENABLED(RISCV_ISA_ZAAMO)
+	amoswap.w.aq t1, t1, 0(t0)
+#else
+	lr.w.aq	t1, 0(t0)
+	bnez	t1, 1b
+	sc.w.rl t1, t1, 0(t0)
+#endif
 	bnez	t1, 1b
 
 	/* register available harts in the available_harts mask */
@@ -200,7 +219,12 @@ wait_for_gd_init:
 	or	t2, t2, t1
 	SREG	t2, GD_AVAILABLE_HARTS(gp)
 
+#if CONFIG_IS_ENABLED(RISCV_ISA_ZAAMO)
 	amoswap.w.rl zero, zero, 0(t0)
+#else
+	fence	rw, w
+	sw	zero, 0(t0)
+#endif
 #endif
 
 	/*
-- 
2.50.1

