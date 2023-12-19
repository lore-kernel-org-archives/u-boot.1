Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBD8C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 16:09:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BFEC86DDC;
	Tue, 19 Dec 2023 17:05:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BUR37aGV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC289878CF; Tue, 19 Dec 2023 17:05:24 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CF5E8789B
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 17:04:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40c2db2ee28so59496055e9.2
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 08:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703001895; x=1703606695; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/2GCeSRI2kgHi1OozoahJPzRQ1Y+EnYIHXRIt5CWvoc=;
 b=BUR37aGVeve3Mg4taIgfX8L6WWSiDkEqqBmZtMRD5MXu3F89+o8Qk2baFvE2LJ+7za
 cmzf87j4ri3w1ALVzN4Q9SGCB6YdGH29+Fo4jdOcd4TtdRPmPZSm9iZTFIaH18GQGSaB
 dRczP0Bf+UUVA83DrX7ZTu+45w74c83yHetUzOiafL/KKLBKnaOWYkmBSryEEd80G+wz
 3ux8FLBPLwKeSnrCcxXOHVmsn4l4+6Jcq0BDcWhnqnptpaQ5229KBz9lGt7jc+abnvMg
 ncYftpOvnwA2jwm6Ym1+Fie9gxRWtvBrwhCH9+GN/3yxrgjucHl458TO2TYg2GyXwdj+
 77Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703001895; x=1703606695;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/2GCeSRI2kgHi1OozoahJPzRQ1Y+EnYIHXRIt5CWvoc=;
 b=lB0qEdQluae+pLe31aidthRP8TQTzWzUrjWC/Fjc6R2fwBKNABgwTJ2qw+z3Fsfk0E
 SaxcWl0o1ZrRerezYFhELRcLT+qkS2U64Dv12wbGTHzmfS3ng4VJ6ulFgDDxKvfJxV7x
 2P6quwpNTKl80jNpeIVIzfZGG5NtaUHGKneVXOPNDd87vvJJtJrvO3oiYbEmpmIgOO2z
 m0HZ+YkFlSaQlDcvCcrR+YP8PbSzHmkzCDgfiB0BXiERGO0n1ZZLzEJExESBtDNDO6JW
 4iCAuNkvlm2XrSfkeSQamIIgnq09Xpd5hGRuQiPTctQ46Pv7CJbg76lRY40V07+cZsQP
 i+MQ==
X-Gm-Message-State: AOJu0YxutkOY1uA+LeUO5fuBQZ+05/mVDnGvmzITUxbRqvPvYDMtVhW9
 Ry3ZB80sSGd7/hFpU3121YdVmg==
X-Google-Smtp-Source: AGHT+IFPrH/l7pLQY6ibWj7xhPOdtURLSEpJmrbxwHwOD9T6yWXzz08zXRxvmk+/0BFgbJk81FX5ZQ==
X-Received: by 2002:a7b:ce8a:0:b0:40c:61f1:7fcd with SMTP id
 q10-20020a7bce8a000000b0040c61f17fcdmr5403242wmj.155.1703001895069; 
 Tue, 19 Dec 2023 08:04:55 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 je17-20020a05600c1f9100b0040d1450ca7esm3429723wmb.7.2023.12.19.08.04.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 08:04:54 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 19 Dec 2023 16:04:32 +0000
Subject: [PATCH v2 31/32] board: qcs404-evb: drop board code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231219-b4-qcom-common-target-v2-31-b6dd9704219e@linaro.org>
References: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
In-Reply-To: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4012;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=UJfD+5x+yBJg+hh3tB2PF2W2kpeHRlNvP890GhlqUrA=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtTG/SyFnz8wP2ffa74ybfb1B39asvo6fhScKPN9yL+kd
 /2ES1tndZSyMAhyMMiKKbKIn1hm2bT2sr3G9gUXYOawMoEMYeDiFICJHGhm+M1+tKf0ZW/K4mvM
 v69/rJb5pXNky423n7INrr51mWayW76Z4X9pI6vYeilOvx8T/l29zvfwxY2Hf5tfSS9RWXpnt2i
 q1uM5AA==
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
index 7daaa449ffbd..000000000000
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
-# CONFIG_DISPLAY_CPUINFO is not set
-CONFIG_HUSH_PARSER=y
-CONFIG_SYS_MAXARGS=64
-CONFIG_SYS_CBSIZE=512
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
2.42.1

