Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09607C3600C
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 12:33:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E9D082027;
	Mon, 31 Mar 2025 14:31:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zuf17zPN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5094782027; Mon, 31 Mar 2025 14:31:50 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DD5981F0D
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 14:31:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43ea40a6e98so2975835e9.1
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 05:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743424307; x=1744029107; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qkBJkl3WKwaUf5l3xYynOeT0PQynHCpYMM2dqIakoiU=;
 b=zuf17zPNMxy6NUYGMq5b8e81v/T/9zjIzasA3hfQRG6HS4KNyiuIrOOsvWfiHLgeId
 zoMPQBpNquuTLZFTLdhp3muggAPDyLt4RSMG9LNzNgN2ZuQvjCVrbX9X5IiC2Tp3BFdt
 7UTlE4TaILvxxiwSWAaAjANyf9XuhpU5CFEWVS6ZhhdgwMYfs7HpalSkvVSPgjqU4bfD
 kw25RynHITm2kP38/nepDUUWLB9yckNT/Zg2CQpyytg7DlR8cW5Lbj9KKN9FJUusq4nH
 hhAXwMFiLHvJF0ljy42uKjbCM+IgCJ22/sTwLxK0uKu6WHtgcftQbu6g/m33cAP06d7L
 TgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743424307; x=1744029107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qkBJkl3WKwaUf5l3xYynOeT0PQynHCpYMM2dqIakoiU=;
 b=UP7DUzBHLsXWkCFZMobJR3j6EQM6xikQOPXLqisXqSVwkHMhooDan/Xl94DkFw8H2k
 tYBZSOYo+SDD4kVNx/dVZhqO8X2uVjEF7K2+9ovP0BmGAbmMeRCNdBO3mSSvxFQnwmko
 cDo+XoMTyYJv+nykJ/dYHuTzVO3dNr4otsByklj+Vc/I+Gbxpws5SUqieoNRDHEvVFuN
 5lkk9JM6GxMmD+0cmK/BmAA/F1yyGgwgZ5/ZCK6GxRfebBsGwJL7X9Ao+wlT5yxxiEmh
 kdiMl1Qx42sttfMyrvT9RNb6fDD1AHkpKXrwI9eVDG4Zna2VrasaTHkTClzpjoh/hx/K
 iTaA==
X-Gm-Message-State: AOJu0YzIhyMORYRnMcdpE8zs9/iwBk18r4KLKl/Lt0h1h7M8/JUoeMz7
 lLYz/wsfGdsES86yFEliGmZgStQAY0Bny04OFopNW9sfQKhdJ0q4VMDpfUcKGAbLzq9io81iUeG
 7R83Mwg==
X-Gm-Gg: ASbGncsx+BRKGsYugLQYeUjwTnUpyvZbm2rQDs8/1T4L3SbA7ryAt0QkW5Jc739MYx0
 jtdtF3pdj+7TCLPgDqlbQsJShJPBScVB6APQB+BW0UHUxYcqr0to81KMZIXAFPyoxG9LZ99DJQe
 PdPw6fF4r7od9h8cRg+p3VriZdPhEH3psE+xH/a6I6rIYhX2tl/QPEcx/uME28JVNE86Ul/5QSY
 Ytr62NMC25xkjMUYP6EJInVW6hbA9BnXbVvhm8QKMnPX523xNxk3iWcieoofrsDJXIfRAagsVSw
 TGVjmlKNuOpOHBQayr7PjjkIRvcuxwxgdjEOwDhsWNGYNb6Zq8Ah
X-Google-Smtp-Source: AGHT+IGFTLiJwfl8tJPN5KCQZ+KlzECltW2OkUYm5rtXlLGLL/BPnOgSVBAroWS2z9x+sRYamUm8zw==
X-Received: by 2002:a05:6000:420a:b0:391:487f:2828 with SMTP id
 ffacd0b85a97d-39c120cd1d0mr7340258f8f.10.1743424307373; 
 Mon, 31 Mar 2025 05:31:47 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:f23c:25c9:dc74:be1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b6589e4sm11337029f8f.10.2025.03.31.05.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 05:31:46 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Raymond Mao <raymond.mao@linaro.org>,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v5 10/16] test: lib: add uthread test
Date: Mon, 31 Mar 2025 14:31:04 +0200
Message-ID: <20250331123120.2025062-11-jerome.forissier@linaro.org>
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

Add a thread framework test to the lib tests. Update the API
documentation to use the test as an example.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 doc/api/uthread.rst | 12 +++++++
 test/lib/Makefile   |  1 +
 test/lib/uthread.c  | 80 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+)
 create mode 100644 test/lib/uthread.c

diff --git a/doc/api/uthread.rst b/doc/api/uthread.rst
index 21233ff6b22..8b25cc1ff80 100644
--- a/doc/api/uthread.rst
+++ b/doc/api/uthread.rst
@@ -3,5 +3,17 @@
 Uthread API
 ===========
 
+.. kernel-doc:: include/uthread.h
+   :doc: Overview
+
 .. kernel-doc:: include/uthread.h
    :internal:
+
+Example
+-------
+
+Here is an example of how to use this API:
+
+.. literalinclude:: ../../test/lib/uthread.c
+   :language: c
+   :linenos:
diff --git a/test/lib/Makefile b/test/lib/Makefile
index bf04685dae1..c991dff1c63 100644
--- a/test/lib/Makefile
+++ b/test/lib/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_CRC8) += test_crc8.o
 obj-$(CONFIG_UT_LIB_CRYPT) += test_crypt.o
 obj-$(CONFIG_UT_TIME) += time.o
 obj-$(CONFIG_$(XPL_)UT_UNICODE) += unicode.o
+obj-$(CONFIG_UTHREAD) += uthread.o
 obj-$(CONFIG_LIB_UUID) += uuid.o
 else
 obj-$(CONFIG_SANDBOX) += kconfig_spl.o
diff --git a/test/lib/uthread.c b/test/lib/uthread.c
new file mode 100644
index 00000000000..0c0540585e7
--- /dev/null
+++ b/test/lib/uthread.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 Linaro Limited
+ *
+ * Unit test for uthread
+ */
+
+#include <stdbool.h>
+#include <test/lib.h>
+#include <test/ut.h>
+#include <uthread.h>
+
+static int count;
+
+/* A thread entry point */
+static void worker(void *arg)
+{
+	int loops = (int)(unsigned long)arg;
+	int i;
+
+	for (i = 0; i < loops; i++) {
+		count++;
+		uthread_schedule();
+	}
+}
+
+/*
+ * lib_uthread() - testing the uthread API
+ *
+ * This function creates two threads with the same entry point. The first one
+ * receives 5 as an argument, the second one receives 10. The number indicates
+ * the number of time the worker thread should loop on uthread_schedule()
+ * before returning. The workers increment a global counter each time they loop.
+ * As a result the main thread knows how many times it should call
+ * uthread_schedule() to let the two threads proceed, and it also knows which
+ * value the counter should have at any moment.
+ */
+static int lib_uthread(struct unit_test_state *uts)
+{
+	int i;
+	int id1, id2;
+
+	count = 0;
+	id1 = uthread_grp_new_id();
+	ut_assert(id1 != 0);
+	id2 = uthread_grp_new_id();
+	ut_assert(id2 != 0);
+	ut_assert(id1 != id2);
+	ut_assertok(uthread_create(NULL, worker, (void *)5, 0, id1));
+	ut_assertok(uthread_create(NULL ,worker, (void *)10, 0, 0));
+	/*
+	 * The first call is expected to schedule the first worker, which will
+	 * schedule the second one, which will schedule back to the main thread
+	 * (here). Therefore count should be 2.
+	 */
+	ut_assert(uthread_schedule());
+	ut_asserteq(2, count);
+	ut_assert(!uthread_grp_done(id1));
+	/* Four more calls should bring the count to 10 */
+	for (i = 0; i < 4; i++) {
+		ut_assert(!uthread_grp_done(id1));
+		ut_assert(uthread_schedule());
+	}
+	ut_asserteq(10, count);
+	/* This one allows the first worker to exit */
+	ut_assert(uthread_schedule());
+	/* At this point there should be no runnable thread in group 'id1' */
+	ut_assert(uthread_grp_done(id1));
+	/* Five more calls for the second worker to finish incrementing  */
+	for (i = 0; i < 5; i++)
+		ut_assert(uthread_schedule());
+	ut_asserteq(15, count);
+	/* Plus one call to let the second worker return from its entry point */
+	ut_assert(uthread_schedule());
+	/* Now both tasks should be done, schedule should return false */
+	ut_assert(!uthread_schedule());
+
+	return 0;
+}
+LIB_TEST(lib_uthread, 0);
-- 
2.43.0

