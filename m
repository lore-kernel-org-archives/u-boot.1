Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F306DC27C53
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 07:17:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CB868840F;
	Wed, 19 Jun 2024 09:17:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NRqs/2gG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFDF588415; Wed, 19 Jun 2024 09:17:48 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6709C883FE
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 09:17:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHZ7SgAzDUvhC8qud+F/7nmAdilVWt3/oopoWzZrx01QaZ9VakYzXEUPiSxKyw3e+F35IlhzYaiew1PNVo2vVTJORQc6DiZi7i/SW4seR45cxatUiTLnXYV8ZpX/WrWSS4KErnFV+o+hul/TcnMoqKHUah/vvIY2MP13Pfn1gETaygPjLvwahPA/LbwWzFjYVXogZQ1Zz9WcrL1MobK5r2Ie+RKPq7rxZdCYC8FbfxddNHb9AR5rb6onqycQVtJwTbG6TJNV546DDMbvBJEsSvpMUocWAcaT/RuhEugom8FXIJMuf1OnUfdRIyx5E+GVG/jaogXg9V1CzxkpkxdXjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iadm42JzPS0uSMJ31z9B3x/3qcTxbDrYl+DYwzcaAjU=;
 b=jfUJVbXkGSg4477DMFvImGjxSzApkSlTP3IBlbc2oYjO5Uw4F/tyAPDuvNyJP6z2BE/bXZINSBw4iZK9rLazfHpXf6WoPJ5XGiZah5NBsg4uULX1g/z9auC8FsXpCb+D0bbvNhZOsnYpXgZSRlhqCLACPN94R9bY5+AunY3WF2s8ZWriBwJ9yolz9b8ze1cabzfwJomXIW+0CxervGTi+2nBZ4F+SAjLu7I911zc2qFLYA+fixsojopojLKwrBS23vFVpMICrISa/yfJDjHtr+P/Ep3eODAeK/uBcLKW/UOtCVP5uCPKeCWP9AmJ7SGpT3jHp+IMM9B8+AwE5SCXXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iadm42JzPS0uSMJ31z9B3x/3qcTxbDrYl+DYwzcaAjU=;
 b=NRqs/2gGCEk/Q3wEjHwCFdDrJJouwKyZGLaPz3Bc8jukBSFBey3af6ifzGSD3EZP5m78HPxNwlPQWBLbWwU8X7U6w4sgpHvbMGA3UAGWeSPH+ZcfzhjmKHi8RABTffqyFT10UI2sDRsolErfAADVaFwalGVWYJDDSXoyqWQVdnw=
Received: from SN7PR04CA0208.namprd04.prod.outlook.com (2603:10b6:806:126::33)
 by SA1PR12MB7040.namprd12.prod.outlook.com (2603:10b6:806:24f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Wed, 19 Jun
 2024 07:17:42 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:806:126:cafe::40) by SN7PR04CA0208.outlook.office365.com
 (2603:10b6:806:126::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Wed, 19 Jun 2024 07:17:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 07:17:41 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Jun
 2024 02:17:41 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 19 Jun 2024 02:17:40 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@amd.com>
Subject: [PATCH 0/4] Add mini configuration support for versal2
Date: Wed, 19 Jun 2024 12:47:29 +0530
Message-ID: <20240619071733.10256-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|SA1PR12MB7040:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a2aab14-aae5-47be-4f95-08dc902fe898
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|1800799021|376011|82310400023|36860700010; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HvUadblszGN8D9i9tcIjdbxHQ5R8ZJ4eAKau3rgqKTXYfvAUV3Lv0p3/GeTj?=
 =?us-ascii?Q?4UYjTd2KcGAhR52/vviE+KqQZukPbHGyVImUKlCHZ7LnfG4Cw+qWdDBtAEkb?=
 =?us-ascii?Q?ojRpj714sagZDsBuymcW8u5+J1EGDv469trtNMQK9rmcOvA5w9lRThgxXupU?=
 =?us-ascii?Q?N4lR9szDQWLvLESK4Y5klwLIuPFeIrwRC/FLkFc2H1idExGrv30DpcVmzx8g?=
 =?us-ascii?Q?b1QjOuwfZwsnEdHopJfDzP+LZN6c4EBf3isuOam8PLyvm2bcByU+EAE4VNBx?=
 =?us-ascii?Q?KTfMKP+N1FgVsn7fnO/vg6AfcntpUgUgyUeu6RdRU3DZlYkYbHa3/QQ2kNJN?=
 =?us-ascii?Q?Dzr0s79LLI993DYBgAH9o+s2iRBWStAeVdrURULtL1OyPcLb6A/lCEhjKrrn?=
 =?us-ascii?Q?4MBvtVtuoD27i6Ltzs1j1WA2gjQ0e/N+JeT+GkPUXokP++Q1geqBTwkJ1pdX?=
 =?us-ascii?Q?hHauAudHU9rcqCGEDrjkERxGumjoFWvJHFn85372akoJCakaTIToigutcNuX?=
 =?us-ascii?Q?/DAKuBlJ+XxEwTZSVsZzsmZF9rXb/xUin3Jo44SZ3x+fI3J0SnXWTGCu+Vsq?=
 =?us-ascii?Q?9cTR38r/yscEEOcUEv6xa2hkwEDdwDFI0K8CcS64Qz4dywQGrx+cOeydTvBP?=
 =?us-ascii?Q?8hafPlf6yPrUEG3QXakGh+HPn4RUEuJ8GR2ppyYmBdmgpEYM7E7uvKR6mN1K?=
 =?us-ascii?Q?uQvBQ50vEOwHiBwi/TRA+iBcTC+LB4jMMYrP2zqQJ4qMLjBiFRRf1gVhs+sV?=
 =?us-ascii?Q?nqEHba0tWJtonuXko91W3GMTrK0jjpjgziE7rmPDE18/jKv5CtL7WjmaTw4O?=
 =?us-ascii?Q?Hc24xt6spqm+tyZcu8dk5d9wJf2H2GUSJn4+wUQN3Mi0WzzBILlAuvWTmBXw?=
 =?us-ascii?Q?0ATzWGrYT8StQfMLDSjvCcRsqRXVRqIYEIJtR2Z63gHuyExaZULLo6UzIqZb?=
 =?us-ascii?Q?6SCWXBg7WU8Z6oqT5bqZMiiHOAg3cWI4U2D7Z2Y8+uXnQdo28pZ1HoLKV7Aw?=
 =?us-ascii?Q?ZXVoQqlvJ+/lvTM2jkmDc9T/SRHexwkm4/BTbDug3sq8dMeVfGtM0pFG7+c2?=
 =?us-ascii?Q?d4VTjq2W70G/UwnsgnvNBjbQ+96C8/uryfP5olOzaLz5isoZuA1qWCjZokdO?=
 =?us-ascii?Q?EYaP0ImobtxORvTFCDiFBDetyDouMRdPEElRcCHLKWuS2qp9CnAwBsd3hwAp?=
 =?us-ascii?Q?11s8wfddds6nSvKrazHBVPEKK29MtA3zN+tdGHV/1YZop3IRhsSD6OsrVVxq?=
 =?us-ascii?Q?LFahDMgS7vmT7Rj2XFdcQofs9j7J28C6WCK8dMVYY//oUafj8mXfU2rWppHp?=
 =?us-ascii?Q?aFtHJRb7antN78DD6zbx5kOxKTsoUmx0BnEKTIBBd2bWAsoi3K6oYR/bPojk?=
 =?us-ascii?Q?b4xtD1g1SsBOTJTVLCmSiQC4JbimIsvLHygLoYmGnJWSPzb0zA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(1800799021)(376011)(82310400023)(36860700010); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 07:17:41.9145 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a2aab14-aae5-47be-4f95-08dc902fe898
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7040
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

Adding the basic mini u-boot configuration changes for qspi, 
ospi and emmc.

Branch:next

Venkatesh Yadav Abbarapu (4):
  arm64: versal2: Add support for mini configuration
  arm64: Add versal2 mini qspi support
  arm64: Add versal2 mini ospi support
  arm64: config: Add versal2 mini emmc defconfig

 arch/arm/dts/amd-versal2-mini.dts       | 11 ++++
 configs/amd_versal2_mini_defconfig      | 77 +++++++++++++++++++++++
 configs/amd_versal2_mini_emmc_defconfig | 69 ++++++++++++++++++++
 configs/amd_versal2_mini_ospi_defconfig | 84 +++++++++++++++++++++++++
 configs/amd_versal2_mini_qspi_defconfig | 79 +++++++++++++++++++++++
 include/configs/amd_versal2_mini.h      | 20 ++++++
 6 files changed, 340 insertions(+)
 create mode 100644 arch/arm/dts/amd-versal2-mini.dts
 create mode 100644 configs/amd_versal2_mini_defconfig
 create mode 100644 configs/amd_versal2_mini_emmc_defconfig
 create mode 100644 configs/amd_versal2_mini_ospi_defconfig
 create mode 100644 configs/amd_versal2_mini_qspi_defconfig
 create mode 100644 include/configs/amd_versal2_mini.h

-- 
2.17.1

