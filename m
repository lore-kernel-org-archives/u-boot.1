Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3D3E937E3
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 11:25:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF23F841CD;
	Sun, 12 Apr 2026 13:24:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OpjdVFK4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04739839D5; Sun, 12 Apr 2026 13:24:27 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B16BE841CD
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 13:24:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-40ef10ec84cso2403452fac.2
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 04:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775993063; x=1776597863; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TntcstSuO60GougXCwCwNigTK8sl/33dvalNsrtzqUw=;
 b=OpjdVFK4oVPsmZWzCTUzyrWtOGhBqbuReyreQ10OBOO3lVFdc4BMPvJGd4aiF+/5tH
 jIDwo1PXVeoyXs381LsV9JN8EM31+E+tClQ+CTsDao/IpgVmtiVw629m/5qa4F9fCeYO
 y1v+pxS26cArlPOXXE3dTgYiuk2n8Na3RLC6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775993063; x=1776597863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TntcstSuO60GougXCwCwNigTK8sl/33dvalNsrtzqUw=;
 b=C2K/z+9LZYV9L/GYbr3b0E2YV3Klv2sTjojd+xb1Kj95BHCoXg48cnNUF196tkUjza
 mPb5wLNmbJi2L0WEwjykfW6DaMGGIUZ6L4y+cvJn4VOgAGmx7Y7wCq3t6wBFEEGifDwE
 m0RvV66Z7Bm7qYwJFYFwn0f7w7Z6WiEdKCz+4DnuzTwuDXttVW6dP7iJPOp1LAOHpVwl
 Z5cYzxGpU85b7Kz7TVKVizVO5tKDkoN5xlHQqlDddMzLd+YzaLxdlNRTgNoQKfWvNFjQ
 ZoFkTqeiL3pnwP9GVb5RQm+O5Pf4iIBJUAJydZXcGFz+9FITDWJgKcjHXoGPawZhiKOK
 BqPw==
X-Gm-Message-State: AOJu0YyDt8puwFrdXXoK8LieoAaVSGb2HFGwNJcNVk+UFY/M3sWCr8IR
 BTWT9LK6e5DwODeg6sd6AAOQDz6n4wu4wCK6BEqAnHfmguuneU56R1O4CIu3f4aPjk0KncTs9os
 IsP4=
X-Gm-Gg: AeBDievNBF5EQa+diKBHRkAXGK5QC0MJqzcu5Hoz+Zo7q1nGtl8lPEJ3DoGuBjOt41S
 cv97yuk/lGJNBjhG8C1tLKM3bbFlLbq6Mdy6Wtr5ntLBzmrNoiTDC76K8vuGD2Es3f6uxsvOkTN
 FGiBNDg8vgkCxoQsPz3od6Nqh1d3qkys+rrTes1BG4XYkQh9sBBbfRvdzFENME57jbYcBU1Hq9e
 sL30MyL51+YUJSuP1yFChRQrUI7rUHgevxKFo+6Gjsn0yR1CYKze6/vMJFny0WnjpbnJ5PGcmcx
 DNcl3EZCV4fFgE1HQZEM+FEuGCsepo8KkFA+zEV8r1lGlkhpRaVoH7+AJCG62TLxZJVf9b46JOa
 xg81Sz8NUKpGtPN20eB+ypOtBUMPv+YtVob+v4SynWB4c0XuO1r0RFcfPprzeoAbtM3gpWG1+kc
 Iu99IgVy0FPlTCfoQBPNLclZJ7w9e4
X-Received: by 2002:a05:6871:7586:b0:3fa:aa1:5b1c with SMTP id
 586e51a60fabf-423e113c1fcmr4979808fac.30.1775993062818; 
 Sun, 12 Apr 2026 04:24:22 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423dd395606sm6622071fac.1.2026.04.12.04.24.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 04:24:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH v2 08/12] test: Add type-checked argument accessor functions
Date: Sun, 12 Apr 2026 05:19:45 -0600
Message-ID: <20260412111958.943933-9-sjg@chromium.org>
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

Add ut_get_str(), ut_get_int(), and ut_get_bool() functions with
corresponding ut_str(), ut_int(), and ut_bool() macros for accessing
test arguments with type checking.

These functions check that the argument index is within bounds and the
type matches what was requested.

The first failure for a test is reported via ut_failf() which should
make it fairly easy to debug the test.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

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

