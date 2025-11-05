Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A08E9CCFA1A
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 16:14:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCD3783A9F;
	Wed,  5 Nov 2025 17:14:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="AaBtgnTj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFB5383AA4; Wed,  5 Nov 2025 17:14:54 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FE5683A9A
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 17:14:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-jain1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I0kLMGSz6shBY0UNNDZcaOODo9cGWSa3asSQ+WePbRztAXsht2XN3FSxHEY9N97YJ4MdKjA1XNuop05lXimXb3zLqpuYPWCxKvFeNPnd2FXFDAxtOyE/GUA07EmS3RCt3UWFR8nYoSYJc20wS5KSwlslj0PQUK1aY89m2qcxfiJqBqgsFLOXqF6Qduzx3sGNpkxzxTQc6Wg/qep2eZyFscKyJJozALlg9tNFjprNi+d0bgrUMr3zcdpMXWZ6qhJUQ5maCm9fwKQF4BsS5lRdYpu1iPh/ZiqrcN3LQ8rPNUVOtig/Cki+yqSszXHCfmERT+PnPqho0z82GUmbP7RBAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pERnVwQEOBgth4pee+9Mgmkd4XTT6Vtrg9Ez7FR0ABo=;
 b=rHD1dJemjJzab5uns3FV9cvtcey3VlWERwTZOB4BhcWR+/isMsG7pyNrjZS5XZV9gJI/4OLJn+NhdvIKaj9MG5/EA6x06W1Vn9nLuFgv6memgKdeynv39mW/cY6IjPtoIHPT7sgvZt8Uf3uLCMYELyfSn3bYHDQNCOZSQIBoYQ1zSBMKaKjjsJ+mzu+wDVzgAdiVn5hTxTO/oLOtBl/xcTcCPVcMDrbeRZ7yCASEYVCzUi3Mxe/xkiaulQUObqN0sFfWMNJVdXp2X5QHHOk424s0W+P2NRcfWNp8YINmgSdH67V1IIapBt62ZXwCpuvjsu4jrbDLjmCExTpLu4Semw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pERnVwQEOBgth4pee+9Mgmkd4XTT6Vtrg9Ez7FR0ABo=;
 b=AaBtgnTjL0IMhsIJaiJKpPBVam5CXu2w+0mg9FWN1RLUaaQq/+Z5M8SbQ7Rufxyac/sJIx2/DlTKG+xrsrT08kTU1zcoW5EbQCQ4WEHldnLdMjooPA98/COfUmSWNBuSpOh9krD61KPkgDJ5WlMgOMt3n2N6OA+L4WtxF0H+3bs=
Received: from MW3PR05CA0007.namprd05.prod.outlook.com (2603:10b6:303:2b::12)
 by SA1PR10MB6543.namprd10.prod.outlook.com (2603:10b6:806:2bc::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Wed, 5 Nov
 2025 16:14:47 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:303:2b:cafe::cd) by MW3PR05CA0007.outlook.office365.com
 (2603:10b6:303:2b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.6 via Frontend Transport; Wed, 5
 Nov 2025 16:14:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=fail
 action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 16:14:47 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 10:14:42 -0600
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 10:14:41 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 5 Nov 2025 10:14:41 -0600
Received: from a0512632.dhcp.ti.com (a0512632.dhcp.ti.com [172.24.233.20])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A5GEbEx3983374;
 Wed, 5 Nov 2025 10:14:38 -0600
From: swamiljain <swamil.jain2016@gmail.com>
To: <devarsht@ti.com>, <aradhya.bhatia@linux.dev>, <n-jain1@ti.com>,
 <tomi.valkeinen@ideasonboard.com>, <trini@konsulko.com>, <agust@denx.de>
CC: <vigneshr@ti.com>, <praneeth@ti.com>, <h-shenoy@ti.com>,
 <u-kumar1@ti.com>, <n-francis@ti.com>, <u-boot@lists.denx.de>,
 <s-jain1@ti.com>
Subject: [PATCH v3 0/2] Refactor tidss_drv and enable early splash on AM625
Date: Wed, 5 Nov 2025 21:44:35 +0530
Message-ID: <20251105161437.4064391-1-swamil.jain2016@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|SA1PR10MB6543:EE_
X-MS-Office365-Filtering-Correlation-Id: 183d314f-9fbb-4fb7-832a-08de1c867086
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|48200799018|376014|7093399015|82310400026|34020700016|61400799027|36860700013|43062017|35450700002;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Cz+pav4LV255q4PzruhdP748wNz6e7OlK9pMXofMBIT5iJ4CAR4QPhC263t8?=
 =?us-ascii?Q?rUV5jy7prR8gdRDjDQhaRfkrgz7Ykfxq/h5JhP3wZhH1SjbmWPMiXCDDz/J2?=
 =?us-ascii?Q?n/9UewD0aO6xQdV+br+e37E2/cFMG5KO7zcvo5DJXirKR2mNtPlB+8ZNYCoC?=
 =?us-ascii?Q?jDR12lf3GQAzjOT4dxwEZCcrtso81UcLy7rqWDcIYGgZFOkuQQSG93cKl+sT?=
 =?us-ascii?Q?lL4AvJmGQpJ5ruvMC6vrG+9s4+Nyk6S5HLQzzwyJwJIgyE4eHkfNq6Am7syZ?=
 =?us-ascii?Q?gpIr9sJOd+ZJhZ30CHrD1PHbyysTFOaQpCpvteRQ/j5cQHTs+PfI9tizNhCE?=
 =?us-ascii?Q?fA//aQIcS0MM2UXyxBnO/Awl6E5Ec8dnrOfy85bMXhplaab/03EA3HjSALd0?=
 =?us-ascii?Q?752lzka89xUs4e01tsB5pUcTcWp+91uB3MsmLdgZJyQThGqw5ZUYSSEgI3FA?=
 =?us-ascii?Q?//CcYBQA/mDSsPEJn88FaOhcqSxHfUcH7iayozg1GW03HWnqNCgl8ql6DkYu?=
 =?us-ascii?Q?mT94b3ywu1U+0d1PDuql/q65Jz7NCn+2QyXuNzypnJJA3A6MJp8xOwe6l1g+?=
 =?us-ascii?Q?Lcu1d+V0+L/GmkCjBjlfw3XtrcMw7+7MFPogVqIDK7JHzIm+S8uakLaO6ppD?=
 =?us-ascii?Q?KSkpKrCjACNIrONOkOkmAlID4Q/cGchw8O5dDWTmsEaKrYL53FxNnOq9r9P4?=
 =?us-ascii?Q?1Kd4/AvSN4yLn7IV7vVS/EVwHKFsRal6OMqdVurcn/ukYdPpJ9AIsaX2r9zD?=
 =?us-ascii?Q?q69G41qsGFuNhzC+G/feMgjPPpGWqarURlx+XtO8N+ZkOCvadxmvQlxHllDP?=
 =?us-ascii?Q?werCutYOYzuwiai2cerEac/J/9JlWgu0TRin/C3s+47Nwx5VgI8/IeN6ig0h?=
 =?us-ascii?Q?ExM/VyXntLj5lmNSgL/9UY3MmpW/idkYpuHVLwwF7G5r4pcyOzPOF5COhKtV?=
 =?us-ascii?Q?fsOw3sIgrZgBva5iJ2ql6XrZjRHP1tTQ7WpZ1hft5UFhFISdTPfkgMeAFILs?=
 =?us-ascii?Q?EzbzRk1TZeEhEI4wz/gorEHWaGHMF28SDwtet9f32Zum9Md35xPzBXzRoWlm?=
 =?us-ascii?Q?Dd8xy6Uf80L3Jh+D5QIlOnFub5PKwwR41KuzQCgEb1OASSHxjkJH+ocq1y02?=
 =?us-ascii?Q?yQ9YK13klITVeQuq/1QyKBLB9dQjVAjoe69s3Fle8cq8/fb0oOIZFi/pJGee?=
 =?us-ascii?Q?tSD53WjJ1bnp5q4sufFky5zzhMngVGg9TBOhM/TIFVlsfF5VdDrc2+E3I7Mq?=
 =?us-ascii?Q?NBNnNLRpzDl/ZT4EWbn7pXKTVYfpCDfJeg5hH3impDPuKLrQ5fke2zwHp2vQ?=
 =?us-ascii?Q?NLumd+5/CKvOPGDFsZFNkuXZ2837jqAyUQz2JFhsEL3U2ckqjKM0m57nLPxp?=
 =?us-ascii?Q?VdI98ezra6kK3/MwqlWa9+3/zj4GivoSlNxGOo8HRWqbneNH20IyxCWoVqnh?=
 =?us-ascii?Q?0lCSnxe0ToQSl/80YtV0Xvpjtjg89uDO/YfyUInfJJCgxuJZFWcygbS84VS8?=
 =?us-ascii?Q?Umn7M3P7Bc/jWn88aJIpqx4TUwCR24p/esEnDD9YIirZultwqQf/Fo6fmnAC?=
 =?us-ascii?Q?LQ9hSqtnv5b8ES3fsD1l+7gPpe4eXeahTV7nsAGOEOJgRYpwH6kKpuQD6FZF?=
 =?us-ascii?Q?9l5m5TCN/4A4pDST8naUOrk=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(48200799018)(376014)(7093399015)(82310400026)(34020700016)(61400799027)(36860700013)(43062017)(35450700002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 16:14:47.1368 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 183d314f-9fbb-4fb7-832a-08de1c867086
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6543
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

