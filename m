Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 713ABCD1296
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 08:44:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9B9F88120;
	Wed, 10 Apr 2024 10:44:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="b0HZnePQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80450870AB; Wed, 10 Apr 2024 10:44:04 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2611::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 546C3881A7
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 10:44:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4R6dDSR+fS+Cif6U7VxabA1lR3ZIQQXSSNgB1dTSO6EVmiZOU+bFr+BboO09020yECTuQ6zQqUmqkAJAHJFxq8Rf41jCZSsMIAy5ulYkxNsIfc74bIEEngynMhUUauOBZ9Wj1178YjOeZQJRaV2jND92glh0kqtxlw8XOq29XBZNzllCVKdkLZjSiUYFNgU/PNK7Oj1Lil8A+paqEhf2z91jBPvKvcVwHaetVcWebI7bvWDv5Uuh9M4kuPKtdC39CfR0X677QX65loOihnWtlH1KBawkj7OjnZtRdOWqpSYuXRa6u3ysP+TcS+zS3N8q6gz9MX24l3w7NWOH0p8FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7oP1dZkNxwFxU13nR14ItHKwpsfIjWEcYc+BeTbxKg=;
 b=idBW/e+GgY+9G0DbXN39jgRNSjEFNLWiNfQG90DdWZjtaMieuiJIFGsla/nKzrEiLe6RUAqRQw4smDHiNC+r5CaCgu78HaiP19/whP3n45HKwKy8k5GMtip98iEornFX8ITUuz+Yu446hht5/ib44jX31KzDF/hmeap9UNSoldhm/ap6TpXUGlbUt8jPYP8+AIy2OzW8oPz+HOarcTfH/vFkD7LMqcE/DTlnWZyQkScICpAAEHJXihZY9D4uCwBMfWSoVAowJe0anZ7HKF65C9cPhA7QnOenvbHWwo2dnvuv3ran79c1kTV6PhMmVVkAEbs/l6+ep5Aner3tgPATIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7oP1dZkNxwFxU13nR14ItHKwpsfIjWEcYc+BeTbxKg=;
 b=b0HZnePQVXDjuVAVivRDdR9wOq6j6WVzipPGh4hiAjBmjbYXk84qWjnb/h9diZIU6B3yBXRgwij0hCgN0SYY0Jzt+gcYEDcD8nV12G0F+fvmWck/TqCnMGnMret7B2QO1m+//Gnr/wP/CeHOqW9T9SGWO/HFLlWplLgowwukLu1oeJxGpJV6+voOllbhbAyqvTHVxp44YJsBOt4UE6y6gT4A4j5ff4XoiJLRgUMoZS1rYn9yAgYWJUbTsswU64I0dpmx9vTOSf8cO0OAmmxHWOnBfMihI7mM1uqdi4DXLkXF7v3yta/Zk9veU+JUjf7EZuy0bRLnTCfVRs3LGpqa0Q==
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AM9PR04MB8523.eurprd04.prod.outlook.com (2603:10a6:20b:432::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 08:43:58 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779%3]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 08:43:58 +0000
Message-ID: <f5e41945-a4f4-44ab-b698-d34963f7a4f1@theobroma-systems.com>
Date: Wed, 10 Apr 2024 10:43:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/14] rockchip: rk3308: Enable random generator
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: Andy Yan <andy.yan@rock-chips.com>, Akash Gajjar
 <gajjar04akash@gmail.com>, u-boot@lists.denx.de
References: <20240408181429.3676856-1-jonas@kwiboo.se>
 <20240408181429.3676856-6-jonas@kwiboo.se>
 <3fb8bdca-042a-4153-ae0f-114bbafcb82f@theobroma-systems.com>
 <6c4b5110-9ef1-4013-a858-b59637ae6d75@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <6c4b5110-9ef1-4013-a858-b59637ae6d75@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: WA2P291CA0002.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::22) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AM9PR04MB8523:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xFneJ8rmaXqBepKOTuzLfvN/XScxsHQ0wZdk459rt8NjwWcL6jVciGAW/Im62vFsVn992MMK35X80j8TpyQ/uTA5Q9UVAFUuoJFch7MzsGaYvQSEeLoYuZhkw0LK6/cbpYjCk+mRpF8ZPrlHdDQ+pkB3KH/4BCohJRQrHkA93l2KSSj24DLJqwjfwmfeeYgVms54sjnPlyGUioaaAXW/DeTazddu7PfNqwTnQ4/xaGxYYz3qzAUREypLWliTLp1TGqRrRvPusvmyfSSznMRgowzZbskcJqyHvhZyPVVCuWPcJqNh/hABtBx34on80npNkEBMoBftRJXxHCsoOkNq5704qAVv44JlWAdYoFPq9mgYbnR5Ua+wtBz0IIfzRkqEhYizev9cIWaFwHzPHBuGc0lvanHS5fPtRFSylsQ2uJAjnio+KOMWXn0H3cGH/JHcE/HctGALyWlSZvxrKs79f15JbuIvgw3HMzJib/Ub5eewzYNlws4kdOlsbpTaJ7RjmtSMzV7nGJIn8KIut+EaK5Pxmwk1Tem0D28iPeL5XZIU48gCOIYq4mw4ZG4htqAS90++AKRdzbn+hScbRxheuGD08qfq7gt0m1YHMvOPzuE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MElZTHp5UnJzdmx4NFZ2b1E0N0RSZUg4OVlsYU1VQzJVd25oVllDV0VFMXhF?=
 =?utf-8?B?TjVDd3pabTFqUm1waXdUODE2R3ZMSkhQRzBGdnprUFdmcXM0bTVScGtLUTZV?=
 =?utf-8?B?SnBzRmNwWE83SEpxK1J4U2l6djdYODVMakhpSHUraFBFUDJucUFWZXd0TGpG?=
 =?utf-8?B?NCsxMFd2OGM5clkrdlBLOGtOV0xXWFFoaDk0V3dzWHd5djkrWVJSblZJOFZr?=
 =?utf-8?B?VEhmRlQ2cG9ZdWZNbENtOHgwYS9jdWc0ME5BN2dJeFBYVVo4L2xSMFE4cW5q?=
 =?utf-8?B?V1I2dUhTc3hGTmF6SUFWa245cXVTNTRFUUh0Uzc2NDFwVEhRY1Y1cFZDejV0?=
 =?utf-8?B?MWFDTm54TXZpWEErZEJHVk4rL0FsNkdaZXhXd2JFa3NWZFBMeGlFRnFicDE1?=
 =?utf-8?B?RDl5VGsrSDFRVzkwd1Q4bWVsaWpPYmc5VG1zYldPelpXK0lEY2RBSFBFS2Jy?=
 =?utf-8?B?WWlPUGFEZ3BrdGE5UWxIbENKRmJldE43UGRBdjlzUC9yMFkyRXBYYVhEV2Jx?=
 =?utf-8?B?SnduWXZuMlJGRVgvQlRJdm0rZk9rQXc1ZDBDS2hIaUtEQUJCbXIrWWZ5eGl4?=
 =?utf-8?B?T3hxelZLQVFLclNMbTNjOVNOLzVtcFlOemljMW42clprUjVjMG1qeTZMaEYz?=
 =?utf-8?B?NHZWN25yOWxWYll5TVFjRmU5eXQ1OHNBKzVuWG11WEtLemZrb3dqNmU0QUtL?=
 =?utf-8?B?czhMbHUzMHo5c0t4MTdVTWpMN0NOa2ZoMis1ZmtDdEJTeHZoOFdzTXhBV0I1?=
 =?utf-8?B?SktIb0piUE1sNnZkd0JLeUwySGk2cm5SRnJwd0VoR09NU1hFSEVMUFF4T3Qy?=
 =?utf-8?B?WlcwcENTdFVERWEwYW1WUmEwWUYyTER1YlYwYURDaDllT3AwNUwxcURxSGFr?=
 =?utf-8?B?WThpVjZPVUJ3dng5bnBOcG1oeDU3WFhlOVNsaGozY0k0b3JtcWVISVp4OGhk?=
 =?utf-8?B?bkNEMDUzQjFsc2N6NmhKNHpXNFMySVQxZXRIdFMydDVDRW82WHlUdGJnbEpt?=
 =?utf-8?B?ZHpkeGZoemRFRUx3akFlVStnaXBjRXpKUkR0bnNvOWlOV2hmbzhOQ3dWYUZD?=
 =?utf-8?B?Uk1aWHBvNFhPc05aSEM0WG9xZ0E0VDFIa0FlK05wSUlPQXl3SXRLb3FEYXhC?=
 =?utf-8?B?UzJ6bjYxaFk2WnhhcmFrZlIyRmJ3WmJCUkZoalNHMEMvcEJuSlhHWlU1bERB?=
 =?utf-8?B?ZHhNeFFpYTU1SzBCcThERmdtTlRXTTNnN3VZUlRuckZOQ1dtT05wSmNseTM4?=
 =?utf-8?B?MTZlZzhTTS9GL3FLSHk2ckZyV2k2NDU4cCtoUFhBS0VxL0RKWU81eW40SnVW?=
 =?utf-8?B?WUtKZS84S0tkbE9oNnFyVmhSNVRyRUFVWVREODNiYTJjdXZNd3ZJbTR0dXF5?=
 =?utf-8?B?MzlhTWM3YUo3Z0g3SmpRalVMWWczOHVaZ3NLcXBTNGJRdUR5bHh4MjMzZHpN?=
 =?utf-8?B?MnRyWjFQN1ZiUWsxaVg2NmFBVXg1b1JKOEl6M01YcXYvTWRwb2pIZXo2cS9B?=
 =?utf-8?B?M0JKS1RyT3lXSDhVSmNkU3F4YmxSK29qRWJpd2xTcnlUSjZjQlFCZ2pLbTA1?=
 =?utf-8?B?UC9JS29kaHlqK3pzWWlMckh4MTlDSCt3am1aU1h3VkJmak53bzQ2WElsUWZT?=
 =?utf-8?B?SllDekplcU1ZWXo5aVZ4VSswZ2VMT09pSzBDQnhmQlFFL0cycVJ6ZHhrMlJP?=
 =?utf-8?B?eThkTktEYy95cGtKbzkzUjRVYlZ0dDVVSWVSb016bWhrMVFjZlNJUkFDSzIy?=
 =?utf-8?B?emIzZW5KVFM4YXRva2ZGSGhXVXBpaVNoRVRPeWNBQkFPTDhYZ2tUY2NQaFJv?=
 =?utf-8?B?RnBoQWpTRWxJN1o0aS8yK3N3NUpvVkMvcUQvRHJGMWk0REZNYzlVM2c2aGRO?=
 =?utf-8?B?ZjExTmFueFJIRk00T0xSbjlmUkNBaDVyaXUrUTRpRXlWVU4ycEtQbEluRWJa?=
 =?utf-8?B?S05TaXFoalV3aVN5QnFCRitrTHlhYi9YV2RUQlRBYi8rOHN5dWNoeU95aDVF?=
 =?utf-8?B?UTJ0dkJ0SDJtVHBwZGVKNXhLVG5DekZMODVWUTFZMTFKMWRUZHJVR2lvNzUw?=
 =?utf-8?B?djFjQXlaR0lrbFdId01YUTBJRC8wcXNzb05uNUpQeGhTY2dRa0hHcUI4cCtE?=
 =?utf-8?B?SDkwZk45ZkJhTTN4eWUybmFiRE5iZ1IyRUs1NERlWVhSV1pYdlhCY0phOU9t?=
 =?utf-8?B?dlNYQVVhdStLdXBhZUU0OXFzZHkzNUJOU3gzdTBTb2N6MmJFL1d4ZTRpZTQ4?=
 =?utf-8?B?Q3RxOTIrOXBCekpGTm80dmJ3ZXRBPT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b720a7e-2336-4117-745a-08dc593a5cf0
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 08:43:58.3599 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LujA+yQcLXY4Ype7OKxGEzInZqO33XRblFQKA6M3WDDD//5uszYr+TBcP8b7jnseLjYcA6xSfABqr8Od1ZOqfkH7njRXNGQDz2qw/wvi2Iwop0ugYw34eJqMmc9V5OQY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8523
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

On 4/9/24 18:21, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 2024-04-09 17:45, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 4/8/24 20:14, Jonas Karlman wrote:
>>> The RK3308 SoC contain a crypto engine block that can generate random
>>> numbers.
>>>
>>> Add rng node to soc u-boot.dtsi and enable Kconfig options to take
>>> advantage of the random generator.
>>>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> ---
>>> v2: No change
>>> ---
>>>    arch/arm/dts/rk3308-u-boot.dtsi | 5 +++++
>>>    arch/arm/mach-rockchip/Kconfig  | 2 ++
>>>    2 files changed, 7 insertions(+)
>>>
>>> diff --git a/arch/arm/dts/rk3308-u-boot.dtsi b/arch/arm/dts/rk3308-u-boot.dtsi
>>> index 436f66d1b87d..fa31c838d34d 100644
>>> --- a/arch/arm/dts/rk3308-u-boot.dtsi
>>> +++ b/arch/arm/dts/rk3308-u-boot.dtsi
>>> @@ -26,6 +26,11 @@
>>>    			reg = <0x07 0x10>;
>>>    		};
>>>    	};
>>> +
>>> +	rng: rng@ff2f0000 {
>>> +		compatible = "rockchip,cryptov2-rng";
>>> +		reg = <0x0 0xff2f0000 0x0 0x4000>;
>>
>> Downstream says something different:
>>
>> https://github.com/rockchip-linux/kernel/blob/develop-5.10/arch/arm64/boot/dts/rockchip/rk3308.dtsi#L1007-L1020
>>
>> I couldn't quickly find the TRM for the RK3308 so cannot check myself :/
> 
> RK3308TRM Part1 mention following under address mapping:
> 
> ff2f0000 CRYPTO 64K
> 
> And RK3308TRM Part2 mention following under crypto regs:
> 
> CRYPTO_CLK_CTL  0x0000  W  0x00000001  Clock Control Register
> [...]
> CRYPTO_RNG_CTL  0x0400  W  0x0000000c  RNG Control Register
> [...]
> CRYPTO_SRAM_ADDR  0x1000  W  0x00000000  SRAM Base Address
> 
> And the U-Boot driver:
> 
> /* start of CRYPTO V2 register define */
> #define CRYPTO_V2_RNG_CTL			0x0400
> 
> So 0xff2f0000 should be correct for the crypto block on RK3308. And the
> rng cmd also gives me proper random numbers on my Rock Pi S board.
> 

Could verify with the TRM Dragan shared, thanks.

>>
>> Also seems to be missing clocks and resets?
> 
> Yeah, this is just a minimal node to get the rng driver in U-Boot
> working and like most other clocks they are enabled and running at an
> acceptable rate by default.
> 

Considering that the clocks and resets all seem to be crypto block 
specific and that the kernel doesn't seem to be doing runtime PM on 
Rockchip clocks, I guess this is good enough for now?

Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Thanks,
Quentin
