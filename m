Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 259D5C02182
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:28:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 919DA80790;
	Mon, 20 Jan 2025 22:26:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dkcUYMRI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFDAA801CF; Mon, 20 Jan 2025 22:26:58 +0100 (CET)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F93C800C2
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:26:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3ce7f6fdd2aso40039155ab.3
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737408413; x=1738013213; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R2ThxoSxG4JYgmKBXYsTODMmw0nIUaAJovz01BkxcVk=;
 b=dkcUYMRIOJoEqYmPChGD0rvwax5p5pYmZTOtnRE9MXgFiXRXHhe/yqtPR+q6sd3m3J
 9/6h1gSCa6Tq4Tn2X98wGZtBnz8Q/fEaryq/Aa7ea3H5xWQ4GroOaiW8qfkVO5icJ8/E
 vKA/5trdQ+JgjDliTCkZc7/nhglHJRpcwPAic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737408413; x=1738013213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R2ThxoSxG4JYgmKBXYsTODMmw0nIUaAJovz01BkxcVk=;
 b=YmpNLEQ8jGx8xEiN+/5e5S+HnLLOhknCbD1pCFAEys5f7sarEIEuj+k4sHfVR3/yml
 HSOUFgWEMWdyN7pM+x/9AM/tsIzD3kgrgdaYgomAO+mCt1OUA7VR84SCo6FSCFtt0GK1
 9sICSH3ai7YXobtroE9Kpr6G9irPNW/IWfDK+QmejL148br9Wvg7OZH7qEWZp6MVsBEp
 0en8DQu3HJhOkLhovHtj9JxERPWbBMpJXuqx2fMPwAufZmfXdMOAbrZ08Ag3y8AVjc7L
 Al1fy//mGXxHuWj1/zGIfRF/2y2LLMejD60QaNiMwXeajtBhsHQbOWyinQqrFrwQCuhw
 OS7A==
X-Gm-Message-State: AOJu0YzL2Mbs9GvAs4J+Op7QanxAQmclPiDgAJh4B3+NCIjLMAF0IXo0
 fGXeiYU941+sTrv80XSX3++3ftOEqS27T/7gZNzNFmCoO+MDuZWu23A9QzA/2PfDVRXUXYk8eQg
 =
X-Gm-Gg: ASbGncszWUpxTU957w6AwiRro2lsFJywTRvEzi9PpfEP54vPnNuzHi0or0X6+ngudWT
 Y9X8RsWlBYNqYND/YaooBtA9IR9Z+aVOxKGuPvZwG3iUj8xpFatAN/Q/U04nZbRt/fjtPAYi04/
 6WWE2NkMIvuSsok9yJAirQXjzfRTFYS61R9g8Gbe7hOXk2ngXhmybRT66MdsDcg4sOV/LYXr7/o
 345B2XlBv7PrEb6iUG6Ikrqi61QM0jiI+XPiLHYFFekAaBp/NycgN+6rZ+KFkyl+JLbHO7Qkl6c
 HZWUZOENFTQSGeah7bMuAPV8omsHvho=
X-Google-Smtp-Source: AGHT+IGMl6mw+YsXhYDz8RHabJXezA29kXWdd1TNA8xcIje6EETbijcm0ftdTpcTFdzNoK15Sa+Vkw==
X-Received: by 2002:a05:6e02:1a0a:b0:3ce:8e2b:a3ac with SMTP id
 e9e14a558f8ab-3cf743e2ec7mr131447075ab.3.1737408413468; 
 Mon, 20 Jan 2025 13:26:53 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea75440a24sm2847693173.33.2025.01.20.13.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:26:52 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 14/44] test: Drop the function for running common tests
Date: Mon, 20 Jan 2025 14:25:36 -0700
Message-ID: <20250120212613.516664-15-sjg@chromium.org>
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

 include/test/suites.h       |  1 -
 test/cmd_ut.c               |  2 +-
 test/common/Makefile        |  1 -
 test/common/cmd_ut_common.c | 21 ---------------------
 4 files changed, 1 insertion(+), 24 deletions(-)
 delete mode 100644 test/common/cmd_ut_common.c

diff --git a/include/test/suites.h b/include/test/suites.h
index 21158692e9b..d6c0061ff87 100644
--- a/include/test/suites.h
+++ b/include/test/suites.h
@@ -37,7 +37,6 @@ int do_ut_bootstd(struct cmd_tbl *cmdtp, int flag, int argc,
 		  char *const argv[]);
 int do_ut_bloblist(struct cmd_tbl *cmdtp, int flag, int argc,
 		   char *const argv[]);
-int do_ut_common(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_dm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_env(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_exit(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 09538301cd7..1fda67abd95 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -131,7 +131,7 @@ static struct suite suites[] = {
 #ifdef CONFIG_CMDLINE
 	SUITE(cmd),
 #endif
-	SUITE_CMD(common, do_ut_common),
+	SUITE(common),
 #if defined(CONFIG_UT_DM)
 	SUITE_CMD(dm, do_ut_dm),
 #endif
diff --git a/test/common/Makefile b/test/common/Makefile
index 53c4f16164d..9cfb5585d78 100644
--- a/test/common/Makefile
+++ b/test/common/Makefile
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0+
-obj-y += cmd_ut_common.o
 obj-$(CONFIG_AUTOBOOT) += test_autoboot.o
 ifneq ($(CONFIG_$(XPL_)BLOBLIST),)
 obj-$(CONFIG_$(XPL_)CMDLINE) += bloblist.o
diff --git a/test/common/cmd_ut_common.c b/test/common/cmd_ut_common.c
deleted file mode 100644
index 0724c9361b8..00000000000
--- a/test/common/cmd_ut_common.c
+++ /dev/null
@@ -1,21 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) 2019 Heinrich Schuchardt <xypron.glpk@gmx.de>
- * Copyright (c) 2021 Steffen Jaeckel <jaeckel-floss@eyet-services.de>
- *
- * Unit tests for common functions
- */
-
-#include <command.h>
-#include <test/common.h>
-#include <test/suites.h>
-#include <test/ut.h>
-
-int do_ut_common(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	struct unit_test *tests = UNIT_TEST_SUITE_START(common);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(common);
-
-	return cmd_ut_category("common", "common_test_", tests, n_ents, argc,
-			       argv);
-}
-- 
2.43.0

