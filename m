Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4640CC02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 13:08:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DF8380BA4;
	Thu,  6 Feb 2025 14:07:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="C6e6UvyP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AEFD80944; Thu,  6 Feb 2025 13:46:04 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::62b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BCBB807FB
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 13:46:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Oleksii_Moisieiev@epam.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f5LIOxl306vNuzu0QCtPllBTqBM+B/Vtsac/C4GbQzeXL6r1WJ1gh4t6xoL1Wxl1SLzNOKtA1sm2tXjoOE2QngjVpHCoGP93D04rloHOU+Xl/xn07Ynw2VeMFL8JXmXq3ToV07OJtDrDAp4+cCDt1HXzbvSvUjwkUxcT/+qHaOaPtF2ERn65/mGylLOZCVseZ0hUNlr68qIoeJ9bzspswI680ihT8f7tDYieFG9r9ioS612SAnDmTtvQ4U+Te98ONvsx1cyln0VPwbOL03pObjhdOvD80OXmSNepy+esqn7usP/z6tt6XZT5dsPwY3l5LLkMs82zT+Fqr+eIm/md4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Os3/ZXo5O1aODhcJe5b5ztj4JY2Wkpddk5wXZQUht+w=;
 b=dwJ950AYJXIPhy5WSvWlsXFrIplIOrUfPwFo7otjsHSMya/3/ln7NJN9PQFfXi9IXwLFANMLz48muxWTU1VkUw/di0obXHBwjbdtnJYh+NNFs9AepKUIwu6Ee7Vb1HMDo/MkM3oXdZc0GXnWaAFY0buUjHXZN6EIiBoaJh7recy3Ni3z3M4eFM+LF4tR0rI6I7EhX/VbhYh4XD3nXVrisSZSvHQAkPqVxQk574nFJNBtpuMV6W1dtSTkRJp1qFL/7VAipA9YQrPe9kB77+4Xjr7GL8DpKLq3vVkRYjcStpZzIMmTtEyAOG7mixsCVZuDkXfM8Q3A6ny8mErrY8L+SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Os3/ZXo5O1aODhcJe5b5ztj4JY2Wkpddk5wXZQUht+w=;
 b=C6e6UvyPkU3ZsLXEk5Ox4qrOasPmBbapscDlZSMb3HBpFg0YNV0zcPQq46s2OTpdMRNZ9XOeJd/rdBMKQJOdDev5Bn3ldrDUF+OxBT5xhSHetuqHZPMTmbhuJVFqT9wkvyrmN+cTwQNw8E42/khwPKs99+j1SGpooBybKjc+2tigbde5q9SyrtLUklVZRT8UEExR/ExcoEOmmYYd5ETplyu3GQYBGyCcmNJmFmaKMOhCKRLXPFkU1FOtoGllk8x59speE6gm/3hkXKx3oEXwE8NPKNr4aEZ4+REBOBDHfeRk/85OnRkcPS0T+XfLtMcHAj1MrQTBh1P6E4PL9q3+MA==
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com (2603:10a6:102:32e::21)
 by AS4PR03MB8625.eurprd03.prod.outlook.com (2603:10a6:20b:588::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 12:45:59 +0000
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc]) by PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc%6]) with mapi id 15.20.8422.010; Thu, 6 Feb 2025
 12:45:59 +0000
From: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To: Simon Glass <sjg@chromium.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, BELOUARGA Mohamed
 <m.belouarga@technologyandstrategy.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Lukasz Majewski <lukma@denx.de>,
 =?utf-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Marjolaine Amate
 <marjolaine.amate@odyssee-systemes.fr>, Matthias Brugger <mbrugger@suse.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peter Robinson
 <pbrobinson@gmail.com>, Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Ramon Fried <rfried.dev@gmail.com>, Sean Anderson <seanga2@gmail.com>, Stefan
 Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>, Volodymyr Babchuk
 <Volodymyr_Babchuk@epam.com>
Subject: Re: [RFC PATCH v1 00/20] Introduce support for Raspberry PI 5.
Thread-Topic: [RFC PATCH v1 00/20] Introduce support for Raspberry PI 5.
Thread-Index: AQHbd7boMg6OKeAhq0iRP9GJxZu6mLM6NqCAgAAEFQA=
Date: Thu, 6 Feb 2025 12:45:59 +0000
Message-ID: <e190bf7b-a024-4698-8450-2346d5b0531f@epam.com>
References: <cover.1738749764.git.oleksii_moisieiev@epam.com>
 <CAFLszTicLJR6n7WAaAmp5DDnk96gELO=x3qaOCwLCSJ510kKMQ@mail.gmail.com>
In-Reply-To: <CAFLszTicLJR6n7WAaAmp5DDnk96gELO=x3qaOCwLCSJ510kKMQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epam.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAVPR03MB8946:EE_|AS4PR03MB8625:EE_
x-ms-office365-filtering-correlation-id: b7dbe7fa-768f-4e0e-3dd4-08dd46ac350a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?anVYMHdhMWJFVGF6NUE0aDVhSkk3RHAwQ3FmL3BadGhPQXBITWlxNlNJSG5R?=
 =?utf-8?B?QTNtTWVyUzUyZThocjdWQUE0N0RCUTRNdko0M3YyUGZRLzN4aTFxV2cvdWM0?=
 =?utf-8?B?aWVPRnhPZWMwUHg1dzNnTzZ2ZFVGcFJRWG1VaFhFNGtMS253cnlkSm8vOWc5?=
 =?utf-8?B?WkpsaUpFcTF3dk1vcE10UlpaK0psWHJJTXRpVU9FT2pKOTJVcjJMVW1XQ3Z2?=
 =?utf-8?B?UysrUkw4WndMM2psRXFQc1REOU10MTUxNG9QS2hvZnhDWEl1UFlQRW5GVnRK?=
 =?utf-8?B?N2w3b3BTUlFqTjRMRUx0ekNMb1B3Y056WWQ4ZHU5bll2c1VYM3lQL00wZlJ4?=
 =?utf-8?B?MmdBeDk5SWh0TUd2NEZUOXo0WjVmMXZCSFB5c2VjYUg1UkJIYjRzc1hyOVZm?=
 =?utf-8?B?ZDZWcWFac0VjMUNEYzBCZGNiT3dkZWQ3aUlzaFVqZDc5YU81ZU5sTFd2S0tZ?=
 =?utf-8?B?RndBTU9STWlaSTNqaHZNa1MyM1E1alFTb3hRRzJNWWZQZEJlQUc3UHRJcjVB?=
 =?utf-8?B?bkZrcTRMNGRVcDBuNG5WL1JlR3NaYnlSVFZUdkFCUC93S0VoZmhEdG11djdH?=
 =?utf-8?B?eWRIOXBGVVlsZjhtblB1dEU4SWZVMzh5VzdFaWFjSWcvc2hwR0hLbDFHUVV0?=
 =?utf-8?B?dTN4YVAwM280WU5yNzkvVEd2NXVMaWF4VXNKZW1zZGdidDhUTUhNM0FHcGpj?=
 =?utf-8?B?dTlsWk9FQ0NuVGdMdmxseWNIZ283azFEVkRkU2RBMEt0VS9QVkt4eXZ4bkVj?=
 =?utf-8?B?aEx3YWVIT3NGZnpiekYxVjZJeDk5OHdOL0hwMGx6S3Z1UTc5UktPSk9jMU83?=
 =?utf-8?B?MmNwSVV0QVpoeXpRWU9ZRWZNV3ZvMjRoWWNUUGczMXVORjhyZVV3cHgyZnpG?=
 =?utf-8?B?RHhDQ2drQjFEeW5CZzFCR1U0eDByaTEzOHplRE9uSllKbGdUeVdMYzFXK1ZN?=
 =?utf-8?B?cHRTMHJwTFZqVllGdHFzNnkxT3ArZkJrMWQ0ZkhINWkvSDRhZ0lVZWcwYWNh?=
 =?utf-8?B?RERxR05vclpLY241YlpLb216bGc3K3B6dHNQK0dTSFEzTE83RmNwL1dSUVZN?=
 =?utf-8?B?bTBoVHNHMjZtK2l2dlJXQ0RBV0h2UFhpWVcxNVBmVFZrQ0RjQXR3Q0NuNE1T?=
 =?utf-8?B?TTVqY0o1a1Q1RTNFMTNNMXl3R29Lb1dVMjdUczRmWktOczlzUklCYjIxTEEw?=
 =?utf-8?B?cEhOKzRMRjZrNXV2S0d4alU5amxlcHE4QkpJZ2lFcC9iV3UrVlJ0S1pHeVF6?=
 =?utf-8?B?bnI4UVQyRVNVcVE1aGYwQXdPVlQ2Q09NaTYwM0VkS0M5VmdsSTZJVjVGUExT?=
 =?utf-8?B?VjBERzEvVlJhbU5LTXdVQXNkVmltOGZzRTI5SldoSTAvVXU0UkdSTDF6YjdF?=
 =?utf-8?B?SkxDdGFzR0R6U3cxckJrRzBZYnp6NmdnNnRxbi9WVFpCS1MzZUNkYnpKdFBF?=
 =?utf-8?B?TURrN1U1MnBYZ0N2TzNZV0JjSzFDQ0hCZ0tOUTUyd1N5dlpzNXFNZmo3aGw1?=
 =?utf-8?B?L0JWZzVDTHRjSDZLOXlmcEgyNEhqY3E2Q3ZnVkZEa1IyYktPZmNVUmVCQ2dY?=
 =?utf-8?B?QUZodmVNZU1Pelcyd0tjQ0p6dllNU1lIZkNHVTMrdUxvR1ErZEpPY0VORzRp?=
 =?utf-8?B?eDFLdXlzTDBNOTlFSmhQSGtuK1lzWHRxZ0p3eVJlZXRWMGIzL29LcWpnNFli?=
 =?utf-8?B?bmpuL0NmUFBEekUwWHdlY2hNVzJ2b3RqeVlGdkErd0x6eVBKTUkwRi9qVnZ6?=
 =?utf-8?B?aDZ0K3FOdGRqdjBVbUJERnBSRnRWT1U1eWw4TzRMbm13bEJXUHBoOGxhVTdh?=
 =?utf-8?B?YldTYkpabm1HcFZua2dBUjE1TVRTaTRzYnY0SnVHVjZnZkVVOVIxNTFRcm1r?=
 =?utf-8?Q?nrm/PTu/CHkuQ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAVPR03MB8946.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWxTS1pYbWZrSk5SSCtMK1Y0UjRraGhKTE53aFNLY0YwRHhRVFZnVWhKVkpj?=
 =?utf-8?B?elFPVm5OTFVrY3Fvc2J5MS8rbDhTbDJkeU9IelRBZ3JTSzB4K25uY3RORFBZ?=
 =?utf-8?B?NGd6SFR1bnRGOCtBdWgrTCt4SWJCOEE1OXhIQkhweGpnbnRZSThOcmJoMHFY?=
 =?utf-8?B?WXVCaWtVSEQ5RURTd1dEMDNLOTlLR2E3TjF6UzFjaXQzZlNORVR2MGhUSkFy?=
 =?utf-8?B?bGtSa01lSkxkV3oydEdFMGhZK1Naa1FXQU1ub2VwMWxUWk5mWWd1SDR6QkpH?=
 =?utf-8?B?ZHNBRTNXNFZaZ0lsTXZXQUx2ZmtuSTQya3d6K2JpSnUyUks2ZzFQM0ZGOWtT?=
 =?utf-8?B?dUFmZGdzc3BOTjJlWTJiczY2ZmZZY09CclBseGhHUUFublFHYnBtNUwyS2FK?=
 =?utf-8?B?QURVQzFqNnhLZkFyd0NvMmY2VTNKdG1jQnN4QThKN2pJa1U0eXRENnZNNW1h?=
 =?utf-8?B?YlVHaEpTYis0UDgrcUIzZmxySXUwNGcwOTgxdnBzZTFnRUwxSFRuRGZvQW04?=
 =?utf-8?B?UEsrdjg5UEduUzQzRWpaWWRwZzR2U1hNNHpTMmVIZmFvQ3F0V0pHUWdmaG5D?=
 =?utf-8?B?SmUwbkJ3ZHZLTm9vbjlDNDVNaDd6cXZ6eHRySWFSbnZXV1JBY3p2Uk84N1o0?=
 =?utf-8?B?VWx0THdOdmFSS1N4MFdZdnB3cTN2bWtBVFpLN3k2eVNkWTNLQ254UExpOGFB?=
 =?utf-8?B?UGlCYnloNzgrRVp2YUxHWk5Ya29WR3h4enNvYUZIU0s0b1hLRW9JQ2hDcUsz?=
 =?utf-8?B?bFByaTNTL1NOZExJNlMxYjlQZHp0L0lhd3NiQys0SldBVUhobWdJbm1HMlBF?=
 =?utf-8?B?SStPNzRaODEzakNWbUlKbzM0SVNKcG5MN2VxNEYrQit6bWkwWjQwcXNGY1Fy?=
 =?utf-8?B?R2VJbkRzTFRmQjRIeWlZR09MUk54Z3poRnBxNDNna0JCTWxXeVVWa1ZpUW90?=
 =?utf-8?B?SWRpVUV1bndUNkdiUFJ2N0hEZytzaEhQdHY4cmJxbXdYK0hPNEdGaEJZejI3?=
 =?utf-8?B?Y2NrZGI4OGJQZGtaUFhCYUNwZ1MvQTBUOVVFNllLTGNZSk1BNk1CakducXd1?=
 =?utf-8?B?d25SUFp3b2RkWmM3NkFQZWhBNFRxWnJkZTZNaG14dUhOelIybVlaOGdwdjIz?=
 =?utf-8?B?MDg1ZndMenk4NE15TzhvSmY4YjV2R2F0UGtHK3Y1RlJoK2FyWFNWMnloRllS?=
 =?utf-8?B?cUN5WWVhWTFtUDdUaGFrS3NiNGk3ZFJ0WWdKeFY3cDRBeUNjWlcvVVRINGcw?=
 =?utf-8?B?Y3BQYUFuMitiYlF2bmZjY2VjeTlNcjRhRVRqbHZqK1Y3MW1Ca1plV2pnQ1Uw?=
 =?utf-8?B?T1NSYmluTEk2cEFnOFI0TEF0bGU2RVgrY0F0ZExhTytTby96S0NDS0tXcHNh?=
 =?utf-8?B?bXRlRUttMUx2N2lMc3hMRTcrVW9xUkdQbmExWTV4OG5YRzZLb2FWRkpURmZK?=
 =?utf-8?B?ZW5hcmgxUUZ6ZnBlNUYvYmpYaHpkcXNrMDBTYlphL2MzV2lyOHJKZWZFYTJQ?=
 =?utf-8?B?andaRWR6U0pWRWc4ZTJJQXovcVc0MnRPcUxCTUNVSThBMWFxN3BBdG92RlJK?=
 =?utf-8?B?SnRqNkMzTm1XbllIMEZXSzRLNCt6VHkxOHVyR010QnhIMzVRUGJ2dmtqMm1G?=
 =?utf-8?B?aFV5dmowRW50eis1MGxvUjUva051L1ZKSDcrendtd2lTN29wMVlVVDh6R0pE?=
 =?utf-8?B?NS84NitvbzU3MzBLTWdyQlhBMFRMS3ErTlQyZExvRHdyb0N4ZTlCODlURHdn?=
 =?utf-8?B?YU9WclhiWG54UFRLeTduUHZvb3lqbzdUSy9KOXlZU0JsRnl4OWNORzRQMVNO?=
 =?utf-8?B?TTRVN1duamVJZGIvdVdPWHAxQkxwM3NtL1I1N0N6TFduRG1Zb1drcWtoTFZz?=
 =?utf-8?B?NmFqcHNFYlc4ZTRFZXRMeXBMWEtVZW5DUTFJTlg4WUVaYzVrcExLYXJzRXhP?=
 =?utf-8?B?ZHltUTdzdDcwTG0vUmFkTmgvd2plT0lFWVlGdnM0YmxYUEx5WnJXWVRlTkFV?=
 =?utf-8?B?ZUdobkFkYWtzOXYxcVBvSGpyK3FYZnhzQmVTc2tqcGhWeUlSdXVHczFiZVpP?=
 =?utf-8?B?S21JYW5rZWFkOHNJajhETWhhSC8wbXJ3dXJOcWNTd1YrdjQxekRYdE1WaWcx?=
 =?utf-8?B?SU1lWnhPNExhdE82bkhoaFJyNkhRWUdLdzNhR3ZVbkt3S0FzbEpmNmpFK25h?=
 =?utf-8?B?MUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC2CEE9B2FFD3D499E6DEDEFF098C6B6@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAVPR03MB8946.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7dbe7fa-768f-4e0e-3dd4-08dd46ac350a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2025 12:45:59.4573 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xMeEvcAZOn9mWmMqPYYG8uk3T0lzy/J8kDaCUaemqrLl8VfQKOk1vC0+LKbNuCdNOVNjeT77fNxEpl92XycXFP5d0w2dYLTXXpuJEWZnj1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR03MB8625
X-Mailman-Approved-At: Thu, 06 Feb 2025 14:07:31 +0100
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

SGkgU2ltb24uDQoNClBsZWFzZSBzZWUgYmVsb3cuDQoNCi0tIE9sZXNraQ0KDQpPbiAwNi8wMi8y
MDI1IDE0OjMxLCBTaW1vbiBHbGFzcyB3cm90ZToNCj4gSGkgT2xla3NpaSwNCj4NCj4gT24gV2Vk
LCA1IEZlYiAyMDI1IGF0IDAzOjE1LCBPbGVrc2lpIE1vaXNpZWlldg0KPiA8T2xla3NpaV9Nb2lz
aWVpZXZAZXBhbS5jb20+IHdyb3RlOg0KPj4gVGhpcyBwYXRjaCBzZXJpZXMgcHJvdmlkZXMgZ2Vu
ZXJpYyBzdXBwb3J0IGZvciBSYXNwYmVycnkgUEkgNSBpbg0KPj4gVS1Cb290IHdpdGggYWRkaXRp
b25hbCBoYXJkd2FyZSBkcml2ZXJzLg0KPj4gVGhlIGZvbGxvd2luZyBmZWF0dXJlcyB3ZXJlIGlt
cGxlbWVudGVkOg0KPj4gMSkgYWRkIGdlbmVyaWMgYm9hcmQgY29uZmlnIGZvciBSYXNwYmVycnkg
UEk1IGluY2x1ZGluZyBkZXZpY2UtdHJlZQ0KPj4gZmlsZXM7DQo+PiAyKSBhZGQgc3VwcG9ydCBm
b3IgUlAxIGNoaXAgd2l0aCBhZGRpdGlvbmFsIGhhcmR3YXJlOw0KPj4gMykgYWRkIHN1cHBvcnQg
Zm9yIHJwMS1jbG9jayBkcml2ZXIgd2l0aCBkdC1iaW5kaW5ncyB1cGRhdGU7DQo+PiA0KSBQQ0lF
IEJSQ01TVEIgZHJpdmVyIHN1cHBvcnQgZm9yIFJhc3BiZXJyeSBQSSA1Ow0KPj4gNSkgYWRkIGNs
b2NrL3Jlc2V0L2dwaW8gZHJpdmVyczsNCj4+IDYpIGFkZCBldGhlcm5ldCBzdXBwb3J0IGluIHUt
Ym9vdC4NCj4+DQo+PiBUaGlzIHBhdGNoLXNlcmllcyBpbnRyb2R1Y2luZyB0aGUgYmFzaWMgc2V0
IG9mIHN1cHBvcnRlZCBkcml2ZXJzIGluDQo+PiBVLUJvb3Qgd2hpY2ggYWxsb3dzIHVzaW5nIHN1
Y2ggZmVhdHVyZXMgYXMgdGZ0cCBhbmRcb3IgTkZTLg0KPj4gSSd2ZSBwb3N0ZWQgdGhpcyBwYXRj
aCBzZXJpZXMgYXMgUkZDIGJlY2F1c2Ugb2YgdGhlIGZvbGxvd2luZyBjb21taXQ6DQo+PiBlNTFj
YTBkMjIxIChIQUNLOiBkcml2ZXJzOiBtZmQ6IHNldCBiYXIgY29uZmlndXJhdGlvbiBmb3IgUlAx
IGRyaXZlciwgMjAyNC0wNS0yMSkNCj4gV2hlcmUgaXMgdGhhdCBjb21taXQ/DQoNClRoaXMgY29t
bWl0IGlzIHBhcnQgb2YgdGhlIHBhdGNoIHNlcmllcy4gSGVyZSBpcyBkaXJlY3QgbGluazoNCg0K
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvdS1ib290L2NvdmVyLjE3Mzg3NDk3NjQuZ2l0Lm9sZWtz
aWlfbW9pc2llaWV2QGVwYW0uY29tL1QvI20yMWNmMjM5ODlmYjA4Y2I2NTVlMjViMWEyZDA4MjYz
MmI2Zjg2NWM5DQoNCj4+IEl0IGluY2x1ZGVzIEhBQ0sgZm9yIHJwMSBkcml2ZXIgaW4gdS1ib290
LiBUaGlzIEhBQ0sgaXMgc2V0dGluZyBiYXINCj4+IGFkZHJlc3MgaW4gdGhlIGNvcnJlY3Qgb3Jk
ZXIgYmVjYXVzZSBSUDEgZHJpdmVyIGluIExpbnV4IEtlcm5lbCByZWx5IG9uDQo+PiB0aGUgcGNp
IEJBUiBjb25maWd1cmF0aW9uIHdoaWNoIGluaXRpYWxpemVzIEJBUnMgYmFzZWQgb24gQkFSIHNp
emUuDQo+PiBUaGlzIHJlc3VsdHMgdGhlIExpbnV4IHNldCBCQVJzIGluIHRoZSBzYW1lIG9yZGVy
IG9uIGVhY2ggYm9vdC4NCj4+IFUtYm9vdCBkb2VzIGluaXRpYWxpemF0aW9uIHdpdGhvdXQgYW55
IHNvcnRpbmcgc28gdGhlIGNvbmZpZ3VyYXRpb24NCj4+IG1heSBiZSBkaWZmZXJlbnQgZnJvbSB0
aGUgTGludXgga2VybmVsLg0KPj4gQkFSIGFkZHJlc3MgY29uZmlndXJhdGlvbiBpcyBzZXQgdG8g
bWF0Y2ggdGhlIExpbnV4IEtlcm5lbCBvcmRlcg0KPj4gdG8gYXZvaWQgZmFpbHMgb24gYWRkcmVz
cyB0cmFuc2xhdGlvbi4NCj4+DQo+PiBUaGlzIHNob3VsZCBiZSBjaGFuZ2VkIGFmdGVyIHVwc3Ry
ZWFtaW5nIFJQMSBkcml2ZXIgdG8gdGhlIExpbnV4IGtlcm5lbA0KPj4gbWFpbmxpbmUuDQo+Pg0K
Pj4gUHJvYmFibHkgc29tZWJvZHkgZnJvbSBSYXNwYmVycnkgd2lsbCBwb3N0IGFuIGFkdmlzZSBh
Ym91dCBob3cgdGhpcw0KPj4gY2FuIGJlIHByb3Blcmx5IGRvbmUuDQo+ICsxDQo+DQo+PiBVLUJv
b3Qgc3VwcG9ydCBmb3IgUmFzcGJlcnJ5IFBJIDUgd2FzIGFkZGVkIGluIHRlcm1zIG9mIHRoZSBm
b2xsb3dpbmcNCj4+IHByb2plY3Q6IGh0dHBzOi8vZ2l0aHViLmNvbS94ZW4tdHJvb3BzL21ldGEt
eHQtcHJvZC1kZXZlbC1ycGk1DQo+PiBUaGlzIGlzIHhlbi1iYXNlZCBkb20wbGVzcyBzeXN0ZW0g
b24gdGhlIFJhc3BiZXJyeSBQSSA1IHdpdGggWmVwaHlyIGFzDQo+PiBDb250cm9sIERvbWFpbiBh
bmQgTGludXggaXMgRHJpdmVyIERvbWFpbi4NCj4+DQo+PiBJdCBpcyBZb2N0by1iYXNlZCBzbyBp
dCB3aWxsIGJlIGVhc3kgdG8gYnVpbGQgaXQgb24geW91ciBzaWRlLiBQbGVhc2UNCj4+IHZpc2l0
IGxpbmsgZm9yIHRoZSBkZXRhaWxzLg0KPiBJIHRyaWVkIHRvIGFwcGx5IHRoaXMgYnV0IEkgZ2V0
IGEgbG90IG9mIGNvbmZsaWN0cy4gQ2FuIHlvdSBwbGVhc2UNCj4gYWR2aXNlIHdoYXQgdHJlZSBp
dCBpcyBiYXNlZCBvbj8NCg0KWW9jdG8gYnVpbGQgdXNpbmcgdGhlIGZvbGxvd2luZyByZXBvOg0K
DQpodHRwczovL2dpdGh1Yi5jb20veGVuLXRyb29wcy91LWJvb3QvdHJlZS9ycGk1LTIwMjQuMDQt
eHQNCg0KSXQgaXMgYmFzZWQgb24gdGhlIDctOCBtb250aCBvbGQgbWFzdGVyLiBJIGRpZG4ndCBk
byBhbnkgcmViYXNlIG9uIHRoZQ0KdG9wIGJlY2F1c2UNCg0KaXQncyB1bmNsZWFyIGlmIHRoZXNl
IGNoYW5nZXMgd2lsbCBnbyB0byB1cHN0cmVhbS4NCg0KU28gSSd2ZSBwb3N0ZWQgUkZDIGJlZm9y
ZSBtYWtpbmcgc2lnbmlmaWNhbnQgY2hhbmdlcy4NCg0KPg0KPiBSZWdhcmRzLA0KPiBTaW1vbg0K
