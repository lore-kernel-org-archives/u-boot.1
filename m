Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 220A4C282D2
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 15:33:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5AC7810ED;
	Tue,  4 Mar 2025 16:32:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YFmjfDdK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBE13811B3; Tue,  4 Mar 2025 16:32:11 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 256568128D
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 16:32:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-390f69e71c8so2491680f8f.0
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 07:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741102291; x=1741707091; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lZ+vMlEvS8LCYmC7HjtNZdw2xmcTzhjatEcHVTOwFrU=;
 b=YFmjfDdKfqq0uyJXd0wokEDMt86H8dwHOv8l3Y3tq3a1bACcaBewKeQU5X61FVlDXs
 6pQ9xuaNwfqBiZ2TZyX+p4wE7J694dXNUiKuOVU0W2+mlNaKwmXdUszPjsfR/wtDR+9L
 gUH3IaZjX+Ja8HqMBVO32dmqeODIYBL2gl3BnMkjq2J9I65IP+GbGcqnNKDLgCX3wa1m
 cy8r8BED+mCfbAE9EcwLcHfLJUwsp1TrBIQu0p+LfryWO/v/7kaU4GwcWvV+x9KQbAG/
 rHBFnLk6cGvg5Wvtg1B6qO+w9/h66ngraMG+0hwjcgPj8J26PjsuF60X17zudE+j9Twj
 zznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741102291; x=1741707091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lZ+vMlEvS8LCYmC7HjtNZdw2xmcTzhjatEcHVTOwFrU=;
 b=lb7YxjZZcUBOdSRcOipVR/+WehUqm/ld6ZuOtescSZ/A+TQgRLTz4sIMvom6wozQx+
 +/yUKy4alhpwZH52/+El+ZZmFiOQmLklEiFuE8QMh6NlNoV7Yfl0hDuisSY1Svl40bM9
 CWcAiW9C+HOpichevqqktYVHQAJY89mBv+ueqcQ/SXhwz8bJNwQDf/F+21RvyVM4OXQL
 IApNgkhsIGYqeVsxyMsIYgO7YfTXdNiTvaVnzxQxXlasbInl5p3rDeDyN6X9e4CbDbna
 jeOxFxYO1Wehs5QHcIMIVrVbMpy9rn8x4Uuk1zyBMPDnj6SR1OrQGFEbdPskdox5Icer
 hNXQ==
X-Gm-Message-State: AOJu0YzkWvLp/hJYmhAgAP55s1HFaQDhCqURVB+rC6zGTzz6EPKBGgZM
 kBoyr+diPGSt6ByTErt8hfAeYaNYEOL6MI1xxm1VVaac3katkGKN+1sLkmVtIddzBZBGZdtAfIH
 E
X-Gm-Gg: ASbGncumr5FBF4h9DfX+O2TNbhstdvJJvJvdZZ587TrtH9vvqvMBfqNoGlGpkeh0dQW
 99Yq/jT0JrPPuQn0wDV1UNcyDfh97iRjFFqrcNdiHJk0ngiTzOqpGOtfqH/JEG0ADvKeOG0aDRZ
 WURTRuQVVRSHTujyi6oa630XnlSK4/JBxmutM/5JJjBX8jh/Vt/jvBMgURFoW2QsnhacyQjyhUS
 G5vvRZ6YLZiokYw45CQ8wGQ39Gm4V4mq4DTUl0ci+gm6Tc5yDsGtsHF3oCdauP1XoLVZ884CBEl
 X3ho9JwZw+WTjwzLcyo4JuHKg8x35AerXKl12m6R0ASLzcGszaqH2g==
X-Google-Smtp-Source: AGHT+IEAfqbkeVfpLw+fNeTQfLfJ7SBBauOKApoLOlknqrLmF/HOsiOLGyK9z8yHr0+eghb5Locxiw==
X-Received: by 2002:a5d:47af:0:b0:390:df83:1f22 with SMTP id
 ffacd0b85a97d-39115627f82mr3511321f8f.25.1741102291408; 
 Tue, 04 Mar 2025 07:31:31 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:771e:3d0f:d9c9:2f92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e485db82sm17669254f8f.88.2025.03.04.07.31.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 07:31:31 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Raymond Mao <raymond.mao@linaro.org>,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v3 05/14] test: lib: add initjmp() test
Date: Tue,  4 Mar 2025 16:24:53 +0100
Message-ID: <20250304152510.2832340-6-jerome.forissier@linaro.org>
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

Test the initjmp() function when HAVE_INITJMP is set. Use the test as an
example in the API documentation.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 doc/api/setjmp.rst | 10 +++++++
 test/lib/Makefile  |  1 +
 test/lib/initjmp.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+)
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
index 00000000000..3f11c5b42de
--- /dev/null
+++ b/test/lib/initjmp.c
@@ -0,0 +1,72 @@
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
+	int stack_sz = 1024;
+
+	ep_entered = false;
+
+	stack = malloc(stack_sz);
+	ut_assertnonnull(stack);
+
+	ut_assert(!ep_entered);
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
+		ret = initjmp(buf, entrypoint, stack + stack_sz);
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

