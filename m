Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB50CD4851
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 12:36:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16F3B84674;
	Wed, 13 May 2026 14:35:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=genexis.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=genexis.eu header.i=@genexis.eu header.b="LwKLjVd3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 735DF845E3; Wed, 13 May 2026 13:30:58 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC815836AC
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 13:30:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=genexis.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=benjamin.larsson@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rbYHnH68rhK416HDPcTmAccrSltsLFwvK8LWCzx7BnEh56hSzRPwtdPvQiopndf13ULOncrRHUl9MgbiDw0p3nzQPEUtLRuijdQh4VSRSZUkkR5ApBnvrNnt05Gc2cdx+2I8eEA8bxqacmhZXUBggLPuvmrBYQ5nXiFaXQBxrC0/2UGPuMOfu1fziLlSiLfnIAeks366Za/0Qad0UIVYIASWCqpm5UMKHfRTyDFoQKt0eATzCBoXvWqzlQUwdgItbe4B26bzwkRPgTTt4f0zPtMnY190jMq/E5+JXNeg5x5lpJX3MyjC0btsMZ1iYkM/b0RRMvnReskEj7aUtTWwJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66MsiFpiBXAL8qlGd1pjZMtVln8y4iYMPJPM7GdaQU8=;
 b=UblS8gP0/y5BNwLjMq6ebiezDPu39Of4BcEZJi0nZ2W58V5u5R+h9p71GRQoyi1NWQM5959QNDkfXr/0itSVrSfd/3BLnoCJwfdRj2ubKLr867xy/q+bDJOrG/FwGrC4r3rauMFviTIIIQPwX+W9dATwmxgkCSvEY/bwwxwr7s5M3pFxG4iL3HW1hR6DLE9oP6H2cmuAd4N/C6zyEtkgxcSDWgLi2KCiGGPobMQL3rUvomaY/P5YW2J6OZPl/KoHFXJckxI7qi91h3IXFhiEXwT1DSUUWEnmDZUS6eKarPBiWSdELj81b5sXd68sJWjBlZY/Ib5iu6m04RtJ6lPKeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66MsiFpiBXAL8qlGd1pjZMtVln8y4iYMPJPM7GdaQU8=;
 b=LwKLjVd3/q3EU+iphNQAPhg2DcalRqkT45g1iVqHiAkUTu2Fgl9Pny9nEMaYjLxVdc/f5YnpS0ylQAiRJX3PcnzjUc0+jrpliwVUUnSFoDmBIgoRUBq2bigYE4UE2yiIgnIrs+p2o7c4i2A7qjUsCcW2MhLFodND6gPbC8EvslqJFfIVNi7nD3irDLerBfQAt3lMYuchSoPhhccMIXvrSKbGpyYm6MSl0cgFyDMXf4b/07XkeDdmxhoBo3Z1McaNdUsqGgQcR6tv5YY7XoGp0yyMYybZX1+vrBaXmzicwYXU7b4mETAuFIWQbUwxhcd142DNKmn/eXincK5XwSycvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from DB9PR08MB6697.eurprd08.prod.outlook.com (2603:10a6:10:2ad::14)
 by GV2PR08MB11818.eurprd08.prod.outlook.com (2603:10a6:150:30d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 11:30:49 +0000
Received: from DB9PR08MB6697.eurprd08.prod.outlook.com
 ([fe80::bdec:3e95:6614:441f]) by DB9PR08MB6697.eurprd08.prod.outlook.com
 ([fe80::bdec:3e95:6614:441f%6]) with mapi id 15.20.9891.021; Wed, 13 May 2026
 11:30:49 +0000
Message-ID: <633941db-10eb-49ad-a2dd-a81a71e6b6c9@genexis.eu>
Date: Wed, 13 May 2026 13:30:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/11] pinctrl: airoha: add pin controller and gpio
 driver for AN7581 SoC
To: David Lechner <dlechner@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Anis Chali <chalianis1@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Yao Zi <me@ziyao.cc>,
 Sean Anderson <sean.anderson@linux.dev>, Michal Simek
 <michal.simek@amd.com>, "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>, Markus Gothe
 <markus.gothe@genexis.eu>, Matheus Sampaio Queiroga <srherobrine20@gmail.com>
References: <20260509111157.4039434-1-mikhail.kshevetskiy@iopsys.eu>
 <20260509111157.4039434-7-mikhail.kshevetskiy@iopsys.eu>
 <fd91e95b-d45b-4fdf-807d-54f87a19b26a@baylibre.com>
Content-Language: en-US
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
In-Reply-To: <fd91e95b-d45b-4fdf-807d-54f87a19b26a@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVZP280CA0083.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:274::16) To DB9PR08MB6697.eurprd08.prod.outlook.com
 (2603:10a6:10:2ad::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR08MB6697:EE_|GV2PR08MB11818:EE_
X-MS-Office365-Filtering-Correlation-Id: d0fc837d-e029-4395-14b2-08deb0e314e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|921020|18002099003|22082099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: pXnIvP5YeEqhoF30sdQJIa76JpgBgyAIa0YoGrsYOiTCDWj5wTBDc/Skj23HoiI6Qa1SGjTrcfj5mAsPNHIhJURSAPseAAZvBUjvOoljOTCzub5+Uk/Gy2fsEmsSGl0RVFEmgoylT4BTzAQgLy9Bd9EEML6STNJl6P7vzz3olRPncdt935O+Py40P0dBde7awUU8PI4TYQ4Xh+eeoF9g5iEvnutgaMFaB8mESXzvFoVhCNbSrpZWHCKneMgu4226up+SIZd3CZlBq5Z+1x2YZF2KyTvWuf5T3DMGm98xv1A51QxZsi/ZydHyEanP1qQfTzDJeRYLBYzwpU64hF9wwSAfNJ6/Ujz+JCFpDlXZiKL5QTY3GjskED/H67yQEXqHYIek/iMkXCUJYnV2A6MreoGqfy6bLmSjN0IVV0eVOSVk1hUTlDRCwFTWm0n5n3B0LpZmp4G0EYBtVznuYi7WrSvZBPFY9o8zJNmAi41UQevwYBXAt2LMR+kumIUC+HBMaMDKGpWKk50NKA5QMBlfAdKvgy7FLT/oHU6Y3wYrY9FYav9SyW4p47Pob5WAZ7fsucR8TomYOzGYD3aJGV7UTqcSlpw3OoQ5kw/i8XUnqrNpbS0sdp3+Xhn2GbFwJF6rrq+493UnRRplPXgZnQMjVzeoAe91vfMxHebDFERNetXJAskCMEfF460dNaP86aS38CABPTyd7yeCsx3wrnKnzsff2g5NAp2vzkRw6htZC6k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR08MB6697.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(18002099003)(22082099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0pZbmJvbGgrZlFiV1FLM1prNnlrV3dKeEgrQkt2Nm5kT2RicTJ4WnZGMCtG?=
 =?utf-8?B?eXVScmpBeHZYQTBjSnE1eWM5VHNjcCtSdmJtaTEvTW5FMXB4RlRYZ1FMZ0dO?=
 =?utf-8?B?eEFvdzQycjBHOEpoeVF6SGNFalpTZ2YvWk5DME15dHBOa09CZkt6MGxkVUo0?=
 =?utf-8?B?akU1OUY4V1JMUWtkbzczbjM0dGh0clBnOVhQUEFRY2hteTRUekVKVFNuenJ6?=
 =?utf-8?B?eHFPbzZNbFRKY3NRVWVrczEzZ09oeEhyYnlNanhkZFQ2RGp6S0hWQVVCVk9D?=
 =?utf-8?B?cEorcVpwNUNjSHFOQ05hVG1HSlZnZU9TSXhWS1U5Rm1xK1IrVndHRGJOUDNU?=
 =?utf-8?B?MWJMdTFObHR2YmMxUHE3dVRzNzhJZ0JPVkJSWDdwc0xKSWF5YzI2b3pIaFdv?=
 =?utf-8?B?MjkyYjJ0bmVvN3I1T3NHb3BseC9FVWFsd2pmV1JlUHhGQlhDMmowNUJjQjRD?=
 =?utf-8?B?d1hraHJOUGFjUWJseS9iSlJaemNaN1pZak52bGtwMjA3WUtVYUxpSzZjVGFq?=
 =?utf-8?B?WU5qWURFWWdJcnEzRm5remNHbmVULzcyYWhxWngyTmIvUzZYUHlJY3lpeW5B?=
 =?utf-8?B?SFdrZWVSWE4xRDlPVkFpb1A3dVhkeVJmMks2T2dpeEhKbS9tWlQ3akNhRktO?=
 =?utf-8?B?VitMaTRxelNHUk9CdHFRMzBRRVFacjZqNjFCZTRocE1rbi91WUVWSmhJWUJj?=
 =?utf-8?B?K3FZb21mRDJMQ2g5UTV1UmtXUmtLRDlCNWJNQm9aOCt1aC85ZDBIZGFpRHh3?=
 =?utf-8?B?WmZDN3kzcWFNZ28zWDdKckpadTU2WU1EOVR3UGVMb3EzVjhwTnY0cUZZOW04?=
 =?utf-8?B?REFKckcxTWF6Z2FIWFJGbjRKN3cwdGdsU1ROZmNKT3RQNDB2MFR1V0dSa3N2?=
 =?utf-8?B?MnRKYlBYUVB6SUhMYTZTNnpEcHYwWjVsajM2QjNCMTBzc3FrSmJta0hyKzY5?=
 =?utf-8?B?SjVKeFA5MjN0ejZaSnBsTWYwTzFXOFJZdnJuZ0c3ajBWaXg0VTB1MEUrZ04z?=
 =?utf-8?B?cnB3WjRhR0tDVjVYTDBBT2NWT1lLTkFmRURyOVR1Z0lnOHkvUjViNFJxTVQ2?=
 =?utf-8?B?YVZpbUtoNGV5U1VMVnJNU2x3WHZWMS9XZlNIL1FFMm5pa0pCTk4weUFWaDRL?=
 =?utf-8?B?VnNKd0ZOUm5taE8rTGdLY0ErTjcyR05VN3VNM1djU3grNmRSdnA4VXdaTy9s?=
 =?utf-8?B?Wmw5RmhrdkZTUXpFYjhBQm1OTUVwMjI1Ulo3MmdmOXd0MTh1U0lTSDFnSnVI?=
 =?utf-8?B?eFJtdUxFVkNTZEZHNnNTTzR0ekRud2MxVmxva3hYcHltWURhVjFrRUhPZVU1?=
 =?utf-8?B?aFNKWi95OVVJNm5SbFE2bm8ramJPVEQwczJocER0QXhMQVowdzAyZGRVQmxU?=
 =?utf-8?B?OTA3bWlxcUdBbmNMQmRCOGVGM1MrRStJTll5TlpUNWVWai9MN3ErUVBDZGh3?=
 =?utf-8?B?V0Qyb0pYZHlTS0ZoYmJtQ0k5WkdCUXdoUXAxMHN4ZVVvdUFKdnVZZW1TOXIw?=
 =?utf-8?B?V0ZiTDlDNXBFZE1iclZuMHVqMm5sTFN2eEphcTZ3WTNPSUJpQlZ5NVByeC9S?=
 =?utf-8?B?MXBOelh0QmdBa3RWTmdlRTZQRmxOQkxabkJpdjVHdjdLdGxac1lBMGZPYzFW?=
 =?utf-8?B?ZG1mK0pGdGFxb3JkdHJwZDd6cnRYcU5ScmdzKzFic3dQQUNIcld1eFFTbUZm?=
 =?utf-8?B?ajBPUDZRZ0VncTM3TDhRNkhaSUNvYnZVZGQ3NkxrS2JBSlJrNmNoSVRnMEsr?=
 =?utf-8?B?ZitBL0E2N0RSd1FQK2V3R3RUK0oyZ2k0SmlMOTBZVEhpQUJHU2djcy9wTVJC?=
 =?utf-8?B?SHRLcVZLY3hTS20wU0x2dmIzWUNzTXhTTzZmVGp2Vk4rbWo1VVdNZVBOVFAr?=
 =?utf-8?B?TkJBTzVaNzhEdnVzTUYyb3ViaTgyZHAwRUYzb3N4UkJsZFdQcFRaK3BPc1JD?=
 =?utf-8?B?SzYrMW9KQkdwOW9ieFo3V1U5SFB2aml0c2xoSnJJV1orYXlBakNPNXRxSThW?=
 =?utf-8?B?NjFzTE01UzlyL2daQlY4Q3ZtYzIvMlFsZHNiMDUzcTV5aS9LRFlSZHZRL0J6?=
 =?utf-8?B?VkZSMnZDYkZMNkozNnNHS3VCSUlmcnNrN0xZaHpyb1BEYk9uaGtDU2JKTTJk?=
 =?utf-8?B?QnBBK1VndGZjUUJlcnhyMmd2R2hJNGlHdHlqWG9pb2VFamtrN2wwMk1GNUU2?=
 =?utf-8?B?T3V2enNGSGtmY25DdWlSdVlab1ZoOHZiVWpFck1EYS9rcEhZTS9nM3FqVUFE?=
 =?utf-8?B?QnJkS08ySVBZeHF3MmhzTUx6NTZRSm9kbTBDRUVPSWl4VGZTZGFZVkNaKzJ2?=
 =?utf-8?B?MG00TmtUd2tLZUN6L1M5R3VORjZJay9IOHlOUnhVc3hURlkzMjE1Sk55ZTg1?=
 =?utf-8?Q?ITz8o1oUogAhgYRs=3D?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d0fc837d-e029-4395-14b2-08deb0e314e4
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB6697.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 11:30:49.1777 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: klnQRHtZc9jBS+NFsvZWQygFgogbUAuAsagb1PaUYcZMaim/zq/v4Wa/9TqSW9D2+VgHl3S+rGch0x+hvyLdlpgHH6MGAuvHBKgdCcCtrJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11818
X-Mailman-Approved-At: Wed, 13 May 2026 14:35:03 +0200
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

Hi.

On 13/05/2026 01:42, David Lechner wrote:
> On 5/9/26 6:11 AM, Mikhail Kshevetskiy wrote:
>> This patch adds U-Boot pin controller and gpio driver for Airoha AN7581 SoC.
>>
>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> ---
>>   drivers/pinctrl/airoha/Kconfig          |    5 +
>>   drivers/pinctrl/airoha/Makefile         |    2 +
>>   drivers/pinctrl/airoha/pinctrl-an7581.c | 1076 +++++++++++++++++++++++
>>   3 files changed, 1083 insertions(+)
>>   create mode 100644 drivers/pinctrl/airoha/pinctrl-an7581.c
>>
>> diff --git a/drivers/pinctrl/airoha/Kconfig b/drivers/pinctrl/airoha/Kconfig
>> index eb87afbb374..986d23c2e3d 100644
>> --- a/drivers/pinctrl/airoha/Kconfig
>> +++ b/drivers/pinctrl/airoha/Kconfig
>> @@ -9,3 +9,8 @@ config PINCTRL_AIROHA
>>   	select REGMAP
>>   	select SYSCON
>>   	bool
>> +
>> +config PINCTRL_AIROHA_AN7581
>> +	tristate "AN7581 pin controller and gpio driver"
>> +	depends on TARGET_AN7581
>> +	select PINCTRL_AIROHA
>> diff --git a/drivers/pinctrl/airoha/Makefile b/drivers/pinctrl/airoha/Makefile
>> index a25b744dd7a..909bd9a04d9 100644
>> --- a/drivers/pinctrl/airoha/Makefile
>> +++ b/drivers/pinctrl/airoha/Makefile
>> @@ -1,3 +1,5 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   
>>   obj-$(CONFIG_PINCTRL_AIROHA)		+= pinctrl-airoha.o
>> +
>> +obj-$(CONFIG_PINCTRL_AIROHA_AN7581)	+= pinctrl-an7581.o
>> diff --git a/drivers/pinctrl/airoha/pinctrl-an7581.c b/drivers/pinctrl/airoha/pinctrl-an7581.c
>> new file mode 100644
>> index 00000000000..606e042b069
>> --- /dev/null
>> +++ b/drivers/pinctrl/airoha/pinctrl-an7581.c
>> @@ -0,0 +1,1076 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Author: Lorenzo Bianconi <lorenzo@kernel.org>
>> + * Author: Benjamin Larsson <benjamin.larsson@genexis.eu>
>> + * Author: Markus Gothe <markus.gothe@genexis.eu>
>> + */
>> +#include "airoha-common.h"
>> +
> It still throws me off that the en7581_ prefix is not the same
> as the file name/driver name/config symbol name. If en7581
> is preferred, can we change everything (an7581) to match?

The physical chip is marked AN7581 but I have seen some old EN7581 uses 
in Airoha(Econet) material. I'm not really happy with this situation but 
for some reason the en7581 name has been pushed for this SoC in mainline 
kernel code.

Ideally linux and uboot should use the same naming but I'm fine with 
whatever gets code landing upstream.

MvH

Benjamin Larsson

