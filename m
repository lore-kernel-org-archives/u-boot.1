Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB215C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:29:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C3A080834;
	Mon, 20 Jan 2025 22:27:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hyMhMi8J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4814808B6; Mon, 20 Jan 2025 22:27:10 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72F49807B6
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:27:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-844d5444b3dso172090839f.1
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737408427; x=1738013227; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DNC18uYvZRVkG1E01/X2Q/P1/i5tUwlCrrTMjikMdXk=;
 b=hyMhMi8JuPd1saBy1Sab07VuxaX5ffcumjfBMYgiE5I9Sp0ckSF2ZKi7vu3O/hnyV/
 II3LmVosL3qc1V642YHP5949Q3tZqk/eRAXwCUQoj3G0VWcVd9IA22ZdP3P1nU9eM3MD
 NSHdYw1cX7+qUygnRvVnwQHo342pWHMCAKdng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737408427; x=1738013227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DNC18uYvZRVkG1E01/X2Q/P1/i5tUwlCrrTMjikMdXk=;
 b=Dag+Fk243l9cyu7Hy+av7ViiI7XmQuAl10fRwgvqKcCZaGPhR19b3gEtugBDALPVaA
 MElvnVCXd7/NbAocmvLE2EN2/I6x/QnR32FJZBpPzwZE3+pDQtc6FXsGnSa8o+651Fgq
 +l5HxQz5WKwx+u9caKYhBAaEhTY2NwmtU1gb48JFZIoWg51Xb7Dn8HoSbeqEYBd/0x/Y
 hTpw/LqK/NFCeaYhZi8e6X6Cn+hQwQqGUqmlOz/jB/Re970yFsQAtl2LUveSTql5LyUM
 WfwitJXBf64Q5Ojs91AeFYv/zIBJSNnhxK/lsrD4hXv3b4TQP+UBvk3x0v84ktR9dCao
 p83w==
X-Gm-Message-State: AOJu0YyklRkHEpkL5Wo6L+GPsYiiPTjDMu2nmiaLexqIcSXTKWI0LJ4a
 UoDi+O9KpJs5RjwS8048YGfsdDJ4rMr5xv8fnsyq5yshUlOrdDSU+/sQiKLG0KKYO1Bt33UITtI
 =
X-Gm-Gg: ASbGncusvM3TGq4jrm2D1qy7XHDYWMo/GCw917s9hFk3TY5TELW8XPS2OXqgzyobplF
 rZ/EA6jaKtItLvAT2/RjFMy9rdKEX+muiGIalZAChKh1sS9M5+0vm1VrFhgRP+fjcm//nAxSwhq
 0VVFhy9PkuJ+zDyuljkWjD9CY8TqA40Crq1Ns2/U6sE7LjMRMK7TR0a7SJ5m+msdsw2JCPt4NYR
 uq/BMRxkU9aFMDM3NZanZHwLKyu0+1zZsMHiEJqUu9CT8jVoKqxcCRJocsp7R74vpy32968tCj3
 MGkUxjPTEmuopUlM5lqPh0kC7izOXX8=
X-Google-Smtp-Source: AGHT+IGB8BvNTrOgs3nSa2EtJcNl+imefaKBR+Negu+FBs11IOAfi2rkrn9BGF+KW4c5xh6jgQga8g==
X-Received: by 2002:a05:6602:4745:b0:835:39a8:e201 with SMTP id
 ca18e2360f4ac-84f67175a09mr2040820039f.0.1737408426689; 
 Mon, 20 Jan 2025 13:27:06 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea75440a24sm2847693173.33.2025.01.20.13.27.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:27:05 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 21/44] test: Drop the function for running log tests
Date: Mon, 20 Jan 2025 14:25:43 -0700
Message-ID: <20250120212613.516664-22-sjg@chromium.org>
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
 test/log/Makefile     |  2 --
 test/log/log_ut.c     | 20 --------------------
 4 files changed, 1 insertion(+), 24 deletions(-)
 delete mode 100644 test/log/log_ut.c

diff --git a/include/test/suites.h b/include/test/suites.h
index 08b35b276be..72f98eb3558 100644
--- a/include/test/suites.h
+++ b/include/test/suites.h
@@ -39,7 +39,6 @@ int do_ut_bloblist(struct cmd_tbl *cmdtp, int flag, int argc,
 		   char *const argv[]);
 int do_ut_hush(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_loadm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
-int do_ut_log(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[]);
 int do_ut_mbr(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_measurement(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[]);
 int do_ut_mem(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 27d090c7225..a196702dd17 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -155,7 +155,7 @@ static struct suite suites[] = {
 	SUITE(lib),
 #endif
 #ifdef CONFIG_UT_LOG
-	SUITE_CMD(log, do_ut_log),
+	SUITE(log),
 #endif
 #if defined(CONFIG_SANDBOX) && defined(CONFIG_CMD_MBR) && defined(CONFIG_CMD_MMC) \
         && defined(CONFIG_MMC_SANDBOX) && defined(CONFIG_MMC_WRITE)
diff --git a/test/log/Makefile b/test/log/Makefile
index 08eea70e344..24b7c46786d 100644
--- a/test/log/Makefile
+++ b/test/log/Makefile
@@ -7,8 +7,6 @@ obj-$(CONFIG_CMD_LOG) += log_filter.o
 
 ifdef CONFIG_UT_LOG
 
-obj-y += log_ut.o
-
 ifdef CONFIG_SANDBOX
 obj-$(CONFIG_LOG_SYSLOG) += syslog_test.o
 obj-$(CONFIG_LOG_SYSLOG) += syslog_test_ndebug.o
diff --git a/test/log/log_ut.c b/test/log/log_ut.c
deleted file mode 100644
index 2aa3afe286a..00000000000
--- a/test/log/log_ut.c
+++ /dev/null
@@ -1,20 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (c) 2020, Heinrich Schuchardt <xypron.glpk@gmx.de>
- *
- * Logging function tests.
- */
-
-#include <console.h>
-#include <log.h>
-#include <test/log.h>
-#include <test/suites.h>
-
-int do_ut_log(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
-{
-	struct unit_test *tests = UNIT_TEST_SUITE_START(log);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(log);
-
-	return cmd_ut_category("log", "log_test_",
-			       tests, n_ents, argc, argv);
-}
-- 
2.43.0

