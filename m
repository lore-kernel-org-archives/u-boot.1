Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19258C3DA61
	for <u-boot@archiver.kernel.org>; Sun, 21 Jul 2024 15:27:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBAC487F51;
	Sun, 21 Jul 2024 17:26:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nmaaX3P9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 396248811C; Sun, 21 Jul 2024 17:26:45 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12204880A5
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 17:26:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42793fc0a6dso24500285e9.0
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 08:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721575602; x=1722180402; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UYuwZJIgxlwfHOZYBYL2xm2sC1BLAWH9zxC4CFAVpbE=;
 b=nmaaX3P9Poa8ytpsWL1hqw20qJ3dYTmf/GRUQ5rPlcG4R2TTUTLsvLayXghkCuxkup
 EilvdJLEKlYNfSo29MxCoYJLgLt+JmUMp6h6fC9EERmC1IG9+nImV3A0JSYtFYMylNmv
 A88fFI62ZbezsJM6j0zYG5Sga6xKVycJimxg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721575602; x=1722180402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UYuwZJIgxlwfHOZYBYL2xm2sC1BLAWH9zxC4CFAVpbE=;
 b=h4gJT79RFDrUYNra0ORxpypNkmDvwQF8mVWuzjecDcep90h6SKqwx+9gIBl0ewKmpM
 qEOkikd93v0vxZdaU9GU7revChic780LgOs7XTgc7LzHs9E5RGrzpbbydP2C9+b07Z2p
 0GYbupwUvYh4u3LWC4jWUMZard4KB48nfeKc0jPUO3fGf70MRH5ULOLDnCH2SN4ovJaL
 ggu7b9yiLb+PAC8cjyTthnWQKvkqsg4pGacIg7AOWVqff6IIvRQ+vMakufMPiLD5MtIS
 ynZTEp9H5zoTWNHs+1AuaqR4f9nq3oEHKYSw1Vq9cyAwx5NT1MQwCUhUYFIYzwUE9oC1
 9G4g==
X-Gm-Message-State: AOJu0Yxkouu1QwhO/WefvFVZUMpAQwlxK7PNEr/hHgHs4IPV0sISYzQg
 CNEO1RXBb2HC+u/aAQ7OXW4xd+UhkCt2x45ITJvHt1kKal3uXsH5IopDcQRYLNEiZvyWVKBvBDI
 =
X-Google-Smtp-Source: AGHT+IFPIU1ngRjYKG5+/jMKD4sFYfIG+c7FOeGUXD2CbqUCZE8/3W1m/F549qTGzWQE13pMBEGGwg==
X-Received: by 2002:a05:600c:4ecb:b0:426:58ca:5a3 with SMTP id
 5b1f17b1804b1-427dc576586mr24212075e9.30.1721575602425; 
 Sun, 21 Jul 2024 08:26:42 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427e5803bb0sm8702255e9.45.2024.07.21.08.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 08:26:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 07/14] log: Avoid including function names by default
Date: Sun, 21 Jul 2024 16:25:52 +0100
Message-Id: <20240721152600.3212917-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240721152600.3212917-1-sjg@chromium.org>
References: <20240721152600.3212917-1-sjg@chromium.org>
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

Unless function names are requested, the logging system should not
compile these into the code. Adjust the macros to handle this.

This means that turning on function names at runtime won't work unless
CONFIG_LOGF_FUNC is enabled. We could perhaps split this into a
separate option if that is a problem.

Enable CONFIG_LOGF_FUNC logging for sandbox since the tests expect the
function names to be included. Fix up the pinmux test which checks a
logging statement.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Update commit message to mention the runtime impact
- Leave assert() alone since it is only compiled in with LOG_DEBUG

 common/log_console.c      |  4 ++--
 configs/sandbox_defconfig |  1 +
 include/log.h             | 16 +++++++++++-----
 test/cmd/pinmux.c         |  8 +++++++-
 test/log/log_test.c       |  4 ++--
 5 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/common/log_console.c b/common/log_console.c
index c27101b8fe2..9376baad664 100644
--- a/common/log_console.c
+++ b/common/log_console.c
@@ -38,10 +38,10 @@ static int log_console_emit(struct log_device *ldev, struct log_rec *rec)
 			printf("%d-", rec->line);
 		if (fmt & BIT(LOGF_FUNC)) {
 			if (CONFIG_IS_ENABLED(USE_TINY_PRINTF)) {
-				printf("%s()", rec->func);
+				printf("%s()", rec->func ?: "?");
 			} else {
 				printf("%*s()", CONFIG_LOGF_FUNC_PAD,
-				       rec->func);
+				       rec->func ?: "?");
 			}
 		}
 	}
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index dc5fcdbd1c9..a1a9e174de8 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -39,6 +39,7 @@ CONFIG_PRE_CONSOLE_BUFFER=y
 CONFIG_LOG=y
 CONFIG_LOG_MAX_LEVEL=9
 CONFIG_LOG_DEFAULT_LEVEL=6
+CONFIG_LOGF_FUNC=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_STACKPROTECTOR=y
 CONFIG_CMD_CPU=y
diff --git a/include/log.h b/include/log.h
index fc0d5984472..69dcb339543 100644
--- a/include/log.h
+++ b/include/log.h
@@ -125,7 +125,7 @@ static inline int log_uc_cat(enum uclass_id id)
  * @level: Level of log record (indicating its severity)
  * @file: File name of file where log record was generated
  * @line: Line number in file where log record was generated
- * @func: Function where log record was generated
+ * @func: Function where log record was generated, NULL if not known
  * @fmt: printf() format string for log record
  * @...: Optional parameters, according to the format string @fmt
  * Return: 0 if log record was emitted, -ve on error
@@ -141,7 +141,7 @@ int _log(enum log_category_t cat, enum log_level_t level, const char *file,
  * @level: Level of log record (indicating its severity)
  * @file: File name of file where log record was generated
  * @line: Line number in file where log record was generated
- * @func: Function where log record was generated
+ * @func: Function where log record was generated, NULL if not known
  * @addr:	Starting address to display at start of line
  * @data:	pointer to data buffer
  * @width:	data value width.  May be 1, 2, or 4.
@@ -193,6 +193,12 @@ int _log_buffer(enum log_category_t cat, enum log_level_t level,
 #define _LOG_DEBUG	0
 #endif
 
+#ifdef CONFIG_LOGF_FUNC
+#define _log_func	__func__
+#else
+#define _log_func	NULL
+#endif
+
 #if CONFIG_IS_ENABLED(LOG)
 
 /* Emit a log record if the level is less that the maximum */
@@ -201,7 +207,7 @@ int _log_buffer(enum log_category_t cat, enum log_level_t level,
 	if (_LOG_DEBUG != 0 || _l <= _LOG_MAX_LEVEL) \
 		_log((enum log_category_t)(_cat), \
 		     (enum log_level_t)(_l | _LOG_DEBUG), __FILE__, \
-		     __LINE__, __func__, \
+		     __LINE__, _log_func, \
 		      pr_fmt(_fmt), ##_args); \
 	})
 
@@ -211,7 +217,7 @@ int _log_buffer(enum log_category_t cat, enum log_level_t level,
 	if (_LOG_DEBUG != 0 || _l <= _LOG_MAX_LEVEL) \
 		_log_buffer((enum log_category_t)(_cat), \
 			    (enum log_level_t)(_l | _LOG_DEBUG), __FILE__, \
-			    __LINE__, __func__, _addr, _data, \
+			    __LINE__, _log_func, _addr, _data, \
 			    _width, _count, _linelen); \
 	})
 #else
@@ -314,7 +320,7 @@ void __assert_fail(const char *assertion, const char *file, unsigned int line,
 #define assert_noisy(x) \
 	({ bool _val = (x); \
 	if (!_val) \
-		__assert_fail(#x, "?", __LINE__, __func__); \
+		__assert_fail(#x, "?", __LINE__, _log_func); \
 	_val; \
 	})
 
diff --git a/test/cmd/pinmux.c b/test/cmd/pinmux.c
index 4253baa5646..7ab7004b684 100644
--- a/test/cmd/pinmux.c
+++ b/test/cmd/pinmux.c
@@ -30,7 +30,13 @@ static int dm_test_cmd_pinmux_status_pinname(struct unit_test_state *uts)
 
 	console_record_reset();
 	run_command("pinmux status P9", 0);
-	ut_assert_nextlinen("single-pinctrl pinctrl-single-no-width: missing register width");
+	if (IS_ENABLED(CONFIG_LOGF_FUNC)) {
+		ut_assert_nextlinen(
+			"   single_of_to_plat() single-pinctrl pinctrl-single-no-width: missing register width");
+	} else {
+		ut_assert_nextlinen(
+			"single-pinctrl pinctrl-single-no-width: missing register width");
+	}
 	ut_assert_nextlinen("P9 not found");
 	ut_assert_console_end();
 
diff --git a/test/log/log_test.c b/test/log/log_test.c
index 855353a9c40..d756b96dbac 100644
--- a/test/log/log_test.c
+++ b/test/log/log_test.c
@@ -452,8 +452,8 @@ int log_test_buffer(struct unit_test_state *uts)
 	/* This one should product no output due to the debug level */
 	log_buffer(LOGC_BOOT, LOGL_DEBUG, 0, buf, 1, 0x12, 0);
 
-	ut_assert_nextline("00000000: 00 11 22 33 44 55 66 77 88 99 aa bb cc dd ee ff  ..\"3DUfw........");
-	ut_assert_nextline("00000010: 10 00                                            ..");
+	ut_assert_nextline("     log_test_buffer() 00000000: 00 11 22 33 44 55 66 77 88 99 aa bb cc dd ee ff  ..\"3DUfw........");
+	ut_assert_nextline("     log_test_buffer() 00000010: 10 00                                            ..");
 	ut_assert_console_end();
 	free(buf);
 
-- 
2.34.1

