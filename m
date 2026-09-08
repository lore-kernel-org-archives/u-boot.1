Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98FADC79F82
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 13:08:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 34E4040582;
	Tue,  8 Sep 2026 13:08:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jSoUxHV08yBw; Tue,  8 Sep 2026 13:08:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3AB034058B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788872896;
	b=Uyi7JxykwzavUpqVOB7MShllI8F3n7cd2YpAdivwKnvm/ei3I8E66y4nBTHjZLgDJeGU
	 gTOQU3MwqXlUx1iZv7GDGkck02vKuEDpw9MUqXHmwKmrCdZ52UEQefzGfd8fz7G+4so++
	 Q/CgmfVZorBooqG3jEGqykrr7FRezSfYGDMCo/GCsuGsW/mivqTiCbmQUgYeqVaaV3+uo
	 WTZfUUe6sraqrs5b2MfgX4WBIboOK+ta6wwUY2oEteqvRJJfKSAuiUHfQYBYwURAC5kou
	 qqTTCRhIauFl/wDcC0+dN6lBh7N0xEwoRc4ijOSeWf4yRGGFfwoPhjN2xLP62MeGwtg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788872896;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Virus-Scanned:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Q+xmK0LtwG9aWKzBSVZ7+UQZzCvCOUc+VPUloWA7r58=;
	b=ZhuvLzOvnGLEazsz8UPKf27xO/ceQ6KNxXOBbUEz/YL8iqit8SVsxzAOBHcH75tTEl6l
	 Nv2LyxdN8Jv9vJacEUOu69sCqXYXaVzc5rebMYl97nQ8qHDopFgdJX3O2IcRDZmtd3n9E
	 342DKy0FtW/hhlPt7+NHVxxuB9HiDsLgXouxVXqz5NDEb8ABiUxtT85oyKKApiWRKi2Pq
	 MD19/Y/hlVRy9bf/ZkITywatuYq+wF6baeYZ5Tt6Utsh6RnqZn0q1FzX5vFgIjQuN06zR
	 FYasa+wpM9DqcpPWiuBMI3L1zkgKd0QPOOBlSgBrS+twwqhoSl5HKFGFqeGgV2vcguQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=ew.tq-group.com;
	dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=Dl6kZHus;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788872896;
	bh=Q+xmK0LtwG9aWKzBSVZ7+UQZzCvCOUc+VPUloWA7r58=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oofQpywelphqqO7c6itgZ+MfUug0f2h4mermJM2JqxU7G43IwphLGGZeRXs7WYcJ6
	 zk/C4VDoIBTcKnvqzbAg/2x0G/AiFYmSLaulfgUOoi7EbmwmeQwYqxY+JC7LT/VjsP
	 9x+3qRZdEpunmH83x0NzT08EYBMUnHWyWun1oYPRojyGtQJT7iKQji6Pfh4XuUwRpB
	 tmMND3jDXiwKxUwJzIXDkGTZv/+72j8xlpqOW3JyFVWHiOLOVCFMPDJfsQZwzjepw0
	 nrnEcD9ZYT9pI5YoWS6zgbCb6220Ob9YHdENveaBuQdGiyWHsMEqROhfsIQeHqxxJv
	 YyyGPr15Sm3lA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3AB034058B;
	Tue,  8 Sep 2026 13:08:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 30A1FD61
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 13:08:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2E3EC40555
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 13:08:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z5bw32M0D_z3 for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 13:08:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E211E40582
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788872893;
 b=N+Ahc8kHmUZEXq34TxHSqwW1RUgsmcyZmxfaLCSk9x0+E1xotn81nVZl+4259O739wMF
 IO1Ge5EqSuhu5PDSd6v5drG4kJXK1QRRSgC0JX5nc+zUP1H/foLy8IfmP7dVZwGO7Ibus
 xwpT7V+qlXjC5oXTCNWYEAYq97W69NU1SKcPGYoJta+o/+bpn3X+keIHs6GJyUCiwDWkg
 MyJMi6j1tmrGdZAUOE+rw5BVG6Pkmf/YDqeSkTcwfSc23ssaaQ6xZShKLZ0HTPokM+//S
 MQ2NMj1z4j6GAv4n+RK4diG1/+v1O/bunOqCUNTEcBNi0SFtEFkDsR30VP4A9b/boNg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788872893;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-Virus-Scanned;
 bh=Q+xmK0LtwG9aWKzBSVZ7+UQZzCvCOUc+VPUloWA7r58=;
 b=bTccog681xE2rAtvaLONt4xG554tp6G1bn0j4VHoB3UBeiqDvRnDPzfAJQx/yPZO20O/
 3Thvamwq7P5+WZBOz/d8e/mLpca/hho2Fklj8yMP+51TK5QDOb5RyqjoT+y0bLXr6bXQ4
 Ri+cT/uTH4U9tv6DhOmRLZAtwS4pL2gmGJAU3eqQLJkrXY8gmVT+VhNmPIxOgXnxxhqlA
 5Yd5PzCZqXDyDE0tswEpFi3fNAOa1jRtndnjLyBqvQAbQmeYUqiTSyqxI8y/K8jC3UiFj
 HfLC1CcJJsgVtEEBT9hJg36oCmCraEILOkFgUiVDUp8ADxh0+YRz0CmYiCBqfgwBmfA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=ew.tq-group.com; 
 dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=Dl6kZHus; 
 arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=alexander.feilke@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=Dl6kZHus
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E211E40582
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 13:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=Q+xmK0LtwG9aWKzBSVZ7+UQZzCvCOUc+VPUloWA7r58=; b=Dl6kZHusf8vSlCDKPb3pJVyfvD
 qgZ2KzEXhIvnssh4BkvEtjaO8P8KVvIeYH5c5HlrhppzGSIp7nt5ddx82x8Nt+F4np6fzWw6ccPJy
 UaW1yZt2wKuGRRFnA0v0mxonIoMoKLQ7RhYYoTCAOklYRQ+fgj3py/ZAbyIJX2nJ6Wb54wEw5Cj0Y
 0eFusUUKNg+oCZQb9dy3bHI8YixikRvUGBZF6vjH76RPRW8YV4OjBhoxaaHtPUIJKIryE4NoYALf0
 Sv3udUN+j6dd+9q8Y3aFhpIoeDfIJl6YZc0e8QvBrRe+XOtj7wKPxEX3bvYzMpCIDhtq3uPbFhkLi
 oWXRbjIQ==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1x3vYY-000JXi-12; Tue, 08 Sep 2026 15:08:10 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1x3vYY-000F8P-0D; Tue, 08 Sep 2026 15:08:10 +0200
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: u-boot@lists.u-boot-project.org
Cc: Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/2] rtc: ds1307: support register offsets
Date: Tue,  8 Sep 2026 15:07:58 +0200
Message-ID: <20260908130800.1144691-1-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
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

Convert the scalar type data to a data struct that also
contains a register offset for otherwise compatible RTCs.

Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
---
 drivers/rtc/ds1307.c | 87 +++++++++++++++++++++++++++++++-------------
 1 file changed, 61 insertions(+), 26 deletions(-)

diff --git a/drivers/rtc/ds1307.c b/drivers/rtc/ds1307.c
index 4176ab3701e..db9bf43214c 100644
--- a/drivers/rtc/ds1307.c
+++ b/drivers/rtc/ds1307.c
@@ -29,6 +29,11 @@ enum ds_type {
 	mcp794xx,
 };
 
+struct rtc_ds1370_data {
+	enum ds_type type;
+	int offset;
+};
+
 /*
  * RTC register addresses
  */
@@ -72,7 +77,7 @@ static int ds1307_rtc_set(struct udevice *dev, const struct rtc_time *tm)
 {
 	int ret;
 	uchar buf[7];
-	enum ds_type type = dev_get_driver_data(dev);
+	struct rtc_ds1370_data *data = (void*)dev_get_driver_data(dev);
 
 	debug("Set DATE: %4d-%02d-%02d (wday=%d)  TIME: %2d:%02d:%02d\n",
 	      tm->tm_year, tm->tm_mon, tm->tm_mday, tm->tm_wday,
@@ -89,18 +94,18 @@ static int ds1307_rtc_set(struct udevice *dev, const struct rtc_time *tm)
 	buf[RTC_MIN_REG_ADDR] = bin2bcd(tm->tm_min);
 	buf[RTC_SEC_REG_ADDR] = bin2bcd(tm->tm_sec);
 
-	if (type == mcp794xx) {
+	if (data->type == mcp794xx) {
 		buf[RTC_DAY_REG_ADDR] |= MCP7941X_BIT_VBATEN;
 		buf[RTC_SEC_REG_ADDR] |= MCP7941X_BIT_ST;
 	}
 
-	ret = dm_i2c_write(dev, 0, buf, sizeof(buf));
+	ret = dm_i2c_write(dev, data->offset, buf, sizeof(buf));
 	if (ret < 0)
 		return ret;
 
-	if (type == ds_1337) {
+	if (data->type == ds_1337) {
 		/* Ensure oscillator is enabled */
-		dm_i2c_reg_write(dev, DS1337_CTL_REG_ADDR, 0);
+		dm_i2c_reg_write(dev, plat->offset + DS1337_CTL_REG_ADDR, 0);
 	}
 
 	return 0;
@@ -110,21 +115,21 @@ static int ds1307_rtc_get(struct udevice *dev, struct rtc_time *tm)
 {
 	int ret;
 	uchar buf[7];
-	enum ds_type type = dev_get_driver_data(dev);
+	struct rtc_ds1370_data *data = (void*)dev_get_driver_data(dev);
 
-	ret = dm_i2c_read(dev, 0, buf, sizeof(buf));
+	ret = dm_i2c_read(dev, data->offset, buf, sizeof(buf));
 	if (ret < 0)
 		return ret;
 
-	if (type == ds_1337 || type == ds_1339 || type == ds_1340) {
-		uint reg = (type == ds_1340) ? DS1340_STAT_REG_ADDR :
+	if (data->type == ds_1337 || data->type == ds_1339 || data->type == ds_1340) {
+		uint reg = (data->type == ds_1340) ? DS1340_STAT_REG_ADDR :
 					       DS1337_STAT_REG_ADDR;
-		int status = dm_i2c_reg_read(dev, reg);
+		int status = dm_i2c_reg_read(dev, data->offset + reg);
 
 		if (status >= 0 && (status & RTC_STAT_BIT_OSF)) {
 			printf("### Warning: RTC oscillator has stopped\n");
 			/* clear the OSF flag */
-			dm_i2c_reg_write(dev, reg, status & ~RTC_STAT_BIT_OSF);
+			dm_i2c_reg_write(dev, data->offset + reg, status & ~RTC_STAT_BIT_OSF);
 		}
 	}
 
@@ -150,7 +155,7 @@ static int ds1307_rtc_get(struct udevice *dev, struct rtc_time *tm)
 static int ds1307_rtc_reset(struct udevice *dev)
 {
 	int ret;
-	enum ds_type type = dev_get_driver_data(dev);
+	struct rtc_ds1370_data *data = (void*)dev_get_driver_data(dev);
 
 	/*
 	 * reset clock/oscillator in the seconds register:
@@ -158,26 +163,26 @@ static int ds1307_rtc_reset(struct udevice *dev)
 	 * on DS1340 bit 7 disables the oscillator (not EOSC)
 	 * on MCP794xx bit 7 enables Start Oscillator (ST)
 	 */
-	ret = dm_i2c_reg_write(dev, RTC_SEC_REG_ADDR, 0x00);
+	ret = dm_i2c_reg_write(dev, data->offset + RTC_SEC_REG_ADDR, 0x00);
 	if (ret < 0)
 		return ret;
 
-	if (type == ds_1307) {
+	if (data->type == ds_1307) {
 		/* Write control register in order to enable square-wave
 		 * output (SQWE) and set a default rate of 32.768kHz (RS1|RS0).
 		 */
-		ret = dm_i2c_reg_write(dev, RTC_CTL_REG_ADDR,
+		ret = dm_i2c_reg_write(dev, data->offset + RTC_CTL_REG_ADDR,
 				       RTC_CTL_BIT_SQWE | RTC_CTL_BIT_RS1 |
 				       RTC_CTL_BIT_RS0);
-	} else if (type == ds_1337) {
+	} else if (data->type == ds_1337) {
 		/* Write control register in order to enable oscillator output
 		 * (not EOSC) and set a default rate of 32.768kHz (RS2|RS1).
 		 */
-		ret = dm_i2c_reg_write(dev, DS1337_CTL_REG_ADDR,
+		ret = dm_i2c_reg_write(dev, data->offset + DS1337_CTL_REG_ADDR,
 				       DS1337_CTL_BIT_RS2 | DS1337_CTL_BIT_RS1);
-	} else if (type == ds_1340 || type == mcp794xx || type == m41t11) {
+	} else if (data->type == ds_1340 || data->type == mcp794xx || data->type == m41t11) {
 		/* Reset clock calibration, frequency test and output level. */
-		ret = dm_i2c_reg_write(dev, RTC_CTL_REG_ADDR, 0x00);
+		ret = dm_i2c_reg_write(dev, data->offset + RTC_CTL_REG_ADDR, 0x00);
 	}
 
 	return ret;
@@ -197,14 +202,44 @@ static const struct rtc_ops ds1307_rtc_ops = {
 	.reset = ds1307_rtc_reset,
 };
 
+static const struct rtc_ds1370_data ds_1307_data = {
+	.type   = ds_1307,
+	.offset = 0,
+};
+
+static const struct rtc_ds1370_data ds_1337_data = {
+	.type   = ds_1337,
+	.offset = 0,
+};
+
+static const struct rtc_ds1370_data ds_1339_data = {
+	.type   = ds_1339,
+	.offset = 0,
+};
+
+static const struct rtc_ds1370_data ds_1340_data = {
+	.type   = ds_1340,
+	.offset = 0,
+};
+
+static const struct rtc_ds1370_data mcp794xx_data = {
+	.type   = mcp794xx,
+	.offset = 0,
+};
+
+static const struct rtc_ds1370_data m41t11_data = {
+	.type   = m41t11,
+	.offset = 0,
+};
+
 static const struct udevice_id ds1307_rtc_ids[] = {
-	{ .compatible = "dallas,ds1307", .data = ds_1307 },
-	{ .compatible = "dallas,ds1337", .data = ds_1337 },
-	{ .compatible = "dallas,ds1339", .data = ds_1339 },
-	{ .compatible = "dallas,ds1340", .data = ds_1340 },
-	{ .compatible = "microchip,mcp7940x", .data = mcp794xx },
-	{ .compatible = "microchip,mcp7941x", .data = mcp794xx },
-	{ .compatible = "st,m41t11", .data = m41t11 },
+	{ .compatible = "dallas,ds1307", .data = (ulong)&ds_1307_data },
+	{ .compatible = "dallas,ds1337", .data = (ulong)&ds_1337_data },
+	{ .compatible = "dallas,ds1339", .data = (ulong)&ds_1339_data },
+	{ .compatible = "dallas,ds1340", .data = (ulong)&ds_1340_data },
+	{ .compatible = "microchip,mcp7940x", .data = (ulong)&mcp794xx_data },
+	{ .compatible = "microchip,mcp7941x", .data = (ulong)&mcp794xx_data },
+	{ .compatible = "st,m41t11", .data = (ulong)&m41t11_data },
 	{ }
 };
 
-- 
2.43.0

