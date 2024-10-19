Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D57D3C916
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 15:25:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75BC3892FB;
	Sat, 19 Oct 2024 17:22:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Epr7etzX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92B40892F5; Sat, 19 Oct 2024 17:22:51 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1234892E8
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 17:22:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3a3bd42955bso12592015ab.1
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 08:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729351367; x=1729956167; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ivUejSRHIHLCpB4/N0Odve5k4oZBvOZPQ75Cr6S4xh0=;
 b=Epr7etzX4utFdObjDiTXXvWVjKsh5+X1WJJ/9srwpAyNdecUd/aDhZUOSNGDGHeUOe
 xWXXrsBMGq/5p85lzWvQ08ylrWkuoYUug1no4QtgW7Z5y9xwSngSiq7d2FRmMPM7toxq
 Te8TZkHVvhhXEgqFdmCNdOFBibhqnYOEVp5WE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729351367; x=1729956167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ivUejSRHIHLCpB4/N0Odve5k4oZBvOZPQ75Cr6S4xh0=;
 b=RcKRjL2Nv7MaS4rvGVSPefbjOOyjEpXY6dkZ1yhwLPNanQOi5qfS7vPR9V5YtDmQuM
 U4Yq/M5Ijf/pRRgkuSJ3rUJCgn/gPfH2rWG5/u9tAD4uJ3OY+z+GGMhI4zv73zoV/Ygp
 oWmNk/ICKLBVXvUZfoQxUhYmpQRHPa73DeqJwIEd5cKwMh8Hhb0fTOAHgFJBe49Ovo5J
 6e1qFWbGChifVIODXj69HuO2FGeTwj/VARuMb6N4j41aZQC06e7PhopiZQtBITyDMGLL
 uxZOJGJvbws8B5YGjOxHvdk5kvJq7I2MJUmovW5JqLho+FBoOORTgGmWWo5QePlleVxB
 ERiw==
X-Gm-Message-State: AOJu0YwDIyRnxDgjwTvv1CcaHyrgedqnfNt4JTKSPL6w4N3wpkPn0G7t
 +6CgxGMeC+HMnWWRTBhPibw96566YaubqxJwsLSxbMKDAwBX4fQ6BELZeztX0OG6aasEbHZKEkQ
 =
X-Google-Smtp-Source: AGHT+IHAtElpYdZnqj2DxNILWprBaAwEctShq1GlpX7ma2KgvYo+AwM8zOy4evHczvsN5bsTMcfJRw==
X-Received: by 2002:a05:6e02:1a2a:b0:3a2:74f8:675d with SMTP id
 e9e14a558f8ab-3a3f40a8682mr55487645ab.20.1729351367480; 
 Sat, 19 Oct 2024 08:22:47 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b83faasm1006111173.52.2024.10.19.08.22.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2024 08:22:47 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v2 16/31] test: Expand implementation of ut_list_has_dm_tests()
Date: Sat, 19 Oct 2024 09:21:56 -0600
Message-Id: <20241019152211.1014896-17-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241019152211.1014896-1-sjg@chromium.org>
References: <20241019152211.1014896-1-sjg@chromium.org>
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

(no changes since v1)

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

