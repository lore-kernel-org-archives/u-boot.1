Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0FD3C4706F
	for <u-boot@archiver.kernel.org>; Mon,  1 Jan 2024 21:08:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07D7C8784B;
	Mon,  1 Jan 2024 22:08:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1704143317;
	bh=Hxpy24yfowZkiOAcbHjmNwR2EIUqXIVW1S77JN6yzwk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oMZ56nczZd2dazdqczcDJj36KgdA4e7fYJhbOr8Vl3+J6ra1QUgQwcccpHt95EbRF
	 giD+HczgS1YtxALMoNA54nFJ9W1gYqgzka85oO9bwybPNPpNfZuGCtcHBk16I8fAXl
	 eS69fhjpcyNMG44SZr2CoUu+DGG/WFnQViyuIYeZeywhG+reDf2gCW+6Anx+1FaGsy
	 IUSo1FWuQSJizbdVT9yKNLREUim+o5YOCkX6fZJuTOyRahNsiAz6mwDp/xzl9+h6Yw
	 8EoKSGAPrfTT9cBgme8cqSCf297uRrBCZtL+yW4t+ulv9pBf9hHLy6+Gfz9J2Pd1/X
	 oXRtEY9tB93jA==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 4F2948780C;
 Mon,  1 Jan 2024 22:08:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1704143315;
 bh=Hxpy24yfowZkiOAcbHjmNwR2EIUqXIVW1S77JN6yzwk=;
 h=From:To:Cc:Subject:Date:From;
 b=cb71i2MR6luBVvvYyyG5mts7QtgMru0TR9Kmclnx4gv2tU7Dqm/WAZrqqp5aSHV63
 QyAhO2oXV2iI/QCAgVeZ9ZTcwAOE+RAICo+Toxj8YmUEzfJ4mdijAsB3lowqiPNpMX
 xdquFp9qWOC+p+U3ob/cc1aOPiIY8P8XCX45Ff0aoRDkHnDKrI7khMNevnyz0+sAm9
 jsfGIDRe5bWLbGYcwOparWlQtCWLIMqax7qXcRP/YrGGyLaK0pgh4WDDkEt96gAmsq
 FhxQlXxNEvIGXqES3lN19AZKXGccSdK+5sx7Sn2sXmzs+XUEABnBnKWLHG0PwK7usa
 C8BztYR2Q7OqA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Joe Hershberger <joe.hershberger@ni.com>,
 =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
 Ramon Fried <rfried.dev@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH] net: phy: broadcom: Configure LEDs on BCM54210E
Date: Mon,  1 Jan 2024 22:07:47 +0100
Message-ID: <20240101210820.87486-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Configure LEDs on BCM54210E so they would blink on activity
and indicate link speed. Without this the LEDs are always on
if cable is plugged in.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Rafał Miłecki <rafal@milecki.pl>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/net/phy/broadcom.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index 82e3bbef7dd..ecccb7c3b54 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -42,6 +42,12 @@
 #define BCM54810_SHD_CLK_CTL				0x3
 #define BCM54810_SHD_CLK_CTL_GTXCLK_EN			BIT(9)
 
+#define BCM54XX_SHD_LEDS1		0x0d
+#define BCM_LED_SRC_LINKSPD2		0x1
+#define BCM_LED_SRC_ACTIVITYLED		0x3
+#define BCM54XX_SHD_LEDS1_LED3(src)	(((src) & 0xf) << 4)
+#define BCM54XX_SHD_LEDS1_LED1(src)	(((src) & 0xf) << 0)
+
 static int bcm54xx_auxctl_read(struct phy_device *phydev, u16 regnum)
 {
 	/* The register must be written to both the Shadow Register Select and
@@ -148,7 +154,16 @@ static int bcm54210e_config(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;
 
-	return bcm5461_config(phydev);
+	ret = bcm5461_config(phydev);
+	if (ret < 0)
+		return ret;
+
+	/* Configure LEDs to blink. */
+	bcm_phy_write_shadow(phydev, BCM54XX_SHD_LEDS1,
+			     BCM54XX_SHD_LEDS1_LED1(BCM_LED_SRC_ACTIVITYLED) |
+			     BCM54XX_SHD_LEDS1_LED3(BCM_LED_SRC_LINKSPD2));
+
+	return 0;
 }
 
 static int bcm54xx_parse_status(struct phy_device *phydev)
-- 
2.43.0

