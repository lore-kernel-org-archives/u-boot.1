Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F228B6075E0D
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 17:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cPk6/t2t;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=Mer88enU
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C7E2640633;
	Fri, 13 Nov 2026 17:17:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id azQQSAkqlJyK; Fri, 13 Nov 2026 17:17:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2BF864072B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794590236;
	b=b4YEhZ0CU/EuLxWgg9DgwUAAudhm7HncKIg+NuL3iZdhy/PH7wwCH8e78txqIZGvhoBL
	 W8aCLNxlHKKnwYXyKKkb5npOZTSJD+tjaMib2mGVGHtHSZAH8c99539B6mMOyP2vYBsTi
	 PSRp+zmLaFPbXpbLAWhlavxFsxrpegz0xo2EJi1bKZfYFoLyH7uApzO1Quu64AQ4/iMRD
	 hWCQ5Pk0X52ZjxFnI6f7GfXJ3IVAhLdOYdp4o9lSOMjS6SS6NYNvVQh79Y+k7NyukzGQq
	 egwA4L6ps+AL7FO0g5yQ10Qn0eQT6xzytXQfpCqeb68n1R6JgjpSx1dKEKezNJ3LWxA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794590236;
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
	bh=krXAEe6/ZJZpvoLmyvkBROrfurMLGUuqHMbASu2WrCA=;
	b=a34k7KDNJBxZTubH7Zjy7kbEmzhbo40R6yGc0YWxc1SqrpZKaifvxZxK0yt4RT8yyWkb
	 +ekFcGy1TMzbFXw5JHvotF8O+4r0bYfa645hREGg9+AvOTloyoXOHvPAkM5E/gFC/OyFh
	 Kocz6aSWYnkHy+XAgKIy794IoVSPnaJwG1F/moF9tl3/gwJRwQRtngdhh5BthNkosr8Vj
	 FFCt+lBJqeeYo+iGNZxeoZMBmBuWRt1MSizWN7VHBBYpxlWUQIXPoUbLxx9ESDSIsEUzV
	 rj3CAIJiCKu2f+nqXqt+PissCAQb9UevFFaUh/AjvlsA/iCZzINPLTd1dojMm++rrRQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=Mer88enU;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794590236;
	bh=krXAEe6/ZJZpvoLmyvkBROrfurMLGUuqHMbASu2WrCA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cPk6/t2ttLyN6fclD4+llUaEJCHq28/ZBqnhgaNerJX6bzAw6WldKJZU4ynJ9f3p1
	 ixYL1KxymOqxUQLH70ZHy+iAmQQmrCT4qMvzsyeZbPHaWgzNMggKfQjCkoxNAWZtjY
	 BnYw4CV3HQmbmVJuGs7645OKyfPqoCoUCPaEkOABhOtIbJmnRziR7il5NK6f2mwZ1c
	 AiDf6oeqx8aQB6mLlJgvI5we5Be5iKub2nR1rqBGfoy6JoVIBRbkurqxEhkKWIoyJt
	 P7Zy+sNjo1mTp/HilU6gfna1wi+Lg8zpraV29OFy4kJWy6itt5tvV4IjMH5b7fce5n
	 GaZ0PZeaAw5/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2BF864072B;
	Fri, 13 Nov 2026 17:17:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B4543F46
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:17:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A5C644072B
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:17:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ICbnwBkuDWhW for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 17:17:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BC95F40633
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=Mer88enU
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BC95F40633
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krXAEe6/ZJZpvoLmyvkBROrfurMLGUuqHMbASu2WrCA=;
 b=Mer88enUXtZVHqF3n+8Qr5/PKU0QHV0l5cLeIcQU5s7XxpsBrsMa3EYDtaFI7V1KlG9g2Lrk33qBWmWd1MANvZwxfXhie00HkjFSQ/UBYrfEQdZiOxMdZmhPHX+5IlYJlMhYsbshhfQ2qkq88Q+MqOWwce7L5PMKIjFnSUuTPLg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by VI3PR04MB274072.eurprd04.prod.outlook.com (2603:10a6:800:374::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 17:17:07 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 17:17:07 +0000
Message-ID: <8041d43f-ab75-45cc-98d4-ac52288952da@cherry.de>
Date: Fri, 13 Nov 2026 18:17:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] clk: rockchip: rk3588: Use correct PLL rate for
 SCLK_UARTx divider
To: Jonas Karlman <jonas@kwiboo.se>, Lukasz Majewski <lukma@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>,
 Elaine Zhang <zhangqing@rock-chips.com>
Cc: u-boot@lists.u-boot-project.org, Jagan Teki <jagan@edgeble.ai>
References: <20261111231251.160051-1-jonas@kwiboo.se>
 <20261111231251.160051-3-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261111231251.160051-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0087.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::16) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|VI3PR04MB274072:EE_
X-MS-Office365-Filtering-Correlation-Id: a8d2e66f-57d1-48c7-9dd5-08df41a9f1cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|18002099003|22082099003|56012099006|11063799006|4143699003|261102123227099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: 3Ij7GXr62/FvxnpATBrlLTKXPDgeOvDk0E75T/5qVFmW/Nz7X3YzJ5TIxZlg8NMGmdnf1AGzdGxxE9ZpdaRPnaAh4D5qy6k8x00/WCyjLof0DP3RAhbd2Cb6/IKZuTaIb3iHtIBvcmBs00XiYyA8DK8D1X0phlISVJv6JhS6oVQ7E1hwvL/VcUDdQFgZqOBr9giDknmKhfsuxMZzzKZOMDaQoKhsw3Hbsb9ABQH97pGnXbKc7hANSeKx6bHbstWzj8OK5oLipqX8meM91359HKsHiChY1aDVhUwzZXfxryLiTdzP+s3Lr4BqOAiyYxXt+Xe1q1fFRzdrb9osLSQxLOWbmR9aFH+5B8SQqnNg6v5gkXDSRe4PrcJYSqw+UEFWU2FwVnrzCwAfjqcsPPKa9Px3cXSznvRtgvjxV8kCHwLljYDNXYG4xawz5CO8NQB+AA/C3OZribckhf7vVXMu8uNCsDzDB7aj5etNiX0FIihqp2DQfmFe8iDR1WTN0eMvFzOGIPW+hyKv/X9QTSeMW9mBlYJhXB8fZ44dh3KoncCIVV8GcjgpnGs+p/AmSebx2CCwIqjnyHBanQBk+jXNeCrwgoURrEjoNepfqRmVE1+EJpdP2RZHgiOT8DjDBVBKsz3YCZBDIBo04ImiUMyvqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(261102123227099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHZVaFNjOGpKcXhJWXErVjJRbmVkdDZJR2JZNW1wd2xkRHNpMnl5R2hxSkFU?=
 =?utf-8?B?eTVNd3c2STVXK2V3R2Q4aW5HSUplWFliVjUyT0tyRUdmN21OdGdyQVpOTlhj?=
 =?utf-8?B?blVMOWRCTEFXWUVUM0hlL0VaMHFVTUhEdm9yOXFHVjZpZFlLMFhXZkhCUWJ4?=
 =?utf-8?B?M1BuYndmTXk4cnBnNWV1YzNQTUNiT1hTK3ZBY2hqc3BZbnpOUDg2L0hsTmpB?=
 =?utf-8?B?RXU5L3I2Zktqc0JPQmpVUkxUU2Y3U0VwTTNoZnViZlUxaWpYa1dNYksrMWNR?=
 =?utf-8?B?czd2dE56czgrT05yRlg5Q0UwNUNYNUc4S1RzVkRuSnBjTzNMZ25HOXUzZFN2?=
 =?utf-8?B?c3JGSElRS0Q4UHVoODJLaWtERDd0eFJVb0dJSEtNd09ubW1EY1hkd203UE9G?=
 =?utf-8?B?MTlPUVk1SVFyZmRjR0xFSmNyR0l1QmJkMFY2Z0taKzIzMVJuY0o2Z0pUbmJI?=
 =?utf-8?B?N1VuNVZCOVhhbjFFanR4aFR4TVl4SGtZRWhsZkUxeStVL2U3ME5XNC9KejNk?=
 =?utf-8?B?bndVZ0hXSWN1aFFWTTcvTWZGYzFhQ2dCUHMweDRSTzliN25iMVhLVGpkei8y?=
 =?utf-8?B?MjYxZTNYczFIaCsvcUZ2L0ZST05vRHM3OUVDWnZaRkpoYWFZMnpqUEk3OGJ4?=
 =?utf-8?B?Tmw5RjhYbjF5VTRwYkdYNk1GUFVJbDlzcFBMMWY5KzRJM3FjTy85aVVzemRo?=
 =?utf-8?B?eG1sS3M2S2E0NU5VUDFnMC8rZHV0Z0tsUTlicHJPV1k2NDJzYnRXSXlWV2xk?=
 =?utf-8?B?cU1lbXgxUUFMWHl1RXdaWFZCQzNFVTg4L3ltRU1STHhRQmVyU0h1b1lHRHB3?=
 =?utf-8?B?aFBYcDlBU2JoUlZJVXVEL05ia2hMbUxJTzVrTG5JT2FuTjFFM1lSNWVmZDJ1?=
 =?utf-8?B?bitRUnprR0NZd0dXRnI5M1F6c0s4WnN2ejQvQnU5cTF2UGtScUJVRzNZTlNP?=
 =?utf-8?B?NHBBMjJpNC9hMXJXeG53QmJTTzR4dkdNcUw2bEtGVmxsRjV1MGRkemVxRytL?=
 =?utf-8?B?Ymt0djNpRmxJY0tjdjRkQ2FMcWw0NFFZMHVPUXNWVDFwZUgrUEE3TmxycE9k?=
 =?utf-8?B?NFZaRG5iTm1SR3NvRmZwQmNKYnVqT3Nzbno5UElEejFaR0paVjFCaXZpcnhv?=
 =?utf-8?B?SnlTelgrUkl5R1lSVUVwVk5aN0ZuNWVZS2Y0ZnVYRkpBcnFWVVkzSDVMQ2Z2?=
 =?utf-8?B?cFJBbGM1NkM5YUFwQ0VBbjhSUGJ5R001M2d6WHhnTFUxaEJ3VjVUWVNJc1pR?=
 =?utf-8?B?UGFpZXZvdUR1OFd3em5FMGpiVG1ZSU5TbVFMd1VFWnJsL2pIUERFR3Yrc1Mz?=
 =?utf-8?B?bE4yV3RhZW50WG1yci9jN0Z4dmpaOGNNUlhBSXpHa3hxZjZsNnN3QW5RRXI1?=
 =?utf-8?B?L3ZDUDgzMW5tLzI5SG9IcXppY2d4bkdiZE1xSWVIOGhIaGVQOGVJK3BVQ2d3?=
 =?utf-8?B?cTEySjRCOWZ1UERERXZhYzhZVkpZRm53aXNBUnV0QUJ0bnhzSm5LdzdaaEVm?=
 =?utf-8?B?c2piaEFEN2NQVmNDdHMxb2RpZEcxdFV1TWRpdEFvbjVPV2o1MzZ6RzhlOGc3?=
 =?utf-8?B?b3h0Z3RwNDczZjBPcGdoSE1oMFpuS2M2SUZLOUlZb0VKZE8vSGFzM2xhazhx?=
 =?utf-8?B?OGFyU2VSMnF3V1RPMWxlNlFSOFlGSkE3YTk5SGZ1Zy9Cak4zcjJieGwyRkht?=
 =?utf-8?B?ZElnMWVqeWZiK1hqb2JNSnBWekZVZVRHUGt4RGd0UlIvcW4vWW9CWGJad3hx?=
 =?utf-8?B?bTVhVHBZWlN6cGlVbFpPc0ZwRjhTdjQrZjFXYmRVZzd4bnlCTDMwa0pWUERP?=
 =?utf-8?B?R0pSMU5iNUVtZlA1cHV0ZnB3cGhFcW00V3BINDlYV2E4Sk8xZTBOY3hRbExM?=
 =?utf-8?B?Y1JCcXFFM204aklCM0NsQVVaWjNjQk9DeHoxazRtdk9Ta2h3UEVSWUU2R3lF?=
 =?utf-8?B?Y1RkUC9nbFFjd2V4WFhnem1jYmMybVdSR2VnUmtFamt1bFA4SWRyU1R0aktq?=
 =?utf-8?B?VTBXbkwxbXNwZ2JvWGlWWm13YnpNREF6aS9HZE1xRlpZM3FNZDZrMWxEMXpI?=
 =?utf-8?B?MnRKYm5aWDR2d2IrTTZZNDhna2hDc0ozbFhnOVdhQzBNMkhlaTBDSTVudmQw?=
 =?utf-8?B?cEV3WHN4NTZTOWJXZEY2OEVxQ3ZFaExXZWo3Z3htekNVanlTZGxXcTBKWXUw?=
 =?utf-8?B?UFEwcWwyeWwvdGpMaWxxb0NYaXVIZ0xUSkp0a0lGVmNoMU93dlM4WUVKTjhX?=
 =?utf-8?B?NzhQcTdvL0UrSGtWL2xabUJHaGd6WUs3QWdXUTRYempRTmZuZlJsK2psK21Z?=
 =?utf-8?B?elU0eFpwZk1Lc293Y254TGRhMER5NE82UFFOam1hRytoYmVkQW9Jdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a8d2e66f-57d1-48c7-9dd5-08df41a9f1cb
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 17:17:07.5348 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1uMzWP/wugffLd85pb1phIQysfAfN1jYgZE+B/f7XAR/1juM9gi+2mXXZWMLbGuaZMTaTAAslprsSi3oG3j2NG9SfhNJzjMqwq2i5ut/FbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI3PR04MB274072
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

On 11/12/26 12:12 AM, Jonas Karlman wrote:
> Calculate the divider from the CPLL rate instead of the GPLL rate when
> CPLL is selected as the SCLK_UARTx parent.
> 
> Fixes: 7a474df74023 ("clk: rockchip: Add rk3588 clk support")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
