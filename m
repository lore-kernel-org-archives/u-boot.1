Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83ADC54E67
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 13:49:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9B8487F5D;
	Thu, 14 Mar 2024 14:49:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="eOWuQxXe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D8DA87F6E; Thu, 14 Mar 2024 14:49:51 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F38F987F40
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 14:49:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LUlQp4SYoGIQvHH11vsY0z1MxKNhy9SS0JPD5FC1gORuCeUzxE9AO5CDgP7XE67GzFB8kRaA4YuCm8wfAV+8/zs/YsXhMiQSlnlQk2GcdK4lmRIG2ZXzsyw0x3QQWM7Pk4uGfXVFPraTpLPsfbhI/ZSUul3K/6isGChZdMHvq87ZPxOkwO1F/gEqw+827MBQOL7atOHw+YJSagerWWuTrTaPw4ANnCefR7JAEnqO3c2jIsXOtzoXNjxjqWf/ISu3l/nFBYyEJArSFXBVU7YT1OFL8ZUPwlw2m92vcMDHACaqAoO2bUcZ4IsQI2OCPEbW/lz9iqb7y2e2+QCZw1jk9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6l7kXhtoWzm742IW4QETjIPhpt9etUNpA7MGFPZlyM=;
 b=NavxggWFT0F7xsUdfjj55VdwMz5EA7uZN8XrGJgfK4vFgOaoo0DgIr405qQ4oHDqooGsPbDXJ1l5fdSD3J+wNuBg/rDAmxFg5llAeijs3gFpbQRUHt9eA0G1N/KGMiL66YQ9p76b8eCVko5nQ6jzSLZgKrCDSLuybZx2Z3OASGoGtqXlHoPcsfjDbQpPl1f6MxFbUwRA5IqeF3qnGVNcNEfmwTec6Xne2potIOJJpKXO2J2irr1FRrjUtzlpaRyG1PHTy015azSZKgormp15vXrk439jltDFtph6rHAYCR/1e3pozQbhc8RKmzv8k/4kxyjT+RArKGrndIIoMddozQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6l7kXhtoWzm742IW4QETjIPhpt9etUNpA7MGFPZlyM=;
 b=eOWuQxXeH/p2y8BwIz76a28yUNQNGogvCfGm6a/cv96JHofqwY2/Qqpwyf5L2mK/4GPSKRTWtcv3WnKTPoKMpp+3peK+5r4M6ZPPq168I6OC16tm9zq1taPqvT/l/pU2t37MOJFjTdA6TFxeXU3UkPBfhF48nqpimuAwdAqQbTuHB+Lskf13tMQZvhbtPoRyQDTJETUVl3MHOJQAQXfK9T2ZHuP2QQFs2jZ7sRwMsVa75+j/TL1v6OTFEJs7gBTnHJQ04qDLLUGpFlQ7FRS1m+Sts03W1UdgRldfAFmlgfKHsUCv2ohidQHbePjKzhgAUDMSmbbUg4oNBZmiwWc4jA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AM9PR04MB8828.eurprd04.prod.outlook.com (2603:10a6:20b:40b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Thu, 14 Mar
 2024 13:49:46 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::23:4118:ae4a:8dda]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::23:4118:ae4a:8dda%5]) with mapi id 15.20.7362.031; Thu, 14 Mar 2024
 13:49:46 +0000
Message-ID: <6d46cfd9-ee3b-4f8f-a8b9-c8fd306131a7@theobroma-systems.com>
Date: Thu, 14 Mar 2024 14:49:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] rockchip: spl-boot-order: show DT path for missing
 device
Content-Language: en-US
To: Christopher Obbard <chris.obbard@collabora.com>, u-boot@lists.denx.de
Cc: kernel@collabora.com, Dragan Simic <dsimic@manjaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20240314115801.241575-1-chris.obbard@collabora.com>
 <20240314115801.241575-3-chris.obbard@collabora.com>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240314115801.241575-3-chris.obbard@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0127.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::13) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AM9PR04MB8828:EE_
X-MS-Office365-Filtering-Correlation-Id: d76ba016-0172-488f-7289-08dc442d9c0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aQQe7feVARbDAOQS9DjcGmLgem2oLo6Xjl0rwfdnNZP6tJXxQk8Juj2R4vbLW+1eq+LEvZSDGNip6CFxF7PQqBBMudPwHvVMYLcg0m7Dls0hF6ekZPAPWUodhgKTMu8j9jX6NRjM3EsG+TzJVHYH/ktf2PAFWxlp6ztToh94E98+ha160eZ93X7OCAV19etoYDW7Y92yP6j6WdB7RSJsx448SbpxNIvAAEUgd4Am2pxJ20qNnYhMoYFo7VEQXEv9cjZFKdU4VxMTrYwf3FH6BkcnsgnrRISaR1aHviGJKIj4QT+p/RAnwvGmhSzxCKLcBqEjmnXrGRC+8EGgdHxAJgNbOFMaGjtTJnl/m29bZOgvl89zACLUvrTl8NVpoqeBoWc5bhJtAPXwGcxl+RulLmdSWzUrU6K2mLkjW5u5qReJgpbVNol4Z9y2FOisrWldyPbaVZPio1FVPcDo18DwngGoXAmzfxnMr3OzOqwnbZ6anIcvF4SQaoQ0SKMO45TzEnowgKyT1Bl5BW+oUGiVlm8fzVLqtTHwD0pPwppsDcl+FpXjwNiPdlWAYdm48kFG4E2Wi9e/76GhktdcKGqHqci+mj+H5Jgj7wRHJaG96W1uIclNpzDDmr6SbN9bIx4grnlc7czRRE5DHBGLVxVJ60qSRxMWd0I/3rfKW39P5GY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTc0bEorSjc0amJtdjc4bWRUNW5SUGJtSUh6S1NiQ1lWV2Njc1NUdWFWOVhR?=
 =?utf-8?B?bitzcTRPL0Niem50U01SQ3Eyc2IrY2l1WTExQjJCVitSYnhpU0haS0tZQmd6?=
 =?utf-8?B?bFB5bjJ3aGdVVTZseFpJVEcyYmR0TUs0UWtDNFdjNVBwV2FmR3NNWG50RGpL?=
 =?utf-8?B?U2lHKytLOUwyN09BY1RSQ2h4b2dHcFJaK0xtQk4wMG9XNjlOcjBoZkFKTjRK?=
 =?utf-8?B?TVFzRTA1MzBUL2VXY2VCUnVLWDRZTHBrL0FPNjBqSmIxVVgxYVFmakJlOHVr?=
 =?utf-8?B?Y2hEWldZZVg3cXRYWW9wb0I0L09aZVB4bkhqVE5PUnJWL0locUw5UlNoRi9x?=
 =?utf-8?B?b3BBVjNhTHFkcVZWdWJHNlMvY3dxM1lkendPU2dCT2d4S1paQW1lZWJxZlBr?=
 =?utf-8?B?OUxrdjRBSWRla2M1cTNZaU1VZ0wwcFdLK3FGM1ZjbU93MmFiVS80QXpnMVRK?=
 =?utf-8?B?cElDMGtJWkFsSnhOODJpL25kdVhjWTk3cDYvWXFnSUZUN2p1QUJYMUdyYkdX?=
 =?utf-8?B?d0FucmRwNFRwb1Jya3RCSkdDRG82bkExWWNNSFozejJGNWtDL3NzaXZrdExT?=
 =?utf-8?B?MmRDNWVFb0htV3JJYzUxem9Ldi9yM25IM1dFUmE3dWw4dVUyblBkZjhmWG9r?=
 =?utf-8?B?OUdtc3RKMEVHMmJsdGtSWHc1dCtuNmYva2FBc1VBVjR1TXg2Tmh1czQ0K2E3?=
 =?utf-8?B?UTZCMU9Cckw1QU4rdGFrODlNVXZSSDVsK2p5TU1Nbk9IWnNaU1JrUmM4MTFx?=
 =?utf-8?B?VnVVZmcwbVo1dG5vRjIxQzZIY0VrQllqa1FnVjV4aVlLOGFPU0VlYWxCSzdT?=
 =?utf-8?B?WEYrMmw1QWFqcjZzTVBvekYvdUpRQW1kQU5zMnAzbUVnYnNwVkJzQlpvUFFK?=
 =?utf-8?B?K3lOV1lSa3B3cWMyelM3NjZGbGJTdXJKS1ZLLzEyZEpqYTFDVStXdjZpb0g3?=
 =?utf-8?B?UnhzM1B5azQxL3JhaEFmKzlWU25KZDB0WkJlbkk1RlRkNU5XY2pTUGJpNjUy?=
 =?utf-8?B?Zkx5MFc3b0M2YVZ5aE0zU0RrdWhvNHVzVHpnN2ZaQ3N1RXRhQXgrT1JIeWdJ?=
 =?utf-8?B?MWN5SXNyZERnWW9Fd0ZKVGQrcEZ2bVZpMHhMeWRYa3AxMCs2SlVlUE9HVW1N?=
 =?utf-8?B?eXR4VFJJY2pZK0lseFlEZGpCSTB3RnpkVGZxQmdJeVYwVHY0VE42V0pmQkhz?=
 =?utf-8?B?MXM0WWlIT2pZWnhiZW41KzRRRHVlb3paODVFTXpFcmVmbzNXalpwRTExcUV4?=
 =?utf-8?B?UUxKNW9LVjRYLzM1TzZoU2htR1JxVllpTitmOTUzYkhLSzA0ODZMNHdyNFp2?=
 =?utf-8?B?OGVwcVVTc2t0T01mbE5jbW85OHJuSStDQy9ZTmNWUWgzMkp0Lzc3OGdzblFz?=
 =?utf-8?B?TE52NW9tV3NTQ1ZWMVE0WHBLRlorUEhIWk11bXlUb0tQMzArZ244dTcwSlQy?=
 =?utf-8?B?VWIzYVBmMEwrb0lsc2MyV0szRElyaERVcjhXdEljTzVUdjg0OFJxd1dCc1l0?=
 =?utf-8?B?K2d4cnJUWldCZUN5aUZic0FoUEVLMS9VbUhaMmlaZHA0ZmkrcjIwN1VlMFdV?=
 =?utf-8?B?aHYrbnY4clZhNzNUbVJlQTAzZTZHblY2MkQvNXZaYkFHUXJicWUyNVk1VE1v?=
 =?utf-8?B?MFc4YUJlWHpsQ1BoeWhidVhHVkFJM29lcVorcUw1R09LSWRwd28ySGV3T3dV?=
 =?utf-8?B?WURwSTk5V1ZvNkJEVXluVUZKZVNLaUxtTFRobVRvZWw5QmUyMXFkRlRxdXE2?=
 =?utf-8?B?b2tWaHpjSnliemdNUmtCQjdCa001Uk9GNGpoR3lTNzNnSDAwVDVRTm9ybkhz?=
 =?utf-8?B?RXVYNnNwUzRjUi9lZldtSnF3MFd6WEtJdWZ4WHpVL1BGUWc4d2ptQkl1TjJM?=
 =?utf-8?B?aTFsWE85cUNXU2lsK2wyWWN3M3ZrZllpeXY3bllEbm5rcWtzYWVFM25vckx3?=
 =?utf-8?B?NloyKzF5ZVVEdVBuOXJzVTZ1WWZydi9pK29RemVEVUp2akRQUjV5OHZFelFo?=
 =?utf-8?B?OHBVUHpiNTdxUnQ1amppejRPZ2Q3T1FOb1hwR292eVVvWHBLQWg5WTY0aVcz?=
 =?utf-8?B?QlZTYm9FZzNCYy90UG5zQUNITHlYTFlSZGd1aWxETTRXMloyemtCbnY5Sll6?=
 =?utf-8?B?WDVGUUJic1EvQVYweEVMOThXWkdGdHJlc2xXbDk4RmJTbFNudkttQUJzMG9n?=
 =?utf-8?B?Ri82TTBvZDFuSGk3WHVnTlhvUWlXby9IcEJYVnR2MG8yMUdSUUxsb2NIMFF0?=
 =?utf-8?B?R3hVdlQ0M05wOUVVYStWRitHc3F3PT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d76ba016-0172-488f-7289-08dc442d9c0d
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 13:49:46.3531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vdtliLtAxH4HNPZVy2iAutTXKr3IT1slLW0+vMeB5ihf3jOKKdj1Myyy00qbNPVO6tuucef072NZA1VPxepNujtjow3Nl3nLPy2Io1afii0rMiTOIydBtk4oocGe0c0O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8828
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

Hi Christopher,

On 3/14/24 12:57, Christopher Obbard wrote:
> When debugging the SPL boot order, the node ID of a device which hasn't
> been found is printed but it can be quite hard to relate that to the
> specific devicetree node. To aid debugging, print the node path instead of
> the cryptic node ID.
> 
> Original debug message:
> 
>      board_boot_order: could not map node @73c to a boot-device
> 
> With this patch applied this becomes e.g:
> 
>     board_boot_order: could not map node /spi@ff1d0000/flash@0 to a boot-device
> 
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
> Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>

Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Thanks,
Quentin
