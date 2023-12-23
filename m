Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A09C3DA6E
	for <u-boot@archiver.kernel.org>; Sat, 23 Dec 2023 03:59:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED3288746A;
	Sat, 23 Dec 2023 04:59:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MBgP2W3Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CB1287652; Sat, 23 Dec 2023 04:59:56 +0100 (CET)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D7CC87250
 for <u-boot@lists.denx.de>; Sat, 23 Dec 2023 04:59:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=cnsztl@gmail.com
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6d99ff0b4a5so180734b3a.0
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 19:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703303992; x=1703908792; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tfosOhHEXZtMaQ232kUV+59dIQwrhZCF5ZFw3dSbzOA=;
 b=MBgP2W3Zj9/IgakUki8ifbGOU+Ylc9ss7z4IQ/iv0RKHicX207N9DZNnN7npjMB27R
 i3rvBVbFUn5vXSg0qHo+36a3CsiJCKGHWtX/qrBbsJYGZIxwN06MNwmcted7Z7gDglz5
 CW9EYT+xq21/IxGvgzHiO51OvPKb8gKhJbDz3L03g0nacrsiuRdhUiTFoLyuTfPYtnFm
 Mdj5sP0OCeIh2gQpZ98XBVS4+jHidPuAQ6K2i6P0htqAlVye69XaqvRKxcj8uubod6TI
 v0kDtD/eN+fGszwyr2Og2YcE15woQJzFJe9TfXycjz8tHlx5av3loPtZAMJbDmDZHwuX
 OesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703303992; x=1703908792;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tfosOhHEXZtMaQ232kUV+59dIQwrhZCF5ZFw3dSbzOA=;
 b=hq8jcmq7gw56BvdTw1ALEM/R5SZ16Gkp8XiBsGrbNxDHzlHhbepA8/Pdia4AaHYoSQ
 DlDNsWrs8VB0Tl4sxzuVM+vnoGvJ2co6Xe8z68lBDYg+YB/CMgE5wmeJg3hFwp6S9zEI
 45bZL3PL615VZIGFXoW7besE3yVIAsd06oCv64pbeF59zwDb4zsauWt01FhDaqlkpTa1
 sX1F/Hyejpvj5bAanZoTF3u/GhYCLaFvctnU7tOYPmzpM8Q7/f59/yIPCi5E5ERkImrA
 YafS1LgMxpScP1jyukQKCB6tZuBCsVTk6eevDqudrySUj1m4xLmdmHbRcwivzBH7LXP7
 s9gg==
X-Gm-Message-State: AOJu0YxGRbhhuOyXxMpoIzhx5Q68hjIHtxd/3yWuGcG1df413qa2/3lQ
 eAZHigUrSZUG33/ppS+gLMk=
X-Google-Smtp-Source: AGHT+IHvZO8dUjmmFbtfZIezkcSt/qCQNnUQnV+bVMR3439fZOHHVOCh2BPvLKy/VWgUFME6r+sLLA==
X-Received: by 2002:aa7:8a0a:0:b0:6d9:6acc:172d with SMTP id
 m10-20020aa78a0a000000b006d96acc172dmr2746536pfa.49.1703303990887; 
 Fri, 22 Dec 2023 19:59:50 -0800 (PST)
Received: from buildbot-shaka.infra.immortalwrt.org ([38.150.14.243])
 by smtp.gmail.com with ESMTPSA id
 a19-20020a62e213000000b006d7e67d2e74sm4203898pfi.32.2023.12.22.19.59.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 19:59:50 -0800 (PST)
From: Tianling Shen <cnsztl@gmail.com>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tianling Shen <cnsztl@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jagan Teki <jagan@edgeble.ai>
Cc: u-boot@lists.denx.de
Subject: [PATCH] board: rockchip: Add support for FriendlyARM NanoPi R2C Plus
Date: Sat, 23 Dec 2023 12:00:07 +0800
Message-ID: <20231223040007.72997-1-cnsztl@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The NanoPi R2C Plus is a small variant of NanoPi R2C with a on-board
eMMC flash (8G) included.

The device tree is taken from the kernel v6.5.

Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 arch/arm/dts/Makefile                         |   1 +
 .../dts/rk3328-nanopi-r2c-plus-u-boot.dtsi    |   9 ++
 arch/arm/dts/rk3328-nanopi-r2c-plus.dts       |  33 +++++
 board/rockchip/evb_rk3328/MAINTAINERS         |   6 +
 configs/nanopi-r2c-plus-rk3328_defconfig      | 114 ++++++++++++++++++
 5 files changed, 163 insertions(+)
 create mode 100644 arch/arm/dts/rk3328-nanopi-r2c-plus-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3328-nanopi-r2c-plus.dts
 create mode 100644 configs/nanopi-r2c-plus-rk3328_defconfig

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 9d28a485bec..6909f95e084 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -126,6 +126,7 @@ dtb-$(CONFIG_ROCKCHIP_RK3308) += \
 dtb-$(CONFIG_ROCKCHIP_RK3328) += \
 	rk3328-evb.dtb \
 	rk3328-nanopi-r2c.dtb \
+	rk3328-nanopi-r2c-plus.dtb \
 	rk3328-nanopi-r2s.dtb \
 	rk3328-orangepi-r1-plus.dtb \
 	rk3328-orangepi-r1-plus-lts.dtb \
diff --git a/arch/arm/dts/rk3328-nanopi-r2c-plus-u-boot.dtsi b/arch/arm/dts/rk3328-nanopi-r2c-plus-u-boot.dtsi
new file mode 100644
index 00000000000..f8adb9e5e1f
--- /dev/null
+++ b/arch/arm/dts/rk3328-nanopi-r2c-plus-u-boot.dtsi
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include "rk3328-nanopi-r2c-u-boot.dtsi"
+
+/ {
+	chosen {
+		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &emmc;
+	};
+};
diff --git a/arch/arm/dts/rk3328-nanopi-r2c-plus.dts b/arch/arm/dts/rk3328-nanopi-r2c-plus.dts
new file mode 100644
index 00000000000..16a1958e457
--- /dev/null
+++ b/arch/arm/dts/rk3328-nanopi-r2c-plus.dts
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) 2021 FriendlyElec Computer Tech. Co., Ltd.
+ * (http://www.friendlyarm.com)
+ *
+ * Copyright (c) 2023 Tianling Shen <cnsztl@gmail.com>
+ */
+
+/dts-v1/;
+#include "rk3328-nanopi-r2c.dts"
+
+/ {
+	model = "FriendlyElec NanoPi R2C Plus";
+	compatible = "friendlyarm,nanopi-r2c-plus", "rockchip,rk3328";
+
+	aliases {
+		mmc1 = &emmc;
+	};
+};
+
+&emmc {
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	max-frequency = <150000000>;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_bus8>;
+	vmmc-supply = <&vcc_io_33>;
+	vqmmc-supply = <&vcc18_emmc>;
+	status = "okay";
+};
diff --git a/board/rockchip/evb_rk3328/MAINTAINERS b/board/rockchip/evb_rk3328/MAINTAINERS
index 8a19eb373d0..5fc114a63f6 100644
--- a/board/rockchip/evb_rk3328/MAINTAINERS
+++ b/board/rockchip/evb_rk3328/MAINTAINERS
@@ -11,6 +11,12 @@ S:      Maintained
 F:      configs/nanopi-r2c-rk3328_defconfig
 F:      arch/arm/dts/rk3328-nanopi-r2c-u-boot.dtsi
 
+NANOPI-R2C-PLUS-RK3328
+M:      Tianling Shen <cnsztl@gmail.com>
+S:      Maintained
+F:      configs/nanopi-r2c-plus-rk3328_defconfig
+F:      arch/arm/dts/rk3328-nanopi-r2c-plus-u-boot.dtsi
+
 NANOPI-R2S-RK3328
 M:      David Bauer <mail@david-bauer.net>
 S:      Maintained
diff --git a/configs/nanopi-r2c-plus-rk3328_defconfig b/configs/nanopi-r2c-plus-rk3328_defconfig
new file mode 100644
index 00000000000..320ed8b434a
--- /dev/null
+++ b/configs/nanopi-r2c-plus-rk3328_defconfig
@@ -0,0 +1,114 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_TEXT_BASE=0x00200000
+CONFIG_SPL_GPIO=y
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
+CONFIG_SF_DEFAULT_SPEED=20000000
+CONFIG_ENV_OFFSET=0x3F8000
+CONFIG_DEFAULT_DEVICE_TREE="rk3328-nanopi-r2c-plus"
+CONFIG_DM_RESET=y
+CONFIG_ROCKCHIP_RK3328=y
+CONFIG_TPL_ROCKCHIP_COMMON_BOARD=y
+CONFIG_TPL_LIBCOMMON_SUPPORT=y
+CONFIG_TPL_LIBGENERIC_SUPPORT=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_STACK_R_ADDR=0x600000
+CONFIG_SPL_STACK=0x400000
+CONFIG_TPL_SYS_MALLOC_F_LEN=0x800
+CONFIG_DEBUG_UART_BASE=0xFF130000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_SYS_LOAD_ADDR=0x800800
+CONFIG_DEBUG_UART=y
+# CONFIG_ANDROID_BOOT_IMAGE is not set
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-nanopi-r2c-plus.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_MISC_INIT_R=y
+CONFIG_SPL_MAX_SIZE=0x40000
+CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x2000000
+CONFIG_SPL_BSS_MAX_SIZE=0x2000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_STACK_R=y
+CONFIG_SPL_I2C=y
+CONFIG_SPL_POWER=y
+CONFIG_SPL_ATF=y
+CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
+CONFIG_TPL_SYS_MALLOC_SIMPLE=y
+CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_USB=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_TIME=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_TPL_OF_CONTROL=y
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_TPL_OF_PLATDATA=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_TPL_DM=y
+CONFIG_REGMAP=y
+CONFIG_SPL_REGMAP=y
+CONFIG_TPL_REGMAP=y
+CONFIG_SYSCON=y
+CONFIG_SPL_SYSCON=y
+CONFIG_TPL_SYSCON=y
+CONFIG_CLK=y
+CONFIG_SPL_CLK=y
+CONFIG_FASTBOOT_BUF_ADDR=0x800800
+CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_MISC=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_ETH_DESIGNWARE=y
+CONFIG_GMAC_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_RK8XX=y
+CONFIG_SPL_PMIC_RK8XX=y
+CONFIG_SPL_DM_REGULATOR=y
+CONFIG_REGULATOR_PWM=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
+CONFIG_REGULATOR_RK8XX=y
+CONFIG_PWM_ROCKCHIP=y
+CONFIG_RAM=y
+CONFIG_SPL_RAM=y
+CONFIG_TPL_RAM=y
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_SYSINFO=y
+CONFIG_SYSRESET=y
+# CONFIG_TPL_SYSRESET is not set
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_GENERIC=y
+CONFIG_USB_DWC2=y
+CONFIG_USB_DWC3=y
+# CONFIG_USB_DWC3_GADGET is not set
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_DWC2_OTG=y
+CONFIG_SPL_TINY_MEMSET=y
+CONFIG_TPL_TINY_MEMSET=y
+CONFIG_ERRNO_STR=y
-- 
2.43.0

