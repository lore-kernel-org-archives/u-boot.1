Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15AB8C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:57:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB5E880934;
	Mon, 20 Jan 2025 22:54:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MUha37qi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E651B80A0A; Mon, 20 Jan 2025 22:54:32 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAD36807E4
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:54:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-844e394395aso144902439f.3
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737410069; x=1738014869; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YmQrlCYkccZrWD9deOQ41vgBjA2eHsNooJKHupDKAmE=;
 b=MUha37qiXksr3CzNOX2C0HF3DvbJVaXZ+PsSqr7IxirBVOyrLrcOMi4xEFmNrhjdeB
 iJ3PH07NxJHYOJsZjbesRn/3P2eZFcrgZf8jfDNgGdiAkCsS9JhRNSnPQFX54eicHUry
 nKgz1IvV4bR6yIp6nEHPaYoYnSa21CxcerTiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737410069; x=1738014869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YmQrlCYkccZrWD9deOQ41vgBjA2eHsNooJKHupDKAmE=;
 b=mTJtbZhHpfSXfO/MnEEZJeJzl0JO79ipBnZ/XGa5HtqwmVgorzIgW8K0zZn8T+5bME
 hpDmVW2C8Lj+eu0lrG7TksQuYRnXsuzSk81r7yvE7UiwDe84wq0N+tPu2IIubovwXsHR
 pWwAspiIaWsU+uv/aHg6JmlcMXiI3hWmelNJ0KizCrHSYC1HloSsexASNQ8sedZ0WEyy
 IJRl3noTklJnv0kLuNRu+mkrbCo5cBWBaYkveFn6wNwT5fgxk5Xx9pLG4lp0JkMAc3bA
 SuZVgVHjSmdcJHCRiwD05ers1ehU/D/Wwj2zcDTEme8K1l3OIynmY7odrUqv8MA6/otk
 vBJg==
X-Gm-Message-State: AOJu0YypUwchEid0i0G3fjiD4FvJfqpSxguktXXRfXBRExeQddU4DyUS
 /HWOo97iWY1oMpaTfldy8vM2EljMUDQa85koNk6tIbDVjP6sy8g/rL6Sv/svrFqhXKlb+9kHHDc
 =
X-Gm-Gg: ASbGncuH80RIOt7WTtXpblXwa/QNI/5mNc9zKHoIXqtIPC+uj61lUq7ryZbpm+iDnbw
 KLUts+/MA1Rm45VdqsZgsSQByBRbvEgmeZVu4oTN/UznJc5Ow3nJisnnovrpGafO2ZYO2aerfMi
 GGKhnJYo33ubiEG0bJr+grPr1zlWwP2Vp6zBzm5TDVwPEUmGtPZaK9NqCCJ/usu2WgNesJ++ad7
 fPZi3ozO/t8Sa/mzWIr1JOm/EpyUieIP2KiBiVSe0uYUoixqaoq4FrnS67khehfm7YnILspBHFE
 tCzuZhb4RUL/BOc9KzX3n8YFksTLvHg=
X-Google-Smtp-Source: AGHT+IFoLh+Fr0+oIwVgW1iCmHhh3pg3ukdYZlN66gG7th/onuWcYoejV46FXb9L4ZJQT0smNrj9XQ==
X-Received: by 2002:a05:6602:134c:b0:844:cbd0:66ca with SMTP id
 ca18e2360f4ac-851b619f53amr1184347839f.1.1737410068910; 
 Mon, 20 Jan 2025 13:54:28 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea7568067csm2809650173.129.2025.01.20.13.54.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:54:27 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 22/28] test: Drop support for test commands
Date: Mon, 20 Jan 2025 14:53:22 -0700
Message-ID: <20250120215340.617194-23-sjg@chromium.org>
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

Now that everything is using the new test-suite features, drop support
for running commands.

Fix a missing closing-bracket while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/test/suites.h |  5 -----
 test/cmd_ut.c         | 43 ++++++++++++-------------------------------
 2 files changed, 12 insertions(+), 36 deletions(-)

diff --git a/include/test/suites.h b/include/test/suites.h
index a2f982bf6fa..687a8a13e7f 100644
--- a/include/test/suites.h
+++ b/include/test/suites.h
@@ -7,14 +7,9 @@
 #ifndef __TEST_SUITES_H__
 #define __TEST_SUITES_H__
 
-struct cmd_tbl;
 struct unit_test;
 struct unit_test_state;
 
-/* 'command' functions normally called do_xxx where xxx is the command name */
-typedef int (*ut_cmd_func)(struct unit_test_state *uts, struct cmd_tbl *cmd,
-			   int flags, int argc, char *const argv[]);
-
 /**
  * cmd_ut_category() - Run a category of unit tests
  *
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 6d1e20ef02e..b3821a0fe68 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -20,14 +20,12 @@
  * @name: Name of suite
  * @start: First test in suite
  * @end: End test in suite (points to the first test in the next suite)
- * @cmd: Command to use to run the suite
  * @help: Help-string to show for this suite
  */
 struct suite {
 	const char *name;
 	struct unit_test *start;
 	struct unit_test *end;
-	ut_cmd_func cmd;
 	const char *help;
 };
 
@@ -76,21 +74,11 @@ int cmd_ut_category(struct unit_test_state *uts, const char *name,
 	ll_start_decl(suite_start_ ## _name, struct unit_test, ut_ ## _name); \
 	ll_end_decl(suite_end_ ## _name, struct unit_test, ut_ ## _name)
 
-/* declare a test suite which uses a subcommand to run */
-#define SUITE_CMD(_name, _cmd_func, _help) { \
-	#_name, \
-	suite_start_ ## _name, \
-	suite_end_ ## _name, \
-	_cmd_func, \
-	_help, \
-	}
-
 /* declare a test suite which can be run directly without a subcommand */
 #define SUITE(_name, _help) { \
 	#_name, \
 	suite_start_ ## _name, \
 	suite_end_ ## _name, \
-	NULL, \
 	_help, \
 	}
 
@@ -161,7 +149,7 @@ static bool has_tests(struct suite *ste)
 {
 	int n_ents = ste->end - ste->start;
 
-	return n_ents || ste->cmd;
+	return n_ents;
 }
 
 /** run_suite() - Run a suite of tests */
@@ -169,19 +157,15 @@ static int run_suite(struct unit_test_state *uts, struct suite *ste,
 		     struct cmd_tbl *cmdtp, int flag, int argc,
 		     char *const argv[])
 {
+	int n_ents = ste->end - ste->start;
+	char prefix[30];
 	int ret;
 
-	if (ste->cmd) {
-		ret = ste->cmd(uts, cmdtp, flag, argc, argv);
-	} else {
-		int n_ents = ste->end - ste->start;
-		char prefix[30];
 
-		/* use a standard prefix */
-		snprintf(prefix, sizeof(prefix), "%s_test_", ste->name);
-		ret = cmd_ut_category(uts, ste->name, prefix, ste->start,
-				      n_ents, argc, argv);
-	}
+	/* use a standard prefix */
+	snprintf(prefix, sizeof(prefix), "%s_test_", ste->name);
+	ret = cmd_ut_category(uts, ste->name, prefix, ste->start, n_ents,
+			      argc, argv);
 
 	return ret;
 }
@@ -266,14 +250,11 @@ static int do_ut_info(struct cmd_tbl *cmdtp, int flag, int argc,
 			struct suite *ste = &suites[i];
 			long n_ent = ste->end - ste->start;
 
-			if (n_ent)
-				printf("%5ld", n_ent);
-			else if (ste->cmd)
-				printf("%5s", "?");
-			else  /* suite is not present */
-				continue;
-			printf("  %-13.13s %s\n", ste->name, ste->help);
-			total += n_ent;
+			if (n_ent) {
+				printf("%5ld  %-13.13s %s\n", n_ent, ste->name,
+				       ste->help);
+				total += n_ent;
+			}
 		}
 		puts("-----  ------------  -------------------------\n");
 		printf("%5d  %-13.13s\n", total, "Total");
-- 
2.43.0

