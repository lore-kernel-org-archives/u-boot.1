Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BC9CA6017
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 22:10:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B7026069C;
	Thu,  8 Oct 2026 22:10:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b8rZAZ4mZjtd; Thu,  8 Oct 2026 22:10:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D6B7160808
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791497407;
	b=hilPTRQV7RgfNzQxCSCmLbVp+WtGWR+YzLtzTRF2m85tUypGkaeyP4loQSmrZMZAym2m
	 cWUp8Cu/h79J0Ok8qQk7ed9eWEFFxLckRRNJREFhpyOVetyibMne1S1tjWG3prHpFuo/5
	 xgbzOWNtYFi3X4XR0CSjgxj1uEuFCLL2ZX/54nxyPzNF6xubnixe64sGVqwQXq8JQC4m3
	 WDdR+V0n+oG9fMBqxUrtGVW3dDh2jzHvIIe8+rFSKe+N9SE3ZGWoE5zBGpsdkr/VU8ctn
	 vPt/t3dwou3HVP/wxFcOPnIrSMpa6tBA8NZ82pW7T0oJQunv0pub206w/2z+wVOCytw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791497407;
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
	bh=HnGbLNNgfJgFXr50/lRj3aTVAiGyIwDewZGxQgpSCOo=;
	b=OzLcpXDq1kFM0ZX5w4jAFpf2/sJ+Jmjd14NGUQ1m92Z+YLZJBdfk0RW5hvY0zRhr8R9r
	 4/Foxp8acFGVkIpX2vpbc/b54EO/0qLqrh9M36HCqnyariNuzBn4Td1pfuH2TBuxEhTj4
	 g2ObmzNlyCv1UDQs5Lq7hZ707y81VHUrZsZX2UNVzxPT9ipIqGPHQYG1IZA5kPmI24LSM
	 ZjaGdrNkabEOi5VVcy2tqNsAZbLWeJq3cxA6qSoiy2vp7IHt+g4HH5DdPxwG+VN530IeQ
	 waN/I12GYo/Clp0OizEhaQ18GtZYc2yjuTFrWw37OsSfKjrMtwzjXCqY0yPk6UQx/mA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791497407;
	bh=HnGbLNNgfJgFXr50/lRj3aTVAiGyIwDewZGxQgpSCOo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AqTRBiL2CxUgyBi4rDwSmE4j8jLwvRkTHmWAYNnlgV0okvxE6rk6l29tMi5fiUKZX
	 +G3IPWgB/BqYz8z8QnXbENuT3WSipGMe7/Jzo2wuIg5rwrCbC6oZdC+/jqF7KE+heX
	 Bl+ALRRZQkbu0XNEcgpnhyCnH9jCBtAz74XNsijmxpg6S3leBbPFKoBDI4HGvzIe0y
	 nroQsVdWwuq60Ae4BVdSQWDZ4+JA7IbVqhsf2ECTFzjD1M84LNfNfYV4xNGpVMgpB3
	 /eGf1f8DMPCh4NAnPXVdvBf8sM6qzE/pXe2viV2bBhT2BzvWAns1P6F4gtQh4z3Hhv
	 GfFyUSk5+52nA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D6B7160808;
	Thu,  8 Oct 2026 22:10:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CE3C12E0
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:10:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 563B84090C
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:10:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OwJ0u6MpUvub for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 22:10:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A64224090A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791497404;
 b=eZ7pRFZ9IFvNKfXgCL5eVJ/q7Spl/HgLJSaSbKSDhyNoPdZSoHl/0YoosqV9kFlmn28O
 a2MlKmA1eqqMzLUAjYX8o8FtuHwoyEDU/G6yWhBxunIS1xaNJ8Z4EA1Y+fXUIZobgxmXh
 l2EUNDNZUbEfKsYSng12Hw93BOQFWooYwy0xDSJKgShyUMfqFvxkHPQQbM53U1QkzEaal
 QurENn82CxMKOMPQwFGVMjRt2nq+AVGkzFO6TjIrvws77ALC/D3g4epdLpIIeUWD0CBA+
 sQCXFFxC2sbQudPs4AfByinYc9j9e2XCwlkLoQE6IvIKh8ppZi9FeeZYTyNauT/vhLw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791497404;
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
 bh=HnGbLNNgfJgFXr50/lRj3aTVAiGyIwDewZGxQgpSCOo=;
 b=qp6m0DhBPC5LjefeVFDg2mzhg+xSXHSBR76ykpsoz51omwkhbi0an/ledsRt1qP1Zrdw
 XqfNEH5OJ+1ExGt/cs9LYJkyPGDngVXyfBhA0+a8yeCYnYqBJAfMZpT2+27nrsPFwdVaS
 h5cR9I37yPkz50PLjF+YDAGwinsyjdXuS3MX/dahUqDn3SCzGyCPgtVDt0MSh4pybMkrg
 t+t/Rnq/I5DYKGJCnxYi1FvHeZXLMXU0F8cM/8S0RDATDXQ1DDknUb9EDv9/SY4gOtPoN
 cl0/S2Uk6iP2PWip0xoGADSAieJi653hkLJuh8beCU4u5OTLHX9VBu/okwuh7Zi+uxg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=cherry.de;
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=WE0o3f7R; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=WE0o3f7R
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A64224090A
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:10:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iY9liH/atRbQ8qLwaKCHrXa5nvYcIw7mtHN3ERsRSjsN5fjg/qav0/Gvw8mz8NMS695hadxI4jBmZtO735CAkCxKDsMaBEbk9DfR99XO0q31u+Bc2lyh9nKmXFr1WhKuqU6siVeYfpTN81264zfO5dK8diufqc+4QvbHfy4kl4qGIbCo2zUPI4jS+WhfE3C2hmCjOjMSvgqAhBfTESBZXo0Ffsbl92Zg23cTucLBmcAdmSiTtZZhfxHdsZO10Sm744nfpOirmEN/v0/y8aWCAqTf9MxGiwqCxwTOU2vrvJbPhZyUGplICyUkeY2v6J1II3W1s4OdruKLDPp2Gz9cnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HnGbLNNgfJgFXr50/lRj3aTVAiGyIwDewZGxQgpSCOo=;
 b=Cmrr8b5gLxg6qGAmHbYlwB+AkM7FysRLVnMX6errwgWffNSu0UQsrkax14RW603P1qK9SQdz7y2MrM4i7DsC7EIxbfJ+kyIjorTwZIABQXqiWdUwP00Ht1u1bn+SO55bfHoAy5hNYNC29w+B5Al0O0Jhdpg5hjGvXQVyIgQxkcW9XfGnQV7+MsMvXKAxDORGHwzclL5tMEbe5vTzAtif6ql1bSqLWQPCtMuQlrDXpT6xeS67Z3AnfnepBfqAE7960mSmLc60tvY0RD0zPDJsGpcJnP6quOoUDDyo/oz6HJwU0tnnY46A/vPhPmPufSgT0MVjEQQ+KfqPFjmg1funeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnGbLNNgfJgFXr50/lRj3aTVAiGyIwDewZGxQgpSCOo=;
 b=WE0o3f7RphZ8cM4c2BY6yQUnNisuHEF7awo06DPJhokfvuH7EZa420oa72SWFEJWIAYi1tTsiHUPGYNJDrkVIyLb7yWXMl8+a7dyC5I9b3a8mMhjRL2kaDUSbbNaafhrPbt5yNtmar7UpxbBWYiz4PzEIyQr4CR1aPRfDNYhY3Y=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by PAXPR04MB9218.eurprd04.prod.outlook.com (2603:10a6:102:221::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 22:10:00 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 22:10:00 +0000
Message-ID: <21e707ad-02ab-4fd9-bea0-959195019715@cherry.de>
Date: Fri, 9 Oct 2026 00:09:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] rockchip: include: Remove unused ROCKCHIP_SYSCON_x
 enum values
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org
References: <20260804105721.2402406-1-jonas@kwiboo.se>
 <20260804105721.2402406-10-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260804105721.2402406-10-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI6PEPF0000020A.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8d8) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|PAXPR04MB9218:EE_
X-MS-Office365-Filtering-Correlation-Id: 305550b8-46e2-42b5-8347-08df2588e536
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|4143699003|56012099006|11063799006|18002099003|10067099003|22082099003;
X-Microsoft-Antispam-Message-Info: KPASQavNkFHD8H+bLmMBILbe8HjW6X8IQ2RlB1p2y/AlZZrhJEeAQiLdGleBdLEvDhsfnkGGBEnHcW2gnaJchLCBAzSlt6Ks5rR7JG7xqMBTR5gs8yZ/N6Y4O48iQ3njdBc3DW5XJt+hDL2o1B+FJCtR0UkMMTBW4y6B0Nk6MIXQ/IwozX5JYJlnWwx0dmmzhkUdgIfCNhPoZtXCRNhXhLwSf0SKkZ8D9eGdTs4KiLxgWziJvuYajgAXuE31PlOi5IS5Qwp6SPnPSh2K8gurOHlJa9OUYXiGVDGjxja6N94Y3duc2Kk9bIc+J6dFPHn7FVj77qo32LNHyoLsa02e+a7gONA6rkni3OQIdO+A6gruR4bJmvTOVvQ+EJfeAgLlrqZu3JwAEjFaqFO6jUCWVsw+QOp5kWdTGdvh9Naavrjg3J/WrhZm2bZwuDTyGGMAFqvsa/66QNWBoIAyVS74R1aGnxkglLyhSGWrA8baZFAh2Al5kDQvqIJevhM9uCbBIQK8mmI2mtka2cCgQugS4JX00pJRPRZNQE0nNJcdiVt+943pPmzBoMlJEYjUts91Y1X1eA+S7z8tZrV3RIVK2DoZk2tQ9AeLzCgzcjvt3m6F+r/InO6B8OerZMepvhUVxCeNCO5k5igx0vJM2NDfUyY+eHOfisCiVCJHEqalNjE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(4143699003)(56012099006)(11063799006)(18002099003)(10067099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUlUdU1BWlYvQ084eHBIT09TSFQ5Z29ibGJJTjR1L25DeGIrS0lUZGhaUUZk?=
 =?utf-8?B?UXY1SHhyOWlkMDNxbEJUdlpTQ1huTXROY1VsUVNsdzNMZzF2SXRibFdyYkw0?=
 =?utf-8?B?aGdZVG9WaTAzR1F0cTdzMlgzcWFBMHBxNkVpVWtraDc1UFJGWHNnckFwS0U5?=
 =?utf-8?B?all2Tm1BbVZPcHI5MEhYNHI2Mi9yMnh5NWRLM2VrbVpRdHpLL0lWcFNIaFFZ?=
 =?utf-8?B?THFTREZkbThMRHd4VXN4cHBheU5pL05qVytuWDZLeExOQlhEekRTeWloRTdF?=
 =?utf-8?B?OHVvTTRxM0xrbGlGeDhrZ1RYSTErbFhEVzVnQ3hmRU9zMnhFM3Y5Zy9HaHpu?=
 =?utf-8?B?NGh0ZkhWYThiMDhybGZ3UGVZaGc0VFc0WWc4Z2xpVHk1Z1Z4Y2Z1WHNpSjZl?=
 =?utf-8?B?MmpkUG5lZEZOdmVWb1FoTUFVKysyWEliN2dtaWNnNGN3MysrazRnWlBkSERZ?=
 =?utf-8?B?UGtaY1JPaTFlcU5qd0tITGZHUWZyU1ROajZLVmo2TVNDWFpCUjA0VHF1OS9S?=
 =?utf-8?B?RE5Sd1NoSkxCeU9oQUc5WndKWmMvSWpwcjJzQ2pKc1YzS2NyVjl4eFRHMEd6?=
 =?utf-8?B?N1JPL25aS3U5dHFncDZ4eUFnM1loa3pNL29NT040N0NNMGxyYlpMbnhYQ2VF?=
 =?utf-8?B?M3crUjJOQ0lPRFUvOVlRQ0k0YTA1SldoeGtkNmJPMElMNVlNSk9BTGZTcGFO?=
 =?utf-8?B?cXRIZGVjRzlTUVhrN2phdXRkYWZaVXBxcjNYeDh5NDhIRFNUYXYyZHd2bWhE?=
 =?utf-8?B?b1Myby8zdURJWENGWmNkL3crUGo4eGsyeCtQS0tEUXo4RTZvU24zOUVxc1BK?=
 =?utf-8?B?Y1gzRjRBc2NENzNGNlVldk1OalBoelZzWHRXUDJnT0lIeWtPRkJPeDNmaFRs?=
 =?utf-8?B?dXlFSXZSZnZjYlNYeEtMQyswMHM5UW1uaGZwbVJ0Qis2STF2ckJDOFdsU3Rv?=
 =?utf-8?B?V3Y3OUJab2xmNURRZ0w3S0l1aVJTcmdoZFNWWVd1WVlwV3A5bkM2a0dYd05J?=
 =?utf-8?B?NVRHUFlmZGZVMkIyY3ptbEp2eW55YStXV2Mxc1JWS2FYZnJWWCt3eEZRY3Zs?=
 =?utf-8?B?Wlc2VGtuR2VRVHQ0dlRmREdySnBNVHU1RnNNWnVqZ1lMdnMzOG50K29XZ0k1?=
 =?utf-8?B?VlU0UC9WTGZ4Z1VvZHNLSFRvTHlpaVlSSU43eUtTbU1adVhlMHJXa2txVlk3?=
 =?utf-8?B?Y21kTEkrVHVIaXoxU2hwckxoR2dSM3JRdmdOd09sN2dlU3VFb0RrMFcwK1dL?=
 =?utf-8?B?cWd4WnRyUWdNWEJjcUNHTnp3K0N3QXc5VlBTV1BlbDdEWDNDSWxFVDJrQlR4?=
 =?utf-8?B?eWNWTktTMVpuK1JHOVE2Ujk3N0pIRTVkQ0pmZmVPNzdxUTR2QncxaFpRWTN4?=
 =?utf-8?B?emtpRlEvb0duM21Cek53N0t0ZHdVS0RCcDJzZ21Lc1FobURJOHdRMnFqb3Bu?=
 =?utf-8?B?S0t2Rld0UmJaVmkrYmQwSFR1dXVuWkEydHdjaGt3VFJXU2s2OFNzTnFaSkp5?=
 =?utf-8?B?ZEFwdmNWNFVkQzlSQXRtUzZzUmdSNTVOS3lyTHpPYWl4ekRISUVDRTNsQ0Nk?=
 =?utf-8?B?Vk1WZUx2MStmSER5WjV1Q2xZV2V5M0doYmpQQXFiVWNzS3JIamUxald0OVBr?=
 =?utf-8?B?SlBIZS9LbkY1Y3luUmhwN2VDbjVXR3M5OUVoT2xWdlQyeUdpQ0p0QVpBNUVo?=
 =?utf-8?B?Syt2NFljN2JOM1Q4a0d0V1NsR2xhREp6L2FwazF4b1BSc09hNHAxRzNsKzFK?=
 =?utf-8?B?ZUhJbTVDQXNGbzRaMGZTYmYxVFozR0wrK3F3U3FEV0NQRzg4ZTVrV3ZCd2Nv?=
 =?utf-8?B?a29hMzVqMnliNTFlSE5OMEFtQzhlbklQbkR2UlpiUzRUc0NrTUUvdHg2Tmhz?=
 =?utf-8?B?L2tlZC93TlpYM3IwRUIvdGNQbUc2Ykp0aXl4dytJTFppN3VUQ3VWNnJ2Tk5L?=
 =?utf-8?B?c2FENVllUmJSQVNFbjg3ZEw2OEx0NXNMNGZSZFJjUHRGNTF1U0FPVjFmYzQw?=
 =?utf-8?B?S1BybmIwUDhSYStHMWxkTTQ1YTVWTkZ6WkNya281eEhMenpKQjE3L0xUb1V3?=
 =?utf-8?B?eWlsdk1vZjhYZnpGY2tTMUU3YWRQbldNVUNKa3gwSW9QQnNpMU9memhRRWRJ?=
 =?utf-8?B?SlJFYWNsZ1NJT2QwSlJYT0k1ZE5zcUxkdWYrcEZYK0h5Qmg4eU9TQ3M0Z1du?=
 =?utf-8?B?eVc3N3lqeFgxTUdPOUJCL3RxNXFoQ2JITXQ1a0tBeWtWaDRPQzlVMm9IZnJt?=
 =?utf-8?B?Z1kzNEs3NEVXYXo0U0dIRmo1VHpTTkJrZk9TYStTRXRuVTdPeklNT09hMEFl?=
 =?utf-8?B?Ry9qcWJvWjliUjVtc0hZaENtYWsxMUltblI3cUxxaUJXZ2svTzdkdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 305550b8-46e2-42b5-8347-08df2588e536
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 22:10:00.2561 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SPt6mAzlKHkibKANxBlU6+ae3bFZP4111M6FcPNE9IfDv4x1TCCZyZZaO4s15Xkiq3GPB9wVcWBsQ+UWaTwijfSa7cQKp+HLV8J7Vv7Rw2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9218
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
> Modern Rockchip device drivers use syscon_regmap_lookup_by_phandle()
> to get a regmap or use a constant to get the fixed base address.
> 
> Remove the unused ROCKCHIP_SYSCON_x enum values to discourage new uses
> of syscon_get_regmap_by_driver_data() or syscon_get_first_range().
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
