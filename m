Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A92C369A4
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 08:31:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FC9A83A5B;
	Thu, 10 Apr 2025 10:31:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1Wu4OhsV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BC6C83A5B; Thu, 10 Apr 2025 10:31:12 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::610])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1A0C83A4A
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 10:31:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MFChRXfbKUyVhYqHduvp5nU6a50xbFMROezcmV4zz83M4nRGKAiQm1Ks+l3ukctDMWkusY8pZEYN0aZ1BZKIBy+HOWPxLD99TcSs2gG+wuR/BCWj6DIs1y/bz+IAFhrw1z2G66ok0/tKluFtefgiQqhmjMoNZhXup4zkjqyPED9/CDcRA7dtY9LiIHOYVaN/SviDFJ6HOhRDT+iOwDWUwXEtVg0MfuhQNh1B/F3rrmpzZNhBjrUzMpKXaymUF7D1PexN4feO37taZ3QEmBAzYskxMHh/JI6ei/COG5rUd6qIe/awdLHc//zV17bMJdJ84dUY5+JX0JMiJ94Fg8VkJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIIvWhdJgI8morGXQIsB7rxRrZCK+IoqLPQSXFapb60=;
 b=L0T7JoprC2n71rkth3h0VlxAYR1SHAJJFqvaBUSZCgwJG6N+jPSgDXenWoRSgd89kKdmywJkTsloqR93px2M9Und+qcCHoYTtj/CEAEm5gB1oINEyFuXD1R3D/KaYlBOkdYUy9EFo8p9EW46q8XSmQ6YuRl6VFCG1koKlRVjRxYX8Z4TmUc9OyHbvYT72k4Dbemt9F7j7WjGKLlQ9uvcNcKSwZP+n008/HeMnruyKoSjp206MxRglo6sViZux/pgCVv/Lu06XhpUbbZP7LSKqxDSchQD+tpYthO7PCInwPS29wEXtAMaaRI5P1kQ+eSphc0IKF/lzRTSILPaWCfmZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIIvWhdJgI8morGXQIsB7rxRrZCK+IoqLPQSXFapb60=;
 b=1Wu4OhsVNIpUgL6qWo/dgAdGDi2Og7892x5aZF+eJCnaljp8IW1fRCyJk67zxgw8Ay+M8iqLVSE124TxfzxICyvMJOoJjyQxUNtn8OZM4CQWjEbNsSu6M9ybFjl19miV2P1z7W5u6n4n/DHVXiEEC7lOFRwXIvbaodVV7od3tlU=
Received: from BN9PR03CA0381.namprd03.prod.outlook.com (2603:10b6:408:f7::26)
 by SJ2PR12MB8832.namprd12.prod.outlook.com (2603:10b6:a03:4d0::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Thu, 10 Apr
 2025 08:31:02 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:408:f7:cafe::f0) by BN9PR03CA0381.outlook.office365.com
 (2603:10b6:408:f7::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.37 via Frontend Transport; Thu,
 10 Apr 2025 08:31:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 08:31:01 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 03:31:01 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 03:30:59 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 10 Apr 2025 03:30:59 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini
 <trini@konsulko.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH 0/2] arm64: versal2: Enable boot from UFS and USB
Date: Thu, 10 Apr 2025 10:30:53 +0200
Message-ID: <cover.1744273853.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|SJ2PR12MB8832:EE_
X-MS-Office365-Filtering-Correlation-Id: dc7f1cb5-c21a-4d6c-4343-08dd780a06f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NTYNmPQD4WLfaitu6+XxZ7HCWqswMP2FBVZSWKkYXwK4pQV2/y+r0l+HaZO4?=
 =?us-ascii?Q?H8zKF7ogXLnuAO3vjV38EA1IuDn3agwa8pZpPUI6nZdZy07FxPhOQ5XpEfjv?=
 =?us-ascii?Q?jZBIS+5iWSkmcf2PU1Iz9QqGiI6pGK7aYNXVXnmPf0jLC5Ja5hLCyDArsWGH?=
 =?us-ascii?Q?sQWUDiL+vNCePEOcBKlW/WbRI+gfnrejtZu1z0RwlVYCmjBO14xaCXIGQYzx?=
 =?us-ascii?Q?HWCF9hp6ykAMPAvw2wn1uOypjaS1N/FVvfz3CoEF6yOvxV6XReKFSPLQULqs?=
 =?us-ascii?Q?BU9myt/8IsKicix7zIKF7CzpAIJP246cheldYwIIo2ZoTIzJAFnFV6WlL7rm?=
 =?us-ascii?Q?cd+eEKBsT8B9bX9Qd+pkH5iw1Igsw1DPzV4atul62YKXEYMYJXWwdd+yd/Iq?=
 =?us-ascii?Q?Lg8yr7N+jrMpuC2Eq1zg9v1ndSZWBf2w2Hg4f2x1DhrOY8Q+HOJK5iSyVBWT?=
 =?us-ascii?Q?pfr32ZaGLXg0H8g6iiajLLYDESDsDBh1e1erre41mLA+TrSWYO/TH7dkuH4m?=
 =?us-ascii?Q?ONnK81nK/gZ9gFCUgXJe01gyUnN572GDTLeBQ/UBGDABXwsmar8R1w4YaMZd?=
 =?us-ascii?Q?+RQ7ZdVmItQSSoS4TvjqHzJLFHEZX+bAmjmY5onjkEjKdZPe2ZN3dbwxgKVr?=
 =?us-ascii?Q?6V5qlQeJp2GU3E2FWnurq4IW/3wkKRHB7IG3ApSIfcRbsEX/gSNTzZZYwrN9?=
 =?us-ascii?Q?YPcUERUueafM8DbYj9Nbny/zwAFhMiJDp1inramda784ZAeyyPl3jSI2EfTa?=
 =?us-ascii?Q?eo0pNJVzerqRwbab5ewIDQ2chDINrKpUATAZbpAbyl/jC1OPeb6xlrlftQS3?=
 =?us-ascii?Q?4nRHgBiuMULT1X9y8ycTj5BqGWjqOKixgP0o8saaqlTGj5S6FVDmfQllIdsQ?=
 =?us-ascii?Q?AiIsy6Hxgdtrok/mS5mkBy+hNSTGAMhv7VvomXjxIeLwYX4nPk1Z2nk5Ht8N?=
 =?us-ascii?Q?a0WAmjHu9lytiIMu3tSF9rhUBeWZIe/AIDOdnTVG84IwlNc2eI9JFzuEcy2/?=
 =?us-ascii?Q?auJtGIsKNFRgMcjrS73X3jJJFnNxoSuJfSgAV8vRO/iqhF30XugI9VjvoX1W?=
 =?us-ascii?Q?LzJUSILVbgxTPkZFGVCTACoQgBscATk+xiltRVgzWageEYjfm2uhw3OrpiZW?=
 =?us-ascii?Q?T+rEKC92nUwBWkJnH2621eOIDRzCVyKXXgTwR86uooNPEuEl7MTpnNc4g4Fz?=
 =?us-ascii?Q?hNJnp72djTGNAbpFIjH59Nm42lMm0rSGlHBMC3dhaUkPB4XLwPjvundbliMT?=
 =?us-ascii?Q?ICXyF/fcPGih5aHcpQPY1PtyzNBlA2Yk0tlWWPAdTvw9icSMvfsIFDv9ATnQ?=
 =?us-ascii?Q?X0DWALSIdHFHUAVpYzsSKPCJsNPNtH4oVhz2SNZky5KH3375fz6n+jgM4/Ze?=
 =?us-ascii?Q?3A4+y7B9ljMhA5uJjJVez9Rkyq+OXxW1ZczczpAE500r+JDnpoOshF/LGhnJ?=
 =?us-ascii?Q?NbFFOOU6i6bMk8mDMbmkaBcGZ/lVZD3uY9ugr3amVpfS8bM3zUU/cRSNM/6W?=
 =?us-ascii?Q?nwzM/A/0gFrcXTyi7ByA503ZJpGufpYqIoYf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 08:31:01.7424 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc7f1cb5-c21a-4d6c-4343-08dd780a06f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8832
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

Hi,

these two patches are wiring support for USB and UFS. It is still done via
distro boot because we didn't switch our platforms to standard boot yet.
But investigation is planned already. To bridge the gap between wire it via
already available distro boot.

Thanks,
Michal


Venkatesh Yadav Abbarapu (2):
  arm64: versal2: Add ufs distro boot command
  arm64: versal2: Add usb distro boot command

 include/configs/amd_versal2.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

-- 
2.43.0

