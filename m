Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB6D3CD5BB0
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 15:40:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1548B84866;
	Fri, 22 May 2026 17:39:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="OTgXbD0+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 534EE847EF; Fri, 22 May 2026 17:39:50 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 686E384867
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
 bh=uEb9WCZ13xKPJx7hBuBD623NK8i956egQTvwN7TgPgE=; b=OTgXbD0+d8t4o0tLr2XpQD2x6N
 PA2z0L31uPHrK7NbkpGt5XMaeeYvwb+QVA16GbcA6X642rn3/nfhRrFfS/41FGybzjRz1yxVuRQvS
 4O3Bg1YRzXycxbVuadX1uLXEelp7G4ZqCmNvDaI+2OAdRTzhz9PkTHwtMxiMhjIxGdgEfLspjfudO
 9CkQ2RNW6EZjTsWtXzsVpwnQrNnFFvyX+S0Vd3h1jXLv6Le7n4urmCTLcfWEYYZZyNkfnSfxQftDN
 HXLZRxVJbXoVBmYm5cZKc4JPruMFFhSmmPbbdegf7jEjb2WgNQ5Qrk8ioeNxHG57CwjSFE6pNXJZ2
 5aLw7RxA==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wQRyT-000OMO-1s; Fri, 22 May 2026 17:39:45 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy08.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wQRyS-0002ma-1X; Fri, 22 May 2026 17:39:45 +0200
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: u-boot@lists.denx.de
Cc: Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: [PATCH v3 5/9] rtc: pcf85063: add missing register definitions
Date: Fri, 22 May 2026 17:39:25 +0200
Message-Id: <20260522153929.2472552-6-Alexander.Feilke@ew.tq-group.com>
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

Sync definitions from upstream linux v6.19.

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
---
 drivers/rtc/pcf85063.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/pcf85063.c b/drivers/rtc/pcf85063.c
index 183a214a3e9..06c85d939e0 100644
--- a/drivers/rtc/pcf85063.c
+++ b/drivers/rtc/pcf85063.c
@@ -11,11 +11,33 @@
 #include <dm/device_compat.h>
 
 #define PCF85063_REG_CTRL1		0x00 /* status */
-#define PCF85063_REG_CTRL1_SR		0x58
+#define PCF85063_REG_CTRL1_CAP_SEL	BIT(0)
+#define PCF85063_REG_CTRL1_STOP		BIT(5)
+#define PCF85063_REG_CTRL1_EXT_TEST	BIT(7)
+#define PCF85063_REG_CTRL1_SWR		0x58 /* Software reset command */
+
+#define PCF85063_REG_CTRL2		0x01
+#define PCF85063_CTRL2_AF		BIT(6)
+#define PCF85063_CTRL2_AIE		BIT(7)
+
+#define PCF85063_REG_OFFSET		0x02
+#define PCF85063_OFFSET_SIGN_BIT	6	/* 2's complement sign bit */
+#define PCF85063_OFFSET_MODE		BIT(7)
+#define PCF85063_OFFSET_STEP0		4340
+#define PCF85063_OFFSET_STEP1		4069
+
+#define PCF85063_REG_CLKO_F_MASK	0x07 /* frequency mask */
+#define PCF85063_REG_CLKO_F_32768HZ	0x00
+#define PCF85063_REG_CLKO_F_OFF		0x07
+
+#define PCF85063_REG_RAM		0x03
 
 #define PCF85063_REG_SC			0x04 /* datetime */
 #define PCF85063_REG_SC_OS		0x80
 
+#define PCF85063_REG_ALM_S		0x0b
+#define PCF85063_AEN			BIT(7)
+
 static int pcf85063_get_time(struct udevice *dev, struct rtc_time *tm)
 {
 	u8 regs[7];
@@ -74,7 +96,7 @@ static int pcf85063_set_time(struct udevice *dev, const struct rtc_time *tm)
 
 static int pcf85063_reset(struct udevice *dev)
 {
-	return dm_i2c_reg_write(dev, PCF85063_REG_CTRL1, PCF85063_REG_CTRL1_SR);
+	return dm_i2c_reg_write(dev, PCF85063_REG_CTRL1, PCF85063_REG_CTRL1_SWR);
 }
 
 static int pcf85063_read(struct udevice *dev, unsigned int offset, u8 *buf,
-- 
2.34.1

