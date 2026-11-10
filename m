Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A760606A31C
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 15:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DFZLHtxY;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=hZJMCXhL
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E0B9E4094C;
	Tue, 10 Nov 2026 15:39:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wf0Jfwz9djMp; Tue, 10 Nov 2026 15:39:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 11A4E4052F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794325155;
	b=erYyZP54LtaBayXxbLAVfmuCyOWrYW0uNO+FOF8LigjIh80PuafwT8T+BIe6lxGWk9Qe
	 3NcQnah+r45Em0qJFlvjaFeSVRnN0o9kVWdoLKWAbzv/p/vXdwvtDNNq5ArnRvKH/xp2B
	 7v0bj3wUmi5r97/pXj/F4Cq9hlxaJKspQv1jLbsFaVKRlRfmCi/v5aQo+l9tY/TNFtK+e
	 8LQfyRDm9DNmQyTyk2JcWFVS1LEfImpARXNy0zgRRqZJxJNNt59k/4HqhEGNmSDvNdi8s
	 /AhCZDaGHPHnR1EB62edYMpxLTxZKgoVsFKyyz0g9AoaiU8Pgu/+slOJF+gisJzA5Xg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794325155;
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
	bh=L32t64hmAf3n5JdOwZziTSvdjOhtO85ff5FHGah45Oo=;
	b=J1OkTW3ENkxIymzx0AaSBkyoD13LF6A2qT6oCq1Xwq6oRUjcUwltf9dMEfvRWmI1uzeX
	 iF42WHvrp6tDeHlhYa6hjYXyFBB2namW/fSF2EDOY/bhRe/V/cD6ex7xaMasZUq6DPLWj
	 GoFpeY7HSaWYGtxEiDld4DGy0UBR+bxun9JGg4Dz1kkNn5aiid76x+hE0oD7Dc/VU9hDj
	 v+53wFyf0iwIrQgNY6MHk8hOYKWjWFSb18KlQ9xtcq4LXQfchN2fTRcw0t3UHSz+fLhlN
	 YpT2JV4cAShXKOgsu5XE8Cw24LPtd0QN3nPc0+E4I7d5Cl2i1y9FJvtNFHO7gtCji4A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794325155;
	bh=L32t64hmAf3n5JdOwZziTSvdjOhtO85ff5FHGah45Oo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DFZLHtxYkn9yI3bIj9xw1UvFGHpkWJpckOHUly8xZqDAulq56CfP+5j4VffHmtk6q
	 lyytPresKWIhMzLI3JTeiq5mL7maQzUCYfiUgUy8lt7s1UrmavnL8vPVx4lNCw8k0e
	 dG4ZzNo0shCOuB/Lr4zWBYQgIAwr0fk7xZepd/2zeoCOBxtqJa+4EtIkE4v7kUcsRK
	 W6pkUEMCxKwTKFNwBZgcCE1jlSdgWlNigDXDgSz2bvI0VXAYJzQXqnljLAuHCPmhOo
	 L4oMMJZ778+kbj8Ljv3fHMmBaWOhJg8IbmdqibswTVMB3XQSkhkXRKZnTdvhOij1Pk
	 TnjrI1BE7HNHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 11A4E4052F;
	Tue, 10 Nov 2026 15:39:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 80B3C28C
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 15:39:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 71A95400B4
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 15:39:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eWqbqijyoTsy for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 15:39:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 72DF04008E
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=hZJMCXhL
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 72DF04008E
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 15:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L32t64hmAf3n5JdOwZziTSvdjOhtO85ff5FHGah45Oo=;
 b=hZJMCXhLE565EGJVE/Z8HKTMTWDQRFHUmI5Uw4TPKat7QP2Ox+KTK6MJTlsa0X5fu5ylSZT5ofIe9MQol262iuNj/JfW1WX/bKxBBgRPJ2NH9RAeKxjFrR9vpqwVTbFz2tNMxShvjIjU5E485MwQtSU5eNwlz87zBkihuNg95M8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by ZR6PR04MB786520.eurprd04.prod.outlook.com (2603:10a6:910:e1::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 15:39:05 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 15:39:05 +0000
Message-ID: <4c272bb8-5ac8-42e9-9338-fc9e13cfeca4@cherry.de>
Date: Tue, 10 Nov 2026 16:39:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/12] test: Fix test_basic file system tests
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
 <20261110-qcheck_fix-v2-12-1c76e0b68f29@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261110-qcheck_fix-v2-12-1c76e0b68f29@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0012.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:357::16) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|ZR6PR04MB786520:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b0a8d06-e5cb-4e16-f1a6-08df3f40c07d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|1800799024|10067099003|4143699003|11063799006|56012099006|261021121427099003|261022105027099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: wLIgWoB3jvyr6JcIkF7Un3NYHhAh3WRmhxs0JQcU0EGr0sIFc+XJTvGPyqpgAYdBSWG9T6MJHWV6iQXI74crRxmG/yR1pKgjlGo6YhRxnfuQfldihKBeVaZwRmLH2Q4CUhy5z5JpiT0rhvo3aFGILQA2ze2pzBmkQVsM21ECSfRJYlts1S9oKzClqf/6c3hokv2glkUHqMWDhgrnGGwrgmwybFYehgFMrf4E13ghua90MT/m99QISyYnkof9Yh+euoLOR8Nt4mr1dDl8ZBFIbDcJntMeCjKdn5CZ81jB4ittJ+rH74VyyNQ69hLVt9KJvCCgsL+NTgf4A0hMXn1bTJQobkEAoz7+l5UMFi8aWieLrdBm20pdV3drfFmwARuOf3sgHeDzWcxlh4F3WtU7Urx5z4clEdTZEjMDb3WiXViQEix2eXZQ+DtD/xoWjngW73APsY51LHh45zZoUyJJO4NmC8mLIQQnmljby+DRo/7N7dvjw3MMZhQqTsbioh9vzkLjc3zrBdVGkvRBDZXK9DhLNH592Wa4hpjODR25kOijPdNUSgL0rIFP4uLPdmJrrkXo0POyBxNt0GYm55YRkGNdsmWv+h0ACYY5CNGo1apsO5pVkODY2b1XbnWW/woSA1aEpk4oh7OVJ+tbM3G/77NHACrtJTC/GLeA3MoUWUI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(10067099003)(4143699003)(11063799006)(56012099006)(261021121427099003)(261022105027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bElKaCtzVmxNV1V0VklRcEF2VFhEcHNwVnpxaFFSekFhTUZDcEtqb0t3Ymhy?=
 =?utf-8?B?WTBDR3RHVEZHQWZBZXd0YytHdUVhWHZhNTg1MEh4WjVRc3BzZ1JLUm4yZmFR?=
 =?utf-8?B?MjRRWndwVmtWN2hEYnhhMFlBTUNvN0g2R0NEMU0yTFpBK0ZEWWtBSUV0QU51?=
 =?utf-8?B?bFNxQ1o2T0ppTm9LSEUyUFVobzVzK0U0N1hEQjdxWGpzVXkwb1YwN2hwVHJr?=
 =?utf-8?B?bStOSTZKczRRWXpwTTdYV2JqcFYxSXVPM0ZUMjNlZGxjcU5RdUZ4dGlnN3pm?=
 =?utf-8?B?dUtWMUt5OXJ4ZnZJZzF1UTlXTlpUM2lCYjcxeHlrZERWZHo1M0ZIeG9ZUlcv?=
 =?utf-8?B?cGQ0TFVMZVJmajdJei85MkF3c0VScEdDUHBYS2MvejhXeVhMUUZaTEs4K2pZ?=
 =?utf-8?B?VDZjVU1QN0tRTDdwazl0YUxnMDYrZkl0cXYrcTBRT1ExZGtpMlVxanJmSFlY?=
 =?utf-8?B?YitRdXBrS3dGcHBqK0xOUkxUekY1bHNqcUlraUtrQU9MNkovZWp5ZDlybjdE?=
 =?utf-8?B?cmdSNXpBMU1wa3Zhc3hLdlAvZkl4YVkwcDR2MUNjbWQxYkhOVnB4Z0QwYmVt?=
 =?utf-8?B?OGltR1FxaE5TL2JJT3A5d1JXbHFnaXJEQVFPZVl6MnhFTzhCUERFNWw0V05k?=
 =?utf-8?B?YTVQcDlydG1WQVJrby93T0lvWUFBeElUR0xYYjI0VExZR0tCODROdXIzTjh2?=
 =?utf-8?B?WnRweUpNOXg5blFVdGhmb0tQSUFIZSswKy8vT2Y2Q1RKVFlxbSs5K1Z1elZP?=
 =?utf-8?B?M1JSS1B4K014NllVUElQM2ZEdGRRS3hUdDh6TVJQakJXcTJ5cWFSQmVpY2sx?=
 =?utf-8?B?bzhGMnpNRTV5NjZGanhWaEhKYU00ZTh4QmQzTmVOMVluYjd0cVFzbXNibHBq?=
 =?utf-8?B?VGt3US9aMUhtUFRLL0ZqSW9mV2JQWkZEUzhiS2duYncyUHh4R2d5L1A3aU5r?=
 =?utf-8?B?ZTM4RWtHSnlZbTgwcDdET0IyQkpzbU01c0xrMTdvZ2QzdTIzSDRxWVk4WmtT?=
 =?utf-8?B?NXgzWXZ6MlNPSUxKYTJMcUM5SmFoR2MyRTBIbk1kMVh1bTZqdWdiM0FNR1Y0?=
 =?utf-8?B?ZS85dTVQY1lMQm0xd2xEQ2R2bW1VekZ1eTQ5RVlaWk5jVWJWZ2xvNXpyYXFU?=
 =?utf-8?B?ZFRnTzh1anRwYkIrcVNHMm12NldpYjNROUpSZGdBdWJyaytCdlJTODFrN2R0?=
 =?utf-8?B?SndOeTFDUU1GZnJzR2txOExub0l5TXlWQjdWQ2djT1FOb01GeG9obFBCeFBJ?=
 =?utf-8?B?Y1BLYTY2TjY2WitHMFg3UHQrUU50U1cxSE9WS1ZsRGtUNnRDSVhLZWpSQU9P?=
 =?utf-8?B?Q016RXJ0dmdXOXdjZ3ZWU2FyWE5zV3FWeFhUWFBMZ1dzdnVYWm1iWXF2RXN6?=
 =?utf-8?B?NUQ2R2tCRStZbUJnbUVKNm9QQUxDNVM2TlAyRjBhTmFtTlNKMjIvL3hsRW93?=
 =?utf-8?B?TnpjTW5wK0lvZk1Bd3dKamxzQTlpMk9LUDltWGZIQmpvcDhkTnlqYjdGTzM5?=
 =?utf-8?B?a2dFc3dyeG9Hc3M3VDhNNEhjaWpZVExCQzFxaVhUYW1vUy82U09jQktwWDlZ?=
 =?utf-8?B?MGRkU09VOXpuS1JBL0dYZEN6UTlISUJtRlFkTjRSUzZPUTViZk9zSDhyN3M3?=
 =?utf-8?B?YlhLdTVhZ2VMN25XUms0bmVIRVJCazFrVDcyRE5QTGR1YXQrWXlCRmJudnlj?=
 =?utf-8?B?ZTFZRWJyV295N1VVL2d2aWhkckVpRXo2OEY1ZTNkM01jLy9pMUtQbmdCOTBl?=
 =?utf-8?B?L0p2SHdjZklld1N0aU1MWHpHWDhpRGUrdUhMRk5WVzR1YmpZVjc0d3NYdmdn?=
 =?utf-8?B?ZVZCUnBYbDcxREtXQ0ZYNzRXejEvTXp2cE5QMU5JOUJYVWdEMlJmUWtuekN4?=
 =?utf-8?B?bk1hUGdYVkcwSm94ck1VK2xXNWpwOExPYk9WUjVwdWg0eTl3ZnR3dC84cVdo?=
 =?utf-8?B?N1ZvWjZaRHNKVDIxc3Z4Q2lueWkwTzU3bS90cllhL044K3lZaTduVVRaa0Nn?=
 =?utf-8?B?TFR1dFRzVkNhbGxtTktJbXNpcjg5NFo2OU5TdnNKZ0NoMTFEaTIzK2lnaStV?=
 =?utf-8?B?RDR4ZjZKKzhsMmlVK24xZDNERk5kMUpiMS91aGppUjFTa1E4ZmpQbjAxcGZM?=
 =?utf-8?B?OE9oWU9SZm0ySDMzS2dMK0NhL055cDh2V3RXQndGUUpXWlgzOXhyOXFvaytX?=
 =?utf-8?B?THhPVktMbXA0MzdOcjkzTHFKaVRrYW1xOWtWUHg1MXFrbXhyTThleTQwTDVk?=
 =?utf-8?B?ZTIzMW1LZ2M0OWd6c1o5S2hYZ0szbE84dWtyTWc0bHhrZ2U3QXdOaHlYKzNH?=
 =?utf-8?B?aTR0cGpINzB6KyttcFp6TjFKdHVmbDA0a3ZROFZvb2NrVEo2NGNMZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b0a8d06-e5cb-4e16-f1a6-08df3f40c07d
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:39:05.1057 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZASfogzj1sLAoOIePcmWQkMX/nJ0x0uFbfb5Wt+HwZHghq2dNnxGZob5+U/e2bNj1ogjf+ef8TXiLNT1CQx9z86JVxZBJqFZoc+o/mE4YQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR6PR04MB786520
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Andrew,

On 11/10/26 1:24 PM, Andrew Goodbody wrote:
> Ensure that /sbin is on the path so that distributions that do not have
> it will still be able to successfully run these tests that need fsck.
> Add a forced clean of the newly created file system to cope with the
> fact that there is an orphaned file on ext4 that will cause the
> integrity test to fail later on if not removed now.
> 

question: are those really related?

It feels to me that those should be fixed in separate commits?

> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   test/py/tests/fs_helper.py              | 4 ++++
>   test/py/tests/test_fs/fstest_helpers.py | 5 +++++
>   2 files changed, 9 insertions(+)
> 
> diff --git a/test/py/tests/fs_helper.py b/test/py/tests/fs_helper.py
> index e3824b2c1fd..48b047aeefd 100644
> --- a/test/py/tests/fs_helper.py
> +++ b/test/py/tests/fs_helper.py
> @@ -250,6 +250,10 @@ def mk_fs(config, fs_type, size, prefix, src_dir=None, fs_img=None, quiet=False)
>                                         shell=True).decode()
>               if 'metadata_csum' in sb_content:
>                   check_call(f'tune2fs -O ^metadata_csum {fs_img}', shell=True)
> +            # Cannot use check_call here as it will return an exit code of 1
> +            # as it modifies the file system. The -f is needed as although the
> +            # fs is marked clean, it is not really.
> +            call(f'fsck.ext4 -f -y {fs_img}', shell=True)

nitpick: just use an array to avoid shell=True

Considering the rest of the file still uses shell=True with a single 
string, I guess it's fine for now but we should really think about 
getting rid of those.

>           elif fs_lnxtype == 'vfat' and src_dir:
>               flags = f"-smpQ{'' if quiet else 'v'}"
>               check_call(f'mcopy -i {fs_img} {flags} {src_dir}/* ::/',
> diff --git a/test/py/tests/test_fs/fstest_helpers.py b/test/py/tests/test_fs/fstest_helpers.py
> index d25326ee993..6164eca476a 100644
> --- a/test/py/tests/test_fs/fstest_helpers.py
> +++ b/test/py/tests/test_fs/fstest_helpers.py
> @@ -3,9 +3,14 @@
>   # Author: JJ Hiblot <jjhiblot@ti.com>
>   #
>   
> +import os
>   from subprocess import check_call, CalledProcessError
>   
>   def assert_fs_integrity(fs_type, fs_img):
> +    # Some distributions do not add /sbin to the default PATH, where fsck lives
> +    if '/sbin' not in os.environ["PATH"].split(os.pathsep):
> +        os.environ["PATH"] += os.pathsep + '/sbin'
> +

issue: modifying the environment like this is a big no-no.

Modifying the environment like this should really be last resort as it 
breaks things in various sneaky and random ways.

check_call() takes an env parameter, so copy os.environ and edit the 
PATH key, then pass this copy as env parameter to all check_call calls 
in this function.

Cheers,
Quentin
