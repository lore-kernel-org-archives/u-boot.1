Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FEFAC25B74
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 09:12:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D768987E3F;
	Mon, 27 May 2024 11:12:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ddI4ywuU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6872B8826B; Mon, 27 May 2024 11:12:37 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5696B87DEF
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 11:12:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJpQ+zfnJcgmZjwZeDmgPYl/jqXTFnuSHmXXYmmhNaQKdKTaIAsMIZYJYvIxeDtNXDCCvl2BS8gCT84zan+/HXHre0nJDYJSOcoTP4PNXm+A6jplUgg5xO9haKmcUuyhse09zqn4YGI/hdTFABoOH/7ocEkr4EzdWkJO3IcovEfOBILp9BVT3v2qI9Ab4ruov+sswZVAn77w3xt6xUeoNKpFWU8uHifa1TXKpL+TLcu4fba7/oBiG7rgjlly5K8xhXxtcbR8gq/AoTpAyGnNP4OLIX38tnx6PMQul8vt1VckKjqqWGDINmwF1XNP7WMWR15fiw7Lg2R29UKhWTDeRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrTeNVOsp5AWUDps950TekTjDox4SWdvyxaHjCyHdNY=;
 b=C7KY0lFHnypnMxXwYJrpmihRbMV4Zpldo442+Y/6wxYzncpoIkx2cidcXVXnkkrsWSaz7h2XvJpPz08QSQGPdt7TjHzyS/FI5FXBGeOszHfHff4aKSfz3PfLn+ysxlfCTkGzk1/T55MD+2azbCq25HXDwVxuv21QVMpzSaq+11ZlYajkuqufyVbQ4NFh/sK15w5XFscVUeZmYgxettdfl5VhddbVKLm2D1YSbrPQP+wizyU0fSePD3zSVtoEK82e3edAUo/YCWXqIccxlGzkGoAm4M3cXa0GofZ+pEqVFCI96wAKD0d4wH1nJ/Gl/O+ePWeF9XcZTOedFwlh1dn3kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrTeNVOsp5AWUDps950TekTjDox4SWdvyxaHjCyHdNY=;
 b=ddI4ywuUk+JnCOIdHblJwWIzY18bOsvP7Csjm+Dt8kDZW6q7MDwiR5WJhHJoIqroNeVmQeY0WUDjFRr4sQjz3r5bdXoIKR4sJOyYcb58ybsTf2YC7MVaQMVya1+JUiKXy415Jd1GR8TO2fCFEyzYfoJmMZTo9iTCH+U1sq7KJvw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com (2603:10a6:803:128::25)
 by DB9PR04MB9476.eurprd04.prod.outlook.com (2603:10a6:10:366::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 09:12:34 +0000
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31]) by VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31%6]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 09:12:34 +0000
Message-ID: <ecb77588-6e53-47c8-8f0a-60c5d45a0f03@cherry.de>
Date: Mon, 27 May 2024 11:12:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rockchip: rk3588-edgeble: Add USB OTG support
To: Jagan Teki <jagan@edgeble.ai>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Jonas Karlman <jonas@kwiboo.se>, Anand Moon <anand@edgeble.ai>,
 u-boot@lists.denx.de
References: <20240527063915.6205-1-jagan@edgeble.ai>
 <20240527063915.6205-2-jagan@edgeble.ai>
 <c4024690-7067-4d23-bdf3-320194e31287@cherry.de>
 <CA+VMnFy39zhYSSmL=JuG_c=yejOccVGF+_jwj2YA0UPrF3HNhQ@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CA+VMnFy39zhYSSmL=JuG_c=yejOccVGF+_jwj2YA0UPrF3HNhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0041.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::27) To VE1PR04MB6589.eurprd04.prod.outlook.com
 (2603:10a6:803:128::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6589:EE_|DB9PR04MB9476:EE_
X-MS-Office365-Filtering-Correlation-Id: 3837bf8c-4b73-4453-7b53-08dc7e2d2507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eGpOYmJzaEF5VzBUVVdsNVVUV2hXMFpxaTd6R3pTV2dyeXN6V0pOQ1R4c01M?=
 =?utf-8?B?WmpTbFRFTmd1Y2tka3FzUDJxNlJiTkpYVktuTTBnZ21CSFFIaEordHFqTGpC?=
 =?utf-8?B?Q2p1bjVoWGU5eGpKdVd5T0o1QXdRR0ZHODZIQ3V5RUxOamdtRE9XbFpTaXBw?=
 =?utf-8?B?dm1mTHZZWUxDUGFkanFzWnc1dG01YXlack9MREpJMFA2SjJ1RlJ2OE5MMUhN?=
 =?utf-8?B?cUx3T24vKzVoY2pPYU5wWklmb0FwRGFsYnBEdEx0UG5zT2hEOHpxQkZrcjJq?=
 =?utf-8?B?YmhYNk13dnlXSHdhcU5zWitlNDlBWGd5TmhKM2w3ME1tUmEyUGVjUnJtZ25v?=
 =?utf-8?B?WTR4R0g5dzZJaWhxeUtLWlZmbXJBdHNndkdjNWFDRXdVZkhxaHJGbGgzNXdL?=
 =?utf-8?B?azVQMERpMzhVZVBIc3lqeTcrTUtrU3lFVmpnVW5aY3Jadk5MUmFsUnBrOWl6?=
 =?utf-8?B?dmZJb0JqNUNmR3dNai9lcDU0dlRpa0Z0WVByTDdha1Z1ZDRDeWNWSUVYU1VE?=
 =?utf-8?B?L2l2MmZuc1ZkcEpGWnh5dVVIQVNCMDVCWUFOZmxMWTQ2TUV1azFSUy84cVZD?=
 =?utf-8?B?cDlWcjY0TERJUElIa1M3T1N4WHZOOGphVjRLeHJOdmpYTFhvdzk0VHNKeUNt?=
 =?utf-8?B?QmlOTWxyNjJIMUFSY3daTDdRKzVpbXVCei94eFBxdFZndmdUazRUT0ZLYUNi?=
 =?utf-8?B?Y3pOWXJxZVFaWWFqQm1JSDR6Z01YNlpsUDYwQkR6aXRzaXBGYmI1WjNPYWVj?=
 =?utf-8?B?SjRXNHIwVnlnWmc1YkcrbzdOT3RNUStNNG05Q1BYakowaEo4MXk2QjdvTmxs?=
 =?utf-8?B?cFhkRW02cUxtQkhYL3hsVkgvTHRoYVlHV0F3QWtBK1U1ZDRDZzhDQThnTys3?=
 =?utf-8?B?T0kzaVNidXZvaExLY3hPQWxPSVZiL09EREZDVWlGZ2orOVpBMnhrd3E4bU5k?=
 =?utf-8?B?amhFK2lSaHJWWFZUVlVUSjM5L0N0VGxmYW14bnVIUkFncGRRQnh6SzVGdm93?=
 =?utf-8?B?TWs3QVJSTmpvMXNObExzRW1zalpqQnNGalFkNERUVk9PMEV5K2VnWUhjMDlM?=
 =?utf-8?B?VFJaaE1YRHRYQm50S1ppenMwZXpEWlhnRTdWcDd3dHZrcnR5cWxvaktXNWVi?=
 =?utf-8?B?VytjSXBBdkM0Q05jb1FUZjFhdU91WDNvYVlmd2lPd3BabStyMGdBL0lNbVhh?=
 =?utf-8?B?eTc3b2hJbUNvOTBUci9TU2R4bEpPcGNzK1NTRDlUNHVkd0FiVlRHZEh4Tm1B?=
 =?utf-8?B?MWJUQWp6NjVwOHBid3JqUk4rTlNJWElNZUt6ZmtHQzQ5bmhmVFhBWExySzZw?=
 =?utf-8?B?ZW1DSFZMM25uRXJYbjBqQjBYRzlGdkdpcDkvNEVGcGY3Y1BoYTRRV2lJVTd0?=
 =?utf-8?B?Zkh2MHZncDE3ZGQ1TVFEUUJjZlc0eEdXaXRRa3BJbjN3TE02ZEY3SFRyRFhq?=
 =?utf-8?B?czUxN1ZneUNEU2RYTHA4eENNRTI1QUR1RlgvRzhJLzZOd011bWcyY1dpb0or?=
 =?utf-8?B?NUZ6TjZpbVRCSTFWUjlLRXBSQ0xpZU83eEJ0WjNyeVpvdFdQUFNnRDlWWStJ?=
 =?utf-8?B?dzl3akdzQmlDMFdpcmV1cWZtZ2Nrd1hreTZCQXExMEkwZkRWcDIzazRGL2pr?=
 =?utf-8?B?SmltcUtWd1RoZm5ObWZlOTVFb3lqc083Mkh0bHVicHR1SkRVMFRReERmSHlK?=
 =?utf-8?B?VDZ2ODBxV1lUR0djVlNUdEJWRnQySlpZaGwwL1FWTENxbzFzZTJPKzN3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR04MB6589.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVQwdXQ4SjV4YWZKTWk1d0FOSTBiTkZuTWl5ODEvUU9kaXFhRWFzVXFKck1C?=
 =?utf-8?B?THRJUEUxRm11blZQeVUxNGl4YkcrcUxQbk5NQk1oU1YrQnN3SmxvRklmNlhv?=
 =?utf-8?B?Ri9kUkF5WXNPRnpJNUY4a3RiWWF4eEVIOVdFb0lEOWN0cjR0M2MzZHlKb01i?=
 =?utf-8?B?TFNtUjdYcU82T0s4T3VWQ1d2REFmeEJrVEVnb0d4RmdkUVJyb1JLU3YxdktK?=
 =?utf-8?B?SHBvcnpVVmVzNnJ1SkxvcVZWVzJ6MWJjT1J1akJGckRmMmNIQUxOQ0N2eXBm?=
 =?utf-8?B?YmFQQUkrTXIreUVjSjNGOFBxQ1YxZmhNckRMYWNEMmViRWF3UTM0blpWN0tp?=
 =?utf-8?B?ZWt1cVNlcXFHVWZaa3NlNGMwTEpjOXJFaUVHS085dVM2eXdlaGxEenEyVHBi?=
 =?utf-8?B?TklTdnFBMTl4b2JwbHlzczJsZUt3ZEtDTktJdlRrY0srUnBuemQ4aDBXVG5P?=
 =?utf-8?B?SEN6SWhQdXpBOFR6UnVrL0hQVHhDUGlYRjZYdmIxTVV3MWtuSHhseGpkeTlm?=
 =?utf-8?B?SWFJZzhxbnk2V2Z0RkRZWkl4dkNaK1RvcHUrVzBkeTFEYlIxSjhHZmovWDNp?=
 =?utf-8?B?cjUyekJ5SndYVVBOMzhTQVRiYXdhb213dGo2dVFlVnRKTE9iSW1JWEtkOVpE?=
 =?utf-8?B?bjB3Y3FTdFh1eG02TnZWb01CTHdpaDVIVmFPY2hHTXVGSDJ5NVllOWRXNEN5?=
 =?utf-8?B?R204SFFFUnU4QTNFaDZWVGtNZ3RVTUs5R3VxQkRpUUd5TWFzNXNJREtHVHJN?=
 =?utf-8?B?bVExYzV4b3VCcVg5bzkzOU5UNml5WTZ5Wi92R1Y4dzN2cGwvZjdJSWc5RXVR?=
 =?utf-8?B?SFdsQVhCOFNoN3R6Tk80WFp5U0hVL1pwV3h6NkNHc1hUUEgxMTdWKzRaNWhF?=
 =?utf-8?B?THd0bGVHR2pVZmRrRXhYNGMxb0huVzNObmVnU3ZzSzhZL255bXI4SEZpaFZV?=
 =?utf-8?B?OFhCT2ZnaW5iQ1c4WGVRNTBrQXdIS0RSbDkvemV4TVE2TjZWMG9ZYUxNM2dU?=
 =?utf-8?B?SDQ0aUpEM0kvekVXM1lEZXU4cWlWbkU1THU0aFBqZmw5VUk3aVRJZDBGbHJE?=
 =?utf-8?B?VFdYNG9nWDlDdmtOR0xUQjZHenNLNVNSQktUaXdmbHNkSzJaSGc3dDBqcWdi?=
 =?utf-8?B?MkxhUGRnS3pSMHNOVUluMGlaQmZyaXNMRGxSMStWVUk4MkRPWnpMRCtqUS9u?=
 =?utf-8?B?eXJoVW5BWEZHWGxoc0NIdktCcmVWM05mdFh6RGZoYWE1NUpqMCtocWdlOVB6?=
 =?utf-8?B?QnNObzEva2dYRy9zZjU5QmQ3bUV6cEtRN2JEWjB2N1ZiWHJtSkVZc3NxTkJw?=
 =?utf-8?B?aDM0MUtZTlc3aHJlTkxUSVVneS90Vk9ZSGFZdmhySmRHT1JLRlRESkMveUtF?=
 =?utf-8?B?clJ0cHJsMSswR0owT085WVBZZUxvdTBSRk1BR1F1dWhvdnJ4WTNURXh1Ty91?=
 =?utf-8?B?cUFRQkdLb2xYK1ErVk1SajhYbWVRRUVrWkgveThraVJ2eDBxQkhLZVRBMWhJ?=
 =?utf-8?B?QXJjMTFZenJiUGVRZ0ZPU1ljcTlhOTJGZEN2ZXQ4RXpBM1E2eUZ5NUJHalFU?=
 =?utf-8?B?cG12cEJNdmtTNnFHR0UraGJwM0l3czZNem85UkplZ3h5TWJqd1NDaDRHTkxV?=
 =?utf-8?B?RVN4YUt5ZXlZMHhJb0xra0cvWHBYVUlDWUJJODMyTnVrdkdqTlAvQzY4YTdV?=
 =?utf-8?B?b29sVkNiWUtHbjRmcFdoeWlhMnhVM3R6MVp5NDhXS3ZjOUhqandYSnkrL3BP?=
 =?utf-8?B?TzhScjBUaityaTZybnR4V3VRS1V2eXEvY3RLeEtQQWlMbzFBNVdWRU04OHNx?=
 =?utf-8?B?aG1rQWh5K1lrd0RaclduVWlnaWVmMnJpUzg1Mng1Yk5tZVE5T3Q0ZjlCUEVS?=
 =?utf-8?B?eWtiU1Z6SW9hWEJRR2g1T2p5S3VGaTNCdVJaaW1aUXdMbjRLMlQ1cktWVTVH?=
 =?utf-8?B?K3p2L1IyZ3pJYy9SQkpwYWwzMnZ3cDh2TG1LVitlcElMQlBXemNoU0hGVnd4?=
 =?utf-8?B?ZjFPYjBFc1FqSHMvZXpPa2Q1NEJ5WitETldma2xia2diMUpHSUhleDNuc2Ez?=
 =?utf-8?B?cGJzT1pGQmluVXlGVTFzaThzRk9sTWFTKys1bHpiY0lIbWdiclhFclB6UWt3?=
 =?utf-8?B?YW5VdlppQzRXNlJxNFkwWEhkQWZkL2VjSTJZb0RWR2lIeHZrK0M4OSthRnV5?=
 =?utf-8?B?Y2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3837bf8c-4b73-4453-7b53-08dc7e2d2507
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6589.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 09:12:34.0675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hb5XUY8gSNmXuYncHwB7pzWvakEUJGwMw0U3OKFt66jio7cDY5ofMlt2HMcXxrjMG8C12eMAUNW4Aco+OiNKkFD+0fyizPQlXXDOcOCl1K8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9476
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

Hi Jagan,

On 5/27/24 10:57 AM, Jagan Teki wrote:
> On Mon, 27 May 2024 at 14:17, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Jagan,
>>
>> On 5/27/24 8:39 AM, Jagan Teki wrote:
>>> Add support for USB OTG with UMS to program eMMC.
>>>
>>> Add it for Edgeble NCM6A, NCM6B.
>>>
>>> Signed-off-by: Jagan Teki <jagan@edgeble.ai>
>>> ---
>>>    .../dts/rk3588-edgeble-neu6a-io-u-boot.dtsi    | 18 ++++++++++++++++++
>>>    .../dts/rk3588-edgeble-neu6b-io-u-boot.dtsi    | 18 ++++++++++++++++++
>>>    configs/neu6a-io-rk3588_defconfig              |  9 +++++++++
>>>    configs/neu6b-io-rk3588_defconfig              |  9 +++++++++
>>>    4 files changed, 54 insertions(+)
>>>
>>> diff --git a/arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi b/arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi
>>> index 88f3f7eee2..534d9f8a2c 100644
>>> --- a/arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi
>>> +++ b/arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi
>>> @@ -15,3 +15,21 @@
>>>        bus-width = <4>;
>>>        status = "okay";
>>>    };
>>> +
>>> +&u2phy0 {
>>> +     status = "okay";
>>> +};
>>> +
>>> +&u2phy0_otg {
>>> +     status = "okay";
>>> +};
>>> +
>>> +&usbdp_phy0 {
>>> +     status = "okay";
>>> +};
>>> +
>>> +&usb_host0_xhci {
>>> +     dr_mode = "peripheral";
>>> +     maximum-speed = "high-speed";
>>> +     status = "okay";
>>> +};
>>> diff --git a/arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi b/arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi
>>> index 289578803e..b3d17a60ce 100644
>>> --- a/arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi
>>> +++ b/arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi
>>> @@ -15,3 +15,21 @@
>>>        bus-width = <4>;
>>>        status = "okay";
>>>    };
>>> +
>>> +&u2phy0 {
>>> +     status = "okay";
>>> +};
>>> +
>>> +&u2phy0_otg {
>>> +     status = "okay";
>>> +};
>>> +
>>> +&usbdp_phy0 {
>>> +     status = "okay";
>>> +};
>>> +
>>> +&usb_host0_xhci {
>>> +     dr_mode = "peripheral";
>>> +     maximum-speed = "high-speed";
>>> +     status = "okay";
>>> +};
>>
>> I don't see those patches in v6.10-rc1. Have you sent those to upstream
>> already? I assume we should cherry-pick patches in dts/upstream instead
>> of piling stuff up in u-boot.dtsis. This should also bring the patches
>> in rk3588(s).dtsi to add the missing bits for USB support we currently
>> have in rk3588*-u-boot.dtsi?
> 
> These are -u-boot.dtsi and nothing to do with dts/upstream and can be
> removed or reconfigured once we sync the DT from Linux.
> 

This answer seems to suggest there are no patches in the kernel yet. Do 
you not want working USB in Linux? Is something broken in Linux?

I think we're also aiming at only having U-Boot specific stuff in 
-u-boot.dtsi wherever we have OF_UPSTREAM enabled, and enabling USB 
doesn't seem to be typically the thing that should be U-Boot specific? I 
know that we have most rk3588/rk3588s boards with those nodes defined 
already, but they predates the move to OF_UPSTREAM.

As far as I remember, we've always asked people to upstream DT stuff 
they could upstream first and then import them in -u-boot.dtsi later, 
except for things that are U-Boot specific (e.g. different 
representation at a given point in time between U-Boot and kernel, or 
simple support in U-Boot but nothing in kernel yet). We could be a bit 
more aggressive with this policy now that we have dts/upstream as well. 
Ultimately this is up to Kever/Tom to decide where we want to go with 
this and how strict we want the policy to be.

Cheers,
Quentin
