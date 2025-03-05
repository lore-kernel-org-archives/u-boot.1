Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF3B4C19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 13:30:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E170A81420;
	Wed,  5 Mar 2025 14:29:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="B06m0yaV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D5E0807B1; Wed,  5 Mar 2025 14:29:24 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AD638121A
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 14:29:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eNkW3Do0UHE3TCFvsqWw5sMw/0dhjttNnrEv4QzYRAxwthA8AbgqfJqpYKawNkprdycauwJFtchLvLZJu76cXDGjQsiqOIIuseoVc87ozgZ70eC0Y6gh43RWXAxMqYNo4R+i7nprZNYkbRFQn8ja6HdK10WH3bh5x9+ErbNCv8wvfpL9eE/YpKSySrFIR0QjnmZz3ZNIzgGF5V+gjThpnl2270PNy4T9q27VKOFuYxca0EC5PxASDlWM/8zEb8t1evfylC9dFGw+oJ1hu/W1r8F7QtRCCBmVVmnMNe3p+6TKIBvxpTtjlFCS4/DzB6/pOQeXP40nGkcdB5K69UIEHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vDj7DyZ3JANj9G5OW2RDEI/xuzF2Rw+9pTdB1BMX8I=;
 b=pcHIuK2quZgZ9POjHC3YSznR6RjTVe3kiqVxaM7SM6yxjnfs0xDWzGMUdCA89LIyEDPMzryi1D+tykpzhR8Z4dm3USrwf8oWEhSyOgVA9Fk36vB/SP5ULofeKvjrOpiujz3iSfnCSIJWa839PaxhH9aLGBDLpwCtl6fAL32n0Ma+m8wSB/Tx0w84h5352S4Ep4pDa6pIYllDuT5sapAVZydEZB7BcCA+jRrJDFJJRnk8NkK77bNTD/YlsqFRGlWgTpRKEXbb6+TKT5UxDD/LT2pJCBP6m/oTYzRgRQPIJF/SOUTGyXcn+i1Qf+Uyqk5U7VLEP/dHy4pLLfygCESb2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vDj7DyZ3JANj9G5OW2RDEI/xuzF2Rw+9pTdB1BMX8I=;
 b=B06m0yaVwPazATU152UNsbJO3yxf3NqVszMbpY4linALyLVHcF68J9FOCxIKi1wFg/8Wp3osRTKf1WPgUd6WQRyeFo3iHSf4R+r+5CU1A2XNQtMkPfmFJKAE/Vz6Rmig/szqJWKE0ErCTkBWIcRuN/L0vhL39cy4OQ+Fxf2Yl0GE7LW6xFKH+XxauAA4IIRO3rrCAWiCvB4lsZSAyQOtm4J9T8iEQ/ZAfwhpByG+sCO5ZZUeq3Gl5fCMuO+r+97+rAOs0EFKn1uBE8SH0ly5JOXlWfvjRQIqVfhHPfhIk9udvCMK+kdjlNmU3OylGVyDE2m4/uRzwQuhUGV+4H2KXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS5PR04MB10000.eurprd04.prod.outlook.com (2603:10a6:20b:682::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 13:29:20 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 13:29:20 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Wed, 05 Mar 2025 21:28:19 +0800
Subject: [PATCH v7 07/19] clk: scmi: check the clock state/parent/rate
 control permissions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-imx95-v1-7-286d15acbb8a@oss.nxp.com>
References: <20250305-imx95-v1-0-286d15acbb8a@oss.nxp.com>
In-Reply-To: <20250305-imx95-v1-0-286d15acbb8a@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 marex@denx.de
Cc: u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS5PR04MB10000:EE_
X-MS-Office365-Filtering-Correlation-Id: ca0e0814-8629-46f3-563b-08dd5be9bc7a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TGtHcytuY09IYXZQYkxsWWl0NkovUXdDZFpBRUd1SXh1QW5OZVlNZHBYWjcv?=
 =?utf-8?B?YlBzaGkyM2l3bVAycVNGRjgxczR6dkJ0bjYxMHFmM0Uvb2FGczRpczF1ZFdJ?=
 =?utf-8?B?L1NxWmF4TlpkQi84QU9GRGZLbUlscUV0Tk1vR1hBRWQyVFRSbzV0ZE4xL0Zi?=
 =?utf-8?B?clh0UVQ1VzBNWUtlT3UvQlVqS3pFQWJKdVcrNlNBRXljNjlFb29BZWVEbVZq?=
 =?utf-8?B?bFlteVZCMlV2bFMxNWlZSzZHVEd4YjdGVllOeVdNUzRGT080bVk5YzBHTVJZ?=
 =?utf-8?B?RTVheGxqTkdVdjhuR1B5cW5GRU54SjVvNzlNTlF1Nkd5bFVYUmxUZmVCYXh0?=
 =?utf-8?B?K3VsTzZqZW55K0R2QW9sWldZM0dON2ZmaUd4T29KdTVDbm9mRitEenQ3UTY3?=
 =?utf-8?B?NUhBQXk3eXNlbHl6MnBlK0ZvMW9HeTI0N3BiWlp0aVhka0t4eW5tdTB0M3d2?=
 =?utf-8?B?cTdhRlRwTmFrcTRmeXoyQVBuOFJkUnhXVGQzZ1ovSXp4TEhDUW5KSDNnc3Rx?=
 =?utf-8?B?Ump1MFUrYWhOa1BKRWxUcTJaWHVsSEh3TFEyM0xnRThHOUtjVlhVKzlJaTY1?=
 =?utf-8?B?RzFMN2ErZmFiNXYyZ1NGY3lrVFJzU0ZZaU1pMTA3dXdSeExyVjNsRHR4RlRi?=
 =?utf-8?B?WXhEZS9IcTNMemhTdy9jKzBCbUk0RVNXc3FwLzErR2c2cEpqNWVYZUtOQlZ4?=
 =?utf-8?B?WXZaTExCWlVCcFRkRlprNkNBT0JvT3B2NW5zNlZZUmxMS3p5dFNLblcxYmsx?=
 =?utf-8?B?SnZ5dlBCVTB5UXBMeEc4NmdDMllWTThlSDBzVzhyeCtraldxZ1gzWWQyYTV2?=
 =?utf-8?B?cjJoTkxiMks3Q3prVGFQNFgxQkF5VitYcHFITHdDdWJRcmovRUkxMUdvYkpC?=
 =?utf-8?B?bGFueDNVTkFNR0REcXhtMENZS1F5c3FHZTlGZGZZeUMwdnA5QzJIOXh2T2Vp?=
 =?utf-8?B?YXZzMFhjWFlQZzE0RkpYVUtsdFFENldlTWkxM0R5MFA0V1pORXBqWDVqMXZG?=
 =?utf-8?B?Qk1MbUdPM0JtMnJ5aFVzandqTkRLbEthZlphZlMwcjZsWUh1dXJIYXVtT0FF?=
 =?utf-8?B?MHpScXVlVnlOUlhCRTFIejROdVRxdjBrV3BhNm1YTnhldmZjWUZ1NWNRVUxq?=
 =?utf-8?B?RnhJd0VsM0wzRkRrL0lBd29SQU83amhCcDdpNUF3bkt0Vmw1dlRNc0lGUUFT?=
 =?utf-8?B?Wm8vVlYvY0ozaGZoTkNzM0orMDRnOCtHN0NTMVdvZDgwTSs2VDE5R1ZGSWZq?=
 =?utf-8?B?WWJvMWtZUkEwZyt4SkNxakdtMFN4bHFLV1NTbXVJNUZwRU1BbXFuUW9Qa2N6?=
 =?utf-8?B?bWRSV1B1UDlHZlBvY3FEZHhkN3VOSm5HUmQ5R3VFK1JPWThQMkFNczN3UUNq?=
 =?utf-8?B?eGJYK3E4U3ZTc1Z0aDNpVW12NHdRY2drMFYxNS9uNG9LYU9kajhKcWc4d2My?=
 =?utf-8?B?Rk04QUtFem0zWDJkaUU1TGpCODZyaCswVjArNFFoZDYvb3lKUTJ4ZUdJNjg4?=
 =?utf-8?B?bWZQbVlEcVJ1dlBOQzdOWE1YNVh5a2Q2bE9UMWttR3A1R3hFekNVbytkdUZv?=
 =?utf-8?B?WXM3Ykpmbi9PeC9zU0p2YSsvQmFoSEZPUmI1Umt4VVdxRThNTU5ocktLU3pY?=
 =?utf-8?B?NHBaWWpqVGFPZlhJQ3hmbTFUR0RoR0lLU1pkTjdjQ0x3Mm11QkNBRWVSV3ho?=
 =?utf-8?B?R0ZCTnUrM2cyZXpEV3pITExhMW5ndXRobVJOTFJHQ3k0L00xUkphYnBBcjRj?=
 =?utf-8?B?V2lzaHVrSER4Q3BWRkN1WkFTOXFhYWZSU2p2Z1A1ZWo3bmcyZTJpc0hGN0kx?=
 =?utf-8?B?MEZzQTYvYXRYMUlVR0t1anF5WHJjNzZ3RlBwY1F4R0hHclZoQUhIelkwUXJ2?=
 =?utf-8?B?OWZEQXhhR0lxaWFiTVl5cGdmZU1GdFo3VVpqVTFwMnY2TWI2emwzR0xkZnVQ?=
 =?utf-8?B?cUVOYy9NZ0pRYXIxYmRjWENMZE5TQ2N3UDJUamFxOFcvSmVoc2JKM1lIeXlv?=
 =?utf-8?B?TU55NXUyajB3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHFHN2diZ2ZkRlJoZ2Iwd2tKaWtLVTFiTTBHdlM1QVJyeitqZ2VTajRtaTlt?=
 =?utf-8?B?YTlycFFwcGx3ZjVRcmdQdUJXYlJBek43cDJXYmFpY0o2Ynk1eC9TUmJKZERU?=
 =?utf-8?B?bWIrN1hYY3l3RlVQRTJiRjl0emlZM2txbXgrdXFFVFl4eC9Ia2RvSVdXME5S?=
 =?utf-8?B?ajh3cVVQOTQvOHdDZVRkL3doSkVmNHlwY3E2QjZKbmRZS09KQnBIUzVwS0E5?=
 =?utf-8?B?R1YwNDAySWpRaUVsOFlLUTI1eVRzTDJZMU94UkxCbmFSNWppQ05jM3pqSm5h?=
 =?utf-8?B?Tmk1SlR5STQ1dVYySG9EU3E5Z0FWcXZ4eXZiZFJxTHV4WUxSUGtNT1JDWXh0?=
 =?utf-8?B?SGJDYVl5RmFsMmg1VFp1Y2IraE1la1czVkdPL29MYTlFbGxDb1ZvQ2JFY1hh?=
 =?utf-8?B?SXRTZzNRbXZNVmJGNjU1Lzl3L2JEOXZzUDBma0RVUzgwbmh5VEFmaDgraHJu?=
 =?utf-8?B?ZzZ1N21VcUV1eVZ1amRkVE5QWkJEa1FlSzVCV3JORlZObkFseldlQUR5dS9G?=
 =?utf-8?B?ZWoxbzBNVjFuT3hkdENkZVdFQ1R3NC9ETEtzOWRZakR2QzBjRkF0djdlTGtU?=
 =?utf-8?B?RDJ0RkhMU0dVRVhEZ0E5OGFNcDRPK1lUMHdtUnMxVGY5TnNSTFY0a0FPSzRu?=
 =?utf-8?B?ZFo3OWdhMzRiS2xGRGtmK2U3TjhyR2ViN3BrR1FEbGdNV2IxdW5Mb0JtdkNz?=
 =?utf-8?B?STZHQ0lOcmprVWxTNzU5TlRrRDZITnJNM2FSakhSZ2dOZGR2eWcvM1ZIY3Nt?=
 =?utf-8?B?bHJWYlNmNnQvY3BxRFpsWVNDazdSZ081Z0trbk5JNGVWWFJJdklUOGRpd04r?=
 =?utf-8?B?dlBJZ2NxM0J6VGJmNWI4ZzJRZWVjRGtDUU93bjIzVTcwRTYyQVFScGRFb2w2?=
 =?utf-8?B?dzNybEJZM1ppd0lwTVRtNDA4Y3VJZWlQWTc2Q051dGxOZXJ6VzBCVVVOUDhC?=
 =?utf-8?B?cC9GYkl0MEswbUQvQ0ZjYlZGcDg3dHBUTVF2aFJQQ1gzaTNuQjdrWTRyRkhp?=
 =?utf-8?B?b3F1cS9HSGtZTUY4VUJoZEl6aXVNQ1RGU2lYRkUyc3NWZThCNldRUVk0Y01D?=
 =?utf-8?B?bjJFTXMwbDJzd0JCQmZiSCtCTms3K1hJWDFnZ1NPa2h1S2RlQXBiTlRYTXYy?=
 =?utf-8?B?Z2pwcDJYL2I2ZzRPb3ZvbUMzdnUyRnZWaFdmNWxSeFlWOGJVWnhJNFh0ZWNC?=
 =?utf-8?B?SG8xaEF3U09RelYwN3REMFB6emxJT012UGFZM29HZ2IzOGVrU2liRHJMaWlQ?=
 =?utf-8?B?b2ZtT2M4M05peklWak9BZ0Q3OHo3a0U4QWU3Wlo1UE9JdWJyNlZJd21NdVhK?=
 =?utf-8?B?d2lqSDlJby80SmJaU1JlemFqRVRWN0VWKzFJQmM5K0cvTVRPNmxJZXhSb1g0?=
 =?utf-8?B?QnRMK2VaTUNpQTkwOU1zZ0xpcGhLRzdJUEpUUE9weHZCVTIvaDI3d2pwWFlH?=
 =?utf-8?B?Mnp5NXNUbVk1eFhqUkIyWWQ1ZGk2c3hGbWkxeUIwbFdYb01uNFlpYml3QUZO?=
 =?utf-8?B?dzZDQWRlUjM3czhqZDFWaUJWY1ZhV3hxdVlzTGd5aHBUMjl4SnBEdi9DVzMr?=
 =?utf-8?B?MW9pQXM1YmZmMEdmTjErSEEzUktWdnJkMjJya1JnNFVZUEMydUdPMFlXUzMv?=
 =?utf-8?B?YjAzRnZ6TmorbkVVOGFmWEYyeWFlWUtiazd4R08ycTNlaTRTVnRMMmQ2cTdM?=
 =?utf-8?B?YVg2VWFiNyt1YWt6UUlGdVkyS2FsSGsxUkhiWVdEUGlpdVMwMEk5cDhiSzJJ?=
 =?utf-8?B?OGVwZmsxd1Q3dUZmbmFWTWJoeWhUTVZEUWNZWDcyWDNIZlhBbFRibldtSkcy?=
 =?utf-8?B?Zytoek5uS2JtR0xhQ1VrQlBENGpycGdrbFhFbkMzS0Vzd21tMWVvMDFUY040?=
 =?utf-8?B?dEdSbk9sbUVuc29OSE96N2kvSTdaTXVRYm1RS01qNHZlN3BqRk9sTkR5anhs?=
 =?utf-8?B?UlBYNnY1NnRaR0MvSGZ2TSt1cE9OblNJUjJ3WVFBQll6clQ1RE5MVnIrdVR3?=
 =?utf-8?B?OWUxdG8wS1V2cmtpeVZTbXVqUWpTbTlybTF3bGlHT0hvN2ROZzNQSHd5UFpH?=
 =?utf-8?B?anNDbEhQd3IwNHRkazExRzB2K2JUbHFNdUZjWXNuWFV3NXRZQTg5Qlh1WHVz?=
 =?utf-8?Q?eNpn2rOcggPwElN6p5UDutgiM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca0e0814-8629-46f3-563b-08dd5be9bc7a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 13:29:20.5175 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: waqg2HuGklF79UyDW3SjJ8wvcU4we5cYYuVfMWidjt8KRrgFBQeZB/S/wvMQH/0usIT+cMBVdOTMsLz2kaJ5Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10000
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

Clock driver based on SCMI clock management protocol in Linux checks
clock state, parent and rate control permissions. To be consistent with
the kernel driver, add this check here.

When using common clock framework (CCF), use the clock signal ID to get
the clock registered by clk_register() in scmi_clk_probe(), and then
obatin the struct clk_scmi variable with container_of().

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk_scmi.c   | 173 +++++++++++++++++++++++++++++++++++++++++++----
 include/scmi_protocols.h |  26 ++++++-
 2 files changed, 186 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index 84333cdd0c..d120c1eba0 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -12,6 +12,56 @@
 #include <asm/types.h>
 #include <linux/clk-provider.h>
 
+struct clk_scmi {
+	struct clk clk;
+	u32 ctrl_flags;
+};
+
+static int scmi_clk_get_permissions(struct udevice *dev, int clkid, u32 *perm)
+{
+	u32 version;
+	int ret;
+
+	struct scmi_clk_get_permissions_in in = {
+		.clock_id = clkid,
+	};
+	struct scmi_clk_get_permissions_out out;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_CLOCK,
+		.message_id = SCMI_CLOCK_GET_PERMISSIONS,
+		.in_msg = (u8 *)&in,
+		.in_msg_sz = sizeof(in),
+		.out_msg = (u8 *)&out,
+		.out_msg_sz = sizeof(out),
+	};
+
+	ret = scmi_generic_protocol_version(dev, SCMI_PROTOCOL_ID_CLOCK, &version);
+	if (ret) {
+		log_debug("%s: get SCMI clock management protocol version failed\n", __func__);
+		return ret;
+	}
+
+	if (version < CLOCK_PROTOCOL_VERSION_3_0) {
+		log_debug("%s: SCMI clock management protocol version is less than 3.0.\n", __func__);
+		return -EINVAL;
+	}
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret) {
+		log_debug("%s: get SCMI clock management protocol permissions failed\n", __func__);
+		return ret;
+	}
+
+	ret = scmi_to_linux_errno(out.status);
+	if (ret < 0) {
+		log_debug("%s: the status code of getting permissions: %d\n", __func__, ret);
+		return ret;
+	}
+
+	*perm = out.permissions;
+	return 0;
+}
+
 static int scmi_clk_get_num_clock(struct udevice *dev, size_t *num_clocks)
 {
 	struct scmi_clk_protocol_attr_out out;
@@ -32,7 +82,8 @@ static int scmi_clk_get_num_clock(struct udevice *dev, size_t *num_clocks)
 	return 0;
 }
 
-static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name)
+static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name,
+				 u32 *attr)
 {
 	struct scmi_clk_attribute_in in = {
 		.clock_id = clkid,
@@ -53,6 +104,7 @@ static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name)
 		return ret;
 
 	*name = strdup(out.clock_name);
+	*attr = out.attributes;
 
 	return 0;
 }
@@ -78,12 +130,48 @@ static int scmi_clk_gate(struct clk *clk, int enable)
 
 static int scmi_clk_enable(struct clk *clk)
 {
-	return scmi_clk_gate(clk, 1);
+	struct clk_scmi *clkscmi;
+	struct clk *c;
+	int ret;
+
+	if (!CONFIG_IS_ENABLED(CLK_CCF))
+		return scmi_clk_gate(clk, 1);
+
+	ret = clk_get_by_id(clk->id, &c);
+	if (ret)
+		return ret;
+
+	clkscmi = container_of(c, struct clk_scmi, clk);
+
+	if (clkscmi->ctrl_flags & SUPPORT_CLK_STAT_CONTROL)
+		return scmi_clk_gate(clk, 1);
+
+	/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
+	log_debug("%s: SCMI CLOCK: the clock cannot be enabled by the agent.\n", __func__);
+	return 0;
 }
 
 static int scmi_clk_disable(struct clk *clk)
 {
-	return scmi_clk_gate(clk, 0);
+	struct clk_scmi *clkscmi;
+	struct clk *c;
+	int ret;
+
+	if (!CONFIG_IS_ENABLED(CLK_CCF))
+		return scmi_clk_gate(clk, 0);
+
+	ret = clk_get_by_id(clk->id, &c);
+	if (ret)
+		return ret;
+
+	clkscmi = container_of(c, struct clk_scmi, clk);
+
+	if (clkscmi->ctrl_flags & SUPPORT_CLK_STAT_CONTROL)
+		return scmi_clk_gate(clk, 0);
+
+	/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
+	log_debug("%s: SCMI CLOCK: the clock cannot be disabled by the agent.\n", __func__);
+	return 0;
 }
 
 static ulong scmi_clk_get_rate(struct clk *clk)
@@ -108,7 +196,7 @@ static ulong scmi_clk_get_rate(struct clk *clk)
 	return (ulong)(((u64)out.rate_msb << 32) | out.rate_lsb);
 }
 
-static ulong scmi_clk_set_rate(struct clk *clk, ulong rate)
+static ulong __scmi_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct scmi_clk_rate_set_in in = {
 		.clock_id = clk->id,
@@ -133,9 +221,32 @@ static ulong scmi_clk_set_rate(struct clk *clk, ulong rate)
 	return scmi_clk_get_rate(clk);
 }
 
+static ulong scmi_clk_set_rate(struct clk *clk, ulong rate)
+{
+	struct clk_scmi *clkscmi;
+	struct clk *c;
+	int ret;
+
+	if (!CONFIG_IS_ENABLED(CLK_CCF))
+		return __scmi_clk_set_rate(clk, rate);
+
+	ret = clk_get_by_id(clk->id, &c);
+	if (ret)
+		return ret;
+
+	clkscmi = container_of(c, struct clk_scmi, clk);
+
+	if (clkscmi->ctrl_flags & SUPPORT_CLK_RATE_CONTROL)
+		return __scmi_clk_set_rate(clk, rate);
+
+	/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
+	log_debug("%s: SCMI CLOCK: the clock rate cannot be changed by the agent.\n", __func__);
+	return 0;
+}
+
 static int scmi_clk_probe(struct udevice *dev)
 {
-	struct clk *clk;
+	struct clk_scmi *clk_scmi;
 	size_t num_clocks, i;
 	int ret;
 
@@ -156,29 +267,44 @@ static int scmi_clk_probe(struct udevice *dev)
 
 	for (i = 0; i < num_clocks; i++) {
 		char *clock_name;
+		u32 attributes;
 
-		if (!scmi_clk_get_attibute(dev, i, &clock_name)) {
-			clk = kzalloc(sizeof(*clk), GFP_KERNEL);
-			if (!clk || !clock_name)
+		if (!scmi_clk_get_attibute(dev, i, &clock_name, &attributes)) {
+			clk_scmi = kzalloc(sizeof(*clk_scmi), GFP_KERNEL);
+			if (!clk_scmi || !clock_name)
 				ret = -ENOMEM;
 			else
-				ret = clk_register(clk, dev->driver->name,
+				ret = clk_register(&clk_scmi->clk, dev->driver->name,
 						   clock_name, dev->name);
 
 			if (ret) {
-				free(clk);
+				free(clk_scmi);
 				free(clock_name);
+				free(&attributes);
 				return ret;
 			}
 
-			clk_dm(i, clk);
+			clk_dm(i, &clk_scmi->clk);
+
+			if (CLK_HAS_RESTRICTIONS(attributes)) {
+				u32 perm;
+
+				ret = scmi_clk_get_permissions(dev, i, &perm);
+				if (ret < 0)
+					clk_scmi->ctrl_flags = 0;
+				else
+					clk_scmi->ctrl_flags = perm;
+			} else {
+				clk_scmi->ctrl_flags = SUPPORT_CLK_STAT_CONTROL | SUPPORT_CLK_PARENT_CONTROL |
+						       SUPPORT_CLK_RATE_CONTROL;
+			}
 		}
 	}
 
 	return 0;
 }
 
-static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
+static int __scmi_clk_set_parent(struct clk *clk, struct clk *parent)
 {
 	struct scmi_clk_parent_set_in in = {
 		.clock_id = clk->id,
@@ -197,6 +323,29 @@ static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
 	return scmi_to_linux_errno(out.status);
 }
 
+static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	struct clk_scmi *clkscmi;
+	struct clk *c;
+	int ret;
+
+	if (!CONFIG_IS_ENABLED(CLK_CCF))
+		return -ENOTSUPP;
+
+	ret = clk_get_by_id(clk->id, &c);
+	if (ret)
+		return ret;
+
+	clkscmi = container_of(c, struct clk_scmi, clk);
+
+	if (clkscmi->ctrl_flags & SUPPORT_CLK_PARENT_CONTROL)
+		return __scmi_clk_set_parent(clk, parent);
+
+	/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
+	log_debug("%s: SCMI CLOCK: the clock's parent cannot be changed by the agent.\n", __func__);
+	return 0;
+}
+
 static const struct clk_ops scmi_clk_ops = {
 	.enable = scmi_clk_enable,
 	.disable = scmi_clk_disable,
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 0d8c177025..2684f4177d 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -731,13 +731,15 @@ int scmi_pwd_name_get(struct udevice *dev, u32 domain_id, u8 **name);
 /*
  * SCMI Clock Protocol
  */
+#define CLOCK_PROTOCOL_VERSION_3_0	0x30000
 
 enum scmi_clock_message_id {
 	SCMI_CLOCK_ATTRIBUTES = 0x3,
 	SCMI_CLOCK_RATE_SET = 0x5,
 	SCMI_CLOCK_RATE_GET = 0x6,
 	SCMI_CLOCK_CONFIG_SET = 0x7,
-	SCMI_CLOCK_PARENT_SET = 0xD
+	SCMI_CLOCK_PARENT_SET = 0xD,
+	SCMI_CLOCK_GET_PERMISSIONS = 0xF
 };
 
 #define SCMI_CLK_PROTO_ATTR_COUNT_MASK	GENMASK(15, 0)
@@ -776,6 +778,7 @@ struct scmi_clk_attribute_in {
 struct scmi_clk_attribute_out {
 	s32 status;
 	u32 attributes;
+#define CLK_HAS_RESTRICTIONS(x)	((x) & BIT(1))
 	char clock_name[SCMI_CLOCK_NAME_LENGTH_MAX];
 };
 
@@ -858,6 +861,27 @@ struct scmi_clk_parent_set_out {
 	s32 status;
 };
 
+/**
+ * @clock_id:	Identifier for the clock device.
+ */
+struct scmi_clk_get_permissions_in {
+	u32 clock_id;
+};
+
+/**
+ * @status:	Negative 32-bit integers are used to return error status codes.
+ * @permissions:	Bit[31] Clock state control, Bit[30] Clock parent control,
+ * Bit[29] Clock rate control, Bits[28:0] Reserved, must be zero.
+ */
+struct scmi_clk_get_permissions_out {
+	s32 status;
+	u32 permissions;
+};
+
+#define SUPPORT_CLK_STAT_CONTROL	BIT(31)
+#define SUPPORT_CLK_PARENT_CONTROL	BIT(30)
+#define SUPPORT_CLK_RATE_CONTROL	BIT(29)
+
 /*
  * SCMI Reset Domain Protocol
  */

-- 
2.43.0

