Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD63D3B7F3
	for <u-boot@archiver.kernel.org>; Mon,  8 Dec 2025 15:04:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 647518313B;
	Mon,  8 Dec 2025 16:04:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i8Rbn0kJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DDA98392C; Mon,  8 Dec 2025 16:04:09 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9362E830E4
 for <u-boot@lists.denx.de>; Mon,  8 Dec 2025 16:04:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zx++me3K/qAgJ5tmSIYz+vK9cfHHYyFztguPfw3JKFW7pUzZzPG+sPcvu10EY4yjetbFqBoGhpTkGx5euCg9G/q0VocTfcFwh4fR9ihJWXuXNr2xfbZAPmKMMT52hY3ZdFRS1eqhqyva86IU06BwulQ9DoVI0gJ7w2Rbyshq0zT6eGSBmVL5Vqvr+RMbCE+epIiS5+RVIhrBs65XpYRbngBQbQJshh8+0Nf6QfP66LyMzCOLbnDGhBpf2taGHYPVa9EaF67xifv/xgoTJUe2Z+l1tID69jeFTex0Cs3KE2VGTtTFDByXzGgzI90Hw4e1MwS4A1LyRihUtwKX+PcO+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ekiBWmzewgRwuHBwyfiFH+knhlB/jbZa8ApPuHvVPo=;
 b=bakAVlSt8ILwL4IOip3h8NwjYI0gNT1syBAHlpFaaOYWYYq7MsB4x+aWvOw8OTAAv+mWAf1C54+MZHwDvXnz4tbPIkMotEsehH0q/luCtKCrHnucFOWfchrFPLyfytoVVDou1zWhy1WAO+5zIRUL3ulDnJUtMGSL2PJVZqFZlkgFgAY3fyCqOsSl0VlJNehwrGd5aUKrcReBxJh/93jzsQRvRLehwfs0ycIMiwSkWs7yxB0EOPE6KP9jMTJr96/Zv1Lp//n/FjsCJbJaTtEIYocgjCY54Sa+zstc/gWMerPOnD4casr+y4dazXo5imywk4gYDTvDnNS5tnSa7xk9XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ekiBWmzewgRwuHBwyfiFH+knhlB/jbZa8ApPuHvVPo=;
 b=i8Rbn0kJd7ZxThD/LibzV84TFVRiT8T3Q+H+7wRzohyk4zk9PSOw9HIk46zF/lBy5ZQ6ET2Dp+gvp+SFlcuKhGi9CP37YxUi7rxBKV/sV5yP5UgC0j56CWe9wjThjdWfqpqzTH3YLc90w28XDEgc0ou6B3FpV7OQfwvwGgjuSsc=
Received: from SJ0PR05CA0116.namprd05.prod.outlook.com (2603:10b6:a03:334::31)
 by MN2PR12MB4341.namprd12.prod.outlook.com (2603:10b6:208:262::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 15:04:00 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::38) by SJ0PR05CA0116.outlook.office365.com
 (2603:10b6:a03:334::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Mon, 8
 Dec 2025 15:03:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Mon, 8 Dec 2025 15:03:58 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 8 Dec
 2025 09:03:52 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 8 Dec
 2025 09:03:51 -0600
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 8 Dec 2025 07:03:50 -0800
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Padmarao Begari <padmarao.begari@amd.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Leo Yu-Chi Liang <ycliang@andestech.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Martin Herren <sputnik@on-the-web.ch>,
 Peng Fan <peng.fan@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] xilinx: mbv: Update defconfigs as per memory map
Date: Mon, 8 Dec 2025 16:03:34 +0100
Message-ID: <ed4a3618875869287b87b6b57fd55f4c6a36f046.1765206211.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2966; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=hJL/3FAYiOQ4jKiLJdZM0ZChlq2+2qM2W9IxDeRgNXY=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSavTj3U/b++ZWTK5fq3Fq3jKPnQpDFAp/EjIS9rNafN
 25nSH3O01HKwiDGwSArpsgynUnHYc23a0vFlkfmw8xhZQIZwsDFKQAT2XyX4X9SL5+5wUmNzScC
 nyZ2/GXanBoab2Hw0ZzPlrVx0//2H+aMDD0XWDfMXqnjnHk/9Irh7yuC/x8bXs5teu6tcbxmua+
 /Gi8A
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|MN2PR12MB4341:EE_
X-MS-Office365-Filtering-Correlation-Id: a4e5f829-28c3-4db7-4e76-08de366b0393
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KQD/kczFPGY9ZGwCLnpoQ4UmiNXfe1aL616s0udjNGnh70WGszDC49KQq3cp?=
 =?us-ascii?Q?uqVCpNR8hEEE6wsv/qhxQu2JLpE3VPhQN60yfcusQAqyKf3Sbuw1AWuXYS9m?=
 =?us-ascii?Q?e2zSP+Qu9DIEZ996JSg2fFznovivx5XF8gT+YsuPb7oK8xBIRAKrJAiTK/dv?=
 =?us-ascii?Q?VMJ+Bb83DwVARm8tpjDB6rfdc8z8IchkmJ1cDPiPMCahwvFB5/h1j0hi91Kk?=
 =?us-ascii?Q?0QcTcetDoA+BzDK83F+TGXOzZqj2r+aChXKrMuzT5ngd5g/2sGLqEpAIgMfj?=
 =?us-ascii?Q?OfglWd+b0pyRzfK83Fxjx9f5xhK9gYmrUSAPHHAB/UPH+WqQLfLS5ih/kHxp?=
 =?us-ascii?Q?VPXl3weQzw/XBJFvN+ZqkiiTH38F37ffviRYW4Voe0Ec8JoNqR1zB20GL8XK?=
 =?us-ascii?Q?pg9ayv3lwZl3U/SCZ9hWmAx/1lIzEG+mFuyG+8Djpi2NV3tXMs6YyLcn1DdF?=
 =?us-ascii?Q?bro+g8XlxtXFPJvAJAwOo0Cxclp0JIZpCHaszOLRKnJPT06knqjP0y0BQsiW?=
 =?us-ascii?Q?AoBc2RWCxpc5DMOBKSzPwcSsqumHiNFZLnnAym8IhBZYm4j9o2AwHLTnfNHW?=
 =?us-ascii?Q?Ea+6JWvY1JCjSp6kN+XOLyLK9tSqvkdusTKSYw8MCXftykk3EL1b02fv3hPQ?=
 =?us-ascii?Q?aU0bZ4jzWznnTyacqLeMtkftJV4naivwKpuVpQSQCv5SVwZeZLdkxMHXRYEe?=
 =?us-ascii?Q?TuuLJxGG7SI36OtDykZ3jmTLgcKAfQRvygueXzbEHHzC0R0KK2I4G3aJGY7U?=
 =?us-ascii?Q?N8jMWjL5S0VOelT/e5sXnjAslwV6tzeiVUTQf/My2QsKPLXx5jcu5sq7VAL+?=
 =?us-ascii?Q?gB+1jdcIiBM+sK/sosFUCUpMtPyL0jTdvsW6TQ85LkZL+IANUz5+QD88Lije?=
 =?us-ascii?Q?6nCPwYGttLHtaL6osyV+Do5gRzI10NSN9DSvSyr2J2tZ7xxx2ASbBLLlRB9j?=
 =?us-ascii?Q?4gqh+UHZpWDVupub1Y+BIS3kNiGDZLnzCnj43filPW9AoC1egtXRBvYWxv1d?=
 =?us-ascii?Q?DuhcfAKMUIoLwKnAVvTFymOF3CHQgiJzc9nBzcEBEUKQqBT0c1qbTqfhJf5Y?=
 =?us-ascii?Q?MyjGCXd+OnNjtbKSixBvMxaefnWj0ZBwbOPeYmpKqcHaGFX52zll9yG9By1G?=
 =?us-ascii?Q?R8iXR3++MvwYJoQs2Q/LDgio+uqHSkEafi9KB+Bv8Nu6EYfnsAhfEO1WoODe?=
 =?us-ascii?Q?EFRfPhkbKE539rGmvllIcJZJZTHfiF5FraiB6LmDTqfqFFYg8MnBqYKrah6W?=
 =?us-ascii?Q?4OTbwOZVSMqZBRJXeqHPlgfqIz5y+g+ncEMQ2bIPPtq1H0dNQKXKPSq7SdSj?=
 =?us-ascii?Q?vl+O2Dvxb0btGDIeQhhQx7jKCQ/qZKg9dGqKLwulbTens9HI2E8xhxj2W8gZ?=
 =?us-ascii?Q?ZupeB2CCospqdjnJhlguJGvmPh7UnKRFg963ukdN5O01D8Blp/dGzTtub3RM?=
 =?us-ascii?Q?Ck0UTsgNPseH7ksLKKN9GZ/zhhtTS1AGENtA6fceoVmI1kOwCvmnAywAujzk?=
 =?us-ascii?Q?knydqYNf5aok4VopU/9M2/HIzG7baIBhG3Mxp8zi6A099pC1QG74XhQEeehL?=
 =?us-ascii?Q?VhQfDvitWqnPA4yFwXg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 15:03:58.1210 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e5f829-28c3-4db7-4e76-08de366b0393
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4341
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

U-Boot SPL should be executed from LMB BRAM, where its text
and data sections are located, while the heap and stack are
allocated in DDR memory.

Because on the MB-V platform, after power-up, reset, or FPGA
load, execution begins from LMB BRAM at address 0x0. Therefore,
the SPL binary must be placed in BRAM to support this boot flow.
Without it, the system can only be booted via JTAG.

A 64KB LMB BRAM region is allocated for U-Boot SPL, starting at
address 0x0. This region contains the SPL's text, data, and device
tree blob (DTB) sections. The .bss section is placed separately at
address 0xF000.

	_________________0xFFFF
	|BSS            |
	|_______________|0xF000
	|DTB            |
	|_______________|
	|Data           |
	|_______________|
	|Text           |
	|_______________|0x0000

A 2MB region of DDR memory is allocated for U-Boot SPL, with the
heap starting at address 0x80000000 and the stack at 0x80200000.

	_________________0xBFFFFFFF
	|Full U-Boot    |
	|_______________|0x80400000
	|Load FIT Image |
	|_______________|0x80200000
	|Stack          |
	|_______________|
	|Heap           |
	|_______________|0x80000000

Since LMB BRAM is a limited resource with a practical size
constraint of 64KB - it cannot accommodate all runtime data.
Therefore, the heap and stack are placed at the beginning of
DDR memory to ensure sufficient space for SPL execution.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/xilinx_mbv32_defconfig | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
index 9e3c44352a15..42dc5fb282ad 100644
--- a/configs/xilinx_mbv32_defconfig
+++ b/configs/xilinx_mbv32_defconfig
@@ -6,11 +6,12 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x81200000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_DEFAULT_DEVICE_TREE="xilinx-mbv32"
 CONFIG_SPL_STACK=0x80200000
-CONFIG_SPL_BSS_START_ADDR=0x84000000
-CONFIG_SPL_BSS_MAX_SIZE=0x80000
+CONFIG_SPL_TEXT_BASE=0x0
+CONFIG_SPL_BSS_START_ADDR=0xf000
+CONFIG_SPL_BSS_MAX_SIZE=0x1000
 CONFIG_SYS_BOOTM_LEN=0x800000
 CONFIG_SYS_LOAD_ADDR=0x80200000
-CONFIG_SPL_SIZE_LIMIT=0x40000
+CONFIG_SPL_SIZE_LIMIT=0x10000
 CONFIG_SPL=y
 CONFIG_SYS_CLK_FREQ=100000000
 CONFIG_BOOT_SCRIPT_OFFSET=0x0
@@ -25,10 +26,13 @@ CONFIG_DISPLAY_CPUINFO=y
 CONFIG_DISPLAY_BOARDINFO=y
 # CONFIG_BOARD_INIT is not set
 # CONFIG_BOARD_LATE_INIT is not set
-CONFIG_SPL_MAX_SIZE=0x40000
+CONFIG_SPL_MAX_SIZE=0xf000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80000000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x200000
 # CONFIG_CMD_MII is not set
 CONFIG_CMD_SNTP=y
 CONFIG_CMD_TIMER=y
-- 
2.43.0

base-commit: 6cf68b9fba56781b3a7b1c2976aec4d2c71bebc1
branch: debian-sent3
