Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF287F3ED4A
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 01:35:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D98084201;
	Sun, 12 Apr 2026 03:35:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MqqgegJH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E15EB841CD; Sun, 12 Apr 2026 03:35:13 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D68DE839D9
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 03:35:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7dbd08144deso2981304a34.0
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 18:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775957707; x=1776562507; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TaVAJCUw+eVY0YvFCdEVevvvhEsssQ8uhhWPDp87rRA=;
 b=MqqgegJHHqQ9wwqlkQo64Bz9arUUKb+m+mKnVlYqWJAvhfM+E9acdksi8DE+yBn+6g
 6sdwzNTmrp7uzh9Zsa243PZS5iQTD2LqLrLQFz8PH56bfEN9c7TlLURuN3qROL3niWtF
 MR2aW8Wf41KWvu7BK2c1RK4YEyx6KIrUy2Chg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775957707; x=1776562507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TaVAJCUw+eVY0YvFCdEVevvvhEsssQ8uhhWPDp87rRA=;
 b=iGNmHr84aVSN7o0Vij6jfmCjlksA1owk9JlYPs939MmxIN+ZhXpaORneWCso5Nr1up
 5ELE3L6HUGtJNG0MUbKfeZ5XDvDX59zzQ2US5ymkyrK8wiylnCptArASceR3mR7g6/3A
 uVvQnEPTgkwtfX/NDiaGJ12v6cMvZU1BfkJm9PFFfbzJ6GlbVyjjFjH+F5aFIavUhR2W
 BkuVGeCleG0J9DOZmQB/8YQJ16InDmPmOKIiORRMXmfifamNhgxAXzvTwh+Ut9/VYomW
 Lu3HtQtpiAVCCSbDr9qADm3Un+3uBcsuC/Do2IccQVQOLnyWqUWronf2IapHupC6IdFx
 ewDg==
X-Gm-Message-State: AOJu0YzqBe5g8UZVEKzOatFuLGMvnoE9MkYfF/yr5tSheMvApdXZ3HYT
 AbPNckaacpXpd4l1y8YMT3m0c6l53LQe9f/crFfNUo+yWOP8Pi8C1FxKAmi8Y5i/eEl9BE/1bt1
 R9ReyTg==
X-Gm-Gg: AeBDieu4EcpYb0bkYlKj9dbx9t2mzd4SZsNWK4QM5GIivD8081ASl9TBab0KatQ6hnf
 QQ51AgkpSBt5ojBtdK5IARt4jzHbLNkVZlkcCpp1XP5QlJYK68IZrZpIMNjeqJstKEtDHGoFtJL
 dh/7aKvu0UYW43lW7kxHXpxkdjGlrfUvP/oTj9Qy0LAWqL1weBpz/WmMIo4YOOBIIbqLDVYCokB
 cGoVfCVsXGpQeFwIT2oI4Q3GT2GXD8S03dirYJjF/dFARsCk8FZFKIy8BXzPA9bLMwuwOk7/qx3
 LFCOa494//eDZV2xdWKJeTNo4D8dyWdiIAgbJSPLydleBI1yJsib02Vk8WGcXCB72i3qroUwD1c
 YdfQHtb3aYnSRxTflt4ci+haavj42hYhRNTmvgIj0q7CtflT7DMz9Nvzt1AHJYzbmjfrkItKM8L
 QCf/bRA1iD5c82AJ1T5g==
X-Received: by 2002:a05:6830:6f4a:b0:7d7:dcb1:1e6c with SMTP id
 46e09a7af769-7dc27c99044mr5439057a34.7.1775957707152; 
 Sat, 11 Apr 2026 18:35:07 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc2d1aca3asm4242826a34.6.2026.04.11.18.35.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 18:35:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <simon.glass@canonical.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 02/12] test: Add a helper to check the next line against a
 regex
Date: Sat, 11 Apr 2026 19:34:30 -0600
Message-ID: <20260412013451.2929001-3-sjg@chromium.org>
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

Add a new ut_assert_nextline_regex() macro and
ut_check_console_line_regex() helper to check console output against a
regex pattern. This is useful when the exact output varies (e.g., file
paths or line numbers in error messages).

Signed-off-by: Simon Glass <simon.glass@canonical.com>
Signed-off-by: Simon Glass <sjg@chromium.org>
---

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

