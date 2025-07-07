Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3964DC8303C
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 04:06:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B31081D5D;
	Mon,  7 Jul 2025 06:06:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OG0uGlga";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E01D082FAB; Mon,  7 Jul 2025 06:06:26 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::620])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9495F810EB
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 06:06:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rlU7MKCSEHJxZWgp61hhRvyDhzxu3el4jWaRNlRbNuIEG9HwNiRYrl5FD/BPJf9uegEmTipfhYJdD23mOkEHxSDJxbHVkVzc6IaE4eH7t7eVfbrstmST50/Zz9IIyAcyDwwAIbc+KuTwec1FPbSq0xMd5zKGkA4v0uC+t4p5qlU6boHPZKnmsRAeIoCPsSsZsa1zfO745N9lOdQs2kW4I2pUgrmBZKWuUr0QAhKfmbTmFCnAhgs5phE0c18ofavH1CTCs6j7891pTDhwnccG/zbwbirlwjS3bd+NB6Xfw/exdEdBF76bA/n7KcoDUv9hv95W33vqGaKEoGyMcME65Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fh1v68IBBb6DMEB/aSFEU8ixruzADExX3r5w9xhhAZk=;
 b=WE+6Iee4ocj8UbbrpM8vvaXTTsduUNee2mN2QfT5DjppLShNrS81b4WRjgNxJfYHPLVubqIxtv2go1zKv6WjAhfKA3bjbMRmQfbM37z44Xg1e1m4FNmOtc8anvSAcSkA1fYg6x2IU+4fag6rLzt0nfbbmuduRHOboiFAgBEm23cOA9ULLZ5xG98Go4MhwLlsiq7vRpqBqlFvz/kV656y+0a6cNpZVxtrRFGMN5a9CByxu75Z4yz0e153wu44HUjWGRdzjGX3xoxmcoBN8EOd9J3nKJn3aL2m/dIUgRvTik0aQF5YXDpWakLD8gBit/5mBdq7OHzqXEa/n2o2eO6wlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fh1v68IBBb6DMEB/aSFEU8ixruzADExX3r5w9xhhAZk=;
 b=OG0uGlga+gPBy+ftKIeuyBHa2GttIVQzzZMh2fZu8H8yQDj0gkbzZQc6yX5hf0Ot69bF1e3N7sTZ2CqcMbiJsB/i4msebIP9lbIsFZTy4/aCW8KHA5+cD9TU2UPnhSmeC53gN6M/tLiDyvLkdrSbRr4zUF5oenGqQqmXL1QJMDs=
Received: from BY3PR05CA0023.namprd05.prod.outlook.com (2603:10b6:a03:254::28)
 by CY3PR12MB9579.namprd12.prod.outlook.com (2603:10b6:930:10a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 04:06:21 +0000
Received: from BY1PEPF0001AE1B.namprd04.prod.outlook.com
 (2603:10b6:a03:254:cafe::2) by BY3PR05CA0023.outlook.office365.com
 (2603:10b6:a03:254::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.19 via Frontend Transport; Mon,
 7 Jul 2025 04:06:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BY1PEPF0001AE1B.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.20 via Frontend Transport; Mon, 7 Jul 2025 04:06:20 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 6 Jul
 2025 23:06:15 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Sun, 6 Jul 2025 23:06:14 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@amd.com>
Subject: [PATCH 0/2] versal2: Enable reset and poweroff
Date: Mon, 7 Jul 2025 09:36:05 +0530
Message-ID: <20250707040607.758919-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1B:EE_|CY3PR12MB9579:EE_
X-MS-Office365-Filtering-Correlation-Id: 39c69046-7793-4a01-02cc-08ddbd0ba188
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8iaIlVbDLnaLdYWjXEYGNRnhl0+ingkCvtepwu53Cg5O9NPqe5pe3hJtI57A?=
 =?us-ascii?Q?HPzaK0AbMT51UemBY+fpPG4VBUPaNc+Aj9EI8iZQY5zCVjoY6MSWF/2p31Rt?=
 =?us-ascii?Q?8qh9SCl+4SOC9JGIO25iqlewjWa9LA1k836ZLfdNNaGMHWEoAK4oMNiIDVOB?=
 =?us-ascii?Q?7A/JP7fmzjG3JIx+O58gw4pRamd7+jEHb8oszMdXyaxnePwbMMexEGENcRYe?=
 =?us-ascii?Q?0UcMWh7LvckCAG+2cIJGJJAYdKbVaTBF+GxQG2bDTv9ZIdvJoj2ouMXxGl28?=
 =?us-ascii?Q?R3+toHR/ILts7CiaXS4bWxlEPUhVMcyfdQr1yy1gY5EMvPm0S1BCaDa7dDSM?=
 =?us-ascii?Q?JJLsNnJR4gs5H9CEaN3jHgvXbvI9Q1t6wNPFXmZgbND4o/R1q7QrZGb+WV26?=
 =?us-ascii?Q?H6BOQ/JPOJxaBdNfTBFv1jeahM66UiR6qodNpdwTbbX0rjeAaVs8hAYirL5T?=
 =?us-ascii?Q?71OIQTaFy7vG4KQEO0YLnSxNZ22pF07uPTEe7HTe7uTScWQog/iuUUZI5Zm5?=
 =?us-ascii?Q?i1/PYWqzJyR2gdd79F0MGJwT86aZDdx7EfEyWj1NcBizCXZCm7arxIcFM+yO?=
 =?us-ascii?Q?q4v99TTLiSSFffDUlz8CSPv7BG7eTweeYAmdBkm03igEmhGvGuwWI14dw+9Q?=
 =?us-ascii?Q?PJ5LkKQ2aS1tUE9CWZo2OAxJr+9CkWPG2qziE89G0t6XK34hdyR4+RFUf/Kr?=
 =?us-ascii?Q?QeUQPusK8zBfcTbkgWLqH3+VZSxagMiMf78quDSLUQsuGU8qw0MQw+XS5q0u?=
 =?us-ascii?Q?lf2r8YNdHD1sL4ektbTZBWoQHK+Wsb+hF9hU4KjSMvBmLPexvOaTWSsaDPCk?=
 =?us-ascii?Q?D2rMN0vOZIpnKzERu5nXc/roSPTeq5cC8lGxFE94P33yZFRdMb2XKGkukLBg?=
 =?us-ascii?Q?8m3QemS9WC4Jh1hek9do8u9istt+UX0Av+oJn+jJ/CQIdjSom1dzmlyW9xuz?=
 =?us-ascii?Q?37zYEhmWB8qPPGv3n/1I5YC83O82Ve6wPEB0ltFKNKGDbiJayZBMdms+aZu5?=
 =?us-ascii?Q?w4RAflaQZHWNbh5hyUACi3aWCTcy5OruLhy9nYonRR3CqIQ9XVO+z0J7RxGL?=
 =?us-ascii?Q?C/yGVxrdzDYd34iDIVagWY9lXZTob+CuONx0Ey3IdYa7MfGwq5jyyw3tJpPY?=
 =?us-ascii?Q?ssoVuY2eL2oKalZ7lLdSXaIMjsozPK/glIYmZg7qeDrH2bVGbRi/drpw84Vr?=
 =?us-ascii?Q?V5yFp1gbQrn1XsoFbJW5ajCvIzx0q9jJmFJuSS+t6GNXRxHzSKXUprTMAaJN?=
 =?us-ascii?Q?olRXjBtFn8jPYZW7pF8C8qpx/D7jtFEGezSe25bN1a9aniy0C3i/Y4yvpUbv?=
 =?us-ascii?Q?PPsMDEyc23/KOrWjTb1A8cEGtPktX/1zZroR5wepdjaD3uqFGHMxDy7fmWcb?=
 =?us-ascii?Q?3KqRWAXqRU3Q2BmEhz37im5vhcs6dfBuBu+rbKgP/7ZnFXwgvMEKz9+58LwY?=
 =?us-ascii?Q?Uqfjbw3DrcqbhRpSyvjZmeEAOGJxY7e8keukGsFSXkeQWtgY3f2nPfOE87dS?=
 =?us-ascii?Q?O6wnlPbtEvJ0CPowTAniHzKARbGM6p5h8Sgx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 04:06:20.7459 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c69046-7793-4a01-02cc-08ddbd0ba188
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9579
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

Enable reset and poweroff via sysreset framework.

Venkatesh Yadav Abbarapu (2):
  arm64: versal2: Enable reset and poweroff via sysreset framework
  arm64: versal2: Do not define do_reset() if sysreset is enabled

 board/amd/versal2/board.c          | 2 ++
 configs/amd_versal2_virt_defconfig | 3 +++
 2 files changed, 5 insertions(+)

-- 
2.34.1

