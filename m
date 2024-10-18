Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085FDD3C53F
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 03:01:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 611DF891C4;
	Fri, 18 Oct 2024 05:00:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kS9BXmn+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B33D3891E0; Fri, 18 Oct 2024 05:00:57 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6488989185
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 05:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-83ab694ebe5so33148839f.0
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 20:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729220454; x=1729825254; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FZTfiSC+i6lhuATfSaAIF9zOI06j8Zc1GQ9TNBFsWAg=;
 b=kS9BXmn+DpLDBW5ZrK6Ngi8HCqn4+qpgpQ9u9J/dc+6nIANIZcdQaTotUPl7SGfHZ+
 g2NICz4vjgsGF8/VwyNM8dN4faZnSQy82UTWIOEc+UVhJdhzcOrUpc/VbKbGEViDq6iH
 cut7fieWleNpj04Vv0pyviZCZZsrfJib8fQIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729220454; x=1729825254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FZTfiSC+i6lhuATfSaAIF9zOI06j8Zc1GQ9TNBFsWAg=;
 b=HS5RdouoAZPPo5mKbWCYhxo0m1s+A2z5MslpS64xR9E0utA2/lurZojkg7pkPTxnnN
 aWOL9jSBZK6qziBZDtqbdOPY4M0HZm9l5xXBVORlIqKUajOE4Q6/jAflQr60EYJcwUsf
 8YM5V6bywUMxtsyO8hSrTBpC6vRWRIT7GkeoQ3Z1Ds6XVYzInmxriRd3u3WMlCm57Exs
 TJIB702Xy6rOFaSxsps0alk1y2/ib7Ug/6NHO1xsYG5lGnrp/zB+N5lbfmAIGTUsjFEO
 fRf5Yn+vZbn5OzsJqaUV91JTsrMAD71CJbToNbc8LMLkCdbJa8ZAcF1mfwRRGGzCqZ+r
 58ag==
X-Gm-Message-State: AOJu0YyD8hd9qeJ1mjfHhmlNnCf4WMFmWq/pmkVfo7w58l7U4axOd+CN
 UJssUKXr/yzQsej/nQxWjdBFeEOo3aCTelHaWvQSRSYRyUcYJotr+r2kK/5HDQu4gH1mJyr8iFM
 =
X-Google-Smtp-Source: AGHT+IE2jMx5ArVlALHGbMVjUGwM2ZqXswiVD8/6xNLvPjz6wv8C4UVWZ32voVknFvQGo8Au2/FLYw==
X-Received: by 2002:a05:6e02:1445:b0:3a2:7651:9878 with SMTP id
 e9e14a558f8ab-3a3f4073cf2mr6625945ab.12.1729220453960; 
 Thu, 17 Oct 2024 20:00:53 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b83e6dsm192499173.39.2024.10.17.20.00.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 20:00:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 6/8] membuf: Add some tests
Date: Thu, 17 Oct 2024 21:00:25 -0600
Message-Id: <20241018030027.842749-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018030027.842749-1-sjg@chromium.org>
References: <20241018030027.842749-1-sjg@chromium.org>
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

 test/lib/Makefile |   1 +
 test/lib/membuf.c | 239 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 240 insertions(+)
 create mode 100644 test/lib/membuf.c

diff --git a/test/lib/Makefile b/test/lib/Makefile
index a54387a058e..014cd42efe1 100644
--- a/test/lib/Makefile
+++ b/test/lib/Makefile
@@ -12,6 +12,7 @@ obj-y += hexdump.o
 obj-$(CONFIG_SANDBOX) += kconfig.o
 obj-y += lmb.o
 obj-y += longjmp.o
+obj-$(CONFIG_SANDBOX) += membuf.o
 obj-$(CONFIG_CONSOLE_RECORD) += test_print.o
 obj-$(CONFIG_SSCANF) += sscanf.o
 obj-y += string.o
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
2.34.1

