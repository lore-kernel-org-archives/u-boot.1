Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F01C48BC1
	for <u-boot@archiver.kernel.org>; Wed, 14 Feb 2024 11:53:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E239187E01;
	Wed, 14 Feb 2024 12:52:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="USKxjbD5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B9F587E0B; Wed, 14 Feb 2024 12:52:51 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0301787DF5
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 12:52:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIt0qjDU/TExls0piNtpOGh+9uoGfLsZdHXOM1DxH+77/Xgch6b3SLkfHgAo/3/hgoP84Jpv5cPU9gzC0JVY027EeyPqE7sdf4q5o4uXQ4627l6n+coGyZGE7erutJrnayAHCvEpcZMLukXA0I6iGXEjgwKYc5HzQc3SZQGssCDyxRkBPqxlse4ELJyt4IDwynEPzonTeiKUyQhfsy6FNC3iC/sBpgMoWyeyJqud+PSfMxLjnp1e5w0NZ9TYN5n1lIIC1M5Dl9VjTXyFGRsnddHvADQzC4LeW9vgCzn/nd2xu8g6WMArG/sckhMneerCYfF67/400gcFt696/XhN1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oFi8mguXAz7AF0SmtQ/r4EKTAtnrdGR3w4D+tyyF5rc=;
 b=dYVW7qcJFKdUpYHH/hVvduEWIunZdm8YGv4GvknuTHfXcBiWlGwI4YsxPzHN/GBX4DzI95dzrCr3kfIrBTiGUARRv+5zSv/TGa2eUSd29Ov4lmmZDbOULrtAZN+vTuFt0x7xg06q+ARyU+Vz6YMyDSdx9V1lHhH5/QAk6AFzYgm+91afjtRjwJuDZ0cViJLQtW+selhfFBeU5GTpqS34YBTJvSrtNe37VVUgCeq602gAzm484eD8benER9/+lMg0ETpYBkvYS5OY7MiH1FISs4WXubRB/aZD/YthNmhScjwirA99jRNsyUanPCF79XSpJBqjZCY3GwjPjMeHEuzUwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oFi8mguXAz7AF0SmtQ/r4EKTAtnrdGR3w4D+tyyF5rc=;
 b=USKxjbD5ssCT8lW+OarrQlaz8yKRKSuxoHbcq2bUUoMPrAZTaiBuTkDTOUJAWmuT+x+RSs7jMg/pN4eq7RtKgHyZmW+8/l970ycuA2RIOgh9V+oU6gnTgACfHPNEdPhALKh1JMY24mCRU9F16kAPua5QGfVQGDd+6pFEl4dfTuc=
Received: from BN9PR03CA0302.namprd03.prod.outlook.com (2603:10b6:408:112::7)
 by PH7PR12MB6611.namprd12.prod.outlook.com (2603:10b6:510:211::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Wed, 14 Feb
 2024 11:52:42 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:112:cafe::69) by BN9PR03CA0302.outlook.office365.com
 (2603:10b6:408:112::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Wed, 14 Feb 2024 11:52:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 11:52:41 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 05:52:39 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Leo Yu-Chi Liang <ycliang@andestech.com>, Padmarao Begari
 <padmarao.begari@microchip.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/5] riscv: mbv: Align addresses with default DT
Date: Wed, 14 Feb 2024 12:52:29 +0100
Message-ID: <be54c668d5626ccd702507a86c2a95d1eaefc690.1707911544.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1707911544.git.michal.simek@amd.com>
References: <cover.1707911544.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2155; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=/9d8ghSDYMfADDkbsmu03AaELdNtbpVo98cvgiPViE4=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtQzK+vOn4ruus1tomdw/osu9z+NqCePI4TmdjVumhqvE
 TM7QcCmI5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAEzE/BzDgkaPoxL5OfetV+Sp
 Nbzs2qAgdKhtJsNceanDCayWxzjv6FyYohLk8Vh3PpcRAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|PH7PR12MB6611:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b577824-34b1-410b-194e-08dc2d5372f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RwEwsVsCHRrJ2Sv2zDbkXdVZwYo/5T3knIvrPM81jDsxrRbjtkd+NNyK+kQ1EEX10X6tV9IMyCftF5G14Zbqhuyc6+VgpOdOdjkxFvvwuC6bcjj7bBGCV0eWFeRjLcqGfyYu0CiD5yF7rYnsgIFG8YcVhCoHP1RyJswFWP29joeBqzAYmBWLBJrdWxW+bSDPtg4vnXo1E1nUntiXObMIfQ/PEhlPt4OnMz68+Y6rE8WB4gkhj1iIbfi10Z7q6lvzGxzP6Qtysw24sU5UkVYUt/caUUxV5qrnY0SaJXxE4wrT9KIPyAUxV1IqPwLtwn9YPRlZD2tVcF+h+Cm4mKbXVZYBYHCEG9YjrzoD25M8qUz7G/7CGDpENbGpGjOtF9y+42tq/9aj6XRnohj4D5X2fz6X9pQeSr4UZg14erJthlaK72cBj22YH9noltcoe7djxUDoZgwoqkn1HAXj6XT6RUVwd2dR16z4Egx0VAW6PgqSbbIUnGkH/1sHD5wO3zKm3EfjJ+MhboRrPAtnUEcIfpC6jfqQc4+Vs+ztxn16EtnxzlmAypO30l5wwCd5Zy2An4k9jtIQRlAZuxIlEwm9njUyfAGBiTDyRBE/hLtUrzM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(82310400011)(186009)(451199024)(64100799003)(1800799012)(46966006)(36840700001)(40470700004)(2906002)(4326008)(44832011)(8936002)(8676002)(5660300002)(336012)(426003)(2616005)(83380400001)(16526019)(26005)(82740400003)(36756003)(356005)(81166007)(86362001)(6666004)(54906003)(110136005)(70586007)(316002)(70206006)(478600001)(41300700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 11:52:41.3368 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b577824-34b1-410b-194e-08dc2d5372f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6611
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

Better to align everything with memory map described in DT to avoid
mistakes. Execute both modes form the same address to make address map more
understandable.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 board/xilinx/mbv/Kconfig             | 3 +--
 configs/xilinx_mbv32_defconfig       | 3 +--
 configs/xilinx_mbv32_smode_defconfig | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/board/xilinx/mbv/Kconfig b/board/xilinx/mbv/Kconfig
index 4bc9f72c541b..553c2320697d 100644
--- a/board/xilinx/mbv/Kconfig
+++ b/board/xilinx/mbv/Kconfig
@@ -13,8 +13,7 @@ config SYS_CONFIG_NAME
 	default "xilinx_mbv"
 
 config TEXT_BASE
-	default 0x80000000 if !RISCV_SMODE
-	default 0x80400000 if RISCV_SMODE && ARCH_RV32I
+	default 0x21200000
 
 config BOARD_SPECIFIC_OPTIONS
 	def_bool y
diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
index 2689495057b0..912355f42911 100644
--- a/configs/xilinx_mbv32_defconfig
+++ b/configs/xilinx_mbv32_defconfig
@@ -1,5 +1,4 @@
 CONFIG_RISCV=y
-CONFIG_TEXT_BASE=0x21200000
 CONFIG_SYS_MALLOC_LEN=0x800000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
@@ -10,7 +9,7 @@ CONFIG_DEBUG_UART_BASE=0x40600000
 CONFIG_DEBUG_UART_CLOCK=1000000
 CONFIG_SYS_CLK_FREQ=100000000
 CONFIG_BOOT_SCRIPT_OFFSET=0x0
-CONFIG_SYS_LOAD_ADDR=0x80200000
+CONFIG_SYS_LOAD_ADDR=0x20200000
 CONFIG_DEBUG_UART=y
 CONFIG_TARGET_XILINX_MBV=y
 CONFIG_FIT=y
diff --git a/configs/xilinx_mbv32_smode_defconfig b/configs/xilinx_mbv32_smode_defconfig
index c724d1bad742..3c911607a8d9 100644
--- a/configs/xilinx_mbv32_smode_defconfig
+++ b/configs/xilinx_mbv32_smode_defconfig
@@ -1,5 +1,4 @@
 CONFIG_RISCV=y
-CONFIG_TEXT_BASE=0x21200000
 CONFIG_SYS_MALLOC_LEN=0x800000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
@@ -10,7 +9,7 @@ CONFIG_DEBUG_UART_BASE=0x40600000
 CONFIG_DEBUG_UART_CLOCK=1000000
 CONFIG_SYS_CLK_FREQ=100000000
 CONFIG_BOOT_SCRIPT_OFFSET=0x0
-CONFIG_SYS_LOAD_ADDR=0x80200000
+CONFIG_SYS_LOAD_ADDR=0x20200000
 CONFIG_TARGET_XILINX_MBV=y
 CONFIG_RISCV_SMODE=y
 CONFIG_FIT=y
-- 
2.36.1

