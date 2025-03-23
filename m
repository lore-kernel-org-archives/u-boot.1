Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB29C28B30
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 11:40:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CD1782040;
	Sun, 23 Mar 2025 12:36:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 080F582008; Sun, 23 Mar 2025 12:36:44 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id E7DE381D5A
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 12:36:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 236AD1595;
 Sun, 23 Mar 2025 04:36:48 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 69F783F694;
 Sun, 23 Mar 2025 04:36:40 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Mikhail Kalashnikov <iuncuim@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: [PATCH 24/34] sunxi: armv8: fel: move fel_stash variable to the front
Date: Sun, 23 Mar 2025 11:35:34 +0000
Message-ID: <20250323113544.7933-25-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250323113544.7933-1-andre.przywara@arm.com>
References: <20250323113544.7933-1-andre.przywara@arm.com>
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

To return a 64-bit Allwinner chip back to the 32-bit BootROM code, we
have some embedded AArch32 code that restores the CPU state, before
branching back to the BootROM. At the moment the pointer to the buffer
with that state is located *after* the code, which makes the PC relative
code fragile: adding or removing instructions will change the distance
to that pointer variable.
The "new" Allwinner A523 SoC requires more state to be restored (GICv3
system registers), but we must do that *only* on that SoC. Conditional
compilation sounds like the easiest solution, but would mean that the
distance to that pointer would change.

Solve this rather easily by moving the pointer to the *front* of the
code: we load that pointer in the first instruction, so the distance
would always stay the same. Later in the code we won't need PC relative
addressing anymore, so this code can grow or shrink easily, for instance
due to conditional compilation.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/cpu/armv8/fel_utils.S | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/cpu/armv8/fel_utils.S b/arch/arm/cpu/armv8/fel_utils.S
index 939869b9ffa..f7707acdf1a 100644
--- a/arch/arm/cpu/armv8/fel_utils.S
+++ b/arch/arm/cpu/armv8/fel_utils.S
@@ -63,9 +63,12 @@ ENTRY(return_to_fel)
 1:	wfi
 	b	1b
 
+fel_stash_addr:			// must immediately precede back_in_32:
+	.word   0x00000000	// receives fel_stash addr, by AA64 code above
+
 /* AArch32 code to restore the state from fel_stash and return back to FEL. */
 back_in_32:
-	.word	0xe59f0028	// ldr	r0, [pc, #40]	; load fel_stash address
+	.word	0xe51f000c	// ldr	r0, [pc, #-12]  ; load fel_stash address
 	.word	0xe5901008	// ldr	r1, [r0, #8]
 	.word	0xe129f001	// msr	CPSR_fc, r1
 	.word	0xf57ff06f	// isb
@@ -77,6 +80,4 @@ back_in_32:
 	.word	0xee011f10	// mcr	15, 0, r1, cr1, cr0, {0}  ; SCTLR
 	.word	0xf57ff06f	// isb
 	.word	0xe12fff1e	// bx	lr		; return to FEL
-fel_stash_addr:
-	.word   0x00000000	// receives fel_stash addr, by AA64 code above
 ENDPROC(return_to_fel)
-- 
2.46.3

