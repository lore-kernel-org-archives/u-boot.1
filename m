Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40BDBCD342C
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 12:37:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8428984948;
	Wed,  6 May 2026 14:36:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="qFaBmtef";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1B11848A1; Wed,  6 May 2026 14:36:31 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 362C484949
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 14:36:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 08BF3442F7;
 Wed,  6 May 2026 12:36:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245D0C2BCB8;
 Wed,  6 May 2026 12:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778070987;
 bh=e6h2lUfl/yNuWQorIIWGpQxRp5IMe1bE99MboCwdsjY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qFaBmtefxMnM7zKHqMysekjqIBlGoyk3h9j8cRiyj+xPYcBm/YtHhYuglVV4KE0Q7
 S2H5RjNr3wsQAioKlcky2oYrQfMdBgA9CptDTjosY4dt5Re83efc+jJoYqcw7MggfJ
 EpEBTTuFqgxT41eceJyFlLGQoRyEZvnwG+goyYXFPhIwjIlECFgzREWDVueVsS7+9M
 BkLMOfrCSFGDAPcIw7rTSNFr7r7dau4Bk+IiX2iQQ1v07dU9t+jkfEMufskTwhERNH
 cPhmzcbdRqqyCnWhkIrDb4/Wpa0SyHFpOhDMnUZs078IjTrKfhzIwBHYUOIIKoVD8O
 qpPcsFfPgg1Pw==
From: Michael Walle <mwalle@kernel.org>
To: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Tom Rini <trini@konsulko.com>, Pramod Kumar <pramod.kumar_1@nxp.com>,
 Vladimir Oltean <olteanv@gmail.com>, Alison Wang <alison.wang@nxp.com>,
 Tang Yuantian <andy.tang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 TsiChung Liew <Tsi-Chung.Liew@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Shengzhou Liu <Shengzhou.Liu@nxp.com>
Cc: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>,
 Jerome Forissier <jerome.forissier@arm.com>, u-boot@lists.denx.de,
 Michael Walle <mwalle@kernel.org>
Subject: [PATCH v2 07/11] p2041rdb: use the upstream device tree
Date: Wed,  6 May 2026 14:34:16 +0200
Message-ID: <20260506123507.2081751-8-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260506123507.2081751-1-mwalle@kernel.org>
References: <20260506123507.2081751-1-mwalle@kernel.org>
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

Switch to the upstream device tree, which already includes the UART
nodes we need for the DM.

We also need to increase malloc area before relocation otherwise you'll
get the following error and the board panics:

	DRAM:  Initializing....using SPD
	alloc space exhausted ptr 414 limit 400

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 arch/powerpc/dts/Makefile             |   1 -
 arch/powerpc/dts/p2041.dtsi           | 138 --------------------------
 arch/powerpc/dts/p2041rdb-u-boot.dtsi |  19 ++++
 arch/powerpc/dts/p2041rdb.dts         | 127 ------------------------
 arch/powerpc/dts/p2041si-post.dtsi    |  43 --------
 configs/P2041RDB_SPIFLASH_defconfig   |   4 +-
 configs/P2041RDB_defconfig            |   4 +-
 include/configs/P2041RDB.h            |   2 +
 8 files changed, 27 insertions(+), 311 deletions(-)
 delete mode 100644 arch/powerpc/dts/p2041.dtsi
 create mode 100644 arch/powerpc/dts/p2041rdb-u-boot.dtsi
 delete mode 100644 arch/powerpc/dts/p2041rdb.dts
 delete mode 100644 arch/powerpc/dts/p2041si-post.dtsi

diff --git a/arch/powerpc/dts/Makefile b/arch/powerpc/dts/Makefile
index 766b0c05951..4fd3478ac2f 100644
--- a/arch/powerpc/dts/Makefile
+++ b/arch/powerpc/dts/Makefile
@@ -14,7 +14,6 @@ dtb-$(CONFIG_TARGET_P1010RDB_PB) += p1010rdb-pb.dtb p1010rdb-pb_36b.dtb
 dtb-$(CONFIG_TARGET_P1020RDB_PC) += p1020rdb-pc.dtb p1020rdb-pc_36b.dtb
 dtb-$(CONFIG_TARGET_P1020RDB_PD) += p1020rdb-pd.dtb
 dtb-$(CONFIG_TARGET_P2020RDB) += p2020rdb-pc.dtb p2020rdb-pc_36b.dtb
-dtb-$(CONFIG_TARGET_P2041RDB) += p2041rdb.dtb
 dtb-$(CONFIG_TARGET_P3041DS) += p3041ds.dtb
 dtb-$(CONFIG_TARGET_P4080DS) += p4080ds.dtb
 dtb-$(CONFIG_TARGET_P5040DS) += p5040ds.dtb
diff --git a/arch/powerpc/dts/p2041.dtsi b/arch/powerpc/dts/p2041.dtsi
deleted file mode 100644
index ad09b138fc8..00000000000
--- a/arch/powerpc/dts/p2041.dtsi
+++ /dev/null
@@ -1,138 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+ OR X11
-/*
- * P2041 Silicon/SoC Device Tree Source (pre include)
- *
- * Copyright 2011 - 2015 Freescale Semiconductor Inc.
- * Copyright 2019-2020 NXP
- */
-
-/dts-v1/;
-
-/include/ "e500mc_power_isa.dtsi"
-
-/ {
-	compatible = "fsl,P2041";
-	#address-cells = <2>;
-	#size-cells = <2>;
-	interrupt-parent = <&mpic>;
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cpu0: PowerPC,e500mc@0 {
-			device_type = "cpu";
-			reg = <0>;
-			fsl,portid-mapping = <0x80000000>;
-		};
-		cpu1: PowerPC,e500mc@1 {
-			device_type = "cpu";
-			reg = <1>;
-			fsl,portid-mapping = <0x40000000>;
-		};
-		cpu2: PowerPC,e500mc@2 {
-			device_type = "cpu";
-			reg = <2>;
-			fsl,portid-mapping = <0x20000000>;
-		};
-		cpu3: PowerPC,e500mc@3 {
-			device_type = "cpu";
-			reg = <3>;
-			fsl,portid-mapping = <0x10000000>;
-		};
-	};
-
-	soc: soc@ffe000000 {
-		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
-		reg = <0xf 0xfe000000 0 0x00001000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		device_type = "soc";
-		compatible = "simple-bus";
-
-		mpic: pic@40000 {
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <4>;
-			reg = <0x40000 0x40000>;
-			compatible = "fsl,mpic", "chrp,open-pic";
-			device_type = "open-pic";
-			clock-frequency = <0x0>;
-		};
-
-		espi0: spi@110000 {
-			compatible = "fsl,mpc8536-espi";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0x110000 0x1000>;
-			fsl,espi-num-chipselects = <4>;
-			status = "disabled";
-		};
-
-		usb0: usb@210000 {
-			compatible = "fsl-usb2-mph";
-			reg = <0x210000 0x1000>;
-			phy_type = "utmi";
-		};
-
-		usb1: usb@211000 {
-			compatible = "fsl-usb2-mph";
-			reg = <0x210000 0x1000>;
-			phy_type = "utmi";
-		};
-
-		sata: sata@220000 {
-			compatible = "fsl,pq-sata-v2";
-			reg = <0x220000 0x1000>;
-			interrupts = <68 0x2 0 0>;
-			sata-offset = <0x1000>;
-			sata-number = <2>;
-			sata-fpdma = <0>;
-		};
-
-		esdhc: esdhc@114000 {
-			compatible = "fsl,esdhc";
-			reg = <0x114000 0x1000>;
-			clock-frequency = <0>;
-		};
-
-		/include/ "qoriq-i2c-0.dtsi"
-		/include/ "qoriq-i2c-1.dtsi"
-	};
-
-	pcie@ffe200000 {
-		compatible = "fsl,pcie-p2041", "fsl,pcie-fsl-qoriq";
-		reg = <0xf 0xfe200000 0x0 0x1000>;   /* registers */
-		law_trgt_if = <0>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-		device_type = "pci";
-		bus-range = <0x0 0xff>;
-		ranges = <0x01000000 0x0 0x00000000 0xf 0xf8000000 0x0 0x00010000   /* downstream I/O */
-			  0x02000000 0x0 0xe0000000 0xc 0x00000000 0x0 0x20000000>; /* non-prefetchable memory */
-	};
-
-	pcie@ffe201000 {
-		compatible = "fsl,pcie-p2041", "fsl,pcie-fsl-qoriq";
-		reg = <0xf 0xfe201000 0x0 0x1000>;   /* registers */
-		law_trgt_if = <1>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-		device_type = "pci";
-		bus-range = <0x0 0xff>;
-		ranges = <0x01000000 0x0 0x00000000 0xf 0xf8010000 0x0 0x00010000   /* downstream I/O */
-			  0x02000000 0x0 0xe0000000 0xc 0x20000000 0x0 0x20000000>; /* non-prefetchable memory */
-	};
-
-	pcie@ffe202000 {
-		compatible = "fsl,pcie-p2041", "fsl,pcie-fsl-qoriq";
-		reg = <0xf 0xfe202000 0x0 0x1000>;   /* registers */
-		law_trgt_if = <2>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-		device_type = "pci";
-		bus-range = <0x0 0xff>;
-		ranges = <0x01000000 0x0 0x00000000 0xf 0xf8020000 0x0 0x00010000   /* downstream I/O */
-			  0x02000000 0x0 0xe0000000 0xc 0x40000000 0x0 0x20000000>; /* non-prefetchable memory */
-	};
-};
diff --git a/arch/powerpc/dts/p2041rdb-u-boot.dtsi b/arch/powerpc/dts/p2041rdb-u-boot.dtsi
new file mode 100644
index 00000000000..1dc83cf846b
--- /dev/null
+++ b/arch/powerpc/dts/p2041rdb-u-boot.dtsi
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+&serial0 {
+	bootph-all;
+};
+
+&soc {
+	i2c@118000 {
+		bootph-all;
+	};
+
+	spi@110000 {
+		flash@0 {
+			spi-max-frequency = <10000000>;
+		};
+	};
+};
+
+#include "u-boot.dtsi"
diff --git a/arch/powerpc/dts/p2041rdb.dts b/arch/powerpc/dts/p2041rdb.dts
deleted file mode 100644
index 0fa1f098524..00000000000
--- a/arch/powerpc/dts/p2041rdb.dts
+++ /dev/null
@@ -1,127 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+ OR X11
-/*
- * P2041RDB Device Tree Source
- *
- * Copyright 2011 - 2015 Freescale Semiconductor Inc.
- * Copyright 2019-2020 NXP
- */
-
-/include/ "p2041.dtsi"
-
-/ {
-	model = "fsl,P2041RDB";
-	compatible = "fsl,P2041RDB";
-	#address-cells = <2>;
-	#size-cells = <2>;
-	interrupt-parent = <&mpic>;
-
-	aliases {
-		phy_rgmii_0 = &phy_rgmii_0;
-		phy_rgmii_1 = &phy_rgmii_1;
-		phy_sgmii_2 = &phy_sgmii_2;
-		phy_sgmii_3 = &phy_sgmii_3;
-		phy_sgmii_4 = &phy_sgmii_4;
-		phy_sgmii_1c = &phy_sgmii_1c;
-		phy_sgmii_1d = &phy_sgmii_1d;
-		phy_sgmii_1e = &phy_sgmii_1e;
-		phy_sgmii_1f = &phy_sgmii_1f;
-		phy_xgmii_2 = &phy_xgmii_2;
-		spi0 = &espi0;
-	};
-
-	soc: soc@ffe000000 {
-		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
-		reg = <0xf 0xfe000000 0 0x00001000>;
-
-		fman@400000 {
-			ethernet@e0000 {
-				phy-handle = <&phy_sgmii_2>;
-				phy-connection-type = "sgmii";
-			};
-
-			mdio@e1120 {
-				phy_rgmii_0: ethernet-phy@0 {
-					reg = <0x0>;
-				};
-
-				phy_rgmii_1: ethernet-phy@1 {
-					reg = <0x1>;
-				};
-
-				phy_sgmii_2: ethernet-phy@2 {
-					reg = <0x2>;
-				};
-
-				phy_sgmii_3: ethernet-phy@3 {
-					reg = <0x3>;
-				};
-
-				phy_sgmii_4: ethernet-phy@4 {
-					reg = <0x4>;
-				};
-
-				phy_sgmii_1c: ethernet-phy@1c {
-					reg = <0x1c>;
-				};
-
-				phy_sgmii_1d: ethernet-phy@1d {
-					reg = <0x1d>;
-				};
-
-				phy_sgmii_1e: ethernet-phy@1e {
-					reg = <0x1e>;
-				};
-
-				phy_sgmii_1f: ethernet-phy@1f {
-					reg = <0x1f>;
-				};
-			};
-
-			ethernet@e2000 {
-				phy-handle = <&phy_sgmii_3>;
-				phy-connection-type = "sgmii";
-			};
-
-			ethernet@e4000 {
-				phy-handle = <&phy_sgmii_4>;
-				phy-connection-type = "sgmii";
-			};
-
-			ethernet@e6000 {
-				phy-handle = <&phy_rgmii_1>;
-				phy-connection-type = "rgmii";
-			};
-
-			ethernet@e8000 {
-				phy-handle = <&phy_rgmii_0>;
-				phy-connection-type = "rgmii";
-			};
-
-			ethernet@f0000 {
-				phy-handle = <&phy_xgmii_2>;
-				phy-connection-type = "xgmii";
-			};
-
-			mdio@f1000 {
-				phy_xgmii_2: ethernet-phy@0 {
-					compatible = "ethernet-phy-ieee802.3-c45";
-					reg = <0x0>;
-				};
-			};
-		};
-	};
-};
-
-&espi0 {
-	status = "okay";
-	flash@0 {
-		compatible = "jedec,spi-nor";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		reg = <0>;
-		/* input clock */
-		spi-max-frequency = <10000000>;
-	};
-};
-
-/include/ "p2041si-post.dtsi"
diff --git a/arch/powerpc/dts/p2041si-post.dtsi b/arch/powerpc/dts/p2041si-post.dtsi
deleted file mode 100644
index 8819199646f..00000000000
--- a/arch/powerpc/dts/p2041si-post.dtsi
+++ /dev/null
@@ -1,43 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
-/*
- * P2041/P2040 Silicon/SoC Device Tree Source (post include)
- *
- * Copyright 2011 - 2015 Freescale Semiconductor Inc.
- * Copyright 2020 NXP
- *
- */
-
-&soc {
-
-/include/ "qoriq-clockgen1.dtsi"
-/include/ "qoriq-gpio-0.dtsi"
-/include/ "qoriq-sec4.2-0.dtsi"
-
-/* include used FMan blocks */
-/include/ "qoriq-fman-0.dtsi"
-/include/ "qoriq-fman-0-1g-0.dtsi"
-/include/ "qoriq-fman-0-1g-1.dtsi"
-/include/ "qoriq-fman-0-1g-2.dtsi"
-/include/ "qoriq-fman-0-1g-3.dtsi"
-/include/ "qoriq-fman-0-1g-4.dtsi"
-/include/ "qoriq-fman-0-10g-0.dtsi"
-	fman@400000 {
-		enet0: ethernet@e0000 {
-		};
-
-		enet1: ethernet@e2000 {
-		};
-
-		enet2: ethernet@e4000 {
-		};
-
-		enet3: ethernet@e6000 {
-		};
-
-		enet4: ethernet@e8000 {
-		};
-
-		enet5: ethernet@f0000 {
-		};
-	};
-};
diff --git a/configs/P2041RDB_SPIFLASH_defconfig b/configs/P2041RDB_SPIFLASH_defconfig
index 1b7389178be..465b3ee7dc7 100644
--- a/configs/P2041RDB_SPIFLASH_defconfig
+++ b/configs/P2041RDB_SPIFLASH_defconfig
@@ -1,11 +1,12 @@
 CONFIG_PPC=y
 CONFIG_TEXT_BASE=0xFFF40000
 CONFIG_SYS_MALLOC_LEN=0x100000
+CONFIG_SYS_MALLOC_F_LEN=0x600
 CONFIG_SF_DEFAULT_SPEED=10000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0x100000
 CONFIG_ENV_SECT_SIZE=0x10000
-CONFIG_DEFAULT_DEVICE_TREE="p2041rdb"
+CONFIG_DEFAULT_DEVICE_TREE="fsl/p2041rdb"
 CONFIG_SYS_MONITOR_LEN=786432
 CONFIG_MPC85xx=y
 CONFIG_SYS_INIT_RAM_LOCK=y
@@ -56,6 +57,7 @@ CONFIG_CMD_PING=y
 CONFIG_CMD_EXT2=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
+CONFIG_OF_UPSTREAM=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/P2041RDB_defconfig b/configs/P2041RDB_defconfig
index b6c28db4f10..9c3e95093bf 100644
--- a/configs/P2041RDB_defconfig
+++ b/configs/P2041RDB_defconfig
@@ -1,10 +1,11 @@
 CONFIG_PPC=y
 CONFIG_TEXT_BASE=0xEFF40000
 CONFIG_SYS_MALLOC_LEN=0x100000
+CONFIG_SYS_MALLOC_F_LEN=0x600
 CONFIG_SF_DEFAULT_SPEED=10000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_SECT_SIZE=0x20000
-CONFIG_DEFAULT_DEVICE_TREE="p2041rdb"
+CONFIG_DEFAULT_DEVICE_TREE="fsl/p2041rdb"
 CONFIG_SYS_MONITOR_LEN=786432
 CONFIG_ENV_ADDR=0xEFF20000
 CONFIG_MPC85xx=y
@@ -52,6 +53,7 @@ CONFIG_CMD_PING=y
 CONFIG_CMD_EXT2=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
+CONFIG_OF_UPSTREAM=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_FLASH=y
 CONFIG_USE_BOOTFILE=y
diff --git a/include/configs/P2041RDB.h b/include/configs/P2041RDB.h
index f88fb9cdb9a..3525e29acc4 100644
--- a/include/configs/P2041RDB.h
+++ b/include/configs/P2041RDB.h
@@ -149,6 +149,8 @@
  * shorted - index 1
  */
 
+#define CFG_SYS_NS16550_CLK          (get_bus_freq(0) / 2)
+
 #define CFG_SYS_BAUDRATE_TABLE	\
 	{300, 600, 1200, 2400, 4800, 9600, 19200, 38400, 57600, 115200}
 
-- 
2.47.3

