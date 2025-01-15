Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5235AC02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:36:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9923C808B6;
	Wed, 15 Jan 2025 14:32:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PEqpt65I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71F538092B; Wed, 15 Jan 2025 14:32:04 +0100 (CET)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44AF580702
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:32:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3ce4b009465so24582135ab.0
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 05:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736947920; x=1737552720; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sejEG8lDbX3/Yhi+KrzrV3b4ZTGs5O7z4q4eU4Nhtqs=;
 b=PEqpt65ID385pHKGI5lAuSXzfzHi7T5AdEyePkhxP4eMEMQomWezY03MH7BuCjoMpn
 dqPdJZXuXTBkuHLyX6w0PnG0U1BsuXKNtypPgqLCrtNcJQ7hcFdDHDRW13cXt9Kf6ex1
 Z0PSvdo2wMpJ0vswaG63L42uJsZ2ZUUI/Ih1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736947920; x=1737552720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sejEG8lDbX3/Yhi+KrzrV3b4ZTGs5O7z4q4eU4Nhtqs=;
 b=P6Y6CYg1GIhK9niV6clyR8Qqs4fPaOALLtVn2ertgneW8eJSz78IYz8Dpy8+Qe2IjH
 0e70qAgPilkIf6oXsI0fUwb7ibDrxo6HC3cJpWjIwvNW6PLEaa3Oc00VWvVZlD9XkdAJ
 8iecOad5ecjOUEUuFApz+E+u9lv8i3RH0QAmaH1wB8+pi9R8XEjP/7B4uFHip1p4/MQI
 EF/xZMluCEOCYC+yjcluOi13+pjIBjVYNwXJYuQk7aboowNJWwUCPcborsteYbv6Jhwc
 WyTJ2zPVitFF9qdC5vGT47IdpjVUWlT/uFaxbL//fxMG5o6haBu3FE7/Eyv9GtdwZn/7
 W3rg==
X-Gm-Message-State: AOJu0YzzQfGGyBAi2LmvOJfOOhvlsBO+hfWgI0YAUWOyb5pZia3Gr2rF
 jw63vLNY00nmfks4Q893/ZbvlOIY1XLv5uYpytXZASRsuqTcwBjPjJ7W3k8BtlbIEZfrYNJlj+M
 =
X-Gm-Gg: ASbGncsSwyVDGS/2e8DbBqbd4vobyY8TMMYD/dd6ZSbnjwnR7XmcAu0+nugomkbbSwl
 h7UuEDEqZ+TRInhAhc8Y4z/jDaZ9aLQxS/kfXPVRUXFlxhVpVa2oOel/1/mYLk9WQz5LR2/LniP
 RpFrZbvDaDTTlhxsaENHMJO5bSm8525lXjvv56UPhB6Qz8EcKut3dwiNv7P3I+wLxWd6BoTCaND
 aVczPtZ3liOpwzb8aZRUzpEUkOg2YEBhedrfQbjKoII0kvrrfrFep5Q4WYO1W7ii05w/YqOjpj4
 2JNtjiTuNcfVav5PiA==
X-Google-Smtp-Source: AGHT+IGqJ0mjfFhJ5L/lsjF/eg0qzKFL3vWSNvHMbS7ZZXu7kd6o3LLWIGcX7Cq2EAVLhY2QIz2VyA==
X-Received: by 2002:a05:6e02:2144:b0:3ce:7f8a:8548 with SMTP id
 e9e14a558f8ab-3ce7f8a86b5mr44877435ab.12.1736947920473; 
 Wed, 15 Jan 2025 05:32:00 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm4091248173.20.2025.01.15.05.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 05:31:59 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Massimiliano Minella <massimiliano.minella@se.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 24/43] test: Drop the function for running setexpr tests
Date: Wed, 15 Jan 2025 06:30:54 -0700
Message-Id: <20250115133114.590375-25-sjg@chromium.org>
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

 include/test/suites.h | 2 --
 test/cmd/setexpr.c    | 9 ---------
 test/cmd_ut.c         | 2 +-
 3 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/include/test/suites.h b/include/test/suites.h
index cb6b6fba240..775b0a5a131 100644
--- a/include/test/suites.h
+++ b/include/test/suites.h
@@ -46,8 +46,6 @@ int do_ut_overlay(struct cmd_tbl *cmdtp, int flag, int argc,
 int do_ut_pci_mps(struct cmd_tbl *cmdtp, int flag, int argc,
 		  char *const argv[]);
 int do_ut_seama(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
-int do_ut_setexpr(struct cmd_tbl *cmdtp, int flag, int argc,
-		  char *const argv[]);
 int do_ut_upl(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 
 #endif /* __TEST_SUITES_H__ */
diff --git a/test/cmd/setexpr.c b/test/cmd/setexpr.c
index 49eac5890aa..7f318a42ead 100644
--- a/test/cmd/setexpr.c
+++ b/test/cmd/setexpr.c
@@ -479,12 +479,3 @@ static int setexpr_test_fmt(struct unit_test_state *uts)
 }
 SETEXPR_TEST(setexpr_test_fmt, UTF_CONSOLE);
 #endif
-
-int do_ut_setexpr(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	struct unit_test *tests = UNIT_TEST_SUITE_START(setexpr);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(setexpr);
-
-	return cmd_ut_category("setexpr", "setexpr_test_", tests, n_ents,
-			       argc, argv);
-}
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 4e57fcf0005..c53b24bfde9 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -163,7 +163,7 @@ static struct suite suites[] = {
 #endif
 	SUITE(mem),
 #if defined(CONFIG_SANDBOX) && defined(CONFIG_CMD_SETEXPR)
-	SUITE_CMD(setexpr, do_ut_setexpr),
+	SUITE(setexpr),
 #endif
 #ifdef CONFIG_MEASURED_BOOT
 	SUITE_CMD(measurement, do_ut_measurement),
-- 
2.34.1

