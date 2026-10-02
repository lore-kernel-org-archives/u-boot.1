Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB80CA5FDD
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 14:27:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2BE7181130;
	Fri,  2 Oct 2026 14:27:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u91NAJfQ--CN; Fri,  2 Oct 2026 14:27:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 486DF810FB
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790951275;
	b=XGYkfXVFP6BDVDynku/n4TLbQTAOrM7swNxDVXF/CMAtYvzsHMz+dgIOnuB7Rx5XiDDp
	 T3Ep+tvKziXAurzD9RoKp18w3Q5bJi2hM3KYU+luGCsPHTx2MV9HEqMBearnu0CHvLCwG
	 HS8S0OFsb6k4LqhcoLXf+HxKgTz6lSKR+7VsdGCndxgB3iduVwXlv1MEBpZvGsjPlwMEY
	 ioEW3B5XS1eZW2CtHfBUUA21LQ2Irq0ojenJFBeJceluNqwl03tFjOxL9lpjForldWX3P
	 owtWzGxOBbr3LWSz7/Ga/jL6PFVpyWiralermyMajqTOgG2CezuYmMD0McFbnkJms5Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790951275;
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
	bh=fQaKaytV0Mqq9ms2aR/iMJ8ZofSKHVlPC+XmqIhajhA=;
	b=lHPIEQ3nazXMoOVBgtSdvSlCIoNFxbpDW2rQKCs7jLTk9fvlUtm5d+6AE/7ukJb+U1f1
	 RTCblFQDCHisENFqCJXHW+ajgl3enr0bl8rCssEo26OPmmU+6eDgxFwPpEpgM+Dz7w0hv
	 uFdrSzpEAzSGxu6stRgjAL1RKXTHiDX7WjtZsQ9d5ISicfrQ0R+ffgVmCfVlbayJia/oa
	 d2qUDdmCL+Vgxa8jlLrY9ZgdFFB+xxh5zoLYdePNpIgvh56yeluYdty2wwctaQ9hkoCO8
	 lpHzg+hEWzx4UC+wM+IR01mks3uv7UjI4rBghXpQkdZ456h3M2VtjCmy220+5I7aw7A==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=OmuW3ZlR;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790951275;
	bh=fQaKaytV0Mqq9ms2aR/iMJ8ZofSKHVlPC+XmqIhajhA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZHjVF5QJB5qkOIjT4HpAG12PAohlK4y+GpzNMJfnLFx9dC0tTggh9/XxNWccCxhOq
	 IRArjuaWgw8CY3prRo5SmyOa+HQTlmDXj8goYy6HQ1VYY0A5Mmv53mAeld1XKJBQp8
	 MTNE6dJYV46CgPem+9rDk7+QZweSzK9wricEXOjB+OEx08t4DA9hUVsjgFl9+tWLuT
	 S6r/HEviJ+Hj4lb8gUGiyYD5hY3eKZURXIGv6dU0wb2o3VyNlumka1LDIBwPNLHFtT
	 zu/1q9ptHfGKsgtNENfREEBeuMWo00oixqcLcexTcCZtaSA4KnOyJl2pTWDQaYxxE1
	 WTJMni/wAyKJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 486DF810FB;
	Fri,  2 Oct 2026 14:27:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 100FD282
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:27:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E9C5E81102
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:27:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XEGQyBJudtRw for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 14:27:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0A62B810D6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790951273;
 b=tO0u6Z7T2KdJWSA3wRsQC4c3eKWdJSURK8cD7KWsG6Z2E5KblYmAI3+Di2jB6n2Dg32M
 m6i6w2/3AaewM3xqVeYBWvJb+UkDTHmYvpQlNPjQBS+aqHisT238owIue/qo33LetZdgf
 6cByVLZJRudjhvkvxaVLHbfTNq2WPEEbUnkHjgT9qjJkHFKLRoG7OsJ0BmXwq+d2po9NO
 bQUwRlvnifPfSO9gs05EqLu38DhwIj6xt8i/L1BaA7Zuvhp7HrjZz2gCXRVfFYAxP3mfE
 hZ2xW3TzjI/qjHMF/GRj4o1RshEux6penUshPDxCtDsEhw2TaTkNLI8infV+d0+yG3g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790951273;
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
 bh=fQaKaytV0Mqq9ms2aR/iMJ8ZofSKHVlPC+XmqIhajhA=;
 b=L1prDC7NlLPqNY5w+3KTEkFDEd9gujrE+qqti0E2GIP6spFeZVNfj2BdVOuM29QVHFuH
 oMQ1mUjbPaBkPataiZ5nqZ+FjHnVvJV5C1zAAraLoch5XnQ7TabhRLMVeiBZ7N1dCv4NT
 tsRjOFqLNa/RJJ2tojrH/overv6KicH7N0NTNWPx+hNyalXFw8GBZAKMsxb5lflDLXAHm
 f0ru+xzZnaslo7ZFUJxywHB0whv+NLTCGwDD2M4qatp20oBAK9LgfcMhYPScZbPJE+rwn
 Qgt4UlIapWWxdrk32bU0YaWqU939TBPD7mn28Zy+9XfOsayTG8tAs93hLQoSVYamLDA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=cherry.de; 
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=OmuW3ZlR; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=OmuW3ZlR
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0A62B810D6
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:27:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q1qVEt0IjZWCZ4DtRDdZikTRlRRfrFELZp540vwnjvIjX8pQ32wroIt7VCll9QWLy+ZM/9E0YiI/JbFLAGiyzYGhySaO7lMxuybsM+25HEncQ2P0Qd+8NJtTrkNn/8Jxr30DkMDwZTjM/iWnet0rBsIXQa8FobTZYiAvQojR1H834GrHRLMHb/Gjr6Of1dWPqJhlbxYqlpKLsV3C/ojy92B8nDCLWy9814NkQEOdNc60i1Mxf57uIolcQ3nCe8OTQ0kMmuuj1dDV/jalQ52YB/GL3VUdGq8fCPwetNRcBnOAH74m5+8JAqkWWmuRZmWZERTQbPUxffSqmLYhzNV+LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQaKaytV0Mqq9ms2aR/iMJ8ZofSKHVlPC+XmqIhajhA=;
 b=uxE4ngrU0Z9sQTOJ7WXME6D5IqF8e2CnnTuHTOjl9yB9arYRM5h0H5uDN7Ra1g1G09Wl82nnnigAUiZyOBqyH2PN0PLqjleHyoSzdMoLehmaIn/t0zSr6vCVOH3X8v+uYYHUL/xioVMAMR3LePSzYvwIN3sh1obvrPXNP/4FiyDlV0mNLiNDM6JJp9MnBODliipWpKpkshV2x1r/I+4c5x6nuc+5LzTRzHulf0KwNHvGKQ7GHKEo9f17yf6UKOzXbjIpm8GLADj5CMH06v5Z4LJaCf1fRWpDm33n1BURCU940IjRF2m6eVvdAZIY5sDEUSQAGvjVPlZb5R2V6pI0bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQaKaytV0Mqq9ms2aR/iMJ8ZofSKHVlPC+XmqIhajhA=;
 b=OmuW3ZlRYqbhXbH/6vcAMhiNrUPh746iXouUinGghCOayGN1/FCDOl6Q5pd75Cy2ocK9ACsRbPDnMnsT6dXzwP/085nr8jxDQLooM9UkuR6BQhOaWiyZC58dFh1GzqzJXnCpr2BszKueWeT/+4AAFw+Q191UmQhA+vFYHLhydlQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AS8PR04MB7784.eurprd04.prod.outlook.com (2603:10a6:20b:2ae::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Fri, 2 Oct
 2026 14:27:45 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0451.022; Fri, 2 Oct 2026
 14:27:45 +0000
Message-ID: <856096d9-a21f-4d29-9a96-f57842aceb63@cherry.de>
Date: Fri, 2 Oct 2026 16:27:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] arm64: dts: rockchip: rename PLDO regulator labels to
 match schematic on rk3588s-orangepi-5
To: Dennis Gilmore <dennis@ausil.us>, u-boot@lists.u-boot-project.org
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Alexey Charkov <alchark@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20261002031334.3285687-1-dennis@ausil.us>
 <20261002031334.3285687-3-dennis@ausil.us>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261002031334.3285687-3-dennis@ausil.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P191CA0010.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::18) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AS8PR04MB7784:EE_
X-MS-Office365-Filtering-Correlation-Id: 62a60bb8-ab6f-46e7-d83a-08df20915373
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|10067099003|5023799004|11063799006|4143699003|3023799007|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: HurnP9GkbGT8+KLpa58CQkuAkCbwITrRnW1KX5cza0ys/XciATir/ExQLkX4pkG83i7X1pNDPDEIFPIXCB0bZSDvS8xximszaWBxFF+k3XSc4t3VLbx4UbqByv7X/CxLP27Gy33kyFik/QJ0qs1ZKcwh5fBxOIqoEi0c/heh6oQFoL/fisoEYs0T0Bk4EBaudXoLhD8eQD89PtoEwYLq0YTB2qwNn5SeoREMcToQQUS9ryIbksHCaEgRZvlFMAPJDCXoE++BIVJq6pOLKcQ9wIuZFULVIk9hYDOKLz9Ezpwq4DOSWMRkcU+E86R7Lv8IpbDYqvR5cc75EdqrCVW+txIWm0Z2B/tKgr05sIb3tQ7aBluwN2PMjTS8N+4C1soxuHmh4W0cQNSmCiST3CkPUE7bMBCRe/KCZlJoaDa49kfoDzad2Dg4KpsR4N46QNRZwm1lLx7AdZK9iG+eKPgacpbUs4mnHkWRHlCO/XZur5jMtRKhFnwp8MzOx+j4y7YKAEkWOLr2vQWjdu7VG9KdC0Prpkmy36gAJR17cu8OvDvBRoiKdeb0jPKtvrTK9rVB4/yNLtp7edWKbQ9HrKFMJTqssFszu0Vkwmsb0eAM/vudNgYYzxL+aXMdkoCfgdeQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10067099003)(5023799004)(11063799006)(4143699003)(3023799007)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVZyVGFnM28rdzZpeEFoNitGTzJnTlo1Y3NTRjVrdVV2Rk5EeE56V3duUEZi?=
 =?utf-8?B?ZXhydW5BSjlBdFBEczduR0RpNTNTY2padXpqVm5VcEdiQ3FHYmNPczRXeDQr?=
 =?utf-8?B?QnNWejR3U0dHQWZVNWdrR0pIS0I3NWRNY1pTb3U0RzZQa2svR2N4VkllbFl0?=
 =?utf-8?B?cUJieDJnTzJ1c3BIK0Z6ZzlNOUhmUWZXMXFGNWpyNnFydG5DTExXM2Y5VVBz?=
 =?utf-8?B?UmFHV3VrOFNraXNjOEo5TkIwNUZxclY0aDAyMVBxbkV2dkxvdTRMMStNV21T?=
 =?utf-8?B?OS90bGsvWTJEdUo4ZG5uYmFRTE82TDFZM2tqM09nZG12RkJ1THJuNGt0VGNE?=
 =?utf-8?B?MXJFTlp1VllBd3JuVE1xMzNkbmsvN3BiYWVaU2pVejdwdElSRlhlWEdLNy9q?=
 =?utf-8?B?VWdrWnRhcVhQUlVtUFVtZ1pOYnpvTTJZbFBNRzladG9oODdVWFNvZ0ZET0pU?=
 =?utf-8?B?dE1zenZlV2tZUDEyMVRnRHpHNUVJeEpLUUdyak9xRkVKaWQ2WG42VER6L2VS?=
 =?utf-8?B?WHBtejlwalY2YVhpc0Jvamg2YzB4V1crMFlpL1Q1WThhSU93alp1aWdrcVh1?=
 =?utf-8?B?cXBkUWlKaEVCRjJyQzdqc1dMN1dPclRaTnU1L1huenNvNEF3elFGTWZxQUJy?=
 =?utf-8?B?OGlsR0N2ZU5SNjBreVNsK3RrTTBSZzJTRXlWMjNnNHdTMVlTSXBFS3RoM1g3?=
 =?utf-8?B?dzhWUE4xOXJRYVBiS1pnWTRxTFk4MUFzZXdhZXlqZzRJMTkyVlFvS09DZUl0?=
 =?utf-8?B?U2dTMmVIS2VCNU9yb1RkSTRqZ3h0RXVxbjc4eEJpQXhaYklmS1d3RUxHRjVX?=
 =?utf-8?B?dWgvKy9DYm9RZ0RoRTJDT0FEOTZsdWs3RDhuSVBQcWs1MjRvVXZrYXJXbE4r?=
 =?utf-8?B?bFdvOVFqWFpGaFJ0N3MrSUNXVXI4VUtzWnpXSStHZE9VdEhsZDg1WG8rVndM?=
 =?utf-8?B?V01VbE9BejYrQWNtcTNsZmp1aUVUaG1DdlgyWlFyRUF0NUtGVjh2TTQyUUNG?=
 =?utf-8?B?TzdYUzNxcVJVNldmc0VDM0FSd2ZGbXRrUUloNkFVcnZRblgxU0IxU2hCWEJE?=
 =?utf-8?B?Z1VyYlRpaUxCOU1VbHlVQVE4VmxXNGdRcm91cjRoQWpFdDlWTSs3UUVoS1ZQ?=
 =?utf-8?B?a0tidUR0VExpdFJzQkYrZjVrYjlFN3lHVmNHVHZxM1RvKzZwTnNhZUoxZDB1?=
 =?utf-8?B?bUFnSlY0SkdXaDJNUHpKQnluU0YzYmRIZ2t3Q2labnU3bm9uTS9FeWpsOUZr?=
 =?utf-8?B?MjdRRXBlSGZOc2ZURml5TDd4U2NvWDhtSEpqWi9lTjNFYmNRZlVGTlJUdzd5?=
 =?utf-8?B?NTNqdDVFS0wxNm9KVjhLbFEwQUlILzdoYkZOYk5jc2I4M1p3NFQzVWpiaFJ5?=
 =?utf-8?B?NlJnYTBnT1FDcmpLUnRWc3V3SnlINm92T29PRVZxRzJCZ0hGUFhDUUJGajVk?=
 =?utf-8?B?WVo4d2tPR1cyYlMwNzVNcTRQRGdHcVd0OCt2WDh1bEJYVUdtTWxoQVhCV3Ft?=
 =?utf-8?B?K2FjOEhzTERkUi90UXA1UmRJbUlIeEhMbGtsNytocHVIcjZqWUZERGJhY1U3?=
 =?utf-8?B?Sk40SElENTBJSXNGSkF2VzgrajVyekM2RXJ2RzNwMmdINWcxUzhBb20wS2NE?=
 =?utf-8?B?L3JBWnp4VW55a2Z3QlV5eXpRNUQ5SkNFOFd6a0xLSFJEalE0bjRtbHpWazF1?=
 =?utf-8?B?UWFIanRnSi9saXFaRW1zWjJhVW9scUVZZ0lIQUs0a0FCZEx4VG9HWWpJZGNa?=
 =?utf-8?B?TEdZUkdhcmRsenYzUng5eER1c0RNUE5xQ0FSZlEwT3ZGT3oxMGRrNE02Titx?=
 =?utf-8?B?cUVPR2dJRk1YQytWRE92ajRZS2EwSUxnTFNnRW5nV1pyV1VjU29lbTl6blI5?=
 =?utf-8?B?MlRSZ1g3d2QzdkswL0Z5L2tWNTh2Z2RNek02cHlLdExCeXlacnJFb2JPMkxY?=
 =?utf-8?B?RFl5Ni9JT1gxNzZ3dW0zcHhKb3Awc2dVbUtFU1lRRnRUTmFtd1dCT2ZmMGho?=
 =?utf-8?B?REdSQ0I2R0V2WlExYUo3czJick9ENzZqY2NoYWlCbnhsNWVUQ0hyeTZWaFdp?=
 =?utf-8?B?a2VkY2drVVpmVEdYSnFkNTl5eU52ZU93Mmk5aXc4RGxmZk94Sk5QZzljamNW?=
 =?utf-8?B?Tm1DODExMmRlMkNmeVNKdFdtL1o4aTNzMHJaRDBvNGJ1SHRveW00RkJYaVhs?=
 =?utf-8?B?cEVvWHFRMVR6anZHcElIRVM2S0lpVm1WeVYwZGdSdnBCQnhMclFKbk80ZGhl?=
 =?utf-8?B?YkFGaENVSmYxYTRhcC9XY2lOQlVJL3I2cWpqUi9HU29ZU0toaVVJRElNUGRE?=
 =?utf-8?B?bU5ZNDN0ZEE5ZnpaZXNDa0x1TFprZE81UGM3RnU2KzJGUkFIVGoydz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a60bb8-ab6f-46e7-d83a-08df20915373
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 14:27:45.3407 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9gx9XXQUIbGbXUCCBc3n2W9hhzYPV4BO00W6DPN8LALxvy2/yqSjH2slA4MPllrY/++68dY7p4fInvnXCs23PkXQxWs1j8YzfPdELEL300g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7784
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

Hi Dennis,

On 10/2/26 5:13 AM, Dennis Gilmore wrote:
> The Orange Pi 5, 5B and 5 Pro schematics label the RK806 PLDO outputs
> using the pattern VCC_*_S0 / VCCA_*_S0 / VDDA_*_S0. Rename the base
> dtsi regulator labels (and the es8388 supply references) to match:
> 
>    pldo-reg1: avcc_1v8_s0 -> vcc_1v8_s0
>    pldo-reg2: vcc_1v8_s0  -> vcca_1v8_s0
>    pldo-reg3: avdd_1v2_s0 -> vdda_1v2_s0
>    pldo-reg4: vcc_3v3_s0  -> vcca_3v3_s0
> 
> Also update the saradc vref-supply reference to track the pldo-reg1
> rename. No functional change.
> 
> Signed-off-by: Dennis Gilmore <dennis@ausil.us>
> Link: https://patch.msgid.link/20260511025352.106126-3-dennis@ausil.us
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> 
> [ upstream commit: e3132dc1f4ebc9dd28ef9108f2aac84e5d4c5a15 ]
> 
> (cherry picked from commit eae11c5c68fda07dca1c855c129c5630408c1aa5)
> Signed-off-by: Dennis Gilmore <dennis@ausil.us>

The line number in the hunks are different compared to upstream but it's 
because of commits f2f73e3c2b6d ("arm64: dts: rockchip: Add 
frl-enable-gpios to rk3588s boards") and c1fbd20a6e96 ("arm64: dts: 
rockchip: Add missing pinctrl-names to rk3588s boards") which aren't 
necessary nor adding anything relevant to U-Boot, thus:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
