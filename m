Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CEEFC02193
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 01:59:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50F548096D;
	Wed,  5 Feb 2025 02:57:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BmD5VEMd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5536E807FB; Wed,  5 Feb 2025 02:57:51 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBD6380A0A
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 02:57:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-71e565708beso3410319a34.1
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 17:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738720665; x=1739325465; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G4Q3pyqZ+0ewPqe0Ej3vP4gvacIPGI9tiRKEznCfHNc=;
 b=BmD5VEMdLaaYIGCW2Zxe17Q0buel/UR+j2LWOZJYCD53Oc2DwgNvC7hRJeUwE3JYg/
 qMLkhLJ3Rd+8+CqufE5uiPctt4yBcKqfbDwZNHJgXVFHInofhVYpUiAIYlpILLqkfCWS
 ItsAvTT9Ek14TroY94pE4x5l/EADYXd2p7Bgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738720665; x=1739325465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G4Q3pyqZ+0ewPqe0Ej3vP4gvacIPGI9tiRKEznCfHNc=;
 b=oHJBoY6+rlXlOaXRO/PzyxTD7YyaOjN3+ALGSudkrq00nTDT7V9585UpDHbpyo7SiI
 V44tisx0POFaSeOyRS9H2w9BixP0LUO2lxeVQXrPPWEj/PWn8XR/aojPESDgNyXEmi0E
 wTFiob5oX6ALK2vm5MV02qNXymUxpiz1JrzlwVoO4tzglOYMGt0Ws/gKUbAJVJwLeaqb
 +7tm2uMmRy6wCTG4WdR8vK1OJL4Z6+x3b4vWyvNz4BDFYpwdCR34FwO9yg6O9C4WR7/h
 R5CWKD//xPZ7IM4MGt+zDWRLlm676z9ZHz9ZFPKat7RJTo8+a4nIlAvP2mtfoNE8BKpY
 PpMA==
X-Gm-Message-State: AOJu0Yxn582+imKVfC7En1Sl4lVWxromwYNzKthesMVhtd5EYbMgye+j
 5Qk2kOaOwr+HzX0aLjYifDYKgKdWVtAVbFEWEI5/KkATndY3jMQXOgSX2Gmuv2q5tqHLIYYYMMA
 =
X-Gm-Gg: ASbGnctftp+z5hLKxFjWorYRQ1NczsoNqgqo7TQPAkO4O0aT/UOt9Sl+ig0qX/mNAFw
 TV6ziKIFD9jdv9m+Eg9KC71YcLpWlhBMk0HhHHa6fY8y6wqO/3FmL2NKXmIArXeAWpnP2TCeUv0
 JSDk1H/iTZkGXHwBjbgaC0KQtxj8LetqgkreRRBuf4zkMqOR/+K4dqycVHq/yZDxW4bnjBbhRVC
 ZT2e1MMpuxfgiLxmhvYIqLSBnXoE1PpZBAoGpdEpRW0zEJ/xMO9kUQjlV+fWbVaqDRYMAq/6IOl
 156POvd7rtox2QJz7a1olx0Z8HvjKRIGOs7u+QDjP/rkGIZfJ0rZ
X-Google-Smtp-Source: AGHT+IFxq1qRKDE04qFbC8XzkbKFqz+15Y9/Y+pHEZ2H8u5isDZsWuE8XC6pD0J3B8+nNqKw0ujHEA==
X-Received: by 2002:a05:6830:630b:b0:71d:f8bd:4be4 with SMTP id
 46e09a7af769-726a428004emr774626a34.19.1738720664864; 
 Tue, 04 Feb 2025 17:57:44 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fc104c2e7asm3543676eaf.12.2025.02.04.17.57.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 17:57:43 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Christopher Obbard <chris.obbard@collabora.com>,
 Dragan Simic <dsimic@manjaro.org>, FUKAUMI Naoki <naoki@radxa.com>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH 25/29] rockchip: Add a generic rk3399 board
Date: Tue,  4 Feb 2025 18:55:15 -0700
Message-ID: <20250205015606.2686149-26-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205015606.2686149-1-sjg@chromium.org>
References: <20250205015606.2686149-1-sjg@chromium.org>
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

This build-target is used to build an image which can run on multiple
rk3399 boards, using VBE to boot.

To use it, the TPL binary for a particular board must be placed into the
first part of the image. The rest of the image (i.e. VPL, SPL and
U-Boot) are largely generic and can work on any supported board.

With VBE, memory-init happens in SPL so that this code is updatable in
the field. Due to size constraints, the type of memory on the board is
defined at build-time. So it is not possible to use the same VBE image
on boards with different SDRAM (DDR3 vs LPDDR4 for example). This may
become possible with newer boards with more SRAM.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/dts/rk3399-generic-u-boot.dtsi |  32 ++++++
 arch/arm/dts/rk3399-generic.dts         |  30 ++++++
 board/rockchip/evb_rk3399/MAINTAINERS   |   5 +
 configs/rk3399-generic_defconfig        | 133 ++++++++++++++++++++++++
 4 files changed, 200 insertions(+)
 create mode 100644 arch/arm/dts/rk3399-generic-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3399-generic.dts
 create mode 100644 configs/rk3399-generic_defconfig

diff --git a/arch/arm/dts/rk3399-generic-u-boot.dtsi b/arch/arm/dts/rk3399-generic-u-boot.dtsi
new file mode 100644
index 00000000000..732727d9b03
--- /dev/null
+++ b/arch/arm/dts/rk3399-generic-u-boot.dtsi
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2019 Jagan Teki <jagan@amarulasolutions.com>
+ */
+
+#include "rk3399-u-boot.dtsi"
+#include "rk3399-sdram-lpddr4-100.dtsi"
+/ {
+	chosen {
+		u-boot,spl-boot-order = "same-as-spl", &spi_flash, &sdmmc, &sdhci;
+	};
+};
+
+&sdhci {
+	cap-mmc-highspeed;
+	mmc-ddr-1_8v;
+};
+
+&spi1 {
+	spi_flash: flash@0 {
+		bootph-all;
+	};
+};
+
+&vdd_center {
+	regulator-min-microvolt = <950000>;
+	regulator-max-microvolt = <950000>;
+};
+
+&vdd_log {
+	regulator-init-microvolt = <950000>;
+};
diff --git a/arch/arm/dts/rk3399-generic.dts b/arch/arm/dts/rk3399-generic.dts
new file mode 100644
index 00000000000..f13bb7f6b4b
--- /dev/null
+++ b/arch/arm/dts/rk3399-generic.dts
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2017 Fuzhou Rockchip Electronics Co., Ltd.
+ * Copyright (c) 2018 Akash Gajjar <Akash_Gajjar@mentor.com>
+ * Copyright (c) 2019 Katsuhiro Suzuki <katsuhiro@katsuster.net>
+ */
+
+/dts-v1/;
+#include "rk3399-rockpro64.dtsi"
+
+/ {
+	model = "RK3399 Generic";
+	compatible = "pine64,rockpro64-v2.1", "pine64,rockpro64", "rockchip,rk3399";
+};
+
+&i2c1 {
+	es8316: codec@11 {
+		compatible = "everest,es8316";
+		reg = <0x11>;
+		clocks = <&cru SCLK_I2S_8CH_OUT>;
+		clock-names = "mclk";
+		#sound-dai-cells = <0>;
+
+		port {
+			es8316_p0_0: endpoint {
+				remote-endpoint = <&i2s1_p0_0>;
+			};
+		};
+	};
+};
diff --git a/board/rockchip/evb_rk3399/MAINTAINERS b/board/rockchip/evb_rk3399/MAINTAINERS
index 8dab3fa70f5..5f7c92230fb 100644
--- a/board/rockchip/evb_rk3399/MAINTAINERS
+++ b/board/rockchip/evb_rk3399/MAINTAINERS
@@ -89,3 +89,8 @@ M:	Jagan Teki <jagan@amarulasolutions.com>
 S:	Maintained
 F:	configs/rock-pi-n10-rk3399pro_defconfig
 F:	arch/arm/dts/rk3399pro-rock-pi-n10*
+
+RK3399-GENERIC
+M:	Simon Glass <sjg@chromium.org>
+S:	Maintained
+F:	configs/rk3399-generic_defconfig
diff --git a/configs/rk3399-generic_defconfig b/configs/rk3399-generic_defconfig
new file mode 100644
index 00000000000..ab57e011726
--- /dev/null
+++ b/configs/rk3399-generic_defconfig
@@ -0,0 +1,133 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_SPL_SYS_DCACHE_OFF=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_TEXT_BASE=0x00200000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
+CONFIG_SF_DEFAULT_SPEED=20000000
+CONFIG_ENV_OFFSET=0x3F8000
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-firefly"
+CONFIG_DM_RESET=y
+CONFIG_ROCKCHIP_RK3399=y
+CONFIG_TARGET_EVB_RK3399=y
+CONFIG_SPL_STACK=0xff8eff00
+CONFIG_SPL_TEXT_BASE=0xff8c2000
+CONFIG_SPL_BSS_MAX_SIZE=0x2000
+CONFIG_SPL_STACK_R=y
+CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x30000
+CONFIG_SYS_LOAD_ADDR=0x800800
+CONFIG_DEBUG_UART_BASE=0xFF1A0000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+CONFIG_FIT_BEST_MATCH=y
+CONFIG_VPL_LOAD_FIT_FULL=y
+# CONFIG_VPL_FIT_PRINT is not set
+# CONFIG_VPL_FIT_SIGNATURE is not set
+# CONFIG_VPL_BOOTSTD is not set
+# CONFIG_BOOTMETH_VBE_SIMPLE is not set
+CONFIG_BOOTMETH_VBE_ABREC=y
+CONFIG_BOOTSTAGE=y
+CONFIG_BOOTSTAGE_REPORT=y
+CONFIG_USE_PREBOOT=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-generic.dtb"
+CONFIG_LOG=y
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_BLOBLIST=y
+CONFIG_BLOBLIST_ADDR=0xff8eff00
+CONFIG_BLOBLIST_SIZE=0x100
+CONFIG_SPL_BLOBLIST_RELOC=y
+CONFIG_SPL_BLOBLIST_RELOC_ADDR=0x00100000
+CONFIG_SPL_MAX_SIZE=0x40000
+CONFIG_SPL_PAD_TO=0x7f8000
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+# CONFIG_SPL_SEPARATE_BSS is not set
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1000
+CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
+CONFIG_TPL=y
+CONFIG_TPL_RELOC_LOADER=y
+CONFIG_VPL=y
+CONFIG_VPL_RELOC_LOADER=y
+CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_USB=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_BOOTSTAGE=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIST="rockchip/rk3399-evb rockchip/rk3399-ficus rockchip/rk3399-firefly rockchip/rk3399-gru-bob rockchip/rk3399-gru-kevin rockchip/rk3399-orangepi rockchip/rk3399-pinebook-pro rockchip/rk3399-pinephone-pro rockchip/rk3399-puma-haikou rockchip/rk3399-rockpro64 rockchip/rk3399-rockpro64-v2"
+CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_TPL_DM_SEQ_ALIAS=y
+CONFIG_VPL_REGMAP=y
+CONFIG_VPL_SYSCON=y
+CONFIG_SATA=y
+CONFIG_SCSI_AHCI=y
+CONFIG_SATA_SIL=y
+CONFIG_SPL_CLK=y
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_ETH_DESIGNWARE=y
+CONFIG_GMAC_ROCKCHIP=y
+CONFIG_NVME_PCI=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_TYPEC=y
+# CONFIG_SPL_DM_PMIC is not set
+CONFIG_PMIC_RK8XX=y
+CONFIG_REGULATOR_PWM=y
+CONFIG_REGULATOR_RK8XX=y
+CONFIG_PWM_ROCKCHIP=y
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_ROCKCHIP_SPI=y
+CONFIG_SYSRESET=y
+# CONFIG_VPL_SYSRESET is not set
+CONFIG_USB=y
+# CONFIG_SPL_DM_USB is not set
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_GENERIC=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_KEYBOARD=y
+CONFIG_USB_HOST_ETHER=y
+CONFIG_USB_ETHER_ASIX=y
+CONFIG_USB_ETHER_ASIX88179=y
+CONFIG_USB_ETHER_MCS7830=y
+CONFIG_USB_ETHER_RTL8152=y
+CONFIG_USB_ETHER_SMSC95XX=y
+CONFIG_VIDEO=y
+CONFIG_DISPLAY=y
+CONFIG_VIDEO_ROCKCHIP=y
+CONFIG_DISPLAY_ROCKCHIP_HDMI=y
+CONFIG_VPL_USE_TINY_PRINTF=y
+CONFIG_SPL_TINY_MEMSET=y
+CONFIG_CMD_DHRYSTONE=y
+# CONFIG_SPL_SHA1 is not set
+# CONFIG_VPL_SHA1 is not set
+# CONFIG_VPL_SHA256 is not set
+CONFIG_TPL_CRC8=y
+CONFIG_TPL_LZ4=y
+CONFIG_VPL_LZ4=y
+# CONFIG_VPL_LZMA is not set
+CONFIG_ERRNO_STR=y
-- 
2.43.0

