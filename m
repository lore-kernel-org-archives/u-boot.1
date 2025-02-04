Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A469C02193
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 17:30:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EBB3805D7;
	Tue,  4 Feb 2025 18:30:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="k66nUtls";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3E1B8070F; Tue,  4 Feb 2025 18:30:40 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB9BF80762
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 18:30:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xt1tIPk2KMsoL/MNtzIEI9vzvmTBMK+dJOmOzzIcby9dFigCJ1W6G/un2H9LRYw8vOyhbhD40yr7tVT0VLiut5tW3ntE47TOABUirvjAb2x5G6wUS+nf3Uam9oWuL7neeLcadovZVtVh6P0LtEF6FodOV/ABefKRxyG79YrRtDa7s8+JEokIQq1cZPVitPZS1zjcDPIl5MlzvCOOEpnEpdKiR2JWalAMABxqwggl2tP5+XRIQ83fM1/c9cbOQK3gqPrWt0ghS4VFC3qSLR4G2QH2l7FQ+Axb2ah2GeFK2/90cL01Cg2/38mAWwy+068VU+O2qCnXtD2O4I0+tEzi+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7tTlJKhmyuM+JGU8Xs1aRL481342N/5QxmYZIFcKnpM=;
 b=A42wV2tRkSK7cws4AKX0ZgHbIYENDviI+AvjVx3mJDTFsyRlhp7L36HtNRztyS7787KqgdhdYpnx7rBziSOh6JlZdqPpfL3Omgi+/HDjZO+Ejna1S68N8YMIF8qytid9IvyWKj45mmNg1111/aAWvdt9Ds/TR7HLc2ReEDGlKwN6J6SFErkthXPGUhyi2JYFzTQ4zDKKRXhG8kjnZEKr1pkPaek6OpYBHgNro3GV9tklFaWLRw2uMxqWRyzgEIr+JLgSqhFRxsjUmtefBowcMSWhLCRZFWBk8Wwn2giEZMcWq4lk9sJAH9tUNYn3GIn1/leSF70farWn3xl+B5psZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tTlJKhmyuM+JGU8Xs1aRL481342N/5QxmYZIFcKnpM=;
 b=k66nUtlsbqVKjcqLACN9HiEx3QLQNAxhAe3UOzmb3YEtsMo7A5cM5Y+sSmXxwWV6i9yWSOjFWFnMtmfmyhnRdnl5NbeG6obnNCyeQkBd+rLf2x3aVbfzvzw9XedRlrjf3BqO7nNxasozNfHN2GApy6wHil9ZFi1P44xq1UHFypU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU2PR04MB8744.eurprd04.prod.outlook.com (2603:10a6:10:2e2::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Tue, 4 Feb
 2025 17:30:35 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 17:30:35 +0000
Message-ID: <fd8e76dd-f26d-40e4-b16e-893e670e217d@cherry.de>
Date: Tue, 4 Feb 2025 18:30:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] regulator: rk8xx: Add CONFIG_SPL_REGULATOR_RK8XX
To: Justin Klaassen <justin@tidylabs.net>, u-boot@lists.denx.de
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Jonas Karlman <jonas@kwiboo.se>,
 Keerthy <j-keerthy@ti.com>, Kever Yang <kever.yang@rock-chips.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, William Wu <william.wu@rock-chips.com>
References: <20250128213852.465664-1-justin@tidylabs.net>
 <20250128213852.465664-4-justin@tidylabs.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250128213852.465664-4-justin@tidylabs.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::15) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU2PR04MB8744:EE_
X-MS-Office365-Filtering-Correlation-Id: 144e31cc-09ff-4796-14dd-08dd4541a1e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S2xnNFZzYVB5dnpEM04xblVGd0l1RE9aclJiRDJuTlVxbk9rZ1M5eTNsRGdB?=
 =?utf-8?B?ZUxuN1hnd3pDRXhoUUF2MXpsRjdXSmM3ODczSXh1OGFuT2R5dWhrYVlabG1q?=
 =?utf-8?B?QnZuaG91NHhrYk4vTGpCNndVMURXNDdBYlFiZkhMTWFkeGxGcFpiRHJETks3?=
 =?utf-8?B?Z0szRWNWd2tENmlMbnJEQlY1ckduWENvQVl6VTFRNWJaN0tUSzJVSjczdWRq?=
 =?utf-8?B?dVhiVTJ6SkxjbEJVNnFHeTBwVGtuQjc4S2V1am0yUjVjeitGMGJIaWora0M0?=
 =?utf-8?B?blQrZFByWnRUTkJ1L1dnMXAvZmpJWXlVbDQ0anF6blAxNG16eExHd0cwK1lq?=
 =?utf-8?B?UElVdkNFVTBPOGNWeVBVT3d1Q2plU1R6aGFRbFVWaDRubm1OM2w1c3RpQ2p2?=
 =?utf-8?B?UkNOT3VzaFBydFFvODhEaHREd3A3V0QySkF3VlNHNUJJOW1pMHVkb2dBQ05t?=
 =?utf-8?B?L0dhc2xVaDBPN25Ld3JXQU9XbDFBVHVTUE1oNkU0R2Z5cXBRWVpTRDBBZld6?=
 =?utf-8?B?QlF4UUkyeGNuK0xQYXR3SXBlMVhNVE5UbFpmanRBRjI4ZzdCMWpHWnNvd1NT?=
 =?utf-8?B?L3Ewd2dENVpLTHJVWVZ1eVU1cU5GbXQydUtkd2JCQ3VacHNCa21JUVFlVGV4?=
 =?utf-8?B?bHNCdzZOVWFleTZOZERxVWFYUEdna0I0NEUvaWxhUFU5UHdPRGxidllkRWRq?=
 =?utf-8?B?RkNxenNHcFQ3Yld4TUpsTVhMYnJqWjQvNXJ4MXBHK2FaVGpSNzZFZXJqTkxl?=
 =?utf-8?B?L1NBSEdQWDJKakFqSWpJK1JJMnhpd0Z3WFVoUjBmcWJvL08vRkFzbnFLN2dB?=
 =?utf-8?B?THQ2cE1YMDZWTkcrRGY4eEo2Y2dGaVlub1Z5NXVwQnlYUWFmK0YreWZWaEdI?=
 =?utf-8?B?SlQvVFFQQWVwQkNjZTZxZGl4VjcweFJWY1cwbS9udHRmVTdITHpab2FaT2xp?=
 =?utf-8?B?U09DZlI1YUlkVktydjdjK2p1M0dvbWtSbUx6aldWNVBRS0hjUVlFdlZEb013?=
 =?utf-8?B?UTlraXZWVW9xK3JxRVM2TWpVMVZJMXhtZkhtRmpXQVMvSkhvWTJ0Z3Q4bEd5?=
 =?utf-8?B?K010M1NmZWpqVGk1OGtHdmx0R0c0RFdFSll6cnNoaEVJbjUwVEV5RSt4Vy9L?=
 =?utf-8?B?aVNsN24ySUFzR0tlQ0dzcXBWWUJ0anJreHE3eDYzUXNKYnluOGpsaWdCSjVs?=
 =?utf-8?B?MnJJYzBFZ2xuOGNMRXhDQzc1VjhUc0E1L1YrZzY1M0JKaFRkN3VzazMwamw2?=
 =?utf-8?B?K3JLbUtick9NaHJQcGFFRUladmVqRWk4VmNLbmt3MHRveEwxSWF5Zk14OVZx?=
 =?utf-8?B?OE8xeHJSZ0RuVWw2dkF2b3RMVTdlRytiK1ZCUXZZQUNHOXlla0tFUngyOWsw?=
 =?utf-8?B?Nit5ZnV2dWdKVjJZM2JscVZVRE5uSEVqV0JiQytaYUZzaWVwSVNjZ3lFdE1D?=
 =?utf-8?B?TEM1UzNyU1hGbVVVcjhqdXRaaUJJV0NTM1h2QjdNRW9xOVhPRVg0MU9TdDJR?=
 =?utf-8?B?MldtYTdZV0hyNVo2RnBjL2d6Q2JiMDhEYzhDVVNBa0NVV1ZqakFjbUFSUHY5?=
 =?utf-8?B?SjFHRzFnK2JLSlpsZHB2WFBVUEE2clRRZllLcXhHb2hleWZ1di8reThWZDc1?=
 =?utf-8?B?NmRja3g3ZE9nZ2FzaTR5S1RuNDhRRTRmSHVlaS9iQVg2MFhhOW5qNVJTdEFz?=
 =?utf-8?B?aHl6Ni9yZkRvTkw2a0k0d2VuQTNIaWltN01NdDJTbTkrNGhoZUR1Lzd4OHZ6?=
 =?utf-8?B?cjBzdEcva0ZvN21Yc05sbWhzcTBsanBaVXNmZGUxbU5Hbm5rRlRwR1JOYllC?=
 =?utf-8?B?ME0veHplbWVLWVA2MU4xNGFsb0RoaWZyMEFDbmpGK0tUUHJqMURMeVVWL1M1?=
 =?utf-8?Q?/rZO23icnApqC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1hzVWxvZEdDMUxTeW9xdW5OemY3NGV4Mk50aVVqaHRVVDhncU9ic0lRUUxN?=
 =?utf-8?B?dkhCMGZjNDNDc0Y2NHMvNjI1aTlBQzNaRlRZak1OK25FSGNvNWZPellTc3d6?=
 =?utf-8?B?QlM0ZVNvYTBuODZVaTNtQk5SVk54TVFjNFcyNjZVTk55Zk1VM1M1eVpyZG5z?=
 =?utf-8?B?QjFIUm9JTTlhYTBrb05ld3JZckZhYzVDSUMzQTQ5b3d4QjRSVW5tcWNmL0FL?=
 =?utf-8?B?WWVBdXVsYVl2LzRaTzJOMkNpWEZENGo0eVZJWVlIYnFhbG1XOFBYenJ1VlI3?=
 =?utf-8?B?S0YzblUyK1J2WG1tc1g0NDB3VVM2YlZ2OWt4cnR6MFYzTDYydUplVHlkUk9S?=
 =?utf-8?B?Ti81MVFTTkFoYzF2dFF2Q2pJMnMyTUtwdGIwS1F6aHJkdy9raUdpaFkxVzZG?=
 =?utf-8?B?cU9ydVdNbk1VcEI4dXJCOEpYUGwwdGlpeGlCb25EOGFMRExHanBxRTh0QS84?=
 =?utf-8?B?dWs3bFp4TkVYdFJleEVxcURtSVkwc3M1RlA2aGVDMjViOUhXTlMvRFJjcUpM?=
 =?utf-8?B?b3d2aHFUL2FqaXB0Wk9OZ1N3aDZneXFlVjNDLzlzZzdtVU9hNkRLMGlTYW1s?=
 =?utf-8?B?VC9sN1VZRFJJQjAzZnFtWFRzWkNqVjhtcXdGRW5ZZ1F0eGJ0d3Iyclo2RFY1?=
 =?utf-8?B?TmpmTHlqc0cvYUd4RzJBTzZadWNmV1VYR2xuM2ZIRXFuWm84RFF5QnNRTTkr?=
 =?utf-8?B?bTRQQ3dGZzNsY0ozdDRHNGFNd1p5WTFCZ3pjWEVERUIwWlBmVmRDaHkxSGxI?=
 =?utf-8?B?UG00aTkzZG16eW1qb1NHMmU1TExVcGN2YUl1TUNJaDd1dVZhWHlIZXhUL09R?=
 =?utf-8?B?endHODNtWGRPY3FTQmNpRE9MQjExWTY0REtjQ2hkbzNEY3N6VDNmcVFhWEUv?=
 =?utf-8?B?NzhzRlh5Ym5hV2UvRlNWcmdReVl2bzdvVU9qVU12SVBuUUpqaElQT2YveDVI?=
 =?utf-8?B?aTA5NlJJa0s4Ynd5T05saVJQSzZNb2FyM1JMZnI2NmZBcUVMWFJuRTVpQVhq?=
 =?utf-8?B?SmZmaGljakxycURvV25wckg3cXpFeDRGSWk0eWtKN0FGcXVIcEYwYWl1Q29L?=
 =?utf-8?B?Y1VnTzl0TTd3VnV6enNENHJMTm54RGVHMTlwa2loN3ZIQjFOWFIvSUdnMmg4?=
 =?utf-8?B?QWM0WmJ0N013TTl4VjBWd0wwN01Xb3gwNVJBVEVmVVlFbG8wc0JGMW4rN0h2?=
 =?utf-8?B?dHJyeWlkdVBPTTBsWkYwNEJncVZmTXR2YWJhbm11MnFsWGpWYzdqby92QURh?=
 =?utf-8?B?dDBKeDg5aXpkNUNZVG1Fak16TEJtODgxN001NzJJM0o5MWoyNVBJTFZybkdV?=
 =?utf-8?B?NkIyUEFzSjNnME1jUWR2VEJsNVdLRXFOSFI0Z0NsTld3eTFoYzJtcENSVDBS?=
 =?utf-8?B?VjZnSFNqcGl0NWI3THgvVGozck9QbEJSWXJmejhsV1g4d3VHOC9oZU5XRkVS?=
 =?utf-8?B?MDY0bFJZMHhNdllmbWl3OUtlUUw0QUZxVURNVHl5UUZ4UmZoWVRQajBmRzJI?=
 =?utf-8?B?RFBROHdKVW12dUNXaS9GcWhsaC9xOEtRNC9QWWdiV0hDd1ZaVXd1N1lBWGFI?=
 =?utf-8?B?QnZBcEplbk5sN3ZvTUcyMlB0QVN0WVRrU2dSWTdZSm1wVDhEV2ozVWtpaDRF?=
 =?utf-8?B?VUpuTkZsaG1UQzFBRW5aOG5YZUZ3dThtR2FJSjNET3Ryekw3L2VzMGoxdTNO?=
 =?utf-8?B?N1ltbDh4MVNaUWgzRHZ5UEVTaTlya1BXOE1BTFRmeEkvM1c2MGpKTDhzMU9P?=
 =?utf-8?B?OW9DSmJGYXpvWks4RlllTTZtRkRwbGx0ZlhuZzhNS3FuQnovNUdlTmNXWlZm?=
 =?utf-8?B?MXI5dU1qOUJHRytnTkJZWjZtMmQ4Vmg1NGxlTmZiQ053WXVTd3pZNEpjQUNh?=
 =?utf-8?B?ZHEyOEc4dnB6dkpuWEY1cDh1SFVITDIrU2NDY0NhWnl2R2ZoMDQ4TkY0RmVG?=
 =?utf-8?B?aUc4c0dRS2h1elpnWUpmeTRVOXV0SnVZQjhBaXFxY2R3S0dyVGs0dUpVWit1?=
 =?utf-8?B?N0RieDMyQThwY3JHMnBOZHA5VkxJdHdidmJrMkhnNEd6OWdSc1hraEplOHZW?=
 =?utf-8?B?NUppbS9xZ0podFRGbDRQa0lXQkJpRDQ5WmxwQTh3eldVVkNzMHM2ZEZNZlZu?=
 =?utf-8?B?dGNQckFpT2VMaUs3UnVrOU5LMFg3N2F5UG83Mmk5VTdoSXk4REQzU1c4QWk5?=
 =?utf-8?B?MHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 144e31cc-09ff-4796-14dd-08dd4541a1e8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 17:30:35.8435 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C/DclwRUFB0QENkNT7gv8XL+/D5xi0GtxRlRHhkXugsXZeFkFTC5jzDa46C8or6jelWRRmNWYT+s+AedGGuEidMXTEJRNmIxOPxMzSPYeZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8744
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

Hi Justin,

On 1/28/25 10:37 PM, Justin Klaassen wrote:
> Allows use of the regulator functions of the RK8XX PMIC in SPL, which is
> necessary to support the functionality of the Rockchip IO-domain driver
> on relevant platforms.
> 
> Signed-off-by: Justin Klaassen <justin@tidylabs.net>
> ---
> 
> Changes in v2:
> - Added separate patch for added CONFIG_SPL_REGULATOR_RK8XX Kconfig
> 
>   drivers/power/regulator/Kconfig | 9 +++++++++
>   drivers/power/regulator/rk8xx.c | 8 ++------
>   2 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
> index 958f337c7e7..9b50128f859 100644
> --- a/drivers/power/regulator/Kconfig
> +++ b/drivers/power/regulator/Kconfig
> @@ -241,6 +241,15 @@ config REGULATOR_RK8XX
>   	by the PMIC device. This driver is controlled by a device tree node
>   	which includes voltage limits.
>   
> +config SPL_REGULATOR_RK8XX
> +	bool "Enable driver for RK8XX regulators in SPL"
> +	depends on SPL_DM_REGULATOR && SPL_PMIC_RK8XX
> +	help
> +	  Enable support for the regulator functions of the RK8XX PMIC in SPL. The
> +	  driver implements get/set api for the various BUCKS and LDOs supported
> +	  by the PMIC device. This driver is controlled by a device tree node
> +	  which includes voltage limits.
> +
>   config DM_REGULATOR_S2MPS11
>   	bool "Enable driver for S2MPS11 regulator"
>   	depends on DM_REGULATOR && PMIC_S2MPS11
> diff --git a/drivers/power/regulator/rk8xx.c b/drivers/power/regulator/rk8xx.c
> index 368675ebb9f..88453bb7bdb 100644
> --- a/drivers/power/regulator/rk8xx.c
> +++ b/drivers/power/regulator/rk8xx.c
> @@ -16,10 +16,6 @@
>   #include <power/pmic.h>
>   #include <power/regulator.h>
>   
> -#ifndef CONFIG_XPL_BUILD
> -#define ENABLE_DRIVER
> -#endif
> -
>   /* Not used or exisit register and configure */
>   #define NA			0xff
>   
> @@ -202,7 +198,7 @@ static const struct rk8xx_reg_info rk818_buck[] = {
>   	{ 1800000, 100000, REG_BUCK4_ON_VSEL, REG_BUCK4_SLP_VSEL, REG_BUCK4_CONFIG, RK818_BUCK4_VSEL_MASK, 0x00, 0x1f },
>   };
>   
> -#ifdef ENABLE_DRIVER
> +#if CONFIG_IS_ENABLED(REGULATOR_RK8XX)
>   static const struct rk8xx_reg_info rk806_nldo[] = {
>   	/* nldo 1 */
>   	{  500000, 12500, RK806_NLDO_ON_VSEL(1), RK806_NLDO_SLP_VSEL(1), NA, RK806_NLDO_VSEL_MASK, 0x00, 0xe7},
> @@ -454,7 +450,7 @@ static int _buck_set_enable(struct udevice *pmic, int buck, bool enable)
>   	return ret;
>   }
>   
> -#ifdef ENABLE_DRIVER
> +#if CONFIG_IS_ENABLED(REGULATOR_RK8XX)
>   static int _buck_set_suspend_value(struct udevice *pmic, int buck, int uvolt)
>   {
>   	const struct rk8xx_reg_info *info = get_buck_reg(pmic, buck, uvolt);

I would split the modification of the c file into a separate patch as 
the addition of the symbol and the modification of the C file aren't per 
se co-dependent.

Their order wouldn't even matter in that case.

In any case, looks good to me so:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
