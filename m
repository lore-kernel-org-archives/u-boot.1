Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 188B6C48BEB
	for <u-boot@archiver.kernel.org>; Thu, 22 Feb 2024 09:28:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5178C87E13;
	Thu, 22 Feb 2024 10:28:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="gaAosxe2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D205688072; Thu, 22 Feb 2024 10:28:15 +0100 (CET)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on071b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::71b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83ED287C83
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 10:28:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9Wt6mmgpBVV9f5GgFag8XBWJg5vzONrTWR/EMbtRhoV1bK/EUxi4RPHoc8JIv1tw80Os9h4uV2v7wtSVomOVVEmSHe2HpGCRiyOw6AeQ0dAXALjUfe9Wu3XkOVNQL21Tpt6UQ5XdQgv8KaAoEtQa93n5OXuaPG+QMCWiYb9OmBen/smn2XwtTSH/J6Yvxa7v2cUzaxhceunavfsT58Picma8iDUesBjNhrbQ5rRw00WhoDZmjT3yXJC/GG6oEcHjs9KuLu2uw5ASyZetMujjUNm6+CjyV71F1cZUs0mSMb1uVOASfP+KCmc/wqMXuuET/iiIORZ3Lp3sf6odak0Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovJuCo/YgROcXxu/BuOkPHMxzSeWNhOq/66pIlR3T/Q=;
 b=UzdkfCflSsQACV1mC2dRZsMtM3Qx0y5dGNzp3rppOKgfGFYN6ji6bzBhB+z9Etz2eLrGh4RU/gQyz2Zn5MPA73hnSl2PZkDt6ZY9YK+oQhWaTTPZ612EBApYs7KbrdhMy77YCuqiLnHurU3m4ascEgmFqHv2OBR34y/VjIthnoFctHbpyWM+YCib8phXh8m3l+7waA7RRzrHegYHhWw6JvnY+oS8aGZGGelrRbN7EYsLdY+ljD7syYUzcjDjuE00jOZqW793K1aaw/gcoAoGij6SNWelvDDeq9Ew9FXSS427Wr4DfwMWIdm11P7hb7Wg4qo4Mk4iltJJgoxkk2BjKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovJuCo/YgROcXxu/BuOkPHMxzSeWNhOq/66pIlR3T/Q=;
 b=gaAosxe2C9NmhB3WQcZRciW+JXd0Ovxs+icbE8NIYiRbfeRptyfSWpb6LM1f1TdUFQ/72uagk0HM9uE4E8PDeogsNBVPIldIbJZRe6zAbA766eVGDZvV7dUbS3tScFRJqgGuCtCMkyA9DHX1cevAKwMdat9dQbQct+I5tLX3KHlEYlydnb/LwZzixFz261ZAgeuxUoAwA2h+0AItfoooZ4AA/z7SH4Zcgsz6Q2c5YulV4PRqNjzuph+pAagBp05/jVfajtiJL5DW69GtoMqBEAlyVJZ6awbvRyVdZull/xkw7ogR8XiNZDYLyQ8uxQ3vhrbDGk4XZ/giTQMLAJhr7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Thu, 22 Feb
 2024 09:28:09 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e%5]) with mapi id 15.20.7316.023; Thu, 22 Feb 2024
 09:28:09 +0000
Message-ID: <7613ea71-663b-459c-9450-710731c74de3@theobroma-systems.com>
Date: Thu, 22 Feb 2024 10:28:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] rockchip: io-domain: Add support for RK3399
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240217183610.2621132-1-jonas@kwiboo.se>
 <20240217183610.2621132-6-jonas@kwiboo.se>
 <f00195b3-b410-4e1b-ab56-c448e8f530cc@theobroma-systems.com>
 <5c6e6525-fc93-4a5a-b3bb-f5f6b5341ef3@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <5c6e6525-fc93-4a5a-b3bb-f5f6b5341ef3@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR0P281CA0169.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::11) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|PAXPR04MB8253:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e64371b-97a2-45ea-47da-08dc33889540
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i8IwNGgEhaS/o1GpC8/Npmqq8N4WLfeFVzia54iJHxKtU5lqr7lQXsvAac/uP4Nl3hnIgouxr0/DggRX84MGkGEeW63tuliYm9IpmyeENEHbPjyh3JBlqFsioM6bht3K5Run2nU5IoGpwN9rl+NpVcaOkFCtQJTt7y0nVK9EIRenw9h+nmoWBlVoZwxIxbOgMdLFg6dN5+a6HL5Bl992NG9+3iiDnGClLKcL0AyLLYm2j7MScbsG5Njj2/R7tRrr9wurDCLadPIii/Zp2nti3n8Wq0Y/86kZD7xq6IZpE2Q7zUOwOyb/uZpsNgtRBj4tZlA4AG4KzdxMHAYihksdPQJhU4Y4Ri5/qFRwMmS5MKSUlRwaALTKE2Ijl/ukt1ThZ8gvyTD49TIXXa/quCfTr3wKKUKDAIq6aeDwLKuRV3AkeQ2fUNUenGjD4c/C+NhxI9SOclxQfIGXYt2Zsb+mDK+YOQ4+C6RbHbCpmOy358OaB5Dide6DqKqh8yko73iSWxneUzR3Su83a1+lZc0BhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDF3QWo2TXVaOVRLQkliTWRTQzdvZGE4VkcxNzEvTG5hdUcvbU1IS2VNYTY0?=
 =?utf-8?B?aVp5MlJsT2UrSTQ2WFk2ci9XbE1WVWlodDVleURWUWdUR1JkMUVVZUhKbWNN?=
 =?utf-8?B?ODJQRXk1SCtBd0pBWlpLaTFRTjBoanJZTzdvTWwzeCtLTGhuaFZyYTBJNlFH?=
 =?utf-8?B?c0xZMGVBZVBIT3pZSGdQVnFCZEJsNnhGMmo5bmNHbExqekxHMWMyTDFJcVFz?=
 =?utf-8?B?NGxjcWRVWDJPOG5UZnREM1ZoM3ZXQXR5TzdJbnkwQXVIbjRKSFlOeTBYNmJz?=
 =?utf-8?B?U0NkWlp0WUFTczVWdXRpaFMzTVNFbHh3Y1FNZnRpQm9tYzl3RUk4ZitHb3Z4?=
 =?utf-8?B?U3dZU3kvajNHTDlRTjhKR3Y5SHY5b2taM3JaQ2t3bWRxSVhCcFdtUXNyVHpw?=
 =?utf-8?B?RmNERFEvUCthLzlsWG9Pd1dOZEhSMVN1NzNRM2kwa2dsUDM5RUpLbHZoa05t?=
 =?utf-8?B?ZHB1dDVwYVEyV3lXYnZKVzA4WE01c1VJdTdycTVQNm5YaWZGd3o4ZTJxUTZq?=
 =?utf-8?B?SnRYeHVYYU04OTE3bUVjOXdCclFpUHVhcEYvNVRwek5YNkZjc0lyK0kxWUc2?=
 =?utf-8?B?bnQrYll5dWZKcHIrc0w4SVlyUnB6aVEvWldoT0FHVkZZV2dlb2l5OGZsTlNp?=
 =?utf-8?B?YVZKZWpORUt6M1VOUEl6UlExNWFFekdaOXY2YjA0dkV1aHR3bG04NXAvSHA3?=
 =?utf-8?B?Ujg2WHRjRi92SSszazJKVkZ4czc4ZFJQbWNjOVAydGlkdm5BRDErQUZaM3ZX?=
 =?utf-8?B?anFDdm5wSEh6RndHZEtLVnRGMHpXZzdYM2RuOFpQNGI3ZTFFblFRejE3QVZU?=
 =?utf-8?B?SnBkMzRNVlpCU2dsVHAzMGlSL0tDeGcwUU4yL0IvVityYzg4UVJJRzhtT0xN?=
 =?utf-8?B?Qmk4WDlBQnFuSk5NRUZtNU5VTzZFdzdvdTJ5VWtQQmJrRnJOVVRFbjI5R0NH?=
 =?utf-8?B?MTU1WDRKSWJmOHJWWVdkS0ozWlZxSlc2d1J4bG0yZDBMajFVWW1rWjM3eU1W?=
 =?utf-8?B?L2hhcHNVN3NxbjFyN1BnUm01K1dZQ2M2M0FORmpHREdXVmtGaXAyRFhRY1Nn?=
 =?utf-8?B?dEpJNGZsOU1JVUd6cjJ1OGN0K25KNUVaVm1KVWcwWGc3bDlIeG9qaXpoTWVp?=
 =?utf-8?B?N1dmSE0yc1RINVcrbGhKc0JQZk9mRWtXMVc4Q1BNME15aHdHRVAvb3d2M0Vh?=
 =?utf-8?B?T09vRUR6Rkg0WVV6RTBuQkFsaEpxM1hLeEVoam1tWk9ZQXl5MERubTk1emI2?=
 =?utf-8?B?bWdYVElXOHdnYSs5KzFuNS84dE0zZSsrUFBrZGJyWlZRYlMyZW5HdXZYeHpH?=
 =?utf-8?B?bFhIb2d3em1NMUI3OUhCQk9DamRBbHlUMGl0cHBjS2tHdERCRy9xcWt3M2Fk?=
 =?utf-8?B?NDZ6SjZ5ZGRKczVtSk1hTU1HMVlxK2loYzRPRGJ6RTc0UUNOYnlqRnVqRFRs?=
 =?utf-8?B?MHlJTDk2cThUK3RFOTZ4ZlZXaSt5WUZ5Zy9WTUZUNjRpWnAyazd0MlUrUjYx?=
 =?utf-8?B?aWx5eFFCdnk3ZXJMMnY0aVM0TzEwd1lkNUh2dFRuRGQvK3dUYUc4WitPbTVF?=
 =?utf-8?B?ekFCSXhkcTVTMEhwOXRNNEViZ0lyZlpIZmNFUG4wcy81VTdWQ0NQTXVZazU4?=
 =?utf-8?B?a3didnVDTCs0RUNQV1Boc2tTbG13cjVYMGFBU2U1dmFIYmVKMlhha0lYT21h?=
 =?utf-8?B?V1hrTUJYUmwrSW91NEo1bWVaYTRmYmdhMHR5bkI3NWVaS1Rqb3libnYwdnVV?=
 =?utf-8?B?YVA4MTdpdzB4M0ZTeGR4dUhFNUpGVFBjTHVTUWNnbW5ra085TGpuWlpWeFc4?=
 =?utf-8?B?UWYyRzVGK1pLZEpIS3dvVHJIbGhFd1BobFF5ZDk5VnFoUTMyYStMQUVYeXZR?=
 =?utf-8?B?TlRmenRwUDh6R0RhZS9VQVNYNGc3cmVDemlnR1Y0bWhsWnhZR0orMGVxS2lK?=
 =?utf-8?B?NloxdWdOZU9TSzBiRm5IcGp3RU15U3VsbmVQano1WFp0QVI5NkJNempzS1FZ?=
 =?utf-8?B?cGxrYzk1R3JrMUQ2V0JJYWpRdzVmOW1aVVhuSGxOZXdobnN2dnVDclFxSDUy?=
 =?utf-8?B?Rlh3SThmZ0wzeVJkUjhMZmNta0dYaFZaZ1N2a1MxYnViR0NsUmpNNmpMQW00?=
 =?utf-8?B?YXFiN1VNVTRtWFhBNlc0QnRUMk1SM20vaEV2d1p6SU5xSUZGKzRnUlFPQ2F4?=
 =?utf-8?B?MW5XZmtUbi9KT2k1NlExKzhuS2RCcnFJNkd2elE1bklkQVVVWHhXVHNEUXNn?=
 =?utf-8?B?TU5jY2Foakx6cTBWQVZDaTZPWS9BPT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e64371b-97a2-45ea-47da-08dc33889540
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 09:28:09.3294 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4/UDW+hxt3D5v0xuXQGHsLQBxA2EcEPMbHO++8IGmkzKRGgA/vdiVfb5AGys39ZCt9NPymq2satEEOy0rB7Ckfoj7G8jI3OPyF+0kzFML7sEVjVK21fCSUWdYoTXI/t6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8253
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

Hi Jonas,

On 2/21/24 20:05, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 2024-02-21 19:18, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 2/17/24 19:35, Jonas Karlman wrote:
>>> Port the RK3399 part of the Rockchip IO-domain driver from linux.
>>>
>>> This differs from linux version in that pmu io iodomain bit is enabled
>>> in the write ops instead of in an init ops as in linux, this way we can
>>> avoid keeping a full state of all supply that have been configured.
>>>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>
>> Suggestions below, otherwise I only have one concern:
>>
>> This actually postpones the moment the IO domain is properly set.
>> Before, we knew almost for sure when this was set, as it was pretty
>> early in the boot process (misc_init_r), I hope before any device was
>> actually probed. Now, because we're using the Device Model for that, we
>> may probe this IO domain device after another Device requires it? e.g.
>> for Puma, we need the IO domains set for PCIe to work. I assume if we
>> were to use PCIe in U-Boot on Puma, we may have this issue (we don't
>> right now use PCIe in U-Boot and I don't think we have any plan of doing
>> so).
> 
> Because this driver makes the following call in its bind ops, the
> opposite is actually true and the IO domain is configured earlier than
> it was previously done with misc_init_r.
> 
> With this the IO domain driver is probed directly after bind and
> all regulators that is referenced by io-domain supply nodes will be
> regulator_autoset() before the uV value is evaluated.
> 
> In rockchip_iodomain_bind():
> 
>    dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
> 
> On the boards I can test on the GRF got configured exactly as before,
> just a little bit earlier in the boot process.
> 
> Prior to the "rockchip: Port IO-domain driver for RK3568 from linux" [1]
> series the rk8xx driver had some issues and incorrect voltage could be
> read for some regulators.
> 
> [1] https://patchwork.ozlabs.org/cover/1823769/
> 

Well, maybe I should read the source code before raising a potential 
issue :) Thanks for the correction.

So in short:

common/board_r.c:init_sequence_r calls initr_dm before misc_init_r.

initr_dm -> dm_init_and_scan -> dm_scan -> dm_extended_scan which binds 
the device and because the IO domain driver sets 
DM_FLAG_PROBE_AFTER_BIND in its bind, dm_probe_devices at the end of 
dm_scan will probe the device all that before misc_init_r is called.

>>
>> This all reminds me of the attempts we've made in the Linux kernel to
>> make sure the IO domain devices are probed before the devices that
>> require them to be set up. Maybe we'll need something similar in U-Boot
>> as well.
> 
> The main thing missing compared to the linux counterpart is that changes
> to regulator voltage is not tracked, so there will not be any changes
> made the initial IO domain voltage configuration made by this driver.
> 

There's a common issue for Linux and U-boot parts is that devices 
dependent on the IO domain being properly configured is not properly 
handled. Here in U-Boot, if there are devices which also have 
DM_FLAG_PROBE_AFTER_BIND set, then I think this is dependent on the 
order in udevice->sibling_node/child_head.

In any case, nothing that is specific to this patch series because it 
was already the case before.

Therefore,

Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Thanks,
Quentin
