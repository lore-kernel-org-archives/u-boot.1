Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3EF8CA0EC4
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 09:45:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AAA48328F;
	Tue, 12 Aug 2025 11:45:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="pusx1fx9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3AE583087; Tue, 12 Aug 2025 11:45:21 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D9498329C
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 11:45:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TKmyzr5ijIpcw5TqT6AYexk47AWQogNAexEDf4aayuGKcqETWaZUjKjNx4ww54qHWHvuHCDhjmRcHg49UmM6hNWZuI45K57F98eNAhouRNfJsutaDs64BGnB4vryEMRXRh8Nu0I6u05QNcbpT1Z+DaSwfrpPXD6yzYwqaM4CVM1gPJuw/umdY8z4ejyq32/ZHZ5W+KesCSCK4jwHpJZkP31tgRgWGFa9OCRCjfa2X+VZoj7U50/OAXrpXi29DYmLRkEjeOE51MfDibAQbgUaL+0PNumooGFKVNYBEKqBbi5qpPQbkx+R/MKeM6X456O5+z2wTsm3g3+ICULUml7cHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7v6WRYSHhjJLr6lQ6/agjM8g25Ayx4anBJWsLVvNWw0=;
 b=tGCrvpp1/061KKBU9LlrscPcYFGUlWu6pGlusaU3orOyQSASKQf2Rs16O2AwoCT4rSbTrTU6UovxsfrdszXuo+RoTqAUz0aF6sRer6a/NUWWbFk0eWAqcwt4r34gj3AkqjGWbsL/Pk2D4mE8MQCxmZqCx9OhIOBqNf1Ea329VPqHQWc2cwAmEdHCyLJb7z0oMwY8QXTdnh+lV5/E/cmETXCc34SlLxFcA7NO3LYQk2hhF5zQOwXADMh3OMzRqmhim517KB/64FhRWAZ1MMNyd/RMBwNCDx8KzCvnOYZCH/aLp1vfPQYXjnLW4bafkYye6EZajZQcQf3As2donnT5YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7v6WRYSHhjJLr6lQ6/agjM8g25Ayx4anBJWsLVvNWw0=;
 b=pusx1fx9MPkCm7RDyMLMWx0P3qwpMPiqPpC0uwZGm7j8r4apVwDnJn8RG1CsgEDD9ZqkhGA///wOGwZepRdfRXXoBNUnlAZPxhsXxYRZM3+UoplqHVy6dsCAg1v4+i8fL0E5knKhjsYtwqW3AkbU1vYE6ApxDwjJCI6f7TgKHQHlZ4U+0KgdOt96Fy0mfCuKo2aLuezxgjzJECo0336GzagRtZW8N1/391oJdxDKiX9tl1KO+LsETcOVKn/aUK6eAaW67gDCyJhbWhW8TWY/8L9/GZpwq6PaDhdXC7K08DUCCeD4E99s3rYzan3rNy2rgfZhDs/yRPX2Lao+eb5eyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DU4PR10MB8974.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:562::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 09:45:18 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9009.013; Tue, 12 Aug 2025
 09:45:17 +0000
Message-ID: <bb985e21-8b2f-4899-b07f-739a35dc67f5@kontron.de>
Date: Tue, 12 Aug 2025 11:45:16 +0200
User-Agent: Mozilla Thunderbird
From: Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: Re: [PATCH v4 08/24] mtd: spinand: minor refactoring
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
References: <11f6f79e-0622-42e2-901e-16335ad73409@kontron.de>
 <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
 <20250809010457.3125925-9-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, de-DE
In-Reply-To: <20250809010457.3125925-9-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0213.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::7) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DU4PR10MB8974:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eae7129-4e71-47fc-5f54-08ddd984f224
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|7053199007|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z1VyU1kxUkg5VGMzWGhLelJyWFUveDZUUW5CR2s5M0N6ZVJLT1R0OVFEMldz?=
 =?utf-8?B?VE92bU1VeUNncWtIT0RITHM2M204SHhGNEJ5MU5TVjF0Z3B6WEF3ZDJiSDVo?=
 =?utf-8?B?N0E5VGpQQUQ1QWFBZ2NDQTEyV2xFVzQ2b3orMFVwTW55dENWUVJWTDgvTXFk?=
 =?utf-8?B?SVZpaGw2UFEzY0dBVks4TzcvSW01R210VWNtTzBVVloyZmZhTHBadjRGbmht?=
 =?utf-8?B?VkdLanBqWEZwTkkwUUIxbm5oK1dyUXpTZVloVVcwN2F4YUtmeGRpOEhsK2M5?=
 =?utf-8?B?c29DNmdWSnR2MVFKNmd6WFYvUnRNenEzWWs3SnpiQmsvT2F4OEVxMVpydGI0?=
 =?utf-8?B?ZGNKS3RiTjg4bGJYWGN6MnpsSURQMGxVaHdGU0kvSGpVU0FQWnQ0cTZ0Nzdp?=
 =?utf-8?B?Rm9kMlpidDJEWVdXaE12WjgyRHk0YjBOd3h1di8rYnpJWCtObWRMK1lSUXZY?=
 =?utf-8?B?UXp0MTJadE5qM05TUEIycEJKUlBkakJ3RkNGQ0tLMmlTaktaTXlrM1ZXNXBI?=
 =?utf-8?B?cEZnWXhGV3Z6aXprL2JGWWZpOTVQZ0NNREdBWXRXZy92eDAySFFFSmR6NFB5?=
 =?utf-8?B?aUJhaTJhK2dmZFNHUDBnY0xScC9UUFZYei9nODRPdVQ3RExLWmVRWmZqQWor?=
 =?utf-8?B?Q0lYYjJIWkJuOUsvaGsycDhoV0NGeXNPL3RDU0lPS0pkWEZLV0JrWVQwZ2s3?=
 =?utf-8?B?SjcwSVh2UG51VHBxRWlKMjVpZzZTWGxkeHdpWXZDUkRCcm5QWDQ5eW0vZ3JZ?=
 =?utf-8?B?Vmo1WUVNdFd6TUtkTzREeGFMbzFvSDI5VkNENnFxUlI4eWFNM3dtQ2FNSVBS?=
 =?utf-8?B?ejVZdHlNVmY0QkxxbElQbnVUR3hxSVJ1YVpuT005VkJSdHB3cVJmcVVyQ2RG?=
 =?utf-8?B?OVZ4UUdSUDlyL3FhZUFVSWkvbzI0a1F0YldSWWdZZVdQZ0p6VFV3cUlLRDR5?=
 =?utf-8?B?akkzajNvNUh3MllWMHpFMWNBc1hQTHUzbGlENE9Yb1Bla29odHY4RHZESXF0?=
 =?utf-8?B?dVV4dW5tSWR1RU1sUzlQRHVpOFpTZmlzb3haaG5pMWxXRkM2SEE2MTJsNEx2?=
 =?utf-8?B?R3VPMlNmbmFKMTNseFNUWFg1UjY5VWJnZituaSs0ck13OWpycmZndVRzM3RV?=
 =?utf-8?B?dGVsamx5YmRaTDV5N0NMV0pqSG13U0VaaHE3OStiVHpNWGVQZzgrRy9nam1r?=
 =?utf-8?B?b3BHdGJhRUdpem1IRy9OVVJVbzU5aVQ5NWpRcDRoNWxFL2tPeUJsWmtRNWZR?=
 =?utf-8?B?T1NjYUFpSnlUSUl3S0pvQzJUV0FNaGQ1OWhpK0F0QzZ4RVdzNnNHMlMzazRr?=
 =?utf-8?B?WVZyUGJVWXdkYnRINjB0ZDhYZytDenF3b21JbWdRN2RKcitseUM2d2pnbTNZ?=
 =?utf-8?B?dnB3cENTMk9UaWltZ005TGtSNlYyZEdLYTlZSUVxaVp4Mk5ySlU3aThsOU9Z?=
 =?utf-8?B?UjRoaWFHcTZyczVGMmpCTmdTa09tcmI4dW1idlZHWGVkVW9pWWxnU2NNemsz?=
 =?utf-8?B?TnRZWUxSYlpGbkE3TTBhWTNHMmVyZktIQzlqOUF5d3V5bmxrdnp4L3IydjZ5?=
 =?utf-8?B?emZxbERHQWt1MW5icHFkN2VaT3ZueDA5Z1JvdDArbHExNHNMZFYzYzByQTdv?=
 =?utf-8?B?NWQ2K3dldmk0bEhLeTFzWUVZRDk1elhtVFVRbGYrTCtOKzZXVWlkRnA4UXc3?=
 =?utf-8?B?dUlsVDNoRmxBN2xRb2o3ZHBLc1R6b21rYjNiRkhlZ29DcDJuUTRhaHRxL3FE?=
 =?utf-8?B?bkxIOS9LNmYzYzRnSFhMK0xvRTg5N0p5Q1NwbEhhbzVoQ0RhdzdDVUoyTmVG?=
 =?utf-8?B?bURmUzBOekZydTNGZWVibzZiMVpKTVZEM0lxOVZOenVOaWV5SFFJdlNPVE4z?=
 =?utf-8?B?NmJjMU5BTDZTZk5JbHNNWHhqSngvbmxvVjErL1JISTdqbnNVSHovMFRmYmtJ?=
 =?utf-8?B?Rll0UlZFdWMvb3dmZEwyTXFkS01CMUhjdVhzbkpzWnlrRElkSjRJTG05WVoz?=
 =?utf-8?B?NVk0SDI0eDl3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3ppVHVtU2k4dkd5UXIxTlBzYjRkUDNKVFJnZTRNWThpVEh5anpTMXNEM2tX?=
 =?utf-8?B?K2dkRVV1TXhTVkM3YUlsQzQxWkZIZzBNejV6UXhVV1NnOHJPbytoZm1TU1Aw?=
 =?utf-8?B?M0VZK1FGSWhLL2k4dVpKUVhkaDRwRkxIWEwzUFF4Y3pwR0h6end5WlozZi9m?=
 =?utf-8?B?eEZhbDIrSXpQM1c1TlQ2L2h6K1Y3ZXMzNlBQWUh1V0hpWGtMVG5sZDcxSDQw?=
 =?utf-8?B?a3BPcGdhQ2xtNTRKV1FIQ0xZZjJEWDhFd3hHMWg1TDV4ZFJqdnV5dGhwb3N3?=
 =?utf-8?B?cVgrUU5LRkk5MXlIdXpGQ2o5ZzhIa0tPUlNvWCsxdVhEc09nZW0yTmhWcTlr?=
 =?utf-8?B?cFZzT0lmdkFNSHF0dHZQVHdLT2lld09jK1cySmZYQnZZdEFMaU5SSlZ5M084?=
 =?utf-8?B?V0w0S0xiWXNUSFczMGtJY2gxVXpmQWtIa1JiOS8vb3JLdXN4aGZzTm4vaFRN?=
 =?utf-8?B?VDNGNXdvSFdld2NITS9JUC9QZ09DdlhSQUVzWEdZVzMwNk9ZamkwZFZMUXdW?=
 =?utf-8?B?NllTVHVaMlp6MEZQUzRsVkJXRjhBYVQ0MDlxSEc0SXY0M3FWMjJYckIzenA1?=
 =?utf-8?B?eWdvOEYwTzlIYlluY29QSTh5OXFBWjlZMUJiOE5wUXNmNlB3eEZsUmJwZ09q?=
 =?utf-8?B?Q2Rta1p3c0dDbk83d1kxaFFSbkNpMGcrQzVPNUhFZERaN291Z2ZjY0g1KzNX?=
 =?utf-8?B?c1ZlcGJVWXRoVW1HQ2IwMSswRlhQdDJZVFdISThzMUVsdXZXeGI1MUVGTit1?=
 =?utf-8?B?ZTZnU24wUGRGRmhwTi9yOGV0bzl3MmJnNTlMNmZHSVg5ZWJZMlhYOG1pbGJB?=
 =?utf-8?B?ZHVDemdwOHdEVTR3VHU3RnBWSGRLUGhNaHRZbkNYREdLYnQ5bFdrUjJ0a01p?=
 =?utf-8?B?N2pRMUtJaml1L00zRjRHenNNc2cxdlVJUktlVnZkWURwbCt0aHI4Z1pLNmlp?=
 =?utf-8?B?WFFUR3RuaWxRclYyV0g0aWJEZ3YxUHRBL2JUOHdSUjgvRHBWQlVmUmQ1VHk2?=
 =?utf-8?B?bGpaZjlaa2o2emJHUHFLYnd2cFpFUXBqN1RLdVlyT1M5RHdUaVR3Yys3N3Vr?=
 =?utf-8?B?NHVkazNBY1RyNit1RkFONkFjN1NpQ1VNczVrZzRFMXNyOC92eWgwWFM1dVVa?=
 =?utf-8?B?U2VVRG5MVERBS054MW1KTkNzSHIrS1VOMDFDaldzUEF3Tys0UFc0bk9tSEpn?=
 =?utf-8?B?bW9iMGt1Z3NvOXJEU3BvSys3MUwwNVUrd2VjUzZlK1ZVQXdaeWhMUmxVeElF?=
 =?utf-8?B?U09xbkVFM1VQSzVyZnhxQnhQdmlvKzlwRUVPN1ZkRkN3eVNxcGp0OFJZcEla?=
 =?utf-8?B?T1RzVE5YNHhQY3BjR0luSklqY0VYY05FYWhpYnA0ZkdNSDB0Skh1REM0UGRn?=
 =?utf-8?B?ZTZZbksyMjFkTTI2TWRSWm9tMWIwSVNyY3FLaXdmQ01zK0pJd1RwSUlkeUF1?=
 =?utf-8?B?eU5yaFN2MmZocE51Y2hWaGpoZSttSjcvemtVU01icFdlNW4ySnppWFV0YUV0?=
 =?utf-8?B?dmJUMmpvMHFVSXFrbDNDMHMwRVJDUzF1MHNrSW93M3pITnlPeFBhRURvWlF1?=
 =?utf-8?B?alFNVk9jOFVaRnlIUVA4eTBpZ1ZIT05HQWZYREcwa3MxdjJ4NmN1dlM3UGV3?=
 =?utf-8?B?MFZqQ3hBdU4xNW00R1hDajFoNE9FU1F4Z1RwN3kxeDUyeXgrNThMT3pWY1BF?=
 =?utf-8?B?a2xIcElvS3lpUnpzRXJrM21sWm1mQnN1S3YwTDNzZENyVTdCTUNHdmtmNGlG?=
 =?utf-8?B?R0Y5Z0FYcjZwbDk3ZDE3c1lKdXdoY3NyUVo4SEJRUldTQU9lK2NIMzhzSUNH?=
 =?utf-8?B?eG91eTg2MWE5WG9WRFJ1T1FHd3AzZVovY2Fwc2hyZUVmSGFOdnJxNUhGc2d6?=
 =?utf-8?B?QUpsdFplL2J6ei9pdjdCMkxuNjVhSzV2cnhocHNGSE9FYTMvVUlYd3ZVdSty?=
 =?utf-8?B?R3UvTTJyRWVybGJzVmlFWmRITGJpTzVzVk1vczlYSDlwbjNlWDQ1aWJkLzgr?=
 =?utf-8?B?RElkUHUxaWprdytsNFM2T2NTaFhuK1FxOG1KUFVqcWlwcTZVUnVZdDJQemV3?=
 =?utf-8?B?aTZlL0lBeVROc1hnYUhSbGwva2d1K0RGMWl2Rm9XRkZabkNDMmRsamEvdFNN?=
 =?utf-8?B?VlRZZ0lja0UzUTlKZEowSE12VmhNOVQ1MExraGJ3WFVuMWNQbGwrazRiSW80?=
 =?utf-8?B?TVE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eae7129-4e71-47fc-5f54-08ddd984f224
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 09:45:17.8906 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ebo6ERoM1cEgBzvBQANDqbKASb0ay3szD8jo0SBrRhXUn1WTutuH4f78F6kRpPKLaHz7LoO4I4szswIYGIb0uD7J8MPJFrJFo2tG16PMyNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8974
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

Suggestion for subject:

mtd: spinand: Refactor spinand_init* functions

Am 09.08.25 um 03:04 schrieb Mikhail Kshevetskiy:
> No functional changes, just some refactoring to match better linux
> kernel driver.

Nitpick: "... better match Linux kernel driver"

With the subject line improved:

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

> 
> changes:
>  * move spinand configuration reading out from spinand_init_cfg_cache()
>    to separate function spinand_read_cfg()
>  * move spinand flash initialization to separate function
>    spinand_init_flash()
>  * move direct mapping initialization to the end of spinand_init()>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  drivers/mtd/nand/spi/core.c | 112 ++++++++++++++++++++++--------------
>  1 file changed, 70 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index 098ed0c4cd2..df59d3d23ce 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -160,20 +160,12 @@ int spinand_select_target(struct spinand_device *spinand, unsigned int target)
>  	return 0;
>  }
>  
> -static int spinand_init_cfg_cache(struct spinand_device *spinand)
> +static int spinand_read_cfg(struct spinand_device *spinand)
>  {
>  	struct nand_device *nand = spinand_to_nand(spinand);
> -	struct udevice *dev = spinand->slave->dev;
>  	unsigned int target;
>  	int ret;
>  
> -	spinand->cfg_cache = devm_kzalloc(dev,
> -					  sizeof(*spinand->cfg_cache) *
> -					  nand->memorg.ntargets,
> -					  GFP_KERNEL);
> -	if (!spinand->cfg_cache)
> -		return -ENOMEM;
> -
>  	for (target = 0; target < nand->memorg.ntargets; target++) {
>  		ret = spinand_select_target(spinand, target);
>  		if (ret)
> @@ -192,6 +184,21 @@ static int spinand_init_cfg_cache(struct spinand_device *spinand)
>  	return 0;
>  }
>  
> +static int spinand_init_cfg_cache(struct spinand_device *spinand)
> +{
> +	struct nand_device *nand = spinand_to_nand(spinand);
> +	struct udevice *dev = spinand->slave->dev;
> +
> +	spinand->cfg_cache = devm_kcalloc(dev,
> +					  nand->memorg.ntargets,
> +					  sizeof(*spinand->cfg_cache),
> +					  GFP_KERNEL);
> +	if (!spinand->cfg_cache)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
>  static int spinand_init_quad_enable(struct spinand_device *spinand)
>  {
>  	bool enable = false;
> @@ -1091,11 +1098,55 @@ static const struct mtd_ooblayout_ops spinand_noecc_ooblayout = {
>  	.rfree = spinand_noecc_ooblayout_free,
>  };
>  
> +static int spinand_init_flash(struct spinand_device *spinand)
> +{
> +	struct udevice *dev = spinand->slave->dev;
> +	struct nand_device *nand = spinand_to_nand(spinand);
> +	int ret, i;
> +
> +	ret = spinand_read_cfg(spinand);
> +	if (ret)
> +		return ret;
> +
> +	ret = spinand_init_quad_enable(spinand);
> +	if (ret)
> +		return ret;
> +
> +	ret = spinand_upd_cfg(spinand, CFG_OTP_ENABLE, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret = spinand_manufacturer_init(spinand);
> +	if (ret) {
> +		dev_err(dev,
> +			"Failed to initialize the SPI NAND chip (err = %d)\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	/* After power up, all blocks are locked, so unlock them here. */
> +	for (i = 0; i < nand->memorg.ntargets; i++) {
> +		ret = spinand_select_target(spinand, i);
> +		if (ret)
> +			break;
> +
> +		ret = spinand_lock_block(spinand, BL_ALL_UNLOCKED);
> +		if (ret)
> +			break;
> +	}
> +
> +	if (ret)
> +		spinand_manufacturer_cleanup(spinand);
> +
> +	return ret;
> +}
> +
>  static int spinand_init(struct spinand_device *spinand)
>  {
> +	struct udevice *dev = spinand->slave->dev;
>  	struct mtd_info *mtd = spinand_to_mtd(spinand);
>  	struct nand_device *nand = mtd_to_nanddev(mtd);
> -	int ret, i;
> +	int ret;
>  
>  	/*
>  	 * We need a scratch buffer because the spi_mem interface requires that
> @@ -1128,41 +1179,10 @@ static int spinand_init(struct spinand_device *spinand)
>  	if (ret)
>  		goto err_free_bufs;
>  
> -	ret = spinand_init_quad_enable(spinand);
> +	ret = spinand_init_flash(spinand);
>  	if (ret)
>  		goto err_free_bufs;
>  
> -	ret = spinand_upd_cfg(spinand, CFG_OTP_ENABLE, 0);
> -	if (ret)
> -		goto err_free_bufs;
> -
> -	ret = spinand_manufacturer_init(spinand);
> -	if (ret) {
> -		dev_err(spinand->slave->dev,
> -			"Failed to initialize the SPI NAND chip (err = %d)\n",
> -			ret);
> -		goto err_free_bufs;
> -	}
> -
> -	ret = spinand_create_dirmaps(spinand);
> -	if (ret) {
> -		dev_err(spinand->slave->dev,
> -			"Failed to create direct mappings for read/write operations (err = %d)\n",
> -			ret);
> -		goto err_manuf_cleanup;
> -	}
> -
> -	/* After power up, all blocks are locked, so unlock them here. */
> -	for (i = 0; i < nand->memorg.ntargets; i++) {
> -		ret = spinand_select_target(spinand, i);
> -		if (ret)
> -			goto err_manuf_cleanup;
> -
> -		ret = spinand_lock_block(spinand, BL_ALL_UNLOCKED);
> -		if (ret)
> -			goto err_manuf_cleanup;
> -	}
> -
>  	ret = nanddev_init(nand, &spinand_ops, THIS_MODULE);
>  	if (ret)
>  		goto err_manuf_cleanup;
> @@ -1189,6 +1209,14 @@ static int spinand_init(struct spinand_device *spinand)
>  
>  	mtd->oobavail = ret;
>  
> +	ret = spinand_create_dirmaps(spinand);
> +	if (ret) {
> +		dev_err(dev,
> +			"Failed to create direct mappings for read/write operations (err = %d)\n",
> +			ret);
> +		goto err_cleanup_nanddev;
> +	}
> +
>  	return 0;
>  
>  err_cleanup_nanddev:

