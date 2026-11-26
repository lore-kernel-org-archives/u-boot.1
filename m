Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF283606A339
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YGQKl9OB;
	dkim=pass (2048-bit key, unprotected) header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256 header.s=selector1 header.b=sx99yPN1
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CC910608CD;
	Thu, 26 Nov 2026 13:33:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xReDjK0D9jNK; Thu, 26 Nov 2026 13:33:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BF0B260AD2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795700036;
	b=VvuBMtHPFcgL69Mm/s6uO+nof7Ftz2ZEK763qnI7NNp44QMvj0YHECrAwVsIMILQXdUK
	 yVTkPv25cIorqvpzh8+GfjBfOFPIV9Nde1cFVtSw5Bu/jJijpL9f9zhq++M4+bxrBrDV5
	 +eG1IyjgCqnsdgZ56pPCc92v1oOO90qljXKpSHT49I2bWaisaZGgW0ArlovedL7NyEdoH
	 6RnDKlU9QkVbExPSR2t6Wi0vrnyXIxyXx2X1HXrDXgCf9UD2eDGZ8hvxvJLMAO3FzOusV
	 ZzMd8AsY/yB1tIp8YnoR5bJfDsUc9OpgGI+aRql1I/yavoD3fRXNoLCiLE+yYTzDPoQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795700036;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:References:Content-Language:Cc:From:In-Reply-To:Content-Type:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=UfeOeRnJjL8PEQoiNCTg3cImyPZHA18g7N3nYqwBYaI=;
	b=RbZqnQDY3Fv7ltYSpjiaO96qqKBabHVDWj3IMupUQR6F0R6Zofi0Rk1Ed0GhNp9ukgju
	 ogulvSyvbbg+IctXpGiVVAxSYHnYSZOnLOODxC1yleSLWoPKkxChnojyLwbRarKlqy5us
	 cI6WqzDWNSAu4qPuWF+zvrCYH4CiChnSB06Z5FfBTzhaZtiuoZ6XDw+77+K1TuAfO4b/V
	 ubGWhMhV1nIKamUGyYTOMyd7K/RfBDhs5kWTqcQfKXEXKToyjjP/A8tIIka3cvFGydUDq
	 k5QtOeBikEBRKBXfOxhAEp2Hl2scz7g0xiU+qiA8LpOtk0oGrjj7ddGGdab6f3dCVOw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795700036;
	bh=UfeOeRnJjL8PEQoiNCTg3cImyPZHA18g7N3nYqwBYaI=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YGQKl9OBoPYkr2WR7zhZvUZulIAye4/e4kGVpCAEUwszqVsZq58ucICJ4CH768q/f
	 whQbFQVJLBrgwhLcsoDvR/ubjPGGdEjDJeOXJnQHfCT+wFZz3LZf30BsSI/h/yCMZf
	 ZK7L1No8MY19zceVpmEx0UJEBtz0mWgU1LcvOwdUU/XLUNnyfRcWkEQXUtGXzCFR1e
	 YNQnuBycSOoURtRyg/ZE2x2ACxdkoDNMn4M0nrsx+fm7n+3timTsuGraCi8GccEh2D
	 9Q7kr2Zc4jRKnS5pA4aABjs/ia1W/IK4PzMxd0XCVy8fKInV8TBrYAHVO3XJZDjp3b
	 t3gIZQwJxdotg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BF0B260AD2;
	Thu, 26 Nov 2026 13:33:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 778C0371
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 07:57:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 69BDD40490
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 07:57:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4BgbDb7nghK5 for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 07:57:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DD8E04048E
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=frieder.schrempf@kontron.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b=sx99yPN1
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DD8E04048E
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 07:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfeOeRnJjL8PEQoiNCTg3cImyPZHA18g7N3nYqwBYaI=;
 b=sx99yPN1wySufB6VJnaTyc36YbiPMkNSFh3yh09uut6BsecI2K1kylmGaFbB3UzubMgvvczkSrYf1YjfSpiOqO5pyFsXBBlb2WQ+Fwwfks9250GdztEG0eZ6R1WgoBEhKSBsLWV2O2vXRVZhyBuJiPOuRrBr7URa0qJCmUjEW7Ng8PZG5GBwA2T0S1qsCYhz1rbAmond+DPi07mszwWHpWockoVxiArcYH+BJEQ3jM6Br6oBqBwQJIUudJ49Xbo+4aPiiocXaOwzkXEdEyTPVf2FErHKM35udQucoGRZCEQOdDJi08YWn/34n0p8JQzVoz3Xs6bSRM3yDpNSAh9MrA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::23)
 by DU0PR10MB5535.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:31f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Thu, 26 Nov
 2026 07:57:01 +0000
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22]) by AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22%3]) with mapi id 15.21.0662.001; Thu, 26 Nov 2026
 07:57:01 +0000
Message-ID: <9c7f2fa2-d3cd-4795-b808-1fbe84e87711@kontron.de>
Date: Thu, 26 Nov 2026 08:56:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] spi: spi-mem: Transform the read operation template
To: u-boot@lists.u-boot-project.org,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <20261117224236.3150882-1-mikhail.kshevetskiy@iopsys.eu>
 <20261117224236.3150882-3-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, de-DE
Cc: Vignesh R <vigneshr@ti.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Stefano Babic
 <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goat?=
 =?UTF-8?Q?er?= <clg@kaod.org>, Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Daniel Golle <daniel@makrotopia.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Aleksei Sviridkin <f@lex.la>,
 Zunyi Hu <roberhu001@163.com>, Guodong Xu <guodong@riscstar.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Mark Brown <broonie@kernel.org>,
 Yuho Choi <oss.patchbox@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Peng Fan <peng.fan@nxp.com>, Padmarao Begari <padmarao.begari@amd.com>,
 Akshay Belsare <akshay.belsare@amd.com>,
 Cooper Huang <cooper_huang@aspeedtech.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Boon Khai Ng <boon.khai.ng@altera.com>, Cole Munz <Munzzyy1@proton.me>
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20261117224236.3150882-3-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::7) To AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4277:EE_|DU0PR10MB5535:EE_
X-MS-Office365-Filtering-Correlation-Id: 5700252b-aed0-4f6c-00f4-08df4b92da97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|376014|1800799024|4143699003|18002099003|261009223027099003|22082099003|10067099003|56012099006|11063799006|261102123227099003|261022105027099003|261028144727099003|261026140227099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: Am1d03IproXQTw3/OfmCRjueLhmsYPy3OP8NVY5it1GHtAxrciJLo2Owbw+I7uMM7HVpegHXiW+j7lDO+mlzXLr5FBuHM16rZ8t0SH8fJ4l4csMkD9704oRpDQFlr8qOMyG7PTdt2B8NKiiiT1KrBg4LRuLWgmscKgdzbSsxFdqlBi8gATegibihR6AhXXdJ7JFPv8uUNwwcT2awDLQ71SGPUuqQPgYnXGxv2WjX2Pmw49UXvWzoT8RjKvvWTnvQ8aFerV3T4bUhysEXbQwsErHAQxWJT/h9zbcdKEkYyPyP1WLFgryqLQFhu09gzBG2P00laDxx0YM35qypKzJtjN/YPP75dhoOZyAHKFhK5Y4re+8DxXKn61pAj5cPm0jmHM/HTIK48jRzRAbJLRUbUxLiVBorOgGlhPOWZg9XYXonDIWPtufMzVtZLvjpyZ1IrgbOHzPaKMUZtpY077ENnksgRWcs9BhQGFn38W3vYzBO6ixyWcRZmddZiPQQRTHi+pht9ndygEdL88pVjwvv24uTjC2erhQYiu+JVX6s5nhEowws7Iq+hHCffYY0RaeiQmjw8/R/Vu8zaBj6ZPBqP2UOjdsrSFoMCRNHYNopyB+k9Qd3m/XKkVg4TDHfwkkb6K0yarI0Xt9cxKfy96UqmcLxP5TrzaZJ7FuiyE9VRHA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(4143699003)(18002099003)(261009223027099003)(22082099003)(10067099003)(56012099006)(11063799006)(261102123227099003)(261022105027099003)(261028144727099003)(261026140227099003)(261021121427099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUY0bUJ4akl1WEd3NDBhK1ZiZ1BtKy92VHNTZ2puTy90NEJVWEdhVWhpcDVy?=
 =?utf-8?B?dDN0QXRLLzhRUUsxUE96eSszLzhUNVdTeEFGUGFwVE4vQzIzRnRiRVc5c0Uv?=
 =?utf-8?B?UXh6TGcxNG55QWR6eTlnSVZnK3ZSdHBhZWo1VW80WDY2dTFKeHNPNCtpRjh2?=
 =?utf-8?B?Slo3RSsvbVlZMk9jM1hSU21UTW54bnB1K1dkWXN4dDk0WDFubVZON3d3ZVhI?=
 =?utf-8?B?MkxPQlJlNUtLa0VuVXZNNFNya2l3dUxQd01UUUsyMGFIU2lxckZnam5sbTdv?=
 =?utf-8?B?ajc4cm1WMmgraDdRNjQrRjFRV2Z1eFViQkpkQXU0ZXNTVm5iVzRvOXg3NkFM?=
 =?utf-8?B?YlV3anZmcjk0Y0dnR2ZxdzBwVmJFRTEzYVp2L05qdkdOV0EySnZDWnJyK0k3?=
 =?utf-8?B?eU84dU10QzVFcFZ0bjJPUGJpZ3M3TDU0ZEtQTUpxMHgycjFKMHM4a2xUL2cr?=
 =?utf-8?B?TXgraStnYkJieFFaRnkrYUpmOXp6Qjk5ZlBLMURvZlhqYVNIVHRLQTlLdVFH?=
 =?utf-8?B?bk9FK1NmakYwc0M2UEdITzZVTHowYlN3eDNkMWNvSTZlUFp6aldsRFpJZjZC?=
 =?utf-8?B?cldlcXZETUdOR3F0ZlJxV1pIMGMwQ2k0R3VTL3Q2QlgzVXBxV1ZseW1nMXhY?=
 =?utf-8?B?aHNoUXdxUjYrSUg4NlZQcWdFNU95UkYzVFY3OEdLVXVTRHJrb0gzeTVCS1hx?=
 =?utf-8?B?bG42aXF4QWhldUNSZW9oOXE0RlhwU2NqOWRhZmNwM08zazNsRG8rZHRnMzdS?=
 =?utf-8?B?T05kd3JIQWs1UnlDZGQ2c0NNV2s0aUtIZWFiZDllTjNCUGZyVjh4RHhMbVc4?=
 =?utf-8?B?eWpXVGVOUVVMeS9mbVoxcGtWbXVLUXE5UVlGVlJOVlFmYXFqUjdaUVIxQmVR?=
 =?utf-8?B?Um5USEpnL0MwUU81QTN5Wmt3am84TCttblNpdjdXbmVlcDlCWHhSMHU0VW5C?=
 =?utf-8?B?MUg1dEZzYU5ydkIrRVdRbGxoOEVRQW45TExNZ2llWTlIMVNkSWM1c0c4QjUw?=
 =?utf-8?B?RkpTVE9LQitnWlRkZ2dCcEZTZlhxUEE0cnpBaTBqeVAxUU1ENVpjWjNUeUli?=
 =?utf-8?B?MWovSUYxVWxwS1pzR3ZmMDNZR1VTL3V4ckpEdDd2OWlDM05HTndlQXFmNWVG?=
 =?utf-8?B?Q1ZheUYrK2d5WWdBdFdEZVpZc0FUNFFlVHFNKzQ3b25YRzFIdzNzWWM2OHNl?=
 =?utf-8?B?d0dRU2tDUHNTaUYyTE9wSkhCUGJld1lWaEJNVmM1VEUzZFVaVzRkeFMzZHdv?=
 =?utf-8?B?ZHA2Z3VjUkpqbmhSUitoTXF5KzM3ZjBwNHQwTzM0WFp2aUN5bUs5UjhjRW56?=
 =?utf-8?B?UmdxQnlRb2h0TitjUUxmNC93NHpiSzFMMTlXRlNHaW5KR1haQnJnV3BxMXVj?=
 =?utf-8?B?UDV2UmFYSWVGSkJWYmpOZ09yM3dEckhkY2QxWWFjdnhUQU43RHpyZUcwZ1J0?=
 =?utf-8?B?eXdabVJDN29pbk9mT2tKSU9DUWwvaU1TUS9HaGdzaktOb0w2L3NjTUpPZmpr?=
 =?utf-8?B?bDhyUmFBTmFZMFAyQlVKNXoyR2lVbmtNQitSM0wvTGFUbzJra1pTYUp1OVR2?=
 =?utf-8?B?dnptRVJlYytMaDd4L2sxY2FodUdWK1FVb1hwRHpaa2J1dFdjN04xd3N0c3lq?=
 =?utf-8?B?Unk1SERMS3VlSEZ0eFpzbHB0ZGFPTm9TaVlISTg2eG90VXNsNzNYV3dvcER1?=
 =?utf-8?B?SkZtZjAxWjhDS0FGWVNNSFEvLytJU0I3aHB6Nkt1aFBUcmNPME54ekZLU1pu?=
 =?utf-8?B?bVpDYk5vUTRabzBZSE82azh0VENkTm9MeTB0S2dqZ1R3dTBKNTJ0TWVBS0FI?=
 =?utf-8?B?ak42bFZDajE3bFRGN25GRndZcWYzTUJCUGRJUm81QmRHSU5tL3I1N1JGNWcw?=
 =?utf-8?B?Mm9Ub2F4YlpUMDJHTTNybEgvU2J4T3hWWkF6aExaUlFKdnJkNlZIR2xBdDVY?=
 =?utf-8?B?eG1LM1FTcmFQNEE0VTRDU1hZYkg5NmJkWFRsM1JyMFR2YzhTdWRzMEtYUUl3?=
 =?utf-8?B?N3ZSOC9xajJxby9DYU5WWlJTK0dUbUdQd1lzQVhvZ3lqS0pUY3dOOHBNelE5?=
 =?utf-8?B?STB5eS9UcG9oamZlKytkZTNQbnZGMXFieWZHdC9EdWlWWXhIN1BmSzdUR09n?=
 =?utf-8?B?UnVMQnpHTmZtaXRIc3IrUytmdFF2MEs2cmVHcCtQaHluSWxscm5xYzZ1c2hI?=
 =?utf-8?B?TTRmVm9JZkpiYkZUOVNUZ0ljbXg0OVBjeE1UeVpyMTZDYzV0S001eWRJaXdt?=
 =?utf-8?B?NUkzU1RDN2w1bTZNMWtPL3VQa2lZd3l0cy9uSkNabzFKOG5JaEpHSkE5dC9l?=
 =?utf-8?B?ZkthYkZxZkNLaVd2ZnkxRTBoVU1oRFdvOWNXeUgvdG5tb05XWjZhQ2NBYmRr?=
 =?utf-8?Q?hsH+i/0Tn+1/Dkj0=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5700252b-aed0-4f6c-00f4-08df4b92da97
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 07:57:01.5380 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RvTwWO84r27rPgBGbBtg44fNtUC/p6Kxr+LqoUplsoU9sLunrTaOeS0g/9molq242MuhIJIV+ru8HdeUdQvFi0pCi+tMAPKj5PzTejIZMEQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5535
X-Mailman-Approved-At: Thu, 26 Nov 2026 13:33:17 +0000
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

On 17.11.26 23:42, Mikhail Kshevetskiy wrote:
> From: Miquel Raynal <miquel.raynal@bootlin.com>
> 
> As of now, we only use a single operation template when creating SPI
> memory direct mappings. With the idea to extend this possibility to 2,
> rename the template to reflect that we are currently setting the
> "primary" operation, and create a pointer in the same structure to point
> to it.
> 
> From a user point of view, the op_tmpl name remains but becomes a
> pointer, leading to minor changes in both the SPI NAND and SPI NOR
> cores.
> 
> There is no functional change.
> 
> Acked-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> [Linux commit: 39d0ea33123ffe0214217b529830ad91574c8757]
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
