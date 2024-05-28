Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA5E4C25B7E
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 19:15:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E136C88555;
	Tue, 28 May 2024 21:15:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Auc4aGGP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2096E88580; Tue, 28 May 2024 21:15:23 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CBA788577
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 21:15:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2bdd6b73a3aso211589a91.3
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 12:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716923719; x=1717528519; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K/HvvPjT5jS6DJlBWw5Ho5w7l50LcdfY3UoLqOzPGUk=;
 b=Auc4aGGP8Vq+OCJQ5N+3vioLmNjqc32e4CZZYyO02R9ZIAY/Gn+5K+5T1X6vqVMUHM
 3QN0F05B+zXEwx6gXnTokVl4Yky8u/B7IHI9gtrnyGqjP0GFosEpgfbQj3mcDj9WsOrR
 mbdV+o07RE8aFEs0zZlELOb5JImYXBtRM+HpdEPPArPfuYZ6U0kTDmwSTkgTqt6k1vxF
 WH2O4fgH5ZAX+iKowu0XFolldl0yJlW+oehTspklDbA0kf78vVoICrhAuLbLmPyvRRzN
 x+suu15s/+93rQlorxcl1GNjeReE42ElOb+gcAWue30llTs9arQRVD4bBHZs3GJn3yrf
 ZUWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716923719; x=1717528519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K/HvvPjT5jS6DJlBWw5Ho5w7l50LcdfY3UoLqOzPGUk=;
 b=i1wP/sXdy+5O9Zqo3wavIgdgBr1F9Me0rkTJlDr59GiHJjcxGMSg5HR4NiYGeJoD5y
 5id2WTKqXhwG1BKJMsI0AMIZUoYnZqnOo6VFG+j2APQsOJlykM4tJHdGUPvH7upIa7U+
 hj2Yq1JifJuC8ZFnGALopcgq+4O7/s19gJ+8+JtuIxsczEkjN76tOAGs/aOCUY6udBPx
 D8BqcX3dyhJqf65T9tRcZAaVXqKePkMNkyO8PjZtqv4KQdpvrK8VwfpaAXr2+iv0eCv0
 6Ca0y1U4vvYhFnkuB1U3MLm0o6E/3Jj3EhJRjt/o6ON6tHSjE6NP+L+a1/MWr3ELOGdx
 MIdQ==
X-Gm-Message-State: AOJu0YwFyWG86I7sv+vTkuI4duFAlvMp/5vbYQUEVUS/f4IAPKklAwS3
 LtT7In+bWdKS8QSvmJk0m6jJf+ClUbyqcoNl6e8ne5jS0OeyZODV
X-Google-Smtp-Source: AGHT+IHhIfa9dZhbPBNSj9OiZQJMKiAfXsgKo4cRSa7ygCrOUTqGN/IkRWgt0TUdXIe7iKc+d0+A2A==
X-Received: by 2002:a17:90a:53c6:b0:2bf:9370:5a55 with SMTP id
 98e67ed59e1d1-2bf93705c30mr8954817a91.2.1716923718832; 
 Tue, 28 May 2024 12:15:18 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:dfd9:2d9b:ff9d:4f57])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bf92de8b86sm6127952a91.45.2024.05.28.12.15.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 12:15:18 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: paul.liu@linaro.org
Cc: u-boot@lists.denx.de,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH 2/2] imx8mm-cl-iot-gate: Add support for the Realtek RTL8211E
 PHY
Date: Tue, 28 May 2024 16:15:10 -0300
Message-Id: <20240528191510.1366328-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528191510.1366328-1-festevam@gmail.com>
References: <20240528191510.1366328-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@denx.de>

Newer imx8mm-cl-iot-gate versions are populated with a Realtek RTL8211E
PHY instead of the Atheros AR8033.

Adapted Compulab's patch from:
https://github.com/compulab-yokneam/meta-bsp-imx8mm/blob/iot-gate-imx8_5.10.72/recipes-bsp/u-boot/compulab/imx8mm/0125-imx8mm-net-enable-phy-Realtek-RTL8211E.patch

to support both PHYs in U-Boot.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 .../imx8mm-cl-iot-gate/imx8mm-cl-iot-gate.c   | 106 +++++++++++++++++-
 include/configs/imx8mm-cl-iot-gate.h          |   2 +-
 2 files changed, 104 insertions(+), 4 deletions(-)

diff --git a/board/compulab/imx8mm-cl-iot-gate/imx8mm-cl-iot-gate.c b/board/compulab/imx8mm-cl-iot-gate/imx8mm-cl-iot-gate.c
index af070ec315c4..bf196e062bd0 100644
--- a/board/compulab/imx8mm-cl-iot-gate/imx8mm-cl-iot-gate.c
+++ b/board/compulab/imx8mm-cl-iot-gate/imx8mm-cl-iot-gate.c
@@ -9,6 +9,7 @@
 #include <efi_loader.h>
 #include <env.h>
 #include <extension_board.h>
+#include <fdt_support.h>
 #include <hang.h>
 #include <i2c.h>
 #include <init.h>
@@ -31,6 +32,8 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+static int fec_phyaddr = -1;
+
 #if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
 struct efi_fw_image fw_images[] = {
 #if defined(CONFIG_TARGET_IMX8MM_CL_IOT_GATE)
@@ -110,10 +113,72 @@ static int setup_fec(void)
 	return 0;
 }
 
+#define FDT_PHYADDR "/soc@0/bus@30800000/ethernet@30be0000/mdio/ethernet-phy@0"
+#define FLIP_32B(val) (((val >> 24) & 0xff) | ((val << 8) & 0xff0000) | ((val >> 8) & 0xff00) | ((val << 24) & 0xff000000))
+static int fdt_set_fec_phy_addr(void *blob)
+{
+	u32 val;
+
+	if (fec_phyaddr < 0)
+		return -EINVAL;
+
+	val = FLIP_32B(fec_phyaddr);
+	return fdt_find_and_setprop(blob, FDT_PHYADDR, "reg", (const void *)&val,
+				    sizeof(val), 0);
+}
+
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	fdt_set_fec_phy_addr(blob);
+	return 0;
+}
+
+/*
+ * These are specific ID, purposed to distiguish between PHY vendors.
+ * These values are not equal to real vendors' OUI (half of MAC address)
+ */
+#define OUI_PHY_ATHEROS 0x1374
+#define OUI_PHY_REALTEK 0x0732
+
 int board_phy_config(struct phy_device *phydev)
 {
-	if (IS_ENABLED(CONFIG_FEC_MXC)) {
+	unsigned int model, rev, oui;
+	int phyid1, phyid2;
+	unsigned int reg;
+
+	if (!IS_ENABLED(CONFIG_FEC_MXC))
+		return 0;
+
+	phyid1 = phy_read(phydev, MDIO_DEVAD_NONE, MII_PHYSID1);
+	if (phyid1 < 0) {
+		printf("%s: PHYID1 registry read fail %i\n", __func__, phyid1);
+		return phyid1;
+	}
+
+	phyid2 = phy_read(phydev, MDIO_DEVAD_NONE, MII_PHYSID2);
+	if (phyid2 < 0) {
+		printf("%s: PHYID2 registry read fail %i\n", __func__, phyid2);
+		return phyid2;
+	}
+
+	reg = phyid2 | phyid1 << 16;
+	if (reg == 0xffff) {
+		printf("%s: There is no device @%i\n", __func__, phydev->addr);
+		return -ENODEV;
+	}
+
+	rev = reg & 0xf;
+	reg >>= 4;
+	model = reg & 0x3f;
+	reg >>= 6;
+	oui = reg;
+	debug("%s: PHY @0x%x OUI 0x%06x model 0x%x rev 0x%x\n",
+	      __func__, phydev->addr, oui, model, rev);
+
+	switch (oui) {
+	case OUI_PHY_ATHEROS:
 		/* enable rgmii rxc skew and phy mode select to RGMII copper */
+		printf("phy: AR803x@%x\t", phydev->addr);
 		phy_write(phydev, MDIO_DEVAD_NONE, 0x1d, 0x1f);
 		phy_write(phydev, MDIO_DEVAD_NONE, 0x1e, 0x8);
 
@@ -121,10 +186,45 @@ int board_phy_config(struct phy_device *phydev)
 		phy_write(phydev, MDIO_DEVAD_NONE, 0x1e, 0x82ee);
 		phy_write(phydev, MDIO_DEVAD_NONE, 0x1d, 0x05);
 		phy_write(phydev, MDIO_DEVAD_NONE, 0x1e, 0x100);
+		break;
+	case OUI_PHY_REALTEK:
+		printf("phy: RTL8211E@%x\t", phydev->addr);
+		/* RTL8211E-VB-CG - add TX and RX delay */
+		unsigned short val;
+
+		phy_write(phydev, MDIO_DEVAD_NONE, 0x1f, 0x07);
+		phy_write(phydev, MDIO_DEVAD_NONE, 0x1e, 0xa4);
+		val = phy_read(phydev, MDIO_DEVAD_NONE, 0x1c);
+		val |= (0x1 << 13) | (0x1 << 12) | (0x1 << 11);
+		phy_write(phydev, MDIO_DEVAD_NONE, 0x1c, val);
+		/* LEDs: set to extension page */
+		phy_write(phydev, MDIO_DEVAD_NONE, 0x1f, 0x0007);
+		/* extension Page44 */
+		phy_write(phydev, MDIO_DEVAD_NONE, 0x1e, 0x002c);
+		phy_write(phydev, MDIO_DEVAD_NONE, 0x1c, 0x0430);//LCR
+		phy_write(phydev, MDIO_DEVAD_NONE, 0x1a, 0x0010);//LACR
+		/*
+		 * To disable EEE LED mode (blinking .4s/2s)
+		 * Extension Page5
+		 */
+		phy_write(phydev, MDIO_DEVAD_NONE, 0x1f, 0x0005);
+		phy_write(phydev, MDIO_DEVAD_NONE, 0x05, 0x8b82);//magic const
+		phy_write(phydev, MDIO_DEVAD_NONE, 0x06, 0x052b);//magic const
+
+		phy_write(phydev, MDIO_DEVAD_NONE, 0x1f, 0x00);// Back to Page0
 
-		if (phydev->drv->config)
-			phydev->drv->config(phydev);
+		break;
+	default:
+		printf("%s: ERROR: unknown PHY @0x%x OUI 0x%06x model 0x%x rev 0x%x\n",
+		       __func__, phydev->addr, oui, model, rev);
+		return -ENOSYS;
 	}
+
+	fec_phyaddr = phydev->addr;
+
+	if (phydev->drv->config)
+		phydev->drv->config(phydev);
+
 	return 0;
 }
 
diff --git a/include/configs/imx8mm-cl-iot-gate.h b/include/configs/imx8mm-cl-iot-gate.h
index 09d87cf214bf..0c547027ba69 100644
--- a/include/configs/imx8mm-cl-iot-gate.h
+++ b/include/configs/imx8mm-cl-iot-gate.h
@@ -136,7 +136,7 @@
 #define CFG_SYS_FSL_USDHC_NUM	2
 #define CFG_SYS_FSL_ESDHC_ADDR	0
 
-#define CFG_FEC_MXC_PHYADDR		0
+#define CFG_FEC_MXC_PHYADDR		-1 /* Auto search of PHY on MII */
 
 /* USB Configs */
 #define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
-- 
2.34.1

