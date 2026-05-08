Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8421ACD342F
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 08:22:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A00884C63;
	Fri,  8 May 2026 10:21:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="mo5QITcX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B27B984AF6; Fri,  8 May 2026 10:21:45 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB72284C2A
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 10:21:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Alexander.Feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=DXA88PWP99w6fGlKjR6LAs8Hnn88rBqum2Kkhs+NL/Q=; b=mo5QITcXdBb1Rwk5YQ25ya9+Ot
 oLvmEwrtdjLd0a5tN23OTB2m9eKCThODGjs49T50Tr/0Nzj+CAFOnj0OSLUHqyHghtfIydNWPw45K
 Z73OQlpdkDNJnEM46u9rZprwUmTMQstPKvE9kaURy52SAApmBhP4tGcvxKKFzKLgBuJVG6SUn4iS7
 p1udYj6HKQTIdNjE20Z4aHnaYYgRlvO1mUb8bmxNcoW7ccyUZD9zvPbSl2taoRECinSJTlNVWSf50
 oxj4EeH7tfebwUW8qdm9WMalMKNjT95oEX8B4xg3GRv0zoJuxASKpbL1khKb+3pgxkibfDe2PcLQ0
 Ar31C3XQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wLGSs-0005oT-11; Fri, 08 May 2026 10:21:42 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy06.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wLGSs-000P5H-1Q; Fri, 08 May 2026 10:21:42 +0200
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: u-boot@lists.denx.de
Cc: u-boot@ew.tq-group.com,
 Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 6/8] rtc: pcf85063: support loading quartz-load capacitance
 from device tree
Date: Fri,  8 May 2026 10:21:30 +0200
Message-Id: <20260508082132.25476-7-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260508082132.25476-1-Alexander.Feilke@ew.tq-group.com>
References: <20260508082132.25476-1-Alexander.Feilke@ew.tq-group.com>
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

From: Alexander Feilke <alexander.feilke@ew.tq-group.com>

Use previously ignored quartz-load-femtofarads property from device tree
to set load capacitance. If missing, leave the device unconfigured
as a default might have been set. force_cap is left out for now but
can be retrofitted in the future as there may be different hardware
without the 12.500pF flag.

Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
---
 drivers/rtc/pcf85063.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/rtc/pcf85063.c b/drivers/rtc/pcf85063.c
index 0b336b8c5ee..107e8b4d4c8 100644
--- a/drivers/rtc/pcf85063.c
+++ b/drivers/rtc/pcf85063.c
@@ -140,6 +140,30 @@ static int pcf85063_write(struct udevice *dev, unsigned int offset,
 	return dm_i2c_write(dev, offset, buf, len);
 }
 
+static int pcf85063_load_capacitance(struct udevice *dev)
+{
+	u32 load = 7000;
+	u8 reg = 0;
+
+	if (ofnode_read_u32(dev_ofnode(dev), "quartz-load-femtofarads", &load))
+		return 0;
+
+	switch (load) {
+	default:
+		dev_warn(dev, "Unknown quartz-load-femtofarads value: %d. Assuming 7000",
+			 load);
+		fallthrough;
+	case 7000:
+		break;
+	case 12500:
+		reg = PCF85063_REG_CTRL1_CAP_SEL;
+		break;
+	}
+
+	return dm_i2c_reg_clrset(dev, PCF85063_REG_CTRL1,
+				 PCF85063_REG_CTRL1_CAP_SEL, reg);
+}
+
 static const struct rtc_ops pcf85063_rtc_ops = {
 	.get = pcf85063_get_time,
 	.set = pcf85063_set_time,
@@ -150,8 +174,22 @@ static const struct rtc_ops pcf85063_rtc_ops = {
 
 static int pcf85063_probe(struct udevice *dev)
 {
+	u8 tmp;
+	int err;
+
 	i2c_set_chip_flags(dev, DM_I2C_CHIP_RD_ADDRESS | DM_I2C_CHIP_WR_ADDRESS);
 
+	err = dm_i2c_read(dev, PCF85063_REG_SC, &tmp, sizeof(tmp));
+	if (err) {
+		dev_err(dev, "RTC chip is not present\n");
+		return err;
+	}
+
+	err = pcf85063_load_capacitance(dev);
+	if (err < 0)
+		dev_warn(dev, "failed to set xtal load capacitance: %d",
+			 err);
+
 	return 0;
 }
 
-- 
2.34.1

