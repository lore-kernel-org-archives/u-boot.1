Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F36ECA1005
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 08:20:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B506583A7A;
	Tue,  2 Sep 2025 10:20:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="ZEMWFIzL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66BA983A64; Tue,  2 Sep 2025 10:20:42 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91F4883145
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 10:20:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 632EE22C1F;
 Tue,  2 Sep 2025 10:20:40 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rvz3J2hk8pkT; Tue,  2 Sep 2025 10:20:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1756801239; bh=IBWOFMz7WixzVshxvRfGQ+3i3EZSXEa9yqAXrVAqrGg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ZEMWFIzL64MljDU29eatelQ27TO1B7FuGpE8Aodbk/1ey2w+B9sO19bJ+cx+2x6Nw
 EzTpftWu6Vxjq67qlnfCk1nqFuFvdauFPFPMFXv0vEWyCMhJqetWR2gaaVHPcy0jtT
 PlOJUyC8qfiO+/Ia8KK2FphNIWlj6vpOcc9Ih1hG/Rp4obfZ2+GR5tooSTiznjYrLM
 8OU9Zh1z3c6ouEp+6s8MDthwGSGBEIkKHIEfWqBN85ixU2BmzGOrT6dsa0oskuvfLx
 GwWJDrrTi9o/KQJrUtW4fz2XPecXruFNyFg2njSkOya7GYagi+7SBCaXqCyb9Wf9DQ
 ucDzyEqgtQ0Wg==
From: Yao Zi <ziyao@disroot.org>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>,
 "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH v2 3/3] riscv: Add a Zalrsc-only alternative for
 synchronization in start.S
Date: Tue,  2 Sep 2025 08:19:32 +0000
Message-ID: <20250902081932.21103-4-ziyao@disroot.org>
In-Reply-To: <20250902081932.21103-1-ziyao@disroot.org>
References: <20250902081932.21103-1-ziyao@disroot.org>
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
extension available. The Zaamo implementation is still prioritized if
both of them are available, since it takes fewer instructions.

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

