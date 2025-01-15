Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B88C02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:37:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DBEC80BAF;
	Wed, 15 Jan 2025 14:32:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g6PQj+de";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 944E380714; Wed, 15 Jan 2025 14:32:13 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 597BB807E1
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:32:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-844dfe4b136so174457439f.3
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 05:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736947929; x=1737552729; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y3uRCKGX/aAxPopc0qkq5qlLEeQgfn+uMNkERT3wroU=;
 b=g6PQj+dekAWl9Lo6djSjnECMsgHMyCHGZT9XwvSL5qPoSKOXYQOUFipqRqg5E3GgiQ
 CLy4+Ns3ol5ojrk2GNyxDRiuXuDteRPgYkGchqh2pYJEXL5IMXXYsVlr7iMfSNxUOQr9
 x7Y2OTSPmR6fv+rD+tgbXdax4YPgET+5JvtFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736947929; x=1737552729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y3uRCKGX/aAxPopc0qkq5qlLEeQgfn+uMNkERT3wroU=;
 b=nWXcf+o2T2NF1bpeC/Sj1HUnYjP3iZ7QFLQvH+1MfhYLDBAITV3rXJkIuK7Bky71Cg
 T7NCllfKCw6Q6t/DALqMtxV4Aa9XYtijgrtdvwaiEcpb/VSL6SMonuALOw4UdDABpVNb
 Nxsg7T6r1ZSn9JVwCMU8dbkqzuKAV/DM88jO+q1npVaufj1F8Im3eer17XZ4vQAsBici
 xTuh6KMJNYF9vSG1o7PaNfG3s3NvqTWRROSWKe4UkrZjo/52peDh/TgSdppmXw08YitE
 8dHP2hh25W3/LdVx5alb5/7VmYGwySSJT/dAbOoQwodHwFpHUaoyX/X2F5bfmQU52q3Q
 CjtA==
X-Gm-Message-State: AOJu0YwSxS7nCYE8i9cICZL7wYVWled+vv7/Pr8GFh7iKA36yk3X5UgM
 MCW/MxsWpau3oIwbZQvp/IyLyeJXk5TTZoLEg/1xMD3E+DU6J3r+0m4FFClJnKe3ln68Xs4zT2I
 =
X-Gm-Gg: ASbGncts3w215UYgjTppUaYVp7ZIXRD2z0Yfwbq7cGSqln0RfYD92+9DfTEAb0Zmt4q
 Y12g5Zoi6BNksekNdKUPM/0D/nMWydMPx1GnIjo7i1Yqv7U4Ht+xb0wl0Wn4scGpmovUVwmNuDF
 HUKVT90lmqhBXYByv4E78NdRt5jyjPqj/MYzI0GRX1LByuUZOqRPGjCsuf4ENXtMLNRdvxXKs+u
 JRNw6XfUpn4TF0KE3InlYoms3J4vGm6Un0GeK9IXZKF1BNAfG1K4swuPWq/AZ2R5xKqRxCYsE+Z
 d489kavuN8ltlZ8NPg==
X-Google-Smtp-Source: AGHT+IHnkEMYCgD+bza8AQKF8hDz46jMh8f7efhM52ohsyPFHExicG31VNJv6HUgI3h2Swd4Ylm+Nw==
X-Received: by 2002:a05:6e02:308b:b0:3a7:6c6a:e2a2 with SMTP id
 e9e14a558f8ab-3ce3a9b8f55mr223219705ab.9.1736947929572; 
 Wed, 15 Jan 2025 05:32:09 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm4091248173.20.2025.01.15.05.32.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 05:32:08 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 29/43] test: Drop the function for running hush tests
Date: Wed, 15 Jan 2025 06:30:59 -0700
Message-Id: <20250115133114.590375-30-sjg@chromium.org>
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

 include/test/suites.h   |  1 -
 test/cmd_ut.c           |  2 +-
 test/hush/Makefile      |  1 -
 test/hush/cmd_ut_hush.c | 19 -------------------
 4 files changed, 1 insertion(+), 22 deletions(-)
 delete mode 100644 test/hush/cmd_ut_hush.c

diff --git a/include/test/suites.h b/include/test/suites.h
index 54fddaa6bac..b96a78f7129 100644
--- a/include/test/suites.h
+++ b/include/test/suites.h
@@ -32,7 +32,6 @@ int cmd_ut_category(const char *name, const char *prefix,
 
 int do_ut_bootstd(struct cmd_tbl *cmdtp, int flag, int argc,
 		  char *const argv[]);
-int do_ut_hush(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_loadm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_optee(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_overlay(struct cmd_tbl *cmdtp, int flag, int argc,
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index f68da4dcf76..39489ba0811 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -176,7 +176,7 @@ static struct suite suites[] = {
 	SUITE(addrmap),
 #endif
 #if CONFIG_IS_ENABLED(HUSH_PARSER)
-	SUITE_CMD(hush, do_ut_hush),
+	SUITE(hush),
 #endif
 #ifdef CONFIG_CMD_LOADM
 	SUITE_CMD(loadm, do_ut_loadm),
diff --git a/test/hush/Makefile b/test/hush/Makefile
index 4c3a0be857a..febdc82e8aa 100644
--- a/test/hush/Makefile
+++ b/test/hush/Makefile
@@ -3,7 +3,6 @@
 # (C) Copyright 2021
 # Francis Laniel, Amarula Solutions, francis.laniel@amarulasolutions.com
 
-obj-y += cmd_ut_hush.o
 obj-y += if.o
 ifdef CONFIG_CONSOLE_RECORD
 obj-y += dollar.o
diff --git a/test/hush/cmd_ut_hush.c b/test/hush/cmd_ut_hush.c
deleted file mode 100644
index 141203d766b..00000000000
--- a/test/hush/cmd_ut_hush.c
+++ /dev/null
@@ -1,19 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * (C) Copyright 2021
- * Francis Laniel, Amarula Solutions, francis.laniel@amarulasolutions.com
- */
-
-#include <command.h>
-#include <test/hush.h>
-#include <test/suites.h>
-#include <test/ut.h>
-
-int do_ut_hush(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	struct unit_test *tests = UNIT_TEST_SUITE_START(hush);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(hush);
-
-	return cmd_ut_category("hush", "hush_test_",
-			       tests, n_ents, argc, argv);
-}
-- 
2.34.1

