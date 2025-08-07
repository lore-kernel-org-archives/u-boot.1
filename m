Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F57BC87FD2
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 05:29:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 226A183BF1;
	Thu,  7 Aug 2025 07:29:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hM5bpf0R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A62983BC9; Thu,  7 Aug 2025 07:29:49 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A7B883BFE
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 07:29:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-76bfd457607so720740b3a.0
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 22:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754544584; x=1755149384; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VTzRIp+WTnxoJqCbaSaitImJg+O5rgF+dfjjB5GrBTQ=;
 b=hM5bpf0R6tiqVXjhlKL+TkQ4RgYozcR/yP8gyVBeHQ+yVPoUqkk7hbZVHEZdwKBZQx
 Z4ArBB0DCaGJZ06V80Y6sGGYUOU/ZiHwGYSYZ+Qh23W8mcXujD7GCPsE2ymtyyonZQrV
 HrXdt/i1Co+OAg+BMMMdD8yN+F6jA+aU0ES9SRNcrmy6u3PMZj7esOtMYUSnH7cf+cS1
 fPTueLBNDAwymU1xIsKPVMFwkmiE9QdsJFDjNs0F/nm3uwjYbrUNZxA8Lqht6DoBIaRP
 sLKfHlM9SbD9mBsqEhbNDTP9LWNhKgDsRh2pXpC2bxBvFydQIiYXhB2fNT/Wa9o3Hs+4
 FKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754544584; x=1755149384;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VTzRIp+WTnxoJqCbaSaitImJg+O5rgF+dfjjB5GrBTQ=;
 b=ngMPFAQtV5jiebOqhvyDGJWOtuxR4ZH6pPMkyrC/01GdlgDrtHPik4fkX3r2fzs4Vf
 rFf7ADmpvsacycff1JytO2PXP3hnGDdQQ1fgvi7f8M4BrVofoTU1Q72tDfNJl9mrLEe/
 X2pN8djYyqk/OF2VUGIRlRqhIMz3u5F5x7a/2F0hsp4KfIawV/p5QijwIclY90OhegV1
 h+Bv3mGjC0yT01XwisduEGsqwNvw+YxU9VD5TMZZNvzC+RKq7QMf/WI1/wFGUmSFOAad
 L4vb8EQpjeAC/dPHgjvRfiiwQoVOvrpUkgwTD/xPGItZsN5npJw9OlLnUpUFYGfpxHT0
 wTDw==
X-Gm-Message-State: AOJu0YzRaE5xY5ZsglYBxYJWxyUWe8WpblJGNXx9HFlp/pGsfkvQBCs2
 AasukB6ZJS7u55PXKZ3O9DI4rIrMTFUkxfCNKLjHrkvChCasl0N2d8rR
X-Gm-Gg: ASbGncusGdQZtsvaL4QgjB6ESCI7LAVm/2xBRJ+LeQ0iCaCQwpEHhKQjI4BXyjnqGDW
 47om1fwNkXiJWHuPsiCljK1w6/dbs6crEIsDJ4BRPju93hY171xp0gjQAbGuz03IJQtLTYP4u1T
 5bXs10a/mA4vFZK5FtQCNiZBDEbcwLCcOBE6l7Pd2g7M5n7fr5AwVXHt3b4sy8N9W0QxGHoniia
 KXhPQNBqIxwbsI0iryxZzQJp+6TjgcLOKTidoozYWvWaD1Mj0EyS1saHg5Lv+2MB/aB3IAl+UKV
 tgWe+jG16qmPPuAM1ftpGW04QVAKTcMkwrLB5LjmIBD6jKH3oqBPkR4+7S1zni8oRpMFjSCNhK4
 TfLu3mvOtRionZDLsh5wIg30KWdpwR7cvqg==
X-Google-Smtp-Source: AGHT+IGjG0lERinyqFwjYef8mkrq2HO0do+PlEtZLbGbV98HRkGZy9ZR3a0d6b4shnWbO3CcRSYdTA==
X-Received: by 2002:a05:6a21:3285:b0:230:3710:9aa9 with SMTP id
 adf61e73a8af0-240313e7a65mr8523679637.4.1754544583745; 
 Wed, 06 Aug 2025 22:29:43 -0700 (PDT)
Received: from cs20-buildserver.lan ([2402:7500:400:60db:2e0:4cff:fe68:863])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bd6aacad9sm16010901b3a.124.2025.08.06.22.29.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 22:29:43 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, jim.t90615@gmail.com, trini@konsulko.com,
 joe.hershberger@ni.com, rfried.dev@gmail.com, YSCHU@nuvoton.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v2] net: phy: broadcom: add support for BCM54612E
Date: Thu,  7 Aug 2025 13:29:31 +0800
Message-Id: <20250807052931.2169465-1-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
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

It's Broadcom PHY simply described as single-port
RGMII 10/100/1000BASE-T PHY.

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 drivers/net/phy/broadcom.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index 0a49015eb89..1c02e3efedc 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -134,6 +134,33 @@ static void bcm_phy_write_misc(struct phy_device *phydev,
 	phy_write(phydev, MDIO_DEVAD_NONE, MIIM_BCM54XX_EXP_DATA, value);
 }
 
+/* Broadcom BCM54612E */
+static int bcm54612e_config(struct phy_device *phydev)
+{
+	u32 reg = 0;
+
+	genphy_config_aneg(phydev);
+
+	phy_reset(phydev);
+
+	/* 125Mhz Clock Output Enable */
+	reg = phy_read(phydev, MDIO_DEVAD_NONE, MIIM_BCM54XX_EXP_SEL);
+	reg |= 0xD34;
+	phy_write(phydev, MDIO_DEVAD_NONE, MIIM_BCM54XX_EXP_SEL, reg);
+
+	reg = phy_read(phydev, MDIO_DEVAD_NONE, MIIM_BCM54XX_EXP_DATA);
+	reg |= (1 << 1);
+	phy_write(phydev, MDIO_DEVAD_NONE, MIIM_BCM54XX_EXP_DATA, reg);
+
+	reg = phy_read(phydev, MDIO_DEVAD_NONE, MIIM_BCM54XX_EXP_SEL);
+	reg &= 0xfffff000;
+	phy_write(phydev, MDIO_DEVAD_NONE, MIIM_BCM54XX_EXP_SEL, reg);
+
+	genphy_restart_aneg(phydev);
+
+	return 0;
+}
+
 /* Broadcom BCM5461S */
 static int bcm5461_config(struct phy_device *phydev)
 {
@@ -434,6 +461,16 @@ U_BOOT_PHY_DRIVER(bcm5461s) = {
 	.shutdown = &genphy_shutdown,
 };
 
+U_BOOT_PHY_DRIVER(bcm54612e) = {
+	.name = "Broadcom BCM54612E",
+	.uid = 0x03625e6a,
+	.mask = 0xfffff0,
+	.features = PHY_GBIT_FEATURES,
+	.config = &bcm54612e_config,
+	.startup = &bcm54xx_startup,
+	.shutdown = &genphy_shutdown,
+};
+
 U_BOOT_PHY_DRIVER(bcm5464s) = {
 	.name = "Broadcom BCM5464S",
 	.uid = 0x2060b0,
-- 
2.34.1

