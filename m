Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C447C79F82
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 13:08:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9C38740555;
	Tue,  8 Sep 2026 13:08:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oJCZ2YXoa47F; Tue,  8 Sep 2026 13:08:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2DE43405FF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788872898;
	b=Iemk639vlvQ8uwdUG04rC/Ni+FvJwHtGO8ShukldvSTJdpl+KJzzo6UeF9wvLiWV3Vch
	 +jmoMbYzhdsNVHWLIP+2G7M0BqzbfUYHjEq3gkeh0nlXf7qHDy1oO+4Jv7RPNwVoES5JQ
	 oxXmhCjYwTW5rsCtPlvkrb2EVZtwhHasxjZ7PNjvcBbDyyZ0TAQm29b07ydaYssEbA6q3
	 Demo3/rQeC1M4Q/8TBNeP4KZI622hiItqxUXh2GN4I6g4LVwUFxSNkF2azLw4EkCKVowa
	 yu9rF2JtCqZCaEePs2NuiBrfGSSld4NVJ3Sp0w9fuV0aBHDTsYl2bLxIfQfZRhFj1HA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788872898;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=lchtoFEiE5JhYyvlv5MXqTdwB2SbLuYNqHad77SJqn0=;
	b=LjHn04/QIQFF3fFg4SPi/mxbywSUxJojabLqKT/AxDjtkEhEffU05s+D+hBVmnx22dXJ
	 oT5QEOffdAt6KGamAZgMke9LR3xjq9XmQoZZHlV59QcvImRxFIlY96IFYQ3beMqsk5jN8
	 nYY9xR3WAmatcN9tRf68yk21WawzlfxV+wdbAFdsJbzF0TSujGbKYLhfd64oVdFrwNQDX
	 CTZ0bqm5C2ztFh4PTTwk/kRRBdqhidDsM2qOMx0ZhfrGBi2Rgid2TnOpcszVOcbZsRfIZ
	 cnLLZ7O5QckbMyT3z3SSgOpZduxJhcSAIxu6n3BzSmEhJq1L0N0WTYoOh1fikCt9RuQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788872898;
	bh=lchtoFEiE5JhYyvlv5MXqTdwB2SbLuYNqHad77SJqn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ak0kDW8h0A128oKhabiLOiJygp8Q+dpUjNAGlQMAKi1W4+bCWBxr+hEMy0qGmhU1h
	 VNsya5K4hfoimRzZX+36kNv/ZL5fdACPUM1wb2quCJrVn5Q0+m6PhBRHROurwdyw7y
	 L5XpRx1Ca3OAtISregTeFWZMormO6mg9wcHlK6Zub7fe37zEpUV1Gc+9s6YrjNH/or
	 KF6a22ejjbA94zUpFazfdWJz5GDsgOs3hzP3CnZg9rVCdPy262ABZSf/OhjueDryDV
	 AQSHnbE3wk+YBcIGdO8ZidLUMKnwm5gOl51knHV6UV6/NGZdQTSVQjVCB1UvLUdyjL
	 My0BUNyWrPwaQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2DE43405FF;
	Tue,  8 Sep 2026 13:08:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 970CA372
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 13:08:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7DEC9400CD
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 13:08:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b7oV0B6LhBMc for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 13:08:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org E23B340165
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788872893;
 b=WQZl4TlZYu0UqxDeHbnwJraqPYZQjAdRXJ/3OwgpdB0H9ET3izQlGDx2rwno4W9ImbyK
 2B4rwFHSlrscu2rv4aB6qvYwMi2fTWAXxTjlCTHFZB/6R7Z1nKLGh2H56uRjMCMf/SJOp
 rRoaucqj5+gWV/A0EJaak3k9BuiLWqsvkKQNU1jwjNyIowBJ1g9ag+111/orAxY96ue/Q
 xySzhjZ+NAxQelHJ6XXIwW6wnL6DKN9ejk/ywnD67D6YRMFIbBbkXoxxN1ANB3aoJS0ct
 Qp7GccMFo7dcsxQVmA8dLBjO0yirA+4YrzojaLA3eQ29RcfdHMg4lapFG2ab02NuUrA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788872893;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Virus-Scanned;
 bh=lchtoFEiE5JhYyvlv5MXqTdwB2SbLuYNqHad77SJqn0=;
 b=cCFDQ/vNU9A8tk1mvFe4ogUFfHQWnEmwIsR3GuE5Yp88RLD+vkiKqq0a2pf0Og4o7Pfx
 RGwOCOOc29pApotsEV960UX91BGbMJGf2M3JEyNWmu+mQVFyaUcKOrHNN1gHbXz+jg45v
 8loptMmE0KXjBYAeP/WhbeZAF5Ra2brLQ7ixzad2iLYxHwxp7AiTd4m/lGiNTg9xI5abM
 R3UJpEdCveatLZG6HwL9yFTo9CjMgqnCUvYR4ojgO3qjxkmXrWD5N9FmOyhpVNCAP8RMd
 c0+fsWixaFNPrkoqfHPkKWp7q8Wm8KOwMntny/cdtxpH0+9R88m9l+KKiZaiH8rLWWg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=ew.tq-group.com; 
 dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=ppF3bI6E; 
 arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=alexander.feilke@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=ppF3bI6E
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E23B340165
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 13:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=lchtoFEiE5JhYyvlv5MXqTdwB2SbLuYNqHad77SJqn0=; b=ppF3bI6EXydxNlRi90uJPcymou
 l9j4vZ7pJ0I75/MMSHr5cQDptNA7TZUj9bP5CdFGQRP+eHCYVSqLdYpnIaVqqIh85x/2N/GOCYLsi
 LgbGIIsLDmzTkGNdq3jaXqN2DxJWEUlbgc9dPiW/6Be5ugOFFMj7uAf795FNpzs/kE3K85ESLzgHn
 pdl+h2aaOncEyqEPvxoRK9DAMJLU0TcEi5A2ZLbYHX+pCBh3ZVPW40wmSjxjJ+7mCVETHyyg9QoZE
 gLTzlFledejSXEfYW1TZ4e07or0cn2J9GCc/6/iLKADmhMYzdGAJWF1PGqXc5xNuheN17SUkuEi0D
 lMv/Z5Pw==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1x3vYY-000JXn-1e; Tue, 08 Sep 2026 15:08:10 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1x3vYY-000F8P-0l; Tue, 08 Sep 2026 15:08:10 +0200
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: u-boot@lists.u-boot-project.org
Cc: Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/2] rtc: ds1307: add initial support for EPSON RX8130
Date: Tue,  8 Sep 2026 15:07:59 +0200
Message-ID: <20260908130800.1144691-2-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908130800.1144691-1-Alexander.Feilke@ew.tq-group.com>
References: <20260908130800.1144691-1-Alexander.Feilke@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28117/Tue Sep  8 08:26:31 2026)
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

Add support for the EPSON RX8130 RTC. The date/time registers of this
chip are compatible with the DS1307.

Inspired by Linux 6.18 rtc-ds1307 driver code.

Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
---
Changes in V2:
- Fix indentation
- Fix mention of RX8025 instead of RX8130
---
 drivers/rtc/ds1307.c | 137 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 134 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/ds1307.c b/drivers/rtc/ds1307.c
index db9bf43214c..089c5a3facb 100644
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
+					RX8130_REG_EXTENSION_FSEL0 | RX8130_REG_EXTENSION_FESL1);
+
+	/* Clear VLF bit */
+	if (ret >= 0)
+		ret = dm_i2c_reg_clrset(dev, RX8130_REG_FLAG, RX8130_REG_FLAG_VLF, 0);
+
+	/* Clear TEST, AIE, TIE, UIE for inhibit interrupt output of suddenness */
+	if (ret >= 0)
+		ret = dm_i2c_reg_clrset(dev, RX8130_REG_CONTROL0, RX8130_REG_CONTROL0_TEST |
+					RX8130_REG_CONTROL0_AIE |  RX8130_REG_CONTROL0_TIE |
+					RX8130_REG_CONTROL0_UIE, 0);
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

