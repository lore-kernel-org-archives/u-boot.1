Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2449EC71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 07:32:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61DAB82D66;
	Wed, 18 Jun 2025 09:30:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bCE0qqeR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EEA482DA1; Wed, 18 Jun 2025 09:30:49 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF64A82B18
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 09:30:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jM1TdnisxMbjP8AEqKv+d8+4Vx8OC5HYwypShOy4D2IwTCXhHDUjsJtzskQ4FuxKjDn5dyKldSyllnCtB9+MIXH9iQAtkugv1rKeAtpWdh4zvT+Wf5VzKx73o3mIHu+zguyjzSVZSw6+490N0irvg58TSsaYHPZuMt9MGyKlCHAL/RcFMHB649uMCphNDRNQJ+bxC9udf05VqkeDWDMDLzSdA/qPNQg0kCH92uYH6xJ9+rTQVyRurIVQBNbknW6fPHHix3f1+lX1a3u7ebTeNM3b9+lUZLpUhDEF1je76Rz/Caci7Phlw49EaRDW3k/XVpgCof55HN9HhEbOzYWUAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=216N5I037QI99eO3nPBz83lgP7DIDK752qOn6HWpC4o=;
 b=ErtFMPInrJDccHrIKvk8HdgiUIPx5G98u/75UBFFP/A13hpNG1uCvv9zL60uj85OLqHES/FhVoJXIN+eT+nSQGBIAGk2p/GkwbWljegymfjQUeNZWNsR/0XIdg/t7QucfMy591UG9uWmOFPdX3/OxpxJWQqUOCpnlXp4WOnefqmCmHUr9Qb+t9b11olMYdTB+qhCPg0MMthcm48medCDRpUJxcGcdfps1n6vMM1BNS49qbjF+wGYN+l+mSQeOM4EmRwL7omkbMsoJ3YdvXxZbPxoGK6ln56NxmFaFqOm8Lm0D/46rWjPhP82KO9R/DPvmVpq3xkznE3boPZwJt5Byw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=216N5I037QI99eO3nPBz83lgP7DIDK752qOn6HWpC4o=;
 b=bCE0qqeRGC5nLAXjIFVv0DtUxXeG+91LPfp5Wwk2EOLP+y7EqbdUHntoMtLzON7SDUTWDAl+hbleFEsK93zdPpW5lJ6FaSQlyg4WTgpReMbq/Nqj3URzxjXCBVCo+CaF6fxJAEGO8kz9v/Ua0Ct7nlB1bIO2Shyn+qP09ZvsYMIOSK+Py/1gPnogw/lO7RpfeKhQgfUldxyny/dMpyqu8YZFIiAcvCTTCohUtZ6T2b08WJuCSRZZZnFJRq4qVpmnyOMVxrzysXBV8d+h9wnmImp14vrNUZnAYIObFRkejiwCRKx7g7+JFQTtCUlAnWPjMfFfl74VlTdNXyAX6B49mA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI0PR04MB10928.eurprd04.prod.outlook.com (2603:10a6:800:261::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 07:30:44 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 07:30:44 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Wed, 18 Jun 2025 15:30:21 +0800
Subject: [PATCH v1 8/8] imx95_evk: Add i.MX95 B0 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-binman-v1-8-373e66c7a51f@oss.nxp.com>
References: <20250618-binman-v1-0-373e66c7a51f@oss.nxp.com>
In-Reply-To: <20250618-binman-v1-0-373e66c7a51f@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Alice Guo <alice.guo@nxp.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>
Cc: u-boot@lists.denx.de, Enric Balletbo i Serra <eballetb@redhat.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR01CA0191.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::6) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI0PR04MB10928:EE_
X-MS-Office365-Filtering-Correlation-Id: b956814d-0c5f-485d-6438-08ddae3a0964
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eGloSjAwMUNYcUMwd0pXMk54QkZLUUIwajF0djNnaGZtS1NlSFhJSmpMUHFp?=
 =?utf-8?B?eDBUTjhiOFJ6ci84ZDdRSDQwMGhKU1ZydzRLalBCSzVxZ1B1VUFaeUVtODhQ?=
 =?utf-8?B?UDY3ZG5pWFNEVUxkZzNlbVVhTGtzSWp5a3dOb09CbmFLZDI1NWdOVktZL1A0?=
 =?utf-8?B?SUZzY3pKWERvVm43NTFRa2dnVFRXc1FVbytQbnFxbUhROUprM3Jpb3FmZyto?=
 =?utf-8?B?azlEUS9wL3NmSGNhdHBDSUZuY0p4K1hReU9HWGtpV1FZZ0JUeTV0OEk2ZWVN?=
 =?utf-8?B?bkl5bVBBVm5yVjFmTVVmV29NYThjNFYrWkxhY2ZtUU11QTZuQWJBdGVXUUQy?=
 =?utf-8?B?VXpsbWZ1SE1EVWpSTzhBc3dxUU9adFFKMC9GL0ZKL1lVcFJZNmhtYmZLdUcy?=
 =?utf-8?B?SFVxeTFka0VsNklhZmp6aHZIMnVYNHBzdnlwN0RBdU5hTElNWVNsN3Vzckkz?=
 =?utf-8?B?aVhQUEJML3JQcjBlQzcyUTVkSE8xWW1aczlWTWlXS25udHppVVQ4c1pUVlNO?=
 =?utf-8?B?VnJPZEtyNWpmNml3WVJPRzRrZ3QzOTREako5c1R1R3EvazB2TnFTRm13dHpi?=
 =?utf-8?B?TlZkSVVubkxzQ0d4UXBlajZKOXZPQmhIWXNvcHg3ZW94dHB3S1hWZXVlWlV3?=
 =?utf-8?B?bjZDcEF5ZVFZaXdGU1BrbWg3YnQrK2doWVRGVy9sajV4bTlQa0NsT1I0UDhG?=
 =?utf-8?B?cHJaNmZLa3V1Y3BqamtTNTBJUXIzTEt1T24vUlUxTmNIUHJQYm9BdnVNc2RF?=
 =?utf-8?B?VE1ZWjFpcFdnaCtxK2hncFp0NWx3bHl3OGJSUkdqcVFQcUw1bXBWOHEyWHgr?=
 =?utf-8?B?WVhudlhoa3RJbVNkbCtaR1c2ajZENmE4ZW1oZU9KRXV6Z0lINFcwcmoyU2dt?=
 =?utf-8?B?R2h6cnlwNHREb2l5cFNsSE9xbG1XRTVlcHMwajRJeTVEeGJWUnNTWlFuVmlH?=
 =?utf-8?B?SHFiNU1ZYW1LMmRoaXFLWnAwSXV3eVlZVmNtRmJONDJqVGwrNjFURi81SS9k?=
 =?utf-8?B?VEJYUnFRZXFCckF2K0lSZmNnSmFmUnlyb0w1cmJlRXNYSytQcDRLK3VwOFJx?=
 =?utf-8?B?YmpPaGJVZUVmdXFJekxKdFExTGFKVXVqR2JGNU8rZC9ZT2pvZnI4UkZLSkRE?=
 =?utf-8?B?WlBpWXhrbXY4SmVidEt4bXR0bE01SWM2U3pDaXBOL3Z3S3M5d0V6dDBIakl3?=
 =?utf-8?B?VmJsSUN1d0NhVFdLMmt3MzJ1QXhtOUxxUTFmcXJTNUJwejRBQlFsV1ozanB6?=
 =?utf-8?B?TG1OMVY2K2prVDd2VWtvQ2xzT2ZQT1FnSVJ4NlNxVXdvMTJYWitHUFM4MVB3?=
 =?utf-8?B?Q0d6LzNhSmVtOStlZ0ZJNnhaSGw3TS9GTkxiS1QvSEZjWDRidDdjTkZrQkhH?=
 =?utf-8?B?ZGQzZ1lmQjhGSmZpOFY5Rlp4MThxTDh2dGpGdVJyYUc3Tk1iSjNrTzVlUEU4?=
 =?utf-8?B?UDBSSk9xRENDek4wS05zTzhZWjd0OUFZaTlHZXpsZTlKc0UwQm94TzNFcTYy?=
 =?utf-8?B?VHZRTmtmNEp6Q2FmV0tOYmhJalV6TFZyNG9DckZjMXBDeEtLcWl3eUlNaWk2?=
 =?utf-8?B?S1lWV3p2TW1JcVFyMy9PbDRBbll5VFgwOStaQzFWcVVQTFEreENkcEwzamF1?=
 =?utf-8?B?bm1zMUpXQ0hLSkIydTgzZmowMDZYMVdFVFRQblhWK2RrdFhIVmQ2V3FBNDNC?=
 =?utf-8?B?WFZaRjloaVIvVWJEZjVIY05SWlV6M3Q4M3dGTVVBZjJORjlYK2UxTXRkYWgy?=
 =?utf-8?B?bUlXNCs5b3pUclhiYnQ2WHNIY0diQUNtSTFxK241UmplTC9xNkFUOEJYc2Fq?=
 =?utf-8?B?cGN3WFF4empHRjdxeVN4cndGTVlMMUtMQjRvM2MyNDBuSjlOamw5REgwYTZo?=
 =?utf-8?B?Z1BHOHozTEIwNWRaRXo0UzhQTDhBdHMxUzYyQ1QxV3NCeWVTdmIxNG5WV24r?=
 =?utf-8?B?VjhKTFkzOFdWdXhrcnM0QmgxNEFITDRGQmVuWlhlcHVPZXQyVVZoaWxCemFX?=
 =?utf-8?Q?bwZIzqIMc4QSfKkZao7kE3KIrBZtz4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0o4V0RBelBhMld6WVBmaE9kTUswcVVsOWpTWndSR1ZFVHRYaVl3UC9ZQ2hw?=
 =?utf-8?B?aGhrV0lIcmpuVVQ4Y0djUFVUMUI1SW5HQWdsZlJ4L2ZiTlp5Sk5oNkxoeHZq?=
 =?utf-8?B?Y3g1UkQrSTV0cWR3RjU2a2JNQXgwNU9aSjlTczEzeS9tNTRIZ25ldTdsMXgx?=
 =?utf-8?B?OGZNbnhZNWJSVjdvMmJNZmo3M0lnNHowTHY5WUlCbnBGNjFTOVBoS3R2VFRp?=
 =?utf-8?B?VlZyU002UkFlbm44enRSNDZrQUI1Y3BKam9IUEd3QXNKU0UzbGsySXUwQVZW?=
 =?utf-8?B?WVJmSmE4c1VhYmtIUUtaWENSRDlmQ0VaTTJGUHlscjgvSFhTY0ZGcFQ5enRP?=
 =?utf-8?B?NzZ1ZFhjYXVONmE4ZWpVQzdKTkNxL0diTWt3VUVBTzNBZ3NJYUUyQWZld2ls?=
 =?utf-8?B?TjV3TzJEWXM4bm1FSUxsZFJEdk1BL2lxR1AwVU1lYk1SdmZlTWUvVkVwV1dr?=
 =?utf-8?B?SUdRQzkxdjJvSVh5aHM4akNxSjd2RUZzWFFFQXlEQkM5WUlZMDlLVXdhSmg2?=
 =?utf-8?B?NnpHcU55MGt5Yk5yclJHVTkrZTZON1VmMHkzeVJEek91N2U0Q01sNC9qYnlX?=
 =?utf-8?B?VE9oZ2YzZ1FCc2dxallrK25MSE0zaWE1KzQzTGFVbWk2Y0xtNFFQMnFnYitO?=
 =?utf-8?B?NXlGQ29hRkEwN0Rpd2swQlk0ci8rUWQzaFh2QnpiWEJXNFhIU1NYcjNWTzVN?=
 =?utf-8?B?YXVLamtIOWhqQjJhR0hFRnA2TnFOL0FjL2hFaFlmdkVqWFY2cWQ3ejVReHdq?=
 =?utf-8?B?V2tmVjRmYlgzekZ3Qy85d1dlTXp3Yk9xNWVKM2pXdkE0VG44bUh3WWh5djFp?=
 =?utf-8?B?OC93OFIveE1DM3JzVU1mNDJaQVVDNGo1bzdVL1c1MnVabVU1TkdlMlFhU05N?=
 =?utf-8?B?cFhmYlBra1pDOTJDTVdzRlVWUVhZM3BsV0ZlemMzTWd2VnVKUVRSaUVhak1m?=
 =?utf-8?B?a3Zwb1M3ZGdSaUJsVHJsZnhLOVF1SVFiL01pZk82alhlc3h0azl4OWVabGlL?=
 =?utf-8?B?SkNNSEtBM1lwQUF2ZHNDZDBLNVFQdXVHOXZ6UGFZVVFKczhVc3FtZXI4NVJ0?=
 =?utf-8?B?cy9uN3VaNmxXYzBQQ3ltb3RQdUFUaE5PcitwbFZkbDZVSnE2bjZTWitoQXFy?=
 =?utf-8?B?aHpkbWxsamc4d1VON1I1enJZQW9SN1JucG1pN2pOUVUvdHAzd1VMN0dVTC9j?=
 =?utf-8?B?QkE3RklhWUlDcTJCV1RveElYVzdFUUNGeGVnSEVuUzN0S1R2TytLdWl4UnU5?=
 =?utf-8?B?M2xETlYwNDRxbk51MkgvRWNvbm9RRFJBTlV2eTR2cjluQnBvTVY4WTZORlRK?=
 =?utf-8?B?US96U3ROMHlxb1hOeFBmUjFGaVFoSUZYdEhRT08xQVZCanMyNUFFMjFYd1lM?=
 =?utf-8?B?eEdkMEQzMUtGM1J6d3haVEI3cjNSOWpQMm8rc2pyS0w3QnlFemFQcmRnUEJp?=
 =?utf-8?B?OGdLMDRpODl2RGZEM29vcjV2RFZPcnBFVHkxMTAyNUE1OGFTdVZCeWROWDlL?=
 =?utf-8?B?N08vVEQ1WGpGSUVVWjlQSGs1TStyMHBkUXp2NGZzT0E4R2s2bHRrd0kxNG16?=
 =?utf-8?B?Vk0wSVpSejVCZXJZMnJ0V3JodWk4RTVNaktZTkE1R0d1UVRjMmJPS0NvaTF6?=
 =?utf-8?B?clk2eDdoRll0cnRodW56MCtqUDdJQTBvWVE4NXpPMVdjTXQ2TW16UnRKZkll?=
 =?utf-8?B?YXlwZGF4WWM3WXdUYlR3MXVXT2NqcjJaUjQxSnNtYU0yVjU5UnRBanU4Zk5E?=
 =?utf-8?B?UDdRaFdldDVjSGVTb0NncW55ZHdad25xdzdTY3hZWHVPVE5hbENnSnZoU1JO?=
 =?utf-8?B?L1dBcEkyNnV5NTA4K0lHeDJRVGVBU2F5NUJyRDVjL3Nkd0JYSWRiTkVQWGRr?=
 =?utf-8?B?MVVxdWxCbllsbGhJOUgwUHgvTjFNRkdlT08ybG1BUG01STByNmhuY0xPNmVW?=
 =?utf-8?B?ZkNjVnJxdys4eHpWTjlJL2Y4VzVIOUxoTGdoWEV1UW5GWjhDMFdjcVFiNWtC?=
 =?utf-8?B?SE1nMEk3bm8rbk05UjRaaTFvU0pnb2daRHRMVWU1dWhZSCt3WGJTMExGMlA1?=
 =?utf-8?B?a0VNZUxpdjh5RDhVL05oZGp1aGdlWmZjVFl3S3Y4Y01vRW5BTm4vTjRlTG45?=
 =?utf-8?Q?DkYSOjxE/oTcU+dmu+ihIIRZs?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b956814d-0c5f-485d-6438-08ddae3a0964
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 07:30:44.6991 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lvTjwH5FPeOrsltRjCCfK+HQzVVK8ENrrQuyfTBN8abRCB7jq9ruecYdSNzy0MR5EcJiU7ksxI9gDjhq1DbjOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10928
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

i.MX95 B0 uses image container format v2 and needs DUMMY_DDR so that
update imximage.cfg and container.cfg for it.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/imx95-u-boot.dtsi            |  8 ++++----
 arch/arm/mach-imx/imx9/Kconfig            |  1 +
 arch/arm/mach-imx/imx9/scmi/container.cfg |  1 +
 arch/arm/mach-imx/imx9/scmi/imximage.cfg  |  5 +++--
 doc/board/nxp/imx95_evk.rst               | 12 ++++++------
 5 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/arch/arm/dts/imx95-u-boot.dtsi b/arch/arm/dts/imx95-u-boot.dtsi
index 5ec3b1c51d6..9bf8f9834c9 100644
--- a/arch/arm/dts/imx95-u-boot.dtsi
+++ b/arch/arm/dts/imx95-u-boot.dtsi
@@ -22,12 +22,12 @@
 				type = "nxp-header-ddrfw";
 
 				imx-lpddr-imem {
-					filename = "lpddr5_imem_v202311.bin";
+					filename = "lpddr5_imem_v202409.bin";
 					type = "blob-ext";
 				};
 
 				imx-lpddr-dmem {
-					filename = "lpddr5_dmem_v202311.bin";
+					filename = "lpddr5_dmem_v202409.bin";
 					type = "blob-ext";
 				};
 			};
@@ -36,12 +36,12 @@
 				type = "nxp-header-ddrfw";
 
 				imx-lpddr-imem-qb {
-					filename = "lpddr5_imem_qb_v202311.bin";
+					filename = "lpddr5_imem_qb_v202409.bin";
 					type = "blob-ext";
 				};
 
 				imx-lpddr-dmem-qb {
-					filename = "lpddr5_dmem_qb_v202311.bin";
+					filename = "lpddr5_dmem_qb_v202409.bin";
 					type = "blob-ext";
 				};
 			};
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 280d255c086..81f75b92bbb 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -31,6 +31,7 @@ config IMX95
 	select DM_MAILBOX
 	select SCMI_FIRMWARE
 	select SPL_IMX_CONTAINER_USE_TRAMPOLINE
+	select IMX_PQC_SUPPORT
 
 config SYS_SOC
 	default "imx9"
diff --git a/arch/arm/mach-imx/imx9/scmi/container.cfg b/arch/arm/mach-imx/imx9/scmi/container.cfg
index 441d9beedd1..b25f3b726c5 100644
--- a/arch/arm/mach-imx/imx9/scmi/container.cfg
+++ b/arch/arm/mach-imx/imx9/scmi/container.cfg
@@ -3,6 +3,7 @@
  * Copyright 2025 NXP
  */
 
+CNTR_VERSION 2
 BOOT_FROM SD
 SOC_TYPE IMX9
 CONTAINER
diff --git a/arch/arm/mach-imx/imx9/scmi/imximage.cfg b/arch/arm/mach-imx/imx9/scmi/imximage.cfg
index 6af1c4ba628..c2c92174c1c 100644
--- a/arch/arm/mach-imx/imx9/scmi/imximage.cfg
+++ b/arch/arm/mach-imx/imx9/scmi/imximage.cfg
@@ -3,13 +3,14 @@
  * Copyright 2025 NXP
  */
 
+CNTR_VERSION 2
 BOOT_FROM SD
 SOC_TYPE IMX9
-APPEND mx95a0-ahab-container.img
+APPEND mx95b0-ahab-container.img
 CONTAINER
+DUMMY_DDR
 IMAGE OEI m33-oei-ddrfw.bin 0x1ffc0000
 HOLD 0x10000
-IMAGE OEI oei-m33-tcm.bin 0x1ffc0000
 IMAGE M33 m33_image.bin 0x1ffc0000
 IMAGE A55 spl/u-boot-spl.bin 0x20480000
 DUMMY_V2X 0x8b000000
diff --git a/doc/board/nxp/imx95_evk.rst b/doc/board/nxp/imx95_evk.rst
index 9121f7561ab..27cd15eb7c9 100644
--- a/doc/board/nxp/imx95_evk.rst
+++ b/doc/board/nxp/imx95_evk.rst
@@ -23,9 +23,9 @@ Note: srctree is U-Boot source directory
 
 .. code-block:: bash
 
-   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-ele-imx-1.3.0-17945fc.bin
-   $ sh firmware-ele-imx-1.3.0-17945fc.bin --auto-accept
-   $ cp firmware-ele-imx-1.3.0-17945fc/mx95a0-ahab-container.img $(srctree)
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-ele-imx-2.0.2-89161a8.bin
+   $ sh firmware-ele-imx-2.0.2-89161a8.bin --auto-accept
+   $ cp firmware-ele-imx-2.0.2-89161a8/mx95b0-ahab-container.img $(srctree)
 
 Get DDR PHY Firmware Images
 --------------------------------------
@@ -34,9 +34,9 @@ Note: srctree is U-Boot source directory
 
 .. code-block:: bash
 
-   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.26-d4c33ab.bin
-   $ sh firmware-imx-8.26-d4c33ab.bin --auto-accept
-   $ cp firmware-imx-8.26-d4c33ab/firmware/ddr/synopsys/lpddr5*v202311.bin $(srctree)
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.28-994fa14.bin
+   $ sh firmware-imx-8.28-994fa14.bin --auto-accept
+   $ cp firmware-imx-8.28-994fa14/firmware/ddr/synopsys/lpddr5*v202409.bin $(srctree)
 
 Get and Build OEI Images
 --------------------------------------

-- 
2.43.0

