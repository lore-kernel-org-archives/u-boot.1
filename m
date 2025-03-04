Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5DA1C282D2
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 15:32:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F214801CF;
	Tue,  4 Mar 2025 16:32:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="b/yD7lXr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE120812C8; Tue,  4 Mar 2025 16:32:08 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61A8E810DC
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 16:32:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43bcbdf79cdso6278385e9.2
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 07:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741102298; x=1741707098; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h+4hVmas2EiPoyJIFhc1fMdsIcMgmXOQv5p+6lZAxr0=;
 b=b/yD7lXr9nWtOomw7XqORBw/onF17c0cAe7KLSIAW3ZHJeoqCtF/np8/4nrZOnW4cj
 jXoVVWIchxlZZB62UDXD432ZbK1c0e8o4uzPO5eC2WqhKqPIxYzgzyk0W1vH9E23vepN
 DSqOjBYVcGgTDgwpfmRzCA6ysrRSHZ/H4zk0Gnpmhq1QNwSH1HqjJ7BaTx0MINFBPLKx
 fv/8wZn26CvFKL/dby4vCeqFNihoI5/NZO92c1jSw5SFr6i9B5GBwh05oZwp1hPf/xCZ
 XxYGGHo8iEtudo0N8Kdwfx0LjXZmqxe7IbY1WSG5SdA+vS6AywBO1hf7s+VvEoMtNlTL
 aDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741102298; x=1741707098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h+4hVmas2EiPoyJIFhc1fMdsIcMgmXOQv5p+6lZAxr0=;
 b=nZ4LHI44eyV+Y0j6p2UnJ2O+KdiyzcsniVmkWZoJwgiz+i8T4jvekwHGhZLO10TuoU
 RzuUKbxOIAegnd7SjzvHrf4rG6Pq/gF+R3A3h3zeX3I5vTyaiCQaI6J+Vn59dDFdJbV/
 6NW2ykvqzrk2eYR0RI8gDzRcK/+RylwNwXR61IzO+AgkV7W9/Tbvk7sU5ogq9c8Jqpxs
 6BxsVR9Iu2aqWy1CH1n1tG3yE7v102QseOSBngX/E+z3yRX41PETPKrTYZ2K/qsFWigP
 SRH5Tp4bcL2FuXTBbS9bGfUS/QV7LdCVSn1NVlgau2YQ5rqG/TKn3jzQpcucC4KHEafn
 Ox3w==
X-Gm-Message-State: AOJu0YwjB/gz550VUXE2CXOSsl0vIHMODswxBRSO7SV9KMLL8nPPj9pi
 29b1Aks/BHOpfsRb6dXIfaf0Bo3Jw5+99s5RIS3dbQHOoyNoP3ucOp45yP3KDmS4NzBN36eDzc+
 y
X-Gm-Gg: ASbGnct9VeCwQGTj/UlnsGZxR+f8+1XzV51cdOsAXcxEErqrgPHJEciGJ8O00vSzdnA
 1DBfRPTfXvuR+jFDAO6iy+MiMeY0hn3XnaebZR7g5/w/4vbI4Z+RorTEnHJRr/KEKzzGMFT10pN
 wvzJnxwZD1xMc+KcgaFFZaCoDZYCmxv7ED9c59rB+FZEqReLVRYShYHWA1t5uMGWuz87eyg5F+E
 istpGF6wo6vKg8ouVVZ3S9VS5697f9BTl1OgsT6XsZjDSu1B8PPbBpd1IUKB08LLatutghR+dKp
 MQLy7Hs1P1pTpY5f+vgtNhSvhYYI/M9kR8kfJv098+I0Ul+WrZA5hg==
X-Google-Smtp-Source: AGHT+IFUBb7/6WMMHaTk3npBA7HKMzWcrzI9EylsI2amgbE9DkfFyyxSKC7kum9R6CEJc1vJqqP9hQ==
X-Received: by 2002:a05:600c:4ec8:b0:439:8b19:fa87 with SMTP id
 5b1f17b1804b1-43ba66de874mr137013645e9.4.1741102297662; 
 Tue, 04 Mar 2025 07:31:37 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:771e:3d0f:d9c9:2f92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e485db82sm17669254f8f.88.2025.03.04.07.31.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 07:31:37 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Raymond Mao <raymond.mao@linaro.org>,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v3 09/14] test: lib: add uthread test
Date: Tue,  4 Mar 2025 16:24:57 +0100
Message-ID: <20250304152510.2832340-10-jerome.forissier@linaro.org>
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

Add a uhread framework test to the lib tests. Update the API
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

