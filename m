Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87913C021AA
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 13:28:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60B6B80BAE;
	Mon, 17 Feb 2025 14:28:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="hPW8LYiO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 500F280F5C; Mon, 17 Feb 2025 09:51:27 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::602])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2E2180F56
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 09:51:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Oleksii_Moisieiev@epam.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZwLA+yg5E2nSYzF5eEsEbvyFUKZ4thnFsqsX9K55HVFXOb8bbd6bFWm7INYIaM7tpbMzbfhkFmkUVzEE1sj4Z8zSWPAsVHB/fRidQ6Sxa4p4Z8C945AKzuXUG7Y44v3IQwFJBAIvBnCcnQ3o/oRYW+fIRvzk8XeGK0ay255laq5sPX40VTp3XGBOQn3Ws1rWt3TGnFrDfsAnl0oLtRtYfALRfE6Utr7kVbN9iGDjK7xRNi+ke+Cb5fYVNkwEDdbzI2G0MP3XEKXOTfvExU8g51xsj3bhyb7MFi6uxxDxI4hlhtlgyNJP62Oe1txWG6huVftXxvcaIOhjwtH5AeMUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SkqF7hQfRRG/+CuzsPsrvQTie7uWY05fzFXOZCdHqPQ=;
 b=rdU2YjsRI5QLuuHMh/Hiq39StuTvBlWQYIv0XlCf+HEWm4/5V2eVzgdwRThgbTgV+GyqN898NE7u/r+gmP1Dr4FBAluVBSI7GUjuH7TDcw+iIkzjof/xSjwFvpmKP4H+s2Vn0OHt+WMOVWrrBWUKGFjStB8aWTmZ0vLPJFqXj0o1O8qz+KZGQMoEs1Pz2xRGpu+qwALTFtqE0gnYQgqNhVRf6GG6iqsdYGnaPNNjtxwELp3V1HXmJbRD/FkpFtYwP8fSIfTvEYyZSMxKKDwv/D6jCFl6F6AfeUp1tT6O/AOHkR7Uc0srTsVoSUMH/bQGcjlEIhBfdFCOG0mZBs7Xqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SkqF7hQfRRG/+CuzsPsrvQTie7uWY05fzFXOZCdHqPQ=;
 b=hPW8LYiOo1x9lz2IGXFvv8sgaQOYdI66L4g0saeAcVOes30RwOmdrUucpwUEWGL3VVSicugDrjuLlCK84BU1wSm6G0plZCi+iXMOSwIHlbxJ7BoGAQyTD7aoWpvTdUZdFu/oKGcE1wUDsgQivguOblPVmt+qXpNVJc+Oo3ymA8fjcVYmhnWjOK6/aJr9e+0rJxRgmHuD/iEHC0VBFjBSSBnO0GLS3WLSd/U8W9jWItyo7cVccJ6QUwjurzDz6bVo3aphgBqU3eKBn4gvg8VAEvCy3As29UDELhJ48A3HvKz0lLWnY/TOf/sfzxbMbfFKK0ZX/mRzUHvmLrfqs7aUxw==
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com (2603:10a6:102:32e::21)
 by AS8PR03MB9141.eurprd03.prod.outlook.com (2603:10a6:20b:5b4::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 08:51:21 +0000
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc]) by PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc%6]) with mapi id 15.20.8422.015; Mon, 17 Feb 2025
 08:51:21 +0000
From: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To: Tom Rini <trini@konsulko.com>
CC: Simon Glass <sjg@chromium.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, BELOUARGA Mohamed
 <m.belouarga@technologyandstrategy.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Lukasz Majewski <lukma@denx.de>,
 =?utf-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Marjolaine Amate
 <marjolaine.amate@odyssee-systemes.fr>, Matthias Brugger <mbrugger@suse.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peter Robinson
 <pbrobinson@gmail.com>, Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Ramon Fried <rfried.dev@gmail.com>, Sean Anderson <seanga2@gmail.com>, Stefan
 Roese <sr@denx.de>, Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Subject: Re: [RFC PATCH v1 00/20] Introduce support for Raspberry PI 5.
Thread-Topic: [RFC PATCH v1 00/20] Introduce support for Raspberry PI 5.
Thread-Index: AQHbd7boMg6OKeAhq0iRP9GJxZu6mLM6NqCAgAAEFQCAADW2AIAAArMAgAANFACAEMKZgA==
Date: Mon, 17 Feb 2025 08:51:21 +0000
Message-ID: <245acc31-9f77-4ac1-9a5f-af4fa8d14774@epam.com>
References: <cover.1738749764.git.oleksii_moisieiev@epam.com>
 <CAFLszTicLJR6n7WAaAmp5DDnk96gELO=x3qaOCwLCSJ510kKMQ@mail.gmail.com>
 <e190bf7b-a024-4698-8450-2346d5b0531f@epam.com>
 <CAFLszTjh8qd0ycyqafHUaBuBS0Lhgtp0763FUER6PO_QAw4JdQ@mail.gmail.com>
 <5db27eca-7960-463e-9345-46d40d8a3350@epam.com>
 <20250206165440.GE1233568@bill-the-cat>
In-Reply-To: <20250206165440.GE1233568@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epam.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAVPR03MB8946:EE_|AS8PR03MB9141:EE_
x-ms-office365-filtering-correlation-id: 170c55ab-fa2c-4a39-baef-08dd4f304085
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?UjNjOGNjejFadVJ1cmhqUUdUMFZ1b2REN3pFRStBaEtUaXJPR3F5dmJQdGkv?=
 =?utf-8?B?STVkRU1hSVZnK3pZSkh1QXAzMjZwQUs4TDJDQkhhRWJvZG5qM0ZvSU95SlZD?=
 =?utf-8?B?WEMvSHZGUWhQTDA2KzNPb0pqUUN0U2ZhaUNGWnFGa1dCTlR4STFDdDBSeDY5?=
 =?utf-8?B?WmpQQ2pWamdCYmpCWmoyN0VoYS9iWC9LYlFLdnQ4RVZNd3RObVd2d0tqaWlY?=
 =?utf-8?B?a0FvSWRoSWNVamlGKzVEa05sZFZZdnBGY3VTYlpndithKzkvUXRjRTJWaDhU?=
 =?utf-8?B?NHYzb3hqOXBIWUZhZnFqVHhQd0ZSVkhFemF6RUxQZlpoN3BnQWN3WldlTURt?=
 =?utf-8?B?QnczZUh2UzU3ZEtCaWhybWViS3J0RXh1dVZyczRDRWJXV29XcW02RFlDZVNC?=
 =?utf-8?B?Q2RhUEx5MkhtbXJURG5Ia3VETWJvNHIxOVpKRXFqZGNzNm9sZVRRelkvN3RY?=
 =?utf-8?B?bWg2Y3VJSjY1cEJ5MGs2QlBXWjhOTFJYTExYVi81RGtYVFZqZCtwZnhGdXBj?=
 =?utf-8?B?Sk1TZFpJYzZLZEE0ZW1Kc1pIVGNnb2x6NDY1UmZNOWM1MlU3c1Q0TUwvYWY2?=
 =?utf-8?B?OGFkcUdqUTJHNTBxZmJUbWpyM2pLWDFWZnF4ZWhmdG8yK0lGMS9FQ1dhWEFI?=
 =?utf-8?B?eDArWUFGWnVGdjVmT3B3Zk1sQWJIVVkrR0E0dFRvb0tHVlNUMUZOa3V2dXN4?=
 =?utf-8?B?cW1YMUFjUEEwU0drTGh5YzVPaCtWNFd5bmN4WHRZKzdjOXhEU0l2cE8xbFRa?=
 =?utf-8?B?dk9JVjM3MmN0UExHOG91UVFqZ2VNTU5hVWwyeHNFbEdLblRjVm5YUmh2cWFx?=
 =?utf-8?B?NnhWVTQ5OTNsbnpEK1hFR3lISGZENHhyZnFVZzBWU2c3ZHViRjdhMmZIVk5T?=
 =?utf-8?B?dTQwVmx4WXVEMERUbithY003M2pCam1pWXRaOStySVVURHhsWEJ2clN6T3A0?=
 =?utf-8?B?d2xKazZEYXFhWVAzcnZpQW41ZUhRQVNOdTdwTW5wYVEvMitzeFdpVWFpTTY2?=
 =?utf-8?B?RzJuWjBOWmFjamcwVU5rK0VDaThaUlRjS0ZWVFpYTTVpUmE4cG5Hc1BXVHZH?=
 =?utf-8?B?ZGd5Q2dLdlVZSzZ4MHNBK2RhcXAwUU1VS3JLTXM4WkkzMlZlTDQ1TEFqNVBz?=
 =?utf-8?B?MTltRTRub2s5RENZUklLd3N6WkpYYStvS2piRUhNTGFUcjdqMko3NXNhZk1Y?=
 =?utf-8?B?eVl4TC9wZzhmcWJZeGlhRDVhdVB2Z0FnMXpoNkNseWwzRVFuczZmdjJ5Vjl2?=
 =?utf-8?B?YmF0eUVwb2xlMGNjTVlCaG5zWml2blFBZHZaVXI3c01zbHNaQ3RkSjROdkw2?=
 =?utf-8?B?RUNHd2xqb1U3SjEybEwyeWFEYytrM0hoTFJLNVlGYXJ0U0JnWFdDMEMxYlk5?=
 =?utf-8?B?SVl1L1FNUm53UUJ4alIzOVA0UVNaWDM3TGxTKzZCRDdGUEtsQWVVdGpVMnZu?=
 =?utf-8?B?NVFTUXlwV0tkcS9iNEUrb1poa09icXlUckRJdGJ1eGRPWFJoWU9mbldvYXAz?=
 =?utf-8?B?NDZjZURXS3ZMWGlpZzZWd0M5bUhlYkNkM2V1T2N1bERVNGpkRnF3VVNzZUVE?=
 =?utf-8?B?cXJvb2d3akxlWGozV3IreDI1cnZJTFQvVGQxY0VMcWhnQUxOM2hhakpML01u?=
 =?utf-8?B?bkNvRlZWSk9weE1jM3YzMlEwZzFEVFl2RmNHdmZxSjRmbnlJVXlwN1JFOGJZ?=
 =?utf-8?B?NVFmY0hkM1RoeVBzaGN0U0YxckZMdDA0RnFMZHcxbnRqQ2ZhYzlZZjlBbGNq?=
 =?utf-8?B?akJWbnpucUdORFVZRXVKWjNEYVFzbEhaYzZHWENXaVZzcE03SkpKOWZMVDQ3?=
 =?utf-8?B?a0VBUUxxYWlUclF6Y01RZzRHaEtJSGhxU05zQ20xelJQc3VpWXBPazZLZGJX?=
 =?utf-8?B?WFRzZ0JYQXlQb1dqeGVhSmlFRENUZ2lneEdjWVZOMmhYQ2c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAVPR03MB8946.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S05oRFBoZ2Q5dm82TzJUTGpBaEhCUHAvRXVMWkZmN0txNzNucGJDRjlhZGZK?=
 =?utf-8?B?dnJYLy9Jak45bW1tRGxSVmxyQllKeGhBTTUzcUxQL201RVAreDNwUVAvTU9E?=
 =?utf-8?B?NHJBQ1RNcVFBOUN2WUNzdDlTZWFMbzJYclFDTXN5M2lxemQ3NkwxdkYwN0pP?=
 =?utf-8?B?aXhBa3Q1dmlnWG1Bc2h6Q0lEbDZTU2tmNUFXZXBXdGRTQ0l3cWhYVjdWZCs3?=
 =?utf-8?B?L09EL09jVUxFcm43K3Q1cVk0d1g3VE04TGVQRlI3djJEU2JPK2x1MTM4UmZB?=
 =?utf-8?B?WnVmN1lKcThwam1Ka0VBaXpiWlovTWlGZHh4c0w3emVTVVlZV3Jqb1BGVGlS?=
 =?utf-8?B?QUh0YXdNZEN4V3VvMW9xTGpodENpbGNyUTBqZ0RRcEt2ZDI4SUpGR0ZwK2do?=
 =?utf-8?B?TzZsTExDZ2Jld0lVdlM2ZUNZS3kwY20yamtrYitKQVhWUzdJa3VPZ3Z1bTZu?=
 =?utf-8?B?WG41VHE1czd0S3RORGxmbW9rakNCZ3VvakF2dmlmZFAwRDZaNzUrelJGeWxN?=
 =?utf-8?B?SURVMUFkZEZMaEFhaVlSTURTbVNhRlVsWVNHSXNuQ2dpVDRsSnJjMlJRTGxP?=
 =?utf-8?B?YWxkb1BlK2E0cHFzS2lTamk4N0x2UjU0TWFjR1JWanBxeHp0Y24yQkFuN3lo?=
 =?utf-8?B?Z0tKeGppeWdCQUdCamJqOUJBUFFoQTJra1RTbTZwZ09EZnpwelFBL0R6UTVL?=
 =?utf-8?B?b2FYdldXYmhhaldXV0N2a0pyOGp3T01hSHFVVmJvTWl4dTJGeXFwSlZIU0Js?=
 =?utf-8?B?aEtqem01eDFBRHB3aFhZbk0vR29BUmhwYmk0TlFiMis4cGZQUFl2WEtaWXA0?=
 =?utf-8?B?a3plK0hiT0ZHVkE5OWlwODNETCszcUxIRFdTZUYyUm5kQldOZXpNMlJnaFNq?=
 =?utf-8?B?d2dZVWdaRkg5ZVJNcE1GYlR0V0pPTjIrSHQ1K2RkNlRqeE5nMGtNcERZU055?=
 =?utf-8?B?Q1h5dWQxajBLcXpVbGFDQWJ0WnlvTmJNTkkzaTIzYWU5RzBJbzhCTEQvN2x5?=
 =?utf-8?B?WmVqbXVBNE1lT2NudGJiN25UMHpVN0JFZGUwUHdlcWZMTUdUaE9ITkFOWDJK?=
 =?utf-8?B?VS9aQmxCQnpManEybXJMbnVpSWF5UU5SMnB0dDkyelJMQkJkd1FoUlFxbE1v?=
 =?utf-8?B?aWpKV3hDRThZelFuK3YwN3NjTmNVVGo1dXBMbU0rRjAvYlpHTUNtSkd3bG1l?=
 =?utf-8?B?NUlKUnVsZnhSckpBTjBGbW1jUUZwRHI2YTZ5Vjd5RjBpNXpGcFZUbS9WeE1P?=
 =?utf-8?B?R0Z6S295QnlyeVdRc3FPSXk1Q3RrYmZmMVNxdTFNR3Y5Tmh1WExUSUZpWE1L?=
 =?utf-8?B?eXBWZFpwVFhsdzlnbjNlZzlZVWdoSEpxeG5MNGZqY3FwWmpFRXdaeCtPZjFE?=
 =?utf-8?B?Zy9PcTJ1amJzOHpiYzRKbm01dTVsZnBiZHRsQ3RIcnRGUzY1SyttZ2srSHAy?=
 =?utf-8?B?eUN4NU8xaWw4c1lBSldyTDY4WUNpcEZFSEgrZ2VWNkx6Y2pjWFZ3Nm1UWTFp?=
 =?utf-8?B?MXBqMkltTzJmSmVWb1lXYzRTais5OEMwbEVrdGJ5MVQraXNFSjhReU1kamoy?=
 =?utf-8?B?V1JTSGNHZDZnS0NQejJoS2FJNDMzQlI0QkQzNk0yOWRXYlZmaU43SHJvWVFH?=
 =?utf-8?B?dGJzeVJOV1AvVUVVcEZmL0pqek9TZUxwalJMVW93YTdFRE5WcXh5SmtzYWxm?=
 =?utf-8?B?R3ozRHNNYVNUZ3R4QmRqSUpLWjlhRTJJSFp1TjZCcjdGN09UZXgraHN5b29Z?=
 =?utf-8?B?c2llYThNWFkxSU1WZVJWbE90U2E1ZVZSMXdTV001U21OZUhndG1PajNnei9X?=
 =?utf-8?B?ZkRYZGlQczJEWnlFVG0xN25LZmNSVmJCL3dwaTBBdnc2Qm10Yjg1ZWtXZUNk?=
 =?utf-8?B?d0xHUWZ3anE5SUJMSzEraC8rQzF0V1ZQeDljY0FGZkVMQm1HRzF3Zmt4RTd3?=
 =?utf-8?B?OG55emxVSlJiQnpid3lVaVpMN3pTNUczVGIwd1dRR2lVdlJLczNEcDdpYUpO?=
 =?utf-8?B?RHlhdFNHRTI4RnJZemdPajRxTTRZeG5JZDZ4NmNTZVRNUEFQUFFidklKS016?=
 =?utf-8?B?eUJqWVhuZjg0MGQ5bksrWXdxZVcyc2RRT2ZpVGMyS2Y3bEZjQ2dQQXJwVmd5?=
 =?utf-8?B?d2ovYnNZc1pUYTY0SEdFSkx0ZkJtT0txS29iQXFQRGNpSEhjY3A3NXd6cURI?=
 =?utf-8?B?YUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7C9C18B3FE061418FFDA2F5C67F36B2@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAVPR03MB8946.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 170c55ab-fa2c-4a39-baef-08dd4f304085
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2025 08:51:21.5569 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YV2b+VqUPU4i/APXdFuiak6hReirbRZlMMUfXiWFZFvCc2juxmSUR1VjnghGuyDSzjE7sZTWIojUru+685g1jY3osvV8HxRTtmcDa7JSldE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9141
X-Mailman-Approved-At: Mon, 17 Feb 2025 14:28:17 +0100
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

SGkgVG9tLA0KDQoNCk9uIDA2LzAyLzIwMjUgMTg6NTQsIFRvbSBSaW5pIHdyb3RlOg0KPiBPbiBU
aHUsIEZlYiAwNiwgMjAyNSBhdCAwNDowNzo1M1BNICswMDAwLCBPbGVrc2lpIE1vaXNpZWlldiB3
cm90ZToNCj4+IEhpIFNpbW9uLA0KPj4NCj4+IFBsZWFzZSBzZWUgYmVsb3cuDQo+Pg0KPj4gT24g
MDYvMDIvMjAyNSAxNzo1OCwgU2ltb24gR2xhc3Mgd3JvdGU6DQo+Pj4gSGkgT2xla3NpaSwNCj4+
Pg0KPj4+IE9uIFRodSwgNiBGZWIgMjAyNSBhdCAwNTo0NiwgT2xla3NpaSBNb2lzaWVpZXYNCj4+
PiA8T2xla3NpaV9Nb2lzaWVpZXZAZXBhbS5jb20+IHdyb3RlOg0KPj4+PiBIaSBTaW1vbi4NCj4+
Pj4NCj4+Pj4gUGxlYXNlIHNlZSBiZWxvdy4NCj4+Pj4NCj4+Pj4gLS0gT2xlc2tpDQo+Pj4+DQo+
Pj4+IE9uIDA2LzAyLzIwMjUgMTQ6MzEsIFNpbW9uIEdsYXNzIHdyb3RlOg0KPj4+Pj4gSGkgT2xl
a3NpaSwNCj4+Pj4+DQo+Pj4+PiBPbiBXZWQsIDUgRmViIDIwMjUgYXQgMDM6MTUsIE9sZWtzaWkg
TW9pc2llaWV2DQo+Pj4+PiA8T2xla3NpaV9Nb2lzaWVpZXZAZXBhbS5jb20+IHdyb3RlOg0KPj4+
Pj4+IFRoaXMgcGF0Y2ggc2VyaWVzIHByb3ZpZGVzIGdlbmVyaWMgc3VwcG9ydCBmb3IgUmFzcGJl
cnJ5IFBJIDUgaW4NCj4+Pj4+PiBVLUJvb3Qgd2l0aCBhZGRpdGlvbmFsIGhhcmR3YXJlIGRyaXZl
cnMuDQo+Pj4+Pj4gVGhlIGZvbGxvd2luZyBmZWF0dXJlcyB3ZXJlIGltcGxlbWVudGVkOg0KPj4+
Pj4+IDEpIGFkZCBnZW5lcmljIGJvYXJkIGNvbmZpZyBmb3IgUmFzcGJlcnJ5IFBJNSBpbmNsdWRp
bmcgZGV2aWNlLXRyZWUNCj4+Pj4+PiBmaWxlczsNCj4+Pj4+PiAyKSBhZGQgc3VwcG9ydCBmb3Ig
UlAxIGNoaXAgd2l0aCBhZGRpdGlvbmFsIGhhcmR3YXJlOw0KPj4+Pj4+IDMpIGFkZCBzdXBwb3J0
IGZvciBycDEtY2xvY2sgZHJpdmVyIHdpdGggZHQtYmluZGluZ3MgdXBkYXRlOw0KPj4+Pj4+IDQp
IFBDSUUgQlJDTVNUQiBkcml2ZXIgc3VwcG9ydCBmb3IgUmFzcGJlcnJ5IFBJIDU7DQo+Pj4+Pj4g
NSkgYWRkIGNsb2NrL3Jlc2V0L2dwaW8gZHJpdmVyczsNCj4+Pj4+PiA2KSBhZGQgZXRoZXJuZXQg
c3VwcG9ydCBpbiB1LWJvb3QuDQo+Pj4+Pj4NCj4+Pj4+PiBUaGlzIHBhdGNoLXNlcmllcyBpbnRy
b2R1Y2luZyB0aGUgYmFzaWMgc2V0IG9mIHN1cHBvcnRlZCBkcml2ZXJzIGluDQo+Pj4+Pj4gVS1C
b290IHdoaWNoIGFsbG93cyB1c2luZyBzdWNoIGZlYXR1cmVzIGFzIHRmdHAgYW5kXG9yIE5GUy4N
Cj4+Pj4+PiBJJ3ZlIHBvc3RlZCB0aGlzIHBhdGNoIHNlcmllcyBhcyBSRkMgYmVjYXVzZSBvZiB0
aGUgZm9sbG93aW5nIGNvbW1pdDoNCj4+Pj4+PiBlNTFjYTBkMjIxIChIQUNLOiBkcml2ZXJzOiBt
ZmQ6IHNldCBiYXIgY29uZmlndXJhdGlvbiBmb3IgUlAxIGRyaXZlciwgMjAyNC0wNS0yMSkNCj4+
Pj4+IFdoZXJlIGlzIHRoYXQgY29tbWl0Pw0KPj4+PiBUaGlzIGNvbW1pdCBpcyBwYXJ0IG9mIHRo
ZSBwYXRjaCBzZXJpZXMuIEhlcmUgaXMgZGlyZWN0IGxpbms6DQo+Pj4+DQo+Pj4+IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL3UtYm9vdC9jb3Zlci4xNzM4NzQ5NzY0LmdpdC5vbGVrc2lpX21vaXNp
ZWlldkBlcGFtLmNvbS9ULyNtMjFjZjIzOTg5ZmIwOGNiNjU1ZTI1YjFhMmQwODI2MzJiNmY4NjVj
OQ0KPj4+Pg0KPj4+Pj4+IEl0IGluY2x1ZGVzIEhBQ0sgZm9yIHJwMSBkcml2ZXIgaW4gdS1ib290
LiBUaGlzIEhBQ0sgaXMgc2V0dGluZyBiYXINCj4+Pj4+PiBhZGRyZXNzIGluIHRoZSBjb3JyZWN0
IG9yZGVyIGJlY2F1c2UgUlAxIGRyaXZlciBpbiBMaW51eCBLZXJuZWwgcmVseSBvbg0KPj4+Pj4+
IHRoZSBwY2kgQkFSIGNvbmZpZ3VyYXRpb24gd2hpY2ggaW5pdGlhbGl6ZXMgQkFScyBiYXNlZCBv
biBCQVIgc2l6ZS4NCj4+Pj4+PiBUaGlzIHJlc3VsdHMgdGhlIExpbnV4IHNldCBCQVJzIGluIHRo
ZSBzYW1lIG9yZGVyIG9uIGVhY2ggYm9vdC4NCj4+Pj4+PiBVLWJvb3QgZG9lcyBpbml0aWFsaXph
dGlvbiB3aXRob3V0IGFueSBzb3J0aW5nIHNvIHRoZSBjb25maWd1cmF0aW9uDQo+Pj4+Pj4gbWF5
IGJlIGRpZmZlcmVudCBmcm9tIHRoZSBMaW51eCBrZXJuZWwuDQo+Pj4+Pj4gQkFSIGFkZHJlc3Mg
Y29uZmlndXJhdGlvbiBpcyBzZXQgdG8gbWF0Y2ggdGhlIExpbnV4IEtlcm5lbCBvcmRlcg0KPj4+
Pj4+IHRvIGF2b2lkIGZhaWxzIG9uIGFkZHJlc3MgdHJhbnNsYXRpb24uDQo+Pj4+Pj4NCj4+Pj4+
PiBUaGlzIHNob3VsZCBiZSBjaGFuZ2VkIGFmdGVyIHVwc3RyZWFtaW5nIFJQMSBkcml2ZXIgdG8g
dGhlIExpbnV4IGtlcm5lbA0KPj4+Pj4+IG1haW5saW5lLg0KPj4+Pj4+DQo+Pj4+Pj4gUHJvYmFi
bHkgc29tZWJvZHkgZnJvbSBSYXNwYmVycnkgd2lsbCBwb3N0IGFuIGFkdmlzZSBhYm91dCBob3cg
dGhpcw0KPj4+Pj4+IGNhbiBiZSBwcm9wZXJseSBkb25lLg0KPj4+Pj4gKzENCj4+Pj4+DQo+Pj4+
Pj4gVS1Cb290IHN1cHBvcnQgZm9yIFJhc3BiZXJyeSBQSSA1IHdhcyBhZGRlZCBpbiB0ZXJtcyBv
ZiB0aGUgZm9sbG93aW5nDQo+Pj4+Pj4gcHJvamVjdDogaHR0cHM6Ly9naXRodWIuY29tL3hlbi10
cm9vcHMvbWV0YS14dC1wcm9kLWRldmVsLXJwaTUNCj4+Pj4+PiBUaGlzIGlzIHhlbi1iYXNlZCBk
b20wbGVzcyBzeXN0ZW0gb24gdGhlIFJhc3BiZXJyeSBQSSA1IHdpdGggWmVwaHlyIGFzDQo+Pj4+
Pj4gQ29udHJvbCBEb21haW4gYW5kIExpbnV4IGlzIERyaXZlciBEb21haW4uDQo+Pj4+Pj4NCj4+
Pj4+PiBJdCBpcyBZb2N0by1iYXNlZCBzbyBpdCB3aWxsIGJlIGVhc3kgdG8gYnVpbGQgaXQgb24g
eW91ciBzaWRlLiBQbGVhc2UNCj4+Pj4+PiB2aXNpdCBsaW5rIGZvciB0aGUgZGV0YWlscy4NCj4+
Pj4+IEkgdHJpZWQgdG8gYXBwbHkgdGhpcyBidXQgSSBnZXQgYSBsb3Qgb2YgY29uZmxpY3RzLiBD
YW4geW91IHBsZWFzZQ0KPj4+Pj4gYWR2aXNlIHdoYXQgdHJlZSBpdCBpcyBiYXNlZCBvbj8NCj4+
Pj4gWW9jdG8gYnVpbGQgdXNpbmcgdGhlIGZvbGxvd2luZyByZXBvOg0KPj4+Pg0KPj4+PiBodHRw
czovL2dpdGh1Yi5jb20veGVuLXRyb29wcy91LWJvb3QvdHJlZS9ycGk1LTIwMjQuMDQteHQNCj4+
Pj4NCj4+Pj4gSXQgaXMgYmFzZWQgb24gdGhlIDctOCBtb250aCBvbGQgbWFzdGVyLiBJIGRpZG4n
dCBkbyBhbnkgcmViYXNlIG9uIHRoZQ0KPj4+PiB0b3AgYmVjYXVzZQ0KPj4+Pg0KPj4+PiBpdCdz
IHVuY2xlYXIgaWYgdGhlc2UgY2hhbmdlcyB3aWxsIGdvIHRvIHVwc3RyZWFtLg0KPj4+Pg0KPj4+
PiBTbyBJJ3ZlIHBvc3RlZCBSRkMgYmVmb3JlIG1ha2luZyBzaWduaWZpY2FudCBjaGFuZ2VzLg0K
Pj4+IElmIHRoZXNlIGFkZCBtb3JlIHN1cHBvcnQgZm9yIHJwaTUgeW91ciBwYXRjaGVzIHdvdWxk
IGRlZmluaXRlbHkgYmUgd2VsY29tZS4NCj4+DQo+PiBJZiBjb21tdW5pdHkgYWNjZXB0aW5nIGl0
IEkgd2lsbCBwcm9jZWVkIHdpdGggcmViYXNlIHRvIHRoZSBsYXRlc3QNCj4+IG1hc3RlciBhbmQg
cG9zdA0KPj4NCj4+IHYyLiBCdXQgdGhlcmUgYXJlIHN0aWxsIHF1ZXN0aW9ucyBhYm91dCAiSEFD
SyIgYW5kIHJlZ2FyZGluZyBkZXZpY2UtdHJlZQ0KPj4gYmluZGluZ3Mgd2hpY2gNCj4+DQo+PiBz
dGlsbCB3ZXJlbid0IHVwc3RyZWFtZWQgYnkgUmFzcGJlcnJ5IHRvIHRoZSBMaW51eCBrZXJuZWwu
IFNvIEknbSBhc2tpbmcNCj4+IHRoZSBjb21tdW5pdHkgaWYNCj4+DQo+PiBkdC1iaW5kaW5ncyB0
aGF0IGNvdWxkIGJlIGNvbXBsZXRlbHkgY2hhbmdlZCBpbiBmdXR1cmUgYXJlIGFjY2VwdGFibGUg
YXQNCj4+IGxlYXN0IGZvciBub3cuDQo+IFNvIGxvbmcgYXMgeW91J3JlIHdpbGxpbmcgdG8gdXBk
YXRlIHRoZSBiaW5kaW5ncyB3aGVuIHVwc3RyZWFtIFBpDQo+IHByb3Blcmx5IHVwc3RyZWFtcyB0
aGVtLCB5ZXMuIFRoYW5rcy4NCj4NCkkndmUgcmVhY2hlZCB0byB0aGUgUmFzcGJlcnJ5IHRlYW0u
IFRoZXkgYXJlIHdvcmtpbmcgb24gdXBzdHJlYW0uDQoNCkxpbms6aHR0cHM6Ly9mb3J1bXMucmFz
cGJlcnJ5cGkuY29tL3ZpZXd0b3BpYy5waHA/cD0yMjk0MTczI3AyMjk0MTczDQoNCi0tDQoNCk9s
ZWtzaWkNCg==
