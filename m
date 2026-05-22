Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8EB6CD5BB0
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 15:40:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA99284862;
	Fri, 22 May 2026 17:39:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="kKcJ5JiM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23EA18487F; Fri, 22 May 2026 17:39:50 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9719B84869
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
 bh=N97FhPkFbSRdOyiybXcWcJonrb79sUKtCLdvhpy8/Dw=; b=kKcJ5JiMhC9Pzz0aprDBHQnXDK
 EYD4XQyQ7iSB59S4z8WpYu3WnEm3dgQGVRhfGkl8A9VYv+1mCWroiXOnIqyYDVd35NyLp76a/te2Z
 DkxEgV5blVab3KzOciuWmoRWOOBiwalE68RPY72zNzp6JEB35DTZvlOkwp/yZJn+JE8aMLyz7vzXU
 RF5oYpsUMDkmBzryRjh27IeQaFU29XjzlFB6/cDblJHSOEMt7BtjqINNOZocle+HK6ZRwrbAdVHrK
 LMOFIU4kJP3ZWpO+kkG49aThku8VypgWAsnZAAWyBXnZSQupQOCmTZCgAT45dj+uEzFeS0OFjCDWs
 /nJoRPEg==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wQRyT-000OMW-2c; Fri, 22 May 2026 17:39:45 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy08.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wQRyS-0002ma-2G; Fri, 22 May 2026 17:39:45 +0200
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: u-boot@lists.denx.de
Cc: Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: [PATCH v3 6/9] rtc: pcf85063: keep the divider chain in reset during
 set_time
Date: Fri, 22 May 2026 17:39:26 +0200
Message-Id: <20260522153929.2472552-7-Alexander.Feilke@ew.tq-group.com>
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

Sync from upstream linux v6.19.

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
---
 drivers/rtc/pcf85063.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/pcf85063.c b/drivers/rtc/pcf85063.c
index 06c85d939e0..0b336b8c5ee 100644
--- a/drivers/rtc/pcf85063.c
+++ b/drivers/rtc/pcf85063.c
@@ -68,12 +68,25 @@ static int pcf85063_get_time(struct udevice *dev, struct rtc_time *tm)
 static int pcf85063_set_time(struct udevice *dev, const struct rtc_time *tm)
 {
 	u8 regs[7];
+	int rc;
 
 	if (tm->tm_year < 2000 || tm->tm_year > 2099) {
 		dev_err(dev, "Year must be between 2000 and 2099.\n");
 		return -EINVAL;
 	}
 
+	/*
+	 * to accurately set the time, reset the divider chain and keep it in
+	 * reset state until all time/date registers are written
+	 */
+	rc = dm_i2c_reg_clrset(dev, PCF85063_REG_CTRL1,
+			       PCF85063_REG_CTRL1_EXT_TEST |
+			       PCF85063_REG_CTRL1_STOP,
+			       PCF85063_REG_CTRL1_STOP);
+
+	if (rc)
+		return rc;
+
 	/* hours, minutes and seconds */
 	regs[0] = bin2bcd(tm->tm_sec) & (~PCF85063_REG_SC_OS);
 
@@ -91,7 +104,17 @@ static int pcf85063_set_time(struct udevice *dev, const struct rtc_time *tm)
 	/* adjust register to match rtc_time spec */
 	regs[6] = bin2bcd(tm->tm_year % 100);
 
-	return dm_i2c_write(dev, PCF85063_REG_SC, regs, sizeof(regs));
+	rc = dm_i2c_write(dev, PCF85063_REG_SC, regs, sizeof(regs));
+	if (rc)
+		return rc;
+
+	/*
+	 * Write the control register as a separate action since the size of
+	 * the register space is different between the PCF85063TP and
+	 * PCF85063A devices. The rollover point can not be used.
+	 */
+	return dm_i2c_reg_clrset(dev, PCF85063_REG_CTRL1,
+				 PCF85063_REG_CTRL1_STOP, 0);
 }
 
 static int pcf85063_reset(struct udevice *dev)
-- 
2.34.1

