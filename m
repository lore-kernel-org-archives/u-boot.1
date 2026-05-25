Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD031CD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 18:26:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16190848BB;
	Mon, 25 May 2026 20:26:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="B1JRLYCd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1222A848E6; Mon, 25 May 2026 20:26:32 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD9D8848B9
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 20:26:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josh2@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 9658F26A37;
 Mon, 25 May 2026 20:26:29 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8mT3y9p6VlUc; Mon, 25 May 2026 20:26:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1779733588; bh=btPRWYyaJZQMugaXWN9hDn/VVClFA89BFrpoBlQSISM=;
 h=From:To:Cc:Subject:Date;
 b=B1JRLYCd/W3V2y25s4C8rFqKMICK5Kz/RgCu+ye4gJz7u29J8gq/66mgGz+owmrph
 fKQrjoDn8Bx4Q8Perr1ZrUv1cRW27hnTnEm1c+VzCD9NPz+zOaHTQrw787qcPIx+Pd
 qwH+Dyc4acEkaZgiamhT17IWiUCQxbB13kNzpZflX2moZEezLm/K4rugXMUVoq70Y7
 dVEa4QrR97uwqPHBsmYYx/wlWVocKx6wc0XOE2GJjj45qYO/euJy4UIO0We3DoaSG+
 +Nwt9u7Pnwpn2rzVLqubOPAI6O84YOq6Qp/H4YJiCYDsFF2MFzpdHyvNRWyjFaFilK
 gTWpyjjFRRz6g==
From: Josh Law <josh2@disroot.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Josh Law <josh2@disroot.org>
Subject: [PATCH] arm64: memset: speed up cache disabled path
Date: Mon, 25 May 2026 18:26:27 +0000
Message-ID: <20260525182627.2597-1-josh2@disroot.org>
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

AArch64 memset() skips dc zva when dcache is off. That fallback
was still storing one byte per loop.

This runs before the MMU comes on. One common caller is create_table(),
which clears 4 KiB page tables during MMU setup.

Build the repeated byte in x1, align the destination to 8 bytes, then
use four 64 bit stores per loop. The head and tail stay byte based.
The cache disabled path still avoids SIMD and dc instructions.

For qemu_arm64_defconfig, the object text grows from 412 bytes to
524 bytes.

A qemu user mode bench of this fallback loop gave a 4 KiB fill time of
4970643109 ns before and 254278076 ns after, a 19.55x speedup.

Signed-off-by: Josh Law <josh2@disroot.org>
---
 arch/arm/lib/memset-arm64.S | 55 +++++++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 15 deletions(-)

diff --git a/arch/arm/lib/memset-arm64.S b/arch/arm/lib/memset-arm64.S
index ee9f9a96cfe..97849e8b4be 100644
--- a/arch/arm/lib/memset-arm64.S
+++ b/arch/arm/lib/memset-arm64.S
@@ -28,9 +28,8 @@ ENTRY (memset)
 
 	/*
 	 * The optimized memset uses the dc opcode, which causes problems
-	 * when the cache is disabled. Let's check if the cache is disabled
-	 * and use a very simple memset implementation in this case. Otherwise
-	 * jump to the optimized version.
+	 * when the cache is disabled. Use the plain store path in that case,
+	 * then jump to the fast version otherwise.
 	 */
 	switch_el x6, 3f, 2f, 1f
 3:	mrs	x6, sctlr_el3
@@ -40,21 +39,47 @@ ENTRY (memset)
 1:	mrs	x6, sctlr_el1
 0:
 	tst	x6, #CR_C
-	bne	9f
+	bne	10f
 
 	/*
-	 * A very "simple" memset implementation without the use of the
-	 * dc opcode. Can be run with caches disabled.
+	 * Avoid dc zva while dcache is off. Build the byte pattern once,
+	 * then use aligned stores for the main body.
 	 */
-	mov	x3, #0x0
-	cmp	count, x3	/* check for zero length */
-	beq	8f
-4:	strb	valw, [dstin, x3]
-	add	x3, x3, #0x1
-	cmp	count, x3
-	bne	4b
-8:	ret
-9:
+	cbz	count, 8f
+	and	val, val, #255
+	orr	val, val, val, lsl #8
+	orr	val, val, val, lsl #16
+	orr	val, val, val, lsl #32
+
+	mov	dst, dstin
+	tst	dst, #7
+	b.eq	5f
+4:	strb	valw, [dst], #1
+	subs	count, count, #1
+	b.eq	8f
+	tst	dst, #7
+	b.ne	4b
+5:	cmp	count, #32
+	b.lo	7f
+6:	str	val, [dst], #8
+	str	val, [dst], #8
+	str	val, [dst], #8
+	str	val, [dst], #8
+	subs	count, count, #32
+	cmp	count, #32
+	b.hs	6b
+7:	cmp	count, #8
+	b.lo	8f
+	str	val, [dst], #8
+	subs	count, count, #8
+	cmp	count, #8
+	b.hs	7b
+8:	cbz	count, 9f
+	strb	valw, [dst], #1
+	subs	count, count, #1
+	b.ne	8b
+9:	ret
+10:
 
 	/* Here the optimized memset version starts */
 	dup	v0.16B, valw
-- 
2.47.3

