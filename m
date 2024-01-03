Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8743C3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 13:07:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25266807EC;
	Wed,  3 Jan 2024 14:07:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cdGdbEC0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F252786F39; Wed,  3 Jan 2024 14:07:31 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF609807E2
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 14:07:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-7b7f2c72846so515379639f.2
 for <u-boot@lists.denx.de>; Wed, 03 Jan 2024 05:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704287247; x=1704892047; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6l2MJjGaGtsiyYkbcBGwmQWO9qaFabV1WMuqad5D+1g=;
 b=cdGdbEC00Yt5F/OmriViNhhHBJIBzpCP9qTFrqo4jTc2yoUxHHrcyzWBKuubleOSFj
 85JoE/YT/x2tgPJhlOJKw5qMsF9zJT2y/0NgONQC5LVXg8RRy6eKqwfkvX3nDT2W0nki
 hzjXVQ9YmHBmoW/h8rhzEnxUm66vRXVP4HF7uSFP/GGU6MjsO26zJEa330KaK89CHl3J
 R2VRw9PuaONtIz3UOXVVci2qbYaG5HGz9l9m3dn5NF4gsbuUnSI86J92DLrD1AumUcE/
 587QfrtPQiOaRLem6bEc8GFUvNhVAqBqRyYy+bzC/qD54oNLFfc3CB/Fvs6qTg5Y07AD
 Yl/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704287247; x=1704892047;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6l2MJjGaGtsiyYkbcBGwmQWO9qaFabV1WMuqad5D+1g=;
 b=JdIGltD64MLkNLFvg3n+lF5AVFT2nTBLEpirhDzgZMOUnZsHLt0ymeqkY3f1+zmRa2
 /WQw8S5e/yEqEnpYGXbHQyA7OwDe5cl3zq57oGl4r2yUYzuJnBVsGknQMNJw35wIB2PK
 hbQMLfbq1/umSKIS3kINkeW+K1CWRo5PdNfSCbV/6BLkOvhfOEUW1ixqb2+65vzSPybh
 UiSrCxzRxbRzxGlIPynd13Iix+X0qUvATTYj9lHLtialN11IZCSNQ4l32v3gVn8menya
 1hIyuFgfbsnkIRiQcMxfgCRnBlHJ0ZkBXcIBWkvPkMepiWUlX3XwOfJFBtcajqHSrPOl
 i5sQ==
X-Gm-Message-State: AOJu0YzbYNwE3/HAJNF4NpRLxJ4aGEa4RHQQ4njrV5WLYkHuEH34tfWJ
 wGQLFuAJ6JJcsjZpikPSNhQKfven7wo7CA==
X-Google-Smtp-Source: AGHT+IEjKlLQfBLgcp3Nf3qBnrSFMyyOxVSONUL9Ex8ClzP/PC37O8BD47ElEVTJUm8UwXRhVWtE1w==
X-Received: by 2002:a5d:930c:0:b0:7bb:b6d3:8f with SMTP id
 l12-20020a5d930c000000b007bbb6d3008fmr3281747ion.11.1704287247397; 
 Wed, 03 Jan 2024 05:07:27 -0800 (PST)
Received: from sumit-X1.. ([223.178.208.87]) by smtp.gmail.com with ESMTPSA id
 q7-20020aa79827000000b006d9a94a03a8sm18649860pfl.77.2024.01.03.05.07.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 05:07:26 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org,
	caleb.connolly@linaro.org
Cc: neil.armstrong@linaro.org, rfried.dev@gmail.com, dsankouski@gmail.com,
 seanga2@gmail.com, marex@denx.de, laetitia.mariottini@se.com,
 pascal.eberhard@se.com, abdou.saker@se.com, jimmy.lalande@se.com,
 benjamin.missey@non.se.com, daniel.thompson@linaro.org,
 u-boot@lists.denx.de, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH] mach-snapdragon: Move APQ8016 SoC derived board code
Date: Wed,  3 Jan 2024 18:37:16 +0530
Message-Id: <20240103130716.4144892-1-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
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

In order to avoid duplication of APQ8016 derived boards specific code,
move common bits like USB pinctrl and fastboot to board-apq8016.c file.
This will allow future board support like SE HMIBSC board etc to reuse it.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

This patch is based on Caleb's Qcom common target branch [1]. As per
Caleb's comments here [2], there is no scope for people to add board
code for new board support. And even people can't reuse existing board
code like for db410c for further new board support but rather they have
to make db410c generic first.

I fear this would be couter productive and motivate OEM vendors (which
aren't Qcom reference designs) to keep their board support code
downstream. IMO, the approach should be to allow board code reuse which
this patch is all about. The next steps should be to make the underlying
board features to rather come from DT but that as you know requires
bindings to be accepted first.

Tom, Simon,

Is there any U-Boot policy in regards to board code going forward? Are
we moving in a direction to get rid of most board specific stubs from
generic U-Boot code?

[1] https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commits/b4%2Fqcom-common-target
[2] https://lore.kernel.org/all/824be245-60c9-4a1a-a386-be765e8eba91@linaro.org/

 arch/arm/mach-snapdragon/Kconfig              |  5 ++
 arch/arm/mach-snapdragon/Makefile             |  1 +
 arch/arm/mach-snapdragon/board-apq8016.c      | 64 +++++++++++++++++++
 .../dragonboard410c/dragonboard410c.c         | 62 ------------------
 configs/dragonboard410c_defconfig             |  1 +
 5 files changed, 71 insertions(+), 62 deletions(-)
 create mode 100644 arch/arm/mach-snapdragon/board-apq8016.c

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index 96e44e2c549..8069a89bf78 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -3,6 +3,11 @@ if ARCH_SNAPDRAGON
 config SYS_SOC
 	default "snapdragon"
 
+config SOC_APQ8016
+	bool "APQ8016"
+	help
+	  Select this if your SoC is an APQ8016
+
 config SYS_VENDOR
 	default "qualcomm"
 
diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
index 857171e593d..7d210e6d872 100644
--- a/arch/arm/mach-snapdragon/Makefile
+++ b/arch/arm/mach-snapdragon/Makefile
@@ -3,3 +3,4 @@
 # (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
 
 obj-y += board.o
+obj-$(CONFIG_SOC_APQ8016) += board-apq8016.o
diff --git a/arch/arm/mach-snapdragon/board-apq8016.c b/arch/arm/mach-snapdragon/board-apq8016.c
new file mode 100644
index 00000000000..bb9a3a9f0fb
--- /dev/null
+++ b/arch/arm/mach-snapdragon/board-apq8016.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Board init file for APQ8016 SoC derived boards
+ *
+ * (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
+ */
+
+#include <button.h>
+#include <dm.h>
+#include <dm/pinctrl.h>
+#include <env.h>
+#include <init.h>
+#include <usb.h>
+#include <fdt_support.h>
+
+int board_usb_init(int index, enum usb_init_type init)
+{
+	struct udevice *usb;
+	int ret = 0;
+
+	/* USB device */
+	ret = device_find_global_by_ofnode(ofnode_path("/soc/usb"), &usb);
+	if (ret) {
+		printf("Cannot find USB device\n");
+		return ret;
+	}
+
+	/* Select "default" or "device" pinctrl */
+	switch (init) {
+	case USB_INIT_HOST:
+		pinctrl_select_state(usb, "default");
+		break;
+	case USB_INIT_DEVICE:
+		pinctrl_select_state(usb, "device");
+		break;
+	default:
+		debug("Unknown usb_init_type %d\n", init);
+		break;
+	}
+
+	return 0;
+}
+
+/* Check for vol- button - if pressed - stop autoboot */
+int misc_init_r(void)
+{
+	struct udevice *btn;
+	int ret;
+	enum button_state_t state;
+
+	ret = button_get_by_label("vol_down", &btn);
+	if (ret < 0) {
+		printf("Couldn't find power button!\n");
+		return ret;
+	}
+
+	state = button_get_state(btn);
+	if (state == BUTTON_ON) {
+		env_set("preboot", "setenv preboot; fastboot 0");
+		printf("vol_down pressed - Starting fastboot.\n");
+	}
+
+	return 0;
+}
diff --git a/board/qualcomm/dragonboard410c/dragonboard410c.c b/board/qualcomm/dragonboard410c/dragonboard410c.c
index 2a502c7c284..f7c6a6cbc0a 100644
--- a/board/qualcomm/dragonboard410c/dragonboard410c.c
+++ b/board/qualcomm/dragonboard410c/dragonboard410c.c
@@ -5,78 +5,16 @@
  * (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
  */
 
-#include <button.h>
 #include <common.h>
-#include <cpu_func.h>
 #include <dm.h>
-#include <dm/pinctrl.h>
 #include <env.h>
 #include <init.h>
 #include <net.h>
-#include <usb.h>
-#include <asm/cache.h>
-#include <asm/global_data.h>
-#include <asm/gpio.h>
 #include <fdt_support.h>
 #include <linux/delay.h>
 
 #include "misc.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
-#define USB_HUB_RESET_GPIO 2
-#define USB_SW_SELECT_GPIO 3
-
-int board_usb_init(int index, enum usb_init_type init)
-{
-	struct udevice *usb;
-	int ret = 0;
-
-	/* USB device */
-	ret = device_find_global_by_ofnode(ofnode_path("/soc/usb"), &usb);
-	if (ret) {
-		printf("Cannot find USB device\n");
-		return ret;
-	}
-
-	/* Select "default" or "device" pinctrl */
-	switch (init) {
-	case USB_INIT_HOST:
-		pinctrl_select_state(usb, "default");
-		break;
-	case USB_INIT_DEVICE:
-		pinctrl_select_state(usb, "device");
-		break;
-	default:
-		debug("Unknown usb_init_type %d\n", init);
-		break;
-	}
-
-	return 0;
-}
-
-/* Check for vol- button - if pressed - stop autoboot */
-int misc_init_r(void)
-{
-	struct udevice *btn;
-	int ret;
-	enum button_state_t state;
-
-	ret = button_get_by_label("vol_down", &btn);
-	if (ret < 0) {
-		printf("Couldn't find power button!\n");
-		return ret;
-	}
-
-	state = button_get_state(btn);
-	if (state == BUTTON_ON) {
-		env_set("preboot", "setenv preboot; fastboot 0");
-		printf("vol_down pressed - Starting fastboot.\n");
-	}
-
-	return 0;
-}
-
 int qcom_late_init(void)
 {
 	char serial[16];
diff --git a/configs/dragonboard410c_defconfig b/configs/dragonboard410c_defconfig
index 453cb9d04c7..23024066f82 100644
--- a/configs/dragonboard410c_defconfig
+++ b/configs/dragonboard410c_defconfig
@@ -3,6 +3,7 @@ CONFIG_SYS_BOARD="dragonboard410c"
 CONFIG_COUNTER_FREQUENCY=19000000
 CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK=y
 CONFIG_ARCH_SNAPDRAGON=y
+CONFIG_SOC_APQ8016=y
 CONFIG_TEXT_BASE=0x8f600000
 CONFIG_SYS_MALLOC_LEN=0x802000
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-- 
2.34.1

