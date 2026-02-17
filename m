Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA88EE83844
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 13:31:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34C038063E;
	Tue, 17 Feb 2026 14:31:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="a3jwlGlb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C503183C32; Tue, 17 Feb 2026 14:31:35 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4871180325
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 14:31:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZswJU8fqx2hlMltWOr33ifCmVpIPghvkLOfDiWLWQvf9xZMS3ADmCwBXan7AdxnGa0UokS1kSZ57JBO9J2KKK7z6oXCqNFnjl+vyGP1nhU/JSqEbdhf9SjRdBs7GGsi1IkHrkRwe16FdP51vMC78Vv0s+Azb6f19fSe0n4pGXsIyANt50oSPIaeaNf81W8tpMYeo4XdRtEk9JGnQdyeuuR+heoNso/mHFy/6MZS2biV+VhjN4opW/l/JjfZfJ7/uZJt+O3RI14MW/YC6BKntZEMuuccCfNgukFjFYSNXoPMiHpRA/yGNZFO+FPlWVPSX39Om0MLuVnbR7pdI/PCUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cevdvW/ONHv/UyFmOLJawBQnEMZ1jsKCoMP6juL2EpA=;
 b=rfl7r3QnHAO/zZtZHFjMwDKMRPboTeBbBPGlcfan4tXcQsH37nfAo9kEBy3eP1kjNGtM0FdnNx0ExHGq4l++wD56obeIqBtMXU90W/F2ILjirxdhPGqruW2pZE6a/xPTx/v5UB76LSN2Xqi5CLJo/AZsqSuMPX5zDMyvEBvnysqS0qPq+MyiI+Ye2hZL/WYZ9DBurl0aSuAsJ8SBSPPEbCtpnwxi0tQ65BE/2aFoq0bDhnw6c5T1MDikVM0r0mGFZuvOwnkYz+y4cljV80fADzWe3v69vg7EQJyRwZidjRiY5hcue9ZXOTtc5vveg4w1ZMDbS3DyVJJ1S5K+1HAI2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cevdvW/ONHv/UyFmOLJawBQnEMZ1jsKCoMP6juL2EpA=;
 b=a3jwlGlbL8IvJlp26h03hYhVHzBVNV4Uh8BKeN0pFm6d5gfMTYo/RWUMKjJxIGXyAhKcUsQZlCJuV3MWl00x+oZtNJ1xLGPldr7sLKuQNb5aJlFZEjdt8NROAMEI+qYG/M2vwaghxTaF5jJjwwwZQB+KotnkDwLHaQlSyEz1qV0=
Received: from MN0PR02CA0016.namprd02.prod.outlook.com (2603:10b6:208:530::14)
 by SA6PR10MB8134.namprd10.prod.outlook.com (2603:10b6:806:443::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 13:31:28 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:208:530:cafe::21) by MN0PR02CA0016.outlook.office365.com
 (2603:10b6:208:530::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Tue,
 17 Feb 2026 13:31:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Tue, 17 Feb 2026 13:31:26 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 07:31:21 -0600
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 07:31:20 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Feb 2026 07:31:20 -0600
Received: from [172.24.233.254] (santhoshkumark.dhcp.ti.com [172.24.233.254])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 61HDVHq53405792; Tue, 17 Feb 2026 07:31:18 -0600
Message-ID: <c487a05a-2fba-4620-9d0b-768cef20ff44@ti.com>
Date: Tue, 17 Feb 2026 19:01:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] OSPI NAND MTD load and boot support
To: Anurag Dutta <a-dutta@ti.com>, <jagan@amarulasolutions.com>,
 <trini@konsulko.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <boon.khai.ng@altera.com>, <gehariprasath@ti.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>, <u-boot@lists.denx.de>, <s-k6@ti.com>
References: <20260217112156.272154-1-a-dutta@ti.com>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <20260217112156.272154-1-a-dutta@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|SA6PR10MB8134:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b155bee-3223-43d0-f1d1-08de6e28d9eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1BxczNaVFB5Y3ZraU1OUWlwbHBhZHFlNUhuRHdPV1RiWi83YlpvTk5aQWhZ?=
 =?utf-8?B?V2ZQbzVBSWhKeWRxQW8zeTdZRGptM2hTZUpvYkpzY1pXTjdLM3pOTXo5bWVH?=
 =?utf-8?B?OTFuMjJxVkpmREhZSFNnTXBXajAxTFFKWGxRcHBlZkdjNmwxcFVtNDd3OHNj?=
 =?utf-8?B?TDdZc0k0Wmk1QlQ1Z3B2VGljdG55OXdHR0t3YUg4K2d2RUdFZG5VcjhrM29U?=
 =?utf-8?B?YU1ZVytEOFJ4azdEc0pYTHhwTUtLRUxyYUNkbUZjd3NpSjNPSkQ0cVk1cVdK?=
 =?utf-8?B?c2cyTnp3YVU5K3hVdm9jVG5pbGFMRkJCbkZFaXhJQ1AyTmVLYlF5QVdXRzFH?=
 =?utf-8?B?YU5uenAwRkx4emVJajhjTmJxTzVtUTg4WUNSckJPOFFiSVdJRUkzdGFCWXor?=
 =?utf-8?B?MkhGd1FKZi9Oa2poSThBN2xScVFRMDNkT05ibFJHcjFLbjNISVovWm1RN3lL?=
 =?utf-8?B?Qk5Dd1VQbkVkY01FV0MyZERIUGMvNTl4c2ExZlYrLzNwZFdRRnFlOGk0R2Ro?=
 =?utf-8?B?SHBLZkFXbStjcWZQL0ZKTW84NFJjY29lNkRDajJlZm1ySjZ4OWdJc0hQZjJi?=
 =?utf-8?B?NFYxUzBRK3RrbDYwSW1tV0NhYU1JdlFuaU9rUmVac1NBaFdvajVaTWFMUjFX?=
 =?utf-8?B?N2tXM0VlNWczdFNwWGd4SUhzbk1zUTNBSGk3bGRPcnMwdGJNMXhTRTdpQU1O?=
 =?utf-8?B?dERDQ0t1Z3RDYVVnQU5WRERwS3ZxK3loaTlzbVhUbmhNdEk4bHpYck9hT3ZH?=
 =?utf-8?B?TXJ3djVBdEtsUG9tQ0lkY0U4bmErOTA1RmxpL2dOMkgwcjg4bTVYOFFiM2gx?=
 =?utf-8?B?RjBOMldGS05CdE5wQ0MwNzVYczE2WHRKZVB4MXBHWkdWSnVQemxiaWxneDFh?=
 =?utf-8?B?ZktwR3FyYXFVbWt2OXRWQlhCSEZ1ZWRHbFFYTFZ6NjNNOTZnMStuVlRpamFl?=
 =?utf-8?B?Zm96THZaZUNIMGdBOFBrVC9KMFVJVlBZMDJPRCtlODVCaklHeFpWaUdBMGZH?=
 =?utf-8?B?ZU1sZ2FKTklQeWNyYWt1T0Y5MHpMSWJXWHdQTHFrTTJ0RFJMUDRqOXhBWVpB?=
 =?utf-8?B?TFo1VDRPc0htU3Bzc0tMUjBRZTVLM294cFZwelp2WGtRYURxaGF5WU9yVUZJ?=
 =?utf-8?B?Ris1NXdoQSsyd3dnNGM1czJRaGNYVGU3bVZ6ang1a0M2Z1cvbVFTU0N2Y3Vx?=
 =?utf-8?B?bjh4UWJReHYvcWkrd2ZwaFFYT0JoUHhxK0RrMjg0MFR0VWx1ODdEWGZGaHEy?=
 =?utf-8?B?bXFsUnJvUnNvbHdXWURSUVphRWxVZzM0bk1aNlUrZEI2STlSQkVzQmJLR1NR?=
 =?utf-8?B?RUNMNGF5ZVdVWHl1TW0vc085Q2hWb25XVFQ1UkJaNUJ0Q3YzZ2Eyd0JTRTlZ?=
 =?utf-8?B?a0xhTVgrS1FWdjc2My9NRCt2QjNmaWhOdHpPTmNoS3BiK1prQUVWWHBBdUky?=
 =?utf-8?B?SStKeEV1b1NsNk9KQWlteGZFbTZSQnZ4Z0k0TVlqcjdadnFrVjFkT1dUbmlZ?=
 =?utf-8?B?MjFvWkxGeWIvZXM0aGE4eU9scndCR0lYVzNXWlhkb1h0R1QwREU4d1FvdytW?=
 =?utf-8?B?UG5mNGMra3hZcVpmd01oZ29RTzVKZW9GeDFRcnQ4Y0NMQkkvYTFGdzl4YUpY?=
 =?utf-8?B?M0FFR3lNSW1NNHhmV1d3RDFramlHQWtXdUdzY3B6WTBSa3d3dFp6R3dZS01C?=
 =?utf-8?B?UmxJakU3aUhyQjBQWDV3M3lyY3BMSzVGSDZCMUNmTW4zVThaZ3p5SkhWN0Ja?=
 =?utf-8?B?bVo4VUZqQkhmVmFQMFRyMXcrRUJ5U0x2b0YwUnpwUG40T09hTTJPTFozVVNn?=
 =?utf-8?B?QVlBb3hTS0swbGVKdFFTTW9Pa0dpSEtweFpnNC9mYXpra25odDlRWVY0K0hN?=
 =?utf-8?B?TWwrQkx3bkFXelBpbCtWUjVDb09xL3c2OE0zbE1lN0w2VFdpYVFBaktjT3h6?=
 =?utf-8?B?ZHFsaTZBd0xHOGNnUzg5cU1JeUZ1bGF3KzVlWU0ydnBiREF5VjkzRFFaZ1NK?=
 =?utf-8?B?Qzc4SS9FOFpOdGlQajRxTmZ0ZFBFTm5lQ0c0UUZpR2d2RzhNQ0xnR01kblZX?=
 =?utf-8?B?S1AvZmxsSWZLSXhUL1o3RUJ3T1pZRVllTHNpVXRlYnRHYmhyWXh3SFVNc1Bx?=
 =?utf-8?B?T0hHWVEwWXVBcXVKeUt4dWJLQ0pMNWdqa3lpc0pNT1FwZ0dqOGdNNnluRWRq?=
 =?utf-8?B?bEE9PQ==?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Jq4ENpqvcQG+7opA49aGI/l4JBxRZ2X1uhTsGgcasEgSxIPNL+4xvNpTmuT2d9wYnEHv2mjAmqZ0s0lUGt71zzvPCm8nSKqB2lXDIJwxVWkUta7i/UicSoNBkkrk/tF7g4EW6kmLKFMDO61lSt7uO/cCw4Q2kPFqX6ASMqYj1vNR39HOoy1wvxX4Zna+yDh/Sh9LUNBnsew9fyi+71w8Kf1Vne3xAtOLAjwR5fDZm3+9ABiJX9tmuHPeiTXpBxQ+yUQqaD4s06C3E6ZKrEV/uV95SvhFl/IjE8fwqNuZ+lSnSVB76omy8m72We0MQxY5Ssa7SDd9/JvXCQ7gdHh94WgRIp0AxHve8fRBNbiwHpJ1jyHbR120cNGqy68wICKaQ1Ulh+DS3SFk2ACFCXZIOwCkaI/u5m3f1cFFwc7n4MzsEtBiAolWiOTqdhDFIAds
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 13:31:26.5811 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b155bee-3223-43d0-f1d1-08de6e28d9eb
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8134
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



On 17/02/26 16:51, Anurag Dutta wrote:
> Hi all
> The series adds SPL support for loading images via the MTD subsystem,
> including handling of bad blocks during read operations and removal of
> the MTD device after image loading to allow reuse by later boot stages.
> These changes enable SPL to load U-Boot proper from SPI NAND in a generic
> and reusable manner.
> 
> Tested on j784s4: https://gist.github.com/anuragdutta731/e873fb91098e71c1613fb9a3472d94e7

Tested on AM62x LP SK: 
http://serenity.dal.design.ti.com:7777/vuvucodapo.yaml

Tested-by: Santhosh Kumar K <s-k6@ti.com>

> 
> Apurva Nandan (6):
>    common: spl: mtd: Add support for loading images from MTD
>    spl: mtd: Remove MTD device after loading images
>    spl: Add MTD loading support configuration
>    mtd: nand: spi: Enable spinand build Kconfig option for spl
>    arm: spl: Enumerate SPINAND as a boot device
>    include: environment: ti: Add ospi_nand environment variables
> 
> Santhosh Kumar K (1):
>    spl: mtd: Add bad block handling for SPL image loading
> 
>   arch/arm/include/asm/spl.h   |   1 +
>   common/spl/Kconfig           |  30 +++++++
>   common/spl/Makefile          |   2 +
>   common/spl/spl_mtd.c         | 149 +++++++++++++++++++++++++++++++++++
>   common/spl/spl_mtd_nand.c    |  35 ++++++++
>   drivers/mtd/Makefile         |   1 +
>   drivers/mtd/mtd-uclass.c     |  12 +++
>   drivers/mtd/nand/Makefile    |   3 +-
>   drivers/mtd/nand/spi/core.c  |  12 ++-
>   include/env/ti/ospi_nand.env |  22 ++++++
>   include/mtd.h                |   2 +-
>   include/spl.h                |  18 +++++
>   12 files changed, 281 insertions(+), 6 deletions(-)
>   create mode 100644 common/spl/spl_mtd.c
>   create mode 100644 common/spl/spl_mtd_nand.c
>   create mode 100644 include/env/ti/ospi_nand.env
> 

