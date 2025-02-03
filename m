Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ABACC02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 12:28:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 584F380077;
	Mon,  3 Feb 2025 13:28:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="hEAs6a0u";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="hEAs6a0u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E92380079; Mon,  3 Feb 2025 13:28:43 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::625])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8091A8004F
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 13:28:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Harrison.Mutai@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=bGJ00/d6jOWQ4CEaylPW0Co7DFpbh99g9a7OGdhS0/o6N8sUu6pmf3YpvSKmb/H+ClWeiasAIpvXJSHBJNytjgHNc2mSX6Bn3q81bpjiPPpVeDFkOea0Bt4kZn6OS4rerntoTryGjqrSdZonwtSdCZ8OB5VjsOUJGWUYu7VWI6m0/P3DiP8KwjqOHq1bzvk0l1p9GZN3Bi6GDlICM1QzqqoTDzQNT1ioql08yV4FJS4gOQ06c/yjg+aIIzxLS3n89IVovrV3ZSWRAv66rLQdtMPW+Nc+nvThfKgnb1ugH6y35HIcmxvlSoE5QSl4TehJsf/WN82vMkjuDEV3liXiYw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VH+GRJ/gCTU67iCT0i8VRarbtboeQyAHvdGso+m0V8=;
 b=eMhCnqa2KCFGpowLmxoddd9VJ9dRtVYeJysT1GCNMGE7xdvj4oI34ksSYgmZMpVpFhnJePJTP5UAWRxl05F6Chrl7yab5IDJ7CLuXrDZa3f8qGtZth+vHfmsbPBxLPUox7WqaeEvG/oYgvDC94altiQGluDBowqmey0epMTANKsI0VwsSQY+vIiLfSoDtWxfpckMZaanLD+7ZCohHtd/rN9T4dOza8Cx0HNiPyHQXpeTYoJ34jTFube34SS6S3Qs7IPUlMwBGfhCUhMtim4RFbFYmY3M0KdAg6AeO8CpoUBfH284hv3iMaYXiYpjhboiuMyP7icREfh8dX1I+HF2mw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VH+GRJ/gCTU67iCT0i8VRarbtboeQyAHvdGso+m0V8=;
 b=hEAs6a0uC6OuRQ2o0BLXHpXEmumaXpMgmXPyVQBZ3Am96ERmwH48Y/NMdxhCWQgS4xQhNjlhjvMuWvTQZugkELPwC3GzvmmhgJ7gr5xVkZGdbXIZU6CSdllF2KaGbNjXfOrrL6lrxDu68d385eLwNkHyCqbARGPhjbga8sY3cjM=
Received: from CWLP265CA0380.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5e::32)
 by PA4PR08MB6080.eurprd08.prod.outlook.com (2603:10a6:102:ec::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Mon, 3 Feb
 2025 12:28:38 +0000
Received: from AM2PEPF0001C713.eurprd05.prod.outlook.com
 (2603:10a6:401:5e:cafe::86) by CWLP265CA0380.outlook.office365.com
 (2603:10a6:401:5e::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Mon,
 3 Feb 2025 12:28:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM2PEPF0001C713.mail.protection.outlook.com (10.167.16.183) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.14
 via Frontend Transport; Mon, 3 Feb 2025 12:28:38 +0000
Received: ("Tessian outbound 4d4d74fe3cc9:v560");
 Mon, 03 Feb 2025 12:28:37 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: d6bf4c5faa2753ed
X-TessianGatewayMetadata: VXZimEkUPAlSt6zwAw6LvWI8Rqxfn0Z65NGPQ7OzEAyNbrhUv/kCKEyljdGwNjgYqLHJYlxlCJ8nBMniP+RCJX7gH8gWTr5xAaAeRxMYg4H1+3p0SezmfZM9F/3K1DXT7gIuRjJnPj5R0aKyEHAmkxAuGriSP+pULfo7tSSZ4os=
X-CR-MTA-TID: 64aa7808
Received: from Ld1629273f233.1
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 D8B855B5-0D94-448D-9B6A-6BB219D9B2F5.1; 
 Mon, 03 Feb 2025 12:28:30 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id
 Ld1629273f233.1 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Mon, 03 Feb 2025 12:28:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uplv8Kp2I3KImedQP5PgwxO7FRVc/tek9yzFq4JjqCtBTdJVaeiC0Uj8696jb4aKD+RIsIkdWgw3nCpKi3v3/Iy/140b0agelHn3oeCnZ/C/pWJQlRJyXt6pvejpYBefGYmahoOmvkyryAYya3hm8Cc4bIze6MVUJnmaGcF0w0wezlvWR4rC17XJexaN6SG/V+FX5uedJT4LSSE4MPRZSbfgsSohldofqYepSynALVySd5RTCRUfwsWfOnkf8Q90VJYwfY6HBkLoldGkvTXQIq1lTVw1jr/lY7arCXkel/WG6iHRGW/+xPtq0dU1gIMBeGa73uVAZJkKvSnU4pRTzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VH+GRJ/gCTU67iCT0i8VRarbtboeQyAHvdGso+m0V8=;
 b=OOCFORJzh3HtjtzQarpj1L9QKLfb92HJJz8wav6RaSQ2dbeKnmm9MsvU6/x5qzucEMyXdx9Q/4OsZBTRrwJFjLGIa5+ilDmsZufj0ekTO62Q2W9CojvULXB/wTxKsesa3LUEdT7UPnlnF9iQGqHMoTz8B5IJWHTFJVKj45E1i+P6Q8MdrOielcabvyMkJJJNMxg6LkuiZMDo8AABXKCMq0qs60xlMiaMvDKZPgnf406eDSiNfEhRKT45UmTtn1Y6TgVQvwINax9bOZm5esvjjy6QahRt4r9ZprQmYrjHNNCR9dLNR/zJU9QteFh5IXGnBJgCTZgS1/76TAITuPD/Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VH+GRJ/gCTU67iCT0i8VRarbtboeQyAHvdGso+m0V8=;
 b=hEAs6a0uC6OuRQ2o0BLXHpXEmumaXpMgmXPyVQBZ3Am96ERmwH48Y/NMdxhCWQgS4xQhNjlhjvMuWvTQZugkELPwC3GzvmmhgJ7gr5xVkZGdbXIZU6CSdllF2KaGbNjXfOrrL6lrxDu68d385eLwNkHyCqbARGPhjbga8sY3cjM=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DU4PR08MB11188.eurprd08.prod.outlook.com (2603:10a6:10:571::11)
 by AS8PR08MB6024.eurprd08.prod.outlook.com (2603:10a6:20b:23d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Mon, 3 Feb
 2025 12:28:26 +0000
Received: from DU4PR08MB11188.eurprd08.prod.outlook.com
 ([fe80::5926:9f0b:ea5d:24df]) by DU4PR08MB11188.eurprd08.prod.outlook.com
 ([fe80::5926:9f0b:ea5d:24df%7]) with mapi id 15.20.8398.025; Mon, 3 Feb 2025
 12:28:26 +0000
Message-ID: <e9fee281-70aa-4a8c-a8ae-b1ed76eeefa5@arm.com>
Date: Mon, 3 Feb 2025 12:28:25 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] bloblist: add support for CONFIG_BLOBLIST_PASSAGE
Content-Language: en-GB
To: Tom Rini <trini@konsulko.com>
Cc: nd@arm.com, andre.przywara@arm.com, manish.pandey2@arm.com,
 u-boot@lists.denx.de
References: <20250115135209.13946-1-harrison.mutai@arm.com>
 <20250115135209.13946-4-harrison.mutai@arm.com>
 <20250122172103.GA52306@bill-the-cat>
 <71c99ce9-673f-43e7-8bdd-86afb64c3707@arm.com>
 <20250123171239.GM60249@bill-the-cat>
 <e2cbe06e-c83b-4bbf-94dd-386fea7fb41f@arm.com>
 <20250131001021.GN1233568@bill-the-cat>
From: Harrison Mutai <harrison.mutai@arm.com>
In-Reply-To: <20250131001021.GN1233568@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0029.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::20) To DU4PR08MB11188.eurprd08.prod.outlook.com
 (2603:10a6:10:571::11)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DU4PR08MB11188:EE_|AS8PR08MB6024:EE_|AM2PEPF0001C713:EE_|PA4PR08MB6080:EE_
X-MS-Office365-Filtering-Correlation-Id: 743711d3-bdd9-492f-8c7e-08dd444e4917
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|13003099007; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?NGZRd1RLbjNIYWJQZlBERkpLZHluQUl4d3lobGw0clJzb1c1RDM0d21YcFJv?=
 =?utf-8?B?cTJpaWFoc1pRYXNWOEJoUGN6TXZRRDFad3Y4bFV2SVlheWdScXVnWi8wRkp6?=
 =?utf-8?B?ejAwbUpncGVtbXRENEpiWjNxMS9BckNYLzhFSm1hQXd1b0E5MnNJOXVSVVlT?=
 =?utf-8?B?ZUNXQmhCRlRQdHg3akNxMzlFVDJldkpIVWNucjEzS1VaUVF0d2kzeUJJT2tM?=
 =?utf-8?B?M2F5R25ZWWR4MlNjbzdmR0EzU3FGVkt6RkVKN1NlTUs0NXExVHBkaDRKVnh2?=
 =?utf-8?B?V0E4Rkk4K2d6ZWpRaFNQSmFJMlNMYlBKUE85RENXMGE2ZVZtMXQ2SEZKWS9o?=
 =?utf-8?B?eFpLQ3lnOTkwWmtNUEtHS0h4dW42UWNGcEMzQ2FKa2FuTDZsQnVMWmtjMjcz?=
 =?utf-8?B?dFB0OGYvOEJXQVQ4UnNIR2d3NVIrYTlkMWp1bkh4MWVBcWlxaEhqNUo2QklR?=
 =?utf-8?B?ZW4zTWtaNkFGVVF2RXV0Ky9KV2FaN1lRYU14MStpUWNzVFc2RTlPYXZubzJy?=
 =?utf-8?B?bHFGZkwvTHBBckhHdTNpbm1abUlrYWhsS0ZMYXNDQ01XQUJZYWViVGtMOU03?=
 =?utf-8?B?eWsrY2ZUOXNwUnN6RHBzVU56SVcxQlNxVW1pYUdJcFVmTlpma3FxS2wrK2wy?=
 =?utf-8?B?N3lpWEs5a3MzRDhQUW0xQVdiTEFmakIxTHlmRHp1RXNSZmFVS2JNOERENllK?=
 =?utf-8?B?T2RscU1ZUFQ3R1BKOXBhZG9YdllPeGZ1SHpESFdtbCswa1lwbXZObUNrTXF0?=
 =?utf-8?B?dGN6b3hUR3BnK2t2b0FBM05GRmFKMnFENlpranpsbEM2d0RtMmI3OGJtc3Rj?=
 =?utf-8?B?NEpBMnZNZHZ2OHRWazVmRmtKV09kTWQyUVZueVI5VEp3YmkvWnBsam1CYnEz?=
 =?utf-8?B?UmFxUzdydXlOZDQvOUFaaWVpSDZQdGJPdFZ6UyszWEh4MnBHSFhISGY2R0VT?=
 =?utf-8?B?d3BvL3lNOUNuOTJXR2lMODFoYVBNN0xsNVdmelEwbEE3UjFtaXVkYWg2UWs2?=
 =?utf-8?B?eVZsM0xvNmZBbXhCVFRnUHJIeDJ4RTJMNzdnZUFobFNRQ0F4dEhjTHd0WFUx?=
 =?utf-8?B?Qm0rdnRFL2dKalV0WEJyc0ZUZTVDclBnY3l5Q21BcnY0RFIvejV1aUlwUWVm?=
 =?utf-8?B?bHcrSGExdWFpODNJYitxSFZDVUYrVGlmQ0dFVWljZ096ZXh6ZXZ0Ny93d09O?=
 =?utf-8?B?OU1vMUhGWDlWVkhYZlp6dW9BbllHdlMvWmxHTjdVU3NocStYaHVTUnZsUjIz?=
 =?utf-8?B?MXhCNWlPdGdlUlpiYVpCanIvanZMUzJtaUhCTFBlRkxocUNzazdmbis0dTJX?=
 =?utf-8?B?YWZlRTlhTWZXZGFmZFNWK2xudnQwdVZvUVpBQzIrcGNNMmpWRWUwUjErTlNi?=
 =?utf-8?B?cTF1aTY5bEM3Rk0zaUVLdUtEZkdYT2dXOHpnNk5wSUQvQmhwekxGZ2hqU3U2?=
 =?utf-8?B?a0JQaWNOdjlKcXJiTUdSVWpZU0U0OGJLb2JXTjdNWS96SElKME1ONWphK2FT?=
 =?utf-8?B?S3NXUnNYeHZpOXVDblI1bTVqWU55TVhlYUJFVG8rbFJ3NUJwcXJGYWsrbDlF?=
 =?utf-8?B?elRwTWlibzBQanhrbmxiZ0Q3TVc2MHpUa3BSdTlMWURtY1FJNnBqY3pSdTU2?=
 =?utf-8?B?ekJSNkw5Y0grbmM4WVhwTndzK3ZpNlluNW0veUFRbVo1WVFZRGt1Z2plT3JV?=
 =?utf-8?B?bEY5WTJNZUxWYm1TTklMVkJkWkNTYnVMSHdiaFpuWDNDa2tFQjRDMkluZUNI?=
 =?utf-8?B?eUYxMC9RV2JKN1JUNFJxUmlDYmtBVTZvTmFUUkx1RmVvbGlTWUZQaHZKRGZC?=
 =?utf-8?B?TDVTWm0zNGFLdWZnTFU0UT09?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DU4PR08MB11188.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6024
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[2603:10a6:10:571::11];
 domain=DU4PR08MB11188.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM2PEPF0001C713.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: e393a473-bc17-4325-1eeb-08dd444e41f1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|35042699022|14060799003|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZHpFc0NsaGRkRnFRS21mTnM5TmF2aXA2WElKaWRIM3JLZFM5N0NXV2ZldzQv?=
 =?utf-8?B?bDBUenNDaVl6YkNyc1BpVWVwTjFHeDJPOW9NODFDQkxSV1pwNC9qcE4rYnQy?=
 =?utf-8?B?SzdJUVNjb2JnRkhVTEJmRUJyTjZsbHJZdFNyWkVKRGo2Q0pFYjk4bGl1dFJQ?=
 =?utf-8?B?SDY4RndUem9XdXpHZDdleXNOSzFNK044eVBiSzRQbGhXcW4wRE1ZaFZ0WVJy?=
 =?utf-8?B?OXNhaXN4a0FSL2JSZVp5L2xBUDhLc01lWEVOTU14S3ZFdkpyZW1jOTU0ZDkv?=
 =?utf-8?B?cFU5eFZtMzI4WEc2a3hVMTZUU2srRWtwR3JUcFNvTHZhUmpQcnZsM0pVWFl4?=
 =?utf-8?B?bWJ1b1MzT29jTnNWL0ZZeXVMZnZpOTRwMUgvWXkxSjF0RTBjZjhqTk1vWHk4?=
 =?utf-8?B?enVaZldvd1EvU1hWLzlnbUlCNFdpM28vWlNJdXpsVzBYaGV2bVZrYjk3c2I4?=
 =?utf-8?B?M09Vd1RyZitBNjFiaGhwZWM4V1pYSHArb1o0eGw1aXNsaVNKdEhoZDc5dC9T?=
 =?utf-8?B?djkvaWExT0xENVVlVmpHSFRzb3BEaW5ZU3dJN0NJcStGTDhOa3hlRzVPeUR6?=
 =?utf-8?B?dzk4YnhZYTBMK3BVR2NLcUc2NkdmcWF3akkwZDl2KzF1UWdtRVNTenNPV3Zx?=
 =?utf-8?B?ZjBHRmdvelJrT3hUNk4vcWNUeGVJc0g2NFAzQjd3clc3QTgwUjlOMFZKRXY2?=
 =?utf-8?B?NGpoYTVtbTB3ZEdOdlZMTTl5cEVlVXh1WmtWL1dMRWFtWFFoc3RuSDJ0bG0v?=
 =?utf-8?B?USs3a3p3U0RVa1ozK1dYN1ZsNlNyb0tueWgvQXZobFRqS1A1bVVBMGlRYTM0?=
 =?utf-8?B?aW92aDhqcTJJWEZZRVowZnkxNWQ4S1BHM3JLamlrd1hSc1dQVzhHSUM3ZVM4?=
 =?utf-8?B?RGVhZE1jdURmbFZ3TXhVdXdFRGR5MjNQcTBZN01RcmhiUDBMS0VoMklyTmVs?=
 =?utf-8?B?eVE2OGZqYmNpMDkvQURRMUxxZHdvUEZVYitOTXZBZXNjV1hnME9tbUxmUHVI?=
 =?utf-8?B?SVNvYXZ0SUwrRDVicmFjTU8yOFlDRlQ4Z25ITkdIWmswNThsZG9MWW4wakVI?=
 =?utf-8?B?RXA5V0RhWkF6MGVRQnlWVks3dnlXWjdMbFdOUXp3L2s2MFYvNWphWUpRM3dL?=
 =?utf-8?B?MmhVU2dzZTM5cTRqMzZIQitjQ1hnYVIvenk5Ymo4emxqZXZoRkRwRk1VdkVy?=
 =?utf-8?B?eWw3Ym0yY2dBdGpCUWI0RWZJZUlSbFI3MElQVlVzNUYrYmJkemVvY2IvR2RJ?=
 =?utf-8?B?TVpuV0RuQ21ZR3c5b0RmcnFtMXQvdGdmSEVVb3JHOGE5M3g3U0lGa2FvVmQr?=
 =?utf-8?B?UnJpUUl1N3ppbzNhaXVMcDR2OTNMekUvQVJWYXJRQ3BsRnA3bm53VXhuRzBa?=
 =?utf-8?B?VkptVWlvVENmN2pkSHZXQitrSGpDejI3NnR3TGljTmRwYTk1SlBURndHeGUr?=
 =?utf-8?B?cFlUVms0WWFyS282ZFE2eUNUZld2V09IeVh1dFkyYU5JS1duTmEvNFNBUzd5?=
 =?utf-8?B?aVBtNllTcWhxVkRmb0xnMkhWaFIxSU5QSXNuQlVIR2VGd1BUVFNYZmlWOUJN?=
 =?utf-8?B?MW5NNW5SSUFZZ1RoNWZiSS9xbHU1M2dtcVpkMFIwdVZzY2RkQXV4V2FCY2lE?=
 =?utf-8?B?ZWEvVEZmb0ZJRmVJU2tkRHFGM3lEZTN6VkpmUkFocWhOcDF0QVBBOGhWZElY?=
 =?utf-8?B?SGpUNUM0NjJUUENHZWlSbGtvN2c3c2VOOWR1REhnUis1WEFaMHJVZjNEZlcy?=
 =?utf-8?B?NTN4bjI5QndYa05PQ0lpTHhadElEU3FwZEV6dXd2Nk1jYzJwQ3ZCV0o2Z05G?=
 =?utf-8?B?MENNKzllL0wyc0IyTlhmUUxjaUNHL2pjZ3A5cXhnNG0zMmVlbkVWQ1NFWGFx?=
 =?utf-8?B?RGg3RTB0c3R0Y1ZST0hTNGFYTXNFYVBMWmVDWXY0S1lneklmVjF6MEZjNTV2?=
 =?utf-8?Q?B8UwisBIEtSSs3To2KkiNJyvqOvsY89n?=
X-Forefront-Antispam-Report: CIP:63.35.35.123; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-1.mta.getcheckrecipient.com;
 PTR:64aa7808-outbound-1.mta.getcheckrecipient.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(35042699022)(14060799003)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 12:28:38.0271 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 743711d3-bdd9-492f-8c7e-08dd444e4917
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C713.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6080
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

On 31/01/2025 00:10, Tom Rini wrote:
> On Mon, Jan 27, 2025 at 12:42:30PM +0000, Harrison Mutai wrote:
>> Hi Tom,
>>
>> Thanks for the additional details, that helped!
>>
>> On 23/01/2025 17:12, Tom Rini wrote:
>>> On Thu, Jan 23, 2025 at 05:03:40PM +0000, Harrison Mutai wrote:
>>>> On 22/01/2025 17:21, Tom Rini wrote:
>>>>> On Wed, Jan 15, 2025 at 01:52:06PM +0000, Harrison Mutai wrote:
>>>>>
>>>>>> When the configuration option CONFIG_BLOBLIST_PASSAGE is selected, the
>>>>>> bloblist present in the incoming standard passage is utilised in-place.
>>>>>> There is no need to specify the size of the bloblist as the system
>>>>>> automatically detects it using the header information.
>>>>>>
>>>>>> Signed-off-by: Harrison Mutai <harrison.mutai@arm.com>
>>>>>> ---
>>>>>>     common/Kconfig    | 8 +++++++-
>>>>>>     common/bloblist.c | 5 ++++-
>>>>>>     2 files changed, 11 insertions(+), 2 deletions(-)
>>>>>
>>>>> This leads to failure to boot on qemu-arm-sbsa as seen in CI:
>>>>> https://dev.azure.com/u-boot/u-boot/_build/results?buildId=10392&view=logs&j=ac5e904b-a30c-5e1d-9570-462b8181c990&t=863544fb-ed04-5d34-fdac-10f5bbb057bd&l=423
>>>>>
>>>> Sorry, I'm unfamilliar with U-Boot's CI but I can't make out what the source
>>>> of the failure is. All I see in the logs is what looks like an intermittent
>>>> error.
>>>>
>>>> https://dev.azure.com/u-boot/u-boot/_build/results?buildId=10392&view=logs&j=ac5e904b-a30c-5e1d-9570-462b8181c990&t=863544fb-ed04-5d34-fdac-10f5bbb057bd&l=423
>>>>
>>>> Would you be able to share the results XML?
>>>
>>> The problem is that qemu doesn't start anymore, sorry for being unclear.
>>> Looking at
>>> https://source.denx.de/u-boot/u-boot-test-hooks/-/blob/master/bin/travis-ci/conf.qemu-arm-sbsa_na?ref_type=heads
>>> we can see how qemu is invoked.
>>>
>>
>> I've successfully reproduced and resolved the error. The issue occurred
>> because I relaxed the condition for calling the architecture-specific hook
>> xferlist_from_boot_arg. Previously, this hook was only called if the
>> bloblist was at a fixed address and U-Boot was in the first phase. However,
>> since we also need the hook for BLOBLIST_PASSAGE, I've added a condition to
>> prevent calling the hook if BLOBLIST_ALLOC is enabled, assuming we don't
>> expect to receive a bloblist from the previous stage in this mode.
>>
>> However, I'm slightly unsure if this assumption is correct. Generally, when
>> BLOBLIST_ALLOC is enabled, is it expected that U-Boot will allocate memory
>> for the bloblist, ignoring the bloblist from previous stages? In the case of
>> BLOBLIST_FIXED, we relocate any bloblist received from the prior stage to
>> the fixed address. I'm surprised we don't do the same with BLOBLIST_ALLOC.
> 
> The problem is that today at least yes, BLOBLIST_ALLOC is only viable
> for full U-Boot as we don't have a mechanism to pass our own from one
> stage to the next unless it's fixed.
> 

To summarize, BLOBLIST_ALLOC is meant to serve as a fallback buffer for 
internal use when a prior-stage bootloader hasn't provided a bloblist at 
a fixed address (BLOBLIST_FIXED) or a pointer to a bloblist 
(BLOBLIST_PASSAGE). From the perspective of a prior-stage bootloader, 
these are the only relevant options. BLOBLIST_ALLOC is also entirely 
irrelevant when U-Boot is staged. Have a I missed anything?
