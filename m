Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA535C77B7C
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 05:20:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C3A482F7F;
	Thu,  3 Jul 2025 07:20:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="U1TIJwTS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A96E280E9A; Thu,  3 Jul 2025 07:20:17 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A37CF82F30
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 07:20:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id AC2D840B63; 
 Thu,  3 Jul 2025 05:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1751520008;
 bh=n3rMoMGG7phC2PyYrp8jQh28nX1hu5LMKFlI6fHUAK8=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=U1TIJwTSrZp4SIvyc02U+Vjp70odkJXTkJbLeUto5vOAIPO0zkYUgmF9Y43jRFY8q
 lEXlJNy985AvLRsCKVqGckpyX9nB/q3rcEAsODYoe3mShT+JfER+l4E0UnhElPKic9
 i7nRIRMScO5xaXduK6u+VY1elhAASHjxcyudKD9jdCvBFKcFqi8unVR73qd7NL3TTt
 r4W7OA+dt04SHdAB7SLYnzr1IitsOgciIfoBGni8wNw2/bxTLusX47d3m1TtraJ9h9
 gULNtb7ZfsSsrqBLFtcl4XygHR4LI0jYeUWFS584HX0wQX5vecXoe/Ehite1qXXZS+
 5vf54Raf7plIA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ben Dooks <ben.dooks@codethink.co.uk>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 5/5] arm64: simplify interrupt code
Date: Thu,  3 Jul 2025 07:19:51 +0200
Message-ID: <20250703051951.43372-6-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250703051951.43372-1-heinrich.schuchardt@canonical.com>
References: <20250703051951.43372-1-heinrich.schuchardt@canonical.com>
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

Carve out a function except_msg() to handle the output for most type of
interrupts.

Consistently use 16 digits for printing the exception syndrome register
esr to match the register size.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/arm/lib/interrupts_64.c | 72 ++++++++++++------------------------
 1 file changed, 24 insertions(+), 48 deletions(-)

diff --git a/arch/arm/lib/interrupts_64.c b/arch/arm/lib/interrupts_64.c
index 970f8b6831f..cc20528327b 100644
--- a/arch/arm/lib/interrupts_64.c
+++ b/arch/arm/lib/interrupts_64.c
@@ -170,14 +170,18 @@ static bool smh_emulate_trap(struct pt_regs *regs)
 	return true;
 }
 
-/*
- * do_bad_sync handles the impossible case in the Synchronous Abort vector.
+/**
+ * except_msg() - print exception message
+ *
+ * Print exception message, register contents, backtrace, loaded EFI images.
+ *
+ * @msg:	message describing exception type
+ * @pt_regs:	registers
  */
-void do_bad_sync(struct pt_regs *pt_regs)
+static void except_msg(const char *msg, struct pt_regs *pt_regs)
 {
 	efi_restore_gd();
-	printf("Bad mode in \"Synchronous Abort\" handler, esr 0x%08lx\n",
-	       pt_regs->esr);
+	printf("%s handler, esr 0x%016lx\n", msg, pt_regs->esr);
 	show_regs(pt_regs);
 	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
 		show_backtrace(pt_regs);
@@ -185,18 +189,20 @@ void do_bad_sync(struct pt_regs *pt_regs)
 	panic("Resetting CPU ...\n");
 }
 
+/*
+ * do_bad_sync handles the impossible case in the Synchronous Abort vector.
+ */
+void do_bad_sync(struct pt_regs *pt_regs)
+{
+	except_msg("Bad mode in \"Synchronous Abort\"", pt_regs);
+}
+
 /*
  * do_bad_irq handles the impossible case in the Irq vector.
  */
 void do_bad_irq(struct pt_regs *pt_regs)
 {
-	efi_restore_gd();
-	printf("Bad mode in \"Irq\" handler, esr 0x%08lx\n", pt_regs->esr);
-	show_regs(pt_regs);
-	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
-		show_backtrace(pt_regs);
-	show_efi_loaded_images(pt_regs);
-	panic("Resetting CPU ...\n");
+	except_msg("Bad mode in \"Irq\"", pt_regs);
 }
 
 /*
@@ -204,13 +210,7 @@ void do_bad_irq(struct pt_regs *pt_regs)
  */
 void do_bad_fiq(struct pt_regs *pt_regs)
 {
-	efi_restore_gd();
-	printf("Bad mode in \"Fiq\" handler, esr 0x%08lx\n", pt_regs->esr);
-	show_regs(pt_regs);
-	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
-		show_backtrace(pt_regs);
-	show_efi_loaded_images(pt_regs);
-	panic("Resetting CPU ...\n");
+	except_msg("Bad mode in \"Fiq\"", pt_regs);
 }
 
 /*
@@ -218,13 +218,7 @@ void do_bad_fiq(struct pt_regs *pt_regs)
  */
 void do_bad_error(struct pt_regs *pt_regs)
 {
-	efi_restore_gd();
-	printf("Bad mode in \"Error\" handler, esr 0x%08lx\n", pt_regs->esr);
-	show_regs(pt_regs);
-	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
-		show_backtrace(pt_regs);
-	show_efi_loaded_images(pt_regs);
-	panic("Resetting CPU ...\n");
+	except_msg("Bad mode in \"Error\"", pt_regs);
 }
 
 /*
@@ -236,7 +230,7 @@ void do_sync(struct pt_regs *pt_regs)
 	    smh_emulate_trap(pt_regs))
 		return;
 	efi_restore_gd();
-	printf("\"Synchronous Abort\" handler, esr 0x%08lx", pt_regs->esr);
+	printf("\"Synchronous Abort\" handler, esr 0x%016lx", pt_regs->esr);
 	dump_far(pt_regs->esr);
 	printf("\n");
 	show_regs(pt_regs);
@@ -251,13 +245,7 @@ void do_sync(struct pt_regs *pt_regs)
  */
 void do_irq(struct pt_regs *pt_regs)
 {
-	efi_restore_gd();
-	printf("\"Irq\" handler, esr 0x%08lx\n", pt_regs->esr);
-	show_regs(pt_regs);
-	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
-		show_backtrace(pt_regs);
-	show_efi_loaded_images(pt_regs);
-	panic("Resetting CPU ...\n");
+	except_msg("\"Irq\"", pt_regs);
 }
 
 /*
@@ -265,13 +253,7 @@ void do_irq(struct pt_regs *pt_regs)
  */
 void do_fiq(struct pt_regs *pt_regs)
 {
-	efi_restore_gd();
-	printf("\"Fiq\" handler, esr 0x%08lx\n", pt_regs->esr);
-	show_regs(pt_regs);
-	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
-		show_backtrace(pt_regs);
-	show_efi_loaded_images(pt_regs);
-	panic("Resetting CPU ...\n");
+	except_msg("\"Fiq\"", pt_regs);
 }
 
 /*
@@ -282,11 +264,5 @@ void do_fiq(struct pt_regs *pt_regs)
  */
 void __weak do_error(struct pt_regs *pt_regs)
 {
-	efi_restore_gd();
-	printf("\"Error\" handler, esr 0x%08lx\n", pt_regs->esr);
-	show_regs(pt_regs);
-	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
-		show_backtrace(pt_regs);
-	show_efi_loaded_images(pt_regs);
-	panic("Resetting CPU ...\n");
+	except_msg("\"Error\"", pt_regs);
 }
-- 
2.48.1

