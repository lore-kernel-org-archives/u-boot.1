Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F95DE67806
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 05:36:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A018890FC;
	Sun,  3 Nov 2024 06:36:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="S4x24TOU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BB9688FB9; Sun,  3 Nov 2024 06:36:16 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98A5F890D5
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 06:36:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id DD41A3FDEF; 
 Sun,  3 Nov 2024 05:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1730612174;
 bh=rlEvLFVzMUjHmeAHg2iwzBqkz/eIz8L8daImaYm2JxI=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=S4x24TOUMHcDUpeh+J7edGclo/pDElvCy9l1upehF0NPTPArApGABUAF19x7f4zz1
 tP5KHgjEJ5Ih1OY4a/5QEGgR80EgGf+1R5qcBKLY7gS7DShhhKJM3ab/wgUUGE5fZI
 2Z/J7Oio4R9HBEypw7uQmpFg4pZz54kj8+iHXbmW1pt91YpUnMVDmPn2mNUb2jb4DH
 9Y34S9fRVtGtj3AdCP+L/HZx9WNcD7YImw0vlNl4S7QaVzeGHDAM9s6fCECe/a3RdM
 HDI7e3a/eHlE1DmW6piAe7SCWUBM6+xpHRnbrOWbNtrjGaEH8k5VxS1FwAkW8S3dJh
 A3syTTWS13POA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Kalen Brunham <kalen.brunham@intel.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/3] examples: fix building on arm64
Date: Sun,  3 Nov 2024 06:35:49 +0100
Message-ID: <20241103053551.52715-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241103053551.52715-1-heinrich.schuchardt@canonical.com>
References: <20241103053551.52715-1-heinrich.schuchardt@canonical.com>
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

Commit f9886bc60f42 ("Added arm64 assembly for examples/api crt0") tried to
add arm64 support to the examples but crt0.S does not even build for
qemu_arm64_defconfig with CONFIG_API=y, CONFIG_EXAMPLES=y:

    examples/api/crt0.S: Assembler messages:
    examples/api/crt0.S:32: Error:
        expected a register at operand 1 -- `ldr ip,=search_hint'
    examples/api/crt0.S:33: Error:
        unexpected register type at operand 1 -- `str sp,[ip]'
    make[2]: *** [scripts/Makefile.build:292: examples/api/crt0.o] Error 1

Do not define _start twice.
Use valid register names.
Move syscall_ptr and search_hint to the data section to avoid an invalid
relocation.

Fixes: f9886bc60f42 ("Added arm64 assembly for examples/api crt0")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 examples/api/crt0.S | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/examples/api/crt0.S b/examples/api/crt0.S
index 06f6d1f9ad4..f1b88ed8a3d 100644
--- a/examples/api/crt0.S
+++ b/examples/api/crt0.S
@@ -24,7 +24,7 @@ syscall:
 	mtctr	%r11
 	bctr
 
-#elif defined(CONFIG_ARM)
+#elif defined(CONFIG_ARM) && !defined(CONFIG_ARM64)
 
 	.text
 	.globl _start
@@ -33,26 +33,27 @@ _start:
 	str	sp, [ip]
 	b	main
 
-#elif defined(CONFIG_ARM64)
-
-              .text
-              .globl _start
-_start:
-              ldr           ip0, =search_hint
-              str           sp_el2, [ip0]
-              b             main
 
-
-              .globl syscall
+	.globl syscall
 syscall:
-              ldr           ip0, =syscall_ptr
-              ldr           pc_el2, [ip0]
+	ldr	ip, =syscall_ptr
+	ldr	pc, [ip]
 
+#elif defined(CONFIG_ARM64)
+
+	.text
+	.globl _start
+_start:
+	ldr	x17, =search_hint
+	mov	x16, sp
+	str	x16, [x17]
+	b	main
 
 	.globl syscall
 syscall:
-	ldr	ip, =syscall_ptr
-	ldr	pc, [ip]
+	ldr	x16, =syscall_ptr
+	ldr	x16, [x16]
+	br	x16
 
 #elif defined(CONFIG_MIPS)
 #include <asm/asm.h>
@@ -83,6 +84,8 @@ return_addr:
 #error No support for this arch!
 #endif
 
+.section .data
+
 	.globl syscall_ptr
 syscall_ptr:
 	.align	8
@@ -90,4 +93,4 @@ syscall_ptr:
 
 	.globl search_hint
 search_hint:
-	.long   0
+	.long	0
-- 
2.45.2

