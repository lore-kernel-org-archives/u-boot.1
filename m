Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC695CF34A9
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 12:50:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE28E83D3C;
	Wed, 19 Nov 2025 13:50:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="VvKdEdVz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C635983DBF; Wed, 19 Nov 2025 13:50:52 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 304DA83952
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 13:50:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pZcFPhyJznHpjy58MfQRiVjYTOKxYMzPrvX0Gd1idibtXyn+sZh1rVB5VTmsoMCkfUZZWucCISgT1z5aV1RoMHrqgYOI3OzyvMSfeXr7EtgmTC8pLNOLqZKdB+aTgm8eC57cSqAGIcOKicslCvG0gttFJh1+YZBbGeA1g/mhdsPbOQJkQs9oZ+leTfkBBX8UGP3TfxwcpvNWauhEGbnv3vHH8xTX+yiggjNbmS4LVa+N/U4hTkA/usxYx51CLbiLyl7rSMEq/Jg4cahXXSFTvvupR++o/+c6mhtMQfpVgm/xP07hmoJ4gFg4y4YjYbFUdqyZ+44WFkm9L6pGU3y5Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljCCfC+xD/4sGbReCsrrssk5yNcH2a9frLXOcR1E/Rk=;
 b=iIQYnNsIES8zxYpQc+Ut7NlPxKyNpIj3JR4izJwNtL1Xxz6NCBzGd7J3h7mAiC5VuV6AJIEIcWN7b/1T0uz3DJJEr7RdJy56AKLeuG2pR9Kn1MrItLrj+zlysrs48Ie4C1SxkSncSIbJ9CmHjI86uyk3t3/s37etj7dVXiXHgdOZHiyDKzv8P7/Px6c9gM8ylmBKjbZvF5eJXzvfU0sUIGdqGHe+g5YN8qfgKULLXVDzCvzmPLU3hT4od/3tL01ASx6A6k8GiohkCu8PCrfeuij6VLxTMtfztgkSJeuR8vUu1KW7K990vmPh8cicQgwLkww8mj9KJguqm++e1v/2GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljCCfC+xD/4sGbReCsrrssk5yNcH2a9frLXOcR1E/Rk=;
 b=VvKdEdVzbaKrc/xFaRS8Czpc8/9h7Aj4C8nI/hrXd4YICbWFvzbGDEIe++JgxWOPUW/m5SEE+/oXmxtIn9OyEXvgrQQtZC8bGd1F2M8s+bFs/vQDKIbYfu64gj1a+kQnNo7WciPNGMO9ikx9pPQDVX/bY+LMVnPiB2+6WrH0HMY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA2PR04MB10422.eurprd04.prod.outlook.com (2603:10a6:102:417::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Wed, 19 Nov
 2025 12:50:43 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 12:50:43 +0000
Message-ID: <b4e389fe-024c-4eb7-8c5b-b27188f50b48@cherry.de>
Date: Wed, 19 Nov 2025 13:50:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] tools: binman: fit: add support for OpenSSL engines
To: Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 Quentin Schulz <foss+uboot@0leil.net>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Aristo Chen <jj251510319013@gmail.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass
 <sjg@chromium.org>, Paul HENRYS <paul.henrys_ext@softathome.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>,
 Anton Moryakov <ant.v.moryakov@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 Bryan Brattlof <bb@ti.com>, Peter Robinson <pbrobinson@gmail.com>,
 Eddie Kovsky <ekovsky@redhat.com>, Kever Yang <kever.yang@rock-chips.com>,
 Yannic Moog <y.moog@phytec.de>
References: <20251117-binman-engine-v2-0-e053f683c0b8@cherry.de>
 <20251117-binman-engine-v2-3-e053f683c0b8@cherry.de>
 <DB9PR06MB8512FD168E1197521BDD445DCBD7A@DB9PR06MB8512.eurprd06.prod.outlook.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <DB9PR06MB8512FD168E1197521BDD445DCBD7A@DB9PR06MB8512.eurprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:22::16) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA2PR04MB10422:EE_
X-MS-Office365-Filtering-Correlation-Id: e83cefb3-05ae-471f-b4a4-08de276a4038
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T082di82c0t6ZDMraWdzK3hOR0FWM0x5Q21qczRwdWlBNGx4eTRmNlVPVW1C?=
 =?utf-8?B?bUhMYkFLUE5VVThQb291dk5neDVHZHQyMHdpT3kwanBIVDhtYzdObXJHWDNx?=
 =?utf-8?B?SU4rN0Y3aDVxRUROZzRsMERoOERYc01Na25NaU5mak5jMUhmWkJxd3UyQU40?=
 =?utf-8?B?WjVsbnp4b3pZa1IyQzhQZmpVVDh5cVZKb0VNVzNYcDhid0ZsbEVkNGpLcWZD?=
 =?utf-8?B?ZW1oZDhxWDdUOHpLK3ZNd1MxaThNU2cvTUFoRjAxVkwxWmVoeWcvRnFoaGJx?=
 =?utf-8?B?L2d5WGFjNjZXUjZBS3RmNUVvRUl2Wjg2MjZPMjE0cm1yMVFGSVlpUy9Ecmd3?=
 =?utf-8?B?VTBzMlFXREpqWkpmTHhxNExVemxUcVhzR3ZFOUg5RzU3UzVHazJNMjJISUpL?=
 =?utf-8?B?TzZmbHJYWndvVWlPa1RMMlpKMDdEUHlyL1ZGN2VDc1RPdVNGL1Y3Skt0U1ZX?=
 =?utf-8?B?ZzBpc2hPVDVCYVF0MG1DUlMxak9pTjlxcWg3czY1MGN3NzB3TjdNS1B0NW9s?=
 =?utf-8?B?WERpR1l4Qm9BS25jSHphME0rTHNkK00wcUVrTWJ3RjQwY2FFMDJkTmEyeS9r?=
 =?utf-8?B?M05VQnoyYUxrditaNFBpNDZETWsyMEZYcW9aWWgydytPK1E1YzhEMy8wNTl2?=
 =?utf-8?B?eWFKSkFGcmNlWFhtNko2TklxVkFETkxxL0dRSklmYzI0S0VWeFBsYUlpanNx?=
 =?utf-8?B?L28wcFdXNkF3R3Q2U0JzNDdIMC85NWlIL1JoQThPMk15aXdqWWkrSjNHVGFQ?=
 =?utf-8?B?a0ZoTDk2UWVuWS95WUlzdDlLMFgvYmlpaHV4SkVPSWR4S2pza3ViV1NZaUh3?=
 =?utf-8?B?L0RZNlA4OUl2bEVibmxTcnE4RXpXLzh4bDZsV0pqY3BUaEZWT093RmxqSEFK?=
 =?utf-8?B?b25uc3VoazZXbzJXV2hCZTh0b1I4alltZThtM3hjK3d3SUtwMUF1dkg4THo4?=
 =?utf-8?B?NDRGV2dHMHdHRVI5RWxXaUZHRHF1cFN2bldZLzlscCsyNEZUYUh1blZ1dFdm?=
 =?utf-8?B?cm9TSTJZdVFaNVhVMDkwRk9zRjFzeUx5TkQyZHA0M3B5Z0tsczVNMEJUWThB?=
 =?utf-8?B?dlBZYzZLMmdyRkR5ZEgxaUl5THFOWnI5RVdCenkvREpDbWZWSVYxZ3p4c0gw?=
 =?utf-8?B?ZUkxK2JZZDBzSEtpUHd0U2p1SjAwZ3YyM3NVREk4NG10OGNsWDBhMU1kaGlH?=
 =?utf-8?B?UnpXYnRCTzVMUlR0R2dNS09JMWFuRkVWUmFZYXhyeCtmOU1Mb25vUTZBYzNl?=
 =?utf-8?B?Y0M2NktWTnpyZGxXcGFsUURQU1BCY2pVZHhMTlA3cGdmaEpsVXJZYXhhQjVy?=
 =?utf-8?B?b2c0QUFuT0pjT1BoK28xUWthYWpKREI2aTlEOTB1MkFRaWMzV2VaaVFqZzl3?=
 =?utf-8?B?UVhlTGxaOG5LVVRZaHR1RCtLbiswcGdZeG11MnJhQXEybWJMMExubkF2Mmxy?=
 =?utf-8?B?Sm1VbkxXNnJQNTVsMWxIRFA2dS9iTnJTL1JqdVUzUktXZWlhN2g1dG50M1Rs?=
 =?utf-8?B?TFNaM2NndTk5NG5SWlp5emZ4UkFnLzY4K1ZRZHh5bkxVOWk2bWd2SGx1MFdl?=
 =?utf-8?B?TllMNE9BamFZdUZaNHF4cStzMVdmS2pEWkdPRnZYT1BYQ2l5REhoYUcyUUhH?=
 =?utf-8?B?dzF1b2xrT2xtcE5EYVZNMG1URU9uSHIwYUFtbTM4a09oTzNmaXdZNmxIaG9F?=
 =?utf-8?B?RUN1K0JLNnRqRTN2SndtbVhkc1BlV2lUWU1lUU1ib2hxMnJTTzBoNTJReFY2?=
 =?utf-8?B?NHJHRWd6ZXVTSDgxaUt5bi9ZUm93QWcwYlpqbE5nSll3ZWNiMmVBSVpBMWVF?=
 =?utf-8?B?czdKbUpZeTlyR1grVVFhdnZFa2VpbHhZNWlnVXFmcUJRc1NBK09jb2gzeHFQ?=
 =?utf-8?B?NkxMejJYSTg3NEhGZ1NMSy94Sng3ZHpXbzJsODBJT2V6K0E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVFSRU9TeGpTWjV6alBuK0lZWStSdlphVkZyQnEvY3pyWndHNjlGckZvRHFB?=
 =?utf-8?B?L1pXajZEN2IzaGxNcHVOZ3JQNzRTTFpHNXNQTVp0cnFOZkIwNGtvbGNkKzdS?=
 =?utf-8?B?SitqOGdwejFSR3Bpa2U0eG1lbHVqZk5jMGppTUxKYm5JRytDTHJWdzI2Smtk?=
 =?utf-8?B?cEZrMTNPc3ZxeDFKRHVSRnFucDlZR2lSZ25SaXM3WU5JODNQY3pxeEpweE9D?=
 =?utf-8?B?elUraHdiNzI4THJvcnhQYUQ2TDhFaVBGSmFucGNrcFZ5SHZVM2VMNHlZODlk?=
 =?utf-8?B?clZKRDFJYWdCQWVodndzVlZqb0xuLzVzWE5pVmI3Nm82cFh0VkNGakJwZzBM?=
 =?utf-8?B?dXJCd3VheUNUdktobkF4MUl2eDgvWDVYcDZPa0hMS2c2cmNYNnhQTDI5eE9D?=
 =?utf-8?B?LzdDbGpIdzJVbnZTa1lxby9DY1RITVpQRUZsRDdXYWlmVFNVTnRINU1xZnlj?=
 =?utf-8?B?YnFmRmQ4YjU2c0krVkNZTXNBQzlqOWhEUU1WNzI5QjM0V2R3YXBPKy9UeEs0?=
 =?utf-8?B?R3QvSE5ZdjBoYVdYdVlObTNKV244dkNNeU5GNjNISTAxMk1RV0luZXIrSnJM?=
 =?utf-8?B?Ui83QzdPNGliQ2Z3K2FyZ1FZcURJNWFIVWEwZWVNSzNoNTJjMnZmYngxeUY5?=
 =?utf-8?B?Y0p6cGN0Mm1zZ0xkSm1kdlZIOXhUYnpRTGlSOGpsNWlOcXhJTlhtaXcyS0Ri?=
 =?utf-8?B?QWV5b1B1KyttWnphb1VZOFZJSWZzcUNoNnpSM1EzY29mNDNMeUNsYU1zUThO?=
 =?utf-8?B?QmQ1MDJIWmgrV0h1SjJkTHRLczhSUmJwOCtWNUgvWUFwaFVDTEM4RXVIUjlF?=
 =?utf-8?B?aEFxeUptRlB3VEZ1d1hDTXAyaUZUa1dFQm1INHVLRHExZGc0YUUzWnF6UmF5?=
 =?utf-8?B?em5oR0UrWDZoS2VLZEJjTjExKzBsQVFNM24xOTNmRksrY1N1OG5xMEo0S1Zh?=
 =?utf-8?B?cCszemM4Q0p1MU5MMi91SGY2aXEwZ0pZSGYyZHptcmxHU1Y3NmlZbG1XNVFz?=
 =?utf-8?B?TjNzVURLbkVWSlhSWW9RaXRHam5mRW5VdEl2aFpqdHQ4UjVTQ2tXcG9iSUZl?=
 =?utf-8?B?NkxTbDB6ZUlsb0F4a25XazZLYTFzZVFhblVNeTdDcFBPWmNqZmN2cUlkeFVL?=
 =?utf-8?B?d3d3N21GY1JIRkdrdzBQbmdBQldEek9iU1pNWTFXdXFOVEN2VFBIWUNkY1p2?=
 =?utf-8?B?R1V5L2N4VzlWekM2MG9hNzdqeE5JTWhwbUtwSjdRL3BISm1LMUZUcHFZWnQ4?=
 =?utf-8?B?Q1pQbE1RSXZWWi9PdWlzN3d4WE9JN2YraWRJY1hseXNEVE9JWlRuempFaGh3?=
 =?utf-8?B?Z0VmbVZVaGlLd2hxS3ljelZ5OFNkWVNia2U3alUyTlNJWWV6K0ZQWWJjeHFN?=
 =?utf-8?B?VWxneVlKbjdxVmZCK0MxQytsR2RYcWxVSE9FeUVabEhwd3ArY05PSTNRajJt?=
 =?utf-8?B?aERFdWhVaDRRVXIvOEkwNmdFY1h4UzUvY1E0VWRJMWg2ZWtsU2VDWGJXWVVO?=
 =?utf-8?B?empFekd2akFwd2dZQVUrTDVPZXd4WkczU0FCK3k1NDltQWhnWUJwSzdqT0tF?=
 =?utf-8?B?R3NUbjV3dFpJc2o5c2lMVzY1RzM2NTNUWGVIbkFOQ1piVzM0Yi9ZUnBLeEJn?=
 =?utf-8?B?TnE3dVp1VzZDcTdzeER6MHUvMWgyMlhxU1FQc21ySktac2JGQjNiSGRqM0c1?=
 =?utf-8?B?M2NORkpqMVZlQ21QOThFc1dnTE9BSCsrQUF2TjhGUVUyalVDRU50cW8rQ0Jq?=
 =?utf-8?B?R1IvM25CU0R6MTI2cmdzYkU4dnVxOVNhQWhSRnhURVYwUUNaVzk4NXhQNmlG?=
 =?utf-8?B?S041RTZTa0prRHMwNXJZMHloOTZaZ1VnSk9RTGNMeVF0Y2MyVTNoYkdsWVRi?=
 =?utf-8?B?ZzUzQVRBOVJyZ2ZaUHlmejNTVit2QUN5bW4vZ1lQYlpCcHY0L3lyeTZNR2hi?=
 =?utf-8?B?dUNnalE0OWMwOCtMa3BoVkUwMU9maTNBMzN1eTM0TnU3MlNzVmhhaC9QTDUr?=
 =?utf-8?B?MVlERVNNWjdRZnVCTTVIbnhtV1pxRXZnR3pEYjM2NUt2WkdFNWg2UllFcmdx?=
 =?utf-8?B?ZklsNkJtcWRjbFpVQzA2cGhHZlY1OEJYellhZDcrSXg1dGJXZnVlQndaVkV1?=
 =?utf-8?B?VWtOZm1HT3E2dzNLOVlvRWQ2SXJtUmVwbVRKYUFUZngyWlFXKzZGSHpUSlJp?=
 =?utf-8?B?ZUE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e83cefb3-05ae-471f-b4a4-08de276a4038
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 12:50:43.2136 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2yt/RRFyslViO1CuMmdh1pVumAM5DJ3qI4Q9Ecvu2w1hbHW/kuUZJINu6iIM61rEDFugzdBLDnCN+zrX0Gx1jBhv4IhgB+G3OpHoPnTs3WQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10422
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

Hi Wolfgang,

On 11/19/25 1:19 PM, Wolfgang Wallner wrote:
> Hi Quentin,
> 
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> This adds support for using an OpenSSL engine for signing a FIT image.
>> To use it, one should set the fit,engine property at the FIT node level
>> with the engine to use. This will in turn call mkimage with the -N
>> option.
>>
>> The -k argument to mkimage can be specified via fit,engine-keydir. This
>> is especially useful for pkcs11 engine to specify slots, token label,
>> etc...
> 
> Thanks a lot, v2 of the patch series is really an improvement for the
> PKCS#11 use case. I was not aware that there was already code that
> could automatically prefix 'pkcs11:object=' to the key-name-hint.
> (Yes, I know, it is part of the existing documentation, and I have read
> that, but that just shows how much I miss even when the reading docs ...)
> 
>> The -k argument to mkimage can be specified by setting fit,engine-keydir
>> property, if missing no -k argument will be passed
> 
> Small nitpick: the above two paragraphs seem repetitive, how about the following?
> 
> The -k argument to mkimage can be specified via fit,engine-keydir. If
> fit,engine-keydir is not specified, no -k argument will be passed to mkimage.
> The attribute fit,engine-keydir is especially useful for a pkcs11 engine to
> specify slots, token label, etc...
> 

I think I simply forgot to remove one sentence when rewording the commit 
log when I added support for PKCS#11 :)

[...]

> 
> This description is quite convoluted. I would propose to describe it as a list,

I'm very good at writing convoluted paragraphs, so thanks for suggesting 
something more readable :)

> something like the following:
> 
> When `fit,engine` is set to `pkcs11`, the following cases are distinguished
> regarding the value of `fit,engine-keydir`:
> 
>   - If `fit,engine-keydir` is not present, value of `key-name-hint` is prefixed
>     with `pkcs11:object=`, and then passed as-is to the OpenSSL engine API.
>     
>     PKCS#11 id: `pkcs11:object=<key-name-hint>`

I have no experience with PKCS#11, but shouldn't that rather be a 
"PKCS#11 URI" instead if " PKCS#11 id"? c.f. 
https://www.rfc-editor.org/rfc/rfc7512 Especially since there is 
actually a possible id field, see 
https://www.rfc-editor.org/rfc/rfc7512#section-2.3 pk11-id.

>     
>   - If `fit,engine-keydir` is present, and its value contains either `object=` or
>     `id=`, then the value of `fit,engine-keydir` is passed as-is to theOpenSSL
>     engine API. The value of `fit,engine-keydir` has to start with `pkcs11:`.
>     
>     PKCS#11 id: `<fit,engine-keydir>`
>     
>   - If `fit,engine-keydir` is present, but its value does not contain either
>     `object=` or `id=`, then the value of `fit,engine-keydir` is concatenated
>     with `;object=` and the value of `key-name-hint`, and passed as-is to the
>     OpenSSL engine API. The value of `fit,engine-keydir` has to start with
>     `pkcs11:`.
>   
>     PKCS#11 id: `<fit,engine-keydir>; object=<key-name-hint>`
> 

*Technically*, pkcs11: prefix isn't required as it'll be automatically 
added if it's missing (and you'll be warned about it), c.f. 
https://elixir.bootlin.com/u-boot/v2025.10/source/lib/rsa/rsa-sign.c#L120

But yes, I'll do this rewording in a v3. This is not up for merging 
until 2026.01 is released as it's not a bugfix, so we've time for some 
other feedback/review before I send a v3.

[...]

> 
> Tested-by: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
> 
> I did test the 3 cases listed in the description of fit,engine:
> 
> Test 1: No fit,engine-keydir:
> 
>      fit,sign;
>      fit,engine = "pkcs11";
>      key-name-hint = "<object-id-of-my-key>";
> 
> Test 2: fit,engine-keydir present, and contains the string 'object=':
> 
>      fit,sign;
>      fit,engine = "pkcs11";
>      fit,engine-keydir = "pkcs11:object=<object-id-of-my-key>";
>      key-name-hint = "MyTestKey";
> 
> Test 3: fit,engine-keydir present, but does not contain'object=' of 'id=':
> 
>      fit,sign;
>      fit,engine = "pkcs11";
>      fit,engine-keydir = "pkcs11:serial=<serial-of-my-key>";
>      key-name-hint = "<object-id-of-my-key>";
> 
> I think the suggestions above would improve the clarity, but even if you
> choose to keep the text as is would be fine for me.
> Both code + documentation:
> Reviewed-by: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
> 

Great, thanks!

I was wondering if you had experience with using id= in the pkcs11 URI? 
It'd be nice if I could add a test with SoftHSMv2 for that as well but I 
wasn't able to do that fiddling around.

See 0707f73a8ba2 ("lib/rsa: allow matching pkcs11 path by object id") 
for the commit that added support for it.

Cheers,
Quentin
