Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF00EE9410B
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 09:12:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20D9D83D1A;
	Fri,  2 Jan 2026 10:12:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="DEX1z0mh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47F7E83FB2; Fri,  2 Jan 2026 10:12:16 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF1E683AED
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 10:12:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-jain1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fp5OVJJX8KQPmB9INs6DjbiOnmjdSDO5SMBOpFQKl0vaof9q6Gi0ogRcb2kEVDS4GlXWblztBoAD2pWIl9dej7STirQ5ELYGAShPpkQErRy3rckPJfeODqjkniSUv2q+esVlBYETVJYKGtV2+URGh/qeCP4HlwWOuDTbm5PqGeUg5CfhD99HrtT8KnwBNs5gbqmTc9qDToANLyKrKOwG1jL0XBtzgenqT4ujFL8YT2USRqD0NiYZDpgMJn1zeajGib7CTnQhtDyibAhJutN7dA1ArQpjawDzlSg0J9RjeQbSI0PnUUFknbLW3F3jr4ucg5+zoXJyZYr/wBSmEjYV/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3bHt1K1ei2NL/fTh07I0GRL/EWkCKEppzfqsmSwnS8=;
 b=kdQFisj4V2ViHOWbXRIzzbLx7wuujkO+LYNXcvF2Wcb41LSpCYyzjzbTeMF1PGb1jJnuaN/MFtW7uk4c6Q9f71jN/4HHJjI93aVe5gWkxj6gOrEhBGCgfU+IiSdU8lc8FgbAZlxIIAruBu0h0EnZFml8FeGvslKinHG6mA37a7gIsXb1iJs8oWnJZ9xHNokJs0TIfbzH3gJvB+0BR6zgANKaeWUNnnXEguzCPSCGyiwyKiZp5A+DeDrw8hxxXdq08moEVq3ALs64xZTyZuOKn6SNYD4aOBR6Ey+FfKsIJb2T2GU12Zz23Wyp9Xxwguw82cVaMFNakmgCgPq7bDKvog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3bHt1K1ei2NL/fTh07I0GRL/EWkCKEppzfqsmSwnS8=;
 b=DEX1z0mhwOX0i98MoglgWgQGb6Y0p169f2FKimcCbTo7BPf2j3WDvnL88PlOUsB3b1PeOamBjUuuGqlkrkHz2U+xVSIcLiwzDUHnBYDcMROiRRnGVDGX4YeS8z8mzD92SgjRP1DTGLt4McsuhyBEpgobinKYSj3QgCXUXmRQW28=
Received: from PH7PR17CA0033.namprd17.prod.outlook.com (2603:10b6:510:323::7)
 by DS4PPFAEF42CAE1.namprd10.prod.outlook.com (2603:10b6:f:fc00::d40)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Fri, 2 Jan
 2026 09:12:11 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::cc) by PH7PR17CA0033.outlook.office365.com
 (2603:10b6:510:323::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Fri, 2
 Jan 2026 09:12:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Fri, 2 Jan 2026 09:12:10 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 2 Jan
 2026 03:12:01 -0600
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 2 Jan
 2026 03:12:01 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 2 Jan 2026 03:12:01 -0600
Received: from [172.24.233.20] (a0512632.dhcp.ti.com [172.24.233.20])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6029BvCa661910;
 Fri, 2 Jan 2026 03:11:58 -0600
Message-ID: <7a1750b3-c8b3-4828-a7a6-c1f44aadde34@ti.com>
Date: Fri, 2 Jan 2026 14:41:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] configs: am62x_evm_a53_defconfig: Enable A53
 splashscreen at u-boot SPL
To: Tom Rini <trini@konsulko.com>
CC: <devarsht@ti.com>, <aradhya.bhatia@linux.dev>, <n-jain1@ti.com>,
 <tomi.valkeinen@ideasonboard.com>, <vigneshr@ti.com>, <praneeth@ti.com>,
 <h-shenoy@ti.com>, <u-kumar1@ti.com>, <n-francis@ti.com>,
 <u-boot@lists.denx.de>
References: <20251106085842.629521-1-s-jain1@ti.com>
 <20251106085842.629521-3-s-jain1@ti.com>
 <20251230175012.GA256115@bill-the-cat>
Content-Language: en-US
From: Swamil Jain <s-jain1@ti.com>
In-Reply-To: <20251230175012.GA256115@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|DS4PPFAEF42CAE1:EE_
X-MS-Office365-Filtering-Correlation-Id: 38e6696f-da6f-4140-d25b-08de49df02e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ajB1K2M1bFNkL1hSUnZQNmFZMllwaHBvbjVyaXlGSjhxandVMjZHdkpkRDZk?=
 =?utf-8?B?VzFsNEtzdysyc0dRSDFWUi9DaDRvQVZQVUgySzBHaU1acmRRRzUzOGU3b3Zh?=
 =?utf-8?B?WmhCV0w5OTV3Vk9MZHVqTk5HYkNsUmh5VUF1LytxNng4cGFDQkFGQk1JQk1m?=
 =?utf-8?B?ZmRMdGl6MkxrK0ZBYlRJeUlnR2xxd1JxUjZCMTRQSVpsQUNXNXJscnNOSmlN?=
 =?utf-8?B?bytha2VadUtqT2tmbm5KRVFaTlIwNHhIMTRYSkYzR2tudE8yVG9BNjE2REdO?=
 =?utf-8?B?MXEvbC95SEhXQnpYaUlHc0k5cVNwZ2NoUHl2Y2V2dHdoNnZBY0grd0NXNWpT?=
 =?utf-8?B?R3dUTFNYYU9ld1BDRnorNHFkSCtDSnFMUkNtVktubkphZ0Z2WlhCREJwS0VC?=
 =?utf-8?B?aFFQU3RQY3RRbURhem1oM2k5ai9NTHJUK2FLN1ZuR1N3aWVmQk1TbzhIeE9E?=
 =?utf-8?B?Q0JHQzl6WGZFTFpxdDdpWXZhYUhSM09kUWFuZ1licVBtdTJ0bWxqa0psQ1BV?=
 =?utf-8?B?MEdzbFc5RnpFcitHbzRBRGtjVmxqMTR4bU9tUm5BeWhMTW1FRmthWXBDR2hQ?=
 =?utf-8?B?ZHRIVUFkaCtNaHZmTUdmUC9KZ0h1bGZTRnhjdlBObS9HWlBwNEkwVXVNblpL?=
 =?utf-8?B?dnRyblliUmF5OVZ0RDNPeXBVWU95UXllb2pHaFc2bWJuS0w1SmIzcmFqWU1S?=
 =?utf-8?B?RmJzTzRYckEwSkdqK2FwTnVZbW0wZkh0M2FTSjVsWm1UOXRjS3NwWHB4LzVL?=
 =?utf-8?B?U1VLNCt2T0s3ZE16ZHQrWFowRjg2Rm5qcU5RbnFKMHVmajZxOVk3NFczWXJ0?=
 =?utf-8?B?cndHdkFZTkZGU3FqQjNvMU1PSmhRMHQrK2lGWFZmTlhadlBpRHRLVnRncWMw?=
 =?utf-8?B?c3ZZNkJQUTBqUEJIeXNYWGRYVVA5cmMvS1NDQ1dkODYzRFQ1dGovYjJnUzMr?=
 =?utf-8?B?UGVBdkc1aFBGQWxCNzVleUx0UHJsVU5mSEptOTJHOEN5Z3plN3QydjNhQjJy?=
 =?utf-8?B?SVM4SjBGdmowVGFqVmdGN2RFYTRxSWFZK0Jla0s1WVZsNlpaZjU2Mm1ySXJn?=
 =?utf-8?B?Q0xVa21sMitYSjNheWpWaHMrZVBxSTBvY0MxQSt6amlUbU5vRlF1aThmOTNp?=
 =?utf-8?B?S1lGTS9TVkYzRW0wOE9FSEszSnpXWW9rMTdVRWtEWG5lUzZybUoyTjVETVlu?=
 =?utf-8?B?U3pqcW5EbGZGUTNBcWU3L0ZqV3RrSHlwdFJ3cXM0UWhlRnplbzhqS2ZjNndD?=
 =?utf-8?B?ME94WkdHeC9JdndCWlhsVWpLQ1NETkxjYUdxL3NEVUtoUStnK1J0elI5WDB4?=
 =?utf-8?B?cHdOQXN2NzhZQUREVUdoYWlyRVVMK3l5SzZOR0Z2cVdFSzN0QzNWRHpuaWZz?=
 =?utf-8?B?Zk5zVE9RQ3MyTS80YVZ1TC9rcGJFdm9tbWFMbXJGcmFkVHNoa1VPaDh3a0Zl?=
 =?utf-8?B?UTNwdGVMOU1vcGxyWC9qa3hIVXVqd3JtMkh3U01mMnJZUThkREx1U1pRZ1BK?=
 =?utf-8?B?YXIrc0NhdmtUaFFDYkhsbURqOGJ5bHRhWnNUK0tucndwUXpkRjJQcXJrYTVm?=
 =?utf-8?B?VS9qM2U4MldsdCtSaVA4b3Jmd2xZRVdkeTgrQlZCeEdlY0p4OTQxZ3dLQm5a?=
 =?utf-8?B?MlhqdkNBMHBRcW0xUGJEYlgyQjlscjRXNUR2WEZ4TkFRSVBVR1BHOVlkbUFO?=
 =?utf-8?B?Q0tsclg2dkQvWWxlUVVWcE5VS2RMWkZiMXdyNnp4dXdwcEsyVGp3QUp3L1ZO?=
 =?utf-8?B?WmMzUVVBRWlUOEZUSFNqc3NobjR3ZXVVbUV3a3QwVUtKQ2hwODl2aU4yY1FL?=
 =?utf-8?B?RUpWUkxTSXl4M250b2dsU3BRR0hyT3VkSW9lSjNlTlNnU3IzdHViN3V6c0pP?=
 =?utf-8?B?L3hEcGtGV0lwanBvSGlYdVRzcXFmeGs0a0ZWVmU2R1JFcW4xVFFnTTI0d205?=
 =?utf-8?B?Nkt6WkdndlUyUUplTXNBN3kwNjVmcHZmVEs5a2U1MEpZVW9FQTZHUDZmU3Zz?=
 =?utf-8?B?R0t0eldJTS9iREFoZnpOTkdnNTUzYlc3cHpHTzVjM3kwSWJkVi9OOHdWWjRs?=
 =?utf-8?B?cW1PclRXV3VHc1JjSlduM2l5eXZmT3JEbDZpRnZNVE5hTWJwNWgwYjg2amt0?=
 =?utf-8?Q?zAkw=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2026 09:12:10.7951 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38e6696f-da6f-4140-d25b-08de49df02e7
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFAEF42CAE1
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



On 12/30/25 23:20, Tom Rini wrote:
> On Thu, Nov 06, 2025 at 02:28:42PM +0530, Swamil Jain wrote:
> 
>> From: Devarsh Thakkar <devarsht@ti.com>
>>
>> Enable A53 splashscreen at u-boot SPL stage. SPL_MAX_SIZE is bumped up
>> to 0x80000 to accommodate splash related code. SPL Board initialization
>> Kconfig is set to dynamically update simple-framebuffer and
>> reserved-memory DT nodes before kernel bootup.
>>
>> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
>> Signed-off-by: Swamil Jain <s-jain1@ti.com>
>> ---
>>   configs/am62x_a53_splashscreen.config | 17 +++++++++++++++++
>>   configs/am62x_evm_a53_defconfig       |  3 ++-
>>   2 files changed, 19 insertions(+), 1 deletion(-)
>>   create mode 100644 configs/am62x_a53_splashscreen.config
> 
> This in turn makes am62x_evm_a53_ethboot too big to compile. Please
> figure out how to re-factor these changes, or update the _ethboot
> version to disable this again. Thanks.
> 

Thanks Tom, will fix and resend the patch.

Regards,
Swamil.
