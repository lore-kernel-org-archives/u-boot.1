Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 866B2C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 15:32:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBF51812D8;
	Tue,  4 Mar 2025 16:32:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hqwrSHac";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FDCC80F96; Tue,  4 Mar 2025 16:32:09 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AD6E800C1
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 16:32:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-390df0138beso3044238f8f.0
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 07:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741102290; x=1741707090; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YFDmGzMpKY+29gEM4ZJhgVMoSZNmh5jXaS5z7DuspBk=;
 b=hqwrSHacuGnU84kFa6VLmfqxrlrTNbMMCsaXVfoPBjg9SjJiZ9SDPxkiID6BjwzLBz
 u8nzsfnGQMM9e04swLeOPxp7Md+QBV8nZfdZJ3zP8iEXz0Z4p8tmlbRtGvu8WeBYJzN/
 2u6gpYfAAxhXc+NKQYSRTh3CvpOrO74/sv3PGTW/bERKLtgeFuVvQY5fVdDxr1Jgj9Z+
 9kTOfpgrRv5R6LQH7k6+koqTXErhXtXbD7kpJ5DZoa7RozTLYMhCAaitPzum64e3fZR6
 MN3wB6A2q8bot1CNN6qwQ5TQRh4vyRs4LYcWpGZWtx+ADFJlxPfgwdzwX8gmbLodsJf0
 jFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741102290; x=1741707090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YFDmGzMpKY+29gEM4ZJhgVMoSZNmh5jXaS5z7DuspBk=;
 b=CSIPWBBiamQSI+qQvUBuD+UmOvvx7jZq0HzBd2W42LSc7hTi9dWLJx3S3MWVdkjjRy
 lp4WHO0Cn4Q4ZN+6/j2SDAQ3byUS7bmFapRWzDYvl568byhd0GL6W4cLoClHBshzUUip
 7vBa595Ck9WqnCAnHVX0WQyY0l94EZzCNb3rhnGvnoRraPbYaEnUoVV9PXlNk1CUiK8W
 Y+bSAIdwzZrtE8+FZFRlWUlEXzXwjlusWVd/CteSF8wQ0DBXYqrCOYFGQpswFInrc/y/
 NmJxDCSONxJpWyYnJl7/QFqMIMvhpVpyF+62n03bE5ztOyb5Se3895PCpm1MHCk1+PuJ
 4TWg==
X-Gm-Message-State: AOJu0YwDdBZ0UbYvKDqUJvPMXAymPcmcd4CD8ciHhxArMbZMBXzvmMKe
 qBXcs+XNVl9fIt7bFhIGEOQaYqq8kWa3hGQ/YrVbJi2APugVAPsBmke8wIY9PKEzP8sQcLfYhO4
 s
X-Gm-Gg: ASbGncuJFWETrQJ316tWCfKFuTqxRL4Yuk8zm11DMPlJljkemlozwmcTwkBjjVJG/bL
 +y6U8ID3MNhQvOzQODHP23vE4zVQnfUfc/vAgTjb74ZcC+C9mUnU2Twp7zlW++fS8hrWzvL7nqh
 0ylDK5jUuNyzqBJGRzEwTqu+/3KWKz5CFZgfF+VE2VSwWeJVVvjE2ZIhb3EIYda6nc0XYCyluh7
 c/L9yDJVrCeMYyBg4ewerLcl3iShi3Eea5nT7CGcsrTMuBbCXo3GcBJiuXufgvI5VsQsdJs12rR
 W1M3OQPPiJkccc+a7YprQK/TTnuPMZALqQ0CDglAqAUah3EGtyg62w==
X-Google-Smtp-Source: AGHT+IEKfYesa72zH00bx5Vl3Rt7zLUr/Je8Pnm8tjO5+oakYclne6tn7NeUMg51Baq1FLZ+XPgl6g==
X-Received: by 2002:a5d:5f81:0:b0:390:f607:9656 with SMTP id
 ffacd0b85a97d-390f60796f9mr12520106f8f.34.1741102289752; 
 Tue, 04 Mar 2025 07:31:29 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:771e:3d0f:d9c9:2f92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e485db82sm17669254f8f.88.2025.03.04.07.31.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 07:31:29 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 04/14] sandbox: add initjmp()
Date: Tue,  4 Mar 2025 16:24:52 +0100
Message-ID: <20250304152510.2832340-5-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304152510.2832340-1-jerome.forissier@linaro.org>
References: <20250304152510.2832340-1-jerome.forissier@linaro.org>
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

Add ininijmp() to sandbox. The implementation is taken verbatim from
barebox [1]. It is quite complex because contrary to U-Boot platform
code we don't know how the system's C library implements the jump
buffer, so we can't just write the function and stack pointers into it.

FIXME: this patch should make SANDBOX select HAVE_INITJMP (in
arch/Kconfig). It does not due to the following error detected by CI:

 _________________________ test_ut[ut_lib_lib_initjmp] __________________________
 test/py/tests/test_ut.py:608: in test_ut
     output = u_boot_console.run_command('ut ' + ut_subtest)
 test/py/u_boot_console_base.py:334: in run_command
     m = self.p.expect([self.prompt_compiled] + self.bad_patterns)
 test/py/u_boot_spawn.py:296: in expect
     c = self.receive(1024)
 test/py/u_boot_spawn.py:235: in receive
     raise err
 test/py/u_boot_spawn.py:227: in receive
     c = os.read(self.fd, num_bytes).decode(errors='replace')
 E   OSError: [Errno 5] Input/output error
 ----------------------------- Captured stdout call -----------------------------
 => ut lib lib_initjmp
 Test: lib_initjmp: initjmp.c
 Failures: 0
 common/dlmalloc.c:796: do_check_free_chunk: Assertion `next == top || inuse(next)' failed.common/dlmalloc.c:796: do_check_free_chunk: Assertion `next == top || inuse(next)' failed.
 ---------------- generated xml file: /tmp/sandbox64/results.xml ----------------

On x86 the dmalloc error is not printed but the I/O error is still there.

[1] https://github.com/barebox/barebox/blob/b2a15c383ddc/arch/sandbox/os/setjmp.c

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 arch/sandbox/cpu/Makefile  |  11 ++-
 arch/sandbox/cpu/initjmp.c | 172 +++++++++++++++++++++++++++++++++++++
 2 files changed, 182 insertions(+), 1 deletion(-)
 create mode 100644 arch/sandbox/cpu/initjmp.c

diff --git a/arch/sandbox/cpu/Makefile b/arch/sandbox/cpu/Makefile
index bfcdc335d32..038ad78accc 100644
--- a/arch/sandbox/cpu/Makefile
+++ b/arch/sandbox/cpu/Makefile
@@ -5,7 +5,7 @@
 # (C) Copyright 2000-2003
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
-obj-y	:= cache.o cpu.o state.o
+obj-y	:= cache.o cpu.o state.o initjmp.o
 extra-y	:= start.o os.o
 extra-$(CONFIG_SANDBOX_SDL)    += sdl.o
 obj-$(CONFIG_XPL_BUILD)	+= spl.o
@@ -29,6 +29,15 @@ cmd_cc_eth-raw-os.o = $(CC) $(filter-out -nostdinc, \
 $(obj)/eth-raw-os.o: $(src)/eth-raw-os.c FORCE
 	$(call if_changed_dep,cc_eth-raw-os.o)
 
+# initjmp.c is build in the system environment, so needs standard includes
+# CFLAGS_REMOVE_initjmp.o cannot be used to drop header include path
+quiet_cmd_cc_initjmp.o = CC $(quiet_modtag)  $@
+cmd_cc_initjmp.o = $(CC) $(filter-out -nostdinc, \
+	$(patsubst -I%,-idirafter%,$(c_flags))) -c -o $@ $<
+
+$(obj)/initjmp.o: $(src)/initjmp.c FORCE
+	$(call if_changed_dep,cc_initjmp.o)
+
 # sdl.c fails to build with -fshort-wchar using musl
 cmd_cc_sdl.o = $(CC) $(filter-out -nostdinc -fshort-wchar, \
 	$(patsubst -I%,-idirafter%,$(c_flags))) -fno-lto -c -o $@ $<
diff --git a/arch/sandbox/cpu/initjmp.c b/arch/sandbox/cpu/initjmp.c
new file mode 100644
index 00000000000..c99721423c5
--- /dev/null
+++ b/arch/sandbox/cpu/initjmp.c
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * An implementation of initjmp() in C, that plays well with the system's
+ * setjmp() and longjmp() functions.
+ * Taken verbatim from arch/sandbox/os/setjmp.c in the barebox project.
+ *
+ * Copyright (C) 2006  Anthony Liguori <anthony@codemonkey.ws>
+ * Copyright (C) 2011  Kevin Wolf <kwolf@redhat.com>
+ * Copyright (C) 2012  Alex Barcelo <abarcelo@ac.upc.edu>
+ * Copyright (C) 2021  Ahmad Fatoum, Pengutronix
+ * This file is partly based on pth_mctx.c, from the GNU Portable Threads
+ *  Copyright (c) 1999-2006 Ralf S. Engelschall <rse@engelschall.com>
+ */
+
+/* XXX Is there a nicer way to disable glibc's stack check for longjmp? */
+#ifdef _FORTIFY_SOURCE
+#undef _FORTIFY_SOURCE
+#endif
+
+#include <pthread.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <setjmp.h>
+#include <signal.h>
+
+typedef sigjmp_buf _jmp_buf __attribute__((aligned((16))));
+_Static_assert(sizeof(_jmp_buf) <= 512, "sigjmp_buf size exceeds expectation");
+
+/*
+ * Information for the signal handler (trampoline)
+ */
+static struct {
+	_jmp_buf *reenter;
+	void (*entry)(void);
+	volatile sig_atomic_t called;
+} tr_state;
+
+/*
+ * "boot" function
+ * This is what starts the coroutine, is called from the trampoline
+ * (from the signal handler when it is not signal handling, read ahead
+ * for more information).
+ */
+static void __attribute__((noinline, noreturn))
+coroutine_bootstrap(void (*entry)(void))
+{
+	for (;;)
+		entry();
+}
+
+/*
+ * This is used as the signal handler. This is called with the brand new stack
+ * (thanks to sigaltstack). We have to return, given that this is a signal
+ * handler and the sigmask and some other things are changed.
+ */
+static void coroutine_trampoline(int signal)
+{
+	/* Get the thread specific information */
+	tr_state.called = 1;
+
+	/*
+	 * Here we have to do a bit of a ping pong between the caller, given that
+	 * this is a signal handler and we have to do a return "soon". Then the
+	 * caller can reestablish everything and do a siglongjmp here again.
+	 */
+	if (!sigsetjmp(*tr_state.reenter, 0)) {
+		return;
+	}
+
+	/*
+	 * Ok, the caller has siglongjmp'ed back to us, so now prepare
+	 * us for the real machine state switching. We have to jump
+	 * into another function here to get a new stack context for
+	 * the auto variables (which have to be auto-variables
+	 * because the start of the thread happens later). Else with
+	 * PIC (i.e. Position Independent Code which is used when PTH
+	 * is built as a shared library) most platforms would
+	 * horrible core dump as experience showed.
+	 */
+	coroutine_bootstrap(tr_state.entry);
+}
+
+int __attribute__((weak)) initjmp(_jmp_buf jmp, void (*func)(void), void *stack_top)
+{
+	struct sigaction sa;
+	struct sigaction osa;
+	stack_t ss;
+	stack_t oss;
+	sigset_t sigs;
+	sigset_t osigs;
+
+	/* The way to manipulate stack is with the sigaltstack function. We
+	 * prepare a stack, with it delivering a signal to ourselves and then
+	 * put sigsetjmp/siglongjmp where needed.
+	 * This has been done keeping coroutine-ucontext (from the QEMU project)
+	 * as a model and with the pth ideas (GNU Portable Threads).
+	 * See coroutine-ucontext for the basics of the coroutines and see
+	 * pth_mctx.c (from the pth project) for the
+	 * sigaltstack way of manipulating stacks.
+	 */
+
+	tr_state.entry = func;
+	tr_state.reenter = (void *)jmp;
+
+	/*
+	 * Preserve the SIGUSR2 signal state, block SIGUSR2,
+	 * and establish our signal handler. The signal will
+	 * later transfer control onto the signal stack.
+	 */
+	sigemptyset(&sigs);
+	sigaddset(&sigs, SIGUSR2);
+	pthread_sigmask(SIG_BLOCK, &sigs, &osigs);
+	sa.sa_handler = coroutine_trampoline;
+	sigfillset(&sa.sa_mask);
+	sa.sa_flags = SA_ONSTACK;
+	if (sigaction(SIGUSR2, &sa, &osa) != 0) {
+		return -1;
+	}
+
+	/*
+	 * Set the new stack.
+	 */
+	ss.ss_sp = stack_top - CONFIG_STACK_SIZE;
+	ss.ss_size = CONFIG_STACK_SIZE;
+	ss.ss_flags = 0;
+	if (sigaltstack(&ss, &oss) < 0) {
+		return -1;
+	}
+
+	/*
+	 * Now transfer control onto the signal stack and set it up.
+	 * It will return immediately via "return" after the sigsetjmp()
+	 * was performed. Be careful here with race conditions.  The
+	 * signal can be delivered the first time sigsuspend() is
+	 * called.
+	 */
+	tr_state.called = 0;
+	pthread_kill(pthread_self(), SIGUSR2);
+	sigfillset(&sigs);
+	sigdelset(&sigs, SIGUSR2);
+	while (!tr_state.called) {
+		sigsuspend(&sigs);
+	}
+
+	/*
+	 * Inform the system that we are back off the signal stack by
+	 * removing the alternative signal stack. Be careful here: It
+	 * first has to be disabled, before it can be removed.
+	 */
+	sigaltstack(NULL, &ss);
+	ss.ss_flags = SS_DISABLE;
+	if (sigaltstack(&ss, NULL) < 0) {
+		return -1;
+	}
+	sigaltstack(NULL, &ss);
+	if (!(oss.ss_flags & SS_DISABLE)) {
+		sigaltstack(&oss, NULL);
+	}
+
+	/*
+	 * Restore the old SIGUSR2 signal handler and mask
+	 */
+	sigaction(SIGUSR2, &osa, NULL);
+	pthread_sigmask(SIG_SETMASK, &osigs, NULL);
+
+	/*
+	 * jmp can now be used to enter the trampoline again, but not as a
+	 * signal handler. Instead it's longjmp'd to directly.
+	 */
+	return 0;
+}
+
-- 
2.43.0

