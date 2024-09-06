Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0FE4CE7AB8
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 07:08:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47B5588D02;
	Fri,  6 Sep 2024 09:08:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J6gSzRJ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 775AE88CFA; Fri,  6 Sep 2024 09:08:48 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::610])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4346888580
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 09:08:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Prasad.Kummari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vf2HQPnj8YaH/J6l3F0przHLIc2mFhFikTSe8fW8z8ta4wS9pbiopRpjd0JLH+ShZuMK6oIoqQbrbbC0zsqm7L53UQ+fUmljxg4inly4UyOwGRCtNb/h445UXpuTvfn7yEiAS3rLT5Y4xXESHkU4JxFXmhOhWlF0ek7dAdeXOcXViG0k2Ct2ufK/bkeD5jGgRL6a0Yt/ASOmbKBtzGR0kDKcwQtlVNfezDSB4ks8QOEo7yzLJMhhBRvBAMmLy9HHoo2jMqk46BkmATjhr095IrzAt/qhnNPmIQh4KqDLatFCN/36LGH94nXE9TdwGyPKu0IN1hd8SoblLuPjegJYHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xE1V+xLotDDI0wNcoud/aLO1gDVn2b4khCfneuwGD6c=;
 b=hCmRhPYaHPTAtsJgYFxYyrQeJQHE5uI34DKqI0vg4w3Gi007hnFvwM5/xxRD/ifGlEmd6KJ1Hd/f4z5h/rYMRkT4WTd16BYW+DGxay0OrZ9jVtDiKCB/ZdibzEJiJyw+NF9sBsR07p0+ezP3nebKj0Ny0p2WGjQQNN0Fp9YI02cnVMccjam2nDPogmzKGPBDEDxDv/qT9vCQLGXVKocJAoTBDyEUPEoRNrcvqmH5FvabJS8tTGhB6N4NZMchL7np5n0jUTEWsiyI8PWnZAgOL8rJ1RJL5pBUulBui5TtgbPfMM29nHlUaPGgm1lOAOzzXTpfu8lF1qv7zUzl5HpUlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xE1V+xLotDDI0wNcoud/aLO1gDVn2b4khCfneuwGD6c=;
 b=J6gSzRJ2dTYcaCuaHK3j2Avvx4iftbU5yUSsXrPVfif0zBTDTwwkQP22d2SCvnvOBTKq+HBflfMquX/pmcSbusDDIYbcfwlJ8pNMJP9rPnN5qT6WnULsZ7UduIzq1oigEt7024MRS2xJZed3mJl4WptEhnld3B6hjIBFQelPp6Y=
Received: from PH7P221CA0058.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::28)
 by PH7PR12MB9255.namprd12.prod.outlook.com (2603:10b6:510:30c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Fri, 6 Sep
 2024 07:08:40 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:510:33c:cafe::2d) by PH7P221CA0058.outlook.office365.com
 (2603:10b6:510:33c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.16 via Frontend
 Transport; Fri, 6 Sep 2024 07:08:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 07:08:40 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Sep
 2024 02:08:39 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Sep
 2024 02:08:39 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 6 Sep 2024 02:08:36 -0500
From: Prasad Kummari <prasad.kummari@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <padmarao.begari@amd.com>, <git@xilinx.com>, <jagan@amarulasolutions.com>,
 <n-francis@ti.com>, <d-gole@ti.com>, Prasad Kummari <prasad.kummari@amd.com>
Subject: [PATCH v2 0/2] fdtoverlay related changes
Date: Fri, 6 Sep 2024 12:38:06 +0530
Message-ID: <20240906070808.1045991-1-prasad.kummari@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: prasad.kummari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|PH7PR12MB9255:EE_
X-MS-Office365-Filtering-Correlation-Id: d4bda722-f9f0-43ff-30ea-08dcce42bc69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uFBlvgwCpnwRMqhfaQ8SyLrumCZ0sGlDp7lFjDpN/d4DgoWcQe9FzkWjzCVE?=
 =?us-ascii?Q?4+W5H7I4jId5lnJ2XroJb8HMuhB8NdA4gRwzYghCAetfBTzBDYTJPfFwIxMS?=
 =?us-ascii?Q?pNzXizHIMDmyLc8+Hg3vMHL0LyEwqE7/67ka7j5qsBXnwOIj236WB5pTQDjE?=
 =?us-ascii?Q?R//5WTbq701/ac13zoPdb+eoDi2UT1jqKgkduwTy0kwRmHEi1BF/imZpmRd9?=
 =?us-ascii?Q?OrUt0hljxRCk8Q2uOgfrm9sjlKioE7YbbcEcZ7f+GK09sSinZzQq2Ag74YDw?=
 =?us-ascii?Q?eVmRZ8//epT05d6ch+zhctXE2OubT98TQZsD8leKKTrm9oegSbV8homqc6sY?=
 =?us-ascii?Q?HzAQzeTMDCvjaCN9kOSuWIfQPyxTrlcPJH5a9wCRvRliALwHaLpE8NbwERz0?=
 =?us-ascii?Q?86CIY7hbdAr8YbIqsh5tRtwq3utNyLDWnWH4c1sxt3DR5slOhin0mkctEaSg?=
 =?us-ascii?Q?NlykvAqOLdnQc+Ct9Icsdfaz3UA715LD+KSm0PeBgQBDiIMQ9yHA9Q6trZBF?=
 =?us-ascii?Q?yPnnYtqTc4vbvntO+Q5S8ZLZLK65Qwr/WDlcx9whzv7/rO8XrzqvOS+Zul2p?=
 =?us-ascii?Q?6xeDNX3w6ZGB+4EiZgPbCevKohPr35wbMRMuphi6x84O1jjcp5zl1VUvF/ur?=
 =?us-ascii?Q?hI6ZPWjXnWu9xrBysy7CsqTngiLvNboicJO2Wqgbx0u1Z90/jQTCzB0AbREz?=
 =?us-ascii?Q?1loIkQYfx5o8RfWdCe4N3wA3K2lbAi4bt9AkHtJuAstLH49Sx8HOlel3Ia4T?=
 =?us-ascii?Q?FFxAPTQKwiDwasq1OKKYyWsOLvFIiCkIpqEowaN1OWPxuR1BvLKiqbD3Zlix?=
 =?us-ascii?Q?kwrv5q5ccFMkfm1juP5k2p8tJjQCtmOh42dkZzBsyuwO/IlHylC3luzpXWZj?=
 =?us-ascii?Q?hRr+pYHmyzi5+F3OTm4rc1gBkeck0lE5CAhCvvyTsz2Q9b5jaCIXADiMof+i?=
 =?us-ascii?Q?24i/qzYsK4u7cbJEeEvSGNlZ0SsI31c9MOdyD1sFwDsfeJVBnVSRk8XhcczD?=
 =?us-ascii?Q?yVed2iMkMuCDlCbxyCA2nNeluyUxhFFeBGqY92HZaiCGFjH2ieJgjg78ui7t?=
 =?us-ascii?Q?1HoicTys5zG1v0TIZsvv/RKBLjnk289od5ASi4oNw9iAnRUwNWFdBpD4KSmP?=
 =?us-ascii?Q?qZIE2Ypz2U0z9JCkBAX06tmTfy9gsuXHp2biN9TuKoxqyGJ1fNQr8dgNygfk?=
 =?us-ascii?Q?s8bgMZxXhEU6Wi+f0zDgeqU/ZAT3TY4rp/JBWU6JF3haQvxEUCXqp/QGn89e?=
 =?us-ascii?Q?dYfcaTVTCwuxgjWO+7GAymKy3oLLrDLdF9UB8qx/exLzWaMTNhO7nqox/o0E?=
 =?us-ascii?Q?zwAIk9m7HiyIB6ckQFsjfg4QbizbOzN9UJbvIbstnasw9yvv7tBYD1l6w1Gu?=
 =?us-ascii?Q?e0k1x90OG/N4ifWCDMb2eC/swnSMZHE/UmGDMxQDPFvIyWrghwmI8XiXyFuZ?=
 =?us-ascii?Q?OBLTeRnwHUdzurGfTbCpKue3DgUnUKhl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 07:08:40.3160 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4bda722-f9f0-43ff-30ea-08dcce42bc69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9255
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

Changes in v2:
- Corrected commit description.

Prasad Kummari (2):
  kbuild: cherry-pick kbuild fdtoverlay changes from linux
  arm64: zynqmp: Remove overlays and add new dtb entries for ZynqMP

 arch/arm/dts/Makefile  | 78 +++++++++++++++++++++++++++++++++---------
 scripts/Kbuild.include |  4 +++
 scripts/Makefile.build |  1 +
 scripts/Makefile.lib   | 27 +++++++++++++++
 4 files changed, 93 insertions(+), 17 deletions(-)

-- 
2.25.1

