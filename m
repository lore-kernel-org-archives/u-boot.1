Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 744ACC02196
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 13:17:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4954C80842;
	Wed,  5 Feb 2025 14:15:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="vUYAYetE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D2C0807DC; Wed,  5 Feb 2025 11:15:52 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::610])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3B8080207
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 11:15:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Oleksii_Moisieiev@epam.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=huIGJx6FGZSnjPf32k70YXi5q77OsCHNUKclKh2oNyMViF2B8mNRNsUMjmh1H49nNksgKDBaRPfSwiF3xd9PKpehP5JVWB5ugyK63b+4gtYr+6DlrzubC6+yUyCBKb1hKiFEp1NkPhlq/w9CTniQBSkCVvZPXQ10fPBZxiBN/YPT5kw++4I0CKNj0mhTdI1ewMe4kOB8gHgLERP15zcuJfLVJ8xYWJ3Rz73ETsY0rGAuaZRkQdVlxtz5M7EZSnqfU5Jwl8EHgGuuyWG8eBObOeyCoohympDRBmFDarN2/hHa8xVj/Lr7shecxMHlJa2AgM4ZjZPW2lg0if03vyVcGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCU0oqQMHfjEpnxnBiBgera2rP8QkYjxkGo2/jDf534=;
 b=EtjJZJNt+VqUvBHpiw4EF4a+iBB7XgMxbLiKSHtuKnk4191SJ27j8KjPPGIvTQRaZGqxdl8ETKAWqKwT0y2IIaw7FY1fHOIU8MeMs8E+aykmePgwBpreWF6n58Xm7+gUJfjfOSW9YWZwyIvouRFQu4zEIgU/w2fB04LpUe18CJ18EQe0kOm9WLhavvvwlxPcREFUOmXlDs/LnPeFKh5l+Mnun3RQadRMV/Vx0+mKOIcAkvHBv108RGZ0FoEnWtCKrX+cMKd8khk2R1zXG7cFtPJG4bDoblzYNAYBHlg5fc5nhhvGs2VYz5kOv3NiyFr0BR5cIvrpMFjXlwPPhaQXqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCU0oqQMHfjEpnxnBiBgera2rP8QkYjxkGo2/jDf534=;
 b=vUYAYetEFYgCC85a0Y/yRaKbzGkl3lSuZbjQIpQLxOS7nYcQsxyh3al43WD+fABlmibmVLDNiEwcdVQmieNaO2xUKkZXeaa5gVa9oDN1+ziBYzbxVAQKT0FKXefyHkGtpVpxIdxsp6C0Ok5WiFHpJTKLa4qNx+Zx8cUUvfem58h6fHSfl2AkfV8hsF9mnGmeW2Id0rBnsj60S/r2TnFWReuj5g6/GET5qWqEuMx+LLGWd9VOzoTiwOlB6KENugpUkz3dYfQXM4Z1oR5fARZZxDbZTJn6vAsyFcU1F2z9AagqJz7Km/HX2vUKnPT+2HZAAYoXaFyUdmEWcSxIdCIZUw==
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com (2603:10a6:102:32e::21)
 by DU0PR03MB9635.eurprd03.prod.outlook.com (2603:10a6:10:42d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 10:15:41 +0000
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc]) by PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc%6]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 10:15:41 +0000
From: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, BELOUARGA Mohamed
 <m.belouarga@technologyandstrategy.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Lukasz Majewski <lukma@denx.de>,
 =?utf-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Marjolaine Amate
 <marjolaine.amate@odyssee-systemes.fr>, Matthias Brugger <mbrugger@suse.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peter Robinson
 <pbrobinson@gmail.com>, Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Ramon Fried <rfried.dev@gmail.com>, Sean Anderson <seanga2@gmail.com>, Simon
 Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>, Tom Rini
 <trini@konsulko.com>, Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Subject: [RFC PATCH v1 00/20] Introduce support for Raspberry PI 5.
Thread-Topic: [RFC PATCH v1 00/20] Introduce support for Raspberry PI 5.
Thread-Index: AQHbd7boMg6OKeAhq0iRP9GJxZu6mA==
Date: Wed, 5 Feb 2025 10:15:41 +0000
Message-ID: <cover.1738749764.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epam.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAVPR03MB8946:EE_|DU0PR03MB9635:EE_
x-ms-office365-filtering-correlation-id: 2dac27a6-2ca9-4bcc-7114-08dd45ce0b61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?UTJUTnd4eDFNZEgyekNYWDlZcWtWaXlQYmloMG5SNEc0RldvYWI4T2loYmhI?=
 =?utf-8?B?QVRQTzZTeFBPV200N0dCODVOSXpGTERuTXp0U0tNdnF0bGsvbHl0VWlUQVIv?=
 =?utf-8?B?a0JNSk5BMXFTNlY4ZWVBRWZsTE1ndTZ2ZWF6WW93TzlNSG5kOEtTcW9kM1ox?=
 =?utf-8?B?M0VxSmhqTjA3TGRtaVcwc0JLdDZWbjJUQmhwV0FmK0VJcTRHUkJOUi8zUEJ6?=
 =?utf-8?B?Zm9FcnBZM2N2T2kwbW1SY1krMURUWHlWcUVIK0RFWEkwYUw4VUFMT29wVjBT?=
 =?utf-8?B?emJUV2k5bU10Z2JHMWpvOGN1N1NmelRib2dnNG4yNFI1QUtIZFp5eDZZck43?=
 =?utf-8?B?U0s5RERkeFkvQVZMSWdXYjJnQ2lqNG1UZU4wdXQvdUlDVUVudjNYWkZpUWsz?=
 =?utf-8?B?V000WDRFOHZqcitqdnZNWW5Ta3NkTEZLeUpUTGg0VytVdFEySXVvSUZ3VjYy?=
 =?utf-8?B?REswYk5YekZBSlhKWml2bytsT2Q5M3d6eVFTVk5rZUNyNVR1NmVUKy9zYlI5?=
 =?utf-8?B?aVlHWUJabnF0R00yRXBOcHpOYUhEQ3IyNEVLQzhBVlUwZ281azhIZzBHS2xh?=
 =?utf-8?B?RVhVN2JqaGszZ0dYM2J1dVgxeExwbFUvT29ockVoVTV3NTV1QkMrOG5yczFn?=
 =?utf-8?B?Y00zdFdoa1R6QytnRHQvNnZuTmZPdmc4UG8xNFNHM3dUNGlESThZV21kc3M1?=
 =?utf-8?B?Zi9TV2luNU92Qmt1cjFOZ0RsRnRjYU45QXcrRzF1dHg0OXhPQWVpbHVvNVRt?=
 =?utf-8?B?ZmNIcXhSSGwrU3kyTHQ3ZHNXRTVNeUVYRHhLMFU1OWtQbHJQM2hlVzQrRk1L?=
 =?utf-8?B?UEhsWmptU2dFeEJ2amxLNlVZR2hOd0Q4b0xDM1RpSjdaQnFOZ2w0OTZXWnVK?=
 =?utf-8?B?MDIrUEZNTWhoNXBYcTZxai92czlsaVRmVGlIeCtVandjaXloRzV2emtpdFR5?=
 =?utf-8?B?RytPRzZST0Ryc01DSmRFaXUxcXlCeXQ3NEMrQm0rMjc5RFdvekFsMW5Id2Ru?=
 =?utf-8?B?M2FiQ05URFBTMytPbzkyTUk3eEYyajIzTzhTR3NacUhNZ3k0Z1JTTEJhdWlj?=
 =?utf-8?B?aUd5UTNmcG5DQUhWby9pWVJQWGM2NGpIekppT3JxMWJqNTZ0TlRHZ3FVSDZB?=
 =?utf-8?B?c2J5NnRROHhUb2tkMENkWGNaaURQaVIvTDlaWEo0ekpEWmlQRmVtS2FKZUFC?=
 =?utf-8?B?bm0yTW9EbC9pRGY5MTBqNTJXbDFmTU9ZR2Q0RU82L05zbWdqOVJHcXhIS25j?=
 =?utf-8?B?VXNYY3ZOQ3V3SnFXVzR4ZWJPcldMaCtsbkJKOEJaVi9MWnNtRFRrb0greWcz?=
 =?utf-8?B?L3JndHR2Z2RJdFVhNlMvUzcwNlkvTlh0VDdFUVBBRUo2R01Ia1NxUldVWXln?=
 =?utf-8?B?MEVVcWkxMWxuV01uTlpDa0dVVzB1VTNwcHVEbXVZRitpcjdUU2NRRU9SNll6?=
 =?utf-8?B?dkxQOTZSRExnbWNqSlZwL2dQMHBSZ2ZmN1EzK3JadXQ1TFAydHpZM3V3NnFT?=
 =?utf-8?B?WlQvTzBENjI0U0xwNE9Ldm10Q3UzRklQcytwUlRpd2w4SlZYbXJQUWRXZThX?=
 =?utf-8?B?UVhxT2NCOUg5WjVuQmZuSWtNMDhKVVhmS0RTWHpkUVZ0MlMwUklnOW5OWXNX?=
 =?utf-8?B?bmdWd0lmMDc0MkxxWGt5R1hJY211Y3dQYVNuMy80UkpxWlpUWm9WTXcySlEr?=
 =?utf-8?B?LzJ0THQrblpubVpRZTJoWWZtNTk2VWdzenEvUDFPTFJHYjUyS21OU0g0RnJ0?=
 =?utf-8?B?OW1RZFAvUDFoL2czbjA2ci9rcVNuUEdFSXFaek9neWswRzRkZ1NybFVjaFdM?=
 =?utf-8?B?QXRlbkhsampFMFdEL1JISjh5TG9reFdYN29TaTVMMzRrSXJxUFN3bElpOUFx?=
 =?utf-8?B?R3B4L2RMa1dsbDhsM2hBY1hUK3A3ZzVXK1JOZzA4a25DRnJ4VW9wc1JSblc2?=
 =?utf-8?Q?ORSVC6IwOUzCGyYt3MPdfjf3ZLNjRsCk?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAVPR03MB8946.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUNvc2V1OGNPMmUzVUV6aUFGUWxjR0dNcFVUaWF4b2pGV21OODZqV1luY21W?=
 =?utf-8?B?ZkVmaC8rRlAwYzFUajNOMS9JVjliY2l4Z0RzdDVBampkNlZXbWhSRE5rRC9o?=
 =?utf-8?B?SGtvZlIwNTd4MnhUUEIyMmJQenVxMjFpdVByYXFpYUd3WWc4YWRyVjlvcXRQ?=
 =?utf-8?B?N21RaVlCcEJ4eUtNT2R6STZlWGtFK1pQTENyOG8ydTEvWGI2WjJDYXpucytS?=
 =?utf-8?B?R09jYmF6K2kyNVlzMENYVlRncGtJanVIRjVpY2hRcUFuRzIxU1ZQT3R3ZUJR?=
 =?utf-8?B?Wk1zbXJpd0tZb2c3YnFZSndoa1JxRXVlVGFxMVpqc25HVG9SS2R0TzJhOEhG?=
 =?utf-8?B?c3RtT1dzR2kvVXQ5bVNCS1VSNkZkUXZwcHlSOGRHaldLaHl3SmNHNU0zVzRN?=
 =?utf-8?B?blRVeVA4ZCtKejNXY2ZYWFdZVGhjTFJ6WDRHYk8vMXJnZ2tHQlZyRHFvOHFk?=
 =?utf-8?B?a0s2aWlFdi9LTERWRWg0ZG1KaE5YSDBBS3FHSVk4dFN1T2xxdGxvVXF4bktr?=
 =?utf-8?B?a1JnTEI5UHcyY0pxdWZwcDVWamxEVEw4WmR5Qk1BOHA3dlVWM3JnN3lkK1lT?=
 =?utf-8?B?cU0zTzNHWEsySDhVcjJyUzl6VzJOTy8wQ3pEMlFOcHhCNHJPVXlua0ZnRm1S?=
 =?utf-8?B?NnNMTU5GMFQ1c2pEVFhrN2VETDBXSUt3VXZDR1Z5dGtBVTAwTHdIUGc2d3V4?=
 =?utf-8?B?b0Nxb1ZNL2VtUW5uOE1kc1l6T1hlSTUrTG1IcTB3TjE3UFMydW05eTJRY0po?=
 =?utf-8?B?NitKck5GWEFqb3NoME5yVXBIMkhpZGdJaHBvVVpSd3hFYjAzTUxZSjgyeU54?=
 =?utf-8?B?cjJySEFWWHQrWTZ0UFkwU09ueklaVnRFVU9MTXRxZ29XWHMzNlRIT2N6UFZX?=
 =?utf-8?B?VEpNWC9kRkRJaU5qb2kzczZLV2hFNnMveFhaWkU5Wm16Ymk4MWN2UWJ4ckJm?=
 =?utf-8?B?ZEZyL29RM2I3YnJzK1pqeVlQWkEzdlZ0bitnMDUwTDc0ZHNEZ2laRk9LaEFi?=
 =?utf-8?B?OWhQNTlUWE1JK2dVZTBFeHc3V05uT0UrRmJING5hd2RhT3IwSjdvQ2NJQW1B?=
 =?utf-8?B?WHEvTEw1SlMydzQzaGRZRUpHRlhNWWdVTGE1Unc3SDFRbFQvUmxyTElIN0xY?=
 =?utf-8?B?VjlzZVZYQ1FwdlZJY0dLOXVDb25Mc0hXbFQ2RjQ0NzI0N2hIZENxelRnWTdU?=
 =?utf-8?B?ZEFydUtwZDArQzV2dDF4Q1I1UFE5czBDdEdQejN5d2tqZC80TUZQd09DR0U3?=
 =?utf-8?B?VCtGMDFjY2ovbmdLOU5ETmJUQzR4M0JraGxLTURvcVM4OXVzdnhOLzU0UWNV?=
 =?utf-8?B?dzdUdUFEdE95SlFrNkdMWlhkVGVZK3U4RHVHa0QvUGRidjhvdEdnVDkwTTZj?=
 =?utf-8?B?R2lFN3VKeUlmemVOYVpjeWZ0amNiUWlnT2s1aTlBbUpKbXRLcHdtQTZHZy9x?=
 =?utf-8?B?dFVrWmJhWEdIVDFGbXM1SzhYRmlBYy9YYlhWaXlpcE1GYnVONGpCQWgvYXdL?=
 =?utf-8?B?YmRtVG5URysxaFdoc1ZNWnVWZ3FtTU56aSsyYkI3d3c0UFpTZnI2TmNFSTJU?=
 =?utf-8?B?SndDMVBlZFhSNHhxUC9HVHd5WTFHOFlJR0c3SXNuL2VPRDdSaGNHVFVKbnpo?=
 =?utf-8?B?UlVvci81cTFTY2RTc1lLY1U3Y2VzK3c4Nk5kNXlUK2J1ZlEwRk1JeUlueDRB?=
 =?utf-8?B?dGZrREFMdUtHenplTU5ubGVGWGFINW10czBWMy9HQnRUdmJlWjZRbFFFQ05I?=
 =?utf-8?B?ZU1lb1ZJb0NKVGpMdVlYRWxlVlZXME80NXVXUGNmSDN0N2Y5ci9NMkVhVVkv?=
 =?utf-8?B?VWRQV0xoZnlBeThFMXc0Q2pHMHRPNVpac0x3YStLOGNDandPbEcrbU95eE56?=
 =?utf-8?B?TzRNSWlibnVXVU9nWmxLQitFTEdMMVlORDlVSEtiSmxhOHZMM2hlRGNERGhi?=
 =?utf-8?B?dXhVZnEyMUFlajZVMFdCb3c4YVlKOWUwYjk3Q3FrenFwTWhpdUoreEUrRCti?=
 =?utf-8?B?Y0pPZWNpL21Fb04rbHVoOEpsWmRuaEFrZDh1T0NPSEp3YWticTJPZFdXUnVT?=
 =?utf-8?B?U3k0bWo3U1FqMU9pa1BIN29PVkUvVkpGYzc2NUFGcDNRNTloVmE1dXVjaW41?=
 =?utf-8?B?c3lVcjFkNWxVUGo0N2wwSVh3SVV3Q1NOZFZGekJFakdPa0hLZHlZWTExVm95?=
 =?utf-8?B?d2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <193655947179CB45B853CBB826BE7DCC@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAVPR03MB8946.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dac27a6-2ca9-4bcc-7114-08dd45ce0b61
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 10:15:41.2773 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: veh5LYmMgxta1tmLF1YqLGwME3Ca3x5bcJjcJ/ApaPK024ev1VW8HdkqffsbRJkzODFNgQjztzM0zC+AOJnUGA6UkQFv8Zi1DezWw6p2ilE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9635
X-Mailman-Approved-At: Wed, 05 Feb 2025 14:15:26 +0100
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

VGhpcyBwYXRjaCBzZXJpZXMgcHJvdmlkZXMgZ2VuZXJpYyBzdXBwb3J0IGZvciBSYXNwYmVycnkg
UEkgNSBpbg0KVS1Cb290IHdpdGggYWRkaXRpb25hbCBoYXJkd2FyZSBkcml2ZXJzLg0KVGhlIGZv
bGxvd2luZyBmZWF0dXJlcyB3ZXJlIGltcGxlbWVudGVkOg0KMSkgYWRkIGdlbmVyaWMgYm9hcmQg
Y29uZmlnIGZvciBSYXNwYmVycnkgUEk1IGluY2x1ZGluZyBkZXZpY2UtdHJlZQ0KZmlsZXM7DQoy
KSBhZGQgc3VwcG9ydCBmb3IgUlAxIGNoaXAgd2l0aCBhZGRpdGlvbmFsIGhhcmR3YXJlOw0KMykg
YWRkIHN1cHBvcnQgZm9yIHJwMS1jbG9jayBkcml2ZXIgd2l0aCBkdC1iaW5kaW5ncyB1cGRhdGU7
DQo0KSBQQ0lFIEJSQ01TVEIgZHJpdmVyIHN1cHBvcnQgZm9yIFJhc3BiZXJyeSBQSSA1Ow0KNSkg
YWRkIGNsb2NrL3Jlc2V0L2dwaW8gZHJpdmVyczsNCjYpIGFkZCBldGhlcm5ldCBzdXBwb3J0IGlu
IHUtYm9vdC4NCg0KVGhpcyBwYXRjaC1zZXJpZXMgaW50cm9kdWNpbmcgdGhlIGJhc2ljIHNldCBv
ZiBzdXBwb3J0ZWQgZHJpdmVycyBpbg0KVS1Cb290IHdoaWNoIGFsbG93cyB1c2luZyBzdWNoIGZl
YXR1cmVzIGFzIHRmdHAgYW5kXG9yIE5GUy4NCkkndmUgcG9zdGVkIHRoaXMgcGF0Y2ggc2VyaWVz
IGFzIFJGQyBiZWNhdXNlIG9mIHRoZSBmb2xsb3dpbmcgY29tbWl0Og0KZTUxY2EwZDIyMSAoSEFD
SzogZHJpdmVyczogbWZkOiBzZXQgYmFyIGNvbmZpZ3VyYXRpb24gZm9yIFJQMSBkcml2ZXIsIDIw
MjQtMDUtMjEpDQoNCkl0IGluY2x1ZGVzIEhBQ0sgZm9yIHJwMSBkcml2ZXIgaW4gdS1ib290LiBU
aGlzIEhBQ0sgaXMgc2V0dGluZyBiYXINCmFkZHJlc3MgaW4gdGhlIGNvcnJlY3Qgb3JkZXIgYmVj
YXVzZSBSUDEgZHJpdmVyIGluIExpbnV4IEtlcm5lbCByZWx5IG9uDQp0aGUgcGNpIEJBUiBjb25m
aWd1cmF0aW9uIHdoaWNoIGluaXRpYWxpemVzIEJBUnMgYmFzZWQgb24gQkFSIHNpemUuDQpUaGlz
IHJlc3VsdHMgdGhlIExpbnV4IHNldCBCQVJzIGluIHRoZSBzYW1lIG9yZGVyIG9uIGVhY2ggYm9v
dC4NClUtYm9vdCBkb2VzIGluaXRpYWxpemF0aW9uIHdpdGhvdXQgYW55IHNvcnRpbmcgc28gdGhl
IGNvbmZpZ3VyYXRpb24NCm1heSBiZSBkaWZmZXJlbnQgZnJvbSB0aGUgTGludXgga2VybmVsLg0K
QkFSIGFkZHJlc3MgY29uZmlndXJhdGlvbiBpcyBzZXQgdG8gbWF0Y2ggdGhlIExpbnV4IEtlcm5l
bCBvcmRlcg0KdG8gYXZvaWQgZmFpbHMgb24gYWRkcmVzcyB0cmFuc2xhdGlvbi4NCg0KVGhpcyBz
aG91bGQgYmUgY2hhbmdlZCBhZnRlciB1cHN0cmVhbWluZyBSUDEgZHJpdmVyIHRvIHRoZSBMaW51
eCBrZXJuZWwNCm1haW5saW5lLg0KDQpQcm9iYWJseSBzb21lYm9keSBmcm9tIFJhc3BiZXJyeSB3
aWxsIHBvc3QgYW4gYWR2aXNlIGFib3V0IGhvdyB0aGlzDQpjYW4gYmUgcHJvcGVybHkgZG9uZS4N
ClUtQm9vdCBzdXBwb3J0IGZvciBSYXNwYmVycnkgUEkgNSB3YXMgYWRkZWQgaW4gdGVybXMgb2Yg
dGhlIGZvbGxvd2luZw0KcHJvamVjdDogaHR0cHM6Ly9naXRodWIuY29tL3hlbi10cm9vcHMvbWV0
YS14dC1wcm9kLWRldmVsLXJwaTUNClRoaXMgaXMgeGVuLWJhc2VkIGRvbTBsZXNzIHN5c3RlbSBv
biB0aGUgUmFzcGJlcnJ5IFBJIDUgd2l0aCBaZXBoeXIgYXMNCkNvbnRyb2wgRG9tYWluIGFuZCBM
aW51eCBpcyBEcml2ZXIgRG9tYWluLg0KDQpJdCBpcyBZb2N0by1iYXNlZCBzbyBpdCB3aWxsIGJl
IGVhc3kgdG8gYnVpbGQgaXQgb24geW91ciBzaWRlLiBQbGVhc2UNCnZpc2l0IGxpbmsgZm9yIHRo
ZSBkZXRhaWxzLg0KDQoNCg0KT2xla3NpaSBNb2lzaWVpZXYgKDE3KToNCiAgaW5jbHVkZTogZHQt
YmluZGluZ3M6IGNsazogaW50cm9kdWNlIGJpbmRpbmdzIGZvciBycDEgY2xvY2sNCiAgaW5jbHVk
ZTogZHQtYmluZGluZ3M6IG1mZDogaW50cm9kdWNlIGJpbmRpbmdzIGZvciBSUDEgZHJpdmVyDQog
IGFyY2g6IGFybTogbWFjaC1iY20yODN4OiBhZGQgcGNpZSBtZW1vcnkgcmVnaW9uIHRvIEJDTTI3
MTIgbWVtbWFwDQogIGFyY2g6IGFybTogbWFjaC1iY20yODN4OiBhZGQgQkNNMjcxMiBib2FyZCBz
dXBwb3J0DQogIGRyaXZlcnM6IG5ldDogbWFjYjogZG8gbm90IGluY2x1ZGUgYXJjaC9jbGsuaCB3
aGVuIGNsb2NrcyBlbmFibGVkDQogIGRyaXZlcnM6IGNvcmU6IG9mX2FkZHI6IGZpeCBvZl9nZXRf
ZG1hX3JhbmdlIHRyYW5zbGF0aW9uDQogIGJvYXJkOiByYXNwYmVycnlwaTogcnBpOiBzYXZlIGJv
YXJkX3R5cGUgdG8gdGhlIGdsb2JhbF9kYXRhDQogIGRyaXZlcnM6IHBjaTogYWRkIEJDTTI3MTIg
c3VwcG9ydCBmb3IgcGNpZV9icmNtc3RiIGRyaXZlcg0KICBkcml2ZXJzOiBtZmQ6IGludHJvZHVj
ZSBSUDEgY2hpcCBkcml2ZXIgZm9yIFJQSTUNCiAgZHJpdmVyczogZ3BpbzogYWRkIHN1cHBvcnQg
b2YgUlAxIEdQSU8gZm9yIFJhc3BiZXJyeSBQSSA1DQogIGRyaXZlcnM6IHJlc2V0OiBpbnRyb2R1
Y2UgcmVzZXQgZHJpdmVycyBmb3IgYnJjbXN0Yg0KICBkcml2ZXJzOiBjbGs6IGludHJvZHVjZSBj
bG9jayBkcml2ZXIgZm9yIFJQMQ0KICBkcml2ZXJzOiBuZXQ6IG1hY2I6IGludHJvZHVjZSBlUENJ
IGNvbm5lY3Rpb24gc3VwcG9ydCBmb3IgbWFjYg0KICBjb25maWdzOiBhZGQgc3VwcG9ydCBmb3Ig
dGhlIFJhc3BiZXJyeXBpIDUgYm9hcmQgdG8gZGVmYXVsdCBjb25maWcNCiAgSEFDSzogZHJpdmVy
czogbWZkOiBzZXQgYmFyIGNvbmZpZ3VyYXRpb24gZm9yIFJQMSBkcml2ZXINCiAgZHJpdmVyczog
cGNpOiBwY2llX2JyY21zdGI6IHVzZSBidXNfYmFzZSB0byBjb25maWcgUENJIGRldmljZQ0KICBk
cml2ZXJzOiBwY2k6IHBjaWVfYnJjbXN0Yjogc2V0IGNvcnJlY3QgcmVzZXQgc3RhdGUgb24gcGNp
ZV9yZW1vdmUNCg0KVm9sb2R5bXlyIEJhYmNodWsgKDMpOg0KICBkcml2ZXJzOiBwY2k6IHRha2Ug
aW50byBhY2NvdW50IHRoYXQgb2Zub2RlX3JlYWRfcGNpX3ZlbmRldiBjYW4gZmFpbA0KICBib2Fy
ZDogcmFzcGJlcnJ5cGk6IHJwaTogcmVxdWVzdCBSUDEgaW4gbGF0ZV9pbml0DQogIGJjbTI3MTI6
IGVuYWJsZSBsaW51eCBrZXJuZWwgaW1hZ2UgaGVhZGVyDQoNCiBhcmNoL2FybS9tYWNoLWJjbTI4
M3gvS2NvbmZpZyAgICAgICAgfCAgIDggKw0KIGFyY2gvYXJtL21hY2gtYmNtMjgzeC9pbml0LmMg
ICAgICAgICB8ICAxMCArLQ0KIGJvYXJkL3Jhc3BiZXJyeXBpL3JwaS9ycGkuYyAgICAgICAgICB8
ICAyOCArKw0KIGNvbmZpZ3MvcnBpX2FybTY0X2RlZmNvbmZpZyAgICAgICAgICB8ICAxOSArKw0K
IGRyaXZlcnMvY2xrL0tjb25maWcgICAgICAgICAgICAgICAgICB8ICAgNyArDQogZHJpdmVycy9j
bGsvTWFrZWZpbGUgICAgICAgICAgICAgICAgIHwgICAxICsNCiBkcml2ZXJzL2Nsay9jbGstcnAx
LmMgICAgICAgICAgICAgICAgfCAyODAgKysrKysrKysrKysrKysrKysrKysNCiBkcml2ZXJzL2Nv
cmUvb2ZfYWRkci5jICAgICAgICAgICAgICAgfCAgIDggKy0NCiBkcml2ZXJzL2dwaW8vS2NvbmZp
ZyAgICAgICAgICAgICAgICAgfCAgIDcgKw0KIGRyaXZlcnMvZ3Bpby9NYWtlZmlsZSAgICAgICAg
ICAgICAgICB8ICAgMSArDQogZHJpdmVycy9ncGlvL3JwMV9ncGlvLmMgICAgICAgICAgICAgIHwg
Mzc0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKw0KIGRyaXZlcnMvbWZkL0tjb25maWcgICAg
ICAgICAgICAgICAgICB8ICAxMCArDQogZHJpdmVycy9tZmQvTWFrZWZpbGUgICAgICAgICAgICAg
ICAgIHwgICAxICsNCiBkcml2ZXJzL21mZC9ycDEuYyAgICAgICAgICAgICAgICAgICAgfCAxMzQg
KysrKysrKysrKw0KIGRyaXZlcnMvbmV0L0tjb25maWcgICAgICAgICAgICAgICAgICB8ICAgMSAr
DQogZHJpdmVycy9uZXQvbWFjYi5jICAgICAgICAgICAgICAgICAgIHwgMTU2ICsrKysrKysrLS0t
DQogZHJpdmVycy9uZXQvbWFjYi5oICAgICAgICAgICAgICAgICAgIHwgIDE2ICsrDQogZHJpdmVy
cy9wY2kvcGNpLXVjbGFzcy5jICAgICAgICAgICAgIHwgICA5ICstDQogZHJpdmVycy9wY2kvcGNp
ZV9icmNtc3RiLmMgICAgICAgICAgIHwgMzI4ICsrKysrKysrKysrKysrKysrKysrKy0tDQogZHJp
dmVycy9yZXNldC9LY29uZmlnICAgICAgICAgICAgICAgIHwgIDE0ICsNCiBkcml2ZXJzL3Jlc2V0
L01ha2VmaWxlICAgICAgICAgICAgICAgfCAgIDIgKw0KIGRyaXZlcnMvcmVzZXQvcmVzZXQtYnJj
bXN0Yi1yZXNjYWwuYyB8IDEwMyArKysrKysrKw0KIGRyaXZlcnMvcmVzZXQvcmVzZXQtYnJjbXN0
Yi5jICAgICAgICB8ICA5NyArKysrKysrDQogaW5jbHVkZS9icm9hZGNvbS9iY21fYm9hcmRfdHlw
ZXMuaCAgIHwgIDI1ICsrDQogaW5jbHVkZS9kdC1iaW5kaW5ncy9jbGsvcnAxLmggICAgICAgIHwg
IDU2ICsrKysNCiBpbmNsdWRlL2R0LWJpbmRpbmdzL21mZC9ycDEuaCAgICAgICAgfCAyMzkgKysr
KysrKysrKysrKysrKysNCiBpbmNsdWRlL3BjaV9pZHMuaCAgICAgICAgICAgICAgICAgICAgfCAg
IDMgKw0KIDI3IGZpbGVzIGNoYW5nZWQsIDE4ODIgaW5zZXJ0aW9ucygrKSwgNTUgZGVsZXRpb25z
KC0pDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvY2xrL2Nsay1ycDEuYw0KIGNyZWF0ZSBt
b2RlIDEwMDY0NCBkcml2ZXJzL2dwaW8vcnAxX2dwaW8uYw0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBk
cml2ZXJzL21mZC9ycDEuYw0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3Jlc2V0L3Jlc2V0
LWJyY21zdGItcmVzY2FsLmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9yZXNldC9yZXNl
dC1icmNtc3RiLmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9icm9hZGNvbS9iY21fYm9h
cmRfdHlwZXMuaA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2R0LWJpbmRpbmdzL2Nsay9y
cDEuaA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2R0LWJpbmRpbmdzL21mZC9ycDEuaA0K
DQotLSANCjIuMzQuMQ0K
