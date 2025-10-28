Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 282F7CCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 08:06:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9E0783A05;
	Tue, 28 Oct 2025 09:05:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="roSz0xZQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EFA783968; Tue, 28 Oct 2025 03:47:59 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27B28838F8
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 03:47:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nLUhP5Lq3J/VERfh+FfbsRy2T2KeCboA/5JSQVBXxeCo2BxdKOvf2b/+24+RDH5A+XgryDrGT+zELsL1EsNQv4seGdBgzd1h1kVv53cITkgy1LWH7M2Wo/ulDqhpIOsVOA7eXZnSMv0twAd+bkRFcEQ0MmZHQuIVnewi4eDcU1Be44xKOwSEJiY3buEwgq49VEY75mWxR2F1umjj8/dc7qHw/tyG9srZr8uoU1OUy2aDm7maYBG8jdpT3WDDETCrpRbIYxWBSjQ7U2CgpS07lP36RytpmchtNqB1GdqK+2wE4XpKRWHifXSWbwhkOI6BpjZlgovzE5Y2ptGElspmjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7ShLVoq5b15lkj5caz8iIku/YtOFWETGe8qYNSM0D8=;
 b=yeGGm5hZxABgaOlPnQIXAY5aydY7tT+AL1PnciaJtDxfcNa4mPQilxXHcNzb+DcsiKPTDcLBx+/ZNFVqV1MXcoqaD/NkQNEv0tPiI2xUN2ISq/uLRHf4izbbpCpVGe+Zm4MF1M/Jk/GiAzpjLBIg4NBD+3qic7WfzVGqlWX+xzaf4X1JUc44sITTy8w9KXSPTJ4HzUbE0Gby/Nx3HsKe+5YnHPdJBqj3PktdSZ6NyblMzjXmvTHxVaN+qZ29D5ZHVFt94E4q8OvCgzmI+dfi0YuaWMEhLukK7zuoLjLoFVfKjJdmGcRrOaXqgvzNaGaBoBk6GcY7x1//zwswysclxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7ShLVoq5b15lkj5caz8iIku/YtOFWETGe8qYNSM0D8=;
 b=roSz0xZQC5ym5+xleaGe9Jt7h6pPMRDueISTt6eMo3mWwCJ4xbeYbGcA7ykHoZ5KGR+crmHOVA0XkUt5LzhUa/QkvvW1jJrh1IQ149cWU3GouB1/rtWWr4Vt82mi8Fc+5sp/HbWxKNi/jtHVIedcY9FRLR0MzON9EPgTvWRJenSDCSS16QqLa5Pf/qpX7uSe6BgBAtZFEVapKF5VImco2RrP7sLEV4ZbLhyjvP9kZltqbHXz47ThW6j0CSVvNd859ju7AmsFmQ99H1hEiqHgxEMZn76Wz4huYMqeHz5PRzGUiW4Di1NvAeCuOAzrId1QYl9QXqc6V8w8rjZqecafng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM8PR04MB7891.eurprd04.prod.outlook.com (2603:10a6:20b:237::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 28 Oct
 2025 02:47:55 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 02:47:55 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 28 Oct 2025 10:46:25 +0800
Subject: [PATCH v4 04/10] Add serial# for SPL SDP download
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-imx943-v1-4-955b8370c685@nxp.com>
References: <20251028-imx943-v1-0-955b8370c685@nxp.com>
In-Reply-To: <20251028-imx943-v1-0-955b8370c685@nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Jindong Yue <jindong.yue@nxp.com>, 
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tim Harvey <tharvey@gateworks.com>, Frank Li <Frank.Li@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>, 
 Minkyu Kang <mk7.kang@samsung.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Roger Quadros <rogerq@kernel.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Yao Zi <ziyao@disroot.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR06CA0222.apcprd06.prod.outlook.com
 (2603:1096:4:68::30) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM8PR04MB7891:EE_
X-MS-Office365-Filtering-Correlation-Id: bb0a811c-583c-42df-8326-08de15cc656c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|366016|7416014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q01GUzJaM3NiV0IzUlRxK3MxQjFPcUh3WE1Ia0FFOVVqaG8zU1k5c3EyZ2hq?=
 =?utf-8?B?OFY1aGkvWThZMlVxYUdEN21ZZTA2NXN6dXZIdjlQZWpBNkwxSnhoSEdnYnBF?=
 =?utf-8?B?eTlrOVhvdjF2OUh2WjJzLzZsZ3VyS0tJL1RFS29DV0lqa2RNOE1ROHR5ZTFD?=
 =?utf-8?B?bWVUbXpMbnJHTDVMMVJRQjd4U2tGQ1JNSWl4NGU4Qy9jZ2Y3YlpQSnQ5ZHZi?=
 =?utf-8?B?V1A1QTdSZTk3c2p2MzRuUk1mU1B0WHdNcGJZQmZYS1BzUGZmU24wWWdHcytW?=
 =?utf-8?B?cktLL3VlUC9qUkV4VENKYk16UWpvQjBkMU5uZGE0c3pyanZUMTgyY2xFamhl?=
 =?utf-8?B?dWoxeUJ4TWlLSTBtdVNGcFFjdXQwYzQ1cSs1aTZNejB3aktCVWh0VmM1M2k3?=
 =?utf-8?B?dVJqNFdmSURYNXFWR2RyVkNMVnVOSXlJWmJCOGZrRGdHNnZaVjdoekdVeXRa?=
 =?utf-8?B?UitwOVdaT1FzOCtHVHd2ayt2clhRR2Y3YzRHbW12dkV3b2ZhSVBjM25Ra21v?=
 =?utf-8?B?eENmUmZKRnpzaWlXc2RTZEJmajBxeTFTbm9BbG9UWXJrZ0ExdjRnYjJOQTk0?=
 =?utf-8?B?UjV1K1NhN044Z21SYjlyMTZialZnTjJqYitwUlhFcVN0SEFFK2VXN1JCUHhw?=
 =?utf-8?B?U09iTGtyTmNwKzN6N2FMTDJtSnF1N1RheVZuUzhQZy81TXlNKy9lRUNEU0Qv?=
 =?utf-8?B?c0Y5RHBGMS9iK3pPVlNjK1NQTisva3V3UUc1UXBkQ0VXVlNDZ3Vja1RObGxj?=
 =?utf-8?B?WDBiRnhQenJWeWd6enNNamZxQURzZXp3K1JvTnB0cVE0dEcySkhxZzduamxL?=
 =?utf-8?B?VlhrbkFPU0NQaTRKRXlOVXEvcmRIK0Jsdk16NFl1SXhWMjJabzk2U0hqbzB6?=
 =?utf-8?B?UEZpMkRsbWNCMHc3OGY1cHorcUlVUzl0aDByYURqRm9xU0ZOVDZGcHE2aHMw?=
 =?utf-8?B?ZlRZd25RcDk1ZVhrWmNXTmhiVTR3V0RWNWVOTjNWcFlnQVZTTUhZT3R1YzFp?=
 =?utf-8?B?VVFiK3B1TmRVVGFwTVM0anFqeFU5OXpIWWN6a3pYSW5sSndSTnVzNnFMUnlB?=
 =?utf-8?B?ek5JTlliWmMxRjJZN2l3a3oxaldhVUFMMnFDMlVzTVBwQXVVMm55cHdieC9H?=
 =?utf-8?B?ZU5UbTJ3OFM4eVJoRHNNc2hUMlJ2ckphZHEyUXlldm5SRGErdWVqSFN6RFlo?=
 =?utf-8?B?RTRKVVNkRjBWTWVaVmU0ZFFIU21HN3FER3RZSm1mb2JnL2p0V2JoU1BkUTdV?=
 =?utf-8?B?R0R3SHZFNHVUaVZya3ppZXpqZ1FEczRoTjRRWnRSeVRkemlwR3QvbVlVd3Iw?=
 =?utf-8?B?SysyeGNLWERYTlNuaWxCN1pmakgzc2JNRUZPTGtlZEQ3OXB3SFFMUGYvcW50?=
 =?utf-8?B?aUt2RU85TkR6QkF3T1FlUUc5VC9WaXlWL0N4T3lQVThkd3Bacm1PTHcyWSs2?=
 =?utf-8?B?dmU5YVpqNlFHYS9sZ0FTK1Z5YlZxeERoN2I4MGxCQmE1V05kSEMyeHhra0NM?=
 =?utf-8?B?QnhOU2hVOFBVNUlJSUZ0dnFiZFgvWkJKRkc1M2wxTENtVjUwK05PZ1BISjJ6?=
 =?utf-8?B?V0didUN3M1Q5YW8xcThQb0NockkxaENkMUNDYkRadDQyeHIyQnUweVpqWEFz?=
 =?utf-8?B?ZXFJRmQ4OG1JaVNDbEQzYkR3dmUvcHcxV296UXMyY01UZllyVmRUcml1SFdr?=
 =?utf-8?B?Z00xYU5HWXdtMmdEV1JsT05TVUMzckhHMStJbnhESEgwOU9pa3dXbFgvM3Zj?=
 =?utf-8?B?WmR6S3hJVDcvdWRZYWdLYzBRcDZMUUFvVnY1aHhRL0J5aitIY3cwdUtLekMz?=
 =?utf-8?B?OG9NUjNwZzZyN1JoZWR5ZnRwSnkyd081aXVlT1R6cSs0ZjgvN2l0cndkQi92?=
 =?utf-8?B?OWZ5bjVPY1VPUUY1T2svcXBYY3lMOVdRVEEzN0kxWjlMczFMRlJud3dYVVFC?=
 =?utf-8?B?Q0c5bEkwZDZnWE5QajNSNzJNdlNORVZtWUEwN0hFaE5uT0xVdzJ3ZG5uMEtl?=
 =?utf-8?B?TkV1dFl0UEppOTdaWjFodlBHNkwxeXgzb282dWR2WDhTRVQ3cEFBdk5Sc28w?=
 =?utf-8?Q?vE5Yub?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(366016)(7416014)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnRNK3FXc09venBiNW9xSUtNdVZrWHh3eldzQ2VpVzg2U25PMFUybGk3RWhR?=
 =?utf-8?B?T3VEUkRobDJWbXpHOUh6bHdSbVMxSmh1MEo3ZkQwclBIOVJBem9tU05JWm85?=
 =?utf-8?B?SjQyN0syOUlzckV5NlRrYmFWaWR0dGZsdk50RnV2TVlNa3BkdVl4c3BPSkZk?=
 =?utf-8?B?ZFdvOHpKSHZBUXhlZmhSVkpXaWJBUVlWc2NSOGJDRXVjd01vcGduVGNZWTRa?=
 =?utf-8?B?bmRiQmc1WmxVMkZtRnNxaWJKekdMeTNpRHFibjZ4eDJYR2xYT1dVVW9FZ01F?=
 =?utf-8?B?OEFQWDI4Y3ZsYVk2YUpHRzh1VEVhbG9HdFBkam82K2pVVndSejlHWXNpNVpm?=
 =?utf-8?B?bFBRUW1pRTlGTjZkdkhoaTBxTkt5cWlnWnZoMTh1NnR4RzVObGpFR0RzNlpQ?=
 =?utf-8?B?UjIzVEo2ekFQanphNnkxcm5SUkExUXJ1Y3o1TU5zd1VENzV5S0UrREUrMkZw?=
 =?utf-8?B?bWI1QTg3NDYzRGlvdWFMN0dHNEx2cXdjS1pHQUZFc1J2N3pyTU1DRG1ycVV0?=
 =?utf-8?B?K0NnUjhWT0EvWVJNT2Vid3FYRGFieHRxL08wWFJuN2FxREwyVUhhSTZnejlh?=
 =?utf-8?B?d2NTSHZjWDZMbUtmRmRlaU1HbGlGVUs5OGpMbkNhZWFiM2psaHQ3STVrbGZ1?=
 =?utf-8?B?TWZrdXp1Z2JHZk9JdWNFeEczdjB4cUhMNGJ0VlMyRTlBbUU4ZFVGY2N1NzRD?=
 =?utf-8?B?S01MdGplQm0xVUxNdXRNVDgvdk5ubkFMUENtdlp1RzZ2Zy83UzFrZWNLclYx?=
 =?utf-8?B?VUxUYkpPL0hWQ1NOeUtMenkyT0ljYzdJZ29mdEtodWJCbzJ0OWU3VkJNdmJj?=
 =?utf-8?B?VEJXK2lBd0Rwd0NOUGZqRUlGdWt6eVZlUHRkQjdnWkpLam4wMjU1Ti96M1Bm?=
 =?utf-8?B?RjZmcDdRSnV5TGZSejhOVnJDRmgwU2N2RVE5QWFZeElTNkYyMDVJTXlEWkdm?=
 =?utf-8?B?dUdoSkZOYzVwQzNJRUJUVkJ6dUNPTDlQaUhRLys5VE5IOGpndzRnTVZaMUJm?=
 =?utf-8?B?UlpHWldkb21JTUU3dmFqZHJkNG9iZmdBdk5JRE1MVzloRitWbjZveVQ0Q3dq?=
 =?utf-8?B?bzhScVJkVWlhQ3d6dHQrUk1yOFRCQUNoVGJZNzhjVzdWSVdrcGt2Y2tHaUJV?=
 =?utf-8?B?UFBWS3I0b3lmU0QycTdTMGh5NWJDUVJUOHpuTE5jTTAvT3NoakQvc01UWWlD?=
 =?utf-8?B?OUlhYmJCNXpKQm5qays0T3QzS0FHdXYyTklsS3FiRkNMK2Z6RnB6WnN4KzVa?=
 =?utf-8?B?eEFoVkJtUnNmT3N4K21Ja3J3Q0NaMnRQdFhMazdOaGI0UEVaRTI5VjlTcmZE?=
 =?utf-8?B?WFBMWEg5Y2JrTi9GSVBrK21WYWE0cGZrbEg2MVBteWZKMlZReDBiMG9XdlQr?=
 =?utf-8?B?clFiUVNlZzY3bGYyQS8rMjdRSlFSem5tUjIxQWs1aWpoYlRFcFZFbmhOL2ZK?=
 =?utf-8?B?eGo0THlVMXFXdis0OThzc1dWRXZJOXM1aHlTdkN2cjE3QWdrZUZIOHY2MFBj?=
 =?utf-8?B?YVVKWmtxYmYrVFBBa1BIaWM4aWx6eHN4Y0dvSXQrNlFlYWlYRk1sbmtRbVBy?=
 =?utf-8?B?REpOMnVRYk5meTIya1BiakZqaU5HMzdnV1pGZEs5NDVUOVhrT2VMZG1hSUxw?=
 =?utf-8?B?a0x3ZGVOdE0rbW5YYUdhV2lVdEN4Z29jbGdXdEJPRS9vZE9FdTVWNExlZHlT?=
 =?utf-8?B?RU8vbThMT0QvMlVjU1BmbzNYUVhQOSt5eFRjaFBpbTJSSEo3R0NXSnphSEZ0?=
 =?utf-8?B?am5UMUxRcUpJejBXRjZqYkVNUWlsYWJDYmRpUUFqUU5iWXdPczhlcERQZUxw?=
 =?utf-8?B?bmx5WXE5NCtuTzYvY1RhVmlqNzUxb3l6MDgzM3l4NEhjUHovOURXZ2twQXFI?=
 =?utf-8?B?MzZjYVR6YkNvRE5kRmI1YXh5MzlWNTBZd0lZNHNYTGNoOGJ4dEcvSEw4ZDFN?=
 =?utf-8?B?dW0wUS9UQm80Vmhid29TQTEvQTU4VDhZTGVsR3dKdVhkTzREaHpYbWFHMHpu?=
 =?utf-8?B?bk8wZVplMGxZcnZqYThYKzZRM1Jnejh3NDVYUldja0VkQ2NvWS8yRDBTcTVr?=
 =?utf-8?B?S2dwRzlab1R6NEFuTVdOSmRZNkZva3FFZ2FvNDJJcWk2V0tMRkxsb0lsS21o?=
 =?utf-8?Q?MecafPrqdXwbn3GMVZkSieD4F?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb0a811c-583c-42df-8326-08de15cc656c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 02:47:55.4182 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gpfmzqtJfoWfa9FXSM+sESw1OPWUNfOcH6nHjaG/87vSaiBj4yJk6CifUaG5KZ2C4BuJTq91eDQ1yC8e7/ffOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7891
X-Mailman-Approved-At: Tue, 28 Oct 2025 09:05:24 +0100
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

From: Frank Li <Frank.Li@nxp.com>

After update this, uuu(>1.6) can use below command to filter out devices
when multi boards connected.

uuu -ms <serial#> ...
[sudo] uuu -lsusb can list known devices with serial# informaiton.

Serial number is retrieved via get_board_serial() and passed to
g_dnl_set_serialnumber(). This part is conditionally compiled for i.MX94
only now.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/mach-imx/spl.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-imx/spl.c b/arch/arm/mach-imx/spl.c
index 518d9cb1262..57ae81c7834 100644
--- a/arch/arm/mach-imx/spl.c
+++ b/arch/arm/mach-imx/spl.c
@@ -21,6 +21,8 @@
 #include <g_dnl.h>
 #include <linux/libfdt.h>
 #include <memalign.h>
+#include <asm/setup.h>
+#include <asm/bootm.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -184,6 +186,16 @@ u32 spl_boot_device(void)
 #ifdef CONFIG_SPL_USB_GADGET
 int g_dnl_bind_fixup(struct usb_device_descriptor *dev, const char *name)
 {
+#ifdef CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG
+#ifdef CONFIG_IMX94
+	struct tag_serialnr serialnr;
+	char serial_string[0x21] = {0};
+
+	get_board_serial(&serialnr);
+	snprintf(serial_string, sizeof(serial_string), "%08x%08x", serialnr.high, serialnr.low);
+	g_dnl_set_serialnumber(serial_string);
+#endif
+#endif
 	put_unaligned(CONFIG_USB_GADGET_PRODUCT_NUM + 0xfff, &dev->idProduct);
 
 	return 0;

-- 
2.43.0

