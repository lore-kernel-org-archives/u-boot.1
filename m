Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E853EC02196
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 18:35:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4119E80C72;
	Fri,  7 Feb 2025 19:32:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dUQw1dFZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD96B807AE; Fri,  7 Feb 2025 19:32:34 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 718A580EB0
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 19:32:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-854a68f5aeeso53551639f.0
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 10:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738953150; x=1739557950; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rV8oSSKopJr/4KUOMC9pMWPie+S1L7oKlLObwJKznJY=;
 b=dUQw1dFZMmCP0mDIMZbWb91mZS2OTeP1SCg510tT+2nfMfDb89x1u3U1QCOJqOIAfa
 XwvUbzJ4WZNmOqLz/XiS9KrWpfkYZSG1mNiOV5pP/t0D+j3DigmMipaqL7URVdsuWxa2
 f0jcznL2bDXHptsDdQCaXGBrzPk01xSzeaz50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738953150; x=1739557950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rV8oSSKopJr/4KUOMC9pMWPie+S1L7oKlLObwJKznJY=;
 b=NKxG3plFuH8wso3A5ntifV5N6H5wSEmqZ2un9rdEVRF67I3Qlgk0zsC3+F2VC8bQxu
 jdvoXo3qrq4E6dx/bhi8E+pTeQNf1K+T9NnGYlqWITF22fDV6LWML786qeMJwPdbShBw
 F/84EhHYD5jjnBVX1sYUtVy8buLfHUdKi8DN+Nj0/x6Fz1Pq9rwC3pHo1lwioFgELB6S
 oanKDbZS8d6+TfxQGxxkFgPRyFuh3qLijSgEdMSz9ruJPwMKsAj+IfrYamAC2J8Ld4Ma
 mmOSAZm46g19I5e6p4WXbY4/AyRMHmLsIS652kyjwv2nVAJF+FE7eW+zel3+K9blGiQM
 unzw==
X-Gm-Message-State: AOJu0YzQkcjMWFwdlmaUfP+H1zjoQ1KHB8rYEKAFKoTfl2HW7OTLVr8S
 VbxxZXjgtTzls/UdsE8XgQjnquDis+0LyWZUDBP5vDi32sPHK/S7AZcHDe3CDzjV/Xj8WBaEFmE
 =
X-Gm-Gg: ASbGncvDDCtikTszojCTwYgKtVFeJh5Wd1NVlR887j5jQuytx4m/3phsbR+TOgqiSov
 6MkAnv4PjkJPiP+JrOCu/7cEEr9hGZlQ+7zF0YoDg7GJ/EG1LJI7Xq316z5fE0SLjesq74k9B6Y
 0US4iDoswErHekA5bNJPd7cnyBi6pbwJHl/jk/K5krtKj88M5cXtA0TUvPRW0Sdd3VoimyKZXD6
 qDV92TsM+VUGFT+yqsPjnL5HnN0CjnWyOHuDRLcO1eN4aqp82OksQVcQ0as3cHRLD4oDo+Zq44y
 uTaHmbA4bEqf5sAUnZxoYTfF7PtPspWzwZkX+VKxEnH9eC+ppYxQ
X-Google-Smtp-Source: AGHT+IGkAhFmoGL5cQWn2VrqW2NnZkWJDriDhaP2RRjLadRlpNntvvppa3tIKcTnlniBsrJeNZ4SkQ==
X-Received: by 2002:a05:6602:4895:b0:84a:5201:570b with SMTP id
 ca18e2360f4ac-854fd79521cmr428702139f.0.1738953150609; 
 Fri, 07 Feb 2025 10:32:30 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-854f67bc3ecsm74850439f.47.2025.02.07.10.32.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 10:32:29 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 26/29] test: Allow running a selection of suites
Date: Fri,  7 Feb 2025 11:30:57 -0700
Message-ID: <20250207183121.117663-27-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207183121.117663-1-sjg@chromium.org>
References: <20250207183121.117663-1-sjg@chromium.org>
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

Enhance the ut command to accept a comma-separated list of test suites
to run. Report the summary information for these at the end.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Use strsep() instead, in case tests use strtok()

 test/cmd_ut.c               | 32 ++++++++++++++++++++------------
 test/py/tests/test_suite.py |  5 +++++
 test/test-main.c            |  2 +-
 3 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index b44e60d5a87..3925a391de1 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -218,7 +218,6 @@ static int do_ut_all(struct unit_test_state *uts, struct cmd_tbl *cmdtp,
 			update_stats(uts, ste);
 		}
 	}
-	ut_report(&uts->total, uts->run_count);
 
 	return any_fail;
 }
@@ -282,7 +281,7 @@ static int do_ut(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	struct unit_test_state uts;
 	struct suite *ste;
-	const char *name;
+	char *name;
 	int ret;
 
 	if (argc < 2)
@@ -299,17 +298,26 @@ static int do_ut(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	} else if (!strcmp(name, "info")) {
 		ret = do_ut_info(cmdtp, flag, argc, argv);
 	} else {
-		ste = find_suite(argv[0]);
-		if (!ste) {
-			printf("Suite '%s' not found\n", argv[0]);
-			return CMD_RET_FAILURE;
-		} else if (!has_tests(ste)) {
-			/* perhaps a Kconfig option needs to be set? */
-			printf("Suite '%s' is not enabled\n", argv[0]);
-			return CMD_RET_FAILURE;
-		}
+		int any_fail = 0;
+		const char *p;
+
+		for (; p = strsep(&name, ","), p; name = NULL) {
+			ste = find_suite(p);
+			if (!ste) {
+				printf("Suite '%s' not found\n", p);
+				return CMD_RET_FAILURE;
+			} else if (!has_tests(ste)) {
+				/* perhaps a Kconfig option needs to be set? */
+				printf("Suite '%s' is not enabled\n", p);
+				return CMD_RET_FAILURE;
+			}
 
-		ret = run_suite(&uts, ste, cmdtp, flag, argc, argv);
+			ret = run_suite(&uts, ste, cmdtp, flag, argc, argv);
+			if (!any_fail)
+				any_fail = ret;
+			update_stats(&uts, ste);
+		}
+		ret = any_fail;
 	}
 	show_stats(&uts);
 	if (ret)
diff --git a/test/py/tests/test_suite.py b/test/py/tests/test_suite.py
index 1e02d67efe2..d0025a7ba30 100644
--- a/test/py/tests/test_suite.py
+++ b/test/py/tests/test_suite.py
@@ -187,3 +187,8 @@ def xtest_suite(u_boot_console, u_boot_config):
 
         assert suite_count == len(EXPECTED_SUITES)
         assert total_test_count == len(all_tests)
+
+    # Run three suites
+    with cons.log.section('Check multiple suites'):
+        output = cons.run_command('ut bloblist,setexpr,mem')
+    assert 'Suites run: 3' in output
diff --git a/test/test-main.c b/test/test-main.c
index ee855bfe2ed..cabc736a524 100644
--- a/test/test-main.c
+++ b/test/test-main.c
@@ -683,7 +683,7 @@ static int ut_run_tests(struct unit_test_state *uts, const char *prefix,
 void ut_report(struct ut_stats *stats, int run_count)
 {
 	if (run_count > 1)
-		printf("Total tests");
+		printf("Suites run: %d, total tests", run_count);
 	else
 		printf("Tests");
 	printf(" run: %d, ", stats->test_count);
-- 
2.43.0

