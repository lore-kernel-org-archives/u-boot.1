Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA81C02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:34:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 503E1808AF;
	Wed, 15 Jan 2025 14:31:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Z/xBesO1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B0CB807B4; Wed, 15 Jan 2025 14:31:48 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44A3F807DD
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:31:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-844df397754so217272539f.2
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 05:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736947904; x=1737552704; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q9NUyk/OncPe3pc/RSZs4CTDsihLs8pkpXqSM6zIj9s=;
 b=Z/xBesO1wh6Ybkzck/HlKTZkfSFC7/z/MpBElzGLXEIfut8fPhHohb3gyZWb72caWl
 NgQmAQ8KUFNRsMUaerJgGWSy0qEIbGAEwQZvYwUi9l34fRpsjtJaT5/qa+iGCOYLiQrQ
 1C2FzMFsNRs34TwK0R3RCChz6Gw7ViXZRNhGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736947904; x=1737552704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q9NUyk/OncPe3pc/RSZs4CTDsihLs8pkpXqSM6zIj9s=;
 b=PDz6liuTJP6mvm4p9p3u/MxAhd2pmM/c5iuo3cyabE/f2BjrR9Ou/coACLl9+XLAjQ
 UXAHa0ZndE3MRmf6WiIQt9uoACGBxx93ewujD+XAzwkxNQuUJj6aGy1/ZBUV4ASoKdVw
 KhRvNwfw41c/Ak7zgDPz1mZeOtwAIZ81ct+f8Nb2yXVk8ES6n0LHXMVOarPLV1NnbGoP
 4kmok9+GQU+zXx1IuubtVGruwLv9uYH5u3PuhTlBudt3maZ5gjVufQldERpOU6aZkXHp
 S8naKlRXdL8Dttyffj/XpJ4QQNVDbwADsadojXDeyxwZn3S2W2WRCKMXwN59SRybJMoX
 o2TQ==
X-Gm-Message-State: AOJu0YyrzWd4wxz6Ktm8wgjvMT88z5J9CoDmt7akUkU2CBRA+2p9+zke
 YOCI6DLbw/VLWrv4Aj7uaVfhLgOwyut1l4jkIbG7Y5bVDMTzTkm2gT17VOv8MMxNJ0WtK+TvttY
 =
X-Gm-Gg: ASbGncsvC2BhlarxOhZEAEOEl7Q1QY9Efedj984uUpOH7+Ta/g6GJchzkVzSeoa9flk
 RvVjcwhwEZiKMYkXVZP7RMAOKZZs0Ht/Or7OJBhWerX5KdF9E9FZMMLFuYMUaTkhUUnVnHh6qdp
 pTj/ec80KHPHrAFLlw+i0JtQ+QqVDfw8Fuoq06iC2SqBwIJZcmoJXwjWFOY/M8Hsb7VSBKfyWVC
 VWiTZrxuyiZFQArF8NqbRc3eNVSzjxweqysjuYvsJMSdI0NXtmscJxJOW9gHW+PR6ZGAXdtrWJE
 zpV85zIAlFG/tsKIVw==
X-Google-Smtp-Source: AGHT+IGxtG7XVlKUQlnqsfgLghu86qXEgq+nnxI4DfbQN2GmOpc0BiN2YE1OnbdCkPIUlrTPlLJ+rA==
X-Received: by 2002:a05:6602:4810:b0:843:e89d:b62b with SMTP id
 ca18e2360f4ac-84ce015fd46mr2452385939f.11.1736947904146; 
 Wed, 15 Jan 2025 05:31:44 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm4091248173.20.2025.01.15.05.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 05:31:43 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 14/43] test: Drop the function for running common tests
Date: Wed, 15 Jan 2025 06:30:44 -0700
Message-Id: <20250115133114.590375-15-sjg@chromium.org>
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
index 761556cc763..4b529cbd699 100644
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
2.34.1

