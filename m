Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F80C28B28
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 15:22:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67D08819B1;
	Tue, 18 Mar 2025 16:21:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="W4UgOU5B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F83981C84; Tue, 18 Mar 2025 16:21:23 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3771819B1
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 16:21:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43948f77f1aso25406775e9.0
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 08:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742311280; x=1742916080; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+mVDRcCol7Chd0PJ7oZ5oFbXMC5+xcMWdpGT8tHV3pI=;
 b=W4UgOU5Bx9usUWByg2EC0orN/ZSgCZ1FkSLYFsGoN+0gq+x1Ux/N2Qs0DIQ0R1cwjj
 RoCTp99stzZtzHo5vjYvM4vQInBQ1XmMe8oB6gBkTT8pFUaaARhZZ2Y4HXvPt2Jwno7B
 QK21v6kK04C7M1R/tzveMHQhy6y3FJmF7QfmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742311280; x=1742916080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+mVDRcCol7Chd0PJ7oZ5oFbXMC5+xcMWdpGT8tHV3pI=;
 b=VIzX4A+CXjyCt3wYTlEqf6Ik6bL7LoYlVT3qNCH24RpyI4LZQnaQFc4hdWpD7GoxE0
 snprV/myUbHXK1fgzDQr6faHMgHE2n5QptPA1bJ+EsV1n9rNQG+kKJp+80LsLE0+U5VD
 cVw8I9pOaQvFITti3CEdmq7ig7R7k8f5yRMSaEChhVKfIn+r687AlA3QKmOa39H6ZwlQ
 ENeaIsjzlJnR3T1Vb4gAWvnX0PZzm5RLoUc48uk1GqNGuaNLjnOM2eSwMIAPjUcoqlpf
 IU4B4eOPglTb1cN+Dwbqb7moZm4lpx/EUDG06mMWlJ8hRlt3ukzanTuMxb1WoejmO6hW
 gDlQ==
X-Gm-Message-State: AOJu0YwmwAO1/6PDavPYwemohfTg8wyOSBGjdFwchA9Iwij4u6r090ry
 iNN/KPMZXk/Fl/2Ho8hVa1Pc12/Lo83kgZvXx6BFNXcL+XzW6ukcPUfqH4yPY4PLAItR6KeYCCo
 tqKiL
X-Gm-Gg: ASbGncuBu6/pz7IvoWfftQnUZCUaNgDrxtFvhnEqnJnZsCTd/33oDJ6VNhfF4xQyEqy
 OpBy7vZrLU10yYAjUbn/cCFYUk5Rt4US6C4oEcX4NP+ltC5o5yoUDD4eFyq2g2JPB75LwD3dS0S
 zn57tOxbgFFeavOe8uEhsQmOTk2KUfzjRGnyvA77w6A47s3Ac2u5vUG16NvZ9uJGcXukOp4nuLW
 7SSUSV/wLZ0Z7bgFLtnKDrR/HxD99Con3G+ur2yedECzGX6r09OTo+ftZqSBSZ8EJkTAi2vvaFZ
 T0BgHnRpL8zc9XsMbxLkLA9y4sS05MWNhj4Xj/asHA==
X-Google-Smtp-Source: AGHT+IEnwqdVCZtIuhOXyvvexFEtKPdWdVGszw1Wsf9L9ec6yAxa3zXBvWdMN/oKJohWLGNiBgAHrg==
X-Received: by 2002:a05:600c:3591:b0:43c:f6c6:578c with SMTP id
 5b1f17b1804b1-43d3fdd3e64mr12724025e9.15.1742311279469; 
 Tue, 18 Mar 2025 08:21:19 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe60d37sm136962225e9.27.2025.03.18.08.21.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 08:21:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 6/7] membuf: Add some tests
Date: Tue, 18 Mar 2025 16:20:47 +0100
Message-ID: <20250318152059.1464369-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318152059.1464369-1-sjg@chromium.org>
References: <20250318152059.1464369-1-sjg@chromium.org>
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

Add tests for the membuf implementation.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/lib/Makefile |   1 +
 test/lib/membuf.c | 239 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 240 insertions(+)
 create mode 100644 test/lib/membuf.c

diff --git a/test/lib/Makefile b/test/lib/Makefile
index 0e4cb8e3dfd..aa89923f786 100644
--- a/test/lib/Makefile
+++ b/test/lib/Makefile
@@ -14,6 +14,7 @@ obj-y += hexdump.o
 obj-$(CONFIG_SANDBOX) += kconfig.o
 obj-y += lmb.o
 obj-$(CONFIG_HAVE_SETJMP) += longjmp.o
+obj-$(CONFIG_SANDBOX) += membuf.o
 obj-$(CONFIG_CONSOLE_RECORD) += test_print.o
 obj-$(CONFIG_SSCANF) += sscanf.o
 obj-$(CONFIG_$(PHASE_)STRTO) += str.o
diff --git a/test/lib/membuf.c b/test/lib/membuf.c
new file mode 100644
index 00000000000..3f268a422d5
--- /dev/null
+++ b/test/lib/membuf.c
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#include <membuf.h>
+#include <os.h>
+#include <rand.h>
+#include <string.h>
+#include <test/lib.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+#define TEST_SIZE	16
+#define TEST_COUNT	10000
+
+static void membuf_zero(struct membuf *mb)
+{
+	memset(mb->start, '\0', mb->end - mb->start);
+}
+
+static int membuf_check(struct unit_test_state *uts, struct membuf *mb,
+			int value)
+{
+	/* head is out of range */
+	ut_assert(!(mb->head < mb->start || mb->head >= mb->end));
+
+	/* tail is out of range */
+	ut_assert(!(mb->tail < mb->start || mb->tail >= mb->end));
+
+	return 0;
+}
+
+/* write from 1 to test_size bytes, and check they come back OK */
+static int lib_test_membuf_one(struct unit_test_state *uts)
+{
+	char in[TEST_SIZE * 2], out[TEST_SIZE * 2];
+	struct membuf mb;
+	int size, ret, test_size, i;
+
+	ut_assertok(membuf_new(&mb, TEST_SIZE));
+
+	/* setup in test */
+	for (i = 0; i < TEST_SIZE; i++) {
+		in[i] = (i & 63) + '0';
+		in[i + TEST_SIZE] = in[i];
+	}
+
+	test_size = TEST_SIZE;
+
+	for (i = 1; i < TEST_COUNT; i++) {
+		membuf_zero(&mb);
+		size = rand() % test_size;
+
+		// now write patterns and check they come back OK
+		ret = membuf_put(&mb, in, 0);
+		ret = membuf_put(&mb, in, size);
+		ut_asserteq(size, ret);
+
+		ret = membuf_put(&mb, in, 0);
+		ut_assertok(membuf_check(uts, &mb, i));
+
+		ret = membuf_get(&mb, out, 0);
+		ret = membuf_get(&mb, out, size);
+		ut_asserteq(size, ret);
+
+		ret = membuf_get(&mb, out, 0);
+		ut_assertok(membuf_check(uts, &mb, i));
+
+		ut_asserteq_mem(in, out, size);
+	}
+
+	return 0;
+}
+LIB_TEST(lib_test_membuf_one, 0);
+
+/* write random number of bytes, and check they come back OK */
+static int lib_test_membuf_random(struct unit_test_state *uts)
+{
+	char in[TEST_SIZE * 2];
+	char buf[TEST_SIZE * 2];
+	struct membuf mb;
+	int size, ret, test_size, i;
+	char *inptr, *outptr;
+	int max_avail, min_free;
+
+	ut_assertok(membuf_new(&mb, TEST_SIZE));
+
+	for (i = 0; i < TEST_SIZE; i++) {
+		in[i] = (i & 63) + '0';
+		in[i + TEST_SIZE] = in[i];
+	}
+
+	test_size = TEST_SIZE;
+
+	inptr = in;
+	outptr = in;
+	min_free = TEST_COUNT;
+	max_avail = 0;
+	membuf_zero(&mb);
+	for (i = 0; i < TEST_COUNT; i++) {
+		size = rand() % test_size;
+
+		if (membuf_free(&mb) < min_free)
+			min_free = membuf_free(&mb);
+
+		ret = membuf_put(&mb, inptr, size);
+		ut_assertok(membuf_check(uts, &mb, i));
+		inptr += ret;
+		if (inptr >= in + TEST_SIZE)
+			inptr -= TEST_SIZE;
+
+		size = rand() % (test_size - 1);
+
+		if (membuf_avail(&mb) > max_avail)
+			max_avail = membuf_avail(&mb);
+
+		ret = membuf_get(&mb, buf, size);
+		ut_assertok(membuf_check(uts, &mb, i));
+		ut_asserteq_mem(buf, outptr, ret);
+
+		outptr += ret;
+		if (outptr >= in + TEST_SIZE)
+			outptr -= TEST_SIZE;
+	}
+
+	return 0;
+}
+LIB_TEST(lib_test_membuf_random, 0);
+
+/* test membuf_extend() with split segments */
+static int lib_test_membuf_extend(struct unit_test_state *uts)
+{
+	char in[TEST_SIZE * 2];
+	char buf[TEST_SIZE * 2];
+	struct membuf mb;
+	int ret, test_size, i, cur;
+	char *data;
+
+	ut_assertok(membuf_new(&mb, TEST_SIZE));
+
+	for (i = 0; i < TEST_SIZE; i++) {
+		in[i] = (i & 63) + '0';
+		in[i + TEST_SIZE] = in[i];
+	}
+
+	test_size = TEST_SIZE - 1;
+
+	for (cur = 0; cur <= test_size; cur++) {
+		ut_assertok(membuf_new(&mb, TEST_SIZE));
+
+		membuf_zero(&mb);
+
+		/*
+		 * add some bytes, then remove them - this will force the membuf
+		 * to have data split into two segments when we fill it
+		 */
+		ret = membuf_putraw(&mb, TEST_SIZE / 2, true, &data);
+		membuf_getraw(&mb, ret, true, &data);
+		ut_asserteq(TEST_SIZE / 2, ret);
+
+		/* fill it */
+		ret = membuf_put(&mb, in, cur);
+		ut_assertok(membuf_check(uts, &mb, cur));
+		ut_asserteq(cur, ret);
+
+		/* extend the buffer */
+		ut_assertok(membuf_extend_by(&mb, TEST_SIZE, -1));
+		ut_assertok(membuf_check(uts, &mb, cur));
+
+		/* check our data is still there */
+		ret = membuf_get(&mb, buf, TEST_SIZE * 2);
+		ut_assertok(membuf_check(uts, &mb, cur));
+		ut_asserteq(cur, ret);
+		ut_asserteq_mem(in, buf, cur);
+		membuf_uninit(&mb);
+	}
+
+	return 0;
+}
+LIB_TEST(lib_test_membuf_extend, 0);
+
+/* test membuf_readline() with generated data */
+static int lib_test_membuf_readline(struct unit_test_state *uts)
+{
+	char *buf;
+	int size, cur, i, ret, readptr, cmpptr;
+	struct membuf mb;
+	char *data;
+	char str[256];
+	char *s;
+
+	ut_assertok(membuf_new(&mb, 1024));
+	membuf_zero(&mb);
+
+	/* Use the README as test data */
+	ut_assertok(os_read_file("README", (void **)&buf, &size));
+
+	cur = 0;
+	readptr = 0;
+	cmpptr = 0;
+	for (i = 0; i < 100000; i++, cur += 1) {
+		/* fill the buffer with up to 'cur' bytes */
+		ret = membuf_putraw(&mb, cur, false, &data);
+
+		if (ret > 0) {
+			int can_read = min(ret, size - readptr);
+
+			memcpy(data, &buf[readptr], can_read);
+			readptr += can_read;
+
+			membuf_putraw(&mb, can_read, true, &data);
+			ut_assertok(membuf_check(uts, &mb, i));
+		}
+
+		/* read a line and compare */
+		ret = membuf_readline(&mb, str, 256, 0, true);
+		ut_assertok(membuf_check(uts, &mb, i));
+		if (ret) {
+			char *ptr;
+
+			s = &buf[cmpptr];
+			ptr = strchr(s, '\n');
+			*ptr = '\0';
+
+			ut_asserteq_str(s, str);
+			cmpptr += strlen(s) + 1;
+			*ptr = '\n';
+		} else {
+			ut_assert(membuf_free(&mb));
+		}
+	}
+	membuf_dispose(&mb);
+	os_free(buf);
+
+	return 0;
+}
+LIB_TEST(lib_test_membuf_readline, 0);
-- 
2.43.0

