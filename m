Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE383D1039D
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 11:29:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F69483B55;
	Wed, 26 Nov 2025 12:29:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Sos1iMU0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CF3983B55; Wed, 26 Nov 2025 12:29:06 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF99983655
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 12:29:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s4fc4jJYnidmVJxA7m0Wn8G4XbzNhBACGIirhiyXoGUMTTTBODcpXis5/Mhkh3LWCAxP1t5z5HvMWKM8Ipp9Rj26DHtB71FL+VDUYGOat26ZkBjyOTfOAhTmkf5EMW8Zg/SXOKMogs9zPJ7XBbwShlA8T0a+lVmUQ8GPrf7Z3rXtwxNSHqzphBbYY+pWonx07ndaxuwYzIGsYWMTa9GJWU1G5oXpv+Us3V8S5TEZ7CHselfVPJ2h6Iwfkjnkg+YjMEL/Y7hsWtGLG9NHqWoJRwyMjyPSZUDD+f7fOlIdEmFGN2Y34GiByNKxbl6sDooitXpg9DlkBfA25MMUPS79lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xe4CYhmtPprwn8pPDQUoqtkYpm05owASjHg+gsNra4s=;
 b=wJK/gDSCHJoIN/OsApCQOLySoBjRutJBV5qbbPCU+cptCqzpF7sWlKDEz1NHDFq9Hb/UEJ/Dzplbw6SlcTK4DHK8hbWSxMUdtX5TSV21jAdDXPdZzFIGD+Jt0RHOKkkkWsG6+VwngpmzecqZllgCHN83u3yKzDishWXcJOeZtjajRIif03leQItd0v1e3yRx6+NwYEdDfl6OeePUgmf5a2ehq+cQttoDH2BXCFd9K33xz+wk6zo2Xo0OnsudXqgxAVjLyrKTqiR2I3wF/vk4F/N+681Vs64HaxHC7FkWzNLrN1QVweGcSiqT83uxb/ORMOlUQocaFdDD/D1WWcTGfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xe4CYhmtPprwn8pPDQUoqtkYpm05owASjHg+gsNra4s=;
 b=Sos1iMU0NsupmT+EsE8AaiSc7sOBf/VftAtFkRjS6BC+NmxP14s+5UluVIJQMafCgClFwYpPrX8Lm6XaH0JmDQCroY6esl/5WxdFtczmK7ln1+43GA7uyIKMx4VsbTKz1VBO+FMCj9DqS2zrMziF2momzASv8Q4FYYQQOOq1CTk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 11:29:00 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 11:28:59 +0000
Message-ID: <50d0c028-374e-45d7-ad85-29d43bdb9767@cherry.de>
Date: Wed, 26 Nov 2025 12:28:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] tools: binman: fit: add support for OpenSSL engines
To: Simon Glass <sjg@chromium.org>, Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Aristo Chen <jj251510319013@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>,
 Anton Moryakov <ant.v.moryakov@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 Bryan Brattlof <bb@ti.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 Peter Robinson <pbrobinson@gmail.com>, Eddie Kovsky <ekovsky@redhat.com>,
 Kever Yang <kever.yang@rock-chips.com>, Yannic Moog <y.moog@phytec.de>
References: <20251121-binman-engine-v3-0-b80180aaa783@cherry.de>
 <20251121-binman-engine-v3-3-b80180aaa783@cherry.de>
 <CAFLszThFdfMeFTtvDyXfH1iO2zx5fe9rJJSz=MQBGJiXB4HG5w@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszThFdfMeFTtvDyXfH1iO2zx5fe9rJJSz=MQBGJiXB4HG5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0034.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::7) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DBBPR04MB7979:EE_
X-MS-Office365-Filtering-Correlation-Id: 1accbffd-f7cc-4663-87ca-08de2cdefe84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YzRtMmdGc0E5ZE9mSEdRSmhLbGpPVnM0V0lwR29EM292V3lmMHNpTjJYTzVZ?=
 =?utf-8?B?VWdVLzRkVVJJTjgrck03NmtJMk5sWWwwRFhOODErMWY5VFNucXlBWk1uTG1T?=
 =?utf-8?B?emM5SlcrMlA3azh4RjVDdzNIWjVqVGZEMW5UWnVRUFhyTTNaWFRBM0V5dHJ5?=
 =?utf-8?B?ZHNrTmNmaVByV2tRY2ZoTUpTNFdTUjBIeWhUMXl2LzNtWUZDUTlGd1dCdkUw?=
 =?utf-8?B?b3g3ZW1hVkk0bTNrVmJ4MjVvL3l0Si9hcWREV2tqTmZBSzA3d29rUVpaSDZT?=
 =?utf-8?B?U1hLd3VNdDQrdEQzY0RwTFR4bnloU2ZRQnQzTHZKVUFMdkNIdjJPajNHdCtk?=
 =?utf-8?B?VGNuRXRDK1VOMzZSMlJ0cW0wRFV4RnRJbGhtOTZSSXpwYytONEZ5NmI5cHM3?=
 =?utf-8?B?NVNmcU5tbmdqWnI0dEZkeDF5ZTNKVU9tTW1pSWcxVmhkYWhHRVMrYmQrSGQy?=
 =?utf-8?B?NWE5eHordU10YWpjYUZGN0wwWnNheEtVbHBRVWVYTVlVKzZycFB1S1l0aEc4?=
 =?utf-8?B?V0loTE5BSDZBYkdXQVd4MDhaTUZleGg1VDl4TzVPUFI2bGJoYS9KQWtnTUR5?=
 =?utf-8?B?d2d2WDdxUnlXamZDNnpNOVB4UnJ6RExmTUJXMGRFa1FHcERVeXRiWjJJQ250?=
 =?utf-8?B?cmVZM3cxcnUyRGNPQy9YM2wyUmpONEtMeEJ6Y0trSkNOSmRrc21YM01HRk1K?=
 =?utf-8?B?MktJVHNlNUFOR1hMV3BuWWVyT3dKRlFBdHd1Nkgvc0lSME93dkZmeTRFdlZs?=
 =?utf-8?B?RjBXV3ZBU09IQjIrZ0U5MzIvWFZVb2pWN091dmNvWGpWaHh5bDUvMGxwaDJy?=
 =?utf-8?B?clNpM0cvaVNTN0M0ZklLcmxWekhFVVFyQkJNU1VxTXpvZVE1SkJZQXhWUWQy?=
 =?utf-8?B?Qy91THRwQjBWRjVVTzFwM2gyclNQNDBxWVRVTWNSQjg2VVNiR1Q3UWtwdXR3?=
 =?utf-8?B?U25mK1ZGeFBpODhqOGpNamdLdm14eW0vK1RwSE9TWkJuUnZaOGZIS0RWemo0?=
 =?utf-8?B?NGpodEx4YjBSUG5ENDN6NFF4VTg1bHZVdXdmSEsxN2hYQTRBaUFlY3E0ME5q?=
 =?utf-8?B?QkpraGpGZTNFUmRJUFdzRDd4L1JrUVgrd3NlUXQyQ21SWVFtTEhFOFlpL251?=
 =?utf-8?B?UitLQ29NQ3dlTHA5STNCL3hCenBPME1wY1VOdmt2M0lNMmROeHgrUU9FelVT?=
 =?utf-8?B?bXY0VXJJYlRpVzV1TU1LUWdEL05uNUg0THBSWUFuVEtNLzZRM0VJREova2hG?=
 =?utf-8?B?T2Fxd1hXSkVTTzlqUlNXQ1Ayb1l5cm5ISXpJbUNReVpYbmZETXJnS1U1RXZZ?=
 =?utf-8?B?QjBUZ1k3ck1xK2lWbFFYdE5ka2lac1QrU0UwUWRBZDBhek9yYmpOUStyWEt5?=
 =?utf-8?B?WFhWdGRxNEdmZFVaNWN5ZUl0K3lRc0k3QVdzVFlENnhoT2pjaUh0bnZjWnY3?=
 =?utf-8?B?TkFXWTZoYy9acnRjaWpBSldKVDUvQzFndVFjU3ltVGNFeVhrci9PaFU2Q3Jl?=
 =?utf-8?B?TE1hNVdiRWRTZ0VCeDdYOEhXNnRnVzdlUGh3UWRVdTVpVUR1aEtjNnozUURY?=
 =?utf-8?B?UHJGNFhsbTcveEZrNGlsK21CYVlka0hmSVpzdTMzK3ZYdzBuYXZZNE95Ujdz?=
 =?utf-8?B?MXloMU81Qm9ZRG1hRzAzZjB4MHo3U3RnSklldG1lMXBwdTZUa1NoMHJldzZl?=
 =?utf-8?B?RitRWmR6RjdhbGR1Vkl2OGcwbXhURWZKVWtaT2Zaanp4N0s1eVBzcVhiSHhL?=
 =?utf-8?B?ekp0WGwrekViM2VBaDhmVFhLVXk3VGlzcXhxRFFwYzNvNEZ6amkzMmtWd1ZO?=
 =?utf-8?B?Wk50eWR4a2o4aG5kV0Z5TzB2cUpJZm1qYXpQc1R1K0NJb1R5SDE0WVRJUW9O?=
 =?utf-8?B?dUFFZ1dTZzVOTWVvQW1GdCtjVU8rdHZBMHl3bGpyeFVTbUE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDN0ZWorb3U2ZmxjYjlKTDBBdGt1ZWhNWlhBTmJleldrTW1ZTk5VV2RIZVNv?=
 =?utf-8?B?dDZYaXNrbWxBWGx3eUZncTBCUktKaUtJZzl5SFhlMlBhU3RCVTVHQ3Rza0sx?=
 =?utf-8?B?Z2tKL0tqTkNoL0VaT0p4SFFrQ2xLYmVaQktyc0piUHpUbkc3MHVOWkEzMm5P?=
 =?utf-8?B?SUNsdk1kYkk2RjdOOHpTWHFQb3k3bHRnRm9VT0gxMzlDSlNobFcyVHlzQVRx?=
 =?utf-8?B?Tmh2WVdveHV5M3o2Z2paRmZYRTd1Z3dhbXY4Mmh6clRoNXU1ZGQ5czRUZWxk?=
 =?utf-8?B?cnJwcmtZU1BZMDBQcUtLN2pSaG13dDlsSWRwVHpRVVVHM3FCRXpKNkRVck9U?=
 =?utf-8?B?R1BybE9mTFZUZkdKWGFHRlFSUUdOR3E1MERVTXRtUlRkblE1RW5hZ29Remc3?=
 =?utf-8?B?Q0Z2bGZUSGxQU05OMEsyVlBxcko4dllJUXkwbEIyaVpiRHdGVWFvbHAxN3l2?=
 =?utf-8?B?dk9WSEhUUzdJMmFyNmpLN0FWalpHRHdHMzNySGcvNmY5ZHBaZ3N3R0JEb3NO?=
 =?utf-8?B?dWg4US9xcmhTNWh0N2pHdDVqNjZIZ0h2WGZUNkFFS2Vjdk5PYnNiSnZVZDJR?=
 =?utf-8?B?SC93QjJxQmRQbjhJOHVBVllMYXBaQVV3VTF0WW9Ecm1namI3SUZYSWV1dXRT?=
 =?utf-8?B?dlBmY1ZmOEFkQzZ1UW9zbStEb1JQZVdKb1IzeExQb0dVOWdVaWZpYWZFRzk2?=
 =?utf-8?B?UktZMnFLOTZMNzBtSGdiZ2VzaEVnRStiYnBRbk04WERBL1NGOFNXazFZOENq?=
 =?utf-8?B?Njg2SytpV0hHR1l0YkM1d2hNb0xud1dyUGVYcFJNaUFzUkZwQ0hCUXgzUWZs?=
 =?utf-8?B?QW1POEdkR1hHZU5uZjlFTVlxcnlYVjNBNWpoTHEySm1xR1h5ckg1a29aUVpO?=
 =?utf-8?B?WGVuYldoZ2E4TC9GYkp1cm81ZmkyTzIvN1l4SlpOc3NuUXB1VThuQ2lqZE5q?=
 =?utf-8?B?TERmaWFRTlRUL2hObnZHTVZqV29BZmFQendXNGJtYVYzaVpuQTVDeGtFUmZU?=
 =?utf-8?B?NVp6SGJIdVB3NkxVNElwZE1Sbm1pL3oxT3YyWEgyRUJzZkVOakhpdlM4ME5U?=
 =?utf-8?B?L3RucHNmcWM2eW5sbGtBK0xOenZOdThGSEZ3QU91YWFib25XQmUwMFowblkr?=
 =?utf-8?B?V2JFekhTRnBVSlgyQ0ZnUUNqRitPOFJ6OEdvemhURmNyTTZLZ1V4Zk5tczc4?=
 =?utf-8?B?Uk9ZbWViL3ViWnN2ZWZQeGxSN3RVamdjQWd3RzIzU0w3emdtaGZHaFAwTDZv?=
 =?utf-8?B?MStubnRQYzJheU5EOSsrNGNBZ0hqdHd5VDBXcVFxY05xbXNCY0dCb1NCbmcr?=
 =?utf-8?B?OGh5bmIyaEFEQzEyZXcrNHJuZ0duazNxWUFVajRVTHhMdVZFMTduMG1tS3Fy?=
 =?utf-8?B?NXdSTXgxM2FHZDRrcFVMcXpGUWZRMXV3Vng0aVA4YnVTTE5BSi9oR2N1Q3Fk?=
 =?utf-8?B?MlJ2ekJKY1phVmxZR1EwRUpjbWlEeHU3YzVmWVhpZytoZTFDSFpyWE9BVkxI?=
 =?utf-8?B?bGlRcHhoVmlNbmJRMTRKZXZVcG51VFJxYU51V2hiUFhIYk43bkk1Tm1sV2po?=
 =?utf-8?B?T3FhWFBDdDkvc3RpbTIxT0llUnNIaGlOOVdueWEwWWFQQkVQNDJjZWJQeW5N?=
 =?utf-8?B?cXpmNmxCdjYwa095ZnFJK0hxdnhVVGtiSXVJaEpiOFRtM3BvNVhnd21KLzFu?=
 =?utf-8?B?YWlZS0dkc1ZJeU1EUU5QL2xGclFUWDJ2MU5EQkRubGl0TEN6dlFIbWZNRmIw?=
 =?utf-8?B?WjJidkVpNHFMajZTeWNwSjRLOTVqZ0ZmU1pUNmdtRVZuakk1czJWUXNsL3pG?=
 =?utf-8?B?bFY0M21XMnNta0NZbTRxcjVXR2JMMFhhNkthVXZsM2h6emp5OEFYOXFpMTNk?=
 =?utf-8?B?YUkwSUQ3c2Z5dGpqKzQzYWJGbnNyUVpwdVVqbVZYVmw0dmNiUHkwcFNUVmpX?=
 =?utf-8?B?NlQ4ZE5xVTBzVGgvS0N2cE5TQmJUMUs4bWJYWnQzaDBTcVJsUHFiRHU3K1Iy?=
 =?utf-8?B?b2ZQUDBZQUwvbHR1cTh3d0xiOTFJNWJQVnNzU3djb2NaVEd0UFFGQTdkNkxO?=
 =?utf-8?B?SzdSd1JxZDl3L1hocVdNTnpFTk56Wk1nTUVVY1pkUCtWdUdiMEdxS3hDVVQr?=
 =?utf-8?B?MksrQTVvVEkxMTcwNGFJMXVoczU5SmdrdGc0OUJ1ajZXV1QvUVhicjU5eEZ6?=
 =?utf-8?B?V0E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1accbffd-f7cc-4663-87ca-08de2cdefe84
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 11:28:59.8676 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vaKFcNtYg3mkQXeVZ4S+5SNSLqPWJQXBeZ8mIkTNsk7BCXASAwCkK1js0PYwKFGC29WCZGPNBMXOr7DLWf5BuCLDs+lPbECHTzZk/DAkF68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7979
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

Hi Simon,

On 11/25/25 11:15 PM, Simon Glass wrote:
> Hi Quentin,
> 
> On Fri, 21 Nov 2025 at 10:15, Quentin Schulz <foss+uboot@0leil.net> wrote:
>>
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> This adds support for using an OpenSSL engine for signing a FIT image.
>> To use it, one should set the fit,engine property at the FIT node level
>> with the engine to use. This will in turn call mkimage with the -N
>> option.
>>
>> The -k argument to mkimage can be specified via fit,engine-keydir. If
>> not specified, -k is not passed to mkimage. This property is especially
>> useful for pkcs11 engine to specify slots, token label, etc...
>>
>> As far as I could tell, mkimage encrypts and signs a FIT in one go, thus
>> the -k argument applies to both signing and encrypting. Considering we
>> reuse the -k argument for two different meanings (info to pass to the
>> engine when using an engine otherwise the directory where keys are
>> stored), we cannot reasonably encrypt using local keys and signing with
>> an engine, hence the enforced check. I believe it should be possible to
>> support encrypting and signing with the same engine (using different
>> key pairs of course, via different key-name-hint likely), but this is
>> left for the next person to implement.
>> This is why the property is named fit,engine and not fit,sign-engine.
>> Ditto for fit,engine-keydir.
>>
>> The public key (with .crt extension) is still required if it needs to be
>> embedded in the SPL DTB for example. We could probably support
>> retrieving the public key from an engine, but this is a change to make
>> to fdt_add_pubkey.c.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>>   tools/binman/entries.rst  | 54 +++++++++++++++++++++++++--
>>   tools/binman/etype/fit.py | 93 +++++++++++++++++++++++++++++++++++++++++++++--
>>   2 files changed, 140 insertions(+), 7 deletions(-)
>>
>> diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
>> index 8922d6cd070..a81fcbd3891 100644
>> --- a/tools/binman/entries.rst
>> +++ b/tools/binman/entries.rst
>> @@ -885,9 +885,10 @@ The top-level 'fit' node supports the following special properties:
>>
>>       fit,sign
>>           Enable signing FIT images via mkimage as described in
>> -        verified-boot.rst. If the property is found, the private keys path
>> -        is detected among binman include directories and passed to mkimage
>> -        via  -k flag. All the keys required for signing FIT must be
>> +        verified-boot.rst.
>> +        If the property is found and fit,engine is not set, the private
>> +        keys path is detected among binman include directories and passed to
>> +        mkimage via -k flag. All the keys required for signing FIT must be
>>           available at time of signing and must be located in single include
>>           directory.
>>
>> @@ -898,6 +899,53 @@ The top-level 'fit' node supports the following special properties:
>>           required for encrypting the FIT must be available at the time of
>>           encrypting and must be located in a single include directory.
>>
>> +        Incompatible with fit,engine.
>> +
>> +    fit,engine
>> +        Indicates the OpenSSL engine to use for signing the FIT image. This
>> +        is passed to mkimage via the `-N` flag. Example::
>> +
>> +            fit,engine = "my-engine";
>> +
>> +        A `-k` argument for mkimage may be passed via `fit,engine-keydir`.
>> +
>> +        When `fit,engine` is set to `pkcs11`, the following applies:
>> +
>> +        - If `fit,engine-keydir` is absent, the value of `key-name-hint` is
>> +          prefixed with `pkcs11:object=` before being passed to the OpenSSL
>> +          engine API::
>> +
>> +              pkcs11:object=<key-name-hint>
>> +
>> +        - If `fit,engine-keydir` contains either `object=` or `id=`, its
>> +          value is passed verbatim to the OpenSSL engine API,
>> +
>> +        - Otherwise, the value of `fit,engine-keydir` is followed by
>> +          `;object=` and the value of `key-name-hint` before being passed
>> +          to the OpenSSL engine API::
>> +
>> +              <fit,engine-keydir>;object=<key-name-hint>
>> +
>> +        If `fit,engine` is set to something different than `pkcs11`, the
>> +        value of `key-name-hint` (prefixed with the value of
>> +        `fit,engine-keydir` if present) and passed verbatim to the OpenSSL
>> +        engine API.
>> +
>> +        Depends on fit,sign.
>> +
>> +        Incompatible with fit,encrypt.
>> +
>> +    fit,engine-keydir
>> +        Indicates the `-k` argument to pass to mkimage if an OpenSSL engine
>> +        is to be used for signing the FIT image. Example::
>> +
>> +            fit,engine-keydir = "pkcs11:model=xxx;manufacturer=xxx";
>> +
>> +        Read `fit,engine` documentation for more info on special cases when
>> +        using `pkcs11` as engine.
>> +
>> +        Depends on fit,engine.
>> +
>>   Substitutions
>>   ~~~~~~~~~~~~~
>>
>> diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
>> index db40479d30e..f28b1e6b4cb 100644
>> --- a/tools/binman/etype/fit.py
>> +++ b/tools/binman/etype/fit.py
>> @@ -104,9 +104,10 @@ class Entry_fit(Entry_section):
>>
>>           fit,sign
>>               Enable signing FIT images via mkimage as described in
>> -            verified-boot.rst. If the property is found, the private keys path
>> -            is detected among binman include directories and passed to mkimage
>> -            via  -k flag. All the keys required for signing FIT must be
>> +            verified-boot.rst.
>> +            If the property is found and fit,engine is not set, the private
>> +            keys path is detected among binman include directories and passed to
>> +            mkimage via -k flag. All the keys required for signing FIT must be
>>               available at time of signing and must be located in single include
>>               directory.
>>
>> @@ -117,6 +118,53 @@ class Entry_fit(Entry_section):
>>               required for encrypting the FIT must be available at the time of
>>               encrypting and must be located in a single include directory.
>>
>> +            Incompatible with fit,engine.
>> +
>> +        fit,engine
>> +            Indicates the OpenSSL engine to use for signing the FIT image. This
>> +            is passed to mkimage via the `-N` flag. Example::
>> +
>> +                fit,engine = "my-engine";
>> +
>> +            A `-k` argument for mkimage may be passed via `fit,engine-keydir`.
>> +
>> +            When `fit,engine` is set to `pkcs11`, the following applies:
>> +
>> +            - If `fit,engine-keydir` is absent, the value of `key-name-hint` is
>> +              prefixed with `pkcs11:object=` before being passed to the OpenSSL
>> +              engine API::
>> +
>> +                  pkcs11:object=<key-name-hint>
>> +
>> +            - If `fit,engine-keydir` contains either `object=` or `id=`, its
>> +              value is passed verbatim to the OpenSSL engine API,
>> +
>> +            - Otherwise, the value of `fit,engine-keydir` is followed by
>> +              `;object=` and the value of `key-name-hint` before being passed to
>> +              the OpenSSL engine API::
>> +
>> +                  <fit,engine-keydir>;object=<key-name-hint>
>> +
>> +            If `fit,engine` is set to something different than `pkcs11`, the
>> +            value of `key-name-hint` (prefixed with the value of
>> +            `fit,engine-keydir` if present) and passed verbatim to the OpenSSL
>> +            engine API.
>> +
>> +            Depends on fit,sign.
>> +
>> +            Incompatible with fit,encrypt.
>> +
>> +        fit,engine-keydir
>> +            Indicates the `-k` argument to pass to mkimage if an OpenSSL engine
>> +            is to be used for signing the FIT image. Example::
>> +
>> +                fit,engine-keydir = "pkcs11:model=xxx;manufacturer=xxx";
>> +
>> +            Read `fit,engine` documentation for more info on special cases when
>> +            using `pkcs11` as engine.
>> +
>> +            Depends on fit,engine.
>> +
>>       Substitutions
>>       ~~~~~~~~~~~~~
>>
>> @@ -588,6 +636,29 @@ class Entry_fit(Entry_section):
>>
>>           return paths[0] if len(paths) else None
>>
>> +    def _get_fit_engine(self):
>> +        """Detect whether an OpenSSL engine is to be used for the FIT
>> +
>> +        Returns:
>> +            Tuple(str, str): Name of the engine to use, as first element of the
>> +                             Tuple. None if no engine to use.
>> +                             keydir arguments to pass with the engine to the
>> +                             OpenSSL API, as second element of the Tuple. None
>> +                             if no keydir to pass.
>> +        """
>> +        engine = None
>> +        engine_keydir = None
>> +
>> +        prop = self._fit_props.get('fit,engine')
>> +        if prop is not None:
>> +            engine = prop.value
>> +
>> +            prop = self._fit_props.get('fit,engine-keydir')
>> +            if prop is not None:
>> +                engine_keydir = prop.value
>> +
>> +        return engine, engine_keydir
>> +
>>       def BuildSectionData(self, required):
>>           """Build FIT entry contents
>>
>> @@ -620,7 +691,21 @@ class Entry_fit(Entry_section):
>>               args.update({'align': fdt_util.fdt32_to_cpu(align.value)})
>>           if (self._fit_props.get('fit,sign') is not None or
>>               self._fit_props.get('fit,encrypt') is not None):
>> -            args.update({'keys_dir': self._get_keys_dir(data)})
>> +            engine = None
>> +            keydir = None
>> +
>> +            # Engine only supported for signing for now
>> +            if self._fit_props.get('fit,sign') is not None:
>> +                engine, keydir = self._get_fit_engine()
>> +
>> +            args.update({'engine': engine})
>> +            # If no engine, keys must exist locally, find them
>> +            if engine is None:
>> +                keydir = self._get_keys_dir(data)
>> +            elif self._fit_props.get('fit,encrypt') is not None:
>> +                self.Raise('fit,engine currently does not support encryption')
>> +
>> +            args.update({'keys_dir': keydir})
>>           if self.mkimage.run(reset_timestamp=True, output_fname=output_fname,
>>                               **args) is None:
>>               if not self.GetAllowMissing():
>>
>> --
>> 2.51.1
>>
> 
> Were there any changes on this one? It looks OK to me.
> 

Yes. You can see the git-range-diff between both versions with:

$ b4 diff -v 2 3 -- 
https://lore.kernel.org/u-boot/20251121-binman-engine-v3-0-b80180aaa783@cherry.de/T/\#t

Also see cover letter where I list the changes made to the v3 compared 
to v2 and why I decided to not add your and Wolfgang's trailers.

> You should be able to do: if 'fit,sign' not in self._fit_props
> 

$ git grep "in self._fit_props" tools/binman/etype/fit.py

returns nothing. I would rather have the same logic to get properties 
within a given file.

Cheers,
Quentin
