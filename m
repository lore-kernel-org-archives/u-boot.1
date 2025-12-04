Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56638D2168F
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 15:19:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D04480107;
	Thu,  4 Dec 2025 16:19:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FBCVi910";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 453248042F; Thu,  4 Dec 2025 16:19:54 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12F5480050
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 16:19:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Smmv3DfoeBtSt0xzpLEdzsO3osy7WV8NxMjkowN+gFJyW3/9ir7MOnA80qH5m2AQ7+4WYmld4+eeSt4IqIAYHlelGXU1p69QZZvlP259+bCi9m20EnCG/aFw8kCJSaq9zBcjPmXPvy0SXr0lKgSUJVKvR23EYlTeppzUmTiRtirVhYFP0S73/LjSO5fYnuNM0bS2Sms9RfX4SZJNnpYhEeaFEZ8If2z8R1XVVniH5XMKrYGVqOxu9kVqUM40GwN6wMB/RM9IWKt/k7ivI73nerBl+oLzPu3eWd0Bw3JiAYw9o1WHX9rRMHIr3tuXvSNBOb5JIXa0WHq65cQV6pz92A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5siYlwWyELY6BG33Tpz4BSzEQuez2/P+fP+4AlO1QhE=;
 b=nrNDhTPh7TE3GK60Cy6sMRInCd4q6pLs1Hscb4Txe1FZml/XmKvZO60SwgROwCezpGxmq+rvjlxZcTBdHdiC0Vq16PAXNB+rMzIbJ131K3lndpdIMbRk7j2hQNUr+T8FeBVTvA5ugAQsgF05EfQYpswAJGlEBqDZu6m6ZWAIEmMbTuqI4UoKQoQbWdUy1KWhuccyroLgWrZW1ut39XF8NwvpUzvCXfGu2ujXeL/eg80dApKvpKerNZnZr8lL8mepb9imDT4ESOytZulG0harqsg22rz7VWOpd2TlKxHh4TZ+5ZhFcLJlxFuejjWRbtMktO1lnUuryVHDdiehAKdHng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5siYlwWyELY6BG33Tpz4BSzEQuez2/P+fP+4AlO1QhE=;
 b=FBCVi910rUeaFltcU9Q8c5J0S1FdzJ0fimZHCB3TJb/AeiL/+lbaj+E+U0Vx8zu9/JqqrMSb9o3wDhWSzhodDug7KLfDULpWOZBTHAsh0GvAIyZY0NgeGGc7nDUDvLlw7U/PYYE6Ahw9D+0TUQLhZ8VtjpJkpci3dTlw24iibIA=
Received: from CY5PR18CA0046.namprd18.prod.outlook.com (2603:10b6:930:13::8)
 by SJ5PPF25BED9404.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::794) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 15:19:44 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:13:cafe::d8) by CY5PR18CA0046.outlook.office365.com
 (2603:10b6:930:13::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.10 via Frontend Transport; Thu,
 4 Dec 2025 15:19:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Thu, 4 Dec 2025 15:19:42 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Dec
 2025 09:19:40 -0600
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Dec
 2025 09:19:40 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 4 Dec 2025 09:19:40 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B4FJbSb1744730;
 Thu, 4 Dec 2025 09:19:38 -0600
Message-ID: <c3416918-965e-44c9-b202-ab9703806ad2@ti.com>
Date: Thu, 4 Dec 2025 20:49:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: board: ti: Add J742S2 support
To: Tom Rini <trini@konsulko.com>
CC: <nm@ti.com>, <u-boot@lists.denx.de>, <mkorpershoek@kernel.org>,
 <n-francis@ti.com>, <anshuld@ti.com>, <u-kumar1@ti.com>
References: <20251204142451.834404-1-u-kumar1@ti.com>
 <20251204144840.GX303283@bill-the-cat>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251204144840.GX303283@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|SJ5PPF25BED9404:EE_
X-MS-Office365-Filtering-Correlation-Id: 74f8be56-8b81-4ed8-4357-08de33488cd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SXlwQVhjZGtURHNBL1Z2YUVDVURPRGpRdW1Zdkp1K2dKNnZYUU9OekVUNWJO?=
 =?utf-8?B?UjEyOTAxaTNnK1JvcUhWM3B2WTk0Rm52Z0JLRnlZaU4vdklWTVlWMGViUDI5?=
 =?utf-8?B?MXk0bDlJdmxxSnVHMXpUa2ZZbFRQOG1RTFI1MjNrc0NlN1daTTFaaXZ6QlNL?=
 =?utf-8?B?eW9OdVZTZEJlUDFxWlhxdERDS3M1S1N4dnNqTU04Y3FwZHoxcVJ3Y205bldk?=
 =?utf-8?B?NW5nRWZRZStEQlU5Qkwxblc3Q3JzOFVjUEF0V2NpRXFTRTRrdmR4NUpGRFdi?=
 =?utf-8?B?ajVHTm5saGZEQTlweE1TZXdYb1k3QkI3cy93TFRrL3VHdTFya1c4RkR0VTF0?=
 =?utf-8?B?SXpML1FkVUZBTG9vcDRTRHVFRjdYUXNvSEtwcUNCYnI1YUIwS0EveTJrbmpI?=
 =?utf-8?B?djQwamI1WTRhbG11K0ZTWUhJOVNKZWR5UlRxUVhSeXl0UWZZM0p3a2NEY3lG?=
 =?utf-8?B?Y3puYmticit0OXRvejR1dkd0MDZMejd4ZGYvZUNxdXRTdlhwZWh6R1FQcG0v?=
 =?utf-8?B?STRsd0grVHNDWjMwbi8wYUxmSEhCSzB0ZFpicVZxSk0zY1VHcDlEVWYvWVdx?=
 =?utf-8?B?L0VEcGZOVTZPenBjV1cwV0hIOU1BUDUyL1hrdTFtOC9zOGtHdlgvOUo4Y1Nu?=
 =?utf-8?B?VVI3anVWT0tkMmthcERyUXlQdnJTTHgwUDM1YzI5bFpCWC9XQUJjUGJHalVy?=
 =?utf-8?B?bC9BdWZIZjJhdmtWSjk2UTlhMm1UaVViWnh5UWM0VVFZZ2ppZ1dzSURtejZZ?=
 =?utf-8?B?azBpZDJyOU5WNWQ1cElmdzFGMDhPN29FWTBuS0U0L1Q3NDUwL2tsMGRHSWhq?=
 =?utf-8?B?OGdKclhnalA1QnhJVXZQKzliL1AwY0VNOUxUdXV1Z1p2NVArSUFsN0xHdytU?=
 =?utf-8?B?SzdieDVjcDA2eGVJNjJ1RXRwMkRnbU14STVTNVRVYmhkckVsMnFSU1BPK2Uz?=
 =?utf-8?B?ZjJCRnNLNzNlYVpYT2tBZUNGVHhad2s0RWxsZjVMVG5QeEJSNHlRVUk2N294?=
 =?utf-8?B?Y1dVZTVmNkJTZzJvajg4YkhsVzJWekpPNmJZV0dkRnFoRlR4VGV1bTFRTzlO?=
 =?utf-8?B?NzgrdEVORlBYQWZCaUVJY1ZxS1FXMy9vbkNVSWZ3ZkhDRzNTNlBTNnBkaXQ5?=
 =?utf-8?B?dHNMSUNEcS9WaE5RSXdrdEVDd09qc0J3SUkwd3k5dXRtSTNCbG9ObzdxdTUr?=
 =?utf-8?B?SzVENXlUdHVZTUk5VEo0Y0ZKRlhjVEVRaVR3UzA4RXZpTUkyQkFnTFB0Q0Vj?=
 =?utf-8?B?N2l5U3ZrdnRqZXlQaG5HQURLMU1nYUUzNWtvbDJjQXVvVFNyUkExT3F6dGY3?=
 =?utf-8?B?NzQ0R1E3ZG1LenZldzA0UTdzTEJ5dlRPZGNSYXNzTmhHWDd6YzhlVVlNRXhx?=
 =?utf-8?B?OFVQNGdNMnBvSXh2RFFjN0YrQ3FCaG91U2VudWpMbFpFZDU4dEdCazdKOHYv?=
 =?utf-8?B?Rkl1cDNmc0JZZjEreWNTTm9yZWZxUU1Qa01yMEc0am9XNnVKZXdDREtRMVhE?=
 =?utf-8?B?UDJuZ3dBdXBiWEgvaFp3bnIyMWcxK3pzeG1sLzErdlRISHhYaDQ3TW5VUEcy?=
 =?utf-8?B?MlhJcGFDSWl3cDFnTE9GcUFoTFhCN2RZZmUvMzB2NFFkSDhsK25Ucm1EL0F1?=
 =?utf-8?B?RDVRVHNSeGJqbVNjQ21TSGh3dWRRQlI4UHFqbTgzS092cjljVVo1VEdYd2Jt?=
 =?utf-8?B?SmQzNkJSSmh0Vk9oaWU5L3dQaWJRSnZuS3lZRGhOOGV3NW5pYjdJQmRWUXZV?=
 =?utf-8?B?QlhjMFhtOU03ek1nZXE3NEFRT1BBMnk0ZWhxVGFTb3kwOUZRNERYQWJRU2dD?=
 =?utf-8?B?SEZva2tOaENLYWlRdkVJOFNtcEVYOHEwK05YWkx1UzRNVG02S0FvelIrYUVj?=
 =?utf-8?B?RWJtSU8vb0YwMkNLVUFBQWJlWFBRekJDS1lqRWtGQnZKejl3NWZhb2p2Skc3?=
 =?utf-8?B?ZGFaUzNReUQ1YTZwNHBQNEkwN3pqZWRqck9uTWpVYnRwQkRidERlbUdEdFlk?=
 =?utf-8?Q?ndSBV+R5chDPasXZTCMsa6hkHTeayk=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 15:19:42.5679 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74f8be56-8b81-4ed8-4357-08de33488cd1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF25BED9404
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

Hi Tom

On 12/4/2025 8:18 PM, Tom Rini wrote:
> On Thu, Dec 04, 2025 at 07:54:51PM +0530, Udit Kumar wrote:
>> J742S2 SOC is derivative of J784S4, most of build infra of j784s4 is used
>> to build u-boot for J742S2 EVM board.
>>
>> Add guide users on how to build for that board.
>>
>> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
>> ---
>>   doc/board/ti/j784s4_evm.rst | 24 ++++++++++++++++++++++--
>>   1 file changed, 22 insertions(+), 2 deletions(-)
>>
>> diff --git a/doc/board/ti/j784s4_evm.rst b/doc/board/ti/j784s4_evm.rst
>> index 22442874110..4162a42c075 100644
>> --- a/doc/board/ti/j784s4_evm.rst
>> +++ b/doc/board/ti/j784s4_evm.rst
>> @@ -1,8 +1,8 @@
>>   .. SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
>>   .. sectionauthor:: Apurva Nandan <a-nandan@ti.com>
>>   
>> -J784S4 and AM69 Platforms
>> -=========================
>> +J742S2, J784S4 and AM69 Platforms
>> +==================================
> This is too many '=' and now CI doc building will fail with a warning.
> Please build doc changes with:
>            make htmldocs KDOC_WERROR=1


When I checked locally, I haven't encountered any error

https://gist.github.com/uditkumarti/94780fe8ec2bb4b55c46b1ab4afc7e7d

Anyway, I will send v2 by removing one extra =


> To ensure CI passes. Everything else looks fine, thanks.
>
