Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA18CCD6E79
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 01:44:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A31B839A8;
	Tue,  9 Jun 2026 03:44:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fNrEXmFz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E16C1841C2; Tue,  9 Jun 2026 03:44:32 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E54618341A
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 03:44:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hP0ZZHT0eG7Z+HSNhEFKUD9CP9FSpP/1bN8qF8UWkRBiHKNt8qUia5m52fe24RUp2jKcK28c2S+/D2wDf4FwDZbkrTtTObYIV97eFu+BQg1xR5T7zUps0a4d/j7vkZgs6G8GTSY9IjYv5Wa3fhjs/x/2JoZXVitald4qX5/HOrnNzHHp1VebCGsyPQJxmjIsp8AagrhoAmj0fBfw0mU9bkwHDVRlyGJtyquV1okNb8ZQMSQGQSIvnBg7OH3f+AQ6C4rkc/B9pjs0GEvMeSR33UTL3R7VIaKIAlX+j1DqVvaDLF1gsUxL6QefcB7IcEDzP96vxo6sXDO8vhF0k6WGrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TmLVbBfEavV/VpEjtLh6p4u21fwoBqE3qewtn4lXcZ8=;
 b=YTHjDmzy8/hDambn6yg9LqJKZLA1Udi1yOzIIUuTR8wIbfO6MJKCiuVolteH78m541pZzDxcU1H+M5PMnEe0xaiI5jpQy1BJzcvn0U4GEGr3jBSPrmUkujtofwLyO/s6/iDo2WFYvNUbb40Q/zu9tU02PtIElUBoaee2uF+DJqJGWA+478jgnsXDQ82e6lIUlJWFyVBnp8VwEaOVwLOBuAIXoX1He8v5S5ZKBuQAuZ3Wd0fWk6SiP38kY28LA/OJAEP3uTRmURogq1qLV78RRN94SC14bsxYIOx2xOEGlxYDerMNF3N7v7M0Q2auJEmaWdxWjuZPx6Mk1D8etJGE+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmLVbBfEavV/VpEjtLh6p4u21fwoBqE3qewtn4lXcZ8=;
 b=fNrEXmFzKS7UtkBsd6z2OCQ2IltL6ddJZOPVNpqaGkw0bjKWh1QyU7R6aY4pIvk07CQMtcyU5jB/f+rBFWRSNwrA9zC8Kbh8zrVNHg0XYs5lZK+vVwj88lgVZdVqomNFnIEvrWZPZFePxzDNX8JLBjPanrk1QuD/UfZToLDy70emo1sCckIYboQtOSwtNVM2g4tXvUq3dISutF7Dly8SHGAEAXINTgxNSuYRJjCOMyCtiwE4UHG20phmSD5350gxKEK7L/oZ1E7UH9Q3o+2XD3aoMAnwlOkzWC/FQPSJEQMX/YF3vxet7/MRHG0HIYad+22XDV/+7tjFLqMivH504g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI0PR04MB11766.eurprd04.prod.outlook.com
 (2603:10a6:800:2e8::21) by VI2PR04MB10738.eurprd04.prod.outlook.com
 (2603:10a6:800:277::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 01:44:27 +0000
Received: from VI0PR04MB11766.eurprd04.prod.outlook.com
 ([fe80::bae1:c77d:b6db:16bd]) by VI0PR04MB11766.eurprd04.prod.outlook.com
 ([fe80::bae1:c77d:b6db:16bd%6]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 01:44:27 +0000
Message-ID: <9bcf6592-e616-4b7f-9d54-83987c6a2bbb@oss.nxp.com>
Date: Tue, 9 Jun 2026 09:44:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: TZASC misconfiguration on i.mx8m
To: Richard Weinberger <richard@sigma-star.at>, sahil.malhotra@nxp.com
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, alice.guo@nxp.com,
 peng.fan@nxp.com, upstream+uboot@sigma-star.at, ye.li@nxp.com
References: <3208216.Ym5mLc6kNg@nailgun> <5857153.7ts2hSHzFV@nailgun>
 <a22e9862-8718-48eb-9eb2-ecb51209f672@oss.nxp.com>
 <CAKxiovgS_1x4rVYN+bdXGGSBLQ87Q-ho88wSLn=eVEMQO9BG6Q@mail.gmail.com>
Content-Language: en-US
From: Ye Li <ye.li@oss.nxp.com>
In-Reply-To: <CAKxiovgS_1x4rVYN+bdXGGSBLQ87Q-ho88wSLn=eVEMQO9BG6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SL2P216CA0143.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1::22) To VI0PR04MB11766.eurprd04.prod.outlook.com
 (2603:10a6:800:2e8::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11766:EE_|VI2PR04MB10738:EE_
X-MS-Office365-Filtering-Correlation-Id: 2755a504-bfdc-448b-05b8-08dec5c8a400
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|42112799006|376014|1800799024|11063799006|56012099006|3023799007|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: rhEADXyhlVCocr+YEA1HVNXmqGZytA1uhhG55eK0bJwOGiGCf6GgKcrDSX215vWOjTEQcTZNDE3NYi7EJmicXKylF6wXtVxJaX6YU/dTX18YOuN8AbZk7LW0DMu5JLe2clLBSmzM9nxemAlbCfrOUL0FyzZ7h1vAdevRaGRqjATIIoAx+dmOtyltCRe7c/Nnm+WgxngN0Ys3YYlD4AzmgyiAPA3Umz7bMFcEadV4gXqaCHQuAGq7fNr6NHQS3mMQOc4SVs9LmVhUHymrWm5p375tEi273ol3FO0xPYAnaz9xp/2SaijOC0dywjlYO+7+RzLuZrRC/Sh8sAUjWBcGCLl7gz2kywR0EtH+/2vEjidSTmvNs4oIvWVe5Z7ak3IJcnlG8VrtvLcLHG/bkWIYoFGBY49K9BcvXBvz1vnnM/0L7j9D2cDdrygmtwZgXe0CWLQWAM7lWuWQOQ5OXqTYm066f2Nie8GeMWJSJ9OeS4iQm/CqSGMT/JZKYGLGq6BHBxXukFXD5KoJVjlzUDOastCTuQEmjaGWykids8bRyIg95Oluy5LuaxFeAyCma7j6ECD2Z4RgyWOJopY3ysLzphuANR5JuEnybDtIKhRNECbZfUJIm8mOaCoqo5fXl6QD2kBzzFy5RO9ea5oQEQ1Kn57qyVjCuY8S9EGE6F9cSS2BBekb554894u+5h9ryHJ8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR04MB11766.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(42112799006)(376014)(1800799024)(11063799006)(56012099006)(3023799007)(4143699003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWRhbDQ4UnhHRnkzbDFHSzQ0dWcyZGRUS0hLcjRvamp0b1hwSzlkTWl6WEZB?=
 =?utf-8?B?bDMxMyt1d0puQXNaUyswQlA4eUFjS2lxOGhzb0hneGRPZEl5eVhMQVYwdXJL?=
 =?utf-8?B?NnIydTlLQ2p5c0N4VjdveTNBRUwweXQyNmt1V0VyU2JoOXpOeVVHWHhOcTZs?=
 =?utf-8?B?Z3MvSlk4bXRvQ1lNQ0NTb1VHYWY0WkxGK1FSZUcyNlp2dkorK0huVDVDT1hB?=
 =?utf-8?B?ZEJRNkxRYnQxaUQvM1lES0lpSVBkTE1pcmFSNUZlWm1uVVd0VDF0OE85eTdN?=
 =?utf-8?B?Sk5ocWErT0NRV1VqeENaNlFESTdKSzZwOVpqOXg2VFd0SnRNNjlpalJneUVu?=
 =?utf-8?B?bWYzTVpzQnlBdU0xdlNxSmx1cnNaL0RXQjl3UnlPVHBkc3paODd2em9BZ3By?=
 =?utf-8?B?emFwZng1UDZwNVN3K0ZBSlI1VDBscWN6TTBiVVlzT1hHQS9lMXVuVjFlc3Bm?=
 =?utf-8?B?aTJyRFpITGJOd0o0NkYrUmtBWUlBeWorRFlHVnBsY2lyVFJiNU1XTGZ4NlZH?=
 =?utf-8?B?MFE0b2U1REh1SVpDTUVFbjFmR1ZOZkYzQkJ3dTRMOHAzb1lUc3RHbFRyZ0ds?=
 =?utf-8?B?bXlFUTAxZzMydlNQNWhJaitHWXlYbzE0ZGhEQkwrNXRIdTR0QkxRaWtlam43?=
 =?utf-8?B?cDRNV1paM2U4SlFzV2cwTys1SlVvWHJhTGhUSWtORS9vZGVoSjc0bHZHNU1N?=
 =?utf-8?B?RU5WZy9uTTk0d3ZIdW1NcGxza21Pbm5OVXJZUnk2Q1kvT1YvbTJucHV1NWZG?=
 =?utf-8?B?SEFtamcxbnlwZkl0YWtwelJXV3hadTU5YVZlWEt5ZUhyMGQzMHlqaWdVd01q?=
 =?utf-8?B?TkswRnVhWDlTcEt4T3VORmc4cWtYeklSNG8wSzl1ZTVoNjV3YXdRb3gwNTJT?=
 =?utf-8?B?WTYzMDVNejlMMjZkbzU1RE1tSUcxbkVVRllRbzlyd2drWjc4TityVSt4Y2RV?=
 =?utf-8?B?S3VndVRLWXJSZXZWSE9UdmpiMUJ0LzRDamUySlVidlVJTzJYVXpBRUFidnov?=
 =?utf-8?B?VGczamh1NkdHYWdrT0JSOWtUYmJyNUROaXA3OVJtOVU2VU4vdnd0Y0IzYWtq?=
 =?utf-8?B?NDJVR0N0SGxkV0JidDVMYnlTcUNad1AvTVJsVW91N3krUkRtbUZyeVNUelpp?=
 =?utf-8?B?YXhacWQwc3UwdWEzZEtxTW4zZmdJa0NOWWM1bHpoWE1XU0tTQno2eC9aZzlL?=
 =?utf-8?B?cWY5NXZDWHgvYjE4MHVUMXdPQlgzeFVoS29BbXdWQStmSXNObHlOR2ZuQ2JD?=
 =?utf-8?B?dUJEOHo3Wkc3cnpJYWd0S0ZOTU1ZUnI5cXJVN0ZqUTltWTN0cmVlR01DeWkv?=
 =?utf-8?B?TjZUd29xanBSd0ViekJkd01MOGduMnBKVmpyZUh6Yzg2Rm9jN25rVk9xS1hk?=
 =?utf-8?B?eDZMUXpxQXRzZ29tYlNrNUFnUEk1T0ZnOGpMeWFpN1I1MmE2SWNVOFpuQmhu?=
 =?utf-8?B?NlUzbm8rbDJBNGJyQXBzYWM4K2oyNk5DYklrYXRsL2VBR29qdG8rTmcwZUI2?=
 =?utf-8?B?M1grWEdRaUtrZ0VNUitGZTBwbmFRaDBQQjNYUEVpTFJrU3hja0ZOdSs0ZHBX?=
 =?utf-8?B?OEpBVXRzOTBvTkhHdEVMNWhKamZ2RDBhVTRwYVZtL3dZbHQrY0FySFJUdENS?=
 =?utf-8?B?R2U1amd4WmJIZmxENTlJNEdOOHk2ZmJOTmxyVWQ2a2l2d0dicStzbEVXV1N5?=
 =?utf-8?B?YU41SWNhcEdaUXU5c0pnYXNWZVNySTlVNDZ0cGZZenJwMkFGNFVENUhDM0ts?=
 =?utf-8?B?L3Z2YTd2aWZxZ1N3QzBWTkhqekgwbVdYUi9jNS8vZm9QRXpFaHh5RVBTaVFK?=
 =?utf-8?B?UCtBa3BYOWdIS1RQSkFlWVhKZzNMdnNUMVk2OE5YV1ZNMW1RSExEalhUeitz?=
 =?utf-8?B?b3dIYmJ1SVFNQmNaajVVbkNsMnVMb1NlUG5WREE4d05LcXlXYTlMUGp1aEZ4?=
 =?utf-8?B?VW1uRlJlMk5lV29kMVBrM0Q4OGhVSWFFLzZ4aUFKc0pVN21qV2YvZUNRaUFu?=
 =?utf-8?B?TUhXbXpVVmVNcmc2VnNJb3lWb2hDZCtLd2twU3ZPZUVlektSOFNLRHU3NXU5?=
 =?utf-8?B?eGF5S3pld3JzeDRyN0gxMkF3UkJBNXFFYzlyTDhtRTRTbGdYbmtsLzJDc0NX?=
 =?utf-8?B?ZjNrUEFWOUU2TXBnaC9iSGx3WHcyaUZ4bFp6V2pEWFNsa3BlSDlEdUJVSnNY?=
 =?utf-8?B?eEh5NWgyU21IRnI0czBrbENZTDB2cTNVSndOeklRTjZRTWR0aEo5UUd6TzFu?=
 =?utf-8?B?N2o5RndzMnZnTTgvUk1HRE1aUHhsczBkS1VzWUR0OStIODM2bFV0RW90NEN0?=
 =?utf-8?Q?NzH4OAuNEhdOaJ5a3X?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2755a504-bfdc-448b-05b8-08dec5c8a400
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11766.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 01:44:27.2824 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j3mV6C1bX/Q4broCTmxskFBVer92GK46W+Vo8PcKOVNT9lmg8KLwTrOqFxdkk4S3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10738
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



On 6/8/2026 11:07 AM, Richard Weinberger wrote:
> Ye Li <ye.li@oss.nxp.com <mailto:ye.li@oss.nxp.com>> schrieb am Mo., 8. 
> Juni 2026, 03:43:
> 
>     Hi Richard,
> 
>     On 6/5/2026 10:52 PM, Richard Weinberger wrote:
>      > CC'ing Ye Li.
>      >
>      > On Donnerstag, 4. Juni 2026 19:24 Richard Weinberger wrote:
>      >> Hello!
>      >>
>      >> FYI, in arch/arm/mach-imx/imx8m/soc.c enable_tzc380() U-Boot
>     configures
>      >> region0 to allow secure and non-secure world access.
>      >> This is known to be problematic and allows circumventing the
>     TrustZone due to
>      >> memory aliasing[0][1].
>      >>
>      >> It causes also recent OP-TEE to panic at startup:
>      >> E/TC:0 0 Panic 'region0 is not secure configured, non-secure
>     memory alias access possible!' at core/arch/arm/plat-imx/
>     tzc380.c:217 <imx_configure_tzasc>
>      >>
>      >> This is not a theoretical issue.
>      >> On my i.mx8mm evk Board I was able to exploit this and dump all
>     OP-TEE memory from Linux.
>      >
>      > I suggest reverting commit b3cf0a8f03d162e030cde1131751d060853e16fc
>      > Author: Ye Li <ye.li@nxp.com <mailto:ye.li@nxp.com>>
>      > Date:   Tue Aug 27 06:25:34 2019 +0000
>      >
>      >      imx8m: Configure trustzone region 0 for non-secure access
>      >
>      >      Set trustzone region 0 to allow both non-secure and secure
>     access
>      >      when trust zone is enabled. We found USB controller fails to
>     access
>      >      DDR if the default region 0 is secure access only.
>      >
>      >      Signed-off-by: Ye Li <ye.li@nxp.com <mailto:ye.li@nxp.com>>
>      >      Signed-off-by: Peng Fan <peng.fan@nxp.com
>     <mailto:peng.fan@nxp.com>>
>      >
>      > Thanks,
>      > //richard
>     We have discussed this with iMX optee owner. The fix should be done in
>     OPTEE not u-boot.
>     1. OPTEE uses secure memory, so it needs to re-confiure trustzone to
>     meet secure requirement not depending on SPL setting.
>     2. SPL also supports Non-optee case.
> 
>     Best regards,
>     Ye Li
> 
> 
> Can you please point to this discussion?

It is our internal discussion not on community thread. I add Sahil to 
comment for optee. And please notice, trustzone should be enabled before 
DDR initialization. So it should be in SPL not optee. Optee can 
reconfigure trustzone setting.

Best regards,
Ye Li
> 
> Thanks,
> //richard
> 

