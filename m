Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B64E8C02182
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:27:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 744C780763;
	Mon, 20 Jan 2025 22:26:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jTDzKib6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12B3F80762; Mon, 20 Jan 2025 22:26:38 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD51C8032B
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:26:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3ce85e37887so50058165ab.2
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737408393; x=1738013193; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gQElxEZFGb2n3S3CeN/i0QqFxVywTdqzdX3Pryb81iQ=;
 b=jTDzKib6VxiTFv1vYIDdeF3m5A8o8lkvdSUd8XX3XNt51wS5+YMLu2JKzEn74jiAAP
 C7xPo28p8IlO7+P7uhYa55aQEEfPj5NbGqelSj++cyZXLUwu9VKqiWCm71fgVY/0ocGY
 q6TsqKBnc8aDiIDC0/lTrpMZIxw3qy+ZPhCsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737408393; x=1738013193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gQElxEZFGb2n3S3CeN/i0QqFxVywTdqzdX3Pryb81iQ=;
 b=nx0hIE5eSPg3SVYGT2kbdASUD4WPjVYtbuRTn4OF6pG6HN1eNNbeM7lGMQ+gY6dFFd
 zR4QHZZCUqzBQDstlmnBO40D3gi/JwCEUF7cZVxdVpoyhUGP8lw/lAtCE0B+Sw/SfQfk
 mxkzqsHFAA/D4Np13JqOYCQZEONZBHmw04T/jV9PcrZirDbWhSwptIHLWSjeScNe0K6q
 CuYVyiUwSXLrUcdhKhGjyW56kBKlxM4SRinUuSj6ZD8eUxEpRCsdXl12HUpGlT2e3oNX
 j30FCIXzvebmGzRHY/Orfr7TTggz/NNWlOSRQnOeaBhQeiGhK0pNDN3oSFQgmNJ1uHw6
 Xeqg==
X-Gm-Message-State: AOJu0YzYDf8xtarlnfLdQwMqxwAIwoAK8JIYIoKacDcYUtscjMx4ABh+
 AVRvf+k3yxaqLUV4Kd21HxgVm/te6JJGGfigW0ow7uLR+7neVCFF/Huo8xbKcv5YW2XufvTaM8o
 =
X-Gm-Gg: ASbGncvIvYkYd5ld+lKxr7cJdM7w0N51lCTjErwDty08WRl4R+fu0DWknI+TbaD80l7
 RR2GNGHstOkOwQXOxvqXkGfQtDFmygR9WF2yHJxi6QoHTUb/mPxBWID9oWhsV6V640zwAB2H0Mw
 HOOZLLoCJqCSrkj6ddENlCoQ73Oy6ef7JoID2hAJP4k+Meh4ipqRvPe/lTkWRVosl4bVSr5ztHT
 gwDg0ivhJ73c3R2zdQ59VLbosSxAhVz5+DZWFTBk6ZUeLJqAmor0XMb/LL4hdQkJQoqEViCkzXX
 j5n0OjXahkiFSPIIigjA54Pal6dHhV0=
X-Google-Smtp-Source: AGHT+IEVN2HGxWcUwsw/pltAWGasDMASNMM5BjoHN08a3lGa2SYN/n6iLxrkJFI//xh2B3Ad6LcULQ==
X-Received: by 2002:a05:6e02:1989:b0:3ce:8aa2:3fb1 with SMTP id
 e9e14a558f8ab-3cf744bf12dmr121720865ab.22.1737408393425; 
 Mon, 20 Jan 2025 13:26:33 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea75440a24sm2847693173.33.2025.01.20.13.26.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:26:32 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 04/44] test: Pass the test-state into ut_run_list()
Date: Mon, 20 Jan 2025 14:25:26 -0700
Message-ID: <20250120212613.516664-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250120212613.516664-1-sjg@chromium.org>
References: <20250120212613.516664-1-sjg@chromium.org>
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

Pass this into the function so that callers can inspect the state
afterwards.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/sandbox/cpu/spl.c |  5 ++++-
 include/test/ut.h      | 29 ++++++++++++++++++++++++++---
 test/cmd_ut.c          |  5 ++++-
 test/test-main.c       | 35 +++++++++++++++++------------------
 4 files changed, 51 insertions(+), 23 deletions(-)

diff --git a/arch/sandbox/cpu/spl.c b/arch/sandbox/cpu/spl.c
index 7056cfd0180..0ad23e4ba95 100644
--- a/arch/sandbox/cpu/spl.c
+++ b/arch/sandbox/cpu/spl.c
@@ -147,10 +147,13 @@ void spl_board_init(void)
 	if (state->run_unittests) {
 		struct unit_test *tests = UNIT_TEST_ALL_START();
 		const int count = UNIT_TEST_ALL_COUNT();
+		struct unit_test_state uts;
 		int ret;
 
-		ret = ut_run_list("spl", NULL, tests, count,
+		ut_init_state(&uts);
+		ret = ut_run_list(&uts, "spl", NULL, tests, count,
 				  state->select_unittests, 1, false, NULL);
+		ut_uninit_state(&uts);
 		/* continue execution into U-Boot */
 	}
 }
diff --git a/include/test/ut.h b/include/test/ut.h
index 2e4d8edf826..a51defc3b90 100644
--- a/include/test/ut.h
+++ b/include/test/ut.h
@@ -479,12 +479,34 @@ struct unit_test_state *ut_get_state(void);
  */
 void ut_set_state(struct unit_test_state *uts);
 
+/**
+ * ut_init_state() - Set up a new test state
+ *
+ * This must be called before using the test state with ut_run_tests()
+ *
+ * @uts: Test state to init
+ */
+void ut_init_state(struct unit_test_state *uts);
+
+/**
+ * ut_uninit_state() - Free memory used by test state
+ *
+ * This must be called before after the test state with ut_run_tests(). To later
+ * reuse the test state to run more tests, call test_state_init() first
+ *
+ * @uts: Test state to uninit
+ */
+void ut_uninit_state(struct unit_test_state *uts);
+
 /**
  * ut_run_tests() - Run a set of tests
  *
  * This runs the test, handling any preparation and clean-up needed. It prints
  * the name of each test before running it.
  *
+ * @uts: Unit-test state, which must be ready for use, i.e. ut_init_state()
+ *	has been called. The caller is responsible for calling
+ *	ut_uninit_state() after this function returns
  * @category: Category of these tests. This is a string printed at the start to
  *	announce the the number of tests
  * @prefix: String prefix for the tests. Any tests that have this prefix will be
@@ -503,8 +525,9 @@ void ut_set_state(struct unit_test_state *uts);
  * Pass NULL to disable this
  * Return: 0 if all tests passed, -1 if any failed
  */
-int ut_run_list(const char *name, const char *prefix, struct unit_test *tests,
-		int count, const char *select_name, int runs_per_test,
-		bool force_run, const char *test_insert);
+int ut_run_list(struct unit_test_state *uts, const char *category,
+		const char *prefix, struct unit_test *tests, int count,
+		const char *select_name, int runs_per_test, bool force_run,
+		const char *test_insert);
 
 #endif
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index a14dbf4ca5e..69f0230e556 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -21,6 +21,7 @@ int cmd_ut_category(const char *name, const char *prefix,
 		    struct unit_test *tests, int n_ents,
 		    int argc, char *const argv[])
 {
+	struct unit_test_state uts;
 	const char *test_insert = NULL;
 	int runs_per_text = 1;
 	bool force_run = false;
@@ -44,9 +45,11 @@ int cmd_ut_category(const char *name, const char *prefix,
 		argc--;
 	}
 
-	ret = ut_run_list(name, prefix, tests, n_ents,
+	ut_init_state(&uts);
+	ret = ut_run_list(&uts, name, prefix, tests, n_ents,
 			  cmd_arg1(argc, argv), runs_per_text, force_run,
 			  test_insert);
+	ut_uninit_state(&uts);
 
 	return ret ? CMD_RET_FAILURE : 0;
 }
diff --git a/test/test-main.c b/test/test-main.c
index 871fc1f22b4..e12c5a95e45 100644
--- a/test/test-main.c
+++ b/test/test-main.c
@@ -673,15 +673,15 @@ static int ut_run_tests(struct unit_test_state *uts, const char *prefix,
 	return uts->fail_count ? -EBADF : 0;
 }
 
-int ut_run_list(const char *category, const char *prefix,
-		struct unit_test *tests, int count, const char *select_name,
-		int runs_per_test, bool force_run, const char *test_insert)
+int ut_run_list(struct unit_test_state *uts, const char *category,
+		const char *prefix, struct unit_test *tests, int count,
+		const char *select_name, int runs_per_test, bool force_run,
+		const char *test_insert)
 {
-	struct unit_test_state uts;
+	;
 	bool has_dm_tests = false;
 	int ret;
 
-	ut_init_state(&uts);
 	if (!CONFIG_IS_ENABLED(OF_PLATDATA) &&
 	    ut_list_has_dm_tests(tests, count, prefix, select_name)) {
 		has_dm_tests = true;
@@ -699,32 +699,31 @@ int ut_run_list(const char *category, const char *prefix,
 	if (!select_name)
 		printf("Running %d %s tests\n", count, category);
 
-	uts.of_root = gd_of_root();
-	uts.runs_per_test = runs_per_test;
+	uts->of_root = gd_of_root();
+	uts->runs_per_test = runs_per_test;
 	if (fdt_action() == FDTCHK_COPY && gd->fdt_blob) {
-		uts.fdt_size = fdt_totalsize(gd->fdt_blob);
-		uts.fdt_copy = os_malloc(uts.fdt_size);
-		if (!uts.fdt_copy) {
+		uts->fdt_size = fdt_totalsize(gd->fdt_blob);
+		uts->fdt_copy = os_malloc(uts->fdt_size);
+		if (!uts->fdt_copy) {
 			printf("Out of memory for device tree copy\n");
 			return -ENOMEM;
 		}
-		memcpy(uts.fdt_copy, gd->fdt_blob, uts.fdt_size);
+		memcpy(uts->fdt_copy, gd->fdt_blob, uts->fdt_size);
 	}
-	uts.force_run = force_run;
-	ret = ut_run_tests(&uts, prefix, tests, count, select_name,
+	uts->force_run = force_run;
+	ret = ut_run_tests(uts, prefix, tests, count, select_name,
 			   test_insert);
 
 	/* Best efforts only...ignore errors */
 	if (has_dm_tests)
-		dm_test_restore(uts.of_root);
+		dm_test_restore(uts->of_root);
 
-	if (uts.skip_count)
-		printf("Skipped: %d, ", uts.skip_count);
+	if (uts->skip_count)
+		printf("Skipped: %d, ", uts->skip_count);
 	if (ret == -ENOENT)
 		printf("Test '%s' not found\n", select_name);
 	else
-		printf("Failures: %d\n", uts.fail_count);
-	ut_uninit_state(&uts);
+		printf("Failures: %d\n", uts->fail_count);
 
 	return ret;
 }
-- 
2.43.0

