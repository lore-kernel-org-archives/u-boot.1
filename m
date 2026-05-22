Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E29D1CD5BB0
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 15:40:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F00584832;
	Fri, 22 May 2026 17:39:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="koHoDwMz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EF8484886; Fri, 22 May 2026 17:39:49 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 047FC84851
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
 bh=wLflnhTKbp7p9U4MKE5Bqy3CgGyhtDuOU+d3vvmkUi8=; b=koHoDwMzmXxrgGzvRhsD6FihcD
 5h2q+y1JpYpXwO7iqdU+ZiXkMppXBVUIMxou/+WePvOV/x2dTRQSoNGlXbQ6mfyEqibqc+gsZkzVJ
 o+7Y0AAY/rdJs7yiSSH7wFts0+hMs28upa5GCSxPe9FnMTpVIhuVSvmP/iKsdD/iOt4ngWCgaryqB
 heaoY8Bwb4KyZheowHfKLJaxDRsd/bJlnZkIdVgZKri5PUO99/dEvHMPQldTeIylbq5mMl6DDN3OX
 zJIE/yFxIh+OzDFwDMl/ahPrA5JhryNCw4+1H5Y8U/H4IOT+NdTy5XBQZ7VOM1PoM5hfoLyF0Kf54
 r7k8gh6w==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wQRyT-000OLy-0M; Fri, 22 May 2026 17:39:45 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy08.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wQRyR-0002ma-3B; Fri, 22 May 2026 17:39:44 +0200
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: u-boot@lists.denx.de
Cc: Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: [PATCH v3 3/9] rtc: pcf85063: adjust date format to adhere to the
 rtc_time spec
Date: Fri, 22 May 2026 17:39:23 +0200
Message-Id: <20260522153929.2472552-4-Alexander.Feilke@ew.tq-group.com>
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

The rtc_time documentation in rtc_def.h notes a differences
to the common "struct time" that specifies tm_mon as 1 ... 12
and tm_year as year since 0. Also trim register values to valid bits.

Fixes: 1c2a2253f798 ("drivers: rtc: add PCF85063 support")

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
---
 drivers/rtc/pcf85063.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/pcf85063.c b/drivers/rtc/pcf85063.c
index 737d4547aca..21640b039c1 100644
--- a/drivers/rtc/pcf85063.c
+++ b/drivers/rtc/pcf85063.c
@@ -35,7 +35,9 @@ static int pcf85063_get_time(struct udevice *dev, struct rtc_time *tm)
 	tm->tm_hour = bcd2bin(regs[2] & 0x3f);
 	tm->tm_mday = bcd2bin(regs[3] & 0x3f);
 	tm->tm_wday = regs[4] & 0x07;
-	tm->tm_mon = bcd2bin(regs[5] & 0x1f) - 1;
+	/* rtc register and rtc_time spec uses 1 - 12 */
+	tm->tm_mon = bcd2bin(regs[5] & 0x1f);
+	/* adjust rtc_time (years since 0) to match register spec */
 	tm->tm_year = bcd2bin(regs[6]) + 2000;
 
 	return 0;
@@ -50,12 +52,21 @@ static int pcf85063_set_time(struct udevice *dev, const struct rtc_time *tm)
 		return -EINVAL;
 	}
 
-	regs[0] = bin2bcd(tm->tm_sec);
+	/* hours, minutes and seconds */
+	regs[0] = bin2bcd(tm->tm_sec) & (~PCF85063_REG_SC_OS);
+
 	regs[1] = bin2bcd(tm->tm_min);
 	regs[2] = bin2bcd(tm->tm_hour);
+
+	/* Day of month, 1 - 31 */
 	regs[3] = bin2bcd(tm->tm_mday);
-	regs[4] = tm->tm_wday;
-	regs[5] = bin2bcd(tm->tm_mon + 1);
+
+	/* Day of week 0 - 6 */
+	regs[4] = tm->tm_wday & 0x07;
+
+	/* rtc register and rtc_time spec uses 1 - 12 */
+	regs[5] = bin2bcd(tm->tm_mon);
+	/* adjust register to match rtc_time spec */
 	regs[6] = bin2bcd(tm->tm_year % 100);
 
 	return dm_i2c_write(dev, PCF85063_REG_SC, regs, sizeof(regs));
-- 
2.34.1

