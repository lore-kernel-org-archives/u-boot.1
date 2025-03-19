Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84ED3C35FFB
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 11:59:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5285981C67;
	Wed, 19 Mar 2025 12:59:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kLNUKFnf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 141FB81C67; Wed, 19 Mar 2025 12:59:35 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E468881951
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 12:59:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39141ffa9fcso5865669f8f.0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 04:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742385571; x=1742990371; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wuWuhJEJaAaoGSUu/ApBRCmu3dxsRzVUwMndy77boso=;
 b=kLNUKFnft68sCwN3ocutpyZQH2gsJNeHwKf7gpUFlGQL/N6k5Ij8XZlDimFdBsjb8/
 NnO/LYQxyCHM52ZYXdeHG1Vs1INADB4zvm7TbmrBVPMtjA+t5yLITWiZFe+HxRxNzz2A
 oQp8/rBgyhUhtqnsaShkBRz5Gak2cvEWk468A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742385571; x=1742990371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wuWuhJEJaAaoGSUu/ApBRCmu3dxsRzVUwMndy77boso=;
 b=qVf5Oh1fvyWIKRMeRsQzO7NC2pQiKhxbEQ5fVrTdRM4JoI6CZ9KsZx8D+XVHsM8u+B
 FcBnw5kGpO0Q9yXrqj1dvpeIkGLVaSF81GyeyTg3zL6+Sz2pFB/t8KAbdTH1Fs5uXXlz
 r+Mljb89V0weeM3OtxiWxMINanPzwE81lj1IXek7qYbqcJFdWmk1VMqRDJeEiqI2u/Oc
 jkQ+qKpXZV7eRi1vMzXx5kzWo+9EkgozcHFNfoFzzyMa+hDgNOpDoJkGpPRZ6PqA9jon
 mnsDINRXO5k9uiYKp6N1ccECyjQk+XUBlIc0dH6Tvs7ST2QTukHbN+/ZBetkLQy2oNTa
 nwZw==
X-Gm-Message-State: AOJu0YwfAF10eOJwT9JC+DwJW+zooGuHiy8Rn3Ym8WsRzRn0jWFAp3yh
 zwWNLA8UdSKwb+KBxNc88nCVUvhSkqkNlCXSzkockI4d/djgYcABjicnZvwoxQ2d1fObrF3TthK
 /hA==
X-Gm-Gg: ASbGncuXOGHpwex4xdSmDmKR+RVuH5K6BTS7ogsIQf2OG8vO10moiAPmOuYcRjkcd0s
 5n1w6ZXEfIlx5srOdpK4uNlIzvmolc0YwT+A52iqfxfXZwJAl9ePFlctWz+WapIOnWpdzUW6SG9
 7oElVvCdwZm83n+GRo3LOBiMNe180LcCsyPAO/G8rCMeUMqcS03zxtgyTul8NEVpQZwf98DhjCl
 AurbGJbqYpOZSnGIyZ3XwY5LiUGNuB4TEiNMvvTR/vxUK0rcaLD4K/CiFObPNcvZiglJ40u85iD
 H5K3NuEGVP2ZZo7o9bTo4BbC69MreL0vm7cad4vrhA==
X-Google-Smtp-Source: AGHT+IFqmf+Ndt/QdHAlcgGdtpqa30bSynqDRyAekl9k121kW35mKNzp+KQvBqRMosbIDba5VhVJMg==
X-Received: by 2002:a5d:5848:0:b0:390:fbdd:994d with SMTP id
 ffacd0b85a97d-399739c8c6fmr1946430f8f.27.1742385570846; 
 Wed, 19 Mar 2025 04:59:30 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb7ea16csm20606906f8f.82.2025.03.19.04.59.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 04:59:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/6] abuf: Add a way to printf() into a buffer
Date: Wed, 19 Mar 2025 12:59:04 +0100
Message-ID: <20250319115911.2204045-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319115911.2204045-1-sjg@chromium.org>
References: <20250319115911.2204045-1-sjg@chromium.org>
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

 include/abuf.h  | 21 +++++++++++++++++
 lib/abuf.c      | 35 ++++++++++++++++++++++++++++
 test/lib/abuf.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 117 insertions(+)

diff --git a/include/abuf.h b/include/abuf.h
index 64189a4e32c..e761e87b584 100644
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
index 503f5004ff8..816f92587eb 100644
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
@@ -133,6 +136,38 @@ bool abuf_copy(const struct abuf *old, struct abuf *copy)
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
index fa6b007248c..1b16d79cc03 100644
--- a/test/lib/abuf.c
+++ b/test/lib/abuf.c
@@ -442,3 +442,64 @@ static int lib_test_abuf_copy(struct unit_test_state *uts)
 	return 0;
 }
 LIB_TEST(lib_test_abuf_copy, 0);
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

