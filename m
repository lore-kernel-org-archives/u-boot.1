Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B22C02185
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:57:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 494FD80A08;
	Mon, 20 Jan 2025 22:54:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EeqTzxIW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0B5D80A23; Mon, 20 Jan 2025 22:54:34 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B8A580A08
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:54:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-844e12f702dso140406039f.3
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737410071; x=1738014871; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bO0HVHAolI2Wu2LDSQhoDG1YqYkBQ0NnjBYP7SYxUSM=;
 b=EeqTzxIWgiwIlmWFXs4zTACMzWb7ycV27hDV/9jmVp8vTHTD99jLYi5uacWUgXqYHe
 cedoWrb8+xE0ShN56uEE7lIORe4Gm3cf7eg1mFRzE6tnWYr9KMg46guJEj5i3007T6DH
 aSmzeEZoVFdeaQ3dbRT1Qx9Fwa47w8LIjWrV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737410071; x=1738014871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bO0HVHAolI2Wu2LDSQhoDG1YqYkBQ0NnjBYP7SYxUSM=;
 b=Azj1I0mrUUaJMF2loEsyF795SD/p4idliD3KdfwALfnBeXuOko/4V0D0VBO/ID9EnQ
 MvzHGjCMgRgQEqNvzlNFOYuatptkQFcZjqS+2S/yVxG+cZsN9WBWnE4V0FhtJvs1+zm7
 zsUo6hYLhxRvM9qKf+9RAYrr5ng4M0vKx1wZehVkyyJQpUe5NGyDgl+qT2sONxZFRpJ+
 NbKudKpKBViQqlNKez8695t/gw0+ZNpK3ISNi43SbrujUByD/Cw+NtnqI7ba6BXO3o9u
 F7mvme0nUBus/fxsvruZXi6u7VvMo6kD8mIq39HzPBDuQYBaBgiBbE1zf5RygSaEvntb
 y98g==
X-Gm-Message-State: AOJu0YyafODO/j7axXFRDSqWvSRe/NSVkOkFVORcZpgnnN/j7h/VNus5
 A2/b38P0w+aE4AB+QNE3Avy0+9D6l8/xdaM7Nhp2cnZel1cPhx1psUCjI2yhfqUZjfQU9a8McZA
 =
X-Gm-Gg: ASbGncteEprKuQCd4V5sdBvRnveDRGFAJptVNzcTas2KNXQ1LgYWLLLe5m9K+PPArnv
 rWrZj560eKgmORhvxTrmyowOWfjMfcIM4rfqMyshR2CmjebfST2flIemChSuHFpN8HfpechE/tJ
 ZJCPQk31szm3pWC3wiAk6IWTBgt5aYiF8ZJvFVeZO2vhelLIsPFmsRxin8vTRGaF903hxl1WwFH
 9tMvUDaZmO+Rdlb8YUSx06bBzP/8uVl9FYYGddudxjTE+swXiN+oJucLpElo0oNOaMz46geDXHY
 BdaV5oe4wxWt/x0Ndf/XbONKDu9jC9o=
X-Google-Smtp-Source: AGHT+IFIv/DTTVeOoQNjoQrNj4QuZFkvG+LKPoyaIMnK8OLz/TwyQ6sMpAL+WaJ4IRqcMLiF5lM/Yw==
X-Received: by 2002:a05:6602:3f0c:b0:84a:5280:5a15 with SMTP id
 ca18e2360f4ac-851b618ba61mr1259651039f.5.1737410070865; 
 Mon, 20 Jan 2025 13:54:30 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea7568067csm2809650173.129.2025.01.20.13.54.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:54:29 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 23/28] test: Make cmd_ut_category() static
Date: Mon, 20 Jan 2025 14:53:23 -0700
Message-ID: <20250120215340.617194-24-sjg@chromium.org>
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

This function is not used outside the cmd_ut file anymore, so make it
static.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/test/suites.h | 22 ----------------------
 test/cmd_ut.c         |  6 +++---
 2 files changed, 3 insertions(+), 25 deletions(-)

diff --git a/include/test/suites.h b/include/test/suites.h
index 687a8a13e7f..f817da747c2 100644
--- a/include/test/suites.h
+++ b/include/test/suites.h
@@ -7,26 +7,4 @@
 #ifndef __TEST_SUITES_H__
 #define __TEST_SUITES_H__
 
-struct unit_test;
-struct unit_test_state;
-
-/**
- * cmd_ut_category() - Run a category of unit tests
- *
- * @uts: Unit-test state, which must be ready for use, i.e. ut_init_state()
- *	has been called. The caller is responsible for calling
- *	ut_uninit_state() after this function returns
- * @name:	Category name
- * @prefix:	Prefix of test name
- * @tests:	List of tests to run
- * @n_ents:	Number of tests in @tests
- * @argc:	Argument count provided. Must be >= 1. If this is 1 then all
- *		tests are run, otherwise only the one named @argv[1] is run.
- * @argv:	Arguments: argv[1] is the test to run (if @argc >= 2)
- * Return: 0 if OK, CMD_RET_FAILURE on failure
- */
-int cmd_ut_category(struct unit_test_state *uts, const char *name,
-		    const char *prefix, struct unit_test *tests, int n_ents,
-		    int argc, char *const argv[]);
-
 #endif /* __TEST_SUITES_H__ */
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index b3821a0fe68..31ded16325f 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -35,9 +35,9 @@ static int do_ut_all(struct unit_test_state *uts, struct cmd_tbl *cmdtp,
 static int do_ut_info(struct cmd_tbl *cmdtp, int flag, int argc,
 		      char *const argv[]);
 
-int cmd_ut_category(struct unit_test_state *uts, const char *name,
-		    const char *prefix, struct unit_test *tests, int n_ents,
-		    int argc, char *const argv[])
+static int cmd_ut_category(struct unit_test_state *uts, const char *name,
+			   const char *prefix, struct unit_test *tests,
+			   int n_ents, int argc, char *const argv[])
 {
 	const char *test_insert = NULL;
 	int runs_per_text = 1;
-- 
2.43.0

