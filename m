Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB68EC4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 16:03:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 216FB87092;
	Fri,  3 Nov 2023 17:03:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Tx9JFmcU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AFD187090; Fri,  3 Nov 2023 17:03:40 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::60a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEE2A86F84
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 17:03:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJjO3fxBW5QCjxaisuTnTnpuW9fbk/aPykXw/NFtVORjZT/g+w0zVsKWKP3Cb6FelR18wNFPjjlJkpdc+mFvOYHiAo96fmbjBDnGgzJVhLGD08JEUdK5OtVhtp/xzMM5DniVoT36e8pUKP6fDQEXTuwO3lhO7IC05q/oS3NH4S+lfIw+5AN24PdlMxh1IgRHTrmn+AE/XIwaGCKZbjS0Cl9cwRWSEaPn7Yu4mc3oWUFbc20E69QlWda2vwrZLze2Uo/cACK5voIZNktc+dAR8f1dOzUr08GbbRbQ58P/yC7nNmwHkWc9JV4RqfKVcqdYXZVvtW/cyxelfHsR7vskww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g23MT4UMkrdxcTpZ8/4wNK8dWfogJiEBz0UePb4W1eo=;
 b=lrbpKA/NGY3LvtNDhSdGj4cdcf6AX7tDiVryZUj6zP0az2TDhNJDO2mNFRZtn95Y/ugAFvFoxgq7Qbt4rpTYsH62vlcMuCVQoBkIegf8pbxWvbGZfWZAo73gFSiKCkWaoobHq6bp8ljfh+S1udxpGspHoxJonZ+b6zr+GCTUgUfrz0+gIt4rO8imhDtA972DwkZWChyH/XCto3nJGc++eKlSzTkOVdNLWhR5vJVXRYOtJGG06ps/nf+XxewwcxJXfAxGlldV6ST4RxYUR6fxOJa61z6v5WOmM4FGnJs9QQikXKUU3U4Or2E9ow0EKLL2I+mTGqAfA8eoirq/w85Q/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g23MT4UMkrdxcTpZ8/4wNK8dWfogJiEBz0UePb4W1eo=;
 b=Tx9JFmcUm/SsGeC89mTvWXf7x1Ysgojw7dUzJ66rR6O3/YBat+xJuByj2Q4Rs806bn/uyUuybzqowsRAAt9zeu9odj+Jlj6PPO8g0NAjWNT74q6SMqfRZeTz9JRW7P1tq2GJRo9uidC5SDI+z0XgDSIoAA/VAN9N1oQsTTevnLQ=
Received: from MW4PR04CA0352.namprd04.prod.outlook.com (2603:10b6:303:8a::27)
 by PH0PR12MB8100.namprd12.prod.outlook.com (2603:10b6:510:29b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 16:03:30 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::76) by MW4PR04CA0352.outlook.office365.com
 (2603:10b6:303:8a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.22 via Frontend
 Transport; Fri, 3 Nov 2023 16:03:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Fri, 3 Nov 2023 16:03:29 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 3 Nov
 2023 11:03:27 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Conor Dooley <conor.dooley@microchip.com>, Leo <ycliang@andestech.com>,
 Randolph <randolph@andestech.com>, Rick Chen <rick@andestech.com>, Wei Fu
 <wefu@redhat.com>, Yanhong Wang <yanhong.wang@starfivetech.com>, Yixun Lan
 <dlan@gentoo.org>
Subject: [PATCH] riscv: Add support for AMD/Xilinx MicroBlaze V
Date: Fri, 3 Nov 2023 17:03:25 +0100
Message-ID: <41c2fda5d6f96e44188d912811a63b8a40625e6e.1699027398.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10746; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=qzQpKQu2QAs4+kDTELLRkfKC+LrWL0Xo0ucUMuuYdcM=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlRXyePuP1tfTjY49+qX/oHj3Fft3n7Rnp67Qd5Qx9TK7
 tGRh77zOmJZGASZGGTFFFmkba6c2Vs5Y4rwxcNyMHNYmUCGMHBxCsBEOk8wzOEM3sRbbJNh5hTE
 /KEiTOiwocfSPQzzMz5tP28/r05MJfXQF2bxhJpi1UWSAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|PH0PR12MB8100:EE_
X-MS-Office365-Filtering-Correlation-Id: 584e6276-5d7b-4d24-c370-08dbdc866bd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QAs3y82O6eKBvUoMou+hv6prk3y6jvgwKEe1zSh8PCr8DmhG/T7nWQc0xTjJtyDAST98RnNuS9zWZxzr7Cm+HY0BsEtahPEg5iKSpHxW3Art5FPBh63LXeU8Yqlv6WQI2kdXCtDVV1Ih3XDcTpza83ajadaoxYnAY7igahlcV/CPriXINQOjS5d400dK+PLk8IzHOdDi4PoNV80jQVrt1szb4FPy1jlfCGt179uxSHDZFJzX2+HL62f0GBJa9gU6b83U7s54p+yYOpp0VkYwrk3ufTVi7VpvO8JoohTEImM+ZGV3cUP09BIfkDCan/piaZhMoS/vJGPD3zSOYUQNY7qlERE+knpg/ZW3RnbdQ2XYo8qt0X4PFTVOSwlAzZoZjEMqGJID+4JXm2mp1KZzgrGerrFnXoBUvEGpr+AI2/CacVJV+QXjWjOFPSX1BQ6nEt+pBVENSixO4lwXDh3a3azKmXwPQEtZfcb9zDW49KBoOfmvfF6HSSiqzoXsF6bCTy/lIVl28katbW3R2dit5Ix+sIZpEYBEAz7GnuL5vF/KibbCC/Xr0WueCTIuXgQRxWVykXah14HPYm8EQnjB46WNnGX78T06MT3jl9eDagvt0sjyfTLbMdIyLz7s4dvNycXBOMBv7hn7BEub3/Gatiib+2gWc3UXhQpPz+hduvp9GD+vq+42ZMQNZwJswxEkcErSNZ82jSIjTz7/fsX8zpfZz0u1wfCoRsDD8LlDn0mvyD7oqBpIqi22gC4pqvqWd1kuUbeUqWM7PJklFWpYmA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(82310400011)(36840700001)(40470700004)(46966006)(40460700003)(40480700001)(16526019)(2616005)(26005)(478600001)(47076005)(36860700001)(83380400001)(426003)(2906002)(30864003)(41300700001)(44832011)(110136005)(70206006)(54906003)(5660300002)(70586007)(966005)(8936002)(4326008)(336012)(316002)(8676002)(81166007)(356005)(82740400003)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 16:03:29.2478 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 584e6276-5d7b-4d24-c370-08dbdc866bd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8100
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

MicroBlaze V is new AMD/Xilinx soft-core 32bit RISC-V processor IP.
It is hardware compatible with classic MicroBlaze processor.

The patch contains initial wiring and configuration for initial HW design
with memory, cpu, interrupt controller, timers and uartlite console.

Provided DT is just describing one configuration and should be taken only
as example.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Public annoucement is available here if someone is interested.
https://www.xilinx.com/products/design-tools/microblaze-v.html?utm_source=marketo&utm_medium=email&utm_campaign=EN-EM-2023-11-02-New-MicroBlaze-V-Processor&utm_term=btn&mkt_tok=NDA5LVdZWC03MjQAAAGPMMJYuPPscCags7WdvOeUSWy-_mC9aOwrobFaZRf5ok_eHoQUvTLBzJdHrkcBId9tQ4a-odfnU91WjUkIxx-iSG4OKGofjK5iZcAiK_VN8_xK
---
 arch/riscv/Kconfig                   |  4 ++
 arch/riscv/dts/Makefile              |  2 +
 arch/riscv/dts/xilinx-mbv32.dts      | 86 ++++++++++++++++++++++++++++
 board/xilinx/Kconfig                 |  3 +-
 board/xilinx/common/board.c          |  5 ++
 board/xilinx/mbv/Kconfig             | 28 +++++++++
 board/xilinx/mbv/MAINTAINERS         |  7 +++
 board/xilinx/mbv/Makefile            |  5 ++
 board/xilinx/mbv/board.c             | 11 ++++
 configs/xilinx_mbv32_defconfig       | 30 ++++++++++
 configs/xilinx_mbv32_smode_defconfig | 32 +++++++++++
 include/configs/xilinx_mbv.h         |  6 ++
 12 files changed, 218 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/dts/xilinx-mbv32.dts
 create mode 100644 board/xilinx/mbv/Kconfig
 create mode 100644 board/xilinx/mbv/MAINTAINERS
 create mode 100644 board/xilinx/mbv/Makefile
 create mode 100644 board/xilinx/mbv/board.c
 create mode 100644 configs/xilinx_mbv32_defconfig
 create mode 100644 configs/xilinx_mbv32_smode_defconfig
 create mode 100644 include/configs/xilinx_mbv.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 8fc81fb284cd..40113d7803b2 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -39,6 +39,9 @@ config TARGET_SIPEED_MAIX
 config TARGET_OPENPITON_RISCV64
 	bool "Support RISC-V cores on OpenPiton SoC"
 
+config TARGET_XILINX_MBV
+	bool "Support AMD/Xilinx MicroBlaze V"
+
 endchoice
 
 config SYS_ICACHE_OFF
@@ -82,6 +85,7 @@ source "board/thead/th1520_lpi4a/Kconfig"
 source "board/openpiton/riscv64/Kconfig"
 source "board/sipeed/maix/Kconfig"
 source "board/starfive/visionfive2/Kconfig"
+source "board/xilinx/mbv/Kconfig"
 
 # platform-specific options below
 source "arch/riscv/cpu/andesv5/Kconfig"
diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
index be6c8a422729..b05bb5607f06 100644
--- a/arch/riscv/dts/Makefile
+++ b/arch/riscv/dts/Makefile
@@ -9,6 +9,8 @@ dtb-$(CONFIG_TARGET_SIFIVE_UNMATCHED) += hifive-unmatched-a00.dtb
 dtb-$(CONFIG_TARGET_SIPEED_MAIX) += k210-maix-bit.dtb
 dtb-$(CONFIG_TARGET_STARFIVE_VISIONFIVE2) += jh7110-starfive-visionfive-2.dtb
 dtb-$(CONFIG_TARGET_TH1520_LPI4A) += th1520-lichee-pi-4a.dtb
+dtb-$(CONFIG_TARGET_XILINX_MBV) += xilinx-mbv32.dtb
+
 include $(srctree)/scripts/Makefile.dts
 
 targets += $(dtb-y)
diff --git a/arch/riscv/dts/xilinx-mbv32.dts b/arch/riscv/dts/xilinx-mbv32.dts
new file mode 100644
index 000000000000..9046aa0e52eb
--- /dev/null
+++ b/arch/riscv/dts/xilinx-mbv32.dts
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dts file for Xilinx MicroBlaze V
+ *
+ * (C) Copyright 2023, Advanced Micro Devices, Inc.
+ *
+ * Michal Simek <michal.simek@amd.com>
+ */
+
+/dts-v1/;
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	model = "Xilinx MicroBlaze V 32bit";
+	compatible = "xlnx,mbv32";
+
+	cpus: cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		timebase-frequency = <102000000>;
+		cpu_0: cpu@0 {
+			device_type = "cpu";
+			compatible = "riscv";
+			reg = <0>;
+			status = "okay";
+			riscv,isa = "rv32imafdc";
+			clock-frequency = <100000000>;
+			i-cache-size = <32768>;
+			d-cache-size = <32768>;
+		};
+	};
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		bootargs = "earlycon";
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@20000000 {
+		device_type = "memory";
+		reg = <0x20000000 0x20000000>;
+	};
+
+	axi: axi {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		ranges;
+		bootph-all;
+
+		axi_intc: interrupt-controller@41200000 {
+			compatible = "xlnx.xps-intc";
+			reg = <0x41200000 0x1000>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			kind-of-intr = <0>;
+		};
+
+		xlnx_timer0: timer@41c00000 {
+			compatible = "xlnx,xps-timer-1.00.a";
+			reg = <0x41c00000 0x1000>;
+			interrupt-parent = <&axi_intc>;
+			interrupts = <1 2>;
+			clock-frequency = <102000000>;
+			bootph-all;
+		};
+
+		xlnx_timer1: timer@41c20000 {
+			compatible = "xlnx,xps-timer-1.00.a";
+			reg = <0x41c20000 0x1000>;
+			interrupt-parent = <&axi_intc>;
+			interrupts = <0 2>;
+			clock-frequency = <102000000>;
+		};
+
+		uart0: serial@40600000 {
+			compatible = "xlnx,xps-uartlite-1.00.a";
+			reg = <0x40600000 0x1000>;
+			interrupt-parent = <&axi_intc>;
+			bootph-all;
+		};
+	};
+};
diff --git a/board/xilinx/Kconfig b/board/xilinx/Kconfig
index 4f0776e8bd95..843198fa0da8 100644
--- a/board/xilinx/Kconfig
+++ b/board/xilinx/Kconfig
@@ -51,10 +51,11 @@ config XILINX_OF_BOARD_DTB_ADDR
 
 config BOOT_SCRIPT_OFFSET
 	hex "Boot script offset"
-	depends on ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_VERSAL || ARCH_VERSAL_NET || MICROBLAZE
+	depends on ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_VERSAL || ARCH_VERSAL_NET || MICROBLAZE || TARGET_XILINX_MBV
 	default 0xFC0000 if ARCH_ZYNQ || MICROBLAZE
 	default 0x3E80000 if ARCH_ZYNQMP
 	default 0x7F80000 if ARCH_VERSAL || ARCH_VERSAL_NET
+	default 0 if TARGET_XILINX_MBV
 	help
 	   Specifies distro boot script offset in NAND/QSPI/NOR flash.
 
diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
index 9309b071269f..12a877c71549 100644
--- a/board/xilinx/common/board.c
+++ b/board/xilinx/common/board.c
@@ -652,6 +652,11 @@ int embedded_dtb_select(void)
 #endif
 
 #if defined(CONFIG_LMB)
+
+#ifndef MMU_SECTION_SIZE
+#define MMU_SECTION_SIZE        (1 * 1024 * 1024)
+#endif
+
 phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 {
 	phys_size_t size;
diff --git a/board/xilinx/mbv/Kconfig b/board/xilinx/mbv/Kconfig
new file mode 100644
index 000000000000..4bc9f72c541b
--- /dev/null
+++ b/board/xilinx/mbv/Kconfig
@@ -0,0 +1,28 @@
+if TARGET_XILINX_MBV
+
+config SYS_BOARD
+	default "mbv"
+
+config SYS_VENDOR
+	default "xilinx"
+
+config SYS_CPU
+	default "generic"
+
+config SYS_CONFIG_NAME
+	default "xilinx_mbv"
+
+config TEXT_BASE
+	default 0x80000000 if !RISCV_SMODE
+	default 0x80400000 if RISCV_SMODE && ARCH_RV32I
+
+config BOARD_SPECIFIC_OPTIONS
+	def_bool y
+	select GENERIC_RISCV
+	imply BOARD_LATE_INIT
+	imply CMD_SBI
+	imply CMD_PING
+
+source "board/xilinx/Kconfig"
+
+endif
diff --git a/board/xilinx/mbv/MAINTAINERS b/board/xilinx/mbv/MAINTAINERS
new file mode 100644
index 000000000000..445654fe740e
--- /dev/null
+++ b/board/xilinx/mbv/MAINTAINERS
@@ -0,0 +1,7 @@
+XILINX MicroBlaze V BOARD
+M:	Michal Simek <michal.simek@amd.com>
+S:	Maintained
+F:	arch/riscv/dts/xilinx-mbv*
+F:	board/xilinx/mbv/
+F:	configs/xilinx_mbv*
+F:	include/configs/xilinx_mbv.h
diff --git a/board/xilinx/mbv/Makefile b/board/xilinx/mbv/Makefile
new file mode 100644
index 000000000000..e2fc0c69715f
--- /dev/null
+++ b/board/xilinx/mbv/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# (C) Copyright 2023, Advanced Micro Devices, Inc.
+
+obj-y	+= board.o
diff --git a/board/xilinx/mbv/board.c b/board/xilinx/mbv/board.c
new file mode 100644
index 000000000000..ccf4395d6ace
--- /dev/null
+++ b/board/xilinx/mbv/board.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2023, Advanced Micro Devices, Inc.
+ *
+ * Michal Simek <michal.simek@amd.com>
+ */
+
+int board_init(void)
+{
+	return 0;
+}
diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
new file mode 100644
index 000000000000..2689495057b0
--- /dev/null
+++ b/configs/xilinx_mbv32_defconfig
@@ -0,0 +1,30 @@
+CONFIG_RISCV=y
+CONFIG_TEXT_BASE=0x21200000
+CONFIG_SYS_MALLOC_LEN=0x800000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20200000
+CONFIG_ENV_SIZE=0x20000
+CONFIG_DEFAULT_DEVICE_TREE="xilinx-mbv32"
+CONFIG_DEBUG_UART_BASE=0x40600000
+CONFIG_DEBUG_UART_CLOCK=1000000
+CONFIG_SYS_CLK_FREQ=100000000
+CONFIG_BOOT_SCRIPT_OFFSET=0x0
+CONFIG_SYS_LOAD_ADDR=0x80200000
+CONFIG_DEBUG_UART=y
+CONFIG_TARGET_XILINX_MBV=y
+CONFIG_FIT=y
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_DISPLAY_CPUINFO=y
+CONFIG_DISPLAY_BOARDINFO=y
+# CONFIG_BOARD_LATE_INIT is not set
+# CONFIG_CMD_MII is not set
+CONFIG_CMD_TIMER=y
+CONFIG_OF_EMBED=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_DM_MTD=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_SKIP_INIT=y
+CONFIG_XILINX_UARTLITE=y
+CONFIG_XILINX_TIMER=y
+CONFIG_PANIC_HANG=y
diff --git a/configs/xilinx_mbv32_smode_defconfig b/configs/xilinx_mbv32_smode_defconfig
new file mode 100644
index 000000000000..c724d1bad742
--- /dev/null
+++ b/configs/xilinx_mbv32_smode_defconfig
@@ -0,0 +1,32 @@
+CONFIG_RISCV=y
+CONFIG_TEXT_BASE=0x21200000
+CONFIG_SYS_MALLOC_LEN=0x800000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20200000
+CONFIG_ENV_SIZE=0x20000
+CONFIG_DEFAULT_DEVICE_TREE="xilinx-mbv32"
+CONFIG_DEBUG_UART_BASE=0x40600000
+CONFIG_DEBUG_UART_CLOCK=1000000
+CONFIG_SYS_CLK_FREQ=100000000
+CONFIG_BOOT_SCRIPT_OFFSET=0x0
+CONFIG_SYS_LOAD_ADDR=0x80200000
+CONFIG_TARGET_XILINX_MBV=y
+CONFIG_RISCV_SMODE=y
+CONFIG_FIT=y
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_DISPLAY_CPUINFO=y
+CONFIG_DISPLAY_BOARDINFO=y
+# CONFIG_BOARD_LATE_INIT is not set
+# CONFIG_CMD_MII is not set
+CONFIG_CMD_TIMER=y
+CONFIG_OF_EMBED=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_DM_MTD=y
+CONFIG_DEBUG_UART_UARTLITE=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_SKIP_INIT=y
+CONFIG_XILINX_UARTLITE=y
+# CONFIG_RISCV_TIMER is not set
+CONFIG_XILINX_TIMER=y
+CONFIG_PANIC_HANG=y
diff --git a/include/configs/xilinx_mbv.h b/include/configs/xilinx_mbv.h
new file mode 100644
index 000000000000..dba398aeec49
--- /dev/null
+++ b/include/configs/xilinx_mbv.h
@@ -0,0 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * (C) Copyright 2023, Advanced Micro Devices, Inc.
+ *
+ * Michal Simek <michal.simek@amd.com>
+ */
-- 
2.36.1

