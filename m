Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BAD8CCD184
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 18:07:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA90C83A5B;
	Sat, 11 Oct 2025 20:07:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="I96Qq/Se";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B12C083E52; Sat, 11 Oct 2025 11:08:24 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC56E83CF5
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 11:08:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=klCK3VxZ4haZsyZ808noQDPQHaWjX0evzcjW+sIMZKR0e67WgzC20hxMufKcfSokEvHu8tLQVm+AKQ4sSYszk/Sb68Fci8i4v+i7+5QYsLTD6qoETzh5qwwRI7zTmPMXmjD4bUVGMRb6y2TKkvgapPWip9UC96BGqhfqDBrdF/mCfGbCsQcriY1itgHRUi4wa4DgZ2S/mTkgSOk7S5iWu0r5GfHSgX2EcyhAcuwU8D0ysd0DXDuE1G9kVsCagrjHnrND9hvEVbUO53kLiOeV12JH6JWQ7T0ryRj9JXsR/HBKTN5LKF4QaK+xbiMxxtZ0mCNOi4xsbGRieeeOgRVqxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDyX/zZCbWg9p2ogqNxi043zT0ItK46TLhSHN5zLhN8=;
 b=sMy5O3kUsj/TnfWaZkTdeVg73U08VzdqzOE0TtBs6xgiw2DJGbrI0wUinF5j8FydF1Rv+GviknEgX9MBCeTPApMheFzPF8PTwy1lgg/d8fLgqEnus0EW9ahaXfWM02gHWyst4BFh4kIlVK0nVcQsrWuxrPXAMF+MMQ5m4xOcCIZPHk9UjTXG7rBbGqQhC0joFFZ6e788eqS34oo7A9lM4SbKKiR6fvyvujUC9tm0FKFNd49lYL1OjDiO0SHUrrrQ8bToySkAWrI+hVsalOiVtGDranhgy3pVO0R9xBWhy/HasJ9dMnboXKePcy7BL5jjeq1ve6v3ru8UZhr1qjrTxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDyX/zZCbWg9p2ogqNxi043zT0ItK46TLhSHN5zLhN8=;
 b=I96Qq/SeboM4QoPYCwOvDejNk/YyZkA23UYVvbzxTzYDZmShbXU20prwTx0jnGbSR1hfRmuJv05mVC5sDuY6XpKdjVkT62eVqBXTAwOA2N78izzIkO955sNYj6k/8yBPbiKa1Zg8+g47SMjqin0TBu6U1VJ6cgUrKbjBgVaOIzGAaMlsypJ0CqNnFi2kG6ZhmQ8+BLhp70pi5gzp880eKX1+GSzUoJriOqIr+toiMS3hA52z1K8Ekf4+PIxe44wEYV53ZKHqG4McHWNwI4yFdP3vCupSsu5wb8u5c3ZQWcWaWxqRz6YnXuy+OzpIAysUzpQu/MYFDqYx4+rzWR5mGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU6PR04MB11160.eurprd04.prod.outlook.com (2603:10a6:10:5c3::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Sat, 11 Oct
 2025 09:08:21 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9203.007; Sat, 11 Oct 2025
 09:08:21 +0000
From: Alice Guo <alice.guo@nxp.com>
Subject: [PATCH v2 00/10] Enable USB and ENETC on i.MX943 EVK
Date: Sat, 11 Oct 2025 17:07:47 +0800
Message-Id: <20251011-imx943-v1-0-313444548ab3@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGMe6mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA0ND3czcCksTY10Dc3NDg9QUs+Q0MwMloOKCotS0zAqwQdFKZUZKsbW
 1ACnVeq1cAAAA
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 marek.vasut@mailbox.org
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Alice Guo <alice.guo@nxp.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>, Jindong Yue <jindong.yue@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Minkyu Kang <mk7.kang@samsung.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Roger Quadros <rogerq@kernel.org>, Tim Harvey <tharvey@gateworks.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Hanyuan Zhao <hanyuan-z@qq.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0012.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::8) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU6PR04MB11160:EE_
X-MS-Office365-Filtering-Correlation-Id: 874db774-ad06-4440-f676-08de08a5b990
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NUo1YlJtbHo3cXo3dXJ1UEZ2WkJ5VXJtR2JFdFhSVUhTNmxqeHlFVjlNcWdm?=
 =?utf-8?B?MHBUdnFoT3hJMFVaUGVXUUptUnFSSFhKTWlicFFUNFpVVjJyYlMwK0NpSkc1?=
 =?utf-8?B?QnRFSVpBeDZ0OCtSVzFnL2tqLzNyUFJsUnNPY2huZDBhVTZXUnZiM3B1ekF4?=
 =?utf-8?B?MWIvNkZvdjFEWFFER2xsbUZROENwZ1M5bFE4RGxtYSt0RXBCRmlIdkV1Ynhn?=
 =?utf-8?B?aEVCVWJDRTRrK1lrcHNlZGhWQ0V4RjhqLzZiM2FZZGw1WWg4RVA5U2dnWXdh?=
 =?utf-8?B?WExMWVRJYUxUcGdVc0Y0OStYWWxpSXJFZG5HSHBMQUpUaDVSanBvMTUzcnNS?=
 =?utf-8?B?VE5KMktjZkJ5dTllR2pDc0IxZ0NMRVJyNVJabU50OVlPbHlaNWNrb3lPcnBF?=
 =?utf-8?B?QmY5RzR4SytzdVZOZ0hFNGlxTGcvTmF5RXcyaWRQWHp4NzRWZTQzV0JjTWx4?=
 =?utf-8?B?YVY5TzNjZVhBam9QNWRQVGMveW1jMkZJVklldVdVSnFhWkJtSGF1UWVNdXAv?=
 =?utf-8?B?LytVM2gxV01ySlA0a3ZJSFA0b3RXZDJwQWx5KzVKUkhpdTgwTDJYOHJhRTN1?=
 =?utf-8?B?WU9mVmNobnNFRTBxbVZxWjREREFzc0FsYllMTTdtVW1obDVNRnA3RS9oQlhN?=
 =?utf-8?B?N3lSZ1NLelJDcXZyeFVFK08rQnBGbEliUGZyTzFxd3J0YmczMmdWTmtHK0ti?=
 =?utf-8?B?TUJjTk1KeVhtNFRzRTJ2UDlnZ2xKdDNYdk1mczRaTzhyZStLdDNab2xITUJQ?=
 =?utf-8?B?QTluQ1FXVGR5dStVQm9uYXNmZzdmSXpuSWxLaFFPZUVLT3FNRTIyT2MwbFZt?=
 =?utf-8?B?aDkxcXc1VkRNVU9YVkFuN1NLMFJGcDVTaTRsQkEzTm5nRy9NeUhFZjJHcVA4?=
 =?utf-8?B?Q3I3UHVodGRhSDloOGJqNDBFVXpNRXVkTVhKQWFrU2NyNkpyajQxVmhFRWcx?=
 =?utf-8?B?SkpVSGl0a2Q1dGpZeWE2cVg0MkFnSEVjUHJrT2tLOER1c0pGdWJYcDcvWHpr?=
 =?utf-8?B?Umc2ZVBIQ01vVGF5bzRwZldiY1JWREZYcDgrWDZQK2RhandiTjd4QjYyRHVK?=
 =?utf-8?B?MDNULzJkNVhsL2x2bStxME9md2VtMklZMnowaXYreFhXdEozZ0ZETDlCSERR?=
 =?utf-8?B?TTRCVWtlU2lxbDFJS2pZMUx3TzNEemc4YmlQc0VTc3FUSkFxYmlQdWRUQUtU?=
 =?utf-8?B?VU40N0ZMdWIzTnF2c09HQW1ZS3NYNmRRU1c4SlBkN0pZN2NXYzlJY3hYZ3Bv?=
 =?utf-8?B?bkVSNXRhYmZabkZ6YVpNM2lGSW9Kb0R2aUd3Z2xVWEhmaXlPSWxrLzh4VUZY?=
 =?utf-8?B?Njh5MGcwWnZwTjVUTjA2OWZJUlVUUGQ1a3AwbXJMNElaaVFOaXg2Y1IraUFL?=
 =?utf-8?B?OEo4R3h2Y1NXb3d5dUh2b1ZQY3BnczVZSnluc1FnaTVDRzBuLy9ZM0YrcEZO?=
 =?utf-8?B?SUhwRjNvdUFMalZNTFpoeWtqYm8rUFZqL3JZTnluSDlKYmdkZUM2L2VyYWRh?=
 =?utf-8?B?WU1DM0NIclc3eVhPbHl2RHlwRkE1djMwc1hBRDJtTW9oNStPRVVrUG53V0dn?=
 =?utf-8?B?eTZEZmwwTGZnVkFubXhkUVlmLzBQMzBidkFZSHBzNDVnVlY3Y2EyMDlHVXBF?=
 =?utf-8?B?aDRBQ3NvYzltd3JETVJYY0dhNVRrQkRlL2x3NVVacVNVcWF5NWEzUG1VYnF1?=
 =?utf-8?B?N2NLYS8vU3BzRUxNeGl5VU1pd0NhTFNHcnNPYU1JQUliNjJXOS9RRzFKeEVq?=
 =?utf-8?B?TTJNc0daMWthbGYvcmJNZUFVTHNjV0ZBT29xYWFucVI5UGw4UkpleEdVMVpG?=
 =?utf-8?B?UzViTCtzQ1ZQZmNYdUZJVVJ4dTFpVXUxV0ZHdTNpMW83dDl4RkRVeDlkWjVI?=
 =?utf-8?B?a2hHNWc2TVE5akw0V05hWFBLekNqSkhIZ1lEeUZUcDZjb01mc2FQZGx6WjdO?=
 =?utf-8?B?RmFFeTBjeDRSd28zZ2pSbHFxUVAwTGhlUmZicGp6Tm9Vbmp5NXJ4UmdobHVo?=
 =?utf-8?B?aitpOEdzQmJRdDQ1NzZiVmVnemJpRE1kbGJrMk9yK0cwU1phRlk3TlpnZk5G?=
 =?utf-8?Q?o/wmdc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(52116014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tm05aU1YYUdQSDBSVjNXNkY4NmV3cENmV3JCdzdzZndMbEVxSWE3WHEvK09X?=
 =?utf-8?B?WmtVdEQ4WTQ0L2p5UDk2S3o1czVrSkZGQ2FmMnpmZ2NQdE1iU0QwTzdhNis1?=
 =?utf-8?B?b3VRdzAzUmZkcGFkdVZxdHpXTVJNaUlFQyt1N0llN2lOdXQ3NW5kSGM1aG0y?=
 =?utf-8?B?dHdIU2ZSMDkvZmhuVnlIQWgvQ3JTeEhZUGxDSmNSQlZpUzhZMWw1VDNNT3dP?=
 =?utf-8?B?M0ZJZjB2UkFyeUpnaDNsWVlnblJCTXhjQU1EcjRxRGNOSnZjYTkxUE9ROExD?=
 =?utf-8?B?eWlaY0Z3SXE0aVpwZkJYWUo0TWZxMGR5QU1VOVNxZ2pSMnFBRkI5Nk40VkRY?=
 =?utf-8?B?ejMxeVhJNnNrZzd1MUczUEczYSt6LzNnU3pCM1QvMmlJc2FVR3k4eTJYdHJo?=
 =?utf-8?B?VkFRdVNScEIzVWJWZWZkTnlvRjZ1TGxQcGVTczd0YTF3T0N0VlY3SEh3UlQz?=
 =?utf-8?B?QytidjlEcVFNMm5hMjFxb1l3MVlrdzdkSi9HdHo3WUM0OVRRdHBiTm9xQjFa?=
 =?utf-8?B?cjBnb1FHUFpPQXcvYi9Td2VwdzRUcHkzaW40RC92K05VcDBiNC9sdElOWk8v?=
 =?utf-8?B?dzVDMHRubmFmRmUvdjU5WTZwSmhUZE9CVjU5Z0R5T3ZsOEczc04zaklXWkhF?=
 =?utf-8?B?TTR1U2xaUTFjYXk2WVE0Y2FwUzVsLzNsd3NBcmZpZHZpRWpKODNDdmlaOWJh?=
 =?utf-8?B?OThnSmdGT1pqRTlXcTZDbWthWUQ1aTNlNmJ4WGFzenB6NmQ5SGZ5cGVuUTl3?=
 =?utf-8?B?em16RFBBQkZUc1ArV0J0UFBaOEdHcFRLS3haaUh1NmlrTm1hU2pyOCtueko5?=
 =?utf-8?B?WVpleW5IZ0RJRVllUjBFdUk1ZlBzbzYyVjczMjUxM0FMWEhYWXRxTSs3eDNQ?=
 =?utf-8?B?VDJXejdEdXlRZFluTFpGTWkxSUU4TFhSUG40dEhhSDR1T085amw0RWNWVW4x?=
 =?utf-8?B?dzhzcGZSME82S2oraFo0cnRNczQ0Z1dPOWFjTmllVGhURnNFV2hpUWdjMzh3?=
 =?utf-8?B?QjQxaGxpQmdUUmRvdUU5TWdNRVhRbDJBS3JRQU12NHpwMm1CYkVrVXhYR1N5?=
 =?utf-8?B?ZTFnRnVhSjJ2MlVqVkRUMWJWSEhXK3Q2c3M3VEdVYnBPY3pCUHh2RUkxZ2ho?=
 =?utf-8?B?bmwxREdITjh2OUFOSzdWVTBWVFgvVVFhNzFhcldFaDdCd09YZ015N0xldzJi?=
 =?utf-8?B?RXp1L1g3U1YyK1BvSTVGYXpTcG9wR21PMTZrakNuZVRvZGN5VzgwOERCVjF2?=
 =?utf-8?B?cTdUdlRNN1FjM0VtRjJBMXJnQnV5ZTNvZlB0RVlrb0o2T08wZ2d3STFEYnZM?=
 =?utf-8?B?T3Q3VUdsSHlxTjdvUnpGKzNpR0VWTExpTmZkeGVSZm5pTjlSamxRbW1hU2Ey?=
 =?utf-8?B?OE1ZS0E3N0xEZ1A0cFJuWkxRcHRrbnNBZC82alA0bG5qa25ZanpjUVhGc3Fm?=
 =?utf-8?B?cW1JZ3RmalU3TGFuWm04cDcyQjNmSDY1MFRLTjc4dEFtMUpkVTh6NElPYklm?=
 =?utf-8?B?OGZIZDQxaEZDWGpUTXp5Slg5YjlxQ3RLQ1Zsd1pwUUhYSEdkK3V1aG8zMEcv?=
 =?utf-8?B?YldGWFFMUWhuUzN6Zi93dHByaExFb09PbDFYczZic2NrUG9sSURQWVR6eXlr?=
 =?utf-8?B?TUpsREIwVHJwMTNOM3JxaHZaOXMxMnFVbkluTytnZlhrYjNUTi84SkZ3OXpx?=
 =?utf-8?B?SkNsMkg3aDZiRWM5OTNIOUJocU5vM202bENia01pajJsblp0RVpaMVFOaHc3?=
 =?utf-8?B?YjJSaXNXR3Jaa0Ftb2ZyeUJOdlFtOE1uVVRrbDRETXVtQU9uT2QwRXR4emtE?=
 =?utf-8?B?S3I0MDhMeUdSUWlzN3hSZ3FVS3dsekNzSmtQMnY5SDBzd1dpbHlOMldrQko4?=
 =?utf-8?B?azNrL3dCRXMyWUp0cDdNTEJHRmhDd3ZKaVNyTnBVbjNVRklIeFA1Nkp5U0Ni?=
 =?utf-8?B?WkZnVktobWh5T2JwOWFZSHhTNzMwSFVXYzRQRDZFclhZb3N5eVl6MWdmQW8x?=
 =?utf-8?B?RlJSUVhxNFc3L0lOSWQwRW1ReTR2ZGM3T29maWQ5WFlRMUhFSWpHcXQyc2VO?=
 =?utf-8?B?UWcxZU4yazlySXAxeGR4NWFOYi9wRFFMekJyenBuNWMreFZ5dCtpYllRelpp?=
 =?utf-8?Q?ReOJUR8Dx2+KEh0ZypqHthZdG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 874db774-ad06-4440-f676-08de08a5b990
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 09:08:21.0988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r4OdPduBd4+D1k58JXcdWQuAj43wBTEm16Qe7XbPvK9IUmgglWbgUUu74ZEEnVkh1coH1ZHpnGXYBVVlu1MiOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11160
X-Mailman-Approved-At: Sat, 11 Oct 2025 20:06:59 +0200
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

Changes for v1:
 - Adding USB2 and USB3 device tree nodes with required PHY and
   regulator support.
 - Enabling ENETC1 and ENETC2.
 - Updating Kconfig and DTSI files to support these interfaces.

Changes for v2:
 - Resend patch series with updated To list.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Alice Guo (6):
      usb: ehci-mx6: Extend support to i.MX91, i.MX93, i.MX94, and i.MX95
      arm: arch-imx9: Add USB2.0 and USB3.0 base address definitions
      imx943_evk: Enable USB 2.0 controller host mode
      phy: imx8mq-usb: Add SPL support for i.MX8MQ, i.MX8MP, i.MX95, and i.MX94 USB3.0 PHY
      imx943_evk: Add support for booting from USB SDP on USB3.0
      imx943_evk: Enable ENETC1 and ENETC2

Frank Li (1):
      Add serial# for SPL SDP download

Ye Li (3):
      usb: f_sdp: Update SDP driver to support PQC container
      net: fsl_enetc: Add i.MX94 support to NETC block control driver
      net: fsl_enetc_mdio: Add support for phy-supply property

 arch/arm/dts/imx943-evk-u-boot.dtsi       | 182 ++++++++++++++++
 arch/arm/dts/imx943-u-boot.dtsi           | 234 +++++++++++++++++++++
 arch/arm/include/asm/arch-imx9/imx-regs.h |   5 +
 arch/arm/mach-imx/spl.c                   |  10 +
 configs/imx943_evk_defconfig              |  30 +++
 drivers/net/Kconfig                       |   5 +-
 drivers/net/fsl_enetc_mdio.c              |  25 +++
 drivers/net/fsl_enetc_netc_blk_ctrl.c     | 338 +++++++++++++++++++++++++++++-
 drivers/phy/Kconfig                       |  14 +-
 drivers/phy/Makefile                      |   2 +-
 drivers/usb/gadget/f_sdp.c                |   2 +-
 drivers/usb/host/Kconfig                  |   6 +-
 12 files changed, 835 insertions(+), 18 deletions(-)
---
base-commit: 8c42f534d7e1956192ef8457fae884469f60ff13
change-id: 20251011-imx943-07710ed6cf60

Best regards,
-- 
Alice Guo <alice.guo@oss.nxp.com>

