Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87DF4D232E4
	for <u-boot@archiver.kernel.org>; Sat, 10 Jan 2026 19:56:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC26C83B1E;
	Sat, 10 Jan 2026 20:56:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="NP5vMU/f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FACB83B4E; Sat, 10 Jan 2026 20:56:50 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E013083AB7
 for <u-boot@lists.denx.de>; Sat, 10 Jan 2026 20:56:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=kettenis@openbsd.org
X-KPN-MessageId: 7c25cfef-ee5e-11f0-8fef-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 7c25cfef-ee5e-11f0-8fef-005056999439;
 Sat, 10 Jan 2026 20:56:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kpnmail.nl; s=kpnmail01;
 h=mime-version:message-id:date:subject:to:from;
 bh=Ic1JSkNqHL4sDPGrMelLnRPGCkhFLYTxtzNQOhoKGWI=;
 b=NP5vMU/f9VXZyNJNV9Tf1j1hzzSV2NWqH6afudB79eMOZnjEDIVcA+CK5L84TYXogmZM86N+1iBxx
 5aqYkRYSxUBX7ww64i1RkXdjxArla10fM0KcMd4Eg5eqshij7hD4J/7ZtNlGfNQYR4zX3WK7uMf0mp
 Htxeh3cWMVd6NdKE=
X-KPN-MID: 33|4EjVsOkQ823zdkGsrYznoKqRTNODuMEJUj6EE93eKUISaXAV210FjgJn9kt+si7
 L5vUBKAAnU51mVakZB/8jGN3IUHHzFpfLMy77z7UDgYw=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|WrZ0cm6DeIy0TXHJls5aFPrQC4eME02RizRyb7Zfyq1SX0ysOditpLue3as0U+g
 Ab3/W6hTXUMhiK9/BlMVplQ==
X-Originating-IP: 80.61.163.207
Received: from korngold.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 7ca99012-ee5e-11f0-9bf7-00505699d6e5;
 Sat, 10 Jan 2026 20:56:43 +0100 (CET)
From: Mark Kettenis <kettenis@openbsd.org>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org, anshuld@ti.com,
 d-gole@ti.com, casey.connolly@linaro.org,
 Mark Kettenis <kettenis@openbsd.org>
Subject: [PATCH] arm: armv8: Flush TLB before enabling MMU
Date: Sat, 10 Jan 2026 20:56:10 +0100
Message-ID: <20260110195610.42068-1-kettenis@openbsd.org>
X-Mailer: git-send-email 2.52.0
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

Commit 9ebdbbc43e5f ("arm: armv8: invalidate dcache entries on
dcache_enable") broke Apple Silicon machines in certain scenarios.
If the MMU is currently not enabled we need to flush the TLB
before we enable it to prevent stale TLB entries from becoming
active again.  So move the __asm_invalidate_tlb_all() back
immediately before the mmu_setup() call.

Fixes: 9ebdbbc43e5f ("arm: armv8: invalidate dcache entries on dcache_enable")
Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
---
 arch/arm/cpu/armv8/cache_v8.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index 0309da6d397..39479df7b21 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -878,15 +878,16 @@ void flush_dcache_range(unsigned long start, unsigned long stop)
 void dcache_enable(void)
 {
 	/* The data cache is not active unless the mmu is enabled */
-	if (!mmu_status())
+	if (!mmu_status()) {
+		__asm_invalidate_tlb_all();
 		mmu_setup();
+	}
 
 	/* Set up page tables only once (it is done also by mmu_setup()) */
 	if (!gd->arch.tlb_fillptr)
 		setup_all_pgtables();
 
 	invalidate_dcache_all();
-	__asm_invalidate_tlb_all();
 	set_sctlr(get_sctlr() | CR_C);
 }
 
-- 
2.52.0

