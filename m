Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3CD6CAC5B8
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 16:30:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60879838C1;
	Fri, 26 Sep 2025 18:30:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Lzghwurf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 391B2838C7; Fri, 26 Sep 2025 18:30:06 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18607838A5
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 18:30:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-46e2c3b6d4cso16499045e9.3
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 09:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758904203; x=1759509003; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=B2nzQEi1+usWvURgdGByZdCs0yKzpw/AppOW1ie74BI=;
 b=LzghwurfLZlsavI2IeZGjl6EpPHYVhm9mLEYT2CaGAvarXuLneUE/n+hwT9wxys6ci
 gy0hsjMnyaCGTB2hVEjs2lkoSAvWLPUs1k8AQzT8XZgD9WQ9/cCgfsseFqwyKmLDz29E
 twJn1RUOYgvPGpp8vOVSnx4RZmZ2l5nW0gAA+tVtkAT5SUxHfKFYA5tyYJ+a9Wlk0vOG
 +y8zWRbmvaSfXfkNxJGURfAxZV5MxNYOQ8VCYeE0N9iKSw8y+Sn/f81zGaMP7B5J/hM+
 SA2P0cVf+kslv+Re7C5l05fJJL7J92Q6G3CPQlSJRFeyX+Ipr0NR/FOcOA1c2BZU1ob6
 XdTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758904203; x=1759509003;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B2nzQEi1+usWvURgdGByZdCs0yKzpw/AppOW1ie74BI=;
 b=BWZeNCjpygahb0PblPzLma53iSd6U6Y4rwWT2wsRhlfJSUskYoou04G3iA/sPmOv1E
 pcwZhnpJO2OMpLO8I1ZMwN0FmRtHM3b/I+qFvq3Ft/fxr+iXFfIK4b92tYj5/BouV5ut
 enznlZxhN+pr4x59emR6pq1MQQ7NcLjnZrTJquylLALxmQHb+/pMHwyVltyCBQRRf0hF
 YFiGqIOvEObBc3sgcuMOspM0R1XwEKHVeXCKnsxo8XJozjQsI/T5GB3S1z1GNcnv8Obg
 z7NoPxXcrTU4+R8I/7Qjk6Lf+EP6KjPqh4oIkCXM7MoKxftR50UtIYcETY6tNZe2JESp
 35QA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIqtfZlzChUHn9Vh88DViTDmX4vv+NLu5QHv+HyD139HioCgy1Ej6urdpSz7KiBsni8NonQ94=@lists.denx.de
X-Gm-Message-State: AOJu0Yyk9Yn0uDMMvTBXj79QDWPxepGFgfDHiNHeBFJuDD5YwA9pLrW4
 pXRyt2/v5VSb/z0a1W7dGIya99LA2A/cHXcASneI3Uin5SXUQHNdOfIm
X-Gm-Gg: ASbGnctWXePyoXTYQN0A4fq1yjl1fziPEQkDnE3jwKdF888nnsC1jebWw3gp3jSE33U
 EwL5OYqPvWyLTCEqyWuH6YP5LHWLsLAAkEx6y/fTS6/RREp+YQVXUrUAQ/fUSARrTEo6sEENP66
 XiCbThwhFmVNMBhozO9rQWe+1tdic+tf++fUBbql860RzaARb+f5XlUb3ouHc0UN5L4Xp48Q14s
 d/cDpPbjy/uvNGSkYeZ5ErzKF10Kweyqb1YedCIWNwCcS4sKRG+v0OGIV8Ov81KXwE51bIyGO/d
 s8+RZ8+OQV4J3lYtZRt6vc48eCD0l99tACVyirFrkNbHA9DssMoq3vi1csdCLDwYi4Ys0QVKa8w
 GMun26ZRMI+pEdgv/14vgW4kkF42OvjJ0mAvPQaUn2MeKlOqWZ6HBALQO8jBdbg/Koia8cX71X2
 tWzwnOKiD5GSWawkZSEbOLr2EIYRpvDdtBqOL0PqmdlCU/lEP2skfPQx6txIKi3uzZnvwi4Q0xJ
 v6KKz+wc8Cs48ub4h0SLsu70BYLacgYaKtp
X-Google-Smtp-Source: AGHT+IFJTNlolu+VXOvdIzO65iM9Ib+XTAb7f4OXOKMKzfD3N72mukrLltkSXAFOk8nyNoDBgt5p8A==
X-Received: by 2002:a05:600c:3f12:b0:46e:42cb:d93f with SMTP id
 5b1f17b1804b1-46e42cbdbacmr14455875e9.15.1758904203266; 
 Fri, 26 Sep 2025 09:30:03 -0700 (PDT)
Received: from cypher.home.roving-it.com
 (7.9.7.f.b.1.3.0.b.8.f.0.9.e.0.0.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:fb11:2681:e9:f8b:31b:f797])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-46e33beebbasm81232995e9.19.2025.09.26.09.30.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 09:30:02 -0700 (PDT)
From: Peter Robinson <pbrobinson@gmail.com>
To: Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Heiko Stuebner <heiko@sntech.de>, Xuhui Lin <xuhui.lin@rock-chips.com>,
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v2] board: rockchip: Add support for rk3588 MNT Reform2
Date: Fri, 26 Sep 2025 17:29:56 +0100
Message-ID: <20250926163000.657437-1-pbrobinson@gmail.com>
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

Add support for MNT Reform2, it works as a carrier board
with a Firefly iCore-3588Q SoM.

Specification:
- Rockchip RK3588
- LPDDR5X 16/32 GB
- eMMC 128/256 GB
- HDMI Type A out x 1
- USB 3.0 Host x 1
- USB-C 3.0 with DisplayPort AltMode
- PCIE M.2 E Key for Wireless connection
- PCIE M.2 M Key for NVME connection
- DSI to eDP panel
- 1Gb Ethernet w/ Microchip KSZ9310 PHY

Tested using Fedora boot on USB stick and eMMC.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---

v2:
- DT now upstream
- dropped extra -u-boot.dtsi bits
- Run synconfig
- Minor other cleanups

 arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi |  3 +
 board/rockchip/evb_rk3588/MAINTAINERS       |  6 ++
 configs/mnt-reform2-rk3588_defconfig        | 84 +++++++++++++++++++++
 doc/board/rockchip/rockchip.rst             |  1 +
 4 files changed, 94 insertions(+)
 create mode 100644 arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi
 create mode 100644 configs/mnt-reform2-rk3588_defconfig

diff --git a/arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi b/arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi
new file mode 100644
index 00000000000..e1bdd5f98c5
--- /dev/null
+++ b/arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk3588-u-boot.dtsi"
diff --git a/board/rockchip/evb_rk3588/MAINTAINERS b/board/rockchip/evb_rk3588/MAINTAINERS
index 379c85f48a4..d630e3d4985 100644
--- a/board/rockchip/evb_rk3588/MAINTAINERS
+++ b/board/rockchip/evb_rk3588/MAINTAINERS
@@ -29,6 +29,12 @@ F:	configs/generic-rk3588_defconfig
 F:	arch/arm/dts/rk3588-generic.dts
 F:	arch/arm/dts/rk3588-generic-u-boot.dtsi
 
+MNT-REFORM2-RK3588
+M:	Peter Robinson <pbrobinson@gmail.com>
+S:	Maintained
+F:	configs/mnt-reform2-rk3588_defconfig
+F:	arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi
+
 ORANGEPI-5-RK3588
 M:	Jonas Karlman <jonas@kwiboo.se>
 S:	Maintained
diff --git a/configs/mnt-reform2-rk3588_defconfig b/configs/mnt-reform2-rk3588_defconfig
new file mode 100644
index 00000000000..c9cd4c85321
--- /dev/null
+++ b/configs/mnt-reform2-rk3588_defconfig
@@ -0,0 +1,84 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588-mnt-reform2"
+CONFIG_ROCKCHIP_RK3588=y
+CONFIG_SPL_SERIAL=y
+CONFIG_TARGET_EVB_RK3588=y
+CONFIG_SYS_LOAD_ADDR=0xc00800
+CONFIG_DEBUG_UART_BASE=0xFEB50000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_USE_PREBOOT=y
+CONFIG_PREBOOT="pci enum; usb start; nvme scan;"
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-mnt-reform2"
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
+CONFIG_CMD_USB_MASS_STORAGE=y
+# CONFIG_CMD_SETEXPR is not set
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
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_MISC=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_HS400_ES_SUPPORT=y
+CONFIG_SPL_MMC_HS400_ES_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_SPL_MMC_HS400_SUPPORT=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_PHY_MICREL=y
+CONFIG_PHY_MICREL_KSZ90X1=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_ROCKCHIP=y
+CONFIG_NVME_PCI=y
+CONFIG_PCIE_DW_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
+CONFIG_PHY_ROCKCHIP_USBDP=y
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
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index de3aa79cb5c..1e60327066b 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -152,6 +152,7 @@ List of mainline supported Rockchip boards:
      - Hardkernel ODROID-M2 (odroid-m2-rk3588s)
      - Indiedroid Nova (nova-rk3588s)
      - Khadas Edge2 (khadas-edge2-rk3588s)
+     - MNT Reform2 (mnt-reform2-rk3588)
      - Pine64 QuartzPro64 (quartzpro64-rk3588)
      - Radxa ROCK 5 ITX (rock-5-itx-rk3588)
      - Radxa ROCK 5A (rock5a-rk3588s)
-- 
2.51.0

