Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD08C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 07:59:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C118C40660;
	Mon, 24 Aug 2026 07:59:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SdiB40cGysiq; Mon, 24 Aug 2026 07:59:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787558342;
	bh=5NXl0OwhO0aDVc8XPHAP942tE/vmECi34DpEsLOZ79M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tu2Evfj26alGYhwDwIDHgLM81FGYhTq41nzBn4sdw+ttyXFsN13MTLnWoWraKCbXi
	 xxt83aVLX5MCKwLquh3XoesMob+I/YIU/PEGmdtPLNXCce3uDi1ZwElmWZ2GvwbTha
	 yE520bPenaVi7/flf8E4f0HlMNVf+4CqpM0r3877senmpj2m4EFZ3OpVjuNnivOhsY
	 k70hUeLzHcbZhweXhmUgYXKwLA5xct9qXPGC+bRcvxp1P4RoEiHFfEZGv+8Hc6DpnN
	 GdAAOkzvr+VsZYE6l7wTOTpUg9DDm/jV8DFSs/CN/1dZ/dPilYvtt4lEtNOOyI4aAP
	 6sXW9pBenV7mw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C6DBC40652;
	Mon, 24 Aug 2026 07:59:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id F36F3336
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 07:58:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E55AC40649
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 07:58:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yMCGSV_DIf4Q for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 07:58:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=ArfK3MoR
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CB8D140652
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 07:58:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oEVjQlZbbLxu+9yaIKHIoO4YSWcaQNq2pq4oZAMBeAkFnhT26ggs2D2by4SaZyWiB7gBgG45BOkCghP1nbxexO5IRS6c3wiT/hXJTbBmwP4dqhQlOMGHQ1x7SjgwwEK81y9TahuKtGjx/QO5vFE0tVliYtGTxY4YyxzQkB9g0laJ4GY9YeXUkS6mBcIWlkFINidOoUMfje1qSa+xGKq0SbKjJkg80qUrs3UxsQVWb49V2SDzXXpOEp/GXuuqf05h7EL5fZ9rHMUbh8qI5iVzZm51H2WHdbE0szo/wNOAaQWSssVrU2REWRP4d5dopyL7h9aWcazltGEvjUpCcZE0Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NXl0OwhO0aDVc8XPHAP942tE/vmECi34DpEsLOZ79M=;
 b=CotdQYdJ7kdPO1jPm4yia8itVIxkrq4u9KW3xnEBFZGPBgYVIsJtTtY0yDdP8L+ep7kHSny4R2DsOur4jk8aMwWYmB+trkng0yc7soLBFb0mEOthAv+Vs8MvU2Dd3IKKDERyBQehx67lK18utABjzfyQg79VBcEf17Wis8VvNQWa7mvLOFhm9rIjuLda3D7z74Hf2cCLq62O2y+bCQ4qfgCpFnEDXLLgZAbSmr9/fJVlm/9VVtLdH02qrVzRv9rtZdXjLiuHT/9vdwAgIDfWFukJ8AqJlcudEopcDUZkKj7YwYuGFUxluWzZerYGKD9bSv6FIuPTypeuwrNd3w7xVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NXl0OwhO0aDVc8XPHAP942tE/vmECi34DpEsLOZ79M=;
 b=ArfK3MoRS/AfUXunjYNztso7Q7icwc87fDH9CA/DC7PjMiiUbMH83vokNOlccXsKjX8su1kfKXSamnz5n2+EKf2ttlKrNtdHSsRwDXk43Pg7t5PosWW2ZyNc+aNDwV2Wm0qkQ2EAfRtN3AsAw6g+qTuQmZzF/Un8fDuMAkzgB9c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by PAXPR04MB9121.eurprd04.prod.outlook.com (2603:10a6:102:22b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 07:58:52 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 07:58:52 +0000
Message-ID: <db56e278-9e90-4e15-bd09-aaf8f2395b99@cherry.de>
Date: Fri, 21 Aug 2026 20:32:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] lib: zstd: update to latest Linux zstd 1.5.7
To: Cole Munz <Munzzyy1@proton.me>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Alexey Charkov <alchark@flipper.net>
References: <f80b946dbc32e60ffdb8f4a4d259b11156974489.1786750193.git.Munzzyy1@proton.me>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <f80b946dbc32e60ffdb8f4a4d259b11156974489.1786750193.git.Munzzyy1@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI4PEPF0000015B.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::87a) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|PAXPR04MB9121:EE_
X-MS-Office365-Filtering-Correlation-Id: 596d2530-6fff-40d9-71b1-08df01b5897e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|23010399003|376014|10067099003|56012099006|11063799006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: IOjz/e/bBeUXApLoM3IAMsfC9r3Lb074F/HmCt5G3yytvJeO7sJLlx0/ZLbobbdFGfODso+xtIvdWh9ShfFv3/GlWrvCXc957FBOZJ5u+jk+AgLafHo2wcF+B5rCFJsrVRvZuryNczoIRMEkW9KGYyYCSLW2XaXqjKkQnjJ5im0Kh+2skQCfXeiI0UIbY9UrSo/5hCRE1i3cTPk3zkSd9P4J+ehSRzx4CoEEXwmShDErQ0P7g3VqkRKbNQ/B8xsZuLUbBxuboEBtAALeapr2AFuTGJTPQgDOoDYF+QmIma78rsp4nF8sLe+FkdnLhxeTCgm9gbbumHDTtr6mrBgr6157fggt20Ok2lC/P89hMQwQqkZ66BJQl+4aai9+5vIgYMmA6wp1Hy+jBErcg9tXroEiiJVCNn7r1JhCKozsaMLrf2XpoE8xw4/E3Kl/QSk660cmk1SaRIwNLu3NJwux+ORKUB+B2eSLAC4cp/EvxGyyIp2LKHroCBWm0rik90lLynOxVYrhH7TEam5KcZGoBet+0SQuOYwLO78NmrQ0KIyeDsV9b2lMp6EcDZELEd7wx0TSqWS7/wliebGR04izIgctiV6T5nwKpU4bo9mn0lkTQmGmRzOyYTaqACLhYbocKntU/+k/C4oayxSmeJTwUsxv4lwUtws2n+jTaWLbh/s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(23010399003)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzNoMUFzWDQ3NHpoQWZQVnNGcnBQWklGVjFPUnMyU1FJanJvU1hHSW9udzM5?=
 =?utf-8?B?OUlubzQxTGRYaWlqeUx5Tm5JUk1GcjBJVVAwLy9FOHc5SDgwMmUydU1zM3V6?=
 =?utf-8?B?c0d3aFp5dXFvYWVJcWdrT3IwSzNBcW9DYklTblVwc3ljU2VYSFNjbzhqNTA2?=
 =?utf-8?B?WCtuMmFMNXh1NHppU2IrSTNNRlY1S3QwQ2ZkSmRLOEIyT3VyYWwwb2VTdllN?=
 =?utf-8?B?YlFIRlBwK29SQWxoYWFiS2tadkhXU1NOa3NDMURDNm5VSDlNdG5tb2ZIOENj?=
 =?utf-8?B?a3o1VmExMzA4M3ZiaVZ6aHE4NjRncmVnL0NUNlBiank1WUluUGdtLzJYTTFX?=
 =?utf-8?B?bWVKNTNSRmxIU1ZjVk5oZlExcVVkUUQrT21sejVBY3c1SENXWlhsZUo5NERp?=
 =?utf-8?B?QzBEYzdlTm5ITFZ6NUsxS1JVMFZHVXJxajcwTmhLdzY3aUlQNy9udFZyS0hy?=
 =?utf-8?B?b2prcEs2VVRLbVpvT29iVnlBdXdxWHNnRjZVYnpJS0dKQ2diNkZ2Nk04OFlD?=
 =?utf-8?B?MWdjZHpldHZtbTdXMkVELzk2VjN0cjJhNmZrUEozMWgxdE05Lzg4MVZoeGFx?=
 =?utf-8?B?QXozajMrYXZHRWxSNUJrVnh6aXowN1FhUWl6eGNrOTZieGo1VXpZeEdkUnp1?=
 =?utf-8?B?dm9XcklSdFpMM3RNNkEzZUxBbFZibXdocVYvT0Y2V1g4RnppK0NrSmJYRC9h?=
 =?utf-8?B?bFA1K1BBSzJNNVpFTzUvSVBpcFZFWnBKS2xXU3hiYStubFB4OHBqNUViVmpq?=
 =?utf-8?B?dzBFc0J3NzRUbFp3NWxubFpudW5LTEo0ZXFrcmh1Yy9qWmZFL0RyVmVndHFU?=
 =?utf-8?B?ejQvNTFVajlZcWJpMTA4UnFvdFBROFRObURaUndQYzlzcURPTHNJdno5Q29z?=
 =?utf-8?B?U1RkRG9NTDc3bkZPOUhIVHFmNkZkYjE0ampTMC8xL0h0RWJWREdQSEhTd3hp?=
 =?utf-8?B?R1VjMlUvMkRRL3VvWWJFcHVrSUdpQWNSeGFGQ3I5dDFIKzhHbHcvczRaQzBI?=
 =?utf-8?B?UkpEeGIzNEw2ZXZWSml5SkVRSExzNlBSSUZ6Zk8xbkVpL2Y4TG5Palk1bzd4?=
 =?utf-8?B?dWdOZ0x4THNGNVhRQ3pEOE41SG5kOUdlbVlnaks5S3VEVDdQVCswZ1Q1U2ds?=
 =?utf-8?B?Kys2Wkd2VU81RXpHRkV1cjlJQ2I5Q2plSUhJL0VQT2VwWWhWTEtHN1lpdFEw?=
 =?utf-8?B?YzNTSWFtczB5cVoySS9SeGV3N1ZZR0ozV0h1S2hFenF1YTB5a1Y3SCtPd0Fh?=
 =?utf-8?B?S1BCV2taOXFHanI4bEcwNmVKbURiaWFiWDcyd0c5YUdaanByQzNFV052QXpD?=
 =?utf-8?B?SzFLWDh0WHdRa0xoZURCeWdtNUNVUzdWU0hqNm51b00zaFMvclREL0pNTU9n?=
 =?utf-8?B?ejBJZktvbnd6MHBmWk1LamhkRVVHWENzUmJ0d2t3emRhTWpnMTd5c29Kcngx?=
 =?utf-8?B?M3plQ0pISEhTbkt2VGZtUkRTTi93UVZwdnJ0eFBhM2ZtTFNQY2JwMjNDTEVs?=
 =?utf-8?B?bmdDTjNnWWd2b29ZMGY4YmM2VUtBbmRDMytUQkRhVEdiY2dzNXUvY0M2bzBR?=
 =?utf-8?B?WHVGK0xmYmdnRzJyaDZOalIyRGlHOFF6dGJMM1N2bzk0TVhiMVpubWVuOHJR?=
 =?utf-8?B?REltajQ5Zk5aZWx3dk1wRG5ucm02L2c4ZkN6UGFxeUxZbnZJaDBmR05LbzFZ?=
 =?utf-8?B?SWk3RGRQYW9TOFlCY0w3OHhRaUxOQ3lLZnZXRzZ5VVdqMWRIb1phaHNjaWJI?=
 =?utf-8?B?aUd1UXA5bG5mZjVibDY2TUNqcHNVQ3V3MlRwcmIweHhhZSs3SE40SXhrRkN2?=
 =?utf-8?B?dTZJMDBhU041Z0ZleFRVTHVUZVNhVDdUZ092RitiUnJ2V1RxaFdIRlVFdHZI?=
 =?utf-8?B?WWNzdGhFeWdWc0RmK2xzNi9xMEFUNDBobGpXaitjbk8wOXhTUGRPNUV3TExp?=
 =?utf-8?B?NkkwVFR4dEEzYkVCU0NFUDRqTFlzUlVVNit6aGNZcmVseEdlcktQNERyQUI5?=
 =?utf-8?B?QU1BSkFwZkNjdC9mbzBEc2lINFp2bFBTaUlLeS8wMXhRLy9wNzEyVlErTEwv?=
 =?utf-8?B?ZTB0OUtVRU1Kc1ZGdVRVVXN4Wit4TWxMeGJKYVllZjYvQTlCOWZnWTE5K2ZS?=
 =?utf-8?B?S1dONEduNUNwbHN5eE1SMFVYNzNBMS9seUlkb0dkcG1DWXkvUkdKMk5DNzBE?=
 =?utf-8?B?RzZML2RxQ2hkU3JYc1drYThKdnU0K0Jzdi93WHY5UVhIc3ljallQR1MvT2VZ?=
 =?utf-8?B?c0FvQXZ5dXFtU3B2K3BkcmYvaldJTmhNYmliU3JmSVVxaEdldzkrN2ZQeTFq?=
 =?utf-8?B?UUMrRml1aFZmakVDVy9LL0dJcFd6Z2tucHZndGFtM1oxTWFXRks2ZVRLVGdl?=
 =?utf-8?Q?lS4mpPTo7VQjAzPR0e1d1v2lI6f1hl7lLVsIr1jAmWp20?=
X-MS-Exchange-AntiSpam-MessageData-1: 3j7tpzJXRHH7H4YPLawN+zcXJBG25+BOJRM=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 596d2530-6fff-40d9-71b1-08df01b5897e
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 07:58:51.9798 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xqUZohpyHBAE3ZmtNVtVUfbaMMrVaThC5visa7KpwxknEX2NOl23Jl5nyy628jUyV+UHUUgm1BNqmSec6pBhu0vBq5mufSv9IhmdxqHyGXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9121
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Cole,

On 8/15/26 1:30 AM, Cole Munz wrote:
> [You don't often get email from munzzyy1@proton.me. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Update the zstd implementation to match Linux zstd 1.5.7 from commit
> 65d1f5507ed2 ("zstd: Import upstream v1.5.7").
> 
> U-Boot has carried zstd 1.5.2 since commit 4b9b25d943ff ("lib: zstd: update
> to latest Linux zstd 1.5.2"), which mirrored Linux commit 2aa14b1ab2c4.
> Linux has since moved to 1.5.7, which carries decode robustness and
> correctness fixes.
> 
> This is a straight mirror of the Linux zstd code, keeping the same
> adaptations the 1.5.2 import documented:
> - update a few #include that do not translate cleanly
>    - linux/swab.h -> asm/byteorder.h
>    - linux/limits.h -> linux/kernel.h
>    - linux/module.h -> linux/compat.h
> - remove assert() from debug.h so it doesn't conflict with u-boot's
>    assert()
> - strip out the compressor code as was done in the previous u-boot zstd
> - change the #define for MEM_STATIC to use INLINE_KEYWORD for codesize
> 
> Two adaptations are new to this update:
> - linux/unaligned.h -> asm/unaligned.h. Linux renamed asm/unaligned.h to
>    linux/unaligned.h and 1.5.7's mem.h picks up the new path, while
>    U-Boot still provides the asm/ one.
> - collapse duplicate newlines. Commit 2f8c004a5ae5 ("lib: Remove duplicate
>    newlines") stripped those tree-wide after the 1.5.2 import, so mirroring
>    Linux verbatim would re-add 137 of them.
> 
> 1.5.7 adds a faster Huffman decode path, and buildman -B shows it is where
> nearly all the growth lands, mostly in HUF_decompress4X1_usingDTable_internal,
> HUF_readDTableX1_wksp and the new fast_c_loop. Upstream guards that path with
> HUF_DISABLE_FAST_DECODE, so add it to the CONFIG_ZSTD_LIB_MINIFY flags beside
> the HUF_FORCE_DECOMPRESS_X1 and DYNAMIC_BMI2=0 already there. It recovers 1684
> bytes on turris_mox. Giving up decode speed for size is what that option is
> for.
> 
> Tested on sandbox: "ut lib" passes 133 tests with no failures, including
> compression_test_zstd and compression_test_bootm_zstd. Also cross-built
> for aarch64 (turris_mox with CONFIG_ZSTD=y) with no new warnings.
> Size delta with CONFIG_ZSTD_LIB_MINIFY=y is text +1088 bytes on sandbox and
> text +236 bytes on turris_mox, with data and bss unchanged on both. Without
> HUF_DISABLE_FAST_DECODE those are +2888 and +1920.
> 
> Signed-off-by: Cole Munz <Munzzyy1@proton.me>
> ---
> 
> Changes in v2:
> - Add HUF_DISABLE_FAST_DECODE to the CONFIG_ZSTD_LIB_MINIFY flags, per Tom.
>    turris_mox goes from +1920 to +236 bytes against 1.5.2, sandbox from +2888
>    to +1088.
> 
> checkpatch is loud on this one, but that comes from mirroring the Linux
> sources, not from the change itself. Running checkpatch --file over lib/zstd
> gives 5127 errors on the 1.5.2 code already in tree and 5283 on 1.5.7, over
> 28 and 30 files, so the per-line density is flat.
> 
> The import is scripted against a Linux tree at 65d1f5507ed2 rather than done
> by hand. Happy to post the script if it would help the next refresh.
> 

If it fits reasonably well into a commit log, that would even be a nice 
place to store the info for the next person bumping libzstd to look at. 
It would also help us identify shortcomings if any, even after this gets 
merged (if it does :) ).

Cheers,
Quentin
