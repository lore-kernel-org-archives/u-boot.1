Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82820C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 11:57:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 660F886BAC;
	Mon,  6 Nov 2023 12:57:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wdI0qily";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0748886F68; Mon,  6 Nov 2023 12:57:04 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::622])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C59586BA9
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 12:57:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqISY6GJafGwzQbyeoa4BKht74+rwcixJCT1KP2cog3u+7woEsiuG1JSv9j7ay+asg0AAB6CTDt3Cw0BG+idYwaYh0r2K03pdxr0FM02WRLGn/MIQeu1gcBO5Ii9WeLqioEUEvsAi4uIwDqSJ0LUFqilMoYPrvbs7rKIFUYSKihO8tpLPF1ouJPtgypsQIVrWhDwNXcKo9Tr2LoM61XIzLHUlRvi+WD3mPuDIZOHs74Dd+noUDUVF0/9/RYEEyJvYlQXLgeNkp0xEvl1mKY7XVwuCdlGMFgYA6XwqSvz9eb2um5LTqrarT78Bdy7wQut3oHLk1qy4xU6j0MDUcryvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDGFlKc/xAtSN9S9+oD1MkLkrJ2EyXMlm0dpsRLFRCg=;
 b=AyWRQruXCxjyWIamXoscqaZm6rH5muIw9rsvXCUhEd7Ddn2zDuAOUIrrRLUO/ucC45CcQfGTqgIjSVRlU0ytYJ6z7jXsISLBGcSB6/AwXdDUqrW3krN0BuhefuO+MWaWJACIAYQEkT1WaV+IVJhLq6d/KSz6EGgnfZVgW3ZBoWidlp8O1End0cpp+Nj3hCN1d44Vo6vl+KnCIDoqjUZHqjalQ67JtOJBA3Pn8SrYO6ADJiecJxXf1XGb2oK/Z07RD1czo5U40SusUQm/RkGZJ/igIp9QiubIYgshvVPCi8sW775rFCn6njFoCavil68LfyG/ZVFWpTNFc5DWbUH7Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDGFlKc/xAtSN9S9+oD1MkLkrJ2EyXMlm0dpsRLFRCg=;
 b=wdI0qily9rWB/3O3zmo37cLz4TcDvEhTMZ3Dg27jLJW93i9Vk1Omz+y9XzKsSe0lLVZJrCQgJnKhWk/lMUX/wQ6yKTK8W0Umi63nQ+o8TyaOAOTwCQjE1ojyNnJKlzNe+VR4DOxafKISkcEG9YQnmMMRromKkJW74P+ksElbW1w=
Received: from BYAPR11CA0105.namprd11.prod.outlook.com (2603:10b6:a03:f4::46)
 by PH7PR12MB5829.namprd12.prod.outlook.com (2603:10b6:510:1d4::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.25; Mon, 6 Nov
 2023 11:56:55 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:a03:f4:cafe::16) by BYAPR11CA0105.outlook.office365.com
 (2603:10b6:a03:f4::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28 via Frontend
 Transport; Mon, 6 Nov 2023 11:56:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Mon, 6 Nov 2023 11:56:55 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 6 Nov
 2023 05:56:53 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Conor Dooley <conor.dooley@microchip.com>, Leo <ycliang@andestech.com>,
 Padmarao Begari <padmarao.begari@microchip.com>, Randolph
 <randolph@andestech.com>, Rick Chen <rick@andestech.com>, Yanhong Wang
 <yanhong.wang@starfivetech.com>, Yixun Lan <dlan@gentoo.org>
Subject: [PATCH v2] riscv: Add support for AMD/Xilinx MicroBlaze V
Date: Mon, 6 Nov 2023 12:56:47 +0100
Message-ID: <d488b7016e0d1b1324c64d8a8b2f033851aab6c6.1699271804.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12034; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=MiuGkqc4wr51urXQw7Z/R8Qk63BgsjCh3iEDIYJEceM=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlSPK7WPs6yCNNaJ7Xecqn3yCI9SRp3M9kXbld5pRac57
 L0sfEKmI5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAEykegbDgu5VmcWtfgpBJy6u
 Lsgrutv1euEEfob58c8Wbjj0b8uhhGrLX9nX4xbac16yBQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|PH7PR12MB5829:EE_
X-MS-Office365-Filtering-Correlation-Id: 19399890-e3e8-4580-7d70-08dbdebf7909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yh3mqN4/NKX3xpsLAu5JaWGT5bLQHN9TdYUWgtsKBvd8ZTKBdmAEkDKDvA7+x1KKSNThnblFF43NYLAsVUzYsXabPm+PckTmeLs6J+YhqRNCYDVBoyH8HH+cBn/8rf+dQlVLeYflrKk7Ll9Cuxn78ukG0t90DkaZEeW990aJHb8vSIX0ne6HyeNngYo+qa6ObNFEwW220xyIlXj7SjQv5CHkglE3RfJwI/fklPaOaUT5YcosOwVy66NGbWMVHWO1lo4uXQvhh2qANchwaOQYIt9Gf9nqDR00zQ+CVVvPMxGWAdGGK+u1v/jGvW90U344TiVfE4zvimrPTx+IPjc9HmpgPRCQhbHI8/zRQG1CkN4uO0WocfMf1SRtABaU/oFxAkMeIHsHXQpz9ex4aAV30gIoxKTxFbFlvEYqAzCdsBLui5XBr99BRWjBxAPVTFMPA0oGkID6VvwvI+0dPgBBqV7cdHdrcW77346CCfy290F9j16ZjlKZHmHwmtpa/XcondtGVNq6mQ+pRvuLLxXo4S6xOoMGVkh4n1W1zYKVe546YnBvhXSTgbhKhss+Nu/WQj8DedLXSNEZX+PJwE1zn+AfQBxOhxhyAdSx4QXaddjCAOJeJWeh4aagsaYNPp9+kLiaJkTo5ax1+W3O7Zmap/UefKofI+GTEXIXgfFdNilOGNMyTRAEVX1vjNXXQG+jyEWnVPqsWqCSt/RlKBM9iYWw4QJTgNZODRNsNsdd4qr9Cjrc04WSFo6Ip5NkrwkwN9r3uzrVH1Yc9jZsq+2FhclsmU7jYp3AFW/4rzLAhiU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(82310400011)(186009)(64100799003)(1800799009)(451199024)(36840700001)(46966006)(40470700004)(110136005)(70206006)(2906002)(40460700003)(41300700001)(30864003)(36860700001)(47076005)(70586007)(82740400003)(54906003)(86362001)(356005)(81166007)(6666004)(478600001)(2616005)(83380400001)(16526019)(26005)(426003)(966005)(336012)(316002)(5660300002)(44832011)(36756003)(4326008)(8676002)(8936002)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 11:56:55.2279 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19399890-e3e8-4580-7d70-08dbdebf7909
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5829
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
with memory, cpu, interrupt controller, timers and uartlite console
(interrupt controller is listed but U-Boot is not using it).

Provided DT is just describing one configuration and should be taken only
as example.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- Extend commit message
- DT changes, add interrupt controller, check agains dt schema
- The patch for amd,mbv32 compatible string is here
https://lore.kernel.org/r/d442d916204d26f82c1c3a924a4cdfb117960e1b.1699270661.git.michal.simek@amd.com
- The patch for board compatibility is here
https://lore.kernel.org/r/50c277c92c41a582ef171fb75efc6a6a4f860be2.1699271616.git.michal.simek@amd.com

xlnx,xps-intc-1.00.a driver exists in the Linux kernel but DT binding is
missing. That's something what we need to work on.
arch/arm64/boot/dts/xilinx/xilinx-mbv32.dtb: /axi/interrupt-controller@41200000: failed to match any schema with compatible: ['xlnx,xps-intc-1.00.a']

Public annoucement is available here if someone is interested.
https://www.xilinx.com/products/design-tools/microblaze-v.html?utm_source=marketo&utm_medium=email&utm_campaign=EN-EM-2023-11-02-New-MicroBlaze-V-Processor&utm_term=btn&mkt_tok=NDA5LVdZWC03MjQAAAGPMMJYuPPscCags7WdvOeUSWy-_mC9aOwrobFaZRf5ok_eHoQUvTLBzJdHrkcBId9tQ4a-odfnU91WjUkIxx-iSG4OKGofjK5iZcAiK_VN8_xK

---
 arch/riscv/Kconfig                   |   4 +
 arch/riscv/dts/Makefile              |   2 +
 arch/riscv/dts/xilinx-mbv32.dts      | 106 +++++++++++++++++++++++++++
 board/xilinx/Kconfig                 |   3 +-
 board/xilinx/common/board.c          |   5 ++
 board/xilinx/mbv/Kconfig             |  28 +++++++
 board/xilinx/mbv/MAINTAINERS         |   7 ++
 board/xilinx/mbv/Makefile            |   5 ++
 board/xilinx/mbv/board.c             |  11 +++
 configs/xilinx_mbv32_defconfig       |  30 ++++++++
 configs/xilinx_mbv32_smode_defconfig |  32 ++++++++
 include/configs/xilinx_mbv.h         |   6 ++
 12 files changed, 238 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/dts/xilinx-mbv32.dts
 create mode 100644 board/xilinx/mbv/Kconfig
 create mode 100644 board/xilinx/mbv/MAINTAINERS
 create mode 100644 board/xilinx/mbv/Makefile
 create mode 100644 board/xilinx/mbv/board.c
 create mode 100644 configs/xilinx_mbv32_defconfig
 create mode 100644 configs/xilinx_mbv32_smode_defconfig
 create mode 100644 include/configs/xilinx_mbv.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 6d0d812ddb55..67126d96af89 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -39,6 +39,9 @@ config TARGET_TH1520_LPI4A
 	bool "Support Sipeed's TH1520 Lichee PI 4A Board"
 	select SYS_CACHE_SHIFT_6
 
+config TARGET_XILINX_MBV
+	bool "Support AMD/Xilinx MicroBlaze V"
+
 endchoice
 
 config SYS_ICACHE_OFF
@@ -82,6 +85,7 @@ source "board/sifive/unmatched/Kconfig"
 source "board/sipeed/maix/Kconfig"
 source "board/starfive/visionfive2/Kconfig"
 source "board/thead/th1520_lpi4a/Kconfig"
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
index 000000000000..6a6b8b694bd1
--- /dev/null
+++ b/arch/riscv/dts/xilinx-mbv32.dts
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dts file for AMD MicroBlaze V
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
+	model = "AMD MicroBlaze V 32bit";
+	compatible = "amd,mbv";
+
+	cpus: cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		timebase-frequency = <102000000>;
+		cpu_0: cpu@0 {
+			compatible = "amd,mbv32", "riscv";
+			device_type = "cpu";
+			reg = <0>;
+			riscv,isa = "rv32imafdc";
+			i-cache-size = <32768>;
+			d-cache-size = <32768>;
+			clock-frequency = <102000000>;
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
+	memory@20000000 {
+		device_type = "memory";
+		reg = <0x20000000 0x20000000>;
+	};
+
+	clk102: clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <102000000>;
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
+			compatible = "xlnx,xps-intc-1.00.a";
+			reg = <0x41200000 0x1000>;
+			interrupt-controller;
+			interrupt-parent = <&cpu0_intc>;
+			#interrupt-cells = <2>;
+			kind-of-intr = <0>;
+		};
+
+		xlnx_timer0: timer@41c00000 {
+			compatible = "xlnx,xps-timer-1.00.a";
+			reg = <0x41c00000 0x1000>;
+			interrupt-parent = <&axi_intc>;
+			interrupts = <1 2>;
+			bootph-all;
+			xlnx,one-timer-only = <0>;
+			clock-names = "s_axi_aclk";
+			clocks = <&clk102>;
+		};
+
+		xlnx_timer1: timer@41c20000 {
+			compatible = "xlnx,xps-timer-1.00.a";
+			reg = <0x41c20000 0x1000>;
+			interrupt-parent = <&axi_intc>;
+			interrupts = <0 2>;
+			xlnx,one-timer-only = <0>;
+			clock-names = "s_axi_aclk";
+			clocks = <&clk102>;
+		};
+
+		uart0: serial@40600000 {
+			compatible = "xlnx,xps-uartlite-1.00.a";
+			reg = <0x40600000 0x1000>;
+			interrupt-parent = <&axi_intc>;
+			interrupts = <2 2>;
+			bootph-all;
+			clocks = <&clk102>;
+			current-speed = <115200>;
+			xlnx,data-bits = <8>;
+			xlnx,use-parity = <0>;
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

