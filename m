Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06048CA0EE4
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 11:05:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7926282F49;
	Wed, 20 Aug 2025 13:05:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="FS1j7fds";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4806801DD; Wed, 20 Aug 2025 13:05:20 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B10F82F03
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 13:05:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oKESSnKhoskiBLWSs+SAJ+s2WE3v221+9OZ7LjPk5oKrKV/z43lzgcc/FpotISVUl/JB3UnISXw0AnjINNUcEwPIKerIemjxW5jdf1jh7W5JIdTKaNU4bsmFtQDlkWO6ZfTrBeSBLs3mu5HCxdy9BqcB4ZwtsweBzRCo6WRfdvWVbF59M8b5kQF23LQBc9mBFGiwG1wksb60Y9TMcBXt35zXimLYCinwUqAxpCXwsTx6xCxWyWvdoojPSLlHX0bd/f8A5j53gTUUnnt8tMCLj3pidvGi170YvUmnzZzbdNQMLw/m4H0cKAjGb7kiTtd3ZyFOs96XV5MdWIflGDAeNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUoleuK47lZOxhkid3DcJ9WoSshTHvRCfuiFRlHHkFI=;
 b=kipvGqzI7PSCD7qwdIsYzzx8mkn9IlqBYg2nA32qNakS1mNrCQWY0ekTGufcoLlit7naxETNMH5ONha7+H1km0y0H6GePkuqOLesuYfy9JtoRg/PpyKhxtkkUqKWfV8/dSkaqDasw+5L0kOIKNrEGivXmmqg66hXRk8AIl4y26LjoSfaLkv+Djoiau1wJHKnhyYoLugM1D2g6GffhhqAObiB1IZhYqfmCtED3hLNs8rKBA7wEmx842A7H6sucysCyZ0b2AfxVqI33FeljvFJy7qYevpN+Rlrt1eWU/ixJ6HhKsOjuGDwwIlPYh9WF28Cg/RWmfSXqaQy6UgCOUsRAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUoleuK47lZOxhkid3DcJ9WoSshTHvRCfuiFRlHHkFI=;
 b=FS1j7fds9FOthCEkt1j2CqPui5qcnX+9Xty6N0ktmPZZsMzNTcf/NBRWKWWpn1pmAUV5fbIiZY70bwJDrpait247DoWBQsXKKiO98fjWyNuvnla0K5cUSrEekkrmKN0phoU3vHD8BYtperpI5ULKjzgsQ2sKaMXWIkjxlN/8wj00YcdEoKHkOiN1S6HEDDHo+2WwpUorM+CDGuNvMBB85JC+WVU0GutmPxAhO0u+Do4iLeB8zeX/V4g4fRjgOcQmC/U8jGjsy2PHcewEZBFr8sP90Rl7O27eXwvKxYburLmOdvdA5TOt1hS2DsL4cOHwSRhN5Vrf4DEs+Kx6MGCAow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by OSKPR04MB11365.eurprd04.prod.outlook.com (2603:10a6:e10:95::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 11:05:15 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9052.013; Wed, 20 Aug 2025
 11:05:15 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Mon, 11 Aug 2025 05:59:35 +0800
Subject: [PATCH v3 1/2] binman: add a new entry type to support .bin file
 generation for the i.MX95 platform
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-imx95-v1-1-569d8014172f@oss.nxp.com>
References: <20250811-imx95-v1-0-569d8014172f@oss.nxp.com>
In-Reply-To: <20250811-imx95-v1-0-569d8014172f@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR03CA0120.apcprd03.prod.outlook.com
 (2603:1096:4:91::24) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|OSKPR04MB11365:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fa2feca-e3e2-44a9-de57-08dddfd97104
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|19092799006|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cEdZcmV6N0cycmJudEtZNlBvQzJLcVRwRHlWOHhxcU9PdWFZdUlFSHJsQmJx?=
 =?utf-8?B?SGhvdHR2Qk84RTg2dVRocnJBTVJIcytjM0lTaWZMMmpLRy94c1ZtWlkyaXhk?=
 =?utf-8?B?eWRRUEJCYngreTgyT2FsRFB3SG9CR3lUaGZzYTd2aDZzNmFTbTFBZFZmdXI1?=
 =?utf-8?B?MElnVlErQjl3bG5TZDBFSHJuN1plTDZWQjJObGQ4ZStMOGlKN0ovRk1YajlP?=
 =?utf-8?B?bEFOVTN1SDJmTHVndVpHSmo4MzFSMzJPNXVsWldOcE9kamU2N0RFdTdiOTFY?=
 =?utf-8?B?RS9IT2FkL3dQYXNoRERBSHRlL2R2b2VhdTQrOGFYWjE2bGZrdzJNVjBzd2ox?=
 =?utf-8?B?dVN4UjFSUWx4NlAwTktnR09neDEyNkdhdXVtNU9hTTJMUkpRT08yRjI2UEkv?=
 =?utf-8?B?QTV3bm00ZlkxOFM4T2hjeGNZdXRuZlV3ZFpHWUVhd2g1Z1Rhckd4Uzdobk1S?=
 =?utf-8?B?Y1AvV1F2RmNLVnpqdi9lYk9rcXJyc2tVK1V1OFVDWkRLdCt1NXVBRnEzYUlF?=
 =?utf-8?B?SjVWeEFMakx4MnZUa3Nsc2IvU0pZN1Q3eUh6N2kvTjBZRlJUZTA1MkhnRVNQ?=
 =?utf-8?B?Yy9IWElGZUtyTlVBb2dET3VWeEwyS240eEV2Q1JWRVVWOUpDbWtrUzM5VkVa?=
 =?utf-8?B?WnJUVnhYQU9ZTGlyVW5aS1BEYmlmTGl1cjhjSW5FeSs1eElXU1dJNnVZNHU4?=
 =?utf-8?B?WDRQL2lQSG5oWFRxYVdVSFZ2SVc4K3htY1NkR1hFNlpCRVBmbkdkVGpJUmc4?=
 =?utf-8?B?RS95MmUwREQ4RTNaWURXUG1DdkxZMEJxckV2NzE1aWlKYzdROTBWR2dNcWhX?=
 =?utf-8?B?UHRNUVZkcXBHb3ByREVlb0JHZEM4UjlaaXRlaTJyNXZndStFYSt6OWUzTkNh?=
 =?utf-8?B?aW1yb01jTDd4L01RTDRtVW5MdlhDNEl2d0dBekFqNzczS1NQb0p0dDRqNXZ1?=
 =?utf-8?B?cGVTbm5UQnc1NnNoV21iRGNQQlpBRWhQZFExRFhacGZ0NU8zUGRLdEZTQzFy?=
 =?utf-8?B?cCtaNWppdG5Mb2E3RUhIWk1rcVVGaWphZ2xXNTRpREFTTEgrWEdESTFnckFl?=
 =?utf-8?B?NlF1aHI2bGErS3R6VEZTdkp0dXV6cDllcEFhd3pISjN0TFVSZTEzWFIrSGdX?=
 =?utf-8?B?UTM1TkNHQWtGTmhCQVlRZkFRUnVkMmkzSk1MdWdnaWhITEtBdFRMREpnaEVu?=
 =?utf-8?B?RWxYQm1xUlRYOGoxK0xUMkhCM3JjMXdPSWxuR3hpMU9vd1ZwV2JQMHEzMFFX?=
 =?utf-8?B?UDJaZW9lYlRKcTNWS0FTUXNPdGRpT1FrMWMwNmhCMkR0SC9oWmdHZGFFeW5I?=
 =?utf-8?B?VVg1d1RYZlhaVHBMVDNtTGo1YUMzUnFWcysvWDRnNEE3OE5naXF0OXYrSlo5?=
 =?utf-8?B?Y25rMW90T0VXN3BTQkg3Ym9lbHdueHVHSDhmeEtxaUdvNWlIZklFUm8ySVdH?=
 =?utf-8?B?elV0dXFGOW9DN05YVVgwSXNzVGF0U2Fua3pJODZ6UTR4dTFzYWlQaG5BQ2o1?=
 =?utf-8?B?TWFKZDkrMXVOTFRqMm5NOFY1NGQxUC9iYVBlNHN6UXJ0VHRsUC9VL2xDaDc5?=
 =?utf-8?B?S2VDVHRaNFhBbllGOXNEcVBhZWRhK0xBU2pKYk9kU0tEdkx1UnBydUJ6ZEJE?=
 =?utf-8?B?WmxiVTE1czRGWFBEUEZrWnFNNlArUEtqSTM4MzVPcUNDL2pvbFVGMU54L1JL?=
 =?utf-8?B?SjJkYVN3ajdRdEhCN1prNy96OXYwSDZKRzIyYVFacnl0YUcyTzNxZVRhdGxY?=
 =?utf-8?B?d1Q5eVpEMXB0cGdHeUZUYzNuaHFBd0hVejA0S1pKaXFKOXozZ3FLVkx4VjJl?=
 =?utf-8?B?TlMxWG1MQW01NEVXMFVTOEs1MytFOE5zWU9HZm9aWkJkcC9hREUrSklpR08z?=
 =?utf-8?B?Vm5MaU5Xamd2QnJaN3RLbHdFQk52VUQrSHBQK3M1Wi9uSXJ2aVlndTlDZjJ1?=
 =?utf-8?B?MmwzTU5vSVMrNXRmZnRXeVBPdTI4dUpDNnJpWHBPQjJXOVBjS3R6RDFxTFlJ?=
 =?utf-8?B?YndncUdsNTNnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(52116014)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?am41N0RCcFk0aTdQTFRDVm95L2hpM1NSYTJWZytBTUV2QVFLNVlwenJ1Zytv?=
 =?utf-8?B?TlIzdEZjMWFHS244N0pDRUNEbWR6WHpwU0daSFg0MTdsY1VraUNPZzcxMXpJ?=
 =?utf-8?B?SVd3aCtPckp2cHRoeGo0NEh2V3pCWWptMGE1TGV5R3QwR2phUVJMYUEzdXFo?=
 =?utf-8?B?azFXdVpXWE9hc2o2cEE0QlJncFdyNEkwK3NUbS9PcDZMQW9kN3I0RExXTlkx?=
 =?utf-8?B?c3hCTFRRcEs0L0hEV3J4bk9lTGVOUFNVUXN1YUNHejAyTFpscytSRzJyekFa?=
 =?utf-8?B?cHkxV3p0YTNmZ05mQkVJZFk5b3JyREhpc0JPL0JHSFJBN3FnNEJBMFI5MW40?=
 =?utf-8?B?YzlBczdSMnUrMUFvUDA5akIzd1VnUEhBZjlQRWtqYUZFb0s1RXZGSE9DWU5v?=
 =?utf-8?B?SG5oelFEWGwvR0dtNFFHVlhoVnpYRmZPQWlTcTExeW9nK3l3bGdyZjg5OUtW?=
 =?utf-8?B?c2lBSkk3VkRabkJjNDhJS3EzZjdrYWwyRDZaVUREdlRhdmFKRVdVb0JxVDFD?=
 =?utf-8?B?RUhaY1RLNVNpNDZJeXIrT0FSNmxqV1JUTnFnNDUxZEVQVE1BdjZYSTFhbzVq?=
 =?utf-8?B?bGdQQUdaKzJCNEMyUlFSQlV4SFFtTzJPNlFlTG1IbERhd3h6eXdSSUV3Qkhn?=
 =?utf-8?B?ZWJsZ0NRWndvV1g5MVpNNlZJclFDZGdJbmtteXkzU0cxZTNMMmRXK3Nkb0I1?=
 =?utf-8?B?VlY1SmV3SXlYYjFTdmR3cUlzUWdDNG5BTnAydldtRUcxcDNxQS9lQ0IzbjEw?=
 =?utf-8?B?WWdNVU9MYTVWTENxTHREMEJ3OW1QRFBCdyt6YXhteWUzRkVRMkh6WTJPWWlM?=
 =?utf-8?B?S09TZkRxTVZKTVducTRPMXJkU2xJcU5qc08rRUljTWFQQXJTRnNGSTFpZVNU?=
 =?utf-8?B?Zkh5b2JPZjl6amRkWjVpS3pZNktHSlBYZnlqT054eDRpNUhVMTREcXcwa2tn?=
 =?utf-8?B?WkJuVHBDemVHZW4yY3lOVUpFWmIvSVhCZmIzMS9aNGlrVmZ2RmVMN2pTQlZN?=
 =?utf-8?B?ZVIvbmdMNDJQVjhxbnNnM3d5aEhDYkE5VkF0VVpxWE8rdHA0RjlybXhNSW53?=
 =?utf-8?B?Z0JVakRhWDJzbTd5Q1NoL3MxU3FxU04rSk1aaDZXKzR3NEFmdDdHN0RsVHQv?=
 =?utf-8?B?M1B4Zk1nMEt4WGtaME1jK3pSUFM3WjVVSmZZOWhtQUVtRjJ4TERTSmRqMDNM?=
 =?utf-8?B?Y1htZ1dNOSsvT2pWYWt3aFNPMkVwNWYyOTRDTEZON2hNNmh5clU2TEx0UTJX?=
 =?utf-8?B?aFZMZ2hCSlR2TzdlL2JQcFFubytkTW1maE5seHNGdjZITURiejdmUkVzTU8r?=
 =?utf-8?B?YTcvUFVHMEFWV3Q2UStJZ3Z3TDhqNWczeXhidFJGS0h2RlB6Zno2elk2K1px?=
 =?utf-8?B?ZkVJNWczRmtYeDJEd2NFQ2tDc3pjbkxZNXkxZWtVaEEyYm9pWmZObHhyYjRl?=
 =?utf-8?B?YVM0NTBQc2x1YmdkUkJrVFZEOGhHaGlPeWZPdk56V24ybnBZZ0hQSzMyL0dX?=
 =?utf-8?B?L05qTjU5a0Radnp5c3h4alRaTVNEL0Z5bkpUQThtYXAzMThMWUxUOHNnWGhD?=
 =?utf-8?B?WWZBaUlwZCtvVVdPUlNLczRaSFRkZ0hqQ0d5dVl1akhUanQ0YUpzVHBuNkxO?=
 =?utf-8?B?MXcxbWh1OHpJWW9VMG1QYmtTWG1vR3FZK3BEa05EbS9vVlNGa1AwbmNyU0NM?=
 =?utf-8?B?RDFERS82M2tYQmtmZ1FWbnpJTDVaN2dQV3MxRzU0RmttM3F0elJpeXlDOWpP?=
 =?utf-8?B?aGtpV0d6VzBxdzJiUGNibnduWFVjY2NnUmd0UzlxdFpQVzkvS0kxdE9uc2JP?=
 =?utf-8?B?eDRUY3JFR2kvNVBaaHBVRmU1U0RjWGhOYjliZzh3YkVwMjJSWEliQjV0bjFw?=
 =?utf-8?B?YXQrOER4Z1FnUm55dXZUUXcycnBCQXBObDFEbi9IYXRDbE5kWFA1bVMxb1dC?=
 =?utf-8?B?MCtveDZUVTVNUnk4OE11UnpWVW5NMENQMFdNUUoxRllPWkQyZ01xSWJ2cFlh?=
 =?utf-8?B?cG1Jb3FOQXJHNlI3SWszOUdXTTIzTGF1MDltTVpNVWl5WlFYK1piOFJmYXFL?=
 =?utf-8?B?NEk1dVoyaThtNVo1ZC9kYm1RcjBDVjJjSmZJRTBnNWlXQXhnUCtVdTlxZW4x?=
 =?utf-8?Q?LqQRSofMp2V/yPyYMGSLFLbJW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa2feca-e3e2-44a9-de57-08dddfd97104
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 11:05:15.4910 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jsI4SpJxFCqQkoCuAb1Ef/bbYHrhblJ1NfTnuJUq+apMWugmRQGd+X+NkfTPtWe+yiHD+gVIiXEX2ze+VrA0Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR04MB11365
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

To support passing specific commands defined in enum imx8image_cmd to
the imx8image_copy_image() function, this patch introduces a new entry
type nxp-imx9image. This entry generates a plain text data file
containing the relevant commands, enabling flexible configuration during
image creation.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 tools/binman/entries.rst            | 12 ++++++
 tools/binman/etype/nxp_imx9image.py | 85 +++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)

diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index 12a39d070e4..8922d6cd070 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -1689,6 +1689,18 @@ together. See imx95_evk.rst for how to get DDR PHY Firmware Images.
 
 
 
+.. _etype_nxp_imx9image:
+
+Entry: nxp_imx9image: data file generator and mkimage invocation
+-----------------------------------------------------------------------------
+
+This entry is used to generate a data file that is passed to mkimage with the -n
+option. Each line in this data file represents a command defined in the enum
+imx8image_cmd. The imx8image_copy_image() function parses all commands and
+constructs a .bin file accordingly.
+
+
+
 .. _etype_opensbi:
 
 Entry: opensbi: RISC-V OpenSBI fw_dynamic blob
diff --git a/tools/binman/etype/nxp_imx9image.py b/tools/binman/etype/nxp_imx9image.py
new file mode 100644
index 00000000000..af893cf27d7
--- /dev/null
+++ b/tools/binman/etype/nxp_imx9image.py
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright 2025 NXP
+
+import os
+from binman.etype.mkimage import Entry_mkimage
+from dtoc import fdt_util
+from u_boot_pylib import tools
+
+class Entry_nxp_imx9image(Entry_mkimage):
+    """NXP i.MX9 .bin configuration file generator and mkimage invocation
+
+    Properties arguments:
+        - append: appends the specified blob file as-is
+        - boot-from: indicates the boot device to be used
+        - cntr-version: sets the image container format version
+        - container: indicates that it is a new container
+        - dummy-ddr: specifies the memory address for storing the DDR training
+                     data image
+        - dummy-v2x: specifies the memory address for storing V2X firmware
+        - hold: reserves a specified number of bytes after the previous image
+        - image: defines the option type, image filename, and the memory address
+                 where the image will be stored
+        - soc-type: specifies the target SoC for which the .bin file is generated
+    """
+
+    def __init__(self, section, etype, node):
+        super().__init__(section, etype, node)
+        self.config_filename = None
+
+    def ReadNode(self):
+        super().ReadNode()
+        cfg_path = fdt_util.GetString(self._node, 'cfg-path')
+        self.config_filename = tools.get_output_filename(cfg_path)
+        accepted_keys = [
+            'append', 'boot-from', 'cntr-version', 'container', 'dummy-ddr',
+            'dummy-v2x', 'hold', 'image', 'soc-type'
+        ]
+
+        try:
+            with open(self.config_filename, 'w', encoding='utf-8') as f:
+                for prop in self._node.props.values():
+                    key = prop.name
+                    value = prop.value
+
+                    if not any(key.startswith(prefix) for prefix in accepted_keys):
+                        continue
+
+                    formatted_key = key.replace('-', '_')
+
+                    if key.startswith('image'):
+                        if isinstance(value, list) and len(value) == 3:
+                            combined = ' '.join(str(v) for v in value)
+                            f.write(f'image {combined}\n')
+                        else:
+                            self.Raise(f"Invalid value for image: {value}")
+                    elif isinstance(value, str):
+                        f.write(f'{formatted_key} {value}\n')
+                    elif isinstance(value, bool):
+                        f.write(f'{formatted_key}\n')
+                    elif isinstance(value, bytes):
+                        hex_value = hex(int.from_bytes(value, byteorder='big'))
+                        f.write(f'{formatted_key} {hex_value}\n')
+                    else:
+                        self.Raise(f"Unsupported property '{key}'")
+        except Exception as e:
+            self.Raise(f"Failed to write '{self.config_filename}': {e}")
+
+    def BuildSectionData(self, required):
+        data, input_fname, uniq = self.collect_contents_to_file(self._entries.values(), 'imx9image')
+
+        outfile = f'imx9image-out.{uniq}'
+        output_fname = tools.get_output_filename(outfile)
+
+        args = [
+            '-d', input_fname, '-n', self.config_filename, '-T', 'imx8image',
+            output_fname
+        ]
+
+        result = self.mkimage.run_cmd(*args)
+        if result is not None and os.path.exists(output_fname):
+            return tools.read_file(output_fname)
+
+        self.record_missing_bintool(self.mkimage)
+        return data

-- 
2.43.0

