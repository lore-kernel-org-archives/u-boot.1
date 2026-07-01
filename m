Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E5D4C43327
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 07:30:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA86B84A26;
	Wed,  1 Jul 2026 09:30:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="W1NzGZYz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9AB784A26; Wed,  1 Jul 2026 09:30:36 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDDA884A1D
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 09:30:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lboPxRpy4yahfl8slYYw5Ab0g8OVFZviQ5rkLg7X+moVwUOY3VLAUU45ltEPKcICD6sD4PQr2zKgeIwXfCL0uIb0WwwELUwlBcw3GDVqYhux7YQSruSehgEsIlsKlmfPlGleiUQjzt6ir/ZIKlDRm2iFGCzv3wQ1TxKEJb93qIubIczEiFCyuXJ6JQ2py4hWq77JZxgpDpmQScjDyVfLXKACKzG0nI0/L4XYHZmJB6v8KR+GyFaqviTpykJtrTxgBgFtVbytAQ6CcZasz17zw+aX5SSXZpxJDc1PD1ENccZ7MCwdR3tqaYHKsJ5fIOzx4JJT5tNd7KgLd8iSV4s7lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bI7f5GsFw4cymnmBPHrN5LD7jPNbVcKniwCWS6xK/MA=;
 b=CPQ110zeZ5MvBDqiAt3PVaSwU9eUShHTcRKrp/2OzJgaZh/GlhFs/n01ko0x0k7YglYQRCgC0O3iej5WNNvHfA7XrRRNHiVwEYdirqBjFbZL+0J0BeNypM6OH/WSykJzGBTw6fAfLPwjYSZurQ9JXzcARW9HJUBuZ6Hsd29hPLd7IGo6978UTbsT46W+FRDevuG81/t29xULGJRsgPQV9HkFXnK8POnrZiZD9XyRq1tFNbEWHIbXYfWBdDWG4YuPcPfH/IATCVm4UfG4vw0HHrFE5LP03GH4v0eMVk2XebAVwwDY0m17LHHkYv23C0apqgDjqR71lSgf1a2phruZpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bI7f5GsFw4cymnmBPHrN5LD7jPNbVcKniwCWS6xK/MA=;
 b=W1NzGZYz472zoCU/Tb518neYDY9ZR9dUX2INo5f6HOWsVSZhJgNzf78wm/pgUKVD+Dc+d+rqcKQsV/3iVCZxA2+0+WMAqFBvTWkJ6fbZh0MTpEBM40TKpDH3X5cwlk8impWbaaBJ2c7WVBUoiftjRPjxIDd6xAXEv3cxztf4Osu46cBxWRhtKYee4P+5N9Mzip1hlSKpfN9EAf73Lc9sPkLBw6Z3klCNZj76wak/v8zvLyNoEFbyqpwXAEeRv98+ltGJtNpV0p0tXxKE8DjyKqOCWiKO6pUodzYVAJHIYeftxCt25h97y4klXQm/nh74Fh13gzSsa0xJAgYCHR8Mtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by DU2PR04MB8869.eurprd04.prod.outlook.com (2603:10a6:10:2e0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 07:30:33 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Wed, 1 Jul 2026
 07:30:33 +0000
Date: Wed, 1 Jul 2026 15:33:57 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marex@nabladev.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Yannic Moog <y.moog@phytec.de>,
 Ye Li <ye.li@nxp.com>
Subject: Re: [PATCH] arm64: dts: imx8m: Reinstate TEE ifdeffery
Message-ID: <akTC5TQupHhkqev+@shlinux89>
References: <20260630160951.122230-1-marex@nabladev.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630160951.122230-1-marex@nabladev.com>
X-ClientProxiedBy: MA5P287CA0114.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b5::11) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|DU2PR04MB8869:EE_
X-MS-Office365-Filtering-Correlation-Id: e29cd9b5-5269-4ed6-9663-08ded742a2bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|19092799006|11063799006|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: nW/TZ/e2bNzprYqxc3BJCUeMIKBkwaBM2qnVaA7IqQAsMfaD1prkoqBwjkA6M5L1LJ8b+qURuFMkWzeRCxUgMK9Tr1b0iZocxP9MGUmDW3sKnKTKSMt0ew43dxGqD9sJ/oImmQQVwasYUplFQRvc6pRdfakFkrA5RnWDsZAkxmJmgncWwCzvWq+Cs4R70Cl46xhg8q7+rNJDhKkmNkLMy/F3Sf6ojSYiHGsFBFLeV8OJKNTg/34OZRN+JiYU/5PX3/soNbgKwNOXhowfYFE9yvYBtvl9aK1T2vvpzyFmq1p2gGA18CR8bPimBeMjiwzGg012z2FFnUd6//VckCB/QTfjgzEqOzJeMD0nf7Pb7fShp9IfOf1rfFLbDojDz/l8X7wMAQXFPfyky/QX8eptrUdn+I+Cl+Q/qUCMNouvwkYqCWHqoCxBm/UexkUDxvND4MOzw+ynpl9SplVQnmtUu2SxO3is0lPKh0sscqqOQjJd9bE2LWhqA5CCSOel/BvYsZHyDQwE9MGunafn+hNJc5ajUg8Uutq1mEQ+XDxO/PHDgt8z7W2t9CWZZ1OnKRydxUqqb6BDka85pNm3wq3tF9NmvHQHSYAA6pURInFtQg+1/umK86SnLl2XTmGIIGSslV+GYTgUrl8he7j5KQlJJlI5ab6CtkIHOmYcH1ZFCFY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(19092799006)(11063799006)(6133799003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?djPf1GdCl/Y/Gy6wI46triztFd/G77RYfwVWDe9NefobcjiGEzKHReqt75Jw?=
 =?us-ascii?Q?9ZgZaYoWaU7RVnnAxT2t1cFUJoZk4Ha0T4ex2+13lzwK5UthW815tSX8X2T7?=
 =?us-ascii?Q?LFm1Eq1yjFm+XC49pUJzecw2Au9k4St7T+lBcb7U2qL7NkCJl/ILPYhQgTbZ?=
 =?us-ascii?Q?sNB2LQcbv44fW2+HWLFGPSFMbSsU3F/uNlH6mlOJv7RVNs8JEvMqDzL9y11/?=
 =?us-ascii?Q?cxHnGONGLNA+Tc8Tb43pSmWcv1hK5ABm3U+VvdxDu+8EfvLjP1CKauEKizh0?=
 =?us-ascii?Q?pg12IvmxE0UUdNI1zHZ/iJeZKzn0Q5aq14dzzsXqLSfS8TfvEMfzJsKHpm1G?=
 =?us-ascii?Q?/mVDzy7Xr1xsEjRT4ytF5T6bhJZdyF7bfoGEq3qES1355YGANlgOmZs042N1?=
 =?us-ascii?Q?kgX1cW4Vb3OzWQoAvN0DFDqfFTt4CVsuhD4J31PHDRIGyXGHTnoBhxUsbHOl?=
 =?us-ascii?Q?LX8SUJG9O0tOANPXkgokmlzoWrk5Veg3dRb9YRDt861iChEslFRablsiX2uR?=
 =?us-ascii?Q?Jj598tcEytvdf5vLU3echj3+XqbKygedSUt6hMCLJoPl2lVrF1f/k1lbLQBs?=
 =?us-ascii?Q?ar8Qd8LwCmamOIWwMQECrEMRuL+n/wqfmkA+Fu2xRnBjrQq4eVYLURHCXvCc?=
 =?us-ascii?Q?cvEOiOfd3M/CBSnOpUcheSrdwGLikthYrxWtWWa0jDyxlDv4BO5+LktnmAXN?=
 =?us-ascii?Q?0GYD7MEL2upDGGwDoaDsS+iaxOOpJm3UpKBCgLFbgix+EmpQcW+TRnJxsEVm?=
 =?us-ascii?Q?VhgcLXRr1IeGz9vxKEFsKuzuM2BeP8Gi2q9fPjp+rtdfSYb6gnJX5W6x7lpZ?=
 =?us-ascii?Q?080jkPkvH44QI1q+Lipz2HhNgcP7LHKkTbAiyjRDhcoJqroOOzp3aZeCEiL2?=
 =?us-ascii?Q?jmVKR4Lr7wAty/kGsgmLQLRWJrhIGXt78+jpDuIaDyUyH4SW8BzyLKgkts3Y?=
 =?us-ascii?Q?39KGpKFCzgQaULp/3oKh6jJvLvpMi7uoIVT2PmiHixvtgiMcZLl4zrLiDrpp?=
 =?us-ascii?Q?bD+uIyswNQadROGch+qkeNnMpFOFtmD4ysSGf+8EQfnszwzwVAB9cfRq501w?=
 =?us-ascii?Q?8Yh8wYFYg9YB8wJEUkVQQUjMgDQ5Coe7LPP6QX2LTUTQelAfZkf9bIZBr98P?=
 =?us-ascii?Q?MR75YQ1vwL4zv2Y/IoUCy1nq/L+SVWFQDU77iB4VE7zZKNhs918v2D0zWiep?=
 =?us-ascii?Q?o4rEWKtrvQQeNitOLEzQ4S/jChElGW8ido8QcrmW2rYXVb4rnahi5X3vyTES?=
 =?us-ascii?Q?NyiuSitQoBC8c8/JsE7CsCWVbK840/+G8AsQYeyT2mWHZ4cKiiXg3EKVCKhV?=
 =?us-ascii?Q?FIpzPD9KBZs2+q716dj/yZrCKPd4q8DPU41BZSk8RlAA6T6bFNsQTlnILely?=
 =?us-ascii?Q?DeralNrkRzc5oNnTEt/YcnCWeNOovye6UCtDNZcVx7sRlrj76Xln5ESPV2mB?=
 =?us-ascii?Q?VGJRWMT932W3+dYL5/UoE8t2KEiZsA9ub3qY+/PmlBZY0l5A+OqTr0WKvd2P?=
 =?us-ascii?Q?htQWMfx64sGQl9kHUXmuGv4IBdTvjvJ3KrFO1L/fj1hDVDDJJnH7366Y3mmw?=
 =?us-ascii?Q?PiSHUOI5HgpluUbNd5bQMHIWVqOO8uVG1Ky6+gIfNSDFJLJtJ+7lpb8mYAB6?=
 =?us-ascii?Q?drPDjMpT6G1nzR3FuSdyFvoSizFLFbea0jHfe74z8NPZp0TG+RJpc2fN2QRf?=
 =?us-ascii?Q?NwbFnKrV7VZ3A/C8kK1IjlMiWrhNhYQ9k34PZdZHJFZ78Mbqx9mmAKBG6i5u?=
 =?us-ascii?Q?P1o+uOIpJPTV2rxyANDOIbP9uYR8TIkDYX/uVkGt5dnOlxCVr25K?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e29cd9b5-5269-4ed6-9663-08ded742a2bd
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 07:30:33.2954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TuFWqBe5P5fvmhBxP/6LrMYCgRfvcAS8d5O0r23E5RlfbDx4irDzjVUTogdG2fkve1t0DIQ4SJe44pemvopBmOmh/YDac1hl64WuFXU6Re+uxjvLodA/2bg2Q/3KAfQy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8869
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

On Tue, Jun 30, 2026 at 06:08:56PM +0200, Marek Vasut wrote:
>Since b57ed147939c ("dts: imx8m{m,n,p,q}: Make optee packaging optional")
>the TEE node is always present in U-Boot proper fitImage, even if the
>CONFIG_OPTEE is disabled because the u-boot.itb should not contain any
>tee.bin. This is wasteful, and produces the following warning which is
>also confusing to users:
>
>"
>Image 'image' is missing optional external blobs but is still functional: tee-os
>
>/binman/section/fit/images/tee/tee-os (tee.bin):
>   See the documentation for your board. You may need to build Open Portable
>   Trusted Execution Environment (OP-TEE) and build with TEE=/path/to/tee.bin
>"
>
>Reinstate the CONFIG_OPTEE ifdeffery to mitigate the problem, but retain the
>binman "optional" keyword at tee.bin .
>
>Before:
>"
>$ mkimage -l u-boot.itb
>FIT description: Configuration to load ATF before U-Boot
>Created:         Tue Jun 30 17:23:54 2026
> Image 0 (uboot)
>...
> Image 2 (tee) <------------------------------ bogus empty image entry
>  Description:  OP-TEE                                 |
>  Created:      Tue Jun 30 17:23:54 2026               |
>  Type:         Trusted Execution Environment Image    |
>  Compression:  uncompressed                           |
>  Data Size:    0 Bytes = 0.00 KiB = 0.00 MiB <--------'
> Image 3 (fdt-1)
>...
>"
>
>After:
>"
>$ mkimage -l u-boot.itb
>FIT description: Configuration to load ATF before U-Boot
>Created:         Tue Jun 30 17:58:15 2026
> Image 0 (uboot)
>...
> Image 1 (atf)
>...
> Image 2 (fdt-1)
>...
>"
>
>Fixes: b57ed147939c ("dts: imx8m{m,n,p,q}: Make optee packaging optional")
>Signed-off-by: Marek Vasut <marex@nabladev.com>


Reviewed-by: Peng Fan <peng.fan@nxp.com>
