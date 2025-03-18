Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D06C28B28
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 10:48:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C6C981A10;
	Tue, 18 Mar 2025 11:47:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aDbXa91m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E82DD81D3B; Tue, 18 Mar 2025 11:47:34 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B102281D0B
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 11:47:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cf257158fso20743855e9.2
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 03:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742294851; x=1742899651; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qkBJkl3WKwaUf5l3xYynOeT0PQynHCpYMM2dqIakoiU=;
 b=aDbXa91mU6b97ldxHVzwZ5ejlaKHYjWkhAi1FgVYrgsodyhL9LY9JLghcjXjRAkAmD
 ZD0fwDmjl22/qc2sbm7CdyXwly22yCSAm3KMpKwoiBS0mGujT3mIDwtyVPXMnE9ilSBX
 NRnZZ02BtG0P+a9/iq1peH1NOVfn9FJAXlZ6vc1Bk2TtUwaixgkV8EDre+QlWLk7j8yQ
 V8n1gndoRYAoTLcrB10yaifY64D6akO50fwboNIuOkk+6gCv5ATPI8mSbX1L/WIRoQfe
 ymr/DrrJfVKUJIb5QKviIPB6xa9Y8oJeCQ0fWthkKGW0MtyI9M3devWL0bPPXZtKquq7
 YPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742294851; x=1742899651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qkBJkl3WKwaUf5l3xYynOeT0PQynHCpYMM2dqIakoiU=;
 b=oy29zapS9if8nY6da3DiO7JEn1/+MMRzxs0nRXY7gxYL6vzYudz/wzFf53zDWA8Q7u
 xWRcSfSVjYadI73JROYiro5+vML4jXIMGesmxioQZV3klNVvHZ0rxZN1FuPi09hVhHAj
 D+LlNjLx9ZbaFrv4s17MsFvG1i5VJ/zYML5dmzK7qWGVUx2j6I4Yi+BBLZoaT9tStTkT
 agkMm2mK8UnSSVHXqa+V3s5lJCJc4ZTPHHqyzvZ4BRnIuWDI2LHuDbTvsEtdX+1pSOsx
 UA6EPKaGXggm06nAHMGd/2BDdhmwDji7JgLMU0ahYt2vQWAxl03ZcoKxd1i86xEKMAc2
 qirw==
X-Gm-Message-State: AOJu0YwjrYikwk+IYQMRjTdMs9LkaFc8c+r2ylqB98Py+O5u3y0SnE1u
 4KkSBkZZKhATdcEHDm6rsn3RNzBP94Uq8ckLuNJbJHTPfJ2VTF78Pjh+yha6tEZ2eq/8qq9kIYr
 ccQY=
X-Gm-Gg: ASbGncs5KUlMNZLeVGjz1qhS88Ek/UljD0gAYK1Zvp1Jfc4ZLJOapklQLU8kB6rdriY
 nxjetlU6skNEtZF8g7jmiI35PCSWTrh0JFqi+K0ncPqFzc2Yn4Ymqjoj8JQl8C1eU61Q0HesuXx
 S57xOOajnTXN7xBwWu0y5hDzY+3uYI12N02dWSLNG7qgw8KeYc+JwMXthRBM8QFST6QCJG3ROM8
 DA8bKOSY/n9v6nthSBpUUPIvGVY8ks3k5PYo/JOCj98WotkCZByKeSHTwQbqZuEf4QldjBGZq32
 VDFlk8sKRNfgK0z9vjH5+leBiUkaWI/rcTYiTTBdgSxA1gVvHBbfXZk3fxTTartR
X-Google-Smtp-Source: AGHT+IFFueoZG6PEHugNuq7S4JzTW3D6VuiZfDCG01KaDjPPtw5lmOJT1tihJ8+n/pHIrHc78lmupg==
X-Received: by 2002:a05:600c:4f49:b0:43c:ea1a:720a with SMTP id
 5b1f17b1804b1-43d3b9502e0mr9047155e9.1.1742294850765; 
 Tue, 18 Mar 2025 03:47:30 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:78bd:2e7e:120c:26bb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fdda2dbsm131788185e9.2.2025.03.18.03.47.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 03:47:30 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v4 09/14] test: lib: add uthread test
Date: Tue, 18 Mar 2025 11:46:45 +0100
Message-ID: <20250318104659.1114340-10-jerome.forissier@linaro.org>
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

