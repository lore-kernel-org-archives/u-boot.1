Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 619AAE784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:31:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BBE787165;
	Mon,  2 Oct 2023 03:17:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="j/Iij5Bf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 984AC87118; Mon,  2 Oct 2023 03:17:00 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A42B88721A
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:16:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-79fc3d32a2fso415777639f.1
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209366; x=1696814166; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q5gB0bGiHFVxRqphlEfn3vbaOPFW4YgSKWgq+oB0pL8=;
 b=j/Iij5BfSX/spir1SXHY71PhFqXQxHU3JWMg7t+2GEAMYQAypl9iAfxQS3Y3u4lW91
 Zam5gJcL8fzNWT3yeATywgfYWz+5l6t/BHbfk0sj8Hr7nSIGDez7/EaX1vJNuUQvJOlz
 o66O7RxroiI8socUsTDBMwZCXD9yghaWvr/eU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209366; x=1696814166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q5gB0bGiHFVxRqphlEfn3vbaOPFW4YgSKWgq+oB0pL8=;
 b=jP5beZE7i/auHgqhlM2f+Hwl4a0FJqXrL2oSKRBVkK2En/f79jLdC2UibDpM6U7LEZ
 WaxINEm4Dh9ybRJJsuqkqL4pjNpK/uFkTBH9udBP7+xrO/6fX3biOhDzx6dOj065eN2a
 vYBb7s94B1W0eCsNeM5Ma670GLNB7FaAcnpB4hd3iXJ5dq2VKOuk90mnZBhDApYysqzP
 V+mAqL2fmkFwrGJkVH+xC8YM9Ze2qsya8G5jlG+9mDjhwUcAtAij2X2+igPH7y4XbOI+
 F05CCCVVg/PgWhFEHGwHsrVcDHKEt27euqep5aW0RqACTC5wuBGBX3Gu7jukzmN34F6m
 iuKw==
X-Gm-Message-State: AOJu0Yzr0KbzTK0Ot6sbdM+1mDdqM6lIvPExePlaIzwxpGa2iDG6eUfF
 caYjIzObdeoUcAnXbQk5lLQAttqTL5kA220mIfI=
X-Google-Smtp-Source: AGHT+IF69MSEJ5P/b8Go46UW+fikbEQS2eYS76KE/tdWvvUEbwbTmPsICM035je8x8hcuIQfDiV+mQ==
X-Received: by 2002:a05:6602:1b10:b0:792:82f8:7402 with SMTP id
 dk16-20020a0566021b1000b0079282f87402mr11825164iob.16.1696209366358; 
 Sun, 01 Oct 2023 18:16:06 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 l26-20020a02a89a000000b0041d859c5721sm6819619jam.64.2023.10.01.18.16.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:16:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 03/34] test: Add helper to skip to partial console line
Date: Sun,  1 Oct 2023 19:15:13 -0600
Message-ID: <20231002011553.463514-4-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011553.463514-1-sjg@chromium.org>
References: <20231002011553.463514-1-sjg@chromium.org>
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

Sometimes we need to skip to a line but it includes addresses or other
information which can vary depending on the runtime conditions.

Add a new ut_assert_skip_to_linen() which is similar to the existing
ut_assert_skip_to_line() function but only checks that the console line
matches up to the length of the provided string.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/test/ut.h | 30 ++++++++++++++++++++++++++++++
 test/ut.c         | 27 +++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/include/test/ut.h b/include/test/ut.h
index ea6ee95d7344..d3172af8083f 100644
--- a/include/test/ut.h
+++ b/include/test/ut.h
@@ -97,6 +97,23 @@ int ut_check_skipline(struct unit_test_state *uts);
  */
 int ut_check_skip_to_line(struct unit_test_state *uts, const char *fmt, ...);
 
+/**
+ * ut_check_skip_to_linen() - skip output until a partial line is found
+ *
+ * This creates a string and then checks it against the following lines of
+ * console output obtained with console_record_readline() until it is found.
+ * Only the characters up to the length of the string are checked, so the line
+ * may extend further
+ *
+ * After the function returns, uts->expect_str holds the expected string and
+ * uts->actual_str holds the actual string read from the console.
+ *
+ * @uts: Test state
+ * @fmt: printf() format string to look for, followed by args
+ * Return: 0 if OK, -ENOENT if not found, other value on error
+ */
+int ut_check_skip_to_linen(struct unit_test_state *uts, const char *fmt, ...);
+
 /**
  * ut_check_console_end() - Check there is no more console output
  *
@@ -359,6 +376,19 @@ int ut_check_console_dump(struct unit_test_state *uts, int total_bytes);
 	__ret;								\
 })
 
+/* Assert that a following console output line matches */
+#define ut_assert_skip_to_linen(fmt, args...) ({				\
+	int __ret = 0;							\
+									\
+	if (ut_check_skip_to_linen(uts, fmt, ##args)) {			\
+		ut_failf(uts, __FILE__, __LINE__, __func__,		\
+			 "console", "\nExpected '%s',\n     got to '%s'", \
+			 uts->expect_str, uts->actual_str);		\
+		return CMD_RET_FAILURE;					\
+	}								\
+	__ret;								\
+})
+
 /* Assert that there is no more console output */
 #define ut_assert_console_end() ({					\
 	int __ret = 0;							\
diff --git a/test/ut.c b/test/ut.c
index 28da417686e4..628e9dc98050 100644
--- a/test/ut.c
+++ b/test/ut.c
@@ -121,6 +121,33 @@ int ut_check_skipline(struct unit_test_state *uts)
 	return 0;
 }
 
+int ut_check_skip_to_linen(struct unit_test_state *uts, const char *fmt, ...)
+{
+	va_list args;
+	int len;
+	int ret;
+
+	va_start(args, fmt);
+	len = vsnprintf(uts->expect_str, sizeof(uts->expect_str), fmt, args);
+	va_end(args);
+	if (len >= sizeof(uts->expect_str)) {
+		ut_fail(uts, __FILE__, __LINE__, __func__,
+			"unit_test_state->expect_str too small");
+		return -EOVERFLOW;
+	}
+	while (1) {
+		if (!console_record_avail())
+			return -ENOENT;
+		ret = readline_check(uts);
+		if (ret < 0)
+			return ret;
+
+		if (!strncmp(uts->expect_str, uts->actual_str,
+			     strlen(uts->expect_str)))
+			return 0;
+	}
+}
+
 int ut_check_skip_to_line(struct unit_test_state *uts, const char *fmt, ...)
 {
 	va_list args;
-- 
2.42.0.582.g8ccd20d70d-goog

