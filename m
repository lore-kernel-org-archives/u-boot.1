Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC96606A330
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 18:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=D6klUq/5;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=TtryGuqy
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B68FF40E0E;
	Fri, 13 Nov 2026 18:04:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3pNfcfim6Avs; Fri, 13 Nov 2026 18:04:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1F37840E17
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794593083;
	b=Jl4vEqtpfe+WMswrYo01Kv8xNVo5iyohKTpMp4T0V1XPZ5lM0Oz2JRV4O4cEPAnkorcK
	 KvBGkqN1CRgSimIScjNF2dW/cqWV2sBYgeQA/qZ9sQqYQG3G18Y0U4BSQ78p6hQZSSLut
	 +iSs76Y2OtEinC7S4JbARTHnYKZV0gqiTt5vHU8R8YH8FqpoVKb64mPM45EFPUekJgVgh
	 DRIHk2diIBt/Ezb91KD3yMixHPko7m36/tfM14ao/zIIdabyAvwesiFOlZ9p7PzM01YGC
	 8au8Az0s+mwNPmrpF7WVvEq5llX4/DajNxD0IdS/IAHWLvs/9WCu6k34/i196DugwWw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794593083;
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
	bh=M4hIkb68Kgmdp6XNmX/W/KU6ykjIqua5DVWwI7zxZCU=;
	b=GQa0XH8AeH8urL/zFj5i6eJiBs8BJQQexL+WrJbw9aEuR0yeN8GkUlyqbz+j51HROVDq
	 ff+tLKuOUWlIP/wF/ON8soVj/5zFVXqtS5gJguWgtrKosUwSpatdAeyXZWXjy4g5l3arn
	 ySaCxWbPd9kOccTQCODW7qVbcGXEAd+eYtAowy1MLt6x0IdxrCooQ2jgQz59wWS6mqr82
	 B5ZpuEV/MGYYvtrwhwN3eLrD3lv6RGU/CTO+t135P+KqEeYl5xapSNCVQLxMGge4YZShw
	 gHQo0meA0TU/AGNoSTHvgFDtpBV9jQ+d8qvzZ5WxQOUXn92YvoVEzyGqkWwUEv8/qCQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794593083;
	bh=M4hIkb68Kgmdp6XNmX/W/KU6ykjIqua5DVWwI7zxZCU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D6klUq/5wZ5uDzGVrjUMfU6mPtV+inrlLLkjdGiOJQ8C+G9nrM/0+CDNHYo7BItzh
	 INhKQ7Y4F3AzuwwHxK4dd7vq2EaynHhWcxaLGaAJ6w/c2wcErDeZl4cEkdNNKPLsnm
	 inQVpjxTBl3FGS/zzC5CNKSx3e6ZuRl8Kc3Go8wdDBdOkQmCkCvEXGQfJvGOT3NO5T
	 Otp1Sp4FMoYyK5/Pcwq+FHa4LO+fv6l1eB4CV5M4xD7wHQ6WT51JNPXg+JteX24X8Q
	 lV3RsaKImCwPivcQCegARk2sU0upsHbORWVThjmqwrrG2lR+fkuDZg55khU68LMTlw
	 9hR9KUrP48kzw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1F37840E17;
	Fri, 13 Nov 2026 18:04:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 56EF7F46
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 18:04:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 486E14018D
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 18:04:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4V2cmUEnRrcH for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 18:04:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 83AA84005E
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=TtryGuqy
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 83AA84005E
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 18:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4hIkb68Kgmdp6XNmX/W/KU6ykjIqua5DVWwI7zxZCU=;
 b=TtryGuqyQx9oxzXbO2OgZZpNF2nYjQq24ykRoU14GnRQHeXr/r+fTXXqwUwMbiAbqoIBs1KmEf0kmOEjGrv3CS4Kb5bTmFhkysHkQqrDnwDBtN7F2A3oNN9ENjAqCYLPmECj7vVUdQ3Sop4A+OxrVrRcnuq6PaKCXFkX8cYMt1Y=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by PA6PR04MB11780.eurprd04.prod.outlook.com (2603:10a6:102:522::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 13 Nov
 2026 18:04:37 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 18:04:37 +0000
Message-ID: <2ac5eef0-72b8-4f8c-99ee-4b9c606d814a@cherry.de>
Date: Fri, 13 Nov 2026 19:04:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 30/37] clk: rockchip: rk3576: Align BPLL entry in PLL
 table
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-31-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261011222930.1085075-31-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI4PEPF00000158.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::874) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|PA6PR04MB11780:EE_
X-MS-Office365-Filtering-Correlation-Id: 510476a7-54c0-4ca4-e73b-08df41b093df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 0viGn9jGsJHeP1+QEHLMcrxjRmeDweZEEVYbSyMEL1/kBKRKXVgoiaDbrE2K+q+nlx/uJtCIGhzsV3s1fA0LeF98kQPAVkDWKdTGl2Rps2UE7bnowOuJ71v8ylZ2QGnSZ8EinkuKv6NkhvZTrsv0pQBvyRb1a/pHpFZ/qhJQxCrv9qdQuGCcu0bntu5OpHMNCAB5phsEHH60hXm4f+IiFIXYwYQCLhtGqGOPgt1U7ExY7y3HXWIlazQid1mOxofAhFd5grXGhYOzZOLEt1MOjw2Fhovwjdu6dSvZ1h1tGNof2pCTMpQTOGca4xXOg7I0CnB38o7U8jVeKYtG+ohb9/TSVCujy6t4V0Cp9yZs1pdsOf87wSaQRk8X87zDdf7csPM9kw83QzJA+wLkgbeIUojFeJx6BV88r2mCg76YzGE01rpPh9xLaOzXvBEnMRiDybYOcQX7nAxKDOTMLmuaRUGkmqs0dbJSFxDZohD2mB6r+vgurv7YdVmfkQyxhLKfrJs3wYd8VD7M3ZIJ3hddjCeyf/IVDWhm6/W12XdPuJspF+ALa7X4gG8Zw4rvTvLru6PhU/f7XW2Ll9jGGat1y7nUbpxk4IVwcBB3+YDcuo1xtvB7a2OgnuXRCu4rdznbsLnLrZ6EsO0FuCVQsTVLEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjQySm1JT0I4NmF3ejJ6TnZwNUZsMENlSzF4bDdsTGpRMUxBTFF5ODdDanU0?=
 =?utf-8?B?MG5EelFEbHpLdlRvWWFGOFVmc2xSZC8vNjBJUGFwTjQrV25XdkpCWUNSbXV1?=
 =?utf-8?B?cS9vemcrSzkxbnNUWjcrNnF4Vk5Xa01acEpySTRHcjlLSE1FY0IzUE5Paits?=
 =?utf-8?B?ak0vMVFvaGVXNHRWMXIvYUNZcUFzdXphWjhmblcwbi9YSkVpUk9meC9iaU9q?=
 =?utf-8?B?OEhsME5DMFlvdVc3QkNOdGlvMjVLaHdJQlFWenRIN3g0aVR3dmRtbGdrSTNL?=
 =?utf-8?B?dlM5SDlEUnFRNzJqRFZsRHZNMDhpMHJ3MmI2SkpJdnRaMnRMcXUxT25EVFY1?=
 =?utf-8?B?L3R4TWVrUEp0Z2RQOFJDdGZQL0NRMFBJeVNnMzc3RHZkcVltcTRHY0RqOTV5?=
 =?utf-8?B?RDJ5OGNxcStJSTU4WFNZRDU1Q0RmT3BMZDIxNmQzbkVaTmhvQkNybXVobm1i?=
 =?utf-8?B?aC9UMDNpTkJlS0ZZYnJiaW1VZ1FFUjRkN29CZWxFN1ZhNmdtbmJjNDB0ODFH?=
 =?utf-8?B?Z0d6NXZIVldiSWpzK1pLZmVzSEVMbHF3NTZuUjVFc2REYkxxNVdPZ2x3MXdX?=
 =?utf-8?B?cHdXNUJTMzg5VjQ5ZTQvNUpiYkhmL2huSWNYYmltYjdSbEpEUG9vblBFbzVN?=
 =?utf-8?B?YmpBUDZPTEtlYm5KOGxFR1luMjExMGluZlRpVm42dy9qVWVaUXZGNXFzM3dq?=
 =?utf-8?B?My8rdFZnUGMwWGZzUWw2MGxkbVh1Q1pJUnBGSEowM0JOYkQzLytwdTVxMXZU?=
 =?utf-8?B?Nmhnak91VGNVUUhNaGJLMHRlcTJ1K1FJQ0ZHMk9xNlcwK1RCMkhvdDlCeUhs?=
 =?utf-8?B?a044UXBQRDBEZXRTWVFuM2IvRW1vYzFSdWhyZW5LektrclpGNithbXBmMWN6?=
 =?utf-8?B?cCtpcnN6Q1BpM1FJejVQcTNsQ2VjaHZ3RXZ1MGJWTEtkb0ZnVnIyQ1dmTFRr?=
 =?utf-8?B?VlhSOGJxMkMzcUZpSk5rdW9ZbXYvZHJGZlBiT0JYd3R6bWNhSlBZNmhiQUJS?=
 =?utf-8?B?K21uamtWSU1rQ0dlRWRUeVQwLytlNDlidmIybFNzb2JIYm9rd3ZUZzluTVpF?=
 =?utf-8?B?NDY2RkF5dDZFU2MrcHVsTi85YXROYmgzcjBVQXlMRmJTZkVqSFJiem45MWRl?=
 =?utf-8?B?UEZtVWRCK1A1VUZ4aEdZYXdCV0NDdjhyRWlpT0d3bnJ5aGNLNGt0RldpSzdh?=
 =?utf-8?B?c2ZzRFlPQkRpckNnTEliTWdPay9ORlkxdmFMQ3o3RFFmSjZEVytXY3lOYW0v?=
 =?utf-8?B?R0Y2bzhUUHAwUkNTcW1xejU3NEhNYlMxamNNSXpxQVNMMXE0YnRnYkNqbFFn?=
 =?utf-8?B?MmJsMm1GdHBCOC9LSGhEY1g2WDJzTFlwM040NHM5NVh0OFJlTjNqejgyazR4?=
 =?utf-8?B?ZkVuNFJSRmJ4YU5kYXNEdmVQZmFITGo2alg2bk5yayszaEduMExGZ2lOeFpX?=
 =?utf-8?B?Zlo3dTh6MGRPS0p4dUY4Q295c3VBdnhUNkJkQmRUZC91elNES28zbnZkdSta?=
 =?utf-8?B?Z25xa055dXRrc29vM3pvZDI2WktuOTV3a2xORW5wU3Q5NmhyMWtiN1pTVU1H?=
 =?utf-8?B?TmIrSmlETjhBTW85NU9hYXN5d3Y5ek5LcWhCZzZhdjBmUFIxeXlMdXVrVkFY?=
 =?utf-8?B?L1VGZTY2eFM4bGNLRHdpRVVaR1pRQnpNbkRxYjA1Y3p6Z3dLR2dtRGdSdFpD?=
 =?utf-8?B?RHhJWjBLcnlUWmhlSmhuSUF6Q0NSN284OGpmWE1DMkMrZG9NZHRob2lFdGNi?=
 =?utf-8?B?dmlIbDNrTU95ZlBWSmhEU3dXc0hCaW51ZUdqUXZweFNoNjNRcTAzZi9VZHQy?=
 =?utf-8?B?dktub2oxeC85WHZJd25OMkViQ2FpRnBDdlVaanE2RXFsNWhienBQWUlscHl3?=
 =?utf-8?B?REs3cXJBNmh3TVhZYWF2K2R5Z3FOdWU2dVpQdkdLeEErR2JNVkpHVzJmZmdB?=
 =?utf-8?B?THVqZlVvdHZUamJEZFFCRjc0ajBSQzBzNmE2d21HbVUzS1BNbWIvc2RQbkVl?=
 =?utf-8?B?TSthRW5BYmg4KzlwVWpYVjR4NUVybE1JZ3BUci9oaDlqVmpnQmtDODh5ckc4?=
 =?utf-8?B?dm1aR241RVJRRFVEQVJ4K1Q3cHBMK1IydlBLUVJDV2VHeDRqUjlpV0VLcGNq?=
 =?utf-8?B?MmFHL1NLanoweCtUeG5JQ3F5b0hwdEFJZHZOa3U2R2RXYkJOb3p1dnVuZVRy?=
 =?utf-8?B?UlJ3cldTM1dnWlBTTHR6RWFmeDdkVXBIcEtaK1VDWTFERU93eFo5VmE1enE3?=
 =?utf-8?B?MVE0RzBLSXJiYjl0SkVzNVo0YWIxNGtPT1pra3JYK0lXTTVzbXk1cDE4c1Rh?=
 =?utf-8?B?dXIvQ2djdDlrQ2lzR0E0ZzNXelRwYzlpS3NaZ0xVV05SOHlPb3FEdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 510476a7-54c0-4ca4-e73b-08df41b093df
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 18:04:36.8977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FTyBKkMbRrOAhjg1KKAsYt4dgAFgIXrOWjMNd/CfD+2P27ne2lrqEmskFcyJHql91Yasi48s45bmqKyCcmPncZ63EbHkT1ohPHU+v9t+fjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11780
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jonas,

On 10/12/26 12:29 AM, Jonas Karlman wrote:
> Keep the BPLL entry formatted in a similar way matching the other PLL
> entries for consistency.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
