Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 038A6CA6019
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 09:57:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B153606F3;
	Fri,  9 Oct 2026 09:57:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EdEAr8lGGd5A; Fri,  9 Oct 2026 09:57:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 05A97607B2
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791539861;
	b=e7a3MotDkz1XidCQamfnthoExBRBlvfvSnNS5X00K7F4PqhCtvaaUqyD/aXTNTQ5QEiV
	 0CDoeGCxwHW1EpdfraTX/rUtxb5MuP//jOXSI+yEn0ADUHWq1FlJHtppCphuNpNSRtcYf
	 DqXghbXxF0vokd/0iWzzO7qU07soD1ZR2VS4GrKQJzltB0EL2uAge2fHpHxW6bpdEow9j
	 P6RDmsLGDs34HtTPpeE1QPlI+SJSZPGwOaXFtdN7WeZ4/bq5t6XWNz6Wsqi/FUAd4bjrt
	 ULtOJ7OzTXNF+lisa3d7temgq0hadXZfN9YEqc67o2YveCT7oljzWojXya5p2EsjOow==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791539861;
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
	bh=bFOXpvZU1Dc+idUIK3OB3oqU+lI4Vs6hxuddqBpaMUY=;
	b=fAuUFy/maRQlqZUlIme4fE3gRVAuUKTZEAwNz+gBNSSO9nhDQsVOdX2MAcF7okZRFG6b
	 M2ANk0DvoB3T/f2U8sV33rIfdDp2v7+x9maRaYW4uXy0gM1HonN8cg33Egbipl38GQqqR
	 yJZzOWq7IFihng4AJnJIvQmUGDB/F0NWDQ0CKp91L338bxDJ+8HpXgozW34FPGvJR3VlO
	 +2Xa3HJD0DwcB6JdtxyIs7pzuomW/s4/4uEL7kTTWHMJNECOghkUVZnpfCaydHBMHFQTc
	 iUWYmgNsHPcpI6qBNYQ2ovzkZ1ivPv3ULqfK/chwaz83Pp6sLyH7Iz4Zf2c8o+iKg5w==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b="iqr/3T/y";
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791539861;
	bh=bFOXpvZU1Dc+idUIK3OB3oqU+lI4Vs6hxuddqBpaMUY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0eOeNhy6V5+S2CpIFndVXApGTS+Ml2b54J0I2nxOdbn4W4T6dmWfBZ+Hy7mxVZgys
	 CH91/7YZVRv8fqMN3QXxt0obc4Ni2Ew2GHCNEYCJPqkimGRBbYpUg+GAdZ7N/6pD6o
	 XuVv4tE75FvFs3wKVdDYY7FJVPWeKOA7RssV0vDs4NxAvWeIILcH3QG1ONMklcZ0iJ
	 B4+1jA2ZikFBYDBhiInqLEAAl3C4hvQ9xga66D4MA4yZF18VEY5ykAuJNDwLdl4904
	 vBbfmJUTuFYdb6C5Fc9uZsbeP8m5bFQGLVGmVzB/qIMXfEcgr65UUrx0B66Ec1zxsM
	 VmyJi0qFgO39Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 05A97607B2;
	Fri,  9 Oct 2026 09:57:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A918B1D2
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 09:57:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9A96260892
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 09:57:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zTUha0A0D7Pp for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 09:57:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4E971606F3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791539858;
 b=auaSlIa/2w9eDrPUmKBewTSKqahNJFHjJhSKtf8pfLDb3tPsHRWW1EeLx33DzRhhJq2q
 PVW0JO72bjPt+PkSFrgcS7xWi9oiBVYBtpkNayo2njdlpuGJy10Ll5garho9Cy5PzMmn9
 E6chcJKq5IivxyyGkikFwvVHzOL77OBynu5bUOLuU+SzZha/5PmKS2Zfuk3yULmi5uWPC
 ei7BBBYmZvMdhvgAJFO+7zVdu5nUe1kTH6nwSXq02+nfiqNmNsf2WPBfNp57t8ubM46Zy
 +bYxCo8jg/IRzaISWKk4EV6s4qV1zwWG716KcWo024o7kp3Y9MSW1mqpw3IfZh4Z+uA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791539858;
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
 bh=bFOXpvZU1Dc+idUIK3OB3oqU+lI4Vs6hxuddqBpaMUY=;
 b=omn1i9jt/hTWkxoBuLKgoWeJzbZ2K0m+U32ZMFnVblwsg3XopCQ35+kVFrPiVQKZnibj
 IJv+Edm8TRGIv5FsHWmu67oaZFWx2iq5Vw+1rsU+KKSkgZ3FfCY76KdS5fosb4PG/Mzm2
 7rD1tRPr4qL/fFxueKiGHtnqYYZj8EnCY2oDkQ+wpecRsEJCBp20Cwm1Bn7HjPT1g7W0A
 mBbSI7tgBc55EvdMitFchZjXlzgmmAie7xnwFzK/LoCGP6hbYJDjgWar1LBDdHYxfm2lu
 SAN0hzGSA9UB6py0dnzaGaUSPTRHDprw4UxJyP/gdBpTWZI8sexfSpfU76GOF6TEStw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=cherry.de;
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b="iqr/3T/y"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=iqr/3T/y
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4E971606F3
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 09:57:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FYFputaBWfl1kd6UnIjSyi/gjksZr/MFxPoQ1wtsmNgXZb+j666XpsBAcDjY1eLj9wl+LOiErhm3q+vpj5ekrEVot3aYd57lpdUmAJnPwwZ/WAZRIYHujdO7AroimLRTO+dmIilh6eoTtPGajnq1Tl+vbiFbtrOh5TMo5MTDxvA5v8IeqaFGJ342mbaQec+lLUu6ANHiDFv7yiaLq0mvRZ8mwZHERmYKepEE3U+E9fsSvay6TDdHsVpqWFnncokHyPXbHJlLz+NVfGwURXqsNNR1l4BKqrGYiH0pJK1FmWvTWuAfRDPvZpC3yDLhowjV6anMZc9xptHoa/cAutuQhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bFOXpvZU1Dc+idUIK3OB3oqU+lI4Vs6hxuddqBpaMUY=;
 b=VXu1LcwBezYLsyp8Jd+fJoD+CEk1hupSD3Mo/zwmlDgUVLrtEFa0N+p76H4SMiRP9Jf0shFWLr/0GUI/3oGVvsf3l+8YrcyAn179eZ347dG1V29nqPU6sy+95s4jTuFK396d91jCSfxQ7FeKLWeh+RfcNzI3Un8I0FnZUCwwa5gClDexwka3/LCg93Nz+ZMvrCX6pUhqodlQIre8kEYY9osSeveFExM8Y6oadmDS4uAW/dKYrqGaX7ix9TOez7nHIa1l6L7wQZfAoY5rkD5AHyIM3TuuOrab+YMyMtxLOoOSJJEBxjRC9LyyDFNG4XxLLfNOTRe0B/HbrML646IJPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFOXpvZU1Dc+idUIK3OB3oqU+lI4Vs6hxuddqBpaMUY=;
 b=iqr/3T/yG+QAGPbg/LyMzgMKpIt0CfWKuqa0tOqoxDz/qXM/a8i4hnXG2tysJOyz5ujDMFUkd2NSZmJi9XEaxerPoWBm1yFTcSkuslcrdNOQTtbhBpXOFdDEzU3ihFEOS7M9Ol3CI1Eo+iJORo8vXvbMwRxwqs9/GHCH2DDUtnQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by GV2PR04MB11589.eurprd04.prod.outlook.com (2603:10a6:150:2b1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 09:57:30 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 09:57:30 +0000
Message-ID: <5669ce41-8327-459b-9738-f3c48ef50900@cherry.de>
Date: Fri, 9 Oct 2026 10:11:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] rockchip: rk3588: Rename CRU_BASE to RK3588_CRU_BASE
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Klaus Goger <klaus.goger@cherry.de>,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: u-boot@lists.u-boot-project.org
References: <20260804214442.2592597-1-jonas@kwiboo.se>
 <20260804214442.2592597-2-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260804214442.2592597-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0027.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2df::19) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|GV2PR04MB11589:EE_
X-MS-Office365-Filtering-Correlation-Id: 5905ab91-b5ed-42a6-2e04-08df25ebbb4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|22082099003|18002099003|10067099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: T7k3lCSJpMpkAub6oaiaeFvKwZxTLazmKIPRj+qviXpbzj0unTNLqLLj84gpSQ5TjQxynKb37T4x0LNocqE2c1uYL8FIxy5+bqNC7Ow8DgLj6vGizYbVzjEvLYQwsLU7GZPIKuNFHSfzwNB4F21m1RIyMPBsTVqfQJyA9vXBDmZsGdx6eTSCA6WeT9kjLOqBtMj/Uj9XGhUd8ipfAeRrRWQCC5s4MKGMwebEWORp+pCpWrLi9qQtMiNKJCkYFQFXz2bDOV4Dyx99kNXj1obAOmLz66fb2ipMZ9Y0wJl5o0VC6G66uKyt/hRJJ2+pUe8MCZCl2/s5riFcUtnP/kLQoWQN0llAYdplAEIoZPhM0qsgldNRSuhBevpeEauG+d6EsZaTcUHMewbj19WHXvAhgg89hRIrbF+uBZ1Pv3IMC9D1i9Xwwcz0b7legoNQoiqUIQv15sOIYHURK29Z1xmOuPSZyta1lZZx1kmduDIVj17l3iQd5Mv17hllR1h9cCM49D/F1P2LfQDjk3bSurl3WB4LWLE/M90NyflK9Gh4a5POaGvS/o94z8dQk7ALXAVKEt6aPbdy6dzwK2x3kpqYQu1hBK4yUkeB4S2pQNy/Xl8/KlN8vIAczLaY5PX5MwpyMC9j7Cq6SiFkVxqSIHPsvpNaXindw4QtW6oczyMIIao=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUtkanJDT0U5UlNzQ2dzWm15ZXg2bFg0Q3N1Wjc0TzVVM2dIY094RjNtSGRM?=
 =?utf-8?B?N1o0SDNtOTFzYXc5TXpMWG1DQ1NVWDFITlpzT0h1NkkxQzRMVWJLMzgwcENT?=
 =?utf-8?B?MHVuQnpRMXZQQll2aVZRclFDblRoWUZvYkZham5FdlU0Q0NqNzVRTysxSWNq?=
 =?utf-8?B?QkVseTdaeTZpNGMwLzdwc3paVmR2aFFlWlFRTENKY3IzU051bU5VQnFyMGxa?=
 =?utf-8?B?Z25Bb1NNbVpLN3pmcENSaHhoVlFUazJQbXpkMC8rcTdDMzFjazFKQUJlMTNP?=
 =?utf-8?B?Y3VJN0Nia0RXbDkzU3dHajFGVmxqekwrZytkZzAvZjZhYjB0YXo2bklPU0Q0?=
 =?utf-8?B?RlVIZWxXOG5Ld0luZnhHQncyRzg2eCtlUWwrVnd6NEYwems4VlpIclZaWGV6?=
 =?utf-8?B?VVBWK0pwMU1XcVUwaXU3VnhFdjlid0dHajM5Tk1JT0p1dC9FQ1ZSZThiKzFy?=
 =?utf-8?B?VnBOVjk3V3M1Tk8ySTdwZVZHR29uRlRDSktHczJ1QitDVTFKL3M3UFJwaXlx?=
 =?utf-8?B?cUFVaFphaHd4ZWhUQmhOekc4OURHWXVubGZBR1ptUjdvMTFpSkQrTE9lZUls?=
 =?utf-8?B?MWFITUZlM1RxOCtHY1QzN3V5enYrbEp2bUI3WDNGUmM3TWFGRG8zcE9sWXd5?=
 =?utf-8?B?SjlGNnRyNENpd2JicmE4ZXY1cHorcktwSHU2VkJuakdhY0NlbHNTZU4zMnFC?=
 =?utf-8?B?ejlxcHB3OFNRVmlwUFV4WnQrbmRSNTB5T3Jheit1Q3E4NVp5b1BQRi9TSlZq?=
 =?utf-8?B?MURpN3NDWVl5bStoOCtENUY1b3ZSQXpRekpXZFBmMTV0QzFuaW1nZTZaalVp?=
 =?utf-8?B?clIyNnBmZHluT1cyWGwrOWsxbHF2VG8xZ0srMnZ2bmxmQkl6aGN5dTdKRklM?=
 =?utf-8?B?Wm45M1dhRzVmdzdrYTRXMUtIT0ZXMGJKejRaTzFmU3JENmxmTmtVZWowWlo2?=
 =?utf-8?B?aks4cWtQSzNCUnpNakRFa1FQeFpGa21KTVYzUDU3eE00aGdzTWpFSlVjRVA0?=
 =?utf-8?B?VWd3Q2NHOGtuSDRLWUdSN1NaVGNzckdUendWQlhIZzNZcGpQVzBlM2pZYUNz?=
 =?utf-8?B?cXNNcDd5cCtaZ0dwbDBzWmJ5c0QvYmZvUDFxWXBDWkdpOGUvMmljaW1Ma2lV?=
 =?utf-8?B?M1lsT2xiZkkrcmh4U05abGpyTHRnMnFwMmxIaDIwZWpMQUY3VTlOTWJ3NE4v?=
 =?utf-8?B?ZzV5d0VJTlJkUFpBMmVuUlB5b054VlZZaEltS0tEd0VrY3VvV2ZwREJDMnFR?=
 =?utf-8?B?bDJhV3dJMURCTUVzTHoxbUxtSXJ6Uk9Zb0VxRHd1WDZ2Y21ZMmhaSGk1WGo4?=
 =?utf-8?B?dVhFSkh5OTdoMWZDbmp0M3o2NldRNDlSNW8zL2d1RFdIVGlqQ1F3eU5CWlRM?=
 =?utf-8?B?QlpVOTFUS05PeERmWG9wcWt0T3BJMlBHSlNyOFg1SzV3K0FrWWtSMFhUQWlq?=
 =?utf-8?B?S0xtRVZvMGovS2RLUGtFUldMTThFbFp3ZUkxUmgzMzRNTGZpdjdnV2dhZ2hQ?=
 =?utf-8?B?L0NzRHI4eXQwR1BZRHVWcDMwVzgzWmxLZWkrV1BXZUVlZ0REQXQ2dU5BSU1w?=
 =?utf-8?B?NTJIVWxhZXFNb040OU1HdUVOLzVIM09tcTJTVFB6ak8vQWs0S1lOS1V1OFVH?=
 =?utf-8?B?ZTJtcm5xLy9INlQ1SEhkcmZOMjBtVXp6Z20xRjVEMk1OMm9sSHIxM1FrclhE?=
 =?utf-8?B?NVhNVFJBSm56US8vY0tDazV1RVQ1NVRleFM5M1BBNkp3aFNzMGNOQTh4UGkr?=
 =?utf-8?B?eUlXS0NEZWJRYXg2WVdoZndYRFplOE1MaGdnNWQwVGJnZ2ViaUUvb2RlaGlh?=
 =?utf-8?B?cGYzbUxMWGhJZ0F1U2hkeW1mdFUweHlWT1g1aDdtY3dOdlhyUmV0b0FnWWxa?=
 =?utf-8?B?TVROUlg2MGpva2pQeW9xUGppN1dPUUZpRjBHT2Z6MStXZ0NwS3o2UGQ1VEZM?=
 =?utf-8?B?TGxEWTZONytjY3poWGtrb2E3U1FaSkdHOHBCZ0M0L2t6UGMyYjVxZDJ0OExD?=
 =?utf-8?B?NkowUFF1aW1wdmQ2U21LWWcwM0U1NzVrdnhLcEVqNUFqSEw4VVV3WlphUVM1?=
 =?utf-8?B?VUMrb0lrcWlkd3l6YlVZc25ONWo3dGs3Z2w0MWI2TXpjVk5leWZ2aGlPUDhh?=
 =?utf-8?B?QzJLemNsMDh4T05Xd3B3Y1hrTHJLb3kxL1J2WS9kQzhVQUV4TWJzYzRoVXh2?=
 =?utf-8?B?ajN0UjJyMXZpTkRBZmlabFJ2U1JYdUU3a1dwSlAreWhwZ0ZvTnhDdkZUSkVT?=
 =?utf-8?B?WDNOUDVuOEY4a1dRQTM1YUp4SHowdDE1VG41UXFBdzdyMzlLbEhwWjI3b1o1?=
 =?utf-8?B?cXBRZFJCTVgzYWRuME9vQ3pzOEJsR2FIL1hiUi92RGpSMm5ROXZYZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5905ab91-b5ed-42a6-2e04-08df25ebbb4a
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 09:57:30.3078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0xClIVnIU2PnIKYCcNIePi83L1I8stL/w9eWS9Tl9A2zJTpS8NUNfu4gwSsXA4u6ezGVZxUMoLdxLO5l5VZzu5OpIY+Wd5OInFNdrKl/N2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11589
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

On 8/4/26 11:44 PM, Jonas Karlman wrote:
> RK3588 is using a generic CRU_BASE name for its SoC specific CRU base
> address constant.
> 
> Add a RK3588 SoC prefix to the CRU_BASE constant, similar to how other
> RK35xx CRU base address constants are named, to more easily distinguish
> what SoC specific CRU base address the constant refers to.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
