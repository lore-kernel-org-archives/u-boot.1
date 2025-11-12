Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA5BCCFA1A
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 06:48:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8D5383C08;
	Wed, 12 Nov 2025 07:47:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lvd1sT92";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 247E883C40; Wed, 12 Nov 2025 07:47:49 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1317B83AB4
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 07:47:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xHmBlgL3lAsumWikWqk65j6IgBmA+FwEIepuPfIE5ua141SlEAO4Z5d7HUBtVqdM95uwWYXeTgKA2bfNjBc3rH+R9ENKh6BW+Z3WZ+/5ICRF2+GlGl++ppULU2Z6vOuMcCL7l/XI7yl5QN58jQdIJxL8yXSOGQrvL1V08wiATzCV/Am1RxMFhNP45Vmnbu8VUTxP3uzXdSfqVLVC3Mrr5szrEo6lLycneKXOGri5j1ausv8iIyL1NgYatzjxBprrOeptRDoycZYDbYjBsGqc8l32Dp+WUYmX3VHMERO4jNUeOQJ8kRw/7c2v2LxldO0c3vEVLMaeNzHV2ViYn+8vqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WEjduVtwc5IbwSDtH/knqXc7tHOMOGqqzzpN0JIJ+zE=;
 b=RZvStiahEOdGjCgZdtzWGEBqIGsJTZfaGgngjBvUE3R1GlsRP+c9Mfn66uzE8m3oiB7XzzeTaBIzhENJ8fFjc2yLf2YX9wNKC8VLiLD9kgVRlRi8GYcMEjozaOXDIAq4aWRTL4Vr84M4sT1wPg6kvGIddE/Gji0g3ZwB48Ht9Kb/aEkM3hakwmm3g3EdD6+r1NPSAnkk6ms7Ewqo5QQz4OVvHDPodiJWWkXb5bxTL6skmemKiCCAvk52HtGU94pB6zOGb2ZsKhHoNkNF2Ao8kz4LlDWzToOT+RbSO0957aKRfcX36IZJv0VXVQ8CPheFXgkJciMZz/CDJl7AoT2UyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEjduVtwc5IbwSDtH/knqXc7tHOMOGqqzzpN0JIJ+zE=;
 b=lvd1sT92RRrlDh5R3oP0fDyPxlsO/17PqJNplA2MFSEGLnqkGnNL0rCBR7/QLELP4ZQkhQbaCVR5rro1AbjL6siW+TMbyf+vUDyp31ZAjkhCtJ0T2xEgB5+bKV3+HAXV7U6R4w/DKztW7EYeC5YLO7rU7hxDWw1e5916Ui3/wcA=
Received: from SA0PR11CA0002.namprd11.prod.outlook.com (2603:10b6:806:d3::7)
 by BN0PR10MB5029.namprd10.prod.outlook.com (2603:10b6:408:115::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 06:47:43 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:806:d3:cafe::19) by SA0PR11CA0002.outlook.office365.com
 (2603:10b6:806:d3::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Wed,
 12 Nov 2025 06:47:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 06:47:42 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 00:47:37 -0600
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 00:47:37 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 00:47:37 -0600
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com
 [172.24.231.157])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AC6lPoX2217584;
 Wed, 12 Nov 2025 00:47:33 -0600
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <trini@konsulko.com>, <c-vankar@ti.com>, <u-kumar1@ti.com>,
 <marek.vasut+renesas@mailbox.org>, <n-francis@ti.com>, <peng.fan@nxp.com>,
 <semen.protsenko@linaro.org>, <s-vadapalli@ti.com>, <jm@ti.com>,
 <m-chawdhry@ti.com>
CC: <u-boot@lists.denx.de>, <h-salunke@ti.com>, <danishanwar@ti.com>
Subject: [PATCH v3 2/5] phy: cadence: Add config to enable Cadence Torrent PHY
 at SPL stage
Date: Wed, 12 Nov 2025 12:17:22 +0530
Message-ID: <20251112064725.1049199-3-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251112064725.1049199-1-h-salunke@ti.com>
References: <20251112064725.1049199-1-h-salunke@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|BN0PR10MB5029:EE_
X-MS-Office365-Filtering-Correlation-Id: 64509a70-1c61-4a2a-1e94-08de21b7615b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dNxWzZevYoq8Nj0RUBhnLqTEMk/igLdryGSw7BKUuabyOkTD1v0eLgARD2Kv?=
 =?us-ascii?Q?kvKsxN3kmFN94JF4Y0JGxgWo2Sa8IPKe50TXaYoklk8V+9dLHE2xnaQXfIAt?=
 =?us-ascii?Q?RKLkg/TfVQv7JlWXRdzJIBsK6zv0ZioDM5YsIafbo+Yq7fTZQTr7neyK7w3b?=
 =?us-ascii?Q?Fx8g/AuCxubnpTLkQjfCpcas8PCIMCsF+aX5/hFGGRsTDhOa/CvfqFtratDl?=
 =?us-ascii?Q?rvyj5GA+D29x1RgAzET/aeGLa0X7cocZnfUb8lulW8QeXiYHXjCdibf11dmF?=
 =?us-ascii?Q?vhNAeb1YeLB54+AjJaASVy5dPDErIsN8rou0KobcXlAfx3Rn8ZHUqt0xDqUl?=
 =?us-ascii?Q?g4EYjlnmMh1g84pR2os7cBC8IA+JF+AGdmZYHYTTRGt04VuAJU+Txttzb5DN?=
 =?us-ascii?Q?tDZ6oooBnXJKGUTSkz0uFLzUHOslbQpCJXGGYXZ+Bm4Sp1dg9dCVgQBT6huz?=
 =?us-ascii?Q?XWfol1UjMqpUxXRvH1LAvyAPU0y2WQUxqGBEHMgJ9nAqPoo15XatWHa90ctH?=
 =?us-ascii?Q?XlLmBSL0oNzzG7Or4U6a51ZZEmhhHL4PRJ4Qq6XfJUTtaxvrY5iScZlXXQIy?=
 =?us-ascii?Q?JsqwaX0e3T3y7geRYRbN8XSz219rNEPvtyBKcTMpmBx36YYDiffTq4YYWeV0?=
 =?us-ascii?Q?G8glDJRe2E4NuIF1gcmQzG0ua9aaswhWpvrADAlWD/9fOmQ0ItCnKlX8Dktb?=
 =?us-ascii?Q?pbnbRIjrZJRpxCRCP0+2nmXkOvYeSzLnb/8bG5Bx4xIe4sreCnKpfdWgpBbz?=
 =?us-ascii?Q?x0MnXWam36lBOEpatk/caFBOqEPpeUWBMDG1e6uCx2E0xEIXLqH0LjEKuDuI?=
 =?us-ascii?Q?E7sd+IH78Bx4k7y8kaGbeIGIJkAkkv6Q1hrkQMeGJZoJ1PCcuSqm7rGm7Zju?=
 =?us-ascii?Q?lQkrunWmLabfaIb7iJH22Ca+IMWRUSh1l1KmsLxA6Zh7L3JNf7V3iw/+ovcH?=
 =?us-ascii?Q?BGyQh7PvJ8Tw9kRYeGkWuYPHC7JwcM06vjzxapODCPI47NPc2Fa7d9DEqDWV?=
 =?us-ascii?Q?p3Y2FRmxgOLHS6Q+H9KEfNkid21cRZ/hycg62mCf+tqWXG+Ro0mcGl11P2PV?=
 =?us-ascii?Q?EdsOQ3AnbGK/H8UPQ61nbI26m7NO3YyTVqUfSkPDmC5/CNjqcffjT+rMhrIt?=
 =?us-ascii?Q?S6qkxO04PWWEg4PP5lUFW9O9hmX+moONJNfFDEgd3Lum15UsDWH3oW8I5cID?=
 =?us-ascii?Q?RmWRWF0nRrOrR884mAk5VGJIy9pOL3SQ8gZBbDZPhK0CJJ8BtP7Z7QMrx+4p?=
 =?us-ascii?Q?xRLOSQ/TN/XV4+OGgoNwEifTAnUcAmOUpEJovJsBDyXgY3/qGZKRG4goktbX?=
 =?us-ascii?Q?oRwbtrKYDINtXkiacBH6xAEJnbCDkbvJ8RPBaCEgOUCJfTD+dr/1X+mO9Z4m?=
 =?us-ascii?Q?NafW1d3uoRkalua8A4ISyeT4uTtV0geAH3aOtlJ6mtUgoEoJzP90HDlsasTf?=
 =?us-ascii?Q?LnatqS4tvN4HOW+IpcaR1+6Linqs2BuWLS+r0yullDL0KCKfPu8Nz0afBRER?=
 =?us-ascii?Q?CEWK2Y5nn+HfmjiQjatFphqHxs+1W25qFccpTGfhGJ7plgeM/WbhoUNqIT0O?=
 =?us-ascii?Q?4KWmys26BeQjaN3HNdAm4RX3LZTnnsaKJ1ygEeb1?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(921020); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 06:47:42.8911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64509a70-1c61-4a2a-1e94-08de21b7615b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5029
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

Add SPL_PHY_CADENCE_TORRENT configuration option to enable the Cadence
Torrent PHY driver in SPL stage. This is required for PCIe boot support
where SERDES configuration must be done early in the boot sequence
before loading bootloader image over PCIe.

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
---
 drivers/phy/cadence/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/phy/cadence/Kconfig b/drivers/phy/cadence/Kconfig
index 549ddbf5046..8c0ab80fbbc 100644
--- a/drivers/phy/cadence/Kconfig
+++ b/drivers/phy/cadence/Kconfig
@@ -9,3 +9,10 @@ config PHY_CADENCE_TORRENT
 	depends on DM_RESET
 	help
 	  Enable this to support the Cadence Torrent PHY driver
+
+config SPL_PHY_CADENCE_TORRENT
+	bool "Cadence Torrent PHY Driver"
+	depends on SPL_DM_RESET
+	help
+	  Enable this to support the Cadence Torrent PHY driver at SPL
+	  stage.
-- 
2.34.1

