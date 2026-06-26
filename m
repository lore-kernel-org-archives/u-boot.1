Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7AF0CDE00B
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 01:53:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED4878495B;
	Fri, 26 Jun 2026 03:53:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ioSLNHtO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 023818496E; Fri, 26 Jun 2026 03:53:52 +0200 (CEST)
Received: from mail-dy1-x1331.google.com (mail-dy1-x1331.google.com
 [IPv6:2607:f8b0:4864:20::1331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B79A847C8
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 03:53:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-dy1-x1331.google.com with SMTP id
 5a478bee46e88-30b9e755555so1267655eec.1
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 18:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782438828; x=1783043628; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=D+h72+2Xo4BLKiO+vvXQCgPhdcsB+Dqc0DpT6Vg7cvs=;
 b=ioSLNHtOueXjnqVeqREjBB2wUum3/E5N2gg3yXplnDr4KEQEg8y2Go8IYeG9TOAAeD
 6W8fgtoXBvHUphHxRqQxqf4PwQUXKGAt49DScK/ITgdVzIq6Qaqq78WayP+14vp0hGkR
 GPjIbbBYBHqgSzHIkdC3o9xMPlOXlrLcFCLVCLFSdlohHO1TD1jRPnl+VcQNThQvM3oF
 WS7BJtv3DQR0pWsfI+ZWrDGj3zs6702bVIybNmxXFC7dHgRGU3rQn2s+XOOyTZnfNaIu
 AVwSlMkPkrdPB7R4G+i0y3doh2YK+svytmjp6I5WrPasCrJ7dBaaozg19BmdF/F9fHBi
 fJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782438828; x=1783043628;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D+h72+2Xo4BLKiO+vvXQCgPhdcsB+Dqc0DpT6Vg7cvs=;
 b=tD01UL6wJK2OWm0b1yen1ME70xLFw0n4G2i7tL4J4JUfFniTI+ziWrXcuipo+tvBBb
 PYwzLK08gBscsRHEs5PUPl9Rbj4cG/INPoewtd/XONRESFt2xCYZ7DEkvQK87h1KZPy2
 6VwGWqHaoMQcbpPQ61UyvCoDeivc9boxGPEHkb2tSOAcuBUGp0Ce39JY6FsTGWvCTGz0
 GKT/6DIoSkKCABmCOMDIZ8mm6Iu26PAEeqn6hXtJxJJhCgfWvrP1Rx59DfdStaiU643W
 AzmlAJHmpEyHv+bmwUJhCaSyEA0vxLNjstmDbGPbYvpKHp/ZL2RLfTP6LGZTyWXepzY9
 K/Zg==
X-Gm-Message-State: AOJu0YwKBaF+vBQsJaTHsz7vQzg8ztXU08EXw9ZnmosDX9bd4C5L4b66
 4dww77Ys+jkG1T22MhxYd5DopVGng5bBRii+Mo0Z2dTw5/6+kJINcDxY
X-Gm-Gg: AfdE7clPLRS/GQhz8tXCEETUgT+ErnYgbnGaXMHNn40IlbIPu0DNbPPPbuBxKrCRmJI
 iZF8gmQ0RC0mlaXLsCm+V782ReobKEMjxh81YSOGGuBnRkDnImyhHn2wPzoGKamNtsqNcPIbJty
 NA5wtc7EQy3U2xXm8sfz30V4CLOB64Ok6L9lGqEXy5HwLDllR/7L8AyhhrYDG11sUPWAVTAHUNm
 kj8S++5MunfNVKrz5B3WtB6JCiZTq24THeoLc2NR/AN3JgQWrjWlFM1AeLqrzw03toXRrL8PkXk
 ZLCxRSWYJfBxwbRFdPQ/IGBcs4aGIGEKO7EYQXuGLvDX+mDtSOzHN67z5J24Ujhm7rkPN0BS1uD
 MknH5JKwowAfSeEFUBMiQrV8LG3zTIq/UKhABkPs6jG7tg+2OelD7CR0vnDC3Jrt7FRI/B0VoI+
 Klki0Ny70IR57V6gq6DgwfoSE4HGwA7IWp9fIcKl/ny4IsX8YY9Cs4lKQKb2I=
X-Received: by 2002:a05:7300:547:b0:30c:38ed:46b5 with SMTP id
 5a478bee46e88-30c84c0506amr5702230eec.12.1782438827684; 
 Thu, 25 Jun 2026 18:53:47 -0700 (PDT)
Received: from fabio-Precision-3551..
 ([2804:1b3:a803:bcaa:389b:2f9f:e80b:4f62])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c9e220bsm12952673eec.21.2026.06.25.18.53.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 18:53:47 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: kever.yang@rock-chips.com
Cc: u-boot@lists.denx.de,
	Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] rockchip: rk3588s: Add support for ROC-PC-RK3588S
Date: Thu, 25 Jun 2026 22:53:40 -0300
Message-ID: <20260626015340.2375163-1-festevam@gmail.com>
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

The ROC-PC-RK3588S board is an SBC made by Firefly, based on the RK3588S
SoC.

Add support for it.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/dts/rk3588s-roc-pc-u-boot.dtsi  |  7 ++
 arch/arm/mach-rockchip/rk3588/Kconfig    |  7 ++
 board/firefly/roc-pc-rk3588s/Kconfig     | 12 ++++
 board/firefly/roc-pc-rk3588s/MAINTAINERS |  7 ++
 configs/roc-pc-rk3588s_defconfig         | 91 ++++++++++++++++++++++++
 doc/board/rockchip/rockchip.rst          |  1 +
 include/configs/roc-pc-rk3588s.h         |  8 +++
 7 files changed, 133 insertions(+)
 create mode 100644 arch/arm/dts/rk3588s-roc-pc-u-boot.dtsi
 create mode 100644 board/firefly/roc-pc-rk3588s/Kconfig
 create mode 100644 board/firefly/roc-pc-rk3588s/MAINTAINERS
 create mode 100644 configs/roc-pc-rk3588s_defconfig
 create mode 100644 include/configs/roc-pc-rk3588s.h

diff --git a/arch/arm/dts/rk3588s-roc-pc-u-boot.dtsi b/arch/arm/dts/rk3588s-roc-pc-u-boot.dtsi
new file mode 100644
index 000000000000..e2ed7ce6232b
--- /dev/null
+++ b/arch/arm/dts/rk3588s-roc-pc-u-boot.dtsi
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk3588s-u-boot.dtsi"
+
+&usbdp_phy0 {
+	status = "okay";
+};
diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
index 675f13ab66d7..841ae490e85a 100644
--- a/arch/arm/mach-rockchip/rk3588/Kconfig
+++ b/arch/arm/mach-rockchip/rk3588/Kconfig
@@ -208,6 +208,12 @@ config TARGET_RK3588_NEU6
 	  IO board and Neu6a needs to mount on top of this IO board in order to
 	  create complete Edgeble Neural Compute Module 6B(Neu6B) IO platform.
 
+config TARGET_ROC_PC_RK3588S
+	bool "Firefly ROC PC RK3588S"
+	help
+	  ROC-PC-RK3588S is a single board computer from Firefly
+	  using the Rockchip RK3588S.
+
 config TARGET_ROCK5A_RK3588
 	bool "Radxa ROCK5A RK3588 board"
 	help
@@ -421,6 +427,7 @@ config SYS_SOC
 source "board/armsom/sige7-rk3588/Kconfig"
 source "board/coolpi/genbook_cm5_rk3588/Kconfig"
 source "board/edgeble/neural-compute-module-6/Kconfig"
+source "board/firefly/roc-pc-rk3588s/Kconfig"
 source "board/friendlyelec/cm3588-nas-rk3588/Kconfig"
 source "board/friendlyelec/nanopc-t6-rk3588/Kconfig"
 source "board/friendlyelec/nanopi-r6c-rk3588s/Kconfig"
diff --git a/board/firefly/roc-pc-rk3588s/Kconfig b/board/firefly/roc-pc-rk3588s/Kconfig
new file mode 100644
index 000000000000..bded7a2fcba1
--- /dev/null
+++ b/board/firefly/roc-pc-rk3588s/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_ROC_PC_RK3588S
+
+config SYS_BOARD
+	default "roc-pc-rk3588s"
+
+config SYS_VENDOR
+	default "firefly"
+
+config SYS_CONFIG_NAME
+	default "roc-pc-rk3588s"
+
+endif
diff --git a/board/firefly/roc-pc-rk3588s/MAINTAINERS b/board/firefly/roc-pc-rk3588s/MAINTAINERS
new file mode 100644
index 000000000000..9a2bb4e69e89
--- /dev/null
+++ b/board/firefly/roc-pc-rk3588s/MAINTAINERS
@@ -0,0 +1,7 @@
+ROC-PC-RK3588S
+M:	Fabio Estevam <festevam@nabladev.com>
+S:	Maintained
+F:	arch/arm/dts/rk3588s-roc-pc-u-boot.dtsi
+F:	board/firefly/roc-pc-rk3588s/
+F:	configs/roc-pc-rk3588s_defconfig
+F:	include/configs/roc-pc-rk3588s.h
diff --git a/configs/roc-pc-rk3588s_defconfig b/configs/roc-pc-rk3588s_defconfig
new file mode 100644
index 000000000000..b625c93ad2d3
--- /dev/null
+++ b/configs/roc-pc-rk3588s_defconfig
@@ -0,0 +1,91 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_SYS_HAS_NONCACHED_MEMORY=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_ENV_OFFSET=0x400000
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588s-roc-pc"
+CONFIG_ROCKCHIP_RK3588=y
+CONFIG_SPL_SERIAL=y
+CONFIG_TARGET_ROC_PC_RK3588S=y
+CONFIG_SYS_LOAD_ADDR=0xc00800
+CONFIG_DEBUG_UART_BASE=0xFEB50000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_ENV_OFFSET_REDUND=0x500000
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-roc-pc.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_SPL_MAX_SIZE=0x40000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_ATF=y
+CONFIG_CMD_ADC=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_REGULATOR=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_REDUNDANT=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SPL_SYSCON=y
+CONFIG_AHCI=y
+CONFIG_SCSI_AHCI=y
+CONFIG_AHCI_PCI=y
+CONFIG_SPL_CLK=y
+# CONFIG_USB_FUNCTION_FASTBOOT is not set
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_MISC=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_ROCKCHIP=y
+CONFIG_RTL8169=y
+CONFIG_PHY_REALTEK=y
+CONFIG_NVME_PCI=y
+CONFIG_PCIE_DW_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
+CONFIG_PHY_ROCKCHIP_USBDP=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_RK8XX=y
+CONFIG_REGULATOR_RK8XX=y
+CONFIG_SPL_RAM=y
+CONFIG_SCSI=y
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_ROCKCHIP_SPI=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_PSCI=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_GENERIC=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index a31ee7100b9f..ae18b08031d2 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -153,6 +153,7 @@ List of mainline supported Rockchip boards:
      - Rockchip EVB (evb-rk3588)
      - Edgeble Neural Compute Module 6A SoM - Neu6a (neu6a-io-rk3588)
      - Edgeble Neural Compute Module 6B SoM - Neu6b (neu6b-io-rk3588)
+     - Firefly ROC-PC-RK3588S (roc-pc-rk3588s)
      - FriendlyElec CM3588 NAS (cm3588-nas-rk3588)
      - FriendlyElec NanoPC-T6 (nanopc-t6-rk3588)
      - FriendlyElec NanoPi R6C (nanopi-r6c-rk3588s)
diff --git a/include/configs/roc-pc-rk3588s.h b/include/configs/roc-pc-rk3588s.h
new file mode 100644
index 000000000000..c9316687c38f
--- /dev/null
+++ b/include/configs/roc-pc-rk3588s.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __ROC_PC_RK3588S_H
+#define __ROC_PC_RK3588S_H
+
+#include <configs/rk3588_common.h>
+
+#endif /* __ROC_PC_RK3588S_H */
-- 
2.43.0

