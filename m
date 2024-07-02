Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 833B1C3064D
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 11:01:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABF6A87EDC;
	Tue,  2 Jul 2024 13:01:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=weidmueller.com header.i=@weidmueller.com header.b="kBQXbkti";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AEF48824C; Tue,  2 Jul 2024 13:01:26 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20707.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::707])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 648D087EDC
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 13:01:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kR32impHUft0EJnng42K1D9L+auKcV+fcsSBunY/FbxXXflBsJXjOCIO6oGVm7bnBkUXYX8ZKB39dv96LjZCt0i08U+djtnOiBPtIS1AtZtnlfnMRHAZqAgkBXrp0/cIpNG1+FQNmeuS97sfQo/yPEscfAoSYnvLvApwy87OcIHautnfBZkaVye36BYb6jdh2J+S77MgqGZWaE8s2yMJWipkbuwe4hCCcPfK16Hn706iiATcsyvW2NDESTY/E1rKbwxh5Yx5oGn3M+PQNNTf2xMy/H/i8Utp9Ltun0a4GctA2JqYYP811b/tROJmCJosAsK8urLPK/sSzhCeHhHb1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkO87whq1Ckc8ncU0g+iQ242Yo99uJFAfJYGhPNLfbk=;
 b=Y0xy0cFHHsmCXdD2GQ96uyaFMgM+ayHyB39lfkzjKLkqqKjVHwYd7Ahi4dp9Fg9Rg3SLgX3bWBBs5xAaoyG5cH1D3qoSvQeaahjl9euogeSlonEhjBR75DGi+CwzKnvD4izDZCqoD7JQcTAKuzh2NFBpTLZP1c+m1BWrUsbFKok2oUXHWBGZXfY52FzOPY2uAMqESXb22T/vl3apTwteKoTMFPQujC+KC7UAklKPHdVfiok/i/6tgQbD9UtWZPhMOxDTRQ6uSoC56yR/rwzQ891jDD3YGrmuRU2T/zxfPEnMtjJAJurJn8SW+y3Y6imbaWyMH4Q+WaPG6mme2rZAyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkO87whq1Ckc8ncU0g+iQ242Yo99uJFAfJYGhPNLfbk=;
 b=kBQXbktiRpU1TQkF29JSj8Ip507iG+DzhO/7xvDkcSQ8Uep+EjxVrSiRX6Uer9ulTBLYn2wWsScRXlEtwni6y9VLY5ZwACTqbf+BijKU47iXlTJLkdOzi0GiGtPcJ5SwMXN51hyCA0s5GVnrQXydwoEAVbZwNNcxjxnxly0DbizbS863/rulf8zvtp1Kaps8PSunKeVUMLqStb6cyEPXyq8F8uQ0c+XRYtVFePVZv6QxTvfBPt3TPKzoMR8/GH8IaD20oae5VB+QUVQuEerBw2+XLx9e7lIus2XUFSqZ4384PoIBpUbn2kBRQlhHIKaZJprdNKplFJhMgz0rCj3DLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AS2PR08MB8748.eurprd08.prod.outlook.com (2603:10a6:20b:544::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Tue, 2 Jul
 2024 11:01:21 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6%2]) with mapi id 15.20.7719.028; Tue, 2 Jul 2024
 11:01:21 +0000
Message-ID: <6dc671c5-2f2e-4cd9-817b-5aa50e5a4232@weidmueller.com>
Date: Tue, 2 Jul 2024 13:01:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Import environment variables from FIT configuration
To: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: Niko Mauno <niko.mauno@vaisala.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Emmanuel Di Fede <emmanuel.difede@cysec.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ivan Orlov <ivan.orlov@codethink.co.uk>,
 Joe Hershberger <joe.hershberger@ni.com>, Joshua Watt
 <jpewhacker@gmail.com>, Kever Yang <kever.yang@rock-chips.com>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Piotr Kubik <piotr.kubik@iopsys.eu>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <20240702064834.9543-1-lukas.funke-oss@weidmueller.com>
 <d609b656-19db-4dc3-956f-7dbec5de9975@cherry.de>
From: Lukas Funke <lukas.funke-oss@weidmueller.com>
In-Reply-To: <d609b656-19db-4dc3-956f-7dbec5de9975@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::6) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AS2PR08MB8748:EE_
X-MS-Office365-Filtering-Correlation-Id: b880ddc1-b791-4d5d-a1af-08dc9a864e88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K3BnUHJiQktOL3VMazNnS1gxWVhqOFhwSThBeWRPalVFdVR1TWcwZnFQSENO?=
 =?utf-8?B?bWxnY0VMazF5cGlpeS8ycmkxdFJTVTFUQ3VGVzdXYml2RXFEZXoxMVF4eFdr?=
 =?utf-8?B?RG1HNkJwaE8vRmpjdExsN05nY1QybCtZSE5BMUNtZXB0cGxhMERwd0NsU1hp?=
 =?utf-8?B?cklQUGhrdmM4VjlPZ0h3MzRNeHlvU0RrVkUwQ05GbnpDeVozWmR0ZXk2WDRW?=
 =?utf-8?B?dE5NWnNJUXYzc2RyZVZqb25lSmlrb1I0ckxveUQvcHRJUjA4V3JMTjByYmox?=
 =?utf-8?B?UUZ6OXRSQnBLWCtHaDVtclIzU29LdEpUNkxGTU9MWStwajhKU2VCc0dlcW54?=
 =?utf-8?B?WCsxL0N1S1oxUlYvTXNuWW5qdzZ2MnQrbEptSFdsdE1MUy96NkMyOXV1L0xz?=
 =?utf-8?B?R09acEpMTFlRTzdKZlByNCsrQ0NnazE1OEFaR1lRM2Z4K1N3OGhlSFhiOVY4?=
 =?utf-8?B?UUwxQ0xQS1NjNk51UTJjRWM3RjNqYjl0dlhxQk5ISk0xK0ZZOXMrVjUybjNk?=
 =?utf-8?B?Q1kvdVdDZEhsc25vbUJGYVhsWjBCK0hMTU1hMW84RWl2V3NrblJsejJVS1Qy?=
 =?utf-8?B?Q3lxSkhsY1hWMFN0NkpydVBtWUM3RlB3eExrSUNOUTRpWFVGRUpaVGMzK0xu?=
 =?utf-8?B?aWdnMUhmUjdnMjVadFpGbjJPWmZ6VVE0SERJZGRXN2RRc2ZYbndWVG05R1FU?=
 =?utf-8?B?aVVuMUIrUHIxRXA2N3J1RGxQMDhqSzF5SkdENnJocEZNQ1R2TFdoOUJiNHJW?=
 =?utf-8?B?WUJiVEFNY3ptY1hnQjhuZDNnZlVtQlpCUkU0Q05oWHJUTmZISTRJQmU2M0VT?=
 =?utf-8?B?bC9pRzFJSlA0aERPMHBaUHUxZmh1SHRYcEJvSE9xU1FDNXROYzEwTHB0NzJW?=
 =?utf-8?B?cFp0T1ZCUUxyblYxNmQrU0dOSUI1SEVHTjBFZSs1UTZQc1VmRkFQZWZtVWdD?=
 =?utf-8?B?QXUyck1FVHJXRHBTeTJqaFlmTEVQYjJ1Yk9YeXJxczRvUUhjVmllWUFER0ZN?=
 =?utf-8?B?TWpFMEdUNzFyRW1aalF1ZEhDWlYrMUhXSERSZ1R2Ylcvb1RsMEFPbFI1L0o0?=
 =?utf-8?B?eHRLUTVuSDJyNFM3SHZWcXFCeFRINE9uVFA1T0Ewdm91eUpBREg0dmR2YmpU?=
 =?utf-8?B?OExwNFZ1cVlndnNCRHFhTWdSWXhDeHk1MWdqTUdNYng0TUVOU3Z6VkJCMEhJ?=
 =?utf-8?B?WU1VWExETUhPUXYrSXRiSmMvb0Yyb1NmWTJkODMzTmhpdXVOaW5wTnhaRlpl?=
 =?utf-8?B?SHZMSnRrMlVWUWxoWGNzeWlySlR0T3lSanBaYk45MFE5N1FMRzJrSlVsb2NG?=
 =?utf-8?B?VU56cjJ0R0lLdUl6SUVNKzhLMVpJeTRHQVNTL0dYY0xDdFJocVB1c3RCQ2tL?=
 =?utf-8?B?a1lzaVpyZDBpTmxXNlpVcEpRaUpNaUlLQ25tRGs3QXhuUGlxMVZtT1pXYUI2?=
 =?utf-8?B?cnRzSm5hYU9VNjllTHVMR1RPRWNkaEVVcVFHNHdCZURMUkVPTVdHR1l0UlQr?=
 =?utf-8?B?NFJNd2hWNU45ZmdLMWtiUk93Ny84ZENKMzZDRklKZ2psV1hjNUtxSWZLdVlQ?=
 =?utf-8?B?V09mNm1pL00vRDljclZIYVhtQWk4aEgzcXdxQTdzOGZrZzlCNzVGbmR4OW1w?=
 =?utf-8?B?VzA4b1FIMUIwMWc0TUlJbVp5aWhGYmU1T1N5NUFLNGR5c25jWGErbXlTekcz?=
 =?utf-8?B?YmwwRTZzcTZMa0ZYSXh5b2daSTY0MlZlYkRzdnRGSldEZloyeFNYRTJUQzlp?=
 =?utf-8?B?VWdHRUlkQmU1S2p4RkFEM0xHckZCRVNaZHhmb05RY1YxZ1o1RjZBTW5IdXJO?=
 =?utf-8?B?dTloSXh2cVZoQk5qTmJWdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGZOdFFWNko4eUF6WExnNDhNc3JoL2xTOXhjQ0dlWHAxWkFnTUIwOXBZNW5H?=
 =?utf-8?B?SlNQcE5UNld1NDlublprUmhyVy9ZanZKNVRzMWVFcTMvMElmb1dBdUwzTDM2?=
 =?utf-8?B?OWdBczJwMUp6UEJWVGRpWitCTkRqYkJZNHFxT09QSXF3Nm1MTHlWTlp0UHRx?=
 =?utf-8?B?QlpEeGxGWFA0TDY4QlMvaS9UbUNHT3ozWkFzUm1LU1J2WGFEN2hWTTlVUTV3?=
 =?utf-8?B?bnJ0MTVrNDlQRjF1VzlGei9MZU9zajl0clNhbmRKVDJNME9oaDQ0US96cjBQ?=
 =?utf-8?B?Ui9uTlp3UVpIOXBZbHBaTlUvdExxYVp1ZWd5ZC9BaTV2R2lBamMrUTRuSGdk?=
 =?utf-8?B?MW9RNkoxS1RJT0hXR2JmSW9nMG5OYVRmaWVrandGTlAxbkh4MHZUaFhQUVJH?=
 =?utf-8?B?cHo2WlVUU2V4eTA5dUIvMEZ1WWFJN1JMZjBSWVhpNi9qTmVIVVUycUxtUE9U?=
 =?utf-8?B?N3RPTnd1YUJSVk5Ody9zSFN1WmpwTlVMWDVlQTFKYmdqRE14YjZyRXhpUmdy?=
 =?utf-8?B?WGVDTktGckpMT3FzRi9YaitOYWk5TmdXMytweGxDMXU2OUJjRC9xdW1OUzhP?=
 =?utf-8?B?QXY5Mi84QTB1czJUcmZha3NIZzFtc1pDeG90RDBBcUdRc2pGVzk4bFJKdDVv?=
 =?utf-8?B?ZGp4cnNybGYxSmxuM2VJdUVqcVBRb0F1NWpsU3BFREZsaUNWMU1uNmRpWEhN?=
 =?utf-8?B?TkVmRXZ5M2tFTFV3cnM3UFoxaVpmL0dVNGRObnVvMjJidjBGcWpRTTE0MzV1?=
 =?utf-8?B?UWFWUGwxOFE2L3dQREpQVFBKWDlmRm14VUN1aElzYjNzNGhxM1pIY1hFYmZU?=
 =?utf-8?B?aEZjRVk3YXp3VG0xR0lNTW03OG5iZFM4Q01mRWxEbWp6TVY3RXNLN1NDckxW?=
 =?utf-8?B?Q09vT0V4YUEyRDMyYVpDYkRneitobThteGkyR3VzZUlreFV0VU94azExZXVV?=
 =?utf-8?B?bUp1Nkw1UkxqaURaY0NMMTloSFJBcVZjUDdMc0owbkdyb1ZFWlJVVVRVaVBL?=
 =?utf-8?B?bXNta3Jod2dGYXJKSkEzMHJBSmV3UXNNaFREeEpLdGFmd1MxRHJadWFjZ1ky?=
 =?utf-8?B?WTl2cmc1ZEVDVktiV2huZTJDa09qNDF5RU1DbUQ5R3c2djNtMEFtc0R6SnIy?=
 =?utf-8?B?QkZ1d0pKTnpQTU4rY2t3OFArck5QMWlnZmwrSGtUZ3NEWjM4aEtVdTVFVXh3?=
 =?utf-8?B?NTNUVXNxczlXUjBHN1hRMmsyUDJyWS91eXRFUjhZdUNWL205alQrT0xJY2hI?=
 =?utf-8?B?VkdnMGpnbUdMRmJIRlFQK2lsNHBSN3I4U1ZiSXg3UVBINS9pcUR5OUEvaG5H?=
 =?utf-8?B?T0FyTEo2bXNNNnNIRFlaVy9oN3dlVW1oay9uaU00NTMrNC9xaXZGY2kyMGZ4?=
 =?utf-8?B?M3ErQ2doY1F5WUV1Mk1tRWlvUEZpS2R2NEN3b25tZE5lV3d1cWNLQndZYWVF?=
 =?utf-8?B?cEF3K2R1M3JUdXZYSDJaaC9tYXA3UnJzQUJEZFNYem1NVnB0d0NOSjFXZnhl?=
 =?utf-8?B?VXUzSVU5U0ZSaXVrSldmY3FHRVFybU03WEk5Nnd1cFRtM01HYWpzUVIxUG4z?=
 =?utf-8?B?S0orVzgvamFxNmlQR3JnVGJvVDlaWDBqdWF5Qkp3UEVrVW1YUU0rTFB6cFFm?=
 =?utf-8?B?MmV2L3ZVM3lFR2NMQ2pzaGtMWTlzQzdTaEJ0cEhFMWE2VFpHTE4yN1dLdUdE?=
 =?utf-8?B?Q2NjbWUxdE8rQ2J5N3A4bVd4dFVyOVE3eTljNnlkZmNTY2VYTzhQRnVWVmZZ?=
 =?utf-8?B?bnJNZmVxOUVma1JsdkFoRWRjaTVVUkpYWThxK09qV0RpanJUU1laaUdaQXdu?=
 =?utf-8?B?OTNXeFR0LytHS3Nwb3kzOWlmU2tUTHRDZS85b3RqSzRUS25JaXpXLzF3cWMy?=
 =?utf-8?B?bk8rSkRTbEhzSy9sWmlmRTZJdkY0THAvT3pPUUZRbEFwaUVOdmtMY1dCZHh3?=
 =?utf-8?B?cUpSMkF4SEprd0NZNU5JS0VaazZjTUxrUWZLTWVERU9lejRQZy82OGVTSmtL?=
 =?utf-8?B?eTZ5bjR0TklHU1ZNa1MxMlBjVGFqMHNwNDlZSVZGU2YwWUpxb0o5U3N5Ykhm?=
 =?utf-8?B?cnluUDV5dzBxdjlRWjBiSFQ1eTBQQ1JCZ2NkMHhKMDNLSnhaRDN5S3k4R0h1?=
 =?utf-8?B?ZXl2b05BeEdWbEM1T2gxTjNYYTR2amNBMDh6eE5sTWJ6cExWWlhxVldxUUZr?=
 =?utf-8?B?cnc9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b880ddc1-b791-4d5d-a1af-08dc9a864e88
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 11:01:21.4645 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5C1hCLbmbXnAcCVwz2fewXRatEAV/nF+Kfj6NT2xeCvsZnEpEPSLEssypwNR04P9TipLzUthCSWR+meTysXCbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8748
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

Hi Quentin,

On 02.07.2024 11:16, Quentin Schulz wrote:
> Hi Lukas,
> 
> On 7/2/24 8:48 AM, lukas.funke-oss@weidmueller.com wrote:
>> From: Lukas Funke <lukas.funke@weidmueller.com>
>>
>>
>> This series enables U-Boot to import environment variables from the
>> selectd FIT configuration. One use-case is that the overall build process
>> enriches the FIT configuration node with dm-verity information which
>> should be injected into the kernel commandline. U-Boot will then read
>> these (possibly signed) environment variables and put them into the
>> actual Kernel commandline using variable replacement
>> (see CONFIG_BOOTARGS_SUBST).
>>
>> Example:
>>
>> Config:
>> CONFIG_BOOTARGS_SUBST=y
>> CONFIG_ENV_IMPORT_FIT_CONF=y
>>
>> FIT:
>>      configurations {
>>          default = "conf-1";
>>              conf-1 {
>>                  kernel = "kernel-1";
>>                  fdt = "fdt-1";
>>                  env,dm-verity-args = "dm-mod.create=...";
>>                  env,bar = "someothervalue";
>>              };
>>      };
>>
>> U-Boot cmdline:
>> => env set bootargs="rootfstype=squashfs root=/dev/xyz 
>> ${dm-verity-args} ro"
>> => boot
>>
>> Kernel cmdline:
>> Kernel command line: rootfstype=squashfs ... dm-mod.create= ...
>>
>>
> 
> I think FIT supports storing U-Boot scripts and running those via 
> `source` command (usually the file extension is .scr).
> 
> I do not know if there's support for automatically loading this .scr as 
> part of a config node though, but if there isn't I guess it'd make more 
> sense to support this case than to come up with yet another implementation?
> 
> What do you think?

I wasn't aware of this, thanks for pointing it out!

This patch was mainly inspired by the dm-vertiy use-case which requires 
just env-variables and no (complex) scripts.

There is currently no mechanism to source/run such scripts automatically.

How would you distinguish between scripts that should run automatically 
und scripts which are sourced by a specific board/shell-script 
implementation? I guess there are good reasons to not run such scripts 
per default. I would also change current behaviour. For env variables I 
see no harm.

Please let me know what you think.

Cheers
  - Lukas

> 
> Cheers,
> Quentin

