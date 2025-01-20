Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6E0C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:30:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14E99807CD;
	Mon, 20 Jan 2025 22:27:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EMW7Im4j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95620809A8; Mon, 20 Jan 2025 22:27:14 +0100 (CET)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07714809A4
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:27:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3cda56e1dffso15147275ab.1
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737408430; x=1738013230; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=agcu6Jb6BT9mKQRvntr+D93OwzT0ELXXeZmCEJtAptQ=;
 b=EMW7Im4jYEutugGbmJNjYnfd36LwZAR8HOMyHO+wpE9Hfu4dC1UFf8K3FoTRCn/Z6v
 ylla9ubZcRwdl+VBSZsRQd/VBkflek8al8jYJmTTRQo4fOlHJq/cjAd8xWskbHGzKP5Z
 wJmZNhbVJa21bS8LX+zgoOa4hsu/nQPA86KBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737408430; x=1738013230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=agcu6Jb6BT9mKQRvntr+D93OwzT0ELXXeZmCEJtAptQ=;
 b=f6TUCqMhOFW6aX/5w7bGZteYcfW13+kYO6yn4ZvTje/nn/EkStgTQmmDA1ZWjC320E
 J0cB0euzDwMgycF2lWRbtuNwkGKOw4/a5bc1lBIJu3sD4T/R7DpHeklaOlwSTKgO+DvG
 G0Y2xT4OYnTOJUBYylstcXAuVmg9S9vhcTMcZoI7R9fo5YSp07OoQHBaRsyWF+djt4xh
 /YXiHZqGrW3AORcz5+WC4AciXwrSLylaaDHkybIu8dEKu333xG9qQfUtiz2Rim32seRo
 Xe0wHuKLUa0I+5lApntE7fiNi23WgpHcNHRa1WgdA2iN7tCogQfG1lEAtgGYk9e8H2AW
 MP9g==
X-Gm-Message-State: AOJu0YxcpJeF1VDoGBqDB71su/duqRWYmE63eA9uMHmowEcEzL7qJRWT
 HlVWsYQ06YVYFYvon6zzCsVWfWwzoiAB5BeRF60mTqIOLHj4iNY4MosXRT082HF0aa0M0Zgbz9c
 =
X-Gm-Gg: ASbGncsjwenAC1kDH4fw7yzjxnCK4EcoPnkSUxYI+Gsp3xglivdm5ErZaBRDMv7Sdig
 SAJAnFFTNeO2OGu2z1G5NDMTQ84zokzPvn0GsJR+cdycJcdjrKFs+egD7mJrR+3fUm1muAF9FSS
 uJgOXsthVfW3TpFZf6MTVyHx0emEEmbH+mzsROcnNWVv5P1fTg7nPhGGr6YHIJYLylINFJTdhRC
 Awfa2/nkDwgyJT6cfvEwwrmpFVz+7+O0LiD1rIGE+TLCwMXGdOw5HTMLBUIkgdfVhjXmkuwB0fy
 OU4DLuWUYufKyszz5nvbJjehpTQVr6w=
X-Google-Smtp-Source: AGHT+IE5UmoBv3MHU2xZzIRyil/JKZKxat95SDRsXFiFa/DMmO15fTqs197QepYocLd7QRVqAnEhzQ==
X-Received: by 2002:a05:6e02:1a67:b0:3ce:80b8:7328 with SMTP id
 e9e14a558f8ab-3cf743a9a61mr103169025ab.3.1737408430236; 
 Mon, 20 Jan 2025 13:27:10 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea75440a24sm2847693173.33.2025.01.20.13.27.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:27:08 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 23/44] test: Drop the function for running mem tests
Date: Mon, 20 Jan 2025 14:25:45 -0700
Message-ID: <20250120212613.516664-24-sjg@chromium.org>
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
 test/cmd/Makefile     |  2 +-
 test/cmd/mem.c        | 19 -------------------
 test/cmd_ut.c         |  2 +-
 4 files changed, 2 insertions(+), 22 deletions(-)
 delete mode 100644 test/cmd/mem.c

diff --git a/include/test/suites.h b/include/test/suites.h
index 612167fe053..cb6b6fba240 100644
--- a/include/test/suites.h
+++ b/include/test/suites.h
@@ -40,7 +40,6 @@ int do_ut_bloblist(struct cmd_tbl *cmdtp, int flag, int argc,
 int do_ut_hush(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_loadm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_measurement(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[]);
-int do_ut_mem(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_optee(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_overlay(struct cmd_tbl *cmdtp, int flag, int argc,
 		  char *const argv[]);
diff --git a/test/cmd/Makefile b/test/cmd/Makefile
index f83c53696d0..d8a5e77402d 100644
--- a/test/cmd/Makefile
+++ b/test/cmd/Makefile
@@ -10,7 +10,7 @@ endif
 ifdef CONFIG_CONSOLE_RECORD
 obj-$(CONFIG_CMD_PAUSE) += test_pause.o
 endif
-obj-y += exit.o mem.o
+obj-y += exit.o
 obj-$(CONFIG_X86) += cpuid.o msr.o
 obj-$(CONFIG_CMD_ADDRMAP) += addrmap.o
 obj-$(CONFIG_CMD_BDI) += bdinfo.o
diff --git a/test/cmd/mem.c b/test/cmd/mem.c
deleted file mode 100644
index 2b78e421a9c..00000000000
--- a/test/cmd/mem.c
+++ /dev/null
@@ -1,19 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Executes tests for memory-related commands
- *
- * Copyright 2020 Google LLC
- */
-
-#include <command.h>
-#include <test/suites.h>
-#include <test/test.h>
-
-int do_ut_mem(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	struct unit_test *tests = UNIT_TEST_SUITE_START(mem);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(mem);
-
-	return cmd_ut_category("mem", "mem_test_", tests, n_ents, argc,
-			       argv);
-}
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 1a69b1c215b..8ab29046969 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -161,7 +161,7 @@ static struct suite suites[] = {
         && defined(CONFIG_MMC_SANDBOX) && defined(CONFIG_MMC_WRITE)
 	SUITE(mbr),
 #endif
-	SUITE_CMD(mem, do_ut_mem),
+	SUITE(mem),
 #if defined(CONFIG_SANDBOX) && defined(CONFIG_CMD_SETEXPR)
 	SUITE_CMD(setexpr, do_ut_setexpr),
 #endif
-- 
2.43.0

