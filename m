Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9463DD29DF7
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 09:40:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3079083678;
	Tue, 13 Jan 2026 10:40:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="cRKiEnNf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C265C838BB; Tue, 13 Jan 2026 10:40:23 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1CD78352B
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 10:40:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u2i8K81+QcU9kmPeoRCtdvbHB9ulOW6gSfSBqb3e2wWsD/Nicp648sEIWEfrFkjx7SViZYwdwBZ/7tUKpYODJRuHv4fTwzIGKYycllJxjxXMULbFrSxmW3/Zq/OIs3jZAf9e47W/y7XLyuEIO+WuiKa3uJ1fwgXFQOrpQofam5p9Aw6W2HqqQy9hLt4vxP/zBqtgKNLI1HD4ty7rbmj93lcPMkolCreerH7kxjRagETS3xprKXLS16SJ/77BVpxe/4+wY6EGeTI/EifNRBUCkslqUFeIZaKlZJiikRj4eaMavQpmGOsJ7vQNQvxyiyfQRvOGBK31fon5p9RyrF43FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8oDGVFQFsdRZiXCnZVJI/h7RflUcd08/fuF+CaOHMjA=;
 b=yGphA6OzuoGcoeKWHDVA+P5EvSe40wWHQA4EZ9gYl6TqPd1dSfg2+OCtAJc/EpomJhSdLncFjzfZ+Rpw/O+ixQTRqUP0ZfkCghwJTFWbeXRUNzIjr1bOde46RCEXaWFEd2QIqB21aAxZN3HfRucfGfRizpY8h1VRL9ITze6Di638+zq953+Fz5hlovUAAX8r6Ge9HjTrIN53hs6ISLKHoyQSawjU1jycYTLXy4JfHYVeIb/CoGm99LNBFcfiMThssEqlmshf132Lw/y8P+jJ+ukC+cIvD74w+YFSLe12CRsX7v/RF1dxrNGu+x+zPE+D6I0aaSeyQohomoowBxzMAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8oDGVFQFsdRZiXCnZVJI/h7RflUcd08/fuF+CaOHMjA=;
 b=cRKiEnNfGcCGUYttQrGZBbDQGfhw1SIB/eNtqtULlFmXqSmGiSFwkZRd9sGju6dgHB1UPu2xOtLerVABIT5aFO5MXqvn2p104PIYS00aTOPGDm2Y+AFxmTuNvHu/stUmVq4rsrmufov+u4bjkqxpuHCjxv5KKx7YKxSDwm3RizLpq/1bc5HMJuiw5J66WnAB3jRbI3858JVefKOs0HMvTyMJ9igK8aayXwwgqlRGNw586UE5VAKtyseT43a0Dg3KjvyjpWOygWb1Zglc0uKPm0IF4LqhdptWRMK8E4maxqjAt5xiUjsGXbxsfKaioCT9S22Mpjf4PX6PQVEB4toPew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SJ0PR03MB6469.namprd03.prod.outlook.com (2603:10b6:a03:398::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 09:40:19 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%3]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 09:40:19 +0000
Message-ID: <5a182394-a1d3-4799-a0fd-898ab35a547d@altera.com>
Date: Tue, 13 Jan 2026 15:10:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] power: regulator: common: use dm_gpio_is_valid
 helper
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>,
 Dragan Simic <dsimic@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 David Lechner <dlechner@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
References: <20260108-power-regulator-fix-compilation-v2-0-b00cb3268059@baylibre.com>
 <20260108-power-regulator-fix-compilation-v2-2-b00cb3268059@baylibre.com>
 <7b910d61-cbcf-421b-ade8-904a7f3a06e7@linaro.org>
Content-Language: en-US
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
In-Reply-To: <7b910d61-cbcf-421b-ade8-904a7f3a06e7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0230.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f4::11) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SJ0PR03MB6469:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c6af6ff-6d71-46e0-ea7f-08de5287c39b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MzI1L3FLK1Z4T3pUQWFYOTJUWDlwT1J5YmVueFFBN2lxNmY2VVJjQ2twVWFU?=
 =?utf-8?B?WEdwT3oyemlGSFZaYXg2V05pOWxQS1N2aGZCODVNWXljd1Q1ZUVkdGtla2NG?=
 =?utf-8?B?cUh4UEV6TGp6bldLSWlwVFljeXJlNnN0SmwwUk5DT3dTdmExSDl6blFpRHdU?=
 =?utf-8?B?c3lhVGJOaXJBQVpwQlRxNEtOZHEzT0NkVGs1RFJxSE1nRU5zaVdQQzhhK3Zs?=
 =?utf-8?B?alN0K0hZakFLQlVtbzYzOVFkR3h5amNzRmJ4S210ckhpWit5K1NVY1V2dVNx?=
 =?utf-8?B?YjZ6cWNyVzROVTd6QzRjLzhBWnZKa2E5aWN4SEttcWE3eTg0c3k4UEJJL1Ra?=
 =?utf-8?B?WkpmQWdwT1VRNGR4cEgxTG90LzZQRC9jRXhnUXRxKysyRUR0TkNpTTc0cnI4?=
 =?utf-8?B?MXQyOHRWWGtUSTkxSXE1ZUJpRTZvWkZIenBKajZZRWN1VVA5R2lJSXlSM0ht?=
 =?utf-8?B?VkxEYVhIREwxUndVd1R1SFZOY1BubFRaa3V6em9BcE9CM0NRQlpjL3Z1MjJK?=
 =?utf-8?B?WmRNL010N3pNSjZjejNrTEZEejNGdGNjRTFDdVBGS2lsNVk0WkRjWUtyS0tU?=
 =?utf-8?B?aDNxTi9MdytKQWZULzc1SFF0cGFEQ1V4dGZldHBIcERGb0NITngyTDZjZlpO?=
 =?utf-8?B?bWQ4dDd1cGxSQzN2UTBHU2lhK3k0b3FUaHNYdFFpSFk1a1VlUGhxaENQQjFV?=
 =?utf-8?B?TFlKSTdtWmtVSXpTbmdES2lFdXpRc1dadTZoL1VNKzEzaHJhUmkreFZXZEtr?=
 =?utf-8?B?OHNsNXhZMXZySEpVenhPbi85RWtIYkYrVXE4bXZiL3NyY2ZKR2ppUWF1azhM?=
 =?utf-8?B?aVJtaU5jTVZlTTF0Rm81RzBxdW81VXBMV2xTQ2pTTWh4cVNoOUJCYWgwV1Uw?=
 =?utf-8?B?aUpoR1hUQy9RNWZXbmhzNFRWdE52NVVLUk1sN1RNa24yNDJkNU9zU1lDSmhR?=
 =?utf-8?B?VlhENDUwVjN2NllxR2tLaVRZOUhzWlpjcDlLdGk1WWphK0Y0MVZ3TUFyczFa?=
 =?utf-8?B?dGhIclpzM29RbU5hbDFab2FvQ0UvMWQxRDh1VUVYLzhiZmE3RzVsZEwzR20v?=
 =?utf-8?B?NHRnM0RXWnlBQVJpSHFTcmFuK09aREwxZ1hMaHE2SmorT2J2TC9PQitlMnpB?=
 =?utf-8?B?V1hJeGhjcS9EaWl1QjFCczM3cWlhVWQ3dVNSdVo5RGpicDNOeUhLRXM0YTRl?=
 =?utf-8?B?cHowbCtkRUZsbFdMa3NSTmI3eVo0YXNNRlQvM0FNRm53enh4ekxoVUptRFNr?=
 =?utf-8?B?cmlrd2dUM3VYUzlVQnZ0L05PWDBQQTB2VWZBeWljeUVqUjRIZHZSNTFISXdL?=
 =?utf-8?B?N1BrSjFieEFQcVA5NGpGWG1tQTVSQWRhb0Nyb0laT0YvWUtZOWgyZWx3UE1L?=
 =?utf-8?B?ekE1blBsTVlyaVoyb1Vya0ZrakkyKzEvTzg5UjhTZUEvNnQvS2RrVFUvd3g3?=
 =?utf-8?B?bjkySmRNMDJkVTR5UVRNeGVySFU1UG1wRVphd200R2hsbThqWWhPOUVSa3g0?=
 =?utf-8?B?dXYvTHFNQ0Q2VFJEU1l4QU1vYkhIQ0lldm5ub0RWTzE4OWhUNFM3dCtjZHpX?=
 =?utf-8?B?SEoxZ3RWYlJiNkt0SGRwTk01bFpHQXRSS2FocWpJTWI0cUVVUG1xazAxd3lE?=
 =?utf-8?B?dW9jaUczdWx2cjkxNXI0cGMyRDJYRUZVUUFlUnMvR2gxVlpqSnB5aVlOWkdW?=
 =?utf-8?B?aFg5RGU1VTg0MkpFWXh3Y3hONHZGVVBqZWpNWUFxTUhZTEpOUHR0UkljdWlv?=
 =?utf-8?B?eVU4aTR5cWxaV0J6L0VSaDgyQ0trL0piMUNnMGpxSy9KSHJMQk1GNVFRQXYy?=
 =?utf-8?B?anVDRzJhbGNndXhEbzB4RkdBOXdjV2YwSmJldlFwdGIyT0czVmx5WUNhbWRQ?=
 =?utf-8?B?dzYzajNXanB3Y08wU1hrWUsyN1I4bHcydFhkRThWV21hSFJvMUlOb0xYUzNa?=
 =?utf-8?Q?dvPT0bCWY5Idaaw75p9LEdLIP2YeutSb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1k4WkRMa1dYbjYrTXl0dkRCQnIzeHZla3podkRVNXFkS08yVzlXT1A0M244?=
 =?utf-8?B?aXp0akJQb2VVSGtXL3NSRmlrdlh0UnpCeTJsS1pJRFhNSVdBMFBreEF4UmlR?=
 =?utf-8?B?UFozR2F6Q1hxMThDTzdBdWZhZ1d2K2tHelNWL2R1OGhadElWUGdtMGMrdmtX?=
 =?utf-8?B?U3ZoeDV0S1FoOTYremRSOTI4K2d4a05ZYkdYZWM5OVd2ZGM1bURaeHN3b0dy?=
 =?utf-8?B?ajlRN2VCQW9aNXdOeXRYK09hUHdZZW5sem5mUHJuMUJ2K0JDQWVaVm81MjRE?=
 =?utf-8?B?YzNZUk9Rc0lTMjNPYjhEYm92WlZLU1VSRUFJUDZUUVZaS1pZajk1R2IrZDVs?=
 =?utf-8?B?STNyM2MyaVFXa0VKVnBTcVlRVjIxaFdhUzFqNkREZlhocUpjVGR3VWxOK1Fv?=
 =?utf-8?B?SDZ1Z3I5YlcxOWtlQWxIZWJLd0dkc00xR0F0YjVJb2x3WFFjWE9oWkNsTkJh?=
 =?utf-8?B?WmM0b0J1LzQxS0ZSM2ZIaHlOZjFpZk1KR0NLYS9NQURyYy9YaDV1NC9jQlBO?=
 =?utf-8?B?VmNBaytFNE5iUnlZeVhDVEptWDhiRnBFTWFNV0J0YUdYOGlIOFh6Q09nWis0?=
 =?utf-8?B?SE5WbXNHaVdiZjBITUlkS2FkTHZWVHNtc2ZMTllLUlAwU1Y0aWFsdklMQWdV?=
 =?utf-8?B?L0pVb0huSE1WMVpiMS9WbkNObWpYSmxsUjNJbUNpbTRNaWlPVC9YMGpIU0tQ?=
 =?utf-8?B?bG9TUHYrR0FkRlA2RmdDTDRva2NtSGt4aWxNb21pVmlvQ0VwNHRtc1ROZmJs?=
 =?utf-8?B?TGE5SExDWmNkV2NLTnRHUndlZmxSZ2lCakZpNElFeklMazVIdjNrTWlydmZs?=
 =?utf-8?B?VlhVZVoxc29zTEZvRzh3d2pQVkZic1FXSktqNFZud2ZCQ0VweEY5N0EvNUFT?=
 =?utf-8?B?b3NYRGpjWnI0WGVPUDZMZk1rOGM5ZGc2c1ltb1oxSUFnQ1RvK0JDOElmbTVs?=
 =?utf-8?B?MURxeVFLejVxUEVncFBQbnByUWZReVB4Tm1ZZDZhS2ZMSTU3Q2lRbWFROUlw?=
 =?utf-8?B?WlBIOFUxaTNUeVRKUlFWaEgzaU03Y0pKNHdLc21tZ3FiTVBsQ2xjbUt4bFBQ?=
 =?utf-8?B?NDgxMzFBV0V4WmNmdVFIWFJ5d2xnQnJMdzNQMGdzblVjOUxqbm1hbjR5Slpq?=
 =?utf-8?B?cmVlY25EZ1Q3YkUyT21qZ1dTMDZ5ZkRNNTllRXV6KzZHYVBoYU9lR3ppTEw4?=
 =?utf-8?B?M3VJQzVpQm1STXRFaFFpc1pQU3U1MUd2Y0JJc3grcEYzeGlmdXRUQmlCSm1a?=
 =?utf-8?B?bFdLaHJtcVNGdnRPbzZHblo4eUsxZ1ppaU1wa242ZytQeEorSXRKVDRpOGFl?=
 =?utf-8?B?cHE3aGlnNnJxTGdtNExzOWZ4K2Nwa2dWQmFHdWIzN3UzclFIVkFhVmU2VjNB?=
 =?utf-8?B?dVk0aENTcVNoK3dDYVM2ZTh4eHVhL0dpNERCdkc2M1FQVm42ekFaSm1pdWJp?=
 =?utf-8?B?dVk3NnJmb0R3YnF6Q1E4SnNlS0QwNE1oMjFrRTVNcFlwM3JhTGhoRFhvREhr?=
 =?utf-8?B?T3NqOEVuYjRhL3V5UlMzbW5zcXd4SXdaWWdKemF3dWR5c0ZtUkdkbVppd3JN?=
 =?utf-8?B?VjdtSVVjYU5MVlk0QW5pS3NwUXJRdnJPdFFoSGZibGFRaXo0Z1djM2UwSHo1?=
 =?utf-8?B?NFZkS21XeThZcFA0Wmh4WW9ScFQ0b3NPR3hHTmxjZ3VVelJyMUc2V0pwbmlB?=
 =?utf-8?B?L3JyVklsNUN3VnJFUFpnVUV5bVYyMVZyVEY2VzBjTUxDNVhXTUZOMDkrSzkr?=
 =?utf-8?B?cU5UbG90UkVmTUhrbmlsSERldWxPUVlQMTA5M2h6NXpNWWthTlNLU2creHh1?=
 =?utf-8?B?VlhTRjBPZisvdTNOelRMRTF6c290c3d5cDlNdVdpSWZac1BkWDZsNlpJK1RN?=
 =?utf-8?B?b3pQTlMxeUZSZy9FVVJWeHViTWNEYkF3SUUyaGRiRk11ZTlIRmMxWjBZT1FC?=
 =?utf-8?B?S05KSmVXZFJBbjloY0JOcUttSm5YSWpWR0wxMDZJSnBBNUxuaFJlM3A3dStV?=
 =?utf-8?B?UW5EMnM5OGhsalpZWGkyUUN4aTJmVG9OWWROV2pKbm1wc3gvVXY0SlcvajlH?=
 =?utf-8?B?Rk5zT0NUZEdOZTY5KzR0WFlVanpPbUluWit6TnFMUjBsMGJlWHFOU3laNmtj?=
 =?utf-8?B?OWhhejNmRlMzdWorUkZzYnBxRHkyZ3BBUUY1eWlnbW05Z3BmY3RwZ1E2V3M3?=
 =?utf-8?B?bHB4ei9ITlQ3VWxKSnk2SGE5REk0Y3ZDMU5IZ293b0w1KzdaR1p6cWwwVkN6?=
 =?utf-8?B?K240ejlzTExUciszZXpKN2VqbVBWTVh2WXlrY04xWmJTWWlqMHB6eW00Z1cr?=
 =?utf-8?B?VHRWMjUwMFo1WUpnc1BnQ3l5aVlRcjdzcFhyMFBzZXV5RmUyRXRKMG12RUd4?=
 =?utf-8?Q?HYLp+itQ7+fyzGLc=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c6af6ff-6d71-46e0-ea7f-08de5287c39b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 09:40:19.1979 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aB/TyfrFEStw72DlRQiM3UFfXWc3rW0Ch3xJ6LCzuZvVjBuDu0mBHVx39P9clUXFQClgrk9NssNK7DGmkOFynFnKbYfvhPtjlA8g1uQOy1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6469
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

Hi,


On 1/13/2026 3:05 PM, Neil Armstrong wrote:
> On 1/8/26 15:42, Julien Stephan wrote:
>> Use dm_gpio_is_valid() helper function instead of manually checking the
>> gpio.
>>
>> Reviewed-by: Peng Fan <peng.fan@nxp.com>
>> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
>> ---
>>   drivers/power/regulator/regulator_common.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/power/regulator/regulator_common.c b/drivers/ 
>> power/regulator/regulator_common.c
>> index 
>> ce3d80670de045dde7e263c5301bccd744abd2f5..cf98998579aa8a3cb7f09dccd2124207a58d8b00 100644
>> --- a/drivers/power/regulator/regulator_common.c
>> +++ b/drivers/power/regulator/regulator_common.c
>> @@ -51,7 +51,7 @@ int regulator_common_get_enable(const struct udevice 
>> *dev,
>>       struct regulator_common_plat *plat)
>>   {
>>       /* Enable GPIO is optional */
>> -    if (!plat->gpio.dev)
>> +    if (!dm_gpio_is_valid(&plat->gpio))
>>           return true;
>>       return dm_gpio_get_value(&plat->gpio);
>>
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> 

Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

Regards,
Tanmay
