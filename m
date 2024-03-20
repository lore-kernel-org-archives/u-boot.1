Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8096C6FD1F
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 14:59:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0174A88103;
	Wed, 20 Mar 2024 15:57:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="b+DvN5Ph";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B16B88122; Wed, 20 Mar 2024 15:57:27 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4591B88111
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 15:57:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4146a1b6faaso9931665e9.1
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 07:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710946645; x=1711551445; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lO21LnQXMCtSkhTkeX8Wl6Wtl5Wfo0r1/e3rYdUQqpc=;
 b=b+DvN5PhhGfjjCE6Tm0C9plFVZXN7BvvF4mmYhrkAgQnzSHETCtUlr20kIqBDApYZL
 Yw3bErYZ1ZeMSmsVb/omwlaJV8GlP4yRQhQXySuB+M0vc3lwU+MerG4gFlQZyDUyZ908
 0Z9buP5vss9++PHF9DU8ptUqTMBrNaAp+lOcJAlEo28waLV/TVlU3VHca5W3LC0I0sQq
 65+FghDOmAhPkhfejTLDZx+qgN06C4cJTBohf50GL0VuisvNzySlxV2ERx4Kc2PLP/Up
 LeCc0R/MD9i2kbYh5oRbc8DHuXIkly7cWQSLqa/u45eVLzGhpCqUdChJ6K/FswZUQDsz
 uRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710946645; x=1711551445;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lO21LnQXMCtSkhTkeX8Wl6Wtl5Wfo0r1/e3rYdUQqpc=;
 b=fPRV7+rg+0+5S8QMCuqqmFBYvD3wwfg85BTBqJvLufn7hjI2ozyqbxYMvJowTJdBcU
 nDgVAA1EZOipCE195uL4mZEY0VwOWRtbUrKjiA4AMDnxhUYZJLVpphfMLl2CW6kO1LpQ
 X+OVAdfRjMWruR5SeGlNtshIjQDJCtI3K4fbK+ufbs2p0Jg+bz8wZK6nRwYoKwJdpgss
 f6aLc2xuaWA/7ptq/tDVWV8+wPHOMvUjkqAOJvcHys380mdMKZx8Jovk2/U5fklV4Wfn
 v7C4d1IZXg4Cfb0Bdr6w/LtU99UIpRcGxqiQ4bkyvqDuKhkzn2pbJIYxUXBOWOR6Zuhi
 Zj2g==
X-Gm-Message-State: AOJu0YxsfjCcdcYJlPmF7DvK3bE3Bqr1yVOs07pGSt8H0QoCO13g1kDo
 14O6Q3ojzs/urQVR6tqfwgnikePWsP7zKp2Riex0uL8b3kR8Jp8RgELJ4MFugTs=
X-Google-Smtp-Source: AGHT+IF6wJ13rpSev4vs2CibQJ/rGnYQojCCpmqprvlGT9F4FeRUrdNQE5jnb9rQICIpuUHMhAoRiA==
X-Received: by 2002:a05:600c:364a:b0:413:3110:2d06 with SMTP id
 y10-20020a05600c364a00b0041331102d06mr11740624wmq.16.1710946644863; 
 Wed, 20 Mar 2024 07:57:24 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 bi16-20020a05600c3d9000b0041468f79fd5sm2461268wmb.16.2024.03.20.07.57.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 07:57:24 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 20 Mar 2024 14:57:17 +0000
Subject: [PATCH v4 14/14] qcom_defconfig: enable USB
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240320-b4-qcom-livetree-v4-14-d867ab1f06c2@linaro.org>
References: <20240320-b4-qcom-livetree-v4-0-d867ab1f06c2@linaro.org>
In-Reply-To: <20240320-b4-qcom-livetree-v4-0-d867ab1f06c2@linaro.org>
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
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRfP52yX/BdmHP8YrVE/rSnQgXb95zd+uPDFfufz/a88
 xBaFFXU3VHKwiDIwSArpsgifmKZZdPay/Ya2xdcgJnDygQyhIGLUwAusoXhr3yEwgKb5WvE+VPv
 vW94fW7prdnXktr23TSsPPQgw+xovQ4jw/yzolby3OvLe6TfT+jb43j967TXDhe5Fs+z47G7kvr
 z0B4A
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

