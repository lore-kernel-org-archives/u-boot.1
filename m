Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0675BF3ED4A
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 01:35:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C159384119;
	Sun, 12 Apr 2026 03:35:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kf8sRXL4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E119384181; Sun, 12 Apr 2026 03:35:09 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D8A0839D9
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 03:35:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7d7ebe11bffso2887177a34.0
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 18:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775957704; x=1776562504; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyLEl7CFJqYARK3ivXz1vsLYN0g21lVWNoS2PyIY9DA=;
 b=kf8sRXL4E3xUd5pl/7w9nOJepnjL0Qv4BbQOvwFA7Y8R+zppw4wa+ShJHavdMXoaaN
 ZcM1OqL6Rae6DtRpEQMV+zJqaLni9OimOBzeqmBimVmJx/IbYnmXvbDXZha97yMi5Wlf
 O/XKI710X8Xhw5/bbzwnsoX5KNQH7zdiD17PI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775957704; x=1776562504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cyLEl7CFJqYARK3ivXz1vsLYN0g21lVWNoS2PyIY9DA=;
 b=tPwDH2qtBzv4rJ4JWtduRL3ClUDgSvBdhgeGMebwL/0OfxAqVRLvQOWejBUvfCjlTW
 PEKZudGv8iX5Tv/uODsO9md93BY3tLhmXpP7jHA0foHQk5LBsKiOQ/RdrEa0JYj7utln
 nEuFNdBy+FxTYj6Nyt0y/fTL3n9qdccl/BmUpC40xlxEbmA/pgz7H+GxMb/uLf/sMlxy
 udhMct+vGpGHMQMdawh0VPdysqHT8235i4SSNZrbIMB+09cnsXxBMvySqPVQgvEdMlpl
 in1Q7HLXFeHsQQTbk7NaqMhE6XAuuZy3ub558fZDwsg/ocVhXb8OjIo3m57RvyzpjWpC
 gVWQ==
X-Gm-Message-State: AOJu0Yxzs0xF6QFgg7W1G09kY+W4OJRKe1Uospw8nqbQqoh7BBjBVaLa
 WjAGuA4GPVgDNDfETn0WTPeTu3oBP7dpP7p70ecvqb0QNTjPPMSWI3KgNX8L/ydmmuJWt5KxGno
 jXzpGeQ==
X-Gm-Gg: AeBDiev72UkM3mBmALOeDBXCqVTc+VilR0MUgVSyEUB+kPZv2QU4ckiwIX055g2/GYr
 WwfobxcnL3AxI4CvJg4WxD6ykEyEeiqKyJQSRC4OXsTXmRBj68yEj81SKTYBgJP6ylIuvpJicfA
 eA2zKuy7W7tmVEIJvRiI5udj3UhJoe+Mu3Jxdj1gjWIiJE/paoEWvtIg/FceQSeMBZhF+xRYKAl
 upfR/j/lgdPAvj4laJRFeEnpqwFa1QJT2RUWe8bDxQlsY64RvAYid28EDUv7EJiqhH1OD1x1hn7
 FcjQJcGEt2hXu1RGG509H3ZjQ9cb0ung+RzNIwuCc+UE4UVvi4SnaBSeYz4pA3djf6wgVn7wJbR
 BVuR2krU1zuNjsDNC5Xi6A33y6I9xwogtAC3hH3Q7rhJm/+tv25PXn5Un4D0QACJ9q6CjZkwlVF
 ONmwRvI7Y5UjaJL5dXJA==
X-Received: by 2002:a05:6830:710c:b0:7d7:570b:6800 with SMTP id
 46e09a7af769-7dc27f7ce91mr5071256a34.23.1775957704232; 
 Sat, 11 Apr 2026 18:35:04 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc2d1aca3asm4242826a34.6.2026.04.11.18.35.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 18:35:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <simon.glass@canonical.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 01/12] test: Add ut_asserteq_regex() for regex pattern matching
Date: Sat, 11 Apr 2026 19:34:29 -0600
Message-ID: <20260412013451.2929001-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260412013451.2929001-1-sjg@chromium.org>
References: <20260412013451.2929001-1-sjg@chromium.org>
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

From: Simon Glass <simon.glass@canonical.com>

Add a new assertion macro ut_asserteq_regex() that checks if a string
matches a regular expression pattern using the SLRE library.

This is useful for tests where exact string-matching is difficult, such
as when output contains line numbers or other variable content.

Use a helper function ut_check_regex() to avoid including slre.h in the
header.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/test/ut.h | 36 +++++++++++++++++++++++++++++-------
 test/ut.c         | 30 ++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 7 deletions(-)

diff --git a/include/test/ut.h b/include/test/ut.h
index 6510c35997f..cda15f3a7a9 100644
--- a/include/test/ut.h
+++ b/include/test/ut.h
@@ -13,6 +13,9 @@
 #include <linux/err.h>
 #include <test/test.h>
 
+/* Size of error buffer for ut_check_regex() */
+#define UT_REGEX_ERR_SIZE	256
+
 struct unit_test_state;
 
 /**
@@ -41,6 +44,16 @@ void ut_failf(struct unit_test_state *uts, const char *fname, int line,
 	      const char *func, const char *cond, const char *fmt, ...)
 			__attribute__ ((format (__printf__, 6, 7)));
 
+/**
+ * ut_check_regex() - Check if a string matches a regex pattern
+ *
+ * @pattern: Regular expression pattern
+ * @str: String to match against
+ * @err: Buffer to hold error message on failure (UT_REGEX_ERR_SIZE bytes)
+ * Return: 0 if match, -EINVAL if pattern is invalid, -ENOENT if no match
+ */
+int ut_check_regex(const char *pattern, const char *str, char *err);
+
 /**
  * ut_check_console_line() - Check the next console line against expectations
  *
@@ -264,13 +277,22 @@ int ut_check_console_dump(struct unit_test_state *uts, int total_bytes);
 	__ret;								\
 })
 
-/**
- * ut_asserteq_mem() - Assert that two memory areas are equal
- *
- * @expr1:	expected value
- * @expr2:	actual value
- * @len:	length of the memory areas
- */
+/* Assert that a string matches a regex pattern */
+#define ut_asserteq_regex(pattern, str) ({				\
+	const char *_pattern = (pattern), *_str = (str);		\
+	char _err[UT_REGEX_ERR_SIZE];					\
+	int __ret = 0;							\
+									\
+	__ret = ut_check_regex(_pattern, _str, _err);			\
+	if (__ret) {							\
+		ut_failf(uts, __FILE__, __LINE__, __func__,		\
+			 #pattern " matches " #str, "%s", _err);	\
+		return CMD_RET_FAILURE;					\
+	}								\
+	__ret;								\
+})
+
+/* Assert that two memory areas are equal */
 #define ut_asserteq_mem(expr1, expr2, len) ({				\
 	const u8 *_val1 = (u8 *)(expr1), *_val2 = (u8 *)(expr2);	\
 	const uint __len = len;						\
diff --git a/test/ut.c b/test/ut.c
index a16fdfb3a93..b4f2a8bf40f 100644
--- a/test/ut.c
+++ b/test/ut.c
@@ -6,7 +6,10 @@
  */
 
 #include <console.h>
+#include <errno.h>
 #include <malloc.h>
+#include <slre.h>
+#include <vsprintf.h>
 #ifdef CONFIG_SANDBOX
 #include <asm/state.h>
 #endif
@@ -38,6 +41,33 @@ void ut_failf(struct unit_test_state *uts, const char *fname, int line,
 	uts->cur.fail_count++;
 }
 
+int ut_check_regex(const char *pattern, const char *str, char *err)
+{
+	struct slre slre;
+
+	if (!pattern || !str) {
+		snprintf(err, UT_REGEX_ERR_SIZE,
+			 "NULL value: pattern=%s, str=%s",
+			 pattern ? pattern : "(null)",
+			 str ? str : "(null)");
+		return -EINVAL;
+	}
+
+	if (!slre_compile(&slre, pattern)) {
+		snprintf(err, UT_REGEX_ERR_SIZE,
+			 "Invalid regex '%s': %s", pattern, slre.err_str);
+		return -EINVAL;
+	}
+
+	if (!slre_match(&slre, str, strlen(str), NULL)) {
+		snprintf(err, UT_REGEX_ERR_SIZE,
+			 "No match: pattern '%s', str '%s'", pattern, str);
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
 ulong ut_check_free(void)
 {
 	struct mallinfo info = mallinfo();
-- 
2.43.0

