Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E22FC54798
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 10:11:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8989F8801D;
	Tue,  5 Mar 2024 11:11:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="LIb8bEzn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DA0888020; Tue,  5 Mar 2024 11:11:23 +0100 (CET)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0710.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::710])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8247C88015
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 11:11:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z00CtbKdLO9CeAJU1DEDIK6t0bES5Lon0CQOkco7M25EPpDNBlP9ZUmJ4IIzZDtZgze3BzvXySSSgCZeDtv9cSy2ksx4yazPJBYIqjaudA6RpfGKHQeyn3XSjkiYkNJ0SbK5avA8mHNtgJH/TTM121bTRYGbRIUu1Boiodt16bXKmeRs1y2otDhAhO4kn7TkShjTOdaW9EJqiGNGrOFCFwMrcoONbwVmjVSg3a7y1xFU3ZGjByIF9pJU38EubRvinGVLvR60IveJho5JlmydhgZvibHNCIKDto/XNUSc0lXgKYQSTspbzFT5tIkvi0oEgJ+a6aO4krmyHLYAMh+9eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CP+p4gUA2k8xUeNGCLjmeRDh4ikDzdEP6kp7vgvR5QQ=;
 b=YR2Fr/TElLQ3dDt26oD01AFjUCskxi9EPzGkaqe8Ds5tamRr68uOhy/b31dYh/f5iBRCC5ttrR4NotZ0NJso3WxWoaGz3DNIZJPnkSZ93qui/MJx1BSMbvbhBjPT/IWcFcId64RDQLDbpg0mugDbmh+Q4qVfa7HzB4GRDr6R+NoZHRl/5vjk/kAy3Jz1seLsqoW9yPbDQgXgfLc/yQmkXDD8EP7v7XaYEBuonVPIAZrnWlM8i4A9scGsSfbIL8KAyunhU2+/6yHJ4V4r8afYlC53OueciWSiwEbJBsYXs0ITwistBwxaahwZQWj0og5f6z8EgS1C2pt78VhFS6Cv4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CP+p4gUA2k8xUeNGCLjmeRDh4ikDzdEP6kp7vgvR5QQ=;
 b=LIb8bEznOv9x88tn5WlUBBmOF98LbUZnkhes1KO6TwV2EQPuqiLs242qfig0wMayxPypz7po9IZmTCwjR19/R0lzIldY37QcP9oHrZMCfaTKzmX8zMJy9QGbvvB0DwQM93il5DJGP2o+oZdE64DBy3GTUsZclkwWZLFeM8Xc5Wp5MKkLt6wg6jkG/yBTDNpjPJVOV3kTKjuttMeEwbhQJrjsyuG34WGJQc6IiIqaS7eV6NVJpyI9eJyaM2qMcRtarCTUC+uB4olJrGui1fmAUa0BsS2P9RN040L9ZsSVboqcFiBAoFXMnY+G4NjODpdSxpHbJLq3AiMbKu+1uCmd5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by VI0PR04MB10212.eurprd04.prod.outlook.com (2603:10a6:800:243::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 10:11:16 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::23:4118:ae4a:8dda]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::23:4118:ae4a:8dda%5]) with mapi id 15.20.7339.033; Tue, 5 Mar 2024
 10:11:15 +0000
Message-ID: <3bfd0ec1-6fc0-4792-b71a-700684e6695c@theobroma-systems.com>
Date: Tue, 5 Mar 2024 11:11:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: rockchip: rock5b: enable environment
Content-Language: en-US
To: Christopher Obbard <chris.obbard@collabora.com>,
 Jonas Karlman <jonas@kwiboo.se>, Trevor Woerner <twoerner@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Eugen Hristev <eugen.hristev@collabora.com>, Tom Rini <trini@konsulko.com>,
 Kever Yang <kever.yang@rock-chips.com>
References: <20240305021051.22405-1-twoerner@gmail.com>
 <20240305021051.22405-4-twoerner@gmail.com>
 <48a3680a-2e33-4c2f-b564-68fd13a4e064@kwiboo.se>
 <c0785fe90bc1128140480f7812cf6facbf6e637c.camel@collabora.com>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <c0785fe90bc1128140480f7812cf6facbf6e637c.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZRAP278CA0012.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::22) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|VI0PR04MB10212:EE_
X-MS-Office365-Filtering-Correlation-Id: d3a75026-76a0-4041-6202-08dc3cfc97df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GJxdQe4udNX+2Cq0QcFpKZ313Qqx8tveZyex9ThMOr1IiEGMGVzF+iOXywoZOKFd8c2huu/gtZDDAZqNUlXs5jUlz9+fKZLD3yE/qyzXfHkFOTElvvQNzwMoXEeTJI4NfJK59Iuf8uWBll6iys969NCMmN+5jVT+4t6eRbIc5clEvZ+1MpRGNbG7rCE0k5iEb1IAb7qNPAX0YhIxGAI4gtfOb4PJKJaiKR1glGmvOfHiEgxFwmQvifR0en6bH445jpiDMbHXW+SI4/78pbupJPAwGJCQl0ntueepnarXrWYJEHc20dFgPFtZNdqrNXRdeHhUT7qC/bjRn3qdoJwNe8K9o5NK1thukYDGxYkYW/HcN46jduxFeVggZq0MCzaouOHogBr5EY3vp5Zl+d2kqjtvw4qC2KiyklUYCE0eR50leuicSJd/Mq3EjqSOr4CX5K55q8OjKfI7FFL3drCFJ9OunBm6JzflKK2covOSs2yWguzpYVaP5zPNQWRKlD8t83J7O8Uv1Fr5OV7hlaVZUjIAVrLYVTeYXXAbw0OdZsGvupEBUQsqkzAPytRhSeay65ZKOHSbX3Tu91/H7e97tn+9tiGicAql5/zByXKVxlo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3hBYS8ycktYWGwzNDZXc1U5UWZ0emFBZEFoNGlNVUcweGhkaXc2UlJaWnVB?=
 =?utf-8?B?TjAvTUlIR2JZMlpTK1d1SmNsUnppSld2bEJwWGw4Ynpwd0cvVHVtWGhKNFRi?=
 =?utf-8?B?SUpNcDNCZThwVklGYk5SK2RRbVlvak51RFRpVVl6a3dKS1ZJUTcydnhwVVhF?=
 =?utf-8?B?eHRuOVBMekNPeW1CcERkNzhIRkxqQ0hmNjZLUVhKZXEvWlpOOENyciszOGhn?=
 =?utf-8?B?Tm5HUjJDdlR1QmhBOE5TbGxhaWV2RUZjNWNMcFlXcG9xYzhrWm90S3BETTVQ?=
 =?utf-8?B?MmdiTzFsUkptYmMvakRDRW8xZmZYcmpiWGZyakRVaFZBODUzNTZnakhzemFk?=
 =?utf-8?B?dmtDbmVUUVVURGNUZXd4QThBdFMvWEh3WWFuWDBDbVdrclZwUC9VeURHYUxQ?=
 =?utf-8?B?Q05SQUdDSmExaU5wRDhCZnJIMFVoVnRmcXZqL0NjMk1NYnExRndVanVaNWV5?=
 =?utf-8?B?OVgwbFRsQjE5aDdoRDNiQkVrSjNpNnZnUXZYYVhOL1hVcXFORU9maVQzblVB?=
 =?utf-8?B?QSt3UXUyMkM0amlieWxBQjJiTXpRbm9Melp2WTFySmVyMUV5UXREc3EwbG1C?=
 =?utf-8?B?RkNaRkIyNWd4QzZxbWJkMTJIZ0tGMWhyb3I1WWRCcUtYZ1Y1anlIYzZ3MS8y?=
 =?utf-8?B?Ty9QQU1tYmk4SzVmVWtKNmJGLzAxaDVCdm5RTWI1Vml2VXpMMGdvT1dMOUNa?=
 =?utf-8?B?OEJGZVRDajk1OGRMek4zaU14UGd2bWdRSnMzNUEwVm8zZDZUb3hidTd6eWhl?=
 =?utf-8?B?SDFnd3FqY3kzeHRIdXNKWnFMVFVqZWF1R0xsSCtNWlJzVVFnZndEeHgwS0Vs?=
 =?utf-8?B?c3prWDhpNGxHNlFwOEhGbFFPelowSXY0SW9vdHI0Wi9kaVBIai9zS2JBUGI3?=
 =?utf-8?B?N2dKcy9YOXFIckVHRGVWdWZhKzdrejZ0Z0NlbGt1THVpSERlRmZMbDZNYWZj?=
 =?utf-8?B?REpKSXBTUm1UbDFLZVF0TEVOSjZCdmh2RDJhS09NQ0tGa1VCWW9JMjN1OGRl?=
 =?utf-8?B?aktHbUJ6WW43M0RtZGJCNjY2REw0bmoveXhtcmFrcjJMbG1DNnJmcWtvdXc1?=
 =?utf-8?B?S0g5WXEwYVZpcy9CR1NKZjRDM1FYSmZlSmhpSEdzVk1QVnJObktwQm5mZVVm?=
 =?utf-8?B?Q2h2c0NPTmJvZ1JsSDllK3BtdDdWMGhmZGp4RnZiNE1iKzFENG91Z0VtVkNF?=
 =?utf-8?B?UjRXZEc4anZ0QTNRdFQ5eFNrblpaRnJ6aVZRQ1pRUEhTdDBsdlV2OWRuQitn?=
 =?utf-8?B?VDM1aWNINHBzWk5SeGI5M0lYSGRXMU5ia3cxd2E0RWRVLzA1VlE1TWVhNldZ?=
 =?utf-8?B?MlV4T1ZuUW5LTzVUei82TnBCdFhqNTZzc0hVQXhKUEM5R3JqYmpNUEt2a1NX?=
 =?utf-8?B?a2R5eWxSeTdIMnZqY28wbFFRdlNCLytacm9GckcwRkx4SXoxbUVvQVdaUWUw?=
 =?utf-8?B?bld3WjZWNUFiRlYwWnV1VXkyTURSeTJua2I1T2FyUXZ6c0lHaVhZWjk0cUla?=
 =?utf-8?B?UWNiTHBCWklkKzdla3lNQjZxVWpHcTMySUlLYU0vRkNIMXIzK1BPbTVyZEEv?=
 =?utf-8?B?T3NHODN6UmhTSHhIZmhxblU1N0pNZ094V2ZFam95cklBOW9EeVA3R1RMc2J2?=
 =?utf-8?B?SmJNcysyYyt1cEx4cDhmLzRJcVh3L2w0dGU4TkVZSDRYRFBpOHNDVjJESDhF?=
 =?utf-8?B?MUtnUlNYQ1JDNjZFMTMzUDBkQTdmNU56UEhoL0FURVoxZjhyaS9pQmFnUXJt?=
 =?utf-8?B?K0NTWURtZjhnWVN5QkczRFVYcXh4T1YwTVd4U2xjSzJWSlpBRUY5UklUdmxv?=
 =?utf-8?B?akhwNVYybHljSFlqMlE3ckdzTmZVVGwrNlVteVgxT2dPL1NoYjVaSmwzZVZY?=
 =?utf-8?B?OUN2TEN3ZisvUnQvbkNZcWpCSHd2L2dzN3BWWVM2MUlMbEFqZlRFZzl1TjdL?=
 =?utf-8?B?Zkw3RHJSWHZqRSsyc1JUSmFyS1ZqVGNiZkRpSHVBSVZ1bVM5SVQ3Tm1hVW5r?=
 =?utf-8?B?bXpYaFM5NWk5WHRhdTN1R2VVK1djZkY4ZlN0S1NBNWFudElvSHpCcS9QaGcr?=
 =?utf-8?B?dU5CR2hUZVdROU03K3ByM3FMN1loNVowMVN1QWtwbXhXMVI2NDhKN2tiUTRP?=
 =?utf-8?B?V3Z5ZUV0cHdVdlFQN2hsakU1Y1U2N2Z3a1haZitYNVhkblpWYTNXclRsdUpC?=
 =?utf-8?Q?576xEm3OSueW7mhjd0QhinA=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a75026-76a0-4041-6202-08dc3cfc97df
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 10:11:15.8510 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YgXVLUV/Rq/nS0SyRq1rb8V0LPU45kFzBrWYWDgjykwJNywhsZmcyZi3AqrtUPyH16VQZN51ZxRefSZ+yMEbdllBmS6qfKaFLKyL1uW7nJXN4rC3rSpuqcR1wMRGxhJO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10212
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

Hi all,

On 3/5/24 10:36, Christopher Obbard wrote:
> [You don't often get email from chris.obbard@collabora.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hi Jonas & Trevor,
> 
> On Tue, 2024-03-05 at 10:31 +0100, Jonas Karlman wrote:
>> Hi Trevor,
>>
>> On 2024-03-05 03:10, Trevor Woerner wrote:
>>> Following the pattern of other Rockchip devices, enable the U-Boot
>>> environment to be stored in MMC. This patch specifically assumes the
>>> environment will be stored on the SDcard.
>>
>> This board has SPI flash, so storing env in SPI flash is probably a
>> better default.
> 
> I agree with that.
> 
>> However, preferably the env should be stored/loaded from
>> the same device that TPL/SPL was loaded from.
> 
> Do you know if there is some mechanism in U-Boot to do this already ?
> 

We do this for our Theobroma boards, though we use the same device that 
U-Boot proper was loaded from, and not the one that TPL+SPL was loaded 
from but the logic could be more or less the same.

https://source.denx.de/u-boot/u-boot/-/blob/master/board/theobroma-systems/common/common.c?ref_type=heads#L92-L152

is what you need. The first function is to differentiate between SD card 
and eMMC, the second actually returns the **kind** of medium the 
environment is stored on (so MMC or SPI-flash for Theobroma boards).

Instead of 
https://source.denx.de/u-boot/u-boot/-/blob/master/board/theobroma-systems/common/common.c?ref_type=heads#L94-L95 
you probably want to use board_spl_was_booted_from().

Note that to you need the MMC and SPI controllers to be bound in U-Boot 
proper **before relocation** for this to work. c.f. 
https://lore.kernel.org/u-boot/20240221-jaguar-v3-15-1f256a82201b@theobroma-systems.com/

> It could be useful to enable autodetection on many boards which can boot U-
> Boot from either SPI flash / eMMC / SD card.
> 

There's been an attempt recently:

https://lore.kernel.org/u-boot/20240226011413.435713-2-benwolsieffer@gmail.com/

though only for the MMC part of the equation.

Cheers,
Quentin
