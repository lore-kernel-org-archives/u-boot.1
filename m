Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A2E2C77B7C
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 05:20:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AB2D82F4E;
	Thu,  3 Jul 2025 07:20:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Znsuylww";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E961882CFA; Thu,  3 Jul 2025 07:20:15 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D56D882F00
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 07:20:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 0611040B5C; 
 Thu,  3 Jul 2025 05:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1751520004;
 bh=eB9r59Iya2fMxQ7OAIFtBP8Bc3H5wwjAaPdzgAQOjKc=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=ZnsuylwwGKkq0w0e1e90LOq+8hr8qrWQgYSH/Fr5oi4uVgmieicfrxT6ygQWVwcTY
 rM8N4zYTSSwqdr2cy2La6BeceB9ZeiKbESC5AeGXNhkFaUgW8FSYxJa5TcHm7XdUfz
 R8eX6uT4LT91x7KImZK6iw2ESx4Kb1r/QVDL7teAM+14fjTapWA0B0OuEbUDSOj5UR
 alLP4/6mL1OSjClF9OgjymTRD4afq1Pg/ByeP3K4AGrub5sbBXs0xzwrg/GMybIVxH
 EjMFIwKrB4yoCTf9927QyRari4EnbGUQZMyhQvd+ee9bXk6iAMr2HhMJB4GxDACskb
 /oi2i8/z518BA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ben Dooks <ben.dooks@codethink.co.uk>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 3/5] arm64: implement printing backtraces
Date: Thu,  3 Jul 2025 07:19:49 +0200
Message-ID: <20250703051951.43372-4-heinrich.schuchardt@canonical.com>
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

Add a function to print frame pointers depending on symbols
CONFIG_(SPL)_FRAMEPOINTER.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/arm/Makefile            |  9 ++++++-
 arch/arm/lib/interrupts_64.c | 46 ++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 5ecadb2ef1b..41e75b5bcb1 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -33,6 +33,13 @@ endif
 # Evaluate arch cc-option calls now
 arch-y := $(arch-y)
 
+ifeq ($(CONFIG_$(PHASE_)FRAMEPOINTER),y)
+	ARCH_FLAGS += -fno-omit-frame-pointer
+endif
+
+PLATFORM_CPPFLAGS	+= $(ARCH_FLAGS)
+CFLAGS_EFI		+= $(ARCH_FLAGS)
+
 # This selects how we optimise for the processor.
 tune-$(CONFIG_CPU_ARM720T)	=-mtune=arm7tdmi
 tune-$(CONFIG_CPU_ARM920T)	=
@@ -47,7 +54,7 @@ tune-$(CONFIG_ARM64)		=
 # Evaluate tune cc-option calls now
 tune-y := $(tune-y)
 
-PLATFORM_CPPFLAGS += $(arch-y) $(tune-y)
+PLATFORM_CPPFLAGS += $(ARCH_FLAGS) $(arch-y) $(tune-y)
 
 # Machine directory name.  This list is sorted alphanumerically
 # by CONFIG_* macro name.
diff --git a/arch/arm/lib/interrupts_64.c b/arch/arm/lib/interrupts_64.c
index b3024ba514e..970f8b6831f 100644
--- a/arch/arm/lib/interrupts_64.c
+++ b/arch/arm/lib/interrupts_64.c
@@ -98,6 +98,35 @@ void show_regs(struct pt_regs *regs)
 	dump_instr(regs);
 }
 
+/**
+ * show_backtrace() - show backtrace using frame pointers
+ *
+ * @regs - registers
+ */
+static void show_backtrace(struct pt_regs *regs)
+{
+	void **fp = (void **)regs->regs[29];
+	unsigned int count = 0;
+	void *lr;
+
+	printf("\nbacktrace:\n");
+
+	while (fp) {
+		lr = fp[1];
+		printf("%3d: fp: %p lr: %p",
+		       count, fp, lr);
+
+		if (gd && gd->flags & GD_FLG_RELOC)
+			printf(" - %p (reloc)\n", lr - gd->reloc_off);
+		else
+			printf("\n");
+
+		fp = fp[0];
+		++count;
+	}
+	printf("\n");
+}
+
 /*
  * Try to "emulate" a semihosting call in the event that we don't have a
  * debugger attached.
@@ -149,6 +179,8 @@ void do_bad_sync(struct pt_regs *pt_regs)
 	printf("Bad mode in \"Synchronous Abort\" handler, esr 0x%08lx\n",
 	       pt_regs->esr);
 	show_regs(pt_regs);
+	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
+		show_backtrace(pt_regs);
 	show_efi_loaded_images(pt_regs);
 	panic("Resetting CPU ...\n");
 }
@@ -161,6 +193,8 @@ void do_bad_irq(struct pt_regs *pt_regs)
 	efi_restore_gd();
 	printf("Bad mode in \"Irq\" handler, esr 0x%08lx\n", pt_regs->esr);
 	show_regs(pt_regs);
+	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
+		show_backtrace(pt_regs);
 	show_efi_loaded_images(pt_regs);
 	panic("Resetting CPU ...\n");
 }
@@ -173,6 +207,8 @@ void do_bad_fiq(struct pt_regs *pt_regs)
 	efi_restore_gd();
 	printf("Bad mode in \"Fiq\" handler, esr 0x%08lx\n", pt_regs->esr);
 	show_regs(pt_regs);
+	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
+		show_backtrace(pt_regs);
 	show_efi_loaded_images(pt_regs);
 	panic("Resetting CPU ...\n");
 }
@@ -185,6 +221,8 @@ void do_bad_error(struct pt_regs *pt_regs)
 	efi_restore_gd();
 	printf("Bad mode in \"Error\" handler, esr 0x%08lx\n", pt_regs->esr);
 	show_regs(pt_regs);
+	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
+		show_backtrace(pt_regs);
 	show_efi_loaded_images(pt_regs);
 	panic("Resetting CPU ...\n");
 }
@@ -202,6 +240,8 @@ void do_sync(struct pt_regs *pt_regs)
 	dump_far(pt_regs->esr);
 	printf("\n");
 	show_regs(pt_regs);
+	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
+		show_backtrace(pt_regs);
 	show_efi_loaded_images(pt_regs);
 	panic("Resetting CPU ...\n");
 }
@@ -214,6 +254,8 @@ void do_irq(struct pt_regs *pt_regs)
 	efi_restore_gd();
 	printf("\"Irq\" handler, esr 0x%08lx\n", pt_regs->esr);
 	show_regs(pt_regs);
+	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
+		show_backtrace(pt_regs);
 	show_efi_loaded_images(pt_regs);
 	panic("Resetting CPU ...\n");
 }
@@ -226,6 +268,8 @@ void do_fiq(struct pt_regs *pt_regs)
 	efi_restore_gd();
 	printf("\"Fiq\" handler, esr 0x%08lx\n", pt_regs->esr);
 	show_regs(pt_regs);
+	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
+		show_backtrace(pt_regs);
 	show_efi_loaded_images(pt_regs);
 	panic("Resetting CPU ...\n");
 }
@@ -241,6 +285,8 @@ void __weak do_error(struct pt_regs *pt_regs)
 	efi_restore_gd();
 	printf("\"Error\" handler, esr 0x%08lx\n", pt_regs->esr);
 	show_regs(pt_regs);
+	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
+		show_backtrace(pt_regs);
 	show_efi_loaded_images(pt_regs);
 	panic("Resetting CPU ...\n");
 }
-- 
2.48.1

