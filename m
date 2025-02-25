Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C67C021B2
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 16:36:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A8698104B;
	Tue, 25 Feb 2025 17:35:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JUBnXKQg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D98FA810F1; Tue, 25 Feb 2025 17:35:24 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8DA78104B
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 17:35:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-439ac3216dcso34660075e9.1
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 08:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740501322; x=1741106122; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MSvBrHsgKEvlZcp51TYx/CfxU1FN8m2sCk/LzFjOfQg=;
 b=JUBnXKQgFO6E6wE2S5QBrGSEtwdEVCxPDY4m/xZzTnCZ4Ix4/2XDJKvp9V0E3p1dhR
 3rPVLa2m/FVacw0p9o1/1T4/pIizJhMfSXtlBSIIGJ1pLDwP/HkGvyrP+sLsLOfXPLba
 czFRSN4YuTbIYT9vQwKQ79fZ3IuhNPzwqlzs2OGJEW6wbwSJY7H0I21KWsViFwVQro14
 sQ/YM8kIZqwVtY09yvYAOLWOzkzN9tfWHaKNe9pFqYZatJ1oEAHzsVOCch9A06W+8SgC
 pR3aI8roXWQ6v8awtVmpIzr/DhOVSrVJOkp3wHG4rFjTLU1izaFWkd62boAlQo67FcK8
 rjtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740501322; x=1741106122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MSvBrHsgKEvlZcp51TYx/CfxU1FN8m2sCk/LzFjOfQg=;
 b=rkAdu1WpcpAnrPLhTtu8BrPDo6+vTuLxrvjHKGVqktuyFyKBdLTMM6UpNTM6lz++Pa
 D8QdQL8k1xT9a3rWwhiinuN6pwDvKsjOqOxs//jgPPyW1Fj/jA3EMslnPIH5/TKMYT3Q
 2l/QRZgIaAby1OUZOU6vz1P/79q2BoQaQ3K4bQMd1Im+r93ST+iPFmLR7/Z6BuWhq+RX
 cw6MO7w5tknPILvTot2QnUzGksNnTWPwe12kD51DdrlaHQBUs1AbOyhj1SjEKA+bHAmG
 WO7BghuiUnBheEVTm4ODZOfyQB+ylPygceViUes9Kb8cXesaaqTSD9NrOBS44nz6j4hA
 TWQw==
X-Gm-Message-State: AOJu0Ywcw6/KfHcODZGXeWh4qmxXsXQPKKaLL1SGWdkYQb/VQke7HOy+
 y7BZjkGg/XizVOlH+AsAlX4+6SK6bJTd7emhmOixCeS98OoXIFHtukH/FGElydCWPt7HaNxMZgk
 6crCIqA==
X-Gm-Gg: ASbGncv6i2+PL07hFw5lASxOG8rNYnFo/k0o3JNxbmJuDRNpeFazTVGgj5SP2W1Rqwk
 CCxbw2jIzwf1YdLioV445emcBFkEVd2ZrK1+9k53WRwqdQjpdVJdd0audkG2QSoPoR0WiGUNzGv
 HCbXVdwx12Z2hXEIKuGyF7B0I5SLBtqtAjYFlzCP1iNT9GGM4TSqWRcH7fSqKupefdboz/IGzt2
 +aTyC5ZgvFaP53VfKWjBU2fpdtZx0Fe2PC5Y3rHuqAzAEvYvunJGSKyU2fI54m1lheQfk/4i9vi
 +5w+d7F03LfivcPf+iUif6A7oLmM+xnRm6g=
X-Google-Smtp-Source: AGHT+IHV0r/ptpM8Gyz88M15zsfGUXb2VAvIEJ/uVaSAwyItwvY5qpryrDcQRDg7bYMFpLEMy+K0gg==
X-Received: by 2002:a05:600c:1906:b0:439:9c0e:3709 with SMTP id
 5b1f17b1804b1-439aeafab74mr127407795e9.8.1740501322187; 
 Tue, 25 Feb 2025 08:35:22 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02ce735sm146356195e9.3.2025.02.25.08.35.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 08:35:21 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Raymond Mao <raymond.mao@linaro.org>,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v2 10/14] test: lib: add uthread test
Date: Tue, 25 Feb 2025 17:34:36 +0100
Message-ID: <17ec7e3f553fa8c36c19d2cbf4cc0e6d03c7e443.1740499185.git.jerome.forissier@linaro.org>
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

Add a uhread framework test to the lib tests.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 test/lib/Makefile  |  1 +
 test/lib/uthread.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)
 create mode 100644 test/lib/uthread.c

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
index 00000000000..84c41d35875
--- /dev/null
+++ b/test/lib/uthread.c
@@ -0,0 +1,68 @@
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
+	ut_assertok(uthread_create(worker, (void *)5, 0, id1));
+	ut_assertok(uthread_create(worker, (void *)10, 0, 0));
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

