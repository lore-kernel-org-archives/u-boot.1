Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73BADCCA476
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 04:19:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0C0083939;
	Mon, 13 Oct 2025 06:18:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xSZA1xSZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4B58836A4; Mon, 13 Oct 2025 03:38:08 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29D2883631
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 03:38:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gsizfAewcdDaMz3yenXdPxs0gEkgZ18bWurWge8yrErQCK6461dw2QtqLRcXROvURO6vR0tLRdAPy+mY3DtZQy1yP/AWewDe8pO/JM73uAH09Fzo2lNJw/xWeDyMO51CmAJxh4l50xtSQNcqrrOf3g5jUvCpf8gGky9kHsGi/hLApWKOnbz8C6tsu4CLTqMFTVzKOTqA1YUGbH2qcP0iHaky1Pxzk6sx1D7gvYH2mxNEBBlDUek2ygxve1Q7r4BEgLJaky4eCHgiXs8HeTs4lDeAgehbG/GVJM5IrtHpvyKH76YLRZ61Xok5L3JC8HX9YettvhYl3LB4tx5BYUh2YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HpYnLYBOw/GHNWBHzQ63FX5N3NIrCAYps/ldQ3vqDOM=;
 b=Vg1MJozrFKXJVSFqg+bkd+wf9G95b/0QAHZcX4+mXO0plfKeDyRzrY+GyNZCgfGf8bT+BTy4Ddt50rlHwr3i+6spoA+bm3zhOqVhhWv1/Xgj2yTdZwcFTsobS9byTFesEG9hmbP6fmpk27uCMh+YgIBpwLxkZzZI7ZHAEzPpMGaE1rmAqataK2xyDtuP3P6GfDmmU0iTeBIOVUF9WPEzjMx1Uxbb7lsER0Nff10MUM1MIWELU6pV8YiklMb7taj5j1okp/9wOPD1FJ89bPqjCfy6r3eJvNgxnzcBk8iUZG0MlcxI1MGkUkaPWXHc8qn8O5slIzgbdfiG9USZFPAasw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpYnLYBOw/GHNWBHzQ63FX5N3NIrCAYps/ldQ3vqDOM=;
 b=xSZA1xSZnJahBeAUxoGAT/0XXn+9MjE39LRvBuo4bWrPwAbvbYDkRZkPouqDEawDnEez2AIj06MLizMVNfDXtnu7Tla+XpZAdYB/z/D8qDpKSGQCHRyY/piyDKkgL4hVLUkoNtqr9587PLllDcxBE8kbz7SyqKGkqw/4La+/P6ojeEZADB0MLqQ2qmN5h/uFYU38W9nwmm/VNOfO0nFu2LV3kR/o4wFoG+t31kwpQHJ7FqvdeAY7XtfY6B5llHTI7WD8gVBljNxndAcMwn/aQNWqXX2Hvxi+bcNmyVagc0h+alsgUnzmLX+oPYJHYRk5DrCVF03S6ogQyGlwmy98UA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB10613.eurprd04.prod.outlook.com (2603:10a6:800:25f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 01:38:04 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 01:38:04 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 13 Oct 2025 10:49:30 +0800
Subject: [PATCH 11/11] imx93: Enable remoteproc for i.MX93-EVK/QSB/FRDM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-imx-rproc-v1-11-fb43a3fafcd0@nxp.com>
References: <20251013-imx-rproc-v1-0-fb43a3fafcd0@nxp.com>
In-Reply-To: <20251013-imx-rproc-v1-0-fb43a3fafcd0@nxp.com>
To: u-boot@lists.denx.de, uboot-stm32@st-md-mailman.stormreply.com, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>
Cc: Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Udit Kumar <u-kumar1@ti.com>, 
 Beleswar Padhi <b-padhi@ti.com>, Hari Nagalla <hnagalla@ti.com>, 
 Andrew Davis <afd@ti.com>, Judith Mendez <jm@ti.com>, 
 Ryan Eatmon <reatmon@ti.com>, Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2PR04CA0202.apcprd04.prod.outlook.com
 (2603:1096:4:187::20) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI0PR04MB10613:EE_
X-MS-Office365-Filtering-Correlation-Id: 01bf44bd-3206-4ff0-91ce-08de09f92702
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QmU0QTNodWpORm1Mb1R5ZzNKSEJpQzhNNHVvUG4xdjlzSXFHN25oOE5DRUpj?=
 =?utf-8?B?QWxkU0VUQTFVYlcyQ2gyUEJTV25SMzFMcW1FczlmTkZONGMyR3J2T0wySVNu?=
 =?utf-8?B?Q0JjNGttZVNnZVlJbzYxTERoT29Pdlc4N2FGbTZGK0NTaEhtQnZTbjlGRkUy?=
 =?utf-8?B?NHpmc01tc2NZVGJLOFZxaDVwOGp1WVpPTmN3VHdZeVhBTDFwQlJGV0xuUlhh?=
 =?utf-8?B?WDNHOGdXMEdYSHAxTisvbzZpc0w3eXNpL2I5eHhzUm1XRjMwbWV6bThPRlc0?=
 =?utf-8?B?ZmZEcEcycFE4YWQyd1NaeVA2SWZnQWwwTDNUTllEMXdYWk9EY1ZzM2dXaFM3?=
 =?utf-8?B?dCtGRXBpd1lndllCOWlKczhxSkJtMW5KRXhkWTFPVGlUTEJqMW15OXFzdjA0?=
 =?utf-8?B?SlYxUFMzWHhHZURkbm9MYXliUGZuOHFQZS96Mms2SUZvR21LVXB5N2dvbWMy?=
 =?utf-8?B?VjVzdDhPWGU1TVZXb0J5NitrMVBLbVZkNmVjTXZZd2xmTWNuRlNSZE1HNklQ?=
 =?utf-8?B?ZXJldGJZYlRtU2NkTHZMUXhtVk0vakZnTE9xRkZOZEpIR2Z3NWhjYWduYXhQ?=
 =?utf-8?B?QUZtTDdKOUZTQk1FMFVtcjBwZkZ1a3VWa3BEUkhrMHZZamNqSjZkWGhtN24z?=
 =?utf-8?B?c3AwMnVjYUNLaXZmcm5OYXBFUzI1cXdYWHI0ejZtZ0xKSUkxdW1KMW9aYnhq?=
 =?utf-8?B?Tzk1ZWlJME5vSlpaQlhOeEN5QU5mR21RR2hJejVEN2xZSUxXV0JjbTBzUVdh?=
 =?utf-8?B?MzFhb3E5UDQ0REoxbXg0VDBXL0kvTkxwSU4rWDZzTmdrVUluNGk0dG13VXJS?=
 =?utf-8?B?SS9nblBwT0lpQ3ZrYmJqR1owdSszRXd2elZEaGRGQXN0V0phTTJRSCt0SndJ?=
 =?utf-8?B?MkVkd1IrVEFBQm9PdHREQ051eVpRendQeW9vK3kyOC9tVjFLS2ZPRDVIUWFn?=
 =?utf-8?B?N0pST3BCUG1nMVVrKzNKb3lHSlNhUEgyQjE4c3BZRmV2MlN2YVYzdmhXVEtM?=
 =?utf-8?B?dlR0K202Qms3RWhDaUN4T1JPR2pzdm5uMmlzSWQvV3dxNlBJSSs4Y1M1c1hs?=
 =?utf-8?B?K2MxTDdmREtUdUZ3RlJTKzFNYk9JVXdqNHlpeVUrUjNmOXRtRTY0UlRlanF0?=
 =?utf-8?B?WHBSc3Zpa1A3NkNHZzl1bEVLa3EzQVJDeUFvTzNVSUFpeGlTbkdwTWVXUUx1?=
 =?utf-8?B?RmtmWXhKOEVKdGJmZy9kL2QvaDJZc2JkWEhrSmJFcnJWOGEzNzczMFJpQnFB?=
 =?utf-8?B?OUorUld6dUFLdFVtNGYzZTd5MUR3WjNDVDF5djYwQXQ3aWUwS3FoSHNpbEdQ?=
 =?utf-8?B?SkN4dGJQL2p2S3RTVEs4SkIxdXkvWmRjZFVJSlViSnYyL01mSzl5ZFM5R1VG?=
 =?utf-8?B?d1Fua2NYT0pBbk44RytLREZ0a2ZlSWxZTG9kNzVhLzYxZk9UUWI5UnhhTTRK?=
 =?utf-8?B?VjlkM3ZpcnFhUG84NlNJNkx3Y3lhMEZHYlVlV1lmN2U4SHRNQlc0Q3lMb0FE?=
 =?utf-8?B?a2RJUnZrbTVEVVplelVhQ0FTVUh0bU9RQ3lhQSszUmpkazNnSXRzS2JwNHh5?=
 =?utf-8?B?V1o3K2tNMlhQSkcxbXg4enpsZFU2WmxSVHhkdmFzSlRkL0d2a05aKzJZMTB3?=
 =?utf-8?B?UEYxT3lqYWhuVUViTzk4RHZ5TnRLaVJuNXQ2ZC92dkNlL0g3Ynl5b3pvak15?=
 =?utf-8?B?bzh2RmNuUVRFaWRKSTVGUGk0U1I1VzRoNnRqMzdKNDNGbDhRL3N4VkVUTHJV?=
 =?utf-8?B?WnBiTEozMjREOEJDbHVFSzNVRXp1TE5qZWFWMWQwQWFlM1Y5TXl1WmE4RXkv?=
 =?utf-8?B?c0dwZW4rKzEzd0dLTHoxVVoxcE1ZNHRZaUcraHJ2UzgxUm5VaTRid0x6Rmo2?=
 =?utf-8?B?WUl6R2E3VWQySWQ2ZExZdDY3dWxGTktIRlZtVld6WlVoMi8yb3h0eUl2Q2p2?=
 =?utf-8?B?TGNvM1ZacWI3bVdoUUN0SXUwbUYrMWRVSmtEbVJQTmlhUFR0V2xFNStEdFAy?=
 =?utf-8?B?a2FhS0d3QUR5MTBYWitjU2JienVFKzBKSUdwU0tLUU5PK2xWNHZEa3RBbnhs?=
 =?utf-8?Q?ygZl+D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVBhcTQ1NThpODRrbWxHWUhBNHM3WkhVNk5zekxTOFdWR0RZM0NUMDc2aXBw?=
 =?utf-8?B?SXN3TURReldhUTNtM0R4OWljTTI1SjlsdzI4MitTUStUeU5pZno4NVUzYlJZ?=
 =?utf-8?B?QVZaZGZVOHNmb0dzMXhwa09weFJIR09zQUZONmZCZEY1WnhXUU96anRtYnZ2?=
 =?utf-8?B?ODZkMlFubjN2c3JnL3lzL3lsYm9LNEp2S3ZZYmQrNzQ1czlZWGlvbFp2bExW?=
 =?utf-8?B?REtNbVd6dFUwZkR2M1ZEODhDNlFZajZhdmxFZlo2Z2lENWI4N1FnWHp3Mk1j?=
 =?utf-8?B?Z0hIU0l0aWtiZHpjaDdaOGVQdGVHT0hkQkRWLytVeVFGbEFjVVEzbW55NHA2?=
 =?utf-8?B?Y3ErV1kwMEFrdjZsVzVmY0xLNWhFMmdES2hZVWFCZHgrUHB0QzNtcEp2RzFq?=
 =?utf-8?B?eDRPRGZPY0N0b3Z4L2ZDQ056OXUxL2hHWGVhVnNkR2N2cktzYlJTamlYelpu?=
 =?utf-8?B?ejRWSTZEUWp6TEhrL1d1L0U5cHpLTjhmemthdHQxMGdJU1dsaUtoaFpoL2dT?=
 =?utf-8?B?Sms2OUhTK0U1NW9NSEFwWHdRTVhoYndWbnQvS3NCUjBmYjJkaE9mMmRYL0Rn?=
 =?utf-8?B?ZUxVNkxmSzZiQkdsdVYzU3ZoRndvdmF3Y1ZqUWlXaUtFL3lmZ3JBSEVIRzNy?=
 =?utf-8?B?blFLSkg3Y2F6c0tZZnYyTjRLdXdnR0JCcVNQaGdaaEI1RVEwL0RuejRlTFN6?=
 =?utf-8?B?bU96bzNzMWF2OGowRFRpd1lCOVp1Z2pOdzcwRXFRaklmVWxrdzJKOXFjbGRP?=
 =?utf-8?B?OGRLdUNNalZxbXZFREdvS1Z4UTc5YndzVEcvL3RkWGhxa043ZzhPNloyTDZ3?=
 =?utf-8?B?MEJrUEUzZ1NUN3Q2ZXhhYkN0eldXUTNIUGtNVEszbmxGVnFaZDc0c0JyaC9t?=
 =?utf-8?B?UndZVCtYeDhINVRmMStnWHZmTy9rdFd2dHNGbnBRYy9XRTdOV2VqK3ZBQUNM?=
 =?utf-8?B?aWtGSFNDQXJxcHR6K2RwWndRQlRCRXlqbjhWMjkxVm9zWVpGOXhEclIwTmVq?=
 =?utf-8?B?MmN0MFphOFU1UTFiR2pHcXNZb1JYVXNUMmoyaGJ4L3c5Q2lWN1d3aWlIRUV2?=
 =?utf-8?B?b0ZyQlh4UWF5cHk4dUxLTHRIcXg1NUIyMkZhNGVFeGVPRUV2ZXhHZHpDaHdV?=
 =?utf-8?B?U3F4ZmgxbXJ6aEZsdGJ2dVZYYW5aSlo4RU1UQVkvaTdXTU9FZW5vQU5XZnlS?=
 =?utf-8?B?VmlQSkROQzF4N3ZBWVBXZ3MyS3ZRWFdzdERuU3NjM2U0TkVGWDJsTEFNY3hH?=
 =?utf-8?B?WWtSTS94QXd2UFgzT0lPMHlCdUdkNmQvSTZXNlhFYTY2ekltUmdSM2hqSWY2?=
 =?utf-8?B?WEtyazA1Y1lpMEVKOGZtWUVIY1NZTHA3Sy9acmZQcG8xRGV3UThqRC8xWTN2?=
 =?utf-8?B?Yzk5NDljY3JYVUY5c2FMUlNLWmFNeGZOUUE1NkZncGV3U2JRRUkrOUQxd1B6?=
 =?utf-8?B?MWk4LzlUaWhNS1hqSnRtWVJoRzVqRk1HOU4wM3dQcFcvV01wYU9iZTBrck5W?=
 =?utf-8?B?bjNKWVlwenhvWEpCVmNRM2wzakIrYVdRcTFUZWZTblhSQTNyU1hudjZJRmtk?=
 =?utf-8?B?VGROamMyWDMzdWNCRUVsTVByNzZsK0k2MC9TdGd5aHRuQkpvNlU1TUhtV2hY?=
 =?utf-8?B?VHRhajZDZUZyTThLaitoMGovMmNWWnlMMlNHUGZPMHRGZS8zV25YcTYxTk9P?=
 =?utf-8?B?UlVxTUk4YWFzRnNzd2xuendvSEtlbGF2K1BIUTBtRCtSUzBLL214RTl6YW1K?=
 =?utf-8?B?NVZSYkJjN1pCTytvdVJiVTA2MmxXUytJZ1BsLzJDWUkrek1BQ0hIaGlHUUIv?=
 =?utf-8?B?aFFwcFRFd1Z2Zjd1VDYzZXp3WEl5ZUVlL2hyL0hmTVB6WFlydXZIS0QzajI4?=
 =?utf-8?B?aEdPeDhlZ01wT0ZFUXRDcEV0YW1hbkFSckNMUi9YaGdNa05vZEhaZ25Rd0Ja?=
 =?utf-8?B?NDR1bS9tQ1ZzRG0zUXgvNW44M0hZOGp5VWhtdTBYL1dpam1scjRrRWVNeFRo?=
 =?utf-8?B?c01DeFRTWGFtcWRsSXp3SXBnT2JieUQyOWRGMEtxOHhJQndZT2JwNHViaHdE?=
 =?utf-8?B?ZUJqaVpiOUx0aE5PSDJGaStGYzdudkwvYVRnckRjTHdSWXBnKzJCUVBENDZ2?=
 =?utf-8?Q?DM6Rn+WD33YL2pwVh55jS+vlb?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01bf44bd-3206-4ff0-91ce-08de09f92702
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 01:38:04.0808 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xCvpwn88wy33yYkHfQ4MBSRQlaHdS04wMbdARoFxlDeBwIPI3wsSWZGEUMTXOIsPvn4YtgWRy/RMwfMumcil9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10613
X-Mailman-Approved-At: Mon, 13 Oct 2025 06:18:05 +0200
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

From: Peng Fan <peng.fan@nxp.com>

Select configs to enable remoteproc for i.MX93-EVK/QSB/FRDM

Reviewed-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/Kconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 48f458fa55c0938b0219648541314b1655ffc980..7fd408815e3b62665f8cd7a0456d137385dfa444 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -69,6 +69,10 @@ config TARGET_IMX93_9X9_QSB
 	imply OF_UPSTREAM
 	imply BOOTSTD_FULL
 	imply BOOTSTD_BOOTCOMMAND
+	select CMD_REMOTEPROC
+	select REMOTEPROC_IMX
+	select REGMAP
+	select SYSCON
 
 config TARGET_IMX93_11X11_EVK
 	bool "imx93_11x11_evk"
@@ -77,6 +81,10 @@ config TARGET_IMX93_11X11_EVK
 	imply OF_UPSTREAM
 	imply BOOTSTD_FULL
 	imply BOOTSTD_BOOTCOMMAND
+	select CMD_REMOTEPROC
+	select REMOTEPROC_IMX
+	select REGMAP
+	select SYSCON
 
 config TARGET_IMX93_FRDM
 	bool "imx93_frdm"
@@ -85,6 +93,10 @@ config TARGET_IMX93_FRDM
 	select IMX9_LPDDR4X
 	imply BOOTSTD_FULL
 	imply BOOTSTD_BOOTCOMMAND
+	select CMD_REMOTEPROC
+	select REMOTEPROC_IMX
+	select REGMAP
+	select SYSCON
 
 config TARGET_IMX93_VAR_SOM
 	bool "imx93_var_som"

-- 
2.35.3

