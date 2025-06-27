Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D766CC7EE31
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 05:10:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55CAE81F66;
	Fri, 27 Jun 2025 07:10:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pjkvqo1T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9224282C65; Fri, 27 Jun 2025 04:57:43 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B863880C83
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 04:57:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=liujianfeng1994@gmail.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-313dc7be67aso237139a91.0
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 19:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750993057; x=1751597857; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WaU2+E3Ehj4EoEMY2fKPuORjP91K8fEsBkcBkMJNtMs=;
 b=Pjkvqo1TolvXY+1rUz8PfcsBBVyvgVta7Ym15+u7xgPxv0U6Htf4ey1HSL9WS/Of96
 wlr6ENvBZyp0WIH64pWzsyyL2/IS67LSxdVUYRPQZSRcbE1TQtoX9DfJUEHSrq+yti1n
 5Kq1Mn1Zf7jHBDIobGOjIqPEwuUhXG9jsJG89VnYxAc6D1PRZpEt793MbeG+jnfLxTEd
 cSVPdUj6MOOYn35F1rn8HeFgMKJiSvGhqQyxTPARP4SX8UrvkDOUFpEoOFmOVDOLYxQN
 AWl2PwbDq3ouMfdmQ+zfqGZWp++uTYwZMnyJoE1hjPypfhzfW2OEdvXeZ0ONXNMGUMd9
 QD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750993057; x=1751597857;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WaU2+E3Ehj4EoEMY2fKPuORjP91K8fEsBkcBkMJNtMs=;
 b=h5gQDhlb+b3kS1McXlj+hRCrmlcm7KJTowNg95ZQWghxWslO2whEaQ+kvZa+gdaGmU
 dQd3aFTNHasn3+EiMaRF2ZlLCOHqNX8saR1TAuY3913HNCltlCaLCdqyobp7bQDPslaS
 gVrBsaQC2P9FtFM2ldcQE8NUoLBXedtOrBCc39at7C9QmbLEpGdF4TsDW4o+2PamRPwI
 CZphV9QX6wplC5XSvIm1Ei+WJ0Dk5W7Vbo3FD+CqnRg5Yr8zqd/JyR3jt7iiBmpyBxj3
 N2D9XgJ0eC0NGsb/ZfKSBf+7i2tAZf+WG5R4Ih12C5Oz6EoJh71n4BEMnMMctQnJLnDP
 pDsg==
X-Gm-Message-State: AOJu0YxkNhVSe4uZycJSfo5mBKdRa1CaE0LjUY8bu+j37n7WfUPIev0u
 GI/b1X0xaqHsE7KI83/W0Y5dz5S3jT5gRzfDEy13TJ6RAvrUUs513MER4AhHcdlLmmYDhA==
X-Gm-Gg: ASbGncvy/pnyP6rg/upq8HUvTcKSG1ZC4mNcA22OZFjilFYvHsIApCrjbCpIM9Sa6UP
 19cq0bKqA6qJGpzJAp0xFnYxft4bCmTBIvi78gKq+PZ+3oYfQWBFFYIgD+hb+cataHDOKiKqt7i
 ZGqVPMCfZfYp/ocn0g5/71QfdgTXi8xYJ0Ev0iZ1GTGdG/vGsZ9pxPVdtWjGwG1dFxqcNgsg69u
 UqX5XLMBbfHnoaRbOPNmGWzdQrUmPz0i71mlm2WLHaL4xfMVUTiQrcIA7EZxZ74Pq5ilBmzYXgh
 68oo2tf6ZQcYYp/uE2nKRidJCsFBL8i+5WmS4m9PDWIr+8r0R61xEJO7ncz+ZzlwKTHd
X-Google-Smtp-Source: AGHT+IH2FkawPcuMniUBrPALCgbRsV0KUnjVQs0z4p0TZ4812A9df8lbLcsfsofX5hLFhifxHdkCkw==
X-Received: by 2002:a17:90b:1811:b0:312:e9d:3fff with SMTP id
 98e67ed59e1d1-318c8ff20e7mr839493a91.1.1750993056873; 
 Thu, 26 Jun 2025 19:57:36 -0700 (PDT)
Received: from rock-5b.. ([111.172.109.70]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-315f5382ef7sm5777360a91.4.2025.06.26.19.57.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 19:57:36 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: u-boot@lists.denx.de
Cc: Jianfeng Liu <liujianfeng1994@gmail.com>,
 Greg Malysa <malysagreg@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Robert Marko <robert.marko@sartura.hr>,
 Sebastian Kropatsch <seb-dev@mail.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>, Xuhui Lin <xuhui.lin@rock-chips.com>
Subject: [PATCH] board: rockchip: add ArmSoM Sige5 RK3576 board
Date: Fri, 27 Jun 2025 10:53:48 +0800
Message-ID: <20250627025721.962397-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Jun 2025 07:10:49 +0200
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

ArmSoM Sige5 is a Rockchip RK3576 based SBC (Single Board Computer) by
ArmSoM.

This is the second board of ArmSoM supported by u-boot, so I change the
dir in MAINTAINERS to board/armsom/.

Booting from emmc is tested.

Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
---

 MAINTAINERS                                  |  2 +-
 arch/arm/dts/rk3576-armsom-sige5-u-boot.dtsi |  6 +++
 arch/arm/mach-rockchip/rk3576/Kconfig        |  7 ++++
 board/armsom/sige5-rk3576/Kconfig            | 12 ++++++
 board/armsom/sige5-rk3576/MAINTAINERS        |  7 ++++
 configs/sige5-rk3576_defconfig               | 44 ++++++++++++++++++++
 doc/board/rockchip/rockchip.rst              |  1 +
 include/configs/sige5-rk3576.h               | 15 +++++++
 8 files changed, 93 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/rk3576-armsom-sige5-u-boot.dtsi
 create mode 100644 board/armsom/sige5-rk3576/Kconfig
 create mode 100644 board/armsom/sige5-rk3576/MAINTAINERS
 create mode 100644 configs/sige5-rk3576_defconfig
 create mode 100644 include/configs/sige5-rk3576.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 92119667618..15e471060b7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -555,7 +555,7 @@ F:	arch/arm/include/asm/arch-rockchip/
 F:	arch/arm/mach-rockchip/
 F:	board/amarula/vyasa-rk3288/
 F:	board/anbernic/rgxx3_rk3566/
-F:	board/armsom/sige7-rk3588/
+F:	board/armsom/
 F:	board/chipspark/popmetal_rk3288
 F:	board/engicam/px30_core/
 F:	board/firefly/
diff --git a/arch/arm/dts/rk3576-armsom-sige5-u-boot.dtsi b/arch/arm/dts/rk3576-armsom-sige5-u-boot.dtsi
new file mode 100644
index 00000000000..a662a4d46b8
--- /dev/null
+++ b/arch/arm/dts/rk3576-armsom-sige5-u-boot.dtsi
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2025 ArmSoM Technology Co., Ltd.
+ */
+
+#include "rk3576-u-boot.dtsi"
diff --git a/arch/arm/mach-rockchip/rk3576/Kconfig b/arch/arm/mach-rockchip/rk3576/Kconfig
index f347caf8904..755bdaa3e9c 100644
--- a/arch/arm/mach-rockchip/rk3576/Kconfig
+++ b/arch/arm/mach-rockchip/rk3576/Kconfig
@@ -1,5 +1,11 @@
 if ROCKCHIP_RK3576
 
+config TARGET_SIGE5_RK3576
+	bool "ArmSoM Sige5 RK3576 board"
+	help
+	  ArmSoM Sige5 is a Rockchip RK3576 based SBC (Single Board Computer)
+	  by ArmSoM.
+
 config TARGET_ROC_PC_RK3576
 	bool "Firefly ROC-RK3576-PC"
 	help
@@ -15,6 +21,7 @@ config ROCKCHIP_STIMER_BASE
 config SYS_SOC
 	default "rk3576"
 
+source board/armsom/sige5-rk3576/Kconfig
 source board/firefly/roc-pc-rk3576/Kconfig
 
 config SYS_CONFIG_NAME
diff --git a/board/armsom/sige5-rk3576/Kconfig b/board/armsom/sige5-rk3576/Kconfig
new file mode 100644
index 00000000000..45ff164313b
--- /dev/null
+++ b/board/armsom/sige5-rk3576/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_SIGE5_RK3576
+
+config SYS_BOARD
+	default "sige5-rk3576"
+
+config SYS_VENDOR
+	default "armsom"
+
+config SYS_CONFIG_NAME
+	default "sige5-rk3576"
+
+endif
diff --git a/board/armsom/sige5-rk3576/MAINTAINERS b/board/armsom/sige5-rk3576/MAINTAINERS
new file mode 100644
index 00000000000..26a780b06f8
--- /dev/null
+++ b/board/armsom/sige5-rk3576/MAINTAINERS
@@ -0,0 +1,7 @@
+SIGE5-RK3576
+M:	Jianfeng Liu <liujianfeng1994@gmail.com>
+S:	Maintained
+F:	board/armsom/sige5-rk3576
+F:	include/configs/sige5-rk3576.h
+F:	configs/sige5-rk3576_defconfig
+F:	arch/arm/dts/rk3576-armsom-sige5*
diff --git a/configs/sige5-rk3576_defconfig b/configs/sige5-rk3576_defconfig
new file mode 100644
index 00000000000..0b668ea0c15
--- /dev/null
+++ b/configs/sige5-rk3576_defconfig
@@ -0,0 +1,44 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3576-armsom-sige5"
+CONFIG_ROCKCHIP_RK3576=y
+CONFIG_TARGET_SIGE5_RK3576=y
+CONFIG_SYS_LOAD_ADDR=0x40c00800
+CONFIG_DEBUG_UART_BASE=0x2AD40000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_DEBUG_UART=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3576-armsom-sige5.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_SPL_MAX_SIZE=0x40000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_REGULATOR=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_BUTTON=y
+CONFIG_BUTTON_ADC=y
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_PHY_MOTORCOMM=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_ROCKCHIP=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_RK8XX=y
+CONFIG_REGULATOR_RK8XX=y
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_SYSRESET_PSCI=y
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index b88299cbba2..7cab2c3ae0f 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -134,6 +134,7 @@ List of mainline supported Rockchip boards:
      - Radxa ROCK 3B (rock-3b-rk3568)
 
 * rk3576
+     - ArmSoM SIGE5 (sige5-rk3576)
      - Firefly ROC-RK3576-PC (roc-pc-rk3576)
 
 * rk3588
diff --git a/include/configs/sige5-rk3576.h b/include/configs/sige5-rk3576.h
new file mode 100644
index 00000000000..1011f78c7a4
--- /dev/null
+++ b/include/configs/sige5-rk3576.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2025 ArmSoM Technology Co., Ltd.
+ */
+
+#ifndef __SIGE5_RK3576_H
+#define __SIGE5_RK3576_H
+
+#define ROCKCHIP_DEVICE_SETTINGS \
+		"stdout=serial,vidconsole\0" \
+		"stderr=serial,vidconsole\0"
+
+#include <configs/rk3576_common.h>
+
+#endif
-- 
2.43.0

