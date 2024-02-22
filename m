Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27FFFC48BEB
	for <u-boot@archiver.kernel.org>; Thu, 22 Feb 2024 09:57:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0282487C68;
	Thu, 22 Feb 2024 10:57:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="T3CaRyBB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECD4188076; Thu, 22 Feb 2024 10:57:23 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7309387BAF
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 10:57:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RK61R1tt5Xuu6KNEZWLSvQeqEbVAvGsQyeLR5o6GAnFeoRgNYr0kTJPsUqAwMaWglzAjIngjq8qI8/zrH0tHqA1GprrXCLLlbzrrhUeGGVhHhu1HINmTwu29BDT0Nh9lW3KCT9+sU6B3e3K7/u2/f9iWv2hcO/HNOeVUcWZSs8YgzW0wO2shZT5s3/XmpBm0Rvm5UGXYBRH8GQqVAlLJ/xQPy86Mk1vTyuejMZ3SRkyuoeZucRV9/rkShan5viuG3U7evEU2KXyZ1uul3CiWIPNmXtaVa/jVrZb7FCVmUljf6S+zQ9YolLjyBB+fe/Ysc4ZQq4SswN6WzrwaDeHq3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ND96YVKXmj1hGHymtcl/nzTl4AAAQcq53zkWrQVm+AM=;
 b=BlrqpBcjtCXDBSsyKvboV8Ex1f/3MUeGCI37FmZv6LT4j9zLdUZAKRqZRKskUZVWLq/XIQUuJK5xy1vzO7BdOA517EFI1kNvWz/KCqScRLJK0TjUEIhs0cNBOPi1fDuEEvXI2elnFWw4Fuqng4Y4ataDOHBC8sBMnSDZQXasGizZSyMumHdeiHk/Ev4+Rtj1rfctsqEvFGapb3yH/HaE3Ffr9B4mOAh+GZ+OL1nDG+1xwTcgAJeSeYSWHRizOomD2f+PJdQGcNq4XLZQwgj5wbtZk4hHy2VDP1zZF3J4r3i7YKFpx5UeUxOxuhTZylYh5MRU8CXmRKlv2l2m+eXE+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ND96YVKXmj1hGHymtcl/nzTl4AAAQcq53zkWrQVm+AM=;
 b=T3CaRyBBdJWXZIp00Cw0jPFfsxyvTkuMldMxwq3yviwoSaC81wBvVyI3B6Mh2fEHkb8qn6uEdu2dWWZ0eTgvybfYlzmAYgzxK9JDWiDLbqLs/c2BpwUZ3BM/0t3y1pP1nP9NdBtYkLFlh/NZ+T7d96eF06Cj3hOdhIxqjg4vSe99d6ghK4Gg1TyGDnVjiWgWsORJepFMT8ZkVHtd2oHnvIArnS0KCdeNDxcaIn2BBomZgG2boqcCeOHRwBP6n+tahpofr4wrwOlLHY0zOMqSs0dBoZCBs1P9nOUR4vWqb4L7rEsmOtNyVQcWvAZni+oe7q2tKB3JIB17ftEaisYjAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AS8PR04MB7527.eurprd04.prod.outlook.com (2603:10a6:20b:23c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Thu, 22 Feb
 2024 09:57:19 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e%5]) with mapi id 15.20.7316.023; Thu, 22 Feb 2024
 09:57:19 +0000
Message-ID: <da4c2fbb-ad73-4c86-9b80-63020be1bd71@theobroma-systems.com>
Date: Thu, 22 Feb 2024 10:57:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/15] gpio: rockchip: Use gpio alias id as gpio bank id
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: Dragan Simic <dsimic@manjaro.org>, Tianling Shen <cnsztl@gmail.com>,
 u-boot@lists.denx.de
References: <20240217002304.2141064-1-jonas@kwiboo.se>
 <20240217002304.2141064-10-jonas@kwiboo.se>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240217002304.2141064-10-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0345.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::6) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AS8PR04MB7527:EE_
X-MS-Office365-Filtering-Correlation-Id: e12659c5-04c6-4047-95c9-08dc338ca89b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /H7wZJjaGTaATR/08y5yDP1wmmOsHhIkZfGRzUbWz05nKTlDe0rzgaF8dVfpepIdAuBhAmAxwf/jji/7qJp3Q6GO/zO2Al80R9v6mXVCIDrf7N5vx09k5uwi/0r+30GmN92RxRhrLCgoULXoEFviMK9qUSWk+Dos8YVDWLTglkc5EjSvNeXunEY2RniOR1XPTKw55EUZt0ZgNv7CEsI04FZos5k/32H/B+RKkLjff7hBveP9saLjc2KVY/lDfNNlrwjf/1Yy3A9uo0vVCQGz+5djaJw9D4cP2MC5Np8cmCvsl+AvtpnVXxo1Wi662DehrjkHQiYlIxZHUBC3cNAP2kqa4upABf+U4R6Vwva135a99uierJE6A2658PwUo59duZwu8WWRryeZ4hFXsGFZNFR8CEiXzJ8KbWW2C7tUiqNEEuL84HntARBmqSFtiuLmIXgqXBNydq5bqF74kyM3kKqINaIz3j+Ery6Amu1PtxwXItDePirs1+mxq7ZZr0gdvBhsHw/cDqc7+bFtfKWM4l8CRPXdGsRzSTOjnQEdFmw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yzc0SHg5QUpXdmgrU0hLV2NRaGpZRDZRL0JCRFcxOUIySEprcUhFYzh0b3I4?=
 =?utf-8?B?VXRoMHpiY0hBRXhmVXdORFEyTEw0M3FJcXNHYWlMUWJJL1RCTWNuMGlrbFFB?=
 =?utf-8?B?a29yNlM1VEMwOTlkaFZzSnNnWkpobXlVS2lUeG1BdU5LSXVLa3FSRm1FdHht?=
 =?utf-8?B?MkpSdmg3Wk9nK0ZLbEszbE91WWswMDFLYktualgzME1HbVlMdy8yaTVNVXlU?=
 =?utf-8?B?ZVQvZWRJRjBBVkF1YTZLcFJhaU8vZTFWNFFiN0RLaGY1SHJSZU5FWHE1TjdF?=
 =?utf-8?B?ZnBPdUYvVVFnRXJaWHUwSVhURCtGWDZ5VHZhN001dkdQOGtLU3djci9KK2Ir?=
 =?utf-8?B?d0tHbk9OcDk1a2FuVWVOQ2NXMWM2dXFRUkVMZVBndEpyelVVZWQ0bkEwQU1M?=
 =?utf-8?B?aFRoU0NhZGF4ZzFFUnVUYVNZdDY2cFJwSEtTNXlFY1hGWGN1NzEzNUhmQXNI?=
 =?utf-8?B?TE5xRlRKM1ZocDlpMm1jMTIxQVhTUVczM280ZW0vREMrby9EbDIvS0dKb2Fn?=
 =?utf-8?B?MFNsbWhzZ2x4TTVBZjQzT1NNOTlDTlgzZnZyTWVHUTlLNFJub2N1YkVTaWJW?=
 =?utf-8?B?L2QycisyRjV4blRPTkVCalcyb3VROWlFclpHdTBCMjNyUHQvMjRRd1A4aHA5?=
 =?utf-8?B?Rkw2N25XU3d6RDJ4MnFadnFSeXJuVmtLL2NTWnMwTTRtVkk5aGMwRjg2MHBT?=
 =?utf-8?B?Y1BxVVFTdmRRV0EzbmlkYm80aVNTYzNlWW12QzNjS2F4R2liamJVREMySnlQ?=
 =?utf-8?B?TDgzb0tRZ1NWNmlCMTVpVHFtNkFseS9aOXhIZ2FESkRlbzhGaVZ2VThIbWN2?=
 =?utf-8?B?VHg0NEJLU1grQmNEZUxUR1QwdW90U0MxVm1oLzVFRWE1c05mdVk1ZVNHR0ZK?=
 =?utf-8?B?eWtjYlM3bXBKQWx6MnNTdzlWa2xpbVdnalZQQloyRHJFUXVBRUs0RXJoRTVl?=
 =?utf-8?B?V0lFVGVmajB2aCtDREgrUmhvdFg2Z3kzaFpNRmxlS213MlNFeEtNbmtSQmxw?=
 =?utf-8?B?RTVlV1c5S0J5REI2Zm1VZzhnSG1iaHFQUncyK2ZHaU5IaUZWekcrdlM4OS9p?=
 =?utf-8?B?ZnVpTkhUTzlSeUxTZG41NlVoWWw0Nkw3eU5ZaW5KZEUrazBUSHkzRDlZQnlo?=
 =?utf-8?B?bTdmZlNWTG5nUXBhOHNjZFdISVduOTlPdklsV0JFR3FpNnNVVlRFUUk2bU9C?=
 =?utf-8?B?Q2NhRE9BaittZFkxdi9qOGdRZlc1bDBaWTRLTmVCK1ZvVTF4Vi9qaThEZEp3?=
 =?utf-8?B?QW9kc2VsbmJwZUhqRUpnS3V5SjFxQVBUMWkvWG1aNDlqa2tYdTFFRXFqMVN2?=
 =?utf-8?B?WU84c2YyeFlha1A4dHZ1YlJQTFJGdllCVHM0elRLTUxTVXR3MDIrYzVyZTM4?=
 =?utf-8?B?QnRaeGgrRWxWUm9ObjYzOThkZzk3N3RhYVJQVDN6WUUrVi9FOU1UeEFENXQ4?=
 =?utf-8?B?Zy9rTFpVUVFickhSUmc1MDZ2d08vUHpmNDluK1pVdWltQjUwelZxZ0R3MGdz?=
 =?utf-8?B?MVByOXQxak9wV0ZCZjIwd09PYVRMQWttQjRvSGNqNW8wdXFoWTlPaGNkbWxt?=
 =?utf-8?B?QUhWWWhKWnB1cm9pVWUwRm8zb3pyaVJ1OFA3a3RBU08zcHFSVTBJNTBuY2k4?=
 =?utf-8?B?MGxWbU5DQ0NGMjEwL0RETHZTTDB6MUFsQzNyL0ptOVlxbmpxMGczK2p2VUlv?=
 =?utf-8?B?MjFwZXFwLzdVczhPZ1NzZ2wzWU8waHVIaEE2NG9tNkFUQTlOSFJCeUdJTE5T?=
 =?utf-8?B?K1VBa3lnYUNZQ29Ma3owcXMwRUVneGJsbUZvcmN1SGVGUWx0ZnBCcFpkSGdo?=
 =?utf-8?B?dFBQTnAwWmJRU1M5QVA0eWRhdVlncytDbU56WmxudmZiTmZhdmlUTzYvb1dw?=
 =?utf-8?B?YVpON3hVT1VrbmJkeE9iemFTTmNCZXIvb0ZuR2VXUW1UMDFJSEtnUjNWVk5Q?=
 =?utf-8?B?SFlqU0pCWXBUL2YzY3BQdEhCN2Q2ckJTQ1U4bGh5VnZVRmFqMndRN0t6T3BX?=
 =?utf-8?B?ZUVhVXBwQzJ3Vk9OT29EbjdwTElIWjc1QVNXSFpBV3M4Ky9USFNHeGc2QkZX?=
 =?utf-8?B?SGtIMkJ4QjAxdDNNSlpGSm5ZSGZNb2tSTkMrNjMxZGVKV05SbmErRmd1ZFFp?=
 =?utf-8?B?YTBsWUE1dUdCZUc0aFI5eDlJczhic2dYc213amFJaFJmZFYwMFZhc1BtcEMz?=
 =?utf-8?B?OUU5eGZBSnY5VDFqV0NFMmhySWQyVE8yYlEvdU4vbDdYaFo3QjBVN01XdG95?=
 =?utf-8?B?cHZnc2t4cnpVY2FrQmFqZWYxazJRPT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e12659c5-04c6-4047-95c9-08dc338ca89b
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 09:57:19.7915 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vwhMxK57MKFl66hjcJI4DaXtI0Vc0RQ/CaEwUVHn3fwe3xZgI3zLD//lHcoo9UOz+fncrRH/ZZ4D0cE4FbPG+4otQlzRCUSipSBxlOi4Um3a90XLRy6j7+F6CpjMwELw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7527
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

Hi Jonas,

On 2/17/24 01:22, Jonas Karlman wrote:
> The U-Boot driver try to base the gpio bank id on the gpio-ranges prop
> and fall back to base the bank id on the node name. However, the linux
> driver try to base the bank id on the gpio alias id and fall back on
> node order.
> 
> This can cause issues when SoC DT is synced from linux and gpioX@ nodes
> has been renamed to gpio@ and gpio-ranges or a SoC specific alias has
> not been assigned.
> 
> Try to use the gpio alias id as first fallback when a gpio-ranges prop
> is missing to ease sync of updated SoC DT. Keep the current fallback on
> node name as a third fallback to not affect any existing unsynced DT.
> 

The gpio alias is not necessarily the same as the gpio bank in the SoC. 
But I guess if it's good enough for the Linux kernel AND the fact that 
we take our device trees from the Linux kernel, it'd be near impossible 
to have a non-working setup for upstream-supported devices. But 
considering all Rockchip SoCs in the Linux kernel have the gpio aliases 
set in the SoC.dtsi and that no board seems to be overriding them, it is 
safe to do.

There's also a possible issue with two gpio controllers using the same 
bank, e.g. if there's one using the first of the three methods, another 
the second one and another one the third one. But again considering all 
Rockchip SoCs in the Linux kernel have the gpio aliases set in the 
SoC.dtsi, this should be covered as well during the next DT sync from Linux.

Therefore,

Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Thanks,
Quentin
