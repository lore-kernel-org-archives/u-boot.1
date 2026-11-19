Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEC7606A32F
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 13:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=j3THBB3F;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=U/cgcAaI
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4B2C840A83;
	Thu, 19 Nov 2026 13:15:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j_KeC-exjkr3; Thu, 19 Nov 2026 13:15:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 68B3340A70
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795094111;
	b=dnHkhcGg/rFNFopkUR1E7oOyJvDw/fMHiD+ao0DSDp0kYaoMQgUhhivckgS+gTrNhuUQ
	 yPAxKmyM4tEGZ2YYSTejZ6KFiuKhZ7Sn406+j7NYJt9cCG2PCgwb3MbowHApOcT7TMHnf
	 OjKvIpTUJphFc9Oexm/KrV3TYmNLRKuhUIRsqwx00ivjzoFnT9reTRcVnRcpJ+lhoVOiH
	 e7P9N3S1SmcOrN8Xk+902mGHaPPGj1IXWKoUEyR1E6LsS2Oi5OwHgMEHWMP8wiJS1zNBQ
	 aYUXrZDDOp2WaFlzopgV+6yKjDxNiboQUBUfLEJRhOkQ+vDEWmJ5acJuCwHCy7SHm1Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795094111;
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
	bh=ZoPnV2dlRL3QNTZ/R1fOFfcBy/aPC3FufHQ/axZZAGU=;
	b=XWLWDBsEZHPTnJjqJp6BTO3AiXZB5t615xfJxThQ6nAqXClt1oS3TJPMEPIikhQtxJhl
	 crXy6yrcdrN5mKH8F6meuH8FCyhHRuumhNI2r5Ya4kUIQYmq+EXU/c+eHlyOBAR0sD2jW
	 Jx1OmHjGdQq/AOQmXEOLFKlVddx5ef4vLmwld9erbzRLHm0Qv+wa8Dk48qnvuL+49LHU/
	 cK6Oby9tJXNT+WZuyXM/e7aNNlOT3u5t6Tnjjx76Fvamccr0uymQgm+ra58nN5nAqacE1
	 UlLqUJgmA4KWN25XYcOJiKVAouPkuxXAjaUV6YOmxG2Au5rxpAtEnq5iClUE8co/ECg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795094111;
	bh=ZoPnV2dlRL3QNTZ/R1fOFfcBy/aPC3FufHQ/axZZAGU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j3THBB3F1iKKLXM+KXpOwkHcxcAylnQlghxMz4oudMlqsH1oC3ctGf8olNPmxBELD
	 YC2O+tvdaodGEr8KytYESKXz6DSZDfgAW/7SHE3RC1qxfzSuvTb7DGFcHWnOFGq8X+
	 RKYsvmIZCbGtuTLdtL7B1scxbyv9hDlxPIkBjfjHb+tTACVVbNZRacmQQp776NnFs6
	 HL9Lo3ig2H21ICJej3HAaDlVhNQfMOUBqXUHWT0SjT3FwPrpLnAxuMg14ezcaGfh9D
	 VpDTjFdZBtCDauzNfx6OsDV5OQIRjoWYY7s1K+0BXtpQARqwsNsf+TC8mY/IEy8myL
	 dW41l3eRUifhw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 68B3340A70;
	Thu, 19 Nov 2026 13:15:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2E7C59F8
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:15:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2052A60D7B
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:15:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fJSNDUDx8XRi for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 13:15:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9ED2960ADF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=U/cgcAaI
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9ED2960ADF
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZoPnV2dlRL3QNTZ/R1fOFfcBy/aPC3FufHQ/axZZAGU=;
 b=U/cgcAaIW+pc9ak33+Cz7bw9RRn1H5rjusx7RQmpJOTGj1ZfeClfj1pbeASNcBUTisTOgXpQFxvXcE/SYyZ5mXjpq7/Q7r5+JmbYoKMxvKp9kdYs17s2yW08FgD+hvxVEKUCn4elqANsnCXmxQylHlHFYb7x07KIv0LrTsgQOSY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AS5PR04MB11396.eurprd04.prod.outlook.com (2603:10a6:20b:6c9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 13:15:00 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 13:15:00 +0000
Message-ID: <01cf9193-94e5-43ef-a566-a428b2ffea8e@cherry.de>
Date: Thu, 19 Nov 2026 14:14:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 3/8] clk: rockchip: rk3506: improve PLL_CON() user
 friendliness
To: Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Alexey Charkov <alchark@flipper.net>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
References: <20261117-rk-clk-better-con-names-v1-0-25521d4e37c3@cherry.de>
 <20261117-rk-clk-better-con-names-v1-3-25521d4e37c3@cherry.de>
 <94e836e4-fe65-4891-839b-1998c02c2b77@kwiboo.se>
 <d4467ddf-13e3-405e-9c89-93bdeb02a5e1@cherry.de>
 <c336839f-36fd-42ec-9db0-322d5c13eebe@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <c336839f-36fd-42ec-9db0-322d5c13eebe@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0233.eurprd08.prod.outlook.com
 (2603:10a6:802:15::42) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AS5PR04MB11396:EE_
X-MS-Office365-Filtering-Correlation-Id: 81b8d741-f1fc-49bd-e9fd-08df463f1d65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|10070799003|23010399003|366016|22082099003|18002099003|261009223027099003|11063799006|56012099006|4143699003|261102123227099003|261026121527099003|261026140227099003|261021121427099003|261022105027099003|261028144727099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: n1eJUpr1KjRVYN94Uzzf/6b0CCGl9b0h8zCnd/g46uxpxR75faAz/UNl5RYP4mSdPDbMAt9AtJe6j87qx2eOQplbeqxI53YDZEG6yJyaWbAKJ1q4Ho/HQE5MuqnDdrcCd4dH9obe9X730tnAO43wPzE+/iAc8jCUfluEQLvCbHVd8PNm7P+OV3QNAe2i4VqtqIotv6vUYduxkECG9XTE7UFwzcfM4ZUKCrGKmA73il5qnHMUamYpdAGY0xmmFowkzl55tOczFnCYMmbbqzJ6iinRXqvLNCqIgF7zIQLNsljEYCKBQeXWXFpZdxw8dEXJW81fmZYhWb+sXhhCjvLRQx3RIou9IwcNge+ktDrVj6OkaNmjyNG2w4sd8uw1puKL9ooAsBAYkGLUuwhA4V+WeeZFT8PyLbvBO76URcZG1u+ibkfp6/WO8IxbcMTzf6lSzdOOHYJMLC1/onwYtg5cEg6z/y6I1FrHTZLhOf8rAdIn3lPhvKUiDZbPpvkHXgJl2R7ttstavJJbPgMuh4OoL+Kj2hxA2ugFAYECGHe4D9p338vO+WLAFkJ9aUPIXPiVFFKhNUyOroXeJeSZrlZGMcKDVB1XxMFpYzOcT07KkQ1wlmJUxRfdDY0EYrEyGDTYAEqDVieX0jRjRp8PBg27nNhE4dqeCVGSZe3sfb49vTQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(23010399003)(366016)(22082099003)(18002099003)(261009223027099003)(11063799006)(56012099006)(4143699003)(261102123227099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022105027099003)(261028144727099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWhwOUh3emYvY1NxTGJCWW85WlBPNTVWY05zMm9GMkpGRjY1TUR3d2RpTGEz?=
 =?utf-8?B?NGRtY3VwN3ZnVXk5aGFRT3QvbzMwUVlWN0xPQmJYTGllUWJFU0p4YUZCamZw?=
 =?utf-8?B?d1kySTRFRVhwdzUxc2tId2MwcHprajJmVzdoM2VZRk8zUGlRMUNPNmh3NzZ1?=
 =?utf-8?B?dlhOM3BGbTB5WTVnQk5nMXROWUR1YWJmc1R1V1JwOTRoOUkvejhEUTFKcEhG?=
 =?utf-8?B?SktnMEc5ZzJUSVJndDhBU3NTancveFByc1R4UHlHcVpEczU2c213em5ScXJM?=
 =?utf-8?B?cHo1bmJsZkxCQ2krM3JnUVlPQU9sWVA5U290MW9VMEdTcXRlMnBKbzBGOTVn?=
 =?utf-8?B?QkxIQUlGanYySHlDR1FzVU5KUWZJZnU2UlJDZkpqYXdpMXAwWW1OaWNLUHpR?=
 =?utf-8?B?THQxT0VkTDlQYzY3NUt0QUgydUNHUHplV08xSi9lUE9Fa1FyeCtZZVlMTHdP?=
 =?utf-8?B?RUN1T21pWGVFYVpkWGN6aFVJYy9CN0kwS1E0NVpGdzB1dTBIT1MyelY3bXdR?=
 =?utf-8?B?M21YcUtueHJrWjZwZHoyaDB2UUtaTzg5RGtkdkpIM2Nzb1Fka0xsdkZyTVAx?=
 =?utf-8?B?ZlV6Y05DaGFvZmlETk1CTHRaSEhOeEE0ZFA4OFhqWjdYRXE3UzE2MVVBK0dX?=
 =?utf-8?B?UEVqb1NQRGFhVU9OSTdWbWlnMTFpd1lJcXZwVG1VZU5VT2hSczE5Ti8wcnN2?=
 =?utf-8?B?SFIzOGo0Y1E3TUpGdnVkYldzQVZxcE9jL2NjUVRTYXh6QXcyMjh3YTJUOC85?=
 =?utf-8?B?WWJ6bkpGTmwvbUxoNTVZaldLL2M3R0NhVmtFVG1Tbmw4cjFRbDdEd3Y4Nlcr?=
 =?utf-8?B?RE1SMHkrVTU0bnUvL2J3NWc5cTBxNDN6bjNFUGVUUDk2WXdPRzhyNjh1Y1VI?=
 =?utf-8?B?TWhJaGRDYVQvQTgrSWxDaVMvK1hPaDBxNThuTHFORDhVQ2FuRmpTVkRPT28x?=
 =?utf-8?B?TFFpR0JJZ2o4Um1OMWdPQ3pManBlVzZzU2Jtb1ZMK1lOdGh3K3J0cW9ma3hp?=
 =?utf-8?B?T1RXb0pXb2RBUTlMUDNwaHo1S1dIT0VhTHVJc3BRaTBaeWpQNkFvaXVCZE9n?=
 =?utf-8?B?RTQ0N3FpWEVDMzVBSmNPZlJoWnpGUE9TMzVMb1M0TVpteUN1L29FR2cwcHFm?=
 =?utf-8?B?cW42c0tFRUREZGdzK0JnMEloaUI2M3hCdzkyOWg4dURWUG1DQnBTNVY1S01y?=
 =?utf-8?B?K3h0QlRDN0NQQTlsaU0yTzV3cUlUT0hoc2djblkwcXNpd1ozU00xdERmNGhM?=
 =?utf-8?B?NG91Q1BZeDNQMUR6OW9meVNKQ1V2aURKc0J2MUIyUVNTMHlzZUIrZVliYzZF?=
 =?utf-8?B?dkpYMGZ0MWV6TWd6SEJaVFBoQ0sybERHUkxqWDBYUWxSMU5kckpUTlhPWE5O?=
 =?utf-8?B?Mnl1V3pnaWM0bjVlVFFZYVJqWFRQcGVMNDJUOUxjRkRTTTg1OXE4aW42MEM3?=
 =?utf-8?B?WW16MCtlZ21Gdk03aDVmSTZ1RFVHc1ZHbHhpdVUySGNrUGx1ZDg1WlV1MGFs?=
 =?utf-8?B?bnp5R3N6eTZQelJrQm5LMjloSmJHbVZZR0RJZldJUVFBZzVVU3NORDFSSnB5?=
 =?utf-8?B?Um9ycTBicFU1V2loVnBiTXFSUXY1OFRRczltb1lFZmFlbVV5R1I1ZVZINVhV?=
 =?utf-8?B?VXVJSWVMNkRwMldBdHZTcWNiNjdwcnFFdnRCazhCZmtyOGt3eWhOZjdYcHBX?=
 =?utf-8?B?NVBRdDZBLzlzZDA5MGRxU3A0Y09HRzk3Tjg2dXpWL2toa1QwZGNZTlV6Y3Jl?=
 =?utf-8?B?Q3laYk1lK0daS2ZKSmhub2M0M2xmK1NQaHUvaTE4c21TZDVpbUZveGdzMHA5?=
 =?utf-8?B?aXAwTnA4QkVXZ09kWitMc1R6aUNqUlltM2VzbnZOSytZazhXbHVZRDlmbkpG?=
 =?utf-8?B?NTVQZVQrSk1oNnhvMDVMdEhOcTg2OHhkd2krdEZlNXFHMGVDSDJaZFJmUVZQ?=
 =?utf-8?B?ZzQwUXVITEdXeGdadE5tUVIwVUxLZjlmYk1hbXZIT2hjbmV4dVV4TGZIenF0?=
 =?utf-8?B?REJ4dmt2MitGR3lFS20zNlMzMVlYTW50T2ZML1FKTExtUXBiZzJDbTJaZnp0?=
 =?utf-8?B?djNtZyswU1hQenUxR2o1Yjd6aEV4OHJOaUQ5N3l2WllPRU16U1Y3ZzVpNjkz?=
 =?utf-8?B?OWVrVEFiVjNKcThqZHFQL3NOUmlGSENXOFh6a0YyUGd4c2d5YW1QRGVoNnI2?=
 =?utf-8?B?WUxBcHZ6NWlac2xVYkpVUTZGVXB6ZTRnRGV1N29aNlc5RSt4bytsYWxYQ3Qz?=
 =?utf-8?B?Qm8xN09VTlpoOFZyZXZLaVUzRDNKa01ldEFnM1hCOVBNM3VydGE4Z3Y2QkxO?=
 =?utf-8?B?NHdhWlRhbzNreFZLU0NWL0RSRHR0dUJNb3JiNmpodVQyTlZhYk4ySlh5aEtH?=
 =?utf-8?Q?RA1rfMaYYfgdCuTSa2FU142BT7F7s3LZeXC27dNp/en2L?=
X-MS-Exchange-AntiSpam-MessageData-1: X6WDhEQnH6PmfQP61fMxAyMEFlOWlUSlcpg=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b8d741-f1fc-49bd-e9fd-08df463f1d65
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 13:15:00.3796 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U5qX5XjP1GHNPCLFy+WaIpi9QuEd+QguRLLAmTfydYqeg/Tn7+U8TQjTncJvWowr3t39WtyhlzLJgWAUxR1TdSvWcssxSMUzFoOX/NQc6MQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11396
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jonas,

On 11/17/26 7:49 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 11/17/2026 7:06 PM, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 11/17/26 6:59 PM, Jonas Karlman wrote:
>>> Hi Quentin,
>>>
>>> On 11/17/2026 12:37 PM, Quentin Schulz wrote:
>>>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>>>
>>>> There's no PLL_CON8/16/24 in the TRM so one needs to do an additional
>>>> lookup the header file to know what exactly this refers to.
>>>>
>>>> Use new macros that reflect the names used in the TRM.
>>>>
>>>> No intended change in behavior.
>>>>
>>>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>>>> ---
>>>>    arch/arm/include/asm/arch-rockchip/cru_rk3506.h | 4 +++-
>>>>    drivers/clk/rockchip/clk_rk3506.c               | 6 +++---
>>>>    2 files changed, 6 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3506.h b/arch/arm/include/asm/arch-rockchip/cru_rk3506.h
>>>> index 9ddd6215fc53..331b100ced54 100644
>>>> --- a/arch/arm/include/asm/arch-rockchip/cru_rk3506.h
>>>> +++ b/arch/arm/include/asm/arch-rockchip/cru_rk3506.h
>>>> @@ -48,7 +48,9 @@ struct pll_rate_table {
>>>>    #define RK3506_SOFTRST_CON0		0x0a00
>>>>    #define RK3506_GLB_SRST_FST		0x0c08
>>>>    #define RK3506_GLB_SRST_SND		0x0c0c
>>>> -#define RK3506_PLL_CON(x)		(RK3506_PMU_CRU_BASE - RK3506_CRU_BASE + (x) * 0x4)
>>>> +#define RK3506_PMU_GPLL_CON(x)		(RK3506_PMU_CRU_BASE - RK3506_CRU_BASE + (x) * 0x4)
>>>> +#define RK3506_PMU_VPLL0_CON(x)		(RK3506_PMU_CRU_BASE - RK3506_CRU_BASE + 0x0020 + (x) * 0x4)
>>>> +#define RK3506_PMU_VPLL1_CON(x)		(RK3506_PMU_CRU_BASE - RK3506_CRU_BASE + 0x0040 + (x) * 0x4)
>>>
>>> Please consider something like following:
>>>
>>>     #define RK3506_PMU_CRU_OFFSET		(RK3506_PMU_CRU_BASE - RK3506_CRU_BASE)
>>>     #define RK3506_PMU_GPLL_CON(x)	(RK3506_PMU_CRU_OFFSET + (x) * 0x4)
>>>     #define RK3506_PMU_VPLL0_CON(x)	(RK3506_PMU_CRU_OFFSET + 0x0020 + (x) * 0x4)
>>>     #define RK3506_PMU_VPLL1_CON(x)	(RK3506_PMU_CRU_OFFSET + 0x0040 + (x) * 0x4)
>>>
>>> That would closer match what I had prepared for existing and have
>>> prepared for new SoCs, i.e. RK3562 [1] or RV1126B [2] ;-)
>>>
>>
>> Yeah, I wasn't too happy with what I came up with.
>>
>> So, I'm actually wondering if this is just wrong? Shouldn't we rather
>> have a pmucru driver, separate from the cru one? Then we don't need an
>> offset relative to CRU_BASE, only from PMUCRU_BASE (so the hardcoded
>> RK3506_PMU_CRU_BASE - RK3506_CRU_BASE, or currently 0x10000, can be
>> entirely removed).
> 
> The upstream dt-bindings header and clock driver for RK3506 already
> include PMU clock ids, so not sure that would be possible (or easy).
> 

OK, I had missed that. Thanks for the heads up.

>> I briefly looked on linux-rockchip ML for an RK3506
>> base DTSI but didn't find any (but maybe I'm bad at searching :) ).
> 
> I have prepared and was hoping to send out missing GRF dt-bindings and
> base DTSI based on [3], excluding USB nodes (missing dt-bindings), very
> soon.
> 
> However, CI failed for my latest rk3506 branch so may take some extra
> time to sort out final touches before posting, as I would like to cross
> reference any RK3506 related Linux and U-Boot postings.
> 

No problem, wasn't meant to be a stab at you.

>> I
>> think this would align better with other SoCs like PX30, RK3399, RK3568,
>> RK3588 and RV1126? What do you think?
> 
> For most newer Rockchip SoCs we seem to treat any consecutive CRU
> related reg-blocks as a single CRU, i.e. RK3588, RK3576, RK3528, RK3562,
> RV1126B and RV1103B. If the two CRU reg-blocks would have been separated
> by something else I would likely have agreed, not sure it is worth
> trying to change something this late for RK3506.
> 

Agreed.

There's no hurry for this series, so I'll let this simmer a little bit 
and wait for reviews. I'll implement your offset suggestion for v2 (only 
for the change I'm doing here, I'll let you handle the driver-wide 
fixing in a future series since you seem to have more patches ready 
already).

Cheers,
Quentin
