Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 954DDD3C925
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 15:49:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF5BB83CD2;
	Wed, 10 Dec 2025 16:48:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WAfswAK9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9C8283C08; Wed, 10 Dec 2025 16:48:57 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AC7A83C7B
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 16:48:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vishalm@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O3GEtOAI+MBlXrwLQ0LRB4WCIGpnZalao0qVpkcO1CAkgSmv5SaBEcKCxPK8XvbEQcf1uNoqFpGMgOiXApoMvp3hBRt/rMjmyKpoH37SVlNlUnhtMyyZ9vDU9OF+Y4Y90OuC4NgEc4C9+u7xr2VacPWJCwNQnqQYUW8xuxIXh6FFqWgEtXWCgLcyfg97uqEpuKrSiS6NfN/a3wAQ9XIvrTIBumWv+2+f44nrxzVJcDwAqlbP9K0NrqE2XJrbPYpOJu6ieft5619slXz1HG4sFxJ7t7+qRrWLq3wtRyaI0s2uIMSmiMB/ooROeC3QT+tG62j5JmLOHBQurVv8cJ8U5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQyuJlUxjsy8QGVtObLJY1tv6BrooYZTm5b1xpbOCVs=;
 b=jjP0xLo8x2N+BQ2hZKh9VcA7JiaH6qegTqE2bg89Qry5zBifRe0PPDZzw4ahKHQnTeM4NGwMRQ3DTvvHgxWI/jLhJc2QhCnOPaI3WP8j/IxRn0XXoZCG14puG5uvZ9qclOJLlBcQG6l3gtOif8Mx+xfT980LjKZ3m93uvCvmLvUGDW69Gq7SERZ2cU+7QVeRJXb4oDaiAxKuYinLiI1Ip7TJESaumjvenAdb3l2a87eSw4kuX5Bt65f/yDBwFB+GRXVShfqKobywhlt6aN5inDW7asTElG53kgtdoxLjU7Lc5KBn5qg1XbJlrO4o990GmuqoMrCwcQAvqxzWUnYU2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQyuJlUxjsy8QGVtObLJY1tv6BrooYZTm5b1xpbOCVs=;
 b=WAfswAK9LwR0s5b42VsX+ewblqzazv/0oYA8z65YLzWNjMmP/TwZsgshcSGbkGSLOvFJ5vbFgeJKba0ogsU02t1pNdo1hqp+lc/rPAxA1TWoptDa7kEV01OyoQwoukWXTz9fhA2rUyg72ES85xWXxpHQEBAVnrqjV19BP4HfjBw=
Received: from SA1P222CA0046.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::14)
 by SN7PR10MB7074.namprd10.prod.outlook.com (2603:10b6:806:34c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Wed, 10 Dec
 2025 15:48:49 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:2d0:cafe::46) by SA1P222CA0046.outlook.office365.com
 (2603:10b6:806:2d0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.7 via Frontend Transport; Wed,
 10 Dec 2025 15:48:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 15:48:49 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 09:48:46 -0600
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 09:48:45 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 10 Dec 2025 09:48:45 -0600
Received: from uda0271468c.dhcp.ti.com (uda0271468c.dhcp.ti.com
 [128.247.75.68])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BAFmjru3199756;
 Wed, 10 Dec 2025 09:48:45 -0600
From: Vishal Mahaveer <vishalm@ti.com>
To: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH 2/6] board: ti: am62ax: Add basic initialization for 32k
 crystal
Date: Wed, 10 Dec 2025 09:48:40 -0600
Message-ID: <20251210154845.3852231-3-vishalm@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251210154845.3852231-1-vishalm@ti.com>
References: <20251210154845.3852231-1-vishalm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|SN7PR10MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: f6c91a27-dd50-4880-a030-08de38039c4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VMoLiK2nZYoiSTdsZIQfzwHWcPKvFAlXtydwJLNeTgitAHsIOLQ5BOJ2VHnL?=
 =?us-ascii?Q?yh+rUBPHoYANtUWD7ee90G9pFBV/gUPsfDBBTqytP6pnBBOYuQl1JNqG3mSw?=
 =?us-ascii?Q?3arRr/Li2KNppvqKx0VTxtfF94nweM0SGiBW2YYKmqkzjK86gCKDSc6xnONr?=
 =?us-ascii?Q?uQYK06H3/Srjp8h5QFXeRJepBCaopbi0xty98egN64qNxUqtFutgxo+GvCMp?=
 =?us-ascii?Q?13TXHmzAl5BnfmvvCrNCz8iM5/+st7N6Sxet+NJH0NF0uoo3dJcQ7dNYKL5Z?=
 =?us-ascii?Q?qqrdkVNbvljodrMZ4cs/xXIKbLHCQJSw/kbbipPtQiHDNtBGQVBiq8YFpNbZ?=
 =?us-ascii?Q?T6zEh/vehfgZSiD40jhuG98fBgpCppO18aEOIbjdtoI4hldediux4Mzlz/2R?=
 =?us-ascii?Q?9RlN4md8nGPwzixK1bq6I3LWM3cbCetIXjxWMbFB+i8EEbCKqqE5QE3dRbv9?=
 =?us-ascii?Q?UTltVu+aXV3s6Ex0KZV3O9q2S79ZYG5WOudm4dgx/oUccWQgJ0C/8GH+x6FQ?=
 =?us-ascii?Q?gbJhLqoKfu/w08lV1mf4ITXMaiS3VwoEdIFikZpb+D/PJjBEresMW801Aw1p?=
 =?us-ascii?Q?5QR8WKt7Pefv4zAqWP/Ux7URM5eeiyB6dJhzyfm7/3QVNZDUN/TXM2QiG0OD?=
 =?us-ascii?Q?QdfzvNvBx57SoAeLCFsPreS6SRCJJR6mOZw1EYxaKyOyjmUbG55cmWW6McnW?=
 =?us-ascii?Q?i6M40noC8Kg66UpGtx17x/Q4+vxiToZwr3oMZ3rpWiYuRv4HYSRXW6pIc8GX?=
 =?us-ascii?Q?rHmms5xo2UXGa9vXydd2+6V5REv7RSvD/1e+nU9TQmoYI8toCz637WJuAyUN?=
 =?us-ascii?Q?haeCUz/KWZ3R2B64K1EHwGucZPPfpx3rBjiwkxuAgzZn2ocy/GyPF8yOxAYe?=
 =?us-ascii?Q?jRKYCxkqPPWnQIoofuixAvOOutm9FGdYCRzvaQ27Bv4C+H1e9s3/CSC3Yxrt?=
 =?us-ascii?Q?+lgvsKFvqBIaiSjXk26+q+cdSBrrT7WlAzuTO/IpSEfKsVoeCAV/7RajPRCd?=
 =?us-ascii?Q?xvscV/Lvxm2MQFcmMOB2LMijOSQ2ynFEH4ikrGxSzmcoOaOHrh/eRKE4L1yL?=
 =?us-ascii?Q?4ZqiJ2B96xVhHIwyId6V1/4pMCqbKPwgR8v2+JaG6VmK5d3vaCTnaEvcInhL?=
 =?us-ascii?Q?NFma9+5UWTWmHrtn2ARju9/zPDewZ+hqwoXe7WivenSnNmB+CDe+G8j5HFEC?=
 =?us-ascii?Q?+IL5CK1AS+/xReYkuZ6gUGHixpPfd3eu/H8TpJXoJySTXL7M8PEsVN3WniYs?=
 =?us-ascii?Q?OSHuR82oSIPMGHv+kUpXm4WQznG9b9OMvVMGw3NOB07Sp5+QcheuAY0IRs+B?=
 =?us-ascii?Q?L2lCAhHAqXZ9iDQLnfiRm1xNm0864AeMLPKBbOWvfnTh9memSUhc3mItKbgx?=
 =?us-ascii?Q?6Qdx9CdTldItcKQmNAnA9HS5PFD0wr9WNZI1OfFCpqR1EQOh5b0dRex/1DWx?=
 =?us-ascii?Q?6C3OwDApoxnn3qigL/aOAU6k5vvU0WYbyVqG7J/Rk8D1edTfT5UhNFRamjr1?=
 =?us-ascii?Q?SL/OQ8i1lZFQcKGCcmRyXJeJuJ43LRp4lq0dv7mSJ7CmsoDRnZ8ibpdhyYb8?=
 =?us-ascii?Q?8rne81n/8GVL2lDD/no=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 15:48:49.1031 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c91a27-dd50-4880-a030-08de38039c4c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7074
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

Do the basic configuration required for enabling the 32k crystal. If
external 32k source is not used, 32k rc-osc comes into play, which is
accurate to +-20%.

Signed-off-by: Vishal Mahaveer <vishalm@ti.com>
---
 board/ti/am62ax/evm.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/board/ti/am62ax/evm.c b/board/ti/am62ax/evm.c
index da6c31176cd..fffbddbdcc0 100644
--- a/board/ti/am62ax/evm.c
+++ b/board/ti/am62ax/evm.c
@@ -35,3 +35,19 @@ int board_late_init(void)
 	return 0;
 }
 #endif
+
+#if IS_ENABLED(CONFIG_SPL_BOARD_INIT)
+void spl_board_init(void)
+{
+	u32 val;
+
+	/* We have 32k crystal, so lets enable it */
+	val = readl(MCU_CTRL_LFXOSC_CTRL);
+	val &= ~(MCU_CTRL_LFXOSC_32K_DISABLE_VAL);
+	writel(val, MCU_CTRL_LFXOSC_CTRL);
+	/* Add any TRIM needed for the crystal here.. */
+	/* Make sure to mux up to take the SoC 32k from the crystal */
+	writel(MCU_CTRL_DEVICE_CLKOUT_LFOSC_SELECT_VAL,
+	       MCU_CTRL_DEVICE_CLKOUT_32K_CTRL);
+}
+#endif
-- 
2.34.1

