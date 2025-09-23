Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A0DCAC5AA
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 02:16:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 054CF835BF;
	Tue, 23 Sep 2025 04:15:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HFWccLMD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D65F83616; Tue, 23 Sep 2025 04:15:40 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 836D083211
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 04:15:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r6e7WELVF7BbiNdFbJgoZQLu9KWvvitGHcb5M9AXxQBKSvZXZk4no1yevpwdzV2jRBe1gWD2zfYwq8K1DUVw94fJxQQ+B4FfHuJhVj1HnfegnWMIgHCivhotIg7ZxbC9lu57IjkcK0+OHJFW6NryW09pbTvnxp99lc+8yYT+v9bXgWKefpB1tkXPWkAaWKlbTCtplL+Tivfdq3onhFEHFHayiZySt5cgQiVmsHyDYbVMRuFiWwzOk9My8Ggg+Dq5YGHgSVjvrNCzA3t63no0Bg00fWh+4SMuEQrofx1Cd3ODmnIWND5CLJTKMLfzbkcgPHy3CdgYiXy+88BN3LDraw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xyGYinnxbRdgZsnqkDsSY8cg3bkaG0qafWc7HujTGeg=;
 b=XqAYQVfhW+Uzri9svlxjuKaovvbJr72j+I6Civ+Q7S+x8x51k6w+lqoHKBf4GNTIv0+I6pTA9tDX2ayPn7p+OmxCv6TaQRoCuPB2/mjkDGCACzQvEm6rMpdk06kV3J8EWu5LCq3fIcrIdRpdEJ1GyVl4L1LYjyn/d9Xv9/mAVFol5UBGkn1XD7Gj/TyNOLJ8GBYRanMIkD66+SAZNR20W1psrMm8RvRv9IY7hB08XBd2SmbLUCTs8Tf1SuBJqtbpeGNRdsDh4PtYg2zlrt3syZPfCJApJW7eCNJ45yQ5II0FUg2PBhBt3vlHVWDMaFjq5G6nEIyqkt1k8Q4gb4pokQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyGYinnxbRdgZsnqkDsSY8cg3bkaG0qafWc7HujTGeg=;
 b=HFWccLMDmfXLBB5LAECquglpFgqU95z1Ik3ncVs+3/46XZ3m0KbR51sZ89gRuJkEWM2MY2X78osTTZ2Xk9FfcQs3aJA0/ZIDTb6gbAl3DB9Oycl/2Q6WH4ZznZShJBLJqvYS8DgTSPMMhBP1PNx7Iy5QWJNEkZgRWnAdDum1NoUFD81Gc1K9du1fqRGAkJLt9fviSjSnoRg3BTaL+f8K9mMdhFmg9/Q3HaVWj0T+HnvCJOe+7Ba1pzBsynXS5AN03Bxyi06o2CkylH4T0NhckM6fZ0VtynnJn4ZmILWvuKlfj38JafJyXeNGBF3R6rIyHnbz5nDiNDdLZnlDNsyTJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VE1PR04MB7469.eurprd04.prod.outlook.com (2603:10a6:800:1b0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 02:15:37 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 02:15:36 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Tue, 23 Sep 2025 10:15:00 +0800
Subject: [PATCH v3 08/12] imx9: Change container header temp buffer address
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-imx94-v1-8-cb3b65169048@oss.nxp.com>
References: <20250923-imx94-v1-0-cb3b65169048@oss.nxp.com>
In-Reply-To: <20250923-imx94-v1-0-cb3b65169048@oss.nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VE1PR04MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: f787cbf6-b271-42ad-3793-08ddfa471579
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TXcwaHRZQVo3QXdyV2o0QUhXd25QcHFvdGt3WkVZdDQwNHNGcHhmZk03WVQ0?=
 =?utf-8?B?ZW55ejdQRHlzOGo2Rktrb0QwYi9JVm9vbVpsTk9nZUM0TGpza2EzNGdRWGpI?=
 =?utf-8?B?VnZBMkYvWENyMVpic0tYRTBsbG9KYW12MXBwR08xaWtBdUFJYkUvMmlUZUFF?=
 =?utf-8?B?L1J3STZZZGZXSjlLODJud1NXQjBYSkl3VFlQUFcwUHlwS2dxdFZVSU9jb2N2?=
 =?utf-8?B?Ym8xVGsvUVpCc0RENjNGaVVqdzBLMG14Z2hJbGVEb3Q1NWJtTzJtQUdXTkIy?=
 =?utf-8?B?azBVMlY2OEovR1VGUUh2dHBleHgyUFdjcmxnWXI0TzY4OUMxNitSdC82bThH?=
 =?utf-8?B?Qkgxb00rZmdVZE5IZDBWRGJiQXUvaktrV3FKWGJ5dWtUd2ZYNVNoQWtLTGxn?=
 =?utf-8?B?Q2tFaExRRDRLbTllWXorKzBFaXpoTDBIdng2SG0zdW9BY3IxcXJPREp0YUJj?=
 =?utf-8?B?QVhhMXRod1pPcGorSjV4Qmhwek16aUFTR1ZrbVMzbGJxZWM4dFROMnFuc2pw?=
 =?utf-8?B?YXNCUTlBTnFSWDlKMDFwQUIvNUJKUkJ5eUxwN0ZXZW9GR3JaVlVQM1NYMlpm?=
 =?utf-8?B?TU0vbHJqRGt6UGtBajhocy82ajhuSHMxaHFhMVdMdFdDZFZ3by84QkZRV2xV?=
 =?utf-8?B?R2xCaTBTbzVDcE9ySXk5K0RnUHNrTHU0VFFjck9xWUpWRGtuVFRrY1kyY3lk?=
 =?utf-8?B?NXJPQVZ0cWVySHZSWXlhQ0JPaWFKdFNQQTVScHRSclYxbWhMT2VuSkhsNklW?=
 =?utf-8?B?WmRiRjQ4VUVlUXlDN0JHOWdoZkNNRlhBVWY3ci9lSUVBRUp2TEhKSkRrM09q?=
 =?utf-8?B?NUpyN1M5LzBUTDhSWDhBNHZhNythWTlEaDc0bmdOOFNZY3Q1Y1dKc3hJYU92?=
 =?utf-8?B?cDR2dyttL3NJMlNlMDVWSW5DTHh4S2thdzdSSFF4RkpheGYrZVNMbkRMRTRs?=
 =?utf-8?B?UWpsUmtCV3RrNXNQdkhNQWkxMTN2YVRVa2FZemYwUm1Ec1N5THAveW45UmM1?=
 =?utf-8?B?L1Y0RnVjZkRaV3BLQTZRaUZ2WlJCS1A1d3kvcjNpZXFac3hZQi9iNE82dmNJ?=
 =?utf-8?B?d3F5VFY2VEYwQm9WMExsd3cxdXMvL3RXZ1JkcEcvVmwzMk9TbExkK1VQQ1dU?=
 =?utf-8?B?TWhYTWtUQUh6YXpJYWp5N3lCS2M1aXM2dzZGV0xNZk1Ua1JUakQvWHN2RjZ2?=
 =?utf-8?B?T0Z5eFMwNjJtSUV0MGdGMU0rbjFlZlk4N2F3clJsUTVONlI4V3FnVy9lbWs4?=
 =?utf-8?B?blRDd3RCNEtBQlQwZzZocHdjaEZSOWIxS05pc0FOeVJpT3p4TkxCM2VZZWRN?=
 =?utf-8?B?aWhzU2wwMVZ0WFBvWGVHMyt2M1JzZmV3bUVaOGdIcmVCZmVOYUs0YktkL3FH?=
 =?utf-8?B?MXdCL0lCNS9CL0t3dEFUdTdmV0JQeXJRR09wbVI0Uy9JU1U5ZmZPd0J2VzJE?=
 =?utf-8?B?SUplYUZMSFlXNzRpa2YwTEtmRGx6anQ4SGgvZ0E3QzlWeTBUNVhuVkRTbWpm?=
 =?utf-8?B?SGpGN3BmdHhkNnJXTUpLcnNPa3BKT2YvU0pONDN3ZUxwaDQxMDkwSjF4R09j?=
 =?utf-8?B?T0hTNWNEQVJSNm9LekdzVVNlQjBseTlweFVsLzEvOEsxTksvTXM1YmJEVWsw?=
 =?utf-8?B?L2I2QmM2MnNLaDV4MktEUTR3UlJJUFJ1OFNqU1JPOEcrUWVvZExJeDZyNXZI?=
 =?utf-8?B?YStQb1VWbDliMUlwVk4xYVhMT1Z4djFlQVFjM1Zna05TRFZlN2FuYUNHZjRr?=
 =?utf-8?B?ZDkvU2xmbTAreDMrcm51L0dOTnJCa3R6M1VKRjlBQ1JRTDZVbTM1ZmpCYldl?=
 =?utf-8?B?UXkyTjJZMlhFYUJvK3B4bVkvT1FRMzZOTFl4elYwK0lBWGhRZmE5SzlKeWgy?=
 =?utf-8?B?OGhrNWZZRlg4bEJ5cUxwcnFoTnpqMURhZWsyd0FuOEdEcFVMN3duM0NIME9a?=
 =?utf-8?B?VjBhOHR2UVFFMWhHV1V0M3BNM29uMGh3TFJ3cmVLcXVlTFBsYkZHVkkzSGxK?=
 =?utf-8?B?UFFEUzF5aHJBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTBLd1FlQUpJRXFaY244aVFHc3g4OEVQV21oK0txR3BRU3o3S2VLc0xHdkQw?=
 =?utf-8?B?bVhzMHY5RWd0b1ViV1lsQ1NvNjd1NGtjdkQyakdkamVwcS9HZ2ZhN2dvRFMv?=
 =?utf-8?B?SjlldjhTQjFRTzU5cUM2ZVlZUnZUcWMwOGZRTlBaLy93QkpkZndBY1RDZ2JW?=
 =?utf-8?B?MzRFazlzV2pURXZKMUNVb1Vub0hUODZCM1h1UkZvSklOdGJxU3FObmVQc0h4?=
 =?utf-8?B?OFNKNGJwV2ZrTDBwUXR3L09ralY0bm15L05xbmd2S1FYU1MyYXNXbXNtMkJO?=
 =?utf-8?B?R0NjSTRtbm1vRWVucnJML3MzbUNOa29MWURUL3J1RDJocWZ3YWNJSjJPaS9G?=
 =?utf-8?B?cGpvQ0JobXdadGVuSlFBcG5kN01mbXUzaFpacVpnMVpucVRFZWdGemVDOUVB?=
 =?utf-8?B?cjRsaDRFWFlaVGFNVWhWalhQNDhSMHF4M3VEajhtUlhnb0w4bHdLUDcxcnQr?=
 =?utf-8?B?S3d3WllKcGZTdC9pSDF5V2E0THNDaS82cDlXdkJubDBwVHV4UGZjZDV3aWho?=
 =?utf-8?B?VjZMRTB2SUgyK2I4aFNJc1NvUDdTb1FMNGhYbzU3c2VOeFJGSW9MaFlHNW5K?=
 =?utf-8?B?N252Nmc2akJicDdPV09jZmJ0VXZYRXBFQmd0aU5SNFYvWW9yNVhKZzQyenMz?=
 =?utf-8?B?b3Zyb2F2Ukt3K3NSZysxSnVubnlFYnpOOWtseXdNa1ZWaTJBQkU1L1A2bVQz?=
 =?utf-8?B?NDVSK1dKb0Jna2hkL1U4UUoxZG9iRUVIZkgwbVdwbXdaVHdVVE8zQ0dnWHhJ?=
 =?utf-8?B?S3EvSndMUFBHWUVZV1VPZUZsUkI0V0ozdmpQRFdBd1o3a1ZRSmNnaG1BOURI?=
 =?utf-8?B?R3NKM1pmbzJHcG0wVEdMZjRXMHFLNHY1WkZ5cDFkbDJ2VHBJendlU3dQYlJw?=
 =?utf-8?B?dnFBQnhUQ3gwR3JseTBJUnM5RXRsME9tSFJJemxDK1YyTE1GQk9yQ0c2Yy9D?=
 =?utf-8?B?cXd2eGY4K29mTHUyM1pmVGNMNXRmZmpUdm4wekxhb3pxWlFYQ3lIemtVUW1r?=
 =?utf-8?B?UTBqdnJ0cjhDNmw5aFVJaHFic0YxekllWUpCZVgvR0IycGUxY2VzNVl3Sm9l?=
 =?utf-8?B?NlFuK2I3MTQzaWxVWTZxUnp0NnFMdW1qdmpGa0RRdjRpR0JEVUdoTzR6ZVlx?=
 =?utf-8?B?djBNY00xdWg0VUd5LzJCYmFTRlNpQkU0L3hFcXNOOGNoNk1idGwrZE1qWWRH?=
 =?utf-8?B?a0ZDVFpWQTBzSWw4aXJnN2pmSnhzT0RhRFJucEg4YVpvQkplWDU1MC9aVFp2?=
 =?utf-8?B?SXhucDkyb2o1MDkzRWZzVHRUeVlGMXFSZnV4M2ZJUGRTNmM3SFF3YXBZR1BH?=
 =?utf-8?B?cG9NbGdxTjUvNmEzd1dYK0Z5NEZRdFZRQ09Db3dzU0MyMk43OFIySUphUDNO?=
 =?utf-8?B?NGFHWXdFR1pzK25VS3pNNjNUNkN2WjZJQlZWejZqZjZVb1p1OTRCa25oLzF4?=
 =?utf-8?B?OHJpdDN2Wkh4WCszYXF1K1NyY3NjS2dSZmFwbGlSc0M1Z1QwNFdvUGhBdWlX?=
 =?utf-8?B?UWsxYjR3UkNiQWYxQTc4bDBsWUtvSHNSSUNmOG0xRjVZVmRWT3VBMG9SOXpx?=
 =?utf-8?B?cGU2WUliSitUdXV6NFE1MEhrRmp1ckRWYlpOTlFRUkxnYzZIRWpGM1pTek0r?=
 =?utf-8?B?d2wzbXdSL1BaLzRMYlE0WjZJNEtjM3lqODZEZ3NyOHlWWWh1YkR0M3c1YWxl?=
 =?utf-8?B?aE5CeEFCRFJQVEVDVlZWaE00azQ4N0V4MlRqNmd5TkFxbjlZaG1IU2JpVXZW?=
 =?utf-8?B?NjkvQlVPSVAxUFZiSkx0ajJ2ZUNhVUlTSkk5MmF6amlHYStYblZUQkh1b2g3?=
 =?utf-8?B?Qkt4VWJuT0puaTdYMnNOejJzVjRObXUzQmJLbzNvcGlVU3l0K2VmaDJsMVEx?=
 =?utf-8?B?NWNqMEJTNWhDV3RJVDZaTjV1M0p6VEllOXU3WXZLTWVvRkpZVmhWQ2U2aGJE?=
 =?utf-8?B?SUtid3NJTm9ueFllZXBNVWFIMFdXdVBINC85YitGYzFySXlEWGF6aXQxWTVJ?=
 =?utf-8?B?bVo0czlrZXd6Z0JHejRMUWwzVy8zd0YxTHVFR3hZUnE3Y0Q4OWxRSFIxTjZN?=
 =?utf-8?B?a1lGZUd5cTZyVVRaeDVoYWM4Tlp2RUFKdUNKWnFsa2JSTEE2WjhFd1pkenJ6?=
 =?utf-8?Q?i1rM0ZCAxGeYQdyBBYULq/nQM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f787cbf6-b271-42ad-3793-08ddfa471579
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 02:15:36.8476 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FLRrks0TYsBIU131bEjxZ5XGuYFZynE5G5LrPBvAGkAIQ6zO44IB3+a975l/QiGb3pTFb/69pLPJpumKkNdkxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7469
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

From: Ye Li <ye.li@nxp.com>

Due to i.MX95 has reserved first 256MB DDR, change to use the DDR
start address in u-boot as the container header buffer.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/include/asm/arch-imx9/imx-regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-imx9/imx-regs.h b/arch/arm/include/asm/arch-imx9/imx-regs.h
index a44fa6663c3..e641ed299c0 100644
--- a/arch/arm/include/asm/arch-imx9/imx-regs.h
+++ b/arch/arm/include/asm/arch-imx9/imx-regs.h
@@ -57,7 +57,7 @@
 #define SRC_MIX_SLICE_FUNC_STAT_SSAR_STAT BIT(8)
 #define SRC_MIX_SLICE_FUNC_STAT_MEM_STAT BIT(12)
 
-#define IMG_CONTAINER_BASE             (0x80000000UL)
+#define IMG_CONTAINER_BASE             CFG_SYS_SDRAM_BASE
 
 #define BCTRL_GPR_ENET_QOS_INTF_MODE_MASK        GENMASK(3, 1)
 #define BCTRL_GPR_ENET_QOS_INTF_SEL_MII          (0x0 << 1)

-- 
2.43.0

