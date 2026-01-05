Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BBCEC79FAF
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 18:59:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC6E483A26;
	Mon,  5 Jan 2026 19:59:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="B5XuzM7W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEDAC83D17; Mon,  5 Jan 2026 19:59:27 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1309839DE
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 19:59:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OFFYnm960eXL+MZSzXespXohdVUYaD3Y3AxpQS53PNlQl44vQRzFA22MMRzHWtdnv2CqR+rVeWAUacYgC8TqjN4jcpK96C2RwgJBtFySpj8P6pFtaPSFAOr9w/Kx3pAKlO7fwNiaHqvCubfjbcbLuit1jUz2BnEuofz608maYZcfoa5q+tYo24O+Mx/W3CSb4bMXyDPVsURDEgAn6bvdvnoR4GTVNTC/JyolEOjw/bCiZWbK95//ePlZAGZwFF7yIYPMNGqQIP47Oh8qNL2vzG3/jhHVewv0wfKKiURtjfJOEJdQ5828mqmwRY6DJOqI0LGYG0BwmwlPvAubBMuKPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gxgzmw0nHxRDT8tFlX10hbh8d0PPBPpCpKCyz7jb7uw=;
 b=Vz2tcycatbyMi4t4OjNQ+QesiR9QgVTjiEmX3TPrOI2zMBt5IiEOhFZwlONsDSSCpOps2THKTwxLqdvhAM5L9dhbJgZs9YU0VBLAgVROzOFmyBx2Q8xyE0XNFoAGvkOVkr0Rl0nDrqqlgPzUikClTGp3PCCX7m5ui0R4XkV8N2ALgLH3Ag8scv3pYOSA9kO6U0GArk2DnHu5Lv+w3CamN3FtnbPQH4c307OANl8TkreyNSyQMQIEzYCuSdjAVUvgDTN7Xu4bW0sDD4IBJoM595i5s2rb04XGsCY4IJq+Hy/LJCmPwyUYL2BCDics639BAxupBJ1EAac/4WuNFmqVVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gxgzmw0nHxRDT8tFlX10hbh8d0PPBPpCpKCyz7jb7uw=;
 b=B5XuzM7W0ShWO0Vp5PCRb14/uPGoVYWBACSs0krnESW5RwEO43y90Cx9Tfo9asshdvxq2plQi6wDuUiM0AiuOAiOPiO6pbXv5dH29mZ7zqluY/uXodXAuIbSkmCejcA7iwKpzOOWe+I2iw178cglaW49iJrdZB6Oa4mFH2//Ryw=
Received: from MN2PR06CA0005.namprd06.prod.outlook.com (2603:10b6:208:23d::10)
 by BN0PR10MB5191.namprd10.prod.outlook.com (2603:10b6:408:116::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 18:59:16 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:23d:cafe::16) by MN2PR06CA0005.outlook.office365.com
 (2603:10b6:208:23d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Mon, 5
 Jan 2026 18:58:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Mon, 5 Jan 2026 18:59:14 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 5 Jan
 2026 12:59:09 -0600
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 5 Jan
 2026 12:59:09 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 5 Jan 2026 12:59:09 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 605Ix9TM1754027;
 Mon, 5 Jan 2026 12:59:09 -0600
Date: Mon, 5 Jan 2026 12:59:09 -0600
From: Nishanth Menon <nm@ti.com>
To: Paresh Bhagat <p-bhagat@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>, <praneeth@ti.com>,
 <vigneshr@ti.com>, <bb@ti.com>, <khasim@ti.com>, <afd@ti.com>
Subject: Re: [PATCH] doc: board: ti: Add AM62D documentation
Message-ID: <20260105185909.t7xv4xjl3xzw4d6m@granddad>
References: <20260105183545.4108567-1-p-bhagat@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260105183545.4108567-1-p-bhagat@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|BN0PR10MB5191:EE_
X-MS-Office365-Filtering-Correlation-Id: 703b3b87-8410-406a-4d74-08de4c8c8551
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zpT/SZip1d+NS7T/byjh2YcnNNzwHbUaojlP1hwFqRBS4BKCh2Rqe8ELBx5G?=
 =?us-ascii?Q?/gEQkH9hE1G/42Hu7t1yAecaQSMepoB+PUpjU1a4KpIKHlhDn+2sjVHbiqNi?=
 =?us-ascii?Q?0GCz776k0Nu/jnVr400EdtNEN0VjVYbkrokpRkbFbp1+LmgonEGHNJjXq0J/?=
 =?us-ascii?Q?//WSU2vRDaY426aryb4esqJVdmD4gLYjhoVLC++VtSblVY2KyUmhrCHHMNoN?=
 =?us-ascii?Q?qfiIsoznTTHWpl1MHQLDmjm6BbCK1eUjWnrXR02Wtht/6maMuhIJFGrsIw52?=
 =?us-ascii?Q?81UJ2DASm7B4HqF+Of6SO2dIQcFQ3gSuzGSqD0QONTU04m7D+nmbIN5+ChZA?=
 =?us-ascii?Q?2q/cyOHmUYUhRJOOP9kKshRRJodutDLsMEVAIXaJb0udBz6RQb6JWyaSwuFf?=
 =?us-ascii?Q?YY98uYJ6Lwt6YWkKOQjxxfWvFRSlbE0E14znGpcC9WnLtcEYGyRcL3kpFqbW?=
 =?us-ascii?Q?90VdJp7OZ1pwpsiplh4Of3EJ6VZdSZYiqlnbYigRIDkgMLYEkx0vwBNYO0RF?=
 =?us-ascii?Q?S7/dZvplyW5h4B/+pCZ448jY/omVw/6n9jgLBjuV15HXfmcZ7/B57QY+aY6u?=
 =?us-ascii?Q?vxmG6Lu9HLHPR0LH1cI0liH3IwLIkVg2bziR8/LjHhPkmt5cBLiOyXkQQrcO?=
 =?us-ascii?Q?c+rkK8LRZ/QOO3nQS6LochM6Y+KbNbvVgBBLr8k1Xe9oWlkObghNhVJjSs2G?=
 =?us-ascii?Q?r8rCdfFG4zD21xAeCCGmk9//PoHVZIA88WQPlJNwfGtrUKje58UAyRrmejzR?=
 =?us-ascii?Q?Z5WtIEI2rCl5qEBLu9Ya+lDp3/ruaRcGBAgJg5DMZdVJ1gnoXW4Lra5msLcO?=
 =?us-ascii?Q?dWoOC0LO08d3R1w+OOWMxko6IY9vOWm2whWndmcDh/1eIRX8J9z7/muZcinL?=
 =?us-ascii?Q?o/g81LI1gxW9Zrh6iY43yzVdcobVyELvH0sgwapMOskKHx4pqhQTbPcHQR46?=
 =?us-ascii?Q?yCi04VsczsnGOAptYHiG20idVfvgP/absWo3zFtqHW9lbYpvE8/irsj9gROb?=
 =?us-ascii?Q?cycNjKuEraLO1qZDo8jXzL/tdqXW6JLtxo4r2mXpX2Ss/2OO0gt6Q/Kd5YFA?=
 =?us-ascii?Q?W68TT2vdA3IEfU3GYh3+BkA7qOiTsi3DDk2qk6mkiJ8qtPBjWMhW7O2lclw3?=
 =?us-ascii?Q?pa4Zafwes09Uw2nFnXk9L4UWfyq9Uecce8c7uQsaYhZC81wM6C5o53Gijz6P?=
 =?us-ascii?Q?IRIHRKKdPvR9covksqutcK5GHcRShJEWTrYxlXBvbVvdS0KHF56kA6kgJRy/?=
 =?us-ascii?Q?2sT4zAbFNg62iV26IGOMF0V4E1/qELJO7MwumU0fbIviyLHFyJhgoqny9QML?=
 =?us-ascii?Q?/FfIdrd9c6CBo3WHYrk0PSFHJY6N9XAKxsvyjlXM1DgkHvQFfz41qd2/6QXj?=
 =?us-ascii?Q?EnhIj65oextrXkDhSmTD7sY54A6CoKASYGU+EeVyncP5AkRuGVs/KQa6pjST?=
 =?us-ascii?Q?dtEZ06fmo3BpBTZCP0QYIBT1WFtD14v1L2cz6j+5+yTNwqoFP/Clh1Gmb3yW?=
 =?us-ascii?Q?LjDLknL5py04Zyo3hl3z/Iq9E8955QQ4ngxoPF1XmIbsbgpWbPSpgR29Eex7?=
 =?us-ascii?Q?qntxk/6yZJ1gurIU3QA=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 18:59:14.7850 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 703b3b87-8410-406a-4d74-08de4c8c8551
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5191
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

On 00:05-20260106, Paresh Bhagat wrote:
> Add info of boot flow and build steps for AM62Dx EVM.

[...]
> +  **OpenOCD support since**: August 2023 (git master)
> +
> +  Until the next stable release of OpenOCD is available in your development
> +  environment's distribution, it might be necessary to build OpenOCD `from the
> +  source <https://github.com/openocd-org/openocd>`_.
> +
> +.. include::  k3.rst
> +    :start-after: .. k3_rst_include_start_openocd_connect_XDS110
> +    :end-before: .. k3_rst_include_end_openocd_connect_XDS110
> +
> +To start OpenOCD and connect to the board
> +
> +.. prompt:: bash
> +
> +  openocd -f board/ti_am62a7evm.cfg

* Are you sure this is the location[1] ?
* is am62a7 correct for am62d ?

[1] https://github.com/openocd-org/openocd/tree/master/tcl/board/ti
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource
