Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4349AC02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:30:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 111C28032B;
	Mon, 20 Jan 2025 22:27:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SIp1oNKB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01C308083F; Mon, 20 Jan 2025 22:27:26 +0100 (CET)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE8C680A4E
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:27:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3a9caa3726fso14259775ab.1
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737408442; x=1738013242; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HDBZACBBMrnxwcIs824UCENCIOEDQqmmg7IAkvq8r5Q=;
 b=SIp1oNKBXMEvEj25kJqqIhUrU3txGLFLiRtRdmyOuC6Lku85F3rdwF4ll6ZZYK/0X6
 LXfM2BkRMLNhov4s94pChlyUgrq3Dbv6QuDt1oVJ2opeVfx3z+aX/b162yepr/L3vhLf
 vT4Lsl9HspjJQzfx5WUUFBqDFmHyjvcgMr3vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737408442; x=1738013242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HDBZACBBMrnxwcIs824UCENCIOEDQqmmg7IAkvq8r5Q=;
 b=V5GGA3Mlx3cF+jtf69FuBW8Gq+SMObXAV96aiuKTBqJyfkpOvhAxWSz+KXQ7uJSFbG
 xGAcsFupzCatFvmPBi1sr6W8pP+zyLTK18+fSCEelXb3z5zxw+1a338EmH3pAvwYSpsu
 RlOGCz7fKZBcCQuCTsUldDlKlukIPKsZ/6pXWmf5tUMcgD6UxjuvIJI63Yn56Qg5nWEE
 aZcUQMm/vW+S7x9vQeUeJKYOtFOiF4AvtYsVdliZaozfmf+DPa0R1JJ7aWxkpdba3VUf
 Njxze2ZeFQw/OhmvZbRT5YTQrDB7tJF3StlPnLflMrYFWGcQqJwao0xadC+TKSZdwmMd
 NFtw==
X-Gm-Message-State: AOJu0YyCehTpxpLDHVpfuTD+wCi/Sfu62TGO/fwNKaeTkhGkdPUSfsrW
 O196bPZ/NXf5AcyCPF8DkIIFfEL4ALyQz86HnebSwfxCkX4QnwzoooJ9zaZwY+QukmtrgtOCJhA
 =
X-Gm-Gg: ASbGnctQRXMD1K1B4L4YMgXIFJj9jKtNQryFR/LA0X400wjMdSE+8GvCgtkSwTPFHLy
 w2RIdJqUoyPkJx8WoH6ovzVWC8uZc6XDNG/z3j4WBTlUfrspBNrkN/roelkXicwZ6wgl8lefkAk
 Ko8ABtmvDOrH/jlLfbWq0TPekDT0T13f3Xins1JxRNKD0bLPN1vSClVcrdMlWD7i9tY9ZtzP5FI
 8SHoMPNbkktWudGZDZ7xeyokmi+pRw65f9Kla0faqNRundZlpUwio71bsUB2WynG8onGoWI4EMZ
 WT/nKZO/nzytPsPYhnZbNE3IEuHHaM4=
X-Google-Smtp-Source: AGHT+IFlss9iXv8+WGC5Mqzc5Vx3iy1ADIBw/QE2wnBP3k/dsjx0c2R37a6+GpTsm0NGxV5rI333Xw==
X-Received: by 2002:a92:c54f:0:b0:3ce:34fb:fdac with SMTP id
 e9e14a558f8ab-3ce849b9f59mr183264575ab.5.1737408442025; 
 Mon, 20 Jan 2025 13:27:22 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea75440a24sm2847693173.33.2025.01.20.13.27.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:27:20 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 29/44] test: Drop the function for running hush tests
Date: Mon, 20 Jan 2025 14:25:51 -0700
Message-ID: <20250120212613.516664-30-sjg@chromium.org>
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
index 611171740a9..c892891d6c8 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -178,7 +178,7 @@ static struct suite suites[] = {
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
2.43.0

