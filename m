Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA6BC197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 13:17:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A4DF874BF;
	Thu, 16 Nov 2023 14:17:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=conclusive.pl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=conclusive.pl header.i=@conclusive.pl header.b="AOC1SdMb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 706AF874BF; Thu, 16 Nov 2023 14:17:15 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46A4C8746A
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 14:17:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=conclusive.pl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=artur@conclusive.pl
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9c3aec5f326so394814966b.1
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 05:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=conclusive.pl; s=google; t=1700140623; x=1700745423; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L87QDYmS2j3Z8kWtK50JspTi5cto2YsdApraFEMKEbs=;
 b=AOC1SdMbqH85X+6U8leNevhTw4I9HXWqfhUIQbaVDD7fnNpDyut7T8aJ2zBdK5/XDZ
 v4Jj/aBisH9Vo+FlqSTIC6wIhQ/Dc87/tpKfa4M9lMiYgG/xQq8Eb09Era4LlPVKXWx9
 z2SOw9ahprZ4BwGZH6aWGp9IOQI1bqLHE6Aw7EWWSPEKqfDBG9ENQtcEy/ioibtct7iX
 WoE9F/7tCbfxLgYu9uYNHan7yBGp5q2npi+Yj5W/a46BUXMzeXrY7r+/5+QaNKOVIToU
 Pv1mCEW0h1xkcPsaQKivU2p8WRZwTk9Cx3Zhb3sW10Z9kW3OQHSDZCRUnCujU8wGJpy8
 ZUeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700140623; x=1700745423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L87QDYmS2j3Z8kWtK50JspTi5cto2YsdApraFEMKEbs=;
 b=ktoQfmRkQfyP2MhDhagtYvSITDlJe16gYEO1caT9cCS4YlDPtlVUOnM2aJd6lE+Qxa
 J9jkYnsNjSbQjr84d1QVm1pMPFAcK8Ox9xC2RmsA4Oyre3WrWwQMu7YjUEDWCtnHYXlB
 ifQZYkNqEL7FRkGAd19xL8KbFbp+npK6oDuZrti+QFKM3w45RllY+2c+xa8IsaD2g3GC
 rBk/zHVpSYn5Xljcj2hRASB3xep4wfDC9QcVjNj0LPWTxYZcdMJGgAyfbzgqt2c40OD7
 q99iFmD1YILmnHYE0/zg6ED97+Lw+oDj5MAki0JxsJkP4LLJgKG7jG1W1S33vuH3+ZDL
 qkAw==
X-Gm-Message-State: AOJu0YxqZHO8hl9aFhshKFLLyF7lILQir7qgZ0h6GVPh1/6RqATY8uwb
 EwfRUM+/Ic9cgXtJKoxo11x+KQ==
X-Google-Smtp-Source: AGHT+IEs5LZ/NxxwbR5eTnVsQF5Y+9Dd1mqQufVqUd4eNVTAmuveOhrl2KXpTfRb8tuJgNnxEifXEw==
X-Received: by 2002:a17:906:2358:b0:9ad:e62c:4517 with SMTP id
 m24-20020a170906235800b009ade62c4517mr1593184eja.34.1700140623381; 
 Thu, 16 Nov 2023 05:17:03 -0800 (PST)
Received: from localhost.localdomain (host-89.25.128.123.static.3s.pl.
 [89.25.128.123]) by smtp.gmail.com with ESMTPSA id
 h17-20020a1709063b5100b009e6e82939f9sm8347885ejf.26.2023.11.16.05.17.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 05:17:02 -0800 (PST)
From: Artur Rojek <artur@conclusive.pl>
To: Peng Fan <peng.fan@nxp.com>, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Simon Glass <sjg@chromium.org>, Jakub Klama <jakub@conclusive.pl>
Cc: Wojciech Kloska <wojciech@conclusive.pl>,
 =?UTF-8?q?Rados=C5=82aw=20Adamczyk?= <radoslaw.adamczyk@conclusive.pl>,
 u-boot@lists.denx.de, Artur Rojek <artur@conclusive.pl>
Subject: [PATCH 2/2] board: Add support for Conclusive WHLE-LS1046A
Date: Thu, 16 Nov 2023 14:16:30 +0100
Message-ID: <20231116131630.407502-3-artur@conclusive.pl>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231116131630.407502-1-artur@conclusive.pl>
References: <20231116131630.407502-1-artur@conclusive.pl>
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

Introduce support for Conclusive WHLE-LS1046A Single Board Computer.

Co-developed-by: Jakub Klama <jakub@conclusive.pl>
Signed-off-by: Jakub Klama <jakub@conclusive.pl>
Signed-off-by: Artur Rojek <artur@conclusive.pl>
---
 arch/arm/Kconfig                             |  19 ++
 arch/arm/dts/Makefile                        |   1 +
 arch/arm/dts/fsl-ls1046a-whle.dts            | 208 ++++++++++++++++++
 board/conclusive/whle-ls1046a/Kconfig        |  15 ++
 board/conclusive/whle-ls1046a/MAINTAINERS    |   9 +
 board/conclusive/whle-ls1046a/Makefile       |   7 +
 board/conclusive/whle-ls1046a/ddr.c          |  21 ++
 board/conclusive/whle-ls1046a/eth.c          |  64 ++++++
 board/conclusive/whle-ls1046a/whle-ls1046a.c | 218 +++++++++++++++++++
 configs/whle_ls1046a_emmc_defconfig          |  82 +++++++
 configs/whle_ls1046a_qspi_defconfig          |  83 +++++++
 include/configs/whle_ls1046a.h               |  90 ++++++++
 12 files changed, 817 insertions(+)
 create mode 100644 arch/arm/dts/fsl-ls1046a-whle.dts
 create mode 100644 board/conclusive/whle-ls1046a/Kconfig
 create mode 100644 board/conclusive/whle-ls1046a/MAINTAINERS
 create mode 100644 board/conclusive/whle-ls1046a/Makefile
 create mode 100644 board/conclusive/whle-ls1046a/ddr.c
 create mode 100644 board/conclusive/whle-ls1046a/eth.c
 create mode 100644 board/conclusive/whle-ls1046a/whle-ls1046a.c
 create mode 100644 configs/whle_ls1046a_emmc_defconfig
 create mode 100644 configs/whle_ls1046a_qspi_defconfig
 create mode 100644 include/configs/whle_ls1046a.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d812685c9842..609571e6e421 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1851,6 +1851,24 @@ config TARGET_SL28
 	help
 	  Support for Kontron SMARC-sAL28 board.
 
+config TARGET_WHLE_LS1046A
+	bool "Support Conclusive WHLE-LS1046A"
+	select ARCH_LS1046A
+	select ARM64
+	select ARMV8_MULTIENTRY
+	select ARCH_SUPPORT_TFABOOT
+	select BOARD_EARLY_INIT_F
+	select BOARD_LATE_INIT
+	select GPIO_EXTRA_HEADER
+	select DM_SPI_FLASH if DM_SPI
+	imply SCSI
+	help
+	  Support for Conclusive WHLE-LS1046A platform.
+	  The WHLE-LS1046A is a high-performance Single Board Computer with
+	  extensive connectivity features that supports the QorIQ LS1046A
+	  Layerscape Architecture processor:
+	  https://conclusive.tech/products/whle-ls1-sbc/
+
 config TARGET_TEN64
 	bool "Support ten64"
 	select ARCH_LS1088A
@@ -2299,6 +2317,7 @@ source "board/cortina/presidio-asic/Kconfig"
 source "board/broadcom/bcmns/Kconfig"
 source "board/broadcom/bcmns3/Kconfig"
 source "board/cavium/thunderx/Kconfig"
+source "board/conclusive/whle-ls1046a/Kconfig"
 source "board/eets/pdu001/Kconfig"
 source "board/emulation/qemu-arm/Kconfig"
 source "board/freescale/ls2080aqds/Kconfig"
diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 1be08c5fdc2e..8dcbf29df363 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -615,6 +615,7 @@ dtb-$(CONFIG_FSL_LSCH2) += fsl-ls1043a-qds-duart.dtb \
 	fsl-ls1046a-qds-lpuart.dtb \
 	fsl-ls1046a-rdb.dtb \
 	fsl-ls1046a-frwy.dtb \
+	fsl-ls1046a-whle.dtb \
 	fsl-ls1012a-qds.dtb \
 	fsl-ls1012a-rdb.dtb \
 	fsl-ls1012a-2g5rdb.dtb \
diff --git a/arch/arm/dts/fsl-ls1046a-whle.dts b/arch/arm/dts/fsl-ls1046a-whle.dts
new file mode 100644
index 000000000000..44188f16d739
--- /dev/null
+++ b/arch/arm/dts/fsl-ls1046a-whle.dts
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: GPL-2.0+ OR X11
+/*
+ * Copyright 2020-2023 Conclusive Engineering Sp. z o. o.
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+
+/dts-v1/;
+#include "fsl-ls1046a.dtsi"
+
+/ {
+	model = "Conclusive WHLE-LS1046A";
+	compatible = "conclusive,whle-ls1046a", "fsl,ls1046a";
+
+	chosen {
+		stdout-path = &duart0;
+	};
+
+	aliases {
+		spi0 = &qspi;
+	};
+};
+
+&soc {
+	pcie@3400000 {
+		status = "okay";
+	};
+};
+
+&qspi {
+	status = "okay";
+
+	gd25lq128: flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		spi-max-frequency = <50000000>;
+		reg = <0>;
+
+		partitions {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fixed-partitions";
+
+			partition@0 {
+				label = "bl2";
+				reg = <0 0x100000>;
+			};
+
+			partition@100000 {
+				label = "fip1";
+				reg = <0x100000 0x400000>;
+			};
+
+			partition@500000 {
+				label = "fip2";
+				reg = <0x500000 0x400000>;
+			};
+
+			partition@900000 {
+				label = "uboot-env";
+				reg = <0x900000 0x10000>;
+			};
+
+			partition@910000 {
+				label = "fman-firmware";
+				reg = <0x910000 0x200000>;
+			};
+
+			partition@a10000 {
+				label = "dtb";
+				reg = <0xa10000 0x10000>;
+			};
+		};
+	};
+};
+
+&i2c0 {
+	status = "okay";
+
+	spd@50 {
+		compatible = "spd";
+		reg = <0x50>;
+		status = "okay";
+	};
+
+	eeprom@56 {
+		compatible = "atmel,24c64";
+		reg = <0x56>;
+		status = "okay";
+	};
+
+	eeprom@57 {
+		compatible = "24c01";
+		reg = <0x57>;
+		status = "okay";
+	};
+
+	leds@62 {
+		compatible = "nxp,pca9633";
+		reg = <0x62>;
+		status = "okay";
+	};
+
+	rtc@6f {
+		compatible = "microchip,mcp7941x";
+		reg = <0x6f>;
+		status = "okay";
+	};
+};
+
+&i2c3 {
+	status = "okay";
+
+	i2c-mux@70 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "nxp,pca9546";
+		reg = <0x70>;
+		status = "okay";
+
+		pcie0_i2c: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		sfp0_i2c: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		sfp1_i2c: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		ext_i2c: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+	};
+};
+
+#include "fsl-ls1046-post.dtsi"
+
+&fman0 {
+	ethernet@e4000 {
+		phy-handle = <&rgmii_phy0>;
+		phy-connection-type = "rgmii-id";
+		status = "okay";
+	};
+
+	ethernet@e6000 {
+		phy-handle = <&rgmii_phy1>;
+		phy-connection-type = "rgmii-id";
+		status = "okay";
+	};
+
+	ethernet@e8000 {
+		phy-handle = <&sgmii_phy2>;
+		phy-connection-type = "sgmii";
+		status = "okay";
+	};
+
+	ethernet@ea000 {
+		phy-handle = <&sgmii_phy3>;
+		phy-connection-type = "sgmii";
+		status = "okay";
+	};
+
+	ethernet@f0000 { /* 10GEC1 */
+		fixed-link = <0 1 1000 0 0>;
+		phy-connection-type = "xgmii";
+		status = "okay";
+	};
+
+	ethernet@f2000 { /* 10GEC2 */
+		fixed-link = <0 1 1000 0 0>;
+		phy-connection-type = "xgmii";
+		status = "okay";
+	};
+
+	mdio@fc000 {
+		rgmii_phy0: ethernet-phy@1 {
+			reg = <0x1>;
+		};
+
+		rgmii_phy1: ethernet-phy@2 {
+			reg = <0x2>;
+		};
+
+		sgmii_phy2: ethernet-phy@3 {
+			reg = <0x3>;
+		};
+
+		sgmii_phy3: ethernet-phy@4 {
+			reg = <0x4>;
+		};
+	};
+};
+
+&duart0 {
+	status = "okay";
+};
diff --git a/board/conclusive/whle-ls1046a/Kconfig b/board/conclusive/whle-ls1046a/Kconfig
new file mode 100644
index 000000000000..5778fbd5cd22
--- /dev/null
+++ b/board/conclusive/whle-ls1046a/Kconfig
@@ -0,0 +1,15 @@
+if TARGET_WHLE_LS1046A
+
+config SYS_BOARD
+	default "whle-ls1046a"
+
+config SYS_VENDOR
+	default "conclusive"
+
+config SYS_SOC
+	default "fsl-layerscape"
+
+config SYS_CONFIG_NAME
+	default "whle_ls1046a"
+
+endif
diff --git a/board/conclusive/whle-ls1046a/MAINTAINERS b/board/conclusive/whle-ls1046a/MAINTAINERS
new file mode 100644
index 000000000000..1dcf067a06d8
--- /dev/null
+++ b/board/conclusive/whle-ls1046a/MAINTAINERS
@@ -0,0 +1,9 @@
+WHLE-LS1046A Board
+M:	Jakub Klama <jakub@conclusive.pl>
+M:	Artur Rojek <artur@conclusive.pl>
+S:	Maintained
+F:	board/conclusive/whle-ls1046a
+F:	include/configs/whle_ls1046a.h
+F:	configs/whle_ls1046a_emmc_defconfig
+F:	configs/whle_ls1046a_qspi_defconfig
+F:	arch/arm/dts/fsl-ls1046a-whle.dts
diff --git a/board/conclusive/whle-ls1046a/Makefile b/board/conclusive/whle-ls1046a/Makefile
new file mode 100644
index 000000000000..9197ec93a6de
--- /dev/null
+++ b/board/conclusive/whle-ls1046a/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright 2020-2023 Conclusive Engineering Sp. z o. o.
+
+obj-y += ddr.o
+obj-y += whle-ls1046a.o
+obj-$(CONFIG_NET) += eth.o
diff --git a/board/conclusive/whle-ls1046a/ddr.c b/board/conclusive/whle-ls1046a/ddr.c
new file mode 100644
index 000000000000..cbefc779d55d
--- /dev/null
+++ b/board/conclusive/whle-ls1046a/ddr.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2019 NXP
+ * Copyright 2020-2023 Conclusive Engineering Sp. z o. o.
+ */
+
+#include <config.h>
+#include <fsl_ddr_sdram.h>
+#include <asm/global_data.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int fsl_initdram(void)
+{
+	gd->ram_size = tfa_get_dram_size();
+
+	if (!gd->ram_size)
+		gd->ram_size = fsl_ddr_sdram_size();
+
+	return 0;
+}
diff --git a/board/conclusive/whle-ls1046a/eth.c b/board/conclusive/whle-ls1046a/eth.c
new file mode 100644
index 000000000000..492921166ebe
--- /dev/null
+++ b/board/conclusive/whle-ls1046a/eth.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2019 NXP
+ * Copyright 2020-2023 Conclusive Engineering Sp. z o. o.
+ */
+#include <config.h>
+#include <fdt_support.h>
+#include <net.h>
+#include <asm/io.h>
+#include <netdev.h>
+#include <fm_eth.h>
+#include <fsl_dtsec.h>
+#include <fsl_mdio.h>
+#include <malloc.h>
+
+int board_eth_init(struct bd_info *bis)
+{
+#ifdef CONFIG_FMAN_ENET
+	struct memac_mdio_info dtsec_mdio_info;
+	struct mii_dev *dev;
+	u32 srds_s1;
+	struct ccsr_gur *gur = (void *)(CFG_SYS_FSL_GUTS_ADDR);
+
+	srds_s1 = in_be32(&gur->rcwsr[4]) &
+			FSL_CHASSIS2_RCWSR4_SRDS1_PRTCL_MASK;
+	srds_s1 >>= FSL_CHASSIS2_RCWSR4_SRDS1_PRTCL_SHIFT;
+
+	if (srds_s1 != 0x1133 && srds_s1 != 0x3333) {
+		printf("Invalid SerDes protocol 0x%x for WHLE-LS1046A\n",
+		       srds_s1);
+	}
+
+	dtsec_mdio_info.regs =
+		(struct memac_mdio_controller *)CFG_SYS_FM1_DTSEC_MDIO_ADDR;
+
+	dtsec_mdio_info.name = DEFAULT_FM_MDIO_NAME;
+
+	/* Register the 1G MDIO bus */
+	fm_memac_mdio_init(bis, &dtsec_mdio_info);
+
+	/* RGMII on MAC 3 and 4, SGMII on MAC 5 and 6 */
+	fm_info_set_phy_address(FM1_DTSEC3, RGMII_PHY1_ADDR);
+	fm_info_set_phy_address(FM1_DTSEC4, RGMII_PHY2_ADDR);
+	fm_info_set_phy_address(FM1_DTSEC5, SGMII_PHY3_ADDR);
+	fm_info_set_phy_address(FM1_DTSEC6, SGMII_PHY4_ADDR);
+
+	dev = miiphy_get_dev_by_name(DEFAULT_FM_MDIO_NAME);
+	fm_info_set_mdio(FM1_DTSEC3, dev);
+	fm_info_set_mdio(FM1_DTSEC4, dev);
+	fm_info_set_mdio(FM1_DTSEC5, dev);
+	fm_info_set_mdio(FM1_DTSEC6, dev);
+
+	cpu_eth_init(bis);
+#endif
+
+	return pci_eth_init(bis);
+}
+
+#ifdef CONFIG_FMAN_ENET
+int fdt_update_ethernet_dt(void *blob)
+{
+	return 0;
+}
+#endif
diff --git a/board/conclusive/whle-ls1046a/whle-ls1046a.c b/board/conclusive/whle-ls1046a/whle-ls1046a.c
new file mode 100644
index 000000000000..74d1e5f01cc5
--- /dev/null
+++ b/board/conclusive/whle-ls1046a/whle-ls1046a.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * whle-ls1046a.c - Board init file for Conclusive WHLE-LS1046A board
+ * Copyright (C) 2020-2023 Conclusive Engineering Sp. z o. o.
+ */
+
+#include <config.h>
+#include <i2c.h>
+#include <fdt_support.h>
+#include <init.h>
+#include <env.h>
+#include <asm/io.h>
+#include <asm/arch/clock.h>
+#include <asm/arch/fsl_serdes.h>
+#include <asm/arch/soc.h>
+#include <asm/arch-fsl-layerscape/fsl_icid.h>
+#include <hwconfig.h>
+#include <ahci.h>
+#include <mmc.h>
+#include <scsi.h>
+#include <fm_eth.h>
+#include <fsl_csu.h>
+#include <fsl_esdhc.h>
+#include <fsl_sec.h>
+#include <fsl_dspi.h>
+
+#define	BOARD_REV_MASK	0x0f
+#define	SPI_MCR_REG	0x2100000
+
+DECLARE_GLOBAL_DATA_PTR;
+
+static inline void set_spi_cs_signal_inactive(void)
+{
+	/* default: all CS signals inactive state is high */
+	uint mcr_val;
+	uint mcr_cfg_val = DSPI_MCR_MSTR | DSPI_MCR_PCSIS_MASK |
+				DSPI_MCR_CRXF | DSPI_MCR_CTXF;
+
+	mcr_val = in_be32(SPI_MCR_REG);
+	mcr_val |= DSPI_MCR_HALT;
+	out_be32(SPI_MCR_REG, mcr_val);
+	out_be32(SPI_MCR_REG, mcr_cfg_val);
+	mcr_val = in_be32(SPI_MCR_REG);
+	mcr_val &= ~DSPI_MCR_HALT;
+	out_be32(SPI_MCR_REG, mcr_val);
+}
+
+int board_early_init_f(void)
+{
+	fsl_lsch2_early_init_f();
+
+	return 0;
+}
+
+static inline uint8_t get_board_version(void)
+{
+	struct ccsr_gur __iomem *gur = (void *)(CFG_SYS_FSL_GUTS_ADDR);
+
+	return in_be32(&gur->gpporcr1) & BOARD_REV_MASK;
+}
+
+static int settings_r(void)
+{
+	serial_read_from_eeprom(0);
+
+	return 0;
+}
+EVENT_SPY_SIMPLE(EVT_SETTINGS_R, settings_r);
+
+#if defined(CONFIG_DISPLAY_BOARDINFO_LATE)
+int checkboard(void)
+{
+	const char *serial_number = env_get("serial#");
+
+	printf("Board: WHLE-LS1046A, Rev: %s\n",
+	       get_board_version() == 0x00 ? "0" : "unknown");
+
+	if (!serial_number)
+		printf("Warning: unknown serial number.\n");
+	else
+		printf("S/N:   %s\n", serial_number);
+
+	return 0;
+}
+#endif
+
+static void board_retimer_init_rx(struct udevice *dev, int chnum)
+{
+	/* Select channel */
+	dm_i2c_reg_write(dev, 0xff, chnum);
+
+	/* Initialize receive channel */
+	dm_i2c_reg_clrset(dev, 0x00, 0x04, 0x04);
+	dm_i2c_reg_clrset(dev, 0x0a, 0x0c, 0x0c);
+	dm_i2c_reg_clrset(dev, 0x2f, 0xf0, 0xc0);
+	dm_i2c_reg_clrset(dev, 0x31, 0x60, 0x00);
+	dm_i2c_reg_clrset(dev, 0x03, 0xff, 0x00);
+	dm_i2c_reg_clrset(dev, 0x3a, 0xff, 0x00);
+	dm_i2c_reg_clrset(dev, 0x40, 0xff, 0x00);
+	dm_i2c_reg_clrset(dev, 0x1e, 0x08, 0x08);
+	dm_i2c_reg_clrset(dev, 0x2d, 0x08, 0x08);
+	dm_i2c_reg_clrset(dev, 0x2d, 0x07, 0x02);
+	dm_i2c_reg_clrset(dev, 0x15, 0x47, 0x00);
+	dm_i2c_reg_clrset(dev, 0x0a, 0x0c, 0x00);
+}
+
+static void board_retimer_init_tx(struct udevice *dev, int chnum)
+{
+	/* Select channel */
+	dm_i2c_reg_write(dev, 0xff, chnum);
+
+	/* Initialize transmit channel */
+	dm_i2c_reg_clrset(dev, 0x00, 0x04, 0x04);
+	dm_i2c_reg_clrset(dev, 0x0a, 0x0c, 0x0c);
+	dm_i2c_reg_clrset(dev, 0x2f, 0xf0, 0xc0);
+	dm_i2c_reg_clrset(dev, 0x31, 0x20, 0x20);
+	dm_i2c_reg_clrset(dev, 0x3a, 0xff, 0x00);
+	dm_i2c_reg_clrset(dev, 0x1e, 0x08, 0x08);
+	dm_i2c_reg_clrset(dev, 0x2d, 0x07, 0x00);
+	dm_i2c_reg_clrset(dev, 0x15, 0x47, 0x00);
+	dm_i2c_reg_clrset(dev, 0x0a, 0x0c, 0x00);
+}
+
+static void board_retimer_init(void)
+{
+	struct udevice *dev;
+
+	i2c_get_chip_for_busnum(I2C_RETIMER_BUS, I2C_RETIMER_ADDR, 1, &dev);
+	board_retimer_init_tx(dev, 0x04);
+	board_retimer_init_rx(dev, 0x05);
+	board_retimer_init_tx(dev, 0x06);
+	board_retimer_init_rx(dev, 0x07);
+}
+
+int board_init(void)
+{
+#ifdef CONFIG_NXP_ESBC
+	/*
+	 * In case of Secure Boot, the IBR configures the SMMU
+	 * to allow only Secure transactions.
+	 * SMMU must be reset in bypass mode.
+	 * Set the ClientPD bit and Clear the USFCFG Bit
+	 */
+	u32 val;
+
+	val = (in_le32(SMMU_SCR0) | SCR0_CLIENTPD_MASK) & ~(SCR0_USFCFG_MASK);
+	out_le32(SMMU_SCR0, val);
+	val = (in_le32(SMMU_NSCR0) | SCR0_CLIENTPD_MASK) & ~(SCR0_USFCFG_MASK);
+	out_le32(SMMU_NSCR0, val);
+#endif
+
+#ifdef CONFIG_FSL_CAAM
+	sec_init();
+#endif
+
+	board_retimer_init();
+	return 0;
+}
+
+int board_setup_core_volt(u32 vdd)
+{
+	return 0;
+}
+
+static void board_config_mux(void)
+{
+	struct ccsr_scfg *scfg = (struct ccsr_scfg *)CFG_SYS_FSL_SCFG_ADDR;
+	u32 usb_pwrfault;
+
+	/* Configure IRQ01 and IRQ02 lines polarity to negated */
+	out_be32(&scfg->intpcr, 0x60000000);
+
+	/*
+	 * IIC3 is used, configure mux to IIC3_SCL/IIC3/SDA
+	 * IIC4 is not used, configure mux to USB3_DRVVBUS/USB3_PWRFAULT
+	 */
+	out_be32(&scfg->rcwpmuxcr0, 0x0033);
+	out_be32(&scfg->usbdrvvbus_selcr, SCFG_USBDRVVBUS_SELCR_USB1);
+	usb_pwrfault =
+		(SCFG_USBPWRFAULT_DEDICATED << SCFG_USBPWRFAULT_USB3_SHIFT) |
+		(SCFG_USBPWRFAULT_SHARED << SCFG_USBPWRFAULT_USB2_SHIFT) |
+		(SCFG_USBPWRFAULT_SHARED << SCFG_USBPWRFAULT_USB1_SHIFT);
+	out_be32(&scfg->usbpwrfault_selcr, usb_pwrfault);
+	set_spi_cs_signal_inactive();
+}
+
+#ifdef CONFIG_MISC_INIT_R
+int misc_init_r(void)
+{
+	board_config_mux();
+	return 0;
+}
+#endif
+
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	u64 base[CONFIG_NR_DRAM_BANKS];
+	u64 size[CONFIG_NR_DRAM_BANKS];
+
+	/* fixup DT for the two DDR banks */
+	base[0] = gd->bd->bi_dram[0].start;
+	size[0] = gd->bd->bi_dram[0].size;
+	base[1] = gd->bd->bi_dram[1].start;
+	size[1] = gd->bd->bi_dram[1].size;
+
+	fdt_fixup_memory_banks(blob, base, size, 2);
+	ft_cpu_setup(blob, bd);
+
+#ifdef CONFIG_SYS_DPAA_FMAN
+#ifndef CONFIG_DM_ETH
+	fdt_fixup_fman_ethernet(blob);
+#endif
+#endif
+
+	fdt_fixup_icid(blob);
+
+	return 0;
+}
diff --git a/configs/whle_ls1046a_emmc_defconfig b/configs/whle_ls1046a_emmc_defconfig
new file mode 100644
index 000000000000..1d20d6ad9165
--- /dev/null
+++ b/configs/whle_ls1046a_emmc_defconfig
@@ -0,0 +1,82 @@
+CONFIG_ARM=y
+CONFIG_TARGET_WHLE_LS1046A=y
+CONFIG_TFABOOT=y
+CONFIG_TEXT_BASE=0x82000000
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_ENV_SIZE=0x2000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="fsl-ls1046a-whle"
+CONFIG_QSPI_AHB_INIT=y
+CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT=y
+CONFIG_SEC_FIRMWARE_ARMV8_PSCI=y
+CONFIG_PCI=y
+CONFIG_AHCI=y
+CONFIG_MP=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTSTD_FULL=y
+CONFIG_BOOTSTD_DEFAULTS=y
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_USE_BOOTARGS=y
+CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/mmcblk0p1 earlycon=uart8250,mmio,0x21c0500"
+# CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_MISC_INIT_R=y
+CONFIG_CMD_TLV_EEPROM=y
+CONFIG_CMD_BOOTMENU=y
+CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=5
+CONFIG_CMD_DM=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_MTDPARTS_DEFAULT="mtdparts="
+CONFIG_OF_CONTROL=y
+CONFIG_ENV_IS_IN_EXT4=y
+CONFIG_ENV_EXT4_INTERFACE="mmc"
+CONFIG_ENV_EXT4_DEVICE_AND_PART="0:1"
+CONFIG_ENV_EXT4_FILE="/boot/uboot.env"
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_USE_ETHPRIME=y
+CONFIG_ETHPRIME="fm1-mac3"
+CONFIG_FSL_CAAM=y
+CONFIG_MPC8XXX_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
+CONFIG_I2C_MUX=y
+CONFIG_I2C_MUX_PCA954x=y
+CONFIG_I2C_EEPROM=y
+CONFIG_FSL_ESDHC=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_MTD_SPI_NAND=y
+CONFIG_SPI_FLASH_GIGADEVICE=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_PHYLIB=y
+CONFIG_PHY_REALTEK=y
+CONFIG_PHY_FIXED=y
+CONFIG_DM_MDIO=y
+CONFIG_PHY_GIGE=y
+CONFIG_E1000=y
+CONFIG_FMAN_ENET=y
+CONFIG_SYS_FMAN_FW_ADDR=0x900000
+CONFIG_NVME_PCI=y
+CONFIG_DM_PCI_COMPAT=y
+CONFIG_PCIE_LAYERSCAPE_RC=y
+CONFIG_SYS_QE_FMAN_FW_IN_MMC=y
+CONFIG_DM_SCSI=y
+CONFIG_SPECIFY_CONSOLE_INDEX=y
+CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_FSL_QSPI=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
diff --git a/configs/whle_ls1046a_qspi_defconfig b/configs/whle_ls1046a_qspi_defconfig
new file mode 100644
index 000000000000..c8aed6492572
--- /dev/null
+++ b/configs/whle_ls1046a_qspi_defconfig
@@ -0,0 +1,83 @@
+CONFIG_ARM=y
+CONFIG_TARGET_WHLE_LS1046A=y
+CONFIG_TFABOOT=y
+CONFIG_TEXT_BASE=0x82000000
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_ENV_SIZE=0x10000
+CONFIG_ENV_OFFSET=0x900000
+CONFIG_ENV_SECT_SIZE=0x1000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="fsl-ls1046a-whle"
+CONFIG_QSPI_AHB_INIT=y
+CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT=y
+CONFIG_SEC_FIRMWARE_ARMV8_PSCI=y
+CONFIG_PCI=y
+CONFIG_AHCI=y
+CONFIG_MP=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTSTD_FULL=y
+CONFIG_BOOTSTD_DEFAULTS=y
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_USE_BOOTARGS=y
+CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/mmcblk0p1 earlycon=uart8250,mmio,0x21c0500"
+CONFIG_BOOTCOMMAND="sf probe; mtd read dtb $fdt_addr_r; bootflow scan -lb"
+# CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_MISC_INIT_R=y
+CONFIG_CMD_TLV_EEPROM=y
+CONFIG_CMD_BOOTMENU=y
+CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=5
+CONFIG_CMD_DM=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_MTDPARTS_DEFAULT="mtdparts="
+CONFIG_OF_CONTROL=y
+CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_ENV_SECT_SIZE_AUTO=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_USE_ETHPRIME=y
+CONFIG_ETHPRIME="fm1-mac3"
+CONFIG_FSL_CAAM=y
+CONFIG_MPC8XXX_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
+CONFIG_I2C_MUX=y
+CONFIG_I2C_MUX_PCA954x=y
+CONFIG_I2C_EEPROM=y
+CONFIG_FSL_ESDHC=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_MTD_SPI_NAND=y
+CONFIG_SPI_FLASH_GIGADEVICE=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_PHYLIB=y
+CONFIG_PHY_REALTEK=y
+CONFIG_PHY_FIXED=y
+CONFIG_DM_MDIO=y
+CONFIG_PHY_GIGE=y
+CONFIG_E1000=y
+CONFIG_FMAN_ENET=y
+CONFIG_SYS_FMAN_FW_ADDR=0x910000
+CONFIG_NVME_PCI=y
+CONFIG_DM_PCI_COMPAT=y
+CONFIG_PCIE_LAYERSCAPE_RC=y
+CONFIG_SYS_QE_FMAN_FW_IN_SPIFLASH=y
+CONFIG_DM_SCSI=y
+CONFIG_SPECIFY_CONSOLE_INDEX=y
+CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_FSL_QSPI=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
diff --git a/include/configs/whle_ls1046a.h b/include/configs/whle_ls1046a.h
new file mode 100644
index 000000000000..982bf71be515
--- /dev/null
+++ b/include/configs/whle_ls1046a.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2019-2020 NXP
+ * Copyright 2020-2023 Conclusive Engineering Sp. z o. o.
+ */
+
+#ifndef __WHLE_LS1046A_H__
+#define __WHLE_LS1046A_H__
+
+#include <asm/arch/config.h>
+#include <asm/arch/stream_id_lsch2.h>
+
+#define CFG_SYS_FSL_QSPI_BASE			0x40000000
+#define CFG_SYS_UBOOT_BASE			0x40100000
+#define CFG_SYS_DDR_SDRAM_BASE			0x80000000
+#define CFG_SYS_FSL_DDR_SDRAM_BASE_PHY		0
+#define CFG_SYS_SDRAM_BASE			CFG_SYS_DDR_SDRAM_BASE
+#define CFG_SYS_DDR_BLOCK2_BASE			0x880000000ULL
+#define CPU_RELEASE_ADDR			secondary_boot_addr
+
+/* Generic Timer Definitions */
+#define COUNTER_FREQUENCY			25000000 /* 25MHz */
+
+/* Serial Port */
+#define CFG_SYS_NS16550_CLK			(get_serial_clock())
+
+/* Miscellaneous configurable options */
+#define HWCONFIG_BUFFER_SIZE			128
+
+/* EEPROM */
+#define I2C_RETIMER_ADDR			0x18
+
+/* I2C bus multiplexer */
+#define I2C_MUX_PCA_ADDR_PRI			0x77 /* Primary Mux*/
+#define I2C_MUX_CH_DEFAULT			0x1 /* Channel 0*/
+#define I2C_MUX_CH_RTC				0x1 /* Channel 0*/
+
+/* Retimer */
+#define I2C_RETIMER_BUS				0
+#define I2C_RETIMER_ADDR			0x18
+
+/* RTC */
+#define RTC
+#define CFG_SYS_I2C_RTC_ADDR			0x51  /* Channel 0 I2C bus 0*/
+#define CFG_SYS_RTC_BUS_NUM			0
+
+#define BOOT_TARGET_DEVICES(func) \
+	func(SCSI, scsi, 0) \
+	func(MMC, mmc, 0) \
+	func(USB, usb, 0) \
+	func(DHCP, dhcp, na)
+
+#include <config_distro_bootcmd.h>
+
+/* FMan */
+#ifdef CONFIG_FMAN_ENET
+#define CFG_SYS_FM_MURAM_SIZE			0x60000
+#define CFG_SYS_QE_FMAN_FW_LENGTH		0x10000
+#define RGMII_PHY1_ADDR				0x01
+#define RGMII_PHY2_ADDR				0x02
+#define SGMII_PHY3_ADDR				0x03
+#define SGMII_PHY4_ADDR				0x04
+#define FDT_SEQ_MACADDR_FROM_ENV
+#endif
+
+#define QSPI_NOR_BOOTCOMMAND	CONFIG_BOOTCOMMAND
+#define QSPI_NAND_BOOTCOMMAND	CONFIG_BOOTCOMMAND
+#define SD_BOOTCOMMAND		CONFIG_BOOTCOMMAND
+
+#undef CFG_EXTRA_ENV_SETTINGS
+#define CFG_EXTRA_ENV_SETTINGS		\
+	"hwconfig=fsl_ddr:bank_intlv=auto\0"	\
+	"kernel_addr_r=0x81000000\0"		\
+	"kernel_size=0x07000000\0"		\
+	"kernel_comp_addr_r=0x88000000\0"	\
+	"kernel_comp_size=0x04000000\0"		\
+	"ramdisk_addr_r=0x90000000\0"		\
+	"ramdisk_size=0x08000000\0"		\
+	"fdt_addr_r=0x98000000\0"		\
+	"pxefile_addr_r=0x99000000\0"		\
+	"scriptaddr=0x9a000000\0"		\
+	"fdtfile=fsl-ls1046a-whle.dtb\0"	\
+	"console=ttyS0,115200\0"                \
+	CONFIG_MTDPARTS_DEFAULT "\0"		\
+	BOOTENV
+
+#include <asm/fsl_secure_boot.h>
+#include <asm/arch/soc.h>
+
+#endif /* __WHLE_LS1046A_H__ */
-- 
2.42.1

