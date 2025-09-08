Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA905CAC586
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 11:34:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49A3B82AE9;
	Mon,  8 Sep 2025 13:34:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Au7YNJyR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76CD882DA1; Mon,  8 Sep 2025 13:34:35 +0200 (CEST)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39F50809A5
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 13:34:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=cnsztl@gmail.com
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-b4d5886f825so3732392a12.0
 for <u-boot@lists.denx.de>; Mon, 08 Sep 2025 04:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757331272; x=1757936072; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nCrPWOh4Wgn11tNEeKOlvr/Pj98Mut7l+0c/7utaQ9c=;
 b=Au7YNJyRW3OeWf2RuGKewl3Jt6Zck79ok2OQxdu2ECM4Jqvg8wA4eNi0EaZRudel0H
 oCbAYZRfvPxNHoxkmgw4MERCDBJ/CXmlydFro9rr/iAnsbkUqf2O6byjhJF8zSjTqEUx
 p7sVIyBtzRUX6Dcuq9F/2pT8g63HzdhmpsCmXFgADjQkJ2v7+5H2XwUnjdra1iE3egdI
 sI5vl0EWrEmPCOVN0uzdMaQ246r0UbamMM8X2LpnU4OMNhfI8+EOk38z8LeEhCNZQRVL
 ZYDztBwLFSoJcHjcy0IXg73Gf/HL3mms2X4Q1ThPksPdZiNG4bLRMCnxqJzwmkIUa6nS
 5btQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757331272; x=1757936072;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nCrPWOh4Wgn11tNEeKOlvr/Pj98Mut7l+0c/7utaQ9c=;
 b=lZsPQRdSZQyi0RwPu2sCS82H+J5m1JHwqa/N9cDD+8UuMUcTw6GP063JdI/ShROK2a
 GwfHhN5qTS7bYDACM1enlv2vlcLs2wFZdx/Cr3C4roA2uW90k+wb6K271eVIgil78xaw
 iGgkdslTr/mfhEnikZEEeUajXkJ7QBKeEuKn07mh2RCKvY7s6rLcqdRU2nSbWqk0wAUY
 NNyzRrIlHAJhQgHRj+CJSX66Gx1W68W0eVITzWcq4THaMv9qHyxBofV+4poMvsyMN8f0
 te3JRjhip/ovSR9PlcvI2TpQLB07DFLbS0zmbBF0V33HNnPTMtszMgLVHWfoOAU/jETe
 AKGw==
X-Gm-Message-State: AOJu0YyOkyGs3FUdET+6Q0IcZd0BgN2j2SDg6Cgd4bVl5a7MtKuGDwrG
 Ly7Sdq9NZtKsZtnwUJZIv3Tx3GChdzWmMDN3pXn3R6aHYzWOFaGtiJUNanjAPA==
X-Gm-Gg: ASbGncvgMk2HHubewfShq4Mvd9xeniED99zUy5VwAtG6OMt/dKbP1v1mC87OVc0ObwP
 4GODphvizwG0gbDleqqLw6ehUNwzYfwkZHl/oyafMSFh6r6R4pob3chdurx+j5ugumw6AkfT6lg
 y93AN8oP5rdRnatIepOmoYIZiygTIMjTIsiAXyEYNZcy/eAIas0qZaNYvwCOG7W9WsUcUhgSdEX
 +SsYZCPeycvF5PuRsjOWD7KC/LhXbVFLJAY0qU3NPhNNur24afPyC5D4rW4/rHLTDrNLoFhfs+0
 OeEMpBWc1hopwAG8CN7zxxIhME738B1fVz2VT5b4kBxy4bgRreyBNnhPuASuWUdgVfg/aQO2zat
 yzvNSHsryBF0UyjCd6ETSbgBpd/tu+ZS96hvJTAKq
X-Google-Smtp-Source: AGHT+IGMs5CtfZPBYmNdY/2gqAiCDHRQEqScXdWeDrIhA2W6tu1g5l2FJgwe1nliJzyB+Qg2HxizTQ==
X-Received: by 2002:a17:903:234a:b0:24b:1d30:5b09 with SMTP id
 d9443c01a7336-2516e4afbacmr89616915ad.13.1757331271068; 
 Mon, 08 Sep 2025 04:34:31 -0700 (PDT)
Received: from CNSZTL-DEB.lan ([27.9.156.128])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24b1d2d5a66sm167622125ad.125.2025.09.08.04.34.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 04:34:30 -0700 (PDT)
From: Tianling Shen <cnsztl@gmail.com>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tianling Shen <cnsztl@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH] board: rockchip: add Lunzn FastRhino R66S
Date: Mon,  8 Sep 2025 19:32:18 +0800
Message-ID: <20250908113218.4102764-1-cnsztl@gmail.com>
X-Mailer: git-send-email 2.51.0
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

Lunzn Fastrhino R66S is a high-performance mini router.

Specification:
- Rockchip RK3568
- 1/2GB LPDDR4 RAM
- SD card slot
- 2x USB 3.0 Port
- 2x 2500 Base-T (PCIe, r8125b)
- 12v DC Jack

Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 .../arm/dts/rk3568-fastrhino-r66s-u-boot.dtsi |  3 +
 board/rockchip/evb_rk3568/MAINTAINERS         |  7 ++
 configs/fastrhino-r66s-rk3568_defconfig       | 64 +++++++++++++++++++
 doc/board/rockchip/rockchip.rst               |  1 +
 4 files changed, 75 insertions(+)
 create mode 100644 arch/arm/dts/rk3568-fastrhino-r66s-u-boot.dtsi
 create mode 100644 configs/fastrhino-r66s-rk3568_defconfig

diff --git a/arch/arm/dts/rk3568-fastrhino-r66s-u-boot.dtsi b/arch/arm/dts/rk3568-fastrhino-r66s-u-boot.dtsi
new file mode 100644
index 000000000000..a2b60da65865
--- /dev/null
+++ b/arch/arm/dts/rk3568-fastrhino-r66s-u-boot.dtsi
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+
+#include "rk356x-u-boot.dtsi"
diff --git a/board/rockchip/evb_rk3568/MAINTAINERS b/board/rockchip/evb_rk3568/MAINTAINERS
index 6cf568ad1507..030cdbe6f3db 100644
--- a/board/rockchip/evb_rk3568/MAINTAINERS
+++ b/board/rockchip/evb_rk3568/MAINTAINERS
@@ -14,6 +14,13 @@ F:	configs/evb-rk3568_defconfig
 F:	arch/arm/dts/rk3568-evb-u-boot.dtsi
 F:	arch/arm/dts/rk3568-evb.dts
 
+FASTRHINO-R66S-RK3568
+M:	Tianling Shen <cnsztl@gmail.com>
+R:	Jonas Karlman <jonas@kwiboo.se>
+S:	Maintained
+F:	configs/fastrhino-r66s-rk3568_defconfig
+F:	arch/arm/dts/rk3568-fastrhino-r66s-u-boot.dtsi
+
 GENERIC-RK3568
 M:	Jonas Karlman <jonas@kwiboo.se>
 S:	Maintained
diff --git a/configs/fastrhino-r66s-rk3568_defconfig b/configs/fastrhino-r66s-rk3568_defconfig
new file mode 100644
index 000000000000..70b20720ecab
--- /dev/null
+++ b/configs/fastrhino-r66s-rk3568_defconfig
@@ -0,0 +1,64 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_SYS_HAS_NONCACHED_MEMORY=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3568-fastrhino-r66s"
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
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-fastrhino-r66s.dtb"
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
+CONFIG_CMD_PMIC=y
+CONFIG_CMD_REGULATOR=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SPL_REGMAP=y
+CONFIG_SPL_SYSCON=y
+CONFIG_SPL_CLK=y
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_MISC=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_RTL8169=y
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
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index de3aa79cb5c9..21cc6922e177 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -128,6 +128,7 @@ List of mainline supported Rockchip boards:
      - FriendlyElec NanoPi R5S (nanopi-r5s-rk3568)
      - Generic RK3566/RK3568 (generic-rk3568)
      - Hardkernel ODROID-M1 (odroid-m1-rk3568)
+     - Lunzn FastRhino R66S (fastrhino-r66s-rk3568)
      - QNAP TS-433 (qnap-ts433-rk3568)
      - Radxa E25 Carrier Board (radxa-e25-rk3568)
      - Radxa ROCK 3A (rock-3a-rk3568)
-- 
2.51.0

