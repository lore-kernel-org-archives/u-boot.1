Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C297C02182
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:28:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50D3D8083E;
	Mon, 20 Jan 2025 22:27:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E9OffR8J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85CA680717; Mon, 20 Jan 2025 22:26:59 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 543A080820
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:26:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3ce85545983so17415615ab.0
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737408415; x=1738013215; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ow42Mg4YNry9kZ9G47LxoCapthoLjMzriIesomFjUDI=;
 b=E9OffR8JUYBAT7LVZR/4DaSF8dGSDKcAgASU2fZbXGqwiq3cF2eJKtJuS35gqfhNJ8
 BX8yj20/ExNX4SR1J+HhV1pi0y5Q5QQbBW8KiTRMg210QG0cwVuuG4ppwFDx/GXl8Ip0
 rAoRQ1r/udgjphaxbLvNY74eaaft637crFDmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737408415; x=1738013215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ow42Mg4YNry9kZ9G47LxoCapthoLjMzriIesomFjUDI=;
 b=f64menS0esyb0IUTGj8zvaJM82OJ7g3VLXBEPRHe9Pcx68abQAvYm7nbnwoQm6ytSU
 DrlzV4B+BtKKFCsJaPLGNVIyL/GyAgumFyGwZ4QZYFoflsvV8iLnT/HmrJnpQC8pfJiN
 qmfzouBHuF1jPX4NzFVusfANjlrzaTSJvQ8wicVUB52rFe59i/OVDSOVqhZ585iOq5WU
 wul/JNYI4xIhsU9PDs62Jw4ByFwimJYr+Js3/NfPYT+30iDUjgYdrxeROCm9h9dJxl8c
 2EWpMpxIv15lnGA597jT3/B+fMcKeWCA3eeACZ0vStPAxWFNID+DrkBnTVFCXgD89myx
 BqwA==
X-Gm-Message-State: AOJu0Yw2qhLQSOWdAA3YPfqoqnY4m9QRLL+jSM5HdIeBHzhttbDcxd0Q
 GJYVfQBl+3CXBpOXy6NZ7hXoaHECM31Y7mhvVG6MT8JQq+qrjKx5eU3ToPjV6Sw7LYRqe2Wmh+o
 =
X-Gm-Gg: ASbGncsPQLRYUfmq1mcqMGzxka9snoCDcPUT7gxrvZHTAsdkbpl04MVVi8hl20CCeWB
 UZW+TbWeY3ru4cYq+fKjQEQj8vwkwv28mOaDJk8nAOauVwE1bpz2FpWfr00orn/s6cFxZiAPWQT
 eluzd8y0PWvx8DWpjPbqCkeOOYPLzUoOIXjkPtJ+lHNsosIRCLrROkycZa6DFawsSoEWnzwQVGY
 Gt/o3g3ak7x5h56DeQWP4on2eNhmZkZje1ROCKMgrmrlVmPiPFSOGIvBDZ0oHsQbdU/iik55XIM
 nvqQ6rHjhn/40z7qv/UIwtIPd8HmlKU=
X-Google-Smtp-Source: AGHT+IG73kITUfo7JBeohqYazreNLbtGoKI4Jl3RcKn+QFydY2M90EZTINuxSMxMS/3BlLWnyKPBvw==
X-Received: by 2002:a92:c98e:0:b0:3ce:3541:d80f with SMTP id
 e9e14a558f8ab-3ce8485cc3bmr172095745ab.0.1737408415564; 
 Mon, 20 Jan 2025 13:26:55 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea75440a24sm2847693173.33.2025.01.20.13.26.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:26:54 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 15/44] test: Drop the function for running dm tests
Date: Mon, 20 Jan 2025 14:25:37 -0700
Message-ID: <20250120212613.516664-16-sjg@chromium.org>
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
index 1fda67abd95..a0905ec54b7 100644
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
2.43.0

