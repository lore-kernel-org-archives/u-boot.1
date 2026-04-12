Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE783E937E3
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 11:24:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 621418419E;
	Sun, 12 Apr 2026 13:24:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XUl4AKGg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EE91841A2; Sun, 12 Apr 2026 13:24:07 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EDB484181
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 13:24:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7d556c1a79eso4944103a34.3
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 04:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775993043; x=1776597843; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vl3C/Ro/3cVsjKPA140+6mn8hoCVXeFEF/h8GYnjB/U=;
 b=XUl4AKGgej/J9csQgTEyW9kAP+/XhzfLpV2WXrDPLhOoHI80BpiyiFBNJYcN61Qeft
 kH5KmG9fCvlR7mgdLP1LepWiaeVDjdNJO4lM7uwtFwSMkPGQxCXjNHbi48kBwv6ogYKP
 tTLHk5thkMpwDaa7p3QOrZZs2LaTx7WCI0YGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775993043; x=1776597843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vl3C/Ro/3cVsjKPA140+6mn8hoCVXeFEF/h8GYnjB/U=;
 b=VBbXDCd2veKQQyN0qUyzK0hJHy2Oioit3smHPeTS8FPA9r7VEjB0K6epR19uJiCK1K
 A+xS9iOW7tXK+MV3UWf8S0Ta6Wuqz6BkXYM7GNmRfLlrXq3mhgiUeKyoP6UsaUQs+J+X
 fHhfxtCvEznkBnCzOLa2X8lEIf/1LyzIz0sTzXN5Nlm6g3BqcF4jQPlHCBYoWM3a+nxl
 9UosH3jTe8EBLJHq/pZiih5HWKc/WBiY+IWkobaEZ/3mDfKicI3wvWyDcXuYcgyaLtH2
 t+M5vrY1aUb+2dX0pQiCNTeRu0klDFYgjqbeHqfWaFsqzwdLB0DyXsEHDFuclk33SDPu
 hppA==
X-Gm-Message-State: AOJu0YxsPwn7Fuph/U0yrkpGzWA5NIhYVcrbGEoisNs7LJbU9KsER27b
 7rUq/dXrbEocZY80z278ufvotWZC6AHXARGHAkiYBGiuUbDRjjjzmjBIYBZL9L6mU/r2vuP5v1d
 Kqjrg2w==
X-Gm-Gg: AeBDieuhJhmja/Qs82VKTp12vmUdJJmOOqTy9ipTGc2SruESzRl0kRllfj4XY67XuEQ
 /fGCGDKVZKek2Vx+TKJBseBgHVeIDpClZkA6lg9db7grJ5gBOGDRoSR86msqeHCSFx8b9Ep/kRj
 6bzC/d7jsjyE+HgR8yvUZYha2FfoEMm1/q+drptiJgCIvC1oZKr5tbzBCLhtMgdp3bcEekIlM1w
 10bW10tbl6RVysmIMAGOASTCewlVXqbir3UZ9KrX5C6t90lNQqWb9I6rlWoThos2iBSQnpMMiS6
 LvQHdUJH8s7dSeH+su5Phd2fwP3ePcZYGMy72a6ZKrmlz1IaJMNKEL/3T5NOvKQHRWc5D4JNxs7
 e0xT7oRYrJ2kG9/lMqKRzOnonunj76rlj4JglNkBCJz3iJO381hNCtEtyAkj3NuOJxnQomjfqSx
 0Vfd0Y9tNtu7ePvAlYeg==
X-Received: by 2002:a05:6820:310a:b0:685:5300:f1c2 with SMTP id
 006d021491bc7-68be671f863mr4820037eaf.28.1775993043547; 
 Sun, 12 Apr 2026 04:24:03 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423dd395606sm6622071fac.1.2026.04.12.04.24.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 04:24:02 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 02/12] test: Add a helper to check the next line against a
 regex
Date: Sun, 12 Apr 2026 05:19:39 -0600
Message-ID: <20260412111958.943933-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260412111958.943933-1-sjg@chromium.org>
References: <20260412111958.943933-1-sjg@chromium.org>
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

Add a new ut_assert_nextline_regex() macro and
ut_check_console_line_regex() helper to check console output against a
regex pattern. This is useful when the exact output varies (e.g., file
paths or line numbers in error messages).

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/test/ut.h | 33 +++++++++++++++++++++++++++++----
 test/ut.c         | 21 +++++++++++++++++++++
 2 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/include/test/ut.h b/include/test/ut.h
index cda15f3a7a9..8f0e69a7734 100644
--- a/include/test/ut.h
+++ b/include/test/ut.h
@@ -87,6 +87,20 @@ int ut_check_console_line(struct unit_test_state *uts, const char *fmt, ...)
 int ut_check_console_linen(struct unit_test_state *uts, const char *fmt, ...)
 			__attribute__ ((format (__printf__, 2, 3)));
 
+/**
+ * ut_check_console_line_regex() - Check the next console line against a regex
+ *
+ * This checks the next line of console output against a regex pattern.
+ *
+ * After the function returns, uts->expect_str holds the regex pattern and
+ * uts->actual_str holds the actual string read from the console.
+ *
+ * @uts: Test state
+ * @regex: Regular expression pattern to match against
+ * Return: 0 if OK, other value on error
+ */
+int ut_check_console_line_regex(struct unit_test_state *uts, const char *regex);
+
 /**
  * ut_check_skipline() - Check that the next console line exists and skip it
  *
@@ -451,10 +465,21 @@ int ut_check_console_dump(struct unit_test_state *uts, int total_bytes);
 	__ret;								\
 })
 
-/**
- * ut_assert_skipline() - Assert that there is a 'next' console output line,
- *			  and skip it
- */
+/* Assert that the next console output line matches a regex pattern */
+#define ut_assert_nextline_regex(pattern) ({				\
+	int __ret = 0;							\
+									\
+	if (ut_check_console_line_regex(uts, pattern)) {		\
+		ut_failf(uts, __FILE__, __LINE__, __func__,		\
+			 "console regex",				\
+			 "\nExpected regex '%s',\n         got '%s'",	\
+			 uts->expect_str, uts->actual_str);		\
+		return CMD_RET_FAILURE;					\
+	}								\
+	__ret;								\
+})
+
+/* Assert that there is a 'next' console output line, and skip it */
 #define ut_assert_skipline() ({						\
 	int __ret = 0;							\
 									\
diff --git a/test/ut.c b/test/ut.c
index b4f2a8bf40f..b0cc0f3e8ff 100644
--- a/test/ut.c
+++ b/test/ut.c
@@ -139,6 +139,27 @@ int ut_check_console_linen(struct unit_test_state *uts, const char *fmt, ...)
 		       strlen(uts->expect_str));
 }
 
+int ut_check_console_line_regex(struct unit_test_state *uts, const char *regex)
+{
+	char err[UT_REGEX_ERR_SIZE];
+	int len;
+	int ret;
+
+	len = strlcpy(uts->expect_str, regex, sizeof(uts->expect_str));
+	if (len >= sizeof(uts->expect_str)) {
+		ut_fail(uts, __FILE__, __LINE__, __func__,
+			"unit_test_state->expect_str too small");
+		return -EOVERFLOW;
+	}
+	ret = readline_check(uts);
+	if (ret == -ENOENT)
+		return 1;
+
+	ret = ut_check_regex(regex, uts->actual_str, err);
+
+	return ret;
+}
+
 int ut_check_skipline(struct unit_test_state *uts)
 {
 	int ret;
-- 
2.43.0

