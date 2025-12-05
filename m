Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B544FD2E01F
	for <u-boot@archiver.kernel.org>; Fri,  5 Dec 2025 07:32:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE23B84181;
	Fri,  5 Dec 2025 08:32:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="cXHhYwYJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AFF78418C; Fri,  5 Dec 2025 08:32:45 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C3598416E
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 08:32:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NvsyLegZVh7tI4xn0XkymlQ1rGlrNRbiqtz9syKzoouoE5rUFPHHXY+eU1hMwaFNmapluzhhG8SJd48mEmizzGAnmXsbwx40xAOOFba8tm61MxXxhbO+uvxOPnX3twZG91AEhvIylPBIN5i5rmCUVrSFe+FvydeqCNPk/84XADkwadMV0ME4MbvY7QPVFJ0H/J3kSxh0x4jaO9CVe0VyIuaENI9pfxIztJvMVPbA0VV3DyYsKFyIl5dUSkpAnPtdmLIfpsC70+oHQ5oXUXuU43oMvrVUYzFCY/qqSP66ISGAwKHVxsVoiFMG9OptjV5q9plB7BEC8ktZjEvyraIdyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6yi7moNUUsmSIe2CiWw720BMkFh4CIbZz5Cb8RqDfc=;
 b=KxWdDYcCEolCDf07gE0AQwwC41w68nXQ8vFXhSqxTyU4Eoa2rBP5FDeYBsq+Tyz4OnfGs8MfVADh3iiaJ/R7J8n+JKIyVZMAKk5jVbBubwd5+Bv+Lr5vtVFF2PbJPgcGr9XDO7rpU7khcR1a7F5mOFTUGmeis995+5yDhOZas1AlrHd3dWt9m2WopyUlRKs9l+uTFQNGw2bEGYjqSiME3bnirxdKSFFjFNL1E+ttr7Rbws0CLBA9X7ZgjMG739NMvK9KP9Ub4GXbib+qpARaX6BtVm9wt9xyE5f/w//AZ4xtvCK3aOci0n9tZk+B8lkhRX9aMJFWBoC785pfHYZ51w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6yi7moNUUsmSIe2CiWw720BMkFh4CIbZz5Cb8RqDfc=;
 b=cXHhYwYJVDVurn51qME9Lkh6oxvVijsm4E0U4tBCwL0aaqGZE2Dcqog+Czr2UeQVdsBW/aKb2YuI6z2CVr0kGuviDkTh1Nlt8IrbksVrGJhCOl1BQjp1GllvtztjUS3HmGhB8/0jGxD6MUapUg0f/KJCEbcPHIADrjOVjIrNd6c=
Received: from MN0P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::14)
 by LV8PR10MB7727.namprd10.prod.outlook.com (2603:10b6:408:1ed::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 07:32:33 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:208:52e:cafe::d8) by MN0P220CA0019.outlook.office365.com
 (2603:10b6:208:52e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.10 via Frontend Transport; Fri,
 5 Dec 2025 07:32:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 07:32:31 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 5 Dec
 2025 01:32:27 -0600
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 5 Dec
 2025 01:32:27 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 5 Dec 2025 01:32:27 -0600
Received: from [172.24.234.212] (uda0510294.dhcp.ti.com [172.24.234.212])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B57WP3d2921063;
 Fri, 5 Dec 2025 01:32:25 -0600
Message-ID: <0a4d1065-24ce-4806-9696-b300717a672f@ti.com>
Date: Fri, 5 Dec 2025 13:02:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] configs: am571x_hs_evm_defconfig: Reserve EMIF memory
 used by PPA
To: Andrew Davis <afd@ti.com>, <trini@konsulko.com>
CC: <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>, <u-boot@lists.denx.de>
References: <20251128150455.3279166-1-b-padhi@ti.com>
 <c5f858f8-0eb3-4ff0-bc7b-6286a43c93da@ti.com>
 <52e73f71-6c4d-4630-88f4-81de3fedaf83@ti.com>
 <1e980f3c-5955-47c1-81d4-f758dfa2d09c@ti.com>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <1e980f3c-5955-47c1-81d4-f758dfa2d09c@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|LV8PR10MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: 135fc6de-3423-4916-ad66-08de33d07379
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGlEaEhURXR4K1lmVWdJNUgrQTQ4L25zRmp1Y0VoSnVJQW02YkFQYnZkWUNO?=
 =?utf-8?B?SlNCQnlJL3duK1RrNmluanhBMWFMU2VKaXg4RjVydkdGSnI3azlaOVc5MWJs?=
 =?utf-8?B?aHAwRGdwWkNVcVZlOWF5eGxvSmwrRTgzenQvNnhDSmM3dTN2aU56aWNsb01m?=
 =?utf-8?B?ak9RczlNbWVSWElwT3l2cUtkS01kQm9KUmd6MVU1a1lPb0U1UkhURHQ2elFx?=
 =?utf-8?B?emYzR3AybWIvMWdRdDg1RGtFRjJYa3lMaDZKQzZkOGtDcVBaeU9ST011NjZD?=
 =?utf-8?B?WnQ3ZjJYMlowRDh5bm1zT0FDTUxWeTYzcStmL1ppbFlKWDJWLzk3TlZCNk9y?=
 =?utf-8?B?V3NBcVpucmx2WWpPd1JWWDFUNTlRSkNLNEVXUEZ1K0xuZnQ3eUFHRnpMK2Zq?=
 =?utf-8?B?dk1nQzdjeXd4ZlZrNis4dlRvTjJQSGRpTVByckZxbENKbUptdDJhYnZSQ3Va?=
 =?utf-8?B?dVRvRUFtRnRpUEpRdU1iUkZObG5KdEVuNW1yNm1uMGlrZDZOWHgzSWtLamR5?=
 =?utf-8?B?MFptWXJOSUZWWHZMR20yOXVWNUI4WHRlM2JrUUgwc2Z1N1dYTzRwdXZoeTNY?=
 =?utf-8?B?TExZVmVWVVpDaXVOcXMvMzdlMjg5L2dPOUlzUVQ0UEFWeklFaXAzaVhTMFJJ?=
 =?utf-8?B?b2lodGhJbjhvZ25aRkxhL3Z6SUdQckZHb3lockJQY0h3eEZGOE1sY0crYmlZ?=
 =?utf-8?B?bHpWVmJJZyswbGRPQllTRDJXN3o0RFJpUFlVdit0WHRRaUNNUFNHN0JzZUZQ?=
 =?utf-8?B?WXo4ZnQ0UHlPZGYyRlU2TjZTRkljbGY0Q2E1Sy9VZmJvRlFRQmd1RXA5akNG?=
 =?utf-8?B?WnEvMGJobzcwVmZOR1VKSVpCOEZTWlpEbjkwU3BkMHpDTGlLZEJBUWY4czZj?=
 =?utf-8?B?ZHB2V2ZiQkMrSGRNdzZYOGZ0RFQ0RWo3amJRZ2pLeFQ4YU9hT0l5dHpGTVo4?=
 =?utf-8?B?ZFBOejhxUzNJRnZ1S3prZHB6RitkRVY5KzZ4NlBEb2orc1NlR0VPK01zY1hK?=
 =?utf-8?B?MGxNY0ZWcjV6THVNSlNlUDNiZ2sxYzFJVTl5L0ROcjRrZ2Mxbk5nSU5sQWxV?=
 =?utf-8?B?T2I3bGtSaU1aUmFvck0zamFxMFVDd0JnZUZnQU9Qck15a0dLT0wyVndIMlQv?=
 =?utf-8?B?TDloVndiQmFOSW13aDYxWTM3VnpyNGZaZWZCZ3lCRGdVbnZnd0UvOVBQUzZt?=
 =?utf-8?B?VlhTbUVsZ2RhY2pFdnp4MXpKUU4rbmd1MDVtUWY5RnBUa0FPa2hybEo5L0tV?=
 =?utf-8?B?TVovUUxjaGJKMnlKMlpmaGk1c25abFdoY2ZSUm04Szdrd2tXQlhYbzVrTmxt?=
 =?utf-8?B?RkEyc1g0SGJJTWxIaVlyRXlhMzNybHFHKzJxdHZJWkhRMmVkVm9jOGR2SmpF?=
 =?utf-8?B?Wlg5Qy83ek9MTXZRbUN5NllpMzQvVDloQys1UjlwMCs0cnZIK2JQM3dkY2Nu?=
 =?utf-8?B?MEdGa1FuYW9idXo4MGRDSHoxZUtnZ011U08yRWtMUVdMczF5UGRhVGxVdmpH?=
 =?utf-8?B?aitFYmwxaWR2L0F2bjFyaWMvbTMvbHVKQTREekhtcU01b0FwZUxxM0N1UGxJ?=
 =?utf-8?B?U0NBMjRIaDY0ODdUamM0Um5aS1Nza2FRK3E5QWNaU2FwemM4eTF6eGVEWk9V?=
 =?utf-8?B?NmtKTnBLUCtxWEZhU1o4L3ZvejZ4dGZDeW4yZmtBRU1PaXBhNmJ3Wld5Vmxt?=
 =?utf-8?B?UFBHbTl0MEJTb1FJaC9KNi9hZUFvQ0xNMWVpYTU2TlAvSXljQlBvTjlzb0M2?=
 =?utf-8?B?THV6NVRsODhhOFRZbDZ3VXNBNlpBT0NLRHN2Wnh3OHpCbys1T0drMnlONGZw?=
 =?utf-8?B?dWpGZkNSUG9NTWFlQjNxaWtJNE1XNDVvckMwSVFGcm43cUorcm1ldzM2SlRU?=
 =?utf-8?B?NXVhcWVVNVpZZGpvcElGcXFHOTFOZ2JPbGZub1d5S0oxdUp0WWhrcjVnSXRD?=
 =?utf-8?B?V0JYSGJ4em10R2hla2srQXlEKy84UXlzMWYyRjU2SHZUdmVDRUYyN1BuUi8z?=
 =?utf-8?B?RHNnV1BJeXp1ZENvbzc0d0N2WU5yekdVNEkrbitTZUNnNjdYSWE1bzhuTlNR?=
 =?utf-8?Q?CvgJfn?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 07:32:31.5583 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 135fc6de-3423-4916-ad66-08de33d07379
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7727
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


On 02/12/25 18:47, Andrew Davis wrote:
> On 12/1/25 11:56 PM, Beleswar Prasad Padhi wrote:
>>
>> On 02/12/25 00:58, Andrew Davis wrote:
>>> On 11/28/25 9:04 AM, Beleswar Padhi wrote:
>>>> The AM571x SoC has 1 GB DDR space. As part of normal re-location process
>>>> U-Boot copies itself to the top of DDR bank. However, on HS devices, the
>>>> top 37 MB is used by PPA and is firewalled. This results in an exception
>>>> and the boot fails.
>>>>
>>>> Introduce a new defconfig for AM571x HS platforms and set
>>>> CONFIG_SYS_MEM_TOP_HIDE to reserve the top 38 MB memory (aligned to 2MB
>>>> as per page size for ARM32) for the same.
>>>>
>>>
>>> This "SYS_MEM_TOP_HIDE" looks new, for other OMAP-class HS devices we
>>> use "CFG_PRAM"[0], seems these two configs do the same thing, could probably
>>> combine them in some way..
>>>
>>> As CFG_PRAM is set based on TI_SECURE_EMIF_TOTAL_REGION_SIZE which is 32MB
>>
>>
>> CFG_PRAM is only set if TI_SECURE_EMIF_REGION_START is not set, but we
>> have it set it to 0xbdb00000 in the am57xx_hs_evm_defconfig.
>>
>> https://github.com/u-boot/u-boot/blob/master/include/configs/ti_omap5_common.h#L75-L81
>>
>>> for all other AM57x, why is this needed only for AM571?
>>
>>
>> Other AM57x boards have >1 GiB DDR. So, the top of DDR space does not
>> intersect with the firewalled EMIF region (0xbdb00000). Only in case of
>> AM571x, the top of DDR collides with firewalled region, so boot fails while
>> doing reloc.
>>
>
> Is there some way to detect this at runtime? Nothing prevents any of the
> AM57x SoCs being used on boards with 1GB DDR (although they also might use
> a different defconfig). How do we deal with this for K3 devices? Some use
> an OP-TEE address aligned at 512MB and I'm sure one of them have that amount
> of DDR.


Well, actually not...
It's the AM62 SIP platform. From DT, it would look like OPTEE is at the top of the
DDR[1], but we do a FDT fixup here in u-boot to replace the OPTEE to the start
of DDR[2]

[1]: https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi#L71
[2]: https://github.com/u-boot/u-boot/blob/master/arch/arm/mach-k3/am62x/am625_fdt.c#L84

I am not sure if we can do such a thing here for mem used by PPA/firmware
as it could assume it has that memory hardcoded.

>
>>> We build for all
>>> the AM57x with one defconfig, so this new defconfig will go unused. Just set
>>> the default CFG_PRAM size to 64MB (same as AM43x),
>>
>>
>> I am guessing all AM43x devices have the same amount of memory unlike
>> AM57x devices? If we set CFG_PRAM to 38MB by default, won't we lose out
>> that memory on other devices which do not face this limitation?
>>
>
> We only really supported "officially" the AM437x-EVM. But our over-focus
> on just our EVMs caused us to make assumptions that would later make
> it difficult to add support for customer boards. Assuming DDR size was
> one such assumption, and should a customer board have the "wrong" DDR
> size things like this would break.
>
> So instead of making another one-off fix to get one of our EVMs working,
> I'm trying to think of a way we can make this work automatically for any
> combination of DDR size and firewalled region.

TL;DR
I think adding that dynamic support would be tied up only for TI usecase?

Hmm yes, I get your point. But to be able to do this dynamically, we
would want to see if gd->relocaddr intersects with CFG_PRAM:

Case 1:
gd->relocaddr > (SECURE_REGION_START + SECURE_REGION_SIZE)
= Best case. U-Boot relocates to an address higher than firewalled addr

Case 2:
gd->relocaddr <= (SECURE_REGION_START + SECURE_REGION_SIZE)
= Fixup needed. U-Boot relocates to an address which could overlap
with secure region. Update the gd->relocaddr to a lower address range
which won't overlap with secure region:

    reloc_text_size = (RAM_TOP - gd->relocaddr);
    gd->relocaddr = SECURE_REGION_START - reloc_text_size;


And ofcourse, we can't put this logic in the existing 'reserve_pram'[3]
INITCALL because gd->relocaddr gets modified in the subsequent
initcalls like 'reserve_trace'. We would want to introduce a new
INITCALL which would be invoked after all reserve_* initcalls and
before the reloc_* initcalls; where we can put this logic.

Let me know if you think this is worth adding, or is an overkill and
we can live happily with CFG_PRAM = 38 MB for all AM57x devices :)

[3]: https://github.com/u-boot/u-boot/blob/master/common/board_f.c#L990

Thanks,
Beleswar

>
> Andrew
>
>> Thanks,
>> Beleswar
>>
>>> should be enough for all
>>> and doesn't hurt to have more than needed reserved to be safe.
>>>
>>> Andrew
>>>
>>> [0] https://github.com/u-boot/u-boot/blob/master/include/configs/am43xx_evm.h#L153
>>>
>>>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>>>> ---
>>>> Fix boot for TI AM571x HS EVM board
>>>> v2: Changelog:
>>>> 1. Drop [PATCH v1 2/2] in v2 series. There is no need to add reserved
>>>> memory node in DT as it is done by U-Boot as part of FDT fixups
>>>> https://github.com/u-boot/u-boot/blob/master/arch/arm/mach-omap2/fdt-common.c#L72-L107
>>>> 2. Add entry in MAINTAINERS for new config.
>>>> 3. Update commit message to use memory size in MB than raw hex bytes
>>>>
>>>> Link to v1:
>>>> https://lore.kernel.org/all/20251128064353.1295063-1-b-padhi@ti.com/
>>>>
>>>> Test logs:
>>>> https://gist.github.com/3V3RYONE/e86b3f4551986b0400d0e0f66d6ecc66
>>>>
>>>>    MAINTAINERS                     | 1 +
>>>>    configs/am571x_hs_evm_defconfig | 3 +++
>>>>    2 files changed, 4 insertions(+)
>>>>    create mode 100644 configs/am571x_hs_evm_defconfig
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index b43dae882b3..e5d564cd760 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -1780,6 +1780,7 @@ F:    configs/am335x_hs_evm_spi_defconfig
>>>>    F:    configs/am335x_hs_evm_uart_defconfig
>>>>    F:    configs/am43xx_hs_evm_defconfig
>>>>    F:    configs/am43xx_hs_evm_qspi_defconfig
>>>> +F:    configs/am571x_hs_evm_defconfig
>>>>    F:    configs/am57xx_hs_evm_defconfig
>>>>    F:    configs/am57xx_hs_evm_usb_defconfig
>>>>    F:    configs/dra7xx_hs_evm_defconfig
>>>> diff --git a/configs/am571x_hs_evm_defconfig b/configs/am571x_hs_evm_defconfig
>>>> new file mode 100644
>>>> index 00000000000..7e44ee5221a
>>>> --- /dev/null
>>>> +++ b/configs/am571x_hs_evm_defconfig
>>>> @@ -0,0 +1,3 @@
>>>> +#include <configs/am57xx_hs_evm_defconfig>
>>>> +
>>>> +CONFIG_SYS_MEM_TOP_HIDE=0x2600000
>>>
>
