Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9EF2D5CC99
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 09:51:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45D2E88D9A;
	Fri,  1 Nov 2024 10:51:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BH76TgVq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEAF18887A; Fri,  1 Nov 2024 10:51:00 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::613])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFDA189020
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 10:50:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bH65AgXn+fXfVSPbylonmpqRSm9VBwBoiMPO7JYdCIyXApub3pTfUXOsmYnrNNy/Y8cv1DbZ/urQ03LW3tl9hddO5t+wzlIAwJZmVJslWznb1oBl4fZGpcsxw7BIeQy00o88gNWHG5Sm72vsBOEARfl41xiPum3I44WE/d4Z/vrzM7WOzpMbchx+ZB0H9RS+cg3yQ0n2esYL6zghlUxXWR3UUaF/jcyzQwYr/O3E5tz+9IQo6oeRPi4Zfet25LxePCmro9HV56cEfl8rmdR2ufPzQg9EYo1e+ncsm4hRDw0DWNYDdpnRcSHsvQIYDGNUInoDGJuk0qdHs0WSw1Yxzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CATEPK2LJF3G6TJueS/Wx5NdUlkpz3+5ao2c247kVf4=;
 b=r4YlHOrCA5z+SBC82YhkDTYPwKELfR2P9mXd1EfiVQUklqVx3s0B/ft6JQ/n517wdGDvBszDvvrGVF4zypMc3eU313ak6rU9Ef3DaM4jInlb8QcH1i0cdvFYWaTSTR07pMC+j/4nWxiIRfIdWHBAbwiSaa/YAs1iOV0o/bCx5j7/t8K3tslKPfNDm2LA2pY8xLdR6K5x11BuwBlEP2xtivrQGRBgR/L8rYWqqkuhOD7M1TKPfJBYY+hsKtNlnvKYHQI5PbWD4rpVezj57/+WauUEC62YCOk3IYsRzGyGZO8+9/370Qw4OSHUf4iCV18npswqaRiWjZIwFo9UicQLAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CATEPK2LJF3G6TJueS/Wx5NdUlkpz3+5ao2c247kVf4=;
 b=BH76TgVqHaz3SBzxtHBMXXYTjJCFSeQTfjsQV7JYYkWgGlHqPfhCArW2A5vZLvkWIjSye4LPD7dua2PPQiEU2ur/0idtI8ifv1ge8KKJl8w254DqBb3Ay57yhXk3LA2BwAbQieD43NbbbsAlu2efcYgVOf9RFCn12QyR56FsAUk=
Received: from PH7PR13CA0002.namprd13.prod.outlook.com (2603:10b6:510:174::6)
 by CY5PR12MB6383.namprd12.prod.outlook.com (2603:10b6:930:3d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Fri, 1 Nov
 2024 09:50:53 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:510:174:cafe::55) by PH7PR13CA0002.outlook.office365.com
 (2603:10b6:510:174::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.7 via Frontend
 Transport; Fri, 1 Nov 2024 09:50:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Fri, 1 Nov 2024 09:50:51 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Nov
 2024 04:50:49 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Conor Dooley
 <conor.dooley@microchip.com>, Kongyang Liu <seashell11234455@gmail.com>, Leo
 <ycliang@andestech.com>, Marek Vasut <marex@denx.de>, Padmarao Begari
 <padmarao.begari@amd.com>, Rick Chen <rick@andestech.com>, Sumit Garg
 <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] riscv: Introduce configuration for 64bit version Microblaze V
Date: Fri, 1 Nov 2024 10:50:45 +0100
Message-ID: <5b042f4ef4927b7f87e1f8623dabeab5a8642916.1730454641.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6932; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=jWr5u171CCRsBOs4+gebYDwxibU85nKZQG/BvIYldAM=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhnSVJWWlfYp6++RNi54vmnaj4meXfEZbcO9vm/CVB7ymm
 U9w3vipI5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAEzkqiHDHO7W7RPfevatDjnK
 Iueds/rU0pTndxhms71627uye3vsJa0PYbVZL5s2bgzdAQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|CY5PR12MB6383:EE_
X-MS-Office365-Filtering-Correlation-Id: 31e0086e-abae-4c34-ff9f-08dcfa5aac1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ElQdj3lsFIoK8hlG4XNoZtXDhSgSU7ZrEL515k64OXbIiwc6b4zpEUj3hGIT?=
 =?us-ascii?Q?tjC4nSeCb0USOVaLvxtxD5eGcXcb5pBTzh/Z/XHjZ25f1gXi3O/1OWgeyEMD?=
 =?us-ascii?Q?Zip6bqWyu1Q7QP2lcNZ8izfjWAE007bjXYumyhfHmm8oUvZYlm9hK9Y56Awh?=
 =?us-ascii?Q?VrWBX2p8WBOyuFEwVM9gWwYLkrdImb8pa57aNkKj1H6yR4VSfQkfY2x5LsNb?=
 =?us-ascii?Q?JmFcg1wOH/uhjVNxWlPcjl5c5Etr9mEiZFvHya1Ev8i3uomp3U892RO1rS/r?=
 =?us-ascii?Q?d9d7Pxi3CIeBdozEQVH1sY+1QyGp2Dv23u3dqLvkBY5biqHJ4a5uyO6w/3V6?=
 =?us-ascii?Q?xfvtoL+hkKJ74Wl1u1IDZ/l8M96Y/D4eP+u+O34atUiYABrlijj3oZwTB9Pd?=
 =?us-ascii?Q?bti6qL73rCKrMbbXRgstQOZIrqEwHn3RbmOjHglNH832aFbJH/On+qkrM7xg?=
 =?us-ascii?Q?6N1qUMHNFXVG5itB+b1Sl1LmIj5tCbfiamST/JjeGEoE9U5b6KA7g9hjSpHE?=
 =?us-ascii?Q?OwH5p38KjGWyHFmwMfS9JflBL8KQb4Wwvopg0tEyDAQ+ThFy26NPyBOwna1c?=
 =?us-ascii?Q?PGvykpZoNreBJssOyBLngaomde1DD/8zpnCqZsmRT3eA6ZFefW4xhZgO3UEO?=
 =?us-ascii?Q?T1dbZHJ0/fNBB5o8WQhZMPaD28VgSURt7ScK0DFIaLcKOM9fZC+uULhaByA0?=
 =?us-ascii?Q?9IGakTNIZJvONm4n2L3eZZcx7blbp8tZCD/NCVINvMxUsc0HzfgLlYlBvqER?=
 =?us-ascii?Q?AO0dD45UbR+01zFhTRibIqFikhge4JggEws7vzj7gG6Kz3zHCGH9ZoY61uaM?=
 =?us-ascii?Q?L3COu/gHHP7Zq16cie6JfGWpY+4wInc32B7syJuuI17XZwZ8emixj/t24RGP?=
 =?us-ascii?Q?2UnlXrTAyR33QsP/+2+BHyBAxBPkl20HrNWyHEqt77KNJw7037H5RV8J4vXd?=
 =?us-ascii?Q?NzBk4nU9WvcviKfcLBmVeg+OjT1U5GRalhPjePMYCeVGHTY09c2IYkldenhQ?=
 =?us-ascii?Q?im567h/syFmKw3ExXzFa8NXLNl14qSJxbZ6TMTMdhg2gfgfpyk8lS+/Jyx/c?=
 =?us-ascii?Q?qOMJT6eYsxVgjXO/NYqqyvE4iURqWWESediEAGI7r/h+ImZlSX2XoDIMTBnr?=
 =?us-ascii?Q?da4nv8sZ9BUybH40HZF7SqWIsrOrSIOvafr5KSR1sFCgNw6us/7n/MeFBcPf?=
 =?us-ascii?Q?8l1dXZnAFn4VvWauo5iXJzoGAxk972HIGsHuYs8oWByd9qGiYR5eiEFVc61T?=
 =?us-ascii?Q?hg8b7S0X7IDSf7nMKizciHWeZ4Jm1Z/QlkJhLJQCYtjjBLzmavFjZ41rte1g?=
 =?us-ascii?Q?pI78iYek8wZPk4lxp5dxBrEzGlqKpYz0B0zHJAPL2+WAg79TeRYw4REtZao+?=
 =?us-ascii?Q?j8qfyZiAFGSj6BgLWas92KVUdt6r22bswiftb2IBYktDLM0vHg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 09:50:51.9656 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e0086e-abae-4c34-ff9f-08dcfa5aac1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6383
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

The commit 7576ab2facae ("riscv: Add support for AMD/Xilinx MicroBlaze V")
added support for 32bit version. 64bit version is also available that's why
wire it up too.
DT is providing description for generic QEMU target.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/riscv/dts/Makefile              |  1 +
 arch/riscv/dts/xilinx-mbv64.dts      | 99 ++++++++++++++++++++++++++++
 configs/xilinx_mbv64_defconfig       | 44 +++++++++++++
 configs/xilinx_mbv64_smode_defconfig | 48 ++++++++++++++
 4 files changed, 192 insertions(+)
 create mode 100644 arch/riscv/dts/xilinx-mbv64.dts
 create mode 100644 configs/xilinx_mbv64_defconfig
 create mode 100644 configs/xilinx_mbv64_smode_defconfig

diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
index bf32ead01b03..de356584bf1e 100644
--- a/arch/riscv/dts/Makefile
+++ b/arch/riscv/dts/Makefile
@@ -10,6 +10,7 @@ dtb-$(CONFIG_TARGET_SIPEED_MAIX) += k210-maix-bit.dtb
 dtb-$(CONFIG_TARGET_STARFIVE_VISIONFIVE2) += jh7110-starfive-visionfive-2.dtb
 dtb-$(CONFIG_TARGET_TH1520_LPI4A) += th1520-lichee-pi-4a.dtb
 dtb-$(CONFIG_TARGET_XILINX_MBV) += xilinx-mbv32.dtb
+dtb-$(CONFIG_TARGET_XILINX_MBV) += xilinx-mbv64.dtb
 dtb-$(CONFIG_TARGET_ASPEED_AST2700_IBEX) += ast2700-ibex.dtb
 
 include $(srctree)/scripts/Makefile.dts
diff --git a/arch/riscv/dts/xilinx-mbv64.dts b/arch/riscv/dts/xilinx-mbv64.dts
new file mode 100644
index 000000000000..4d65d338ecb6
--- /dev/null
+++ b/arch/riscv/dts/xilinx-mbv64.dts
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dts file for AMD MicroBlaze V
+ *
+ * (C) Copyright 2023 - 2024, Advanced Micro Devices, Inc.
+ *
+ * Michal Simek <michal.simek@amd.com>
+ */
+
+/dts-v1/;
+
+#include "binman.dtsi"
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	model = "AMD MicroBlaze V 64bit";
+	compatible = "qemu,mbv", "amd,mbv";
+
+	cpus: cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		timebase-frequency = <100000000>;
+		cpu_0: cpu@0 {
+			compatible = "amd,mbv64", "riscv";
+			device_type = "cpu";
+			reg = <0>;
+			riscv,isa = "rv64imafdc";
+			i-cache-size = <32768>;
+			d-cache-size = <32768>;
+			clock-frequency = <100000000>;
+			cpu0_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
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
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0 0x80000000 0 0x40000000>;
+	};
+
+	clk100: clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+	};
+
+	axi: axi {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		compatible = "simple-bus";
+		ranges;
+		bootph-all;
+
+		axi_intc: interrupt-controller@41200000 {
+			compatible = "xlnx,xps-intc-1.00.a";
+			reg = <0 0x41200000 0 0x1000>;
+			interrupt-controller;
+			interrupt-parent = <&cpu0_intc>;
+			#interrupt-cells = <2>;
+			kind-of-intr = <0>;
+		};
+
+		xlnx_timer0: timer@41c00000 {
+			compatible = "xlnx,xps-timer-1.00.a";
+			reg = <0 0x41c00000 0 0x1000>;
+			interrupt-parent = <&axi_intc>;
+			interrupts = <0 2>;
+			bootph-all;
+			xlnx,one-timer-only = <0>;
+			clock-names = "s_axi_aclk";
+			clocks = <&clk100>;
+		};
+
+		uart0: serial@40600000 {
+			compatible = "xlnx,xps-uartlite-1.00.a";
+			reg = <0 0x40600000 0 0x1000>;
+			interrupt-parent = <&axi_intc>;
+			interrupts = <1 2>;
+			bootph-all;
+			clocks = <&clk100>;
+			current-speed = <115200>;
+			xlnx,data-bits = <8>;
+			xlnx,use-parity = <0>;
+		};
+	};
+};
diff --git a/configs/xilinx_mbv64_defconfig b/configs/xilinx_mbv64_defconfig
new file mode 100644
index 000000000000..aad9c3f140b2
--- /dev/null
+++ b/configs/xilinx_mbv64_defconfig
@@ -0,0 +1,44 @@
+CONFIG_RISCV=y
+CONFIG_SYS_MALLOC_LEN=0xe00000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x81200000
+CONFIG_ENV_SIZE=0x20000
+CONFIG_DEFAULT_DEVICE_TREE="xilinx-mbv64"
+CONFIG_SPL_STACK=0x80200000
+CONFIG_SPL_BSS_START_ADDR=0x84000000
+CONFIG_SPL_BSS_MAX_SIZE=0x80000
+CONFIG_SYS_LOAD_ADDR=0x80200000
+CONFIG_SPL_SIZE_LIMIT=0x40000
+CONFIG_SPL=y
+CONFIG_DEBUG_UART_BASE=0x40600000
+CONFIG_DEBUG_UART_CLOCK=100000000
+CONFIG_SYS_CLK_FREQ=100000000
+CONFIG_BOOT_SCRIPT_OFFSET=0x0
+CONFIG_DEBUG_UART=y
+CONFIG_TARGET_XILINX_MBV=y
+CONFIG_ARCH_RV64I=y
+# CONFIG_SPL_SMP is not set
+CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x80200000
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_DISPLAY_CPUINFO=y
+CONFIG_DISPLAY_BOARDINFO=y
+# CONFIG_BOARD_LATE_INIT is not set
+CONFIG_SPL_MAX_SIZE=0x40000
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
+# CONFIG_CMD_MII is not set
+CONFIG_CMD_TIMER=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_DM_MTD=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_SKIP_INIT=y
+CONFIG_XILINX_UARTLITE=y
+CONFIG_XILINX_TIMER=y
+# CONFIG_BINMAN_FDT is not set
+CONFIG_PANIC_HANG=y
+CONFIG_SPL_GZIP=y
diff --git a/configs/xilinx_mbv64_smode_defconfig b/configs/xilinx_mbv64_smode_defconfig
new file mode 100644
index 000000000000..628e0ed5be2c
--- /dev/null
+++ b/configs/xilinx_mbv64_smode_defconfig
@@ -0,0 +1,48 @@
+CONFIG_RISCV=y
+CONFIG_SYS_MALLOC_LEN=0xe00000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x81200000
+CONFIG_ENV_SIZE=0x20000
+CONFIG_DEFAULT_DEVICE_TREE="xilinx-mbv64"
+CONFIG_SPL_STACK=0x80200000
+CONFIG_SPL_BSS_START_ADDR=0x84000000
+CONFIG_SPL_BSS_MAX_SIZE=0x80000
+CONFIG_SYS_LOAD_ADDR=0x80200000
+CONFIG_SPL_SIZE_LIMIT=0x40000
+CONFIG_SPL=y
+CONFIG_DEBUG_UART_BASE=0x40600000
+CONFIG_DEBUG_UART_CLOCK=1000000
+CONFIG_SYS_CLK_FREQ=100000000
+CONFIG_BOOT_SCRIPT_OFFSET=0x0
+CONFIG_TARGET_XILINX_MBV=y
+CONFIG_SPL_OPENSBI_LOAD_ADDR=0x80100000
+CONFIG_ARCH_RV64I=y
+CONFIG_RISCV_SMODE=y
+# CONFIG_SPL_SMP is not set
+CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x80200000
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_DISPLAY_CPUINFO=y
+CONFIG_DISPLAY_BOARDINFO=y
+# CONFIG_BOARD_LATE_INIT is not set
+CONFIG_SPL_MAX_SIZE=0x40000
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
+CONFIG_SPL_OPENSBI_SCRATCH_OPTIONS=0x2
+# CONFIG_CMD_MII is not set
+CONFIG_CMD_TIMER=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_DM_MTD=y
+CONFIG_DEBUG_UART_UARTLITE=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_SKIP_INIT=y
+CONFIG_XILINX_UARTLITE=y
+# CONFIG_RISCV_TIMER is not set
+CONFIG_XILINX_TIMER=y
+# CONFIG_BINMAN_FDT is not set
+CONFIG_PANIC_HANG=y
+CONFIG_SPL_GZIP=y
-- 
2.43.0

