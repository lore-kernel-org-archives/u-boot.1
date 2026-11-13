Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E6B606A33B
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 18:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dUmy9CT4;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=T0s8yoA+
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 47DD081801;
	Fri, 13 Nov 2026 18:00:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oV3BtLxZgTnw; Fri, 13 Nov 2026 18:00:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 85BA8817E4
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794592814;
	b=dqiXtgdVOeBm2l1YmnD61DHllSACuAcyO7+H1SQN8oiEg/RkNytL3X+hPnEWItkwhI/X
	 0CZqMdfg/oZqXfeuxJxd2ly+StW8S1v7WV+lrKONbSoA78WbNKGrWRMTtdL8ykWfM8LU1
	 oNk0sqG0zWSTjKNRlbtuRIVJ/hf+9q6lGitIAKlF8B/v+njr86/lVDaA+MlKGx1uoh1uB
	 L97NAU/VJYnLlI28yYycb8XL82gv4J1dNIJjqvgXGgzfNTl9KzcyOof05l5a6kJv08IEt
	 QdaUE0YSHZlyP0MUhltrJnGJMJy6eatI5W4olDpVZXKMc4L0gPIWyRxqtjvX/UzPVsg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794592814;
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
	bh=JdAweMHo0CgRABAQv3JGHRdqsYY7j4cjg6vMwwnUEXY=;
	b=afDGw8ZQB9GpoQQmgGI16SaHF4LR0BcCIQheqrfrQ+W3uBKNXz37FdOAF1yNwlvJULAI
	 O1gjFfQfzIWBQblaTOzs+CWdWP3oV37C3Yttes6W8O26pywHPIJdUl9N0X2ELcdFkhFIF
	 4vA/ONWEhAAzfHUq9DWbr28hd56Uwz4v8m6G19twKpwtl0ElUASkoh73Ku79Lbv7cFmZk
	 lROu5FhjzRov8eoLo3t7jJGCHaa0rXj16t5tyBozzhbDpWcMxBWbP8IMfIIsQbR1ecrhf
	 hSCHMVKJgP9ofn7IQXX1zm0lNjFdK+VVyqDAgacBhuLyxrob4EHvxjVytsTply6no2A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=T0s8yoA+;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794592814;
	bh=JdAweMHo0CgRABAQv3JGHRdqsYY7j4cjg6vMwwnUEXY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dUmy9CT4W4++zd19RY/2duZNESmdCrGvrrve9VBSbsmtGuOCdHzrIaDM3Ap4ltrSJ
	 E7HLdMA6j7SRq2K+101Zf3eih+ddI3YaEcCkS6NzrtfVUuDNVo5N144NSbIIQVwXlP
	 JA5b/Jk8pOERRE53SsUCUE2T0oe/S2qfHXDfCDOFa8T3ugBHHeEliZy0xHoyX7P+mU
	 WqmAGu/RYiF5N/KvBp5+OFZa2CHsXvB2GoZsnt8ytetHC2JXw7Ld/qA10RyghETp5s
	 lmLho72BzPk9AR1Tc0BTTiZtFLcXhaDA6cbtUj/F37KvQtLG6iFCSkm6ubZuZDaH1y
	 K9mQehYvu1RZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 85BA8817E4;
	Fri, 13 Nov 2026 18:00:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BC721F46
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 18:00:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A2136817E4
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 18:00:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GLjLx6HTjMLW for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 18:00:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org ECE93817B5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=T0s8yoA+
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ECE93817B5
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 18:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdAweMHo0CgRABAQv3JGHRdqsYY7j4cjg6vMwwnUEXY=;
 b=T0s8yoA+kW49FNzqBEloqk4YpQKp+SMSJeFyLs+TblTBsf9wyQNljzKRjfM5PS4KW3L4wi+bQNCyN3Z2osyHBmQEH7+c7FqCBHGNnySoJTcnZluQLn+uPND2yPeZkBhbPdQPZRfnoAWPPxWGK9se0fuBIUht4oGlQzttEpUtOWc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by PA6PR04MB11780.eurprd04.prod.outlook.com (2603:10a6:102:522::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 13 Nov
 2026 18:00:07 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 18:00:07 +0000
Message-ID: <02f935f9-f679-4505-90fc-1bcc43f69a5c@cherry.de>
Date: Fri, 13 Nov 2026 19:00:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 26/37] clk: rockchip: rk3576: Use correct PLL rate for
 UART divisor
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Heiko Stuebner <heiko@sntech.de>,
 Elaine Zhang <zhangqing@rock-chips.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-27-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261011222930.1085075-27-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0160.eurprd07.prod.outlook.com
 (2603:10a6:802:16::47) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|PA6PR04MB11780:EE_
X-MS-Office365-Filtering-Correlation-Id: b4674444-1600-45a3-932f-08df41aff38a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|261102123227099003|10067099003|11063799006|4143699003|261021121427099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: dxUYgWaXx+rO/jwZhbWIsfDJ+nzwFKmpE7DsFuPgg+CGudAprnB1GgjGrzhQJXhH/gjlqKRYXsx9hzqwdXp4KJxOdMzz0aVmGF8Go7EVzCzl5ELJ2lwlSDUxMaoRcE5lyWVdegn4gFD4ye0zRPQKTOibTiFuGtQtIPB7rjRe8PV6Lc34lq5e96bokJZuBNd1ggQjNkaukOzw9bvxId2n2prq3ANbxrcBVS6JQEQakoubewacCf6YtYs8gI9gmUeNhEO+QlVk++R4MqWmsdgbAeG44NpzMaqZvU9DfD+8gJwLGyKHAJ5mWcljDxRoydPi64KSkZCQ0D1AEnSf74oF9VY0EgR5zg23+KUe24tJBlPE2M/A9FeKk6uz5MIdL7fE74GQPpOV3QeAGC9OjngEr9qa+bCBRrT1MX5g2JBSbFKJe4xUP1s3H8a5MaLkcRR0/AlS7gNXbZ2J2ncD/z8KLGyZAAvDlWcM/gZlTTKLjZQDYElrN6ByWoHceEKWSkLKzpOV0Jcw+U3l71iUfJbPb/n8CE/l472HqgDZj9PW3H7m4jzJHJ1M4mfpvOD7cIsAxr4vI5Ey8pTCY7MtORhTLMXzHSw2+cwpJezjhrFd4+FK3IZ5LCwXFVPdZzZv2Xao2UFjkwc6qRgezp242aU1EnN5/ML1SFc8pq419zmUj88=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(261102123227099003)(10067099003)(11063799006)(4143699003)(261021121427099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVh2RWJYNThKSTUxblZtK0x4cGdUWFBtT0xQaEhvZlhuemxlZWprbW8wazJr?=
 =?utf-8?B?R2NYdjMwSWFTNGF4RFNyMjE5TWNjYUxJV2dIWG53Wlg5dTVXRVBVRHJPbVVh?=
 =?utf-8?B?VGNnTXFucmh6YUZSQmVMTy9wY2NSdmdZdUVyNVVrSmNiODZSWFQwd2FLR2xq?=
 =?utf-8?B?U2lvc3c3S09vOFp2enArSUVKMURROVo4dUtzMjBUVXIwYnZpcTF3ZW1JS1VX?=
 =?utf-8?B?blIybXQxSHl4WjR2NmN6ZkM2NWtOeVdjWmtoSmN2cjJMYngvblJSY2trQlpX?=
 =?utf-8?B?M1VuSXp0NzgwV1FnbzhnZ29HZ2MzZjNlM0tOazlaNGREUkpZNE1PbUJZcFdw?=
 =?utf-8?B?VTJtbUdsYTl0Yy91czJ0cnd6SCtQYWpBdCtLb0cwUUdqNkMxR1Nndk1PelVC?=
 =?utf-8?B?L0pzaDMrQ00rdHhXUFNrWnEvcDhRTExGb0s3ejJWS0s4eTlJMC9EVDY0aFpE?=
 =?utf-8?B?QW1GRHA4RmZaamF1SXR1ZU96UGZTSkNkRUora0t5dldhUzhlLzB6bUIwRUI1?=
 =?utf-8?B?WW5HM2Vvd1I4TXgrTWRoWTkwSWRZTzR3dGF3V0RveHdKUit1blBWVEtQUlJV?=
 =?utf-8?B?Z3ZlNjBodHpNMVFVWFhnTjIxZktGTXRoMW93bUhwRlNhQWRLRVkwTlRVZkNS?=
 =?utf-8?B?cVErdUtFaU96TDVtUUwzV2dVQndqY2JIMTVGRUd2R0ZpLythQVRPRFkvMlNx?=
 =?utf-8?B?VXphV0pObzNFd3c5M2ZoaU9zNGVSc1BWRCtjSGtqS2tvSnlKN1YyWEx5Q1FM?=
 =?utf-8?B?S3ZrWnAwblpWd1JrVlFrd3JxazZwVWdRSjNlU01FZ2lIR3FZQno0cGhUUy9a?=
 =?utf-8?B?Wm5tY1FjOGJWRWR4NjZkSEN5eEdFK1NERWg5NjZYVkVvT1NaMWtzRWpXRUdQ?=
 =?utf-8?B?SFprd2VETnVkVVZyd1lDK2Nvam55bGpzckpOZTg1ak5pTkVGNHFDOFExN29E?=
 =?utf-8?B?ZnRDWmJFdDQ0NUdPTlF1RTN6eHU5Q3JPSlRkSDRNQVVUYmttRU44OEV2V2Uw?=
 =?utf-8?B?VWVCOXZKYjlDSzdvNThTWWNGaGVsRVZCbEVrNDRhc1NjenhlQVNlblV1NHk3?=
 =?utf-8?B?b3B6amdOYU9UeWFESzRtc1Jkem5ORWtSYnZWcXE1RDhneHNvSEJuZFZTQ29s?=
 =?utf-8?B?T2ZqbUgxcWc2S3ZxMVBCT3JheXd5bWNZcktJVGxpcXRtcDZUbVhubE9PelJC?=
 =?utf-8?B?Qkt3dkladHZ2enNDK1ZDU1c5NVhqTGw0NVJhR0VvbHpwaEpxYmxrRmxVQ21r?=
 =?utf-8?B?OHN3a3dZRitHTUZESWM1Uy9TcXB4UG9uNWdHT2hDR1RxbUxkRENPVHdkYXl6?=
 =?utf-8?B?NDlvQlRuMGdFWlJDWFFoYUFScHlQelhHS3V4UTBzZnA2ZEpGeTRvRHdmNmRr?=
 =?utf-8?B?VStxNEhEb3h1NXQvbmpaVnNleCsrVGM3NHZsam1GMnR4azNMSGdBYkg1ZEhi?=
 =?utf-8?B?S1JSTWZud25SR3dwWHZpVWFKSVhiaGtUSzJ4dkNqSTRCWFhrdHl5cEtITmYx?=
 =?utf-8?B?YXJqbzFadThyWW84Ui9oM20zMEM5MU5OSmtHZkNJbGY4OElKUW16R1hER2Y2?=
 =?utf-8?B?SXVOUGFneXU4SDBwcmhVdkJtZnVLUENuVjc1YWl2WjY1bEFYcWtpVmIxaHNC?=
 =?utf-8?B?Q0xvdkVESlMrMWpDSHJMV1I5V1haNmswUGpvdGEwcndYSUVZaDhmMU4rNTNN?=
 =?utf-8?B?b2pFYUJXcEJxMnlvWmJxa1hIbXJaMHh4TEFuQlhQcm9OcDlpN3loZVpYYU5B?=
 =?utf-8?B?aFM1M01ValFYWGNJY3JGMXkvMnpDV3YvUWRBcjVLUkcxZEpQTEtKSXc0YmZS?=
 =?utf-8?B?RUZhWWsydzlkTElQQnlIVEtpN2hoMTM2c1RRRnVEY05IMDRadjFVUnorOGN0?=
 =?utf-8?B?aWZWSkxoRit1dDE0bjJVQTM4UVdtVm9mdXZ3dzdhR0xua2p0eUJnTTJ6S0RZ?=
 =?utf-8?B?bUNuZzlNT0NRWnlrRFRodnkrU1AzRGVuOTFQRmpheG10YkxLVDNmTTA4M1Jp?=
 =?utf-8?B?N2hlb1dvUmJiRXBOY29mZ3FnbncxWTg1c1lSZ0VDY3dTY3prM0NZYTROSU1o?=
 =?utf-8?B?ZUNaVHNCbit0U1JTVlQ4dW41SHpYOVVnNU9sejhUWFNJd3VuMGlrdXhueUJl?=
 =?utf-8?B?N3pMM2tac0dZeFR3MkhYbjR6Q0RpaElScGhTbEFXdXBldEpNMVRDcUxoV2lT?=
 =?utf-8?B?aXVMS2hqUU1HeE82b0k1dVRleko5eE5HR2lQS2hXcmRQMGdqc0ZMamRuMDhC?=
 =?utf-8?B?WEx4dWVYN3M0RWhJTXBiNitTcVpqRGxKOGZOM3JDUWhXeWJnR2dXM3l1NTYw?=
 =?utf-8?B?UHhrVWJxclBocFU5YnV6NTA0NnI4V29xSEVpVDFkSlN2TGRWa2o4QT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b4674444-1600-45a3-932f-08df41aff38a
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 18:00:07.4013 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cQrwU/Ot81MXxlEwtjzHxRNy/D57zmZyxqWStTKU5Ov9tEkyyeJw8Qng6iZIp4mvYycbE70ahjYXyTWkAJwdQQEHwvhVP6y4Ox1Sei9HWcI=
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

On 10/12/26 12:29 AM, Jonas Karlman wrote:
> Calculate the UART divisor from the CPLL rate instead of the GPLL rate
> when CPLL is selected as parent clock.
> 
> Fixes: 3919310b37ec ("clk: rockchip: Add rk3576 clk support")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
