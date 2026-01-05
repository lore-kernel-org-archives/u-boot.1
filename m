Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0325FC2A072
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 07:18:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9E0D83A9F;
	Mon,  5 Jan 2026 08:18:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pDjd3iYx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A654883AB7; Mon,  5 Jan 2026 08:18:10 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F0D783A3B
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 08:18:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NfvkKa531jIfoGDPFM/x065OzlOFgoDkIUtW9FROyZcYKGkEYdMK6BfYP5vUEOUwmqcUn2pmqiYZy8g5fp9/Puieqc747BTvT0e6nLl0zB73sJv9aZ1h4JqCoEg4pjvNvNyLXnWgGbGhv49lJTCkX40jqI1uubLUy8c8GU5qubzeyhYGohsTXAhnteR60QAlJeFsr9ZyIh5A2mpZnnZhxUCQUBle8E8vJKX/LlRem5jalvNTJ0PiTC2RWYhoe+4XXJLJbrVssO14sFBTP9p8es3xaTieQQ2BiLaxVc8nYTVQ6mMEYioU6PflEhu4iLjToxc17mPLLBPRYGZTO2zKyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3bcInXMUy+eoSgj0rkSOMxsKsO4T9IybvrJ+f4iays=;
 b=x3030GcNhU2xtQHwiGLU3lA+NtnKJv5/QQXdu2VHVxaECWT/wKJefD7eTGVqlS9izH7lqjzmUfbfFI8Ei6ay4G+ivVdW5KAsSBbrGlW+Q+Q3AzJHh1ZAFzXR8dxeSgvMKNJKfQUPH/qO3atCJQVEyoMyfXEz5Ivw2uxBdCdsGZspwrHJ71praSZYktOqGm5iZPphtFXUgSj1u3zLyylYhY4n3GiQ8NIEjieQBlsZIYhJIaSmjs8FfGas+H7Fnb2jqdIi54KF7QgRgC6Q988stiWA5nmSmbdOjQXTSduIgbDYZbB2I8+65M6QLTK4X4vocACcWsNbkvnoEZUleVIJhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=chromium.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3bcInXMUy+eoSgj0rkSOMxsKsO4T9IybvrJ+f4iays=;
 b=pDjd3iYxYmrN9uIoG8YK6v9yDn/YR7nMqbkBGX7d8/Z4yoIWUU2yCZAZUGkpNyP5dSLea8E5RXu7+2+TBBMViwunXk5BokoweUqbBLSGSN3XBWGXp4ntJhR6/Is1xhQP9QpAC6ro8usrJMQjXmDxtclql2somGJrI9alqzIQx/Q=
Received: from DS7PR03CA0030.namprd03.prod.outlook.com (2603:10b6:5:3b8::35)
 by DM4PR10MB6085.namprd10.prod.outlook.com (2603:10b6:8:bd::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4; Mon, 5 Jan 2026 07:17:59 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:5:3b8:cafe::d4) by DS7PR03CA0030.outlook.office365.com
 (2603:10b6:5:3b8::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Mon, 5
 Jan 2026 07:17:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Mon, 5 Jan 2026 07:17:59 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 5 Jan
 2026 01:17:58 -0600
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 5 Jan
 2026 01:17:58 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 5 Jan 2026 01:17:58 -0600
Received: from [10.249.130.12] ([10.249.130.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6057HsLO761666;
 Mon, 5 Jan 2026 01:17:54 -0600
Message-ID: <e8c526aa-f356-49b6-8bb7-171e53d1cff7@ti.com>
Date: Mon, 5 Jan 2026 12:47:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/11] spl: Use FIT data address as fallback when
 'load' property is absent
To: Tom Rini <trini@konsulko.com>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
References: <20251231173621.1069988-1-b-padhi@ti.com>
 <20251231173621.1069988-2-b-padhi@ti.com>
 <20260102144710.GB6124@bill-the-cat> <20260102145512.GC6124@bill-the-cat>
Content-Language: en-US
From: "Padhi, Beleswar" <b-padhi@ti.com>
In-Reply-To: <20260102145512.GC6124@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|DM4PR10MB6085:EE_
X-MS-Office365-Filtering-Correlation-Id: a7d3a090-61ef-43b1-dcca-08de4c2a8e8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MkIwRytXUmNvM2JuQVI0WmI1Y3BJZHpDbm5hWGFESFNiUFA2UnZCTXJUUmFG?=
 =?utf-8?B?MGxOVFRHMTVYaktBMk42NTRqZlZlV0N1dG1QNFlEeTNySjFGV2lEV2QyRlE1?=
 =?utf-8?B?cURONFRpRUJkQThpS0dnWUVMazhpYy84SUdqZlF3R0svelIxMlU4ekVYTGZh?=
 =?utf-8?B?ekpYd2docjV0OHJONjlnT05zL0UyN3ExeTdqaVRWRGwzSThvc0ZHYWw0V0di?=
 =?utf-8?B?RHNDOU45TXVmMlp0bGYvdS9JN0Y4QmhnRjUrTXJWQnlmeFlmZHkxL3N3UjFN?=
 =?utf-8?B?ODhUY2ViL2xEU0EwcXk2dmo2OG1zVi8waEd2L1B1VlJwb2tLcnZKaTJtdWJI?=
 =?utf-8?B?TVVzTGFjRFRvL1RCM3ZJU3NiTm9rU3VqKzNFZUk3RkZmVHN5d0hUVEZ1b2E2?=
 =?utf-8?B?cU9OSUJ4VmN1WjB5dnhGdlcwNW8xTE5jb3ozZU9Wa0FWdTc0QWt4d1djbXBi?=
 =?utf-8?B?WlZHb3lncVN3Q2VUQy9WSXA5VFg4eFRCNzJqNVhuYmZkUkh4cG1EbkFTNDRV?=
 =?utf-8?B?emNyUUcyK2tYUFVLM2VkTVM2MUJNRlFEdC9xaW5NUmtJYXpLNlZJNXFBaHFS?=
 =?utf-8?B?cERSUnlTL1R1ajhET1lWTG9ySzJyZkthczRraStaZFc4Q1NPOGQrZWZQUGRG?=
 =?utf-8?B?WFpPb1pVUkFsamg1T0laRThpSFZCcUpTN3BJcXM1cUtzV3dUSzF6WTNlaW4w?=
 =?utf-8?B?Tnl2RFQ4aTBzaXVhalB4dFROVk5qVmI0ZS81NzhNUkhTaE5VczBmSnRNM00r?=
 =?utf-8?B?SWxUWWVXM01GcGhzL2Y4THVwenhZLzFMQi8rd2xMQ3BJM1pQdGN5cUNPMGsw?=
 =?utf-8?B?SjhTRGZ4VWh2TVlGVUIwc0t6dXNjRlFVemFuR3BONWY2dUVRc3lmYXNobFEx?=
 =?utf-8?B?U1hsN0JBSmdCZFdsTzBFLzJjcVdkMkplalppRCtENEJab1Nxc2JBNTJPcDM4?=
 =?utf-8?B?RDVwaDYyOS9RZHBZN1dZcC9XQW96NkY0N3dIcjFkS2JUVCtiTmVwWEplVC9m?=
 =?utf-8?B?eFI1RkJ3YWtoK2V0cXg4ZXpjSHU1V0YvdldZeDQ2NkgrcDhYUkQvZGFxS09r?=
 =?utf-8?B?VnY5dElua1BxU2FSTzdNcC9mVjdVY2trODZ1UkpNNkFFWG04N0ExWFBEaSsx?=
 =?utf-8?B?d2Y3MGVnRlRMK1lEY0k5YzdNUytWSW1sVjhuaklOaERRMzlFRWZ4OWtoVFpG?=
 =?utf-8?B?NGQyOGJvdTRQKzBPUkNrai8wU3lkSkZGS2dkaVl6N0NYZnBsaU5rV1BSYjF2?=
 =?utf-8?B?RkhYY21NdFoxU01wTmY0bURzWHBoZGtIOWNZMHBZS2NRa25OVnJUUzc5QXd2?=
 =?utf-8?B?UUJxdThtM1lqSGtFelphMnRGOTd4c1RKNVJtcGVvZ0Q2YWJuazlWR1F2alZK?=
 =?utf-8?B?UjI4OW9EejR2WkNVSGI4MGJkUkNrN2pwQmhWb1cvWklYMDFMVE9RUnQyNEVE?=
 =?utf-8?B?ZUwyZVJtWHRaRm9tOTE3amVZd3FoS082QU9HZ1IyaFgyakdLYTJVR2JCcFA5?=
 =?utf-8?B?YzN0UnQ3T3RwWkEwTXpJL1VLQ0ZjQnZRZ2JpOFBoQU1GWk5GVENhcXpjRGtu?=
 =?utf-8?B?dnh2VVI3dHdDeUlYdk9acWlDKytFUUtZZkpaUUlXM1g3TGRwcUZHdnFhZUph?=
 =?utf-8?B?Zzk0VzZqY2txSnNwdTlkcU4rSGFOdVNiR01nM2piREhBeHNIVUUzWjN4QThD?=
 =?utf-8?B?NVYyZUt3TGtsa08rSnYrcElLZ0pOZUtFd3kwOEozK1cyM1BnZHk0N25jS0lh?=
 =?utf-8?B?MGtqVkNFVnI2Q2NsSzJLVG0yNTgzYWRveGd3K09uQnJnckJwbkZNelFKNi96?=
 =?utf-8?B?dkxNalJ6RThnU01iOGNxUlJCZnBjNXl1UHRzbnQzajZHdU9aeHVCMTBpN002?=
 =?utf-8?B?Ri9ZL2o3UHI2M0FjdFJ5T3ZLaXBNWHkrMS9RRTFiWVpHMHhYaE5NWDFNaFFZ?=
 =?utf-8?B?MlFjRWpwN0NhY3dYM0QvN3lpMW1aQnd1QjRGN0V2L2xPWU9xQzExK1VpR3RS?=
 =?utf-8?B?Vnl2RXZDOFB0ZzYrSjQ3WFBKNzAybVZqZmNnaVRlRDl4eDlCUDBnTnFPOER2?=
 =?utf-8?B?WXlPK3NzeFZ1T0I4OWRnQlMrZGxWRGFBZnYrU2RKT2thalk5YW9TNk12QTl6?=
 =?utf-8?Q?+72U=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 07:17:59.6765 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d3a090-61ef-43b1-dcca-08de4c2a8e8f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6085
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

Hi Tom,

On 1/2/2026 8:25 PM, Tom Rini wrote:
> On Fri, Jan 02, 2026 at 08:47:10AM -0600, Tom Rini wrote:
>> On Wed, Dec 31, 2025 at 11:06:11PM +0530, Beleswar Padhi wrote:
>>
>>> In cases where the 'load' property is not defined in a FIT image node,
>>> fallback to using the data address returned by `fit_image_get_data()`.
>>> This enables FIT images to omit the 'load' property during FIT creation.
>>>
>>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>>> ---
>>> Cc: Simon Glass <sjg@chromium.org>
>>>
>>> v3: Changelog:
>>> 1. None
>>>
>>> Link to v2:
>>> https://lore.kernel.org/all/20250506104202.16741-3-b-padhi@ti.com/
>>>
>>> v2: Changelog:
>>> 1. New patch. Add support to load images without 'load' property.
>>>
>>>   common/spl/spl_fit.c | 16 +++++++++++++++-
>>>   1 file changed, 15 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
>>> index a588d13eb40..c18c98b2959 100644
>>> --- a/common/spl/spl_fit.c
>>> +++ b/common/spl/spl_fit.c
>>> @@ -803,6 +803,8 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
>>>   {
>>>   	struct spl_image_info image_info;
>>>   	struct spl_fit_info ctx;
>>> +	const void *fit_image_loadaddr;
>>> +	size_t fit_image_size;
>>>   	int node = -1;
>>>   	int ret;
>>>   	int index = 0;
>>> @@ -893,7 +895,19 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
>>>   		if (firmware_node == node)
>>>   			continue;
>>>   
>>> -		image_info.load_addr = 0;
>>> +		/*
>>> +		 * If the 'load' property is not present in the image node,
>>> +		 * use the FIT image's data address as the fallback load
>>> +		 * address. This allows flexibility in omitting the load address
>>> +		 * during FIT creation time.
>>> +		 */
>>> +		ret = fit_image_get_data(ctx.fit, node,
>>> +					 &fit_image_loadaddr, &fit_image_size);
>>> +		if (ret < 0)
>>> +			panic("Error accessing node = %d in FIT (%d)\n", node,
>>> +			      ret);
>>> +
>>> +		image_info.load_addr = (ulong)fit_image_loadaddr;
>>>   		ret = load_simple_fit(info, offset, &ctx, node, &image_info);
>>>   		if (ret < 0 && ret != -EBADSLT) {
>>>   			printf("%s: can't load image loadables index %d (ret = %d)\n",
>> What's the IH_TYPE here? Saying to use something in-place is not always
>> safe.
> Looking at the rest of the series, and then going back to v1 and:
> https://lore.kernel.org/all/b6bc14fc-c823-4376-939f-2c0e6b120a2c@ti.com/
> we're IH_TYPE_STANDALONE which *does* require a load address


Yes.. we are trying to change that: support fit images with optional
load addresses. Ideally, load_simple_fit[0] would grab the loadaddr from
the fitNode, and if it is absent, it would use the address that we
populate as fallback above.
https://source.denx.de/u-boot/u-boot/-/blob/master/common/spl/spl_fit.c#L261


Please feel free to let me know if you are seeing any issues with this flow.

>   (see boot/image-fit.c).


https://source.denx.de/u-boot/u-boot/-/blob/master/boot/image-fit.c?ref_type=heads#L545-554
Here, we are just printing unavailable and not failing anywhere based on 
IH_TYPE_STANDALONE...
Could you please point out if I am missing something..?

Thanks,
Beleswar

> You might need to look in to a new type or see if
> another type is reasonable, that doesn't already expect a load address
> set.
>
