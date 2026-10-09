Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E166CA6012
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 08:38:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1A8B8608B4;
	Fri,  9 Oct 2026 08:38:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4gbQvVlxR3eK; Fri,  9 Oct 2026 08:38:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D1CCB608A9
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791535125;
	b=bCS4mx4uIdWIIHf5I8SC2qNMOnbfCwnez3H8CgmcPJ1aMsfkv7FLaV6R0Zud/rjI4tw3
	 +r8FlrAgIY5VC/GuMg+ZoujRqELgzMjS/VUh87TzwGIdaitPhobcSmSCeKfj5GXz1ZGFv
	 KCtHKIUfp6t5cGz9KvpIkK6leXxcGbJSt/UODZ1X6zJGLy0mAez8eMq4smhZDTKTiDRia
	 myEmHL+h+q0im07XiV8iZ5u7+uGKn5R9mBotOunpDEkezODmMhn/QGJ5HGJ67V0d5NoHa
	 VdpV4S72Brs47k5YYFocbXos0J6agOENA2j7x5PtzAR/pyTCiASMBslJLvpl7n3kUdA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791535125;
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
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qhPE9M7BeVT/b6H+/uuc28kUqBoZwxWZe9/CT6EqshM=;
	b=N3Tws5nN8mwVgBFNYY9hKAqek9XMI4fjhqGuKtx6hKePlgpegbpsuON2yWQp+BAa/8tN
	 T6sOgvYht/MGSc7VbTwcnR4PyNG2QpIs9DZoCwYTdfR95xAdS/K2PToq1skEUFBx1y4iQ
	 qojarOstrQgvHlHkx54xtrwamgBjB16V9ppx1nSZ2qSI1I8C2mJrssmXC7trkXxAJCJFA
	 OYYVNt7ObSMN+QxJHXcWy6SWMDjH1K5I/ycMb9+oPW6tOmtg4YbQ54uk+s9IH7qMU7GPv
	 nTANxlzx7+8jecHF1HP0z2oqUclbD8VzEI0b08p+qCmfV4Pyjf/o6F/NND4fCIgETrw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=none header.from=softathome.com;
	dkim=pass header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-softathome1-onmicrosoft-com header.b=OcrOAblZ;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791535124;
	bh=qhPE9M7BeVT/b6H+/uuc28kUqBoZwxWZe9/CT6EqshM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZaBA5F4uh5QnA8TuO1bY3xYQmTC9xJILhsWyHeuEzFPHUqgtLwNr1GnIR26Khv7Ej
	 up5LuGl/NqzzVh4pPEt7qpQoaRxHY6LLMjErVTKsHj97jC8Okpbx0GwLtgLNRY97R4
	 VZB8Vc2Zb+IgEtfkj7O3s9ZLClu3T/GsnO2VlBlJVqwCEzksOrtYjcSlAuuh8R757N
	 Uk8BwXwovWwR08R3ckoZ+H2ypG/GrqTVH2IRYd3sUJ2BOKvC/AI7TllhbN1jPfWp5n
	 P0maWrp332hP9sVrw3mDz1+V8aLvw4U8SO4ulug2MbeX+9VSsOEM+3lqBBFH2d+o8J
	 N9pJT10TtR71Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D1CCB608A9;
	Fri,  9 Oct 2026 08:38:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E78CE1D2
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 08:38:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D922A608A9
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 08:38:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nTbs0lGnnBmB for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 08:38:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3011A608A7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791535122;
 b=oopNYUaXB97HJdOV5lg1zxLrbBGsBm9u11pOTvoaHznDnx6GYPPEkJtJrWOE7bucGxi9
 x7eAmpKR8BbHR9kSGAi/DnR/CapI4B4CyUStpnW08fal7wlNEN22JYKZI08XwlCUUDYeE
 nslYoXsxp6GeZA5A/gczU8NkPNTW/udxYZAXdpAComv6FFxHbLQxP8vxDDCainxczSRAb
 Iho3si6adKbMxKjYaCZmWYUxoPwFK1ZClEKPnZzdSZoE2Fb25AwD4qgVMgNdA+VFIkaVj
 Hc3hHPoCZm9JUxch9rlkq0GA4PW0lHR/y594qr5r7FVjL+lfxHVUOKP8EUT7B0FqGOg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791535122;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:
 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=qhPE9M7BeVT/b6H+/uuc28kUqBoZwxWZe9/CT6EqshM=;
 b=Dh5GEuRidweFQ+wqx5BwmzhuTBgCRsbYdva48nbTTCdPExFZym66/LP4MEooqWU7gt/X
 k0Uo5UosilB+pdQapaiQMHMFzrapNxqt1VVLJ7Y4oUNYA9GzHIU5/QWAs56N2smveu9m7
 67AGzgvW0L5d7XICXaen+v9KJfWWu7TVPldJM0mCMUoV4cT80G2lK+V8SXpym/UxQzHTq
 +lxuB1j7IbClBqLRujB67RYMyBtuJFgBRppCpDc3yk6IgxiQsMukJRrVsMmBQ9mInZLDZ
 ip5iS5x35nNQB5F8HHUuedBoKDY8mAPamnvEBF3f5+uMTmKf+HR7JzlxoLvFn0HMeWg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=none header.from=softathome.com;
 dkim=pass header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=OcrOAblZ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:c20a::;
 helo=pa5p264cu001.outbound.protection.outlook.com;
 envelope-from=philippe.reynes@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=OcrOAblZ
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3011A608A7
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 08:38:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/V6h+He8s3hEH7eYz+XU6ElIiY1NwI8FYzpxvIVAb5+3Wh3cPb7ohk6CiONxmGjy/MhIylPgQwZT0HVONEC2e5uGvGX+uzervA6nz3XBpAWOdFFP9umzLe9EtnG1tUJwbdsqbjIAsUQOnnPRZcuRIrtPk/TTQGaQyAoJkI9h/v+ko63gYEuC4dPje7WChwUwSI8asGgxE7mIhgikw43LAQW11nB6IJFUnSHIQt5NtTFzf3Wvd5a+Qit7AyGJOWcVaBQPjSIFoMglXjcIitnRPwUyyel+5m8CZi3JgPLqrK0xcNpSE1iW4Qb3R7l4OxYpOFualFBP1bFDHY21Wl8ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhPE9M7BeVT/b6H+/uuc28kUqBoZwxWZe9/CT6EqshM=;
 b=QZn66+gFta/8puXKMoV+1GKVQ+MtTMWSaiipPuzHqPFR32Mdx/G21v6zvKea4pXGHuFBMu8RQvgsfttp1S5nbTiihd4AKw3FwQ2BJFvvtiL1U4nuA2ARqWutSwmzcItnpkY/yQrO6c+gY8k87AwvfMPkRPtTVnrcAq3g+i4yGO3u8LTjLV8Ev8cLeSKPHXu9KZSM60G0hcuQ82Qm//x+PWFDS6lgCQP3QiSrZFckHDuJbrn57gVmjllOq8F8ZBlWZkyv7sGKifSgbTWGQJRuYJyar0DsFjGq8lEWP1MP9OdMKANulGYimPbOism7QAH/bnYbsNlj9tcuyt4i5GxYSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softathome.com; dmarc=pass action=none
 header.from=softathome.com; dkim=pass header.d=softathome.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhPE9M7BeVT/b6H+/uuc28kUqBoZwxWZe9/CT6EqshM=;
 b=OcrOAblZ+krEeiUgDMnDokG+SyJp5P9ggIyc1322gLC0tHbfRfMys5NjU0y8+i0wxJD/InGtAhiXg18EfpXco+8nnYfxRzDaGr0oq8Jv+6P/1yzz/asINdjEriO4mXtc9PJu+KveKjIL91Bnog0hyY3NSr/IwN/03ErGm5OefEePWyOdKXCKV1cYDbdyBkThg8nPJ/7fsXxaqdqH6vlhx04kHKpzs8I4A4ruVVu1DNBAr8LKXgMzLa/uauIYyQpgmI1hRrEzfE/OgSMoOHejDetIfyHW4oo5SPk4DTlvd8NWyF5ciX6d+EAjlcbNJKwhUQ9OR1ROryueSVDPB8QiDw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=softathome.com;
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d0::9)
 by PR0P264MB3674.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:14a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 08:38:32 +0000
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6e14:438b:5c18:8557]) by PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6e14:438b:5c18:8557%5]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 08:38:32 +0000
Message-ID: <4fc58666-7025-4e04-99db-2b2aad74022a@softathome.com>
Date: Fri, 9 Oct 2026 10:38:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/15] add software ecdsa support
To: raymondmaoca@gmail.com
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com,
 simon.glass@canonical.com
References: <20260904083719.53132-1-philippe.reynes@softathome.com>
Content-Language: en-US
From: Philippe Reynes <philippe.reynes@softathome.com>
In-Reply-To: <20260904083719.53132-1-philippe.reynes@softathome.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0118.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34c::9) To PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1d0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR0P264MB2741:EE_|PR0P264MB3674:EE_
X-MS-Office365-Filtering-Correlation-Id: 31c76c6c-0201-40a8-3dfd-08df25e0b342
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|10070799003|366016|6133799003|22082099003|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: w1OOd7Xq9frrxoDh7A7CSU+31s3Sjg5fWYvS5zilIFSReGXjGZGQLvie5L3pxJJxKdVF8InV0rNDCTCmcOuSTJ/h0NBVfCd2kFVF6hLPwbB9rPrH3UIlvoyQkgbY1sLwXZWcKAZqEGnOanWCiYs8tBnxf3zZ7xrefUhHJMkufMPqdkU2uq6hfQwW2jnNafqg89X3eZz/B3DfPCNg5Jkr2dCt3zEXelVqjLUgGQOB7OJytHO1B/UTOTu3AcmS97TbAdV081MB2CpKR39XqnuOGGydWFOcoNHBnLlIPhVKQOzs4y93Px7NnhKX3KzC8Ml6vA6McX9BYJCq4EVqVaplLyCisgLcDAnChJAs5P+2qBreFH5ZR0/afU27/eRomp5NF3Ll8zXDFtVbSXcRwXHSJox8s4KRHPFl0izECQxwyYUsAzLE4u++Q6NoTNZrX/RvTGrX8GqQ7ci1YbUcVsXekCfw8UG3x+fL90h1Q5xjErintGzGJiJAPB2ODz0DzherfuMa/cUVFJVTTCnMblXBJoC/LtRT9vkd5ysNK5drBehEk80TXjiUaVFi6Tlzpm3vq/eS9gij2ani4RjwBczWOb1wUqQmOu/LWbKMwqtVfc17JHqz5WpVYqFK30+d+YJB45eQHHEg2604hBRaMtxpDt7EfS+9kl0SBqSiTX51X4E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(10070799003)(366016)(6133799003)(22082099003)(18002099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjVsbG13M1REcEZyd0FnWE5zZUNQV295Z1YxcGlOU1VDVmFjS0w2SlhqNHgy?=
 =?utf-8?B?WFZUdlptV1VzcEFlU1FsNEpkR2lkVzcxM3BDUDVrTVdCbEFDcFBRSmNKbURx?=
 =?utf-8?B?QWtoSjB1clhncTdnbGVHNVpUQ2s4M1R6SHJwTll1OVl0QW0wT2UvT1JkNHBx?=
 =?utf-8?B?N1NUWWpNd1NJTkRYN2JnTlhWNHllSGtkUXBFaVF4OS82Q0VKR0NpWHFxRTJW?=
 =?utf-8?B?cnIxQnQxWGYvVm82Ynk4TWVPclVIMzJUa1VhUUwyclFJK0FMK1A3VWlSZi91?=
 =?utf-8?B?TUJTbzBjMVdLbGpKaEJZZUh4c1RMSDZQZXRKL1NVMkZpUnBlQTc1MWR1WkRr?=
 =?utf-8?B?MjF6N2lMTHhVdTdEUzExRkF0RmxrVG5GMU9uVjV3OWZRR1BuNzgzYmJlL3FP?=
 =?utf-8?B?cmFsWjhqak9ZZlMzUTVDcSt3L2tLeUU5U0k1UlZlOHZyVDdmZFlsTHY5VGlJ?=
 =?utf-8?B?M3lFSXhnSmpJOG8xWTdyL3F4VjE4bm1ZdFl0WVNNZFJ1TXpHRXMvcDZLbVNs?=
 =?utf-8?B?amQ4cGRTQmN5NjJ4V1pOeVNxeWdPQWRGWDl0YjNXa3FGZTdHZ2pZOTkzeG8x?=
 =?utf-8?B?N2Z0YnNISE9mUVFxV0dxWVI5dGhRbmpCMGp5OEljRG5DVHphNWU3MGlVWWVj?=
 =?utf-8?B?TDNWTDBIeWhFWVVwSVBoc0QyYXdKWkZSKzBQZ1IvUEJXK3lYekNlSktuOU9E?=
 =?utf-8?B?QzdVUTFRMGZ0aTFQZUZMdDhhTi9rSTZiSjZMbittSjZaU0RxL24yZ0dHb0hr?=
 =?utf-8?B?a1N1UE5pSEQ1bHB4VWZwc2hVaEV5RU1EOW13bnRmeGZkOVBGNkRWYW1Wb2J6?=
 =?utf-8?B?c3JsUWVMeitZV0RNVm5ocEhhaGo4UnlSQ0lXUUUrWXFRVXlMdVJZR25ENmxx?=
 =?utf-8?B?MEpFL00weVVTakk1VmRSemJPaThRZXpNZzBiRTAwOWNlUXBaaG84WmhDem9L?=
 =?utf-8?B?OEV6RjEvZ09YOEhOcE9jVnh3WVZGcUs2R1BqNzBOVzY2WVBxN0JIelBYZWpP?=
 =?utf-8?B?MU03OXdnTlBIaHdHUGp0R0xIQXcvVnJ5RGNmMmxjdE9qQnVsMUVUVVVpZHZ5?=
 =?utf-8?B?ZXpFY2lZSERBa0M4alBDVFd1LzMwQ3NBTjF3enpicEs4MzU5MHVENG9BYzBF?=
 =?utf-8?B?WHBoQVRNRElOVlAwZlZPYStZOTJ3VzI4d3MxOXhkR0dHOHNaN2N3TDZZWm0v?=
 =?utf-8?B?RTBTbDRPYmtGaWkzemozVUNrSFpYMUVMNkRseFFWZE80amRXZnBlS0l2VEJC?=
 =?utf-8?B?NjlmM092Kyt4NlRYM3hUeUVCR1AxSmtzcVMyM2Z1ZFdFTG9CNmE4SFBIQjRa?=
 =?utf-8?B?NXNyQ1NscG1pdzdMLzBuT2M5MzdnMmpZNTh5Tno1QnJ6RVdJQ2pZMUxNUjhy?=
 =?utf-8?B?OXRDZ2VOQlB5VFVmUld4Mno2M2Z4dGVZakJoOFpOMzI4MmNkd0xPUFpyTVUr?=
 =?utf-8?B?UVJOL1EvcS9NQWRicXVJWGJ5aTlSVVF1eCt4Rm43MldUSzhVeUpNMUtQd2hD?=
 =?utf-8?B?cHExaitwL1F2Qk1iVi9FbThReU55b1V2RlJEeEprblovVlhhS2VVMi9wdTJx?=
 =?utf-8?B?Y28xYXJsMDR3ODZJOG1TRzhWWXJVd2dvd2VMcEhib01wQ09tMFMrTDdSQVA5?=
 =?utf-8?B?ZVFvMkFVTDN0b1RyK0hPSlVkemVDRm1uSmYwZm1xaVFtWlhHRUwrSzFEYVlJ?=
 =?utf-8?B?VGhBc2YrS1Y5eVZWTVZkM3RKYThRTCtkcldqZm5TenNQakZocHVCa0pJeHNo?=
 =?utf-8?B?QmhnZGFDMnhBTy9iUmF1Zm8rb2dmWUgxdkYwbFRVRCtiZUY5TFpiZmRWY09U?=
 =?utf-8?B?OUJ4MmpuSDM3TDhqSVIzWURsbzFBZThpa05TMzBwQlQ1V2hLc1lySmY2dXli?=
 =?utf-8?B?ZnNHc2xFVWlaWTV1Y0RPeTZ1VkE2YXZVbmIrRjNMNStydzllQkpuSndZRlEx?=
 =?utf-8?B?UU9VMXlocVBNamNSRCs3dFl6aVV0aUtKaW91UWhnMmpxc3pOZUFncjdWNHo2?=
 =?utf-8?B?WE1nVFpWNkNtbTEybHczbUNrNlNVVUNEMGw4ZkRQZjRFaHJPQno3QUtGaGFL?=
 =?utf-8?B?c2RmMGQ3aUk3YVRscjAwRk5va1YwYU8zTGpQMStKeFcycXlJMkltR21RdmRK?=
 =?utf-8?B?UHRnWEl6Sm1jUE95UVFEL1N2MUU0SEhsdXlqc2FEUUNkYTRwMHVoT2xOTFcw?=
 =?utf-8?B?Y21WZU5NOWpjeElGeXIvckgvQU52RVFoS3d6QUhKMzk4dFJrRmFwdXF6TWdL?=
 =?utf-8?B?K0R2a2JqQUthUm9pWVhqZ2NHRVl3RURMTWZiSW0zZ2dsNjlXdWVUQm94QzBv?=
 =?utf-8?B?MmtDaHY0SGFlNjEyNXMwc2FCbTVWUm0xUDlBWC94MzhxcGE1SFVsQmN6RU9u?=
 =?utf-8?Q?JaAYqnKozacucLztIXq7Sjo3X1tHBAyfgk56copL9P+dl?=
X-MS-Exchange-AntiSpam-MessageData-1: gYrv43HEbcuY2ZWikmBm3/3cbCF/KIy91eo=
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c76c6c-0201-40a8-3dfd-08df25e0b342
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 08:38:32.1208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xuUwLh3BG+/Nyn9ymc2e6jHoASPK+yq7LCZRdX4LQmS6HQAjgBWNeS8yEP+Xi9Z6h3c1C5Oh8++c7y9LqOsvtB7KYLcFiztxuAj0+w3XjaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3674
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

Hi Raymond,

Do you think that this serie may by merged please ?

Regards,

Philippe


Le 04/09/2026 à 10:37, Philippe Reynes a écrit :
> This series adds the support of ecdsa with software
> using mbedtls. So boards without ecdsa hardware may
> also use signature with ecdsa.
>
> To achieve this goal, several changes are done:
> - fix the support of secp521r1
> - enable support of ecdsa in mbedtls
> - add software ecdsa signature check using mbedtls
> - add support of ecdsa for internal fit signature
> - add test for ecdsa for internal fit signature in vboot
> - add support of ecdsa for pre-load signature
> - add test for ecdsa for pre-load signature in vboot
> - enable software ecdsa signature check in sandbox
>
>
> To test this new feature, just follow those steps:
>
> 0) build u-boot using sandbox_defconfig and adding those options:
>
> CONFIG_ECDSA_MBEDTLS=y
> CONFIG_ECDSA_VERIFY_MBEDTLS=y
> CONFIG_ECDSA=y
> CONFIG_ECDSA_VERIFY=y
>
> 1) add a signature node to an its file
> 	signature-256 {
> 		algo = "sha256,ecdsa256";
> 		key-name-hint = "private-key-256";
> 	};
>
> 2) generate an ecdsa key
> openssl ecparam -name prime256v1 -genkey -noout -out private-key-256.pem
>
> 3) create the itb file
> ./tools/mkimage -f <file.its> -k . -K arch/sandbox/dts/test.dtb <file.itb>
>
> 4) launch sandbox u-boot
>
> ./u-boot -d arch/sandbox/dts/test.dtb
>
> 5) on sandbox u-boot prompt, load the itb and launch bootm on it
>
> => host load hostfs - 1000000 uboot-ecdsa.itb
> 4628674 bytes read in 1 ms (4.3 GiB/s)
> => bootm 1000000
> ...
> ...
>     Verifying Hash Integrity ... sha256,ecdsa256:private-key-256+ OK
>
>
>
>
>
> Changes in v2:
> - move ECDSA_MBEDTLS to MBEDTLS_LIB_X509
> - rename lib/mbedtls/sw_ecdsa.c to lib/mbedtls/ecdsa.c
> - enhance dependencies for ECDSA_MBEDTLS
> - fix support of ecdsa521/secp521r1
> - add vboot test using ecdsa
>
> Changes in v3:
> - do not use _MBEDTLS in mbedtls_def_config.h
> - check returns and remove mem leak in lib/mbedtls/ecdsa.c
> - remove useless field  *k in struct ecdsa_test_vector_s
> - check returns in test/lib/ecdsa.c
> - fix third parameter when calling sha*_csum_wd()
> - add support of ecdsa in pre-load header
>
> Changes in v4:
> - change some dependencies to enable ecc
> - use ECDSA_MBEDTLS to build the ecdsa driver
> - support ecdsa521 and secp521r1
> - add a test calling ecdsa_verify for the ecdsa class
> - merge patch 10 and 11 (support ecdsa pre-load for binman and tests)
> - several code cleanup
>
> Change in v5:
> - fix ecdsa 521 in the first patch (instead of the 5th patch)
> - mbedtls: ecdsa is only compiled when ECDSA_MBEDTLS is enabled
> - fit_image_setup_sig: required_keynode is initiazed to -1 instead of 0
> - avoid hardcoded value for ecdsa sig and point size
> - check pointer before using them
> - free ecdsa keys when key are not found/used
>
> Change in v6:
> - fix dependencies for ecdsa
> - ecdsa is no more mandatory for tls
> - remove include u-boot/ecdsa.h in ecdsa-sw.c
> - do not use fdt_stderror with -1
> -
>
> Change in v7:
> - change uint8_t to u8 in test/dm/ecdsa.c
> - change info->required_keynode >= 0 in lib/ecdsa/ecdsa-verify.c
> - set required_keynode to -1 in test/dm/ecdsa.c
>
> Change in v8:
> - check exact size of data read in dtb in function fdt_get_key
> - enhance commit message to explain patch 2 (enable ecc)
> - no longer use macro CHECK with goto inside macro
> - some code cleanup
>
> Change in v9:
> - rebase on next
> - update cover letter
>
> Change in v10:
> - remove empty line at the end of ecdsa-sw.c
>
>
> Philippe Reynes (15):
>    ecdsa: fix support of secp521r1
>    mbedtls: enable support of ecc
>    ecdsa: initial support of ecdsa using mbedtls
>    test: lib: ecdsa: add initial test
>    drivers: crypto: add software ecdsa support
>    test: dm: ecdsa.c: clean this test as software ecdsa is now
>      implemented
>    test: py: vboot: prepare integration test for ecdsa
>    test: vboot: add test for ecdsa
>    tools: fit_image_setup_sig: set required_keynode to -1
>    tools: mkimage: pre-load: add support of ecdsa
>    tools: binman: pre-load: add support of ecdsa
>    boot: pre-load: add support of ecdsa
>    tools: preload_check_sign: add support of ecdsa
>    test: py: vboot: prepare test for global signature with ecdsa
>    test: py: vboot: add test for global signature with ecdsa
>
>   boot/image-pre-load.c                         |  53 +-
>   configs/sandbox_defconfig                     |   2 +
>   drivers/crypto/Makefile                       |   1 +
>   drivers/crypto/ecdsa/Makefile                 |   6 +
>   drivers/crypto/ecdsa/ecdsa-sw.c               |  31 ++
>   include/crypto/ecdsa-uclass.h                 |  15 +-
>   include/crypto/internal/ecdsa.h               |  39 ++
>   lib/ecdsa/Kconfig                             |   1 +
>   lib/ecdsa/ecdsa-libcrypto.c                   | 104 +++-
>   lib/ecdsa/ecdsa-verify.c                      |  73 ++-
>   lib/fdt-libcrypto.c                           |   2 +-
>   lib/mbedtls/Kconfig                           |  24 +
>   lib/mbedtls/Makefile                          |  20 +-
>   lib/mbedtls/ecdsa.c                           | 152 ++++++
>   lib/mbedtls/mbedtls_def_config.h              |  41 +-
>   test/dm/ecdsa.c                               | 107 +++-
>   test/lib/Makefile                             |   1 +
>   test/lib/ecdsa.c                              | 456 ++++++++++++++++++
>   test/py/tests/test_fit_ecdsa.py               |   2 +-
>   test/py/tests/test_vboot.py                   | 148 +++---
>   .../tests/vboot/sandbox-binman-ecdsa256.dts   |  24 +
>   .../tests/vboot/sandbox-binman-ecdsa384.dts   |  24 +
>   .../tests/vboot/sandbox-binman-ecdsa521.dts   |  24 +
>   ...pss.dts => sandbox-binman-rsa2048-pss.dts} |   0
>   ...-binman.dts => sandbox-binman-rsa2048.dts} |   0
>   .../vboot/sandbox-u-boot-global-ecdsa256.dts  |  27 ++
>   .../vboot/sandbox-u-boot-global-ecdsa384.dts  |  27 ++
>   .../vboot/sandbox-u-boot-global-ecdsa521.dts  |  27 ++
>   ... => sandbox-u-boot-global-rsa2048-pss.dts} |   0
>   ....dts => sandbox-u-boot-global-rsa2048.dts} |   0
>   ....its => sign-configs-sha1-rsa2048-pss.its} |   0
>   ...sha1.its => sign-configs-sha1-rsa2048.its} |   0
>   .../vboot/sign-configs-sha256-ecdsa256.its    |  44 ++
>   .../vboot/sign-configs-sha256-ecdsa384.its    |  44 ++
>   .../vboot/sign-configs-sha256-ecdsa521.its    |  44 ++
>   ... sign-configs-sha256-rsa2048-pss-prod.its} |   0
>   ...ts => sign-configs-sha256-rsa2048-pss.its} |   0
>   ...56.its => sign-configs-sha256-rsa2048.its} |   0
>   ...84.its => sign-configs-sha384-rsa3072.its} |   0
>   ...s.its => sign-images-sha1-rsa2048-pss.its} |   0
>   ...-sha1.its => sign-images-sha1-rsa2048.its} |   0
>   .../vboot/sign-images-sha256-ecdsa256.its     |  42 ++
>   .../vboot/sign-images-sha256-ecdsa384.its     |  42 ++
>   .../vboot/sign-images-sha256-ecdsa521.its     |  42 ++
>   ...its => sign-images-sha256-rsa2048-pss.its} |   0
>   ...256.its => sign-images-sha256-rsa2048.its} |   0
>   ...384.its => sign-images-sha384-rsa3072.its} |   0
>   tools/binman/etype/pre_load.py                |  78 ++-
>   tools/binman/ftest.py                         |  50 ++
>   tools/binman/test/ecdsa521.pem                |   7 +
>   tools/binman/test/security/pre_load_ecdsa.dts |  22 +
>   .../security/pre_load_ecdsa_invalid_algo.dts  |  22 +
>   .../security/pre_load_ecdsa_invalid_key.dts   |  22 +
>   .../security/pre_load_ecdsa_invalid_sha.dts   |  22 +
>   tools/image-host.c                            |  93 +++-
>   tools/image-sig-host.c                        |   7 +
>   tools/preload_check_sign.c                    |  30 ++
>   57 files changed, 1892 insertions(+), 150 deletions(-)
>   create mode 100644 drivers/crypto/ecdsa/Makefile
>   create mode 100644 drivers/crypto/ecdsa/ecdsa-sw.c
>   create mode 100644 include/crypto/internal/ecdsa.h
>   create mode 100644 lib/mbedtls/ecdsa.c
>   create mode 100644 test/lib/ecdsa.c
>   create mode 100644 test/py/tests/vboot/sandbox-binman-ecdsa256.dts
>   create mode 100644 test/py/tests/vboot/sandbox-binman-ecdsa384.dts
>   create mode 100644 test/py/tests/vboot/sandbox-binman-ecdsa521.dts
>   rename test/py/tests/vboot/{sandbox-binman-pss.dts => sandbox-binman-rsa2048-pss.dts} (100%)
>   rename test/py/tests/vboot/{sandbox-binman.dts => sandbox-binman-rsa2048.dts} (100%)
>   create mode 100644 test/py/tests/vboot/sandbox-u-boot-global-ecdsa256.dts
>   create mode 100644 test/py/tests/vboot/sandbox-u-boot-global-ecdsa384.dts
>   create mode 100644 test/py/tests/vboot/sandbox-u-boot-global-ecdsa521.dts
>   rename test/py/tests/vboot/{sandbox-u-boot-global-pss.dts => sandbox-u-boot-global-rsa2048-pss.dts} (100%)
>   rename test/py/tests/vboot/{sandbox-u-boot-global.dts => sandbox-u-boot-global-rsa2048.dts} (100%)
>   rename test/py/tests/vboot/{sign-configs-sha1-pss.its => sign-configs-sha1-rsa2048-pss.its} (100%)
>   rename test/py/tests/vboot/{sign-configs-sha1.its => sign-configs-sha1-rsa2048.its} (100%)
>   create mode 100644 test/py/tests/vboot/sign-configs-sha256-ecdsa256.its
>   create mode 100644 test/py/tests/vboot/sign-configs-sha256-ecdsa384.its
>   create mode 100644 test/py/tests/vboot/sign-configs-sha256-ecdsa521.its
>   rename test/py/tests/vboot/{sign-configs-sha256-pss-prod.its => sign-configs-sha256-rsa2048-pss-prod.its} (100%)
>   rename test/py/tests/vboot/{sign-configs-sha256-pss.its => sign-configs-sha256-rsa2048-pss.its} (100%)
>   rename test/py/tests/vboot/{sign-configs-sha256.its => sign-configs-sha256-rsa2048.its} (100%)
>   rename test/py/tests/vboot/{sign-configs-sha384.its => sign-configs-sha384-rsa3072.its} (100%)
>   rename test/py/tests/vboot/{sign-images-sha1-pss.its => sign-images-sha1-rsa2048-pss.its} (100%)
>   rename test/py/tests/vboot/{sign-images-sha1.its => sign-images-sha1-rsa2048.its} (100%)
>   create mode 100644 test/py/tests/vboot/sign-images-sha256-ecdsa256.its
>   create mode 100644 test/py/tests/vboot/sign-images-sha256-ecdsa384.its
>   create mode 100644 test/py/tests/vboot/sign-images-sha256-ecdsa521.its
>   rename test/py/tests/vboot/{sign-images-sha256-pss.its => sign-images-sha256-rsa2048-pss.its} (100%)
>   rename test/py/tests/vboot/{sign-images-sha256.its => sign-images-sha256-rsa2048.its} (100%)
>   rename test/py/tests/vboot/{sign-images-sha384.its => sign-images-sha384-rsa3072.its} (100%)
>   create mode 100644 tools/binman/test/ecdsa521.pem
>   create mode 100644 tools/binman/test/security/pre_load_ecdsa.dts
>   create mode 100644 tools/binman/test/security/pre_load_ecdsa_invalid_algo.dts
>   create mode 100644 tools/binman/test/security/pre_load_ecdsa_invalid_key.dts
>   create mode 100644 tools/binman/test/security/pre_load_ecdsa_invalid_sha.dts
>
