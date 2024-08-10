Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEAEAC3DA7F
	for <u-boot@archiver.kernel.org>; Sat, 10 Aug 2024 20:52:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AF42888AB;
	Sat, 10 Aug 2024 22:52:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LshJ9nFX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88093888A0; Sat, 10 Aug 2024 22:52:24 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C5D788881
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 22:52:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-81fda7d7a48so131849339f.3
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 13:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723323141; x=1723927941; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0aWeVxlPsk9/PktGPADIUlhZ0Z89L/OW/ELEF1BycUA=;
 b=LshJ9nFXnuaTfuWjdGH64GhdPqZwMmYRUy18DSznUe7MffPxUKq3PEc6rShbY3ncKc
 5qDpuP99YR8iZDuGbF7HZF7zI1dZvvAmCdSSeIXIvzdyyyZ0jK5uk0a5sHRpKpL37gDp
 8bTAt4Lt7b+vhEoh7qz0ktF5J/t9o6Q9D3OyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723323141; x=1723927941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0aWeVxlPsk9/PktGPADIUlhZ0Z89L/OW/ELEF1BycUA=;
 b=i2qa/hQQH11z72qUtjagu3LXLltH/hhh5qvWQbp0LsFszkMWljDCSL/CET0hXhSM/c
 zxmk9hWItkMI0xF/dmJBP0NaN9SIM65QQTrfeAlaOWUlZSgY3FMkB4JKif9PG4kpDP7J
 nj8lwkEV+7SNrnlW54FRP3AEht+YA8EWDsI2PKAmlIzR5+ZDf+T8sPERsZXfbgISKLw8
 d6RRTT2NIzcGO5rKHCD3RomH8UbzO9wwV0J5jthrV8rxhNO0CxtXpvazPD/hhyJJC3aG
 LbZc5Sq2utXTzl4xBhLAfiWJ39mprChLQS2iJ7OdFf1D/2anjk6fh64X8T3GIPbqXsUq
 gusw==
X-Gm-Message-State: AOJu0Yyfm+9slA/OdoUq7Yn314g/I/5Xv6mBxwn8CSSGBSFg5MMV2iJM
 Yo44Je3/xg41F1b6uegR6TGtxBtVnDcvnX8hpDY3M4mgZUx7CGNmTw3gxNdRvysFP49T6I/RIzo
 =
X-Google-Smtp-Source: AGHT+IFPCawBrb2368Y92zNlzbMA8Q4D+A4zsOP++u2xCMOs1YkFisrwlk4MsDFQRAZbmnDAM9tVWg==
X-Received: by 2002:a05:6602:1493:b0:81f:dcd6:200c with SMTP id
 ca18e2360f4ac-8225eec7816mr710171339f.12.1723323141000; 
 Sat, 10 Aug 2024 13:52:21 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-82266f56333sm82893139f.0.2024.08.10.13.52.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Aug 2024 13:52:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ion Agorria <ion@agorria.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH 02/21] test: Fail when an empty line is expected but not
 present
Date: Sat, 10 Aug 2024 14:51:46 -0600
Message-Id: <20240810205205.3403177-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240810205205.3403177-1-sjg@chromium.org>
References: <20240810205205.3403177-1-sjg@chromium.org>
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

The existing implementation of ut_assert_nextline_empty() cannot
distinguish between an empty line and no line at all. It can in fact be
called at the end of the recorded output and will happily return
success.

Adjust the logic so that this condition is detected. Show a failure
message in this case.

Fix the one test which falls foul of this fix.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: 400175b0a7d ("test: Add a way to check each line of console...")
---

 common/console.c     | 2 ++
 include/console.h    | 2 +-
 test/boot/bootflow.c | 2 --
 test/ut.c            | 8 +++++---
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/common/console.c b/common/console.c
index 63f78004fdb..85f627297ed 100644
--- a/common/console.c
+++ b/common/console.c
@@ -845,6 +845,8 @@ int console_record_readline(char *str, int maxlen)
 {
 	if (gd->flags & GD_FLG_RECORD_OVF)
 		return -ENOSPC;
+	if (console_record_isempty())
+		return -ENOENT;
 
 	return membuff_readline((struct membuff *)&gd->console_out, str,
 				maxlen, '\0', false);
diff --git a/include/console.h b/include/console.h
index 2617e160073..6b6d0f9de73 100644
--- a/include/console.h
+++ b/include/console.h
@@ -73,7 +73,7 @@ int console_record_reset_enable(void);
  * @str: Place to put string
  * @maxlen: Maximum length of @str including nul terminator
  * Return: length of string returned, or -ENOSPC if the console buffer was
- *	overflowed by the output
+ *	overflowed by the output, or -ENOENT if there was nothing to read
  */
 int console_record_readline(char *str, int maxlen);
 
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 8b46256fa48..8bfc2a1b9b4 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -1151,8 +1151,6 @@ static int bootflow_cmdline(struct unit_test_state *uts)
 
 	ut_asserteq(0, run_command("bootflow cmdline set mary abc", 0));
 	ut_asserteq(0, run_command("bootflow cmdline set mary", 0));
-	ut_assert_nextline_empty();
-
 	ut_assert_console_end();
 
 	return 0;
diff --git a/test/ut.c b/test/ut.c
index ae99831ac8f..7454da3e001 100644
--- a/test/ut.c
+++ b/test/ut.c
@@ -59,9 +59,11 @@ static int readline_check(struct unit_test_state *uts)
 		ut_fail(uts, __FILE__, __LINE__, __func__,
 			"Console record buffer too small - increase CONFIG_CONSOLE_RECORD_OUT_SIZE");
 		return ret;
+	} else if (ret == -ENOENT) {
+		strcpy(uts->actual_str, "<no-more-output>");
 	}
 
-	return 0;
+	return ret;
 }
 
 int ut_check_console_line(struct unit_test_state *uts, const char *fmt, ...)
@@ -79,8 +81,8 @@ int ut_check_console_line(struct unit_test_state *uts, const char *fmt, ...)
 		return -EOVERFLOW;
 	}
 	ret = readline_check(uts);
-	if (ret < 0)
-		return ret;
+	if (ret == -ENOENT)
+		return 1;
 
 	return strcmp(uts->expect_str, uts->actual_str);
 }
-- 
2.34.1

