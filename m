Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A854CD4F24
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 11:10:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BE35845E3;
	Wed, 13 May 2026 13:10:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AR27ihbs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FC37836AC; Wed, 13 May 2026 13:10:29 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4630483FB0
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 13:10:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DQU+v00BwoSIWgmThap6LSSbyksfXQu2hyBW5Vk1qfo/X7CDPAtHfWLPHzbWk4SE3Isb7Y1QZMqMctPuLPBRHSfwbNxRRKC+/hIvXreZkgBN3V7i8p3QMwWOLF48Qy6ThRozIIJdqE3t3I9nLH5PL+IgIfwvb4NtZofr97mACaNf7vgE24ji0L6kSNGyNWSHnOus8mH/LxNh0+kyrZZynJenEP0l3Kc2ApBnVxDTK9qh0CwpauySQdn23Tuw/4TPtKV1kZUQ469f2V1mKbLv2pk4ilsLR2ItyiFW2kgEbMEeVz0nCvy5hizsCZMw+iL8yVhIOSrvZht+8nVtcb7yuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hDlNp1H5/UB3Lmhmn8BviRCWmbC2AVzMYChHy0UQsA=;
 b=WxqumTTkwjL7/gkPCX8DPV5FgbqHk+D9KuSxwftvIqOXmy/weNAg7+XAZD1lgzik5DwFYdNGXdRXkSPc104wrZeKZCrMv3rSLUO8QyEiqGnTazki1rz7knBvNJndENbiOo2Fg38a2BoMzoqTiHY7L0OmX9fonhql3GtGDiZkYf2ZIEeWNococ4z3leNxR/Jw4fGcTN5sG7TSq09yZct7gyuNiMUvFREhpf2l5ox/a+iynBVi0Gv1NKU3qfuPj6Fp/CNhZxIyOadtcnKBiyiR1lYrSPBIKkQtyVcM8hxMhbRzJljHgp9BmGMeeAX7pPpx/yHe4drWAFhWDMMhxe48Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hDlNp1H5/UB3Lmhmn8BviRCWmbC2AVzMYChHy0UQsA=;
 b=AR27ihbs/s1jPVnjb0AHlC0CkHphi+58HMTYYE+gOvgknOUCAEryxvrgP73Mm24wNj/BIil7dqWjbrOxj0MLc5qixq0t6230tUdK0XeObDXOulsFeGjCCxO1Gz735SndSBJiJaflNJraeGvU2jHK8csAzFSULgTFcg4MSe/BYj5gaT0uCP8HJkQfizwoizav9No6SpBdhi5yQPMxvURvlSygLZKZ/dyIuPnFJBmfX/28lnUO/jbvaPXvUbJ2xHL9ZPAHmRabMySuef8k8meRxDalsZYlIVxN96il2II1najK/ilSxyvKJGU8hq4tI+x1WHLflI4ZmgJT72EY+8xdKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by VI0PR04MB12135.eurprd04.prod.outlook.com (2603:10a6:800:324::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 11:10:22 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 11:10:22 +0000
Date: Wed, 13 May 2026 19:13:11 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Antoine Gouby <antoine.gouby@gmail.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>,
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Antoine Gouby <antoine.gouby@toradex.com>
Subject: Re: [PATCH 0/2] board: toradex: imx95: remove gpio1 reg
Message-ID: <agRcx1GtLEwuNHJp@shlinux89>
References: <20260506-v1-remove-gpio1-reg-v1-0-d5e09f936d90@toradex.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506-v1-remove-gpio1-reg-v1-0-d5e09f936d90@toradex.com>
X-ClientProxiedBy: SI2PR06CA0012.apcprd06.prod.outlook.com
 (2603:1096:4:186::13) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|VI0PR04MB12135:EE_
X-MS-Office365-Filtering-Correlation-Id: b4a75036-be4c-4476-7ef3-08deb0e03a09
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|52116014|376014|38350700014|11063799003|56012099003|3023799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: L4rhHarK5TQ4bSLgObg85P5OQwVKCXYkGyyyUMErOcw+0RwRKMegrLZ07dYOPyflLLwJJMZ2ZfKlbSmEWkY0Hn+X9DD22cONt+96IIsadzmgTM4iy+YuCRJFsQVVtS0EnogvFSLQ++YY1u9QWfuPtfYOOkCDkINzU6Oe/fJS/rtYCJOwk2ijf4y9yddiPm/M8f3kaIrCh1q3R+4q9WQot3haLSo/BiNdYsSdzTFOz869/9kpmscnCmr11NJpDGxI/0dgv3L6r7P1Ugvm4CadDiXMRvVfBuZBpSL483EGqkuA/fKRNB36YXQufkNhWX3xu4E5xySEQOKdYbX/V8a2si/p+44kP9PrZW9QaRaQfCOriC8SZzlNVUhyuVcAkkft36IOJxsnn6wkeV+1j8VqXIgS8gP3Qi5dD9rZLnsnYIvQ/gV98toIuHLAphvr5eBAtvhlLLWPOvgF+v2CcMJ76euTEVQ6rA4TQ91AZWLHfD99wtzpaigf24RTqqJ9ioodgNNuharcM+gI+CXsGvWKebifACo79rNauQ19wPvtXNd1SxE0NQCZWxVNAHbtj46PCijna8bMpMY2CRk+yDDLyGc7hG7jOXS/gj5jeyX6BOUrFfYekH7qHpi1aufPS+EWHfBYYhQHkk3IxXWcqBZ91oj55XeMky3KFFl7H7mU5dquXe8cgQOiKmYusTalti9oCZ6g8CBTzDueuYmMpy2Yob0J1uw1+ykw6yRsm497gZHY1hYbx5jEDF5a4CVDwmRR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(38350700014)(11063799003)(56012099003)(3023799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ArBIS3mOF/KsCY93aboIeriD80ESe3DBIEVIp94Up6Pg3IoBBygttBfSvuGA?=
 =?us-ascii?Q?WhDvD94vKx9CNOZ0Szgj6oAZcKtzuKvSevpl3G5OjVY+EYkRykVmIkkrjoQ3?=
 =?us-ascii?Q?eRW6EIIlBbBFOpKI2Fd/G1sz38dlI9T5chI8SpopCWc5NoWCYNdo4/sG4Q2v?=
 =?us-ascii?Q?NSzjQSvfbwp73mtiqKrZT6SiNMNS+dzz4+Oe9ei9jH4SgtbVFziTeBV5rGeR?=
 =?us-ascii?Q?W92qn2x0DyniQNnO/OwVjMVpA8aZVVTZ+VIqOcOcRVm/jriM++69Ud37Ny8P?=
 =?us-ascii?Q?4klvy8CgoyaKZGmRXr7ib+7mox6Svib408UYQX9TwskRiy68kG5yk5DPHd90?=
 =?us-ascii?Q?ZLwqAFf+qfwsWqksQt85ZH3dQhyxeSsm0Ak77lNhaU4Ff8Fg1l5S1FKSIW9/?=
 =?us-ascii?Q?JG8zgDLAoT9ImYouxymlltIrHuFnx8rDmKrslqpOlAgnI0oHlFSIGHmXuWu3?=
 =?us-ascii?Q?1oPXeWPsy8owAJCQVLH2OASc7UYBUDoaCQlyRsxwlaG8ysDSisTWQrNNXXg2?=
 =?us-ascii?Q?uDIGFLtqJPvI2hgI0daYkfqjfQJGtAF3dgHd0DeagFUjxWcYZn/zV2VBpBVD?=
 =?us-ascii?Q?As9FcqSkpBMLA1/rWYXTizP/YbdFSrjd8esbdC1bZr5r/9QLmZ2vb0gJT8Y0?=
 =?us-ascii?Q?/x6A41gw8jCo15p3zO3I/g1CmnYh6FWw/82QGMUmU+J2VzvCBlTwIHi7yfdZ?=
 =?us-ascii?Q?Oe9zvbNgVr5grQlVRkbP4jiFS0fF9aK6ypQcSK/MXn8N7FLGIhF2ckIBoBx7?=
 =?us-ascii?Q?/ltpAWUxFPmQSRcJkkdkx4CY8ggPw1kArneNavJxgHVJ4SZa++cbCKAszAJy?=
 =?us-ascii?Q?L4cilt31EdJloeWEpV/9FbVGaW56KLK0Ecg3EU90UOfMmAQOvTQtPlAgRi+5?=
 =?us-ascii?Q?JArhzVqM0+fkzyzvU+GcMNt0q6UosPhHU38yLsrpC8eaM5mh334NnCX2QlJs?=
 =?us-ascii?Q?98ZMyn/ouKEtUholASIb2Cp6RyFYvjLY6G8PMdwSi7BQ2iRC0cnzWohsZaEc?=
 =?us-ascii?Q?8seKAqHPCFeJgQ6b7rHWmSqrJ5QDftkEI9mtIy/cA1DCSNUNaveQzcvXGCUn?=
 =?us-ascii?Q?LMJP7gt1Z5+h2+uXaWfYYZiJfDOaItha33FZ4fwIInzeEUYs9Cg91g/kA0Kz?=
 =?us-ascii?Q?XgAO1KaRKs3GaehxIKy2hlsjIEMgLTWC550g8zSEQ2DIYjs14ARRcsHLqHuy?=
 =?us-ascii?Q?PBRr+Up7yicV/5rAT7bJBye1rathE5IbA/arV2gFKTHRgyk7qlji3vBaXYrv?=
 =?us-ascii?Q?ruggC1fY8hcH2bGr4+rRcB/GYC3o1hcXo7XMLdrJuOM/DrI8qQtmWt5iQRc3?=
 =?us-ascii?Q?JNJcNkBmRKxJvKfvbBBBuiK7K1+KFgIOahUq8N6JgGDkYqO3uNpxHZafxNaF?=
 =?us-ascii?Q?s1/oefEjwlG5WFjqfUbnPQm4UMoNOmK4AoX05ljzIfA8hW5nDTwCnAba7yTl?=
 =?us-ascii?Q?0U/pyUeFIx33xvejF4naIo3Fc/MG1SwFnEd2pl2Jl0VZBFJnXYBQTHZQn3S+?=
 =?us-ascii?Q?rwzMN7A4U0/gk+D19fuF56EUOKh6VfPnMxJVJ6wWE8iM1U5/gn2sr5IDP8O9?=
 =?us-ascii?Q?PhQd2RoTppUhzJEdTLjPFixhMH0isdFeooaMGe/nF0natc67mt07h7KHdf/2?=
 =?us-ascii?Q?RU+8/7q/bXBL5fJvtXp1FG2PJoKrK8IsqBulrtLU2QE/dIGMcPQhI605JICi?=
 =?us-ascii?Q?TvY+RSaXJ5XUbBL9pjtoTKRHrvn8vHQcPPSvf8LEc9+shXN38u0dtqG8cwPQ?=
 =?us-ascii?Q?d2P4hTwmWQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a75036-be4c-4476-7ef3-08deb0e03a09
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 11:10:22.7326 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fsnJ/ZcBYPf4o2oC7rB4SPN08W88P51ka2AhMnsMDJYraVMKyt/MWDirO17pfCeeIFEd+/hPunJkQUVxImIsJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12135
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

On Wed, May 06, 2026 at 01:42:19PM +0200, Antoine Gouby wrote:
>This series removes gpio1 reg from Toradex SMARC iMX95 and Verdin iMX95
>device trees.
>
>The RGPIO2P driver contains legacy handling for compatible combinations
>that expose two reg ranges (dual base) for i.MX8ULP and i.MX93.
>
>The i.MX95 GPIO controller exposes a single register range, so the 
>dual-base handling is unnecessary.
>
>On Verdin iMX95, the second address of the gpio1 reg node was incorrect.
>When used, it needs to be offsetted by 0x40 to start at the Port Data
>Output register.
>
>Signed-off-by: Antoine Gouby <antoine.gouby@toradex.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
