Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47FEFC021B8
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 16:36:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E06A480F53;
	Tue, 25 Feb 2025 17:35:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZoN8PFRf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3171807EE; Tue, 25 Feb 2025 17:35:20 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79B7480FED
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 17:35:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-38f5fc33602so3387808f8f.0
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 08:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740501318; x=1741106118; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D6Dmo3k63v8InZm1ge4XlbDH+XbCJvJuN1AGsB+nbZ8=;
 b=ZoN8PFRflyj4Vd/nqE17Xqk7dJXKehuyGx1GULnhM/tl0G0gwjYYOzBCJcuBNXoPXs
 RPNwWIoZIYDk+Hkj7EMKZxW9IhknZctM8HX3PGg3h7a/oIS22SCUyphcckE3rZPZMSzP
 VEeYmses3TiatrS36IKd76l9pymihXKXiu/WdZfuHDiJ/H7h//0RKyIbLPdAuRQ54iXw
 3AG//V8QWiPiNMIj8jom4KrHy+1enfMXGUycc2C+kL7OqQIjW5rntnOfXnI4/FQ46GoT
 YYxGwL9zJi9ADlIWbXZ1rdBDLfWry4wENmmeUGbLarqzWrKjiI5DMgBtxCDDn3oCdLnA
 xM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740501318; x=1741106118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D6Dmo3k63v8InZm1ge4XlbDH+XbCJvJuN1AGsB+nbZ8=;
 b=THNE+OpEA1G5V1TMFzOvtXIH+NrsvvtdCgMKWHHrUa0YVBV+NsbYvEDk2JKbt7c1G2
 8gDsXEqQfntVO+ont7h3gZqZDY28t/K8OA7DSxi9MNOprcOIBudogWDP85+9bbBEkMcx
 bJKDJTFKQfdpYuGrxnSBYczxHKfhHIbSeghXKuJGClcrWfbfjaRoTADfclk+WuLxcbES
 7RqNoshx2Mai+bfxJy9V1iOgf4NVYl0pEmPELkUn/TTstaj8zZKsBpgeYOIWjR8pCwmf
 4Dgwo583TBvT4wjAzOwlSfU7RZPJnpmLxKlIA/YsX92/iRI6QoJKAIvb0JuNS0Vrz5dg
 zhSw==
X-Gm-Message-State: AOJu0YypiYhxB+EU6svmfSA2aODZO2zGTbmFtPVGGp9EZewx1tyNh1lc
 5PO9AoniQCWLA2NSgImmbOY9RkrZuNtGe5QDdPvtWcf2EKDj9cAXXYTNdyXM87D2fxaGqjTFGjh
 rz4ntSw==
X-Gm-Gg: ASbGnctomwBEGhZjrXiC83GpfDzXG3ulY6VZC7JyQb8xUvhnKnxYOjf943s8e4MI1G5
 Lr0C5+SpP5inJMBM3SItzBkhvQbk/B/Nt9Re0VU2cPlZqV1AkuCirfE8w77muVKJjJWP2SGiX2Y
 NM29IX4OVD8nWutXwEEiwQ8vW9W3q1t1761bo6gxxSTKHGzVYt5O6CgWoZ4v/RPLQhWqkEC6sc3
 WLo9CfCYyCdsUKWjOGDruPDeolwM5BF9XUL/cbcbP1mryXJ1gulY16kA9PKyhPpYYhgcekyoqGF
 UEE1A372aIuxvuATM8Uih9u+oabgSbgl/rY=
X-Google-Smtp-Source: AGHT+IEtYqoXl1PLin9yL+ACet3S1WQMrGaynlkh5ENfiGKuJ9McqmWCDocS3OMAfk+LGyHW1TOpgA==
X-Received: by 2002:a5d:6d09:0:b0:38f:4f37:7504 with SMTP id
 ffacd0b85a97d-38f615be1c7mr18930983f8f.16.1740501317686; 
 Tue, 25 Feb 2025 08:35:17 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02ce735sm146356195e9.3.2025.02.25.08.35.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 08:35:17 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Michal Simek <michal.simek@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v2 06/14] uthread: add cooperative multi-tasking interface
Date: Tue, 25 Feb 2025 17:34:32 +0100
Message-ID: <0b793a3251dbd9cf41066e3e358269fdb1aac3f8.1740499185.git.jerome.forissier@linaro.org>
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

Add an new internal API called uthread (Kconfig symbol: UTHREAD) which
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
 include/uthread.h |  44 ++++++++++++
 lib/Kconfig       |  21 ++++++
 lib/Makefile      |   2 +
 lib/uthread.c     | 178 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 245 insertions(+)
 create mode 100644 include/uthread.h
 create mode 100644 lib/uthread.c

diff --git a/include/uthread.h b/include/uthread.h
new file mode 100644
index 00000000000..f1f86d210d5
--- /dev/null
+++ b/include/uthread.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2025 Linaro Limited
+ */
+
+#include <linux/types.h>
+
+#ifndef _UTHREAD_H_
+#define _UTHREAD_H_
+
+#ifdef CONFIG_UTHREAD
+
+int uthread_create(void (*fn)(void *), void *arg, size_t stack_sz,
+		   unsigned int grp_id);
+bool uthread_schedule(void);
+unsigned int uthread_grp_new_id(void);
+bool uthread_grp_done(unsigned int grp_id);
+
+#else
+
+static inline int uthread_create(void (*fn)(void *), void *arg, size_t stack_sz,
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
index 1a683dea670..b32740ecbcc 100644
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
+	  The default stak size for uthreads. Each uthread has its own stack.
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
index 00000000000..430d1c0de32
--- /dev/null
+++ b/lib/uthread.c
@@ -0,0 +1,178 @@
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
+#include <asm/setjmp.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <malloc.h>
+#include <stdint.h>
+#include <uthread.h>
+
+static struct uthread {
+	void (*fn)(void *);
+	void *arg;
+	jmp_buf ctx;
+	void *stack;
+	bool done;
+	unsigned int grp_id;
+	struct list_head list;
+} main_thread = {
+	.list = LIST_HEAD_INIT(main_thread.list),
+};
+
+static struct uthread *current = &main_thread;
+
+/**
+ * uthread_trampoline() - Call the current thread's entry point then resume the
+ * main thread.
+ *
+ * This is a helper function which is used as the @func argument to the inijmp()
+ * function, and ultimately invoked via setjmp(). It does not return, but
+ * instead longjmp()'s back to the main thread.
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
+/**
+ * uthread_create() - Create a uthread object and make it ready for execution
+ *
+ * Threads are automatically deleted when then return from their entry point.
+ *
+ * @fn: the thread's entry point
+ * @arg: argument passed to the thread's entry point
+ * @stack_sz: stack size for the new thread (in bytes). The stack is allocated
+ * on the heap.
+ * @grp_id: an optional thread group ID that the new thread should belong to
+ * (zero for no group)
+ */
+int uthread_create(void (*fn)(void *), void *arg, size_t stack_sz,
+		   unsigned int grp_id)
+{
+	struct uthread *uthread;
+
+	if (!stack_sz)
+		stack_sz = CONFIG_UTHREAD_STACK_SIZE;
+
+	uthread = calloc(1, sizeof(*uthread));
+	if (!uthread)
+		return -1;
+
+	uthread->stack = memalign(16, stack_sz);
+	if (!uthread->stack)
+		goto err;
+
+	uthread->fn = fn;
+	uthread->arg = arg;
+	uthread->grp_id = grp_id;
+
+	list_add_tail(&uthread->list, &current->list);
+
+	initjmp(uthread->ctx, uthread_trampoline, uthread->stack + stack_sz);
+
+	return 0;
+err:
+	uthread_free(uthread);
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
+/**
+ * uthread_schedule() - yield the CPU to the next runnable thread
+ *
+ * This function is called either by the main thread or any secondary thread
+ * (that is, any thread created via uthread_create()) to switch execution to
+ * the next runnable thread.
+ *
+ * Return: true if a thread was scheduled, false if no runnable thread was found
+ */
+bool uthread_schedule(void)
+{
+	struct uthread *next;
+	struct uthread *tmp;
+
+	if (list_empty(&current->list))
+	    return false;
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
+/**
+ * uthread_grp_new_id() - return a new ID for a thread group
+ *
+ * Return: the new thread group ID
+ */
+unsigned int uthread_grp_new_id(void)
+{
+	static unsigned int id = 0;
+
+	return ++id;
+}
+
+/**
+ * uthread_grp_done() - test if all threads in a group are done
+ *
+ * @grp: the ID of the thread group that should be considered
+ * Return: false if the group contains at least one runnable thread (i.e., one
+ * thread which entry point has not returned yet), true otherwise
+ */
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

