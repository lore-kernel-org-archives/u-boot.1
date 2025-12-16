Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD0ED5CCA0
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 09:50:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE6DB833C6;
	Tue, 16 Dec 2025 10:50:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="IojAZrhm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B4C2838A5; Tue, 16 Dec 2025 10:50:35 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F00C8334F
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 10:50:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DLQP3fPSGYegk93+X77xk1pmwfki7oOtPVQ8GQ8+x4OdLK1nmRVAYbwGbl4e2eER/uNgp+V1ytFFtedMGidZKsZeTJEPJQRnWRBaid0OZs57L3mUlgSohp0TZdSRrXTtN29wmmGKK+Sis6BRT5PNvrf2hn7QMF+SPnOlCRvFCEACNc0JpIH+y0cYmDk6Epjuqco3paSgotrHXio0Czr7JHKuMH0uGFSLUYgxiiSE2yYzKbycHZ0v5Fu8PwqpdeKBbb0WT4bYN2NZ+mrt4ds27f+ryC/R244vF0BBnwBM2iv1UcfFZJ5ExeYBPyIwaqGypir3q8BSJ7S08z1DRPpMUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TndX30eV7PbQJgTnqVIoZSa8d4jrxyiYIq8lP3aytB4=;
 b=BQ8J2dhsf+c/6ztg3Oep8zBfx46je5CHHz965V/2t+v7q47gjhuVmLyaMy8SqLA8p3/mLKSaJMYwa8qYarGekFCoIT9zRKkOUCBvTvXqJy82P6yzTGG0RiuhPOpFtLgL3SGML80fJwuSSgLQ6QfKK4cN9g0oqOzJmulLWn7IqhTo6j/r65LwRJo81jScgqts3uPZaolRiWpDTGCdfzsDeodAV6W1Ni5SYrJ9/QNN0TWzyMS+kBrtoKnd/q3MD3ZDhixwtadb5zsPcSa9UiTMQVMNpbJd/RTTnxDIkcW369PISj6d61isY+LdJDztz5tfghvB2gGGiraXsveWCeogcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TndX30eV7PbQJgTnqVIoZSa8d4jrxyiYIq8lP3aytB4=;
 b=IojAZrhm1gN3u/M/c5WobaOLXnRBQAz9hlKJuWdaNBq/bWXUYlHepm+a/avOtkPAVK4LbKdjykgnpN6PmrwBvrDaLntbEu9dcXJOIH2miu/EgtRo5gClBfDICMAhVBOW8chWbMf75l7PxXQq/1viP8K/shFv9TOPGiZxOucSkeA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by PAWPR04MB9935.eurprd04.prod.outlook.com (2603:10a6:102:387::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 09:50:28 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 09:50:28 +0000
Message-ID: <13e5946a-26d7-4b60-91f1-df9a3ba36f52@cherry.de>
Date: Tue, 16 Dec 2025 10:49:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/7] usb: Kconfig: imply DM_USB_GADGET
To: alice.guo@oss.nxp.com, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Marek Vasut <marek.vasut@mailbox.org>, Ye Li <ye.li@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>, Peng Fan <peng.fan@nxp.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Lukasz Majewski <lukma@denx.de>, Sherry Sun <sherry.sun@nxp.com>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 George Chan <gchan9527@gmail.com>, Simon Glass <sjg@chromium.org>,
 David Zang <davidzangcs@gmail.com>, Alice Guo <alice.guo@nxp.com>
References: <20251216-imx8ulp-v1-0-504115a53020@nxp.com>
 <20251216-imx8ulp-v1-5-504115a53020@nxp.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251216-imx8ulp-v1-5-504115a53020@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0026.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::22) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|PAWPR04MB9935:EE_
X-MS-Office365-Filtering-Correlation-Id: 48b06d2f-3b55-476c-0fee-08de3c888b2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|366016|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZFhEbm5hU3VSb0tNdFVtSUVjQTdDQTJSbnZxSml2UWRwbXVEdkpPalBZa0JU?=
 =?utf-8?B?NjhDR2VSTDgwMHRMRk51SmpxNjByQit1NnRwVWpZZnprdkw4Zi9zQjc4Smds?=
 =?utf-8?B?SGw2ZWNmU0RoSzFsaUFwU2dYc0lBK0VZSDhVWnBFQSs3eWRhb2E4TklwTFdW?=
 =?utf-8?B?SGVCS21UR1lWbTRSenJ0NFVVdlBKZ2NLeEJpcitsbDhmRFc2ZGVOWGtTY1RM?=
 =?utf-8?B?SGU3V2VMNkgxNkNsc1FvWmh6MTQrcTJNTnorUndqMlNQRDU2bXRtZktjRlBu?=
 =?utf-8?B?d1hxRlVZQXp3SkZoQTlxYU1EM3kwd1NUSU1qS0x6QzdEL0Y5YnNDajFnVVpj?=
 =?utf-8?B?ZHN6NkpyNFNNT2ltQ1ZoVFFlbmZwWGR4ODVSRFN4VTgwQkN5UE9US0xQL2c2?=
 =?utf-8?B?WTE1TUdSNXBMWURiUUwwWG1lNHp2U01nOWR5d3F1dUJXVUw1bjFwT3ZOMnRS?=
 =?utf-8?B?S0grOHlmSm1ZRGs5MUFHOXdvd09NWU5JWFpJYkt0VzUzMXdpL3IweGtMNFJk?=
 =?utf-8?B?VHZoNW8vZTVLdHY0TG1Ya1pWd3pMVUljdXBJR2NYS2lXazJSU0JiQkl1M1E0?=
 =?utf-8?B?ZVY3dXhKNmM4MVg1cnRXUEsvdXkyVittVVBBaHJzU09oSVdzYUtEeEx0UEFt?=
 =?utf-8?B?R3hpd09vK0FYeGQyOGttcm4yMXdreW84VnJ5SXpRMC9xQTE2b0MzczRMVmY1?=
 =?utf-8?B?MWJZaDJ2bHNvZTdhQ1cvczhxT2hOeXN1MFpBdXpEQVZwMlBjN0syelR6MGlv?=
 =?utf-8?B?RjVRbk5aQm8vMndtN21kbzJaeHl6SG9nZjNpSnp1UjR0bWlSVjUyaTBzZmxC?=
 =?utf-8?B?aTJYT29ZUVlVZHZmMHp3NStxTVVmenBnRUxPRStOK0VxSW1va2l6M3VSZytD?=
 =?utf-8?B?TG1CejJEUTEwUCtyeVZMTjFiUTFLdmRQV2Nxa21hRTJ2K0FhRW5FMEszM3Nw?=
 =?utf-8?B?czJOR0NGMTNqSEhaUkVPZEI2UFBpY1U3U0RZeUwrazN4ZTVlVjBHMzhwZDF5?=
 =?utf-8?B?MzNsS3VTMlBQV2JNalNzYTVJN0dBZHlKUGVGbmZIUG50c0pxbmxaaml0WS9k?=
 =?utf-8?B?UU9lM3RQZUxDYXFoV040SHlkL3U3VDE0YWtQSkN4MmN4UkVYRytSSmQ5UlpB?=
 =?utf-8?B?eVliZ0QrY1N4Ynh0ZE5URG14OG5pRnJ4M1BiazNyMkh4amVmQjlrOTV5c2NT?=
 =?utf-8?B?WXRjVjB5ZFdOaHdpRWErL1N5R1l4YXkyVnFHTmNtSGpHMGd5Nk9rcWYvOTFw?=
 =?utf-8?B?MVFIKzZBek9uMStXUDFsVVhocVNuanJjbTNNVWtJRUk2d0NVOWlWaGIzS2lZ?=
 =?utf-8?B?b3NJaCs5UENWRzZCSGsvZEFUTHZEdlg2TTZRVGIrSDJnMFJ0SWZRVDZpMzdU?=
 =?utf-8?B?UDF3NG9SY0hveHlFeGdoU3NJdUJyUWJGdjYwa2xwNE90cG5DOXBqRkZGWnBW?=
 =?utf-8?B?d2NpakcrTUJ6VUxXZ2Q1MmsxYVJyWWpaQVYwVHhrZXRrVjBXOGQ5dXZqUlNE?=
 =?utf-8?B?SkZjMjNWRGlpUUFmSFJCc2hRRXBLamdwa2N1RHUwR0ZEQmhvc3ROTHlzVjR2?=
 =?utf-8?B?VjZvbHpYczZ3bzZsNGMyam8xUFdGUkFRYk1uY2J3TndGTGtBQU01STBTTGYv?=
 =?utf-8?B?czFnVFJLN2JtYVFwejFNMlF6aE1yRU40VkpneWprc01pVC9NMlBnaUdsRlRk?=
 =?utf-8?B?RUlQcEhDZmRqODdaamNYK2MxRXVGc2Y0dktJYm9mcU02QTNJYjQ4U212aWht?=
 =?utf-8?B?eG1SMlh4SnlsVFp5djcwQ0FVZW1GdTc5czFmMm1FZ0Z3QjQzaXlpS0ZjSlha?=
 =?utf-8?B?RTAzRVV0YW1UZmQreVJ6S29rVTQ4bkVrY0lnT3E0ZlJvVnVnNllvZ09aajFP?=
 =?utf-8?B?VzA1emowN3RqV0FjSEJGMTZ0WUZLWlVzMjBqeUUvMVBTT0E1UGNJaE9GV0wr?=
 =?utf-8?Q?QI6QJSBU2aJZM5vs/xaGL/wFB+dBHIK1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0p5dUJiTFdwRExyYVE3aGxicGF4QTUyKzgwQ3l6Z2ZFR2hhUUZuTG52c0Zv?=
 =?utf-8?B?bzBoRDRWREJrWkl2U2dRVEtNUlFrWTNXRVRHeFdCVHc4LzhRK3FiRzdwR3Vz?=
 =?utf-8?B?SzI4R2ZSTVdVSE5xN1JxOWZrUTFHVUNrdVkzQmVBZ2Qwd2Via253cEdPODdr?=
 =?utf-8?B?QmdKby9CY0pmczZuSmwzZTNLb2FzcnFFYTgvOGpzdGNMUmw1MnhGUXFtZTJy?=
 =?utf-8?B?Z0FwSGhJM0E5SXBxOXZjU2p6cjY5VjhMSS9iK1Jsa3FwUXZWV3dxL0gza2dM?=
 =?utf-8?B?dEtMWWRDbWdHSTRLbk9kVUpWbmZYVitIUTVQZHdaQzBMekl3MUtrcjFDU0xu?=
 =?utf-8?B?Y1Y0alRYYkVMQzllMU1EMnowemZpMWN3T0FTQzhSZE1ZbXd5UG50ZXNPYzBB?=
 =?utf-8?B?b3hsSmJtZTBKUzBRTVhrZlo0VFlnSFNrT3JTSURHQjFqM0NVa2dxVjNlNVI1?=
 =?utf-8?B?UlVUOU55QU9HYjBYTlFSaEhuVWx1SjYwbzRsN3hJdEExT1FjUVVHZ1RBb2Zx?=
 =?utf-8?B?LzBhaDRxQVUzYnhCWCtEZytxMDVsb3FsMlo3SU9oMW0yWEVVKy9yVjA1azdG?=
 =?utf-8?B?Qi9VVTlmOU5ZVktBM2ZQTGNzclM2Z01UMUt1WmM0elZqRGpWL0lWbzAvbVBF?=
 =?utf-8?B?WkErR2RLWlVHeWJ5ZXlITmlXdi9JUTc0a3hxYThKcGQxS1dHQ2F3cE1SUTZU?=
 =?utf-8?B?TG9CSXlRdFVGVGl3dUpTckg3QkR1cExzdEJOem5MR2pUTUlqazZwb3BHbUox?=
 =?utf-8?B?QUNjVDFkMnAzWFE0dURiVXFHMHNORU5hVDd4dmlsNzV5R1ZQQkx5Q2tyL1NC?=
 =?utf-8?B?Y0o1TWRlSmZnL3lZT2pDRjBtNnZZTTFlOVBPdlZDMTBhZXJ3N2hNcGJxdk13?=
 =?utf-8?B?SW9QZjM4NVNPZWcva2FKZ3p0RThabjVoelZlK2pQYnRCam01bm1HV1VCVzhS?=
 =?utf-8?B?WEI1RVF3ZmNhcWUyY2M0Wk5ZWHJzZnNEYlFkb0VsSVhrR1VGZWdaZ2ZOdExm?=
 =?utf-8?B?KzExTGtqeVQ3ZVdacFdIbUk0amg2NjBNQitWMlB1MzA4SHh4WGo5ZzB3K0pa?=
 =?utf-8?B?TU1reDQ0cjVDTFVudHZYZWhZaXBJMXF4QUxEeGlrMlRIY1Y3V3BzVnQ0YzN3?=
 =?utf-8?B?ZTUrY3VzR0lBY0R6aU0rMnM0dTVDTDNQTzJaYlBEWFB5RU9XaDN4MktPTml1?=
 =?utf-8?B?b3V0V0ptWEpJMVJpQ01Fb05TRGgwOXlNSGRsMFRSTGdYdlFmMGRIUTl4Vlhq?=
 =?utf-8?B?TmpsR2FURy9pMndEUWpHZ1NlNTBTcVhFUVpRRjJqUzlWOFpNK0h4OUVRc3RS?=
 =?utf-8?B?bWxiWUxpVHUrWW1TQW12dWZVRG1ucndpZjMydTRzU2I3WnFLVjBKd2ZSbXFk?=
 =?utf-8?B?Q3NRQm1kemd2N0dxWHQvNlJ2MFNFZVQwb3A3cmp1bUlhOWVHTmtheGMxditw?=
 =?utf-8?B?ajlObWpjdG9LOHlkT3ppS3I1WlFpUktqNTBNNjdGVVNoaVRzc3hTZmZjZTdh?=
 =?utf-8?B?bjhWNHRWRS9tRzI3VllCQktLNUw2OTlkYndkcEVrMm8zM3NIVzN3MVNFbExV?=
 =?utf-8?B?MW03K2lRMmhkSy9JTm1reC9jWVR3UkZlU3NDS3QyK3cyby9GYTN5QU1XMVZo?=
 =?utf-8?B?cy9Ma3FHck4za3ZlWkJUTHFlZFBFMUpqbkUvVjZuOXdBZEJjTnp3N25PWUJY?=
 =?utf-8?B?cVRiRnJ0MytIWE1sR2FBS2oxTVJkbzBLSmFTZjJBTFVPMStyTTZ3ZzZPMVFM?=
 =?utf-8?B?VER3VmYzOHQrSGx5cGFJa0hNSkJMbjRxdGhlaFkxTEhVdmlObzd6UVhzanMz?=
 =?utf-8?B?MmpMc2prUnZwVXNIRnRnWnJVQ0twKzNEYWFzaWZwbXZNTDVUYmh5YWZabTRm?=
 =?utf-8?B?dE5odTNaeC9JRVlzaWJvYmpSZnNvK01sUmd4NU4vWUtSeEFDWFJmZ0VXMEpG?=
 =?utf-8?B?RkhWSkxRVG1JckxiSzV6YkV3b29mc0EyZlJIaDRtRXBxQmFEMUo3aDl2UWov?=
 =?utf-8?B?VTcvQ3E0Zm5lTFZPcXBOVEljY3NXVCsvOWpFdzN0U3NVeWtUek9NbUYvcXZJ?=
 =?utf-8?B?L3pWTU90MSszcUpxUC9BUU1XYVRzajF2OE5qUkhlRWxPNlJYV3BTVUI2c2dI?=
 =?utf-8?B?NmMyZWFWdVoxd0ZDSjIzQWRxK3A5aTdGMXZFMTdUWHhIQ2t1NzVwWEh6N3po?=
 =?utf-8?Q?x3N/O/Xw9jANFon9E8ZawW0=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b06d2f-3b55-476c-0fee-08de3c888b2c
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 09:50:28.2245 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XuWrESe9UBBLeq/tUkBi7Ah3FhVSNUXngLfUtQ9afqmLHQW+vn6WpLC7863922rlxL6BIF245B6xzcmkYyWWywC9RtRUSFZA9eCN8muXfS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9935
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

Hi Alice,

On 12/16/25 7:38 AM, alice.guo@oss.nxp.com wrote:
> From: Sherry Sun <sherry.sun@nxp.com>
> 
> Since the ci_udc driver has been converted to DM driver, the
> CONFIG_DM_USB_GADGET should also be selected when CONFIG_CI_UDC
> is enabled, then we can use DM ci_udc driver.
> 

Is DM_USB_GADGET *required* for CI_UDC to work? "imply" allows to have 
DM_USB_GADGET=y AND CI_UDC=n, which is probably not what you want. You 
probably simply want "depends on DM_USB_GADGET"

> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Ye Li <ye.li@nxp.com>

Please do not provide Reviewed-by on the first version of a patch, 
Reviewed-by, Acked-by, Tested-by, etc.... should be given publicly on 
the mailing list. We don't know if Ye Li actually reviewed it or if you 
unilaterally decided they reviewed it. We don't know if we can trust 
it... which we shouldn't have to figure out.

Cheers,
Quentin
