Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 879CDC02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:34:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA9F9807DD;
	Wed, 15 Jan 2025 14:31:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UxZFR8/m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D533D807B4; Wed, 15 Jan 2025 14:31:47 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E3F280714
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:31:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-844de072603so556939739f.0
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 05:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736947903; x=1737552703; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r0bzfInVmGKXIF+l3YxbItaKOHvVCUtEbZWvVYiGsA8=;
 b=UxZFR8/m+IQ3aPeSVaqb//qp6nVT/Qj9j37jjiLmF+7HDM0vNHay4IYZceVoLXbMH1
 Ojoq7acL0YGJyTkQ69vTbLGIaoM+RvzN1ISBi2YtUDD40kjKH3j7usM7dUy7xu2AUxls
 oh5ZCJw37ot6VOY+OD6AztV5XHN9H/iG9IZDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736947903; x=1737552703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r0bzfInVmGKXIF+l3YxbItaKOHvVCUtEbZWvVYiGsA8=;
 b=qC1UIQbpyZVZQsO0a7sOJwOfgSdUxVWJ3H5XGqyFOxZcos9j4fJDtv3lBHUNrmabmO
 rLv2n2+nWK59pz3t+rCA8QbmLEIDmWuCO/G4thtot2DbcGsbH5U+eekYF7eMHkoEVV3n
 M9B8J9NvRDDbqdyePg7XQ49by/VYQdob4ftXuN8xSj7c+O+lc77/xEFkXGVqAW43/hMD
 F751CYwKxdmY5Uc/g4VjvK4uHOI6ENWlZJYofvd9haboSQTJf85g47WHr7oC36MXvgxN
 VLXpKq00fNEGPBKTxfsXKMuHy/Gh6EtqUVSHUWPM8ZMGip24bc8mC4BDwzDZrRTURQy3
 xF/A==
X-Gm-Message-State: AOJu0YyVyrhXCDLAXarILwN0K8CLSNY+U/uljfGV49j2BcwftvQ1dEWH
 7qO7HLXWqNy1xF8oorwIBdFIVeWhOWM0YjPnodgrlQV1vRTxHUhr3t+DQ59UiXvoVoJIgBSG9Zo
 =
X-Gm-Gg: ASbGncvpM0IePjNBwgD9mXHvx+q11iJUpj/nP379joMitwr76SvURCsNxmFSENCpDg+
 FwymdMcdIqfNxucyjWWylH+5m8L00Q48oXr4B0zSw+gC0GDgUyO+COmOMtGYXUi8GY8K5ZNCBWp
 ngkD7wSLYHZyRrGlzZy+cdgQq1pdJOyIL249gEXAyb63msFuedZbymtSryOq5Rsy/vvMqJxBQy3
 RO7SE9VM6R8y0tBzEnt35rY9YlOe0527pktiXpKiDoP3Q8jEv51NpSrshz799BpVQSmDRityt1M
 U6InIQAvukuhNFenMQ==
X-Google-Smtp-Source: AGHT+IExub62ROs1+L3FDFWLhNnsCeYDnPXM3xJ6cb6Kr5/zhqHHwopU3IodTKureh4wnGjhSrgBFQ==
X-Received: by 2002:a05:6602:4c06:b0:844:c76a:354d with SMTP id
 ca18e2360f4ac-84ce00368f5mr2654394339f.2.1736947902909; 
 Wed, 15 Jan 2025 05:31:42 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm4091248173.20.2025.01.15.05.31.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 05:31:42 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 13/43] test: Drop the function for running cmd tests
Date: Wed, 15 Jan 2025 06:30:43 -0700
Message-Id: <20250115133114.590375-14-sjg@chromium.org>
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
 test/cmd/Makefile     |  2 --
 test/cmd/cmd_ut_cmd.c | 20 --------------------
 test/cmd_ut.c         |  2 +-
 4 files changed, 1 insertion(+), 24 deletions(-)
 delete mode 100644 test/cmd/cmd_ut_cmd.c

diff --git a/include/test/suites.h b/include/test/suites.h
index b6af9295424..21158692e9b 100644
--- a/include/test/suites.h
+++ b/include/test/suites.h
@@ -37,7 +37,6 @@ int do_ut_bootstd(struct cmd_tbl *cmdtp, int flag, int argc,
 		  char *const argv[]);
 int do_ut_bloblist(struct cmd_tbl *cmdtp, int flag, int argc,
 		   char *const argv[]);
-int do_ut_cmd(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_common(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_dm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_env(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
diff --git a/test/cmd/Makefile b/test/cmd/Makefile
index 583e7c2eec4..f83c53696d0 100644
--- a/test/cmd/Makefile
+++ b/test/cmd/Makefile
@@ -3,8 +3,6 @@
 # Copyright (c) 2013 Google, Inc
 # Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-office@arm.com>
 
-obj-y += cmd_ut_cmd.o
-
 obj-$(CONFIG_$(XPL_)CMDLINE) += command.o
 ifdef CONFIG_HUSH_PARSER
 obj-$(CONFIG_CONSOLE_RECORD) += test_echo.o
diff --git a/test/cmd/cmd_ut_cmd.c b/test/cmd/cmd_ut_cmd.c
deleted file mode 100644
index ad192563c5a..00000000000
--- a/test/cmd/cmd_ut_cmd.c
+++ /dev/null
@@ -1,20 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright 2023 Google LLC
- * Written by Simon Glass <sjg@chromium.org>
- *
- * Unit tests for command functions
- */
-
-#include <command.h>
-#include <test/cmd.h>
-#include <test/suites.h>
-#include <test/ut.h>
-
-int do_ut_cmd(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	struct unit_test *tests = UNIT_TEST_SUITE_START(cmd);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(cmd);
-
-	return cmd_ut_category("cmd", "cmd_test_", tests, n_ents, argc, argv);
-}
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 2ee9b589b52..761556cc763 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -129,7 +129,7 @@ static struct suite suites[] = {
 	SUITE_CMD(bootstd, do_ut_bootstd),
 #endif
 #ifdef CONFIG_CMDLINE
-	SUITE_CMD(cmd, do_ut_cmd),
+	SUITE(cmd),
 #endif
 	SUITE_CMD(common, do_ut_common),
 #if defined(CONFIG_UT_DM)
-- 
2.34.1

