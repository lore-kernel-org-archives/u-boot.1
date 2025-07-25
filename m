Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E20BC87FCA
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 12:58:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E17B68397F;
	Fri, 25 Jul 2025 14:57:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="o6QaMfGn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EAD081E06; Fri, 25 Jul 2025 14:57:38 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43D6B839A5
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 14:57:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-455ecacfc32so9549855e9.3
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 05:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753448256; x=1754053056; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mOju8Z28VGOc6AuuR+5Q3XIFwQR05A9ViZBTn8BIZ4w=;
 b=o6QaMfGnNuYRqCCBmjTbkx5KwB2ojqFXPgkR9fV33cqyEPHB7WgVMHhb4/PyPvBmWn
 zJqiAySwdHLQybfwbhpocV77urW6e8IKf6i8HLbZBCdBS4HBQuY59MTDvdzKcDKhSUd2
 dnF5LHAjVctLrYJde++GrlWxSBllBsvsdWQ2LbXEsB7acSpUo5jolcLORCRwF23ICHbt
 wU286CidqxLSNkfiw91tt2rg4fRudroODv3YSXU2l7NpDWNxZb+DgvMJlOckE2gpf5j3
 Z8LQdbPRcw1b76Do77+Y5zi4cgD/d0T3sdfQNOEyr97CxzIEdEcug/T7x397eG1phtqd
 14GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753448256; x=1754053056;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mOju8Z28VGOc6AuuR+5Q3XIFwQR05A9ViZBTn8BIZ4w=;
 b=jrQOR9aQhuInz7B4Shv4o2TJFpzKgtnCgP6FhlZ8d17yfkxSE4QjF1ahdZVqHwVL3r
 g5lmdahwdYfY5LhofKzWLGLp0HdZwEzOIhZnADycKGNwFFIWnDtixEFq5f7suN+c+gqn
 cZJWFOEIt/zI8smk+4VJkXU75Sdendt/evt2hcDMwCN5t5ebF0oJeH4X+CbIkB6eq59m
 pwz1PR+XiIz8IbrTQme/t+OFmqkf1vog6c80dJq3WsSsAu0IwrOsda1F4raIub37AUtG
 eGIGhQzbiyu4Zmr2O0Uoi5+WxuTStxLg0ejPkFTqNESn1ZmdmGXAIX29sxW+1aZ/FoQc
 9Njw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJhNEa23qiT8YMq5QU/BgMaOVjkzBxUHZ8DhLRGHQXmzoGorpY7PgFya86AZZtEwfbK7MlaHw=@lists.denx.de
X-Gm-Message-State: AOJu0Yy8iDnSIQAt1m6Up1OrSZK6CvD9KrmNFHYSX7wy4YgLZ5kkJi+h
 OXUDzdlb/eaPyF0ED6FP2lpY5InUgK/txh8Q4r5w7o4aGCOf/O2GfG9HOQZVEoYH/r4=
X-Gm-Gg: ASbGncsaSdXTl7nbIX6MQDFEBOPvG/o6AjCpiqYInN6kqCMa0LOjN2ZJCBTSj+CAcUc
 QEf0ivtB3Phu80v/AeqHL6BwUFc1Yq92t7Kbu+5ZlDxit3Zh3Ah2d6cst6B5wDh8Lm9NAB3MqEA
 MEqs662c4p1YDDCCSlzuIK21bQfcLlOtJlk5B+adcktmfsE7Tg3tgJfyBEvWYIEcyJ8aeMAqp5D
 xAtI6Tx4+Fqssxtl4qud+iq8Gu7BQmRdtAGecYlVelGHmLW6xHIr3DlBRUZpb4rTYZybYT3NLLp
 8Xaort3L2HJH/PONIcYJM5tY6BNPdEYgtordnwBP90VbHEHFOCw4JRFNLvaCNj6IXkDW4BFU8ei
 rUfS4KK4vWEqlvr+5iV+b1Ae8E4TyaysGubgdw6ETtnGEDhzDrGMmIj8oFxuAqGsZKg==
X-Google-Smtp-Source: AGHT+IEiv26qKufkGgF/C9yaJY4LOO1dv+U2lwYEgaP87JeSqzdkmXS6aUEdtkPBjG7vcJjOAPw0ZA==
X-Received: by 2002:a05:600c:1e2a:b0:456:2832:f98d with SMTP id
 5b1f17b1804b1-45876556361mr16222665e9.27.1753448255562; 
 Fri, 25 Jul 2025 05:57:35 -0700 (PDT)
Received: from lion.localdomain (p549d4bd0.dip0.t-ipconnect.de.
 [84.157.75.208]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458705c4fcfsm53115355e9.29.2025.07.25.05.57.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 05:57:34 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Fri, 25 Jul 2025 14:57:10 +0200
Subject: [PATCH v2 6/7] arm64: implement printing backtraces with symbols
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250725-b4-arm64-backtrace-symbols-v2-6-230a9665085b@linaro.org>
References: <20250725-b4-arm64-backtrace-symbols-v2-0-230a9665085b@linaro.org>
In-Reply-To: <20250725-b4-arm64-backtrace-symbols-v2-0-230a9665085b@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7831;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=XLi8HRoOfG+ja2aHjFEmQk9LbCK635oY64kzQk2vjPk=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhozmerMJsRGXZj5UXLx5Xnii1cPpm24kpR5cJp97PeDqt
 H+Objr2HaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAiegsY/umJZR2Zy7Z0quOX
 BhkrEwX3xWsXPi8w8N/u8S/+iy1PayTDb7aARXyPm7qi7vofu2GYceXD+ahY/9LYKzyfnDlc18i
 KxwAA
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
 arch/arm/lib/interrupts_64.c | 83 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 5ecadb2ef1bc..41e75b5bcb1c 100644
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
index b3024ba514ec..6cb16811566a 100644
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
@@ -97,8 +99,73 @@ void show_regs(struct pt_regs *regs)
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
+static void print_sym(unsigned long symaddr, const char *symname, unsigned long offset)
+{
+	if (!CONFIG_IS_ENABLED(SYMBOL_LOOKUP) || symname[0] == '?')
+		/* If the symbol is not found, symaddr will just be the link register address */
+		printf("\t(%#016lx)\n", symaddr);
+	else
+		/* Print the symbol address and the offset to the LR */
+		printf("\t<%#016lx> %s+%#lx\n", symaddr, symname, offset);
+}
+
+/**
+ * show_backtrace - show backtrace using frame pointers
+ * @lr: link register (x30) of the current function
+ * @x29: frame pointer (x29) of the current function
+ */
+static void show_backtrace(unsigned long lr, unsigned long x29)
+{
+	struct stack_frame *fp = (struct stack_frame *)x29;
+	char symname[KSYM_NAME_LEN + 1] = { 0 };
+	unsigned long symaddr, offset;
+
+	/* If we're pre-relocation then _start and text base might be the same */
+	if (CONFIG_TEXT_BASE && CONFIG_TEXT_BASE != (unsigned long)_start)
+		printf("\nCONFIG_TEXT_BASE   : %#lx\n", (unsigned long)CONFIG_TEXT_BASE);
+	printf("Relocated base addr: %#lx\n", (unsigned long)_start);
+	printf("Backtrace:\n");
+
+	/* Before walking the framepointers, print the calling function from the link register */
+	symbol_lookup((unsigned long)lr, &symaddr, &offset, symname);
+	print_sym(symaddr, symname, offset);
+
+	while (fp) {
+		symbol_lookup((unsigned long)fp->lr, &symaddr, &offset, symname);
+		print_sym(symaddr, symname, offset);
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
+	show_backtrace(x30, x29);
+}
+
 /*
  * Try to "emulate" a semihosting call in the event that we don't have a
  * debugger attached.
  */
@@ -148,8 +215,10 @@ void do_bad_sync(struct pt_regs *pt_regs)
 	efi_restore_gd();
 	printf("Bad mode in \"Synchronous Abort\" handler, esr 0x%08lx\n",
 	       pt_regs->esr);
 	show_regs(pt_regs);
+	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
+		show_backtrace(pt_regs->regs[30], pt_regs->regs[29]);
 	show_efi_loaded_images(pt_regs);
 	panic("Resetting CPU ...\n");
 }
 
@@ -160,8 +229,10 @@ void do_bad_irq(struct pt_regs *pt_regs)
 {
 	efi_restore_gd();
 	printf("Bad mode in \"Irq\" handler, esr 0x%08lx\n", pt_regs->esr);
 	show_regs(pt_regs);
+	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
+		show_backtrace(pt_regs->regs[30], pt_regs->regs[29]);
 	show_efi_loaded_images(pt_regs);
 	panic("Resetting CPU ...\n");
 }
 
@@ -172,8 +243,10 @@ void do_bad_fiq(struct pt_regs *pt_regs)
 {
 	efi_restore_gd();
 	printf("Bad mode in \"Fiq\" handler, esr 0x%08lx\n", pt_regs->esr);
 	show_regs(pt_regs);
+	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
+		show_backtrace(pt_regs->regs[30], pt_regs->regs[29]);
 	show_efi_loaded_images(pt_regs);
 	panic("Resetting CPU ...\n");
 }
 
@@ -184,8 +257,10 @@ void do_bad_error(struct pt_regs *pt_regs)
 {
 	efi_restore_gd();
 	printf("Bad mode in \"Error\" handler, esr 0x%08lx\n", pt_regs->esr);
 	show_regs(pt_regs);
+	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
+		show_backtrace(pt_regs->regs[30], pt_regs->regs[29]);
 	show_efi_loaded_images(pt_regs);
 	panic("Resetting CPU ...\n");
 }
 
@@ -201,8 +276,10 @@ void do_sync(struct pt_regs *pt_regs)
 	printf("\"Synchronous Abort\" handler, esr 0x%08lx", pt_regs->esr);
 	dump_far(pt_regs->esr);
 	printf("\n");
 	show_regs(pt_regs);
+	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
+		show_backtrace(pt_regs->regs[30], pt_regs->regs[29]);
 	show_efi_loaded_images(pt_regs);
 	panic("Resetting CPU ...\n");
 }
 
@@ -213,8 +290,10 @@ void do_irq(struct pt_regs *pt_regs)
 {
 	efi_restore_gd();
 	printf("\"Irq\" handler, esr 0x%08lx\n", pt_regs->esr);
 	show_regs(pt_regs);
+	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
+		show_backtrace(pt_regs->regs[30], pt_regs->regs[29]);
 	show_efi_loaded_images(pt_regs);
 	panic("Resetting CPU ...\n");
 }
 
@@ -225,8 +304,10 @@ void do_fiq(struct pt_regs *pt_regs)
 {
 	efi_restore_gd();
 	printf("\"Fiq\" handler, esr 0x%08lx\n", pt_regs->esr);
 	show_regs(pt_regs);
+	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
+		show_backtrace(pt_regs->regs[30], pt_regs->regs[29]);
 	show_efi_loaded_images(pt_regs);
 	panic("Resetting CPU ...\n");
 }
 
@@ -240,7 +321,9 @@ void __weak do_error(struct pt_regs *pt_regs)
 {
 	efi_restore_gd();
 	printf("\"Error\" handler, esr 0x%08lx\n", pt_regs->esr);
 	show_regs(pt_regs);
+	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
+		show_backtrace(pt_regs->regs[30], pt_regs->regs[29]);
 	show_efi_loaded_images(pt_regs);
 	panic("Resetting CPU ...\n");
 }

-- 
2.50.1

