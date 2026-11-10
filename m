Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC2C60A3814
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 14:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cG7xMA5J;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=cd/Pxzs+
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8D8C0608DB;
	Tue, 10 Nov 2026 14:26:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 32L98ub6xlO0; Tue, 10 Nov 2026 14:26:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E1DCD60858
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794320765;
	b=rrvHezUtzUqPzLvp75uRLxJePAQ3jxGie1gn1JBoAVb8npwPgeOn/xzWF2cI0r9i60/V
	 oMFQF4VfJBMCdHLJdzY8ATZUAj39Z2Mc46uCFPH9GTLamvX3ZpgujaVMPoCcaJvkebKEs
	 WILEFrfqo+EJ925H0ZweR/LVyBk5+mcCWpAKnXBeNJV1ecG3JIupO0YiYD6w1hNAdT1Db
	 CApurrSypAguxOhzMhQWWz2AJoSH7rqTwCLst/Wnmrrhg6hJi6q1cyib4fdZfAs+WbyOu
	 2QRHn+0gTs8sFNarxqE2DmSsPRCtKtGubnM078ogK+xmoL1dfKGqXtIa+eoKRyXJ7Rw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794320765;
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
	bh=sX3e5DR3QxzULorX0dsYc63oQdq/h3FGKlU5+umFmd4=;
	b=DN3aSP6HEBF7CnzX66oQXtXxHvUEkMKIgOWYE02C4Xhg3IdNrYyWnpi1VJvT4DMjGJ3T
	 aZOTic+qvqK8Lf/usGBkwv6Z10DqNinwdJ/rYHENpmcvmZQGrnsCzN4Vo+dtd4Bc0vypF
	 ZjK10LheJ/kVUfIjKHdAQ2cVkKQIPlDlhV0+ThzZO3SbtrQINJYnu3Q1bEdXUgNEA+MaK
	 TYE4ExdlKadmJgF/gny5OrLPALpfjG7n7E5upmvv4/C+/1EHNc6vANOBjt5FBP2MSJKeX
	 yVhw8bYVsyAmR74D/VjKm7WUlmswmV02B5HW5322FAN/AqpnUxwBSiQsTe2jTTm4O8g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794320765;
	bh=sX3e5DR3QxzULorX0dsYc63oQdq/h3FGKlU5+umFmd4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cG7xMA5JOVhwoZSX9HhMyS9Z2hhdxqIK3I/iL9LUdDgamTkZrq8fEabfN+bSWhjvP
	 RT9F9AXbMBT0ylqbhulr1SbGdbhWUrRoPBNf++qxc/YjuHoUQ3FQmZfxJ2bmsFSr/G
	 DCLwP99maMhf/Jmj9ipXydAY/lLaQpIF5mOfG4A+7k/772ZwWAhcAv9EPyIVVuV026
	 j4YSPTsM5O/DptEVJhegW8NQp4kFwWlEJ/HEE+rvfawUFJ6SPXxmqktxgIZNGLguef
	 zYz59YDjq+hOXUKRE1Quuai9Ty1AhAIJO16YChtlrjGj/2S4TKeb5Qozm6ifvB1P8y
	 eDtyEWWtq0o3w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E1DCD60858;
	Tue, 10 Nov 2026 14:26:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E4545388
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 14:26:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C99F781092
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 14:26:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZELUTFJFl1Se for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 14:26:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D87A181321
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=cd/Pxzs+
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D87A181321
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 14:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sX3e5DR3QxzULorX0dsYc63oQdq/h3FGKlU5+umFmd4=;
 b=cd/Pxzs+Y977bu4eP52lB+MU9it0kuMdWG4TfsS02gNWnfQzS10e9tHZMzMQvcb5Y7uvycPtmeetaiqf9xsEaD6m7v+LTBBeqWmZWO4IJXF5OJbbKEWwiMF7JL+MjlSoLIapmQgzTuFqjTSHzPA1P/eAa88thDMwKhywVl1avXM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by DB8PR04MB7193.eurprd04.prod.outlook.com (2603:10a6:10:121::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 14:25:58 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 14:25:58 +0000
Message-ID: <66d22487-93ea-4c21-8b7a-399f3b7d4680@cherry.de>
Date: Tue, 10 Nov 2026 15:25:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/12] test: Disable running event_dump test for make
 check
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
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>
References: <20261110-qcheck_fix-v2-0-1c76e0b68f29@linaro.org>
 <20261110-qcheck_fix-v2-6-1c76e0b68f29@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261110-qcheck_fix-v2-6-1c76e0b68f29@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0119.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:358::17) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|DB8PR04MB7193:EE_
X-MS-Office365-Filtering-Correlation-Id: 04b7c107-8e20-4723-e362-08df3f368a07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|23010399003|376014|366016|1800799024|4143699003|11063799006|261021121427099003|56012099006|261022075727099003|261026121527099003|261102123227099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: wlMbRoUi7DgOBDHECThRcz++0LqHolOhy+N5CzV7dI771txxPWFyDx/faSkrY2kV+pQ5R4nn/R8hRh7Z8JjlZ9Wnw+Y9B20wTnYRnK2gLPRCaVUjB5Qbb6NkwNS0v5JLaAxGJ/VhJqRc2KXp0r5yPFcLjl78nTSjGxcjKzf46gtans95w1jFpH6Lco2NpSXnwwTwEJNz5U6gdrUNhraLK2urNamVCn91lQs0uGuTVvysaMyF2GlcNLu6V4egrWfqOm46bn+9W41jI+wZCpWqqyL0l0iZfMagExV/Iplo3XfxJTyHM5jQNCgUQHx48kJ1m/tqAulVJrf2go/K9+agGJOl3KP3cuIu+/eGp5SyCTQQ2swPmrHr4PBirV0xskJqcPc4MjOZkZpNlRcexY9KUcEyK219N0OBEjYfiLPeccNjIxdMsS15sMuKkUm49kdpc+Vhwriu/3LH05OhPtv6eakItTL733oObO5QGKskNegKQhieFl53T5hjzf8Pnu6joXM89gqPh2yJMPUG81skOwjZpsxb19GP3ShCAI+JaZJDL7QfOoQ8CrkPMyDQZPokEdhUN0g9nIJj2TgPJ6UaOX/UzjmJmBjb5VveAog0DYZoItWePXv5HYU6axcR3+L4zMNeImvhyjOo9PIFRKWnSLv8xANVnSW7D3NNrBQ3y7c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(4143699003)(11063799006)(261021121427099003)(56012099006)(261022075727099003)(261026121527099003)(261102123227099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tjg4alJ6NjhjNUlaVy95eEZ0b0llQmx4QmE1Ym1YUmJaN2JydEZTVUZqUGNK?=
 =?utf-8?B?ZlFEeDg0aDMvYmVRTlBGRXNtU0paZWtOVjdrVjBuSHl2MU9wMUptUkRNbkZH?=
 =?utf-8?B?UnN5RGx1WHp2cFBEV1VzWUh0bFFhRUNMdEd0T08vK2ZlU3VuUmxkZnpCK05X?=
 =?utf-8?B?Z2QrMkFXVzg5bzZzcFIvV2tNL0l4TDdJK3RPYVM3TWw1Z0JoOFd2anlJZmlt?=
 =?utf-8?B?YW9PQ2RTZDhXMGJmelFkZm5Ha2c5cjZDbjZheDZZWEZkZ096UmFFYzhCUVZ6?=
 =?utf-8?B?em5UL0lJUG1SRW5WOHUrYnRoTEpTUTM5VzMvNDZKVmE0TFZnZkwvdnE3bUNR?=
 =?utf-8?B?ekhIWldiajNQWkhSV2Z1QktNUFVCZEhFU05hWEs3WndPTHZlbVZQUng0cUlo?=
 =?utf-8?B?Q2lrMUdrd014c2l4MWY4WUs1cXlZM1prbERMTFFpYnVZb2RURkZOb3RneExE?=
 =?utf-8?B?cUlDSWpiOHVlQ0lYWjVDT1NCYlpUdkJnK1h0RDJnMXdrVDF5ejRDSVBnVVVp?=
 =?utf-8?B?NVF2UGVUMkhwMTNndU9sYU9hcElOdGl2dHFiVnM1ejNFUVR5NUNvcTFRdzQw?=
 =?utf-8?B?L2hKRFhzSThRS2wrNHNydC9DYU9qQ0JadTJyalpKVndCMXR1SXdObm13S2Zw?=
 =?utf-8?B?RTBDcnRNQUZuRXZhaFc3aXBJbEZicjJ0UGZubTJ0QTNuLzEwNGJHRm1PeGcx?=
 =?utf-8?B?dFVnanNhWlVaZTd1RzhoRVYyOGRGd1NhZ1FUSVlXZXRiWE9CUTRLdzZJZXBO?=
 =?utf-8?B?SkxzR0FObWRjaTdzbjBEeDVaUDE5R3VuclVzRXoyNnhEeko1dzQvY2MzbEhE?=
 =?utf-8?B?emxTNzBzY0hwVVl0cklWTnhQU2d5eHJXWHdwUGxXVjB3NzNNNkNyNVlRaFNm?=
 =?utf-8?B?cHFXT2t3OXQva1Q2WE4ramtFdTBSUWtIL1NKdVlwR3dhMURFOGdYdXpabElw?=
 =?utf-8?B?eE00Q2xoend6VFk0dTVhK2I1dlBVWUZRdDZZSFNpWThjaUpQcUpjVzJFWWNy?=
 =?utf-8?B?M0hjNDRzc2NkeUJlUWFHWmVtM0RydkVnTTlqa2c2ZGtUdGRlS2xjMnNKaVhV?=
 =?utf-8?B?MzlZeCtpRnBzYUpwRHo5S3RoUUZ0anM2Zjh6R0lzUEU1NmgxSWJaNzBMUXc3?=
 =?utf-8?B?QytvS2xacStHamdSeThLdXMrNVUxZHlEY1Zyb2J5YjROVTdYZXQ3T2JWZU1L?=
 =?utf-8?B?aU1odjgrL3VrS1Mwd2tTUVMyeXlaQVkxR2NnR3Q0dHYvN2cwdHZVaVJjYXFt?=
 =?utf-8?B?cnJtVWl0NXdzUWtWN2JGYmVxSFlMZDhscnk0cU51eElueFQvTVlzUUZiYXRn?=
 =?utf-8?B?ekx2Zkt0NDFHRkQwWEkxY1IvcGpyN0VDOGFiV1NYQmxwVElxM0twTHhYZDI3?=
 =?utf-8?B?a3cxMVFBRVJGblpzQ3BQOFUwQ0VxeldiSVZxVG5NcWtjcGU0SmE1WVBWK1dk?=
 =?utf-8?B?NnRzM0Jmb3BGRGVMeW1aQ20ydS9zcUZDVHRicGl5Zm0xNi81N1htcFZsY3E2?=
 =?utf-8?B?NFBHRUtMUUxESXpwd0FaYld4MjdHU1o1bEVMbmRndUNNRU14SEFaNUkvUFZr?=
 =?utf-8?B?dzdBd1RDcGNBYnRMcjhxTnpvY0swVjEwMlI4Rm5kenJmL2hwTFZvSndwTGhG?=
 =?utf-8?B?WXFPdzRLU0VnVEVHNm9PRnd6RVlZdUpIZGxFRTVxdSsxL2lpbXJLbWY5S25v?=
 =?utf-8?B?ZkxsUkdkZXpwV2NKNW0xdDRwd2Q5OHhWOG8yQjErcjBQQUw1Y0pEOHN3Z0c5?=
 =?utf-8?B?QzVuQ2MxeFVPMTdxQW9ZcThaVDJiMWlTYS9DUS9DWWh2c284ckdNSFpPUkhP?=
 =?utf-8?B?VVUxbGNEOWtkeWo5eExqOUI4czhuUk9JVEZOcE83UWhmOGxnUzF0S3BiaXpR?=
 =?utf-8?B?cW9GMk1GVlNiYm80c045UnZnc09aR3krUFZEMWs3ZW9Mb01FaTZOR1FkQUJo?=
 =?utf-8?B?TlFxMm9PaGFBQnhUaUQraXF4c2x1RXNOQUE3Zm01a1NkUHB3YnVZa1Rxa0xr?=
 =?utf-8?B?NnNydnZmTitSMDZuZzI4clBoWTRYNWpjb01Yb2hPOFpiSysvZFVBRzYzclAv?=
 =?utf-8?B?TUFQR3BBR0lmRG94SnVxYnNpVzRINHZFWFBXSWV3VUxKKzREcXpwT0xoK244?=
 =?utf-8?B?U1huVkRkMEhSNnUrU2tZVmpaWlB1cFl6aVdWcnZNNGU0VmtEVnFCbVdURmRL?=
 =?utf-8?B?aG8wd2lPVkw4aFpPQ21oalFkK2NUeXBOK1lzU0lOOTRBOHZLejVwRm1lRHVW?=
 =?utf-8?B?Q3pVRytHNjB3WXp4cFpMSjVkZnJNSWFZYmNlVW5HMFlPS0dyRGlUeE1hN1Qz?=
 =?utf-8?B?RU9tanE0cmU3R25jZ3l3ZWxRSnFLODdMOGNseWIvYjBrb05HOTZYZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b7c107-8e20-4723-e362-08df3f368a07
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 14:25:58.7837 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CNCjyz8wyJNvVJFkY6O5v+/lxwHQJxaNRTbTNGMA8v1i7IghM7sZ4fkhh4dwDNhrGV4x6mlkwWTdq4pdjmf/GVV/Ux6YXOPnHsgk4CiOCaM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7193
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Andrew,

On 11/10/26 1:24 PM, Andrew Goodbody wrote:
> The event dump script does not work on more recent versions of binutils

Please provide the error log or something so that we get a chance to fix 
this in the future.

Cheers,
Quentin
