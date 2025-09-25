Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4557DCAC5B1
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 16:02:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8996880107;
	Thu, 25 Sep 2025 18:02:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="jB1LWR/c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B019C809A5; Thu, 25 Sep 2025 18:02:26 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 594D2800D7
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 18:02:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 167FC22B59;
 Thu, 25 Sep 2025 18:02:24 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6FIO3KGQe-S5; Thu, 25 Sep 2025 18:02:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1758816143; bh=25uKYNjSa1Qb80cjh0D9AX8jj87b5jIkmG3Ma3/vhTI=;
 h=From:To:Cc:Subject:Date;
 b=jB1LWR/czIPJ39DDjCwrVkMmoo5goS6Y1GPbJu5gYtPWyoRz82x3QbwMcTaXtW87z
 zCJ08obPbAW2Xrvw1qZq1+ktGDYPtRYnmTCBl9E6duAbnVaFYJC8dBwMzn2aUZ3ZdG
 Oa0pfwHvVt25Gm5i7M0JvAMp5YZH6CCG2ws4KMpZEkrHbL3100UiFqC4I+BpiOTHRR
 bTJPuPGTFyrOQ5RkeGea2uakvPT8JsBOygOE1eWPpsLBGrwtNW3PTbiVSEB+Ohbpy5
 0Ix/h4ljpovvKNjVM9Lktd0ZGIuIcyKuSumdcNiqlslsXS4Vzye/8ljzPOI2jEHrOZ
 PU3A80jUWmtaQ==
From: Yao Zi <ziyao@disroot.org>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>,
 "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Yao Zi <ziyao@disroot.org>,
 E Shattow <e@freeshell.de>
Subject: [PATCH] Revert "riscv: Add a Zalrsc-only alternative for
 synchronization in start.S"
Date: Thu, 25 Sep 2025 16:01:48 +0000
Message-ID: <20250925160148.21624-1-ziyao@disroot.org>
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

This reverts commit a681cfecb4346107212f377e2075f6eb1bdc6a2b.

It has been reported that the commit causes boot regression for SPL on
StarFive VisionFive 2 or compatible boards. Inspecting the code, I did
spot one logic error for deciding whether Zaamo or Zalrsc is used, and
it's still unclear what exactly causes the regression, let's revert it
for now.

Reported-by: E Shattow <e@freeshell.de>
Link: https://lore.kernel.org/u-boot/1871663e-b918-4351-9e9e-97f9a4c73733@freeshell.de/
Signed-off-by: Yao Zi <ziyao@disroot.org>
---

The original series causing the problem[1] contains 3 patches, and I
think it should be enough to revert the change of start.S only, since
the others touch no code, and should be relatively safe. I'll fix the
reverted change up and get it work on VisionFive 2 when I got my new
board. Sorry for the inconvenience.

[1]: https://lore.kernel.org/u-boot/20250902081932.21103-1-ziyao@disroot.org/

 arch/riscv/cpu/start.S | 26 +-------------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

diff --git a/arch/riscv/cpu/start.S b/arch/riscv/cpu/start.S
index 6324ff585d4..7bafdfd390a 100644
--- a/arch/riscv/cpu/start.S
+++ b/arch/riscv/cpu/start.S
@@ -151,15 +151,8 @@ call_harts_early_init:
 	 */
 	la	t0, hart_lottery
 	li	t1, 1
-#if CONFIG_IS_ENABLED(RISCV_ISA_ZAAMO)
 	amoswap.w s2, t1, 0(t0)
 	bnez	s2, wait_for_gd_init
-#else
-	lr.w	s2, (t0)
-	bnez	s2, wait_for_gd_init
-	sc.w	s2, t1, (t0)
-	bnez	s2, wait_for_gd_init
-#endif
 #else
 	/*
 	 * FIXME: gp is set before it is initialized. If an XIP U-Boot ever
@@ -184,12 +177,7 @@ call_harts_early_init:
 #if !CONFIG_IS_ENABLED(XIP)
 #ifdef CONFIG_AVAILABLE_HARTS
 	la	t0, available_harts_lock
-#if CONFIG_IS_ENABLED(RISCV_ISA_ZAAMO)
 	amoswap.w.rl zero, zero, 0(t0)
-#else
-	fence	rw, w
-	sw	zero, 0(t0)
-#endif
 #endif
 
 wait_for_gd_init:
@@ -202,14 +190,7 @@ wait_for_gd_init:
 #ifdef CONFIG_AVAILABLE_HARTS
 	la	t0, available_harts_lock
 	li	t1, 1
-1:
-#if CONFIG_IS_ENABLED(RISCV_ISA_ZAAMO)
-	amoswap.w.aq t1, t1, 0(t0)
-#else
-	lr.w.aq	t1, 0(t0)
-	bnez	t1, 1b
-	sc.w.rl t1, t1, 0(t0)
-#endif
+1:	amoswap.w.aq t1, t1, 0(t0)
 	bnez	t1, 1b
 
 	/* register available harts in the available_harts mask */
@@ -219,12 +200,7 @@ wait_for_gd_init:
 	or	t2, t2, t1
 	SREG	t2, GD_AVAILABLE_HARTS(gp)
 
-#if CONFIG_IS_ENABLED(RISCV_ISA_ZAAMO)
 	amoswap.w.rl zero, zero, 0(t0)
-#else
-	fence	rw, w
-	sw	zero, 0(t0)
-#endif
 #endif
 
 	/*
-- 
2.50.1

