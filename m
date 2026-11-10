Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AC8606A334
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HpME/smN;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=goCRpiK7
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 843F8408AB;
	Tue, 10 Nov 2026 15:30:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7pq4I0Sv6CDZ; Tue, 10 Nov 2026 15:30:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C228C40937
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794324606;
	b=YBNPQYY3sobB1V22ZMTSrvr2y4K+U5bwQ8AbTMswNSod8uh4b1SATFiF31opUTVrT4IX
	 OOggnz/+rFUi12LZrX/idI29cmmwoS55y01IObo4dp4/Ft2FFaHVDl23V5v9/GpwgchOk
	 gJJdCtgM/hPPyeu25P4raKQTfKDeJtOdUs1xZCmp3fcSwCtaf5r/Imic+KV2DMeiutmNM
	 zhCjIsIDjcZSNe3GokIIapqq1Uz5UYZ/jD7nGeKNDY5ap7jwOi5yLoYKXqtKbwFOdtqu0
	 bZWh92IssCoE+n1582aMdnh3d7T8UXXfNb/HwpEmeY+Li3qFgzS2ketax1+FmnwUPRQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794324606;
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
	bh=0zvWtgdnQZGtzKT4FBtZzuOk6o8Fd+meHTDPYipzq0A=;
	b=Gkk/W1POhPc4ssgMjp5RFTQPBcoCRabMhlrgv6gHAqA+aD7eABsRr8DMag/QysZ//buM
	 a1QdM800ZRppQ8CTkakT9X19PkAwlW3kKjdqOo31knKg5TtKXkIzNsBY6SrScdH/TRACU
	 SuhXULretaHCwQoTH1zKvKA/JKvn//UbAeZhs8wuxdEUQTcofEi2iym5ULLzZAf6Eeq0Z
	 Z29gMfSBmB3QwQT8YPQjUi0rFeGGnsYoDO7V/k8Qd3Ha6d7zQBN2hNzzjUTwUei+KPVFJ
	 VJCJyZVPT/pvxo+DIITsKRKWnE0psTlWd1rBxLpTG32MG8j/WTxywlOFTTAA/sNSYhA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=goCRpiK7;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794324606;
	bh=0zvWtgdnQZGtzKT4FBtZzuOk6o8Fd+meHTDPYipzq0A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HpME/smNWjKeYgADAdz27f0EzNUU3x1L7fmxLdsgrtEYPtQddYJ6UOclu4TJxDk+U
	 2vrbhJJ/1ZfQ0ma3i3BaXqMo4BvXfdqRLB0MVveG/vqpa4KKxUsJNB38ZDEMSctI6N
	 I6M35/bNyRBTJR7RowjsGnTtDhzxkbcJowj95uO9z1pe0kqpO51q8OprLlkgPIqFrk
	 r7aopf/BceQLHZBFyhha94rIo1HwuJCNCiAefnssZ9jhn8O86rDAU1LA2Lezaof5KX
	 y1jV9GtZfKEZzaTKxeWQaZoWVwKjbLy+OHkXwhBTi16NmAm2MAIh8u4tstzi9fAqw8
	 8eLRbMEBoFIgQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C228C40937;
	Tue, 10 Nov 2026 15:30:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id EB9B0388
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 15:30:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D0C0140946
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 15:30:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B6Y4g8kSFSYt for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 15:30:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A6E1840937
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=goCRpiK7
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A6E1840937
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 15:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zvWtgdnQZGtzKT4FBtZzuOk6o8Fd+meHTDPYipzq0A=;
 b=goCRpiK7OBZNokQDrKBwRKEy+DpD7tpO0817afOvO6G/YUob5ae6FvRPRE2otPG+rX+0SjbY7G+kqjYHMXTG6/bJ5YZLrxg3Cz84Cbj91OcrB3kF4OEZmk+iyd4ljQzHnNqlSyMPOurKhrp1VLYdEQ6ujjWi4Fh1dmXmvpCImqU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AS8PR04MB8834.eurprd04.prod.outlook.com (2603:10a6:20b:42d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Tue, 10 Nov
 2026 15:29:53 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 15:29:53 +0000
Message-ID: <93a130bc-3c19-4ab6-8826-cf8bf76e4fba@cherry.de>
Date: Tue, 10 Nov 2026 16:29:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/12] buildman: Cope with CPP="gcc -E"
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 u-boot@lists.u-boot-project.org, Kory Maincent <kory.maincent@bootlin.com>,
 Linus Walleij <linusw@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini
 <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>,
 Alexey Charkov <alchark@flipper.net>, Francesco Valla <francesco@valla.it>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Carlo Caione <ccaione@baylibre.com>, Yao Zi <me@ziyao.cc>,
 Michal Simek <michal.simek@amd.com>
References: <20261110-qcheck_fix-v2-0-1c76e0b68f29@linaro.org>
 <20261110-qcheck_fix-v2-11-1c76e0b68f29@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261110-qcheck_fix-v2-11-1c76e0b68f29@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0014.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:357::10) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AS8PR04MB8834:EE_
X-MS-Office365-Filtering-Correlation-Id: db088c6a-0c40-425a-3271-08df3f3f7768
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|261022105027099003|11063799006|261021123027099003|261021121427099003|261009223027099003|56012099006|261026121527099003|261102123227099003|261026140227099003|4143699003|261028144727099003|6133799003|17002099007|18002099003|22082099003|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: coGo/is2lZmFaq/EyQIsvNtru0ZVvZAQIiTjfFXv5CME4Q1QhBU0DQ3gWbG1lVXovDvUiuC0Pe6nHrzRCcprEdF+VKwoZICf5xDc2gHHb3zr2iDhP1nJWqiBsrl0xZAsJ4eTuMgH3vTr51Biw4QUm8zIgbqwxI11qpR2bq9Mtv1pAfQLHFH72Vkw/lIFqPlGLpJwfngPMOqiVFOgLFnK9FiZyJ3sHakD86CtFyk1FTwk0TUtp+3zlW9ttt9nCfMM/I5qeJNNcT+tsIndpqa0frkV8hzlP62nsElL+mu7beYF1s3OgHUwqRTvv3STxOhaeWkZ3hP39wQPtZoa7Rs08lvEA+U9kShEAuueosiMCArFVI99fmedsxgmfzm2eyy3awtCRW5e13tXCkMzQVjhl+AS+ATJYPXb6E206VlZz/kp+ugAIOz+pNMyFrsbdcuD2bN+crBEJzO8dZ4q8WXfvjs1jkDEzqRFA3eoTQZxla86zXCB3NPJa0/uLIqd01iUaOdDLLWKy0pN9XmcduuP6WUBuHcNbUdOVEJOhjr7I43G1oWaDrJ8dNMK4Zvxk4CIFCVIrfMOzuQtcTnp0jdaqVC8CfJqcg539Yw8QtRJH704e9Q5oR1PdGGye4IhMFxUibmMIlB0njXpelfFdaz+btaR/LdA5py/Baee8cUEY6c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(261022105027099003)(11063799006)(261021123027099003)(261021121427099003)(261009223027099003)(56012099006)(261026121527099003)(261102123227099003)(261026140227099003)(4143699003)(261028144727099003)(6133799003)(17002099007)(18002099003)(22082099003)(10067099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NE1lUWxOclB3TU5JWG9xeEtCTGhKVExuM2JBOHZ0Smw4ZUtzbElmVlU5QVgx?=
 =?utf-8?B?NHV6amVHaVkzR1VDUzZPUWd5aGI4Z000QUkrNzRLOUthYVFoMGpuNmZwSW02?=
 =?utf-8?B?MnlrUWR5Wk1xWkZqQk5BZ2Q5dDMvUm9DRmNiZXVISVJxczhpYTZDL2JBY0lu?=
 =?utf-8?B?OXE1SCt3VENiUG56MEp1cVFhVnAxUEVCOGMyYzZpZnFHUDUrdk5paGpLNGdM?=
 =?utf-8?B?Vm1SVE5WY2VRdzNwUzhySUZVN2FXcmpoc2xPTlJlNFAxTHM2dERDaFJhMHNP?=
 =?utf-8?B?K2lBZlRYWnhqMGFNeDBWSHhROEpBbHVERHJKNHgzR0FrMWxHZVE2aXI3WXFU?=
 =?utf-8?B?WXowUmxidU1HYXQyWWxlNDhZUXhVU0tlclVYR0JOcnJhbzNPR2xhc2RMR1ND?=
 =?utf-8?B?U1JlNnRjd3hDakVIOVV2L3Ywd3hIVDFQVG15NS9LSFFDczlWeUl4d1Z4bjlH?=
 =?utf-8?B?ZTZBMTYrdGV4YnFCS3NPUjVBeEphUk1LN0JBcVRCa1ppK2NxeWo2NVZpQnFE?=
 =?utf-8?B?MUdFcnR0UFVmNHIrNlIxd3FnNkY4emZmUGR2dU1QZTNuS05KVFFsZitETEZn?=
 =?utf-8?B?dVYralYvdG9HN0NWNVVodFhuWFFkWVZPRExpZ1E0M0NMUmdERFlmM0lLbmha?=
 =?utf-8?B?QWl6T0ZMN0tiZWhtNEVaalVVQ2h1SmF3RW85VmNCaXhQakZJTmhoYXJuVHZl?=
 =?utf-8?B?VjdZR2lUTE8ra2NKelVyQ2t1VTVtRGtFN1VOaTl5U1NkQW5pWlU0QmlUZGpn?=
 =?utf-8?B?TFppNG9YSEx4cjV3RHJKUEJCVTJyMWp2NnVsOXUvRlhFS0FXZEhGWjN5R0hj?=
 =?utf-8?B?MlVMYmVtSUg3SXpmK0RoeUZNMkRUamVnbndpOFFNbHpYalNBVDdDdGxiTFpT?=
 =?utf-8?B?SHg0cHB2Qm1OQXU5SitFeTdvRUxyYWRQT1J0V2JTUStvZUZjUWI0RzJDdXhs?=
 =?utf-8?B?RUJIWEV2cDJTZ1N6MmNDMFVLNE5BTjZSL3hPaWtab2Zma1VKdWsvVVRQelo2?=
 =?utf-8?B?K0FzemRzYVQ1L2pwd0MrMlpqYktpejg4aTNLenQ1QXRnYkpxYWhxWWhmS0xI?=
 =?utf-8?B?MURoYXhOMHBtcU1GOHA5RDVpNysrcEZqVUFaTzFJdGRNd0xIWmZOdDlGMjZi?=
 =?utf-8?B?STZ6RjZPUGdPK01SYTg0a3FRL2ZwRTJQN0RIUkJrZmoyeDBVSmgwM1ByU09m?=
 =?utf-8?B?MzM4aHNFTGMwVTdOUnZIL0hZRUZPenU2UUVRbVo1bjdiUyt2aUcrN2plYU81?=
 =?utf-8?B?akdoSFBRVXVvdHFEVGJhNWdjVGNiQ3ZSMG52ZGZWUlFrallCT3VtdktaTExP?=
 =?utf-8?B?bWwyU2JKM2MzNFYyQVB6Y1cwS0VDRkxmZ0xXS1AyMGhLSmlqMW81bjU2Zm16?=
 =?utf-8?B?aUN2ZXcvZHlGelRYV2NpQU5od0tqWGdqeWw5azNSSVp4R0pmZUN0OGp5dUFi?=
 =?utf-8?B?YTB3ZXV1T0UwZDVNUm1RWnVRakk3VVlyNm1rK2NwZnFGYVpReGs3N2JzZmpw?=
 =?utf-8?B?K2RCaTJzWndQR0x6bW5URG95b0ZqN1dRcE9hdXVVZmRZWk9PK2NnVkVUWXhH?=
 =?utf-8?B?Zm9xNjdHMzZKZDBFeDJzNU1DUGVGQWZ4clUwZDgwc0hxeXhlQ3Vla24xUk1z?=
 =?utf-8?B?UENYcjlwWkNha3RHczlKNFN0aDdXeG5MZExRektlcDdVNVRwZWVHc005UXlu?=
 =?utf-8?B?YjhzOXZYR2RKRzkrcElFd0hyQmNjVDFlbnYraFE1akdnWGpEWkpHSTUyNEJW?=
 =?utf-8?B?OTYxdzdvbFhQWlZEQ3plaFpOVDJzYlk3Vkx5YmlZZGM1bkRXZEJQTHp3Q0RJ?=
 =?utf-8?B?OWg5ckswSzR3eTd0WGgzSEJsT2svVmxJKytUOXVTcTRrSmFZQmYwWjhtd1Nu?=
 =?utf-8?B?RXdMVC91MDRYdjI1U0d6ZUJpekdGUnhrTHhXdjY4cFo0K0c4ZFJUa1ozcUh4?=
 =?utf-8?B?TTJTclZLVENEY1VWSnRWeTNROE5odWJ5R2padS9UaGtzQ0dYYzUyellQOUFP?=
 =?utf-8?B?dmRBRlNkNzZxdUQwbWRTeTMyVVkxSmJWQmZKeS9uSk5zdDliZEdjVnNWa2c0?=
 =?utf-8?B?Z0d4VXNuaEFDVXd5bnp3QUpmaGIxZlhpTytKYmxBNnh2c0phZ1ErWFUwdHlj?=
 =?utf-8?B?K3AwSWwzN1NyeEMrMUx1MTN1c3BUSE03OW81M2w4V2x1RHAxdW9ldEdvR2tj?=
 =?utf-8?B?QnhsajlpMWkzYnlOTUlWNkdzL1lTR01LLy9NaGNpSXlhRDJLbEs0dE82Nmsw?=
 =?utf-8?B?SHZqMm84N25XTThlOE5MTGhUQU02dVAyM3ZDRHV6Zk5rbHRVOCs3eDRhbXl5?=
 =?utf-8?B?WUVXN2VJYlB4eDl5YUFlMVlobHRUTGE2OEd3bDkrQWlCaXJ2WmRuUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: db088c6a-0c40-425a-3271-08df3f3f7768
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:29:52.9985 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kSgEOXcB0tj09diflRMi1xhpIyaAlUHIjzJ/Zd/PDBFdpiKE11AIX375KXXPMdCTzSD7LF3uBlBo6WBmxYZANxzjHz6r0KGW2+ROpuS0BSM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8834
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

Hi Andrew,

On 11/10/26 1:24 PM, Andrew Goodbody wrote:
> Allow the use of "gcc -E" as an alternative to "cpp" when set in the
> environment as the value of CPP. Accept it as a valid command for
> running the preprocessor and adjust the test to not depend on a fixed
> number of arguments. Also split it into parts for constructing the
> command list so that the validation for running a command does not fail
> when it tries to find an executable named "gcc -E".
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   tools/buildman/boards.py    | 3 +--
>   tools/buildman/func_test.py | 5 +++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/buildman/boards.py b/tools/buildman/boards.py
> index 5d5d3a3822b..111789f1bd4 100644
> --- a/tools/buildman/boards.py
> +++ b/tools/buildman/boards.py
> @@ -244,8 +244,7 @@ class KconfigScanner:
>   
>           temp = None
>           if b'#include' in tools.read_file(defconfig):
> -            cmd = [
> -                os.getenv('CPP', 'cpp'),
> +            cmd = os.getenv('CPP', 'cpp').split() + [

issue: str.split() is not safe for shell commands.

I think the proper way is to run shlex.split() on it instead of a simple 
str.split()

>                   '-nostdinc', '-P',
>                   '-I', self._srctree,
>                   '-undef',
> diff --git a/tools/buildman/func_test.py b/tools/buildman/func_test.py
> index fce615ba8b8..eb13589ba17 100644
> --- a/tools/buildman/func_test.py
> +++ b/tools/buildman/func_test.py
> @@ -378,7 +378,7 @@ class TestFunctional(unittest.TestCase):
>       def _HandleCommandCpp(self, args):
>           # args ['-nostdinc', '-P', '-I', '/tmp/tmp7f17xk_o/src', '-undef',
>           # '-x', 'assembler-with-cpp', fname]
> -        fname = args[7]
> +        fname = args[-1]

todo: add a comment with the new possible list of arguments

This should explain why we are using -1 instead of an offset from the 
beginning.

>           buf = io.StringIO()
>           for line in tools.read_file(fname, False).splitlines():
>               if line.startswith('#include'):
> @@ -424,7 +424,8 @@ class TestFunctional(unittest.TestCase):
>               return self._HandleCommandObjcopy(args)
>           elif cmd.endswith( 'size'):
>               return self._HandleCommandSize(args)
> -        elif cmd.endswith( 'cpp'):
> +        elif cmd.endswith('cpp') \
> +                or (cmd.endswith('gcc') and pipe_list[0][1] == '-E'):

question: can't -E be anywhere in the list?

Should we use "'-E' in pipe_list[0]" instead maybe?

question: what about "gcc --preprocess"?

This is the long-format version of -E according to gcc(1) manpage.

question: what if we want to use clang instead?

It seems like clang also supports -E/--preprocess.

Cheers,
Quentin
