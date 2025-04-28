Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE60C3ABA4
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 14:07:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3702A82AFC;
	Mon, 28 Apr 2025 15:45:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="nU1Rr+o0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7C3082B53; Mon, 28 Apr 2025 15:45:53 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20714.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::714])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D471582AFB
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 15:45:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oArKhvhN2cWRGIpr/fv0geI3KS/U0IdQYxZg6ogOC9C/PJgurXnY+ZyUQ4gukEkQA1JgRJ1cKeU/Ef2eyIs3FItD6k6Q7oX3rGDXdhNQu3piVLDbB+QWUhnwNj1naU1AumaY944jMDRVknegHZpxr5TAecUSVV8e2k+fdDTXV9k98uK4pBs++f7mhy6O6s4Qt1OTyjhQaPfUZnHGc1yga5Qs9RCiRyk1DaRpB0b1ubmtz1uWbEZk+r7781dF1JPE586VkfwgmdaSmvgG+Tb3bFbsnQBnHlWltZARscMNTJYdkSwljBkZxjMM+M1Q+f3cU2XqsbpXOVr3D0Iygv0mWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fc/kO2zt/8umJ7bdLXWh611yZVECB82PzuhIUJr/E6w=;
 b=EE684BLfQfgU/63aQAyKHEWCaF1Yy4n8chgjoyBMjgKkjjzxe363uiIwLkMdiSA/a5r4BTj18NblzDlD4Hvdmc3qcIwj1J9ELyU7M21jJzrOu3vYQPm9a6pngqdh0NyG0R93HLgNhSRXquxY4MWz8HeOGse5p450lNVOauMM3xFcPpwrbotgg4VNZR8+DKlo8gFRD26aVTjUcmEIV0zxW1mudbPYRuP9IEqi/oT2wSUZJ1z/e/sn7BxNvKPXR/F8X/weLSMGqk6641kjlGtuDF+A5g8H56fn+b4cvrwsyy4S2F5m2AgMZioVzOboijuaywUVkYP/YMvJmjPOfjtIPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fc/kO2zt/8umJ7bdLXWh611yZVECB82PzuhIUJr/E6w=;
 b=nU1Rr+o0PNYWri3QX5gZltpPGX2DEvv1jp8UitNIFFZ65YTJg/uoiFISoQ7d+9EzeFaRo7A6GPthH7k7qx9d9gqf2KElp7HDtlidscNmHZlPvAJJp+fZrHFC6nvPeI43wui0xRLPVhZljt2KRTNBNKCdfMV3nQJVRQmTBXKPjrpO1fu5dyR6Ouj5LJHmELiA8DhguTT3Y3XwpCJ5C09+WXGNae9zm7mKw+x6Yda7Nt4twu1EE6Gy9GlwKdwbszgr/ibhgsCPfS7LX4nPAWm1OmBRXDJ2G+qNzOaADsnAfvWfzxTbN/y+QTKCwJ4QBM7Q2ZiMjizt7Ld17mZneoyuNQ==
Received: from DU2PR04CA0044.eurprd04.prod.outlook.com (2603:10a6:10:234::19)
 by DU0P195MB1883.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:3cb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 13:45:41 +0000
Received: from DB1PEPF000509ED.eurprd03.prod.outlook.com
 (2603:10a6:10:234:cafe::c1) by DU2PR04CA0044.outlook.office365.com
 (2603:10a6:10:234::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Mon,
 28 Apr 2025 13:45:41 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB1PEPF000509ED.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 13:45:41 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 28 Apr
 2025 15:45:41 +0200
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 28 Apr
 2025 15:45:40 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <ggiordano@phytec.com>, <d.schultz@phytec.de>,
 <n-francis@ti.com>, <nmorrisson@phytec.com>
Subject: [PATCH 1/7] board: phytec: phycore_am62x: Update environment for
 fitboot
Date: Mon, 28 Apr 2025 15:45:25 +0200
Message-ID: <20250428134531.2884940-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509ED:EE_|DU0P195MB1883:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fbbf577-fa07-4275-c06d-08dd865af77a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/tDyuKOWJprVmHgqpbvUl7N1IX2czG6homHjFfc/x857ZIWKVkWhNkeIdss8?=
 =?us-ascii?Q?xUGn4OJBiUt1TVjBydj9O6ZLqtM8yJGVExzqdQeBa3xBVOGCN3pERgN/lWVa?=
 =?us-ascii?Q?3a1LK5Sh1lQQALcNnCHRg41yePny+MxQFijn8VwsaTu9n1TzIl0vs6jittwV?=
 =?us-ascii?Q?GW+vSOkbGvFgRPUDjSLOTf1DNVqHRc4sCRZ5A+PhgYZfkiWLt13oFkI/vI0S?=
 =?us-ascii?Q?W64JnYBtmNwodEu8ThvYgGCeQ954H6ZyA645m4KoWG75EgsYLb2U0jLq22Eb?=
 =?us-ascii?Q?TcSdHkCH13FglZENCMmqeocrKwWxoS5+pGNEhgygtvvKdDQpd+GpGkWysz1L?=
 =?us-ascii?Q?8O+EaP0S7zjuhMQHEgxBZDr9p0J3kGyuxxLbTUY5Yr9AB4nFXVbfXDpdC0Op?=
 =?us-ascii?Q?ApmFH+vE0SmM0TPnl+zRIwUr0Cu4wYIEJnJO78khprDeAzNbDKsm0/0mje/3?=
 =?us-ascii?Q?2lJhoJoBO39WHt+4sj1AZGAJuFg5LRXmHL2x7f1SJ7C4RqWQGXXSfS5kAB5k?=
 =?us-ascii?Q?tethTnwc4Mc+ulRarvoMpcRT/VD9NPW0s5IxRRLoOaoNofMYxFDFoW1LDgbM?=
 =?us-ascii?Q?hoSahOcosPQA5DchZzS17OjIHW3KGuZhUcOQNqxz0F9JzTYyosGfzblOiGBd?=
 =?us-ascii?Q?hkuttID7jTSdD969SJHOT/ilDYI72AcdbMxbSXd/J7TZJ49QkmgTisvcIv27?=
 =?us-ascii?Q?Ln6d7Pbz/FzpPEikzYt9XNKx5bt2xP4jC350RdptHPEk2gSxMnbl+KivecRC?=
 =?us-ascii?Q?LgeEKNuAkU6xwtcdnSehzFeiP+URoFloF+wcDRpG7mQk2WEfy9iQBnSSnn3A?=
 =?us-ascii?Q?G+IFBtksjNwu+Xt357yN8WzoYid8CJktHIJgo8Y6WGcpyW5mBQDIgSwNnAKG?=
 =?us-ascii?Q?JEwXGLAOIF19qW8lLtUkESleUVOB3Zr8TbM0xMRnQXKf6wh0HCv5wygjLRR5?=
 =?us-ascii?Q?hjwMQ/b4gZmhSKeNIT7zlecYAkQVXdwoxuUwNTkwiXfiGOtNOiH/lyLw7SR7?=
 =?us-ascii?Q?7K1EYH8rEUV87ve65xm3M3vbzJvboLd7l3FS1UIsQTRSd9wCf263jeRLK3Ah?=
 =?us-ascii?Q?aCuZV4xgvCW+dhPBgU2ISSb2OFtQwAx5Z0ClcihZMKW0p03J/ASADlSMN/7z?=
 =?us-ascii?Q?4RLgOExkslB5PV2WpPU3pTvdVz/ieWJI/7A0y0y4QFdDDpta1jYxZhb9EmSs?=
 =?us-ascii?Q?Rn48CBZTNPF6xD0Tz5l8hcr5nAAVu/7GdsOB45UTirCo8nGHoL1knKDKSOzG?=
 =?us-ascii?Q?g0+F4hyviC5dS+GPKLkSOpqQJ7DeRYxS/WCyz3Tjz6XeyoqaUJ6mkh6WwA4m?=
 =?us-ascii?Q?PmU7N7MxkPXkicIcHSg8/DdTiM3JZ/ds2VezFMMFq24pDb0qsCGu2Yy0+BtM?=
 =?us-ascii?Q?qgb3zymI0HpPrf/kgMUU05V+P/GAUl/J2qtcoU2jNY2Luj6noiAyMpkFI8an?=
 =?us-ascii?Q?uYGuu85itLTKpx2F9o6//Rk3mJhJy+1UFKL/+iaVAen8fh/2tVpomtbBfQi1?=
 =?us-ascii?Q?f8URvw9toSmAoU/mbkBUGph6kSUDW6K8GKE7?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 13:45:41.2954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fbbf577-fa07-4275-c06d-08dd865af77a
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509ED.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P195MB1883
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

From: Nathan Morrisson <nmorrisson@phytec.com>

Add fit_addr_r to the environment to allow us to boot from a FIT image.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 board/phytec/phycore_am62x/phycore_am62x.env | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/phytec/phycore_am62x/phycore_am62x.env b/board/phytec/phycore_am62x/phycore_am62x.env
index 5c48e856685..40787b0cbcb 100644
--- a/board/phytec/phycore_am62x/phycore_am62x.env
+++ b/board/phytec/phycore_am62x/phycore_am62x.env
@@ -10,6 +10,7 @@ fdt_addr_r=0x88000000
 kernel_addr_r=0x82000000
 ramdisk_addr_r=0x88080000
 fdtoverlay_addr_r=0x89000000
+fit_addr_r=0x90000000
 
 fdtfile=CONFIG_DEFAULT_FDT_FILE
 mmcdev=1
-- 
2.34.1

