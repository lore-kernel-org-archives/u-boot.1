Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C931C369D5
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 06:36:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20F4F82155;
	Thu, 24 Apr 2025 08:35:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lznGcDYo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 631698212B; Thu, 24 Apr 2025 08:35:03 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::60e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DE2E82045
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 08:34:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n2XbG0l0jLfoPEiRplrZ+MTvMr/JRnpY/a+BoE2GZ4afx+iinYepw/Ir+Q5bEN9M5vSyRbDANrhdIADrM2QQT1/KAsUUMoVeQ7q4anKlvaQuWYRL8Eie8SsEWMy4vVQV02JLGJn99L81pKXNxngCCU3m1Npw7tuKbCpKgWULSDEyScm0IlUUNyfCGdbgnn7QqCByflG8PMIrkuO3Sr7CI/eyq2VxuuY0/jTY6bHfi0plExvhe2dnnIqlDdvnm6yyUgN6mpEjvc8d+AkgDh7QpPz3ZjgYkKPf1aAaTpWK8KtSzcIRfG66nY+bBfeH8KiYRFm+WpwN4vu1xR3riySMHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7g0SWdObg8lVEGXhgGO4ZLxRvem+7sEIy5wQ7gxqngU=;
 b=OA8NT3mOivizNT5BjDrEdIOBFXTcjWeVXYY/G3z50HfM8z6BeZGFb/qMvXRjFRan6yxHk8tbu96PawAVVbO3KV6el4ZgLV1drf1/QIXNtqsvafBb7RlNXy0lulpTmI+NOTUWC1O3wdhL9EPXGmZkpOtO+XrgdopLJ9hc1Wngmq/2gdJix1KDRoWtlQvfZdxQnY7DOoUXfCxlEaLUXRxSbq7FCEY6CzA3ErmY6UKpPv6uaEu1fxzN3UHYQXqqMi3nZUmi31V6DBrkZRMhJISc6Ao0cFORR/U/eCis/JM8lbfV3qPRHeE2YjMoJY0MI2Ob+So5HGkJtoaKcZLZ9wybjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7g0SWdObg8lVEGXhgGO4ZLxRvem+7sEIy5wQ7gxqngU=;
 b=lznGcDYoE2Wo/3KAGqJMfBNbW3c84cIMi9/p4NfkZ5qS7WbTfjxXGSnFlVAXgge6HB8rNLUSreFNTWwed989b8FIT02Sbtby510cdpyIm4S5qrT67cwrhpdUxR38UKtFa9UiahMzcjbY2clVkVs/lYfTTr67oi9AtVM2eTQxEIZv3D0xdhxXMBLMeF5c9t5LU5VGbgrTxOdjB1xO1i6Ig4YodVdCyvKn+n8er/KTwNt/WASlRRf/HA8TaACRx5b3WbPtMvZ2va8xt3jHI68Q28CTCp4s+emk3MUfJgk5d0k1cu4kGG798GiTzIlF/rnk2qLv0X3c04ykPu22fLrndg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI0PR04MB10661.eurprd04.prod.outlook.com (2603:10a6:800:265::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 06:34:55 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 06:34:55 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Thu, 24 Apr 2025 14:33:12 +0800
Subject: [PATCH v10 16/21] binman: add a new entry type for packing DDR PHY
 firmware images
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-imx95-v1-16-10a8449b1e5e@oss.nxp.com>
References: <20250424-imx95-v1-0-10a8449b1e5e@oss.nxp.com>
In-Reply-To: <20250424-imx95-v1-0-10a8449b1e5e@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR01CA0140.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::20) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI0PR04MB10661:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b62087f-f816-4099-ffcf-08dd82fa2025
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dGtwMkRvQWRXdTFTbDF1TWN1OG5ZTUlQMlVZQzA0STlWRytidStGM1VNeUtS?=
 =?utf-8?B?TXVQanNPRUVJeFF5eEZYWVc5TEJNcXBzbDFhK2R2elUzQUFPbmxSUjJJSlE4?=
 =?utf-8?B?SnZWM2dxWlVnRW8xcEZDdUw5Q3VoQ1BDT3hmT01ndWljeHF0RjFpZjVvVzJU?=
 =?utf-8?B?aHUwQlVVL0krMnNlWnZCRnVWSDlsQXl0WG1IZnYza1dpemNvaU1MczFhL1pU?=
 =?utf-8?B?Y1lTd2xvU3BiRHFJb2F6bmZmSFhuYnRSOU05SW5vR3ZtWlA3bnhaMzN5TjhO?=
 =?utf-8?B?aTVIRXRUc3I0cEJtTm1TOG1JaUJQSjMzMmFGcHZrR1FlSmZzaTE5VWxEYzEv?=
 =?utf-8?B?MDFmNnh2WjdQZ05jd1hyRDRkS2kvV2FoNjNWL0txbmM1SWF0YXZ5czVtN0hL?=
 =?utf-8?B?dW1PU3lTNVp0eFNLQjBwWXFtK3dYWU5YY3BrZzNzTVR0VFA5VmFqd3FYZTJL?=
 =?utf-8?B?S3U5YzQwMFRpZHU2RiswNEpMZWRKSUwxanZ2Z0NXVTRFay9zbG5aeFhRRWIy?=
 =?utf-8?B?OVY1RVRIZVhvdEgrT3lXU0VFMzM3Zm5BcFIzRlJzTEFWQkNUSm0ycXEvb0Mw?=
 =?utf-8?B?U3JJeG54eUJLMUMzNnZkWHMvQ3hLZ0c2K1ZPKzJSWmFISFlCTzRMVGVpN291?=
 =?utf-8?B?aEcybXhFNExFa205MFNPcFNEWlhlZEYwZFV5d3NsRnpLcUgrYkdHNVVUQVRQ?=
 =?utf-8?B?MlhDUGZzSGZ4N0w4NkV4V3VIelBWbDRuT2xrMUJUZnVyM3JQMzVjN3VCMklT?=
 =?utf-8?B?UWtqQ012YjczSnBkcUNVLzE0WWc2OXEwcldYa284UTkveW5wRXBuZW5scDRI?=
 =?utf-8?B?MU5NNGJQNk9pS25qWjB3Ymh6c1A1T2NMZ3o5SDJ4aGtDTnloYnMxQXJHWWhj?=
 =?utf-8?B?OU5iNytGWXQvaWdna3FEK0lyekc5RkN4UlNZcGhqd2dNYUtvYkVqbXNhTmE4?=
 =?utf-8?B?MHNYMlF6VHlPRXcwZzhYNGpFbkthaGlXY2FpS0xQQUtUYWtGK2tCSUJxL2NG?=
 =?utf-8?B?M0haYmZLVDNxN3lrUGhQbFZrQlFaWmhsWHpXN1Y5T1lxYmRIa2Zod1lGRE91?=
 =?utf-8?B?YTloMFR0WVoyK1lpaDFFZWYvSTlpSDJ0NlFBeUJyT2ZsbE0xMDMydFJEUzl4?=
 =?utf-8?B?dUdKQjdWWDF6RTI4Y0lCTHNaSUhuQ2F6UFlOQkR5RHBoT2h0bGt3ZWJBbnRo?=
 =?utf-8?B?b3Y0MHdiTG5LQVYrTWovZWN5SlVHV2VUYVl0Nm9MRlRsc0VVSVpGZU4wMkpk?=
 =?utf-8?B?NnFrWVBqaFVkdlFHSWlIdXBkclpCTXhSQnFPZFVZN21EMFk2dU0vbUJnV0pR?=
 =?utf-8?B?MHlOa1hvWkJ0YzlSVUxibGZTTzF3YWl5bmFmMjRRdURmM1M2RU43dGhid3N2?=
 =?utf-8?B?VlFvbDFDdjZHTTFsYTRZYmxwNUlRK2hwM2RUL1JrbExEWC9wYlFiUHlwM1Bo?=
 =?utf-8?B?VWFsSGMzek9jcHF5Nmg2akpJOXpWS0Z4VVZNbEpQVDlCMFB5VjZHUzJPUVl2?=
 =?utf-8?B?Yk5uYUdiWFFXa2Z6YUJMbGtpMnVueVFnSkNkSHJoVlhUbXRKSncwUWlBb1ZT?=
 =?utf-8?B?UFZlNGxuenZjR3NGN2FNRDVQeUVCMm9IeTB2S3o5OEZhdUtSTkh2QUQxdy9i?=
 =?utf-8?B?OE04ZGlDUk45clVwMGJrVDIyMVI3RDJ5a1kvMUplcWZGeFVrSHQ3SldSNzlR?=
 =?utf-8?B?SHF4Wlp1V25RR0o4ak9kTjZ1QXhJQVh4MXpuVVJINld1WUY5bmIzSTlvR3dD?=
 =?utf-8?B?eWdiTXU3NE5EeisrWEhLR3pjblMrUS8wNllFWlZnSWNzSW8yT2RldXluM3JF?=
 =?utf-8?B?S2FxdE43dko5MlpBZ1FWQlA4ejh5bkRPOWIySlFtWWR6TzZ1RXBVY21DMWpL?=
 =?utf-8?B?UkxZTy9TMVB3T1FOQjVBcmEwczlRZ0twdFI5U0MxZVFpelFiVWtYVHhlakd0?=
 =?utf-8?B?cVBmMjBxZjJreFVnZmE5akRyRVRnVWZiRnEvTU9EODdJLzhqQ0pMeG9TZE91?=
 =?utf-8?B?WnZhMmIxOGhRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WForSEJNMVFDcXpCK2YzY1Y3TkVMcTJSZXVlU0V3Vk9qMEdPSEJxOFg0QkM4?=
 =?utf-8?B?amdFODE0d1dPMDByQ01DZHl2UmRiRmRQaHp5Sy9OWlB6ZUM5ODVCeDU2SVBS?=
 =?utf-8?B?V1RONDQxazc5a3phd0xxWjFoUExKcVdNdS9rdDZiR0xxQlpVN3JIL1ZwSndm?=
 =?utf-8?B?Zkk5T3hMWkFUd2lPT01FNnRPckhEd09GRFhkd2RGa2FnSENnSEx6YThKdGJS?=
 =?utf-8?B?OE5UVzYyQ0g4U0VjK0ZLSlkwMDdnMVpGQ0JqZWNqKzEwVE8yTHRseXd4TnZv?=
 =?utf-8?B?aDA3QzU5K3IvLysrRGE4L2JtdDhjanhqVUhSWGF4WDRmTWNvZ2k2dERuTVQ2?=
 =?utf-8?B?Z2tYTTRuWUpVbHdwb2N4czZGaTNvbkkvSGtrRGlzT040dGk1VW1LWnBGaHB5?=
 =?utf-8?B?ZnVaUHlVT21aVi9RWVdDTUhsZ25TQlF1cXNXSGE2SnRqcSt1WGVMeVZIVFR1?=
 =?utf-8?B?cElrN29IRkNtMUJvcEx6cmpudi9XZGFyYmVIRkRERG84T2RhT1dGaGQyWFpo?=
 =?utf-8?B?dk5ZWkcwWlV6UjIyaExRL2dqZTJkUlcxZE9iaFpLbHYwNk05UmpFSkJRTEox?=
 =?utf-8?B?NDkzQVlBb0JTM2JaYlJDWGZZVThIUHR4SjV5Y0prVmxQRXFIbVErRWlVMVlp?=
 =?utf-8?B?bTR6dExmVW1hSlNjSUxEbEFnVmJaSW5JaC9QRWk4dTA4THloanQrOFNTUGVw?=
 =?utf-8?B?bnlDMm91anJSenJteWVObDRqWjY1ZlZlRUlZWFVMRWo5MlR2VTBUbk92dnp4?=
 =?utf-8?B?ak15eEZLeUQzdk1YN2ZwRlNPTXluWG5TQmVRTVJyb3ErNjdjUVYySml2WmN5?=
 =?utf-8?B?d05vTkl5K3FNZm14WGViOWdHTUhHMUtzN2dObTc2SEVNbkVsZUFEKzRGVlg5?=
 =?utf-8?B?N28zaC9yQitjRnFLUjZ6LzloV1M5L3JVUnVYa0NVd2xZYlA0UW5yaGJkWmlq?=
 =?utf-8?B?YXB1ck02NmlOQkliWmJ1U3RxWXovamFyaFlqaVBndU8xajYyaDVLM1B5d29X?=
 =?utf-8?B?KzdGaDI2ZW5CWWFGU1RNSHZ5VytlUFRqNTVWMEo4SlBpeGpDZlF2MURhdFB3?=
 =?utf-8?B?MGh3Y0h4WWJpVDBaWHJJRkl4WkFIWjJGbnkzL2JLMkFPVG9PRlhETlQ4NXZR?=
 =?utf-8?B?QlBydjRpdkp3cU5vanJneTN4N0Jtb3V6R08xeFl4QjU2R1JlZXNCSlJmN1k2?=
 =?utf-8?B?bzVWTG4rZzlpSFNvVDV6YVNhOFhYVkRySkVUcjRZT1VDUFBFc1haQkRUWjYv?=
 =?utf-8?B?VHFUZ2QzdTYxUStxNzl3a3huNGY2QjBHaVpwNm1tenYvOUdIdWxqbzNxdmdt?=
 =?utf-8?B?TjNIckdsbnI3WlpvSHIyL0hSUC9vNXhPZURwMzJJWC9rN2NhbnJKdmdKMlBI?=
 =?utf-8?B?VWtXdm5wK1loSVhFc2MwODFsQnNESkNidmhQcHg5QlJxNjlZR3lVM2JwSFhW?=
 =?utf-8?B?Qjl4T3h5bDhSWUx5RlIxMzFvSVNxdkovbWlRM2FsdEhLTFd2eVBzNkt5Z0ln?=
 =?utf-8?B?ZjhVeWVPOGtHQ2dKZ2VzcU1TVzhRUjg4R2o4NXBRbmxVWFlqZkdUWTFLVkJy?=
 =?utf-8?B?NWtHakJpTkhMcnB4WUs4NW1JTGgrZWxuYk9uamFkbzBCNVR3bnVXaGw3RVBp?=
 =?utf-8?B?K1lidUU2UExtWVQ4QkhTSEttMlZ0NFNkV201ay80VEE0NVRXcU9vd2IreUVS?=
 =?utf-8?B?VFlBL0F4Z2hWSDZ6M2JjVzNTaEZvTzllTFN5bnBBSDJONEVIK2hTUnFPSVRy?=
 =?utf-8?B?WnBHaU1jUXUvVml5V3J5T1FWd0s1M1JaR2lyVm14V0VTejhST3JwLzhKeHJN?=
 =?utf-8?B?NWQreDFaVVVLekJ3RWcwVS9Ga1c5OS9BR3E1VFM3NXVDcmRHOEhUUVBIR2tT?=
 =?utf-8?B?eE9pT0p6NHEvSnc4QUorYTZTTmR3b1NpM1pWcGlQaWpzY0NtK0ZseGwwcm81?=
 =?utf-8?B?NGVPajdVdS82RTRFWWNnOWtyTjhzdVRrY0hCOXFWV21zV1ovYWJPVDRVencw?=
 =?utf-8?B?UXFacHh0bXRjYlVScGhGN2t3Q2JncXhTbWhrdHR1WEtyRVUwUFdkMkkrZFpN?=
 =?utf-8?B?NFFzWnBKbEJrV0lXK3B2REd1NUQxMkhMQ2l2a3BicDRBZU1GRVBuZklkN2Zm?=
 =?utf-8?Q?CSh9a9jpSBygWhv++etOI2b25?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b62087f-f816-4099-ffcf-08dd82fa2025
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 06:34:55.0838 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Un7gORanofcLXvx8ksWPYemamq5ZQHNFx++waEFZX+CBs75rRGPTjZtkmdZI7dd4yRUCaS2yOL0qwxyhusQCvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10661
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

From: Alice Guo <alice.guo@nxp.com>

i.MX95 needs to combine DDR PHY firmware images and their byte counts
together, so add a new entry type nxp-header-ddrfw for this requirement.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 tools/binman/entries.rst                  | 10 ++++++++++
 tools/binman/etype/nxp_header_ddrfw.py    | 29 +++++++++++++++++++++++++++++
 tools/binman/ftest.py                     | 11 +++++++++++
 tools/binman/test/346_nxp_ddrfw_imx95.dts | 24 ++++++++++++++++++++++++
 4 files changed, 74 insertions(+)

diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index 780e9817fb6..4f05aa0a323 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -1663,6 +1663,16 @@ Properties / Entry arguments:
 
 
 
+.. _etype_nxp_header_ddrfw:
+
+Entry: nxp-header-ddrfw: add a header to DDR PHY firmware images
+----------------------------------------------------------------
+
+This entry is used to combine DDR PHY firmware images and their byte counts
+together. See imx95_evk.rst for how to get DDR PHY Firmware Images.
+
+
+
 .. _etype_opensbi:
 
 Entry: opensbi: RISC-V OpenSBI fw_dynamic blob
diff --git a/tools/binman/etype/nxp_header_ddrfw.py b/tools/binman/etype/nxp_header_ddrfw.py
new file mode 100644
index 00000000000..655699e6ffa
--- /dev/null
+++ b/tools/binman/etype/nxp_header_ddrfw.py
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright 2025 NXP
+
+from binman.etype.section import Entry_section
+
+class Entry_nxp_header_ddrfw(Entry_section):
+    """Add a header to DDR PHY firmware images
+
+    This entry is used for i.MX95 to combine DDR PHY firmware images and their
+    byte counts together.
+
+    See imx95_evk.rst for how to get DDR PHY Firmware Images.
+    """
+
+    def __init__(self, section, etype, node):
+        super().__init__(section, etype, node)
+
+    def BuildSectionData(self, required):
+        section_data = bytearray()
+        header_data = bytearray()
+
+        for entry in self._entries.values():
+            entry_data = entry.GetData(required)
+
+            section_data += entry_data
+            header_data += entry.contents_size.to_bytes(4, 'little')
+
+        return header_data + section_data
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 92df2a03650..fa174900014 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -104,6 +104,8 @@ PRE_LOAD_VERSION      = 0x11223344.to_bytes(4, 'big')
 PRE_LOAD_HDR_SIZE     = 0x00001000.to_bytes(4, 'big')
 TI_BOARD_CONFIG_DATA  = b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
 TI_UNSECURE_DATA      = b'unsecuredata'
+IMX_LPDDR_IMEM_DATA   = b'qwertyuiop1234567890'
+IMX_LPDDR_DMEM_DATA   = b'asdfghjklzxcvbnm'
 
 # Subdirectory of the input dir to use to put test FDTs
 TEST_FDT_SUBDIR       = 'fdts'
@@ -202,6 +204,8 @@ class TestFunctional(unittest.TestCase):
         TestFunctional._MakeInputFile('fsp_m.bin', FSP_M_DATA)
         TestFunctional._MakeInputFile('fsp_s.bin', FSP_S_DATA)
         TestFunctional._MakeInputFile('fsp_t.bin', FSP_T_DATA)
+        TestFunctional._MakeInputFile('lpddr5_imem.bin', IMX_LPDDR_IMEM_DATA)
+        TestFunctional._MakeInputFile('lpddr5_dmem.bin', IMX_LPDDR_DMEM_DATA)
 
         cls._elf_testdir = os.path.join(cls._indir, 'elftest')
         elf_test.BuildElfTestFiles(cls._elf_testdir)
@@ -7848,6 +7852,13 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         """Test that binman can produce an iMX8 image"""
         self._DoTestFile('339_nxp_imx8.dts')
 
+    def testNxpHeaderDdrfw(self):
+        """Test that binman can add a header to DDR PHY firmware images"""
+        data = self._DoReadFile('346_nxp_ddrfw_imx95.dts')
+        self.assertEqual(len(IMX_LPDDR_IMEM_DATA).to_bytes(4, 'little') +
+                         len(IMX_LPDDR_DMEM_DATA).to_bytes(4, 'little') +
+                         IMX_LPDDR_IMEM_DATA + IMX_LPDDR_DMEM_DATA, data)
+
     def testFitSignSimple(self):
         """Test that image with FIT and signature nodes can be signed"""
         if not elf.ELF_TOOLS:
diff --git a/tools/binman/test/346_nxp_ddrfw_imx95.dts b/tools/binman/test/346_nxp_ddrfw_imx95.dts
new file mode 100644
index 00000000000..889f6f29860
--- /dev/null
+++ b/tools/binman/test/346_nxp_ddrfw_imx95.dts
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		imx-lpddr {
+			type = "nxp-header-ddrfw";
+
+			imx-lpddr-imem {
+				filename = "lpddr5_imem.bin";
+				type = "blob-ext";
+			};
+
+			imx-lpddr-dmem {
+				filename = "lpddr5_dmem.bin";
+				type = "blob-ext";
+			};
+		};
+	};
+};

-- 
2.43.0

