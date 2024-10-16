Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4575D206A4
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 07:19:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55CD588D75;
	Wed, 16 Oct 2024 09:19:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VCKqPPc1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BE6088DDD; Wed, 16 Oct 2024 09:19:14 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::61e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D3FA88DC7
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 09:19:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UgALiJrkAvZdw4AK8idSwNi6ad6Lm+00efItM5e2BZRmwfiZ2QpcP0B0ZVDJtEiPG2Bhd8AHtjUfe5edOLZ+mwKV+4LwwQk2Op+0671LbfjpTDl7+2X/EBENTKAnNW4eBtz7IJ4GKOHps+mIC8fl4SSlFKWzmX3fKBeZ3zqS+LamLYcFcLotW4IrOWs+w9ZFkF5RjqNKqSo/Pngd4QpGe+JZeXtxsm3jkKABH/sMtQJ9NMZKmZpJSgyF/cjZqWLQzn1mJjK5CxLQTuKWNSSGjbkiL+Uu9xaRLi7pUYWbVLYn2vaMkEFMv3zQ8e4zIbXjrjJTBacsvmG1daVgIKDRCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SjPHnHJj/XeyRJc4lWrrKFqBOJLG11ag769tMT/dOU=;
 b=Sc+pvMUndagSLjrrd9mQvLXaLbvBt/Gt8SUceQm2sUjCsh3g6LSLGBM2bSiVorxqyM90GPwdsQFIo3X3FLXSMnNKwiw2v2oqvuquYfAWlfBr8ZLpW8K0jvdCSxoVQRXk2N4B5p7YXKyuPQwlCJkE29fwbefgPmEby23gfY9sE2TwibMV9t6KSyebLTp1pzxGXno1lBvSukkcilzFIR5t6RJV6ceWUtR03jgzosyDYnEuc4UnKKod15BX5me61EmwfwAqkuAdoeEI2cgX33BpqxImWcB+bYFVgzb0G3p9XZ8XaF3Nikj6t9ZL+Jb+DnnQuuZdJ8o+IW8BodViJL+XKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SjPHnHJj/XeyRJc4lWrrKFqBOJLG11ag769tMT/dOU=;
 b=VCKqPPc1yKQ0aSJ+cT6qzIWhjEECezCi+bM6ZUR0/kN4dzFDR3XIN2jLiGSRX8TtSp4sseG47xqpBOsJ+mMIA4ULmJtCa0Sejr/UVUUWNV04l3O3icyM5rFxYPoYXv3UBBWuHKm0WD/JkiQavVwy7n71bLXgmdUtZgS5tIB9Z6m3qAPR702YAEsJLBkceDClQPxfCmhyZ7h+FvxjP5DlYKdMJ74Jlsao026eN2msGvfza3L0Ox09tK+KtjPemThvJksNTeRxyun4EJQXf3kSsqX1L9roGQcVjhMpQxg6WcV+78PG0DY1nn9dnF0U1EdMlTQN6FdMeWpo2SVqrcPRaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS4PR04MB9362.eurprd04.prod.outlook.com (2603:10a6:20b:4e7::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 07:19:08 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 07:19:08 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Wed, 16 Oct 2024 15:17:56 +0800
Subject: [PATCH 03/17] pinctrl: nxp: add SCMI pin control protocol driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-imx95-v1-3-f640c8f3bc1b@oss.nxp.com>
References: <20241016-imx95-v1-0-f640c8f3bc1b@oss.nxp.com>
In-Reply-To: <20241016-imx95-v1-0-f640c8f3bc1b@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Alice Guo <alice.guo@oss.nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2P153CA0016.APCP153.PROD.OUTLOOK.COM (2603:1096::26) To
 PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS4PR04MB9362:EE_
X-MS-Office365-Filtering-Correlation-Id: ec426248-1e44-403d-256f-08dcedb2d368
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d2hUalBjSzZpaUZZK3lLeE5pMUVXU0NFTjZVcVU0R2VGZWNMR3FpWjR4cXUv?=
 =?utf-8?B?LzUvb2RVVUJKSGgzTnBrQWxCZWhJc1g5UTNiSjFVa1lzS0VoaUFBWHZ4dzdD?=
 =?utf-8?B?Y2tyL3dMSmxxaFZwRncrZVQrN1lSdmJiYmo4Szk5N09kOVo2allHZVplQ0RV?=
 =?utf-8?B?bDRYSXA4T2UxMUp3bXpzL0lZa0duQUJwUytYWUlMdE5BT2FBWU1XdXF5UTV4?=
 =?utf-8?B?QTE0NmdOdEplcGhBaUZwakJkZmxpSFpWc2pQdzhwZUJXUXpqMHp4WTAyYVlN?=
 =?utf-8?B?bzhNUElSUG5WU1RKZUlWcjhuVmx2YThLditBK0lnelZXRlJkV1VsdFgxVkxK?=
 =?utf-8?B?VmxaRmpTYWFwL3FxcEJBWnAyK0Iva0JzS25kT1p3TmZOQm9ZRHB6c0orTGFv?=
 =?utf-8?B?WVF0M0NZYkkvMlY0QkJKenhEVFh3eGFFSzZDdlZUcC8xaDNSZUVBRlRab3NF?=
 =?utf-8?B?aCtlQVZ6YktCK3liOWJUVnROL3dzUkYyUFAyTjRIbllMYlhieUFpWTR2N3VU?=
 =?utf-8?B?ZjVCeEMwcWNIS01LU3A3VHIyTnA1UXF6OUpoRWo0RDIvUjB6NVRmNVRpcXpJ?=
 =?utf-8?B?TGFlVEJIYTVJckwvYWRnN3psYXgxQXc4WnRwSUtacU8vT04zMlJvT2ZlNDNE?=
 =?utf-8?B?Ym5ZMFY0VUhPNDJ1YVBZU1JaQkUxa0huR2VObEt4UjBHTEtOM2g3S2h5cktp?=
 =?utf-8?B?NXZaM2JSVGY0VGFaalZjcHJaZFBpa1p1Z3Nzc3ZpWmk3Y1gxWjExdDhtMWdD?=
 =?utf-8?B?RHBkNkVSR1piL2U5U1hEQkpBUUNKWE02dlJuZCtSTlBWTi9GYzkraVBxMmVw?=
 =?utf-8?B?ZlAwaElhNjZ1ckR1bmFnNXU1VDZieFBSeG9HVlVWTlRjYjdJRFRtWlN3amN6?=
 =?utf-8?B?YjZ1enNjVTJzR0l0TFZjVlpORldtNHhRMWt5NW8wRE9LVkxOMlptZDF0ZUdW?=
 =?utf-8?B?cnA3N2dpbWVLR0pRMWpYZTZZNm93V09Ld3M5aXFDK01KSUJpZktNcGNyTFMr?=
 =?utf-8?B?WENJNk13dk4xSXNUQ2xVVHAvd0xkcGg5eFdXWVFZa01COHFzQ0I5eWFRVXlV?=
 =?utf-8?B?d1RGNmRCR2o5UENieER2dTU2S045ekRXeGZaRVBQanluRncvT09BTEpPclhN?=
 =?utf-8?B?VUFrc0N1ZmMvNWRaMmc1NFYwZmNlaWowR0lBbUZQbEIzelZxOGZnRHhlQ24v?=
 =?utf-8?B?c3grS3ZrWmkrZnU3Z21kZlcydlk3a2V4MURoRFI5RVQ5ZXdOUm1hZVI1dmxZ?=
 =?utf-8?B?a0NVWDhDbnJzalMzM2JrMVBGZ3dxY3ZwdlNGbS83bVgybDlaY1Y1cXlPSm9O?=
 =?utf-8?B?UXhPVmFIN29NYWRxdmM4V1NSS1dEMk9sNVdhRzVDOGJ5U2cvUGtCZGFUZ004?=
 =?utf-8?B?UVY4Ym1QU3ZFVHd5b1NmL3NadnR6SjRJV3ZSZWIrSEJmVmhBR08ybWpWSkc3?=
 =?utf-8?B?NnJFV0pDc1N3YTBOVWVUbi9LT2FTeXN4eVBsVlN0Q01JVkdtcS9CY2FBNkZY?=
 =?utf-8?B?WTlicmFGY2RIZnFmVE12WUI3empSbTNuYllJSDNXZHBXSUpsQ2w3dGVGNlY1?=
 =?utf-8?B?MFR4NGJxOEpiSVZ5MlkxQy9OMEFmVGl4ZEc5eDlkOXJDc1AydmJjU290Ukt4?=
 =?utf-8?B?MjdRQ3pOeG5PbG9IRUZlNzdsV1UrWjJpTHNXMzM4TnJvZVZWYlVFdTRxNE1E?=
 =?utf-8?B?NjZSbzVKZEtYbjkxTHlRY2dPTzBzZHYwYWVkRlNuVVYzcE9vSDhVN3h5NGpW?=
 =?utf-8?B?aCsvRVlIYXIxSE1zejN3dzArVU1hOXEzVkZRdzRoSE1WUVc5WUg3OVRUVThi?=
 =?utf-8?B?MTVtQWVFdjRwN1Q2VmpDUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0d4SDRkYXByYkl2MzNxd1I4dUhmaEdkNzJuc3BWU2ttS2R1Uitzc0VYazlH?=
 =?utf-8?B?aUo1YTkrMTVIYWpQTTZpb1lHT1M4VlpBWTVRbVVIYlFFQnlSeFkwZVE2V1hH?=
 =?utf-8?B?K2tTT0Z1bVErU2ZFWnUvdHkyK2hpWlNSQXBqVmxzYjlCQm8rWDE2WDN3akdr?=
 =?utf-8?B?eE9jb0FhRE5JN3FqQnBNbE9pRDNCVGtQZE41VUNHeFltakptSlBDbUxGV1Bz?=
 =?utf-8?B?ek9FODVCbk9aZmkwWFM2MXdDN0U2N2dKcnFnYUdVNk4zelhqa1AxT0lqQ25K?=
 =?utf-8?B?UkFRYkliT0tBamhsVWpQRFM1S2NHVmNRMFg2cW10eTkxdUxjb05VT0pxc0Nj?=
 =?utf-8?B?SUZoODI2Y3NKQWNqTXNPQjlIMTB3RWw5QU5LSnU1STYybTlMWDR1bkRqNjkr?=
 =?utf-8?B?Ylg0VHhHREF0eFpYNEFKdHdFU0tDRkNqL1FuVkQ5NDNCcFYwbDRpRTBnWkRC?=
 =?utf-8?B?UE1PTFpud3dhTWdaejcxOXJMbHN0WjJiZ2pjRi9LNzFJOFZXQXBXbkNYc3Zy?=
 =?utf-8?B?NXFEVnhjUkRMY1N4disrQVhIWDF4eHJOVzRJcE1qSXBIZjIzd2FtMkl0NzFv?=
 =?utf-8?B?NzB4TE4xOHk4MVJVNWRPVkJQRU53Uk8xQnJJVEV6SU5CYmNib3VMMlg2ZStI?=
 =?utf-8?B?cy85czdOT3cwMnlCaUk2SEhDbmV1d09Qc0N4TTcrK2RiRVlaS2x3VXoxM1pP?=
 =?utf-8?B?bHllbm5GTzVaOSsySmFzcmZYZjBhWTZjKzk1RlQ5MU1ZRXVWUlVGM2JXaitO?=
 =?utf-8?B?MGFXaGVPOGc0cGNmYUMra2pGWWtYVXN0cWxpNTBkZi9VT1EzUXcvaW9pc3VW?=
 =?utf-8?B?RThMb0V6Z1pwazZnZnJmMkxHOWh0aHpCS25scktUQ3NJSjBIR2VmSm9FQXFG?=
 =?utf-8?B?MXdIYnBrVWVNV20xK29wUDdQOVlURVFZOWFvWm5mUHBOUDFSWVZ6MnprdzNa?=
 =?utf-8?B?dFk4VjBEbzMzdWVsa0pnQ2tQRWtPQ1dTeVhOaVMwVnhURkNBUkEvcTFRVFFB?=
 =?utf-8?B?ZzlZdzNNMEZkYVNFYlJzR1ZPS1NUWi91Z0Q4ditZRms4QndpR20veTUyWmtX?=
 =?utf-8?B?NmxxbzFYSENYMGtOemwrcTFUNHpxMjRhZ0xFMm9VRTdUZnhDT0taeDVPOXBI?=
 =?utf-8?B?NSsvSXdiS3YzWXFtRXJQK3JlRTkwYVlkNHFTY0ZpWHBIRlMxNUpGSTJ2bk8w?=
 =?utf-8?B?YStnRGJIZkRFVDJHY2dEdVVxOGVxK0ZLTjRIQnJlUWRUYi9BNXZXdk5HTVZ5?=
 =?utf-8?B?OEJSUkk3UUdhWHFzY25PUDNkWVh0MTVFYkZiS2I5QzZKdGhiYkh0S3hSRzcw?=
 =?utf-8?B?RXJpRFdHdlE0TjRDNExCQmN5N0JUY0JVV2VwRDd2alA2Zk8xWFZpbmZWaGEv?=
 =?utf-8?B?MjBLWDhUdngyOWxvb0ExSWFaeEs3RkVHeWtLTEVXZkZ3ZDRIbHgwa3BGM2Z1?=
 =?utf-8?B?S1RHWjBycFZEN1dkYU1qWVhBY2pLSVBueEVybmY2Y1plNktMKzhONmRIZEQx?=
 =?utf-8?B?NUdmTWt4NXl0RHdPblpFMmdFb3JwUzVWOE5GNVgxeUpxVzk4NGd6TVBrL0J6?=
 =?utf-8?B?NU1GNklteE5GWkQ1bEI4UmJOU1dYNExWa1FKeVMrUy9KZjRYV1lCYUZ5ekhp?=
 =?utf-8?B?UDJEQ3Z3VzRqSyszcE5pWjEzN29VdncySysvbE9EaENjNmtSSk1LNlZPMWEz?=
 =?utf-8?B?b05SamdvM0RpRkdVN0ZFUDFDVU9WMVgyOUIweVlnTHpUUVd0YzM5UDdJdzda?=
 =?utf-8?B?bmNyZkFFYWNubXU4V0tjRXYzaXJMcVROSHh0R1JHaGM5V08ybVAzQ0tmeFlP?=
 =?utf-8?B?TXVleFU4bUJoNDAvKzh5S25jcmNuWjNIOTgzYzVwYzREemRiUEdOS25aUGFM?=
 =?utf-8?B?NlRla1FENG1oWkx2dExVYkJhdGlybnkzOGF2VHJOYkozbllNaGJQdXFKQU1r?=
 =?utf-8?B?a2pJZEVMUmZ5R283UTZpM2lxeW5vdzVnTDl1NkRKbDBwVndiQW95M2d5aG1r?=
 =?utf-8?B?enZXR0d3NzhPNm1OYW5IRjZiZDY4N3ArcFlCc2hJOTFCbjh4amE1Q1RZOWpE?=
 =?utf-8?B?RUdGRmNiVWFMMmdhOFBCSGh3L1hXUWE5b2o4cjE2dWFTWTNGcHp3azRRMVVw?=
 =?utf-8?Q?rNqzgx3y7UkbSXjg+A9p3Zdhw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec426248-1e44-403d-256f-08dcedb2d368
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 07:19:08.7726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dDJJf/9yATsX2NiAr1ayJ/k6z7sK/CQ5vpufvbcU5sIpkv5fqU5RBypK6ZOXLB0DQUU5MVaav35168f+qvS49g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9362
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

This patch provides a driver for the SCMI pin control protocol which is
based on ARM's System Control and Management Interface (SCMI) 3.2.
Currently, only the PINCTRL_CONFIG_SET command is implemented.

Signed-off-by: Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 drivers/firmware/scmi/scmi_agent-uclass.c |  11 +++
 drivers/pinctrl/nxp/Kconfig               |  13 +++
 drivers/pinctrl/nxp/Makefile              |   1 +
 drivers/pinctrl/nxp/pinctrl-imx.c         |   7 +-
 drivers/pinctrl/nxp/pinctrl-imx.h         |  11 +++
 drivers/pinctrl/nxp/pinctrl-scmi.c        | 136 ++++++++++++++++++++++++++++++
 include/scmi_agent-uclass.h               |   2 +
 include/scmi_protocols.h                  |  34 ++++++++
 8 files changed, 213 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
index 8c907c3b0328095c4b35ba089ed608fcda48b567..6b9d8361c236114b6ca6c36390ab1aeab9e60e0f 100644
--- a/drivers/firmware/scmi/scmi_agent-uclass.c
+++ b/drivers/firmware/scmi/scmi_agent-uclass.c
@@ -97,6 +97,9 @@ struct udevice *scmi_get_protocol(struct udevice *dev,
 	case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
 		proto = priv->voltagedom_dev;
 		break;
+	case SCMI_PROTOCOL_ID_PINCTRL:
+		proto = priv->pinctrl_dev;
+		break;
 	default:
 		dev_err(dev, "Protocol not supported\n");
 		proto = NULL;
@@ -147,6 +150,9 @@ static int scmi_add_protocol(struct udevice *dev,
 	case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
 		priv->voltagedom_dev = proto;
 		break;
+	case SCMI_PROTOCOL_ID_PINCTRL:
+		priv->pinctrl_dev = proto;
+		break;
 	default:
 		dev_err(dev, "Protocol not supported\n");
 		return -EPROTO;
@@ -436,6 +442,11 @@ static int scmi_bind_protocols(struct udevice *dev)
 				drv = DM_DRIVER_GET(scmi_voltage_domain);
 			}
 			break;
+		case SCMI_PROTOCOL_ID_PINCTRL:
+			if (IS_ENABLED(CONFIG_PINCTRL_IMX_SCMI) &&
+				scmi_protocol_is_supported(dev, protocol_id))
+				drv = DM_DRIVER_GET(scmi_pinctrl_imx);
+			break;
 		default:
 			break;
 		}
diff --git a/drivers/pinctrl/nxp/Kconfig b/drivers/pinctrl/nxp/Kconfig
index 06c26f156f6c8f63204604d6065485629cfd9b61..0086f9825837bf568bd7633a21da860e410eeeee 100644
--- a/drivers/pinctrl/nxp/Kconfig
+++ b/drivers/pinctrl/nxp/Kconfig
@@ -1,6 +1,19 @@
 config PINCTRL_IMX
 	bool
 
+config PINCTRL_IMX_SCMI
+	bool "IMX pinctrl SCMI driver"
+	depends on ARCH_IMX9 && PINCTRL_FULL
+	select PINCTRL_IMX
+	help
+	  Say Y here to enable the imx pinctrl scmi driver
+
+	  This provides a simple pinctrl driver for i.MX SoC which supports
+	  SCMI. This feature depends on device tree configuration. This driver
+	  is different from the linux one, this is a simple implementation,
+	  only parses the 'fsl,pins' property and configure related
+	  registers.
+
 config PINCTRL_IMX_SCU
 	bool
 
diff --git a/drivers/pinctrl/nxp/Makefile b/drivers/pinctrl/nxp/Makefile
index f10aa6ef188e37583b181bdf9d70ac191e506d75..3ec3e2a9c6fdb875da4ae9bf151df5666256883b 100644
--- a/drivers/pinctrl/nxp/Makefile
+++ b/drivers/pinctrl/nxp/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_PINCTRL_IMX6)		+= pinctrl-imx6.o
 obj-$(CONFIG_PINCTRL_IMX7)		+= pinctrl-imx7.o
 obj-$(CONFIG_PINCTRL_IMX7ULP)		+= pinctrl-imx7ulp.o
 obj-$(CONFIG_PINCTRL_IMX8ULP)		+= pinctrl-imx8ulp.o
+obj-$(CONFIG_PINCTRL_IMX_SCMI)		+= pinctrl-scmi.o
 obj-$(CONFIG_PINCTRL_IMX_SCU)		+= pinctrl-scu.o
 obj-$(CONFIG_PINCTRL_IMX8)		+= pinctrl-imx8.o
 obj-$(CONFIG_PINCTRL_IMX8M)		+= pinctrl-imx8m.o
diff --git a/drivers/pinctrl/nxp/pinctrl-imx.c b/drivers/pinctrl/nxp/pinctrl-imx.c
index ff466c4910414db3ad8790cd59596a9836b29e28..cdadf7a3f10e3be940fe5660a7103143a7f517b3 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2016 Peng Fan <van.freenix@gmail.com>
+ * Copyright 2024 NXP
  */
 
 #include <malloc.h>
@@ -65,7 +66,9 @@ static int imx_pinctrl_set_state(struct udevice *dev, struct udevice *config)
 
 	npins = size / pin_size;
 
-	if (info->flags & IMX8_USE_SCU) {
+	if (info->flags & IMX_USE_SCMI) {
+		return (imx_pinctrl_scmi_conf_pins(dev, pin_data, npins));
+	} else if (info->flags & IMX8_USE_SCU) {
 		imx_pinctrl_scu_conf_pins(info, pin_data, npins);
 	} else {
 		/*
@@ -215,7 +218,7 @@ int imx_pinctrl_probe(struct udevice *dev,
 	priv->dev = dev;
 	priv->info = info;
 
-	if (info->flags & IMX8_USE_SCU)
+	if ((info->flags & IMX8_USE_SCU) || (info->flags & IMX_USE_SCMI))
 		return 0;
 
 	addr = devfdt_get_addr_size_index(dev, 0, &size);
diff --git a/drivers/pinctrl/nxp/pinctrl-imx.h b/drivers/pinctrl/nxp/pinctrl-imx.h
index fa4c084e2fc067fcb4e92c33312d4f430081fffd..b2f8865ded0ae380fc0156baa5eaea505c12f501 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx.h
+++ b/drivers/pinctrl/nxp/pinctrl-imx.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2016 Peng Fan <van.freenix@gmail.com>
+ * Copyright 2024 NXP
  */
 
 #ifndef __DRIVERS_PINCTRL_IMX_H
@@ -47,6 +48,7 @@ extern const struct pinctrl_ops imx_pinctrl_ops;
 #define ZERO_OFFSET_VALID	0x2
 #define CFG_IBE_OBE		0x4
 #define IMX8_USE_SCU		0x8
+#define IMX_USE_SCMI		0x10
 
 #define IOMUXC_CONFIG_SION	(0x1 << 4)
 
@@ -65,4 +67,13 @@ static inline int imx_pinctrl_scu_conf_pins(struct imx_pinctrl_soc_info *info,
 }
 #endif
 
+#ifdef CONFIG_PINCTRL_IMX_SCMI
+int imx_pinctrl_scmi_conf_pins(struct udevice *dev, u32 *pin_data, int npins);
+#else
+static inline int imx_pinctrl_scmi_conf_pins(struct udevice *dev, u32 *pin_data, int npins)
+{
+	return 0;
+}
+#endif
+
 #endif /* __DRIVERS_PINCTRL_IMX_H */
diff --git a/drivers/pinctrl/nxp/pinctrl-scmi.c b/drivers/pinctrl/nxp/pinctrl-scmi.c
new file mode 100644
index 0000000000000000000000000000000000000000..19b1b433a5ced0bb85e52f4d19bdeab2825f275e
--- /dev/null
+++ b/drivers/pinctrl/nxp/pinctrl-scmi.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP
+ */
+
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <errno.h>
+#include <misc.h>
+#include <scmi_agent.h>
+#include <scmi_protocols.h>
+#include <asm/io.h>
+#include <asm/mach-imx/iomux-v3.h>
+#include <linux/bitops.h>
+
+#include "pinctrl-imx.h"
+
+#if defined(CONFIG_IMX93)
+#define DAISY_OFFSET	0x360
+#endif
+#if defined(CONFIG_IMX95)
+#define DAISY_OFFSET	0x408
+#endif
+
+/* SCMI pin control types */
+#define PINCTRL_TYPE_MUX        192
+#define PINCTRL_TYPE_CONFIG     193
+#define PINCTRL_TYPE_DAISY_ID   194
+#define PINCTRL_TYPE_DAISY_CFG  195
+#define PINCTRL_NUM_CFGS_SHIFT  2
+
+static int imx_pinconf_scmi_set(struct udevice *dev, u32 mux_ofs, u32 mux, u32 config_val,
+				u32 input_ofs, u32 input_val)
+{
+	int ret, num_cfgs = 0;
+
+	/* Call SCMI API to set the pin mux and configuration. */
+	struct scmi_pinctrl_config_set_out out;
+	struct scmi_pinctrl_config_set_in in = {
+		.identifier = mux_ofs / 4,
+		.function_id = 0xFFFFFFFF,
+		.attributes = 0,
+	};
+	if (mux_ofs != 0) {
+		in.configs[num_cfgs].type = PINCTRL_TYPE_MUX;
+		in.configs[num_cfgs].val = mux;
+		num_cfgs++;
+	}
+	if (config_val != 0) {
+		in.configs[num_cfgs].type = PINCTRL_TYPE_CONFIG;
+		in.configs[num_cfgs].val = config_val;
+		num_cfgs++;
+	}
+	if (input_ofs != 0) {
+		in.configs[num_cfgs].type = PINCTRL_TYPE_DAISY_ID;
+		in.configs[num_cfgs].val = (input_ofs - DAISY_OFFSET) / 4;
+		num_cfgs++;
+		in.configs[num_cfgs].type = PINCTRL_TYPE_DAISY_CFG;
+		in.configs[num_cfgs].val = input_val;
+		num_cfgs++;
+	}
+	/* Update the number of configs sent in this call. */
+	in.attributes = num_cfgs << PINCTRL_NUM_CFGS_SHIFT;
+
+	struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_PINCTRL,
+					  SCMI_MSG_PINCTRL_CONFIG_SET, in, out);
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret != 0 || out.status != 0)
+		dev_err(dev, "Failed to set PAD = %d, daisy = %d, scmi_err = %d, ret = %d\n", mux_ofs / 4, input_ofs / 4, out.status, ret);
+
+	return ret;
+}
+
+int imx_pinctrl_scmi_conf_pins(struct udevice *dev, u32 *pin_data, int npins)
+{
+	int mux_ofs, mux, config_val, input_reg, input_val;
+	int i, j = 0;
+	int ret;
+
+	/*
+	 * Refer to linux documentation for details:
+	 * Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt
+	 */
+	for (i = 0; i < npins; i++) {
+		mux_ofs = pin_data[j++];
+		/* Skip config_reg */
+		j++;
+		input_reg = pin_data[j++];
+
+		mux = pin_data[j++];
+		input_val = pin_data[j++];
+		config_val = pin_data[j++];
+
+		if (config_val & IMX_PAD_SION)
+			mux |= IOMUXC_CONFIG_SION;
+
+		config_val &= ~IMX_PAD_SION;
+
+		ret = imx_pinconf_scmi_set(dev, mux_ofs, mux, config_val, input_reg, input_val);
+		if (ret && ret != -EPERM)
+			dev_err(dev, "Set pin %d, mux %d, val %d, error\n",
+				mux_ofs, mux, config_val);
+	}
+
+	return ret;
+}
+
+static struct imx_pinctrl_soc_info imx_pinctrl_scmi_soc_info __section(".data") = {
+	.flags = ZERO_OFFSET_VALID | IMX_USE_SCMI,
+};
+
+static int imx_scmi_pinctrl_probe(struct udevice *dev)
+{
+	struct imx_pinctrl_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = devm_scmi_of_get_channel(dev);
+	if (ret) {
+		dev_err(dev, "get channel: %d\n", ret);
+		return ret;
+	}
+
+	debug("%s %p %s\n", __func__, priv, dev->name);
+	return imx_pinctrl_probe(dev, &imx_pinctrl_scmi_soc_info);
+}
+
+U_BOOT_DRIVER(scmi_pinctrl_imx) = {
+	.name = "scmi_pinctrl_imx",
+	.id = UCLASS_PINCTRL,
+	.probe = imx_scmi_pinctrl_probe,
+	.remove = imx_pinctrl_remove,
+	.priv_auto = sizeof(struct imx_pinctrl_priv),
+	.ops = &imx_pinctrl_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
diff --git a/include/scmi_agent-uclass.h b/include/scmi_agent-uclass.h
index 33e0e18c30d4ae4ddaaa2cb3830c03cd7a559cc0..4beec43cb080b14a777cac1cb0f18ef53433596c 100644
--- a/include/scmi_agent-uclass.h
+++ b/include/scmi_agent-uclass.h
@@ -27,6 +27,7 @@ struct scmi_channel;
  * @clock_dev:		SCMI clock protocol device
  * @resetdom_dev:	SCMI reset domain protocol device
  * @voltagedom_dev:	SCMI voltage domain protocol device
+ * @pinctrl_dev:	SCMI pin control protocol device
  */
 struct scmi_agent_priv {
 	u32 version;
@@ -43,6 +44,7 @@ struct scmi_agent_priv {
 	struct udevice *clock_dev;
 	struct udevice *resetdom_dev;
 	struct udevice *voltagedom_dev;
+	struct udevice *pinctrl_dev;
 };
 
 static inline u32 scmi_version(struct udevice *dev)
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 7abb2a6f36ba53223bd9103fcc02f58506fbfc8d..2367467512a6b65253317e51bea71de396aa96f9 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -24,6 +24,7 @@ enum scmi_std_protocol {
 	SCMI_PROTOCOL_ID_SENSOR = 0x15,
 	SCMI_PROTOCOL_ID_RESET_DOMAIN = 0x16,
 	SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN = 0x17,
+	SCMI_PROTOCOL_ID_PINCTRL = 0x19,
 };
 
 enum scmi_status_code {
@@ -1005,4 +1006,37 @@ struct scmi_voltd_level_get_out {
 	s32 voltage_level;
 };
 
+/* SCMI Pinctrl Protocol */
+enum scmi_pinctrl_message_id {
+	SCMI_MSG_PINCTRL_CONFIG_SET = 0x6
+};
+
+struct scmi_pin_config {
+	u32 type;
+	u32 val;
+};
+
+/**
+ * struct scmi_pad_config_set_in - Message payload for PAD_CONFIG_SET command
+ * @identifier:	Identifier for the pin or group.
+ * @function_id:	Identifier for the function selected to be enabled for the
+ * 					selected pin or group. This field is set to 0xFFFFFFFF if no
+ * 					function should be enabled by the pin or group.
+ * @attributes:	Bits[31:11] Reserved, must be zero.
+ * 				Bit[10] Function valid.
+ * 				Bits[9:2] Number of configurations to set.
+ * 				Bits[1:0] Selector: Whether the identifier field refers to a pin or a group.
+ * @configs:	Array of configurations.
+ */
+struct scmi_pinctrl_config_set_in {
+	u32 identifier;
+	u32 function_id;
+	u32 attributes;
+	struct scmi_pin_config configs[4];
+};
+
+struct scmi_pinctrl_config_set_out {
+	s32 status;
+};
+
 #endif /* _SCMI_PROTOCOLS_H */

-- 
2.34.1

