Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92FC5CCFA1A
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 04:25:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF13883990;
	Mon, 10 Nov 2025 05:25:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="NEcI3Qk3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D46F83993; Mon, 10 Nov 2025 05:25:20 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE9A38398D
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 05:25:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rgUjXuLTpeseVm8Dq6+tBdmQiP3ygMrr5+i5U5pgP13hQcWc4NuU/p3Lp57ytOBcfSu+jIHrvKoCRIuqFDRlAIuJb75uj22mn6KcumtRlFQCDf423aBTVL2cBdu8rDSv3N5gIMEp/LWQDrytG6wQW0tXa5nDrSeGfSpuC1ABBXvr9xSiP6RwIrYLUL1svJhINs8QkliAb7By0jeLWYZ8hGD34wjkiUJ2IzE6R8uhIm32+UlYKr4z66Qg9cO2ubdb+hBEEK85hMRyGM45CbUBxaQOj3ZV93jVgQpwCxVyNk1QXC/Idr0eyUaV90eOSY3t42USExapnOx4u9B6Imd6bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvEAljgj1jRDUKuqA6X/7QpMWZclmsjLEDDwACVr0BI=;
 b=pljBBheG7BX0lsSIKsM+jFlGEw8XRKV5FmDOP6C5AU5Al5d23W5kTOAnahTnHC/kSOJsQKTnmwyTePuGaVsGSjzOc21fF4ZNX68eUrO714DGSbx3wS7cF6H1pwZ0CrtZVjhqfXh4d4oHk70Y4lupKbNTvDLTUfUq6XaCMCadZ54Vlqs/zCm4lFmn9VXEegYHtvMY2XLYgvRYdO0HWoGh1NYNF+XLybXoRrNyo/+mh2U4KWPe3tEKCiyv4sP/yFdmO0LgYJ/8Oi7oevbBO4L0jAMEaPlMqTBlvIYOAE4swVIxPH+HwOIf8MggcSF494VE6ojSMIdD8hZPzXV2wq8auA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvEAljgj1jRDUKuqA6X/7QpMWZclmsjLEDDwACVr0BI=;
 b=NEcI3Qk39eLP7djYEHSmPleeCnRItPJXwIkz4/ea1lkhLxu5vHULHqfu6eaeISARlV6ee28iUxDfcsENJsM7NVTH5xfWnsq21fWHuktefTS925y8+8VdSLrEDoC7ofVJLZgAF0qF0zji2vt6d5L3NVjaNKTYNsbxtk2SNFt7Tfg=
Received: from BL1PR13CA0268.namprd13.prod.outlook.com (2603:10b6:208:2ba::33)
 by SA3PR10MB6950.namprd10.prod.outlook.com (2603:10b6:806:31d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Mon, 10 Nov
 2025 04:25:14 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::cd) by BL1PR13CA0268.outlook.office365.com
 (2603:10b6:208:2ba::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.14 via Frontend Transport; Mon,
 10 Nov 2025 04:25:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 04:25:13 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 9 Nov
 2025 22:25:12 -0600
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 9 Nov
 2025 22:25:12 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 9 Nov 2025 22:25:12 -0600
Received: from [172.24.235.200]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.235.200])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AA4P9Ee2747976;
 Sun, 9 Nov 2025 22:25:10 -0600
Message-ID: <2b1b5496-cbd2-4ac4-85cc-2b8da653bbdd@ti.com>
Date: Mon, 10 Nov 2025 09:55:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] arm: dts: k3-am69: ddr: Update to v0.12.0 of DDR
 config tool
To: "Scholz, Kevin" <k-scholz@ti.com>, Franz Schnyder <fra.schnyder@gmail.com>
CC: <trini@konsulko.com>, <s-k6@ti.com>, <bb@ti.com>, <m-chawdhry@ti.com>,
 <u-boot@lists.denx.de>, <u-kumar1@ti.com>, <gehariprasath@ti.com>, "Franz
 Schnyder" <fra.schnyder@gmail.com>
References: <20251103071035.674604-1-n-francis@ti.com>
 <20251103071035.674604-6-n-francis@ti.com>
 <btgc6fvqwkqlnnmqicvobikkyjpib5lgvda7tfyguwn25bmd2s@hdhibzylbig7>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <btgc6fvqwkqlnnmqicvobikkyjpib5lgvda7tfyguwn25bmd2s@hdhibzylbig7>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|SA3PR10MB6950:EE_
X-MS-Office365-Filtering-Correlation-Id: 66d910d1-9105-41e2-50da-08de20112490
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U3BwSklzNVpiamtkTzVMRkxaaE1nd0diWlprR0ZaeXlXSHBHU2k3YTc3UVFW?=
 =?utf-8?B?SStsODliKzIvN3ZPRGFPZE56RW8vbFVYVkxCN1hiaHdHVmZqQ2JIbjRXMHNp?=
 =?utf-8?B?VllpM1A4b2h1cWpjYmE1U1pkZ1BqYm1vU0RKUUl2NVA2MGpSTzY5LzIwekp0?=
 =?utf-8?B?cGErcURwVGNjVEhrcFdMYkxJY3Fud0pqZTd4WDcyNjVQVG5ydDlHRGRBY1ds?=
 =?utf-8?B?ekhqaTJUdzNYdHQ3TWJZY0F1VEk0bnVmT3F3YnFCeXV0YmQ4bjdhUHNoOFBr?=
 =?utf-8?B?ZllmU3IrOWg3VXNVclhIVmZvTHNVbk41eTZBTFZORE1pS1MvbHQ1WG82ODUx?=
 =?utf-8?B?RXVKTjZJRDRaNHBWb0hsKzVNdGtIUUJtN05QKzhCbVUwNWtZK1JsMGtKczBk?=
 =?utf-8?B?dUFsSFdyMXducXlZZDdGaWt0OGpldlBNa0pyTG9ReGdCcjF6OTBSOXNDYTJa?=
 =?utf-8?B?SE5lQXA5SjhGMGlKQXNYK1YrdmV1dkhDcHdkOG8yMDlmcEFIVmErbG1HNTlu?=
 =?utf-8?B?Tm1QUENsSjF1aDViazVsSUxxZ3hNR3Z2cG4vdjhNSWw4ckpnNlkwVUw5TmdZ?=
 =?utf-8?B?eFpxdVBER1JyWDgvV0NPa0YrVm94aUFsQlpkZU1nZUJLOXpWWEpmNWloWnVl?=
 =?utf-8?B?R2kzTGJac1RyK2tDQzFYbTRHTktDRTRnNHg2UDQ1OWt0QXl1c1ZZd3FVS21N?=
 =?utf-8?B?NFNNK3F4K2pZaFZrTjd0aXFvd3gzaEhuNU9Oc21NMXowNnJQUWFIK1gxQWxo?=
 =?utf-8?B?bVBweTVKVFJ5d1VjMGwzU0dVaHYwOHlRMXlLdmdCVldmQW1qQW1wYWRBK0g1?=
 =?utf-8?B?KzhSSTF6QmRGZHVNdjk4Uy93K1JzbHRWaHhaOER5aWFVdTB2bDhINHJSQVBn?=
 =?utf-8?B?czZ5VGlKazcrbzhHejhOK2lha1Z2MTNFMERuNzl1R2pvVWlHbWQrK2xsUmcw?=
 =?utf-8?B?bXg0Vk1yWDk2d3J1TmgvTVFLdGpqS25uVGtLSWxER3lJLzF6WGY1UkI4S0xl?=
 =?utf-8?B?bWVEU01oUUhmZkVXZVFhQlNsSkhmTlQzWHRBUEVMRDNqeUJjdjZDSmFpQjAx?=
 =?utf-8?B?NWFsb3BNY3d2MUlLT0dHSUdNeFRhTGhmT00zREErUlVNczE1WWEycmZWd29C?=
 =?utf-8?B?MzdwRjdLWGxOd0I0SEJkdUhjbmkza1N5bW1SUEF3VkJqMEtUSXl5eHRGZnRK?=
 =?utf-8?B?bjBMSTBSMEJpYzhadDJtMG9wSmVidXVxZVVLam83ampOSklJZGN1eFNZbHJp?=
 =?utf-8?B?VGYrWEVBN0lLcDhxTGZRbktnRy9WdFJwSk1qUFdFUFhNWXVVSzB5OFVhSmlt?=
 =?utf-8?B?SmJQSWozVjdHcmozQmQvdUNlZDgyRTd6aTZGeUhWZmIwVHZhenYxUEdSRHBP?=
 =?utf-8?B?YTI0VU4rZ2NFcWFmNFZyVG15Ujd5S3BmOStpZ2VEbTFQTGtycXR3VFk5ZTI2?=
 =?utf-8?B?aDNNYlJ3bXJCT1VwMmZHaFdGV0ZjUjNtd0lpdGFjR0FvcWVHeGJOWDlncWF2?=
 =?utf-8?B?N0M4U1FtS3g4LzgwZDZDdEJXa0ZlanVaZ1VXcmhKSHN2Nk1ZUXo3ZHVBMXJ0?=
 =?utf-8?B?L294bkdhbWpMNHBBalVKM1dUdDFjc3VxVytUUWN6ckNPWnJvSExpVHNrUjRX?=
 =?utf-8?B?b1ZRSExhc1pJVE9ndzUwUlNUZ0hEZ0hsaEVNWE1Jd0R2MG9Uc0dwZ3VYMkl4?=
 =?utf-8?B?eG1NWlJob1NLU0cwV2REVVBoWEhWWUIwa3lDYWZqYTR3cVh4dkNCdE9iVnk4?=
 =?utf-8?B?VnIvMUxiamtnSGRKTngzU3NTTXNVNGp6WjRGdFBRTTlQY3pBNUc2dlBzeVpt?=
 =?utf-8?B?am5iR0ltUjZjWktNb1JIMmlTNnRSVldNKzBZY1JMZHVveWo2OUNvZmV3YTh1?=
 =?utf-8?B?Z1o5c1duWExUaDJiNHRrWEdSNVpuQVliQUpXTXV3d2JQMTFoRlhiZE9IeldF?=
 =?utf-8?B?endJSWE1YXhHamVZRThhYlNxVFBvWmM1cGU4Ykl6NUIxVEN6ZUFaRUtNd3lE?=
 =?utf-8?B?cjJkSWVNaFV3OC9EanliN3dvam5pdEZKMzJNRVFnM25jYUhhYlhLZjY1L1lj?=
 =?utf-8?B?akFGa0NiMjFlSERRcm1qTnE0NWRhK3BiS0taZ0NYbmU2STRoM2dvMm5BMFdN?=
 =?utf-8?Q?pb5M=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 04:25:13.2424 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d910d1-9105-41e2-50da-08de20112490
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB6950
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

+ Kevin

On 07/11/25 21:14, Franz Schnyder wrote:
> Hi Neha,
> 
> On Mon, Nov 03, 2025 at 12:40:33PM +0530, Neha Malcom Francis wrote:
>> +#define DDRSS0_CTL_178_DATA 0x35000000
>> +#define DDRSS0_CTL_186_DATA 0x00353500
>> +#define DDRSS0_PI_275_DATA 0x00F30084
>> +#define DDRSS0_PI_281_DATA 0x00F30084
>> +#define DDRSS0_PI_287_DATA 0x00F30084
>> +#define DDRSS0_PI_293_DATA 0x00F30084
>> ....
>> +#define DDRSS1_CTL_178_DATA 0x35000000
>> +#define DDRSS1_CTL_186_DATA 0x00353500
>> +#define DDRSS1_PI_275_DATA 0x00F30084
>> +#define DDRSS1_PI_281_DATA 0x00F30084
>> +#define DDRSS1_PI_287_DATA 0x00F30084
>> +#define DDRSS1_PI_293_DATA 0x00F30084
>> ....
>> +#define DDRSS2_CTL_178_DATA 0x35000000
>> +#define DDRSS2_CTL_186_DATA 0x00353500
>> +#define DDRSS2_PI_275_DATA 0x00F30084
>> +#define DDRSS2_PI_281_DATA 0x00F30084
>> +#define DDRSS2_PI_287_DATA 0x00F30084
>> +#define DDRSS2_PI_293_DATA 0x00F30084
>> ....
>> +#define DDRSS3_CTL_178_DATA 0x35350000
>> +#define DDRSS3_CTL_186_DATA 0x00353535
>> +#define DDRSS3_PI_275_DATA 0x35F30084
>> +#define DDRSS3_PI_281_DATA 0x35F30084
>> +#define DDRSS3_PI_287_DATA 0x35F30084
>> +#define DDRSS3_PI_293_DATA 0x35F30084
> 
> When I compare the updated configuration to the one for our Aquila AM69
> board, I can observe that you have set an on-die termination at boot
> frequency only for DRAM3. DRAM, DRAM1 and DRAM2 do not seem to have any
> termination enabled. Is this a mistake or is it intentional?

Kevin, could you explain the reasoning for this?

> 
> kind regards,
> 
> Franz
> 

-- 
Thanking You
Neha Malcom Francis
