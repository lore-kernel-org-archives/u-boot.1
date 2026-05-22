Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4371CD5BB0
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 15:41:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2505D8487C;
	Fri, 22 May 2026 17:39:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="J/r0CFEh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12C38846DF; Fri, 22 May 2026 17:39:52 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD4328486B
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 17:39:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Alexander.Feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=6aWUOzjFlzUFgxUqGIxvtJuzmqbR1FHIptgBI8+0DM0=; b=J/r0CFEhK9nWoWU7xB5VaPKJi4
 kV/MO9bpdFwZQFJhhT6LwJEA2ZCvWKvX5XxQ3s4yXO3H+BBf/0KoIUX7DO2BX3A0dVXObIhxEVOiy
 qzPYdhg0R9cKcVn4NAY8DuKCSY45zeXNauYzeqAy2J8BX5504hSJAcxmpUFn8gZv04CTBP4hVU8+v
 b+kGetfUqQ4K7R1G17hc3Hi1vzYvEsBNaz/dcRYggPCotgtZu5p9ZpYPqDlECjbychp/A+L+3PngH
 KyWRlkNQ1lw7V3KyFqjEqgl2mhoquByN4R5seEGEpg5C0ftE1fyWF9vSjiiYHm8VE2ZtfYDaT3Zuv
 PUvl9KhA==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wQRyU-000OMi-0E; Fri, 22 May 2026 17:39:46 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy08.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wQRyS-0002ma-2z; Fri, 22 May 2026 17:39:45 +0200
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: u-boot@lists.denx.de
Cc: Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: [PATCH v3 7/9] rtc: pcf85063: support loading quartz-load capacitance
 from device tree
Date: Fri, 22 May 2026 17:39:27 +0200
Message-Id: <20260522153929.2472552-8-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260522153929.2472552-1-Alexander.Feilke@ew.tq-group.com>
References: <20260522153929.2472552-1-Alexander.Feilke@ew.tq-group.com>
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

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
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

