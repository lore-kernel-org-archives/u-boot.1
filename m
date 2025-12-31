Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BA5EEB565
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 17:36:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 286B2840F8;
	Wed, 31 Dec 2025 18:36:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OYHcOznH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EAD9840DE; Wed, 31 Dec 2025 18:36:41 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D397F840EE
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 18:36:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gKlX0TbOQLP9ved8iFC5dp++NUyey4aBHnD6/VjizMzeIt1oHrk5Q3C5orIxtnII+O6XynziazlggAkdqIqly2kormSXdlZsFY5Wv3aWDghaZX2A5ZBVaDBadFzRDVduKhFf7Qf3cRxP3AEeFPtwR5VsPn9/vDu9LAatZ0c67TSibxj7I1XXGxPj+hevuRW53Fgp/FIzDVwWrFJ8sUbChMxYNv3/EwSdo1lbbirLdeq7YyM+DUSWQ87tqfedLMfJvrTaM7/nxoUI5invd8XFhaMonAQjWLlflklrRSayyCGrL5otO/Dt1ChqLlcjOed/9q6frrJeo5/0LFW866mXnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGr9vMVBd1UFCuxIpW7MkMT9vN9iR5zibdF7KoyF7nA=;
 b=dWoNfFSqh7uH1ibEx3hIq6IBz4JKtj6YSCSI0ZbU9r1xOFjo1DxxyGZJk3TcKDyoLbK/PXqcIbcD3h0R4caAz0BN7xZyjUSyGdutRRd5WuL5jfTNXCUNi94MlEmlymoHiRKOXj6zwzuspJExowXSiFn2cHXQDpMEAHcS36Hw29gC8ge68mLkjGG2wtKfudl/C/P2SPmhRELf2sRPTDJxhuynsmYzQ8ozgFtnkU7/zBBtXxYo18HB47VnipaL0m+/vKwJpRTfsd81BSKyVQ17My/DJUWf6LpqJF/yc9Q8BBlKT2gA1bzu6YS5bnm/S3qPcR+4Zhsuy+GrY0bU/j/lQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=chromium.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGr9vMVBd1UFCuxIpW7MkMT9vN9iR5zibdF7KoyF7nA=;
 b=OYHcOznHlC0w/f1htm5eo/FA5q+AEedyGKG59EoqOJLiQVqfWQFXhf+no/UoT9x4v6yo73pxcn4nL/Jep4Wtv6Gg0ZkuVtv4HVGSE/fs/eL3MMQZciHfyzN9FcrFWbWYUekqqBBz/h7r/ELqzIE5YVQNxrvxpK8OmWVANDVbdew=
Received: from DS7PR03CA0069.namprd03.prod.outlook.com (2603:10b6:5:3bb::14)
 by BN0PR10MB4952.namprd10.prod.outlook.com (2603:10b6:408:122::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 31 Dec
 2025 17:36:36 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:5:3bb:cafe::76) by DS7PR03CA0069.outlook.office365.com
 (2603:10b6:5:3bb::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Wed,
 31 Dec 2025 17:36:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Wed, 31 Dec 2025 17:36:34 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 31 Dec
 2025 11:36:33 -0600
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 31 Dec
 2025 11:36:33 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 31 Dec 2025 11:36:33 -0600
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BVHaOqq2541396;
 Wed, 31 Dec 2025 11:36:30 -0600
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 01/11] spl: Use FIT data address as fallback when 'load'
 property is absent
Date: Wed, 31 Dec 2025 23:06:11 +0530
Message-ID: <20251231173621.1069988-2-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251231173621.1069988-1-b-padhi@ti.com>
References: <20251231173621.1069988-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|BN0PR10MB4952:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dd78646-97e7-4bfc-6f16-08de489324c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C8U5bNJpQmGf6Z9ZiAo9Wnewwu9KzYuaJf+H2mfIxceK40nkdECRLmKF2evJ?=
 =?us-ascii?Q?sznMboF/5BSeWa9fIay4/POAyP8wkbun52Qpl8mssDGnXThTgO5kbOcufseT?=
 =?us-ascii?Q?wOox+hnY2AcXXAfAgVmK0Q/DYLQM3P3acgDmbc77V6205XvUfnMhLpDnVVlC?=
 =?us-ascii?Q?5wFG42ik/KWRxXTOxsp9Uv7KxzNIiZoWJ3SHUxVRKJL39QhUNKoQT4oxhIL8?=
 =?us-ascii?Q?9i0Xdlkj9vcIh2vcXRHNbeyBcO9conQ+IIYWy1Xrpj6uVsawLOybvbRGuTDd?=
 =?us-ascii?Q?K3jvcgfjvWCSoufdvIlmLNBslU4Coe2p/hPzsWQx9u93HRtShu5XTRcy5GiU?=
 =?us-ascii?Q?hoLTLqfcqxqGWY7TYB75tKUyvHk8fwX113hqmFWpb750TIGsUhXHcGSPwKYE?=
 =?us-ascii?Q?MQffG+Quu3mXcqWCfWBMkqLuzCH49pV+PLbPG7ScyajwRp8Cg2+xWz83+jPq?=
 =?us-ascii?Q?QrVVNM6yOsB8vScqu8ckc1UClBR7vxznuOdlGpqTkQWsGSLJQtVwZnAvhtdm?=
 =?us-ascii?Q?vqP4UDbuvOVwB90er9TsH47Qw5Lygrp3PoYaKTvMCVpM79sU2gVtqZwu5AMA?=
 =?us-ascii?Q?Y7JzfyXS2tlnIFLI0fvmyiJ7UGCzs4Q0RsS/eG3k3/Mr2nePp+kLstlHexqX?=
 =?us-ascii?Q?dnhbSw4NZm+nPFAXmbu66XIxTB5pkjmLgy19FaDhV2Urpnl2xHBbCdllhAc2?=
 =?us-ascii?Q?tO8TmAVC4z4LQZCDb/8E92FslfiEOvofLctyqFTD+cDH87wO8aetILEQAMvz?=
 =?us-ascii?Q?VlZfcCkvMZmM8o9jtYurAXZ3x6gldZw0rkaxrh1pRqr0Sr2thuH6et5nnoeB?=
 =?us-ascii?Q?WPNacv6Y5uBp8sdHR0SeOL8uA1d2iY96wnsTJR3Modkq6TY/5swxFv295N/R?=
 =?us-ascii?Q?Ucg9fJzQWvTeZKE65E39/VBzZHT1kr+HYXH5I+d14uWvWKCxUak9RR4Vgdjj?=
 =?us-ascii?Q?vaK3C1xNMVSOdB7xOcLEtUmzihu77ORfIboi6AXC8glD3aPah+GvOZUg58pG?=
 =?us-ascii?Q?VTWcOKP+KKOsWp97sC3+lxOg+c0XWQOoyfPju0mC0jf6rjWlj+67gwBjgj9Q?=
 =?us-ascii?Q?Lt49h+YHN5uL2DnlQd+nws7t4ToQ71Yy7wQBYl4t9Rdum/vre3kJj2JUCw3v?=
 =?us-ascii?Q?1fyML5hOWsRXMLreIjh3mQJEWp5jqJK3Vs5YMgKXAhFyO1YRGbT8JtlkpIpm?=
 =?us-ascii?Q?Ann+IFD9CYtaipeLTM2tX/1cLxcyzr5bFFko3AKFqLsAi3sgN1wMct16uRiz?=
 =?us-ascii?Q?6qFJCqJZdzLuGxabfS1wxi8tdpZ/57/9yGyHrZHGIe6PH3pqwyCQcOH+VUmT?=
 =?us-ascii?Q?4tq7NtnCY2SsUEKLPKFsPmM4909wo4xX8ISjiv+lz3EnUNU74UIpkHb+NJdx?=
 =?us-ascii?Q?lvd3nzen2rwjDsvD9B4ZORLkJwaST6lfAdwqwvfPEi6adCmOPBdE+fFomdRl?=
 =?us-ascii?Q?g4ZOxExpifZGcYZfu/W9mbMNHsNGg4A+FZZ9PtMf65YquNEdT3mG8RRS0g82?=
 =?us-ascii?Q?TkujWPLq+OseenPUEdEewJopfn8XZS5VpzqUkhCQQsSLDjx25YUthEzLrSj2?=
 =?us-ascii?Q?Vn6tbru59LOTstKCgEE=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2025 17:36:34.6939 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dd78646-97e7-4bfc-6f16-08de489324c6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4952
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

In cases where the 'load' property is not defined in a FIT image node,
fallback to using the data address returned by `fit_image_get_data()`.
This enables FIT images to omit the 'load' property during FIT creation.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
Cc: Simon Glass <sjg@chromium.org>

v3: Changelog:
1. None

Link to v2:
https://lore.kernel.org/all/20250506104202.16741-3-b-padhi@ti.com/

v2: Changelog:
1. New patch. Add support to load images without 'load' property.

 common/spl/spl_fit.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index a588d13eb40..c18c98b2959 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -803,6 +803,8 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 {
 	struct spl_image_info image_info;
 	struct spl_fit_info ctx;
+	const void *fit_image_loadaddr;
+	size_t fit_image_size;
 	int node = -1;
 	int ret;
 	int index = 0;
@@ -893,7 +895,19 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 		if (firmware_node == node)
 			continue;
 
-		image_info.load_addr = 0;
+		/*
+		 * If the 'load' property is not present in the image node,
+		 * use the FIT image's data address as the fallback load
+		 * address. This allows flexibility in omitting the load address
+		 * during FIT creation time.
+		 */
+		ret = fit_image_get_data(ctx.fit, node,
+					 &fit_image_loadaddr, &fit_image_size);
+		if (ret < 0)
+			panic("Error accessing node = %d in FIT (%d)\n", node,
+			      ret);
+
+		image_info.load_addr = (ulong)fit_image_loadaddr;
 		ret = load_simple_fit(info, offset, &ctx, node, &image_info);
 		if (ret < 0 && ret != -EBADSLT) {
 			printf("%s: can't load image loadables index %d (ret = %d)\n",
-- 
2.34.1

