Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF1DC83F26
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 16:08:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1797B831AC;
	Tue, 29 Jul 2025 18:08:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="e66mZ6yW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7CF882BA1; Tue, 29 Jul 2025 18:08:19 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 107368323A
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 18:08:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3b78315ff04so2204494f8f.0
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 09:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753805295; x=1754410095; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6HCyeLbMOrm5QqAb5ko4m8uovTZ11dM1Qf+beTy9EXs=;
 b=e66mZ6yWc2TwA6i0Ody7OljtIV0KbDoMN87tfH6UNIhLZdX8c5+EZ7pmn2MIlfb8RZ
 HbV1EbMe+c+r351QBRDstaQIPhHuYJzNMcTeBktJRMwo+HC7utp6PKAyrtGnDQr6U4BM
 gemd35imcQwim9hZPqp+yq7hPs6iQIhxj2+n5HsjUYTI1ikkbFSSnYDe3Rsqk8WZhQJs
 Q+PLMiS6/4gCX/n4FmO8mZy6S6+KGqA3dMyCgnWZEnA0t1k4t+Q6KU+lni1O9ynO+fBr
 R5BN5vmNsqDxKGeoiFNHSrs8QI1xz6MjDuTyZ8VP6rTScdgGEbtsteRJiNS0D6dJHW9Z
 oFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753805295; x=1754410095;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6HCyeLbMOrm5QqAb5ko4m8uovTZ11dM1Qf+beTy9EXs=;
 b=Xl4E071OvOKt5HyWLnLEnhD2kpm2sUHxezsdFLtLQVHd2l69QfnPJEjuR0TN+kks/8
 AgU1tnezG3jYhW5JkNeRg9AROQ6b3ciKBG9CEHf/M4Nm9MEd8HVTV7jwchU17ZRzpuYu
 k6iajg+disQrtOB1aVvHpSX+RnU4ab2rVIsVlAhlWfCcyiOV0oGaUSYtUstJUQI/WxU9
 MpQM7Z5QNOok5XC23YFFjvDSyCZ3ulun2kojXDMvLwQAdTPeobbkM90Z89AsFSmBM7YY
 cZEaIoJc634tRorM6pmi5+8mniV9uzhCUXpxkq2AgypeVi9PDgZbejyiAaopWyoCaZkr
 uD1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5Ng5RMIoZ6HI8j+lyJJ1GKha2/r5H0DUA9DeKLz3vXUszwOeYAYqOvR/XZ1aPIxtUoEnbNJY=@lists.denx.de
X-Gm-Message-State: AOJu0YwMfWbrm0ey1ogd1jHnAwR97a0lIRybA+yqWp/3oYAHKkbCcno7
 SrUyAjlAeY3fu2r9L2zWEb4KHGwfXSG7S0Fb1pFU3IuZ2ExlG29yDZUFUyLUvqHZTWI=
X-Gm-Gg: ASbGncvRw0/T4S1yE3FoeLbspFocKSDdXsV5XWPjREjxlyxTpS4wTUJGmFLIBUlSV4o
 3Gjzz6r68MXyGfk6MNlxmQH2nUiYBmrM+qyn0TFyZ4ywKtbjyWi7/x1XoJrNFfvKoltUyV9A26x
 kyyZ+SJGbRTA9jZVJeBad7deOauz3T0J3fYRuN9fbknZpAMwJSe9QpwNF+Vv0QMLXxj9duJM5iM
 Qet8WSjB50Yt8YMxV/BM9DX4ESrT2I6E7IA5+dkB73mg9hIaaQ/u8o7zaW5b5z74982GyQPvdKZ
 uinxZw1km7bpLvatt72u3tU798VWL6CZU8/4QpWd/uSUlLY8DNY6WgcS8SmyU3lEAbDrTo/VsTO
 5hndd6Mn1oiEDnKICl/SfqwZSq1ODM9+2x5TnKjiMVNfnRJ2RnDCVn4VfB9MpA7nbdwCql2smdW
 lJDu+KjK5+sQ==
X-Google-Smtp-Source: AGHT+IG3cUj6nB+361OPPKanX+iYdljA+QfR9hiNXI2/i0HhM8PGtfVoiJPBST+NTJP2f/gDF7l4ew==
X-Received: by 2002:a05:6000:290f:b0:3a5:2599:4178 with SMTP id
 ffacd0b85a97d-3b794fee7camr162556f8f.19.1753805295332; 
 Tue, 29 Jul 2025 09:08:15 -0700 (PDT)
Received: from toyger.tail248178.ts.net (ip-185-104-138-124.ptr.icomera.net.
 [185.104.138.124]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b781d2fc1csm10512075f8f.5.2025.07.29.09.08.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 09:08:14 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Tue, 29 Jul 2025 18:07:29 +0200
Subject: [PATCH v5 08/10] arm64: implement printing backtraces with symbols
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-b4-arm64-backtrace-symbols-v5-8-0009c4620a46@linaro.org>
References: <20250729-b4-arm64-backtrace-symbols-v5-0-0009c4620a46@linaro.org>
In-Reply-To: <20250729-b4-arm64-backtrace-symbols-v5-0-0009c4620a46@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.denx.de
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5835;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=z0SPONuy9LdOUPCYjZeEQth+BksbBsBlrbEhOSq6Nws=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoiPHC7dFxnXPfXBx1rX+/nIywqkzC1n+Hvf5s/
 IdwxTyxT2iJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaIjxwgAKCRAFgzErGV9k
 tnScEACKY0lVLPTkXDuOjubKJtNeTjbcA46HJRR3paiQ37FA0wL3r1eQ9HrCf6OcuQ11Og5Q1nh
 po5VQ9pvVGq/Dl4GudQ7uHc4OsQC5UBoJKCI7WGwHGcDlJNhAYjwrrghsa1QQQjrOWOBM28WZQk
 Cld+WvwRXFXmbt5+rGsRKTg73Q80DJf9Hxq8FcRpmVqkMbJg4zTU6fpIv9qu+OFXFjWy5s/cBEp
 Ztpw3BLrY87Ahx0Ul4jg8fmuSy3iE0g/YF+3+i/50A0wxvayvA3DYVb0M50I+GWeBjlPf80k3EH
 ZkxkqSoltI+sTV8ppm8hyuiqJRGUT6SvdUQr4MpGinIuW+Y/vqETzHYRxaybLv99VegP+GCSSIo
 YpvCAl6re9zEifrRcJvXmqS2i1oCN0LU5ImU/t7f1v5SLKMedkWjL/G+DiupMRx1uN4TSRlqPOy
 rKOt1DDgmTdhlyHTsG1CAjbkYrMJ6i7MaAeHKEpT0XXdrptbOF3GmMeKSIb5jwkQUbGukpodCCr
 kRwceOW+ergX7sRzYNDwFpwBIJRYSzc0Xdwk811Vxcg5BE+0WC5wINw1qfROofprDHAkJUpBxZX
 1/g3pxg5rSY8uAOvcsTHOxtjPHfSt2Uf2+NZ5ZtaAXSUpRGnYvI+U7Kg+uhq0qi2ji+OBFec7Bp
 hr0ChJ268uGG4YA==
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
 arch/arm/Makefile            |  9 +++++-
 arch/arm/lib/interrupts_64.c | 77 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+), 1 deletion(-)

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
index d13ee8d9f81dc8c41ef4732167663b223ab6ab3b..973ade4b3b2b649b76fa6b67742a247dbacf7ffa 100644
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
@@ -97,8 +99,79 @@ void show_regs(struct pt_regs *regs)
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
+	/* Print the symbol address and the offset to the LR */
+	printf("\t<%#016lx> %pS\n", lr - (gd->flags & GD_FLG_RELOC ? gd->reloc_off : 0),
+	       (void *)lr);
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
@@ -152,8 +225,10 @@ static void except_msg(const char *msg, struct pt_regs *pt_regs)
 {
 	efi_restore_gd();
 	printf("%s handler, esr 0x%016lx\n", msg, pt_regs->esr);
 	show_regs(pt_regs);
+	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
+		show_backtrace(pt_regs->elr, pt_regs->regs[30], pt_regs->regs[29]);
 	show_efi_loaded_images(pt_regs);
 	panic("Resetting CPU ...\n");
 }
 
@@ -201,8 +276,10 @@ void do_sync(struct pt_regs *pt_regs)
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

