Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3293B606A331
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 16:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FRZr8bPJ;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=UHOzypw0
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C6A0606A5;
	Fri, 13 Nov 2026 16:17:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8-wgFK2Bh1Y3; Fri, 13 Nov 2026 16:17:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5734060658
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794586647;
	b=Sqekuywv/Drn8u77EyGU0cKK8N6HnTsa74zSHpjF+zcvhyFr/VjUuY3GPDGsSZxowLev
	 5WgiPlXDfqvpWapDHvWDB4EGhCzqQ5Z/MQhDQURS2a75m/a7/PgnKPkTffJg6QN2qzSBG
	 2Cg6MFHWqk2rkg7E+00+hn0uqJg3+CuZiwvkE1JMfWdMo+0AoYXWFVelGVKkOtpBHGzgf
	 v3fIgYUOaV15uB9sbzR+ZjqfrlTuh0LZMnPAHIfpzSxyU01riFNRQ6b8Ie7d+PZESK5nS
	 s+lZcpuVKwsQrcRhPF6GnKbnvKcR7W8wxc+PRdWEANTZX1N2wjQetHnss+uwyjCmp4w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794586647;
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
	bh=RnsLSS9t4iX9HctErLZaFt+0S8UFuNG50VO8eB7xc3s=;
	b=JcJdJY4MLeZDtnKiOfPIH5cdOxLWNw6794rNS8ESxSTTKtUupQsYKHgUiSqQOq46Mm+P
	 /1ZzCtc2gpdSjuFg4prnPFbMDuXgP9HChdMBvXeZfWf8G0R3wRobDDgK5LIfK9NnZd//D
	 fbVZaMCHwhLxT1vokjtXv/0/ZZfLebgrbqJUaZnHC+qBcUtBCgdXI20ik6KFdRGUhUkgX
	 kMuKMUuY3evDFUljmgWDd5G1pz4/zP5UqaHRSuk9YoU+Uzk0uSOZ3Q1TTJ5g9k+0L6t4v
	 kPw3pHqAXbwQkbSqohFnMd7p/PxykfPBLw5uDie+maEBoHWqWSbuwZ3eCbF6p/skWSg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794586647;
	bh=RnsLSS9t4iX9HctErLZaFt+0S8UFuNG50VO8eB7xc3s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FRZr8bPJ1J5Ft6acmQg6k2/FkaXdbyIPGGHXKHkRF8qeoaBvFp0ytMeEWGBOssFI8
	 usYe+I3xYlgH69V9F8KgS62Z/7dy/ILSlAYT6kqmoQIRek5YZ0RENqGYJTrYZAv/Dt
	 kfkscr4R0j6q7RWYplECqELDG/F95rNRc9c/hfdZPtnvX1okzMsSj+jg1KNDfCQr1y
	 DwPI9fExC9sOfELwlPP3EW7HmV+ZICA4NxpEyCBX4RiMAAO2BsYYy2ARjHJ/Sn1qvJ
	 rkjHmuE6a7oO0kmde+2gynoRZ8foc2DC3Oa6mbPO8ErELrFh/UrSmfReKs0NgZw7zB
	 3LQbKdEC5jZxA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5734060658;
	Fri, 13 Nov 2026 16:17:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 87431AF8
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 16:17:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8489340731
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 16:17:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id anSYWx-mb0T6 for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 16:17:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C88514072B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=UHOzypw0
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C88514072B
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 16:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RnsLSS9t4iX9HctErLZaFt+0S8UFuNG50VO8eB7xc3s=;
 b=UHOzypw0PWwJB5S1t4kxM/XEA9UaBGjr7Aj3GYGgFmS3NotH4GXCxhapTObqF3adSyJ2J1ngRiStecCX+X282nhOV3BebbLHVy3t1MJrciNXXCF08ZLgL6kVK1oIbB7e0Rp7zN+iuL2f3pCwnNTOyCpFS9bC7mC+X0wPFxFnViM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by GV2PR04MB11712.eurprd04.prod.outlook.com (2603:10a6:150:2d4::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 16:17:17 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 16:17:17 +0000
Message-ID: <dc4edb29-be3d-4514-b297-5d349701c878@cherry.de>
Date: Fri, 13 Nov 2026 17:17:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] clk: rockchip: pll: Fix fractional PLL rate
 calculation
To: Jonas Karlman <jonas@kwiboo.se>, Lukasz Majewski <lukma@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>,
 Elaine Zhang <zhangqing@rock-chips.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
References: <20261111222834.157842-1-jonas@kwiboo.se>
 <20261111222834.157842-2-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261111222834.157842-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0138.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:359::17) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|GV2PR04MB11712:EE_
X-MS-Office365-Filtering-Correlation-Id: ee17e534-7626-4d0a-61f5-08df41a195bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: DMQwWilmlwbjvcmsmrnmeNTHUHbteoWgcpJolV/uXDn2bekFX3pRRvmovdD1FRWG51kVhxysySMef2KL5qWmWWxxPPW+x6MHJQG+AzRyuRl/8xJ85uiD8mpZ7NLBKhAsKNarUv2yKB1h2ykl4camUEiiwTWqte0XBUNO1V2vfsD4NL/Nzu9Z7D1qxgv6EP+WEL1IDP0nIq3cKd66KuGwFEWQrG9/1RtXDZqkAoim64Fl7QQxf25+ohVt1auhSnIoMjwFWRvxuMdeuN8+eoGe7SKbaigk1ggQJi7n0vFThOB9HaO7UBQ2hydk+Mmx54jR4taVDKq8qL0s9RZ6E7CfgWKm/LdLB/6aopCQOAGmlrF5chLIXgvieo+0TRKoQP/ojoKr516cUshlpXc0Vm+L+HL9eEOv9fuLrcgQTbkFTnd84VhW0oxQM03bx21p5mG3ZCxII7mRrTUkym5Yxx2YvvFvmeEUm00T7pxQrWHD5wjVsDqisxqeCUbFSFasqI4TpP3T44QDy9FxbbUoOIVsICGjqHxm2WsHQ4Pz2r2qJfE2wR0QOfyi4nWzoa290atPnSFpR1NuJNEdNVEXH03iGjFCoDaB2GjeKIyFVu/z2bp8IDQb/9ykIPTD6fQiFPrEqaUfPex5bCeGUBsy8BB2beW+B7/6c1N2MlCJOlTmRmY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGwxY2NGVzFDV3huQ3RGR2I0amNHTzJCYTdBeFVlRzd5a2k3TVlQVkQxKzlq?=
 =?utf-8?B?L0ErMDJxK0FNQ3NLM3FBRGIzRVZyVEQ4c0dMRWRTRnQwb1FuemJXejIwVm8x?=
 =?utf-8?B?K25KOTBmaGE2RFphMW1TdU9oK095eFJPU1dpUWhUakYzVGJzUThFaXJsREFQ?=
 =?utf-8?B?NHZvQmRqZTZwamk5blI1THhTZ1piTkpNNENQUjVlcTZKK3pmajZkVXZMTVV3?=
 =?utf-8?B?TUduSDBPSHRJNThsOTV5MjRQMm1JQkpzUm1yT0tEUmF5MUhqallnOFA3cHlj?=
 =?utf-8?B?b2dSSnMyNEtDK25EWG9ETU1OQ3ZBM0NiQXZsRHVBcmczT2dnRjI0c1pLTHBy?=
 =?utf-8?B?MW5YOG5odGtaYUlIY1FBMnk4aWRJQ1M0cHVuenBpUXdFejRHRW5weTkwdldZ?=
 =?utf-8?B?SnBsTzBzT3pKbTNtb3dyc1JibDZPakJKSmdTQ09nZnkxUFgwVXY0MmJRM3RE?=
 =?utf-8?B?QXh4b1JNRHpiOEpXai9ibS9HWHdJM0szWTEydVF5M3ZWVDhITTV2OTF4T0lB?=
 =?utf-8?B?OE9RVVh4ZUdPY0VPdnlkbHlYTzcrNEdkS3ZLTk5Ga0ZnNmNITWk4ejNwb2pW?=
 =?utf-8?B?c2djN041UjB2LzhwV3p6bUQ0UU80bDNiM1U1aEZzT0FZWGxISWgraDhQSjNM?=
 =?utf-8?B?L2t3TVhrODkyNnM1NklXTXh5c1NRWnRBT0JoWHk4WnhrNDNPbzVTVkVpS1Fh?=
 =?utf-8?B?TnEvbThsSzZpSWEwb0ZUZ25EdGRhbHVRSDI2ZlJsQlk4VkJHYjJlMU9IMW8v?=
 =?utf-8?B?enA2QnBrVVR6YmhENXkxMkp5WVdMSUJuRTRYOWNjblRoa1VGelk1Si92QlpS?=
 =?utf-8?B?OHpoNnNnVDE3QkdFQi8yTEtEZ0NjeGFLbEZBTzNYSVBNREhBVFIvVlJ5NU9E?=
 =?utf-8?B?cUtsczAvVllHTTJWNzZ5cEcvcGNTaVdQSUpWVjdMS3piUWxacEZybU55SGts?=
 =?utf-8?B?YXQvaGFJTHZCRmw5TTBiR3M1QTBDWG1ZMDRreXlFMmEwNTQrVFU1MUE2a3NI?=
 =?utf-8?B?VEpKT3h3RmVOaDRtMU9FYkpJU0FaajM3Vmo0cCt6M2Q5QndJSjRPclFkTE5V?=
 =?utf-8?B?T3dzODR0U0Fmd1NHVU40SFBFRXlVUkw0SDkzZGcyTmdxYkZZWnJMUlVzY1Ba?=
 =?utf-8?B?M0dHSlJRWEhNSWhOK0VCTW5hZXUvYlVuSTBoRUZENFZGOUtnLzZsSVR0R3dN?=
 =?utf-8?B?UDVTSy80Zys1MVJERWlTV0F4NmNock5ETXhaaGFwdE1rVWprNU9YTzJtV2t3?=
 =?utf-8?B?SUJsL2NRaElCZWUxNDdFUHpxUFZTYWoyRTB1b2FxYjdRWnEzUi92NHovMXVj?=
 =?utf-8?B?Z0lFTzBxWHNmTnIzQW5lRWFWVmhIYVNHei9ka3JybDhxeXk4SDRja1JMKzFl?=
 =?utf-8?B?QlRPL2d4cGhDS1BQM2d2djdTMEp3YW9makNJZll2V1VadFNPTWY1VnV1L0Zl?=
 =?utf-8?B?Skg5V3hNUlhmL2N6cG1LNUxJQnltYVJxaHZ5K2JKdEt2ZTAwRTJTdnBFbmdk?=
 =?utf-8?B?aFVHOGRuSnJSb09mQkFMaGd0N1ZCNlA0TUZWZEIzOFBNZWpXbUZhNDBvaGJa?=
 =?utf-8?B?Qnhld2YzRkJyeXhZUlMwZ3hWcUh3RUtjUDRjTWhtL3dkZ2dhai9peStiQWxO?=
 =?utf-8?B?WUppY0NDRTN0TlArWWo0dmJZbkxrekJPQUhjYmRWYXJPWUQyWnlrWXZwMWwv?=
 =?utf-8?B?VVMxTlpKNEYwdGh6cXhmZUp1VGh3Q1VkUjRQZXAxSXc5bnhsVmd6TFYwUHlk?=
 =?utf-8?B?Z1BVdVBTQ0pDaDF5WTVKQVdOWWYwT1JHQTB0QzArWkthUlpSS2hxZThkeWZ5?=
 =?utf-8?B?elFad2dtdW5hVzNHdDhkS2JuRU56emxvRTBwdmxTa25wcEw5RER1Rk1TZEli?=
 =?utf-8?B?V2RQUjN5RzlsdGZZbDJjclJFbXRuUXk4VHZleENYQnM1WWthVFVXY0R2UnBh?=
 =?utf-8?B?TEFZVDZydDNkZEc1azRpUFk0SVlGMGRkd3JNNFBidWVyWTAraEZQck5rTk1C?=
 =?utf-8?B?K1BuQ3BSd0tpcWZub3owSkR6TWNKS3ZucDV0TEloNGpuRDBKZVNQUFMzYnNl?=
 =?utf-8?B?K3BvT3RHZUdXRkdPZkx0MkNUa0RacUxpZlpnbEovaTJhTDNtdm5vY3Job01H?=
 =?utf-8?B?bFRha1dST203L3g4NjFyN1J2SWRsVk1paFJveEMxWGxjYVNmLzlnRDFzZW9I?=
 =?utf-8?B?c280RkUvVUVpaDN3Y2h1Q1c4dmtEYWdadVB0eVpTUUhRQlQ1TkhLY256QndU?=
 =?utf-8?B?c1JDR1g3L2kwd1RCY1dsMDhSU0hYZENNbjVJaFJtaCtEbWI2Y21sKyswa2Vm?=
 =?utf-8?B?TDNIS2Y2R1RlWFE1L1ZvdXdYcnE5VlpDc2duY29aelRhWTNLS2Uvdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ee17e534-7626-4d0a-61f5-08df41a195bc
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 16:17:16.9961 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /doTKJU3G6+81kbyOTpjBv+WJ2Hi+Uus58Y7Hfb4y/3Xpx833CTKZrknzh80nwISOcmp1Y1ce0TITkowgAJtpwwUEf+SFa8Mz6YgCH95D4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11712
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jonas,

On 11/11/26 11:28 PM, Jonas Karlman wrote:
> The fractional part of the rk3036-style PLL rate is divided by
> postdiv1 twice instead of by both postdiv1 and postdiv2. The integer
> part also loses precision by calculating in MHz before converting to Hz.
> 
> Calculate both parts in Hz using u64 arithmetic and apply post-dividers
> on the combined integer and fractional parts. This also closely matches
> the Linux implementation.
> 
> Fixes: bbda2ed5840c ("rockchip: clk: pll: add common pll setting funcs")

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
