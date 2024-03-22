Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E17C47DD9
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 09:38:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C136881A4;
	Fri, 22 Mar 2024 10:38:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="jrqB06+6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E491D87FB6; Fri, 22 Mar 2024 10:38:30 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4363688126
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 10:38:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRg8ox+4z6MZgtC2ZIQHPDCAj+Lr+BuF3z09k8ZmS56Etyx9ygqBDtKmo7SBI1+byhUJalDGNES7JUGf2SlY0Pn4hzbV9+kIpZZ4vbDu0xK+QxWfawcWcz7eBLpY4gf4bqmMPd+/e9JWOlefSSjwXfMkA6ne9PQW35Etyhy5yTs9/q6U3WFluU8C+711naS3L5gC7h27arsAoXPas4fROK764v1yHfILWQ2mT+EjrsTy0vmkVHMSF4qvWPd5l1mRK/IWpCgCG6CtYph0ibb7klsRFHqMX8Z2o3JjfNIQNnM8+R66HMBLWGfMsNtY0lyiFPTXnoDS+FEJnW3cWHbQcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tD169fDO+44u6cgvFJ4QJQFFf9vZKlrrWxJOOVCI1ZU=;
 b=Xrxp9i1XgniyBmknWY0PpsXV09OjI6zFSGwd4wvztARC9GpgwZwBjBtElo90nXBPly0gw712UWQPhF5Rfh9N1HrwnsrwRZdvPUOrVrt5Mi6W66G1jydpQbehmUWFzV1R4c2Ks82EvCjnGP2Jg5wnsNCSyYUnRzDc+HS1gd4A5sku9mPrUVBmNXnMSH21nNQtHnh9pkEvcf/lS/Hxt6ci6soAQxLR3yld2jmn6bVak38/fDj01PgTT1V0J5K80ZdrPlbp3KSFVnkSqvJr2EgUpj3zPyHbZZgRRc0OEQbQb80fWmYFkyMeuiIIgxP40prTWLbN5qMXO1o2/4xexaAL3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tD169fDO+44u6cgvFJ4QJQFFf9vZKlrrWxJOOVCI1ZU=;
 b=jrqB06+6+pJhLLHnRsc5ONLgfV0n6euuWLnZ3h3U01u1HBZW2Txr7I+N4Yg+PcD7PANR0OTzLxI+e3yOzbMk205FWRagt9Veoo2uHh0fMo99+04VC9jXX4Z4AyZpCfEdEWcbSSMlHdmyjuBn9uCG0dZ60kid8hV2iQFZV6I5JIHyRfux6/yrh9dVi7IinMQxruE4g5AoqntuI6Gn0YVVneI5q/lt/rrM23mijjgNlMuDzrUcrhcFUGZzkt2GPmzOrmk1YqQ6LPjx+4J1wzjLO8IhlcU/fpe2yb9L2/XC+GoYw/ZV5O7s08pZqaovy6+9kMTS7SmntKw1AvQxuXD3mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by DBBPR04MB7532.eurprd04.prod.outlook.com (2603:10a6:10:207::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.35; Fri, 22 Mar
 2024 09:38:25 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::23:4118:ae4a:8dda]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::23:4118:ae4a:8dda%5]) with mapi id 15.20.7386.025; Fri, 22 Mar 2024
 09:38:25 +0000
Message-ID: <0186f16e-ee67-4507-a752-4729bb466a3b@theobroma-systems.com>
Date: Fri, 22 Mar 2024 10:38:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: ringneck-px30: put STM32_RST line in input mode
 instead of output
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
To: Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <foss+uboot@0leil.net>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>, Heiko Stuebner <heiko@sntech.de>
Cc: u-boot@lists.denx.de
References: <20240209-ringneck-stm32-rst-input-v1-1-fa9d23ac8ebe@theobroma-systems.com>
 <03469644-53de-4484-82d7-348531d2148b@rock-chips.com>
 <0b87d8df-9040-432b-8756-17afa0118c40@theobroma-systems.com>
In-Reply-To: <0b87d8df-9040-432b-8756-17afa0118c40@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR4P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::7) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|DBBPR04MB7532:EE_
X-MS-Office365-Filtering-Correlation-Id: 556b30de-c402-4b20-f5a6-08dc4a53d279
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JQyWFGIm2Ip5kzDJbv6+a+0Rdw2mbmWKsKmz+rdCfzerNJ/iBYuf5XP8u5L3tRO1FPUhi2vO7GzHAQx9hcXWMrWFgdjWrv75zle47/5T7ZANGJylEzPPKQJ8Lv+FmA5gsUWUREEDPBECfU9CbdeQjHqtdEPNsiQjsOObDpz9FmlwWmLAnmjoqDvcoWzvOPT6H22woFbvhq67R8c7yDiQDm6gW/1dNy5WxfjNFF8xS7dDab3cUt1VAGoWddOH1n4X/ZZlUaaGY44YP59hA7NFeg5JzMHl+ZpmfRhh/Zsa13nRUlZlfyrZKgQWXiGNahd1BBaolJuRy9LQZ37Gxn266YvMwmAhI3y3zcq166UbG586m0wTQ+9EkWp3if40EC0xGp7Wh11ne+2W7h5yzkKWZyV8VKrzhgX9qwJxxKnSv+wxZgioVFrBDULhjzEpO1jY+tZVFMjnhEFAC4bHEm3D2nF58AcbfSH/OqjJO9XMmWq/GgO14erqgRub24gPYMnUuCSuBBgTqdKFFg1ul4vKiFOmt11vNd3kpQHXAPIj2yhV4+VPa2iIjLa4O6CNvaJPX5WtVNDKLWJ6dOlulntwbC0f79XP/I9A4opLUx5vJ+I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUEzMkdpYzREbnBBSEZGZ0hSbnNmdndlQms1SjVmeFB4RHhGV1JpOE9ZVE0w?=
 =?utf-8?B?R084TnJ4V1RzZVZpTFQzaTZYZjVINEF6b1ZzK0x0dTlTakVhYUJyWnJtNkln?=
 =?utf-8?B?Q2FtTm9PSFZXTlpvOHZleHdYVk81OWx5ZFplK3Rqem1ya3Uzb0lWeXV3eGM4?=
 =?utf-8?B?dFB2NExjTVBmVGdhOWFRZXBLcnlOVlBkbmN0dGFaY3ZsK1BxUjY1OWlMRnND?=
 =?utf-8?B?YUsxVnVzSld0U0NsYUpQeTh3dHc5QUtQVndrYnQ0MHlINEdZVXM2MGFmRmFa?=
 =?utf-8?B?VTNNQU5XQUg2Z1N1WnFRTHlSVnpwYk5KQjBWSjlNeFVxSlJqV0FpQ1NNTVNL?=
 =?utf-8?B?U0hWaWJpNEFiU3pGNmZROVNtR0dkSWc1QVFNWFcyMnAzS0hmUWh3ZkV0My9l?=
 =?utf-8?B?eWNETjZKYUV1Z1dONzhyRC9GMzhlSmt0OXFvYWFvZEtqMnNIbU5UWmtJUDIr?=
 =?utf-8?B?MEpNT3I3TFdEWG1Zdk5zaFhRNXdzL1dxQ2RJN2hxZzlZRmRYMmdYWXBiYmFC?=
 =?utf-8?B?RUg5NW1lK2ttb2pGN0Y5T0lVU2lPRDlLSVAraU9WbXh6ZjBJQjNsTHYraldr?=
 =?utf-8?B?VW8wdzlsWXMvVjltUnJQU0QxNmpwZ1hMYTZDcXFRdU1yVHYzQVM4ZzE1Q0hm?=
 =?utf-8?B?bUhqbkVPZ1JGd1J3ZXNSaG4xbEMyd1VlYlZmNXg3dkcxbmdwU0ZiZURUYmNK?=
 =?utf-8?B?Ui9ETDZYclF2dmkxaWJJNHNFeVN3MzEwd3J3TlErRG0yay9rNFZvNUxoVzJn?=
 =?utf-8?B?SGRSai9GbXlUaXZpeTZlZHRwclA3RWhCNE1LbnYvalZaL3VBYzZ4d1U1S2w3?=
 =?utf-8?B?RkhRMFp5RXJZdVkxazg1R21LeGxaMHhPd3NGai9sU3pSdEM3cDBRZmtmV2NT?=
 =?utf-8?B?K3hjRlFZVzkxaTRwbmFPN3docTdXZ1BPRGdNemFpMExjWm9zTmZFVXNxdXA0?=
 =?utf-8?B?S2lmUXVXL1dSNUJNcVNRR3Q4ajZnZzd6UkdiYmh2bkwwYVRLaENDUXJjMEJp?=
 =?utf-8?B?eDQyMEVqNWNFUC9NNkd6WC9VNHpCMXlvV0ovNldBS21wR0tVQnBYaXY5VmRm?=
 =?utf-8?B?Mm9RS2JWbU1Ld1JRNGFQOThlaDVqSzlEVVJKMmxBaVZRTXFmSVJlU3hMRElL?=
 =?utf-8?B?VGFqeTV4NzVXa2ZqMktlSmJFUy93VFR2dFhUOTNSeVNLdUtiNWVUOENTdERn?=
 =?utf-8?B?NzFFNlFPNngxcjNERXNPc3FsMnRaM0E2SWN0TEtsQ1EyT3ptOSt5cGQ3NmFi?=
 =?utf-8?B?N3dIYXg5VGVxeXYvSDU5UGN4bVR3SG9MdlB1OVJyamRWK1g2SGhGMUljNENS?=
 =?utf-8?B?em9Ham5ZR1J1dG1JbDNodXRqMTd2Ti9HZWFyWjlLaUpzQzZLR0pnZ2JFKzQ2?=
 =?utf-8?B?dTFNeXlWZWI1ck9aWjJoZ3QyZ2JzcVZQdE0rWmo5RkFtWldNRHBka2czUUQv?=
 =?utf-8?B?Y3BTNVl6V0x0dGJqa1VlKzlFMFdzYTI4aVNpVnRDRFluL0RNckJwMnpiQUpo?=
 =?utf-8?B?dGtzZE5XS2Z4SE8rSUN0S09PdXNPeWYweXJndlJzdWVtZGJKcndkS08zT3dh?=
 =?utf-8?B?NnpIa3EzZVF2bjdsc1hreFdxWGhGWHlvMXFZNGxrbi96TW5sRnNvSytpei9m?=
 =?utf-8?B?ZmZCTkhCaFE5U2tuTEVuT3dWSjMrcm1ZbFR4V3ZvWUtTN3Uwd2U3TzVFbElE?=
 =?utf-8?B?Ymg1MDlROGFmclNmWk5OYkh4aFYyZ1o1UU0zblhYNmNmSmFrSnVmQm5qOGo1?=
 =?utf-8?B?MnZXeXBOVUxoemM2SmV5a2VrMW56N0t1WGxxNU1BSFM0K1hBQmFSSDBUNjEz?=
 =?utf-8?B?a0s4ckprNkp6bm1NckRyeTNEOEtlbUtEQUpPMjFpWURSM1FudlRwNWxKTU5B?=
 =?utf-8?B?TTN2UlJkZ1JGbXV6dU5JYlZRTXdNWkloLzRuYlpmemlsaVhudTkxOUNWbzEz?=
 =?utf-8?B?WlZPd3laYUZMY1dReTRrc0hrdTBmWml6ZkNMbDMzdlF1byticmpzcmZlVk9t?=
 =?utf-8?B?L0l4d3ZFaE1TZjBuTWFWRlczVEMydmc0SmFydS85bmxTTkEzNEJFZFVoMmlt?=
 =?utf-8?B?dDZ6VEE1SHd4Q0tySUJOb256YUV1VTB0V0hrREZDZk04eEpSSGFsUk5XdmtR?=
 =?utf-8?B?dFRYMHp6TmdBbVU1OWpvR1IvUVNqMzhrV2cxc015T2pXQmJjdndtblhENVlR?=
 =?utf-8?Q?vAGaDcdJB6cQPPkQVH985Xs=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 556b30de-c402-4b20-f5a6-08dc4a53d279
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 09:38:25.6002 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K95QiBhwSAzXEJ5157EmQojLpiXXP6NUxW5U32Z3jli8sD/oqT873SV504hu0HVIVt+Z6zV8N0F4xdjkOVr8IUXBTdPkDWXFggeo9+9gu2byZv6SHq6my0/x6YQJCuhN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7532
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

Hi Kever,

On 2/19/24 10:50, Quentin Schulz wrote:
> Hi Kever,
> 
> On 2/18/24 02:14, Kever Yang wrote:
>> Hi Quentin,
>>
>> On 2024/2/9 21:18, Quentin Schulz wrote:
>>> From: Quentin Schulz<quentin.schulz@theobroma-systems.com>
>>>
>>> The STM32_RST line is routed to the ATtiny microcontroller
>>> PA0/RESET/UPDI pin. By driving the PX30 SoC pin as GPIO output high, we
>>> prevent external UPDI to be used for flashing without first putting this
>>> pin as GPIO input, an extra step we could avoid in userspace.
>>
>> A little confuse here, this GPIO is an output for PX30, right?So the 
>> config is:
>>
>> 1. the PX30 SPL init STM32_RST as input, with hardware pull-up the 
>> keep STM32 work;
>>
> 
> The pin needs to be high for STM32, and high **but not driven** for 
> ATtiny in order to allow flashing scripts to work.
> 
>> 2. when need UPDI for flashing, need to set STM32_RST to output and 
>> trigger the reset in userspace?
>>
> 
> For STM32, STM32_RST needs to be driven low, then STM32_BOOT needs to be 
> driven high, then STM32_RST needs to be high to deassert reset.
> 
> For ATtiny, STM32_RST needs to be NOT driven so that UPDI lines can be 
> used to interact with the MCU. Note that we also have the ability to do 
> bitbang UPDI on that STM32_RST pin but that's another topic (just 
> explaining why it is routed while seemingly useless for ATtiny).
> 
> All the above is for entering the flashing mode.
> 
> However, in U-Boot we do NOT want to enter flashing mode, we want to 
> exit it, c.f. 
> https://lore.kernel.org/u-boot/20231103-ringneck-stm32-reset-v2-1-a0e5559f89bf@theobroma-systems.com/
> 
> An external HW pull-up is required because of glitches on the line when 
> powering up/down. However, this is only done on newer versions of the 
> PCB, so we need to tackle old versions.
> 
> The old versions do not have this external HW pull-up and the glitch may 
> cause the MCU to enter its flashing mode. Therefore, we force it to exit 
> the flashing mode by always hard resetting it into the normal runtime 
> mode. This is what spl_board_init() does. STM32_RST and STM32_BOOT are 
> controlled by our flashing script for the STM32 variant for the MCU, so 
> the default state when entering the Linux kernel doesn't matter. For the 
> ATtiny MCU variant, we do not handle those GPIOs as part of the flashing 
> script, therefore the default state when entering the Linux kernel 
> should be the expected value for which we can use UPDI to flash the 
> ATtiny. For ATtiny, the reset line is shared between STM32_RST that goes 
> to the SoC and the UPDI lines exposed over the Q7 header. If STM32_RST 
> is driven by the SoC, the UPDI lines won't be able to interact with the 
> MCU. Therefore it needs to be put into input mode, whether in U-Boot or 
> in Linux userspace.
> 

Can we have this in the next merge request for next please? Or maybe 
there's something I need to change here?

Cheers,
Quentin
