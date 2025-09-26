Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E597DCAC5AE
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 16:10:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 643F3834D4;
	Fri, 26 Sep 2025 18:10:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="bsCS6yGI";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="bsCS6yGI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AC6F836A3; Fri, 26 Sep 2025 18:10:32 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8AE483448
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 18:10:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Harrison.Mutai@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=cxGWgso5tWAeffwqNTCfKNTJTEca2q471hTr6FUgfvuxvpBegcLNt1U9NBO+RuwLFN/SfYoLtvAMCMZPVHau3sxeAffGHjGs6Vn7sgV3Hhd4C7ZrsHQOMdDF8X4+k7lHZ72/U9Q6pIott0xl7Bg81GKcbx/uCcsCluhkIm8g8tDSDJ8/Ipljev+ih/hH2D+GIfOngnzzf/kim9n0E8tll1cLZ+pUsS6Yw6lyvChbvo3bdXEcWS7eXEwf3+aTenLA+d+QO7+NI4c2sGy9yzwJo33m9kRs3jDz9IfeBEsBUrouspzJhV819s6JG0tGFVMuXzJkmiCn9+crKPd3c0XTPA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rn98KZGSfDIWACqJEyIMQHfp6GpyStcoL9+SnLg7NR0=;
 b=KZBIV/p9qjXri96ILtcnYaudkSbu5zTzuml5nyKgX1is5+M72eiV6wrlJ7eiW+9XCEH1CTtcl9fP4btEOB1UvTKpBkvGB1rY5q++PaZxfbYsvWUZjOYkZp9KbE80J0/Qw4qKzorC2YTUVsEsccNqaP7DY3k0SAB1Ur9kjoNDG2nDBmtjAYvFogpoNqDUh1ds3XoOfF2P9uDrRxfwEacGUNNkRcrP9oRQxc3/SrxI0802OqQB3EwXJQJvGdJ046Qiq8pQ2Bf9Vg66l3Hlh/xAGf9Uc2yXv5NdI+xDthmsP6ZgrFFNCkK5vIGSp79fcBwsoqSIRQ7somdOKQ/YF+RUGw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rn98KZGSfDIWACqJEyIMQHfp6GpyStcoL9+SnLg7NR0=;
 b=bsCS6yGIWpeC6IurFl2IgnQqVK7cx/0urZ3JLssoGnPuc1vbnHm59uuyuCTuKSJONdNpQVwRexkw33lPAUzE0sjugzUTzNF9pJF4NW6DV1hlW3vgNPk+LRuRWEBiEoGjQrYaRfpj/j4/oiDSVfCO9hWpQFDy9xvzSYsRK0JB81Y=
Received: from DB8PR03CA0029.eurprd03.prod.outlook.com (2603:10a6:10:be::42)
 by AS2PR08MB10082.eurprd08.prod.outlook.com (2603:10a6:20b:62f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.13; Fri, 26 Sep
 2025 16:10:28 +0000
Received: from DB5PEPF00014B98.eurprd02.prod.outlook.com
 (2603:10a6:10:be:cafe::eb) by DB8PR03CA0029.outlook.office365.com
 (2603:10a6:10:be::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.13 via Frontend Transport; Fri,
 26 Sep 2025 16:10:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B98.mail.protection.outlook.com (10.167.8.165) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.9
 via Frontend Transport; Fri, 26 Sep 2025 16:10:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dR/L57500X2l1PEkiRdjg8GgNEn9OtkZuoaryXqlnj5jRd9HjPAeNfoA5SDGrm4ZHWPy3uyggxFucGBbpFeyQTBPQVokUcogqyKDTwfXbzSVKQAZqiABOfwoJNjyWhhsb50wRfF4upJ9vepGIcqKavfXKyHCSi+26Y/XECRGLrnlTPAYU7Td6EV7a4h6C62fYA+kRcgE82KDP6d+yZ0etlEPGRNaI2GwXE18uYPYRzeIiWybOjxEIW4Z7Y6X5whFnlmrigLmxvFs7TfwlpuaeiPyLBjoiNq+kGviebroEpUjbPo8Tnrb54bD4x+rTfnW2qktGdNkqqDKtlY6W+XDSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rn98KZGSfDIWACqJEyIMQHfp6GpyStcoL9+SnLg7NR0=;
 b=IE19gpcvJyemrsaGRjrJAjpDf6/kzU8Jeq0aabPnKg1PCS+bP/CSSRqveSLJC/6Qvp5puYRIFZsHiD3v6wkgOKvwdHp5WETN/dKRUzVJHvVsexyx1cKUiYVdFM7ZuSKdHwmCDEo3a1hWDbWvL1t4GEGoA45y8L4eRbF3fuFh1LwGeq5wMOgpuFVGJ6LhjS7jKjHr3feQq9pVulWmrzGE4EQcRgzJZr7oJNOTlp6NP2xToP6ZMgtr9wHiDfVZtxQjrlP2W3d43p/2sNinAahEq91d7R6olTfUun5hj2230qRTSTBMFlU2rEJmvG9rC4Hya0k2B0koiSRwRRil712kzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rn98KZGSfDIWACqJEyIMQHfp6GpyStcoL9+SnLg7NR0=;
 b=bsCS6yGIWpeC6IurFl2IgnQqVK7cx/0urZ3JLssoGnPuc1vbnHm59uuyuCTuKSJONdNpQVwRexkw33lPAUzE0sjugzUTzNF9pJF4NW6DV1hlW3vgNPk+LRuRWEBiEoGjQrYaRfpj/j4/oiDSVfCO9hWpQFDy9xvzSYsRK0JB81Y=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DU4PR08MB11188.eurprd08.prod.outlook.com (2603:10a6:10:571::11)
 by DB9PR08MB10380.eurprd08.prod.outlook.com (2603:10a6:10:3d8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Fri, 26 Sep
 2025 16:09:54 +0000
Received: from DU4PR08MB11188.eurprd08.prod.outlook.com
 ([fe80::5926:9f0b:ea5d:24df]) by DU4PR08MB11188.eurprd08.prod.outlook.com
 ([fe80::5926:9f0b:ea5d:24df%5]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 16:09:54 +0000
Message-ID: <ada31617-374d-4f87-97eb-c91da2c4e9b5@arm.com>
Date: Fri, 26 Sep 2025 17:09:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Transfer List Checksum Correction and Impact on Bloblist
Content-Language: en-GB
References: <b7c008b2-0a1f-4971-af4e-428faf818d4e@arm.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Simon Glass <sjg@chromium.org>
Cc: nd <nd@arm.com>
From: Harrison Mutai <harrison.mutai@arm.com>
In-Reply-To: <b7c008b2-0a1f-4971-af4e-428faf818d4e@arm.com>
X-Forwarded-Message-Id: <b7c008b2-0a1f-4971-af4e-428faf818d4e@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0396.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::23) To DU4PR08MB11188.eurprd08.prod.outlook.com
 (2603:10a6:10:571::11)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DU4PR08MB11188:EE_|DB9PR08MB10380:EE_|DB5PEPF00014B98:EE_|AS2PR08MB10082:EE_
X-MS-Office365-Filtering-Correlation-Id: 13f82ab7-5b14-462c-ef04-08ddfd17346e
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?TTNBWWt0VWtRTkxoVTdPdDZNc05ha2VlcytRVTFLUTA0L0hUa2F4akh3QXlR?=
 =?utf-8?B?WG5HZDRUWkNKWi9tN25lN3NZMGJsNUYybld4ZnM3VE9CWGVid1NKQjFqb1pQ?=
 =?utf-8?B?b0NnKzBiSUNUcVJHS1oxdDd4MitkODFSRW8vYTB3RkxjNHNPSXBlV2F2S21I?=
 =?utf-8?B?djBhUmRxOFROc3NZa1c0a3F5eW05dzJtU0QvN1BEbzFkYTNtdGlnaWlGYS95?=
 =?utf-8?B?eS84bjB2K01pOWJ5UXh5eTF6cjlEMlMycE43S25xbEYyWm43K0NkQlRTOGoz?=
 =?utf-8?B?QnRxQko0eFAyN0ZZNE80YnhTcmR0ZUduOVJiOWJnOU42MFptZFNVd2dYL25R?=
 =?utf-8?B?dGx1WHNPb1RleWVvT2hNeWM0K1pBVFk4ZVdmZzVIWTdrTnpnODlPdWptblZl?=
 =?utf-8?B?UFVMcEo1WlNSNGJ5UnJJMFg4aG9jcG1XOVFyN1ozV3NpTEwwUHhOaGlMMDZ1?=
 =?utf-8?B?UHJqOUhvT05zdGNlWE5ZTUpIUy9HSElNVTlPZStZZ2xjTlFwSTRnZnhLbm8r?=
 =?utf-8?B?TDRGMTRDSmJ6S2lVZjNibFR6dEQ4bjRiT09ITUtLYisvWURDczByajlCSm1Y?=
 =?utf-8?B?OVluSHc2aXNRVHkvQi9xb1hCaVNma2FxSUtlMHcvM1FQaTZlM0k4VVRkNFZD?=
 =?utf-8?B?cHFNSWt2anlXSkVaN2VjNXBzWU9VeGVGSjREQVBvRlZ6OWFYS0k3cVV4V2RI?=
 =?utf-8?B?S2tmS2ZSdHIyUmJMVE16Y0NYRmY4NHdlNmw5NlZMMFpwMWNKd2pFUFBlckY2?=
 =?utf-8?B?WXBKeDJ1UHZ4Y1lteEMzU1JPbmx1bm9iWXBCblhjV01YdmtQQ0tjUHVCbGl4?=
 =?utf-8?B?ckdjaXNmMXQzeVRsVFdsMlBaT2EycjBvL09ubHYwa3FNeDg1VFZkejFQNlZn?=
 =?utf-8?B?ell1bElpUjVmZDJDWGFaUENRMzFOM0JUQ2NHTDY1VlcxblZydzhuM09Xcmxz?=
 =?utf-8?B?L2dRak4rVGxvbVFUWXlwK2VyUVhnTHcvNnVLRjBuODdEY0Q0R04zT1ZrZThn?=
 =?utf-8?B?K05wc2s4VVlJcm1hVnd2UnZ4R0ZxY2dFbkRCRG9XeWpJOUFjSFBLWnBkekhS?=
 =?utf-8?B?cXFRb1JCZjByeUM3Ny9KYWRuT2hnRlNhc2Fsa005WnhwbEppd2kvcng5YndU?=
 =?utf-8?B?RkZsYnc5Z3NEeG9HNkhTUEFNb3NoS0YySE16OFVUWE55Sm9wSktiMDl6aWpE?=
 =?utf-8?B?ZDZOTkpqQkpsbEU3bUhzYTlzQ09UZHA5VjA4MHNVNjlFNFl6eHNaZnh5b2FM?=
 =?utf-8?B?UTZmVDdZQllGcUd0YWVsVlMzbEVVYXlwVnpsclplQ1h2VDAwUkNLd000dGN5?=
 =?utf-8?B?b2ZzMVliYzU5L01qZm1ER2YybVU2bDhsMXJ5MXY2WmswMHJJWlo2bDlFWUlx?=
 =?utf-8?B?MUxKcDUrbm9ML3BVN3VtQm5TNzUyQXFuNXZJYkxVZEIxZGlsMTcwWlJzMzQ2?=
 =?utf-8?B?dDI1Q3BvUm90Q3hmNkF0OEkyK0xaOFpVZldpT2dLMzBPaGpnbTd1L0FDKzI4?=
 =?utf-8?B?TE1QNXpuS05DU096VVBRUklJZnVUTWxyNlBTVS9oakw2WkRWeXBSTEFsUGJt?=
 =?utf-8?B?RnVna3BNcjBGd3RGYk9UZ1EyNm00OFEvNFZYVWliQ09QNVFRNDYzQmRQUHpx?=
 =?utf-8?B?eVFQa3Btc3FZTlBWb2FHMDRLNnZtMnVOTGRmV2wwMy9rUVAxVnNxSkovWWVi?=
 =?utf-8?B?R3huVHBOSlF4a1FMR09lcVZjd2I1cURHd1hsMDRCZVNiclh4UnQrdDlPU1BQ?=
 =?utf-8?B?dVNyME0va3F4ZENrZE81dWdCUU8vRU1aT2Y0WTdZM0w4MUoyTkFaRm5BNGZN?=
 =?utf-8?B?Mi9lNW9HN0FncWl6TGd1TjhZMC9XQURsMmd0QVJYQStrMmdwTC96Nzc2VWxk?=
 =?utf-8?B?Mm1IOVZ0RGxzazNxWURTRnBJT2NPUjBvdklBVXpsQXYrRlE9PQ==?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DU4PR08MB11188.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB10380
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5PEPF00014B98.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: ff32f52c-97ce-40a1-05b5-08ddfd17213b
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|14060799003|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N0ZNQzBmYmdRUTNtT3NmQWt5UDc5Sm1nSEp3cGdpNTJsNlJWeVFKRmIvb2Qv?=
 =?utf-8?B?UmUvWW9wUC9vNXJPOU1sZ01PUFdCT0pERUpuZzFNbThnR3lWUHV3a0tiSWl6?=
 =?utf-8?B?UnI2eUwrWkJ1NEFJUitqS3cwMGdOdHVWNlhDRVIrdWw3MTdISm5UNXQ1TkVF?=
 =?utf-8?B?RVNXS01aaW9IZzdDWU5WWGZvbmhDaWx1TjFqTzhERjd6VzR5SHg4RHFueWw5?=
 =?utf-8?B?d1AwNGc0Z0RGN0pNNGRhQjdid3ZSV1pzaFFxRTVscE8vYkhJS3JOTTlqb2Jy?=
 =?utf-8?B?VWg0MTRFaTZQWWVWY2Rsam03QkZmbVdFYTdkTldNeDlzSmg2V1FXb1Z3Vmpx?=
 =?utf-8?B?c1Qra25aeU1nVmVrbk9tVnJoMnZyK0VBak0rQWkxeld3SER5dXBvTzdsd2po?=
 =?utf-8?B?SzR2Z09WdVdydGh3WW1TZEZwSEdXRE9qT1FCZGNMdzcvaFBqN3RxQXZrWnZT?=
 =?utf-8?B?dUhjL1o3YklXVG9kTC8veGhRZWFWQVhJOVZhQTRJYncxOGdmaGJJTkxaVlFW?=
 =?utf-8?B?eERTemloN3IwRWhvb3lURDUvUHQ1WXdyZ3hwbTVueVl2d1FIN2FBTVFlYmZp?=
 =?utf-8?B?b0tlcEJvbDJwaVlSNmd4VndrK2lGQnd4UUx6TEVNZWJpdm5zMWpKM1JSc3ZD?=
 =?utf-8?B?VzNDNGtmTWJaYVNGZEI0RElBT1hwUmxZWEM0Lzg4MUlzYk1kcDQyYTh3OHJq?=
 =?utf-8?B?RW0rK1NKZXFyYitqRkVWOFR5WnpHaDVZTktLcUZIOUY5QXlwbXFNNlR4cHhx?=
 =?utf-8?B?QkU4enJhaWhKWEQxa3IrbGFYZU8zVXU1WmpKK2FaTUcyb3p4aEdXMEFmd0JJ?=
 =?utf-8?B?VUpFNmEzdHNDT2ZUdlM2a216OUtkUU9PVE1vSnN1bmcvUUgzZkVKTTN6Rlo5?=
 =?utf-8?B?NE5UbDBLVTVmOCtzMGQyOWozTE9KaExiSDZnNkowM1BtWm5LY01hZTQzVXpx?=
 =?utf-8?B?Nno5L2ZQYkZqVi9KbEJtd1ZMZFFuYzdYRnF3VktCSjNBR1BXWnB2Vm01WjJn?=
 =?utf-8?B?VnFsVFdqUElGT2lLQStVT3NIdWhXa05jMW5LaWlMV2lvOG1rdDQ4VUp6cTdm?=
 =?utf-8?B?dEhHODc1aVpEUFUvb0swNzlYcERFVStBaml4SThFRndsd1d1RDdOOTJjby9D?=
 =?utf-8?B?dW1QbHRPQTZuT3FzQ0c4MlU5bnYrUHI0S3RpVkM4b1JRTXM2amxISnc1dW0x?=
 =?utf-8?B?VnFHUFl2c0NnckFYK0RFMERWYmlXeThXUGVZQ2hUbnQ0M0RrUmtsSzlrTm02?=
 =?utf-8?B?MTlZenBlSnVZYndHVmtNcVRKZk9MMG12MDl2anRwSXh4aEVJbVhsRGJ6ZEFS?=
 =?utf-8?B?MWNrVi9rU2U0Y3ZOQmdtZDBIT1NkSk11Wm45eWxrNElHNjR0TE95SEpFdmxV?=
 =?utf-8?B?dndxc3F5VTdScFo0aHFySVFzMWpuaDJ6d1NlRHE1UGNwNEdubUVxTkNraHd3?=
 =?utf-8?B?bGdiQXNxbXNqUGc4SWtkRm1WRmNpaHA2cUswSUpmYnRzYlU5Y0hndUYzVUN0?=
 =?utf-8?B?dm95dG12VXhYWDQxbUlzdjhpc3V1WmFoNXMzZjdBa0tTNlZQdDFqb0RoTHR3?=
 =?utf-8?B?cnkyMXphR0daeURQWVRIRlBlSDEzME9Vekt5Z0xoUHlJcmNrM2J3cmE1bW9E?=
 =?utf-8?B?bm5RaStJMHFUZzB6cXYybC9MM2hGbWljdlk1N0VqbWNKeGZIcUpKRmcrTUQz?=
 =?utf-8?B?VWM1N3NUZWozMWs3MEkwQ2QyT21WdEw5RHUyZUJOeTBCa0wxalJTeElDdFJj?=
 =?utf-8?B?eStXLzREUm9FK0Jyd3pvNGpvaGhsWXUxckIrR3NoUHVyZWhFQlhidVFrempM?=
 =?utf-8?B?eWJQZkJpbHA3Ui9mYkU2U2J1ekdwY0ZDUUtnVGpmM05CcU5YaFVBZ01UT0Q3?=
 =?utf-8?B?dVl1djhtb3NCT2FFeko5QnEyRThHYkVvTXNKdVJtNzRnK2JjREo2aEZNNFo3?=
 =?utf-8?B?K1cza1VHNkEyMHJFU1JEZUd0WFBCUGZFdXd6TVFSaC9jQjN3Ui80cEV2TjlC?=
 =?utf-8?B?OHc5bXRJZ3VYNGE1M09iZjdtNTZqY09vUzM2MjJwYjc4ckVqSk1HeWxPSmZv?=
 =?utf-8?Q?4MUsGZ?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(14060799003)(376014)(82310400026)(1800799024)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 16:10:26.1701 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f82ab7-5b14-462c-ef04-08ddfd17346e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B98.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10082
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

Hi all,

We recently applied changes to the transfer list library [1] to correct 
the checksum calculation. Previously, we used a simple byte-sum 
approach. However, we later realized this contradicts the Firmware 
Handoff specification, which states:

> The checksum is set to a value such that the XOR over every byte in the
> {tl_base_pa, …, tl_base_pa + used_size - 1} address range is equal to 0.

This discrepancy creates problems when interoperating with Bloblist.
Should Bloblist’s checksum calculation be updated to follow the same 
XOR-based method?

[1] 
https://review.trustedfirmware.org/c/shared/transfer-list-library/+/42548

All the best,
Harrison
