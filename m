Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A44606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 15:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=exhMBWBc;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=mBMIuItn
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC1424082B;
	Mon, 16 Nov 2026 15:45:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nyfmfNerFvUr; Mon, 16 Nov 2026 15:45:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 33C07405E2
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794843939;
	b=aoCgYPDjkVb2Y5gySxAs9sBrKpnLIhyPpt8rSamNyW8TCngxb/ujsePbBNHdeYVwyTn9
	 kKRFYZQPQeJleCJ+ukj1OaOvVkg3l8QC2hP+xe0LZDNTZaH4R9nqpkwA0U5F1mjJRXj6L
	 UUHzn0t9XdXcTd4ZEINFiWYZd+AdGML751ImHysbA4CGmvvAoHks2JgueQDGMJCjX0AK8
	 xtrLtSLUL5thZVdLORqvUvUg4pypvHfKhIBKidfACI0XBBMWU7NfQ/4xv/8UMDq04j8ns
	 UyXl69Vet3kLjuDXaeTdFzyi1OHi7jMNT1zQm+lfVjY+Z8YBgOOSk6rXWctyIoGe31w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794843939;
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
	bh=6/2qCaUR31JvUxYcB1C1lcddmzND9ZmcmbXUf1rLyPk=;
	b=HqFlFGrxjXLliz6CytjICgOuBl8rHOqMZO+l3QgB+g6bQuxjJRSbHvL6MZlEvsrQLcsv
	 xYjTKFPGhWcqEHhIMP63NBiEI9+HNLxibi9J6W+Fim6AlHinCW7O5pQtjDYdD2MFYLOTk
	 WHPCvqo3vJf00sEkBf3u30oX3ULlBZ2NGHbVGdoQId3Q5GUdD7KoRPgyXNZUj82J3qjP4
	 kmjF0MMXAUslFpVt+Kma2eH05P3Zo7SaoCF0KI1kGYg5D6RZ2mRwQ8+m+LR8icHG5wJec
	 cjzSz5/CjiMbTYH86Zogv8kou7m0eMhNrMTi6EAegBynEEw/ZzbBEWw2H8NxoRy+tog==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=mBMIuItn;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794843939;
	bh=6/2qCaUR31JvUxYcB1C1lcddmzND9ZmcmbXUf1rLyPk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=exhMBWBcMlqbKEVCNcFRh9wjSTxeidscLJA8A8HQ7EnsgdLb5BQsvD81brUAtIrdN
	 +aRd2P08+b2faKfrmWSZ8ps+96kZK39TqdqlRSXFsq8Ir8bVsicof8ZmP98+qCGZjJ
	 3tPEod18SCfovihwcmtgXZG9BZScB2w6XVId3N/Kmnh6TxCMj3fVZqfWmq2Z9Ac0Tf
	 0rsWz0J1qVDqrAfxbU+n9oA7CMV0ksTCPBBpD9pOPyStKVd1HZqCXnudqaacflqGaF
	 b7kMt096rUPSXwvOxpwDiQuZ7lG27JoYyKdccMnFLZOTukAEt58XZ08GUMKc1R0QBx
	 +UBOk37LBxzzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 33C07405E2;
	Mon, 16 Nov 2026 15:45:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7FB762FE
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 15:45:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 683AD405E2
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 15:45:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sRf2Zn2LGLB2 for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 15:45:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5AC9F405B0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=mBMIuItn
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5AC9F405B0
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 15:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/2qCaUR31JvUxYcB1C1lcddmzND9ZmcmbXUf1rLyPk=;
 b=mBMIuItn7q2URjoXAZIlIqTD6+goGAmEdYfU0FoFmYhBiWK8eH8UnnweA0H8trgGzp9xysY9usHW7W873hD79aCX2Ay/90PVnyhHj2rkQ3ti+/I5iZZ7McK/wCJA6A90UwgDTcSJwSNtyyCjqIulLKA0NV7BNiay2s3tIbz5vvA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AS8PR04MB8277.eurprd04.prod.outlook.com (2603:10a6:20b:3fc::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 15:45:31 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.009; Mon, 16 Nov 2026
 15:45:29 +0000
Message-ID: <fbee6c71-f2ac-4650-bb28-83b1a6fe1e51@cherry.de>
Date: Mon, 16 Nov 2026 16:45:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] video: rockchip: Set return code
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 u-boot@lists.u-boot-project.org
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20261116-rk_video-v2-1-9d78708245a5@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261116-rk_video-v2-1-9d78708245a5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0049.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::7) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AS8PR04MB8277:EE_
X-MS-Office365-Filtering-Correlation-Id: 8199aaea-fe67-4751-ed5f-08df43f8a3a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|11063799006|10067099003|56012099006|261021121427099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ckJWQ1bEeV0GN6/sIJPGFGKXJzepthKoDQKu+lEjc3O/mE+RYCz1P1+14s1C1cCSEmkuL+2ZJYQT7scMMz1Cv4/IJo+oumBkvVnzObm138HCFCc5ayGteI1pcAoxsHScyEj2LWJG4L5kcLnwXGoOxgOAH9/s8PJCN2uhjvFGk2tmKu42PpbUZXwqJfqkGdxMReuPSbWzwqeAyvLqVZBQWpaktLEPIec4DPc9bgqs99tqCWUgfXwM/EgINFvswCz6w1JM0uGBC3d/EF/ZchXpfylPm97yJ0TsMoJpIB5uDb8jkcIfFapwSrV7NbcvAeYjPY7zbxLDW8X0DYx1hXbxb44a0fUZSAaTqM4Yi7/df1TASBmDl6QUIQ/n/PsHqGB8252CNNZjllb4LeKty+4Hm94K6qEl2EIsTk05VSjORRw7tHOH1B/C/vpvC79WBuQ+Cxa71DdFmDkqHU8fAraBEEiMNK7naYkiNGgwVvyOeh3Tyber8O74vN5yCH2p3e1yO0I0s8cLQS5X36D7pxr1vaW8o5ZI74qsomEQkTqBInTXD83rpHgyTol54Wprxj2/q2Wf7FR5U8Pky3DPgOjfMyv8w2GH+23yLgqq6F2iyuLFE+fyQGt8eGZLVBYW60yXACTjuJbBDMnDq/c0+qmAoDTzB+hH+mBw6ps2+sPq/fA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(11063799006)(10067099003)(56012099006)(261021121427099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjJKQ01jNDVqenNaVThMSldwZ2JrV2t0bE9OTldZNVZCT2NqNnU0Q3hGTWVX?=
 =?utf-8?B?Nk1DV3VXcFlUSVJLaHBBL056ZVNwZDlROHJOOUtLMlprcmc5a1RtWkxKdE1M?=
 =?utf-8?B?UDRaVUNXS000Qjl1b1J3NGEwVjJJL2dHNXlxczZuU25xazNSa25rVjFRMEhM?=
 =?utf-8?B?TkxUaVg1dFcwR0R1L1RDa0tIRTdaMGg3VjQ0dktmZW0yM3lmdFZuSU1DVUVK?=
 =?utf-8?B?enJDSS9NT0JNbC90aFRKTldGcEo4akFUMkp4aVFyYnFDTzI5cHNuMlFKeWQ1?=
 =?utf-8?B?QkVTN1FwOFFna1Fud0xhVjhCYkt1bUs2ekFqL290Z3FhQm8wNzZsdXdJNmth?=
 =?utf-8?B?dVVZdnVVZFdZZ3A4U0R6T1hKT1ZEeGQ5Ny9IRUhqVXRVVjc1N29VNHdRc3dV?=
 =?utf-8?B?OGFaY1diaDkzbkRKZWxTNnd2akhiSTBNS0pYdGltZUQyYlhTVVp1dDF2bkJY?=
 =?utf-8?B?RDJvU0xtZXN1RUR2SFVxeUVzbjJEQXdGWGYwaEl2c1pjeENyaWpidXFGZ0VD?=
 =?utf-8?B?anp5NXhJL2ZORlNzYUY2RVBwa3dkbFYwb3prVDB1RldaMkxJRnpGdHNiWTBx?=
 =?utf-8?B?TzdIUHh6TVhYZThqN1Zrbjc0T0VrQ2prSHl6SU1iVm10U0RRTnJtSmFHYUZ4?=
 =?utf-8?B?TGNFaHNHRDBHOWtHelB0aFBDclAyNGJlczBiT0RNUnpudlFtbGN4TmJQVEdU?=
 =?utf-8?B?QXlRWFJXdCtFckprZDh3SEFicDc1RlM0b1FvOUxvNkpBYThCODdWSDlJTlRU?=
 =?utf-8?B?bFZJU3AwbHBBYWtScmF6ZnBON0Z3a3J6OEhld2ZuOHhkRXp5c0swcm1sYTRn?=
 =?utf-8?B?QnBlQ2xRbTRlOHZwd0M4Mlh4dUZUTnZrdjMxTUsyS2ZSSm5jNmNlMDI4SlEz?=
 =?utf-8?B?UU1RYTBQZncwZGJtWVA1ZXlFYk1XNFBCUEEvRlcvdFFndy9ORXZHdWR3d09a?=
 =?utf-8?B?aFA2bS90M1pMNEdac1N3N002QittVG1TeS9LUnFrbWp0SXdMVWJVbmxucS9I?=
 =?utf-8?B?S0xvS1UrdjNsWnM0TEMyQUJ5Q0RmZGpWRjZXdzg2cWlMNDVrUWZQaVNOc0Rk?=
 =?utf-8?B?VTladFRXVnUrQXVHWkFNZnA0U3FZR25MZWhzeWJ5dnEwK3prbGJCc213eGVR?=
 =?utf-8?B?VTRCaFNNWjVBVDNscnB2TU5NWThUb2VSRjhXWUpJbGFWbE02eGNWSlc1Ulov?=
 =?utf-8?B?Z2JoVXF4cUdRdWJ5L0hFaVB2R3dSWUJrazI3MGpjd1I3S0dJdWx2dEF4SUh6?=
 =?utf-8?B?TmRRTnRQQ08xTmtTeVVLWUxhOHZzRThOK2w1Y1FZb2J2Ni9iZ0ZPZ29xVVZk?=
 =?utf-8?B?bVZqekZUTFE5czdQVnluc1lRTktaSzhibnY5bTNxbGhtQmE1c0ZjQ3BMdm9l?=
 =?utf-8?B?QlBXT1JFMkVhODNYcjRnVVk2SjNNUlovRUd0cHRNc3duYUo0V2pIdFVGZzRt?=
 =?utf-8?B?UmRHNHNIRDRlanZoTm9SbG9SWG4yOW05UjNFQXZvd2lFczV4T1g2WVlTeVVu?=
 =?utf-8?B?dCtlRlVxdS9vUXAvZUxIN3V6UW5kbHh2bFZ0aTFtbmZoekFROE9wMmt1WmVJ?=
 =?utf-8?B?Rm5wRDNIMXBBZnlwbk1vampDbG9URUl6WnpTOHBEZ2lPQll0bW9lWGdjQ0tn?=
 =?utf-8?B?WWJ3RGVQZUk1Zm0zbUhpbUlDWWF6RE5mejdnUlRBUWx0ZzJXb1RhNEFCU2Vj?=
 =?utf-8?B?ZC9MWFNvQ3MrTTRqd2Fac0dQME0zUDlCVy94WFZ3bis2eUg1d2tRcTBUUHhx?=
 =?utf-8?B?ODJPVWNVSXdUd0RLQ0FZWFVXTlhXR3NjWFp0K21vTjRHbmY3Rm5SRU9VUWdM?=
 =?utf-8?B?Q3NOeER3dEQ1cERjQWFNSU5SbXVXTTBMZ3B1Unc5SkJCTVA4QlNCZzI1d0Jx?=
 =?utf-8?B?Uzc1c1NWQ0Q4T2kwbitMdFJoOWc3SHREdllDUmxCNWxsZDZqUlhHOWxndU50?=
 =?utf-8?B?N0NLYnU1R3NlZTVwNnpZV3MrQzllRFFQdVkzQWVwRlM3TVVCK0RGT0xyZmtM?=
 =?utf-8?B?Q09VY0c4b3ZBM1hRL3E2YUduMG9ZcEdSbHVjRXZpZjAzODllaG91VzF1SVll?=
 =?utf-8?B?Uy9lajdXRC84bVhCUG9XZk1paVFjWUFXMG1VM2JyMUdVNkpQL2pzWTNoNkFE?=
 =?utf-8?B?TmZrL1AvalM1VkNRUXRPemlCNjZrWlpSaEFod3dwTWk0dC9nSDdEMWIraFpC?=
 =?utf-8?B?VlI3ZzFEbmdhWWlkSE02emIxNFQ4WnJPOUpRTUxENTBzNDdpdjc4K01ya3F6?=
 =?utf-8?B?MWcyR1NXajNIYlQ1YmlRT3RNbmdIcGhyR0tCa0RMZXZ4MGJJcGp4dWhGZzc3?=
 =?utf-8?B?dFI2SWkvQitNUlV2RmltbXhOVXhwMVNnM3JiWi9ZNFNrbStPdjhXdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8199aaea-fe67-4751-ed5f-08df43f8a3a2
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 15:45:28.8757 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lv1zmSyhhmptFZMdJjE192bmFg08BeErD23sFGzNXB71GUK//+yYjuCQiSc6nVMey6V+0KBjFAVStMKqPktrJibGjNAVP8u/B2YGUU85k8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8277
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

Hi Andrew,

On 11/16/26 4:13 PM, Andrew Goodbody wrote:
> In rk_edp_start_aux_transaction the check for "AUX CH command reply
> received" returns ret as the error code but it has not been assigned a
> value so this could lead to the calling code silently ignoring the
> error. Instead add the code to pass on any error returned from the
> function call.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Since it's been a long time bug, one more release unfixed won't hurt so 
I intend to take this for 2027.04 (next branch).

Thanks!
Quentin
