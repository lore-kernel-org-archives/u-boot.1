Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF4BACCD195
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 21:41:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 256CB8382E;
	Fri, 17 Oct 2025 23:41:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="zF93m74y";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="zF93m74y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA47A83835; Fri, 17 Oct 2025 23:41:12 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 700E383804
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 23:41:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=BvnHWR5qkpFapt9BTDmiavkeZrDoCIc3K2Yt5RYGtbjegDQIck+SiYtWY3U+kDSreMKNtNHkgoW7Sivke9oposWcg6TI1quKO1yH3y09x39U+wEaiaoQfqMEm3g5aAcuPMOaxKFy+yhYMUOzIxDPgs5kZjZK6GI1tmoRHQi32qWWQfUfHgsetx7a1AcPhQs8ljhiKSgC9wSDeGmpEOoVonOI+hmnflYvOYidSH+2yCuBeBCWWo01Kxwrd6Wn3XSJtMvCGWHjqAKHFmSOTD/gZrs6Fh59ysK8Z2ZOPmilnMzWk5e1kNA9e1wauHOS7AXfsleci1wiaq3ELwKb2pazRQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZGFRsIuCYEzLSKvf1c5z7ykW44LI/1FlSGCfFl/rg0=;
 b=GaCKKab9cRwWDuRdZq2yWELOzLK9EVh4PplIomerW+lv9L8khscCj5H+l5pi+h+Ke25oMJoQ3/jv4rOhIMcSBYGQgpE6toc3D3v+KxpDR/3CR/4bScKNebAJHpYkbQ9WLQoHakDzeGebbFZTKLupbnUVQg4XtvcdqWOUt0on3XPTDEKL08ySlDLJUY8nws7FClwQRbyWdoIDEwJIWf9quoEpFENTSLwCSU+Qk9RdxIXs7Z/yyct+YPZm/tMtPphqg30qJvwuvuwyCbDusIGzIhDtD0cXrMfEOouz+EYkh4YPQuZjg2oeNAwq65Nm/zD3UOA6UKB+Rr0J5DqxkaXpgw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.81) smtp.rcpttodomain=canonical.com smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZGFRsIuCYEzLSKvf1c5z7ykW44LI/1FlSGCfFl/rg0=;
 b=zF93m74ypa2CPoglgr57Ua9eMHFVifkVareX1ODkcUY5nvm/r0skBXk12a7cL8R3/GKjQrsrwg4Z5StL2eEiaJx8t5LEcPsfRSBnDgO6vQixlVChJ6lkwK76bspCzmW88PSUlaQJ4AjFK4Ef2BC2en8uJvbPoc6GcIkJgmBoeJyCRPh6OY36N5RRtugmXiE3OwWuTo14K60+nvoV3yPmbLj17PhQiBkdZUyJlf1hhzDuEmdfsghRIMLhzmqLdE32THabHXh+PzxUuH1XVFAMntx6Yn+pk1FOWW2HcXWGGFY+J/cstyK1xl6zCgbU0QSc24Sf786W/StJdiZS/Nd08w==
Received: from AS4P195CA0042.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:65a::16)
 by PA4PR03MB7199.eurprd03.prod.outlook.com (2603:10a6:102:101::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 21:41:07 +0000
Received: from AMS0EPF000001AF.eurprd05.prod.outlook.com
 (2603:10a6:20b:65a:cafe::bf) by AS4P195CA0042.outlook.office365.com
 (2603:10a6:20b:65a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.14 via Frontend Transport; Fri,
 17 Oct 2025 21:41:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.81)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.81 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.81; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.81) by
 AMS0EPF000001AF.mail.protection.outlook.com (10.167.16.155) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Fri, 17 Oct 2025 21:41:07 +0000
Received: from outmta (unknown [192.168.82.140])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 E188920081603; Fri, 17 Oct 2025 21:41:06 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (unknown
 [52.101.69.77])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 34E1920080095; 
 Fri, 17 Oct 2025 21:41:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hoinUrc7LVWwP6K3ioCH4E0Fkn6wJKVMdpZhnvzQ0cuzw0fuGAZYE6T/9UEFR3JR2zQ0WdncrncTpVnCDshM90pPAPgDYOI826SD7RNzw64Aw/s1aFkc0iacOvWlfjoE0ziAjtSB9LZ+kIeoj9XMxY6eo3QOf6StWNhsx4HBhDMq+EnnfVxKJxBB+wjUGjOuakb9OXf9P21iVpC/SIuyOKtuIbAg2k217qZH+9ARoJjt5M9Cug3iP2+PY3x7iO6HhmSBO7vEjMQHPSrBhiT2JPtZXSv8fP5+LXNlpa3L2hKoUfJWbvq1H1gRV2YlH+rdVNluZGNMJndUwvB/hwSf7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZGFRsIuCYEzLSKvf1c5z7ykW44LI/1FlSGCfFl/rg0=;
 b=XeUZait4ggrJ5Br290CwkfBImGB2lY137eyKloe/7v0WjIohzzYurN2llrPIVDWDDmHs0KbRD0QkzCuIyeo8uk1V3mFedp+Br4uxx1Qr5dcgdbVAqXgqfJz8w1B+aD+TtmBKZjiGvWCVSs8xP3SwYJoqhkdtwSJBwYjwGdxRVA2HxHKHJYVOKA60fW8O5qjPYDdVC8uC9jqf20lCsrHgFsjMYCDHXBEgpxh4XvtOrQKxCNbrxEoAntrdsSmRgPISUjBpXEDTId1l7EfEKVzDxMQEAQFROdvNy9Zg2I2HQ1LopwjRtM8FlT/NozWNms4THyIa+K8jQMkgtCLcozVdUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZGFRsIuCYEzLSKvf1c5z7ykW44LI/1FlSGCfFl/rg0=;
 b=zF93m74ypa2CPoglgr57Ua9eMHFVifkVareX1ODkcUY5nvm/r0skBXk12a7cL8R3/GKjQrsrwg4Z5StL2eEiaJx8t5LEcPsfRSBnDgO6vQixlVChJ6lkwK76bspCzmW88PSUlaQJ4AjFK4Ef2BC2en8uJvbPoc6GcIkJgmBoeJyCRPh6OY36N5RRtugmXiE3OwWuTo14K60+nvoV3yPmbLj17PhQiBkdZUyJlf1hhzDuEmdfsghRIMLhzmqLdE32THabHXh+PzxUuH1XVFAMntx6Yn+pk1FOWW2HcXWGGFY+J/cstyK1xl6zCgbU0QSc24Sf786W/StJdiZS/Nd08w==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com (2603:10a6:102:329::6)
 by AS8PR03MB9957.eurprd03.prod.outlook.com (2603:10a6:20b:63d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 21:41:01 +0000
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce]) by PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce%4]) with mapi id 15.20.9228.012; Fri, 17 Oct 2025
 21:41:00 +0000
Message-ID: <0532fb54-43c6-45c2-98b1-51fd4acecc3e@seco.com>
Date: Fri, 17 Oct 2025 17:40:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: semihosting: Use correct variable for error check
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20251002-fs_semihosting-v1-1-1124e6becc51@linaro.org>
 <2780374a-3a85-4969-96df-34e331a53c53@gmx.de>
 <7f274115-8fd1-46c3-866c-278569aca469@seco.com>
 <20251015162858.GA669557@bill-the-cat>
 <632340c9-6a6d-4f46-b731-e766f8517f7d@seco.com>
 <2b8c5ccf-5ed8-4ea2-a149-e37f9ed8943f@canonical.com>
Content-Language: en-US
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <2b8c5ccf-5ed8-4ea2-a149-e37f9ed8943f@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR19CA0015.namprd19.prod.outlook.com
 (2603:10b6:610:4d::25) To PAVPR03MB9020.eurprd03.prod.outlook.com
 (2603:10a6:102:329::6)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: PAVPR03MB9020:EE_|AS8PR03MB9957:EE_|AMS0EPF000001AF:EE_|PA4PR03MB7199:EE_
X-MS-Office365-Filtering-Correlation-Id: e6c2b332-d314-4b52-d34f-08de0dc5e12e
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?dTQ4ZEE0Q0hEOEdFSTl3MCtBcWs0KzUwazVsNGNJeU5lUWhJa1NNMjJEcTFw?=
 =?utf-8?B?RmcybTJySThjbnp1b1NtQ09RRHlFNGhod3IycXRhakxDU2piMHV1L0VLSFQ0?=
 =?utf-8?B?NW1SWXZjR2J3ZStVYXo0SnFjd2ZVOVZOOXFGcFpPUDdsM2hJQk1lYytwNnBQ?=
 =?utf-8?B?WUNxaUxwNFZmVWRQenVHZExxaTgzSndPdlE5a3ZFUzd5UzVXbTlwQTd2Si9q?=
 =?utf-8?B?OVYyTzJEV25OSndPVkorYURuTFplMEJ6TVpMalBVV081M0FIRzhPUUhEbmpG?=
 =?utf-8?B?ZnRmY2xkeEl0NE94RFlkdk1qUTc4cnBFZzFXWnIzYjhXUmFJYlhmMDBZcHgv?=
 =?utf-8?B?dGg2d1k5NjJkbmlnd0wwNGppREtaUFdON2dDbDl0OUZacmdGbUdPNW9PT2Z2?=
 =?utf-8?B?K3RIN0ZOM2w5akU5Nko0YmJKTGw0NW16SWtNdGNvUGdaNUtSbk9pYlBQek9O?=
 =?utf-8?B?M2J3cmZaZnhRdVp4dmRKaDhSS0ozMFhnZDNjbXBxdlNhbDhmdW5TbGtUcCtk?=
 =?utf-8?B?b1NaZHB3MnNzeHpXRkd2SW5jQldIMENpSWxjcUcyYTVTNk5uOURycm1HRWF3?=
 =?utf-8?B?c1ZBR05aZTRnL2lXejJUSGZ6aVd2SDYyZkZqMUhseTdaY0dmdHJUQjg5S3pT?=
 =?utf-8?B?S093TmUvV28rQzJkL2NMRjNpaTNIUTRONUVldFZDV1UzNWVieHdReFZ1NjVO?=
 =?utf-8?B?VGM1cE0wdnAveXYraGVhd0NrMlE5UG53WmdlS0FrMDdnajhnKzlGcjVaL0Vl?=
 =?utf-8?B?MWhFdFJHeHpEUzNJR2YvemZSM3lHLy9mTkFhNU5HTks3WXplRjgrRG9WbUpm?=
 =?utf-8?B?dVpQNUJoWGZqMCtRVEMxV3B6ZmttdFdMcUdxM1pROWljc1o3ZjJXTVFyMkRr?=
 =?utf-8?B?VVozeno3OFkySkU1aVo3eXhmeXF5dXlNYUlzSEk3QzBkUE1TYSszOFZKT1M5?=
 =?utf-8?B?dzV6WCtwUmNXVnJ0c3IycWtFVXZQVEtZUDBuTW81ZFgyRnRna2wzbTExMnVz?=
 =?utf-8?B?MERCSmxNTEVBdENDYTFFTnNIaHN6am83TVJKQVo0NWhCTmRlelNuV2xPVUZm?=
 =?utf-8?B?UituWjUxL2p3YlYzQkpHWWEwMnRqTzMzNUxjN1ZyN0V6WVBJZ01KSVN6anRx?=
 =?utf-8?B?QWo4dm81RmtkaTNvRGZPL05OLzRia3pKaUc1a3lndlB4blBWQlFCbmpRNjF6?=
 =?utf-8?B?VU5NZ1dPWEIyaTl2S213Mk5ySGlDVjNGSmlrbnRnV093QVE5K24zc1RlT0FT?=
 =?utf-8?B?YzJhSDZOcWpzc1JJaFhsWVVZRWQ4RklHSXAvTVFFRDJFcGphbGlDcGVvOTlx?=
 =?utf-8?B?d2ZISzVKck85YkRlb2RvN1N6R29teU5NOGlYMU4rM3VtTHdPb2hBRUo0YWFw?=
 =?utf-8?B?clByNE9TYVFRY1ZGL1UrdnpQeXMySC95S2ZrL2NDbVJRL1Y3cGdxeXoxb0I2?=
 =?utf-8?B?MUZvNU1YQmduMjE1MlplcWJDbk1hay8xY0tnb1VjZGxpeWl2Z2pBSUsvMm11?=
 =?utf-8?B?Q3NOMWdoSHdqc0JIT0RjRC9uK2NST0xrZGVLS2hWK01FZ2ZmYXhMNysyaHB0?=
 =?utf-8?B?K3FoZlFuM2owMmc2dnEzaURJTi9laUR2S1RHRStFRFJqUG5lZzVBSFlCdjg2?=
 =?utf-8?B?WmEwWXpDV3h6UEgyOUYwRXdKVHZxZWcrMFExTGJ5M2lldXlLUVNadkVUYmdJ?=
 =?utf-8?B?TXhyMkxtNGwxODV1TWFFNFE3V2JRanoycks0RjRDeXNuSzQwRTJZK1AvR2Jm?=
 =?utf-8?B?WCtJVFVmNzM0VVJ0UHVPWW5oQ2tUYytTV3NXMVMwVjdZQUNpZk9OUDNvOFhC?=
 =?utf-8?B?SEhjNUNiVndubk9SZXQ4R0pYQm5nQ1hnTDc5bzdYY09hU000bllnUWJFY2Qy?=
 =?utf-8?B?YzBPZVBCWDY5NzR1ZGd0dHVhV0ZnamdrTFZZYVZpWlpNT0E9PQ==?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAVPR03MB9020.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9957
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF000001AF.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: aab45192-c61e-45b5-65f0-08de0dc5dd0d
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|36860700013|14060799003|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SHhYZGdmSjludmRVME1SQ2tLUHRVKzV4b1Nra1ZqS3NIeTNjWElLSTBRcVlj?=
 =?utf-8?B?ajRJSnRWdWVDTEFwdWo5Qkg0YTZpWjNHSGRLSm5senFFRWlGYTFNREl1dy9a?=
 =?utf-8?B?b3BZYTRFNnBBWGxMeVVQWHBPS2tZemVaRGpERGxMRTNLMWlRRHpPYzdZRFF1?=
 =?utf-8?B?cy9xQWY3N1lPTjhqdkdiTVFmUHI5bDNZdU1wdjJFMk5WalA0R1JnV09WbWll?=
 =?utf-8?B?TllIWmRhMjAzcTQxQkhXeEt4K1JDSDJDRGR4b1lmNzNTQXQ3ZnZyZmJMWkli?=
 =?utf-8?B?bC9URHlOWEtMRkNlYlFyS25tc0dFMm5yMXIvcGNCeUpWSVJhMGNoQnJwS3JN?=
 =?utf-8?B?SFNTSW5MMERBMGdYb2JpQWx1YmozQldpUE9JbzBzUlk4OXRSM2lXeUlVVjZu?=
 =?utf-8?B?bEZIb0tvalZYczhyUDVQTUhZOXhmQnk5NmZUNUJBV3Q3cXptcjlhQnFlSWdC?=
 =?utf-8?B?Y3prVlQwclJnNFUwb3lEU0szbEJ1eHcrQ0NjNWV3YTMxUDhCMG1lSEd6eS9n?=
 =?utf-8?B?dkR6M0ZoaVVTRzQvZWRqeEtyN1owY2ovWGFCSVNZekpzQ3gvZmxLWlQvTGl5?=
 =?utf-8?B?QzdRa2kvU1kzTWxvbEZMeE9vcldCSjJJNEtodjVDdG93enRiWVVjUWEyNm1m?=
 =?utf-8?B?L3dQNnExZWdHOGFyNW1rZE8zSDZZa0U5dmZCZGdCNkhoVjZ4REtEYjQ5eXo4?=
 =?utf-8?B?K0tEQWp3eUZXQS9kcmEzNlhqZm5DWmtJckhoSnBVQXJPSkpRY0tJRllSUnZr?=
 =?utf-8?B?WWc5QXdLVDY3WTlSUjhpQ1I2VTlrRHJyTFJ3MXh6dHlIakY0NFpGQjg3L1Rx?=
 =?utf-8?B?NXRKZnpmRFk5elk4RDBWYnJNMEpSaGhhcklXT2RQRVBLaUtHWTZEWElMVVBa?=
 =?utf-8?B?K1p6dUk4bjdxM0NML3hTYWVicjJ4Nk5rQUZxT0NqYS9LM2xrNzJPM2dOb2t0?=
 =?utf-8?B?S0hJRmEwaWQwUFJxcG5ZRTR0VmVxVXh5RGJpcUVOMDYrblQyWVFMWmRVVE1u?=
 =?utf-8?B?TnJ5OUp5N2RySUFoSDZSanU4U0FpaU5lRWo5TUVIMEJEcWNpUlNYdzRXcmxw?=
 =?utf-8?B?S251QUVaWWQ3blpGaUwzVTV2SW4zUEpGTW44MlJNdHI3T2JDbnI5bmszZmhP?=
 =?utf-8?B?d0lKSXd1Tm9KSkFKZzFQQkppVTFrQ3NPdkNTc2FXVjAxWGZjcnJZU05pR3FZ?=
 =?utf-8?B?eFpWZUlJOVhIRzU4enZtUFBYNUROZkJmYUszTmQxU2ZnK3BYdGJ6RUZwaENG?=
 =?utf-8?B?NjU5NktPcVlaNWdDbllMeHJ5ZzNJeDdTSnpCOGlNODRsL2xmN3p5Uk5wdGZt?=
 =?utf-8?B?QUloSE5WTytzQjhKRGFLSVJYWDdmYyszejhzODh4YmtLSnFaOExKQTNSTklv?=
 =?utf-8?B?NTdFWHVOMmFxSWZ0Ylh2Y0d3TlRJVHpYOEp2NGFLUzRSKzZZRW9ra1gxL0pX?=
 =?utf-8?B?R01rbDZYT2JXaHpvZWxIR0NvUjlnM2hKWUpyRGJCUURUVlZjRHZaMWF5VUtP?=
 =?utf-8?B?NnFtSHpwUHpoMjV6Mk90elYzUEQwT0lNemlxR2hnR1F0UURvZEFKZmJOSkY0?=
 =?utf-8?B?M2wxYTZvaGpWV1lZOHNLdWN2Y1ltbnM0QWxlVjFjdTFMM2FrK25qTEFYYi9P?=
 =?utf-8?B?Ni9FemFsZUM4VkwyRmVXLzY5bm9SR0RvYmxwN3ZiaHhzRmFEM3F4WGQ1UWE2?=
 =?utf-8?B?eWlnSmhiVDh1L25WNS9taU8zT3ZnUHNmZjBDVVVYOXlMS013TWk3MEZYYU54?=
 =?utf-8?B?enM2ZzFmMEZ0Rlg5Y2NkdVFoNHZEOTJwK005dnRnZjVKN0VvdUtMcW5kcVFS?=
 =?utf-8?B?a1dCUzZ5RVhiNmJxRThMcDhERUJHNUVHVEJIYWVKek40cVd6bGY2M1JTaVhy?=
 =?utf-8?B?S09KVEgybmlMb3lTZEZRRGgxYXNOb3NwSTlScWJVNy93SE5abUQrSjJsR3FU?=
 =?utf-8?B?OTBlNE9Dd0J4S2FzeFlQTGkwc2E2ZThnMWxBejZXT1dTL204eStEOTBIb3Nt?=
 =?utf-8?B?R2o3SEYwZStZeVhYRHJsUmtheXg1YVdqUW9idmFRWFVMSUlGZlA1c0R3OXVh?=
 =?utf-8?Q?sgfiIN?=
X-Forefront-Antispam-Report: CIP:20.160.56.81; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230040)(35042699022)(36860700013)(14060799003)(82310400026)(1800799024)(376014);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 21:41:07.0404 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c2b332-d314-4b52-d34f-08de0dc5e12e
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.81];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001AF.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB7199
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

On 10/17/25 14:00, Heinrich Schuchardt wrote:
> On 10/17/25 19:08, Sean Anderson wrote:
>> On 10/15/25 12:28, Tom Rini wrote:
>>> On Thu, Oct 02, 2025 at 10:36:07AM -0400, Sean Anderson wrote:
>>>> On 10/2/25 05:52, Heinrich Schuchardt wrote:
>>>>> On 10/2/25 11:39, Andrew Goodbody wrote:
>>>>>> After calling a function that can return an error, the test to detect
>>>>>> that error should use the return value not a different variable. Fix it.
>>>>>>
>>>>>> This issue was found by Smatch.
>>>>>>
>>>>>
>>>>> Fixes: f676b45151c3 ("fs: Add semihosting filesystem")
>>>>>
>>>>>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>>>>>> ---
>>>>>>    fs/semihostingfs.c | 2 +-
>>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/fs/semihostingfs.c b/fs/semihostingfs.c
>>>>>> index 77e39ca407e4d240a1fd573497c5b6b908816454..9d7a136b9ba9b035545b34b31df58e2d65de7db9 100644
>>>>>> --- a/fs/semihostingfs.c
>>>>>> +++ b/fs/semihostingfs.c
>>>>>> @@ -35,7 +35,7 @@ static int smh_fs_read_at(const char *filename, loff_t pos, void *buffer,
>>>>>>        }
>>>>>>        if (!maxsize) {
>>>>>>            size = smh_flen(fd);
>>>>>> -        if (ret < 0) {
>>>>>> +        if (size < 0) {
>>>>>
>>>>> The ARM specification (https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2fdeveloper.arm.com%2fdocumentation%2fdui0203%2fj%2fsemihosting%2fsemihosting%2doperations%2fsys%2dflen%2d%2d0x0c%2d&umid=f17ab8fc-2d9d-4cce-91e2-e7e66f117613&rct=1759398729&auth=d807158c60b7d2502abde8a2fc01f40662980862-e0799d2d4d61f93cae033d54733c8fa50ef84918) has:
>>>>>
>>>>> SYS_FLEN (0x0C)
>>>>>
>>>>> Returns the length of a specified file.
>>>>> On exit, R0 contains:
>>>>>      the current length of the file object, if the call is successful
>>>>>      -1 if an error occurs.
>>>>>
>>>>> Please, consider that the file length on 32bit systems may exceed 2^31 You must not consider this as an error.
>>>>>
>>>>> %s/if (size < 0)/if (size == -1L)/
>>>>
>>>> This cannot occur because on a 32-bit system SYS_FLEN only returns
>>>> 32-bits of information. The host must detect files that exceed 2 GiB in
>>>> size and return -1 (simulating EOVERFLOW).
>>>
>>> OK, but this is for 64-bit systems too, isn't it?
>>>
>>
>> Sorry, I worded that poorly. What I mean is that the spec says
>>
>> | On exit, R0 contains:
>> |     the current length of the file object, if the call is successful
>> |     -1 if an error occurs.
>>
>> which implies that R0 is a signed integer (otherwise they would have
> 
> The only thing that is certain here is that the register will be filled with (unsigned long)-1L if an error occurs and that any other value is not an error.

It says that any other value is the current length of the file object.

And we should not support negative lengths.

> Everything else is your personal interpretation which does not match the existing implementation by Linaro in QEMU.
> 
>> specified 0xffffffff or 0xffffffffffffffff as the error value). So
>> negative values (other than -1) indicate a negative file size (or are
>> unspecified).
>>
>> However, both OpenOCD and QEMU just take the return from stat(2) and
>> copy it into R0. With a 32-bit host there is no problem since stat(2)
>> will itself fail for files over 2 GiB. With a 32-bit target, this
>> produces erroneous values for files larger than 4 GiB. Files sizes
>> between 2 and 4 GiB could be recovered, but I don't think we should do
>> that. On a 64-bit target, there is again no ambiguity (at least until 8
> 
> You still don't provide any reason why you don't want to support files in the range [2 GiB, 4GiB[ on a 32 bit system.
> 
> Instead of restricting U-Boot we should add a fix in QEMU to report an error if the filesize exceeds ULONG_MAX - 1.
> 
> This is the only way we can ensure that a 5 GiB file is not reported as 1 GiB in U-Boot as we see it today.

https://review.openocd.org/c/openocd/+/9173
https://lore.kernel.org/qemu-devel/20251017213529.998267-1-sean.anderson@linux.dev

I think the latter may be held up on the list, but hopefully it will arrive on lore soon.

--Sean
