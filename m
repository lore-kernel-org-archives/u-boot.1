Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 123F6C98302
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 16:44:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B4EBE407FF;
	Wed, 23 Sep 2026 16:44:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d8DkIqnrls_f; Wed, 23 Sep 2026 16:44:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0DD504074F
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790181849;
	b=iQxHkIaeqEg8s0PAxRsE1Asap+/oWmfCBEx6btblVt1VNrTB9ow+xFXmv/Z/3nTU9Rqg
	 mJWFIA6LQBv9f573gRcpA1td0WrSvl8+qpETKvqIPtaJJoqeOZGixuoGlT7KtpnAsYM52
	 KgFjFAjEtx2fB8hZXTlQNaVySAOy3LSS+vuGvECa6kU8Y1gKuJFmRvx7eGWn0sneXiOMI
	 GAtXzI2H1O02IOhTjgrYurmTvpaOprDrrj1s5spiHrJeUA6vGlagM3hmjlRRJ+I8TUUse
	 OuRTPCyfByfBHlQk1VVYe8Kn7rNuc9yLKu8Lm/GJgQzLRh/KB/i3oYzUj2B2GdgkKAw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790181849;
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
	bh=nBfjIJW/WtttdVQJLaYjhnN9Q/cQphcbgrTJpsngeNU=;
	b=f9dq/nbt4iBDbzfZ6UTmd6WYptIhOX5rbCAbgRbynnw5FbuUv7bBQDFeG9h4rV0CpQiC
	 msE+ivzl2QXzuHj05YENgtaClwyf7Z9bZmGCxWXhiyLPACJJ3u+ZrQgTdq/qbNvKfdART
	 juSs+MS+oQK/Ed54d+zUUfsMMMS4cTF1K+L7I40zqxlQcnko+6wzPCw5ZCZCn+KFaQkWG
	 ufxy96Tdi/uODerJz80dTVC/+57TrlwHD+pFfSqzMKSN27nmndlmh0Xx/pkHwsc0olPBk
	 ScIaDwdNblR+fLciD944m8ny1BPXuYvAmgPgCQFCEsxMgihwPrLeyTlVBp4I8wIhCdg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790181849;
	bh=nBfjIJW/WtttdVQJLaYjhnN9Q/cQphcbgrTJpsngeNU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DrRC8JOoAzKq7NkKGbN2jrPo3QPamWhdmOibtpfJifHBAB0YvTyJ81eRtrqh439t7
	 NwUDVFYmh4LkA6lIKrXwOBVB2aU5IKxV8ARx9HIISa3GPd/IBnSnPl+rrSub7hNJnb
	 2bM2qXZaHRVSddJNoWVcbTxgI3MJhkqDk7L24jFdX8UXHTbNjYyZJkWqyHMTGXlCSd
	 Ooshxn0rfcIqjEwU6qr6V4/v0dVvO8zr1ov2WYbwO3xRhcM8JLHLJitXCGWojesadn
	 zFWVqJtRaDzQp0zEQhCZqn9dXSOJtnUpmcQndQ8r/1JfJNpzd5dmBUfi7WhPg54KXP
	 O5Fr67Xcq7T7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0DD504074F;
	Wed, 23 Sep 2026 16:44:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E0F39334
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 16:44:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D31E460715
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 16:44:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lb2GYyBeW4iS for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 16:44:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 13ED6606D4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790181847;
 b=gsSqPfXK/z6u1lYnNU3Jm22VP2pu9vPUF17gZ1utoSICNtcmc3lDRD1AGgVXa54nd3gS
 TGTogW3fK4UJl3ptALI5XYuiVXgxGu1AtYt7A//Oyg1w+rleiPKlScvs4QMXa22Vyh9IV
 BJ3E8zYdHT4PXG25yFqYrXOvQZRwtnU/4i1uz79bHsSW44608o2tVQWrhkuT/SWrOhgWp
 D6f465TEqq5Pj67/Aj9BDbBE/5PorD9eNe6V/K4tmUImk20j7Uodv2r4pvD4hGqJ0lszr
 bUb+kaKUNL++wIpJ+yBhNUmdKTt/0gwstgi9S3wwFNcWyQ2CtIxak0OWrWMriywFeew==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790181847;
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
 bh=nBfjIJW/WtttdVQJLaYjhnN9Q/cQphcbgrTJpsngeNU=;
 b=WXF1DyJpNPFRgB/GQm48twp60aTno8qaYIm4TI2IOdtQL1PASBns84Hu3wxMs1shND6G
 yNn2BUhzyYRsRH1Sl06hwiwdO13eBrHDxSPtyLwGXQxRaCs6x9pyjy+qvuLiGInVixNmE
 u34oCAFLWN2diwNSMpz9tQwfcwOiLGRKquRbD0MfluMqZa2FfZSbSkONSU4t709M2lNRY
 2zbWUchXXK/kdJBbz2hrYt6qdrisfB5Z4nX9vBiBJcS4/RSvZhrdQaQEAqwMwbLpBbgFM
 JPCwOr8hN0W2DrP8ZIODu3xB0/IQ+slgobNE53OHdKFXzo/Sf2ekbksnorjVEzSou6w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=cherry.de; 
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=NC2Kmj7a; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=NC2Kmj7a
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 13ED6606D4
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 16:44:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Udc4tbfgzAHxQE8UUr3wJf718FyranFYm1M99ijLX/P/dF6lC0RmctY/Hh1Oxb0C+/suBc5L+PsQYP7RWRKox6/GSICgTyHf6tAtlu9k7Rh29hUa4CeOFBnVbNNAogxyxbW8vXHaOrIpe3ebWZVCtXKvvSeMBdvi+2Ox9W08VEZY93QmJ8AURym4tl6N354Jb3vwchoXNvgRXcWy2671fui6/tUeFy9F+F5ngeSQBhV4iSe6yiihc36n7HX21YmTsTd9tgpp+q74ZO7W2qA2zr7AIkq1HSqy4VMPvC9kj1bQP5xKWqBaxd6kblVbEKequ14MuZyLeKLxuNvrE0d9mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBfjIJW/WtttdVQJLaYjhnN9Q/cQphcbgrTJpsngeNU=;
 b=eRAAP9q31+XL3VSbAK8e49NJf+NZjQ1QbIfsM6nJM9vlhdiEhl1wzMHUkMAwtZhWIUJr1yFO2+jUR97qqyjCvlAQSSbGDS8iJ44Ip8iyBNsqrmh/9vgOm8U2PoJZ0wKVvGNZc8z4z2pfo+L5f8VKr+SpXdewSV+bFcdImJVGue0X4W/YtaWbLn6W5kmWCbJgL/BBV86GVJzK3NoKLvyX3oPNTuwkeI2+GcICeyLAJtEPPyOiR36Nn32aVdbiRgfsl/E/kEvlZHBGry0VuWdYY7I/V0hbWehOaaJmySdyjXgF+gRbl++ieBhbpbxJkhzamvRo0NiWBEvCiuEAbNk74A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBfjIJW/WtttdVQJLaYjhnN9Q/cQphcbgrTJpsngeNU=;
 b=NC2Kmj7akIvRSroqwhTXQPYWfsGgdqts1ixmG+lh/AGebweffmj1a0WS2Jv9huEkM3M0yS/5yEUaA4Ejj/8sdmX2upDcZ3VhaEaAE7zcPOPrYO4nIa2zt6J2W590V7Gf1dLXd/UDaow8WdpL/I4kOgM/irdpLXXxCL7vp/tIU20=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AM9PR04MB8732.eurprd04.prod.outlook.com (2603:10a6:20b:43f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 16:44:01 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 16:44:01 +0000
Message-ID: <a21f2fe6-e1d1-4ef9-b9b6-8639b7f70e31@cherry.de>
Date: Wed, 23 Sep 2026 18:44:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] spl: fit: use constants for FIT property names
To: Aristo Chen <aristo.chen@canonical.com>, u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org, Francesco Valla
 <francesco@valla.it>, Anton Ivanov <anton@binarly.io>
References: <20260923154610.339153-1-aristo.chen@canonical.com>
 <20260923154610.339153-4-aristo.chen@canonical.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260923154610.339153-4-aristo.chen@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0072.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:349::13) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AM9PR04MB8732:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e40a38d-b9ac-4a2f-54b2-08df1991def5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|4143699003|10067099003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: byV8ANk37+f/8EMzUS8MwcKqY3Oj1R4VXcUU0hfqckB190R5YeHJlOJWzhOg7cBuAQswE67/EXNZUuvkS2+DgYrndvEPWhg9TLP09G68oNNFgKzbdxuI8S7wRRxsvW8x0s0Y6/u11C+rzUQt3mEcBq11FHDrmrSyJ2U/WsqVeGcuBCquHgJ1TNm/8/WXyuyBWYdGavOHKT/naRLfV3zrTmsKZMWI7jGrGLN97DmruG29Dhz42eSuzqgCw4OZQv/3ioKEGG+FTm8mdyTxi8IHsVjX233vlIfylPTr3SD0IImoA26zQxluSureEicNbAPg88FG0QWu7X/GWqno7k6cGghv6xTMIbqqFpdYZqpB8bQVxIm1MDyy/D0IByHa+HLoo5Dvf6kgTmSX7kNkt2EinrqSayZ/xBsE1bvjhZv0VBJ5hp3TfG/9L/fP/SN2ndibeBnIBbyYwokY5cD/WSh0OVF0qO2i7v8By5c0bSjjxyEPgCkT7mcu5Nv2exYsIzEvWRSNVt7YCFcx0ZIzQaKvA56Fv5xn55Fz2l7qSB25YG9fYrHjQDCyh+2+1FOCoQPX3rQZdn2FT8N3G91DYgIxOHGNL4KaVkZNkHOFMXE+lzFCwMV6QUm8BrxeeeNP9Wrm3uc8UBnA+y9CXeQYbkNwvyDA8wKDgomh/Mixys0BPOg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(4143699003)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Slo3cEVySmFNS1VhcHdJQ0FsdmdIditoTzZvcndZaDJNWDh1aittK3lFQTVn?=
 =?utf-8?B?aHZIQ0NTbDBiREdnbjh3ekVUVWtVZHQ2YnNGRHJUM1ZvMDJaRno0aXlPLzJJ?=
 =?utf-8?B?SmkxY0xkOWk3bExXT3NCeUN6K1A4OWk3dURFdjlLUFhpUTJkeFQvVTB0QWl5?=
 =?utf-8?B?c0M3R0d2bHE4bW9MUzdNUjJvOHRDUnRGZ3FFdGxlZERuWkVmNE5YSXlXdmZm?=
 =?utf-8?B?SFJMSy9KbjRZMnZha3dEMEZCa0p4SXgzZ2FPd05oRCtZVWRGNmIwczhCUS9x?=
 =?utf-8?B?V2VFOHFUaldzcGNjcXBEaGhFT1F1R3VsZWdWb2dwQkZGbit3TFhoUXJKbHBx?=
 =?utf-8?B?enNKbW1PdnB5MnFidUJvaEF2NlRmMzRSQWlvaFFTK0x2N3NPV2tSN3gzSHdW?=
 =?utf-8?B?Z3QzNlpDZWZjbnZ5aWhOWFIvVjZOVXpURENKdEtEd21zSG5nTFh0WFZ4L0dN?=
 =?utf-8?B?VENCVVhydURHc3RFeWg3UDhKamZQdDZjWllQOHcxTis0WUdQSDdtOEFtRWd5?=
 =?utf-8?B?b0ZlaTZtVWYreTdoemNaWG5hU0IrQ3ExTlJLQnVyeUJ3bWhFWjI4bThZOE1X?=
 =?utf-8?B?MjU2MDB5NGNpV2xGWDFkSDJ1QUwzNUxtWDIreEdULzJPQlgvZk1RMHBtMmZB?=
 =?utf-8?B?Y2Y1TTY1cmRRWS84bGVKc3RSaDNDelJKMWlkWVVJcXZqTVpQWENLMmc4WE0v?=
 =?utf-8?B?L2h1ZjZQRTR1clpWaTQ4dzZac0syZFNzU0g5QlNwd2lWa0JuZEUzc0ZMbERR?=
 =?utf-8?B?b1d4STNLVlJLVzIxL3lNeThscDBZTlordHhESU1pYzQ0ejJqYW1wbUxVTTYz?=
 =?utf-8?B?NkxyN2F2eEhyaUpYRmxsMFpYblJwdlhEUG94RXozOVFqRHVMazFKd250TFlE?=
 =?utf-8?B?YU9RSnE3YnY5OXpPSmozSmtFQXlyY3ZNOGs4WnJCSmxjV3A1R1ZPWnUrd3M1?=
 =?utf-8?B?VThxS3YxSXZCRnEwblZrR1lzbjZWR2s2eXhNWFFZRTFicWdpSS93cWFyMWpm?=
 =?utf-8?B?QkxyMXV2aE56VGFzNVZsbVRKNnBac0YrWGF1c0ZoVUNYcDlsTEN6SXVjcloy?=
 =?utf-8?B?R3dBMStyZVN3MjVPN2NCRHIrYmpwUWlJcXpzaFVuL2NRajhFUnpwTkc0SXFP?=
 =?utf-8?B?SzMrdWQ4R3ZDc2hPZTBZQmVBOUQwUnVubERTOG93RGlyak1iaGhGZ2ttVFh1?=
 =?utf-8?B?UU9Bemc0N01QRVNaTDJZOEpXdXdWM0Jnb1VHMkY3WEdQY1NIUU1VQmhzSE1F?=
 =?utf-8?B?RHNTWHlSVmpEN0lBTXRBbnprYzRXaWp2eGZhUjhBT1R0MjdGZ3ZxaFpwZWVp?=
 =?utf-8?B?TERIa2pCN1NxR2tuNmozeW81eUNmQWFlOTcwZUM2WUdUenNFRkcwRUE2WXR6?=
 =?utf-8?B?eCtEU2Y3d1Q0ZzYxcXpXcG5pT294bk14cHBsUVBaSzh0TUF4VkVWSjRhdHFO?=
 =?utf-8?B?TVhLZXAySXd6TG81VzBickYzM3lwNytVRmt3SThnQktUUzk4STBoKzF0UUNl?=
 =?utf-8?B?aTNWVk4zREgzcjV6VExueDFrRTh4bkV0dXpzbjJjKy9LR1RNU3k4K24zMjd3?=
 =?utf-8?B?MHJGWnFMbzNsSWI3TkFkbjlrMUJrdyt3bzMvNzlVRVNtWDFSSXZNTEtrNG9G?=
 =?utf-8?B?WlhZR3Q4cU85c2xhejE5d2tabjJ1bVlPL2dabkxON0ZuOGVMVlhYUHo0ZkVF?=
 =?utf-8?B?VytaN2U2Ri8yRjJIM1YxWXdZZEQ0QlRjTEZXalhUWThzeGRWSncrUzZyT1dL?=
 =?utf-8?B?SkFuK2tSenlnY3YwUC9MSjdTNndZMTNFS1NjN2ZlYzJNUU15cXJSN1NxU1BP?=
 =?utf-8?B?YU85Zkg0eXMwK3Y5OFJTeXhET0pKNjRYYjhLMEtqSWNDTlIyT3NMR0Q0MDUz?=
 =?utf-8?B?ZlppWFVSWHlMNlJRMS9DUWZnQnp1UjB5R25QdkdiK3pzMjJ3U3JaaXFxdUts?=
 =?utf-8?B?QjZPaUJhSEFCeFlmaWl0c1JlT0lQKzY5TXl1MHJNeHdkYkRmQkI5V1hnNzZi?=
 =?utf-8?B?cC9oUWljdzVnOWJ4d0FXaVUyYWhJWW56VHFDcGkzMTNrYUMvSlB3WXliSE1X?=
 =?utf-8?B?b3kwMUpoRFh6aHZPV1h5a1QrYkJPVjRSbFZUUDdJU0FhaytraVc0dWFkQTZh?=
 =?utf-8?B?VDdlVllWMlJyYVg4THRmMlFhRWErdzJ1U3FMZk5TYzNVaFMrZUg4YU5KRnJ1?=
 =?utf-8?B?NkV2cDJtMGFEZ00wMzRsdisvUTFFUE82YUtwTVZTTi9GV3oyVzJaRWV6RndJ?=
 =?utf-8?B?S2o4Qy9vZ2padGJsZjZvUUZYdjhxK1B6N2oxT05ORFVUR0FBdG0vcE9vYU9S?=
 =?utf-8?B?STBpb0VUTkZSbStkRkFmdlNKWjJXS05xNWNkTEJNTUdmc1FGN3BFdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e40a38d-b9ac-4a2f-54b2-08df1991def5
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 16:44:01.3512 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zHgbF28JBdkGp8wrDPr6j/HVSrtyunbj9o5f0pr3f9/fPv6a+kqVXFtRgk8xjbSqwHtVsGPXSfNz+mJKDUGNT4eLqPWj7qxo4BF5w0P9yu0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8732
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

Hi Aristo,

On 9/23/26 5:45 PM, Aristo Chen wrote:
> spl_fit.c mostly uses the property name constants from include/image.h,
> including FIT_LOADABLE_PROP in spl_load_fit_image(), but still spells
> out a few names as literals:
> 
> - "loadables" in spl_fit_record_loadable() and spl_load_simple_fit();
>    use FIT_LOADABLE_PROP.
> - "fpga" in spl_fit_load_fpga(); use FIT_FPGA_PROP.
> - "compatible" of the FPGA image node in spl_fit_upload_fpga(); use
>    FIT_COMPAT_PROP, as boot_get_fpga() does in U-Boot proper.
> 
> No functional change.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
