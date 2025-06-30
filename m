Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B628DC8302F
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 12:21:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35B5381FEE;
	Mon, 30 Jun 2025 14:21:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="njan4EU8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A3C382E27; Mon, 30 Jun 2025 14:21:38 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::62e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FC0F81E13
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 14:21:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jqyBRT1CwHEMqblb6o1GQt7JakGBZfG3fSQwS4gIcBTkY8FCxTaAq0wqg53GXCWRkTiqBR2yGKx2uI066Kys8vlIsN6DhLeKmiuRGbOe/IVna22XIv64OEes+spMC3xxwq0i02OfiECeU7EfiVoO2IF0OnZIkssw7PpDT/MJf72cj3yB883RI/3sxlHzue91QxHf8K4o6RcmxqHBJXOzDic+oLzxrygvP9yTNGa+eTwrQzoeiKuhrWFGugRnApd0mMkGiWF5D79XUd9e7EVjoI/f1MpX+QRg+kATAUSjFCldBV9u2Wu7GWTKy0y5vcDj13/z4BP988jdfnteHmBMiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQrFww7vDpN4TJfsMejDPp7PW6ZzcP3nWVWA+q2bqjk=;
 b=Fv+SM8myP9Ugfq86x7VI3mydSrUzdFVUHjzD463t5AYAyGPLzr84YwKaaICnMQQmhoAM8K4ZpzaN5B4Um+ynhxgae1dsUqs9fWhq7Xkj7rn6opzy6rpyeCBcId4rR74wE/TyzuSDc1ES0NTwS0SFwOB4Qv1tvTNBQqLUD1rTtFuSilOXHtC0+YTOX2e4Lw7uW4Gvi4pe9/teYMHU+5sCZu838Yv2mjglDflyABIYXGkNXsIZXS9EjHyO7SOPuhcckyTzh+4XW16CqecDMjxXjV/7TOTHiSBrvjRKkSf/trj5pUsL9+LwHNBYaO68sVrRfOa+t0ny8GFTs+zpG+SYRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQrFww7vDpN4TJfsMejDPp7PW6ZzcP3nWVWA+q2bqjk=;
 b=njan4EU8BwCcfgWYwW3+6MGaXwBwxUbBIiU0F40pHyi69wBtaGE12m9xDJAU/3KPZ6eIBdEEPvkEpfE8kMwv3N7An8HR/lsM6O6Kz9p4oNeWlCCI37/7Ah9SBd6blb/WnYlxDqxbI8CgOugzI7zcz8ZwXPSbTCrLldMNblqBNzs=
Received: from SA0PR13CA0021.namprd13.prod.outlook.com (2603:10b6:806:130::26)
 by MN2PR12MB4469.namprd12.prod.outlook.com (2603:10b6:208:268::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Mon, 30 Jun
 2025 12:21:26 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:806:130:cafe::f0) by SA0PR13CA0021.outlook.office365.com
 (2603:10b6:806:130::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.19 via Frontend Transport; Mon,
 30 Jun 2025 12:21:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 12:21:25 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Jun
 2025 07:21:22 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Jun
 2025 07:21:20 -0500
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 30 Jun 2025 07:21:20 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>
Subject: [PATCH v2 2/2] xilinx: Disable help command for all mini
 configurations
Date: Mon, 30 Jun 2025 14:21:08 +0200
Message-ID: <885a74b7f5b28ea7850a6ebaaf879dd8b13e18c8.1751286059.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <c17f825fb8a74e1d1912a3fd09a9a880c84a8bfd.1751286059.git.michal.simek@amd.com>
References: <c17f825fb8a74e1d1912a3fd09a9a880c84a8bfd.1751286059.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11088; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=48YLmqyQB9kvIyjtuoRazaroRPZi1RKTmHJMi076jJ0=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQkNVolp0c/mMQZvMIzgGtlqE187Zv02Dixbx8tRZn/r
 cp4uFe0o5SFQYyDQVZMkWU6k47Dmm/Xlootj8yHmcPKBDKEgYtTACYylZPhr7jhFRfflL1vjJ8m
 /zpwetu3dWaShs1/33wX5j87f+8MfWmG/2nrg9OL3l/Ot/dOnLb3fcuk/LVfjJcbLVsge2r5W/1
 zndwA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|MN2PR12MB4469:EE_
X-MS-Office365-Filtering-Correlation-Id: af850876-85f5-4c72-67d1-08ddb7d0a217
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+FVqf6LOrRRb+4C8MC1Q8rvCteGoo59B1JBczpkEW6445vdposGnJ2Wr7oId?=
 =?us-ascii?Q?xrEhOJhBEqbfLMSCG6MARxSPrxQkYNTsWx8vwXuwwajVT9NWdEBost9Mn9Yg?=
 =?us-ascii?Q?856uzi+zo+4VWNIRlTGXsK5SE/eNCkn0khrUvyQAdA15ARJYCw0MinTi/BBB?=
 =?us-ascii?Q?MNidI71QGKSB5h3NxxJLCuANbiv/znbfL+fQ0zC5KAH8yitV5xxnaU8nLNjI?=
 =?us-ascii?Q?as51cFUTJ9L8kHntqJ6AfZzwGisLbRYLqKBB12sBCXgnKwUwZxh868E0EVTM?=
 =?us-ascii?Q?exc1FNSn2+jo+N1SBxfabRVc6ilW3rPk8hIBg+oyAw9vqVu/1pGfT2Zfu0Rg?=
 =?us-ascii?Q?w8ZT4lcnhbqPrHb5GCPIZ71YjF1MxVHgEUtXjB+GD+qOhIbdM6Dq3VIVfHSG?=
 =?us-ascii?Q?nHgBn9dqmrBtQYKSuEE3IOVjYfAoNPosfm2yba/9qKJR6yKERKdh+i6mGT23?=
 =?us-ascii?Q?xpaYQrhAUorB3iJTdJym/Os7Be1cHya/q1CGeBqWCBJ+M9/4oLjJg+exbHLU?=
 =?us-ascii?Q?LahevpwKdmp6TsRBXTS23Q7hKD8UQ8R72yJeenFDKFS1hkobPNByc0RxdUmi?=
 =?us-ascii?Q?f9QdeIPbUTk01wJb25W3jisqyrz6iMoZ8QIO4hRNndNeqv7DFmDfeUtdev3D?=
 =?us-ascii?Q?Wlbo5Td7gYer3XuQn9iZXZUbtnM5nnGRe6VjbSlUCbZapWZhQ16ZcvziNuL/?=
 =?us-ascii?Q?D2off9wHQSHjRVHkP3wNsXQV9fdE0Y+5A8N1CcS1vsZEQBTmuYEGcb1Ymqvp?=
 =?us-ascii?Q?no4RFPmN68JDjSXOqddBZ6aDx8w3TUQ6aMMi4WoHIDBUfsCyB2bU5YnM1j9w?=
 =?us-ascii?Q?ESUd5CXuDI7LZuZMFUip9aguIKjxxfUQcLAlNrBKS172i+zde8G6qBkm/AIQ?=
 =?us-ascii?Q?jRdEI43S7mKuV/vIcKoVFDzqjMJAyib5nz+1nnR+NrbU2IQ4fPqH964lzpYO?=
 =?us-ascii?Q?fhtISz58ghwRLAYTz8kS9CE8HIAwDgD71j6MfNakE71b80OXnJIgtI6uWh0n?=
 =?us-ascii?Q?WoVkgoMyKr6y45SbmhJYmVyGRicuokxOzxqlR8Ccg7tqf1c4kx0cF0Vlp2mV?=
 =?us-ascii?Q?a+YXPG3xMvZPUzAxMEy7O4pJE4aq+uSj3nQ9ii2albRJhAmpUxZ64ZnQNRjS?=
 =?us-ascii?Q?ShTdkgomhFDWvavaKlzeudQft4OI2njJM7ZrhNy8NWD5mkmtr95TAzN94FEs?=
 =?us-ascii?Q?y5lHNqymLJCkbsJE93ldqFOxp8YCZ45ciaWjgTjw+baXpUuGBYgXY6Fy5fZ2?=
 =?us-ascii?Q?umEUFhRxYjDBStk/IkaLeH203V7KTN18UBhgTNZ4rdFmsGAV0OBKp1b3uCBG?=
 =?us-ascii?Q?Po6L3leobTlTxgVCqMIMqu8N/PPkJd39Bsu0qlp3DPVOx61pYraWbuoAHLp8?=
 =?us-ascii?Q?8Ia/L3/XMOHd0PL7GRhDDmqOknhy9vR3j9H/SoNNOD5JRsRrmQQbQd6Dfn4c?=
 =?us-ascii?Q?oWH79ng1l+nqqw2ndseONQiFtuWnwwmErLtZ8UH//TuW45BhwB4cWW6wiIFS?=
 =?us-ascii?Q?InqPojSdoxyIp6Yqm5KmzxQxrUI0VxwY0JZG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 12:21:25.6336 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af850876-85f5-4c72-67d1-08ddb7d0a217
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4469
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

There is no reason to have help command available because none is calling
it and only make binary bigger that's why disable it.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

(no changes since v1)

 configs/amd_versal2_mini_defconfig               | 1 +
 configs/amd_versal2_mini_emmc_defconfig          | 1 +
 configs/amd_versal2_mini_ospi_defconfig          | 1 +
 configs/amd_versal2_mini_qspi_defconfig          | 1 +
 configs/xilinx_versal_mini_defconfig             | 1 +
 configs/xilinx_versal_mini_emmc0_defconfig       | 1 +
 configs/xilinx_versal_mini_emmc1_defconfig       | 1 +
 configs/xilinx_versal_mini_ospi_defconfig        | 1 +
 configs/xilinx_versal_mini_qspi_defconfig        | 1 +
 configs/xilinx_versal_net_mini_defconfig         | 1 +
 configs/xilinx_versal_net_mini_emmc_defconfig    | 1 +
 configs/xilinx_versal_net_mini_ospi_defconfig    | 1 +
 configs/xilinx_versal_net_mini_qspi_defconfig    | 1 +
 configs/xilinx_zynqmp_mini_defconfig             | 1 +
 configs/xilinx_zynqmp_mini_emmc0_defconfig       | 1 +
 configs/xilinx_zynqmp_mini_emmc1_defconfig       | 1 +
 configs/xilinx_zynqmp_mini_nand_defconfig        | 1 +
 configs/xilinx_zynqmp_mini_nand_single_defconfig | 1 +
 configs/xilinx_zynqmp_mini_qspi_defconfig        | 1 +
 19 files changed, 19 insertions(+)

diff --git a/configs/amd_versal2_mini_defconfig b/configs/amd_versal2_mini_defconfig
index 181866ba6973..e0f43352236f 100644
--- a/configs/amd_versal2_mini_defconfig
+++ b/configs/amd_versal2_mini_defconfig
@@ -32,6 +32,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
 # CONFIG_SYS_LONGHELP is not set
 CONFIG_SYS_PROMPT="versal2> "
 # CONFIG_CMD_CONSOLE is not set
+# CONFIG_CMD_HELP is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
diff --git a/configs/amd_versal2_mini_emmc_defconfig b/configs/amd_versal2_mini_emmc_defconfig
index 1c5fe4b84ce5..d95c4b3d199f 100644
--- a/configs/amd_versal2_mini_emmc_defconfig
+++ b/configs/amd_versal2_mini_emmc_defconfig
@@ -26,6 +26,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_SYS_PROMPT="versal2> "
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
+# CONFIG_CMD_HELP is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
diff --git a/configs/amd_versal2_mini_ospi_defconfig b/configs/amd_versal2_mini_ospi_defconfig
index 5d3d0fb5231a..cd59e0fc1a98 100644
--- a/configs/amd_versal2_mini_ospi_defconfig
+++ b/configs/amd_versal2_mini_ospi_defconfig
@@ -30,6 +30,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
 # CONFIG_SYS_LONGHELP is not set
 CONFIG_SYS_PROMPT="versal2> "
 # CONFIG_CMD_CONSOLE is not set
+# CONFIG_CMD_HELP is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
diff --git a/configs/amd_versal2_mini_qspi_defconfig b/configs/amd_versal2_mini_qspi_defconfig
index a9fb217b286f..03f3bd488061 100644
--- a/configs/amd_versal2_mini_qspi_defconfig
+++ b/configs/amd_versal2_mini_qspi_defconfig
@@ -30,6 +30,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
 # CONFIG_SYS_LONGHELP is not set
 CONFIG_SYS_PROMPT="versal2> "
 # CONFIG_CMD_CONSOLE is not set
+# CONFIG_CMD_HELP is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
diff --git a/configs/xilinx_versal_mini_defconfig b/configs/xilinx_versal_mini_defconfig
index 296c404d15ab..59f33f669cbe 100644
--- a/configs/xilinx_versal_mini_defconfig
+++ b/configs/xilinx_versal_mini_defconfig
@@ -33,6 +33,7 @@ CONFIG_CLOCKS=y
 # CONFIG_SYS_LONGHELP is not set
 CONFIG_SYS_PROMPT="Versal> "
 # CONFIG_CMD_CONSOLE is not set
+# CONFIG_CMD_HELP is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
diff --git a/configs/xilinx_versal_mini_emmc0_defconfig b/configs/xilinx_versal_mini_emmc0_defconfig
index 36bd519af0c5..92d08120237e 100644
--- a/configs/xilinx_versal_mini_emmc0_defconfig
+++ b/configs/xilinx_versal_mini_emmc0_defconfig
@@ -31,6 +31,7 @@ CONFIG_CLOCKS=y
 CONFIG_SYS_PROMPT="Versal> "
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
+# CONFIG_CMD_HELP is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
diff --git a/configs/xilinx_versal_mini_emmc1_defconfig b/configs/xilinx_versal_mini_emmc1_defconfig
index 630f328e69ea..2c3775c3075b 100644
--- a/configs/xilinx_versal_mini_emmc1_defconfig
+++ b/configs/xilinx_versal_mini_emmc1_defconfig
@@ -31,6 +31,7 @@ CONFIG_CLOCKS=y
 CONFIG_SYS_PROMPT="Versal> "
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
+# CONFIG_CMD_HELP is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
diff --git a/configs/xilinx_versal_mini_ospi_defconfig b/configs/xilinx_versal_mini_ospi_defconfig
index cac691c92cee..11811f3c0fdb 100644
--- a/configs/xilinx_versal_mini_ospi_defconfig
+++ b/configs/xilinx_versal_mini_ospi_defconfig
@@ -31,6 +31,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_SYS_PROMPT="Versal> "
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
+# CONFIG_CMD_HELP is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
diff --git a/configs/xilinx_versal_mini_qspi_defconfig b/configs/xilinx_versal_mini_qspi_defconfig
index 220daa894ea0..47737ce0f8fd 100644
--- a/configs/xilinx_versal_mini_qspi_defconfig
+++ b/configs/xilinx_versal_mini_qspi_defconfig
@@ -32,6 +32,7 @@ CONFIG_SYS_PROMPT="Versal> "
 # CONFIG_SYS_XTRACE is not set
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
+# CONFIG_CMD_HELP is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
diff --git a/configs/xilinx_versal_net_mini_defconfig b/configs/xilinx_versal_net_mini_defconfig
index b0f4128932ce..27a163a9ae5c 100644
--- a/configs/xilinx_versal_net_mini_defconfig
+++ b/configs/xilinx_versal_net_mini_defconfig
@@ -33,6 +33,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
 # CONFIG_SYS_LONGHELP is not set
 CONFIG_SYS_PROMPT="Versal NET> "
 # CONFIG_CMD_CONSOLE is not set
+# CONFIG_CMD_HELP is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
diff --git a/configs/xilinx_versal_net_mini_emmc_defconfig b/configs/xilinx_versal_net_mini_emmc_defconfig
index 1f8fb162c976..8d3561fee6dc 100644
--- a/configs/xilinx_versal_net_mini_emmc_defconfig
+++ b/configs/xilinx_versal_net_mini_emmc_defconfig
@@ -26,6 +26,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_SYS_PROMPT="Versal NET> "
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
+# CONFIG_CMD_HELP is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
diff --git a/configs/xilinx_versal_net_mini_ospi_defconfig b/configs/xilinx_versal_net_mini_ospi_defconfig
index a8d0c5fc1287..aadfcfcf9dbf 100644
--- a/configs/xilinx_versal_net_mini_ospi_defconfig
+++ b/configs/xilinx_versal_net_mini_ospi_defconfig
@@ -30,6 +30,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_SYS_PROMPT="Versal NET> "
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
+# CONFIG_CMD_HELP is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
diff --git a/configs/xilinx_versal_net_mini_qspi_defconfig b/configs/xilinx_versal_net_mini_qspi_defconfig
index 1a3df99f65ed..ed4c3893315e 100644
--- a/configs/xilinx_versal_net_mini_qspi_defconfig
+++ b/configs/xilinx_versal_net_mini_qspi_defconfig
@@ -31,6 +31,7 @@ CONFIG_SYS_PROMPT="Versal NET> "
 # CONFIG_SYS_XTRACE is not set
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
+# CONFIG_CMD_HELP is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
diff --git a/configs/xilinx_zynqmp_mini_defconfig b/configs/xilinx_zynqmp_mini_defconfig
index a068e8976b48..41444271f0d9 100644
--- a/configs/xilinx_zynqmp_mini_defconfig
+++ b/configs/xilinx_zynqmp_mini_defconfig
@@ -27,6 +27,7 @@ CONFIG_CLOCKS=y
 # CONFIG_SYS_LONGHELP is not set
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
+# CONFIG_CMD_HELP is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
diff --git a/configs/xilinx_zynqmp_mini_emmc0_defconfig b/configs/xilinx_zynqmp_mini_emmc0_defconfig
index 498bd809afe8..369d480fd1ff 100644
--- a/configs/xilinx_zynqmp_mini_emmc0_defconfig
+++ b/configs/xilinx_zynqmp_mini_emmc0_defconfig
@@ -41,6 +41,7 @@ CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
 # CONFIG_AUTO_COMPLETE is not set
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
+# CONFIG_CMD_HELP is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
diff --git a/configs/xilinx_zynqmp_mini_emmc1_defconfig b/configs/xilinx_zynqmp_mini_emmc1_defconfig
index 6b053cfa3ada..2b415b8f7271 100644
--- a/configs/xilinx_zynqmp_mini_emmc1_defconfig
+++ b/configs/xilinx_zynqmp_mini_emmc1_defconfig
@@ -41,6 +41,7 @@ CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
 # CONFIG_AUTO_COMPLETE is not set
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
+# CONFIG_CMD_HELP is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
diff --git a/configs/xilinx_zynqmp_mini_nand_defconfig b/configs/xilinx_zynqmp_mini_nand_defconfig
index 09e0cfb693f6..c7271899bdf9 100644
--- a/configs/xilinx_zynqmp_mini_nand_defconfig
+++ b/configs/xilinx_zynqmp_mini_nand_defconfig
@@ -28,6 +28,7 @@ CONFIG_CLOCKS=y
 # CONFIG_SYS_LONGHELP is not set
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
+# CONFIG_CMD_HELP is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
diff --git a/configs/xilinx_zynqmp_mini_nand_single_defconfig b/configs/xilinx_zynqmp_mini_nand_single_defconfig
index e9258fa598f1..bb9cd8823403 100644
--- a/configs/xilinx_zynqmp_mini_nand_single_defconfig
+++ b/configs/xilinx_zynqmp_mini_nand_single_defconfig
@@ -28,6 +28,7 @@ CONFIG_CLOCKS=y
 # CONFIG_SYS_LONGHELP is not set
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
+# CONFIG_CMD_HELP is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
diff --git a/configs/xilinx_zynqmp_mini_qspi_defconfig b/configs/xilinx_zynqmp_mini_qspi_defconfig
index 193cc7d27224..3f2d44d038e5 100644
--- a/configs/xilinx_zynqmp_mini_qspi_defconfig
+++ b/configs/xilinx_zynqmp_mini_qspi_defconfig
@@ -43,6 +43,7 @@ CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
 # CONFIG_SYS_LONGHELP is not set
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
+# CONFIG_CMD_HELP is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
-- 
2.43.0

base-commit: 40ef75b0796307f718a4b424b5e52e79b36ae2f4
