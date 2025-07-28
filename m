Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3B2C87FCE
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 08:47:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 312CF831A4;
	Mon, 28 Jul 2025 10:46:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="VsnxBBwb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40A0082F00; Mon, 28 Jul 2025 08:56:58 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::60e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0A4082F14
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 08:56:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rXK/tdlkAtAcRohvvZn3sT6pOI6qXg9wG7GXc55EVoCASeBqMzDlD/HCKvBELxZBqpdsKGj3+NmlyZCcP0h2ZQblsmkFLNS1QVol189PdROoy0GGNRryeSvG55Cv+MNDu9LnFbwYeYMkUwUuL4h68cWY0DUonEf/plqZX+6GSJ/0shFBs5m5guLbzi2SKv5oDnaC2s1PrAv0Ay/6yYv+bylj7Kc/g3EQyypVPl7mcyy5c1L2g3MPrSH3FOvn8/miUk/PKZxtD9jNjv3lmt5CEEvBQIl2Ulq+1B1dMIvA6UeCFEecDKv2wBLTde6DxK5uAzWziDon92/Qa1Kc6bqn9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SojoK8zgHzq2SNMbmVcgdlKoETAD48vyEzp9iZm/AvI=;
 b=FvxJOq32RBtEizZll+sZaC5E73qN9acm1luthkgWdBgDSb6xuedPsEpjl8u0zgyU5JGCDjt3nSwGM4qdhbUDYff/Ab1w2mLsv4mW6S8WDrS24KU6ie/8jxCwndq+hUPqQDuOwUeqCSkYxFX5YhnpmltTBYaXcsVSVB2s7/D3szcKWK9EVmj29nMsCzC/NT+8poWWlbmJ2wkbWopBxjCfp7Cy3A0e8wCgnyviCY8X6t9pxrzLQGNIUVUr1wFtQKCe7uhETTFzz7hneel7KZSlvdbq7n7+88txMoGJr9Zx8R1XaOUIo8AP52ODRO7zPuSdaReqCPNr/uriiHEn8DvFOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SojoK8zgHzq2SNMbmVcgdlKoETAD48vyEzp9iZm/AvI=;
 b=VsnxBBwbMcCCydueldRVY+keOjCWQb5NaGyMXlrlLqd0m6XQs4FJFBtWpDnXq4Hhv9Vm07pioEfOpP6Bvt6tv5/7FK7/HN8NGeUA8ZOshrI3pEPJthprWR5bHQGhY/V61Dlg032XdU7pOXq/Aii1VzazjnpmyUSALZ9//SuYqHiJ+3Em1LccyjbKMMMhv/Hn0mS0MNpXexS86Tt7ub1gJBTygtH83rqbKICzSCImrzeGVRUWieaZerRnJceMTWdDiOlW9vXY2MrB0cCSEHg8zwJ9Uw5E9yxH+eiDoCLJNs0+fnUbRAGqIx+q7TE8EQFqazYyK7WSuOpjaoMdWcs6ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by DM4PR03MB6128.namprd03.prod.outlook.com (2603:10b6:5:397::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 06:56:53 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.8964.024; Mon, 28 Jul 2025
 06:56:53 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Heiko Schocher <hs@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>
Subject: [PATCH v7 04/12] drivers: Enabled Kconfig and Makefile for i3c support
Date: Mon, 28 Jul 2025 14:56:04 +0800
Message-Id: <20250728065612.6039-5-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250728065612.6039-1-dinesh.maniyam@altera.com>
References: <20250728065612.6039-1-dinesh.maniyam@altera.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0057.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::32) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|DM4PR03MB6128:EE_
X-MS-Office365-Filtering-Correlation-Id: ce5a3e41-ae07-40da-b053-08ddcda3ef24
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?em9pNlRpUjRDZDhrOFVjU0RXdFdsdExUYUZwVGVFc2J0c0JZa1BjRVA0Z2c5?=
 =?utf-8?B?aERsTFhROWJyTlNIS2FHWng0OEV3dTRZSVgzU1VleTZwNVBEblVFeDFxUm04?=
 =?utf-8?B?N0NvYUpLa1A0VG8wNTh6dVdwTVJrazVPVzNUeFVLa0dlZFdGNTBOZ0VjcmhZ?=
 =?utf-8?B?ZlNMcm93MHhIakd3MlZCOUIveHl2TldKV0Y4dHV6ZFZMUmErTXZ6R09kQlhG?=
 =?utf-8?B?UlZpaW80c0xjYkFEeHdQZi8yT0tJMmVMTTFVRjhpYjAwTXlIRkZnNUJBOEVL?=
 =?utf-8?B?blpLY2hzRk5TTEJhaWlhNXJmM1ZhOCt0Ui9IL3lWOGlzZldoMDhadXBsQzk4?=
 =?utf-8?B?VVlsY3dzR3BUb0JxYUxoeWRQNjk4cFEzeEdYbDNFVmNFb0FPcWs1VDF6aVNy?=
 =?utf-8?B?RllLZFFzMEVWSkF5MEdZVW5yWjNGOW0yTU9FOFMreUNjY2ErMTBVNi9LVGRG?=
 =?utf-8?B?dUxpVllQRHg1S0lEaCtaVDFxTFVYdnJmNlFMUzZpZE1JekJTNC9lM0Y4OS9Q?=
 =?utf-8?B?TXhtd3FCbllzdWprSnpsQmJOR01aNWR2Z3psYlNueUcyM0k4bnozcWFiL2dZ?=
 =?utf-8?B?WHVnSTdiRmI1WFJrYXA2cTRZOXVhZDluOHAzRHdVazJTZ0tKMzRRR3N1M3Bj?=
 =?utf-8?B?dnc0Y2ZhWlNmVEwrbzhTNGovSFdoTE5CcHVwWFMxbWZqb3FpVE51cTgwWkV5?=
 =?utf-8?B?ZngwMm9jU0VQNzF1OGJaVEIwUjFsZ1Z4czlUWStjTVhHZ0dzcnRSd2ZPcHp3?=
 =?utf-8?B?Y2MrUVZEVXpXZ09EaVRGbGFGUEZPdlNvTnlmYjRIOSs2alA5bnJYbHNSWEl5?=
 =?utf-8?B?VU5NZy9rZVIyQkt1QmcxeGpzUlRNRDdWTFdyTjBMeTVKSEVhYzc4QVJjckdK?=
 =?utf-8?B?NzRCbGRKNkhLOHlJM0ZUNHBIejZPTnVhSnd0UFpLRWdoRXpDdDJPQ0pLMDZy?=
 =?utf-8?B?cWZramhuZHZWaWJSRjdYbzdld0xNUmt2TFB0N0h4ckQ4b091bWZZOS9pNDdE?=
 =?utf-8?B?Ujhuc2dUQU5UM3pObTRVMUF1bDl1SzNsYWR1R0pMM3ZZYWUwS01XZUpvWHVE?=
 =?utf-8?B?aDdJTkJkRjhtU1VRNXlIY3A3N3k2Q0lLeUcwZFBoeU5zY1YyTldOS0VqakI4?=
 =?utf-8?B?cEJWa0NJN01QMnkxTkdWNS9rZlZRTHZlVU54ZlY4ZHNsYmFBVG1OVENNZ3Bw?=
 =?utf-8?B?ZHpoL3ZMVWtOZDg3KzZya0RjM2I4SS9Ca0VuclNEVjQ2QlZ2UWVyS3BWZ01J?=
 =?utf-8?B?UVBKVVNsWWhYNmo5MGhsOUo2TVRHYS9GeGNjN25YUE01eUFUVVlvM25saklT?=
 =?utf-8?B?K09pTTZkeERVNFpkd3dxVVoyOFNjZTdPazNqTFhsbDZabEM0SlluemNSSDhG?=
 =?utf-8?B?VWNsek1OcnFZS0hSUmovMnZjaVhLYTQrS2puclNMR1ZFYUJxRXhYTFFKQ2xM?=
 =?utf-8?B?UStXTEVlMHFOZHM2dHdld3RHaG5KN3V4V0pOUmw1eU1QUUZXM2RGU05oOVgv?=
 =?utf-8?B?bG12bzNiaStZalJLOGRkLzZMWm5nL2g5Wituc2ZDNlRkTEFxbXpaNXFhczZV?=
 =?utf-8?B?djdnNy9Xa0ZjTUhZMXV4MGp6Yk9TaUhlVzhwQUhIcGM4L3k3UUtMRzd4OUxh?=
 =?utf-8?B?WWYrVU9TZmhTRXBFbklxQXh3S21GWnhCNlJBUGtXNHUxQ0FwOWxOUWtJYWgw?=
 =?utf-8?B?QlpDelhONmxPQ0hURGxZczRXVk9CQkY3NFdPaTdQUXRuVlM3VDZQUE90bXpP?=
 =?utf-8?B?bFBCZHhaeG5Ldm91S2tNVUpMUjErMkRsUE5vL1NDYlUxV2U0L01Zd09EK3g2?=
 =?utf-8?Q?H3v8LuLc3QfFao1aOiwW5k++TxzbG84ODGLIs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1FITzBMM2ZtM0RZYTJtOG8wZHp5NTZpUDc2eVBETEtXNlpDMnMrdE5QNENo?=
 =?utf-8?B?MXVnajdLS0dwTzdjckEwb0ZpVUZWQytBSmFaUzAxZ0FNK1hZR3Q1bjMrR1h5?=
 =?utf-8?B?ZnM3bzhRaHgwRVh4K3FuaUdiTGVnc2Z5ZXd0WjJkR0tqSDVwY25DR2V0Ym5k?=
 =?utf-8?B?ZllVYjRDRHJHSS9CdTl3dWNwcHRQNHlFQXV1YUsrYXhQdzE1a0QzYWtzOTh0?=
 =?utf-8?B?NS81QnhUR0NLMzhRT0d2WVJQSUo0MUhiSER3QThRRVBSd1VhU0FuejJhYjhZ?=
 =?utf-8?B?QmQrMkhrK1pOZlJEZ2FQYVJCdEhvdk84L1MrTVlKKy9jTDdvQ2FNRnFSRmJI?=
 =?utf-8?B?bFJ0Q0FKT1Bwa2h1ekRBZVcwZEd6MFlNaEZQem12VTZ4YWRYaW9BREpLdGVo?=
 =?utf-8?B?cndHYWpIbFZJRkMwUkJjVWZUc21mMWdsUTJlbWkya0JKUEN1dENBd0hKY3BU?=
 =?utf-8?B?STNFTkZYcDE5MisvTWhrNnpXZVhHK2ZHSnpEMXVXbzEwMzlFdHlML2pDVXpw?=
 =?utf-8?B?RWZ3b1pXYjJQeDdhM1dEMUdQdjhFN2REYURUaXZZczBMdTVEWEpYdEJMYVdx?=
 =?utf-8?B?Ym9JOUtmZ1F1bldrcVF5L09MeENVLzlCVU5CTCtKUnZMOGFNTkhPcGZOOFNo?=
 =?utf-8?B?ZGtreXVna0dUOS85QjdhelRXV0doUmxIUmM2VnY4R3VoUXFsK0M4alRqZEs2?=
 =?utf-8?B?d0VkMi8za1lVRXJ2cUpESjVYRFZrV01LcmtDalVXcEphUDhQYWpUVG5DY0dJ?=
 =?utf-8?B?MU5yMkN4M3Ayb3o0aWZ1WS9wcThjbFdyclpvQUtnbHdrM1B4SERGR3VnQzQ5?=
 =?utf-8?B?UEExUHZJTWo4ay91VDU4QTJrMVV0Zjd3emtMY1ovVUJkZnQ4eThtVUhzVVU2?=
 =?utf-8?B?Z0RkSkdoZ0tXLzUrWktqZzNUNzVrWUZucjhiSjZOY0JsSlc4UCtUR1kzNXpq?=
 =?utf-8?B?RnVHZVB2ZnhoLzhwSFZlUUZVWE5uQVkwaUk5TVA5QWQ5QmJwWHJiZG1aZGhS?=
 =?utf-8?B?MUxQSzUwTUtUaUp6MW5pc3U1U093OURja0dNRHg2QmViS2ROZHJZVUtHc3c1?=
 =?utf-8?B?YmdrOWhTa0RENk5IeE5WZDQ4ZFJSdXdnVlRQRGxWdEV4TUVJTGo3eXppRlBS?=
 =?utf-8?B?V0ZEZHBjbDM1WUsvQXZsVVZTeFFqMjU2b2l1RTV0Qko3bnNDZFQ1eGRRVHVn?=
 =?utf-8?B?MjY2eTY4RmtlSHlWRUo2eFQxejFzZ0RSTmVRZU01MW5MMXJ3WjJtNkRBU2Qv?=
 =?utf-8?B?a0NJckJNcnBuL1lDRkV5Nmc0Qy9VRFRGRHBLTTE5dWFTaVIwQlNmVDJhVGlw?=
 =?utf-8?B?VTFOMmRsSmIva1dRV0xwL1lHeGFnK29jUXl4Ui8zamU4L0NzdVg0SGx3QzBo?=
 =?utf-8?B?eDIwa2tqbVFxbnBjRDF2TDFieXRDZUtvQ3k3VWF3bnJQZnZvNWNpdHdaNW9m?=
 =?utf-8?B?Y2pBZDUwMTRMd3hCbTh4TkhuSWVrOXd1Z3I5MFJ2RVN2MUNEcXVhVkQ1eVBh?=
 =?utf-8?B?S0lvRklOalRCSXk4NXNMR1NCVUE2MGo5UHNRckJtYUlEYWxabVF2bU9YUDFD?=
 =?utf-8?B?YzBDZGtwWG4xRElRQXNicUhPZUtpNVpTUUNqSHlmVnVMN3pncDA0V3BQK1oz?=
 =?utf-8?B?Tllmd3Rmd05ONTBtV3NBaHZYajBCVmo3MW5qWDB2Wmk4dWkyT0V6SGNEdWlI?=
 =?utf-8?B?L2cxR214T0xSMXNiWjNXQkFwKy9tS29jY0duVDFQREZNRmVDcWJHVGR1OFA3?=
 =?utf-8?B?cUlYTGx3bUoxTnltMDNlU3FhZGVyUDdFYmlUUElsczBMSU5kOVh2ZldlSnFh?=
 =?utf-8?B?Skt1RnY4USt2VVRITnF2QS9zTmNrWTZORWRra2E2TUlwN0FyQWxWa2swUGNr?=
 =?utf-8?B?MThlYmFBVkpDSThTTUFqcG9UZWVNMDBWYWdjMVJrRTBPSjJXL0pjS1I3Mllt?=
 =?utf-8?B?ai9uOEk4cnVFbTdXNlhnSThDQ2VER3pMSWJQT0YrYjU5Nk1WQnB3WXlBZ3Bj?=
 =?utf-8?B?TU9kT3ZhRWlFMmkxVkZMYWZjNS8yYTNiUitQOFVMU2RvY09hR21vdFRWTkhO?=
 =?utf-8?B?dXVXSjhxMWlQR1dMNWx3cUxScmlJcG5hUk8zTi8vUDZPeWlSWWNOOFQrK3Fu?=
 =?utf-8?B?VVpkNEc1MmQyeERZWHJzNXJERFp5eW1ZaUFkdUEvS1RVc3JmS05TY1EzY1JS?=
 =?utf-8?B?N1E9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5a3e41-ae07-40da-b053-08ddcda3ef24
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 06:56:53.4787 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7YrIIQ64cyhcHFyyrVE8RoppAn8jkx4rdAYYXS0xBnzsijMK5M8AzqmAtq/DCBge6tZeNRDE30xjKbRfEqE2dGK2VO7ZU0RHnrOrzAPZ8KQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6128
X-Mailman-Approved-At: Mon, 28 Jul 2025 10:46:50 +0200
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Add new i3c driver to U-Boot drivers.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 MAINTAINERS          |  7 +++++++
 drivers/Kconfig      |  2 ++
 drivers/Makefile     |  1 +
 drivers/i3c/Kconfig  | 16 ++++++++++++++++
 drivers/i3c/Makefile |  3 +++
 5 files changed, 29 insertions(+)
 create mode 100644 drivers/i3c/Kconfig
 create mode 100644 drivers/i3c/Makefile

diff --git a/MAINTAINERS b/MAINTAINERS
index 0315c606744..6dcc566eb72 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1230,6 +1230,13 @@ S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-i2c.git
 F:	drivers/i2c/
 
+I3C
+M:	Dinesh <dinesh.maniyam@altera.com>
+S:	Maintained
+T:	git https://source.denx.de/u-boot/u-boot.git
+F:	cmd/i3c.c
+F:	drivers/i3c/
+
 KWBIMAGE / KWBOOT TOOLS
 M:	Pali Rohár <pali@kernel.org>
 M:	Marek Behún <kabel@kernel.org>
diff --git a/drivers/Kconfig b/drivers/Kconfig
index a073230c26d..0b0c610e629 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -56,6 +56,8 @@ source "drivers/hwspinlock/Kconfig"
 
 source "drivers/i2c/Kconfig"
 
+source "drivers/i3c/Kconfig"
+
 source "drivers/input/Kconfig"
 
 source "drivers/iommu/Kconfig"
diff --git a/drivers/Makefile b/drivers/Makefile
index 0e1f58c515b..fd155835ab6 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_$(PHASE_)DRIVERS_MISC) += misc/
 obj-$(CONFIG_$(PHASE_)SYSRESET) += sysreset/
 obj-$(CONFIG_$(PHASE_)FIRMWARE) +=firmware/
 obj-$(CONFIG_$(PHASE_)I2C) += i2c/
+obj-$(CONFIG_$(PHASE_)I3C) += i3c/
 obj-$(CONFIG_$(PHASE_)INPUT) += input/
 obj-$(CONFIG_$(PHASE_)LED) += led/
 obj-$(CONFIG_$(PHASE_)MMC) += mmc/
diff --git a/drivers/i3c/Kconfig b/drivers/i3c/Kconfig
new file mode 100644
index 00000000000..fa68612787b
--- /dev/null
+++ b/drivers/i3c/Kconfig
@@ -0,0 +1,16 @@
+menuconfig I3C
+	tristate "I3C support"
+	select I2C
+	help
+	  I3C is a serial protocol standardized by the MIPI alliance.
+
+	  It's supposed to be backward compatible with I2C while providing
+	  support for high speed transfers and native interrupt support
+	  without the need for extra pins.
+
+	  The I3C protocol also standardizes the slave device types and is
+	  mainly designed to communicate with sensors.
+
+	  If you want I3C support, you should say Y here and also to the
+	  specific driver for your bus adapter(s) below.
+
diff --git a/drivers/i3c/Makefile b/drivers/i3c/Makefile
new file mode 100644
index 00000000000..5bb44a8d64f
--- /dev/null
+++ b/drivers/i3c/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-y				:= i3c-uclass.o device.o master.o
-- 
2.35.3

