Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2EA8FD3762
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 14:56:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6A8283F8A;
	Wed, 25 Feb 2026 14:35:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="V1QqbUrl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FC2D83F61; Wed, 25 Feb 2026 14:29:46 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E021483E83
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 14:25:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sparsh-kumar@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+cAqPtC+EMfL9eFPLisHUITqVC+XP4QT6YqSU3zXe86cARVO5LSQGpE+m846TYwIyYQJFMLxdjYEgeK3eeq4wrfz0TyYcB5zsPYresoomTf9KcTI1Eb8k8xbNBfPV4QZlTehgqEmyIJ/LidN1KigzhMG3lkTFViJO3+6UWleIaC7b3GkSKixupQSqhpTkIxkIjlDpHrWsmVOcx/p53pJ00tOLDrW8WcIdh/K9f1e1Bff3SC7cSgptla1bpt33Wup4RloSkdr7EY1jJXVeLh1GUOLnUnqESp+6zb7M9Cy39XIcM0MzcUK3H2fLoYn4JP2gdAoy0uFjjPDoV9jyAUEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rL8E/dVnEy3EHzk4M2Crixpx1HG/PCWTKdyFWG187sI=;
 b=L/kdLd9B0pqJlT6LPww4Ud/lxr4WcWdq/V/iAHLp7uAQUW31h7WNp/sUF1eLZwLcoI9nF78Yoa6hqXClBg+LZ+y3uPIwtArnKPW2vJMS3MWAxvdT+uGt+pamwRRIy+MNocO5UG5rF8oeVSazEUKlkO3XTyoOov9xWN8O8mZJLVA6n3p2KcAm1VTRWIeIgBoxhDieq/5obc2ynnI2dj1MnusPAln5apX7R4GKSf1N3HaJ6SwQQqPW4ovwlz1UHeIJFfePXbCiDo6pSuR3Bcwgh7gdSsNhsy6QH66BtGw2/nZr3XN7UYscI5k4uuv3CkK2UEla9t5cRdrtmfu2WY7IGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rL8E/dVnEy3EHzk4M2Crixpx1HG/PCWTKdyFWG187sI=;
 b=V1QqbUrla0Tnc2YPdnFEFvkvwl1bahKnple7LF335wARLEAGkgmOZEpKyJTWale+6eodZA5RcB5JF4IZLXLjShjnR9vqS+AnSKEMqImXYcVF9wKeQe86/Ki4Gukiz7pyNVv8kQ16mz1w7eu0vBz7YSb38xHb3IROlZFWlihFFQA=
Received: from PH7P221CA0067.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::28)
 by CO1PR10MB4580.namprd10.prod.outlook.com (2603:10b6:303:98::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 13:24:58 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:510:328:cafe::5f) by PH7P221CA0067.outlook.office365.com
 (2603:10b6:510:328::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 13:24:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 13:24:57 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 07:24:57 -0600
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 07:24:56 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 25 Feb 2026 07:24:56 -0600
Received: from uda0510137.dhcp.ti.com (uda0510137.dhcp.ti.com [172.24.233.216])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61PDORGv011150;
 Wed, 25 Feb 2026 07:24:53 -0600
From: Sparsh Kumar <sparsh-kumar@ti.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>, <vigneshr@ti.com>,
 <praneeth@ti.com>, <bb@ti.com>
CC: <afd@ti.com>, <n-francis@ti.com>, <vishalm@ti.com>,
 <sebin.francis@ti.com>, <d-gole@ti.com>, <a-kaur@ti.com>, Sparsh Kumar
 <sparsh-kumar@ti.com>
Subject: [PATCH V2 7/9] toradex: verdin-am62: rm-cfg: Update rm-cfg to reflect
 new resource reservation
Date: Wed, 25 Feb 2026 18:54:23 +0530
Message-ID: <20260225132425.3096103-8-sparsh-kumar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260225132425.3096103-1-sparsh-kumar@ti.com>
References: <20260225132425.3096103-1-sparsh-kumar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|CO1PR10MB4580:EE_
X-MS-Office365-Filtering-Correlation-Id: b958db47-497c-4f10-b169-08de74714589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|34070700014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: K0FS5Y7GgruM15fekaTOslbzLQyZtkBp7wxHSuNYLBMFU+avmdhciD0eOBjiBPr3z0/RZxwThuRehMiHqEg+PEs4UEDX0Mns61pLsKm7PNDP6WpkGSx/0QlUBq/9J8V+5r+343Z+wA0JVZPcb6Y+pVxyo5Vo0MzpwE+YbaTW2XnKx/LL76sSJqhCdCAPcuLNgrzoipqexEZPyvXNkg28PWCdDdNQpFgnAuFjY0liEKl2VdWitaAwGLwBc0AcbFRh+THwRqLLB05k4fizv77B39Kv632EYlBURDB7rKTGjv93ly7v2EQXpuQtDKM50GCn+NWIW63CGOgElixp45aZGArccA3I409qxLPuXzwWU9Tc9yZ6tREsIkelEDxhLWjjEkzwp4RAi5HSqjtLpfZjtie/cQZAb+QkLuPD16z3B+uQIadXvzrNE7siv+rJFiIHy4OlGAnmZm4Ve2ztI/6lVIv28jLimlGNn9VaF5HBpjpqiK+nPy1xNME2NVW8+z4bN/K5l1jryZahMNlH6kpKXHG53pb66DwvqiP2IQSj/9FG3erYEzdyHRFioNSOIf1TQX2rZetNxd8QBGdfRPG28OP9vLjmZIdKUWJqiqnkx4qyhDFk8+9IWtpqKULBznJVFzDkmhGy0kcrgpKLCFotF/pjfEb9U+AdAWZ6/dzS//qRtPIaYYMG6EpU0299LPYARgkAGzM24azcHNjs7EyuTNs1lX8Aft6rixQu1eF7SovrAoZecgJHUlHpGLfBHED+8uDRGHTsbZ6WCAHhAxSaeh0024E610kUP81I4ESIvXsixj4XhZYfw/dMOBtipBsquRikttKpe8RZAasw8ECM3Q==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(34070700014)(82310400026)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Z91S6ui+cm+8EAczFTUDdgDurgZP2CWVixdzYlfh/gDuOhkDjI/m9dQ8QCVgh3JPQWGD/tmusEfFs4XnGubbmT+mkeBv2i9KRYQVcI0hIe4/MIHDZZG9GqNrOzUtTACpyIiB9yK5h113LtL0JIxDJgsDfeIvasRbu9dGYZrr+a6oG252tTPykhJoyy+4uBbld3jNH2b9hXMb3ZfJ8sA4QDJKXYtXdMnzfcuvRkEjee3tjIde4NSGyYOAhXFpbRNWqpOrbWjVk62edvG5u+1TR+llOvjQmQoihBnqDwkIgW+LYfF26ZbLvZ0xDdu03CyVc71RGFjn4RFS4DO/4m4DirqLFLxVh9V8EZKM1KosagRiekNpDUG67xxupqY0trfVeHl+djCMpo+LGraPoFjIXTgK6J/IIQAkOTp4CsYPhB3gg0OtpHsYRtWoVC2a9kDi
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 13:24:57.9171 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b958db47-497c-4f10-b169-08de74714589
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4580
X-Mailman-Approved-At: Wed, 25 Feb 2026 14:33:08 +0100
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

With the latest v11.02.09 TIFS firmware, an additional
virtual interrupt and event is reserved for MCU cores
to DM usage on am62x devices.

Update the rm-cfg to reflect this new reservation.

Signed-off-by: Sparsh Kumar <sparsh-kumar@ti.com>
---
 board/toradex/verdin-am62/rm-cfg.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/toradex/verdin-am62/rm-cfg.yaml b/board/toradex/verdin-am62/rm-cfg.yaml
index ea5f2423cf3..8204031449e 100644
--- a/board/toradex/verdin-am62/rm-cfg.yaml
+++ b/board/toradex/verdin-am62/rm-cfg.yaml
@@ -525,7 +525,7 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 168
-            num_resource: 8
+            num_resource: 7
             type: 1802
             host_id: 30
             reserved: 0
@@ -555,7 +555,7 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 909
-            num_resource: 626
+            num_resource: 625
             type: 1805
             host_id: 128
             reserved: 0
-- 
2.34.1

