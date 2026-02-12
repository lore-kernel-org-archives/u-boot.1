Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB0AEB48F3
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 10:29:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 984BA83CB5;
	Thu, 12 Feb 2026 11:29:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nP8uJLR5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8703183D6C; Thu, 12 Feb 2026 11:29:32 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0A9583D5D
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 11:29:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-joshi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQ4zvJpUjwBmO0DyeKLL+ZQboG1KUJY5Yq5LtYaJX2BWt0sgU9UAdjkcvgLd3hXULcPcoZP7W5bmSlUG+nE7yyL2b4bdFfqsYHSTgmXS0NYfmXM78FEiqEqkDw0tmF8u+A5an7IyJ3joA6Sq3IWDiLb8LDgPh5HdIMrPwcayxe20/1idYSXsPmo4AtYX/cL/LBIWarAW/Czgf0dOXZ9NaNXMKYQyD6d2Vju7N5YisXSy5VnaUcTEnyBb0bRtx47xDYUsKZ2jKsWzSYxdFv/N+d6ZxEgVp1W9EfxSvJvRLcWS8eB8srZPzGQ0N9OcPjT/tbPpIL89bmOrbxDCxUV0Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukvA4o4JcDg+QufoJwh79TTGKAcdq+Sc+jJg7iuRUSU=;
 b=DowVwv2SA3Ex9SkYRAjRN/wcZC+EQ+zsGx6a4ta1gCraxzTq2uJaBaBPjL4kmrD6II4BuATmtz8C1aTznXbo9sLZVff6FdBIGx3gVKn4ew91qmc4XebOyLSvnb9biS6iDeLDxf2RTF9dACaz1cn/sKDbgNmQ/vATZd72d9xjvRRUBmB1GRK0pDimC5Fu5idL1vPVALvUXk44rYIhSWxeLfUuIB3pEQbZ/c05OcQbgEkaC0nzDQIOnWBxXFYN1yWF9Jo1JoxtRITJpLm5toEsqnKWlCYKf2akIKJhbVyvcvD7ygZE5HQjJ/VRsjWxyJN6yHuaHT34FHGLv2PSvEXSrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=phytec.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukvA4o4JcDg+QufoJwh79TTGKAcdq+Sc+jJg7iuRUSU=;
 b=nP8uJLR5NUaIQZ0WJCG1kEXBdS/PEnCYeE9F5Le98tk32ZZPNBrmIz4V1TVfIwn4c6Rzt0blKdIOWxcggAaS9RE2fD9h+AStANdg+9awcfieEBKn98SWoIIViUoIEFK3t0Rfa8xSPCFUBS+s5ly3Im1lfIMpne+Pw0nWV92pi7M=
Received: from PH8PR22CA0008.namprd22.prod.outlook.com (2603:10b6:510:2d1::20)
 by BN0PR10MB4871.namprd10.prod.outlook.com (2603:10b6:408:128::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 10:29:25 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:510:2d1:cafe::f5) by PH8PR22CA0008.outlook.office365.com
 (2603:10b6:510:2d1::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.11 via Frontend Transport; Thu,
 12 Feb 2026 10:29:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Thu, 12 Feb 2026 10:29:25 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Feb
 2026 04:29:24 -0600
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Feb
 2026 04:29:24 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 12 Feb 2026 04:29:24 -0600
Received: from localhost (ula0507357.dhcp.ti.com [172.24.233.202])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61CATNfj2904539;
 Thu, 12 Feb 2026 04:29:23 -0600
From: Suhaas Joshi <s-joshi@ti.com>
To: <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <n-francis@ti.com>,
 <s-tripathi1@ti.com>, <k-malarvizhi@ti.com>, <kamlesh@ti.com>,
 <vishalm@ti.com>, <d.schultz@phytec.de>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>
Subject: [PATCH v2 0/1] Fix regression caused in Verdin boards by 42b3ee7fa524
Date: Thu, 12 Feb 2026 15:58:46 +0530
Message-ID: <20260212102847.1560553-1-s-joshi@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|BN0PR10MB4871:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aea8ee6-a9b6-49a5-606b-08de6a219815
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cTm+vzhjmO3wjUQBcfEtCK8dM0BU4ll2jCL6SYe3YgOif8CV0TXCTWsE1o3H?=
 =?us-ascii?Q?kdvIuR9DNo4lvyH9bBQkaRqgro7xjacIQE4p15o8otxrI91iDbh0sxCWsBb/?=
 =?us-ascii?Q?M4LwUy73IJZ1cJv3ZEHopES3Iz9bgjTA/ATrnYALsubxZeauoNcQUvnfVc0I?=
 =?us-ascii?Q?Al6MgAOejDJSz7+xIdTb8pjQUoj54+lVh6XCaII7zeR4IG/lrrjLFJUkVbWU?=
 =?us-ascii?Q?uDWcadS9kU6SUQ+FKmF/441o4B9bAikYTDJqTF2TvAf1VC2IhqGuR4/Qhrg+?=
 =?us-ascii?Q?hoG7Vfoei1XVD2mHkQDiWo9orAk+302NC32KB92yI3zLnTxJ1vQh9TIbu1uC?=
 =?us-ascii?Q?7RNCDwhV4wemq2c48tpAYZUfhQVJ9JxwW9uh6XN6uOB0uwVeOUkNBth88wUT?=
 =?us-ascii?Q?ABh6uDrVl3pJToeBLiJPkwxdQf23v5dKl1ytUt0i57gxZ/595Nou+j6PJirh?=
 =?us-ascii?Q?x+Do1FjEprz+B/XKLOZ6hXTBAwp/I5PrMscP93utucGCrZfxCrVYbSXehOj6?=
 =?us-ascii?Q?gIVXL4nGlALXKLI65CweRU4xZeM8gt/AZmdWVgSyuY5/Cjkl5XUSogFMWJF5?=
 =?us-ascii?Q?7kRCt9PN3CQpVLwf57cNhgDgrceZuPvQWLFgoX8eB7g9Eke3/H/ZuKNnB5c8?=
 =?us-ascii?Q?v748/gc8/5HsgsAhlZuXtBcp5VkBgLMnFSRMnUngpg7vH3NDiDmuQPiOiGhS?=
 =?us-ascii?Q?GsGXLfUIbFBLYJrKWc1+gU5vD4/TawpZrqgt/Iaoyn1x8i4vW20crVLpZx4H?=
 =?us-ascii?Q?Okyl9lopmMNGmVy67e1Cz0D67Z7lmg8lsq7f1afQ+ZE4Nm1kM7cBXDFmd69d?=
 =?us-ascii?Q?PzeGY68qtssqjpUP28COqMP0He03ZQRB5P/NT8aCaxgtG/8uWk2OQMH6aNBP?=
 =?us-ascii?Q?CAAoDkjUTibAfx0TkGmPHJEhE+FMLy09CzX5CE3KiSAuaA/6FNy35sKOqJmF?=
 =?us-ascii?Q?00qgEf4h0ONUlb4wsDTAdBZf89vj6895JSd1NKaIW7PUy71d8KkSBhVp7Hm+?=
 =?us-ascii?Q?0zHf2/QxY6iQAP98U7p03846MlmRTpyX/MOEmELG/Uz98mOEhFC7oG7GPZaX?=
 =?us-ascii?Q?m+/mkF+RU/swNE30S7qKZEAcJlouk6hhXsww9fotMJy7NYdSIfzomE9qGO5f?=
 =?us-ascii?Q?TlBQH9VlyNcvZIWRqQ/68/AMwcZr+dIov1YOzdxoYYh4P/OMSP/JG21Q82j/?=
 =?us-ascii?Q?HZPO9MtgSlABORFSj7nCu7T9cUcVNXfviInSkzZS2FEuSB0LTOjNGjD/H0E1?=
 =?us-ascii?Q?ri2LHT65V/Joa3YYWy0PZKSmtQ5gi7u+DmoEXpXYnWJUoAyDBWWfVszYj8zF?=
 =?us-ascii?Q?OE/H3TrlMNIgpSOAmFM1FVifummCR6e0negkpPFgfFpufhQmow6M04yvKyJe?=
 =?us-ascii?Q?0RjuFxTQLlzLk0e/Vx7ezWhGSCnLb7ZetC2jJVqidSjs4Xy4FOkLMTD6hfk7?=
 =?us-ascii?Q?GZJ5r3xUMwSnDMSX0nbaKPyXkT8PBqlhGJNEg09oAeSSnqiIeqifxyVpCrua?=
 =?us-ascii?Q?tjjRRWVj2N1dJOB2T+nuSw0dVRrml6ysE3dbNzQbEFnOS3ycHd54go+vfFWU?=
 =?us-ascii?Q?UaHQeYqJVXZWY3qF6hwQ4wJF2pM7i6DupBYh+A8Kp5iI9AEQMcs9+ZUd3PBc?=
 =?us-ascii?Q?BCZkEhVbxovHqcMA9XGwwT289AATZ+r11V3Pp2l190re9n39PdE+IAtks5A9?=
 =?us-ascii?Q?k/B7D6b2LEWduauiE9xm3FQpwDw=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vXADMT9CJ5AR6LEaI/FX+OJrEGAImZ4owSfPrkqTAH8jlqkikQTEw7tq1g83Y4zjTmXH6YFP8ncunND+WTdMIPKxfJFl1hKxX7FceTzeB/6EXzCSOY3aK9Y5ccY6ydC3q5KX73+YDEzgD5mv+VrHkqYMjfS42YpGBVk5lkMldtp0JvoYf0B0rH727ilo5LD9XVdVD6HhqXPbhnDMI2KbSCmTaYTtlpBbw5X7wPtOz77OnymHpsGnpI/Q97o3FIgMzyGIgB1HLHNRffRxTjaq4u8IftkkTNfJEuipk2RFTZCF/vAb4/J/uW9EoXqxhfDMyob69a/+hydW1C9FkqkRuMNLiwR4iJigec2qYMz5gfDNStvWpvCJGNl01Kpdmt5R3FI35x9tFtnxGjvUVemKMXG+a/uW0mVcGoZjtigtc2bB/wGb+hhFBcz6hHeNEP2K
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 10:29:25.0335 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aea8ee6-a9b6-49a5-606b-08de6a219815
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4871
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

Recently, I made a patch series [0] that added firewall configurations to protect ATF and OPTEE
memory regions in K3 boards. This was merged. Francesco reported [1] that this series broke boot in
Verdin boards. This issue occurs only in Verdin boards, and not in other K3 boards, due to
`dram_init()` invoking `get_ram_size()` even at the A53 stage.

This patch fixes this issue.

Note: Kindly test. I haven't tested this because I don't have a board.

Changes from v1 -> v2:
    * Made if-block check more explicitly for Verdin's R5 environment in `dram_init()`, as suggested
      by Francesco in v1.
    * Added "Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>" in commit message, as
      asked in v1.
    * Link to v1: https://lore.kernel.org/u-boot/20260211111328.1481562-1-s-joshi@ti.com/T/#t

Suhaas Joshi (1):
  board: toradex: Make A53 get RAM size from DT in K3 boards

 board/toradex/verdin-am62/verdin-am62.c   | 10 ++++++++++
 board/toradex/verdin-am62p/verdin-am62p.c | 11 +++++++++++
 2 files changed, 21 insertions(+)

-- 
2.34.1

