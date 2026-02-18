Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B7A5E9A03B
	for <u-boot@archiver.kernel.org>; Wed, 18 Feb 2026 06:34:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A9C883AC5;
	Wed, 18 Feb 2026 07:34:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W2vD3W3K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 412DD83C72; Wed, 18 Feb 2026 07:34:12 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A11283AA9
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 07:34:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SGaI+66tBbnIoIxceSMBROA5q7bQ8xY+tcWcRS8ZgM0ru9tMxFUNhEzAZQBsA57sIt0QaNYGSj+OOhv3jvj/KV1LT2OJbtcpP578gbGgvKyr2i+aoU/tlTY/doDvSijBtmdnIbrKu67YrH7S5vf4uxdxJ0/SEBGv6DrPGHvdeOwPgz2HrUmhkcSVyeOrlLkUrvf94wvXzi78rffXTUyGYszWX+M2biKUwAUX6dxFl4WUg7fWJ47BtRuHBLEzXq8Fl3pA793LXpJlDT0bsC6peW1bEwXRbZ8N636yYzRlNzIMFPae96VYUU6af1HnyYEHJ638v5bETsX1ML0WCF7TlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVGZIawFaGC3HGeLJEqAyM3/28XRdwWs1EYC3eRoJF4=;
 b=okoRDl9tnZTZtJBNPXYpw1ra4E+tbXTBy1jzDm3mC6kY+NqjTSqi2xmui3lMYI0J/kL/yTzmOSDz0+wcI6HWoR0kzPiEVPh22FBSyyFdbZke01yNxiktP6mupDf0Rz7yBQsPiOavnO7m/D4vvQ8wlHiUK/x/Jg6Ks7CKWERwUfSrqjs+UAbIhtJV/TjZ/iO2N7P5ZZBCHOZoW5R4iKE4CTxIAIlKutcWAGeeNi0PBPMr8eGwGVSnOOjxCkUTcoSV9e7gfpIwMHLrCAJfrtBUutBPor25e8of7F9uFIv+F00wENsca8BKWVKDM2P778GbY1i63TvI9bEwXx8vkf3dfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVGZIawFaGC3HGeLJEqAyM3/28XRdwWs1EYC3eRoJF4=;
 b=W2vD3W3KVCj977U6d6FO3J88opf9qQD7hrgakWKr7gTo/iFiy++8WR4tIcDmlxxHI6Y9m51dIJ5F4O9tZijB4wVNeLhSn3FlaVHoeKybMdi5TXTq+07+NJnHfXRItTy3TCCWon8IDrS/orLc2+qFD5Vh+a4J2pw7O7OM21OHi1g=
Received: from DS7PR03CA0077.namprd03.prod.outlook.com (2603:10b6:5:3bb::22)
 by PH7PR12MB7137.namprd12.prod.outlook.com (2603:10b6:510:1ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 18 Feb
 2026 06:33:40 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:5:3bb:cafe::d) by DS7PR03CA0077.outlook.office365.com
 (2603:10b6:5:3bb::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Wed,
 18 Feb 2026 06:33:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 18 Feb 2026 06:33:40 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 18 Feb
 2026 00:33:39 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Feb
 2026 00:33:38 -0600
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Feb 2026 00:33:36 -0600
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] xilinx: mbv: Update stack, heap, and OpenSBI memory
Date: Wed, 18 Feb 2026 12:03:15 +0530
Message-ID: <20260218063329.396968-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: padmarao.begari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|PH7PR12MB7137:EE_
X-MS-Office365-Filtering-Correlation-Id: 57b1420f-f7b6-4954-d1d0-08de6eb7a77d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eDVmQ0hRTitJZXhFcTgxbTNIWElxUXpCVVU3UnFlK1UzSTZ6N0NOTGVhQndw?=
 =?utf-8?B?UkJ1RW43SVpPN0xrZnhIM2FhVDRpd0FMRldPd0FRZ0lrclE0UThIZjBJNktP?=
 =?utf-8?B?M3UyN3NrNGpGL0sraHBzWlRMSlJJQjlObE9mQWlXNHphY0grRm9reXc2TDFz?=
 =?utf-8?B?blhZbFJIcjJBbStoYUJMMmlNUktMSXJvUEJ1dmJOc1lHVjkwZExKTmlGd1hG?=
 =?utf-8?B?UkNMWHB2YllRZmZzblRSRnFsWExkR2JTSDNmd25WQUlPT2ladDFKSndrejZk?=
 =?utf-8?B?WmppSkpQMTZ6YU43aFBHTkVIQ3VXVzh3RHE4dTU1aE1zL2hzcUtkSnVTeDdZ?=
 =?utf-8?B?Ny9RVTViQk5BYmFadTgrZDhyTnAwSXFBMCtYakluRzdhM21aT2hkZi9CU0NQ?=
 =?utf-8?B?dy9ub2htejUzWjZLS09IQW9URWpGUzZySHphTEhJSVlNT09ySGtYK2lqM3lD?=
 =?utf-8?B?SFJvQUxoREJnQUxzNm9QZkdTVGUwWnFaT1FDV3hwNTQxRk8xR1pERnVXOEtM?=
 =?utf-8?B?MTVtbzQ3WDFSR0FHTmVac2h1UWlSMTlDTHpQSHpSVVBvdlJwRzNTemM2OEpO?=
 =?utf-8?B?UGFsamNUZktnREdybVZQNVFydlZRREZ4RjJqM1NaUFdwY29OY3hPalVmM0cx?=
 =?utf-8?B?SFJLdyswajZNaGI1UTNTcGRyNmNkcS8vZC82NE9IUW1DTk1OOWVkQWNWQm9r?=
 =?utf-8?B?dm9EcElidVpNQ1V0bkVvODhpOVRKeUZSM09wdnNzb3dxdVlYc1lKN296TDZn?=
 =?utf-8?B?VlhSWGVTVjU1dVFnTFo5aXN5bi9VVHd4SXd0azJldDBTWUgxeVZvd3ZWdEZF?=
 =?utf-8?B?VU9wK0tya2xMVlVRWFRCSVRhMDRCMXVxQ2dRSTN5Zm1TUTUrZm55aDBvYk9H?=
 =?utf-8?B?anU3RmkzYVhwb292cWVNK1lDdU9UYmJKRm1VcmRwK1doNm9PL0wyYWZhcTlP?=
 =?utf-8?B?L05DcHNIMWZYTlJmN0FUVGhRUlcrN3ArRnhVckdwOGVjUC9TSEpKWHFIc3Z2?=
 =?utf-8?B?RnM4MHZncTI2VklNSUVsRnk0c01vY2Q4VnZNL0l3eUNsamduMVRoQTZzemJt?=
 =?utf-8?B?VU1tYjhJeC9RekJ1REZ0a2NrSWJuSE5BbUdkRE1zYmFtK1gzSXZremhTdjEz?=
 =?utf-8?B?d2lUajhsTVQxVGpKUk5oa3gxajdKMFNJc21rWGpQK0d5T1JWdTFxSHZ6T241?=
 =?utf-8?B?TE84T1lYblplS1JCUllWUkhwbEtXbmRFYjBSSTBoM0pDYW5pKzI3ZjZhaFVT?=
 =?utf-8?B?dFpuQVkzRW9PMGkvOEM1NmlpN1hPdzBZTEFRRFhXWngxL1BnOUxmWi9EWmVC?=
 =?utf-8?B?ZHZaOHZWTnYwd3ZTRVNCRFdlNmVPN2Q4YkhPbVdnbllicm1mVkRDZDJrTzNy?=
 =?utf-8?B?QUp2Ky84UWZLRzIzb3R4cERVS3VVSlo2N25JdEFzcDRhcEcvWkM4SGhaMzNE?=
 =?utf-8?B?cER4OGRocTBwMVdlUW1zUU0xbEJSUnBoWXVMRWgzU1U2UDdjWTJLN3FFWGdx?=
 =?utf-8?B?alhUb0lLTDNsT0M0b0F6b1dEZVJYVjlyaTFmc3VtYlR0WWF6aEU4VHp4a2Js?=
 =?utf-8?B?OGxkL3NkTGhIL2pONUp1SXRlYmkzR3V1TUh4WGRYb0JKRmFnRytNcXFGRVdi?=
 =?utf-8?B?ZDZDd2JWUnlLT1M2VmErZUZrZ3ZJNmo0ek15VERhWUdrM3B2eEl6dFdaZXU5?=
 =?utf-8?B?ZittdDBzL3B6RWtrOHp4R3ZkSERqWWRlTnFDaU8wYlRETlNIUHpnQWEvRGtn?=
 =?utf-8?B?Q1puTzdTdXNwUmhsT0NITkhsZ3h2WW0wd0VnOXo4R2tLUCtsU05PcXlqMU9V?=
 =?utf-8?B?WFdDUlBoak9BUXF2WlNKOVRUZ1dyQkVLbzk0ei82Y1dDUWhRYXQ4U1c3Z20w?=
 =?utf-8?B?TUdnNnBlRXZtQjVFbUVYaWNMdEVMb2ZwR0p2M0dKSFBoYk0zVVREYTViSzkw?=
 =?utf-8?B?VlVIM3ZqbXd5eWU1R3dQM1hXZ0NYUUI2eW5Za08rRmZFTjN2V3ZPSllJZkFL?=
 =?utf-8?B?OGREMFVTR213dkw2ZGJIVnBuVTVPMWJNRXAwSzJKTExIWlBkTXpNdCtuMXdn?=
 =?utf-8?B?dng2c0xUaUlnbzZlbjVrd3BQWFlPM2xTNk1sbUJSQk1OaHNEU2N0eDVBdDZv?=
 =?utf-8?B?RkxEM0hNY0piK1RuY1VSYW1qdVlwU2RxOGJmS2hNVVlzcjZ4UFhtS3VCYjRy?=
 =?utf-8?B?U29jV2FyeEFSQTRiamZRZmpzc2t6bHFBYnVpMDIxdkQrWjhmdElsRWFNa1BM?=
 =?utf-8?B?WkNzdldveVZkcmVVTFFvL2RubUtBPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wl1IY/ORcupFRmdzTbZxlTPbTfHAacBnCHJR3k7wD1pWiXrWhZX4dxN6TzRhcO1gOAym4XOrlueYUSJPbDK1Z9TeWfx2ClxDMwy+/tK4ZHUhUiVKn6T8yGAVZ6STwlRXQ4tq9Y3G9SYa8ZCEWX29VDotGpg9mwnu1QNIbXKCqxRlYhm9bdULMj30etcpJ7KrBe1PNuJ9XTs7T075fFOr7DXM55M8xCeq0ZrOz2LeO67IuaUx6Ywls2rp8OKefteX3+xE31TkDmbQaKdcgNmGQAsBMw2+qeUOlquq2Vl2Kmk/bRnj7XqFdQj2VWGmzjsivDYcw0PiYc4EG81xM5uy4lj6y9mTRcE1KOAX8gNzfW6JXrJ6On3ux83QLF9w/xxwpyO2GQJH1PQlvdGyIlxwgxVPyQ9YAauvndrlxpFDQc+n+Y/KrWEEKFWV10zmh8Az
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 06:33:40.0494 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b1420f-f7b6-4954-d1d0-08de6eb7a77d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7137
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

A 2 MB region of DDR memory is allocated for U‑Boot SPL, with the
heap starting at address 0x80000000 and the stack at 0x80200000.
However, U‑Boot fails when using OpenSBI v1.8 because OpenSBI begins
execution at 0x80100000, causing an overlap between the SPL stack
and the malloc region.
To resolve this conflict, the SPL heap and stack are moved to
higher memory addresses, and OpenSBI is relocated to 0x80000000.
The SPL heap now starts at 0x8C000000, and the stack is placed
at 0x8F000000. The MB-V requires at least 256MB of DDR to run U-Boot.

	_________________
	|		|0x8FFFFFFF
	|_______________|
	|  SPL- Stack	|0x8F000000
	|		|
    	|		|
	|  SPL - Heap	|
	|_______________|0x8C000000
	|		|
	|		|
	| Full U-Boot	|
	|_______________|0x81200000
	|Load FIT Image |
	|_______________|0x80200000
	|   OpenSBI     |
	|_______________|0x80000000

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 configs/xilinx_mbv32_defconfig       | 4 ++--
 configs/xilinx_mbv32_smode_defconfig | 2 +-
 configs/xilinx_mbv64_smode_defconfig | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
index 42dc5fb282a..0ca64b22659 100644
--- a/configs/xilinx_mbv32_defconfig
+++ b/configs/xilinx_mbv32_defconfig
@@ -5,7 +5,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x81200000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_DEFAULT_DEVICE_TREE="xilinx-mbv32"
-CONFIG_SPL_STACK=0x80200000
+CONFIG_SPL_STACK=0x8F000000
 CONFIG_SPL_TEXT_BASE=0x0
 CONFIG_SPL_BSS_START_ADDR=0xf000
 CONFIG_SPL_BSS_MAX_SIZE=0x1000
@@ -31,7 +31,7 @@ CONFIG_SPL_MAX_SIZE=0xf000
 CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
-CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80000000
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x8C000000
 CONFIG_SPL_SYS_MALLOC_SIZE=0x200000
 # CONFIG_CMD_MII is not set
 CONFIG_CMD_SNTP=y
diff --git a/configs/xilinx_mbv32_smode_defconfig b/configs/xilinx_mbv32_smode_defconfig
index dd1221a6904..a72f13851ac 100644
--- a/configs/xilinx_mbv32_smode_defconfig
+++ b/configs/xilinx_mbv32_smode_defconfig
@@ -1,5 +1,5 @@
 #include <configs/xilinx_mbv32_defconfig>
 
-CONFIG_SPL_OPENSBI_LOAD_ADDR=0x80100000
+CONFIG_SPL_OPENSBI_LOAD_ADDR=0x80000000
 CONFIG_RISCV_SMODE=y
 CONFIG_SPL_OPENSBI_SCRATCH_OPTIONS=0x2
diff --git a/configs/xilinx_mbv64_smode_defconfig b/configs/xilinx_mbv64_smode_defconfig
index 56bf0bdc7e4..d7cf108692d 100644
--- a/configs/xilinx_mbv64_smode_defconfig
+++ b/configs/xilinx_mbv64_smode_defconfig
@@ -1,5 +1,5 @@
 #include <configs/xilinx_mbv64_defconfig>
 
-CONFIG_SPL_OPENSBI_LOAD_ADDR=0x80100000
+CONFIG_SPL_OPENSBI_LOAD_ADDR=0x80000000
 CONFIG_RISCV_SMODE=y
 CONFIG_SPL_OPENSBI_SCRATCH_OPTIONS=0x2
-- 
2.34.1

