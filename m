Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C6CCCF9F8
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 08:59:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43C9183B5B;
	Thu,  6 Nov 2025 09:58:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bbV2J3Dl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 322A883B55; Thu,  6 Nov 2025 09:58:58 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36A8383B22
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 09:58:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-jain1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Asc1BSb1odECoCTe/n0x0m8j6Ayvx2H3IZJ7+tz7qqEuYVDMRvErOfyeoKZnD8hABHGi6RU5fLtaQgjKeIWPVR4B9ovA/2Fk7PhoKJ3U7dsHAALRbZ/hq/riejfPwqNYJvaMxTUArkDw50AJmaXbPLT7B8zyBjzW8SpG7ADKjVZ7sCGH/dgfKP7UA04sCmPE/Gy7tX5i8Z4qHRtNNdIgyJiXyF3zRQNL8FPIYh/lU8O7kfhE4QB16ZjEKpEiGom/dJJK7fvMFOnfKUGNkEAo2wt2XzuivQ71P7jDyhPQkYPBFnnIHMVO2T+/6/Y6h+RzcV5o/VbhGRdiCI9xl4mi1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c4pQS2q6NjonYtIJJoDKLPewcysm4TYkC615Q3ByrQI=;
 b=ZDRVXZJfvfj+PKMyVI26SuMUOqr9A26eca2Nvg6Y2opdZGp106qJRapPv00bTee+L5WBWR7AuhQaQGt76JIP5J0jcs0u6ElTQXO/bRr/Rk9yNIWX+22cfnZsnQrj8vzkUsS3iVqDiFrHOSgYcRcX5prV2G+jbTPm5JxEuvHaqWCMF+heOkP6pRffZuXJVXsAZ5k3sJbxC17jQqBKbGfnZbONx6MSzINSF6Jd7btMZagwidlOBAbp/hofAy0IXLj2tyUCQrUogvgKu5l0CUCBb/z/Zha9/nfcZmSD/xUgpmZK/E7qDkdWzk+f+HgEbqIwkr13TQwUrQRy8i8R2xcMgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4pQS2q6NjonYtIJJoDKLPewcysm4TYkC615Q3ByrQI=;
 b=bbV2J3Dlt//sGIoA/4Rz1984saEXPsF9ko3zSUnWyotffqioGeMgLKuoOcGJwVRI1dsCYBSEfkO4PLFB2ppzn0l8eOXJEM1rRmqKoZL5EJxL5LpxFIg28R7JIcS5zJkA0v8bARqR/PDQLriWoJJRVLhQk21/mMcxQXv/HOuabq8=
Received: from BYAPR03CA0030.namprd03.prod.outlook.com (2603:10b6:a02:a8::43)
 by SA1PR10MB997739.namprd10.prod.outlook.com (2603:10b6:806:4bd::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Thu, 6 Nov
 2025 08:58:52 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::bc) by BYAPR03CA0030.outlook.office365.com
 (2603:10b6:a02:a8::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.9 via Frontend Transport; Thu, 6
 Nov 2025 08:58:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 08:58:51 +0000
Received: from DFLE209.ent.ti.com (10.64.6.67) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 02:58:47 -0600
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 02:58:46 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 6 Nov 2025 02:58:46 -0600
Received: from a0512632.dhcp.ti.com (a0512632.dhcp.ti.com [172.24.233.20])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A68whm6994350;
 Thu, 6 Nov 2025 02:58:43 -0600
From: Swamil Jain <s-jain1@ti.com>
To: <devarsht@ti.com>, <aradhya.bhatia@linux.dev>, <n-jain1@ti.com>,
 <tomi.valkeinen@ideasonboard.com>, <trini@konsulko.com>
CC: <vigneshr@ti.com>, <praneeth@ti.com>, <h-shenoy@ti.com>,
 <u-kumar1@ti.com>, <n-francis@ti.com>, <u-boot@lists.denx.de>,
 <s-jain1@ti.com>
Subject: [PATCH v4 0/2] Refactor tidss_drv and enable early splash on AM625
Date: Thu, 6 Nov 2025 14:28:40 +0530
Message-ID: <20251106085842.629521-1-s-jain1@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|SA1PR10MB997739:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a78e56c-e72a-462b-f66c-08de1d12b4eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|34020700016|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BP74EnFAiDsT2L8PjftghnXmfxOvk5ozP9NEfvynZ/UJ8+74cjtCMn0bDfEg?=
 =?us-ascii?Q?7j+fNLMZFrZJC2pPzWL/Rm0yvOLxQXTlDBdoWnNtbOCtuxNupj2gc58LH+Zl?=
 =?us-ascii?Q?a//AWn+tS1u+UcdEYcNmGj1WbLv1nyFYFDkoFSiXeaPKtFgoiSjg7RcInvlQ?=
 =?us-ascii?Q?AlxBKu/3fXOMHnovjuVfNxkRYd4ZoV4X4jTG0G7nvrNlk14BxCkwjW2teo0x?=
 =?us-ascii?Q?C2JzLBIuGx9+jID4/jtVppNxMfbcdFPSORiCN4kxj+Td5cR1ycJaw6Pbbzi8?=
 =?us-ascii?Q?b/7g4NX3wwfLoCdpZWCl/jJbwVT2ec/cetkL2H9bokvURhFlaQ8961QQ/Apz?=
 =?us-ascii?Q?yYl9Rm6lONOW+T9gPSdD0Z5UxxBMlbDw3YqY6oNaIhn3AM3nBsijNusAsF28?=
 =?us-ascii?Q?y3q8PORsYFTqRMHSYCkYjQU5U8vOK1RuB+8p8pDY36UlEvyXS/H0qWR/Cszm?=
 =?us-ascii?Q?rmH1O01s+sJFi68s3REa9mk7OMqc3D+YbHVx95KX2Mq8ZOMu5NvdUG6gXZKQ?=
 =?us-ascii?Q?XbIP1EOsgVt1m3amuYJONymZhvDhTYVZu82CA0CJ3xCk/lwzEOqvx+d9XuB8?=
 =?us-ascii?Q?XHQqhQyB39qmJg0S+b0+j474UhUaa6pySdlUZqGvCchYojlxXDrzYSZXR7TV?=
 =?us-ascii?Q?KlQlS8NZBLvyaGesFpkWLQYmUKz68LQ6+hdVZ6/CWMpQjNBNxYjfBVFN1yIV?=
 =?us-ascii?Q?VupAMRc4cyRtqsr/v/wfWJyaVrbfqBNqJrhmnB+R4LE6FaRA8+lZKrZYVuoS?=
 =?us-ascii?Q?gyQLBxZ7Cwo5mYNmqSf2tt/ulMB48itQsJOxqYHXSYlUShOoJE/ZMKqaK0eb?=
 =?us-ascii?Q?yaoxd/5XzaTI8YjJs0QAkH39DaECTA7CgO1SuChz9VllbJJTKjajguwXFosH?=
 =?us-ascii?Q?dE/Brd1EgjDXo8KBSFc45FpJRfYp9ScuDG1EwiuYOFNy0giRXUkcSmUqs6Fo?=
 =?us-ascii?Q?uMU8S5YoW2ye9HvkfRidsEk84GYWZSAg2MOY3FPZbfx8EvDfRwS1sXD3IryU?=
 =?us-ascii?Q?B6QIRLV8bAUPukR4w3nNUdJLPrEMyo+JGoEKhJwAQIgiiW8UKbrC5QaFtjCM?=
 =?us-ascii?Q?6Dzw7OkvSrWLDa+ZLBwhSBYyY11GAc/tt2Y5XiSNRHgCkkn/5Rh1YfWEz1rJ?=
 =?us-ascii?Q?wm+V+9DDO0/q8EzYddIXI2/IUgg+0dn/ZUG0LiW0CLEkgo2SvLRGR3DWvyOo?=
 =?us-ascii?Q?iciOb6VH2yJsD3Ty5+hTYMQC/15xBV1q9WyOnueOz0O5H0Ir/zyn2/fFTX/L?=
 =?us-ascii?Q?3hRWL5GGg9a7/+yXb1uILsem6KUVsvrD2KQY96oI/aoA+aWY5MRye5+pFkkB?=
 =?us-ascii?Q?yYDs4pKybZM0/JdH5vrWoP1S3VehsHUHsG2J+qZVDMyj9bd4UoJSIbYqv192?=
 =?us-ascii?Q?OHtqS139z77XO0i7l/da80GJVjax4KOv92YgrkS3dyhlOhpclfpiNGyWGhCu?=
 =?us-ascii?Q?GVwZpFB1vDPmW1WsmaZsIX61s9l5l8PxS0Si7/kmWdzcduf8/w0BdJLLTxtC?=
 =?us-ascii?Q?z9CirFujb44nNg3CzNv1xMavfk8uFvQ3YNnJr2YYI3nNsyUsfkJ9/v8Pvbwb?=
 =?us-ascii?Q?3iAl+Y91VtJlP+Qc4MQ=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(34020700016)(36860700013)(376014)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 08:58:51.4294 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a78e56c-e72a-462b-f66c-08de1d12b4eb
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997739
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

This series:
- Refactors tidss_drv                                                    
- Adds am62x_a53_splashscreen.config to enable splashscreen at u-boot    
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
Changelog v3->v4:
PATCH 1/2 : Don't include "asm/utils.h" in tidss_drv.c
PATCH 2/2 : - Move CONFIG_FS_LOADER from am62x_a53_defconfig to
              splashscreen.config fragment
            - Minor change in commit message
Link to v3:
https://lore.kernel.org/all/20251105163040.4086273-1-s-jain1@ti.com/
                                                                     
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

 configs/am62x_a53_splashscreen.config |  17 ++
 configs/am62x_evm_a53_defconfig       |   3 +-
 drivers/video/tidss/Makefile          |   2 +-
 drivers/video/tidss/tidss_drv.c       | 236 +++++++++++------
 drivers/video/tidss/tidss_drv.h       |  40 ++-
 drivers/video/tidss/tidss_oldi.c      | 364 ++++++++++++++++++++++++++
 drivers/video/tidss/tidss_oldi.h      |  72 +++++
 drivers/video/tidss/tidss_regs.h      |  21 --
 8 files changed, 631 insertions(+), 124 deletions(-)
 create mode 100644 configs/am62x_a53_splashscreen.config
 create mode 100644 drivers/video/tidss/tidss_oldi.c
 create mode 100644 drivers/video/tidss/tidss_oldi.h

