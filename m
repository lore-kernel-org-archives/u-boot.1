Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C47C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:30:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD3E9809D0;
	Mon, 20 Jan 2025 22:27:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="k5pPSjhP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20F6980711; Mon, 20 Jan 2025 22:27:18 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E04EA801CF
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:27:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-844e161a957so391602539f.0
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737408434; x=1738013234; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BzXSsfgUonNeifAiiw3lXc9kvPR1NzRDo7HCYU8wXR0=;
 b=k5pPSjhP1+maEchgC+UEPQmYP8ojMLEc36HK8MEEDjhovtJWhoH/aeDfbtI5Rns+1R
 q/3ZI6ZUwTskdJizOO++ZmZbFSCngt6dFBYtIf6IMQzq6jnlxab0OzBb9bqhdhlc817N
 +3JllTCr4JJSDr2z3PeWqgdkYX/wmzcYTZ0v8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737408434; x=1738013234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BzXSsfgUonNeifAiiw3lXc9kvPR1NzRDo7HCYU8wXR0=;
 b=h9ZR/Zj7hNvqhNbyYzTYjGfbQJUtLBtDI74gPujN1mF7wshC2DCsvbZ41Axh5ezm0+
 mr5VFKlpk9f8dAUguYKi3PolTLAsSDBTMe4wDSVyQk93wH2I6HlMtDdGVB23gTMbOpqe
 9WknTGVLw2RpoynVrOOCJZjb9kZDYpdXEESaNHsB4BWJ471+Du9OMUrE8HzMS72gDQC6
 nRc8hCU7Zf6OBpdjAlxoAwO/R1HdEO92I0LDNv9hwJ8umnEAeLS9TvEwD8TYU7Ri6bXy
 bvTsGSqQie3NTXLLt+4nYAGO58/piToU6YumJF6b5xJwizEDazi19Zxz399/o8nMLm5g
 LSuA==
X-Gm-Message-State: AOJu0YxZlkTSssejDWEaHspdJNJTkAdicb86Fp+l0Ob3G9RtpUTaNb0I
 2uRJbPUjIs70xfBbDXL9MHMwHOvhWoAyiorzFYDDVfCdjAZgdlFZS/+6V+R+ZAUvAAmBrdCrsz4
 =
X-Gm-Gg: ASbGncsGZiBEWlo8L6kU5CYLDOBqOpI3ScvQUOueFAvHhJsLubA0akbHTv+D4ak2ec0
 TVWfuvKS5Q2Y2Rfsan86vDKaKecwbxz4u0QNy8WuUffgYsz3EpSCpo2UWX8/oqcR1m2iNW36SZn
 Jy4xqQNSUjwj/UymG9509SYagkl2WdjfFi9lL4hZPOf2S/zBxPMLeqsYMrlRgs1v4pCF06cbiw7
 RnAWfjFJK55jhgE9uNA03Fw5ObVP5otkiRBkF4kV9bAsWyEhWS6xFP5f8hJDIgSvbWLRLy10bBe
 uLlHfHQPgW5wvvxfg0ghRSWAg/1uxfs=
X-Google-Smtp-Source: AGHT+IFSx3GMbmnQ+LJRW26ZLLHJX/pG8CaoznpcGaHSSVk/KjmJYdEcs8iPTcwe70X+GSW63Do79A==
X-Received: by 2002:a05:6602:6d13:b0:83a:9488:154c with SMTP id
 ca18e2360f4ac-851b619f80dmr1307250439f.3.1737408434096; 
 Mon, 20 Jan 2025 13:27:14 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea75440a24sm2847693173.33.2025.01.20.13.27.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:27:13 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 25/44] test: Drop the function for running measurement tests
Date: Mon, 20 Jan 2025 14:25:47 -0700
Message-ID: <20250120212613.516664-26-sjg@chromium.org>
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

 include/test/suites.h   |  1 -
 test/boot/measurement.c | 10 ----------
 test/cmd_ut.c           |  2 +-
 3 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/include/test/suites.h b/include/test/suites.h
index 775b0a5a131..1a40af6599a 100644
--- a/include/test/suites.h
+++ b/include/test/suites.h
@@ -39,7 +39,6 @@ int do_ut_bloblist(struct cmd_tbl *cmdtp, int flag, int argc,
 		   char *const argv[]);
 int do_ut_hush(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_loadm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
-int do_ut_measurement(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[]);
 int do_ut_optee(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_overlay(struct cmd_tbl *cmdtp, int flag, int argc,
 		  char *const argv[]);
diff --git a/test/boot/measurement.c b/test/boot/measurement.c
index 018e8af45f0..5a49c7a6b23 100644
--- a/test/boot/measurement.c
+++ b/test/boot/measurement.c
@@ -53,13 +53,3 @@ static int measure(struct unit_test_state *uts)
 	return 0;
 }
 MEASUREMENT_TEST(measure, 0);
-
-int do_ut_measurement(struct cmd_tbl *cmdtp, int flag, int argc,
-		      char *const argv[])
-{
-	struct unit_test *tests = UNIT_TEST_SUITE_START(measurement);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(measurement);
-
-	return cmd_ut_category("measurement", "measurement_test_", tests,
-			       n_ents, argc, argv);
-}
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index f2a72adc16e..ff9976cb98a 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -166,7 +166,7 @@ static struct suite suites[] = {
 	SUITE(setexpr),
 #endif
 #ifdef CONFIG_MEASURED_BOOT
-	SUITE_CMD(measurement, do_ut_measurement),
+	SUITE(measurement),
 #endif
 #ifdef CONFIG_SANDBOX
 #if CONFIG_IS_ENABLED(BLOBLIST)
-- 
2.43.0

