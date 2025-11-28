Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E38FCFD376
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 11:35:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EAA784540;
	Fri, 28 Nov 2025 12:35:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="X8/JDRhH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 098828453E; Fri, 28 Nov 2025 12:35:56 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACB5E8453E
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 12:35:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DOGy21xI96IRM49lHgWRyN6rJAcI+04XIdNEvP3hF2QhF1yYjphIrLTEJvUaRZy6EKW3kPyRKkHqeKbQxrSwvsVovAApfIkjzdgDccw1/qSL+zyaTYqXSjCMPK6x1SFArQfs2PR6UadTVXWlItJ5QPaU2vLFagkkYraykbHMxC8ooYoxhcQOkr3Td2gjNFuaaNrfWONXqiqQrGFjjdbHLghUcaGUqNz0iyGJlHOh2EI7Q1ctTWZeoZEu+QZxaWaBmWnfMypFGftrGc7RprdwZRUaYY+xKLT4lfuAE3+eij0p+PPLiY4H0AYgOUu+vnkh6viBysgrEfZOoclgL+VSOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ri6kd05qBwnuPZYFZnyEJknSP4nQgRGdzwBvzxlWKyI=;
 b=UIi1ofZV+hNI/dQ2hkMucyhjsMl6rMZE8c4itli928dztPaDOgkOz7zIq4QLbgesvz67RbjRF7jBSG87jj8MuZ24io5k1HSxQOwMczHLuAEPtk7QMmjHMd3E3oPlRmuKAj/BhChnWzs4qyAq1zBBVtZq1CnxU1pIaZcKD4H+joVDCXzwDS9AVw8WuSERjwk2gI9q8QNZ1mMP6a8ceARwUALnFiCzV6NCifRtsrsdSPtvUbijWBQoUQJFOTWoczKJSFZUsVnSixpddzALuefPLay/I2HG3oYJvZG412mAnat/DMTyZ52ImZVwBtHrrF0wGqZovh5FBk6+3EHT8lLJ2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ri6kd05qBwnuPZYFZnyEJknSP4nQgRGdzwBvzxlWKyI=;
 b=X8/JDRhHTwyykzGMWMMfVL1v+qfqlJUOGHHGFLZGJrUJkZFnYRfSX5+nsKEXXS8N5P6ZSgtDikL75kGsT/6FUvxQbSih++Oo6Au+vhu5kHcDWA9/ShV72whx8jtQzdPFWM2Pz79mr7LA9SKBpGeay3v+yoov2CaQUwGQJ94+xTY=
Received: from SJ0PR13CA0038.namprd13.prod.outlook.com (2603:10b6:a03:2c2::13)
 by MW4PR10MB6321.namprd10.prod.outlook.com (2603:10b6:303:1e1::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.16; Fri, 28 Nov
 2025 11:35:51 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::95) by SJ0PR13CA0038.outlook.office365.com
 (2603:10b6:a03:2c2::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.4 via Frontend Transport; Fri,
 28 Nov 2025 11:35:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Fri, 28 Nov 2025 11:35:50 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 28 Nov
 2025 05:35:46 -0600
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 28 Nov
 2025 05:35:46 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 28 Nov 2025 05:35:46 -0600
Received: from [172.24.231.164] (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.231.164])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ASBZik7264868;
 Fri, 28 Nov 2025 05:35:45 -0600
Message-ID: <f23f1568-fc01-4a39-acc9-5e99ccab9876@ti.com>
Date: Fri, 28 Nov 2025 17:05:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: mach-k3: j722s: Update SoC auto-gen data
From: Chintan Vankar <c-vankar@ti.com>
To: Michael Walle <mwalle@kernel.org>, Tom Rini <trini@konsulko.com>
CC: <u-kumar1@ti.com>, <vigneshr@ti.com>, <u-boot@lists.denx.de>
References: <20251125094639.1754402-1-c-vankar@ti.com>
 <DEHU1N85F4DN.3W3VX01XHQTCH@kernel.org>
 <4c468d40-4d4c-4acf-a758-5b9b88963b90@ti.com>
Content-Language: en-US
In-Reply-To: <4c468d40-4d4c-4acf-a758-5b9b88963b90@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|MW4PR10MB6321:EE_
X-MS-Office365-Filtering-Correlation-Id: 23d1c2ed-1385-4272-5678-08de2e72485c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eHpZNFNxQXZZTTZvYmJjbkt2UDl1R1FOMjR4aG8zNXFhalVwSHJ1L3pGYVNU?=
 =?utf-8?B?NWFub2ZMZjg0T3NkUVZ1UWZTMGEvckRHV3M5TWJIbG16ajhpTHh0NUJacGpH?=
 =?utf-8?B?ZWt4dldxZ0l0VFYybzhydUpCNFlqaHlkWXQzRHFPYlZxcDZKRWZSbUliSUdn?=
 =?utf-8?B?SzF1cXR2aWxaMWdVVHVyenR3YUlGVDZGbDdLZ0gxS01MN2dzNkdsb2c3RWVZ?=
 =?utf-8?B?SThRM1NUR3p3MU1oUnJsWDBWSzljTnhnVE9sY2NmUkdNZkhPQzl6ckdZL0JS?=
 =?utf-8?B?UHRHc2twdXQrak9XU1FKQnRNK0czOTl5aDRyWHlOcTcyUlpwZTJWMG1BQ0RJ?=
 =?utf-8?B?WDlFNE82SnFFV2xuTFR3dy9ockNmL0ZWWnZxOEpDT2tiZWFyd2dlWkcvYVBK?=
 =?utf-8?B?a3MzK1hUS1hrbzFqOVB5TmVWeG0wSXJUdks0d1Jna0dPT0phd1dkRjc1bDF0?=
 =?utf-8?B?QXJJYmJSQXB2Y0dzWkJBL2d2czBRY2ZLaFZIZnB6SGsyZ2IrNFNzM0NtbmhD?=
 =?utf-8?B?ZWJkTjlIREprbTBkemZaa3FYeXoyZjlzMCtHZk9xUGZnOVpoZEhjWkh2bGN2?=
 =?utf-8?B?QjRnOThGWHlvaVFwYkJUVmVibGhVQWNLa2Q2S3crRFQ2T0p6b1JOZk1BVG9N?=
 =?utf-8?B?RzJ3UGxMbHFZeXhTWVlOVW51M1hNTzhReUNSdWNVRDZlUEg3QklQcGF2M0JL?=
 =?utf-8?B?MFcxVjhseFhJcmdzbHF6M1ZFWm9rdEFmc2V4Mmdia0U5THFCaHdhOFpvc2I3?=
 =?utf-8?B?bEZZRkRPWGR5ZURoTjVjeGlXRlRGMEFBTlVyQXBBMEx2UGFuSndESDl6bENY?=
 =?utf-8?B?RmE2bVJpTXdGUXd2YVJvOFpXLzhmZ0dTK3N1bUJYYkcvMGJwVUNFdFlFUVFO?=
 =?utf-8?B?RmxxZjYwWFc2NGZvMUJOdURwSi96UG4wZUVzeE4vMWw5RDhFWXhBUjdxTmM2?=
 =?utf-8?B?Ri9XWDkvQ3hEV3BrYlF6UWZvRUVkNkROTTNCWFBVVDMySVBzKzNpZWNMSzVo?=
 =?utf-8?B?a1drcEZQOEhseHhMemlZZzJpMGJxUk9XUVpQdTV2emZ1RkpEVnJTTVo1YkNm?=
 =?utf-8?B?QkFPaENIV0JjU1BFcnZSUUpLbkdiYnRIdG9vekVGWDZ1d1o3WmkwL1ZUeXFH?=
 =?utf-8?B?QXZlMFc4ZktBdnZtOFFQOWZBMitmV3U3SGtEYkNnbU9xanM2cVErUzIxejlt?=
 =?utf-8?B?YWdRd0lKZ0RGbHE5OU1rTlVHV3E3eUpRT3QxR3g5SWx2L3p1UkpjZEtGZFFI?=
 =?utf-8?B?bVBxME9EWEM1Wm5iYjVVSHdKTXBkbWEvVmxoVkZPbHEvenlmZ1MrWlNoUkNQ?=
 =?utf-8?B?b1ZWalJLUmhQUjY0V00vQ2VPVkY3dDVpTTkyaGZhVHlaSHpGQUxuMlViMzBJ?=
 =?utf-8?B?czlEd3YxbEtzRm9Wamp2aFBoNVlKQmxkUGRNUEU1MGszb0FnemtQaXpKR0hZ?=
 =?utf-8?B?S2JOTmMwa0lmdGcrUDBCN2x5dHhmM2VFajdYcDRhYTl6OXNBTEQ1S2Jlb3U2?=
 =?utf-8?B?OXd6TXhWSy9DUkRFOGNEeUNuYksvSzFIdHZmVHFyVUxad1o2SUlnYjB3clMy?=
 =?utf-8?B?WkZ2TWFBaTBUblJrVUdIdm1Rd3JiZHhaZ0dkTGZNdlZjbmFwY0FTb0VSSzBm?=
 =?utf-8?B?SXB5V0ZucVR3YXVwTHhvcGxZRnNCbmRkWmJTRGNLWFllQUtCTEY4UnlXTFph?=
 =?utf-8?B?QW9Zclp4QjUrWE5Bek9teE5ISHhBbFdxVWRKMHBqRFlKNVNhVUhSeGhkSG94?=
 =?utf-8?B?ckpHR0JCbTdSM0NtRnFsRWZ2SWFhckNDNjZ4VEQvMUgzSzlsakRONW14ME1X?=
 =?utf-8?B?TU5hVFlPS0FuSk5ZY3luZXB5R2ZxMWNGVFFYSXVzMHRtUkFGcU1KM2lnK1JR?=
 =?utf-8?B?NUZTU0FpYUU3d3JqVGxoL2hvT1F3S2RMVno5aVg0eGtDQjcwUlZoVEwvM1Rt?=
 =?utf-8?B?c1ZkREpMZmRUUjBRWWd1eFNHTHovNkg2RXZJZlZraXdhRXFuMFZxWGhxZG9k?=
 =?utf-8?B?VzI2ekVvK1MzU1h0UTFKdW5HOVRpZjY2Nko1SHVrUC9uZTRVQkNDdklBU25t?=
 =?utf-8?B?eEJsZDdna1BoNXowOVpxeVJRcXozYXJaOGtJZmJ2NHg3NkFucjhwbGVTWHJy?=
 =?utf-8?Q?o6ek=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 11:35:50.7328 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d1c2ed-1385-4272-5678-08de2e72485c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6321
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

Hello Michael,

On 27/11/25 00:53, Chintan Vankar wrote:
> Hello Michael,
> 
> On 25/11/25 19:37, Michael Walle wrote:
>> On Tue Nov 25, 2025 at 10:46 AM CET, Chintan Vankar wrote:
>>> Update dev-data and clk-data to fix the eMMC boot for J722s-EVM.
>>
>> Isn't there any more information? Why was it dropped in the previous
>> commit?
>>
> 
> It was not dropped on purpose, I was enabling CPSW device and
> unknowingly I removed device id 57.
> 
>>
>>> Fixes: a02009f3a816 ("arm: mach-k3: j722s: Update SoC autogenerated 
>>> data to enable Ethernet boot")
>>> Reported-by: Michael Walle <mwalle@kernel.org>
>>> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
>>> ---
>>>
>>> This patch is based on commit "4a4871e3dc38" of origin/next branch of
>>> u-boot.
>>
>> This shall go into origin/master, no? The issue is present in the
>> v2026.01-rcN.
>>
> 

I saw that the patch is already on top of the origin/master branch with
tag "v2026.01-rc3". Can you please add "Acked-By" to unblock it for a
maintainer to get it merged?

Regards,
Chintan.

> Ack, I will rebased onto origin/master and resend.
> 
>> That being said,
>> Tested-by: Michael Walle <mwalle@kernel.org>
>>
> 
> Thank you.
> 
> 
> Regards,
> Chintan.
> 
>> Thanks,
>> -michael
> 

