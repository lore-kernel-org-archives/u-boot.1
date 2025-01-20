Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6620C02182
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:29:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18008807FB;
	Mon, 20 Jan 2025 22:27:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OSUwMybT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 410CB808AF; Mon, 20 Jan 2025 22:27:03 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D043C807E1
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:27:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-844e61f3902so396067639f.0
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737408419; x=1738013219; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HcLJTwTxBRRoprXcJaiGL/m+j1Sn3cqh21mz1o7k/+c=;
 b=OSUwMybTHBz4Xd//zU+82XXJlCTfdNS2UNAYQqhZI7xA5YC1/jJrftbKpdIwxVYkvh
 8DQ/OiAVlKicznXnxOdEyMEOnBCFL0yuDytggXoKj4gknqMLPZlTuag81eKWFVow/ovI
 q0l8ROe0eFx3PlsvXajxNdlEoRtzJDO7Qc1dg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737408419; x=1738013219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HcLJTwTxBRRoprXcJaiGL/m+j1Sn3cqh21mz1o7k/+c=;
 b=YNg3Z8TEBYifmIzYT6w6Uo5YbLtf44D8FwKdiy/atT4LytbWmBVxHWR2trtMX0Zxru
 UMR9vNj1ZnnGZjcj7lS6BoSsryX9yEdY+40S49EfoBRauRHzPxITeAm0cNHGyKyR1vfj
 xvszX94xYz4YMvquNr3e4ZKiCKX+cYrgczxLjPt8JTC9veGhrZLZzpOb2BGMOlqeJ5H0
 DSUj8rRpX1fpPMPO0nWKH7LYh6d5t72MFgFYWZgaO0DXQonnQ3ODPdXpE2/i9aRGuuEk
 XgGgbG6wDXMJjn/qC6hcEqQf1RuMg0aVuVZV9T7+Gy8PNZRLadddyhf9a/UbgVKMp3hL
 s5JA==
X-Gm-Message-State: AOJu0YxafQt7yOkLGz3xIZ80MBOXxm9YGQSwqPymgQBQdbIz8sKxZh4X
 CE9VUCDA9TXNwG9uGxGlo58PAO7Bp5WGlZ5S5nyNEUzQdDgcEwEwCxGmaN88O9FvExXWHOjc1WA
 =
X-Gm-Gg: ASbGncuBSFh2hToH0tqkx4rBYc4scEucMRnyavy+GziPBjWH5BZhKmLTOY1HyNx1SfV
 NFAdm2y4FjZvzbTM6Oo6vIA/4e3TlWf6HqAhqDsFevGrHr2qv7/BhPh7o1G5FqoMYaNzM1HsCjo
 iXMlq8g4BOfsbPZVst9sZDgDclp3Nh8oOMY5hS4oyN4zwc00jzAn5VSwjYCvCWe9tsyzcOzVtrY
 dmMZFAlFvy2neZNIItyDRA6w/10ZII43HgHlpcvAxE/ce55/tgTn0iVJC9f0wfABUlV5MltwiFE
 eHkjSllQbeLfhp/65Bzdz/gmC4nyfJc=
X-Google-Smtp-Source: AGHT+IGEFuhCaxLbq3QRD8JjkqWQSW6kI7K/hr+SxGtAeY7w8Kkf41HmEOW/7VdUvA2RFjwBpA0S8Q==
X-Received: by 2002:a05:6602:6d8d:b0:841:8d66:8aea with SMTP id
 ca18e2360f4ac-851b617219bmr1098988339f.2.1737408419085; 
 Mon, 20 Jan 2025 13:26:59 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea75440a24sm2847693173.33.2025.01.20.13.26.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:26:57 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 17/44] test: Drop the function for running exit tests
Date: Mon, 20 Jan 2025 14:25:39 -0700
Message-ID: <20250120212613.516664-18-sjg@chromium.org>
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

Use the new suite-runner to run these tests instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/test/suites.h | 1 -
 test/cmd/exit.c       | 9 ---------
 test/cmd_ut.c         | 2 +-
 3 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/include/test/suites.h b/include/test/suites.h
index b78436fe2b2..70b9af1fd05 100644
--- a/include/test/suites.h
+++ b/include/test/suites.h
@@ -37,7 +37,6 @@ int do_ut_bootstd(struct cmd_tbl *cmdtp, int flag, int argc,
 		  char *const argv[]);
 int do_ut_bloblist(struct cmd_tbl *cmdtp, int flag, int argc,
 		   char *const argv[]);
-int do_ut_exit(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_fdt(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_font(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_hush(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
diff --git a/test/cmd/exit.c b/test/cmd/exit.c
index d1eacdc36c2..71c37edcdf6 100644
--- a/test/cmd/exit.c
+++ b/test/cmd/exit.c
@@ -110,12 +110,3 @@ static int cmd_exit_test(struct unit_test_state *uts)
 	return 0;
 }
 EXIT_TEST(cmd_exit_test, UTF_CONSOLE);
-
-int do_ut_exit(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	struct unit_test *tests = UNIT_TEST_SUITE_START(exit);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(exit);
-
-	return cmd_ut_category("exit", "exit_test_", tests, n_ents,
-			       argc, argv);
-}
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 155b187ad4b..387aacb916b 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -138,7 +138,7 @@ static struct suite suites[] = {
 #if defined(CONFIG_UT_ENV)
 	SUITE(env),
 #endif
-	SUITE_CMD(exit, do_ut_exit),
+	SUITE(exit),
 #ifdef CONFIG_CMD_FDT
 	SUITE_CMD(fdt, do_ut_fdt),
 #endif
-- 
2.43.0

