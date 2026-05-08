Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 500CBCD342F
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 08:22:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8866084C69;
	Fri,  8 May 2026 10:21:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="jTwImMi8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B79F784B56; Fri,  8 May 2026 10:21:45 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 393B484C0C
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
 bh=Pf5q3jGKK2KEhKZjhY9BRR4TNqQR2QHK8ib4rUUMjDY=; b=jTwImMi8SmP1QpggWQbLxlXoLc
 dTwO/wtlB+qZR4Z0QBkpz84PTBLeiorXazPIwN4JV5ezJbZq+SZSPBCArDT9rbwKIRPOGnM7IgVWC
 4/3EtjjvJ3ryTQQGgOmIk3uZCEtiVPNF3M544zvBHY5rEERQebi/z0qckG3yOwI8mdErfyjN0buwC
 /SW/74qsLsLQwxTLqZrkW9zuAPyacwXXeHYtjQP118FpMlhWZy60EhxoQtti62eddo5JuIvYIJB1V
 B+4odroEXV545Sv5iPrAlfiyl2DcXzlDFnejYTZs7RvKO268RpR2wt/maWwDnO9WXzKy0+G31pzuf
 OJ4WA8kg==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wLGSr-0005nd-2N; Fri, 08 May 2026 10:21:41 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy06.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wLGSr-000P5H-2c; Fri, 08 May 2026 10:21:41 +0200
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: u-boot@lists.denx.de
Cc: u-boot@ew.tq-group.com,
 Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: [PATCH 3/8] rtc: pcf85063: add support for NXP PCF85063 family
Date: Fri,  8 May 2026 10:21:27 +0200
Message-Id: <20260508082132.25476-4-Alexander.Feilke@ew.tq-group.com>
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

Supported devices:

- generic PCF85063 / PCF85063TP (no alarm regs)
- PCF85063A / PCF85073A (alarm regs)

Tested with TQMa8MPxL SOM from TQ-Systems GmbH.

Also add missing .data field to rv8263 which represents the number
of available registers (= linux `pcf85063_config.max_register + 1`).

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
---
 drivers/rtc/pcf85063.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/pcf85063.c b/drivers/rtc/pcf85063.c
index 21640b039c1..183a214a3e9 100644
--- a/drivers/rtc/pcf85063.c
+++ b/drivers/rtc/pcf85063.c
@@ -80,12 +80,18 @@ static int pcf85063_reset(struct udevice *dev)
 static int pcf85063_read(struct udevice *dev, unsigned int offset, u8 *buf,
 			 unsigned int len)
 {
+	if (offset + len > dev->driver_data)
+		return -EINVAL;
+
 	return dm_i2c_read(dev, offset, buf, len);
 }
 
 static int pcf85063_write(struct udevice *dev, unsigned int offset,
 			  const u8 *buf, unsigned int len)
 {
+	if (offset + len > dev->driver_data)
+		return -EINVAL;
+
 	return dm_i2c_write(dev, offset, buf, len);
 }
 
@@ -105,7 +111,11 @@ static int pcf85063_probe(struct udevice *dev)
 }
 
 static const struct udevice_id pcf85063_of_id[] = {
-	{ .compatible = "microcrystal,rv8263" },
+	{ .compatible = "microcrystal,rv8263", .data = 0x12 },
+	{ .compatible = "nxp,pcf85063", .data = 0xb },
+	{ .compatible = "nxp,pcf85063a", .data = 0x12 },
+	{ .compatible = "nxp,pcf85063tp", .data = 0xb },
+	{ .compatible = "nxp,pcf85073a", .data = 0x12 },
 	{ }
 };
 
-- 
2.34.1

