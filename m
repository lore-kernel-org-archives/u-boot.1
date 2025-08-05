Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ABF8C87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 09:20:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9434C83531;
	Tue,  5 Aug 2025 11:20:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eYYDWQiL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3394B801DD; Tue,  5 Aug 2025 11:20:04 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84BEC834A3
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 11:20:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-76bc68cc9e4so4516902b3a.2
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 02:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754385599; x=1754990399; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VTzRIp+WTnxoJqCbaSaitImJg+O5rgF+dfjjB5GrBTQ=;
 b=eYYDWQiLPfLEybTY2vvT3t0f4Ol3oT11EnvWsSeEKu6oMfrs3DuBwB3K4SUZ/SOilN
 duf2HSBfF20h397t6/Y+bno4XJMhyCC+JU6lfWDGEbCaPbTZJnCKmZXcJWOzs5WBP3j5
 Rwe30xPpI5nsBJ5vLML/K9IQDlK53g51eRAs6UbqPKn42igIrIExcYiEiv7P6E27U5Yc
 wrjLwqj8wWQNxDNWHQ0XrzzlKOfO4jHImxZxI20LvIoK2cxPSjBbBda+StbALBgxSgqh
 8o0nX76oOF/a3IKFt5b9RePn3cHx8Q5cm9SMVJDu3OLwTee8qhHlLfV+V7BQ64uCxypB
 txUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754385599; x=1754990399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VTzRIp+WTnxoJqCbaSaitImJg+O5rgF+dfjjB5GrBTQ=;
 b=g+iaLp4aE8WiBIvE5QLFkdGdhnA7AT2h2wXcPyAC7/x9EQGHag/ggZYlu8z9qPjDxO
 +XnDR72AMSBi72evqPv0/8S/dZftOTyHYnLCLSSLkB3gmnJaBaBl5Sv+n3GQlzcuPu5x
 or2mj1RV18UYjtEZygB/C9sh0712Ve7w+9LddJ2hEB/aaLxp/Lt2Ok6RB6Y4z/nZ3SfJ
 sTMtKnysdLCWgWiDnPvPKlOtUUthx4gmDuhvEroS267Hm3rciNjQtyHk3CA1a7B4iY+e
 VfTy8ST2FGvJ7kL77UYHaPKWtJrEn2GVNlRNt6uHv+2E9QUn4cmgjOC5rNcR0LYycUpf
 HHjQ==
X-Gm-Message-State: AOJu0YwHI5OkI42ZJYGtAToVCRaPY+NdEhVelA6GJbyQO6sZ7KvsLjY4
 Ufp572TRYizb/zxIBjymkUeo4gkAesH4ds38pJYj54fvIgZ4RRgznf5SDo4FzlJy
X-Gm-Gg: ASbGncv+XJrxCnFIFUdH2wndMS52VoO5U3GbtJsz0rU+wdUaNdzPnqmy9wif5ma5IiX
 s0ZRC0UQtvjP1AedDBm1M5og5wIuVrrk999anRyiasi9dnNzBj7yc+ENXWalu155IaaYezUI//z
 9IwWdb9mOXLJYB5ycmXVF4mH0vP6sdWk4CUrdT2ss+HTgqn7Dkfv74mxh6IizSxdc6p7A3hEMWx
 5Jx4HpQKn8THK+wT/Ad4cT4jcJpdFTFdgiCl5+Rj1QEYx0Ct2Wqponxdh+adPOv75d14d4VeoHd
 8QYlnK+wbGbfHko7jFtxkssjCM1oqrvuaO8Oi7hAtTPQg2A28u8qjQl7/FDagEVHSLtG1oE7ZdC
 VM8pVVqr+8hQpj9b25dYsz6yr9vSOnLfr7Q==
X-Google-Smtp-Source: AGHT+IGZC6WYMyL+Km58IEZylHZxIgzp34wNIscvqETleoiut4kWbWcb5wX14sxK7wmZ7Aixag0TNA==
X-Received: by 2002:a05:6a20:939e:b0:240:50d:4285 with SMTP id
 adf61e73a8af0-240050d4b8cmr12490952637.38.1754385599037; 
 Tue, 05 Aug 2025 02:19:59 -0700 (PDT)
Received: from cs20-buildserver.lan ([2402:7500:400:60db:2e0:4cff:fe68:863])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce89125sm12495185b3a.33.2025.08.05.02.19.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 02:19:58 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, jim.t90615@gmail.com, YSCHU@nuvoton.com,
 trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 4/9] net: phy: broadcom: add support for BCM54612E
Date: Tue,  5 Aug 2025 17:18:45 +0800
Message-Id: <20250805091850.2051096-5-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250805091850.2051096-1-JJLIU0@nuvoton.com>
References: <20250805091850.2051096-1-JJLIU0@nuvoton.com>
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

