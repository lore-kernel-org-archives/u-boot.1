Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3CA8CD4842
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 12:10:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0525838D7;
	Mon, 11 May 2026 14:09:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Eq6a1S2Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9683F845E3; Mon, 11 May 2026 14:09:39 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F1AC83BC8
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 14:09:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Alexander.Feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=+tiNDsglmt29WcjpfIyx3nsbhYgX+64HSA0Jhk2V/Tw=; b=Eq6a1S2Q6mckIBYjlqfxcUJGP4
 CN4swPJ+GgrbY0Oj7tW2ToEeznlkGR9+it7fdx7WVC5hRpSlzWlF2Nd+n4lu4JPNSeLhFfkMlwYJ3
 vJi1tJxRiUiaXTBsn3dqFyPbhYIhodbynX2vd+rXc6wm6BrzecJhgUK9XYmDbV/trDZY9pKhO51ag
 v5ZryEebq3yq5yx8kLogKv+GK02SUWUCzLK6CBbcOjo7+Uq7Matgmi3aqIjTzFiLUmWjA9tfNw1tB
 +SQIWUaSLlZ3Frt0tLaal9YmkEtp5F5+tF2w2XUmcpfLDW5DI2+AbqNRDQGlykOwHOMv8GveRN/ym
 xY40xk2Q==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wMPS1-000MVu-0j; Mon, 11 May 2026 14:09:33 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy06.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wMPS1-000GAr-18; Mon, 11 May 2026 14:09:33 +0200
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: u-boot@lists.denx.de
Cc: u-boot@ew.tq-group.com,
 Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 7/8] rtc: pcf85063: add power loss detection during probe
Date: Mon, 11 May 2026 14:09:16 +0200
Message-Id: <20260511120917.1017866-8-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511120917.1017866-1-Alexander.Feilke@ew.tq-group.com>
References: <20260511120917.1017866-1-Alexander.Feilke@ew.tq-group.com>
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

