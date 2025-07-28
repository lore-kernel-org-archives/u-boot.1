Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E5AC87FCC
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 02:14:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B457783013;
	Mon, 28 Jul 2025 04:14:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rdlPfgsE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD2678300B; Mon, 28 Jul 2025 04:14:17 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72C2382F14
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 04:14:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+hR6TLzxYhvS/fI6V+AQl6y6EUyzO9AYfzDNnhJQpe0u8HEU5Z9kml4MZHqSkg7dOVOoAJ4CWlG874YXpNNvsMaUTKPjDkR7SSQpe3yy9gd7ZKDsWkYa9gF9OYupOWZb3MMSNTS9vze++4AaJaYab354Iouwg2XAyp265dRnWb2gLXYlMkiOZZrQxVUEZWlsuMMU1HAP/lq7GZQsOAEWgH1KAoW6Un0pJg07/FV8ycyMQ6TS1G77KN61NgEFXBVSYsSvpdENUFjao+P3ylgqx00aTbuQ6kWYv0zGVUFn4lJ0uygDEheOHPgoBu1F1knSCjZQTIso37YGBs+0L+ZOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzG9tYpVXRoVe/YtDByuool3CWoY2JiRLeB1Ae2P+es=;
 b=tQBn6CBVXZ5/tAbwubifEhr2o+kzXLmNs3euDtrk7YMukxuwhgMSgwvgCTImDosnfRzhI17aZoz+DCK4ppr3t10NGQC61rU6lPPIyRqHn0xOBKmCbF1UO1QWNjMDHj8wecTzTOQOGnIO8+8T6B2JnOICi3JKkGZm3JVhGW75pz7T9+viduaI3SWMocAQZKSipaTMk1kid0Wa8YjmF1uGyCb7kyFZ1Y0DEsZc0qS3MVqUM2utaUkR3L3JPEVLaB/ZIrGBx6eFQUbXOdE1xM91aWXzhAWXTDuN+PgNCiq0feN3v7GWWYk2/M5T62Wuv3TnP8YJCKPdqLtUuPkf7uUyYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzG9tYpVXRoVe/YtDByuool3CWoY2JiRLeB1Ae2P+es=;
 b=rdlPfgsEQgY+Dno1g9SzdCTwuSqui8ogRihZgMCPrX/Bq2N0h2o8ftLU+ho4+x9myLW26VKfObeNjw699zxOuOTTay8WUqmS2sezePhyadYcUg5saaxdT3iWnwGmtH/Z/ocJDznozzP7bDE8NpTDQj6reloh04rGadOljPC+QdAhDWYJfMFJ+TngduKt0TB72fYlORVznz9Jz/xsFfMMwpfHBE9cuJzcaE5Ffui6LPg+YWW0521Q4YBUMAo+yVOlQmW377c37D7Ci1oU5mGV/BgAno29+pdE5E99aVki13HcfRZbcXwAaxgeAyY+wWopOn+SZ+QWnlx5C6YhKbeYaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8546.eurprd04.prod.outlook.com (2603:10a6:20b:421::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 02:14:13 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 02:14:12 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/9] ddr: imx: Various updates
Date: Mon, 28 Jul 2025 11:24:46 +0800
Message-Id: <20250728-ddr-imx-v1-0-73da75bb33d3@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH7thmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcyNT3ZSUIt3M3Apdc3PzJIuklBTjJKNEJaDqgqLUtMwKsEnRsbW1AEG
 BRalZAAAA
X-Change-ID: 20250725-ddr-imx-777b8bdd3b2a
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Oliver Chen <oliver.chen@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, "Tom.zheng" <haidong.zheng@nxp.com>, 
 Viorel Suman <viorel.suman@nxp.com>, 
 Florin Pavelescu <florin.pavelescu@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: MW4PR04CA0277.namprd04.prod.outlook.com
 (2603:10b6:303:89::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB8546:EE_
X-MS-Office365-Filtering-Correlation-Id: f6bd5be5-efa4-4416-b5e4-08ddcd7c71a1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d3ljZWVwcnpUNTA3QlptTHpCVThuVXdTeVFEaTFTQXA0UGlzZzhTeTlRYXRF?=
 =?utf-8?B?LytwSFNENzlHL1lUd1U0Yi9RZkJkVExVZ0dPZlBaRWhBZ1J3cURDVEpBVlZN?=
 =?utf-8?B?SnRLcHhXTU54dkU3MTFMVi9weUtWUXFUVWpwaFBvYXIvWS9uRmI1NEZnV1hX?=
 =?utf-8?B?NS9maFhPbGNrWGpXL3ZVWUFyZS9BK0NDVG40WmpZaDVJYXlhck5vMHBiSDJo?=
 =?utf-8?B?OG1PclFIWFdXWlRQSEtSalM1OVR4Z1hoT1VaYXhVSjIwTmlrc2IxS3pvSWJu?=
 =?utf-8?B?Y3lndmRwYmhCU0lSRlcvV2N5NFVVaGtuR29qUHIwSjAwQXRjTkZlTWlVUVhv?=
 =?utf-8?B?K1VLSnBXUHpzek8wdTZKRGtFV0pEejhIem1yRG9Qc1JGeGExZWhCV0dCcmFV?=
 =?utf-8?B?SnFaQ3BTSEdmTU9LSmI3djVRQXJuNFh4aUxXa0piN2hQWWc5WTBoaElneExD?=
 =?utf-8?B?eGtlREphVTFTcnpFODB6am5LczY3K2ZpOTAxeExhM05JVnVuV2lFRnczODhs?=
 =?utf-8?B?bHBzL09YN05FS0R4d0xFRTNocnRvT2lDajg1Qm1aMkNJbEZab243VXZ6WnJL?=
 =?utf-8?B?NWpjaUl4TzR4RDArN3BxLzlVbnJZWUI3Ly9uRXB0MTBQOFJYNXNFSFA2TnI2?=
 =?utf-8?B?bE1kZmFnS3V6dkZraW5DTUM2L0MyRlhkSGFKbTZQVDNmRmRjcXJiYWNLUW1x?=
 =?utf-8?B?S3lwQy9xR2FURnBiWTJzOUJlQTZPdzMzaGQyV2MzRlFQd3laLy90NWQ1eGRy?=
 =?utf-8?B?SlJ4NnM2V1kvZE94UXY4MURDVThEbUQzd2lPMXByWmQ1bWdoQjhhRXRrUnJF?=
 =?utf-8?B?RktnbllzMDBXK21iaUE5US9ERi9rWGg2V0k0NERObU94bFh4eDViait3VUxY?=
 =?utf-8?B?T0d1ZUErQkJ5YXoyemt0NEhiY2wrNVRIRk9JWWp0bGpJQjBUUFNGeU1VQ0pZ?=
 =?utf-8?B?Rm5yWGFHbEdMaWZUUnkwYUxUdzRodEIwdXo3MTlpSXRtblJJTVQ1ZGt4bDRD?=
 =?utf-8?B?SmQvd0t0bmVPZkxOZWhPNkVQdVNXYS93K1h5QlN3aVdmZzFwdHFFVGQreE5F?=
 =?utf-8?B?d3p0b2krbUVBdDRzUjZxR3RKK0tnRUJVRG9odTlPb0oyOUpsdEVETW5zUWRt?=
 =?utf-8?B?QlJ1eElXdjgrQjJ0T3B3Vlhlbm4xZUdUVmt2WUdpcUdYc241K0FyNlNPbEI1?=
 =?utf-8?B?ZFVEVUFuRklFenFJTkpZUWIzNzJBVjRESjZnYXFXeFZHYllWaElibmJ3bGxi?=
 =?utf-8?B?bXRVb2R0dTF1OUtWTWJxUCs1N01wYkhkREdxTEwyTlNuU3hvenFYVWtoTEt6?=
 =?utf-8?B?YzV5Yi9VRllnMm9yYTFkdTQ1NEhiM3lOL1p5NVZKdFVYalVURDVrSlNlNWt5?=
 =?utf-8?B?V2VMdGlNR2U4dHJWTzIyVUZDUHp0K2hnUm1yT0ZuMEFRL0t3L1BuZHZpSDV3?=
 =?utf-8?B?QWFSdHNOelBYTU56NjNOTnhZajlIUGRVajNLSVBML05HWEhERnFMMWZMR3NO?=
 =?utf-8?B?amlNZ3dGMm9jU1hFU1E3LzdZaEZkMHV6a2lvbkY2RGdqNVUvKy9VQWY2MzRI?=
 =?utf-8?B?YVVlQ3FEbDVpZmVseW1DVTNKRVR5UlZFMFN0cGt2WEZiclJoWmpteU1uK0Zk?=
 =?utf-8?B?T2xTR1ExSHFDbGJHMWdhTTVRN3l5NnBiREF2ZmFjRG5jK2krZVRpMXIrc2tP?=
 =?utf-8?B?NUtrUHFZS3lkWkdMOSthaE5LRFkzcXFFaklBVFY4QVl6dWtTdSt2dTluVUs2?=
 =?utf-8?B?bmFWSTZLNVQvdUR0YkgzK2FabjBWTXdBZlVBdHlZT1hmbGpRN0l0eis0NWll?=
 =?utf-8?B?U2phUzJjdlYvN2Z6SjlvWjV4M2J3R25Uc3p2b0o5dGZRMVRHd05nY3htcnA2?=
 =?utf-8?B?RzRhTEhJT3AyOHBCV3JqMGZQRnFDWDlhUGxwaTF2UHN1bHdIakxLdkQ2cWRJ?=
 =?utf-8?Q?mJ4bopNX3uo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlJNdXJpRHgrMVRBNTFFbmdjKzMrK2hCeTlTZEV0Mk9yRndkT0ZWWWFGUlU2?=
 =?utf-8?B?V2JkSmprcnRiVDFaUDJDdHlEalVjMFFWcnRNWHN1SlIzWDFhOXlwNURoK3hr?=
 =?utf-8?B?dURyVmh2c0hzaG5qVld6MTBUSWU0eXFsRmdKcDhrUWJCTGsyVFdxam0wbDhC?=
 =?utf-8?B?dHUya3J6alJ6RHpsMHI4ZFZ6Yi9YRWxERnlMZVFRWjJsbURzNTRGRVpNTmp1?=
 =?utf-8?B?NWlEcjNhZkNtK0J2RTBCRDNxNjNyOUpwK1piVEdoc1VGN1NSMUVmK3ZTYUVR?=
 =?utf-8?B?M0Rob0drMnhsK1Y4SGxzaE80ME1mWjczT1lyTW1laDdNN0wvQk9LTThOaGl4?=
 =?utf-8?B?a0t5YkZzTnZ2TVJjaitnWTdPekdIN3B6bzdNR2x1Z1ZvK1JCKzFIRWFXdm1T?=
 =?utf-8?B?R2hxU1ZtZmRtUGhoRE1YbUpJYk1SR1FLQU93NXhsY1RhcnA2MmZpd2V1VmY5?=
 =?utf-8?B?Y2FncSt6b2pvN1FYaWRCMG5JdG5WUnFMUnd5WHMxZlk1bkhrQkpzM3l2MDNw?=
 =?utf-8?B?aVJLWStJVVFpSVNRMU5ZbVVLRVpab2lHeDNDcVNPaEhkNTlVSFQxVGhCcHRV?=
 =?utf-8?B?TURTSlByS2VNOXYzNkUrUDJuZFJVU1VHeC9uUHFjTGg1ZDBSaTA0L3lldXVM?=
 =?utf-8?B?RHFzRXNJU1haQUZEWWxrNzAyTk8wcG1zVDZJOGZ4L09lYUpkR0VsU2ljdFlj?=
 =?utf-8?B?NGx4dWw3bURYcWk5UVFGU1BRZmE5U1hac0E2V2dMck9NVzdDdEs5alM3K2dF?=
 =?utf-8?B?Yms0N0x5VGdteUY1d3UzSkxtb3FqMmVmUk5ZZFYvWmRwcHEzWWxFZWl2VWx4?=
 =?utf-8?B?bm5GZmJkQUNyWW9tR200MEM3enVsQXhKVmZsQWd0bzVDcDV5Vmw3dEJtTDl6?=
 =?utf-8?B?QVUzQmFzeDlWbldoYnRYN25ESVJZdjJnNENHY3BISEpWMVFIVDNwbG1wbEF3?=
 =?utf-8?B?Sld6SEJaNmVTclowS2JxYUllZis5ZDVKN2RuZGp5RTE4elhTM1R6WktaSXFM?=
 =?utf-8?B?akpWYkZYV014WTFSbit0cFdpUmcxUkYrVHo0SkUrQ1BxSVBDWEE3Qm9ITTVK?=
 =?utf-8?B?QU5KSzBOUUtHOUwxMURQazJPUjVpTHA1U3RaTmxhWkdpcG9LQkRoVy9pU1lN?=
 =?utf-8?B?RDFpUmFCeTZIamVqZWwreUxWdjJnMVYvZkZHcVVseEQycnYxSnpEMXNWc2po?=
 =?utf-8?B?eGlNU1A3UEFvaG1ZWmNvcUQramxyUjJuK3QwQVhVN1BjdlhFYXhZcjNkdnhm?=
 =?utf-8?B?cXdnTUxTcnZvU3MzUjgxc0l2QjZ0T285QWpOWUdnL3dOdkZwZm5RVmxvejAy?=
 =?utf-8?B?aDE1ZXFTNVJYRVQ1SEVLWHN4QmYzQlNVekg4b3JhUXYvWVNCTzFKNzF6ZVpx?=
 =?utf-8?B?dkg0dkJxUnNCRmNmM1BjWml1eDNUMGtqMmlObzliQW5sajNnU1AxczFYYjF1?=
 =?utf-8?B?azVTZG9FaWNrYnV0VVRHWGxXSnNtZWxubXZsZ3ZaeHVkd3cyTmlnSUppb3h3?=
 =?utf-8?B?dmFNeUZ0M3VUblZKSW9LdS93WEVoOElxZ3M2bkZMT204SDRRQVJ2cm5tNkpm?=
 =?utf-8?B?SnQrOTVENjJhSE5RZkVWWGZWeWNwNWtZS1BKQ3pvaUptNUI3UWVqRXg3R05K?=
 =?utf-8?B?ZkhhNHlPOGZjVTNaOWJ2Q0V0cGtjRk9ubnYwSlhMdGNjWEJTSU1QSFJFMmF2?=
 =?utf-8?B?K1lxallTdXV2cEVJZUx0Vmh1Tko4Mlp6RlJrQTY0V2MvSjZqY3psVUFQRmpj?=
 =?utf-8?B?aXhidEhDNWlTZTZLUGFsRmdERGEzKzZwUThyVXUrcXEzYmpFTzBBaVZZYWhw?=
 =?utf-8?B?ekZCcGJwNnhUYXg3cWNEaDVPQUlyeXZyRWdlV0JiNnFUcW1OQmlHVWFQSThC?=
 =?utf-8?B?T052NUZGMHlCMWYyajU5OHhYWlVycWtvYjRad1NpWjVmVW5VKzVpa213STV2?=
 =?utf-8?B?MzBnV3pBc3ZDQytZdDJia0M0dzJWOGR4ckZJdGlNNVovVDJMVWFGYURMR0cx?=
 =?utf-8?B?S2l0b2QwV0hIa0I0RkJsOUJXV2hsSVVSYTlQZHpCRFlzTjJINVlJSThWdWMx?=
 =?utf-8?B?WkoyUEhoUDVjd3NPL0h1ZGRVMjU1T1ZkWm1hWmd2dWd0MDUzb0phWVo4UGpk?=
 =?utf-8?Q?AfG4JRSjP6GIZUeit/+SXS9bQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6bd5be5-efa4-4416-b5e4-08ddcd7c71a1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 02:14:12.5100 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rTrxwcrjkYMNZ1e/vEIjt4mxVQpIeqwdL/Bu3wzQLhXGaBCX2jUQ0mLL/026Ds5TsWk9tPMAsEeKJR9KWBaPzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8546
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

Collects NXP downstream DDR patches. The patches are directly
cherry-picked from NXP downstream with minor checkpatch warning
addressed, so tags are kept.
Only one minor Kconfig update patch is new which is to drop dependency to
IMX8M_LPDDR4.

- Fix i.MX8M DDR inline ECC scrubber configuration
- Fix i.MX9 DDR MRS
- Wait until dram initialization complete to avoid unpredictable behavior
  when inline ECC id enabled.
- Disable dynamic refresh rate when do mr operation for i.MX9
- Add Quick Boot flow and errata registers support

CI: https://source.denx.de/u-boot/custodians/u-boot-mmc/-/pipelines/27190

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (1):
      ddr: imx8m: Drop the dependency to IMX8M_LPDDR4

Tom.zheng (1):
      ddr: imx9: Wait until dram initialization complete

Viorel Suman (4):
      ddr: imx: Move reading LP CSRs outside "ddr_cfg_phy" function
      ddr: imx9: Add Synopsys LPDDR training data collect
      ddr: imx9: Implement Synopsys LPDDR PHY QuickBoot flow
      ddr: imx9: Add errata registers support

Ye Li (2):
      ddr: imx8m: Fix DDR inline ECC scruber configuration
      ddr: imx9: Fix DDR MRS bug

haidong.zheng (1):
      ddr: imx9: Disable dynamic refresh rate when do mr operation

 arch/arm/include/asm/arch-imx9/ddr.h   |   29 +
 drivers/ddr/imx/imx8m/Kconfig          |    2 +-
 drivers/ddr/imx/imx8m/ddr_init.c       |    8 +-
 drivers/ddr/imx/imx9/Kconfig           |    8 +
 drivers/ddr/imx/imx9/ddr_init.c        |   60 +-
 drivers/ddr/imx/phy/Kconfig            |   12 +
 drivers/ddr/imx/phy/Makefile           |    2 +
 drivers/ddr/imx/phy/ddrphy_qb.c        |  104 ++
 drivers/ddr/imx/phy/ddrphy_qb_errata.c |   39 +
 drivers/ddr/imx/phy/ddrphy_qb_gen.c    | 1845 ++++++++++++++++++++++++++++++++
 drivers/ddr/imx/phy/ddrphy_train.c     |    4 -
 drivers/ddr/imx/phy/ddrphy_utils.c     |    2 +-
 drivers/ddr/imx/phy/helper.c           |   39 +-
 13 files changed, 2142 insertions(+), 12 deletions(-)
---
base-commit: 4c3b5fcd810081bd7f3c51859fe1b5f0c159803c
change-id: 20250725-ddr-imx-777b8bdd3b2a

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

