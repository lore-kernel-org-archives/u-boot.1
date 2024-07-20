Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA46C3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:48:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3C4088CAD;
	Sat, 20 Jul 2024 14:44:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="JUbOuFYX";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="sQ40wP0U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 856CC88C94; Sat, 20 Jul 2024 14:44:00 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AEB088C84
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:43:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WR5np2RfXz9sWs;
 Sat, 20 Jul 2024 14:43:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UZHJtaXRzSzKAKzeBVSSboLVCyfwLjv1Igj8xMD9YpA=;
 b=JUbOuFYX0gWYbXVjxIIQkQugJR2Y6VfMs8sHS/BHJb4bRWr3ehH4dBh98nS3XXNUK53YrH
 lNEwUwb/1Ow3BxDJM8OgMokYqodNcGrALsJqgCjowrh1Pfv8QwnvkIUEX6bNTkclisWEeA
 mk+2dz8v7oZIchHXVZrUt8CnHwMiA35WUl4rw6GkMHisPWlr6+bbQBomdR4reZKCYV1T39
 zOlBPzQSabyK8dPizcmOUpEilP5udUnoBjjmriaHqKuxnjpmtnoEdPmqqexeek/u/fQatO
 mX3+kbKgh1piM1nQsImDog6B9YtoCu5WqrDuHevhfUs2XIqtUPz1RWkLwjD8lg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UZHJtaXRzSzKAKzeBVSSboLVCyfwLjv1Igj8xMD9YpA=;
 b=sQ40wP0UHd1HrUbhe40N3mKNlpp2BS3mHy4px76ea2srjHBp8zhlPktGWTb2VPul1qOk/p
 9D9ZCan4zRNl1ZrKNJT0E/1CTf5m2c+RU3z4Yb7AK/D1kHPs7ss/9nBfglxB0tGwtbnT/K
 tBOTF/u/oBW/3X33dMzrOD0+GV+ueD4CS2cDBTnQukavvObHgWsyr4NV3miPWePFKBSEGv
 1J/TByrEPR/t2yEO8tr00mVAiXBwGRVZsVZS3Ufm4E2vFo2mOxfq/P4ez53FCM84+Ljcn3
 vPkroPVK7aRDW0ESKJtDV4sJfAZGrCRXeckzzmLN94HwXUwZFno7lSShRijBIQ==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 28/40] drivers: rtc: Remove duplicate newlines
Date: Sat, 20 Jul 2024 14:40:53 +0200
Message-ID: <20240720124239.7553-28-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
References: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 751cd6315bd84a7844d
X-MBO-RS-META: miorihgtwtnat6ym46dmozfafjuuhthi
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/rtc/ds1307.c | 5 -----
 drivers/rtc/ds1337.c | 5 -----
 drivers/rtc/ds3231.c | 6 ------
 drivers/rtc/mcfrtc.c | 1 -
 drivers/rtc/rv3029.c | 2 --
 5 files changed, 19 deletions(-)

diff --git a/drivers/rtc/ds1307.c b/drivers/rtc/ds1307.c
index ba06ff9f0be..04921099101 100644
--- a/drivers/rtc/ds1307.c
+++ b/drivers/rtc/ds1307.c
@@ -139,7 +139,6 @@ read_rtc:
 	}
 #endif
 
-
 	tmp->tm_sec  = bcd2bin (sec & 0x7F);
 	tmp->tm_min  = bcd2bin (min & 0x7F);
 	tmp->tm_hour = bcd2bin (hour & 0x3F);
@@ -157,7 +156,6 @@ read_rtc:
 	return rel;
 }
 
-
 /*
  * Set the RTC
  */
@@ -190,7 +188,6 @@ int rtc_set (struct rtc_time *tmp)
 	return 0;
 }
 
-
 /*
  * Reset the RTC. We setting the date back to 1970-01-01.
  * We also enable the oscillator output on the SQW/OUT pin and program
@@ -204,7 +201,6 @@ void rtc_reset (void)
 	rtc_write (RTC_CTL_REG_ADDR, RTC_CTL_BIT_SQWE | RTC_CTL_BIT_RS1 | RTC_CTL_BIT_RS0);
 }
 
-
 /*
  * Helper functions
  */
@@ -215,7 +211,6 @@ uchar rtc_read (uchar reg)
 	return (i2c_reg_read (CFG_SYS_I2C_RTC_ADDR, reg));
 }
 
-
 static void rtc_write (uchar reg, uchar val)
 {
 	i2c_reg_write (CFG_SYS_I2C_RTC_ADDR, reg, val);
diff --git a/drivers/rtc/ds1337.c b/drivers/rtc/ds1337.c
index 7eccf1cb8c5..77544298d8a 100644
--- a/drivers/rtc/ds1337.c
+++ b/drivers/rtc/ds1337.c
@@ -62,7 +62,6 @@
 #define RTC_STAT_BIT_A2F	0x2	/* Alarm 2 flag			*/
 #define RTC_STAT_BIT_OSF	0x80	/* Oscillator stop flag		*/
 
-
 #if !CONFIG_IS_ENABLED(DM_RTC)
 static uchar rtc_read (uchar reg);
 static void rtc_write (uchar reg, uchar val);
@@ -119,7 +118,6 @@ int rtc_get (struct rtc_time *tmp)
 	return rel;
 }
 
-
 /*
  * Set the RTC
  */
@@ -145,7 +143,6 @@ int rtc_set (struct rtc_time *tmp)
 	return 0;
 }
 
-
 /*
  * Reset the RTC.  We also enable the oscillator output on the
  * SQW/INTB* pin and program it for 32,768 Hz output. Note that
@@ -176,7 +173,6 @@ void rtc_reset (void)
 #endif
 }
 
-
 /*
  * Helper functions
  */
@@ -187,7 +183,6 @@ uchar rtc_read (uchar reg)
 	return (i2c_reg_read (CFG_SYS_I2C_RTC_ADDR, reg));
 }
 
-
 static void rtc_write (uchar reg, uchar val)
 {
 	i2c_reg_write (CFG_SYS_I2C_RTC_ADDR, reg, val);
diff --git a/drivers/rtc/ds3231.c b/drivers/rtc/ds3231.c
index d6267d660d0..6341a1d62b8 100644
--- a/drivers/rtc/ds3231.c
+++ b/drivers/rtc/ds3231.c
@@ -34,7 +34,6 @@
 #define RTC_CTL_REG_ADDR	0x0e
 #define RTC_STAT_REG_ADDR	0x0f
 
-
 /*
  * RTC control register bits
  */
@@ -54,12 +53,10 @@
 #define RTC_STAT_BIT_BB32KHZ	0x40	/* Battery backed 32KHz Output  */
 #define RTC_STAT_BIT_EN32KHZ	0x8	/* Enable 32KHz Output  */
 
-
 #if !CONFIG_IS_ENABLED(DM_RTC)
 static uchar rtc_read (uchar reg);
 static void rtc_write (uchar reg, uchar val);
 
-
 /*
  * Get the current time from the RTC
  */
@@ -107,7 +104,6 @@ int rtc_get (struct rtc_time *tmp)
 	return rel;
 }
 
-
 /*
  * Set the RTC
  */
@@ -133,7 +129,6 @@ int rtc_set (struct rtc_time *tmp)
 	return 0;
 }
 
-
 /*
  * Reset the RTC.  We also enable the oscillator output on the
  * SQW/INTB* pin and program it for 32,768 Hz output. Note that
@@ -167,7 +162,6 @@ uchar rtc_read (uchar reg)
 	return (i2c_reg_read (CFG_SYS_I2C_RTC_ADDR, reg));
 }
 
-
 static void rtc_write (uchar reg, uchar val)
 {
 	i2c_reg_write (CFG_SYS_I2C_RTC_ADDR, reg, val);
diff --git a/drivers/rtc/mcfrtc.c b/drivers/rtc/mcfrtc.c
index b5cc6b96881..9708971c5c4 100644
--- a/drivers/rtc/mcfrtc.c
+++ b/drivers/rtc/mcfrtc.c
@@ -4,7 +4,6 @@
  * TsiChung Liew (Tsi-Chung.Liew@freescale.com)
  */
 
-
 #include <command.h>
 #include <rtc.h>
 #include <asm/immap.h>
diff --git a/drivers/rtc/rv3029.c b/drivers/rtc/rv3029.c
index a82acec6f7e..8c80fe9cb79 100644
--- a/drivers/rtc/rv3029.c
+++ b/drivers/rtc/rv3029.c
@@ -73,7 +73,6 @@
 					 RV3029_TRICKLE_80K)
 #define RV3029_TRICKLE_SHIFT		4
 
-
 static int rv3029_rtc_get(struct udevice *dev, struct rtc_time *tm)
 {
 	u8 regs[RTC_RV3029_PAGE_LEN];
@@ -127,7 +126,6 @@ static int rv3029_rtc_set(struct udevice *dev, const struct rtc_time *tm)
 	      __func__, tm->tm_year, tm->tm_mon, tm->tm_mday,
 	      tm->tm_wday, tm->tm_hour, tm->tm_min, tm->tm_sec);
 
-
 	if (tm->tm_year < 2000) {
 		printf("%s: year %d (before 2000) not supported\n",
 		       __func__, tm->tm_year);
-- 
2.43.0

