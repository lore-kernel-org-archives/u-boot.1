Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4AF2CD5BB0
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 15:41:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 607D1848A5;
	Fri, 22 May 2026 17:39:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="cSLAKbop";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C8B3846DF; Fri, 22 May 2026 17:39:52 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0770C84832
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 17:39:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Alexander.Feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=LrsfEkPE5A3YigtFUNPuR2484uEX0P+pIJOZbTfvxdE=; b=cSLAKbop8W/J1XyP31gPHzXsHV
 kKelHlJsC3zJ8wu6c4z+GOoThE0tfPGAIsoouHsaEXh4LXIEFfs1tMECZ5U/I+tARH34O86af08VY
 ztK7dFXLUKfspqflyNtgtGKTS5IGz9PynSvPvl6DtgDRBSaBN3HTgoWXc8fgNC8gyOw7k2bxa0lnk
 H3SQIrLEC4smBcFSvIlcjMKIHmo2TOjwAFM3Dv/9esLUfGibgAgW+o+vueOGuY9ZTAQDRKxbWdW3d
 DsZRwq1/Qsq3r3WANgILqpZNu//151ZFvgmtCnDbgzDAy8vLuHV5tXw+2Fe+PysmpY5ylqP2uGpeZ
 EQbvDBhg==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wQRyU-000OMn-0q; Fri, 22 May 2026 17:39:46 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy08.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wQRyT-0002ma-0U; Fri, 22 May 2026 17:39:46 +0200
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: u-boot@lists.denx.de
Cc: Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: [PATCH v3 8/9] rtc: pcf85063: add power loss detection during probe
Date: Fri, 22 May 2026 17:39:28 +0200
Message-Id: <20260522153929.2472552-9-Alexander.Feilke@ew.tq-group.com>
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

Retrofit from upstream linux to try resetting the device after power loss.

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
---
 drivers/rtc/pcf85063.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/rtc/pcf85063.c b/drivers/rtc/pcf85063.c
index 107e8b4d4c8..421c42c0b81 100644
--- a/drivers/rtc/pcf85063.c
+++ b/drivers/rtc/pcf85063.c
@@ -185,6 +185,20 @@ static int pcf85063_probe(struct udevice *dev)
 		return err;
 	}
 
+	/*
+	 * If a Power loss is detected, SW reset the device.
+	 * From PCF85063A datasheet:
+	 * There is a low probability that some devices will have corruption
+	 * of the registers after the automatic power-on reset...
+	 */
+	if (tmp & PCF85063_REG_SC_OS) {
+		dev_warn(dev, "POR issue detected, sending a SW reset\n");
+		err = dm_i2c_reg_clrset(dev, PCF85063_REG_CTRL1,
+					0xff, PCF85063_REG_CTRL1_SWR);
+		if (err < 0)
+			dev_warn(dev, "SW reset failed, trying to continue\n");
+	}
+
 	err = pcf85063_load_capacitance(dev);
 	if (err < 0)
 		dev_warn(dev, "failed to set xtal load capacitance: %d",
-- 
2.34.1

