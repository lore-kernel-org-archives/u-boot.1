Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28DE8C54E60
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 12:24:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09BB687FCC;
	Tue, 19 Mar 2024 13:23:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hxoKqBYR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7679D87FEE; Tue, 19 Mar 2024 13:22:57 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0650880A6
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 13:22:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-414676fe047so2435405e9.2
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 05:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710850970; x=1711455770; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pdq+iYZM9doxBiaqfYuN3zlWlFiZfOFDgIL00JcoHKU=;
 b=hxoKqBYRVeawk2yFVbNiTExb93aZ+h9H5IfjqRooopuQ5VRdLVX3hVO8FXcXZ7AGqJ
 Iw463c3HFLM8dHQupQWCkLo0QII7HGvBGwQ8w2VouVv889nBj6EwLHZpuhaC6b4mCjdu
 EaaFZFo/u0+16az0wEUGR09klKl130GqtAIbZSX13fAN4LJLW+izVJOl7CKc4VUgr7ID
 ZdIFfC8L9iJgi3wNeGpb3sLq5hU64xD2yTFft49WFgqwF5gngrXZ6igvVvAb1divTSbl
 5H5lYfFdRzFOonFUxUPsYJdF1i5gjlGHLT9VhKthv4FqfSkMbtphqrzta6fjRZqRfssf
 yOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710850970; x=1711455770;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pdq+iYZM9doxBiaqfYuN3zlWlFiZfOFDgIL00JcoHKU=;
 b=qvWo1J1CMQWcYKENg/XMq/n15k8BBS1vNuoEWB2T8GOM2+2NLYMTnZm6//5ZQed8u8
 95nuoJBlhpQC8OC/+2ae5TmWfK3U/1nNihlvxQZLcvkTdSqeNqxEzbKXBFk0K5AAKmqr
 hU3TyVXLKDGB757351hZfWW2ffIweCQfjAa5lp7hdKXhA1J4LXRBl6RoEkQ4BUp18p/4
 IBU6ANDIPUsz1SaGSOpjmhc38MNRBq9QHyq7YIENaQZLUoPYCIgiXrI/+NME1Uui4vAE
 Vx6xFr2KDKnlhSOruR8u8SP2NgrUnMvKyQLS4vbv2rt0ro/XWeaHvcgRlmAt3A7+uZ4B
 W3NQ==
X-Gm-Message-State: AOJu0Yxve6FGMJCWl4jqFqVQXiokB/jcjFpM9uR2wigWPENCqKDth+s/
 aLtpjwoblN+gllKb/eBYB4KfozCdkaxIfX/bpfqRdBpFa4GZYZYETeQ0OwEIVDi8Xv4CUqfZI3Y
 f
X-Google-Smtp-Source: AGHT+IF8/Rc1Sa1aYaBeQ9wWML4tJG8ITNz2sYta/rNV6nj9aId2YML123KiyNrhzG1gLMjwLF7Cog==
X-Received: by 2002:a05:600c:4e89:b0:413:eba4:f221 with SMTP id
 f9-20020a05600c4e8900b00413eba4f221mr9881672wmq.37.1710850969966; 
 Tue, 19 Mar 2024 05:22:49 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 du18-20020a0560000d5200b0033b7ce8b496sm12170498wrb.108.2024.03.19.05.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 05:22:49 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 19 Mar 2024 12:22:13 +0000
Subject: [PATCH v3 14/14] qcom_defconfig: enable USB
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-b4-qcom-livetree-v3-14-e1b38d9b4fa4@linaro.org>
References: <20240319-b4-qcom-livetree-v3-0-e1b38d9b4fa4@linaro.org>
In-Reply-To: <20240319-b4-qcom-livetree-v3-0-e1b38d9b4fa4@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3198;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=HWPxFuYU2JIZQzx7o55X+IT8yjx7pAsyxeMIGwbY4X0=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSfzV1FBZ1d2w+fe5QleVf/ykSrRaK7XytP+jH5/snau
 VuTVUKZOkpZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBE3qYx/A/cdvQwh0unx+6M
 f+YewU8t1m2If8S6pfHH9kj3hwKHgpYx/HdWWfTJmPnZmfuGa1V/clslJJsuk1xUMlGLZ+6BJ9d
 7n38GAA==
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
 configs/qcom_defconfig | 49 ++++++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index eebd0d74bd51..156c205284dd 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -12,42 +12,63 @@ CONFIG_BOOTSTD_FULL=y
 CONFIG_BOOTDELAY=1
 CONFIG_USE_PREBOOT=y
 CONFIG_SAVE_PREV_BL_INITRAMFS_START_ADDR=y
 CONFIG_SYS_CBSIZE=512
+# CONFIG_SYS_DEVICE_NULLDEV is not set
 CONFIG_LOG_MAX_LEVEL=9
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
 CONFIG_CMD_BMP=y
 CONFIG_CMD_LOG=y
 CONFIG_OF_LIVE=y
 # CONFIG_NET is not set
+CONFIG_DM_WARN=y
 # CONFIG_OFNODE_MULTI_TREE is not set
 CONFIG_BUTTON_QCOM_PMIC=y
 CONFIG_CLK=y
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
+CONFIG_DM_ETH_PHY=y
 CONFIG_PHY=y
+CONFIG_PHY_QCOM_QUSB2=y
+CONFIG_PHY_QCOM_USB_HS_7NM=y
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
@@ -56,8 +77,13 @@ CONFIG_SYSINFO_SMBIOS=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_USB_FUNCTION_MASS_STORAGE=y
+CONFIG_USB_FUNCTION_ACM=y
 CONFIG_UFS=y
 CONFIG_VIDEO=y
 # CONFIG_VIDEO_FONT_8X16 is not set
 CONFIG_VIDEO_FONT_16X32=y
@@ -66,27 +92,4 @@ CONFIG_NO_FB_CLEAR=y
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

