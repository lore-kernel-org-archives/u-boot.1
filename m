Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 483ABCCF9FE
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 05:15:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 827058331F;
	Mon,  3 Nov 2025 06:15:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="AUnuIdYX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C27083642; Mon,  3 Nov 2025 06:15:06 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36D6A80050
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 06:15:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qsnEfyfmw3/AZ/VRKfvBhYbgQIPo/2yC6l4ESGglbJw59OXUmyaU3ezxdg+79+qw76Wdgq1IVI2mQmiRxOh0ftNyYfy1Z9O2Ero7IV9d01uzFttoAbb0YV1uSOa6Cgil+d2HzJriF9xx8aW2BLfIO61tuEuBI25xEeFQ5x8MNIt/MQsYV4OtXzpBVPbgkBLrCcdppCY4fNXDv5TJNQIn7f4hI3T8zTvI4SmQrFar6peAlJnN5zQPbe6ChXe+Ux8z1Qpsh7ALf7vr1WMgLlXYf5YLR3dUqUh80U+SKacEHG2LnzWOKKf+PxtKy6Rk6pl1dRvFp+sqnD12RWk+Mz4lYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjKsZzPWra2f6waJOqFA3Pi1UuKExpGwlX29Cdmy+Bc=;
 b=cR4UlxzRp3U7hYvoIBqKa70e2ynH0mzhIlUSr9hUuYNgPFHB27YtdM5qRlXex+vJZe9/h0kiEyaVcMLDZ5mtJ7ky3luGfD/FzXYzQk5uUgMNCgiJoZXFkdZiH8iQiQcHwZn4Sgfxv1ikNq25z9cM6Zyo4M8Tk79TI832VGz/n8DaWvhX+6e3Rl5anRNph4Ph5JIAW7BZ0EK6jB9g4hUa1HKOz77dQeoW3vevyP2C3Xzlun8L6lWNtWYihlowF8a/4VbtBgh3dGekLcXzAJv5QeZXpvUzrxsR3FQpPEisJyZtm9Bse2878qHgTton0JakivdTjSg1BGinMKDHAzD4dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjKsZzPWra2f6waJOqFA3Pi1UuKExpGwlX29Cdmy+Bc=;
 b=AUnuIdYX0PM7z8/ZAMpR1HK2i8IXE+OPAW2eRL/zwV9ctjk+OTTp2gm6/8BxRdU0N9D5WxqwVJxosHssg/myyl/hLHh0U4PSVZu09O2Is64rQ9luYD7TsMRqLU0Drw7krR4SjYSMIh68ME1wc93jS7mbH4xRKOq4j40Sea6Gc7o=
Received: from MW4P223CA0018.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::23)
 by SJ2PR10MB7618.namprd10.prod.outlook.com (2603:10b6:a03:548::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 05:15:01 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:303:80:cafe::88) by MW4P223CA0018.outlook.office365.com
 (2603:10b6:303:80::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 05:15:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.0 via Frontend Transport; Mon, 3 Nov 2025 05:15:00 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 2 Nov
 2025 23:14:58 -0600
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 2 Nov
 2025 23:14:58 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 2 Nov 2025 23:14:58 -0600
Received: from [172.24.235.200]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.235.200])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A35EtCs3534825;
 Sun, 2 Nov 2025 23:14:56 -0600
Message-ID: <f94ecef1-5fe2-4809-be70-ac5d36becb77@ti.com>
Date: Mon, 3 Nov 2025 10:44:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] arm: dts: k3-j7200: ddr: Update to v0.12.0 of DDR
 config tool
To: Bryan Brattlof <bb@ti.com>
CC: <trini@konsulko.com>, <s-k6@ti.com>, <m-chawdhry@ti.com>,
 <u-boot@lists.denx.de>, <u-kumar1@ti.com>, <gehariprasath@ti.com>
References: <20251031053425.3960963-1-n-francis@ti.com>
 <20251031053425.3960963-2-n-francis@ti.com>
 <20251031113240.b3kdiupm2v6n6tob@bryanbrattlof.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20251031113240.b3kdiupm2v6n6tob@bryanbrattlof.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|SJ2PR10MB7618:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c58f1f9-f350-476e-187e-08de1a97f032
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|34020700016|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U3pidEJFUnFranEwa29Ubm1ZcXpaM3pac3lTdXZGcVhlbVZPZU9NOC9TOXFu?=
 =?utf-8?B?bXVIcGtIZmVmdGdiWGtMUDZrMkxjWDFiTmsxbVNFTTg4K2QraGlJOGw0WmMw?=
 =?utf-8?B?NnlwclNBWHNMYkZlNHdpZUFLWkxsR24vTkR6dmMvRktueDJkQkJEZGR4bVRN?=
 =?utf-8?B?SGR6V3RuSmxoMndLeHJkOUpMYUJBbWgzOTZpTGJqSTE2V3ZXc093VWNUb1BK?=
 =?utf-8?B?aEN2MEVGRDhFYVY1UzBvNmc2ZlI4bUpzRE51N1c4bUlWTTR1RXhSbDdWQnZY?=
 =?utf-8?B?ZENPUGhZajAzVGNxUDUvNGJQSlhmM3JkMjBkTjZJeGtrYUF0cG1TRnBmQ0Fj?=
 =?utf-8?B?cmp5VGwxT1RmUEZzNG1rQkl2cUFkam0vMTg5OXlTbmdQQS81N01DaE1ZcXl2?=
 =?utf-8?B?VitPU0I5V3k0VkVkWHYvQXFNVnJ5UGNTZjlPektPNDl5L0lHUWw1eXJlUUdx?=
 =?utf-8?B?c09vU3E5RnR5b2Uva3gzQWM0dnJxM0lwV2xnbFVic2YwYWJyRWJsRUp4SnV6?=
 =?utf-8?B?WDhmZDBmUXFEclNVNDRiblB3bnNaaFRTdUFGdDUxbkhQVkVMV1hwS3RraFBU?=
 =?utf-8?B?ek9pU0hQZDR4Qk1KVzBXckh2ekp6OXI0SnZKd09oUEVGZEpDUWFmVHhnQXQ0?=
 =?utf-8?B?c1o2NWpURk9DQVAvN1R3MFIxK045OWJEcjJBQjF3Y0J5RXZYZ0pqTmxneEhU?=
 =?utf-8?B?eE4vdjl0QWRBOEhBU3d4TVFyM2RJaklwalNvbkdDcjBwdHh6TnNrV2RhUU9p?=
 =?utf-8?B?Z2djMnd4dE02VWpCamhob1dDUklLUXRKNTdBSm5iS3Y3c2xNT2pyY0Z4M3BM?=
 =?utf-8?B?TkN6N2dzQWVYSW03YVIwSExRRUhRSXhKMGladUxkb1ZicndBZmNkYUZnWHlh?=
 =?utf-8?B?YXFLVmlHL1V1bm9ROHhWK1l3TEVRblE5NFU2dWVldnYxSzAzZUtOQVUxeUZT?=
 =?utf-8?B?NTJibUhFeEh5amdDRHNrV2pVTEpXc2l0Zk10ZnNCZWJFQWpFcS9OLzMvWVYw?=
 =?utf-8?B?eDRGWmhqNlV3Q2dpK3I1M3FSSTRVWWVJSnZMU2sraGpBUktIdUpVdm9KZ2Rp?=
 =?utf-8?B?VHFvcTZpUW5uY0ozcklEbnpTSjNsRFVxcEhEdmNuWm1UMTJDL2pweGVpdXNS?=
 =?utf-8?B?ZGVOdlZJeHNGVmFVa1hoQjdRdjRqZlF6d0dNOFB2N2RHa2NsUHdLV2xHb3pj?=
 =?utf-8?B?ZUljZFdCUkoyOEJhZ1RhZ0dKVitUYkx0MGJTSEpaeFYvYm1EYUxHLzU2bUQ0?=
 =?utf-8?B?UCtSM0ZnTkd5VUJEYy8wY0ZQSjQxWGQ3VG5SUnFPSWtyT1BKSm8weDh3a3Vl?=
 =?utf-8?B?SmFIRnU3VndOUXVBOGxiQm52VmJIVWRTSG0rU0NURjd4andxMlRMS3BjWFlR?=
 =?utf-8?B?T1pQakJYZnovNWk4VHdPSkVFbFZSK2ZxUnZaVnBPbWwvQTR0Vlk0QndGM01z?=
 =?utf-8?B?MG9hVVh4R2kwSWVFWVJVb2IrTGhWRHlPNlVteXdsUFp5TVI3THZPaVhCekgx?=
 =?utf-8?B?OFlqNWl2MXFrVDhWNWYrYjFUSU4wVmN4enI1eks5TEZ3eUkvVUNOWWM3TDBM?=
 =?utf-8?B?Z0ZXSytPeVFVYlU4ODRXOFhxc3F0NU0vM2ZIU0xDN1lXMk5ocVc5Y3A0emxL?=
 =?utf-8?B?N1NQem9CYXdlVklYQjYzeENyMlZ5aWp1Q2sySmxTcG56c09QWlRNZlN6Yk5r?=
 =?utf-8?B?L1VWWHlIMVl2ZkJMNnNzYldiSGdGUm9zZTFLQ1R0a1pXaVh5YTNXb0thU0dn?=
 =?utf-8?B?YnpGV2xtWXo4U3k3MmdhRXZPdU9vUWdRQnhFNjZNditRNU5pd3J3cTdWOUdI?=
 =?utf-8?B?UlpTYUVUMXBORWpSa29YMTBiWnhMS0p1QWxWSkZXbWhsWVlqaGRKUy9CNGhR?=
 =?utf-8?B?aS82OTJrekRQbWZtd1FFM1dhaTViZ0ZjdEpZbDZBck1IdDhaU0Y3R3M2Mm5D?=
 =?utf-8?B?TzNGc2Y5eGR1TkphbWJzOTFPSjZYd1hIZ0p5b0lmOVRka2gvaTZKYmE3TlZ6?=
 =?utf-8?B?dGhvNFowdXJlRzZ5eHNTbDJGL2xmMTNPcWJhUDQ4YURzanJNRFFPRHQ2eHRo?=
 =?utf-8?Q?e+4X3o?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(34020700016)(36860700013)(1800799024)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 05:15:00.4000 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c58f1f9-f350-476e-187e-08de1a97f032
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7618
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

Hi Bryan

On 31/10/25 17:02, Bryan Brattlof wrote:
> On October 31, 2025 thus sayeth Neha Malcom Francis:
>> Update the DDR configuration for J7200 according to the SysConfig
>> DDR Configuration tool v0.12.0. Log of changes between 0.9.1 to 0.12.0
>> is [0].
>>
>> [0] https://dev.ti.com/tirex/content/TDA4x_DRA8x_AM67x-AM69x_DDR_Config_0.12.00.0000/docs/RevisionHistory.html
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>>  arch/arm/dts/k3-j7200-ddr-evm-lp4-3200.dtsi   | 2207 +++++++++++++++++
>>  .../arm/dts/k3-j7200-r5-common-proc-board.dts |    2 +-
>>  2 files changed, 2208 insertions(+), 1 deletion(-)
>>  create mode 100644 arch/arm/dts/k3-j7200-ddr-evm-lp4-3200.dtsi
>>
>> diff --git a/arch/arm/dts/k3-j7200-ddr-evm-lp4-3200.dtsi b/arch/arm/dts/k3-j7200-ddr-evm-lp4-3200.dtsi
>> new file mode 100644
>> index 00000000000..810415494ce
>> --- /dev/null
>> +++ b/arch/arm/dts/k3-j7200-ddr-evm-lp4-3200.dtsi
>> @@ -0,0 +1,2207 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
>> + * This file was generated with the following tool revisions:
>> + *     - SysConfig: Revision 1.25.0+4268
>> + *     - Jacinto7_DDRSS_RegConfigTool: Revision 0.12.0
>> + * This file was generated on Thu Oct 30 2025 13:11:41 GMT+0530 (India Standard Time)
>> +*/
>> +
> 
> ...
> 
>> diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts 
>> b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
>> index e35b767a7e3..3127ac83d7f 100644
>> --- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
>> +++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
>> @@ -6,7 +6,7 @@
>>  /dts-v1/;
>>  
>>  #include "k3-j7200-common-proc-board.dts"
>> -#include "k3-j7200-ddr-evm-lp4-2666.dtsi"
> 
> These are automatically generated files. Why are we keeping the older 
> configuration around? 
> 

Yeah I wasn't very sure of whether or not to keep it when the op freq is
different. I saw both k3-j722s-ddr-lp4-50-3733.dtsi and
k3-j722s-ddr-lp4-50-4000.dtsi coexisting so followed suit in case the
end user wants to have the option to switch between op freqs. But I'm
open to dropping the older files, if someone wants another freq they can
use the tool to generate it.

> ~Bryan
> 
>> +#include "k3-j7200-ddr-evm-lp4-3200.dtsi"
>>  #include "k3-j721e-ddr.dtsi"
>>  #include "k3-j7200-common-proc-board-u-boot.dtsi"
>>  
>> -- 
>> 2.34.1
>>

-- 
Thanking You
Neha Malcom Francis
