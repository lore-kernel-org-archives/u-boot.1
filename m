Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0377BC369CA
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 14:12:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF40A83291;
	Fri, 18 Apr 2025 16:11:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="m5xEU4Kj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1625832A1; Fri, 18 Apr 2025 16:11:40 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45DBB81E72
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 16:11:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso19936525e9.1
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 07:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744985497; x=1745590297; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PCOSivW4G25Wr3pzerYd4MtsXVJwWLTDzqpEif7nwzg=;
 b=m5xEU4KjCQK06tvGaaCinQLCGsxW8fIGCj6CQ2IR4gGO/NsFojaRbOFiiNNqJHdrrc
 KfDm8U18MdiIfQ1JCjDWdKHCxjEb/gmRx9yaEFTSwW2MbTRewyPWZTD3/JEPol0CkVn3
 fjqaiSd3OtNs5PLtXaW2DPKSNLw3key287yOIwjb4K3qfJpkRp9kgZrioZrhxEQeB25K
 vsaTXphyG9WsGh6I4+azp5MvmaPZxVAVoHS4QeD1NjyZJY87TzFmTcNEE6zgB8V/OB7C
 X3SHAblCGXTOdPExO3HVCnrzlU21pGUHBx01HTZJwXbvWZH+4eKGtCYDD52uARQClodm
 fi0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744985497; x=1745590297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PCOSivW4G25Wr3pzerYd4MtsXVJwWLTDzqpEif7nwzg=;
 b=pwkE0v5YkCSizTUpQiCHLfwjTKjKQIlLzhRqE08RZ4UpKrnLLPwkVtTZISx4rKAx9c
 FLtIL5e689IpIvwVjN2NJCuYhggGwN+ofwDrE/nkjnRrIwZRRWuSOUqdx7E0N+eTgram
 j835XwnCqCcFKqXDvDs+7HxUoFPuL79cEmFM2zgOghBhEyZ662TewyYzkfm/6VtUCGWN
 CIhot7i7i4S+ExmhhRX7K2ETlZFUW1psz30NbwErEJtcuz0QZFIulVPFb4dXhrwTZqNS
 pKqgYkAubNI5a4A5G7GEyQn3I9GzzAypv/wqQxDqP/gx9U4WsKwKCNP1BBzmwP5iO+9B
 PObQ==
X-Gm-Message-State: AOJu0Yxq+3PDMBNB6l0E9iB40+LE1+SnuNg/zyjx3ucU+iJslyDgGX0G
 /p52XfU3O/6TVwiigFY97trrX2nUsiyAfo+zDqr1in3T0Lo1zLJzXkEqQAGj4LdVlT3DUE8s6m8
 p2tys6Q==
X-Gm-Gg: ASbGncsyaREuv/BkpvymRlYwOYRDkM8bFJOQcoJ0Edh8Iw0mDENeX253Ar0Sl83k+rV
 vAF/nuTDAncGm5EwA7+HY5waguiD4sM1+u+5nZwFBoapZ3N9v4fMmTaz7ZCC2zdjfJ1YwSeRlQn
 fIbf52+vCRa2OhelWGrcr/udMvStgXgdyV3E8PZ1rj0lcPepnLJm62EdiPaac+rjnltEsDlkxzK
 NbuK+Fnka6BdrapHbbnyjGYrba69wUag34Jfs4fWKO18uEwYgsEEcSHkiHZ/mGyAqkOfGeSW1LZ
 S0s5OlF8lE99yVianLkFV/oYXUho+gzHAvmu/XjqVY5ej8/lag==
X-Google-Smtp-Source: AGHT+IECld30JoHBndERL2VG3hIYKKVeU2eoeieVcRGSxellRqJQ4uPSa46xZaNX2BUubts050D2Gg==
X-Received: by 2002:a05:600c:4f12:b0:43d:1b74:e89a with SMTP id
 5b1f17b1804b1-4406ab964dfmr23736475e9.9.1744985497394; 
 Fri, 18 Apr 2025 07:11:37 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:1526:5ffd:d63c:cc85])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5bbcc3sm23734385e9.19.2025.04.18.07.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 07:11:36 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v6 06/17] uthread: add cooperative multi-tasking interface
Date: Fri, 18 Apr 2025 16:09:34 +0200
Message-ID: <20250418141114.2056981-7-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418141114.2056981-1-jerome.forissier@linaro.org>
References: <20250418141114.2056981-1-jerome.forissier@linaro.org>
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

Add a new internal API called uthread (Kconfig symbol: UTHREAD) which
provides cooperative multi-tasking. The goal is to be able to improve
the performance of some parts of U-Boot by overlapping lengthy
operations, and also implement background jobs in the U-Boot shell.
Each uthread has its own stack allocated on the heap. The default stack
size is defined by the UTHREAD_STACK_SIZE symbol and is used when
uthread_create() receives zero for the stack_sz argument.

The implementation is based on context-switching via initjmp()/setjmp()/
longjmp() and is inspired from barebox threads [1]. A notion of thread
group helps with dependencies, such as when a thread needs to block
until a number of other threads have returned.

The name "uthread" comes from "user-space threads" because the
scheduling happens with no help from a higher privileged mode, contrary
to more complex models where kernel threads are defined. But the 'u'
may as well stand for 'U-Boot' since the bootloader may actually be
running at any privilege level and the notion of user vs. kernel may
not make much sense in this context.

[1] https://github.com/barebox/barebox/blob/master/common/bthread.c

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

---

Changes in v6:
- struct uthread: give a name to the void * argument of fn()
- uthread_schedule(): remove useless else after return statement
- Do not initialize static variable 'id' to 0

 doc/api/index.rst   |   1 +
 doc/api/uthread.rst |   7 +++
 include/uthread.h   | 123 +++++++++++++++++++++++++++++++++++++++
 lib/Kconfig         |  21 +++++++
 lib/Makefile        |   2 +
 lib/uthread.c       | 138 ++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 292 insertions(+)
 create mode 100644 doc/api/uthread.rst
 create mode 100644 include/uthread.h
 create mode 100644 lib/uthread.c

diff --git a/doc/api/index.rst b/doc/api/index.rst
index 0dc9ad45d41..506843ed74a 100644
--- a/doc/api/index.rst
+++ b/doc/api/index.rst
@@ -29,3 +29,4 @@ U-Boot API documentation
    sysreset
    timer
    unicode
+   uthread
diff --git a/doc/api/uthread.rst b/doc/api/uthread.rst
new file mode 100644
index 00000000000..21233ff6b22
--- /dev/null
+++ b/doc/api/uthread.rst
@@ -0,0 +1,7 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Uthread API
+===========
+
+.. kernel-doc:: include/uthread.h
+   :internal:
diff --git a/include/uthread.h b/include/uthread.h
new file mode 100644
index 00000000000..f796a16f25f
--- /dev/null
+++ b/include/uthread.h
@@ -0,0 +1,123 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2025 Linaro Limited
+ */
+
+#include <linux/list.h>
+#include <linux/types.h>
+#include <setjmp.h>
+
+#ifndef _UTHREAD_H_
+#define _UTHREAD_H_
+
+/**
+ * DOC: Overview
+ *
+ * The uthread framework is a basic task scheduler that allows to run functions
+ * "in parallel" on a single CPU core. The scheduling is cooperative, not
+ * preemptive -- meaning that context switches from one task to another task is
+ * voluntary, via a call to uthread_schedule(). This characteristic makes thread
+ * synchronization much easier, because a thread cannot be interrupted in the
+ * middle of a critical section (reading from or writing to shared state, for
+ * instance).
+ *
+ * CONFIG_UTHREAD in lib/Kconfig enables the uthread framework. When disabled,
+ * the uthread_create()  and uthread_schedule() functions may still be used so
+ * that code differences between uthreads enabled and disabled can be reduced to
+ * a minimum.
+ */
+
+/**
+ * struct uthread - a thread object
+ *
+ * @fn: thread entry point
+ * @arg: argument passed to the entry point when the thread is started
+ * @ctx: context to resume execution of this thread (via longjmp())
+ * @stack: initial stack pointer for the thread
+ * @done: true once @fn has returned, false otherwise
+ * @grp_id: user-supplied identifier for this thread and possibly others. A
+ * thread can belong to zero or one group (not more), and a group may contain
+ * any number of threads.
+ * @list: link in the global scheduler list
+ */
+struct uthread {
+	void (*fn)(void *arg);
+	void *arg;
+	jmp_buf ctx;
+	void *stack;
+	bool done;
+	unsigned int grp_id;
+	struct list_head list;
+};
+
+#ifdef CONFIG_UTHREAD
+
+/**
+ * uthread_create() - Create a uthread object and make it ready for execution
+ *
+ * Threads are automatically deleted when they return from their entry point.
+ *
+ * @uthr: a pointer to a user-allocated uthread structure to store information
+ * about the new thread, or NULL to let the framework allocate and manage its
+ * own structure.
+ * @fn: the thread's entry point
+ * @arg: argument passed to the thread's entry point
+ * @stack_sz: stack size for the new thread (in bytes). The stack is allocated
+ * on the heap.
+ * @grp_id: an optional thread group ID that the new thread should belong to
+ * (zero for no group)
+ */
+int uthread_create(struct uthread *uthr, void (*fn)(void *), void *arg,
+		   size_t stack_sz, unsigned int grp_id);
+/**
+ * uthread_schedule() - yield the CPU to the next runnable thread
+ *
+ * This function is called either by the main thread or any secondary thread
+ * (that is, any thread created via uthread_create()) to switch execution to
+ * the next runnable thread.
+ *
+ * Return: true if a thread was scheduled, false if no runnable thread was found
+ */
+bool uthread_schedule(void);
+/**
+ * uthread_grp_new_id() - return a new ID for a thread group
+ *
+ * Return: the new thread group ID
+ */
+unsigned int uthread_grp_new_id(void);
+/**
+ * uthread_grp_done() - test if all threads in a group are done
+ *
+ * @grp_id: the ID of the thread group that should be considered
+ * Return: false if the group contains at least one runnable thread (i.e., one
+ * thread which entry point has not returned yet), true otherwise
+ */
+bool uthread_grp_done(unsigned int grp_id);
+
+#else
+
+static inline int uthread_create(struct uthread *uthr, void (*fn)(void *),
+				 void *arg, size_t stack_sz,
+				 unsigned int grp_id)
+{
+	fn(arg);
+	return 0;
+}
+
+static inline bool uthread_schedule(void)
+{
+	return false;
+}
+
+static inline unsigned int uthread_grp_new_id(void)
+{
+	return 0;
+}
+
+static inline bool uthread_grp_done(unsigned int grp_id)
+{
+	return true;
+}
+
+#endif /* CONFIG_UTHREAD */
+#endif /* _UTHREAD_H_ */
diff --git a/lib/Kconfig b/lib/Kconfig
index ac34ec45bb1..b2aecd8a49e 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -1258,6 +1258,27 @@ config PHANDLE_CHECK_SEQ
 	  enable this config option to distinguish them using
 	  phandles in fdtdec_get_alias_seq() function.
 
+config UTHREAD
+	bool "Enable thread support"
+	depends on HAVE_INITJMP
+	help
+	  Implement a simple form of cooperative multi-tasking based on
+	  context-switching via initjmp(), setjmp() and longjmp(). The
+	  uthread_ interface enables the main thread of execution to create
+	  one or more secondary threads and schedule them until they all have
+	  returned. At any point a thread may suspend its execution and
+	  schedule another thread, which allows for the efficient multiplexing
+	  of leghthy operations.
+
+config UTHREAD_STACK_SIZE
+	int "Default uthread stack size"
+	depends on UTHREAD
+	default 32768
+	help
+	  The default stack size for uthreads. Each uthread has its own stack.
+	  When the stack_sz argument to uthread_create() is zero then this
+	  value is used.
+
 endmenu
 
 source "lib/fwu_updates/Kconfig"
diff --git a/lib/Makefile b/lib/Makefile
index 7178c5a3e3c..18ae0cd87bf 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -159,6 +159,8 @@ obj-$(CONFIG_LIB_ELF) += elf.o
 
 obj-$(CONFIG_$(PHASE_)SEMIHOSTING) += semihosting.o
 
+obj-$(CONFIG_UTHREAD) += uthread.o
+
 #
 # Build a fast OID lookup registry from include/linux/oid_registry.h
 #
diff --git a/lib/uthread.c b/lib/uthread.c
new file mode 100644
index 00000000000..aa264b1d95f
--- /dev/null
+++ b/lib/uthread.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021 Ahmad Fatoum, Pengutronix
+ * Copyright (C) 2025 Linaro Limited
+ *
+ * An implementation of cooperative multi-tasking inspired from barebox threads
+ * https://github.com/barebox/barebox/blob/master/common/bthread.c
+ */
+
+#include <compiler.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <malloc.h>
+#include <setjmp.h>
+#include <stdint.h>
+#include <uthread.h>
+
+static struct uthread main_thread = {
+	.list = LIST_HEAD_INIT(main_thread.list),
+};
+
+static struct uthread *current = &main_thread;
+
+/**
+ * uthread_trampoline() - Call the current thread's entry point then resume the
+ * main thread.
+ *
+ * This is a helper function which is used as the @func argument to the
+ * initjmp() function, and ultimately invoked via setjmp(). It does not return
+ * but instead longjmp()'s back to the main thread.
+ */
+static void __noreturn uthread_trampoline(void)
+{
+	struct uthread *curr = current;
+
+	curr->fn(curr->arg);
+	curr->done = true;
+	current = &main_thread;
+	longjmp(current->ctx, 1);
+	/* Not reached */
+	while (true)
+		;
+}
+
+/**
+ * uthread_free() - Free memory used by a uthread object.
+ */
+static void uthread_free(struct uthread *uthread)
+{
+	if (!uthread)
+		return;
+	free(uthread->stack);
+	free(uthread);
+}
+
+int uthread_create(struct uthread *uthr, void (*fn)(void *), void *arg,
+		   size_t stack_sz, unsigned int grp_id)
+{
+	bool user_allocated = false;
+
+	if (!stack_sz)
+		stack_sz = CONFIG_UTHREAD_STACK_SIZE;
+
+	if (uthr) {
+		user_allocated = true;
+	} else {
+		uthr = calloc(1, sizeof(*uthr));
+		if (!uthr)
+			return -1;
+	}
+
+	uthr->stack = memalign(16, stack_sz);
+	if (!uthr->stack)
+		goto err;
+
+	uthr->fn = fn;
+	uthr->arg = arg;
+	uthr->grp_id = grp_id;
+
+	list_add_tail(&uthr->list, &current->list);
+
+	initjmp(uthr->ctx, uthread_trampoline, uthr->stack, stack_sz);
+
+	return 0;
+err:
+	if (!user_allocated)
+		free(uthr);
+	return -1;
+}
+
+/**
+ * uthread_resume() - switch execution to a given thread
+ *
+ * @uthread: the thread object that should be resumed
+ */
+static void uthread_resume(struct uthread *uthread)
+{
+	if (!setjmp(current->ctx)) {
+		current = uthread;
+		longjmp(uthread->ctx, 1);
+	}
+}
+
+bool uthread_schedule(void)
+{
+	struct uthread *next;
+	struct uthread *tmp;
+
+	list_for_each_entry_safe(next, tmp, &current->list, list) {
+		if (!next->done) {
+			uthread_resume(next);
+			return true;
+		}
+		/* Found a 'done' thread, free its resources */
+		list_del(&next->list);
+		uthread_free(next);
+	}
+	return false;
+}
+
+unsigned int uthread_grp_new_id(void)
+{
+	static unsigned int id;
+
+	return ++id;
+}
+
+bool uthread_grp_done(unsigned int grp_id)
+{
+	struct uthread *next;
+
+	list_for_each_entry(next, &main_thread.list, list) {
+		if (next->grp_id == grp_id && !next->done)
+			return false;
+	}
+
+	return true;
+}
-- 
2.43.0

