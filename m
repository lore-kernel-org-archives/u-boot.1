Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18272C0218C
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 12:42:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D1D7807E4;
	Mon, 27 Jan 2025 13:42:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="RjC8Uy5X";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="RjC8Uy5X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F183D80F98; Mon, 27 Jan 2025 13:42:48 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::614])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2844A8076E
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 13:42:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Harrison.Mutai@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=e4ZAFkj3B4p/BzITBO6HuzfJI7t4TgsJM5NgM9ethtysoRdolzebXawOak2muGb8sgPEWNKxQatk3+Y8F20jBjsgPu+/VtteeyFAay6pirgNtSO+S/EbUzvqDuPtsSjN40OoWR1c+noSXgEr2Zl1K5DMTlnxJlZ2bYMED9UnZMWq3Ft1ULIorhUE/KkqRbsIuhnqKht72vOzGuBqdzdhzTFwef6I8sQEdXM0pal6taEILlHF8NH65p+pD8Y2HIHlPO8v52lZtN2o/0LCOHanTTQt7lEICxNyM86bNl6OrvuOdXFhRPo1C9I/47tKwpZ6xGFCvXflaIH8DGBCkSYYvw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOucgL5skJ7Y1D9dui0zZaJKFKG6hLzcLovodfXqqCU=;
 b=QFeUzFRY6StS3JMzEAB/WYUkdoBO1XmUIrnelYetvhcGNyvyYomp9S/R2WXrsWiRH+e5BG/OBO92zFdA6e0xq8uv0nCP4wzqtieMuY5sRz1Qkp/wze4vNm9WYirC9YAtSKNYakClBhm0F3oEZMKs8rb07jhNu36kYU9QSiMdlfUdm/JsQzP73C7b/gFuIscderElNcnCNKgv+CFKUwmSVgQTQQ7gL2slKZTMGwTKEKPUjdrbgNh21KZYkwWY0iD0E9ylDKOz90sKT64c1R5e7gmLUabE7h0+J6a28fgXjza7BL0ds3rP5OPko4pRi67DyCs0YWaDhN/zltoLPKWTWg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOucgL5skJ7Y1D9dui0zZaJKFKG6hLzcLovodfXqqCU=;
 b=RjC8Uy5XsHRvU2dUYCErewZ1yirbfiIoPOsWFqfguS5xD3PiDcQB89sNXFpTqOX1PZxv0KqbV1biskV1h66ANyq3W2gPx0/txrIB2IJOLeuQ54gTcqsp3fqDiI2CQTcJycmAtVagjUP9aFOzL7UxgUtD0RhxUZtmoup5QaxaCFk=
Received: from AS9PR06CA0523.eurprd06.prod.outlook.com (2603:10a6:20b:49d::24)
 by PAXPR08MB6685.eurprd08.prod.outlook.com (2603:10a6:102:133::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 12:42:44 +0000
Received: from AM4PEPF00027A60.eurprd04.prod.outlook.com
 (2603:10a6:20b:49d:cafe::79) by AS9PR06CA0523.outlook.office365.com
 (2603:10a6:20b:49d::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.22 via Frontend Transport; Mon,
 27 Jan 2025 12:42:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM4PEPF00027A60.mail.protection.outlook.com (10.167.16.68) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.14
 via Frontend Transport; Mon, 27 Jan 2025 12:42:42 +0000
Received: ("Tessian outbound f63d5f8a6777:v554");
 Mon, 27 Jan 2025 12:42:42 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: e5c33361ea00e31b
X-TessianGatewayMetadata: qrT7+h2NNKAX7S5nKcfw/NBYwoG61DfYMsv6B25IXloMa/NnopVDTx/7BHHBXhzbQyS8u/ieVa1xebwwGYI/OXJw86vl2BSgiF7qsMUEJ7vMmo4fiTxWm0cXfJR6Voz3dFjVlUh71SzMsu8VBidfisyWe+r4/mc0/bQEeXVIT+c=
X-CR-MTA-TID: 64aa7808
Received: from L4135bb1634c7.1
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 8B8CBA43-840F-4C40-9A71-8CCF3C59767F.1; 
 Mon, 27 Jan 2025 12:42:36 +0000
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id
 L4135bb1634c7.1 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Mon, 27 Jan 2025 12:42:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W7ZGu6LNB8Wv9ArXE4ykR0FYQDO7hGQ4ztIThKtSXmdWeBrlcDoY4oFI3AGz+05/4dI4Wz61iIxhiIjW2kQx1p3IOwET3qZaEMCcxQndacQSJARj5n7jF6s+sM3lkvxyFdmejP2DueSgknw6n2+LEsybM4bi6ik1W11VChX1H2JAMSqO+wzHD/11UUCHh1aen4864TJFZ1KJohy5YekOOkMEtWp1tQ45nUFZIQlEl0W9zIcZ/+HX0gSrqeA01PnXk6X1nBeZwtI7ZoGtAnRWeQ1uk6ItiR5Aop5AtMNim5LWDGGRv1a3B1WxXenaagEeGdMEpRHbN39fBPYzTcG36A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOucgL5skJ7Y1D9dui0zZaJKFKG6hLzcLovodfXqqCU=;
 b=R0x06d85jtQ/0pN5CiTk1XN1XYMj7tjKQOUZivvO8WJGto2LjothZTs5nS9HBEfnHB2yvQ8Ea+nCE03dFoRnKDDB/JvGoOM7oslzXSRfXLXOnvo+/NC0xWJc8UwHSXjr6BkRq2dMZwiZCPgDZGD4HHlsrauDrrd0Nb8MD01GXXVqwfjhY9yGbJKS97mLsnH+ujosRmUovqGJgFtFHgezvlmhKXOJ7ni2FYvSGW1iaIanUGe78ilQeUAX+sH7YdmIAw7QAP3caVFSjTow9uZjo1Ay3BeGDskG3uoC/DrN55jVSboYqQR3OLlPt8akUWjYxwuaJpKpbjSKXQ96ZOBGMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOucgL5skJ7Y1D9dui0zZaJKFKG6hLzcLovodfXqqCU=;
 b=RjC8Uy5XsHRvU2dUYCErewZ1yirbfiIoPOsWFqfguS5xD3PiDcQB89sNXFpTqOX1PZxv0KqbV1biskV1h66ANyq3W2gPx0/txrIB2IJOLeuQ54gTcqsp3fqDiI2CQTcJycmAtVagjUP9aFOzL7UxgUtD0RhxUZtmoup5QaxaCFk=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DU4PR08MB11188.eurprd08.prod.outlook.com (2603:10a6:10:571::11)
 by GV2PR08MB8512.eurprd08.prod.outlook.com (2603:10a6:150:c2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.21; Mon, 27 Jan
 2025 12:42:31 +0000
Received: from DU4PR08MB11188.eurprd08.prod.outlook.com
 ([fe80::5926:9f0b:ea5d:24df]) by DU4PR08MB11188.eurprd08.prod.outlook.com
 ([fe80::5926:9f0b:ea5d:24df%6]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 12:42:31 +0000
Message-ID: <e2cbe06e-c83b-4bbf-94dd-386fea7fb41f@arm.com>
Date: Mon, 27 Jan 2025 12:42:30 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] bloblist: add support for CONFIG_BLOBLIST_PASSAGE
To: Tom Rini <trini@konsulko.com>
Cc: nd@arm.com, andre.przywara@arm.com, manish.pandey2@arm.com,
 u-boot@lists.denx.de
References: <20250115135209.13946-1-harrison.mutai@arm.com>
 <20250115135209.13946-4-harrison.mutai@arm.com>
 <20250122172103.GA52306@bill-the-cat>
 <71c99ce9-673f-43e7-8bdd-86afb64c3707@arm.com>
 <20250123171239.GM60249@bill-the-cat>
Content-Language: en-GB
From: Harrison Mutai <harrison.mutai@arm.com>
In-Reply-To: <20250123171239.GM60249@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0046.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::15) To DU4PR08MB11188.eurprd08.prod.outlook.com
 (2603:10a6:10:571::11)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DU4PR08MB11188:EE_|GV2PR08MB8512:EE_|AM4PEPF00027A60:EE_|PAXPR08MB6685:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c0f2530-4d97-41cf-7cb5-08dd3ed017bd
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|366016|13003099007; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?eHlEZnJWMy84QWo5Zk82a2ZmQ1REVUt6VU9UdEVrS0JubldFVjdzWGJtV0lv?=
 =?utf-8?B?RlpTSndOMnM3aEZXcFRpdnlhOFkrKzlyUmJIMjJtVmZCQlZCbVY3eG8xNGla?=
 =?utf-8?B?c1ZXcWlkTXpmVlVaMDd4ZU5pQXlyaVlLWER6bFJGY3FzNWFNUWJ3M2RrS1FN?=
 =?utf-8?B?YnJxMzc3VFNLNW9XNVJTWTU4b01sMWxQTzBNWTR3NEdYZHFKUEhkT2QrL3Jt?=
 =?utf-8?B?ZXZjbnp6QUwxMWhDeVFuaHpUVFJSamQ5ek0yNkpPNHMydWlyRHg3b3VsdTNO?=
 =?utf-8?B?Z3pNTU9KcEszQ3RuSktydUVleGg0NW5FN29IeHdXblFrdlVJMkc0MXhuaDFQ?=
 =?utf-8?B?NEIwbkI5ZkFtRDh6SFpmM2cxSStwd0pNTlJyK09TekFJc1RSOW5rRmVBOWts?=
 =?utf-8?B?bGpyeExsU2VkdGhWSXE3eTYva1JzRkxpZHRUWFdUYnBTS1VzRXBrQkZ1N1I0?=
 =?utf-8?B?TUpXYTdzb29hbE1jdll1a0pKanIzYmlwSmg0ZGpJaTRGVndCQnZkOFBXWVBC?=
 =?utf-8?B?dG5pQlNaS0sraHp5VlVFMlpnL2FqbzlSRC9qKzd4UWZpamh5ZUhTL0gyMmtl?=
 =?utf-8?B?VXV5dU14OVZmM2JKaW52RE9xS1ZYNnMwUFI5WU9lSHg4WlREYnhER01wdmtY?=
 =?utf-8?B?Z3c1a2VJKzBCY2FZZC9aYVUvdFFjaWRTUUdHbkJpckFMZFgyL2FpOFZzQSs4?=
 =?utf-8?B?L2s4R29kbnlQQk9mMUcyVTlINk9idmx4RzNoWEdCL01veXNtRWpTK1V1Z0Jv?=
 =?utf-8?B?cFdFQzdhL2YyR3FqS1J1V1ZaS2R4UFZUVlZXN3Jlc3pBeFRkRkROakt1cWJ4?=
 =?utf-8?B?Y3pMN0dLQVhDb0Z1VTRpZjhIbUg1cmJYbzhwTktFcmhXM0d2bXBSUjRZc2VE?=
 =?utf-8?B?Tm9wMmMrbk5wbU52NUF2dWhsSk9iUkJLMmNCUDR4ZW1xclp1SkpNc1hKTHlS?=
 =?utf-8?B?UGllMWVvYnMzaWhxSm0xZCtOdzdhVkRIRjJyZVpNUE5OL2d3V05pSHFaTS9y?=
 =?utf-8?B?LzZyTEgzVjNyZ2w0VmtMYUtyUDY0dk8yWVM4OG45NkdYMTBHdEMxTVprTVBu?=
 =?utf-8?B?NzRySmYwNTJOUEFMNE9hR1NxcktrbUJTbWxMT1V3VUIxM2N0aWxpRzhQQ2gz?=
 =?utf-8?B?RFFXdzBvd3JXcHhUaFVFZXF4VWZXM0hIY3ZHbnlmakxoRUlxcHJSaTdueHh4?=
 =?utf-8?B?WmplZW1yVFdoYTIycmp4SXRieUd5Kyt4Sys1b2RFdTNWM3pzeG9GWkJFd2hh?=
 =?utf-8?B?YTZsZEh5RjVpQXNMR1Z1eDdhSmFiWVloa3NCc1B1bzVQSkwzWStHNGJTb1dz?=
 =?utf-8?B?cmdhVmNLR0p6YTdLRWNzMFcxTWJUZTBqbEd0MmZXaXRWdzNmaWFhVVRDSGpu?=
 =?utf-8?B?djgvUFdpMElEL2NZWTdkWU1wblRKMnBBY0pHUmRyalQ3Vko4bm80empPL0xj?=
 =?utf-8?B?RVFscE81WTQwWUdURE13bERWTUhZTmozRnNTUzU4SUVFNW5CWDNtQWU5YXpJ?=
 =?utf-8?B?cnRFcFprSEUvb3hXRUZ4NlVtWG9xRG5tdUtMWlppV0VPMWF0SFAyVTBlK0FJ?=
 =?utf-8?B?VUFBTk1YaFI2Mk5BeDNES0hOVzB6VnlDcElJS2M5WUUwVndxMGhMZmxPelcv?=
 =?utf-8?B?aHkrMUgzU0ZhZWNRWE5BMytWdERqc3cwMnltRktQMHdIUk0wc2FPRWhQalVR?=
 =?utf-8?B?R0h4UXJqcXBIWW1COWFIdVRFajhHODZJajFvM29qNTU2NXdTUEM1Skl0MDFT?=
 =?utf-8?B?Rkljck9zMGxiUWV3ZjFCcStFMEdrNDdmNUdnTlJXcXhQM1dzdHFwaHdvdjdU?=
 =?utf-8?B?Z2dDNitNNU12Q2RlMEZaUT09?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DU4PR08MB11188.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8512
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[2603:10a6:10:571::11];
 domain=DU4PR08MB11188.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM4PEPF00027A60.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 30dddeff-556e-42bd-7bb4-08dd3ed010f5
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024|35042699022|14060799003|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WUgrcWRhOUNvbytxMCtuYUMyV0Nma3dUMk5hWG1NYkpORE5neHoycnR6N3Fy?=
 =?utf-8?B?NGt2Qks2S0lubUVETXpMREFFL2w3OFEvcExPQUk1NWFmcHdFL3NUTlArZ0U3?=
 =?utf-8?B?Y3ZMby9rL1BNRVN5ZjRFNFFkRjVrR3dXNjhpK2NrQ1hVS2JkWExHUG9EYU1R?=
 =?utf-8?B?UlZ2OUVXRW13T2dBZ2pTTUJZdFNXZnJ4a0RHcjZDWTZvbFdMRGxmLy9kWG5C?=
 =?utf-8?B?VlFUTGNiaWlUSHNrdzBPWCtkRnN5eDhxNXpQbSs4NG53WTFhdExPYTJ2Q0Zy?=
 =?utf-8?B?Q3NRK1NoaHFOU2RlWkRPK2J2Wlcwdm9oR3VXa01uTG9NUGx5a0NyazhHU0tK?=
 =?utf-8?B?YTdzUjZXN3BZZFR6Y2tLTXo5dklhelNoMzI2emZncXZuM1E1KzFUZnpHSE16?=
 =?utf-8?B?RnhrNFJxSnZ6clE5eEpnVGFveWlxK0hBUng5UjROMXZka3JwSkMzOXVzRURW?=
 =?utf-8?B?dFhHcVBWUi9MWEtvTHcrZWJ3YTNWOXhwdmpRZnFWWGt1alQzdlR0cGM4R3Na?=
 =?utf-8?B?Tk51KzJWTzYrSmd1ek5vWUxDK1Z0T2FEY2NGcTBhS1NsN3hrSDVkeEI3Sk5j?=
 =?utf-8?B?UW5IUXcvdzE3OSt5VVNvUXR1a2wyaUpmQWNUaWlmS3FjZUhPY1JodUFhTFpR?=
 =?utf-8?B?T0llNlJDSmQ0Y0c2SXZSbDFGdzY5em5yL1ZyNlVwZGRUN21GYkJsM0orcEE5?=
 =?utf-8?B?R1pIRXJILzdlM09IbjNyQ2tuVkdzSThxSWFOMFp6a2huTHpXdkFGTXo3SXRT?=
 =?utf-8?B?SVlUSFdEUnJMcm5Fb2FmZ0tNWUxzc3h6Y1Y5d0xLN09OajFtOFlWUkxrUStZ?=
 =?utf-8?B?NDRKVGRhUWUySnVkMUM0L2xXU2ZFb0dBUURKcTdaT0o0elBVbHdhbWtpU2Fs?=
 =?utf-8?B?OHdhWGdRR1Fzbm1DemlObEM0RXVYWHBUQyt5bm9sSkJvUThITTZ3N0k0QjdI?=
 =?utf-8?B?dmNXTjNjbTFxNnJjR2FvQTJZUG1Fb1lsR3FBVkFRZHI2YzFacG9jY2hpaG9q?=
 =?utf-8?B?QXA4eCtKRklNeFhLcTZxMVJabEppdEZNQTgvTm5kTENPTmc5QmdzOGRYaDNO?=
 =?utf-8?B?Tnp2Qmg0aWhwVHVZbERzQmJNOXM1VFBaMkZHZ3loMlR1L0k1dVBncUowbXR2?=
 =?utf-8?B?SVpHTmdiRFU4RUx1YlhsN2tibTNDdGwxcm1UUUFicER2NnpDK2J4amlkamR5?=
 =?utf-8?B?ejhjaGg5dVdPN0pRMWlQWE5MdXE3aUtxd09RU2g4MUhPeDU5RVdXWlBsejNH?=
 =?utf-8?B?ZkY5T1NhMnByUUtiSmp4RlVwLzl5SE5NZDAzTEhtZkhnc0RMcHBNRHpJUEtL?=
 =?utf-8?B?eHlEck15YkE2WHFtNlNNazRGaFN1SWxMcGNCRklvWHVINm02YStZYkpjNUln?=
 =?utf-8?B?cXB5TDBsdnFjZzFRRlFPUUxnVG5jVDNjYzNUL0hMSjNFdzRGNXNKR2s4anNk?=
 =?utf-8?B?bDViTGJxU0pJejZ4UnpGa2VFZWYvREQvSnROUkJiRVVmdTJHSzgxTGVaYlJr?=
 =?utf-8?B?Qlc4WkEydUoyTGJPQlRhdXNodXNobEg4VXU4ekRmTm9WNk9TYlM1NFdranZE?=
 =?utf-8?B?QkVmVjdIeFFqaUFKOUJHdjNTWjFiSTBtVkZFTDNSbVBrbThCR2F0VG9UMjJ6?=
 =?utf-8?B?V2pNRzVQMUlBdmY5bG1xbVFIUGdJSDE2N0NOS0RDMnZGU1kzUXA4MVZpYW9r?=
 =?utf-8?B?OFNFZGRsQmgrNVA2T2htYWxxdW82SnR0c3JLRVA0cG4rVFFqQWM2MWM4d25n?=
 =?utf-8?B?Zi9QUllnUWJsR29kY3RpMVVkU2RYdWVzRG5uZkJRWDhLN1Z1UEUrdm9vdG40?=
 =?utf-8?B?ZWxFMDc1OVZBZ0RjWksvcUhackdIVzVnY3V3UWZmT29UaDJlWThReU5GZW8r?=
 =?utf-8?B?MTJIY1RpckZTRWVZeVZ1MFBvaUtPV3NXOWRmZ2hDSktqTTlJWnptSWMyL2hv?=
 =?utf-8?Q?Vymt6iS2r83chBFw6zmD8SXeFmxMmpQV?=
X-Forefront-Antispam-Report: CIP:63.35.35.123; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-1.mta.getcheckrecipient.com;
 PTR:64aa7808-outbound-1.mta.getcheckrecipient.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(35042699022)(14060799003)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 12:42:42.8423 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c0f2530-4d97-41cf-7cb5-08dd3ed017bd
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A60.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6685
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

Hi Tom,

Thanks for the additional details, that helped!

On 23/01/2025 17:12, Tom Rini wrote:
> On Thu, Jan 23, 2025 at 05:03:40PM +0000, Harrison Mutai wrote:
>> On 22/01/2025 17:21, Tom Rini wrote:
>>> On Wed, Jan 15, 2025 at 01:52:06PM +0000, Harrison Mutai wrote:
>>>
>>>> When the configuration option CONFIG_BLOBLIST_PASSAGE is selected, the
>>>> bloblist present in the incoming standard passage is utilised in-place.
>>>> There is no need to specify the size of the bloblist as the system
>>>> automatically detects it using the header information.
>>>>
>>>> Signed-off-by: Harrison Mutai <harrison.mutai@arm.com>
>>>> ---
>>>>    common/Kconfig    | 8 +++++++-
>>>>    common/bloblist.c | 5 ++++-
>>>>    2 files changed, 11 insertions(+), 2 deletions(-)
>>>
>>> This leads to failure to boot on qemu-arm-sbsa as seen in CI:
>>> https://dev.azure.com/u-boot/u-boot/_build/results?buildId=10392&view=logs&j=ac5e904b-a30c-5e1d-9570-462b8181c990&t=863544fb-ed04-5d34-fdac-10f5bbb057bd&l=423
>>>
>> Sorry, I'm unfamilliar with U-Boot's CI but I can't make out what the source
>> of the failure is. All I see in the logs is what looks like an intermittent
>> error.
>>
>> https://dev.azure.com/u-boot/u-boot/_build/results?buildId=10392&view=logs&j=ac5e904b-a30c-5e1d-9570-462b8181c990&t=863544fb-ed04-5d34-fdac-10f5bbb057bd&l=423
>>
>> Would you be able to share the results XML?
> 
> The problem is that qemu doesn't start anymore, sorry for being unclear.
> Looking at
> https://source.denx.de/u-boot/u-boot-test-hooks/-/blob/master/bin/travis-ci/conf.qemu-arm-sbsa_na?ref_type=heads
> we can see how qemu is invoked.
> 

I've successfully reproduced and resolved the error. The issue occurred 
because I relaxed the condition for calling the architecture-specific 
hook xferlist_from_boot_arg. Previously, this hook was only called if 
the bloblist was at a fixed address and U-Boot was in the first phase. 
However, since we also need the hook for BLOBLIST_PASSAGE, I've added a 
condition to prevent calling the hook if BLOBLIST_ALLOC is enabled, 
assuming we don't expect to receive a bloblist from the previous stage 
in this mode.

However, I'm slightly unsure if this assumption is correct. Generally, 
when BLOBLIST_ALLOC is enabled, is it expected that U-Boot will allocate 
memory for the bloblist, ignoring the bloblist from previous stages? In 
the case of BLOBLIST_FIXED, we relocate any bloblist received from the 
prior stage to the fixed address. I'm surprised we don't do the same 
with BLOBLIST_ALLOC.

Best regards,
Harrison

