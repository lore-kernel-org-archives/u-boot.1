Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B1CC5478C
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 17:31:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F91587FC4;
	Mon, 26 Feb 2024 18:27:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HwDxc4zy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C21CE87FBF; Mon, 26 Feb 2024 18:27:00 +0100 (CET)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C98C887FC0
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 18:26:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2d23114b19dso48287491fa.3
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 09:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708968405; x=1709573205; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HV6FQ8s+xx+gCeZyecez+2ZPdAKnY099pPvfaSWMmv8=;
 b=HwDxc4zyMjZCpRviq5famcOZatY9JG84A//styjAhbNahWU4ksvXQmZCyIH6TYtvWN
 y0FvrkgdShwC5IifoO5Q7PIosUQR1hoF5tJw6tMuZbLZTOMN0w5d8Vd3p38qhDURvJzw
 N3n61yWlkCKsAgC0ZTOw4+9Z0ItU95GrcelJ4z2qzKMEfxkZt6aKdc532jqOhjwUO7a4
 Cs2/iT5r9jdCMqwmsz0dXR5C5LNPWVwqr1pEjNxmH+84IRfScGm6i7Bk6KBclCSszvL7
 Nf4/+IrLd4JODkmyHUKZFrCgB7R42Be/iGIiuP6C2TtPYbOHVUg5TScLiWmM1iQn57rl
 1zCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708968405; x=1709573205;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HV6FQ8s+xx+gCeZyecez+2ZPdAKnY099pPvfaSWMmv8=;
 b=C2IzNoUHiycykugdBlhQ3xREt53G4UGKxTLmmHE4CVnk3G6A2L4jbQf9TKupso3VbE
 6wjPXZM1xe3//C885X9ZfVLJw1NzY3X9Q7agLvbIvBYycfYz/zZrf/+V/KOPIA3lLYVN
 aMvtITkwWHl7mDOoxmGd6ByB24KbjdvKGxW/rXtAA9oaUO8yhmeHuH+0qBQz+fdI7Gq1
 LEAQKMKtznrta7L8q5ut9FRjnRKQy08D20JKn6O6nmwdr3pc+FI5NgvDqvSnmF+hhWuv
 7TRVCFcP8airYCQrxlaOjTvP12MYqSKcXX4Q1Lcfnj7YHq3HrlWkecH13YWOwFP4QXnI
 BdQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmueMdcZIHlwAN5Ra9ga0pc7KIEJEFCpqJePU2PTennE6arWuy8DKhWsLqAodNCRaUaojuItWuhqEmCymWyfYv1XRW5Q==
X-Gm-Message-State: AOJu0YwQSSNosxSaT7tPZWgOu6gOV0TuLgFRON4FIf16hul1QUqIdv4H
 D8Hhg0AgElMwX4sf4oUszmn/80EzvF4kFaQ65AqxeieARLtjRAEC7GRulKvNuCU=
X-Google-Smtp-Source: AGHT+IE/DhLQHMeGMVZyzN0dIOThxsNek6PjB0kFndFrgRVJ8tdKlH1mW7JwVFCQ39k0XjQnreHuRA==
X-Received: by 2002:a2e:808a:0:b0:2d2:30b8:fbe2 with SMTP id
 i10-20020a2e808a000000b002d230b8fbe2mr4625038ljg.43.1708968405186; 
 Mon, 26 Feb 2024 09:26:45 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 bt1-20020a056000080100b0033d9c7eb63csm9142256wrb.84.2024.02.26.09.26.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 09:26:44 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 26 Feb 2024 17:26:28 +0000
Subject: [PATCH v5 24/39] board: qcs404-evb: drop board code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-b4-qcom-common-target-v5-24-10c8e078befb@linaro.org>
References: <20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org>
In-Reply-To: <20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4173;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=UTpVtL+2R1m666j5BXC22xsE2MJ0OzcbmOR4gd1i6n4=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQ7J3cnyEVeN4mUWXWub7nqyznNV6baXhIr6LL2nWk6r
 XtC7Ov/HaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAiFRcZ/qmG7G+wEOZey/Gg
 o1ZvflN60yptbrdt9wwjE3gvP2464MbIsN3m4LHr9zmN7CPyd8wV/yteGpI/o9Dqkppyk/qxS0J
 h+gA=
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
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Tested-by: Sumit Garg <sumit.garg@linaro.org> #qcs404
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

