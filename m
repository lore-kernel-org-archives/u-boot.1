Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF9CC02182
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:56:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83B8B80840;
	Mon, 20 Jan 2025 22:54:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M9kkgLgD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7990807E9; Mon, 20 Jan 2025 22:54:19 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABDCB80771
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:54:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3ce7f6fdd2aso40325205ab.3
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737410056; x=1738014856; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T5FGVE0GK2hu0/c5vVxSOqMfNBGOGtwIll/fe7rg+VY=;
 b=M9kkgLgDTaXVpcH6SfCCp84pSewB3NNgaT11FxQHqjLD7QvQBdWi2J7/XsOV8S8O2D
 2FOsu+Antnx62c9DcY4UKCJe283hxj8GU2SX+MDn/hEoe7kGqksOGmYgYtMc4t11gKdk
 7TcIu5Mr8vZDzway8gxW30hT7sO7mQ4M/K53o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737410056; x=1738014856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T5FGVE0GK2hu0/c5vVxSOqMfNBGOGtwIll/fe7rg+VY=;
 b=wWy+/Iix3JA8YYT3aJHw2XHCwqLbVFESwheQnxCnLM81bjVWq8V0/tF93mSWOi53LH
 uS0Dj9w5x8MeZ9Ovv/RWH8cFg+vCFyifoj9Bc18E1mBQVWVTlh1VNAlzhP/CcW2RpxRV
 Qzp2UcsxUFqDLbf1pdCqvbkC0UjwfUjDs/EX7fra/m9zIkSP5xhc28s9raIHya1yuIEM
 w0EiCJJVc9wEJ1E9uNCm/6LPJuYj/uJG+iRUDiVfe9A3Iiq1gzhvc++MR3zhp5xQOhdW
 k3O5M4v04zv+wLHJNk/UbUXNL9xPAH9tkYgGxf6YTlLsm35n3mFZ8gOZjhBMjeWelLHx
 Hw3Q==
X-Gm-Message-State: AOJu0YyJ1v1Hlr2eOIvK+gXrzmPus0DUuoY3Zz2mmzAhKK60StF3Przh
 L8uk+hGAfmN4ovYs6eVTqqxruYlW6XmW1W5xXQJq7cq1ZrWBZiNYtelQTsY7d9aCm+Kamyc9ZEw
 =
X-Gm-Gg: ASbGncvLDZbrGNY7J7wJWiO1DBExInXL4U90CGEgocuV2+fb/0jw9oskNy3gnsqW3Sh
 mpRO/XrCSKj+M2cfgrHzlPmNfA/8PGLN/KO8OefZI+JetO7LGNLknuYtJq0Y4xvvvoorEaTjWYi
 i52uNwrI60tfmhouomOhAZAFULpshl0ZABJ41jLSlX7cRDFMwNj3eUilzXoPcLcAaaQzWxY2QrM
 ocMo4BCPtt9BUacOWWmGHfRpy+z2OmNPZrN7Lw1oLVCAlsbATJFup1elREKHNv6qCWo06h3b9Ei
 M/yH2NAYMZ4ElweWuyo2IWZYZ9eRaNY=
X-Google-Smtp-Source: AGHT+IGsr0eeQELNzmh1QMjriMRuKP+RP3OkHhEt3/YedvVS/801Y4bTFtRsZYI/6A5kGMmCz/3BXA==
X-Received: by 2002:a05:6e02:1a0a:b0:3ce:8e2b:a3ac with SMTP id
 e9e14a558f8ab-3cf743e2ec7mr132031785ab.3.1737410055815; 
 Mon, 20 Jan 2025 13:54:15 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea7568067csm2809650173.129.2025.01.20.13.54.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:54:14 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 15/28] test: Drop the function for running fdt_overlay tests
Date: Mon, 20 Jan 2025 14:53:15 -0700
Message-ID: <20250120215340.617194-16-sjg@chromium.org>
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

Use the new suite-runner to run these tests instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/test/suites.h                 |  2 --
 test/cmd_ut.c                         |  4 +---
 test/fdt_overlay/cmd_ut_fdt_overlay.c | 15 ---------------
 3 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/include/test/suites.h b/include/test/suites.h
index dce720b4e78..78f5cdb4bdf 100644
--- a/include/test/suites.h
+++ b/include/test/suites.h
@@ -36,8 +36,6 @@ int cmd_ut_category(struct unit_test_state *uts, const char *name,
 
 int do_ut_bootstd(struct unit_test_state *uts, struct cmd_tbl *cmdtp, int flag,
 		  int argc, char *const argv[]);
-int do_ut_fdt_overlay(struct unit_test_state *uts, struct cmd_tbl *cmdtp,
-		      int flag, int argc, char *const argv[]);
 int do_ut_optee(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 
 #endif /* __TEST_SUITES_H__ */
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 958b591c605..c4a42ee2e20 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -134,9 +134,7 @@ static struct suite suites[] = {
 	SUITE(env, "environment"),
 	SUITE(exit, "shell exit and variables"),
 	SUITE(fdt, "fdt command"),
-#ifdef CONFIG_UT_FDT_OVERLAY
-	SUITE_CMD(fdt_overlay, do_ut_fdt_overlay, "device tree overlays"),
-#endif
+	SUITE(fdt_overlay, "device tree overlays"),
 	SUITE(font, "font command"),
 	SUITE(hush, "hush behaviour"),
 	SUITE(lib, "library functions"),
diff --git a/test/fdt_overlay/cmd_ut_fdt_overlay.c b/test/fdt_overlay/cmd_ut_fdt_overlay.c
index c716c6bd6b0..3244f2d3582 100644
--- a/test/fdt_overlay/cmd_ut_fdt_overlay.c
+++ b/test/fdt_overlay/cmd_ut_fdt_overlay.c
@@ -236,18 +236,3 @@ static int fdt_overlay_test_stacked(struct unit_test_state *uts)
 	return CMD_RET_SUCCESS;
 }
 FDT_OVERLAY_TEST(fdt_overlay_test_stacked, 0);
-
-int do_ut_fdt_overlay(struct unit_test_state *uts, struct cmd_tbl *cmdtp,
-		      int flag, int argc, char *const argv[])
-{
-	struct unit_test *tests = UNIT_TEST_SUITE_START(fdt_overlay);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(fdt_overlay);
-	int ret = -ENOMEM;
-
-	ret = cmd_ut_category(uts, "fdt_overlay", "fdt_overlay_test_", tests,
-			      n_ents, argc, argv);
-
-	free(fdt);
-
-	return ret;
-}
-- 
2.43.0

