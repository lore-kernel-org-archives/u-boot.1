Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D4DCCF58C9
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 04:18:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B44CC89320;
	Fri, 20 Sep 2024 06:18:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jUy3QVV8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C44389326; Fri, 20 Sep 2024 06:18:22 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::61e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E41388B31
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 06:18:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s7BFeWThpS/5SOQ0HG2upRKsrtIya2+dJGBB2qb+Z31T//J1x6h5i6BWnsGQdLId9PkkHS5Lj2qyfzO6slfg4lrkPQflbVR6HVlSpF1wZFnRXoOiTJTJqcEeTAAyr30z3BxU1N8JzM/o5w9xDqBuPhz4OMDgYBghCXnzuJnknaRnW6qoGS8GvoGvFAXqcoG/o3IkZLJgJB7usBo37T1Zrw1/hqhCspuTKph5L0MZwCMo986BRAwIcQszjUYUKijeU5rfV4cyf8LOzIcid1mLQXT6vu1qXVYjpmmZDpBA749ODhIQ93N9cAaW14963xSEjwy4i0jwjWloWc9b+xtwaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6R9bC9/oeXP4FsRDYEdYJ76libBGA5PbzHuSRYUjaE=;
 b=pXj8k1L5FY37hOqduCA0hcrVnaLarDhbSEdWU3kAzsWNl/z+W2eaQ1GInWNfhrDmcTRXZ3whPVzzxLLhL3tUN1GBvPu9cT8tY92Yi4o/ytw0EMMOA1zpheq5QmbNe6qRPtrXmg0d/go76JrOdsR13p+iXTB1PomFHNQJ84gb4dQzDrURUdB6Au7wni8dG9rJtG7DeVkLwvfIl9LV1LYBr/nbCGRXvyeKOoUfO2z/gLoe815bHO2ak0eCHiF2ggEXj9IQGAazWUiQDTurTkLJB8IFs/wDfsS/qnjJ+5KLa8PvtExoKz0g93Fv2qJCviXhZMzjpnbr0yTyBsO/SQ7faQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6R9bC9/oeXP4FsRDYEdYJ76libBGA5PbzHuSRYUjaE=;
 b=jUy3QVV8yQjpBwsDGIBhTTyJuLFPan8uMNATKJgHHNVsKeP3ypi0AkS8X2BRL66ymtx/UWzQAiqBQZGc5tWFOi+4+afEEWvROIkoa13b/ubxbtmb39cMek1ebTUNqD+RNGTidDBdm5pE3VJgRTJFO2ZqQ+O2r6WhnPDJVp08S1c=
Received: from BN0PR04CA0010.namprd04.prod.outlook.com (2603:10b6:408:ee::15)
 by IA1PR12MB8406.namprd12.prod.outlook.com (2603:10b6:208:3da::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.26; Fri, 20 Sep
 2024 04:18:15 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:408:ee:cafe::50) by BN0PR04CA0010.outlook.office365.com
 (2603:10b6:408:ee::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.25 via Frontend
 Transport; Fri, 20 Sep 2024 04:18:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 20 Sep 2024 04:18:15 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 23:18:06 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 23:17:07 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 19 Sep 2024 23:17:05 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <neil.armstrong@linaro.org>,
 <bhupesh.linux@gmail.com>, <n-francis@ti.com>, <git@amd.com>
Subject: [PATCH v2 0/3] Add AMD UFS platfrom driver support
Date: Fri, 20 Sep 2024 09:46:48 +0530
Message-ID: <20240920041651.18173-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|IA1PR12MB8406:EE_
X-MS-Office365-Filtering-Correlation-Id: faf3dec2-2643-4fb9-e534-08dcd92b3fc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dWR06yAKoP2FH2Lop+Dof+ag908qp68tEMZaT7QQk6F15fIN6MZsnxgh27bg?=
 =?us-ascii?Q?YiXlgc0h7rHZOZp4TKDQA30L/zQUp1ckbi5JrxjE/vEXC3Glf0/SQlrl02ia?=
 =?us-ascii?Q?eN7iO6B7OhfhI2MEJcu25uUJhkvHLndZSplWlSEX6Z2ubHcAQPe7U8QyAIAt?=
 =?us-ascii?Q?AYXk61YSramqWM4Da19JtFanopIWhsfZvejOmaeQlqosB/S1tNfkEwFwaa0s?=
 =?us-ascii?Q?ew55QpWRsCY0G1JzmP5xzsNRIWhyceMrisIi/ZMqv3BSw9KLnrzINYmMDm5b?=
 =?us-ascii?Q?mRoj68YsNcgn6P+oAB+ZlLLwff4QtP8NfoHtTTyyUWs7I74KyFUSuOyy50fK?=
 =?us-ascii?Q?6rTMvcN1g8qzGxoDLjhJCFxP1WKvXb4OLM9A0uXqzdT/XfRwvs5s23rr/h7A?=
 =?us-ascii?Q?Htfyciu4csoOe3HQ0de4A79B4V3fwA/44nCWMxAnBgAq51ZViVSiGXH9lmzN?=
 =?us-ascii?Q?UbPh8ilyXUTNjx4SMv6Lo5T5LxZ4gwUuG0GxxCfxJTMaiW/JthyalrE13LVD?=
 =?us-ascii?Q?eo9SpvVjzdX1sVL51fp9rc1ZsdQ11mFwXP8A50sW1TNBPooHtS/Utjge8pKB?=
 =?us-ascii?Q?T0asbrJK3XSIp32trsys7t6IBcF0K2b4OBZtTEdNgCPJKlGo/EQjDBc80CiE?=
 =?us-ascii?Q?hXJuBTY7FpvbjJfKohbTLxLFw7Bz+4Ck97gqCp3Z02KJEVLERe2xlU5VDbcv?=
 =?us-ascii?Q?3Lsrj7RAvPBK3V10cRNavW2ZN6dggxemZ6l1InBu06TdapWN/2RpKwN87fUB?=
 =?us-ascii?Q?BxsYvwVswq8/yTpamJRgo5K3eb0ofzYInFsMDhFVIRjnRPjr9N9Z+1IR7FM8?=
 =?us-ascii?Q?7AbmO4D7uEKyKiF2RSjG4vKs/jK209SHwiHtlkZVXn4hNzv2v3hiYJ4RCj70?=
 =?us-ascii?Q?0d25HF99EUdD6uMNPLom+8fbntxfHeVSSreyeWC2mvfMWB/DOn4jVL6bTqzA?=
 =?us-ascii?Q?691utidGz9HmZLNLB8B5DFaF5WQjcZZhM0mRWSc/+xsL5US2vPBofj+e8jmG?=
 =?us-ascii?Q?EaxF0NBYU4m+zZ5GsbI1+93JA1iQ/ML6lM003ZtF5MgSLDayMljJovfWkYwF?=
 =?us-ascii?Q?pa0dHK9A7ZmqXNYTZpc9Jp9Dcd9I0AcjFFc2H7McjinsLQlGiqA8t04aSSQF?=
 =?us-ascii?Q?4nwGVA39I9n8KC6cOir6PfYwf+raBhOfrV+W4fEEnKD3KU1cnRc//nr6ZqEh?=
 =?us-ascii?Q?YOicdOLCmubINCO+XZtfTIhHaLPKKF++z+jUxp0mf4YWuxeDRPVl3JIPKnZl?=
 =?us-ascii?Q?bdaBabqSbHFduI2YAxsWrMhA2qiDgirw8lpSGaP656DDiyA3Fp5kKfYPZd93?=
 =?us-ascii?Q?aIr3yi4w9WKbeV3gibjVZu5UfR7GJ6fIKxGx8qx9UWZY75HpGk1iVTAu6/Af?=
 =?us-ascii?Q?KQ/5WYPwBmO2WYumGqJQyLlg/LQu?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 04:18:15.5716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faf3dec2-2643-4fb9-e534-08dcd92b3fc7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8406
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

Enable UFS DWC controller driver support and add AMD UFS
platform driver support.

NOTE: These changes are rebased on top of this series
[PATCH 00/13] ufs: enhancements to support Qualcomm UFS controllers

Changes in v2:
- Removed the ufshcd_vops_phy_initialization function.
- Removed the ufshcd_set_link_active function.

Venkatesh Yadav Abbarapu (3):
  ufs: add support for DesignWare Controller
  ufs: ufs-amd-versal2: Add support for AMD UFS controller
  configs: versal2: Add support for AMD UFS platform driver

 configs/amd_versal2_virt_defconfig |   2 +-
 drivers/ufs/Kconfig                |   8 +
 drivers/ufs/Makefile               |   1 +
 drivers/ufs/ufs-amd-versal2.c      | 501 +++++++++++++++++++++++++++++
 drivers/ufs/ufshcd-dwc.c           | 133 ++++++++
 drivers/ufs/ufshcd-dwc.h           |  69 ++++
 drivers/ufs/ufshci-dwc.h           |  32 ++
 drivers/ufs/unipro.h               |   1 +
 8 files changed, 746 insertions(+), 1 deletion(-)
 create mode 100644 drivers/ufs/ufs-amd-versal2.c
 create mode 100644 drivers/ufs/ufshcd-dwc.c
 create mode 100644 drivers/ufs/ufshcd-dwc.h
 create mode 100644 drivers/ufs/ufshci-dwc.h

-- 
2.17.1

