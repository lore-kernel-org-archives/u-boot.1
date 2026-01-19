Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6480BCCF2CF
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 09:30:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BA69839DE;
	Mon, 19 Jan 2026 10:30:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="jzDIbxBS";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jzDIbxBS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FE49839E2; Mon, 19 Jan 2026 10:30:13 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1521839D5
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 10:30:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=QhI/KzMS086SaOZC/hkEJeV6EZICNki0Lzs01roNxvXu9SukDpxrBTSfGHeAKSTNUDBOmkspYXVrxPLDoHCKi8iS10libkGWOjH8V084fJ5GQFFigsruQAwbj53ciUrMMZDAp1li3EgOzHR5JojKS3ebx65JV8LgrAssxvNEpP/FRhLmx3SJS0jPeUcfU8QBnRLAYABh7BqOMlwCSoyksJLwkAedJbAOWKjqmTvr+4zHAScyVpCeOw7Y2IkEC5tqoHvRBigobXik7v3ZGBNrWN4DBUlEIhys7t6ZTEAx2hR0o9/eNtbg+em7s3Mo9kpOP/zDYtqVxwZqECqPimvdGw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Hm/hoG/gzzmi0PR+zrOSSawTai8dsADpMAyAqKt4eg=;
 b=bQ1LssQP+/NYJXFGmpdus7McV45qbbKHomYkv0GHXhWU0FW+Vv+OvNzftIXTv66YyEDZj/2pYxWwq/Y+ck9xlJHP15sMLnFrAIgLof3UiUEcsdrWB2ZvqiRrO+66eh46wL+ujdcTohlieANbyJwyoIdsARx6XByQzHyveAMdovllSiakpqnj6tHSLUpanvrdEZwgLVMFKI2+05TLRcJaib2hEstZ9H/sF9zsgM8Om9CJneofU1zlpEuLEn53VETfseD6SIAkD+Dd7UT0TKMcs5QjbDImic1VyKwHZVgGRN/ekCkyfIlv1ripCFhrGv1jZtaIMVhD/oSQyNt6/M4ynQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=forissier.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Hm/hoG/gzzmi0PR+zrOSSawTai8dsADpMAyAqKt4eg=;
 b=jzDIbxBS522f88hzi3GuLtc3mB0Ky9iUG1tosxEXl7Gmp/Bqo9PTJz6koGdqVCSTKpZzHjoVdQ1I3GLh2vP5uyRTEWO42aaoYqQhs26Px3NuZcOLeiNoBMgGgwn+cy/c0gdbJyCdrmuZaqx2PNXzC41lgogvB1dQARIIHEv06To=
Received: from CWLP123CA0260.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1d5::10)
 by GV2PR08MB11539.eurprd08.prod.outlook.com (2603:10a6:150:2b1::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Mon, 19 Jan
 2026 09:29:55 +0000
Received: from AMS0EPF00000193.eurprd05.prod.outlook.com
 (2603:10a6:400:1d5:cafe::70) by CWLP123CA0260.outlook.office365.com
 (2603:10a6:400:1d5::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 09:29:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF00000193.mail.protection.outlook.com (10.167.16.212) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Mon, 19 Jan 2026 09:29:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NwjCJ7f3YHEBBUwcC51DlnlAe24xkuuRhJJGcLGt4DhfVqSKUy6kvaSidHyXoMj8Pexd2KXUEXncRwfqeGWCH0Ww3GQjRsmoSkMgeCybK9y7Pevirx/sXBE7XsRJhn5888MhjKmSSKcfHbJQusZUhv/nZ/593XIrOVEbjMlaLyYF19erQr+HpmLIkyLX+PDGQwpMYqj403bqgk4WoLqcJkCKEpluAzo1m7lFg8JAx+vd7wYAtK5gAylsuY8xpTsSOgbEl9V5BURr/3Tlh6gs/OzeTlzZFFAHzFwZpv037dbcAFTFY1YWwhf43YLBsCEkH6Zm2B83JzlIZh2bvLatYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Hm/hoG/gzzmi0PR+zrOSSawTai8dsADpMAyAqKt4eg=;
 b=H/Yq6T8efP/Jy/ODRqdpI1HHlTwbV35Mtw9lTVnp6pC6M+aQBO6dtIb9U1YnoJe7GA1HLFvOjHRLFn6XzuN/nIAljxNDCt2eh+F2fAEPCUVTExDY0BNR25XexuaiS+n8T68ESKvFV6nwY4D0RQW2InxafJ5N2yoOU06520FBJ/20mF/odRPW3mdVd8RoOtjfPt6M6kl5LgVWgOnQg6zhj/Fi9gC6H6TYy8rUN09YZ2y2s2Xan7IMGW4A7ANISw+TLMeXLZ9bd82VCfKbbb7jZW8CpHQhoQgOBLxcD0L+tcU7Sjxw+XgZOouCitIWXBe2TFgZpY/jz0wcjyG7CNM7lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Hm/hoG/gzzmi0PR+zrOSSawTai8dsADpMAyAqKt4eg=;
 b=jzDIbxBS522f88hzi3GuLtc3mB0Ky9iUG1tosxEXl7Gmp/Bqo9PTJz6koGdqVCSTKpZzHjoVdQ1I3GLh2vP5uyRTEWO42aaoYqQhs26Px3NuZcOLeiNoBMgGgwn+cy/c0gdbJyCdrmuZaqx2PNXzC41lgogvB1dQARIIHEv06To=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by DB9PR08MB7673.eurprd08.prod.outlook.com
 (2603:10a6:10:37c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 09:28:28 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%5]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 09:28:28 +0000
Message-ID: <92c8ad45-a5d2-4972-84e0-bb6e48fa4a35@arm.com>
Date: Mon, 19 Jan 2026 10:28:27 +0100
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH 3/6] net: lwip: dns: Call env_set() from dns loop instead
 of found callback
To: Jonas Karlman <jonas@kwiboo.se>, Jerome Forissier <jerome@forissier.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, nd@arm.com
References: <20260117002452.1026310-1-jonas@kwiboo.se>
 <20260117002452.1026310-4-jonas@kwiboo.se>
Content-Language: en-US
In-Reply-To: <20260117002452.1026310-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0188.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::13) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|DB9PR08MB7673:EE_|AMS0EPF00000193:EE_|GV2PR08MB11539:EE_
X-MS-Office365-Filtering-Correlation-Id: e8227430-c5bb-40b8-82e6-08de573d4dc6
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?a05aeHB4Q1k3Q3JBYng0VU9RVUxxbExTRllkaUxPRkg1VnpWTDBoaXVUMGVI?=
 =?utf-8?B?ZCtiMmEzZnN1V0VJT0RwUHg5bDJRdllNdkxjVFZvVUdvZ05lY3ZVdTZ5V2dN?=
 =?utf-8?B?NGVSMHlWODRBdEpodWNLSDZZeDdvOFc2NEd1S0NHK0djbEl6a3lUUzdlbzZB?=
 =?utf-8?B?ZGYxK2Z5ZGlqMUgzVmhPMVZpcUtyOVNqSUUrTGd4ZURzNmkwZERHUCtvN0Nk?=
 =?utf-8?B?N0gzT3pCVnZ0d3hOcy9EN2hleW41N3FNUWZlR29vVkQ5Y3g2VnRGQUlSeDlu?=
 =?utf-8?B?cHg2a2JVM1NCWGlnM0x0OWYxK3UyVGJWT3dmU1ZEb0w0L3Jiem91TnBTRG1k?=
 =?utf-8?B?R3l6VmlGS2kxREhLVGZ1NGdTQ1U5K2NocGt6cHVGUUl5MUFrQmMwUitpaUQr?=
 =?utf-8?B?SGtPZjgyRkI3UFZrMzVQMHN0N3dXcTRtMXZOcU56M3VOTmZOejBXclFIaWJq?=
 =?utf-8?B?R3BuU1U3TTBkL2QyMTNZTmtXanlmNzYxdjVUbWtRL2p4MTluSk5qK0lVN0xI?=
 =?utf-8?B?djdjTDVYSHNwUlpEZ2xjT2xGRVdWZkIzWDBWMkJHbWVGNVBQM21QQXFmY000?=
 =?utf-8?B?VFBIdUZiUkl4K2x6eEZ5ODBQbldJT0JITTRBQ25pYWhLa0ZjYUhMN3ZmZDFX?=
 =?utf-8?B?cXhqbVZoa0tsSHdDbVJHdDE0enk4VDhuM09TRDRxcEpCbFl4ak9ROWdQTG93?=
 =?utf-8?B?dnVhQU00MFA2c1Y3WlR2TGtHd1JUdEkzdTVEbmVtRU0rbHA3Ty9qY280OE0x?=
 =?utf-8?B?by9HNW16RmZmSmpJRjRlZEdLRUtpSlR6bG1pM3daVks4eTdrMUhqZHQ0MWlS?=
 =?utf-8?B?enFaT29kTVVjTUlIczhMV20zWHZOV1FPWWd5S3R3YW5WaHBqZUg0di9MYU4w?=
 =?utf-8?B?WUdjTkNnRUF2Y2FDNEZMV2hCSDJqdnAyR3ZOWFlwb3FEbk5Ic1NRUnYxbndO?=
 =?utf-8?B?aEN1Vjg3UUw4UVZSS3NxYmNZcC90UGRacXpNRUppeVJXUmVrV0drWTQzdGov?=
 =?utf-8?B?UTFBT1RvMHMvaW1NZW1ZV0hwQmJyb3o3WExhM0pkOG9qcVN6bXFTd2JrSEFZ?=
 =?utf-8?B?bFM1bkdPZUtRcUl1dG1nM2NCbXJkd2Q0VUxldjE5eUxlN1FaeHlBYXhWOXVS?=
 =?utf-8?B?RVNneE5aNXFCd2FPZTBDaW5VMndEUFlvS0NPTEdlT1ovWHJuQUo2bjV0L2pj?=
 =?utf-8?B?aURZY09aOUNvaUtWcmkzRzN6VGpyZmFSTm8xVUxrY1hYTkRIOTMvcE92Zisx?=
 =?utf-8?B?a3ZTRzd5ZkN0amxaY3BjQ0FjN2M4SUl6cGFzdVVDM2tySmJQMFRzU2hQS1ho?=
 =?utf-8?B?SEVPZm5tYzQweWVZY25idC83OTh6Y3NCbzdTM1FlRm93RCtFdlNYSEVCUUdP?=
 =?utf-8?B?TEQ0UXJMRmFwVWorbHRoVVVTS2krMjBGREFscEVNRXkxYzdTWU9aSU0wRlUr?=
 =?utf-8?B?WXEreDg3eTQ4MnU1dFNZSXI4TEpEY3lBTE41amNidkozb2F0OUpyM3BXZkpk?=
 =?utf-8?B?aDAvd1ZRcDVHQUNUeWtTV0ttYkRvZS91LzBuTTFsVmNzaGY1Z3U2VGdDcFhT?=
 =?utf-8?B?L1h2aWdYZ3hlVW90QWM4VFdZVWFlOW40ZXJFQzhWSlZ5QW90ZzNDNHdyTlF6?=
 =?utf-8?B?ZjZYKzczaWR1em9ORklhM1UzN0xRdFdkNnlFbFRHYUlNanpHOEc2ay9JUncv?=
 =?utf-8?B?UXpXbC9TdmprYTVFYURYMGR2Z0hyLzZHRmQvNFQ3NHhvSGhmMWlMNHdpK1Mz?=
 =?utf-8?B?R0hVcVp2QVlDVEp3TUVtdmJGUVMwR1FDVVl0ZmE2YW1DQ2pNY3NOYXZLOTJV?=
 =?utf-8?B?dWlseEJOenRFU2lzNkJPN2JBdU5FSWx5UlZlZVphQ0pmYkpaSVdvOWJMZUlm?=
 =?utf-8?B?eU9OdU5uN0lOWFZZNnEwRTJkdmNscDVhSnRRa25lRGVxN3paSStUa3FQYlpq?=
 =?utf-8?B?TGVUL1dSU1d5anhORGJHUytFNFlkdGRsNnd6Q2xxSDMzUnFOZktjVWd6SjBD?=
 =?utf-8?B?aXpXcjRrQy9tblU1aERyT3ljRFhhdGcyYjVKUEtTbnZGb2UvamlLb2tIenlC?=
 =?utf-8?B?U1FPWDRoa2tad20yeUZCVlduY3hNL1NPd291ajhTNVZOOWRpYlJ4dkw1UE9M?=
 =?utf-8?Q?35iA=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7673
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF00000193.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1dbe26f7-6a7a-4077-a1dc-08de573d1a9c
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|14060799003|35042699022|376014|36860700013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d25ZUWdsUFNLVW51QU5RalZ1eG0zRmMycmVoWlZaQWpmSE1CMzVUblZjbXpM?=
 =?utf-8?B?bWs3b0x1L3FKTE1SRWdUd3p4aThQalY4a1dtcGUvbE45b0ZZdUZxRCt2d3d3?=
 =?utf-8?B?VnJkaEhHOXQ2WVRKVGJDanpUYmtld2xCMEVOTG5NWkxCVERDRFBKRDJBZTZC?=
 =?utf-8?B?eFBQV1dDWkxxUXYrbjg4ZmVwT1cxK0JPaDdrQitwWGFLZUNlVG5qVmRYM3B0?=
 =?utf-8?B?QnVadEZGY2RiQ1V3MDNIaVlZV0lqNmREQnQyNCtCMmx0MXJ3c1dhdUFuRG1n?=
 =?utf-8?B?YmZSNk9RUThTYUNkME1jUXlWYWtUakdFeHNJY1J0a2lIU1E0dDkyblBZZ2xV?=
 =?utf-8?B?U1ZCcGJTTytCd2hGK2QzNkdCN2k2WGFqMUwxU0hhbmpDbnB3R0tsUjlGOGc4?=
 =?utf-8?B?V3VVRkNiamFNd3JwQ3lYYklPWTF6VDBTQVNUdk9PMUs3V0xOeUJMd1RHa2Vl?=
 =?utf-8?B?bStpZk5CVTdKL2ZZR2cwOUYyeFBVRjBpVFpFR0xOUC9iZVVxaWV4WVhrdWlP?=
 =?utf-8?B?SW81bzk1Y2U2QzlXRDVncVp1WWprcEFPb1hydnVuUmdzOWNaZThVcE1MeEwy?=
 =?utf-8?B?SmIwZHFFdm5QeE42U2tDTEorMDdRWWlNZzZ4Q3NtV01yRVhXOTRQdkJCSE9r?=
 =?utf-8?B?SHdNb2JlenRESzVxKzIvNFFoTnB6d3ljMmc3QVhFTUZRdU1xZUxhenF1ejZu?=
 =?utf-8?B?Q1FJYm0zbEhvQ1F3bnVnbFhxaUZ2N01LZGxXRGFueVE3TmhlcWpDMWZOTlZK?=
 =?utf-8?B?NU1jbVprMERkbHBiT2VnT3NyVjFKd3k5K0l1YXZnNkg0anB1aG1qRk0rSDBx?=
 =?utf-8?B?L3ZrZU5na1JkM1dveWFmeGVmUzd4V1cxbERlWm1JYndOWVhIQk5pZUVCVm9a?=
 =?utf-8?B?ZExaQURRdlc1QnA3M0RLR1pDeVpFUDZnd3NEQXdoUHpHU3h1aWZwWW84ck1T?=
 =?utf-8?B?a2NLWXdjQkZZZUtKVm52WXpWeEpwd2llbkUyMW4vK3Fva2JmbE9YVEZ5WlFG?=
 =?utf-8?B?UVZ2SjlidTc5Mzhad3JzOWRvajRiUXl3M2pub3NlVjVadHZpZ0gxcjhRWTNj?=
 =?utf-8?B?aGVsYXlkRzFnLzdnUnIvRW1mTWV2Q1kzbXNjY2F2K1YrK0s5NEl5cktLZzZY?=
 =?utf-8?B?SVFNOEJwUUh6Slc1TXZaL1phQmtQc3JQekd0U1NjditURzZsZTlXNFlFWU1v?=
 =?utf-8?B?U2hRdWQ2bjVYdzVvdWF5bHRveVpFaXFTOHVHTndzcDVoR1E3SENEdkhhdDVu?=
 =?utf-8?B?OEF3bzAwWkhEY1JrVmY3VURUeis3dHgxR0xXRjRXMVJOOFFOUkhIeDYyQXg0?=
 =?utf-8?B?RE5oV1QzVVJJUUxEMUxDS3d0YlZ0VmpDbkNBZ0NFMmpYTzlOTHpBYlZsOGJM?=
 =?utf-8?B?NTJ0bm82ckZOTGxTRGduUGd3NzFDcTZRSmJyTG5XOFhiMktvVmFQS09HMUQ0?=
 =?utf-8?B?TVFaWnNWcVB2dGk0Y1hBdU5kTGdBelhLYXAydFRhNlQ0blZrVG9ubU5pdmtT?=
 =?utf-8?B?YzlNOHIzUzBkRjQ0N0lyczZqc0d5clpCU0RZbFZTMm11dkY2aEE2N3g0RFkr?=
 =?utf-8?B?RHBPRTBEUFVERE1HL3RheGdPQmZYaEt5VFdJT3d3eHhUUjBmWmEzTmEvTWdn?=
 =?utf-8?B?WkpsQlZqa1dSOFZleDVZZWhlTGpsMlNXSU1LYytwcmNkckRRWHRRanRqUE1D?=
 =?utf-8?B?S3NhYVFmMVNOQ2VCMGZqYzk2TzNXNDZYa0xSUnNOQ2E0NkZ5L2M3UG45aEto?=
 =?utf-8?B?eFFvenJONlQwbHpBZ3JEMHlNejYxSHNSaFdPQnlsZEFFV0ZhWTUxZFN2dTFP?=
 =?utf-8?B?TG8vVzZPRlRWTDc2M1YzNklnM1I0Mm9yc0VlZXJqcjcxYlQ5SXpTUmdhVC9j?=
 =?utf-8?B?Z25KK0Z1MFdsK2xVWHVDVGZudDJ3Sk9ZSm1iL09mSFRZSTRpOWNtaGkvbXVV?=
 =?utf-8?B?alpuRW42emNBQnVMT0c3bVlwMy9VMERJbTNqWWtRSGdzQjl0a1JNWmxyMk1M?=
 =?utf-8?B?d20rVC9aU1hsMlFFV201VVRNRGZTL0hiaXpJRkU0dVVwbG1wcUVVTXp2a1Ja?=
 =?utf-8?B?WFkxUW4rOGpUMDBBZFluc1NSMlFFQ3c5a0JpajErVWdBRkV1VjhHUG1Nblkw?=
 =?utf-8?B?QXduSFpPSnV1NVowT3RDWW5zQ1FuUGhVclo3NzZkSDE2OEU2KzkwdnE2Tzdo?=
 =?utf-8?B?bFloOTNmbjRMQUQvTFFRS0dHbzA0bElod0Q0aXVac0VxWHE5QU0rdkxqSGZo?=
 =?utf-8?B?VjFYMVQ1RGxwQ3R2VVk5bXlITHJBPT0=?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(14060799003)(35042699022)(376014)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 09:29:54.1767 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8227430-c5bb-40b8-82e6-08de573d4dc6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000193.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11539
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

On 17/01/2026 01:24, Jonas Karlman wrote:
> The lwIP dns command handle env_set() calls from the found callback and
> printf() to console in the dns loop. Making it more complex than it
> needs to be.
> 
> Simplify and ensure any environment variable that is being set is the
> same value that would have been printed on console.
> 
> There should not be any intended change in behavior, besides the change
> from using ip4addr helper to using version less ipaddr helper.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  net/lwip/dns.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/net/lwip/dns.c b/net/lwip/dns.c
> index 2b2a5947a2b8..2222e2b0b045 100644
> --- a/net/lwip/dns.c
> +++ b/net/lwip/dns.c
> @@ -14,7 +14,6 @@
>  
>  struct dns_cb_arg {
>  	ip_addr_t host_ipaddr;
> -	const char *var;
>  	bool done;
>  };
>  
> @@ -26,7 +25,6 @@ static void do_dns_tmr(void *arg)
>  static void dns_cb(const char *name, const ip_addr_t *ipaddr, void *arg)
>  {
>  	struct dns_cb_arg *dns_cb_arg = arg;
> -	char *ipstr = ip4addr_ntoa(ipaddr);
>  
>  	dns_cb_arg->done = true;
>  
> @@ -37,21 +35,17 @@ static void dns_cb(const char *name, const ip_addr_t *ipaddr, void *arg)
>  	}
>  
>  	dns_cb_arg->host_ipaddr.addr = ipaddr->addr;
> -
> -	if (dns_cb_arg->var)
> -		env_set(dns_cb_arg->var, ipstr);
>  }
>  
>  static int dns_loop(struct udevice *udev, const char *name, const char *var)
>  {
>  	struct dns_cb_arg dns_cb_arg = { };
>  	struct netif *netif;
> +	const char *ipstr;
>  	ip_addr_t ipaddr;
>  	ulong start;
>  	int ret;
>  
> -	dns_cb_arg.var = var;
> -
>  	netif = net_lwip_new_netif(udev);
>  	if (!netif)
>  		return CMD_RET_FAILURE;
> @@ -85,8 +79,11 @@ static int dns_loop(struct udevice *udev, const char *name, const char *var)
>  	net_lwip_remove_netif(netif);
>  
>  	if (dns_cb_arg.done && dns_cb_arg.host_ipaddr.addr != 0) {
> -		if (!var)
> -			printf("%s\n", ipaddr_ntoa(&dns_cb_arg.host_ipaddr));
> +		ipstr = ipaddr_ntoa(&dns_cb_arg.host_ipaddr);
> +		if (var)
> +			env_set(var, ipstr);
> +		else
> +			printf("%s\n", ipstr);
>  		return CMD_RET_SUCCESS;
>  	}
>  

Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>

Thanks,
-- 
Jerome
