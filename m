Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA0D0D185F1
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 13:36:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 692A4841CD;
	Thu,  8 Jan 2026 14:33:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Zx3TWJaK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 211DA840A9; Thu,  8 Jan 2026 10:53:17 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 373AC8405C
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 10:53:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C+/o/8OJ6H8y3hXbSSSc6UT/WsCmARyhaB9HPtnMWpXViHdDU8x1Gd05XoMcuKuPCinBX4JL/tGBYq7sE4SXX9tNJ80W//l5XiykFiV+qpzX9mlimrO7amz05ENi8aaUVhEOPhtBCDlITuQLh1f/XIAV9s+P5+qkGCuCpTJ5DQ9UEGD+hipSRIe2sswT1oqe1VZlDyNWSQ2eBIlb8iIa9Du8EJdD+G+zn5gbJSY8gMqLY18ZpCbYqeE8NoFD7gcMNftjz3I72EYH8QnvQc/nZfO1WAmXtSeiMR8a2vsh2UWV2czqd9o1dIcVPrIpRgmLxHOzEMrijLxSic4S11HLNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9P2dtNHviL0tQtiB+opsMph8zaaxeQwlbB7VoPHehU=;
 b=qS5hzJc00lldSYfVm3YckU2+6MdZbwtnurW6v1OZraWG6UKn1L4DgXJKf6nbcW9NMPG9rEtgac4NN8IREYnvLNIWTb1jdss3PdhbYQNxGOHlF2kDlOOkDYjGQ2tVaAB0PoWWXbhyMfJwOBZB9zd95epsKy+WmrwVarq0s13ZKusjVLMrLrIi/duV8veL5M4Iel7Bn6wuZgXMu77l33PsNhjF24Vl+h1ZYmC+NWXm8KivowsBwD7sb/4ls5DDWbAMShzGU/rivDAyKx9hiMywwot0Gc+RXw/A11y7eHzy1YgZNFL+Hb+svicu8Y+YMXbV8SEfquWGhPvdvJBnQF+1mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9P2dtNHviL0tQtiB+opsMph8zaaxeQwlbB7VoPHehU=;
 b=Zx3TWJaKDiE56wiT0YFXMeKBZKfiUYLtDl9LLhIP6fd6fYOkBB+XlAM3BD7gK+YDwpEfkTnLHTZe3ragWnqfaC/JcvBSi8lZxGYf5X2ZZ6wpvkN6YUeSQoBzDuz09jiKLRi3ahfOuoarEHLwV0J6UtR0TCvzNk7988vq2y0JAa11qJgLFUfRah7qecMhuNLz+eg/2wqVtRGuUYhuQGHWvAqGX70aI5TxMw3uLCm3ylIn0enaW+7LSguWU5WWWi5ldnhi6RqAIiQws4CrbgoNm5S9nkL4KvvJMN0YkTWj5et+nRitroohPwjvwrjin2ZHibEFPjc2Z2V2cSebCbLt+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by PAWPR04MB9765.eurprd04.prod.outlook.com (2603:10a6:102:389::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 09:53:10 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:53:10 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 08 Jan 2026 19:06:53 +0800
Subject: [PATCH 08/13] imx94_evk: Sort header files
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-imx-update-v1-8-0d5921c575bb@nxp.com>
References: <20260108-imx-update-v1-0-0d5921c575bb@nxp.com>
In-Reply-To: <20260108-imx-update-v1-0-0d5921c575bb@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2P153CA0025.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::12) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|PAWPR04MB9765:EE_
X-MS-Office365-Filtering-Correlation-Id: 174e67cb-ab19-42bd-2eca-08de4e9bbb05
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bDIxYzN3bzRjNDZNUG1NU2FzWlZDV0R5aHpVdkNFZ0o2Ly9udXhzaEw5Y2pY?=
 =?utf-8?B?QkgzNWEzVEhndTBNRm5xbG1ENWYwMlN0NkhYaDBwZFRSQlQ3SWtsZkdCb3Jw?=
 =?utf-8?B?bXNGd1BwaE1LQ0R4bHZ5amVQNHdDUitTWUx3K1FvUXlMOVNUeW55dFlBTDlS?=
 =?utf-8?B?Nk1RaWZqcXNPODIyMVdYblk2S0sxajl6RVVMcFBYUFpLVXZjZjBsaEYxMGZP?=
 =?utf-8?B?TXNJc1YwT1RLeVhpVFI5Mkx6QjVMemlablFTZTh3UGZ1T1V0WnIzc2NteEdo?=
 =?utf-8?B?WkMvT0NnWnZ6VUE2OHJZUWNKdXNUVDlnalROUWc0cEUyWjNiL0JSMEhLZTRG?=
 =?utf-8?B?V3VxcWMxZkduS1VuNStyQ2VPbFk2OTlISktlbkJ5Y2lTdFg1alNhNzZxbXBx?=
 =?utf-8?B?WWN1aElhOWIvbVpaVEtHcC9xTXhJS2l4Ym40R3ZIcWZwaHVWd0dkVUJuQXZY?=
 =?utf-8?B?MVR5RUx5RmN3eUlCWUozcXpSNUJsUGxrSWtiZjJZbFk1TmJYRUNIRzVWOW5u?=
 =?utf-8?B?UkdkQldmdWllb1ZuSjVRb1dEZCtCZ3NEVU1ycndaZE5Ya3NrczgrQlFwbUc5?=
 =?utf-8?B?NlMwb2Y4ZUJ4QXo3dWpJZUpqbldtTFdQanF2TExHbFRpb3BXZzgvVzl6aDdQ?=
 =?utf-8?B?RWs3a3U3QjNFRy9CaVd3ZWpSU0h4Um5yTXFuYWxOMGZOa2tyS0dzZWxuRUU5?=
 =?utf-8?B?RUZ6U2pTYjhzcGpGTFJZUGNzRXVqZyt5VEV3N3lhWXFRUUFpa0VVdXJxRncw?=
 =?utf-8?B?RTc3d0xBdmRqc3lXR050bzdteEVBdkZBTThwTy9WSEJOWTBJcmpLTjFxTkdJ?=
 =?utf-8?B?aUxnNGFSVmVzQjRHclREaXhkNU1NV1lIRmxkUThhYlBXdmJlUXBCSFFHYWEv?=
 =?utf-8?B?ZzFqeXVGMm5jUmlUcHR6RTVYU0I0c1orN01HdjNZNTdkVWY4a2VOWVgweHJX?=
 =?utf-8?B?ekV1dmw0cTVCME00THNoTmRSa1BhdWlZcUE1QmszWGhjdjI1Z0ZXY3hOd1Za?=
 =?utf-8?B?NE5mRGVPUTVZR0hsbUlRTmRUS0gySE1rQWZpbXVpQTEzN0N2by9XOFFhakxH?=
 =?utf-8?B?Y1JRZ1ByYk55R0ZoYkIyb291WDlzTkVRN1g3Qk00VkNXaXRlaVBobkZNTmZp?=
 =?utf-8?B?WmY5STFtZnJoa3RmVHNzUGw4K2dmKzB1NE5ONEx4Rk94aDZQdW1XWHozT2hI?=
 =?utf-8?B?Y3BuYXV2dUVLeUxhNmJLQW5DdTBVOFNFOE10THJyck9JZElUMmswKzc0NXVu?=
 =?utf-8?B?VEhUdHBrenAveDlSSDVOVFhLMmdDNkNqZTNKYlljRWYyTGhUMEpiWXVIcVVq?=
 =?utf-8?B?SzF6ZVhOL0pDdGpZU2paK0wxOWFONnNRcnJnaWxneTV2ZnNSMCtIcWJBbUNQ?=
 =?utf-8?B?OExsT0VMaTFSMTY3MXVkTG9EcGF1Vjk4ZlN2QkZMb2VUV1AxUFNBRU4xQ3lp?=
 =?utf-8?B?TkRSSEFnM3FpL2x3LzI5eW1lZG10bnF3dDEvY2Q0bnRSOHJWcEFNQTE3a09G?=
 =?utf-8?B?UVpqOFBFM3U1WGszaGFYZCs2Rm5DeVA0VklEcWNaNDc3Y3RqVCt3SG9wbzkx?=
 =?utf-8?B?UzRVczZLeTE2V0NYdjRzeHFzOEk0OENQS3NYcC9zamZmbko4WjJYcWs5aTNV?=
 =?utf-8?B?d2drVjd6S0VkY3JJZkI0U201Uyt4L0pJWFpDWm1HRisxTUJDNHhUZHFYWjhF?=
 =?utf-8?B?Z3JvTCtsalBqbnNhYTVKa2wrY2ROcnJjdG5vSk92QXdkd3hOVmlJcVRDLzFU?=
 =?utf-8?B?ZDlYUHovemRrVnBGaFErWXNYNldLdHhoOWhrTERIVG1KNng3SWk0S2xLanNj?=
 =?utf-8?B?emNaT1V3ZnZsMGw5aWdIb3diT2lyS2Z4WGxLNS9TVW1VdXZEWEhqMTl6RlpR?=
 =?utf-8?B?aFJvVFZBMkkrVFo4RHZwZHVvQmtNcG9wT2IvbzMrM2xmcndlellDNmlCTFhE?=
 =?utf-8?B?VHdwNTMwc1hocGI2dDlRTVg2OTllRGFMYW9adEhZTjFaNkRMa0JmbG5uQ3ZT?=
 =?utf-8?B?VXNLSWdueGJtL1c0WUVqR2taN1p3b3FTa0MvblJwQ0RSczMvQXNmN0pzUHh4?=
 =?utf-8?Q?CwcBDV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blpiTjQ4QTVZWVpLcEFTWExxalNnb3poeDZ5RnpTQWpLajVScldScGxQQmdT?=
 =?utf-8?B?bVhkMDNIZTJ3Q2tBUXFDcDU0cCtsN3BRZW56OXRsRzZrVzg1L2ZCSlRzUG0r?=
 =?utf-8?B?eE1pc0NHbWJNRHdleWtsbjdPVllVRDFlT0svZ0IxRG8yaDI2SS9yckhLdTVy?=
 =?utf-8?B?WVBsVC9ReGxSNjdBbUc0L1pDbm81a3RaTWhsc0NnZ2lNeFdldHkwTUlBa2ZF?=
 =?utf-8?B?bHliQ3MzNmUveU9vRi9wVXpXOUwxNER5SHVUT2Z5Rk9uN2kzSStFWGF3S2tX?=
 =?utf-8?B?azJ0V0tJdFpYbjJVaDBXMGRvMitQOWVlcWw5VHJ4WWtQVHRGRmxocUhmQXVX?=
 =?utf-8?B?Zi9YdXFiWTAyay9IY3JTL1NkU2F6V05Qb2tIWlVDdzZmN0p0cVdDeHRDby9F?=
 =?utf-8?B?RDEzMGlJV1FKU3YvOStzOGJVaEJCaDhJNWFNYm1iRGl3ckY0akhzUjJCeHo2?=
 =?utf-8?B?eVZiZnBKS2NqS0psMTEvSm0vbjBrV1N0R0w1VCtiV0lHN01EeWZxampSUzN6?=
 =?utf-8?B?MzhZcTM1M0ZhTnZMUktSUVlwRE1EZW9XNGdZNkdkbEFWM2pZTFNESXJyYkg1?=
 =?utf-8?B?UVFuR0MyQ28xUUxTdmUydFRTOHZnNm1Hc1F1aUFvdUV1Q1J0NTRFcUV2alIz?=
 =?utf-8?B?REQ2b1k4VldtYVFzRUpmeXBQK1RWVkp4Qm1DV2FNa0NFU3pXd3RJakl2QWVJ?=
 =?utf-8?B?UlAzQVZyOHEwUzdTdHpzZVVPV0VtOFphYjRYczNweWlwZGVYUmwzQVdhT1pZ?=
 =?utf-8?B?aGJDY3NOUS9rMDJnREtQMEdmZjhqZWllaS81R01zUjBMUjJqcStuV2RIR0Vk?=
 =?utf-8?B?ZXg1YThjSjROUlM0QjFDWkxvTnNPRjkzekNydVp6OXpIaVpHMkFPU2pSUFpq?=
 =?utf-8?B?bVZ5aVZ0a1BMdlY0dkRBeEJHanBlbVU2OFBtWTZsNnc3UTNGdEtQbkJjSUd3?=
 =?utf-8?B?NnlDS0g5RFAvVW9SVUdPZjZlbWFzNkxnUG5RbWIvTmYraHhCbHN3UUg5QkZn?=
 =?utf-8?B?N0FKaVVZMVEyUnBYTTVVclIrK1JCdC9MOWgyUTN5NHNSVU9SeFEraC9MVlFK?=
 =?utf-8?B?eFo4Ti80RHllaHh0bWF0blJEVWl2NVpmZmFFckdOdkY4TGZYODM4SHlPendn?=
 =?utf-8?B?dkJPcDlMK25vZmw5OHM1RXZkd0xSRkJpWEFlQXhwU1VKL1VQMUovVTMzeDVN?=
 =?utf-8?B?M2pPZGNjNnUyOVVZNDl3Ni95T2QrbU52dFZxTjhGSXJyd0YzQmFNb1NtVGZT?=
 =?utf-8?B?LytvTGxTTnJKczcwTW55SnMxdUFibnBGOW5haUx6enJQa1dvZUt5alVXdHMr?=
 =?utf-8?B?WThpZEU3a3VmQ2lsaUNnQjZycHRZWndPSlVSN3lkcS9ud3gwWm82cDhlWjBJ?=
 =?utf-8?B?UUNrT0hIc0RPb2FlUVkxbS80elB5UVg0ZjlqdFlJVlcwV2w2blZzcEdLZ09U?=
 =?utf-8?B?WFR1Z2tySnoxbWtPcjBTRkNVNEMzemJROUNLSGdDM2NoKzJZeG9pSUZ4VjVm?=
 =?utf-8?B?SEJvL1UxQ1kwZzM2Qk9XN0thT1ZBbldsaWdJRmZZR3JIOVM1QUFIYVc2Yk56?=
 =?utf-8?B?VjVyNHBCR0xxcFgyUDIvRmwxdHp1dzc2WnZ6dys3QVNWa3RUNVJZMm9nR1Vz?=
 =?utf-8?B?cUd4Q2Z5cTV2cGRESCttcUVlWnFqV1I1Qlg2Vy9DUXlza0ovc3QrcTNCdEFa?=
 =?utf-8?B?OU5Kd3FhMVJKay8xVXN0eC9sNm9ZaWlaNVhqM0ZIR0hoL0x6NFZGSkNOemZ1?=
 =?utf-8?B?ektrTGt2SitUa1ZMOGhONkxtV1IrL1kvMGsrdWI1RHljUGZwY2pDNk1jTzVQ?=
 =?utf-8?B?TjFXdVdEQ0dDems3RldkNFpNbnJXT20vblE4ZXhab24rUTBTY0xZaDd3Snpw?=
 =?utf-8?B?bVE2bXpXYU5jVmRZeGNQTmtHeEVvRndldTRWc1ZJS0xZRzd0Q0NYbU1XcnA1?=
 =?utf-8?B?TjRCZTZpNUl4R0kxbzJtK0IrV3JpZitKUjRtQ3RYTTZOTmNWZkIzK0hoRnQ2?=
 =?utf-8?B?RkljTXpmS3BvVHNBcHdQL29WTHIzQ3ptd3lWWHI2bWNVL2NvT2xLaldzUzZD?=
 =?utf-8?B?cjN2MUpVTllCbE5aNG9Sclpoa250N1Vid1VSUUZKeDJBb1o2UjZWYW1NWXpJ?=
 =?utf-8?B?cy9PZVpKWEdrSWdBNlY3NXFwVFZGclF1Ym1RakNxekxOTlg3a0tDUW5XTVpJ?=
 =?utf-8?B?dHZod0lTMHJuRUYzV2hrUTRjTXhENnlQQk1ieFVidGtncTBxWTFJT2hzbERn?=
 =?utf-8?B?MDFBMXRwN2VXQVVNaGYwYnJjSHVVRVE1SnZZaUlDUXhnblJnNWt0QW9RbU1S?=
 =?utf-8?B?dEhSWVJlTitxQlg0c0lSTUFJQ1AzKzZNYjc5N2sybTBQQjlaMVZndz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 174e67cb-ab19-42bd-2eca-08de4e9bbb05
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:53:09.9770 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X+up9tOA18klYjE9jZRkrP6Oq+3N7ltat5QVOLzdA4NdWOoM4cFsinWEwCO/b0Joy+84O3KGRzufdnfoZY8jKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9765
X-Mailman-Approved-At: Thu, 08 Jan 2026 14:33:28 +0100
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

Sort header files following the order:
 - generic-header
 - asm/generic-header
 - asm/arch/
 - asm/mach-imx/

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx94_evk/imx94_evk.c |  6 +++---
 board/freescale/imx94_evk/spl.c       | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/board/freescale/imx94_evk/imx94_evk.c b/board/freescale/imx94_evk/imx94_evk.c
index 28d512ac5f3..588aa7548d4 100644
--- a/board/freescale/imx94_evk/imx94_evk.c
+++ b/board/freescale/imx94_evk/imx94_evk.c
@@ -3,11 +3,11 @@
  * Copyright 2025 NXP
  */
 
-#include <asm/arch/clock.h>
-#include <asm/gpio.h>
-#include <asm/mach-imx/sys_proto.h>
 #include <env.h>
 #include <fdt_support.h>
+#include <asm/gpio.h>
+#include <asm/arch/clock.h>
+#include <asm/mach-imx/sys_proto.h>
 
 int board_early_init_f(void)
 {
diff --git a/board/freescale/imx94_evk/spl.c b/board/freescale/imx94_evk/spl.c
index 341b165b3c8..0aa75ea907e 100644
--- a/board/freescale/imx94_evk/spl.c
+++ b/board/freescale/imx94_evk/spl.c
@@ -3,16 +3,16 @@
  * Copyright 2025 NXP
  */
 
+#include <hang.h>
+#include <init.h>
+#include <spl.h>
+#include <asm/gpio.h>
+#include <asm/sections.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/mu.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/gpio.h>
 #include <asm/mach-imx/boot_mode.h>
 #include <asm/mach-imx/ele_api.h>
-#include <asm/sections.h>
-#include <hang.h>
-#include <init.h>
-#include <spl.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 

-- 
2.51.0

