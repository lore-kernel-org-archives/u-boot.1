Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 869F8C36005
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 11:40:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF77F81ED8;
	Sun, 23 Mar 2025 12:36:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BADF82033; Sun, 23 Mar 2025 12:36:45 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 2D0D881FBC
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 12:36:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CBCA339;
 Sun, 23 Mar 2025 04:36:49 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3B3C3F7D8;
 Sun, 23 Mar 2025 04:36:41 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Mikhail Kalashnikov <iuncuim@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: [PATCH 25/34] sunxi: arm64: boot0.h: move fel_stash_addr variable to
 the front
Date: Sun, 23 Mar 2025 11:35:35 +0000
Message-ID: <20250323113544.7933-26-andre.przywara@arm.com>
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

To be able to return to the BootROM when booting via the FEL USB
protocol, we need to save the CPU state very early, which we need to do
in the embedded AArch32 code. At the moment the pointer to the buffer for
that state is located *after* the code, which makes the PC relative
code fragile: adding or removing instructions will change the distance
to that pointer variable.
The "new" Allwinner A523 SoC requires more state to be saved (GICv3
system registers), but we must do that *only* on that SoC. Conditional
compilation sounds like the easiest solution, but would mean that the
distance to that pointer would change.

Solve this rather easily by moving the pointer to the *front* of the
code: we load that pointer in the first instructions, so the distance
would always stay the same. Later in the code we won't need PC relative
addressing anymore, so this code can grow or shrink easily, for instance
due to conditional compilation.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/include/asm/arch-sunxi/boot0.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/arch-sunxi/boot0.h b/arch/arm/include/asm/arch-sunxi/boot0.h
index 6b2bb5a4586..24c81391d58 100644
--- a/arch/arm/include/asm/arch-sunxi/boot0.h
+++ b/arch/arm/include/asm/arch-sunxi/boot0.h
@@ -16,10 +16,11 @@
  */
 	tst     x0, x0                  // this is "b #0x84" in ARM
 	b       reset
-	.space  0x7c
+	.space  0x78
+	.word	fel_stash - .
 
-	.word	0xe28f0070	// add     r0, pc, #112	 // @(fel_stash - .)
-	.word	0xe59f106c	// ldr     r1, [pc, #108] // fel_stash - .
+	.word	0xe24f000c	// sub     r0, pc, #12  // @(fel_stash - .)
+	.word	0xe51f1010	// ldr     r1, [pc, #-16] // fel_stash - .
 	.word	0xe0800001	// add     r0, r0, r1
 	.word	0xe580d000	// str     sp, [r0]
 	.word	0xe580e004	// str     lr, [r0, #4]
@@ -54,7 +55,6 @@
 #else
 	.word   CONFIG_TEXT_BASE
 #endif
-	.word	fel_stash - .
 #else
 /* normal execution */
 	b	reset
-- 
2.46.3

