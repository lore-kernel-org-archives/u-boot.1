Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE25CC61DB9
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 13:30:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7318B80F10;
	Fri, 28 Aug 2026 13:30:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wu0hYaOKBdwN; Fri, 28 Aug 2026 13:30:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787923814;
	bh=1xueCMjKwPBCR+ZAogKZugtshq4fvOECeo4l0D/MsQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mC1/18dEKj/4mdhUWvcRKFt8maDbv9syxSVVevEjr1q/2gOk5z/TX3dkpTn/MDku0
	 MMKPMGGjm47bgtr8zY1hPOeglEWnmg3P1m5NSGWJ46xexP2wcJXPVxwC57hfjsVMDY
	 qwP1aYR08K5yETJHLldVMItsSCCI/I1IUr1ksmJQJw0Ffdh8So5Y/pBz436VHGCXT2
	 T0lAH24e2iiKc4WQbtvkJ9EqGfMYdyOQa9jvFrzmCx4jhnoZvp5eIev2yFa3YtypJg
	 MFKscvCG09w8w984JFGHy7IBuc59BmQj0o0Q+8igeJCsQwqqJtyJLiq/smBcyRHsJt
	 AOtS485rA3Rsw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A8FF80F12;
	Fri, 28 Aug 2026 13:30:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id F30A3336
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:30:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D90B480F12
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:30:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9bvcYXHPGcYe for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 13:30:12 +0000 (UTC)
X-Greylist: delayed 981 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 28 Aug 2026 13:30:11 UTC
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=B/LkDXq5
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=alexander.feilke@ew.tq-group.com;
 receiver=<UNKNOWN> 
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A9E7D80F10
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=1xueCMjKwPBCR+ZAogKZugtshq4fvOECeo4l0D/MsQQ=; b=B/LkDXq5nGUdThz2cfFdKiaxsk
 sRiA2QzXkEOEKQOgZbCzrWiiovF/akKFWVRRn5vZLofazaimZ8fMCjaKYNzPJZJzyNy+PAgdKGd+1
 XT7QDY7NJYJd7g8Ed+uYE5KSg+A/eRBTQTF9fjA+54x6n1khuLnhuEnT0fMelGc9QVZPOPu9sxLV+
 YP+4mLPaCrB0y0oFYBF1n1N6/0uIfTGYS2ZGua2HOBmKBKK1HK5WxAxEEOuVzOC+7Y6K9GmlVH0lf
 hITWjTEd6IUYWd3EauV0Om/1veOqOp6/UVixXfUlGkuf933vavSBhDluJlveM+EAnm8YBgHl2wBWQ
 SsBXZKvA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wzwOx-0009cu-0z; Fri, 28 Aug 2026 15:13:47 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy06.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wzwOx-0001qv-01; Fri, 28 Aug 2026 15:13:47 +0200
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: u-boot@lists.u-boot-project.org
Cc: Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] rtc: ds1307: add initial support for EPSON RX8025
Date: Fri, 28 Aug 2026 15:12:59 +0200
Message-ID: <20260828131302.2176223-2-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828131302.2176223-1-Alexander.Feilke@ew.tq-group.com>
References: <20260828131302.2176223-1-Alexander.Feilke@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28106/Fri Aug 28 08:27:08 2026)
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Alexander Feilke <alexander.feilke@ew.tq-group.com>

Add support for the EPSON RX8025 RTC. The date/time registers of this
chip are compatible with the DS1307.

Inspired by Linux 6.18 driver code.

Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
---
 drivers/rtc/ds1307.c | 137 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 134 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/ds1307.c b/drivers/rtc/ds1307.c
index db9bf43214c..eb53a531492 100644
--- a/drivers/rtc/ds1307.c
+++ b/drivers/rtc/ds1307.c
@@ -16,6 +16,7 @@
 #include <config.h>
 #include <command.h>
 #include <dm.h>
+#include <linux/delay.h>
 #include <log.h>
 #include <rtc.h>
 #include <i2c.h>
@@ -27,6 +28,7 @@ enum ds_type {
 	ds_1340,
 	m41t11,
 	mcp794xx,
+	rx_8130,
 };
 
 struct rtc_ds1370_data {
@@ -73,6 +75,28 @@ struct rtc_ds1370_data {
 #define MCP7941X_BIT_ST		0x80
 #define MCP7941X_BIT_VBATEN	0x08
 
+/* RX8130-specific bits */
+#define RX8130_REG_ALARM_MIN		0x17
+#define RX8130_REG_ALARM_HOUR		0x18
+#define RX8130_REG_ALARM_WEEK_OR_DAY	0x19
+#define RX8130_REG_EXTENSION		0x1c
+#define RX8130_REG_EXTENSION_TE		BIT(4)
+#define RX8130_REG_EXTENSION_USEL	BIT(5)
+#define RX8130_REG_EXTENSION_FSEL0	BIT(6)
+#define RX8130_REG_EXTENSION_FESL1	BIT(7)
+#define RX8130_REG_FLAG			0x1d
+#define RX8130_REG_FLAG_VLF		BIT(1)
+#define RX8130_REG_FLAG_AF		BIT(3)
+#define RX8130_REG_CONTROL0		0x1e
+#define RX8130_REG_CONTROL0_AIE		BIT(3)
+#define RX8130_REG_CONTROL0_TIE		BIT(4)
+#define RX8130_REG_CONTROL0_UIE		BIT(5)
+#define RX8130_REG_CONTROL0_STOP	BIT(6)
+#define RX8130_REG_CONTROL0_TEST	BIT(7)
+#define RX8130_REG_CONTROL1		0x1f
+#define RX8130_REG_CONTROL1_INIEN	BIT(4)
+#define RX8130_REG_CONTROL1_CHGEN	BIT(5)
+
 static int ds1307_rtc_set(struct udevice *dev, const struct rtc_time *tm)
 {
 	int ret;
@@ -88,7 +112,11 @@ static int ds1307_rtc_set(struct udevice *dev, const struct rtc_time *tm)
 
 	buf[RTC_YR_REG_ADDR] = bin2bcd(tm->tm_year % 100);
 	buf[RTC_MON_REG_ADDR] = bin2bcd(tm->tm_mon);
-	buf[RTC_DAY_REG_ADDR] = bin2bcd(tm->tm_wday + 1);
+	/* rx8130 is bit position, not BCD */
+	if (data->type == rx_8130)
+		buf[RTC_DAY_REG_ADDR] = 1 << tm->tm_wday;
+	else
+		buf[RTC_DAY_REG_ADDR] = bin2bcd(tm->tm_wday + 1);
 	buf[RTC_DATE_REG_ADDR] = bin2bcd(tm->tm_mday);
 	buf[RTC_HR_REG_ADDR] = bin2bcd(tm->tm_hour);
 	buf[RTC_MIN_REG_ADDR] = bin2bcd(tm->tm_min);
@@ -97,6 +125,10 @@ static int ds1307_rtc_set(struct udevice *dev, const struct rtc_time *tm)
 	if (data->type == mcp794xx) {
 		buf[RTC_DAY_REG_ADDR] |= MCP7941X_BIT_VBATEN;
 		buf[RTC_SEC_REG_ADDR] |= MCP7941X_BIT_ST;
+	} else if (data->type == rx_8130) {
+		ret = dm_i2c_reg_clrset(dev, RX8130_REG_CONTROL0, 0, RX8130_REG_CONTROL0_STOP);
+		if (ret < 0)
+			return ret;
 	}
 
 	ret = dm_i2c_write(dev, data->offset, buf, sizeof(buf));
@@ -105,7 +137,18 @@ static int ds1307_rtc_set(struct udevice *dev, const struct rtc_time *tm)
 
 	if (data->type == ds_1337) {
 		/* Ensure oscillator is enabled */
-		dm_i2c_reg_write(dev, plat->offset + DS1337_CTL_REG_ADDR, 0);
+		dm_i2c_reg_write(dev, data->offset + DS1337_CTL_REG_ADDR, 0);
+	} else if (data->type == rx_8130) {
+		ret = dm_i2c_reg_clrset(dev, RX8130_REG_CONTROL0, RX8130_REG_CONTROL0_STOP, 0);
+		if (ret < 0)
+			return ret;
+
+		/* clear Voltage Loss Flag as data is available now */
+		ret = dm_i2c_reg_clrset(dev, RX8130_REG_FLAG, RX8130_REG_FLAG_VLF, 0);
+		if (ret < 0) {
+			printf("RTC: write VLF error %d\n", ret);
+			return ret;
+		}
 	}
 
 	return 0;
@@ -131,6 +174,17 @@ static int ds1307_rtc_get(struct udevice *dev, struct rtc_time *tm)
 			/* clear the OSF flag */
 			dm_i2c_reg_write(dev, data->offset + reg, status & ~RTC_STAT_BIT_OSF);
 		}
+	} else if (data->type == rx_8130) {
+		ret = dm_i2c_reg_read(dev, RX8130_REG_FLAG);
+		if (ret < 0) {
+			printf("RTC: read error %d\n", ret);
+			return ret;
+		}
+
+		if (ret & RX8130_REG_FLAG_VLF) {
+			printf("RTC: oscillator failed, set time!\n");
+			return -EINVAL;
+		}
 	}
 
 	tm->tm_sec  = bcd2bin(buf[RTC_SEC_REG_ADDR] & 0x7F);
@@ -141,7 +195,11 @@ static int ds1307_rtc_get(struct udevice *dev, struct rtc_time *tm)
 	tm->tm_year = bcd2bin(buf[RTC_YR_REG_ADDR]) +
 			      (bcd2bin(buf[RTC_YR_REG_ADDR]) >= 70 ?
 			       1900 : 2000);
-	tm->tm_wday = bcd2bin((buf[RTC_DAY_REG_ADDR] - 1) & 0x07);
+	/* rx8130 is bit position, not BCD */
+	if (data->type == rx_8130)
+		tm->tm_wday = fls(buf[RTC_DAY_REG_ADDR] & 0x07);
+	else
+		tm->tm_wday = bcd2bin((buf[RTC_DAY_REG_ADDR] - 1) & 0x07);
 	tm->tm_yday = 0;
 	tm->tm_isdst = 0;
 
@@ -152,11 +210,78 @@ static int ds1307_rtc_get(struct udevice *dev, struct rtc_time *tm)
 	return 0;
 }
 
+int ds1307_rx8130_rtc_reset(struct udevice *dev) {
+	/*
+	 * RX8130CE manual, 18.2 Software Reset
+	 */
+	const uint8_t reg_address[]  = { 0x1e, 0x1e, 0x50, 0x53, 0x66, 0x6b, 0x6b };
+	const uint8_t reg_sequence[] = { 0x00, 0x80, 0x6c, 0x01, 0x03, 0x02, 0x01 };
+	int ret = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(reg_sequence); ++i) {
+		ret = dm_i2c_reg_write(dev, reg_address[i], reg_sequence[i]);
+		if (ret < 0)
+			return ret;
+	}
+
+	mdelay(150);
+
+	/* Dummy read before reading FLAG register */
+	ret = dm_i2c_reg_read(dev, RX8130_REG_FLAG);
+	ret = dm_i2c_reg_read(dev, RX8130_REG_FLAG);
+	if (ret < 0)
+		return ret;
+
+	while (ret >= 0 && (ret & RX8130_REG_FLAG_VLF)) {
+		ret &= ~RX8130_REG_FLAG_VLF;
+		dm_i2c_reg_write(dev, RX8130_REG_FLAG, ret);
+		mdelay(1);
+		ret = dm_i2c_reg_read(dev, RX8130_REG_FLAG);
+	}
+	printf("rx8130 VLF cleared: %d\n", ret);
+
+	/* Clear TE bit and Disable FOUT */
+	if (ret >= 0)
+		ret = dm_i2c_reg_clrset(dev, RX8130_REG_EXTENSION, RX8130_REG_EXTENSION_TE,
+			RX8130_REG_EXTENSION_FSEL0 | RX8130_REG_EXTENSION_FESL1);
+
+	/* Clear VLF bit */
+	if (ret >= 0)
+		ret = dm_i2c_reg_clrset(dev, RX8130_REG_FLAG, RX8130_REG_FLAG_VLF, 0);
+
+	/* Clear TEST, AIE, TIE, UIE for inhibit interrupt output of suddenness */
+	if (ret >= 0)
+		ret = dm_i2c_reg_clrset(dev, RX8130_REG_CONTROL0, RX8130_REG_CONTROL0_TEST |
+			RX8130_REG_CONTROL0_AIE |  RX8130_REG_CONTROL0_TIE |
+			RX8130_REG_CONTROL0_UIE, 0);
+
+	/* Set INIEN to 1 */
+	if (ret >= 0)
+		ret = dm_i2c_reg_clrset(dev, RX8130_REG_CONTROL1, 0, RX8130_REG_CONTROL1_INIEN);
+
+	/* Set CHGEN to 0 */
+	if (ret >= 0)
+		ret = dm_i2c_reg_clrset(dev, RX8130_REG_CONTROL1, RX8130_REG_CONTROL1_CHGEN, 0);
+
+	/* Start clock */
+	if (ret >= 0)
+		ret = dm_i2c_reg_clrset(dev, RX8130_REG_CONTROL0, RX8130_REG_CONTROL0_STOP, 0);
+
+	return ret;
+}
+
 static int ds1307_rtc_reset(struct udevice *dev)
 {
 	int ret;
 	struct rtc_ds1370_data *data = (void*)dev_get_driver_data(dev);
 
+	if (data->type == rx_8130) {
+		ret = ds1307_rx8130_rtc_reset(dev);
+		if (ret < 0)
+			return ret;
+	}
+
 	/*
 	 * reset clock/oscillator in the seconds register:
 	 * on DS1307 bit 7 enables Clock Halt (CH),
@@ -222,6 +347,11 @@ static const struct rtc_ds1370_data ds_1340_data = {
 	.offset = 0,
 };
 
+static const struct rtc_ds1370_data rx_8130_data = {
+	.type   = rx_8130,
+	.offset = 0x10,
+};
+
 static const struct rtc_ds1370_data mcp794xx_data = {
 	.type   = mcp794xx,
 	.offset = 0,
@@ -237,6 +367,7 @@ static const struct udevice_id ds1307_rtc_ids[] = {
 	{ .compatible = "dallas,ds1337", .data = (ulong)&ds_1337_data },
 	{ .compatible = "dallas,ds1339", .data = (ulong)&ds_1339_data },
 	{ .compatible = "dallas,ds1340", .data = (ulong)&ds_1340_data },
+	{ .compatible = "epson,rx8130", .data = (ulong)&rx_8130_data },
 	{ .compatible = "microchip,mcp7940x", .data = (ulong)&mcp794xx_data },
 	{ .compatible = "microchip,mcp7941x", .data = (ulong)&mcp794xx_data },
 	{ .compatible = "st,m41t11", .data = (ulong)&m41t11_data },
-- 
2.43.0

