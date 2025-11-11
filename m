Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 261E0CCFA1E
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 06:17:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6503C83AF6;
	Tue, 11 Nov 2025 07:17:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="K3SZg75/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F37983E63; Tue, 11 Nov 2025 07:17:16 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76C0E83A98
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 07:17:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Du6ETLX4UkosmRq85OxZoH/IAVJFjwa8Gy8YAVAIo7g8Px7YS+prjprHdqtDLxvIU34wSMChwxI4oH1HlWaFrn7szqbTlr3FcsbcrNjJNmTMwZHE435aAZI1eKu8HWYwz1AhaKZ2zMyhWLD5tN6C+VLJnVtSA3MgYThUXjmMtKCxl+y4Xh6jHsFvpyY0mLpqoPTkszAR+Dd0iegraossqMswnG0hgKsRLdzTSKCm9/dZF4AhgIeZQ1ZUIxHstrFpbwgJ3QEcoFbOxYo/Zubc44FNw/Y0DApy5U54tn74wVxMNVHdLEZikE817vA/FqYXvihWtkbX/hTFqXq2tNwTGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2vpFSX3slLQaUw25wqfn57Mzw13fPGQyfY0QsLk1I0=;
 b=u7SsjRDtgZAUFkQLFO2kuwrUBySkWKnm1EIvyKar3CAvgW7BqfQo4wKMMA7ErOosTVEt7oce8PNXbrt11kQdb1PmE/a+kEt3LOazpYGSJuz9zDxlXVvdtF9Gfys+dIu9+c20w0fU+y8h+cDY3SMauyLWRhIekaVNyk/ypKFjrhpoZ1wkPC6LpvBEeHwpYT71n4kiwxtPkEO1jiFX8j5Nuna+vRnG/SI7oBQqe9vPmFMThVZVOuvMO6EdbPTKGK/ZOCO7Lc7lyI/rhF9PpKiOQw7NF/jSmEHgiujAf2GIIvkAnIMktuEIjTToo/m7Wu+RDjWtOYhChPId/5OKIajIBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2vpFSX3slLQaUw25wqfn57Mzw13fPGQyfY0QsLk1I0=;
 b=K3SZg75/m8hKbohaFgOYOBbTLD8ptiLdPHzJWLv2yGwArisRdPG+FKLBsNIDaiESnxY6DXp7cWcI94+Bv21bzIMRh2I33uopC4+/rnumuh18iIUEiKbCn0PLm/oq10JZzkEQBs1EWbdHbxNMUGqNIde+fyCkKP2/Ka9VehthBOk=
Received: from SA9PR03CA0013.namprd03.prod.outlook.com (2603:10b6:806:20::18)
 by SA2PR10MB4730.namprd10.prod.outlook.com (2603:10b6:806:117::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 11 Nov
 2025 06:17:11 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:806:20:cafe::54) by SA9PR03CA0013.outlook.office365.com
 (2603:10b6:806:20::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Tue,
 11 Nov 2025 06:17:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 06:17:09 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 00:17:07 -0600
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 00:17:04 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 11 Nov 2025 00:17:04 -0600
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com
 [172.24.231.157])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AB6GkPQ448280;
 Tue, 11 Nov 2025 00:17:00 -0600
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <trini@konsulko.com>, <a-nandan@ti.com>, <c-vankar@ti.com>,
 <u-kumar1@ti.com>, <marek.vasut+renesas@mailbox.org>, <n-francis@ti.com>,
 <peng.fan@nxp.com>, <semen.protsenko@linaro.org>, <s-vadapalli@ti.com>,
 <jm@ti.com>, <m-chawdhry@ti.com>, <ahalaney@redhat.com>
CC: <u-boot@lists.denx.de>, <h-salunke@ti.com>, <danishanwar@ti.com>
Subject: [PATCH v2 3/5] phy: ti: Add config to enable J721E WIZ SERDES wrapper
 at SPL stage
Date: Tue, 11 Nov 2025 11:46:43 +0530
Message-ID: <20251111061645.1004382-4-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251111061645.1004382-1-h-salunke@ti.com>
References: <20251111061645.1004382-1-h-salunke@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|SA2PR10MB4730:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a453f9f-fb46-4511-77f8-08de20e9f23a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X+Tq36PYPrEY5R0NNmEQMMBmpXjnAAAfEpyHvffabMCGEbq0ii6xXCV0RTZE?=
 =?us-ascii?Q?mSdn1eQYNIooP8UFDQ/7hfIExfnvLgENNCMMlKUzg9ZkUNS/h/vZGEtyHBs1?=
 =?us-ascii?Q?GDLLQHWp2ez60LEiw6CLWCtEIxry7K3OmXdo6O5xY98PQLos+rwNviHFa+NO?=
 =?us-ascii?Q?V0PvkFALLCgha9RfuPQ0G7HWkk/aM2lw0/1M1g5fJbOafbnYr+16K84fNCFw?=
 =?us-ascii?Q?PjhfQuKiAZZUWf6LD1fzLykYeolFAZgcM1UUoL3UkCB20QrfH2Tp4MubZOZR?=
 =?us-ascii?Q?3esktlK61Fa/QuE5yq6a6NSis2ceO6tSAt/T9tZ0dPCH32JVwceHqxgDnMzA?=
 =?us-ascii?Q?8/nF/QrM6PA/AsMQuVU5brc//0DJXTYQKEA7bXaUw7IIqKvy/DzgYs7XwXR5?=
 =?us-ascii?Q?t71IVDmq6/W+WzzXQh2Vqh6bQgpb4y2mwQbBECctJJyd/zPhl+dGKipZwoGU?=
 =?us-ascii?Q?1NDUicJoiFZQwINNl5w7KfJ7prZ6VYWT9CcF4tqXurOgw39AuYwt6XqO6hOH?=
 =?us-ascii?Q?IzTVr6roTCFwCZ198oPU9Av/i3lrrrVO54n012IPd0n/IAT7lN3AA2KWwrom?=
 =?us-ascii?Q?nLVoW8G5gvPf/TeDgcUQvKzbiK6VBQ+aInkWM3Ua4sy8YOGBkTy6tFXWatA1?=
 =?us-ascii?Q?7QxalDSXoM7WfgE/rS4ic+o4id5oaN9OnG02euqOVXt1L8oFmhjwXLgymodU?=
 =?us-ascii?Q?kjAmYr2SMEXB6dEiMTZ4krJXHeqbFPMagoA/4+2ErC+18NySDL0yUbqw17Ux?=
 =?us-ascii?Q?VIGuK4bVI8irdxUZRM1WkBpVb1207XOOjTYlFawDsAqwncq3+GhEVhvj3dcO?=
 =?us-ascii?Q?kW8q/xiXj2KDGgXxuP4cLPzDfbAb/kzkkcOXDY1StKnL56UxIjNtIPGMVPtL?=
 =?us-ascii?Q?eMF14lGRrmMwnU6atJCZ5Lz+6ADm3o1TswxZEs1SzmK1M2HlULMVn9aEdqC4?=
 =?us-ascii?Q?pM98gZTV3BogPCQcVZiZA8GgjFh8zqO0XyNtVMHh1PoDP2f4cchnHwOWOGCH?=
 =?us-ascii?Q?TQ7clFj0w8/hkTHZV9HWv21ImiMUwsg24U2LjJYCNH/Ij/O8wmReRAu6JQaW?=
 =?us-ascii?Q?h9HKaIhrxfukDbNAVIuivo0KwT4/nTPc0rx+aFljjSn9UajxXy40VQmAY8XG?=
 =?us-ascii?Q?J8bN6TW3ux98mDqlR8iPQXOOZq9+OmWoINBZ+p9fvcN85OdHG2dFhPpKnAkC?=
 =?us-ascii?Q?vBRx/faJSOMi7JE/t+IOrS2ZPV7xksawQ6vv3Om25sbv/nAYTMLxduDK+Tuu?=
 =?us-ascii?Q?Vx9By3z5Fdtv0F3nPezGRCCs8RmIenPR4gm428EyO++0NSAvDsO+L2gLWPNa?=
 =?us-ascii?Q?o0ggtIs+UmqLu38yGtoXhpHosPLMd+Ie8WopK78xfCkMd/Th2RhK95+splz6?=
 =?us-ascii?Q?Z+XQyZF26PB4UQpARn5lauNSv8t8Ne4KEu7X3YTLCaizrx8vIHdHLDIrDadW?=
 =?us-ascii?Q?C/Y6M4AnHwJpfx7swnYSnAYDaD0lICEx8cunm1Of5oMo2xW1y9rnV8XsROId?=
 =?us-ascii?Q?AkNnRE4nM8Dinvx2vi7jRNC0nEV//uGOEzWoaxidJDcLJnMrWTHfp79GGw0C?=
 =?us-ascii?Q?nB3nz/0W0b4McMgRcP5IYBzSErUt1mdx56N8b5Y0?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(921020); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 06:17:09.5726 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a453f9f-fb46-4511-77f8-08de20e9f23a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4730
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

