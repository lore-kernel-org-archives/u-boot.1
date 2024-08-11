Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DEB2C3DA4A
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 12:31:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 475FC887E8;
	Sun, 11 Aug 2024 14:29:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MrvFgzJd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E8C08885E; Sun, 11 Aug 2024 14:29:44 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6232884CA
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 14:29:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-81f86fd93acso128506539f.1
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 05:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723379380; x=1723984180; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1zH36sy6MVcJSzy9Uy7LVElpuI2a9vtsSzwhRZiWGQE=;
 b=MrvFgzJd81P/JBQMhCRZRf38Pq4sTja1p0UsEjcqnIKxQW/ZqTeZxWhVmVyoE5jIvV
 SjdGSi+6jQJfY65StYXH1vuM3qz65wygN1Ee0ei5FttVEZSadzE2hDJKH2r8H9GwguJJ
 8nTJRcNycgzXRUEEylNh4Dk0Rck+lMx9MVPag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723379380; x=1723984180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1zH36sy6MVcJSzy9Uy7LVElpuI2a9vtsSzwhRZiWGQE=;
 b=iQgwUZnnsgZereUTP/QW1M5LNBVJ6NBBgODCEFFG04/TBK4YnuKp/EPDCeY7Clhm8y
 17poR2/2lOm9ATC5h58qlOSn4/O8qj2ddkOUY51W5e1ZXTOG+wXYrlxVSbTf2HhJn95H
 71G5jCeT3xyvc44KxYTbxiJcTQuzw6Hzq80DE1UT8HDRuAg5BEy2pRNNBhv0D1ZjX6x7
 bMPfN2Bk4oZMFxkwZLpsXHZ9bs74y/sgscZatRC4nELaBI9wVeYuTMbsbSwrwiHyJOvc
 PJ4Au49D3bmkQA3CgJPXwBNZsVxKAdiFfwN/EDVo9rXHnPzR1OKlNxGqODDzAyiw2No/
 SxVw==
X-Gm-Message-State: AOJu0YyczJEQNgKhUdjjn0tpECEJA03O/j8S4PFOfPwMXmpzGPhuAr84
 4BBKRqOa/xAXKu+pEj1O1pqQDcrdezLv7WuNOlqWqMJZXhBZORNn6ufwiqqy4PFN+5DB+ckWOq0
 =
X-Google-Smtp-Source: AGHT+IGRm4txmY1XCn6RONSSYx4eiVap9z5iz6gvh2YWvmn2cjH55AaZ0LQdxRrCEz7TRalnY2O3SA==
X-Received: by 2002:a5e:dd49:0:b0:7fb:c0c8:2fc7 with SMTP id
 ca18e2360f4ac-822546b0cccmr1089532139f.3.1723379380377; 
 Sun, 11 Aug 2024 05:29:40 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ca76940448sm1017935173.45.2024.08.11.05.29.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 05:29:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 08/15] log: Avoid including function names by default
Date: Sun, 11 Aug 2024 06:29:17 -0600
Message-Id: <20240811122924.4035982-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811122924.4035982-1-sjg@chromium.org>
References: <20240811122924.4035982-1-sjg@chromium.org>
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

(no changes since v2)

Changes in v2:
- Fix up log_syslog.c too
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

