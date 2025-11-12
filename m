Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8060FCCFA1A
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 06:48:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E861783C54;
	Wed, 12 Nov 2025 07:47:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TTJdIsAM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F10F683C54; Wed, 12 Nov 2025 07:47:53 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02A8583C46
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 07:47:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JdXfErZuJodKKf0lveGaO+A80SppBm9WapvfDdSORdwhLXmwIgOqJT9tREaOVX0S/YOGWOnkq0MQsdUq4NNvtnAne+1DQc+at+xIeJcDkkVUdol/eLJjSP9WObCJrFcCn/8fmXQ8OqOO+briOBhzV1fskPCnBa1XjLYlmsylEldPDBhftVXM6S3sAbT+Fi0V1EEOWJ66zWqBDtv+YsfFClWiwQvaA0ZYj2XI2iraiBqs9U2FyyFoZEq6z6Mf8dPri2KCpNVQWoGYwDMPcGUrX2Vp8lrA1HMrFZSX16JwEC7Wjy/Pgfvu4deF82jRut5uqEG7OP2sLr3YQ4DdmeSaRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2vpFSX3slLQaUw25wqfn57Mzw13fPGQyfY0QsLk1I0=;
 b=ch6dIpdPfehaDlEmNrGFMxnOtUxNqTq4qUvuYCHnQaNG5zccmRWE+zsIz3SJYKNcPPdthypRsrou4SyCyK3iV5kyROvGVzKRvQl7YQkNBC7ML0F/GQERCTd7NjMP4sOinzz5VaEwb52em2owvJgTa0B3LHKzT7jsDm1I1AyyH4HMKu7f8U6qIKMSSoGPmaR1OoaeFiMv9aak+4hSORKEyDHNdWk1DHXe7zvpQyK0TudjisnXsBbooUWmb6ViBUpql7JpVQSx5lVUNXUWwDBXzRTWo0hUpa7cYVUzJk6FBPNNWSakOjYR9N361TSYBIOZlxiHLUEoQO/pkyr9Zn9H5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2vpFSX3slLQaUw25wqfn57Mzw13fPGQyfY0QsLk1I0=;
 b=TTJdIsAM69SUGOPdchLCNcajx8wsZYmqDQCzcYCSgX0gsr2ppsmJL0cRDAnIi1CZzZwP5vkCMGY3N8rgs/C7FGuTGDkAtzgyEQ0I8NhhMTRULq3egHJu/cnOaO5K87uhSD19DKLy9jFey0mZVfzVEXePqOKUV4/3HSXzBDTP0ao=
Received: from SN7PR04CA0052.namprd04.prod.outlook.com (2603:10b6:806:120::27)
 by DS0PR10MB6127.namprd10.prod.outlook.com (2603:10b6:8:c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 06:47:49 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:806:120:cafe::96) by SN7PR04CA0052.outlook.office365.com
 (2603:10b6:806:120::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Wed,
 12 Nov 2025 06:47:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 06:47:48 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 00:47:41 -0600
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 00:47:41 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 00:47:41 -0600
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com
 [172.24.231.157])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AC6lPoY2217584;
 Wed, 12 Nov 2025 00:47:37 -0600
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <trini@konsulko.com>, <c-vankar@ti.com>, <u-kumar1@ti.com>,
 <marek.vasut+renesas@mailbox.org>, <n-francis@ti.com>, <peng.fan@nxp.com>,
 <semen.protsenko@linaro.org>, <s-vadapalli@ti.com>, <jm@ti.com>,
 <m-chawdhry@ti.com>
CC: <u-boot@lists.denx.de>, <h-salunke@ti.com>, <danishanwar@ti.com>
Subject: [PATCH v3 3/5] phy: ti: Add config to enable J721E WIZ SERDES wrapper
 at SPL stage
Date: Wed, 12 Nov 2025 12:17:23 +0530
Message-ID: <20251112064725.1049199-4-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251112064725.1049199-1-h-salunke@ti.com>
References: <20251112064725.1049199-1-h-salunke@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|DS0PR10MB6127:EE_
X-MS-Office365-Filtering-Correlation-Id: bb79171c-f723-4521-d35e-08de21b764c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ov29rkYw65hQdx/lySt9O9W/z08tMQX756T3KNZVkzSiWRUmemhCv5yXqZBR?=
 =?us-ascii?Q?UO1Rr0u+Ruk2T3EOgt0VPFn9Hs3iMzbq6KIUcSTEh86qdtg8Bf93ZMW8OVEN?=
 =?us-ascii?Q?G37hKsy9zCf+1iwUMxRfUQgnVOjtz788I1uKsdcEErqrmynIrKPZOGHNee0l?=
 =?us-ascii?Q?RC//Nx8W8fzQhkXMuTMzE3eNXsOU2nUTd6jbI5st6ODh14ihjI8NxEPxF+Kz?=
 =?us-ascii?Q?T96LLqXakX70E3N1pfqU2McFRL6jiVj27R03XCdWd8j3t9gAsczbXe7crdT+?=
 =?us-ascii?Q?FY+1PHiWCx1h9JqA2Rojafzh07EfnBjPm3OUIqdHPsnJHLcFljRFf26reonk?=
 =?us-ascii?Q?Ps9dAqP5RsDONSBRiWPdlKo10bLr9k59kp3M+upplrHg3kF4Nynpf+F88Awt?=
 =?us-ascii?Q?kkLfe6r0FtgxCjXHKw999LRpTncSYlogm7NmRu10KeDMsUnbiFGHwuhY9lLb?=
 =?us-ascii?Q?0vT7BtfPr3nNztw1ktGLjSKt39ELgsWY8FjSTN3K0MQSKAmBpE8U/lX3Dfxp?=
 =?us-ascii?Q?PtDxKLu1k/4wVGrUs/TBUYdaAjGNuVkRpcDajcy/OhQAIuu1MTzJWCsoGb53?=
 =?us-ascii?Q?Y8OfI5WzfsEcLovfjC9vqurgAVDFd//93Ez/lIRAOQAjTw+MkyDHob/NA3pa?=
 =?us-ascii?Q?LKmT7CAAL19cSRkZSS+2bFZLJa+bMxpCF1Exlk8cwGke9YpV4n1MiPrJHBpe?=
 =?us-ascii?Q?HuzJQwUZ6tVgseCj3OvmoQRuCyEWYyF9dnNIRjoPu+0Db2IRXysuqWtwic3B?=
 =?us-ascii?Q?Q4ZSJ8dY400bMuykEjrffXM5J0dLcX10YL0+P7lMxCELUCBwD29bNbY4KUs7?=
 =?us-ascii?Q?T+HBiuhLDGKicLLr1CNKHCiqYZBqn5aAw2cJWDiQCupgKGR8XOna69xVxAhi?=
 =?us-ascii?Q?leiC02U4gZ/2eGca6xS7FWlvj2jeIR5z9AK6QyjG9r3RKdqKlPHp7/0zKKRU?=
 =?us-ascii?Q?caog8qY3K6CPBqYf3lJA5HceKZL5WkMMvc+KDjo5sZMgr1wWgmpjeKiL4Nee?=
 =?us-ascii?Q?O7ZIK1KqMNdK70IaX2ib1bWY4iWfynmnoZ9eOBEmhnJAhbo7CaUz+kTk4IV4?=
 =?us-ascii?Q?2qQZ0VsAEvVKMFJDN6XodAo5l+SSZsS7m6107PnvkfYKfc2fTlCXUp0Oo4Jw?=
 =?us-ascii?Q?lJChI4cWVATFH/LuETC0nGvr34c8xZBtpmx1E1nAs6JqCKAtrat6Ewq3EJkR?=
 =?us-ascii?Q?lExg+Xm95RwTNQDpBnKuVciMH/2BqQogdFK8Sd3mEM3P9ivwJq4SmPADceG7?=
 =?us-ascii?Q?byth8IvON0VV0ngFIboT6t/Iy8Y1zQXP6OE0dAxXOMHKWfP0nbMM6bif39N0?=
 =?us-ascii?Q?9Ru7Uc6xL1vP3yHHO34P8WzEqoxRRlLlwmcZle949OvKLrtSqEmw6X6X77C/?=
 =?us-ascii?Q?wy9t1HvaCBen1k4sb+wb42k4DFg1HcTNsdYFv7iZB4CU5S7Vmk8VjYuZ8kHA?=
 =?us-ascii?Q?znGdSHJPv4tUh1lU/fCfsct+RCHtwGEyEjktOVg9owFzHQ/Uim7HOMc47KG6?=
 =?us-ascii?Q?EZRxIBhx69f5V3MEvClsjvq61FDgBIIpcUnVY1h/HHmAfyIz/8J6ZQUt8g6w?=
 =?us-ascii?Q?15ySrp7xF5Rd9slJeclWC5/lJJipaApzU2mLWR4C?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(921020); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 06:47:48.6007 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb79171c-f723-4521-d35e-08de21b764c2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6127
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

Add SPL_PHY_J721E_WIZ configuration option to enable the WIZ SERDES
wrapper driver in SPL stage. This is required for PCIe boot support
where SERDES configuration must be done early in the boot sequence
before loading bootloader image over PCIe.

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
---
 drivers/phy/ti/Kconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/phy/ti/Kconfig b/drivers/phy/ti/Kconfig
index 111085f235d..df750b26d66 100644
--- a/drivers/phy/ti/Kconfig
+++ b/drivers/phy/ti/Kconfig
@@ -7,3 +7,13 @@ config PHY_J721E_WIZ
 	  signals to the SERDES (Sierra/Torrent). This driver configures
 	  three clock selects (pll0, pll1, dig) and resets for each of the
 	  lanes.
+
+config SPL_PHY_J721E_WIZ
+	bool "TI J721E WIZ (SERDES Wrapper) support"
+	depends on ARCH_K3
+	help
+	  This option enables support for WIZ module present in TI's J721E
+	  SoC at SPL stage. WIZ is a serdes wrapper used to configure some
+	  of the input signals to the SERDES (Sierra/Torrent). This driver
+	  configures three clock selects (pll0, pll1, dig) and resets for
+	  each of the lanes.
-- 
2.34.1

