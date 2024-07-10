Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B37C3DA41
	for <u-boot@archiver.kernel.org>; Wed, 10 Jul 2024 16:27:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15CDC8871A;
	Wed, 10 Jul 2024 18:26:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ayYyFo4k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 490D888719; Wed, 10 Jul 2024 18:26:47 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CB6F88719
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 18:26:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2ee910d6a9dso63725831fa.1
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 09:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720628803; x=1721233603; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NyzsCZtuwVIUEhrBwkXcq4z8tfZsk2RtUBZ3lc+CRbo=;
 b=ayYyFo4k5dqSaEJc+oljBQwS9V141mF5KDA5oztPp9lIhsT5BlwcbOdBiOoZRHK9LS
 mwjdxXRoZZrBMm0PVpQ77Mqy6TOmu0B2/+kx+So7myeAQDJyled44pudOSk7vMoXsL/g
 tcLF8RWXXZCokndna87gSRBWfBS2qQnnEcJnWEZdX8z4/HThorswF9jPEgplYap4nVcl
 G+khL8ixykHtq1fBQI9BBVH2TNPDyiwToHor13dHhXnyWGxFkfP9MS5a0PegjMW2xO7u
 VmXhfvUGponQv7EGbzfsAOBU/yw4TQpqvD/X8z7+l6Bih9GCyKNyY/rejUJFbJdiHnUk
 GYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720628803; x=1721233603;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NyzsCZtuwVIUEhrBwkXcq4z8tfZsk2RtUBZ3lc+CRbo=;
 b=I0frBGHrqd0bTnklPlHhTSj5YlwKMflz/O06fFQ+zRiJO8lO8iIIu9P0ds5lftKmAl
 qXXG0LzKP/PR5pmA3FRQ/meCAuRPieCExRUoergSsyppc/PNifqBbehpRgLZurB9pJs3
 +wtSiysjZfhyKV+LUX7rnKEvVXDX/fc02NaD2uvdyq8itTNAMoOHp3PDTfp+1GM4/4bZ
 R62SIcKAKND5ug1XEoQZPiOq9yTVspcDdGz1RRo5z32OkhbUy3QsGJMOIN7cA6+A85gf
 31cgp2uv5mrkWkq31i2zfGjkUJgLqdjdASoNsaY8JKFbwsqVZ2vZLGo/QUAGrzk2NJTZ
 nxJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9ArouW+RgDrLqwA1B4boIWG8wX42Gs9hte09t6GdVrcYKAxXEoULC85oKcdhaPg5Y0rxTbmo4CodA4l+BLEIvBkuM5A==
X-Gm-Message-State: AOJu0YyeLIXy2EzJIW2wB9b73//uAXDRXwXyHxGsjeNI2+8KiD6Ij8tc
 1TeU7hAqMl/oo7cJCtfYW4J1j4ivPSKhxV19LYfuTVD38laqpZBuABQlWa96zdt0SzvoyowfuNS
 8
X-Google-Smtp-Source: AGHT+IFt/PW9C7msmJf48AFFeH92uksMmildpPk9KHTlPrSO+4Phwq7ozueY3i5EMYANPLTQ4rNmcw==
X-Received: by 2002:a05:651c:198b:b0:2ed:5c34:4082 with SMTP id
 38308e7fff4ca-2eeb30ba0abmr54549271fa.8.1720628803047; 
 Wed, 10 Jul 2024 09:26:43 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-594bc4e8255sm2370348a12.48.2024.07.10.09.26.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jul 2024 09:26:42 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 10 Jul 2024 18:26:20 +0200
Subject: [PATCH RFC 3/3] arm64: unwind stack on exception
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240710-arm64-backtrace-v1-3-5a2ba50485dd@linaro.org>
References: <20240710-arm64-backtrace-v1-0-5a2ba50485dd@linaro.org>
In-Reply-To: <20240710-arm64-backtrace-v1-0-5a2ba50485dd@linaro.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5030;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=ZwtGypsu9akeCWuDyhZMYfNLMYxqXylLI8lAIBv1USQ=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmjrY+ce2jWkyPCkLWWNIu3kMGc+MIiSt5VaA26
 ORj4zb3ibCJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZo62PgAKCRAFgzErGV9k
 ttt4D/9LEf6M/839RJmr6L4kP8y+W0MJ628dbxtrE4+RvKlu/J2KQ4zmEO5Hr/7hVllHqKG7Qkm
 GABrx1GFChPTINkEa5b1jaAWum4RDJRibHLlyh60jlahnFZ/Ws122NIlhnP2j4pDBOfNBdtyei/
 mXkxZRTLCJ/vjL3UVwFH6igF48XOgIm8idly20z8pNQg8OEZtFUrUzqKW+/MAGdzPE8vm/9ZNsc
 cxjUIbGWs0xq7JHXDTXbLuhfbJUylmz9bmqkjy6EYwrrJiNcaS8xB1/Wb5wvbUVl3QHDe4bkl4U
 AXs1ld2hF6agUUqT/sDo96bGxjt+/Vr70ba1eIkdboG+mQ/5czg43TfJ4BzEoKpu5a9o++OvEez
 ONfnxKEn2j4NlFh2XPS3zPa0FJRmnliQ9bcR3nSdMdm8R0H10Ztx1+5tZHRFF2UEkT8WE705D4L
 IC8KrFI3z8Br/Ra3jVBT4CWS0id5zQ0Ik8XjlFsNMgdRjw9E4AOHMufTHBAajpYB0WDwLVSMhfc
 J/oY/lVuqxSwPu/nnVFKA+GCnp2U20NQTnoPWkuOtda87JHExRu3viyGuFgBEF4690sQOEmT46C
 tN9crbhyRIW1Xv3cRMDQbgpVexfEhlTizrYbLFFQi6w0cXQfN7kj+pEs0oXfzBlf1leX3uyk7zk
 F5Yc49qxwi4bsxg==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
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

We already build arm64 images with frame pointers. Let's finally make
use of them in tandem with the new symbol lookup support by unwinding
the stack when an exception occurs, producing a backtrace similar to
those emitted by Linux.

In addition, introduce a dedicated unwind_stack() function which can be
called from anywhere to print a backtrace.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/include/asm/ptrace.h |  4 +++
 arch/arm/lib/interrupts_64.c  | 76 +++++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig                   |  6 ++--
 3 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/ptrace.h b/arch/arm/include/asm/ptrace.h
index a836f6cc60db..f42cfb33e918 100644
--- a/arch/arm/include/asm/ptrace.h
+++ b/arch/arm/include/asm/ptrace.h
@@ -22,8 +22,12 @@
 
 #ifdef __KERNEL__
 extern void show_regs(struct pt_regs *);
 
+#if CONFIG_IS_ENABLED(SYMBOL_LOOKUP)
+void unwind_stack(void);
+#endif
+
 #define predicate(x)	(x & 0xf0000000)
 #define PREDICATE_ALWAYS	0xe0000000
 
 #endif
diff --git a/arch/arm/lib/interrupts_64.c b/arch/arm/lib/interrupts_64.c
index b3024ba514ec..24edeb0de51e 100644
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
@@ -80,8 +82,77 @@ static void dump_instr(struct pt_regs *regs)
 		printf(i == 0 ? "(%08x) " : "%08x ", addr[i]);
 	printf("\n");
 }
 
+#if IS_ENABLED(CONFIG_SYMBOL_LOOKUP)
+
+static void print_sym(unsigned long symaddr, const char *symname, unsigned long offset)
+{
+	if (symaddr > (unsigned long)__bss_end)
+		printf("\t<%#016lx> ???\n", symaddr);
+	else
+		printf("\t<%#016lx> %s+%#lx\n", symaddr, symname, offset);
+}
+
+/* Stack frames automatically generated by compiler emitted code */
+struct stack_frame {
+	struct stack_frame *prev_ptr; /* Alays a bigger address on ARM64 */
+	unsigned long lr;
+	char data[];
+};
+
+static void __unwind_stack(unsigned long lr, unsigned long x29)
+{
+	char symname[KSYM_NAME_LEN+1] = { 0 };
+	unsigned long addr, offset;
+	struct stack_frame *fp, *last_fp;
+
+	/*
+	 * Either the place where unwind_stack() was called, or the
+	 * instruction that caused an exception
+	 */
+	symbols_lookup(lr, &addr, &offset, symname);
+	print_sym(addr, symname, offset);
+
+	fp = (struct stack_frame *)x29;
+	while (fp && fp->prev_ptr > fp) {
+		symbols_lookup(fp->lr, &addr, &offset, symname);
+		/*
+		 * _start is used over gd->relocaddr because it will be correct
+		 * if U-Boot was built as relocatable and loaded at an arbitrary
+		 * address (both pre and post-relocation).
+		 */
+		print_sym(addr + (unsigned long)_start, symname, offset);
+		last_fp = fp;
+		fp = (struct stack_frame *)(u64)fp->prev_ptr;
+	}
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
+	__unwind_stack(x30, x29);
+}
+
+#else
+
+#define __unwind_stack(lr, x29) do {} while (0)
+
+#endif
+
 void show_regs(struct pt_regs *regs)
 {
 	int i;
 
@@ -95,8 +166,13 @@ void show_regs(struct pt_regs *regs)
 		printf("x%-2d: %016lx x%-2d: %016lx\n",
 		       i, regs->regs[i], i+1, regs->regs[i+1]);
 	printf("\n");
 	dump_instr(regs);
+
+	if (IS_ENABLED(CONFIG_SYMBOL_LOOKUP)) {
+		printf("\nBacktrace:\n");
+		__unwind_stack(regs->elr, regs->regs[29]);
+	}
 }
 
 /*
  * Try to "emulate" a semihosting call in the event that we don't have a
diff --git a/lib/Kconfig b/lib/Kconfig
index 06a78f83b7d6..092b780aeeb8 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -979,11 +979,13 @@ config VPL_OF_LIBFDT_ASSUME_MASK
 	  unsafe execution. See FDT_ASSUME_PERFECT, etc. in libfdt_internal.h
 
 config SYMBOL_LOOKUP
 	bool "Enable symbol lookup"
+	default n
 	help
-	  This enables support for looking up symbol names from addresses. The
-	  primary usecase for this is improved debugging support.
+	  This enables support for looking up symbol names from addresses. When
+	  enabled U-Boot will print stack traces with function names when an
+	  exception occurs.
 
 menu "System tables"
 	depends on (!EFI && !SYS_COREBOOT) || (ARM && EFI_LOADER)
 

-- 
2.45.2

