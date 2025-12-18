Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 293B4D6D22C
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 14:42:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43CB083DEE;
	Thu, 18 Dec 2025 15:42:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BaPbsAGU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD4C583E0E; Thu, 18 Dec 2025 15:42:11 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E99D183D8A
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 15:42:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WS5plwk96Asxs0rgrrCBhFOhUn6Q2tHwp0AIhrwV5RQREV9d8vXI9VRQJaxG5PyWLG+Q04ixkobNT8aocezoi30ZHvQD8UEeuUdP/PV3+VCmpKdzW2qfFgQpJqBkisM5wlgdWU1+gdTB8vwwPGqdNW4T9Btdbd7ewzPqot/VlU6uO/LSlgRD5R4KPfuEMbQBq/GvioSybqUb6eYCZLRsf1jeON/dCEeCYXbQrFY8mkuQZedCmxDlG59OO1sfvgRHDOAh/luOSmwYDdXLV2epZtkQ9tnAOEKlVyNhWfnwCuiFjt7ZBNr7mqwsO8TPSBoW7crH7tY2bcYzoR0LUkTezg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBdohLKd/M3cV3pvja44WTtigre57TCnfVlLVOCJ9oE=;
 b=urxVxWQEO296oUjnK5bA3Xf45XG8JFToOdL9zIo6BwHac6DMksm4uDUYE1V8B82oRbC6t5kCyQcKA6Hp6lBmqN2wuMVrFGHzPlEgu16AV6X01FJH5x2yLyVBR+th88h/iZ91shTJ0mRj0Iom5/PF8XhP7JHqMOtcDolOeKuxN2mg1JxfH1izrqOs6E5UbcqgP9uyu0cLd7uZl22F60bhBjFE2ffZ2NQ2VLs37CehvxlxUWnFIfwQYWhhr5GwtDqLGO6wtGvP0M5ra7NOx1xtGxWr+twS/mBkf899l6W28OUNjvqM1rh1V64iOpcXIqUU1qBtz0uUq3GEXE1oJuXRPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=dh-electronics.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBdohLKd/M3cV3pvja44WTtigre57TCnfVlLVOCJ9oE=;
 b=BaPbsAGU04Vg7qPIbkFL3wcPtaNjbZq65hEvXy0ZYpML2AVIK0IA5BXn/m0tfW0CZVJjOQGoSgko7wgX/Hs5zKvytuUZ9AOlCxbL5eYVJfV2WwfiRbxjx6GonZssch1UZxf6e6bytRZHGxJokdIn3kDiz+fF7iPT3t7dsPVdNAI=
Received: from SJ0PR13CA0141.namprd13.prod.outlook.com (2603:10b6:a03:2c6::26)
 by LV3PR10MB7964.namprd10.prod.outlook.com (2603:10b6:408:215::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 14:42:02 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::b2) by SJ0PR13CA0141.outlook.office365.com
 (2603:10b6:a03:2c6::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.5 via Frontend Transport; Thu,
 18 Dec 2025 14:41:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Thu, 18 Dec 2025 14:42:01 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 18 Dec
 2025 08:41:58 -0600
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 18 Dec
 2025 08:41:58 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 18 Dec 2025 08:41:58 -0600
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BIEfwxq3515821;
 Thu, 18 Dec 2025 08:41:58 -0600
Message-ID: <210ecc7f-4de4-40e8-8c15-5a6231df48a4@ti.com>
Date: Thu, 18 Dec 2025 08:41:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next v3] Kconfig: select
 SPL_USE_TINY_PRINTF_POINTER_SUPPORT for K3
To: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>
CC: <u-boot@lists.denx.de>, Judith Mendez <jm@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Hrushikesh Salunke <h-salunke@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Vignesh R <vigneshr@ti.com>, Christoph Niedermaier
 <cniedermaier@dh-electronics.com>
References: <20251204-am65_dfu_fix-v3-1-de18ed3f346d@ti.com>
 <DEZHV1ELFZ43.E3FN619R0UNY@ti.com> <20251216140104.GU303283@bill-the-cat>
 <DF08W9D84X84.1DQ1VM5S8TT9D@ti.com> <20251218141653.GI303283@bill-the-cat>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20251218141653.GI303283@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|LV3PR10MB7964:EE_
X-MS-Office365-Filtering-Correlation-Id: eb246f0d-6301-49bb-630f-08de3e439ad1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eFQ1SDRUTlN3aDZtWXM5cThFcUxNdHRvbkF1dURDNXNOeWo2K3p2QlZlSzJt?=
 =?utf-8?B?aWk0QXJORlB6T3UyODdjQWU0VGd2T0dBZ2tRZmUxZDNwNFEzNXJIZEVucFdj?=
 =?utf-8?B?NlZnLzFvbmxILzZSL0I3MlVHalBnWjdlUEZCUVYrVW9RVWdkMEp5SXFaY0Rv?=
 =?utf-8?B?N1VlR3l3WnB1em1oUXpSbVM3a3ZhRFR1dUhVWmc4azlrZWgvdGs4VklJNUZF?=
 =?utf-8?B?eW5URVlsSXVtWGdKRTZBUDNpd1QrRy82TDJUSmdwVjl1Q3h0amowWCtGUG4z?=
 =?utf-8?B?cHA2ZUtzeXRBekN2a1p5Yno2TXNwMHVCNnNzTnBCTWF1VWVXZm53WnRJeERV?=
 =?utf-8?B?WTNZNXhDV2dXTzZaSk9qOWlzajVXMGdBWjIvNGEwaDFyZmJSRHZpK3NQZ21R?=
 =?utf-8?B?TTRKNEpTL20vamdreUlKaTU5aVFrM09QTkhncWF0K1hQWjZEWXJ1elY4Slcx?=
 =?utf-8?B?c2xYRmcyL2w5N3MyTnNHYVhScHpvQldoTFBpTHFYTlBPZ0dQWDBvK0MyU1lX?=
 =?utf-8?B?bFRiVEFBZVIxRWw0NE5HR1k1a0xuaVdIa1lZRmNvVVp2bmFNUzIzK1l4d1B4?=
 =?utf-8?B?c2hHWlY4dStucVZRUlJIN3c2VG9xM1VPb3NRQTRYNVRwUG05MkRPanhtRm5Q?=
 =?utf-8?B?NGx4WCtVVThuUWN2NFQ5anRwNThlb0Irc2lIbTk2N1Fra0U2V0lkTFpKMjAw?=
 =?utf-8?B?dUZXbkhNTlZ1UTU3YUNURVBPckw0TW9rZDdKTUF4aGtWRHI0bXBJNUpabnJx?=
 =?utf-8?B?akZvYlNWTWt6VE15bE9KUUFBODlqYWo4bldUWU5UZEoyRE1jR3VKQmNoZ2VW?=
 =?utf-8?B?dkZHd2NSYW1nY3NZY2t6dnJQcUxTZXRFZzJPTFVyTC9HOXFEZjVON1RLTzVn?=
 =?utf-8?B?SEk1TG5UVHVwcno3MXlUcDkvQUlZc3hmZU1uUWhkNzQzVWNWZTlQbVAxR21w?=
 =?utf-8?B?UTZoYjh5N0RDRm1VMVlIbWFIN2FobjZCUkpERUFlOGxoYVBNNlFVL3ArWkxW?=
 =?utf-8?B?MS84Qk93Q3VLaDhIYTlIejhrRktWQlk5cnBVb2JiVVFIRG9DcnU1UExxOElk?=
 =?utf-8?B?S2NuRUIzSU1UR2VPZjZGdUNXNkl5MmJUR2pONlNHTzdlWlEyOVFseVJRcWE4?=
 =?utf-8?B?TWt1RUk2a1h4c1ZHeXMxOVJraGFja2ZnNHhKbkJnZmlHSVBMaVkvNG9tbkFu?=
 =?utf-8?B?OWhOZGZ2a0xzWlIwYjhPcTUyb01yRWlHWjJoZ1BBSzlvR3lhUCt6Mmk2aXhN?=
 =?utf-8?B?RUJ5RExlZGNsRmw4MUFBRDBtWGhJN3BkTnd0Nmo1M3ErazBoYVRTcUpSakhp?=
 =?utf-8?B?ODh1Vy8ycm5BbUNMUXN1MXJCNWNSUThrUXEvNVhOSWJjK082WEtLUU1sb3hj?=
 =?utf-8?B?bXpTUmJQemxiR2hsaW94TDBWSmNJSnNrZmIxMkdldjFmaVQxb3E4QlBYTGdN?=
 =?utf-8?B?a3Z0VytKTmFhY09XTkc1NmY0UHVZMG5lQlZWczdJVk8yTUxZSEZNUzZ0MFVv?=
 =?utf-8?B?TyswN2NUbE1hQjEyR3NmUDh5QTNxK1IrSklKMzdaQUJJRGpCc0w4a3h1SjJT?=
 =?utf-8?B?NVV2UUM2WjVMMFZ5OHA2U3ZXY1ZxdzJuWmxyNllxZng2d2NRUWdFbDYzT0Jv?=
 =?utf-8?B?WkpxS0NGUnFXbkdzMnBSOUFQMDYyODVGOW96S1k4UWhJQ043UTU3MnZOZnJ4?=
 =?utf-8?B?ZHVpeXpMdlk1cS81VU1JTnZNMmVjUVJrdHdjYXhsS0tnQTNjMFhSbm5PaGlC?=
 =?utf-8?B?UUdxVUx2dUtVQjByMmpSNlVKSmh1YUVuWkpBcVRqVXk2eVcrSWJ0VS9HRXVr?=
 =?utf-8?B?SGFjYktEK1AvU2p3UGZKVDQ3WkpUMjVxQTRVNjFManJ0VGZMSGZlVHhMaklr?=
 =?utf-8?B?dys2azZiRWNUbHFBc09aYU92dXdVdHh3WTJCS1FpTTZNeDlJWVJUNVFtWnBK?=
 =?utf-8?B?eC9xTEJxcWlZTjdMSmhFcXovKzRpeGRycnVNR24rdldnNFlXNzdaUkhoYyti?=
 =?utf-8?B?YlJkWUxOY0xxMS9pWldGb04xNDE5aDY0akdNNlp2ZDV0Y3hrVy9tWTFGRmVC?=
 =?utf-8?B?ZGlHNU9DVXdqbVQ5YjJzQVZDUWNudTNnWUxzcmpmYXBCcWY3KzN0VVVKcENt?=
 =?utf-8?Q?f910=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 14:42:01.3579 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb246f0d-6301-49bb-630f-08de3e439ad1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7964
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

On 12/18/25 8:16 AM, Tom Rini wrote:
> On Wed, Dec 17, 2025 at 11:03:43AM +0530, Anshul Dalal wrote:
>> On Tue Dec 16, 2025 at 7:31 PM IST, Tom Rini wrote:
>>> On Tue, Dec 16, 2025 at 01:52:37PM +0530, Anshul Dalal wrote:
>>>> Hi all,
>>>>
>>>> Any updates on this patch? If possible could we pull this fix into
>>>> master as well for the 2026.01 release?
>>>
>>> I thought the feedback was that this was a generic problem and so the
>>> Kconfig logic should be universal, or there was an incorrectly /
>>> sub-optimally handled case in the tiny printf code, that needs fixing.
>>
>> We have a few ways to go about fixing this:
>>
>> 1. Fix the commit 1e24e84db41a ("tiny-printf: Handle formatting of %p
>>     with an extra Kconfig"):
>>
>>     Pointer formatting used to fall back to %x handling before the
>>     commit. Though going by the commit description, it looks like the
>>     change was intended. So, I'm unsure if we should re-introduce the
>>     confusing handling back where %p is handled but not %pa or %pap.
>>
>> 2. Add SPL_USE_TINY_PRINTF_POINTER_SUPPORT per defconfig:
>>
>>     This was what v2 of the series were attempting to do but as Andrew
>>     pointed out, there might be other platforms with similar issues and
>>     it would be better to fix it for K3 overall.
>>
>> 3. Change usage of %p in k3_sysfw_dfu_download to %x:
>>
>>     This is a suitable fix imo but we might still have to fix similar
>>     usages of %p in other places. We'd also have to be more careful when
>>     bringing proper U-Boot code to SPL since %p would not work the same
>>     way.
>>

For what it's worth my preference would be this one. We should just work
to avoid using %p in general outside of debug statements.

>> 4. Unconditionally select SPL_USE_TINY_PRINTF_POINTER_SUPPORT for K3:
>>
>>     This allows us to remedy the problems with above 3 solutions with
>>     very little overhead to the SPL size (<100 bytes).
>>

How about unconditionally select this for all platforms? If it is only
saving 100 bytes it shouldn't be an issue for most, then platforms that
have verified they do not need it (or need to save every last byte) can
then disable it. Seems odd to make a change like "1e24e84db41a" and not
have the default be the existing behavior.

>> If this problem is faced by non K3 platforms as well, perhaps it might
>> be better to take the hit and make SPL_USE_TINY_PRINTF_POINTER_SUPPORT
>> default y.
> 
> Ah, so now I understand the problem, with point 3. So yes, I think the
> right fix is to add "select SPL_USE_TINY_PRINTF_POINTER_SUPPORT if
> SPL_USE_TINY_PRINTF && DFU && CPU_V7R" under the ARCH_K3 symbol.
> 

Just the length and specificity of that conditional string is making
me think that is not the right solution. What happens when we find
the same issue for SPL DFU on ARM64, or in some other code not
related to DFU, etc..

Andrew
