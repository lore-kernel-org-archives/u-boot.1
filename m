Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E8E4E77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 15:37:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C911893AE;
	Sun,  8 Dec 2024 16:37:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IxpyMA4R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0D0A89586; Sun,  8 Dec 2024 16:37:01 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 511E689370
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 16:36:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aa65f707419so24862166b.2
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 07:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733672219; x=1734277019; darn=lists.denx.de;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qkISwdGcAxHbZq4MlfL88QCbnVFihdAck3o04bIAhyk=;
 b=IxpyMA4R8IjST1HDU9g4NXVf4VytKqN3uMVxntiqtiSwXxU/q9XUwyxPL5wNJ/vCmV
 rHab7U/Biac55J+0ovtw0jJlqm+8TIF7Dxo3zYMsbv7Yu/X3ryKAwVRhwmu5alu0/trc
 wBHNXlY7Km+2dRXObY7QrhYlszajs18YlLnooEBbGHg7z92IIXXoq1v+Rc3IWCypTIHF
 I6tZ8QqMOWP7yROhtPMPYzRMdOG8Jn2IudSzwcBrxocAk1ZbGfL0RM3M5vWsUnAIWdWX
 yxjLh9cc/fpWH6olHKO0KN8Dm8O3GWJSzMFK4gr2KnAXShWlLKzo652eL+RE5+JbFlMq
 U9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733672219; x=1734277019;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qkISwdGcAxHbZq4MlfL88QCbnVFihdAck3o04bIAhyk=;
 b=rHw7b+kSzdsU+0YpzC+FWK47aq6+9x4mTYHwJ0LkNB8gTprbFUdQ5PJ3VOIQqA/9dk
 E+34jLbeRJS4uUFrd+uKHlq0jdEVnrmbuEYFi4zSK65KVUH2wvURHJ31ff453lo0lqfG
 q0rJktavQCXUVdPpdPxJDp0ha8CH7bAoSmVDvvp8khollptiscay68x5vmWAaqZ/Au8v
 kG3voSIx/Q96ix9pUURHQ0Dvpmlc67l/zjyT28Mi3Ml0NiUWwkBONyW2pDJbyMhw90Hu
 Ifc6gmRA/7CKnHIO87P7TevPzgQW855eHWZSH9O0LrG6g7XExxplkaC4Rsinr7wzhVCH
 NHOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkl5tL6m98lNeWFrMxKSSxpIX1WL1Sr4guIvABJzezgmfLZVriFwHuwTgYtF1/4zVbmGDZL3A=@lists.denx.de
X-Gm-Message-State: AOJu0YwYIWbeDoRFU4QBYDAyv4837r49lgmRp75IDLA8yd3sSEGadJcH
 llVXyE7Oeb09cA7QNWKf2f7dn5nsCSR39ODYIG8kfHF+7OugkyH2
X-Gm-Gg: ASbGnctiMu2t7kcQw3bmQtb1SFOiAzKX4GmTUb8/MaJXWjHY4pszeAeFSt8RKQ1NRXA
 Z4Ja0LM40R9M0Ax+AlK4PP7Yzlt2bpjUitQ5Fn6lQZ312dN9bSlANW8OMWUXXNLdBp3UsW8p6iq
 0UZQsB/bYC0g4PSB6VFMjx2A6y+97Y8VOkzbYXvwaLBgz44VhagLBV5O4gAIq00QfEt61IaQo17
 gFZ0nGwz4dHSWq3/0Cyf/9pGcLUOgrNyVzyp8vnKkwL4U3aR03xT/9dVlaI/ZQtGFIqiv4R3GxF
 rNqVbSh6BSqSbw==
X-Google-Smtp-Source: AGHT+IG+WYgJgaJE/rRq5l6wbdqs0cJ+gdAhH/pAy8UmW7eBjG7siiEbq5GPPl+lXA2x8/PoMdyudQ==
X-Received: by 2002:a17:907:3fa4:b0:aa6:2eb3:40ea with SMTP id
 a640c23a62f3a-aa63a28806dmr393057966b.11.1733672218381; 
 Sun, 08 Dec 2024 07:36:58 -0800 (PST)
Received: from ?IPV6:2a02:a449:4071:1:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:1:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa6801060e4sm74046366b.158.2024.12.08.07.36.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Dec 2024 07:36:57 -0800 (PST)
Message-ID: <d0bcf1f6-3698-4e5f-8f2c-fcb99bde7602@gmail.com>
Date: Sun, 8 Dec 2024 16:36:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1] arm: dts: rockchip: add rk3318 A95X Z2 board
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, u-boot@lists.denx.de
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

The rk3318 A95X Z2 boards are sold as TV box.
No further documentation is given, but from the dts files
extracted it seems that the rk3318 processor is simulair
to the rk3328. Included is an extra dtsi file for U-Boot
specific properties. The DT is already located in
the /dts/upstream directory.

Features:

CPU: RK3318 Quad-Core Cortex-A53
GPU: Mali-450
RAM: 2/4GB DDR3
ROM: EMMC 16/32/64GB
HDMI: HDMI 2.0a for 4k@60Hz
Ethernet: 10/100M standard RJ-45
WiFi: 2.4G+5G WIFI, 802.11 b/g/n
Bluetooth: 4.0
1 x USB 3.0
1 x USB 2.0
1 x Micro SD card slot
1 x SPDIF
1 x AV
1 x DC IN

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/dts/rk3318-a95x-z2-u-boot.dtsi |  9 +++
 board/rockchip/evb_rk3328/MAINTAINERS   |  6 ++
 configs/a95x-z2-rk3318_defconfig        | 94 +++++++++++++++++++++++++
 doc/board/rockchip/rockchip.rst         |  4 +-
 4 files changed, 112 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/rk3318-a95x-z2-u-boot.dtsi
 create mode 100644 configs/a95x-z2-rk3318_defconfig

diff --git a/arch/arm/dts/rk3318-a95x-z2-u-boot.dtsi b/arch/arm/dts/rk3318-a95x-z2-u-boot.dtsi
new file mode 100644
index 000000000000..e21fd6e07df7
--- /dev/null
+++ b/arch/arm/dts/rk3318-a95x-z2-u-boot.dtsi
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include "rk3328-u-boot.dtsi"
+#include "rk3328-sdram-ddr3-666.dtsi"
+
+&usb20_otg {
+	dr_mode = "otg";
+};
+
diff --git a/board/rockchip/evb_rk3328/MAINTAINERS b/board/rockchip/evb_rk3328/MAINTAINERS
index 5f81be55b8e0..fe642a56a690 100644
--- a/board/rockchip/evb_rk3328/MAINTAINERS
+++ b/board/rockchip/evb_rk3328/MAINTAINERS
@@ -1,3 +1,9 @@
+A95X-Z2-RK3318
+M:      Johan Jonker <jbx6244@gmail.com>
+S:      Maintained
+F:      configs/a95x-z2-rk3318_defconfig
+F:      arch/arm/dts/rk3318-a95x-z2-u-boot.dtsi
+
 EVB-RK3328
 M:      Kever Yang <kever.yang@rock-chips.com>
 S:      Maintained
diff --git a/configs/a95x-z2-rk3318_defconfig b/configs/a95x-z2-rk3318_defconfig
new file mode 100644
index 000000000000..9cb6a67ad5ae
--- /dev/null
+++ b/configs/a95x-z2-rk3318_defconfig
@@ -0,0 +1,94 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_SF_DEFAULT_SPEED=20000000
+CONFIG_ENV_OFFSET=0x3F8000
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3318-a95x-z2"
+CONFIG_DM_RESET=y
+CONFIG_ROCKCHIP_RK3328=y
+CONFIG_SYS_LOAD_ADDR=0x800800
+CONFIG_DEBUG_UART_BASE=0xFF130000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_DEBUG_UART=y
+# CONFIG_ANDROID_BOOT_IMAGE is not set
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3318-a95x-z2.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_SPL_MAX_SIZE=0x40000
+CONFIG_SPL_PAD_TO=0x7f8000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_ATF=y
+CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
+CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_ROCKUSB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+# CONFIG_CMD_SETEXPR is not set
+# CONFIG_CMD_NET is not set
+CONFIG_CMD_TIME=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_TPL_OF_CONTROL=y
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_TPL_OF_PLATDATA=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_TPL_DM=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
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
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+# CONFIG_NETDEVICES is not set
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
+CONFIG_PWM_ROCKCHIP=y
+CONFIG_RAM=y
+CONFIG_SPL_RAM=y
+CONFIG_TPL_RAM=y
+CONFIG_DM_RNG=y
+CONFIG_RNG_ROCKCHIP=y
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
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_DWC2_OTG=y
+CONFIG_USB_FUNCTION_ROCKUSB=y
+CONFIG_SPL_TINY_MEMSET=y
+CONFIG_TPL_TINY_MEMSET=y
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 9bab86d23479..ec325c4fe558 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -57,6 +57,8 @@ List of mainline supported Rockchip boards:
      - Radxa ROCK S0 (rock-s0-rk3308)
      - Rockchip Evb-RK3308 (evb-rk3308)
      - Roc-cc-RK3308 (roc-cc-rk3308)
+* rk3318
+     - A95X Z2 (a95x-z2-rk3318)
 * rk3326
      - ODROID-GO Advance (odroid-go2)
 * rk3328
@@ -190,7 +192,7 @@ TPL

 For some SoCs U-Boot sources lack of support to inizialize DRAM.
 In these cases, to get a fully functional image following :ref:`PackageWithTPLandSPL`, use DDR binary provided by Rockchip rkbin repository as ROCKCHIP_TPL when building U-Boot.
-Otherwise, follow :ref:`PackageWithRockchipMiniloader`.
+Otherwise, follow :ref:`PackageWithRockchipMiniloader`.

 U-Boot
 ^^^^^^
--
2.39.5

