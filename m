Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A76FC25B77
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 12:50:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82B3388496;
	Fri, 17 May 2024 14:50:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="MKVnN482";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9664B88491; Fri, 17 May 2024 07:27:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 112BD882D9
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 07:27:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tingting.meng@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715923657; x=1747459657;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kS5WEPKBMPi3jyjTEBadxfZNfAHl5+3GPJAo4n+R58s=;
 b=MKVnN482jTiBAyOT046j0dYmmKSED0Mk60G4Bf8ULs7ga7wgFgOQCYgs
 1BVbAUAD2uTXep/9X3jAGDEbi2r/Lf41CvR7+/cQpA1Htgb5PDoTLGmEI
 inXJuwlO55Lg8z2zD1kq/5SqlrRWrGp8B3RuZyPtXtcdJFKd77EFF1tJU
 tYR+c9F2zRUy3Q6am8nArImEkBsgdK/2mp9sztTUb1bDL8m9Z10SgDgCN
 NKR8f5XQLoCRsgt3o43frwI+boHmtK3J6mYmpcuOqTT3HZwKnhCxBMFRP
 Qf6E7hISeU+jzKsQDoBrUzHFqjcx+siw8XyiLx6zwbV9OTc/yKy1EbReS A==;
X-CSE-ConnectionGUID: BY+4cJFyR/SDO6+skzFbJg==
X-CSE-MsgGUID: 7tZNiHYmRLaSWzhuhk9aSA==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11929925"
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; d="scan'208";a="11929925"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2024 22:27:34 -0700
X-CSE-ConnectionGUID: oO+w8iW4TbOJsOTo7c0VnA==
X-CSE-MsgGUID: 4E4bZKq2QamiVaLm1/wWyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; d="scan'208";a="36188217"
Received: from pglc00543.png.intel.com ([10.221.239.235])
 by fmviesa003.fm.intel.com with ESMTP; 16 May 2024 22:27:30 -0700
From: tingting.meng@intel.com
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Marek <marex@denx.de>,
 Simon <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>,
 Dinesh <dinesh.maniyam@intel.com>, Boon Khai <boon.khai.ng@intel.com>,
 Alif <alif.zakuan.yuslaimi@intel.com>,
 Teik Heng <teik.heng.chong@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>,
 Wan Yee Lau <wan.yee.lau@intel.com>,
 Tingting Meng <tingting.meng@intel.com>
Subject: [Agilex7 M-series Platform Enablement v1 01/16] arch: arm: dts: Add
 dts and dtsi for new platform Agilex7 M-series
Date: Fri, 17 May 2024 13:26:46 +0800
Message-Id: <20240517052701.12949-2-tingting.meng@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240517052701.12949-1-tingting.meng@intel.com>
References: <20240517052701.12949-1-tingting.meng@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 17 May 2024 14:50:41 +0200
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

From: Wan Yee Lau <wan.yee.lau@intel.com>

Add Agilex7 M-series dtsi and dts for new platform Agilex7 M-series.

Signed-off-by: Wan Yee Lau <wan.yee.lau@intel.com>
Signed-off-by: Teik Heng Chong <teik.heng.chong@intel.com>
Signed-off-by: Tingting Meng <tingting.meng@intel.com>
---
 ...tsi => socfpga_agilex7m_socdk-u-boot.dtsi} |  37 ++++-
 ...x_socdk.dts => socfpga_agilex7m_socdk.dts} |  66 +++++++--
 arch/arm/dts/socfpga_soc64_u-boot.dtsi        | 127 ++++++++++++++++++
 3 files changed, 213 insertions(+), 17 deletions(-)
 copy arch/arm/dts/{socfpga_agilex_socdk-u-boot.dtsi => socfpga_agilex7m_socdk-u-boot.dtsi} (50%)
 copy arch/arm/dts/{socfpga_agilex_socdk.dts => socfpga_agilex7m_socdk.dts} (63%)
 create mode 100644 arch/arm/dts/socfpga_soc64_u-boot.dtsi

diff --git a/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_agilex7m_socdk-u-boot.dtsi
similarity index 50%
copy from arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
copy to arch/arm/dts/socfpga_agilex7m_socdk-u-boot.dtsi
index 63df28e836..4369f0b545 100644
--- a/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex7m_socdk-u-boot.dtsi
@@ -2,12 +2,18 @@
 /*
  * U-Boot additions
  *
- * Copyright (C) 2019-2022 Intel Corporation <www.intel.com>
+ * Copyright (C) 2024 Intel Corporation <www.intel.com>
  */
 
 #include "socfpga_agilex-u-boot.dtsi"
+#include "socfpga_soc64_u-boot.dtsi"
 
 /{
+	chosen {
+		stdout-path = "serial0:115200n8";
+		u-boot,spl-boot-order = &mmc;
+	};
+
 	aliases {
 		spi0 = &qspi;
 		i2c0 = &i2c1;
@@ -23,9 +29,7 @@
 	};
 
 	memory {
-		/* 8GB */
-		reg = <0 0x00000000 0 0x80000000>,
-		      <2 0x80000000 1 0x80000000>;
+		reg = <0 0x00000000 0 0x80000000>;
 	};
 };
 
@@ -34,22 +38,43 @@
 	spi-tx-bus-width = <4>;
 	spi-rx-bus-width = <4>;
 	bootph-all;
+	/delete-property/ cdns,read-delay;
 };
 
 &i2c1 {
 	status = "okay";
 };
 
+&nand {
+	status = "okay";
+	nand-bus-width = <16>;
+	bootph-all;
+};
+
 &mmc {
 	drvsel = <3>;
 	smplsel = <0>;
 	bootph-all;
 };
 
-&qspi {
-	status = "okay";
+&sdr {
+	compatible = "intel,sdr-ctl-agilex7m";
+
+	reg = <0xf8020000 0x100>;
+};
+
+&socfpga_l3interconnect_firewall {
+	soc_noc_fw_mpfe_csr_inst_0_mpfe_scr@f8020000 {
+		intel,offset-settings =
+			/* Disable MPFE firewall for SMMU */
+			<0x00000000 0x00010101 0x00010101>;
+	};
 };
 
 &watchdog0 {
 	bootph-all;
 };
+
+&binman {
+	/delete-node/ kernel;
+};
diff --git a/arch/arm/dts/socfpga_agilex_socdk.dts b/arch/arm/dts/socfpga_agilex7m_socdk.dts
similarity index 63%
copy from arch/arm/dts/socfpga_agilex_socdk.dts
copy to arch/arm/dts/socfpga_agilex7m_socdk.dts
index bcdeecc0e0..ba929b9c74 100644
--- a/arch/arm/dts/socfpga_agilex_socdk.dts
+++ b/arch/arm/dts/socfpga_agilex7m_socdk.dts
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier:     GPL-2.0
 /*
- * Copyright (C) 2019, Intel Corporation
+ * Copyright (C) 2024, Intel Corporation
  */
 #include "socfpga_agilex.dtsi"
 
 / {
-	model = "SoCFPGA Agilex SoCDK";
+	model = "SoCFPGA Agilex7-M SoCDK";
 
 	aliases {
 		serial0 = &uart0;
@@ -14,10 +14,6 @@
 		ethernet2 = &gmac2;
 	};
 
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
 	leds {
 		compatible = "gpio-leds";
 		hps0 {
@@ -85,6 +81,36 @@
 	};
 };
 
+&gmac2 {
+	status = "okay";
+	phy-mode = "rgmii";
+	phy-handle = <&phy0>;
+
+	max-frame-size = <3800>;
+
+	mdio2 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+		phy2: ethernet-phy@2 {
+			reg = <4>;
+
+			txd0-skew-ps = <0>; /* -420ps */
+			txd1-skew-ps = <0>; /* -420ps */
+			txd2-skew-ps = <0>; /* -420ps */
+			txd3-skew-ps = <0>; /* -420ps */
+			rxd0-skew-ps = <420>; /* 0ps */
+			rxd1-skew-ps = <420>; /* 0ps */
+			rxd2-skew-ps = <420>; /* 0ps */
+			rxd3-skew-ps = <420>; /* 0ps */
+			txen-skew-ps = <0>; /* -420ps */
+			txc-skew-ps = <1860>; /* 960ps */
+			rxdv-skew-ps = <420>; /* 0ps */
+			rxc-skew-ps = <1680>; /* 780ps */
+		};
+	};
+};
+
 &mmc {
 	status = "okay";
 	cap-sd-highspeed;
@@ -128,13 +154,31 @@
 			#size-cells = <1>;
 
 			qspi_boot: partition@0 {
-				label = "Boot and fpga data";
-				reg = <0x0 0x034B0000>;
+				label = "u-boot";
+				reg = <0x0 0x04200000>;
+			};
+
+			root: partition@4200000 {
+				label = "root";
+				reg = <0x04200000 0x0BE00000>;
 			};
+		};
+	};
+};
 
-			qspi_rootfs: partition@34B0000 {
-				label = "Root Filesystem - JFFS2";
-				reg = <0x034B0000 0x0EB50000>;
+&nand {
+	flash@0 {
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			partition@0 {
+				label = "u-boot";
+				reg = <0 0x200000>;
+			};
+			partition@200000 {
+				label = "root";
+				reg = <0x200000 0x3fe00000>;
 			};
 		};
 	};
diff --git a/arch/arm/dts/socfpga_soc64_u-boot.dtsi b/arch/arm/dts/socfpga_soc64_u-boot.dtsi
new file mode 100644
index 0000000000..d8a121ade8
--- /dev/null
+++ b/arch/arm/dts/socfpga_soc64_u-boot.dtsi
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * U-Boot additions
+ *
+ * Copyright (C) 2024 Intel Corporation <www.intel.com>
+ */
+
+/ {
+	soc {
+		socfpga-system-mgr-firewall {
+			compatible = "intel,socfpga-dtreg";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			bootph-all;
+
+			i_sys_mgr_core@ffd12000 {
+				reg = <0xffd12000 0x00000230>;
+				intel,offset-settings =
+					/* Enable non-secure interface to DMA */
+					<0x00000020 0xff010000 0xff010011>,
+					/* Enable non-secure interface to DMA periph */
+					<0x00000024 0xffffffff 0xffffffff>;
+				bootph-all;
+			};
+		};
+
+		socfpga_l3interconnect_firewall:socfpga-l3interconnect-firewall {
+			compatible = "intel,socfpga-dtreg";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			bootph-all;
+
+			noc_fw_l4_per_l4_per_scr@ffd21000 {
+				reg = <0xffd21000 0x00000074>;
+				intel,offset-settings =
+					/* Disable L4 periphs firewall */
+					<0x00000000 0x01010001 0x01010001>,
+					<0x00000004 0x01010001 0x01010001>,
+					<0x0000000c 0x01010001 0x01010001>,
+					<0x00000010 0x01010001 0x01010001>,
+					<0x0000001c 0x01010001 0x01010101>,
+					<0x00000020 0x01010001 0x01010101>,
+					<0x00000024 0x01010001 0x01010101>,
+					<0x00000028 0x01010001 0x01010101>,
+					<0x0000002c 0x01010001 0x01010001>,
+					<0x00000030 0x01010001 0x01010001>,
+					<0x00000034 0x01010001 0x01010001>,
+					<0x00000040 0x01010001 0x01010001>,
+					<0x00000044 0x01010001 0x01010101>,
+					<0x00000048 0x01010001 0x01010101>,
+					<0x00000050 0x01010001 0x01010101>,
+					<0x00000054 0x01010001 0x01010101>,
+					<0x00000058 0x01010001 0x01010101>,
+					<0x0000005c 0x01010001 0x01010101>,
+					<0x00000060 0x01010001 0x01010101>,
+					<0x00000064 0x01010001 0x01010101>,
+					<0x00000068 0x01010001 0x01010101>,
+					<0x0000006c 0x01010001 0x01010101>,
+					<0x00000070 0x01010001 0x01010101>;
+				bootph-all;
+			};
+
+			noc_fw_l4_sys_l4_sys_scr@ffd21100 {
+				reg = <0xffd21100 0x00000098>;
+				intel,offset-settings =
+					/* Disable L4 system firewall */
+					<0x00000008 0x01010001 0x01010001>,
+					<0x0000000c 0x01010001 0x01010001>,
+					<0x00000010 0x01010001 0x01010001>,
+					<0x00000014 0x01010001 0x01010001>,
+					<0x00000018 0x01010001 0x01010001>,
+					<0x0000001c 0x01010001 0x01010001>,
+					<0x00000020 0x01010001 0x01010001>,
+					<0x0000002c 0x01010001 0x01010001>,
+					<0x00000030 0x01010001 0x01010001>,
+					<0x00000034 0x01010001 0x01010001>,
+					<0x00000038 0x01010001 0x01010001>,
+					<0x00000040 0x01010001 0x01010001>,
+					<0x00000044 0x01010001 0x01010001>,
+					<0x00000048 0x01010001 0x01010001>,
+					<0x0000004c 0x01010001 0x01010001>,
+					<0x00000054 0x01010001 0x01010001>,
+					<0x00000058 0x01010001 0x01010001>,
+					<0x0000005c 0x01010001 0x01010001>,
+					<0x00000060 0x01010001 0x01010101>,
+					<0x00000064 0x01010001 0x01010101>,
+					<0x00000068 0x01010001 0x01010101>,
+					<0x0000006c 0x01010001 0x01010101>,
+					<0x00000070 0x01010001 0x01010101>,
+					<0x00000074 0x01010001 0x01010101>,
+					<0x00000078 0x01010001 0x03010001>,
+					<0x00000090 0x01010001 0x01010001>,
+					<0x00000094 0x01010001 0x01010001>;
+				bootph-all;
+			};
+
+			noc_fw_soc2fpga_soc2fpga_scr@ffd21200 {
+				reg = <0xffd21200 0x00000004>;
+				/* Disable soc2fpga security access */
+				intel,offset-settings = <0x00000000 0x0ffe0101 0x0ffe0101>;
+				bootph-all;
+			};
+
+			noc_fw_lwsoc2fpga_lwsoc2fpga_scr@ffd21300 {
+				reg = <0xffd21300 0x00000004>;
+				/* Disable lightweight soc2fpga security access */
+				intel,offset-settings = <0x00000000 0x0ffe0101 0x0ffe0101>;
+				bootph-all;
+			};
+
+			noc_fw_tcu_tcu_scr@ffd21400 {
+				reg = <0xffd21400 0x00000004>;
+				/* Disable DMA ECC security access, for SMMU use */
+				intel,offset-settings = <0x00000000 0x01010001 0x01010001>;
+				bootph-all;
+			};
+
+			noc_fw_priv_MemoryMap_priv@ffd24800 {
+				reg = <0xffd24800 0x0000000c>;
+				intel,offset-settings =
+				/* Enable non-prviledged access to various periphs */
+					<0x00000000 0xfff73ffb 0xfff73ffb>;
+				bootph-all;
+			};
+		};
+	};
+};
-- 
2.25.1

