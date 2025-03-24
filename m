Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07FF2C36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 12:44:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A6E58186D;
	Mon, 24 Mar 2025 13:44:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="hfeZyXWO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CC3B8186D; Mon, 24 Mar 2025 13:44:45 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68C81817EC
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 13:44:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ce96vjk/BSwawNJ55hU+zMA5vNc6azv4AIsIZZVV/y/zL4bWpuHZ3dKyapJ8TJiMfL4ngsqLS1YzH13ZVlB0B//+709V75uO2G+Ic3Z+iKGsob9jX16Bvt5V/cJ8YU4SLKAvJwVpv0gnsD9eoMgo/baNr/9VoCkW1zKS/p/h1bJ7/U/pbRpOxX5os7ULOq2oavg2+RtQYq4hPfg0p8zHqO1qFC+CwY41+OWNzJaThskHGFFchlGXJ5KKdQzXOpklDNjBQCTUvJrlqc8uw/UA+iR8f55+RYbwG1Fj0UowJYSQu7/S60DZG2b3/ryy5EBk+OwF2ozRBoHH3pBKruKj3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGF9W7OzMaUGgPnAzM2NeCvuXDEE5UV1/lG8aKd4LD0=;
 b=Y4Ii/PFhf/1i72f500GOZxQjdM9/1Xau0lYWQnVl3JEf0rmnd6UryahaJEQAbogxV648l7f2uWIuAdTn3gY2//cv5BM6E1gAHQ1fJB6vQ6xi7ZpY6OWKh2OvlX8+eJ32vVzcvnY9thIJV90F37A8ACdi8vkunetQ+ITmvEnWTC8PQlNgigM302dBZYUWCrxof8IVFaylTMfSGwS5TcGnxImRCgqGsFrnKOexPqHwWot85UKmDWauTN8p/PgstIemNmRkqIDpiu4SZlFIqDXs/5th/VjepCA4gDi0dVX86ZCXFktP57FoK8Kylo5d5CnqavxPlpFllaPPGyu1aomT9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGF9W7OzMaUGgPnAzM2NeCvuXDEE5UV1/lG8aKd4LD0=;
 b=hfeZyXWOJz5BhBaEVKl12wDVNjgcRCY+tnMCCrBeqeopEI3TXPTOGaAKd4JnmrqG2yPgRKlaq6xAbZfC3nd+NeooYRmjH/wrRGy9u3+Jo3dOj1rkolocn6wHZCTwqt+nwODJNVetG8Fe8tQ4Qpu6VV22lr4bvuu4nWFcyqGwc9k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI1PR04MB9809.eurprd04.prod.outlook.com (2603:10a6:800:1dc::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 12:44:40 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 12:44:40 +0000
Message-ID: <d609f060-4068-4b61-9be2-57c695d7fc23@cherry.de>
Date: Mon, 24 Mar 2025 13:44:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] env: Rename SYS_MMC_ENV_PART to
 ENV_SDMMC_EMMC_HW_PARTITION
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20250322215624.18994-1-marek.vasut+renesas@mailbox.org>
 <20250322215624.18994-5-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250322215624.18994-5-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0086.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::22) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI1PR04MB9809:EE_
X-MS-Office365-Filtering-Correlation-Id: 9366af57-6c6d-41e8-0a63-08dd6ad1a4e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnZlMEZkdHBnSC9pZUtEQlVxWlIvOHk1SERsME9wL0xPdHVBRTY3ZDJYUFBN?=
 =?utf-8?B?dEtWbDdlQXN3Zkt2emhHQmc5bWdLaGxibnB0NGlrTnFiOElhbHJPYWlEMFNn?=
 =?utf-8?B?czVTaFVxRTBVYlpZR0M0ZHRCSU8xY2VPZDhZYmRjZkJTS013VGFpdGZvYUJt?=
 =?utf-8?B?cFk4MUo4b0pCV0EzUzBvK01HYlVCYWFic0M4a0g5cUpwNG41V21NejZYMHF3?=
 =?utf-8?B?S1lLYTIwZ1lIbW91NG9GZUZ5S0FCNDJEbVR1Q3ZpdTN0VDZtRWR4dkE4eUIy?=
 =?utf-8?B?WUtVbkptYzF5UHlDdWtlTVNlcTFXcFlnVkM5cDVKNmd6a0g3Sks1QXRNRElX?=
 =?utf-8?B?TUw2aWlVVjB0RnliWDhIQ3h0MlNoOXNFU1NJQnNLVEZXZzZSVm84YTZZakkz?=
 =?utf-8?B?a1A4bVJ2Wk9xUEZ1a3ZBNlFuRVZHV0JaRmZlUzgyZGpQNDI2NFlVUXhJNjkz?=
 =?utf-8?B?U1BmTTIvYWV4enRuY2tJZFNMblJlN2M2elJHYVIvd2N4bWQxYk1tMytXWkpt?=
 =?utf-8?B?NWppbjJ1NWk4ZW4zNlJQbmFJazBpNHJRQjNHbUJ2TE9ya0R4a2Fyb0NSMGh2?=
 =?utf-8?B?b1BUM1ZqSlBZS1lBU1k3NDZGNnJoUU9XMjFVQ0pVV2tTVzRCb1QvQXV3NWVK?=
 =?utf-8?B?R3UxdFJuS0Z3Y1VjcUhPUkRVaGFVZGp6VW01eEVGUnVteHM3NXpwTWpTME9a?=
 =?utf-8?B?dUJ3a3FqYjlqcjY2bmRzd3JOd2kvYVVGbkdRRnVjV0hkZThtaWcwVm9oQzRv?=
 =?utf-8?B?NmhqYk5Bc3grRDRTd0cyWVUxWGZBajloekdqSGhONHptV2lreTQxcHhrb2Vy?=
 =?utf-8?B?TTY0bi94T3gzS2J3NnowYm05eGZIUnQzYXV5bWQ5cHM5czFnREJHK1J6d3dO?=
 =?utf-8?B?bG9HL1ZISmEyZkFXcGtIUWR6dmw1Y3EvK2RRUlp2cHV2YmpuYWtGdGsxa0dQ?=
 =?utf-8?B?ZXR0ZFNuenR1WHRvZU1HcG1sNWh2NkJHdkZ6NXBZbDFMd0JaK256d2wxdFZz?=
 =?utf-8?B?SUVwVzlCQ290SDIvSjJKQXNybWp4QVdMSi9SZm5WZTdqQzRpL0pKTGhzNXVO?=
 =?utf-8?B?YU0xTlJyMlhLUUpESXdXOUtFL0E4WHdvVXFRY1lVQURpa3A4TmF1d3RGR1Vv?=
 =?utf-8?B?MkR0NUhjMzNKYUlNM0daZDZTbnNlVm1tTklDbzdHTzdFODBIWTc0ZjNDeXFm?=
 =?utf-8?B?Z2N6aUN5RGdSUDNzZTdqelJBSGoxN1dnUzFxcVZLMW0vK092MkNlUGF5ZHF1?=
 =?utf-8?B?NXlHQ3h4ZlN4emNGVloyRWtobE1QbnVsL0g2eXZKR1J3MDYzcnZMem8yQlhh?=
 =?utf-8?B?UEMzVzNHYUYrRHB1UFdQc3dUUmRoRVZZSjRUL2RSY0dNNm9OL3gzQ1JEb2JU?=
 =?utf-8?B?N2tCSWwyQ01MczZYWUZIR3V4YytGMGd1MVVwaDREbWFjRVB2ZlR6NGtnVWZI?=
 =?utf-8?B?a3F6czNwSURxcStGNno2T2RMMmlRM2dZcUM2RWxDNzFuRTV1SlZBUE9LOS9n?=
 =?utf-8?B?R2ZTczFRYWwwTG5vdkF1cEJldGNFM0NsblphN0pMUEJRelkxNDhsd3REWmtn?=
 =?utf-8?B?dmhLNmZKcUIzTHB2OVFCWWhMTFN6THNqbHRBSGxOUGVOb3UrbU5RT1BVZTBO?=
 =?utf-8?B?eUFnYUdvUTF0WVVaOGdoWWtNOTYrcDhReDJNVGV4U3hMbnYxRUhRTHdaait6?=
 =?utf-8?B?VWhIbHFIMkNDRlNnci8reFIzenRzODR4MVEzY0xydjMrSUhEOGpGMmRDT1g3?=
 =?utf-8?B?NFlaRGFBQ09tT0hsNTVzT2NtcHQ2S0tqK2wremFseXF2Wm5CQjA0V2hGY1Ar?=
 =?utf-8?B?M3p2M2IzSmsvV1piQVBNL3l3NC8rNS9HYU1GSGNsWEcvQWI1dGREbDFJSHZB?=
 =?utf-8?Q?sixnopqaPIkPL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eStYVU8zSG9WaFhYQWYyRVcraDBZeDhRZ2RSUkJabmU3V2lhZzhUY2R0UXZo?=
 =?utf-8?B?T0owMzV4N0F5c3B5Q05FN0wrUncvVzRBdzlWY050a0c1UDluMWdvSzRudEdx?=
 =?utf-8?B?dGVOWjdkem85eDJKK3FkSVNVNjJYMWs5K010RmU5RXI1TnUzUFY5bUhHYkxy?=
 =?utf-8?B?SUllMlRacmdiSVFNSXlycXBYbXZFd2JablN6ZGxjUUx1OGhyMWdFSXJ3akhl?=
 =?utf-8?B?S29SWjY1bHZVa2hYQjREZjEvczF0WlVPKy9NemhQK2FYOVM5ZGpXWU1ycU9l?=
 =?utf-8?B?V1IzQ01HT1hSTitnblk2WGdiUFdnamJITXBKc05ta0ZWaUhxbGw5SUcwdFdx?=
 =?utf-8?B?YlZONWhyNmFuN3JwaWE0ZUh6Vml3L2tTRTVOREhnTWxvejZEKzBzMjJqcEtJ?=
 =?utf-8?B?VDF1cUhwWTUyYVZtdzlpd1dZZFltSEtHMlpsNmN6STNDWklEMmVkc1N6a05F?=
 =?utf-8?B?ZllhcWJ0ZFV6aFpKRjBnQjJtbjAwSzlJWVNSVXloZHp4TmZzSHJZRlVjc0pM?=
 =?utf-8?B?ckxqbEVqVC80cTAwRkFOK1pCSEZjRGljRElpRWNCMXEwQUFyaTlWV3BPZXN6?=
 =?utf-8?B?K0x0b2h0dzZNUzc3T2NCZDJ3bnFtMUlOUzZIamgzVzI4KzNrWS9JNlA5N0hy?=
 =?utf-8?B?azJzUkwzbzRkSVpISEdmWEdTaEFSMHl3aEMvc0xQY3VjSFhWR05HTVpMVG9S?=
 =?utf-8?B?THdDRVVEODhWWFE2SEJqZFZtNmRRWDFjUy9YZUVYRFpYSUJnVG5mV01Zb1ZU?=
 =?utf-8?B?cHZKWU9YZUtMbWFlemxTSmY1UUdaVUxiZDF2M3U2dEFOdzRQRlpGS1pmMlB6?=
 =?utf-8?B?UUtGS2tJM28yYVF6ZUN0YjlZdmxGWmxGeXVsWXgvcGZ3SHE4YlRCeHZrSzUx?=
 =?utf-8?B?WXdsaktqMm04M2x5ZFBON3Rvd3dFSzgrK1R2SGFrd0hzNnJ2SlFkRnM1aS9v?=
 =?utf-8?B?dERoVFUzMTFMbWhLTFN6Z1A3SThHRHBYUzVjdE9MOFhPUVVkSElUY3B5cVg3?=
 =?utf-8?B?ZEJVRVZFSDNMQXJjbEJyc24rTUplSy9QTW52YzV4U2dwNGgxRHlJbk95dHFC?=
 =?utf-8?B?Tm00UEVPTmdQcDI5aEg3TUZpVHM2YnJpenJ0bkRDUFppbmdNL3U4ckdteVRN?=
 =?utf-8?B?aytEbHNtcWhqWUdPTVg5aTg0UUQvenNhYUdQb2wrMFN5NU53ZUszOUNCWUFP?=
 =?utf-8?B?VUQzM29uTGR6VWJUQmY5bmxVdmNCR1dGQ0psQ3ErOFVWb1lBRlp3cm1xVFFW?=
 =?utf-8?B?N0M1dlV5Q3dmQjJ4VHZuSG1RalpuQ2RKc21JRnJxK29KMVBiNXBseWlCb1RX?=
 =?utf-8?B?NlN3QmR6cWxPTjN1czdqUjRreEYvQk9mWUF5R2FENXhNblltcWNGelZtS2h3?=
 =?utf-8?B?ZmRVVU4rS05pM0RQV2ZhZC80bnBMaFhNdmtxNmpoZkJSUU1INjIxZlBoZzdz?=
 =?utf-8?B?dmxmNzdLTW5JbjkyV1pTMkh6cHNnQnJ0bkplY2t2U1Y0UHZtenp4Q3cwRE5u?=
 =?utf-8?B?L3loREQ5WTJTRkxGTXFNUDdiU2tjTmVGYjExVHlxaStXN2Z0aGpla3ltNnFI?=
 =?utf-8?B?TU5xd3FnMERsY1d0ZndkNGJrcGNZcG1LWldndlduM2N0YVY3OWI1U21Gd3d5?=
 =?utf-8?B?RlBkdmlrQlNhL1VraVhTL0gzMWFpeEx5bGVBTHhwYnJJZlRUOVQyNWNlYU8r?=
 =?utf-8?B?cVRld05JR2JsU01Db3FTSXhwRzJHcWR3WVRUTGVadmRiV3IrTy9tanBNczJ5?=
 =?utf-8?B?TGRBcndrcmhGZFZVakVRWUlSZ3kwaGk1Y3ZyR3RwNWJJVXBLdVFHTGlSNnFU?=
 =?utf-8?B?ZzBNaVpsVkpSYnFqVEhoZVF3eTg5dUJqY3dJdFFYMlhWV3VqZ24xZm1ycHlL?=
 =?utf-8?B?NGtkWHRNWDRNL2tFWTVORjRiTnpWM0RIRkdVY3Z2b1o1dllGWW95RUIzU0s3?=
 =?utf-8?B?SkZNNkpHSmQ2ZjYwN25Oa0NuMzJWQU9hNStKbjVrNnVLZ0poekVJME5ES09v?=
 =?utf-8?B?ejhMTXBUeVBWdFU0U3ZRVTJtTElkZWlETTdZdllvTXFCS3FxSmpZS3FtTlRD?=
 =?utf-8?B?cmVXZFByc2dySjZQY3Zvc1F6Y2pvcXB4cGw1RkN3NFI2aU1RS0NaV1VYdHdh?=
 =?utf-8?B?dWYyaDRLUmo4dFRMSnl6aFg4c3ZXellRUTFERTNpcEFhd3FNUXZDVnExM1JI?=
 =?utf-8?B?YVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9366af57-6c6d-41e8-0a63-08dd6ad1a4e6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 12:44:40.6231 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: djWV52wJg0wcGJvvUQ8Ss9WCqEGGfAmpllDfQ43R8d9iAbt0McbrBhPbZ4x5t+iMwImazK0wEx0kQVCsZzdaH36CyXeGrkbv4G3zJ9T9T4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9809
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

Hi Marek,

On 3/22/25 10:55 PM, Marek Vasut wrote:
> Rename the variable and add ENV_ prefix, so that all configuration
> options which are related to environment would have an CONFIG_ENV_
> prefix. No functional change.
> 
> Use ENV_SDMMC_EMMC_HW_PARTITION to clarify this is the eMMC hardware

Same disagreement as previous patch for the MMC->SDMMC rename, I haven't 
checked the next patches but the same remark would apply as well.

[...]

> diff --git a/env/Kconfig b/env/Kconfig
> index 6bb882baa9e..fbc03777040 100644
> --- a/env/Kconfig
> +++ b/env/Kconfig
> @@ -219,7 +219,7 @@ config ENV_IS_IN_MMC
>   
>   	  Specifies which MMC device the environment is stored in.
>   
> -	  CONFIG_SYS_MMC_ENV_PART (optional):
> +	  CONFIG_ENV_SDMMC_EMMC_HW_PARTITION (optional):
>   
>   	  Specifies which MMC partition the environment is stored in. If not

"which eMMC hardware partition"

>   	  set, defaults to partition 0, the user area. Common values might be

Outside of this git context:

"(first eMMC hardware boot partition), 2 (second eMMC hardware boot 
partition)" maybe?

> @@ -252,7 +252,7 @@ config ENV_IS_IN_MMC
>   	  This value may also be positive or negative; this is handled in the
>   	  same way as CONFIG_ENV_OFFSET.
>   
> -	  In case CONFIG_SYS_MMC_ENV_PART is 1 (i.e. environment in eMMC boot
> +	  In case CONFIG_ENV_SDMMC_EMMC_HW_PARTITION is 1 (i.e. environment in eMMC boot
>   	  partition) then setting CONFIG_ENV_OFFSET_REDUND to the same value
>   	  as CONFIG_ENV_OFFSET makes use of the second eMMC boot partition for
>   	  the redundant environment copy.
> @@ -676,7 +676,7 @@ config ENV_SDMMC_DEVICE_INDEX
>   	  The index is often derived from DT aliases mmcN node ordering, and
>   	  matches the 'mmc list' command output.
>   
> -config SYS_MMC_ENV_PART
> +config ENV_SDMMC_EMMC_HW_PARTITION
>   	int "mmc partition number"

Should we say "eMMC hardware partition number" here?

Cheers,
Quentin
