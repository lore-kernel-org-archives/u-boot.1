Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05837C02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 18:34:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17D4680C65;
	Fri,  7 Feb 2025 19:32:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RzE1mGqR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E9C480C8A; Fri,  7 Feb 2025 19:32:28 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6595B80C83
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 19:32:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-844eac51429so187575639f.2
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 10:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738953142; x=1739557942; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tK6BeGbh3y6CGGbxGeyv/3alyy88lULbE12Y0mIq+lM=;
 b=RzE1mGqRDOXx7xgN6FlvzB5/1UO2Ub61x4ael8ugVvlTTBZWSGekLo3HjfkMV+G/z7
 NC7UiIlZUDXn+ijP/Ll68WY9r+EaDKmj/4AXJxMEMVq7jnK4P6AA1y3P8EwCTgYQBMmD
 hsy/bHHhi6v65jzy670RsHjpo45mWRFnM/6vk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738953142; x=1739557942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tK6BeGbh3y6CGGbxGeyv/3alyy88lULbE12Y0mIq+lM=;
 b=k/4MKhWh/e3gLUp4zg/rECv8QSoPvTleB5Tfk3dwbGweQNvj0BjpIt/qz2wd/+KAdC
 6HoggJTRScsJCz/dkH4vFMINm0XKyA8cPItG1SHrBz/+L1Ke4YQhQRcKqESVJ3f0xNI4
 9FPdOxz6hDECp0w0W4HIyxjyM6r5YnqMjJ/UgWXP5L7NA+dm0s0ZDvHULFuE3qorsHQB
 +zL/32lmiM33dK7MCcvEFhL4573RCqxViGCY4XjH3kKvQNwNjYgclQitvouqpHLjfY+n
 l8HCcttX8IQwaA+3t2qVVC0QKF05b+Uzl2hH7D+sDLvPjPextNDf+neTQYzHB1NrXP+L
 OpcQ==
X-Gm-Message-State: AOJu0YwbaxsD+Qe2za7U+qhheReJ8+j5tLfuEQZPmnnTzG1ypPtMsaPE
 JcZkugztkPLWNuazdzvJ5KQGray0V72C1MPQI5haD3RRTXumMd7vYWCegyMs02qWPWmsPF25noQ
 =
X-Gm-Gg: ASbGncsZMD5kAhEUD/9EnREd9bQRo8vmt3nHcdhGQlr86Dn6d2yOYmCgiCebLQjtrdm
 5VmoUas8olfZwHc1kTUTwuXpOlBz4txNEOp912RATeKrZ3Os11AJ/aZWGK+96QnqoaUcWqMrIoS
 RH8lU+ie+Tkx+z4/DoifgmVMur7uOduGq00LzHYQfscKf6dTAcvzIYN2rLWg6mJS2O99zNk18ja
 Rrw7YR+p99eM3FhK/W+5ZtjEE60k7sD7S185pZqpD70PiljjG/WfNd87KgSe9gkyHemOHpPWVZ2
 qY+GtD/p6hV+fToKMsgtQSzMovjHcymkajS1WLTR7ZUM9rUHeU8H
X-Google-Smtp-Source: AGHT+IHabYz2t5hdW7+3OM7qRjcftTDBRRsV0VkP2DvlqDHKVMDVhofaT/boMdi0NsTs/S9vsfHc5g==
X-Received: by 2002:a05:6602:7289:b0:84f:5547:8398 with SMTP id
 ca18e2360f4ac-854fd8f59d6mr477753139f.11.1738953142545; 
 Fri, 07 Feb 2025 10:32:22 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-854f67bc3ecsm74850439f.47.2025.02.07.10.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 10:32:21 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 23/29] test: Drop support for test commands
Date: Fri,  7 Feb 2025 11:30:54 -0700
Message-ID: <20250207183121.117663-24-sjg@chromium.org>
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

Now that everything is using the new test-suite features, drop support
for running commands.

Fix a missing closing-bracket while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

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

