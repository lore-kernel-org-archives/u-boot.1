Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2DB5CD4F21
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 12:37:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6BB483CD3;
	Tue, 12 May 2026 14:37:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZNqTXcxh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1568680398; Tue, 12 May 2026 11:15:51 +0200 (CEST)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95770803C6
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 11:15:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jjm2473@gmail.com
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-836ebdeb969so2440967b3a.3
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 02:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778577347; x=1779182147; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pKzfYovXRHByoBHARTf0s+c2UCWNgPXJqjqaNDTun8U=;
 b=ZNqTXcxhu6tDtEvlOD5kb1kAASH+ArxdMpN1vN8wYIWIHr1z28mSaeC+dR+ehzwcqZ
 mXlL32oRdDShwIkJToDlssI9Lh2+iin0QyC+foUpBJGeOdrWpBBVRpFWZlyUBoE3SAET
 qKgiYKd1N7XsNMfWZ30w+TLL4R9sfeqjjak2my7kKciT4YOzyqxmDQlmChYZCKtgbJ3f
 V6mNxQ/DzdDyGGb0mNesJ25FsgukTr7NXfX4MRTTACDASP8OBdpIK6xWBODQGbwWdgzw
 Ep1Lz/Nz0CalKPjRfO2WMrOzQ0mP8iw0f2a3HkGCYj9DG4/LmG+sLZGa9aB1BSnBVr7s
 Lw9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778577347; x=1779182147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pKzfYovXRHByoBHARTf0s+c2UCWNgPXJqjqaNDTun8U=;
 b=hIjHaBaxL+0/eDou8JraFevnxL+Vl8yCiu2+ZBXQlaBN2BppDjrG/LmbVS0yCt7C2Y
 ebkpfjxN7d/s8HRalEHs28V1dAfQaBsDG3JvIDHz4du6bqZzv4gWSpAVJ91WKdO/joRg
 pD3zUvzkK4AivmDf2y1DWHf1AhpJjJWFDIqSnC/divaRdyy/+qEqQY2+VinkCXMvVfY8
 JYKu5brIts3aff8QOMlSdCWRLEUpxuiHRUwCFOrklGmENMT6UUheHUIBfCnjAvUt5ntk
 IgZrnU2xpzl3/HBKJFFDO1+R/ReFyAYFtoztzuPNC1zoP/KpD7IciCDgiadwQxT7To+O
 52Iw==
X-Gm-Message-State: AOJu0YyJvnIx9sR+CJHQp5C/DBI13nwTDhGv82YenxZMqU2uWJvSd/zy
 Z6WcBBkow+3uCfEtRfKundkzKjLbCwSydpV3u2Rf81rBRZAEWpM+Zpyo
X-Gm-Gg: Acq92OEpqTsDQpo34zjHTU03rHiGs/MmMF9BFCq9m5pAcrbC0xZrJR3Ccv6t99KCe0z
 vBshnBEUCNSQSmWXmgB/4UYaTVO6btbsCQV2Hs+mNVXnhNU3MDbrWwwSyBcpteykZCIrwE0xt51
 p5v+QMwYgtyh7YzuLoreL64vqI0x2mSkCOg3Byr/sEfvpBC1Eu+ogf7OsoDA7gCFD4gOxqdFuQR
 P3h5wSGosl/7cTLRXwwY9JeaDyT+Clusznylw/wHjZkPcDSgZd5l+uUScLXVVYNve/xlejcOEER
 bmL8cYCYW+KtAigqGCLGJv4J6r7m/RHj4WLVn9fuVNejeJeJG6xwhaQPtxFnqSjEXnvYIr6/Gsq
 uKtc3p+n4dX74Bj+ua3m1xymd+6t45qXjEJWrvwV+dxiKqJ3+8xCon9DR3sI5zcjSN6mRT1FZQw
 k+7nk8llVvH792
X-Received: by 2002:a05:6a00:420e:b0:82f:6e7:152d with SMTP id
 d2e1a72fcca58-83a5bfc0bb8mr26434126b3a.21.1778577346954; 
 Tue, 12 May 2026 02:15:46 -0700 (PDT)
Received: from jjmdeMac-mini.lan ([2a09:bac5:3981:e6::17:35a])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83ce94a0e93sm12354494b3a.37.2026.05.12.02.15.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 May 2026 02:15:46 -0700 (PDT)
From: Liangbin Lian <jjm2473@gmail.com>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Liangbin Lian <jjm2473@gmail.com>,
 Tom Rini <trini@konsulko.com>, Joseph Chen <chenjh@rock-chips.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>,
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, FUKAUMI Naoki <naoki@radxa.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH 1/1] rockchip: rk3568: Add support for LinkEase EasePi R1
Date: Tue, 12 May 2026 17:15:32 +0800
Message-ID: <20260512091532.97256-2-jjm2473@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512091532.97256-1-jjm2473@gmail.com>
References: <20260512091532.97256-1-jjm2473@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 12 May 2026 14:37:47 +0200
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

LinkEase EasePi R1 [1] is a high-performance mini router.

Specification:
- Rockchip RK3568
- 2GB/4GB LPDDR4 RAM
- 16GB on-board eMMC
- 1x M.2 key for 2280 NVMe (PCIe 3.0)
- 1x USB 3.0 Type-A
- 1x USB 2.0 Type-C (for USB flashing)
- 2x 1000 Base-T (native, RTL8211F)
- 2x 2500 Base-T (PCIe, RTL8125B)
- 1x HDMI 2.0 Output
- 12v DC Jack
- 1x Power key connected to PMIC
- 2x LEDs (one static power supplied, one GPIO controlled)

[1] https://doc.linkease.com/zh/guide/easepi-r1/hardware.html

Signed-off-by: Liangbin Lian <jjm2473@gmail.com>
---
 arch/arm/dts/rk3568-easepi-r1-u-boot.dtsi |  7 ++
 board/rockchip/evb_rk3568/MAINTAINERS     |  6 ++
 configs/easepi-r1-rk3568_defconfig        | 82 +++++++++++++++++++++++
 doc/board/rockchip/rockchip.rst           |  1 +
 4 files changed, 96 insertions(+)
 create mode 100644 arch/arm/dts/rk3568-easepi-r1-u-boot.dtsi
 create mode 100644 configs/easepi-r1-rk3568_defconfig

diff --git a/arch/arm/dts/rk3568-easepi-r1-u-boot.dtsi b/arch/arm/dts/rk3568-easepi-r1-u-boot.dtsi
new file mode 100644
index 000000000..dc0e0eb7e
--- /dev/null
+++ b/arch/arm/dts/rk3568-easepi-r1-u-boot.dtsi
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * (C) Copyright 2021 Rockchip Electronics Co., Ltd
+ * (C) Copyright 2026 Liangbin Lian <jjm2473@gmail.com>
+ */
+
+#include "rk356x-u-boot.dtsi"
diff --git a/board/rockchip/evb_rk3568/MAINTAINERS b/board/rockchip/evb_rk3568/MAINTAINERS
index 030cdbe6f..4dfc3d870 100644
--- a/board/rockchip/evb_rk3568/MAINTAINERS
+++ b/board/rockchip/evb_rk3568/MAINTAINERS
@@ -5,6 +5,12 @@ F:	configs/bpi-r2-pro-rk3568_defconfig
 F:	arch/arm/dts/rk3568-bpi-r2-pro.dts
 F:	arch/arm/dts/rk3568-bpi-r2-pro-u-boot.dtsi
 
+EASEPI-R1
+M:	Liangbin Lian <jjm2473@gmail.com>
+S:	Maintained
+F:	configs/easepi-r1-rk3568_defconfig
+F:	arch/arm/dts/rk3568-easepi-r1-u-boot.dtsi
+
 EVB-RK3568
 M:	Joseph Chen <chenjh@rock-chips.com>
 S:	Maintained
diff --git a/configs/easepi-r1-rk3568_defconfig b/configs/easepi-r1-rk3568_defconfig
new file mode 100644
index 000000000..c76960379
--- /dev/null
+++ b/configs/easepi-r1-rk3568_defconfig
@@ -0,0 +1,82 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_SYS_HAS_NONCACHED_MEMORY=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3568-easepi-r1"
+CONFIG_ROCKCHIP_RK3568=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SYS_LOAD_ADDR=0xc00800
+CONFIG_DEBUG_UART_BASE=0xFE660000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-easepi-r1.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_SPL_MAX_SIZE=0x40000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_ATF=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_ROCKUSB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_CMD_PMIC=y
+CONFIG_CMD_REGULATOR=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SPL_SYSCON=y
+CONFIG_SPL_CLK=y
+# CONFIG_USB_FUNCTION_FASTBOOT is not set
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
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
+CONFIG_SPL_PINCTRL=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_RK8XX=y
+CONFIG_REGULATOR_RK8XX=y
+CONFIG_PWM_ROCKCHIP=y
+CONFIG_SPL_RAM=y
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_SYSRESET=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_GENERIC=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_SPL_USB_DWC3_GENERIC=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_USB_FUNCTION_ROCKUSB=y
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 141071f52..a2c7c80b8 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -133,6 +133,7 @@ List of mainline supported Rockchip boards:
      - FriendlyElec NanoPi R5S (nanopi-r5s-rk3568)
      - Generic RK3566/RK3568 (generic-rk3568)
      - Hardkernel ODROID-M1 (odroid-m1-rk3568)
+     - LinkEase EasePi R1 (easepi-r1-rk3568)
      - Lunzn FastRhino R66S (fastrhino-r66s-rk3568)
      - QNAP TS-433 (qnap-ts433-rk3568)
      - Radxa E25 Carrier Board (radxa-e25-rk3568)
-- 
2.51.0

