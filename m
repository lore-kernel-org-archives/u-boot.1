Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4298FC02198
	for <u-boot@archiver.kernel.org>; Fri, 14 Feb 2025 14:01:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F278F80EAF;
	Fri, 14 Feb 2025 15:01:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MGq3WpY4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 230F580F0A; Fri, 14 Feb 2025 15:01:05 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E32880C83
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 15:01:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-388cae9eb9fso1049669f8f.3
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 06:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739541662; x=1740146462; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zc5YqeOWjVFGOI9lQwk18URjr1oDar0gNQj5WjUOp00=;
 b=MGq3WpY4/qrbCv2mDbpHVVQWRyEznH3KcwzrJJ0C18R+0v2T72sH3TTIPFlUKJ48xf
 0hCrzUSIAmhAwnByVAEoepkOVEaT+q3v0VLlW0p4Ch5osQ5/y0eh2cjhBuREvG4Ajq2r
 vVnv8SJsZxBoUC25/Qfk+SgqnMbKJ+CH1oelky5sXmdpqeKaDNhrTOmmYaMP0rWIiao8
 rTDrICL90YjkEKUF09axbHwjfBrhAZgibrAt0KoMGoA+vIWLTX49VMzyZzpahGmspnZf
 kszPItOAcAzRDjx4jASQAJA48H3dxT+s9KSWC3bCl0uAOb15Gs/BHIUAPAplKIGnYCBR
 wW1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739541662; x=1740146462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zc5YqeOWjVFGOI9lQwk18URjr1oDar0gNQj5WjUOp00=;
 b=eG7rIry4pM5BYM1CEsyMD9WDKZo7PiFmo+JdvNmdTVwI8Ic7C6cg95u3Ol55AE4vtA
 Y6Pl5uwPFwgEBVIex5cASTf4GiGBn7/JaqHJQRlPY5mVhMAVAmTj6xX0pZ3RS4LI+bO3
 NkSdRd7/zIjTBDZLGYXoMa2igAkXieYCwXj/IE6laaNp12TUwZY6fERjLQgPeRZJbuKi
 /g4XUfoMmr7g5ipF7MpG99RWe6PzGZ6sqA+6kltzui71DDCis/e1UZPXvmmpPv7mxtpE
 rlRbNKkPUSDpNn8NktPp74mIwvKbLC3CMTw7hri7CrU4lS2BkNEv38nMrmQDpBteylwF
 jxEQ==
X-Gm-Message-State: AOJu0YwR0lEsZQMrCvJNBKeB+mX0FTUfDme0unIR0O1nC8W16kGFlsxs
 rbXb2XZT6fbQL/03ci9h7vBu9uT4yYLTgkAz0oYPxLadeR5E/bRURU0zA1hoErQA/AS8Rj55n+2
 uuSOj3Q==
X-Gm-Gg: ASbGncvE1sDlWs2f1ZbNNmvZfCk0bzR3mNKhbu9qrDax1Y2H/6vSb/h4PalA+Wmj9ig
 3XVw9vnJYVC3YuYnkQiscxskLVUJVD49jIy5jr/kUu8J405HsO+K4XXiUPY9AUT5FZcXBraVCEg
 9K7a8w5Us+Z7LEtQML3TN938lG5F71N+pfhW1J1H+q/Qc7V8LOlA15IYKl5ripKU26aQx6jGHSb
 79Rp16c5JVv0+fhNIGddDM0AfefruqLLz9Nno3axFe1ZRQARpjL5b6iPow1AfHtlu2apRXHR8ua
 vUlVvUON8PX8T6hbXLYMEicR
X-Google-Smtp-Source: AGHT+IFVeOCFBne6dYIUUzPvigrNJmIu2xDr83QpEM8giv6P1AO2MCwW/gVuyMbUA4tnTWzOXrqP/A==
X-Received: by 2002:adf:e386:0:b0:38e:c2de:70d4 with SMTP id
 ffacd0b85a97d-38f24512d6amr7751638f8f.42.1739541661170; 
 Fri, 14 Feb 2025 06:01:01 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:65ac:d875:2c3e:607f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258fc7e0sm4666391f8f.48.2025.02.14.06.01.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 06:01:00 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH 04/10] sandbox: add initjmp()
Date: Fri, 14 Feb 2025 15:00:19 +0100
Message-ID: <20250214140031.484344-5-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250214140031.484344-1-jerome.forissier@linaro.org>
References: <20250214140031.484344-1-jerome.forissier@linaro.org>
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

