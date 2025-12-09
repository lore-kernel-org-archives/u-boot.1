Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA81D3B7EA
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 02:48:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65F0083B7F;
	Tue,  9 Dec 2025 03:48:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WOrOXTnU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D48F283B81; Tue,  9 Dec 2025 03:48:19 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E55DB83BDD
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 03:48:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BVH0vA4JcyzblE3tccw8TBJezI8ecr8zeXJOVqxUJMukN1hoJFgynIyk9NYlB+6Po6NDxK+KAWy6qW/byu4Xdxw+yS1JcZ0ZStBb5R17pSeZxEz8NPdzEKBY6gYdyQVhsqQcdldO5X1923x4LKw2GEQW+ZAZVdMih+PuRAYKK0H3g+plQajr2GAn1VjDgwJb2gHtUo/pJCYfwJEIzKFKZu3RGjPpioYyT1E7acehPMlx27bplZW8GsbWHKZOz/ySrg6kUe5QBs736ElqY0y4EOWwtcvvLTzWtioTfyPn7AJ0ff0zQrX8ieGBocdBT+yWkhvJtVu8pT3ePM3RaKHJpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8cnXfpTy7wEPH69YFRM4Q6Hsu9P1nc2f0PAAhQuX0E=;
 b=ZBE1R8PSYLnFY4jv+zpMwFkoRoLDRkvMBmMKwzvhzygqtN6KG+YsLh6isdA+thX892A3lvvt8ivQHJRg4x3kgsRvRueaVPymih7j51CU5zt+Cbo7zI9REcr52yUzuJY2+R6ZXlNWYbn9bebHtmI1XO310+5qtTJV33M2rglIniADeScFTGzK/D6Vc78Fhhue+bWpV6wVXsI4Z1sJVMaFAvLlOuXfT6bD5d6PGRWkZc4ctrZzq4ziuxwCjUyjljkyDgFlh/p2c847LaTVQtSFul/niLZ/xL9mdmqh/w3hhUm/VzujT+hWYmpfYWXulVzCcHs1RxaruxJVmIRSayOpFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8cnXfpTy7wEPH69YFRM4Q6Hsu9P1nc2f0PAAhQuX0E=;
 b=WOrOXTnUcWjPA6yPsmrUDmb65V0UZokTkmC4k+HkxSUE42gM9OrQ67Joo7V1raT5+GyrQHTcbp/LQ9pOYo+cOGXNTEUxyf3b+2twa7hNpU1wnf5I1LTZw2gmvMvM4QeAa15Fj6ZdnxS5EltVOWZ5K4xpohkfzENI7CIjxohLSeyBs3bmNnAEDLltMukQzDRqQP/9dcI8gT3CDrpiXx0wWDK4h2caesQCsPlpBTYSl2wGoE0Vwq+UUeykm2RNIDgfd22JioIc8cLJVWhi7GhaqUW7z2RQYG5mdw4VLMcy4wScb4N/vddfYKEyJzxlDs2AHpH6iYW7xzEJ5RE8M2rESw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU4PR04MB11897.eurprd04.prod.outlook.com (2603:10a6:10:61d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Tue, 9 Dec
 2025 02:48:15 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 02:48:15 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 09 Dec 2025 10:47:09 +0800
Subject: [PATCH v2 2/5] usb: ehci-mx6: Replace fdtdec_get_addr() with
 fdtdec_get_addr_size_auto_noparent()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251209-imx8ulp-v1-2-97e76ed1d967@nxp.com>
References: <20251209-imx8ulp-v1-0-97e76ed1d967@nxp.com>
In-Reply-To: <20251209-imx8ulp-v1-0-97e76ed1d967@nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Marek Vasut <marex@denx.de>, Marek Vasut <marek.vasut@mailbox.org>, 
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tim Harvey <tharvey@gateworks.com>, Peng Fan <peng.fan@nxp.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Stefano Babic <sbabic@nabladev.com>, Lukasz Majewski <lukma@denx.de>, 
 David Zang <davidzangcs@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR02CA0098.apcprd02.prod.outlook.com
 (2603:1096:4:92::14) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU4PR04MB11897:EE_
X-MS-Office365-Filtering-Correlation-Id: ad50d289-6cdd-41d9-2c6d-08de36cd666d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|366016|376014|7416014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RW4vZDUweTV5cVVwRmh4UXU0UlJiOVAvSmJ6aW9RWC81a1k0UWFaenQzUk9u?=
 =?utf-8?B?YURlY1dLNjZMUGZsNUFwTnJxeXJleG1qWTFhc1FvZVpQOFZ2NGVTZlRQMlJI?=
 =?utf-8?B?ZHJWS1I3RitwaE90UjMvY0JqZXprTGt2K1hFWlh5aGlRUDYyM1FEZFF1L0V4?=
 =?utf-8?B?RE10bDRGa2FLVm5KL2MwTVJjWDJoeHhYWWRCYjFjNzVRZlNRUytPQ0c5aUdT?=
 =?utf-8?B?RWcvaWlzMDh2ZTZIZ3RiT3FyQ2RFdXpqL1docFhEV2w0OU13ZUF6MCs5RDF2?=
 =?utf-8?B?dGs4bFNIcHdjNkxpWjhQeWNYNWVIV041S292WXZyS0w2eXZ6NzByN3QrL3h4?=
 =?utf-8?B?eVJrTGErcWhJbExSOWROSDZ3dXhnR3lXdzBRV1hvdXdZTlJqcHVldFdaRXNQ?=
 =?utf-8?B?U3RUbk9DK0ZkQlU3VWJPUlF3d1AvUnNrYTNpd0Nva0RNaS9PcFlxUEdpZWsr?=
 =?utf-8?B?R1A1UWFGdmRac3E1OG9RcjYzbkRSaEhnZVBjM0o4dlhYY29XbWl6TXNmK0RR?=
 =?utf-8?B?dFdaN2NOK1VHTkl6cStZTGdCcXJhVGxWTkhQZncyOTBXNXE1RW9HZFdXbkwx?=
 =?utf-8?B?ZWhtdTd1MGJDNWpFRHZrUVNySzZ0QkY1NElPODdoOHFXNkdsL1dGODJobXRs?=
 =?utf-8?B?eW1OUFR2UWo3S0pJSENoeEl2SllGY2FLWDdkWWpLY3Y4TTFsNkI2c1pCOVh2?=
 =?utf-8?B?VTFvWmZ2SGp6eDRIMFFKSTNpbnhGN0U4ZWMxaVNlU2syOUxQUFJneTE5WFgx?=
 =?utf-8?B?QVhrVVhCaHZiUHZSNEw3SmM1NklGSnJ5bDBwc3NlZXRMQkc1S3ZRd3ZlS1Ni?=
 =?utf-8?B?NVhZVi84UDdvR3p0dW9GeDQyZTBjT2haVFF5Ny9uUE9jd2VGakFvekowN2J4?=
 =?utf-8?B?MEJwNXZaNHFiZ1d1elkyd2VTMDZYRDYvcE53S3BlWTdmZitVS3RsdVQ4alFv?=
 =?utf-8?B?bU8yMlU0RXBnZUZtZXdPeG04aEx3MXUwN0VyWU8zMWJ4Z2s3WVJ1TForWlN6?=
 =?utf-8?B?NUtHYTFYWXVCK1pSRGpCZzF6ZzlVVy8rTkZsbzJLSG9KdlU5aUN3eXd1TjZT?=
 =?utf-8?B?UlN0Unh5d29ncFd0U2toZnBNZ0tvVS9ZNGswUk5hbWdFcG1aVGtzTXNhLzkx?=
 =?utf-8?B?bi9qK01jSFJ0NTdRZ3JRRG1LV3I1Q2IyNzFlN2RnL2VmOVUvTithY1U1a0Nk?=
 =?utf-8?B?Ui9KQWMwOWdsM2M5eGMrY0t6eXNjaEcvenEwbXdETHMyWFhwcS9wdHJiTFc0?=
 =?utf-8?B?RnB4clo2VmpXcTBpdjNZV2dwN21kZTVsbzB5MUpCQXk2dm1ieC9sYlNMQkRE?=
 =?utf-8?B?cWpaMTU2Vzh1cmlJSUtDclRHTDN4ZXBSK1lHTS9lWEUxall2dmltbVpKdmVv?=
 =?utf-8?B?L2FodC91SmVvMHZQcFF3bFpvcDBGY1ZlT2gvcHFiNjJpb2t5MjdyODhDS0Fr?=
 =?utf-8?B?RFFuUzIyeWpFcFVmSnhMYUxRcDF2dzR1bTg3YWxoVEdaRnZ3bVJNd3Y4Q3da?=
 =?utf-8?B?Z3dNdmIyaEppMEhONmhmY3pUV3p5anl6eDZ5RVBGMzArU3FzUVV4SG1zdzU0?=
 =?utf-8?B?TUQxUmt3VUhUUElQaEJKSW5mVWFySzFuTGhoR203UVNJdWlhbzAwSWE3T0RP?=
 =?utf-8?B?czU3TGVOck5lUWhYTDlNKzIwTzZvVjlYai91bGlzZVAyY3RiREEvcDF2aE56?=
 =?utf-8?B?Y05JWi9hMGFsVUJEUVB1UkFkVEU5b2JrNEJ4azdCaTd1RUE5cTBNSGNuSzJW?=
 =?utf-8?B?eE5wQWIrbEV0cUZRSkdLSGJHLzdkWlY1TE4yWVVNaGZzR3RlZU9EL0hOb3lt?=
 =?utf-8?B?Q0hzMVZsMkZHVzZOVVpDcmZXUG5BUnpZdVEwSmN1T1FjajViY0N5YWlXWC9R?=
 =?utf-8?B?TjF5SGxEeFAyMFUxVmJBTW9MdFBpaDdxcXViTkladm5mL2xRWjNWSkRWbmYw?=
 =?utf-8?B?dGdsaklpZGJjaFExcGFWbmMwSFA3VlhzbUx6Y0ZUb3VkQ24yNmhVRW5BelVp?=
 =?utf-8?B?SXNLR3dDK3RLd2VwMmZnem1BN1JxZS94OUdaK0c0d0w5UWhTdnVBMUhQc1Vh?=
 =?utf-8?Q?Z5HDzU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(366016)(376014)(7416014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjNCUEwyeE02K0gwNXRVUGRmNmR0THNsV0luSUJ0bUtaL2tyQnRXeXVwbFpl?=
 =?utf-8?B?MThzUHdEazVGOU5qVnlrbU5DeWtqcVk1aGpnODZHbVZBcW9vUjZBSXdKSHRY?=
 =?utf-8?B?RkdOYnNJMW5Ia1hVVFYxVHZieGpvY1JBSk1YUE01bU1TWk5yVUt4aVFnRC9X?=
 =?utf-8?B?RDdWZkdYMS84UVUwOWFnTk1DalU0OW8rRUxncXNrTklMMjFDQkV4QkNoamNS?=
 =?utf-8?B?M1pUNTNaWTNJaU1veDhab1U0akpRL01jOFRkM0ZMNDZnLzdPMGJEQVhwRmx5?=
 =?utf-8?B?Mi83MmtiaWV3QmU5dlQ4bFdUV3BFa1RKMFBVN0JqaC9STmpJR2l2TFdnUWZs?=
 =?utf-8?B?ZHBxMjhrMy9wK1owQlIrODVodXNxUUZEZFJIekYvTG15WWh3cHl1THBJc2oz?=
 =?utf-8?B?NjVSNVJyWUdVcVA4SzlXN3AzamxZK3hNTVFzeS9FRVhlZTdyb0dkMlFRdExK?=
 =?utf-8?B?dzZXMTRLL0dQV0VFSVI5bWRUMFhTSCt3QURkVVNlejEwOE93L1hBN3RDVmlk?=
 =?utf-8?B?YS9kL2FUK2c4bkQ4R1hkMXpYd29tZVBDVGRCQXJQQ1RaMHgyS2pQSmZ0WE9z?=
 =?utf-8?B?VHZTdlViYmF5eVd0Z3Z1czFvTHhsSWRCV05CQjcrTzQ5dzdsZVJ6NHVZYmhH?=
 =?utf-8?B?eEdmYTdhMHlSbDZkQTlpVlJyN01RY0MxY2RyUmdEYmFpYnc2a1dYYmF6TTVh?=
 =?utf-8?B?SnYvdjRGUS9CSnplNUlFd2tzOFljaWNjSFlRSGtVOEtZY2hZM2NqQ0NpUlF0?=
 =?utf-8?B?SW5LWjlzQmhYaUUzZHBLbVV5TFVKK1FyRUJzVXY2NUc0b0p2UlBGRTRISVB3?=
 =?utf-8?B?aXlkZjVjTVdMR3dUM3FFbTQ4RWFUSUJKNldyVEdPWHFKdXY4bkl1bDlpbE50?=
 =?utf-8?B?cEpHWDBKQWpYNW1GaWgvQi9CcWFyYy82eFMrRmFYUU5RWVd2M2w5bFYzc3JN?=
 =?utf-8?B?VXRhaW4yZW9UQWhzOWc4SlJSb2VTYlhFNytVYVRXU0Zrb1BoOEM3TlQ5UlIw?=
 =?utf-8?B?dGxFOU0rNngzMVB4Mm5McTcrY2toRldtMDl2WTg4Y3dnSlBJVVlvV3JQK1lY?=
 =?utf-8?B?Z0ttcjRZK3ozOG0rYU91cTUrTEhTSG1YdTVncmFSdXp1djRHd0ZSWU83VUp5?=
 =?utf-8?B?dmNPR1cwUGY3dVlUMTN0KzBwWC9yT3B3MlI4bUI5amZCV3ZuNjFmOWRMRndl?=
 =?utf-8?B?eVNsYXhqMGdKYTFkOGVmUDU0YTRvV2NlaGYycDFTZWtTcVlsL1RvYUhhbVA3?=
 =?utf-8?B?M2ZGY1RoM25XMnU4NWV0bjZKVUltVEVpV0UyQ2wvcjZDRW9YZFk3UnNFN2NN?=
 =?utf-8?B?ZzBERjZnTWdoZk91bjdiNjkyMXg3Q2VaemVDWmhxdTBOTkxsaXRnb2FuVkJa?=
 =?utf-8?B?R3hTb2V5QnpuTFByTTVQSWxKTkgvbDBGK3cwQTl1S0k3SDNxT3lCVklaLzUy?=
 =?utf-8?B?c0xCbkZVVXFOZU1HQUxhVWxHL01WaTh0VkF3azJ4aTlLWGVmdkVMS1Qwd0J4?=
 =?utf-8?B?czcwOVdYVCtJMk00QUpYYWNXZ3hYQlRPTXhYbWJjOTFPYVB3TEt5c2U0dGxy?=
 =?utf-8?B?ZCtFKzh5WW4wR2wxQ1ROMnlUWXBGTkhndVRqdERrQkhudmRRU1hTbTlwalBE?=
 =?utf-8?B?MkRUN0pJcUQ3c2JmZi8xTVplM3Q0Rk81ZDdHRTlqOEZacWUxcmlleWd6Z094?=
 =?utf-8?B?d09XeVFDelFVdXNwTkFjbFliQ21NUEVDUnpHQXN4QnBnTG1TNmZoNlNnbFVw?=
 =?utf-8?B?VUpFT0N0N1FmSDd4VHAwVDVJbWIyaS9yaWd4WnRoTmtzM0pjZ1l0WUxyYW45?=
 =?utf-8?B?Z0luQzFuVFV0RFRsbm1JUFNiS0dEdVJYd1BwZ1o0anVBSWExSkk1d2dMazhh?=
 =?utf-8?B?QWtXQW1aYjNqSVptVlVQOHlxejdkLzRNUXNWbnFMUWE0d2tWdW5yL3MyTWVR?=
 =?utf-8?B?Q3RSZUJpY3ZGRjYrWDBQbDVDY3lHRkkrc1N2REdLbFdwRnhvY0RLSHdXRE9J?=
 =?utf-8?B?a0R3UURpZC9MRnl3N0swK2JhSEpMWkJ5TXd6a2h4R2NTR3h2eGNtTHlMQlk2?=
 =?utf-8?B?YWM0QlNsK3FBU0N3YnBMYUJNZzNpUVlrM2o5Nlpab2FLZE9udnQzN3RaZDlN?=
 =?utf-8?Q?gMq6dTesTpCMse2GfoTRgJlmb?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad50d289-6cdd-41d9-2c6d-08de36cd666d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 02:48:14.9386 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tyANAx5rkLtaoOU49joEcz6hHB26Do1C0LoAeBvQxUUceNTH0GUMfkbguTnvrKp6o0T9wrDbVtPGSaOVvdyuVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11897
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

Replace fdtdec_get_addr() with fdtdec_get_addr_size_auto_noparent() so
that address and size are decoded according to the device tree’s
actual #address-cells and #size-cells.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/usb/host/ehci-mx6.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/ehci-mx6.c b/drivers/usb/host/ehci-mx6.c
index 1838ed252cc..fdaf1002190 100644
--- a/drivers/usb/host/ehci-mx6.c
+++ b/drivers/usb/host/ehci-mx6.c
@@ -551,8 +551,8 @@ static int ehci_usb_phy_mode(struct udevice *dev)
 		if (phy_off < 0)
 			return -EINVAL;
 
-		addr = (void __iomem *)fdtdec_get_addr(blob, phy_off,
-						       "reg");
+		addr = (void __iomem *)fdtdec_get_addr_size_auto_noparent(blob, phy_off,
+									  "reg", 0, NULL, false);
 		if ((fdt_addr_t)addr == FDT_ADDR_T_NONE)
 			return -EINVAL;
 
@@ -620,13 +620,15 @@ static int mx6_parse_dt_addrs(struct udevice *dev)
 	if (misc_off < 0)
 		return -EINVAL;
 
-	addr = (void __iomem *)fdtdec_get_addr(blob, phy_off, "reg");
+	addr = (void __iomem *)fdtdec_get_addr_size_auto_noparent(blob, phy_off,
+								  "reg", 0, NULL, false);
 	if ((fdt_addr_t)addr == FDT_ADDR_T_NONE)
 		addr = NULL;
 
 	priv->phy_addr = addr;
 
-	addr = (void __iomem *)fdtdec_get_addr(blob, misc_off, "reg");
+	addr = (void __iomem *)fdtdec_get_addr_size_auto_noparent(blob, misc_off,
+								  "reg", 0, NULL, false);
 	if ((fdt_addr_t)addr == FDT_ADDR_T_NONE)
 		return -EINVAL;
 
@@ -646,7 +648,8 @@ static int mx6_parse_dt_addrs(struct udevice *dev)
 	if (anatop_off < 0)
 		return -EINVAL;
 
-	addr = (void __iomem *)fdtdec_get_addr(blob, anatop_off, "reg");
+	addr = (void __iomem *)fdtdec_get_addr_size_auto_noparent(blob, anatop_off,
+								  "reg", 0, NULL, false);
 	if ((fdt_addr_t)addr == FDT_ADDR_T_NONE)
 		return -EINVAL;
 

-- 
2.43.0

