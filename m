Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6839F3ED67
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 01:36:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9ECEC8423E;
	Sun, 12 Apr 2026 03:35:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="i57ciLkN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3280784228; Sun, 12 Apr 2026 03:35:44 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5365D84119
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 03:35:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7d9bba96f7dso1758442a34.1
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 18:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775957737; x=1776562537; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zt2N+wp3Hs5kTRDQsJEthMcS45mGIUKbolsmUpj/Nc8=;
 b=i57ciLkNt25NeK9gT1yGdGHzghMN13j9ZxwWuaAkeNnNS3CbWqt/0WHrX0EaxHVxoU
 Ii9CPTU1Rsuud+9BECLFHnm01EUYXLVQ00/pStIZRelOcSl5+0f8lXGT05LOU7C92WWG
 ynMqCH2h6uPqLa8MAgURHMXbQpi7YXiGxOg4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775957737; x=1776562537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zt2N+wp3Hs5kTRDQsJEthMcS45mGIUKbolsmUpj/Nc8=;
 b=KTQDUWwPosMQFiVWVtu0I7zl2Yf7vardS5UU4xR/WjH3+1k5JBGtn07qVJY27MgGjt
 XRODpSlV0eIty96n6n2edMN5UFAhN3oJsrHEWpLiPcwisXdglTgZD7LStO5GviYX8+x6
 eJKIoKw0t45oADvVyCHm0zGv6ucvb9zF2sxOujXqen+A2TE3NXoCX0X25iY/QFDE2Reo
 YHxfJND6KQ9gBkCyDEej/+Fg/TkBuuRwJcPW1u2zMMsEn7Dmt7VBwO+WbIQi59FiHbZl
 Ade0Dj+meo653c5fC4PbxG8/2GZIP0z+0huohElq/QkzdtqQfbhdMs2MaefWIiYRwcdk
 joYg==
X-Gm-Message-State: AOJu0YzQ3/4H4Lx5F+qtoV8+x73z5IC5UEePasMvkDcjw/odraQNPNsy
 qRuDSYwnPozsvvenvb89u9XgeiQse3/8vmwzq14k54zMOEGOfDr2r0l/D5WqysAtigIehTZ1jSO
 qZvfnIg==
X-Gm-Gg: AeBDievxCBUV8MIXmHD1Umi0SuCN85s8xboQaXHiXzcYol4zt/3TY10mRMMlZ0Qb1HS
 rBMlJavLcaGkgrlwZwqKYgecCQnm/zUMuoUefoXjEAaR0bwahnjL6xclftuCn2//bhwexzO9PDn
 2PvJTXqW1ampTuCaLpyuV8jsnVhgGwCEUbLGMLU3iMAqD8HvRMHZVAwUcJrWtq93v7Ido1DSuus
 Fjc0DfmxEAsVz9bAgRmZa9ZjaYAuaJVaLsOGoVksJLhnIcZGFw0UIzB8PlSdnqN8ruq3DiWIyT/
 AWHfWs6T/+u/O/3NrRQzwrJ5SnWCW/UgpBndnjfDlRQ55DCyHNaRsAoUniuFnoxKOyM7le1FWrD
 l6CDqsLpgXH7PoLdmy5WQjkPeoTjzS5/zSmvnfYahcD03llEDpvbxSjDiN0OThaBueh3xaJw0vo
 NdwrJnVl7JUGvu3QM8nA==
X-Received: by 2002:a05:6830:f96:b0:7d7:d54c:5b53 with SMTP id
 46e09a7af769-7dc27e6d91amr4755692a34.29.1775957736964; 
 Sat, 11 Apr 2026 18:35:36 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc2d1aca3asm4242826a34.6.2026.04.11.18.35.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 18:35:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <simon.glass@canonical.com>, Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH 08/12] test: Add type-checked argument accessor functions
Date: Sat, 11 Apr 2026 19:34:36 -0600
Message-ID: <20260412013451.2929001-9-sjg@chromium.org>
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

Add ut_get_str(), ut_get_int(), and ut_get_bool() functions with
corresponding ut_str(), ut_int(), and ut_bool() macros for accessing
test arguments with type checking.

These functions check that the argument index is within bounds and the
type matches what was requested.

The first failure for a test is reported via ut_failf() which should
make it fairly easy to debug the test.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/test/test.h |  2 ++
 include/test/ut.h   | 50 ++++++++++++++++++++++++++++++++++
 test/test-main.c    |  1 +
 test/ut.c           | 66 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 119 insertions(+)

diff --git a/include/test/test.h b/include/test/test.h
index bd47025ce50..f435d6f8c6a 100644
--- a/include/test/test.h
+++ b/include/test/test.h
@@ -95,6 +95,7 @@ struct ut_arg {
  * @priv: Private data for tests to use as needed
  * @args: Parsed argument values for current test
  * @arg_count: Number of parsed arguments
+ * @arg_error: Set if ut_str/int/bool() detects a type mismatch
  */
 struct unit_test_state {
 	struct ut_stats cur;
@@ -123,6 +124,7 @@ struct unit_test_state {
 	char priv[UT_PRIV_SIZE];
 	struct ut_arg args[UT_MAX_ARGS];
 	int arg_count;
+	bool arg_error;
 };
 
 /* Test flags for each test */
diff --git a/include/test/ut.h b/include/test/ut.h
index 1c4ee390fd8..6115711574c 100644
--- a/include/test/ut.h
+++ b/include/test/ut.h
@@ -692,4 +692,54 @@ int ut_run_list(struct unit_test_state *uts, const char *category,
  */
 void ut_report(struct ut_stats *stats, int run_count);
 
+/**
+ * ut_get_str() - Get a string test argument
+ *
+ * Fails the test if the argument type is not UT_ARG_STR.
+ *
+ * @uts: Test state
+ * @n: Argument index
+ * @file: Filename of caller
+ * @line: Line number of caller
+ * @func: Function name of caller
+ * Return: String value, or NULL if type mismatch
+ */
+const char *ut_get_str(struct unit_test_state *uts, int n, const char *file,
+		       int line, const char *func);
+
+/**
+ * ut_get_int() - Get an integer test argument
+ *
+ * Fails the test if the argument type is not UT_ARG_INT.
+ *
+ * @uts: Test state
+ * @n: Argument index
+ * @file: Filename of caller
+ * @line: Line number of caller
+ * @func: Function name of caller
+ * Return: Integer value, or 0 if type mismatch
+ */
+long ut_get_int(struct unit_test_state *uts, int n, const char *file,
+		int line, const char *func);
+
+/**
+ * ut_get_bool() - Get a boolean test argument
+ *
+ * Fails the test if the argument type is not UT_ARG_BOOL.
+ *
+ * @uts: Test state
+ * @n: Argument index
+ * @file: Filename of caller
+ * @line: Line number of caller
+ * @func: Function name of caller
+ * Return: Boolean value, or false if type mismatch
+ */
+bool ut_get_bool(struct unit_test_state *uts, int n, const char *file,
+		 int line, const char *func);
+
+/* Helpers for accessing test arguments with type checking */
+#define ut_str(n)	ut_get_str(uts, n, __FILE__, __LINE__, __func__)
+#define ut_int(n)	ut_get_int(uts, n, __FILE__, __LINE__, __func__)
+#define ut_bool(n)	ut_get_bool(uts, n, __FILE__, __LINE__, __func__)
+
 #endif
diff --git a/test/test-main.c b/test/test-main.c
index 9d8ab794db8..9fc4bca8e20 100644
--- a/test/test-main.c
+++ b/test/test-main.c
@@ -636,6 +636,7 @@ static int ut_run_test(struct unit_test_state *uts, struct unit_test *test,
 	if (ret)
 		return ret;
 
+	uts->arg_error = false;
 	ret = test->func(uts);
 	if (ret == -EAGAIN)
 		skip_test(uts);
diff --git a/test/ut.c b/test/ut.c
index b0cc0f3e8ff..a13e4825eac 100644
--- a/test/ut.c
+++ b/test/ut.c
@@ -284,3 +284,69 @@ void ut_set_skip_delays(struct unit_test_state *uts, bool skip_delays)
 	state_set_skip_delays(skip_delays);
 #endif
 }
+
+const char *ut_get_str(struct unit_test_state *uts, int n, const char *file,
+		       int line, const char *func)
+{
+	if (n < 0 || n >= uts->arg_count) {
+		if (!uts->arg_error)
+			ut_failf(uts, file, line, func, "ut_str() arg check",
+				 "arg %d is invalid (arg_count=%d)", n,
+				 uts->arg_count);
+		uts->arg_error = true;
+		return NULL;
+	}
+	if (uts->args[n].type != UT_ARG_STR) {
+		if (!uts->arg_error)
+			ut_failf(uts, file, line, func, "ut_str() type check",
+				 "arg %d is not a string", n);
+		uts->arg_error = true;
+		return NULL;
+	}
+
+	return uts->args[n].vstr;
+}
+
+long ut_get_int(struct unit_test_state *uts, int n, const char *file,
+		int line, const char *func)
+{
+	if (n < 0 || n >= uts->arg_count) {
+		if (!uts->arg_error)
+			ut_failf(uts, file, line, func, "ut_int() arg check",
+				 "arg %d is invalid (arg_count=%d)", n,
+				 uts->arg_count);
+		uts->arg_error = true;
+		return 0;
+	}
+	if (uts->args[n].type != UT_ARG_INT) {
+		if (!uts->arg_error)
+			ut_failf(uts, file, line, func, "ut_int() type check",
+				 "arg %d is not an int", n);
+		uts->arg_error = true;
+		return 0;
+	}
+
+	return uts->args[n].vint;
+}
+
+bool ut_get_bool(struct unit_test_state *uts, int n, const char *file,
+		 int line, const char *func)
+{
+	if (n < 0 || n >= uts->arg_count) {
+		if (!uts->arg_error)
+			ut_failf(uts, file, line, func, "ut_bool() arg check",
+				 "arg %d is invalid (arg_count=%d)", n,
+				 uts->arg_count);
+		uts->arg_error = true;
+		return false;
+	}
+	if (uts->args[n].type != UT_ARG_BOOL) {
+		if (!uts->arg_error)
+			ut_failf(uts, file, line, func, "ut_bool() type check",
+				 "arg %d is not a bool", n);
+		uts->arg_error = true;
+		return false;
+	}
+
+	return uts->args[n].vbool;
+}
-- 
2.43.0

