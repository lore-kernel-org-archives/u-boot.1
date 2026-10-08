Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 492BFCA6016
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 21:31:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EBA704092B;
	Thu,  8 Oct 2026 21:31:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7-SxJHnJm3NA; Thu,  8 Oct 2026 21:31:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 15F3E40921
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791495112;
	b=EnC02lGPTiXwjKMobYQAB6BumIg999dKKq/ovt4my4w1i50YNcnY6OITHZV6KNMbhb5X
	 mrppaJ0a1/JS7L0R+fpnHg5+OC5rr9OIm8iogVxr5TwOUusJHYPap0S1S/MvpEUeYHago
	 aQHMy95EwUVTrazJ0xsx++AHrB7FynOgN8UWtoBQDN5nV+/NDwsNf5Zxg3duf8ELCF5X3
	 GYTwQAZeUgcmPKZdls2xA6u1tdAtBVy7bKJ7LtNOjQmP6wjPS6hjjklVLbC7ro33s17D6
	 aaQ+ey2KcofZ33Ka0OixyshxxViGu5391cgspQx/MiyJlUtBoIl/PJVxvTKKknjfcbg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791495112;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=V+qzjPgese7zIK84jcwsZm3begIZTqX2DHkyv2Ryk90=;
	b=GTdwOThzCdqOmg5gazXq4CxKY0Xmj/Lqs1TQCQyw5BRHPjxVlelB26WMBjz+a9Bt9LC0
	 oH1FzRKESEe5bSihdb/cnaq8D9UPeV6BK7SvuMoHN6baVtLRvJS/Xh8LHzSGiYlBwYbpp
	 58AmeGDzeNphYR72lyFDQirqX0S2qzwGFSlenA2Xi7K69QKTx7cnx3fFP3gzWI1MGB01W
	 +q5JWURUAUUhUjTAndaWYKzUBgyKgg3/9fhhLdIbCpYRfSZ2/swSfuq10voUKU3+WINJN
	 vrFEFwqK4agKMF7BhXkRPSu2LkbG2OEAM85WEbTphZyd/xHeI9Bbpa4EiVuZUQJDSbQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791495112;
	bh=V+qzjPgese7zIK84jcwsZm3begIZTqX2DHkyv2Ryk90=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R44axJHslEsvoE5P3618rlrRVf/4b3ZseLApbvTDC9E8VIIia0hfP/p3Ncg1PISkr
	 Z3GwJFrEdkZLuFEYW1jA5x66rXwFgH0J/hl3ybYhz1m+yrytTPEQKyZl05i6+GINce
	 T0iCrWiTUYDlPpezecbaoQ62RRntFtzd7kRd1sLbeXvi/9/ohhDIV2zSwafDmAZqXz
	 M5QQsnQnqIhXCHyPQqYa02P5K59VHzkIXDZg7tZdwPX1Tsk2KOh+0z/OLxNlynU4C4
	 Jfs7NdwmEduDXgdtkIPfqyajM8h97gb1gwLidjmqFm9r58o8R5dMZEfBdLUEqyTYDz
	 WvgLPeT1xH7zw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 15F3E40921;
	Thu,  8 Oct 2026 21:31:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DF6D42E0
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 21:31:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DCAE9400CB
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 21:31:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 67yO9NG9TvaV for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 21:31:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 31C6640064
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791495110;
 b=qVbCLEACtS6BbZWAAOYBlMYx9QflDMfD7GBYsenyhM5KYhU55rd4wMC11Wb+OGMxBuxa
 w662SgO2NJFm0rRSpMWCA1bEJpsr0LlOd/g67k9gwjCjew/+MSb7yrn/IwbbPdS6XLUJs
 cOGMUOH7hM4ztNYW63e0EeuoJ43d/MmpmqdijxTkg/toJchYDnWrjVCv8vNdzxqWmEKaN
 wkLOiNa1ESKBhaOBsXpdjxpz24HlUE+UvC07PPhiGLVD+SshuF9fLdGrfGXWVMi3sknax
 eilPv+9WwOCHojwEnKpLk5vB9GOcTyobXvxRuHwf1hA4bgwLSZoy2NYmjN3O1RmDtQA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791495110;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=V+qzjPgese7zIK84jcwsZm3begIZTqX2DHkyv2Ryk90=;
 b=qqfbVQfeGSOFbvQfiL37VLgNcu2ylT5XnOAB3hUZaXAa94hGF/qMHK+Rx/Qn/tkH0nlV
 3K40tf56VWmvVYrrAPtCsKA3k5dh5jUB6Qzu0DJ4vRyA/4Bmh76NUUS6RlGAMvmAmjsN1
 16uboF6ifoV92U9dD4Mq0qxn1ZK3Dr4npspZ203bRd2vw3m4aYL7e1XE5W95Noxo1xzDK
 tzXLIi4x5cD1jSmhRodQWFODMTKfZJLM/CTjhZTW4ah9QVd3jqBqbPmnEMlmUK9Or9Teu
 TDFjKctVJ3aZD5kdzHHFgRRFreSsgMeB0dLrQimmIGundsCFGqJxRS7/jijVFhWpiOw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=cherry.de;
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=CjJjNXbZ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=CjJjNXbZ
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 31C6640064
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 21:31:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oVuvimc4Bip3U+vhxOXUOgdtKGWaEk8vpO0/b8VzzgGl9p27INP78quDPA8RdOmoxn5dMDJ3mR2V0U2I3yyY5ebYYjhF6SCdVx4v5IXqmG2uecRh/lutou/1gac7I0pcfkQ62sIFLO2UbJE2F+43knKTRfh8UhaL8jN/bOmSVSyc77o9rjneUf9TGS8xSneZwd77+G1OfaOgHxKQbDA+RO0mPd6sQ72AlclOJHvBjNnN+LSGGv5oKxxxsqQl8/8ScfFX/cURNPeutHsNQfwmlTPAPe5stI0+1CmbB6ENGDpUa8kMu0Tr0201HuaQ3xwvzw06Rz1sohfIYsY4us89oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+qzjPgese7zIK84jcwsZm3begIZTqX2DHkyv2Ryk90=;
 b=Yr/0USa+Bg3OxfgpBUfLDr8wtACZTOR35sF1CDzytesgd/UqsdXVmrraH61Xnft64O9l7TPh/xICx9ln69RURNb1wIZE2vv5d4BdiRUjkqT0y/uIWk/bVqU8DV6YifHgSZHyFf5XaPIf6hU9b+sJfuYiYKpH0MCisjHM50zMn5+D6hwrUX1GGQZwrivgqceI5qU6T9mduprqEFyutA5tSh8hnDd65ToPTG6MHLbaYJr59e0ElhCTmdW/J5jS6HiHy24Uwpnf+C1pvbFA9mSdNl+aN/ACYQxqXIP+L1Z+ZTe1A1sNo2VN+R/oRFP7zrrbE86BCSiMgurJ64XorUHLVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+qzjPgese7zIK84jcwsZm3begIZTqX2DHkyv2Ryk90=;
 b=CjJjNXbZCEZuQJZc2QWL6BsOUf0pqxRMI4y6ieT5ihkQlBT9Erne0K2Hl8DZM12fx6qKT0WZkr5LumVyNutRm4jcKkzAeM7u22ZxtFuJi8EWPbJkVegOoHW8sUB+HlLQhM/pl4Ch1j6zVzIUS4qXw3wKKjxpAkna/cUngGbclvQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by MMZPR04MB886210.eurprd04.prod.outlook.com (2603:10a6:190:4e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 21:31:42 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 21:31:41 +0000
Message-ID: <670ba375-0a50-4f74-9e0a-4a2b017534a4@cherry.de>
Date: Thu, 8 Oct 2026 23:31:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] video: rockchip: dw_mipi_dsi: Get GRF base address
 from phandle
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Ondrej Jirman <megi@xff.cz>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Chris Morgan <macromorgan@hotmail.com>
References: <20260804105721.2402406-1-jonas@kwiboo.se>
 <20260804105721.2402406-4-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260804105721.2402406-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI4PEPF00000161.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::86e) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|MMZPR04MB886210:EE_
X-MS-Office365-Filtering-Correlation-Id: 13163d58-12c2-4627-4936-08df25838b39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 0Jp2+ESLEJFBAEEa8RYp7m/UTfX5bzwTmZ1Isxl7AePO5lcTks0SCyloTRZmiKYk+M3m/A/bmkX6X49mZ0hVq6RSnBmaOgM2s3gC9VylcUnW2iAVgo/SLiIh0HF9sm3CSW5S3S4K/o/FVBb8Q6g9saqjJ97UquWJbB2N/D6fvNuTpPYKxt2nqd0hp3U0aXiI61/OECSkJMWGlTD1rDx3EGWT/HDdWC9m2RFFKxuO1D6i7w028wtwtOo4AF2Y53e0wZ/Sz4ikwt5O7X3YCf/lEKCAgUNaidu17aNF5zsBL6A32/H3GXp49ejtl311M+XHBhF+xy0CDTZbFkitjY095s+hEhb6//VwnZaYjDk84mfLMofDjNMVfPp6UgEhe0cEdVmzQ4AM8SWtgRlgdCh216RdKRiPzwAZXGFELr+jSFua7D1DnUF/Wko9uTVagu8Xfnx7ap8SOSSvZ7tCkxeyGrmCn2QB40JP/Y0o+69dwFJJk4FVATWT4N6RoyzyTIXMbOXapY/XlhVnCqDuQs2Qd1gLFLReLCZeD/iPEbCabTwoe3VA7Vh2MuXfqM2oXDFAZU+8r3b8fvfOFYQaa2Xjk0i5fH+aYykTygJevd8UDnZDR40tBwmiDlNLHEuAkWPFn5fap90YYquEG+MWceYAyF6mEIjDLvn4+nnQiTRPfJ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGhBbnROK3pmZCtYMHhMVndENEg0eGtCa3FxVEdMZXIzekFuVmlPMHg3TWd3?=
 =?utf-8?B?U1FnUytOSk5wMVV4aVhmcmFxVzlKbUt6U0k4dzVQR3pnTGhCUFZPMk9PKzZP?=
 =?utf-8?B?QTBKcEJFa2Z2S3NhU1hWZFd6aUU5Q25RWU5xcGd1Rm5scThwai9PemxYVG44?=
 =?utf-8?B?TDlmeFpRRDl1Q3RGeEdPUzJHN3huVVFQeitzMy9mdlg4aVBLM0dKRnR6UTZT?=
 =?utf-8?B?aDFxV0Z5VjdyZlU2R3ovY2lxSGVVY2YvdVljaUpPK1dGL29tcmF1RkY4T2Fy?=
 =?utf-8?B?cmhWOEdZZVp6OHlVUFIyL0hBL212RDQ3L1c1WEhVdVVPcWFxOEl6WStLcy9M?=
 =?utf-8?B?WDNzYnA4SEZFbklUVGdHS0RUY3VCN2NjZTlneHIxdkwxd2hZR0pZVW5jWnE5?=
 =?utf-8?B?T0c4cjJRVnlkRHBFZFo1RzZ2V29BMU9xN2hqQkQ2em82eTFsL25TeUJERkgx?=
 =?utf-8?B?Y0w3ckV0Y0IrRFJjRDZLSCtIeTUzTkxTNFdMcTZBSnpNS3JuNWlzdkY1cHpB?=
 =?utf-8?B?RWVmQ2JyS1Y2M1hGYjdkYnBtdXhFNVhFZVQ5TzNpaXE2dEpDVTk3RFlJL2V2?=
 =?utf-8?B?ekZqTVB1QnpRR0pxaFBmYUFJN2psazlmSWkrMzl5cnFZSEU3dzdaVWpYL1hD?=
 =?utf-8?B?bXljRW53NENjdXk0UTFuaDQwQ1ZMMWNwTUliTDFTallYN0VwUm10emc2ZE8x?=
 =?utf-8?B?cDdIcXNFY0ViWWQvSUxrVFQ1VGc4OEVFYUc5VjU5dG9TUDZJMXVyM1FFdi9n?=
 =?utf-8?B?QUROVzByOHVGR3I3MERmempkMnFFcHhyV3o2bGd0RU9UMGx5dEJCekNTeDgw?=
 =?utf-8?B?S2lkbUpKb3lYenFQVVIySU5odEFSZkc3cnZ3NVBiMHZzcktPTmtVY1hPZlo5?=
 =?utf-8?B?cnZjZVg2Z1R0dmhzWjF0T29hQU9uQ2tzNDhMZm5sQTI0UHF4cjRMdWNnNnFk?=
 =?utf-8?B?ZlRQTVAyN052cDBGZXZMWVYxMlJPanhWeTVHTFpoVFF2MldJNHhLNXZQbzhU?=
 =?utf-8?B?ek0yc2RQVTJhaER5TmppRWVIR25WLzFFakx4dzA4RTdlU2pydjNhVzNxQXZD?=
 =?utf-8?B?RGJubG5JLzFLU202aDlIM09MTlFuYWFZTTl2WVU0RHNiWlh4c0VibzBnZXdo?=
 =?utf-8?B?YWZnRGE2Z1cvOXR2TklqZWVjWXpqaERnZURvcC81VVA2cFhPRnE1OTBuc0RZ?=
 =?utf-8?B?NVRhUWVra2FrQWxiY0VDRGkrN2ZnTk1qemZVOEpITmhJYWloZFZkeG1DVS81?=
 =?utf-8?B?cFhGU0lPZzRzZ1ZpQTV4RUxTbGl6d3JySHF0Tk5qWmJmeE1HMzM0NHlRR1RK?=
 =?utf-8?B?R056cllXVWU4di9zNHorMncraWJVODl3d1FqV050UHhqRzFqcjdHSW10V09I?=
 =?utf-8?B?eVpiS01XY3oyeFZJbHRERkRhc3NTNkc4NUxlYXhlVFpkRmpoOWhmLzZuRG1s?=
 =?utf-8?B?c0NncHNrOGhIdDBDRUI2ZGZMWDR5M3FrZS9DMDFGL3prREJHVE84RjdKOVQ0?=
 =?utf-8?B?WVUzUjdtYzZ6VUQ3NnF0WGtEL2w0WUswblZXRU82TmJIeVRKNnBCZ3BjODcv?=
 =?utf-8?B?blRtcEJoOHFQUERKY2UrWitLcTNyVGY5QzZmZ1d1VlY4eVpmaHFrbXFaUEJR?=
 =?utf-8?B?U1RpYkh3VTNEaWJ4MnBhdjNJVEM3QVd4TWtabEt5ajBVSmxuZUxDdXpIRWdG?=
 =?utf-8?B?MVZXOTBza2JPUkRGV0x4Z05SdlhFTVcyQ0YrOUVQalRFZWQ1T1dSbXRaTTlX?=
 =?utf-8?B?eGJpYnBXSFluMTY2a1F5aWhJblk4OEhaY2Q2b1cvR285R1JCaHRJQ1F1NmJj?=
 =?utf-8?B?ZkdwUlIxVmsrT2RWeUhKRTNtTVNWNHAxZEl6VFVxZ2hkWDB3ZWpNaWxET3NP?=
 =?utf-8?B?aHRDZUZHYktCbHVEazhYMzJyaVhIVG9KUERrV0RRZ3ErZ2EwdVYzanVDVTJw?=
 =?utf-8?B?dXYyNHNXOTY2b09rbEZNclVnYTh5c0hDVVNxbytxa05CZS9Pak41WEtZMThY?=
 =?utf-8?B?RnNkK3BvbFpMSjZtZUtyMzdaYjdDakh5ZjdyNWlRZFJvcm5ZYnRVL3Y5SEkz?=
 =?utf-8?B?VHdtcHkyRjJucUZ5aUJJenpLajk2VTE3UkN3YWZPR202ei8vOGJ1cmJwWFpO?=
 =?utf-8?B?cjN5WHZqRDdJS21tQlRIMXJQdU1PVjQzNUhPWVBFUnkya0xVclZudDRieFV1?=
 =?utf-8?B?WW9GeEF3MTl1MjBGNm9LSTFkeWUvWnlNYjZJY0Vqa2VjRTl1NldlYkFKa0R0?=
 =?utf-8?B?NllxQUMwOVc0cnI5b0lEN2grc1lFQkk5blNIemdwL1FLTGRUaWRxTnF2dkR5?=
 =?utf-8?B?bjdCV2tWMU9saVZaV09ZSDFqNkJHaExpUXFhSkVCL0VwN25rdG95Zz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 13163d58-12c2-4627-4936-08df25838b39
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 21:31:41.7968 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y6sp27PNZelexIbpP+/14hRcTsmHgxklQlyGxe9NvKabZ+JxCt0IHxl4MljYd8b1C141zxGp/bez1Gnwisg5QgayhLnA2ml51d8s2Scxeuk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MMZPR04MB886210
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

Hi Jonas,

On 8/4/26 12:57 PM, Jonas Karlman wrote:
> The GRF syscon is referenced using the rockchip,grf prop in SoC DTs.
> 
> Change to use syscon_regmap_lookup_by_phandle() to get a GRF regmap
> instead of using the inconvenient syscon_get_first_range() method.
> 

This was on my todo-list for so many years, thanks <3

> This has no intended behavior change, all affected SoC DTs have the
> rockchip,grf reference and the values being written already contain

If they didn't, it would be an issue as the device tree bindings 
requires this property to be set.

> correct write-enable mask.
> 

Indeed, via HIWORD_MASK() macro which is specific to this device (and 
also is badly written as it should be ((val) | (mask) << 16). Can I 
tempt you in sending a follow-up patch to change that with 
FIELD_PREP_WM16_CONST() instead?

> Fixes: bd6375c5511c ("video: rockchip: dw_mipi_dsi: Fix GRF access")

I don't think this patch warrants a Fixes: tag. I will remove this when 
applying if I don't forget, except if you disagree.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
