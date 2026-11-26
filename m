Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC8D606A323
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 18:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LgMLeRxa;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=JbbGTFWu
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D8B8960A8F;
	Thu, 26 Nov 2026 18:06:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p9UULAmbP3BH; Thu, 26 Nov 2026 18:06:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 03CF260AA1
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795716399;
	b=kVl58FP7G2bcXZihku6IwAIqwgUFfWHwR2mdRW6KDR/H0Z/rovEADgcSjOFl4IvjbhKY
	 5Q8sii5JDPYBEuezLzfgtZGv1GbdQarx2zc50/Jh89syMznTLdPENh89vVmlxyCgqrTV7
	 8dQdXYSiwWJvbQcFVdsAIdAuWXUuYGud2OwCbXssQr51L1/iycgLehAO+hpJQH2bHTNxo
	 +qcz4emELh3W+ERRd83WEdZmIgeIpNSgKpOUYQMy7WYOBnbWcXIJhl66SHzWmLJX22LEu
	 Jq5gFzwFPeiTrUS85DIj4NSVT0qb5gOPlykDhclWIn9opHlWkUA1fA1KppsZJ3+LFLA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795716399;
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
	bh=rMSO0SBZNiVvVdA8yCw/TGGQSWRoZ4jHByx8L+fbbsI=;
	b=YUd1ICVCsv6ylT6dz7em2xF4irqs9sqBTd5pHpc2aPGeXzteGBwiZC25udJRV7jPfhgD
	 hnosVEmphNH5qj6ZtHXiYUUM8xw0J53dpkPvAVUfVQ8EXPRhje3uplvYEyk1rWnDZx1+k
	 /L+reAzsMTPQ4wEZooSDkaZFMV9+f6Ls7z9UzGLbNK8iDhf4R7TXKc7p5owFSfwj9zMdv
	 2qfnvAzO50lLbs55pLNWJj6ZXmkXZz/tfTCUoA4FV/9xUgHbgmZKY88cgP28mCJbKqB5u
	 tZR6A32lcZouRWAFN88MAIwhjEOBn2+vNl+wkcKDXne9+mxrqJqxJNqOP07IfmjUhuQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795716399;
	bh=rMSO0SBZNiVvVdA8yCw/TGGQSWRoZ4jHByx8L+fbbsI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LgMLeRxa3ETzQDWEAU7U7tH9BLM/ypkLbkouxQi/MViyYmAGLaCGfxihatS/5bN/a
	 /9CinWzUWYAFVbzJROr4Rkrs5s84A2cUAuHtQQvKNRVqhtz6yEQBa4qdH5+P4L4sHF
	 1YA35BLnM2yB1X1zbi13Osav5VNT+GtdeNCAQOEwPTbNtdYS5MH/RJrjOjC4vtqhyu
	 FAhHQE2j6KqbQ5qNXm9ErreG8bHwXpd9Uakd0EqomgaAhZ6qKqqS5lBtbYaAuLNi58
	 H7Y7HT9jNiITcFMKNON7A7AwYnu6n/9pamtmFngQMbyjArJtz+fPfnm/NvsRLSeIby
	 DteRxlsTuRryQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 03CF260AA1;
	Thu, 26 Nov 2026 18:06:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4DFA210B
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 18:06:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3ED4A409F1
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 18:06:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HAPbl7mX7C6I for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 18:06:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 34831409EE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=JbbGTFWu
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 34831409EE
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 18:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMSO0SBZNiVvVdA8yCw/TGGQSWRoZ4jHByx8L+fbbsI=;
 b=JbbGTFWuqo7hA5zJQ8WZn//zYHTywMDY29jFCO413klxPd/1HXZme7YJzViPNiNSYiO19tnTq073z+wK9BOEis8VeTxIu9K7tpyV8s/4KwmqcCEPpWkdQHEcF00+gvS0Ir2eOCYC5NbcZnrcAw+k4sB6D7WLJR3B7K7k32YNioM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by DU4PR04MB12149.eurprd04.prod.outlook.com (2603:10a6:10:642::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 26 Nov
 2026 18:06:32 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 18:06:31 +0000
Message-ID: <49068772-25fe-49ad-b53d-0512a70d708e@cherry.de>
Date: Thu, 26 Nov 2026 19:06:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] phy: rockchip: naneng-combphy: fix RK3588 SATA
 pipe_con1 register offset
To: ricardo@pardini.net, u-boot@lists.u-boot-project.org,
 Kever Yang <kever.yang@rock-chips.com>, Eugen Hristev <ehristev@kernel.org>,
 Jon Lin <jon.lin@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>,
 Yifeng Zhao <yifeng.zhao@rock-chips.com>
References: <20261109-rk3588-sata-fixes-v2027-01-v1-0-e54ca8e68f18@pardini.net>
 <20261109-rk3588-sata-fixes-v2027-01-v1-3-e54ca8e68f18@pardini.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261109-rk3588-sata-fixes-v2027-01-v1-3-e54ca8e68f18@pardini.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0058.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:337::15) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|DU4PR04MB12149:EE_
X-MS-Office365-Filtering-Correlation-Id: dfba18e5-a178-4f95-441c-08df4be7ffb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|7416014|366016|18002099003|6133799003|22082099003|261009223027099003|261102123227099003|261022105027099003|260925021911599003|260925021311599003|56012099006|260925022911599003|11063799006|261028144727099003|261022075727099003|4143699003|261026121527099003|5023799004|261021121427099003|10067099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: OrghnC4IgCXjere8zYhuX+gl++meJGUZbQ102oYQEt1ghDWAalpzdpQzNnus+jFtDVmvaFQUKoDsy5l/sZ0xZwVBd2o9ZhhOrajHC/vwq1vywICbXOIm2lEurBdV3qT/Cr+de1nrVxODPuCXTOC29u7WuptiN6g9culbqqHBh9BlXFoYpoior6He1WrGqPXOmfkd9qkikztqTCRxpvR+Iea9699PzOPu/63BPOQrHb1o8jS+Mbl8Sui207oef4m1uNCVm6x06FPKD4q+MIb9YTWgACB7Ai5PVMgIfGNRbQ4EAHD0TR8m+rfndF6mQIdOAvqW81i3RH+XFJ428gwKXN9dLXYo0ujzLu5cNHlvx+t2wBAlqt1joJW+pHdkQsuzqx/X0iEwumWRRDBeJ0FN3ixM7qmiU9xwbTmE7r8OQhvoe0YVPt5uiwpzJOqSuQ2NX8HLFtKsXwjyr/g9UZYde7irViOdwSFxAQ2+jTwrDet1XItfM7kcMCE1b0ayeanm7WtcRn/si7sIHiTE9+QDwT/d2KS12GH/7bcM4gjT4l8WWS20ywJa5n8AKiMCYZ9MtFA0srladbRhvTRhBjFyluA7TbjsrgQ4WvUc9L6UyULN8pT0fF4DB408Z8mHt6yE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(7416014)(366016)(18002099003)(6133799003)(22082099003)(261009223027099003)(261102123227099003)(261022105027099003)(260925021911599003)(260925021311599003)(56012099006)(260925022911599003)(11063799006)(261028144727099003)(261022075727099003)(4143699003)(261026121527099003)(5023799004)(261021121427099003)(10067099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1ZMdG5LRHdBczk5YkRjQ1FzVWI2QUkvWUZqc2IxRUxSRUF3dXR3NmNnRk9B?=
 =?utf-8?B?SGVjTjg3RkhXZEk1b08xczNJSUd4OC9sZi9WVE1FMFlqZU1sa2FrZjZpZkM2?=
 =?utf-8?B?U1p0N1N1L0tBRHNhc3pmRW01SmdScVQzQVNDT2VQRlJkNWZRYkFKdG1LVS8w?=
 =?utf-8?B?c1FFRTdiTXlTTEVCYVhNSTBETDY0TEdLeW1oYTZ1SGxoL3c4ZndPRTdIVGIw?=
 =?utf-8?B?SDBud2xvem8wMFMrcWg5dkxFRDViY2t4OUxjSGh0aWViUWw2M0x6N3BwaUh2?=
 =?utf-8?B?ekJlTERjc3NwZWtBMEg1bG1oWDYzbWtxRUZjaGVLVjlVclJVZ3hPWFNHODRw?=
 =?utf-8?B?WjJVcjRLd3ZrR0NsZURiSE1oeWM0dUlrS2Y0Z0twWFZqVHpESUJhVGV2NGlW?=
 =?utf-8?B?c1dwb1M1Y05NRkI5MEIrdjc3VFcwbjdmeVFmMFdXQjJoOVBucTlyeU5oVGNu?=
 =?utf-8?B?a3E4b1VSeUxhK0NLNTdKcVFUU2pyWllUY01ka2hIVWlqZzVpVXI5SzFmci9X?=
 =?utf-8?B?dHNidXVqZ1JCcVF4TXlnYmZHRUJFN1VWK2txZXI1NXpuU3loSjJ5WUdjeDBj?=
 =?utf-8?B?OTZrdzNkeUYxNTdvWnVhUERjOEx0b1lSMVhBQ1I5elFSZ3NicFpnUE9oU1NN?=
 =?utf-8?B?RmEvUUsxcWtBdjU3SEcwMXdlclFNM0NsTi9NazdGSW5SYnRaMGlOVU5PdXRr?=
 =?utf-8?B?TS9nTXArV1Bla2ZudDd0NnBVZHBpR25ONUVOUlZMcU1Fd1NlNWRvNTVxTDZ4?=
 =?utf-8?B?czJoaU5QVDY1aDFXQkJrNFlvVVFTVHpmQ3hzSkp5V0kraEhiNEFuWW9DRWxN?=
 =?utf-8?B?aE1BU1VYY0VOTExzbGpuNTNzdkY4S2g4dVQwbnNRUGpLeGJHZHZMNko5MVE1?=
 =?utf-8?B?bExRWjRHVUlrazNXcGV2TmhHRk5pYkRyZGoyWExNL1E0M3ZOWjJlOXl0R2VW?=
 =?utf-8?B?eHNNbDlGajAwTU84bElFcVc1MGZHcThZb2tETk9aRTN3ZloyYWNFdVhQUkFr?=
 =?utf-8?B?MmxQUDF2MUNBMU5iTWxqbFloalRuUXV2WGFld1IzS2IwbGRJdm0rWStsMlhG?=
 =?utf-8?B?UGxxcEw0WmRLeU9RZ1hieDhNS3NPZmtTa1p5WE9ZU2YxSU9XbFFXamszS0xm?=
 =?utf-8?B?WVFsM0NybDl0T1NJQ3hMRnh3a0NhUHJ0TU5GajJMTlh0Y3VtZndwRW90NU05?=
 =?utf-8?B?eG03UkpBWVcrOUxJVGtrMDhvZHJqQ2E0bEhrNzZ3N2VuOWRnWjZSMEFiOVB6?=
 =?utf-8?B?dnIySEY5R1YrcHV4dUh3UldocE9kMjBoSFEyRlJaYWhmN2hDWk9OK2loN2Q0?=
 =?utf-8?B?blB4NlBNNTVzZGI5U1hxTFo0UGJYcHF4WEVCV2w2ZXBCRmxmaWd3WXdkQ0JI?=
 =?utf-8?B?THlSVllvc29qYTN5MXl2S0liaSt4dU5yNml6UnB4RFFURHNJN2JSaGlha1NR?=
 =?utf-8?B?UEI2cFNBWWp2Vll6cU1hdmF4V0dOdmFQUHBRR1VyWDJrZ1lXcUhmUUZ2MjZL?=
 =?utf-8?B?S2NiS3JWREdEbzdZQ1V4cEhUNUpQeUhNeWZzcGRHajFsTTJLOU8zL1lQbGlF?=
 =?utf-8?B?eERIaVZGQkJ0em1hK2pOQ2pZY0IvRHRRNXZEc1BnRTg2WVlOOElJMGdXdVpL?=
 =?utf-8?B?OEdhRjhZSW8rRzVtanNjMWxUaUNWcEwwMzRxSnVyRnpCaC9tNFhWVk5oNCt1?=
 =?utf-8?B?TFBMejdFMkhtMUQ5OHZxMVVxc0VmOVBwTDdZa0ttdUVqdTFZQU92cFFRZC94?=
 =?utf-8?B?RW9Dc2dWYjIrMkc4b2xJeVdrY0piQnNaZUFaMjd3TFBRR2YvVEJMcUZCWlkw?=
 =?utf-8?B?NjBLcjNPZ3Q3TmhlRzUxdkpTbXNiQkpsK21XUDdnU1RXNUdEdk16L2lqM2to?=
 =?utf-8?B?YmVSbFVOZmxHczh4WkwwMkphbU01OEVucy9mRHlSMHpCRFBLN1VpblZwVStz?=
 =?utf-8?B?TEFXL2UwcWZsaGZDcnhRYk94TVVKSjNGSFFYYktQWVpMUGNjNUdNNE1XUXgv?=
 =?utf-8?B?VktXQTEvQXVEclQrZWZEVGwyQk1sTFZCV3dLaVZSUTdiQzBZZmpETVl0M0Jm?=
 =?utf-8?B?OE9LTFNWc0JPTEwzNFN3T1psbGg2eGw4K1ZkTGx5LzlWQnhyTXN1aHRFcU1K?=
 =?utf-8?B?cTBzckFRUWtNektDSG5UeHN4cW03bGMxbUZwYkxpK2ZpN1c1eHdRWWsxMUs0?=
 =?utf-8?B?ZUpxLzVXQjFXb3E2MThUSnBQRktMRFBvNmhKTkJVeUhUWitmaHNXNExpYlhp?=
 =?utf-8?B?ZWZqUnV4M0N3VVZiMTNwYlFsSkcyN1FDbGpJVzRWLzdzeU55UzZDS2Z4U0JI?=
 =?utf-8?B?Vjh3RTdvR3gwalFsSDZMWUswNGVSdmdhZ3EvNGxWQlpCTi9CVHVrUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: dfba18e5-a178-4f95-441c-08df4be7ffb7
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 18:06:31.1633 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zKJYahHfBbIDsuyfFKx5EJRPBrRdmQIWELUnMxkcUX50y8whc41LtCr3osf4fznVIQ2JU1i+Czt/nBvWg1/STF9RTTSs7RDgnpBxDGl14lw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12149
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ricardo,

On 11/9/26 3:58 AM, Ricardo Pardini via B4 Relay wrote:
> From: Ricardo Pardini <ricardo@pardini.net>
> 
> On RK3588, the sata2 PHY speed is selected by sata2_phy_spdmode in
> PHP_GRF_PHP_CON1[1:0] (offset 0x0004), with sata2_phy_rx_err in bit 2.
> rk3588_combphy_grfcfgs has pipe_con1_for_sata at offset 0x0000 though,
> so the value 0x2 (6.0 Gb/s, rx_err cleared) ends up in PHP_GRF_PHP_CON0
> and CON1 is never written.
> 
> This leaves sata2 at its 1.5 Gb/s reset value, so the link only trains
> at 1.5 Gb/s, even with a 6 Gb/s capable disk. sata0 and sata1 are not
> affected: their speed fields are in PHP_GRF_PHP_CON0 and are set by
> pipe_con0_for_sata.
> 
> The register layout is described in the RK3588 TRM V1.0 Part1, section
> 6.17 "PHP_GRF Register Description". Rockchip fixed this in their BSP
> kernel in 2022 by moving pipe_con1_for_sata to offset 0x0004; the same
> fix was sent for Linux.
> 
> Tested with an mSATA SSD on sata2 (combphy2_psu): PxSSTS (0xfe230128)
> reads 0x113 (1.5 Gb/s) before and 0x133 (6.0 Gb/s) after.
> 
> Fixes: c5b4a012bca8 ("phy: rockchip: naneng-combphy: Support rk3588")
> Link: https://github.com/rockchip-linux/kernel/commit/2f5fe2c0bbd4fa95102aadd60da1100989103aa0
> Link: https://patch.msgid.link/20261109-rk3588-combphy-sata2-6g-v1-1-e9135c91de6a@pardini.net
> Cc: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> Signed-off-by: Ricardo Pardini <ricardo@pardini.net>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
