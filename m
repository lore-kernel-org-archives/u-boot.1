Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23194C3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:48:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A09D826AD;
	Fri,  2 May 2025 16:47:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ebeW77NE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1208182905; Fri,  2 May 2025 16:47:39 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFD1E826AD
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:47:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-85e1b1f08a5so62924639f.2
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197254; x=1746802054; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ui2WrdkUmuGWBD25Q3cYHTbc0OII+p23M2rp8gJ447U=;
 b=ebeW77NEJiZ8gPrRceFBJhQ9U/qNjnA2/QSkR3O0iSggZk9CsUZFsb5tH6tmEWhlNA
 tnSkRyB7vsSmbFQBdoHbga/tJcCFfPOIghbTZtgLaxhDcnXka24XKyS8tySbDNbTSb8a
 VT/8KF5t3a8566v0bm5OUDl6mRrAI6xTF+Nz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197254; x=1746802054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ui2WrdkUmuGWBD25Q3cYHTbc0OII+p23M2rp8gJ447U=;
 b=FF/nYBs1XQwjFQZjDT7LSvPA6aiA0mUX/7xs8sKmVeMwbR1lROWFkOCRkXaKgYfbqU
 fTJWEYNuR5nRKnXas2AsgZTZt4GyOsxPoAHh9+ds0uFw4VfzEs5rS3ALLBkyHnCNPwc6
 +mMSq6mse5cqIc9cv0FnPEIJEBWAuWiq5za+n9IwfHPIwYfgt9lK7XEr+08gAsJxL6/t
 BzytQ/CLU2TLQ0xTP8JUSh6SB3NgdFQ6dkhu/R823HB+Us/LCuj/l1LPRquUEiYdS7zD
 gZ5taH6kwriieHyW55lDeqtAuuW25v3BDvCmfpKGzRkbu7cNek9xOB1Eeb/S4+mXBfbI
 wZ9A==
X-Gm-Message-State: AOJu0YzuxcARQjLkq9u6nridTQ2PAr+yjfsfTWytMifF52ZiWzD0aiKP
 nzS9DjWeLQSOiFu9JupIcv7YywuXjwd1I4lXWIcP2Reo4y2EATxN/JSBT6dtu5h2xs5zYlilyL4
 =
X-Gm-Gg: ASbGncvjQvCJPdbfJbEnW3uRt9g/kICyDUlOtd3PP4r+0qVSJmdrZz7SkqB7DF4OKzt
 dzVbXsFLBqLBdNx7iaHjml1NgKbATjR/fu+tCBnoDHCd52SFHzvxj1tlYeGZmqyUfoMnSCvXI/G
 cd+XtE+sSd8pHnVg854QLb8A6561s69S+HEiABYBGTHw7KvFvkAKV95zBFdNnsAsOdTsa071VXM
 2IRyRwtcvFJ/3PHYL8iqGGqaJ8nltzPKt+Oqh76bB2h/9WevZ4FE5wB1/TMBaJ+UegrqM7BEX28
 1ZQinWmFB8Yxws35dAuNCtcbiZZvN1N696CX9hPpT9Lj9m3PrUXfFxOa7Z2jW9dcPVs45uHVTRm
 Qdw==
X-Google-Smtp-Source: AGHT+IFIFFHh7ic3BJwuZA0Bh4NHG1GNmLm8ubOloyy3eXwyYEIYv62kw/PVfbaREFWjZIxBw/roSw==
X-Received: by 2002:a05:6602:4818:b0:864:552f:eb26 with SMTP id
 ca18e2360f4ac-8669f96715amr400218239f.1.1746197254420; 
 Fri, 02 May 2025 07:47:34 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.47.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:47:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 06/60] abuf: Add a way to printf() into a buffer
Date: Fri,  2 May 2025 08:46:04 -0600
Message-ID: <20250502144718.313633-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250502144718.313633-1-sjg@chromium.org>
References: <20250502144718.313633-1-sjg@chromium.org>
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

It is useful to format a string into a buffer, with the sizing handled
automatically. Add a function for this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/abuf.h  | 21 ++++++++++++++++
 lib/abuf.c      | 35 +++++++++++++++++++++++++++
 test/lib/abuf.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 118 insertions(+), 2 deletions(-)

diff --git a/include/abuf.h b/include/abuf.h
index bbb3c51f334..7872e9c9b27 100644
--- a/include/abuf.h
+++ b/include/abuf.h
@@ -122,6 +122,27 @@ bool abuf_realloc_inc(struct abuf *abuf, size_t inc);
  */
 bool abuf_copy(const struct abuf *old, struct abuf *new);
 
+/**
+ * abuf_printf() - Format a string and place it in an abuf
+ *
+ * @buf: The buffer to place the result into
+ * @fmt: The format string to use
+ * @...: Arguments for the format string
+ * Return: the number of characters writtenwhich would be
+ * generated for the given input, excluding the trailing null,
+ * as per ISO C99.
+ *
+ * The abuf is expanded as necessary to fit the formated string
+ *
+ * See the vsprintf() documentation for format string extensions over C99.
+ *
+ * Returns: number of characters written (excluding trailing nul) on success,
+ * -E2BIG if the size exceeds 4K, -ENOMEM if out of memory, -EFAULT if there is
+ * an internal bug in the vsnprintf() implementation
+ */
+int abuf_printf(struct abuf *buf, const char *fmt, ...)
+		__attribute__ ((format (__printf__, 2, 3)));
+
 /**
  * abuf_uninit_move() - Return the allocated contents and uninit the abuf
  *
diff --git a/lib/abuf.c b/lib/abuf.c
index 28c748acb9f..3a2fd1782e9 100644
--- a/lib/abuf.c
+++ b/lib/abuf.c
@@ -10,8 +10,11 @@
 #include <malloc.h>
 #include <mapmem.h>
 #include <string.h>
+#include <vsprintf.h>
 #endif
 
+#include <errno.h>
+#include <stdarg.h>
 #include <abuf.h>
 
 void abuf_set(struct abuf *abuf, void *data, size_t size)
@@ -142,6 +145,38 @@ bool abuf_copy(const struct abuf *old, struct abuf *copy)
 	return true;
 }
 
+int abuf_printf(struct abuf *buf, const char *fmt, ...)
+{
+	int maxlen = buf->size;
+	va_list args;
+	int len;
+
+	va_start(args, fmt);
+	len = vsnprintf(buf->data, buf->size, fmt, args);
+	va_end(args);
+
+	/* add the terminator */
+	len++;
+
+	if (len > 4096)
+		return -E2BIG;
+	if (len > maxlen) {
+		/* make more space and try again */
+		maxlen = len;
+		if (!abuf_realloc(buf, maxlen))
+			return -ENOMEM;
+		va_start(args, fmt);
+		len = vsnprintf(buf->data, maxlen, fmt, args);
+		va_end(args);
+
+		/* check there isn't anything strange going on */
+		if (len > maxlen)
+			return -EFAULT;
+	}
+
+	return len;
+}
+
 void abuf_init_const(struct abuf *abuf, const void *data, size_t size)
 {
 	/* for now there is no flag indicating that the abuf data is constant */
diff --git a/test/lib/abuf.c b/test/lib/abuf.c
index c19012d2954..def491ac7a8 100644
--- a/test/lib/abuf.c
+++ b/test/lib/abuf.c
@@ -455,12 +455,72 @@ static int lib_test_abuf_init_size(struct unit_test_state *uts)
 	ut_assertnonnull(buf.data);
 	ut_asserteq(TEST_DATA_LEN, buf.size);
 	ut_asserteq(true, buf.alloced);
-	abuf_uninit(&buf);
 
 	/* Check for memory leaks */
 	ut_assertok(ut_check_delta(start));
 
-	return 0;
+	abuf_uninit(&buf);
 	return 0;
 }
 LIB_TEST(lib_test_abuf_init_size, 0);
+
+/* Test abuf_printf() */
+static int lib_test_abuf_printf(struct unit_test_state *uts)
+{
+	struct abuf buf, fmt;
+	ulong start;
+	char *ptr;
+
+	start = ut_check_free();
+
+	/* start with a fresh buffer */
+	abuf_init(&buf);
+
+	/* check handling of out-of-memory condition */
+	malloc_enable_testing(0);
+	ut_asserteq(-ENOMEM, abuf_printf(&buf, "%s", ""));
+	malloc_enable_testing(1);
+
+	ut_asserteq(0, abuf_printf(&buf, "%s", ""));
+	ut_asserteq(1, buf.size);
+	ut_asserteq(true, buf.alloced);
+	ut_asserteq_str("", buf.data);
+
+	/* check expanding it, initially failing */
+	ut_asserteq(-ENOMEM, abuf_printf(&buf, "%s", "testing"));
+	malloc_disable_testing();
+
+	ut_asserteq(7, abuf_printf(&buf, "%s", "testing"));
+	ut_asserteq(8, buf.size);
+	ut_asserteq_str("testing", buf.data);
+
+	ut_asserteq(11, abuf_printf(&buf, "testing %d", 123));
+	ut_asserteq(12, buf.size);
+	ut_asserteq_str("testing 123", buf.data);
+
+	/* make it smaller; buffer should not shrink */
+	ut_asserteq(9, abuf_printf(&buf, "test %d", 456));
+	ut_asserteq(12, buf.size);
+	ut_asserteq_str("test 456", buf.data);
+
+	/* test the maximum size */
+	abuf_init(&fmt);
+	ut_assert(abuf_realloc(&fmt, 4100));
+	memset(fmt.data, 'x', 4100);
+	ptr = fmt.data;
+	ptr[4096] = '\0';
+
+	/* we are allowed up to 4K including the terminator */
+	ut_asserteq(-E2BIG, abuf_printf(&buf, "%s", ptr));
+	ptr[4095] = '\0';
+	ut_asserteq(4095, abuf_printf(&buf, "%s", ptr));
+
+	abuf_uninit(&fmt);
+	abuf_uninit(&buf);
+
+	/* Check for memory leaks */
+	ut_assertok(ut_check_delta(start));
+
+	return 0;
+}
+LIB_TEST(lib_test_abuf_printf, 0);
-- 
2.43.0

