Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FEAC71135
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 09:46:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A284882CB8;
	Mon, 16 Jun 2025 11:45:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Gjq3NY7y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D367829F5; Mon, 16 Jun 2025 11:45:04 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E4AD829F5
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 11:45:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-450ce3a2dd5so40956635e9.3
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 02:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750067102; x=1750671902; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UY0LEHVBuxxCZxy26Maj/aw8cZ6rY0nS1ZHni5/12/k=;
 b=Gjq3NY7yHKTQG/jbPWOieh14XtWaD2ZmmnTk6a1iLOOMFlHUzLBhGDliOB9hmqVw8v
 JH9jqX6bzgZZG++I3JsfjTZqKE66SjxXjS9PlKvWcjgPIkGMGNL9glryzQEHUTO1FQyE
 SxbRXJs3jn4QTIKskFWuZgiNISIV9LCzktapEJGpPa116xvmRWlHeeEvtww2WxkgDUEw
 T9pz4hEvlqF3e19qJhPVk0PFMqK6lNotntOHKZbc2k+L7jjbx43+OyYdyGkg8yeIr5Vq
 0lbE5MLM5sMJVM5fMkQPsCeWBXLjnhV4SP7Qo1VSoiShPjBPs1OAbqHInXQ/9BmDqxel
 YPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750067102; x=1750671902;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UY0LEHVBuxxCZxy26Maj/aw8cZ6rY0nS1ZHni5/12/k=;
 b=CbYhRX2Z05chNvH3uI81yLCX6k9ax2CAf18ILep/2fSZjuwz+siKByofFv8RSGvtwv
 Zh6Nr41RJaxF4mkpcel3kT6NQjgvPapIZYlnSsX1Hc7frL+SpRsSMqYZhmY6Gvl6QMHl
 26WiDWVlqLkiWuVwrMKUJu7lHk+FoDFgXq8nGkuXeJsR+JEUPY4rB+L4dBWUpiqRLv7F
 0wrn+nVRNQA3/2EQttO2YqGkuqJ6kMzzI6qEofyqtyIk7F4Xv0AMEmVN0k1jxA7LeVvo
 IJJ06hcO7ZDPg2IgXGuTlGSnw/aris+82n/lu8PqPeHr3zQ2Ogl7rx2KPrjrUESKFwhF
 p1og==
X-Gm-Message-State: AOJu0YwUUmY2DCyNZCzWPmotjSl71yQEhda9BcYHCAPtzs98yxBmMZiR
 5cnxoUSQGwImhbRguFKhEYeQVuHEY9y3BO1OtK/Qj0Nzq/6OU0bLAreaA/IunwVbEXs=
X-Gm-Gg: ASbGncttCHmbkVg/TRezf5CNVFZp1gCPSnowdQic8UXURQnCyUwEpDPpFh6Ly/NFQ4K
 D+YE6h3m3qV8MkDOS+jIuZKkGYAUZ9yb2x9pvklraPcUm//dYswUOCN2rkCfuGPjJtdCadfkHRj
 SvJ4wsHlrLnC7KW7AnufVJ8f5sWOGgNoZRPvOakAFDUA36dNFz3qew5EcOeNjQukJtTdNBq3/gk
 vjDq1UX1En3nWILx8aWWcNHVNmQpM4rRJC+xqDfi953zdypst/xBivhi0Gd1AaWpli9aJtTyl3i
 amkizd3ssCGZoSWFEQ1+iEnLMdVUiGJg2IMw8UnRyGGxChSsTQeONgkmVk2e6U6cs+yVQVnRWh9
 2EH+W
X-Google-Smtp-Source: AGHT+IGmYf5XNrelidpFvhruU3XxDd/YPZho5rxL3bSmJEr4jLaQIs3+pGb0sAQC0ZKJQUZguaZNbA==
X-Received: by 2002:a05:600c:1c02:b0:450:d04e:22d6 with SMTP id
 5b1f17b1804b1-4533ca4e497mr74862335e9.7.1750067101831; 
 Mon, 16 Jun 2025 02:45:01 -0700 (PDT)
Received: from toyger.localdomain ([213.240.182.76])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532de8c229sm139308105e9.6.2025.06.16.02.45.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 02:45:01 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Mon, 16 Jun 2025 11:44:51 +0200
Subject: [PATCH v4 9/9] configs: qcom_*: enable QCOM_GENI where needed
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-geni-load-fw-v4-9-e7df44205505@linaro.org>
References: <20250616-geni-load-fw-v4-0-e7df44205505@linaro.org>
In-Reply-To: <20250616-geni-load-fw-v4-0-e7df44205505@linaro.org>
To: Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2986;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=yMJ4hHsnuAn/lBXW0ghmyoZkkGxaE/muJ+J7mW5WKtM=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoT+eOEMd5FStJzoAss6/faFqHokW9bt2zCsyAJ
 1PS0S0vtrqJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaE/njgAKCRAFgzErGV9k
 tjvED/oDg4Zkd7VhTqiQWprPieXquVkhncgbkHbWEG9d0dyT4DWV0BUH9Z+GBTjVRvL2pepLrDK
 Nai+GHWF9drnWmFqxhPFuvYAgC2piEK3Mxu0Ok7yAF9RsPhTJffElBnBAgwwRsVV2Fcny7aRUow
 cTrHHrIZFLhs1tGal+V5GQMswI9a54d5J/8ljd+iGgzGn++frsNZ13auv+j9K9503iNybId5Bdq
 LVrxzLng1uz1GsXWjAl9hGRR/eqnynXWx6Ay69pyfNjHixwXs0CqfboSQFueJna2wYzTfv/IU/e
 TFAvs7G2Dsj9785A+URlUN4U+RYcK+RJNHFL4Pu63lw1sgO9VipUK42SpwHqn6kpOGn36uwi9CU
 bg9QyHN8vvbbI8tQRMRhATGXJu/+nXxsu0S1qFML5ITSnVRocqQ8XXDHyXpIk2YjxXfsMhAvdt7
 x2jJ2tm2ZlLaYv51cml9qpVMAQrFtV2NVacw0IbDwKqO/wxJd84BDb1VirA3c0JNiVDzPce9B6g
 pZNLm77QRsH+IL2M8Qbz18WwyW/4AYB8O5deRUj3wDN+OUHscxMHjcoU8eeTGVP7XM6rEMBGNJS
 gN6QmA0FWNh0JdQYNcC4ePajsg9CoUfmVPjBbrC++vZigCG46Iwejw6Wb1YavJgshTSnT+9pMfe
 BL43ZnYWTROEItg==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
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

Enable the GENI MISC driver which is required for many Qualcomm
platforms.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 configs/chromebook_trogdor_defconfig | 2 +-
 configs/qcom_defconfig               | 3 ++-
 configs/qcom_ipq5424_mmc_defconfig   | 2 ++
 configs/qcom_ipq9574_mmc_defconfig   | 2 ++
 4 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/configs/chromebook_trogdor_defconfig b/configs/chromebook_trogdor_defconfig
index c90dc946494c7f1a25051da84b010e01bd4f9518..81853a6b86fb160021e4db775164311e2cdf8af5 100644
--- a/configs/chromebook_trogdor_defconfig
+++ b/configs/chromebook_trogdor_defconfig
@@ -74,9 +74,8 @@ CONFIG_CMD_EXT2=y
 CONFIG_CMD_EXT4=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_CMD_LOG=y
-CONFIG_PARTITION_TYPE_GUID=y
 CONFIG_OF_LIVE=y
 # CONFIG_OF_TAG_MIGRATE is not set
 CONFIG_DM_WARN=y
 # CONFIG_OFNODE_MULTI_TREE is not set
@@ -89,8 +88,9 @@ CONFIG_DM_I2C=y
 CONFIG_I2C_CROS_EC_TUNNEL=y
 CONFIG_SYS_I2C_GENI=y
 CONFIG_CROS_EC_KEYB=y
 CONFIG_MISC=y
+CONFIG_QCOM_GENI=y
 CONFIG_CROS_EC=y
 CONFIG_CROS_EC_SPI=y
 # CONFIG_MMC_PCI is not set
 CONFIG_MMC_SDHCI_MSM=y
diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 2afb930e103cac5801bea05f531f98ed046113a0..e53bd7fba484153e2334f1d2e016a173373b84c7 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -87,8 +87,9 @@ CONFIG_BUTTON_KEYBOARD=y
 CONFIG_IOMMU=y
 CONFIG_QCOM_HYP_SMMU=y
 CONFIG_MISC=y
 CONFIG_NVMEM=y
+CONFIG_QCOM_GENI=y
 CONFIG_I2C_EEPROM=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_MSM=y
@@ -150,8 +151,8 @@ CONFIG_VIDEO=y
 CONFIG_VIDEO_FONT_16X32=y
 CONFIG_SYS_WHITE_ON_BLACK=y
 CONFIG_NO_FB_CLEAR=y
 CONFIG_VIDEO_SIMPLE=y
-CONFIG_WDT_QCOM=y
 CONFIG_WDT=y
+CONFIG_WDT_QCOM=y
 # CONFIG_BINMAN_FDT is not set
 CONFIG_BINMAN_DTB="./arch/arm/dts/qcom-binman.dtb"
diff --git a/configs/qcom_ipq5424_mmc_defconfig b/configs/qcom_ipq5424_mmc_defconfig
index 81c3865193d73e3f1fc85bd342e3f1d25534c81d..cbd154f81c396b0b10c3c208efe52ff4077e0b54 100644
--- a/configs/qcom_ipq5424_mmc_defconfig
+++ b/configs/qcom_ipq5424_mmc_defconfig
@@ -34,8 +34,10 @@ CONFIG_CLK=y
 CONFIG_CLK_QCOM_IPQ5424=y
 CONFIG_MSM_GPIO=y
 # CONFIG_I2C is not set
 # CONFIG_INPUT is not set
+CONFIG_MISC=y
+CONFIG_QCOM_GENI=y
 CONFIG_MMC_HS200_SUPPORT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_MSM=y
diff --git a/configs/qcom_ipq9574_mmc_defconfig b/configs/qcom_ipq9574_mmc_defconfig
index 00abc8430596dadd574d5d2b7353ecfdef01e2b4..a14129d1e9b96118503a7e9c9ef8bcf2559981a7 100644
--- a/configs/qcom_ipq9574_mmc_defconfig
+++ b/configs/qcom_ipq9574_mmc_defconfig
@@ -33,8 +33,10 @@ CONFIG_CLK=y
 CONFIG_CLK_QCOM_IPQ9574=y
 CONFIG_MSM_GPIO=y
 # CONFIG_I2C is not set
 # CONFIG_INPUT is not set
+CONFIG_MISC=y
+CONFIG_QCOM_GENI=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_MSM=y
 CONFIG_MTD=y

-- 
2.49.0

