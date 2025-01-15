Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24EFDC02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:35:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99F6180A4F;
	Wed, 15 Jan 2025 14:32:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l8nXA/hV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45F2280808; Wed, 15 Jan 2025 14:32:00 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6142808B6
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:31:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-844e12f702dso224536239f.3
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 05:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736947916; x=1737552716; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g4PnMHf1J5jOR0UA/RcFQd6bz/C2WYrTzQ0GngKQK6I=;
 b=l8nXA/hVCozJOe5vRUgT0hHjN/LwPqPgkFrVmvLmthsuFoOM4O9Qft4EHezUR6p5jN
 zUEYT20XCjJYXYyHumiuwmqo11qF4AySJd3m8coUhtQuRM0qFzasRxk2hvwH4J/xL2C4
 WWuUaR8OEbgcGimIWsTpS3jcRTADsJXE+HK6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736947916; x=1737552716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g4PnMHf1J5jOR0UA/RcFQd6bz/C2WYrTzQ0GngKQK6I=;
 b=Qr5YpG+crEC+DVLjv/Bs8xsU0E2W3g6Gk/87LuevyVhczH9IKB+b8lYB3kL5uWWAyb
 pZMDfaArF7NaQpfx7v1xLWsC7Vk7nzqOvgbnOiklG1P7GcTsd78ThzXAKMYzR8cK3y07
 Wl9H2mWUeGmrl52Jq8Itv89To/+uW/P5GueiBunWZ08oLqDAXK8io7rE9S/YnAYtGYOV
 yMpLaWv2QL5QFp7mckxkq4OjYanSc0fml/IPB65xQHKs68QyPH+3de9DtQLMzx0+MuDN
 tVT5F74HvGZuhKSrmr3kef06+jUR2pCWewuQs1abNrx3MAqPI+gqvYoUG5Sc5kbVSuxY
 A+6A==
X-Gm-Message-State: AOJu0YzAID2gDH0GIyibGFgN4/tfBs439ionx+EIOrBftqt4zFyiUgY/
 zOZ525eWOcWxKF+qSh/05TxsvTUTkrLNYVcOiXJlpFFdUMIGJ3JiFXEvdcasq9zKjkyc/oE/7Yo
 =
X-Gm-Gg: ASbGnctP49jo036XbuJb9au3acD0wvbuAAG06Kc1ld+J8cuV/XsJLi1FXIcQOIv3PlO
 X7X269xkPDK5jnIJZhGfIcoIqf1EcUsX19XfXsEUixUo0+dQPjIkMAkz77OyumShXwsGbPmqpto
 z5oON5UzPnEwgpRAxZGXGjg8Mio3dLRIdt7W/RtgAH2AafJ2GZhyWrnRBCcWdT7x2TJyoQbxrK7
 U4hJ+c+9zs3rUs0Mo6BWq6eBgNltyYZiuGxgN5XYWmbM5tgikwT8ZgKdr8UiyqBfKCrE82tYWVU
 IQo3So8eIqE2RyjMZQ==
X-Google-Smtp-Source: AGHT+IGys8Fug5yjsOtzO75FqUh4aU3Zi/mL63p5DmmPXPHMY90qQsFSIDjnaRg7GgjbtY2OEFilBw==
X-Received: by 2002:a05:6602:c85:b0:843:e908:db0b with SMTP id
 ca18e2360f4ac-84ce01e9accmr2246058839f.10.1736947915754; 
 Wed, 15 Jan 2025 05:31:55 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm4091248173.20.2025.01.15.05.31.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 05:31:54 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 21/43] test: Drop the function for running log tests
Date: Wed, 15 Jan 2025 06:30:51 -0700
Message-Id: <20250115133114.590375-22-sjg@chromium.org>
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
index ba101a48b98..c490498b4c5 100644
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
2.34.1

