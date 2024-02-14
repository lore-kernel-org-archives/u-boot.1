Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F1CC48BC4
	for <u-boot@archiver.kernel.org>; Wed, 14 Feb 2024 11:54:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4608A87E1C;
	Wed, 14 Feb 2024 12:53:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nIjwd75Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 880D187E1D; Wed, 14 Feb 2024 12:53:07 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72F8187E18
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 12:53:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CWBD+NSmXEWofVltCQUkKzhBZGE5RJMMedIBNfd4Zb8QNfV5bpZK3afUEGvNY2uy4uJF9/MVoFjeSiYLqUvLHc7mMgRGdpFuHUGzJefQN4sEYgGVgUOIdzOsLZyyiAKJEZt5HzVSfMN58XgEv6m835X9IuHDqUMx47agPRr2hpkf5R62J/F4uYFUHHpLexfQE5TbllFte/YEuL0YUPckwe5nyj+RUwO10XHQAdSrWZ+gehRZNYsqqwCTWQYw1k4f2raQY1cZBUAPr7hhDeOMpKt4OUr1bsoBYIftN+rCBOEe6RYh0rwnPs7mMkTNBZfPmK9Y/e+T2/LvCm8qDORvuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFazBDfUO90GPk0hBxulmSVPWAAyk3WS/K2LVjkiE9I=;
 b=T7Ci9H8GLsuiB9JqiLujM+YOHY1365BzJpClSMK3fv7V/jFXGRN3qEF4K8Lg4MC8Cdj8e7bGOnT7SnBslPcBsH6iVmvOAt3a4t34CriiW01+7/VAQG/8nxarqEsHboEMt+GIZfT53ad/1lNU3r8/UZ/NTFwnIVTsGILixI7O1nr31/Xs/rgZ9vlTtjsWcL4tN6hkuus0dVcQyXQHZiddbJSRjx9sqsceDc0xav/SOhyibY6YjlNsiAptBZGCPyLm26tVdcbiqKKO6akHLfZ4lNsxACo5mi8KPlx2CdukMrCfp32pmrtbqmJAs60ZA5DqfsNdrI1/GuRqM5k3wxW7+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFazBDfUO90GPk0hBxulmSVPWAAyk3WS/K2LVjkiE9I=;
 b=nIjwd75YpLVtUW31JPPuhy9jpkAypgx+QLe4wmXut0kH88W6gfdt+nV/pWxXYf967Lu9ENYONI+Y1vsMxJQxdzjRfVh7zBJqVrwtQQW6sVF30NuZ3kYvuNN+FUWO4wVY8q5lW/pip++rvJnCH3GidrvNuONegbwiamRr0SXXkyc=
Received: from BN9PR03CA0456.namprd03.prod.outlook.com (2603:10b6:408:139::11)
 by DM4PR12MB6496.namprd12.prod.outlook.com (2603:10b6:8:bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.10; Wed, 14 Feb
 2024 11:52:57 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:408:139:cafe::fd) by BN9PR03CA0456.outlook.office365.com
 (2603:10b6:408:139::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Wed, 14 Feb 2024 11:52:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 11:52:57 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 05:52:55 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Algapally Santosh Sagar <santoshsagar.algapally@amd.com>, "Heinrich
 Schuchardt" <xypron.glpk@gmx.de>, Leo <ycliang@andestech.com>, Masahisa
 Kojima <masahisa.kojima@linaro.org>, Padmarao Begari
 <padmarao.begari@microchip.com>, Rick Chen <rick@andestech.com>, Shiji Yang
 <yangshiji66@outlook.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH 5/5] riscv: mbv: Enable SPL and binman
Date: Wed, 14 Feb 2024 12:52:33 +0100
Message-ID: <85506bce5580d448f095f267d029e3932c5e9990.1707911544.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1707911544.git.michal.simek@amd.com>
References: <cover.1707911544.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6163; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=y/2hoEkTDUjGJt2rwVxJaByMM3NMiW3e1TWeNVlc2XY=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtQzK+vZKguOPX1ziz/QukmuTncz17Zlh/fOn5DrsWTtn
 Zv71/7v7ohlYRBkYpAVU2SRtrlyZm/ljCnCFw/LwcxhZQIZwsDFKQATmWPGMJs9YsuGPsXps/59
 vf3rhKxXUIvUpyKGBXOWLC24yG4rd2WyqYHd/Wefl/VffAYA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|DM4PR12MB6496:EE_
X-MS-Office365-Filtering-Correlation-Id: 849551f7-17c3-4914-365f-08dc2d537c50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UB5Rpjyqf0ZM99wxB84ygYkHBD7JpydfAv7Q+o1JummDKBxdAOB1j+Pr6pvOqxyt9ecNqkQ30AizBomJeHMhkiXVgIcBKyF6c1Uzsr1VbAPgAwPO9aFhA2PkNLrhmbkaqg1/gEhatg1ch3UlypPQQKHiSK5P3lkIHeIy6eZWPvMiHntpIeBLOjWQN4ETZjzasOO4xWLWMw1f9w2X+1Q3kOIMtQXhEblVNa3D7o4nsN9I/oGmOlvA1UeQ9iRwO60O6Q+gzexwic8eW5IFQ6Y2x3pWfXsjWwrZN5/BwPvP0peeFn4okN34cdg9T8OsNvQeGEA+GPr6pyvpCaCwOnryFL4Bbxss3H8I7NPArMfrccGwEy3Cvl+MVu4B23vCUxmkJzef2tumB2VIakqFvQ3IrPB9VVjAAJf/1p2Dw4Ob66nWrLl86YLZ3CeVC/KmoP9Eq5UsSUHVEVCqKCkr1ema1UEzLrdd2VNheu71L/eIj0ZhHM3wNW6pC29H0iws/3QGiUc8fovFc3EjQajlARfIctkroPcg9OeoXi8z6xDTgNGJyHJbAH2ZdvazkLb1YkNGieNHIdmPWNGkwg2er38CC62qVtZ0SL9xbAQqznhp9Is=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(64100799003)(186009)(1800799012)(82310400011)(451199024)(36840700001)(40470700004)(36756003)(41300700001)(316002)(4326008)(8936002)(70206006)(110136005)(54906003)(82740400003)(8676002)(70586007)(83380400001)(5660300002)(2616005)(16526019)(356005)(478600001)(426003)(44832011)(2906002)(336012)(6666004)(26005)(81166007)(86362001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 11:52:57.0466 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 849551f7-17c3-4914-365f-08dc2d537c50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6496
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

Enable SPL and binman to generate u-boot.img (machine mode) and u-boot.itb
(supervisor mode). DTB is placed at fixed address to ensure that it is 8
byte aligned which is not ensured when dtb is attached behind SPL binary
that's why SPL and U-Boot are taking DTB from the same address.
Also align addresses for both defconfigs.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/riscv/dts/xilinx-mbv32.dts      |  3 +++
 board/xilinx/common/board.c          |  8 ++++++++
 board/xilinx/mbv/Kconfig             | 11 +++++++++++
 board/xilinx/mbv/board.c             | 10 ++++++++++
 configs/xilinx_mbv32_defconfig       | 18 ++++++++++++++++--
 configs/xilinx_mbv32_smode_defconfig | 20 ++++++++++++++++++--
 6 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/dts/xilinx-mbv32.dts b/arch/riscv/dts/xilinx-mbv32.dts
index 94e42c268115..48ee11549566 100644
--- a/arch/riscv/dts/xilinx-mbv32.dts
+++ b/arch/riscv/dts/xilinx-mbv32.dts
@@ -8,6 +8,9 @@
  */
 
 /dts-v1/;
+
+#include "binman.dtsi"
+
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
index 9641ed307b75..e5ab32f901b9 100644
--- a/board/xilinx/common/board.c
+++ b/board/xilinx/common/board.c
@@ -358,6 +358,14 @@ void *board_fdt_blob_setup(int *err)
 	void *fdt_blob;
 
 	*err = 0;
+
+	if (IS_ENABLED(CONFIG_TARGET_XILINX_MBV)) {
+		fdt_blob = (void *)CONFIG_XILINX_OF_BOARD_DTB_ADDR;
+
+		if (fdt_magic(fdt_blob) == FDT_MAGIC)
+			return fdt_blob;
+	}
+
 	if (!IS_ENABLED(CONFIG_SPL_BUILD) &&
 	    !IS_ENABLED(CONFIG_VERSAL_NO_DDR) &&
 	    !IS_ENABLED(CONFIG_ZYNQMP_NO_DDR)) {
diff --git a/board/xilinx/mbv/Kconfig b/board/xilinx/mbv/Kconfig
index 553c2320697d..9d5ee65cea6f 100644
--- a/board/xilinx/mbv/Kconfig
+++ b/board/xilinx/mbv/Kconfig
@@ -15,12 +15,23 @@ config SYS_CONFIG_NAME
 config TEXT_BASE
 	default 0x21200000
 
+config SPL_TEXT_BASE
+	default 0x20000000
+
+config SPL_OPENSBI_LOAD_ADDR
+	hex
+	default 0x20200000
+
 config BOARD_SPECIFIC_OPTIONS
 	def_bool y
 	select GENERIC_RISCV
+	select SUPPORT_SPL
 	imply BOARD_LATE_INIT
+	imply SPL_RAM_SUPPORT
+	imply SPL_RAM_DEVICE
 	imply CMD_SBI
 	imply CMD_PING
+	imply OF_HAS_PRIOR_STAGE
 
 source "board/xilinx/Kconfig"
 
diff --git a/board/xilinx/mbv/board.c b/board/xilinx/mbv/board.c
index ccf4395d6ace..c478f7e04a0c 100644
--- a/board/xilinx/mbv/board.c
+++ b/board/xilinx/mbv/board.c
@@ -5,7 +5,17 @@
  * Michal Simek <michal.simek@amd.com>
  */
 
+#include <spl.h>
+
 int board_init(void)
 {
 	return 0;
 }
+
+#ifdef CONFIG_SPL
+u32 spl_boot_device(void)
+{
+	/* RISC-V QEMU only supports RAM as SPL boot device */
+	return BOOT_DEVICE_RAM;
+}
+#endif
diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
index a08a12570d34..4113409efbb2 100644
--- a/configs/xilinx_mbv32_defconfig
+++ b/configs/xilinx_mbv32_defconfig
@@ -1,10 +1,13 @@
 CONFIG_RISCV=y
-CONFIG_SYS_MALLOC_LEN=0x800000
+CONFIG_SYS_MALLOC_LEN=0xe00000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20200000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x21200000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_DEFAULT_DEVICE_TREE="xilinx-mbv32"
+CONFIG_SPL_STACK=0x20200000
+CONFIG_SPL_SIZE_LIMIT=0x40000
+CONFIG_SPL=y
 CONFIG_DEBUG_UART_BASE=0x40600000
 CONFIG_DEBUG_UART_CLOCK=1000000
 CONFIG_SYS_CLK_FREQ=100000000
@@ -12,18 +15,29 @@ CONFIG_BOOT_SCRIPT_OFFSET=0x0
 CONFIG_SYS_LOAD_ADDR=0x20200000
 CONFIG_DEBUG_UART=y
 CONFIG_TARGET_XILINX_MBV=y
+# CONFIG_SPL_SMP is not set
 CONFIG_REMAKE_ELF=y
 CONFIG_FIT=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x20200000
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_DISPLAY_CPUINFO=y
 CONFIG_DISPLAY_BOARDINFO=y
 # CONFIG_BOARD_LATE_INIT is not set
+CONFIG_SPL_MAX_SIZE=0x40000
+CONFIG_SPL_BSS_START_ADDR=0x24000000
+CONFIG_SPL_BSS_MAX_SIZE=0x80000
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 # CONFIG_CMD_MII is not set
 CONFIG_CMD_TIMER=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_DM_MTD=y
 CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_DEBUG_UART_SKIP_INIT=y
 CONFIG_XILINX_UARTLITE=y
 CONFIG_XILINX_TIMER=y
+# CONFIG_BINMAN_FDT is not set
 CONFIG_PANIC_HANG=y
+CONFIG_SPL_GZIP=y
diff --git a/configs/xilinx_mbv32_smode_defconfig b/configs/xilinx_mbv32_smode_defconfig
index fd3ef931f6ca..99381478ac5c 100644
--- a/configs/xilinx_mbv32_smode_defconfig
+++ b/configs/xilinx_mbv32_smode_defconfig
@@ -1,26 +1,40 @@
 CONFIG_RISCV=y
-CONFIG_SYS_MALLOC_LEN=0x800000
+CONFIG_SYS_MALLOC_LEN=0xe00000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20200000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x21200000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_DEFAULT_DEVICE_TREE="xilinx-mbv32"
+CONFIG_SPL_STACK=0x20200000
+CONFIG_SPL_SIZE_LIMIT=0x40000
+CONFIG_SPL=y
 CONFIG_DEBUG_UART_BASE=0x40600000
 CONFIG_DEBUG_UART_CLOCK=1000000
 CONFIG_SYS_CLK_FREQ=100000000
 CONFIG_BOOT_SCRIPT_OFFSET=0x0
 CONFIG_SYS_LOAD_ADDR=0x20200000
 CONFIG_TARGET_XILINX_MBV=y
+CONFIG_SPL_OPENSBI_LOAD_ADDR=0x20100000
 CONFIG_RISCV_SMODE=y
+# CONFIG_SPL_SMP is not set
 CONFIG_REMAKE_ELF=y
 CONFIG_FIT=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x20200000
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_DISPLAY_CPUINFO=y
 CONFIG_DISPLAY_BOARDINFO=y
 # CONFIG_BOARD_LATE_INIT is not set
+CONFIG_SPL_MAX_SIZE=0x40000
+CONFIG_SPL_BSS_START_ADDR=0x24000000
+CONFIG_SPL_BSS_MAX_SIZE=0x80000
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
+CONFIG_SPL_OPENSBI_SCRATCH_OPTIONS=0x2
 # CONFIG_CMD_MII is not set
 CONFIG_CMD_TIMER=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_DM_MTD=y
 CONFIG_DEBUG_UART_UARTLITE=y
 CONFIG_DEBUG_UART_ANNOUNCE=y
@@ -28,4 +42,6 @@ CONFIG_DEBUG_UART_SKIP_INIT=y
 CONFIG_XILINX_UARTLITE=y
 # CONFIG_RISCV_TIMER is not set
 CONFIG_XILINX_TIMER=y
+# CONFIG_BINMAN_FDT is not set
 CONFIG_PANIC_HANG=y
+CONFIG_SPL_GZIP=y
-- 
2.36.1

