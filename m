Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF79C87FDB
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 15:05:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8201B83278;
	Mon, 11 Aug 2025 17:05:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="IDC0sUDr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5564583278; Mon, 11 Aug 2025 17:01:38 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB7E983253
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 17:01:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AU1RwahzsbwPygbeRDXkjfN/6MKFAku5Zs1RRwSet86/7Y+KgQAUGqSYxKGrLeLYgY9KvDPcVjwBm2MPFevBPdXG3pHaSWxT4AtOT9FMa3j9JlHQ488AeXSxUyvH59OAgB2kOJlF3KZMrUaavzhGy51xZh3RzeRSCo7ZMz9l4xlZyZs8kvTOPjj8qulZHIb9bPF4AWZmThkmIaTu0R6g1ECWklGcE2HLi8+VYOYmEJR51x2ouCBwjvOou9YP2VIXQpLjkoIf8tokXOYaxYRMVpFVmlaDq4r87C5d3cuiFPAe+j3B0CDAId2X1CK7P9E3jf+7CTFjV6TjVHtzdrMiKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+VUwtx+xdSZ6a5weDU4IIN5mbMjRcjLqi4gtaGwgBtE=;
 b=JNX8R6pOjqlr/b+8Ywcednnk02JTc68qRGgAkZHaIWmnfspUg1ViAOsCUx7ipR4zqcRAuj48rNSCUTLVaqrnAsyqpLEk4WC0bxxTD15/i2cbGR2qNrP66x/Q+h99K0G5Z/9Pe2Fe5qFqBYGcvY2NOhvOVmr9f+TsndVExES9eWBDPxt2C/eJsVqacQLWDQTYCFxNmKkl9kLj1PMLTKkHedWHoGSPPqrjWcNYV8eJ325/9CO7XHESS5yncbhM8oyWef7qCMQgLD8ShcFd8FoErLPUCCQlbeO/sPnVYZ7IeiL1lf0UUL01DgEc83edRKN9X52+cClPBBLKZSReUjER3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VUwtx+xdSZ6a5weDU4IIN5mbMjRcjLqi4gtaGwgBtE=;
 b=IDC0sUDr/QOrEerabbT8b24kr1ESJVMtrsWVlzJaulNeVgYISaAqJ+9+YICJJrdWr/b5hSQOavgYg7q/vRatm8GAqo0YhGPXBvzRAlJj/7OoxC1EJRWObiMlnyAR3F2lCXE9eS/qZvdGWpZhtT9kFRZiCLqJBr1/76irNy1WsnM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA4PR04MB9294.eurprd04.prod.outlook.com (2603:10a6:102:2a5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.9; Mon, 11 Aug
 2025 15:01:32 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.9031.011; Mon, 11 Aug 2025
 15:01:32 +0000
Message-ID: <e19f94a0-4d69-4c63-bbdb-2598e3f5bf68@cherry.de>
Date: Mon, 11 Aug 2025 17:01:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] board: rockchip: add rk3368 ymd8_mb support
To: WeiHao Li <cn.liweihao@gmail.com>, u-boot@lists.denx.de
Cc: antonio.borneo@foss.st.com, mk7.kang@samsung.com,
 gregkh@linuxfoundation.org, semen.protsenko@linaro.org,
 mikhail.kshevetskiy@iopsys.eu, bb@ti.com, justin.swartz@risingedge.co.za,
 lukasz.czechowski@thaumatec.com, robh@kernel.org, tharvey@gateworks.com,
 clement.legoffic@foss.st.com, marek.vasut@mailbox.org,
 dinesh.maniyam@altera.com, patrice.chotard@foss.st.com, festevam@gmail.com,
 jerome.forissier@linaro.org, andrew.goodbody@linaro.org,
 sumit.garg@kernel.org, ag.dev.uboot@gmail.com, rfried.dev@gmail.com,
 joe.hershberger@ni.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 seanga2@gmail.com, lukma@denx.de, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org, trini@konsulko.com,
 WeiHao Li <ieiao@outlook.com>
References: <20250807074419.336752-1-cn.liweihao@gmail.com>
 <20250807074419.336752-11-cn.liweihao@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250807074419.336752-11-cn.liweihao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::14) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA4PR04MB9294:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a95e2fb-dda8-4819-5ed2-08ddd8e7f523
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|7416014|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RFMxQ0h1dkVTWW1SNU9zY2o5R2s0WVcxdHpoeTQ4ZmZqR3VVUGdVVnAxSDVD?=
 =?utf-8?B?SGtSc2pVcmlGeXZyYk1zaDJKYyt3bVlZYyt3Mkh3NEp5NCtCWHkxU3RVRjVL?=
 =?utf-8?B?N2dGbkEwYUI1dHU5RysyWHFZY0lnQlpjbkE1YUlqaXFldG5XUS9HeVBqVVRJ?=
 =?utf-8?B?aXJUUmlHcHg4TXNYd1lBcjUxbnZMcFYzZDJ4amhROXltTU0wUzhLOG9hdGlY?=
 =?utf-8?B?clVNdkt5dXIxdU5tSkt2MDhSZ01PSmR0d0xjN0JBOGFtMy9kcDRHakhuc0RN?=
 =?utf-8?B?UXBzZFdsbnlGZ3VyNkJOVFM4aHlrd2hpaTNuRDR4MW9XcTd3WU9YQVpjdk9j?=
 =?utf-8?B?cy9tUEFvYVNKTEM0NVJtNEZNczB5dkxCU0RQNUYxOVhtb055ZE9XY3ZZYzlP?=
 =?utf-8?B?eGo1TmpvMzdoSm8vS1lDRndNTzE1TGw5WDl3R0tDaERHOURTUEpEa3dydG1Y?=
 =?utf-8?B?RlFXZWtxS3l1UUxCTGdTY0JVK3hQdG4wM3JkWGpORExXUlFoSHFENTdJYVZR?=
 =?utf-8?B?VVZKWVhVa3AycXZYQWhSYk03M0tMU2NhWlkyenBzK1BpUEt4ZW5Gc0R2VlFm?=
 =?utf-8?B?WGpkUDlXZ3F6cXZBYithbERMN0pQOVc0a00xKzlMbUkrNTdSbXNORkw3N0xS?=
 =?utf-8?B?WEhCYUE1bFhXZXBpWm1vRDI0WTg5aTVZWklxTy9IV2xhcHlkNHNIcG95aW50?=
 =?utf-8?B?MHdxK0hqbGF6Zlp4eFZFQi9HOXlYRUh2QWNYRlE0Mjl3ZzhxYkZ2WWQxZk5F?=
 =?utf-8?B?ejV2c0VHNThNNmcwamVEMEZvSmhRa0pPSkEvSytlOVRpbkZhR2lkTWsvWU9v?=
 =?utf-8?B?WHQ1ZG55elRXNDFYRmR0TE44by80Q3BGSytWaFBpbFgwVUxWTnkrdW12OXV0?=
 =?utf-8?B?V2JET3cvcUszR21tUUN4bDZaQ1prM3VUdkt3ZC9oMXUxTzhqbHRsWDlGZk91?=
 =?utf-8?B?dHBSeThPOFVMVDBUQ3JoTU5CSDRvaGUvRzhxZlZ6U2YxUGpMbTRaeUMveWly?=
 =?utf-8?B?NFZqWDZGRkhDNkRsckVSMGNDMHNGVS81RFhDWWRkcWF5V2VINjNOQldXMjRS?=
 =?utf-8?B?NnRhV3htbnpjb25adFVvZUtFUWNNdDlGTjdFeWpVYnJuOFJvVHZWS2JBZXlm?=
 =?utf-8?B?eHYzNm53OGlPekFEYTBCVW04ZGh6U3hkVERVbWNVYldyNVIwc2phWVY0NWdY?=
 =?utf-8?B?T0dQcXRhY240Q3hHRElyVldSY2taM1ZhN2l3MERVOG9Td0VuNW9IL2lSWDJz?=
 =?utf-8?B?TGVKRW5uZ1hGaFYrOHFTSWxPUTczTG54bHB0VG9ZWEMxZTZOb3FHTFE1SElm?=
 =?utf-8?B?aXo3R3ZFaHNBTXB2MnhkaHY5ZVlmUnJkMzVhSmx3V1kwMjZuR1hObHQyNHln?=
 =?utf-8?B?MnNWbmxhV2ttMUtuMmdGZnRkUDd0K0UwWlRQNzlwSmVRL3pxTDBGMnZwSHcv?=
 =?utf-8?B?aUtaTHdGbkM3cElBVWJjS0loOVM4NndRYWEycmlZeVU0MVJsNzFQaWx1RVhV?=
 =?utf-8?B?dXNBZktUTmV1bXNXNmwxRFhod0pJRzA1dnNIbFhBVllVSzZkb2ZEcXptWTYr?=
 =?utf-8?B?VnpDV2xZazN6QmwwMzhiS0RYbGs4RzhTRFNEb0hNV0N1a0ZMK2RnWkVHOEpK?=
 =?utf-8?B?ZzRmSHdwTnA5ZWhUQ3NSQjN0Mm9QUlo2ZlFUcmJ6bmJCQlpHa3VBNHNiQ3Rj?=
 =?utf-8?B?Sm9ISTVoTjlONXo2Tk5qQ3d6bjdOWTdKN2lEVUVBVnlKcG95c214YjZhTzd6?=
 =?utf-8?B?Y1hyclFpVXVJSlQ3STMrSURnMHFoaUNPTENUbHNQa2VJTS9vTjB5blVGRlFR?=
 =?utf-8?B?UXJFRXJnN3c3elJZODJwSGpyV3lkSUxTdytLSmdPVHc0aUt6djdSQ0lmS3F3?=
 =?utf-8?B?bGRmK0ZLVVBIdjVndU44clI3R2tMSkY2cEdxekcvQkloa1Myd1R6YzNZZnhW?=
 =?utf-8?Q?5OzxF4MbwXE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(376014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlFmTnFqVTlCNmNLd1p2b241dXFBbms1bTRHcmRMbm1uekZiMTF1cTRoUG8r?=
 =?utf-8?B?U0s5dEZzNEhVanQzN1kyN0E0dlo1R2YwNllFVFRiYVE3K2xJaWdsZ1IwQXBY?=
 =?utf-8?B?c2hMWlNWWm45ODVsRjlleU1qejludU8zZ0t4UWxwdUI0SERSRHpvYkJuM21o?=
 =?utf-8?B?MGpkQjUrU09tOUNIOURNOEoxd2dOMm8zdTBMS0ZqbHEvWndLT3dWUEtNZDds?=
 =?utf-8?B?S3hHb0V1NDlOdFhHUGlHVjFMUllJek1vcllETEFsM09DOERmSE82R0RTdXVo?=
 =?utf-8?B?eUdnTmN4Q0lZZU5vYlN4QzMrRFFmVUZsN1hCa1Y1Sng3cVpMOUZKV0hkL1FB?=
 =?utf-8?B?OURZdXdaakdWblhxQlVJNXc1U25OaWQrb2NEWERRaHNyeC9OZ0NDZGZRVXlU?=
 =?utf-8?B?Vjkrd0xTc0JYTU95Yi94MFp1MEcyb3Vhcnd5V2hzY0xLRER6MkRDNVR6WXUy?=
 =?utf-8?B?U3RLdHFMbmpvVU5lNjZ4TVcydUNxczNrY0FnVjNrQjczcTR3R0NCU3dtc1Vs?=
 =?utf-8?B?WG1pUHZkZEFSUXZxajd3YzNFN3g3K0NqeGZnendheHgxczdmSEJNZy9NNUFw?=
 =?utf-8?B?MmgzYkFFUE5DTmNZd3BEb2dWc1I4Qjg4TlRHd0ZuRkE5bnpPbEh6RWFxLytF?=
 =?utf-8?B?UlRPd0MzOTJ3TEh2NXhxSjhaUUphVFdBS2lCa2dUd0EzQWJLMW0xV0hFbTZm?=
 =?utf-8?B?ZU5rMjR5WUFFQXc0WFZNYVh2OVo1dUdQR0hidW1lek1sU0pHTlZBS254NDRE?=
 =?utf-8?B?WDU3ZkJlTkJDNE40eHVTV0djVTZsSlBRU2E0b0NacWd2QWhGdE15Z3ozRnE0?=
 =?utf-8?B?NDVRYld2R25vSTRabStjSHJDNUdrbmNCOTI0MDRRaFN0NTlKdmNzbjE2Nkpt?=
 =?utf-8?B?aDFYemxENGc5ZmV2ejNkTzAyMVNXVFF6cTZ5T1VSYmNtV1F5Z2NsemROd29a?=
 =?utf-8?B?VW9Vck5EZXdRRzVRYkZ4UlBmY1NZV0JXRmFQSC9mblJNRER0TklKYUs1MGxR?=
 =?utf-8?B?UEQ2amFGM21DWUpUVUhWRE92UnprbjFQK2drOWJMZm5yWHB4YkVzK0wxbUFa?=
 =?utf-8?B?M0ZJVUdWSkdKaXBKamlxRzNNK0taUGlIOWZCTEthcnlKMnlQeloxdnhzbldx?=
 =?utf-8?B?NHhWSFBWVXdwUGk1Ky8wYXNPbmo5TlhtNFFMRFlHS2lIL0tOd0FiUGNsYm9x?=
 =?utf-8?B?T2xQb3ZzVERVdy95N3FzTWYzRFZzbjZ4QmpyUXl3Ym9jam54WEdOWjVXbHVN?=
 =?utf-8?B?WUhPSWdpU3dORUR0ZEx2YWtKL0E5bU5jZFlNelBsemFBbDlGZm9VNkxXVUtl?=
 =?utf-8?B?Q2Zjak9KRUgxeFVVemdoV2hubG5LbWhnOWZpQkNxQll2RlpaR0VLQjlZMDFq?=
 =?utf-8?B?QUplQzdZTzFxUzdIMHV0T3U4YWlCR3BkTVB3R0VVWlFpcGVTcisrS0JBVk5k?=
 =?utf-8?B?ZlhOZVFLOU05N2VYMmE2Z1d2UUxmb3pKY1g0Z2hTK2JZVzlqQjVmdlN4VzFJ?=
 =?utf-8?B?MGhnTlJHUjBvdFI3U1Zpb2c0NTRJdFh3RzU5c2RmVkhSQUNrVzRMU05sNDFp?=
 =?utf-8?B?TEozWVNobTduS0RsWWVocE8yeTBIdGxWcDFmZSs5TmZnYUVXWHZTSldCZmh5?=
 =?utf-8?B?b3l5a2Z3ZDlraUpKbVRlUXBsZFRqaFQvYm45dndUZ29vSGRCNmR1ZlBkUk94?=
 =?utf-8?B?THB1a0NFaXU3d3Y0dUZORmtNWGVSZlprM1FxRjBEY09neElqejV1bmlHVGlt?=
 =?utf-8?B?SWx3a0JCbmNXeW5VMlpVNGhLajdFU0VwTlR1aythK3ZTSnF6aUF2ZjMvZk9T?=
 =?utf-8?B?UzlUUk44dU5EQ2ZtNlpqUzdZUTdTR3dleENQZDN5akY4VEgzMDFuUXlsMjd6?=
 =?utf-8?B?ZlRKRi95b2tySjE4R0psTGhnTVJvcTR6elZBTzE0eFlBU1hEUU1RWVFuZGpO?=
 =?utf-8?B?enF6MWNWTjcyNFRoN0RQU1ZBT0pRZ09selNGUlVBQnZuSm13TCtRbFBFbyty?=
 =?utf-8?B?UDBLbnp5anJ3SGc1Qll2dXNFV2k5bWJ4dnM1bTFSQ0xpQlhDYnZNcWFMV2o0?=
 =?utf-8?B?aC9tMGt4MkgwaHU0czVVM2dOMVk3eFFzU0llNmhidFJtQm1iZkhSOWVVeCtX?=
 =?utf-8?B?SERpbmdBMnFtV2REQWR1RTF2dU81aVpwMWU0bHhYcU0zdXp0UlpjSlVQaEVt?=
 =?utf-8?B?QStIOWY0Q1lKaW8wZmhXYUkxalRFN1BDSDgvdVNMVEQ4cEdOeEg0Q2JMMDJ6?=
 =?utf-8?B?VDFld0IyTXNiRGhpUVBvT1BqSkFnPT0=?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a95e2fb-dda8-4819-5ed2-08ddd8e7f523
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 15:01:32.0039 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fZ++68n2zhNvJmhJrR1z+qWh500nYplJ/ntyRuZrbLDC0U9C2wAxJHfi5DLXZpRDWVcwgqWz+kswCGXX4X+DDDynr5GwhR6XnCpYE5OhRSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9294
X-Mailman-Approved-At: Mon, 11 Aug 2025 17:05:27 +0200
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

Hi WeiHao Li,

On 8/7/25 9:44 AM, WeiHao Li wrote:
> [You don't often get email from cn.liweihao@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 

Please always include a few words in the commit log.

I believe the description of the board as told in the cover letter is 
good enough, so start with that maybe :)

> Signed-off-by: WeiHao Li <ieiao@outlook.com>
> ---
>   arch/arm/dts/Makefile                   |   1 +
>   arch/arm/dts/rk3368-ymd8-mb-u-boot.dtsi |  44 ++++
>   arch/arm/dts/rk3368-ymd8-mb.dts         | 326 ++++++++++++++++++++++++
>   arch/arm/dts/rk3368.dtsi                | 258 +++++++++++++++++++
>   arch/arm/mach-rockchip/rk3368/Kconfig   |   6 +
>   board/rockchip/ymd8_mb/Kconfig          |  12 +
>   board/rockchip/ymd8_mb/MAINTAINERS      |   6 +
>   board/rockchip/ymd8_mb/Makefile         |   7 +
>   board/rockchip/ymd8_mb/README           |   1 +
>   board/rockchip/ymd8_mb/ymd8_mb_rk3368.c |  19 ++
>   configs/ymd8-mb_defconfig               |  72 ++++++
>   include/configs/ymd8_mb.h               |  11 +
>   12 files changed, 763 insertions(+)
>   create mode 100644 arch/arm/dts/rk3368-ymd8-mb-u-boot.dtsi
>   create mode 100644 arch/arm/dts/rk3368-ymd8-mb.dts
>   create mode 100644 board/rockchip/ymd8_mb/Kconfig
>   create mode 100644 board/rockchip/ymd8_mb/MAINTAINERS
>   create mode 100644 board/rockchip/ymd8_mb/Makefile
>   create mode 100644 board/rockchip/ymd8_mb/README
>   create mode 100644 board/rockchip/ymd8_mb/ymd8_mb_rk3368.c
>   create mode 100644 configs/ymd8-mb_defconfig
>   create mode 100644 include/configs/ymd8_mb.h
> 
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 0dc7e190eb..1dfd1c5236 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -73,6 +73,7 @@ dtb-$(CONFIG_ROCKCHIP_RK3368) += \
>          rk3368-sheep.dtb \
>          rk3368-geekbox.dtb \
>          rk3368-px5-evb.dtb \
> +       rk3368-ymd8-mb.dtb
> 
>   dtb-$(CONFIG_ARCH_S5P4418) += \
>          s5p4418-nanopi2.dtb
> diff --git a/arch/arm/dts/rk3368-ymd8-mb-u-boot.dtsi b/arch/arm/dts/rk3368-ymd8-mb-u-boot.dtsi
> new file mode 100644
> index 0000000000..925264e620
> --- /dev/null
> +++ b/arch/arm/dts/rk3368-ymd8-mb-u-boot.dtsi
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR X11
> +/*
> + * (C) Copyright 2017 Theobroma Systems Design und Consulting GmbH
> + */
> +

I'm quite sure Theobroma didn't work on that, and not in 2017 :)

Please remove us (Theobroma got renamed to Cherry Embedded Solutions 
last year) from this copyright notice and provide the appropriate 
copyright holder there instead.

> +#include "rk3368-u-boot.dtsi"
> +
> +&pinctrl {
> +       bootph-all;
> +};
> +
> +&service_msch {
> +       bootph-all;
> +};
> +
> +&dmc {
> +       bootph-all;
> +       status = "okay";
> +};
> +
> +&pmugrf {
> +       bootph-all;
> +};
> +
> +&cru {
> +       bootph-all;
> +};
> +
> +&grf {
> +       bootph-all;
> +};
> +
> +&uart2 {
> +       bootph-all;
> +       clock-frequency = <24000000>;
> +};
> +
> +&pwm1 {
> +       bootph-all;
> +};
> +
> +&vop {
> +       bootph-all;
> +};
> diff --git a/arch/arm/dts/rk3368-ymd8-mb.dts b/arch/arm/dts/rk3368-ymd8-mb.dts
> new file mode 100644
> index 0000000000..661390b9d5
> --- /dev/null
> +++ b/arch/arm/dts/rk3368-ymd8-mb.dts

Are you planning to support this board in upstream Linux as well? I'm 
sure Heiko would welcome it. If so, maybe think about selecting 
OF_UPSTREAM for your board once the device tree is merged upstream and 
appears in dts/upstream directory in U-Boot? It may not be easy to do as 
no RK3368-based board has been migrated to use OF_UPSTREAM yet.

We typically do not allow (in Rockchip) to support new boards without 
OF_UPSTREAM, but considering how old and how little activity we see for 
RK3368 maybe Kever will let this pass?

> @@ -0,0 +1,326 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2025 Weihao Li
> + */
> +
> +/dts-v1/;
> +#include "rk3368.dtsi"
> +#include <dt-bindings/input/input.h>
> +
> +/ {
> +       model = "YMD8_MB";
> +       compatible = "rockchip,YMD8_MB", "rockchip,rk3368";

The first compatible isn't right if Rockchip isn't the actual 
manufacturer/seller of the whole product. I couldn't see anything on the 
PCB picture you posted on your wiki but maybe there's some information 
on the casing or elsewhere?

[...]

> diff --git a/arch/arm/dts/rk3368.dtsi b/arch/arm/dts/rk3368.dtsi
> index 4c64fbefb4..77ff551681 100644
> --- a/arch/arm/dts/rk3368.dtsi
> +++ b/arch/arm/dts/rk3368.dtsi

Nope, this we won't allow.

If you add support for a board, don't modify the device tree of the SoC 
in the same patch. Please separate those changes from the patch adding 
supoprt for the board.

Here, because the rk3368.dtsi already exists, you'll need a patch per 
logical thing you are adding. There are a few I could notice here:
- hdmi
- lvds
- rgb
- edp
- dsi
- vop

First, only add what you tested. I believe this would be DSI+VOP only?

Second, where did you get all the info? I don't see anything in upstream 
Linux's rk3368.dtsi so it must come from somewhere else? Where? Please 
specify this in the commit logs. it would be very nice to have this sent 
and reviewed by the Linux kernel community as well.

[...]

> diff --git a/arch/arm/mach-rockchip/rk3368/Kconfig b/arch/arm/mach-rockchip/rk3368/Kconfig
> index a7be30bbd8..1d05a6784f 100644
> --- a/arch/arm/mach-rockchip/rk3368/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3368/Kconfig
> @@ -21,6 +21,11 @@ config TARGET_EVB_PX5
>            HDMI video input/output interface, audio codec ES8396,
>            WIFI/BT (on RTL8723BS), Gsensor BMA250E and light&proximity
>            sensor STK3410.
> +
> +config TARGET_YMD8_MB
> +       select BOARD_EARLY_INIT_R
> +       bool "YMD8_MB board"
> +

Please add a help text so we have some clue what this board actually is.

[...]

> diff --git a/board/rockchip/ymd8_mb/MAINTAINERS b/board/rockchip/ymd8_mb/MAINTAINERS
> new file mode 100644
> index 0000000000..a5156b8be3
> --- /dev/null
> +++ b/board/rockchip/ymd8_mb/MAINTAINERS
> @@ -0,0 +1,6 @@
> +RK3368 YMD8_MB Board
> +M:     Weihao Li <cn.liweihao@gmail.com>
> +S:     Maintained
> +F:     board/rockchip/ymd8_mb_rk3368/

This is also missing the new device tree you added which you need to 
maintain.

> +F:     include/configs/ymd8_mb.h
> +F:     configs/ymd8-mb_defconfig
> diff --git a/board/rockchip/ymd8_mb/Makefile b/board/rockchip/ymd8_mb/Makefile
> new file mode 100644
> index 0000000000..a3a34edb43
> --- /dev/null
> +++ b/board/rockchip/ymd8_mb/Makefile
> @@ -0,0 +1,7 @@
> +#
> +# (C) Copyright 2016 Rockchip Electronics Co., Ltd
> +#
> +# SPDX-License-Identifier:     GPL-2.0+
> +#
> +
> +obj-y  += ymd8_mb_rk3368.o
> diff --git a/board/rockchip/ymd8_mb/README b/board/rockchip/ymd8_mb/README
> new file mode 100644
> index 0000000000..de980f2f23
> --- /dev/null
> +++ b/board/rockchip/ymd8_mb/README
> @@ -0,0 +1 @@
> +see board/rockchip/sheep_rk3368/README

I don't think that's right.

Remove this file and add a proper entry in doc/board/rockchip for this 
board (or its own documentation file like we did for Theobroma boards, 
up to you if there are important details that typically differ from 
other Rockchip boards).

Cheers,
Quentin
