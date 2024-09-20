Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B743CF58DF
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:04:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2616E8937C;
	Fri, 20 Sep 2024 09:03:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="k2zqypKm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBD5B89357; Fri, 20 Sep 2024 09:03:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F3CC89323
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:03:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726815810; x=1758351810;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3hN1zhziyS3oz2XWm3zf97DSkEU+iIVZRpej92AeylM=;
 b=k2zqypKmhX8laRvQSbrPmDZHTOatkcSux0KtGz7kgnDVBIeG0mAsgvg2
 2IoW19yN7mefX7HRQ6UjpHhOBkzrwBoz4XZMW9J3Hlt0gRROluh601NPl
 dJBgmlT1fc72ZyGcoLEjwn8sKNss3WCqV8kr6/znKLFkXMMD9fcuHiK8B
 8ksmGd1IwyvqtEYAG+eASoeXOX9FFOKcwxSbXsOWe84dmIpdE08ooWvGN
 AFpgWcn4GgWDBJlnGbLUNJYmD1IUaXUDNZqt1NGproeMn7tEzn6YM6qhn
 f3F9orTI1nqQ/hdne+eAuVp5psatiljIhz7UycUQd25nTLYM1ugEJQv+1 A==;
X-CSE-ConnectionGUID: cGP3R1HJSkqZm7iTNm2RRw==
X-CSE-MsgGUID: hTtMzKBIS+GlTiQjZJVaVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25961047"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; d="scan'208";a="25961047"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2024 00:03:28 -0700
X-CSE-ConnectionGUID: 8syEdc4SSs215D8nLAgKmw==
X-CSE-MsgGUID: x7AYy92VQV2cxO0izFqhWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; d="scan'208";a="70235094"
Received: from pglc00502.png.intel.com ([10.221.239.194])
 by orviesa009.jf.intel.com with ESMTP; 20 Sep 2024 00:03:26 -0700
From: tien.fong.chee@intel.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Meng Tingting <tingting.meng@intel.com>,
 Yuslaimi Alif Zakuan <alif.zakuan.yuslaimi@intel.com>,
 Hea Kok Kiang <kok.kiang.hea@intel.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCH v1 07/20] arm: dts: agilex5: Add firewall configure settings
Date: Fri, 20 Sep 2024 15:02:29 +0800
Message-Id: <20240920070242.20884-8-tien.fong.chee@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240920070242.20884-1-tien.fong.chee@intel.com>
References: <20240920070242.20884-1-tien.fong.chee@intel.com>
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


Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
---
 arch/arm/dts/socfpga_agilex5-u-boot.dtsi | 166 +++++++++++++++++++++++
 1 file changed, 166 insertions(+)

diff --git a/arch/arm/dts/socfpga_agilex5-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
index ec42fd01a9c..bf30b3b8858 100644
--- a/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
@@ -221,6 +221,172 @@
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

