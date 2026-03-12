Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686F0FED2CC
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 05:00:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9854583F8A;
	Thu, 12 Mar 2026 06:00:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jDK6MIjx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CE9083F9A; Thu, 12 Mar 2026 06:00:55 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6BEB83F75
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 06:00:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mCMc69A/RTXRFdmh4OPSF0UTQyMfmtW4O2hKklagbE3YJW2hsyaIsa9I1wmBF4JSiXcKVDEO+yE5uClmUPKzENHd3roWYoqhPQf0mwilnQ+cIazS2x7OeMqmryIcsmGOIAmhT7Vao1+xuZTGdVXw7FlYNCi4fmXCX3rUgI/6wdN7tWttZszcVch/BfxBpKgdbev9Bcej+0t55f+DwOvi1LEXRndkHND7NtLwnDgaVMSQ2l5i70IRfv3i2KTiwvRTPLAaGPiWE5UrOK/NPfy1qjPPSI3//6XCQam0lPazVCRdU8qugcAyQ5mdgX5wu32pWLR16xG2aRm+IYBYPpjUMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7GrJPqxioU4Qk0AHwI9tP/Vnk9SxC5rWgEdafJV1D8=;
 b=ZudvgGyu5SRDZMWWFYqTCDUGad2gj86+uhlj4mraV5qozArLk7mgk0mVRmmuTjlx5aVTUZ2glTxzEn5bZ5p7NN6NOC1bY5kDumhOmhtad6yxPmNbAS/ERi+IAsh5sn/biYxnp1eOHvVHI54SeDNH2kByVZl7Lun8G4+HGKSYI/8M2dTtFKKIGBoTQ9D0xJCybEmRBsWCf6xmiPge2+TSntcfHBMrs1TmmeG1QkrQM69FULP7BycYKA7UpYkB11Gg5kPatVoRI7b91vQdHweGMLuzWeD2xUc0qFSyzJ+gmEYhbm65bJyc02gGMb/faIxIvfBz8Nd044uWxRJ3ue0bxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7GrJPqxioU4Qk0AHwI9tP/Vnk9SxC5rWgEdafJV1D8=;
 b=jDK6MIjxOWncQ7SWerEFTOKbaJaxFeSYNcftOgLhmCRa16KIBW/46qcvDXmzzBxZbUWE30ubeQ7tm+z1fYrsHMqB+5AyNwBJz28dRF0WVDJ8+hjSlYBc1lfthFctD669oEyoJW3Ncluh1zFxrR8xOKymG0CE2/rjGVSe5nyffns=
Received: from BL1PR13CA0178.namprd13.prod.outlook.com (2603:10b6:208:2bd::33)
 by CH3PR10MB7457.namprd10.prod.outlook.com (2603:10b6:610:159::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.14; Thu, 12 Mar
 2026 05:00:47 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:208:2bd:cafe::5b) by BL1PR13CA0178.outlook.office365.com
 (2603:10b6:208:2bd::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.8 via Frontend Transport; Thu,
 12 Mar 2026 05:00:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 12 Mar 2026 05:00:46 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Mar
 2026 00:00:20 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Mar
 2026 00:00:19 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 12 Mar 2026 00:00:19 -0500
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62C50II92178074;
 Thu, 12 Mar 2026 00:00:19 -0500
From: Anshul Dalal <anshuld@ti.com>
Date: Thu, 12 Mar 2026 10:30:12 +0530
Subject: [PATCH] common: splash_source: fix cryptic error messages
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260312-fix_splash_error_message-v1-1-50fb62f972bc@ti.com>
X-B4-Tracking: v=1; b=H4sIAFtIsmkC/x2MWwqAMAzAriL9VrATh3oVkTG004IvWhBBvLvFz
 0CSB5SESaHLHhC6WPnYDTDPYFziPlPBkzG40vmyQlckvoOea9QlkMghYSPVaJ5vYz0StohNAst
 PIXP/dT+87wcaUzY9agAAAA==
X-Change-ID: 20260312-fix_splash_error_message-69a5ce19118f
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773291617; l=1519;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=ruSF1w4ShxmEwydf13ip3S/7ORYntbq+emZD2Kigz58=;
 b=v7QXwa35gT99qQHtiv5k6e6rr/qkBXhL5ID2Kp02SiFOU01/RUmSNiRi7vl2WTgYPzk3w6A07
 gP323Veym6aDHB08VU/sRrzX4nUDE1zjvX8FGyifM9zRK9dw+gfTcZI
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|CH3PR10MB7457:EE_
X-MS-Office365-Filtering-Correlation-Id: 96dc1c70-fd09-4339-6435-08de7ff4524f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: JuGmi1Q5N02r7H8sg/GDwznOVvbUUCvU8uLXOYnKcyRrR2dMDkE2v3vUEogEBiWPXxaAsPuquULzgMvdqLdVpLLE18Xa9xXb3mxdlDlz/+cSTNKqAv1gfSf94L240A5MjukXD+2N7s+QnQGD/Gt08/EgMO/Xb43qTXqnHQb0z7TXsHLAhMBZVdNhii8Imn0doEkcDrmmUEk7UCME+LWZQfKluCF/S1R7WhUk44b0MRaZPn02vCgfVLFxZfBggLHrhE+WjYPw1c5eDO7pBeDVj+zoLZ++fvdDkF4JCKobHAivA0RoBNC7wFVW+QGBSNcuKRPIEjszX7PXoCxkVyAs6hbvi8JQHuvH5az6hY+uiroLlqXNBwolIuvom7DIt7a7/8wMSM9ZoywScUilOzGW3oodci5vrjOw1+ctjsa/EmXH53HmBwkddAlUr2cWVAWYVkBbi34acK2tS1Ff/5F6Ks27zFricF1uhczjSOc0clYe7vavtxVooi5rsNjW4i3xjc8hqI02q64bJSUiwpf4bjOaX0sEETKup6/WikueA032R3QHpCy00/+m62U1UtdPx8GnUmCwh/ynF6paIC9Ig5pCiwOn5S9xeEXNkX2Pisw7tCFeXbWFcLJnhjZi5gDJHEol4slChjHuK7EgavOpfg7Z1g/1QrCSmSKVytlJIUFRQky9+uT0TVy5GAeICLf3aho+eFn06Qb/1aN63U3ES6Y79TtkrK4xm/KmIwT7BY9o169EnIP1etc2oqUBCLr7y1dRnoPUfLXGaUBmSsRK8Q==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8YOyXMt3mrCelT5qMnkAHfOkFJrrjxXQky2CmDcP18y62e6ha5N4fn794MPCF2mRkCcvnNNq4g4XL1uOh9mw2k/MR1f7MxjuzqwcuTxh/UOVDlAVlcRgN7ETlbbKy8yfSArGspxI0rE1q7kc/XyY7hlabCqpzRwX46B4mdY6KaDUJlMT543hrNkM58IPP9XLFbhCtqTKwnicB7iG6KJg/smQr3Pb8Qn3dzGT/m07e2Mwm7j4NcwUSkiqxwcBuEwLGNhj17VwBkiYKNyPqt/sX3yYVlPWxgcrlDzysx6wc//9bbeU0LJBZJOfxkNuyrVJpc5f4Mr83094tmfRhqoLFuhcEQzTyEv8dYM+tX1uMU+M3q2v+df61hl41JWe/fMvAuFC7jgX5FKCcQkBDLfu/MZhIWBecr2039pJ6XAWK0kMCoboqEH8jBV6txAPni/V
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 05:00:46.1650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96dc1c70-fd09-4339-6435-08de7ff4524f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7457
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

Some error messages emitted while loading the splash image are too
cryptic and don't provide any insights into the failure being a splash
related issue, such as 'Error (-2): cannot determine file size' etc.

This patch fixes the error codes by adding the function name to the
error print.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 common/splash_source.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/common/splash_source.c b/common/splash_source.c
index 0710e302ba1..55fa3870505 100644
--- a/common/splash_source.c
+++ b/common/splash_source.c
@@ -159,12 +159,12 @@ static int splash_select_fs_dev(struct splash_location *location)
 			res = -ENODEV;
 		break;
 	default:
-		printf("Error: unsupported location storage.\n");
+		printf("Error: %s: unsupported location storage.\n", __func__);
 		return -ENODEV;
 	}
 
 	if (res)
-		printf("Error: could not access storage.\n");
+		printf("Error: %s: could not access storage.\n", __func__);
 
 	return res;
 }
@@ -284,7 +284,7 @@ static int splash_load_fs(struct splash_location *location, ulong bmp_load_addr)
 
 	res = fs_size(splash_file, &bmp_size);
 	if (res) {
-		printf("Error (%d): cannot determine file size\n", res);
+		printf("Error: %s: cannot determine file size (%d)\n", __func__ res);
 		goto out;
 	}
 

---
base-commit: 8bc2a5196c1c0bb5dbdaca073323da0015a0de37
change-id: 20260312-fix_splash_error_message-69a5ce19118f

Best regards,
-- 
Anshul Dalal <anshuld@ti.com>

