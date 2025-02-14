Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E980EC021A4
	for <u-boot@archiver.kernel.org>; Fri, 14 Feb 2025 14:02:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7EAB80F4E;
	Fri, 14 Feb 2025 15:01:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="R7l5uCgC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41B2E80F30; Fri, 14 Feb 2025 15:01:12 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21ADB80F42
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 15:01:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-38de17a5fc9so1119847f8f.3
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 06:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739541669; x=1740146469; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vw5QNJq6rc3BmUwd+FgBXihOmD2gLyqDw2aIcses8Oc=;
 b=R7l5uCgCzIaStf8A5dmtSr8Y4RY2cCVVQ5wzy7GsXAzODZv7UrPCvqSyC5Hg+vW03W
 iARmZhQ9uhAxLcguOSKp15Rrfd5zJUZqZwT+Aj7k9e0U3Es3OKSb00pgB5cVluV+r/LM
 6CqzAm4dTv/+Mk1A2cjd9cu/rLssvvYMaLMaW/baqj+CKMcWRs7NhAV3vf1R4A3diUxX
 JZpLHwYpaisS00a1nqrxNwVu0wOT+93uJuyTU4fd7+GSEFglVyOTHGto//tSdVh4/4r/
 G9KYQW0nmOiYkmWB3FEwklnRx56Yg1kpFed7bnXXiqATeJ9Br1WY25+fgAUWq4f+031W
 M5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739541669; x=1740146469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vw5QNJq6rc3BmUwd+FgBXihOmD2gLyqDw2aIcses8Oc=;
 b=A++W8PJ4urZudVmv0uU5isgYw+R8VWUyTokHX7/E47JDUfiWhkCD8Gv1n1ZzJZlVL3
 0pLx2dJ7JeXh6guG77Phrz/0sRGqsVmMJiqvpj/Pgh7QrihcG2YfrSvCvMPms2u8P314
 ZbbPCoOiHPanNoSlowVpqRdCw6Y/4jOnDCMNaKpBto9tGE8s3zUlc6bNLdxoz9WRsTRJ
 GavpjDXckRtU9Zpl2CdV3zALiXC6Ah7lKktwVALovhYrb+9UGczPMaS+ZmX8Z3+kCrSv
 j8aGi3PrmValYJQ1VnO7AooCODyoBTepDyi85p9zkQyxe+p1PQ4fGNNBy/aNydQNfOdm
 tvAg==
X-Gm-Message-State: AOJu0Yz9ZGZwrvUUjmyP7Z5WJ+NOnE7s5kfqF5xVeXTeZqezBLZUAeiE
 ptCQ+5CumoPEdzdpQEBxcoD8VAEBcuXyT5Lc5Jc4FQBlm9Ph3lywScWso1C0rR2MnI9KAF16amr
 xQ2p9IQ==
X-Gm-Gg: ASbGncucxZIn1bHj86QNbf8rhmeDNajmvWrZGlyEitxPunhV9pvNLhGfHNp6dDzQpT2
 ap1VVaMKAXixxt2PIykpL4fqshhCQSQfG/tAWCpdURL1z54xiJT+Jg+f3anchEVRMFgMl/XyPcl
 9KrjokMgxu6Z8Gi/sBr/WcI+5Vp5M7WU2X4opddz/t9bdZD83/6SCCATciQdEDBia9az/dog3j8
 7iQ+rCr4dvXsalQaQhfstF6WDK9P1n4fUdTqKVubLbmuAuYlAshr9MsNVZPQzWQ7Dh1BTnXouF7
 6y+gjyjtqh2X9TBPf5r1JJKJ
X-Google-Smtp-Source: AGHT+IFVqqWeNjM7Fs1QkKeEL513yMNgXQR+y7GlwQzQJuXEv1v0GoEGOfIhC6fLPKNhiK29pJdxZg==
X-Received: by 2002:a05:6000:1f81:b0:38a:8ed1:c5c7 with SMTP id
 ffacd0b85a97d-38f24528db4mr8934108f8f.46.1739541669158; 
 Fri, 14 Feb 2025 06:01:09 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:65ac:d875:2c3e:607f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258fc7e0sm4666391f8f.48.2025.02.14.06.01.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 06:01:08 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Raymond Mao <raymond.mao@linaro.org>,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [RFC PATCH 10/10] test: lib: add uthread test
Date: Fri, 14 Feb 2025 15:00:25 +0100
Message-ID: <20250214140031.484344-11-jerome.forissier@linaro.org>
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

Test uthread scheduling.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 lib/uthread.c      |  3 ++-
 test/lib/Makefile  |  1 +
 test/lib/uthread.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 1 deletion(-)
 create mode 100644 test/lib/uthread.c

diff --git a/lib/uthread.c b/lib/uthread.c
index bb132001fb6..1f8e6d0fa80 100644
--- a/lib/uthread.c
+++ b/lib/uthread.c
@@ -76,10 +76,11 @@ err:
 
 void uthread_free_all(void)
 {
+	struct uthread *main = &main_thread;
 	struct uthread *next;
 	struct uthread *tmp;
 
-	list_for_each_entry_safe(next, tmp, &current->list, list) {
+	list_for_each_entry_safe(next, tmp, &main->list, list) {
 		list_del(&next->list);
 		uthread_free(next);
 	}
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
index 00000000000..c9d030dc778
--- /dev/null
+++ b/test/lib/uthread.c
@@ -0,0 +1,58 @@
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
+
+	count = 0;
+	ut_assertok(uthread_create(worker, (void *)5, 0));
+	ut_assertok(uthread_create(worker, (void *)10, 0));
+	/*
+	 * The first call is expected to schedule the first worker, which will
+	 * schedule the second one, which will schedule back to the main thread
+	 * (here). Therefore count should be 2.
+	 */
+	ut_assert(uthread_schedule());
+	ut_asserteq(2, count);
+	/* Four more calls should bring the count to 10 */
+	for (i = 0; i < 4; i++)
+		ut_assert(uthread_schedule());
+	ut_asserteq(10, count);
+	/* This one allows the first worker to exit */
+	ut_assert(uthread_schedule());
+	/* Five more calls for the second worker to finish incrementing  */
+	for (i = 0; i < 5; i++)
+		ut_assert(uthread_schedule());
+	ut_asserteq(15, count);
+	/* Plus one call to let the second worker return from its entry point */
+	ut_assert(uthread_schedule());
+	/* Now both tasks should be done, schedule should return false */
+	ut_assert(!uthread_schedule());
+	uthread_free_all();
+
+	return 0;
+}
+LIB_TEST(lib_uthread, 0);
-- 
2.43.0

