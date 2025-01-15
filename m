Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05809C02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:35:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47A7380A3E;
	Wed, 15 Jan 2025 14:32:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Imiq9Np0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DB3080808; Wed, 15 Jan 2025 14:31:58 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D9098082D
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:31:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-844ee15d6f4so514501539f.1
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 05:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736947914; x=1737552714; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D7UZ3+TxMElLBzulP6bCybYWTkeGZrFmC2P+m8DPdqQ=;
 b=Imiq9Np0SSABEK6oHNeATuYrc1gE3vHtZAXk04Li7ajRTxu+ZwvLXnbtWLMqUHyrNX
 WDjkGIu4aDahmzsAvFZWzGx1AMlgLeKWR+FnuC1S/VziO9vhubJQSwZ6UfKC+EyW+ZJ4
 xtIpD8v2ARxN57zYqaXfFK/FigqlwfRn0EiYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736947914; x=1737552714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D7UZ3+TxMElLBzulP6bCybYWTkeGZrFmC2P+m8DPdqQ=;
 b=k978Fse49lNhAzCsrh+wZ/Fc/56SARqdKtheJSMkS06r+7XqNCnuIVM9wgJ8mclQhf
 pTweJ2ClfkGdaSjXlCynr7pAHdc+UF6IGUoq+aWUFcYKOXOigsZQOl2x0ZUuw/m3rCfV
 0svTfQhEqmw3Jsu+BeZPyn1snkOqN0BD3KfUbW8+5R6meVXR6a8SgbjWaMiZTrgIHWiM
 uufjl66A8DJR20tJJxhvw1gzNutLlgHQwtYIHJkaBdWnarH5EJTWlqzu2a7PSZx/D1uV
 FcJpijA+YVwpihf0Sp6qpGJpdsGQkevxubK7p2XR13Un9MpRrlmMErMGrpWW0KFNsBbV
 hIVA==
X-Gm-Message-State: AOJu0YwYE8+KW/8yCvUDNZIXamfVyiUNH/UelvB1vI8wo94uvxU28pi2
 +zr0rj1ODMd/LJQwvEHXdAWkVwWGuEr3I8+uY/iao3Q8p7AJPLjKte7MTCyjXp5ayDpR+l/zhIQ
 =
X-Gm-Gg: ASbGnctMv6h+EufHDpkL/GImQpLikH5TMZZTkMJi5gwU/lH2SdQ3rA88oUuU6bLHPBL
 M5oWV8N+PO6bQ8ypHRXf8SjIsIaGmHOeiSI9W2Y+zUUitzjukyjGQlsHLiu6/1lu7JoxDopOxs5
 ot2c0bvTURptjR3CcpoLzfKy1ZzgdPmjggmLGMlPVjB1C92UsyoYoG1STGG08u8fYHxZEM+U0te
 h/wlfI3tP1lUhCogHOMEUSr8jeohBU5HiLeHOKybwD0GCULJpCb3qO2AfVZ2P7F7B93O+C5uEdS
 stRXr5Ohj9k49zjzig==
X-Google-Smtp-Source: AGHT+IGdYXDDgpzfWGjzA7PevX2Ls+a698Ovp4Vu/hdT1IGNkjvAnnvssVU/EXKWOUZZXJFlISWmtA==
X-Received: by 2002:a05:6e02:164c:b0:3ce:64a4:4c52 with SMTP id
 e9e14a558f8ab-3ce64a44d8amr122613625ab.13.1736947914266; 
 Wed, 15 Jan 2025 05:31:54 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm4091248173.20.2025.01.15.05.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 05:31:53 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 20/43] test: Drop the function for running lib tests
Date: Wed, 15 Jan 2025 06:30:50 -0700
Message-Id: <20250115133114.590375-21-sjg@chromium.org>
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
 test/lib/Makefile     |  1 -
 test/lib/cmd_ut_lib.c | 19 -------------------
 4 files changed, 1 insertion(+), 22 deletions(-)
 delete mode 100644 test/lib/cmd_ut_lib.c

diff --git a/include/test/suites.h b/include/test/suites.h
index 587d6a5b473..08b35b276be 100644
--- a/include/test/suites.h
+++ b/include/test/suites.h
@@ -38,7 +38,6 @@ int do_ut_bootstd(struct cmd_tbl *cmdtp, int flag, int argc,
 int do_ut_bloblist(struct cmd_tbl *cmdtp, int flag, int argc,
 		   char *const argv[]);
 int do_ut_hush(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
-int do_ut_lib(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_loadm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_log(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[]);
 int do_ut_mbr(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index f9cf7b93412..ba101a48b98 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -152,7 +152,7 @@ static struct suite suites[] = {
 	SUITE_CMD(overlay, do_ut_overlay),
 #endif
 #ifdef CONFIG_UT_LIB
-	SUITE_CMD(lib, do_ut_lib),
+	SUITE(lib),
 #endif
 #ifdef CONFIG_UT_LOG
 	SUITE_CMD(log, do_ut_log),
diff --git a/test/lib/Makefile b/test/lib/Makefile
index 3556c4d199c..f38f4947157 100644
--- a/test/lib/Makefile
+++ b/test/lib/Makefile
@@ -6,7 +6,6 @@
 obj-$(CONFIG_$(XPL_)UT_COMPRESSION) += compression.o
 
 ifeq ($(CONFIG_XPL_BUILD),)
-obj-y += cmd_ut_lib.o
 obj-y += abuf.o
 obj-y += alist.o
 obj-$(CONFIG_EFI_LOADER) += efi_device_path.o
diff --git a/test/lib/cmd_ut_lib.c b/test/lib/cmd_ut_lib.c
deleted file mode 100644
index 90a8c0728b7..00000000000
--- a/test/lib/cmd_ut_lib.c
+++ /dev/null
@@ -1,19 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) 2019 Heinrich Schuchardt <xypron.glpk@gmx.de>
- *
- * Unit tests for library functions
- */
-
-#include <command.h>
-#include <test/lib.h>
-#include <test/suites.h>
-#include <test/ut.h>
-
-int do_ut_lib(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	struct unit_test *tests = UNIT_TEST_SUITE_START(lib);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(lib);
-
-	return cmd_ut_category("lib", "lib_test_", tests, n_ents, argc, argv);
-}
-- 
2.34.1

