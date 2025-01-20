Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F17AC02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 13:51:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 934C880711;
	Mon, 20 Jan 2025 14:51:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Fdh2O6rX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D86780077; Mon, 20 Jan 2025 14:51:30 +0100 (CET)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7B7880711
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 14:51:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-43635796b48so28631025e9.0
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 05:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737381087; x=1737985887; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GzhjAzMbTZvG8bAr8x1apDG0k9gCCm9wC0hx41ahrxM=;
 b=Fdh2O6rXzSdlGy+4Qm32ikYqx0OBLqZ0l1tGY6u7XQxclROsEfrPPHHi+RBAlS/Fb6
 zvpRh4LmtSQj2HJUG/yRb2CfpSvfd5ABw5UdcMIngITfGMIWN6f1RwLLtOeZtQx99VKO
 D5SKO0SCW+Opz9J8Eko6EJaiX3GFKrMaY7KQC1XEuGsvS8xKCX8CQKw/V8D5sOq8lQdV
 74DGuZtcVvMvZbaXVyTBsAXXmA8Mx2lswGD7TnSR9qOE/uUxJSFBGRh62wiO36frH1OW
 v6uxjtLF2kCC9B1BHX/STDVzpv7V6XyzBl8hYhFi/mruD1BM0q+7Qqf69EQVguXDY0LO
 SFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737381087; x=1737985887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GzhjAzMbTZvG8bAr8x1apDG0k9gCCm9wC0hx41ahrxM=;
 b=lqjuGmTtizEWlGkSMDBsx4WFeXigHUiANRAr3YuD9vq+5USwtG1WE33S4Pp+VzF4dU
 dWRT9SBN7T6fHU7XHCSQHOPxe9OnfaDfa4fInqOOig9efQqtNEVll4I450bk8qwMnQte
 ZQ+fOV3fUBAREQfKSBSXdeWh6LeqpwQyk46uoW1dsbBah0fzAIFwpvsFhF0L091UmHrc
 8m2xiuKcVWS8Ir3QztDwlIJXYPHMryXTOfqZPNIe+NuIQNx4lcPrIrxk4741ld+dco2I
 WP17CC6lI5uw3wLbjoRJyW3u7OMuJUrDWQRb1STYo5h55hiOtum5ydpMHxQg/nnEP0Y8
 /Nyw==
X-Gm-Message-State: AOJu0YwL5c9U2CIG/TDdMYjasSEGdNvLVyudzsnrBI1KVbI6kDTL9PHm
 oGhXCm+vZb13TiMid5yNpcib7HbAgus8pcs5VhU42IcTlQawrChkOlzm13s/hZsgjS7gFKdlV3F
 RfqfiOpLp
X-Gm-Gg: ASbGncs3V3OyWsoAZKFnyDzEOyw/4dkKrFGrVNYyQNC8hlB2uuVRjMvsu2kfTXafPnv
 fEwfCM5PwwmCe5dpntDb9DG7LCqHo8XMyOJXUn/9cnlapeX5NDGuRedJ8C+L4GS6pXyJu9Yw52e
 1QDiiN9WQChkMpa1PEXxbvIP3XxnjYITDJ1A0Bl1BsZ++a9yE5yKcyGY5BRs4IBpRu5/C0xFMKN
 r3c5Di+zR7BF6TbabgfRYgCCHQMOKPX/5sCrezNwnIhjtlqQRV/vgaMYeqWYEyFAlK2LQktiBRS
 +Zw=
X-Google-Smtp-Source: AGHT+IGPAsTd2Jb4VM+svSwbYQjUTQzp8bFeW/I46/x84coSDHSAlcLWbYfoHlywgHzMUlekKxC4EA==
X-Received: by 2002:a05:600c:4e0c:b0:436:e69a:7341 with SMTP id
 5b1f17b1804b1-438918b966emr114436745e9.3.1737381086741; 
 Mon, 20 Jan 2025 05:51:26 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:9ae8:b2a8:a305:f9b4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c0f026c0sm108202225e9.0.2025.01.20.05.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 05:51:26 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: [RFC PATCH 1/2] Introduce coroutines framework
Date: Mon, 20 Jan 2025 14:50:43 +0100
Message-ID: <e17799b6938d4afe08b80fc20b70f4d3a81db848.1737380886.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1737380886.git.jerome.forissier@linaro.org>
References: <cover.1737380886.git.jerome.forissier@linaro.org>
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

Adds the COROUTINES Kconfig symbol which introduces a new internal API
for coroutines support. As explained in the Kconfig file, this is meant
to provide some kind of cooperative multi-tasking with the goal to
improve performance by overlapping lengthy operations.

The API as well as the implementation is very much inspired from libaco
[1]. The reference implementation is simplified to remove all things
not needed in U-Boot, the coding style is updated, and the aco_ prefix
is replaced by co_.

I believe the stack handling could be simplified: the stack of the main
coroutine could probably probably be used by the secondary coroutines
instead of allocating a new stack dynamically.

Only i386, x86_64 and aarch64 are supported at the moment. Other
architectures need to provide a _co_switch() function in assembly.

Only aarch64 has been tested.

[1] https://github.com/hnes/libaco/

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 arch/arm/cpu/armv8/Makefile     |   1 +
 arch/arm/cpu/armv8/co_switch.S  |  35 +++++++
 arch/x86/cpu/i386/Makefile      |   1 +
 arch/x86/cpu/i386/co_switch.S   |  26 +++++
 arch/x86/cpu/x86_64/Makefile    |   2 +
 arch/x86/cpu/x86_64/co_switch.S |  26 +++++
 include/coroutines.h            | 151 +++++++++++++++++++++++++++
 lib/Kconfig                     |  10 ++
 lib/Makefile                    |   2 +
 lib/coroutines.c                | 176 ++++++++++++++++++++++++++++++++
 10 files changed, 430 insertions(+)
 create mode 100644 arch/arm/cpu/armv8/co_switch.S
 create mode 100644 arch/x86/cpu/i386/co_switch.S
 create mode 100644 arch/x86/cpu/x86_64/co_switch.S
 create mode 100644 include/coroutines.h
 create mode 100644 lib/coroutines.c

diff --git a/arch/arm/cpu/armv8/Makefile b/arch/arm/cpu/armv8/Makefile
index 2e71ff2dc97..6d07b6aa9f9 100644
--- a/arch/arm/cpu/armv8/Makefile
+++ b/arch/arm/cpu/armv8/Makefile
@@ -46,3 +46,4 @@ obj-$(CONFIG_TARGET_BCMNS3) += bcmns3/
 obj-$(CONFIG_XEN) += xen/
 obj-$(CONFIG_ARMV8_CE_SHA1) += sha1_ce_glue.o sha1_ce_core.o
 obj-$(CONFIG_ARMV8_CE_SHA256) += sha256_ce_glue.o sha256_ce_core.o
+obj-$(CONFIG_COROUTINES) += co_switch.o
diff --git a/arch/arm/cpu/armv8/co_switch.S b/arch/arm/cpu/armv8/co_switch.S
new file mode 100644
index 00000000000..2fa6c52935a
--- /dev/null
+++ b/arch/arm/cpu/armv8/co_switch.S
@@ -0,0 +1,35 @@
+/* void _co_switch(struct uco *from_co, struct uco *to_co); */
+.text
+.globl _co_switch
+.type  _co_switch, @function
+_co_switch:
+    // x0: from_co
+    // x1: to_co
+    // from_co and to_co layout: { pc, sp, x19-x29 }
+
+    // Save context to from_co (x0)
+    // AAPCS64 says "A subroutine invocation must preserve the contents of the
+    // registers r19-r29 and SP"
+    adr x2, 1f  // pc we should use to resume after this function
+    mov x3, sp
+    stp x2, x3, [x0, #0]  // pc, sp
+    stp x19, x20, [x0, #16]
+    stp x21, x22, [x0, #32]
+    stp x23, x24, [x0, #48]
+    stp x25, x26, [x0, #64]
+    stp x27, x28, [x0, #80]
+    stp x29, x30, [x0, #96]
+
+    // Load new context from to_co (x1)
+    ldp x2, x3, [x1, #0]  // pc, sp
+    ldp x19, x20, [x1, #16]
+    ldp x21, x22, [x1, #32]
+    ldp x23, x24, [x1, #48]
+    ldp x25, x26, [x1, #64]
+    ldp x27, x28, [x1, #80]
+    ldp x29, x30, [x1, #96]
+    mov sp, x3
+    br x2
+
+1:  // Return to the caller
+    ret
diff --git a/arch/x86/cpu/i386/Makefile b/arch/x86/cpu/i386/Makefile
index 18e152074a7..7066904a41e 100644
--- a/arch/x86/cpu/i386/Makefile
+++ b/arch/x86/cpu/i386/Makefile
@@ -9,3 +9,4 @@ ifndef CONFIG_TPL_BUILD
 obj-y += interrupt.o
 endif
 obj-y += setjmp.o
+obj-$(CONFIG_COROUTINES) += co_switch.o
diff --git a/arch/x86/cpu/i386/co_switch.S b/arch/x86/cpu/i386/co_switch.S
new file mode 100644
index 00000000000..ec4d2d778f7
--- /dev/null
+++ b/arch/x86/cpu/i386/co_switch.S
@@ -0,0 +1,26 @@
+/* void _co_switch(struct uco *from_co, struct uco *to_co); */
+.text
+.globl _co_switch
+.type  _co_switch, @function
+.intel_syntax noprefix
+_co_switch:
+    mov     eax,DWORD PTR [esp+0x4]     // from_co
+    mov     edx,DWORD PTR [esp]         // retaddr
+    lea     ecx,[esp+0x4]               // esp
+    mov     DWORD PTR [eax+0x8],ebp     //<ebp
+    mov     DWORD PTR [eax+0x4],ecx     //<esp
+    mov     DWORD PTR [eax+0x0],edx     //<retaddr
+    mov     DWORD PTR [eax+0xc],edi     //<edi
+    mov     ecx,DWORD PTR [esp+0x8]     // to_co
+    mov     DWORD PTR [eax+0x10],esi    //<esi
+    mov     DWORD PTR [eax+0x14],ebx    //<ebx
+    mov     edx,DWORD PTR [ecx+0x4]     //>esp
+    mov     ebp,DWORD PTR [ecx+0x8]     //>ebp
+    mov     eax,DWORD PTR [ecx+0x0]     //>retaddr
+    mov     edi,DWORD PTR [ecx+0xc]     //>edi
+    mov     esi,DWORD PTR [ecx+0x10]    //>esi
+    mov     ebx,DWORD PTR [ecx+0x14]    //>ebx
+    xor     ecx,ecx
+    mov     esp,edx
+    xor     edx,edx
+    jmp     eax
diff --git a/arch/x86/cpu/x86_64/Makefile b/arch/x86/cpu/x86_64/Makefile
index e929563b2c1..862f522242c 100644
--- a/arch/x86/cpu/x86_64/Makefile
+++ b/arch/x86/cpu/x86_64/Makefile
@@ -8,3 +8,5 @@ obj-y += cpu.o interrupts.o setjmp.o
 ifndef CONFIG_EFI
 obj-y += misc.o
 endif
+
+obj-$(CONFIG_COUROUTINES) += co_switch.o
diff --git a/arch/x86/cpu/x86_64/co_switch.S b/arch/x86/cpu/x86_64/co_switch.S
new file mode 100644
index 00000000000..ec928f2d1f7
--- /dev/null
+++ b/arch/x86/cpu/x86_64/co_switch.S
@@ -0,0 +1,26 @@
+/* void _co_switch(struct uco *from_co, struct uco *to_co); */
+.text
+.globl _co_switch
+.type  _co_switch, @function
+.intel_syntax noprefix
+_co_switch:
+    mov     rdx,QWORD PTR [rsp]      // retaddr
+    lea     rcx,[rsp+0x8]            // rsp
+    mov     QWORD PTR [rdi+0x0], r12
+    mov     QWORD PTR [rdi+0x8], r13
+    mov     QWORD PTR [rdi+0x10],r14
+    mov     QWORD PTR [rdi+0x18],r15
+    mov     QWORD PTR [rdi+0x20],rdx // retaddr
+    mov     QWORD PTR [rdi+0x28],rcx // rsp
+    mov     QWORD PTR [rdi+0x30],rbx
+    mov     QWORD PTR [rdi+0x38],rbp
+    mov     r12,QWORD PTR [rsi+0x0]
+    mov     r13,QWORD PTR [rsi+0x8]
+    mov     r14,QWORD PTR [rsi+0x10]
+    mov     r15,QWORD PTR [rsi+0x18]
+    mov     rax,QWORD PTR [rsi+0x20] // retaddr
+    mov     rcx,QWORD PTR [rsi+0x28] // rsp
+    mov     rbx,QWORD PTR [rsi+0x30]
+    mov     rbp,QWORD PTR [rsi+0x38]
+    mov     rsp,rcx
+    jmp     rax
diff --git a/include/coroutines.h b/include/coroutines.h
new file mode 100644
index 00000000000..2e2fb1170a3
--- /dev/null
+++ b/include/coroutines.h
@@ -0,0 +1,151 @@
+/* SPDX-License-Identifier: Apache-2.0 */
+/*
+ * Copyright 2018 Sen Han <00hnes@gmail.com>
+ * Copyright 2025 Linaro Limited
+ */
+
+#ifndef _COROUTINES_H_
+#define _COROUTINES_H_
+
+#ifndef CONFIG_COROUTINES
+
+static inline void co_yield(void) {}
+static inline void co_exit(void) {}
+
+#else
+
+#ifdef __UBOOT__
+#include <log.h>
+#else
+#include <assert.h>
+#endif
+#include <limits.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <time.h>
+
+#ifdef __i386__
+#define UCO_REG_IDX_RETADDR 0
+#define UCO_REG_IDX_SP 1
+#define UCO_REG_IDX_BP 2
+#elif __x86_64__
+#define UCO_REG_IDX_RETADDR 4
+#define UCO_REG_IDX_SP 5
+#define UCO_REG_IDX_BP 7
+#elif __aarch64__
+#define UCO_REG_IDX_RETADDR 0
+#define UCO_REG_IDX_SP 1
+#else
+#error Architecture no supported
+#endif
+
+struct co_save_stack {
+    void*  ptr;
+    size_t sz;
+    size_t valid_sz;
+    size_t max_cpsz; /* max copy size in bytes */
+};
+
+struct co_stack {
+    void *ptr;
+    size_t sz;
+    void *align_highptr;
+    void *align_retptr;
+    size_t align_validsz;
+    size_t align_limit;
+    struct co *owner;
+    void *real_ptr;
+    size_t real_sz;
+};
+
+struct co {
+    /*
+     * CPU registers state (callee-savec plus SP, PC)
+     */
+#ifdef __i386__
+        void*  reg[6];
+#elif __x86_64__
+        void*  reg[8];
+#elif __aarch64__
+	void *reg[14];  // pc, sp, x19-x29, x30 (lr)
+#endif
+	struct co *main_co;
+	void *arg;
+	bool done;
+
+	void (*fp)(void);
+
+	struct co_save_stack save_stack;
+	struct co_stack *stack;
+};
+
+#if defined(__i386__) || defined(__x86_64__)
+#define UCO_THREAD __thread
+#else
+#define UCO_THREAD
+#endif
+
+extern UCO_THREAD struct co *current_co;
+
+static inline struct co *co_get_co(void)
+{
+	return current_co;
+}
+
+static inline void *co_get_arg(void)
+{
+	return co_get_co()->arg;
+}
+
+struct co_stack *co_stack_new(size_t sz);
+
+void co_stack_destroy(struct co_stack *s);
+
+struct co *co_create(struct co *main_co,
+		     struct co_stack *stack,
+		     size_t save_stack_sz, void (*fp)(void),
+		     void *arg);
+
+void co_resume(struct co *resume_co);
+
+void co_destroy(struct co *co);
+
+void *_co_switch(struct co *from_co, struct co *to_co);
+
+static inline void _co_yield_to_main_co(struct co *yield_co)
+{
+    assert(yield_co);
+    assert(yield_co->main_co);
+    _co_switch(yield_co, yield_co->main_co);
+}
+
+static inline void co_yield(void)
+{
+	if (current_co)
+		_co_yield_to_main_co(current_co);
+}
+
+static inline bool co_is_main_co(struct co *co)
+{
+	return !co->main_co;
+}
+
+static inline void co_exit(void)
+{
+	struct co *co = co_get_co();
+
+	if (!co)
+		return;
+	co->done = true;
+	assert(co->stack->owner == co);
+	co->stack->owner = NULL;
+	co->stack->align_validsz = 0;
+	_co_yield_to_main_co(co);
+	assert(false);
+}
+
+#endif /* CONFIG_COROUTINES */
+#endif /* _COROUTINES_H_ */
diff --git a/lib/Kconfig b/lib/Kconfig
index 8f1a96d98c4..b6c1380b927 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -1226,6 +1226,16 @@ config PHANDLE_CHECK_SEQ
 	  enable this config option to distinguish them using
 	  phandles in fdtdec_get_alias_seq() function.
 
+config COROUTINES
+	bool "Enable coroutine support"
+	help
+	  Coroutines allow to implement a simple form of cooperative
+	  multi-tasking. The main thread of execution registers one or
+	  more functions as coroutine entry points, then it schedules one
+	  of them. At any point the scheduled coroutine may yield, that is,
+	  suspend its execution and return back to the main thread. At this
+	  point another coroutine may be scheduled and so on until all the
+	  registered coroutines are done.
 endmenu
 
 source "lib/fwu_updates/Kconfig"
diff --git a/lib/Makefile b/lib/Makefile
index 5cb3278d2ef..7b809151f5a 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -159,6 +159,8 @@ obj-$(CONFIG_LIB_ELF) += elf.o
 
 obj-$(CONFIG_$(PHASE_)SEMIHOSTING) += semihosting.o
 
+obj-$(CONFIG_COROUTINES) += coroutines.o
+
 #
 # Build a fast OID lookup registry from include/linux/oid_registry.h
 #
diff --git a/lib/coroutines.c b/lib/coroutines.c
new file mode 100644
index 00000000000..b23c2004a06
--- /dev/null
+++ b/lib/coroutines.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: Apache-2.0
+
+// Copyright 2018 Sen Han <00hnes@gmail.com>
+// Copyright 2025 Linaro Limited
+
+#include <coroutines.h>
+#include <stdio.h>
+#include <stdint.h>
+
+
+/* Current co-routine */
+UCO_THREAD struct co *current_co;
+
+struct co_stack *co_stack_new(size_t sz)
+{
+	struct co_stack *p = calloc(1, sizeof(*p));
+	uintptr_t u_p;
+
+	if (!p)
+		return NULL;
+
+	if (sz < 4096)
+		sz = 4096;
+
+	p->sz = sz;
+	p->ptr = malloc(sz);
+	if (!p->ptr) {
+		free(p);
+		return NULL;
+	}
+
+	p->owner = NULL;
+	u_p = (uintptr_t)(p->sz - (sizeof(void*) << 1) + (uintptr_t)p->ptr);
+	u_p = (u_p >> 4) << 4;
+	p->align_highptr = (void*)u_p;
+	p->align_retptr  = (void*)(u_p - sizeof(void*));
+	assert(p->sz > (16 + (sizeof(void*) << 1) + sizeof(void*)));
+	p->align_limit = p->sz - 16 - (sizeof(void*) << 1);
+
+	return p;
+}
+
+void co_stack_destroy(struct co_stack *s){
+	if (!s)
+		return;
+	free(s->ptr);
+	free(s);
+}
+
+struct co *co_create(struct co *main_co,
+		     struct co_stack *stack,
+		     size_t save_stack_sz,
+		     void (*fp)(void), void *arg)
+{
+	struct co *p = malloc(sizeof(*p));
+	assert(p);
+	memset(p, 0, sizeof(*p));
+
+	if (main_co) {
+		assert(stack);
+		p->stack = stack;
+#ifdef __i386__
+		// POSIX.1-2008 (IEEE Std 1003.1-2008) - General Information - Data Types - Pointer Types
+		// http://pubs.opengroup.org/onlinepubs/9699919799.2008edition/functions/V2_chap02.html#tag_15_12_03
+		p->reg[UCO_REG_IDX_RETADDR] = (void*)fp;
+		// push retaddr
+		p->reg[UCO_REG_IDX_SP] = p->stack->align_retptr;
+#elif  __x86_64__
+		p->reg[UCO_REG_IDX_RETADDR] = (void*)fp;
+		p->reg[UCO_REG_IDX_SP] = p->stack->align_retptr;
+#elif __aarch64__
+		p->reg[UCO_REG_IDX_RETADDR] = (void *)fp;
+		// FIXME setting to align_retptr causes a crash
+		p->reg[UCO_REG_IDX_SP] = p->stack->align_highptr;
+#endif
+		p->main_co = main_co;
+		p->arg = arg;
+		p->fp = fp;
+		if (!save_stack_sz)
+			save_stack_sz = 64;
+		p->save_stack.ptr = malloc(save_stack_sz);
+		assert(p->save_stack.ptr);
+		p->save_stack.sz = save_stack_sz;
+		p->save_stack.valid_sz = 0;
+	} else {
+		p->main_co = NULL;
+		p->arg = arg;
+		p->fp = fp;
+		p->stack = NULL;
+		p->save_stack.ptr = NULL;
+	}
+	return p;
+}
+
+static void grab_stack(struct co *resume_co)
+{
+	struct co *owner_co = resume_co->stack->owner;
+
+	if (owner_co) {
+		assert(owner_co->stack == resume_co->stack);
+		assert((uintptr_t)(owner_co->stack->align_retptr) >=
+		       (uintptr_t)(owner_co->reg[UCO_REG_IDX_SP]));
+		assert((uintptr_t)owner_co->stack->align_highptr -
+				(uintptr_t)owner_co->stack->align_limit
+			<= (uintptr_t)owner_co->reg[UCO_REG_IDX_SP]);
+		owner_co->save_stack.valid_sz =
+			(uintptr_t)owner_co->stack->align_retptr -
+			(uintptr_t)owner_co->reg[UCO_REG_IDX_SP];
+		if (owner_co->save_stack.sz < owner_co->save_stack.valid_sz) {
+			free(owner_co->save_stack.ptr);
+			owner_co->save_stack.ptr = NULL;
+			do {
+				owner_co->save_stack.sz <<= 1;
+				assert(owner_co->save_stack.sz > 0);
+			} while (owner_co->save_stack.sz <
+				 owner_co->save_stack.valid_sz);
+			owner_co->save_stack.ptr =
+				malloc(owner_co->save_stack.sz);
+			assert(owner_co->save_stack.ptr);
+		}
+		if (owner_co->save_stack.valid_sz > 0)
+			memcpy(owner_co->save_stack.ptr,
+			       owner_co->reg[UCO_REG_IDX_SP],
+			       owner_co->save_stack.valid_sz);
+		if (owner_co->save_stack.valid_sz >
+		    owner_co->save_stack.max_cpsz)
+			owner_co->save_stack.max_cpsz =
+				owner_co->save_stack.valid_sz;
+		owner_co->stack->owner = NULL;
+		owner_co->stack->align_validsz = 0;
+	}
+	assert(!resume_co->stack->owner);
+	assert(resume_co->save_stack.valid_sz <=
+	       resume_co->stack->align_limit - sizeof(void *));
+	if (resume_co->save_stack.valid_sz > 0)
+		memcpy((void*)
+		       (uintptr_t)(resume_co->stack->align_retptr) -
+				resume_co->save_stack.valid_sz,
+		       resume_co->save_stack.ptr,
+		       resume_co->save_stack.valid_sz);
+	if (resume_co->save_stack.valid_sz > resume_co->save_stack.max_cpsz)
+		resume_co->save_stack.max_cpsz = resume_co->save_stack.valid_sz;
+	resume_co->stack->align_validsz =
+		resume_co->save_stack.valid_sz + sizeof(void *);
+	resume_co->stack->owner = resume_co;
+}
+
+void co_resume(struct co *resume_co)
+{
+	assert(resume_co && resume_co->main_co && !resume_co->done);
+
+	if (resume_co->stack->owner != resume_co)
+		grab_stack(resume_co);
+
+	current_co = resume_co;
+	_co_switch(resume_co->main_co, resume_co);
+	current_co = resume_co->main_co;
+}
+
+void co_destroy(struct co *co){
+	if (!co)
+		return;
+
+	if(co_is_main_co(co)){
+		free(co);
+		current_co = NULL;
+	} else {
+		if(co->stack->owner == co){
+			co->stack->owner = NULL;
+			co->stack->align_validsz = 0;
+		}
+		free(co->save_stack.ptr);
+		co->save_stack.ptr = NULL;
+		free(co);
+	}
+}
-- 
2.43.0

