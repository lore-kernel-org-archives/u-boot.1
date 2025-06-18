Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 745C2C71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 23:11:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8547A82D06;
	Thu, 19 Jun 2025 01:11:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cern.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cern.ch header.i=@cern.ch header.b="VQB0kfPn";
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="VQB0kfPn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDC4782BCD; Wed, 18 Jun 2025 21:30:32 +0200 (CEST)
Received: from ZRAP278CU002.outbound.protection.outlook.com
 (mail-switzerlandnorthazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c213::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4DDF82B18
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 21:30:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=cern.ch
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pieter.van.trappen@cern.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xRk9DqBc8oYCL/+zFpazMqUErMRoHn8BlT8Lw2D65YSHYyq+kwfa70UeYt9jXh3dQyxL1NDjrSMxROoK5XOLxQEWjOZnv8g/WhjITZ+npPMMTpNsrFGjyZHmroB2ev1vrWS+iEInUSby2mNnymKl8YsNTiW2H26wMQEISKln8VKXItGlSm+PvI02F4KV7QL/5AcvPRXLMVpPYdKRBeW/tALAdCI3mIqW3ZtvyMbtuQJ/XHt9F/VlpTulkInebwoxo93wgjOsPJ4qaMGigV0DUcMUWBL2fLIjN23p7eZD2iA1qT7sGrCclZ2yNyWsQE7zvnEpW3XyM6M7w5l1kzRE2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isqbOUn+RRTZoYFK1sPEjYmpka0EW3GnlazBJ7NAc+0=;
 b=GRlvp9jqMs/agCqBNAWBgYa+uMBDRlXv0EJJ1+nDYtcNTsbPiS3k1YxqNB3AxYknOJuHXhQ0ly1yyiYFngzEt/f9TigbBTlJjNcNUH/B2qu1jpNOS6sc5qMABPAtOwoZXJE5TKr8W8GBNM7/Yde9DApYr2OO61fNXqpHThoKOG7jEj+dddwON/XF9BxBWawJ6lL5O7XCBm8Uuy9GETSvCBdiYArQ/8lRES6avmkE+oZGpPifE+WPiroENtbBv36mGqzZGWdUTOx/i1vyDjibyM1VqB5eaJNpaxCHJZOhirV74/vBhQp4cWgVpmAYaZG56L4ctlB9BOEG36NYcz3UlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 51.107.2.244) smtp.rcpttodomain=amd.com smtp.mailfrom=cern.ch; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=cern.ch; dkim=pass
 (signature was verified) header.d=cern.ch; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isqbOUn+RRTZoYFK1sPEjYmpka0EW3GnlazBJ7NAc+0=;
 b=VQB0kfPnUpstuXMqpmJbxVDSrlAfS4t099PsDPN1je9aLrjDStOjdk9ukU0hf0Up6ZSajhydbF+zkdldPQS26KZy97JpGsrQpiWHvvvcwN1eCtDeHpHhv1ps3hb/uzzsaTMi3Va2879witWE0Up3vpV4RLRZPIhkrRg5Eytu+QI=
Received: from CWLP123CA0087.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:5b::27)
 by ZR2P278MB1112.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:5e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Wed, 18 Jun
 2025 19:30:28 +0000
Received: from AM3PEPF00009B9B.eurprd04.prod.outlook.com
 (2603:10a6:401:5b:cafe::f3) by CWLP123CA0087.outlook.office365.com
 (2603:10a6:401:5b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.30 via Frontend Transport; Wed,
 18 Jun 2025 19:30:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 51.107.2.244)
 smtp.mailfrom=cern.ch; dkim=pass (signature was verified)
 header.d=cern.ch;dmarc=pass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 51.107.2.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=51.107.2.244; helo=mx2.crn.activeguard.cloud; pr=C
Received: from mx2.crn.activeguard.cloud (51.107.2.244) by
 AM3PEPF00009B9B.mail.protection.outlook.com (10.167.16.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.21
 via Frontend Transport; Wed, 18 Jun 2025 19:30:27 +0000
Authentication-Results-Original: auth.opendkim.xorlab.com; dkim=pass (1024-bit
 key; unprotected) header.d=cern.ch
 header.i=@cern.ch header.a=rsa-sha256
 header.s=selector1 header.b=VQB0kfPn
Received: from ZR1P278CU001.outbound.protection.outlook.com
 (mail-switzerlandnorthazlp17012053.outbound.protection.outlook.com
 [40.93.85.53])
 by mx2.crn.activeguard.cloud (Postfix) with ESMTPS id 033C981ACB;
 Wed, 18 Jun 2025 21:30:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isqbOUn+RRTZoYFK1sPEjYmpka0EW3GnlazBJ7NAc+0=;
 b=VQB0kfPnUpstuXMqpmJbxVDSrlAfS4t099PsDPN1je9aLrjDStOjdk9ukU0hf0Up6ZSajhydbF+zkdldPQS26KZy97JpGsrQpiWHvvvcwN1eCtDeHpHhv1ps3hb/uzzsaTMi3Va2879witWE0Up3vpV4RLRZPIhkrRg5Eytu+QI=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cern.ch;
Received: from ZR0P278MB0759.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4f::14)
 by ZR1PPF44E2E16D4.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::28c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Wed, 18 Jun
 2025 19:30:25 +0000
Received: from ZR0P278MB0759.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1a96:59c:94fe:3ae8]) by ZR0P278MB0759.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1a96:59c:94fe:3ae8%7]) with mapi id 15.20.8857.016; Wed, 18 Jun 2025
 19:30:25 +0000
Message-ID: <405c6a76-d2f2-4842-9d0c-b74888834c78@cern.ch>
Date: Wed, 18 Jun 2025 21:30:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Improve user feedback in case of FPGA bitstream load
 failure
To: Tom Rini <trini@konsulko.com>
Cc: Michal Simek <michal.simek@amd.com>, vtpieter@gmail.com,
 u-boot@lists.denx.de
References: <20250617092333.335908-1-vtpieter@gmail.com>
 <eb9be150-5298-4929-94e2-ace2f095eb84@amd.com>
 <20250618135728.GA6521@bill-the-cat>
 <ef7de176-5beb-4a7f-9663-a2757b85b86c@cern.ch>
 <20250618161622.GG6521@bill-the-cat>
Content-Language: en-US
From: Pieter Van Trappen <pieter.van.trappen@cern.ch>
In-Reply-To: <20250618161622.GG6521@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR2P278CA0056.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:53::8) To ZR0P278MB0759.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:4f::14)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: ZR0P278MB0759:EE_|ZR1PPF44E2E16D4:EE_|AM3PEPF00009B9B:EE_|ZR2P278MB1112:EE_
X-MS-Office365-Filtering-Correlation-Id: 22e8dd1d-38eb-4575-c12b-08ddae9e9488
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?TW9tRVNEQlZGNVJKakJBbSt5QllYZjlwSnRPZzQ2VGlGYlVBM2hkWkZrOGRJ?=
 =?utf-8?B?aHBzbU56bzhyQ3pEeUZhMW90alBRSmtwY3NwM1g3cmtQV0Qyc1FyczRmWm11?=
 =?utf-8?B?bisrUU1lQ3dBejJIcnBCZ2FlWmxFNHhpR2djTENpZVlIK2lsME1DbTZ4VVJU?=
 =?utf-8?B?TlNmcUxKQy84eHhUZFRKT3pIQm9NQllobzkvc2YzQXA3aTdWQThwdkRiMThZ?=
 =?utf-8?B?emwySk84RWRHZTBsVGoxVXZ6Q0N5MDhVdzBMM3dMMlhtMnl5SkhOZ2lJeW1m?=
 =?utf-8?B?QU1BTXpURCthN1RnUmhMbzhIeEx2YnI5eDRFQ0FsRVlYQ2pOV2h6cTV1eWQw?=
 =?utf-8?B?ZURla3hGTUFuR2ZXbGYvQ3RPdnkvS2ViaVlkazk2anNxdEczL01ESW13aWJr?=
 =?utf-8?B?dmhOK3FHSm9vN0QzQzdOcEZaRk1rQUN0bUU4cmJiRlV3STlSN21IRmFnYjg5?=
 =?utf-8?B?MnNrSFgwQUpBNWhSaE9QSHVOc3R4dUJ3NmhoZDFZSktENUxETGoycFYveWVO?=
 =?utf-8?B?Y3hsNnNFeVJvcmVXdWs2aktXMTgxdzFFWmNIY0tmV2gwQnMwbHdTQTVmNGlJ?=
 =?utf-8?B?aThMaTZ1QmJORDRVWU9NL0szajBsM3hLVVZLSXY1cHJkZ2pGWGtqd2hab2gr?=
 =?utf-8?B?MFhQSnFJeEtlenRkSnQ0NVBSVzY0NzN4SEQ1NU5KVWdYanZlN042QjRjWGxR?=
 =?utf-8?B?cWNYZjc5eTRXR3k2R0lwRnVVOXcxeHVFTlBKS2FqeGllQmFjWHN2QWxCN3Yx?=
 =?utf-8?B?ZVdXbEdtQ0xwWkk0aENwdGhteHVORTRDMjdRTk03aXg3QzFSRVVrb1JGMU12?=
 =?utf-8?B?eW9LR1hoWmRKL2F4dGpJMjlydXFWWWhYMjEvMWlkMXhNVlp2aDhlTHpZYktZ?=
 =?utf-8?B?ck5BakJWMHhkYUlmb3QzczhXUWtwVkI0VWFqbE5PdkkwRWQxZ2ZudzErVXJN?=
 =?utf-8?B?T1BMSmhtZzZLNURNS3Y0Y2FBM29JaEdvaWpkSW9wVWtjM1RHVURoZkl5TTU5?=
 =?utf-8?B?b1VGRVJGc0RKYjRCWjZwUjlOMEEzOFN4RjNXZkdxK0xBRFFscy9MakV0dlV6?=
 =?utf-8?B?NEo2OWNYZjV6anZ1ckZvTVVEMUhwZUpTVU0rb1l0SWFHT0ZxM1BkSmRvci9i?=
 =?utf-8?B?NFV2Uzk3TTBFVXBwS2d2UkYxelIvVzcyclQxQ21HMUE1enAxWlpvMHAzY1Jx?=
 =?utf-8?B?WXBUdGEzYnlHNEpiK3BRWDF4bW1iWDdBZXdpczNIRTVScHB6OVU2LzVEVmR5?=
 =?utf-8?B?ZjIvR3VWMTlYaGR5UmxBZ21sSWY3K1BLZmh0NDRNOGFzQ2VaV3FmR0NYZEtu?=
 =?utf-8?B?YzZ5eHN1c2dFY1ZwNSsxT0dYWXJyV0hmZ0pVeEJndzdTTDVNcjI0LzBLb1dY?=
 =?utf-8?B?VkFBamsrdkFPOVhJZHFOTkpMa0twK3pYNUFvNUxFUExMbGh0anpoQ3JCZ2t4?=
 =?utf-8?B?WndvWFBwN09ZOURjdGNZTlpBeitjaHVIT2tPNmxseXJHdERjM0ZYTmRnck5a?=
 =?utf-8?B?WWlCZS9RdlVOZjJERXl4dXJucGlZR3RXS0w4dVRCVDJYL0ZSeHB0WkhkcUxW?=
 =?utf-8?B?VnVvQ1JLL2VlMHV3eEplWlNlKzZsV1pYRGIvNTBKdVFsQmRxVGFoVkE5NW1W?=
 =?utf-8?B?Z2pXN2hZTGJXU2E5Q3ZySUlkRzZDbzBaT0hyQkw5RDlwU3RRUEVNR1hyUG1h?=
 =?utf-8?B?QlQ5VFZmUnUyNFJIUWxDK2FWMzFWdGtPTnFnSGdNcEhhN2FQcWJ1N2NBMnF1?=
 =?utf-8?B?TW1ZTUROOHNMQ3NxNmc3TlhFOVNqMFJqNlpxY1luaU9MVFMwMTVwN2VIdEk5?=
 =?utf-8?B?eGxuZDZWUXU3emhPRUhmZXZubndwdUhlL3ROSHVCemYwTmVPZEhSY2tZcUdF?=
 =?utf-8?B?Nk5iUm1RMmZNN1h4YnY0aUJZdlIzYzA0QWp3M0xhMk1YbjZxa2RuMktFUEhm?=
 =?utf-8?Q?jEl9f/wfu/k=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:ZR0P278MB0759.CHEP278.PROD.OUTLOOK.COM; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1PPF44E2E16D4
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM3PEPF00009B9B.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: e08151ad-090f-4c34-f781-08ddae9e9344
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|35042699022|14060799003|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZkphbzRvZU44Nk0rVlIwVHJ5RTAyazI1Z0VydzU2aWh0VlhBa2R1Ynl0bkhF?=
 =?utf-8?B?QzQ4QithM2JqdWxYU0tjYzJjb05KVHhQc2lkUFJTOUUrb2xVRS9DcWJ2NkNG?=
 =?utf-8?B?WFRZMXpIWWd4WjIyQ1hENk5KQ0hmZWY1NnBtN3dOZHRUSlBkcDZBWng4cW43?=
 =?utf-8?B?RnQ5Rmw4UTRtN1pneDRXODRrLzdqT3NtQmxXbzkyNXR4VGgyY1RqTmpKclE2?=
 =?utf-8?B?SmZDZWY2OWVSMHFSdVllRlJUM21BeEd6TjNMVitnbWhSdGxYQ0dZYXBJNXlL?=
 =?utf-8?B?UWxWSlpsM1hFKzNyRWRrZGE5VTh4Lzdic1BWVk5YMEJkV0tTZFQ5aGJnaFEw?=
 =?utf-8?B?WjJGTTl0T1Y3TmU0UWxxMVhEa01oOFlWRnp1MTRFN001ZmdVam9YcTF6QVRh?=
 =?utf-8?B?Lzk4QnRpUmhWS1JUUXdqR3FtWlI2amZtZWFXcm1vR3BhUW54V1Q1dlkzMkpM?=
 =?utf-8?B?VkFCeEl3L201cmIyVDFjeS9DMytBckR0T09sRzE3bU9CMmpMSU1UWDRQZzZM?=
 =?utf-8?B?ZWNqVjBZdDdVZTlqY0xGb2lNSllxOTdJemRuWWZqVDZxcmxSMDlvZGh5ZEpl?=
 =?utf-8?B?L2c0TllTRm5oMkttOGhQZEprQ0wvaThOUWdMRDRxMWdjTzlrV2FaWW5Cc3FI?=
 =?utf-8?B?a2hZbEQ1bE9qRUdaQUxyQWVqd2dpYm5id0ZEWkNCdHV0T015ZjhGNGRudURz?=
 =?utf-8?B?Q05JOS8xNlVoT2ZxR01VbmJsUklZNXpVMVpSWHY2TzlrNUhQZFRISTV4WWl0?=
 =?utf-8?B?OGxXVTRLenpDcWdENUVEc3JtVDcraDJQYWRPVGxrQ04wc2tsbGJjejlkK2hX?=
 =?utf-8?B?UzM5YWI1Znh1LzRzV3dnTUxta1huWElyOWRPRnhIaWQxaGhURjNKQ3Q5dmNT?=
 =?utf-8?B?aFBhbkdYeFA5Qm11K2ZKRkFMMktGeXdMUDdmQ0FuVGxRM0YxZHF3dGVHQ0Z2?=
 =?utf-8?B?NUxRV1c5NjJNUnZtQk91R0QzL2dkRmxmSU56L1lMdzNnSTZhNmozSlVWbmFJ?=
 =?utf-8?B?VDU1TTFnYXBsU1NmOUFlUzdNbGFoUWliaHgxMHN2YUdDdUVLamU1Q3F5K3RX?=
 =?utf-8?B?dklDdEdKTkowRk1yUVhmMTE0aXQ4b3hIZzBRLzA0c3labEFQVEdiOWhtakRS?=
 =?utf-8?B?VXUyMjB5VS9ndzNuL0duaWVhZnV4UnRDNE15V2JoWWg1a3FUWCtOODdtYm5n?=
 =?utf-8?B?c1RQa1lSRU5xT09MRkxOcDJiOVBxY1hINHdBbnEyOUJWWjk3SE9yVzJMT2Rl?=
 =?utf-8?B?dFdZOElXK3Y0ZzVjNnZFcjBITkxSc29jNkM5ZzZFczQ4Mk5hREZYeDBidVlE?=
 =?utf-8?B?UVB6S3hURmNjVjFOSE5UWEtxTHptN3huZkFCcmVqNWV5bFBSdjA5OW56dG56?=
 =?utf-8?B?U1VNcUkrMmRqNWMzOURMSGVVNWh3YVlJd291WjY1WkN0T0ZRVWVzQTdHV1dE?=
 =?utf-8?B?czJGTUdvZTErSzkvOG1tUE9CL21LNFY2VTk0U1QyelFFNU1Ta0FpWG9yMDB2?=
 =?utf-8?B?UHllc3RRcFV1akx0THVERHR5bWUwU0pCamRQQzFZRlh5U1l1ZUhLZGZteEVE?=
 =?utf-8?B?VDNjbG5lMnFhbUo1OFozVWRRL3hLUDdMaTdwNWZhNGMwWW9FOGlBYURUSnVq?=
 =?utf-8?B?TUduV2kySktaakExWUt4b1d1M1lPREFaV2FtNEt5OHo4S0Vvdk1ZeXJBNmY0?=
 =?utf-8?B?WGlBVkhwS1BEZkNzQ3BvUC8xNndQMDZlckVCMmFaUklBTHRlQU1hRWZ3V0dp?=
 =?utf-8?B?NjJiRkJWT2pVYS83MTQyb2JrS2JwN1gxQTNvRDZQVzgzUXBiUlI0bmwvQjly?=
 =?utf-8?B?TkkvcVJ1UmkvemFEZG4wck81ZjhvOExpU1ViOGlmN1krTzhxL0xiNlZFTzJW?=
 =?utf-8?B?SS9ndDRPWjBFVFJuQlUzc0hRNUNOYlltSmhZa2srSFZCMG1tS0hXRExtanpY?=
 =?utf-8?B?Z2pWbkR0Sm1wQnRVcVFTYjR0bU00U1AyMlM0bWM3SjhPdW5NdThwK1RNb1dL?=
 =?utf-8?B?TVJGVlh1eUEvZVNXSG01NEtEeUNyRVgwT29ibFQzSnhWcHUyUTNWaUxyeFZp?=
 =?utf-8?Q?gGHQF4?=
X-Forefront-Antispam-Report: CIP:51.107.2.244; CTRY:CH; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mx2.crn.activeguard.cloud; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(35042699022)(14060799003)(1800799024);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 19:30:27.5707 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e8dd1d-38eb-4575-c12b-08ddae9e9488
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19; Ip=[51.107.2.244];
 Helo=[mx2.crn.activeguard.cloud]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR2P278MB1112
X-Mailman-Approved-At: Thu, 19 Jun 2025 01:11:17 +0200
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

On 6/18/25 18:16, Tom Rini wrote:
> On Wed, Jun 18, 2025 at 05:44:29PM +0200, Pieter Van Trappen wrote:
>> On 18/06/2025 15:57, Tom Rini wrote:
>>> On Wed, Jun 18, 2025 at 09:15:54AM +0200, Michal Simek wrote:
>>>>
>>>>
>>>> On 6/17/25 11:23, vtpieter@gmail.com wrote:
>>>>> From: Pieter Van Trappen <pieter.van.trappen@cern.ch>
>>>>> -		debug("fpga: incorrect parameters passed\n");
>>>>> +		puts("fpga: incorrect parameters passed\n");
>>>>
>>>> I think all of these should be moved to log_err that you should be able to
>>>> control verbosity.
>>>>
>>>> Tom: I think this is where you want to go right?
>>>
>>> Sounds right, thanks.
>>>
>>
>> Right I will amend accordingly in a v2.
>>
>> I'm trying to compile now that it's more than some tweaks and I notice many
>> (fixable) errors in the drivers/fpga files such as missing time.h includes,
>> spotted by gcc 14.2 (x86_64). I'm on the next branch.
>>
>> Is this due to my gcc being too recent or is something else going on? I
>> don't mind patching these in case that's welcomed; let me know.
> 
> Just further changes on the next branch which your changes are exposing
> I guess, separate patches for them would be much appreciated, thanks!
> 

Thanks but that's not the case; I switched to the latest `next` HEAD 
which is your commit ce2a7fcb and I get the same error, see below (one 
of many). Maybe due to my config in which I enabled all FPGA-related 
configs? Is is there a `allyesconfig` pipeline somewhere? Sorry I'm new 
to u-boot development and I don't think patchwork is running pipelines. 
I'm further investigating, I'm probably doing something wrong although 
the gcc errors are correct AFAIK.


drivers/fpga/spartan2.c: In function ‘spartan2_sp_load’:
drivers/fpga/spartan2.c:145:22: error: implicit declaration of function 
‘get_timer’ [-Wimplicit-function-declaration]
   145 |                 ts = get_timer (0);             /* get current 
time */
       |                      ^~~~~~~~~

