Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE1DC0218F
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 21:55:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 754C780AE4;
	Wed, 29 Jan 2025 22:55:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="bl7hGwcy";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="sETVLyTF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8B9980B9B; Wed, 29 Jan 2025 22:55:22 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AFBE80A09
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 22:55:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Yjwtw2dZGz9t8B;
 Wed, 29 Jan 2025 22:55:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1738187720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tKPGCANPQZgtSWaanpltl2AIFw/RpxdLS/ihwJEgDbE=;
 b=bl7hGwcy3smjYr+eg5ICHuE+0sCjaGgNytoN88Pb7+o3YsYrvIi81+CSyX5zl/D3qaoeQ+
 oMibe7/n1oA2wJR9dsrcXE8C+Hj61HrGVXW4KMJyNQ9esFeavEGqXRASPcgc2z3m7CWJsB
 /CKhHdx7Z/9oxt8Cc9GUeWC+oCLuGsjoqutU/vUkMNoGhRkYe+IWSQBx+QNn3lihvwaYVW
 LX+G88lJRDLJZJ/uXyQKcV/K/ttbL0c1JV0Ykx5M3RYbE+5ysnAIKCff4cmv8YAP8fgnG5
 gDdpCYDzlMXI5VG6d+Attgrp0VW9COGry7EGTXwRP/V1CCHIJOZiCyBZBiiLxQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1738187718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tKPGCANPQZgtSWaanpltl2AIFw/RpxdLS/ihwJEgDbE=;
 b=sETVLyTFfysGdyBJ7mcuVnsk0d1mZxp6MbpovwB6NE9Q4WWNFdqQshaLtnTOCan8OfG+C3
 y4hfsZHjewbBHgqI9lD4th9ADj9W5rcoOHS+0rh8CSgb98/WGxJ/E2bRNtoZAX5TTauSDf
 C68Ak9AANOy/0l8aTOrPLJXPcDN7dRP6l74kALj7b/oOmUtcqYtbPhIWeLkheeVEwprrNP
 6g3FeFzmiEMVYAG1G07R54lmK0hEFAEndnDgNiuolNmSmlO04JpnJDaS7WRzDttPkkMlge
 boetopaDQIUt2BHJIBRN7kV9hfw2Z23NRmCCI6G3X8a5bfVStN+FEA5vPTw1qA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] remoteproc: renesas: Synchronize caches across cores
Date: Wed, 29 Jan 2025 22:54:50 +0100
Message-ID: <20250129215503.257073-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: yzt9xx5mzndho9qce8axympthfudmppx
X-MBO-RS-ID: f3ec61558b9df19e283
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

Explicitly flush icache on the CR52 core before jumping to the next
stage software to make sure it does not contain any invalid content.
Explicitly flash and invalidate dcache on the CA76 core both over the
trampoline buffer and over the CR52 firmware, and then trigger full
system synchronization, to make sure the data surely land in DRAM,
from where the CR52 can surely pick them up.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/mach-renesas/include/mach/boot0.h | 12 +++++++++++-
 drivers/remoteproc/renesas_apmu.c          |  7 +++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-renesas/include/mach/boot0.h b/arch/arm/mach-renesas/include/mach/boot0.h
index fc68ffc0945..b71c157149e 100644
--- a/arch/arm/mach-renesas/include/mach/boot0.h
+++ b/arch/arm/mach-renesas/include/mach/boot0.h
@@ -34,7 +34,7 @@ _start:
 	.inst	0xe380070a	/* orr     r0, r0, #0x280000 */
 
 	/* APMU_RVBARPLC0 = (address of 'b reset' below) | CA_CORE0_VLD_RVBARP */
-	.inst	0xe28f3088	/* add     r3, pc, #0x88 */
+	.inst	0xe28f30a8	/* add     r3, pc, #0xa8 */
 	.inst	0xe3833001	/* orr     r3, r3, #1 */
 	.inst	0xe5843038	/* str     r3, [r4, #56]   @ 0x38 */
 
@@ -75,12 +75,22 @@ _start:
 	.inst	0xe20230ff	/* and     r3, r2, #255    @ 0xff */
 	.inst	0xe3530011	/* cmp     r3, #17 */
 	.inst	0x1afffffb	/* bne     78 <reset-0x28> */
+	/* Invalidate icache before jump to follow up software */
+	.inst	0xe3a00000	/* mov     r0, #0 */
+	.inst	0xee070f15	/* mcr     15, 0, r0, cr7, cr5, {0} */
+	.inst	0xf57ff04f	/* dsb     sy */
+	.inst	0xf57ff06f	/* isb     sy */
+	/* Jump to follow up software */
 	.inst	0xe1a02922	/* lsr     r2, r2, #18 */
 	.inst	0xe1a02902	/* lsl     r2, r2, #18 */
 	.inst	0xe1a0f002	/* mov     pc, r2 */
 	.inst	0xeafffffe	/* b       94 <reset-0xc> */
 	.inst	0xe1a00000	/* nop                     @ (mov r0, r0) */
 	.inst	0xe1a00000	/* nop                     @ (mov r0, r0) */
+	.inst	0xe1a00000	/* nop                     @ (mov r0, r0) */
+	.inst	0xe1a00000	/* nop                     @ (mov r0, r0) */
+	.inst	0xe1a00000	/* nop                     @ (mov r0, r0) */
+	.inst	0xe1a00000	/* nop                     @ (mov r0, r0) */
 	/* Offset 0xa0 */
 #endif
 	b	reset
diff --git a/drivers/remoteproc/renesas_apmu.c b/drivers/remoteproc/renesas_apmu.c
index 32d138e6487..1a50cd3289b 100644
--- a/drivers/remoteproc/renesas_apmu.c
+++ b/drivers/remoteproc/renesas_apmu.c
@@ -68,6 +68,13 @@ static int renesas_apmu_rproc_load(struct udevice *dev, ulong addr, ulong size)
 	flush_dcache_range(trampolineaddr,
 			   trampolineaddr +
 			   sizeof(renesas_apmu_rproc_trampoline));
+	invalidate_dcache_range(trampolineaddr,
+				trampolineaddr +
+				sizeof(renesas_apmu_rproc_trampoline));
+	flush_dcache_range(addr, addr + size);
+	invalidate_dcache_range(addr, addr + size);
+	asm volatile("dsb sy\n");
+	asm volatile("isb sy\n");
 
 	/* CR52 boot address set */
 	writel(trampolineaddr | APMU_CRBARP_CR_VLD_BARP,
-- 
2.45.2

