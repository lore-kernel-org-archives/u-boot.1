Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D467C44529
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 14:34:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EADA640918;
	Tue, 21 Jul 2026 14:34:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MDpTXXhsiWs6; Tue, 21 Jul 2026 14:34:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1DBF4408D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784644461;
	bh=d/OT1l3AR9Elqot6woLaJYhQ1P1lV0azmOwaGY+PZOo=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=SGoN+8IEVqO+1f2bbbCOTP/ovKwgkt0ED7AoutBKpOH5Av1jqDsTHj0PQoXSeIZEo
	 iTZ4MrvOXbx4mL9rKLU3MVFOtHRt2SujKPevb0jU0VjH1vRsiwaPYaSzvwYH7aGVQ8
	 HHESR8XRUbgEWLXfLPDlcaqC60D4PD+DO3tyhxos4Y/Upzvpre/jq8w5q104x1fMWo
	 z6oMUJX0kGCv+ih1hwnQZ7ty0uTwr484c0Wz2B64PHt0+b/Y4HK35Cop4M3X0DLt2y
	 2A4d62qwyheQTi8jFldvjH+8QQzUO9HpRU84+B/ynXwNbp6Wru4UaDk2n5jfxav9d3
	 seaKisZe6opIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1DBF4408D0;
	Tue, 21 Jul 2026 14:34:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6400B313
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 14:34:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 558DF408D0
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 14:34:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u5UmWqpmptqF for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 14:34:19 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=quentin.schulz@cherry.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 0C01F40891
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0C01F40891
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0C01F40891
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 14:34:18 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1443084659; Tue, 21 Jul 2026 16:34:17 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9798803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 16:34:14 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQCIfHKFpkW/JNAIybqABV94+6fLtqn4WeOnw3uncTOwdelZYIFIKpd1SXLy9/YYIzLQKdHzw+xgu2HTZwLSKFL3sseagtQYsmfDJNzlgpaqs71NvWCQdHtXDrTyDu4jtOv/sjBKCY+l6t9/uROZYBlJiW3fT7gPoeryCuZGF3IHVAiQboK41P/22CfIeq/D4RHxHm72jOr91CjT7fDtnADMWx0pGwzLcVPHAYqZcWmW9YLZ7ziLxU7xbRg08SeP8i//SeqS/yrqzXrj39xbRJeUdc/zJ8OI6jDWOOH+mxMrHCF/I5EbC6blMvow19ABrAo0rROHpo6zH9H61C+BHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/OT1l3AR9Elqot6woLaJYhQ1P1lV0azmOwaGY+PZOo=;
 b=n+4TO5Y2wIOM5t9vMMqTgAficB1nD+75KDEBmH3eldulu0s9/uKUTvzFdgQ2zsc0jVMnK3Ae8Lgbtjc2eI39BE0Q9FUQJYemohQGmuUqDxTLAuNff+Xn0hxqG+3lMsngOoChUop81++mnMOvWrD4VQ+rcXPPVFqUaKo+3dBMARoG9RtA/2CZOhmOAuOkWEsw6gpYqbDR81bDA+fvABX2dC0umWJVLV0debukQ/BSj1HK3vE5tSeeB/zkMqUFjjPIlaANvFehMypjUGHlSgsbTAtaipJC65Fxa0qkaYWa0HpNlcYNieKYlDEzHWAxv1M/gWiAtZ8YWXPgwd74D6eMrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by PA1PR04MB10579.eurprd04.prod.outlook.com (2603:10a6:102:48c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 14:34:12 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0223.012; Tue, 21 Jul 2026
 14:34:12 +0000
Message-ID: <c42cd1f8-2a74-4ef7-a426-ad43ee038b56@cherry.de>
Date: Tue, 21 Jul 2026 16:34:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] clk: rockchip: pll: fractional PLL coefficient is
 two's complement
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.denx.de, Elaine Zhang <zhangqing@rock-chips.com>,
 Jagan Teki <jagan@edgeble.ai>, Lukasz Majewski <lukma@denx.de>,
 Simon Glass <sjg@chromium.org>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Finley Xiao <finley.xiao@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>
References: <20260713-rk3588-fracpll-v1-0-cdf47f2ca0b8@flipper.net>
 <20260713-rk3588-fracpll-v1-5-cdf47f2ca0b8@flipper.net>
 <153cd45a-b62c-4d3a-93dd-0dc94d74ddcc@cherry.de>
 <CAKTNdwFeUNxcVz-Jv1BGXRfsx7mKo0w9hTQEoEtFabfaco65vg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAKTNdwFeUNxcVz-Jv1BGXRfsx7mKo0w9hTQEoEtFabfaco65vg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0010.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::16) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|PA1PR04MB10579:EE_
X-MS-Office365-Filtering-Correlation-Id: 5014e9d6-13fb-4ea5-0053-08dee73521f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|366016|22082099003|18002099003|3023799007|56012099006|11063799006|4143699003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: nwCtNcDt5Znafkgdz+ByAm+TLupLfuXI1dHG5FYXZ/dgirWBV4BNGZWYueEkxX89vvyNjNKmaoSCRHSswzif/O962b0fLDj6TQnJQ8abGa7k+i/PfZH4HO1UmL8+q8es76uPntq0ZdNxhP1o+4yrwVQt8ctTsikVwjQYhkx9lK+TN3bHFBoW8WjaOQDzAWZ1Xh/ayUb5TgeAAQwi99Y95lfoPLOugEa4WayhrlobcyPJJV1HIBxDXRd0vdNWX5TalZDHGc9hdkX4BZgqe6HF42e1vQyUa/eb70DJwhlSEfvKsZrOpPjMPM6fbsDkNXMziY5NLORMmup9rCfinmHtwVffOzZLjGp9o+cCuZOuApDAtk3vpmHdobcep9mlWY+eyG5r7JD7d43HgsVqO+Ju8iDOCx2wBb1oXjuhALBkbkc4x3P76dq+QYDvczVzLXLrEjLxjaGwGpNt5fgTrWcNvZUB3ATCKxmP9YGGeoqL6YojEeh7YfSEVN00ksuOl23Qmlsvxpxz0zDtIPxnR7Hf2G1eqa6M56P6tQB/5LZBxLzSkBuI5i8vZkHx7DKX38xRskLIYa22eZ6MRnKkl+mcK+fT362MghL2iSXEjA3RURTxw3Upsdq/eCaA9c/YmnZJ5n4sfGMLwTHcbJA4jVlKLrtvNFw+rIT3LCreuFMKTQw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006)(4143699003)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEVKck9BOTExS2swa203M2dOR3REUU4vOS9vN1FqUCszY2toNzB0ZDVReXZt?=
 =?utf-8?B?YmZ4MUg0WGZjbUZjQlpTaDNvL2RTME15eDBKNlRjdDhIdVFwcDJUTHpBMlRC?=
 =?utf-8?B?MGhQYyt4TzN1eXlvSlpmQW5BcDNUWTE3MjhxdTlPYmt4OTBJRktUOWg1UjdN?=
 =?utf-8?B?MzR5bTlyWktPV1ZNSVEvd1lyZ1F6UnJydTgxYzUwTmJmUFV0d2YvMmV1aTRM?=
 =?utf-8?B?WFZKdm9mTGZxZHE1QTFRT28vYUhIT3ZkRnkyRnhlZ0I0SzNFYWtyL1hGbmtT?=
 =?utf-8?B?OXpvWnhFdXZHcjVLMzFGbFRvNEhmTzlxMkNmMzVtYTdCQkJJa2dBeGtramhX?=
 =?utf-8?B?SmtWT1hiS041c2hQUUZWendSQWorVlo4b3pqSytpRTBkN0NNNExpOU1vckVM?=
 =?utf-8?B?dWZaT1Jpd2Z2L3I0V201WGtvM3VkR0VOVWhYNDNwWDNzZWVmcUJ1NGt1UVYw?=
 =?utf-8?B?djR3YlN4K04wbkFGSWhhdkczRGRWS09uMnRQNmRvTkpmRzRmQXU3MG4wNm9k?=
 =?utf-8?B?R01yTGJhY1pmQ090clZGT3doc0tkcGJ6ZWZSMmYvMDRsYjdSUjMwNjNWZjdl?=
 =?utf-8?B?elM5alNCWS9BQlpmcVBsYVloYUJvWUtFN1ZCRVBtcUp6RDZGczZENFhWMDN6?=
 =?utf-8?B?Vzc4OE9JRGZvRkUvc0tJK0lGc3V6akZ2MjIxQTJ4ME50dmxUM1FTcFBFSXZU?=
 =?utf-8?B?QldmYll0Y0FjMU0zYUlydTNhNDhjdkJnWXlzTll2U3duSmo0TEFWWktLR3U4?=
 =?utf-8?B?cXFNa2JYekxoUjJzNXBZdnRXL3ptQU9UN3B1akVsWEt4Qzc2MjZITVhRbFZv?=
 =?utf-8?B?b1lEZkRkQUZqMmxQNFZDbzN4cWtLNHlmNFVPK2QzVkV6RGRVSzRBZ3JpdkZD?=
 =?utf-8?B?SnJQZ1B2VVExMlhMaENiSk1US2tZRGwzTGYyK05CT3QyOStBNmZqU0pkNTgx?=
 =?utf-8?B?dnZmUUFLMGM5cFRPWUJpZTFQYjZQU0RzdXA5akd6d2FBQ2FkZU50bHpTQWZq?=
 =?utf-8?B?cmc5bVkrSUt3QXJkenpVYUhZOS9xR1E3VVZ1R3RPT3RoRXlwb2JTczlTUW9v?=
 =?utf-8?B?czdrbW5icERBUzUxYWVEaXE5VFZUOHo4eWJhMGdIUjlyRkFIemZReWlpcy9V?=
 =?utf-8?B?VkkxZWZkdkNZQmJtUExnMDNCQkN2NjZpMHliQkdVTkVEVkpWU3FJQ094aTg5?=
 =?utf-8?B?SmFrdEp3bjhXM3dUNFZJK3kyZGp4bGNiU3FTNGFhZkNJaDZnVU1ESkVNKytu?=
 =?utf-8?B?dWVPUkhXV3NrMUx2SHk1enhvMGoxS0tNVSt2anA1elhBeHp3SU1VVERyamRk?=
 =?utf-8?B?V0VIWllYYXJYZlZrdm5UWHJjUTRSd0c0U2Q3MTFDQU5oQUNUODY5VGxXZHZh?=
 =?utf-8?B?dGkwSzhSZzcvdDY5bnJKVWI4SWdVYmw1TnpSVzh5c3pvYWNwSlNpY0p5Tjht?=
 =?utf-8?B?VElLeW5oK1IxNUd2UnFqY3hQakhuWTRKWkFNTW93YmJCMS84TnRrYUlURTA2?=
 =?utf-8?B?NWxhOXFYNm1jSW00bVhlZDVsNFJSVEdWQmQ1enpVRG5YVUZ2UG5maHRtbkRU?=
 =?utf-8?B?QTBYSURqa0h6TkR6eVFmdWlvNlJQWG5KSVJwa0ZFN3IrQUg1dlRIZ3IxSjN3?=
 =?utf-8?B?dFpqSWduMXR2Y2VnM0FxbmZWV2gxZEtNRTM5cWJDbVFZTXZRL0JGVldMR01n?=
 =?utf-8?B?eVQzdHJvVktrUldwY2dmTTJ1L2hPdzIra0pUdzZNZVJwZy9ZaVBNMUFGM2Zp?=
 =?utf-8?B?Z3p5aDE5eW1YWmRWdXlZYU1Dd2RrZnZrdHFaVFdubkY2UjRyU3JGVHZxaUkx?=
 =?utf-8?B?SWxHYks3MW02UG5Hei9Oemo5RnZJdkp5bGluVkdhRTJZeG42TDVBQ0xjd284?=
 =?utf-8?B?NlRxRHB6N3dQRU95N2cwZHpIRXJsbHRJRitQdVZxS05aSldObXVVdWIwYWNO?=
 =?utf-8?B?K1VrdjU5eXVkOXlIRHc0c0hWcHM0YWVzRXBaZW1KSjdncEhJQ2NUeWp3RzJo?=
 =?utf-8?B?WWZlWFU4a2ZVQ1d1T2dWcTlWTkszTlN6aFE5OFp4a01jcWlzaktJaUx0Wk9w?=
 =?utf-8?B?c2EzQm1oL0I1N3BxOFdxWTZUOEh3cHdaandhamZYV01PQ0czcjZ5ekd2WDNh?=
 =?utf-8?B?cFhpK25CSlllVHNUdkN0WjBRZFpObDZLZm1TdjAxcHliMmpaNkF3Y0J0VXlq?=
 =?utf-8?B?b0NaN0dmSCszbmVubzdFYWRSN29BS0Q0RllqWXB5NjJrQ0JUOXEvbGdLdDc2?=
 =?utf-8?B?WUlsbWhGalQzVnU3ZHc3Yi80K0Yrdks0Q0RIdkhXUkxPR2ZLRS9hS0VOSWZH?=
 =?utf-8?B?ZkRobDRhMnVOOVkzY1Y4Umd4UkduVUlIYzZubitPRnFNOVloME4zZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5014e9d6-13fb-4ea5-0053-08dee73521f3
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 14:34:12.3354 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1uygMExkOYhkoKSadbplZDYTITZo1olP4pDiFgifVQQSzIKNuqKdbeIbJXBLtj4U+Jc6z2iELIiSZD1DBVLlclKltzyvunlHSvFQh6BYvnk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10579
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/OT1l3AR9Elqot6woLaJYhQ1P1lV0azmOwaGY+PZOo=;
 b=nenWabNvxlGvwndiUfSBH6ezqkgH2SJBV3TFABbagWqEHuW7NGu8vcGRgsB53Q2hGuhaKpsABVSIelnqjwoN1vRDGY0YlgybPbqhOSU2C5YS93amBt+x8KFs0lS/teCpbLFV1ycni4vRsHg6VkWhtJ3OYNCwpBVUMQZDXms5E+c=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=nenWabNv
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=cherry.de header.i=@cherry.de header.b="nenWabNv"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
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
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <quentin.schulz@cherry.de>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Alexey,

On 7/21/26 2:46 PM, Alexey Charkov wrote:
> Hi Quentin,
> 
> On Tue, Jul 21, 2026 at 4:20 PM Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Alexey,
>>
>> On 7/13/26 8:35 PM, Alexey Charkov wrote:
>>> The TRM defines the fractional PLL adjustment coefficient as a signed
>>> two's complement number, 16 bits wide, so store it as such to avoid
>>> confusion.
>>>
>>
>> Yet...
>>
>>> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>>> ---
>>>    arch/arm/include/asm/arch-rockchip/clock.h | 2 +-
>>>    drivers/clk/rockchip/clk_pll.c             | 3 ++-
>>>    2 files changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm/include/asm/arch-rockchip/clock.h b/arch/arm/include/asm/arch-rockchip/clock.h
>>> index 95b08bfd046f..f9bfdfb8a6a3 100644
>>> --- a/arch/arm/include/asm/arch-rockchip/clock.h
>>> +++ b/arch/arm/include/asm/arch-rockchip/clock.h
>>> @@ -104,7 +104,7 @@ struct rockchip_pll_rate_table {
>>>        unsigned int m;
>>>        unsigned int p;
>>>        unsigned int s;
>>> -     unsigned int k;
>>> +     int k;
>>
>> ... you use int here instead of s16, any specific reason?
> 
> Yes. What matters here is the signedness. The table value never gets
> written to or read from the hardware without accessor functions, which
> mask on writes and sign-extend on reads anyway. A generic 'int'
> usually performs better than a fixed-width type because it aligns
> better and requires fewer instructions for arithmetic.
> 

Is the performance gain worth the potential confusion around int vs s16?

> It also reduces potential churn if this table definition is ever
> reused for another SoC with a different width for the k coefficient,
> but this latter point is more theoretical.
> 

The kernel uses a union in rockchip_pll_rate_table, maybe we should be 
doing the same (totally unrelated to your patch though)? It also uses an 
unsigned int k (still, but maybe you're working on that? haven't seen 
patches on the ML at a quick glance though). In general, I like to not 
differ tooooo much from the kernel as ideally it would allow to backport 
patches from the kernel and more eyes have read the code.

If all we care is signedness, I would rather have all s16 or int, not a 
mix. But if the kernel keeps using an unsigned int for k, maybe we 
should wait for them to change or just stay with what we have here?

I understand using an unsigned int for what is effectively an s16 to be 
quite confusing, at the very least we can add a comment in the struct.

> Shall I reword the commit description accordingly?
> 
> Happy to set the type to s16 if you believe it's more expressive,
> though; we aren't doing much arithmetic on the table values anyway.
> 

I'm undecided whether we should diverge from how the kernel represents 
the rate table (that is, switch away from unsigned int for k), but if we 
do, I think we really should be consistent and avoid optimization at the 
cost of readability/confusion (except if gains are substantial).

I see that the kernel only has a table of rates, and doesn't do maths to 
figure out k and it seems they store negative k's in their 
representation in a unsigned form (that is, values above 32767 to 
represent negative k's). I'm guessing we cannot store tables in U-Boot 
because they would take too much space.

I'm sorry this mail is a bit all over the place, but I think there's 
another issue in the driver. I believe we shouldn't check for rate->k 
before calling rk_clrsetreg(base + pll->con_offset + 
RK3588_PLLCON(2),...) otherwise we may not clear an existing non-zero k 
when setting a new rate. Is that correct? Not required for this series, 
but I think it should be fixed (if I'm indeed right).

I'm wondering also if we couldn't merge the loops in 
rockchip_rk3588_pll_frac_by_auto() and rk3588_pll_clk_set_by_auto(). The 
only difference I see is that p cannot be 1 when we have an exact match 
(the for-loop in rk3588_pll_clk_set_by_auto()), but if we modify 
rockchip_rk3588_pll_k_get() as suggested in another patch in this series 
to return 0 on success, we could have the function set k to 0 and still 
be valid. What do you think? This is further improvement and is not 
required for this series.

Cheers,
Quentin
