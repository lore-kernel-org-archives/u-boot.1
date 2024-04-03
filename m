Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23AAECD128A
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 12:10:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74895883CE;
	Wed,  3 Apr 2024 14:08:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bRrIR0Yp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 242B9883BD; Wed,  3 Apr 2024 14:08:10 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84F858839F
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 14:08:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a4e5ee91879so457409566b.3
 for <u-boot@lists.denx.de>; Wed, 03 Apr 2024 05:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712146085; x=1712750885; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lXyr6tJR6QFXRSTjw1XngBqNszpjZjRzQWF6T1YQB14=;
 b=bRrIR0YpahYC/V/b8uGNrWwqrFqWYDOOD9k7h/JtzeixxEh8cFuz7LnGldHwJWfK1W
 Q6U1xxTR/qB3KSVTbX2HXmeYLB8waxx/sCePzCpyfoCRmwJcRgmBgU28Hi1j4pCxuf99
 wjW9jRmI3/r8aIHJ4+1ifosY7sc0REsVjt9MJqxE9iYqbQcWHMJUC/xyi8nVi7F+03rL
 yCTxtpRxYSBW/Q1NzqhzMUgSrzSrClf3lelmcq+tV5ujTi0VWmY4r/eD/DpU7Ze/wKBx
 /Aww5e6bBNU59WzgEaGjisv71JngtFvmpudLtQwRIjzFan3QzNF91zUdwjPEMZzY4n34
 ripw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712146085; x=1712750885;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lXyr6tJR6QFXRSTjw1XngBqNszpjZjRzQWF6T1YQB14=;
 b=lBJwsIaKHfL0/ABUH8abJMQTAqJJy1DzC4Owzmce8Z0lZEWs/J32jmYIyIdBPv3PRs
 mXjPyvsAvZRnhAhZInjWSELgf6refEbc9b69o14iqL7F4a7Mr4X3csU67KFYz6YqHyGX
 QBJlhZPt63zdecO81azT3RJcxsv0NGWiFiFZzWF72G2RpNg8y7iYu0qlBO3wgtaMFRCv
 Ild0IuYgmwzxMSp0rtY/uJre7Va/DIhxnSRNsvssJnZhqXWeeP+vJyDCxsXubDnXDtBx
 d0DNFH83l1M2yQGNd9nPmFRl2ZqpP8TMyoX3qdhSPzyLb8oRQA808TV0SaTIcUy1ksXq
 ahrA==
X-Gm-Message-State: AOJu0YzS5HQiPwqOCFGIYQVs/YKHii0l66vOIHzH3ad/JYhsvYx6iNZr
 eUpluhsUkI2Uyzghv8uHqIgyHxECMjaZ37r9VbnMny9QIW3B+0BifE3hHRCHeKU=
X-Google-Smtp-Source: AGHT+IHDzMoCihRG9iOAaxuT9TbPiZmEKt1i2ovIttbRxTnHUx+VU+2w2gxs1Ltv46GmaEJIezzC+w==
X-Received: by 2002:a17:906:251b:b0:a4e:21e0:2e6e with SMTP id
 i27-20020a170906251b00b00a4e21e02e6emr1760632ejb.5.1712146085119; 
 Wed, 03 Apr 2024 05:08:05 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::38e6])
 by smtp.gmail.com with ESMTPSA id
 lr20-20020a170906fb9400b00a46a04d7dc4sm7654674ejb.61.2024.04.03.05.08.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Apr 2024 05:08:04 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 03 Apr 2024 14:07:50 +0200
Subject: [PATCH v6 15/16] qcom_defconfig: enable USB
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-b4-qcom-livetree-v6-15-130f8f50b538@linaro.org>
References: <20240403-b4-qcom-livetree-v6-0-130f8f50b538@linaro.org>
In-Reply-To: <20240403-b4-qcom-livetree-v6-0-130f8f50b538@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=3037;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=IiD4QOo4vMkDUnm2KTlh/8akfMnxgScbcOmu27O4wOg=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmDUaRqzvIYQZ/RjSRt07WmWRnBYvOAq7BEx9uA
 UiEPOSiRxCJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZg1GkQAKCRAFgzErGV9k
 ts5GD/99sMJAEUdyITeqQ1w5MGwakn3EUmV7X/iZgdT2rZXqxoJtA61jP9Vubv6rrZlxeqW0CSd
 QmJjw4LVVUeVMrRjtM7jZkGvSZk6eqBtAnc019wAS3oOfBGuw6KTFsct1WTVyVFgPv3lMW4lIA5
 /+9R6YG1nCtO3UobWgMpBF1ChQl09YDczB6E/A1bMxFeWCddbQvgXGHFpxH9iYC5bTELTWvL+cU
 za6mFNJSE1lToYryMEfHlr+8vZYH7cUO8Rfu6zxYwL3JoxwuFXAlLjeU/0StwpoCm+Xmn0/Hl6y
 G7pm8mzzXnNaaSl3UaFb6asEIyenDH9+iIp4pxuVVBNNyGdi1UHnnpN8pW94X+ymRqjoSQZmiiE
 0FJ0bivCT79Z13IGXWuuYgebINhtf0yPlgo/xIHPG5kAIgxdYHisEv1PPdX3dUYfKy41ZbgdB/7
 fUOmBhbzOjdIodVD3jHHSKn246KsB+fWGapnzTrdhos+S88CGudQn0KX4gVwlY3Bpji1r3AvK7+
 zFkHIi1vsr/PfiuifdTeZwW0Mf1qlO8Dg2d9tjYEYTf9o3xdqFDI6Vkr8SP+DcPLO7BZUNwsUVB
 Vk9h+K1uD6PsyqZ1kgpONGyAMiOIlh7EEFFwhyr7X5bvv3DyqXSXP+YV/LuDc7PjIDkC/xaAnXf
 mFuV4xhiZd0rqGQ==
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

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
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

