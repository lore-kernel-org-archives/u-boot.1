Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D679C4452B
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 11:07:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3050838D7;
	Mon, 20 Jul 2026 13:07:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="WJf82O0l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38F5383E76; Mon, 20 Jul 2026 13:07:14 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D48D880517
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 13:07:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bs72wbHEXWvPOl3nQgStxBp1FcvLXlq0uMZgD1qxaWar2RKZ0kpK3bqhNTyaE/+nhPIO45VdySPoBbu8nvEhEpc7MlcP5GNDBniBnRdTdeeoZXkViueNKpqNrtUGiR3p/RGGxxvQ96M/D5436OPVM/vcAA9LwVUxfrgz1M8NoIlbCvQuV8bwRfYMNt0f4s27RwjtJQeA55Td+a3Ap3rJ1AXqvTcvvuxURD37xfUNTqOttDKuzy3CJ30dqmSp9Qc4D8A9msRkJ+Pw8jr5RFPsJOcSaDjL03rQPVdX0yue+Cp3fFtyAUz7mXhOZMoy8jKBhHDf4ql5G1c50w/uG3gjOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EuD7jk1+MJVwy237d3fpfbmEcoBcYV/CXwZ4Z3nhOR0=;
 b=ZN29cI8n+tUY2H4Pmp2v3KALnAqGxYsCzVEEfrq4utNNa42pubSM7McTpc3MFQrFEw3y6WHJpOsRtkaLjOqFxFzahOmP+76GSmzHNgYDPoi+BhuZp6O7ymv3UHvmvMTpo1Vf7512LEFHlCbShkvx05rk3WwwrivyqUnW5XlgCaCsTvVuzewDudhiW03o/cVEzgOCa9iO0h4YRrvEvcDurjkBavODZ6F9IW7R9PBgYzlCPjNUvhmZe8c0wJ8BoCg+AMf16sW9KPWp9IrChMLURSOLv1fUQYzs9zYR/zmYJtKKTED27SKifWBUJG+8Y6/dpXSWvCyc779T5cSknjLICg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EuD7jk1+MJVwy237d3fpfbmEcoBcYV/CXwZ4Z3nhOR0=;
 b=WJf82O0lg3g4q6uDl+gsIMntkDG1vzBCsQqQUJia3S5e7Mr23VqVOolss3kJW9czLM6OHDO43M+evskM57BDULDvW4WNmhnUuqFR8hq91Z79z0PYkaLm0PV3BUgixlMmxxJzgZ+NS5pcEjfEnXGmb7zEmjPHF6YxxWkJMQNtFR4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by PA1PR04MB10793.eurprd04.prod.outlook.com (2603:10a6:102:485::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 11:07:06 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0223.012; Mon, 20 Jul 2026
 11:07:06 +0000
Message-ID: <553e5d2b-201d-43da-9c01-e5e699aeae47@cherry.de>
Date: Mon, 20 Jul 2026 13:07:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: rk3568-nanopi-r5s: drop eMMC HS400 modes from
 the U-Boot FDT
To: Peter Robinson <pbrobinson@gmail.com>, Tianling Shen <cnsztl@gmail.com>
Cc: daniel@makrotopia.org, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <09e8f60c19d19b1bef47594e89de52585e6405ad.1784423890.git.daniel@makrotopia.org>
 <CAOP2_ThcJNDU1Q8Otvg37LXjOTZGVoR5XruDBBypGqJ3Q8E=KQ@mail.gmail.com>
 <CALeDE9MQsvqUryOeHogR87t8Et7JZ6NbzqjXknxz9ipcjOFxXw@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CALeDE9MQsvqUryOeHogR87t8Et7JZ6NbzqjXknxz9ipcjOFxXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR09CA0116.eurprd09.prod.outlook.com
 (2603:10a6:803:78::39) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|PA1PR04MB10793:EE_
X-MS-Office365-Filtering-Correlation-Id: 58c39309-3e3e-43ee-727a-08dee64f090d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|7416014|376014|18002099003|22082099003|4143699003|4133799003|3023799007|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 96erxCv1A36r3f4Cx1rCa4nc+MUHBhxZlnQuDpD+anS4mXDyqsQuasN+hhQT7m9Gt5JZxX1fvSSUGn7IwCzCtNGms8J9NquUmR/6EYcaXIBnRtOSy6Frp4b7dBGhxyEHTh0k3BYuxI4n2lPLfdpCDMEfKOVxqsqKcJR4yxPjWPu3/gfpagOnwRzm4l/kcFR38gxb6Ge2SUWFMYPZGZFlyUXlN4mCQawuo98suUjBPJIEK/JxJiDShSFtb8CfaCYPGCY3GyYtvnMvef7D3YCscrp2BZk+Je3qgC/INV1sdNXf2G30BWV9pteGmmT7dsCOW/TP+Jt2gSHVerwTQ5mJ9SQhnAVKFxMI0WbWQ5tfEO0zwugObBPry2qJe1jAOvzp+h/EqNSAk05ukbSWnsfHvgyhiY+OsqAQM1EriVQ8ROvMukg+WtvUy6p37Z9Wwl9n5pD7g7TDQil8pA6XSGhD4FsungRgmTa3IiUGy78a4swAXhc2pw2rg18rUDBKET5NUSP8o3C34OvcEnPuzRqZO7vS/SuclLzyrIb+x5mue5d4PCZjJSCncvnNQ1cVoaAhbyc7fWjzCI7ndt6gae+0Q7w5D5iUETZRU8EJ0n+SzZIezhI2MzDuOOgVgqOV8+Y1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(18002099003)(22082099003)(4143699003)(4133799003)(3023799007)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVQ0eWhCZTI4OFR1QVhWdTFCc1VOZTJ2S0xMMVlBa3BKRW1YMzMrT0VPUGU2?=
 =?utf-8?B?WFg5aU9ZU0cvUytON3llZUw0NlpLNVViNXhnN29ZU0V2d0d6MzBqQU55SlJs?=
 =?utf-8?B?NmRtbmpyV1RvZ2dyaEpvSGpzV2lWVXU3UERnUTdJVnNuYStvUmt6Q2Z1Slp6?=
 =?utf-8?B?QzF1aDdYeTFaZWgveXhGTFE5UWxEK3l2cDNTK05RZlRDWVNzT2ZyM3Voc1hw?=
 =?utf-8?B?Y1lkdnVoYXJ5WDJKRUdkRlhwT2M4MVhSTDJ2UUVMM2ZVVE5EUlFSdktIeHNJ?=
 =?utf-8?B?T29vYnllVHV6RFJJWmpQMGt2NGZpc0p3RFhtQTNESnZYTjVGSjdoSWFkZFpy?=
 =?utf-8?B?L1EzMk1qSkwyOXRrWjUraWtUYWhwNlQreVRLc1J1WDVFMnllU24ycjlnRThw?=
 =?utf-8?B?UnJkazYwM1kyQTBLMm00NWFXWVByMnRyOVg5K0RKRmdCY1ZjaHVUMnZVZUJj?=
 =?utf-8?B?SUVIT1B0bHVyWEZwMkdDQzVaSUJzSXRoQ1Exdi80YTdxUlRWZDRtWTJDOHlK?=
 =?utf-8?B?QWpjcnEyckNOeDJzS2FvNkRIRnREOXhaSUhac1IvK2kzS3FFSjFneXVEWFJY?=
 =?utf-8?B?bWRtSTVWNFk0eVpCckdrQytEM0RnaEpRdVNvZVJQVURyWjJJS2ZGWFFUWDZC?=
 =?utf-8?B?UXh3ZE1abmlocUxEcmh1WlYvTmlNTVFYUjhCY0JNVlRTZm9PVjFCb1VFMUpB?=
 =?utf-8?B?SFRzNEVIUEUxY1MvRTAraFIxQ09VVFFsOWFWem1SZjlyQkZOUm5QcUI5eEox?=
 =?utf-8?B?ZnpSRiszSkhIeWFnK0c2VlgrcnZBVGtGanl4TUJQdTVmT25iaHFrUTBqMXFH?=
 =?utf-8?B?MW5aOTdCV1VJcHhhT0lhTGNiRjgxM21OWThZeHF4SHZqUG1XV1ZLdjNRVEFZ?=
 =?utf-8?B?YUxkNnhkZi9DNzlIMmFpbStxWHNYSFBlZG9ZUkVUT0gzVkRPSGtCZDVPRHZn?=
 =?utf-8?B?Uno0aGJVdTZ3Qjd0cHZocUkwTjFEc1BTWHVSekpjRW00dGNUREZtd3I1clo4?=
 =?utf-8?B?UWsrQmFBUUF0REJxZlpGa29iTUhodE5sbWgwcW5HYXdRdDZBMnNpcGVyc01a?=
 =?utf-8?B?OXJkTlZRazVzWmNud2JFZDNibG9PazZoSTBIK1p0d3dSMEQ1aDJFYnhqeXRi?=
 =?utf-8?B?aXR2RkNEV3c2RmlDcHh2OG1VbUx0N3F4Y3BsSkZYYnErQUZHVmRrNEhFdHJx?=
 =?utf-8?B?ejZkQUlOeVd0M1dVdEVFejJmUElEN2ZCWG9Yc2o2NCt4U1V1V21kcXJ4QXor?=
 =?utf-8?B?OFlIdVc0cnA1Ykh3aGlTUkkvQ3h3Slo0QXk4R2kwQ1FZSDlyQ1R5MXVYeUdv?=
 =?utf-8?B?dkVJdVIzU3o5NXVaS3JjL1lhdzFGTXdqV2w1SGMwTTJlNFJDdjNEb0x1NlNF?=
 =?utf-8?B?YjJ3NWhmRnRNdm5tZjNlU0pTd3ZJaFVYWnh3VHNVcnNyOXJZL05wYmEwOG5K?=
 =?utf-8?B?UG9Xd0JIYXUrV2dkSDlxaEFqU3FLS0tzUUFMYWFtanhicTNtZVlEbUNDajBL?=
 =?utf-8?B?bzl5WGJmLzF4MGlHRmtMb3N3ZEMxQ1RuMFdVL0lyMVBOOEsvZFpaZDBkNlZE?=
 =?utf-8?B?U1E0dzBjaEpFZUZlVzYwZVFsT0lCRnFpTUVyUGFpWXJjWGFWUWpDZnM0VmVr?=
 =?utf-8?B?VjhLdURuaHA1M25ka1J5Z2R2UFpEM2dMVkxjd0ptWnplbERJQTNSTStGVGlG?=
 =?utf-8?B?bVZNTDdwSnFWRHF5OXozMUVCQ21TS1VXNXI2SUt0N2V2MlJxWS9tOHFPdVNM?=
 =?utf-8?B?S0FFbkZIL3JPTGk5TTVKRW9lU3MyR3BVcWorUjU3U0dTaUUwaDZDcThmMmcy?=
 =?utf-8?B?S3lzMTlSVFd4T0dQY1ZpNk0vTTJLdlFqNitQenhVdHJyay9QQnVOWVUvSkJF?=
 =?utf-8?B?VzZJREFOVFpxWkd2VndSSndBaHgvdTlTQzB3Sm43Q1l5ajdqdlBnZ05aOHU0?=
 =?utf-8?B?UmdHWGdHbVNLSFBVQ0NCeTI4RjdpR0hQR3hxSUJ4WTJ3WlhUUFo4d29DYUhm?=
 =?utf-8?B?YmR4ODJ5OTdEejIvZVIvM1hpSlE5SGs1ZlFxVEJoL09xbkxvVW9MZER0MHFH?=
 =?utf-8?B?VW5zcFBIN2wzWkRMc1lBRFdHYjRzY1RqWm1qQnB5QWVwWEIyS1FtUGZCUUZ4?=
 =?utf-8?B?dkVFQ1NyL3JQM0hETXQzbkdaN1FQZWtCM2ZhTTd4S2hVMmdNSysxdVI0V3o1?=
 =?utf-8?B?a1pqM05DQWhaWEx6MnI2U2xNeEZWb0dTc2lUZytlNkZVTkhOQ2YvQlNUd1JY?=
 =?utf-8?B?U0Q4Q1RhZHRBVlRpbm9ORitoUko3OHRBZ1ZHbnNBWmsyWStlYUNkYWpuZEVt?=
 =?utf-8?B?QUx1V3dKaTVkZTRhclpwRER1MysvZkVGbVpTSENPeU9VU3NVcFZhdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c39309-3e3e-43ee-727a-08dee64f090d
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 11:07:06.3339 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RoPDulC7iyx/yQlhlObK8DGwBpMq0bzkk0jmr4NGuEJ+hTmLZptcwviJNxUII7j+ZEzA4QOMz9a1HQ0fyLndEVJeZL1GyVCc0Rv4qXT8KAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10793
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

Hi Peter,

On 7/20/26 9:59 AM, Peter Robinson wrote:
> On Mon, 20 Jul 2026 at 02:59, Tianling Shen <cnsztl@gmail.com> wrote:
>>
>> Hi Daniel,
>>
>> On Sun, Jul 19, 2026 at 9:53 AM Daniel Golle <daniel@makrotopia.org> wrote:
>>>
>>> U-Boot passes its control FDT to Linux, so the &sdhci override adding
>>> mmc-hs400-1_8v and mmc-hs400-enhanced-strobe reached the kernel, which
>>> unlike U-Boot actually drives those modes and then failed on the eMMC.
>>> Keep HS200, which works, and leave HS400 out. Affects the R5C too, which
>>> includes this dtsi.
>>>
>>> Fixes: 0ef326b5e92e ("rockchip: rk3568: Add support for FriendlyARM NanoPi R5S")
>>> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>>> ---
>>>   arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi | 2 --
>>>   1 file changed, 2 deletions(-)
>>>
>>> diff --git a/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi b/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
>>> index 64c43374c04..7e0b2ba02e4 100644
>>> --- a/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
>>> +++ b/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
>>> @@ -15,8 +15,6 @@
>>>   &sdhci {
>>>          cap-mmc-highspeed;
>>>          mmc-hs200-1_8v;
>>> -       mmc-hs400-1_8v;
>>> -       mmc-hs400-enhanced-strobe;
>>>          pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
>>>   };
>>
>> The whole sdhci node can be removed from u-boot.dtsi since these props
>> are already included by upstream dts.
> 
> I've already sent a patch to do exactly this, it was on my list to
> chase up for this cycle:
> https://lists.denx.de/pipermail/u-boot/2025-December/605369.html
> 

I can merge that patch once my question there gets an answer :)

Cheers,
Quentin
