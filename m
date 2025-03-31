Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C68AC3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 12:32:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17477819D2;
	Mon, 31 Mar 2025 14:31:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bEM4QlRk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B566081F59; Mon, 31 Mar 2025 14:31:41 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A736181F59
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 14:31:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cfdc2c8c9so24755555e9.2
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 05:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743424299; x=1744029099; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Wr0962nKSa8gzKuTD03RUSdUdB+lmJXD5dXPdk4D/w=;
 b=bEM4QlRkef45rRMmtLNxmfYKsiqvE2KpI1tIqtseuJ5ArD8bT0hdBXultNk3PVjRPz
 uUg2BgpDPj0YHAcqWuhBwAHUuqZMVA2pxh2GNA8xjnsxg7ISRG3MatE4ymiD2uOAYDJ3
 pOiFSowmZhQYm8pzmPbO+NIhMH3pfmArEQXeaaxg+wqlqL8XFAt8vE43P8nkW6yUke1Z
 hpwKIO/p3dBFBUAE00vjOGJvDWto+FfnfkoOaz+kE8Tm95elbCEnAFmEEF+RYzUDLMbm
 euxrdLecxC3V6HevHB/zAl5MF9lR+Iyrn11gxzwVDmFXE9wBfM04j5pFG4uEPSgg1Hfg
 nIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743424299; x=1744029099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Wr0962nKSa8gzKuTD03RUSdUdB+lmJXD5dXPdk4D/w=;
 b=DVLdNsXOBWpdjbvd8aPOe+y1EzNc5rDUDCJo6uT6CeeuUbPxPwKQgDsAXm0XxLdejL
 MQP6WcwYY1wkc42Qwee+5SJsdW6kvIbjIP7LbfqV5UkCCSlN5QDPWQfCItLqLDoHFMTM
 CPW12rB650ERnyT/otJtCXMR561mOWHZbn4PpS+j4CP/uLdWKhy41eJPkzARfq7H+/2M
 OcQc8ITROwEII4evKqlWtJrKr5Mh6iK+dXTPWbasdmX5vlJeZJcq6zjkJJSBwmES1cgU
 ElxfiYRFW5uIEfyObRmBiU5y6Smi/W3Nqjc0iUY7XdzmEBxe0Vlf7TxGtX3akEpsRCro
 luJQ==
X-Gm-Message-State: AOJu0YzLPNffRtoNmaKcD1Elv1EoWsPFwnOY4jvhitmAYB18op9NK9in
 J8kMDkKtHeUGs/cO5qLawPFO07PvRpqR7SVQ80BjWlaZWsCupKkAF3CRRp633nJ5CTwWPIrS892
 XvnStcg==
X-Gm-Gg: ASbGnctS9c6wuwhqkNQeJcvTXTzUyKW40cD2BiBXnU3c7lirUYiRKivTpOe8d6j2hd9
 7/rgp58Ho0EM9jLJVThEfsgbRrsu57ADgZXArD6VXFoCmqDJu5U7yuyWeMlWhLQ/BLa0ZDF9shO
 98OpZ8LTjW794KMX/Iu7tY/Ons866y8JzXD7KR7+1sCO7nMTnTtlRJ39aRyXPgj39NwE6yoHFEs
 QL0ru9LHuRLPrGxYplSG/Eh/R76QB4D/blJr+dJnajXlGVQA0q8Uuc0pLSk74jWLPrbvwtpQvGL
 6QGJ+jB5OfkhsaqS716buHj/r4ce3JMc/mronJkiPui8GockYliM
X-Google-Smtp-Source: AGHT+IG3+EQquY1wsrACysmbTihbLOKXK4mOMwGs+ArGXOZ/UnQzcUyuQAV6mdpJvmtKyDXpg12mNA==
X-Received: by 2002:a05:600c:c16:b0:43d:24d:bbe2 with SMTP id
 5b1f17b1804b1-43db8524b1bmr62436275e9.28.1743424298927; 
 Mon, 31 Mar 2025 05:31:38 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:f23c:25c9:dc74:be1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b6589e4sm11337029f8f.10.2025.03.31.05.31.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 05:31:38 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: [PATCH v5 05/16] test: lib: add initjmp() test
Date: Mon, 31 Mar 2025 14:30:59 +0200
Message-ID: <20250331123120.2025062-6-jerome.forissier@linaro.org>
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

