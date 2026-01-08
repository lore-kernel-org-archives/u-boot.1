Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB45AD1D462
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 14:37:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53A8184221;
	Thu,  8 Jan 2026 15:37:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="B/PD1pTg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEA388416C; Thu,  8 Jan 2026 15:37:21 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 903BC841CD
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 15:37:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vishalm@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dzAuIqPdY26LGpZAJ3RE6VHu2A/rbhFepihPUlcbmUlQzGzF+x6jrnSH6kK5ZUXpxzAoPESCQM3o3dCsD+vUkRCEEjemBtqljfFnsmKY7QsRC6zqiLJXYaFUMHhSb/xbuzmrpKVD07jotLTO8ZQEBsZBe2LLiYMFaofx43VtjtqbxafOQyvha4sv+LaOIDRL1BLxkBUBnXVLVxiUyXzbtInSm7fgKVacftGX2iVdwxcKDPNB2JFsdLzgkh9/BO8YgZ33Cw5yVaIoNrlMLiqoGuf+o9WAVedD/AHkB2+lb1f/8WbzK1a0vcaNq271f8FRFenHGIG5LjwEAzHD5BP8Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDXhRvFzFlhJpzAppw+qOVuR5ZsCDLq3YoeyWjA42AQ=;
 b=mnAVqgXtZ7u4PBzjULEWxe4CtLwtfW53jUVhtX8CXxRRZF+tatV1rBHaEc121Wp6p5dvH8Lkc3NR8rQLNb3XHCbsKeB85fGzx1nJa4uQXlVHt8Nxwj6pideY56nRAOC0oW17+D/sTxvTAlBxPqDI7DZAOPRxfbWJFSH/kxmfoGmq4RmnIXNSAMHRGfOQN8N9WzmYDOt4C4xJMgxYnARM7Vd3/I5CUHsCcsDpl4T7oKNProuUMFCWVIRrf5m8KJM1l7rkOo0Hf4afggMv3CdxYfxzM0sa5nfWjtWAfMPEYTWMPs++KgEq73fGZBHGDMkD8QbrrPC2ztunhnYJv1cgSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDXhRvFzFlhJpzAppw+qOVuR5ZsCDLq3YoeyWjA42AQ=;
 b=B/PD1pTgTzUGFKGpAMZeejAHp1rAXzNnOxRzoyVN4xjssZrPBmGO42wD7ukT68rTMnuQeiLDGlGzhboFA2Rc3t+1da9TyASmheRQGTiKXmWN4yjNOAruaNMoOr8TZfA/pVt94lpI4eIxEjXhKzwAtnbu6WNQB6CMC9WG4i19GyU=
Received: from BY3PR10CA0017.namprd10.prod.outlook.com (2603:10b6:a03:255::22)
 by SJ1PR10MB5979.namprd10.prod.outlook.com (2603:10b6:a03:45e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 14:37:16 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::5d) by BY3PR10CA0017.outlook.office365.com
 (2603:10b6:a03:255::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.4 via Frontend Transport; Thu, 8
 Jan 2026 14:37:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 14:37:15 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 8 Jan
 2026 08:37:14 -0600
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 8 Jan
 2026 08:37:14 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 8 Jan 2026 08:37:14 -0600
Received: from uda0271468c.dhcp.ti.com (uda0271468c.dhcp.ti.com
 [128.247.75.68])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 608EbEVf2521105;
 Thu, 8 Jan 2026 08:37:14 -0600
From: Vishal Mahaveer <vishalm@ti.com>
To: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Bryan Brattlof
 <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v2 0/4] board: ti: Add 32k crystal initialization
Date: Thu, 8 Jan 2026 08:37:09 -0600
Message-ID: <20260108143713.1130054-1-vishalm@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|SJ1PR10MB5979:EE_
X-MS-Office365-Filtering-Correlation-Id: ea14cb2c-7b4d-4bb7-34a2-08de4ec36af5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|34020700016|34070700014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0UFrdHwnMwlF20rAw/RzCwzURDXAdw21FxCB6FLVP0RzYcoDKTpAHaFcAeUH?=
 =?us-ascii?Q?jgEYOW2DLEZ5YRh9J0Ww+ndZvp6Dnroqjx6Wj6w/KfnusX8Ot3/1tRpK7+y0?=
 =?us-ascii?Q?/2UC/+lsBdcSAoPUwhJc8+Z53Q7HnrkmS8MGK4xcYOcCX6Is1x0JZmQaG+bh?=
 =?us-ascii?Q?hyiP6jD94RWe65Z2iD+Gf+Hb61gOW+JUbUW8we5tuFgu1BsDnyJbhXab+gjB?=
 =?us-ascii?Q?ioGxvJFWkcoYRYJtAEHVPgWNps02HnaRidRN6OkTHhfIDUqPOpjlFl4Vv/CB?=
 =?us-ascii?Q?Ea+Ph+6ucfi/Pwfe5obRjGmLyqDjxaSMjpS6lBRAEZT7Gz4pEnQt96NEmLRA?=
 =?us-ascii?Q?tvUjravtylSm5bnc0H7boVU5+AGh4Y3R9pxs+tAUuG7rYwVsl8cL+ZIO2/0g?=
 =?us-ascii?Q?k2s65UnvVLNxDma+fv9/B5MrusYVXFV37E7Mk1XX46K3JcLHi/PCsuBSwTVC?=
 =?us-ascii?Q?cP9w70zmoIMSu+vqpjjIYhVqifepEw3sUUWbD7JDKEpkxU9ZV5W+HyeAAzCi?=
 =?us-ascii?Q?whKc6E2Jf20Ut17VogGulfc7eu5VxwgLNHv2lls106y9U6T17mE0ScOWvSTj?=
 =?us-ascii?Q?TaV/EJTKJcra8H7G/wjnxuj84MN5zKyPOu3upf9qY47gqE9qPpNo3roRMHRh?=
 =?us-ascii?Q?nqt1Yg5FVRdcdG9bTFiNVmJ95cMH/tsmKDCwSklHQDLBnO8hp8SqDnYBL7Fd?=
 =?us-ascii?Q?L/jxwPqwTln4ZZ1HCpe6I5/2U7bLiYTlBYQlYm1viR4gwyIkNSGNLmmhwVm8?=
 =?us-ascii?Q?EY1KRoyBM+MMCZS/NU6Rf1IVgQzsT3vmNifSkBTOjwEf8YVHLp3+2hR8CTYX?=
 =?us-ascii?Q?tp3WkGEp7aBpF8Xc7tvlV+briVopxWf0x7Y90OyM+ZFz3T6Ix2ojC0chhR3l?=
 =?us-ascii?Q?eLdMzREyazOJf0FxAl2NuPztmBZn3g22Fa9fq7hJzai9XMdK64cLHc/DihC9?=
 =?us-ascii?Q?bL0DbGnOh6p8Vsv+2Eqy/38Mh6dZP7YhfQXSEuQK+23R6ilqrGkYJluNEGSS?=
 =?us-ascii?Q?G4HVLhEdWmSPn/7VA/AVU3oPBGnQgzStTciJivvCT2OEWRnV9mbEffANKFv8?=
 =?us-ascii?Q?IyWlIvwzK7xp37w7o7JR7jzU05exgNl7YfiK8Mpe83EvleS0OuRq5vZTS/dD?=
 =?us-ascii?Q?g05qXBDEWGMGuwlrOxmzP37UwAs2EGRvhsOH2UXA7GLnRIPzc3bumFZK3Krs?=
 =?us-ascii?Q?ETv5oBRfTaQyTmcV/tpLoxNvZpkAn8s8mTK1NnsjlOBiT3CkrTYVGcG4cMah?=
 =?us-ascii?Q?S8qXUxUxfZ4orQnnGwY0g6dlTCv8p8mWIzgYa+0fbPFtJhyE8hVUtrA9xWGi?=
 =?us-ascii?Q?2skQVZf1QD+p+xbNMr2TvnZfM5z5z9248u1hXie/qJ3HoqAJXGduIX7fX2Ef?=
 =?us-ascii?Q?KG0ki5rppsSy2U8iE9ldztuz9Azc3vueVggy6s9uQc5rUxZXEVYIA7FFLKSL?=
 =?us-ascii?Q?oH+hkFuDCEOjtYLrpza/dkQrC4bWUkRA/rHEzVOIxD2v9DaXjivH2UG9mS1d?=
 =?us-ascii?Q?6DdZcoKvnfpPyCk/OiT7gGCT3xOgPJtkzPxpoY5ojCs2LUIAGxzsPcEeH1v6?=
 =?us-ascii?Q?GSiH9b0QOntKdQK2o74=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(34020700016)(34070700014)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:37:15.2083 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea14cb2c-7b4d-4bb7-34a2-08de4ec36af5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5979
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

Add 32k crystal initialization support for am62x, am62ax and am62px TI boards.

Changes for v2:
- Created a common API which can be called from individual board files
- Squashed defconfig and board file changes into single commits

Vishal Mahaveer (4):
  board: ti: common: Add function for initialization of 32k crystal
  board: ti: am62x: Enable 32k crystal on the board
  board: ti: am62ax: Enable 32k crystal on the board
  board: ti: am62px: Enable 32k crystal on the board

 board/ti/am62ax/evm.c           |  7 +++++++
 board/ti/am62px/evm.c           |  4 ++++
 board/ti/am62x/evm.c            |  4 ++++
 board/ti/common/Kconfig         |  5 +++++
 board/ti/common/Makefile        |  1 +
 board/ti/common/k3_32k_lfosc.c  | 22 ++++++++++++++++++++++
 board/ti/common/k3_32k_lfosc.h  | 15 +++++++++++++++
 configs/am62ax_evm_r5_defconfig |  2 ++
 configs/am62px_evm_r5_defconfig |  2 ++
 configs/am62x_evm_r5_defconfig  |  2 ++
 10 files changed, 64 insertions(+)
 create mode 100644 board/ti/common/k3_32k_lfosc.c
 create mode 100644 board/ti/common/k3_32k_lfosc.h

-- 
2.34.1

