Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DDDC369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 14:12:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64567832C0;
	Fri, 18 Apr 2025 16:11:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PwtmQ5OM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1759783249; Fri, 18 Apr 2025 16:11:39 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A8A38327A
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 16:11:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43d04ea9d9aso9116695e9.3
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 07:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744985496; x=1745590296; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PoOfi9pwiceoneya8FYrnN0TEP+mOaYHhxlnDpq5h3w=;
 b=PwtmQ5OMgGpk9KW/wck14fOPxvr8v1+4i7Jt3EegJp6m02XpxOes4O3uIASkRWf5Qb
 tBf5YQlFMp6QlA3BCuH96UKOQ2NLnO1zZg9R1X1L/xPDO7jLs79AbfvC1lrCGN8nsR9I
 Ww/x2kiEwH0d0BCYbzTKBAB79RkZ67CCOtaFwVpLsGsZOEhu3OWRHO6a+5AQPfmt4pk1
 nvuT3J1mUh3hs+f49nkMxsNvzFRDxIvwRUVV9ZAxEDS/GcAPR8n/hlHIAgtrT69UMgsN
 VbydoILt0RZfVjUSVUJ5SOA2YIfOHa8U078WaUuMjRa/IUv+b+0ayxIOgGX6R3+GOvL0
 2yMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744985496; x=1745590296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PoOfi9pwiceoneya8FYrnN0TEP+mOaYHhxlnDpq5h3w=;
 b=jmjicdD+JYGIobMjlMZoTezXfsXaTMzVZO44adpb5DNM+shqcOG0+QPr8Vkx4+LR3M
 cryhxQ9+/Ag9nCcdOYm+n8zrKfZ2pXWU5phmgWFYTFI4WXTuuJOFsOXt8wqfL5jwWUMR
 6XuuMOFVsT19zW59yau4E1q2r81sgTGow/CKIFWFoVzAO47lxT+DR5gDM1SwZoi5nOVF
 AOW7ZeS1WRBhb3H+8FvVSMIvkt80vyQGFfeUoC2q7Zp9yUWQzaSlC62obqgToykruErr
 rboWbTuHTUmYIjqX+TgQ/II8yDREoht5FQ+AedKCYI84xyWr4OA6R9AP+J/3vxbth0d9
 6ZIw==
X-Gm-Message-State: AOJu0YzIQhuTrHrRopZx6IFSaXg5whx1Gjmb4I+1Y/gyRib5212aJW/u
 ThPVZUbfkeUcFLWzh/Mxrp+7kE8ItPQ3MtOKgDqePvGa1qKo45HAIXu8975lwiKSJbV1V5qa9ex
 SWVcGMQ==
X-Gm-Gg: ASbGnct7YR5U2nnQJrJz48CvgHsUc5VkETowk+Ts9q/YQPb0B1r7TtgEJUFXc2dg7B/
 T9sGQMnSzZ2+gzm8BH29OjCMPdOqdqsCs3wZ1mQ0gKkZGxXTsmSQXAvBOT4DMxPWwB6JKPDMAZI
 8e/HxH0m39oH1QvEI5UvvmwIHjj3mbPyn8TYpJJOPg+O3F2rm1OFRtMeTiWnT5h99dGDvo/ZK0W
 erMCA79YYXVsmrLP+/NyHnJxg3RGSWAxZihSU9uL8NEAp+WaRW9Mlv9HBspc3J1ngKBqOICrzQB
 PoorOcaIsl1mT67n489znT5lyFIMPC5ll7iFvunEsNA9Fj3wJA==
X-Google-Smtp-Source: AGHT+IGdpNxV1Sx574OIm1JSFNhDcpBoZMmdzYegqwqIiqh91kDiZagsq3VZRBrK2EetnTDEaWeC9w==
X-Received: by 2002:a05:600c:1f1b:b0:43c:f61e:6ea8 with SMTP id
 5b1f17b1804b1-4406ab81da2mr26771125e9.2.1744985496288; 
 Fri, 18 Apr 2025 07:11:36 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:1526:5ffd:d63c:cc85])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5bbcc3sm23734385e9.19.2025.04.18.07.11.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 07:11:35 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 05/17] test: lib: add initjmp() test
Date: Fri, 18 Apr 2025 16:09:33 +0200
Message-ID: <20250418141114.2056981-6-jerome.forissier@linaro.org>
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

Test the initjmp() function when HAVE_INITJMP is set. Use the test as an
example in the API documentation.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

---

Changes in v6:
- Remove trailing whitespace in doc/api/setjmp.rst

 doc/api/setjmp.rst | 10 +++++++
 test/lib/Makefile  |  1 +
 test/lib/initjmp.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 84 insertions(+)
 create mode 100644 test/lib/initjmp.c

diff --git a/doc/api/setjmp.rst b/doc/api/setjmp.rst
index 7718047085c..c30e51c2b55 100644
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
index 97ab71ba5d1..9db563f7ed1 100644
--- a/test/lib/Makefile
+++ b/test/lib/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_SANDBOX) += kconfig.o
 obj-y += lmb.o
 obj-$(CONFIG_HAVE_SETJMP) += longjmp.o
 obj-$(CONFIG_SANDBOX) += membuf.o
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

