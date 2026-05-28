Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27978CD5BD0
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 01:49:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92B43846E2;
	Thu, 28 May 2026 03:49:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="x83lNl/E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 242BC84702; Thu, 28 May 2026 03:49:01 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8F0B846D1
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 03:48:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sdDTN/mMJKVN6c75spnRsAQKJzo1R9PZ/N03LCcIWHB95k0whrLxtFZFL4bw8v+3WcgNeGkPJQ/SmCWyOTIjYGYx9kxRxQXgwbDl9WCnI/l7P6V9DcoT6g4jcUK92S8tOKkHkLjLWldardVr2Gv8ZR14zp47KeO4d7ljbARLCwryszfCdxsgwfJvBRyQpCz1W5BPvOFWUDu6ArdIzSWfFnyrHbqpbx7Cxc0bV9Cl0e1LoSDYaVb+1GI9aU8o0MrLn5m7Eq7TWBaDt2lUS5fN0/Vz+itPzehbCkzomlJMQ2wrObs76Ap2bflR8f22B/YpVMGWSohBogItapalZlw+IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTSZGMS9vB4l0SBARHVGVSUcmJVLQhoFEpA5cLdY9vM=;
 b=nvBbGChMrnrgLWqbkA9psmxIw1DOrmYSs6LRMBn2hax+VQYZ/yIREAv7EY3ENSnh3uWOfra9XfkTv4lhnw4uMEiOpq9rj3bMkEqHBQL50qfAKcDWklTmhiEIj2rC1GLXAePko4pq34XvybX11Mci1v+QTrRbpW1jGn3tSNOcEg4LZXyQLObs95+W9UoCoyAJ5wSsD7RcRCGmxOV1Mvk1KMI66tCkFnhpsECur0tOQUG65hlnSH6meccXZpLM6xKkbH2hw9HGdq5HmaliCBlfDG0g3EKcRztGYs1aK56n2wuwn0DmNBGJgG9ZQtMg1gdOPJH1CREYxgbjL6xTPPdL8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTSZGMS9vB4l0SBARHVGVSUcmJVLQhoFEpA5cLdY9vM=;
 b=x83lNl/EYtbr9DEjna5fJDgDwnP1d/Plo/5+E7D0olTgqYXwH1zJtGxV+kOv3fzCSR6Hw2SoS+s+yrJBe756nhsjHtOP8hQr85Fihk9fWsNGeowihOh+T2p6Zk7Wsp9sxQ17kBCsB/QluP4Rm95P95zGJHVYpUkMO0DkkkB+28e+0lMJ0O4Vv+3tAFb/rHcD8Jc4FiYJdnJQ39CRoDKYiauq+cfeJ2P07367XODndtebW+uGliWB+cL0RxZN92+CTT/aZodYJJ8fjgmuKi/DFCapZcaPCKVNLKJAqyWrugXCc4THnzBiiVrJ1iLE2Z+pm0Sw3AnVEbPuMVSkB9fr/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by GV2PR04MB12138.eurprd04.prod.outlook.com (2603:10a6:150:327::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 01:48:54 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Thu, 28 May 2026
 01:48:54 +0000
Date: Thu, 28 May 2026 09:51:53 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.denx.de, Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Wasim Khan <wasim.khan@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: Re: [PATCH v2] arm: dts: fsl-lx2162a-qds: drop &dspi{0,1,2} block
Message-ID: <ahefuWTHuddDbf1j@shlinux89>
References: <20260510203738.515452-1-vjardin@free.fr>
 <20260526171801.393543-1-vjardin@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526171801.393543-1-vjardin@free.fr>
X-ClientProxiedBy: SI2PR01CA0013.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::9) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|GV2PR04MB12138:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bccee4f-c55d-41ab-4ea3-08debc5b4617
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|52116014|1800799024|22082099003|18002099003|38350700014|4143699003|3023799007|56012099006|11063799006|15866825006|41080700001;
X-Microsoft-Antispam-Message-Info: 9drnRLxufVBJbMv6PQM2VrNhMdKQN08C2l6ooV97iO6PDdvzsNfEguJoRRIAjo1/uQU23Sg7I/6/LvaKXVNgXBGUR+pvAL+xXoiHGXNIYpZzzqVl+i2uajM/3vKZrpoS5MpAVVvYqmgUR2TUD3uEqhFEKXzY3smWh9ttUiZoddcMYgGMKR7z+eAE/0RtGxf+gTpDNMo3if7x3ZF3JW0wJH2Xv5nyVadCay2RJ1WMBDImN1jciK2U4/8Ke2+Gty8DVpN9cfzC+dsCWojtG4wE8f14PMO0vBdLGjGmpEWG7eq/DPqbsPilxXLOw7476hIfqogZ1ZjAA0irC5CbVszCxvz2UbJPgWgu2cQCLyaZx5vLMb69AJEw9rmy9H01PBHiP9fD9xBDkkS+4BE/6lGqW2LNI9/mWP1vCu81v+Rhx0NYtnU3x8A1tFLdAjlCCP+P+/dHJ29bwS3SJ/6oQ5VC/YiBWePzIn97wJ9JN/65TeUtP9oUoHYQ8v3moyn5BfMqG4GECtPQFT5zVx0KWTv8pCxuWYJpI2BvZ6V0OCBEWGWkqffEVKYuKEPYUAZLdQQIVCBSjJolDco8MsRYqMYwATGsLH7/xIgwTcVy8V1UYRF5bJm4IKBqCvfL3JZn+iP24oBQiNiUhIwiSsYnts6L859NR75dJX6lb70/6/Z31RF5R0pA2FXLajUpgppbxtTQ078Ix2epy7Mgwr31jkbRV2N4BYi/whWnUJN4YLW5Pm81Ppuar63HgSHGopJ3LDI7Iu0PORtmBFbnDfSDouyZUirO5+W6QTsVQtsKKUrX0Jegs6nTMeTstSMk7V8cus1O
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(22082099003)(18002099003)(38350700014)(4143699003)(3023799007)(56012099006)(11063799006)(15866825006)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YTxkUeFBaKhIy4GmmMSlK1cIvR7bbl6EEsRxlUTJQ35DYgMTHPSiY1zIwPyG?=
 =?us-ascii?Q?B8ZlwApIAhR9mL42EUd/kp84NlsexGKVjFDdW9xY/7kA4CPA9KSfokmT7FSF?=
 =?us-ascii?Q?6qrS4gMBefkx1dqirQujybORsc4KoFJE3WE7b3dYukeoDSrn5hq0vS555oHh?=
 =?us-ascii?Q?S0nJlN1gL81qms9ATdA8MIkUp3fFlcohQdtymE3yVP9SK49DCbIvgyZiNfGM?=
 =?us-ascii?Q?nAe3pKUsOWSrIEr1Lk+g5ZYJDwymt3ZlFHOwde3YBWng5iQ6TO/Off5kFtqf?=
 =?us-ascii?Q?aQRAPVGHyCmpm05M23vjJcxKbKlyd6024otVo2XLPzyKk+K/0/6AzrwmoLT3?=
 =?us-ascii?Q?4T3YqYMZv3Pt2mrLrVVoYRpQUhFy7P6qDL0qrWTlDAh3/1vaJgEOzUXTRpMT?=
 =?us-ascii?Q?kcgzrfErzM0zyq26MuRE1PdiIr8frMOF8q/wZrUbz2VMdnh2yAL49PvmTk9j?=
 =?us-ascii?Q?bweDmaShX2BtBNlDPVJNCz+vvtw8zg5FdhFHKoGQWgd+/0T3hWECmZ4Adww2?=
 =?us-ascii?Q?mf9SrWCqjj6VUdWlcCuod1sd+/rQsrAE712mxQYmq2Vw6Q2ITVO6gosZJ8OW?=
 =?us-ascii?Q?CkvAE4Z3J/Dn8iQc9x5Ue3nBnB7v4rljsEn5zNYld2Gl2buyC7+aBwDizzmt?=
 =?us-ascii?Q?uvLKMeQ75JsjE3m7BTZ9tMgCi2meXJIDssOAM3ZZkEBH4CGF0ZWEE1TdKut4?=
 =?us-ascii?Q?Ck4LHdaYzM09uPt67MErOSwrkXrw2uf//ytoERR+RHSRrtXqnQ9KJ6GofXgc?=
 =?us-ascii?Q?/Tr2050qQOMJwJlIF8T5XY6DgdI9B6St32IdhMIPiCV1uNJSERoPUE6/VBma?=
 =?us-ascii?Q?g6iJ+GIAIArGErltLdmzk1OkKDyFDGCX5Bj0mSXtnCG4gOFPFkIMLoHAAgCF?=
 =?us-ascii?Q?y7V7rDE1eH41axHuzhZXA6khOFB/jt5YIdph0w/R3sKYyXprRPETsJqjpiTI?=
 =?us-ascii?Q?d12Yq42RJlZqVCCMndlIGeeeXH1mgNKtjQPY5bwHoIZTD/mHvmr4G4j1fQGC?=
 =?us-ascii?Q?nff/9yKDQo/sND8m77SiPDHNpIIz5jF0azEN0u844mGHGUPNzTlffS9PKGmS?=
 =?us-ascii?Q?lhC9tle+PYbLS/5ogFuLNAFE4W1IaT2pPI+0tTCvIBn2ZiVp12dH2TOR97vC?=
 =?us-ascii?Q?Vk99wqLIfCbeQcnRYUqIq0yCQrH3UsdiK2AWyxXOmEDTR+LhgP993230hsHR?=
 =?us-ascii?Q?JRhyFMwL3/rQGxJ90yRym2bhLuk350erI3uE0c7gYJhhzGj9gbW8BB4ivNag?=
 =?us-ascii?Q?IMFJOr3QRvNqDrmoxRj2xAxiThpflyQ7u/mF0ZSpreBWZUjI2x6NwAqRatpT?=
 =?us-ascii?Q?u9yKwupN9D4EAynhfr3yeXWomMOOvkytwp+XHWcoZiQTB7id9nfC6FXut+mb?=
 =?us-ascii?Q?yIl739YTmZQvVECAF4bdhETi60wnZPoR3vhDGHt0AWQ41EqerHzs5bIyepMh?=
 =?us-ascii?Q?2hQXUvovjHGdIl/YoIee3zlPcS8OvqWVKzcvo4ts0nOC9SoLpw4JV85SfkVI?=
 =?us-ascii?Q?5x3OdN1B6ilZ1F8PGMB8MrZZ5WUuydfmeHGZklwv5e6Z/vkm8mcCXOnVAs63?=
 =?us-ascii?Q?R5FfOO9bp1K+8CIfAFYf7G3gdNDSSEkoHcBs9WiobbcMDAaTvj6kR3DpE7g6?=
 =?us-ascii?Q?bInipYfVdXo4NrT03FA8oOXA2m3PgwGIAlNmxgRSs7DQ3wCFDIxNWKt+FqMf?=
 =?us-ascii?Q?6fmC+BPVd+YjO4I10DfOeUoqZOjt6FrseToJN1UrxWfmZrVw/MoB4OEmiLmN?=
 =?us-ascii?Q?MX6rFL7gKw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bccee4f-c55d-41ab-4ea3-08debc5b4617
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 01:48:54.2988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nlI2crJpI7wzDOFsmudc2iPPAdlojQNHelv0cVnJO/GSQ9q/6LHIVvFHuCVTGi7420swZ9TE4vcoP4nUF7wT4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12138
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

On Tue, May 26, 2026 at 07:17:35PM +0200, Vincent Jardin wrote:
>arch/arm/dts/fsl-lx2162a-qds.dts carries a verbatim copy of the three
>&dspi{0,1,2} overrides that are already provided by the parent include
>arch/arm/dts/fsl-lx2160a-qds.dtsi
>
>No functional change, the parent's &dspi{0,1,2} block keeps its
>bus-num, status and flash children intact.
>
>Signed-off-by: Vincent Jardin <vjardin@free.fr>
>
>Link: https://patchwork.ozlabs.org/project/uboot/patch/20260510203738.515452-1-vjardin@free.fr/  # v1
>---
>
>Changes in v2:
>- Rebased onto Tom Rini's next branch per DM with Peng Fan's request (v1 had
>  conflicts with next).
>- Drop rename hunks: already landed on next as commit 8c60833124c
>  ("arm: dts: layerscape: Fix DT build warning in SPI nodes", Ye Li, May 2026).
>- Retain only the duplicate &dspi{0,1,2} removal in
>  fsl-lx2162a-qds.dts (still outstanding on next).
>- Adjust subject and body to match the narrower scope.
>

Applied to fsl-qoriq/next

Thanks,
Peng
