Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED42E63C9E
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 01:32:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D2CE83DFA;
	Mon, 26 Jan 2026 02:32:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RQkM6Pp9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 579AA83E1E; Mon, 26 Jan 2026 02:32:55 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 531F683DDD
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 02:32:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dEgEcIY+5G6rc5LOTCV095lUM7wZ6OdsAIyvuIk3+1PuPNWwLbwVojKF6L4leW0/84Qh1LKFisk/g4ahQ0Hp9WHpW+qIVNDqDv/ZK7wvQOJ5JwMhYuiDqj4StW9mo/+77bR+IXb2mwahxI5MNvu47QVTJqx1y8A36xDLFw7cP5EcwiW3/BgGA1UQBn7tUNQUZ9UK2ExZrcXAYQoB8rMQLYZs7a8NO7ZggFNDcyPEXXSub9rfESZ91WrRfP5eudw8rXhuvc4xPGRz42v9PbZEUNvDQNk3jXWP2tO7wWg+cJdcgz4HRUOJx2xtmkPzHlwbA50A7feHMFuQukVZ1rzRYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6BEm18sR+20a7NOJTSxdNiTXj3m9J575jTKCxKMGmk=;
 b=pkZGXfmy6r9jTzrcokXWpBipD4o+SNzaoYJ/UkbHFmMPJMfo7pc93Te8K9m/G8QNwF3ntrfyev6Sa/wXfB2ct6DiEb7plrMIXFu2+cxNS/83snZj2ea9nArbBdFQxI88bkIQ411sQrcEC6C190KIehXB9CRRakV1jSdNglSbGnIH9MTScEJb4NozB2h1ZY75Oh7bSh6JGcH/rHKnXgeuCrpZPkaQwVoZH3F2P8q5ar8JPRXB0RwG7pf0ryfl9CC3cJpsDYO/QRORFFwNwv5iZtZNRptZZxNoycfVpaj6S7wQo5WeDfNh3Sg8rt6giT45lCBdEmltXbAz1GZuuZmCCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6BEm18sR+20a7NOJTSxdNiTXj3m9J575jTKCxKMGmk=;
 b=RQkM6Pp988nRMRcsNuNAmP5vVyWmVOOmCwf1CWZsVUHONDI+tqj0Z0Zettnf0JVM/JKOxq73MfgTgHPCDnnUjri7Cdz/zEmUGD0n050f8PcSSOKxeODApc2qnQMpdKpAEzkuXlW85QQA8IV/7IUtOgCNCM4cEe4FnXT06PcL5k9kVrRBlKueB3al8ekDmeOtoK95o8YrFHQ19m1xXc39jj3xmPmKJokuFzyfzi7p+qdlPwc+sc5XR9xbKdOxvP7C5XyaZWlMHMFlnZTK0SmAEZw4ncwGhZSPlPlveNuTuP6OpA0WZtIStv4WVxf/QCmiwHfIrXwKpp8ktNBsdFbjFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by GVXPR04MB10540.eurprd04.prod.outlook.com (2603:10a6:150:218::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 01:32:52 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 01:32:52 +0000
Date: Mon, 26 Jan 2026 09:32:48 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Heiko Schocher <hs@nabladev.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Tom Rini <trini@konsulko.com>,
 Walter Schweizer <walter.schweizer@siemens.com>
Subject: Re: [PATCH v1 10/11] siemens: capricorn: rework bootcmd environment
 variables
Message-ID: <aXbEQJsoHAvVI6yx@shlinux89>
References: <20260124055452.8799-1-hs@nabladev.com>
 <20260124055452.8799-11-hs@nabladev.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124055452.8799-11-hs@nabladev.com>
X-ClientProxiedBy: SI2PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:4:197::8) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|GVXPR04MB10540:EE_
X-MS-Office365-Filtering-Correlation-Id: d9906314-02fd-4b8f-2d73-08de5c7ad265
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0h8hMjf07oP22B6zTMkXCYHFQOYOzI+LyfRx4JHIWTC/BahNqmub3k7QHDrM?=
 =?us-ascii?Q?Qxc2aOKAMIadbp/3LAVDAL2AOze0rHs6AQwQUa4Kqd3mC51YFMdmOKWHAuIp?=
 =?us-ascii?Q?sXxlqGxHmvdqqc8LyEj4J6uCnO1TlOnuw7zboN7Iy7z41cmyAqua3bPwGftN?=
 =?us-ascii?Q?8PhoFJX3E+k+euVgYxlbanEuR84+eR9Pw8wwK3FQJ31IiyeGUoZKQaU/T0uS?=
 =?us-ascii?Q?SVg0BoBzEKLMbdcCn/vXcNNmONKETGTDy0rEPf58FHwMz8qLqUkpH59qgoqg?=
 =?us-ascii?Q?5CP5RbQRCkA528/WTBSzh60prSuR17bxkd0/tEecvdSIzdI/ieRQMQvrS4Wo?=
 =?us-ascii?Q?cU4Q+cd5z7F3MeioF+x9whnFXNQBL++DXOIvdd7bBxTqqq9HyfD0gF47qBTS?=
 =?us-ascii?Q?QFXEJ1fph2HJJuxFPTURPHyY5uw7ha+OP8nUpqP8UZFD2rotQYDhq1/AJHSs?=
 =?us-ascii?Q?VcfZUA35Z3Lv2xogKeeHWRgkRhTMZxzm7+9K6pRfAx+MeLGLQQdrxKPNCmTP?=
 =?us-ascii?Q?d2Ootx/EvYUfDtRrEtFLF33I4JcTQjx/qKGoO+h/SxazFNzF4dFdGUxJbowg?=
 =?us-ascii?Q?gvZtl5pLMhR1y3uLaiVJybdLINJ3oRatAOvd0lL7SAVu4RDkRBpmNGtzavDs?=
 =?us-ascii?Q?lSGhBa7B33SPgDn+XPhYwbTXhF3hDe3oYZZ5oVeCWNd/xuwT2/Iu4ASrxiQ9?=
 =?us-ascii?Q?DOQlWI1zWzOxw8l88QCfVvzT0rR+wNyacwfrnIJ3jF6GH6qCZAr0vGOoS2Fp?=
 =?us-ascii?Q?zlTBeM+6xbHxHTTPOKbYCHUahfZdYdNFKC5LRNXYOMgiRLMVDk8uHXBhhGNi?=
 =?us-ascii?Q?F81su4xgWMwcArVtKDIJPF1jvEyuHoaEuDA5hZe40jqkkrSTbQ4EzGGnILvS?=
 =?us-ascii?Q?TYT01foEv1h/yMDyNOzN1zrsKrMR/ID91rtjUeKi0vsIY+D76iy1ja8oLzwR?=
 =?us-ascii?Q?EzOR6fstOkx4j/z3IiguqJNIfwnoDMOGtAtsyucvpx14okbFr5ZpdUjyKWi9?=
 =?us-ascii?Q?iVWEtcypp9DCW+aMT4Vpj8us5fA5Voyarjll2MlUnykeVQlt8HF9gDrbz36U?=
 =?us-ascii?Q?lVKEbuy7Ek4JSQn/ru+ES9SGPbyVt2p/138Hsu4cei36nSkmjm36Kf26x2E3?=
 =?us-ascii?Q?lvTuz9gcGw5+gGRB2HHD0OHNW37hBp34ZVaTUCFIWwR9cze4TBabbR+um2aP?=
 =?us-ascii?Q?AdX50cFqW1OaG0eeuCoZ+MdtdP0b7bhAaTzlFB4NRKFOHTiD81Ls4G/RwI5a?=
 =?us-ascii?Q?IJPtBseqeI7wEyxmnvvDwuRTF3028RlIz47Ft60/z+5QdMYlNxarNNRMJTOV?=
 =?us-ascii?Q?/JBRbEXYV9ay9vyW6UWHD9Hl/V++Fj53HGRKfdbUnZyADAWDjvssK+jx7aK9?=
 =?us-ascii?Q?9WM/VGtgfIDkoDdR5qwjiE7JpetyNVXkawbZnisNvxKHz2LDvmGBDoayNZGP?=
 =?us-ascii?Q?XLrKfILlDIQcPBF/gnQ9eQJXmLQEI5Zt02Di5VIVSf8cKJpPxFwnSMXtKYYz?=
 =?us-ascii?Q?G1N0v67DZkrDlY8lz9zB+9xoTTSjKyj7dPigelLYH1J1g0URCPUsVndTqnP7?=
 =?us-ascii?Q?qOCCQdxqV7dRtovmp27cf2s0opJdDCfHsJ8D24QaQOtzTzPAiq9dKHx1mJVm?=
 =?us-ascii?Q?87NcDQmPYEBap6UiDrlq2TI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g+DLHiTB2AuKc1aBlkYMS7BbsHuCTM0suBdNP1jOJblXCBocuXqcyNoDscRd?=
 =?us-ascii?Q?CY5Kk2LatrTzF+CD69JvaXTRzL66aGbQF/ARvRfErUYS7AX3KmSLstPOa92T?=
 =?us-ascii?Q?cdOU4n/MSvGcYyQVNjQOY6rZlGuEHDUdoCiVSNzCndhyJzZNBflTy3LwXR6w?=
 =?us-ascii?Q?xe8qBOCKXUO81d2lNjYRxP9aUe1xk9xN75eGLsdoIQLHNlzkLwIH81e8jkgZ?=
 =?us-ascii?Q?r2YFHhWJ3KgOkbh2+AAlVea0EYe43gpSl6kH56IkoGAes4mpKvGeOtvKtlHt?=
 =?us-ascii?Q?B0OKXYAhBj5gLZTySP5exPG1pj6taqVpPOlCr9gnS1R/XHsJdE55ko72XjPH?=
 =?us-ascii?Q?8I8MBkLgi4IJBuV8Zr2VGcUVU6CUBVZPlfVzjg63zvfl6o+gHTA/x8DL/5+Y?=
 =?us-ascii?Q?u1J3hpUCPVAStpAp772gvcTaxSTSkLgbm1WxBMB9jEM5ljUTrOIb9GAMlWIC?=
 =?us-ascii?Q?30bC7HoX5Xph83zg2uPlb90I/hLNoFBDhLx4lMxWlC7OKv17ZoCe7wXZAIKk?=
 =?us-ascii?Q?YaTmgo1bXqMXuv/JXxxbSqiICtOIXhKwqKwPLGveNszVJ+i3MLHo+OZK//y3?=
 =?us-ascii?Q?81d+d7gn3ip1kt5XKQ+6bJiGtv/mjk7JugD2E3ySINAmVvzDUHRMWv/VXuFd?=
 =?us-ascii?Q?tL5UenOLz2fBJY4iZqVxjmyRupMiIbBOl8Y0+kRBZC5wX8NWoWy55hqF2gnC?=
 =?us-ascii?Q?G4pljbqcbF1P9WiF/hZCwKGSXx91yIGmLk1/eClnrYPnUMp9uWvNfVxLj7KV?=
 =?us-ascii?Q?lfwnW+4EBGxjbJnpqxCjQvWlaVLdrC0PMjptoidxzbTrdE43d0Uk37tBVgs6?=
 =?us-ascii?Q?darTBCBt3cJCuIxkVhnW5salyG/hA5obhtJtltkSBT4fGhwMlmRhQ5RCuJHS?=
 =?us-ascii?Q?inAq3lUxZ4yUe6XnMwtfRI2oCgP6pQ0MkjJHdUF4OULGfdv4OFC6LVKdPzjA?=
 =?us-ascii?Q?u7bYiZcFIGA2bbVqKX085rdyM86+YDe+eOwutzn9DbNO1cSl1oSEciNsyqIx?=
 =?us-ascii?Q?auh72FZElVABSRPJZ9pUMeajxi+RuSO++tNGJml5CWPNyf7qeFmf+7VNdndJ?=
 =?us-ascii?Q?+6Z7w+2VKVeuDTsT+8MQBZjLugEwPLZAFe5h+beNMXdQX4CG51aSdyENrFIF?=
 =?us-ascii?Q?OZazC9nE/pyGbGCFoFNz0/9BqdSTgIu1zj1zByk575t2/aJviVhVrMEXXgxu?=
 =?us-ascii?Q?Krmk8IycysSv1xPqlNR7Kz3kJ1i1MriwKgAjibegMezhirkqk1fn4pngVnXp?=
 =?us-ascii?Q?QzfsqSdw/8WlFqhr/bYp138O4pMFByCHCFL8Eq5dtSw3GBovkR3M53iojtMj?=
 =?us-ascii?Q?OYmG5jjDiHCqnc3zVGgYsO8bb2ls/2hrtEcBBEMdLOTtHtkjo9fvEhyM8GzJ?=
 =?us-ascii?Q?hDCXhZHGJ88UpiXjkUMJKAz4c0Pg8Y+hjO+OCuO4oVso7zIHfGCnuasuUFqw?=
 =?us-ascii?Q?F6CNFUDk+29AIENc1wr9Psa4qmzebIAlfflvr26dHnvbjEZNt07tKLPv7joD?=
 =?us-ascii?Q?7lIwFnr9CPdqfkBuhuVhStn/QRw9X1g486bUxz19Vx5t+SPQWqXNNXT2JWzG?=
 =?us-ascii?Q?xNRBFfzoyVOAEmTDlZF4pO/qb5kDzjzptUwqzooHOvkrbBMObh2GjsW+v3CR?=
 =?us-ascii?Q?5imCKKSbIeKwe8sQ7QwekrLShiV1rYA8QTDFqUVyl2SFjP0Xw7NJtbxxqy0C?=
 =?us-ascii?Q?ais1LXhQFFDLLCKEew5FS9RkjV73CL11+qvUX4rBAdM2DY0ixN2r0zG7LCyQ?=
 =?us-ascii?Q?c9oviJmAfw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9906314-02fd-4b8f-2d73-08de5c7ad265
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 01:32:52.2012 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nxvTPaCHf3LPQ5quuNfZQE05lTj2NgNuNs9HjYb9Ityo4nj5p7ymfhXkhVYIh0ziLbZBN1q+gclOjH+TRIWfAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10540
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

On Sat, Jan 24, 2026 at 06:54:51AM +0100, Heiko Schocher wrote:
>From: Adrian Freihofer <adrian.freihofer@siemens.com>
>
>Rework the boot state machine to a significantly simpler and more
>robust implementation. The basic idea is to revert to the previous
>partition whenever an issue is detected during the boot process.
>
>- Broken SPL
>
>  If one of the two SPLs does not boot, the ROM code of the i.MX8 SoC
>  automatically starts the second SPL from the second boot partition.
>  For example, if the system's active partition is A but the SPL from
>  partition A is broken, the ROM code automatically uses the SPL/u-boot
>  from partition B.
>  Proceeding with this boot procedure would lead to booting the kernel/
>  rootfs from partition A, which could potentially successfully boot
>  the system and allow the user to apply the firmware update with the
>  broken SPL again. This would lead to a non-bootable system because
>  thesecond update would overwrite the last working bootloader.

Nit: the second

>  To prevent such situations, zigzag boots are detected and the system
>  reverts to the previous partition rather than booting the kernel/rootfs
>  from the currently active partition. Detecting zigzag boots is done
>  via the new fallback variable.
>
>  To make this state machine even more consistent, the partitionset_active
>  variable is no longer used to determine the active partition during
>  boot. Instead, the active partition is always read from the eMMC
>  partconf registers.
>  For backward compatibility, the partitionset_active variable is still
>  updated whenever a partition switch occurs. However, u-boot no longer
>  relies on this variable, as it could potentially be out of sync with
>  the actual partition state, leading to situations where the ROM code
>  of the i.MX8 SoC would be out of sync with u-boot.
>
>- Broken kernel, initramfs or rootfs
>
>  If the upgrade_available variable is set, u-boot counts the number of
>  consecutive boots via the bootcount variable. If the bootcount exceeds
>  the bootlimit variable, u-boot starts the altbootcmd instead of the
>  bootcmd. Previously, this logic was bypassed by assigning the regular
>  bootcmd to altbootcmd. Now, the altbootcmd is used to revert to the
>  previous partition when the bootlimit is exceeded.
>
>The netdev variable is changed to eth0 by default. This is what the FEC
>driver uses on Capricorn boards. For devices with switches and DSA
>subsystems in use, the netdev should be set accordingly by additional
>logic in the environment or u-boot code. This is not part of this commit.
>
>Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
>Signed-off-by: Heiko Schocher <hs@nabladev.com>


Acked-by: Peng Fan <peng.fan@nxp.com>
