Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB00C43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 11:07:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85E4084A06;
	Fri,  3 Jul 2026 13:07:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="NswQFC1O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66888849F0; Fri,  3 Jul 2026 13:07:19 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84534849AC
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 13:07:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xYS4zCuUo7RHMKqKby+Wogy3JJhtmT4x5fk/SylWzZZVb4n1z0vib6KwDic9D8W4tbO80jDgsWd/9bc/9MILIOJmDjpopJa2N6r8CTYzb7v4G2w/imGS/RlEq6p58Kxh+4HgqxIJdJpyC9tqcwmVlFBdlWmk0oDokKSjaGaSxctvElyjb9ig7+++ZPsHD1hSZAS0SUT9zK0BjW4EJJY8BKkA4Wac0eEjQihft4bWs5R+elVZx318MRyv46AzQf9hNHCPG691vLjTx2R6VV0zTtx/EqBeSm/12VRcG9s8Wur4d2fMchqDOeYhUujnACdt0L/9iN7owGDYr1mEu6jmSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVH+actwaT+IC9MJmoSKmF+ExdUwCDvuca9btKnF9JE=;
 b=AnnhvqUB2i/8OHCzpBftdH8vcC6u/d61+WrbVT+OXjPjh5w7cNvWsQNiFRhJBQe/cfOuiMzZ7QAy+TzNI8WijN4alZGECeXuryFCupzCj/hqwE40rq/zyipkD+7mgOifJpglJIc1pJKpC5/f6sMhNl+6rO9bIgzcsKFjuMa6M4sQIkq2Ucwdcd9EqqqResqgMPm5YD9u4a1bHdFeWMVQawkTu0ERK1aANVnS3+LABhpZ7RjvfmdMyfYXigu7GYnQqwoPDva9mXQV2tJglqk3uvRtsYz1C5sxAhEoRQrBOrObOOBLKxiQQM1KpNBuZ4B2Dg+Mhmykx3iT4GDDVymnww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVH+actwaT+IC9MJmoSKmF+ExdUwCDvuca9btKnF9JE=;
 b=NswQFC1O5aZl/5JfTXE2JLzbjYZpLXIKofIGlBuaFJQbaM9vZG5nshO25QnHnYGNi9EHXkt+UtXTm9rTNvi6wxnu44fe7Sm4Sea6pG2kWuv89KpiPqZmOB/KT1lKwgPxz6eyTZFUnhT9S4r5xumozV5KyJWuF4VNRBDtHI5XCEuvrHgyVgbHh2Hd0RiNrg+2f0B/MOw4Dan1qgRxo9FukvyEmW1HiPNA9LLpQvssFMn9V1qFoqBUaCppT+5VvSL7W4Vd+GiQamGOV4mJ++GW5et4g7Mo2DVZdbgwEfySA+JIv8YSYA3mNKBJ/hx4e0g9Z4BjLAdjllxwBTyhUu7tWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DBBPR08MB5900.eurprd08.prod.outlook.com (2603:10a6:10:200::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 11:07:08 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0159.018; Fri, 3 Jul 2026
 11:07:08 +0000
Message-ID: <0c01810a-8a14-4c9a-9599-38b135c7b7e1@iopsys.eu>
Date: Fri, 3 Jul 2026 14:07:03 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 02/18] bitfield: Add less-checking __FIELD_{GET,PREP}()
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 David Lechner <dlechner@baylibre.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andriy.shevchenko@intel.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
References: <20260702055744.2164975-1-mikhail.kshevetskiy@iopsys.eu>
 <20260702055744.2164975-3-mikhail.kshevetskiy@iopsys.eu>
 <CAFLszTg4ZuiEdQkfTZcomtcWxSN+f1CKvE+Hikk+EHWghPaKYg@mail.gmail.com>
 <20260702135918.GW749385@bill-the-cat>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <20260702135918.GW749385@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P250CA0027.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::18) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DBBPR08MB5900:EE_
X-MS-Office365-Filtering-Correlation-Id: 11dcbc49-684e-4282-63c7-08ded8f3393f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|7416014|11063799006|56012099006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: +HGXOjVfpqChFW+8uC6auCMehTwXXjZSV9dqUKNm8etuC+c0s9pB5Z6MBm0XV2IdlkFxvPsnZ5aRu3U9VLF584UWuNaFNI4tPX1Y8LxqRWTW5o1Aqj6NaduArCE66gQvxVvNcopitlY9bL9ttZFx2JUAQ+3tVcB5wvtri2jbW+DJOyMBFX2/fqbjPQ7qY/7WX1tDPjajAOH2lRxKbS9JJJ7xSTRJEv2jus53n3vRYmyUjFglulSKZssUKLsd/9NWCEJoIwEY0jiKIjoz45UUMS/9J665ZCKz0uvhy+jcngC59OqLS6TXrqdUfg+piULzS7csFcIpHJQN63qv2XAop4fgt7dxrScXHwvkaT2h7a19gg7Rn3wKfFIj+ODh626tnr4W+ncKZ4xOnGTIG6Uxss45Yh7YBEMUzgbwFMrcoOUG9necuH7EsXb5jqUHGJrGBquCYTsdYqgys6+sLwHUX/rwcS5hvBkrL5qeSzb4GhC+bRugaRLE06ZMZH0MW6Osm9hSf22BB/pIAGQ0R+q29Yek0nNqYdwzeUBAz3oxanBioJlxnCDrhmClxmHhA+p0ZvLLD891Cjv9tga7ww5C6Cz0jaE+BSnH4t3KpuFsR/UnCHlhDgpYiKd9ogKdaJFJGBMHH4jf3a1+e9TWwf2yh9YHIi12yjT97sj8xo80254=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(11063799006)(56012099006)(4143699003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWRJQ3gyVE9xWUFSMnY5VmhWZlQ2UlBHN3NRZDF3QTllOTZ3K1BsUGZCTHVP?=
 =?utf-8?B?Wkg0clhZWEVPaFhBNXlhaS90Rnh2VTdRbEh3M3oxVVhKZVI0WncwTDVkT2tz?=
 =?utf-8?B?eVk0Sm5GLzNYYzRwa3dYdnNlQkZua2cvNjl6TkxZNXNPdCttV1VPTU5vZ29O?=
 =?utf-8?B?aHpRQmo2bUY3bmpIT205aEFNVnVxalo0aXJ3WEtNSWdFNW91TURyWExxVlY1?=
 =?utf-8?B?ZXFMaEcyNjhwU2ZEMWZaNjdwd2IrNWx1S3o2UjBRSnZGakhhRTNNT3ZaalBP?=
 =?utf-8?B?cDM1WFp4K2F2TmZCWHowK3dQdkdrNFhUNkFIK2YvYlJ0bkc5QWQvY0NWS0ow?=
 =?utf-8?B?MmxudnZ0ZmRjT2IwWjBsODkycVZRdVRQTDFaQlZHZ1p3Z3J0ZkF0czEzWDZB?=
 =?utf-8?B?Zk05cEpVSlhGWm9xVDU4aERzNkpucUowa2VMc0N5bEVqa3FJT0s5WU9lbXB6?=
 =?utf-8?B?VjAwT1piYVhYRzFJU2xBbDJ6dGZtTDFHY1ZwODZObFlpeUJ0aXEza0FKU0sy?=
 =?utf-8?B?eWkvckp0NHlEOTIzaHZQeDdIRm1qWXpoaDdqa3JuRGJFbUdmTDBBTEFoekR4?=
 =?utf-8?B?MmM4czN0elJXeGpmZlZCQ0xWOFlJb0tpUlVzd2IvcVRpQXB4NTBhSm42K1p2?=
 =?utf-8?B?ZGRiMUtnN2prbE5XMHprZjdkY0Rpb0lNaHVIa1Azd0VOWGlFU3ZiajNFcnR4?=
 =?utf-8?B?NHMybGJjSnJKdk55Y0pMWW1PVjlrdEdUeFQ1NjF2VHVTUitIbHUzdUVQcHJz?=
 =?utf-8?B?amMyMGJXcWZZajRJVzBXU05FZlU3U1dISWtCU1ljQ3VyZStLUHpub29odmdD?=
 =?utf-8?B?WmZKdG1uS2k5dnV6b3NnSmVKbmFtTkZodXcrMW9uS1B1aTN4NFY1bjV0YnBV?=
 =?utf-8?B?clNtVWU5NWs4c3pud21mZjZGWkEzS3dJWVhFU2tqUFJXRkxBWVY1UzhLVEVq?=
 =?utf-8?B?ZVM1OVpyN0xma3RKL3MxajFhekdOY0tkOVlmT0JJSDlDQXNsbGYrS0xHWnY2?=
 =?utf-8?B?SDF6UDJ1ajFXOS9BOGlCdFZzaForTjNKbEo3dXluNUJmcHZ3RzZwSVJVaWdv?=
 =?utf-8?B?eFJRT1BUYUdaQm54aWpxNGpyenNWZ2ZKUmkzOWlSZjY0T1NzTytaZE9XaUsw?=
 =?utf-8?B?c1pSMEdsVkxTa0dqWVdzSHlEeks1TFdVN2VNaXU1NnpPcG1DNEdmNXBYdEll?=
 =?utf-8?B?SGZmdjQ2YlJrZUNyUGVhT2syM0F4Wm9yMmRMY2xHTStka3FYMFh6YldEYXhW?=
 =?utf-8?B?Zk5WRi9TdGlHN2lMNHJtZzg2bHd2V24rZGZIakRDSjZqQzVLQ3JvaFhLWTN0?=
 =?utf-8?B?REZhZk4vUnM2M1orb0Z6djB6cytFN3E3elQ5V0YvNUp2OUhXWkNibSthbXB6?=
 =?utf-8?B?TDcyeHcyM2lBZVBOaFNNYkhHek8xUUpGcmFlcTNCUHdYUWJWM1RKR0g2QVRl?=
 =?utf-8?B?OUFKZ0lWOTV3b0JSUGVkN3VUSC9ZeTRad0J4MzQyRk1RcHFyTEg4MHN2WEhp?=
 =?utf-8?B?eGZUbDRBUVFNVkM3SUpSeXcrREkwY3k3aUt4UE9tSzc4VFlqVlh3VFdlMnAr?=
 =?utf-8?B?b3p2T3N5NHpOSHVDcjdVdnVkNFBUdHFydDJxTVhlU3RwNDFyWGI1QlY0L05w?=
 =?utf-8?B?TXpZbjQ4cVBVVnU2M09ZWjVaSG9CU1BxeWx2ZmJGUG5nRHF6RmdrK0tpSXpm?=
 =?utf-8?B?SzJkYThPSVcvQjhqbzRDZ2ZVT2NxRDNDTjV3bXMvc08vYTJZNjVIOGdPYkpM?=
 =?utf-8?B?TWhMSmR0QnpYUEpjdUk2Zll5YmRILzFEWGVibmlwZFFpbnZnOFpmSGZlWWt0?=
 =?utf-8?B?M3p2eUlFN0MwNjczUFY5cFBFdXFWSEJqNTlXUkZIRWxXTnRLTHdLYnNkY2l3?=
 =?utf-8?B?QVFHQ0JUL2JmMFQyOGRTOUlzcHhUU1oxcisybE0xUG5PSjZaUDhvNFJZMzky?=
 =?utf-8?B?YVVHdGhCNFgrRjZxNU81MXU5ZStJWERFd0o1UHhuNUVPOHEvay93SWU0Qnlo?=
 =?utf-8?B?VmdNTWE0RXlvK1JsY1gzZllpbHFUOVBucFcweG9PMElVamIyN1FPUWJYY0ZM?=
 =?utf-8?B?cWJpcmdhRXYyUGNseGtPYjA4cHZyMS90Z1Y1MC9PQjNWeDVqL21yQTU4bTFI?=
 =?utf-8?B?QzdLSjVPQjZRZU1zbVpFT0lHUW5DQUFBNjBjek9TM1NndVU0M0k0TWhveEVo?=
 =?utf-8?B?c1NSY2RFaHdRaHlxeW83UjJFNEdScjJLMGhrRDBwK2xOS2hYMHRNWEtVR1lS?=
 =?utf-8?B?NXZROGpVZVRObENZNGpLait5WU1xTk13N0VqU2tJM3Z0MjR5VW05QjY0b3Ji?=
 =?utf-8?B?OCtFS3ZNN1hPcTBQR1pIcUhYNnh6aGpMelc3M3NCUHFtbnZMYmlRTXJkVXZr?=
 =?utf-8?Q?0/jbhAqtdUMXBBu8=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 11dcbc49-684e-4282-63c7-08ded8f3393f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 11:07:08.3849 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 268B6NCmwMK4jpL7nGyiySpFCSP4b4JaoyrH4f30xWcn1zBwZyPRf78BiKucgZe8k1yL5ncqYs08AneJ5DBQ/3dhA2DyMEEYCWrHqK9o2So=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5900
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

On 7/2/26 16:59, Tom Rini wrote:
> On Thu, Jul 02, 2026 at 11:53:05AM +0100, Simon Glass wrote:
>> Hi Mikhail,
>>
>> On 2026-07-02T05:57:27, Mikhail Kshevetskiy
>> <mikhail.kshevetskiy@iopsys.eu> wrote:
>>> bitfield: Add less-checking __FIELD_{GET,PREP}()
>>>
>>> The BUILD_BUG_ON_MSG() check against '~0ull' works only with "unsigned
>>> (long) long" _mask types.  For constant masks, that condition is usually
>>> met, as GENMASK() yields an UL value.  The few places where the
>>> constant mask is stored in an intermediate variable were fixed by
>>> changing the variable type to u64 (see e.g. [1] and [2]).
>>>
>>> However, for non-constant masks, smaller unsigned types should be valid,
>>> too, but currently lead to "result of comparison of constant
>>> 18446744073709551615 with expression of type ... is always
>>> false"-warnings with clang and W=1.
>>>
>>> Hence refactor the __BF_FIELD_CHECK() helper, and factor out
>>> __FIELD_{GET,PREP}().  The later lack the single problematic check, but
>>> are otherwise identical to FIELD_{GET,PREP}(), and are intended to be
>>> used in the fully non-const variants later.
>>>
>>> [1] commit 5c667d5a5a3ec166 ("clk: sp7021: Adjust width of _m in
>>>     HWM_FIELD_PREP()")
>>> [...]
>>>
>>> include/linux/bitfield.h | 36 ++++++++++++++++++++++++++++--------
>>>  1 file changed, 28 insertions(+), 8 deletions(-)
>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>> Link: https://git.kernel.org/torvalds/c/5c667d5a5a3ec166 [1]
>>> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
>>> Reviewed-by: David Lechner <dlechner@baylibre.com>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>
>> Please can you add your own Signed-off-by at the end of the chain?
>>
>> It's a bit confusing that you seem to refer to Linux commit hashes in
>> the commit. So maybe this should have a Cherry-picked-from: line
>> indicating it came from Linux?
> We don't use Cherry-picked-from (does anything?), we just mention what
> the upstream commit was.
There are several commits where something similar were used:

86a720aafce5b2 ("mtd: Introduce mtd_block_isreserved()")
[scottwood: Cherry-picked from Linux 8471bb73ba10ed67]
Signed-off-by: Scott Wood <scottwood@freescale.com>

88f95bbadda89b ("libfdt: Add fdt_next_subnode() to permit easy subnode
iteration")
(Cherry-picked from dtc commit 4e76ec79)
Acked-by: Gerald Van Baren <vanbaren@cideas.com>

c9fbe861a2fc1c ("arm64: dts: allwinner: h616: Add r_i2c pinctrl nodes")
(cherry-picked from commit 1665557aa57c2140d014d68dfe1a1f92f9baac82)
Reviewed-by: Andre Przywara <andre.przywara@arm.com>

13f3b04f61aa6a ("mtd: add mtd_ooblayout_xxx() helper functions")
[Linux commit: 75eb2cec251fda33c9bb716ecc372819abb9278a]
[masahiro: cherry-pick more code from
adbbc3bc827eb1f43a932d783f09ba55c8ec8379]
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

1fb87de83dd6e7 ("mtd: nand: Support controllers with custom page")
[Linux commit: 3371d663bb4579f1b2003a92162edd6d90edd089]
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

and so on


