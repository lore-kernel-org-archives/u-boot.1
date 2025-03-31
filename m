Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD5DBC3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 12:32:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B814381F66;
	Mon, 31 Mar 2025 14:31:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="J5UPVyiA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A89E781703; Mon, 31 Mar 2025 14:31:40 +0200 (CEST)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1112881E47
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 14:31:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-3913d129c1aso3238047f8f.0
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 05:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743424297; x=1744029097; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GERz7uJbPWQNt9gxwTX7plSa3IWAbbNTwGxUI2CBlZg=;
 b=J5UPVyiAMhXJSMsEPpmiXXaCXEwpehvdE22epeJZQQa3W9tFoUrmWA6M1hl0fYTP6z
 bBZzospeCAKHv+xJ5aqwp1eEeIOHrYt6aRCHJYAfjoLpN9Z4TVC5JMlf0g48wMl0GON8
 QpETHeAF+TdGb3boUCmH9BECyylkIEkIgbF0ZZuV/GShM8K5JmWqtphsESNRHm+c0I85
 9F/jmC+uCUayDJCXGdInptH1mHxf5TaHvFkXseeAp2nbcoXqNFMDY0aLKqOSxE3syCQ+
 5lWUXjcKBb7OmUXPevrlxek7ZSXmDS5HVYHSXJEq8BhtXY7h9Ntm4prUil6V2juIspAq
 kGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743424297; x=1744029097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GERz7uJbPWQNt9gxwTX7plSa3IWAbbNTwGxUI2CBlZg=;
 b=Os83RJFsZev1mwI1USIHGS3SFtWBv8INcSD9vjhgJjmkq7dTTg347II/ihmxGXdFg0
 TmHjgYBS1/szKJ2kkJyN2CLgzIhDQh72aewftndUL04zELsgY50HFIaUqo0g9c+A/geO
 pCT7nDPFQdMDWm7j6+DkEcOwrkcY+VeWL4MNWQiVlKXS5bSozRwy/o0LKKio8W7Cnsyl
 /rlp9Y8QbIeMm7jreJTC+Omnu6zH1jJmA+rjHfPrY77gO3nL0LVeEKhc0LwhhfpZ4B0n
 bclP4RFoiQOD8sGhS0jBLu/JbS/g2yC7VCmo8VFg+5Br/6ejYL6Ml/rpgvfof2H0B8gZ
 TYmA==
X-Gm-Message-State: AOJu0YxJ2zNLVaRbs0h1mTa4gm34DwtQchqMNA1yi9plOJFSTZfAUVfl
 DNSBrKn47Nzl61a1NOaMyDtDczQLi7AreIQEDgQvzqNd/9Hh/f1EO70jfzK97bSU38zJdz72f2O
 KEvFZ9n2s
X-Gm-Gg: ASbGncsvFO8b42G1OsAQtayy+/ieU3PIwMgA1CQHWuMRaa3297KaY90zbx2xxUhHjHF
 hc/2dZs+tjqUvEZkOq3KrKweDApwEa92E6bb2get6N1j+Vr8HBTks8fr+RkZIYMccpf7fnWlGky
 AOdrVxwrLTSirWWnJtuNorknCxyX7xla8xoltDeaDwSZG4A9b0q18GhY7aiyuLySarQG9n+abha
 jqgRKGuqbrygNi1diw9uPi32s+z60SkfANXXHiE9eFD8LKBo0FzFTq15AlvSFKwiDzr/IdHIjs4
 n3EsXHca7hJaNC4H3zsjhF1rnpmiAV5iF+Cs86ycVnhfgmMyA9il
X-Google-Smtp-Source: AGHT+IG5yXiJ+U/NJQGp1XqAi4aidfCIWduoY27ZY6lWqKxj0TxCIszFKN2QgYRKD85CCo28f7Qndw==
X-Received: by 2002:a05:6000:1acc:b0:38f:4ffd:c757 with SMTP id
 ffacd0b85a97d-39c11b76660mr7348859f8f.2.1743424297212; 
 Mon, 31 Mar 2025 05:31:37 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:f23c:25c9:dc74:be1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b6589e4sm11337029f8f.10.2025.03.31.05.31.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 05:31:36 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 04/16] sandbox: add initjmp()
Date: Mon, 31 Mar 2025 14:30:58 +0200
Message-ID: <20250331123120.2025062-5-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250331123120.2025062-1-jerome.forissier@linaro.org>
References: <20250331123120.2025062-1-jerome.forissier@linaro.org>
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

Add initjm[() to sandbox, a non-standard extension to setjmp()/
longjmp() allowing to initialize a jump buffer with a function pointer
and a stack pointer. This will be useful to later introduce threads.
With this new function it becomes possible to longjmp() to a particular
function pointer (rather than to a point previously reached during
program execution as is the case with setjmp()), and with a custom stack.
Both things are needed to spin off a new thread. Then the usual
setjmp()/longjmp() pair is enough to save and restore a context, i.e.,
switch thread. The implementation is taken verbatim from barebox [1] with
the exception of the additional stack_sz argument. It is quite complex
because contrary to U-Boot platform code we don't know how the system's
C library implements the jump buffer, so we can't just write the function
and stack pointers into it.

[1] https://github.com/barebox/barebox/blob/b2a15c383ddc/arch/sandbox/os/setjmp.c

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 arch/sandbox/cpu/Makefile  |  11 ++-
 arch/sandbox/cpu/initjmp.c | 175 +++++++++++++++++++++++++++++++++++++
 2 files changed, 185 insertions(+), 1 deletion(-)
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
index 00000000000..6e72d32cb4b
--- /dev/null
+++ b/arch/sandbox/cpu/initjmp.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * An implementation of initjmp() in C, that plays well with the system's
+ * setjmp() and longjmp() functions.
+ * Taken verbatim from arch/sandbox/os/setjmp.c in the barebox project.
+ * Modified so that initjmp() accepts a stack_size argument.
+ *
+ * Copyright (C) 2006  Anthony Liguori <anthony@codemonkey.ws>
+ * Copyright (C) 2011  Kevin Wolf <kwolf@redhat.com>
+ * Copyright (C) 2012  Alex Barcelo <abarcelo@ac.upc.edu>
+ * Copyright (C) 2021  Ahmad Fatoum, Pengutronix
+ * Copyright (C) 2025  Linaro Ltd.
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
+int __attribute__((weak)) initjmp(_jmp_buf jmp, void (*func)(void),
+				  void *stack_base, size_t stack_size)
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
+	ss.ss_sp = stack_base;
+	ss.ss_size = stack_size;
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

