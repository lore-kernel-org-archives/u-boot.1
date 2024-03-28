Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A567CD11DF
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 18:02:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67FB9881FF;
	Thu, 28 Mar 2024 19:00:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="o4H1ZrlW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C328A881FF; Thu, 28 Mar 2024 19:00:00 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55AF0881F3
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 18:59:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-341ccef5058so808822f8f.2
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 10:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711648797; x=1712253597; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lO21LnQXMCtSkhTkeX8Wl6Wtl5Wfo0r1/e3rYdUQqpc=;
 b=o4H1ZrlWdOrlcQ01YSGcQ0ope3Otmhrb0tI2xE1tmVbk8FAAgSAHTL9+2YmpLR5HTh
 kXvrHhGT+UMRx1OSPB6Guh9fw9qRttlTFeus6UnCUDfFBJi1bcpj+Ab60DDOJTjI2hVw
 YeiY4gBOXysldfEpO76X4CPS9yTh+JP/e1efolSm3REPXqvennN2EegcsO82YLzeob+d
 ucmi05KYQ06zjfUNbeQzfhbE0Sn6xfSgO9mMGwHUwWODTqAIEa/FOUhc1UaIiQ3tQSBx
 VZDbexXyY7rDuq6G6gPSqTNwpj5QDyaPKtq/MRUYQ6BxQViQStRqycoX9smw3WFZg3/B
 XdfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711648797; x=1712253597;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lO21LnQXMCtSkhTkeX8Wl6Wtl5Wfo0r1/e3rYdUQqpc=;
 b=Hm9w+P1beq7LuJzArBBbpU3HdNrxgEX4jgM3lCKViid8t4zxQxABrsA6C2KkR1OJfk
 QSABRI0i0eHMl1q0AtJW91t7UfEA8bETWUlA4tJ87FYr8CGVMgdXX9fD3NM3NJoHh+CY
 bbxOfu8tGWNEgoQ/aS7iuLIred0AvFQhs8rO9F6uZSEp5Bi2rahZfHcwETe8oS90Pkh1
 OQihKUuxVECaHsLbPFmG9i6c5zYho/yrYb+3/uLn/ENUmmXh2GD3eEDYJ1Vb6pqrzabu
 GnRcsA5NJMSduw77wmursOVLDqf26IIqzeqv2MAboxp9QROUwrxpxjSm7D4PfQi8I7E4
 h0Cg==
X-Gm-Message-State: AOJu0YxGAL/svpOm2mYNMWDUKPnevVpFVm+sLTAYL7HU3w66HXZgFnG7
 iR9d7SY357WDPgDiyLbk9k9ypf43OGWx7AZScnk2IghmAHI5oRTwK98n9z7liTo=
X-Google-Smtp-Source: AGHT+IEwi3yGPMFACDw0TR0+et8RxxWK4Mxz08cQ21F6itoFh3xIy5lW1gyqb6woXUxb6rv1BLgOZg==
X-Received: by 2002:adf:f545:0:b0:341:b756:e1f0 with SMTP id
 j5-20020adff545000000b00341b756e1f0mr2318433wrp.43.1711648796842; 
 Thu, 28 Mar 2024 10:59:56 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 y13-20020a5d4acd000000b00341e5f487casm2292237wrs.46.2024.03.28.10.59.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 10:59:56 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 28 Mar 2024 17:59:21 +0000
Subject: [PATCH v5 15/16] qcom_defconfig: enable USB
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-b4-qcom-livetree-v5-15-4e98228b3d03@linaro.org>
References: <20240328-b4-qcom-livetree-v5-0-4e98228b3d03@linaro.org>
In-Reply-To: <20240328-b4-qcom-livetree-v5-0-4e98228b3d03@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2988;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=qMux8kYFMKD1yGjXCds2wskyfESIrZwEYpVx4JQGqc4=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhjTWDVyrdoab+mvbHi/5d/DC56c/5muo6uy98DVqoX5NQ
 +u9d2HbO0pZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBEJl1i+Kd1etVj65pHZtxB
 jXK5onnCayo7ntYcms6me+zc7svyvPYM/yP72c946FwRePm4+kApi9eFCq2fgn1HfDweuMQfP3I
 49x4A
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Enable support for the DWC3 USB controller and required dependencies for
Qualcomm boards, specifically the DB845c:
* IOMMU / SMMU
* USB high-speed PHYs
* Mass storage and ACM gadgets

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 configs/qcom_defconfig | 52 ++++++++++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 8c4402e8f780..1abb57345ff1 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -17,10 +17,16 @@ CONFIG_LOG_MAX_LEVEL=9
 CONFIG_LOG_DEFAULT_LEVEL=4
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_CMD_BOOTMENU=y
+CONFIG_CMD_EEPROM=y
+CONFIG_SYS_I2C_EEPROM_BUS=2
+CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
+CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=5
+# CONFIG_CMD_BIND is not set
 CONFIG_CMD_CLK=y
 CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_UFS=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_CAT=y
@@ -32,20 +38,39 @@ CONFIG_CLK=y
 CONFIG_CLK_QCOM_QCS404=y
 CONFIG_CLK_QCOM_SDM845=y
 CONFIG_MSM_GPIO=y
 CONFIG_QCOM_PMIC_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_QUP=y
+CONFIG_I2C_MUX=y
 CONFIG_DM_KEYBOARD=y
 CONFIG_BUTTON_KEYBOARD=y
+CONFIG_IOMMU=y
+CONFIG_QCOM_HYP_SMMU=y
+CONFIG_MISC=y
+CONFIG_NVMEM=y
+CONFIG_I2C_EEPROM=y
 CONFIG_MMC_HS200_SUPPORT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_MSM=y
+CONFIG_PHY_MICREL=y
+CONFIG_PHY_MICREL_KSZ90X1=y
+CONFIG_DM_MDIO=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_QCOM=y
+CONFIG_RGMII=y
 CONFIG_PHY=y
+CONFIG_PHY_QCOM_QUSB2=y
+CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_QCOM_QCS404=y
 CONFIG_PINCTRL_QCOM_SDM845=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_QCOM=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_SCSI=y
 CONFIG_MSM_SERIAL=y
 CONFIG_MSM_GENI_SERIAL=y
 CONFIG_SPMI_MSM=y
@@ -54,8 +79,12 @@ CONFIG_SYSINFO_SMBIOS=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_USB_FUNCTION_MASS_STORAGE=y
 CONFIG_UFS=y
 CONFIG_VIDEO=y
 # CONFIG_VIDEO_FONT_8X16 is not set
 CONFIG_VIDEO_FONT_16X32=y
@@ -64,27 +93,4 @@ CONFIG_NO_FB_CLEAR=y
 CONFIG_VIDEO_SIMPLE=y
 CONFIG_HEXDUMP=y
 # CONFIG_GENERATE_SMBIOS_TABLE is not set
 CONFIG_LMB_MAX_REGIONS=64
-CONFIG_CMD_DHCP=y
-CONFIG_CMD_EEPROM=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_PING=y
-CONFIG_DM_ETH=y
-CONFIG_DM_ETH_PHY=y
-CONFIG_DM_MDIO=y
-CONFIG_DWC_ETH_QOS=y
-CONFIG_DWC_ETH_QOS_QCOM=y
-CONFIG_RGMII=y
-CONFIG_PHY_MICREL=y
-CONFIG_PHY_MICREL_KSZ90X1=y
-CONFIG_MISC=y
-CONFIG_NVMEM=y
-CONFIG_DM_I2C=y
-CONFIG_I2C_SUPPORT=y
-CONFIG_I2C_MUX=y
-CONFIG_I2C_EEPROM=y
-CONFIG_SYS_I2C=y
-CONFIG_SYS_I2C_QUP=y
-CONFIG_SYS_I2C_EEPROM_BUS=2
-CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
-CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=5

-- 
2.44.0

