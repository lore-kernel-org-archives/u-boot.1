Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 421FDC02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:28:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40D7480819;
	Mon, 20 Jan 2025 22:26:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cH1Jjld6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3176807D3; Mon, 20 Jan 2025 22:26:55 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90982807E5
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:26:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3ce868498d3so19047645ab.3
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737408411; x=1738013211; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rAR30xC2XwT4uCyTjLcpJVotYignuL9KSeWOy5dRo2o=;
 b=cH1Jjld6GqqkCVg0FDA3ijoWNSSysZiE1hFOiuC/C6NHydSuABUGfz+sq4Z5YTI10s
 L+jUbsNL5Mam8n693A+eNu8DiMKwSQFEIvSPiTio0fBFWuJ09PGeLfgf3+ImGBQoZ35o
 zkbr9jU0vizMxcO44A5y8GBbLsQjS1FryvtxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737408411; x=1738013211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rAR30xC2XwT4uCyTjLcpJVotYignuL9KSeWOy5dRo2o=;
 b=dA1lZh6Fo9IVQyIE7qj+za/DCH7PrgjJy48Qr/8T91RYrownDBz+mqx3dEg4+ikP5T
 CIcH25rIVVnLPF0sfgHbHOWEBZeezzpXZNjuScvopzogpeHrIGtjaNhx3/1Uq2Bfhmes
 +I/qLY75WPEx86R2ECjG0JTgH7SmOQ+/yG+/I8vP8th5HDr9pPoUaiQcDXqHDzu4ROMH
 elT/Hykfs/3g9jlIEfROxZ07j4VnqmcjTOHs6XGZFIK0Q+OGG2tr5oalOWdOXFjHGtKd
 cZioClW/Nsu5x955dwI5GAIWjP0CexAtgF+aT3hpcZOFPpyzxhF+A5AlBpZ2iyzvIYj7
 gxDg==
X-Gm-Message-State: AOJu0Yx5tQbNZg7t4kRWWDL/5FmY//8XxwknxuU54GUny/DCCiHnDbpv
 YvG/DzibiIHV3yszv0AQO/T/9g4LOK70AjPipOhnMuEzQuol3ntbMJEqNkVBB/Nho/iJdR5G/xw
 =
X-Gm-Gg: ASbGncsixhJj3x80XRNdh9ubTGuTs8wFZJp+saXJYj4iEtwwUYeZidcoQOp/fqkchcw
 J/Z0KDfAzwHWHvwBsxiSCDkJq6EmzgD+eoKWmfuiwnI0P1h68LJSz9ufqgZyrVsD7SkfvvvNINQ
 3Wc7uXLSSjOJI5mDY5KS89AofzXZor8zQWDE8xDuWWzqPrP5+87tM4iKVwsiqmfJ55S2XFINgOs
 yeu4sVY2S0XkuJ/nRyL6GqK25uyqL4vMWhJZM0z9s/oWO23vGPLBkXMZZ/mSOBxGrOBZe3pA47e
 Q/wE4eqqVmeu3TD+tB5n4IWX2kEuMeE=
X-Google-Smtp-Source: AGHT+IHobY8R3EtbdEmbx9np7g7bnYB3n+GR8XIXpNNyuUyRuS1GWrsi+eWua1R01YqkOBKrGCvdlg==
X-Received: by 2002:a92:ca4d:0:b0:3ce:7852:129b with SMTP id
 e9e14a558f8ab-3cf7449ddc3mr106340235ab.20.1737408411536; 
 Mon, 20 Jan 2025 13:26:51 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea75440a24sm2847693173.33.2025.01.20.13.26.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:26:50 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 13/44] test: Drop the function for running cmd tests
Date: Mon, 20 Jan 2025 14:25:35 -0700
Message-ID: <20250120212613.516664-14-sjg@chromium.org>
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
index bbd329912d4..09538301cd7 100644
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
2.43.0

