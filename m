Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02881C282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 10:48:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FA3581CC5;
	Tue, 18 Mar 2025 11:47:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xKbX+ArU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1C46800B3; Tue, 18 Mar 2025 11:47:30 +0100 (CET)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F9BB80107
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 11:47:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-43cfdc2c8c9so18215055e9.2
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 03:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742294847; x=1742899647; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+tmM38K8tIdiO7TPc0HndOjbZ2fOYyIuvmRuc6vMa/c=;
 b=xKbX+ArU+SUK4Dj8gA5g+l714CHLGOAh5Mnpcluv3xWD045OEv1aCqHbB10b6CYRdv
 cUeQxtGguF7Vy2EZ5PhXwUmX1RyGFNVKtH+4upO2UfVjelj0MEPz/nIE3kp+JdfEzIun
 UzaCRSACCLefh5lzfjBMEAXXk+gpYaLz9OtfikMZUKzcw7LipL04Z6ACxWbZWLwprdfD
 2NHiuM7W4tGUOQJxDNFCV7aP8NZbfoF/s0Nc17/+H3uatLmTdoDEhQqsJkCiwhpRSW+y
 fgopSpGlCVRGI7g7sDApLi6Je5e2DE+pjrcyq+6OXdrLnPjmG1Q9SbJZJwJ8D4XrBmN1
 eyig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742294847; x=1742899647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+tmM38K8tIdiO7TPc0HndOjbZ2fOYyIuvmRuc6vMa/c=;
 b=QQmUGCo3Gp/46Qe0RSuip3qu7dyC+I5gwXnyG3fI6lsguqzJy94Z2fT1bG32lJ1F4E
 hqCaKyQ8sDFb1TpocW96QjdXJD18jQykvwa6owiNuupjfNT9PALpWSdyMqjtXWZ2LdOv
 HLkcq9sD4TXt+rhwL9diK5lHB8wnk0AgHERRp7U21wz7SQoC+PFJ98FgYulJcA642o3P
 y3oAzIkrgfVQYkXynQoDH35SP1Rmzh66/2S9N1hfottg+j2ls4Fiw6+OS8JHQtwSQWxa
 K6few93bE37OMPzgepoTdB3ySlOCIZu6atU4cY5imhhpGHEij/EGp335WDy+VljcEvjT
 qHKw==
X-Gm-Message-State: AOJu0YwNZZ56AoslTsR8JRNzDCy8abKgZvZwwowtpOIO61SLOgGr2s+S
 GaovSEHQt3k5lYJ3rja3s/6yabKs0y23dmVMqld/rbkvuDj6jPV8yVorhrbpo7lBm131MLt2Gyz
 8ry9SpA==
X-Gm-Gg: ASbGncsLQ7E8Vu5HefVe6qNHVGOh3MpK05Acd9IXHlx9I2xA8gd4zOAGbzXHeT8gbx6
 BR+VrOEDXo4UWpc5ONz8XWj682mF/VyBfHIkGpKtGbkiwp225AWQnVRfxw7asWJjnv0fIxxzd4s
 KNomHBamQ5WhHNmvoOoFA5uP+sviSEaNDyqTqKQyspbcxpUv+kZpSNDZtqM09fOw2pnvb1hnzDh
 jrPghOQ8q0zR4gNGenqjpZbKX9fdWqkwB3jFcS2iwNHuDiGtZyzv/LaA0BEts4lP3k4inEk1u8U
 RGAqpfsnPCPUO1eMrqYUZh64Prh4c0xHCsnmgDARjcnJRXmPnI1Qsg==
X-Google-Smtp-Source: AGHT+IGbxkEgo5g501Bh+1ukjD/wHE84QLMdniPtMHTFtjXOsRvzoRdbs2FvwAYyr6vGhMPX/xQOkw==
X-Received: by 2002:a05:600c:354d:b0:43c:ea40:ae4a with SMTP id
 5b1f17b1804b1-43d3ba14c74mr14023785e9.31.1742294847342; 
 Tue, 18 Mar 2025 03:47:27 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:78bd:2e7e:120c:26bb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fdda2dbsm131788185e9.2.2025.03.18.03.47.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 03:47:27 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Michal Simek <michal.simek@amd.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v4 06/14] uthread: add cooperative multi-tasking interface
Date: Tue, 18 Mar 2025 11:46:42 +0100
Message-ID: <20250318104659.1114340-7-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318104659.1114340-1-jerome.forissier@linaro.org>
References: <20250318104659.1114340-1-jerome.forissier@linaro.org>
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
 doc/api/index.rst   |   1 +
 doc/api/uthread.rst |   7 +++
 include/uthread.h   | 123 +++++++++++++++++++++++++++++++++++++++
 lib/Kconfig         |  21 +++++++
 lib/Makefile        |   2 +
 lib/uthread.c       | 139 ++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 293 insertions(+)
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
index 00000000000..ec3034c097a
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
+	void (*fn)(void *);
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
index a21b3378fa7..db9debaaeeb 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -1255,6 +1255,27 @@ config PHANDLE_CHECK_SEQ
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
index a30ce1595d5..cd7d04528c6 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -160,6 +160,8 @@ obj-$(CONFIG_LIB_ELF) += elf.o
 
 obj-$(CONFIG_$(PHASE_)SEMIHOSTING) += semihosting.o
 
+obj-$(CONFIG_UTHREAD) += uthread.o
+
 #
 # Build a fast OID lookup registry from include/linux/oid_registry.h
 #
diff --git a/lib/uthread.c b/lib/uthread.c
new file mode 100644
index 00000000000..c3f6c84c234
--- /dev/null
+++ b/lib/uthread.c
@@ -0,0 +1,139 @@
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
+		} else {
+			/* Found a 'done' thread, free its resources */
+			list_del(&next->list);
+			uthread_free(next);
+		}
+	}
+	return false;
+}
+
+unsigned int uthread_grp_new_id(void)
+{
+	static unsigned int id = 0;
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

