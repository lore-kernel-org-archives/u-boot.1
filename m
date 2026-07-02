Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A8BC43327
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 17:27:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8166184832;
	Thu,  2 Jul 2026 19:27:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Y340KhQe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2F20848DC; Thu,  2 Jul 2026 19:27:14 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F09DB84409
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 19:27:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PUXKUWQsKJ39Y5SS0ejPvY9ma1+GAllh2wgyYfKCjKGKgXL8dydOpPZEIud82weK3yxipkREvrbHer9AKLC3v8g6PDuHZ7F8VqPOVabJMNO76lmDPFb1QdOzMRRLPLu+J16fD26LBsN2Qw215xw2s/9I7da0XLlBybSqTYOeGxCN30CSDk/wiOaF3uVG+0feFQnxs1qM8VZhfXNC/GPv9apkFK3SZRqBzAcJS6e63DBzbdm7gQz8PHQnrr7BAVGpI7cqeUsYr8ZBB5JcmFPQ24vHl+o0mBpCc7BsBXRp9d5vJ0iO5sHmbGCpzNQl8kVELe3kMuh40Yj8KWp+D1OtIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgyLptTGHxwgwi65QUdNlMP6AyJw070BCigNnYqj4TI=;
 b=ofkM/dRz94yV5JrJCkL4+ROFCt1ovGRClGfWgD7hBx06tSBpeiAvltHi1nGvsnO/X3p507JBoxmf2Qznp/I2SfH1FClC3IxBCXmWNP1BCGUgd0mofhhlJM9lTTABW5iXOZ36ObgY63gaskknSqxUK0wUO85KddjXLVtsbdnSQuf5R9BSr0p9nRJ6ikSMDdVoqT1LpZOCteaZ9BNm5LZ/0aa3eT6WdmpLwt48wIr2HpWeGpoPWvS1qFnderUE60ZSyBJfssVoAvDX06JMv1yM6PV73s6+x2SqDz8EN9SdCYtPXU09/A3Bxv7Fa0oGT3TaDQakXtr2M4Cyss1iBUE7Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgyLptTGHxwgwi65QUdNlMP6AyJw070BCigNnYqj4TI=;
 b=Y340KhQe/Hd+XHQEkMCIKoYqK/PVxPSOAjvmkjEmVadYBN93bBaVMhxwV8LJ9gW7r3bLohNV+2pGoUtVMzA347o9u90rXiuX8XHetgM83Zcnr1B3FvfBRGnsc5grRsdlawNlSTyDbEeeLyETb7+/ZhObydxl7iWV7zLF+BdkzqI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by VI0PR04MB10094.eurprd04.prod.outlook.com (2603:10a6:800:247::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 17:27:07 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 17:27:05 +0000
Message-ID: <78e8662f-359c-42ba-a641-427cfb65ab4b@cherry.de>
Date: Thu, 2 Jul 2026 19:27:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 0/2] Modern pinctrl for Exynos5250 devices
To: Lukas Timmermann <linux@timmermann.space>,
 Lukas Timmermann <uboot@timmermann.space>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Yao Zi <me@ziyao.cc>,
 Kory Maincent <kory.maincent@bootlin.com>, Peng Fan <peng.fan@nxp.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Henrik Grimler <henrik@grimler.se>, Minkyu Kang <mk7.kang@samsung.com>
References: <20260506-pinctrl-exyno5250-v3-0-11649fe82210@timmermann.space>
 <b55bd93a-d117-411d-8cb2-3c5f7c8d64c2@cherry.de>
 <agyIf6anB0ZMRd3y@archstation>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <agyIf6anB0ZMRd3y@archstation>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA3PEPF00000524.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::66e) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|VI0PR04MB10094:EE_
X-MS-Office365-Filtering-Correlation-Id: fdd4cbb3-ba27-496a-b366-08ded85f22ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|22082099003|18002099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: uzjIyoSL7UDgU2nwCody4Z2/6nx3rUZ8jDaIhxwKGXOj5Z4j8vgv67a++qYQpTn+WrZBbbXxdIi/YccZcIpwwObVoqsQz2oS1aN5eiy4jj41jabv7TXbl2XEl/6QJRhhDVolNbifbSKxI5x59HPBMDnMmnMXny7A2MBvvFnJiiKkr0M9Uqw3VrqTGBFiuxEOSHsh+tuOMxeiKo2jeZ01gTrn+WiLxl9uXXWiFWGneBFCuaKQGk+Jg3F2ZvQT7blGxPuH3nHP8atUJbBIBsMnGcZDF1uQ3Nbm55K5sVpbgY+BXi43BhgqPqicf9+5fx1eam1NrKYICrK3f4PHWOpqwQlMdUHiJhh7pVB4eC6ul1l215NcNzNAGfdKwlZHJrqtc1ylQVSV5WsbZnAildvfHZErjtz8AuShDgE5k7k/EVLZVFVpIgW7v4IX+DD6PZDCOxZ7+9ydsdvBx8VDtBiEllk3AMRbrsfyZfEVLk8tilXXmZNlAyP3Y5S8ejvwGBx12vNHzaHxrG4m36wnp4Q/qwf7jCgse5Z+acAk8TcOS8kmY5L+MINZYyCZUdEbIkJ4UtS7r/uKEUDWL9u86AZSY+U4Gs9hkNO4th3IIKSqGUxtP7+fNBD+AMLcRhKqPMa9VB3It7rDlrDV51Tb10ebRQgD7bUoIeu1OoVCZOlx0xw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2tIM2pjK1p3OGJLdWhBUkFNc1pjaFdpUDlHaUw3emlNeTVLaEN1UkJPelZC?=
 =?utf-8?B?M3AycCtIcFM2ZWV4b0R5ZzhYckdJcEZLVUVnSVZoUFJ5eG5UcjJqVEFhVU9H?=
 =?utf-8?B?WEs4dmxFWi9USUw2UTZOY0FFSTc3b3NSZGFJT2FmNjJINEcrNEtqczl4K2R5?=
 =?utf-8?B?cDltKzlaRWFyLzdVL0dTNlgxNm1iR2ZLU0htNVhGVWw3anpmbUI1MGJuVjN3?=
 =?utf-8?B?SzFFWGQ2TGtZZDBBNzNKcUhrRXloL09mWnNuMzNiNFU3RHA0blFQRFJUN0tl?=
 =?utf-8?B?VjJLN3JuZzZEWHdQZ0ZQQlhwOGFCTG84WnJUQWFwdVlKWW5iMC9xTTVVWkp4?=
 =?utf-8?B?T2xtU3VIMjdKUkFFeHhnU1pDelUxV1NvaEE2SlJkRW94MjFSdU5jTzU3RXda?=
 =?utf-8?B?dlBHeGt0UWNtWDJxRzNPVEFadFRnMDZGSmd3MUJwS09OVTdVNmdHOTRVR1dm?=
 =?utf-8?B?YVVBU3BVVGVoZ2YvQ2pUQThkYU5KQVcxRFQzWTlZYzdiZGRWSjRJbWNqUENj?=
 =?utf-8?B?Z0FveWlYVS9Lb0t4TXp3cVNqWWR3NXM0NU41U0dEelVsWWdMK1JmVWRLV2ta?=
 =?utf-8?B?ZFExUXpsK2k1bzVQL0RYendOWkJGRW5Jbks0bC8zM0dzRTlvMTFxbG5oRUJk?=
 =?utf-8?B?akh4WnVzSVZOUzl1RUpJYjJaTGQycjBHTkhscHBVdUV3NEIxcHdST3I4bWRn?=
 =?utf-8?B?eGJlY1owdklFdzM3RG5nZll0V0o4MHF6dDcxOGFVOHRFRy9URzBTVk5ESzFi?=
 =?utf-8?B?SkRTdWQ5bjNld2dVOFFCUWdwMEN1QU5oVFQ5RGFqSHBsN1BnY3B6enVOZ2ln?=
 =?utf-8?B?MkNhdlQxeTNaM1FqNGJzVHdvTDNBMlZEbE0wSVlRQWYyOTNUa0JtdmRsemZs?=
 =?utf-8?B?SkJnNmU2d0VXaC9Mb29wN0FvaytVTlhGTStRZXdqODQ3KzhTbVNzVGNzSm1L?=
 =?utf-8?B?b0VGV0JTNEVFdmRCNmlEdStxZHpJbE84NVZXcmZNc0JqWHJBaE1ZKzJ1QW9T?=
 =?utf-8?B?eCt0a0pSN0J6RFlkNmZLcmpXRzZlc3JYaEd1TUJseEkvK0szcnRkNlNnMzhP?=
 =?utf-8?B?THJuSkpwUWVvS2tvWjVlUm1Ia3NwUmdteDJHSVVBRzNNVWpmYkIxRmNRLyt3?=
 =?utf-8?B?em1kVm96eXBCYWVUdDd0dzg4RjdrQ3VKWVNjeGRvR3VGd0RISmhBWXBIcmpq?=
 =?utf-8?B?c1FKRmszUzNHa1o3N0Z4akppVlVVK3FDTUZsd2FBUmVVWCtZTDVQaDBuUXpT?=
 =?utf-8?B?cDF3WjBSalZ1Q2NvWDdKTDVlclBPVjgxQUdFWWVtMzVpM3VWUmxhd1VOZ0Yx?=
 =?utf-8?B?ZFN6bXJURkhRdENCZlY0RVVXVldLaFUxRDAvZHhsenRZZVpMTC81T3lRcVkv?=
 =?utf-8?B?UWlLeit1YW8zbEoxMVkzejNJdk5OblgzR1ZybW5uNm5zQjBmeUtndy9sNkRG?=
 =?utf-8?B?alUrTWo1UjBSaVJvL2hQc0pVZHRmQ0VzTzEwSGlRQkxtNlp6L25UMFowQ1Rh?=
 =?utf-8?B?QlhpcFBETzg3YkZDbnZQZFdvNkMwalIraU5rVWtCcXNWWE1xMEFjR1NjUnhG?=
 =?utf-8?B?TW9LRkRHSXVZTUh1ZmIrVnBMN0oxclh6VW9EK1lEWmhCcnlVQTZsSThlQ3RZ?=
 =?utf-8?B?UFRQWStRTklxMG1PcDJ4LzlkOVd6ZkpxTjRXQ2w1MUJGcFhGU1kwN1pxOWp4?=
 =?utf-8?B?V0dLVm9lMEVEVktiMlRMVHNKYklEQWkvbFlsYnVydVZHTmFBblJPU25ncWh6?=
 =?utf-8?B?SHhNUG1GSUpnSlY4RGhtdFMwcVgydDQ2WXB0b2NQSElncnJ3QThjWnFTOE05?=
 =?utf-8?B?S1RMWDVPUWFqOElNaENzTkpPNXVmd3FJRXFRM0tmS2R6R2VqYVFhbHV4QkRH?=
 =?utf-8?B?Y0lXUjVkWDVNdmh3c0RwT09UU2FaaG1KM0hTTkpDMkJ0NHNvNW0rQ2hsZVBR?=
 =?utf-8?B?NlNCTVJsckN5bEhMc2RCZlpEd2NhdkF1RXBWVnJxeFlKWm0xSDZhdzVMZWU4?=
 =?utf-8?B?azhZeWN5elhCRmRUMVZTZFVxODZGT1Q2SjU0ZlRTb0xUYjlqNzMrOUhHa2NQ?=
 =?utf-8?B?TzlLUlNqWktubjNYNmVpZjEyK2xkRWlheHVIZFFFUzZZaXRCV3BqaFhGSE1T?=
 =?utf-8?B?eUNHVkw5UDBuWTFWU3phRU1nMXkwTE51Zkk1TmxFMkR1SzVKS2FjWEFIbFV5?=
 =?utf-8?B?TEUyclB1ZXhFK1krUkZDU3RQWmZqaUtJWWIyUjlVYkdtWk5JM0ZINUg0elRs?=
 =?utf-8?B?TTAwdTlLMEUzSnRzdUE4ZjVVUnJyczQ2cnd1a0lTT2dBc09lQnl3UjU1MTBl?=
 =?utf-8?B?dUNoazY2NFgxcm5lUkFOcUl5RnBXWFNuOEkyUGJES0dHay9aSUpoUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd4cbb3-ba27-496a-b366-08ded85f22ad
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 17:27:05.1318 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wh6eiA7TYO9kj+6kQCfGoF4x8a7T4y3MSpKqwjA1UM+CnsN+ttxMPjrsUzcIVtj8hHyO95zy1KTMwSJzz9vAYrNWqoRumXhQjJ63ERSw178=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10094
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

Hi Lukas,

On 5/19/26 6:32 PM, Lukas Timmermann wrote:
> [You don't often get email from linux@timmermann.space. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> On Wed, May 06, 2026 at 03:14:11PM +0200, Quentin Schulz wrote:
>> Hi Lukas,
>>
>> On 5/6/26 1:13 AM, Lukas Timmermann wrote:
>>> This patch series adds the necessary files to use a modern pinctrl driver
>>> with an exynos5250 SoC. The changes are well tested and are working.
>>>
>>> In contrast to v1, this reenables GPIO functionality. But as I'm still
>>> lacking experience, I'm not quite sure on how to prevent s5p_gpio to
>>> load when using upstream DTS in a clean way. Because of that, this
>>> patch series is marked as an RFC.
>>> checkpatch complains about using #ifdef.
>>>
>>
>> We already have an issue with samsung,exynos78x0-gpio so we'd need a similar
>> work-around for that one.
>>
>> An easy way to sort this out would be to know if we know of devices which
>> are still using the old binding? Qualcomm is rather special, is Samsung
>> Exynos also special with regard to how it handles Device Trees? Do we get it
>> from an earlier boot stage or is everything coming from U-Boot itself? If
>> the latter, we can always migrate the existing devices to the new binding
>> and remove support for the old binding and with it the same compatible in
>> two drivers. Another question would be, does it make sense for both drivers
>> to be compiled? If not (e.g. it's only pinctrl IPs inside an SoC and there's
>> only one pinctrl device per SoC, so if your device supports the new binding,
>> you only need the new driver). Then we can add a
>> depends on !PINCTRL_EXYNOS5250
>> for CONFIG_S5P (we probably should have a different symbol for the GPIO
>> driver though, maybe CONFIG_GPIO_S5P?).
>>
>> Cheers,
>> Quentin
> 
> I'm sorry. Some of these Infos should've been in my original message:
> 
> This driver replaces the pinctrl functionality in the old s5p_gpio

I don't see how s5p_gpio is currently doing pinctrl. Do you rather mean 
that the s5p_gpio driver is matching the pinctrl compatible and thus we 
cannot have two drivers match the same compatible?

> driver. It doesn't replace GPIO functionality itself. So both drivers
> have to be compiled in order to work with modern upstream DTs. This
> driver binds the older s5p_gpio driver during its own binding.
> 
> The pinctrl dt-bindings are incompatible to each other. This driver fixes

Can you highlight how they are incompatible? I think the pinctrl part is 
identical?

arch/arm/dts/exynos5250.dtsi

/ {
[...]
         pinctrl_0: pinctrl@11400000 {
                 compatible = "samsung,exynos5250-pinctrl";
                 reg = <0x11400000 0x1000>;
                 interrupts = <0 46 0>;

                 wakup_eint: wakeup-interrupt-controller {
                         compatible = "samsung,exynos4210-wakeup-eint";
                         interrupt-parent = <&gic>;
                         interrupts = <0 32 0>;
                 };
         };

         pinctrl_1: pinctrl@13400000 {
                 compatible = "samsung,exynos5250-pinctrl";
                 reg = <0x13400000 0x1000>;
                 interrupts = <0 45 0>;
         };

         pinctrl_2: pinctrl@10d10000 {
                 compatible = "samsung,exynos5250-pinctrl";
                 reg = <0x10d10000 0x1000>;
                 interrupts = <0 50 0>;
         };

         pinctrl_3: pinctrl@03860000 {
                 compatible = "samsung,exynos5250-pinctrl";
                 reg = <0x03860000 0x1000>;
                 interrupts = <0 47 0>;
         };
[...]
};

+ arch/arm/dts/exynos5250-pinctrl.dtsi

/ {
         pinctrl@11400000 {
                 gpa0: gpa0 {
                         gpio-controller;
                         #gpio-cells = <2>;

                         interrupt-controller;
                         #interrupt-cells = <2>;
                 };

                 gpa1: gpa1 {
                         gpio-controller;
                         #gpio-cells = <2>;

                         interrupt-controller;
                         #interrupt-cells = <2>;
                 };

                 gpa2: gpa2 {
                         gpio-controller;
                         #gpio-cells = <2>;

                         interrupt-controller;
                         #interrupt-cells = <2>;
                 };

                 gpb0: gpb0 {
                         gpio-controller;
                         #gpio-cells = <2>;

                         interrupt-controller;
                         #interrupt-cells = <2>;
                 };

                 gpb1: gpb1 {
                         gpio-controller;
                         #gpio-cells = <2>;

                         interrupt-controller;
                         #interrupt-cells = <2>;
                 };

                 gpb2: gpb2 {
                         gpio-controller;
                         #gpio-cells = <2>;

                         interrupt-controller;
                         #interrupt-cells = <2>;
                 };

                 gpb3: gpb3 {
                         gpio-controller;
                         #gpio-cells = <2>;

                         interrupt-controller;
                         #interrupt-cells = <2>;
                 };

                 gpc0: gpc0 {
                         gpio-controller;
                         #gpio-cells = <2>;

                         interrupt-controller;
                         #interrupt-cells = <2>;
                 };

                 gpc1: gpc1 {
                         gpio-controller;
                         #gpio-cells = <2>;

                         interrupt-controller;
                         #interrupt-cells = <2>;
                 };

                 gpc2: gpc2 {
                         gpio-controller;
                         #gpio-cells = <2>;

                         interrupt-controller;
                         #interrupt-cells = <2>;
                 };

                 gpc3: gpc3 {
                         gpio-controller;
                         #gpio-cells = <2>;

                         interrupt-controller;
                         #interrupt-cells = <2>;
                 };

                 gpd0: gpd0 {
                         gpio-controller;
                         #gpio-cells = <2>;

                         interrupt-controller;
                         #interrupt-cells = <2>;
                 };

                 gpd1: gpd1 {
                         gpio-controller;
                         #gpio-cells = <2>;

                         interrupt-controller;
                         #interrupt-cells = <2>;
                 };

                 gpy0: gpy0 {
                         gpio-controller;
                         #gpio-cells = <2>;
                 };

                 gpy1: gpy1 {
                         gpio-controller;
                         #gpio-cells = <2>;
                 };

                 gpy2: gpy2 {
                         gpio-controller;
                         #gpio-cells = <2>;
                 };

                 gpy3: gpy3 {
                         gpio-controller;
                         #gpio-cells = <2>;
                 };

                 gpy4: gpy4 {
                         gpio-controller;
                         #gpio-cells = <2>;
                 };

                 gpy5: gpy5 {
                         gpio-controller;
                         #gpio-cells = <2>;
                 };

                 gpy6: gpy6 {
                         gpio-controller;
                         #gpio-cells = <2>;
                 };

                 gpc4: gpc4 {
                         gpio-controller;
                         #gpio-cells = <2>;

                         interrupt-controller;
                         #interrupt-cells = <2>;
                 };

                 gpx0: gpx0 {
                         gpio-controller;
                         #gpio-cells = <2>;

                         interrupt-controller;
                         interrupt-parent = <&combiner>;
                         #interrupt-cells = <2>;
                         interrupts = <23 0>, <24 0>, <25 0>, <25 1>,
                                      <26 0>, <26 1>, <27 0>, <27 1>;
                 };

                 gpx1: gpx1 {
                         gpio-controller;
                         #gpio-cells = <2>;

                         interrupt-controller;
                         interrupt-parent = <&combiner>;
                         #interrupt-cells = <2>;
                         interrupts = <28 0>, <28 1>, <29 0>, <29 1>,
                                      <30 0>, <30 1>, <31 0>, <31 1>;
                 };

                 gpx2: gpx2 {
                         gpio-controller;
                         #gpio-cells = <2>;

                         interrupt-controller;
                         #interrupt-cells = <2>;
                 };

                 gpx3: gpx3 {
                         gpio-controller;
                         #gpio-cells = <2>;

                         interrupt-controller;
                         #interrupt-cells = <2>;
                 };
         };

         pinctrl@13400000 {
                 gpe0: gpe0 {
                         gpio-controller;
                         #gpio-cells = <2>;

                         interrupt-controller;
                         #interrupt-cells = <2>;
                 };
                         #gpio-cells = <2>;

                         interrupt-controller;
                         #interrupt-cells = <2>;
                 };

                 gpe1: gpe1 {
                         gpio-controller;
                         #gpio-cells = <2>;

                         interrupt-controller;
                         #interrupt-cells = <2>;
                 };

                 gpf0: gpf0 {
                         gpio-controller;
                         #gpio-cells = <2>;

                         interrupt-controller;
                         #interrupt-cells = <2>;
                 };

                 gpf1: gpf1 {
                         gpio-controller;
                         #gpio-cells = <2>;

                         interrupt-controller;
                         #interrupt-cells = <2>;
                 };

                 gpg0: gpg0 {
                         gpio-controller;
                         #gpio-cells = <2>;

                         interrupt-controller;
                         #interrupt-cells = <2>;
                 };

                 gpg1: gpg1 {
                         gpio-controller;
                         #gpio-cells = <2>;

                         interrupt-controller;
                         #interrupt-cells = <2>;
                 };

                 gpg2: gpg2 {
                         gpio-controller;
                         #gpio-cells = <2>;

                         interrupt-controller;
                         #interrupt-cells = <2>;
                 };

                 gph0: gph0 {
                         gpio-controller;
                         #gpio-cells = <2>;

                         interrupt-controller;
                         #interrupt-cells = <2>;
                 };

                 gph1: gph1 {
                         gpio-controller;
                         #gpio-cells = <2>;

                         interrupt-controller;
                         #interrupt-cells = <2>;
                 };

         };

         pinctrl@10d10000 {
                 gpv0: gpv0 {
                         gpio-controller;
                         #gpio-cells = <2>;

                         interrupt-controller;
                         #interrupt-cells = <2>;
                 };

                 gpv1: gpv1 {
                         gpio-controller;
                         #gpio-cells = <2>;

                         interrupt-controller;
                         #interrupt-cells = <2>;
                 };

                 gpv2: gpv2 {
                         gpio-controller;
                         #gpio-cells = <2>;

                         interrupt-controller;
                         #interrupt-cells = <2>;
                 };

                 gpv3: gpv3 {
                         gpio-controller;
                         #gpio-cells = <2>;

                         interrupt-controller;
                         #interrupt-cells = <2>;
                 };

                 gpv4: gpv4 {
                         gpio-controller;
                         #gpio-cells = <2>;

                         interrupt-controller;
                         #interrupt-cells = <2>;
                 };

         };

         pinctrl@03860000 {
                 gpz: gpz {
                         gpio-controller;
                         #gpio-cells = <2>;

                         interrupt-controller;
                         #interrupt-cells = <2>;
                 };

         };
};

vs dts/upstream/src/arm/samsung/exynos5250.dtsi

/{
[...]
                 pinctrl_0: pinctrl@11400000 {
                         compatible = "samsung,exynos5250-pinctrl";
                         reg = <0x11400000 0x1000>;
                         interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;

                         wakup_eint: wakeup-interrupt-controller {
                                 compatible = 
"samsung,exynos4210-wakeup-eint";
                                 interrupt-parent = <&gic>;
                                 interrupts = <GIC_SPI 32 
IRQ_TYPE_LEVEL_HIGH>;
                         };
                 };

                 pinctrl_1: pinctrl@13400000 {
                         compatible = "samsung,exynos5250-pinctrl";
                         reg = <0x13400000 0x1000>;
                         interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
                 };

                 pinctrl_2: pinctrl@10d10000 {
                         compatible = "samsung,exynos5250-pinctrl";
                         reg = <0x10d10000 0x1000>;
                         interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
                 };

                 pinctrl_3: pinctrl@3860000 {
                         compatible = "samsung,exynos5250-pinctrl";
                         reg = <0x03860000 0x1000>;
                         interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
                         power-domains = <&pd_mau>;
                 };

+ dts/upstream/src/arm/samsung/exynos5250-pinctrl.dtsi

&pinctrl_0 {
         gpa0: gpa0-gpio-bank {
                 gpio-controller;
                 #gpio-cells = <2>;

                 interrupt-controller;
                 #interrupt-cells = <2>;
         };

         gpa1: gpa1-gpio-bank {
                 gpio-controller;
                 #gpio-cells = <2>;

                 interrupt-controller;
                 #interrupt-cells = <2>;
         };

         gpa2: gpa2-gpio-bank {
                 gpio-controller;
                 #gpio-cells = <2>;

                 interrupt-controller;
                 #interrupt-cells = <2>;
         };

         gpb0: gpb0-gpio-bank {
                 gpio-controller;
                 #gpio-cells = <2>;

                 interrupt-controller;
                 #interrupt-cells = <2>;
         };

         gpb1: gpb1-gpio-bank {
                 gpio-controller;
                 #gpio-cells = <2>;

                 interrupt-controller;
                 #interrupt-cells = <2>;
         };

         gpb2: gpb2-gpio-bank {
                 gpio-controller;
                 #gpio-cells = <2>;

                 interrupt-controller;
                 #interrupt-cells = <2>;
         };

         gpb3: gpb3-gpio-bank {
                 gpio-controller;
                 #gpio-cells = <2>;

                 interrupt-controller;
                 #interrupt-cells = <2>;
         };

         gpc0: gpc0-gpio-bank {
                 gpio-controller;
                 #gpio-cells = <2>;

                 interrupt-controller;
                 #interrupt-cells = <2>;
         };

         gpc1: gpc1-gpio-bank {
                 gpio-controller;
                 #gpio-cells = <2>;

                 interrupt-controller;
                 #interrupt-cells = <2>;
         };

         gpc2: gpc2-gpio-bank {
                 gpio-controller;
                 #gpio-cells = <2>;

                 interrupt-controller;
                 #interrupt-cells = <2>;
         };

         gpc3: gpc3-gpio-bank {
                 gpio-controller;
                 #gpio-cells = <2>;

                 interrupt-controller;
                 #interrupt-cells = <2>;
         };

         gpd0: gpd0-gpio-bank {
                 gpio-controller;
                 #gpio-cells = <2>;

                 interrupt-controller;
                 #interrupt-cells = <2>;
         };

         gpd1: gpd1-gpio-bank {
                 gpio-controller;
                 #gpio-cells = <2>;

                 interrupt-controller;
                 #interrupt-cells = <2>;
         };

         gpy0: gpy0-gpio-bank {
                 gpio-controller;
                 #gpio-cells = <2>;
         };

         gpy1: gpy1-gpio-bank {
                 gpio-controller;
                 #gpio-cells = <2>;
         };

         gpy2: gpy2-gpio-bank {
                 gpio-controller;
                 #gpio-cells = <2>;
         };

         gpy3: gpy3-gpio-bank {
                 gpio-controller;
                 #gpio-cells = <2>;
         };

         gpy4: gpy4-gpio-bank {
                 gpio-controller;
                 #gpio-cells = <2>;
         };

         gpy5: gpy5-gpio-bank {
                 gpio-controller;
                 #gpio-cells = <2>;
         };

         gpy6: gpy6-gpio-bank {
                 gpio-controller;
                 #gpio-cells = <2>;
         };

         gpc4: gpc4-gpio-bank {
                 gpio-controller;
                 #gpio-cells = <2>;

                 interrupt-controller;
                 #interrupt-cells = <2>;
         };

         gpx0: gpx0-gpio-bank {
                 gpio-controller;
                 #gpio-cells = <2>;

                 interrupt-controller;
                 interrupt-parent = <&combiner>;
                 #interrupt-cells = <2>;
                 interrupts = <23 0>, <24 0>, <25 0>, <25 1>,
                              <26 0>, <26 1>, <27 0>, <27 1>;
         };

         gpx1: gpx1-gpio-bank {
                 gpio-controller;
                 #gpio-cells = <2>;

                 interrupt-controller;
                 interrupt-parent = <&combiner>;
                 #interrupt-cells = <2>;
                 interrupts = <28 0>, <28 1>, <29 0>, <29 1>,
                              <30 0>, <30 1>, <31 0>, <31 1>;
         };

         gpx2: gpx2-gpio-bank {
                 gpio-controller;
                 #gpio-cells = <2>;

                 interrupt-controller;
                 #interrupt-cells = <2>;
         };

         gpx3: gpx3-gpio-bank {
                 gpio-controller;
                 #gpio-cells = <2>;

                 interrupt-controller;
                 #interrupt-cells = <2>;
         };
[...]
};

&pinctrl_1 {
         gpe0: gpe0-gpio-bank {
                 gpio-controller;
                 #gpio-cells = <2>;

                 interrupt-controller;
                 #interrupt-cells = <2>;
         };

         gpe1: gpe1-gpio-bank {
                 gpio-controller;
                 #gpio-cells = <2>;

                 interrupt-controller;
                 #interrupt-cells = <2>;
         };

         gpf0: gpf0-gpio-bank {
                 gpio-controller;
                 #gpio-cells = <2>;

                 interrupt-controller;
                 #interrupt-cells = <2>;
         };

         gpf1: gpf1-gpio-bank {
                 gpio-controller;
                 #gpio-cells = <2>;

                 interrupt-controller;
                 #interrupt-cells = <2>;
         };

         gpg0: gpg0-gpio-bank {
                 gpio-controller;
                 #gpio-cells = <2>;

                 interrupt-controller;
                 #interrupt-cells = <2>;
         };

         gpg1: gpg1-gpio-bank {
                 gpio-controller;
                 #gpio-cells = <2>;

                 interrupt-controller;
                 #interrupt-cells = <2>;
         };

         gpg2: gpg2-gpio-bank {
                 gpio-controller;
                 #gpio-cells = <2>;

                 interrupt-controller;
                 #interrupt-cells = <2>;
         };

         gph0: gph0-gpio-bank {
                 gpio-controller;
                 #gpio-cells = <2>

                 interrupt-controller;
                 #interrupt-cells = <2>;
         };

         gph1: gph1-gpio-bank {
                 gpio-controller;
                 #gpio-cells = <2>;

                 interrupt-controller;
                 #interrupt-cells = <2>;
         };
[...]
};

&pinctrl_2 {
         gpv0: gpv0-gpio-bank {
                 gpio-controller;
                 #gpio-cells = <2>;

                 interrupt-controller;
                 #interrupt-cells = <2>;
         };

         gpv1: gpv1-gpio-bank {
                 gpio-controller;
                 #gpio-cells = <2>;

                 interrupt-controller;
                 #interrupt-cells = <2>;
         };

         gpv2: gpv2-gpio-bank {
                 gpio-controller;
                 #gpio-cells = <2>;

                 interrupt-controller;
                 #interrupt-cells = <2>;
         };

         gpv3: gpv3-gpio-bank {
                 gpio-controller;
                 #gpio-cells = <2>;

                 interrupt-controller;
                 #interrupt-cells = <2>;
         };

         gpv4: gpv4-gpio-bank {
                 gpio-controller;
                 #gpio-cells = <2>;

                 interrupt-controller;
                 #interrupt-cells = <2>;
         };
[...]
};

&pinctrl_3 {
         gpz: gpz-gpio-bank {
                 gpio-controller;
                 #gpio-cells = <2>;

                 interrupt-controller;
                 #interrupt-cells = <2>;
         };
[...]
};

I can see the interrupts property in the pinctrl@ node is 0 vs 4 
(IRQ_TYPE_LEVEL_HIGH) and the node name is slightly different (I don't 
think it matters).

The pinctrl nodes are also in the root (/) node in U-Boot, while in 
upstream DTS it's under /soc (don't think it matters provided something 
takes care of probing /soc and its children?).

The gpio nodes have an additional -gpio-bank suffix in upstream DTS, 
don't think it matters either.

There are additional pinconf/pinmux/pingroups (I believe?) nodes but 
those don't have a gpio-controller property so they shouldn't matter?

I must be missing something, can you tell me what?

> pinctrl with upstream DTs and the older one must be used on it's own
> when relying on U-Boots deprecated DTs.
> 
> DTs are provided by U-Boot itself, at least that's the case on my device
> (exynos5250-manta).
> 
> If I understood you correctly, we could modify the deprecated exynos5250.dtsi
> to fix this situation. But I don't know about possible side effects
> and I'm not that experienced in kernel/bootloader development. Is this an option?
> 
> I had split the gpio symbol into it's own thing before and could add that
> back into v4 but it's functionally the same. (Both drivers needed for
> upstream DT)
> 

No, I think it's fine to have pinctrl and GPIO split like you suggested 
here.

Can you explain what makes your pinctrl driver require the upstream 
Device Tree (the one in dts/) and cannot work with the U-Boot device 
tree (the one in arch/arm/dts)?

We have a problem if it's requiring an upstream Device Tree because your 
new driver doesn't enforce it (via a depends on OF_UPSTREAM in Kconfig), 
and we have one if it doesn't, because the ifdefery in s5p_gpio is then 
incorrect as you can compile with CONFIG_S5P AND 
CONFIG_PINCTRL_EXYNOS5250 with both trying to bind against the same 
compatible.

I think what you want in the second patch (provided I'm right the 
pinctrl driver can work with the U-Boot DTS) is instead:

#if CONFIG_IS_ENABLED(PINCTRL) && IS_ENABLED(CONFIG_PINCTRL_EXYNOS5250)
  	{ .compatible = "samsung,exynos5250-pinctrl" },
#endif

and add a nice comment around those lines to say that we do this because 
drivers/pinctrl/exynos/pinctrl-exynos5250.c binds against the same 
compatible and will also bind s5p_gpio against the same node.

Otherwise, my suggestion was to maybe remove the compatible entirely 
from s5p_gpio. For that, you'd need to make sure the new driver is 
compatible with the device tree they are using (I'm assuming U-Boot 
device tree and not upstream) and you'd need to enable CONFIG_PINCTRL 
(and possibly CONFIG_SPL/TPL_PINCTRL) + CONFIG_EXYNOS5250 for defconfigs 
where CONFIG_S5P is enabled (and in all xPL/proper phases, depending on 
which CONFIG_GPIO and CONFIG_SPL/TPL_GPIO is enabled).

Maybe there's also a path to migrate the four Exynos5250 defconfigs to 
use upstream Device Tree but one would need to compare the current 
U-Boot device tree we have and the upstream one (in dts/) and check that 
all drivers are compatible with the upstream device tree before 
switching them. Not a requirement for your series, but it'd be nice as a 
follow if this is something I can convince you into having a look :)

Cheers,
Quentin
