Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 295F9C369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 08:57:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A15181F45;
	Fri, 25 Apr 2025 10:57:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="g6w7ZtDV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA79381E72; Fri, 25 Apr 2025 10:57:18 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2070a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::70a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5997D81E72
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 10:57:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FbNGYPvQO8ABXUuZ5SDem3K1SQtIQT+Z3JwWf2L0agsh0924coroodzJ7r6y4HLDlaBJFpnwVWWcBkcfM62uGsKREFO2QSS7x62Duhyb7Hn0D5Up1rz/oPNZCzAsBoChh/dKqntZ+zRFoaDzBmIDILNCfc7WHnnHYFflWut1sWXie38V2ai/Cygcy3FgYAW/dw8RBRnQXbFq/3CyVa4zA2ti5NdBEBr79P9ef6IupCjJnmOuuE1WNcM440Mb9rynoMzE32oHSJpJVVjXPZJva1cnmb4dtDNaQ1++K4sOfY8d8MIbhhPz6sDWia63gsqAQJJTqPuI8ENt/ZbywZRn8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BeyAzrxEF7SkrtJaeTPFyGC7C+ixE2DggJeNqQVapE8=;
 b=Jb0tdP0sRsVxVwG8LlvBeUkGDFESs2DAIg3Miw+26p09lTRLaWV7Mtr4eNt0jFtWKfL655A1Zm1DHx0HkoiLgTDMvIXCL49kBcIRHETuQ97229WGDrGfLYSJ4JY2PYz/Xioa1B73raPpNIGvJqghx7t6ouUPHVLCBTXCVgXFeKtGydXz3kdvsdmx7FPPMQDWZ+nREv+lxAt9VY16ojNViY1GOPxhJ67R2MNFR9e+RUC04tETpv+lHIm4HZgtK+tuggOOYq60FMDNWWSTOX60cIrIcdy5uya/Of1duqFANXfTBWf/zrGZhm4Uw+urLezcXz0Qor8VanLQBuh28K4/Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeyAzrxEF7SkrtJaeTPFyGC7C+ixE2DggJeNqQVapE8=;
 b=g6w7ZtDVR8mSTH2FHghQkoErvCCiY56qrBnlwwEycgMGRmMKbwmx99FXl41yMUuVyErurE14/Ursu/LDWiET2giaCsiKzuuBVU/Nyh5BoSq8RJuLBrWHfJLsXBH38WZeaafrFqs8mFrlSqKdHSXRsQFix8hdfW61v7zkIeX/VzaC1/yVikU/svvwmO93sbu8H2SlFBWPRZil/JBNkaP5vs1Wbo9k+p+8NdFmRgHWKDxFhQWUMsfYlE9Fwu/htAUHO5rXf+YJHArl77n7vWTIKzOp1wF0WgjLMjN5schwoWhEySTBQjO4Fv7Iq2kZb8A/SFEaXeZsTWaN/amEloNafQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by AS1P195MB1544.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:48e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 08:57:14 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%4]) with mapi id 15.20.8655.033; Fri, 25 Apr 2025
 08:57:14 +0000
Message-ID: <f66ee984-8140-4f36-bd08-4c71e8a44256@phytec.de>
Date: Fri, 25 Apr 2025 11:57:12 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] power-domain: Add support for refcounting (again)
To: Miquel Raynal <miquel.raynal@bootlin.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de,
 Samuel Holland <samuel.holland@sifive.com>,
 Neha Malcom Francis <n-francis@ti.com>, Heiko Schocher <hs@denx.de>,
 Fabio Estevam <festevam@denx.de>
References: <20250425-ge-ian-display-support-v1-0-8a7a0fe75023@bootlin.com>
 <20250425-ge-ian-display-support-v1-1-8a7a0fe75023@bootlin.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20250425-ge-ian-display-support-v1-1-8a7a0fe75023@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0068.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::21) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|AS1P195MB1544:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fdd10c4-075a-4a48-6642-08dd83d72c60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YUxVdjB0eXU1eS9KMmtiODJmaWpvWjR5TTVHN2EwQURTeVU3Q2NXWkF2ZlBv?=
 =?utf-8?B?aHJMSkxwcVFQcHhqYml3bjU4aGdwR2Faa0JwbzZVM29ReC9qd2c2TUpKYXVa?=
 =?utf-8?B?M1NOVFRCeGwzN0FGMkVOS2pXTE9NTDd3QkFYaHlCWmJ6OFkvMThIY05TY1Uv?=
 =?utf-8?B?WFF6MVFXS1dyRGxnZ0NqcGhhWTlNUjRqa3Y3bFR4RWYrS3NZcnpJTmFTbFdB?=
 =?utf-8?B?NHlTdlU3d2g5WXB0NnFpSE96QXBIcVhFcjJ1WHBaVDhCS2FxRHV5RkZ5Ykhu?=
 =?utf-8?B?Uk50eUpkQWJ2dm1oelNWVzVQMGszaCtVbW1nSUYvUkJuUXBWcFF2WjdqL1VV?=
 =?utf-8?B?d3FuRmxZeUVHam1peDBoMExWNm52NVdDTzNKNkhpaThMWGhXRUdNcVF5bFBD?=
 =?utf-8?B?SVc0cXZyMndGeTFNeTJsa09ab1J0cnJobDY5bVJ5RDRldkxxNWJXMm1oYWRv?=
 =?utf-8?B?VXpqc3owM04rbW82NU9odWgrRGgxaUd2ai84Y2l3eEJtK1NDeE5udHAvVEUy?=
 =?utf-8?B?cEd4dWxXWEtRYzZkNFBDZkxmMzZobSs0NnZuSWxQdlk5RU9PSmVQV0pjclJq?=
 =?utf-8?B?RkltT0FMMW0wZW1tRmFoV3pwTElGejRqUHYrdFoxV2ZhSnVWVmV6d1F2YnE4?=
 =?utf-8?B?Ri90WHo5QnFJVmVOVXB4WnlyL0huazRGUmJwSUpoaW12RHBvVVdVZ25zNVhD?=
 =?utf-8?B?aVluWEFaMitFTU44NHlTVEhMa2N4UEpYZm44TmdydEhzeHhHTUxUVzgxRTUv?=
 =?utf-8?B?dFF1aDYxRVNjTTRQRitOKytwT2h2dFZWSjdFYkVubVV4dmExQUwzUEFVVGli?=
 =?utf-8?B?b1cweWFzdzFkMExIWnV5Z0ExbWRoUXUwL0RZa2g2YjRUWW5NTG5aMHdPUkJZ?=
 =?utf-8?B?TnBvWk1ZRjhKNStLUUtxaGpOdXNCazMySVNjT1ZPcDlIRlozUVdJM01NK3hJ?=
 =?utf-8?B?ZjFvM3phVXpLOUIwWTZNc3Y2N3lrMk5DelhWZVZqNmxaN0JOcy82eW5RUmo5?=
 =?utf-8?B?V05Kay84cURCVmhFWlBLMFJvbU5jc0xVSG9RaWxuekxIdWIwOWdHMGRlSFAx?=
 =?utf-8?B?Umk2MTBidmp6UVJDZXllNGFjN0hEYWZHcVFnRlYyQTZ2TVBpQlQ4eGZ4cDMz?=
 =?utf-8?B?UEFsOVdNcXM2QzE0bnovdjhJZldZbDFzTk1VTGZRa25qSTdjWXZDM2ZFQXVh?=
 =?utf-8?B?b01nWElDTy80bGEvcEI2ei9lbVdFSXg1MWF0VGxnS1QxMXAwb0xNNFY4ZVZ2?=
 =?utf-8?B?Sld3NHhBeUxEMFhrdEkzU2phRC9jdStrM0V2b2pGL3FVQy9XMWtMUmw2YXJQ?=
 =?utf-8?B?QzR5Y3J5WnpZRVI5R2dSbmo3TzVBZFdQb3hlQXZtek55QU04a3FrdnJzaHlp?=
 =?utf-8?B?cVNPK1pieXo0SWV6aDRZT0VVbkJkaUR5QXc2cVB0QmJqeWpqVHRsVTJTM0FF?=
 =?utf-8?B?clQydm9VNUk1VFc0N1BwZzBqUGE0ZGFWYmQ3ZDF2SUhHUmRGU1BocHRtMW9B?=
 =?utf-8?B?TGxsSlRybzV5M21XcWxYdnJmYkpWOVB3VDh4VHZmd2tEb2dJN21yeVV0eWs5?=
 =?utf-8?B?WjNWMlN5R1BHNUt5bFFSc011N1ZhQndBSi90NmhiUDlSZGFaS0xpL01VTXp4?=
 =?utf-8?B?bTYxTWN6L2NNUE4zL1Z2ZmJ1cnp6ci9ZNzJiRzZhbm85djdPN3h6QU1sbWVp?=
 =?utf-8?B?d2k5bEZqN2IvQzRCTUVGbVc4SWpITW9QejdISnFyVEJiY1kyQk91dVBJNSt6?=
 =?utf-8?B?Rjl3Zk1DS0JaNk9RdmpaRG5DeGhIbHB6aHQ4NVduWW1pVUlSaFJhZGZmMkJV?=
 =?utf-8?B?SGhrVjNrb2JYajlSbmRhWG04cGdKOC9nRWtRZmhrdEZiSVNMczRGbXo0Ui9D?=
 =?utf-8?B?YjhYSGlxS3Q5Sm1VNDE0MEo4OW5QU0pNR2RXcjIwR2kyYVBUT0owQWMvVjNP?=
 =?utf-8?Q?hnDeQpXM/XM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHNETGdOS0ZuMklIeHEvenF3QnRoOXMrRWV5QWVjdFBCeDhIWjFwLzBnRWdU?=
 =?utf-8?B?U3FPc0U1c2VyY3Z3MXBScE8xMFlKd25DSjgzN2E3ek9CRWJzekMvQ1hndkpq?=
 =?utf-8?B?L2ljU3N6VlNVSVJqQTZNMTc1ZzUyMWF5R2N6RG4zS1YzNkhLdjF2Mllxbmsx?=
 =?utf-8?B?cjVub1dZZFMxdmdDWldIalJ1empWeDBuYnVLQU9UWmtDeXFxU3FsS3plSzV5?=
 =?utf-8?B?b2lXdERpbkxZL0Z3R2tSYm0zd3ZDV1lIa3hKeG1SWGpaUXJpaVJ4bllld3Br?=
 =?utf-8?B?RTdsbjVxaE12b3hZSTdDbEF2SklkTmdJNVExWFV3WTB0RjBkT1NNVnJKUVNE?=
 =?utf-8?B?UnhIdVI4ZVhQbWtIcjNFcjhlV0pyVE5sRjh2VEtkUG5tVStGTWpCZXZiejdo?=
 =?utf-8?B?WnJybmpYbEVxRzYzTVpQekxUUnRlVXA5K2diY1FqNjJrbm93S3V5OW1sVUt2?=
 =?utf-8?B?MHR2SU9OZjdGY1JVdkZuanBVNDRZdzdqNTk5Q3hTamM2YWJUeGphZm1yUnJ1?=
 =?utf-8?B?a0g4MWpvYlB1NWhVMXdLRnNGQWdaMWN1WDlESWk2QjVDc2hhSE5tbE1uVDV2?=
 =?utf-8?B?U2N5QkJYWHM5RjBGbDQ1VlNkbFhvRUNIOTQxdHZ4QnhXdmdoSSs4emNvaC82?=
 =?utf-8?B?YVY1Vld6MTUrQmprdlZjbDBVWitIVmJWb2tGYThReFIreTYzQ3Q4cE9ldHFT?=
 =?utf-8?B?K2xWaGxPbzRMOVo3UDRGYVFMelBTS2pNYWpNMzYwSmEySWRYOUhKenRsbW9O?=
 =?utf-8?B?a293WUNDZHlZaDhsNkY1bjdseFFSZlhxUUZ5UXRjTGw0dnBYcXkzSFhqQUpT?=
 =?utf-8?B?bHFKc1YxWDc3VVlnSG5qeTFZLzRsMGUxZGo0blNnaEhuRXVMQ0ZDYlFXVUF6?=
 =?utf-8?B?ZUdYRzZaajJyUGNjQUZDcG5qM2ZNY1FUalZhVlloWHczSXpUd3B6dVBHOWlB?=
 =?utf-8?B?L3owa201WVpoVzhmK1U1ZUdiUzNZN0xUMExDWEIwT0xJUDZIdFdTcHI2cFo1?=
 =?utf-8?B?dVM4bEQrYW1ZSFBBK1VHUXdkWlNVaVE0Y1JwM2RVdkxoOVVLODVKU3k3eVVt?=
 =?utf-8?B?SnJsZUd1cW9UcDJldkZmTk5mRGdKVG1ObGczOFRwUjdTMVZUTmY3ZXBoaUdV?=
 =?utf-8?B?bUl3djZ6ZzluQXExOHRDaG16blZIdjZLSnE5MDBBamxIejVtM0lxZFpzRUZm?=
 =?utf-8?B?WTgzR0NNNmo1VWhrbDFPdFkzNFFGcmNUcXptRmVGK0xET1dLZFZlWFRydjVC?=
 =?utf-8?B?bnFtRTNSaHBhamlQakZra3NpZlAwc3F3SWVEWkxLaktwZnBzRSsxb2ZCWFV6?=
 =?utf-8?B?cjIxNGJqWUNrQU4rT1ZkM1NTTk9BbEFwRU5kNVFTcUxOZGI4UEw4SlJaaXE0?=
 =?utf-8?B?M0hCOUh5d2dxU2dOZ3hvZHdwVEZqWlBVUG05eHRRS3lQckc5OTAwUm5tN21H?=
 =?utf-8?B?YmIzWHVhamRCVGJnTGFDVTE3bGhyS1BpVDlNZFVlTlN1TXJ3dlhQbmhoTTBo?=
 =?utf-8?B?VVNEKzNkWnBSMHFZVkFsc3c2Uk5xVlhINm1WeGY0NFdCKyt2SlV2NVM3cHIy?=
 =?utf-8?B?MytEV3h4eWJoYlB2bWZaWjZGc2txS1BYc3hyN2lvTDcxWlcyblhkSGVXUThS?=
 =?utf-8?B?blVKNVFWaU9Vbm94Vlh5S3VwVXVZQjFoTUhGbUJ3MjZlQytZUEtTaU5GRXU2?=
 =?utf-8?B?WHJNK3psY3h5UkxyR1hCbllLQnJseUhhQjl0RmRhb1F3MnhEQURzNFZ0Q3d5?=
 =?utf-8?B?ZFZGVnV5UTBFeTBkWFAyM045SjlYejlXdE1uam1KSzNMWFR0K1hXdmplVVZM?=
 =?utf-8?B?eWkvU21tbXpBMXFpUEdUTWtUZXd3NDd6QkNERU8yQzZXSlNCLzFqcmRGTVdT?=
 =?utf-8?B?b2FCaTBUUWpGOFNmQnlRTDhoYXhMSWhncERYYlJ0UUwxSEtGWUJ6WnZMSFZ5?=
 =?utf-8?B?RjIwYWtINnM1QmxTUll3QkcwVHVTNFM3REMyNHNmbFh1anVHWTdjTW4yVVNU?=
 =?utf-8?B?VlpRQlh6TnJVcXl5emNCSGlqMWZ5VnVLRWh5OXdJMGZhRUdzNFliU1VkZDNT?=
 =?utf-8?B?RElrYjBRRjBIb09wbGk5b0t5UlUxNlFTS0JlOThHTUJBc3JaeVBvVDJMYWRG?=
 =?utf-8?Q?3o2TcF/Fg8QpRkX5oUJRqpu5E?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fdd10c4-075a-4a48-6642-08dd83d72c60
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 08:57:14.3485 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J/y2Ip7aDVWTa+wqzVuEykaKHk5AysZ4CzD+fNNRvSoSVVkMqzUlBjsOYRCnxTJFO0+jPyF/sZ1rGdAGWlatPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1P195MB1544
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Am 25.04.25 um 09:49 schrieb Miquel Raynal:
> It is very surprising that such an uclass, specifically designed to
> handle resources that may be shared by different devices, is not keeping
> the count of the number of times a power domain has been
> enabled/disabled to avoid shutting it down unexpectedly or disabling it
> several times.
> 
> Doing this causes troubles on eg. i.MX8MP because disabling power
> domains can be done in recursive loops were the same power domain
> disabled up to 4 times in a row. PGCs seem to have tight FSM internal
> timings to respect and it is easy to produce a race condition that puts
> the power domains in an unstable state, leading to ADB400 errors and
> later crashes in Linux.
> 
> Some drivers implement their own mechanism for that, but it is probably
> best to add this feature in the uclass and share the common code across
> drivers. In order to avoid breaking existing drivers, refcounting is
> only enabled if the number of subdomains a device node supports is
> explicitly set in the probe function. ->xlate() callbacks will return
> the power domain ID which is then being used as the array index to reach
> the correct refcounter.
> 
> As we do not want to break existing users while stile getting
> interesting error codes, the implementation is split between:
> - a low-level helper reporting error codes if the requested transition
>    could not be operated,
> - a higher-level helper ignoring the "non error" codes, like EALREADY and
>    EBUSY.
> 
> CI tests using power domains are slightly updated to make sure the count
> of on/off calls is even and the results match what we *now* expect. They
> are also extended to test the low-level functions.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Tested-by: Wadim Egorov <w.egorov@phytec.de> # On phycore-am62x

> ---
>   arch/sandbox/include/asm/power-domain.h          |  2 +
>   drivers/firmware/scmi/sandbox-scmi_devices.c     |  1 +
>   drivers/power/domain/power-domain-uclass.c       | 90 ++++++++++++++++++++++--
>   drivers/power/domain/sandbox-power-domain-test.c | 15 ++++
>   drivers/power/domain/sandbox-power-domain.c      |  4 ++
>   include/power-domain.h                           | 69 +++++++++++++++---
>   test/dm/power-domain.c                           | 11 ++-
>   7 files changed, 177 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/sandbox/include/asm/power-domain.h b/arch/sandbox/include/asm/power-domain.h
> index 4d5e861dbce2b6434ac9bcffe5fc8f704d32e62d..3b0717f8fa06f1c0493fe6ee758e2e72ff77141e 100644
> --- a/arch/sandbox/include/asm/power-domain.h
> +++ b/arch/sandbox/include/asm/power-domain.h
> @@ -13,6 +13,8 @@ int sandbox_power_domain_query(struct udevice *dev, unsigned long id);
>   int sandbox_power_domain_test_get(struct udevice *dev);
>   int sandbox_power_domain_test_on(struct udevice *dev);
>   int sandbox_power_domain_test_off(struct udevice *dev);
> +int sandbox_power_domain_test_on_ll(struct udevice *dev);
> +int sandbox_power_domain_test_off_ll(struct udevice *dev);
>   int sandbox_power_domain_test_free(struct udevice *dev);
>   
>   #endif
> diff --git a/drivers/firmware/scmi/sandbox-scmi_devices.c b/drivers/firmware/scmi/sandbox-scmi_devices.c
> index 96c2922b067e2886b3fa963bcd7e396f4569a569..9f253b0fd40f703a5ec11d34c197423d27ad8b01 100644
> --- a/drivers/firmware/scmi/sandbox-scmi_devices.c
> +++ b/drivers/firmware/scmi/sandbox-scmi_devices.c
> @@ -163,4 +163,5 @@ U_BOOT_DRIVER(sandbox_scmi_devices) = {
>   	.priv_auto = sizeof(struct sandbox_scmi_device_priv),
>   	.remove = sandbox_scmi_devices_remove,
>   	.probe = sandbox_scmi_devices_probe,
> +	.flags = DM_FLAG_DEFAULT_PD_CTRL_OFF,
>   };
> diff --git a/drivers/power/domain/power-domain-uclass.c b/drivers/power/domain/power-domain-uclass.c
> index 938bd8cbc9ffd1ba2109d702f886b6a99288d063..d9fa8ad4bd2126ea564fd5be8124035946dbd432 100644
> --- a/drivers/power/domain/power-domain-uclass.c
> +++ b/drivers/power/domain/power-domain-uclass.c
> @@ -12,6 +12,10 @@
>   #include <power-domain-uclass.h>
>   #include <dm/device-internal.h>
>   
> +struct power_domain_priv {
> +	int *on_count;
> +};
> +
>   static inline struct power_domain_ops *power_domain_dev_ops(struct udevice *dev)
>   {
>   	return (struct power_domain_ops *)dev->driver->ops;
> @@ -107,22 +111,67 @@ int power_domain_free(struct power_domain *power_domain)
>   	return ops->rfree ? ops->rfree(power_domain) : 0;
>   }
>   
> -int power_domain_on(struct power_domain *power_domain)
> +int power_domain_on_lowlevel(struct power_domain *power_domain)
>   {
> +	struct power_domain_priv *priv = dev_get_uclass_priv(power_domain->dev);
> +	struct power_domain_plat *plat = dev_get_uclass_plat(power_domain->dev);
>   	struct power_domain_ops *ops = power_domain_dev_ops(power_domain->dev);
> +	int *on_count = plat->subdomains ? &priv->on_count[power_domain->id] : NULL;
> +	int ret;
>   
> -	debug("%s(power_domain=%p)\n", __func__, power_domain);
> +	/* Refcounting is not enabled on all drivers by default */
> +	if (on_count) {
> +		debug("Enable power domain %s.%ld: %d -> %d (%s)\n",
> +		      power_domain->dev->name, power_domain->id, *on_count, *on_count + 1,
> +		      (((*on_count + 1) > 1) ? "EALREADY" : "todo"));
>   
> -	return ops->on ? ops->on(power_domain) : 0;
> +		(*on_count)++;
> +		if (*on_count > 1)
> +			return -EALREADY;
> +	}
> +
> +	ret = ops->on ? ops->on(power_domain) : 0;
> +	if (ret) {
> +		if (on_count)
> +			(*on_count)--;
> +		return ret;
> +	}
> +
> +	return 0;
>   }
>   
> -int power_domain_off(struct power_domain *power_domain)
> +int power_domain_off_lowlevel(struct power_domain *power_domain)
>   {
> +	struct power_domain_priv *priv = dev_get_uclass_priv(power_domain->dev);
> +	struct power_domain_plat *plat = dev_get_uclass_plat(power_domain->dev);
>   	struct power_domain_ops *ops = power_domain_dev_ops(power_domain->dev);
> +	int *on_count = plat->subdomains ? &priv->on_count[power_domain->id] : NULL;
> +	int ret;
>   
> -	debug("%s(power_domain=%p)\n", __func__, power_domain);
> +	/* Refcounting is not enabled on all drivers by default */
> +	if (on_count) {
> +		debug("Disable power domain %s.%ld: %d -> %d (%s%s)\n",
> +		      power_domain->dev->name, power_domain->id, *on_count, *on_count - 1,
> +		      (((*on_count) <= 0) ? "EALREADY" : ""),
> +		      (((*on_count - 1) > 0) ? "BUSY" : "todo"));
>   
> -	return ops->off ? ops->off(power_domain) : 0;
> +		if (*on_count <= 0)
> +			return -EALREADY;
> +
> +		(*on_count)--;
> +		if (*on_count > 0)
> +			return -EBUSY;
> +	}
> +
> +	ret = ops->off ? ops->off(power_domain) : 0;
> +	if (ret) {
> +		if (on_count)
> +			(*on_count)++;
> +
> +		return ret;
> +	}
> +
> +	return 0;
>   }
>   
>   #if CONFIG_IS_ENABLED(OF_REAL)
> @@ -177,7 +226,36 @@ int dev_power_domain_off(struct udevice *dev)
>   }
>   #endif  /* OF_REAL */
>   
> +static int power_domain_post_probe(struct udevice *dev)
> +{
> +	struct power_domain_priv *priv = dev_get_uclass_priv(dev);
> +	struct power_domain_plat *plat = dev_get_uclass_plat(dev);
> +
> +	if (plat->subdomains) {
> +		priv->on_count = calloc(sizeof(int), plat->subdomains);
> +		if (!priv->on_count)
> +			return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +static int power_domain_pre_remove(struct udevice *dev)
> +{
> +	struct power_domain_priv *priv = dev_get_uclass_priv(dev);
> +	struct power_domain_plat *plat = dev_get_uclass_plat(dev);
> +
> +	if (plat->subdomains)
> +		free(priv->on_count);
> +
> +	return 0;
> +}
> +
>   UCLASS_DRIVER(power_domain) = {
>   	.id		= UCLASS_POWER_DOMAIN,
>   	.name		= "power_domain",
> +	.post_probe	= power_domain_post_probe,
> +	.pre_remove	= power_domain_pre_remove,
> +	.per_device_auto = sizeof(struct power_domain_priv),
> +	.per_device_plat_auto = sizeof(struct power_domain_plat),
>   };
> diff --git a/drivers/power/domain/sandbox-power-domain-test.c b/drivers/power/domain/sandbox-power-domain-test.c
> index 08c15ef342b3dd3ce01807ee59b7e97337f7dde5..df063001f517cae92df6b04a213c81b0d5584d18 100644
> --- a/drivers/power/domain/sandbox-power-domain-test.c
> +++ b/drivers/power/domain/sandbox-power-domain-test.c
> @@ -34,6 +34,20 @@ int sandbox_power_domain_test_off(struct udevice *dev)
>   	return power_domain_off(&sbrt->pd);
>   }
>   
> +int sandbox_power_domain_test_on_ll(struct udevice *dev)
> +{
> +	struct sandbox_power_domain_test *sbrt = dev_get_priv(dev);
> +
> +	return power_domain_on_lowlevel(&sbrt->pd);
> +}
> +
> +int sandbox_power_domain_test_off_ll(struct udevice *dev)
> +{
> +	struct sandbox_power_domain_test *sbrt = dev_get_priv(dev);
> +
> +	return power_domain_off_lowlevel(&sbrt->pd);
> +}
> +
>   int sandbox_power_domain_test_free(struct udevice *dev)
>   {
>   	struct sandbox_power_domain_test *sbrt = dev_get_priv(dev);
> @@ -51,4 +65,5 @@ U_BOOT_DRIVER(sandbox_power_domain_test) = {
>   	.id = UCLASS_MISC,
>   	.of_match = sandbox_power_domain_test_ids,
>   	.priv_auto	= sizeof(struct sandbox_power_domain_test),
> +	.flags = DM_FLAG_DEFAULT_PD_CTRL_OFF,
>   };
> diff --git a/drivers/power/domain/sandbox-power-domain.c b/drivers/power/domain/sandbox-power-domain.c
> index 9dd490b14a3f6e502baccd94d32704e4b6bd56ed..a80316576384b27dc8159e81b5c79fc355af2860 100644
> --- a/drivers/power/domain/sandbox-power-domain.c
> +++ b/drivers/power/domain/sandbox-power-domain.c
> @@ -64,8 +64,12 @@ static int sandbox_power_domain_bind(struct udevice *dev)
>   
>   static int sandbox_power_domain_probe(struct udevice *dev)
>   {
> +	struct power_domain_plat *plat = dev_get_uclass_plat(dev);
> +
>   	debug("%s(dev=%p)\n", __func__, dev);
>   
> +	plat->subdomains = 1;
> +
>   	return 0;
>   }
>   
> diff --git a/include/power-domain.h b/include/power-domain.h
> index 18525073e5e3534fcbac6fae4e18462f29a4dc49..7fd2c5e365b54889a156d0f0b969fae490ac41a7 100644
> --- a/include/power-domain.h
> +++ b/include/power-domain.h
> @@ -65,6 +65,15 @@ struct power_domain {
>   	void *priv;
>   };
>   
> +/**
> + * struct power_domain_plat - Per device accessible structure
> + * @subdomains: Number of subdomains covered by this device, required
> + *              for refcounting
> + */
> +struct power_domain_plat {
> +	int subdomains;
> +};
> +
>   /**
>    * power_domain_get - Get/request the power domain for a device.
>    *
> @@ -147,37 +156,81 @@ static inline int power_domain_free(struct power_domain *power_domain)
>   #endif
>   
>   /**
> - * power_domain_on - Enable power to a power domain.
> + * power_domain_on_lowlevel - Enable power to a power domain (with refcounting)
>    *
>    * @power_domain:	A power domain struct that was previously successfully
>    *		requested by power_domain_get().
> - * Return: 0 if OK, or a negative error code.
> + * Return: 0 if the transition has been performed correctly,
> + *         -EALREADY if the domain is already on,
> + *         a negative error code otherwise.
>    */
>   #if CONFIG_IS_ENABLED(POWER_DOMAIN)
> -int power_domain_on(struct power_domain *power_domain);
> +int power_domain_on_lowlevel(struct power_domain *power_domain);
>   #else
> -static inline int power_domain_on(struct power_domain *power_domain)
> +static inline int power_domain_on_lowlevel(struct power_domain *power_domain)
>   {
>   	return -ENOSYS;
>   }
>   #endif
>   
>   /**
> - * power_domain_off - Disable power to a power domain.
> + * power_domain_on - Enable power to a power domain (ignores the actual state
> + *		      of the power domain)
>    *
>    * @power_domain:	A power domain struct that was previously successfully
>    *		requested by power_domain_get().
> - * Return: 0 if OK, or a negative error code.
> + * Return: a negative error code upon error during the transition, 0 otherwise.
> + */
> +static inline int power_domain_on(struct power_domain *power_domain)
> +{
> +	int ret;
> +
> +	ret = power_domain_on_lowlevel(power_domain);
> +	if (ret == -EALREADY)
> +		ret = 0;
> +
> +	return ret;
> +}
> +
> +/**
> + * power_domain_off_lowlevel - Disable power to a power domain (with refcounting)
> + *
> + * @power_domain:	A power domain struct that was previously successfully
> + *		requested by power_domain_get().
> + * Return: 0 if the transition has been performed correctly,
> + *         -EALREADY if the domain is already off,
> + *         -EBUSY if another device is keeping the domain on (but the refcounter
> + *         is decremented),
> + *         a negative error code otherwise.
>    */
>   #if CONFIG_IS_ENABLED(POWER_DOMAIN)
> -int power_domain_off(struct power_domain *power_domain);
> +int power_domain_off_lowlevel(struct power_domain *power_domain);
>   #else
> -static inline int power_domain_off(struct power_domain *power_domain)
> +static inline int power_domain_off_lowlevel(struct power_domain *power_domain)
>   {
>   	return -ENOSYS;
>   }
>   #endif
>   
> +/**
> + * power_domain_off - Disable power to a power domain (ignores the actual state
> + *		      of the power domain)
> + *
> + * @power_domain:	A power domain struct that was previously successfully
> + *		requested by power_domain_get().
> + * Return: a negative error code upon error during the transition, 0 otherwise.
> + */
> +static inline int power_domain_off(struct power_domain *power_domain)
> +{
> +	int ret;
> +
> +	ret = power_domain_off_lowlevel(power_domain);
> +	if (ret == -EALREADY || ret == -EBUSY)
> +		ret = 0;
> +
> +	return ret;
> +}
> +
>   /**
>    * dev_power_domain_on - Enable power domains for a device .
>    *
> diff --git a/test/dm/power-domain.c b/test/dm/power-domain.c
> index 896cf5b2ae9d26701150fad70e888f8b135a22b0..1002d831764b5a62b05631aee0d70c5609b8574b 100644
> --- a/test/dm/power-domain.c
> +++ b/test/dm/power-domain.c
> @@ -27,17 +27,26 @@ static int dm_test_power_domain(struct unit_test_state *uts)
>   
>   	ut_assertok(uclass_get_device_by_name(UCLASS_MISC, "power-domain-test",
>   					      &dev_test));
> -	ut_asserteq(1, sandbox_power_domain_query(dev_power_domain,
> +	ut_asserteq(0, sandbox_power_domain_query(dev_power_domain,
>   						  TEST_POWER_DOMAIN));
>   	ut_assertok(sandbox_power_domain_test_get(dev_test));
>   
>   	ut_assertok(sandbox_power_domain_test_on(dev_test));
>   	ut_asserteq(0, sandbox_power_domain_query(dev_power_domain, 0));
> +	ut_asserteq(1, sandbox_power_domain_query(dev_power_domain,
> +						  TEST_POWER_DOMAIN));
> +	ut_asserteq(-EALREADY, sandbox_power_domain_test_on_ll(dev_test));
> +	ut_asserteq(1, sandbox_power_domain_query(dev_power_domain,
> +						  TEST_POWER_DOMAIN));
> +	ut_asserteq(-EBUSY, sandbox_power_domain_test_off_ll(dev_test));
>   	ut_asserteq(1, sandbox_power_domain_query(dev_power_domain,
>   						  TEST_POWER_DOMAIN));
>   
>   	ut_assertok(sandbox_power_domain_test_off(dev_test));
>   	ut_asserteq(0, sandbox_power_domain_query(dev_power_domain, 0));
> +	ut_asserteq(0, sandbox_power_domain_query(dev_power_domain,
> +						  TEST_POWER_DOMAIN));
> +	ut_asserteq(-EALREADY, sandbox_power_domain_test_off_ll(dev_test));
>   	ut_asserteq(0, sandbox_power_domain_query(dev_power_domain,
>   						  TEST_POWER_DOMAIN));
>   
> 

