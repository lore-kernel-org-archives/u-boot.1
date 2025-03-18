Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC811C282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 10:48:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D72181B42;
	Tue, 18 Mar 2025 11:47:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fhPxw+e7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF1AA80F70; Tue, 18 Mar 2025 11:47:27 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF34180107
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 11:47:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43948f77f1aso22251905e9.0
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 03:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742294845; x=1742899645; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Wr0962nKSa8gzKuTD03RUSdUdB+lmJXD5dXPdk4D/w=;
 b=fhPxw+e7TOmpH8m4wzpKcMAkQIuMKmk31km8J9qGgbKmjkp75XKPbxBTwjBuP1IMPM
 AuQSeDrz36rgbWNS/YdqZJzHT5u6gZ1YlUq9r9MBUZJ2dZYbVXWunLcKfhAdS3S7mC89
 Vjbi+1WyGFxnJgJg6xUIsH8TzW0XzhXygVF90Quwa4syxD/17t65ekOqRVydesu+nToR
 8OblGiyyOXKt4X6XAQsU/8rI6DhtNwr/5w11kHaCNkiYVdW4WbryX+QYiSEE1+deo3dI
 4DmKJfAGo4EeOy3G4NRwRMX6dNEaQS5sxpEBxiHee9fZZY2f6mYJ7QnYIdmyRzggIqR5
 1lKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742294845; x=1742899645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Wr0962nKSa8gzKuTD03RUSdUdB+lmJXD5dXPdk4D/w=;
 b=LUE8cyUUqC9YpTeRFp/z7i5EWgruVkJXVb2qJrGDdO8OU5RRXZUTlGbkIzFV9sDv6i
 DIxl9m/jjANPxoPji+/RhBt0VqIYn4kXCj2qn0YdlXodv+sVDse+Lwes4m4SWDbMLfKt
 z9cgy2UJUkUaL1KioQ59Kc2exdXbIeRVkQj8QKliyPha8da4Ua0IFw9S0nGNampm3HjS
 rGB+vbPZfHMig/v+EztY9dTBFdr00Zd78aXmrpKy5y6MN+9+i5osSk/T6Ag9Zc3OjzOk
 nFy445WVV84t5htCNecCvq1K/O0CP/B4LZx1Xx8pLrOkpSSieSEjo9eR6lj1B1gzhm+W
 jTvA==
X-Gm-Message-State: AOJu0YwMItV7ZFidYTAH7TnG8igqNKC3Uv97lrrQ0YmcTatZuqUpxZzm
 zgoc5bcerJR/xCQaJ2X+ffPKwfl1jPapaAjcJmqcCQftq6Lyn/AkCEJ+vaBshhDTwVSNus7nUGp
 SyJg=
X-Gm-Gg: ASbGncvhOlWJMGFrx1x4OzAt5ZlcP9aaSltT9LSbKy9tjwMYKq/+fNXioYZsdaijGLJ
 iXbrxP/DlQ0ht/qYi9FG/jhaK0J2CBzW6FfxFHtO8gGq+es7GjVNmleBw1+S5+ntf2GE5tNRe1b
 vfNHPoh7IwfG5002s5dFLUJm4mXBPWx6mtkNY0ng3EszCh4VRFT1MOXtnIf1fSf3Wia3LF0xok4
 E6u23FHpvB5tFbypb2Ob1jyWW2cm700jPx3xolQemzYq74dx1ClTTYzPAUSrbTMcKnlQ5qMntJ+
 +QyhehdE7dm8j4H1gPDGSQjHUEPYdw8l2T5ISG0+H/uAyuSL9KZhAg==
X-Google-Smtp-Source: AGHT+IG6SxCqadPDy+bR0gwdTabjtYjs85NbddrmlqcwpwqIDWjq3YVnaYxwj1jgVvNQSM0J2UKjvw==
X-Received: by 2002:a05:600c:1c2a:b0:43b:ca39:6c7d with SMTP id
 5b1f17b1804b1-43d3b95013amr13736045e9.3.1742294845108; 
 Tue, 18 Mar 2025 03:47:25 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:78bd:2e7e:120c:26bb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fdda2dbsm131788185e9.2.2025.03.18.03.47.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 03:47:24 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Raymond Mao <raymond.mao@linaro.org>,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v4 05/14] test: lib: add initjmp() test
Date: Tue, 18 Mar 2025 11:46:41 +0100
Message-ID: <20250318104659.1114340-6-jerome.forissier@linaro.org>
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

Test the initjmp() function when HAVE_INITJMP is set. Use the test as an
example in the API documentation.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 doc/api/setjmp.rst | 10 +++++++
 test/lib/Makefile  |  1 +
 test/lib/initjmp.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 84 insertions(+)
 create mode 100644 test/lib/initjmp.c

diff --git a/doc/api/setjmp.rst b/doc/api/setjmp.rst
index 7718047085c..c48b2e3e096 100644
--- a/doc/api/setjmp.rst
+++ b/doc/api/setjmp.rst
@@ -8,3 +8,13 @@ Long jump API
 
 .. kernel-doc:: include/setjmp.h
    :internal:
+
+Example
+-------
+
+Here is an example showing how to use the a long jump functions and 
+initjmp() in particular:
+
+.. literalinclude:: ../../test/lib/initjmp.c
+   :language: c
+   :linenos:
diff --git a/test/lib/Makefile b/test/lib/Makefile
index 0e4cb8e3dfd..bf04685dae1 100644
--- a/test/lib/Makefile
+++ b/test/lib/Makefile
@@ -14,6 +14,7 @@ obj-y += hexdump.o
 obj-$(CONFIG_SANDBOX) += kconfig.o
 obj-y += lmb.o
 obj-$(CONFIG_HAVE_SETJMP) += longjmp.o
+obj-$(CONFIG_HAVE_INITJMP) += initjmp.o
 obj-$(CONFIG_CONSOLE_RECORD) += test_print.o
 obj-$(CONFIG_SSCANF) += sscanf.o
 obj-$(CONFIG_$(PHASE_)STRTO) += str.o
diff --git a/test/lib/initjmp.c b/test/lib/initjmp.c
new file mode 100644
index 00000000000..5b4b50b3f0f
--- /dev/null
+++ b/test/lib/initjmp.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2025 Linaro Limited
+ *
+ * Unit test for initjmp()
+ */
+
+#include <compiler.h>
+#include <setjmp.h>
+#include <stdbool.h>
+#include <test/lib.h>
+#include <test/ut.h>
+#include <vsprintf.h>
+
+static bool ep_entered;
+static jmp_buf return_buf;
+
+static void __noreturn entrypoint(void)
+{
+	ep_entered = true;
+
+	/* Jump back to the main routine */
+	longjmp(return_buf, 1);
+
+	/* Not reached */
+	panic("longjmp failed\n");
+}
+
+static int lib_initjmp(struct unit_test_state *uts)
+{
+	int ret;
+	void *stack;
+	jmp_buf buf;
+	/* Arbitrary but smaller values (< page size?) fail on SANDBOX */
+	size_t stack_sz = 8192;
+
+	(void)entrypoint;
+
+	ep_entered = false;
+
+	stack = malloc(stack_sz);
+	ut_assertnonnull(stack);
+
+	/*
+	 * Prepare return_buf so that entrypoint may jump back just after the
+	 * if()
+	 */
+	if (!setjmp(return_buf)) {
+		/* return_buf initialized, entrypoint not yet called */
+
+		/*
+		 * Prepare another jump buffer to jump into entrypoint with the
+		 * given stack
+		 */
+		ret = initjmp(buf, entrypoint, stack, stack_sz);
+		ut_assertok(ret);
+
+		/* Jump into entrypoint */
+		longjmp(buf, 1);
+		/*
+		 * Not reached since entrypoint is expected to branch after
+		 * the if()
+		 */
+		ut_assert(false);
+	}
+
+	ut_assert(ep_entered);
+
+	free(stack);
+
+	return 0;
+}
+LIB_TEST(lib_initjmp, 0);
-- 
2.43.0

