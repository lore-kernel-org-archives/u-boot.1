Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5986DC87FC9
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 15:53:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75093831D8;
	Tue, 29 Jul 2025 17:52:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lJ7lezqu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DBF5831C8; Tue, 29 Jul 2025 17:52:55 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60F66831BB
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 17:52:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-45892deb25dso470005e9.1
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 08:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753804371; x=1754409171; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2Vm1Kf9FnWyQXequsCVuishhir3ePfrhUnNZWIH3+M0=;
 b=lJ7lezqu/oWdaKs653VkoT0J/NMHbN+1D8/CQHkLVU+qjwLwLLkHJ+3T5EszOuT9iV
 PbvgaSSAJfw99eAK2AcTAayV+QXHvkIm5vupsiQFi5tFXnYZVX8wLbGEudMpJrEd3fhq
 u60rXXTjT1fc2pwjw9c+3W7I11eztIpbnsRmItYLhGQTN9HbIgA0Lum7juQy0Ui4fz9z
 fWDszQHw6KdSuGk9FfJ4ib8tvIb2wz09yeTHlzbcRLRjTpKrwdjKGMgi/rYNGWzL2SXu
 WsxYcGBLq0mPk555e6rjESBb9yokOHy/mLHKGjIfvk2K20bQZ1/GuaRKkXtHhcv35xJX
 zzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753804371; x=1754409171;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Vm1Kf9FnWyQXequsCVuishhir3ePfrhUnNZWIH3+M0=;
 b=rnrAHXigtJOlC1GCRsVOj2O6dOkhatDRQ3pvmbzqE9r9uKoDanT0iQ8GHDDqzLwYOW
 zkYv/0U6Ev80TogubP0SgOGV+RGkAfCImw1CCWRkLOrvZBwSbpwaeVN504ZL6sFOWsJb
 plyPDSF/cKiIObwczWoAyg6QkOdX5mvXl0SitGk3gv1o/O7JS51yAmaiFAftRQadE5al
 1CSEssvzKxQ0En2z6fGroqGJ/eFh7KR9RekB2vtttkfs+UL7P4g5Ycy078FaRUJo5ob6
 Cn+Kd0mpiLFuRRZblv6oNgz2OS3mJz9zEoGIjDmnUw1K1JvxUloKIqgWv6MotK5GVlrO
 znxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWynTCs98B2FML5jM3J662F+T9cDKpkzr6PbUXHT9L+VNPvj44uUCWIxVxE5/s2iAwTX6ZFHEA=@lists.denx.de
X-Gm-Message-State: AOJu0YyG26HLUu6JHAVB/bDg3tOwUmFSBY/WfCwh1ipwLS7hjHuH6+eL
 dv4kJFqgDIo0G1WSmNZ9PIgg9Ggltsb5wdKBT+cTONgc7STf/mTSjOMyM+0fCZg8ZvkeVKwUL1k
 mWRqc
X-Gm-Gg: ASbGncvXwbvC5Wsn9gj7ZH0+EChbojKunJmflh1cocXv+mBsRm6pyABcnuFKpEMKL5G
 45xXM/Q+u6C+YZ11M37reszcezLKNxxtGPREfyCCpESgugM+3R2UaBSRV2lao+i21yQcDY25I+P
 G4WDHhmmQBNvlChrO64pY/RuA0tOlHlJUAIM3VadSonmvaB6CH4bg5W/bQlysgzGg8LTWp4Yn3j
 2v4xrM7+/ZX3l7n8U9YCFb+tOhPapO6CWNaCflWqX6VepT5ntFehzBt1vvi7NOvqhjcdkHBxdiW
 AXif/DyEWlkOtkQ2N7PGNcbtzd/2p3p7K281M2hTaHXj8/TsBneIpAQf03KoZxi/yS9Z9uqGLTG
 6wJ5GJWxPm9i2OP1fECSGqd5qFWSFjVmoUm15eDyuRr/X7Q7Aq1PTZ3D+9gfM9zln7RQ5mFBy40
 n01GNJcVyZeHGnQIW8EoOz
X-Google-Smtp-Source: AGHT+IHIyH/mHqffVwtyhx/Pwoe6JGFsFTEu/GIw+nOau8hsDYncxU2DcGOuqHcF/O/NWaQlEvg3eg==
X-Received: by 2002:a05:600c:810c:b0:456:f9f:657 with SMTP id
 5b1f17b1804b1-45892bcfb1amr2609605e9.27.1753804371419; 
 Tue, 29 Jul 2025 08:52:51 -0700 (PDT)
Received: from toyger.tail248178.ts.net (ip-185-104-138-124.ptr.icomera.net.
 [185.104.138.124]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4588dda59cfsm18948535e9.3.2025.07.29.08.52.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 08:52:50 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Tue, 29 Jul 2025 17:52:06 +0200
Subject: [PATCH v4 08/10] arm64: implement printing backtraces with symbols
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-b4-arm64-backtrace-symbols-v4-8-8d8bda8e22c1@linaro.org>
References: <20250729-b4-arm64-backtrace-symbols-v4-0-8d8bda8e22c1@linaro.org>
In-Reply-To: <20250729-b4-arm64-backtrace-symbols-v4-0-8d8bda8e22c1@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5844;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=32gzmMZLwsCDU/kN0Div80xllFvWa9Rr47UxkUylazI=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoiO4kc2QBXB9cfRv56NGk/f/i+lj9R4ziLo5zz
 fYW4NXiH/KJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaIjuJAAKCRAFgzErGV9k
 thgkD/42Py6LhLIUrwndmwZhPaSujPTgCN9SUEN6rrEeTyMNW8BjTI3vqObdo/8tKP0trXOpd8+
 CM2daax1sD6E3O5OLwUJGAfwsByuK+g6OMmx6XMfZ3FusZ95mxYlQlJejU2brcfSDBl5PRiEES2
 M/xK9k4sycJshPLWZVdHrwQe1Ps81kx/Ib0R1aenRslEuTbohSKoIH6w1He6VNXR2h8CioNcce1
 ZfoFjr8loJgfndesgGGxjm7yEWItdfS0ZVgoxJg1ZNdgK48BTX/6SgbvCwe8bMxJAMj9+392VHV
 +gtRupbRcytiiXjw0pXw+wAy4WCY+bWL4zngAAOQjF5IP8O9uo6M/DyQm5Ex0aYl7FlAiMDsGnP
 Puw5YKfbdJPVUx0zjsYCjYsA/LlVS7K1IIRzEEksc7dbrWhpee/0CufPGqfym4nc842UJ+6HMUg
 zTz0OWTFHtTzIxTk0syiy2wZrx4AEGQrZW7KZnsJWxcWZDOcxrrNr2uK1RKDmBjwQwqK/TCpa5W
 w8gLBwYwWxVESH14Je5AjsUyn9WmSvOQhZTFFTtrvQfHXbEdSLtj4rqqkbtiWBWme3Bs9R7A/P+
 v4CLqyD925l60+EOyEOzPgJ/3E1aqJqkALLfysx8eMYH9eKmSNmhcwE6P0jtdiPzA8IOdOGsot5
 3yYjDlB3PsKaj8g==
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
index d13ee8d9f81dc8c41ef4732167663b223ab6ab3b..08d81ca7f654c586521ff97bb5ca37229c9b939d 100644
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

