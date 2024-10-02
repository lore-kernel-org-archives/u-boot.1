Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA4BCF31A9
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 09:25:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 723F888F4A;
	Wed,  2 Oct 2024 11:25:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="VLdslNsT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3293988F3A; Wed,  2 Oct 2024 11:25:49 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::62b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF20A88F19
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 11:25:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lccoQQKBtEdqqq0ftZkU+qbwPSpx18KCTM4FeWioTX24Z+vMzQdkcjigi1RiKnUlVWV/kIOw9FLtyvNwMtzR4aJLMORvwyWqV7D2uPpZoY8KXlFqg1+bwuQyWYtzC9C0rikW7GG46SWRv9wm7fMZxh+YxMnwJN0HbakokOf+HpE9W0xWM0bAFOs2P2VbWZUy4KjqfpomWQzB7QQNRtr/+YQ/rqMTwxBslVKFq8aJXl7fD5vEir+wmUNwgnMD80RnlOz4ywQrOWGbotBH2dTEmINoFXfRzeOCI6vXZwJ3LYbSKyx0E6eLGHQW/r9hQjBF9NOdMSqfE29Mv7TQdACdAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kN53gLXlKfSJ5OEhg1lz3xQI6uMDfqjdV+3qnEfJvBA=;
 b=yJWT4JFKFwHetcvp6BnGn3kBn1f0jfcv/x33YFb4ZtMt/o5hEr4HtEvcOPYjN+ntPIyOoWTZUOgPzGRuHfeXKnctBcCA46u+GTQXt0POi3wmRQopk18rg8olD9P8qQ1vlXhWu12k3knX4Ik5Z4unncszP6PspI9fIMax+SNj/fjIUmyx0Nv2av8shhLQd+70HIn0X7v71DLw//UbNhw4nLdyIHiD9dcsrhlpDwxrEKcxvOK9StG5IBYjpYc5zNSDLzMaYrWHFhxOab9W+eEkZYEBiuVZFZM8FR8PIa8XVveNiuJfDDQmRoZOWyKW+RTRJ+W5AQ+T4lyGftqaIgx1+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kN53gLXlKfSJ5OEhg1lz3xQI6uMDfqjdV+3qnEfJvBA=;
 b=VLdslNsTeoh8heXU422t/fT+L2r45t1KRA7vTYl2mjhzs0AOEI8bzWnBQFjBRAb4TPgKB8TDz8UmXlaNHabfnugoO1uEITTL+qbDkgfB9OB+D2Pj8I4XoLyDLl1QOaNvkEMf5MvnH1TYRv/AIGUu4T/94XSwz76IpZWqiOqVPYo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM7PR04MB6808.eurprd04.prod.outlook.com (2603:10a6:20b:109::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Wed, 2 Oct
 2024 09:25:40 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 09:25:40 +0000
Message-ID: <cd12220e-a111-4576-87d1-e838f1c5998e@cherry.de>
Date: Wed, 2 Oct 2024 11:25:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] dm: core: migrate debug() messages to use dm_warn
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Dario Binacchi <dariobin@libero.it>, u-boot@lists.denx.de
References: <20240611-misc-20240610-v2-0-028e82b0b620@cherry.de>
 <20240611-misc-20240610-v2-3-028e82b0b620@cherry.de>
 <20241002-caption-saline-d00d342af087@thorsis.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241002-caption-saline-d00d342af087@thorsis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0326.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::19) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM7PR04MB6808:EE_
X-MS-Office365-Filtering-Correlation-Id: 16d09370-494f-4fd0-e07c-08dce2c42e26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|10070799003|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SG9HeDdVaHFCdmdyOUsydU9ISFNSTmtYYkh3WHVJRU5oRmNOUUNCL2pPTGcy?=
 =?utf-8?B?N2VsTjhTRWM2VkhLS3F4Yms0bVo1R0YwVytWU1ZhcVFxUW1WN09oZW91Q00r?=
 =?utf-8?B?V2RkNXNaZEFZa1Izc3h1OWMwZlZXekIzMU4vQm5CdkR0ODdQaElnNU5RSHNL?=
 =?utf-8?B?WDAxdy9OclR3MTVMck5saFVwUXZJOXB2VE9ZQk9SWXZJelp3VjZBQUFZWFhj?=
 =?utf-8?B?bUFDM1BaVGVReVJSY2dPUWphTWwrc0hrb1lNZmp3TmY3RGVJbklDeFpNSEsw?=
 =?utf-8?B?bHZFSytzMVJTaDVIbDd0b0d6L04xY3NlRHc0TlJuZk1JeGFPc1BLRGRtc3Mv?=
 =?utf-8?B?WFAzU1lJWjBPM2ZCZG1JaThQdllhVVQwWk1YRjJ5RldGWXJBaEIxR3l6Nmwx?=
 =?utf-8?B?NmM2emJoQ0RPbklpaER0Nno2L0hPUzF1eURya2lHSDUyMHc2bEhIVDI3aFZH?=
 =?utf-8?B?SCs0YWI4ZHREODMyZ0V0MDlOSmR5Wmt1R2U2ZlZtWHI5SkZPM1prOFQyTVVn?=
 =?utf-8?B?cTNxVGNiVHl6YTdMek5TNUJtck5pU0tEeDRDZWJUc0JqMm4wTHo2KzQxMXFq?=
 =?utf-8?B?YzV5QmhHbi83ZGxkNUkzZmpYOWRqWCswVzVaTXhFTWEvZVFpQTB3S2U4VFQr?=
 =?utf-8?B?VlN3KzVBT0ZFdkVISnh0cGhDTTFjUU5MdVJ6M0xkUm9pRmd2dFcvbkh0UTdN?=
 =?utf-8?B?UmZrVFJFRHhaWU80RGtIYUNkRnkrY05OQUNBQ09LbE9meDdwVjluTkoxTEJn?=
 =?utf-8?B?aWpzVDA0d045UDZjUTg3WUJLNldyS3cvVU81eTlkcWFJSjYzWkNtUUdtK1p3?=
 =?utf-8?B?ODRiaGl2dXA5QU5YYkhzbkVydmZFVE9xVW9UZWRneFhJaDJ4aEhNRm9XTTE0?=
 =?utf-8?B?ckNHU1BBaWhtcklJN2JIWUVHVWM0OFJzcFhtTjg2Q2k4UmtiVDJHY0ZHTnd2?=
 =?utf-8?B?N2VyeHgrTjNTSHZ6b1FwTUViaG5OQXpqVG9iN0tCbjRBTjhjdzhNUDRpbGtt?=
 =?utf-8?B?UlRiZU9jNXFiS0M2ZjRzaHY5eHdwWmdOeG50Mjh3SGd5REYxajBwcFAvbCsx?=
 =?utf-8?B?VHU2dDNJQlJwT3RBTWhjVWhRQ2tsNzAwNmJIZHk2dVZOSTVsYWpESnBUYkI0?=
 =?utf-8?B?RHNLZXNpL2N0RzByTXBSK2graml1bVp2SnJGZjVRNnhvcnFHb3FvM3JEYm1Y?=
 =?utf-8?B?YS9TNlZMdkUzek1jU0I5TmdMaUxwNkpINnBvV1pvWU03WG9EVlZZelliL29G?=
 =?utf-8?B?M2JFUDFhWnliODB0bW9yczhwSHAvdnZCUmZoTDI2aFlBMmp3cFRUaEM3QVhs?=
 =?utf-8?B?SXBQbGxhL1JWMm5oRzdmS2hQeDdxbmI5cVd6eTl2Njd0c0tXdVlIdDE5cnBr?=
 =?utf-8?B?N1ExZXNmS0xwSFJ0ZTUraFVyZWdEYTMrbVp2ajNRWTg0UmZlY3E3dXRtVHVN?=
 =?utf-8?B?Wkw4ZnNaT1Z2d1pYMDErNFNQTGpUWFA1NjVKbzhUZk1jeWdldi84R2hDTE5B?=
 =?utf-8?B?bkUxV3g4cDE2MENDVFZsTEpLRi9kdHJGZjBNM1dLOGpvRGZYNVp5c3llbHU0?=
 =?utf-8?B?WkhuSXprcHo3VjJuTWh1UUc1Qi9acDRwR0JLTlkzblc0aVMwbG1mZXNiWjdX?=
 =?utf-8?B?amVsMDU2dE9WNHQwZ21rOW9mUzBZeWt2QktyZWhqaG8vSVNscXdnT2cwWTly?=
 =?utf-8?B?RGRHTG43emRnYVNxTGVnSlhrdWVDaEJXVGpmMVB3ck55S0tmR1JQdUIvYTNl?=
 =?utf-8?Q?+i09H+kDzulMOFBhmw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWJ4aENaRnVMSlhTTkhxWUZnZTNUaXhKOTNlbk04ZFNGdHVmUGJ6WUJoSFJE?=
 =?utf-8?B?WEpxQUc2cDVSZ1RDNjNrZmU0b1VmaEk2Zm5hNC9qU2RNVTFYK3g3QzlsMG9x?=
 =?utf-8?B?V0MvcGM1THJvc3UxUndLVWpOeFBxTVp5SGlkVllpcmNuTWgyeUZjTE1hanp4?=
 =?utf-8?B?K3FFVVNtWDJvM1VkN3BqU1hwOC9BUjNxUmdnNCtiM3ExMEFyOWs4WWVmT0xy?=
 =?utf-8?B?Vzg5Z1c1bWtDODFjQ2tWdnZENkJqOHVuanFubDAxaUN0OXV2eFhXeFg1cEJP?=
 =?utf-8?B?SGdNZ1EzZ1BKbGNmNDdnZThXZGRGL2lGb3k4blZkanZLcURDSytjenpwazdH?=
 =?utf-8?B?ZHZqNnhnY2o2cTBLK0RLV3ZpOGZkcnRKbGRRVzl5cUFEcUp4UndxTWVPUlVi?=
 =?utf-8?B?ZTZJdU5nV09HamhxNEZxV2pJTzlBcjlsc0tTL0pNRzAxQTMxS3F6U21qWXBL?=
 =?utf-8?B?aVMzbytvR0VXNnd4UkNEbWhacnV1bEtxaGZkbStwUW1BeFd0OUIxbmpjOUxY?=
 =?utf-8?B?SHJ1K0ZISDdrVGc2TldjMCtSbU0wRjVaMk1YRk80VFJvMXlOYmdSaDdwR1g2?=
 =?utf-8?B?UDlQSGRBUVY3R3NvQjBCUXR0Z3QyQUpnRnpQWWlhK2E4RHdzeTc1K2Npa1Y5?=
 =?utf-8?B?MmZERnlvMDlZcjJWS2NVcXlKaFVWVnM1Sm8xMFlHaE93VlBwV3dTc3BkQld3?=
 =?utf-8?B?ME5tZGFmeVdBTG83QTk4LzJ6RFhqdnJZTVl5TEVrZEczeUtCV21Wc3ZmdU9K?=
 =?utf-8?B?R1pXeXIwQk1FMVQ1Uk1FYVgrTTFBYUhTNjFMbWo5UWtUaytMclFtUUNzUlAv?=
 =?utf-8?B?em10OCtGdElFMmw5TUdhcWNFeU5ESU9RVmJsUXdxRTlrU0FIZnEwZVF3QTdV?=
 =?utf-8?B?RS8zQWlvTVFIbWF3VGFaN3pkSzIycFhlNHZxOE1TQjhFeUx0bVNFbkZCNHM2?=
 =?utf-8?B?ZitNS0cxNFh1NTdCT0FQRERkNGlxdzlyenZCWnZQY2JMV3RMUFd5d3pCUjI0?=
 =?utf-8?B?RDdUOW43RW9uYUNBRDZna1lkeGtjS2VGY1ZvczRudlpKRCtNMDVZcDFyRWw4?=
 =?utf-8?B?ZU1laDZ5MHUxdDNnOGpTRWI5UUZrTjNDSWJONEZGQy9odTB2T3JhUmFVSUo0?=
 =?utf-8?B?K0V3cXAraDczUEd2TUhjMzZvR1psZXNUdXdNT0VDU0NKb2pvQ1g3VlFreVFF?=
 =?utf-8?B?ZVV6Z2VHVlYxODJkQXBWamc2R1M5WWozSFh1ZDk2MmpEUmpRZFZkVllMSkZ0?=
 =?utf-8?B?QWQ0Y1FONlFMeURXcVBQV1ZPek5pM0JGbEk3c3BrdXJZVFgyUWhycnJoeFF1?=
 =?utf-8?B?TlZiMnYwRjI5NmlyaXJHamJiWGVsVndKRGJxVWhObkQzZTk2cUhwbE9tdDdp?=
 =?utf-8?B?UTF2bGRpSFNqQ2RUNHhlbDdLYmRIY1Jyc2dKb3dweldZUEVzaDB5VGwyWWwr?=
 =?utf-8?B?UG0yMHI4U09vWHFWNnNCWTE5ZUwxbGZwMGxKcXIrVkZkck5ETzllNFNRc3RB?=
 =?utf-8?B?c2xLcXJRbVJrQ1RnQ3JpdUY1QTB3aTlZOS9RNXlIcHY1Z3Q4ZVlyOEtmMFVa?=
 =?utf-8?B?bDFSbXk3OVBsUGpQV2ZhQTNzRnZZb0ZENUcrSUtFN2ZISWRRRWlVeGZsWGw2?=
 =?utf-8?B?NHJ1NFo4K1Z0TTBLaTZwNE1ka1NEK25jTkIvTldicnkxc1l4UHJzZ0FZOHZS?=
 =?utf-8?B?YVhaZ1A3NlZKemh6VGdJeVlrald1dlE1MXQzNGVRYTA0LzBXY3drTW5wam1K?=
 =?utf-8?B?SXIwYXFKWUVCR1FlVmxPYUxMWlZYeG5mZmtOc005dS91eXNkWGk1UXV0MVpQ?=
 =?utf-8?B?cTQ1S09OcDVPZDcyNjQ2WlY2L0hINDMySEFHZDV5cFZKMGEwRWpmK0taZ1Iw?=
 =?utf-8?B?VHhVUnFYNFh0bjZqTkZzUm9NSUdaTjBuWkhXQjM0a2l4QWhhUzBLRmQ5WEdh?=
 =?utf-8?B?RmNHVStZM1hGQURNbWZ1SC8zTGZVU2FVTm1OZWpEeTlDY1FnZFI4a1lQMEc2?=
 =?utf-8?B?R1VRbHEwT1YveHJnUHplZ05lTXRaaDJaM0Zod3ZxbEZHYnRKd0l4RFJYUjdD?=
 =?utf-8?B?azZrSmpDa3EzVUxCcFVPZGJmOExZZHpsdEh5dlRGRUJ1OHVkc1VZanNqc2Q0?=
 =?utf-8?B?ajJZL3VERURYZzF5ZjFXeU1kTUZRMnZLcGVqTHZxcDVvNWpGYW1QOE83RWVp?=
 =?utf-8?Q?mI2TagJDyXvn60bmTeSOQxs=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d09370-494f-4fd0-e07c-08dce2c42e26
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 09:25:40.5524 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vMukbKjO47GXJzyJyPBXnjr91wKmDGL0lxOLChG9VrWsdR54IPEY521x1z7bOdYhvmPaP7K4XDikB0bh8HcO62A+EyJLvWIuS9wvukt5hT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6808
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

Hi Alexander,

On 10/2/24 10:37 AM, Alexander Dahl wrote:
> Hello Quentin,
> 
> sorry for being late to the party, but I just tested v2024.10-rc6 and
> my console output looks like this now:
> 
>      ofnode_read_bool: bootph-all: true
>      ofnode_read_u32_array: ranges: ofnode_read_bool: bootph-all: false
>      ofnode_read_bool: bootph-some-ram: false
>      ofnode_read_bool: bootph-pre-ram: false
>      ofnode_read_bool: bootph-pre-sram: false
>      ofnode_read_bool: u-boot,dm-pre-reloc: false
>      ofnode_read_bool: u-boot,dm-pre-proper: false
>      ofnode_read_bool: u-boot,dm-spl: false
>      ofnode_read_bool: u-boot,dm-tpl: false
>      ofnode_read_bool: u-boot,dm-vpl: false
>      ofnode_read_bool: bootph-all: false
>      ofnode_read_bool: bootph-some-ram: false
>      ofnode_read_bool: bootph-pre-ram: false
>      ofnode_read_bool: bootph-pre-sram: false
>      ofnode_read_bool: u-boot,dm-pre-reloc: false
>      ofnode_read_bool: u-boot,dm-pre-proper: false
>      ofnode_read_bool: u-boot,dm-spl: false
>      ofnode_read_bool: u-boot,dm-tpl: false
>      ofnode_read_bool: u-boot,dm-vpl: false
>      ofnode_read_bool: bootph-all: true
>      ofnode_read_u32_array: ranges: ofnode_read_bool: bootph-all: true
>      ofnode_read_u32_array: ranges: ofnode_read_bool: bootph-all: true
>      ofnode_read_bool: bootph-all: true
>      ofnode_read_bool: bootph-all: false
>      …
> 
> This goes on for several screen pages, and clutters the usual output.
> I first thought I messed up CONFIG_LOGLEVEL or CONFIG_LOG, but no.
> All I had done was setting CONFIG_DM_WARN …
> 
> Am Tue, Jun 11, 2024 at 03:04:26PM +0200 schrieb Quentin Schulz:
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> Prior to that, seeing the debug() messages required to enable DM_DEBUG
>> which defines DEBUG (and then _DEBUG) which in turn makes failing
>> assert() calls reset U-Boot which isn't necessarily what is desired.
>>
>> Instead, let's migrate to dm_warn which is using log_debug when unset or
>> log_warn when set.
>>
>> While at it, reword the DM_DEBUG symbol in Kconfig to explain what it
>> now actually does.
> 
> CONFIG_DM_WARN currently reads like this:
> 
>      Enable this to see warnings related to driver model.
> 
>      Warnings may help with debugging, such as when expected devices do
>      not bind correctly. If the option is disabled, dm_warn() is compiled
>      out - it will do nothing when called.
> 
> Instead of just useful warnings, users get debug messages all over the
> place now.  Is this actually intended behaviour?  Can this be fixed
> before v2024.10 release please?
> 

There are basically less than 3 working days left before v2024.10 is 
released and I'm inclined to say this is annoying rather than a bug, so 
I am not entirely sure this will 1) make it in time if we agree on a fix 
(needs to include review process in those 3 working days) 2) be 
acceptable for a late addition in the release cycle. Let's try though, 
maybe we can figure something out.

Enabling DM_WARN actually changes the loglevel of dm_warn calls from 
debug to warning, c.f. 
https://elixir.bootlin.com/u-boot/v2024.07/source/include/dm/util.h#L11

There seems to be no available dm-specific log function other than 
dm_warn at the moment.

The issue I had was that in order to be able to see those messages, I 
had to to select DM_DEBUG, which does much more than just enabling the 
debug log level to be printed and eventually makes my boot unsuccessful 
(see original commit message), which is not acceptable :)

Can you explain what you're trying to achieve with DM_WARN enabled so we 
have some idea how to properly fix address your concern?

In the short term, i guess we could simply define a dm_dbg macros which does
log(LOGC_DM, LOGL_DEBUG, ##fmt)
which would also replace those instances of log(LOGC_DM, LOGL_DEBUG, in 
drivers/core/uclass.c.

However this means that all those messages would only be available if we 
reach the global log level to debug, which is very verbose. I have not 
looked deeply into all those messages and their contexts and wouldn't be 
able to quickly differentiate a debug message from a warn message, so 
replacing only some of them is not a small thing to do and is error prone.

I guess what we could do is have some sort of kconfig option for log 
level per logging category? Or in some way define log filters at compile 
time?

I'm not entirely sure how to go forward with this.

[...]

>> @@ -508,17 +509,17 @@ int of_read_u16(const struct device_node *np, const char *propname, u16 *outp)
>>   {
>>   	const __be16 *val;
>>   
>> -	debug("%s: %s: ", __func__, propname);
>> +	dm_warn("%s: %s: ", __func__, propname);
> 
> This is no warning at all.  And there are tons of those changed by
> this patch.  It ended up in master as 6afdb1585112 ("dm: core: migrate
> debug() messages to use dm_warn") by the way.  Please review again and
> assign reasonable log levels for all converted messages, otherwise
> the destinction between DM_WARN and DM_DEBUG is useless?
> 

They are not exactly related, that's the issue. DM_DEBUG is not about 
the log level, it's about enabling all debug functionalities (of which 
is enabling the debug() calls), which renders the boot unsuccessful on 
my machine (see original commit message).

The second issue is, we could assign different log levels for DM, but 
they would be printed only if the global log level would be raised above 
the level of said DM log message's level. This means to see those I 
would need to see ALL debug messages using the logging framework. I 
think something more finegrained would be much more useful, but that's 
also not a 5min thing to do I guess.

Thank you for testing an RC though and filing a report, not many people 
do (me included) and we end up fixing a lot of stuff in the early days 
of a new release which is not the ideal workflow :)

Cheers,
Quentin
