Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 899C5E677E8
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 19:40:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BA8C89313;
	Sat,  2 Nov 2024 20:38:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZmdPkd7z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AC4288B0B; Sat,  2 Nov 2024 20:38:06 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D329089110
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 20:38:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6cbce16d151so19370966d6.2
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 12:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730576281; x=1731181081; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RTO4ua8knSEqc4zlfp5Yuw+pWQyxhSnyoW0zpbgkUXI=;
 b=ZmdPkd7zgvVv4gIAKLzEW+hI6LaxFF/p8742khgs85jZqtjdR9vDFAs0OddbB7mHMV
 9A4deRkC/c+OMSLOGpoApyhgicb/h48R8WvkHMRVb6hu6IuUNhhxtuXbd0AeGD6Tj/dl
 zw2rfqn58gOceAoGLLdDAjurV4M8INnLOMix4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730576281; x=1731181081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RTO4ua8knSEqc4zlfp5Yuw+pWQyxhSnyoW0zpbgkUXI=;
 b=It63T4wSQyAQhx19I347lu/OTRnlWi65JD2wA6mwcjNdM6IMtC9FEy1URJWutJ+jTL
 FAISEcRnAjv+cznuBGeZMpkkK+4DC/voTkhzLqnDCXfQfiBJUKjBHhSNoEOwVXS41ksX
 Uj6haDCpd22th8qe+hEJ2UKLg2NJZC9AMtMJkEbl1l/0EocsFeAqxw8I7AcZX1rHJvRX
 BVoY+FjRdWq6jBXJ8avLyupC8aPcj9Fdld70VRjSW8C2wJhwilMg5oKDZq2SfY1SOZdD
 FK8zg3kfvAtE/RQCZfWV19eJk9Mq86EA2lPY92NCSH77vGarR50sFcyJCRr13tB6QyZI
 0H/g==
X-Gm-Message-State: AOJu0Yw7KyrBxFHDDuuPDrJYNksm3F0ZBlQ9mgJvNk6M/78sOAH5TnnI
 ITsk3FHF5yQ7i2gcecPBUTkMjR6ihSI1dtlrxPdvVV5Hmfwbs+2weGSlLPlcISppJFigQARjQKt
 numRs
X-Google-Smtp-Source: AGHT+IFcqmGbkL2sFoeeM5GDQC6oyjDCPMBWhjTLhk9ofNwvk5M+IBzD/k5EFOC3Ddu4C7o4jmI+Fw==
X-Received: by 2002:a05:6214:45a1:b0:6c5:8a85:19fe with SMTP id
 6a1803df08f44-6d185876483mr358909376d6.51.1730576281123; 
 Sat, 02 Nov 2024 12:38:01 -0700 (PDT)
Received: from chromium.org ([165.225.8.161]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d353f9dfeasm32324976d6.14.2024.11.02.12.37.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 12:37:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 17/20] test: Move time tests into the lib suite
Date: Sat,  2 Nov 2024 13:37:02 -0600
Message-ID: <20241102193715.432529-18-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241102193715.432529-1-sjg@chromium.org>
References: <20241102193715.432529-1-sjg@chromium.org>
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

There is no particular need for the time tests to have their own test
command. Move them into the lib suite instead.

Update the test functions to match the normal unit-test signature.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/cmd_ut.c   |  6 ------
 test/lib/time.c | 29 ++++++++++-------------------
 2 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index f86757361db..195b7ea50ac 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -99,9 +99,6 @@ static struct cmd_tbl cmd_ut_sub[] = {
 	U_BOOT_CMD_MKENT(setexpr, CONFIG_SYS_MAXARGS, 1, do_ut_setexpr, "",
 			 ""),
 #endif
-#ifdef CONFIG_UT_TIME
-	U_BOOT_CMD_MKENT(time, CONFIG_SYS_MAXARGS, 1, do_ut_time, "", ""),
-#endif
 #ifdef CONFIG_MEASURED_BOOT
 	U_BOOT_CMD_MKENT(measurement, CONFIG_SYS_MAXARGS, 1, do_ut_measurement,
 			 "", ""),
@@ -238,9 +235,6 @@ U_BOOT_LONGHELP(ut,
 	"\nsetexpr - setexpr command"
 #ifdef CONFIG_CMD_SEAMA
 	"\nseama - seama command parameters loading and decoding"
-#endif
-#ifdef CONFIG_UT_TIME
-	"\ntime - very basic test of time functions"
 #endif
 	);
 
diff --git a/test/lib/time.c b/test/lib/time.c
index 149c4b58f4a..2095bef7589 100644
--- a/test/lib/time.c
+++ b/test/lib/time.c
@@ -4,12 +4,13 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <command.h>
 #include <errno.h>
 #include <time.h>
 #include <linux/delay.h>
+#include <test/lib.h>
+#include <test/ut.h>
 
-static int test_get_timer(void)
+static int test_get_timer(struct unit_test_state *uts)
 {
 	ulong base, start, next, diff;
 	int iter;
@@ -42,8 +43,9 @@ static int test_get_timer(void)
 
 	return 0;
 }
+LIB_TEST(test_get_timer, 0);
 
-static int test_timer_get_us(void)
+static int test_timer_get_us(struct unit_test_state *uts)
 {
 	ulong prev, next, min = 1000000;
 	long delta;
@@ -76,8 +78,9 @@ static int test_timer_get_us(void)
 
 	return 0;
 }
+LIB_TEST(test_timer_get_us, 0);
 
-static int test_time_comparison(void)
+static int test_time_comparison(struct unit_test_state *uts)
 {
 	ulong start_us, end_us, delta_us;
 	long error;
@@ -97,8 +100,9 @@ static int test_time_comparison(void)
 
 	return 0;
 }
+LIB_TEST(test_time_comparison, 0);
 
-static int test_udelay(void)
+static int test_udelay(struct unit_test_state *uts)
 {
 	long error;
 	ulong start, delta;
@@ -116,17 +120,4 @@ static int test_udelay(void)
 
 	return 0;
 }
-
-int do_ut_time(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	int ret = 0;
-
-	ret |= test_get_timer();
-	ret |= test_timer_get_us();
-	ret |= test_time_comparison();
-	ret |= test_udelay();
-
-	printf("Test %s\n", ret ? "failed" : "passed");
-
-	return ret ? CMD_RET_FAILURE : CMD_RET_SUCCESS;
-}
+LIB_TEST(test_udelay, 0);
-- 
2.43.0

