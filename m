Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F314F606A324
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 17:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Qabz3dkD;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=iZFRggjl
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CA1EF60749;
	Thu, 19 Nov 2026 17:18:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tdWCudR1q79d; Thu, 19 Nov 2026 17:18:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 29AE06076B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795108716;
	b=bJcCBv6YEi79IK1duFW9Vw9A62DDvhXVkyxyQa/a0zU8UwYVuLwB80sZr4EM/AdwGP3X
	 LfQxpfPnGCBwfxqRu6G3lKpOMOPINl+g05AkP1po1ur49MjzBFoe72Sasiw7LU58x98iv
	 zgFjDbTEPweHcCxbZhFemyPhZzfWgDv8K7dUbWHaHwzY1Ds6tcB6Lx9IrgEanHOz6AZkj
	 y1Ec/uv+X5KG4z+eCeVKkzT2L/xn/YaDwqLVJGnSfWGTriShbcuUihGy7ujRw3c6Io+5F
	 QXvgKv4tH/nDuR+2sNw/fWxBjJ0gtwhZll9GNuGP4AdhQg5cujoqY/1Vnmm7SebyCrw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795108716;
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
	bh=SNV5opQVFG3DX/ub3K55z7hmgPnIGHpa1UtGkXWPGCk=;
	b=R7xa4iHBhbgKsPjNFeCZFHvXpEmB34ITke5LF6TREHJBAF6LiXTxg6XCMOUBiQZyI2eb
	 2+FWDztJTNh5/7Vy4+ai5J362sEJyAPN9QyDSQ7uEPAYcL6b0fNfbR5IF3Y1jKNHpLwxQ
	 S/jIJPw0pya0qaGWJnoxFNOTlt7K0jsYMBMUw7BcUK5ILrzMCh4pOpwAOCq++PSD43O8a
	 ttZP3KNMEXiTij7+wY4Q13hk92SW9ZCwj8FSkfwlIBjaTvwoeHN95Eug2TuJTQmGrrS8j
	 vHzGtyIq5rspHqQIjwI3o314AfDobpsdaHgEfx/5jdinMgkv90uBhbqwGQ2sjSdqaQA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795108716;
	bh=SNV5opQVFG3DX/ub3K55z7hmgPnIGHpa1UtGkXWPGCk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qabz3dkDhTGUfEUaMbumZrsnr0hq3QqIg2xajEjKBYq/68vsxttncR5KEr1ZwK3fu
	 SJ/4mFYpqlFPqLxXAMdfOtEXC6R5rHDKO9CzHt4Eal55UW7EV/fsqn/d0iMSLuz2we
	 LOhoidYrtb5qf0IAtkY8WibVP4oM4Ay4XKFzZHy6I8yUNhqbkCc3mrU6/n67JkN48R
	 W+5m9FTfO6/oF6KvkC2d8XSKh2kBh+jArBCiTFsgjnNNzCliZx1tKegAFPxqcBHvsB
	 UCELMwz7OWEb9GAisyFaNoxa5Vq2Lnem3wuS/BvsCgChbxiEDCJSXGRD2jl9ijNQ+G
	 KDvCyRhy7KneA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 29AE06076B;
	Thu, 19 Nov 2026 17:18:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id F1B6F2FB
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 17:18:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E381180E25
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 17:18:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x9RckiS0Ej7B for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 17:18:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1E49380DFD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=iZFRggjl
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1E49380DFD
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 17:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNV5opQVFG3DX/ub3K55z7hmgPnIGHpa1UtGkXWPGCk=;
 b=iZFRggjl2kJ0VRNNO5iUDOZj1+qaJAcuJLG9i/biWkUI+OiNE7PSJjLHIcXy9QFLccLbMum5cBebpHdrveXdq/VE1GmYl9SwibrT0IhAIxeTpVBqKuepe19kPviwBSL/O/Id3mkpe1qNJzHEeHCwarQDpMwePkKkn4NKscOCets=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by VI0PR04MB12134.eurprd04.prod.outlook.com (2603:10a6:800:316::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 17:18:29 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 17:18:28 +0000
Message-ID: <8e3d3897-872f-4332-bdb0-af3d4e05bd3d@cherry.de>
Date: Thu, 19 Nov 2026 18:18:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/15] test: Pass location of built tools to binman
 code coverage test
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 u-boot@lists.u-boot-project.org, Kory Maincent <kory.maincent@bootlin.com>,
 Linus Walleij <linusw@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>,
 Alexey Charkov <alchark@flipper.net>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Carlo Caione <ccaione@baylibre.com>, Yao Zi <me@ziyao.cc>,
 Michal Simek <michal.simek@amd.com>, Marek Vasut <marex@nabladev.com>
References: <20261116-qcheck_fix-v3-0-b6cf7e96944b@linaro.org>
 <20261116-qcheck_fix-v3-11-b6cf7e96944b@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261116-qcheck_fix-v3-11-b6cf7e96944b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI4PEPF00000135.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::891) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|VI0PR04MB12134:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bf9e2c8-42a4-4633-69d6-08df466120e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|10070799003|366016|7416014|376014|18002099003|22082099003|6133799003|11063799006|261021121427099003|5023799004|56012099006|4143699003|261028144727099003|261022105027099003|261026140227099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info: UyGfUiPPqLOhwiT9dkVRKsDGX/Einb7me6y0d70gpZJDSPJIKoUv8jF+Df1XjFTQicN0CDRxG/2wpJJdeIN38SB8nZlGkbcxPNrBMnhbY7MfZxE41YV2Qzr2JKuHHTBgW4+NZaBycjRLmd35t8jaXdk9dmxs6UFnTrM+Y2zYlxDJW+P3zNMlqFyuESnWFfebzzkXQrLiabgu+PB7uv+l5hXVn6hUvOjrF54yIduBEkSvInZE/yqWQ7e6zUdDVVRR04xrxOHiPjCtxrPDwR7ux0nEwv+4y3nlioq6bjXAZphJsbzDI423FVfXUALGggU9K/+8QbbtxJW4tT+eL6H+0RQOQXS1v0Jy2tfWXYbno/8vNDkQgRRRwzMOobyIr/N8MvefgveEICf8X/U8WPKQAVd2aUuf5VZXX1msPalW+eOGS8teZ9HF5zIHleplALCbTpbDr4159DZrbVjHuxJaOH7hY7d8TaKEoSRZGzOOzCOx5Aj+D9RBCSgMkT05J1fXtSz7NiHvj7pHR7EGRBQ1PjpsfUxpgp2EtPuD+AjDosk2ChKB3jecVOQxkub/jnKiDJ2gh4KY+w9eG/PXC7odVSn1Z5soc0kwNwBNEntSb/AlQSPtH78zd262wLkh/iNEeNlY0iBSwwe7W74NRHLg49x4cyHVXlNuHmRn/uainmo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(10070799003)(366016)(7416014)(376014)(18002099003)(22082099003)(6133799003)(11063799006)(261021121427099003)(5023799004)(56012099006)(4143699003)(261028144727099003)(261022105027099003)(261026140227099003)(261102123227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2g1N3FPSHdEbGdzRG9QQ05Rb1V6WmxXeGYyZlpjTFM0ZTVVSzVzRXF6K01m?=
 =?utf-8?B?emt5ZmlldjEyYzFORW9EUy92dkJWUmtCbm85K3Q3NHF1SHFHNW0weU0vSlBV?=
 =?utf-8?B?T0t0bE5tdDBJaGYrSS83MFk3cUdXUFhFMzlSbTNXUUVxMWk1RjhYYlZiTmth?=
 =?utf-8?B?Zyt6YWNwUU1SQVRLYkpVMDBrWEdnaDc0QkFXZkw3YXZHMjZoREllT1pBYkNC?=
 =?utf-8?B?QWdaWG5vOFlVRUZENVRNUmh6UVhhZm5FZ2VKZmZUa2xJbmN3ekxBM0h5NlhR?=
 =?utf-8?B?VktlY0VUYWg3MjA5Zyt2ZWk5blhYNjJBa1dIZ2d1Wjc3TFRSRjEvVDA4LzRO?=
 =?utf-8?B?WktlWk9KemdUM0tYdkpRbGk5OVZVbHdYZHZEUExocTJwdlVqd1FwbDU3VWNO?=
 =?utf-8?B?NUVwbnA4eWk5NlJIY3ZCWmQ5UHl3aVFxd2tpaUlLbUdMandjeWtDWkEwU2hk?=
 =?utf-8?B?T3hSQm1FWjhubVFMeFJqUWlTUTIyL2U2ejNBODdZbEZxUm1KQ2FwOHJXT21q?=
 =?utf-8?B?QzhMVEVnWFNiVjd1dGxsam0yeWZ4SGtkTVR0S3VhaEl6REE1RzliUHlNN2FM?=
 =?utf-8?B?Vm4zVVRKcVNwemwvdXdndUJQUnBEdUMyZGM1dGQwZHEzUTRrMkFBM0ZWOUlq?=
 =?utf-8?B?R1BsNnVmeHQxS2lzV1c4QVpydVUyd2ZzWkIyMlZlN0NETnZtS2NVVmhDTGti?=
 =?utf-8?B?ODV6VHRoSVlBbWJPeDUwaGgyZjIzYW9OakRXSUdMRGZibVg3VnROa3YwZnRl?=
 =?utf-8?B?VzJNRjZNcWk4Y1hZRUU4dGowTit6STM0MHcxTDlwRFNvbExRWktMYWU1bTV6?=
 =?utf-8?B?S1pVMWpsOSt0RUFSeks2RlhrSGgyMGlhY21pOW9nSGpKRnUzVHhwWVRZcjlh?=
 =?utf-8?B?a0xEU01TU0ZYWGtsbGMwK3UzUm1UaFZBZS9mdmc2Wk5pNkpvdjFKYk5JUDBR?=
 =?utf-8?B?bENhVVR0YmRvc3NLbzVxd3V6VnVhZ2JkYjhUWlA5OUtWcU4rdGZSVENLSXVh?=
 =?utf-8?B?Q0pkOUFKbCtmR0NwYXBXYjEyczdGQ0tqRTRhNVVIS1cyRkZNNnJLbU5VSnBT?=
 =?utf-8?B?NTlySlcwM2gwVTRCSGxraC9RcFhGU2pCMnVreXdXL0dDS1luaWtiOHRGN0Vk?=
 =?utf-8?B?VkRBWjhPcWkrb2xCdVVUSG45eE5wRThxMXhpaDQ0VlBlYWplWXpJWjBkOFJI?=
 =?utf-8?B?QUVJakJaVUx1REVBQVlWUkVhN1RSQ3VyNSt3SmtrR2RzUUVqdUc2M2QxWUlY?=
 =?utf-8?B?OGRFalNCTUZZK2c3cXF3MWM0RUFUeU8rNWRCMUF6cE1DUDRHSGhRNHpBUjNs?=
 =?utf-8?B?NE1FVzRFNmtKRkpKOTFLbStRR1hFVDlGUXpaMGlxai9zR1graU16VTNqK3NB?=
 =?utf-8?B?VHVjVFM5ZGw2b1ozQ2twZnBGL1FhdFdVY3BUTllYaUoweFduZGFRRWs2KzRC?=
 =?utf-8?B?eHlLMWdMZnJRQWVjUHZwc3ZrVWpqQ3NuSXFvUTVzTitUQkRjY0gyK0VJSVQ4?=
 =?utf-8?B?Z0UwdmVCZVFxdkJyMzZDR1R6V3FhdW9WcEVyL29Tb0pNY0xqWm9QaVJNNDVC?=
 =?utf-8?B?eG1kYmRvZk1GdXRjc093czZaZ09IS01oaXc3RlpBTXlUQkZLL0FXMjJlZS9R?=
 =?utf-8?B?Q01HL2YwN3VmSFJ5M0I4UG9IeGY0Wno3N3hXMllKZllHS0dXWlpFWlNNQVRv?=
 =?utf-8?B?NzdZd1JieGR2Kyt1a3BzR2RUbDBsam9oeEVlVHJyUnY3a3VCSGttNXM2YWpo?=
 =?utf-8?B?UHh2TzNwYzg5S0dzNFl1MU0wQzRPYjlRdG43UU1DU0dTbHpQUFUramJ0NG1W?=
 =?utf-8?B?M0xib3Z1dlU1UHZOV3QrbGRsRDFvckNzTFM3b1ovdnh2bytLZitiRVlWc2pY?=
 =?utf-8?B?dWY1eFBZQmo4eHlTdlMrcUIweUJ6U3pjQVREVGlxRisxSUpFaCt5cGlDdVVs?=
 =?utf-8?B?dmc5M3grdGdwUmtOR01IZkgxdmtiU2pRVDZtTytPNnQxNjJ1aHBXMUtzSHZx?=
 =?utf-8?B?dXFwb2NsSmRHbzB6cW5hZGIwdjhueld3NDZVaHF4Yi92RE5nbmozRW9NVTJm?=
 =?utf-8?B?YlZyWjFXVVZRUmF4S3N2bXNwUWRjbkt4dStDSS92R3JYb3psTzBpUDJrS08r?=
 =?utf-8?B?U0N0L2laZDRjVGlIb2NKMHBxWFRpR1pNQlNuc2FjbXY5M1Nnbm1TQnhpclhQ?=
 =?utf-8?B?MEs0SlFZWi9DUEpuUjRrUlQwVUZrRjVCWkE2WXFoVDJGWC85QTNRRDJTRmZl?=
 =?utf-8?B?L1UwcTRIUjl5aWlHRFBBT2xFeXpGWlhrSWdBYVZEQktiWm1ZUzBEZ3FWWndu?=
 =?utf-8?B?ckNVOVR6dDI3WWVQcXVHa1JHZG5pQXN5RDlTd2tVVHlMcS80dkJUZWpwWUtr?=
 =?utf-8?Q?dFx+zknyGI8TS+sIx9ka2SdKMWQFh1g/5FIItb3T2V3cs?=
X-MS-Exchange-AntiSpam-MessageData-1: FO4Odt4Wnuj8pOtKjzY5u0fW0hqRHHzWF2c=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf9e2c8-42a4-4633-69d6-08df466120e0
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 17:18:28.8771 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sij+TkY4/nGMTLDfK6t+p6M6W2kfLONXY+VMHj/VlOVOBh40hkXKU0KwmvkQO6hBoZctKNMAJf6cBRHk1G6wE0REYRxN34F8+IMKj0RsH3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12134
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

Hi Andrew,

On 11/16/26 11:59 AM, Andrew Goodbody wrote:
> When running binman for code coverage tests and invoked by 'make tcheck'
> some tests can fail if they use system installed versions of tools
> instead of ones built from the tree under test. Use the toolpath option to
> point at the locally built tools so that these built versions are chosen
> before system ones and to match the prior invocation of binman. Drop the
> change to PATH which did not work as it put the TOOLS_DIR at the end not
> the start.
> 

Acked-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
