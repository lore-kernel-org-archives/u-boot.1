Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F16F9EEB565
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 17:37:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E451F84109;
	Wed, 31 Dec 2025 18:36:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tr74NzIc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51A5884117; Wed, 31 Dec 2025 18:36:54 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2A1F840DE
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 18:36:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nTIhQcf6FQIymC6iluj4LnddzHNRXWs2ijv6EnnkVOugCPxj12rO6jmz3bX3Ib2sSBJMJzeZAFoYcUaNfgiOpIhaAYSloxMz9/2KRll7zx1qIdiCOonrV0iNj0Dj7siSUD0r43Ng8sWUrIblPjlkknevy5nIkh4ZvHIbyNiHW7JVakgC9LO2uxUjz6BSXK0BWyanrP6+6dUrOarezmEZW21dutMLbe+mgYskHcBV5zP+FWHrU9DbKfMb0w5JiLLxXxnwXEHPbkk6IptHZjofR2n3YKPwOlZBANTe16C0xVl6Xrr9TXMaze3kfF0aljVgwmyJFIqyELIrsvAtjHpzzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SycckaEtKsQwL+9AqEcCL/HWPpfBH/Yn574qY1FFqeo=;
 b=Byc/0jXjHp8SmZuUQ+P2i6vne1ZI5kmwnUkU+fZFQ6xd3wd0ES+trO8+F/NrinPnEeXp5hWYA3LqPpNMeuuYL0MqXA9AzcvNct1tkBNeMCPpfrlHiMx45JE0okZp9qTohb+mrz7vKdWPUY/DAqFQo8elWg9zZPvag7QK39Y83FwqM1tH9bG6FrHiOTh7B9TTynic6O/pvAvuvrQtATwfS1dokiJjERot6DyfNwfbm4spcQOhgn+HTh9QHHu7lfSbehveAXNvtZxUnrLRzs+tQRprFFGRpLBBFVR7nN+wID6PMuMU1Bmv6swWPzqpxMF0xxos+f8Oh8ggYteXE4c1yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SycckaEtKsQwL+9AqEcCL/HWPpfBH/Yn574qY1FFqeo=;
 b=tr74NzIcjo9V9Dks3RjYkcRDuP2EA0OZOmxwiTd/3Ep6XwykE5nugV6x4bKZ05WJti5tQubx2hc3QNxDTwvPNxSxsD0EW8qgDr1MJAMuk8cOWAe0oOgOWdu6rDaObRXKXCTlCSdEofYWjeGnlmhN3Ui/kMjlvUXSR2hx6phVG+0=
Received: from BN9PR03CA0697.namprd03.prod.outlook.com (2603:10b6:408:ef::12)
 by DS0PR10MB8078.namprd10.prod.outlook.com (2603:10b6:8:1fd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 31 Dec
 2025 17:36:49 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:ef:cafe::13) by BN9PR03CA0697.outlook.office365.com
 (2603:10b6:408:ef::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Wed,
 31 Dec 2025 17:36:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Wed, 31 Dec 2025 17:36:48 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 31 Dec
 2025 11:36:40 -0600
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 31 Dec
 2025 11:36:39 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 31 Dec 2025 11:36:39 -0600
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BVHaOqs2541396;
 Wed, 31 Dec 2025 11:36:36 -0600
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v3 03/11] arm: mach-k3: Explicitly identify TIFSSTUB images
 when discarding buffers
Date: Wed, 31 Dec 2025 23:06:13 +0530
Message-ID: <20251231173621.1069988-4-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251231173621.1069988-1-b-padhi@ti.com>
References: <20251231173621.1069988-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|DS0PR10MB8078:EE_
X-MS-Office365-Filtering-Correlation-Id: 084340d0-d2d4-4d8d-4250-08de48932d51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3qRdVjkYKt5pJ6Ep0XjoRLCNvq29c1NqDfU2jlPm9iXhfAvd0Xm+lplYD0Et?=
 =?us-ascii?Q?82RNi6iL736nadvpAHQ0fIg4rQbfw5LeXGdCSenJCuEYnJIkxI1RKoxd4okd?=
 =?us-ascii?Q?sfqR8tY1tQJMD3JNm4NChf8CYS4ZEVA7an+dyQPVo/xfIoADbk5wVsq2x2fH?=
 =?us-ascii?Q?j5+SVZVB+SHssIjEGRCoyzwt6xlQIhIss07S1eQl5sOr+TGtF0XwETrHxdQ/?=
 =?us-ascii?Q?gJS6ZBKqyt89f5cbGaa0Qcsb09lBqRXJNftqcmpIbAjNxy7ylxmZL5B4UsfV?=
 =?us-ascii?Q?GQw35TE+8BTKYlWkxi2MGf5El5eTRwNPtXizxUpOxaTSU1es9TQyWpO/rUAH?=
 =?us-ascii?Q?67eXUMnOyuMaaXFEJMVRtpPNP89tjVc32yyBETF/+Mrtn5Zp+Usgfl98T488?=
 =?us-ascii?Q?8dzx9KEqVpHIpSPjWQA8DzQB30BNkPSiCImpVuplr2Ry4SLKKDZsQEjnYv/g?=
 =?us-ascii?Q?hqEMlfxi2W/PYTHLAoGjC4wmtiUi4I+2xDrmtmPD1VutfYkfzc4FZAFCizRJ?=
 =?us-ascii?Q?ivGTLRj0tgohOSEgGObj1EXYhYcOL6Uy4DP/nk1zuCSXK4H6UsmAK9MqPJmk?=
 =?us-ascii?Q?XKkMzCBfkSmdESvQWHpMbeA/fBsGPjB6tERQHSsVYcgJKGogMXDt2btU25C+?=
 =?us-ascii?Q?LY4JwWfASRuaLT0yda9We7kG9RtZ6mBGIFVFymjcBh6VFRrI028gNNtM5ocD?=
 =?us-ascii?Q?KMzCoBK6ZO4jxD6A+4C3LRiBMy422g4CV6BaUl5TX6hO25jOrUzSJ80AA2/y?=
 =?us-ascii?Q?uE9RSBLttJtEGDPQyRqFBrU5x4YJELmd1LBbC3UVlh84swqH9ctvwHSf0wik?=
 =?us-ascii?Q?kVxN90rgN2rbp60mImD5tTLJUeEc4n9MdBUGCjFhFkdVJ+lg4y8SXAF1LEKV?=
 =?us-ascii?Q?CgK2vYlbLocspKkyGHUy6b9EhWeGM4A8T9O0ih0wBMpO28wetrtZ4q6icffJ?=
 =?us-ascii?Q?RkP84ApUFd/KPyA9NwuvNwMsLHlkr6CdUjroXJxNJ/wNln1sYwI797xT+Jqh?=
 =?us-ascii?Q?PbhWzl4m5/ZypTxptoVEAq879x4fKgqkm2LaceAJb+wJaZiohEfiU8kyGI14?=
 =?us-ascii?Q?e42AN407XugMkGh/Pt+47A4Ou6wNziw2DeAFDHSJ4qRQn7EqTpnt6QDKwKNt?=
 =?us-ascii?Q?p4XP3Rx8B9Gxe42+rzTCIPlT9eV0+pHDmchtpUXdelZi8hR6UMP7mWfSnkLa?=
 =?us-ascii?Q?/JjbRPKdNUwsDKvxXTIuwzBTPAxIYXA83jkI1WzEu8wzLlZF6ZVEcjqrOoFv?=
 =?us-ascii?Q?fXCYT7D3Kvx9ZhzgD2uxDchyJNp1pQu/PIaw8svOBjm2CcJ82UjvaXz+2jP7?=
 =?us-ascii?Q?e6bSG3OX7Vsnp3QesPksItvcnaqUqmfIOkLvfEjSEYE4IutDxsuGc6fX8QYu?=
 =?us-ascii?Q?HNrjld+BlNld6LzM/HCnEOdcyILwiRmKH05W0UCuokb99+KtNSqKb2+S/Gop?=
 =?us-ascii?Q?CbREMLXzHintpAoEYg/LvYwVaei88IZjEjSq+OvWQ1oFGXB9LxaM68ezXQ3M?=
 =?us-ascii?Q?TkLDIzuKJAsQHmZOhkuVrenh3WcXNT0DDWF1HiyMlekyEwQrRJrDl5/wd8d0?=
 =?us-ascii?Q?MGS61L/SUgKkO9LErUE=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2025 17:36:48.9692 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 084340d0-d2d4-4d8d-4250-08de48932d51
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8078
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

The board_fit_image_post_process() function assumes that all TIFSSTUB
images appear at the end of the image_os_match[] array by using
the condition:

	i > IMAGE_ID_DM_FW

However, this assumption breaks when new image types are appended to the
enum and the array, causing unintended image types to match this
condition and having their buffer sizes incorrectly set to 0 with:

	*p_size = 0

To avoid this issue, replace the range-based check with an explicit
match for TIFSSTUB image IDs.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
v3: Changelog:
1. None

Link to v2:
https://lore.kernel.org/all/20250506104202.16741-7-b-padhi@ti.com/

v2: Changelog:
1. New patch. Fixes condition to allow new images to be added at the end
of the enum.

 arch/arm/mach-k3/r5/common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
index 390e1324fb9..da1d1cb7230 100644
--- a/arch/arm/mach-k3/r5/common.c
+++ b/arch/arm/mach-k3/r5/common.c
@@ -366,7 +366,9 @@ void board_fit_image_post_process(const void *fit, int node, void **p_image,
 		}
 	}
 
-	if (i < IMAGE_AMT && i > IMAGE_ID_DM_FW) {
+	if (i < IMAGE_AMT &&
+	    (i == IMAGE_ID_TIFSSTUB_HS || i == IMAGE_ID_TIFSSTUB_FS ||
+	     i == IMAGE_ID_TIFSSTUB_GP)) {
 		int device_type = get_device_type();
 
 		if ((device_type == K3_DEVICE_TYPE_HS_SE &&
-- 
2.34.1

