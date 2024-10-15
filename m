Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF22BD216A7
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 13:49:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 572C787DC7;
	Tue, 15 Oct 2024 15:49:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="eq560dFy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 962E68839A; Tue, 15 Oct 2024 15:49:12 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::606])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55349881A5
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 15:49:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uqe6SQSUSqM9EasnkqB4W2BL1oPIgVf/GVlYT1agMLe74vhx9o9BDoV3caW7fab66UEwWANgWMYe7m8k7XIC91+UngF1bFxeQZIoiZ0vdc3jNBW7Iqc5vHXsYevNvB8Ye003Dj5xfjjdsFdb+L5Z++75/aB1PxKwAbT8YY7Oct4R7enkyQgOrnnwxQSCZvO5xQwRTFpUoVtDZP9yIdM0GK7Y8K3NV1JSnrZBBtOE/U5Bu+CNzHJR9mwbFqBGVrqfjjSef6xZCKZD/FEjVikhODXa6KINKUfXvdDYbZG3melIQIrytG0yYUKYdAdf7QQpA9dMUUh5+cM1KnM+vUXGMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXqCbVWdn9dpk3/uGOZtLveWpg13C/9c4iaObV1HxQ0=;
 b=u+DLHtgT7We5EBtOTOkBid8wg5q1KDBf8DJaGGsQCjpu5+Ro97dnuGcCPdKFPT8CNetns0vrsHGwMWPkOHF2QdjeohCCC1/mVICxLhkTjctfw3kaY71wYTD9p7QPXwp87CIuSFDM3AIM3n8mCW6nuaQzyBsnNFLlj3tWOwoo0n/SIIeA1C6lhW1rBA5xZz6rn26jI3oeHAMofynjDzDUlsf/VfCXklihIQZiObFyUDNVKmd7f7b6GG0OYRMfN2R3jxixPe4X47RQWukiZAGxwyljqaKwoxbSs+jl7tTTXIYe0iGGuhZZWTI67ax9SYkOWGRgaZI7fSih48AFwHyr3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXqCbVWdn9dpk3/uGOZtLveWpg13C/9c4iaObV1HxQ0=;
 b=eq560dFy6xQkpmxXhFkwdTCIKevq/K6YqjzGgJg35NxIlGqmjsJejLHUc6aqX+GqmuVb/RrMRZ/81g9XMccMlcmTaQa1hLMAdYqxQNA0CxgNyks95tq88nqzyd82mecbnvVNEPa6x+I+A1aJUtRF9QekcwmLJuCmEKnLX6dBy6w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Tue, 15 Oct
 2024 13:49:08 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 13:49:07 +0000
Message-ID: <cec2653e-a90b-4e35-9413-59b68b494bc6@cherry.de>
Date: Tue, 15 Oct 2024 15:49:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] rockchip: board: Increase rng-seed size to make it
 sufficient for modern Linux
To: Alex Shumsky <alexthreed@gmail.com>
Cc: u-boot@lists.denx.de, Dragan Simic <dsimic@manjaro.org>,
 Ben Wolsieffer <benwolsieffer@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Marek Vasut <marex@denx.de>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20241014221523.2912260-1-alexthreed@gmail.com>
 <22953d33-b660-49ba-9664-845416bbc35b@cherry.de>
 <CAF4oh-PepZmO6-8szWUgG76kuTi6F1w+avWvK8mswa6O0dUdUA@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAF4oh-PepZmO6-8szWUgG76kuTi6F1w+avWvK8mswa6O0dUdUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0239.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::16) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS8PR04MB8404:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e83383f-ed89-4c7d-61a7-08dced2023ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXlVWmJ5a2QrWHdDSFZjNUROL3g5MFlTajFRelp3NVhybmhtbFFDNzdpMkMv?=
 =?utf-8?B?TnkwM0traE43eFNaUWpKbWhWUmVNU2czVEZibWtSVTNoQ005b2xtRU1Rb0JT?=
 =?utf-8?B?ZnQ2L1NFai9UK1h3cW9tOGkvckxrVkZxSEJoRG9hbEN0S2c0YzBMNU1HbTZl?=
 =?utf-8?B?M3c1UWt6ZjJwVE05cjVLK0o1NkxkKzhBWFVHbURRNFB0bU9oRlZmZ01tU1JR?=
 =?utf-8?B?WHcwZ2RRTFZ3TzE1VitKcXRxYmpCWnRJY1JsNWZiV3AzOEVldGQweEhxNHRL?=
 =?utf-8?B?bFU4ang2S3UwUE81R3cxajFIbDRScnhrempDdjBZVEhwYTMvaG5sL1BQbmN3?=
 =?utf-8?B?U0xueHE0ZHdhdVdGcU5TTTI5elV3Ri9Dd1ZzcVVBdTFmQ1VHZFMxdTVUUGkv?=
 =?utf-8?B?SVhoeUlrUEs3QmtjczZFbk9zM0RUM0Q3TitQODZ5WUVRWlpOeXE1VWVRMUtn?=
 =?utf-8?B?c0NtNklMRjRuTlRFR01tVmNwSThCbkw3TG92dEZId3BhNnI3ZlZFdGxBeWdM?=
 =?utf-8?B?ZHhoSUdPYVUxdnBWVWpIUWtsUTNOaGJMeWpHd2Q5VThQK2Q4Q1RwcXlicnRM?=
 =?utf-8?B?SE1jb3FPL01kQVFGU0FWMVA2MHNnTlVuNGlDMEZoZCt6V1MwQTRzalMzUnZK?=
 =?utf-8?B?RkxYMFAzVXZrNkc5b3V3NkRHWFA0SXpzc25YSkhWcnhOenNqNmJUTW5DN2pL?=
 =?utf-8?B?ZGpwNHpvemtnS1V2cWpVa0I0L1FhZGg2TWZiQ2JCZFp6Y29kNzlvcXBNQ0RS?=
 =?utf-8?B?TVdZYm4yeHhiRWhTQ0xWdngyWThQdHJUYTFwYTRVSkc3aENpTVZpbnB6Rkpl?=
 =?utf-8?B?MVNESUJMZlVQd3VLRUdob1JyU3dGcHlJd25zSFpRRmo3SGt2ZERwdFVEL21D?=
 =?utf-8?B?WGVuVGp1akhEd2RWSTF4TVFtRG9XSVordEJWM3Awclo2OUlPVVNTeXU1dE8z?=
 =?utf-8?B?OFd5MlVSTTY4bGd6Yi9vYkQ1YTB4YWZVWkZheTR5RG84ZytvbG1oSm1yWXI1?=
 =?utf-8?B?WUlZYXc1SU5EcmlrdmVkdjhQNGxlSnlLamZxQ2ZHMnMzcndwNkZuR0JPbzVP?=
 =?utf-8?B?NTViTTh2SW9qdmZYQVBYbXQzRjhvNmlvK1pnSzllbFFRZHZxcUVjQVZaZHFr?=
 =?utf-8?B?d2l4bXUxV1JXT3luc2dZeitsL0xlbUZWTjF3d0pGWk92TmZGcVozVyt2cGYr?=
 =?utf-8?B?UnJhQ1NLWGc3NjBsOGZaUkhDKzVqZkdhanZkbzBRSzhFd2prRlNMRHFaOWJI?=
 =?utf-8?B?T0RDZHVtbWlhVjFwL0dhRlRTSm44MU5Sd2lydVBJTXlON2lNR2MzdUVPZTU1?=
 =?utf-8?B?S0dBQ3RDVGZZeXlxVkwvQUFQTUY3TmtJbDBpOXJYSlNvTUdxSXY4WU1DVWVQ?=
 =?utf-8?B?TUJMR0w5bUxJdVF0R0sxTytsMFVzZk8xWGhUU0ozQjQ2RUZtZXFwc1R5ZUhD?=
 =?utf-8?B?T1U5NWJZOU9tRHQ5ZFhrQzRycGIrakJjUUhrWmtHd3pWcitHcnlzYkNoV1V3?=
 =?utf-8?B?WU56bTVuMHIvWHdwMkxmMndOV1duUG1MRVIvWEYrZzhHZUpKeElRRnMyN2Jq?=
 =?utf-8?B?TXlJbTUrcUpzeWMrc3Z3K0FqL2k0aHVMc2I5L3dvRlIrM0RDRndraWVLN25h?=
 =?utf-8?Q?X2IPk2gkVx9IqTC5yGTgWnPIBgKlyfRxU2aRqvoGcIVg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlIyMXVDS2ozYnNSKytzOU1Hd1crZFVrN2tKajlWbHZHMlo5bkxKNFJTWFE1?=
 =?utf-8?B?LzN4WkNKaWE0K1FsZ3VHczhUa1V2RW51RndzWDZ4L2V4RjQyelN5Q3ovcnVm?=
 =?utf-8?B?dlA3cVBZZmpxVXlmMEpmMVIxcGNXZTRiWjg5bWdKWnJtWGVuM2VFdnltc01j?=
 =?utf-8?B?ZlhOd3Z3VUg0TnpoQXlnYXR3eCtSSjBBSVorNFpQZmdpbEtCT1RIbmVydjBy?=
 =?utf-8?B?eHBvRVd2ekMxRU55eXplaGx4c3NFUitXejl2aWJqT0F5M2diUDJYeVo5SGtJ?=
 =?utf-8?B?MUZDbTVHOGFkSlM1U3loRTcrd3crZXU5YXc2QmhBeklzbXJJNytzNWQvMmNH?=
 =?utf-8?B?ZGpmaCsxRUY0c3pqMzFTWGg4SVdwejdtWGVqMEVSSHVnV09RemR2am5iaDJw?=
 =?utf-8?B?dDNSYjEwUWlkUU01R1JWc1BBQ2xYNHRhQ0JSQUxqWWRuS0k3NDdPalFwK2JW?=
 =?utf-8?B?M3pSTE9ic3pEOWs0d1RHZFVFeUoxZkhWcHBYcUV3RnI5b0ZpQlkzWldINUhk?=
 =?utf-8?B?M2lscTJVSTRWU1VCb0dncm5NSUdCSlN3a0JzbGs2ckdYMWVMUWxsUU95U1ZP?=
 =?utf-8?B?WEhmMWRTWW1GbkZoUlNXNjlQcWlDaWo4dkE2eTl5K2dqcmhiYVp6NXdLdENK?=
 =?utf-8?B?bWY0OTNFM2FDMWpOdU43TGlrWkZCMXNCSjYyenEreWlQU0JpVFg3MGNtbjhT?=
 =?utf-8?B?dDJaditRUzZBNk1LNk9DdzloN0RWK1FCU0o5aG9zbU9uSW1XcmpnNDNTejZn?=
 =?utf-8?B?SmJITDZ3OTIzZytPL3JKMEVZMUpoOU9ha08zVytldWk5bEhuSDAwbG9jQmZr?=
 =?utf-8?B?c2lxdGR0ZkdGQTZkL1JLRnRoejVDQ2VBRUtXYnUvdGFrSk9jV3pEelhnbitm?=
 =?utf-8?B?V242UzloNSt6UnZEdUtzWFc2VGozVUlNY2l6dWNIRmVOV1MzN2dUY3VsZXQ2?=
 =?utf-8?B?ZUJBMjNmaGRwcXJ3L3pSSTFHa0hUOExWSjE4bG5MOXo0MFNvaE9qN2tYTWIy?=
 =?utf-8?B?NjhPYXdndkg5eCs0dFZldW5KZHZSdWtjVjh6SG55Q091WEZoTklpVHMyQmVn?=
 =?utf-8?B?K1ZsdHpwOVdmV1hLSEJ1MmFEeTBDNWJKMkkwK3l0WFhvMEJ4L1dPYjdiZ2tC?=
 =?utf-8?B?ZVJoYXdHc2VGTVlGQWtlckllSHU1YlJHLzBkNmh1dTFjdXlsenFVWlp5U0ZX?=
 =?utf-8?B?TmVzN05NV3NMVjVvV0FjcTNLdU16VmpsallYRnE4M0NjSm1yakluVUVxSzRM?=
 =?utf-8?B?RStBRjNoejhlSWhNN1REa25xZVpPZW9GQ0ltT2Njcnloei9NcFBYelZlVHNF?=
 =?utf-8?B?WW9zVlBOazd6L2huUEdvSitUZzVvZkJSQVJWSGk2NDhEL1JtQkYwNWVjRS9y?=
 =?utf-8?B?TExEdHZjUUNaaG5kRFNBODBsRzRJSTlKU2MzMG84dmljL2dxUUtaZlE4cEU3?=
 =?utf-8?B?TWVKdTQweFgzSG9icWRvbmZ1N0Rnc0tZd0d4c0hFZkZKLzFybTJkSmhNYzkz?=
 =?utf-8?B?NjZLQW5RTVNxYUQ2akovWjJ1Mjh2OXIzL0o4RHE3TG9rZzhkY2J6UGhUTGhM?=
 =?utf-8?B?SzdsSDBSZTY2dnRRdGExVkJLZzJUQ004bEo0R1VvRDQ0dmpldzk5RGxWWitE?=
 =?utf-8?B?ZUVvQXNHcVZGdWtJMjJ4M0NQS0JLK2UwcGlsK3BKNnpNMGREcUV0V3BvSkFn?=
 =?utf-8?B?RWZaQWplRWZDd0d1S2hORTE2NnFiRHUwU3Fhemc0NkRsTktyVDVHbXdDUURu?=
 =?utf-8?B?TUlpMGdER0tHS2F2TU4vNzdJUWpCWFE3T0gzOXJZQmE2bUY4R3ZIemtwZ3dv?=
 =?utf-8?B?ZmJnTTl2TnNRcVljT011N0RJOWNOSGswZGdxOXJPSE1mWjdpR3RIQklua25Y?=
 =?utf-8?B?OEZuakc1V0tpby9YTFEzV3BzT0ExZmRlWlpUR3FNNXVoTVBOSW1PMW9zUFdt?=
 =?utf-8?B?OG55OWt5TjFzZllqdXlMOHJDRUZDWkl2UHY1bDhpVDJtWUJScnZROHI5c3hQ?=
 =?utf-8?B?bGUrZTBnaDZDbHQ1cXVlbXdLL0tKb2ZCckJRbExITmVHZW1NZWpjaGdnclND?=
 =?utf-8?B?YmVMODlNYlJVUWw4VFJMR1YvUk85Rk5KM0luVVRqNk5rdmNKODVRQStQQU5h?=
 =?utf-8?B?cU9mdVp5a1hyTnFjSmV4WERLQnlBZGsrckpLOE92RUhhMXk2VldGZmxESmt0?=
 =?utf-8?B?R3c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e83383f-ed89-4c7d-61a7-08dced2023ac
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 13:49:07.4592 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZR1A+UV1HvMC3eQMKHkJVgNwbcKRvXeywhOKRK4lBioB0TpoO70bgS85FPGCdrhEbroVbgk3TEbQnY8YONwzeNGlb4m9WBMVEROl9ClV/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8404
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

Hi Alex,

On 10/15/24 2:42 PM, Alex Shumsky wrote:
> On Tue, Oct 15, 2024 at 12:34 PM Quentin Schulz
> <quentin.schulz@cherry.de> wrote:
>> I'm wondering if we have somewhere some documentation on the environment
>> variables that exist and what they used for because this would be a nice
>> addition. At the very least, we can mention this variable in:
>> - include/fdt_support.h for the function
>> - common/Kconfig for the symbol
> 
> I'm not sure if we can expect that all boards can implement the rng_seed_size
> config knob? Currently rockchip is the only board that implements
> board_rng_seed.
> 

That;s the neat part, we're the only implementation so far, so we kinda 
get to say what's supposed to be "standard". I think allowing to get a 
specific size makes sense generally.

Basically, I would like to avoid 1) people not knowing how to change 
this value 2) avoid having different implementations using a different 
environment variable.

Tom has just told me on IRC that we have doc/usage/environment.rst for 
environment variables' documentation, so that would be a good place to 
put some documentation for this new variable :)

> common/Kconfig BOARD_RNG_SEED description looks rather generic:
> 
> It is up to the board code (and more generally the whole
> BSP) where and how to store (or generate) such a seed, how
> to ensure a given seed is only used once, how to create a
> new seed for use on subsequent boots, and whether or not the
> kernel should account any entropy from the given seed.
> 
>> I'm also a bit torn on the base though, I think the assumed base is
>> generally hex and not dec, so maybe we should rather have that?
> 
> We need a poll here )
> Marek Vasut prefers decimal.

Hehe, I think this "debate" will never end, I already had it with Simon 
and Tom a few weeks ago. The "issue" is that once that's decided, we 
cannot really change it as that would basically break compatibility (new 
env with old U-Boot or vice-versa). Not a blocker as such, but needs to 
make sure it's aligned with expectations.

https://docs.u-boot.org/en/latest/usage/cmdline.html#representing-numbers

Cheers,
Quentin
