Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1831ED767F5
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 09:50:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFD06891E2;
	Fri,  1 Nov 2024 10:50:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4aV42Lv4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57CFC88F4A; Fri,  1 Nov 2024 10:50:12 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::614])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A2A688D9A
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 10:50:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F6z0ncUzpQ3S0k0FjIqMUm3h0P8gjbZjNrJuyMZyv7uVV7aM8kf+ZPW2nq+QDKltdbDQAY+JfwBmiqr1881w24B/Ljq/s0B3MG3YMz/K8sAkM4LQ/kZjdpXT6C/3rILshf07eGXkuzzl2yW3n3fLTiZpx98RBg2V8Mxjn+IEu1uGQLxfOqObKYPuHxxsaXxqc7OAcjlxIlBk7uBx8N5Ixqx5N4eMIh7r4U6b/IwIJSZigGchugkyH930gZb9ugKi/kpeBdp9I6T506KwqXhuvNAsMOKnkdifhUM1kJr+/thmJuvmdSkkZCYJEgls0nsb0GX/F4sR9Qy3HQ4/v5rbZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdjmJfoPR35bFCsQVdtRv23iJrWrPJVWD4TpyMkMtME=;
 b=OTL3A24dWeBO/NMSs0QDw2VncWCAr9VpEh7oOx1rNoG7jw/VDRVVk52eHXWMzJMJNxaR6PqqoIRkSq7dB22a2yXUCZmoVvR2qBsGzgfTrK2ry2VgdQ2+UKbYJ2bO5BnqNq0I1BYE05ljGBCkl+tVaORFoNS2uTHRJwgvIFWA5UpMeLnK5bDAdVBbj5pqkQO+4uevOegaQJQ9GK0MNuiNiBWmgZFPXVYivjk/UWMYV1bcayQxKMIVhZZUj4LIMtsNJZkC/X/IMmKd70UhZHJRSrLCK77z7finSv22Z7uKT4ljLTISSqdyvNjkdx3xpM0qgdnkp9+KrAaztNk6P0lucg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdjmJfoPR35bFCsQVdtRv23iJrWrPJVWD4TpyMkMtME=;
 b=4aV42Lv4zqVMH7KKm843+1AYOLbOAXO3q7lCCROYPsV2ijYKttJP7BRtED/Jkb66FSxfrPw1VRjhY+dOvbdN83qnV2bCzXwwLSDquHXgIjDCimc703UbHltPJN67DxI1MPu9jx4mzQGP34PKvCx2OkBgFEYX97NWxPwBzii1AQs=
Received: from PH7PR10CA0002.namprd10.prod.outlook.com (2603:10b6:510:23d::28)
 by SJ2PR12MB7800.namprd12.prod.outlook.com (2603:10b6:a03:4c1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.31; Fri, 1 Nov
 2024 09:50:05 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:510:23d:cafe::4a) by PH7PR10CA0002.outlook.office365.com
 (2603:10b6:510:23d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23 via Frontend
 Transport; Fri, 1 Nov 2024 09:50:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Fri, 1 Nov 2024 09:50:05 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Nov
 2024 04:50:01 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Leo Yu-Chi Liang <ycliang@andestech.com>, Padmarao Begari
 <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] xilinx: mbv: Align smode_defconfig with upstream QEMU
Date: Fri, 1 Nov 2024 10:49:54 +0100
Message-ID: <f7da41aa5222bda46ff6cf869cd45f3088e677ed.1730454591.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <e0109cec6a81163f213684758a5b2d67d927ea26.1730454591.git.michal.simek@amd.com>
References: <e0109cec6a81163f213684758a5b2d67d927ea26.1730454591.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1623; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=UOlKZIV8ef/JPUDaRYzKydEIw2iS3pGwhJo/eg+6iZ4=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhnSVJU4bl3r1XEwOmXBKN6DaujklKsZKaFbGd/mVDoHL+
 7aoLDnSEcvCIMjEICumyCJtc+XM3soZU4QvHpaDmcPKBDKEgYtTACaSuZBhfsh0iU9f//FMWrOe
 8URDzewEd525sxgWzOgrX88nsKP7jvmxhVX7eoqNY6/OBAA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|SJ2PR12MB7800:EE_
X-MS-Office365-Filtering-Correlation-Id: 703b1e9b-a585-4376-69ce-08dcfa5a904d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zitX9ZFhTaEApxztCRun//SCI+JhrfjsNULdgMKPyOGVlB/cIqMbYR1d9zG1?=
 =?us-ascii?Q?7tELTFuMpOjtJmLLZrzdGSTC6BgLUmIBw3spS0JNSAbGq9tNdTFqor6OTJI0?=
 =?us-ascii?Q?DF6jAOTVQoqIZ0W8qp7ik/NkPDkA+UG9W8nHDUuL8X4IEJV9o/Y4cXd070kz?=
 =?us-ascii?Q?uV43Zpnj8s7mMkwdm/Za53ElLh+ikKF92BUHzA8zs826QKxfcZ+kZnkLb0sm?=
 =?us-ascii?Q?O4VDZZwH0jWRbRVIbzwm9K3J+9zMGQWWGpmaoM/DseHJ9P3FNdBjoInhMvyH?=
 =?us-ascii?Q?f8omCUu1zS2OO5upgltvZv8gyQcHks3Tfu3w67QnHe9348xenF5ClX266LYh?=
 =?us-ascii?Q?ltDJlSNwek9+r6FZRF0qfW40/FYdTTWsYdm/b+y3kpB+TQ2C0NQJkiPP/jaT?=
 =?us-ascii?Q?UEE2EhU46vmD2nWIeAfbEfYxHR+AckjqbhyuJEICnBSW0rN55jrqzACzbNh0?=
 =?us-ascii?Q?s1bWlaK9X4Flx7rIWSMbEfH6BoX+E85jJpPqVBgT7+msVHkDTEmB6rx/gDc+?=
 =?us-ascii?Q?tBAB7dzAcTE6YI7vd0qzupNTNSsFUgNBGRntF1OUTnaDUq0BlzQoY+y0noHY?=
 =?us-ascii?Q?foRuzwWGDBpUQTpwpdq4/rFD2sRpdGIc1UPFu++fYoUdh7iBDNmqe8aSBo+B?=
 =?us-ascii?Q?7DKJ33zotS+pOKVfm4nQ4/RxpfzsER9ZVHHr4VJpXF6ldxSrNyirSbEcxkNd?=
 =?us-ascii?Q?14ItCRjYGiW9LGYSH1Zi3wZUe5mPL5I8KTDVyl56GZYDSsW0fVN3bDy/POLw?=
 =?us-ascii?Q?wlUV8m+iVN9ewGlz371tcEwqVWtteMB2ASiLA8aIXk6mI4AnYmC8BYEaWJj9?=
 =?us-ascii?Q?v7JYfrCezfsMjMmK3HxGwEa/kopoG/M4YE/ZIZDw2OXSr4z293P/lWXDy8GI?=
 =?us-ascii?Q?IUPC1NYPmkjKlM9TfeolOA6dl0RHsQo2foNI97zH5PhEJx5xlFreJC8oYBBf?=
 =?us-ascii?Q?NiSDxxAcLbuHowt90DtBeoFyezO81lWPS/RHDF7+aJKJL1M13E7ICPpLU/Do?=
 =?us-ascii?Q?jGSTTOEE/FidCtOUUaqmLXmg6Uhalmx9mgZx+8Hcaf48w4hxbww+nroPVuZ+?=
 =?us-ascii?Q?Mkfm8hB7YcmkWWyXfcw/6xSpxRWO9vdxuAogTyrwR3X6mt26S9N9gOInOOzQ?=
 =?us-ascii?Q?vUEYgcW7o63ffHYXJSw4hoPSnnzmYYvYV6GCGr4NDe8P2Y5y9xE1TJ91ElBa?=
 =?us-ascii?Q?moKiSN369enmG68NjLRL+Xsfbjfe/1kxfbIC+4JKrdRcQ7h3BKJ90dIKVGf6?=
 =?us-ascii?Q?T4+Gk03WgNxl1BC/EdE4DZcJ9ChJlpTyJvmy10WOsECNEjmymkbBjuPii5Om?=
 =?us-ascii?Q?y4tETvmR2bdi5D3BKip3brhejLX/cXxeTfzr94SeAggeHGGNrZCd0+0nq0+n?=
 =?us-ascii?Q?E25m5zYnLb3yW1iopVmCiMZ0GqqujI4FcOLz3GCWZCR2LCEV0Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 09:50:05.3042 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 703b1e9b-a585-4376-69ce-08dcfa5a904d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7800
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

Align smode defconfig with upstream QEMU. It could be the part of commit
9d688e6da5c9 ("riscv: mbv: Align DT with QEMU").

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/xilinx_mbv32_smode_defconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/configs/xilinx_mbv32_smode_defconfig b/configs/xilinx_mbv32_smode_defconfig
index 741724f3bdae..820681d505b7 100644
--- a/configs/xilinx_mbv32_smode_defconfig
+++ b/configs/xilinx_mbv32_smode_defconfig
@@ -2,13 +2,13 @@ CONFIG_RISCV=y
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
@@ -16,12 +16,12 @@ CONFIG_DEBUG_UART_CLOCK=1000000
 CONFIG_SYS_CLK_FREQ=100000000
 CONFIG_BOOT_SCRIPT_OFFSET=0x0
 CONFIG_TARGET_XILINX_MBV=y
-CONFIG_SPL_OPENSBI_LOAD_ADDR=0x20100000
+CONFIG_SPL_OPENSBI_LOAD_ADDR=0x80100000
 CONFIG_RISCV_SMODE=y
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

