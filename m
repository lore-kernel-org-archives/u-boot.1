Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3ADEE77198
	for <u-boot@archiver.kernel.org>; Sat,  4 Jan 2025 03:21:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA430803F6;
	Sat,  4 Jan 2025 04:20:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MCmnveuw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 993FB805CB; Sat,  4 Jan 2025 04:20:01 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::62a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DB1F803C6
 for <u-boot@lists.denx.de>; Sat,  4 Jan 2025 04:19:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iYT8C2sJsMdseZy9brwo+U+xGG7RwU5GIi+ZRAxmJPwa3I3hAgKhcBFyUcr6BwQqSyX8VB/NKA/ntGdLTwp3jgnLfldknXPUaWAOgq/63ztanzucjIesbcYb0fPKf/pvlIbv7OXIECpxyK7RRpWCEx9sSso1HwMyq9y98JDmKH+oLRRR6brx5OMqh+91Upq9VX5z1uBX8p9f+zsPQtxEeC+QInPACaEsAwU9ifsZCA6m21in6iwBKa5vRtBXMnDCOga2KS4tPHdOsfdUgMc0L9noAXRdfKFDC+Lx80ESwoY901c+THhgfOTPvvbSdVVq7zy35X7q0HSZp/9UZzZimw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LTL98YpXEVUSWdrO+0EMFFiIc3Ic+qvXBei5HetxvP4=;
 b=RnCKhYov3RBAUiQnRoR1B1b+agAFRx09Vv+iH9rTAFBFhG78/mymICKMi2CY1pK9KnEbLCkE/d2yWeEky3te2e2pKL4ZJkMJH5NHfVDqwQgZ+qWr1RKIS4uuhuHkzfM48bfQjOZrGNrK5hglgXhJtU6nqxmJrds3hyXY3EwOnHis7BgwHDDHD6yWj+XuCu2x9X0KxnDmJdigSLSgTE8m96lmAMsPVCY8qgsKO76gtDO7FXmAZk7joj6PLpPi4JJ5+33nTek/8/oB5AZ0bDvCVX6EF3N/mJm45sQuuF07Hvve9oABt2JXukwdo2DlINpv0a9Nxzb4HmG71ux1AUuG3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTL98YpXEVUSWdrO+0EMFFiIc3Ic+qvXBei5HetxvP4=;
 b=MCmnveuwuTIqP54lTRUFyxHEHRla66pZ6OfW8MmZg3J/SRzhTufFvbXy1w67jCEfsBS9ZSylBoQjEHNG5kcjzhIhN6Az8WFGTvVW8Ydiie1KnCIBF3WaOKbTuvJfNCgShsUfEL2ZLN8vTPSNIkGjZOIVFjDkIpbcq+CJDdS0C+CQJfu9kagZL/wy10xMtDFchOzp6tnp1zf78kDwcNCmF0CzfWZRFY0Z7vqXLPBL7LOTru60tPbji/2mrkUwO4ELdJM9l+PwoTe3x262iRqjLTsa9zSDASzXiHplg1+4hLmrY0b5rebh1146pthrFQFCUyLITW2nhjdVF6SHeFZCEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB9566.eurprd04.prod.outlook.com (2603:10a6:102:26c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Sat, 4 Jan
 2025 03:19:54 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8314.015; Sat, 4 Jan 2025
 03:19:54 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 04 Jan 2025 12:25:43 +0800
Subject: [PATCH 09/12] imx: imx8mm_evk: Switch to BOOTSTD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-imx-bootstd-v1-9-e09618cc1d65@nxp.com>
References: <20250104-imx-bootstd-v1-0-e09618cc1d65@nxp.com>
In-Reply-To: <20250104-imx-bootstd-v1-0-e09618cc1d65@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2PR01CA0151.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::31) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB9566:EE_
X-MS-Office365-Filtering-Correlation-Id: c7923ed2-0777-4566-0139-08dd2c6ea851
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SlgxZ29PMlhrY3k3RzdaMWY4NWREcHp2V01OeDB4T1J1N2taeVdEc1ZSOER1?=
 =?utf-8?B?QzlPV1BSODExUHR5TzN5cmREQ1hoQWlNZVFtYmZVOFNEdnBLM2lLWHZNWDRF?=
 =?utf-8?B?R0NubTY1b08zOUVuQ2RJdXNaWkN2T3BGRWV0QzdxbjdqOTdxSUxuNWw0d3Ez?=
 =?utf-8?B?OC9hRERqU3JOcTRJc1k2LzIzd1ZabmVvc0dGVlZVREt4MExGeU4yRisyZ2FP?=
 =?utf-8?B?SlRKbW01SU5TaFcwLzd6bm90emQzbXBtY3RnNThHT0ROM0piT3hoYS9NT1BP?=
 =?utf-8?B?ZzZiNGdpU2gvN0hNVWhJWjlMRjZqNlZvMmV5RTJuRFMrQmY3WkRPeDlCUzdE?=
 =?utf-8?B?cVd6SzJxSEpzZzVjdk83NFljbTNqWjdtbVhlZkFLQ3RKWDJOeGI1eTVXV2Y5?=
 =?utf-8?B?czNxd2VNVzlRdXV5dy85aUxWZ0Q5eXlxeUI4eXArK1FVUjV3TmN4N3h1dEg3?=
 =?utf-8?B?a0N2a08veFVkYW95OVR4ZTROci9BSTllRElINUMzejB3bDBEVWdXdVFDRW15?=
 =?utf-8?B?alpzZ05jSzUza0Q4K3NKRjJkSUFwYkoxVHRVb3ZHV3FkUUQwbFgwNVFpMWdj?=
 =?utf-8?B?cmlKdHNURTVULzM3OE9vUkxQUTZsMFNpcm1RL1gwdXVxRnZFWDJFbGNacjNE?=
 =?utf-8?B?VFdTcCtDZks4bks0bnVrNzlCR1NDcWNKNnZUYzdOeUlXUWFFQzN1Ym9Lendp?=
 =?utf-8?B?WkJiWXVrMzltYjN3ZFB1dUxtVXZMcEIxbC9ueXZtRWhvR2M3M2J3dlVWbmEv?=
 =?utf-8?B?cTBFN1p3UHVyS0VBcUFoT0EyNzNkcjVxaUpMOGgzUDM5aEszcmRMYXUrYjRo?=
 =?utf-8?B?bDc1b0FZSU9Od29pYzBWZ1JyeFY2NTk0YmZKMk1XVVQzVmFuNUlrYVZ3N05q?=
 =?utf-8?B?Y1lzaC8vUUFiZXB3UWZGTk4xaWtkSnFQTS92amxVUzNhbVZsUHc0SWpiVDlu?=
 =?utf-8?B?S2N3QTNUckZsM0NpZXg5eVdvR0c4bGMrN1RvNkduWGxpVkUrREluQ0Z6UjF6?=
 =?utf-8?B?U3ErUkpDbEwwRWFRTTgrbEpHQk1USXRQQU93VDMyQlZmb0pteXBtcmNDWjFU?=
 =?utf-8?B?azhpdTIybmFib3pORVJjZjBMcXlwOUR3dTR4NUVzSjFmQzcxbXJHenVsTE1o?=
 =?utf-8?B?SDhtRjRwZTAvT1ArNm96eEFJSDFrOTdwVGhuaVpDb21nb2VVK29JZCtjb3hL?=
 =?utf-8?B?QjBySjVxdmVnTU93czE3OVErM3c3VmxlMUVUWDRMYzJZOTRabXJsOXFwa3N4?=
 =?utf-8?B?N1BJMlJzSU5LWmVtWEN6Z2FrSk13SnBXMWRqQnNGMkNkMlo3Sm9VdG5nMVRp?=
 =?utf-8?B?K0RKT2RYdEJkTzBaUVREc05qbVFmZlducTVFKzBkZjdVNkhlclM5a0RJMlpY?=
 =?utf-8?B?ZnUvKzJrTzNnbjE5UlI5a1dBYlVralp1REZOQXU3VDNIb0xTK2VJbnRkMnVT?=
 =?utf-8?B?MU1SUURFYjN1eVFLVWRCaVczYWlKaXRKcXlVQVJNVXZKU1NaYmk2dHNiNEVN?=
 =?utf-8?B?bU81SDBWV1MyaEN2KzBmWnNIR2l0NWRSaTVncTl6RGp2eEdYWnZCcmZFU3hY?=
 =?utf-8?B?bDV3dE5DMWxrdUxSZnJPU01zY0VCQ0tmSlBBUXo1QW10WkhYUmFZL29xbVpK?=
 =?utf-8?B?VXFvSHdWNDVWR3pFUzZ0amxFTDJGNXdZQ2VvV0oydisvN1RHU2l2M09tMk04?=
 =?utf-8?B?Qit2amNKYmxRREh2WnovMHFMQmVoV1dEZElCbFovQkQ2WHhZOE02MFgxUkZw?=
 =?utf-8?B?VEplVXI3K1ZjQ3drb0doN1dNampLRTlwVVFEZkFwUkxuTjNlMFI5R0FVaEN0?=
 =?utf-8?B?bmIzU3JGWmFGMUNOczR4VUhSRWJkakVqckozNENKN0VEKytrSUtsQUdUOU40?=
 =?utf-8?B?TUJDM0NZeTRobjZTL08vM3RHOXdBeTQ3WWlwZkViRVBhL2t2SFdtL3ZSSk1h?=
 =?utf-8?Q?7bvGvedr+QFPkTNjKivjSBFSgAS3RwiZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmQ3NHREMlYzTkhHMFRBeU1qZFUwYWhMeWRJK0dySUkzSW5UclkwdXc5bFFt?=
 =?utf-8?B?b2h0QUp6L085dW01Ri9RNExLelNlOXRzdndBOFRmeG0rM3lRZE01V2FGSUp1?=
 =?utf-8?B?UXBRd05NL0d3M0tGYmNGWHJQeEM3ZkxmQnltR3J5Z3lOanp0Mm9BRmlFcEVr?=
 =?utf-8?B?RkNZTnFBVG13eHNaNkVhWUs0d0JTMVU4MmNyUWp5cUdoWTJiQVpqUWVQWEdw?=
 =?utf-8?B?RjNLUFp2NmVFVnJtck9mcHNoU2FodFl1Kzhvb3FSUXQvblZwa3l0Z2hmYW5B?=
 =?utf-8?B?MGtNYW9HZ1Q5ckF5REdHQkhvTzBOb3JOT21ITmNxMm95R21QcElQQ1RBL25H?=
 =?utf-8?B?UUxEMDV3ZzErUlVHNFY1cUlQYUo1STIwVHVwajN0akorZFpNTTVGS2RhNG9N?=
 =?utf-8?B?MUNhRm1jV1N6TDREMnZGTkh3ZmRkamVDbkVuMzRQVG5GbVZqUUw3RmNEdmZz?=
 =?utf-8?B?SWZubmVaWWFqVFdlQ2U1N0JRSEpMcjczWHZYbTNadGhaWC90bnpkMlpxL09x?=
 =?utf-8?B?Z1BWWnhkbHlFRkNCUkNrWEhTblhnV0xuczB6R0JzR2R4ckFpYitlcEFnNk5j?=
 =?utf-8?B?aHFVRktCZXpTUG9ad3phZkRwZ0VOWWlJTWpqbW8vcVhmYktWeXp2KzY4S0FJ?=
 =?utf-8?B?TzJ4VEdrZzdVVmdQYitOeUMxdjlzK1UyN3RSeGkrWExlVUhsRUxzb05xa0tv?=
 =?utf-8?B?QmY2UXlDRFhramVjSkJFdzZwUW40dTRkdFhWQlhXM1R4YTBmZEdVOEowWVFJ?=
 =?utf-8?B?QUpyY1loM0ZKZUUwYm0wMFAyMzFFS1o0ZVY1NnEvQXZjRVEwNkRQWklaV2d1?=
 =?utf-8?B?bi9Ud0gydGszSkZYYk9ndVduOUdkTFdGVHVsbTVWaEE0eE0vUTI2YkFlM3B4?=
 =?utf-8?B?blRnd1MwMXpPL2JuZE8wTzJrb2NjY20zR01ZdUJvT2RrRGZGaWpEOEFmYTc0?=
 =?utf-8?B?YzRtVk90S2tyc0ljTGRrWWt2TmNnb1N4TWt4M0xGSUEvaERoN3JTMWV6Slpt?=
 =?utf-8?B?SlFuRnlLN3FaYXNHN3NFTDZYdGNIODV4NllienliTmdkaVN0b0k5Ty9lTmVH?=
 =?utf-8?B?UjRsUm1yYkc1bXJrTHF0V1AxaGlhQmo4Ym5pbXNpbHpLWkt3M3RJQTk0YkZK?=
 =?utf-8?B?Ylg0ZERrTytYK1lRVCtzYngvOGlMc0xUYWl1bTROU2UyNkNaaXlyT0E5ZFUx?=
 =?utf-8?B?Q05JZ1FqVWtBbGd1QjRiMVhMUjVoTEk2RUt5WW9OM1hibDBPa1p5T0VIYmhi?=
 =?utf-8?B?V3Nic3VLRlAyVjVpUlQ3SkpHTVcrMHBLd1NudkE1VGUyL0xYRG96aU9USmth?=
 =?utf-8?B?Q2hUUDdWR2tDUFNFcnFpaXM4VTBoUEMzOW1hSjRzOHl6OGtxanZYTUxpMjBM?=
 =?utf-8?B?MndOeloxZDFkc1hNRHEzZlJHVE55K21mZklreWRKR0tManhlbjZ6YmVrTWp2?=
 =?utf-8?B?cXJ5dGkra2x4QzIrMFJMZ0JJaUlpYTVyTGc1NC9DR0JpUUd1akcxRklaTGY4?=
 =?utf-8?B?Rm9PeE15MVZuMFN3a0NOV1pXT0ZjTFlhUWRjMzNsZEZxVE5ibTJ6UVpJMi9U?=
 =?utf-8?B?bFozYmNFQ3JIOUZFazJOakh2MG1xa3pYM0hKWjl5SWNNVlljRERyQURXMm5o?=
 =?utf-8?B?SjJmd1hTM0hzaklzOVQvL2I0UFFiUGNQM3JmTXBlUUgvbVhacnMzUUFDZHV2?=
 =?utf-8?B?UG9LeVoyakp5U3Q3eDJvaWJqUVE3ZHZrckFCUEgxZ3ZYaWVoS0tuc2JSZEdr?=
 =?utf-8?B?VHVNOUlrMGdTL2JrNUVWYlNPS0sxUTJmc3FGSUxqSGhESEdScHBaWWQrSm94?=
 =?utf-8?B?ZzE2Z0o5dDNHaWpuVGV3aXpLcG11ZGJsd3BkbnNJMldZMGh0VGNlYVh4MVJv?=
 =?utf-8?B?WDQ5cEt6YlowMVJ5a1krTHdYVHF0WGt3Qkl6NVgyTEJwY3U3OTFod0Nrb0V4?=
 =?utf-8?B?eGw3elFLazNKZlJnbDVxNTlEaXFWUzRsMTFEelQ4eVUvSUcxWHA0U0d0VUNV?=
 =?utf-8?B?VlVUWS9sUGhJeXJ4SlpNaFRzdFJ6OFFIWUw5VDUvK3N6TEZSbkZDNzdqaTBj?=
 =?utf-8?B?WlBycU1MM0Nab2s2RTJJbVlwWDFyeVVsTUFGNUp3VU9odFFlTnBqWDdoa25E?=
 =?utf-8?Q?/SCCofTwFxD3s63Oms66hHckB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7923ed2-0777-4566-0139-08dd2c6ea851
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2025 03:19:53.9749 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZrZxBoq7EFILILDOsV/rdTZYw1xiZgBLo0c5HFZU9BLTGTEXEmeLZy7pkRDbhpNEMpW6GMcoNqQpLAa4Ydc1XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9566
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

Move env to imx8mm_evk.env
Switch to support BOOTSTD with a bsp bootcmd as fallback.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx8m/Kconfig           |  4 ++
 board/freescale/imx8mm_evk/imx8mm_evk.env | 67 +++++++++++++++++++++++++++++++
 configs/imx8mm_evk_defconfig              |  4 +-
 configs/imx8mm_evk_fspi_defconfig         |  4 +-
 include/configs/imx8mm_evk.h              | 22 ----------
 5 files changed, 77 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index 0cf3c1baffeecc5d7475e6f7b8d77539aa9646a2..28be6a22bf07e1341ec841bace149cdbb871fac0 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -154,6 +154,8 @@ config TARGET_IMX8MN_EVK
 	select FSL_CAAM
 	select SPL_CRYPTO if SPL
 	imply OF_UPSTREAM
+	imply BOOTSTD_FULL
+	imply BOOTSTD_BOOTCOMMAND
 
 config TARGET_IMX8MN_DDR4_EVK
 	bool "imx8mn DDR4 EVK board"
@@ -163,6 +165,8 @@ config TARGET_IMX8MN_DDR4_EVK
 	select FSL_CAAM
 	select SPL_CRYPTO if SPL
 	imply OF_UPSTREAM
+	imply BOOTSTD_FULL
+	imply BOOTSTD_BOOTCOMMAND
 
 config TARGET_IMX8MN_VENICE
 	bool "Support Gateworks Venice iMX8M Nano module"
diff --git a/board/freescale/imx8mm_evk/imx8mm_evk.env b/board/freescale/imx8mm_evk/imx8mm_evk.env
new file mode 100644
index 0000000000000000000000000000000000000000..29690e75b15aa7c3eb93bd918d42a4d124dde7b6
--- /dev/null
+++ b/board/freescale/imx8mm_evk/imx8mm_evk.env
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+
+boot_fdt=try
+boot_fit=no
+boot_targets=mmc1 mmc2 dhcp
+bootm_size=0x10000000
+console=ttymxc1,115200
+fdt_addr_r=0x48000000
+fdtfile=CONFIG_DEFAULT_FDT_FILE
+fdtoverlay_addr_r=0x49000000
+initrd_addr=0x48080000
+image=Image
+ip_dyn=yes
+kernel_addr_r=0x42000000
+loadaddr=CONFIG_SYS_LOAD_ADDR
+mmcautodetect=yes
+mmcdev=CONFIG_SYS_MMC_ENV_DEV
+mmcpart=1
+mmcroot=/dev/mmcblk1p2 rootwait rw
+prepare_mcore=setenv mcore_clk clk-imx8mm.mcore_booted;
+pxefile_addr_r=0x40100000
+ramdisk_addr_r=0x48080000
+scriptaddr=0x40000000
+
+mmcargs=setenv bootargs ${jh_clk} ${mcore_clk} console=${console} root=${mmcroot}
+prepare_mcore=setenv mcore_clk clk-imx8mn.mcore_booted
+loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
+loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
+mmcboot=echo Booting from mmc ...;
+	run mmcargs;
+	if test ${boot_fit} = yes || test ${boot_fit} = try; then
+		bootm ${loadaddr};
+	else
+		if run loadfdt; then
+			booti ${loadaddr} - ${fdt_addr_r};
+		else
+			echo WARN: Cannot load the DT;
+		fi;
+	fi
+netargs=setenv bootargs ${jh_clk} ${mcore_clk} console=${console} root=/dev/nfs
+	ip=dhcp nfsroot=${serverip}:${nfsroot},v3,tcp
+netboot=echo Booting from net ...;
+	run netargs;
+	if test ${ip_dyn} = yes; then
+		setenv get_cmd dhcp;
+	else
+		setenv get_cmd tftp;
+	fi;
+	${get_cmd} ${loadaddr} ${image};
+	if test ${boot_fit} = yes || test ${boot_fit} = try; then
+		bootm ${loadaddr};
+	else
+		if ${get_cmd} ${fdt_addr_r} ${fdtfile}; then
+			booti ${loadaddr} - ${fdt_addr_r};
+		else
+			echo WARN: Cannot load the DT;
+		fi;
+	fi;
+bsp_bootcmd=echo Running BSP bootcmd ...;
+	mmc dev ${mmcdev};
+	if mmc rescan; then
+		if run loadimage; then
+			run mmcboot;
+		else
+			run netboot;
+		fi;
+	fi;
diff --git a/configs/imx8mm_evk_defconfig b/configs/imx8mm_evk_defconfig
index 90757100c72877d961d3a110e5293c9248c790b7..fa576bbde0208d12e42d117fac46ee7a9a57f230 100644
--- a/configs/imx8mm_evk_defconfig
+++ b/configs/imx8mm_evk_defconfig
@@ -5,6 +5,7 @@ CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_ENV_SOURCE_FILE="imx8mn_evk"
 CONFIG_ENV_SIZE=0x1000
 CONFIG_ENV_OFFSET=0x400000
 CONFIG_DM_GPIO=y
@@ -24,8 +25,9 @@ CONFIG_SPL=y
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_BOOTCOMMAND="bootflow scan -lb; run bsp_bootcmd"
+CONFIG_DEFAULT_FDT_FILE="imx8mp-evk.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074
 CONFIG_BOARD_LATE_INIT=y
diff --git a/configs/imx8mm_evk_fspi_defconfig b/configs/imx8mm_evk_fspi_defconfig
index fb4a4421cf04c3e0f2cee10f1f7689227f44dfd0..af49b82c74cddb0b548b9970af2289e3de320060 100644
--- a/configs/imx8mm_evk_fspi_defconfig
+++ b/configs/imx8mm_evk_fspi_defconfig
@@ -5,6 +5,7 @@ CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_ENV_SOURCE_FILE="imx8mn_evk"
 CONFIG_SF_DEFAULT_SPEED=40000000
 CONFIG_SF_DEFAULT_MODE=0
 CONFIG_ENV_SIZE=0x1000
@@ -27,8 +28,9 @@ CONFIG_SPL=y
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_BOOTCOMMAND="bootflow scan -lb; run bsp_bootcmd"
+CONFIG_DEFAULT_FDT_FILE="imx8mp-evk.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074
 CONFIG_BOARD_LATE_INIT=y
diff --git a/include/configs/imx8mm_evk.h b/include/configs/imx8mm_evk.h
index 3bbbd900dd439a93af62cbcb9c95d03b012fee86..957d9c05083f10534467fcd7b3a5f8d7f1fd4b4a 100644
--- a/include/configs/imx8mm_evk.h
+++ b/include/configs/imx8mm_evk.h
@@ -29,28 +29,6 @@
 
 #endif
 
-#define BOOT_TARGET_DEVICES(func) \
-	func(MMC, mmc, 1) \
-	func(MMC, mmc, 2) \
-	func(DHCP, dhcp, na)
-
-#include <config_distro_bootcmd.h>
-
-/* Initial environment variables */
-#define CFG_EXTRA_ENV_SETTINGS		\
-	BOOTENV \
-	"scriptaddr=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
-	"kernel_addr_r=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
-	"image=Image\0" \
-	"console=ttymxc1,115200\0" \
-	"fdt_addr_r=0x43000000\0"			\
-	"boot_fit=no\0" \
-	"fdtfile=imx8mm-evk.dtb\0" \
-	"initrd_addr=0x43800000\0"		\
-	"bootm_size=0x10000000\0" \
-	"mmcpart=1\0" \
-	"mmcroot=/dev/mmcblk1p2 rootwait rw\0" \
-
 /* Link Definitions */
 
 #define CFG_SYS_INIT_RAM_ADDR        0x40000000

-- 
2.35.3

