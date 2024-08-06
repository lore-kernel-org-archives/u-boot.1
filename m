Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4843C49EA1
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 13:00:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76A3E88A34;
	Tue,  6 Aug 2024 14:59:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Kek7FwB0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA46287EED; Tue,  6 Aug 2024 14:59:33 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D011E88A4B
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 14:59:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-39adbfafde5so2435415ab.0
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 05:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722949166; x=1723553966; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VHucv9SvIxlH9ZUiFfnyDS+E5Bs/v1DYrZK8hA8K99E=;
 b=Kek7FwB0oAQrFBAk1/4WoaUrAcYVyMSwhdqpAgBTbRhzY9hpuUS/pN24fhSH8WHlvx
 2yY7+aYvGxOTwk5Loy8OnAuKTccS2t48hRAiVzoEEgZ+H3mhUFhS26hzwaLRMcrCGO+O
 +zYAt96QeDOXP9lgRWPXgJF7UIeUKbWWE1XPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722949166; x=1723553966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VHucv9SvIxlH9ZUiFfnyDS+E5Bs/v1DYrZK8hA8K99E=;
 b=ZGoRiTGGwTuGtj8quss2rOxbdic+MWNjZNpK3C66/TUgzZtP8ILsEYB74YteG1bsyJ
 FH2qnM9WAcY+C0hBcefyokk//5fwy1GAEYXK3+tc7rQeQZgRVmkqkmCUIEblrErY6iJk
 jtZXXEK2gv6NkCw+60SDR7o8mVC4Qi9X9TNzh957S5QouRJn3BRlFrjCMJp26YR1XW2e
 Sa66B3/H3pYfuuNVgCEBd/pJ5sEoWVaxVu5KKFtSnnoDt23CcK2h6fqPhJkk3QWYA8EA
 0E7Knh0dQ6asNsSsJrXyehbdG8xwL6kbNL2i01bqH+20pho95qLdNanYJ5JqUg7x+kN/
 dQBQ==
X-Gm-Message-State: AOJu0YwHlZlIJ4l7wpYKLoV7LcSPRDOwbdfoIiCEodpakvzdJoUR2qOS
 J2sRFpJfzLJWheDc5w+VxEDwgulEdoPu35pX5GGrc17OiGHkF3NgPzhAyvJwrr8eyFfHvWasThY
 =
X-Google-Smtp-Source: AGHT+IG6NzUAqMfp30DDJAqhbbBNqyeCdQpvCOoo/IMRnHpn3LudUSUB6XD1vpT0xGWzJMT4g7gCZQ==
X-Received: by 2002:a92:c0d1:0:b0:374:9c67:1df6 with SMTP id
 e9e14a558f8ab-39b1fc23546mr151304285ab.22.1722949165827; 
 Tue, 06 Aug 2024 05:59:25 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20ab5ccdsm36871565ab.40.2024.08.06.05.59.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 05:59:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Ion Agorria <ion@agorria.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Subject: [PATCH v2 08/39] log: Add a new log category for the console
Date: Tue,  6 Aug 2024 06:58:19 -0600
Message-Id: <20240806125850.2316956-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806125850.2316956-1-sjg@chromium.org>
References: <20240806125850.2316956-1-sjg@chromium.org>
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

Add a new category which covers the console, including the stdio
drivers.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/console.c | 2 ++
 common/log.c     | 1 +
 include/log.h    | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/common/console.c b/common/console.c
index 63f78004fdb..034942ec4a9 100644
--- a/common/console.c
+++ b/common/console.c
@@ -4,6 +4,8 @@
  * Paolo Scaffardi, AIRVENT SAM s.p.a - RIMINI(ITALY), arsenio@tin.it
  */
 
+#define LOG_CATEGORY	LOGC_CONSOLE
+
 #include <console.h>
 #include <debug_uart.h>
 #include <display_options.h>
diff --git a/common/log.c b/common/log.c
index dfee250b158..b83a6618900 100644
--- a/common/log.c
+++ b/common/log.c
@@ -31,6 +31,7 @@ static const char *const log_cat_name[] = {
 	"event",
 	"fs",
 	"expo",
+	"console",
 };
 
 _Static_assert(ARRAY_SIZE(log_cat_name) == LOGC_COUNT - LOGC_NONE,
diff --git a/include/log.h b/include/log.h
index fc0d5984472..2b86c7da3d4 100644
--- a/include/log.h
+++ b/include/log.h
@@ -104,6 +104,8 @@ enum log_category_t {
 	LOGC_FS,
 	/** @LOGC_EXPO: Related to expo handling */
 	LOGC_EXPO,
+	/** @LOGC_CONSOLE: Related to the console and stdio */
+	LOGC_CONSOLE,
 	/** @LOGC_COUNT: Number of log categories */
 	LOGC_COUNT,
 	/** @LOGC_END: Sentinel value for lists of log categories */
-- 
2.34.1

