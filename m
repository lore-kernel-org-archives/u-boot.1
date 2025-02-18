Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0482C021A9
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 08:36:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F5C280F77;
	Tue, 18 Feb 2025 09:35:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="KvRNgat+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBCEE80F77; Tue, 18 Feb 2025 09:35:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D27080F16
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 09:35:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739867742; x=1771403742;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MZdg5HKvk7YUBdmiSbYld9SAyp9rKIcuxWapWKTliK0=;
 b=KvRNgat+RreW2esBHOkByj1mAObB1cep1OGzpLyETyi6LocIAjajaMhQ
 BXLE3MFVjNBZJ4ZpN9S5GVQWO3s9JzgjGOK4F7e9EHlm8jhIy2NYeuaHq
 Op104QBpiSAug3EkXyKfY1fbf8eQusMAhkbyRxeDFrFHaqZcT8idpLK5i
 a6fsHx/+TMJsN4pp5twr5w+B6e8h3MIrJFQBR751w6dLSiZwpBl/h+4j9
 pVwZ63TsGgZl9/IGd3xyEMtyOvbm+Mh7UlaaFFM5oCNEbUyv5PNgl9H6c
 2OYTndOEbyhxK6Hk676HtfA8G23NSP188yhyEzr1q0P3VT1lB2PaRVh/c w==;
X-CSE-ConnectionGUID: tRSezj1XTEKuslpv5P9PxA==
X-CSE-MsgGUID: T9rxKUQfS42Krj12ib15Fw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="63028138"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="63028138"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 00:35:42 -0800
X-CSE-ConnectionGUID: eirVRApNRJ+wGrrB1AOfPQ==
X-CSE-MsgGUID: zJsQthtHQYSbHkTHpiREww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="145237722"
Received: from apgcp0d540114.png.altera.com ([10.244.77.36])
 by fmviesa001.fm.intel.com with ESMTP; 18 Feb 2025 00:35:39 -0800
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
Subject: [PATCH v2 09/26] arm: dts: agilex5: Add HPS cache coherency unit
 configuration settings
Date: Tue, 18 Feb 2025 16:34:54 +0800
Message-Id: <20250218083511.29249-10-alif.zakuan.yuslaimi@intel.com>
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

These configuration settings are required to enable cache maintenance and
access between initiators and targets.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
---
 arch/arm/dts/socfpga_agilex5-u-boot.dtsi | 210 +++++++++++++++++++++++
 1 file changed, 210 insertions(+)

diff --git a/arch/arm/dts/socfpga_agilex5-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
index a8167e5c14a..4270dce38df 100644
--- a/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
@@ -3,6 +3,7 @@
  * U-Boot additions
  *
  * Copyright (C) 2024 Intel Corporation <www.intel.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
 
 #include "socfpga_soc64_fit-u-boot.dtsi"
@@ -13,6 +14,215 @@
 		#size-cells = <2>;
 		bootph-all;
 	};
+
+	soc {
+		bootph-all;
+
+		socfpga_ccu_config: socfpga-ccu-config {
+			compatible = "intel,socfpga-dtreg";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			bootph-all;
+
+			/* DSU */
+			i_ccu_caiu0@1c000000 {
+				reg = <0x1c000000 0x00001000>;
+				intel,offset-settings =
+					/* CAIUMIFSR */
+					<0x000003c4 0x00000000 0x07070777>,
+					/* DII1_MPFEREGS */
+					<0x00000414 0x00018000 0xffffffff>,
+					<0x00000418 0x00000000 0x000000ff>,
+					<0x00000410 0xc0e00200 0xc1f03e1f>,
+					/* DII2_GICREGS */
+					<0x00000424 0x0001d000 0xffffffff>,
+					<0x00000428 0x00000000 0x000000ff>,
+					<0x00000420 0xc0800400 0xc1f03e1f>,
+					/* NCAIU0_LWSOC2FPGA */
+					<0x00000444 0x00020000 0xffffffff>,
+					<0x00000448 0x00000000 0x000000ff>,
+					<0x00000440 0xc1100006 0xc1f03e1f>,
+					/* NCAIU0_SOC2FPGA_1G */
+					<0x00000454 0x00040000 0xffffffff>,
+					<0x00000458 0x00000000 0x000000ff>,
+					<0x00000450 0xc1200006 0xc1f03e1f>,
+					/* DMI_SDRAM_2G */
+					<0x00000464 0x00080000 0xffffffff>,
+					<0x00000468 0x00000000 0x000000ff>,
+					/* NCAIU0_SOC2FPGA_16G */
+					<0x00000474 0x00400000 0xffffffff>,
+					<0x00000478 0x00000000 0x000000ff>,
+					<0x00000470 0xc1600006 0xc1f03e1f>,
+					/* DMI_SDRAM_30G */
+					<0x00000484 0x00800000 0xffffffff>,
+					<0x00000488 0x00000000 0x000000ff>,
+					/* NCAIU0_SOC2FPGA_256G */
+					<0x00000494 0x04000000 0xffffffff>,
+					<0x00000498 0x00000000 0x000000ff>,
+					<0x00000490 0xc1a00006 0xc1f03e1f>,
+					/* DMI_SDRAM_480G */
+					<0x000004a4 0x08000000 0xffffffff>,
+					<0x000004a8 0x00000000 0x000000ff>;
+				bootph-all;
+			};
+
+			/* FPGA2SOC */
+			i_ccu_ncaiu0@1c001000 {
+				reg = <0x1c001000 0x00001000>;
+				intel,offset-settings =
+					/* NCAIU0MIFSR */
+					<0x000003c4 0x00000000 0x07070777>,
+					/* PSS */
+					<0x00000404 0x00010000 0xffffffff>,
+					<0x00000408 0x00000000 0x000000ff>,
+					<0x00000400 0xC0F00000 0xc1f03e1f>,
+					/* DII1_MPFEREGS */
+					<0x00000414 0x00018000 0xffffffff>,
+					<0x00000418 0x00000000 0x000000ff>,
+					<0x00000410 0xc0e00200 0xc1f03e1f>,
+					/* NCAIU0_LWSOC2FPGA */
+					<0x00000444 0x00020000 0xffffffff>,
+					<0x00000448 0x00000000 0x000000ff>,
+					<0x00000440 0xc1100006 0xc1f03e1f>,
+					/* NCAIU0_SOC2FPGA_1G */
+					<0x00000454 0x00040000 0xffffffff>,
+					<0x00000458 0x00000000 0x000000ff>,
+					<0x00000450 0xc1200006 0xc1f03e1f>,
+					/* DMI_SDRAM_2G */
+					<0x00000464 0x00080000 0xffffffff>,
+					<0x00000468 0x00000000 0x000000ff>,
+					/* NCAIU0_SOC2FPGA_16G */
+					<0x00000474 0x00400000 0xffffffff>,
+					<0x00000478 0x00000000 0x000000ff>,
+					<0x00000470 0xc1600006 0xc1f03e1f>,
+					/* DMI_SDRAM_30G */
+					<0x00000484 0x00800000 0xffffffff>,
+					<0x00000488 0x00000000 0x000000ff>,
+					/* NCAIU0_SOC2FPGA_256G */
+					<0x00000494 0x04000000 0xffffffff>,
+					<0x00000498 0x00000000 0x000000ff>,
+					<0x00000490 0xc1a00006 0xc1f03e1f>,
+					/* DMI_SDRAM_480G */
+					<0x000004a4 0x08000000 0xffffffff>,
+					<0x000004a8 0x00000000 0x000000ff>;
+				bootph-all;
+			};
+
+			/* GIC_M */
+			i_ccu_ncaiu1@1c002000 {
+				reg = <0x1c002000 0x00001000>;
+				intel,offset-settings =
+					/* NCAIU1MIFSR */
+					<0x000003c4 0x00000000 0x07070777>,
+					/* DMI_SDRAM_2G */
+					<0x00000464 0x00080000 0xffffffff>,
+					<0x00000468 0x00000000 0x000000ff>,
+					/* DMI_SDRAM_30G */
+					<0x00000484 0x00800000 0xffffffff>,
+					<0x00000488 0x00000000 0x000000ff>,
+					/* DMI_SDRAM_480G */
+					<0x000004a4 0x08000000 0xffffffff>,
+					<0x000004a8 0x00000000 0x000000ff>;
+				bootph-all;
+			};
+
+			/* SMMU */
+			i_ccu_ncaiu2@1c003000 {
+				reg = <0x1c003000 0x00001000>;
+				intel,offset-settings =
+					/* NCAIU2MIFSR */
+					<0x000003c4 0x00000000 0x07070777>,
+					/* DMI_SDRAM_2G */
+					<0x00000464 0x00080000 0xffffffff>,
+					<0x00000468 0x00000000 0x000000ff>,
+					/* DMI_SDRAM_30G */
+					<0x00000484 0x00800000 0xffffffff>,
+					<0x00000488 0x00000000 0x000000ff>,
+					/* DMI_SDRAM_480G */
+					<0x000004a4 0x08000000 0xffffffff>,
+					<0x000004a8 0x00000000 0x000000ff>;
+				bootph-all;
+			};
+
+			/* PSS NOC */
+			i_ccu_ncaiu3@1c004000 {
+				reg = <0x1c004000 0x00001000>;
+				intel,offset-settings =
+					/* NCAIU3MIFSR */
+					<0x000003c4 0x00000000 0x07070777>,
+					/* DII1_MPFEREGS */
+					<0x00000414 0x00018000 0xffffffff>,
+					<0x00000418 0x00000000 0x000000ff>,
+					<0x00000410 0xc0e00200 0xc1f03e1f>,
+					/* DMI_SDRAM_2G */
+					<0x00000464 0x00080000 0xffffffff>,
+					<0x00000468 0x00000000 0x000000ff>,
+					/* DMI_SDRAM_30G */
+					<0x00000484 0x00800000 0xffffffff>,
+					<0x00000488 0x00000000 0x000000ff>,
+					/* DMI_SDRAM_480G */
+					<0x000004a4 0x08000000 0xffffffff>,
+					<0x000004a8 0x00000000 0x000000ff>;
+				bootph-all;
+			};
+
+			/* DCE0 */
+			i_ccu_dce0@1c005000 {
+				reg = <0x1c005000 0x00001000>;
+				intel,offset-settings =
+					/* DCEUMIFSR0 */
+					<0x000003c4 0x00000000 0x07070777>,
+					/* DMI_SDRAM_2G */
+					<0x00000464 0x00080000 0xffffffff>,
+					<0x00000468 0x00000000 0x000000ff>,
+					/* DMI_SDRAM_30G */
+					<0x00000484 0x00800000 0xffffffff>,
+					<0x00000488 0x00000000 0x000000ff>,
+					/* DMI_SDRAM_480G */
+					<0x000004a4 0x08000000 0xffffffff>,
+					<0x000004a8 0x00000000 0x000000ff>;
+				bootph-all;
+			};
+
+			/* DCE1 */
+			i_ccu_dce1@1c006000 {
+				reg = <0x1c006000 0x00001000>;
+				intel,offset-settings =
+					/* DCEUMIFSR1 */
+					<0x000003c4 0x00000000 0x07070777>,
+					/* DMI_SDRAM_2G */
+					<0x00000464 0x00080000 0xffffffff>,
+					<0x00000468 0x00000000 0x000000ff>,
+					/* DMI_SDRAM_30G */
+					<0x00000484 0x00800000 0xffffffff>,
+					<0x00000488 0x00000000 0x000000ff>,
+					/* DMI_SDRAM_480G */
+					<0x000004a4 0x08000000 0xffffffff>,
+					<0x000004a8 0x00000000 0x000000ff>;
+				bootph-all;
+			};
+
+			/* DMI0 */
+			i_ccu_dmi0@1c007000 {
+				reg = <0x1c007000 0x00001000>;
+				intel,offset-settings =
+					/* DMIUSMCTCR */
+					<0x00000300 0x00000001 0x00000003>,
+					<0x00000300 0x00000003 0x00000003>;
+				bootph-all;
+			};
+
+			/* DMI1 */
+			i_ccu_dmi0@1c008000 {
+				reg = <0x1c008000 0x00001000>;
+				intel,offset-settings =
+					/* DMIUSMCTCR */
+					<0x00000300 0x00000001 0x00000003>,
+					<0x00000300 0x00000003 0x00000003>;
+				bootph-all;
+			};
+		};
+	};
 };
 
 &clkmgr {
-- 
2.25.1

