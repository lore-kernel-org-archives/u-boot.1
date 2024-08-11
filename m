Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10C4C52D7B
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:54:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC9A78895D;
	Sun, 11 Aug 2024 16:51:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Pnwn0M+7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D8F38861A; Sun, 11 Aug 2024 16:51:24 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 368DD8894F
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:51:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-81fd1e05a5aso151097739f.0
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387881; x=1723992681; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XcOIqIv5swTvKcE1N7p/k3qMdpyjnpGwKE1AK4cEEyE=;
 b=Pnwn0M+78UNv0K90msSn7r+nPOaOT3ZfQKul6ZbsCctswdBqjmstPuvo6ydqS4MSkp
 et4c3whwUlATtMCMIksn6dRRqoAvnIBAyp/4VCIYOqxcecTGL46xfRU0L5n66VpJwLf+
 AVwApkn4mje9YJPAspR3/u63w+s+7dEXAA5Hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387881; x=1723992681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XcOIqIv5swTvKcE1N7p/k3qMdpyjnpGwKE1AK4cEEyE=;
 b=YLHN86T+jM6Bbh4mN8UNqlurypyLU5RWGWWXMImUwpbGk4h0CMN/4XLwEFalDQcuF7
 ctetm3CRH9zuuOztBT4k0RkColsH5FoZ+An6juwNiEFB4FPGfAmLkTyTt5+NNgA6BqM2
 OhoG2fTZV2lB/i6XYW7NF3It0HI3eScxG19ArHEtmA8o/0MzWFjNxaxGhat9HpcVO3eM
 jbDdec1Vd94BqVJXpC+eiLZsqtlZ970ulAW7fAnNPMWznJzsn3S5WX8w68ShWi2I7YAX
 08Y+lVkEoQHllNmlgdrYWGPBQ5/c+90WDFccuu5S4EfM/oVam+bQiVGz7y/u4F8v6bCS
 23EA==
X-Gm-Message-State: AOJu0YzWHyAE/mYpH6ZMu8OWvYqPyCAp1cRxYlGk6GiElY9DmuRdNsvp
 wylJu97hRx44ruUFN3gQZgbZ+TEcG6PcBjKTFpWdeatZFQUL6eGV8W49bOoI9XNrnesHvHSPWug
 =
X-Google-Smtp-Source: AGHT+IGgx8wkP1nGWjFVfaaLkNuHA/A0a+sMIdQa2X7uiD0hv6GZJ67RzFfN1fhMxyqizf3nQ/xPFg==
X-Received: by 2002:a05:6602:601a:b0:822:43ef:99d1 with SMTP id
 ca18e2360f4ac-8225ee69806mr800076339f.2.1723387880922; 
 Sun, 11 Aug 2024 07:51:20 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ca769fbe17sm1076047173.101.2024.08.11.07.51.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:51:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 09/18] date: Drop the legacy I2C code
Date: Sun, 11 Aug 2024 08:50:38 -0600
Message-Id: <20240811145047.4189460-10-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811145047.4189460-1-sjg@chromium.org>
References: <20240811145047.4189460-1-sjg@chromium.org>
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

Drop two generations of old code in this command. All boards should use
driver model for I2C from 2021.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/date.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/cmd/date.c b/cmd/date.c
index bdb3e199b43..8614f022761 100644
--- a/cmd/date.c
+++ b/cmd/date.c
@@ -31,7 +31,6 @@ static int do_date(struct cmd_tbl *cmdtp, int flag, int argc,
 	int old_bus __maybe_unused;
 
 	/* switch to correct I2C bus */
-#ifdef CONFIG_DM_RTC
 	struct udevice *dev;
 
 	rcode = uclass_get_device_by_seq(UCLASS_RTC, 0, &dev);
@@ -42,29 +41,19 @@ static int do_date(struct cmd_tbl *cmdtp, int flag, int argc,
 			return CMD_RET_FAILURE;
 		}
 	}
-#endif
 
 	switch (argc) {
 	case 2:			/* set date & time */
 		if (strcmp(argv[1],"reset") == 0) {
 			puts ("Reset RTC...\n");
-#ifdef CONFIG_DM_RTC
 			rcode = dm_rtc_reset(dev);
 			if (!rcode)
 				rcode = dm_rtc_set(dev, &default_tm);
-#else
-			rtc_reset();
-			rcode = rtc_set(&default_tm);
-#endif
 			if (rcode)
 				puts("## Failed to set date after RTC reset\n");
 		} else {
 			/* initialize tm with current time */
-#ifdef CONFIG_DM_RTC
 			rcode = dm_rtc_get(dev, &tm);
-#else
-			rcode = rtc_get(&tm);
-#endif
 			if (!rcode) {
 				/* insert new date & time */
 				if (mk_date(argv[1], &tm) != 0) {
@@ -72,11 +61,7 @@ static int do_date(struct cmd_tbl *cmdtp, int flag, int argc,
 					break;
 				}
 				/* and write to RTC */
-#ifdef CONFIG_DM_RTC
 				rcode = dm_rtc_set(dev, &tm);
-#else
-				rcode = rtc_set(&tm);
-#endif
 				if (rcode) {
 					printf("## Set date failed: err=%d\n",
 					       rcode);
@@ -87,11 +72,7 @@ static int do_date(struct cmd_tbl *cmdtp, int flag, int argc,
 		}
 		fallthrough;
 	case 1:			/* get date & time */
-#ifdef CONFIG_DM_RTC
 		rcode = dm_rtc_get(dev, &tm);
-#else
-		rcode = rtc_get(&tm);
-#endif
 		if (rcode) {
 			puts("## Get date failed\n");
 			break;
@@ -108,13 +89,6 @@ static int do_date(struct cmd_tbl *cmdtp, int flag, int argc,
 		rcode = CMD_RET_USAGE;
 	}
 
-	/* switch back to original I2C bus */
-#if CONFIG_IS_ENABLED(SYS_I2C_LEGACY)
-	i2c_set_bus_num(old_bus);
-#elif !defined(CONFIG_DM_RTC)
-	I2C_SET_BUS(old_bus);
-#endif
-
 	return rcode ? CMD_RET_FAILURE : 0;
 }
 
-- 
2.34.1

