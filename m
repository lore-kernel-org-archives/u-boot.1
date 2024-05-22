Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7915CC25B77
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 10:06:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65A4A8857E;
	Wed, 22 May 2024 12:06:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="O0Aae6Zw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE73988435; Wed, 22 May 2024 12:06:45 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9942288473
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 12:06:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-56e1f3462caso10475381a12.3
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 03:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1716372403; x=1716977203; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XWCcuoDRr/DHuHXl1mRu4u4zD9eF2c1xV5nqik0LR1g=;
 b=O0Aae6Zwn+NHm2u8y4AS91b8v0Y2qHn8dVxeCSYyFCkG0iaZ59PsX9koLRDCebXCHw
 H+k26qulKHa6LysIGc/7s0RI6YxupDRN/G8ZxSpXov8QqSftaaZMz2nWyO2mO2laot+V
 KzqdvaN2jwn/cYRUt7e2vzuSwR9eB0AsHL/WK/D7tHPHCVPvvthttzYPm2kK0PFOCT22
 2MYqMRf4sGMfUaeBxiqmJ05FPU2nUU+tsovPLQLEHSLtgitsD5wY9e6dnITNrbr9xjLD
 wixokUS5AjA3nyNVjrHttPfkEb1i1yQntcNDNTEtFjssB7LSktE3E4gwIaVvMi++9tTt
 ZEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716372403; x=1716977203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XWCcuoDRr/DHuHXl1mRu4u4zD9eF2c1xV5nqik0LR1g=;
 b=MX4M8+EHQCAwO/jSHThZllBX+hlZIq5PXsy3NXWgaZRbf3yoMGCO/PpvuMDFd0ynoh
 dzZgPGCGXy5hdej2XqHRM3dVWGx2crwTAuVeUtVoE05rDlbw1lcvXJPrvntzXUyBDetp
 9OocH/clpyiUVuTo7ArYBc/F3yzOujeM6oQX8KWavTdWR8hX89fCYgGGPaS2FbpUZQI8
 K+aMumz9EEJo8Miv3choKt0p5JQb/bHkXUOdjzlV4FPEAPXZK7YiWSNLIiGTZZ+3yw9k
 yVH+Rb+uaCljSm6+vvez1KwgIFQDcZeF2CELgrvN1qel+zYU03Mbh5FsTGWKJSYgq/t4
 V7RQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNEJd9b40EZNX89l7U4DS2OwlsXIEcr1qTXrgnzeqLFpy6G69dBJ+x+tKv/I/WA3F3IYLVOB0Yw1OO9EbqxXO7NvR8Yw==
X-Gm-Message-State: AOJu0Yztce4SGDcY+2Ke+dOCbDo2C91qLxzUcVoSiGRyEISoXr4ah/tW
 PRZCePBzBHjVHt5/qBHobnZ1nH/3x6gJYTM2NpUIaJVYjmVshCIBJeqYekeyglQ=
X-Google-Smtp-Source: AGHT+IFq7kbDAisMKpGNpY2L2grBKicsDVhpyW/hA/IY/IRs3ehOJknX0xmkf7xD9V1IopNJ+nc8yw==
X-Received: by 2002:aa7:c408:0:b0:578:33f0:9eda with SMTP id
 4fb4d7f45d1cf-57833f0a5d9mr758027a12.16.1716372403160; 
 Wed, 22 May 2024 03:06:43 -0700 (PDT)
Received: from fedora.. (cpe-188-129-47-65.dynamic.amis.hr. [188.129.47.65])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-5733becfc2fsm18146146a12.39.2024.05.22.03.06.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 03:06:42 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: trini@konsulko.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 u-boot@lists.denx.de
Cc: j.beck@linefinity.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 2/2] net: phy: add Qualcomm QCA807x driver
Date: Wed, 22 May 2024 12:06:16 +0200
Message-ID: <20240522100638.224484-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240522100638.224484-1-robert.marko@sartura.hr>
References: <20240522100638.224484-1-robert.marko@sartura.hr>
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

This adds driver for the Qualcomm QCA8072 and QCA8075 PHY-s.

They are 2 or 5 port IEEE 802.3 clause 22 compliant
10BASE-Te, 100BASE-TX and 1000BASE-T PHY-s.

They feature 2 SerDes, one for PSGMII or QSGMII connection with MAC,
while second one is SGMII for connection to MAC or fiber.

Both models have a combo port that supports 1000BASE-X and 100BASE-FX
fiber (Currently not supported in U-Boot)

Each PHY inside of QCA807x series has 2 digitally controlled output only
pins that natively drive LED-s.

These PHY-s are commonly used in Qualcomm IPQ40xx, IPQ60xx and IPQ807x
boards.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/net/phy/Kconfig   |   6 ++
 drivers/net/phy/Makefile  |   1 +
 drivers/net/phy/qca807x.c | 211 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 218 insertions(+)
 create mode 100644 drivers/net/phy/qca807x.c

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 3d96938eab..cc79043b97 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -243,6 +243,12 @@ config PHY_NXP_TJA11XX
 	help
 	  Currently supports the NXP TJA1100 and TJA1101 PHY.
 
+config PHY_QCA807X
+	bool "Qualcomm QCA807x PHYs support"
+	help
+	  Currently supports the Qualcomm QCA8072, QCA8075 and the PSGMII
+	  control PHY.
+
 config PHY_REALTEK
 	bool "Realtek Ethernet PHYs support"
 
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 2487f366e1..b2d31fe4f2 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_PHY_MOTORCOMM) += motorcomm.o
 obj-$(CONFIG_PHY_NATSEMI) += natsemi.o
 obj-$(CONFIG_PHY_NXP_C45_TJA11XX) += nxp-c45-tja11xx.o
 obj-$(CONFIG_PHY_NXP_TJA11XX) += nxp-tja11xx.o
+obj-$(CONFIG_PHY_QCA807X) += qca807x.o
 obj-$(CONFIG_PHY_REALTEK) += realtek.o
 obj-$(CONFIG_PHY_SMSC) += smsc.o
 obj-$(CONFIG_PHY_TERANETICS) += teranetics.o
diff --git a/drivers/net/phy/qca807x.c b/drivers/net/phy/qca807x.c
new file mode 100644
index 0000000000..a851ff34a0
--- /dev/null
+++ b/drivers/net/phy/qca807x.c
@@ -0,0 +1,211 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2024 Sartura Ltd.
+ *
+ * Author: Robert Marko <robert.marko@sartura.hr>
+ *
+ * Qualcomm QCA8072 and QCA8075 PHY driver
+ */
+
+#include <dm/device_compat.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <phy.h>
+
+#define PHY_ID_QCA8072			0x004dd0b2
+#define PHY_ID_QCA8075			0x004dd0b1
+#define PHY_ID_QCA807X_PSGMII		0x06820805
+#define PHY_ID_QCA807X_MASK		GENMASK(31, 0)
+
+#define QCA807X_CHIP_CONFIGURATION 				0x1f
+#define QCA807X_MMD7_1000BASE_T_POWER_SAVE_PER_CABLE_LENGTH	0x801a
+#define QCA807X_CONTROL_DAC_MASK				GENMASK(2, 0)
+/* List of tweaks enabled by this bit:
+ * - With both FULL amplitude and FULL bias current: bias current
+ *   is set to half.
+ * - With only DSP amplitude: bias current is set to half and
+ *   is set to 1/4 with cable < 10m.
+ * - With DSP bias current (included both DSP amplitude and
+ *   DSP bias current): bias current is half the detected current
+ *   with cable < 10m.
+ */
+#define QCA807X_CONTROL_DAC_BIAS_CURRENT_TWEAK			BIT(2)
+#define QCA807X_CONTROL_DAC_DSP_BIAS_CURRENT			BIT(1)
+#define QCA807X_CONTROL_DAC_DSP_AMPLITUDE			BIT(0)
+
+#define QCA807X_MMD7_LED_100N_1 	0x8074
+#define QCA807X_MMD7_LED_100N_2 	0x8075
+#define QCA807X_MMD7_LED_1000N_1 	0x8076
+#define QCA807X_MMD7_LED_1000N_2 	0x8077
+#define QCA807X_LED_TXACT_BLK_EN_2 	BIT(10)
+#define QCA807X_LED_RXACT_BLK_EN_2 	BIT(9)
+#define QCA807X_LED_GT_ON_EN_2 		BIT(6)
+#define QCA807X_LED_HT_ON_EN_2 		BIT(5)
+#define QCA807X_LED_BT_ON_EN_2 		BIT(4)
+
+/* PSGMII PHY specific */
+#define PSGMII_QSGMII_DRIVE_CONTROL_1 		0xb
+#define PSGMII_QSGMII_TX_DRIVER_MASK		GENMASK(7, 4)
+#define PQSGMII_TX_DRIVER_140MV				0x0
+#define PQSGMII_TX_DRIVER_160MV				0x1
+#define PQSGMII_TX_DRIVER_180MV				0x2
+#define PQSGMII_TX_DRIVER_200MV				0x3
+#define PQSGMII_TX_DRIVER_220MV				0x4
+#define PQSGMII_TX_DRIVER_240MV				0x5
+#define PQSGMII_TX_DRIVER_260MV				0x6
+#define PQSGMII_TX_DRIVER_280MV				0x7
+#define PQSGMII_TX_DRIVER_300MV				0x8
+#define PQSGMII_TX_DRIVER_320MV				0x9
+#define PQSGMII_TX_DRIVER_400MV				0xa
+#define PQSGMII_TX_DRIVER_500MV				0xb
+#define PQSGMII_TX_DRIVER_600MV				0xc
+#define PSGMII_MODE_CTRL 			0x6d
+#define PSGMII_MODE_CTRL_AZ_WORKAROUND_MASK 	GENMASK(3, 0)
+#define PSGMII_MMD3_SERDES_CONTROL		0x805a
+
+static int qca807x_config(struct phy_device *phydev)
+{
+	int control_dac, ret = 0;
+	bool dac_full_amplitude;
+	bool dac_full_bias_current;
+	bool dac_disable_bias_current_tweak;
+	ofnode node;
+
+	node = phy_get_ofnode(phydev);
+	if (!ofnode_valid(node))
+		return -EINVAL;
+
+	dac_full_amplitude = ofnode_read_bool(node, "qcom,dac-full-amplitude");
+	dac_full_bias_current = ofnode_read_bool(node, "qcom,dac-full-bias-current");
+	dac_disable_bias_current_tweak = ofnode_read_bool(node, "qcom,dac-disable-bias-current-tweak");
+
+	/* Check for Combo port */
+	if(phy_read(phydev, MDIO_DEVAD_NONE, QCA807X_CHIP_CONFIGURATION)) {
+		int psgmii_serdes;
+
+		/* Prevent PSGMII going into hibernation via PSGMII self test */
+		psgmii_serdes = phy_read_mmd(phydev, MDIO_MMD_PCS, PSGMII_MMD3_SERDES_CONTROL);
+		psgmii_serdes &= ~BIT(1);
+		ret = phy_write_mmd(phydev, MDIO_MMD_PCS, PSGMII_MMD3_SERDES_CONTROL, psgmii_serdes);
+	}
+
+	control_dac = phy_read_mmd(phydev, MDIO_MMD_AN, QCA807X_MMD7_1000BASE_T_POWER_SAVE_PER_CABLE_LENGTH);
+	control_dac &= ~QCA807X_CONTROL_DAC_MASK;
+	if (!dac_full_amplitude)
+		control_dac |= QCA807X_CONTROL_DAC_DSP_AMPLITUDE;
+	if (!dac_full_amplitude)
+		control_dac |= QCA807X_CONTROL_DAC_DSP_BIAS_CURRENT;
+	if (!dac_disable_bias_current_tweak)
+		control_dac |= QCA807X_CONTROL_DAC_BIAS_CURRENT_TWEAK;
+	ret = phy_write_mmd(phydev, MDIO_MMD_AN, QCA807X_MMD7_1000BASE_T_POWER_SAVE_PER_CABLE_LENGTH, control_dac);
+
+	phydev->supported = phydev->drv->features;
+	phydev->advertising = phydev->drv->features;
+
+	genphy_config_aneg(phydev);
+	genphy_restart_aneg(phydev);
+
+	return ret;
+}
+
+static int qca807x_psgmii_config(struct phy_device *phydev)
+{
+	int psgmii_az, tx_amp, ret = 0;
+	u32 tx_drive_strength;
+	ofnode node;
+
+	node = phy_get_ofnode(phydev);
+	if (!ofnode_valid(node))
+		return -EINVAL;
+
+	/* Default to 600mw if not defined */
+	if (ofnode_read_u32(node, "qcom,tx-drive-strength-milliwatt",
+	                    &tx_drive_strength))
+		tx_drive_strength = 600;
+
+	switch (tx_drive_strength) {
+	case 140:
+		tx_drive_strength = PQSGMII_TX_DRIVER_140MV;
+		break;
+	case 160:
+		tx_drive_strength = PQSGMII_TX_DRIVER_160MV;
+		break;
+	case 180:
+		tx_drive_strength = PQSGMII_TX_DRIVER_180MV;
+		break;
+	case 200:
+		tx_drive_strength = PQSGMII_TX_DRIVER_200MV;
+		break;
+	case 220:
+		tx_drive_strength = PQSGMII_TX_DRIVER_220MV;
+		break;
+	case 240:
+		tx_drive_strength = PQSGMII_TX_DRIVER_240MV;
+		break;
+	case 260:
+		tx_drive_strength = PQSGMII_TX_DRIVER_260MV;
+		break;
+	case 280:
+		tx_drive_strength = PQSGMII_TX_DRIVER_280MV;
+		break;
+	case 300:
+		tx_drive_strength = PQSGMII_TX_DRIVER_300MV;
+		break;
+	case 320:
+		tx_drive_strength = PQSGMII_TX_DRIVER_320MV;
+		break;
+	case 400:
+		tx_drive_strength = PQSGMII_TX_DRIVER_400MV;
+		break;
+	case 500:
+		tx_drive_strength = PQSGMII_TX_DRIVER_500MV;
+		break;
+	case 600:
+		tx_drive_strength = PQSGMII_TX_DRIVER_600MV;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Workaround to enable AZ transmitting ability */
+	psgmii_az = phy_read_mmd(phydev, MDIO_MMD_PMAPMD, PSGMII_MODE_CTRL);
+	psgmii_az &= ~PSGMII_MODE_CTRL_AZ_WORKAROUND_MASK;
+	psgmii_az |= FIELD_PREP(PSGMII_MODE_CTRL_AZ_WORKAROUND_MASK, 0xc);
+	ret = phy_write_mmd(phydev, MDIO_MMD_PMAPMD, PSGMII_MODE_CTRL, psgmii_az);
+	psgmii_az = phy_read_mmd(phydev, MDIO_MMD_PMAPMD, PSGMII_MODE_CTRL);
+
+
+	tx_amp = phy_read(phydev, MDIO_DEVAD_NONE, PSGMII_QSGMII_DRIVE_CONTROL_1);
+	tx_amp &= ~PSGMII_QSGMII_TX_DRIVER_MASK;
+	tx_amp |= FIELD_PREP(PSGMII_QSGMII_TX_DRIVER_MASK, tx_drive_strength);
+	ret = phy_write(phydev, MDIO_DEVAD_NONE, PSGMII_QSGMII_DRIVE_CONTROL_1, tx_amp);
+
+	return ret;
+}
+
+U_BOOT_PHY_DRIVER(QCA8072_driver) =  {
+	.name = "Qualcomm QCA8072",
+	.uid = PHY_ID_QCA8072,
+	.mask = PHY_ID_QCA807X_MASK,
+	.features = PHY_GBIT_FEATURES,
+	.config = qca807x_config,
+	.startup = genphy_startup,
+	.shutdown = genphy_shutdown,
+};
+
+U_BOOT_PHY_DRIVER(QCA8075_driver) =  {
+	.name = "Qualcomm QCA8075",
+	.uid = PHY_ID_QCA8075,
+	.mask = PHY_ID_QCA807X_MASK,
+	.features = PHY_GBIT_FEATURES,
+	.config = qca807x_config,
+	.startup = genphy_startup,
+	.shutdown = genphy_shutdown,
+};
+
+U_BOOT_PHY_DRIVER(QCA807X_PSGMII_driver) =  {
+	.name = "Qualcomm QCA807x PSGMII",
+	.uid = PHY_ID_QCA807X_PSGMII,
+	.mask = PHY_ID_QCA807X_MASK,
+	.config = qca807x_psgmii_config,
+};
-- 
2.45.1

