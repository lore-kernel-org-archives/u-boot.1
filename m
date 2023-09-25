Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C74CE7A91
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 02:40:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0071B86A38;
	Mon, 25 Sep 2023 04:40:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m3T3GEWy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3D1C86A38; Mon, 25 Sep 2023 04:40:08 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5517F800D2
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 04:40:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-79fa7e33573so121755339f.0
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 19:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695609605; x=1696214405; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o29E6D9p/sL2FkjffwO2rw9CTShRy+Mexchz0smJTmw=;
 b=m3T3GEWymtB1voBbz2skueV7JX1h3ZaM3Og1rxuFpfZkq5y+p0JuVlaW4HSrUQEC7T
 qYbqDo2ZIEYkaJfDcSf0WqGalxU5EqpIkB0yBqB3J3QbpPxSCoct7kRLNk/T0G0YZauD
 uX1UXc4GYQ4jKK/vq9crAkPFNweeHPk3zIK0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695609605; x=1696214405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o29E6D9p/sL2FkjffwO2rw9CTShRy+Mexchz0smJTmw=;
 b=ZZbY00wZ17lQgKOK02SB/6rfk3a/sr1IjzPtTnu1Eqj6PVH5odLwIbymN7ALWZxIyJ
 Cfbb5owYDxUXLgjWwD6vI083wikpyx6wEwt46mKL8nUOicl3U1I5p/c4/BNmOKRuJMXS
 XaP9QSESZwI7R2XTNIVJI5yRYbXBqD0SCm8KsMG0oFfmP41N17M/2Yu0skCFObicH02w
 R0XslyFiIKyfqkPpB9iYS0C4Nn5RcGas9kh6FyvN8viCcr+xVY+xyyacB9svYnHtJYaQ
 NxVTJxM8OdBZcJ+60A0BOQw6MnFW2tHWH90K5SNKGWnNW6ql62Gv51iZJ8FiZAhxNXeP
 A2DQ==
X-Gm-Message-State: AOJu0Yze6ccaG3g+sA+EQLdVaiPvmE2L4Q0ge1NVAujKC+lhhQrXWV7h
 yjrIFwOnfAocTWIwLYTBM/GuQAXCbSniWkoeh3I=
X-Google-Smtp-Source: AGHT+IHiHnMlKfn7TColfdl1kWU/TCon8Ti10QuhjXlcXEOVTuzIluykuWKDvwlZHsVhOmiBuYgRzw==
X-Received: by 2002:a6b:6402:0:b0:794:eddf:daae with SMTP id
 t2-20020a6b6402000000b00794eddfdaaemr6188004iog.12.1695609604656; 
 Sun, 24 Sep 2023 19:40:04 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 q8-20020a0566380ec800b00439e3c9f958sm2477252jas.129.2023.09.24.19.40.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 19:40:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 1/3] Fix code style for time functions
Date: Sun, 24 Sep 2023 20:39:50 -0600
Message-ID: <20230925023958.1913268-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230925023958.1913268-1-sjg@chromium.org>
References: <20230925023958.1913268-1-sjg@chromium.org>
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

Fix the code style used for some time functions.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/powerpc/lib/interrupts.c   |  2 +-
 arch/powerpc/lib/time.c         |  5 +++--
 board/armltd/integrator/timer.c |  2 +-
 drivers/fpga/ACEX1K.c           |  4 ++--
 drivers/fpga/spartan2.c         | 24 ++++++++++++------------
 drivers/fpga/spartan3.c         | 24 ++++++++++++------------
 post/drivers/rtc.c              |  4 ++--
 7 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/lib/interrupts.c b/arch/powerpc/lib/interrupts.c
index df312dfa28ef..2add2ff95405 100644
--- a/arch/powerpc/lib/interrupts.c
+++ b/arch/powerpc/lib/interrupts.c
@@ -89,7 +89,7 @@ void timer_interrupt(struct pt_regs *regs)
 #endif /* CONFIG_LED_STATUS */
 }
 
-ulong get_timer (ulong base)
+ulong get_timer(ulong base)
 {
 	return (timestamp - base);
 }
diff --git a/arch/powerpc/lib/time.c b/arch/powerpc/lib/time.c
index 8d6babfb83d6..d27432c23af8 100644
--- a/arch/powerpc/lib/time.c
+++ b/arch/powerpc/lib/time.c
@@ -39,8 +39,9 @@ unsigned long usec2ticks(unsigned long usec)
  */
 void __udelay(unsigned long usec)
 {
-	ulong ticks = usec2ticks (usec);
-	wait_ticks (ticks);
+	ulong ticks = usec2ticks(usec);
+
+	wait_ticks(ticks);
 }
 
 /* ------------------------------------------------------------------------- */
diff --git a/board/armltd/integrator/timer.c b/board/armltd/integrator/timer.c
index 9db5135a8ffa..a2abfbfc7f3a 100644
--- a/board/armltd/integrator/timer.c
+++ b/board/armltd/integrator/timer.c
@@ -119,7 +119,7 @@ static ulong get_timer_masked (void)
 	return timestamp;
 }
 
-ulong get_timer (ulong base_ticks)
+ulong get_timer(ulong base_ticks)
 {
 	return get_timer_masked () - base_ticks;
 }
diff --git a/drivers/fpga/ACEX1K.c b/drivers/fpga/ACEX1K.c
index 4c00cdf0b57d..2e788c7a8ef5 100644
--- a/drivers/fpga/ACEX1K.c
+++ b/drivers/fpga/ACEX1K.c
@@ -135,10 +135,10 @@ static int ACEX1K_ps_load(Altera_desc *desc, const void *buf, size_t bsize)
 		udelay(2);		/* T_cf2st1 < 4us	*/
 
 		/* Wait for nSTATUS to be released (i.e. deasserted) */
-		ts = get_timer (0);		/* get current time */
+		ts = get_timer(0);		/* get current time */
 		do {
 			CFG_FPGA_DELAY ();
-			if (get_timer (ts) > CFG_SYS_FPGA_WAIT) {	/* check the time */
+			if (get_timer(ts) > CFG_SYS_FPGA_WAIT) {	/* check the time */
 				puts ("** Timeout waiting for STATUS to go high.\n");
 				(*fn->abort) (cookie);
 				return FPGA_FAIL;
diff --git a/drivers/fpga/spartan2.c b/drivers/fpga/spartan2.c
index 6eef87b78e16..dd84e2e8cbb9 100644
--- a/drivers/fpga/spartan2.c
+++ b/drivers/fpga/spartan2.c
@@ -143,11 +143,11 @@ static int spartan2_sp_load(xilinx_desc *desc, const void *buf, size_t bsize)
 		CFG_FPGA_DELAY ();
 		(*fn->pgm) (false, true, cookie);	/* Deassert the program, commit */
 
-		ts = get_timer (0);		/* get current time */
+		ts = get_timer(0);		/* get current time */
 		/* Now wait for INIT and BUSY to go high */
 		do {
 			CFG_FPGA_DELAY ();
-			if (get_timer (ts) > CFG_SYS_FPGA_WAIT) {	/* check the time */
+			if (get_timer(ts) > CFG_SYS_FPGA_WAIT) {	/* check the time */
 				puts ("** Timeout waiting for INIT to clear.\n");
 				(*fn->abort) (cookie);	/* abort the burn */
 				return FPGA_FAIL;
@@ -170,7 +170,7 @@ static int spartan2_sp_load(xilinx_desc *desc, const void *buf, size_t bsize)
 			(*fn->clk) (true, true, cookie);	/* Assert the clock pin */
 
 #ifdef CONFIG_SYS_FPGA_CHECK_BUSY
-			ts = get_timer (0);	/* get current time */
+			ts = get_timer(0);	/* get current time */
 			while ((*fn->busy) (cookie)) {
 				/* XXX - we should have a check in here somewhere to
 				 * make sure we aren't busy forever... */
@@ -180,7 +180,7 @@ static int spartan2_sp_load(xilinx_desc *desc, const void *buf, size_t bsize)
 				CFG_FPGA_DELAY ();
 				(*fn->clk) (true, true, cookie);	/* Assert the clock pin */
 
-				if (get_timer (ts) > CFG_SYS_FPGA_WAIT) {	/* check the time */
+				if (get_timer(ts) > CFG_SYS_FPGA_WAIT) {	/* check the time */
 					puts ("** Timeout waiting for BUSY to clear.\n");
 					(*fn->abort) (cookie);	/* abort the burn */
 					return FPGA_FAIL;
@@ -203,7 +203,7 @@ static int spartan2_sp_load(xilinx_desc *desc, const void *buf, size_t bsize)
 #endif
 
 		/* now check for done signal */
-		ts = get_timer (0);		/* get current time */
+		ts = get_timer(0);		/* get current time */
 		ret_val = FPGA_SUCCESS;
 		while ((*fn->done) (cookie) == FPGA_FAIL) {
 
@@ -212,7 +212,7 @@ static int spartan2_sp_load(xilinx_desc *desc, const void *buf, size_t bsize)
 			CFG_FPGA_DELAY ();
 			(*fn->clk) (true, true, cookie);	/* Assert the clock pin */
 
-			if (get_timer (ts) > CFG_SYS_FPGA_WAIT) {	/* check the time */
+			if (get_timer(ts) > CFG_SYS_FPGA_WAIT) {	/* check the time */
 				puts ("** Timeout waiting for DONE to clear.\n");
 				(*fn->abort) (cookie);	/* abort the burn */
 				ret_val = FPGA_FAIL;
@@ -328,10 +328,10 @@ static int spartan2_ss_load(xilinx_desc *desc, const void *buf, size_t bsize)
 		(*fn->pgm) (true, true, cookie);	/* Assert the program, commit */
 
 		/* Wait for INIT state (init low)                            */
-		ts = get_timer (0);		/* get current time */
+		ts = get_timer(0);		/* get current time */
 		do {
 			CFG_FPGA_DELAY ();
-			if (get_timer (ts) > CFG_SYS_FPGA_WAIT) {	/* check the time */
+			if (get_timer(ts) > CFG_SYS_FPGA_WAIT) {	/* check the time */
 				puts ("** Timeout waiting for INIT to start.\n");
 				return FPGA_FAIL;
 			}
@@ -341,11 +341,11 @@ static int spartan2_ss_load(xilinx_desc *desc, const void *buf, size_t bsize)
 		CFG_FPGA_DELAY ();
 		(*fn->pgm) (false, true, cookie);	/* Deassert the program, commit */
 
-		ts = get_timer (0);		/* get current time */
+		ts = get_timer(0);		/* get current time */
 		/* Now wait for INIT to go high */
 		do {
 			CFG_FPGA_DELAY ();
-			if (get_timer (ts) > CFG_SYS_FPGA_WAIT) {	/* check the time */
+			if (get_timer(ts) > CFG_SYS_FPGA_WAIT) {	/* check the time */
 				puts ("** Timeout waiting for INIT to clear.\n");
 				return FPGA_FAIL;
 			}
@@ -389,7 +389,7 @@ static int spartan2_ss_load(xilinx_desc *desc, const void *buf, size_t bsize)
 #endif
 
 		/* now check for done signal */
-		ts = get_timer (0);		/* get current time */
+		ts = get_timer(0);		/* get current time */
 		ret_val = FPGA_SUCCESS;
 		(*fn->wr) (true, true, cookie);
 
@@ -402,7 +402,7 @@ static int spartan2_ss_load(xilinx_desc *desc, const void *buf, size_t bsize)
 
 			putc ('*');
 
-			if (get_timer (ts) > CFG_SYS_FPGA_WAIT) {	/* check the time */
+			if (get_timer(ts) > CFG_SYS_FPGA_WAIT) {	/* check the time */
 				puts ("** Timeout waiting for DONE to clear.\n");
 				ret_val = FPGA_FAIL;
 				break;
diff --git a/drivers/fpga/spartan3.c b/drivers/fpga/spartan3.c
index e892fa571f19..95d4dd7d78b5 100644
--- a/drivers/fpga/spartan3.c
+++ b/drivers/fpga/spartan3.c
@@ -148,11 +148,11 @@ static int spartan3_sp_load(xilinx_desc *desc, const void *buf, size_t bsize)
 		CFG_FPGA_DELAY ();
 		(*fn->pgm) (false, true, cookie);	/* Deassert the program, commit */
 
-		ts = get_timer (0);		/* get current time */
+		ts = get_timer(0);		/* get current time */
 		/* Now wait for INIT and BUSY to go high */
 		do {
 			CFG_FPGA_DELAY ();
-			if (get_timer (ts) > CFG_SYS_FPGA_WAIT) {	/* check the time */
+			if (get_timer(ts) > CFG_SYS_FPGA_WAIT) {	/* check the time */
 				puts ("** Timeout waiting for INIT to clear.\n");
 				(*fn->abort) (cookie);	/* abort the burn */
 				return FPGA_FAIL;
@@ -175,7 +175,7 @@ static int spartan3_sp_load(xilinx_desc *desc, const void *buf, size_t bsize)
 			(*fn->clk) (true, true, cookie);	/* Assert the clock pin */
 
 #ifdef CONFIG_SYS_FPGA_CHECK_BUSY
-			ts = get_timer (0);	/* get current time */
+			ts = get_timer(0);	/* get current time */
 			while ((*fn->busy) (cookie)) {
 				/* XXX - we should have a check in here somewhere to
 				 * make sure we aren't busy forever... */
@@ -185,7 +185,7 @@ static int spartan3_sp_load(xilinx_desc *desc, const void *buf, size_t bsize)
 				CFG_FPGA_DELAY ();
 				(*fn->clk) (true, true, cookie);	/* Assert the clock pin */
 
-				if (get_timer (ts) > CFG_SYS_FPGA_WAIT) {	/* check the time */
+				if (get_timer(ts) > CFG_SYS_FPGA_WAIT) {	/* check the time */
 					puts ("** Timeout waiting for BUSY to clear.\n");
 					(*fn->abort) (cookie);	/* abort the burn */
 					return FPGA_FAIL;
@@ -208,7 +208,7 @@ static int spartan3_sp_load(xilinx_desc *desc, const void *buf, size_t bsize)
 #endif
 
 		/* now check for done signal */
-		ts = get_timer (0);		/* get current time */
+		ts = get_timer(0);		/* get current time */
 		ret_val = FPGA_SUCCESS;
 		while ((*fn->done) (cookie) == FPGA_FAIL) {
 			/* XXX - we should have a check in here somewhere to
@@ -219,7 +219,7 @@ static int spartan3_sp_load(xilinx_desc *desc, const void *buf, size_t bsize)
 			CFG_FPGA_DELAY ();
 			(*fn->clk) (true, true, cookie);	/* Assert the clock pin */
 
-			if (get_timer (ts) > CFG_SYS_FPGA_WAIT) {	/* check the time */
+			if (get_timer(ts) > CFG_SYS_FPGA_WAIT) {	/* check the time */
 				puts ("** Timeout waiting for DONE to clear.\n");
 				(*fn->abort) (cookie);	/* abort the burn */
 				ret_val = FPGA_FAIL;
@@ -335,10 +335,10 @@ static int spartan3_ss_load(xilinx_desc *desc, const void *buf, size_t bsize)
 		(*fn->pgm) (true, true, cookie);	/* Assert the program, commit */
 
 		/* Wait for INIT state (init low)                            */
-		ts = get_timer (0);		/* get current time */
+		ts = get_timer(0);		/* get current time */
 		do {
 			CFG_FPGA_DELAY ();
-			if (get_timer (ts) > CFG_SYS_FPGA_WAIT) {	/* check the time */
+			if (get_timer(ts) > CFG_SYS_FPGA_WAIT) {	/* check the time */
 				puts ("** Timeout waiting for INIT to start.\n");
 				if (*fn->abort)
 					(*fn->abort) (cookie);
@@ -350,11 +350,11 @@ static int spartan3_ss_load(xilinx_desc *desc, const void *buf, size_t bsize)
 		CFG_FPGA_DELAY ();
 		(*fn->pgm) (false, true, cookie);	/* Deassert the program, commit */
 
-		ts = get_timer (0);		/* get current time */
+		ts = get_timer(0);		/* get current time */
 		/* Now wait for INIT to go high */
 		do {
 			CFG_FPGA_DELAY ();
-			if (get_timer (ts) > CFG_SYS_FPGA_WAIT) {	/* check the time */
+			if (get_timer(ts) > CFG_SYS_FPGA_WAIT) {	/* check the time */
 				puts ("** Timeout waiting for INIT to clear.\n");
 				if (*fn->abort)
 					(*fn->abort) (cookie);
@@ -406,7 +406,7 @@ static int spartan3_ss_load(xilinx_desc *desc, const void *buf, size_t bsize)
 #endif
 
 		/* now check for done signal */
-		ts = get_timer (0);		/* get current time */
+		ts = get_timer(0);		/* get current time */
 		ret_val = FPGA_SUCCESS;
 		(*fn->wr) (true, true, cookie);
 
@@ -421,7 +421,7 @@ static int spartan3_ss_load(xilinx_desc *desc, const void *buf, size_t bsize)
 
 			putc ('*');
 
-			if (get_timer (ts) > CFG_SYS_FPGA_WAIT) {	/* check the time */
+			if (get_timer(ts) > CFG_SYS_FPGA_WAIT) {	/* check the time */
 				puts ("** Timeout waiting for DONE to clear.\n");
 				ret_val = FPGA_FAIL;
 				break;
diff --git a/post/drivers/rtc.c b/post/drivers/rtc.c
index cc7a49847ccd..9eeb02794715 100644
--- a/post/drivers/rtc.c
+++ b/post/drivers/rtc.c
@@ -36,11 +36,11 @@ static int rtc_post_skip (ulong * diff)
 	ulong start2;
 
 	rtc_get (&tm1);
-	start1 = get_timer (0);
+	start1 = get_timer(0);
 
 	while (1) {
 		rtc_get (&tm2);
-		start2 = get_timer (0);
+		start2 = get_timer(0);
 		if (tm1.tm_sec != tm2.tm_sec)
 			break;
 		if (start2 - start1 > 1500)
-- 
2.42.0.515.g380fc7ccd1-goog

