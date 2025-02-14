Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FBCCC02198
	for <u-boot@archiver.kernel.org>; Fri, 14 Feb 2025 14:01:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EEE780F16;
	Fri, 14 Feb 2025 15:01:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xg4b+rCA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93EC680C83; Fri, 14 Feb 2025 15:01:05 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77D3580E88
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 15:01:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4395817a7f2so14379115e9.1
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 06:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739541663; x=1740146463; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IJNaNPY3czlLhhfrH4SNPdHcNteu2M3lW9KGA73kCRE=;
 b=xg4b+rCA1QidJ4o3ykuBlUJ9tLdhuQKPfF02yuOacR2vrv6LTIIxj5W8v6/dD+ct1j
 B1+MI0rG3hswtgxnDosLf/mq+6vbLzkbcAxjBf0F++luQL3Y0Fsge2mF9d0+5dc75Wla
 YYdp9/bnitI7FNw83BN11uxTyghXlTTWyHCkhODq0z+Gt3130SUV8/uZSIjNf5+6rcyL
 ju5xiDfK9IWg301/r2g7wbvZl7LWJVfDd9vdiRBEIzh/fkqKWZaDyxQKWucnY05/pF7M
 eO3yZ6+JzjCdB+E2ULJK4ftnuNYsGg8ZupzrYGZ2wXJc9i29N4qwDHyLGpVHd7WUcLoY
 KERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739541663; x=1740146463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IJNaNPY3czlLhhfrH4SNPdHcNteu2M3lW9KGA73kCRE=;
 b=ZoMV1M9YoDhlf7xBXaqUT/NGUpB92FtBeus6a/7jojF9eSOpQdqyG3DL+wP7J2JBpI
 vIAZ9nCQQJ5RnXOQoy9VkqHgD4ZAYqFAlHAyquDHpPbXnLfRxGZDsF4ksef+Bq6RbUoi
 YhlPCHKTDjmc7GfLz9NbyxR+g/9sgmZzJkp80t+IFV/NyrOnQOCWbyZirSYoNMW2Wipv
 qio0PEffFB7LUovxiUPPNFUlabipuv1LiXyCuOI1O3K/XBqHfS6VURbTu4h5NjkCX0WS
 lzRbqvn8M39yB0ug5hHpqeU35dQ8kaBhSmIROwhirLj393Vgrz3Fkd9biBc1ser4gJTl
 DxGA==
X-Gm-Message-State: AOJu0Yzi7QZhbmDL7fFPdtIyE4b0cMOaudXcSb/hyR2J5QHkTAL5X2rT
 RDgepUhzyK+uMXr5opu0d5s0wo8N5yQLFJkYM2tvfIDpKwYVMlvWHfM3S/l8ltEkcnBvansFVzn
 SUY9oBQ==
X-Gm-Gg: ASbGncuSxE+we4sy7yEdK92HTfTflGO1qJ98xF9hZQU9vyeZQq0laAgKkwoKr8NhD4T
 Ml34dLFvLdV7mNZLVVW0M/Wwvgd4mU2nXare1XU7AFaYmjURRUc8sceLHmXbt2kY01cDEg99Tnv
 h+aCfWrwqO6EgOBOApdtBhX8dpCM9oEoEmpbkYQQJID2gBTy7z09geFzbq54FX7narjJiscF4K/
 xojtOjEl3rz9YZkEKQCtvgu5+p67L40ZJqCCG6bDz3AnmAVQs7fu0+yTJ7rn1YK6e9R3gwm5Zwu
 d5G8swXq8tu2lbbWgrk8l3ud
X-Google-Smtp-Source: AGHT+IG6Yvp6Qy7BNd4pzZvICCqa4Te6hxZWB7xt9kjTl3GSQUXkO62EKqZCPU2jRu9KJoU5PWeyxw==
X-Received: by 2002:a05:600c:870a:b0:439:42c6:f11f with SMTP id
 5b1f17b1804b1-43960169268mr101954885e9.4.1739541662448; 
 Fri, 14 Feb 2025 06:01:02 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:65ac:d875:2c3e:607f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258fc7e0sm4666391f8f.48.2025.02.14.06.01.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 06:01:02 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: [RFC PATCH 05/10] test: lib: add initjmp() test
Date: Fri, 14 Feb 2025 15:00:20 +0100
Message-ID: <20250214140031.484344-6-jerome.forissier@linaro.org>
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

Test the initjmp() function when HAVE_INITJMP is set.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 test/lib/Makefile  |  1 +
 test/lib/initjmp.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)
 create mode 100644 test/lib/initjmp.c

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
index 00000000000..52bbda8cc60
--- /dev/null
+++ b/test/lib/initjmp.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 Linaro Limited
+ *
+ * Unit test for initjmp()
+ */
+
+#include <compiler.h>
+#include <asm/setjmp.h>
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

