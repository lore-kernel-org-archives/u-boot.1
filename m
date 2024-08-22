Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5402FC3DA4A
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 13:57:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBC3B88A37;
	Thu, 22 Aug 2024 15:55:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SguS4Ffs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEC35888C6; Thu, 22 Aug 2024 15:55:36 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15BA288969
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 15:55:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-39d4161c398so3774445ab.3
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 06:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724334933; x=1724939733; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/QEQKTPdWTP6kjNe8iZhNkLrA05djI6UaoHWfI+/xZE=;
 b=SguS4FfsTrniqkXbuzSUvyci4d880KfjRTgiPsA2jx4vp6ji0Qz2jcGyP0scWvRZum
 5+jwq/UQEtIvHHjETuy3pRU9xqPRKhIX9tz7TDYwSwBV07CqIUfXwSNebreb03TRaroI
 ats+RdTF9AvUj1aVdCXru6e8WhKK45xFeRfJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724334933; x=1724939733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/QEQKTPdWTP6kjNe8iZhNkLrA05djI6UaoHWfI+/xZE=;
 b=Ykgp/NOke255wPU/r+jDxOP5Eg9D6r6F2TRqddJIfYqv9OjTTdE78SypI1Is34/OvG
 931heEF5DrK5wIQYOnsGYmMOAyzaLNq6z4uAxMRg1gtKvk+Uz8X6oMz+OpB/ufUzq5iz
 LhkO0KOTMTcaq+8cvO1EaIKZvF+Cc8xIicxEXLE7p8edpGjeSMdib77buXiPYteOsYzA
 Sv4Vs2wxkhH2WGdKeL1fY3Ms3HjtWNDn1rSzLEHoX7qqJLI+VCTzM4ROWBj7X/ShrlIT
 Df1gZNXGd35CliOdYHE9a7Qeosqn+DT8rDz3LNjpxmS4U5aSnffOp3TujhYF5kMXU8kl
 J9vA==
X-Gm-Message-State: AOJu0YzxdxAX4gtqHQWrMlLm9XHwcWSwWLMhxwD4nOhGbSGOJ/GZk56f
 uSsKZHLw0QTH1o6/ffyNSAxxuSxyvUAGFLyvlXoAvD0siMv73yyeRwwqHZ9mclYxlUMwKCuidqI
 =
X-Google-Smtp-Source: AGHT+IHxFmb95dtwvh/c7i21FGogjyvaWV9ZIvmScpRzQML6K2GjHRPdqVRoIcKowfL41zHnA1bZ2Q==
X-Received: by 2002:a05:6e02:1c08:b0:39d:4976:6772 with SMTP id
 e9e14a558f8ab-39d6c3c4950mr69693905ab.23.1724334932685; 
 Thu, 22 Aug 2024 06:55:32 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e7c1eesm6692585ab.39.2024.08.22.06.55.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 06:55:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v4 07/14] log: Avoid including function names by default
Date: Thu, 22 Aug 2024 07:54:56 -0600
Message-Id: <20240822135503.2363706-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822135503.2363706-1-sjg@chromium.org>
References: <20240822135503.2363706-1-sjg@chromium.org>
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
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

(no changes since v3)

Changes in v3:
- Fix up log_syslog.c too

Changes in v2:
- Update commit message to mention the runtime impact
- Leave assert() alone since it is only compiled in with LOG_DEBUG

 common/log_console.c      |  4 ++--
 common/log_syslog.c       |  2 +-
 configs/sandbox_defconfig |  1 +
 include/log.h             | 16 +++++++++++-----
 test/cmd/pinmux.c         |  8 +++++++-
 test/log/log_test.c       |  6 ++++--
 6 files changed, 26 insertions(+), 11 deletions(-)

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
diff --git a/common/log_syslog.c b/common/log_syslog.c
index d01bb749c22..0dcb5f7cdea 100644
--- a/common/log_syslog.c
+++ b/common/log_syslog.c
@@ -88,7 +88,7 @@ static int log_syslog_emit(struct log_device *ldev, struct log_rec *rec)
 	if (fmt & BIT(LOGF_LINE))
 		append(&ptr, msg_end, "%d-", rec->line);
 	if (fmt & BIT(LOGF_FUNC))
-		append(&ptr, msg_end, "%s()", rec->func);
+		append(&ptr, msg_end, "%s()", rec->func ?: "?");
 	if (fmt & BIT(LOGF_MSG))
 		append(&ptr, msg_end, "%s%s",
 		       fmt != BIT(LOGF_MSG) ? " " : "", rec->msg);
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 484f9e1bf8d..a50fbce8d06 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -40,6 +40,7 @@ CONFIG_PRE_CONSOLE_BUFFER=y
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
index 855353a9c40..7ef89941d42 100644
--- a/test/log/log_test.c
+++ b/test/log/log_test.c
@@ -452,8 +452,10 @@ int log_test_buffer(struct unit_test_state *uts)
 	/* This one should product no output due to the debug level */
 	log_buffer(LOGC_BOOT, LOGL_DEBUG, 0, buf, 1, 0x12, 0);
 
-	ut_assert_nextline("00000000: 00 11 22 33 44 55 66 77 88 99 aa bb cc dd ee ff  ..\"3DUfw........");
-	ut_assert_nextline("00000010: 10 00                                            ..");
+	ut_assert_nextline(
+		"     log_test_buffer() 00000000: 00 11 22 33 44 55 66 77 88 99 aa bb cc dd ee ff  ..\"3DUfw........");
+	ut_assert_nextline(
+		"     log_test_buffer() 00000010: 10 00                                            ..");
 	ut_assert_console_end();
 	free(buf);
 
-- 
2.34.1

