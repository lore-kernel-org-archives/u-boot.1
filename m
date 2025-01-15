Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E0BC02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:35:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D45A8083B;
	Wed, 15 Jan 2025 14:31:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iWJnuh4H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51C3E808E6; Wed, 15 Jan 2025 14:31:50 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9CEE80756
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:31:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3ce8c069840so2030335ab.3
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 05:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736947906; x=1737552706; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5C0LuESPVnowXH7+m5mMqsWQ9cijQmqNlpMqrybusec=;
 b=iWJnuh4HCgjWeWbZuOksMeUfwJqG40BAr+imak2CMZy2b0ZYQxZ6XK2IeZ3tLPhoIp
 9vtboXaoFU1SHxQSsOYiLsRkOsJomq1j5vhj9gHXkJrwme5kUXaVDxhqs0DlhbmB6yoJ
 31a6+bchN2AWdEEjm0Wp88+1Nh+eDEcXPUz4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736947906; x=1737552706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5C0LuESPVnowXH7+m5mMqsWQ9cijQmqNlpMqrybusec=;
 b=bta3OTFLwfiyumMTqgEYEtU6u99SPlZi54dKBu/C+u7p/QczymtTXwSEtFsq+IotHb
 jV5MllTB2r88gBqd359lhRumJWNo3EDazk4qhule9GGa2xpJbvXpRs47mvawtumtf2He
 aO6U8moLAwCNluzHh0fazOc6UmKY9TCm+TyHiT9ZuRbj4vznzIahRcADyL5X/K612Gox
 HwYp44y3RyX2s7n63hftp35F4LfcTQEHxVWSJIQdpluL8rZxCTdsHKxEL/JDF65QekGm
 syURbIYesOKLkD5MxqXDIbfwxU6jScLujDQkfcQpQvsK396CYvynWjVqYCs+BISg6WOI
 w1ZA==
X-Gm-Message-State: AOJu0YxIc8xxUuL7b23oncFp0LplXcG5tznZPadKd7Sfp9WDeVadmmg+
 XUgBYnhH6rHQlW4FJXGHHj6ZnlZAsVyo+OFSjG2bKFu25hj7vC34YDAbjMU0r/Vql2rrfJwpbJM
 =
X-Gm-Gg: ASbGnctixcFlo8+ub4Dx2b0tGMQ9wiWzmns/H5I3qh1dARZ4rroaNVMfCWE2Zb4jYoh
 H8f2kg9GM++3pAA/0LEUfesCtbgN9pLHqs2rPJOQSxrdr+54cqM/zmcgm6npoaGr0jbi6gSgAUF
 b1GIMtZmLjPVfw4V9fn1fqzgmW9s/JzbEtg34nrG8F5eH0XswS9uWUCkcbJ9Nzhs+3CKL87Dh1t
 oJ+K8iFQIK0arjN/8jHwnSHFfNlehqJkBZhyyFr1x4Xh4zLKTJVJ2Fd8cXxen5v1eiAOcZRWXv/
 RpUqoevf9A25YXI+iA==
X-Google-Smtp-Source: AGHT+IEzeDmO+rAlY5KUkibt8LP9Wzh4zNAVmDKke87B/PVkmO+MFV6vs7ulBSdlUp8RuU4LajeN+w==
X-Received: by 2002:a05:6e02:1a47:b0:3ce:6828:8955 with SMTP id
 e9e14a558f8ab-3ce68288f5bmr124231675ab.5.1736947905933; 
 Wed, 15 Jan 2025 05:31:45 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm4091248173.20.2025.01.15.05.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 05:31:44 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 15/43] test: Drop the function for running dm tests
Date: Wed, 15 Jan 2025 06:30:45 -0700
Message-Id: <20250115133114.590375-16-sjg@chromium.org>
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

Use the new suite-runner to run these tests instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/test/suites.h |  1 -
 test/cmd_ut.c         |  2 +-
 test/dm/Makefile      |  2 --
 test/dm/test-dm.c     | 15 ---------------
 4 files changed, 1 insertion(+), 19 deletions(-)
 delete mode 100644 test/dm/test-dm.c

diff --git a/include/test/suites.h b/include/test/suites.h
index d6c0061ff87..414613c593e 100644
--- a/include/test/suites.h
+++ b/include/test/suites.h
@@ -37,7 +37,6 @@ int do_ut_bootstd(struct cmd_tbl *cmdtp, int flag, int argc,
 		  char *const argv[]);
 int do_ut_bloblist(struct cmd_tbl *cmdtp, int flag, int argc,
 		   char *const argv[]);
-int do_ut_dm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_env(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_exit(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_fdt(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 4b529cbd699..a3dcbef1740 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -133,7 +133,7 @@ static struct suite suites[] = {
 #endif
 	SUITE(common),
 #if defined(CONFIG_UT_DM)
-	SUITE_CMD(dm, do_ut_dm),
+	SUITE(dm),
 #endif
 #if defined(CONFIG_UT_ENV)
 	SUITE_CMD(env, do_ut_env),
diff --git a/test/dm/Makefile b/test/dm/Makefile
index bcb52ef1067..e44f3d89e77 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -3,8 +3,6 @@
 # Copyright (c) 2013 Google, Inc
 # Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-office@arm.com>
 
-obj-$(CONFIG_UT_DM) += test-dm.o
-
 # Tests for particular subsystems - when enabling driver model for a new
 # subsystem you must add sandbox tests here.
 ifeq ($(CONFIG_XPL_BUILD),y)
diff --git a/test/dm/test-dm.c b/test/dm/test-dm.c
deleted file mode 100644
index 8f83110163a..00000000000
--- a/test/dm/test-dm.c
+++ /dev/null
@@ -1,15 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (c) 2013 Google, Inc
- */
-
-#include <test/suites.h>
-#include <test/test.h>
-
-int do_ut_dm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	struct unit_test *tests = UNIT_TEST_SUITE_START(dm);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(dm);
-
-	return cmd_ut_category("dm", "dm_test_", tests, n_ents, argc, argv);
-}
-- 
2.34.1

