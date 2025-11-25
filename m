Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E87CD0E6FA
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 15:29:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DA3D83E62;
	Tue, 25 Nov 2025 16:29:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="AYsM/vpb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DD7B8404D; Tue, 25 Nov 2025 16:29:38 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BA6883E60
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 16:29:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ew+Kq1CZYb5GT8q2CJMYRCEnoiISjolcb78A5lHl0aKTLfKCf+6PsqOTzU0QkyhMdyOLHx3lacZzz4lXx1gB5h+fzbki88cW/nRVr2N2M5bW8gHVqZ3IRYikblZT69sxHqaI+XxE13sgRttN3z6ZWTiljn9wVPhHKnSoAnD7RXt3p7/T3bMynN43U/rHMU1qgo3vuSDAubb9fdTuU2uvtAJgfKWpmRztA+LjH/JqeRe1N6wTTr5xXW9JMU2+0YQ1Q+/7zJUHoZEVz97nIIFqSQHxHuVmaBIQ2xzCsndlAOEh66dR4RYK2NRlaSk8xkgu6RRtFBagqFQh5vOtSrgxeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uoiGD+66CcjxJ9FfXn9KSMlUFE/Qe5YcU5/kexUwgqs=;
 b=SsSeciPUdHLVRDiYQhytEPOlC1IRWGZwTq81oZKUPC75IWkMzSmC2eL46scGnkdOJM5vWfKG6I7mnM9cFHX0xQ3SaKxmtwJAiiegg1i1uB0JDopBrThiV8DEsssyd7Af4GS8KLZptsCYYNEVKcRj+e33FmDdrVxzrak+0M7Zc5d9nP5rG/WdBLKy2UvozPj4+o9DZ/76diXr+gWjn/zaDWu8dsPZPkFVQjJNHv3Fvp9Eoxx5MVNq1lJrc/LFRTLhKRKtrWol5AYvlRd8xC80MAUTtDypTrb57oV1oqvMYRpHoAs0Fv0G6kzHmSYXiA3tGqz7VB1Dlk7Z6dNWMl89jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoiGD+66CcjxJ9FfXn9KSMlUFE/Qe5YcU5/kexUwgqs=;
 b=AYsM/vpb1ATRFdpCXNgbExPqGXQkmr2dhWjz5IeGS3QrPaKUOgrJooVv+KdHrorVoV4Mt+DNj0PEpjin8imkMsPZaFCFYso6D10qc7E9XhYKvrg+OAhuXK3cZo+L823tFzLuMxrNPufl3Qzdek7Xs+RBZ7xQeaS4qK9JAWuuLrA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AM9PR04MB8538.eurprd04.prod.outlook.com (2603:10a6:20b:435::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 15:29:29 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 15:29:28 +0000
Message-ID: <cca160a9-45f2-4012-8c1b-6106dc514f47@cherry.de>
Date: Tue, 25 Nov 2025 16:29:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] test/py: fit: Deduplicate the test
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de
Cc: =?UTF-8?Q?Carlos_L=C3=B3pez?= <carlos.lopezr4096@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 u-boot@dh-electronics.com
References: <20251124194201.83326-1-marek.vasut@mailbox.org>
 <cc5f03cd-6caa-4129-a4d9-b502e9c61990@cherry.de>
 <15d914ed-15ed-4acd-b6b6-cdce114770dc@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <15d914ed-15ed-4acd-b6b6-cdce114770dc@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0030.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::26) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AM9PR04MB8538:EE_
X-MS-Office365-Filtering-Correlation-Id: 3119323d-2aec-4dfc-f196-08de2c376bfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|10070799003|366016; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZGYvZGYwekg2NnNseXV2Wk5jbHdZZ3lRUG5zMEE2TVptQm5QMnludU1SZWdq?=
 =?utf-8?B?YnZQbm94d0lnYnhXcVZLOHJlOUlzMTBWTTRVOVdCVTFDTEpRd25TVVRPb01T?=
 =?utf-8?B?Sld1UjZNNFpsM0UvSldYUlFQdWJpd2FleGJvV09NbHgrcWQwM2l6OHhWVW5E?=
 =?utf-8?B?NjBwMlVsUUxrcHlLOTFtYlNvQW5QTlBFR2NHbGlvWGRDZWJQUm1FanFvVE4w?=
 =?utf-8?B?QlRKQnFvdDBqVm1UcThvOEYyVEdnVHk5dGNLRHR4dVRpeFBLUjZzdXpUa2Zi?=
 =?utf-8?B?ZWJLZ0VOalYrMU9BaTFQQmt1MDVmeG52R3duSXZPdi9QKzNHOGJ4eVJYbzdw?=
 =?utf-8?B?YVB3WGJWWGJTNFlIcE9Qb0crZHdDclpEbXdEc1ppZHFyaW9rL1lpWXp3ejVX?=
 =?utf-8?B?d0tuMW0wMjNFRndoaDVpSy9MWEJHZDh5R295MklOSWxQZ2p6QStDTDYrZHpl?=
 =?utf-8?B?NTJva2xIbStHaFh6bjFXajUycWxsb1owaVZMUXhvSVo3aVd4RXk1enlpWW1O?=
 =?utf-8?B?ZU5QSDZjWXliNW5oeUxxWUZ5MmFBdTVlRmJRdU1HT0Jrelh3TmJJS2RxeFd3?=
 =?utf-8?B?SzIrMStrckpYNHNuREE5YTlKYlR2enQvZXVLS0dNblZZZXZFc2N0TDVjekRQ?=
 =?utf-8?B?cWs1TFVXSDVTblhxcTJJWDZJOXlBUktDMGlENUpOWnFWdVNqaGY1RnIyVE5F?=
 =?utf-8?B?ZWJzWEt5akRZei9NRVUzUkQ1RmRMUi9rcjdWV2ZEZ09aWGtOeU9LSGxpa2Q4?=
 =?utf-8?B?cjh3R0hRRzN2OVdtL3RQTkk2VzJaWjBwbGE5UW4ydThRZUdWVXNCb0JVbmpL?=
 =?utf-8?B?WFZaSDMydnpJaFhCYmtRSngrLzBkZ20vd2ZHL2EveEltQktKbGVYY2tnT2VH?=
 =?utf-8?B?VU1KbEFRSHhlMG9sak5uZ28yRGdZTTBlTU9pUXhVYjU1NFNRcGhyRDVOeTFh?=
 =?utf-8?B?aDk1dU9vNnUzcHI2N0dBRTBucWhHWURhZ1JBZXdrZGFnREJVUkozNi9xR3Bz?=
 =?utf-8?B?WTVGRDY1Qm5aN1pRcUZESFdMVHhMajVWR0RVbXQ5MnEvd2VKVm5RU09hWU9X?=
 =?utf-8?B?Z3hMMTNzMzZ5a1VqMk8wZk5GNDhNV2twcXNmc2RLZWNGTUdyaTJ3dUl5MlJy?=
 =?utf-8?B?ZDJxL3pPVWh2ZE00WjBsanFYVmdNOC9SZnNzUm5POGxEVFBVTXFrSUt5UTZr?=
 =?utf-8?B?WDFIWnZtWDhoY2JHSUltUDQzMXlBT1dtdUFNZENjMGsrOUFpY3hIVU1kNWta?=
 =?utf-8?B?Q0JDelZuRkFOL2pUcXc4Wm9qUjJTcDMybEhYUUtGbEt6blFvcmtRelViVGNi?=
 =?utf-8?B?VUtDRXBLUTk3U1UzeDZZK1lNN3hxRmRocDI4TWw0N2Y4OWZlMW1DeTNEMXh3?=
 =?utf-8?B?U0VJV1lBbkgzMWpwbDdJNFlHY3JUdno3YXVtRXRyQmJTcTVKbERoczBwRWJG?=
 =?utf-8?B?RFYrVWNyby9JR1RHeStPME55eVF2Z0tRQ2VGN0NhbUFGK2JnZ2dNejFaNU5Y?=
 =?utf-8?B?dmdJbFl6VU1KU0VFVHh5eTE1bjMwdERQNW9zL2RxUnNncXFMRi9wd2JYNURV?=
 =?utf-8?B?SFdBS2h5dldrd0szK0JRVngzMkV3RjFvWmlCU3k5MG45bHZ1MEtFZUs0NXFj?=
 =?utf-8?B?bFROaGFSMVdMTjB6L3dHc1BhdjhQeDY2VngyVTIvbXZNVXh6Sm1IeVBJcmtO?=
 =?utf-8?B?TFR0Z1FSUzdJSklPVXF3NmVBTVdPMDN3L1pHZnpOV0QzL1BDb1RubStJWGVQ?=
 =?utf-8?B?dzM5aTl3NWtZNHF4cmdlQ2tGL09pZ0NIS1pWanJ2ZXBJYlRVRTViMUh5aW9X?=
 =?utf-8?B?K1p1RVZuc3dTSGhrNDlGWjhQckRCWFc5SVNEOElXZmRkenpOMzh3Ym5IenRM?=
 =?utf-8?B?V3Q1NTZ6UHNvRWluMjk4VkV5OFo3ZmszQWtKRmRGL0NsZUE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlJZSldSWW0yWWI5dFZoOEVKNkozczJ5UkFYalQ0amtZSldlcEl0SzdsQ3ow?=
 =?utf-8?B?dldsVWpMeVRrSnVrUFl5ZkZ0WXdrSzIrRllxcFUxMUN5a3NqVjBIM0FUWVJy?=
 =?utf-8?B?bitmaWs5bjhrMTdDU01PZE1vbDN3ZlhpZGdIL3RXWW9RcGVqcjh2SnRvbnN0?=
 =?utf-8?B?WU9zZVIvV3R2UjEzZmdJMVhmSzkxQjVYOC9jcGkxaHZ1cUdGcTJMbHpadjJ4?=
 =?utf-8?B?YmliaXRmV1E5SVpSZi9aTzFoRWMzcWVHcTUwc3FQQmlteDFkM1BJZmEzbHE3?=
 =?utf-8?B?VzFnL2Mxb3dvUTBFcm5oQmVPa2J3SWtuN2tZaStHOUVLS0lmZXRMOTU2c2d6?=
 =?utf-8?B?U0Rncy94YzR6dHpzdmdhbGpLUGE4bWhDOGxwTTBjN0hOdVpCSEVWQWNoU3Rw?=
 =?utf-8?B?SWZVRkp2ZFRsOHhBRGNjRnBGUVA3cUsrNml5ck4vMlhaR2t6M2QyNG9Jemlh?=
 =?utf-8?B?K3VadllEWUtIbEhlWDZUWVpVYVBxUWNxRkhTZ2tFQktDSW51eDdkMUJnK3BM?=
 =?utf-8?B?cXZDMTJrUDVGV2c5TElaU3ovY1NLTWpzek8rV3UrWWl0Vkp6dEs2Q2RIdm9i?=
 =?utf-8?B?VU9COExaQjVUS1htd2t1L2tWUGdqa0xacjdXUXE4UzN3TW9taHhQTlJLYTFo?=
 =?utf-8?B?Um12d3E5NVNCUEtZU3FYQjMvaE9EM2xHUFBDR0lsVWU3QmpneDJUNFBpQWFP?=
 =?utf-8?B?SWl6WFkwbW0yQnlMREJUM0srVVhPOGdOMGFUTTNIc2k4TEVGVGJ0MlZzdUJV?=
 =?utf-8?B?QlNLb0VKcjZPZGFpWGRId0lyMHZ6emFGRHJvaStpRWh6WnV2OXFFR2pqbjIy?=
 =?utf-8?B?Q01IeDY4L0FINTZqby9RaXJsWnBjQVAwZThRVGZKUmdsd1hhVDV3aVBGV0FV?=
 =?utf-8?B?a3pmTmpKWDdmZy82MDA2UVJXcUNIdTk2U1R1NUtiL0JMSXV5RnRBckpQRkhH?=
 =?utf-8?B?VFh4TjVrWU1pcVNWSXB3TXRiRVFoNzF6ZDNDMGtUNXR5WXBuWDdTN0ZnWHly?=
 =?utf-8?B?cXphclZqVWhDK3c1NmhqY1YvaXh4akVNMndCZHQ3VnprbTUvRE9YSnY4ZTNO?=
 =?utf-8?B?eTR0NEw3RjlGMzJwMjQxeXV3Ky9ncjJTYzZPR2V6SDQxQ0dBVmxvbzNwK2RC?=
 =?utf-8?B?cnFSMXVGd3F2QnR4SEFEdGUwbzdsZVJzWFpZMlFSNXVYRC9GMS9uaEl1eWZG?=
 =?utf-8?B?OXA5TzMweU85RFJTRkYzSGQ4MFo2eEpmaFVld2RSOE8yZlcySlVwWkVqMVN6?=
 =?utf-8?B?VTZRRndobXlUaWlCU3dleUhuUVRMdk9PS0wyaFBUT3V6VTJBOXFvZ09QQVkx?=
 =?utf-8?B?SlVpUXFIaTFyZk5Bd0VyY0oyekVlamh5czVoQVUzRWNabU40RzhMU0JXcGZO?=
 =?utf-8?B?R0JHdXZBeTBZeWh4NWNVQ0oyVWNaa0o3K29rRmRud1dPSkVlQ3NhbjVXZ21n?=
 =?utf-8?B?cS9TQ3dyc0xRYnVxaEt4cVRpTEltOURRbk1XajFubTMrTmQvWktGNkE0UG1n?=
 =?utf-8?B?aEFSZDlTSXJ4L2hTZzIzZXNwbGN0em14bDJUcnNpYi9vMUVucThlTi9Vbnho?=
 =?utf-8?B?Vy9zdklFREhHc3hpK0NVbVR2UlE0aENnczBHaUxBSHJMQ0xjdU91akorVENL?=
 =?utf-8?B?OUc0OUZvTUFjbWk2YitBWEJJeGdaRitKT3ZaTHZUUy9pNCtMN2dhVFMxY3dw?=
 =?utf-8?B?Y2ljQXpzUHIySjY2WVdRbVh4T1dKaWk2b0JYZXZqVEplN2NGWnlRb29iQ3Vy?=
 =?utf-8?B?RXk3NDUrUVAyM0FnMlB2QnF1UytHbUZVTSs0OHNKVkR6RTV6U1JwNVZuQ0V3?=
 =?utf-8?B?SjJpMnRIVEdTaWwxdDhqQXJ4OVlmamFBUkpXUzdOVis5R2ZodHJTRERwMjBj?=
 =?utf-8?B?dUVmaXpVTFRPUW1VVnkzaVlZUThyVUZwTFNEb3BIeW5wNXdPQldrR0RpQUF4?=
 =?utf-8?B?SXJlRGRlM3p4TUdjR3ZYY3NBVEk2b2xrVDJqZFFDRk5QdzlNWGZESGdpcEVD?=
 =?utf-8?B?SjcvYnpaSHhyM3dsaDJnKzJid2J3cjg0bWFyQ0hYS2crVkxVQ3FFUkRSSGFN?=
 =?utf-8?B?VVhJcVVPRHQ0eU1XNDZ5cXlueUJGa1pkaDlQb1Z2YjFBUUtLT0M4RXQ0cVE3?=
 =?utf-8?B?QnRuQ1pFczZYcnVqazIzOUxyNUh0N05rK3Rwb2ViVml2RktHN0FPemZYeVFX?=
 =?utf-8?Q?jc6BxzLMUt0a5QrshIiWKKw=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3119323d-2aec-4dfc-f196-08de2c376bfc
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 15:29:28.0872 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9UBjBq3oKdvnvF9kw0HdKy48OpDclqanzv3t6pXghbYIhn9+ggWlLOI7nNTwJjYRqpbqrbyobm0UiUr9P7SPcEX5CP5Istd+/8YtE4LBd4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8538
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

On 11/25/25 3:52 PM, Marek Vasut wrote:
> On 11/25/25 11:50 AM, Quentin Schulz wrote:
> 
> Hello Quentin,
> 
>> On 11/24/25 8:40 PM, Marek Vasut wrote:
>> [...]

[...]

>>> +        """Generate fitImage and test for expected entries.
>>> +
>>> +        Generate a fitImage and test whether suitable entries are 
>>> part of
>>> +        the generated fitImage. Test whether checksums and 
>>> signatures are
>>> +        part of the generated fitImage.
>>
>> Would be nice to have documentation on what the parameters represent 
>> and what this returns/raises. Not a blocker though, I see we already 
>> don't do it for other functions.
> 
> I am not that deep in python, so if you could tell me how to do that or 
> share an example, I can do that.
> 

Just follow binman's example I guess. If it's wrong, we'll need to fix 
the format everywhere anyway at some point (e.g. when someone manages to 
setup rST doc generation from docstring, maybe with [1]?).

           """Get the operation referenced by a subnode

           Args:
               node (Node): Subnode (of the FIT) to check

           Returns:
               int: Operation to perform

           Raises:
               ValueError: Invalid operation name

This seems to follow Google-Style Docstrings format, c.f. 
https://google.github.io/styleguide/pyguide.html#38-comments-and-docstrings

[1] https://www.sphinx-doc.org/en/master/usage/extensions/napoleon.html

>>> +        """
>>> +        mkimage = ubman.config.build_dir + '/tools/mkimage'
>>> +        utils.run_and_log(ubman, mkimage + cmd)
>>> +
>>> +        fit = SignedFitHelper(ubman, fit_file)
>>> +        if fit.build_nodes_sets() == 0:
>>> +            raise ValueError('FIT-1 has no "/image" nor "/ 
>>> configuration" nodes')
>>> +
>>
>> Only downside is that this exception will be raised with the same 
>> string for all callers. We call it multiple times in the same test so 
>> it might be difficult to identify which one actually failed. We could 
>> try..except the exception, use the content of the exception with
>>
>> try:
>>    generate_and_check_fit_image(...)
>> except Exception as e:
>>    pytest.fail(f'FIT-X failed: {str(e)}')
>>
>> maybe? (NOT TESTED!)
> 
> Maybe it would be better to simply print the test configuration ?
> 
> Like this:
> 
> raise ValueError(f'FIT has no "/image" nor "/configuration" nodes, test 
> settings: cmd={cmd} crc={crc} simgs={simgs} scfgs={scfgs} 
> bl31present={bl31present} teepresent={teepresent} key_name={key_name} 
> sign_algo={sign_algo} verifier={verifier}')
> 

Considering that the only arguments used before this is raised are the 
mkimage cmd arguments, I think it'd be enough to just print that? But 
yes, that would work.

Cheers,
Quentin
