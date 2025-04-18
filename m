Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6927DC369CA
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 14:12:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBC3A81F45;
	Fri, 18 Apr 2025 16:11:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YRuMlo/k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B3CB8331B; Fri, 18 Apr 2025 16:11:44 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F840832BE
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 16:11:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cfe574976so13820385e9.1
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 07:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744985501; x=1745590301; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BREg6FS3yrP9DH3yBgZFyhDX4rt/L4xfFNZxOwyVTlk=;
 b=YRuMlo/kvAjbiwBJCE6EUiOfjaFyD0Bxx9KJuW4z0K+o6IShVFIS/FyPR+dr26WwR3
 QEz7hM9PSmg3r1o7HE4tXwg2y/CEy/54AxVUomJEBAW7Lul4nI3OcCMmx4ggPbVqelZA
 swTIfpWMx9tUsUHIJTAD4mleE25HgW0RIvxIvyBGgrMcnTl5tXsGCHTNmwPIXagQoVmp
 nordeJHxhIvrqo6as/b5lyvn9UAqs+K11oD9tEHY9QFjpJbuh4h2Xelyyoxv6icpi1lu
 P/sP6kIuJ6qjIF/A79VmOKflVRL2yHXhXG6eh+FqGtqaX2Bkqdt1nAtBjZtvGERxz82w
 YADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744985501; x=1745590301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BREg6FS3yrP9DH3yBgZFyhDX4rt/L4xfFNZxOwyVTlk=;
 b=NnR3tkFa8Zz+tSCH6zEw/UECuGQg2ET4YHmNCktoNf7mNYR5i2UUvBM0HxvlueWttL
 OTj/ZhDMyri7v5hFHnxdtFB3xxxFWJtqjIRcuBk0PXo1oVzYrvlApj5wfCP1y39ZOROu
 Nqb23CurwCiAib+bsQ5/glFmFsDNEcWHhKfjbV7C4lcd8/WN5Un8u457wOF+pkc2seJD
 wI5edDVBF7x1VRz3tFgE2zcj5e1dMDWIp+ualK6Iy2yAtn/goV8ec1oEVN/kVSv8RtfT
 5YXX76/vGisncP+10BB7lvxevs68cKntoIEHwK9N0jo5EsJZDs2I2vhK6QBU4vNWxV6G
 jVjA==
X-Gm-Message-State: AOJu0YzJ3bpOT/47KeKvYc0KvkOLCOwA2G/6GNQ6bkHH9FkRWQ3ruw2H
 V4TRlxvyGGx9qpxbxrBK6Poc57Li8r2jmrAoMDbujEaolJ7vU2S8XmGsl0ewUepPvGX5bgn8Mqo
 fKP6Xeg==
X-Gm-Gg: ASbGncssF3Bj6bc7JRMm0bSdVXzrtG0gGOBYK5obyLQUYMFXvvjtFNo/jPIdnMLJfzv
 PYTIkcMN3yPZVTfYDF7/nIO+70mb+XUeQZNV6WQvwueqYuSIgbi7JORqkpRwrF7fwTgT9iAxN1S
 jE/T52t5D+bH8qsz69pqEWyPEyNYKoW1RT4Vtzyn7Hm5kp4GNF1cTHDHrUrLFWbV8TuzGpdk48a
 OLpqAL0ikYqweqMr8EJn6GCdfjlzwJWUf8v/1w9Gf76tb+F6X7rYmYkl7DhrEP1G9OoMwVj0dOa
 TtPhEd9xeP5RbzFxLigpO8JrvQxliHVnlX8w0DVM3edjLUNnBQ==
X-Google-Smtp-Source: AGHT+IGOC2+4CAbl8O6S4viDu74jfCzgQ6VEZWVeCu2CNZq90EZ3iaeceF6ZHuFHTLBvX8RGKdt6hQ==
X-Received: by 2002:a05:600c:3b0d:b0:43d:7413:cb3e with SMTP id
 5b1f17b1804b1-4406ab7f548mr19822575e9.1.1744985500657; 
 Fri, 18 Apr 2025 07:11:40 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:1526:5ffd:d63c:cc85])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5bbcc3sm23734385e9.19.2025.04.18.07.11.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 07:11:40 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 10/17] test: lib: add uthread test
Date: Fri, 18 Apr 2025 16:09:38 +0200
Message-ID: <20250418141114.2056981-11-jerome.forissier@linaro.org>
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

Add a thread framework test to the lib tests. Update the API
documentation to use the test as an example.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

Changes in v6:
- Rename static function lib_uthread() to uthread() so that the test
now shows as ut_lib_uthread in the test log rather than
ut_lib_lib_uthread
- Fix spacing errors

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
index 9db563f7ed1..d620510f998 100644
--- a/test/lib/Makefile
+++ b/test/lib/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_CRC8) += test_crc8.o
 obj-$(CONFIG_UT_LIB_CRYPT) += test_crypt.o
 obj-$(CONFIG_UT_TIME) += time.o
 obj-$(CONFIG_$(PHASE_)UT_UNICODE) += unicode.o
+obj-$(CONFIG_UTHREAD) += uthread.o
 obj-$(CONFIG_LIB_UUID) += uuid.o
 else
 obj-$(CONFIG_SANDBOX) += kconfig_spl.o
diff --git a/test/lib/uthread.c b/test/lib/uthread.c
new file mode 100644
index 00000000000..ad0217485dc
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
+ * uthread() - testing the uthread API
+ *
+ * This function creates two threads with the same entry point. The first one
+ * receives 5 as an argument, the second one receives 10. The number indicates
+ * the number of time the worker thread should loop on uthread_schedule()
+ * before returning. The workers increment a global counter each time they loop.
+ * As a result the main thread knows how many times it should call
+ * uthread_schedule() to let the two threads proceed, and it also knows which
+ * value the counter should have at any moment.
+ */
+static int uthread(struct unit_test_state *uts)
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
+	ut_assertok(uthread_create(NULL, worker, (void *)10, 0, 0));
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
+LIB_TEST(uthread, 0);
-- 
2.43.0

