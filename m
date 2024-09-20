Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D07CF58DD
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:06:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62FCC893B8;
	Fri, 20 Sep 2024 09:03:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="B+gAKqMN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB53D893A9; Fri, 20 Sep 2024 09:03:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78F9089323
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:03:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726815829; x=1758351829;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ah+CHHDr29uPMrqE9LmnZNxx76hvxySACSE84a2KwE0=;
 b=B+gAKqMNqeqHkq62RMhf8ZRl4yT0b5iMEgb12OYLbuzg8fKJ4pL0ub+9
 EfghaQ4hjIFNkB7qE5ennfFdp/veh8UCyfH7bgVY2YEkKvHgWCNMsX3/m
 EiOIQyo0xnkr6qoZvnycgbj0C+peplrTt8HlmfAIYU7f9/0cLRyi3u5E7
 28HgNTVqAh3aFSskbZd/vZswcfcipZMatbC3E2l0rMsH9UakfdO+cH0i7
 oGn1lNhQNnRwZYh9vxBzceALuTZl7RdOG/lSK+yAgiZqrvfxAYfeUqYRm
 j0ECHqXvL5ntrgvrqBjfF8xzhbzQrEsOhJgWZrQqye3G62PQ/qZOgQYa5 Q==;
X-CSE-ConnectionGUID: 2Ec2NBsYSiK/ePpgT2iuTQ==
X-CSE-MsgGUID: rtz7LDogRqiF6HOCTjBJkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25961106"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; d="scan'208";a="25961106"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2024 00:03:48 -0700
X-CSE-ConnectionGUID: ix8JhReWSU2TIkQHUsg6eg==
X-CSE-MsgGUID: nSFhGDX3QAy7HtB9eJ3f1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; d="scan'208";a="70235258"
Received: from pglc00502.png.intel.com ([10.221.239.194])
 by orviesa009.jf.intel.com with ESMTP; 20 Sep 2024 00:03:46 -0700
From: tien.fong.chee@intel.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Meng Tingting <tingting.meng@intel.com>,
 Yuslaimi Alif Zakuan <alif.zakuan.yuslaimi@intel.com>,
 Hea Kok Kiang <kok.kiang.hea@intel.com>
Subject: [PATCH v1 16/20] ddr: altera: Add DDR driver for Agilex5 series
Date: Fri, 20 Sep 2024 15:02:38 +0800
Message-Id: <20240920070242.20884-17-tien.fong.chee@intel.com>
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

From: Tingting Meng <tingting.meng@intel.com>

Adding DDR driver support for Agilex5 series.

Signed-off-by: Tingting Meng <tingting.meng@intel.com>
---
 MAINTAINERS                                   |   2 +
 arch/arm/dts/socfpga_agilex5-u-boot.dtsi      | 251 +++++++
 arch/arm/dts/socfpga_agilex5.dtsi             |   7 +
 arch/arm/mach-socfpga/include/mach/firewall.h |  23 +-
 drivers/ddr/altera/Makefile                   |   1 +
 drivers/ddr/altera/iossm_mailbox.c            | 613 ++++++++++++++++++
 drivers/ddr/altera/iossm_mailbox.h            | 186 ++++++
 drivers/ddr/altera/sdram_agilex5.c            | 377 +++++++++++
 drivers/ddr/altera/sdram_soc64.c              |  78 ++-
 drivers/ddr/altera/sdram_soc64.h              |  32 +-
 10 files changed, 1547 insertions(+), 23 deletions(-)
 create mode 100644 drivers/ddr/altera/iossm_mailbox.c
 create mode 100644 drivers/ddr/altera/iossm_mailbox.h
 create mode 100644 drivers/ddr/altera/sdram_agilex5.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2050ae24df8..1837d283b2f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -146,8 +146,10 @@ ARM ALTERA SOCFPGA
 M:	Marek Vasut <marex@denx.de>
 M:	Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
 M:	Tien Fong Chee <tien.fong.chee@intel.com>
+M:	Tingting Meng <tingting.meng@intel.com>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-socfpga.git
+F:	drivers/ddr/altera/
 F:	arch/arm/mach-socfpga/
 F:	drivers/sysreset/sysreset_socfpga*
 
diff --git a/arch/arm/dts/socfpga_agilex5-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
index 9baf2cbc525..1209a8da4b9 100644
--- a/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
@@ -388,6 +388,230 @@
 			};
 		};
 
+		socfpga_ccu_ddr_interleaving_off: socfpga-ccu-ddr-interleaving-off {
+			compatible = "intel,socfpga-dtreg";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			bootph-all;
+
+			/* DSU */
+			i_ccu_caiu0@1c000000 {
+				reg = <0x1c000000 0x00001000>;
+				intel,offset-settings =
+					/* CAIUAMIGR */
+					<0x000003c0 0x00000003 0x0000001f>,
+					/* DMI_SDRAM_2G */
+					<0x00000460 0x81300006 0xc1f03e1f>,
+					/* DMI_SDRAM_30G */
+					<0x00000480 0x81700006 0xc1f03e1f>,
+					/* DMI_SDRAM_480G */
+					<0x000004a0 0x81b00006 0xc1f03e1f>;
+				bootph-all;
+			};
+
+			/* FPGA2SOC */
+			i_ccu_ncaiu0@1c001000 {
+				reg = <0x1c001000 0x00001000>;
+				intel,offset-settings =
+					/* NCAIU0AMIGR */
+					<0x000003c0 0x00000003 0x0000001f>,
+					/* DMI_SDRAM_2G */
+					<0x00000460 0x81300006 0xc1f03e1f>,
+					/* DMI_SDRAM_30G */
+					<0x00000480 0x81700006 0xc1f03e1f>,
+					/* DMI_SDRAM_480G */
+					<0x000004a0 0x81b00006 0xc1f03e1f>;
+				bootph-all;
+			};
+
+			/* GIC_M */
+			i_ccu_ncaiu1@1c002000 {
+				reg = <0x1c002000 0x00001000>;
+				intel,offset-settings =
+					/* NCAIU1AMIGR */
+					<0x000003c0 0x00000003 0x0000001f>,
+					/* DMI_SDRAM_2G */
+					<0x00000460 0x81300006 0xc1f03e1f>,
+					/* DMI_SDRAM_30G */
+					<0x00000480 0x81700006 0xc1f03e1f>,
+					/* DMI_SDRAM_480G */
+					<0x000004a0 0x81b00006 0xc1f03e1f>;
+				bootph-all;
+			};
+
+			/* SMMU */
+			i_ccu_ncaiu2@1c003000 {
+				reg = <0x1c003000 0x00001000>;
+				intel,offset-settings =
+					/* NCAIU2AMIGR */
+					<0x000003c0 0x00000003 0x0000001f>,
+					/* DMI_SDRAM_2G */
+					<0x00000460 0x81300006 0xc1f03e1f>,
+					/* DMI_SDRAM_30G */
+					<0x00000480 0x81700006 0xc1f03e1f>,
+					/* DMI_SDRAM_480G */
+					<0x000004a0 0x81b00006 0xc1f03e1f>;
+				bootph-all;
+			};
+
+			/* PSS NOC */
+			i_ccu_ncaiu3@1c004000 {
+				reg = <0x1c004000 0x00001000>;
+				intel,offset-settings =
+					/* NCAIU3AMIGR */
+					<0x000003c0 0x00000003 0x0000001f>,
+					/* DMI_SDRAM_2G */
+					<0x00000460 0x81300006 0xc1f03e1f>,
+					/* DMI_SDRAM_30G */
+					<0x00000480 0x81700006 0xc1f03e1f>,
+					/* DMI_SDRAM_480G */
+					<0x000004a0 0x81b00006 0xc1f03e1f>;
+				bootph-all;
+			};
+
+			/* DCE0 */
+			i_ccu_dce0@1c005000 {
+				reg = <0x1c005000 0x00001000>;
+				intel,offset-settings =
+					/* DCEUAMIGR0 */
+					<0x000003c0 0x00000003 0x0000001f>,
+					/* DMI_SDRAM_2G */
+					<0x00000460 0x81300006 0xc1f03e1f>,
+					/* DMI_SDRAM_30G */
+					<0x00000480 0x81700006 0xc1f03e1f>,
+					/* DMI_SDRAM_480G */
+					<0x000004a0 0x81b00006 0xc1f03e1f>;
+				bootph-all;
+			};
+
+			/* DCE1 */
+			i_ccu_dce1@1c006000 {
+				reg = <0x1c006000 0x00001000>;
+				intel,offset-settings =
+					/* DCEUAMIGR1 */
+					<0x000003c0 0x00000003 0x0000001f>,
+					/* DMI_SDRAM_2G */
+					<0x00000460 0x81300006 0xc1f03e1f>,
+					/* DMI_SDRAM_30G */
+					<0x00000480 0x81700006 0xc1f03e1f>,
+					/* DMI_SDRAM_480G */
+					<0x000004a0 0x81b00006 0xc1f03e1f>;
+				bootph-all;
+			};
+		};
+
+		socfpga_ccu_ddr_interleaving_on: socfpga-ccu-ddr-interleaving-on {
+			compatible = "intel,socfpga-dtreg";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			bootph-all;
+
+			/* DSU */
+			i_ccu_caiu0@1c000000 {
+				reg = <0x1c000000 0x00001000>;
+				intel,offset-settings =
+					/* CAIUAMIGR */
+					<0x000003c0 0x00000001 0x0000001f>,
+					/* DMI_SDRAM_2G */
+					<0x00000460 0x81200006 0xc1f03e1f>,
+					/* DMI_SDRAM_30G */
+					<0x00000480 0x81600006 0xc1f03e1f>,
+					/* DMI_SDRAM_480G */
+					<0x000004a0 0x81a00006 0xc1f03e1f>;
+				bootph-all;
+			};
+
+			/* FPGA2SOC */
+			i_ccu_ncaiu0@1c001000 {
+				reg = <0x1c001000 0x00001000>;
+				intel,offset-settings =
+					/* NCAIU0AMIGR */
+					<0x000003c0 0x00000001 0x0000001f>,
+					/* DMI_SDRAM_2G */
+					<0x00000460 0x81200006 0xc1f03e1f>,
+					/* DMI_SDRAM_30G */
+					<0x00000480 0x81600006 0xc1f03e1f>,
+					/* DMI_SDRAM_480G */
+					<0x000004a0 0x81a00006 0xc1f03e1f>;
+				bootph-all;
+			};
+
+			/* GIC_M */
+			i_ccu_ncaiu1@1c002000 {
+				reg = <0x1c002000 0x00001000>;
+				intel,offset-settings =
+					/* NCAIU1AMIGR */
+					<0x000003c0 0x00000001 0x0000001f>,
+					/* DMI_SDRAM_2G */
+					<0x00000460 0x81200006 0xc1f03e1f>,
+					/* DMI_SDRAM_30G */
+					<0x00000480 0x81600006 0xc1f03e1f>,
+					/* DMI_SDRAM_480G */
+					<0x000004a0 0x81a00006 0xc1f03e1f>;
+				bootph-all;
+			};
+
+			/* SMMU */
+			i_ccu_ncaiu2@1c003000 {
+				reg = <0x1c003000 0x00001000>;
+				intel,offset-settings =
+					/* NCAIU2AMIGR */
+					<0x000003c0 0x00000001 0x0000001f>,
+					/* DMI_SDRAM_2G */
+					<0x00000460 0x81200006 0xc1f03e1f>,
+					/* DMI_SDRAM_30G */
+					<0x00000480 0x81600006 0xc1f03e1f>,
+					/* DMI_SDRAM_480G */
+					<0x000004a0 0x81a00006 0xc1f03e1f>;
+				bootph-all;
+			};
+
+			/* PSS NOC */
+			i_ccu_ncaiu3@1c004000 {
+				reg = <0x1c004000 0x00001000>;
+				intel,offset-settings =
+					/* NCAIU3AMIGR */
+					<0x000003c0 0x00000001 0x0000001f>,
+					/* DMI_SDRAM_2G */
+					<0x00000460 0x81200006 0xc1f03e1f>,
+					/* DMI_SDRAM_30G */
+					<0x00000480 0x81600006 0xc1f03e1f>,
+					/* DMI_SDRAM_480G */
+					<0x000004a0 0x81a00006 0xc1f03e1f>;
+				bootph-all;
+			};
+
+			/* DCE0 */
+			i_ccu_dce0@1c005000 {
+				reg = <0x1c005000 0x00001000>;
+				intel,offset-settings =
+					/* DCEUAMIGR0 */
+					<0x000003c0 0x00000001 0x0000001f>,
+					/* DMI_SDRAM_2G */
+					<0x00000460 0x81200006 0xc1f03e1f>,
+					/* DMI_SDRAM_30G */
+					<0x00000480 0x81600006 0xc1f03e1f>,
+					/* DMI_SDRAM_480G */
+					<0x000004a0 0x81a00006 0xc1f03e1f>;
+				bootph-all;
+			};
+
+			/* DCE1 */
+			i_ccu_dce1@1c006000 {
+				reg = <0x1c006000 0x00001000>;
+				intel,offset-settings =
+					/* DCEUAMIGR1 */
+					<0x000003c0 0x00000001 0x0000001f>,
+					/* DMI_SDRAM_2G */
+					<0x00000460 0x81200006 0xc1f03e1f>,
+					/* DMI_SDRAM_30G */
+					<0x00000480 0x81600006 0xc1f03e1f>,
+					/* DMI_SDRAM_480G */
+					<0x000004a0 0x81a00006 0xc1f03e1f>;
+				bootph-all;
+			};
+		};
+
 		socfpga_smmu_secure_config: socfpga-smmu-secure-config {
 			compatible = "intel,socfpga-dtreg";
 			#address-cells = <1>;
@@ -421,6 +645,26 @@
 				bootph-all;
 			};
 		};
+
+		socfpga_noc_fw_mpfe_csr: socfpga-noc-fw-mpfe-csr {
+			compatible = "intel,socfpga-dtreg";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			bootph-all;
+
+			/* noc fw mpfe csr */
+			i_noc_fw_mpfe_csr@18000d00 {
+				reg = <0x18000d00 0x00000100>;
+				intel,offset-settings =
+					/* mpfe scr io96b0 reg*/
+					<0x00000000 0x00000001 0x00010101>,
+					/* mpfe scr io96b1 reg*/
+					<0x00000004 0x00000001 0x00010101>,
+					/* mpfe scr noc csr*/
+					<0x00000008 0x00000001 0x00010101>;
+				bootph-all;
+			};
+		};
 	};
 };
 
@@ -466,6 +710,13 @@
 	bootph-all;
 };
 
+&sdr {
+	compatible = "intel,sdr-ctl-agilex5";
+	reg = <0x18000000 0x400000>;
+	resets = <&rst DDRSCH_RESET>;
+	bootph-all;
+};
+
 &sysmgr {
 	compatible = "altr,sys-mgr", "syscon";
 	bootph-all;
diff --git a/arch/arm/dts/socfpga_agilex5.dtsi b/arch/arm/dts/socfpga_agilex5.dtsi
index 03b55040497..4f17d8fc21e 100644
--- a/arch/arm/dts/socfpga_agilex5.dtsi
+++ b/arch/arm/dts/socfpga_agilex5.dtsi
@@ -544,6 +544,13 @@
 			status = "disabled";
 		};
 
+		sdr: sdr@18000000 {
+			compatible = "intel,sdr-ctl-agilex5";
+			reg = <0x18000000 0x400000>;
+			resets = <&rst DDRSCH_RESET>;
+			bootph-all;
+		};
+
 		/* QSPI address not available yet */
 		qspi: spi@108d2000 {
 			compatible = "cdns,qspi-nor";
diff --git a/arch/arm/mach-socfpga/include/mach/firewall.h b/arch/arm/mach-socfpga/include/mach/firewall.h
index 5cb7f23f8f0..9c3f3313af6 100644
--- a/arch/arm/mach-socfpga/include/mach/firewall.h
+++ b/arch/arm/mach-socfpga/include/mach/firewall.h
@@ -1,7 +1,6 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
- * Copyright (C) 2017-2019 Intel Corporation <www.intel.com>
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2017-2024 Intel Corporation <www.intel.com>
  */
 
 #ifndef	_FIREWALL_H_
@@ -126,11 +125,27 @@ struct socfpga_firwall_l4_sys {
 #define FW_MPU_DDR_SCR_NONMPUREGION0ADDR_LIMITEXT	0x9c
 #define FW_MPU_DDR_SCR_NONMPUREGION0ADDR_LIMITEXT_FIELD	0xff
 
+/* Firewall F2SDRAM DDR SCR registers */
+#define FW_F2SDRAM_DDR_SCR_EN				0x00
+#define FW_F2SDRAM_DDR_SCR_EN_SET			0x04
+#define FW_F2SDRAM_DDR_SCR_REGION0ADDR_BASE		0x10
+#define FW_F2SDRAM_DDR_SCR_REGION0ADDR_BASEEXT		0x14
+#define FW_F2SDRAM_DDR_SCR_REGION0ADDR_LIMIT		0x18
+#define FW_F2SDRAM_DDR_SCR_REGION0ADDR_LIMITEXT		0x1c
+
 #define MPUREGION0_ENABLE				BIT(0)
 #define NONMPUREGION0_ENABLE				BIT(8)
 
+#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
+#define FW_MPU_DDR_SCR_WRITEL(data, reg)		\
+	writel(data, SOCFPGA_FW_DDR_CCU_DMI0_ADDRESS + (reg)); \
+	writel(data, SOCFPGA_FW_DDR_CCU_DMI1_ADDRESS + (reg))
+#define FW_F2SDRAM_DDR_SCR_WRITEL(data, reg)		\
+	writel(data, SOCFPGA_FW_TBU2NOC_ADDRESS + (reg))
+#else
 #define FW_MPU_DDR_SCR_WRITEL(data, reg)		\
 	writel(data, SOCFPGA_FW_MPU_DDR_SCR_ADDRESS + (reg))
+#endif
 
 void firewall_setup(void);
 
diff --git a/drivers/ddr/altera/Makefile b/drivers/ddr/altera/Makefile
index 9fa5d85a27e..117868b6d01 100644
--- a/drivers/ddr/altera/Makefile
+++ b/drivers/ddr/altera/Makefile
@@ -12,4 +12,5 @@ obj-$(CONFIG_TARGET_SOCFPGA_ARRIA10) += sdram_arria10.o
 obj-$(CONFIG_TARGET_SOCFPGA_STRATIX10) += sdram_soc64.o sdram_s10.o
 obj-$(CONFIG_TARGET_SOCFPGA_AGILEX) += sdram_soc64.o sdram_agilex.o
 obj-$(CONFIG_TARGET_SOCFPGA_N5X) += sdram_soc64.o sdram_n5x.o
+obj-$(CONFIG_TARGET_SOCFPGA_AGILEX5) += sdram_soc64.o sdram_agilex5.o iossm_mailbox.o
 endif
diff --git a/drivers/ddr/altera/iossm_mailbox.c b/drivers/ddr/altera/iossm_mailbox.c
new file mode 100644
index 00000000000..5e76246dcca
--- /dev/null
+++ b/drivers/ddr/altera/iossm_mailbox.c
@@ -0,0 +1,613 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Intel Corporation <www.intel.com>
+ */
+
+#include <hang.h>
+#include <string.h>
+#include <wait_bit.h>
+#include <asm/arch/base_addr_soc64.h>
+#include <asm/io.h>
+#include <linux/bitfield.h>
+#include "iossm_mailbox.h"
+
+#define ECC_INTSTATUS_SERR SOCFPGA_SYSMGR_ADDRESS + 0x9C
+#define ECC_INISTATUS_DERR SOCFPGA_SYSMGR_ADDRESS + 0xA0
+#define ECC_UNCONRRECTABLE_ERROR_MASK \
+	BIT(2) + BIT(3) + BIT(6) + BIT(10) + BIT(12) + BIT(13)
+#define DDR_CSR_CLKGEN_LOCKED_IO96B0_MASK BIT(16)
+#define DDR_CSR_CLKGEN_LOCKED_IO96B1_MASK BIT(17)
+
+#define IO96B_MB_REQ_SETUP(v, w, x, y, z) \
+	usr_req.ip_type = v; \
+	usr_req.ip_id = w; \
+	usr_req.usr_cmd_type = x; \
+	usr_req.usr_cmd_opcode = y; \
+	usr_req.cmd_param[0] = z; \
+	for (n = 1; n < NUM_CMD_PARAM; n++) \
+		usr_req.cmd_param[n] = 0
+#define MAX_RETRY_COUNT 3
+#define NUM_CMD_RESPONSE_DATA 3
+
+#define IO96B0_PLL_A_MASK	BIT(0)
+#define IO96B0_PLL_B_MASK	BIT(1)
+#define IO96B1_PLL_A_MASK	BIT(2)
+#define IO96B1_PLL_B_MASK	BIT(3)
+
+/* supported DDR type list */
+static const char *ddr_type_list[7] = {
+		"DDR4", "DDR5", "DDR5_RDIMM", "LPDDR4", "LPDDR5", "QDRIV", "UNKNOWN"
+};
+
+static int is_ddr_csr_clkgen_locked(u8 io96b_pll)
+{
+	int ret = 0;
+	const char *pll_names[MAX_IO96B_SUPPORTED][2] = {
+		{"io96b_0 clkgenA", "io96b_0 clkgenB"},
+		{"io96b_1 clkgenA", "io96b_1 clkgenB"}
+	};
+	u32 masks[MAX_IO96B_SUPPORTED][2] = {
+		{IO96B0_PLL_A_MASK, IO96B0_PLL_B_MASK},
+		{IO96B1_PLL_A_MASK, IO96B1_PLL_B_MASK}
+	};
+	u32 lock_masks[MAX_IO96B_SUPPORTED] = {
+		DDR_CSR_CLKGEN_LOCKED_IO96B0_MASK,
+		DDR_CSR_CLKGEN_LOCKED_IO96B1_MASK
+	};
+
+	for (int i = 0; i < MAX_IO96B_SUPPORTED ; i++) {
+		/* Check for PLL_A */
+		if (io96b_pll & masks[i][0]) {
+			ret = wait_for_bit_le32((const void *)(ECC_INTSTATUS_SERR), lock_masks[i],
+						true, TIMEOUT, false);
+
+			if (ret) {
+				debug("%s: ddr csr %s locked is timeout\n",
+				      __func__, pll_names[i][0]);
+				goto err;
+			} else {
+				debug("%s: ddr csr %s is successfully locked\n",
+				      __func__, pll_names[i][0]);
+			}
+		}
+
+		/* Check for PLL_B */
+		if (io96b_pll & masks[i][1]) {
+			ret = wait_for_bit_le32((const void *)(ECC_INISTATUS_DERR), lock_masks[i],
+						true, TIMEOUT, false);
+
+			if (ret) {
+				debug("%s: ddr csr %s locked is timeout\n",
+				      __func__, pll_names[i][1]);
+				goto err;
+			} else {
+				debug("%s: ddr csr %s is successfully locked\n",
+				      __func__, pll_names[i][1]);
+			}
+		}
+	}
+
+err:
+	return ret;
+}
+
+/*
+ * Mailbox request function
+ * This function will send the request to IOSSM mailbox and wait for response return
+ *
+ * @io96b_csr_addr: CSR address for the target IO96B
+ * @req:            Structure contain command request for IOSSM mailbox command
+ * @resp_data_len:  User desire extra response data fields other than
+ *		    CMD_RESPONSE_DATA_SHORT field on CMD_RESPONSE_STATUS
+ * @resp:           Structure contain responses returned from the requested IOSSM
+ *		    mailbox command
+ */
+int io96b_mb_req(phys_addr_t io96b_csr_addr, struct io96b_mb_req req,
+		 u32 resp_data_len, struct io96b_mb_resp *resp)
+{
+	int i, ret;
+	u32 cmd_req;
+
+	if (!resp) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	/* Zero initialization for responses */
+	resp->cmd_resp_status = 0;
+
+	/* Ensure CMD_REQ is cleared before write any command request */
+	ret = wait_for_bit_le32((const void *)(io96b_csr_addr + IOSSM_CMD_REQ_OFFSET),
+				GENMASK(31, 0), false, TIMEOUT, false);
+	if (ret) {
+		printf("%s: Timeout of waiting DDR mailbox ready to be functioned!\n",
+		       __func__);
+		goto err;
+	}
+
+	/* Write CMD_PARAM_* */
+	for (i = 0; i < NUM_CMD_PARAM ; i++) {
+		switch (i) {
+		case 0:
+			if (req.cmd_param[0])
+				writel(req.cmd_param[0], io96b_csr_addr + IOSSM_CMD_PARAM_0_OFFSET);
+			break;
+		case 1:
+			if (req.cmd_param[1])
+				writel(req.cmd_param[1], io96b_csr_addr + IOSSM_CMD_PARAM_1_OFFSET);
+			break;
+		case 2:
+			if (req.cmd_param[2])
+				writel(req.cmd_param[2], io96b_csr_addr + IOSSM_CMD_PARAM_2_OFFSET);
+			break;
+		case 3:
+			if (req.cmd_param[3])
+				writel(req.cmd_param[3], io96b_csr_addr + IOSSM_CMD_PARAM_3_OFFSET);
+			break;
+		case 4:
+			if (req.cmd_param[4])
+				writel(req.cmd_param[4], io96b_csr_addr + IOSSM_CMD_PARAM_4_OFFSET);
+			break;
+		case 5:
+			if (req.cmd_param[5])
+				writel(req.cmd_param[5], io96b_csr_addr + IOSSM_CMD_PARAM_5_OFFSET);
+			break;
+		case 6:
+			if (req.cmd_param[6])
+				writel(req.cmd_param[6], io96b_csr_addr + IOSSM_CMD_PARAM_6_OFFSET);
+			break;
+		default:
+			printf("%s: Invalid command parameter\n", __func__);
+		}
+	}
+
+	/* Write CMD_REQ (IP_TYPE, IP_INSTANCE_ID, CMD_TYPE and CMD_OPCODE) */
+	cmd_req = FIELD_PREP(CMD_TARGET_IP_TYPE_MASK, req.ip_type) |
+		FIELD_PREP(CMD_TARGET_IP_INSTANCE_ID_MASK, req.ip_id) |
+		FIELD_PREP(CMD_TYPE_MASK, req.usr_cmd_type) |
+		FIELD_PREP(CMD_OPCODE_MASK, req.usr_cmd_opcode);
+	writel(cmd_req, io96b_csr_addr + IOSSM_CMD_REQ_OFFSET);
+
+	debug("%s: Write 0x%x to IOSSM_CMD_REQ_OFFSET 0x%llx\n", __func__, cmd_req,
+	      io96b_csr_addr + IOSSM_CMD_REQ_OFFSET);
+
+	/* Read CMD_RESPONSE_READY in CMD_RESPONSE_STATUS */
+	ret = wait_for_bit_le32((const void *)(io96b_csr_addr + IOSSM_CMD_RESPONSE_STATUS_OFFSET),
+				IOSSM_STATUS_COMMAND_RESPONSE_READY, true, TIMEOUT, false);
+
+	/* read CMD_RESPONSE_STATUS */
+	resp->cmd_resp_status = readl(io96b_csr_addr + IOSSM_CMD_RESPONSE_STATUS_OFFSET);
+
+	debug("%s: CMD_RESPONSE_STATUS 0x%llx: 0x%x\n", __func__, io96b_csr_addr +
+	      IOSSM_CMD_RESPONSE_STATUS_OFFSET, resp->cmd_resp_status);
+
+	if (ret) {
+		printf("%s: CMD_RESPONSE ERROR:\n", __func__);
+
+		printf("%s: STATUS_GENERAL_ERROR: 0x%lx\n", __func__,
+		       IOSSM_STATUS_GENERAL_ERROR(resp->cmd_resp_status));
+		printf("%s: STATUS_CMD_RESPONSE_ERROR: 0x%lx\n", __func__,
+		       IOSSM_STATUS_CMD_RESPONSE_ERROR(resp->cmd_resp_status));
+		goto err;
+	}
+
+	/* read CMD_RESPONSE_DATA_* */
+	for (i = 0; i < resp_data_len; i++) {
+		switch (i) {
+		case 0:
+			resp->cmd_resp_data[i] =
+					readl(io96b_csr_addr + IOSSM_CMD_RESPONSE_DATA_0_OFFSET);
+
+			debug("%s: IOSSM_CMD_RESPONSE_DATA_0_OFFSET 0x%llx: 0x%x\n", __func__,
+			      io96b_csr_addr + IOSSM_CMD_RESPONSE_DATA_0_OFFSET,
+			      resp->cmd_resp_data[i]);
+			break;
+		case 1:
+			resp->cmd_resp_data[i] =
+					readl(io96b_csr_addr + IOSSM_CMD_RESPONSE_DATA_1_OFFSET);
+
+			debug("%s: IOSSM_CMD_RESPONSE_DATA_1_OFFSET 0x%llx: 0x%x\n", __func__,
+			      io96b_csr_addr + IOSSM_CMD_RESPONSE_DATA_1_OFFSET,
+			      resp->cmd_resp_data[i]);
+			break;
+		case 2:
+			resp->cmd_resp_data[i] =
+					readl(io96b_csr_addr + IOSSM_CMD_RESPONSE_DATA_2_OFFSET);
+
+			debug("%s: IOSSM_CMD_RESPONSE_DATA_2_OFFSET 0x%llx: 0x%x\n", __func__,
+			      io96b_csr_addr + IOSSM_CMD_RESPONSE_DATA_2_OFFSET,
+			      resp->cmd_resp_data[i]);
+			break;
+		default:
+			resp->cmd_resp_data[i] = 0;
+			printf("%s: Invalid response data\n", __func__);
+		}
+	}
+
+	/* write CMD_RESPONSE_READY = 0 */
+	clrbits_le32((u32 *)(uintptr_t)(io96b_csr_addr + IOSSM_CMD_RESPONSE_STATUS_OFFSET),
+		     IOSSM_STATUS_COMMAND_RESPONSE_READY);
+
+	debug("%s: After clear CMD_RESPONSE_READY bit: 0x%llx: 0x%x\n", __func__,
+	      io96b_csr_addr + IOSSM_CMD_RESPONSE_STATUS_OFFSET,
+	      readl(io96b_csr_addr + IOSSM_CMD_RESPONSE_STATUS_OFFSET));
+
+err:
+	return ret;
+}
+
+/*
+ * Initial function to be called to set memory interface IP type and instance ID
+ * IP type and instance ID need to be determined before sending mailbox command
+ */
+void io96b_mb_init(struct io96b_info *io96b_ctrl)
+{
+	struct io96b_mb_req usr_req;
+	struct io96b_mb_resp usr_resp;
+	u8 ip_type_ret, instance_id_ret;
+	int i, j, k, n, ret;
+
+	debug("%s: num_instance %d\n", __func__, io96b_ctrl->num_instance);
+
+	for (i = 0; i < io96b_ctrl->num_instance; i++) {
+		debug("%s: get memory interface IO96B %d\n", __func__, i);
+
+		IO96B_MB_REQ_SETUP(0, 0, CMD_GET_SYS_INFO, GET_MEM_INTF_INFO, 0);
+
+		/* Get memory interface IP type and instance ID (IP identifier) */
+		ret = io96b_mb_req(io96b_ctrl->io96b[i].io96b_csr_addr, usr_req, 2, &usr_resp);
+		if (ret) {
+			printf("%s: get memory interface IO96B %d failed\n", __func__, i);
+			hang();
+		}
+
+		debug("%s: get response from memory interface IO96B %d\n", __func__, i);
+
+		/* Retrieve number of memory interface(s) */
+		io96b_ctrl->io96b[i].mb_ctrl.num_mem_interface =
+			IOSSM_CMD_RESPONSE_DATA_SHORT(usr_resp.cmd_resp_status) & 0x3;
+
+		debug("%s: IO96B %d: num_mem_interface: 0x%x\n", __func__, i,
+		      io96b_ctrl->io96b[i].mb_ctrl.num_mem_interface);
+
+		/* Retrieve memory interface IP type and instance ID (IP identifier) */
+		j = 0;
+		for (k = 0; k < io96b_ctrl->io96b[i].mb_ctrl.num_mem_interface; k++) {
+			ip_type_ret = FIELD_GET(INTF_IP_TYPE_MASK, usr_resp.cmd_resp_data[k]);
+			instance_id_ret = FIELD_GET(INTF_INSTANCE_ID_MASK,
+						    usr_resp.cmd_resp_data[k]);
+
+			if (ip_type_ret) {
+				io96b_ctrl->io96b[i].mb_ctrl.ip_type[j] = ip_type_ret;
+				io96b_ctrl->io96b[i].mb_ctrl.ip_id[j] = instance_id_ret;
+
+				debug("%s: IO96B %d mem_interface %d: ip_type_ret: 0x%x\n",
+				      __func__, i, j, ip_type_ret);
+				debug("%s: IO96B %d mem_interface %d: instance_id_ret: 0x%x\n",
+				      __func__, i, j, instance_id_ret);
+
+				j++;
+			}
+		}
+	}
+}
+
+int io96b_cal_status(phys_addr_t addr)
+{
+	u32 cal_success, cal_fail;
+	phys_addr_t status_addr = addr + IOSSM_STATUS_OFFSET;
+	u32 start = get_timer(0);
+
+	do {
+		if (get_timer(start) > TIMEOUT_60000MS) {
+			printf("%s: SDRAM calibration for IO96B instance 0x%llx timeout!\n",
+			       __func__, status_addr);
+			hang();
+		}
+
+		udelay(1);
+		schedule();
+
+		/* Polling until getting any calibration result */
+		cal_success = readl(status_addr) & IOSSM_STATUS_CAL_SUCCESS;
+		cal_fail = readl(status_addr) & IOSSM_STATUS_CAL_FAIL;
+	} while (!cal_success && !cal_fail);
+
+	debug("%s: Calibration for IO96B instance 0x%llx done at %ld msec!\n",
+	      __func__,  status_addr, get_timer(start));
+
+	if (cal_success && !cal_fail)
+		return 0;
+	else
+		return -EPERM;
+}
+
+void init_mem_cal(struct io96b_info *io96b_ctrl)
+{
+	int count, i, ret;
+
+	/* Initialize overall calibration status */
+	io96b_ctrl->overall_cal_status = false;
+
+	if (io96b_ctrl->ckgen_lock) {
+		ret = is_ddr_csr_clkgen_locked(io96b_ctrl->io96b_pll);
+		if (ret) {
+			printf("%s: iossm IO96B ckgena_lock is not locked\n", __func__);
+			hang();
+		}
+	}
+
+	/* Check initial calibration status for the assigned IO96B */
+	count = 0;
+	for (i = 0; i < io96b_ctrl->num_instance; i++) {
+		ret = io96b_cal_status(io96b_ctrl->io96b[i].io96b_csr_addr);
+		if (ret) {
+			io96b_ctrl->io96b[i].cal_status = false;
+
+			printf("%s: Initial DDR calibration IO96B_%d failed %d\n", __func__,
+			       i, ret);
+
+			hang();
+		}
+
+		io96b_ctrl->io96b[i].cal_status = true;
+
+		printf("%s: Initial DDR calibration IO96B_%d succeed\n", __func__, i);
+
+		count++;
+	}
+
+	if (count == io96b_ctrl->num_instance)
+		io96b_ctrl->overall_cal_status = true;
+}
+
+int get_mem_technology(struct io96b_info *io96b_ctrl)
+{
+	struct io96b_mb_req usr_req;
+	struct io96b_mb_resp usr_resp;
+	int i, j, n, ret = 0;
+	u8 ddr_type_ret;
+
+	/* Initialize ddr type */
+	io96b_ctrl->ddr_type = ddr_type_list[6];
+
+	/* Get and ensure all memory interface(s) same DDR type */
+	for (i = 0; i < io96b_ctrl->num_instance; i++) {
+		for (j = 0; j < io96b_ctrl->io96b[i].mb_ctrl.num_mem_interface; j++) {
+			IO96B_MB_REQ_SETUP(io96b_ctrl->io96b[i].mb_ctrl.ip_type[j],
+					   io96b_ctrl->io96b[i].mb_ctrl.ip_id[j],
+					   CMD_GET_MEM_INFO, GET_MEM_TECHNOLOGY, 0);
+
+			ret = io96b_mb_req(io96b_ctrl->io96b[i].io96b_csr_addr, usr_req,
+					   0, &usr_resp);
+
+			if (ret)
+				goto err;
+
+			ddr_type_ret =
+				IOSSM_CMD_RESPONSE_DATA_SHORT(usr_resp.cmd_resp_status)
+				& GENMASK(2, 0);
+
+			if (!strcmp(io96b_ctrl->ddr_type, "UNKNOWN"))
+				io96b_ctrl->ddr_type = ddr_type_list[ddr_type_ret];
+
+			if (ddr_type_list[ddr_type_ret] != io96b_ctrl->ddr_type) {
+				printf("%s: Mismatch DDR type on IO96B_%d\n", __func__, i);
+
+				ret = -EINVAL;
+				goto err;
+			}
+		}
+	}
+
+err:
+	return ret;
+}
+
+int get_mem_width_info(struct io96b_info *io96b_ctrl)
+{
+	struct io96b_mb_req usr_req;
+	struct io96b_mb_resp usr_resp;
+	int i, j, n, ret = 0;
+	u16 memory_size;
+	u16 total_memory_size = 0;
+
+	/* Get all memory interface(s) total memory size on all instance(s) */
+	for (i = 0; i < io96b_ctrl->num_instance; i++) {
+		memory_size = 0;
+		for (j = 0; j < io96b_ctrl->io96b[i].mb_ctrl.num_mem_interface; j++) {
+			IO96B_MB_REQ_SETUP(io96b_ctrl->io96b[i].mb_ctrl.ip_type[j],
+					   io96b_ctrl->io96b[i].mb_ctrl.ip_id[j],
+					   CMD_GET_MEM_INFO, GET_MEM_WIDTH_INFO, 0);
+
+			ret = io96b_mb_req(io96b_ctrl->io96b[i].io96b_csr_addr, usr_req,
+					   2, &usr_resp);
+
+			if (ret)
+				goto err;
+
+			memory_size = memory_size +
+					(usr_resp.cmd_resp_data[1] & GENMASK(7, 0));
+		}
+
+		if (!memory_size) {
+			printf("%s: Failed to get valid memory size\n", __func__);
+			ret = -EINVAL;
+			goto err;
+		}
+
+		io96b_ctrl->io96b[i].size = memory_size;
+
+		total_memory_size = total_memory_size + memory_size;
+	}
+
+	if (!total_memory_size) {
+		printf("%s: Failed to get valid memory size\n", __func__);
+		ret = -EINVAL;
+	}
+
+	io96b_ctrl->overall_size = total_memory_size;
+
+err:
+	return ret;
+}
+
+int ecc_enable_status(struct io96b_info *io96b_ctrl)
+{
+	struct io96b_mb_req usr_req;
+	struct io96b_mb_resp usr_resp;
+	int i, j, n, ret = 0;
+	bool ecc_stat_set = false;
+	bool ecc_stat;
+
+	/* Initialize ECC status */
+	io96b_ctrl->ecc_status = false;
+
+	/* Get and ensure all memory interface(s) same ECC status */
+	for (i = 0; i < io96b_ctrl->num_instance; i++) {
+		for (j = 0; j < io96b_ctrl->io96b[i].mb_ctrl.num_mem_interface; j++) {
+			IO96B_MB_REQ_SETUP(io96b_ctrl->io96b[i].mb_ctrl.ip_type[j],
+					   io96b_ctrl->io96b[i].mb_ctrl.ip_id[j],
+					   CMD_TRIG_CONTROLLER_OP, ECC_ENABLE_STATUS, 0);
+
+			ret = io96b_mb_req(io96b_ctrl->io96b[i].io96b_csr_addr,
+					   usr_req, 0, &usr_resp);
+
+			if (ret)
+				goto err;
+
+			ecc_stat = (IOSSM_CMD_RESPONSE_DATA_SHORT(usr_resp.cmd_resp_status)
+					& GENMASK(1, 0)) == 0 ? false : true;
+
+			if (!ecc_stat_set) {
+				io96b_ctrl->ecc_status = ecc_stat;
+				ecc_stat_set = true;
+			}
+
+			if (ecc_stat != io96b_ctrl->ecc_status) {
+				printf("%s: Mismatch DDR ECC status on IO96B_%d\n", __func__, i);
+
+				ret = -EINVAL;
+				goto err;
+			}
+		}
+	}
+
+	debug("%s: ECC enable status: %d\n", __func__, io96b_ctrl->ecc_status);
+
+err:
+	return ret;
+}
+
+int ecc_interrupt_status(struct io96b_info *io96b_ctrl, bool *ecc_error_flag)
+{
+	struct io96b_mb_req usr_req;
+	struct io96b_mb_resp usr_resp;
+	int i, j, n, ret = 0;
+	u32 uncorrectable_error;
+
+	for (i = 0; i < io96b_ctrl->num_instance; i++) {
+		for (j = 0; j < io96b_ctrl->io96b[i].mb_ctrl.num_mem_interface; j++) {
+			IO96B_MB_REQ_SETUP(io96b_ctrl->io96b[i].mb_ctrl.ip_type[j],
+					   io96b_ctrl->io96b[i].mb_ctrl.ip_id[j],
+					   CMD_TRIG_CONTROLLER_OP, ECC_INTERRUPT_STATUS, 0);
+
+			ret = io96b_mb_req(io96b_ctrl->io96b[i].io96b_csr_addr,
+					   usr_req, 1, &usr_resp);
+
+			if (ret)
+				goto err;
+
+			uncorrectable_error = (usr_resp.cmd_resp_data[0]) &
+				(ECC_UNCONRRECTABLE_ERROR_MASK);
+			debug("%s: IO96B %d mem_interface %d: ECC error status:0x%08x\n",
+			      __func__, i, j, uncorrectable_error);
+
+			if (uncorrectable_error) {
+				*ecc_error_flag = true;
+				printf("DDR: ECC un-correctable error detected on IO96B_%d\n",
+				       i);
+				goto err;
+			}
+		}
+	}
+
+	*ecc_error_flag = false;
+
+err:
+	return ret;
+}
+
+int bist_mem_init_start(struct io96b_info *io96b_ctrl)
+{
+	struct io96b_mb_req usr_req;
+	struct io96b_mb_resp usr_resp;
+	int i, j, n, ret = 0;
+	bool bist_start, bist_success;
+	u32 start;
+
+	/* Full memory initialization BIST performed on all memory interface(s) */
+	for (i = 0; i < io96b_ctrl->num_instance; i++) {
+		for (j = 0; j < io96b_ctrl->io96b[i].mb_ctrl.num_mem_interface; j++) {
+			bist_start = false;
+			bist_success = false;
+
+			/* Start memory initialization BIST on full memory address */
+			IO96B_MB_REQ_SETUP(io96b_ctrl->io96b[i].mb_ctrl.ip_type[j],
+					   io96b_ctrl->io96b[i].mb_ctrl.ip_id[j],
+					   CMD_TRIG_CONTROLLER_OP, BIST_MEM_INIT_START,
+					   BIST_FULL_MEM);
+
+			ret = io96b_mb_req(io96b_ctrl->io96b[i].io96b_csr_addr,
+					   usr_req, 0, &usr_resp);
+			if (ret)
+				goto err;
+
+			bist_start = IOSSM_CMD_RESPONSE_DATA_SHORT(usr_resp.cmd_resp_status)
+				& BIT(0);
+
+			if (!bist_start) {
+				printf("%s: Failed to initialize memory on IO96B_%d\n", __func__,
+				       i);
+				printf("%s: BIST_MEM_INIT_START Error code 0x%lx\n", __func__,
+				       IOSSM_STATUS_CMD_RESPONSE_ERROR(usr_resp.cmd_resp_status));
+
+				ret = -EINVAL;
+				goto err;
+			}
+
+			/* Polling for the initiated memory initialization BIST status */
+			start = get_timer(0);
+			while (!bist_success) {
+				IO96B_MB_REQ_SETUP(io96b_ctrl->io96b[i].mb_ctrl.ip_type[j],
+						   io96b_ctrl->io96b[i].mb_ctrl.ip_id[j],
+						   CMD_TRIG_CONTROLLER_OP, BIST_MEM_INIT_STATUS, 0);
+
+				io96b_mb_req(io96b_ctrl->io96b[i].io96b_csr_addr, usr_req, 0,
+					     &usr_resp);
+
+				bist_success =
+					IOSSM_CMD_RESPONSE_DATA_SHORT(usr_resp.cmd_resp_status)
+					& BIT(0);
+
+				if (!bist_success && (get_timer(start) > TIMEOUT)) {
+					printf("%s: Timeout initialize memory on IO96B_%d\n",
+					       __func__, i);
+					printf("%s: BIST_MEM_INIT_STATUS Error code 0x%lx\n",
+					       __func__,
+					IOSSM_STATUS_CMD_RESPONSE_ERROR(usr_resp.cmd_resp_status));
+
+					ret = -ETIMEDOUT;
+					goto err;
+				}
+
+				udelay(1);
+			}
+		}
+
+		debug("%s: Memory initialized successfully on IO96B_%d\n", __func__, i);
+	}
+
+err:
+	return ret;
+}
diff --git a/drivers/ddr/altera/iossm_mailbox.h b/drivers/ddr/altera/iossm_mailbox.h
new file mode 100644
index 00000000000..49320f8211b
--- /dev/null
+++ b/drivers/ddr/altera/iossm_mailbox.h
@@ -0,0 +1,186 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2024 Intel Corporation <www.intel.com>
+ */
+
+#define TIMEOUT_120000MS			120000
+#define TIMEOUT_60000MS				60000
+#define TIMEOUT					TIMEOUT_120000MS
+#define IOSSM_STATUS_CAL_SUCCESS		BIT(0)
+#define IOSSM_STATUS_CAL_FAIL			BIT(1)
+#define IOSSM_STATUS_CAL_BUSY			BIT(2)
+#define IOSSM_STATUS_COMMAND_RESPONSE_READY	BIT(0)
+#define IOSSM_CMD_RESPONSE_STATUS_OFFSET	0x45C
+#define IOSSM_CMD_RESPONSE_DATA_0_OFFSET	0x458
+#define IOSSM_CMD_RESPONSE_DATA_1_OFFSET	0x454
+#define IOSSM_CMD_RESPONSE_DATA_2_OFFSET	0x450
+#define IOSSM_CMD_REQ_OFFSET			0x43C
+#define IOSSM_CMD_PARAM_0_OFFSET		0x438
+#define IOSSM_CMD_PARAM_1_OFFSET		0x434
+#define IOSSM_CMD_PARAM_2_OFFSET		0x430
+#define IOSSM_CMD_PARAM_3_OFFSET		0x42C
+#define IOSSM_CMD_PARAM_4_OFFSET		0x428
+#define IOSSM_CMD_PARAM_5_OFFSET		0x424
+#define IOSSM_CMD_PARAM_6_OFFSET		0x420
+#define IOSSM_STATUS_OFFSET			0x400
+#define IOSSM_CMD_RESPONSE_DATA_SHORT_MASK	GENMASK(31, 16)
+#define IOSSM_CMD_RESPONSE_DATA_SHORT(n)	FIELD_GET(IOSSM_CMD_RESPONSE_DATA_SHORT_MASK, n)
+#define IOSSM_STATUS_CMD_RESPONSE_ERROR_MASK	GENMASK(7, 5)
+#define IOSSM_STATUS_CMD_RESPONSE_ERROR(n)	FIELD_GET(IOSSM_STATUS_CMD_RESPONSE_ERROR_MASK, n)
+#define IOSSM_STATUS_GENERAL_ERROR_MASK		GENMASK(4, 1)
+#define IOSSM_STATUS_GENERAL_ERROR(n)		FIELD_GET(IOSSM_STATUS_GENERAL_ERROR_MASK, n)
+#define MAX_IO96B_SUPPORTED			2
+#define NUM_CMD_RESPONSE_DATA			3
+#define NUM_CMD_PARAM				6
+
+/* supported mailbox command type */
+enum iossm_mailbox_cmd_type  {
+	CMD_NOP,
+	CMD_GET_SYS_INFO,
+	CMD_GET_MEM_INFO,
+	CMD_GET_MEM_CAL_INFO,
+	CMD_TRIG_CONTROLLER_OP,
+	CMD_TRIG_MEM_CAL_OP
+};
+
+/* supported mailbox command opcode */
+enum iossm_mailbox_cmd_opcode  {
+	GET_MEM_INTF_INFO = 0x0001,
+	GET_MEM_TECHNOLOGY,
+	GET_MEMCLK_FREQ_KHZ,
+	GET_MEM_WIDTH_INFO,
+	ECC_ENABLE_SET = 0x0101,
+	ECC_ENABLE_STATUS,
+	ECC_INTERRUPT_STATUS,
+	ECC_INTERRUPT_ACK,
+	ECC_INTERRUPT_MASK,
+	ECC_WRITEBACK_ENABLE,
+	ECC_GET_SBE_INFO,
+	ECC_GET_DBE_INFO,
+	ECC_INJECT_ERROR,
+	ECC_SCRUB_IN_PROGRESS_STATUS = 0x0201,
+	ECC_SCRUB_MODE_0_START,
+	ECC_SCRUB_MODE_1_START,
+	BIST_STANDARD_MODE_START = 0x0301,
+	BIST_RESULTS_STATUS,
+	BIST_MEM_INIT_START,
+	BIST_MEM_INIT_STATUS,
+	BIST_SET_DATA_PATTERN_UPPER,
+	BIST_SET_DATA_PATTERN_LOWER,
+	TRIG_MEM_CAL = 0x000a,
+	GET_MEM_CAL_STATUS
+};
+
+/* response data of cmd opcode GET_MEM_INTF_INFO */
+#define INTF_IP_TYPE_MASK		GENMASK(31, 29)
+#define INTF_INSTANCE_ID_MASK		GENMASK(28, 24)
+
+/* response data of cmd opcode GET_MEM_CAL_STATUS */
+#define INTF_UNUSED			0x0
+#define INTF_MEM_CAL_STATUS_SUCCESS	0x1
+#define INTF_MEM_CAL_STATUS_FAIL	0x2
+#define INTF_MEM_CAL_STATUS_ONGOING	0x4
+
+/* cmd opcode BIST_MEM_INIT_START, BIST performed on full memory address range */
+#define BIST_FULL_MEM			BIT(6)
+
+/*
+ * IOSSM mailbox required information
+ *
+ * @num_mem_interface:	Number of memory interfaces instantiated
+ * @ip_type:		IP type implemented on the IO96B
+ * @ip_instance_id:	IP identifier for every IP instance implemented on the IO96B
+ */
+struct io96b_mb_ctrl {
+	u32 num_mem_interface;
+	u32 ip_type[2];
+	u32 ip_id[2];
+};
+
+/* CMD_REQ Register Definition */
+#define CMD_TARGET_IP_TYPE_MASK		GENMASK(31, 29)
+#define CMD_TARGET_IP_INSTANCE_ID_MASK	GENMASK(28, 24)
+#define CMD_TYPE_MASK			GENMASK(23, 16)
+#define CMD_OPCODE_MASK			GENMASK(15, 0)
+
+/*
+ * IOSSM mailbox request
+ * @ip_type:	    IP type for the specified memory interface
+ * @ip_id:	    IP instance ID for the specified memory interface
+ * @usr_cmd_type:   User desire IOSSM mailbox command type
+ * @usr_cmd_opcode: User desire IOSSM mailbox command opcode
+ * @cmd_param_*:    Parameters (if applicable) for the requested IOSSM mailbox command
+ */
+struct io96b_mb_req {
+	u32 ip_type;
+	u32 ip_id;
+	u32 usr_cmd_type;
+	u32 usr_cmd_opcode;
+	u32 cmd_param[NUM_CMD_PARAM];
+};
+
+/*
+ * IOSSM mailbox response outputs
+ *
+ * @cmd_resp_status: Command Interface status
+ * @cmd_resp_data_*: More spaces for command response
+ */
+struct io96b_mb_resp {
+	u32 cmd_resp_status;
+	u32 cmd_resp_data[NUM_CMD_RESPONSE_DATA];
+};
+
+/*
+ * IO96B instance specific information
+ *
+ * @size:		Memory size
+ * @io96b_csr_addr:	IO96B instance CSR address
+ * @cal_status:		IO96B instance calibration status
+ * @mb_ctrl:		IOSSM mailbox required information
+ */
+struct io96b_instance {
+	u16 size;
+	phys_addr_t io96b_csr_addr;
+	bool cal_status;
+	struct io96b_mb_ctrl mb_ctrl;
+};
+
+/*
+ * Overall IO96B instance(s) information
+ *
+ * @num_instance:	Number of instance(s) assigned to HPS
+ * @overall_cal_status: Overall calibration status for all IO96B instance(s)
+ * @ddr_type:		DDR memory type
+ * @ecc_status:		ECC enable status (false = disabled, true = enabled)
+ * @overall_size:	Total DDR memory size
+ * @io96b[]:		IO96B instance specific information
+ * @ckgen_lock:		IO96B GEN PLL lock (false = not locked, true = locked)
+ * @num_port:		Number of IO96B port.
+ * @io96b_pll:		Selected IO96B PLL. Example bit 0: EMIF0 PLL A selected,
+ *			bit 1: EMIF0 PLL B selected, bit 2 - EMIF1 PLL A selected,
+ *			bit 3: EMIF1 PLL B selected
+ */
+struct io96b_info {
+	u8 num_instance;
+	bool overall_cal_status;
+	const char *ddr_type;
+	bool ecc_status;
+	u16 overall_size;
+	struct io96b_instance io96b[MAX_IO96B_SUPPORTED];
+	bool ckgen_lock;
+	u8 num_port;
+	u8 io96b_pll;
+};
+
+int io96b_mb_req(phys_addr_t io96b_csr_addr, struct io96b_mb_req req,
+		 u32 resp_data_len, struct io96b_mb_resp *resp);
+
+/* Supported IOSSM mailbox function */
+void io96b_mb_init(struct io96b_info *io96b_ctrl);
+int io96b_cal_status(phys_addr_t addr);
+void init_mem_cal(struct io96b_info *io96b_ctrl);
+int get_mem_technology(struct io96b_info *io96b_ctrl);
+int get_mem_width_info(struct io96b_info *io96b_ctrl);
+int ecc_enable_status(struct io96b_info *io96b_ctrl);
+int bist_mem_init_start(struct io96b_info *io96b_ctrl);
+int ecc_interrupt_status(struct io96b_info *io96b_ctrl, bool *ecc_error_flag);
diff --git a/drivers/ddr/altera/sdram_agilex5.c b/drivers/ddr/altera/sdram_agilex5.c
new file mode 100644
index 00000000000..160b945b55f
--- /dev/null
+++ b/drivers/ddr/altera/sdram_agilex5.c
@@ -0,0 +1,377 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Intel Corporation <www.intel.com>
+ */
+
+#include <div64.h>
+#include <dm.h>
+#include <errno.h>
+#include <fdtdec.h>
+#include <hang.h>
+#include <log.h>
+#include <ram.h>
+#include <reset.h>
+#include <wait_bit.h>
+#include <wdt.h>
+#include <linux/bitfield.h>
+#include <linux/sizes.h>
+#include <asm/arch/firewall.h>
+#include <asm/arch/reset_manager.h>
+#include <asm/arch/system_manager.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include "iossm_mailbox.h"
+#include "sdram_soc64.h"
+
+DECLARE_GLOBAL_DATA_PTR;
+
+/* MPFE NOC registers */
+#define F2SDRAM_SIDEBAND_FLAGOUTSET0	0x50
+#define F2SDRAM_SIDEBAND_FLAGOUTSTATUS0	0x58
+#define SIDEBANDMGR_FLAGOUTSET0_REG	SOCFPGA_F2SDRAM_MGR_ADDRESS +\
+					F2SDRAM_SIDEBAND_FLAGOUTSET0
+#define SIDEBANDMGR_FLAGOUTSTATUS0_REG	SOCFPGA_F2SDRAM_MGR_ADDRESS +\
+					F2SDRAM_SIDEBAND_FLAGOUTSTATUS0
+
+#define BOOT_SCRATCH_COLD3_REG	(socfpga_get_sysmgr_addr() +\
+				 SYSMGR_SOC64_BOOT_SCRATCH_COLD3)
+
+#define PORT_EMIF_CONFIG_OFFSET 4
+#define EMIF_PLL_MASK	GENMASK(19, 16)
+
+#define IO96B0_DUAL_PORT_MASK		BIT(0)
+#define IO96B0_DUAL_EMIF_MASK		BIT(1)
+
+#define FIREWALL_MPFE_SCR_IO96B0_REG		0x18000d00
+#define FIREWALL_MPFE_SCR_IO96B1_REG		0x18000d04
+#define FIREWALL_MPFE_NOC_CSR_REG		0x18000d08
+
+/* Reset type */
+enum reset_type {
+	POR_RESET,
+	WARM_RESET,
+	COLD_RESET,
+	NCONFIG,
+	JTAG_CONFIG,
+	RSU_RECONFIG
+};
+
+phys_addr_t io96b_csr_reg_addr[] = {
+	0x18400000, /* IO96B_0 CSR registers address */
+	0x18800000  /* IO96B_1 CSR registers address */
+};
+
+static enum reset_type get_reset_type(u32 reg)
+{
+	return FIELD_GET(ALT_SYSMGR_SCRATCH_REG_3_DDR_RESET_TYPE_MASK, reg);
+}
+
+static void update_io96b_assigned_to_hps(bool dual_port_flag, bool dual_emif_flag)
+{
+	clrsetbits_le32(BOOT_SCRATCH_COLD3_REG,
+			ALT_SYSMGR_SCRATCH_REG_3_DDR_PORT_EMIF_INFO_MASK,
+			FIELD_PREP(ALT_SYSMGR_SCRATCH_REG_3_DDR_PORT_INFO_MASK, dual_port_flag) |
+			FIELD_PREP(ALT_SYSMGR_SCRATCH_REG_3_DDR_EMIF_INFO_MASK, dual_emif_flag));
+
+	debug("%s: update dual port dual emif info: 0x%x\n", __func__,
+	      readl(BOOT_SCRATCH_COLD3_REG));
+}
+
+static void set_mpfe_config(void)
+{
+	/* Set mpfe_lite_intfcsel */
+	setbits_le32(socfpga_get_sysmgr_addr() + SYSMGR_SOC64_MPFE_CONFIG, BIT(2));
+
+	/* Set mpfe_lite_active */
+	setbits_le32(socfpga_get_sysmgr_addr() + SYSMGR_SOC64_MPFE_CONFIG, BIT(8));
+
+	debug("%s: mpfe_config: 0x%x\n", __func__,
+	      readl(socfpga_get_sysmgr_addr() + SYSMGR_SOC64_MPFE_CONFIG));
+}
+
+static bool is_ddr_init_hang(void)
+{
+	u32 reg = readl(socfpga_get_sysmgr_addr() +
+			SYSMGR_SOC64_BOOT_SCRATCH_POR0);
+
+	debug("%s: 0x%x\n", __func__, reg);
+
+	if (reg & ALT_SYSMGR_SCRATCH_REG_POR_0_DDR_PROGRESS_MASK)
+		return true;
+
+	return false;
+}
+
+static void ddr_init_inprogress(bool start)
+{
+	if (start)
+		setbits_le32(socfpga_get_sysmgr_addr() +
+				SYSMGR_SOC64_BOOT_SCRATCH_POR0,
+				ALT_SYSMGR_SCRATCH_REG_POR_0_DDR_PROGRESS_MASK);
+	else
+		clrbits_le32(socfpga_get_sysmgr_addr() +
+				SYSMGR_SOC64_BOOT_SCRATCH_POR0,
+				ALT_SYSMGR_SCRATCH_REG_POR_0_DDR_PROGRESS_MASK);
+}
+
+static void populate_ddr_handoff(struct udevice *dev, struct io96b_info *io96b_ctrl)
+{
+	struct altera_sdram_plat *plat = dev_get_plat(dev);
+	int i;
+	u32 len = SOC64_HANDOFF_SDRAM_LEN;
+	u32 handoff_table[len];
+
+	/* Read handoff for DDR configuration */
+	socfpga_handoff_read((void *)SOC64_HANDOFF_SDRAM, handoff_table, len);
+
+	/* Read handoff - dual port */
+	plat->dualport = FIELD_GET(IO96B0_DUAL_PORT_MASK, handoff_table[PORT_EMIF_CONFIG_OFFSET]);
+	debug("%s: dualport from handoff: 0x%x\n", __func__, plat->dualport);
+
+	if (plat->dualport)
+		io96b_ctrl->num_port = 2;
+	else
+		io96b_ctrl->num_port = 1;
+
+	/* Read handoff - dual EMIF */
+	plat->dualemif = FIELD_GET(IO96B0_DUAL_EMIF_MASK, handoff_table[PORT_EMIF_CONFIG_OFFSET]);
+	debug("%s: dualemif from handoff: 0x%x\n", __func__, plat->dualemif);
+
+	if (plat->dualemif)
+		io96b_ctrl->num_instance = 2;
+	else
+		io96b_ctrl->num_instance = 1;
+
+	io96b_ctrl->io96b_pll = FIELD_GET(EMIF_PLL_MASK,
+					  handoff_table[PORT_EMIF_CONFIG_OFFSET]);
+	debug("%s: io96b enabled pll from handoff: 0x%x\n", __func__, io96b_ctrl->io96b_pll);
+
+	update_io96b_assigned_to_hps(plat->dualport, plat->dualemif);
+
+	/* Assign IO96B CSR base address if it is valid */
+	for (i = 0; i < io96b_ctrl->num_instance; i++) {
+		io96b_ctrl->io96b[i].io96b_csr_addr = io96b_csr_reg_addr[i];
+		debug("%s: IO96B 0x%llx CSR enabled\n", __func__,
+		      io96b_ctrl->io96b[i].io96b_csr_addr);
+	}
+}
+
+static void config_mpfe_sideband_mgr(struct udevice *dev)
+{
+	struct altera_sdram_plat *plat = dev_get_plat(dev);
+
+	/* Dual port setting */
+	if (plat->dualport)
+		setbits_le32(SIDEBANDMGR_FLAGOUTSET0_REG, BIT(4));
+
+	/* Dual EMIF setting */
+	if (plat->dualemif) {
+		set_mpfe_config();
+		setbits_le32(SIDEBANDMGR_FLAGOUTSET0_REG, BIT(5));
+	}
+
+	debug("%s: SIDEBANDMGR_FLAGOUTSTATUS0: 0x%x\n", __func__,
+	      readl(SIDEBANDMGR_FLAGOUTSTATUS0_REG));
+}
+
+static void config_ccu_mgr(struct udevice *dev)
+{
+	int ret = 0;
+	struct altera_sdram_plat *plat = dev_get_plat(dev);
+
+	if (plat->dualport || plat->dualemif) {
+		debug("%s: config interleaving on ccu reg\n", __func__);
+		ret = uclass_get_device_by_name(UCLASS_NOP,
+						"socfpga-ccu-ddr-interleaving-on", &dev);
+	} else {
+		debug("%s: config interleaving off ccu reg\n", __func__);
+		ret = uclass_get_device_by_name(UCLASS_NOP,
+						"socfpga-ccu-ddr-interleaving-off", &dev);
+	}
+
+	if (ret) {
+		printf("interleaving on/off ccu settings init failed: %d\n", ret);
+		hang();
+	}
+}
+
+static void config_firewall_mpfe_csr(struct udevice *dev)
+{
+	int ret = 0;
+
+	debug("%s: config Firewall setting for MPFE CSR\n", __func__);
+	ret = uclass_get_device_by_name(UCLASS_NOP,
+					"socfpga-noc-fw-mpfe-csr", &dev);
+
+	if (ret) {
+		printf("Firewall setting for MPFE CSR init failed: %d\n", ret);
+		hang();
+	}
+}
+
+static bool hps_ocram_dbe_status(void)
+{
+	u32 reg = readl(BOOT_SCRATCH_COLD3_REG);
+
+	if (reg & ALT_SYSMGR_SCRATCH_REG_3_OCRAM_DBE_MASK)
+		return true;
+
+	return false;
+}
+
+int sdram_mmr_init_full(struct udevice *dev)
+{
+	int ret = 0;
+	phys_size_t hw_size;
+	struct bd_info bd = {0};
+	struct altera_sdram_plat *plat = dev_get_plat(dev);
+	struct altera_sdram_priv *priv = dev_get_priv(dev);
+	struct io96b_info *io96b_ctrl = malloc(sizeof(*io96b_ctrl));
+
+	u32 reg = readl(BOOT_SCRATCH_COLD3_REG);
+	enum reset_type reset_t = get_reset_type(reg);
+	bool full_mem_init = false;
+
+	/* DDR initialization progress status tracking */
+	bool is_ddr_hang_be4_rst = is_ddr_init_hang();
+
+	debug("DDR: SDRAM init in progress ...\n");
+	ddr_init_inprogress(true);
+
+	debug("DDR: Address MPFE 0x%llx\n", plat->mpfe_base_addr);
+
+	/* Populating DDR handoff data */
+	debug("DDR: Checking SDRAM configuration in progress ...\n");
+	populate_ddr_handoff(dev, io96b_ctrl);
+
+	/* Configuring MPFE sideband manager registers - dual port & dual emif*/
+	config_mpfe_sideband_mgr(dev);
+
+	/* Configuring Interleave/Non-interleave ccu registers */
+	config_ccu_mgr(dev);
+
+	/* Configure if polling is needed for IO96B GEN PLL locked */
+	io96b_ctrl->ckgen_lock = true;
+
+	/* Ensure calibration status passing */
+	init_mem_cal(io96b_ctrl);
+
+	printf("DDR: Calibration success\n");
+
+	/* Initiate IOSSM mailbox */
+	io96b_mb_init(io96b_ctrl);
+
+	/* DDR type, DDR size and ECC status) */
+	ret = get_mem_technology(io96b_ctrl);
+	if (ret) {
+		printf("DDR: Failed to get DDR type\n");
+
+		goto err;
+	}
+
+	ret = get_mem_width_info(io96b_ctrl);
+	if (ret) {
+		printf("DDR: Failed to get DDR size\n");
+
+		goto err;
+	}
+
+	hw_size = (phys_size_t)io96b_ctrl->overall_size * SZ_1G / SZ_8;
+
+	/* Get bank configuration from devicetree */
+	ret = fdtdec_decode_ram_size(gd->fdt_blob, NULL, 0, NULL,
+				     (phys_size_t *)&gd->ram_size, &bd);
+	if (ret) {
+		puts("DDR: Failed to decode memory node\n");
+		ret = -ENXIO;
+
+		goto err;
+	}
+
+	if (gd->ram_size != hw_size) {
+		printf("DDR: Warning: DRAM size from device tree (%lld MiB)\n",
+		       gd->ram_size >> 20);
+		printf(" mismatch with hardware (%lld MiB).\n",
+		       hw_size >> 20);
+	}
+
+	if (gd->ram_size > hw_size) {
+		printf("DDR: Error: DRAM size from device tree is greater\n");
+		printf(" than hardware size.\n");
+		hang();
+	}
+
+	printf("%s: %lld MiB\n", io96b_ctrl->ddr_type, gd->ram_size >> 20);
+
+	ret = ecc_enable_status(io96b_ctrl);
+	if (ret) {
+		printf("DDR: Failed to get ECC enabled status\n");
+
+		goto err;
+	}
+
+	/* Is HPS cold or warm reset? If yes, Skip full memory initialization if ECC
+	 *  enabled to preserve memory content
+	 */
+	if (io96b_ctrl->ecc_status) {
+		bool ecc_error_flag;
+
+		ret = ecc_interrupt_status(io96b_ctrl, &ecc_error_flag);
+		if (ret) {
+			printf("DDR: Failed to get ECC interrupt status\n");
+
+			goto err;
+		}
+
+		if (ecc_error_flag) {
+			if (CONFIG_IS_ENABLED(WDT)) {
+				struct udevice *wdt;
+
+				printf("DDR: ECC error recover start now\n");
+				ret = uclass_first_device_err(UCLASS_WDT, &wdt);
+				if (ret) {
+					printf("DDR: Failed to trigger watchdog reset\n");
+					hang();
+				}
+
+				wdt_expire_now(wdt, 0);
+			}
+			hang();
+		}
+
+		full_mem_init = hps_ocram_dbe_status() | is_ddr_hang_be4_rst;
+		if (full_mem_init || !(reset_t == WARM_RESET || reset_t == COLD_RESET)) {
+			ret = bist_mem_init_start(io96b_ctrl);
+			if (ret) {
+				printf("DDR: Failed to fully initialize DDR memory\n");
+
+				goto err;
+			}
+		}
+
+		printf("SDRAM-ECC: Initialized success\n");
+	}
+
+	sdram_size_check(&bd);
+	printf("DDR: size check success\n");
+
+	sdram_set_firewall(&bd);
+
+	/* Firewall setting for MPFE CSR */
+	config_firewall_mpfe_csr(dev);
+
+	printf("DDR: firewall init success\n");
+
+	priv->info.base = bd.bi_dram[0].start;
+	priv->info.size = gd->ram_size;
+
+	/* Ending DDR driver initialization success tracking */
+	ddr_init_inprogress(false);
+
+	printf("DDR: init success\n");
+
+err:
+	free(io96b_ctrl);
+
+	return ret;
+}
diff --git a/drivers/ddr/altera/sdram_soc64.c b/drivers/ddr/altera/sdram_soc64.c
index 9e57c2ecfa4..ce286cc2e76 100644
--- a/drivers/ddr/altera/sdram_soc64.c
+++ b/drivers/ddr/altera/sdram_soc64.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2016-2022 Intel Corporation <www.intel.com>
- *
+ * Copyright (C) 2016-2024 Intel Corporation <www.intel.com>
  */
 
 #include <cpu_func.h>
@@ -27,6 +26,7 @@
 
 #define PGTABLE_OFF	0x4000
 
+#if !IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
 u32 hmc_readl(struct altera_sdram_plat *plat, u32 reg)
 {
 	return readl(plat->iomhc + reg);
@@ -98,8 +98,9 @@ int emif_reset(struct altera_sdram_plat *plat)
 	debug("DDR: %s triggered successly\n", __func__);
 	return 0;
 }
+#endif
 
-#if !IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X)
+#if !(IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X) || IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5))
 int poll_hmc_clock_status(void)
 {
 	return wait_for_bit_le32((const void *)(socfpga_get_sysmgr_addr() +
@@ -251,7 +252,7 @@ phys_size_t sdram_calculate_size(struct altera_sdram_plat *plat)
 	return size;
 }
 
-void sdram_set_firewall(struct bd_info *bd)
+static void sdram_set_firewall_non_f2sdram(struct bd_info *bd)
 {
 	u32 i;
 	phys_size_t value;
@@ -287,7 +288,7 @@ void sdram_set_firewall(struct bd_info *bd)
 				      FW_MPU_DDR_SCR_NONMPUREGION0ADDR_BASEEXT +
 				      (i * 4 * sizeof(u32)));
 
-		/* Setting non-secure MPU limit and limit extexded */
+		/* Setting non-secure MPU limit and limit extended */
 		value = bd->bi_dram[i].start + bd->bi_dram[i].size - 1;
 
 		lower = lower_32_bits(value);
@@ -300,7 +301,7 @@ void sdram_set_firewall(struct bd_info *bd)
 				      FW_MPU_DDR_SCR_MPUREGION0ADDR_LIMITEXT +
 				      (i * 4 * sizeof(u32)));
 
-		/* Setting non-secure Non-MPU limit and limit extexded */
+		/* Setting non-secure Non-MPU limit and limit extended */
 		FW_MPU_DDR_SCR_WRITEL(lower,
 				      FW_MPU_DDR_SCR_NONMPUREGION0ADDR_LIMIT +
 				      (i * 4 * sizeof(u32)));
@@ -313,6 +314,61 @@ void sdram_set_firewall(struct bd_info *bd)
 	}
 }
 
+#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
+static void sdram_set_firewall_f2sdram(struct bd_info *bd)
+{
+	u32 i, lower, upper;
+	phys_size_t value;
+
+	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
+		if (!bd->bi_dram[i].size)
+			continue;
+
+		value = bd->bi_dram[i].start;
+
+		/* Keep first 1MB of SDRAM memory region as secure region when
+		 * using ATF flow, where the ATF code is located.
+		 */
+		if (IS_ENABLED(CONFIG_SPL_ATF) && i == 0)
+			value += SZ_1M;
+
+		/* Setting base and base extended */
+		lower = lower_32_bits(value);
+		upper = upper_32_bits(value);
+		FW_F2SDRAM_DDR_SCR_WRITEL(lower,
+					  FW_F2SDRAM_DDR_SCR_REGION0ADDR_BASE +
+					  (i * 4 * sizeof(u32)));
+		FW_F2SDRAM_DDR_SCR_WRITEL(upper & 0xff,
+					  FW_F2SDRAM_DDR_SCR_REGION0ADDR_BASEEXT +
+					  (i * 4 * sizeof(u32)));
+
+		/* Setting limit and limit extended */
+		value = bd->bi_dram[i].start + bd->bi_dram[i].size - 1;
+
+		lower = lower_32_bits(value);
+		upper = upper_32_bits(value);
+
+		FW_F2SDRAM_DDR_SCR_WRITEL(lower,
+					  FW_F2SDRAM_DDR_SCR_REGION0ADDR_LIMIT +
+					  (i * 4 * sizeof(u32)));
+		FW_F2SDRAM_DDR_SCR_WRITEL(upper & 0xff,
+					  FW_F2SDRAM_DDR_SCR_REGION0ADDR_LIMITEXT +
+					  (i * 4 * sizeof(u32)));
+
+		FW_F2SDRAM_DDR_SCR_WRITEL(BIT(i), FW_F2SDRAM_DDR_SCR_EN_SET);
+	}
+}
+#endif
+
+void sdram_set_firewall(struct bd_info *bd)
+{
+	sdram_set_firewall_non_f2sdram(bd);
+
+#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
+	sdram_set_firewall_f2sdram(bd);
+#endif
+}
+
 static int altera_sdram_of_to_plat(struct udevice *dev)
 {
 	struct altera_sdram_plat *plat = dev_get_plat(dev);
@@ -321,7 +377,12 @@ static int altera_sdram_of_to_plat(struct udevice *dev)
 	/* These regs info are part of DDR handoff in bitstream */
 #if IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X)
 	return 0;
-#endif
+#elif IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
+	addr = dev_read_addr_index(dev, 0);
+	if (addr == FDT_ADDR_T_NONE)
+		return -EINVAL;
+	plat->mpfe_base_addr = addr;
+#else
 
 	addr = dev_read_addr_index(dev, 0);
 	if (addr == FDT_ADDR_T_NONE)
@@ -337,7 +398,7 @@ static int altera_sdram_of_to_plat(struct udevice *dev)
 	if (addr == FDT_ADDR_T_NONE)
 		return -EINVAL;
 	plat->hmc = (void __iomem *)addr;
-
+#endif
 	return 0;
 }
 
@@ -384,6 +445,7 @@ static const struct udevice_id altera_sdram_ids[] = {
 	{ .compatible = "altr,sdr-ctl-s10" },
 	{ .compatible = "intel,sdr-ctl-agilex" },
 	{ .compatible = "intel,sdr-ctl-n5x" },
+	{ .compatible = "intel,sdr-ctl-agilex5" },
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/ddr/altera/sdram_soc64.h b/drivers/ddr/altera/sdram_soc64.h
index 87a70a861ba..f75a1e47cc3 100644
--- a/drivers/ddr/altera/sdram_soc64.h
+++ b/drivers/ddr/altera/sdram_soc64.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Copyright (C) 2017-2019 Intel Corporation <www.intel.com>
+ * Copyright (C) 2017-2024 Intel Corporation <www.intel.com>
  */
 
 #ifndef	_SDRAM_SOC64_H_
@@ -13,11 +13,19 @@ struct altera_sdram_priv {
 	struct reset_ctl_bulk resets;
 };
 
+#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
+struct altera_sdram_plat {
+	fdt_addr_t mpfe_base_addr;
+	bool dualport;
+	bool dualemif;
+};
+#else
 struct altera_sdram_plat {
 	void __iomem *hmc;
 	void __iomem *ddr_sch;
 	void __iomem *iomhc;
 };
+#endif
 
 /* ECC HMC registers */
 #define DDRIOCTRL			0x8
@@ -65,6 +73,8 @@ struct altera_sdram_plat {
 #define CTRLCFG0			0x28
 #define CTRLCFG1			0x2c
 #define CTRLCFG3                        0x34
+#define CTRLCFG5                        0x3c
+#define CTRLCFG6                        0x40
 #define DRAMTIMING0			0x50
 #define CALTIMING0			0x7c
 #define CALTIMING1			0x80
@@ -79,7 +89,7 @@ struct altera_sdram_plat {
 #define NIOSRESERVED2			0x118
 
 #define DRAMADDRW_CFG_COL_ADDR_WIDTH(x)			\
-	(((x) >> 0) & 0x1F)
+	((x) & 0x1F)
 #define DRAMADDRW_CFG_ROW_ADDR_WIDTH(x)			\
 	(((x) >> 5) & 0x1F)
 #define DRAMADDRW_CFG_BANK_ADDR_WIDTH(x)		\
@@ -90,7 +100,7 @@ struct altera_sdram_plat {
 	(((x) >> 16) & 0x7)
 
 #define CTRLCFG0_CFG_MEMTYPE(x)				\
-	(((x) >> 0) & 0xF)
+	((x) & 0xF)
 #define CTRLCFG0_CFG_DIMM_TYPE(x)			\
 	(((x) >> 4) & 0x7)
 #define CTRLCFG0_CFG_AC_POS(x)				\
@@ -99,17 +109,17 @@ struct altera_sdram_plat {
 	(((x) >> 9) & 0x1F)
 
 #define CTRLCFG1_CFG_DBC3_BURST_LEN(x)			\
-	(((x) >> 0) & 0x1F)
+	((x) & 0x1F)
 #define CTRLCFG1_CFG_ADDR_ORDER(x)			\
 	(((x) >> 5) & 0x3)
 #define CTRLCFG1_CFG_CTRL_EN_ECC(x)			\
 	(((x) >> 7) & 0x1)
 
 #define DRAMTIMING0_CFG_TCL(x)				\
-	(((x) >> 0) & 0x7F)
+	((x) & 0x7F)
 
 #define CALTIMING0_CFG_ACT_TO_RDWR(x)			\
-	(((x) >> 0) & 0x3F)
+	((x) & 0x3F)
 #define CALTIMING0_CFG_ACT_TO_PCH(x)			\
 	(((x) >> 6) & 0x3F)
 #define CALTIMING0_CFG_ACT_TO_ACT(x)			\
@@ -118,7 +128,7 @@ struct altera_sdram_plat {
 	(((x) >> 18) & 0x3F)
 
 #define CALTIMING1_CFG_RD_TO_RD(x)			\
-	(((x) >> 0) & 0x3F)
+	((x) & 0x3F)
 #define CALTIMING1_CFG_RD_TO_RD_DC(x)			\
 	(((x) >> 6) & 0x3F)
 #define CALTIMING1_CFG_RD_TO_RD_DB(x)			\
@@ -129,7 +139,7 @@ struct altera_sdram_plat {
 	(((x) >> 24) & 0x3F)
 
 #define CALTIMING2_CFG_RD_TO_WR_DB(x)			\
-	(((x) >> 0) & 0x3F)
+	((x) & 0x3F)
 #define CALTIMING2_CFG_RD_TO_WR_PCH(x)			\
 	(((x) >> 6) & 0x3F)
 #define CALTIMING2_CFG_RD_AP_TO_VALID(x)		\
@@ -140,7 +150,7 @@ struct altera_sdram_plat {
 	(((x) >> 24) & 0x3F)
 
 #define CALTIMING3_CFG_WR_TO_WR_DB(x)			\
-	(((x) >> 0) & 0x3F)
+	((x) & 0x3F)
 #define CALTIMING3_CFG_WR_TO_RD(x)			\
 	(((x) >> 6) & 0x3F)
 #define CALTIMING3_CFG_WR_TO_RD_DC(x)			\
@@ -151,7 +161,7 @@ struct altera_sdram_plat {
 	(((x) >> 24) & 0x3F)
 
 #define CALTIMING4_CFG_WR_AP_TO_VALID(x)		\
-	(((x) >> 0) & 0x3F)
+	((x) & 0x3F)
 #define CALTIMING4_CFG_PCH_TO_VALID(x)			\
 	(((x) >> 6) & 0x3F)
 #define CALTIMING4_CFG_PCH_ALL_TO_VALID(x)		\
@@ -162,7 +172,7 @@ struct altera_sdram_plat {
 	(((x) >> 26) & 0x3F)
 
 #define CALTIMING9_CFG_4_ACT_TO_ACT(x)			\
-	(((x) >> 0) & 0xFF)
+	((x) & 0xFF)
 
 /* Firewall DDR scheduler MPFE */
 #define FW_HMC_ADAPTOR_REG_ADDR			0xf8020004
-- 
2.25.1

