Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22EE2C19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 10:57:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BBAF8118A;
	Fri, 28 Feb 2025 11:55:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="P97oMmeM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8790A81335; Fri, 28 Feb 2025 11:55:56 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::61d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7FE68118A
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 11:55:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M6aKfXqG2NktzYvmwAFopWUb3cVB4krDCtFxoNn0ScDvqHJeQ5SRVP3qkINaiITh838Iz5kOtqEDF3IxvkO2ym/m9YvAAMCywbM0XINL4P6OA8x5hWpBB1s+dnx9RNmWnN8RSC43lFxwnmz2XYWibVwEMoANlU8WyeP8CC/8JFhjVcSsdGH7LMdSy+FfUDMGPNmPDPX8wPDmcBzUyMOIE6o2f7u3QgQn2FIy9Rkq2SEOtjcWHFeEKweM65uJbhdozzPuU7xUkosBH/hKPCuuGjZxcystsy7VA21v7Pg8mNM0mfSJyBUW0rxBCTMkqf8sU+8Hueufpon26qcp2K53iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZpd5IUYdYJsOh5/9kXrAlzrg8wSAaU34MtunfKQ6rs=;
 b=qX9vhLvoR7g7S5xeS1JCk4nRneXdxB1B22q/QD4YXeoX4ZtaciM9Pk9IFvwfwnIPWSod+6MJNe8U6S9yfl59f5E6A+MVi1/gVmfVeKYD8tk72UjnhEZqCmd/WvNsqPKFb9tuAF9ajOCOAY1sX/jna7yLW+uFiimsEmPn3tkz9gPnWLChKhWucZ0qLi2bI5UeXc9s6Hgkb1j5spMV9khI7yBNELrNVarywik0bhj/Wm0E5hEe7HL3A2aFRjNDFizt13oRsSe4ID8p5ZBnQRWKJDcNA7GI8h1u4hOKZPKD5pLDP8gsswxMJSmN5saXlaiytTwkN8yEkhk95oyKUd6CrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZpd5IUYdYJsOh5/9kXrAlzrg8wSAaU34MtunfKQ6rs=;
 b=P97oMmeMCJsU1+JLnN2cL94B2TSJBYsx7ttxUiwvaQ1NPdQo483rW9cPHIQIDzFcVYePIEv2d8q4uEdIDP23HNqCXTxj+bfmO40GnG6imPQFosku843cdZyQ0ZyFYMGHeohmW85lbtbEa+sF9SD+dMkDW9kgZfkw0vKUoGHT/6X+DFDtdv0I5Ca9GX+xjYxAIyGuR+4guJvqUjw01mwkR1zVE9ohC9zQBW3GqdWHx8pLwZvxxOSxVzuww2QjhbK7Oa3qWdDjyDCCG+Liu+5EsfFx/auSwS0OyfPSiPb5qjNP8IqHN5/umnKkE1G5DQpHR6Rgu+fYRAoFzLVVD/wCNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB7845.eurprd04.prod.outlook.com (2603:10a6:20b:2a7::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Fri, 28 Feb
 2025 10:55:52 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8466.024; Fri, 28 Feb 2025
 10:55:52 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Fri, 28 Feb 2025 18:54:10 +0800
Subject: [PATCH v6 19/20] imx95_evk: add i.MX95 19x19 EVK board basic support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-imx95-v1-19-09594e93cc9b@oss.nxp.com>
References: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
In-Reply-To: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 marex@denx.de
Cc: u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB7845:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cd87b09-c073-4405-9572-08dd57e67801
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|921020|13003099007|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UElZUDJ0TGZ3UVRsTG41VmdwUitCL0NQSy9DU1pCWjhzQ0hFdzBrRHBONkZG?=
 =?utf-8?B?aWR6RElXakpHNjZ3ZHdLNVF4VEFDTGtIN2JXMERLalp3c0xudVRsSDk2dUxY?=
 =?utf-8?B?ZFVsdG1qdWo3SnBDTndXejZVWENlbUJQTGxmdm5GZmR6a1dqemI4WCttSzBW?=
 =?utf-8?B?bjJ1M1J6NFBLN2wzc291d3l6SWhadGsyb25PcjdNYjExY0hGd0UwYWFFTCtw?=
 =?utf-8?B?Qk5KSld0aExTdDhpTnltN3ZDZjV1c1NNWW9GeG5pa0ZVazdtT2Y4R2FIOSs5?=
 =?utf-8?B?MVU2WUdhTHdqV3Y1SEs5VllUQWFZSTBDYUZwcnlGMkMrbUJiZElRUzJRYi8x?=
 =?utf-8?B?cWtkUXFzcXBTR0RybFpDRGlLSkJQR1phQW8wVy9VVm50UGozemNlNXR4OWY0?=
 =?utf-8?B?RXVSMDRISlNDZHFnVTNJVmxMckp0TmEyN2VNTG5xWVFiTWw2ZXRiSHVab1hI?=
 =?utf-8?B?bWc5d2JDMi9HY3NhWFFEc0R2UlE0Rlg1N3lwcUhBUGVLUTdKcENpeFhMOW5i?=
 =?utf-8?B?Z1NTaXYzN083L2tLVk9GUThCRTNOemNxR0NsZC9rVVdMZzBXS3FaUHJURzll?=
 =?utf-8?B?RHlwZjJPamt1N0pMU0pIN053ZjhzaVMwWFVRelRUUVArcXArNEJlV3pmUzRv?=
 =?utf-8?B?ZlZmSGFReUN0SWswbDZuNjg0VjRvaXBQTzQweExia1g3dFVPRG41ZVlhanVR?=
 =?utf-8?B?WXRKOTROT1FTWUQwZmFZYWVoLzFkbGt2Q24xdkh6ZXZidEduUHRpK0IxVUFF?=
 =?utf-8?B?NXhtS0s2dTBJMHE0andNNHN1eUljdGNaZGdEbDJsMjdnM1hYVTVRV1JLSGlV?=
 =?utf-8?B?MGdCZjVQZkdXSzJoZ2p4K0ZKRzdSN1pLREs5aW56dlBuNExHRitXa0N2WHJK?=
 =?utf-8?B?RFFIOWxsZWpOak1SbkFrQ2hEVnV2ZlNuNmVtV01GenY5NlpTSEZDUkR0Vkl4?=
 =?utf-8?B?bzZXZXdTZmEzTnBxWXhmUHIyRTM0aDRpRTVrcWtEWUVMNnhaSTR1TE9nSEZl?=
 =?utf-8?B?bExubWEyRU1vU2x2Z0xmYlp6VEM3VC85TDI1NHRIZ29oOWZZZ1o3SElXN0Qy?=
 =?utf-8?B?bEs3SXBLQ1NJT1pMOGliREhjdWJiL2RLSXdyQS9GKzRvTk1hN3l6VW5kVXlz?=
 =?utf-8?B?cDgvWFJ4d0FEVHJzRldEVFA5Snp1MG5zTkxMZ3F1WkRrVTVEKzVsdDdlR2pC?=
 =?utf-8?B?VGVuZG9ZTllXTmt3RnYrU3FNYTVOVURNUnZPSUFHa1JIYVJ4WjlrV3FEWFAw?=
 =?utf-8?B?R3FVeDJJaVp3M2t0TGJOYWtkWEUzUlozU0F0aWNvclVwbnhFNlpyTFZiL2ZS?=
 =?utf-8?B?eUZFYmpDdVo5dDcySE5TYldXYjRYemFBSHdMOWZhM0x3TUVDWjZnQ1Q0Nkxu?=
 =?utf-8?B?OFlqd2Z4Q2c2dVBoS0VKb1BDMWxQS3JqbWxjaWhqMkdjaUxMY3dWNUZndHVP?=
 =?utf-8?B?aWRIQXRXQlFka0NIdHRhc0s3aVR3d1FCQloxdk5WVEIrMFg5QWhXUzhpL0px?=
 =?utf-8?B?ajIzVlVhWFBKN3NFZ0IvdG1RaytGeDk1ejRKL290dTBRTWUxZGczRmpEbDFo?=
 =?utf-8?B?b2lNcm1kVUwvWmZpTEN5ZENMWVRibHduSnlWazNrWXdycHhLOHlWaGVxQW52?=
 =?utf-8?B?RENZTU0zSFNuVG9NRjZFeUhJSVRrNmx3U3RPdWs5TStaS2xJcFMvWU9YYTN2?=
 =?utf-8?B?SVlBd3o1dmx1WWUrYnNkS2pSL1hlU0dtSGhGSzJQRnZKZW1ObmhNMmMxUEVz?=
 =?utf-8?B?OE9wVld2citvTXp5a0hjdGV0MGdCZ2FhQlE0dG4wWkhzaGRHZjVCckJMaW9G?=
 =?utf-8?B?WXd6NDZzaTZ0Zk5Xc2h4eE1rTXQrRkJpL2Y3ZFNpSGJDc2ZUQURQMkVWcTYz?=
 =?utf-8?B?NmVCY1BidjAyLzdPdnB2QjBlbjFwbVlvd0ovcUwvb2RIelVzK2F6NXpqM1Rr?=
 =?utf-8?B?UE8vTGFQcDM5WVErUTJadHg0UXRvSm5NSG5xR3dSNWVVZE1tbjJRYXBtVXJD?=
 =?utf-8?B?ajRCMHdBOXNBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(921020)(13003099007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDF5bVdjOHNlQ2wrYmE4WkljdDdNcWNiaVAwRHJDMFhjK1d6R3pybk5RVFhG?=
 =?utf-8?B?eW5QMVFSYUF1Zzc4YzA4bEpNVDVHVFFpUUMrcE1yQUFSRFBsTW1OQVZQZ0pu?=
 =?utf-8?B?K2xrdzh2RGRwZTJ5aHZlcWtpaENCUVd2Uks3Y2lyaElVMFo0UVgveGxGRG5r?=
 =?utf-8?B?cUVkbEkrVHVCd3ZFQ2RaRkJGMjd3L05STHhvVFlsNXgwVjMrVjhBSkpIK2Iy?=
 =?utf-8?B?WEZhZk9ZQlhRWEFseW1XYzI3N2diaTZCVVhEcUUyNU11d1RrRHZ6TlZ1Rm80?=
 =?utf-8?B?aWdOTzl3MlVOSWFremkwS3RBUVJvNFJTY09KV2JvQnJnTGpDS3pPaXJ6Z1BQ?=
 =?utf-8?B?RlZhSnJGcWg1N243NmY5UFI1TGNMUmF3ZHZoS2loOUdjdno2dnFvaS9rWnhK?=
 =?utf-8?B?OGJCWG12RDlsWHJZT1BUNXZabUlHeWMzMmlqWFRpek9MT1ZCTU1RbzlORlpa?=
 =?utf-8?B?YUFZdWh0a0oyNXdtZ2xMUXkzUWlaSXlqTkpSZ0NHWXR5dnF6Q2pDLzlxem13?=
 =?utf-8?B?N1BYSVVMdlNISmladVQ4aVY5cU5NOVVDbHg0SU1jckVpejhvVnBSMU94Smdm?=
 =?utf-8?B?TmhGaGxXUkdObEk1NW15V211c0puaE9UQml3RzhqUldFbERDTCtUV3c4d0NN?=
 =?utf-8?B?SDJQOEkrdmo1dVBYY0REZFhNb2N5SmlOOGZxMkNycG5xcVVNMEZNVnErTEZj?=
 =?utf-8?B?WlJwNmQ4dHVIcTlRakdKTEJuVlpWWmpNODlxYWxyY2NUbVhVM242dVRXemZ6?=
 =?utf-8?B?ajNmeVFnYnFiMjlxNm1Id0dvVnNvS2hiZ1NSZTJIN0VzOTZJN1VYWjgxZHd2?=
 =?utf-8?B?TGZMalBUUmpYQkJTc1VJQ0VobENhejhHYmhqci91TjhOeGpmUDViY2xuSDUx?=
 =?utf-8?B?Uy92cFpUVmVGeW13SUsvcHpjM2JNOTVmWlpWaGl3OWdwTEFNcTlTMDNTMEtm?=
 =?utf-8?B?dEFQb1ZnenN4dTBXdE1RMmMwbkNtdnd6ZXZJdllCYURremljWVBWYmEvQVln?=
 =?utf-8?B?cC9GTGZSbXh2aytPQXBrMFBoam1zS1JGM1JLUGxQcEdDTEo5bmdLcW8vVjhJ?=
 =?utf-8?B?TVk2a01vL0hwNmhGRGFHa04wT0UxcjFicFFoZjZUUUlYb2hhOThYVEVRMW1U?=
 =?utf-8?B?NC8vOUZXc3pzK0tzNUNTMVBhMkJhQTcrRTBaTkJHOUV5OWdxRmJNbEZsRXNy?=
 =?utf-8?B?WnEwWW00Tyt2ZkFaREtpejM0M0I4TWZLNHdJbzRBWmh4OVBPblltbjV5dDNU?=
 =?utf-8?B?b1IydHNmRlRjSmxsTktvNUFVeHpwczA2clQzOTFKc0JFU05xWTJZNU9tUThr?=
 =?utf-8?B?OS9CKzhFTWJOSm5oQ3JhOGw1MEpEam5GQjcrWmtjMitRU3B2K3ZmWS8wYVl1?=
 =?utf-8?B?QW5GYjlaM205TnFKUk9IRFY4eUF4Sjd4MEZPSzg1NlorcmRBbklWaE5RTGUy?=
 =?utf-8?B?QUIvUTJVbFBQNFdRT0M1UFpRQ2NRZFYxc2h1REZkSnhwTU5YOGRubW5LaWt4?=
 =?utf-8?B?b1FiVjNrbElWaHpqdzlQUUxkWUhVdGJHR2N3VlNBOHU5OHM2SzV4ZFBKeTNr?=
 =?utf-8?B?M3BFdlRpRGRLdlZpL3JSbmZ3cmRyT05GUlBmbGJMcTVKN0RrVGdYL3pIazMy?=
 =?utf-8?B?bDhxWklvbGFTdThOS042SFNzWTNUQzZVNDNCNkNsOXR4UzhUc3dkT2poUmhR?=
 =?utf-8?B?cGxzalZCaUg1anJ2R0F4ZkRTd0hIVE5wWi9BY1ZXWFhpYkxsc0ZsbVpnSHMr?=
 =?utf-8?B?VVdYOG5QbjRRTm90U09DTElxNUNKZzREYU5SUVZkRVNBMktsSEFXUXhMTHJ5?=
 =?utf-8?B?NFNhS1FyVXhnL2FCT1BIVFZaTnNYWGkzWWszM096MFZGT2V1b3M0K1NuMjlk?=
 =?utf-8?B?MWJNOVlEbmN4QWJUOVRya0sxeERQaXJycEdGK2Fkd2FDQ0N0QVFWVkVlN0wv?=
 =?utf-8?B?djZDWEdsSUNmTXdycXVnQ3NDQmR4VllZZkoxa29zVnhESnlLRG5sbjkxMDhD?=
 =?utf-8?B?eFpBRURKd2h1ZWNabENmU09pb1g1ckFlRGd6eUNjTk10aWNqQlFoOVhwKzNt?=
 =?utf-8?B?ZDl5OXhyMUxhZlhTeWI0bUhCa1NKcVNrWnJxTVAwd0JCK1A1TVFUYzVUcy9h?=
 =?utf-8?Q?fqsAzHs1znqwkKF8s7YroXZHC?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd87b09-c073-4405-9572-08dd57e67801
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 10:55:52.5175 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OcsRv4VdFPGiB+ulS1oC2kfn3Ki8jpGY2bvfXG++yi7wbxepvQwYPUOLFs4WbcDCildYb76Nqjgi8VS7UVp3/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7845
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

This patch adds i.MX95 19x19 EVK board basic support.

Messaging unit for EdgeLock Secure Enclave, messaging unit for System
Manager, uSDHC for SD Card, gpio, lpuart are supported now.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/imx95-19x19-evk-u-boot.dtsi      |  62 ++++++++++
 arch/arm/dts/imx95-u-boot.dtsi                | 157 ++++++++++++++++++++++++++
 arch/arm/mach-imx/imx9/Kconfig                |   8 ++
 arch/arm/mach-imx/imx9/scmi/container.cfg     |  10 ++
 arch/arm/mach-imx/imx9/scmi/imximage.cfg      |  15 +++
 board/freescale/imx95_evk/Kconfig             |  12 ++
 board/freescale/imx95_evk/MAINTAINERS         |   6 +
 board/freescale/imx95_evk/Makefile            |  11 ++
 board/freescale/imx95_evk/imx95_19x19_evk.env |  91 +++++++++++++++
 board/freescale/imx95_evk/imx95_evk.c         |  36 ++++++
 board/freescale/imx95_evk/spl.c               |  72 ++++++++++++
 configs/imx95_19x19_evk_defconfig             | 152 +++++++++++++++++++++++++
 doc/board/nxp/imx95_evk.rst                   | 114 +++++++++++++++++++
 doc/board/nxp/index.rst                       |   1 +
 include/configs/imx95_evk.h                   |  24 ++++
 15 files changed, 771 insertions(+)

diff --git a/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi b/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi
new file mode 100644
index 0000000000..2d1f02baa5
--- /dev/null
+++ b/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ */
+
+#include "imx95-u-boot.dtsi"
+
+&lpuart1 {
+	bootph-pre-ram;
+};
+
+&reg_usdhc2_vmmc {
+	bootph-pre-ram;
+};
+
+&usdhc1 {
+	bootph-pre-ram;
+};
+
+&usdhc2 {
+	bootph-pre-ram;
+};
+
+&wdog3 {
+	status = "disabled";
+};
+
+&pinctrl_uart1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1_100mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1_200mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_100mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_200mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_gpio {
+	bootph-pre-ram;
+};
+
+&pinctrl_reg_usdhc2_vmmc {
+	bootph-pre-ram;
+};
diff --git a/arch/arm/dts/imx95-u-boot.dtsi b/arch/arm/dts/imx95-u-boot.dtsi
new file mode 100644
index 0000000000..b0dcf765a7
--- /dev/null
+++ b/arch/arm/dts/imx95-u-boot.dtsi
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ */
+
+/ {
+	binman {
+		multiple-images;
+
+		m33-oei-ddrfw {
+			pad-byte = <0x00>;
+			align-size = <0x8>;
+			filename = "m33-oei-ddrfw.bin";
+
+			oei-m33-ddr {
+				align-size = <0x4>;
+				filename = "oei-m33-ddr.bin";
+				type = "blob-ext";
+			};
+
+			imx-lpddr {
+				type = "nxp-header-ddrfw";
+
+				imx-lpddr-imem {
+					filename = "lpddr5_imem_v202311.bin";
+					type = "blob-ext";
+				};
+
+				imx-lpddr-dmem {
+					filename = "lpddr5_dmem_v202311.bin";
+					type = "blob-ext";
+				};
+			};
+
+			imx-lpddr-qb {
+				type = "nxp-header-ddrfw";
+
+				imx-lpddr-imem-qb {
+					filename = "lpddr5_imem_qb_v202311.bin";
+					type = "blob-ext";
+				};
+
+				imx-lpddr-dmem-qb {
+					filename = "lpddr5_dmem_qb_v202311.bin";
+					type = "blob-ext";
+				};
+			};
+		};
+
+		imx-boot {
+			filename = "flash.bin";
+			pad-byte = <0x00>;
+
+			spl {
+				align = <0x400>;
+				align-size = <0x400>;
+				type = "mkimage";
+				args = "-n spl/u-boot-spl.cfgout -T imx8image";
+			};
+
+			u-boot {
+				type = "mkimage";
+				args = "-n u-boot-container.cfgout -T imx8image";
+			};
+		};
+	};
+};
+
+&aips1 {
+	bootph-all;
+};
+
+&aips2 {
+	bootph-all;
+};
+
+&aips3 {
+	bootph-pre-ram;
+};
+
+&clk_ext1 {
+	bootph-all;
+};
+
+&elemu3 {
+	compatible = "fsl,imx93-mu-s4";
+	status = "okay";
+	bootph-all;
+};
+
+&{/firmware} {
+	bootph-all;
+};
+
+&{/firmware/scmi} {
+	bootph-all;
+};
+
+&{/firmware/scmi/protocol@11} {
+	bootph-all;
+};
+
+&{/firmware/scmi/protocol@13} {
+	bootph-all;
+};
+
+&{/firmware/scmi/protocol@14} {
+	bootph-all;
+};
+
+&{/firmware/scmi/protocol@19} {
+	bootph-all;
+};
+
+&gpio2 {
+	reg = <0 0x43810000 0 0x1000>, <0 0x43810040 0 0x40>;
+	bootph-pre-ram;
+};
+
+&gpio3 {
+	reg = <0 0x43820000 0 0x1000>, <0 0x43820040 0 0x40>;
+	bootph-pre-ram;
+};
+
+&gpio4 {
+	reg = <0 0x43840000 0 0x1000>, <0 0x43840040 0 0x40>;
+	bootph-pre-ram;
+};
+
+&gpio5 {
+	reg = <0 0x43850000 0 0x1000>, <0 0x43850040 0 0x40>;
+	bootph-pre-ram;
+};
+
+&mu2 {
+	bootph-all;
+};
+
+&osc_24m {
+	bootph-all;
+};
+
+&{/soc} {
+	bootph-all;
+};
+
+&sram0 {
+	bootph-all;
+};
+
+&scmi_buf0 {
+	bootph-all;
+};
+
+&scmi_buf1 {
+	bootph-all;
+};
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index ef364ca1a2..19b6e7c981 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -74,6 +74,13 @@ config TARGET_PHYCORE_IMX93
 	select OF_BOARD_FIXUP
 	select OF_BOARD_SETUP
 
+config TARGET_IMX95_19X19_EVK
+	bool "imx95_19x19_evk"
+	select IMX95
+	imply BOOTSTD_BOOTCOMMAND
+	imply BOOTSTD_FULL
+	imply OF_UPSTREAM
+
 endchoice
 
 source "board/freescale/imx91_evk/Kconfig"
@@ -81,6 +88,7 @@ source "board/freescale/imx93_evk/Kconfig"
 source "board/freescale/imx93_qsb/Kconfig"
 source "board/phytec/phycore_imx93/Kconfig"
 source "board/variscite/imx93_var_som/Kconfig"
+source "board/freescale/imx95_evk/Kconfig"
 
 endif
 
diff --git a/arch/arm/mach-imx/imx9/scmi/container.cfg b/arch/arm/mach-imx/imx9/scmi/container.cfg
new file mode 100644
index 0000000000..ac5a0a2818
--- /dev/null
+++ b/arch/arm/mach-imx/imx9/scmi/container.cfg
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2025 NXP
+ */
+
+BOOT_FROM SD
+SOC_TYPE IMX9
+CONTAINER
+IMAGE A55 bl31.bin 0x8a200000
+IMAGE A55 u-boot.bin CONFIG_TEXT_BASE
\ No newline at end of file
diff --git a/arch/arm/mach-imx/imx9/scmi/imximage.cfg b/arch/arm/mach-imx/imx9/scmi/imximage.cfg
new file mode 100644
index 0000000000..678d15c99b
--- /dev/null
+++ b/arch/arm/mach-imx/imx9/scmi/imximage.cfg
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2025 NXP
+ */
+
+BOOT_FROM SD
+SOC_TYPE IMX9
+APPEND mx95a0-ahab-container.img
+CONTAINER
+IMAGE OEI m33-oei-ddrfw.bin 0x1ffc0000
+HOLD 0x10000
+IMAGE OEI oei-m33-tcm.bin 0x1ffc0000
+IMAGE M33 m33_image.bin 0x1ffc0000
+IMAGE A55 spl/u-boot-spl.bin 0x20480000
+DUMMY_V2X 0x8b000000
\ No newline at end of file
diff --git a/board/freescale/imx95_evk/Kconfig b/board/freescale/imx95_evk/Kconfig
new file mode 100644
index 0000000000..f9a67353e5
--- /dev/null
+++ b/board/freescale/imx95_evk/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_IMX95_19X19_EVK
+
+config SYS_BOARD
+	default "imx95_evk"
+
+config SYS_VENDOR
+	default "freescale"
+
+config SYS_CONFIG_NAME
+	default "imx95_evk"
+
+endif
diff --git a/board/freescale/imx95_evk/MAINTAINERS b/board/freescale/imx95_evk/MAINTAINERS
new file mode 100644
index 0000000000..5caf763e0c
--- /dev/null
+++ b/board/freescale/imx95_evk/MAINTAINERS
@@ -0,0 +1,6 @@
+i.MX95 EVK BOARD
+M:	Alice Guo <alice.guo@nxp.com>
+S:	Maintained
+F:	board/freescale/imx95_evk/
+F:	include/configs/imx95_evk.h
+F:	configs/imx95_19x19_evk_defconfig
diff --git a/board/freescale/imx95_evk/Makefile b/board/freescale/imx95_evk/Makefile
new file mode 100644
index 0000000000..0f5cec385c
--- /dev/null
+++ b/board/freescale/imx95_evk/Makefile
@@ -0,0 +1,11 @@
+#
+# Copyright 2025 NXP
+#
+# SPDX-License-Identifier:      GPL-2.0+
+#
+
+obj-y += imx95_evk.o
+
+ifdef CONFIG_SPL_BUILD
+obj-y += spl.o
+endif
diff --git a/board/freescale/imx95_evk/imx95_19x19_evk.env b/board/freescale/imx95_evk/imx95_19x19_evk.env
new file mode 100644
index 0000000000..becf6c3162
--- /dev/null
+++ b/board/freescale/imx95_evk/imx95_19x19_evk.env
@@ -0,0 +1,91 @@
+sec_boot=no
+initrd_addr=0x93800000
+emmc_dev=0
+sd_dev=1
+scriptaddr=0x93500000
+kernel_addr_r=CONFIG_SYS_LOAD_ADDR
+image=Image
+splashimage=0xA0000000
+console=ttyLP0,115200 earlycon
+fdt_addr_r=0x93000000
+fdt_addr=0x93000000
+cntr_addr=0xA8000000
+cntr_file=os_cntr_signed.bin
+boot_fit=no
+fdtfile=CONFIG_DEFAULT_FDT_FILE
+bootm_size=0x10000000
+mmcdev=CONFIG_SYS_MMC_ENV_DEV
+mmcautodetect=yes
+mmcargs=setenv bootargs console=${console} root=${mmcroot}
+loadbootscript=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${script};
+bootscript=echo Running bootscript from mmc ...; source
+loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
+loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
+loadcntr=fatload mmc ${mmcdev}:${mmcpart} ${cntr_addr} ${cntr_file}
+auth_os=auth_cntr ${cntr_addr}
+boot_os=booti ${loadaddr} - ${fdt_addr_r};
+mmcboot=echo Booting from mmc ...;
+		run mmcargs;
+		if test ${sec_boot} = yes; then
+			if run auth_os; then
+				run boot_os;
+			else
+				echo ERR: failed to authenticate;
+			fi;
+		else
+			if test ${boot_fit} = yes || test ${boot_fit} = try; then
+				bootm ${loadaddr};
+			else
+				if run loadfdt; then
+					run boot_os;
+				else
+					echo WARN: Cannot load the DT;
+				fi;
+			fi;
+		fi;
+netargs=setenv bootargs console=${console} root=/dev/nfs
+		ip=dhcp nfsroot=${serverip}:${nfsroot},v3,tcp
+netboot=echo Booting from net ...;
+		run netargs;
+		if test ${ip_dyn} = yes; then
+			setenv get_cmd dhcp;
+		else
+			setenv get_cmd tftp;
+		fi;
+		if test ${sec_boot} = yes; then
+			${get_cmd} ${cntr_addr} ${cntr_file};
+			if run auth_os; then
+				run boot_os;
+			else
+				echo ERR: failed to authenticate;
+			fi;
+		else
+			${get_cmd} ${loadaddr} ${image};
+			if test ${boot_fit} = yes || test ${boot_fit} = try; then
+				bootm ${loadaddr};
+			else
+				if ${get_cmd} ${fdt_addr_r} ${fdtfile}; then
+					run boot_os;
+				else
+					echo WARN: Cannot load the DT;
+				fi;
+			fi;
+		fi;
+bsp_bootcmd=echo Running BSP bootcmd ...;
+			mmc dev ${mmcdev}; if mmc rescan; then
+			if run loadbootscript; then
+				run bootscript;
+			else
+				if test ${sec_boot} = yes; then
+					if run loadcntr; then
+						run mmcboot;
+					else run netboot;
+					fi;
+				else
+					if run loadimage; then
+						run mmcboot;
+					else run netboot;
+					fi;
+				fi;
+			fi;
+		fi;
\ No newline at end of file
diff --git a/board/freescale/imx95_evk/imx95_evk.c b/board/freescale/imx95_evk/imx95_evk.c
new file mode 100644
index 0000000000..d5f5e310b6
--- /dev/null
+++ b/board/freescale/imx95_evk/imx95_evk.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ */
+
+#include <asm/arch/clock.h>
+#include <asm/gpio.h>
+#include <asm/mach-imx/sys_proto.h>
+
+int board_early_init_f(void)
+{
+	/* UART1: A55, UART2: M33, UART3: M7 */
+	init_uart_clk(0);
+
+	return 0;
+}
+
+int board_init(void)
+{
+	return 0;
+}
+
+int board_late_init(void)
+{
+	if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC))
+		board_late_mmc_env_init();
+
+	return 0;
+}
+
+int board_phys_sdram_size(phys_size_t *size)
+{
+	*size = PHYS_SDRAM_SIZE + PHYS_SDRAM_2_SIZE;
+
+	return 0;
+}
diff --git a/board/freescale/imx95_evk/spl.c b/board/freescale/imx95_evk/spl.c
new file mode 100644
index 0000000000..6305037923
--- /dev/null
+++ b/board/freescale/imx95_evk/spl.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ */
+
+#include <asm/arch/clock.h>
+#include <asm/arch/mu.h>
+#include <asm/mach-imx/boot_mode.h>
+#include <asm/sections.h>
+#include <hang.h>
+#include <init.h>
+#include <spl.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int spl_board_boot_device(enum boot_device boot_dev_spl)
+{
+	switch (boot_dev_spl) {
+	case SD1_BOOT:
+	case MMC1_BOOT:
+		return BOOT_DEVICE_MMC1;
+	case SD2_BOOT:
+	case MMC2_BOOT:
+		return BOOT_DEVICE_MMC2;
+	case USB_BOOT:
+		return BOOT_DEVICE_BOARD;
+	default:
+		return BOOT_DEVICE_NONE;
+	}
+}
+
+void spl_board_init(void)
+{
+	puts("Normal Boot\n");
+}
+
+void board_init_f(ulong dummy)
+{
+	int ret;
+
+	/* Clear the BSS. */
+	memset(__bss_start, 0, __bss_end - __bss_start);
+
+#ifdef CONFIG_SPL_RECOVER_DATA_SECTION
+	if (IS_ENABLED(CONFIG_SPL_BUILD))
+		spl_save_restore_data();
+#endif
+
+	timer_init();
+
+	/* Need dm_init() to run before any SCMI calls can be made. */
+	spl_early_init();
+
+	/* Need enable SCMI drivers and ELE driver before enabling console */
+	ret = imx9_probe_mu();
+	if (ret)
+		hang(); /* if MU not probed, nothing can output, just hang here */
+
+	arch_cpu_init();
+
+	board_early_init_f();
+
+	preloader_console_init();
+
+	debug("SOC: 0x%x\n", gd->arch.soc_rev);
+	debug("LC: 0x%x\n", gd->arch.lifecycle);
+
+	/* Will set ARM freq to max rate */
+	clock_init_late();
+
+	board_init_r(NULL, 0);
+}
diff --git a/configs/imx95_19x19_evk_defconfig b/configs/imx95_19x19_evk_defconfig
new file mode 100644
index 0000000000..fe968d5a23
--- /dev/null
+++ b/configs/imx95_19x19_evk_defconfig
@@ -0,0 +1,152 @@
+CONFIG_ARM=y
+CONFIG_ARCH_IMX9=y
+CONFIG_TEXT_BASE=0x90200000
+CONFIG_SYS_MALLOC_LEN=0x2000000
+CONFIG_SYS_MALLOC_F_LEN=0x10000
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=3
+CONFIG_ENV_SOURCE_FILE="imx95_19x19_evk"
+CONFIG_SF_DEFAULT_SPEED=40000000
+CONFIG_ENV_SIZE=0x4000
+CONFIG_ENV_OFFSET=0x700000
+CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/scmi/imximage.cfg"
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx95-19x19-evk"
+CONFIG_TARGET_IMX95_19X19_EVK=y
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_SYS_MONITOR_LEN=524288
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_STACK=0x204d6000
+CONFIG_SPL_TEXT_BASE=0x20480000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x204d6000
+CONFIG_SPL_BSS_MAX_SIZE=0x2000
+CONFIG_SYS_LOAD_ADDR=0x90400000
+CONFIG_SPL=y
+CONFIG_SPL_RECOVER_DATA_SECTION=y
+CONFIG_PCI=y
+CONFIG_SYS_MEMTEST_START=0x90000000
+CONFIG_SYS_MEMTEST_END=0xA0000000
+CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_BOOTCOMMAND="bootflow scan -l; run bsp_bootcmd"
+CONFIG_DEFAULT_FDT_FILE="imx95-19x19-evk.dtb"
+CONFIG_SYS_CBSIZE=2048
+CONFIG_SYS_PBSIZE=2074
+CONFIG_ARCH_MISC_INIT=y
+CONFIG_BOARD_EARLY_INIT_F=y
+CONFIG_BOARD_LATE_INIT=y
+CONFIG_SPL_MAX_SIZE=0x20000
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_LOAD_IMX_CONTAINER=y
+CONFIG_IMX_CONTAINER_CFG="arch/arm/mach-imx/imx9/scmi/container.cfg"
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x93200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1040
+CONFIG_SPL_I2C=y
+CONFIG_SPL_DM_MAILBOX=y
+CONFIG_SPL_POWER=y
+CONFIG_SPL_WATCHDOG=y
+CONFIG_SYS_PROMPT="u-boot=> "
+CONFIG_CMD_ERASEENV=y
+CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CRC32_VERIFY=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_DFU=y
+CONFIG_CMD_FUSE=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_POWEROFF=y
+CONFIG_CMD_SNTP=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_EFIDEBUG=y
+CONFIG_CMD_RTC=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_GETTIME=y
+CONFIG_CMD_TIMER=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_HASH=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_NOWHERE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_USE_ETHPRIME=y
+CONFIG_ETHPRIME="eth0"
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SYS_RX_ETH_BUFFER=8
+CONFIG_SPL_DM=y
+CONFIG_REGMAP=y
+CONFIG_SYSCON=y
+CONFIG_SPL_OF_TRANSLATE=y
+CONFIG_CLK=y
+CONFIG_SPL_CLK=y
+CONFIG_SPL_CLK_CCF=y
+CONFIG_CLK_CCF=y
+CONFIG_CLK_SCMI=y
+CONFIG_SPL_CLK_SCMI=y
+CONFIG_DFU_MMC=y
+CONFIG_DFU_RAM=y
+CONFIG_SPL_FIRMWARE=y
+# CONFIG_SCMI_AGENT_SMCCC is not set
+CONFIG_IMX_RGPIO2P=y
+CONFIG_DM_PCA953X=y
+CONFIG_ADP5585_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_IMX_LPI2C=y
+CONFIG_IMX_MU_MBOX=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS400_ES_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_FSL_USDHC=y
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_MT35XU=y
+CONFIG_PHYLIB=y
+CONFIG_PHY_AQUANTIA=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_MDIO=y
+CONFIG_MII=y
+CONFIG_FSL_ENETC=y
+CONFIG_PCIE_ECAM_GENERIC=y
+CONFIG_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PINCTRL_IMX_SCMI=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_SCMI_POWER_DOMAIN=y
+CONFIG_DM_REGULATOR=y
+CONFIG_SPL_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_RTC=y
+CONFIG_DM_SERIAL=y
+CONFIG_FSL_LPUART=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_NXP_FSPI=y
+CONFIG_ULP_WATCHDOG=y
+CONFIG_LZO=y
+CONFIG_BZIP2=y
diff --git a/doc/board/nxp/imx95_evk.rst b/doc/board/nxp/imx95_evk.rst
new file mode 100644
index 0000000000..5554e96f99
--- /dev/null
+++ b/doc/board/nxp/imx95_evk.rst
@@ -0,0 +1,114 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+imx95_evk
+=======================
+
+U-Boot for the NXP i.MX95 19x19 EVK board
+
+Quick Start
+-----------
+
+- Get ahab-container.img
+- Get DDR PHY Firmware Images
+- Get and Build OEI Images
+- Get and Build System Manager Image
+- Get and Build the ARM Trusted Firmware
+- Build the Bootloader Image
+- Boot
+
+Get ahab-container.img
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+
+.. code-block:: bash
+
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-ele-imx-1.3.0-17945fc.bin
+   $ sh firmware-ele-imx-1.3.0-17945fc.bin --auto-accept
+   $ cp firmware-ele-imx-1.3.0-17945fc/mx95a0-ahab-container.img $(srctree)
+
+Get DDR PHY Firmware Images
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+
+.. code-block:: bash
+
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.26-d4c33ab.bin
+   $ sh firmware-imx-8.26-d4c33ab.bin --auto-accept
+   $ cp firmware-imx-8.26-d4c33ab/firmware/ddr/synopsys/lpddr5*v202311.bin $(srctree)
+
+Get and Build OEI Images
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+Get OEI from: https://github.com/nxp-imx/imx-oei
+branch: master
+
+.. code-block:: bash
+
+   $ sudo apt -y install make gcc g++-multilib srecord
+   $ wget https://developer.arm.com/-/media/Files/downloads/gnu/13.3.rel1/binrel/arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
+   $ tar xvf arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
+   $ export TOOLS=$PWD
+   $ git clone -b master https://github.com/nxp-imx/imx-oei.git
+   $ cd imx-oei
+   $ make board=mx95lp5 oei=ddr DEBUG=1
+   $ cp build/mx95lp5/ddr/oei-m33-ddr.bin $(srctree)
+
+   $ make board=mx95lp5 oei=tcm DEBUG=1
+   $ cp build/mx95lp5/tcm/oei-m33-tcm.bin $(srctree)
+
+Get and Build System Manager Image
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+Get System Manager from: https://github.com/nxp-imx/imx-sm
+branch: master
+
+.. code-block:: bash
+
+   $ sudo apt -y install make gcc g++-multilib srecord
+   $ wget https://developer.arm.com/-/media/Files/downloads/gnu/13.3.rel1/binrel/arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
+   $ tar xvf arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
+   $ export TOOLS=$PWD
+   $ git clone -b master https://github.com/nxp-imx/imx-sm.git
+   $ cd imx-sm
+   $ make config=mx95evk all
+   $ cp build/mx95evk/m33_image.bin $(srctree)
+
+Get and Build the ARM Trusted Firmware
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+Get ATF from: https://github.com/nxp-imx/imx-atf/
+branch: lf_v2.10
+
+.. code-block:: bash
+
+   $ export CROSS_COMPILE=aarch64-poky-linux-
+   $ unset LDFLAGS
+   $ git clone -b lf_v2.10 https://github.com/nxp-imx/imx-atf.git
+   $ cd imx-atf
+   $ make PLAT=imx95 bl31
+   $ cp build/imx95/release/bl31.bin $(srctree)
+
+Build the Bootloader Image
+------------
+
+.. code-block:: bash
+
+   $ export CROSS_COMPILE=aarch64-poky-linux-
+   $ make imx95_19x19_evk_defconfig
+   $ make
+
+Copy imx-boot-imx95.bin to the MicroSD card:
+
+.. code-block:: bash
+
+   $ sudo dd if=flash.bin of=/dev/sd[x] bs=1k seek=32 conv=fsync
+
+Boot
+----
+
+Set i.MX95 boot device to MicroSD card
diff --git a/doc/board/nxp/index.rst b/doc/board/nxp/index.rst
index 8ca4b56198..e7ec725cc0 100644
--- a/doc/board/nxp/index.rst
+++ b/doc/board/nxp/index.rst
@@ -15,6 +15,7 @@ NXP Semiconductors
    imx91_11x11_evk
    imx93_9x9_qsb
    imx93_11x11_evk
+   imx95_evk
    imxrt1020-evk
    imxrt1050-evk
    imxrt1170-evk
diff --git a/include/configs/imx95_evk.h b/include/configs/imx95_evk.h
new file mode 100644
index 0000000000..2eebdadc51
--- /dev/null
+++ b/include/configs/imx95_evk.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2025 NXP
+ */
+
+#ifndef __IMX95_EVK_H
+#define __IMX95_EVK_H
+
+#include <linux/sizes.h>
+#include <linux/stringify.h>
+#include <asm/arch/imx-regs.h>
+
+#define CFG_SYS_INIT_RAM_ADDR	0x90000000
+#define CFG_SYS_INIT_RAM_SIZE	0x200000
+
+#define CFG_SYS_SDRAM_BASE		0x90000000
+#define PHYS_SDRAM				0x90000000
+/* Totally 16GB */
+#define PHYS_SDRAM_SIZE			0x70000000 /* 2GB - 256MB DDR */
+#define PHYS_SDRAM_2_SIZE		0x380000000 /* 14GB */
+
+#define WDOG_BASE_ADDR			WDG3_BASE_ADDR
+
+#endif

-- 
2.43.0

