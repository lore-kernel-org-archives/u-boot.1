Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B2A8E909A3
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 13:37:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 673BA83C72;
	Tue, 17 Feb 2026 14:37:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nSNpEthZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 338EB83CF2; Tue, 17 Feb 2026 14:37:15 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE85680325
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 14:37:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AgdubXou6YmvFvoRQIVLwX+TURd6VJ19vSt+Ed7kMddOO6wm1QTQidiCWB0uL/lEbIU5kXWzAncxEOrzy8Wes0f3dyqFoqPPj9zuq1tLqVLL0duOMk0AQd6QNVWVy7K5zUnY1MkLHN3yBxiX4331iTItvmu6iWb3oTkMJe1PgnwD5MT/BzT84sPkfncuXURM1fAemUGHqoojVvUQT/XhamZ7Wtw/Q3JYF4Wb4EBG33JJOV7YjGuDSQFsGJqA3ki2zwvkRf/Qz13mlMW29lSG0/+nDYHDndl2EUx3DLbDiSZNZBPZjPNDh5nQtsW59hlPvM5PYvZiMAtNGIbOB3I9Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xghwt2ylAkiJdOtAD/XWbHGWeQRBHiObPWWhadRYl0g=;
 b=HmjldBDvSK6blq4NCW/WTPjFTTQ8EfFprJshyiQShuC4jRASg5X/RoO8EM2nvrQXO91/wBfmSFHdVEXntvD1ri3ksWEzIoTABFrQM0AtKJ5XoX6cJ3Rey8yaCd9PngBtx3c+14NfjtnASIBPsfUOz4ZSm50EnJgS3XIB1NDdlZti5p2ji7xFZZrqJoi2vXGNqyB+iWGcn2PJ+3cicH24CvwYOBrHmgweC6Qmo18bTmc81d+BrvTH3ArjN9l2etFYhQAW1sy+O7pYIuDsQvvBxlfzGC5L4PXsN1JdXHrOFuggDKcC7AVWmDpveWzPL/+gXfL/SXGUPqdJpSbltU7iQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xghwt2ylAkiJdOtAD/XWbHGWeQRBHiObPWWhadRYl0g=;
 b=nSNpEthZn1Z4pgLyp5537mxl4IUtpjzWpYPr5CyYO5U8SOc3rWJDDIyUD26qzZOtS0zQMlM9VxgxKCjvHH915A4isghvFlDdMvETa5AFWUxEYnCYWgnl2gKM0lhlF3H9EObj7WNmDmyzaBlj1mob2IrRFFKDUqcglEkAuTPeO0I=
Received: from DS7PR03CA0088.namprd03.prod.outlook.com (2603:10b6:5:3bb::33)
 by IA3PR10MB8300.namprd10.prod.outlook.com (2603:10b6:208:582::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 17 Feb
 2026 13:37:09 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:5:3bb:cafe::f0) by DS7PR03CA0088.outlook.office365.com
 (2603:10b6:5:3bb::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Tue,
 17 Feb 2026 13:37:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 17 Feb 2026 13:37:09 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 07:37:08 -0600
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 07:37:08 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Feb 2026 07:37:08 -0600
Received: from [172.24.233.254] (santhoshkumark.dhcp.ti.com [172.24.233.254])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 61HDb4Xh2939113; Tue, 17 Feb 2026 07:37:05 -0600
Message-ID: <858054db-d163-45b0-8ddf-28bd0f046e85@ti.com>
Date: Tue, 17 Feb 2026 19:07:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] OSPI NAND MTD load and boot support
To: Anurag Dutta <a-dutta@ti.com>, <jagan@amarulasolutions.com>,
 <trini@konsulko.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <boon.khai.ng@altera.com>, <gehariprasath@ti.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>, <u-boot@lists.denx.de>, <s-k6@ti.com>
References: <20260217112156.272154-1-a-dutta@ti.com>
 <c487a05a-2fba-4620-9d0b-768cef20ff44@ti.com>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <c487a05a-2fba-4620-9d0b-768cef20ff44@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|IA3PR10MB8300:EE_
X-MS-Office365-Filtering-Correlation-Id: e19dfcf3-d632-42ee-3990-08de6e29a60a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ajkySFJrK2NIYnNFUXpxYm42K1hpb2ZWNTNXRzRKQ0JHMGhtajJLTTNyaWQv?=
 =?utf-8?B?SlY2ZlZ6Q0dFMWVtdU01MnVKYnRyWkVVRk8xbllYSUprMmJZUVRwN1hhOUJQ?=
 =?utf-8?B?VnNHRWZCUlEwempiNm9MSUhaYUMwWFVYYVhNUWloNzIzTTdTSWhDb09ROUcz?=
 =?utf-8?B?ekQwVHNHQk03Yit3SVVHa3B4U0N1UlpCZmkrS3lOSTRsTUdvclZ6dXNicTZT?=
 =?utf-8?B?dGxwSUNzTTBINytpRG1saHBnZlRQSGhKajBzZE1GNHBQaDdyY1Z5bDNIejc3?=
 =?utf-8?B?UkxyUGlrM1cvWk9lN3k2UExueitLaXIyZ2pSeU9kNWdaOWkzYitBRmVZUDUx?=
 =?utf-8?B?ZkNBVERHd1cvcE5jUWRLSmgxTFNra2dpcUQzMDZ2bTYvOHlkN0RUZS9EVnpJ?=
 =?utf-8?B?dWU4eUFDb2xTeVQ3R1Z2MUFZK3did0M4Mm5VSVBueVAyYXdKRXRUN2FEdm9M?=
 =?utf-8?B?V01ldFl4dU9hVGJ0NG9PVStMMHZlOHI1bWVZNndZK1ZDTkFIM2FTelo4YThS?=
 =?utf-8?B?M2JXUE1vYnRuWmN4VXhqZ2RBRFJPY0tyamRFaGxXZThiZTFNL1ZncTBwb24x?=
 =?utf-8?B?TkV6TlJNaVNmakpKOE9KOC9iNDQwWEtHU0ZvZjNUZFNMdXFCRmNBVkUvcE9Y?=
 =?utf-8?B?YW9Wd1FMWFlaRXV1akdFVWI5MkVMZUZ3akFpNVhTWUNiTHJwTFBtWVdzdnFo?=
 =?utf-8?B?T1R5cEQxeTNIL3A3Z3JtcVVkMW1TeE9VUFlwOUxoSUZEMGM2S1gvZXl5MjAz?=
 =?utf-8?B?RHJEYVM3SzJkK2preCtsRkVLaUhuV3JDWmVFcnV2czFma0V3cGlUbXE4aURX?=
 =?utf-8?B?dWh6ZU5ydzJKbTlYK2Z6b2FUcUd5ek1iU3ArWjFTQWYwb0dJZXdLOGdZNjNU?=
 =?utf-8?B?Vm5kWWhtbVZaNDloYWsxeWRNY3ZCcEpsS2Y2ZEs0TlM3bjJKeDZLdmxVS0t0?=
 =?utf-8?B?VGpod3lHOW9TM0VrN1k1MzlTT09ORVBjMUYyakc5RXNOTm5NL0VIcnJJZkZ4?=
 =?utf-8?B?L1NDM2JWbFZqM2hoTmZ3OXZWNVRrVHJUT1BlNXVmUURiUS9jUnExeFg0U25T?=
 =?utf-8?B?Ung1SHNoQVpmNWh1S2wzMFFVVUtiV1FvVGphOUU1ZzV6OFJQUUV5dTRWN3V6?=
 =?utf-8?B?ZUpaenFoVmFtODRXS0RES2hVNlZDTGhaSXZvcTIrdXZnOFhCNmdTTDh6bFNY?=
 =?utf-8?B?dWhxbTI2U2QvUkQ0WSs1R01Hd3ByVmNiYXV5QlIrcHJXQzdpRFNXK2pCS1Rj?=
 =?utf-8?B?TTNSYTJDTzdaN1ozVnJMZG1TNXloQmZtNFN1MmVmVTR2VVplbUQ4NXdzc0VT?=
 =?utf-8?B?VUw1c0d0NTE3OFFhc0xWUjBuckg4elNWajVZS3E0UDdHaXN5Y3VFTGZuNXcr?=
 =?utf-8?B?akRBa2FVaE44eUdTRUx2ci9XK1lxQndtV2tkMnRhR09pSWdVRlhGdE93eUxS?=
 =?utf-8?B?SWRFcUhQZEwrQjc1bkx0am1DMUtzeFNSMkVlUnFrS0hOMmQ1SkVKaGpwU1Zn?=
 =?utf-8?B?MkJNSEJhcGw0RkQwMVpkY2Z3VUhoYlRHV0pRL2JjM29ZSDFPdEFleXJxK0I4?=
 =?utf-8?B?eTZaMXRKRnZnNHNLMVU2YlZvelRyR29QVlNuRmdKcXJMTzcwVDduZ0MyM1pF?=
 =?utf-8?B?Ty80NjY3VGl0c0RzREZySmxScTArTHh0Wjl0YzlVUEZVZW9DL2UxamhqdmZt?=
 =?utf-8?B?QTFCSzNsaEs3R1lta0tXZXFYc09QR3dmdllMSUsrVld1VHJnMkVuME5mcmVK?=
 =?utf-8?B?ckJWakwrZ25yOVhwVDVpWEV0eTRvbG9QQVQ0SGZnMnh1M1FSc1VMY2VJSldD?=
 =?utf-8?B?TzhObFFRTUEwMmw4ZTVzVmdiOVJsMFNqdlIrRmhsdWdORVpEUmIwR1hMRVZv?=
 =?utf-8?B?bUJYTHQ5YUxJMkhOb1AxMTZ4dEs3Nm5BMzF2anJOQnpLbVB2cFVXd3p3V29D?=
 =?utf-8?B?eDFFYVlEWi8wYThiUzk1U3JDaEQvck1HaFc3aDRqTVZUUGUyQ1pHWUVnd1l4?=
 =?utf-8?B?TDdsUGJPcTdITUFZZkhxM1ROdjc5SWkzY2dlbGQvYXh6MXlRN045QitiSlVF?=
 =?utf-8?B?RjZOVkpEWitGOHFpQkVGS2FDV3RPRFJwMndJLzI3NzdXeU8vTU94Njc0ZFB1?=
 =?utf-8?B?VWlvb2trU3pCVXBDMkRNbldYaE1Najc0aHhlQnNIMmsxb3BqZ3hyRFJrRVhV?=
 =?utf-8?B?TVE9PQ==?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JLaOXLXlt0Y88bR5M/Mm5962URqv7QhDcMzlKGDeXoUxyEtXj3vrMZFD9gBw9P0XElGwCQjlj8KMWo+N/YrtTNGTxzIxkU96BkfBc3HHniVtoJLmkmv2k4VW5kovWiH605SlsF0yk9Z1/hcC6OT7NAOeSJyQ0dhjIK0YvFsjFV6/DIb5yPxsAj4Ne8rzaEvYlBFKzqQGQunZt4Yc1y8c490uisRlaaIEgK8kAN3DK/BoHu3Z8lr5dgUXCClvOO2XntBS/Qp+3jK5XqScqrVxANKKa0qO4EvWAaMIJuIVl9JZypS3BwYutqC/xCo8WkplGVFHVsOJwR0T/Wm8RBaBQzi6GGPQZmpMXuwPwjznRv6xPwmztRvJtwhFltjBBayON0e4gRHs3y03L5n8dztON3vTVZgsB2ex2fx0bfScjKNnVXsDRcgDPs80ExouQCS+
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 13:37:09.0560 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e19dfcf3-d632-42ee-3990-08de6e29a60a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8300
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



On 17/02/26 19:01, Santhosh Kumar K wrote:
> 
> 
> On 17/02/26 16:51, Anurag Dutta wrote:
>> Hi all
>> The series adds SPL support for loading images via the MTD subsystem,
>> including handling of bad blocks during read operations and removal of
>> the MTD device after image loading to allow reuse by later boot stages.
>> These changes enable SPL to load U-Boot proper from SPI NAND in a generic
>> and reusable manner.
>>
>> Tested on j784s4: https://gist.github.com/anuragdutta731/ 
>> e873fb91098e71c1613fb9a3472d94e7
> 
> Tested on AM62x LP SK: http://serenity.dal.design.ti.com:7777/ 
> vuvucodapo.yaml
> 
> Tested-by: Santhosh Kumar K <s-k6@ti.com>

Ignore this mail - I responded to the wrong thread, my bad!

  - Santhosh.

> 
>>
>> Apurva Nandan (6):
>>    common: spl: mtd: Add support for loading images from MTD
>>    spl: mtd: Remove MTD device after loading images
>>    spl: Add MTD loading support configuration
>>    mtd: nand: spi: Enable spinand build Kconfig option for spl
>>    arm: spl: Enumerate SPINAND as a boot device
>>    include: environment: ti: Add ospi_nand environment variables
>>
>> Santhosh Kumar K (1):
>>    spl: mtd: Add bad block handling for SPL image loading
>>
>>   arch/arm/include/asm/spl.h   |   1 +
>>   common/spl/Kconfig           |  30 +++++++
>>   common/spl/Makefile          |   2 +
>>   common/spl/spl_mtd.c         | 149 +++++++++++++++++++++++++++++++++++
>>   common/spl/spl_mtd_nand.c    |  35 ++++++++
>>   drivers/mtd/Makefile         |   1 +
>>   drivers/mtd/mtd-uclass.c     |  12 +++
>>   drivers/mtd/nand/Makefile    |   3 +-
>>   drivers/mtd/nand/spi/core.c  |  12 ++-
>>   include/env/ti/ospi_nand.env |  22 ++++++
>>   include/mtd.h                |   2 +-
>>   include/spl.h                |  18 +++++
>>   12 files changed, 281 insertions(+), 6 deletions(-)
>>   create mode 100644 common/spl/spl_mtd.c
>>   create mode 100644 common/spl/spl_mtd_nand.c
>>   create mode 100644 include/env/ti/ospi_nand.env
>>
> 

