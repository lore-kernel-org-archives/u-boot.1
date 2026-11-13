Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19F6606A330
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 17:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zqDFEO0t;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=bxmmybEQ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 904C260D6E;
	Fri, 13 Nov 2026 17:55:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S63SnQHMM57o; Fri, 13 Nov 2026 17:55:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E86C260DA3
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794592536;
	b=Gmk6U4Yxcu7UL5FTO0Vp/02Q1cRNO76udhQrDsXEsySxAfmVkCEVRhTJx4ldlXPGjYsz
	 odMdFLCh9CGcksVIK2trxPQ9rYHGeOWyWtLf8N2tZqhBgYBdJtdpqQGq6A3Zm78bRLlN9
	 2miluAf5QHz4wvefZGEA60Kt2tl0z8O4+NrWquDd4zDUNcEclLUN2yWRC98dw1qCRfx5I
	 M5+lAu9zzCMgQC9JVk7p4SeEDtRsTDuqg3SJrfzEVogk2EtdL/VhIHDa9PLcIrp8AcbHv
	 wZNS1G+ttgemVEGhKum6Zi03LAIVCFIo4fxo9BvznFemjiESQxPNEgsX4XOxGBe5Lwg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794592536;
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
	bh=HMwNzn2UqYJTj8Jd/bLwAoh105KjgfHZhWhklJP4BzY=;
	b=aQn4X4rs0wDEYtlr/DN6VeyomAx2I6Wl1FLnxCCkffsJDil46o4P/+wcWv37VIBWa+T8
	 VYLQXmj7lGSvwxtD+c4/Iv1DnS88CvM9Z8U+Drj8JRyrmSUTjD7zy6gb3zwHXmnLsNWEc
	 ygoqhQ/WV60YvZq1f/m/Dtf6dGIXPBvbcerNHVWnS1MqRtSNff8ZndS/U2mRkNvWaivxG
	 VMuamkNRYOI7U841r4i3allJfWcSeGFzNehTK7n2fWrdJyEXc/ppbRyVJLWk8BTZuiSV5
	 1/R7yz6JzL/S4+KofPbcFybXkG/oUGyBHCLFvvYQ4nKeEFDSdq9pQ0wPMomydBLpiKA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=bxmmybEQ;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794592536;
	bh=HMwNzn2UqYJTj8Jd/bLwAoh105KjgfHZhWhklJP4BzY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zqDFEO0to5y4IEuJcUzmQpJMBjEV/k4XY10Vizz8PTMwavmDWgQ7KTmwx2Cw1xhs1
	 g1/sFJxwEjoEZPAz3h8QWyj4IlQlucdqLZkXBx26sjlkGV+0sTD4BugAwLwi5YDW75
	 rIkk5CAVwguJWUquWJWNKYzC6xd0JAwkTKNbq+O57ZfS1ctoKABZvhXvc/SRpUyad/
	 kfiadTwpa8OUWLGSCsRNv/FjW5n5jy7RmqggJz+D7tcjScictTtGd5uyWPUVU3btmL
	 auEIqpSCNTj2M+zeY41QiAvvaCLEl9qBC2YEZPxUxPu76lNTVm2T7h+LrqwHwdRC66
	 6Nvt+MIgOYmVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E86C260DA3;
	Fri, 13 Nov 2026 17:55:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 58DB82E5
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:55:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3E9AB60DAA
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:55:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rZa8MzCytwap for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 17:55:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7A0E060DA3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=bxmmybEQ
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7A0E060DA3
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMwNzn2UqYJTj8Jd/bLwAoh105KjgfHZhWhklJP4BzY=;
 b=bxmmybEQcwjgcuvC3Cq2lZhoVeZmWrm1N44NcZyKIV/ZRf5/KcqqQIaIdXPI0RwH3yIJdaTuAjATiYyqvEGpnAvZHfhrqFStpCEvzMbe0y9KTM35+rIbWNaerV8+Ifhmg9I6HJJUqhWUn71y/ScQSh+lTv5l4acksyaQruhS/ts=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by PA6PR04MB11780.eurprd04.prod.outlook.com (2603:10a6:102:522::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 13 Nov
 2026 17:55:29 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 17:55:28 +0000
Message-ID: <50a9645b-d902-40fc-91d4-757bbc55a9da@cherry.de>
Date: Fri, 13 Nov 2026 18:55:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 22/37] clk: rockchip: rk3576: Fix CLK_I2C8 rate change
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Elaine Zhang <zhangqing@rock-chips.com>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-23-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261011222930.1085075-23-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0177.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::34) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|PA6PR04MB11780:EE_
X-MS-Office365-Filtering-Correlation-Id: 253438f7-4e25-4881-26d4-08df41af4d7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: NTtOBjrN4YHqNa53uvdgAUoEAXZV9VBY0HKMB9ACGhIhqX6XIUIIzHSSpkvNe510JGd7no85TAOqH3manPiZVI78uHnsam6SrRlsfciK81doEb1FBIr37wlTzNVQDVKezxcKnTfsIs8qAcKiRorfZm1Ol5IaTfgrmh0G4dRZcvc94qLNXs33AqqySwbPP166LYB9Ha3Z+5UsLlK1DWEoHojmuDYSFmN/dszshmBVIMBBhanNcGdzcluIJfcRss9TeuCOkyu2vGjj+wZLQXIv+tjMUtbbPF3tAr/amcKorDKPpvt2Mqr6jPRPQKGCQLT9/bauk0Zz3ci/sBkZ7LR4hL9b6rai6XVyYmkdAEdwBlhjqwwVDp0kp0Je2pYRGAOq/scvbU6t0yhOAePWiteN569EhjlX8Nzg5FpHAtFWnHWviHdBepPtWU4dskgG9KutXxW/D8pSHBBmn9FCFdxlYX7cCFBwU4b3pOlzrYMAwVJeGZSbvsjStK5OppMNdGcvbn5YNGW8CpG+4lauAkq6VTnEkQsNVkVP6kI0lFF1AsoYh+4FqMEFqfoeFMKSrMMb4l4U6Q+F2givossybIxBEt1qqn9GLCNrDgmHgLSyhmZR+bSJU2FbsJHHRdGoP8oc9zDNw2aiO7d0Of8b7cgLH5ybAm4k6qS7FWxAk6Me4tM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXJHYmRCck1malNTV0s2R1dGUlZYUEhEQjZUYXZyNGxOV1lKNFRZWkZZWVFX?=
 =?utf-8?B?Y1NEL25QWWhzVGtsV3JkNEs2MXl3NWNCY2RyZ29TV3pJWHRHZVR0eVZocS9N?=
 =?utf-8?B?bWhKOGw1bTRVWWU4Qjk0V29wVTNoKytENW1MWXI5K0FTTzNpaVRyYnhlMWRt?=
 =?utf-8?B?QU9LaXBTWVVKKzREZ0VtSStDbmx4VC9yMFhDZmV4TVpsODFZZ0d1SkhUY3o1?=
 =?utf-8?B?VWU1eWdFQmRIZUVjdHI1V3ZlMUJlVzlIUnZwOTUzQTl4MVhNN2pPdlNIVWVM?=
 =?utf-8?B?VjMyNGFjVGJaUHRucTdzeEl5SktndFhKQldHSERiOExEWmZIU0YxVGNUaVl2?=
 =?utf-8?B?RVZLcE51ZHk1RWZHa3pzRXlGekVhMXphTlFLTWp2anBUc2dvWG90dVhLZGFN?=
 =?utf-8?B?dVVuc3BOMDUrWGcwcW5oN2doemFKcC9wMjR3ZHNKOFFVd0J3SGUxeUVTNmto?=
 =?utf-8?B?VTFRd0diUEJhT1pkUy8yejBPV3g5Qkc3dk8veEF1OGJLaklhRXdWTFhMYUpC?=
 =?utf-8?B?ekMyWHd6aC8xVGgrTkxJeDlzemU0REhhQUl5NUd5Vk5RVlNOMmxsd2hEM1M4?=
 =?utf-8?B?QStKaitXaFFZYmtQMXZzRWpaaEtSQkh6WjZSTkZMOW91ZUVxZnJpZzhBS0Mw?=
 =?utf-8?B?ZHpXVFdrVWRBak5taXBKcjFCN2YvUHI0cWZRTnNWREZZY0dGQUxXcitIRkF6?=
 =?utf-8?B?V0YveDF4M0RYK3FqZ2lHZUpBMzhBMVl4cnpHVzcrVWV6Tk5kSlREcnJvVnJC?=
 =?utf-8?B?NUt4TmRTTndvam03ZzBWTG8zVzB4ZmlxR2V0dDlnSlpQajd2T0hpME1KRWo0?=
 =?utf-8?B?eUJOdHdHOFArRXJ3VE0zRGt1N3ZyMXVFNDNKR1JWVm94djdTdndZNnpUNUZi?=
 =?utf-8?B?eHpMNjlQcWZxZVU3cnhJcGw3TUdzSjhORE9VYmRXWGtvaWR0aWtUSW9BQ0or?=
 =?utf-8?B?a2ZqN3BIL2YvT1U5Z0Yrc1VJL0F5TEc4NGhNbWg2eVo5NzlDYWNQUEpXTGJ5?=
 =?utf-8?B?bHg2a0NzWGFVUVVyaGtoQW55TXgvYlo0aWFDait6dzdnQUtrVVEvM1pZbVpl?=
 =?utf-8?B?QjRNT0N2UzJPbmREdnlpUHBTMW13Z0hrUnNYQ0JPVjVVM1hhd2JPbWRla0tT?=
 =?utf-8?B?VlB6Vk9zV3p2Z3h1aHdwUXpGNVVvRHZOSlZSRXE2RThBakJralROQ1MxRHlp?=
 =?utf-8?B?Z2hkUHhJMWhqanRNN24xSlpjTmY0MXJHVDFwcnVqNTlkSnR3aGhBWUFYdHJ0?=
 =?utf-8?B?TVZNRGdUSGNDbHN2SENycFNqdk9tdUhJcU9CNHlweHdDeGxXNlVia0wzdWhB?=
 =?utf-8?B?TUluMGJuNHk1Mk4yNThMeHFwaGJPVVkrY2xwVHBwM1liL2xjaHNOYnBOTjRk?=
 =?utf-8?B?Q2x4VHZHZytxdGZWdXd4UTlpOEFXSnJ3UllWMHF4dzJvblFPQmNYaUtpcEJD?=
 =?utf-8?B?Lzlxb0xLOGtMK1dvQU00UkxtcGM1cm1XbjVQTHdWdG5DUzQ3QVJ3cjRaUTdY?=
 =?utf-8?B?UThnQXRoeEVjcGlRNTlORUh5eWZkMWVUbWhPbysyZzl4Tmh2VFJIK3MvTDZK?=
 =?utf-8?B?ZitPcjFkeWVRTEx4czUydXE1d0MyejcvY1NKbWYvOVZoMVRJUnNCWDJZdlhV?=
 =?utf-8?B?MHBQVmRjRnl2STJmRUoxOUdTY3ZqeitwNFR3T1dPL2pqYzM1THpjeXl3dzJF?=
 =?utf-8?B?ZUNkTXZrOXZNeUZZaEtxYUp2S0ZocXRTS09uOGVML2VzQWFPK1IvWE9ZSzN6?=
 =?utf-8?B?eDJxcDJvZVlBS0d6THhmSkdpUFA4QlA5L0dOS3BNV0J3WHd5VlIzU0Y3KzU1?=
 =?utf-8?B?aGVXM2NWb3VtS3Z1Z2Z1cno3VTdlcC9HUSt3N2VaM3ZCZ0VKSElxWjlCSDh5?=
 =?utf-8?B?WUFLbEw1NDh0Uy8vWUYrS3pkLzVPSzdjZFE4cVZPQ292ZzVsTlY0Tm13YklU?=
 =?utf-8?B?MER1blMxdjd0dlNScTVLOHp6dzRLQkVKVzhRTnNYaE1nQTliODFrejd5NjJp?=
 =?utf-8?B?RzgyL3pFaUdQc0lpMy9QejB1YU5MMVc3TE5NbFN0czlBNm1MUm14OFVOUUFv?=
 =?utf-8?B?OGE0YTVhQytmT1d6T1VVMUdtMDZnZXBPM05KWitZdlR6SFVmMU5CcTNNOU1O?=
 =?utf-8?B?bXJoWEROYmFBWVlqdkM4YlhKdjdwSlNTTXhtSXJMdU5jM01iYitTWkRWN1Bj?=
 =?utf-8?B?NU9iYXN5T0lwR1Q5ZzRTSnJyZm5Tdll5MHRIcGsyY3VMYk51MEQ2eXR2Vjlq?=
 =?utf-8?B?QXg5bnl3b0NxOEVZZE9VSFRkMDZaeUZQK1d3eE54V1UrL1FxOWtDUFp0NEgv?=
 =?utf-8?B?eVZlNnB3bmtZQmJ2cVcyK2Z0TUlXVTlFVmplcHFReGkyNEEyUUFWZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 253438f7-4e25-4881-26d4-08df41af4d7a
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 17:55:28.8323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VAdV1hC17ImdnPAZi5W7T6B8roCdi7G+7HfAZMd+Wqw9ngI/DKvfN6sb9qmNBk5DMuv4ip0zC7Y0c4dFeB279tvu7jl0N4LCS9N/RfYHPag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11780
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jonas,

On 10/12/26 12:28 AM, Jonas Karlman wrote:
> Add missing break to prevent rate change of CLK_I2C8 to fall through
> and also affect the CLK_I2C9 rate.
> 
> Fixes: 3919310b37ec ("clk: rockchip: Add rk3576 clk support")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
