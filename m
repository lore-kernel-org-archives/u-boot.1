Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB7EC35FFF
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 07:16:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E771281BC0;
	Fri, 21 Mar 2025 08:16:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="s4vqz0oc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A2E681D5D; Fri, 21 Mar 2025 08:16:20 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3D3581DB4
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 08:16:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L34gcmaoLaV51SihKQBypd0kPUS5DcmD3T4GKyf7zkcSbi3oO7EogrUxS7+i6GLQpcT8lDJeIU0Xe+RjgMJZc7G2cQHssJMyqS+4McFbsXuc+z68vRHwYRuDoRZsOfQVRkdkhRw0TQFbTJ1dnfpUedjL9fcHQlWJEXH5pFan2WuBBMxc83DSdTtLFmcPrel+VPYg5gTle2lzp8WMaUmTSrY4NOWdN0CAOO6Os7VhIFhRt76QyuCrUr7b8uDiYgR7awUePtwktfnCLNZ1tqL1yYo22voEegzwO7sSCqoFL7BY4cR2bbPp2tq9qIw9LjHWZhce1Uv1+0C+j/j5AYIBOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgRjAXQkB+OBIhlu6FM/C8pLTugFOWg8s2KQcpH1CKs=;
 b=UNdrh558m4jbQ6PQgZPk/sNM3ZVX3WfKwadsFndTsOCjMUB9tEMXwVNOSb2LNXcl/rBoC0Di1WsJRqHQ+HnAIKgeHnHn2/S69NZmtbWXMBFrQipNhyeyGTKHKpE4N4ceKTAtNQsU+wrqlGhc1Ky8kNWtWbvRmnYc30o1U1aVZ65koFgw4HYn8F4bQ9+xcHjdmSNwH0v+PfJ1eVijKqyeGPMMfE5wheaA2U+tubuWIvqPeYJeGbaA8Qy4wUCYlpBDAGeXupEHVwNuGYS9KsHyzod2bw+iEpi+twsKKXXlSbQzhrHzj1mztrYwvCPaEK18jKDZeSeM5cHRYo+jGff49Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgRjAXQkB+OBIhlu6FM/C8pLTugFOWg8s2KQcpH1CKs=;
 b=s4vqz0ocbYL51PyqD8xNTYcqud78YaOB8GaitlEWYsjhkjE+RtUVwDwlUNLf6bMZBOWh0B7+TB2kgx/+cbu8sylxLJrajk/pfBw4TvntMiXad5AsgGbSysEuA74gNhZYAeUUz9g0PZCalB2Gry+OjjkmowtQut/1tNoSOEIxKOTdTZ0Jrd1kxULoZfdYs9TwkDaO2ehaUwMF2ElGr3vKgIe37s+WR39k5Y//qVmK2ZLhr+Dy92YjGhbct5CcetsRaGrNPXJ/CL8yBmCnQ+7DYarREWXWQG9wCQA7gLqAaPHNoO0ItNKSZUZHYOj9foMj+p5+wkxrkWbq/cgrEBsHzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VE1PR04MB7421.eurprd04.prod.outlook.com (2603:10a6:800:1b3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.37; Fri, 21 Mar
 2025 07:16:14 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 07:16:13 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Fri, 21 Mar 2025 15:15:19 +0800
Subject: [PATCH v8 05/19] scmi_protocols: add SCMI Performance domain
 management protocol message IDs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-imx95-v1-5-f2c8ba815f89@oss.nxp.com>
References: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
In-Reply-To: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marex@denx.de>, 
 =?utf-8?q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::6) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VE1PR04MB7421:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ca139ca-3f0e-4072-3e2c-08dd6848438b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7416014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0k2VEF4UkxYVzNYUHpta09DZGxpUWpFcXhsUDJnYzhjclplbHYxVWkxSGox?=
 =?utf-8?B?S0E4SFBpcUtmcW1IS0FmaUlpMHdpNVRzNlVvbDVNVmVyaHNJVEgwRG5UVU96?=
 =?utf-8?B?bGxuRGRXTW5abGNGTkU5c25CT1hkRTk3b29SamFkUlFaNjRhYXQ4dGxWWndk?=
 =?utf-8?B?THZBWVpHTERSWW9Kak95b2JicUNBdEw0YlBhL3pib2VpNmR1QUFiSHVrWHlF?=
 =?utf-8?B?UE12RnNzaktTRkZwaUp2UGdYdEZpSU84RzE4UGQyWEY5N3grcU9vVmVKOE5Y?=
 =?utf-8?B?ZFBsNlJiSWVUajJKTnRNWGpoUFdaMkRpUjhOd2YwdGcwUHpUbnB5bkhQQmVx?=
 =?utf-8?B?dE5IdCtkc1JudGcwUDhuMCtXZW9qZGU5a0xtZnhpMW9NeFNFWTlLTUN6MG0v?=
 =?utf-8?B?Ym9Ub2p6YiswWi9qMlJkNHlGMFFBc0laR1F3KzA2ZHRSMm5LekN1WkRucU5T?=
 =?utf-8?B?WmVwVWxTWDZCWWJUS3diMEgwUVJUMmxDa29rbm1JZFpoc3lGMm5UQkZVcDl1?=
 =?utf-8?B?ZXpmaDZySHhCZld0WXJ3cGkwbTAvaGhOQ3d6WjNNRnE5bzRGeVBrTXBWRlU5?=
 =?utf-8?B?dGZBQkUyL3lVRlBnSVNydjk3RUdQeGRTZEtTQlRLK25xTTQrUEFsZXJkNWNa?=
 =?utf-8?B?MXYyNlNaYlJ6eWNzNm82V2djdk15RzNXMmx5S1V5SWlqbDdoQjVYaTV1cm1w?=
 =?utf-8?B?dnNvbHFWOXdiRnNzWU1VVkxWTWEzdC96RExBaGNDYyswNk9mSlJUY2ptYXc0?=
 =?utf-8?B?YXZVWldKdXdDSnpvQ0pvbUFOQW5kcjlFR0lDUnNVSVBENFFaUE5zb2VCNmM2?=
 =?utf-8?B?Tml5aVlIc0tINmk1U0M2N08zRU4xcWJLS05yb0FmMm1lRjdHWU9xS04yRjFn?=
 =?utf-8?B?VytGSzRXajZsUXJha2Y5VHczREZuc2tTQnNVZ3pERFJ2Wlh6K0dEdldvUm1k?=
 =?utf-8?B?Q2Y5ZHgzV2VEQ3JnWHYvYkdDSGNwdEtQdEhraWFGTWwxdTRsMis2U25GNmlJ?=
 =?utf-8?B?WC9OOWEwOEhrTkxnK01XWXRWQVp1d2NiZVM2S25iTGt6cGxkNkVNakhiMGs2?=
 =?utf-8?B?NDJqeG1ZV1RMU2d1S1FXdkptTzNSaUYxTExLNzdkUEcxdkV5MGcvR20zc3R6?=
 =?utf-8?B?L21VMUxlU3Q0RTJsSUVYQ09mZ3RNcHJWN0lKNmlxdnREdmxwSTVIajNCejgz?=
 =?utf-8?B?T0RrclBNdHZBdVpvUUgyVGhXY0tta011eEZlclpKTmhVakkyRzNjQzZ1QmMw?=
 =?utf-8?B?dG1LalJGZmRyRDliczc4V0RKQmgxMjBCc2xiT0R3Nzd6UzdCeHNoVE5YZ0xL?=
 =?utf-8?B?OWI4bGZrOG9GbXNYTTFZMVdFNUo0QWVqeWxuK2NjYzAydXM0VzZGaDFWN1FD?=
 =?utf-8?B?U1JwY1doY3dWZlE3WjZEZ2lQN3htS292TW5WbnNaOTJ4RmR5bmVTNCtHWXhQ?=
 =?utf-8?B?b0F1emFVUkxSVTdZTStCeVlSQkhhSHR1R3c0L0Nna2FhZFZlajc4VEJ5NElm?=
 =?utf-8?B?YXMwcWhQSlJaRGJnOVVSb1ZOam5GSzdvdENWWE1iUWdMNzFOYkgyOFBoRXg2?=
 =?utf-8?B?ZS9zQ3E0NGhhKzJPcWxYTjQ1TGllazlwdGtmVHRtZTdNMnB3ZjJZcHJLTWQy?=
 =?utf-8?B?ZWQrMFUraEhhK0RBTjZhNW1YR0UwZlZSOGxvb1dUK0x1OWxlZGhRRWw2TXhp?=
 =?utf-8?B?bFZKcytHd21OWVhpOWgyUHhIc1pyY003U05iZXZlNHJra1d4MUtobU1MeTRw?=
 =?utf-8?B?QXFtc3dHYzlsUVp1M1V2Z290U3FicktKZGtwRytjd0tCT0ZVa0FGTGluYTBB?=
 =?utf-8?B?b0d3TGs3a1VqQjlKYzhrRlUxWjJZUENlbE0rQndFUVRCTXZwSGNhbVlwQ2py?=
 =?utf-8?B?SmhLekRHVGw0WGo5MmM0UGpqV2cyODFqK0tSTGNaYWsxUHd4MTZaTnhlTnNh?=
 =?utf-8?B?TjN5ZUhuUXRLOEpUNkNVaVlKak5RYnpNQi9yWjBxYU9zdjhHZDV0d1dGdjBk?=
 =?utf-8?B?K3IwemdWSHR3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(38350700014)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NG50aGw2MENOSmx2SWFXSHBjVzVnckNabEE3a3VuSmQyZnV5bDlkdEVWd1BF?=
 =?utf-8?B?Wml5c1NQVmFtWjJYSncwci9YemhmRUZCUUpSUE95cEpwbjlIVFBYZ3haWkhH?=
 =?utf-8?B?eis3VEZZNk01OGZIY0tpZ0tGVzd4bGY2a2hValhhL01VT0w3ZU8vU01RNmE2?=
 =?utf-8?B?ZVF4U0tYbENBdjNQWGVyQnMrdTZ1ZVJ5STJsMXFCQ25xckVDSnhEek01N0JM?=
 =?utf-8?B?Tzhqc05uanU4T0NkdWsrd04rbXp4WDNtcDhaQ0o5ZFp2anVIY0J0WU1OL2pY?=
 =?utf-8?B?WThOVEQrWHdxT052UGM3WEtpTGlCV1Q3UVpNdVR0NXVIaFA2S1ppR2NuRE9U?=
 =?utf-8?B?UGtoV3RDMSt6MEtVQmwzVkVJRHk1cU40K1paTi8rbjVoM1R3ZDdGU0MyeHE3?=
 =?utf-8?B?RGlkcmhYeGtkVmhVeVlZR2NWT0ozU1JiS0NLNmEvOVBoN3pEcDdha3NjNVhZ?=
 =?utf-8?B?ejhKVFpUQU9Vbzc2eU80KzdrUklCOFJsU1F2QkNsYVFWNFAzYktSSk9pKy9j?=
 =?utf-8?B?anYxVlJ3TWZOak80WE5zbUZVRmN6RmVCTDFqMkFZZVpsS3dIQTNldUo0eXZk?=
 =?utf-8?B?eDFyTVdQMFhSU1k5SFB5bTZabnpLTmhqc2lTZUVGODdsWHNLMnV5WFkwM0ZL?=
 =?utf-8?B?eEVqQWw4OUtPWHNPSW8zYi9vVFprZ1lsR0xaVTBTSGFMY0dVWlFRUmtoT2dp?=
 =?utf-8?B?ODFndlRuZUF6WW5rSWR3Qkc1bjljU0JDZ3BZSGwweVFoTk5DazNnaFVkd1hq?=
 =?utf-8?B?UllRa0l0b24zUS8zWjMxaC9zLzgydVVqOXhLa2ZkRkJFeVA4Q3N1Z3VIODBK?=
 =?utf-8?B?V3Z4OHdReXlDdXg1UXB3OW1sdkN5VGRLNUFuSHg4Z211SXRsaTZBSnZQUzMx?=
 =?utf-8?B?SWlTdFdhblVERFQvOU9yRENwcHFGYUtRQXFUTWNvNzZkai82Rzl2QnpFMm5l?=
 =?utf-8?B?VVBuZEdMSU9abFZnQm5iOFNGTlBBeWZseFRuSVZmaVhINjFCMEZxWXhLclZY?=
 =?utf-8?B?azc4clpEL0F5cE9VNU45a1ptUWhNQnRrS1duK2ZDeklLVTZ4UU5heVZvL0Zy?=
 =?utf-8?B?dEtyN0J4ZktnRkdMcFN0cVRwVlpYalVXUEU5dUVDWTc4cGR4MzlObjNSa3RB?=
 =?utf-8?B?MTk3Y0NPQzJOTlU3QmxqZjQ4Vno4VExXMHV3SGxLc2o1WkZrbWJkclY0RVdG?=
 =?utf-8?B?aUs5SjltUlVMQWUvRDBlRzBTczdyVTQ3eUxxU1VSRFU4OGRqeXRBb0NyNnBo?=
 =?utf-8?B?Ny82RmF1c0VvQ095QkN6UG5KdmcySUVZODczQ09ITm5kZkhkSGI1ZldmV1Fr?=
 =?utf-8?B?QkdDUEM1ZmZhMUlHMDJFczI5QWpDSzRpVDA4MzgvSXpmVm5sU1FiaFVjVmYx?=
 =?utf-8?B?RmpUaXpobUh4Qjl0dmo2SldVN3o5YWNsTnZtOWJKblJPQW96ejVBQzVITm1W?=
 =?utf-8?B?ZmNmZFNzNjRxU1kwLzFBd0JJMUNtNWN6TkxtNzlYeUxXYjRhWG91YXA4Nkk4?=
 =?utf-8?B?d3F0WU0wa1lQdDhBbXlzNDVaV3RHNkdZNXdocU1GVUpSd2I5SjVnb0xNOW00?=
 =?utf-8?B?RmFCS0NNOWJwUUo4TFM2WXVuaXhIMkRvMk5DbjFEVXNjZERKYnVpSzh0clN1?=
 =?utf-8?B?bjlNRldOSDJ4dm9GY2RxekhEdmRZL1l6bzFhYzJzTDdMdjdxRFJwWkZCQnZr?=
 =?utf-8?B?SEVpSGRFUEh4aDMvdEl0L1J6V2tnVTRkSUwwYmxRckQyUnovNWJzaHpJYk9z?=
 =?utf-8?B?S0xjQ2I3Z1JDdDVMS3djalNmVU8yelJCaVE3ZGg1MjRFcjA0cnU3aldyNlFu?=
 =?utf-8?B?SnpVREQrNExldEdYbElOa0FkdHFRZGVKZTdBNEcrRFhwQjlvTllGU2dIdE42?=
 =?utf-8?B?NWZaUkFnQTNMZWFRdWdoMlY2c1VGZWxsNGRVSGtSWVhKWThnaVV4N0pNRWhN?=
 =?utf-8?B?c0ozeGJnTzhhd1ROd3Bma25wZFNxUTFGL1FZMXVPUnBxOURZSFFnWnhrZGcw?=
 =?utf-8?B?Zi9UNEhJRDNUK2V1dzNSNy9YWExBNFZxaWhzWlFydzlnTGFPa2Z2YTdwL3dN?=
 =?utf-8?B?K2p1MHROY3NBeHd5WFRCWWpPU3IxbDRpNDZXdkRPTGZMMENlMG5jT2VPcVdu?=
 =?utf-8?Q?rdP1yore/0Z6rse3MMFBG5xDa?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca139ca-3f0e-4072-3e2c-08dd6848438b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 07:16:13.7705 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ORHuc2An83ibPmW+rG7kUgjThzIqFVQNOfP9toWby4TBMJlUeMKb1V77nFJyrm8B1FPUCMmbfOXwAU1LNpXI2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7421
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

SCMI Performance domain management protocol is intended for performance
management of groups of devices or APs that run in the same performance
domain. The functionality provided by the callee-side can be used by
passing the corresponding message_id.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 include/scmi_protocols.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 06de4a601f8..34f272c448c 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -1046,4 +1046,22 @@ struct scmi_pinctrl_config_set_out {
 	s32 status;
 };
 
+/* SCMI Perf Protocol */
+enum scmi_perf_message_id {
+	SCMI_PERF_DOMAIN_ATTRIBUTES = 0x3,
+	SCMI_PERF_DESCRIBE_LEVELS = 0x4,
+	SCMI_PERF_LIMITS_SET = 0x5,
+	SCMI_PERF_LIMITS_GET = 0x6,
+	SCMI_PERF_LEVEL_SET = 0x7,
+	SCMI_PERF_LEVEL_GET = 0x8
+};
+
+struct scmi_perf_in {
+	u32 domain_id;
+	u32 perf_level;
+};
+
+struct scmi_perf_out {
+	s32 status;
+};
 #endif /* _SCMI_PROTOCOLS_H */

-- 
2.43.0

