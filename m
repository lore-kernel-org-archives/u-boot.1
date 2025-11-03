Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D09CCFA06
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 15:24:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B81D836D1;
	Mon,  3 Nov 2025 16:24:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="b8o3EqZ3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C866838AE; Mon,  3 Nov 2025 16:24:34 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F09080050
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 16:24:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wTP2OMknko1w5vuw86Te/OgTuswqG0/QA2+06UIq2nLp0Ssr/Ko0ntoGLOFsZJvjCDBBUwwBmb2I7FAHOIG9RwrAz6t7SssrehSWUC0ojY0xBaFlWRsHJRBrg4Cst+wOGwtgyOjNegO/H9MXuU3scLcXnhsEggWXoAwkpLpSrDK4IuKF55idgfPSuv4wG2hbs1BkKaFj93+Xpc36pfujoDdu6Pz6X2cGDj06C1NxBXAMY3dDo2eqD92l2UF/PtEiBTEHd/vnCsGPj783AJZs9IX81NoVsyFx5vH1JzIQnF+OhVzRqm0OWxpNN3jX9/mytGe0ZxyLdNRHnz9ayQb6PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MtDpgD7hPLg/LdHwNCGD/GzTpTJKx3gIu+ayphoFUg4=;
 b=possAl0FJ9uUh6iHbL0p7WlLHxXrfTQi/o0HJ6Y0p1ugPNiIm5XzikNNMGh6kc+605vX3FiblNnbBnmmjGg4n85qRkbN3WxSLpGCLh37Vytk9jIZuudRWFZaSzELewvqFV7JArN69MTYlGd1okKpTNUkYEn7mjSi8nSlBs0q4zwvhSQwYKVCOA7Beuzlo2laSFeUil94t6mWhCdUdmaLZ7MI4dZNvZlB5iidl6tnbsTtQ8YKwTPukAYZvouW8BFsSugS6PVKJu6its0yDrcCkEzF/nP7VF9esVkfsgU1gLx0xGLy7UIYSrgxumG3yOtCfIToYwJc8ic4zU8XSLk04w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtDpgD7hPLg/LdHwNCGD/GzTpTJKx3gIu+ayphoFUg4=;
 b=b8o3EqZ3AT4M+4dPAjKL38vFoKFv8tZ22YG/N7uex1T8uyDVuVV2CyebCa18TRpHTUiOyQVAq+l8KnAY1voeyT7PbYvPcQifTd5qQuBWa5qUgqcj5h5LT57KelAW6jqSqN1HMVGs+QtNWVZohwcmkXiZie1mVyytphR5i9brsPla3e6UDZMEpYnp0UljrLl13Hk8Hj/sIaLmN7WlXqGi9cU1f7MpoyKjLejopv7B2/d1a7zLhsCy7BSlfY0oXFbu811l540wvoH4wnAcvPIwnFfPYpvRT5f1pC25T9JXxmQEJsqFWU/+7JFX2xr4EKenbyZBwgNYxwxpFGUQY5X4Iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB9476.eurprd08.prod.outlook.com (2603:10a6:20b:60f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 15:24:27 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 15:24:26 +0000
Message-ID: <db279009-c0dd-4649-8bb5-6cfcc00d378f@iopsys.eu>
Date: Mon, 3 Nov 2025 18:24:24 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/19] dt-bindings: reset: Add reset support for Airoha
 EN7523
To: Tom Rini <trini@konsulko.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Andreas Gnau <andreas.gnau@iopsys.eu>
References: <20251101004503.2379529-1-mikhail.kshevetskiy@iopsys.eu>
 <20251101004503.2379529-11-mikhail.kshevetskiy@iopsys.eu>
 <20251103143808.GL6688@bill-the-cat>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <20251103143808.GL6688@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0131.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::9) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS2PR08MB9476:EE_
X-MS-Office365-Filtering-Correlation-Id: f9dbdfb7-5ee4-4ee2-b1a6-08de1aed134b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QWgwRzdGamU3N2VqTWRMdjlqRkF4engrWUhZUDZGOGVjeHZMekMxM3lwZGZv?=
 =?utf-8?B?UklFb2JGaVgwNUxLbEhDVzFBOEVLbE5SYS9kUkQzN3oyMVFyWENycCt3OXBh?=
 =?utf-8?B?dVlycWFxOGtQd200NDhnTS9UUnhqT0FXdGNINERaVlpsbTZSbmdBZTQ5Njl4?=
 =?utf-8?B?VElrTENocGMwbGh1Rkk4ak85cEo4M2d5UjIvTC9UVk5aNVJOclNZMm9JWXRU?=
 =?utf-8?B?UDFHRjQ1VlBWSjVUZkRsVDRJbHJ4TmxpWlNraElwY1hIbVd1Rzg4SmFUcWl5?=
 =?utf-8?B?eFphS2hXQ0RoNmxna2VkekI4bXZ1emE1RWFaTXl6eU5sSTBnMkkzZGZYd3h6?=
 =?utf-8?B?Q2xHWmlxZjVQcWMxajVjZUljVkxvbVV6RkVyY2JOK3ovd3g2THI2dk5MS1o0?=
 =?utf-8?B?RHdBWHpkaDVzYk9sZ2x5dGVzbHRSeG1GTjdRZys1VXlEbmVoeTh5MG9BS2Qv?=
 =?utf-8?B?TjByV3JveUtyYXp5eWRMOEFVSjBCME9wQ0RkMk9KS3lBMnNyZzRScXR4YklW?=
 =?utf-8?B?TXN2RERBdXJPZlRiYUREOWcrM2EyZm9EZTBhQlRGUUlTWlRoek9IVm1vZVBV?=
 =?utf-8?B?bHdmVlpidUdiaWYrMDUxenN6RW5xS1FQSUcyclpBMXZxTFVMQmJFNzFjdk56?=
 =?utf-8?B?aHMyYjc3U2YwREhlOWFQNldwNUE0aUJDSFFjSWRpL0YrMXQ1VWlJM3NQeURN?=
 =?utf-8?B?ZWZWcXM5aU1HWm40VlpWN2VKVjY2NTd5dTFzSFJwYzlUbFpuMjErNmhRcjZ6?=
 =?utf-8?B?VXk4RHpkbmJDeitXemVsTUlPcXFuY2N2RFJEZk9tYUFaVjdrWjFNVis1eXY1?=
 =?utf-8?B?OWdKYTlNblRmb1paOVI3OVFFK2FkZXpXWHc3TnYvdUxsRVk4TmMvY3dSZFJq?=
 =?utf-8?B?OXFGWFpJcElPL2Q5ZC92UkJtZVNGcFNxMkZ4djBDRnM4OXNtNHZSR081d2dh?=
 =?utf-8?B?Q0VQOEVsZzB1VWg1TzRqYlhnNUhibkpkaGtKZ1l1ZzIxK0FLZGs5K05oUlZY?=
 =?utf-8?B?cDVvMVY1VWdmOWZqT0U5Y3VzeFp4S2pVWXg1Z1VUZWNpTzR6S2hLd0dQY1Vp?=
 =?utf-8?B?bm9nLzR6SjlBbjJGTWNPLzYxenBSVDB0d0VtYkh6Nk1CZ1pBMnhOaEZFanBO?=
 =?utf-8?B?WlZzNm5lWWw0a0htZEJkRWJCYnFUSk5IY25DRndCR1RZbVFITnBKdWUxcCtL?=
 =?utf-8?B?RGZ3L3k2NzU2MDJidklvNUMyQmxSZ0tSMHR5Y1gyN0k5UlJSRy95RVk1Q21w?=
 =?utf-8?B?RmRvdVZvM3dyU2ZwV0xvWUpnT2kvVTlUYUcxV0N4c0wvZVpwRFJxd1FiVU5R?=
 =?utf-8?B?YWdJanpXdDY0OGpYMDZHaVJwQ3VLdlBpZHRiWWNIYkVLZkF4cjllUGl2azMz?=
 =?utf-8?B?QUw3aHNybmV0VVNad3ZTMzdVTHBMQTc3NlRYVFRycHhidjJCWWRqSUoweVlC?=
 =?utf-8?B?Qmt3QllFV3RJSCs1QmlCbjhUcVUreTc1SDVkaWRZeEZ4alA3YkRkcGdSc3la?=
 =?utf-8?B?MlZxekRBL0FJTDNMUmQ0b0FLcFRPTlNjTzJmbjI2Y3RPb2gzZjF3b0k5TGtF?=
 =?utf-8?B?VS9XTHFGMFVwN3BGTCtWNTdjd25lK0tIRytuOGc4RUNnZTV2ZHNsU0dRVTYv?=
 =?utf-8?B?SC9YNndzR2tpOFhvemk1aithRlBSdEtIdmpjR0h1c0ZWOEZyL2NVSjJFY04x?=
 =?utf-8?B?OUxEZnJrSmh0ZjdqeFZSYjFOQjV6MzRBd0hGWThiaXlKVkN4blMyVFJBNkUr?=
 =?utf-8?B?ZGx0Z25IQkdjNUlQVzU4SnBITmNjeGxMc1hLZGxjWTVHRnpldVdtTU1xVHB4?=
 =?utf-8?B?SDNQR0xkSTR2allZQUlZbnNhd3NHM0NObU11SG9hbHdyUlkwMkMrRGRocGo2?=
 =?utf-8?B?RXN3SlFOSWM4QWJpdzFGbGU1R3ZRTkkzeFAxd0N1ZHdBOEx0ZUgwM1BpRXhM?=
 =?utf-8?B?ZjFpWlhjZkMxM2JNNGtGbm9WZmw3Q2FtUnE1MFNHdUNPZjhuVGlEU0lzWkNE?=
 =?utf-8?B?clpiSnU5TXR3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXpORjZ6ZVlzNENMNGVTekg2cmhIVWtyYlIwcE9NQWF2WnRncXlzTEp0b01m?=
 =?utf-8?B?Vmo0aTBsMFFLUUlhNEY4Z0YwUDRjekhnMmNNVFd1WjE5aTRsMFpyaHFmcUZt?=
 =?utf-8?B?WGw5REp6LzNlM3JvQTY0TkVLcDFScmEyYWs0KzJxMllYc2VENWl2aGx2Wncv?=
 =?utf-8?B?Qy9pM2dRdTA1R3cxM2lVWmFFcnV6cVFKcG5BbzdxbXNKaWZkTjd3VDB0Vldk?=
 =?utf-8?B?b2EzRm9KZ2txRmVMT25neDVvOHgrTCtrUDMvZEdudmxQWGpIalc2K3AvRmE5?=
 =?utf-8?B?aXdGZVM4bWo4Q0dELzlxaVZJNXVDMDErMlA3VFE4QW9iR0V1U1FKaUZkL1RJ?=
 =?utf-8?B?eVpTb2JYczMzSGEzTk4rcmRMa2d2YlNsTkVsWUFrSS9GY3oxTGNCa0s1cksr?=
 =?utf-8?B?Nk1MZ1lCa01yTlJqWUZUeGpLOFJUdVdVanNlcHNxSHRNSFM0cGh5em11dDZi?=
 =?utf-8?B?OS9pektON05TaWtxdzBsZEhmbW1NQnc5QTQ3M2hlT0duTHF3ZlJIMVltOU8v?=
 =?utf-8?B?TEFkcTU1WnQ3QUhnd0VIaWNVN1VrZkFTUjFuNUV2ekNTTC82SGJtRGRuTlg2?=
 =?utf-8?B?eGNDZmJqd2JEdGxWV0pMNTA1QjhWbVZvUWNEYjY3RlJaSWF0YUtWUVRSa2FI?=
 =?utf-8?B?Y2VoWXRzd09LVmJBZDVYdmhIblNTWEVrcnprMjNQME4yMVY1S1lrTm1nR25E?=
 =?utf-8?B?NUdaTktwQnhjZDdiVExnWi9xUFJtcDdFUGhJODRNR1Q5NnBzWWZCZThEaG9r?=
 =?utf-8?B?aGF5aFlWRXFqRU9DOU12dGhINVZLNWZxLy9ZUjlUcERQVjM4eTRFNGIzaFh4?=
 =?utf-8?B?WVlBTjU0WVpXVTYzWm5KZys5bnFuY28vVXN4b0pYM0MxTW1KdWdQdzFOaUlV?=
 =?utf-8?B?NTBLemk4c0gxbitRdFpKL2FNTHFQZzdQclZ2Y1ZoL0EzVFl5WHZSN25lWG1C?=
 =?utf-8?B?ME16QS9PczV2MllqcWkrQVlKSlQxZlM0d1dkVnlMZVluMHNJek5KM2JEVWJH?=
 =?utf-8?B?K1ZrcmlpWnB6V2JCQ1phY2krM0IrbGwwK1VGd2tpYkRGcDJBNlo3YmpPT09v?=
 =?utf-8?B?U1FORTR1SlhnaDh1QUZUbmVZSmcwaWpreDN4cnhTelBCS1NGbldKLzNoK1Vt?=
 =?utf-8?B?RHlGMjltUGI3V1hYUzJkd1FuTGFkblZlc0xpNUZkbWVGRHBDTDVqT0QySmRM?=
 =?utf-8?B?eG9hdDBTQ28xVkRQWlVRd0Mrc0c3TDJSc1RPd2VOWHdSeVI4SFZvdjJ4enZt?=
 =?utf-8?B?WEJzYXFhMHE1Sjg0aVJEN0ZqaHhhaUtrbU9PbWhGZENDOHZYTkFjcGxoNisv?=
 =?utf-8?B?NzZCUmRTOURPbEozbUlFYVBsaWpVSmY5S0ZPYWprbzhlMlM5N09YMHNWZ2h5?=
 =?utf-8?B?Rk5sZUoycFhtMGdkRmExUzhZNmNNTTR5MlZKenptMXYzRE5YSXJ6RElvT1Ns?=
 =?utf-8?B?bE95Ny95dFhSYi9tQTV4ZXIvTExnOG1vSkpHM1pramJDTForQVdYdExaZTJQ?=
 =?utf-8?B?bUl5UzVsVzBVRnN3Rm1SN1ZHczVtdzdVQld1OWE0UjRQNmxqbVIrMllDT2Vn?=
 =?utf-8?B?cmFlbDhLSHc4OEErK0poclR5UUpDdXFzcVkrTy9qdTluWHpheXVVUzU5OXZo?=
 =?utf-8?B?Z0tZSHhpbnpVKzNzVEZlZFRoSHZNc2lrNGlhZ00yY1lWMFlZKzhtQkhjWGZv?=
 =?utf-8?B?SWc4eGdpbC9CbDE3WE8zZVE1NWdMWWhWTkdHV25jQklYWGc4d0tldDVtMEtP?=
 =?utf-8?B?RGNiL3RoT0UyRUx1ZXlqcFpmUXlGeUhzZ2tzUStObzJ0YmxreW13SDFoWFFU?=
 =?utf-8?B?bHNkTTZSQ1hOWlp6SjNETVhBQ0RTc1Q1bWVjNU84YlUyZnVGNEIwOEpaOGY0?=
 =?utf-8?B?SXpuU0FsSG5NRm95d0UxbHRKWllMODIzek5namRFMEx1bUkxSmYyYW1wZzRw?=
 =?utf-8?B?OTUxOE1wSktSSGxjZlBubEZVSEJvRWNTTlUrMzdvU0dySG9BSklVaE5JTHBt?=
 =?utf-8?B?T2cxZnlaZWF6dm5RdWxiMEdvNDZHaXdJNEx4UUYwZ2lQeHRmSVJzbkxOQ3FR?=
 =?utf-8?B?WVVWdkZHbUpqbXlkcnpCbndrQnhyV0NFenBYa09BNGpxV3RVWHhsTERySUtY?=
 =?utf-8?B?RnBBRENKZ01vN3M5ZHFNSWdqSFBiNVQvUDNKT3A3dk80YSs1NitoTkVVemNE?=
 =?utf-8?Q?A+992zlmc2aD5lqaCPeTEhU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f9dbdfb7-5ee4-4ee2-b1a6-08de1aed134b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 15:24:26.8775 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mf0RZyUjRH4ZoXSoCc3ahdVAdpcVgX7XlV1Ny0Xo0mhulwXwJw1MyBH/V1EB1xOxR7w0GMbMYGpQJL/s7Y41CM8ONdsFtijTXw/iF5ABEx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9476
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


On 11/3/25 17:38, Tom Rini wrote:
> On Sat, Nov 01, 2025 at 03:44:54AM +0300, Mikhail Kshevetskiy wrote:
>
>> Introduce reset capability for EN7523 device-tree binding
>>
>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> ---
>>  .../dt-bindings/reset/airoha,en7523-reset.h   | 61 +++++++++++++++++++
>>  1 file changed, 61 insertions(+)
>>  create mode 100644 include/dt-bindings/reset/airoha,en7523-reset.h
>>
>> diff --git a/include/dt-bindings/reset/airoha,en7523-reset.h b/include/dt-bindings/reset/airoha,en7523-reset.h
>> new file mode 100644
>> index 00000000000..bb0a28673d6
>> --- /dev/null
>> +++ b/include/dt-bindings/reset/airoha,en7523-reset.h
>> @@ -0,0 +1,61 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
>> +/*
>> + * Copyright (C) 2024 iopsys Software Solutions AB.
>> + * Copyright (C) 2025 Genexis AB.
>> + *
>> + * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> + *
>> + * based on
>> + *   dts/upstream/include/dt-bindings/reset/airoha,en7581-reset.h
>> + * by Lorenzo Bianconi <lorenzo@kernel.org>
>> + */
> This is as good a place as any I suppose, so what is the status on
> upstreaming all of the bindings/etc changes for this platform? Thanks.
>

It was sent to linux kernel already:

https://lore.kernel.org/lkml/20251017201126.493496-1-mikhail.kshevetskiy@iopsys.eu/

Patches was reviewed, but not  merged up to a moment. No any activity
since last resend

Regards,
Mikhail Kshevetskiy

 

