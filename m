Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A825C48BC4
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 21:00:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFB5C87ED1;
	Thu, 15 Feb 2024 21:54:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wELf+MK4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2744A87E49; Thu, 15 Feb 2024 21:54:03 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6089F87EEE
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 21:52:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-412191ed8aaso7915115e9.2
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 12:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708030368; x=1708635168; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Cqmchvij0p6qu+1Wz6VleKp5qI+9PFi5nvdqyZq7cW8=;
 b=wELf+MK4NQr1Y+dCBgYx9Ni4j8XyocGoR8bPH4JZzrB3SNvq4M9SXpZ05+X2MLg9FO
 1+DXot8PNhfieymOLsB8KVj+RO0j2u4pACN4Z74bTjvxKkfLZ7Aw2M9T9s4LzWJrtX4H
 ambMQPv3tfbN+vDIkKJIFrohMgS/pfzCA3AUawUaqlYclgXQla6wvXPzb9z3crgmuD3M
 Fh1nKk8evZmvVMcIWzi43lEEf8p8rx1YEIV9L00uD45zqtf1fzg/4oDoN39eCxpQiOO+
 bfk0uYPvsQcxHWCHpKVQmyJwtuy6YPEEskYRaYtBVGDKzGRCBlfY7dUlcM9TnQtUdrlf
 zL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708030368; x=1708635168;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cqmchvij0p6qu+1Wz6VleKp5qI+9PFi5nvdqyZq7cW8=;
 b=ZWTmHoQWzgTChTLt2Y2Ct+4OKJkQnQ6uvUFnrrAw3VfjWIC5U9rX21C7ZAHi5ng04Z
 8G7+g/rrULKWr2ycNoi6LfKmqNvTKiuFyAEnPCoPB7UmFTi7TZHaqBtvgVbUqu6bOL3Q
 SUrPIXeytoYY/65TkKO+KhsUiEuh+OOeWW4dr9/f972Sq2bqbTof0v2DncdyciWGPxGc
 Ta7RItQFmUcU4U2KXq8av4NZPoauc6JNY6B2vBZLjC6DXuaDSDjQs34YBUonI2oDXT9V
 hcCegZAGJfy6JS/GRidCBUtshEfB5AdGD+QdeCNGeOV+kyy6ytDhc/cpX1ao0+Wsojo0
 lC6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcQ+Tx19SYUSDvu5qbGDHPh0vTwyUsFOX/k9G2uLECGft98cPGKxg4NZBw5/2R/dfJHb3hPpve+peZjFASuamMB1RPiA==
X-Gm-Message-State: AOJu0YwqrEL8H0Trg14mZTmeZi6jXILW+6/PnGtzhTYnmmF1Ki9baWwj
 RoZcCSrWiamCb9zKDxehX0CO4SCqzB/78o3N867IlHhOA6eVwMMfcHXVcCdBAZOJSXrvjMVSHgB
 2
X-Google-Smtp-Source: AGHT+IHZMN7RI2oSuvyv0Vj8IU6o25R/gUzNp6ZeIy8vPZcvi3M1wTX2ox5lH3nahavMV/9i48Z7zQ==
X-Received: by 2002:adf:fd4f:0:b0:33d:1af:3d59 with SMTP id
 h15-20020adffd4f000000b0033d01af3d59mr1575926wrs.31.1708030368705; 
 Thu, 15 Feb 2024 12:52:48 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 e4-20020adfe384000000b0033cfa00e497sm194025wrm.64.2024.02.15.12.52.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 12:52:48 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 15 Feb 2024 20:52:42 +0000
Subject: [PATCH v4 24/39] board: qcs404-evb: drop board code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-b4-qcom-common-target-v4-24-ed06355c634a@linaro.org>
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
In-Reply-To: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
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
 bh=tpvunIwKpVhdVKTmkE6zuO+LGpGU+6d9dM9U5C6RKYQ=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRzlW0tKcqSD5c8y5988BH/76DWO76Mja/Wr283+fZx3
 /TL189md5SyMAhyMMiKKbKIn1hm2bT2sr3G9gUXYOawMoEMYeDiFICJzN/C8E+tRnm2y6meKNXU
 t8zVHj4pHCumJ/9eapL/cZJ1bOvHn2cY/ldty26LW1/WrHEr6qn7HqPvninRCtzP7NndViReZEj
 3cwEA
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
2.43.1

