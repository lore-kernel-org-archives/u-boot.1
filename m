Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A88C021B8
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 16:35:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B5B880F88;
	Tue, 25 Feb 2025 17:35:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="titERvgy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A73480FED; Tue, 25 Feb 2025 17:35:18 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8017807EE
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 17:35:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-38f2b7ce2e5so3432196f8f.2
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 08:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740501315; x=1741106115; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zc5YqeOWjVFGOI9lQwk18URjr1oDar0gNQj5WjUOp00=;
 b=titERvgyTSNDs3dFoZ1T/kFjS6pRHC3vkh3NEEMeRF/BRH3ZbkSPXErUktAV2PXgHc
 nUY5U3Nh58dZk/qbJZkmCI+XE53QnpPYdhAkmjMAd/o5Cqc3VV8p1byUhaoXZEyjX6pI
 S4AyPb35RKa3ZHRGYJMDYGQ8t9umjK5F19RF8iOI/lXPR0R3iO2WFknOAE5AOphUAM2Z
 dTLyiHYyfVpe9axEz4SsKK6mX6QlkWiHzGQdV9n/bD9Wc+ErBTEgQaYimT3PA1w9W7+c
 hIO+bROv8yPNMJJsJaRg+4jQHiF/bCqHnQvfAQul+89W+1vRAqKlrKVR11FK0NSCKs7Y
 /McA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740501315; x=1741106115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zc5YqeOWjVFGOI9lQwk18URjr1oDar0gNQj5WjUOp00=;
 b=ISmr/z9KGR7E+JGVcjNPD7rQZeXwl2whwxwlNyRhOqJx2C9EfRmJ/RIvW+ssdhbeKU
 67dNrvdNlIQ7fYxepr/CXHUjh55wMB3O+snA2BH7UUEnXK7LU4FVzRP6lqqzaIgvp7dZ
 A3FYWfhsdzl+wEk6nRH+JZ6xz4L8yO5OkMrVV7dJTF2lnSTIOaheGEqq0ktx7pV5Ju3R
 2m6rzU+a2mFP/KyxXrOY/I5DW/tCsVUr+3TyMKn2IUaC5Hc3L384s6RCtGflYFQL67x3
 WRnQ3iYhGCYxn+K25DllPmIvVKHwaZbXymnyJM210atyMVR0pA7ydRLktcQ/3rYrYBnK
 BVtw==
X-Gm-Message-State: AOJu0YzAsUmRFioOALeh04RurWHzN+FnBVsKOh9LB9TpwXNV9jQwW6fD
 Xa8Y+7UpWGM9KCA8z7P/0Q3gtcRq8PrvOBL8MD4Os1jlSMyW10AkYaM/nl+xBidYmv78y6I15f0
 ttUvD7g==
X-Gm-Gg: ASbGnctCEhx7ZQylmnQNZ00gh4ZkulG7RESEY0TprYmQ+hlWDAr1ipLBym3HtoRMn0w
 JOYg6Ik5v3eyahmxriEaQOoe3kwII6MYrJQ9mUE/RXGwXYq+CvleEw4HidCjgbnUq9RziTrxsAk
 kYOdtCNnI85tCE5vwl6glNFRMGJreATD8MOXw/WzQ1sBN2YvCrnCrDkR4na+Td528HaTf6dlsBl
 YexNBvey13CHGX7Zl/tzSYdOxqlEUR+J0JSs0ILq7l2neXJ0mhU0091LlgUZxj7osFX5y28e008
 mXcdQzKjp+imyP90QD+6nQwDZI0tJkRSsmE=
X-Google-Smtp-Source: AGHT+IESw3328NI51R779eKxR2MENzTBzQ+gFejZZAAid1rKoKe1bGK5+bJAlX1y3gDTircmmq0YBg==
X-Received: by 2002:a05:6000:402b:b0:38f:4531:3973 with SMTP id
 ffacd0b85a97d-390cc5f7094mr3141387f8f.4.1740501314532; 
 Tue, 25 Feb 2025 08:35:14 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02ce735sm146356195e9.3.2025.02.25.08.35.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 08:35:14 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 04/14] sandbox: add initjmp()
Date: Tue, 25 Feb 2025 17:34:30 +0100
Message-ID: <37f445441e199d9689ae00a386b06dd8a4ebce56.1740499185.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740499185.git.jerome.forissier@linaro.org>
References: <cover.1740499185.git.jerome.forissier@linaro.org>
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
 arch/sandbox/cpu/Makefile         |  11 +-
 arch/sandbox/cpu/initjmp.c        | 172 ++++++++++++++++++++++++++++++
 arch/sandbox/include/asm/setjmp.h |   5 +
 3 files changed, 187 insertions(+), 1 deletion(-)
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
diff --git a/arch/sandbox/include/asm/setjmp.h b/arch/sandbox/include/asm/setjmp.h
index 001c7ea322d..d708e6da3fc 100644
--- a/arch/sandbox/include/asm/setjmp.h
+++ b/arch/sandbox/include/asm/setjmp.h
@@ -31,5 +31,10 @@ typedef struct jmp_buf_data jmp_buf[1];
  */
 int setjmp(jmp_buf jmp);
 __noreturn void longjmp(jmp_buf jmp, int ret);
+/*
+ * initjmp() is non-standard, still it has to play well with the system versions
+ * of setjmp()/longjmp().
+ */
+int initjmp(jmp_buf jmp, void __noreturn (*func)(void), void *stack_top);
 
 #endif /* _SETJMP_H_ */
-- 
2.43.0

