Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 398C6C46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 14:11:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 218FA87E07;
	Tue, 30 Jan 2024 15:06:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OGQzDMl+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3B4887E0A; Tue, 30 Jan 2024 15:06:07 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C02F87E07
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 15:05:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40ef64d8955so19268345e9.3
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 06:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706623546; x=1707228346; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vWroW2rlDElcpUoSDk3OLuEzve9zQRa4Yblm+AQqfiA=;
 b=OGQzDMl+PmuCbKCBfIq+tpLuQbTPdp40KSCI5R2IJYg4mQ+PyfUzeDXdBOV8iZqA6K
 N4m8O7yxCArbD35O74rZs37CQNeIPcED0VD9Tp8T/GebYgHCkqbTE5afy7SAbKTquTM/
 /OzJC2JL0cnBEIbRM0QDHkaLJlwA0TsrK/vucFn/CPILNjUY2kAsjjGmsvDLjpirzbne
 GWz/BGuCpvijUllMKZDk4JG4oVc7n+TfZnzPJETccGzbzLITvHorK/HiP7ZbMraZKx5R
 CZC/pc72YE8abm6cY8hjFpjhc7YDlbhgJ8qDL4R/E4ZycTNXxBOod1+90HCscQgPphj5
 a4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706623546; x=1707228346;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vWroW2rlDElcpUoSDk3OLuEzve9zQRa4Yblm+AQqfiA=;
 b=UlpoKPvpPgGXKjIrod/PbJjbfBzNNjQZYkGcitgxcaUiaJg6eaGe5gGNsaAg3iDU94
 /8ENawLfljZFzEP4jiha8wd2CXx6EuxVcUg6NdjHinw8ReKP+8WRn84TU8/gyUkXJDD0
 b04Lrjqh6LYxWqUNeVkNPOATg8ZhDcInZ5TaJB3gRjxgn5TO/eU6MqOFdaTrKsiYQrrz
 AAR+HWtowypJ/GeFT09vz2Zc37uxA+enx07yWdCpdaFXRdVX7jUcLwUIzB/Vu/5gbJKe
 6U4InsM8KrAK15iT0Cxqll+HIfpE0nfrtHRSwJBS9+sNaFYGnKNUIT2HGFHZ67QpyaoR
 o3XQ==
X-Gm-Message-State: AOJu0Ywp6WuwR/8iaiwliTq1gAle2Pt+qx2NnSplWAjs0tmOQqojZgan
 osznzqk3ELwuyU7KMSe1DdugErYZ8RVRjPxvqa40pZ5mB/tn7HzM9q6H0dVo3MM=
X-Google-Smtp-Source: AGHT+IEWVv6UmGC9elKo+02OUxXq7jxRJCoBy/GXO622ugrO30QGXp4TxITvVNFN+MO5mkcPiodGPQ==
X-Received: by 2002:a05:600c:3548:b0:40e:fce3:3daf with SMTP id
 i8-20020a05600c354800b0040efce33dafmr2515251wmq.19.1706623546210; 
 Tue, 30 Jan 2024 06:05:46 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 g11-20020a05600c310b00b0040f035bebfcsm1799017wmo.12.2024.01.30.06.05.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 06:05:45 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 30 Jan 2024 14:05:22 +0000
Subject: [PATCH v3 34/36] board: qcs404-evb: drop board code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-b4-qcom-common-target-v3-34-e523cbf9e556@linaro.org>
References: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
In-Reply-To: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=4069;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=ac7cCxxCW5o2lXhaHnvXcgbTeHh8Gv/1t2AVE8SNPbQ=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSdTMJlDz49l5pXMafk0albSWJ7RN9aC6mz/ZNoX286i
 bP5kJl8RykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZhIYB7DP5tXMSpcWZteyIS5
 mvw3u7j996aXJ7IW3Pm9xrJFYNN+KWZGhvkxqvMag7/rX5O643cwPeXw4T8uVQd27nffZnxk6oG
 mmkwA
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

This board is entirely supported by the generic arch code and DTS. The
board code used to handle turning on the vbus regulator, however this is
now handled via DT.

With this, the board specific defconfig is also no longer needed, so
drop it as well.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 board/qualcomm/qcs404-evb/Makefile     |  6 ----
 board/qualcomm/qcs404-evb/qcs404-evb.c | 49 -----------------------------
 configs/qcs404evb_defconfig            | 56 ----------------------------------
 3 files changed, 111 deletions(-)

diff --git a/board/qualcomm/qcs404-evb/Makefile b/board/qualcomm/qcs404-evb/Makefile
deleted file mode 100644
index 4665827e0859..000000000000
--- a/board/qualcomm/qcs404-evb/Makefile
+++ /dev/null
@@ -1,6 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-#
-# (C) Copyright 2022 Sumit Garg <sumit.garg@linaro.org>
-#
-
-obj-y += qcs404-evb.o
diff --git a/board/qualcomm/qcs404-evb/qcs404-evb.c b/board/qualcomm/qcs404-evb/qcs404-evb.c
deleted file mode 100644
index 1a4b1f97a3ae..000000000000
--- a/board/qualcomm/qcs404-evb/qcs404-evb.c
+++ /dev/null
@@ -1,49 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Board init file for QCS404-EVB
- *
- * (C) Copyright 2022 Sumit Garg <sumit.garg@linaro.org>
- */
-
-#include <common.h>
-#include <cpu_func.h>
-#include <dm.h>
-#include <env.h>
-#include <init.h>
-#include <asm/cache.h>
-#include <asm/gpio.h>
-#include <asm/global_data.h>
-#include <fdt_support.h>
-
-DECLARE_GLOBAL_DATA_PTR;
-
-void qcom_board_init(void)
-{
-	struct udevice *pmic_gpio;
-	struct gpio_desc usb_vbus_boost_pin;
-	int ret, node;
-
-	ret = uclass_get_device_by_name(UCLASS_GPIO,
-					"pms405_gpios@c000",
-					&pmic_gpio);
-	if (ret < 0) {
-		printf("Failed to find pms405_gpios@c000 node.\n");
-		return;
-	}
-
-	node = fdt_subnode_offset(gd->fdt_blob, dev_of_offset(pmic_gpio),
-				  "usb_vbus_boost_pin");
-	if (node < 0) {
-		printf("Failed to find usb_hub_reset_pm dt node.\n");
-		return;
-	}
-	ret = gpio_request_by_name_nodev(offset_to_ofnode(node), "gpios", 0,
-					 &usb_vbus_boost_pin, 0);
-	if (ret < 0) {
-		printf("Failed to request usb_hub_reset_pm gpio.\n");
-		return;
-	}
-
-	dm_gpio_set_dir_flags(&usb_vbus_boost_pin,
-			      GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
-}
diff --git a/configs/qcs404evb_defconfig b/configs/qcs404evb_defconfig
deleted file mode 100644
index d85d193895b0..000000000000
--- a/configs/qcs404evb_defconfig
+++ /dev/null
@@ -1,56 +0,0 @@
-CONFIG_ARM=y
-CONFIG_SYS_BOARD="qcs404-evb"
-CONFIG_SKIP_LOWLEVEL_INIT=y
-CONFIG_COUNTER_FREQUENCY=19000000
-CONFIG_POSITION_INDEPENDENT=y
-CONFIG_ARCH_SNAPDRAGON=y
-CONFIG_DEFAULT_DEVICE_TREE="qcs404-evb"
-CONFIG_IDENT_STRING="\nQualcomm QCS404-EVB"
-CONFIG_SYS_LOAD_ADDR=0x80000000
-CONFIG_FIT=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_BOOTDELAY=5
-CONFIG_USE_BOOTARGS=y
-CONFIG_BOOTARGS="earlycon ignore_loglevel root= clk_ignore_unused"
-CONFIG_SAVE_PREV_BL_FDT_ADDR=y
-CONFIG_SAVE_PREV_BL_INITRAMFS_START_ADDR=y
-CONFIG_SYS_CBSIZE=512
-# CONFIG_DISPLAY_CPUINFO is not set
-CONFIG_HUSH_PARSER=y
-CONFIG_SYS_MAXARGS=64
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_GPT=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_PART=y
-CONFIG_CMD_USB=y
-CONFIG_CMD_EXT2=y
-CONFIG_CMD_EXT4=y
-CONFIG_CMD_EXT4_WRITE=y
-CONFIG_CMD_FAT=y
-CONFIG_CMD_FS_GENERIC=y
-# CONFIG_NET is not set
-CONFIG_CLK=y
-CONFIG_CLK_QCOM_QCS404=y
-CONFIG_MSM_GPIO=y
-CONFIG_QCOM_PMIC_GPIO=y
-CONFIG_MISC=y
-CONFIG_MMC_HS400_SUPPORT=y
-CONFIG_MMC_SDHCI=y
-CONFIG_MMC_SDHCI_ADMA=y
-CONFIG_MMC_SDHCI_MSM=y
-CONFIG_PHY=y
-CONFIG_PHY_QCOM_USB_HS_28NM=y
-CONFIG_PHY_QCOM_USB_SS=y
-CONFIG_PINCTRL=y
-CONFIG_PINCTRL_QCOM_QCS404=y
-CONFIG_DM_PMIC=y
-CONFIG_PMIC_QCOM=y
-CONFIG_MSM_SERIAL=y
-CONFIG_SPMI_MSM=y
-CONFIG_USB=y
-CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_DWC3=y
-CONFIG_USB_DWC3=y
-CONFIG_USB_DWC3_GENERIC=y
-CONFIG_USB_STORAGE=y
-CONFIG_LMB_MAX_REGIONS=64

-- 
2.43.0

