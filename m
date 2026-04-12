Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C26FE937E3
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 11:24:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F5B4839D5;
	Sun, 12 Apr 2026 13:24:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XHV8P9CC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E967E840D8; Sun, 12 Apr 2026 13:24:03 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53E438341A
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 13:24:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-4138136f02eso2249951fac.2
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 04:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775993039; x=1776597839; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vJU8VpiUrK7UsUpBNsC+ecw18CCcPk4W41lFeryMrJQ=;
 b=XHV8P9CCo40UpNi7YxEjAEBXx9x6dpGCOUpsjHQhz7M2DQs4UGxdRCY00Aqsl37SCg
 I01y0+A717WXhCA1oNqPXIk2jdzq2Mc8YhyX/SDeRk3x7nzmhw0hM3AJy1DWM4caslWh
 giKsyAcRTrUHdDiYkO345bQGyFM6m7lYehLb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775993039; x=1776597839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vJU8VpiUrK7UsUpBNsC+ecw18CCcPk4W41lFeryMrJQ=;
 b=HEe/LBOcXXfpKgfNzvrQe6IuA7Cf5UVG4A/UQFkxU0afqtwMnGHSTFQ7OsPTh57/8W
 Ts4ihaOHvaGyx+aGQvvH1Z/eWPtyYfykobLVBl/CWj54gtggbynFdAUxMLl/J8Guhhls
 pbWixeF280u+/ym0DwE9opV+4X99sXEoVFrlrXlNLtiCAo+1jGKvV2JWb4USgp/+qGDm
 /7YSLrf5Eh1SvOAiveTZBOBZQnEpq4Q9VSwsWdCKxoWQt25/aAR/B8gx05cc526yNj4X
 S7P0xGeF1WV+9jujmklRLVq03JA96Q/RcFY9MUcNxp0mY4aN0a0U17eotIMpDSFrrKCy
 4iBw==
X-Gm-Message-State: AOJu0YzRdqFxrRomJNkbcDlSX4Uy63RQJKeKwWivx0W5uPqp5Q3jUqGH
 Y+bKSmlAqv4eHvVgitM/0ecuyg9Nn8sN/UqvwHFQ1mGI44OIQJw2yGxg//zHGZQySz2dve0vW2I
 CWDfgIA==
X-Gm-Gg: AeBDietrA4SFj85H0M+3ctuhprDdtwF2+Iy3eGJ7T2uMCKIl7O6ht4Qdrhx9uDOaqko
 l8/kNNf8sa5/BtQAPAzpX2c4yUwYpS1xPBYIxrKHTnc8vhAVTA+nY7DdPEqyDqK+JuPUujhLgdH
 gtH1fE4uZPITW7m2TMUucCcuwFVWdow5wehPZiPG/9vibGgqZBF3uKjAqC/HyThH204tLgNlJL0
 SXSICt2K/wUEWOYap1xqxX7b3fdeCRt6fuv9swi/r96ltDvvgWXGE6iglooiQX1h75ADHmVFhw4
 xdS0zOnm7jEVhZBxh2bow5MrbT8rTdNqOZqDSIftGYPudPSSTqvRe159QO3IFZo67/TK052P8m6
 0x5DpOWXXo4PkIDP9tKXJAAQBgIIzJGD6pIaEI8v6DpquVo5wn6xg/87J75mjzhvoDN/U5HwB74
 3cotg/c7bvRsoJPJ9AaQ==
X-Received: by 2002:a05:6870:a787:b0:409:a4d3:a30e with SMTP id
 586e51a60fabf-423e0db9f67mr5366971fac.2.1775993039430; 
 Sun, 12 Apr 2026 04:23:59 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423dd395606sm6622071fac.1.2026.04.12.04.23.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 04:23:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 01/12] test: Add ut_asserteq_regex() for regex pattern
 matching
Date: Sun, 12 Apr 2026 05:19:38 -0600
Message-ID: <20260412111958.943933-2-sjg@chromium.org>
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

Add a new assertion macro ut_asserteq_regex() that checks if a string
matches a regular expression pattern using the SLRE library.

This is useful for tests where exact string-matching is difficult, such
as when output contains line numbers or other variable content.

Use a helper function ut_check_regex() to avoid including slre.h in the
header.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

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

