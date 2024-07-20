Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F17EC3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 06:22:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A67C588C5D;
	Sat, 20 Jul 2024 08:20:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AYdUNa8b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 725B888C47; Sat, 20 Jul 2024 08:20:51 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F79488BFC
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 08:20:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-368663d7f80so1063669f8f.3
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 23:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721456449; x=1722061249; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zBzSzJ441a3jGIsyvMd/IJ4pgpgnY2cbr6bcoKogABs=;
 b=AYdUNa8b3zIa4m+PIAIab3KaSkQ2331F/JhLobWSzPdbrPu93TrZb4cfneDMK8NU+O
 IG/t+DCeT4kUIKuAlnSnv7vjjidt3BS7FfkweBvnTi1x/Sas4gUK52Zuj4MHzMbqAeAY
 nZQs84JAxM5Fqd7IkYlpPwyXekNCP8Tttb0MQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721456449; x=1722061249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zBzSzJ441a3jGIsyvMd/IJ4pgpgnY2cbr6bcoKogABs=;
 b=ERCEMzV8frVHoN9xavRFO3cEXDOdS/Lik4GK+QHRuVmifvb/XoLzmFf+jzJXVaAh2h
 2MSmVoiNB/qVBgiTQ8V07xYKkqAY0MxAkXfY0vYl9+w5geXw2XW+A4d8USIta758tkYT
 WM6sdboZyjkrH9J26zukgsdBtZc5ZFc8eSp2m/lwfGcaPMbnJUMHMVBj8uuno21p4/JS
 weMJncqtII4JWmdJYp+lF4eDErm8HfJ255at7s5HM5GIByH1cyp7R+Bn7wLJ+0yf7Q+g
 P2KoELMZuKSS1n+K0QEWKL8z7ZfQwKuYNM186zq+f4zxl19eJip6douq73VpNKbmhQ6O
 odGA==
X-Gm-Message-State: AOJu0Yya5WApu47v3Ek67T6sowqd6eNQmBQMwHDq+ZC//3nUAyYb8rOn
 sm+ph5mQVbsbvUoaErkpz+3019e1TJreiYW5J3MSDVUYtMOGxkIJwKpuz/lBfAxT+joUyfozoVg
 =
X-Google-Smtp-Source: AGHT+IEXkuomwQVXqqruO88tY9gukevxKfBt9fmjXaDRrqyz8PL6hJmEgG3e9RDQLZa8JJfy35MyUA==
X-Received: by 2002:a05:6000:1b08:b0:367:4e1a:240e with SMTP id
 ffacd0b85a97d-369bb2a1bc4mr321197f8f.50.1721456448673; 
 Fri, 19 Jul 2024 23:20:48 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878684773sm3226281f8f.7.2024.07.19.23.20.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 23:20:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 07/14] log: Avoid including function names by default
Date: Sat, 20 Jul 2024 07:16:59 +0100
Message-Id: <20240720061706.2644229-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240720061706.2644229-1-sjg@chromium.org>
References: <20240720061706.2644229-1-sjg@chromium.org>
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

Enable CONFIG_LOGF_FUNC logging for sandbox since the tests expect the
function names to be included. Fix up the pinmux test which checks a
logging statement.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/log_console.c      |  4 ++--
 configs/sandbox_defconfig |  1 +
 include/log.h             | 18 ++++++++++++------
 test/cmd/pinmux.c         |  8 +++++++-
 test/log/log_test.c       |  4 ++--
 5 files changed, 24 insertions(+), 11 deletions(-)

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
index e2db66d4a25..d43d92d0cf2 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -38,6 +38,7 @@ CONFIG_PRE_CONSOLE_BUFFER=y
 CONFIG_LOG=y
 CONFIG_LOG_MAX_LEVEL=9
 CONFIG_LOG_DEFAULT_LEVEL=6
+CONFIG_LOGF_FUNC=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_STACKPROTECTOR=y
 CONFIG_ANDROID_AB=y
diff --git a/include/log.h b/include/log.h
index fc0d5984472..67b6fd70050 100644
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
@@ -302,7 +308,7 @@ void __assert_fail(const char *assertion, const char *file, unsigned int line,
  */
 #define assert(x) \
 	({ if (!(x) && _DEBUG) \
-		__assert_fail(#x, __FILE__, __LINE__, __func__); })
+		__assert_fail(#x, __FILE__, __LINE__, _log_func); })
 
 /*
  * This one actually gets compiled in even without DEBUG. It doesn't include the
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

