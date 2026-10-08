Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76157CA6015
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 22:01:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1CF7E81414;
	Thu,  8 Oct 2026 22:01:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JPXcXDOlBbic; Thu,  8 Oct 2026 22:01:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 652BF813CB
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791496889;
	b=rejL0eZo3S3ydOFWWjiLg4lC4LkB5jNwT9hFasmVGTg7shwIWWojNb1fei1iEOJ6kUai
	 sLWSI8jcwYdkIAMW+e5MM7o0RI5Re4m55qRhgNxqId6hOapFzqVcXPSsgc4smM/vcIj7S
	 mpNcfKFCRzD1i2rjTKI+h8UFCE2NxXgmXqPhDGW9phEdn7ukSmxTsRXswrVdmt5dGQccy
	 gnw9ztmTXINPn0TgmiFUbQIlTg4KBRM54bgrK4E133P/TLD4p6s21LX2c7ozzE/fqtzcg
	 4oFxLULqYSfqRiAC1UzjDtOumoPvlHnVT/do1EYOGdEKduX5rCv7bLPUuXTNy4xH2fQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791496889;
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
	bh=1NzSfxaTcUiD92k14kM5O2Tr8M2iGdJBpMpYn5rPLIY=;
	b=KTS5ykVaWjpEzndJZnmQ3eZ+Cb3ysdPn1sIR4dwWcfxn31i5KV2f/GLai0Y6hXS0hetv
	 3kTDLVEPl48D25M9jR3XnmetGr9MbYNpAEbxqNDikOrFiiiTbyjq1N9OBkujpIx/o6W36
	 XB64vVPDZ5XVQSimNfbHyTqd+cwZCZd2CmwwKqYW8JK4tOTX0dXzejXiiYnqwa7jYBGSd
	 OOgMnsaK19D5uj5AMWLBwL2xfzgjojiT3qY2WNrJZbeKcBc1MCvPik0uT0TZpTDEZ8brZ
	 VQmHr4XAxhPEEPymM7UgRSNEh7LTPOhrfj9vEX9sQi+wH4MJX/megNfiCo4Uj3P/xew==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791496889;
	bh=1NzSfxaTcUiD92k14kM5O2Tr8M2iGdJBpMpYn5rPLIY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hqQyInknn+Vrk1UvkQPa4DfUi8+DygNNfomheTqwr99kHVG1Zr5H9naoOw1ASKTYB
	 IHPkHHEqwBWCAJAgE49REhcHUF52sDuCB0MsW+BevWZphOBKWB7RGyzPqJLIau/5Zg
	 RdJjZvI94D8X0LMmz2PNI3oKhMudUndXruwPbzTHo7uEvuwfbGDQtLuXsQMbKbhs2F
	 owsoygfCNVZJ01oNMO0aiKGbw51mpI74BxLN2uL0z39Iy7aXTCVVKk9187JhsPahQB
	 2oEPPlRZRRtsd3u99aybV0GQNvDk5McLDMie7+9Ec5P3A22THyBNAHgYZFTynHrDPy
	 tIY+zWTn8ZDIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 652BF813CB;
	Thu,  8 Oct 2026 22:01:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A6753228
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:01:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A450B400CB
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:01:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vawX1fnOslAE for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 22:01:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 77F8140064
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::6"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791496887;
 b=q0OsyUICyCzE2sutC6QOwnE9fnYcMkBs1M9lusnP2CLy6vF0X8aLdIXMmjtyKNz8GICp
 DHF0rk8/bmspSWdUXqAmyexq3briTYNKSPn3UIdlOxlzcslWgMfscVT/1G8jzm12x2fEP
 l126DgHmb7gtbKcnhbHlEGx0pNUGwUXaYadBMGbbXKifkUHWsAHduPGLOKkTMhac8nCR5
 A2gpMGrSSjpCCPmbiT/DQVNLAGsLeFmMvHzSNb+VuE1HHo1FqLqeXW0cguidY2c64f7W7
 kRUjOAAjYEq0H99iw4AzQUekX1xWe902/6j20/ZEKwTHE76jz/UPsNp+GJZz/XxSLRg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791496887;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=1NzSfxaTcUiD92k14kM5O2Tr8M2iGdJBpMpYn5rPLIY=;
 b=PRcvfiOnl0mxMURETGo/oochjIWhtv6jTdYy1180kF6OcGzApF2PMy55onnbE/e/mkOO
 OPiraDK8gGR/LAKQjSXFEFyv9v1Ic2wTUJgwCyou2DFfpNcwB4uju/JZIaOh4aCNskMzx
 ReT+RDQXNwrGOwi19o8k2qkvvGYPcV4vc5AYbnjavdztvPAJTVuVFSJAdXul/Ku5GZp9n
 PoAKcMvbQzx6VUCo2gtGR0B+OavjM8rHzmsyC3BkQEOl9tBn5I7g+wBk+8rxg+A5lN0yH
 Pc0gWRbiVW6UyNfgZRSUiu/8bsQcXbjUN2Sp6ZClhg/IrC6x7+NaYMgYFoFVFRhH+Qg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=cherry.de;
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=cij+fYlF; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=cij+fYlF
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 77F8140064
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:01:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qH+ERvK+d2hkCRvJQxvY/87X7yag3j5DkTsYZxQr65e2yzCfwTCMt8DgsWKRdyH7IzIWk+fAQHmUuamLLc7PCfhs/wq1ZmjUs1CYPWYrpDwwTOGALJAs+HVFpFMIoL00Ys17vYKdqQV3sLC5V9w4zyaXUjUt5+6iRnGD8J6eXvDiGaKRfS2deDXavYi8yCQNduDIjUirX+j1KKd2gR4VNKbJsvEmJAO8rWQWO/Tt3r0+r/JLfDChF+QyMclY93FNXRwjLmiJww2J13juwlDQKoGB7EXUXd7+WiiPhMEDEYj47hjDoQE7d5ckEsjHuCcMumR6wtj6ACG+8G4F2QQ2Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1NzSfxaTcUiD92k14kM5O2Tr8M2iGdJBpMpYn5rPLIY=;
 b=qlN9CjAgtZulGaCPqxCH27gOp9cryghhuF7QNLs1bgw+Qu0W8AhlTovHB8f+qt3wfrPrF6eqZnd40D/PFExbQug10opHln5aq/WiiUIqWXGy/2IjXH0VRro1gb4qUA9zIb+ykE3fa83f4Rcv2gp+vu6WEkFxXTa8TPusBWOCNiuH6nCeTUg8iGAtBTmA9a0CHXMDsm11uH1ZTLSLbXaRlOjgao+6+n3NlCTMYarc4doljcVu9a+YB68UiAW4ZQ0hFkQ3DHOKFk5nfgKVUyTBhjvMfGImZF9vDhC+V3qzbhCYbpEMQl1vg61ey2NTDqTbzLkJ7RwrhY2fKI/K8qOBGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NzSfxaTcUiD92k14kM5O2Tr8M2iGdJBpMpYn5rPLIY=;
 b=cij+fYlFh0E9lLfFj0AhQ244cWdn/9Y4ZB81zAlmwrTSoQoLAwvxP0pZROBHyMy1wXRn1l4/R5tD5dlq+wlM/bRofrYv/qOlmnzvymZ32jC/cbAti0a/ZIBcnnFWVcJ4+zVvnXiolz02jB2xDWN793stLIRYhkE6i0vqQS5V0lA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AS8PR04MB8069.eurprd04.prod.outlook.com (2603:10a6:20b:3f5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 8 Oct
 2026 22:01:16 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 22:01:16 +0000
Message-ID: <eb920938-a70b-4546-a491-ff949913c3de@cherry.de>
Date: Fri, 9 Oct 2026 00:01:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] rockchip: rk3576: Remove unneeded syscon driver
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org
References: <20260804105721.2402406-1-jonas@kwiboo.se>
 <20260804105721.2402406-7-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260804105721.2402406-7-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIXP296CA0007.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a9::17) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AS8PR04MB8069:EE_
X-MS-Office365-Filtering-Correlation-Id: 658be265-f3b4-47a2-bcd9-08df2587acf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|11063799006|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 5PrL2/wJfBl3QMmxCyLZ03Ty+kgAaRGSNMQOop52pUYWf6Ly1E+fKiXAEbavO1F94E9c0kftlhgFA8d3YmY1lTd5xUJwXb+xZN4SlcgDJ00x0ke9DXsB+z36eNtJYYS88Q7aUVkPJV/s6A+cDMrCNTWXDIO/Y9EsjWc/JJOCNT/+er5agjJYAUDTnltWO8u5bHvwe3j8qA+KGam+Nb3H24xjwq9y1SfkjWlfAWM8fffbu84AIxq3RnAUTZtrz7wdr2tw/GXUueJCTRSowF7HQX8tBJnddU8A390lb2OQBrTnL68ghDurPKxOcgq3K+LGRRBRXPNZNfidRLT3bfU/OyEX/NpkGtLo47F0kQ71OrKi9lr9mdxbBKpT5bypkrrqGjZ+z43gR17RGqaXPRL8mACye0GNn3c70fZx5N3iDcpVhH/Of6pWeu4Eh1QJDLnQvHoejjNKYtK3jwxumgzbyNehnL9EkuKCZQBEaPcb/9g7ES0iV9nE293oygeauXVcmxV+cCG66MgwLk6komeQc/g8HLiVb2iryQZryjxwXGC9r3OPKOfpp5LfgksL6NJmvbMg5ErZwp1RtT5cLAMk6ogsPyQqwm0VK2d6crcH1ln2a23f6K5W9lkLO9lBO1DPunM5tjBx1yuPyajhwx70s5d3e/DDrDlh+mTiroibktc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlZocVJOM2ZEVzBGSWNQMnI3MEoveFR2dkNwRHpvYjRkWDNXNXVqbEFDNEhO?=
 =?utf-8?B?S3FXaTlqOS9QMGhYVEhWSndHNmc2TnRzS3lERnVvMTkxSFExaDM3WU5UY0NI?=
 =?utf-8?B?Z2w3OWlzMlIzSVYzN01yaENBdFBBWERVQzVScTZ4cW9FSmpvcllZSmhoR1dr?=
 =?utf-8?B?UDFNSFFuajZBZEtIYXB5ZjRMQTJoYkcvazRnemFZUXVJQVlsZ2E5VnJVbGsv?=
 =?utf-8?B?RHZldnBZUmpKdWdvMGVqcmtZaTRlenZRdk9zRDdxWk9JZkF3aS95ejVUenk5?=
 =?utf-8?B?bVZsM2VudndoZHlGd2puRTJnanAvcWx6SHJobkFNWHo5UnhWR3VNbjRzM1FE?=
 =?utf-8?B?QzJIMHlVeXkvMDBhZno0Yk9vQzZXdjljVzN2WGpZUFVMYThrZWNRVXdrSTg4?=
 =?utf-8?B?MEZ5a1VwRUZjRHlZOE15L2cvMEN5TTM5WjB6SmNsTU5PakY3cW5VZlhjV21F?=
 =?utf-8?B?VGliZ2JXRWluTit1UXRWbWV6SkdCOFhadmROK3owYjArd0xXSEx3RHFnNDBq?=
 =?utf-8?B?NkRzUVhscUZwUVZIcCtwdWJkakFwMTkrSjBOSDNCWVNJSEJaWjNMdklMdmFO?=
 =?utf-8?B?S1JDeVlhdGJqMnhVRjNodFpaR3dtVjQ1SGo2ZTQxUWpIcWFHc3FuVmhUU04w?=
 =?utf-8?B?VlYwUVBBRHplc05tR3l4aUlUUHJzZG1VL0JrUGVmZTlYT0p5eXFuMXhFeFFE?=
 =?utf-8?B?N1V2NWhvSmlVZk5lck1rc29uZ09FUjRKbnZzSVBWSnVpTVV0c1hnNjNzT1VP?=
 =?utf-8?B?bmR0Qm9FWTBtVmlRUmg1dWJ4a01tdEJvRGpmWmxtZnhmMk9oRnBwOUR3Z2o0?=
 =?utf-8?B?OXVCc0I3MnRidkVENjF4b3hXVnFtZFltZDl5dm1yNGo0NDVtOVFmS0xzRC9E?=
 =?utf-8?B?cXZKOVQva1QyTUFLWHU5RGZsQmg1blNHSkpXazFFd0lIQ1k4aFJRTEdhY1dM?=
 =?utf-8?B?L1RsMm95V3dWd0VzUjBlZGpvYldmcmdyTVMyeWtSL0JnMVdVeTd2N25CSEl3?=
 =?utf-8?B?NVRRQXI1YloxYloveFo2aXRwenhRd2Z0MG9pQkpHZnZtR3FVRWhlRStaczZB?=
 =?utf-8?B?WWc0eFpSODRxT1BxS2ZUWGVkRFNjdDNyS2I2L1FMYmxuZmNlTEJ0TTkyYXpk?=
 =?utf-8?B?ZzJkS2V1eHA4Y0pteWtTbWhQWnFYc05jVHo0Z3BITVRRd00rc0RTSFp2MHl4?=
 =?utf-8?B?WStBWTBOczY4azJ3S2tXN1ptdUZnZ2crZ3N0cnRUMzlSbUZnZ2tBeVZSclo0?=
 =?utf-8?B?TGZlTzFDS25DK3RhNm9WSk9RRUliNDJHd2RQYitSSnpiOTQySmpiN2piK0Jy?=
 =?utf-8?B?SFd5ellCa2Zab3pnNkcrKzBveVR5VUkyYzlHL0kzZks1ek1GdUpIOENvTGJa?=
 =?utf-8?B?QjlvYmtqZzFBaWlFNmkvTVRrQ3plQW5QMWNWeHdlUzlMT3RlSXhKNDVZcWxQ?=
 =?utf-8?B?ZDdibkRzSkY5WmdNWnpON28rR09RNkRNOTdBUU5rQzQrdE1yZUpOUGRZUFRP?=
 =?utf-8?B?ME1DTVRLMFhURTBKTDh4Y2NiZGFmTGlOV2RxYTdwVGxiM1RHWE5yb2U3MXBB?=
 =?utf-8?B?ci92RGU4dURZM001YWdsRGFEcGJTYXZISzhrcEhtU3ZHN3pqTmNKR0ZXVVpG?=
 =?utf-8?B?TGJic2h1Ti9la3ZUdStWMFZEb2p2dmgvakEveW5zdDBLNTd0WmxnenorZnJH?=
 =?utf-8?B?N0FScFhxb1U4UWJnTGRCV1N4SjFlOXhxNVRCdEFrU0FhejZTdmRad1ROczlE?=
 =?utf-8?B?WEtXOE9UNzQ2S2huYVVtd1FxK2ZXcFN0Z3Nkc1NKdXZud0ttZVhjSW44VU9J?=
 =?utf-8?B?OHAvWVZ3cnhvYUlXNGxTU2oyeTVvWm1iOFA0NGQxZS9pWDE4ZlVmenJhYUR3?=
 =?utf-8?B?dDZpSmkraTNnUTBWSkxxWU96ZE1ZRU9nczZMSktIZUk3d1VPVDVKVFBaaDJM?=
 =?utf-8?B?YVVtUnhSYS9iS0ErSDlYellpQVRldFRNY3dkcE5JWUNnVGdpVmd5bGpIUFA3?=
 =?utf-8?B?c3ZyajUxd1p4ZU5LdEljbUdBT0syVXpoTWZxWTZFanVTakJYWGhDSDhOektk?=
 =?utf-8?B?MHJ1OHBLVHZEVm12cm5vd3BSdnlZYWlLS1gxUWZ0NEVJWWZNZXBkNWRiY3VG?=
 =?utf-8?B?ODNJc0RRdTcrN0oyYzNaYnZLcHdmcmR4MFJJWUYrVC8rUUhWUmtDQ3BIWnZW?=
 =?utf-8?B?WTlTTTVNNzRUQ0x6OTZRMmFzQUpjcjA2TUhFN3ZBbnFTRTFFakgwZ3JPc203?=
 =?utf-8?B?Q0FHVmdCTkpIYVhraFZzTEFKOUdJaThHK1F3YWNobTZBMUxseVJXeGlweG10?=
 =?utf-8?B?QnlqQnk5eUx5a3NhSXpGUWV2VzVBYWJ6WktFR2xsUUxEZ2hNYWJlUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 658be265-f3b4-47a2-bcd9-08df2587acf4
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 22:01:16.4473 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J5Hjo11WyEiOPbdaHAIQGENLIrvRWXlTIGbvVdzZLSOK3zyx3IDgVGq2cMhwy+Hr7MLQqf80DUrEJ4m0IQ0l17kcyT76m2YORl7wXtR3Jwo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8069
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Jonas,

On 8/4/26 12:57 PM, Jonas Karlman wrote:
> Modern Rockchip device drivers use syscon_regmap_lookup_by_phandle()
> to get a regmap or use a constant to get the fixed base address.
> 
> Remove the unneeded RK3576 syscon driver to discourage new uses of
> syscon_get_regmap_by_driver_data() or syscon_get_first_range().
> 
> The generic_syscon driver will instead be used for the compatible
> previously matched by the now removed driver.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
