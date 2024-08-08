Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4099C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 16:22:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36D6A88BD6;
	Thu,  8 Aug 2024 18:21:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FpZsFDYd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D493188BD3; Thu,  8 Aug 2024 18:21:34 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01A7088BC9
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 18:21:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5b8c2a6135eso1739062a12.0
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 09:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723134090; x=1723738890; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uYOu2ipHwEssxBvLgdYj44u05DMcnmXqyOAokHDVQis=;
 b=FpZsFDYdLL9O9Zd1A3+5PxWrD8GDRssZEGzfre7tiTTJluHaPgXW+XKmCcMxwCiwrb
 kkwCqAG1DzUAfTQp1ib8iTlGU/7TAXraPd4Nwlk5NXuGRE513iDH505FVi2k6ltWIF/M
 uKZPx9aHUx5XhuXPaOqDug6ywtXuqQl3yi4yH+8EsGwvT7I9/3DTSBN8qLcj8gKgm+tr
 54JYD0haQ3tiHnqTOyZVrpooD84YAey7tGd8uzHRUamZsIxKbeJd2ZvmOV9sbtcKvGSw
 0XsfnpK4bKdJNu51RN11Kfhl+au2lL+WX2lTRSexSeNEOe6Kzl4jkeqxhek4O1x3Wrnv
 qB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723134090; x=1723738890;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uYOu2ipHwEssxBvLgdYj44u05DMcnmXqyOAokHDVQis=;
 b=GygHDn7hEi6vgHsSacr99xQviwxYsyKyd8znpVaw53lN6fXKWVUYCteoJndvsE/QDR
 18pv5WdvojvA0rQ2pd7n75N4LwQStmyXHkSWBQ8PNZp/wLqUMjQQPkwrHV36OX+hsNJE
 0KGpWXqX0rcSzGaKOUPVigv9K8cVbd3VKFWaN6UXK5yxlWRv57ACuZ88RVoddBGS/Zh/
 vhZ7pA8We0W4x+FKMrsNYwsyXEQpwzjNydQ63bKz3/vfDmG/KZmNi8xZOiSc62Jz5hMI
 nBylsFzZIe7sd164C9WVu+Sobx2hbE4EraOukmWAb7FdXccTcaNAiZlGr1fnDu9BkiZm
 d4RQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/fAFp2EgqkFvlfpxBwCAtG/CSgstaGSUPlie2p1R4mLojlGkedis6uxPMpzTTF2Cya5m5a4Xi6E8Nv35zMrexqNQhmg==
X-Gm-Message-State: AOJu0YwYRv92YgLoYJNZzIbxLK9hdnb2F00sBUoLsUBauXEjMBB0g12l
 qghYdsMc59dnvSc3Pyvh/RpSBXpmOx6xda4Bx9l0x8Tj61OrrlEcpOghV3H2qTaCWjNjz+QKMJt
 99KA=
X-Google-Smtp-Source: AGHT+IG8m8W52Oo2vL0tddp1U5HOgBiXFXpQyzweext8+I4M4GgKs84wPUhyYyWxBgcIgD0HQ2Mp5Q==
X-Received: by 2002:a05:6402:51d1:b0:57d:d59:461b with SMTP id
 4fb4d7f45d1cf-5bbb3d0f9e8mr2071748a12.13.1723134090088; 
 Thu, 08 Aug 2024 09:21:30 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bbb2e5d76dsm770396a12.80.2024.08.08.09.21.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 09:21:29 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 08 Aug 2024 18:21:26 +0200
Subject: [PATCH v2 3/3] arm64: unwind stack on exception
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240808-arm64-backtrace-v2-3-29665a2265cf@linaro.org>
References: <20240808-arm64-backtrace-v2-0-29665a2265cf@linaro.org>
In-Reply-To: <20240808-arm64-backtrace-v2-0-29665a2265cf@linaro.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4150;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=auYxX8CvKRKTJfLQF3ngQ7IDS2XoN11jACinYgvIZoM=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmtPCFzIqckL0VC5YQUzGcj+p0eZlCLoSTbXejp
 fOR8qQNTqqJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZrTwhQAKCRAFgzErGV9k
 tp1CD/4nS7BOfDLN6mjWJTs+gS8Sf1H21qHbV4wzCyTlouJKP1nbBeEmJDINSlsEH4P1gxc7dZG
 JqVMwNiO7wkcVI+nrbdiZqm900kxLx6u8l4HcdzOwJyF6wfKosD216h8Z3KyyiaT/oWX5QS4OPU
 JBj4pEPaajKPAP1F4NWagObJwhPNEQK/OVgRXvRvxNS+6GZkj0SJryr+ytFOYoiaSBObEUylnAs
 KZ5Pck+KH5T+tNnbuCVU/gqr/9v/WT0qdKkAYZgiFex5BWjDzhPlLRh2OiqNoYXmLfz0DnAuTXV
 d6B2UFcJFcb3euCG2z2iZU2OuXdW4GT7Nv9PGrl9GOXHgCL3e8I27/b9TaWGf49BTfV8RWBtVj5
 5xslKs+safHoES5ZcpFqd8+YkmOMoM+bhcAT3B5Rw+aKXMRi8eHk5YYVothqSzN0E0GWFDUsag4
 uGSXp/hhtWmgqydejCaAVugpRF/uXJ6T1x91qZkZpyzySqTF8tE2OO3pjAMloyEmEjAow8G0beo
 dDThiZ8lTyms/8aJOMLui8SuRjavI77nM/tWG1xY1uTX9R8tFyEjG1ADYJTYiWIQ7j/GVMoK7uw
 ZjmhpfHCTz0KPux3igpGoOvw+OyOQ/sAVQnNWRo5pSslw51dr24l9ckUG1Hl1qfAt7AKyapPbss
 KpTGFjfdMUTdpwQ==
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
 arch/arm/include/asm/ptrace.h |  2 ++
 arch/arm/lib/interrupts_64.c  | 75 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/arch/arm/include/asm/ptrace.h b/arch/arm/include/asm/ptrace.h
index a836f6cc60db..d4a971211843 100644
--- a/arch/arm/include/asm/ptrace.h
+++ b/arch/arm/include/asm/ptrace.h
@@ -22,8 +22,10 @@
 
 #ifdef __KERNEL__
 extern void show_regs(struct pt_regs *);
 
+void unwind_stack(void);
+
 #define predicate(x)	(x & 0xf0000000)
 #define PREDICATE_ALWAYS	0xe0000000
 
 #endif
diff --git a/arch/arm/lib/interrupts_64.c b/arch/arm/lib/interrupts_64.c
index b3024ba514ec..bae823cb2feb 100644
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
@@ -80,8 +82,76 @@ static void dump_instr(struct pt_regs *regs)
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
+	struct stack_frame *fp;
+
+	/*
+	 * Either the place where unwind_stack() was called, or the
+	 * instruction that caused an exception
+	 */
+	symbols_lookup(lr, &addr, &offset, symname);
+	print_sym(lr, symname, offset);
+
+	fp = (struct stack_frame *)x29;
+	while (fp && fp->prev_ptr > fp) {
+		symbols_lookup(fp->lr, &addr, &offset, symname);
+		/*
+		 * _start is used over gd->relocaddr because it will be correct
+		 * if U-Boot was built as relocatable and loaded at an arbitrary
+		 * address (both pre and post-relocation).
+		 */
+		print_sym(fp->lr, symname, offset);
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
 
@@ -95,8 +165,13 @@ void show_regs(struct pt_regs *regs)
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

-- 
2.46.0

