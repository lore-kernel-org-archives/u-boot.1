Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B92FC02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 14:22:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D11B980820;
	Wed, 22 Jan 2025 15:22:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="mKKi+eOj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1C3F80834; Wed, 22 Jan 2025 15:22:18 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::61e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C41FA80805
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 15:22:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PITcAF/sD+CrVlVsL5goVED3TzHNNzxz4ma0l8M1KUI2Aew/0tcklBInVsT+V14wxYdX8B29U4o1isVOSYF4JdwkO0SRbUgTSIVN5vlFLzKItjUi1VtcDbAkpcRU5XaxnEzGEV5Ngf4x5BInLUQmkW3g3yMJFwNGYX19nLPVvlrOGBOV7dwcwWwO/ebA5FJN/kIrEKocKEjOPbQLE6FWDcuD9JQ7LDIFAggq47GM8gg0pbP7/i1PEBPa68ItZ6vBF7xbvoCxpPOgROLgVJAw9LIntq99LuAaCpgtxE+c8VngAhjj42PBX33gKW8GzsyVquWPmts+AwScSLE+nvmyFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KRwMTnxSTtydfEatmrQqvTJobF6zd9yHt+1SfFE/8c=;
 b=oCOdh1/3ufqUFW0S4kKfpfoRPsAKisM+4F5Xmlg3JJDlh1zFpdFXAFB3loWGDIbE2YPBnG7LC656bAK2CAJhYOgDWvm7Vh5rbwkVt+VWQCHjpLw35qLC2XM3LsijJS1rBq7peLUMS7MAq9pRB7lmSsTfqguTL6T5CRCRo8MrR2A5CnS51aB+znptqxJqyH3X6Hw+KmMG1fiNa+QqL9tM39zEYMv61NufQzNY/26LNxcIi+/yBHOqoaU4RYStVxjCmcVlpHreh8Nk71jxWQKHKcOFU5bXaktViorw8/laoo/K3AuO73/gn2q3037GAOhGfvyg+sYa7KOEQY9X9NGPdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KRwMTnxSTtydfEatmrQqvTJobF6zd9yHt+1SfFE/8c=;
 b=mKKi+eOjcurOfPtIRjc93y2gneMdUq4naQsUmym9HvRHCRB9uveXPXUZqJC7KveDIqKDhZBxDM4kUtYBZD5ZOEBELVZb0dP49bAFj5jZHdAPoBhs6x5Tt4jd90GZsZKlXSHrdaEI2g8WYYOJFRNR9jCC/nsH3dbEiRRAvC43ZZs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB8365.eurprd04.prod.outlook.com (2603:10a6:102:1cf::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Wed, 22 Jan
 2025 14:21:40 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 14:21:40 +0000
Message-ID: <ee42f531-0084-467e-86e5-3c16a8c90cb4@cherry.de>
Date: Wed, 22 Jan 2025 15:21:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] image: apply FDTOs on FDT image node without a load
 property
To: Quentin Schulz <foss+uboot@0leil.net>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>,
 Heiko Stuebner <heiko@sntech.de>
References: <20250122-extlinux-relocate-dtb-when-dtbo-v3-1-46bef4eac720@cherry.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250122-extlinux-relocate-dtb-when-dtbo-v3-1-46bef4eac720@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR2P281CA0059.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::13) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB8365:EE_
X-MS-Office365-Filtering-Correlation-Id: c2671010-868a-438a-994b-08dd3af0164a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UlhGWmdEd2xneHg0SFFlRW9BdVRTc29HQmo4Mk9LYk1oN3dmQVZZOWNkZGdi?=
 =?utf-8?B?TUdNbG0xYzNDaThOOEpmanllUXFiYkZYUk9Ed1o2QWl4NkxkR0FpMEhGQ25U?=
 =?utf-8?B?YkxhbmNyUGtsZUJPRzU4R2U0VnROeDdkaHBHRGpzOWNhbGJnV3ZkZU5lOGNZ?=
 =?utf-8?B?RzlJczBNaHNmVDRkZmdpdktUdmdMWklsU0RiblZud0hwV0lLSG1YTDN2ZEE5?=
 =?utf-8?B?dDFmZ2pKd2NJRzU2ZkVlQWpOQllWbnQ1RTZqQ09OekE3OVZicUk4ZEJpZHg5?=
 =?utf-8?B?dEw4QXhMTjJ5dFhhRXBDVmVkRy9yT1hLb09iZFRUZURBaDNCSERLT3psTVVQ?=
 =?utf-8?B?b2wwKytpNnVwckZRbmlwWFlIdU96MTgzVkwzWWVKcDArdE9EeS8zME54SnRx?=
 =?utf-8?B?M254RnpLdytnM2syL1p3Vnh0a0hFaDAxTnZkeVlCcEJxcFdRNXF0TkI1aEFI?=
 =?utf-8?B?SmxMSVR0clVLeFJsNit5WitKam51emQ4bEpGSE9kbzFEbWNTYW8vZTFhVVFv?=
 =?utf-8?B?V3prNlpIUUhuRkl0RmcwbllxSVM5b3pOczVvOU1vSW82SHBsUVNiN1dGcEg5?=
 =?utf-8?B?Y1RzUnpvTjc0WWdBb3VmR0FLS2FTMTdMWjhTdmNlMytSTEFTQ1UwMWlkR1Z6?=
 =?utf-8?B?dGVicUlzZFJMTnhvWXBEVVllaEtQeGhhV0lGNFRWaXNtVERHaUE2NW5uRFJQ?=
 =?utf-8?B?anRpRlhZYUxsaEtaZm93MVBJN0hsUEdjc2tmZkJtZHJ4WmJVem5LbkFrUWY4?=
 =?utf-8?B?TkVJL1FtZG5LcXlmbWZ0UisrNG10dmNYYkZIcG9PUEpxem5FbjRVblJNaFNS?=
 =?utf-8?B?MEFHWEpxdHRrSHRQZU5DSmJnbkNnQlJ6Q3FxV3hsanJwZk1BMGhFM0hpRm41?=
 =?utf-8?B?eG9mdHlObHIxbS9udDVlWFJ4cUthbTVCWFRBamliRGgzYm1salBadFNUZU96?=
 =?utf-8?B?ZzVReHlmZFZkdE0rL3F6aEhkU0NaVVQ4N0R5Y1Q1THVBU1EzUU11NFc2R1lE?=
 =?utf-8?B?a2ZIYlBKelE2M1VTTnNseUEvYWpicVhyOUg4VklEU2xaOXZicVY2bGt3ME9s?=
 =?utf-8?B?NW83NmRZR3ZKS0NlL1U0TnRmSFhuZ2poaGlUdzNDQXo0bUhnOFlYK1JXQlky?=
 =?utf-8?B?clE5RWh2QmdkdDJjR1J3VSs1a0pYYmFNVVEvNVBRTjJBV0FtanNsMlhaSHJK?=
 =?utf-8?B?bVJ1VEhDeW0yekx6bWlKOEh6RUhiNUZPeGw5OUhYcWVWamdDeURwNzVPZDdx?=
 =?utf-8?B?c2Yvc2RPbmhtQ1VUd0cwUVJUMkZjV2pXTjBNNGRLbkJLQTdpOWllUWErMnBJ?=
 =?utf-8?B?NGh3bGMyc08zZmxiY2dEd0tCRHBwblkxR3p2Q2lvSXR5RUpCRWExZENuK0Ns?=
 =?utf-8?B?OFhEVk5VTVVkL1VoZklSekt3VXQwRTN4eEhMNXhuR081bkgzNk5iVlZMNlFR?=
 =?utf-8?B?UWVKdUlHd2E1dGI5OXVGZzV4T1A0NFBXZnhSNGVQNXJYcHl1RXIra2JlaThn?=
 =?utf-8?B?WitYb04zNzBGVTRXMVMzY012WTU4MUJmZXJKdHJpdUh6Zk56TWhLMkU2SCto?=
 =?utf-8?B?djkwczhLSG1xNU9kWnZQemIyLzM3dGtNYkZOSXZoYXBvV3ZFZzJmcEROeVg4?=
 =?utf-8?B?ZWZhQ1A1MUFLM3hvaG8rT0FCUUluWHNnamVZck5wRmNGaWpJdGF0UnRETFVE?=
 =?utf-8?B?NWVNcHMycVd2SDVCSy9xQTFHeXhZaWhqdEgxQTQyVG9ZS2dOMjI4a3ZIZitl?=
 =?utf-8?B?dytJaEQzS3RoZU14MmE5Q2ZSUXNMSCtBNDB0VWdmTXZ0SGp1cFpMbGVTUFRq?=
 =?utf-8?B?V1pSa25iWFFkWGNhVS9taWN3ZGJhbDEzWmhKOCtnYlQ2SXA3MURPajU5cFc1?=
 =?utf-8?Q?MaB00dRpygbYq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGU5MnVxVFROcmxZNjRIclN5aVNKa2tNYkhybnJHZVMyQTBxTHZDajJ6VC80?=
 =?utf-8?B?Y1hKcDBRb3RLcUw2UTRHaEk3L2x4UEg1ZDRVUE9UMy9sdmdERElNTGdoc2Rs?=
 =?utf-8?B?ZUZMeHJaWU4yUGNGTWpxRnVocGc3NE1NMXVlL0tJdE5QSWsrekpMWWN5Slhs?=
 =?utf-8?B?Qzc5bWFhekNBQ3NrTVJxK2ZpK1FrK0Z2MGwxTWpQWHFPYStzYnZyRk5JR3hp?=
 =?utf-8?B?Nmw3elpLNVZNeGpJbWdHb3lYYlJZd2gzL25XWFdRVDRIbFBWemJpTjhBRlkr?=
 =?utf-8?B?SlNRSWxlV2xsSnVNbXpLL090SjJkQU9VM1hOQkZjdDVtbVEwbFkrS0x4aTlN?=
 =?utf-8?B?RU1CQjNOUEwzajA0S2FsNjVzUmJ6NURJNUVIbWNnUUZ6WjlxL3BiRUFVdVFr?=
 =?utf-8?B?a0hQemswMmd1eG9TSmwxeU1LNjhDcFBzeU0vU3loc0hkaHh3QmdkMC91b0JY?=
 =?utf-8?B?amIxbkJYRU5DVlN3aFpNbUdPV0dOSW15dVJ2RXpqV1ZuUnBrVTdCVk9vUkdM?=
 =?utf-8?B?N3pCOWZWMzY4aWxlMGpORE0xaC80MklxKzljdGlwdjFwQ05xYnF2NW9xbUtL?=
 =?utf-8?B?bFJLTVVmc0p1VTIrUUdsVCtabHlIdXB3RTM4UWJ2WU1KSkNGR2IxbzkwdjI2?=
 =?utf-8?B?UncxZkdpY3p1S0FmbkdhUExldHp3eWtKWXBhanNDV3htSEdQU1RQaXdxWnlk?=
 =?utf-8?B?OWFWRVNVZlpwdFh4WnlXSWZ3TGxTQTZXREdVYzFqSkt6QmFjak0zMWp1Sm5B?=
 =?utf-8?B?OTRQYVhKVC9GbytNMHMxSmdvWEVZb29pNTkzeXMxcExjaDY5VmN5VGVicTdY?=
 =?utf-8?B?Qzh4OGs0dlFEUmNQSFhtelI1R0V1Q2lHeWNtUHJxeEszOW9IOVUzRU1tVGV0?=
 =?utf-8?B?amNCdnF5bDREb2N5T01sUHIwRndPTTFQbnliMkFzbGQvTmYxR25pd2V6MUNw?=
 =?utf-8?B?L1NNaUtGQk5qVHdyWEozeitBOE9HM2luN3F2MDdQeS9TRUlGNSt5ZVE2VDdm?=
 =?utf-8?B?L1J6N3M5VGZWcE1FNm05cGtLc0x5QTFNQVVCQWtaMGphQ1pYUVh2RGZ5ZFlQ?=
 =?utf-8?B?VDdsZWhpcVdyekdRd3crVDl4YytWWDVHSTlBV2RweWUrakZyM1M2RGwxaWRa?=
 =?utf-8?B?eDh1alBrSUE3N2xWcG9DTy9Vd0p6ZXZsSWJyYzNZRk9pZEtyemczZTZscmhJ?=
 =?utf-8?B?T1E0OXNpZURhck1UNGNUd2Z0d1ZVWEt1VGd0VTZpSUhueUpQUVVHL09vZmo4?=
 =?utf-8?B?amtHNldzTGQvVUJ6bGttUFBpdld4L1dFSFJDYmo0WVc3SjNsd1VEL29KWWp5?=
 =?utf-8?B?NEx3aHc1SVRhcXExdHRnSndFMzR1bzcva0hxWmRTL01kM3JMT0YzYmN0T2dz?=
 =?utf-8?B?RHdMTXhoZ1BGKzdpUm5mWjhucXorNWtPSEdBY1hHQjdZWUVuUHpNYzgyL1Fi?=
 =?utf-8?B?OG4xS1hwSmhjaG5ZemVHTVY2dUdvRkdmSkhYWnVqcU0wMGRnZGp6L2E5cUVQ?=
 =?utf-8?B?Zm0rZ1N4OGkyalk1UDFaQkhiRGUySkpBNTRmTHUyS0hseU9MNnlhYk5BUGFR?=
 =?utf-8?B?bEVVcjVZY0xWMFhRMUFON0hrTnJUSzhXSnJwZDhrQkFYcXFLMDJ5T3NMd0xr?=
 =?utf-8?B?eWUzUm5Ud3lFUGFMWVlBMmtVN0crL0o5czh2a29nUmZDY3VralBJcmRkSm95?=
 =?utf-8?B?NkozVUFObGhnK2V5emozTWhKVFVsMlc5S251NitLTEJYc1NyNm92RnZIaWFO?=
 =?utf-8?B?WEIwRTdXNWhwb3JZaFB0OXY0NkptazQzeTZqN0ZYY1IrQlp6TUlQaDRtUm8y?=
 =?utf-8?B?UlpMMlAyVDlSSGlqend6YkExVUh5bHlTQm5ENFozcHl2ZkM4QlBQNlBMV2Uv?=
 =?utf-8?B?a0NaVjFhOW01bEFZeGFOemlhcE9ad2lTVkQvZyt4VkNUV3RyWU1WVC9pY3RD?=
 =?utf-8?B?cXR1N24xNXJFRE9aMzlFVWlzdExvWUtORGVlK2VPY25pdVhpZktyUmJuR3B0?=
 =?utf-8?B?SG8yRmN6Wm9SNGhEa2NTVFFIaURCTG5DRVZBQ2JtYXBaNjRHOTNsbS8wWmZY?=
 =?utf-8?B?L1llTGdJZFhwNXFoeG1ZVW40VjdTN1RiZjgwMlNabnJaZ3R2aWVNeU5aOGpw?=
 =?utf-8?B?eEY0TmR4dXdqM1l6c0pOdGJ6eXJaOUVWeG9BS3A2UlgxSFl2WDhObzNXZHdS?=
 =?utf-8?B?WHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c2671010-868a-438a-994b-08dd3af0164a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 14:21:39.9915 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0KdnyjlcgUUbjgeGYifm/Zggutyo5JbmNaFf//Wof6d5xBNK/7Ov7IMsrYC363gss8eE9FeFRpLQNtCL939v8t4/g1g34uU4FEwhkOlIo3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8365
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

On 1/22/25 2:57 PM, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> A FIT image which is NOT using -E when created by mkimage - that is with
> image data within the FIT - will fail to apply FDTO if the base FDT
> image node does not specify a load property (which points to an address
> in DRAM). This is because we check that the FDT address we want to apply
> overlay to (i.e. modify and likely increase in size) is not inside the
> FIT and give up otherwise. This is assumed necessary because we may then
> overwrite other data when applying in-place.
> 
> However, we can do better than giving up: relocating the FDT in another
> place in DRAM where it's safe to increase its size and apply FDTOs.
> 
> While at it, do not discriminate anymore on whether the data is within
> the FIT data address space - that is FIT images created with mkimage -E
> - as that still may be susceptible to unintended data overwrites as
> mkimage -E simply concatenates all blobs after the FIT. If the FDT blob
> isn't the last, it'll result in overwriting later blobs when resizing.
> 
> The side effect is that the load property in the FIT is only
> temporarily used to load the FDT but then relocated right before we
> start applying overlays.
> 
> Suggested-by: Marek Vasut <marex@denx.de>
> Reviewed-by: Marek Vasut <marex@denx.de>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> This actually forces the base FDT to always be relocated whenever FDTO
> are expected to be applied, regardless of the presence of the load
> property in the base FDT image node.
> 
> Tested with extlinux with:
> - conf node with multiple fdt entries (scenario A)
> - conf node with base fdt + conf node with fdto (stored in fdt property)
>    (scenario B)
> - conf node with multiple fdt entries with base fdt with load property
>    (scenario C)
> - conf node with base fdt + conf node with fdto (stored in fdt property)
>    with base fdt with load property (scenario D)
> 
> """fit.its
> /dts-v1/;
> 
> / {
> 	description = "Kernel fitImage for Jaguar";
> 	#address-cells = <1>;
> 
> 	images {
> 		kernel-1 {
> 			description = "Linux kernel";
> 			data = /incbin/("arch/arm64/boot/Image.gz");
> 			type = "kernel";
> 			arch = "arm64";
> 			os = "linux";
> 			compression = "gzip";
> 			load = <0x06000000>;
> 			entry = <0x06000000>;
> 			hash-1 {
> 				algo = "sha256";
> 			};
> 		};
> 		fdt-rk3588-jaguar.dtb {
> 			description = "Flattened Device Tree blob";
> 			data = /incbin/("arch/arm64/boot/dts/rockchip/rk3588-jaguar.dtb");
> 			type = "flat_dt";
> 			arch = "arm64";
> 			compression = "none";
> 
> 			hash-1 {
> 				algo = "sha256";
> 			};
> 		};
> 		fdt-rk3588-jaguar.dtb-load {
> 			description = "Flattened Device Tree blob";
> 			data = /incbin/("arch/arm64/boot/dts/rockchip/rk3588-jaguar.dtb");
> 			type = "flat_dt";
> 			arch = "arm64";
> 			compression = "none";
> 			load = <0x12000000>;
> 
> 			hash-1 {
> 				algo = "sha256";
> 			};
> 		};
> 		fdt-rk3588-jaguar-pre-ict-tester.dtbo {
> 			description = "Flattened Device Tree blob";
> 			data = /incbin/("arch/arm64/boot/dts/rockchip/rk3588-jaguar-pre-ict-tester.dtbo");
> 			type = "flat_dt";
> 			arch = "arm64";
> 			compression = "none";
> 
> 			hash-1 {
> 				algo = "sha256";
> 			};
> 		};
> 	};
> 
> 	configurations {
> 		default = "conf-rk3588-jaguar.dtb";
> 		conf-rk3588-jaguar.dtb {
> 			description = "1 Linux kernel, FDT blob";
> 			kernel = "kernel-1";
> 			fdt = "fdt-rk3588-jaguar.dtb";
> 
> 			hash-1 {
> 				algo = "sha256";
> 			};
> 		};
> 
> 		conf-rk3588-jaguar.dtb-and-dtbo {
> 			description = "1 Linux kernel, FDT blob";
> 			kernel = "kernel-1";
> 			fdt = "fdt-rk3588-jaguar.dtb", "fdt-rk3588-jaguar-pre-ict-tester.dtbo";
> 
> 			hash-1 {
> 				algo = "sha256";
> 			};
> 		};
> 
> 		conf-rk3588-jaguar.dtb-load {
> 			description = "1 Linux kernel, FDT blob";
> 			kernel = "kernel-1";
> 			fdt = "fdt-rk3588-jaguar.dtb-load";
> 
> 			hash-1 {
> 				algo = "sha256";
> 			};
> 		};
> 
> 		conf-rk3588-jaguar.dtb-load-and-dtbo {
> 			description = "1 Linux kernel, FDT blob";
> 			kernel = "kernel-1";
> 			fdt = "fdt-rk3588-jaguar.dtb-load", "fdt-rk3588-jaguar-pre-ict-tester.dtbo";
> 
> 			hash-1 {
> 				algo = "sha256";
> 			};
> 		};
> 
> 		conf-rk3588-jaguar-pre-ict-tester.dtbo {
> 			description = "0 FDT blob";
> 
> 			fdt = "fdt-rk3588-jaguar-pre-ict-tester.dtbo";
> 
> 			hash-1 {
> 				algo = "sha256";
> 			};
> 		};
> 	};
> };
> """
> 
> """extlinux.conf (scenario A)
> LABEL rk3588-jaguar
> LINUX /boot/fit#conf-rk3588-jaguar.dtb-and-dtbo
> APPEND root=PARTLABEL=debos-rootfs rw rootwait net.ifnames=0
> """
> 
> Log:
> """
> 
>     Using 'conf-rk3588-jaguar.dtb-and-dtbo' configuration
>     Verifying Hash Integrity ... OK
>     Trying 'kernel-1' kernel subimage
>       Description:  Linux kernel
>       Type:         Kernel Image
>       Compression:  gzip compressed
>       Data Start:   0x020000cc
>       Data Size:    11862415 Bytes = 11.3 MiB
>       Architecture: AArch64
>       OS:           Linux
>       Load Address: 0x06000000
>       Entry Point:  0x06000000
>       Hash algo:    sha256
>       Hash value:   51a2b828aec49d9ede09a2de2cd05226def258dedcc8e4c4098fa2ba38fb9690
>     Verifying Hash Integrity ... sha256+ OK
> 
>     Using 'conf-rk3588-jaguar.dtb-and-dtbo' configuration
>     Verifying Hash Integrity ... OK
>     Trying 'fdt-rk3588-jaguar.dtb' fdt subimage
>       Description:  Flattened Device Tree blob
>       Type:         Flat Device Tree
>       Compression:  uncompressed
>       Data Start:   0x02b50370
>       Data Size:    168750 Bytes = 164.8 KiB
>       Architecture: AArch64
>       Hash algo:    sha256
>       Hash value:   96213ce3930a5f926b27c90671ca779fc327e2e62c2135f7ed7d8b6dd659b973
>     Verifying Hash Integrity ... sha256+ OK
>     Loading Device Tree to 00000000ece9d000, end 00000000ecec9fff ... OK
> Working FDT set to ece9d000
> 
>     Trying 'fdt-rk3588-jaguar-pre-ict-tester.dtbo' fdt subimage
>       Description:  Flattened Device Tree blob
>       Type:         Flat Device Tree
>       Compression:  uncompressed
>       Data Start:   0x02ba2bb4
>       Data Size:    2753 Bytes = 2.7 KiB
>       Architecture: AArch64
>       Hash algo:    sha256
>       Hash value:   e5eb1fe225d03b04e9bb27c04fe3278f294b48c6ab6757292c9650f6d3ce9f34
>     Verifying Hash Integrity ... sha256+ OK
>     Booting using the fdt blob at 0xece9d000
> Working FDT set to ece9d000
>     Uncompressing Kernel Image to 6000000
>     Loading Device Tree to 00000000ece70000, end 00000000ece9c62d ... OK
> Working FDT set to ece70000
> """
> 
> """extlinux.conf (scenario B)
> LABEL rk3588-jaguar
> LINUX /boot/fit#conf-rk3588-jaguar.dtb-load-and-dtbo
> APPEND root=PARTLABEL=debos-rootfs rw rootwait net.ifnames=0
> """
> 
> Log:
> """
> 
>     Using 'conf-rk3588-jaguar.dtb-load-and-dtbo' configuration
>     Verifying Hash Integrity ... OK
>     Trying 'kernel-1' kernel subimage
>       Description:  Linux kernel
>       Type:         Kernel Image
>       Compression:  gzip compressed
>       Data Start:   0x020000cc
>       Data Size:    11862415 Bytes = 11.3 MiB
>       Architecture: AArch64
>       OS:           Linux
>       Load Address: 0x06000000
>       Entry Point:  0x06000000
>       Hash algo:    sha256
>       Hash value:   51a2b828aec49d9ede09a2de2cd05226def258dedcc8e4c4098fa2ba38fb9690
>     Verifying Hash Integrity ... sha256+ OK
> 
>     Using 'conf-rk3588-jaguar.dtb-load-and-dtbo' configuration
>     Verifying Hash Integrity ... OK
>     Trying 'fdt-rk3588-jaguar.dtb-load' fdt subimage
>       Description:  Flattened Device Tree blob
>       Type:         Flat Device Tree
>       Compression:  uncompressed
>       Data Start:   0x02b79784
>       Data Size:    168750 Bytes = 164.8 KiB
>       Architecture: AArch64
>       Load Address: 0x12000000
>       Hash algo:    sha256
>       Hash value:   96213ce3930a5f926b27c90671ca779fc327e2e62c2135f7ed7d8b6dd659b973
>     Verifying Hash Integrity ... sha256+ OK
>     Loading fdt from 0x02b79784 to 0x12000000
>     Loading Device Tree to 00000000ece9d000, end 00000000ecec9fff ... OK
> Working FDT set to ece9d000
> 
>     Trying 'fdt-rk3588-jaguar-pre-ict-tester.dtbo' fdt subimage
>       Description:  Flattened Device Tree blob
>       Type:         Flat Device Tree
>       Compression:  uncompressed
>       Data Start:   0x02ba2bb4
>       Data Size:    2753 Bytes = 2.7 KiB
>       Architecture: AArch64
>       Hash algo:    sha256
>       Hash value:   e5eb1fe225d03b04e9bb27c04fe3278f294b48c6ab6757292c9650f6d3ce9f34
>     Verifying Hash Integrity ... sha256+ OK
>     Booting using the fdt blob at 0xece9d000
> Working FDT set to ece9d000
>     Uncompressing Kernel Image to 6000000
>     Loading Device Tree to 00000000ece70000, end 00000000ece9c62d ... OK
> Working FDT set to ece70000
> """
> 
> """extlinux.conf (scenario C)
> LABEL rk3588-jaguar
> LINUX /boot/fit#conf-rk3588-jaguar.dtb#conf-rk3588-jaguar-pre-ict-tester.dtbo
> APPEND root=PARTLABEL=debos-rootfs rw rootwait net.ifnames=0
> """
> 
> Log:
> """
> 
>     Using 'conf-rk3588-jaguar.dtb' configuration
>     Verifying Hash Integrity ... OK
>     Trying 'kernel-1' kernel subimage
>       Description:  Linux kernel
>       Type:         Kernel Image
>       Compression:  gzip compressed
>       Data Start:   0x020000cc
>       Data Size:    11862415 Bytes = 11.3 MiB
>       Architecture: AArch64
>       OS:           Linux
>       Load Address: 0x06000000
>       Entry Point:  0x06000000
>       Hash algo:    sha256
>       Hash value:   51a2b828aec49d9ede09a2de2cd05226def258dedcc8e4c4098fa2ba38fb9690
>     Verifying Hash Integrity ... sha256+ OK
> 
>     Using 'conf-rk3588-jaguar.dtb' configuration
>     Verifying Hash Integrity ... OK
>     Trying 'fdt-rk3588-jaguar.dtb' fdt subimage
>       Description:  Flattened Device Tree blob
>       Type:         Flat Device Tree
>       Compression:  uncompressed
>       Data Start:   0x02b50370
>       Data Size:    168750 Bytes = 164.8 KiB
>       Architecture: AArch64
>       Hash algo:    sha256
>       Hash value:   96213ce3930a5f926b27c90671ca779fc327e2e62c2135f7ed7d8b6dd659b973
>     Verifying Hash Integrity ... sha256+ OK
>     Loading Device Tree to 00000000ece9d000, end 00000000ecec9fff ... OK
> Working FDT set to ece9d000
> 
>     Using 'conf-rk3588-jaguar-pre-ict-tester.dtbo' configuration
>     Verifying Hash Integrity ... OK
>     Trying 'fdt-rk3588-jaguar-pre-ict-tester.dtbo' fdt subimage
>       Description:  Flattened Device Tree blob
>       Type:         Flat Device Tree
>       Compression:  uncompressed
>       Data Start:   0x02ba2bb4
>       Data Size:    2753 Bytes = 2.7 KiB
>       Architecture: AArch64
>       Hash algo:    sha256
>       Hash value:   e5eb1fe225d03b04e9bb27c04fe3278f294b48c6ab6757292c9650f6d3ce9f34
>     Verifying Hash Integrity ... sha256+ OK
>     Booting using the fdt blob at 0xece9d000
> Working FDT set to ece9d000
>     Uncompressing Kernel Image to 6000000
>     Loading Device Tree to 00000000ece70000, end 00000000ece9c62d ... OK
> Working FDT set to ece70000
> """
> 
> """extlinux.conf (scenario D)
> LABEL rk3588-jaguar
> LINUX /boot/fit#conf-rk3588-jaguar.dtb-load#conf-rk3588-jaguar-pre-ict-tester.dtbo
> APPEND root=PARTLABEL=debos-rootfs rw rootwait net.ifnames=0
> """
> 
> Log:
> """
> 
>     Using 'conf-rk3588-jaguar.dtb-load' configuration
>     Verifying Hash Integrity ... OK
>     Trying 'kernel-1' kernel subimage
>       Description:  Linux kernel
>       Type:         Kernel Image
>       Compression:  gzip compressed
>       Data Start:   0x020000cc
>       Data Size:    11862415 Bytes = 11.3 MiB
>       Architecture: AArch64
>       OS:           Linux
>       Load Address: 0x06000000
>       Entry Point:  0x06000000
>       Hash algo:    sha256
>       Hash value:   51a2b828aec49d9ede09a2de2cd05226def258dedcc8e4c4098fa2ba38fb9690
>     Verifying Hash Integrity ... sha256+ OK
> 
>     Using 'conf-rk3588-jaguar.dtb-load' configuration
>     Verifying Hash Integrity ... OK
>     Trying 'fdt-rk3588-jaguar.dtb-load' fdt subimage
>       Description:  Flattened Device Tree blob
>       Type:         Flat Device Tree
>       Compression:  uncompressed
>       Data Start:   0x02b79784
>       Data Size:    168750 Bytes = 164.8 KiB
>       Architecture: AArch64
>       Load Address: 0x12000000
>       Hash algo:    sha256
>       Hash value:   96213ce3930a5f926b27c90671ca779fc327e2e62c2135f7ed7d8b6dd659b973
>     Verifying Hash Integrity ... sha256+ OK
>     Loading fdt from 0x02b79784 to 0x12000000
>     Loading Device Tree to 00000000ece9d000, end 00000000ecec9fff ... OK
> Working FDT set to ece9d000
> 
>     Using 'conf-rk3588-jaguar-pre-ict-tester.dtbo' configuration
>     Verifying Hash Integrity ... OK
>     Trying 'fdt-rk3588-jaguar-pre-ict-tester.dtbo' fdt subimage
>       Description:  Flattened Device Tree blob
>       Type:         Flat Device Tree
>       Compression:  uncompressed
>       Data Start:   0x02ba2bb4
>       Data Size:    2753 Bytes = 2.7 KiB
>       Architecture: AArch64
>       Hash algo:    sha256
>       Hash value:   e5eb1fe225d03b04e9bb27c04fe3278f294b48c6ab6757292c9650f6d3ce9f34
>     Verifying Hash Integrity ... sha256+ OK
>     Booting using the fdt blob at 0xece9d000
> Working FDT set to ece9d000
>     Uncompressing Kernel Image to 6000000
>     Loading Device Tree to 00000000ece70000, end 00000000ece9c62d ... OK
> Working FDT set to ece70000
> """
> 
> Cc: Heiko Stuebner <heiko@sntech.de>
> ---
> Changes in v3:
> - of_flat_tree type changed from char* to void*,
> - added Marek's Rb trailer,
> - Link to v2: https://lore.kernel.org/r/20250116-extlinux-relocate-dtb-when-dtbo-v2-1-d011582c2b7e@cherry.de
> 
> Changes in v2:
> - Indiscriminately relocate, regardless of location of FDT to be on the
>    safe side wrt data overlap/overwrite,
> - print return value of boot_relocate_fdt when it fails,
> - Link to v1: https://lore.kernel.org/r/20241219-extlinux-relocate-dtb-when-dtbo-v1-1-fe5eeb8fd4f1@cherry.de
> ---
>   boot/image-fit.c | 17 +++++++++--------
>   1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/boot/image-fit.c b/boot/image-fit.c
> index db7fb61bca948e42a4136b9ceb263a53362ad3f8..5dd896d019a70742510dbf2a9987b0b6948181ea 100644
> --- a/boot/image-fit.c
> +++ b/boot/image-fit.c
> @@ -2348,10 +2348,10 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
>   	char *next_config = NULL;
>   	ulong load, len;
>   #ifdef CONFIG_OF_LIBFDT_OVERLAY
> -	ulong image_start, image_end;
>   	ulong ovload, ovlen, ovcopylen;
>   	const char *uconfig;
>   	const char *uname;
> +	void *of_flat_tree;
>   	void *base, *ov, *ovcopy = NULL;
>   	int i, err, noffset, ov_noffset;
>   #endif
> @@ -2395,17 +2395,18 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
>   	/* we need to apply overlays */
>   
>   #ifdef CONFIG_OF_LIBFDT_OVERLAY
> -	image_start = addr;
> -	image_end = addr + fit_get_size(fit);
> -	/* verify that relocation took place by load address not being in fit */
> -	if (load >= image_start && load < image_end) {
> -		/* check is simplified; fit load checks for overlaps */
> -		printf("Overlayed FDT requires relocation\n");
> +	/* Relocate FDT so resizing does not overwrite other data in FIT. */
> +	of_flat_tree = map_sysmem(load, len);
> +	len = ALIGN(fdt_totalsize(load), SZ_4K);
> +	err = boot_relocate_fdt(&of_flat_tree, &len);

My bad, I mistakenly "compile-tested" this with a defconfig that doesn't 
enable CONFIG_OF_LIBFDT_OVERLAY so this was never built.

The compiler is actually not happy about that, it wants it cast to (char 
**).

@Marek, what do you prefer? We go back to having of_flat_tree a char* or 
do the cast in boot_relocate_fdt?

Sorry for the noise,
Cheers,
Quentin
