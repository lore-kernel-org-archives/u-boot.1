Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEFD6C27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 12:48:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 625D5889E2;
	Fri, 14 Jun 2024 14:48:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aZ5GRBkW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64EAC8857B; Fri, 14 Jun 2024 14:48:28 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::62c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11D48886B9
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 14:48:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gf3O0Df1U63zue4zGGMfq1InglakVDO941JGNkDiwHQuX6jZltind47fY0h8f8v8ues8GRM2aLrmR4rAluhVdF48XIUTKE/O0yBNQ4TjUc7gC8YdQR2OZ4VrF+5TBnq5aj+In5/wahGAMFrPHrJ+G9yi34y/LC4J/e2WVan+fU9UjvtMzDjRpG/zZFjAmuMo6REvCunGgbcuXqB7NRp+7Fsxufm0s9qalozUYQYpXczZKRMhJFDWchHOZGITYr+GeR/WDWPdAdHu0Z1Jp8INfTm9IHHusYbvRVeZK3OvrSeNeUCA7/pRnQdIa8aJo6HzUtYbsmjXG+KuTEriF2dZMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yspirmXAFrFBN3ghLfUX/5FVO0UZYSflJYxGPKBMkTk=;
 b=oPACwjYLnuc1pPIi92rBPcDCluL665TcxrjBzqia17ZyjhM5BQrTq97yvtZXFl2yaQ90p476K/wE5Nlg2VE1goJ+d2e+jaYJE4X6I/Y91MWToJWLzXvRPrsZRIxuFHWh6Ud3zZ3vppWYWnUEXYGC/wQzdJ3qeFkAwPj+ERXIES/MsxQ1IljWSxemlhVr5aIy4tv0pmU+8h4uEsNhNQi5w4itAy4prb+SFjlvw7wEruz6xPqihmPQig94tI8IoJVzakBbUq20CIb+43rAwFCwgS4/mGpGygax24BvCvT1RSMUpFSJs5sopsOU7Scm7+lbQI5xC9KGN7LLjhCCltcAFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yspirmXAFrFBN3ghLfUX/5FVO0UZYSflJYxGPKBMkTk=;
 b=aZ5GRBkWKuFY43+ZzcH1ADvQAY0Kz32S3V1OO5IvbDHjorKf17HLFKX88Cj2ySIrYFEO0ZEhkIhAdvBMhr+5kKHMoUmSzBaweLdXxs+o70jIrHdJTbg4tfzdqoZbW3qiGGMo6RaF5b15ZQeiXKHtjmKU8T+5AjuKTJHcyEeeBmc=
Received: from SJ0PR03CA0141.namprd03.prod.outlook.com (2603:10b6:a03:33c::26)
 by DS0PR12MB6655.namprd12.prod.outlook.com (2603:10b6:8:d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Fri, 14 Jun
 2024 12:48:22 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::c8) by SJ0PR03CA0141.outlook.office365.com
 (2603:10b6:a03:33c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25 via Frontend
 Transport; Fri, 14 Jun 2024 12:48:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 14 Jun 2024 12:48:21 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Jun
 2024 07:48:20 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 14 Jun 2024 07:48:18 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>,
 <trini@konsulko.com>, <vigneshr@ti.com>, <git@amd.com>
Subject: [PATCH 0/2] env_spi: support overriding spi dev from board code
Date: Fri, 14 Jun 2024 18:18:09 +0530
Message-ID: <20240614124811.22945-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|DS0PR12MB6655:EE_
X-MS-Office365-Filtering-Correlation-Id: 90d6cb59-1b4d-4677-d3eb-08dc8c704647
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|376011|36860700010|1800799021|82310400023; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?85t+kQ7XOR/0Fe6dU82bXvIGGo79zMCcm4jnBt3ds4zS8/SFC8xJ6RPNheZd?=
 =?us-ascii?Q?lDMbh72ptObFJTq+CzGBwulOYvT0nskJbNA97DmXcRlr0Rop8zZS5Cya80DW?=
 =?us-ascii?Q?qTMWvEmYOwdxZA1dL8VpbrxcTh+W0qJyFxGtg3tRi9fSajvnMYvRH9v1cU/7?=
 =?us-ascii?Q?WMcnJTRDUNZcWxi6al9HbaIElDrHxF30sJTV3Ngc/zc7njKUHVTNOkmHOuuy?=
 =?us-ascii?Q?zxn1cgVctxzZ0zwt7+bSbqDrF/UW+UjyW0+9AOeysyi4WYLVPHttOdpZh5HA?=
 =?us-ascii?Q?7A3YFM4lvOXzTDAZzPOD2JWOK+Cv6n4w3+ECf604PuR2jAHc/OgAAH75MYni?=
 =?us-ascii?Q?vqh6VfNKFjVN+6pZipwPFvvyEUjcBHVG/SIgBi3NOpB8rEBXsscQnECrWaKO?=
 =?us-ascii?Q?7JYr4XAseV6PCOuwf7XPY4LA2znHOuMV+7y5VND61FWQfokU2WTIQpkSO/q0?=
 =?us-ascii?Q?VTgT9QvnFHINVmrOP0+LYGqkXDJdM1+UUkkJy7OMw2ZaQmlmxFOSOd7plEP9?=
 =?us-ascii?Q?O/90/g7sC6Fwluz8bVN69JvlYn6Xc3IQ9oItceYp4bzZFJms1TH2Ln1UXLTY?=
 =?us-ascii?Q?OmL2f0CWtJCbzGRTMIhwGNpMPRXzM0OywKzpybwXVl3KYNQ5Uph/A9QSDbvg?=
 =?us-ascii?Q?BL5l6UbwqdYokjC4rUkcnRl7ZgHiM51Xw/Ur2eaqss+fRCBhJhPYAMhL42tx?=
 =?us-ascii?Q?7SzG5rkrDMlrsQ4C4XWJo+ROrc5zhO6FwW1GrjVAsbrlWvmFxeS8LYur+usu?=
 =?us-ascii?Q?CBy6ZtRUElQjXaoXmPu8o8h+hd6xKov3MmO5fyvbk0oPuhHWPLH1iuVVIyYK?=
 =?us-ascii?Q?D1JqJwBo41rz5fRPCmcHXpHFqUttvlxoyaccbLOiq38P4ZbM/0OMghh00lfY?=
 =?us-ascii?Q?qglrB+db9cs9nOdMQZ/lb/+6CzzOCNvk5wBWCfZvhTL+OE8czku2CJ8nP6ph?=
 =?us-ascii?Q?2fPY7TOIROlDp+0Dr/kL10dg5pizQgcBIQKwXeBJ6v1eKCv8l7OKQ+sQC/6e?=
 =?us-ascii?Q?fDP2FeTpbPWvzaooNWR7bna9DgKfYRsbmyAdo4PB7cNkYnCJAXzmN0ibnNFe?=
 =?us-ascii?Q?e1hq7F9jJsLRpssbdsrZh+TozTZIiRP5wxVEy0UExD88b8Y48BxpkUEn2lO7?=
 =?us-ascii?Q?zNaH78Zzxbv06/54S232nvgb4X6LXiUVPk8oOhqyGMiAq3IeBUhDKrDnqDyh?=
 =?us-ascii?Q?lHrY88Xm57mGAV4zD0YNiwfpKmNF1y7ON0WHXqD3fhzWBDhD3fL/GpqgzW+M?=
 =?us-ascii?Q?0dTt7H32cnObaD8t8Kh1xACEcxWdGGeIO8qPlWdOuTdyeEtcuw7WFJwOyu0z?=
 =?us-ascii?Q?Zs/qT6//4D6DhQP4AD35ONJxyoU7fa9HhHfsJJkm2xDHsAwMYTzwZpMb9vl5?=
 =?us-ascii?Q?RuwJQa6pOnlf6We5RgOVHOFcc1djkunfSs0qDVYBpa6dZpjPbg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(376011)(36860700010)(1800799021)(82310400023); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 12:48:21.9668 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d6cb59-1b4d-4677-d3eb-08dc8c704647
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6655
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

This enables boards to choose where to/from the environment
should be saved/loaded either QSPI or OSPI based on the bootmode.

Venkatesh Yadav Abbarapu (2):
  env_spi: support overriding spi dev from board code
  xilinx: versal-net: Handle spi seq number based on boot device

 board/xilinx/versal-net/board.c | 45 +++++++++++++++++++++++++++++++++
 drivers/mtd/spi/spi-nor-core.c  |  9 +++++++
 env/sf.c                        |  3 ++-
 include/spi.h                   |  2 ++
 4 files changed, 58 insertions(+), 1 deletion(-)

-- 
2.17.1

