Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E04CCFA03
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 06:40:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2C5983B22;
	Thu,  6 Nov 2025 07:39:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rOmhauF+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3B5D83B4F; Thu,  6 Nov 2025 07:39:51 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CA7983B0E
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 07:39:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H4kkZRL/tNx3UEbSm+o0frbvEqt60dfV5CXqPKv6t4VcFz1CfdhNyPIBI2QO/cCcBDdjNT7vLo83/TQXgD+MRZmNVMQxOOPODP5raAxWm5itWRCiGsm+5nDnZ1q1hL2koNrnTJtTCGMYLSLbdepuL4AifSzOpYf87WDcrEjDmDl25YDtKfqzaJGOIa96llPqRAXyJ2KVP2idTP7+eTA6JiAA4nHUguaOTPt9DXLRZNF6lM2nN7MYzMRPdm1XnObiJj8en6FQruZEoX25J4bp3RvIIpJxG2mLrtshC7dQpWMwSzksl2MGbHUEYw8dvFn53d9n/vKM8k5fyWThAcxfUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RcXmvxIHXW4K4qBP6StueQpvvejvp49tEQ3WbP1khRE=;
 b=yiXhRSLyY+J1mtq4WLiNzUgneU1nvG/WyE9iRNhDownaC+lRu644Crn92jWbJmBkVIkO3OM9S8DCRntUeMKH/ys2UjPs8YKLagq450csMGV9EROWdud7xmIGowB7kjSpsEYeyY3/z2VofMeEMFhb5F8LkE36/SJczQpdYSYadPJs68OnFgrxYpAAJb4tJlTAcp9EksLCO4FBcRe4gqt8HMfST/vqHo3PnBM3V+T/cTePFQRfOrrgkhqx+kCrp6C0pAarjb4SYOEnWBhnhO9tn9U8UVw2TGHUphTUnIgcQA7FiC/U7Jw19Ohxd7jiDMnEZfRZS4CqFE89M+GSPY9UcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RcXmvxIHXW4K4qBP6StueQpvvejvp49tEQ3WbP1khRE=;
 b=rOmhauF+XhQC0fSkgJB4oVtf0Xy8S/mUGa1d5DijvHwJtOPt25AFFN5Rcrq3KUuvfkAGy8VCdoqik0IqbT2UX7NjZfba72EXDA9mEi1vn0e4mipUgnL4H9qSgoglG6FKg+RGrAuFJGReJwgupj0gfVziLnfN2sxrJWdbzKdZWDo=
Received: from BN9PR03CA0750.namprd03.prod.outlook.com (2603:10b6:408:110::35)
 by SA1PR10MB7710.namprd10.prod.outlook.com (2603:10b6:806:3a7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Thu, 6 Nov
 2025 06:39:47 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:110:cafe::13) by BN9PR03CA0750.outlook.office365.com
 (2603:10b6:408:110::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Thu,
 6 Nov 2025 06:39:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 06:39:45 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 00:39:32 -0600
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 00:39:32 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 6 Nov 2025 00:39:32 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.235.200])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A66dTjI765811;
 Thu, 6 Nov 2025 00:39:30 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <m-chawdhry@ti.com>, <b-padhi@ti.com>
CC: <u-boot@lists.denx.de>, <u-kumar1@ti.com>, <gehariprasath@ti.com>,
 <n-francis@ti.com>
Subject: [PATCH 0/2] j721s2: j784s4: Add workaround for errata i2437
Date: Thu, 6 Nov 2025 12:09:27 +0530
Message-ID: <20251106063929.2232788-1-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|SA1PR10MB7710:EE_
X-MS-Office365-Filtering-Correlation-Id: 606dca78-33ab-4a38-a6e2-08de1cff4669
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34020700016|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VXCM5mIpmaiHr47EaUxtaMSH2+e7Sgo8iBcRX6HPNULE9gh/8NcfnUAbhLgT?=
 =?us-ascii?Q?c7H+ajJNXQ6VaUpjVClbYdDumfLLO8OKCjG3K11UXPsZCzuPgf7dwFV8eAk9?=
 =?us-ascii?Q?tfaTUpPXvNFAHGfWd49vHmnmR15cAzDPLozjp9RC0YYJyP+U56IG+ahvdB0c?=
 =?us-ascii?Q?csv9kg0+5/12mAKuRgcj3DoneakhJBrpCzJPNawmJGSEsuzf6p52kmuzZD8b?=
 =?us-ascii?Q?R0j30dGcxYTKLpRL34wz67yRk69uKMVG7+UfSQUEoZ41tw+QGmIixKCljVHZ?=
 =?us-ascii?Q?zPU3GpvTzn/Y01KXt+q6cM7/WH0+SH9RzyKfOkxacEezppnGE6I5eRGaI7jk?=
 =?us-ascii?Q?h9+k+MUgj1MPzA1A9QzzinER700NkX22sXQhJDVvdhudCcapkgcuWHU1dKru?=
 =?us-ascii?Q?7kyuEfOwJwkzlEqS1Drgppdp72HTuQxLuYDQgIcrCpWQqz/z9bkJpG9ttX6+?=
 =?us-ascii?Q?Hcdw3hIdsaVjEQbiXtUlJ22vkdxGpPAiWMasxWMlJUFGFzLajLyZynvp9/s9?=
 =?us-ascii?Q?qjELgdJKSY0q4Pwm0DzsTOmMQj7rJ2hyzHDFZUmjBvRcaK2Mjs0JM6FyHf/r?=
 =?us-ascii?Q?e5EWr9ugoB6MrQlm3mh1d2MZfFyPGLjdoajUYULZZFU0HHO28iiEu/2G4oza?=
 =?us-ascii?Q?RwlYxCvq5Gu4MadjSPSOjM+/AvjSMw3p0td3iVFrCowGkPLC7xAzBB80jDpk?=
 =?us-ascii?Q?UsVvgt3GeePX0FXg1ppqocrW8RVW2mrf5oOXoiKCaZNNdVVZd4cqqdkvF+zu?=
 =?us-ascii?Q?IlCjnc3mxpb0h19UGWkOQESwg6KbJePM6YQVrj2eNyc58RQnNJ0vFH+IjZbY?=
 =?us-ascii?Q?ytmiXqFTVzjSZ0CnYJarvVHdNEbBUkyK0hnSA2JonsV9gM4JlhP28iu0Ni1D?=
 =?us-ascii?Q?Ki9mko6xJ53hwFD/A4qAoHSxk7VoGCGO1SBHpiXB6ylAm2X4gkoZaGZVxtF0?=
 =?us-ascii?Q?K3FSrVXwyPVRWeY55sg1hVmsA9H/8kTt890RYVLr644oVL2lW2pis7TAUiwC?=
 =?us-ascii?Q?W8djATGUhDPKwIsJ8YQCT/UEmnQlHJ/5+nDZJiC5Qbi+QRut7m9/9X8gOSmy?=
 =?us-ascii?Q?uumXq1WncAGrQAcxzs5jKlMMnuu7VrdXvkohdlkrzI/L6xjQFJnLZzmY2HaZ?=
 =?us-ascii?Q?lkSQHZKECXm42LfZsvy4Py7m66YEeLtQ1dM9r0sS4TCZOp1909ryfY9y5ZZh?=
 =?us-ascii?Q?xd1x20JGoS1MRY75cNjJEyF+eDynFpeBv5s8q5MQ57+kTG3lh7yFmN9NY9YG?=
 =?us-ascii?Q?wX+9G3bvRk9jEtnj2tT6/tkQk8clScGSExtF8+KRw020gVBu/6dbPSg1wjY+?=
 =?us-ascii?Q?u31+EkqFlqsRVYfZ0sqR7l8OcAhJHam4bbpyXjyB9Tarz5bPm+SsQhOYWO5N?=
 =?us-ascii?Q?sZ/UVTYVPzPLtSJAeMTI2TLaOzOBWIu0KDyRrD+fsUtwxiy6wcMo4S0Yc1ls?=
 =?us-ascii?Q?Y43QMG9mYUelZc/smYZWSbXh9iQKTlZwMF04/b3rVtYHhl234gwP0A1GjfAc?=
 =?us-ascii?Q?RdbVY/11/i6Kvr/nd0D6u29gTZA0xHOUlH8hXj4fXC40vU5i80qLiNC3S6px?=
 =?us-ascii?Q?VnxxMQw+Fvq9RAyURB0=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(34020700016)(1800799024)(36860700013)(376014)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 06:39:45.5621 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 606dca78-33ab-4a38-a6e2-08de1cff4669
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7710
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

Add a necessary hardware errata workaround for J721S2 and J784S4.

Boot logs (with LOG_DEBUG enabled):
https://gist.github.com/nehamalcom/54b466552b3e1b5c85781be33c2ed0eb

Neha Malcom Francis (2):
  arch: mach-k3: j721s2_init: Add workaround for errata i2437
  arch: mach-k3: j784s4_init: Add workaround for errata i2437

 arch/arm/mach-k3/j721s2/j721s2_init.c | 39 +++++++++++++++++++++++++++
 arch/arm/mach-k3/j784s4/j784s4_init.c | 39 +++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

-- 
2.34.1

