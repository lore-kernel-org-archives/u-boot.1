Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF2DAC83F26
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 15:51:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C8D4829E7;
	Tue, 29 Jul 2025 17:50:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="D9tTjJgJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F038382E05; Tue, 29 Jul 2025 17:50:40 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B69981E14
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 17:50:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-451d41e1ad1so35184215e9.1
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 08:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753804238; x=1754409038; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uFqhoEYM9bhzFZlJ7lu5+RBzFlVl6BUg3JG31C46fOg=;
 b=D9tTjJgJ6TZnmSMbkLJ+b+6RFizoxTRVyFzQ5KVl+QZY1v+sCUa/5ewXGdpcKvAxOn
 E4KDKMbih+QEBK9Z14G6boaxwipCZuUdAuVvIJV191b9V+N+vtKTNG0EjjL+CZTKQOLY
 zSt1qF6xG3BTB4mfNXVSxf8ZcTZCf4lFnb6PVLatvQZ/ouSmsdH3mE9GW2umA0vYHeg9
 RgRO5308ZhRjIFRAfuRrBD+qRWhC5LPpsgA+cS34QGSFTX1bgGFfaWdKix4BgbedpzJz
 KoB3Pdd/37CGMcHtQn9FYosXEp3IS343X0tdmXS0fHFfWH9eVnzXV6/NV+7EPz77XmkW
 Wm/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753804238; x=1754409038;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uFqhoEYM9bhzFZlJ7lu5+RBzFlVl6BUg3JG31C46fOg=;
 b=TXANjvRoFgi320Lzr3H/6YSqLqMydan8lIZU+ESQYkjPOV9ywkQNOPSnSTVbtvDPix
 +zfdtUA6uZlcay47zJUv6HuD/olinv7ShlI2DHOeZGXnl/xTt3NgdIUnmWC9B6DFAILC
 ua9kKbXlZfU+sp7tOQ7vaxy6mvFxDzBErrCdxJGbRFJkwND5vs+21WARHaOxQiGv71XH
 8nXyHib+RuY4NzyC0M8bElPTPMrd01DJPCkcOI9iS1H+SRqyOlkxSs0otQ92hdr1CcuY
 yWIzkxTcxbVX2jH2bmrjK+Gfz4q7N3LSCJJpYvQVrlWUNu7r1wrz8pptD3bjWKchk1mZ
 Uslw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCR2i3kjEy5kn8cN5Ow08/HzvDbddNAF8M6BvJ7ZZ1SN8keV8/pwBWz4shIgXjmKfx1WxlqmI=@lists.denx.de
X-Gm-Message-State: AOJu0YzMkoq6xmdTO950t1nbBeM8LBfp6i6Mej4OZnpYZjpH4oD51wJ9
 uu/Ji4fdHeoKS+Y2ghlio/dMJCuA3alY+BBITMva5vhGSoBF2wsG5/qFXUbCO8PDpdc=
X-Gm-Gg: ASbGncuQQ7ePa9BQjJmUXYdA8m60h+zESEtUJPfBsk0XsZr9/1jm3KP4gb4uoId2vsw
 4cR90MZkXBsMH+Sh+bR8mK3Bxp80dbrBkgVlQ2uabiX7x+co9bdSIWOA7tLNxbFntH2jG3LB+rN
 B2Vxo9Kazhu8mCStgV8whcwhpiwGwDUEO45lWW7bF0kapnoMeXIDOUdzoJIagKNI1jD0V4+QVEG
 k0dxa1sggJMv4BR6tmYOfCQqWhp5RGg/ViRFbI89DUq5Aq8RwHXh32xhMsvQYC2ppWwOcKdgHwC
 VWmpV21190YRigHjUl3og6H6bnA0njZvew4zJQfQCTIAlI1rdNuUOyAJczSmosu3gaINNUwin/o
 kGRsQ/8EGJIElXfH4eK9Bw+nWdiR2a3BZ7JkVRJM0kSfZ4QmNYSVVmOiCSuNPuk6HxIB7ifD1HE
 4+Uu4e2XEtdQ==
X-Google-Smtp-Source: AGHT+IEYGI6hq3hJkkltmC0WuYMvhHJEPFCRxu4Agi6jLAT4/TvXhY7XcpoTVLizU2Goh+xXc73W6Q==
X-Received: by 2002:a05:600c:4fd3:b0:453:697:6f08 with SMTP id
 5b1f17b1804b1-45892bd1a95mr2613255e9.26.1753804237690; 
 Tue, 29 Jul 2025 08:50:37 -0700 (PDT)
Received: from toyger.tail248178.ts.net (ip-185-104-138-124.ptr.icomera.net.
 [185.104.138.124]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4588e5c1a2fsm30635875e9.12.2025.07.29.08.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 08:50:37 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Tue, 29 Jul 2025 17:50:06 +0200
Subject: [PATCH v3 08/10] arm64: implement printing backtraces with symbols
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-b4-arm64-backtrace-symbols-v3-8-6f258b34fe8c@linaro.org>
References: <20250729-b4-arm64-backtrace-symbols-v3-0-6f258b34fe8c@linaro.org>
In-Reply-To: <20250729-b4-arm64-backtrace-symbols-v3-0-6f258b34fe8c@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5964;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=NPBnqJVHwENhJhRXOFOyy8IjD0zGlZPYwDVyFQbyAr4=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoiO2rNP57gfRxqq0nOq6HVzaWmU8/WqyrLADXD
 SzTWule/AOJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaIjtqwAKCRAFgzErGV9k
 tge+EACG84wspF1UQhNLily6EysO/c/KPgbEZrV/0vA1RvJDtXbjfY+8zd2rFJ4JT1W1L98P3AC
 WouH5vLiuO5U38sgSBT48UDINqZ/i80DNqNgm2Y5I9uqdCEQ+tgHqt1PaC/RfUdCPqiOP9wycO+
 WRI2P7N/L74AjJPMnc9lDJmkIs81suZFE2n20+MFh/133xQrcr1NCul/zPB/9lauG+OKP+N6S7Y
 8il/S5ETqBrbdgepQwMTmqMmtUJivB3Nj608pPwgCcVb1CkBpGUBl+/Gw6MlA3yQPl/QQVKG5wb
 el3Dy3FlRjQGxPHrJl92Y7lO285VJ38/TwaufwU8frDabBkgAR2ndsOCGabSZFi1vcqQdtYmb/i
 Ni73WS/48uvlF7weHTEYH/5SncwlJg0xyuGjouLF0B3EI/Z/jrpLp/tgM4Edw0WtdIIFkes0KAo
 TPq3Iyl9qr2ZDeDGJfBM4e/XkFTqw0FwZypUa834M7cg0b133D9PSSydys0NmkfjygIKDtC0N6j
 IvPXYJjMdr3iYm/MI/gXy/b1xjehmDoXk8kvulcjK6FZDnEfh8QASyLwFBzLuPlZhPdYcT0KJOE
 Lwj2rOrLu05Dz1w+DXJrpFpsdUn9VyDK0tNoEDKNTikMZQhyFPut2L3z+fqZDI5bkOi/3GRI7TA
 AFFKD4mMfnqPAiQ==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Using the framepointer register and optional symbol lookup support, we
can now walk through the stack frames and print the link register values
(branch location) as well as the name of the function we branched from.

When symbol lookup support is disabled, we simply print the LR value to
still allow for manual lookups in a decompiled U-Boot binary.

In addition, print the address of _start and CONFIG_TEXT_BASE since they
are typically required to convert the runtime addresses to the addresses
in the U-Boot binary/ELF.
_start is used instead of relocaddr since it will be correct both pre
and post relocation.

Co-developed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 arch/arm/Makefile            |  9 ++++-
 arch/arm/lib/interrupts_64.c | 82 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 5ecadb2ef1bc46ffa68b04658168647eaad9bc97..41e75b5bcb1cd068501f118d72bdb1c486b6784f 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -32,8 +32,15 @@ endif
 
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
 tune-$(CONFIG_CPU_ARM926EJS)	=
@@ -46,9 +53,9 @@ tune-$(CONFIG_ARM64)		=
 
 # Evaluate tune cc-option calls now
 tune-y := $(tune-y)
 
-PLATFORM_CPPFLAGS += $(arch-y) $(tune-y)
+PLATFORM_CPPFLAGS += $(ARCH_FLAGS) $(arch-y) $(tune-y)
 
 # Machine directory name.  This list is sorted alphanumerically
 # by CONFIG_* macro name.
 machine-$(CONFIG_ARCH_AIROHA)		+= airoha
diff --git a/arch/arm/lib/interrupts_64.c b/arch/arm/lib/interrupts_64.c
index d13ee8d9f81dc8c41ef4732167663b223ab6ab3b..0f8ca7d343156bd53688bf4a0acd9437f041f8f5 100644
--- a/arch/arm/lib/interrupts_64.c
+++ b/arch/arm/lib/interrupts_64.c
@@ -3,15 +3,17 @@
  * (C) Copyright 2013
  * David Feng <fenghua@phytium.com.cn>
  */
 
+#include <asm-generic/sections.h>
 #include <asm/esr.h>
 #include <asm/global_data.h>
 #include <asm/ptrace.h>
 #include <irq_func.h>
 #include <linux/compiler.h>
 #include <efi_loader.h>
 #include <semihosting.h>
+#include <symbols.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
 int interrupt_init(void)
@@ -97,8 +99,84 @@ void show_regs(struct pt_regs *regs)
 	printf("\n");
 	dump_instr(regs);
 }
 
+/* Stack frames automatically generated by compiler emitted code */
+struct stack_frame {
+	struct stack_frame *prev;
+	unsigned long lr;
+	char data[];
+};
+
+static void print_sym(unsigned long lr)
+{
+	char symname[KSYM_NAME_LEN + 1] = { 0 };
+	unsigned long offset;
+
+	symbol_lookup(lr, NULL, &offset, symname);
+
+	/* Print the symbol address and the offset to the LR */
+	printf("\t<%#016lx> %s+%#lx\n", lr - (gd->flags & GD_FLG_RELOC ? gd->reloc_off : 0),
+	       symname, offset);
+}
+
+/**
+ * show_backtrace - show backtrace using frame pointers
+ * @elr: exception link register when called from an exception context
+ * @lr: link register (x30) of the current function
+ * @x29: frame pointer (x29) of the current function
+ */
+static void show_backtrace(unsigned long elr, unsigned long lr, unsigned long x29)
+{
+	struct stack_frame *fp = (struct stack_frame *)x29;
+
+	/* If we're pre-relocation then _start and text base might be the same */
+	if (CONFIG_TEXT_BASE && CONFIG_TEXT_BASE != (unsigned long)_start)
+		printf("\nCONFIG_TEXT_BASE   : %#lx\n", (unsigned long)CONFIG_TEXT_BASE);
+	printf("Relocated base addr: %#lx\n", (unsigned long)_start);
+	printf("Backtrace:\n");
+
+	/* ELR tells us where the exception occurred */
+	if (elr) {
+		printf("elr:");
+		print_sym(elr);
+	}
+
+	/*
+	 * LR tells us the calling function, for exceptions this is the function that called
+	 * the function where the exception occurred. For unwind_stack() case this is the caller
+	 * of unwind_stack().
+	 */
+	printf("lr:");
+	print_sym(lr);
+
+	/* Now we get the rest of the backtrace from the frame pointers */
+	while (fp) {
+		print_sym(fp->lr);
+		fp = fp->prev;
+	}
+	printf("\n");
+}
+
+/**
+ * unwind_stack() - Unwind the callstack and print a backtrace.
+ *
+ * This function can be called for debugging purposes to walk backwards through
+ * stack frames, printing the function name and offset of the branch instruction.
+ *
+ * It reads out the link register (x30) which contains the return address of the
+ * caller, and x29 which contains the frame pointer of the caller.
+ */
+void unwind_stack(void)
+{
+	unsigned long x29, x30;
+
+	asm("mov %0, x29" : "=r" (x29));
+	asm("mov %0, x30" : "=r" (x30));
+
+	show_backtrace(0, x30, x29);
+}
+
 /*
  * Try to "emulate" a semihosting call in the event that we don't have a
  * debugger attached.
  */
@@ -152,8 +230,10 @@ static void except_msg(const char *msg, struct pt_regs *pt_regs)
 {
 	efi_restore_gd();
 	printf("%s handler, esr 0x%016lx\n", msg, pt_regs->esr);
 	show_regs(pt_regs);
+	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
+		show_backtrace(pt_regs->elr, pt_regs->regs[30], pt_regs->regs[29]);
 	show_efi_loaded_images(pt_regs);
 	panic("Resetting CPU ...\n");
 }
 
@@ -201,8 +281,10 @@ void do_sync(struct pt_regs *pt_regs)
 	printf("\"Synchronous Abort\" handler, esr 0x%016lx", pt_regs->esr);
 	dump_far(pt_regs->esr);
 	printf("\n");
 	show_regs(pt_regs);
+	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
+		show_backtrace(pt_regs->elr, pt_regs->regs[30], pt_regs->regs[29]);
 	show_efi_loaded_images(pt_regs);
 	panic("Resetting CPU ...\n");
 }
 

-- 
2.50.0

