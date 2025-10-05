Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A54CAC5BB
	for <u-boot@archiver.kernel.org>; Sun,  5 Oct 2025 18:19:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E09B808AF;
	Sun,  5 Oct 2025 20:19:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="z4u2DxwX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23015809A5; Sun,  5 Oct 2025 20:19:30 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7261807C0
 for <u-boot@lists.denx.de>; Sun,  5 Oct 2025 20:19:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZyl90T8u/IuxzniL4gXW0n95eu8rLpGaZAoLxVk6PwkHChpmiX7BwdCH2oF1Fda1X+dAMgOYg6Ngl7sjZbNr4T6mzTf5o6wSCZivFPgUvp9WcPujM6g76VyC+5A9oZr6fQ+2UUK6hwhL0XMFApaUDIwzVGV26QktegVXNSxuls9dyjYSlTcOjelQpqvN6BfMj2a8xLqplnx6iOlSM9RIjP+BHnlbmS/diHjWuzOixL/7rC+hPQ8068Us0CWN212LZXg+i24XmqqxJebevMgjuRr0JcPGxaR1LC0PtJHcOjYxogLg/BVVj8Cy1SvI191WQMj1AOX5CwHxKOjcG81vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMiYClJbaPqxnOAqznW9t0/9hugShyNBntii//JyPqE=;
 b=WKjFuz9KZVsJwFEWlGYhsqFbvB+0KUE/ROb1fey3TfFvsQORg1MVJT1Q3kc2eOtpXjhqOH+KAlnJ53pLlDaf71lYDYQvCwWdnBbMeRziSCZ5CTiVek1TaGW5Wk7ieFFrGdTfc+hH1VXDJXI2LVCnBnbZ2yIZzt/bC9JY575XaMoRQaDLam8orEil2khwjyHvAX8tw2d6czXNiVYIiXxNNW3oUCB1EDCxQpFQjczIFRwiLG4Jhkk8Pe0dD77LjLVvF1o9Bo+7ZeVBau6cy8Vl5a5l/OF0iYBJO17GoLYbM3QM+14AT9DhAjMFIdJOxM0EhjGww3kJXLg9/PaR93kTCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMiYClJbaPqxnOAqznW9t0/9hugShyNBntii//JyPqE=;
 b=z4u2DxwXFZNmR2IFDkOxno8Alqx8+HwoiH4hlwZlLEpwvqhZPMqNHqzKgOrl0SBmvK8tD4RMgKXFJ2GUsKZQj30dxrmGT66FgyZwlLAKPU+SZEl5afss2dl4Yw0ufP6B5FcW7FOCGry/jvPWIUmFQAAtnNgPsJF3vnBJkIORu7BBsUwSzk58XQnTwZDfEHHSdHGD/NpD71JLTe1iBPecrjrLDS1OojLKyRRiVLTSmqh9V6jjH85uylpzwvQxrXHc07vkDuRblkyQe5uVuUEQlAE2OOpqp7joAFvilwzcOuDGUn+Oeo4K2sWacHzPwmvt/pdZRZ7XKujEblcOLGXA1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV1PR08MB11206.eurprd08.prod.outlook.com (2603:10a6:150:1ee::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.18; Sun, 5 Oct
 2025 18:19:17 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9182.017; Sun, 5 Oct 2025
 18:19:17 +0000
Message-ID: <d815a9e2-ad29-4c2d-8d88-bcff2635837d@iopsys.eu>
Date: Sun, 5 Oct 2025 21:19:15 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/24] mtd: spinand: driver improvements
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Chuanhong Guo <gch981213@gmail.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de,
 Andreas Gnau <andreas.gnau@iopsys.eu>
References: <20250930002109.3600886-1-mikhail.kshevetskiy@iopsys.eu>
 <CAOf5uwkGo7bAFdR_bVu0S2Mdta6smR4NzDfV7fXu1anyPACNPQ@mail.gmail.com>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <CAOf5uwkGo7bAFdR_bVu0S2Mdta6smR4NzDfV7fXu1anyPACNPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV2PEPF0000663A.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3d2) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV1PR08MB11206:EE_
X-MS-Office365-Filtering-Correlation-Id: cb019f95-8031-4e97-bbfa-08de043bb21c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QUFpeEh6SnRKNFdnMCt6Sm5PeUdGOXZneGFxY01idmtlMXZDT2x2R2RFdUJu?=
 =?utf-8?B?bFFFaG1Rb1VOUmloRWo1TWovc1FEWnI0aXlZcmtNdzI1YUZFM0I0MTR2a3NJ?=
 =?utf-8?B?MkN1ejBsUEJlMnJscFlzY1ZzUXdEN1BwSit0QTl3TEdvZStZSFZBdWdvOUxy?=
 =?utf-8?B?Y2ZMQzFPV1pMdHdPL1owOFVLenlLdnZkWW9WcDRyaldQMXB2TXRMRGNoZVNH?=
 =?utf-8?B?UnhUNEUvNko5RDNIeWxLSzJJM1daVWx0aDRUcE9nZGRDWnI2TW5saHg2Nklp?=
 =?utf-8?B?YWRsMFJkN1JVRTYwYy9qcGlMT3VITEl4Z2djTUNuTUxrNWcwT2dOd0o5TEV6?=
 =?utf-8?B?TmV6V3pxNlUzcGtGSjd3TjBFeXRJQllOV1d6UWgrQ1Uvck5tbGhXcDU2Nzd0?=
 =?utf-8?B?VndZdDAvZjFmT01RTkV2WjlIdTNCWVJ0dk9QdnFsdTZVNUFTNHcwY2lUYWVZ?=
 =?utf-8?B?cEZkcGFWaFkrUjlXaEZjSzg3ai85M3ZTMkw4YlNUS3RkL2VFcHE3Q0pBN1FV?=
 =?utf-8?B?NW9RN0RkbEtvTTkwZDdyaGJuemdhUGg0UElxUXFyQjRCTVB4R1QreE5yQk5a?=
 =?utf-8?B?WSsrMDVTdmhVNTEwM3ZmRUFNU0RJdXZuMW5OZnVxajEyVjR4Rmp4eE1tM1dC?=
 =?utf-8?B?RElvc0VqUnlLcWU1Uk5mbTR4RlFOZzFZZDdBZ09Zanl1RngvNHNmNXRFNG5p?=
 =?utf-8?B?dTBNZVFWeDZhWE5yK0FLdUhOUXJDK205ZURwWHFjb0xoNUVlejVjdndKTDMy?=
 =?utf-8?B?YkRtVUpSOFM0VVRTRGgrdnlLT0pOdHc2cHNIUnJGMmIrZFFnTUR5b05VTnUr?=
 =?utf-8?B?YS9uL0EvMlM0OGIzTHJWZ25hTGhHTTlUNTBXWjIzYzBGaU0xMEs2ZjVWRG1F?=
 =?utf-8?B?MnNzcUMvZE5ETUxvTVNzbjNKZC9kZ1VlSXcycDVsQThmYTNpNUFMS0xBd0p5?=
 =?utf-8?B?VkFtS05sbWVwZmxjOXZ3SkV4aVVpWHB2YkJQbTFhbDFkQ0oyTFNoeDlzNUlB?=
 =?utf-8?B?YTNLdVRuem8xeTdodmJ2b0p2UElYN1d3NlAxVHNkaDh4bTF6NkJCQmRLaHdI?=
 =?utf-8?B?UHdPUWc3U3dpSW5ZRXJpVGcrR2MzRStYbzJBazhuTitVQVRpc2VyaEV3QjE2?=
 =?utf-8?B?OVBhM2VEZmljNmt6Smk5aTFrdktxNlFRQ2oxUDArbkovMlFQK2NWOE5aMnp5?=
 =?utf-8?B?R3VMRlFGTE4xTUw5dDM1YnUwUVFLVTdoQUcrWUo0b3hDbzFvOWtPYmtYNE1N?=
 =?utf-8?B?RnFLQzRzZ1UvdXpYTVY1endrOHBFZ2hhSGJkVlZFaERodTVGZ3RzNWlrWDh3?=
 =?utf-8?B?eDNZMjR6OVgwUWFYSExWVHhuL29lWGJOVHBhTndDb3ZITS9mNDZaVGZnc2Rv?=
 =?utf-8?B?U2pML0MwVHlCUjRZWGFBZzllcTZ3d1RVczZIVC9VTWdPMEJPb25Idjh3MDM0?=
 =?utf-8?B?NUhRSHBqUm9rWjQzS0RncmFnWkdMYnVRVERqV0ZXMEExVmQyQ0ZQM2VpZ2Fz?=
 =?utf-8?B?TUFFd2tpVXEyYjR6Q3AvVW53b0xLMlFZMmJzOXQzVjlBTUxWajJScWJIdWxk?=
 =?utf-8?B?YStZWHFtUllQMWgwZ0N0K1hYUTZWSzU2NEFPcEhQeEg5VkZMcEhxTm1GQXc3?=
 =?utf-8?B?dzhxMjRQV0xOSjhvTkh5RHVTVUZBZkNLZFBhU2dUdktEendZY0U0WVVxK3BP?=
 =?utf-8?B?M081YUI1WGJ4YkJTZUpFZnp6eTVyZk9VeHh2cUdkcEpMSVBRcjlDL1N2U0Jo?=
 =?utf-8?B?bEhMeWxSUVN4Y0dzTXpSL011eW5GeGdhNTZHTTkzKzhQaFllVmlZREM0S3A5?=
 =?utf-8?B?QlV3dC90M0p1djllOVIrV2VxR09rN0ZhcERzKzZXNlpaZVJVZXFSUThyc0FU?=
 =?utf-8?B?SlBCRXd6LytlZ2lDaFkwTGs0OURJQXVBbGFzSHdGNVRCTXB1MDJyVWhUcGl1?=
 =?utf-8?Q?4KHMasSAFWRxusiYYNeCXopsKexOlyfj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkVJNGtzekU1Sno1UzZnZkJEdU1HdlJWa3UwMTA2c3NzTEgzWHZsOGpMNlpx?=
 =?utf-8?B?ZTMvRXY0WEpwR1BCaUpRSngvYzhLUmlrc3BhTmVGZ3lTQ3VCcDVabUV6ejBS?=
 =?utf-8?B?enVZTmpWbk9JVWVhZWlIN3hoL2EwaGVqL3RwcEo3L2gwUGkyS1FETnRseVpi?=
 =?utf-8?B?dFFDblVqZzFPWmhYN0Z4KzRKQkU4Yzkzd2psc1RndFN2c2hvL251U1R1bDky?=
 =?utf-8?B?bC9ud0JyU0k2eHpYOUxMUVU2TnFOcFBES2txTElSZmc3UTRlTVlxQkZJZWlR?=
 =?utf-8?B?UUlTNDF0Nlh5bUJNaHlxUzhlT2JXc1pUTlJIVm8zWkpzaUI2M25wb25jZlEr?=
 =?utf-8?B?dGZFNGNQcEI4N0RRMFEzRmNydG0rTEJNSGF5ckUraVVMRFdodi9tQ0s4TlV3?=
 =?utf-8?B?Und5bm1zY0tOR1JuTVN5ZnA0dG5tK2lUQ1dHa2JUVjBKWDQza2Nubk1tVXpU?=
 =?utf-8?B?c0lVMElRRU4xd0tybzVsUTlYV0lKeHk5cmVtREVibVdUcnFPcGVKb0Y3Ukx2?=
 =?utf-8?B?ajlRK0xSeGZ2dWJ0TVMrVnZJR0g0RlUxVWJzSjBHc1VsRWJYcFR1NHN5RHFv?=
 =?utf-8?B?Q0MwcG82dkVRS1B0VXk4S0djN0RCQkZZd0EyRW5TOWZXZGxkNUpwM0xiTy9r?=
 =?utf-8?B?eTQ1WURvTWpEalRHb0FJa3psSE5KeDVQTTJJUUtwUzlNbXk1Ym5INUFsY1BE?=
 =?utf-8?B?bGRQcTVLcmEyK0tmN1JmZS9pZlNzV3I2aVZtUlE4UDkxeUJMd1FTdTl1bGNJ?=
 =?utf-8?B?c1JtalAxRTY0V3hWVytWb0tUMXBMUEkyaUR4dmVZUTlYSGFGNTh2d1IvYUJG?=
 =?utf-8?B?MmlrdGZ1bGVadUdQdVlENGhSL3lkWkFVU3ZvcStWOE9yeEc2NnJuaUFuTTh0?=
 =?utf-8?B?azdqK2U0N0VYT0lZcjB4a0pzb2l1NnYweHVoYkQ0QVhQczQ2Z1NxRThDNmlO?=
 =?utf-8?B?WFFPa1lwMUZuekw1akpLdHNQZHZoQUpZc0V0ZzJuOEtXYy9nemQzVVlLQjdm?=
 =?utf-8?B?cjMwT3l1NWtUdjMxRXBsTzVYR1BOWnVXVGNoUWJ6eGhhRmlFemxhV2hIUjE0?=
 =?utf-8?B?czdhc2dGVzhvZ1hDUWdpTGgyQUg5YTZuM3pyTVdTaGRLMldyeUovVXRMeGNN?=
 =?utf-8?B?TXdKaTdDQkpMajRESmVqc0ZEVitFa1ozQ3BUcElxZi9PQ0JRZnRmN0cwblhi?=
 =?utf-8?B?T0tZWmVicjZVeEw5R3AxM0NneUxyR0ZIWTNaOXpYeXIrZVBCSEhJOE1iSkF1?=
 =?utf-8?B?WkVSS1pUeUNya01UaGRkZ0U4RGRuTkkydEc2OFVveGVibFJiRzFMbGgzMktx?=
 =?utf-8?B?d2tHRnV0S3pGWTVzd2FmS3owaWNxMmlvUXNxa29pcWg5YnNmZHBoQUZ2UG5v?=
 =?utf-8?B?cjFJdFU5YWxQOWVnQTJ2Nkp6anVKdXlHYWQ5RGM2SVFnd29YUmxEVUx3Wkta?=
 =?utf-8?B?anhIaFRJdDRXTWpXVW0zVmFWUithQUV1eXU5QjNWdExmQWdTanlVdmVYZlUx?=
 =?utf-8?B?L3k1SEh6K2FZNDJiYUZXR3BBbVpyMGFkZXZoVkVZWDdWYXdGb0dKWnZXZ1V6?=
 =?utf-8?B?dEJIM2p3TlVEVjF3RnRobTQ1RjBpTktlQjJLTmVLVTVjWVcwRldDdktpUHda?=
 =?utf-8?B?YmVDUy9ZWGVPcEZQbmFyd2ZUK1J5NVVObmZGeVNzSnhJQmpvMmNCSWRVUEFC?=
 =?utf-8?B?ZS9sUDY2MUc5N2tQOEYwbjJoL1VrVENTMGozUDBEZkRuRDRMOEZDSVRDd2V3?=
 =?utf-8?B?MkQ3NlNQOUJzcHBpSjlodWdvL1p0VXN1VEwyd003bHVTdytzRkM4Wm95enNv?=
 =?utf-8?B?c1I3R2tjbVByY2wvNkVJUW05dWxkQnRrSWVPZFYzL1lzVGNzK0JuNzBqVUVE?=
 =?utf-8?B?ZU9jNUZPUEtnc3NCUUt1aW1Sd1pXWHhlT2svL2NDdHNSSmNzNmhJUkJaNFR2?=
 =?utf-8?B?eldwVm43Ym5qMWxYOEFDbFBqQmRORFRyL0NJemx5citGZ1dWbllWUm5IVGJl?=
 =?utf-8?B?cGI5bFNESW1aaGlucGg4VmROaVVJKzRWWlpkdHVsYVBxR0U5WmtIVjQrMFBP?=
 =?utf-8?B?S2dZbnU1eEZ3aS9MK0RtSytMaWxMbXBOa0xFRzFiWUx0em5YdWc1UDREUGVy?=
 =?utf-8?B?TGI0WnNaK0hBcDZTQ29HRElVT3NRWWwvSk1GZXlCbU5GWHZnczBHNitvNGND?=
 =?utf-8?Q?8G0Ei/eDec0iHOD+KNhwJqg=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: cb019f95-8031-4e97-bbfa-08de043bb21c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2025 18:19:17.3952 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Nx/fgmEE7aKW196hsMMBI5PKK5GUwjTukhCZPUAtylyCiUwAu+I8EXgNrabB8whNLWE/THfM1XgTEB1M7b4TKi9OVyPQ9RDak8A8WBGa98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB11206
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

Hi Michael,

is there any plans of merging it and other my mtd patches to upstream
u-boot?

Regards,
Mikhail Kshevetskiy

On 30.09.2025 11:19, Michael Nazzareno Trimarchi wrote:
> Hi all
>
> On Tue, Sep 30, 2025 at 2:21 AM Mikhail Kshevetskiy
> <mikhail.kshevetskiy@iopsys.eu> wrote:
>> This patch series makes u-boot SPI NAND driver almost the same as in
>> linux-6.17. This provides the following improvements:
>>  * it becomes easy to port changes from linux kernel
>>  * more flash is supported
>>  * spi drivers can accelerate flash reading/writing using spi-mem dirmap API
>>  * continuous reading mode was supported (for some flashes)
>>  * OTP support was added (for some flashes)
>>  * add support of special data recovery reading (for some flashes)
>>  * bug fixes
>>  * other minor improvements
>>
>> The following linux kernel driver features was not implemented
>>  * support of different ECC engines
>>  * per operation maximum spi bus frequency
>>
>> The code has been tested on Airoha AN7581 (64-bit) based boards
>> equipped with flash memory Micron MT29F2G01ABAGD
>>
>> Additionally the patch series includes continuous reading mode fixes.
>> The corresponding linux patches were accepted to nand/next branch
>> of mtd/linux.git repository.
>>
>> Changes v2:
>>  * update patch description
>>  * add fixes for continuous reading mode
>>
>> Changes v3:
>>  * fix duplication in patch description
>>  * add more information about commits ported from linux kernel
>>
>> Changes v4:
>>  * the original authorship was preserved for several patches
>>  * the code was synced with the latest shapshot of future linux-6.17-rc1
>>  * spi-nand was replaced by spinand in patch description
>>  * continuous reading mode fixes were updated
>>
>> Changes v5:
>>  * add missed SoB tags
>>  * improve patch messages
>>  * add tags for patches ported from linux
>>  * drop continuous mode fixes (will be sent after corresponding linux fixes)
>>
>> Changes v6:
>>  * improve patch messages
>>
>> Changes v7:
>>  * patches to fix continuous reading mode was added.
>>
>> Alexander Lobakin (1):
>>   mtd: spinand: core: add missing MODULE_DEVICE_TABLE()
>>
>> Cheng Ming Lin (2):
>>   mtd: spinand: Add support for setting plane select bits
>>   mtd: spinand: Add read retry support
>>
>> Daniel Golle (1):
>>   mtd: spinand: set bitflip_threshold to 75% of ECC strength
>>
>> Gabor Juhos (1):
>>   mtd: spinand: propagate spinand_wait() errors from
>>     spinand_write_page()
>>
>> Mikhail Kshevetskiy (15):
>>   spi: spi-mem: Extend SPI MEM ops to match Linux 6.16
>>   mtd: spinand: Use the spi-mem dirmap API
>>   mtd: spinand: Extend spinand_wait() to match Linux kernel
>>     implementation
>>   mtd: spinand: Make use of spinand_to_[mtd/nand]() helpers
>>   mtd: spinand: Align logic for enabling ECC to match Linux kernel
>>   mtd: spinand: Refactor spinand_init* functions
>>   mtd: spinand: Refactor ECC/OOB functions
>>   mtd: spinand: Sync core code and device support with Linux 6.10
>>   mtd: spinand: add support of continuous reading mode
>>   mtd: spinand: add OTP support
>>   mtd: spinand: Enhance the logic when picking a variant
>>   mtd: spinand: Sync core code and device support with Linux 6.17-rc1
>>   mtd: spinand: fix direct mapping creation sizes
>>   mtd: spinand: try a regular dirmap if creating a dirmap for continuous
>>     reading fails
>>   mtd: spinand: repeat reading in regular mode if continuous reading
>>     fails
>>
>> Miquel Raynal (2):
>>   mtd: nand: Add a NAND page I/O request type
>>   mtd: spinand: Add a ->configure_chip() hook
>>
>> Takahiro Kuwano (2):
>>   mtd: spinand: Remove write_enable_op() in markbad()
>>   mtd: spinand: Introduce a way to avoid raw access
>>
>>  drivers/mtd/nand/spi/Makefile         |   5 +-
>>  drivers/mtd/nand/spi/alliancememory.c | 155 ++++
>>  drivers/mtd/nand/spi/ato.c            |  88 +++
>>  drivers/mtd/nand/spi/core.c           | 975 +++++++++++++++++++-------
>>  drivers/mtd/nand/spi/esmt.c           | 123 +++-
>>  drivers/mtd/nand/spi/foresee.c        | 107 +++
>>  drivers/mtd/nand/spi/gigadevice.c     |  86 ++-
>>  drivers/mtd/nand/spi/macronix.c       | 289 ++++++--
>>  drivers/mtd/nand/spi/micron.c         | 180 ++++-
>>  drivers/mtd/nand/spi/otp.c            | 369 ++++++++++
>>  drivers/mtd/nand/spi/paragon.c        |  24 +-
>>  drivers/mtd/nand/spi/skyhigh.c        | 149 ++++
>>  drivers/mtd/nand/spi/toshiba.c        |  63 +-
>>  drivers/mtd/nand/spi/winbond.c        | 361 +++++++++-
>>  drivers/mtd/nand/spi/xtx.c            |  20 +-
>>  drivers/spi/spi-mem.c                 |  45 +-
>>  include/linux/mtd/nand.h              | 157 ++++-
>>  include/linux/mtd/spinand.h           | 374 ++++++++--
>>  include/spi-mem.h                     |  93 ++-
>>  19 files changed, 3154 insertions(+), 509 deletions(-)
>>  create mode 100644 drivers/mtd/nand/spi/alliancememory.c
>>  create mode 100644 drivers/mtd/nand/spi/ato.c
>>  create mode 100644 drivers/mtd/nand/spi/foresee.c
>>  create mode 100644 drivers/mtd/nand/spi/otp.c
>>  create mode 100644 drivers/mtd/nand/spi/skyhigh.c
>>
>> --
>> 2.51.0
>>
> Long queue but I will pick them today, together with mtd patches
>
> Michael
>
