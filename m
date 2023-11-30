Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB4ACC4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 20:40:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 366328709A;
	Thu, 30 Nov 2023 21:40:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=conclusive.pl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=conclusive.pl header.i=@conclusive.pl header.b="fsX/5Ikp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD0FA87631; Thu, 30 Nov 2023 21:40:00 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D02F080245
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 21:39:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=conclusive.pl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=artur@conclusive.pl
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a02ba1f500fso204682166b.0
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 12:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=conclusive.pl; s=google; t=1701376798; x=1701981598; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JWl9SLM6FofBz5rNo9LeVvAXU6Fd4RJA3cyuAHSgLL8=;
 b=fsX/5IkpkNwepqF4Xcozk3caVxTnM99Hk0rhi4FhaGBtJBGIPssHEaKY/l8krwa58h
 reT0TWtpTPf7cPM2SHXHwVlAs/lIB+y3RtmINQIQLGRFzlpWvZoJtBC8veekE17NEGkP
 uPKoI8abga5u1KGzjCh3yBrDdLRUn8osO2RtURMpHYJ4lvaljjCFkBnTjwZt0WcuymS9
 Fa45qA7VQP7KEudoRi/jnx3zVPrk03OKoROKTQcGMVzawg4Qgdl8BkrrccYYraaQRG2C
 XIKrFA972kFbvPNKboemBuXE03ygWIe30fVfyyRRiCTjTW/LycwjO05bHX2J2blqB2XD
 Sxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701376798; x=1701981598;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JWl9SLM6FofBz5rNo9LeVvAXU6Fd4RJA3cyuAHSgLL8=;
 b=Nf5XhHahpapk+iYG4rThhTX5VTN9E7VtpmRLsTCM2HFY2Gf6kPBAv93EzL9WCiwUKO
 aIWnwzdOPRDugNDbFTC429pqDQERqRcP9kGv04gZ6IY+VYUtHDpr2YOmAbNFw6MwV6xZ
 70GKBbBO1fqY/TC1wUT37f00Qnug3QhlQkm865BiyIoO+6HymC9g806r5GNeaHAvr7iQ
 E8pXIu3U/hKFw6sUDkcevaOOaiMSTsfj0LNl00rwTr5cietEMaBRhp3Htc68VsoTSPid
 Ln4cM4jaXwON/4CRf49oxfWJTcaiN+42uvysA//XP3jM9O0lTBbIt+r3dupUJBvW7jlR
 5+5g==
X-Gm-Message-State: AOJu0YxNuRDR/3kcVo7tkEIA7mo2pvPckSnTpeygUDDxxi8j/aqcejSR
 QXOJFiqJQdM08CYNfFq+1rR6+A==
X-Google-Smtp-Source: AGHT+IG+Ch5tuczlExq+VnIiCA7RTuRqUUveeUgx8DiuWiivJS2QrhGcKUx2amlm1ia8Yg14fcfstg==
X-Received: by 2002:a17:906:1848:b0:a18:ad93:460d with SMTP id
 w8-20020a170906184800b00a18ad93460dmr91477eje.69.1701376798116; 
 Thu, 30 Nov 2023 12:39:58 -0800 (PST)
Received: from localhost.localdomain (83.22.185.31.ipv4.supernova.orange.pl.
 [83.22.185.31]) by smtp.gmail.com with ESMTPSA id
 j21-20020a170906279500b009dddec5a96fsm1073268ejc.170.2023.11.30.12.39.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 12:39:57 -0800 (PST)
From: Artur Rojek <artur@conclusive.pl>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Jakub Klama <jakub@conclusive.pl>
Cc: Wojciech Kloska <wojciech@conclusive.pl>,
 =?UTF-8?q?Rados=C5=82aw=20Adamczyk?= <radoslaw.adamczyk@conclusive.pl>,
 u-boot@lists.denx.de, Artur Rojek <artur@conclusive.pl>
Subject: [PATCH] net: phy: realtek: Add support for LED configuration
Date: Thu, 30 Nov 2023 21:39:19 +0100
Message-ID: <20231130203919.757-1-artur@conclusive.pl>
X-Mailer: git-send-email 2.43.0
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

From: Jakub Klama <jakub@conclusive.pl>

Introduce an ability to configure LED and Fiber LEDs found in RTL8211F
PHYs. This is achieved through two optional Device Tree properties:
* rtl,lcr  for LED control
* rtl,flcr for Fiber LED control

Signed-off-by: Jakub Klama <jakub@conclusive.pl>
Signed-off-by: Artur Rojek <artur@conclusive.pl>
---
 drivers/net/phy/realtek.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 396cac76d6..d078f41bee 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -59,6 +59,7 @@
 #define MIIM_RTL8211F_TX_DELAY		0x100
 #define MIIM_RTL8211F_RX_DELAY		0x8
 #define MIIM_RTL8211F_LCR		0x10
+#define MIIM_RTL8211F_FLCR		0x12
 
 #define RTL8201F_RMSR			0x10
 
@@ -220,6 +221,8 @@ default_delay:
 
 static int rtl8211f_config(struct phy_device *phydev)
 {
+	ofnode node = phy_get_ofnode(phydev);
+	u32 lcr, flcr;
 	u16 reg;
 
 	if (phydev->flags & PHY_RTL8211F_FORCE_EEE_RXC_ON) {
@@ -254,14 +257,17 @@ static int rtl8211f_config(struct phy_device *phydev)
 		reg &= ~MIIM_RTL8211F_RX_DELAY;
 	phy_write(phydev, MDIO_DEVAD_NONE, 0x15, reg);
 
-	/* restore to default page 0 */
-	phy_write(phydev, MDIO_DEVAD_NONE,
-		  MIIM_RTL8211F_PAGE_SELECT, 0x0);
-
-	/* Set green LED for Link, yellow LED for Active */
 	phy_write(phydev, MDIO_DEVAD_NONE,
 		  MIIM_RTL8211F_PAGE_SELECT, 0xd04);
-	phy_write(phydev, MDIO_DEVAD_NONE, 0x10, 0x617f);
+
+	if (ofnode_valid(node) && !ofnode_read_u32(node, "rtl,lcr", &lcr))
+		phy_write(phydev, MDIO_DEVAD_NONE, MIIM_RTL8211F_LCR, lcr);
+	else /* Set green LED for Link, yellow LED for Active */
+		phy_write(phydev, MDIO_DEVAD_NONE, MIIM_RTL8211F_LCR, 0x617f);
+
+	if (ofnode_valid(node) && !ofnode_read_u32(node, "rtl,flcr", &flcr))
+		phy_write(phydev, MDIO_DEVAD_NONE, MIIM_RTL8211F_FLCR, flcr);
+
 	phy_write(phydev, MDIO_DEVAD_NONE,
 		  MIIM_RTL8211F_PAGE_SELECT, 0x0);
 
-- 
2.34.1

