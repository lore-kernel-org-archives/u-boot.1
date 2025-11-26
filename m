Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF05D10F40
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 13:04:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B03DD84248;
	Wed, 26 Nov 2025 14:04:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rPcLD+LZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A5468424E; Wed, 26 Nov 2025 14:04:30 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B770B84239
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 14:04:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u5944b7diM/gQcmrBa1Fa2yCJVyG6ZIJDpzYbdJ5oc+tgWw6TD2wTKHMwvSnxubVW+fLjJ+AhLOSVxaiBbszDUoEelKCIZQC33N0GttwB31C3cGpHna/UDgYcKQUgzbmyHsk35hVZEJrytQVadRD/QVZgOjba5OTzq7BcijwzA8R5b2dwz+ZrGUoYsxf98cGJph/jMzgryx6DXeXLPiCc6mKq1IN15t+lqo7hbF7r6j1COWhqmcIPDP8D8Xm2I7QVW7mkua+3gjgtSoyEO5Iih7LyK01Sn58O56+glL4vsR9O1j2lxQE/czKE72iP3hobb2V9YnY7Q2OVFh18GsU/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFLsBXMHgjWis7NU2Tsm6QHA29TpPdxh0xaxVzXd7xM=;
 b=AIVUl7YAdzi8u+a3B0P12A93nqDK5UOheTaqDg7s+KJane8CsjMxRxRv79V9vSH5etiF2ZFSpcOuYwyk1Z8jS9OmzvGIyXv24htAm5sfIxIJRM8g2dwL9f2L8hK3luXWTgH9R5UrLG/lI/EX4UcEnV4R587ICXIQsoJm4iWLGAdRPRdhbf4Esq+4lx+gwqDeDcad0dv9uC47H5Ajbbfh2rocpJ3Tzd0wQlpeg9hifBKf2zeZ/y5ec6przhRacQuFFbZokYZMDtgPCpypyIDKZhCbS7KARy+V2IZ978O1h8rjgLqbvpWIXlwJzkmsLZ+nV6LKrZ43kanXYgWMqxsdrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFLsBXMHgjWis7NU2Tsm6QHA29TpPdxh0xaxVzXd7xM=;
 b=rPcLD+LZtykQIF9NJO4KrZxlp7F6/Zrp3m0S/8n7ZEeeOBVdPeb8dOgUKutYiwMoJ+AxlEI+h2GRqD2FZTiA3vD+Ot2MkLnVXi33ek8xijJAWeUnVfHncG0k55H5PfWhq5hVhm3seWY5tvglOHnc198W2hfC1YHxggQHy5yz+4M=
Received: from MN2PR01CA0065.prod.exchangelabs.com (2603:10b6:208:23f::34) by
 CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.13; Wed, 26 Nov 2025 13:04:23 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:23f:cafe::22) by MN2PR01CA0065.outlook.office365.com
 (2603:10b6:208:23f::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Wed,
 26 Nov 2025 13:05:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 13:04:22 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 26 Nov
 2025 07:04:18 -0600
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 26 Nov
 2025 07:04:18 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 26 Nov 2025 07:04:18 -0600
Received: from [10.250.148.210] ([10.250.148.210])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AQD4E9D1284391;
 Wed, 26 Nov 2025 07:04:15 -0600
Message-ID: <4684aa54-db50-47de-a565-e529bde793d3@ti.com>
Date: Wed, 26 Nov 2025 18:34:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] common: spl: Enable Instruction cache after relocation in
 board_init_r
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>, Prasanth Mantena
 <p-mantena@ti.com>
CC: Tom Rini <trini@konsulko.com>, <sjg@chromium.org>,
 <alpernebiyasak@gmail.com>, <u-boot@lists.denx.de>, <vigneshr@ti.com>,
 <n-francis@ti.com>
References: <20250317064507.1702120-1-p-mantena@ti.com>
 <20250317151318.GR2640854@bill-the-cat>
 <20250325053420.4wuenxmlnqsojuyt@prasanth-server>
 <n57czo3z2lzyarh22y7oien3b6vgyum5lt5z7xe2p3rrcktxpp@qmdmk65aagng>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <n57czo3z2lzyarh22y7oien3b6vgyum5lt5z7xe2p3rrcktxpp@qmdmk65aagng>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|CH0PR10MB5113:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b27f6a2-477d-496a-f1bc-08de2cec51c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QjROUTJnS0FZWExxL0xrZkRVT05vWnc1YnY4dHFCclJSVVZPUGNQdVh2c0d2?=
 =?utf-8?B?OERaNm9NRjNtU0xxMUFtZjkzaFNLS2VUbGFodWJQTXVqdzlmVEs1eDdpYkZv?=
 =?utf-8?B?SElqYW8wQXhrait2Q0tobDZIdjVVMlB2anorUXNmT2VzeHhLRHJ0bDN2dXgw?=
 =?utf-8?B?L2R2R0dNbGlHQmdFMWpXdmk4WWdobHpuUC9veUtScWZEeDk1T2U3cUdkTXRY?=
 =?utf-8?B?UEovTWQ5RFV0Nmp1eGJzSFg4YStiV3Z4OWtJWWRhVlBmczFUeVNNdFRkZm9m?=
 =?utf-8?B?eUlOTTNabzdsUlBqYmhzdStZUWFaNXNMRmk2L1RBYkpwR2dEWlZrUHlwQjVG?=
 =?utf-8?B?Qm5aeFhEQ3N3eTVuTm1salp1enU2aHM4SnczTG5aMVB5L3ZUYzFWSTNjNEF1?=
 =?utf-8?B?bnJyeE13QUdXckZpMlhWQmVJTURKZVdPZk96RloyQWdCZW52anVEZW03NmNH?=
 =?utf-8?B?YklINU5ibHR1MmNoZkRLa1pMbWdBS2FCMExBcnYzL0hoM3hxdHA4WVg2UVMr?=
 =?utf-8?B?VUtmc2FJMGNyMjZHdU15Ry95ai9SZWFRK0R1ejA4a3UySHllNnp2bHY1dlcx?=
 =?utf-8?B?MjVPZlNVbGdKak4wb0V1eTI0QVR6ZFNFWGlVd253ckprVkhIRi9qdjNEK0E5?=
 =?utf-8?B?dEd3TGFib1J6bkQwTFUrdjJrVWZsODBLbFhnY2RTcWlwbG5RcDB6N09QOTRH?=
 =?utf-8?B?aXdwbEJ0ck5lVkRVUGQwRk9SdlcyVTd5SFd1K3NKdjJTU2xUUnh6UVVtc3ZD?=
 =?utf-8?B?QWhmTjE1Q0w2emxoNFdmYTBZWXZTS2ZkcjBzd01sRXNRMGRTb0hqeFZDelVI?=
 =?utf-8?B?clRJNVBFMjNwMUJTMXd0NGVsSStQKzZiSzFCMW9OODgxRHNjYTdld0Q3TWR0?=
 =?utf-8?B?Tm1qUzhrRWo5U2N5SndDSFZQT2pYOGFhSzNQak9tR05ody91elA5WVpBaE1l?=
 =?utf-8?B?MmZuZ0tQbXQ1blVUWVpVWXhwVzhoVXY3bWErQ2twQVltWklqT29wcjIyMEJP?=
 =?utf-8?B?bkdRbjFkWm1IZ2p5enUveEN6bitXcFBNcGdsMVN1c0ZCU1loSlZmL0ZoUE5r?=
 =?utf-8?B?NGhsdFhjeDNoeEYyaktENURrY1FJYkU4TFJibmVFK0hBemdWbzY3ZFNiM29O?=
 =?utf-8?B?cjdzUXdLQ21aOGE4b1crRHExbDhoSUFBblF1NSttNXdRdmNrbUNyYXhpZjhj?=
 =?utf-8?B?K0NtR1EycmVhOUZDUi8zVUJ4QVBDYVAzMVk3VlU1cnpnL2EyZ2NpYjYzSDBQ?=
 =?utf-8?B?WXh6THQzWFh2WmRsYUp5R1BxT2NWRDVIUVNQZFk1YmNRQ0NjSzV6U1ZwakxN?=
 =?utf-8?B?bmpTUjJ3bjBOYllDL1F5MkdWbTFmMGNudzlLeUtYMWVCMFpXTXgyOEJIcmJq?=
 =?utf-8?B?YjRxNllEQ21IMjlkYStmSmh0U29uS1VBeGF2YnY3cWw4cnFMcEdNQW92dWVN?=
 =?utf-8?B?bktiNlZhWkN3M1ZzUzhySnlsVlZ0M3ZUVVVhZzdZVmMxTXBLUE9DaVN0Y0pR?=
 =?utf-8?B?dFpVVHJRNENIc3pkbnlDbFRPN3JCa2JnSldzNzJKS3c3VEF2MVVTK0t5bU9Q?=
 =?utf-8?B?cGs3ekx4YzY4Zks4NHJUU3VJeTZObUhwQ1FzZ1V0WUl4bzJBdllrRjNWMFNK?=
 =?utf-8?B?aEk3ek1DMUE1UGl4d2J6NThMTlJzV25OenNwSUp0ZXdFcGVwa2JVRW5Lazg1?=
 =?utf-8?B?TjcySW5sNEFtaDAyUXZEeTVEMGt1NVFuai9UZ3Q2bnNYQkVlMldabjMzWlgw?=
 =?utf-8?B?NWNQYjRKZTY3ODFPMmxPQ2ZVaUgwbExQTzlUNFR2ay9CMG9pbmh1NTBEa2ZH?=
 =?utf-8?B?US9EekdyaGhYSHBpVklFZ2JsTVcrT3BCL1p1U0Jld2ZRVkdhdWhaTll5YW5H?=
 =?utf-8?B?VTEvT1dtUjJqNTRoSWJrekxVZVFWdDBvR0NZdmRwVkNhN1lBOXdSMXY5MzJM?=
 =?utf-8?B?VnI2MmVQS3Q1Qklabkw1eldUM1BoVVNKaDhFd0E5ekNkeEY5SFh3eHBYYVB2?=
 =?utf-8?B?cXNlZm9LSlJxUG5zbVhRVDdYN3IyZ2c5V09keGZkK0N3RVVhWXNaTmtaTndo?=
 =?utf-8?B?RWpLZW90TXA4UVZjL1ozZ1NZWWRtamEyaVlkcHlwSGhGMmhybjd3Z2w3Q0hL?=
 =?utf-8?Q?gV1o=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 13:04:22.7647 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b27f6a2-477d-496a-f1bc-08de2cec51c2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5113
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


On 11/26/2025 5:04 PM, Ernest Van Hoecke wrote:
> On Tue, Mar 25, 2025 at 11:04:20AM +0530, Prasanth Mantena wrote:
>> On 09:13, Tom Rini wrote:
>>> On Mon, Mar 17, 2025 at 12:15:07PM +0530, Prasanth Babu Mantena wrote:
>>>
>>>> ICACHE is enabled in board_init_f which executes only before relocation.
>>>> Instruction cache invalidation is needed after relocation as well in the
>>>> common spl, which is taken care in the u-boot init_sequence, but missing
>>>> for the spl. So, enable it at the start of board_init_r for spl, which
>>>> invalidates icache needed after instruction relocation.
>>>>
>>>> Fixes: 52a86e69e20 ("arm: k3: Enable instruction cache for main domain SPL")
>>>> Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
>>>> ---
>>>>   arch/arm/mach-k3/common.c | 1 +
>>>>   common/spl/spl.c          | 1 +
>>>>   2 files changed, 2 insertions(+)
>>> What's missing from spl_enable_cache() in K3 already? And looking more
>>> at this, since Rockchip does this slightly differently I wonder if we
>>> need to think harder about making some of these hook points generic.
>> spl_enable_cache is getting called in the board_init_f and the
>> enable_cache here is getting called in the board_init_r, which is
>> basically doing the cache invalidate after the relocation. If this is
>> the case, I doubt, if we have to enable this directly in board_init_r
>> only, instead doing it in board_init_f.

I think, you just need to invalidate D-cache only


> Hi all,
>
> We have seen intermittent boot failures on the AM69, fixed by applying
> this patch. How can we fix this up to get it upstream? Thanks for your
> efforts here.
>
> Kind regards,
> Ernest

Thanks Ernest for reviving this patch ,

Changes in arch/arm/mach-k3/common.c seems good to me.

but common/spl/spl.c can not pushed in generic way, I can think of few 
platforms running SPL w/o caches on.

