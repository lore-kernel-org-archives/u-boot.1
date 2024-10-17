Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF01D3C533
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:27:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08C5B8925B;
	Fri, 18 Oct 2024 01:25:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GtRosiQ7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 845348921E; Fri, 18 Oct 2024 01:25:03 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D587389249
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:25:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-37636c3872bso5763895ab.3
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729207499; x=1729812299; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MwCy0VVaPhcaXPxvTeJjgXUk/TJsKDWsbrtgewZBhU0=;
 b=GtRosiQ7AWL8wC/lXx0XzWrVfj6/JeDjvAnGLyZi/IuMK+7uW5+wdl6UWy0R1ZVgG8
 ADUndFm1x+k9lH5meJSsjLLrPHyAFyTtyQelS6LQwjP2zB1ZesyGKfsOok64tMhFpuLT
 4dOQ9H+CVa2EFihAEronxrVBbpmSa+vZn2OLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729207499; x=1729812299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MwCy0VVaPhcaXPxvTeJjgXUk/TJsKDWsbrtgewZBhU0=;
 b=iBjUqLadV8U2mtOViC7OPiHXlaebfcy5N4cgYw2n4BBzhpsJ/4kadKcO35luwXg1fo
 DxyKkFMLt/2mYSr4si+y0HvwPfKtJNRZlFcyeFdLoNNYPr5LZoqYkUTFF9jaTLZC8OhI
 FL+dhLPKNTNv+pcehY1rhtQ1eBSh4pXUtGPI5RSOFqbnZCmQjRA9RtbTtD5LwCTOH6kD
 0tH+9DN9mV7cVaoGI4kQ9L4u6UfgImbxbQ5olD/eo1SUVg1qcnOZo0oaaw+7XMA7+cat
 ux3CWC6PeV6CB/SY9cydavlk6BRs5y2rswOApgIY7dhSA1Ouw76SToE98PpUe0uqqchc
 IDuQ==
X-Gm-Message-State: AOJu0YwYwMKSQT3+iR8akmH5QrMRYf60Q1+CqHhxfJsI/7mJSd0siyhi
 4aPVOXk1il1+5lWT+88Pi3J7+xcChM1QDgwM1YU0TB7Zblv6CF5hjoCDvLsJ7oLCYUgjq5S+3oA
 =
X-Google-Smtp-Source: AGHT+IG8f4aE9u/6QKqfcQbObQEYBHjzgqfX0IiuiEc9L4wKF96grYIE+c1ZSaM5cyFiZn4tdjHPag==
X-Received: by 2002:a05:6e02:1c85:b0:39d:637f:97bc with SMTP id
 e9e14a558f8ab-3a3f3fcb59dmr3840165ab.0.1729207499530; 
 Thu, 17 Oct 2024 16:24:59 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10ba3454sm117117173.79.2024.10.17.16.24.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 16:24:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 19/34] test: Expand implementation of ut_list_has_dm_tests()
Date: Thu, 17 Oct 2024 17:23:58 -0600
Message-Id: <20241017232413.724808-20-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017232413.724808-1-sjg@chromium.org>
References: <20241017232413.724808-1-sjg@chromium.org>
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

This function assumes that all tests in a suite are being run. This
means that it can sometimes call dm_test_restore() when it should not.

The impact of this is that it is not possible, for example, to run
'ut bootstd bootflow_cros' and then check the state of bootstd
afterwards, since all devices are removed and recreated.

Update the function to take account of any selected test, to avoid this
problem.

Add a comment for test_insert while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/test-main.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/test/test-main.c b/test/test-main.c
index da5b07ce00b..ca6a073a8cb 100644
--- a/test/test-main.c
+++ b/test/test-main.c
@@ -240,15 +240,22 @@ static bool test_matches(const char *prefix, const char *test_name,
  * ut_list_has_dm_tests() - Check if a list of tests has driver model ones
  *
  * @tests: List of tests to run
- * @count: Number of tests to ru
+ * @count: Number of tests to run
+ * @prefix: String prefix for the tests. Any tests that have this prefix will be
+ *	printed without the prefix, so that it is easier to see the unique part
+ *	of the test name. If NULL, no prefix processing is done
+ * @select_name: Name of a single test being run (from the list provided). If
+ *	NULL all tests are being run
  * Return: true if any of the tests have the UTF_DM flag
  */
-static bool ut_list_has_dm_tests(struct unit_test *tests, int count)
+static bool ut_list_has_dm_tests(struct unit_test *tests, int count,
+				 const char *prefix, const char *select_name)
 {
 	struct unit_test *test;
 
 	for (test = tests; test < tests + count; test++) {
-		if (test->flags & UTF_DM)
+		if (test_matches(prefix, test->name, select_name) &&
+		    (test->flags & UTF_DM))
 			return true;
 	}
 
@@ -550,6 +557,9 @@ static int ut_run_test_live_flat(struct unit_test_state *uts,
  * @count: Number of tests to run
  * @select_name: Name of a single test to run (from the list provided). If NULL
  *	then all tests are run
+ * @test_insert: String describing a test to run after n other tests run, in the
+ * format n:name where n is the number of tests to run before this one and
+ * name is the name of the test to run
  * Return: 0 if all tests passed, -ENOENT if test @select_name was not found,
  *	-EBADF if any failed
  */
@@ -646,7 +656,7 @@ int ut_run_list(const char *category, const char *prefix,
 	int ret;
 
 	if (!CONFIG_IS_ENABLED(OF_PLATDATA) &&
-	    ut_list_has_dm_tests(tests, count)) {
+	    ut_list_has_dm_tests(tests, count, prefix, select_name)) {
 		has_dm_tests = true;
 		/*
 		 * If we have no device tree, or it only has a root node, then
-- 
2.34.1

