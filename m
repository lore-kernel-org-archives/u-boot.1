Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F5CCD98C7
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 08:47:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 871E880087;
	Wed, 10 Jun 2026 10:47:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="hZMpBr3G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A349838BB; Wed, 10 Jun 2026 10:47:37 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E331A80086
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 10:47:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kAk//pdcmiWPvbIwPhxkPmAhy3v5T7p5Xsg/xOdk2a5e+yOlZYqbuIYSPV0UrKkcH+ok7VKATULBovnrX6aLkp528gutNC0Xd08R0q/Zc9B09AQtE+TvF3KH2vW/2CNjHjrZlYe2TQ3yAMRSqEHVtr8JQw8YqwO/Z90od1V4ZHTk4AAtoc6NLyVKD2csR3X+dakQAt+1vadx5YgibYf1YD5OMF2CglRTGovKm0/uE1gIhhAd4UCUHa/oHyzwlSkQ0JRZZoQgcHUl+GgvC7ktVKChX2xJM5G94bcqjpGRINDaSUuZjtssxpUwspMHPimEy2rFL5BFkWWMgOjCZlGjug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2nLx67yN+1mp+IDKtWCbmR8UWDvEUvKKHYwwkQeHf0=;
 b=xbH64S3k0PP6Rlzy1+bajm62Iq55XpFN2z3GOpReddqBYoRMzFPRvCBsJegjEloq+YdmgkjqcXnDFGrd0AptbVYzlohca0tAWw49MyhcdHlTrFMVGwqqX7qIq580jTAroRBdFP+pC+zJrVZI/T0Pabz3Acutpng+7cuaq73INssBI6JksedLOSkct5GIXyca0wbzZtBwS37425qIObI1iUTcvzsA9IhysehLF8HIT0fhtbB7RDuI/8I97ZSX/QP2DX8lTbJ9hcDIF+lvPW0amnMy5WxomFYuO3Pqz0dt3gnaJtrovjncK86BPj2WWtMClOm6xnWqJVTiYKMaWaSniw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2nLx67yN+1mp+IDKtWCbmR8UWDvEUvKKHYwwkQeHf0=;
 b=hZMpBr3G5sJxoDREwtubMAl+tRvkcz5/1hKAeST4kth9VveGiOoY85i51t4UFUz9ZOMiyH662Xo8fAvhg9EyqjsIPQVdv2ZfNUVdInFHToDYrjx/1L+2gAX8En5RcQzR+Ws3OvdL2ru5SiRm4yHrRosSlbYiGkJ1n/Q2iHfaFhY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by PAXPR04MB8879.eurprd04.prod.outlook.com (2603:10a6:102:20e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.18; Wed, 10 Jun
 2026 08:47:31 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0071.010; Wed, 10 Jun 2026
 08:47:31 +0000
Message-ID: <364e247b-7cff-4711-9d1a-2a1c9b6544f9@cherry.de>
Date: Wed, 10 Jun 2026 10:47:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] xyz-modem: Select CRC16
To: Daniel Palmer <daniel@thingy.jp>
Cc: Tom Rini <trini@konsulko.com>, sjg@chromium.org, u-boot@lists.denx.de
References: <20260608130606.121031-1-daniel@thingy.jp>
 <9b0b5a7c-3a6d-4a54-ad67-10433cbd3435@cherry.de>
 <20260608140454.GH382693@bill-the-cat>
 <0642ec3a-eeac-4d99-bf2c-23822a8d2df5@cherry.de>
 <CAFr9PXn2j1B6WxRdPFabHJg7Ym5KJYgDQTJ16A0uN7Tz-Ot+Vw@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFr9PXn2j1B6WxRdPFabHJg7Ym5KJYgDQTJ16A0uN7Tz-Ot+Vw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0049.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::7) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|PAXPR04MB8879:EE_
X-MS-Office365-Filtering-Correlation-Id: 68a05ee0-ca66-4c28-6951-08dec6cce874
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|4143699003|11063799006|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 3GjFrybkxeVPtg4w6Lj0oD+V0yO3vJf8oLW7rYTOGK5LLcrKPr+lkmUyxuqqn45tx1qwlBx8XIZsOPj8/0qxc14ku5juVmmhrWc1G+hb81ID1sl59bzGJruPtoMYetfA+xq7SS55zDb8wfmAIDZXNtVEYaTBsONo2mqf3QTXBboR4LMJyY8p0puKmVbxN9PL+9bmqgfFBUus+2x+/pV7450iavBT5/+PLttIF+eD2AfYbB2mueXnRMlqqA3yHsbFOwWUNlROMNs4MoLcr8uvNvifiYB9V6xUkm5fs/Fhg+lqq+u2hZiq2+df4iah5VejClLX74mUcjHAk+rZ0/Lwk0Bdu0MuRTU28mFdEdELvsppuhCyI25TTVazbvXl5MWHiIDRt9HjZJ89ZUFOR+by9nB2quqjQYlKSfqz2+chJPRh5kQQgLYDDJmNSJdEtRoLng6QLaVfP1NuF5kZGWBYb3S3noBqPW6106i5mygi1GzLaslrxkgk0ZorToEGRR/6zI8CEeTlcnXyRT7DHhZJSHtu1TuwY3R44/S3vWa63q6HMReRWK9XjgjD+kkAtydpY6z9NH3sUNcV5cNkJUYbMTfZv1a5MJECiRmwalrhIui5DwWgpSmx0lMmUYBY/ZjGgELljbuVE0GMx7RNAN5qXdEnXQawzbgZEGJzEfMNOM0hhm5dlgYLW+msXR3HO+YC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(4143699003)(11063799006)(22082099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEl3a090c1hJVGNFbnNFN1MzY2NxbjZhdTM0QXlJa2IrQkJNSE5hMXNjeVRC?=
 =?utf-8?B?SWIweDVRcHE1ZVg4NHdhRmNYQkU1a0c2NVJ4akJwcmpRcTNsdFA3aUs1cTAz?=
 =?utf-8?B?dzZ4MG83eEZkdmsyekRsb0psZFNXcmdlcVcvMDNoNkVXZXYwQ1M5Y2ZDYmx0?=
 =?utf-8?B?TWIzMit5NC9RcUgrMWRYQmNmbkE4eXd6SFJFK0ZKTEVKYWZicWNhNDliUVZm?=
 =?utf-8?B?SGR3elhYUTI5MlAreHdha1hnNE13d3FhVHNXTEVOWlpUQnpZZVhabU9kd2Ft?=
 =?utf-8?B?L0NLMHpvQ1dFbmptZFkydzZuZUY5UmI0ck12Wk5kYnJhQW4zM2RTazVjQncz?=
 =?utf-8?B?YlJScFo5TkxydENOWnR1N3VQMnZLNU8xYzdzVFgxM04yU0o0UkpNNWpXRkM5?=
 =?utf-8?B?MEdkN25TWXJac2xPVkk5QzVDSTRqYmwrYzNVOTN5akdQaThCK01weFhZeXhF?=
 =?utf-8?B?TVlFNXlEV1lLUHlDeERBTHhQRVBDeXM3bFlXeUNFR3ExZnF4MVppOHJxOExY?=
 =?utf-8?B?eWJidlJzMTNBVTNiWXlMRGJKSHdxSUQ1bk1hMnQ2MitoanJvMXlnZmRsNVNE?=
 =?utf-8?B?eTA1RU5qUkJ6NGd4aWRoeDRHeUNCVmozenFlMjEzaElheTQrZGQ0M0M0a29Z?=
 =?utf-8?B?ZnR5N09zRUpDWXU1ODdPTk9mM3RSQ05GTEhkV3M5VHVjbnlMVjFJNmZNSzN5?=
 =?utf-8?B?ZDdDeWMxZE1IU2NoMDRKOWRpaWNYOTh6WFBhYXhJM1pTTHRNKzVVd0ViN2Q3?=
 =?utf-8?B?ZFlMOWlmMVNiZWJSYzdnUEVJQkNScVdadHFlRVpGdzhhNFFFVmRncStCcTVj?=
 =?utf-8?B?b2tLbnQrYXhESDQ1Q0J4KzIvY2xmVHpxZ2NSNUlqWFNORGZYRVF4WkVHalF2?=
 =?utf-8?B?R0tNUHBlMkprbmFoN0JlK3dHOWZYeFdJSlBHc0lYdGsrOWt0enpiN0NRZCsy?=
 =?utf-8?B?K0ZrUWlEaVB1c1Q2ZERRcUhUVEJRRXZFUEJBMWhrQmlNTE01VGhNUFBVd0Ur?=
 =?utf-8?B?RS8vOTR1VGZFT0dGQnIvSGlBWVpxY0E1WDZxdzNIYjFuNU5CcDY3Q1pzQXRP?=
 =?utf-8?B?d2MrQml1M3F0STlSRHlEcVpQRUpuMUY2YnJRYzk4VmwyREZHL01JRkhpY1d1?=
 =?utf-8?B?WHI0U2ZSTEJGaGtkOWtTM0RmWGg0cHZ0VHZlcUlrQkZyNmRvWEJmNGZ1Y29h?=
 =?utf-8?B?SWtTTGdmaGYvSWMrR1F6NjFLOHB3bmJrenlHUEFjTUx6UXhMcHluTkExNTRZ?=
 =?utf-8?B?Vk9ZaXZxS2UvVExCaEh2a0VVZnlCdGI0VDVQRFZQSFFoUHhaYzc5ZGNkL1Ux?=
 =?utf-8?B?SjlKK09WRHF2TDA5SU82aXdvOGk3SnU5SkJIcGQ2bUdxVmtFM25DSU9nZisx?=
 =?utf-8?B?THp1NXNabDVpZ1UzT29SVy8yTjMyNmxGYjBPeEo1ZnU0Vlltb1c1TzIwQ1gz?=
 =?utf-8?B?SVVDRFlmNGQyZnFGcGJZYVRpbmppNTJCS2ZncEZGK0J4RlpZUU5FUStxZG15?=
 =?utf-8?B?YVk4aXdwM2dKYzFiTnZuZC9sekZQbWFiVEJFSTVBbmlTWG14QU90YjdNZHBL?=
 =?utf-8?B?NHlBWlIzbHc1OXRzd0twZkZIVHg2Q2ErMHlpWkxpenJlc2dxSjJ2Y1lhQVp2?=
 =?utf-8?B?ODFCbFdXUEpwakFnNDNpRG50RXBUN3p0amxoTm55MzFsRDFOdjBGYWMvb1Fq?=
 =?utf-8?B?MTdEc3lhNjhEVEZ2TXdQbjFyMDJqVm9yWUtMQms1dlNpSkZQcjJFMFRoMG5o?=
 =?utf-8?B?UXBFeG5qNVgwR1o1STdlbGk5QXUrQkhJR3RZNlY5VHhaeTZ0ckpLVm93cXlY?=
 =?utf-8?B?SUFqNkM5d1k1SnlUVHN0alYxbEMwL2JORXE3ZjVGSXd3emU3ZGw0dSsxdVMx?=
 =?utf-8?B?TVhqMCs2Vit4SDRWeW55NEhYMDFsWGowQkZmS3NTZmxtWWVlUmNrRFA0OGRk?=
 =?utf-8?B?dXRSdE01ME51RGR6N1dPNjQ5SEU3NGVLVzFqeHVVQ0lKZVJ6a2ZXVlFGZGpa?=
 =?utf-8?B?MHJyZkhCWjFyN2RBa1dCQWNDOStaOGUyYllBK2lDM2phMHNnTVQ3TzdhbTN3?=
 =?utf-8?B?TmE5cm5ZcFJaWjVUVFhyMHBvRDJOdk50RVJ3VmJaazJySWYvbVJvb0FZMzlq?=
 =?utf-8?B?VHFsTjg1VmlMai9sS2RpdHNaVW5RWWltVmhZdUFZSmJYbElwdExMMllZQjdo?=
 =?utf-8?B?V29VZ1ZIMFhnWGdVOEJ5bVNOc1Nmb3NvcHQ0aVhWUUVWWnYwR0JUV1EvY3h4?=
 =?utf-8?B?KzJTZjgzdWwzeHlmeURuZWczWmZXQno1NmlJZnQ5VWZjTFV1aEJ6eUpjdEov?=
 =?utf-8?B?NjBBNGt1bVZraFdhYnAwbVFaRWJ1M0ZFQ05jNkJxUURNSUg1SUdjZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a05ee0-ca66-4c28-6951-08dec6cce874
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 08:47:30.9945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IhCkXx7KXhEgSJuraNt63VSNpf2mcG2iC2lRsg0IeUX40aig4CkFst6H7JazH2uElnMACG/xVwHFHc6uELKzj3Q0vXzMP86t4uh6nxe8sYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8879
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

hi Daniel,

On 6/10/26 10:39 AM, Daniel Palmer wrote:
> Hi Quentin, Tom
> 
> On Mon, 8 Jun 2026 at 23:22, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>> Also, lib/Makefile has
>>
>> obj-$(CONFIG_SPL_YMODEM_SUPPORT) += crc16-ccitt.o
>>
>> which is.... odd? Shouldn't this handle the case of "missing" SPL_CRC16
>> dependency?
> 
> I didn't see this. So it seems like for now just adding
> CONFIG_YMODEM_SUPPORT, making that select CONFIG_CRC16 and the
> Makefile tweak would be enough for now.
> 
> Would that be acceptable for now? It seems like the xyzmodem thing
> needs a bit of refactoring etc. I actually have an almost entirely
> rewritten version of it somewhere that I wrote because of the issues
> in the current version. I'd prefer to fix the build issue for now and
> refactor + replace most of the code when I have time to do it
> properly.
> 

I'm fine fixing what needs to be fixed now and improvements later on.

Note that we generally do not like complete rewrites in one patch but 
rather small incremental changes (which may end up in the same result, 
but is "more reviewable"). We don't have a maintainer for that feature, 
though Tom is the "catch-all" maintainer, so maybe you can convince him 
a full rewrite is ok. In any case, I'm sure we would really appreciate 
tests (I don't think we have any from the cursory check I just made) so 
make sure to include some (especially for the issues you encountered so 
we don't regress!).

Cheers,
Quentin
