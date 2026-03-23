Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0513BEC01CB
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 11:41:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 729CB84113;
	Mon, 23 Mar 2026 12:41:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="gzYJiLEC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7282F84114; Mon, 23 Mar 2026 12:41:54 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B50384099
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 12:41:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fpk77zlCKXMy4uGei7EnYFbN6oKnNVTgnwem2c7ZRQIIrcXtDbaiFY0jnEBmbUIw4KyTfOtwZQtwlRZKIidKbQ4I57o35SgHILnqy4YBx0tmXY4hXTDjV8tmHAaDiO0Yd8e+sLPexH0pI+zhs10hzVaQTuJOV0VCCok9H4Mn29p5xKg8BS6obhE8RbHr1TLHaZ3YXth+7kxaL6C8wWxk1csORmC5hAkVPevfRlyosaCtrpL/b58OaqwXM+w0WwL3Vybi+RAi2v5KXzVHJipkawznLt4bOjlYhzf6wXe0a5X7i3wU0KIyCnb9ZNeAV4jVzvlRhwfxu6qNcJUJvboRBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+O4enJCdjkyltzclYYfqT2+RI3PtoFn8ObIKQb7T7ts=;
 b=T8/CaYTEsYjpqRIKe3lpB9BW6rzhQQPoAYAU67SdNJNliv8amfE6wUv6fFhHfGBhI5gHWh16zWq4j7Y0hsGJAFEPln/7oR3Fg2hor5rxvEeFmMWDU80I2jjhtQTaHZcJVYH7wXHxmSWTsEKM/6S0BrhVuxSrCYn1sT778c285tCKnbqJ9KMLy4K3QmGqRP+3d30YczihJ+fgpmo4Giv6wa8EgmvHhGM5Vp97TycLejBw3C0lm6vv341iojrN8zkkbk/jIqFjm/R8stb3IUVIcf9qvGgObxeb6jli3bJyVUiMKMOTMjutyi2mGh0OPW+PvDK8JUmDsohZsDOPmyPefw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+O4enJCdjkyltzclYYfqT2+RI3PtoFn8ObIKQb7T7ts=;
 b=gzYJiLECwPNuZeOVJtX5kEHFeg5uiL/5JO4+MyGUuLG9YhInDX3yx60rkYM/lqyXVFWwGZrAe5gvPuuYbhguhJFh+W34YTQivJa8RjIWtj2r42+iEgBYVNx8Chbv51Igz6Iwg+wMGfZtfAgytOvy/j0kbOvJPRzlldumaNDnPV1pxFb8qsZ4SzYjnS8cRpnrkPt1lDWDDNAr3LB5U0rM0GTWTg7rh81iOKbAVvBJZSpD2KrC4SCV/BgCPRtUhroOq+2qTO6xNCaSDUtQF+aDwp+YcF4d4+MK+Nh3BuUzH6TcWVtPR/HyAUDwxSvzVN2CSMcENbQK3Q0babjn7uRAGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by GVXPR04MB10993.eurprd04.prod.outlook.com (2603:10a6:150:226::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 11:41:27 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::21f6:947a:1f40:18af]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::21f6:947a:1f40:18af%4]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 11:41:35 +0000
Date: Mon, 23 Mar 2026 20:57:31 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull fsl-qoriq-for-2026.04-rc5
Message-ID: <acE1KOZN1HkALulE@nxa18884-linux.ap.freescale.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0171.apcprd04.prod.outlook.com (2603:1096:4::33)
 To DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|GVXPR04MB10993:EE_
X-MS-Office365-Filtering-Correlation-Id: ff619bd2-dce4-4867-2ee2-08de88d122b5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|19092799006|1800799024|366016|56012099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: BrvkIdC/WEDFZN/QrfCZo3Cff/rdQxXFZDQF5UFEClsE+eJ7mBBoUgCw4AK7Vi9Gqb4AExp2NWfcDnBixHq8FTw4SDj+kzUP/4pdFadLlk9RBJhR8rd4B62H581/MRL9ptSe/ANuQ/gekp6FTkbxmW0hEzRv5HEkUuDzIBp+B2v7hxEfRyFxgl3R6n5COCSYLQPMc4bU37QsdrTXb2b6h7n2WYR0SkYvWMJ5GZLLYxBG1YT0SZU3JjmN7NHxz6+vhDruX/zhnJ3i9n7hn1DDQ766PPsgxpTsvDEYr/s2p8W0dciIgOzvpqdcFnXUx/RKDu7NoAoARYd4Gy51trdulwNz4CeKErDSmUe31rLh9Vz+igbm7eGIotnENoH2behqRgu4t8Xz17YVlvkPPvznJ4lSTyxO9uNjCSDhmuBmrCx3RVlje2sQDoCWDDD8FSd6j/kztQ5Nxn5b/EcXxgGyN82sFq1WX/bzYskZUACudZzn+0SBswuavWvCUDqP1J8/24bTi5AKRxpVUGv6jYWaWbMeedtRzfYqioTmtpAsthUPvGA5M53Ac6fGmhPeTc/p8l4Qsl8/BH46JRWqFNn5m3jVhixckrpTEm2K6SZHKURg34Hq1amzTGUdL+5I5OPJ891vS6FT95KDMKQQeYpP1uJEmIuspOR984RDWaCHK9ZZoAZir87mXWp4pIMdFsjdsksQ5YetDSSgCGMH4c7fgL+TdSxWuqGDB+O+g1MTXJxex4MMwyQhGFU2IXHIJC1x
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(19092799006)(1800799024)(366016)(56012099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WNJ5F7YW8MzStwHybDbLxxsrIg2Wj0Eska0No9AtH7TVn1YPBkbUdVz0W6tv?=
 =?us-ascii?Q?sb9cq4C1M9rPvPlr8Oon5PFJ03dI23l2M7z3Y4Rbw0NLV21fPpJRjOcdmlxV?=
 =?us-ascii?Q?p2t29AACeCKLyG/qk/li5yQ0CA8o+BN7/lRMskYkogOhb+jwSE1trTsxpgE9?=
 =?us-ascii?Q?6rZzwE7wPi2H7dsY62U/t+iLbG3Wm5ItVbdNn373IqLczoxqMeeO5seSz+YE?=
 =?us-ascii?Q?16FA73BN9mqkuQMFFMatjleLWFz4q0VU5r1kNlTKGwMWJJGr3Ri+hzuiQ+el?=
 =?us-ascii?Q?iOlK2b1LDyV3GzZwPjESYHk+WAFmrRNnvUcOz8dEFWAStY9JeZ/mach7GgSu?=
 =?us-ascii?Q?YOoW//L97vWez9HfgaaQ9jVDXz06ClHgQC7GjO6FnQV57lkoroicUsMKEVRB?=
 =?us-ascii?Q?x3CUDvrJdRXmoTSQ9vosFiYM9lSqaunwS/wwmTNf0JuYjqYtMB/cpW29cjVk?=
 =?us-ascii?Q?M0PjIG0tGIt5FeKtQm+m0+UvDVW3ayPCHdRaoQH4aKjJC3PcLn4+ZRhfsWTc?=
 =?us-ascii?Q?cufjWi55VGgI+tcgBSHweSSzUBj4oQP6ixGLQQkQGtEsOreBWJQXDU4h5oeg?=
 =?us-ascii?Q?V9KLvCWCmDkYU12kUQ/O5rhSev/H/rwYaxbCn4B1nlYKv8dFhH+g0tpbJrSx?=
 =?us-ascii?Q?H+Ztw/aphw+bSN05aErxILFGv7vlvHWUOo0K1apMrcg/TcilMSlh5WbaBVvf?=
 =?us-ascii?Q?wBIpzibBurUZaFyulq21vaE6JwOTpnSAlF7kTilzeIfpFFCJueZ/h2VR+9sn?=
 =?us-ascii?Q?OXldbIgGKmrQebfd+oTvQzczQaaM2D094rCJEHu9I/EoCO+9Po7TwrAGBTyR?=
 =?us-ascii?Q?YOkF5m1Evvk0aDadAaUfYL+lkkV6yGTbCkjPukQ0OxvJ2MV2GHWpdegF1u/4?=
 =?us-ascii?Q?+MN1E5Sslg8xKRj9mIjOm7OZkjsXshx0QSFkbqppAYXKJvVx+TeXVyBE1TlB?=
 =?us-ascii?Q?SG+54SU8znI7bxeJ/urRfe1XXY71RnyxRv/jKlECmqNzRxB6pQd8vZzvt6S4?=
 =?us-ascii?Q?INp7lB/77gRXWw4WIVFv2vG25UCTtRLKgAZnil3ceOj8dmj1/JmSEBEmBmbm?=
 =?us-ascii?Q?g20n54PSHTOAisAL7VN5enAnAINSj/xiXZY4OAAGL6UECLax1qI9vpsWUaET?=
 =?us-ascii?Q?qYVcJl0WRF3ireNTdrPmcKRmaMX0Rc1jseBPd8fOjZv2mor10FG3LAiJnkvr?=
 =?us-ascii?Q?jl7aPTN93adnv1PDpWwD+Z0eDEU7/K0QrpkutVszysmlBHOc9r1YJk+PqTma?=
 =?us-ascii?Q?dNGO8VuCSOPPkzbf5m9DeKDk2/u+DGzb25YPsIRLn/4pTc2lOl0ZI2vihYDz?=
 =?us-ascii?Q?gEoykE4leZMkGR+DM8sqiDrvtYURLlPwk8qYTVDQs3ysrwXBmiNCwQjOeK25?=
 =?us-ascii?Q?wlPnM5mYrqwJFwK7iXqjCyZQ/XBqhbL2ay0I9wAZf5Wo5sXF7mDXoq5FsjyP?=
 =?us-ascii?Q?WQ1Yp3rP55VCmoyVLqK8jnxMvFiMApoSjoM37CT2NxmbdmdjYUAzIkbuHmIR?=
 =?us-ascii?Q?bkMAtUClecQRVifBro1tUPHLQk3z5t04XYVZjMlhj8VFy0oXyRH8qypHmoHM?=
 =?us-ascii?Q?WM/Aw6c/cO42/gzZniYYS68stbw1tc4PoSTDF6xdiI6xU3vJObZpVGIHovSL?=
 =?us-ascii?Q?gRbSFcbpoqXAoMmq2QzOzjznQVEpdfk4Gy6CG/beyp3OPJ+vjap69BoR9pYs?=
 =?us-ascii?Q?DsBbYWiHPZK2tWWcmOw4K+whrKZda1E+P+BbKvaaoblKmqkNoJ1K6BwbYXXi?=
 =?us-ascii?Q?6+Ulh0cCEQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff619bd2-dce4-4867-2ee2-08de88d122b5
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 11:41:35.4913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sNxANDjLdVN+3GwR9J/zrXXqgQSmEkfOR+pl59SQ9A+F5wjIQug7+GRazFXnsbH8IRwNbWqHeQRb/iCwAmEWAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10993
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

Hi Tom,

Please pull fsl-qoriq-for-2026.04-rc5 for 2026.04

-------------------------------
Fix SPI flash clock for ls102xa
-------------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq/-/pipelines/29615

Thanks,
Peng

The following changes since commit 33756fd4a8157d1d921a703c4fa172f6d2eadbd2:

  Merge tag 'mediatek-for-master-2026-03-17' of https://source.denx.de/u-boot/custodians/u-boot-mediatek (2026-03-18 11:07:18 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq.git tags/fsl-qoriq-for-2026.04-rc5

for you to fetch changes up to 1f305f99d2001e96daa7e93da4da2bf56da9278e:

  armv7: ls102xa: fix SPI flash clock (2026-03-23 14:27:24 +0800)

----------------------------------------------------------------
Michael Walle (3):
      arm: dts: ls1021a-tsn: add default serial output
      configs: ls1021atsn: enable serial driver
      armv7: ls102xa: fix SPI flash clock

 arch/arm/dts/ls1021a-tsn.dts                      | 4 ++++
 arch/arm/include/asm/arch-ls102xa/immap_ls102xa.h | 2 +-
 configs/ls1021atsn_qspi_defconfig                 | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)
