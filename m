Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBA3606A32A
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 13:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dJQQvlE8;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=ZjXqOMvm
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A0652409B1;
	Thu, 12 Nov 2026 13:59:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MbqhpLTEgfW6; Thu, 12 Nov 2026 13:59:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B5D02409A8
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794491990;
	b=Ot/YfLmVZ5XSDZS4vctubei5a3Dt3JraT9eX/wJ6pPUAORBNviufYx8o1ZWVbiUFLdRS
	 cRR4nLq9E5HuMdg1hBH06mcu63jIFd9dRVvLMeuE5F/LMIPfdFQhTaTVr6zdgagfBIP7f
	 MIfZdc04Hj3qJ076bODrQIThCbkrUTir32mSKGB3KCJ1ZVKfpPBKXagYa9T407BXHoCDq
	 lpOVBZl0IleREqFxuZTM/nZi4zXILDaooYor6Ztu7rZ0IPBRU7dJGoUu0e3r86nwYwMED
	 Fkopr5AXlT3XzCjmiX4+keulggIc4TktCgzP8GKBZnVyu5o61wv2vmVyjRV78Y06n+Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794491990;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:References:Content-Language:From:In-Reply-To:Content-Type:
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
	bh=mbKPkpPUNDyeKKRAxJvw+0Bmuw8eu3vshYpv2V61ZXI=;
	b=G40I/txTPuupHCqDxzSF4Vp+Gk0RnCvHQDvItyvpnyceTV7DgtOOLpkGNumuWgXwxMOy
	 c21bMTFRt5Inf4NQz4GDtnoWkeBWcrshu2nyjxbneVqW4g0ugRNSR4aOmcTHyrzkIMqaz
	 5SnMd6uLSVfSFgLCaAGw66P2JC/gld576m2W7tbC7jOh7MmQm5FOjZgfUftnP699QxNYR
	 6QmzYrQlXOAFB2nGNE6g4ivvliUPx8l37+p8pZezjxFsNULDPhEnL0vAxAlJ7rw+yb85Y
	 4DybifsEe+b0dqJKGLfKVPsQGETF1WtQT8bnZIm5Dvp7Rfraw+JCXgBRuNKVt10PT2w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=ZjXqOMvm;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794491990;
	bh=mbKPkpPUNDyeKKRAxJvw+0Bmuw8eu3vshYpv2V61ZXI=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dJQQvlE82eDBlV7H++7BeOm1QjbHnYB0OBMuuLOmnAtCvdKjER1s5/vSNxMn45QOT
	 17nehW1YzQ7nU9GRZ3vWV82eHyyatQimqMffarii0jO0KsOAelfw6KuSlH9V/B/1SJ
	 +/BlG8N5n0zBwBrlbPZFq6ID+z7MJ/BFom4FSJ6eyDvFQeJeW9Sf/rDnzdEK943WYJ
	 9R1JAGrnQqWx9RFEd5t7yihmCDTnLJmX0tvpSCuzMSfYTaukc+NybTFW5zhLPs0bZ4
	 C/lIjf31RxP8b9ZytQYZX7aunaHk4G++UJcHgn2vVs74tY8Ze9NvIXNDHj31JDlQ/O
	 6ICwdXKdN5JAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B5D02409A8;
	Thu, 12 Nov 2026 13:59:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 34F62335
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 13:59:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1AC8F409A8
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 13:59:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UtgTdSrxkHhN for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 13:59:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 70F1B409A6
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
 header.s=selector1 header.b=ZjXqOMvm
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 70F1B409A6
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 13:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbKPkpPUNDyeKKRAxJvw+0Bmuw8eu3vshYpv2V61ZXI=;
 b=ZjXqOMvmyka8k6IQ3MDTw+1BMKvh6EQQMnDVaeOZ4d33jPbat4vQik82L6teOJVhLaAm+z1ONJKEoaefJIsteLd8gx0NyQ7tZuDmMD4+DbxwRPQY3XxRI4YDGr4XNgtGiTdt5uUVfbIcr7nn8gmTWL+YwP9QQblbZpQBDVzagew=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by PA6PR04MB11987.eurprd04.prod.outlook.com (2603:10a6:102:514::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Thu, 12 Nov
 2026 13:59:39 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 13:59:38 +0000
Message-ID: <06aa5a02-0f60-476a-abab-aa3de9ad6019@cherry.de>
Date: Thu, 12 Nov 2026 14:59:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] Update maintainers and get_maintainer.ignore
To: Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
References: <20261112115842.39126-1-pbrobinson@gmail.com>
 <20261112115842.39126-2-pbrobinson@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261112115842.39126-2-pbrobinson@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI6PEPF00000224.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8f5) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|PA6PR04MB11987:EE_
X-MS-Office365-Filtering-Correlation-Id: 5053583e-9489-4ed3-99cc-08df40c5305b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|22082099003|18002099003|10067099003|4143699003|56012099006|11063799006|261026140227099003|261026121527099003|261028144727099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: ChDuOZEGtYeYHqEwCINemKKso0LbZ8fmNiA2Yk6fCg7K0tj60EBg8HtXqIiSNfurp8Jxd0kbl4K77McBgNCJNoxlfvvJuebsNFujriPzi7DNElQTvQBhyePVarQQ+m/JASbL5Uog3Q2+33mQiVFoGD6ZobR3WDLofZOybXHtznXB9OxqOvOC3xSNgm8tNrnf8TYVMyBEdGD3Cd8T0ZDacYLLnX5Toy1rpGGaKsVD5fsfacVVFErhjlJIRtEJ86RyeBX+ejnpV2uq0jkByG8+8lMpxYDK7D0iJMHdmdcQ6zh4BOAUZ3QKClYOV4OEV9oIji0N7aQeimK6yjHRFecOXANWXHHPXtgsPX6/IjG0CIw2SK7C5DTlkKvlyJb0plNJ/kHXEEdcj4a3oaX4ZttcEXsL4eJmsBChOwxkCjlJC4Mhk0nk7558WS5pICILHUobkllLo2r0p/AYhE/QfyrfZ0foguGcerX23W3K3gNSRvgjL6l2l4sPkaDe0DbZ9QuW8pE9Bp2IeuE6uLnB8GRfmMxqyYknslsDA18BWip20rYPXd6lYO+lYe8EqDRp/D8nD99KTFl+RoN29uF1Hutv7xu894EnkxleOwpCApMbVzahRL3D5hnmexqqjal/xDEzfqHFfF+s6eoTCjtJGdPSS1vsxcr6nvHu7jY9gZma1A0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(10067099003)(4143699003)(56012099006)(11063799006)(261026140227099003)(261026121527099003)(261028144727099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHNmUCtFdXlTQXFCWFFvWWV3SjE2Vjc4NGVDYVhMS3hQdktvY0ZhOGk4Wjd4?=
 =?utf-8?B?SkZMeDMrWmFsZHVCQTdQYjJldmFhaW1qSnpURTlyZFNGK01aL1N6SGRuSERm?=
 =?utf-8?B?UnhWMERhMGkzVi9sNVhYQ1kvdFpuK01lWWZ1cVdKRkZTWUNOM0xhcEwxa0h5?=
 =?utf-8?B?WDRvY1E2YXBNd3VDeUhwTWlRQmxkV2thbmFJNlB1RFhpSW1henIyQytqaitR?=
 =?utf-8?B?T3NTMnBaaUpweXFtTzJBczdYTEhRMzI2M1ZwK2kyTUFtMTRQL0xxRUdUZ0R3?=
 =?utf-8?B?VUVlUzE5eWZGdnBxZUNHNG13Q0tNVi8ycWxVNlNXQmw1dnhqWkNLVGhndTFT?=
 =?utf-8?B?N0RsN3FYRzhPQUcyT1pETlBRa2RXdlFERG9EMGhpTmxGeHlmTTBqUTY0aUgz?=
 =?utf-8?B?NE0veTJGTXhNSTU3VkdNMThpWDVkZUlUZ3lWelVscUtlTjR6Yms2U0ZPbUVU?=
 =?utf-8?B?NHpGWmZuSkJWRnYrWm5LVk5RNDgwYzlpRlltVm50aVlyckZUaUhLNHRtYzNm?=
 =?utf-8?B?UUtiaUlycEQrUmRveU1ONHRvSGpTclRwYTdtL0RLVnhxSUc2bTl0SlpjWmFP?=
 =?utf-8?B?aVJVREVtUXF5eHc2anY5aWdIKzY3Z1FVN3M5azMwWGxtanFLMThnUjRhcnYy?=
 =?utf-8?B?di9vUWdnS1h6TldKenh3dk5yaDlmRDhPSGZ5ODQvKzNRTmlhaGZxMDJiakUx?=
 =?utf-8?B?SG9vNTl5YzNhUUJ5RVZaM2pjNExpeUZnZG1FbVlWTVM4c3gvWUpMUnl6UUxz?=
 =?utf-8?B?SGtWbmcwWkVaN1QwRmJsYVhtaWhkQlV1aURWME0vZm92R0dVemx5T2FXTDJk?=
 =?utf-8?B?M2RUa2xJZUwzQVJiU0RCbnRsekcxTEloNkIrQXpUOFpxcWFEUzl0NFZ2MEFu?=
 =?utf-8?B?YnIvS3daRHdkWkNzUDd5WmV4VjlRWXBlRitvaXBvNE9VbGw5bi9uamNhUFUr?=
 =?utf-8?B?cjNlSGFnVkhIOVRjTk1MRGIzWi9ZSXd2RE1wZlFmSGJPY3JFVjNDOG5xMkZj?=
 =?utf-8?B?elYzaCtZMyt0K1Z0T3A1UHF6ajF4UnFUNXFTYXZqUU95SFBpYkpJY0svRWc0?=
 =?utf-8?B?OWQ0VUp3RHYrTkJleTUzdVJXdHl5dWczM1YwRk5YdVNETlQzNnE4N0c4WUhy?=
 =?utf-8?B?VDc2V3NNRFBPSFQwOC9sc2hMNXplc2VmL0wwclpCSUhXd1NmU1F2eCtMNFhm?=
 =?utf-8?B?bWVrQkpKWVdhaXNBbGF0WWJIeUk4V05scTNQTUVBVGp1Vks5VDJSMDRiaEZP?=
 =?utf-8?B?d1crRk5SK2U5TjhqeDNzRm9QN2gwdmsvRHg3YVRhMDVDRllMcXRNd1RRamVw?=
 =?utf-8?B?NVJtM2x1blIzZUtLMktsczlqcUFRZ2JUQjFUbXBteEFjMElBZlBud3drdldO?=
 =?utf-8?B?aEEzTjF5SXoxVDk2UjFTNGpPWVdUcWxsUnVwYXVWNWV4R2lhMk84bW1uRDh2?=
 =?utf-8?B?dDlDVjR6YTFielhUTHJOMlBVWGdCckdQWWkrZFBZOHZrbmpFcUpTMFRCSHBG?=
 =?utf-8?B?OWhBNFYzaWkvTkdTZFREbk1yWE5OQWg1aHlLRGRWV21PUG5HVFFBUGZIcmNm?=
 =?utf-8?B?RXNCdVNYYjlsbktSVlZmY3hHL3RaWTFpUm8yRDJidWIrWXVPeXZNbVJzZmFk?=
 =?utf-8?B?UjNyOHNSYWF1aXVXYXROQnVUVE53Skl5NCtDVUx2R1FURll2Y0x4L2tVN3Ax?=
 =?utf-8?B?V0VBMEpybThGbEpKNEU0NzVMRlozc1ZwbzVlNnhYbVJlK2svb2JTdlVJSXRh?=
 =?utf-8?B?Y2dJdjhGUUdNRnAxUXE3OS9zRjJ2T1RCQXlHT1ZQOFdoQ2llS2htcnBwTVV1?=
 =?utf-8?B?MDBaR3hxaWJlNjV1blNXM0tOSnZiQ00rQXVpaXJGYjRMTVQxR1JSNnRZT3Rt?=
 =?utf-8?B?UHMrTDVibDJJUitCQU5lSzZkeTZ2ZlZOSXRieDB1bmJlS2Npbk1XMHJ4Uzc5?=
 =?utf-8?B?TDc3MHMyMHVaR0p2OGNick9Lb1JTYS9uYlYrWWlDdzRxanRqZ3B2T3hUdHlq?=
 =?utf-8?B?L2krNHBTWFF4UGlUVFFsdkU4Smp4UkRhRGUwNi9OSVJYenFOWVZDWTBtR3Bn?=
 =?utf-8?B?UTZzWDhFcnpkVUdBVW41Rk1UaHBSU1VYUDk5VkMvNFZqMy9QdEx0eFplT0dE?=
 =?utf-8?B?SWFKLzUwMzViVlltV0oreW5BUVlxVXVwcjRaL25TZ3NNSTB5UFk3VzJVZFE4?=
 =?utf-8?B?UkEybmVUYW1tRUw4ekwrakNjUmlyZ3hzbkRpVkZYdE8zcThQa2hST0g4Ri9v?=
 =?utf-8?B?YzVBN1pTL0RaMzk4eGwxaW5Ta1lrSE81SlBtZm5xalJ2S3ZKTTlyTG4yR0tz?=
 =?utf-8?B?QktoN3lmUDYrNVZLQTdGekwrZ2xHRGVpMGlZWGxKaVJSVXFySXAxZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5053583e-9489-4ed3-99cc-08df40c5305b
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 13:59:37.7392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GlzmXydSJkVQsNndRQl8HUf2ONrNHoaUurUfS/Tjxt85qpoyKPNscgWNWD5A+BIBI0tuCez00t+UHOq2WI0bdG6Jv3roe+4+Zl5Xp++t2zM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11987
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Peter,

On 11/12/26 12:58 PM, Peter Robinson wrote:
> With the departure of Simon update the MAINTAINERS file
> to reflect the current situation of various subsystems.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

I see we're updating patman MAINTAINERS entry to Orphan... weren't we 
supposed to remove it recently? I see it's been moved to Simon's tree 
(https://github.com/deinde-dev/patman) so I guess the "find it a new 
home" part has been done already. Is there anything missing maybe or can 
we start cleaning things up?

Cheers,
Quentin
