Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FAF2C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:29:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A81EA80882;
	Mon, 20 Jan 2025 22:27:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KA/FZdLr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 566C280818; Mon, 20 Jan 2025 22:27:01 +0100 (CET)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B6ED800C2
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:26:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3ce7f6fdd2aso40039655ab.3
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737408417; x=1738013217; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xKi1UFnNzx2bFKyg4M8Yx0z0h2HyOKTqI5B925/7Juc=;
 b=KA/FZdLrvQK2G02RIx/HS/Z6MTOeb9UZBzKSN8dhIwXt9XtnFeJK6Cc1qWDnDELPF6
 aRtMqUJ+MmqL+QQ7BqY76koqEJXNWf0sadKQ6aGKqdj/qnlHajNOZEctpUxk9HfKOU+X
 CKA7dSu77WiSpGaeDciPPzdqIhslDjEQpTdV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737408417; x=1738013217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xKi1UFnNzx2bFKyg4M8Yx0z0h2HyOKTqI5B925/7Juc=;
 b=Ugqtp4wjyEqUf6FwOJat5CvVCmGoNDpmMmsYJYuwXdceZPROIelJOr2Pr+hIGZln+K
 NdfMtpL02kIBKEfmCCkhAjD4WWtab0eDr6LCbL4s+uXTlcWv3iHuWDX+23hDPo93Khtr
 BqBtmelAEiQzmDhOIEF47fLtcbEyxw5V6eDKyk7BBoplgfLjjqasIY7JA0xVt/I5A6e+
 SO0Z0DyXLk+TV0J+tjSQo1gp3waOVr7V7tBl9lp6ylg+7zRr7Oup9G5grEY12WA/MvXB
 vwPXiQyx+dqSGy73AGqq50zaostFU8vmPh7neP1H3bHooRcXy5NX+DmiY/ylXOCPxLBb
 taMg==
X-Gm-Message-State: AOJu0YwdOKPPKu1XsPyxpd2UWr/X4XrixZR2exww2bdsLQ57YRNZNWT4
 O5rVTFSqYpOgU3BA6lGM/KDYqs84Lqo0/0S/+gugLruL+SfKBOc6rKOohSlamvRTGbmZ3VQwN3k
 =
X-Gm-Gg: ASbGncvH6P1XMFi1WM9cGBkjXOrHNd/sLBtt+G23K1nAi6JbKz8CYtivHJp4FnyrMUM
 SNv89GveAxA2OD/KaId/QyKDv6C3CnM2zbCg0iSo2vCb1PCA9udNNQnYBlWv3LirQi0jXywPxya
 nvr02/EgSKd+ErKSK3Sp4/EieVSMdUhoYcIAJ54WK2Co9EY2o4S3ua8mA9M33D+F90VMq8+Czsm
 njgEp6mmTw2NqemoAaVsLLVsE457tZc9CLzr5qTciOt6l1/AfTkkf6egSJ4WNnv27uWJl41ADK8
 iq/VV3IEEa6aUIKZ6jfms/0mucHbFNQ=
X-Google-Smtp-Source: AGHT+IGzvlTNCflBsO0mXwjH/QMvNFATOHqCXMdSaZBhqrEXS681WepJhKpdjfenqR8UIKcqPfWH3g==
X-Received: by 2002:a05:6e02:1686:b0:3a7:4826:b057 with SMTP id
 e9e14a558f8ab-3cf744b4338mr136327735ab.21.1737408417347; 
 Mon, 20 Jan 2025 13:26:57 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea75440a24sm2847693173.33.2025.01.20.13.26.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:26:56 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Ravi Minnikanti <rminnikanti@marvell.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 16/44] test: Drop the function for running env tests
Date: Mon, 20 Jan 2025 14:25:38 -0700
Message-ID: <20250120212613.516664-17-sjg@chromium.org>
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

 include/test/suites.h | 1 -
 test/cmd_ut.c         | 2 +-
 test/env/cmd_ut_env.c | 9 ---------
 3 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/include/test/suites.h b/include/test/suites.h
index 414613c593e..b78436fe2b2 100644
--- a/include/test/suites.h
+++ b/include/test/suites.h
@@ -37,7 +37,6 @@ int do_ut_bootstd(struct cmd_tbl *cmdtp, int flag, int argc,
 		  char *const argv[]);
 int do_ut_bloblist(struct cmd_tbl *cmdtp, int flag, int argc,
 		   char *const argv[]);
-int do_ut_env(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_exit(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_fdt(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_font(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index a0905ec54b7..155b187ad4b 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -136,7 +136,7 @@ static struct suite suites[] = {
 	SUITE(dm),
 #endif
 #if defined(CONFIG_UT_ENV)
-	SUITE_CMD(env, do_ut_env),
+	SUITE(env),
 #endif
 	SUITE_CMD(exit, do_ut_exit),
 #ifdef CONFIG_CMD_FDT
diff --git a/test/env/cmd_ut_env.c b/test/env/cmd_ut_env.c
index 332139bb803..81d1bb2f80d 100644
--- a/test/env/cmd_ut_env.c
+++ b/test/env/cmd_ut_env.c
@@ -4,7 +4,6 @@
  * Joe Hershberger, National Instruments, joe.hershberger@ni.com
  */
 
-#include <command.h>
 #include <test/env.h>
 #include <test/suites.h>
 #include <test/ut.h>
@@ -74,11 +73,3 @@ static int env_test_env_cmd(struct unit_test_state *uts)
 	return 0;
 }
 ENV_TEST(env_test_env_cmd, UTF_CONSOLE);
-
-int do_ut_env(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	struct unit_test *tests = UNIT_TEST_SUITE_START(env);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(env);
-
-	return cmd_ut_category("env", "env_test_", tests, n_ents, argc, argv);
-}
-- 
2.43.0

