Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCBE9C83F27
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 07:19:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38C8F831E4;
	Wed, 16 Jul 2025 09:19:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="SBGbJjns";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6D7F8319A; Wed, 16 Jul 2025 09:08:58 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::620])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46414831A2
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 09:08:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DPKLC2P/WSvfXXPUBlEV1u4+3wnSo8pwK80vBB/CBMfgV/T2LYG1P5doms6Wb95HPR3dJYohLVsX7yBTbRUH5P/98cqtRkxZ3Pxr/BVJkBp2I0ij+KCN+zSEe4uXT3B2YnWvfu7NDXUb6m+RDRqe8PyXZDXbGWrW5FgPDB/pGSsrDvPq6Jvs8HRd5qmCjpvqroJIA+1z/gzx41NE7oRs9iSxxxbqZ2jHvUlA2w2cDi0NNsr8BBDrCxySQitusbfHQRV//nzIUcf1XaEbCUAUDAmTfKHFw/iuD4dw09SYyVRdgYl8jrPRrQIOpeI9irZCKl8Uvw6Dkp0NbyIEjMBO6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SojoK8zgHzq2SNMbmVcgdlKoETAD48vyEzp9iZm/AvI=;
 b=HDSAgPTlAemLu6sGfLsFLADdH7gAAKqN5LajZBwluEomJHHUK1BFDDwSbP5GjwwX8mIP1fJ70lrfDMHoE9sA/XtnTy+YtpQzzayXJfR37SrEEh1tMfKbVsdC3prRqO5gVqSwaiYjcCd9UsBgyyp4vVQBoSX4sPBQD2Fid3Hcs/cxCnXxiUCrjeyglkiosQAOI2B3sVJGrYgVYtUNJH+UL0g64chqi29A88yxMoz8feXVIgRX8ONvRIIJ3TTUx47LJ1/GOcHV7iPBf3Elvo+hHvyP40j6GwlTo/ghF/mMFSjBiABRj5qAqEfD1eCK2dALx2BX+QChsFA3rZiHncCPmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SojoK8zgHzq2SNMbmVcgdlKoETAD48vyEzp9iZm/AvI=;
 b=SBGbJjnsvHW12FUqjV1LmM9JPT4iDmwuTbxcA+/Q/IkMoKfqDAJ+x6SwjNehx8gDTBASxL3IqRduMTKhnkZXJCSqikJC32bBFc3kSmnT6Et4V4Y3rrZVODire9/Y5vyxiRFbey7lPKply//mSyE668e4VFy+meF0XP3u8l1uKyMwMfZnhxjr1DheoJ6Id5pVi85STPYpeGLac1bEY5ka/m/r6MQesMWGVWZSlRPlUV58PxwnTh70TgRfRiNanYoCBWKhw8O04wuFmbSq3Gzd3jX21LmFJ4NAEUJFoHyeVXnP8TYktA/MUmBycZIFufWdMxB6z9fXXeDm4AGQgFIZQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by PH7PR03MB7170.namprd03.prod.outlook.com (2603:10b6:510:241::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Wed, 16 Jul
 2025 07:08:53 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 07:08:53 +0000
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
Subject: [PATCH v6 04/12] drivers: Enabled Kconfig and Makefile for i3c support
Date: Wed, 16 Jul 2025 15:08:02 +0800
Message-Id: <20250716070810.8030-5-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250716070810.8030-1-dinesh.maniyam@altera.com>
References: <20250716070810.8030-1-dinesh.maniyam@altera.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR01CA0048.prod.exchangelabs.com (2603:10b6:a03:94::25)
 To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|PH7PR03MB7170:EE_
X-MS-Office365-Filtering-Correlation-Id: b7123d6b-7a80-438e-5567-08ddc4379f35
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UFE4VWZzUmVFT2V6T3pLUVdsOFNFVXdza3doUVV0SERkWTcwTzBqRC9LTm1t?=
 =?utf-8?B?RGs5aGNZandKd3BoSzZUb3hmeGJpR2RUWW9MZ2ljVHVCc1pyZkVKME16N3FM?=
 =?utf-8?B?TXdBdWdSWUZtNWhJS0tVV2pSR2Z3YXFOV2pjaEJ6Mzh0YXFham1qOGs4Z2pk?=
 =?utf-8?B?R1VsSXc1N2paOXpRZ1FET1FHemp5OC9FeW5FM3ROeEd4SkhYNUlOcmF3aUpv?=
 =?utf-8?B?UG5TQzRrTVhEYW9nL091aFFjbkk5bUsxcGtFWUtaSFVqaEFkSm96TjEvV2Vz?=
 =?utf-8?B?TytlK2NPR0JHRVY3UlN5K2JzS05rdTArQm5rdnBJYXZhd3drWXJGQTFFR1c3?=
 =?utf-8?B?Z3RXbDZMTTJ5Y05mdWtoelhYa3JFMFRydDFYQ2tjN3ZGTWZCc29pUjExZHdT?=
 =?utf-8?B?MTlUQ1JYQzdIdElXWnF4N1dIL3g4S2hmYk5JNm5oc243QllwTnc5OEFEUDZV?=
 =?utf-8?B?MCtTM2xBbzR4UXBrcVY0UkJiejVDRkhDdElVNUp3MVJhQTBPOHE5SEhzdWV3?=
 =?utf-8?B?NlNhdlpzbEpQRmFBZC9LbG9nQ0pSRnVSanh5TUdRdUdtc281dVF2UjV5WkRh?=
 =?utf-8?B?R28zMStOWFRuYTY4VlB0cGEwek9OR1A4dE4zeStHU3JvZmM1YnZ0M2dXaXBM?=
 =?utf-8?B?QTVEN2lmaUVPajFtV00wQ0k3RTl0T3UxQmNzWWx5SnN3TGU4T2dQQVF5TXIy?=
 =?utf-8?B?eVV5cXlNZitHa2d4d1Q5NkVkRFlQNS83c1M2bW1jM3lmYVQwdG9iQTB0L21m?=
 =?utf-8?B?aWZqUnJKRlkvblF2MTN3bTMyc3MxcUl3WnMzSlpSbjVSb0hVbzlNRkQ1bjJC?=
 =?utf-8?B?WklqUXV1dFU2QXcrZGNxZHNzVllXN25XVGhVa2lTdzQxdmtVVXFRQk5qR09J?=
 =?utf-8?B?V0JSL0hvSUsvOWorTU5CNlR2ZmlBZFpHekJyQWFNUFVaYzNmRm1ZYVpYV1Bq?=
 =?utf-8?B?SGJySCtCNE5mbnR5Y2ZpUzlGTHNrR2xESVFlVENyUWJBL3UzNVRJc3N1QkYw?=
 =?utf-8?B?Z3lmZW1wOU1vQWpRWGY1ZzY2cHVkL3gya05USkRZbUROSDVvTHpJZmhIT3Fq?=
 =?utf-8?B?Z1QyOXBNU1p3aGQ4L2ppMnUwOWYzbS84UlN6WGFDQ3pnR1owYloyQk9QT285?=
 =?utf-8?B?YmRBSkpudE0rQUpsSERNRldwSTdwckRRUjlISGlzeExwSzBkMUMyUk4wOUNF?=
 =?utf-8?B?UVMrVVUxMCtmd1huU0E2YVI4c2VhdTc3YUZBUHFiOXlXTHdjL08zeFU3NCtw?=
 =?utf-8?B?UW1FYnpTYjhxaHpGRU4zZTZZcThoOEUyeG90V2NlSTlnTHdsNStCaEs0RXV4?=
 =?utf-8?B?ajd6Qm4rTFFsZkJLd0tkM1BuQTVDMmRIZW9iazJUS0xOUElLNjJycTBmSEl3?=
 =?utf-8?B?VEx4MzZucEcwM1VwZHltcEU4dDZxUmYrcGt5NVFZYm85OHg3alFWSDF1dnRQ?=
 =?utf-8?B?REpxVndNcHNENlE3b1ZnY01BUWdBUVFaZ2taVEU0eE5ab2ZKeW1OZmZDbGFx?=
 =?utf-8?B?Q3owZ3lvSGF0clVyTDhqbkxkVFBvLzlsUXJPK0V6WnpDQ2dlRXRlNE81SzB2?=
 =?utf-8?B?U3NFY0xCVGZmZWJvMXAwR0ErbThkTzlDTmpVSkxsSndKY2VyVjMyd3d4OSs0?=
 =?utf-8?B?bW1GMDFvZmxQV2lzVlRZbjJJbnJKUzFtL1pwSFlJNW5WRE9DMmNMbUcvU2RI?=
 =?utf-8?B?UkxQbFZrU3BVNG9PWk45ci9kbzNjQm5yMVdLT3NPa2hmVEpuOTB1RHlnMTVl?=
 =?utf-8?B?VE9DM1cwS3FldEovMGo0RzYvMHpaZFl6NGE2dzhWcGR2aU9YeHhVWlQrSUZo?=
 =?utf-8?Q?gsd5FAS6Noi0lRnUrvm3Y3ybSrwOc9TvdHZqM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bU14Y3lzbHFMbHg3ZmJtZGxGKzJiUUpabTBpdlFreGtHTUowRW5iUzA2MXNl?=
 =?utf-8?B?eUFjbkI2WUNQa0NPbWNIWDg0SXdIaTZJbDIwL05vU2dBRCt4VWdWcEN4Qita?=
 =?utf-8?B?enhOOTZWVTlGNDBUT0lvQWtBY2RhRjBYcm9adEV6cUoySGg2MUh0Zm1ObzBs?=
 =?utf-8?B?MGx1Y0pTNktadVVPNEErcVZ4VDc0d0JhbUhtaHBEYVljY21CTWlnc2xST3p4?=
 =?utf-8?B?d0pOTERQRUU1MWc5cS9PSjFZWmU3VlpEVUZFc3dEK1hoNU8wK0paRUhGUC9J?=
 =?utf-8?B?VDBCYnFhc1M3MEpKNnVYbFBlcTh1cjFxN2FNL2NtSjE2WVo4cHY1U0UwZU1x?=
 =?utf-8?B?VTNFem9SeVNtREs3TDgyWENHanlMTkFaTTZxQ0czS0ZoNE1sOWwwSXhiNk8w?=
 =?utf-8?B?ZzdRZDR0UTlxSTcwSzhZUEdkcTI2ellhOCtOeXZkakJncVFBdDdhNnR3NEdM?=
 =?utf-8?B?bWRyMzdkQ202Y1Z1ZnNPYXVXVkt2Z25YQXF1WjRTUzhUek1uUjZUb0c4QVUy?=
 =?utf-8?B?dEV6MEQ3M1l1OHpHTE0yeGRab3NoZXNsalhXWTByaWxZRFVFU0hzUGNTbmhS?=
 =?utf-8?B?TzVON3EvRHR2Vk9EbjZZSXBvR1NwaEZtaGhiQUl0WFNZaVUrOVdLV29VVEtW?=
 =?utf-8?B?KzE0VU9BKzByVWcrWGJqMnNkbFV0QWh1aXBVRXZDdURuUHY0M3V4NEd6R015?=
 =?utf-8?B?aW9ZRUh2ZGQxN1pWcG4zOVJuaS9sMWorbTlnL0F5cGd3d3M4MFBjanJ4S3pp?=
 =?utf-8?B?SFVZY1BBSG5mVFNydkJOci9HcjQ1VnBHalpTTk1WWWhEajB4M1F3SGZtNzdo?=
 =?utf-8?B?M0VvSGgzUW9DSm9UTlZNSUZGQUEvQklTb3FYbEZqbGxXM0FmMm9idWFTczVG?=
 =?utf-8?B?VWs2K2pKVHprZ2dUaENXMkoyUmpNcnY5aER3RzA0Uis4N3cxRkNWaUV1ZzFx?=
 =?utf-8?B?ejQ5U2xiYVZiYUR0elFGM1p2LzFnbFVrRTZWdjJRT0JxZ3R6cExJUFFHTDR4?=
 =?utf-8?B?L0RmeVo1ZVp6L3VYT1krY3JBd3NDYU1seGlWSEEzaXpmSUJZSGprcHFQQVp1?=
 =?utf-8?B?QkJ2UllraEV6QXNJUEtXMzU1ZDlsN2xwdENLejFVQURjd09uSWFpYTk5VzlU?=
 =?utf-8?B?Mk5QeG93OVhiSzVsM1FReklIRlNOSk42ZWNDRThwekR6Q2YveWgyM3JDcmlp?=
 =?utf-8?B?amEyK0NJblVScDNXbUY2WUVKaDRON0tPdHFRWGdMN3phVTRpUmk2ZHBQZHdY?=
 =?utf-8?B?RVhjRGE2NHpack1CVVRMMnZWREdaTVVmKzBhN2NOM21Ha2NBQmZSQWRjNUhU?=
 =?utf-8?B?aDFTSm9YMFd6V0tlQWFlTGg0RzVzZEhxNFc3MUJTcFFjNzFNQ29MV1dFNUth?=
 =?utf-8?B?ekliKzkzK3NXVmtvNHZQV3Z2TjZQQ0kzNk9vT0pudFhTR0QrZElScmNBaE5C?=
 =?utf-8?B?aWNRR24rbzZLYjI0UnNWSG04Q0dSYzZJaXhBRFRDKzVublNqY0RQL2JBR0hl?=
 =?utf-8?B?VjNZYkVua01NellkMkswNDZ3Z3R1d2Y4aUs4dStCYzZPZ0VaN0FhSnMwbWxV?=
 =?utf-8?B?R1JpV0FrMnhEOVJnbFl1WlpWd29Ba2p5TFI3M0QwcmN4WEh0UnJ2RCt5emUx?=
 =?utf-8?B?MXluUVBsbFd5a1VPTDU4WVowUzhQcVFzeEV4Q0hNNHlCbTFKdWxla1ZpNzV5?=
 =?utf-8?B?MjVQWjNmUlh1SGozNVRuRnloQUpsaDNlU3o4N2NvSEpkRW5xcmpUSGJ5djBV?=
 =?utf-8?B?cjMwNnkxeVZhSHVPa1M2cGxnOUVDZ2hBRVVUMjJROS9QQnlITEZjMzc1ejlx?=
 =?utf-8?B?R1Z4NldYSlg3bTExZkxUcHpqMHlTYzFlVjNsQmEzV1lXWW1ZZWMxV0ZreGdS?=
 =?utf-8?B?RGlCTzFRWG9sUzBLWWNNUGpicjA1bXVZbUQ5K3l2eVg1NDdFNjlBdzVOVlRt?=
 =?utf-8?B?b21iSHl3QmU0VzdRMm9nYjdGaXZ6aSs5RG5aRzF5VUlSTjJIYnF3cm9heCsv?=
 =?utf-8?B?d3FDMjRlS21JNWhoQVVLYWV1QnZVcDYzUkdFSmt2QjBEMVdrOHh6aUFIN0RZ?=
 =?utf-8?B?TkdGcnpoVHBicU93bmRoK2paekxDNnFWM0U5dm0ySEY3TWRnZDVwU3JQdGc2?=
 =?utf-8?B?b2d0WE9meGRIR1VSSUtjOFZ4dzNtckc4VmFMQ3ZyV1FSd1l2L3JCdUQ5aGJO?=
 =?utf-8?B?TEE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7123d6b-7a80-438e-5567-08ddc4379f35
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:08:53.3020 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bg9vc99pib2dBjed1QdCMJqKjJ+kdCOhgBy2SiM4+YKwd3BaTUepUS70B5QFRW4XkpAcW2qIPEixPdMAgNme/ttJlrJT3IsGwW5ZrG+jEFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7170
X-Mailman-Approved-At: Wed, 16 Jul 2025 09:18:59 +0200
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

