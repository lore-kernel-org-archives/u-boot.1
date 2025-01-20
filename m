Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BEFC02182
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:57:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF94080977;
	Mon, 20 Jan 2025 22:54:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hH1lcxhh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E735807E4; Mon, 20 Jan 2025 22:54:38 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 648BF80A09
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:54:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-844d5444b3dso172917139f.1
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737410074; x=1738014874; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7PwF4vhUuI7VkQ9Uyn9BF43d0d0q9NAx3ufr1A7pmtw=;
 b=hH1lcxhhgq4QPHxs3WeXqyRhZDe1RFR8CK7WAty/Dhl0sLpeZpZ+zeZb/XFFxq/OYo
 QkOMsqLkwgjHM0VPi6+15m9CyV14HIQ8d1OXY/6LXPRynVo/dEhrHDvtuoJ2sQGhmVah
 W3jFVazedpjnz/PfvDLaOVc4sPVGzwuhYxqoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737410074; x=1738014874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7PwF4vhUuI7VkQ9Uyn9BF43d0d0q9NAx3ufr1A7pmtw=;
 b=BciUIm37/qyrMjthCfStRGImVCZBiL///Fc0k43wxwwAAnvN6SSrNeLYQbOQHITZP+
 af3e25K2mhKg9L3rmFccAEVTTTowkASHM+39Al3Frzy/dBok78KQ7P+hAles5/OPxu4N
 5CkaVnJGBPBPwghy2BJfYCKSXhnBuPPOrIEQhSbfjToyrSr5Lu5u37wNZ83U4BeT2GUi
 UXFlpSsJ37huUdU8JeYMCiYZDNcpnGyZJsZjTDHf36HCKR+BkEI+YGojU9jwLBro7/Qb
 K7el/Z8rDOE22n/1K9Rxn8wv5FVoqQSzQJnqqbYLfRDEZb9GZ1cgfplPsoKcMLr4il8E
 815A==
X-Gm-Message-State: AOJu0Yz7teUpqlFqynjcI0/xcId/txR6iKVXyQ4WZIdaiE8cI3HJPovQ
 APJtO9Xq/R46MR+gkUWz23DIQm75NoMR33LZ3KiXAlIC4OkiKhDY4Or+iOcXZExzWpAz8jTAK3Y
 =
X-Gm-Gg: ASbGnctd/uDqYXRFxuP5YAoUu4v5tiFzBE3KQ1HhJDXay/TuWRoeJaU1H8/fEa9a4CV
 T9oncooL1KmtvfVL9Roxt6uEN/Da/8axfFNuUKvi/W8gDaC/jns+OGA9Rt9qpeU/Et0EDe+paqO
 dy66kVsAD6Md53cyJO32eivdl7UtI6npt6ToRowO+DidRgxvHYSD5Igsu0J4GkgzhhuBkyKAZoT
 rVY5uXTc+TycIgztJrUYCsGo4p955+L3chjyBZErDDKHG7KZTOPRfdUWjjfnWwh/M3ArLaqMpka
 qrtx0pbT+WWRDjo6YBEDFRRS7NY8Eyw=
X-Google-Smtp-Source: AGHT+IF8jFhLmaaWZYgliPoz4/5pQjeg9Y1bDdoK7uMqCNw2TINcyqMmOISJCsBCcnXz0Vi7lRarNg==
X-Received: by 2002:a05:6602:3e98:b0:844:2ef3:a95a with SMTP id
 ca18e2360f4ac-84f67429c0dmr2255411839f.7.1737410074019; 
 Mon, 20 Jan 2025 13:54:34 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea7568067csm2809650173.129.2025.01.20.13.54.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:54:33 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 25/28] test: Allow running a selection of suites
Date: Mon, 20 Jan 2025 14:53:25 -0700
Message-ID: <20250120215340.617194-26-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250120215340.617194-1-sjg@chromium.org>
References: <20250120215340.617194-1-sjg@chromium.org>
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

 test/cmd_ut.c               | 32 ++++++++++++++++++++------------
 test/py/tests/test_suite.py |  5 +++++
 test/test-main.c            |  2 +-
 3 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index b44e60d5a87..2ef64d1182b 100644
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
+		for (; p = strtok(name, ","), p; name = NULL) {
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

