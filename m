Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A6FD116F3
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 07:36:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6281E83F59;
	Wed,  3 Dec 2025 08:36:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="clLngBXV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2991283F59; Wed,  3 Dec 2025 08:36:15 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1712283F39
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 08:36:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SAoEwBbQqMDF3mQMMsmCMOjWbwIKHYISyk9nWS2JqJFOgRhJMgbaa/rTkfb2591/6UjeDUYzwrEDLlW3euYr/VMQZkrznFXyOLle72pLaVKxpkhnqMb0Sx5KRA3wvbY4lMCjVaCknrsJOgCdyYuA9RgBio2nchutWXGFR+7owAF3WlFjl8J/scTehHlbbRG/HbrT22RIIohXccBeilpo/Z0uFntFGLgpfIzK2XFkdoJ+bxklYXrJHGrKQcnEVJesfzvefY/tXoYYBzH+5hsVKSibQay+L/vOtBqVy60utdKfNJs5aMbxciKxL12hPiXI8cUpTn2S8g1y4he85BJuYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DjAz0Tos+SyFXaIfXp3AZJDyp0z3RvIHz90V8sdx5c=;
 b=Dt9WqbJRyByl2b4VQeyanctfC/6owOrgeOICTEn8qZM35m8tKQ2vcsG+TiR0xpIs3AdyKRWMFElJia1yD3VTPl2sp38OFWRWacA1q3jf9n8rqZMW1yY+fGDn5++QzWb5kvUICsCiVHYCDCNzXY5LuI1fhIDykvD3DuhV925yo1GtrNFW8iBxO9LWRHmKYdAUXNKqcO9lGJ24AbWuGJKUea198/zyCDX38YSLbuCG/g/zzy5LPotltBNdRu0SR+MnV5LMTwoOz3iFdQHgm36csmBIn6cOao7jbTD6y5egvc/bem1bU1+za20LqkCQH7Lbj/1X8KFstIhmK6ABDQUIYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DjAz0Tos+SyFXaIfXp3AZJDyp0z3RvIHz90V8sdx5c=;
 b=clLngBXVw/UN1q7TMKCoOZBi1Hhr1O2FlNJ8TTjEZaKP/96OaoC75F7GixtkDYkxtNYAZ4XoYsbX3bbCMx7MfcNMqAs4RW9BhhI+goH9dPXLlzs+AUS6umyuX2C0N6zq5Q8MK4uzt3DSxPIZyhPxEx9klOmLKUbE42p3aE/Pn3Y=
Received: from DS7PR05CA0071.namprd05.prod.outlook.com (2603:10b6:8:57::14) by
 IA1PR12MB7494.namprd12.prod.outlook.com (2603:10b6:208:41a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 07:36:09 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:8:57:cafe::76) by DS7PR05CA0071.outlook.office365.com
 (2603:10b6:8:57::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Wed, 3
 Dec 2025 07:36:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Wed, 3 Dec 2025 07:36:08 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 3 Dec
 2025 01:35:54 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Dec
 2025 01:35:53 -0600
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 2 Dec 2025 23:35:52 -0800
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Padmarao Begari <padmarao.begari@amd.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Leo Yu-Chi Liang <ycliang@andestech.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Martin Herren <sputnik@on-the-web.ch>, Sam
 Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>, Tom
 Rini <trini@konsulko.com>
Subject: [PATCH] xilinx: mbv: Remove debug UART support
Date: Wed, 3 Dec 2025 08:35:48 +0100
Message-ID: <6eaad47c30990ffd230d21c7158bc7234cda1752.1764747346.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1253; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=XZyxL/1zVudp2js0GA9glQvkBnz251KTzgmm2d1+NvI=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTqvwirrzj1w+up27c0rR/H131bu6RF9uURL55rL+2eu
 5naXlrF01HKwiDGwSArpsgynUnHYc23a0vFlkfmw8xhZQIZwsDFKQATYUhh+Gd6s3KzO8ub8yo3
 Co8tKtq1wi96Rp7aFfm5l9fsMeHMWHKE4X/qxcs/9uU/uDshhE/tXOzZM6wNU4/9ubeTPesJx6L
 u7yycAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|IA1PR12MB7494:EE_
X-MS-Office365-Filtering-Correlation-Id: 98593b31-3d8a-4a44-da93-08de323ea02b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r/DFgdiG6RhFQGbC8sMJh2ilHnfZaxKLqTHHH2C9A+QGfGoaK3wupsmZweyD?=
 =?us-ascii?Q?B0wmcbcviHP/ZA0zXykVBq6olX2Nn84F68m8ps0sFHgqHjEqdw2Fr2TjrYNC?=
 =?us-ascii?Q?JzpY17IOU2cbIA0+EsrzssH5L0pw+eefg0afD7twmNA4t13A3qUvk1xlFefi?=
 =?us-ascii?Q?ENDlSgG20Ab1G+JUM3B13UKqPhE+hNAzrKhTca144UT/YTHNxJJYseoxExyG?=
 =?us-ascii?Q?P2Qs1sGATeOW5T+2CSRIWEyyf7XY2w+ljN71Oko5RbKoV2mT4BWwA80JdbhK?=
 =?us-ascii?Q?z2qNa+at9Hod0rcE91kBznzFzNGH1a1gSpNFNxb2oXfEflM0J5w5GOA9834i?=
 =?us-ascii?Q?pknVTG3sKAg2lNF5FM0bE/5Gia6hnS7123hQMo/IXd0ZmyS/B7uh97PC6UR1?=
 =?us-ascii?Q?BsMAYZJOleZcaI6fNN5xmAqRiDAWUkD1Q+fR6adHdyuKP4f+MNpGtQoi0LM1?=
 =?us-ascii?Q?UinU9xxxnFXxelXmlc7WcYoAbkqadEzbcq9X5jvstxEMO0M0wbjBP7bsCmSr?=
 =?us-ascii?Q?t6U7XwsYpwcV5vK893GkeKCO/EJjsbYq51KIIM+sTB+Omr8WUwaUbTZpNk5H?=
 =?us-ascii?Q?706zOWlwp1XRAZmQUYvfSjlXJ+1Mg0FeU1UEFmcNu0qiHuKEuj7H+7HFhhzn?=
 =?us-ascii?Q?D8/PLTeyK+6Ghl0uphyHhVj3KPuJWyA4T2ADXsJ8tGPiict2hQSzzNkH+bwN?=
 =?us-ascii?Q?lpu1LKLUkz/YtaxZDRZjYm8hYNzP46VelV6lkSPJmPm33VCD+e7FfOQ7bUoi?=
 =?us-ascii?Q?Kt1gRrLX/nTPEdJ1b2OILXyfa8NJjx5EqWzCIaNSoXZECHgEGWnntXs0frk7?=
 =?us-ascii?Q?GonN/LfomBVo1M8risbp0/5BpRPC5YT846+NEYEdidhxHc9cCWoehsJci7yJ?=
 =?us-ascii?Q?l5euESON1pA2a9cMigMdRBoVQ21YUU2goQuzx34bKvxfYb91CjpK2U/CMXy+?=
 =?us-ascii?Q?JoJcpPHC9bchtcZc+NbKHCb/VxF34VpPAYlDgjCNj3x75QReKxNrI/W/PxXS?=
 =?us-ascii?Q?Q0L3YqQVJNo3y5iAomTVK0AhlJGBht4sOHc1sXQWSVbdSKWZslMW9oham0uj?=
 =?us-ascii?Q?c1L0hcjU3tAn5Sj6aekN5/S7Hh3ZCn+cn7d6aFuxeqbVpADBEip9shjic+P6?=
 =?us-ascii?Q?aDdYbjvrmSBIQ9o3el8520vCk7zU1kKFn15PvxHqLdBxUmRDFQ9TfQd8sQ8D?=
 =?us-ascii?Q?F/PXGs3QqRqnLxh2BGHgdjZjq77svMz3qsC1fLzBZkNRe03bJZkrPtVaw8a5?=
 =?us-ascii?Q?wIeGW40r+jyxQY/tSQ7dGG8anuznVPe69ImM7HapKWeFISFXOwxTF9G8zjRx?=
 =?us-ascii?Q?/5iQUfWi/QeI0jfAs++88USjS+m/qtcrlMBM8JDqgHsWhlVK15leEbKTBaGb?=
 =?us-ascii?Q?FT2kSnHSoVzoZM6Kha8CiTZuYmOcieJN1WHP/ows9tnq25eoe9/8jvvh9jUy?=
 =?us-ascii?Q?7j+wFgOrRz/osd2of5j1fzOBC+vL3Ixy/+3IuyCaim2TRsQTfs8VBsSD8h1q?=
 =?us-ascii?Q?pSiFl5QBI09OoGqntjtmFtfjoZ+cmuaJqiMXURYUWBMA3lXrYNRLe3dkQz7d?=
 =?us-ascii?Q?+eDOttcdQC983Kf90sc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 07:36:08.8931 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98593b31-3d8a-4a44-da93-08de323ea02b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7494
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

Remove debug UART support as it is intended for development and
debugging purposes, and should not be enabled in production builds.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/xilinx_mbv32_defconfig | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
index d10517094c61..9e3c44352a15 100644
--- a/configs/xilinx_mbv32_defconfig
+++ b/configs/xilinx_mbv32_defconfig
@@ -12,11 +12,8 @@ CONFIG_SYS_BOOTM_LEN=0x800000
 CONFIG_SYS_LOAD_ADDR=0x80200000
 CONFIG_SPL_SIZE_LIMIT=0x40000
 CONFIG_SPL=y
-CONFIG_DEBUG_UART_BASE=0x40600000
-CONFIG_DEBUG_UART_CLOCK=100000000
 CONFIG_SYS_CLK_FREQ=100000000
 CONFIG_BOOT_SCRIPT_OFFSET=0x0
-CONFIG_DEBUG_UART=y
 CONFIG_TARGET_XILINX_MBV=y
 # CONFIG_RISCV_ISA_F is not set
 # CONFIG_SPL_SMP is not set
@@ -40,8 +37,6 @@ CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_DM_MTD=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_EMULATION=y
-CONFIG_DEBUG_UART_ANNOUNCE=y
-CONFIG_DEBUG_UART_SKIP_INIT=y
 CONFIG_XILINX_UARTLITE=y
 CONFIG_XILINX_TIMER=y
 # CONFIG_BINMAN_FDT is not set
-- 
2.43.0

base-commit: 339520b249a3c69a36faf5432cbd581459563e32
branch: debian-sent3
