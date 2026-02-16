Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A8CE7BD83
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 10:28:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDCC583CF2;
	Mon, 16 Feb 2026 11:27:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="DGh2kBzG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 137258063E; Mon, 16 Feb 2026 11:27:57 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F076E83C67
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 11:27:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hbzSZjlJSiEr1jxanZD8UMjdfnUENI4LNGfRt55IadmI78uDUtqyCZUMmTrDp3jLXhoijhLJ+ZTxlPLS5YA0jcbd06jGVVbf5a9gs+q20M8bRfwxJ5i9RDB7rjIeqIUr6wl0nL/0unFT1lAR32T75f8NMKlpl4yxgiK1nWUgwH5qlYclIOHR46nwnYFLxEdl9SGPYcEbFSvk9wCGqbmX0K/94CR3SLqGDCmX2xrte8T9yCg1sayjRZtv4VtDGvKW7TxzYfeMaRihx5f9fmo9MSqDekIxT2eXMhwU5JH90NgfFdbQkfM3qSNWjWWPliX8lbKXJ08JuHt9Lfg9as/Phg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDBs4rCE32GaH8gzTkx3R++ZPhXpC+E1nga5jNdSvHI=;
 b=aOVBZMURH5Xi0XaTqHhYY/bVBKc7aGX/e60zVKHmg1DblWbQw7oN7/etysjEFfvFB0NJj10zUwlCVuix/js7pE9S4xjxtlfpBIvnOPcUzHB26+lk3HuYjowJMcRs+iCkna9dvCDdxHupTWbmCvip4f8Qsh2ivkp/c60I3c3X3taY0sjl/QCbPB79HH29wDtJm9/osYcBz3oFgfTH2cSD87n9ZX1vqv16lXJg5WHBrra9PQclIvvjvRA6Nd/8SqNBtzVvTD/VPkvXckcZgB5Ey5Wwv8fK/g+8CkgzeNceEm6/IgbxuzZr/QdSo11pynl/vI7HjD+SxlrxVDdVT2mzvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDBs4rCE32GaH8gzTkx3R++ZPhXpC+E1nga5jNdSvHI=;
 b=DGh2kBzG8ulIw0Glshu1D38pGX7c/zzN/W0OHfsEadpshS1OL9N2icM3ogl0XwmnqV25F1arJXiVIPA1T1bUOQNq6F49pUzYjKuB5D6M6F0uCFaCcXQ2IZSDjG5t5ReY5QfcCLNRwChcOGUTYETgcv4037xEpwighdlmy2PMHiQ=
Received: from SA0PR11CA0045.namprd11.prod.outlook.com (2603:10b6:806:d0::20)
 by SA6PR10MB8135.namprd10.prod.outlook.com (2603:10b6:806:440::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 10:27:52 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:806:d0:cafe::f7) by SA0PR11CA0045.outlook.office365.com
 (2603:10b6:806:d0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Mon,
 16 Feb 2026 10:27:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 10:27:51 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Feb
 2026 04:27:50 -0600
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Feb
 2026 04:27:49 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 16 Feb 2026 04:27:49 -0600
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61GARUHc1147835;
 Mon, 16 Feb 2026 04:27:45 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <m-chawdhry@ti.com>, <c-vankar@ti.com>,
 <neil.armstrong@linaro.org>, <marek.vasut+renesas@mailbox.org>,
 <u-kumar1@ti.com>, <j-keerthy@ti.com>, <semen.protsenko@linaro.org>,
 <afd@ti.com>, <anshuld@ti.com>, <peng.fan@nxp.com>, <ahalaney@redhat.com>,
 <mkorpershoek@kernel.org>, <n-francis@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v5 03/10] phy: ti: Add config to enable J721E WIZ SERDES
 wrapper at SPL stage
Date: Mon, 16 Feb 2026 15:58:31 +0530
Message-ID: <20260216102858.2745657-4-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260216102858.2745657-1-s-vadapalli@ti.com>
References: <20260216102858.2745657-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|SA6PR10MB8135:EE_
X-MS-Office365-Filtering-Correlation-Id: dbffdd51-6ab6-414f-a975-08de6d4609e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/uY7vQzJvZbSxDgrPAyc2UW61ToJT7DTRnmuTOeRbxwSr9FOuX8xmczl8x6H?=
 =?us-ascii?Q?9sJQrZudczxx9+bHicj/T7/yz3XeF4UpWTqfd8RbCUHcefWXs7stVwx8nBSo?=
 =?us-ascii?Q?DcShv2Ypm/u0uadXEGhQkpjn0Yp9Jh8Nf8KsTiW+TbQavq9ApadexXnhOypY?=
 =?us-ascii?Q?d71NWLBQfPmbxrwqLlDyslHFoRrzZWrxayj5q4q3JmbaOIxsUZceOWs+oSo4?=
 =?us-ascii?Q?V51GRYqvtutT73TTt+P0vfkChFWQh1bB4GKC6ZMAwY6g/9+AvV81Z0tB0BV0?=
 =?us-ascii?Q?EuLswVn6/G46H0W1TBvCJr2jxp0RNv2C3Tuq9LcO4FV1w6MzQNWrDWU+fhM9?=
 =?us-ascii?Q?zLt9PGGGsgiPqUxojec+O/pSZ36s+AkEdZ2EYzUATMOiyIfGrluwOE9nQGfu?=
 =?us-ascii?Q?9vxkbUKF5FF30uycDvungMDQalZykPHeVESOfTO1/oAdtFOYgxozS5OPHtAa?=
 =?us-ascii?Q?PaVl+LE6Tn7mjPLKUFX7jSHuNpdoSJqGTXyhCRYwHS/TEuLYpfMqWIMO9MJh?=
 =?us-ascii?Q?s2iP4FK9ixL5u2vN4tmJWLHK12jghdW6RD2ffVCIb/J1E0o5dQ3u0cmrrird?=
 =?us-ascii?Q?uRbYGRNDKK+OAr8QgMYP4KPVF1l6J6TKUTb2pCyGFM9Gb8dn46xbRrTs17kU?=
 =?us-ascii?Q?Y2ZXXut37aaKhm22whTfGfZYvis3LKGmX9MB4AR8bVHAvDIja20Tt8Mo7XOP?=
 =?us-ascii?Q?xUXXNNy0JTwS+KIY+AfDjVIgsOQV9gHi3V4T5jB+qSb1Yk4ejIrc+DrLnHQ8?=
 =?us-ascii?Q?ABC+BBk/FgMEdD6CuguOKdP/KHCtW2QHy0/zpKw9LE40fIHHuESzEDSVkvwM?=
 =?us-ascii?Q?z343wmNuRH1ifGAJGIiXDGy165/c/KKTF8PVrbOIPZQhL82uewvu0j7Slzmd?=
 =?us-ascii?Q?p7GUF8uJqcZ/oeLVtcSqPstndMSkb/pBwOc4sPpxwGNu5GKCUbWII/+u97Ii?=
 =?us-ascii?Q?7Q+LYWVdma+cqAZ2j4V0V4dD6GkWkTK5C/Zz5WIv9ySKYod410Gzm0Bubx8w?=
 =?us-ascii?Q?czpdIqsxvnspZEOumtGNzK7EfNvzbdewfvHHqxd1+i3piECP3QqRs+RPMMAd?=
 =?us-ascii?Q?18YHS4KyEspmq2NbKGMGhJFvvLSuVQ1Taa1x8oJJimmdTsAU0j1H1Jclnbtx?=
 =?us-ascii?Q?zT0t0+rwmjSnIHQJ/AU7UMtHCtbvD0qR3Ey5igA+LGsQ8AeN/U4aGR/2L/DZ?=
 =?us-ascii?Q?vedrk2CnaitvluF53nhAfr6vZSuhyJ+4+4AVTB9sp3GozvYtJ3ELp2Ue0+Uv?=
 =?us-ascii?Q?Q9AyR3DrN3V8f01Ji1yCd/wLMVuuK8AkfaYL4W2guJDwxZEtLNCs/9VVKeSR?=
 =?us-ascii?Q?ZoLFVUmpLpecVAmufM2Ncp/6fXwcKTRmspi7Gk1V5QnGlS0xDvoQHr3l7T1T?=
 =?us-ascii?Q?U3eMXA+GN+ClEz4vyZwhelz3A+NFVxgzSTelrp+lL4KJrgyS1VheAZTBAait?=
 =?us-ascii?Q?5KQSnewLoMoJ0kXBXvOQ0tYdg3AryB8iTMPARI76uHQRjUKwVkjwnT+8z5GF?=
 =?us-ascii?Q?4QHwCRPjLhehyTc1rm3P964eo7uoXeiDyBTKdCqhliiUh8cDxT+MGoYxfMPt?=
 =?us-ascii?Q?k3/7p6kwY4dKZYFnVR0P4AFbbdvYXAIYal4qgua5SnZm5+vS0UNWVcUeOgNH?=
 =?us-ascii?Q?dSs3RjDUdCGrPLTq5lAwmt9DV0y/zmw1mpdnGDYUV/vriAGrAjcRV+qklUG+?=
 =?us-ascii?Q?32Zn7yQLZzFkfsOQYGdIb/poneg=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(921020); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: e+PcQ5G0sDzqWxN8SD8q+jpLSD4w3sUWYQR3GImf9B2PUNAWjEsOTZh2gzgDTVMcSMBlcAEM4+ZhqlQejLZjOA8ihp2bhC/+IMRHCRU6zDDs7mrJFVO3bI1i+uk480J283ux/wG7mZcve8MbAC//tLPTEtxAqxSWld/RyE2D2dT0bLJNctTaCraIIoirnY2t3txFIuEnFryMc9Dj3zZ2+960R6drhfV2/+GiXhpn3fVSfJFuc/g2T2En+wuyLzua0qrLEAcJMnS+tg0Wm0Wql8BnETBuZmMZUrKbliXBvDtv+29lRcJ3eCt2B1CIe1hj8DifYQYtYZkDNlG5GUK8K7nzDy85PqCzqRd/rsz8iDN0+ky6M9wdmjbcDazl4qPo8UhFRNEWOaETtA/TXwFwLTrdvSwXbMZ2shqUCksW1JlycPHpd1kYKRHF6iDkcgTc
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 10:27:51.3702 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbffdd51-6ab6-414f-a975-08de6d4609e6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8135
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

From: Hrushikesh Salunke <h-salunke@ti.com>

Add SPL_PHY_J721E_WIZ configuration option to enable the WIZ SERDES
wrapper driver in SPL stage. This is required for PCIe boot support
where SERDES configuration must be done early in the boot sequence
before loading the bootloader image over PCIe.

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
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
2.51.1

