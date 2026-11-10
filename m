Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AC760A3814
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 14:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hZ5VFAXI;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=MVdtHBST
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 19AE081287;
	Tue, 10 Nov 2026 14:11:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V5RCV9d-Nip2; Tue, 10 Nov 2026 14:11:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 09C1481206
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794319917;
	b=I6gM4+ipYOdm2y0BaPjqIcJfZ21i01Tm/uAXg3Fj9gsHf6deWNOd1HHHMUQAPmfEeJK8
	 YRR+UByooKipSnRvM+u8jnPJQTcx+4aa4gfMiVwBKXuOBIENTTVoArk2tNxeuD8x2DvnO
	 HihKDUYMgHCS8ZHo0R15gpbYucpaM2iDONoh0wm3rZEJ1dCq0UrafhZOrYTfU0uKOMnRG
	 y+rHdfLX+jZWeA8Wc2Qg3sUvTZRKr3xEODzm/PPOeby0aPX0pU6sRqPGDavnsWGtzT58U
	 2Lk3T8o4VBlFEH+ZdvYi8m7VWX9LfarvXADESi0gT73Nj8VATKoUzJkABUSt/Egvwyw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794319917;
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
	bh=rW0ClhVmpQA6kqOWvMHitkqtJoKkke0PiliOcmC7wGI=;
	b=VVWggsHu/MG2wq/UI786FQG48/UaYPln+X+eEbu6k5WFu/l2hWH0DGIcWafjCmd9Mo0b
	 1oV4OXP0o75Q/jW9VHqJ3NikiTxmjRDc1gMNwYguqDtzu2e25YBMSRWVm3kAUa+aQMQzh
	 SD9DVlqxhwNjfpWsA5QxXjLOJmxVRFJ+7FXt4BX34XhJUEgCHNaqJaa2z9gloNj4Z7BkW
	 eH6XZxmCZ/K4oq9hWN98am7UJ0b7J0QzIMP1vEXSGk41LMDSNLfjOL9rTSCCi6mfDoSrM
	 BQXiK14XAmi75nAL9qxfAzm9cCmCXIuRfc3DNLeA/TgIFdFFKgiBkjqf3RLz1GOYFYQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794319917;
	bh=rW0ClhVmpQA6kqOWvMHitkqtJoKkke0PiliOcmC7wGI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hZ5VFAXIbeMC03VIiql8J4zDV2VWbye/p+mBpVFfokpbBqUeG4M8nqcN5YZQAQLHF
	 FAf2c6tVBW50qKydm04V4A72znLgnIZD1rikebsHTGkiUlAN5SZ7mNrSGXlyB4NGlB
	 mblnYnfjEgDmY3pelWt8ONLoL4QOPLkxr92dIkc32gdZ3IGFTYC+cRQTzHESQGqI/z
	 rF7mxckOpdziIvDiWsL6EMWb0QOLM6jFLVXvW7mfCY1U/yeydBj1oPizltRyoA+3IP
	 rZNeMpntRG1TSIs5YsoYZ8rUhXpXSmExI2nIZpq/uN3og33yislgT2jTAP6W3J067F
	 iQgAfCN3HQQOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 09C1481206;
	Tue, 10 Nov 2026 14:11:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id F0B261A6
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 14:11:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E1FC8605CB
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 14:11:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nJQ3J9Wx_fqz for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 14:11:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 266C2608DB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=MVdtHBST
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 266C2608DB
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 14:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rW0ClhVmpQA6kqOWvMHitkqtJoKkke0PiliOcmC7wGI=;
 b=MVdtHBSTyAW9WV2wKnGhbU+R5BAV1/QinrujUdcXBJxa+y8d+lwNsr8Ja/Zsl613yqzTFBvDXeHvdEI3B4evhuPSSFds7LrcoapBv1wxzNDL19eBzLrQ/FmadvaskbMmaxe0V5QaNAH1irss6n7N9o8mLAi2QSijyraeWIjFNSg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AM0PR04MB6833.eurprd04.prod.outlook.com (2603:10a6:208:17d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 14:11:47 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 14:11:45 +0000
Message-ID: <e27aacd0-7d7c-486d-811b-6d25b963d0bf@cherry.de>
Date: Tue, 10 Nov 2026 15:11:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib: rsa: build the engine code only when OpenSSL
 supports engines
To: aiyengar1990@gmail.com, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Eddie Kovsky <ekovsky@redhat.com>
References: <20261110-rsa-no-engine-v1-1-8dfdd9e5dd7f@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261110-rsa-no-engine-v1-1-8dfdd9e5dd7f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI4PEPF0000014F.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::867) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AM0PR04MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: 543a57ce-5f45-4fd3-b37a-08df3f348d7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10067099003|11063799006|5023799004|56012099006|261022105027099003|261022075727099003|261021121427099003|261026121527099003|261022115727099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: YJsi923z8EC87D9dw8LYmLhgJCKcEJQ7v0H7A/mWpxrxnwtNrcUD7oqb5MVjZEStQlxJofRfkdSeh1/nlxpH+bt6LJ+0LiuSHuv0UvXULgGoBilYYc2uR5RvzNvb+X0lqwXPOCDibCSi2cObRocW04nwqS5nA7YSSgUbNamvSjvzXgbgRhjPaTheFebhb+LS5I0ooLIvV2DrwZziJH2R07lXwkucXEc+anHxLIXdnkPtGG9OkgqOmpotsm62BjOnuDJNmJGEg5k+y3Xg2CPQObx+KxBNyUwEbMGbxvSoQNdYfZe63Tbu2Xt0OYFzP8mhYFYSR9npSPTyWsj71H8vrEy1Cuno6vjCpKsti9EqhOtjPAfz9eEJWrkdTUr9h8NzvE2YvIUF/1T2EuUGSCYMP7224cBXICWkS4zhj77M+BdcrulLjPgox+EQCZfTt1V2iu8+G768p/cgYIKli6efKZ82F9u7+38H09B0ZQcleUUpJ6m9N8xv96k0LoZqwriD3mH12XN5pnr3y8eUI79n8QmazUPVs6OxLCQrkoYBmt7qhioMR5AssWWdRVel4cKoWINWAt6budRitPL6+lBiEinDp9/dz9oK1mKEapFuxNacYJH48FsvaJ85vm2NfMVL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(11063799006)(5023799004)(56012099006)(261022105027099003)(261022075727099003)(261021121427099003)(261026121527099003)(261022115727099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sk1WeUprREtWVXE0K3BUYnEvUHlZOTU2SVdQQkdpeUFSSTI2ZzA0dHFMV3ph?=
 =?utf-8?B?SEc4bXhnQS91b2RNM1hkOGFsem95UUJRRWhPdHkyei9kOEVwdWxybS82c0Jt?=
 =?utf-8?B?SC9XYnYvY0dYR1Jqby9JZFA3R3Fjd0NwOEZiV1BJTG8xdmtBZXNrUTNnR3RB?=
 =?utf-8?B?a1hCb3dZMWNiUVlscXRKRUkyY3VqWmFkakl1Q2NNY0Urc3k5S1RBUzdLajF0?=
 =?utf-8?B?YlVEVmZ0TjdXbGV6OU1iS3ZrNE1zY0tRVXA1VEVxVUdQWk9ZbXV6NFd2MW9r?=
 =?utf-8?B?cnFXTjZYL2swMVhPSHNDYzZHWDFPQ1k1UFRVMC9hOHVQWUl6UDdXVGx4TDlq?=
 =?utf-8?B?dXc0NUFsaXZKRjI2Tk5VdGxjaUVETHh1N25PTUc4Z3pvNTlOd3hFcUJJQjdC?=
 =?utf-8?B?ZmZycGdwcXdPcHhOT1FWL29QUGJ5aTlTZ3R6WWc1dFZuRXBVcTdxaDkzUjBw?=
 =?utf-8?B?UkNiVmh0Ynl0NEtwVFc5RWxpZlpOcmJ3UWQ1bzZaUlhiS05iczY3Y2FBdXpu?=
 =?utf-8?B?WElwcmR5STByZXJ5M2hyaFV3VDN1Zmd2RWxvR3pLR1RiRWVQTEFkOUVaTytL?=
 =?utf-8?B?YUt4S0NGZCtzQ3lRV3VSQUxSdndjRG55bU1YUjlHYlpzVlZ3ejFoaTJNL3lX?=
 =?utf-8?B?TlhkOWI2c0I3RlJiMWdXbmRCZ2c1UjJDZzF6LzFRb2ZpNlpMeGZlVElmbUZj?=
 =?utf-8?B?VWpwT1RYUXdWU01VdnBTc3FnRHFXYkZpTERNMUNhcjVsUkwrak5XdHFqR0xv?=
 =?utf-8?B?RWNuNEFTV1FVVmV3N0tZTzFncWZvbU5ZY0Zod09YdXNxeXpZMnhmREppWDZr?=
 =?utf-8?B?L3AzNldTM3hzUVYvNFNqMDN6MU55cFdwK0Fid0xSVUVGTlgreXFwMGhSUllq?=
 =?utf-8?B?SnVTUXZyMnhwS1cwY1Axa09IZ3dOL2ZvaGVVeENqLzg4OGI4T2RZR1FoKzN3?=
 =?utf-8?B?cGhJb0hVKzdZVkQ3LzhXaTNCbnByK3E2aDNtMDRJbTV4UXBZQjVMVzJSOWl0?=
 =?utf-8?B?cnBXM01abEs0UUJYUW01ekp4MUdQUHJFUHozWUpDNEdIZXF5WXhSZ0NMRWNw?=
 =?utf-8?B?TUppUVgrVE1mclB1Zlo2azVadzhVNzdaQjQ1U0ovOUZOK25lajRYZGU3YVBq?=
 =?utf-8?B?QWtwaUt4UzY0TjZtYm9QSzZHUUlBS241T3ludkprOEF6OWRoZ01KbXZnaWFy?=
 =?utf-8?B?WDRxM0QrazRxVmJXRWd4QmNuT3gvUEZIM3NvRXUzbW9WOG82ZXZWZDJFVWo2?=
 =?utf-8?B?NzFKWVdUWjVJQVFLVGVydzJvWE5Cc2MxeHlMUThEcEV5Z2RZcmhmbUFKbHpG?=
 =?utf-8?B?MzVFNm5FOWZCQUE2WEFlaUlPdGlTYmdZT1hDTzVYM2NCTnZqQ2lDK2FwT2t5?=
 =?utf-8?B?dDZiWEZxMG13Q0Q0cTFQR1NTZm13S2ZOR3N0eUVoU0hWbzFac1BDaVNTNlpa?=
 =?utf-8?B?aWd0VDB2Q2NLUnZ3anJUVWtPZWwzUmlXOHFtUGRtTTIzK215TkxURll1YU9t?=
 =?utf-8?B?dFJvVlZjc3VGZXVMRkhEVG9WT0MrRVMvSjlwRzdEY3ErVUswenhrRXcyS3pQ?=
 =?utf-8?B?YmNGeXYxeUVBZ2YvNzBhQjNYWVVSWVhldTFLN2dRS0NYbitIMHh5eHpsQ3g0?=
 =?utf-8?B?ai9FbGlNOWJxREZoZzRyWkZjMnR0RVNpVlBKVXYrUkxlYlJlWER0RTBiNHdV?=
 =?utf-8?B?Mys1Y0pkQ3F6ekZGbXJnU2F1VEVZWitKWXJEN3V6cng3RWZ3MDhlajhJNG12?=
 =?utf-8?B?by9FMEJKR0w2a1NVTi9OZ1N0Zk1CUGpJc1dqU3UrSEU4ejAwMVFFb1ExVHRB?=
 =?utf-8?B?RUQ1WGF2R3dtNkdKVVFFU00xQjBaWXgvNkkycUQzc20zbmZnY1RqcDRDbENo?=
 =?utf-8?B?cmN3cmVrV2dlcFZ6c3hUYm13MmZOVG5WSFRXdUhEM2YvOWZkVU5VbDFHMWxZ?=
 =?utf-8?B?cktlenZTN2RoL3JmeWdSN0FxZnBMYkx3OGFhNHVHbk9USVJ5eDNxS1VaMjla?=
 =?utf-8?B?enlxWWFIR25yTTlYVFg3NzM2OXk4Y3hiWHV4eXl2RG1CaDY5UUlYeVMvaDkx?=
 =?utf-8?B?dUN5MmxHdm1NeTZTdldYTG0rdFZnTkpkOUFiWHVVbThjSnZvTUlVeXhUME00?=
 =?utf-8?B?Q0x2ZUZzdGxiQU9RWm9VVExsVzE4MnFTN2ZkS2RlbWxRcnFPYkIvbXUvSVVO?=
 =?utf-8?B?VVhJOGN5TWdGNlNneWliZXRTVDdWMXZieDdHYitWcXlMSHFIbFVlU0ZKYU1K?=
 =?utf-8?B?anFVZnE1NnN5ejBQaFV3Y2l5NEU5YTdFRDlsUmlkd0xXT2lzWkhvRithOHBJ?=
 =?utf-8?B?aWFFbStlTWNJUDVZUFY3VWVGK1BpRzI2TEZKR3l6aDRLVkJKc2dtQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 543a57ce-5f45-4fd3-b37a-08df3f348d7c
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 14:11:45.5687 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hu+44yWx7agUzATzY1f0pQVDMuQMNZKtdc5yJgkuhc2ptT4KfJV6QkI2FJ7tKfijZdllb4mGjKTebIzrcKauxz5oNBcGnxQrpDJQh1jx020=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6833
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

Hi Arun,

On 11/10/26 6:32 AM, Arun Iyengar via B4 Relay wrote:
> From: Arun Iyengar <aiyengar1990@gmail.com>
> 
> OpenSSL 4.0 removed the ENGINE API: <openssl/engine.h> only has
> deprecated declarations left and the functions are gone from libcrypto,
> so building the host tools with it fails:
> 
>    rsa-sign.c: undefined reference to `ENGINE_load_builtin_engines'
>    rsa-sign.c: undefined reference to `ENGINE_by_id'
>    ...
> 
> OpenSSL 3.x can also be built without engines (OPENSSL_NO_ENGINE), or
> hide them behind OPENSSL_NO_DEPRECATED_3_0.
> 
> Compile the bodies of the engine helpers only when OpenSSL is older than
> 4.0 and has engine support. Otherwise rsa_engine_init() reports that the
> engine is not available and returns -ENOTSUP, so "mkimage -N <engine>"
> fails instead of quietly signing with a key file of the same name. Keys
> from files work as before; with an OpenSSL that has engines nothing
> changes.
> 
> This is the "unbreak the build on OpenSSL 4" part that Quentin Schulz
> asked to be split out of Eddie Kovsky's "Add support for OpenSSL
> Provider API" series (v5) in his review on 2026-11-05, following the
> design he spelled out there (the condition, the OSSL_ENGINE_SUPPORTED
> name and failing with -ENOTSUP inside the engine helpers). Eddie did the
> groundwork for this; I'm happy to drop this patch in favour of his v6.
> 
> This only fixes the build. The binman engine tests
> (tools/binman/test/fit/dummy-rsa-engine.c) still need an OpenSSL with
> engine support, and OpenSSL provider support is a separate topic.
> 
> Tested by building tools-only_defconfig against OpenSSL 4.0.3 (link
> failure before, clean after, no ENGINE_* symbols left in mkimage) and
> against OpenSSL 3.5.9 with engine support (unchanged, ENGINE code still
> built); with both, mkimage signs a FIT with a key file, and
> "mkimage -N <engine>" fails with an error.
> > Suggested-by: Quentin Schulz <quentin.schulz@cherry.de>
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
> ---
> Eddie, Quentin: this is only the OpenSSL 4 build fix from Quentin's
> review of v5, kept to what he described, so the tools build on OpenSSL 4
> while the provider work continues. Eddie, if you would rather carry it
> in your v6, please say so and I'll drop this one.
> 

Please ask for permission from the original contributor *before* taking 
over someone else's patch, this is really not OK. It's good etiquette to 
leave a patch to the original contributor unless they are not responsive 
for months (or weeks/days if it's really mega super duper urgent, and 
even then, we should publicly ask before doing so). Eddie has just sent 
a v5 so we are not in the case of him not being responsive.

By stealing someone else's contribution, you discourage them from 
contributing in the future and strip them from their own voice when 
answering to review. Eddie has put a lot of effort in his patch series, 
and so it is only right we work together on getting his series in an 
mergeable state. You're free to review patches, but not to take over 
someone else's work without their permission (unless you've asked 
publicly and they haven't answered to that request in a reasonable time 
frame).

You can see[1] I asked Eddie if he was fine I take over the part where 
we fix a build issue on distros with OpenSSL without engine support. You 
can see he answered after that but didn't give his permission to do so, 
so clearly, this is not an option right now and it's his right. The 
project may override his decision at some point if we feel like it's 
dragging for too long and it's in the best interest of the project to do 
that, but that's not the case right now.

[1] 
https://lore.kernel.org/u-boot/f7b2f1f2-e8c6-47c1-8e47-795f6ade7618@cherry.de/

> I developed this patch with Claude (Anthropic) as a coding assistant: it
> read the review thread, wrote the code and the commit message, and ran
> the builds. I reviewed the result and the testing is as described in the
> commit message.
This part is particularly infuriating as not only did you steal someone 
else's work, but you clearly didn't even put effort in doing so.

Maybe it comes from a good place and you wanted to help, but this isn't 
it. This patch is therefore rejected.

Quentin
