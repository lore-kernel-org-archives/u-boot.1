Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18497CCFA0D
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 16:31:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8329483A9F;
	Wed,  5 Nov 2025 17:31:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lLwMpsH1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E34983AA1; Wed,  5 Nov 2025 17:30:59 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95E9A83936
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 17:30:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-jain1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o9LxNGqakc8qfkjSb0npnDrw5cmouUHrEPr1zhU202m04dU89hdz5narxwNHSHqHAkf9Wk0DClmZ3jcbXVIAfsV07HDckPA1K9TJk1EsLICkA0Q3eSUeLtHXaotPbKJ4BcO7RAM2gIsRvsKquUmw96CPHvAr5HCM0TVQbQspnEE6HMkV8XYkJ0r/9WLoOIf254PdF8TmCgJp+quvDu7zM2bxc9VpV4WPA79r0aORNukg5Xrjms5eCd9yDYEuJwYmwZ/D/IYjcBKsGLtpE8LnzJZJJb9dfvVETZkXJX/VHJFM4X1HmVStKfpWdOhZnVkNuiUUeRiHI78Xfl/BNLWngw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okf5U3fNvTjOWgBYG6m9UHbZUPkSZU2x/g99g4xdH7A=;
 b=NEarjc6VSn4p3aSvtRlSEJLVAVWJFiaU/zbKILEzaf6xa3+FUz6NhyMQkcrRhnaui6St/UwTxO/hNvAyado71p0es114M2R5vcT6sRtj8yLpEWWbOXiB88MMXip23Zl8xD9hYon5Fr/dB5iAf7pg1JFsgygf2Jq7EI6XVOleNiha9NxDzNWySVNpXEaIfvASk/McBqCiEWRO1ncswQjQXr7vzuqNn54LZMByFui3Ses0S5lQswFa7/pMlh6cakj/0qJqZOkNgC5K4UyLW7AtVLqAetSkZsvPZNYCcNz57RLaQWuciL4ya6YShIRVMtSAsk23ckMrLI8ly++/ZXugvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okf5U3fNvTjOWgBYG6m9UHbZUPkSZU2x/g99g4xdH7A=;
 b=lLwMpsH1zVyKOnZbrxLJb/XP8lTQqenISyQfyUH3NbnGn6HqGoT5NXzf/VwRf7DN9KuqmCo/rFDueHo5Yt7Lx0HWYvT+BIStDAHo4wbLMjbdv2797BTNdWtKsShTgX9GUhBqkv/of10c1cvW6QY8CauPX7BPl7j26vdvQyWf1CY=
Received: from BN9PR03CA0500.namprd03.prod.outlook.com (2603:10b6:408:130::25)
 by SJ1PR10MB5906.namprd10.prod.outlook.com (2603:10b6:a03:48b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Wed, 5 Nov
 2025 16:30:53 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:130:cafe::85) by BN9PR03CA0500.outlook.office365.com
 (2603:10b6:408:130::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Wed, 5
 Nov 2025 16:30:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 16:30:51 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 10:30:46 -0600
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 10:30:45 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 5 Nov 2025 10:30:45 -0600
Received: from a0512632.dhcp.ti.com (a0512632.dhcp.ti.com [172.24.233.20])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A5GUfsL4005513;
 Wed, 5 Nov 2025 10:30:42 -0600
From: Swamil Jain <s-jain1@ti.com>
To: <devarsht@ti.com>, <aradhya.bhatia@linux.dev>, <n-jain1@ti.com>,
 <tomi.valkeinen@ideasonboard.com>, <trini@konsulko.com>, <jd@denx.de>,
 <tl@denx.de>, <agust@denx.de>
CC: <vigneshr@ti.com>, <praneeth@ti.com>, <h-shenoy@ti.com>,
 <u-kumar1@ti.com>, <n-francis@ti.com>, <u-boot@lists.denx.de>,
 <s-jain1@ti.com>
Subject: [RESEND PATCH v3 0/2] Refactor tidss_drv and enable early splash on
 AM625
Date: Wed, 5 Nov 2025 22:00:38 +0530
Message-ID: <20251105163040.4086273-1-s-jain1@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|SJ1PR10MB5906:EE_
X-MS-Office365-Filtering-Correlation-Id: e25742a0-0fe0-4be5-0816-08de1c88af64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|34020700016|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rfmGmiJxRn5usPcGkbwpcdpRJaWyggpXLzW/EQKITG0yLzDBdaoXPzymRwyS?=
 =?us-ascii?Q?WVYeQPAK01hsAvsicTeWVtBZw1uaSUHoe9pdc8XdJKxa+sWiHZdu0ztI1MJq?=
 =?us-ascii?Q?hRl3X9/5QZsqkcVbF8Oln99kMfCgWbf9jQBueDss2bsg2ihesuKX7JcPfHek?=
 =?us-ascii?Q?LmtJ9fHpNkEWC4BbVI58Occ+QWlfQC8p0CJJ7qQ40l5God9Bhzesf7SQ4H+2?=
 =?us-ascii?Q?4SYEVQdISyR9wOTTfai4ywvAPF2u663rMgRfoNQwbHDFklPkO8hOvqBlpQft?=
 =?us-ascii?Q?JrxF20iWETfU+wG0ddld3gUXRKYRl39DE50pqG4lT6ewNfkazoQnDfqLgtis?=
 =?us-ascii?Q?LwRJEYP0NKh8l4j2koDCiWPzMVwfe8lrRxdMFUq+AfQ6ll5LPJaY1JZueaX9?=
 =?us-ascii?Q?z6PctHKodqpL10f2FMmTEGfdKsGvOQyhsFF3uRzFF0ykC45CIN35y6m/L2SF?=
 =?us-ascii?Q?/WZx4t8inPurDh7ZZGR3YVc4PCUhy0gXxpkJdxRsffNU+dFAIe3MWKnkd95/?=
 =?us-ascii?Q?gK16yXbPplnW9VqKoBUm84A3PAzCpz61PFw+/w2Frrtz5mDcCz/k4b/gnelO?=
 =?us-ascii?Q?81YNcM572/SuZDCZN/wuYhMPkwxiymVHhjpHsoFpdeF0j1dWGbz1aEDyXINP?=
 =?us-ascii?Q?9gGxhkD+8K6nZ2kUMq7ryYpRUE8ZVPED0wjiVP+PauMxvrfFeWaRPHVBbDFU?=
 =?us-ascii?Q?FKYw4oVuZ3GYLjHc343KX6oluFdlSO6fGOkm4fVcBnuuzwDtI+vw+JrIgOxd?=
 =?us-ascii?Q?mFwlyglPoP0nDR+peWbRQhU92jAPEy8Zw7S4P+ord0zvMN1UTQ9DL+9ENlzc?=
 =?us-ascii?Q?HDbXQHZtTRcMFg+P/SU2grk/cSHOtasUOJIsfVQKgNnTka9p7B1xO45hvBmH?=
 =?us-ascii?Q?tfrLPD902lf0KP4nI1R/M7wOKPgdxwUPSqZ1nDxT0OOYsSu92EAAN8AXenMs?=
 =?us-ascii?Q?AlG86OI0YBA0vqA4GAAEp/pF30mljNEmmkpRZMEQ2WBBS2Kn/HM8v3Hin8xb?=
 =?us-ascii?Q?bxklWqgbdUy7BUqLXQK5m5uQ6rkrXkLqmRVJFug20Xio9nZKRieIdeVRncLx?=
 =?us-ascii?Q?EHgeNGFiRECO/u7RjQsMnoBkLC80socFNkmR2n0Hm9vPQHca7Blg3qnqsaRx?=
 =?us-ascii?Q?XsGeAL+FeBT9lSPfDqdiaTly14SaRB6QpE9BlY1IBwrsyt7WsjIP+59kGCSn?=
 =?us-ascii?Q?3I81DwTGvmVXKLPV1NzTnZHZIGUFG7w9ROWS7o5bKx0mBhAJZ2J5XANJSc5a?=
 =?us-ascii?Q?Ps1kk90CQ7NQS+vFDkhY53Px/W1h23IDf7lgUL1eP5GVE/IX3aXPd5S57SDL?=
 =?us-ascii?Q?DdPehNYyyCoF8Zqic9SXWcc+VLUe6kI/ysayFsRcDet5E54yNFz3vsZIZ4EE?=
 =?us-ascii?Q?vncQiqNZ1slUAmamrSALwIoKdLU2nevxcViAsUnXUCSkjKMl8xgdsyYz1VY2?=
 =?us-ascii?Q?ejf7ETJ7lU2o8ECQZCqoZc9YA3/yoU9nbdwV5QZ7iHNnSIWCVqDiL7SJytHi?=
 =?us-ascii?Q?DQDJ1dEfwb+QkXw6YzOVdFvOPTTZ//uFiyubWMk6dE1um7Rd5nI/9x3p5EYO?=
 =?us-ascii?Q?uNE/AwYgiNByzifZGzU=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(34020700016)(36860700013)(1800799024)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 16:30:51.5751 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e25742a0-0fe0-4be5-0816-08de1c88af64
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5906
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

- Refactor tidss_drv                                                    
- Add am62x_a53_splashscreen.config to enable splashscreen at u-boot    
  SPL

Signed-off-by: Swamil Jain <s-jain1@ti.com>
---
Note:
- As OLDI specific changes are in progress to be synced to upstream DT,
use this[1] branch to enable SD-MMC splash on AM62X. Upstream DT changes
can be found here[2][3].
- Use TI logo file(ti_logo_414x97_32bpp.bmp.gz) from this link[4].

[1]: https://github.com/swamiljain/u-boot/tree/v3_splash_final
[2]: https://lore.kernel.org/all/20250913064205.4152249-1-s-jain1@ti.com/
[3]: https://lore.kernel.org/all/20251017115325.1942591-2-s-jain1@ti.com/
[4]: https://github.com/swamiljain/ti-splash-logo/blob/main/ti_logo_414x97_32bpp.bmp.gz                                                         
---                                                                     
Changelog v2->v3:                                                       
- Add splashscreen.config fragment to enable splashscreen               
- Align OLDI mode detection logic with kernel side upstreamed OLDI      
  series[1]                                                             
- Address styling issue mentioned by Devarsh                            
- Pick up R-by tag for PATCH 1/2                                        
                                                                        
Link to v2:                                                             
https://lore.kernel.org/all/20250725043012.1186886-1-s-jain1@ti.com/    
                                                                        
Changelog v1->v2                                                        
- Iterate through all available OLDIs                                   
- Move dss_oldi_tx_power from tidss_drv.c to tidss_oldi.c               
- Rename tidss_attach_active_panel to a more generic name               
- To handle all active hw video ports, add an array for active hw vps   
- Iterate through all active hw vps to enable respective clks           
                                                                        
Link to v1: https://lore.kernel.org/u-boot/20250603105735.4038240-1-s-jain1@ti.com/
---
Devarsh Thakkar (1):
  configs: am62x_evm_a53_defconfig: Enable A53 splashscreen at u-boot
    SPL

Swamil Jain (1):
  drivers: video: tidss: Refactor tidss_drv

 configs/am62x_a53_splashscreen.config |  16 ++
 configs/am62x_evm_a53_defconfig       |   4 +-
 drivers/video/tidss/Makefile          |   2 +-
 drivers/video/tidss/tidss_drv.c       | 235 +++++++++++------
 drivers/video/tidss/tidss_drv.h       |  40 ++-
 drivers/video/tidss/tidss_oldi.c      | 364 ++++++++++++++++++++++++++
 drivers/video/tidss/tidss_oldi.h      |  72 +++++
 drivers/video/tidss/tidss_regs.h      |  21 --
 8 files changed, 631 insertions(+), 123 deletions(-)
 create mode 100644 configs/am62x_a53_splashscreen.config
 create mode 100644 drivers/video/tidss/tidss_oldi.c
 create mode 100644 drivers/video/tidss/tidss_oldi.h

