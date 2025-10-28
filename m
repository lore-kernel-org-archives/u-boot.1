Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F75ACCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 08:07:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5242783A47;
	Tue, 28 Oct 2025 09:05:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AOmBHE1/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9783683968; Tue, 28 Oct 2025 03:48:48 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7ACFE838F8
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 03:48:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bFtGF6EAkwhfHTWiwewGttzU0gXm2xywKpMEuhk2wG1WZNXqZNr3Affv6NLJtSPcPhaJaq3eeZNb2wMOMIh18iAK0pXqBEfzQ1Bx1jnwAO6dFa1QjTUN/SKKjzIYgYEpwscQ5ETp2xgNzzA2fkke6Xiv0MCp7ZLtapsHMbI7C9296/wGfcH6wF5aFO3/qhaesQbGbmP8LZq8KWoxkxrBjmivGzPNU4ubkBTPaWvoh6qEI7PeT3d6lnAieiJGepnaeHh0HbTFwDPks/HwwQsYY6fvzAhtdAzlGgOoDxAPF613Qc1MFKnqpP+Gp60anwGM5o2BEEKf190cIGdcgBpWOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxx/yXgr/0tVLQm/NgNnBZLu1mP6HEkRile7cpPTlxg=;
 b=mzIOQftwoqxpzUMg1RJctLQTkUyZG+t57n50o1ZTErjWboo1FfTUKNLgOxm+yo4Kl9xMk2sx5mirvOGZL+nK7ItAQk9m7ui/azHWzoPEDeZ0tGZnk1t+Xcny6J8Pw+mcWoNVXnJKvUhfW1Hw4wJGTTDXCBL9qD9eFlG9b54QXETxgUDqxORq3xlJ1EEanfJpAwF0obFBPUdVpUcPsUUlZlZ8tXgGSH+E7bxNQJrYbmaDEv5a3mhRI3Qh4iUVECMfaycHG5yguRJ5NFOKKD6NHYklcn7ukWYj5srJw5C8mHLaeyOWTJFMm+gEMOOygyiQfs4n3mbPhPQTH0+hauGeYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxx/yXgr/0tVLQm/NgNnBZLu1mP6HEkRile7cpPTlxg=;
 b=AOmBHE1/4mjifU30b09UNKBYZehwhKsM3Zbh7g3tCwaxQTYxKQhvZaBKIAdRkXtJxfPY7k7OiBlgpB89H0IkyPH42y09S8hdeWy3JALpaLOjXpc6+1jhKePblOPSnFL4Cy2gcsBBQLPZYzS+X6OV94Zm3TlINGoNcWDbNA5b/GY26az0NDaKLv0yMezi+ilMt/5a5/cwBWnAFaCnBdh2JNJ4+KtzHeMUd6PyMFnZAIX3zgSr2P/Mct52sJavNAK0iVjfcFVnjR1QJn5m+mDFsXVzdURO7mUn/3e+yQL9/yF26xYajLBEsvS79Xlte4GfeJF6jtkV8dpMbEwmyAR0uQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM8PR04MB7891.eurprd04.prod.outlook.com (2603:10a6:20b:237::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 28 Oct
 2025 02:48:44 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 02:48:44 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 28 Oct 2025 10:46:31 +0800
Subject: [PATCH v4 10/10] imx943_evk: Enable ENETC1 and ENETC2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-imx943-v1-10-955b8370c685@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 739a353a-7b93-4394-ad0d-08de15cc82a5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|366016|7416014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnNiUzBjRGZpTkFDc3J6RHZuVkRZM0pKZHVLWmZHN2lCMkRDRVFvWWZjMnZ0?=
 =?utf-8?B?blFheDEzN1lGUlVMRnk5N1VqUnNCejJUMGVWUmRwUWR1Q1JEV3lyQm1VQ3Br?=
 =?utf-8?B?WmVoYkIvNzNSbnVyVGZRcGNrcWxaZXBYYmM1eTRqZ3k1c2dCdkhYVkdKZmVu?=
 =?utf-8?B?c05WZ2VDRFZHcnJBb3JCOWlZZHYzVXc0eUQ2Uk5kdmFjZm0xTHI1TE11Wmh6?=
 =?utf-8?B?cGhId0ZKNW5zQWx6Z2hlSEVSZUp3VGZYSUdEdHVlczAxOTczUWJOdnZzNTJ5?=
 =?utf-8?B?STJMQ0c3TnJBK0NpT0NmK3h1aE1UWEFCMWNDWWJjQy9oNWFVVHRqKzViejM5?=
 =?utf-8?B?VWw2L0l2OWhseHBCMW5icTFCWXAyOVNXUU5KbzdxZTRLZVd4UWJINkJmK0NC?=
 =?utf-8?B?QjdqMnJuMjZHM3NHUEtXcW9pS1IveGNodjVveG4rQloyZkxRSjBLd25VYkFx?=
 =?utf-8?B?NUMwbzhVYS9VRWY5akJFV3lCTE02L3g2eHJUd1N5Sm9Uekl4bUFlNVQ0SEIw?=
 =?utf-8?B?clRRVGdOYkR4aVRlcitvVS9XaFhsZll2eWhnMVF2TksyZ01XMXp4U2ZZaDdj?=
 =?utf-8?B?bVlxOHRiUGNQdFBMclVub0d0TlNlSHJUTWY2Q01BYWs0a2xyaEF0NnhhUHRu?=
 =?utf-8?B?Z2JzSzBrZzNCdDFyRUM4YVdDSnpTQVZxUEdFeGw0OHdlMDdWdzl2WENMTWZI?=
 =?utf-8?B?Kys0V2YwRk9oV0pqYmE5SUFNclkwL1J2Um1GcVZnMitydmR0SlEwcExkZktp?=
 =?utf-8?B?V2N1OXVidkx2bDUwSXNxSktzYlFjeDJ3M0FBRVFjUnJWaHpvSVI3YWgxVlJF?=
 =?utf-8?B?KzBkMjBGQmJSTGoxSUtNYm5DeVRuUTRPY2tkK2RqTnpUaWd6UW5sRnp5Yjkr?=
 =?utf-8?B?TTB1OWZCNGcrOTZXWkh0Ym83S0FUODViY0pqb2pYNTU0QWs4VGs3VzJUcG9P?=
 =?utf-8?B?MFdtMnJka0ROSE92VG9GWEZzSG10U0tqM1MwdDNZdGpQaDBJOVZxNzNCc256?=
 =?utf-8?B?YXRwYnZuNUdVZlNZTFZBQzN4cXdsY0tucVBrWUhqeXdjcVdjYWdUajJ1ZjB4?=
 =?utf-8?B?MlMrcUxQajhoRmZXcVp5Zllvek9taEovbHNjY05XYXNlTmxhNjdZVkEyWURC?=
 =?utf-8?B?NVRiV3VkUkZibHRWVmZLcGJISm9NZTIwbFpKVThCSnc2MVhEcHd4UDZMOE9L?=
 =?utf-8?B?WGhHeXZPZ0dId1pDdlIvaUhpVDBnYVJHMGYxMHlPK0FyRHZyamJiVEZ6OXo3?=
 =?utf-8?B?WDZ5ZS95OWE4VExIVWw0aHZGUUdvVXlVZnZKbExGSnNwMnVKN1VUdVNUV3ZR?=
 =?utf-8?B?ejdHWHp6dGF0YTFrdzZHb25hUXBlbHJVc2xKZW5CZ0ZHS0Z4YmM2czFCSmMr?=
 =?utf-8?B?Q0Y1Q04yU1o0UEF1QWNNMHVUc3VVT0ZQcWJCdnoxelZaMXEzbmdjMml4dTZU?=
 =?utf-8?B?QVdRd2FmZTB4NFdIdkQraTluN3NQOExWVlJlWGkrL2t1YlNxSDBQYXRQZVJ4?=
 =?utf-8?B?bCsrNjVwM1FOaXI5cmNicXZWMGxLWlVlS3VqWE03MlJnZ2xWb1U4eVJmQTF4?=
 =?utf-8?B?aXJEbWFHdnNKSnRQanlCNTRoVFVlRUpvZWw0YUVNT2ZkL3NlOFBuSGZJSXFq?=
 =?utf-8?B?TkZJN3UveFV5WGVDS0ZiSjhiYVFxN3dTcGtMRGY2RWZjMVZ6WHNtSlZEK2Jo?=
 =?utf-8?B?b3FNYjBXSWVwVS81M1BRRWpvT3l3SlY4dDNvZFhVMTNraDY1M3QrY0QvQ2ZX?=
 =?utf-8?B?aE1WZ0Rkd0VlcUNEZ204d2FCL0VGcUlZaXdIMGUzOVVjL2h4MzRvUG42TXgr?=
 =?utf-8?B?Qmx6c2tpU212cG9qVTRWSEdsaVVtNGtlT3hNNWtYOFNDUzlIekVHWDE2Q0R4?=
 =?utf-8?B?d25NTVNWMzZpTjBENkoyc2d4bXp1bllYRGd5Sk1vRkdCTWZhOVBCOHpJSnlQ?=
 =?utf-8?B?aTBLVDdOUW51TGJ0MmtHYUlCdjd3T0pHckhwWHFsMTZYNlpMZ3FQSy85eEUv?=
 =?utf-8?B?Sk9oUGZPU2VMY2tSVTFPd1NVdUVZb0VaNDNYTUE3S2V5clB2RWxodWFVajYx?=
 =?utf-8?Q?wCa4ew?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(366016)(7416014)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RStlR0lPT1N2bytENVNjMCswSU85TmpJUTNtMmQrVDcvMHg3SDBYb1dIUjZS?=
 =?utf-8?B?MVNveGRvTWEzbjdXVTBTb2NFUEc3NXRZQzVLREM1QVVtT2tRV0JDK0xmMkkv?=
 =?utf-8?B?MmVsMkNIc3pVRXRObDFpOWRtLzh5T3cwd0dEeElJYlh3YmVkdGxlZzJGekMv?=
 =?utf-8?B?SkVQaUVOTFBzMjY1SUYwVkpmS0tOTnJ0V1FsUitoNXFDYXpXdHoxVUQwdkNL?=
 =?utf-8?B?Y2FhRjhtdnZyTzViZTBsbzRRWGVac2J6WEFGbWQxQVFOY3NMNnRpUTBSZUpo?=
 =?utf-8?B?VDVwYkZSQ3BhZThyU3FvdkhSR0djam9ZMHFoK3JqU3EwUWRkRHMxQ1AvL0tu?=
 =?utf-8?B?WjlsNzE2L1RLdDBYQVpkV0RoWnl6WVJMYTlzWHA1VXNYekJvenZVYk9hNG5C?=
 =?utf-8?B?Rmd6cVp1eTh4MGREQ2NEa3JPV2NkdFh5NEtMVUo4NFYxcE1OUGJEdmw4NDF0?=
 =?utf-8?B?Wm1YWEx2VkU2MytSYzcrNWxZVVBzWVpodW8yOWRFbWhnbDI3U1hrZ0hVSTVo?=
 =?utf-8?B?QjNsMVl5cGlwN3BaTkZ0U0RsaWdMVDZMNDhJSWVGOTNZOFFwRDFxd0V6bG1v?=
 =?utf-8?B?Z1BQVTRkU1NHeUp5NWkvdWU5c3FvM25WLzBvV0IyaXBsUE91cEF0eS9ubDRK?=
 =?utf-8?B?ZjFaKzM5UHVPcEZxMWs4YUdNN3FsNy9qRzNXTTVRZlhWbExCakxWalhFdTFw?=
 =?utf-8?B?aVJidnhrZlVEMUVZb2RYY0xHZHJKckhSVjlxZllWVDdiMnFDMTd4K1AvZWZK?=
 =?utf-8?B?MkhGUWEzMjdQVzVEUW85UWJzVGN5b1U3NWtZbkZJZ1BMMVFYL0RUekorNjZR?=
 =?utf-8?B?MHo5ZzZ1NStLcGVJOEY2Ni9tczI2UlZYVkZTa1g1UFBRakM3MDdmOXRkOGdE?=
 =?utf-8?B?Y21uZ2JEK2tSUzFuTk1OR2xPa2w5UDFaaVNtTnowNTRmSnJ0TzY1a0U4Q0NP?=
 =?utf-8?B?b3ZXZjVZU0VTOVdBTDlWcTdCNW0xdGQ3MGhZeU55UmdCOEF5eTNuSldZWTZI?=
 =?utf-8?B?a0JRTE1qQ2VpcUdzN3Vhd2JFTitlbEp4ekptM0JsdHlsbXJlZ3ppYVlmVVk4?=
 =?utf-8?B?ZjJnbkxxcXRMcVFJQXN5NDQ3WTdqU3hoRmU5ODEraXVKZVJHMHpia0ZnYVMr?=
 =?utf-8?B?UUVhb2VJNlFqMVBvQlk5bXNqSFR2WlZmOGFPUUhBT3RxY2dOZnFHYUcybmRT?=
 =?utf-8?B?UVp2K3pTWXFMaHUxY2JFWDlpelhIV2tnUHpQdWp2TjE5MEhFamMzUzlLV3No?=
 =?utf-8?B?Skd0WmlRQStXM3lrTDR1TEFIT3VKWkJIbDQ4SXdrNVlOY0pLVTlWRjU2M0xm?=
 =?utf-8?B?eEtZemcyM0JxejNyU2lPdTJZZnUrZlVkSWtyb0RQQWhCaDJSZzdjV3pWVEZR?=
 =?utf-8?B?Yk1MdDVYSE9RdFY0S0FGVmtVajBxa3BuN2N5ZmNqbGFuajFZY1daT3NNMGNa?=
 =?utf-8?B?NkR4RFpXZVVISGdvTXN1aGt2cGFSUjZsaCtOTXJrS1hiMFczKzAwbmtLazFn?=
 =?utf-8?B?dXk2ZjdXNDRKbDRmTlgxZm1wZ0w4RnJPekZkYmFMcSs1RzdxQk9KMEZhZ1dQ?=
 =?utf-8?B?RzhSYTVNZ0lJSWd3aG0xQStTMnQ5U3JtM3Vna2xLZmVvc1J6eXJGQUtCeUJq?=
 =?utf-8?B?b01UdlNJSTlxYWNyUTBsVUJITFJqb3EveHRTUmZCNmkzdUxXdTdpRFNsRVR3?=
 =?utf-8?B?UE55TEFvR0Qveit1bXM0dXY0d2g1U1IvaGFwbWZVQktmZG1RRDhHLzhjTTA1?=
 =?utf-8?B?U2twbHZTOUcvdjNGb0ZDSkVOb1dCTGRrNnFLTWc3SXlOYmNGd09xVlpFbFhk?=
 =?utf-8?B?d3VvZjF5b1BuMXU1d0ttR2JtMkZ4dHJ0aDlvK1UrMXFOa3hYdmNsbysrY2Ir?=
 =?utf-8?B?eElMV0diSTlPUGpiTzRma2c0RDB1bGU5cnVKTnhYOTAzanY0eGZDK3ZqT3VH?=
 =?utf-8?B?VEl1RkVYckJKVTYzYlVsVGlKbUY5Njc0S1FCSjRjWVBjcTFSV0JZSVNMUXdy?=
 =?utf-8?B?cW8wRFdEek5PcUg0RWtRbVBkVHN3b3FGR0FYWks5QUwwQWVjb016cWZmM2VX?=
 =?utf-8?B?REJzNTAvd2NpYUxkUlJ1bFp4WTgrTmFmaXBIQWlBU2NIWlNENnM1RXhTWnRi?=
 =?utf-8?Q?QuejACiYEAQnseUe4/pse7I8C?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 739a353a-7b93-4394-ad0d-08de15cc82a5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 02:48:44.4256 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T1VAIeSvdTv5IWD28OB1srtIlg+O205wOuM1JFxf4kdHeKTdPILZBEdvPmnDIzwQnLZyXTd8s5NiQwx9m4hwTQ==
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

From: Alice Guo <alice.guo@nxp.com>

With this patch, both ENETC1 and ENETC2 are functional on the i.MX943
EVK board and can be used for networking.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/imx943-evk-u-boot.dtsi | 149 ++++++++++++++++++++++++++++++++
 arch/arm/dts/imx943-u-boot.dtsi     | 166 ++++++++++++++++++++++++++++++++++++
 configs/imx943_evk_defconfig        |  13 +++
 3 files changed, 328 insertions(+)

diff --git a/arch/arm/dts/imx943-evk-u-boot.dtsi b/arch/arm/dts/imx943-evk-u-boot.dtsi
index 3995176f090..528b3b02a3f 100644
--- a/arch/arm/dts/imx943-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx943-evk-u-boot.dtsi
@@ -5,10 +5,109 @@
 
 #include "imx943-u-boot.dtsi"
 
+&enetc1 {
+	clocks = <&scmi_clk IMX94_CLK_MAC4>;
+	clock-names = "enet_ref_clk";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_eth3>;
+	phy-handle = <&ethphy5>;
+	phy-mode = "rgmii-id";
+	status = "okay";
+};
+
+&enetc2 {
+	clocks = <&scmi_clk IMX94_CLK_MAC5>;
+	clock-names = "enet_ref_clk";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_eth4>;
+	phy-handle = <&ethphy6>;
+	phy-mode = "rgmii-id";
+	status = "okay";
+};
+
+&lpi2c3 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpi2c3>;
+	status = "okay";
+
+	pca9548_i2c3: i2c-mux@77 {
+		compatible = "nxp,pca9548";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x77>;
+
+		i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+
+			pcal6416_i2c3_u171: gpio@21 {
+				compatible = "nxp,pcal6416";
+				reg = <0x21>;
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				ethphy2-on-hog {
+					gpio-hog;
+					gpios = <2 GPIO_ACTIVE_HIGH>;
+					output-high;
+				};
+
+				ethphy3-on-hog {
+					gpio-hog;
+					gpios = <3 GPIO_ACTIVE_HIGH>;
+					output-high;
+				};
+
+				ethphy4-on-hog {
+					gpio-hog;
+					gpios = <4 GPIO_ACTIVE_HIGH>;
+					output-high;
+				};
+
+				lvds-en-hog {
+					gpio-hog;
+					gpios = <9 GPIO_ACTIVE_HIGH>;
+					output-high;
+				};
+			};
+		};
+	};
+};
+
 &lpuart1 {
 	bootph-pre-ram;
 };
 
+&netc_blk_ctrl {
+	assigned-clocks = <&scmi_clk IMX94_CLK_MAC2>,
+			  <&scmi_clk IMX94_CLK_MAC4>,
+			  <&scmi_clk IMX94_CLK_MAC5>;
+	assigned-clock-parents = <&scmi_clk IMX94_CLK_SYSPLL1_PFD0>,
+				 <&scmi_clk IMX94_CLK_SYSPLL1_PFD0>,
+				 <&scmi_clk IMX94_CLK_SYSPLL1_PFD0>;
+	assigned-clock-rates = <250000000>, <250000000>, <250000000>;
+	status = "okay";
+};
+
+&netc_emdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_emdio>;
+	phy-supply = <&reg_gpy_en>;
+	status = "okay";
+
+	ethphy5: ethernet-phy@6 {
+		reg = <0x6>;
+		realtek,clkout-disable;
+	};
+
+	ethphy6: ethernet-phy@7 {
+		reg = <0x7>;
+		realtek,clkout-disable;
+	};
+};
+
 &reg_usdhc2_vmmc {
 	bootph-pre-ram;
 };
@@ -58,6 +157,56 @@
 	status = "disabled";
 };
 
+&scmi_iomuxc {
+	pinctrl_emdio: emdiogrp {
+		fsl,pins = <
+			IMX94_PAD_ETH4_MDC_GPIO1__NETC_EMDC		0x57e
+			IMX94_PAD_ETH4_MDIO_GPIO2__NETC_EMDIO		0x97e
+		>;
+	};
+
+	pinctrl_eth3: eth3grp {
+		fsl,pins = <
+			IMX94_PAD_ETH3_TXD3__NETC_PINMUX_ETH3_TXD3		0x57e
+			IMX94_PAD_ETH3_TXD2__NETC_PINMUX_ETH3_TXD2		0x57e
+			IMX94_PAD_ETH3_TXD1__NETC_PINMUX_ETH3_TXD1		0x57e
+			IMX94_PAD_ETH3_TXD0__NETC_PINMUX_ETH3_TXD0		0x57e
+			IMX94_PAD_ETH3_TX_CTL__NETC_PINMUX_ETH3_TX_CTL		0x57e
+			IMX94_PAD_ETH3_TX_CLK__NETC_PINMUX_ETH3_TX_CLK		0x5fe
+			IMX94_PAD_ETH3_RX_CTL__NETC_PINMUX_ETH3_RX_CTL		0x57e
+			IMX94_PAD_ETH3_RX_CLK__NETC_PINMUX_ETH3_RX_CLK		0x5fe
+			IMX94_PAD_ETH3_RXD0__NETC_PINMUX_ETH3_RXD0		0x57e
+			IMX94_PAD_ETH3_RXD1__NETC_PINMUX_ETH3_RXD1		0x57e
+			IMX94_PAD_ETH3_RXD2__NETC_PINMUX_ETH3_RXD2		0x57e
+			IMX94_PAD_ETH3_RXD3__NETC_PINMUX_ETH3_RXD3		0x57e
+		>;
+	};
+
+	pinctrl_eth4: eth4grp {
+		fsl,pins = <
+			IMX94_PAD_ETH4_TXD3__NETC_PINMUX_ETH4_TXD3		0x57e
+			IMX94_PAD_ETH4_TXD2__NETC_PINMUX_ETH4_TXD2		0x57e
+			IMX94_PAD_ETH4_TXD1__NETC_PINMUX_ETH4_TXD1		0x57e
+			IMX94_PAD_ETH4_TXD0__NETC_PINMUX_ETH4_TXD0		0x57e
+			IMX94_PAD_ETH4_TX_CTL__NETC_PINMUX_ETH4_TX_CTL		0x57e
+			IMX94_PAD_ETH4_TX_CLK__NETC_PINMUX_ETH4_TX_CLK		0x5fe
+			IMX94_PAD_ETH4_RX_CTL__NETC_PINMUX_ETH4_RX_CTL		0x57e
+			IMX94_PAD_ETH4_RX_CLK__NETC_PINMUX_ETH4_RX_CLK		0x5fe
+			IMX94_PAD_ETH4_RXD0__NETC_PINMUX_ETH4_RXD0		0x57e
+			IMX94_PAD_ETH4_RXD1__NETC_PINMUX_ETH4_RXD1		0x57e
+			IMX94_PAD_ETH4_RXD2__NETC_PINMUX_ETH4_RXD2		0x57e
+			IMX94_PAD_ETH4_RXD3__NETC_PINMUX_ETH4_RXD3		0x57e
+		>;
+	};
+
+	pinctrl_lpi2c3: lpi2c3grp {
+		fsl,pins = <
+			IMX94_PAD_GPIO_IO16__LPI2C3_SDA		0x40000b9e
+			IMX94_PAD_GPIO_IO17__LPI2C3_SCL		0x40000b9e
+		>;
+	};
+};
+
 &pinctrl_reg_usdhc2_vmmc {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/imx943-u-boot.dtsi b/arch/arm/dts/imx943-u-boot.dtsi
index 8c89b8be04b..2b93ba9a38b 100644
--- a/arch/arm/dts/imx943-u-boot.dtsi
+++ b/arch/arm/dts/imx943-u-boot.dtsi
@@ -84,6 +84,25 @@
 		};
 	};
 
+	reg_gpy_stby: regulator-gpy-stby {
+		compatible = "regulator-fixed";
+		regulator-name = "gpy-stby";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pcal6416_i2c3_u171 5 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_gpy_en: regulator-gpy-en {
+		compatible = "regulator-fixed";
+		regulator-name = "gpy-en";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&reg_gpy_stby>;
+		gpio = <&pcal6416_i2c3_u171 6 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	usbphynop: usbphynop {
 		compatible = "usb-nop-xceiv";
 		clocks = <&scmi_clk IMX94_CLK_HSIO>;
@@ -260,6 +279,153 @@
 		#index-cells = <1>;
 	};
 
+	netc_blk_ctrl: system-controller@4ceb0000 {
+		compatible = "nxp,imx94-netc-blk-ctrl";
+		reg = <0x0 0x4ceb0000 0x0 0x10000>,
+		      <0x0 0x4cec0000 0x0 0x10000>,
+		      <0x0 0x4c810000 0x0 0x7C>;
+		reg-names = "ierb", "prb", "netcmix";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		power-domains = <&scmi_devpd IMX94_PD_NETC>;
+		status = "disabled";
+
+		netc_bus0: pcie@4ca00000 {
+			compatible = "pci-host-ecam-generic";
+			reg = <0x0 0x4ca00000 0x0 0x100000>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			linux,pci-domain = <0>;
+			bus-range = <0x0 0x0>;
+				/* Switch BAR0 - non-prefetchable memory */
+			ranges = <0x02000000 0x0 0x4cc00000  0x0 0x4cc00000  0x0 0x80000
+				/* ENETC 3 and Timer 0 BAR0 - non-prefetchable memory */
+				0x02000000 0x0 0x4cd40000  0x0 0x4cd40000  0x0 0x60000
+				/* Switch and Timer 0 BAR2 - prefetchable memory */
+				0x42000000 0x0 0x4ce00000  0x0 0x4ce00000  0x0 0x20000
+				/* ENETC 3 VF0-2 BAR0 - non-prefetchable memory */
+				0x02000000 0x0 0x4ce50000  0x0 0x4ce50000  0x0 0x30000
+				/* ENETC 3 VF0-2 BAR2 - prefetchable memory */
+				0x42000000 0x0 0x4ce80000  0x0 0x4ce80000  0x0 0x30000>;
+
+			enetc3: ethernet@0,0 {
+				compatible = "pci1131,e110";
+				reg = <0x0 0 0 0 0>;
+				phy-mode = "internal";
+				status = "disabled";
+
+				fixed-link {
+					speed = <2500>;
+					full-duplex;
+					pause;
+				};
+			};
+
+			netc_timer0: ethernet@0,1 {
+				compatible = "pci1131,ee02";
+				reg = <0x100 0 0 0 0>;
+				status = "disabled";
+			};
+
+			netc_switch: ethernet-switch@0,2 {
+				compatible = "pci1131,eef2", "nxp,imx943-netc-switch";
+				reg = <0x200 0 0 0 0>;
+				status = "disabled";
+
+				netc_switch_ports: ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					/* External ports */
+					netc_switch_port0: port@0 {
+						reg = <0>;
+						status = "disabled";
+					};
+
+					netc_switch_port1: port@1 {
+						reg = <1>;
+						status = "disabled";
+					};
+
+					netc_switch_port2: port@2 {
+						reg = <2>;
+						status = "disabled";
+					};
+
+					/* Internal port, a.k.a management port */
+					netc_switch_port3: port@3 {
+						reg = <3>;
+						phy-mode = "internal";
+						ethernet = <&enetc3>;
+						status = "disabled";
+
+						fixed-link {
+							speed = <2500>;
+							full-duplex;
+							pause;
+						};
+					};
+				};
+			};
+		};
+
+		netc_bus1: pcie@4cb00000 {
+			compatible = "pci-host-ecam-generic";
+			reg = <0x0 0x4cb00000 0x0 0x100000>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			linux,pci-domain = <1>;
+			bus-range = <0x1 0x1>;
+				/* ENETC 0-2 BAR0 - non-prefetchable memory */
+			ranges = <0x02000000 0x0 0x4cC80000  0x0 0x4cc80000  0x0 0xc0000
+				/* Timer 1-2 and EMDIO BAR0 - non-prefetchable memory */
+				0x02000000 0x0 0x4cda0000  0x0 0x4cda0000  0x0 0x60000
+				/* Timer 1-2 and EMDIO BAR2 - prefetchable memory */
+				0x42000000 0x0 0x4ce20000  0x0 0x4ce20000  0x0 0x30000>;
+
+			enetc0: ethernet@0,0 {
+				compatible = "pci1131,e101";
+				reg = <0x10000 0 0 0 0>;
+				status = "disabled";
+			};
+
+			netc_timer1: ethernet@0,1 {
+				compatible = "pci1131,ee02";
+				reg = <0x10100 0 0 0 0>;
+				status = "disabled";
+			};
+
+			enetc1: ethernet@8,0 {
+				compatible = "pci1131,e101";
+				reg = <0x14000 0 0 0 0>;
+				status = "disabled";
+			};
+
+			enetc2: ethernet@10,0 {
+				compatible = "pci1131,e101";
+				reg = <0x18000 0 0 0 0>;
+				status = "disabled";
+			};
+
+			netc_timer2: ethernet@10,1 {
+				compatible = "pci1131,ee02";
+				reg = <0x18100 0 0 0 0>;
+				status = "disabled";
+			};
+
+			netc_emdio: mdio@18,0 {
+				compatible = "pci1131,ee00";
+				reg = <0x1c000 0 0 0 0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+		};
+	};
+
 	elemu1: mailbox@47530000 {
 		compatible = "fsl,imx93-mu-s4";
 		reg = <0x0 0x47530000 0x0 0x10000>;
diff --git a/configs/imx943_evk_defconfig b/configs/imx943_evk_defconfig
index e4fcf2eb576..39b616e266e 100644
--- a/configs/imx943_evk_defconfig
+++ b/configs/imx943_evk_defconfig
@@ -39,6 +39,7 @@ CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074
 CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_BOARD_LATE_INIT=y
+CONFIG_PCI_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x30000
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_LOAD_IMX_CONTAINER=y
@@ -83,6 +84,8 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SYS_RX_ETH_BUFFER=8
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
@@ -97,9 +100,19 @@ CONFIG_SPL_CLK_SCMI=y
 CONFIG_SPL_FIRMWARE=y
 # CONFIG_SCMI_AGENT_SMCCC is not set
 CONFIG_IMX_RGPIO2P=y
+CONFIG_DM_PCA953X=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_IMX_LPI2C=y
+CONFIG_I2C_MUX=y
+CONFIG_I2C_MUX_PCA954x=y
 CONFIG_IMX_MU_MBOX=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_FSL_USDHC=y
+CONFIG_PHYLIB=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_MDIO=y
+CONFIG_FSL_ENETC=y
+CONFIG_PCIE_ECAM_GENERIC=y
 CONFIG_SPL_PHY=y
 CONFIG_SPL_PHY_IMX8MQ_USB=y
 CONFIG_PINCTRL=y

-- 
2.43.0

