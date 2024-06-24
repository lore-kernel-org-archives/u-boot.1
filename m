Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB6BC2BD05
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 08:08:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEEFE87CDB;
	Mon, 24 Jun 2024 10:08:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="igygBgjq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E233288049; Mon, 24 Jun 2024 10:08:03 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2070a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::70a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5EC887572
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 10:08:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hxymg7xryUUtA5kUnZ/pndOvHZLMqAyC+j3q4knkVkeQ0oetELNO6Fpsp/WtgQoFPI9NR293XJUuzf/VNTiC+oTJeseTPR61C9x8wa0m9XRiYP8BlB6yqASU99UhOWoja74UP4kFzMCZhfCznmXXA+H1n6ynN1WFM433kzzF3Vekm8oXQvc1gL1zHGddipjg41HKjx12wrKOxnkC+lRPjcOq3Roc/dUbvb3amJueipf0DDvdg15Uxwv7aaP3+rvZQlDz5Rc/4kEaj6HmHAz5skk2BLe+g7Qm8Fm/AtCBupi4iwPWRIoZefIzhjz0H765Zop71NU5o7EhuSOY6NtVzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scBPN2y30t04LSUbznsKWbWirX0POhn2YV2kxT7cr/c=;
 b=iHTDoJHL66Y6soZkwo5GBpLDUZD/Yey8jOA9wX/g07laF+jWyku6btjElfozvLKTFcby3cnnsRes9b+olGo2pMI1TTdUcZ7J8Wh288He2Ccxm2xrczTh67f5pt0zsDlAnlBEExnDfVxijyk29yfFn5yTHamW/4L5NHd/NR5OdeYOPdeyXs5waJlUv60S6YWr7XvB7zaMM4j2zDzrzb20nYnCqibWQy49O+Ko8bR41OjV0gOu7mXMpXCDNwj9aX5m4QdY8xzSJQBowvxodRv4hReQzSkrTI8jvkzMOgvHFj4p88FE1/Ds0VUbAPT+xfxfVBaDzNide2Cj8ls/GR7GPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scBPN2y30t04LSUbznsKWbWirX0POhn2YV2kxT7cr/c=;
 b=igygBgjqmFoTTOYSxwiRf/MsJdq1rCz0rmudzXWN+Qpip5dyF6Do9SM844YQvbkf4wFbp9DYUbX6Nfhfcfq00GOKgBIFUKGzl5oWI/oXHZ2jjhIkqdDI0/r5pvea4qn3E0iQlgYPaF62s/9CLCmy12yudX5prf4aKO7ftY3x/Ck=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by PA4PR04MB8064.eurprd04.prod.outlook.com (2603:10a6:102:cf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Mon, 24 Jun
 2024 08:08:00 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 08:08:00 +0000
Message-ID: <d86c3b8c-9ee7-4b8c-adef-25fb56f29ecd@cherry.de>
Date: Mon, 24 Jun 2024 10:07:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/16] rockchip: Ensure memory size is available in
 RK3399 SPL
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 huang lin <hl@rock-chips.com>
References: <20240623175302.1463973-1-sjg@chromium.org>
 <20240623175302.1463973-14-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240623175302.1463973-14-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0247.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::20) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|PA4PR04MB8064:EE_
X-MS-Office365-Filtering-Correlation-Id: a7b54c84-57e5-4484-0d3d-08dc9424c33e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|366013|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TW1oSEMvOGtyWWVySmJDakE0M0VVSmdYUU5Nb3RFMkZ0RGRiNkQrYVJnc1Jw?=
 =?utf-8?B?cjlDTzgzTllieERmMXRBWWZIbW5aQXpBcmhXZHNlVnUrcjB5UE54RXp1bHVo?=
 =?utf-8?B?OFpwL09YUE01cUhFNmxiL2ZqRVh5d3ZUL3VBZGp4OEc4TVNVNWZzdHpqc2RJ?=
 =?utf-8?B?Q3ZvOWhPamxUbFJ3anhCZU1YTWtGWlAxZ0VwaWQ5c1FyK0FBSThEVGdkUnR0?=
 =?utf-8?B?VWJDU2lGOGgwcjFsV042ZVZETklnWjhsMWUxQTUvU2FHMmlaSHRldFZqazdz?=
 =?utf-8?B?TVVsbmVKcWptRWd5RkNJTDlLeUdBQVpGbk0zMEVkNEloc0dJQVdhN0R1bUJK?=
 =?utf-8?B?YytWdFBacm1LNklUVWJvSXdHbFlSa1dsL2tGUFJoZFdjSkFiN2ZhTXIwZCs4?=
 =?utf-8?B?bUU1eHZ2OEFpd3ZURk40dEU0QklwUU8zVHVsOVZuMFV6ejEzejJ6eFZxeEJJ?=
 =?utf-8?B?VUtEU0pGdVhla0h5VE5ZcXVOWkJ6b2p6Y3hPZTg2MVpYSGtIcHR3MFFNckFS?=
 =?utf-8?B?WUExbGMzdEpUcWEvTnRkUmZ5OS9yZ2FrbnM1clJ1ZjVDNStKRnRyUGxWdHlj?=
 =?utf-8?B?UUtubHZocDZPVWJkWjFLZEUvSTM0TW5zK1JtdDVWcVIrZ2xEZHBLSElJOXJY?=
 =?utf-8?B?VHNudHlFNmREY2d1bUE5YzA1TXN2a1lTSC9TTnd0TDBRNGNIRjFSTHJMeS9F?=
 =?utf-8?B?SjlxTkozNEY4bTBqcUI3NWFBV2E5b0FEbnJXUTBDWE9ZdWhsVkJidDM2RkVt?=
 =?utf-8?B?aWpUOERhaXVNSEhqek1hSmR0UEFLK3JVMmJaZ2MrWFR2S3BodW8ySFFnOWUw?=
 =?utf-8?B?M3R4b0thQXczZTV4L2NXTldmNHloNmYvYWxxT0VxTW5QZ1hsUUtXdVJSMXVl?=
 =?utf-8?B?VktZeTJTMkVjZDE4ZWl2a2xCUmd3ZHRhUER5bjFjbWJzV0xzVTFPSGh5Mmdu?=
 =?utf-8?B?KzZVOS9VcEwrL0YwRjRjYjB6a3BIL29neFNCYUMvaytaTncyTy9EUXZXbmEy?=
 =?utf-8?B?Z0x4Z1ZIMzZraEsrTVNrZWIzUUdscmVQMExqeFY0ZUVlMXNacDcxSUlDOHkx?=
 =?utf-8?B?R1VnaUduWnNuUzczOTVmTldRYTVxTXZIdjQ3R1M2L2ZUM0VPZDBjMmlJM2NE?=
 =?utf-8?B?UGRKenRBbThJMGNDWGFVTm1LdHplMUxCVXZ3U24wY01xeDZRa3ptd05mMEJs?=
 =?utf-8?B?WUkwV1d4SG41N3k2NjlPZTdKa0FYYS92NzhaSEt4SkhtZ29FMkpKM0tyTzVz?=
 =?utf-8?B?cVVqQTBTWmR1VmdwaDg1SlV1VGpIRUpSSlBqYkNGRXFNeE85WkhadVNrbXpQ?=
 =?utf-8?B?RndVbENYcTNaeEhKNWlieStKK3FDcWR6N3VHQnlXcFhvWHBBU1VwYlo2eXFF?=
 =?utf-8?B?MS9iYnpkakx2SDBaNzVSeS9na2p6bE81aWRObzRGRjhwVlNwSWI4TExWYkZz?=
 =?utf-8?B?NFdjZ0NxVmRyenEwMzdRb2xaNnNvaS9zSE5ZdDJ1QWJCenU2KzdxbmV6bWlr?=
 =?utf-8?B?WUYwQml5cDRDM3pvLytKVEgxSG9OUzY4N0xOSHBvWDRsVzBaWXpYTTdVajVM?=
 =?utf-8?B?Q2xVcFF1WnBKYTJMdE1vZFNBSGJ4anU0cEpUWG1BcjJRL1ZmdS9wNTBvSzFM?=
 =?utf-8?B?VHFuRGhTN2tBMXc4QkxFdWordUxZVTdSUjgxVktqTkZLdUtoWWpSbEFZVm1v?=
 =?utf-8?B?TE5PQXZnZ0k4bXNjeFRaNlpXZEdneFpNcHJrUW9SaUczL2xBckdwSVNpUHRy?=
 =?utf-8?Q?WasiiG857/46qsWZMnUUgZsx+pa6qSiJbLrM+up?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(376011)(366013)(1800799021); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEh3eFlpbE1jcGxrZ3ZibWowVjI1d3NRN3AzMnFzeGJVdGtoNUp5MkR0ZUpz?=
 =?utf-8?B?bjU0cGdNdUtUb2dkZit5K1pWMDJPRFdRUEUzU1cwUHZ3blFrRDZIRHhzTnYz?=
 =?utf-8?B?ZFVnYUNEQnBxaTFEV09NSUtnejJ1MmlYMUtnRXowT0lGekVLUDZZdk80RnpS?=
 =?utf-8?B?eGpFZytoMUZUYndYNHpVNG9PTXViZ2JhL3Y3ZGdDa3AvOFU4bzlsdXJzMzBk?=
 =?utf-8?B?R1M0L2Mwb1g5ZkZYdUZtcHB2RnJ2Wlgxdzh2UmM3NXgrQ0E4RWpWMXJFbndt?=
 =?utf-8?B?NHYzbGF6VC9BZEtjWjJNQXAyaWorVy9HWWcyUHJIN1pEaGE0M3diSkp3cW1K?=
 =?utf-8?B?QVV6Qm5tUTFoQkRueE52aklvaE5GbjZ1VFZPM0V1RjY4ZktuSmFGK3ZOcGlz?=
 =?utf-8?B?QzdZRVhWRWZ4cWhaK1lKTG5hTm1DekQzUXhXRHZhNk5OeFhhN25UU2phWE1V?=
 =?utf-8?B?L0FYWmpUNy9CbXU4czFwWFVpaDY5WjZ1c2pvdktpRm8wSWd3WWp1dXQyaXhJ?=
 =?utf-8?B?TVNRaFE1VVR1elB6N01majFaWnFrQUZUUDZITk83RnRXU0VLV2NiOTdYUWdx?=
 =?utf-8?B?amVONlg2L2U1c0lGakNpSnpnZmwxZU9LaTRxaHlPYjAzK0hsalc0cThWUS8w?=
 =?utf-8?B?dGZTV3QrMkhPbEx2eEZZUUZMelE2LzM3VzJ3RUM1MHRIM1dEVm5lMkVlZXNQ?=
 =?utf-8?B?N1ZnQWU4dFRjOUJsRHNSRXNrUlRjR3ovUzZFZm9LblVReFZsMWxSRnpwbFNa?=
 =?utf-8?B?RmkxM3g1OTRBQkVPR3kxcllwaE1pSkJJYzFYdGhKSHBzQkpyUHZqVzRYdG5s?=
 =?utf-8?B?V0pWR3J6d2JYc1F3T2tISWpubnoxY3EzOEhXU0lmNEl0ZWJvSlN3S3V6U3cv?=
 =?utf-8?B?UGZJakFGUW53dkFBczlzc1VJeHYvSTJYL1lpWXpqODZleGVzZVZVYUpTWjNU?=
 =?utf-8?B?ek02SGk2SU5mNWVqYlFmRDBabmMyVkoyT1Y1MUR5TTZHZGtMeEtMOWhZUDZH?=
 =?utf-8?B?dFA2Ym53Q2pxMEE0Qkl5UUUrZWtpUjZiN29UZlN6VnF3T000bVdWZXVyVk5x?=
 =?utf-8?B?eGdCTTlLcENjOVZIaUdhekVlT2FoODFnckVMOWRrSGZpVTRtVkxLa090OGNx?=
 =?utf-8?B?eTVTK25tb29XbTZ5dEdIdVJYd0JjME95c2xyaGE4Q3NpeUN2TUFITmRjcmZH?=
 =?utf-8?B?VkRaRDh6RU94eHNqWCtxMkM0SXpGM3hkZm9HOFNzV2svTzg2RlNFVkplSERM?=
 =?utf-8?B?UGJFM1d6MENFMStPL0xMTXh3SFA0SUdKQWRKKzdUTEVoTXBrRWgveFN6OUVM?=
 =?utf-8?B?R09qanlIaEdBTXkvS0hwd1doTHlRdy9pOERWekh2L0VUMERzK0UvczViTll2?=
 =?utf-8?B?NkY4TGhWcThFRG1HWkVzSmRrdmVYTTdQckZGcUpJYkhuaXRGRDlLVDNpbXFS?=
 =?utf-8?B?VlJNYlRPK3RKZ2g1RW8yNklYMWF3YnFnNU1oaDlCelQ2cC9BVVZScUxXWk9N?=
 =?utf-8?B?Wm9kanpLdTBBT3R3Z1VNRHJDd3Rqa0duczVIb3VxN2tQOUhOdlVtKzErWkVy?=
 =?utf-8?B?YXNBSFBGZkNId1FKVm1uMFVGOFNnNnRvRHNlREpTRk56aGRjd2lCbzhKYTlK?=
 =?utf-8?B?K0JNdCtRaktXM1lRa2VWZUQzektiRjE4T2JtMDBuWHo5V3ViY2NFYWpNMHdw?=
 =?utf-8?B?UktNdmY2eTgxUitjRC96Y0FIbkM2L2JwQXZGOGJtS1gvYUtzUWgwVjJSOXBC?=
 =?utf-8?B?WmR4RUNwbitwUEtkclB0WkZZSnRJUm44d0VPTmNJeEJ5UG1kUmVKcnFkTlh1?=
 =?utf-8?B?TTNFZUN3elVVSEUwdGY4clNDVS9XMWFzUk93OVhRNlFZKzNBUG5iYVliaCtv?=
 =?utf-8?B?aStCYkVFTVlzZmJDNjRrLzZ3WHZ6S3p2dHFWRG9XTEQram1rdGZTRTIxUzVv?=
 =?utf-8?B?c1A0WmpIeDRtZ3VKL2RXWllJQ0xlMk15TEpJWjVzSjNjUzdNbG1laGVGWWpX?=
 =?utf-8?B?ZldQdGVOOEI0cTVPL2lNbkZoemhJN0dEYVkvMVFuT2tneGRSUmdsK0ZKaEVm?=
 =?utf-8?B?cjA0N2VJZ3pOelB6MmdIT3Z0bGVvMGt0b1NJRTMvczFVT2hUcjVZZlJMRDRm?=
 =?utf-8?B?NFFhbS85a1NBMVdSVHU5RlM1ckprK2pTUHVoS0dZQnZLbHVtODNueTZ1dDhF?=
 =?utf-8?B?akE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b54c84-57e5-4484-0d3d-08dc9424c33e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 08:07:59.7363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e3yaAq/vRj8KmnbiewJkqyU63yKCBFImLPJ0a3fdssfN6ssjgNa6bWfPon3VpbixqkKW6qFlljRoTh5eTsSBGca9vi35D1sWP4ObFeoVQoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8064
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

Hi Simon,

On 6/23/24 7:52 PM, Simon Glass wrote:
> At present gd->ram_size is 0 in SPL, meaning that it is not possible to
> enable the cache. Correct this by always populating the RAM size
> correctly.
> 
> This increases code size by about 500 bytes in SPL, since it must call
> the rather large rockchip_sdram_size() function.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
