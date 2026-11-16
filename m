Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4535606A32F
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 10:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xUjtF4Xj;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=FHJCTWrK
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A83BE606AE;
	Mon, 16 Nov 2026 10:55:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6cL87j-z8yRY; Mon, 16 Nov 2026 10:55:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E6183605EB
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794826529;
	b=Zhor6RSY6QTlah+T90TcDPR3yGmFCn+Lo2KneakdjzBT7le88vtgo0YNHtQA2XlxkysG
	 DKTQgg7igbsTXxge8dDsswYmjxKEMcp1WJg9ocM7YUFYg1NKOK1+ut5g32+WT8c4RUbQ4
	 3PcWHfyUAQ3dnnrJbf9dbTF68oL4cUIdfZAzHgqtIZkgq1WMPB3ijhHPxlhZifva77r51
	 j3ijBAtajwFWERdBDyN0ZXZR0qPLgNmmJgRd7kPcQ7bFQzZHRskt0VoDXVWyuEA4UOntd
	 mmLBPsePLDcWrXlXA8iZK9FQ1L/nRXIG1EBzSbqAJBWRJMBmXbF+rzK1WnZBeL/AufA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794826529;
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
	bh=Zl//nPx6Y9TownCbwDOT88CdMwDw8Tf5QCkstHLQkXc=;
	b=WhisurfCjdMczYfUseHn8fG68lEesXZpAcn8verTbBbIFQvPBOpvzVmpjN2OeNzF9+X1
	 pZgAVhvGq6hwDwg1E1Np16b4u9L31vZyzrf3FJSYODqo2yNYguIZ3NGUsUcW8A/Dl6rUK
	 yDj79F8aWWBQOs+BeJm/RWoKsU3BJIb/Twli+kBZSQFerXIDqernOCxPSfRCEeMgZ/5zA
	 FMKi6BY4zdiXT5vHu6Mx4RGjcnWInHiVeBNADr77wcEA+pS1P8AAuvDMbGrLdryEfJorh
	 NEvdJRQFQLHCXMIkH+CI3LcuAx3ZZ3aK36XGzEPQZQyUGfPWlVKgblAXLve35hD2K3Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794826529;
	bh=Zl//nPx6Y9TownCbwDOT88CdMwDw8Tf5QCkstHLQkXc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xUjtF4Xj3XHI9DZHzfWtzmjjG6dAN/5BiE0xdH+CkoTWJLEvKOrF5BhzekHlPy1V8
	 PBPZ1LyZzFuaKfO/au4T+i0tjvpTTs1e+Qz2q6v2km93Z5R/gpwNLzJ5SpA6E4AlL2
	 cWugWWCt1f+RsN4eCSjiczcJhLJY5XdhBdUMCb0tcFB0WnRFVvPqAoQfFWu4LFYh9u
	 piLGcj6vqeelwZlyRh1GgH8bC0XGBRLZflMzoBBNZgrqLiPqDVCIZl+X0cy1LTwL1t
	 hYCeDS5YWRZzaA5K+PigwVuWrYJWGs9ujAeQz6cLO0kaLdFQeMiuFsKHPscv98jYz+
	 Wc3LPu1nffQRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E6183605EB;
	Mon, 16 Nov 2026 10:55:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A63641A6
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:55:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 985254009D
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:55:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7t9BjJ5gRFNp for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 10:55:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 09DD540068
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=FHJCTWrK
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 09DD540068
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zl//nPx6Y9TownCbwDOT88CdMwDw8Tf5QCkstHLQkXc=;
 b=FHJCTWrKBx8bLKPVQKb3/OX8iKO0Uket6y0mJUK0SbU/JfYj5NoQBrluc9OA96O1ugZE19/nW5mSrVSgiA1oorN79W97EC63JTKcTyd4QHHwymfyOqRTEi9rKf2EGUqRpSh+LZhlJ3xucCzQX8ZsQEqVjOPoit8uYjd0KVQGDhg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by DBBPR04MB7707.eurprd04.prod.outlook.com (2603:10a6:10:1f4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 10:55:20 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.009; Mon, 16 Nov 2026
 10:55:20 +0000
Message-ID: <ca64a640-6f9a-49b7-ae33-af8a91bce882@cherry.de>
Date: Mon, 16 Nov 2026 11:55:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: rockchip: rk3576: Fix ACLK_TOP divisor value
To: Jonas Karlman <jonas@kwiboo.se>, Lukasz Majewski <lukma@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>,
 Heiko Stuebner <heiko@sntech.de>
Cc: u-boot@lists.u-boot-project.org
References: <20261115200447.120668-1-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261115200447.120668-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI5PEPF00000922.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::831) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|DBBPR04MB7707:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a7e46de-5dc7-4150-b37f-08df43d01b20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: feRZ45RnlhGKEOwH3kFcoILY11ukVIQpNaYwAfOy4YoC9WGwXZliBJTLGoZn5PjgaDpWAyZin0Rcnsy9ReMogCRDJ7C5lGzKH7Z1XqkrMVsOvxqSNoRluSLxVLwadmfjNDKFKXZkmvfrNM3aHSHsDITzsvPbfwtjlt5TWsZsBviA27QLNf95a62/0nxGoZxqkmPNE+yLKskWTwCBK3CIYu05plvegWInJAbrJwcIe8YVpCtCaZJS+Az3IGoOL71IrOfTlgsl0hFG8ipznYaDrlHmH0BoZXLX1lwINrrj7uQhv1LPdPysuV/6Q71ZRWxN6NdTKhxxbzy7142p89ECFN8Rv6yMjRatY+tQwgGVW3ECvkHZuM1CcjkFqo/HuN1etDjU0i5WSyysOFTvpicW0GwBNXgOcnypitI8z/mto3xFn/sxwGMm9Xadg06ZUgsjcdZmvrqdICct9zvyda2+pf0xF27SYosiDZYgMrk4TmKLuWdRqHK4OKS5XR32c284fjcqkc3jKT1WSlPlz/jweLAja6eL7LZm7ioq6y9j5EsH6nkNG2S152CyeAkn3FhJplXfTpQDPME50kJzDaSLp+jrq0ec4HQ8trDdtULOHMNbha6KOU+83s/zbRTC84oDWM9yHSaw8mKwYBrI0kbK0zGFziFcngw7fSvVQEYqchM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1k4Nlo1MWVMc2k3QVdOdnV5RmRQUXIyMmNHN0Fha2VlcmlvNHZKQnd4QkxQ?=
 =?utf-8?B?N1Q3MzRVS3FScmRtMmozdTVWOFp4Z1NFTld3L2w2VC90d0g4WkFRMjhjWDdR?=
 =?utf-8?B?cXJBZ0Y5Q2Z4alJKb1ZUS1lNQmlhdDFtOFB0R1B0M2hucC9VNURKR3czWTFG?=
 =?utf-8?B?YWpwSWR4OU1YdEcxSnR2VzkwaFp5akRZaEZaTkxuTGNjS3RpeE1MRWZSYUVt?=
 =?utf-8?B?c3NTcmxLY3NudTZyRFRpQmQvWGlobjhnOW93eElrSUJndW9iZkRWRDY0N2h0?=
 =?utf-8?B?RG14elZaUHFVWElFTTJYTFdpQmNRc0tDRHExTXRaVWhoQjZ6bHl6M1hvaDVE?=
 =?utf-8?B?ZjNLNkZBa0NXbzZpMjZWTExHd3pLMythdDRQY2F0SjU5U09JektkMThxSkVs?=
 =?utf-8?B?Nk13eHFpQmVZbk9QME1LcXJQSEp3VkxHbFMrMUxqdDdxTm5QTHpaTW5jOWR3?=
 =?utf-8?B?eTJ0RnlDUm11dkphQlF5MVZudkJMWmd3em1vbHBzWHJhemRVWWRRUk1UWERP?=
 =?utf-8?B?cXE5VkQ3T2lsQUNsTHNCU2s3czZOSGJ3T1BVNDBrYWNtMkZmQjdxdHBkM3RO?=
 =?utf-8?B?WEZneHU1NHh4VzRhK0cvNlNJa01FcFBOWEVnQVh3OXowYzNLNm92Q1E0NFB3?=
 =?utf-8?B?TUgrYk81aGhKMUhERUl0RCs0enRnVXYzQXJ4OXJwWHdUODZTR1hVeXlxWHM0?=
 =?utf-8?B?UE9KaFh6OGpELzA4VWNLYnJoamgvSEl2V0cvS3BKaXhUemZ0eExHMTJNYVZ5?=
 =?utf-8?B?dktBcnFIMTZORkRHblY5R0I3WmlNdFVaelRFQWpkYi9FYUltVE9kZ2FsZlFp?=
 =?utf-8?B?WGpvTjF5U1VlM2ZUL1VjTVpSUkE0UWNiU0FWVzY4V3QybnNNNVEvRndzMWZY?=
 =?utf-8?B?RVRYNUliUjlyTVcyaWNOeUhWclVJQ3dTZHhvUzBkZmErY3hsdmlIcFFOVEFE?=
 =?utf-8?B?WGgyam0yaVVpU0dUdGV0WlpKeDZzTG5PZS9TbXFrdjBFaFF1YytNaDVPV1Fp?=
 =?utf-8?B?Nk1RN3FvOWpxcTRZbEg4ajJtMmVJWm1NODRLWC8wb1ZIeEdRM29FdGxrTUlq?=
 =?utf-8?B?Y2RQVkZZSkQ2QWxNWEY3eVFrWWpKZkU3cmJJSkRhbjVJOUF6QzRNUXlWOFpD?=
 =?utf-8?B?NFhUSlAweEd4cXkxWnBvUDVhdStvbEN0dHl2UGQxMS9tRndWTEdRM0F2ZGFz?=
 =?utf-8?B?Rll0b1ZYM0VXMVlqUTNkQzJVbGNqTkwrU29sOEl3Ujd5ayt0WFdWUDZDM2tO?=
 =?utf-8?B?YlYyelhwdEh3alFjY1FxSE9MNkRTdkJkSTB2R0hCckdFZXUzeE9RZCs4aHVL?=
 =?utf-8?B?enI0WERoUjdJc1lMNzB5VnRqNHF2RHhCL2kzSFhHUnZoQ2VEaTg5cWp6Kzgw?=
 =?utf-8?B?VEZmM2xsejRLMnY4R21qWmlOdDlRNU4yanV2dW1WbXhqVzBqRmZYdmNkdFFt?=
 =?utf-8?B?UEJ6NjNJa2hkNiszbkpQMjRkTlJqdDFMUmp1a1V1ZE5BUFNJUUgrWVVmR0lk?=
 =?utf-8?B?Q0JOeXdrTnM0NktYZjU0M0gxdjJlUXNTa2h1SGY0VW91K3Q5eG9QT0h1Rlkx?=
 =?utf-8?B?c2NlUC9WNzFaMEtXSXdVK01FSUZnbllGYnpoUTNJdlF5cGxZSXgzZHJxcnJ5?=
 =?utf-8?B?VXRUc3g5MEZpaWt6eVRSMkpiekRiUnJneVBGelA2ejY5YTYvMjJiMXV3RWRl?=
 =?utf-8?B?WDQ1NmZZblpJaGw1cTZhQlJrbnorUnA5Y1Qzdnh3MEkwc3p0Vm5hY1BlcHNr?=
 =?utf-8?B?K2xhVnQxWlVxckRDUXJaTHdZU2VSd21NTE8yWk9ucldUVk8ydmJBdEI5dWF3?=
 =?utf-8?B?QzRDdXluRVYwS2FZaHlsNC9zRXBMOG9oZ1doSzR4ZTRZUDExZzl2cEp6UU8y?=
 =?utf-8?B?dFpvLzVCWHlxTmFWTjBKbGdXSFlTcGJqc1dPbGFXT3BhZkhmajdNSElORlZ2?=
 =?utf-8?B?ekFPWFFlQTZCZE12Ti8vT0FYUXlzVWZSZ2Vodklna2ZvNE1IWHNwNFQ5NjJG?=
 =?utf-8?B?b3RHdE9JNzhtcXdNcUZVa3lONS9EZ3IyVCtiK1IxQUFXZ2pKMVRlQ3lubmd6?=
 =?utf-8?B?eGwzRlZJNVluc0QxS0c4bGoyNndLSjBBRW1Kc0hJRGRyMDN5bFBNVGpIR3JT?=
 =?utf-8?B?bE1wNElDNGhOREZuQkVzYjhnSHJoQ0JIMXY4cDViSmNyNHYwcHBYWEZpSzMr?=
 =?utf-8?B?eDY5VVNiZWZWK3NicVJ1T3UyZHVpdGhldVZab3B3R0pBQ0Rqb3QyRHBwYWlG?=
 =?utf-8?B?ZFBhSy9UR3EvckFidDZ5ZE5KRXFmK3puM2h4UHF0cGdtSHVlbTRYbHpmN2lm?=
 =?utf-8?B?Q1dPY3VHYmpKa2IyQ2tSdmhSamlNaERtUW5UYko3U3E3VXRkdkZiZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a7e46de-5dc7-4150-b37f-08df43d01b20
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 10:55:19.9603 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sWJ7ZBgxrOr2iB5WgEwn8YXzC/y+wdvqSVMg6Bj94npjVtn8zpKV583wunjRSTyUBSQ1cpSDGHL2wFSckOT5oqjOvFx69ch2U6dt/w4LYz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7707
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

Hi Jonas,

On 11/15/26 9:04 PM, Jonas Karlman wrote:
> Write the calculated divisor to the intended divisor field instead of
> the parent clock selection field when ACLK_TOP rate is changed.
> 
> Fixes: 3919310b37ec ("clk: rockchip: Add rk3576 clk support")
> Suggested-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
