Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56512FD374E
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 14:09:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8258983FC6;
	Wed, 25 Feb 2026 15:02:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="O/vywmCD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A743483F9A; Wed, 25 Feb 2026 14:47:32 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EBEC83F4D
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 14:42:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sparsh-kumar@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eTLxdAprnF4gaLEhbn+z3UQ9HmT8rVrkJk/l9nuAMS0m1hj6UPLQ6uR09+D8hzlWFZfJkPVB0oHB+o68dE+bY+1JkNCrzm+Oz7se+dLPOzXo9fKLncxy4nSSvrthE2v/YndjmRsaG3xKzHu/oSzCthRrMbHa7gT/TA3NjT/E9gmMMBV84lv7SI770uhVpCrl1c5/4d/HhIDLNBTHHDoZX4Zye/koZ3lioowMzsv9lDp7RvIAHQv3CHbettz16ya67N5LBBjGet9FnnzYtrF7LGMYOIOB6fdrCKoWXqIRLGVM+sFM6ld6Zn/HPmi6kxkdcIVOp+UDxqg0ApCg0XZOkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSVyl5iibkskm+roI9pV8BS7lYd+usYxPfVUFbD6hrs=;
 b=bUPWEtFBM2yx/YPzHoizlDqWKD3p/NHe1FYLqn6AaMagIVHJ3sK0gLT2bTW/ZbJ15vf2528uc8jBLOX5GXwm6jFrx+9gMSvL4tRENxI8H1ugGOu62cf9ISmwUfiV10ym0r/2RKV6OFOX6/CjJhr3rLpXcvY9Mcde7BRB54wqcyMSX5J0aEhx/UothTQKpEGfTFR/hGMbhpS8SMJTVTlnp0YisRq7X9FZc//iORVrBl5tR9iVCRs3f29ZofGdgkXzwpfxdaY+nXhV9KrODxiBVOpmvOL18/oMcGq2CcATrbXYdBj7CdT4T3hOBnNrzTG7/y+Yo2gWHjTE64LQKOVn8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSVyl5iibkskm+roI9pV8BS7lYd+usYxPfVUFbD6hrs=;
 b=O/vywmCDZ9VTUBIrp32286LYGhohKO7PmkIMKuRzjip7eovFJRHD2V/PxqJUu+Vbxebtl2ia961GDvSJaDVvr0AvC9eXWqDrvHXtOR8SToc/Yzzv/j5EgRmz6duyqG9wa9ib0vOsUY1RX+xacPD0ewU5G7LRVPRJDSW0DRzWZrQ=
Received: from CY5PR22CA0076.namprd22.prod.outlook.com (2603:10b6:930:80::23)
 by DM3PR10MB7909.namprd10.prod.outlook.com (2603:10b6:0:45::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 13:25:07 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:930:80:cafe::f2) by CY5PR22CA0076.outlook.office365.com
 (2603:10b6:930:80::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.24 via Frontend Transport; Wed,
 25 Feb 2026 13:25:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 13:25:06 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 07:25:05 -0600
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 07:24:53 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 25 Feb 2026 07:24:53 -0600
Received: from uda0510137.dhcp.ti.com (uda0510137.dhcp.ti.com [172.24.233.216])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61PDORGu011150;
 Wed, 25 Feb 2026 07:24:49 -0600
From: Sparsh Kumar <sparsh-kumar@ti.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>, <vigneshr@ti.com>,
 <praneeth@ti.com>, <bb@ti.com>
CC: <afd@ti.com>, <n-francis@ti.com>, <vishalm@ti.com>,
 <sebin.francis@ti.com>, <d-gole@ti.com>, <a-kaur@ti.com>, Sparsh Kumar
 <sparsh-kumar@ti.com>
Subject: [PATCH V2 6/9] board: phytec: rm-cfg: Update rm-cfg to reflect new
 resource reservation
Date: Wed, 25 Feb 2026 18:54:22 +0530
Message-ID: <20260225132425.3096103-7-sparsh-kumar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260225132425.3096103-1-sparsh-kumar@ti.com>
References: <20260225132425.3096103-1-sparsh-kumar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|DM3PR10MB7909:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d0817a6-3acd-4c42-7727-08de74714aba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013|34070700014; 
X-Microsoft-Antispam-Message-Info: zinlXXXoicbHzxdI9Q5U2jEEznSFjZ+92TxVFN+ObdmBqcTEaFVrdVc+O5tww8OiZzKo6cWirZoz0qqYESzaOt39fezqNCrIztf/ZDpxw/3mCcvRTUpinjheAKtHRZwS7usl/dpDItP/AazcYI5eHpiuNm0LWhZ/n+qIMvzJ4bM8HnwtHFL4SQQ0rCjN3VcwwvJpOqaQXvv1IhIVQ5Ny+bbMy/gzyDdKqc5qvd2jho9R1nuv0OM4H4uN0wn2auLNOL3MmNjopZhiKl916N2smlWs0yZfGVF/EcIXKQizjxh7Z4mlLyNnj84dgtKH1J/W03Pk1SE0AgGsQYTTMcWZM4ESkxojIiunF7E37z1OYRbAkGGro0d4wV3t8Qrouc3EehJjH8EfSEp7fIfB1rCMort6Dqn8uYJ+m9UzdS/lwekqBCAvJoyOfvK6NCuSSwBOUAXCgvoYCNNRAsh7J222pmATf2SlkM/YfyJpaDHrhPQn6TwcjKHfZ36L//DXFYpiXu4kQo9NNrFLC9TarOXIhEB+PBXv8sN7EFJOMAo4bbO2pQMEiz4cretOvO0Z6kv/sRO/vj1FlJfkwlIGCuQmoaXcmu6qDXrKjYcNUbQdk+Lf7U88dRC/IYo9ErUcjt61tn5BAUul//09t/ulCbBjVG3M9xr2uE7au+Om5c/gcCJo4v9mZmiaFQDLwT5jZItrqZghIMKtJSx8iW9K/a+fni00nicsWdRO/pLHlkUVU3YKZstr9B4xoOpmSKuYZ0zPS7UDnGUPlzxxQ67RfwudGVCiv3xp9YH1mhfZgfaFDjl9UjG1Snb/y1LMNTOaqdNGxsulaeeEK0AO/ThgsmK/jw==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(34070700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TPfFWbVI4a2rcqnnk627EU+TMFVxlLrZL8jvU+QVUfPw/XqV5N94IiRBMUID7eRVLZCzTyL2gvWCbEvwXUjDU4vkrF/hYH2FowzV7MUJZjCGgPVfOeV0+22IY+6ALLQhrtEpFmqyylSf+/dUsnSknhxYHCm6FqgpGf3rvyoQxEXb1iqhDc4LNpmHSrhbbs1qS0dbENBlR756D0Y7cPJ8GRsSeJoSgHRB1qTb1mhHmSCF2hhNj0Z1KDUKXqYS7YZeAi6UNbwOsKF79ikGpEpEiO0bBR24c6bZYIjcI/1GhQqG3bcKCxX9uvMjMFhEr0CwGdcCBrFTroqibNz3/pAgNMwvoCVc1TrXQ/HTXir8OSCB+J9wD5f06L5NrSGHhmF0aOBiNRJ15OTI1R9+/j8CYAovO/fb7+Ti5gvNRy7ZY6Dlc959HoTutk/Ktdv86Gob
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 13:25:06.6225 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0817a6-3acd-4c42-7727-08de74714aba
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7909
X-Mailman-Approved-At: Wed, 25 Feb 2026 15:01:23 +0100
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
 board/phytec/phycore_am62x/rm-cfg.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/phytec/phycore_am62x/rm-cfg.yaml b/board/phytec/phycore_am62x/rm-cfg.yaml
index 26d99b03b80..f800fb28a69 100644
--- a/board/phytec/phycore_am62x/rm-cfg.yaml
+++ b/board/phytec/phycore_am62x/rm-cfg.yaml
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

