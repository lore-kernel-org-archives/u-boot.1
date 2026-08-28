Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131F8C61DBD
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 13:30:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B6F9E4085C;
	Fri, 28 Aug 2026 13:30:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id axvTy7fc_pYl; Fri, 28 Aug 2026 13:30:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787923817;
	bh=Q+xmK0LtwG9aWKzBSVZ7+UQZzCvCOUc+VPUloWA7r58=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=o0/q3/fvXFuKPFBFKwl/wBP628owH1CBZUt9Se0o47ldf38n+tKGVK6qvcFsqy5Ug
	 Ny0iGh68JlgvipmtqYkHypzw4tgvHyMMm4j1Oa0B7Pzglw0ygXrZbruICZTGGNKrKO
	 VAW6FJLLbeb+9R+20FrJHzA1iwT9GIxr4Af8E4XKRnzY8rxxTkpU8BXp5Oik8Ehb55
	 wJ9k/tDohBF3nX0+9ghZWagFsx2t8S53goDHZwo4QmNnIf7DPXQA6RYfhfKvzJp+Xb
	 ty2qSng7OemTROCVCIf2kpGMeA/GLQaRrNmXgXKdMeLnVjzHQ6g8jmoQkgvYm19S2U
	 9GNm/4zNaUcWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D47B940852;
	Fri, 28 Aug 2026 13:30:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E3F53386
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:30:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D429580F12
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:30:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uvEFjHZSmuGw for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 13:30:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=alexander.feilke@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=CCY4BzHr
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 97F4980F13
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=Q+xmK0LtwG9aWKzBSVZ7+UQZzCvCOUc+VPUloWA7r58=; b=CCY4BzHr7PEKsiDO/gvedR/4I4
 XpH6/dtL3r0atOhbgQGvKFWhpkuI1oAWwHqcJ5b3o8wat26cRfwJqONxYofp7Drl/aRrzD4ejgM8s
 rbYX2JykNCHiAWhn3vti2+BtJGBC5OThPBPiUohGGZbl2VkUyZnqxywjX+2JMZU28oY644/+mN5lw
 SI1FU3z94to9xOYNdSY5z/BBv8dLQQgf0dqN1tQm2yeRE+RcBGD+Xlz9UA5kBDTdN3E/6vBb5FBHE
 XabXrjXnHNi6CoDbQZMEx2ZiTg6z0Eu/mqzA8NePS8LY6UaFEdwNTZ8DNRqs1ts1vRVLWKTwLlbyt
 pvmEyySQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wzwOx-0009cq-0L; Fri, 28 Aug 2026 15:13:47 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy06.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wzwOw-0001qv-2g; Fri, 28 Aug 2026 15:13:46 +0200
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: u-boot@lists.u-boot-project.org
Cc: Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] rtc: ds1307: support register offsets
Date: Fri, 28 Aug 2026 15:12:58 +0200
Message-ID: <20260828131302.2176223-1-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
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

