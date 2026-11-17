Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE016606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 11:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wnr12Bw6;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=YfGK0F8h
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 84F626085F;
	Tue, 17 Nov 2026 11:47:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CmTZWwoP39Om; Tue, 17 Nov 2026 11:47:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 84AFE60846
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794916058;
	b=kMaaE68Kz9sHxgLmWYh2v8hfBhmmNAotTsMJJRoFqpPEq4tJ33wDBJ3rAQNG++uVg90o
	 Dbkqycr/cP7GejOiP2qFhAI15DkuywJaZfZSvV1tO8y2VFMDk9ldNbvlOpV4W9H6mwXfi
	 rtK2qSOsOTT/WBDPTAnzaMD3gi5Q7edzBrQSFvzciJ84ZinwiLjgtl50TtRD6aw5gg2Lm
	 SCHJz5UrG0/OJNGvU97xY+vWCz/aFXfkty640EQGAVSSDU6F2TLN488Qin32NgTPRlpio
	 7WDujsZ8PfKiORqC9h8vdUxkkO4F6dOVMiSRtNzB+IGlbHFYxgqGkk++/85vnR9BNaA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794916058;
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
	bh=xpaaKmF6YPJUXc0WpWEwzQ6lyFE5Ik6o5w7b8jWIwnU=;
	b=hMiCyNSskkFxDR1+/bSHV7J9761zOKWh2GRyTjQ/pC4Hqtmk0bbFQ99GqcqKlKMoqZrJ
	 roeOv8Pnk+2Xk5dxwkq7FtezcGpqPQvzhYplaOmskgntX8UegIP0iJ/xnhaprQ7KZ4U3d
	 wJMHfD2s4Dn+MrVqddcpklgY8gnXjV4MARxK8EdrhmP4SnHR44vKI1bS/186TKRayGgvU
	 3T+7LYDWdRANNtrFmEhRdXA0M4sxGuSi/kKXjep5V4iCzIB1Pr6rW9dXd5J50SGvzH32J
	 o7aQvLynhrBb6SGmQYGKGk42pJh/Wf5e7MM9uJlimCr0E+rWJw6NqsVnYTQLWImLl9w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794916058;
	bh=xpaaKmF6YPJUXc0WpWEwzQ6lyFE5Ik6o5w7b8jWIwnU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wnr12Bw6/BvKP85ehKCNnctSdQwSjfLBSvCsOF+YghovX4OQfB77dRcT8BxGfS2v8
	 x34Dva3korLD4FXR4dgv4DvvVXqOzDPM2T84jhCk74HTFojqLVe2Vs8vTsdN9X/msv
	 fenNMIXGM7Fw/+Lg13Qh9Tn2uA/CkT2DuDyJDexP+zxXyBs7taSpBjw/8gH4cT2sdl
	 UMA0JVoVO566wDPwFBc3BaQ5BcxrzlZuqU5saFoo0PPzLmgvhql6k7FP4W2gvtkqMD
	 i4vmv2GdsAxIdppVZmD4fo0Q6ATxgaR2pS6og1vtvJDZqHPk7K+zDtOrSxvZ3GTvOd
	 zEWmFB6jiPbyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 84AFE60846;
	Tue, 17 Nov 2026 11:47:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3757170B
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 11:47:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1F255810AA
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 11:47:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NSE4XBTvWHpZ for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 11:47:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B45B78109C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=YfGK0F8h
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B45B78109C
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 11:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpaaKmF6YPJUXc0WpWEwzQ6lyFE5Ik6o5w7b8jWIwnU=;
 b=YfGK0F8hZS6xD2ZFx6c8WGEF7/XznfQiUWRIEChQOwnaquNfRX2Qb2+dxSy/kw5O+jen7zd8wa5sQ9RFgWIhuEy7xHj35I/NYs/Juxyrp9TNLDNfMqQcw1uFu3WhEofREXLFZRgIAJcPLjvPMlqOub8g7wBiXkZCHtk7CNAQxbM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by GV4PR04MB11750.eurprd04.prod.outlook.com (2603:10a6:150:2da::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 11:47:24 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.009; Tue, 17 Nov 2026
 11:47:23 +0000
Message-ID: <63fe740d-d6ad-4833-a263-226f965aca25@cherry.de>
Date: Tue, 17 Nov 2026 12:47:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/37] clk: rockchip: rk3576: Use correct mode register
 for VPLL
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Elaine Zhang <zhangqing@rock-chips.com>,
 Heiko Stuebner <heiko@sntech.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-20-jonas@kwiboo.se>
 <8cd70f39-0ede-4d94-b9bb-ee4dc635a71a@cherry.de>
 <b39abc06-2c35-4b1f-8b48-0511ed58e6a1@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <b39abc06-2c35-4b1f-8b48-0511ed58e6a1@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P189CA0023.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::36) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|GV4PR04MB11750:EE_
X-MS-Office365-Filtering-Correlation-Id: ed0ed409-4a69-46e0-52cb-08df44a08b7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|18002099003|261009223027099003|22082099003|261022105027099003|261028144727099003|261026121527099003|261026140227099003|56012099006|11063799006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: dd6MWNCJ9NVxk6iRNKdPZd6da8YkbxgC/p2bpqFrlriqAjJ6/EkY9mc40bwC6wSpjXQG3DcAkAD9XO//KiXVyzhb1jt5qujdJbOY4+G43n6trL6EW4BT7Kj3BeZYO+73OYUyCz2f2rNUmeehNCs03XY1dEKWXSedROo4XylgpaLdyLvRUB3LXZMrUT3DOgqD4lxIqfsxdQ2C7vokdby37ZB+KG3gdvxuxQRtZ0NrWI1U2uM+rUMAyHXYcLnsbAjaZch/pQckE2TYLfjje7W04NHZeftscm7sCpz9pDPtLjTTVi5yeeeb562ccKFa4wvAnhm+iPBb1gS8ceoWxCRah0IzhShIYjXoHPISJgKtQ9amWLjwgQkcqeV7ZI4/Kw2XGEWwGNdR76iqSePQOjyGSK1YTaqXEs00jPCAT1I6yUbzJLizikLmM19n4mufZC5NgTKJtpcgGQqXIAcxmY3JCiwa8ldUCU964GDsjkITosPqy9NTxSf4005q8T47uQN7UwIr9XjQkMullypZQYoZ1Z4nGr4xsmo7DzE41W5f7iZ9NMhG4SdK2IQ8Y8YuFqaLrQQg+VpJS9oZu+rLtEMKTOlHZcR5lLmGb/L7IHzVu0vX2oN9obe8bp+JhCu5/9Rd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(261009223027099003)(22082099003)(261022105027099003)(261028144727099003)(261026121527099003)(261026140227099003)(56012099006)(11063799006)(10067099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RktYNzg1ZGViL3RHQXgwMDNubzVKV1cxVVlkNkZ2d3NVeTBaQ0FQaFZWZWRO?=
 =?utf-8?B?VGVTZ0h3c2k4TUVUeE03bDF4NVNBakhHMDN2TTR5bk1IbTRuSTQyM1NuSlNo?=
 =?utf-8?B?dEFvYjcrZE1SV2FaZ3o0MUVjYTRQQ0dXeXgzaXRBY3FGY2JLMWc3QjZFN2Ex?=
 =?utf-8?B?RldxV0xIdDdiR3ZUMDIzRFVsbWRmVGZlbmxvSGtQRjFLamg4NmtJR3JHMUNh?=
 =?utf-8?B?WVdRNzhIWXNLTjQ5dXZ6RHJrR0MrLzJQbDlXM0NzaWlUcFFxZWNuTm55c0RG?=
 =?utf-8?B?MlN0V1VUWjd6Wk1zLzV1bVBIa0E0d1ppS0YrSFpvemRSWjVBY3ltRXpwbHRz?=
 =?utf-8?B?eVZNa2xqSGw4YVFHU3NPeWxxa3dYWEZZQkhrN3VrRVlCclp0NHN6RVEwczZU?=
 =?utf-8?B?a0RJWnZyV1p5cHUwVkZ1Q0UrUUdGNWFJR2J6d0tqTXppanNoUFNPazBub3VY?=
 =?utf-8?B?TUV0TVRldHhKZThRU0luMmNWR0FnTGtBNVJyYWhYaThRS2dOazJBMkwrV1Bp?=
 =?utf-8?B?VVluNEZXY0dreURPOG5ZZ1Z6WS9NbWowYUFiaHc2UHVzZlpaSXQrSDVpTHpV?=
 =?utf-8?B?OXc0Y0Q1Sml5ZFJVRG84MGdLbm9XUDZLbEI2dXhiOUN6MDRIT1J0QUF5WmVz?=
 =?utf-8?B?MXhyM0VoRWFwbWcxcS9pc0szUUJ4UDNIUURqcVNMZ0RSUGh6NjkxVGNJRlhC?=
 =?utf-8?B?OURiNURYSENlZnBqMVpuUVRkQTR4MzdUSG9DckZRSEowL1czSmlnRW5TTXJ1?=
 =?utf-8?B?NGlPSkVjNXdJcEFkMWxlUlJaZDE5OXhDOXdtY01TSXppQllPUGZBTnNvQmor?=
 =?utf-8?B?YnlUYmE5aUNKTjl4SDJ6TCtFdDl6eFlhN0grY2MyWDhoNUlZYUxIYVFtcG0r?=
 =?utf-8?B?NHRkMkNvb21BVHFGVFRQLzNmQlVGbWRUdUxUQnM0Rzhicy9janFyQ2xlSDRh?=
 =?utf-8?B?UE1rSnRndFFFR0Q5RTdVdkVWUkZ4Rkk5SnJCVmNkbS8rd01BS0FMMkFOalFD?=
 =?utf-8?B?NDNucW14YUhRUXJvWE5zKzdOZWpraThjS1IrZk4yZExqNlhqTDB6TVR0V0pz?=
 =?utf-8?B?MjZ5ZTlqd1J2WHUzOEFUTVdTdkk2cjU1S1MrS3pXVXdrMG9LdzMyL1c0VVp4?=
 =?utf-8?B?cEVLY1VEaWhSajYxd3A1NGgrU1N3MUJINmJJakQ4TlhwK3krVFQ1dVh0Z3VL?=
 =?utf-8?B?L1JPR01NZDE4M21TcGZmaW1BZGtucERuSXVPSnBFa0Q3d0xDQTRQTzBSY2NN?=
 =?utf-8?B?RVMvUkY0ZFh6c09JazJzVW9JS0tCVHRrYmg5R0Z3YVlTVnJhOXEzTFpjbmYw?=
 =?utf-8?B?b2JMODJ1YWV0MmdDaGk5Q0ZOUWtOYmhNQVhWb1pyVzJRb2x2NXVQRFRHNm9C?=
 =?utf-8?B?WXhLUEhaT21rbUtHaktBdlZlWGdrcmlQRTFYQzIxTUNDanVEUE01c1p5K0tV?=
 =?utf-8?B?dFV6VS9mOHhRWERzekZsZDZIL1I1aExWcGZGMkpqNy9ITTZpWlZMaDZpUnJ6?=
 =?utf-8?B?MXY3d0RnU2Q1TEh3SHk2L0hCamxJcGJ3Yzh1TmF1Z2dYMGdYb25iWXlNWjNH?=
 =?utf-8?B?bHFIZmZ6WnovOEpaeHBtWFhYZk5MSE9ZZHpSMTdBQ3VOT1NuOEYwVXNwbUJm?=
 =?utf-8?B?eHdvdWtTTXk0V1lTR0o5YjZrYVYwMVFzeXVFWnNJY3hHSFBidDlRVTRhbWto?=
 =?utf-8?B?QlNRaW1nZUtaS3B4MGJieXdXUTIramRPWktya0NKWXVtNTRoalp1N1pXMytY?=
 =?utf-8?B?MmkzTUlvazFXVElsSVUvWXQyNzdrOEJHTEJ6WTB1bVJZcHJDRjF3YTRXS1hE?=
 =?utf-8?B?MzMxVHluOFRJbllwMzBXd1QwVVBHczRncXFtT0J5d3R5enA2Yy92VGF1ZGpz?=
 =?utf-8?B?U2k3OVVYdWc4c09VL2M5bTdOQVVOZUxwaTMvb0xyM21mWTNNZ2Nld2crTEJS?=
 =?utf-8?B?d1dXQmo1UXBFL09YTVgzOFFWb2sxK0VrUVBXRWRFam5OcnI2NUp4enpGTk0v?=
 =?utf-8?B?TVBjY1NlTTc4KytybEdWa0JkV1A3TUJzSllpOVBHTWNuRUdzUUpkeU1BSmFS?=
 =?utf-8?B?aWV5VHhxZG5IQ0dNSDBiaFNUbnZwNUpyaWtxeWxLc0t0WlNNQk9wMDdsTzFR?=
 =?utf-8?B?NDNHRTZCM1RqUmRDbm80NWpGalZRTGRIRTlOU2MvaHQrblJXUG5kdFp5Tk1N?=
 =?utf-8?B?amcrSXd3N2NBUVV4dmtPWHplVko3R0ZrcEh0V1Baa2tvckxwRk9vRThWRGZT?=
 =?utf-8?B?YjBXMjJ3cXc3TFh5RTdIRmFyM056S1loYW8zeUVFSzBQeUM3RkFmTEFpQTlU?=
 =?utf-8?B?S21lY0FYMzJiS3JHK1ZYUlpsWTA3OFN5NG1ldGlJdnloSnRpMXJlZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ed0ed409-4a69-46e0-52cb-08df44a08b7c
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 11:47:23.7960 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aIMuUQSEOSSGNHYeZzmONz6H/e5isCuh7FqIg5iw6B1ZBl+MyQxKddqQCct562OCLfhvtG/gy9vSio1PlxBBlXvW0XhTpjBmAK1+d34eWeE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11750
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

On 11/14/26 12:59 AM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 11/13/2026 6:50 PM, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 10/12/26 12:28 AM, Jonas Karlman wrote:
>>> Change to use correct PLL mode register when VPLL rate is changed.
>>>
>>> Fixes: 3919310b37ec ("clk: rockchip: Add rk3576 clk support")
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>
>> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> Looking at the other clocks, I **think** RK3576_BPLL_MODE_CON0 and
>> RK3576_LPLL_MODE_CON0 are completely wrong?
> 
> They should be correct and match what you describe below?
> 
>>
>> The offsets should be
>>
>> (0x27238000 - 0x27200000 + 0x280)
>> (0x27240000 - 0x27200000 + 0x280)
>>
>> no?
> 
> Correct, the MODE_CON0 are expected to be the offset from base parameter to
> rockchip_pll_set_rate(), i.e. priv->cru, 0x27200000 for RK3576.
> 
> With below defines in cru_rk3576.h the MODE_CON0s should end up with same
> values as you describe above, or am I missing something?
> 
>    #define RK3576_BIGCORE_CRU_BASE		0x38000
>    #define RK3576_LITCORE_CRU_BASE		0x40000
> 
>    #define RK3576_CRU_BASE			0x27200000
> 
>    #define RK3576_BPLL_MODE_CON0		(RK3576_BIGCORE_CRU_BASE + 0x280)
>    #define RK3576_LPLL_MODE_CON0		(RK3576_LITCORE_CRU_BASE + 0x280)
> 
> I see now that there are exact GRF base addresses in addition to relative
> CRU base addresses, maybe that adds to some confusion?
> 
> For the pending future refactoring series I have instead opted to define all
> exact CRU base addresses, and instead uses something like:
> 
>    #define RK3576_CRU_BASE			0x27200000
>    #define RK3576_BIGCORE_CRU_BASE		0x27238000
>    #define RK3576_LITCORE_CRU_BASE		0x27240000
> 
>    #define RK3576_BPLL_MODE_CON0		(RK3576_BIGCORE_CRU_BASE - RK3576_CRU_BASE + 0x0280)
>    #define RK3576_LPLL_MODE_CON0		(RK3576_LITCORE_CRU_BASE - RK3576_CRU_BASE + 0x0280)
> 
> To avoid mixing defines of exact and relative CRU base addresses.
> 
>> At the same time, I don't think it matters since we won't change the
>> LPLL and BPLL (LITTLE and big cores PLL I believe?) in U-Boot. It seems
>> that the kernel has it correct though and they have
>>
>> #define RK3576_BIGCORE_CRU_BASE         0x38000
>> #define RK3576_LITCORE_CRU_BASE         0x40000
> 
> This also seem to match what is currently used in cru_rk3576.h.
> 

Seems like I somehow missed this mail and checked locally before sending 
https://lore.kernel.org/u-boot/20261117-rk-clk-better-con-names-v1-0-25521d4e37c3@cherry.de/ 
and indeed I came to the same conclusion: I got confused by the GRF base 
addresses, the current macros/constants are sound. Thanks for checking 
on your side, it is reassuring we came to the same conclusion separately :)

As for the rework: I would like to have the same value in U-Boot driver 
vs the Linux kernel driver, otherwise it'll make porting fixes too 
error-prone I believe. It's fine to set it to addr - cru_base_addr 
instead of a hardcoded value but the meaning of the same constant should 
stay the same between the kernel and U-Boot.

Cheers,
Quentin
