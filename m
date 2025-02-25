Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44AEC021B8
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 16:35:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 939C380FC2;
	Tue, 25 Feb 2025 17:35:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ln7d8vjs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9C1480FF4; Tue, 25 Feb 2025 17:35:18 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A482280F53
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 17:35:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4398e3dfc66so51333925e9.0
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 08:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740501316; x=1741106116; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IJNaNPY3czlLhhfrH4SNPdHcNteu2M3lW9KGA73kCRE=;
 b=ln7d8vjscWbTOUjmrFjZ5J0j7fnPRNIGllKD1kYO9zuIgfdFb16bDSuxyLWgsMZUqR
 aHb8xRQw3u7IDFrXNT/S1QqMXAXAUGgAlCk9eOFDapLpV+NKtiuwQnQkr7FSJB1eQcGw
 yj8iRZCa+S3VcXqjAmMT1tcehjXpbnnSIyOpwfW+pnrIHsXWxrcyQAoGxytZ98mp1oJB
 IqmL0zj3uavJzdp91LI3S+FPC65oXVlfvZaUxjYOclwzOlDE5Jqgq8jQT+hguO5wU8DB
 ZC4WYx8B4RmPE9G2aO7xlWag4306EBIrqCKZ11DPcmSqun0SPdfO359p8nU6edBMiCH1
 mozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740501316; x=1741106116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IJNaNPY3czlLhhfrH4SNPdHcNteu2M3lW9KGA73kCRE=;
 b=OTFjbIAz/StS2hCyQS/AG1/D1HhdanUmjqBKtPCg1bbQCpN6lFBupMTpj1YBvBiHaX
 E7KFHSzQELPbQ/kL1ll65hSGwSqHo7OyFithutHrFU0d/cpZxsnvGFnyXkAkHwiZdy4g
 2ag8ztRqgE8evvs5X7cQXEWwG/xDu1j3StEztrbnLOyWmvoUj/PyfXDlmqk4rPjnKKYN
 UM4oG2asnxKmLk3YpQIs6vg4EZAQSZuCvAcA/ZXE01TnAbLqUrwdFkQDIgdDbwPc3KqT
 bRDSo3fAFEXZ0UGXzBbRTqAUsOx4Q/G/U1tPC+3LD1gwTWb5YzoKIRDIebQjLEgU1ETy
 3VLA==
X-Gm-Message-State: AOJu0YxL2aA5dJf9Zowp2uWvqf8B3T4bdaReE6iTHXK0S9B3APTrETDO
 qu157Xehlj37JWThMWpx+UuYiAwgxcfD/Z4OBQC+tBzTPHGHs3CcjbBiIJ/Ejje3Tt7m6EQINIU
 tZeKVFw==
X-Gm-Gg: ASbGncsRsA6yhWFhPxLNavV0PBm2gIPW7ZuI7L3iSmyMeyuUVKqh/O6HIrAM8YxgzJZ
 BnL+U3cEjrDozE1U4JKyViEPIizyd7aLEG40MdA+mbGpBhv8Uw3Ub2GhRV95zXsRuKRsOQA/yqD
 isMCX/C5iSPk/uo+WAlmuiPCqSCYU4AVuAsw0/1PrXbOJdLZhosjadEO5u4SHXLQZqHHrR3QAwy
 2tbjedF9rU1UGauyucM7z3NVhDjz18TwC4Q3ZH3F0ivfdWdtBa+pZtbDh3nFFjF9wfs4GbZdphv
 BphkTVkQtFvNo+/Iw/LIi/IeUzy8NeQAQuM=
X-Google-Smtp-Source: AGHT+IE7piXtn3y9ZIAXbBJC2KvjGUTiosCs6IAoF0rskq8uRIY96rbsnsHsqYWumu7E72D/ZD2a8A==
X-Received: by 2002:a05:600c:4fc8:b0:439:9496:17df with SMTP id
 5b1f17b1804b1-43ab8fe76d2mr1789755e9.13.1740501315966; 
 Tue, 25 Feb 2025 08:35:15 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02ce735sm146356195e9.3.2025.02.25.08.35.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 08:35:15 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Raymond Mao <raymond.mao@linaro.org>,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v2 05/14] test: lib: add initjmp() test
Date: Tue, 25 Feb 2025 17:34:31 +0100
Message-ID: <6eb03993def0d868874fa3fca05e1d08ddc6afd6.1740499185.git.jerome.forissier@linaro.org>
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

