Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 991FAC02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:36:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8F0880A35;
	Wed, 15 Jan 2025 14:32:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="beppZt98";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E93980934; Wed, 15 Jan 2025 14:32:06 +0100 (CET)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEA0D80ADB
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:32:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3a8146a8ddaso16660225ab.1
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 05:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736947922; x=1737552722; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TqFGqpcbI4ji9ZX9czXCD5lkg5wsdXiWt2LwCvUxCfo=;
 b=beppZt98kLDqhWS2mJveU6ot0vikS7MM178oncOE0ekL+q+Tyb+UPwgfPFLwg4Av3q
 ujUsXWmB7LMpnocNri8SYEYwv7Dmcod88ArvF2ZGWEmD61tl8uJS6t+ltffiqHDLUi6n
 Tm0OnaN8givknXsVwGiHEye3x29cwXmfyH0TU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736947922; x=1737552722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TqFGqpcbI4ji9ZX9czXCD5lkg5wsdXiWt2LwCvUxCfo=;
 b=l8WipYKCCrj446wjUYEk4XW/x7L2XWWQ0Vbj0hi3J3iRzyOBXOzEc+vFN9pt4+Pggt
 GPC8hd0+9gQ6xhx7ejHMW0u7ECYAwane4SP3eEE9kkzEZow/CvpeIsuSTvyvZTdamAFA
 aYRwe1jag4LkiqrWV8GzJ0gKpQ+m8e4Fxph3qvNZbXmJCqtwyUqcvp4sioq1wLGT5hHj
 Tj5ejkDNJP7nKTcRJeH3DYKeur3cWAPQ8UxlPuxNcb/aPx57Frq0nUzxIGNgpkYFPVqh
 1Dxx+gtzuJNO8AHn+iwFUWGRgN9HKAn2+mDVbfDarmoXoZ6gpecowJI8eiZb6NxtU4Nj
 PpCg==
X-Gm-Message-State: AOJu0YyjGNl3anrIbP5r8shju7sECB8VQfji7VxqjQaPBpCHz8yRj2dT
 fGGWuhvQQpApZ5Gl+275S5X7SEvHHqrne5FdlOAz2fng0l2QR1pa7xNX4HX8T7HReYQ8JR6vlrE
 =
X-Gm-Gg: ASbGncudkvbuqe8pKzcYaCD1s2lVZoXTHAXwJjvIYTXkUkQ6xlOBvvKMzZuytM+d/Am
 MM7X3abMzORCrhDvtvitJFjSm0LCwAznQkfCx3fWdf6jK1QVZRRpREHYXjDLirb0e9ZyQKPwTea
 uTi+oqtdvB1GVQ6jjrnZDeM0Wym+omLytkgKZgf6riaVbekYL8qclDmEWmvB7C6VNtbxrNuB3IM
 RRIY5FK9Vw+uB1yR4wct7aSUN8CV9/6rC11b55fDXsj4i/kSeE/XOALzEhOurH4kijPSLnfMkSk
 jbR9eQ2oEYE3z/DZJQ==
X-Google-Smtp-Source: AGHT+IGABw7B0d68H5W2PWG7tXD2OgmkIo5WYs/wpWY/vZlB8gN8fxkaT2JTR0+I47O0w943Ukqf4w==
X-Received: by 2002:a92:d782:0:b0:3ce:7a5d:d2dc with SMTP id
 e9e14a558f8ab-3ce7a5dd465mr48988525ab.17.1736947922135; 
 Wed, 15 Jan 2025 05:32:02 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm4091248173.20.2025.01.15.05.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 05:32:01 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 25/43] test: Drop the function for running measurement tests
Date: Wed, 15 Jan 2025 06:30:55 -0700
Message-Id: <20250115133114.590375-26-sjg@chromium.org>
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
index c53b24bfde9..6f5aa7e4924 100644
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
 	SUITE_CMD(bloblist, do_ut_bloblist),
-- 
2.34.1

