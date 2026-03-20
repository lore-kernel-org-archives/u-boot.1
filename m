Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7282F1099B37
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 20:54:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA0E583FF9;
	Fri, 20 Mar 2026 21:53:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZaTaWzJI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4770A8407E; Fri, 20 Mar 2026 21:53:39 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0EA58394E
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 21:53:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7d1872504cbso2150215a34.0
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 13:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774040014; x=1774644814; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ej1CGRDVTSsd5b2KAAiUdMB3oh1XzfjDdelkwaJiizU=;
 b=ZaTaWzJIX63syQF0LQ4n2vcfcFh5wNWmEXmfimLwf39H6OJ99kTLIrCAmKeYYbQ6SG
 LxqNVMeh/dcLMIS3nyNl61ZLdjxOgUgaLn7iI9SAZfk1Q9CCmbQAgSenKpQjarGzrBya
 CsHXW0FlUXNOzT14+wiTiIKsgiQSfzuTQkMOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774040014; x=1774644814;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ej1CGRDVTSsd5b2KAAiUdMB3oh1XzfjDdelkwaJiizU=;
 b=mNJ/TVarEAv205wThr6HgNBqcD19WDIt57+DlZUkyYgb4hf1l43FfhSgZ+Av9XFzWl
 T8h7DwRUeVCn+SFNYuOrsHNNey+XDsp+oKNeLUSW+jZt6TXXgY35m8zGNmHTTAVby2W6
 ZBCDnDYoPakbsMjjhgfpufztSkDgp1vJhfpEtpqpSKByLQca70/aG2ZiymqI/G3/hpiK
 YU1oEmMvROYhVHTpEru2TVo1wu52rZLKDOy3oP7QPP+r0JUr6+d561lgp8S1NAOHZaZS
 bl7UgbpsgUG6mddwJjwVSfKohwGX6Unoa2oqMUHVwOvNS/CsNYWLBlgo8HKTY0wp1Zhk
 SBrw==
X-Gm-Message-State: AOJu0YzOmWFWWgc38rfXWfPiB07ssv0DB8z214UVc8XHSK+O3m1WBQ/P
 QfTfjpq16bwQbk4jfpe9D4j8hBb42tnLwemD+cg5V/eFWHn4oPVglmEVs5ilblZa8UPIvpv9H1p
 ZX0Z74Ro=
X-Gm-Gg: ATEYQzy9YLtlJ5wcmcmkHkUoQ1dLQKk2hvRR0dhxOtvqlhAL33ZnkgBGD6O/d0Lc/wU
 0hwyTHDq930bKf2SqtqLleoLeTgUkQH22CZPTHGmJkHzY7D8aktWHVUm9zFGTPBqmQGgC/fQYFl
 IjjatCCVqWp22lMmnII5gbV2khasD6NswLHfeXho98RISlsizfSRuKks/G9gKGsg2C2FDtFTwf7
 WMopzCe3wNT7PKMfMqTKSHB7UkS+bh9h/cYxQHEKnPcN36RYKCie6zjWkQyr4zleewXyH458sxk
 fEQJDQ/BL3Tx2tO3R/ML5dv0XJs9aikiJL8rW+HCeVwUyEgyutscYSRQg22/otxtzO1WIc7Nvno
 BEv+bX28rkPTiuSysQ9SA2aQ6ZCKL3yYiLlJYOWdvRw3GxCuFhR07lFIr3+0voEjhcmCC6oG5Hm
 MVhcI7K4OxjYWsBSjhCqcvwc93jYW1FeO1h5IG+TxoGStqHqG2MRlk+NfPjODDKOaIkA1qrlVTD
 jD9Hhot60FgdRh2ofF/W+efHtQGmn5Fx6AizcNs+KWzZ6ULkDs=
X-Received: by 2002:a05:6830:3690:b0:7d7:ddb9:670c with SMTP id
 46e09a7af769-7d7eaad0afdmr2750251a34.9.1774040014240; 
 Fri, 20 Mar 2026 13:53:34 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7eac2dffbsm3036930a34.10.2026.03.20.13.53.33
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 13:53:33 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] rtc: ds1337: Remove various legacy code and update
 dependencies
Date: Fri, 20 Mar 2026 14:53:32 -0600
Message-ID: <20260320205332.3788725-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

At this point there are no users of this driver which do not enable
DM_RTC, so remove the legacy code and express the depdendency in
Kconfig. We can further remove code related to RTC chips / options that
are neither available in Kconfig nor set by any platforms.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/rtc/Kconfig  |   1 +
 drivers/rtc/ds1337.c | 156 +------------------------------------------
 2 files changed, 2 insertions(+), 155 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index cb0a672668ea..648948cc735e 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -73,6 +73,7 @@ config RTC_DS1307
 
 config RTC_DS1337
 	bool "Enable DS1337 driver"
+	depends on DM_RTC
 	help
 	  Support for Dallas Semiconductor (now Maxim) DS1337/8/9 compatible
 	  Real Time Clock devices.
diff --git a/drivers/rtc/ds1337.c b/drivers/rtc/ds1337.c
index 77544298d8a8..e9db6220c55d 100644
--- a/drivers/rtc/ds1337.c
+++ b/drivers/rtc/ds1337.c
@@ -21,7 +21,6 @@
 /*
  * RTC register addresses
  */
-#if defined CONFIG_RTC_DS1337
 #define RTC_SEC_REG_ADDR	0x0
 #define RTC_MIN_REG_ADDR	0x1
 #define RTC_HR_REG_ADDR		0x2
@@ -32,18 +31,6 @@
 #define RTC_CTL_REG_ADDR	0x0e
 #define RTC_STAT_REG_ADDR	0x0f
 #define RTC_TC_REG_ADDR		0x10
-#elif defined CONFIG_RTC_DS1388
-#define RTC_SEC_REG_ADDR	0x1
-#define RTC_MIN_REG_ADDR	0x2
-#define RTC_HR_REG_ADDR		0x3
-#define RTC_DAY_REG_ADDR	0x4
-#define RTC_DATE_REG_ADDR	0x5
-#define RTC_MON_REG_ADDR	0x6
-#define RTC_YR_REG_ADDR		0x7
-#define RTC_CTL_REG_ADDR	0x0c
-#define RTC_STAT_REG_ADDR	0x0b
-#define RTC_TC_REG_ADDR		0x0a
-#endif
 
 /*
  * RTC control register bits
@@ -62,132 +49,6 @@
 #define RTC_STAT_BIT_A2F	0x2	/* Alarm 2 flag			*/
 #define RTC_STAT_BIT_OSF	0x80	/* Oscillator stop flag		*/
 
-#if !CONFIG_IS_ENABLED(DM_RTC)
-static uchar rtc_read (uchar reg);
-static void rtc_write (uchar reg, uchar val);
-
-/*
- * Get the current time from the RTC
- */
-int rtc_get (struct rtc_time *tmp)
-{
-	int rel = 0;
-	uchar sec, min, hour, mday, wday, mon_cent, year, control, status;
-
-	control = rtc_read (RTC_CTL_REG_ADDR);
-	status = rtc_read (RTC_STAT_REG_ADDR);
-	sec = rtc_read (RTC_SEC_REG_ADDR);
-	min = rtc_read (RTC_MIN_REG_ADDR);
-	hour = rtc_read (RTC_HR_REG_ADDR);
-	wday = rtc_read (RTC_DAY_REG_ADDR);
-	mday = rtc_read (RTC_DATE_REG_ADDR);
-	mon_cent = rtc_read (RTC_MON_REG_ADDR);
-	year = rtc_read (RTC_YR_REG_ADDR);
-
-	/* No century bit, assume year 2000 */
-#ifdef CONFIG_RTC_DS1388
-	mon_cent |= 0x80;
-#endif
-
-	debug("Get RTC year: %02x mon/cent: %02x mday: %02x wday: %02x "
-		"hr: %02x min: %02x sec: %02x control: %02x status: %02x\n",
-		year, mon_cent, mday, wday, hour, min, sec, control, status);
-
-	if (status & RTC_STAT_BIT_OSF) {
-		printf ("### Warning: RTC oscillator has stopped\n");
-		/* clear the OSF flag */
-		rtc_write (RTC_STAT_REG_ADDR,
-			   rtc_read (RTC_STAT_REG_ADDR) & ~RTC_STAT_BIT_OSF);
-		rel = -1;
-	}
-
-	tmp->tm_sec  = bcd2bin (sec & 0x7F);
-	tmp->tm_min  = bcd2bin (min & 0x7F);
-	tmp->tm_hour = bcd2bin (hour & 0x3F);
-	tmp->tm_mday = bcd2bin (mday & 0x3F);
-	tmp->tm_mon  = bcd2bin (mon_cent & 0x1F);
-	tmp->tm_year = bcd2bin (year) + ((mon_cent & 0x80) ? 2000 : 1900);
-	tmp->tm_wday = bcd2bin ((wday - 1) & 0x07);
-	tmp->tm_yday = 0;
-	tmp->tm_isdst= 0;
-
-	debug("Get DATE: %4d-%02d-%02d (wday=%d)  TIME: %2d:%02d:%02d\n",
-		tmp->tm_year, tmp->tm_mon, tmp->tm_mday, tmp->tm_wday,
-		tmp->tm_hour, tmp->tm_min, tmp->tm_sec);
-
-	return rel;
-}
-
-/*
- * Set the RTC
- */
-int rtc_set (struct rtc_time *tmp)
-{
-	uchar century;
-
-	debug("Set DATE: %4d-%02d-%02d (wday=%d)  TIME: %2d:%02d:%02d\n",
-		tmp->tm_year, tmp->tm_mon, tmp->tm_mday, tmp->tm_wday,
-		tmp->tm_hour, tmp->tm_min, tmp->tm_sec);
-
-	rtc_write (RTC_YR_REG_ADDR, bin2bcd (tmp->tm_year % 100));
-
-	century = (tmp->tm_year >= 2000) ? 0x80 : 0;
-	rtc_write (RTC_MON_REG_ADDR, bin2bcd (tmp->tm_mon) | century);
-
-	rtc_write (RTC_DAY_REG_ADDR, bin2bcd (tmp->tm_wday + 1));
-	rtc_write (RTC_DATE_REG_ADDR, bin2bcd (tmp->tm_mday));
-	rtc_write (RTC_HR_REG_ADDR, bin2bcd (tmp->tm_hour));
-	rtc_write (RTC_MIN_REG_ADDR, bin2bcd (tmp->tm_min));
-	rtc_write (RTC_SEC_REG_ADDR, bin2bcd (tmp->tm_sec));
-
-	return 0;
-}
-
-/*
- * Reset the RTC.  We also enable the oscillator output on the
- * SQW/INTB* pin and program it for 32,768 Hz output. Note that
- * according to the datasheet, turning on the square wave output
- * increases the current drain on the backup battery from about
- * 600 nA to 2uA. Define CONFIG_RTC_DS1337_NOOSC if you wish to turn
- * off the OSC output.
- */
-
-#ifdef CONFIG_RTC_DS1337_NOOSC
- #define RTC_DS1337_RESET_VAL \
-	(RTC_CTL_BIT_INTCN | RTC_CTL_BIT_RS1 | RTC_CTL_BIT_RS2)
-#else
- #define RTC_DS1337_RESET_VAL (RTC_CTL_BIT_RS1 | RTC_CTL_BIT_RS2)
-#endif
-void rtc_reset (void)
-{
-#ifdef CONFIG_RTC_DS1337
-	rtc_write (RTC_CTL_REG_ADDR, RTC_DS1337_RESET_VAL);
-#elif defined CONFIG_RTC_DS1388
-	rtc_write(RTC_CTL_REG_ADDR, 0x0); /* hw default */
-#endif
-#ifdef CONFIG_RTC_DS1339_TCR_VAL
-	rtc_write (RTC_TC_REG_ADDR, CONFIG_RTC_DS1339_TCR_VAL);
-#endif
-#ifdef CONFIG_RTC_DS1388_TCR_VAL
-	rtc_write(RTC_TC_REG_ADDR, CONFIG_RTC_DS1388_TCR_VAL);
-#endif
-}
-
-/*
- * Helper functions
- */
-
-static
-uchar rtc_read (uchar reg)
-{
-	return (i2c_reg_read (CFG_SYS_I2C_RTC_ADDR, reg));
-}
-
-static void rtc_write (uchar reg, uchar val)
-{
-	i2c_reg_write (CFG_SYS_I2C_RTC_ADDR, reg, val);
-}
-#else
 static uchar rtc_read(struct udevice *dev, uchar reg)
 {
 	return dm_i2c_reg_read(dev, reg);
@@ -213,11 +74,6 @@ static int ds1337_rtc_get(struct udevice *dev, struct rtc_time *tmp)
 	mon_cent = rtc_read(dev, RTC_MON_REG_ADDR);
 	year = rtc_read(dev, RTC_YR_REG_ADDR);
 
-	/* No century bit, assume year 2000 */
-#ifdef CONFIG_RTC_DS1388
-	mon_cent |= 0x80;
-#endif
-
 	debug("Get RTC year: %02x mon/cent: %02x mday: %02x wday: %02x\n",
 	      year, mon_cent, mday, wday);
 	debug("hr: %02x min: %02x sec: %02x control: %02x status: %02x\n",
@@ -278,17 +134,8 @@ static int ds1337_rtc_set(struct udevice *dev, const struct rtc_time *tmp)
 #endif
 static int ds1337_rtc_reset(struct udevice *dev)
 {
-#ifdef CONFIG_RTC_DS1337
 	rtc_write(dev, RTC_CTL_REG_ADDR, RTC_DS1337_RESET_VAL);
-#elif defined CONFIG_RTC_DS1388
-	rtc_write(dev, RTC_CTL_REG_ADDR, 0x0); /* hw default */
-#endif
-#ifdef CONFIG_RTC_DS1339_TCR_VAL
-	rtc_write(dev, RTC_TC_REG_ADDR, CONFIG_RTC_DS1339_TCR_VAL);
-#endif
-#ifdef CONFIG_RTC_DS1388_TCR_VAL
-	rtc_write(dev, RTC_TC_REG_ADDR, CONFIG_RTC_DS1388_TCR_VAL);
-#endif
+
 	return 0;
 }
 
@@ -311,4 +158,3 @@ U_BOOT_DRIVER(rtc_ds1337) = {
 	.of_match = ds1337_rtc_ids,
 	.ops    = &ds1337_rtc_ops,
 };
-#endif
-- 
2.43.0

