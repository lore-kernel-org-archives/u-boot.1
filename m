Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E50DAC47422
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 13:46:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2865879A2;
	Fri, 26 Jan 2024 14:46:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="WyKo71eR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEA6187B63; Fri, 26 Jan 2024 14:46:21 +0100 (CET)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D82DD8786E
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 14:46:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJeZj3SeU06Z+V5RUptfuRGwNib3ct1Jt8sL9pP8nZelgORIXQ7yS79CGG+kCa+KTsrDoM0TMy0YlXFEsmo3TO10MdTnZKalln1L8KE0PFCdiyb68gMfV1GbckaQc4TxeED3u/cnvSxMWCQwsYaR5jzSiDTut+for1pzfHV8r/hUc0QZAmij4HroL9a5F4B22Tqur15265g+iV+W4HjlAxq9dS0NlYYrJr8Qp49O6+kvQx556tB3pXKQVTpt62Kw5HcGl6Tt5T3wGjROvpbPhMbNTtoJP4DGKt+p2N1wTTtB8+SIWRfrJRX7PToID0IB7w2qQ+vgVYRneit0D0iRKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdYc2E8JBKif3FgS+mwyZWl+4SBq5f1Rt3X7/CHGA5U=;
 b=SuoGL+EMDZvU1ucvid43iJodgjUAcbpZuTrhk8xPS4kpLeVZJo82f3B+mH6rWy0RlgQcS06I43/t1qdgG4gurf3FZqI1hudzLXnQhSkALaxz3dqbaaquxm4qSDre4gWKamDp7S/rhLe5fwly5quJ9OxolKF9h8HkLRQ09EyfJGvMTs/yja5+Y2XmYME5oJ2MUddJhsr6bO95YO49gQnuFNZhiGgjT3oKTc9SNungQlpOvvXzq9qqmr5abJE2dWhON3XkoHpz+guSKtnaA1tJtfZGkWYy1h+qrHIJ2CnF8QcrTV2gQvmox5klD59MIZ8fEEbNhcI7orZv9wLr2dt72Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdYc2E8JBKif3FgS+mwyZWl+4SBq5f1Rt3X7/CHGA5U=;
 b=WyKo71eR3f7E/J4b1d6/eeo4LtZKYUM6WdRrlR50E+KEBw89CH0o2mKixzLmscrZ/QvWQV6yXdc1GvrRWrZBuBII0bFTOv0Iia9wNn2oFKOgR9LVBbD4MHDtOVAHEMbLOlVC5Oepf7ZNi9isfsQJ4xdzfvVe9+WyGIu2FtIGSxI0sAXWgm+rBRWK8nQrBDHlFcPo0J3vuGaAHRRmpKh0MTtGx9g9vh/ZqeLB0bhN1t67n5zOhR1NHZYb2Zx0UE4SgTzX0dwhP0Lu0VcxG8XBS51jX9j6R2M5ccOVYxI2aM+8Fs/X3qoCuSUHF5Hw5THOc68SPo96t4IiuEMsSjHaTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by DBAPR04MB7240.eurprd04.prod.outlook.com (2603:10a6:10:1af::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 13:46:15 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e%4]) with mapi id 15.20.7228.022; Fri, 26 Jan 2024
 13:46:15 +0000
Message-ID: <0e3cc574-23bc-4a0d-9f1b-421e5bce77b7@theobroma-systems.com>
Date: Fri, 26 Jan 2024 14:46:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/18] rockchip: rk3588: fix non-working SD controller if
 booting from other media
Content-Language: en-US
To: Dragan Simic <dsimic@manjaro.org>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, =?UTF-8?B?5rSq5oWn5paM?=
 <hhb@rock-chips.com>, heiko@sntech.de, u-boot@lists.denx.de
References: <20240123-jaguar-v1-0-1eec1c34953c@theobroma-systems.com>
 <20240123-jaguar-v1-13-1eec1c34953c@theobroma-systems.com>
 <10ebfefd-1619-4b08-b15d-ec8ca8e798f3@rock-chips.com>
 <c33d0c58-cd95-490f-9514-8d61e1e70925@theobroma-systems.com>
 <31e7cb6e-7ef1-4069-a38e-b61677a8d76e@rock-chips.com>
 <2f6e9491-9ae1-498c-b269-c0a8fbe27552@theobroma-systems.com>
 <609c74a8-80b0-48a2-ae0a-78264014accd@rock-chips.com>
 <82b8fd76-8a84-4253-93b0-bf1bde85121b@theobroma-systems.com>
 <0a9a81f47864fd566206f5e62c3df192@manjaro.org>
 <daf26efb-888c-4903-b8b1-c6d72556fe9c@theobroma-systems.com>
 <4000d538ec88400f0ceaa9f13b6cd489@manjaro.org>
 <31404375-a811-459c-b9d6-87333550954a@theobroma-systems.com>
 <cd2927612a52bf88b7a2b2c937ccd62f@manjaro.org>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <cd2927612a52bf88b7a2b2c937ccd62f@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::6) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|DBAPR04MB7240:EE_
X-MS-Office365-Filtering-Correlation-Id: 82c72251-0f4f-46b1-8cfb-08dc1e752a40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dLFEGpywrM2sceuxcetLmzk13SQnvXTsZ1K+oxsjqmPUWnRIVZouNicoFpC6//60ScCAafGM0IM6Jvu2gaRjEwsO8Z1l90VyWyu+9RjSi1Xl51SRr4gt+KjmxKDUZJY9kRj8nd2n5P/LKS2VaDGToqB89JZZNbwVhBaEoKIwNplzrMy+edZxXZxgm5IjXxRixKdlIQZX7cnucJJlXDk5YGj1z6o02JaNK4O63m+Fh93s/m/F8f7Kmf5y14gVhk2+SzfeOy29p3/s69i9sCD1PXTLd4mCAYAVblVWmcGcn9pYL+tTrlq+lEomMdakzBsAwnp59qLBcnpBm7B0miKuqH4AOb3ar9HotduQpQNY8kOIqlSEJNtig1ii/OaUHPHVs7VkvQ80LNUqVNdSTmY5U185X9KEnqUy1zZlhD8XjBwcQtnV2KLSSf/knOwiFNnz+uEXRyMScSuJbkiipSFFXbvauB/wPp1dMLHqIDW57KRhkDpxXQMHMcg+E6turx7FZk33fdq2NB1QTnCgQUpia33a1OF+CXbAxLwovgGH/K93f+p3/cvktLwlgoDGLaGuytTSbDV0qOkrC97Lza0xTgxroZtpvXW+rIj6GPQPwJ/z8MdhoytEaVBjlmJgQ37Q
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39840400004)(366004)(136003)(376002)(396003)(346002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(31686004)(83380400001)(36756003)(86362001)(31696002)(8936002)(44832011)(4326008)(5660300002)(8676002)(53546011)(38100700002)(2616005)(316002)(7416002)(66556008)(54906003)(66476007)(6916009)(66946007)(6486002)(6512007)(2906002)(478600001)(41300700001)(6506007)(6666004)(966005)(45080400002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjdtWXFnQTFOdFdyWFRFV1pNRTZtQ0l0R253V0V2S0lBaW14UFBtcmhoNXFl?=
 =?utf-8?B?SVo1ejJrRW91b1VJellUeFR2bzVQUGNUUWI5SXNKUkRIZEVBL3JPZzg3eGRT?=
 =?utf-8?B?K1NLZW16NzduSDR6ekFUSEkvc3ZJV1A3aG9NSHYzUWdqV2RKMnpIZkFhTFph?=
 =?utf-8?B?OU5YMklhYnd0cS9IZGJ6bG9hcmJYWFhGK3BWazR2Z2pPVEIxRzN6RFIwSE5Q?=
 =?utf-8?B?cG9SVUpZTU1IcUhMNThXVDhXVXlQanN3bHU3VVBJTFgxRnZvN2xYZ0hBZ0tF?=
 =?utf-8?B?Wjg3RUVSOGpCeUtXNmFHT3U5eWU3RTVVdUtZc2IvRmFtUk1ZWFZ1S0RJYWlJ?=
 =?utf-8?B?Q01iU3o4ZDdTSzFDbVY1RXQxU0lMT0dGRVBKdEhDTEI2dVJ2cEJOc2ZUUE94?=
 =?utf-8?B?V1FnOHJxWW4vQnEvbjJvVUNtTmJXRmpmRzY2VUJEMGxjZXR6V0hyRm1FT0FL?=
 =?utf-8?B?RVVsZ2lPUHNlL1BURTRybWJwWEZSMFBaWWtxaml6MkhQQ0tOVzEraW1JeWZu?=
 =?utf-8?B?YnpJOS9aZ1BzM1NFRGwvK3BkamFqTzVHNHFMZE1Yb2l4N0ZGTVNSYmZPYWJ6?=
 =?utf-8?B?Z25vSGltNWNVc085R3kwMkp5Smh0ZHQ2TjVKWlFmMXhZMHpNV0NOTlZKSGRV?=
 =?utf-8?B?SFFLeDFCTk04dFVIeUFJRFA4Wm5JTldNbldoZUhCZmRaZWk5Y3pLcUZtblV3?=
 =?utf-8?B?Ri9FT2xKY2p1cHQ1a1hVQ3l1V0NPQWtJYlNLaFB1eDc2U0tlVEhDL2dhZnVp?=
 =?utf-8?B?Y3NOTkdmTnAvQ1B5d1lneGYrT29BeEV2dFFHalJ4YmtraWcwbWhVdlZVMGNJ?=
 =?utf-8?B?aWIyOE13RVFHbE85WFplN3p1ZmtFcGhxSlZpbWhKdnVFckYxT0poOFY1dUlt?=
 =?utf-8?B?V1NaVzhQenhsa3BQbkNEU1Zuc1pTREl5Mks0QURoODkxSkpOK1JCVnV6ZGVh?=
 =?utf-8?B?MUlHOGNnSERuYzZmWDNOTC8wQzhWRlB0YjJzUG5TOHVIN2JsZGJucEpET3V3?=
 =?utf-8?B?T3hLYUNKRHF0N0tNU0lPQTdlUnlKYmN1U1l6NDNkZm9JYVFvUVR6NVNHMXdh?=
 =?utf-8?B?SVlNMm90aTJ4NWRPMmJpMlVhYmdpdVlrbnJRRXBhNExpbUY0NGNmb29TL3pm?=
 =?utf-8?B?eXI2NlFHWTlHUlpIQTlaNDg1TFRtQ2Fod2wzNHZvelhxV3l0R1dZdFlWQUg3?=
 =?utf-8?B?TzEwOTlLRythWVhHeFFkb0xTRUZCWXI4UVFSWG0rZVNqbmRDTEhBZGNObGN1?=
 =?utf-8?B?ekZnVnZ2ZWNGTVJxUGZpS2xTQTE4ay93ckNSZkI5bFNXeXcvc056V3Eyc0t6?=
 =?utf-8?B?YXNhWitGQk0zUnI4M211YnpWdk5Vc2ZwUm5FSmtSVXRtTWFGRDhIaXVSbTJz?=
 =?utf-8?B?WnFneXl3SmlFb1g5NlkwWCt3Mno5YlFHSHFFTmhxL1dVMnd4VEQzYkUzeHlM?=
 =?utf-8?B?TUE1NktXcnpzVnhPajJUQnJVL0Z5Rk1wc1dnTGNFUm91SFZjQVlXaC96TTEy?=
 =?utf-8?B?SWk0Sk10Q1dsa3pYb2NMTEg3VVBKL1hBdURlamlIS3VlUGFqTkdSMWJEQTVW?=
 =?utf-8?B?WTd4a3lybVFheWJsL3BpSktiZVdEdG9oaDcwRXJSYUM2ekFzekw4eWwwWTNH?=
 =?utf-8?B?M2ZxOTBUVmcwZ0FNTHNNbHo4YnZIZnlqRm9rK2k5UkI4cm4xWU9rVnByaUlO?=
 =?utf-8?B?ejRwUTIrOWx3eTRyVmZHWW1XOXRpSXYzM0NnT1JuSThvTUNQN3doSHVZaHZG?=
 =?utf-8?B?MXU2eUZOd200aERaWWtncU5lbmRnWEJEalE3SzZmNUZybkQwa3JsZ0pVck1v?=
 =?utf-8?B?UVFPeFFUTjVFY3g2TXZiVm5TL2IzT2c3M3B1RVJ6VTlFMlI0UjY3MkxCNUIw?=
 =?utf-8?B?VUkxRkhQa1Fnb2pZaXh6OEpsZHFBcDVIbi9VUEFQTjVMVkdlQnFtbnpKVUVL?=
 =?utf-8?B?dngybC9jSWVsZ2RaVFJvNEpHMUpJUm5RMWZ4TlBacXNiM0N3YTJhVVdXOWFh?=
 =?utf-8?B?STI3WTVGQXlYZmllZGhTeVRTeGxEV0EyMEdjL0owY1dGTTQzY0xNWStuWUZn?=
 =?utf-8?B?R3kxZjIrL0FQYXRtSjNaeVlrbHNIRFZ0N1JQYU0wU0J5WENEUGtyenZSdkh5?=
 =?utf-8?B?VU9sa2NzTjlyYnpPVDNLNWh4WHpOTVQ3Q29IcytCU1pDSmdmUllqMVZwNFJr?=
 =?utf-8?B?enVVeXZxZkNvbE9mZ0pnOEFNbW9EdDJzQTZDRk1TR1NEdS93Qnp5NVh5Um1r?=
 =?utf-8?B?QkpseHNFb1hzb0JUREZUU09xQTRnPT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c72251-0f4f-46b1-8cfb-08dc1e752a40
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 13:46:15.2017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ugz1ySa8EhoL8q2JWWlcDv3J2OFqBEcsQ09mMfmr+eARp6VY1J1zsbtX/D2VxrMAowRtKET0846WUSSPbi4E1wEjbdY6U0JTmAANFjWz4WLHY2QdikgPLW0u8HuJc5vD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7240
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

Hi Dragan,

On 1/26/24 12:33, Dragan Simic wrote:
> On 2024-01-26 12:29, Quentin Schulz wrote:
>> On 1/26/24 12:24, Dragan Simic wrote:
>>> On 2024-01-26 12:09, Quentin Schulz wrote:
>>>> On 1/26/24 12:04, Dragan Simic wrote:
>>>>> On 2024-01-26 11:37, Quentin Schulz wrote:
>>>>>> On 1/26/24 03:57, Kever Yang wrote:
>>>>>>> On 2024/1/25 19:02, Quentin Schulz wrote:
>>>>>>>> We don't have a dedicated CD pin for the SD card connector.
>>>>>>>> https://www.digikey.com/en/products/detail/molex/0472192001/3044807
>>>>>>>> is the SD card connector we use.
>>>>>>>
>>>>>>> Thanks for your information, but I think you are using the wrong
>>>>>>> microSD connector for rk3588 and maybe also for other rockchip SoCs.
>>>>>>> Here are four microSD card connector from the web you provide, all
>>>>>>> of
>>>>>>> them have card detect signal available for pcb:
>>>>>>> https://www.digikey.com/en/product-highlight/m/molex-connector/sd-memory-card-connectors
>>>>>>
>>>>>> None of those fit our requirements. We need a safe system that
>>>>>> doesn't
>>>>>> break because of vibrations or shocks. Push-pull connectors are out
>>>>>> of
>>>>>> question for our design. We have had issues with our Q7 devkit with
>>>>>> push-pull connector with SD cards slightly smaller or inserted
>>>>>> somewhat the wrong way. I can recall also countless of discussions in
>>>>>> the early days of the Raspberry Pis where there were a lot of issues
>>>>>> related to SD cards.
>>>>>>
>>>>>> This is basically the mechanism we are using
>>>>>> https://media.distrelec.com/Web/WebShopImages/landscape_large/4-/01/Molex-500901-0801-30161714-01.jpg
>>>>>
>>>>> Please, allow me to interject...  I'm really curious why don't you
>>>>> use eMMC chips instead of microSD cards?  I mean, if the reliability
>>>>> is of utmost importance, I wouldn't even consider microSD cards, not
>>>>> even the high-endurance variants.
>>>>
>>>> We have both :)
>>>
>>> Ah, I see. :)  Perhaps my question wasn't precise enough;  actually,
>>> now I'd like to know what do you use as the primary storage for the
>>> operating system installation -- eMMC chip or microSD cards?  Is the
>>> eMMC chip soldered?  I'm just curious. :)
>>>
>> Soldered eMMC is the primary (expected) storage. If both eMMC and SD
>> card are inserted and properly flashed, it'll boot from eMMC except if
>> the BIOS button is pressed, in which case SD card will be selected
>> instead. If SD card is missing/improperly flashed, it'll boot into USB
>> flashing mode (rkdeveloptool/rockusb) if the BIOS button is pressed
>> (similar to when no storage media is properly flashed).
> 
> Thanks for the clarification.  Just one more question, please:  is the
> BIOS button handled in software (i.e. in U-Boot), or does it disable the
> eMMC chip by shorting its clock or a data line to ground?

None of those options :)

On RK3588, the boot media selection and order is done via the channel 0 
of the SARADC. So a specific voltage is provided to boot from eMMC or 
from SD card.

Quentin
