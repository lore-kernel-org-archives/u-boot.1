Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58DF1E7718E
	for <u-boot@archiver.kernel.org>; Thu, 26 Dec 2024 09:22:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE12A80362;
	Thu, 26 Dec 2024 10:21:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eZLyPAuP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5442A803CA; Thu, 26 Dec 2024 10:21:17 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6DC48043C
 for <u-boot@lists.denx.de>; Thu, 26 Dec 2024 10:21:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=cnsztl@gmail.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2ee86a1a92dso5724831a91.1
 for <u-boot@lists.denx.de>; Thu, 26 Dec 2024 01:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1735204873; x=1735809673; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IVJMGVNtn+1sarlnuvaanEPPgv2LPDXsVuDzq5b/GVY=;
 b=eZLyPAuPBxdHQLWUV/2u1BkIaZJLq/Dc5Fd76bvv88wL3CZT90Q/Wa/3nf+UIpoVxx
 mvmNimZs1Q1VWIW0tz1xRgRqQYq86RVSbdwxMi56gzyKC/T663lL5t/3G83QScnFwx9A
 15aL7oUvwoHHqtyZpZRmSv2Xl3JeyTzu5VTnhvgkVTo8xSiogOzI51DAj1E0O0QEZMsf
 qrO80NgI/BZg6VUF+64iUOfALQOyADjfN4gUibbVwPM1ZqYLAGG7/pqhNCwpSme3O13Z
 LjsGnQpnJ8fyyS8YgYNsgys5OERWhOjRTmlrvv2097JAP6hUZhTH+l6pOUQDsk77RtIt
 8uHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735204873; x=1735809673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IVJMGVNtn+1sarlnuvaanEPPgv2LPDXsVuDzq5b/GVY=;
 b=ou2iLKZf6gKyDIu3wJ2NyFyXvgRg1AMEzf/QB3JZVIZvQmUK3NquSuio1VEMO5N0I+
 1r6v4D8+JvZJ4Nt9zgX+EJyjH/ZGKve8JPr6bJ+zcgFfx8SQ3sA9NfXUVf2cgOduUpjL
 nQ2jrXDEUKmHKwb5zAiB8gjE1rcXh37xB7lEnATs3Urt9VMoWOeLj77KiBbPc+HLv3x5
 yQ50PAjDvCgbUdiWPPtonZIjpJrbIP65+Wfc9WmpcKne0L81EZbApn+nAsFhYR2YkE7o
 2IYCjlQSt6U/nV+NvkP2x39HpCzi+xjbK5IL+Kz2WSb+ltz6gPOUBwcPG60nx9WHzr0j
 XNBA==
X-Gm-Message-State: AOJu0YzyfLA3VbjUrgKz/Ou/LFw0nQTLdiGi/+CE48/rccIayJfni1z6
 z/qCg2aMyKivQ4njdR1KRR4MH8n0oCL6YyIJ2KfRuQGLWbbLO5PE
X-Gm-Gg: ASbGncvoZ488k/UBz+RAJqMSGYQGPh1bvfYwEc/yPn0yiGMj82v9q1/j2Fe8RrCETwQ
 k/rQdMPUXzlnX6jvSL0wf3g/O+X5OEJHJqZT78e/OXs/du7zB8z93jVDLiwMG4mvyBCW1j+vp+v
 uwSfhRgFkf5pTtnYsywOJRrb3y7z+PLsAwtUgvixzXyZWSI2OCTie62ecflgfkJV4vYqXMHtldf
 6Q6iHb59Anv5scMxtSHU7vwE31xDjk8bMPrl70+whS+ZaAoz5xskyxjAm8=
X-Google-Smtp-Source: AGHT+IGiwL06W4L3i4Dg9Fx3tnibEpj/lTtlCiOADhvVXkHyCdM3DM7i0yk0hF6V8KAzSeLIeVx4fg==
X-Received: by 2002:a17:90a:d00b:b0:2ee:863e:9ff6 with SMTP id
 98e67ed59e1d1-2f452e2e47amr34767122a91.16.1735204873045; 
 Thu, 26 Dec 2024 01:21:13 -0800 (PST)
Received: from CNSZTL-DEB.lan ([2408:8362:245d:5fa2:bc4b:53ff:fead:2725])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9d948fsm116347985ad.150.2024.12.26.01.21.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Dec 2024 01:21:12 -0800 (PST)
From: Tianling Shen <cnsztl@gmail.com>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tianling Shen <cnsztl@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH 7/7] board: rockchip: add FriendlyElec NanoPi R3S
Date: Thu, 26 Dec 2024 17:20:43 +0800
Message-ID: <20241226092043.419511-8-cnsztl@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241226092043.419511-1-cnsztl@gmail.com>
References: <20241226092043.419511-1-cnsztl@gmail.com>
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

The NanoPi R3S(as "R3S") is an open source platform with dual-Gbps
Ethernet ports designed and developed by FriendlyElec for IoT
applications.

Specification:
- Rockchip RK3566
- 2GB LPDDR4X RAM
- optional 32GB eMMC module
- SD card slot
- 2x 1000 Base-T
- 3x LEDs (POWER, LAN, WAN)
- 2x Buttons (Reset, MaskROM)
- 1x USB 3.0 Port
- Type-C 5V 2A Power

Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 arch/arm/dts/rk3566-nanopi-r3s-u-boot.dtsi |  8 +++
 board/rockchip/evb_rk3568/MAINTAINERS      |  7 ++
 configs/nanopi-r3s-rk3566_defconfig        | 74 ++++++++++++++++++++++
 doc/board/rockchip/rockchip.rst            |  1 +
 4 files changed, 90 insertions(+)
 create mode 100644 arch/arm/dts/rk3566-nanopi-r3s-u-boot.dtsi
 create mode 100644 configs/nanopi-r3s-rk3566_defconfig

diff --git a/arch/arm/dts/rk3566-nanopi-r3s-u-boot.dtsi b/arch/arm/dts/rk3566-nanopi-r3s-u-boot.dtsi
new file mode 100644
index 0000000000..b66e5015d6
--- /dev/null
+++ b/arch/arm/dts/rk3566-nanopi-r3s-u-boot.dtsi
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include "rk356x-u-boot.dtsi"
+
+&vcc5v0_usb {
+	/delete-property/ regulator-always-on;
+	/delete-property/ regulator-boot-on;
+};
diff --git a/board/rockchip/evb_rk3568/MAINTAINERS b/board/rockchip/evb_rk3568/MAINTAINERS
index 588134ecb2..b2780401a3 100644
--- a/board/rockchip/evb_rk3568/MAINTAINERS
+++ b/board/rockchip/evb_rk3568/MAINTAINERS
@@ -28,6 +28,13 @@ F:	configs/lubancat-2-rk3568_defconfig
 F:	arch/arm/dts/rk3568-lubancat-2.dts
 F:	arch/arm/dts/rk3568-lubancat-2-u-boot.dtsi
 
+NANOPI-R3S
+M:	Tianling Shen <cnsztl@gmail.com>
+R:	Jonas Karlman <jonas@kwiboo.se>
+S:	Maintained
+F:	configs/nanopi-r3s-rk3566_defconfig
+F:	arch/arm/dts/rk3566-nanopi-r3s-u-boot.dtsi
+
 NANOPI-R5C
 M:	Tianling Shen <cnsztl@gmail.com>
 R:	Jonas Karlman <jonas@kwiboo.se>
diff --git a/configs/nanopi-r3s-rk3566_defconfig b/configs/nanopi-r3s-rk3566_defconfig
new file mode 100644
index 0000000000..f21c703ca7
--- /dev/null
+++ b/configs/nanopi-r3s-rk3566_defconfig
@@ -0,0 +1,74 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3566-nanopi-r3s"
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
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-nanopi-r3s.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_SPL_MAX_SIZE=0x40000
+CONFIG_SPL_PAD_TO=0x7f8000
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
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_MISC=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_ROCKCHIP=y
+CONFIG_RTL8169=y
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
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 9bab86d234..02d7a4b124 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -99,6 +99,7 @@ List of mainline supported Rockchip boards:
 
 * rk3566
      - Anbernic RGxx3 (anbernic-rgxx3-rk3566)
+     - FriendlyElec NanoPi R3S (nanopi-r3s-rk3566)
      - Hardkernel ODROID-M1S (odroid-m1s-rk3566)
      - Pine64 PineTab2 (pinetab2-rk3566)
      - Pine64 Quartz64-A Board (quartz64-a-rk3566)
-- 
2.47.0

