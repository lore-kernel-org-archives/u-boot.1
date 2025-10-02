Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2DB1CAC5B8
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 08:20:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7969283526;
	Thu,  2 Oct 2025 10:20:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MojRTQcA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BF2183544; Thu,  2 Oct 2025 10:20:11 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1446083526
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 10:20:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UFkomP/rP6AQHLLoLMxeZmd7+Aflv+Mm0ZVGtsgolYzCak80xuXZDWOB8GvE58RNwbRrla3mXdAe8mF2NCkbTFAsrLT0jDIjxu1D6rPNxNfJl3UQ+oOQE8zgZYQJWe4fyvEOTYlYf9mLhF4o8P5/+QkrLi4Udv2hknpPH68uaE+0XtqBqJTaYwJGimaE3IFnsNFxShWD9xfhmJEkdMkY5N4+0FPFXpIMvpeHnM1fmmMXBD64ObDg72wW2jafV4l2W/aPHa/seiKsHUC3ZsLb6bP6klKd7bVxjyO1c+5CmcPrP5tFDbVZZLHEKGf4hAEbloX5ByrkZ8LNc/pVpKe6ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6HOlInW3+udycJqFSymK4ViLrfHO0VTbVq75sPFyZo=;
 b=cJZYmyHWSV5NBzCx5MHvcGxNID8gKABsLhbOdyhA1DZVf4KMK+8gJTwZgj+VE0oUj0EUniiunQ7rH0Jk0oICJqlZpJ2EvDb6pps3mYDiSPV9Bs0yAEJP7XS6AXOYebDl00K0MLBmcR8bKe9RSZOgcvWxL9PZd2sa7rwvjBCf43qyzMewnF6A2Fu0nVRNlO7jzXdnYQz1LeegylWrmRZghsQh2AeXu/hTElZsNBdOuceW8FBNuQQG3/KgtSkdT4LllTqaMCxJA+opa1dFcdtvncg/Rr0Yf/ZZ8gNrZ7NyRd1mO/mlkFxC6gAz7BrLm5R7SjzraHVPYiw1ktEcHIonpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6HOlInW3+udycJqFSymK4ViLrfHO0VTbVq75sPFyZo=;
 b=MojRTQcAAqea6rbaJavr1trEJZKC7wxN08qEz0ErzoHVGNfzYp2YSHex+8mF30Eg8huzhQwQIOIMxQZvvUfh0szyDp8h/kR9l/R+qpKwdjq+DdMjeLlth2BG8A3qd9YpeoEwPEOhePB0ezoHhgjFBAp4zomLVk2Nwd65/Bd2Gvg=
Received: from SA9PR13CA0073.namprd13.prod.outlook.com (2603:10b6:806:23::18)
 by DM4PR12MB6661.namprd12.prod.outlook.com (2603:10b6:8:b7::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.17; Thu, 2 Oct 2025 08:19:56 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:23:cafe::12) by SA9PR13CA0073.outlook.office365.com
 (2603:10b6:806:23::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.5 via Frontend Transport; Thu, 2
 Oct 2025 08:19:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 2 Oct 2025 08:19:54 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 2 Oct
 2025 01:19:53 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 2 Oct
 2025 03:19:51 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 2 Oct 2025 01:19:51 -0700
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Padmarao Begari <padmarao.begari@amd.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Leo Yu-Chi Liang <ycliang@andestech.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Martin Herren <sputnik@on-the-web.ch>,
 Peng Fan <peng.fan@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/2] xilinx: mbv: Remove redundancy in MB-V defconfigs
Date: Thu, 2 Oct 2025 10:19:38 +0200
Message-ID: <585f96d85b656803bd382ac25425d68998f24ed5.1759393175.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6188; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=JCjTw76218Ssj+B1ZX0ETUsqHewoMhpLYswA27kGZJE=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTcM53t7jFf+/E5niNizrds9nV0r9VluzY57P7pj2EKe
 veXcmjd7ChlYRDjYJAVU2SZzqTjsObbtaViyyPzYeawMoEMYeDiFICLpDMytP5+fcd///+A6uyH
 Wryh4kVeFySrJocdYL3ZG8Hbcn3XcUaGJQpPmX+3NPc83yST72913aZomn/Hw6DWnVxxl7VXt+k
 yAAA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|DM4PR12MB6661:EE_
X-MS-Office365-Filtering-Correlation-Id: 161fb538-9703-47ef-edc0-08de018c7786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ye+BWJOf4YZ738Zc10k3ISJF3bGLFpR9DO0I1fIfd+Qio/D6ZlOKxfXKNStf?=
 =?us-ascii?Q?yjsYZVJXPSVKLXtI2+aT1zyx7SXtUg9dBMg9E4yEEZ4D0WZu0A14kJdvRKJq?=
 =?us-ascii?Q?8OlHJ+ubJV880PHXQqMaModkI63An8S0Es1hkD1fAKIweUACe0FZ5/3Ifjig?=
 =?us-ascii?Q?dJfaPSlHjH/wzrIvJEdaMLiNBAtGNGc3QNrhfNvXqFK+N516jPqEPPROEbsA?=
 =?us-ascii?Q?poJYgBHtNqIKSuTjazh3VjOFXXceADdIrzixW649K1dUSlGFdaqn5gZMkvDF?=
 =?us-ascii?Q?O0qk8kHh1kXOAnW+OcoUQatnMnkdbnsXCZaljBKu0RE53wsOChOSynYFmQPZ?=
 =?us-ascii?Q?ZrJnbEi75DlsmjFTO9tzki5qRbcB39tm3KTrsUgPlTsjp0YyVD2NapbwzwpJ?=
 =?us-ascii?Q?inOUN4KU7h9xnjQB1PUl+8Pkhl4VGiyuvkrAynxA1YUeI52cPH7LISrgD7Jf?=
 =?us-ascii?Q?wRYPXGzf5382duY3VlsFPnhvObbbbLzSAk8sAd/SaQRRoMosvUsyfsrU0fiH?=
 =?us-ascii?Q?3WTUBGqzjb7LHN+U3uLbOYT1lrg3fUJBesptJ+NH8U307W9m3nTol0Dw+fPk?=
 =?us-ascii?Q?orkZWF8BLhQQIpUiQXivMU+MN2cWQA2ZfLDlqYB52v2X7KrS2hHK1nZ5cpqq?=
 =?us-ascii?Q?0gNGVCVT3HRpBzqKZm3fPOqcihJmEBagWV1pMb5EdbpLsZ70gEjLvZUHutyn?=
 =?us-ascii?Q?vmjDoVh7zQ4oVvfEb6OGbJ17DbKDg94oeNzo6sCTwMKRrmTSODxa8dboncM8?=
 =?us-ascii?Q?Z0MVZCV4yz/ojeUhEVjR3EFR/39i2ee5v0MO3+Vu07nmjLpNuB4gznIisBHu?=
 =?us-ascii?Q?u6clx/ZZYFZmG7JiKRS8cCgkZbR3D46FG9aaEDWNbKoiklndLBc+3K5LS4GI?=
 =?us-ascii?Q?dxsxPhnMCDFq0mFzZr1yV6cYm/cypD2Vy1RZwDoBjvfh34Fsev85GGr25ZfT?=
 =?us-ascii?Q?5NEDbuedU2Yw1GAUAHPpQ24lQ4ntWx1/YDkrh88j5mWfgaINkH8hDXuLrgu+?=
 =?us-ascii?Q?LRojivjIqk4NgfBBDZEcj/MTfrHCJyWH779jlLOFiIApQSm/NAqL8dLhHCKd?=
 =?us-ascii?Q?5YFBZKxiohCm/W7qZOJvncq6rSc2xyeb+vrd842ydI6eeNZeALjn3AjvBjUc?=
 =?us-ascii?Q?20Z8KRSdVV37MHXFTVOkMAKnOw2W9IRrPpTZ/KqGs07AVWh8EZrG7S/6Orvj?=
 =?us-ascii?Q?/+VEH8QBFpbCHtmK/Or0X9XjT0mRFzfMCW3iC0aMuCljylHBoX6D8bJPU0yy?=
 =?us-ascii?Q?2g+uzPfv901VLMa3ryHi45cJNK2WR6silhMmJJjIKGjBp5MxuDiqKLexoVLt?=
 =?us-ascii?Q?Wa/Qd/GS8JK6OZYw8wq8Z4HYFQmdDPQa8bIi4yR/NH1IH/a3Xm56jM4ITjtk?=
 =?us-ascii?Q?RLhfau9xhmMkXeHtBjK40LSMQcISTCr5LIy1uZgBuZsNcsdCelpH1oHOkXK4?=
 =?us-ascii?Q?V4UrAjaENNVsN8GU7/jNVL1Nby7bBwtXUKUFKqsZe0y4vilwJPv2C9Jwaky8?=
 =?us-ascii?Q?5pVquhO0kBxVoRQs1MEtx6J2pui6wy3Png8CvKXoRxpQD42R8p60zPW5cAxx?=
 =?us-ascii?Q?m/yeEpjU2Yha1VaiXYA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 08:19:54.4906 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 161fb538-9703-47ef-edc0-08de018c7786
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6661
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

From: Padmarao Begari <padmarao.begari@amd.com>

Removes redundant configuration options from MB-V platform defconfigs
targeting both modes. Common settings are now placed in
xilinx_mbv32_defconfig, which is included via the #include <configs/...>.
This approach centralizes configuration management, reduces duplication,
and makes future maintenance easier.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- new patch in series

 configs/xilinx_mbv32_smode_defconfig | 49 ++-------------------------
 configs/xilinx_mbv64_defconfig       | 47 ++------------------------
 configs/xilinx_mbv64_smode_defconfig | 50 ++--------------------------
 3 files changed, 6 insertions(+), 140 deletions(-)

diff --git a/configs/xilinx_mbv32_smode_defconfig b/configs/xilinx_mbv32_smode_defconfig
index c95b44973952..dd1221a6904f 100644
--- a/configs/xilinx_mbv32_smode_defconfig
+++ b/configs/xilinx_mbv32_smode_defconfig
@@ -1,50 +1,5 @@
-CONFIG_RISCV=y
-CONFIG_SYS_MALLOC_LEN=0xe00000
-CONFIG_NR_DRAM_BANKS=1
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x81200000
-CONFIG_ENV_SIZE=0x20000
-CONFIG_DEFAULT_DEVICE_TREE="xilinx-mbv32"
-CONFIG_SPL_STACK=0x80200000
-CONFIG_SPL_BSS_START_ADDR=0x84000000
-CONFIG_SPL_BSS_MAX_SIZE=0x80000
-CONFIG_SYS_BOOTM_LEN=0x800000
-CONFIG_SYS_LOAD_ADDR=0x80200000
-CONFIG_SPL_SIZE_LIMIT=0x40000
-CONFIG_SPL=y
-CONFIG_DEBUG_UART_BASE=0x40600000
-CONFIG_DEBUG_UART_CLOCK=1000000
-CONFIG_SYS_CLK_FREQ=100000000
-CONFIG_BOOT_SCRIPT_OFFSET=0x0
-CONFIG_TARGET_XILINX_MBV=y
+#include <configs/xilinx_mbv32_defconfig>
+
 CONFIG_SPL_OPENSBI_LOAD_ADDR=0x80100000
 CONFIG_RISCV_SMODE=y
-# CONFIG_SPL_SMP is not set
-CONFIG_REMAKE_ELF=y
-CONFIG_FIT=y
-CONFIG_SPL_LOAD_FIT_ADDRESS=0x80200000
-CONFIG_DISTRO_DEFAULTS=y
-CONFIG_DISPLAY_CPUINFO=y
-CONFIG_DISPLAY_BOARDINFO=y
-# CONFIG_BOARD_INIT is not set
-# CONFIG_BOARD_LATE_INIT is not set
-CONFIG_SPL_MAX_SIZE=0x40000
-# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SPL_HAVE_INIT_STACK=y
-CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_OPENSBI_SCRATCH_OPTIONS=0x2
-# CONFIG_CMD_MII is not set
-CONFIG_CMD_TIMER=y
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SPL_DM_SEQ_ALIAS=y
-CONFIG_DM_MTD=y
-CONFIG_DEBUG_UART_UARTLITE=y
-CONFIG_DEBUG_UART_ANNOUNCE=y
-CONFIG_DEBUG_UART_SKIP_INIT=y
-CONFIG_XILINX_UARTLITE=y
-# CONFIG_RISCV_TIMER is not set
-CONFIG_XILINX_TIMER=y
-# CONFIG_BINMAN_FDT is not set
-CONFIG_BINMAN_DTB="./arch/riscv/dts/xilinx-binman.dtb"
-CONFIG_PANIC_HANG=y
-CONFIG_SPL_GZIP=y
diff --git a/configs/xilinx_mbv64_defconfig b/configs/xilinx_mbv64_defconfig
index a3cc1a5669e5..27d674fc34fb 100644
--- a/configs/xilinx_mbv64_defconfig
+++ b/configs/xilinx_mbv64_defconfig
@@ -1,47 +1,4 @@
-CONFIG_RISCV=y
-CONFIG_SYS_MALLOC_LEN=0xe00000
-CONFIG_NR_DRAM_BANKS=1
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x81200000
-CONFIG_ENV_SIZE=0x20000
+#include <configs/xilinx_mbv32_defconfig>
+
 CONFIG_DEFAULT_DEVICE_TREE="xilinx-mbv64"
-CONFIG_SPL_STACK=0x80200000
-CONFIG_SPL_BSS_START_ADDR=0x84000000
-CONFIG_SPL_BSS_MAX_SIZE=0x80000
-CONFIG_SYS_BOOTM_LEN=0x800000
-CONFIG_SYS_LOAD_ADDR=0x80200000
-CONFIG_SPL_SIZE_LIMIT=0x40000
-CONFIG_SPL=y
-CONFIG_DEBUG_UART_BASE=0x40600000
-CONFIG_DEBUG_UART_CLOCK=100000000
-CONFIG_SYS_CLK_FREQ=100000000
-CONFIG_BOOT_SCRIPT_OFFSET=0x0
-CONFIG_DEBUG_UART=y
-CONFIG_TARGET_XILINX_MBV=y
 CONFIG_ARCH_RV64I=y
-# CONFIG_SPL_SMP is not set
-CONFIG_REMAKE_ELF=y
-CONFIG_FIT=y
-CONFIG_SPL_LOAD_FIT_ADDRESS=0x80200000
-CONFIG_DISTRO_DEFAULTS=y
-CONFIG_DISPLAY_CPUINFO=y
-CONFIG_DISPLAY_BOARDINFO=y
-# CONFIG_BOARD_INIT is not set
-# CONFIG_BOARD_LATE_INIT is not set
-CONFIG_SPL_MAX_SIZE=0x40000
-# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SPL_HAVE_INIT_STACK=y
-CONFIG_SPL_SYS_MALLOC=y
-# CONFIG_CMD_MII is not set
-CONFIG_CMD_TIMER=y
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SPL_DM_SEQ_ALIAS=y
-CONFIG_DM_MTD=y
-CONFIG_DEBUG_UART_ANNOUNCE=y
-CONFIG_DEBUG_UART_SKIP_INIT=y
-CONFIG_XILINX_UARTLITE=y
-CONFIG_XILINX_TIMER=y
-# CONFIG_BINMAN_FDT is not set
-CONFIG_BINMAN_DTB="./arch/riscv/dts/xilinx-binman.dtb"
-CONFIG_PANIC_HANG=y
-CONFIG_SPL_GZIP=y
diff --git a/configs/xilinx_mbv64_smode_defconfig b/configs/xilinx_mbv64_smode_defconfig
index 3d49670c60c4..56bf0bdc7e4f 100644
--- a/configs/xilinx_mbv64_smode_defconfig
+++ b/configs/xilinx_mbv64_smode_defconfig
@@ -1,51 +1,5 @@
-CONFIG_RISCV=y
-CONFIG_SYS_MALLOC_LEN=0xe00000
-CONFIG_NR_DRAM_BANKS=1
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x81200000
-CONFIG_ENV_SIZE=0x20000
-CONFIG_DEFAULT_DEVICE_TREE="xilinx-mbv64"
-CONFIG_SPL_STACK=0x80200000
-CONFIG_SPL_BSS_START_ADDR=0x84000000
-CONFIG_SPL_BSS_MAX_SIZE=0x80000
-CONFIG_SYS_BOOTM_LEN=0x800000
-CONFIG_SYS_LOAD_ADDR=0x80200000
-CONFIG_SPL_SIZE_LIMIT=0x40000
-CONFIG_SPL=y
-CONFIG_DEBUG_UART_BASE=0x40600000
-CONFIG_DEBUG_UART_CLOCK=1000000
-CONFIG_SYS_CLK_FREQ=100000000
-CONFIG_BOOT_SCRIPT_OFFSET=0x0
-CONFIG_TARGET_XILINX_MBV=y
+#include <configs/xilinx_mbv64_defconfig>
+
 CONFIG_SPL_OPENSBI_LOAD_ADDR=0x80100000
-CONFIG_ARCH_RV64I=y
 CONFIG_RISCV_SMODE=y
-# CONFIG_SPL_SMP is not set
-CONFIG_REMAKE_ELF=y
-CONFIG_FIT=y
-CONFIG_SPL_LOAD_FIT_ADDRESS=0x80200000
-CONFIG_DISTRO_DEFAULTS=y
-CONFIG_DISPLAY_CPUINFO=y
-CONFIG_DISPLAY_BOARDINFO=y
-# CONFIG_BOARD_INIT is not set
-# CONFIG_BOARD_LATE_INIT is not set
-CONFIG_SPL_MAX_SIZE=0x40000
-# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SPL_HAVE_INIT_STACK=y
-CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_OPENSBI_SCRATCH_OPTIONS=0x2
-# CONFIG_CMD_MII is not set
-CONFIG_CMD_TIMER=y
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SPL_DM_SEQ_ALIAS=y
-CONFIG_DM_MTD=y
-CONFIG_DEBUG_UART_UARTLITE=y
-CONFIG_DEBUG_UART_ANNOUNCE=y
-CONFIG_DEBUG_UART_SKIP_INIT=y
-CONFIG_XILINX_UARTLITE=y
-# CONFIG_RISCV_TIMER is not set
-CONFIG_XILINX_TIMER=y
-# CONFIG_BINMAN_FDT is not set
-CONFIG_BINMAN_DTB="./arch/riscv/dts/xilinx-binman.dtb"
-CONFIG_PANIC_HANG=y
-CONFIG_SPL_GZIP=y
-- 
2.43.0

base-commit: b8889ad5d3a625505dca9ac9f0a164e7587baabd
