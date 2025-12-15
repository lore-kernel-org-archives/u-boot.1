Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D63D59D99
	for <u-boot@archiver.kernel.org>; Mon, 15 Dec 2025 10:50:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 822DF80107;
	Mon, 15 Dec 2025 11:50:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="CcuMrFJV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8674F801CF; Mon, 15 Dec 2025 11:50:55 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6863980050
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 11:50:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q3tq507BmYTSH/30J+tzao+YwBbLx7uulANvPc6pcpWJlrD28CG5hkLEQx/ab1uzfeT5gB9YoQSlZRhnl8914YVNyscGk1lD7pE/akmI5a2kE+YjSSS19ZREef8cAeo/voU2eL4SQdySe5vwgNOPvUstKBMfxYn5SngKPg/IsxHFJY4NiA58pjv83FLBGQwNtNh6GfQejzJUHMWG1mWOFr8863SZyDAZpMe+wBL5yZNnh7ZqEAaK/B9a5ImVNtv3KXRRCaIYzGP8JpEhR1URKvJpCFiNT3XZglAFj94JEh2gjnHJeFzgaw886MYTzGTuSEp5+2LXvDDLQm5p+NL2Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APeZLd2s+8u1kVOMu1AZCNbC0pvbmGBf0/GZywLA8Iw=;
 b=ZcCXN/GHfdLl6O74X0ubLn3hzzar89S7o06WcgZeUdS8ccdngslW4CKL0NGufmj2jKuBKg3EWr+oxKpjs1fRJlwlo1cx+pkX3TqQjUDInGXgDrzm1OdXcoOwXUMV+2/DqOMly18cKm+j25S2kADW+p3e3MoC/aYAR+FCyobauhesLgFlCbD1uh5kqMO2GVx3t/QslAZupeBmK9NF1dS9mB6MLUj+vMg37AbprGJxlzpBC1GuWQjTW3CvwGLb6S6/tzaqKCVQzy1LEOfE9DgpE1KgRLNQNPMiCaelAJTBWnVKYvI6zkkQVwS9fx9fzmrXe0oAoUspOdVvHcSgHoj1tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APeZLd2s+8u1kVOMu1AZCNbC0pvbmGBf0/GZywLA8Iw=;
 b=CcuMrFJV64+RMN4JOBnHmTa2prgJZXDcrdTPNqyAibCLc1fM9KuoZ6yMCffvHGT3Jensl2FrYA5Y6L6TbTS0s5UnfNrGoTk8fgtbUNJdnJd0fnxk7ZGPORiHGDkWJHEbo+x+iioL8Lnq7sU4c56ann1SkBH2PrblWNAqjLX5SOU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DU0PR04MB9273.eurprd04.prod.outlook.com (2603:10a6:10:354::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 10:50:50 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 10:50:50 +0000
Message-ID: <579ab77f-ceac-4de0-b3ef-1bfda1724418@cherry.de>
Date: Mon, 15 Dec 2025 11:50:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] boot: fix prompt for SPL_LOAD_FIT_ADDRESS
To: "Kumar, Udit" <u-kumar1@ti.com>, Quentin Schulz <foss+uboot@0leil.net>,
 u-boot@lists.denx.de, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Elaine Zhang <zhangqing@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Andre Przywara <andre.przywara@arm.com>, Ye Li <ye.li@nxp.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Justin Klaassen <justin@tidylabs.net>,
 Samuel Holland <samuel@sholland.org>, Rui Miguel Silva <rui.silva@linaro.org>
References: <20251212-kconfig-reorg-v1-0-72441d8cc53c@cherry.de>
 <20251212-kconfig-reorg-v1-2-72441d8cc53c@cherry.de>
 <d46a7a85-7077-4b3e-84a2-2ce607412402@ti.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <d46a7a85-7077-4b3e-84a2-2ce607412402@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0285.eurprd07.prod.outlook.com
 (2603:10a6:800:130::13) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DU0PR04MB9273:EE_
X-MS-Office365-Filtering-Correlation-Id: 48c72c6f-1e92-4d82-7e5a-08de3bc7cfde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|10070799003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UmU1aFVvS2ZuNnducERiLzM4Snl3QmM0SkpoeGg5bmZrcndXZzd6QnNwemts?=
 =?utf-8?B?SnM3eXlDYmJYMjVMbDFtUDZEUGViZ2ZRd1JiY1NxWmxmRExBQXNIRHNNTFBz?=
 =?utf-8?B?VGZmMElCMC8vZkF5bmsyRzhPRDFaODM4VVBSb3B2L0lnSCtLZEloeWNtMlht?=
 =?utf-8?B?amtqWlIrZmtjOVlYYXNCcUQ2WXdhMkhSUE42MnR6VkUvSng2OTIwcmVkQ09w?=
 =?utf-8?B?Y1UyMTR5ZWZWS1kyT2hvdEM5R3VPSUF1ejl1QmhtTTQrYlRUeng5YmYrWlRl?=
 =?utf-8?B?Z0lGVnVUZEk3Z29xY1pVWEplRjFBMlhoNjBWQVRGem9vUHNYeWF0d2x2RmpQ?=
 =?utf-8?B?R0JpTWUrNFdiaVpSNWRpMWlMamRNUzEzYVVIK09VMjVhL0JDQ1JYM1BFWitt?=
 =?utf-8?B?VHIwMTdHOWRyRjBlcEtjTWJrZFJvU2tDdWh4NEJKS0IzaGNQUWNqdkF6TkUv?=
 =?utf-8?B?dEJDWU1kTm5adHBoaHNjN0puZHFjU3JIbUswRWRya1pLK1RibXlWZFVKNk1C?=
 =?utf-8?B?UFBjWmxYNThBeDJNbGFlUXdDQjZHdFgrR2lySTh5aXhKOW43L0tnTGw1MXQy?=
 =?utf-8?B?bk9aU25OYm1IWFNXOUpzZ0FxenFFeUVNQ2RpM2xocVZYUmpDa28yTGpwWjVn?=
 =?utf-8?B?VjhDZHphN0ZWNjhtUjdXZ2dwMlF2by92VkkrOXkvdWx1L1RLOWN4M2dheHRL?=
 =?utf-8?B?Z25LRUF6c0lCWmFKRmJucnFhTEphdXBYMlZVNC93bjFPNVNnVkFCTTcrSlVj?=
 =?utf-8?B?N2N3ZzVnOENyVzBGUVg2U0JEUG1qWVlZRDJkbi9taC9uZ3BXZVNnTXB5dG1T?=
 =?utf-8?B?SlBJUzF1aW5TaFFxQUhNRTJSdElvKzAwdFRGQTExVVhzZEpaU2NoOE1QUTBq?=
 =?utf-8?B?QkZvY1dsQ2hQUjlBVVVsNXI4ZXh1Sm9GK2JHK3ZDMXpoY0o0U0MzZUkvamND?=
 =?utf-8?B?dVdHZ2JoMENnckhXcFdkbzhlMFM1UUZ0T2hmVThyaHFtN1B3d3l6djBPWFdP?=
 =?utf-8?B?cWx0eEpEUis2eEp6OFlWQ2xydkhQc1dWTENPenFXblQxWitVNVcxaVhxRERa?=
 =?utf-8?B?VFg3N0creUl3b2NSc2NUTHNseDRiNFpMekpaRnJzcEcvdHNJWjFjZzlxcm1X?=
 =?utf-8?B?Rm5iWGNmN3prRWlzcVVIZVRrTzlFbWd1bm1lVWFPRm9kWklmWlpyUjRnVlNh?=
 =?utf-8?B?NXMrd1B0WUdVNHd2anVsbG5FY2Q5L3NSS29YYnMxS1lyd3N6dkFwNVZRODFl?=
 =?utf-8?B?bDJHdHRIV3NQVWgyUzNaOGtiL1FlSEQ0TUsxcGlJaFpVbFJISDBzczBXSlZF?=
 =?utf-8?B?UCt6YVNsdHRpbFprSmtyY25zcjVzL1JqMTk5YXZrWGVQL0oyS1kvSjNicHVN?=
 =?utf-8?B?OC9mdzBQK2NZdWVtRWdiN3RwUGZtYmR2TW44WW5mOUszNFFwR0xhSHFBMC9u?=
 =?utf-8?B?cGlwQjJob1VrRDRkVE5CK3pWVlR3VWV6SUlPWXFtMG1vRUpOaktqMTF3ZEhD?=
 =?utf-8?B?Q3JOV21kWGhuK1dyb0Qzb3Y0aDA2SjdKMUxuT01qdnJEelRRcGhTWGpBSitQ?=
 =?utf-8?B?SGhLU0h1NWNvSHhQV2J4dFg4UW1UQjBLa042NzI0dnpGTy9ldW9DZ2V4MDh6?=
 =?utf-8?B?cGp2Z1BTbDBFQzJqc3VHQW10TU1nZEVzNjNMcUd4bGM2UUxaM2VYVWJrTUZE?=
 =?utf-8?B?MHpCM28yeFFMak12endrQ2pWREhPeVEwdVowNDlKcGM3ZlVCR0pQMnpremVB?=
 =?utf-8?B?SlkyNkp6cjNreFZWekRtWnZMUGN4L0Uvb1EySkJyaEp0aHdRaU1OY0daUW5x?=
 =?utf-8?B?S2pHV3JZa3R3TXVpRFo0VGEraDFwdmRqYjI2Q1J1aXhaZlpHL2sxQVlXOW90?=
 =?utf-8?B?bm5TK0Y4cStsVXJKY0tQOE5TQmEvcHBTQWtTcEI4UlRlcGVRc3d2NmpEa1Vp?=
 =?utf-8?Q?0FoX7BztCmcIrOIWGIDPXTo4wmvbBVgj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXQ5SENkOFlaNDZTbWovRUhBV2tmd1U3NFBOeUZ1T1dPemFvdTZaZTNWVG9N?=
 =?utf-8?B?dnFGT3hQVStpbUducmNTSmtZSFRkbWtEaElRWGJWZUgxUldVYmE2T2Z1NU1u?=
 =?utf-8?B?MFRtcFA2Si9BaFBvT2E4Y1Foc3IzMVdKWGdOM01meHhwTjlWM0VGWVltQUtG?=
 =?utf-8?B?ekJHTUxBalhuY1Via0JnNkMzdThxU0gyY2ltZ1JGbzN2bU9ucHRLL0oxTHZX?=
 =?utf-8?B?NUJ5dkIzYWd6RVVMemsyTXU2VGFoYU1Wb2FyTDFrTFJtbHNQbFMyMDdGd0tS?=
 =?utf-8?B?UlZsSm1lUmlDSmpkRnJiUFVGSEFFOHRVVXVZY3pTdzRSNVBzWWdTYjRHeGVw?=
 =?utf-8?B?TUJna0lqWFdzSWNhSFJwTEhDNU92dTVBNFZCcC9sT3RYM2lMNWl5cjVkT0lp?=
 =?utf-8?B?dE1sQXlBVHgxeFlQd09rWi9Ld2Q4ZXBLdTk5a1FKUmxWRVFlbHZPZDM1Mnor?=
 =?utf-8?B?bGlFL2lWTGhKaTdRb0o3SDcvWmtyRFpGcmdwVElOK3oxZDJWaDlxdGpxOHdZ?=
 =?utf-8?B?NUlqcEVzVHBlZEw5Y2N2Rk10M0EzY0cxT3BVcGxmTDllY0R6OCtibmhkd2FV?=
 =?utf-8?B?ejhaNXRZTzh2d3NKc2RET1ZiWmxFRnREZjRHTmtVbDhZK1BsK3RYaVJ1Mmxj?=
 =?utf-8?B?WWNqZUF6V1FBN0ZOcDVYZG5PK1huR09CYjVzdytOWW5xY2RmcXk3aDFIenYv?=
 =?utf-8?B?cVdHUHc1RWVocHZCZkUxcjEvcFpLOWJVQUh2aERrdlk5M1JtTTBDWHJ0MmJJ?=
 =?utf-8?B?SXlUQzU3TUxmM0FpaEtNUXdwVTR1WG5kcGpjTFZVa1lmR2xRWXg5ZU0yZlFK?=
 =?utf-8?B?dDVnNDhPTUtzdkdFdzJBdUpTVTN6eWpzWWRBcGJTQ2hHSWk2TGh1UXRETE1l?=
 =?utf-8?B?VGFWYngvb1BTZDl1TnpaNU9XOU9HS1dPVGxxa2o0elBBOFcyaWNaWEZZdGlY?=
 =?utf-8?B?WU5XbytPQm1haXZxQUYxcXMycjl4M1p2Y29IUUw1S2xjQUViVUxNS3BuYmFn?=
 =?utf-8?B?WUthTDVpdy9TV0F2QndJaW85QUY5d0Y2TVM5cTcyYmFjbVRCTTlubTdEeXY5?=
 =?utf-8?B?aU1zRll5dDZLUlNVWkFvb0JyZjlUeHZvSTJ5U2JlcmpKeUNNcSthd1RUenlL?=
 =?utf-8?B?aExmWTI4M0Y1Nmt4VlVVLytIcTZxUnlnTm9SMkg4a0hxWEdJdG82Q3dNTFhO?=
 =?utf-8?B?OHpSd1lsaFZZTzRmRVluZ0p0VjdFQkpncms3UUp6ZmQ0SFY3UEYvb2dtZXBR?=
 =?utf-8?B?elBXSVA2RzZoVnk2VzUyQUY2RmwxNjl0UjdQV0JiZDFkb3gvZERBNW1RQ1A2?=
 =?utf-8?B?WWIyVC9OTUJjZjN5ZW5rQ0VkM1dBV29DYkYybmNNZDJ3aXhsbTRRRXBkd3pY?=
 =?utf-8?B?MWhlQVdjOU93dEhZY093Z3EyR2dKcDlNM0JyTFExYjFOcmREeWVRQXEwbi9t?=
 =?utf-8?B?bnBwRVhlbDJlTzBOcXlMQlpIaSs0M0hjSTMwV1dLdUkrakxhdUJCVXozYmlJ?=
 =?utf-8?B?N1VpT3Bramh2WDc4cXhCejlLTFQyUXNCTVJuWVJkZzhMZ0pzSWRqakZQQk5i?=
 =?utf-8?B?S3p2V1JYeEgrdjNranFwbXNGUW12OW02ZmpTZ3I4SjZaMlR3OURmc0Q0WDA1?=
 =?utf-8?B?ZVd3WENJNENqR0hFZnFGdnNUU1ZrRi9zcWk4RWtJcVZKcFpFRVRDdlI2WEZs?=
 =?utf-8?B?T0lidzdRcTRrR2pTUmtNLytVK3BRRHVBOExEd0tVQXVtSHdqRkN6dDEvenJR?=
 =?utf-8?B?U0VIZ2plNXlTUW5ZU0FTMWR3YU9GVkRQZnVPQWpQUmoyTHlSZ2pvTDA4TUV1?=
 =?utf-8?B?TDlOZkNlSWVRT013Sm1ZaTArS3ZpVWkrTHl6alI4VVlTNE9BUXN0OUhMSjRO?=
 =?utf-8?B?RWVwQVVCcEIvQWt2d2Y1WmRKUXFVeVNuTUgvTHRrZXMwWDhYVVpITnNyY0FR?=
 =?utf-8?B?Z0lySVJ3OEhYbG0xTmlSYkNYcXpkdnkyOHVXS3Rzdkgya2pBWFBZbkwvSEZR?=
 =?utf-8?B?S1UxS3RZUmtBOEt1N0pwSFdheEJyN3RhRldwMk9ITGF4Z1Rsd0tTMUhjMUJa?=
 =?utf-8?B?MVhXVVZ4UXh1ajNSNGRVd21IbE1lM1RFdWcxdnpiLytTUHNrR0IzRy9Xbmh5?=
 =?utf-8?B?ZnM5Z0VJYmhZKzZEeTFld0pkT0w4QU93NDhBOGk2ZVpTdVRmcmJyNnkwOWFC?=
 =?utf-8?Q?dN2Rw0ATSXDN6GoX6PZY+Vo=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 48c72c6f-1e92-4d82-7e5a-08de3bc7cfde
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 10:50:50.6232 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mZopRPc5XFUjng4C8rzDWTiV8O6OlsKs9/vAYlhqkjySM+N1ZagKVCmieTyw41qBQt2K3b794ovTFiMRRXdslxr5+xEdTYxe+DEJ6RtQGyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9273
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

Hi Kumar,

On 12/13/25 8:05 AM, Kumar, Udit wrote:
> 
> On 12/12/2025 11:43 PM, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> The prompt is missing the indication this applies for the SPL loading
>> a FIT image, and not any other stage.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>>   boot/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/boot/Kconfig b/boot/Kconfig
>> index 85f4d468069..07ae6cc585a 100644
>> --- a/boot/Kconfig
>> +++ b/boot/Kconfig
>> @@ -272,7 +272,7 @@ config SPL_LOAD_FIT
>>            "linux" images are also supported with Falcon boot mode.
>>   config SPL_LOAD_FIT_ADDRESS
>> -    hex "load address of fit image"
>> +    hex "load address of fit image in SPL"
> 
> SPL_LOAD_FIT_ADDRESS, itself indicate that this is for SPL, no ?
> 

You only have this information if you enter the help menu of the symbol, 
the user will not know it applies to SPL if they don't enter the menu 
(and they would have to infer this from the name like you just did, 
which not necessarily everybody is aware is a thing). Honestly, I read 
that prompt and thought it was a way to configure loadaddr environment 
variable or something like that, wouldn't have imagined this is related 
to falcon boot (mostly from what I could tell).

Cheers,
Quentin
