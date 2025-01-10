Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52995E77188
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 08:53:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEBB0801F5;
	Fri, 10 Jan 2025 09:53:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JKYP6R3v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8924F800C2; Fri, 10 Jan 2025 09:53:19 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::60c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54CB68036B
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 09:53:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ysSSwQ7FDmeqlhdouLYqLJtZZe2JrcL+QYoLQV9jQO6fEqm8zfdvpHbDqw0uJV+7q7ohwip3V1ZTO8bB14Rq0Gc5+RoHdwRIog3zG0pxOv4qKKhRKJg7sJIc1ZQzp3d3aMEi+tkUD+Z+6WRGBDfuum2e7Z9Pn6aWecatqyQWZstJphePTBGoggyWcGK6BKhrseb8lCNHSPoZzLha1ocnzKl5NLWKf+i1yEm7a+K4iepE+KPW87E7/80W57CeERBj51zx+InM1fCxXzftxRjjcvz2FOo8tgAr/ojyEl9tLgVUNDYIIZJUwAziXnXuEu/uWpwvZmch9GwIUdKZELmvaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11f0kTyYepH8DXU0Xxz/TO25ARv5XJDi6cH8NNEeI74=;
 b=B6skJJfg/13I8jsGN/OtPHLNUUqxgvvqA7yrQJsCV7xtAP7/7xjIwW051by851GaN6sEkMTauoPzFfBXAXoH2DdN22u1qmGnoKvs9PC4cJNDFpUNNC7aVEpJ3CHfi8eRuMU+YdrenjIvHR182qzPHy599fR6i4ihaAoHDXEIiUlEPEmCq2EDG91mqS2fcLdJMNKYWyxS59tsm8nbpNgSGraL0IckTY0cFz5dQzz7Vg3tKZDt8UnpK7ANqhp6ySl4uAkp0gWc1JwCJsSXKqLzGczmT0yEbG0wAYs7VoenW7XHHRmT/XEb1dx3vkSgHW9P27x8icHE9XJL93R8cyVC2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11f0kTyYepH8DXU0Xxz/TO25ARv5XJDi6cH8NNEeI74=;
 b=JKYP6R3vM/onMVvanSm8g2DAE+/Fulzmz3VRopJ0M5HSJJLVqX1N+UgruBvLnG+KgHepp0lW00F1uJWY1b/ny5dDhsxvn579+1ZgzdoBMKAKzzEDT9yYjCIeyfGVF/4k5f1M3EwxNCmN2e56W6w5zPyfMdFD4cO8aOIyUbKkdlHBSkOaCymmHWI3dsnyfcEq2YIyaSE2+OoNEUNfrOY6tzHUIUOTWZ9vJDHa/IcabUafQgOXCAX47kq5s1lrMjV6J959IKegpCq9RVKWC3xZ1XmGkJlIZMAjyOTzJMzH/dY9SETl2xWiShHNcmXt6NqgsgSAnEUaDSgJcadjhNZlHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10629.eurprd04.prod.outlook.com (2603:10a6:150:207::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Fri, 10 Jan
 2025 08:53:14 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8335.012; Fri, 10 Jan 2025
 08:53:14 +0000
Date: Fri, 10 Jan 2025 17:59:08 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marex@denx.de>
Cc: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>,
 Viorel Suman <viorel.suman@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiDlm57lpI06IOWbng==?=
 =?utf-8?B?5aSNOiBbRVhUXSBSZTogW1BBVEM=?= =?utf-8?Q?H?= v3 02/17] firmware:
 scmi: smt: Interrupt communication enable
Message-ID: <20250110095908.GC23168@localhost.localdomain>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
 <20250103-imx95-v1-2-6744df5dc020@oss.nxp.com>
 <1bc61bdc-2ecd-4705-9873-8e0e3257a6a8@denx.de>
 <PAXPR04MB964475AEF1CB007B5949088CE2102@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <dbfd7a78-06e3-4e42-961c-5130f1707f26@denx.de>
 <PAXPR04MB96441C57A9F06EB21FF1FF59E2112@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <5633e9ab-0841-4f1e-9810-743359ac9107@denx.de>
 <PAXPR04MB964422B7AB4E75400F36C017E2122@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <ab77f12a-35b3-4b26-a801-3db315aea1d2@denx.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab77f12a-35b3-4b26-a801-3db315aea1d2@denx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:196::16) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB10629:EE_
X-MS-Office365-Filtering-Correlation-Id: 260ebacd-27db-434c-a5f5-08dd3154383d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RDNLMGppNTE2S3Z6Tm1uSW5Eb1lGUGkxRnBPQzdnNXNlNlpCdnFka1RIUmtM?=
 =?utf-8?B?SVVOcno2Kzh6UE42VG9lRlNSV2xKWlgrTmFjSUttNmsvTnVZWTdKU0ZLUHBH?=
 =?utf-8?B?V1FKSFA5ZWhmc0xLcEcwRmtoSktmK0EwZ3pVM0x5SEloaEJSNGJKTXdoVFNR?=
 =?utf-8?B?THRYOHhOd3lldUx4djRPaTVUbmlweWt4MHFPdTF6NEFjYVJRRjJsUzBacVFm?=
 =?utf-8?B?eGdqM1NQUzI2eDN5OTh2c0gyNllxd2xPRHFKOTJraXczaXhPS2JXTGh2dHNQ?=
 =?utf-8?B?dHpKT1duK2JKc0VZUTNDUUhYSHBkay8zbU8yTEFjQ21zMVBtYzNnbFBLVVNp?=
 =?utf-8?B?S3JXSFRjRGFwNXJhYVpndGxKdFQ3MlQxbWwrMmtJdnBjOHhHaFArYitKU1No?=
 =?utf-8?B?TXFkbGhKUzlyK2xiZWpYalRCOGptb3h6czU4QUxxZ3ZOWXZtRlZaL3M5NlZw?=
 =?utf-8?B?V081VERoR21MTEVGOVJ1U2NRWnhabUZyeTVTMU1OL0NXVFRRb0hUSERrL0JS?=
 =?utf-8?B?MVU5YlhQVUd6amZ1cGNRZG5SU3BPclUzVU1RRUpKd2x5OWNtWXZtUm9QNFJC?=
 =?utf-8?B?cjNsOThkYU44dUFTQ1JrUGpPY0JxR0hxQkxhdG5LYS81K3JDY3pyN3I4Mm4v?=
 =?utf-8?B?QzdVdmZTR0N4UFRXUnVyZEcxR2xTam5IQTJ5dnF2L1hjdjFTQ3lLcnhldk4v?=
 =?utf-8?B?UE5sQTZDNVhRU3Z2SVR2c2ZWT2c1dnJEVVUvQTFoek1tZlFpNVdDVnY1MG1q?=
 =?utf-8?B?eEtUdXdFZ2Y0SEwxNjVaU1JVUklDM05LR1ZoOWdYVnhQZ3llbGxTZHJTQ1dE?=
 =?utf-8?B?Q3lsVUVQZnpWbkxPdlhzaVBJaWYyVDJPWHhZTnVKdk1DSzZobkxhSE9QdTV5?=
 =?utf-8?B?VkdMdzFnV2ZhMEJiRGROOHN4NmlpRXFtSFpUWW5nK0NvL0ZoR25MdUk3emNu?=
 =?utf-8?B?VXUzTWw2NkFUNEdtR0tYSFF1aUhnM1gyYWtubFNyWEtRcEtMdldtTU5maVR2?=
 =?utf-8?B?QWg0aERxZDd6SEtjcTM2UGxtM2sxWHZDMlVwRkszaHhGYTd3TUJBOTFocWxG?=
 =?utf-8?B?Ym5oNEMyWkVQcVh0SXpYL0xDM1pYaDMvSG1kSU5RL3lEZXlyUE8zckRRVlpI?=
 =?utf-8?B?bVZaS2d0SGlFaWRuQUUzbGV3U0lGc0w0Tk85ZlowbzhiZVNLS0FZY0JzRXN3?=
 =?utf-8?B?SWFrbTRvTFRIV1RhWVpleGFiUHVHMlp6VjFlL2Z0ZW5vemxpWUV4WVVueXJC?=
 =?utf-8?B?U1NZeEpGMzltZGNJeGpod0RITnZ6MHgydGJFZ2xMeEIxZlQrZHVVYjZtYUxm?=
 =?utf-8?B?YU1qYnE5L0cya2NLM0d1Z2NpTzhDckdrSUtFNkZBNmhrTlZWTUdZUTlIZUJq?=
 =?utf-8?B?eDBQQldGTDc4MVBmYytEdGZvSFFoWWVVT3orK2NyMElsNHVpWkJjSGl2SEJy?=
 =?utf-8?B?RWw0T0l5SXlrYVF6L0RRVnNPTm9ld3ZjVDdUeUtOdEVaQ1E0M3NuS3J2QlRl?=
 =?utf-8?B?dnVWaHpaYlVUUHI3cStQM25zVHBFbmVjOTBQOGZKbWNDUjVLZkRvOHZFQVRk?=
 =?utf-8?B?akVKa2loMm9ZcXdDY0FyNGxvVENMWTZpK2VVb09Jc3JGMi90MWVYaGl5WjAr?=
 =?utf-8?B?ZFpUbmJ1b1pHNVA2ZnZCZktFa2NjSm55YVZSd0s3YzFldU5IMFg0dHY5dnph?=
 =?utf-8?B?Wmh1dUxKTTRNN1l1d3JTbDRzMXpaWDNZRDIweFBWWHpIN210MW9CbkZVUHpF?=
 =?utf-8?B?WVUzS3lNSUcrZll6N085eStvZzgrZTJ2QmpCdGpuZ3JaMkN6RW9CKy8rMGl3?=
 =?utf-8?B?em9kZnMyQ0lKUVNwYTdDQ0V0MFZvcE1zWVEzMDlsQ0lNNlBsTFZGL20wa1lZ?=
 =?utf-8?B?Sm5lM3g0NkthZWF2UDFyTmpJaFBwdVFDcEhVQjh0UjBhejA5eHZTZVhUanVq?=
 =?utf-8?Q?30vx3YcrU+KD2xCl4dTMqNeBQv2XhX6P?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlRvMng2V2x0VDA0Q3drelpUaGtYQitHNTR1WkNsMzJUM0dWN1g0SVBwVjB1?=
 =?utf-8?B?MFFubEYwOTh2Q3RHWWNTN0U5aXpkYmlacXVVOGZJeHVNZzc0NkFYRXJSWlZk?=
 =?utf-8?B?azlnMGxBbTUxdVk1VUNlN2NZYk9UUWVYVUtsVlVtc2pLNm04bFk4d2U5QWlG?=
 =?utf-8?B?Z3U5a1Z1c0w4SUQ3eW0zeVBBRkt3b3lkWVJpbmdTcEtzY2pUQlBhV3NxbGpG?=
 =?utf-8?B?UWxhL2lVSUYyZ3pVV0ozOWRueGp1MFhlVVZrdXV1RFdOS2NVa2VMNk5WRE81?=
 =?utf-8?B?NWdiMnZtZzgwaUdMWld3ZmtVUVhHUlNrakxWZDFBb0RvUHI3NHUvcFlSNExz?=
 =?utf-8?B?WTF5eHZQT0JKUlVBdmQzMEhjV0RtcWxyeDVaTllwSGREUzdhQWRuZ0Z2SWhh?=
 =?utf-8?B?ZklnV2JQVVowdlA2eDJmV0lnZVNnckZGY3Rhd2JacEZTK2NYVkMyaFMwOW9M?=
 =?utf-8?B?TVAvSlVzMzJib0pIaEVOTDkxL09MYVBob1QzaW1KdlJRaVcvMUQwSWM3SzlE?=
 =?utf-8?B?L2ZDYngvSExCZURhWFhqS25ncmdTU2FwRXh2QThNbml3RGc1UTQ0VHkwYnlL?=
 =?utf-8?B?djA4ZFhpakR6UElTakRpZERBenNKSzB2UWhjRUVTVDJoQXlKWmRvb3VKYU5W?=
 =?utf-8?B?SUhxUmo4Sm16eXRhbjZ5YmtKdHFoODZwYzJQRU9jY1g4aERHa3hwRUVRRVpl?=
 =?utf-8?B?MzE4bVNWazRkWFpaaU5zOFExM3JsUkVHLzJDb0RCU2tVcUpDNTdXc1c0bS9V?=
 =?utf-8?B?ZU5zc1Z0aUZQYTRSandYN1N5NGVYQTZEK2tXcENaSjdCQ3p0YlVzbXNNbTRr?=
 =?utf-8?B?eEJtYWN6SEovS1hsb3FuaDBUSTFDWWdIU2tjUERxRVBEVjcrYjdoMVJJaURk?=
 =?utf-8?B?U21SbXJLYXdQWW12Mld6R1VJMVVaSDFMbm1ZYm1OckRCRC9USmptTmN4K3Zt?=
 =?utf-8?B?V2Q1d1BndG5aZ3ptd0hrSlk1Wk83NVZ4UCtxSFF4UDk4RjNScTNmT0FnZ3pK?=
 =?utf-8?B?M2t0K3NrZldDcmpyajUzempkTUpYU3ZmZm5qT3pBTEhScG9oYWVQYktPTTFq?=
 =?utf-8?B?cXhZK1BiQmpicnJ3UjZoU0dKYW1rTTZVV3lUWUNObHRqUm0wYzdYejIrSWVa?=
 =?utf-8?B?UXlVdlh0TjVVQXl5dlIvajhvUVdkY25md1lOY1hnK1MyZ0JwSDAyZGNFbWNC?=
 =?utf-8?B?am05SExvZlJvQ1QvRWx2WkI5cGJHek9LUXRlbnM3Sm01M2c1dkkzVGlBWFdN?=
 =?utf-8?B?RnlmQjVITkprOEp1eERGZmNRVFJVS0ZybHVBVERKL2tmK1hGNTlSUXNOTlFp?=
 =?utf-8?B?TDR4c21sU0N4N2dBa3VrWldYUlFVS2JWaVpqWU1SVkJ6V0ZXbWFjczNtazZ0?=
 =?utf-8?B?b2NkMDZCZCtGVmV3Wjdid0hSMDMzKytGUjMxUUUzLzZXd0JnMjZpQ3BSWmdR?=
 =?utf-8?B?YTltZXFETUx5Y1cyUTV3VnE3Wm5Ka3JZVUxrcTZZK3dTZjNmMHF2R0cwV2Nx?=
 =?utf-8?B?c01YNWhIc0ZYanRDUHVZNDd6N3NFU0Z2ZFBETTFad3N6cytmYjhFMExRbHZK?=
 =?utf-8?B?dXgwak5FdVk0UUk3OERlSzRaMUx1bjNqK2tHRi94d3E3RDNETTl4SXhuZ3p5?=
 =?utf-8?B?a0pWa3N0SU5ZUGZFb1pSV3RoemZpRWtaaTZ2M2h1Wi9nWnNibjduZ1VNMUVK?=
 =?utf-8?B?YnUweDRsVExXMzhEQ0NUUmJlKzJwRm9XYVpJa1ZaSFlubzl2NStTcS9HU3NU?=
 =?utf-8?B?RHA3MmlFRGR1TWsyTStmd1RnSWJvQ0lMZTNhQ3FFLzZ0UjZlVjhVY04reGs1?=
 =?utf-8?B?ZzlPWVpYUGIzMnpZdWxta01BeC9wSUtuMDFMbFRxWHk1a2JWVkowdXY5Ukkz?=
 =?utf-8?B?V2d3VWk5cko0OVRVcVdXMlF5YmJhdXlHWU1sT1g1RUZKQS9IamI4Y2ZaNFlV?=
 =?utf-8?B?QnI3QXZMUVB1YUlET3NkTGtwRjJvSlJ1c3RoTEY1ZjRCNGJPZXFvbXRwOEph?=
 =?utf-8?B?UmpwTmZ4Y2NVNDFrdkl1MFJ1cW5vMXhWQ0wyMDNUalZzNmRXRXF0M0llMWQx?=
 =?utf-8?B?NG9IOUpPQkU0N1AybWVkelAzK2VxQTlFSjA0ZEJYRTE4aDVmWW5aVHhDZWpC?=
 =?utf-8?Q?vgwsc73fRxA/xaEL+hQeE/rsN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 260ebacd-27db-434c-a5f5-08dd3154383d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 08:53:14.8258 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /QSPSwhTEzwLZpHr/C00gmb+o8R4BJ+Cha7b8LcJX5fd2NsmRUJYugbOMPudkjJFlVLlJOpN5krjlz08z+Z0Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10629
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

On Wed, Jan 08, 2025 at 07:38:30PM +0100, Marek Vasut wrote:
>On 1/8/25 3:55 AM, Alice Guo (OSS) wrote:
>> > -----邮件原件-----
>> > 发件人: Marek Vasut <marex@denx.de>
>> > 发送时间: 2025年1月7日 19:11
>> > 收件人: Alice Guo (OSS) <alice.guo@oss.nxp.com>; Tom Rini
>> > <trini@konsulko.com>; Stefano Babic <sbabic@denx.de>; Fabio Estevam
>> > <festevam@gmail.com>; dl-uboot-imx <uboot-imx@nxp.com>; Lukasz
>> > Majewski <lukma@denx.de>; Sean Anderson <seanga2@gmail.com>; Simon
>> > Glass <sjg@chromium.org>; Alper Nebi Yasak <alpernebiyasak@gmail.com>
>> > 抄送: u-boot@lists.denx.de; tharvey@gateworks.com; Viorel Suman
>> > <viorel.suman@nxp.com>; Ye Li <ye.li@nxp.com>
>> > 主题: Re: 回复: 回复: [EXT] Re: [PATCH v3 02/17] firmware: scmi: smt:
>> > Interrupt communication enable
>> > 
>> > On 1/7/25 4:24 AM, Alice Guo (OSS) wrote:
>> > > > 主题: Re: 回复: [EXT] Re: [PATCH v3 02/17] firmware: scmi: smt: Interrupt
>> > > > communication enable
>> > > > 
>> > > > On 1/6/25 7:17 AM, Alice Guo (OSS) wrote:
>> > > > > > On 1/3/25 7:45 AM, Alice Guo wrote:
>> > > > > > > From: Viorel Suman <viorel.suman@nxp.com>
>> > > > > > > 
>> > > > > > > When interrupt driven communication is supported
>> > > > > > 
>> > > > > > U-Boot does not use interrupts.
>> > > > > > 
>> > > > > > > , the transport allows
>> > > > > > > the caller to choose between interrupt and polling driven
>> > > > > > > communications. To make the choice, the channel flags are used.
>> > > > > > > i.MX95 uses interrupt driven communication so that Channel flags
>> > > > > > > should be set to 1.
>> > > > > > 
>> > > > > > How does this work in U-Boot, which does not use interrupts ?
>> > > > > 
>> > > > > Hi Marek,
>> > > > > 
>> > > > > The clearer explanation will be added in the commit log.
>> > > > > 
>> > > > > This is based on Arm® System Control and Management Interface
>> > > > > Platform
>> > > > Design Document Version 3.2 (Document number: DEN0056E) 5.1.2. When
>> > > > Bit[0] of Channel flags is 1, the System Manager runs on M core will
>> > > > trigger general-purpose interrupts to A core. U-Boot polls
>> > > > General-purpose Status (GSR) until GIPn is set.
>> > > > If U-Boot does polling, why does this bit need to be set, shouldn't
>> > > > the bit be cleared instead ?
>> > > 
>> > > My commit log may have caused your misunderstanding. If the bit is not set,
>> > the System Manager will not request doorbell interrupt. The following is the
>> > code from imx-sm:
>> > > 
>> > >               if (callee)
>> > >               {
>> > >                   /* Generate completion interrupt */
>> > >                   if ((buf->channelFlags & SMT_COMP_INT) != 0U)
>> > >                   {
>> > >                       status = RPC_SMT_DoorbellRing(smtChannel);
>> > >                   }
>> > >               }
>> > Can the SM be updated instead ?
>> 
>> System Manager not only interacts with U-Boot, but also with Linux/QNX/RTOS. System Manager cannot be changed.
>How come other SCMI providers (like optee) do not need this kind of change ?

Here to i.MX SM, this is just a doorbell to tell remote side that info
is ready. To U-Boot i.MX, MU GSR set means SM sends data back, so with COMP_INT
set, U-Boot could poll the MU GSR bit. Using interrupt here is not that
accurate, it is just a doorbell.

For OP-TEE, it is using SMC, it is sync transports, SMC return means SCMI done.
No need polling any bit or else.

Regards,
Peng

