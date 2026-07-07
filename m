Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C687BC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 15:34:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75F5184B1F;
	Tue,  7 Jul 2026 17:33:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aysS3TUf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19C3084AF7; Tue,  7 Jul 2026 17:33:11 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 612B184AFF
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 17:33:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-44ae264a785so2177093fac.3
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 08:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783438387; x=1784043187; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZAVNyJy/MTrAYSjqq7UzL2nDQ/NylNSTKYUntIqi+lw=;
 b=aysS3TUfEeXR8D45ATn3aM42qojRPE2b4RwcuvI2tRNE+onmfof9IgPu5bHnNt86GZ
 11NEn7P1dgK5feI51k2NJjXciSnWRBf19k/9QJWR2WBfhqWgs1+7COwm31zdm2cFPOOj
 t98XB91YhBsHSeZx9BeHMxI2wja6CnECwBv8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783438387; x=1784043187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZAVNyJy/MTrAYSjqq7UzL2nDQ/NylNSTKYUntIqi+lw=;
 b=gxEj6uUvlBl7e2UDv/IO+nTWDRSGzh0wjqjSTJsFljvwokD2D2l4VEezjmj0DBaWKe
 hu4mxZ2uYdTam4G+27dbwbZbB6eV1zmRc9ihXQSbjQcgaqCJtKgSceL0oclxV62TyQ5O
 kX+8VNoBJIAdLdW7OHuxcE4xr04/IcLclnQ3eqOGKPm3sO8RPp/vblTxeRgcPsbRAOSH
 /a7K6gF3ZNB3YF2ZRul77EYvg8fkzij9amBUtA7TeEydcaeRNn6L2emvPYn03K0anYWl
 uUohrrumnaMrbwlEz4aRyXxDd2bnvzNdUGxVguSbNgeKB2InMDIFF0dpEb3Xlri4yl7Y
 7qeg==
X-Gm-Message-State: AOJu0YzoECx4dLKD2bHGq7ugqcH9/RXhcycZJAFmGZyc26DNvKH4xg+c
 ueVrPnwa2g4pCQQ4AR0xo28Da1TIWRdQSz/xCW447z2DABDaBYw1WKHrQnkyUdpw2SftNB+SP6y
 LKYwzkw==
X-Gm-Gg: AfdE7cmnQIkJe/H9RhkPZstLxr1lhCOouPL2wdL3Hs0jgEcQ+D8lo5IWWZ9erTl1RjN
 7kM+8u4S0qoDjn6IVs8sCtYxJvd2rzonlFaxwV6jP5cSM3dK03aLEt6L3ieHV2N0fI+kCHhVx7h
 4Xl4xalFw57Wf30Wn8wubFnzUtIJTx0aB8c2cFP6bKgtGDQtziMNktWa25k/oZIvfsyAXC3lWu7
 EaXwpnvDf/zpLEkQtjFZdnci+eNYPQzLLGutVi+8nV1AUvfFzTsvXJ3ZR7jZnsalIkeW4rjcFaZ
 1xSE4+eTb3w3UfPicQZTdnagUTKtaEZda2cz0CIk2KG7CTHIvzGlnu0h+fA6YoZxmQQuqUkqwTn
 G4/JCKYhQpx4KCYhYIj2E/5/KiGEJLf9YFG1WQqB0aaVPy9gDfw/wR5cX0Qdfl3zRH1OFkrheAL
 DwlqvLeDg=
X-Received: by 2002:a05:6808:524a:b0:495:e677:1332 with SMTP id
 5614622812f47-49fdea0d521mr4106661b6e.36.1783438387008; 
 Tue, 07 Jul 2026 08:33:07 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-497d1b43cfcsm12052218b6e.14.2026.07.07.08.33.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:33:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@nabladev.com>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>,
 Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Chris Packham <judge.packham@gmail.com>, FUKAUMI Naoki <naoki@radxa.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Kever Yang <kever.yang@rock-chips.com>,
 Niu Zhihong <zhihong@nzhnb.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tianling Shen <cnsztl@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 14/15] luckfox-pico: Add the initial support
Date: Tue,  7 Jul 2026 09:31:12 -0600
Message-ID: <20260707153135.2048115-15-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707153135.2048115-1-sjg@chromium.org>
References: <20260707153135.2048115-1-sjg@chromium.org>
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

Add the initial support for the Luckfox Pico Mini B board, which uses
the RV1103 with 64MB of in-package DDR2 and a 128MB Winbond SPI NAND.

The board boots from the SPI NAND, or over USB in maskrom mode using
the u-boot-rockchip-usb471/usb472 images, in which case U-Boot runs
entirely from RAM. The console is on UART2 at 115200 baud

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 .../rv1103-luckfox-pico-mini-b-u-boot.dtsi    | 10 +++
 arch/arm/dts/rv1103-luckfox-pico-mini-b.dts   | 85 +++++++++++++++++++
 board/luckfox/pico/MAINTAINERS                |  6 ++
 board/luckfox/pico/Makefile                   |  7 ++
 board/luckfox/pico/pico.c                     | 19 +++++
 board/luckfox/pico/pico.env                   |  4 +
 configs/luckfox-pico-mini-b-rv1103_defconfig  | 79 +++++++++++++++++
 doc/board/index.rst                           |  1 +
 doc/board/luckfox/index.rst                   |  9 ++
 doc/board/luckfox/luckfox-pico.rst            | 71 ++++++++++++++++
 doc/board/rockchip/rockchip.rst               |  4 +
 include/configs/luckfox_pico.h                | 11 +++
 12 files changed, 306 insertions(+)
 create mode 100644 arch/arm/dts/rv1103-luckfox-pico-mini-b-u-boot.dtsi
 create mode 100644 arch/arm/dts/rv1103-luckfox-pico-mini-b.dts
 create mode 100644 board/luckfox/pico/MAINTAINERS
 create mode 100644 board/luckfox/pico/Makefile
 create mode 100644 board/luckfox/pico/pico.c
 create mode 100644 board/luckfox/pico/pico.env
 create mode 100644 configs/luckfox-pico-mini-b-rv1103_defconfig
 create mode 100644 doc/board/luckfox/index.rst
 create mode 100644 doc/board/luckfox/luckfox-pico.rst
 create mode 100644 include/configs/luckfox_pico.h

diff --git a/arch/arm/dts/rv1103-luckfox-pico-mini-b-u-boot.dtsi b/arch/arm/dts/rv1103-luckfox-pico-mini-b-u-boot.dtsi
new file mode 100644
index 00000000000..968bf1dfa66
--- /dev/null
+++ b/arch/arm/dts/rv1103-luckfox-pico-mini-b-u-boot.dtsi
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0+
+// (C) Copyright 2026 Simon Glass <sjg@chromium.org>
+
+#include "rockchip-u-boot.dtsi"
+
+/ {
+	chosen {
+		u-boot,spl-boot-order = &spi_nand;
+	};
+};
diff --git a/arch/arm/dts/rv1103-luckfox-pico-mini-b.dts b/arch/arm/dts/rv1103-luckfox-pico-mini-b.dts
new file mode 100644
index 00000000000..b0eac7d13c1
--- /dev/null
+++ b/arch/arm/dts/rv1103-luckfox-pico-mini-b.dts
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2023 Luckfox Electronics Co., Ltd
+ */
+
+/dts-v1/;
+
+#include "rv1103.dtsi"
+
+/ {
+	model = "Luckfox Pico Mini B";
+	compatible = "luckfox,pico-mini-b", "rockchip,rv1103";
+
+	aliases {
+		mmc0 = &sdmmc;
+		spi0 = &sfc;
+	};
+
+	chosen {
+		stdout-path = "serial2:115200n8";
+	};
+};
+
+&sdmmc {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	disable-wp;
+	status = "okay";
+};
+
+&sfc {
+	status = "okay";
+
+	spi_nand: flash@0 {
+		compatible = "spi-nand";
+		reg = <0>;
+		bootph-pre-ram;
+		bootph-some-ram;
+		spi-max-frequency = <75000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <1>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "env";
+				reg = <0x00000000 0x00040000>;
+			};
+
+			partition@40000 {
+				label = "idblock";
+				reg = <0x00040000 0x00100000>;
+				read-only;
+			};
+
+			partition@140000 {
+				label = "uboot";
+				reg = <0x00140000 0x00100000>;
+				read-only;
+			};
+
+			partition@240000 {
+				label = "boot";
+				reg = <0x00240000 0x00800000>;
+			};
+
+			partition@a40000 {
+				label = "ubi";
+				reg = <0x00a40000 0x075c0000>;
+			};
+		};
+	};
+};
+
+&uart2 {
+	bootph-all;
+	status = "okay";
+};
+
+&wdt {
+	status = "okay";
+};
diff --git a/board/luckfox/pico/MAINTAINERS b/board/luckfox/pico/MAINTAINERS
new file mode 100644
index 00000000000..debf7059cf9
--- /dev/null
+++ b/board/luckfox/pico/MAINTAINERS
@@ -0,0 +1,6 @@
+LUCKFOX PICO
+M:	Simon Glass <sjg@chromium.org>
+S:	Maintained
+F:	board/luckfox/pico
+F:	include/configs/luckfox_pico.h
+F:	configs/luckfox-pico-mini-b-rv1103_defconfig
diff --git a/board/luckfox/pico/Makefile b/board/luckfox/pico/Makefile
new file mode 100644
index 00000000000..4d2f5caff96
--- /dev/null
+++ b/board/luckfox/pico/Makefile
@@ -0,0 +1,7 @@
+#
+# SPDX-License-Identifier:	GPL-2.0+
+#
+# Copyright 2026 Simon Glass <sjg@chromium.org>
+#
+
+obj-y	+= pico.o
diff --git a/board/luckfox/pico/pico.c b/board/luckfox/pico/pico.c
new file mode 100644
index 00000000000..a8a471c20f3
--- /dev/null
+++ b/board/luckfox/pico/pico.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright 2026 Simon Glass <sjg@chromium.org>
+
+#include <asm/global_data.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int dram_init(void)
+{
+	gd->ram_size = SZ_64M;
+
+	return 0;
+}
+
+phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
+{
+	return gd->ram_top;
+}
diff --git a/board/luckfox/pico/pico.env b/board/luckfox/pico/pico.env
new file mode 100644
index 00000000000..0d954ee4f98
--- /dev/null
+++ b/board/luckfox/pico/pico.env
@@ -0,0 +1,4 @@
+kernel_addr_r=0x00800000
+fdt_addr_r=0x02000000
+ramdisk_addr_r=0x03000000
+bootargs=console=ttyS2,115200 mtdparts=spi0.0:256K(env),1M@256K(idblock),1M(uboot),8M(boot),-(ubi) ro rootwait ubi.mtd=ubi ubi.block=0,rootfs root=/dev/ubiblock0_0 rootfstype=squashfs
diff --git a/configs/luckfox-pico-mini-b-rv1103_defconfig b/configs/luckfox-pico-mini-b-rv1103_defconfig
new file mode 100644
index 00000000000..f857f0a42c0
--- /dev/null
+++ b/configs/luckfox-pico-mini-b-rv1103_defconfig
@@ -0,0 +1,79 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_SYS_ARCH_TIMER=y
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_TEXT_BASE=0x00200000
+CONFIG_SYS_MALLOC_F_LEN=0x80000
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x00400000
+CONFIG_SF_DEFAULT_SPEED=24000000
+CONFIG_DEFAULT_DEVICE_TREE="rv1103-luckfox-pico-mini-b"
+CONFIG_ROCKCHIP_RV1106=y
+CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
+CONFIG_ROCKCHIP_EXTERNAL_TPL=y
+CONFIG_ROCKCHIP_MASKROM_IMAGE=y
+CONFIG_SPL_SERIAL=y
+CONFIG_TARGET_LUCKFOX_PICO_RV1103=y
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x100000
+CONFIG_SYS_BOOTM_LEN=0x04000000
+CONFIG_SYS_LOAD_ADDR=0x00008000
+CONFIG_DEBUG_UART_BASE=0xff4c0000
+CONFIG_DEBUG_UART_CLOCK=24000000
+# CONFIG_DEBUG_UART_BOARD_INIT is not set
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_SPI=y
+CONFIG_DEBUG_UART=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_CIPHER=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_FIT_BEST_MATCH=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_BOOTDELAY=1
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_SPL_NO_BSS_LIMIT=y
+CONFIG_SPL_MTD=y
+CONFIG_SPL_SPI_NAND_LOAD=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x140000
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_SPI=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_TIME=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_NO_NET=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SYSCON=y
+CONFIG_SPL_SYSCON=y
+CONFIG_CLK=y
+CONFIG_SPL_CLK=y
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_DM_MTD=y
+CONFIG_MTD_SPI_NAND=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_GIGADEVICE=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_SPI_FLASH_XTX=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_ROCKCHIP_SFC=y
+CONFIG_SYSRESET=y
+# CONFIG_RSA is not set
+# CONFIG_SPL_SHA1 is not set
+# CONFIG_SPL_SHA256 is not set
+CONFIG_LZMA=y
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/index.rst b/doc/board/index.rst
index 2454c3598fb..11ec39cf915 100644
--- a/doc/board/index.rst
+++ b/doc/board/index.rst
@@ -39,6 +39,7 @@ Board-specific doc
    kontron/index
    lenovo/index
    lg/index
+   luckfox/index
    liebherr/index
    mediatek/index
    microchip/index
diff --git a/doc/board/luckfox/index.rst b/doc/board/luckfox/index.rst
new file mode 100644
index 00000000000..66feee84257
--- /dev/null
+++ b/doc/board/luckfox/index.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Luckfox
+=======
+
+.. toctree::
+   :maxdepth: 2
+
+   luckfox-pico
diff --git a/doc/board/luckfox/luckfox-pico.rst b/doc/board/luckfox/luckfox-pico.rst
new file mode 100644
index 00000000000..a971ee67e0b
--- /dev/null
+++ b/doc/board/luckfox/luckfox-pico.rst
@@ -0,0 +1,71 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Luckfox Pico boards
+===================
+
+U-Boot for the Luckfox Pico series of RV1103/RV1106 boards. Only the
+Pico Mini B (RV1103, 64MB DDR2, 128MB SPI NAND) is supported so far.
+
+Quick Start
+-----------
+
+- Get the DDR initialization binary
+- Build U-Boot
+- Boot the board over USB, or flash U-Boot into the SPI NAND
+
+Get the DDR initialization binary
+---------------------------------
+
+.. code-block:: bash
+
+   $ git clone https://github.com/rockchip-linux/rkbin.git
+
+The DDR initialization binary is at rkbin/bin/rv11/rv1106_ddr_924MHz_v1.15.bin
+and covers both the RV1103 and the RV1106.
+
+Build U-Boot
+------------
+
+.. code-block:: bash
+
+   $ export CROSS_COMPILE=arm-linux-gnueabihf-
+   $ export ROCKCHIP_TPL=<path-to-rkbin>/bin/rv11/rv1106_ddr_924MHz_v1.15.bin
+   $ make luckfox-pico-mini-b-rv1103_defconfig
+   $ make
+
+This produces idbloader.img and u-boot.img for flashing to the SPI
+NAND, plus u-boot-rockchip-usb471.bin and u-boot-rockchip-usb472.bin
+for booting over USB.
+
+Boot over USB (maskrom mode)
+----------------------------
+
+Hold the BOOT button while applying power (or leave the boot media
+blank) and the BootROM enters maskrom mode on the USB OTG port,
+appearing as USB ID 2207:110c. U-Boot then runs entirely from RAM;
+nothing is written to the flash.
+
+Send the two images with a maskrom download tool such as rockusb or
+rkdeveloptool (note that the loader format parser in older
+rkdeveloptool versions is not needed here, since these are raw
+images):
+
+.. code-block:: bash
+
+   $ rockusb download-boot u-boot-rockchip-usb471.bin u-boot-rockchip-usb472.bin
+
+Flash U-Boot into the SPI NAND
+------------------------------
+
+Enter maskrom mode as above, then use a loader from rkbin to run the
+Rockchip usbplug and write the images:
+
+.. code-block:: bash
+
+   $ cd <path-to-rkbin>
+   $ ./tools/boot_merger RKBOOT/RV1106MINIALL.ini
+   $ ./tools/upgrade_tool db rv1106_download_*.bin
+   $ ./tools/upgrade_tool wl 0x200 idbloader.img
+   $ ./tools/upgrade_tool wl 0xa00 u-boot.img
+
+Power cycle the board and U-Boot output appears on UART2 (115200,8N1).
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 2574a1da52c..532a13594fc 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -180,6 +180,10 @@ List of mainline supported Rockchip boards:
      - Yanyi Tech CoolPi CM5 EVB (coolpi-cm5-evb-rk3588)
      - Yanyi Tech CoolPi CM5 GenBook (coolpi-cm5-genbook-rk3588)
 
+* rv1103
+     - Luckfox Pico Mini B (luckfox-pico-mini-b-rv1103), see
+       :doc:`../luckfox/luckfox-pico`
+
 * rv1103b
      - Onion Omega4 (omega4-rv1103b), see :doc:`../onion/omega4-rv1103b`
 
diff --git a/include/configs/luckfox_pico.h b/include/configs/luckfox_pico.h
new file mode 100644
index 00000000000..107ab622dd5
--- /dev/null
+++ b/include/configs/luckfox_pico.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2026 Simon Glass <sjg@chromium.org>
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#include <configs/rv1106_common.h>
+
+#endif
-- 
2.43.0

