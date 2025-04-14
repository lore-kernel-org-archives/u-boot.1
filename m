Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A01C369B2
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 20:21:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79D4282898;
	Mon, 14 Apr 2025 22:21:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="f6FLDHb/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BEDC82153; Mon, 14 Apr 2025 22:21:22 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08A35828B3
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 22:21:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=m6EUgDmo7axoxBJJx6WlPBsjCE2y8J3rY9g/gJzKxcs=; b=f6FLDHb/2wFb4YTQ7XNZwLdbpY
 MJWQPG7gxBJLwVnnUJodQZgYRzumX9YpOrHnMfTtHSa8JdGgJ+2SpI7LoZWbmii9BXcaBChmX0wnw
 r1hIPaebhLYgPXidKqjh8urflTsc7/4byZEffL6fLPC0dRwU0xeRujhmgBFxqtiO6y1BbVCajixBU
 5nqktryXYEXLfQ4CVsIZI4twSIc6eqYcZvqXKZ61UrstyaBgcIp1W3nNZ2Zj7PAlKdOqRgSy4Kdtw
 Y3WbyHlEgBYDHaIgX0QlejkxgDBet7YGUh9j000CLMx8LJKWMa6mLu+EJ83pBwJi07E03dgewgOqr
 LURTP7bw==;
Received: from i53875b95.versanet.de ([83.135.91.149]
 helo=localhost.localdomain)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1u4Q01-0001rf-6M; Mon, 14 Apr 2025 22:01:45 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: sjg@chromium.org,
	philipp.tomsich@vrull.eu,
	kever.yang@rock-chips.com
Cc: heiko@sntech.de, lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jonas@kwiboo.se, quentin.schulz@cherry.de, detlev.casanova@collabora.com,
 u-boot@lists.denx.de, sebastian.reichel@collabora.com
Subject: [PATCH v2 16/16] rockchip: rk3576: Add support for ROC-RK3576-PC board
Date: Mon, 14 Apr 2025 22:01:11 +0200
Message-ID: <20250414200111.1357867-17-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250414200111.1357867-1-heiko@sntech.de>
References: <20250414200111.1357867-1-heiko@sntech.de>
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

The ROC-RK3576-PC is a SBC made by Firefly, designed around the RK3576
SoC. This adds the needed board infrastructure and config for it.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/dts/rk3576-roc-pc-u-boot.dtsi  | 11 ++++++
 arch/arm/mach-rockchip/rk3576/Kconfig   |  8 +++++
 board/firefly/roc-pc-rk3576/Kconfig     | 12 +++++++
 board/firefly/roc-pc-rk3576/MAINTAINERS |  7 ++++
 configs/roc-pc-rk3576_defconfig         | 45 +++++++++++++++++++++++++
 doc/board/rockchip/rockchip.rst         |  3 ++
 include/configs/roc-pc-rk3576.h         | 15 +++++++++
 7 files changed, 101 insertions(+)
 create mode 100644 arch/arm/dts/rk3576-roc-pc-u-boot.dtsi
 create mode 100644 board/firefly/roc-pc-rk3576/Kconfig
 create mode 100644 board/firefly/roc-pc-rk3576/MAINTAINERS
 create mode 100644 configs/roc-pc-rk3576_defconfig
 create mode 100644 include/configs/roc-pc-rk3576.h

diff --git a/arch/arm/dts/rk3576-roc-pc-u-boot.dtsi b/arch/arm/dts/rk3576-roc-pc-u-boot.dtsi
new file mode 100644
index 00000000000..97240345ed4
--- /dev/null
+++ b/arch/arm/dts/rk3576-roc-pc-u-boot.dtsi
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2023 Joshua Riek <jjriek@verizon.net>
+ *
+ */
+
+#include "rk3576-u-boot.dtsi"
+
+&sdhci {
+	cap-mmc-highspeed;
+};
diff --git a/arch/arm/mach-rockchip/rk3576/Kconfig b/arch/arm/mach-rockchip/rk3576/Kconfig
index a94dc6706f0..83d41f7a100 100644
--- a/arch/arm/mach-rockchip/rk3576/Kconfig
+++ b/arch/arm/mach-rockchip/rk3576/Kconfig
@@ -1,5 +1,11 @@
 if ROCKCHIP_RK3576
 
+config TARGET_ROC_PC_RK3576
+	bool "Firefly ROC-RK3576-PC"
+	help
+	  ROC-RK3576-PC is a single board computer from Firefly
+	  using the Rockchip RK3576.
+
 config ROCKCHIP_BOOT_MODE_REG
 	default 0x26024040
 
@@ -12,4 +18,6 @@ config SYS_SOC
 config SYS_CONFIG_NAME
 	default "rk3576_common"
 
+source board/firefly/roc-pc-rk3576/Kconfig
+
 endif
diff --git a/board/firefly/roc-pc-rk3576/Kconfig b/board/firefly/roc-pc-rk3576/Kconfig
new file mode 100644
index 00000000000..2fc0f913c37
--- /dev/null
+++ b/board/firefly/roc-pc-rk3576/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_ROC_PC_RK3576
+
+config SYS_BOARD
+	default "roc-pc-rk3576"
+
+config SYS_VENDOR
+	default "firefly"
+
+config SYS_CONFIG_NAME
+	default "roc-pc-rk3576"
+
+endif
diff --git a/board/firefly/roc-pc-rk3576/MAINTAINERS b/board/firefly/roc-pc-rk3576/MAINTAINERS
new file mode 100644
index 00000000000..aa8897c16fc
--- /dev/null
+++ b/board/firefly/roc-pc-rk3576/MAINTAINERS
@@ -0,0 +1,7 @@
+ROC-RK3576-PC
+M:	Heiko Stuebner <heiko@sntech.de>
+S:	Maintained
+F:	board/firefly/roc-pc-rk3576
+F:	include/configs/roc-pc-rk3576.h
+F:	configs/roc-pc-rk3576_defconfig
+F:	arch/arm/dts/rk3576-roc-pc*
diff --git a/configs/roc-pc-rk3576_defconfig b/configs/roc-pc-rk3576_defconfig
new file mode 100644
index 00000000000..af2c1026636
--- /dev/null
+++ b/configs/roc-pc-rk3576_defconfig
@@ -0,0 +1,45 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3576-roc-pc"
+CONFIG_ROCKCHIP_RK3576=y
+CONFIG_TARGET_ROC_PC_RK3576=y
+CONFIG_SYS_LOAD_ADDR=0x40c00800
+CONFIG_DEBUG_UART_BASE=0x2AD40000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_DEBUG_UART=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3576-roc-pc.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_SPL_MAX_SIZE=0x40000
+CONFIG_SPL_PAD_TO=0x7f8000
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
index 1058a1ce990..8d7c2591e25 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -130,6 +130,9 @@ List of mainline supported Rockchip boards:
      - Radxa ROCK 3A (rock-3a-rk3568)
      - Radxa ROCK 3B (rock-3b-rk3568)
 
+* rk3576
+     - Firefly ROC-RK3576-PC (roc-pc-rk3576)
+
 * rk3588
      - ArmSoM Sige7 (sige7-rk3588)
      - Rockchip EVB (evb-rk3588)
diff --git a/include/configs/roc-pc-rk3576.h b/include/configs/roc-pc-rk3576.h
new file mode 100644
index 00000000000..77c95f0c560
--- /dev/null
+++ b/include/configs/roc-pc-rk3576.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2023 Rockchip Electronics Co., Ltd.
+ */
+
+#ifndef __ROC_PC_RK3576_H
+#define __ROC_PC_RK3576_H
+
+#define ROCKCHIP_DEVICE_SETTINGS \
+		"stdout=serial,vidconsole\0" \
+		"stderr=serial,vidconsole\0"
+
+#include <configs/rk3576_common.h>
+
+#endif
-- 
2.47.2

