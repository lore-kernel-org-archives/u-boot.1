Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA1BC02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:33:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC86F80812;
	Wed, 15 Jan 2025 14:31:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OsgQkeOP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A98C7807E5; Wed, 15 Jan 2025 14:31:30 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A54880714
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:31:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-844dfe4b136so174439339f.3
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 05:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736947886; x=1737552686; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OR83/gygwHeRB3uASnEGYKNAIAdKGzeZm87bnmLUU6A=;
 b=OsgQkeOPN1xTKxTWBnKsOFVbhYICD5hKd4ojpjR6TxmvfTVtcMKCrCMXG6qZbbQDVJ
 jU6UFiPkK6UFwhqUReJbG444kGJ0vL+UMkpCakkg17sZxPx/c8ESHZVb4euFIxd+/rpT
 vSI2hbmJHgWiMd19DSfiCHupIsQMtFHOyLcvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736947886; x=1737552686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OR83/gygwHeRB3uASnEGYKNAIAdKGzeZm87bnmLUU6A=;
 b=qlkrNvtcVScUTbODEzehPGxh5iIEroSU6IcwjjPwOZX2ImqRIkU4x9gFT998UaYmdc
 Uc4XFLVRB5Qu+zZu5p3tY9IWH5QMR7nci/4UV0XYFzUvh+jZFhmLHqoeiycLYg2lE3vw
 62BUhXWBg543XIOBBaBI9waFMsHvG7MUNdJ10zgTTmq6MCH18rfB0SsZPO+DaM3AVNdc
 aJUQ3YevrOWydqoPdzJ65N4jVuNS1L2DRtC41jNWlL+NygJ19L7O0W2+aBUkqTi8QvCI
 FSllZ8q6fRN37ek8XjHKGEAUt/XClPNdc11uf4b5jwG7LyUQtufVOUFJczrrr4+lRNsL
 6c5A==
X-Gm-Message-State: AOJu0YwIWuNTJo+lPog47vLxly5gpYDw5Hft7os2zZinPgEi/ouBICF6
 q2TJP8qX9F+05UkcFIHe97SgYMFfYWj2bSmLNrPcSCG6l0NemkpuHUEgpVVOd2/ToKSV8lDRw1s
 =
X-Gm-Gg: ASbGncu1RQ0LAaGfusKcqF8zxMbS6UYm/AtY36SEdgmVOz0lO506y3FiFDSgFigNPLk
 tfcLn0yDj3f+hQR2J5PkC/YADueaBb0okBOi4WpwQ00qIwazb9hKn/MYFRtt1SHtvZOzopqBnEl
 /trArRTOUo04SoOaCso1yB7sX+aAmuxN6r0ACqGuYCtZsWMvmmrvumKy/2XM5Tk/Sd26ykGRbmM
 GZPSKIMg0IlEdWQ+rSywawQBX4VBJVGsdwGOCLRnGtsgVywcGsvZVVTz9qqL4+EptB1TbBlS0Uw
 PYRs5HGHwr4pP/iJgg==
X-Google-Smtp-Source: AGHT+IESjnVq129q2NffnfY7MegjKgW4rn8IuEmzHSkIuIf2+luNMrSjBSvfu/o5QnJKlU5gVN1pcA==
X-Received: by 2002:a92:c243:0:b0:3a7:87f2:b010 with SMTP id
 e9e14a558f8ab-3ce3a9a5743mr231779215ab.5.1736947885540; 
 Wed, 15 Jan 2025 05:31:25 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm4091248173.20.2025.01.15.05.31.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 05:31:24 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/43] test: Add functions to init and uninit the test state
Date: Wed, 15 Jan 2025 06:30:33 -0700
Message-Id: <20250115133114.590375-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250115133114.590375-1-sjg@chromium.org>
References: <20250115133114.590375-1-sjg@chromium.org>
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

Move these operations into separate functions so that it is clearer what
is needed. These functions can also be called from somewhere other than
ut_run_list().

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/test-main.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/test/test-main.c b/test/test-main.c
index cfb3504941d..871fc1f22b4 100644
--- a/test/test-main.c
+++ b/test/test-main.c
@@ -73,6 +73,19 @@ void ut_set_state(struct unit_test_state *uts)
 	cur_test_state = uts;
 }
 
+void ut_init_state(struct unit_test_state *uts)
+{
+	memset(uts, '\0', sizeof(*uts));
+}
+
+void ut_uninit_state(struct unit_test_state *uts)
+{
+	if (IS_ENABLED(CONFIG_SANDBOX)) {
+		os_free(uts->fdt_copy);
+		os_free(uts->other_fdt);
+	}
+}
+
 /**
  * dm_test_pre_run() - Get ready to run a driver model test
  *
@@ -664,10 +677,11 @@ int ut_run_list(const char *category, const char *prefix,
 		struct unit_test *tests, int count, const char *select_name,
 		int runs_per_test, bool force_run, const char *test_insert)
 {
-	struct unit_test_state uts = { .fail_count = 0 };
+	struct unit_test_state uts;
 	bool has_dm_tests = false;
 	int ret;
 
+	ut_init_state(&uts);
 	if (!CONFIG_IS_ENABLED(OF_PLATDATA) &&
 	    ut_list_has_dm_tests(tests, count, prefix, select_name)) {
 		has_dm_tests = true;
@@ -703,10 +717,6 @@ int ut_run_list(const char *category, const char *prefix,
 	/* Best efforts only...ignore errors */
 	if (has_dm_tests)
 		dm_test_restore(uts.of_root);
-	if (IS_ENABLED(CONFIG_SANDBOX)) {
-		os_free(uts.fdt_copy);
-		os_free(uts.other_fdt);
-	}
 
 	if (uts.skip_count)
 		printf("Skipped: %d, ", uts.skip_count);
@@ -714,6 +724,7 @@ int ut_run_list(const char *category, const char *prefix,
 		printf("Test '%s' not found\n", select_name);
 	else
 		printf("Failures: %d\n", uts.fail_count);
+	ut_uninit_state(&uts);
 
 	return ret;
 }
-- 
2.34.1

