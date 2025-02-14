Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AFC4C021A4
	for <u-boot@archiver.kernel.org>; Fri, 14 Feb 2025 14:02:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA8BD80F57;
	Fri, 14 Feb 2025 15:01:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hqWUFUKL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6235980F3F; Fri, 14 Feb 2025 15:01:09 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E807F80E88
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 15:01:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4395dddb07dso22069715e9.2
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 06:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739541666; x=1740146466; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rQWcMVhiDsInzul+8CcxPqL1KlSPSKMbGE8a9Q4ktAU=;
 b=hqWUFUKLqatwjZyIy0Ycz1gSu6QyGok7oySUh2Oj218Y8YyBpIOwgv/4ACj7MKBsYj
 DPlzNJnVv3l6Q4/V3GE0IcuGplYpJjgOJ3XawNSrlI0ABBR+riOs6iKUJWd2i9RLsnJc
 EjIOoI7KZkwfOvB35Yf4JdI5Zs6AXSH3gXmyM9JAsPu1ownxlFf66TxBtDec5NZcXCeD
 1wKxcIZ32+GxsZHW8eVQ7P5elAs8yKcwPHeYWUSuX6u37H5lqFsYr9NaY7+X8TB4Xkvr
 UREkdmmdCsamJrJQ2a2EeDSnD+nt5sM8K24DIRoxWnvNB59cSTBgBMoaAuvNE60j0nhX
 27ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739541666; x=1740146466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rQWcMVhiDsInzul+8CcxPqL1KlSPSKMbGE8a9Q4ktAU=;
 b=Az6IL8ULO6c76N00ZPo1YFYPAL37k3gxmCBd6uWg79AE9l7ujS7/KAvw9M9TUbnMt3
 GTz+fTbjCuNad03ddi8WhGWwcxG1mSWDG77NSdU30iyUj/PFbf86jMe6Ube/P+80bih3
 cYpBRHftAIl4YGNUrXIRqxunElVpSgZJ2a3wf6D/Soz0JBn/Ngoja0awUcZTxUYLBRUt
 0mPYubN1IkgMKFcOSV/gF69cj8qtVGKRVGJBo6SRYyD18l8UQsELBqRyRqoO5j2Mjuuu
 knsol+kHsA+/uEWJlNmFeB/WgrjHOrzzHRzLCA6RR2lUuS2Pbk5S7rScP4a1G51PRkA5
 h4QQ==
X-Gm-Message-State: AOJu0Yy1wYIyIR+iItWsyyE1tpAV2E5Go4pE7Oa79d/AptFgS9c31JMY
 hy899AhVeInN93zELPjjPoYcFHDZsKEfQh2a/YaaMKBgdrgDe9FB0zsKY7gj4t+OpUMOXDKCQky
 nC83RTA==
X-Gm-Gg: ASbGncsepO3E+683rLgYbPRYqDcfZVCC0V9jNuP5mmc6XVW3cJQQgLPiC/qFSk3xTwb
 yHs4c15jKyPjxihXQ1K54dXWwBzeQPNV2klIH8BjMo2+k1gyBpSWNzoCnyupXKLAchgLEdRoQbE
 pUUJP+cghUxlmrjqe7LHo2bRjCL9M8eJcJnuZk+fbF79GSArp0y8j40JjimkYb2LfK73JroM/aC
 kN5qlID6NXQRMK7/6GjKunq7n4PFtqR4BH7Nx8lRtOptN1u/t5QxywsoQHQncAVkHc1v945xpX3
 BO/g+MC1su/OpzCzHucetjjE
X-Google-Smtp-Source: AGHT+IEJdlyfF8UlZqA5m26a0kGNtoE3b54BLn+VccpKDa3NhRS53MRlIoUvMF0HTFHpUA89i9f85A==
X-Received: by 2002:a05:600c:1e18:b0:439:6589:e1de with SMTP id
 5b1f17b1804b1-4396589e306mr54809285e9.26.1739541664219; 
 Fri, 14 Feb 2025 06:01:04 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:65ac:d875:2c3e:607f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258fc7e0sm4666391f8f.48.2025.02.14.06.01.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 06:01:03 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Michal Simek <michal.simek@amd.com>
Subject: [RFC PATCH 06/10] uthread: add cooperative multi-tasking interface
Date: Fri, 14 Feb 2025 15:00:21 +0100
Message-ID: <20250214140031.484344-7-jerome.forissier@linaro.org>
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

Add an new internal API called uthread (Kconfig symbol: UTHREAD) which
provides cooperative multi-tasking. The goal is to be able to improve
the performance of some parts of U-Boot by overlapping lengthy
operations. Each uthread has its own stack allocated on the heap. The
default stack size is defined by the UTHREAD_STACK_SIZE symbol and is
used when uthread_create() is passed zero for the stack_sz argument.

The implementation is based on context-switching via initjmp()/setjmp()/
longjmp() and is inspired from barebox threads [1].

[1] https://github.com/barebox/barebox/blob/master/common/bthread.c

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 include/uthread.h |  31 ++++++++++++++
 lib/Kconfig       |  19 ++++++++
 lib/Makefile      |   2 +
 lib/uthread.c     | 107 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 159 insertions(+)
 create mode 100644 include/uthread.h
 create mode 100644 lib/uthread.c

diff --git a/include/uthread.h b/include/uthread.h
new file mode 100644
index 00000000000..ea1389e82c6
--- /dev/null
+++ b/include/uthread.h
@@ -0,0 +1,31 @@
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
+int uthread_create(void (*fn)(void *), void *arg, size_t stack_sz);
+void uthread_free_all(void);
+/* Returns false when all threads are done */
+bool uthread_schedule(void);
+
+#else
+
+static inline int uthread_create(void (*fn)(void *), void *arg, size_t stack_sz)
+{
+	fn(arg);
+	return 0;
+}
+
+static inline void uthread_free_all(void) { }
+
+static inline bool uthread_schedule(void) { return false; }
+
+#endif /* CONFIG_UTHREAD */
+#endif /* _UTHREAD_H_ */
diff --git a/lib/Kconfig b/lib/Kconfig
index 1a683dea670..c3416bbd0be 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -1255,6 +1255,25 @@ config PHANDLE_CHECK_SEQ
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
+	default 32168
+	help
+	  The default stask size for uthreads. Each uthread has its own stack.
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
index 00000000000..bb132001fb6
--- /dev/null
+++ b/lib/uthread.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Copyright (C) 2021 Ahmad Fatoum, Pengutronix
+// Copyright (C) 2025 Linaro Limited
+//
+// An implementation of cooperative multi-tasking inspired from barebox threads
+// https://github.com/barebox/barebox/blob/master/common/bthread.c
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
+	struct list_head list;
+} main_thread = {
+	.list = LIST_HEAD_INIT(main_thread.list),
+};
+
+static struct uthread *current = &main_thread;
+
+static void __noreturn uthread_trampoline(void)
+{
+	current->fn(current->arg);
+	current->done = true;
+	current = &main_thread;
+	longjmp(current->ctx, 1);
+	/* Not reached */
+	while (true)
+		;
+}
+
+static void uthread_free(struct uthread *uthread)
+{
+	if (!uthread)
+		return;
+	free(uthread->stack);
+	free(uthread);
+}
+
+int uthread_create(void (*fn)(void *), void *arg, size_t stack_sz)
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
+void uthread_free_all(void)
+{
+	struct uthread *next;
+	struct uthread *tmp;
+
+	list_for_each_entry_safe(next, tmp, &current->list, list) {
+		list_del(&next->list);
+		uthread_free(next);
+	}
+}
+
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
+
+	list_for_each_entry(next, &current->list, list) {
+		if (!next->done) {
+			uthread_resume(next);
+			return true;
+		}
+	}
+	return false;
+}
-- 
2.43.0

