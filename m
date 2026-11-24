Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677A3606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 15:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yaxromos;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=RtkJsLZ7
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 347C0607C7;
	Tue, 24 Nov 2026 15:05:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SFp78sfsS4lC; Tue, 24 Nov 2026 15:05:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8D75160843
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795532728;
	b=S1hnROalFCKJH07p/epGEBtOhb/urCWbx2zOBK2QAulWD5d6dt7/KNymlDqWOIx0I6q/
	 WU2nBLT72WQWd/ff/gpi1vTzl4DBWI5MHkrTMhTsZZOQS5tkOT7D/iaAPoLLdVpeaz7ij
	 ILReUSD+FNce3iwL1oisuDMxYxcD5rvAYK2hMrfk+EIs91hPJCyQBEiKOrNSZqr9CGLrq
	 rQcf8PJMs08/9WUAAloWaDT4mPlXpMManYZ/gmRVGbbOYLcrpB4Zah0f5PqEhwpgmGdtM
	 mFlIOsF0b/olSO6ZdV5GSp3bMOb7XFgAaFByTNA2S88gJHnktIYsPTUP2wq6md3GExg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795532728;
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
	bh=qlFySawHG3HDS6CPPJNka8/SxQ7D0IG65LqeG/NyN80=;
	b=IuRHXNDKhkwaVereS0VbSLDIGxcKBJLKEO37Z1CEHIsWCiv23jqkemHxQdD93JnEmzkU
	 YPbHzdyqUg/xBUU2zIKvJVH9HhYIXdC0/dZcRyMn6uMw3BbqXjNvBonph0UW0PkR9tVp+
	 gxULP7P/VgqzwMX7JwG0HJtAYj1Gfg1/hdf5bVUiuVr8eXyySqMaR/lZF0Bn5FXqQcUqY
	 HXMIHwINrygN5Z3FRIbdUFGqUbV5XLu+bMIXdV+m/gMu+wu+8d0eP5oWN2bYAgs+LuVL6
	 r9hR1R7YEIL9367sBqBqImgt+kwZ0z9AC5LaaqXCu5U/Krn/0SAliYd2Czpr8aT+W9Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795532728;
	bh=qlFySawHG3HDS6CPPJNka8/SxQ7D0IG65LqeG/NyN80=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yaxromostAEVrJvBBFTTUJkdsu+btqbJok6WcDy1oIa8+blQCXQCQ0BjFfgaQdcPb
	 qWT3yXkG2zomsIk2E3bMSWkw9jkC0hjI5XPTH5Hkt5DG1Ez7TokhtQmuGuwEztP0+s
	 hkCHYS3q3wK0sF+DAJyoqGqdV1VekBzxCRiUFztRaiI1plmc0fdbN/wefgpjLKDHks
	 3F27+zLxCfGVslW8xgLpx1UsBG6/efwkddshu9+FoGHFowZLfngbce9qt5Qcp2uhmc
	 KjJubXsTL+29pewdBNdFDdzate5fnQIqd0dOPrkby+J3I6uVKs0vPJ6B+FlMdUZbKz
	 gjhyQIwJsBOtA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8D75160843;
	Tue, 24 Nov 2026 15:05:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3B1CD79D
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 15:05:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 20AEC80FB5
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 15:05:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SEBNuRhZ8oG5 for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 15:05:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BB6EB80FB3
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
 header.s=selector1 header.b=RtkJsLZ7
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BB6EB80FB3
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 15:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlFySawHG3HDS6CPPJNka8/SxQ7D0IG65LqeG/NyN80=;
 b=RtkJsLZ7a/iLIKwT4wgfCthnwGDz5z8EMe05xrO9kcpbBvBp71/485DfYpfKuSZx0Yt67Vo7FIqfwXKc226FdpezbTua2uNRiP/Hb/xvz9A2w8PKMY/331hMQENj6f48gVSRUbj8hit1sK+ZOcqK8UpzuJpAuIzUXlcAYk9+gaI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AM8PR04MB7987.eurprd04.prod.outlook.com (2603:10a6:20b:24d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 15:05:18 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 15:05:18 +0000
Message-ID: <3e147144-ea81-4d66-97b3-bfaeab7d9823@cherry.de>
Date: Tue, 24 Nov 2026 16:05:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] Add support for OpenSSL Provider API
To: Johannes Schneider <johannes.schneider@leica-geosystems.com>
Cc: Eddie Kovsky <ekovsky@redhat.com>, Tom Rini <trini@konsulko.com>,
 Tobias Olausson <tobias@eub.se>, Paul HENRYS
 <paul.henrys_ext@softathome.com>, Simon Glass <sjg@chromium.org>,
 Jan Stancek <jstancek@redhat.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>, a.fatoum@pengutronix.de,
 mark.kettenis@xs4all.nl, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org, Bastian <bst@pengutronix.de>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Jaipaul Cheernam <jaipaul.cheernam@est.tech>
References: <20261029201348.730274-1-ekovsky@redhat.com>
 <20261029201348.730274-2-ekovsky@redhat.com>
 <d9d0d343-c615-4a78-9f24-197ec3fbbee7@cherry.de>
 <20261112160408.2321891-1-johannes.schneider@leica-geosystems.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261112160408.2321891-1-johannes.schneider@leica-geosystems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI5PEPF00000913.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::937) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AM8PR04MB7987:EE_
X-MS-Office365-Filtering-Correlation-Id: 4511c5a3-553c-4102-7a54-08df4a3c5964
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7416014|23010399003|10070799003|10067099003|261021121427099003|261026121527099003|4143699003|11063799006|56012099006|261022113327099003|261022105027099003|261022075727099003|261022115727099003|261026140227099003|261102123227099003|261028144727099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Z2z6frHFkV7E3hPSR2bI4Pvc4vUBOsWbYVaDy5qREcENpaobdY8H2PcREbaYs6FwT169adAxKvSbjTmbRz6a8WLQ/5760tc8b7OU+L+oe7TvFnDVbL0pfhKI6UthS66yTHHdh9b68lu8w3oAH5GV3heaLSyHimVSc2G4XxX9Zzmd3xy2X3UM/cAI+rmJAt0GuzmY9Mxsxx1tQLPJlBfZUNLJN61G2F41hNVXjHF+6eRF93AaBu2mLZnRMVEP9GEUXr6XAD+RB/xgFfF5JCuUjVHNSgACa9oRx1kPdtbvYSBUBsMxnD0/b7aqdxORe+zMicHSELFR8LxYJfLtT61yBMv9/SWPKRpxvidgvc947vJRTujkHx6UCb3ch+wrEM+RyV6yALiNEiIfhw+ezx/vHGo7bu1js5HsZiozKpopi51mt6w3x5FYVZthdf7e85NHvOmnXY/p357nvtcjWJBQ7pZo0G6mqIG3WGnyPIfLN40Zn0BAJK5cJu1nQ7FM23Cw0wNZqaWUgNM/o2cKG57rHN2qr2k7G3I9X+lCV9t2NsGVgdztVvpE8PiMxWEzxHdLK3GSiqhW95bAWfxeCH0i6cDpW8k/QHWF3npISsXyQQgoTxpLEr3C/6mtUoaEclj2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014)(23010399003)(10070799003)(10067099003)(261021121427099003)(261026121527099003)(4143699003)(11063799006)(56012099006)(261022113327099003)(261022105027099003)(261022075727099003)(261022115727099003)(261026140227099003)(261102123227099003)(261028144727099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEg3T0F4QzZWcFd2RG1OUDJQTnVUSFg3VDF4RStqTTlYT2RHWkxuejhFaS96?=
 =?utf-8?B?eSt3dVFyTjRiNExQTjFKbk5IYXYxNjkvSVlLSmNiRUs1VXE4UmV4Yk5vdU1j?=
 =?utf-8?B?eDV5OTkyamJFdUNoSExXOHlCZE5BdG1OYjJkT3ZOU0Z3bFNyaS9tM1ppWG0w?=
 =?utf-8?B?STlhQWRiMVZlaTM5cUUxVjJSKy9GTmZhSDhvKys0ZjNQWUptU3dRU0Jxd2gw?=
 =?utf-8?B?WFpCcHpwN0RLY2hlbWZGL0c3eFJmU2RxRStpa0tMd2FFSXlBb1ZQVkVUQmdj?=
 =?utf-8?B?MzYvRVBZNVlmNzZCWHZXallvQWsrdnVMTFVLN0JINXhkTlc2U014Tzc1QlJs?=
 =?utf-8?B?ZUpkMkF5ZTNwam9saDhDSXdabDN6ZTZ1N3hWb2FBWDJUTzdlYVY1V3ZjTUQ5?=
 =?utf-8?B?WjlkQlA4WXNUSGJkRXFQa3pWb3Z2Z2NKS0t1MW1IcXRuZ2xwNitjWWFERGh3?=
 =?utf-8?B?RS9YUG9qeVdTQy9rR1RDZVlmQ2puY09XZHFabUZ4ZU5zSGpUdWFGckVjOGNs?=
 =?utf-8?B?VnlVT3ZTNEF3dGpIYURyQzFOTVVuTUNCdmZtSGN5cVJITHExTU9rVnNMd2ZP?=
 =?utf-8?B?T1NjTXdFcTNNRElYUG1XTGRMZStjQTMrM0V5cmNUOTZxbVpzZU5tRndDL2VQ?=
 =?utf-8?B?eDIxdU43Rm1QaUlmWUpEWG8xOHZvRlA2YUZxTGJQVGJvazJzcUhMaHQ5SFov?=
 =?utf-8?B?aUJqZkcvVWF1SzRiZ3N1eDlvSkhzamlTR2Z0dGRoeElsUnFWbWYxTTRQaHB4?=
 =?utf-8?B?VmZ4MmMzU2R2cFJLcXRuY05hK05EZGhaLzN2cDVBWTFZMndleGJmdjJKYzls?=
 =?utf-8?B?cHBnL0lIWmtYWml6cXVYZm1PK3lUQUg0aHA2d2dKeVIvOXYwZWRsRGlFR1o5?=
 =?utf-8?B?NTQ2K0RUdkJHcUIyVWh4TUE1MmhuMExVL3NwdTBOUTZvTkhIbUhGR0k5S3BS?=
 =?utf-8?B?c29aSmY5Y1hOSy9id2VVYnpCSzZ2NDJkdlpRb3lwd052WEZCaXdmN2FGVTBO?=
 =?utf-8?B?N2hKenpkODRPTHNubHRCb2V0dUc1aUFLMnk1dFF0RGUrK3FoZkN2N2VKZmtB?=
 =?utf-8?B?dWVUa0w0WHlyYWErZUh6V0Z4Y2RFYm9QREo2L1AxSm5Bd091TzB6Vi9ETG1U?=
 =?utf-8?B?dzA2RElxK3B3SEtoSFB1cmwzUERzK1BFb2xjU0UxSVErdVhTc2Y3L3ZKTnVJ?=
 =?utf-8?B?WkNIdGFJN2VXLzRjR3dmUFZ2NlNGc3IyK3MvUTlmbytSZjNTRGZ2UytoWGsw?=
 =?utf-8?B?cGtlRWZoODN1ZUZQVDBEYXQzS1l5STMxNW5hemVodGlEZS9jQlFWTDNhb1hC?=
 =?utf-8?B?VldQZythRXZCQmRLdHFuSkZ4TUZrS0hVQVZ1YXNoMno1S0I1cVpIVHA2b0hP?=
 =?utf-8?B?Um0xRlo3cG56clhQWmF6ZFJjdGtYamZGTit3aUxOblFXY3Q2cm5qWnhpdENG?=
 =?utf-8?B?c3JZSkI2TnlXYjFCUE1BZjlWbFl5QVRzWTJPVmVWbzZ4VmxRc0tqMDN4UHRB?=
 =?utf-8?B?ek1ocmFwL0ZuTGlZK3NUdDlyUGw1eldXeGh2WWdGaG5UNTg1Ym1GREg1TjMv?=
 =?utf-8?B?WDIzSmVlSy8vZW9ISWtSMndzRnIvK0E4SkN6dmZ6ZXJQSDhVRXFxZFNETXh0?=
 =?utf-8?B?ZXA2MXJ0eCttc3JPMVpHdURHS2pUUHJ5V2tITGY2cExtRm9MRCtOM0NZQmZv?=
 =?utf-8?B?RTg0dnJiK2xOcU9yenArU0s1TUxKMWlGTGh6UkRiT1JTVml1MnQrSDI5N0V6?=
 =?utf-8?B?d0MwSEhUb3l5Ujh2UWJUUnA2ZC9iRmNNaHRucC91SkRaa2g4ZVZHbHNTZjJ6?=
 =?utf-8?B?bHJMVEFNbGF0YktOeVVOOUV5OTFiRWJ6V0FiUlZZZFBRSW5QTG8xRkVaMzVn?=
 =?utf-8?B?elRLbDE3alNtMEFNVVdEVm1DVjhiY3VJVk5xeGx5TXMvdnZOU2x6SkFPZC92?=
 =?utf-8?B?MlRHNldNdnh4cUE2RmdoNzl6eXJleXZiUkhvbUszQUlSSW1DbUl4QTBtNDlD?=
 =?utf-8?B?V2hNdjlkbUNqaXJxNEs4UVZieENkR2xyVlh3S3lFdHFMd2YrUmNkUkMyaEhm?=
 =?utf-8?B?bDRrZmhialJpb0paZ2RUZVFhNWF4NWpDdkFrcS80RDlxRk9zeHVpckwyQlVa?=
 =?utf-8?B?TmNWcUlXVkJ0WVphd2RuakZXNDMwOGFmUm1DV295eU9ybTJZYVArVjF0aXJj?=
 =?utf-8?B?QTdwNkNyVUEyMWpUdXcrbUJ4czNSOC82YkJHYi9CbmkxaC9uQVRjaVlFVzdK?=
 =?utf-8?B?L2E1emRteXZYNTBjNjIxaGh0aVkzWm9heSt3WCs3eHBmQktMWUoxTXpta2xI?=
 =?utf-8?B?SmY1Y2VCRFJhS0thb1gyWXJJQkVEVEx2cXpLRzNPampjZEdSOThJeEpmRFJq?=
 =?utf-8?Q?HvEFSkSXQKS1I/03hVAInMpViWAi0et+Km0nl2zxmrPEG?=
X-MS-Exchange-AntiSpam-MessageData-1: Npx/zLFOV1QJNb6FAALnBLrki0+KeuRZHIQ=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4511c5a3-553c-4102-7a54-08df4a3c5964
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 15:05:17.8969 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b8IUczSO+YQ4uyOvvk1ksntPRdDXZqHwT97Hl7ngOqiJ4IO8VLpyJnXl2I83KKmBdy9r0HuXJl1ilZchcm/g43yfOVmSBkAbdSk7ll76L0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7987
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Johannes,

On 11/12/26 5:01 PM, Johannes Schneider wrote:
> Hoi Quentin,
> 
> On 11/5/26 6:05 PM, Quentin Schulz wrote:
>> On 10/29/26 9:13 PM, Eddie Kovsky wrote:
> [...]
>>>    static int rsa_get_pub_key(const char *keydir, const char *name,
>>>    			   ENGINE *engine, EVP_PKEY **evpp)
>>>    {
>>> +#ifdef USE_PKCS11_ENGINE
>>>    	if (engine)
>>>    		return rsa_engine_get_pub_key(keydir, name, engine, evpp);
>>> +#endif
>>
>> issue: we should fail hard if the user requests to use engines but
>> mkimage/rsa is built without engine support otherwise we may incorrectly
>> sign/verify things with keys the user didn't expect.
> [...]
>> What I ended up doing is:
>>
>> static int rsa_engine_get_pub_key(const char *keydir, const char *name,
>> 				  ENGINE *engine, EVP_PKEY **evpp)
>> {
>> #ifdef OSSL_ENGINE_SUPPORTED
>> [same code as today]
>> #else
>> 	fprintf(stderr, "rsa-sign compiled without engine support\n");
>> 	return -ENOTSUP;
>> #endif
>> }
> 
> Checked on OpenSSL 4.1 with main (3cb2cbbc) plus this gating, no
> provider code:
> 
> - It builds, and signs with a key file.
> - mkimage -N pkcs11 -k ...: "rsa-sign compiled without engine
>    support", exit 1. Good.
> 
> [...]
>>> @@ -207,13 +251,44 @@ static int rsa_pem_get_priv_key(const char *keydir, const char *name,
>>>    		return -ENOENT;
>>>    	}
> 
> Without -N, the same hole is here. With the build fix only,
> mkimage -k "pkcs11:token=...;object=dev;pin-value=..." (key on a
> SoftHSM token) gets to fopen("pkcs11:.../dev.key"), which fails, so
> this returns -ENOENT. image-host.c ("We allow keys to be missing")
> turns that into exit 0; the signature node keeps only algo,
> key-name-hint and sign-images.
> 
> -k pkcs11: without -N is how 3/3 and your c3855b08 select a token key.
> Your branch closes this once providers land (fba37b81 drops the
> fopen(), b00da645 fails hard), but a build-fix-only 2027.01 has
> neither, so a pkcs11: keydir there gives an unsigned FIT and a green
> build.
> 
> We already hit this -ENOENT path once, via -N: v4 compiles the engine
> out and ignores -N, so our old "-N pkcs11 -k <uri without scheme>"
> call opened "<uri>/<hint>.key", exited 0, and only the bootloader
> caught the unsigned FIT. Our current "-k pkcs11:..." call is what a
> build-fix-only 2027.01 would break the same way.
> 
> Could the build fix also return -ENOTSUP for a pkcs11: keydir, like
> for -N?
> 

If you call mkimage with a pkcs11 URI without passing an engine, it'll 
try to parse this as a filepath and fail (return -ENOENT). It currently 
behaves this way, and the same after my suggested patch is applied 
(except if I missed something?). We're trying to fix a build issue, not 
change behavior. I'm not disputing there's an issue here, but I haven't 
looked deeper into it right now as that seems unrelated/parallel to this 
build issue. I will not change the behavior in this patch, so this will 
need to be addressed in a separate patch/series. Ludwig has spent some 
time reworking FIT signature lately. I believe it's 
https://lore.kernel.org/u-boot/20261029100455.31820-1-ludwig.nussel@siemens.com/ 
(merged in main). Can you check if enabling 
FIT_REQUIRE_CONFIG_SIGS/SPL_FIT_REQUIRE_CONFIG_SIGS helps catching those 
issues?

b00da6457f26 ("DO NOT MERGE: rsa: hard fail if no private key found") is 
only relevant once we add support for OpenSSL STORE API (for providers 
or simple files). If you use OpenSSL 1.x (now, or in my 
openssl-providers branch), you'd still have an issue if you're trying to 
pass an invalid URI as -k I believe.

Cheers,
Quentin
