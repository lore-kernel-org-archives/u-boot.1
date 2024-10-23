Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 667C6D2E016
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 06:07:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3B9F890AE;
	Wed, 23 Oct 2024 08:07:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Tz1lgz76";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DD2589092; Wed, 23 Oct 2024 08:07:03 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::60d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9E7F890AE
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 08:06:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u2TCPAvi+Al8Pa/J9IGKcR6/3EeC/yprANiXlNcAgYae3YCN/OokshK2581jTNcd1i5Hj82fk8/TLfs2XF+4kymGMqYU1BjOPmOTJow/w5atnJZGNkTjmczBylx3YiVQ2fzaWL/38R/ylOPXWG+TclH+b31FiY743QjJfX6euuvc1APaE2D5gI2oGY3caQwKv0Knlu660zSljLUvw3sEqnl2ncxFYRWP/+w5pZbZhBj9Ra0Yq3Ily+bdTQM/GlzL0wMRUMsDYXf5csxbUGcaYr+l5BIXCk3UX2okup1NMLKeHpiBRiap/JSdue2C3jFnpmmYNZ89n43MwyF4b8UuwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQbQGcVHCl099X98OS62/GTUa9327cRBk8TLxzUAzk4=;
 b=lDpuVPjHyp36lHMeRtxdrQsg2qiWjc87qzOdKNonCfoDtB5kYUhIM/fwg97IG1i8y9J2ix81O8f3+vOppXtN/FaFnpbVP30/1AuOb6y4B+34rn2jm668jD8r7snLgpOXKx94BBQAxf+cjDXRqGfnRiwpkp1/18Qx3tFZdschEguFdpVZ8qI4rFbD5MuUnSPs1JQO4HunjFVAeEoJ/CNHlMq3nPcTWn8ithxJTFgQ4p+lfCBkbPhJlqKoUviMwJfNKCYJbuE7eXUljBSV21aYAvjXcPI9rZL9UmGKhlUcTbrEL1+LHEgOX89znyQF1Vek98cK370O8tn/JZONcPpDGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQbQGcVHCl099X98OS62/GTUa9327cRBk8TLxzUAzk4=;
 b=Tz1lgz76W6/wpzHXt9UDM8bgkcMXlDdhnZmaEm1LB3FjtNKubQ+cSbUHY5DuYVbp2RFOAP5FFGnH12JjaooqldawP4yPdxQ6UX5R1JemsE7gN62gC1ad+OJY6NIOvvwgWbLjVWfFFY/PqHzhp60Lw80Dv4QqW5MufGaP+Sw7g0s=
Received: from BYAPR01CA0026.prod.exchangelabs.com (2603:10b6:a02:80::39) by
 DM4PR12MB6328.namprd12.prod.outlook.com (2603:10b6:8:a0::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.29; Wed, 23 Oct 2024 06:06:51 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a02:80:cafe::d6) by BYAPR01CA0026.outlook.office365.com
 (2603:10b6:a02:80::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Wed, 23 Oct 2024 06:06:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 06:06:51 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 01:06:47 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Leo <ycliang@andestech.com>, Padmarao Begari
 <padmarao.begari@microchip.com>, Rick Chen <rick@andestech.com>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH] riscv: mbv: Align DT with QEMU
Date: Wed, 23 Oct 2024 08:06:40 +0200
Message-ID: <077311f948de84c055ce2529370734b8ce310ad6.1729663597.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4379; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=PNFHWj4WnTwSs0s9hJdu6ZGPi3TDXsl8elfUWN8hnWc=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhnSJSYWud3XLZHSMryddtQnQzp2/s/aJ0xXBl+6bfPXfH
 P/2WoelI5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAFxEjGHBBOnQrAkCjm/Nb4go
 sXsmXFnxY68mw3ynhffCjr+eYXVUMkbhDNPEk9r/T94CAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|DM4PR12MB6328:EE_
X-MS-Office365-Filtering-Correlation-Id: 2678cbdd-b3f1-402a-28ea-08dcf328e2ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6sQGnKKqQpoR3B2LOl1uil91FwWybZ7YOxewNUFL5RsXd0oa5ePVgo5sHwcH?=
 =?us-ascii?Q?FbdRr5gt/wwFwzEHPVcOLU2rOJuDt9kLNLgWDc1JFXmIrE8rQqUO5lNBvRFt?=
 =?us-ascii?Q?Bn1HAAO90TI4uUk5gywWjyXo2H8lkFlGkWMQd831/xTgTwlKu3Otk2exos1O?=
 =?us-ascii?Q?uEZWu5ZzHy4cSytf5XDGa1fBIYLA3Y/LIIb+ZuqbbMcSVF5G3WBROpr7lD4f?=
 =?us-ascii?Q?p+aTT3Sq0/RbZkiI12Zb/zo5YQ6g2etDs+7qNLdK9I3ZASwxHfO+BmXWPuyX?=
 =?us-ascii?Q?6jNe+t9SnubzVsg/uE+XMlmPdDh3ngzrwfQu/yzZhCMciHLhD/v5MPfQeNJ1?=
 =?us-ascii?Q?YKPD/i8wad24U94fbYbSUhEeI/KdEfmIXcCqCJMpRXpdRoB8sLtrrbDjEfvp?=
 =?us-ascii?Q?pEAoq0oZhsfzx1JrI7e8720BHvyvv1ouVVXJgJKsD3eLe6p8Feylv30DP9S+?=
 =?us-ascii?Q?r9IVdSop+3gqqgS8Wx1AkbRexKj3mR50tUsuSzYRuxA0ButfRiAEqrsTJM8x?=
 =?us-ascii?Q?oV13sPn6vROsLWmalqdT/dFGSWQV8mOMNKYerAYUQ9TRc9qdKiA6zAs92AfS?=
 =?us-ascii?Q?eU4NxRas+khXHKNZyx/hiCoSybVUcqUGM6uAIEBXaLIPN50qalr2E1cWjJui?=
 =?us-ascii?Q?92RvO4ayA4NjK+rtCEZnepKsfc45ua+YjMbw71k0TvRG9mmyEHhlx34rSwf+?=
 =?us-ascii?Q?fspC0xWZEAa9LoiWQXakT/C+i6wnJg1JS/XJAUVbmxKeyS/wV/YydJHdOpyA?=
 =?us-ascii?Q?obIpvjSSCbYrMRaRQqrZXTjC5xJ4KeG3l6BxcFhKdtvTwHoUjqoHxrT81fhX?=
 =?us-ascii?Q?ubnIt8IL1kPQeN4VIGNAT8EQ2iAw32sJTjXMWLyl1ELB1LiE5Y3xmfLCR6hN?=
 =?us-ascii?Q?wrGoipH244WG5YA+4zNAfAlUoq8iIwKTI3I3YHuHwVZrUtZ+z4GYCE0fOo++?=
 =?us-ascii?Q?qIeM+79Su+4UxS0szQ3xCPBbbWHkSckuSn6HX2m68YhIilzdTLzM+hP6a7ZB?=
 =?us-ascii?Q?ABIMKKQHta25sfkT1cXfQqKSSanswzlnZDKKdBl+Fv6oFcl9bRNi7fUs0LOC?=
 =?us-ascii?Q?Yeps/AO6Ya6IKCFPu4/HVDaLnH3JfvwGiMH50NemH85fv7sgfmOnVLJtXlQ5?=
 =?us-ascii?Q?BMPETdZJAmdaV1wOtpoOtirf3TktY7vvY6wXCI3LWiVLyOhrYg5qzepmyO0r?=
 =?us-ascii?Q?cuKvdpG6a5Hq5CAiuXQe8SCzvZWqJQNStkENCIbRifC3GRyo5jleo4W/TPaJ?=
 =?us-ascii?Q?M/amlh1kW0I1QH0IqH+IUXBFD+iuzv8CROg+RelrT7DeUQELg513Sih6ZjNu?=
 =?us-ascii?Q?xV7rNeozZY5MvwPpucoZNqjvv5/xA5F6PJX2PFqdf310twxxKJrX4/EuWOzH?=
 =?us-ascii?Q?mxz/a62EBa3alRvvlmHgx/06SpIPNAqhMGvU98D/GRhRgH+cMg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 06:06:51.0975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2678cbdd-b3f1-402a-28ea-08dcf328e2ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6328
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

Align U-Boot with QEMU amd-microblaze-v-virt platform to be able to wire
it with CI.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

I am sending it to be in queue. Qemu patch hasn't been merged to qemu yet
but here is the latest version.
https://lore.kernel.org/r/20241017072507.4033413-1-sai.pavan.boddu@amd.com
---
 arch/riscv/dts/xilinx-mbv32.dts | 30 ++++++++++--------------------
 board/xilinx/mbv/Kconfig        |  6 +++---
 configs/xilinx_mbv32_defconfig  | 12 ++++++------
 3 files changed, 19 insertions(+), 29 deletions(-)

diff --git a/arch/riscv/dts/xilinx-mbv32.dts b/arch/riscv/dts/xilinx-mbv32.dts
index 48ee11549566..4050ce2f051d 100644
--- a/arch/riscv/dts/xilinx-mbv32.dts
+++ b/arch/riscv/dts/xilinx-mbv32.dts
@@ -20,7 +20,7 @@
 	cpus: cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		timebase-frequency = <102000000>;
+		timebase-frequency = <100000000>;
 		cpu_0: cpu@0 {
 			compatible = "amd,mbv32", "riscv";
 			device_type = "cpu";
@@ -28,7 +28,7 @@
 			riscv,isa = "rv32imafdc";
 			i-cache-size = <32768>;
 			d-cache-size = <32768>;
-			clock-frequency = <102000000>;
+			clock-frequency = <100000000>;
 			cpu0_intc: interrupt-controller {
 				compatible = "riscv,cpu-intc";
 				interrupt-controller;
@@ -46,15 +46,15 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory@20000000 {
+	memory@80000000 {
 		device_type = "memory";
-		reg = <0x20000000 0x20000000>;
+		reg = <0x80000000 0x40000000>;
 	};
 
-	clk102: clock {
+	clk100: clock {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
-		clock-frequency = <102000000>;
+		clock-frequency = <100000000>;
 	};
 
 	axi: axi {
@@ -77,30 +77,20 @@
 			compatible = "xlnx,xps-timer-1.00.a";
 			reg = <0x41c00000 0x1000>;
 			interrupt-parent = <&axi_intc>;
-			interrupts = <1 2>;
-			bootph-all;
-			xlnx,one-timer-only = <0>;
-			clock-names = "s_axi_aclk";
-			clocks = <&clk102>;
-		};
-
-		xlnx_timer1: timer@41c20000 {
-			compatible = "xlnx,xps-timer-1.00.a";
-			reg = <0x41c20000 0x1000>;
-			interrupt-parent = <&axi_intc>;
 			interrupts = <0 2>;
+			bootph-all;
 			xlnx,one-timer-only = <0>;
 			clock-names = "s_axi_aclk";
-			clocks = <&clk102>;
+			clocks = <&clk100>;
 		};
 
 		uart0: serial@40600000 {
 			compatible = "xlnx,xps-uartlite-1.00.a";
 			reg = <0x40600000 0x1000>;
 			interrupt-parent = <&axi_intc>;
-			interrupts = <2 2>;
+			interrupts = <1 2>;
 			bootph-all;
-			clocks = <&clk102>;
+			clocks = <&clk100>;
 			current-speed = <115200>;
 			xlnx,data-bits = <8>;
 			xlnx,use-parity = <0>;
diff --git a/board/xilinx/mbv/Kconfig b/board/xilinx/mbv/Kconfig
index a3a6f2125770..c52ba1870b0b 100644
--- a/board/xilinx/mbv/Kconfig
+++ b/board/xilinx/mbv/Kconfig
@@ -10,14 +10,14 @@ config SYS_CPU
 	default "generic"
 
 config TEXT_BASE
-	default 0x21200000
+	default 0x81200000
 
 config SPL_TEXT_BASE
-	default 0x20000000
+	default 0x80000000
 
 config SPL_OPENSBI_LOAD_ADDR
 	hex
-	default 0x20200000
+	default 0x80200000
 
 config BOARD_SPECIFIC_OPTIONS
 	def_bool y
diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
index 3983b20c2d80..7333413267ec 100644
--- a/configs/xilinx_mbv32_defconfig
+++ b/configs/xilinx_mbv32_defconfig
@@ -2,17 +2,17 @@ CONFIG_RISCV=y
 CONFIG_SYS_MALLOC_LEN=0xe00000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x21200000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x81200000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_DEFAULT_DEVICE_TREE="xilinx-mbv32"
-CONFIG_SPL_STACK=0x20200000
-CONFIG_SPL_BSS_START_ADDR=0x24000000
+CONFIG_SPL_STACK=0x80200000
+CONFIG_SPL_BSS_START_ADDR=0x84000000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
-CONFIG_SYS_LOAD_ADDR=0x20200000
+CONFIG_SYS_LOAD_ADDR=0x80200000
 CONFIG_SPL_SIZE_LIMIT=0x40000
 CONFIG_SPL=y
 CONFIG_DEBUG_UART_BASE=0x40600000
-CONFIG_DEBUG_UART_CLOCK=1000000
+CONFIG_DEBUG_UART_CLOCK=100000000
 CONFIG_SYS_CLK_FREQ=100000000
 CONFIG_BOOT_SCRIPT_OFFSET=0x0
 CONFIG_DEBUG_UART=y
@@ -20,7 +20,7 @@ CONFIG_TARGET_XILINX_MBV=y
 # CONFIG_SPL_SMP is not set
 CONFIG_REMAKE_ELF=y
 CONFIG_FIT=y
-CONFIG_SPL_LOAD_FIT_ADDRESS=0x20200000
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x80200000
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_DISPLAY_CPUINFO=y
 CONFIG_DISPLAY_BOARDINFO=y
-- 
2.43.0

