Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1701BC3DA4A
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 13:59:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D18188A5A;
	Thu, 22 Aug 2024 15:58:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PngxbnKH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D41F688A54; Thu, 22 Aug 2024 15:58:18 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB85F88915
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 15:58:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-39d34be8ca2so2858815ab.3
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 06:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724335095; x=1724939895; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zgnMo75DS9vGD677v3Plr4Gpcx2dSLNstFgWqi5y6xU=;
 b=PngxbnKH7FKEZriGwcyX2ZpVUm+1rpkOzV3PfywnyXaBU7qwhB0QGlw2kwfV3Oh6J4
 jRn3Fg5GdAczlEoIkG203ZuVsaWmcuqM5z+IsJU0ueagf3ZkD8WLuGYn0mrTuHw7iqFs
 rbz8wBVhQbXJX8nXfXt+qx7tvORfMsZBvxIlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724335095; x=1724939895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zgnMo75DS9vGD677v3Plr4Gpcx2dSLNstFgWqi5y6xU=;
 b=gXbMQTrsCw8MrmZMNtn11yhWYMkAuP8D7O2HEwZdW5ykYvFUs0tWbo432F8TsPgnBR
 Xp1TYS+85DwF95Isv/Xh+LdsAw9Z+QEVqU45+JmqQSQF5wIHQ27XFxHX6tKjSW+uHMmI
 nThMJlR2JypTEoym3Nm3kENu6ykO1zjMmPG3eGG79VaueTspwBnWoEg+3gJGwhZ1k+S+
 Hogxie4GU9zQuJ+lqTqf7kWWe3yQ9ZeoRFtjYHdDKHeBfIHdpvKa5Q0lyXBXdYTKp+Kw
 hMM/KcMYpqSGyhyP19cC0Y+YVpVjJozjQlcNsJNJLuMA86EmEfvHialP67tO7fUPrnLN
 yCSw==
X-Gm-Message-State: AOJu0YwYKymv2vOTh6gdV7JPHi30eH58iZW+xXYcEU2/foGzoWUW3jdQ
 q1uSyPkkYvFciq15ZAltnm0jJ+WPV+zbyXotlVRioIY5ADRfNMngjWr81E5XI5xv1VNFKlZJS7M
 =
X-Google-Smtp-Source: AGHT+IFUrvnNV4/LceTLD0BHGJUAwSlOLs6xz3VTcj67dkiEbfo8un+9NaNEwLW0CMrvosGP98kA+g==
X-Received: by 2002:a05:6e02:1c42:b0:39d:25a2:7b6b with SMTP id
 e9e14a558f8ab-39d6c34c321mr72271355ab.1.1724335095345; 
 Thu, 22 Aug 2024 06:58:15 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e747eesm6793275ab.29.2024.08.22.06.58.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 06:58:15 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 02/19] test: Fail when an empty line is expected but not
 present
Date: Thu, 22 Aug 2024 07:57:47 -0600
Message-Id: <20240822135804.2375959-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822135804.2375959-1-sjg@chromium.org>
References: <20240822135804.2375959-1-sjg@chromium.org>
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
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---

(no changes since v1)

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

