Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E60C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 17:38:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAF5E88B80;
	Thu, 18 Jul 2024 19:36:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JxIb71ON";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AC7D88ADC; Thu, 18 Jul 2024 19:36:50 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D147888B37
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 19:36:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3683f56b9bdso71739f8f.1
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 10:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721324203; x=1721929003; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sPnvaVlT8/NA2r+1550BsFJnCHZwiiO/dBXdqH3MsZA=;
 b=JxIb71ONOt/za53ahBlncxfbDF0uDQSfsiZJ1a/YLrSpTHt5cnXL7Ma3gWwQTwEcPV
 Urdy4kSKghaxp1YNH7IXsvY0K7Bebh+zPlLQsXm9SF2TETcx93PvGfZdEl7tcUGUkwum
 5KT6EQ4mcRilfqjvDGBdC44bbFhYsUpqls+1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721324203; x=1721929003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sPnvaVlT8/NA2r+1550BsFJnCHZwiiO/dBXdqH3MsZA=;
 b=e28a59IqyXVz/Fp6ONlJJ6aw7qrrQxgl9Eyd+3MKXAzBM0MgPf6l1kTal+eigityYN
 PLcoab1sH/VvauPOSRxcBC8Uytf7jga0rmxH0j2A1Ymylco/MIwvJz4lGWFYpZ17xuG2
 oHYj9Uf2rdjCOY8ulkezqm0sl13jUi+XeMzmLyE22fDWOY8u9c/2miUmUY39l2O/m2yV
 IPGwnbyk9ccDD/9hKsjFy1Y2u9/uEVEXaUBqmc3TY+3hA48D1M0vjmEwGKPb5khGFGF9
 Yd2BGyvxfjvXr2oY13hForMvPZy+KxfiKf+vE5MnYhOb6JzaN4lKvnppVtBTeU2J5YNS
 k+iQ==
X-Gm-Message-State: AOJu0Yx2twZPQumxGbuXlOc7/vQjmddYu+nsM1UP44MmkxrPnTyl6fua
 i8tTCzhW+oVpclrspEtH5EWbLQngm+SSgAK7MWtWCM763O7vMAg139cJg3HydkTWhybkZtT1W8g
 =
X-Google-Smtp-Source: AGHT+IHSdunYzmLonJsig8toi4X5PL0HzBOsVdcHlIKiv81u9BmEwfKDLgD5b4Nk+hgdzMRQei3RKA==
X-Received: by 2002:a5d:4e4e:0:b0:367:988d:fb99 with SMTP id
 ffacd0b85a97d-368316003camr3383692f8f.8.1721324203240; 
 Thu, 18 Jul 2024 10:36:43 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2b29396sm20950715e9.32.2024.07.18.10.36.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 10:36:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 10/20] date: Drop the legacy I2C code
Date: Thu, 18 Jul 2024 18:36:01 +0100
Message-Id: <20240718173611.4014274-11-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718173611.4014274-1-sjg@chromium.org>
References: <20240718173611.4014274-1-sjg@chromium.org>
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

