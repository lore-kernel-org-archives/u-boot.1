Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D857FF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:25:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA02984348;
	Sat, 25 Apr 2026 18:25:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="kuF58Srf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CBAC83FB0; Sat, 25 Apr 2026 18:25:16 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72AE08432A
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:25:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb.. (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 7A2F81FE9C;
 Fri, 24 Apr 2026 10:45:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1777020356;
 bh=agByQXGGaIrOFB1nL4lo4z3k1us/x+W8lr0GUM7F0HY=; h=From:To:Subject;
 b=kuF58SrfSh1/xCPE7xAFVvWEMBNWIasOfuVJCp7BR8T8C2RusSLWpCnFm3vDVgskx
 SoRcwYlFUaJqg72+GcuJcyJlzvm8R2Tg/lORJ4UFE6L11QoenNLSsOmvvx6Ig2XIuY
 gAnFaqVkO9u+GY7HF7GszeV09EXusoGam/GnutdgWavyko4qgv3+CCU1Br+kBdCYnP
 YU2BnlD0ZBZ99e4xShV+Ny7DGU57o+g2lkcbgkJJLNHC1EBbUWLwVxaYGYtQONn6UE
 FOfg5L5pu3kEDKPl/0c+4n8VSgCA89lJDwWQtSCkhIeZonUVDMNJgYQoCkW7grDQr0
 yWQq0NafHZTLA==
From: Francesco Dolcini <francesco@dolcini.it>
To: Tom Rini <trini@konsulko.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	u-boot@lists.denx.de
Subject: [PATCH] rtc: ds1307: Remove legacy non-DM code
Date: Fri, 24 Apr 2026 10:45:44 +0200
Message-ID: <20260424084546.260786-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
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

From: Francesco Dolcini <francesco.dolcini@toradex.com>

The DS1307 driver depends on DM_RTC since commit d425d6056e01 ("rtc: Add
DM support to ds1307"), remove the related obsolete code.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 drivers/rtc/ds1307.c | 152 -------------------------------------------
 1 file changed, 152 deletions(-)

diff --git a/drivers/rtc/ds1307.c b/drivers/rtc/ds1307.c
index 049210991014..34d8f8c5276b 100644
--- a/drivers/rtc/ds1307.c
+++ b/drivers/rtc/ds1307.c
@@ -68,157 +68,6 @@ enum ds_type {
 #define MCP7941X_BIT_ST		0x80
 #define MCP7941X_BIT_VBATEN	0x08
 
-#ifndef CONFIG_DM_RTC
-
-/*---------------------------------------------------------------------*/
-#undef DEBUG_RTC
-
-#ifdef DEBUG_RTC
-#define DEBUGR(fmt, args...) printf(fmt, ##args)
-#else
-#define DEBUGR(fmt, args...)
-#endif
-/*---------------------------------------------------------------------*/
-
-#ifndef CFG_SYS_I2C_RTC_ADDR
-# define CFG_SYS_I2C_RTC_ADDR	0x68
-#endif
-
-#if defined(CONFIG_RTC_DS1307) && (CONFIG_SYS_I2C_SPEED > 100000)
-# error The DS1307 is specified only up to 100kHz!
-#endif
-
-static uchar rtc_read (uchar reg);
-static void rtc_write (uchar reg, uchar val);
-
-/*
- * Get the current time from the RTC
- */
-int rtc_get (struct rtc_time *tmp)
-{
-	int rel = 0;
-	uchar sec, min, hour, mday, wday, mon, year;
-
-#ifdef CONFIG_RTC_MCP79411
-read_rtc:
-#endif
-	sec = rtc_read (RTC_SEC_REG_ADDR);
-	min = rtc_read (RTC_MIN_REG_ADDR);
-	hour = rtc_read (RTC_HR_REG_ADDR);
-	wday = rtc_read (RTC_DAY_REG_ADDR);
-	mday = rtc_read (RTC_DATE_REG_ADDR);
-	mon = rtc_read (RTC_MON_REG_ADDR);
-	year = rtc_read (RTC_YR_REG_ADDR);
-
-	DEBUGR ("Get RTC year: %02x mon: %02x mday: %02x wday: %02x "
-		"hr: %02x min: %02x sec: %02x\n",
-		year, mon, mday, wday, hour, min, sec);
-
-#ifdef CONFIG_RTC_DS1307
-	if (sec & RTC_SEC_BIT_CH) {
-		printf ("### Warning: RTC oscillator has stopped\n");
-		/* clear the CH flag */
-		rtc_write (RTC_SEC_REG_ADDR,
-			   rtc_read (RTC_SEC_REG_ADDR) & ~RTC_SEC_BIT_CH);
-		rel = -1;
-	}
-#endif
-
-#ifdef CONFIG_RTC_MCP79411
-	/* make sure that the backup battery is enabled */
-	if (!(wday & MCP7941X_BIT_VBATEN)) {
-		rtc_write(RTC_DAY_REG_ADDR,
-			  wday | MCP7941X_BIT_VBATEN);
-	}
-
-	/* clock halted?  turn it on, so clock can tick. */
-	if (!(sec & MCP7941X_BIT_ST)) {
-		rtc_write(RTC_SEC_REG_ADDR, MCP7941X_BIT_ST);
-		printf("Started RTC\n");
-		goto read_rtc;
-	}
-#endif
-
-	tmp->tm_sec  = bcd2bin (sec & 0x7F);
-	tmp->tm_min  = bcd2bin (min & 0x7F);
-	tmp->tm_hour = bcd2bin (hour & 0x3F);
-	tmp->tm_mday = bcd2bin (mday & 0x3F);
-	tmp->tm_mon  = bcd2bin (mon & 0x1F);
-	tmp->tm_year = bcd2bin (year) + ( bcd2bin (year) >= 70 ? 1900 : 2000);
-	tmp->tm_wday = bcd2bin ((wday - 1) & 0x07);
-	tmp->tm_yday = 0;
-	tmp->tm_isdst= 0;
-
-	DEBUGR ("Get DATE: %4d-%02d-%02d (wday=%d)  TIME: %2d:%02d:%02d\n",
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
-	DEBUGR ("Set DATE: %4d-%02d-%02d (wday=%d)  TIME: %2d:%02d:%02d\n",
-		tmp->tm_year, tmp->tm_mon, tmp->tm_mday, tmp->tm_wday,
-		tmp->tm_hour, tmp->tm_min, tmp->tm_sec);
-
-	if (tmp->tm_year < 1970 || tmp->tm_year > 2069)
-		printf("WARNING: year should be between 1970 and 2069!\n");
-
-	rtc_write (RTC_YR_REG_ADDR, bin2bcd (tmp->tm_year % 100));
-	rtc_write (RTC_MON_REG_ADDR, bin2bcd (tmp->tm_mon));
-#ifdef CONFIG_RTC_MCP79411
-	rtc_write (RTC_DAY_REG_ADDR,
-		   bin2bcd (tmp->tm_wday + 1) | MCP7941X_BIT_VBATEN);
-#else
-	rtc_write (RTC_DAY_REG_ADDR, bin2bcd (tmp->tm_wday + 1));
-#endif
-	rtc_write (RTC_DATE_REG_ADDR, bin2bcd (tmp->tm_mday));
-	rtc_write (RTC_HR_REG_ADDR, bin2bcd (tmp->tm_hour));
-	rtc_write (RTC_MIN_REG_ADDR, bin2bcd (tmp->tm_min));
-#ifdef CONFIG_RTC_MCP79411
-	rtc_write (RTC_SEC_REG_ADDR, bin2bcd (tmp->tm_sec) | MCP7941X_BIT_ST);
-#else
-	rtc_write (RTC_SEC_REG_ADDR, bin2bcd (tmp->tm_sec));
-#endif
-
-	return 0;
-}
-
-/*
- * Reset the RTC. We setting the date back to 1970-01-01.
- * We also enable the oscillator output on the SQW/OUT pin and program
- * it for 32,768 Hz output. Note that according to the datasheet, turning
- * on the square wave output increases the current drain on the backup
- * battery to something between 480nA and 800nA.
- */
-void rtc_reset (void)
-{
-	rtc_write (RTC_SEC_REG_ADDR, 0x00);	/* clearing Clock Halt	*/
-	rtc_write (RTC_CTL_REG_ADDR, RTC_CTL_BIT_SQWE | RTC_CTL_BIT_RS1 | RTC_CTL_BIT_RS0);
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
-
-#endif /* !CONFIG_DM_RTC */
-
-#ifdef CONFIG_DM_RTC
 static int ds1307_rtc_set(struct udevice *dev, const struct rtc_time *tm)
 {
 	int ret;
@@ -366,4 +215,3 @@ U_BOOT_DRIVER(rtc_ds1307) = {
 	.of_match = ds1307_rtc_ids,
 	.ops	= &ds1307_rtc_ops,
 };
-#endif /* CONFIG_DM_RTC */
-- 
2.47.3

