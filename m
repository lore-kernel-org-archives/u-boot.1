Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D408FC02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 08:36:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74B7280F96;
	Tue, 18 Feb 2025 09:35:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="IRNe0Osp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F18280F81; Tue, 18 Feb 2025 09:35:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC91080F6C
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 09:35:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739867745; x=1771403745;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PEtlNcI/fwEyruf5we3eWfvl5Y/AUg9YobTnlhuJMNs=;
 b=IRNe0OspsWNkdFNOO5jrWfk+Mc9v1cEpG7Q3MDksHN1pPSTB9UuPGWax
 sfq6mZqppeuA+gluVjXUpr5Ifn6h1UQL7z6FuotEP7cXUkCcygem8Nlgf
 TW2HfECxJ0//dgWHB1Ne6ETmdLKm3JEt0w2ZPI/8p8dnm0D7Ic4nfq7PX
 hhhYa2GjK0+tbt2ToiP/wMZMMMNULIlIB1xny7hXZMcY6prToMLPUoxm6
 0agyNOnpjK0dsUU6LPPIrCns/6xKLiVEjOdzgLvZLoMIj8r+RQ+F4qi+j
 K+sLXbmYSZoulVY5EVfPRZPIVwcDEHX+CncaSsQBnLRl90oqS7hk/nuup Q==;
X-CSE-ConnectionGUID: kdwe8kudT1+6HKAJydI+Iw==
X-CSE-MsgGUID: zQsX5ZzFRPmeJd6YxnlCKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="63028144"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="63028144"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 00:35:44 -0800
X-CSE-ConnectionGUID: Rhvwrbe1TWKO3+dda4bvzA==
X-CSE-MsgGUID: Cl8H792rTbyd47iZJtE77Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="145237733"
Received: from apgcp0d540114.png.altera.com ([10.244.77.36])
 by fmviesa001.fm.intel.com with ESMTP; 18 Feb 2025 00:35:42 -0800
From: alif.zakuan.yuslaimi@intel.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCH v2 10/26] arm: dts: agilex5: Add firewall configure settings
Date: Tue, 18 Feb 2025 16:34:55 +0800
Message-Id: <20250218083511.29249-11-alif.zakuan.yuslaimi@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250218083511.29249-1-alif.zakuan.yuslaimi@intel.com>
References: <20250218083511.29249-1-alif.zakuan.yuslaimi@intel.com>
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

From: Tien Fong Chee <tien.fong.chee@intel.com>

These firewall configure settings are needed to disable firewall on
respective hardware component so both secure and non-secure transactions
are allowed.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
---
 arch/arm/dts/socfpga_agilex5-u-boot.dtsi | 166 +++++++++++++++++++++++
 1 file changed, 166 insertions(+)

diff --git a/arch/arm/dts/socfpga_agilex5-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
index 4270dce38df..08f568f5650 100644
--- a/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
@@ -222,6 +222,172 @@
 				bootph-all;
 			};
 		};
+
+		socfpga_firewall_config: socfpga-firewall-config {
+			compatible = "intel,socfpga-dtreg";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			bootph-all;
+
+			/* L4 peripherals firewall */
+			noc_fw_l4_per@10d21000 {
+				reg = <0x10d21000 0x0000008c>;
+				intel,offset-settings =
+					/* NAND */
+					<0x00000000 0x01010001 0x01010001>,
+					/* USB0 */
+					<0x0000000c 0x01010001 0x01010001>,
+					/* USB1 */
+					<0x00000010 0x01010001 0x01010001>,
+					/* SPI_MAIN0 */
+					<0x0000001c 0x01010301 0x01010301>,
+					/* SPI_MAIN1 */
+					<0x00000020 0x01010301 0x01010301>,
+					/* SPI_SECONDARY0 */
+					<0x00000024 0x01010301 0x01010301>,
+					/* SPI_SECONDARY1 */
+					<0x00000028 0x01010301 0x01010301>,
+					/* EMAC0 */
+					<0x0000002c 0x01010001 0x01010001>,
+					/* EMAC1 */
+					<0x00000030 0x01010001 0x01010001>,
+					/* EMAC2 */
+					<0x00000034 0x01010001 0x01010001>,
+					/* SDMMC */
+					<0x00000040 0x01010001 0x01010001>,
+					/* GPIO0 */
+					<0x00000044 0x01010301 0x01010301>,
+					/* GPIO1 */
+					<0x00000048 0x01010301 0x01010301>,
+					/* I2C0 */
+					<0x00000050 0x01010301 0x01010301>,
+					/* I2C1 */
+					<0x00000054 0x01010301 0x01010301>,
+					/* I2C2 */
+					<0x00000058 0x01010301 0x01010301>,
+					/* I2C3 */
+					<0x0000005c 0x01010301 0x01010301>,
+					/* I2C4 */
+					<0x00000060 0x01010301 0x01010301>,
+					/* SP_TIMER0 */
+					<0x00000064 0x01010301 0x01010301>,
+					/* SP_TIMER1 */
+					<0x00000068 0x01010301 0x01010301>,
+					/* UART0 */
+					<0x0000006c 0x01010301 0x01010301>,
+					/* UART1 */
+					<0x00000070 0x01010301 0x01010301>,
+					/* I3C0 */
+					<0x00000074 0x01010301 0x01010301>,
+					/* I3C1 */
+					<0x00000078 0x01010301 0x01010301>,
+					/* DMA0 */
+					<0x0000007c 0x01010001 0x01010001>,
+					/* DMA1 */
+					<0x00000080 0x01010001 0x01010001>,
+					/* COMBO_PHY */
+					<0x00000084 0x01010001 0x01010001>,
+					/* NAND_SDMA */
+					<0x00000088 0x01010301 0x01010301>;
+				bootph-all;
+			};
+
+			/* L4 system firewall */
+			noc_fw_l4_sys@10d21100 {
+				reg = <0x10d21100 0x00000098>;
+				intel,offset-settings =
+					/* DMA_ECC */
+					<0x00000008 0x01010001 0x01010001>,
+					/* EMAC0RX_ECC */
+					<0x0000000c 0x01010001 0x01010001>,
+					/* EMAC0TX_ECC */
+					<0x00000010 0x01010001 0x01010001>,
+					/* EMAC1RX_ECC */
+					<0x00000014 0x01010001 0x01010001>,
+					/* EMAC1TX_ECC */
+					<0x00000018 0x01010001 0x01010001>,
+					/* EMAC2RX_ECC */
+					<0x0000001c 0x01010001 0x01010001>,
+					/* EMAC2TX_ECC */
+					<0x00000020 0x01010001 0x01010001>,
+					/* NAND_ECC */
+					<0x0000002c 0x01010001 0x01010001>,
+					/* NAND_READ_ECC */
+					<0x00000030 0x01010001 0x01010001>,
+					/* NAND_WRITE_ECC */
+					<0x00000034 0x01010001 0x01010001>,
+					/* OCRAM_ECC */
+					<0x00000038 0x01010001 0x01010001>,
+					/* SDMMC_ECC */
+					<0x00000040 0x01010001 0x01010001>,
+					/* USB0_ECC */
+					<0x00000044 0x01010001 0x01010001>,
+					/* USB1_CACHEECC */
+					<0x00000048 0x01010001 0x01010001>,
+					/* CLOCK_MANAGER */
+					<0x0000004c 0x01010001 0x01010001>,
+					/* IO_MANAGER */
+					<0x00000054 0x01010001 0x01010001>,
+					/* RESET_MANAGER */
+					<0x00000058 0x01010001 0x01010001>,
+					/* SYSTEM_MANAGER */
+					<0x0000005c 0x01010001 0x01010001>,
+					/* OSC0_TIMER */
+					<0x00000060 0x01010301 0x01010301>,
+					/* OSC1_TIMER0*/
+					<0x00000064 0x01010301 0x01010301>,
+					/* WATCHDOG0 */
+					<0x00000068 0x01010301 0x01010301>,
+					/* WATCHDOG1 */
+					<0x0000006c 0x01010301 0x01010301>,
+					/* WATCHDOG2 */
+					<0x00000070 0x01010301 0x01010301>,
+					/* WATCHDOG3 */
+					<0x00000074 0x01010301 0x01010301>,
+					/* DAP */
+					<0x00000078 0x03010001 0x03010001>,
+					/* WATCHDOG4 */
+					<0x0000007c 0x01010301 0x01010301>,
+					/* POWER_MANAGER */
+					<0x00000080 0x01010001 0x01010001>,
+					/* USB1_RXECC */
+					<0x00000084 0x01010001 0x01010001>,
+					/* USB1_TXECC */
+					<0x00000088 0x01010001 0x01010001>,
+					/* L4_NOC_PROBES */
+					<0x00000090 0x01010001 0x01010001>,
+					/* L4_NOC_QOS */
+					<0x00000094 0x01010001 0x01010001>;
+				bootph-all;
+			};
+
+			/* Light weight SoC2FPGA */
+			noc_fw_lwsoc2fpga@10d21300 {
+				reg = <0x10d21300 0x0000004>;
+				intel,offset-settings =
+					/* LWSOC2FPGA_CSR */
+					<0x00000000 0x0ffe0301 0x0ffe0301>;
+				bootph-all;
+			};
+
+			/* SoC2FPGA */
+			noc_fw_soc2fpga@10d21200 {
+				reg = <0x10d21200 0x0000004>;
+				intel,offset-settings =
+					/* SOC2FPGA_CSR */
+					<0x00000000 0x0ffe0301 0x0ffe0301>;
+				bootph-all;
+			};
+
+			/* TCU */
+			noc_fw_tcu@10d21400 {
+				reg = <0x10d21400 0x0000004>;
+				intel,offset-settings =
+					/* TCU_CSR */
+					<0x00000000 0x01010001 0x01010001>;
+				bootph-all;
+			};
+		};
 	};
 };
 
-- 
2.25.1

