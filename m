Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D5FCF58C9
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 04:17:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 286B589127;
	Fri, 20 Sep 2024 06:17:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZzhWITaN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B714892FC; Fri, 20 Sep 2024 06:17:47 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::62f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C49D88B31
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 06:17:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dyRel1O9QykAmYMFM5lEAZUbZzReyajdEu904+gnc+Mos3pNoLyEUMl30OS76TvAXokRLd/9FpJmkyxRebk/r9ZaxD/tNEmpYzdu3h8Brpl/MqG2eHh22pq6z1upvjWd1cJ7BwAOGtQyYAthfzrZ4UeHuWaN33wdMqyBWu+vhRUMsnqzVJAMa6cKLVmtZyJ7yYRoSPCXaQndxdgpwcG82UrdNJbuqkqAOwACBqW8mE6wYQYX5NVAyaA95hEkDGc3dtfbnp14XZfuvhMMfvYrtzjLuTWi4WgG6zirlFuzMidT8vy08lfaS9Y2dVoi0kAll/bNnVLOow1ukaml609Izw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNGijAOAutP2FItcxCeecBgDrXlkyY0M/Vb1JHVa4g0=;
 b=iuuXoUkvkY8SiDILFPHhkQjjln1gfytnSeDM8ZLv/cqMdAkjIzDaV8A18P04iVBB4+xKW8aJFTSS/PWtlKcfWH8akfh6SBMENSwuDEa/dGjL8ajBp/fHZt1zvTnFyAr55XoTXIr+/lMD7WQ7rdgmQd25ooKQNZ9T/JV1YZx1ur/kyVKQAQu1e4C29HvtKQVUp8Tgjbf4TaPqG40bhsN0/fkvND1WrBRE5e/SQS6FytdyzZPrxfEy1HN4GEyZYVB2M8kAC6WTDOtcuUhBhMPXL3yJoFeBfhmGxCMUv0uSAdpEUbgGUuJCt5JuruF1ScWatFW2l5JleHk3P+MAE8ojFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNGijAOAutP2FItcxCeecBgDrXlkyY0M/Vb1JHVa4g0=;
 b=ZzhWITaNsbifY1nIJxvhW1U7rYXVzK4zRIf9OQiDBVGXXAIcw6T0PqFXVjteIPuWMu48QL62amJP4U7ceFBA/WEDxR2sLAI5OcFZ2zUDpY+otE5wtfkLykjMDTizydzklEq6bhl4g7us+h+gQZrt2Q3oXprUhUOyZExfFW5f8fY=
Received: from BLAPR03CA0124.namprd03.prod.outlook.com (2603:10b6:208:32e::9)
 by DM4PR12MB7694.namprd12.prod.outlook.com (2603:10b6:8:102::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.21; Fri, 20 Sep
 2024 04:17:39 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:32e:cafe::9) by BLAPR03CA0124.outlook.office365.com
 (2603:10b6:208:32e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.29 via Frontend
 Transport; Fri, 20 Sep 2024 04:17:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 20 Sep 2024 04:17:38 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 23:17:33 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 23:17:15 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 19 Sep 2024 23:17:13 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <neil.armstrong@linaro.org>,
 <bhupesh.linux@gmail.com>, <n-francis@ti.com>, <git@amd.com>
Subject: [PATCH v2 3/3] configs: versal2: Add support for AMD UFS platform
 driver
Date: Fri, 20 Sep 2024 09:46:51 +0530
Message-ID: <20240920041651.18173-4-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240920041651.18173-1-venkatesh.abbarapu@amd.com>
References: <20240920041651.18173-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|DM4PR12MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: f10afba1-22fd-42c7-032b-08dcd92b29c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+Az+CEn7vGNcc7NqUOXcVX+4sv6YiIsKHrObIwV7LJ3Yhddc5I4nMB0qndP7?=
 =?us-ascii?Q?IswIvRmezDwuMSnMDvMKC4sa+qho+UKkFvlUipY8dsoQUwpNGMIOXxqgezVI?=
 =?us-ascii?Q?/Vr72x2n+yq7JfdFHISI+lkPPY9s3qqY4RS7xABR4ncBkGujlkJWbfhmZyqV?=
 =?us-ascii?Q?1VOAAU5G+TwjVrGvtQ0Autf2JaXGzQMgIgi8AzwF8qsPYnQBmuRTQq9JlhjZ?=
 =?us-ascii?Q?FGdrLtBgqy+kc6CrSfOP7yy5CZbZOjewE2VjN8pFo2x+uCbcGL0l6nBC26Ss?=
 =?us-ascii?Q?9YUmkq32WZKzlSyyEOtNtnJnHaPihu0vWu5M3l8nOkrpCLcY8hjQa69Cxq8C?=
 =?us-ascii?Q?LI+bz+mt58TzS6BC4Z/+iRskSpVCkH78pthQdkgo7pFG4yiRJjDizPvNUCbg?=
 =?us-ascii?Q?KQeON4rMKEqSwUjC8Rfy2sgPJE3iGYjPup4KJKyIDwOI+D370xgwRN1bkJUe?=
 =?us-ascii?Q?CNM/LAfbB0f0BTSHp4nyb1YxJaTSUbn5ETaYBvRNd7chfwcgB1ayqTo8zBCT?=
 =?us-ascii?Q?yWZOZwl8aa6DkqyWRBzWXolVVoXvUPRJSMYPqd5ISoVR5rKJYcusQSIKQErH?=
 =?us-ascii?Q?SlgRZtMDnrPJT24SplfTph5Lt4c1QqR9z1fDByLyIYr8gdVMAdNGYRfVe7Oj?=
 =?us-ascii?Q?1kQROcyBmGJSdHak5JlOcCX/SFncnIKX+xOiOgHRN7tckjKVUzm0vOUchJqw?=
 =?us-ascii?Q?SCUu6ziiUn1EHqOCRUc7axLXdb2yz86Uo8Y+vOCbwJrbSis4cAxG+pvy1pQY?=
 =?us-ascii?Q?4fODy7VNcHx8HplrsZXbGN20EiQHQp4L0EkaD/ggioKqddIj3BdJhgALSy8J?=
 =?us-ascii?Q?QXKWWN9VNeqg4BStCsu7Jo2H2mdKMgnXVWELkjYud/LeIT/jdH8CVpKwAZff?=
 =?us-ascii?Q?Rg9KacTbiKrN9e3Gq4i6OAI4ykQGcynrSjsvTfZCrp+ee+/MFwYEIFRD4aLw?=
 =?us-ascii?Q?vPA9n7yLrdrYtkG0tzZ9SpoQ831uMYDdVYMRZSXrDkO2fHg6CttrFI/vYLYL?=
 =?us-ascii?Q?FyVGxoAJPydwpfnsv3kHqhGBRhkZv4j+xR9PKy+YfjzUFrilUh50wlA1ttoq?=
 =?us-ascii?Q?Swuuhxl90hDPxZ5Cg3Eaz4Wnc0rxh1EbCRxANXIuwKRz9Yuis3unuOxWQAOw?=
 =?us-ascii?Q?wYi7nVVTwNlQJ4kvbiNHb+LGVUmmhADd7u2mlb2gO4DVc8oZQR97iMVzTRDp?=
 =?us-ascii?Q?nqGm/ORW3XXAvaL+ITY6u+YMm8PSX1vORIMfXACmRjPWO16TggfWUDf1EBq9?=
 =?us-ascii?Q?2S/Z1XtiCf0BJYYI12xXOqd2uLGNs70b9caVpFy5zUOUO8tW+M/fRvtDd3bx?=
 =?us-ascii?Q?5wmOYeoAe/Mjn+rgDZV//ivxK7rx3t3Ekwp7CExK/m0Ssu/1TP+AQieV4twI?=
 =?us-ascii?Q?/qCxZLpj35TaWtLImz328Bb86P6J?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 04:17:38.6479 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f10afba1-22fd-42c7-032b-08dcd92b29c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7694
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

Enable AMD UFS platform driver.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 configs/amd_versal2_virt_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index c4bf77186c..666d76c449 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -145,7 +145,7 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0x0300
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_USB_FUNCTION_THOR=y
 CONFIG_UFS=y
-CONFIG_CADENCE_UFS=y
+CONFIG_UFS_AMD_VERSAL2=y
 CONFIG_VIRTIO_MMIO=y
 CONFIG_VIRTIO_NET=y
 CONFIG_VIRTIO_BLK=y
-- 
2.17.1

