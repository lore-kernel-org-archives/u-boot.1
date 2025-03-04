Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B22DC021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 15:34:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0923F814A4;
	Tue,  4 Mar 2025 16:32:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="frS0SB5X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF955811B3; Tue,  4 Mar 2025 16:32:13 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 705B180F56
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 16:32:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43bcc02ca41so7917765e9.0
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 07:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741102294; x=1741707094; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y5+FHnnKlOsm/zGfnc1QpeuPrzdz/XlW9L07/HBqKxg=;
 b=frS0SB5X1xOxxhqk5uxiQgmErVfsXlja0EWVsXSaIRZyOt10axj197Q6mGWv09XuwZ
 S39YQvya+f1+L80jSfcoHoeIW5hL/sjhyvmMBTsKUacx2+Fi9xHsK90rM9iJBtUEpd22
 rqXPsxTD9z/GdQTnck41mst3HUF6P9uGCUPYfQ0Q8XCtWz8VLh36k40CzFwvhdylt5rF
 4ER9On0KC+3YHTvza2fTESr1g+HGSnPmx6ZzQQPQKoUdjCk3eZIx5ShXhIHBQ9MTkdHh
 csHjAUubj6ncRu8Gnz+Vq6ne1AiyCpWYD+h74CZo0pUOvkqv3Mn5o2G26fwB/QAgBXd2
 SOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741102294; x=1741707094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y5+FHnnKlOsm/zGfnc1QpeuPrzdz/XlW9L07/HBqKxg=;
 b=wGyQGbm31GTbGb9SZD81VSrVXt8A3C1YB4sN3/WEB8TZ81spjIHJPsAGOVITyR3+Df
 jqeXizGOjxkekftQ1JAs21wWf2bIAskcVZC/spzOT1+s4QQ7QK5MRTSocS/Lwly3nJZ1
 xIyXwURTuDSbxSo5clNX+lGHaiQgQ/KTUOnsuYB5wiTT/EPTQjhj2FE/Cw7aA/hJlpBG
 m1j2TFUnHQUItSNzHK0/+l81I6VFpBjEbY/xXerc/0w6aT6mT6Ktrc+j6p1CQ0K7Y/AX
 fs34duMZrOMhH8fzRUR3M1iHkF8EpFJSI30IrEjshil/jinA2daZNvV5Azl1yp5L9Jp6
 qPLg==
X-Gm-Message-State: AOJu0YxGzBQZqLxNn3Vb0KXjPPWekf1Jsyyr/aUPfI+i7H4dE9SITje1
 jQpLrXFWZI8BOisP60YI4Qvnnbv6SI59/KnSaOiN7srrAenO9YynXDOAovk1i13PeqUR/3zOUIO
 d
X-Gm-Gg: ASbGncvQxhaw5iVqt+/gVKl004w8KuJa7ZwckZXyvfV+ZCIq8RisRfhfQ/epKhjLMRQ
 Z3unf9Ej54kGLTBqwc5iHM+JGeV9bunX/Y1OvycWSOH1b9n7SQmjpurcIs2Kr1xHSWXYpfNqfMU
 PhBGKURuN6QoeTg88dDX4V7ZEtB1TxCDD2uBpb0XlPHT+AzV/4Blcp2j4QTV/AzRPmtrOuJp65D
 HwYKTE17JafUV5nhvoO9qGzvgF9Z0EpIG93FoEu3K/T4SMKPHVyUg5Oa7rzqsKAxbylMIkE+riZ
 0NohcmpnXOu84EzBUMo3p67Bd2K+5aocQhYkjgU8UrMfPlIynVNBew==
X-Google-Smtp-Source: AGHT+IE4uC2iRzVeNR0X5r1Qej7KyPjYgyJOBcLET+Ff1AYvsgbu6GQOZ1BI9nf70JOaCO5/wEmJPg==
X-Received: by 2002:a05:600c:1384:b0:439:8bc3:a698 with SMTP id
 5b1f17b1804b1-43ba66e5e9bmr145889065e9.6.1741102293911; 
 Tue, 04 Mar 2025 07:31:33 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:771e:3d0f:d9c9:2f92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e485db82sm17669254f8f.88.2025.03.04.07.31.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 07:31:33 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v3 06/14] uthread: add cooperative multi-tasking interface
Date: Tue,  4 Mar 2025 16:24:54 +0100
Message-ID: <20250304152510.2832340-7-jerome.forissier@linaro.org>
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
index 1a683dea670..8321f20e154 100644
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
index a7bc2f3134a..3610694de7a 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -164,6 +164,8 @@ obj-$(CONFIG_LIB_ELF) += elf.o
 
 obj-$(CONFIG_$(PHASE_)SEMIHOSTING) += semihosting.o
 
+obj-$(CONFIG_UTHREAD) += uthread.o
+
 #
 # Build a fast OID lookup registry from include/linux/oid_registry.h
 #
diff --git a/lib/uthread.c b/lib/uthread.c
new file mode 100644
index 00000000000..3cb25784556
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
+	initjmp(uthr->ctx, uthread_trampoline, uthr->stack + stack_sz);
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

