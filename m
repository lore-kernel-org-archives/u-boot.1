Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 727C7CAC599
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 09:47:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7045F832AD;
	Tue, 16 Sep 2025 11:46:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="tilxOAYM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69AAD8318E; Tue, 16 Sep 2025 11:46:16 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1771832AD
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 11:46:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ejxFOzkzGuNMGj3ezZ05LCZjFrMTsWYK2bRpzMhLQ9lerxIJEhfvX+Bk03XmXSKs/YeNxNTrtwpC1dFDF8EPw5DUn7JdOeVG26ufYZUD89YUiQffUPGSpnB+tKo6GynhEigz9LMF+GBr9ins/9ZLOnOhAuWbCLQgc6y5UDtKexgJb43VCgn9Im3W2bkmIkgaHqqKyKvjkPufgycdGdhI8ietemobeWr0b9mXfsVdG6mupto6a1GbqeUrWD1v0MDaJc1C05GBQy1lOBiFnQ7JusrI847bOkLfpKRSbuErrYN+aNYRroSr6oTJVWON4q0xB+ziDRHEN1bMVXJPV9cWFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJTjEvuy9gmMwY69J/ceef5WGIiZ+FbKEiaYUw3ypQw=;
 b=t0DiJ8m64jt5vzOWMxBABt8B6T4Hb4xt5puVuHifY9BQOMC+JvQyoJ47poHlAqSm5Rss4lfpSn6+jgN6NGU7JQXEnKhjYXAQ4SgY+siWJ7jLbyMtvPGYvOR17gH9FFo+WbDZNaWbqiX8xXjGNGtiwPVsKcoBl72o6mQxa8yNeZUh3JEJW/XEnzsxHIvr5f/bEpUkX3nnvhFDXtGxZ4b6EhLqHD1NsGHmCQu3yexkhGqXcol64pp1yCsJUvh/hJoxih8C2WvVvr4X/pu+szd65E9VgwHSqNVHNCybkAmeZszMjD9jfXa+m7qfjhoie9jqbifTyhOFv8l7IRpC8ln4Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJTjEvuy9gmMwY69J/ceef5WGIiZ+FbKEiaYUw3ypQw=;
 b=tilxOAYMqXzwtshSE3mwue7yldAL8Kb8qaB6tssNJuRClX9PLWBLwA/JDktVrVQ47mqlQ2K0MgEzScO0WrCJ0hx6CHQKqiHHWHkB+kA1/W4Z1m2YJVUClUcSs27jCY6+dowF2sFEt+/w/iQMSTzC2SV+CK2LmwZ3d4aI9NYv5qMumapx7yaoNM9e77vv/Owpv4Hsl1R6LDPIWyRxoa/IDEg97xqvzmtfMW9IYP88raCjFgzgzZ3kfZu07qsqLY+lgyEnpJX4i0w0MT+Je+GyzPdEBJJ0nfP2ffWpcHcSeAsEVp2YIYtgyemrDgj4I5Eu7BToAZJxBZWeUlfxXABy/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA4PR04MB9391.eurprd04.prod.outlook.com (2603:10a6:102:2aa::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.12; Tue, 16 Sep
 2025 09:46:03 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 09:46:03 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: sbabic@nabladev.com, festevam@gmail.com, uboot-imx@nxp.com,
 trini@konsulko.com, alice.guo@nxp.com
Cc: u-boot@lists.denx.de, ye.li@nxp.com, peng.fan@nxp.com, ping.bai@nxp.com
Subject: [v2 12/12] imx94_evk: Add i.MX943 EVK board support
Date: Sun,  7 Sep 2025 04:37:42 +0800
Message-ID: <20250906203743.3352805-13-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250906203743.3352805-1-alice.guo@oss.nxp.com>
References: <20250906203743.3352805-1-alice.guo@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0162.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::18) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PA4PR04MB9391:EE_
X-MS-Office365-Filtering-Correlation-Id: f6917c52-8824-48f0-c662-08ddf505d99d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|52116014|376014|366016|1800799024|13003099007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h1ZLo9UvydnZQHFQ3/Ll32HT/fl69a/Ur6c3qe4MIvLBl7/6NOCLuuyauxfT?=
 =?us-ascii?Q?gnBfJE+5XVfpc6dm0nq0bkdUNa2QGHyN8CbeAtD7PnvaQphEEGX5E9GlU3P8?=
 =?us-ascii?Q?GFWd2Qj2YsQURSuBZehKRsuX2DZZStNtT/3agvkY3eND2pq9LCf2rzqHRn2j?=
 =?us-ascii?Q?kbkBQMW9PWHsRnHdf0wmkc3xJg//IOHfWHocIpd+NLKPp00Bpazu4vE65xGM?=
 =?us-ascii?Q?Qk0F8vAR8siPyeDtQtMVyTgpzQFrEUHYmuRlffHENBncn7piOIV6VNAIp/Cc?=
 =?us-ascii?Q?/CXsYPbUQS/qFW5lmbZ+w7LSibDEAzs57/PY9X61Bshmr0Mi3CPa5EhNukNP?=
 =?us-ascii?Q?F7fKlo+jqNuL8d0AJD23zrKusIde0d2Z6JZRgSP+3f6F0Krob2OzDmRzgyjj?=
 =?us-ascii?Q?C1c2jaldHl1uEWL0ZqTFlg1975HcP9R7ATxqvFQh2witriz/qMZZtspqPzJI?=
 =?us-ascii?Q?bbyzIUOHRbvmbzdkbdbDd+EN541vYMQ+SoNq1g2ZVa/mHEEiC0dlJ3J1h3pz?=
 =?us-ascii?Q?SnaxuVy+KKCaUqDOgd7Ei7PY1J2RLTWcv9Q69BFUIOVZ46mPjgaZkeP1MZt4?=
 =?us-ascii?Q?fiSHsI+iEnsCJFAi57CWrZxOlUGXxt6HCgokAoR6HiDCTZ8bdnzPRCiHUFf3?=
 =?us-ascii?Q?3JBzqrRF7vKZOcgUJ8zRJdVenAFpKpsJ6W8tHPq6XrjpGL+XPMjFNWThxjkA?=
 =?us-ascii?Q?wPrRUzxBt319UBLMSOpc0cEBoaeAAGxk+OB5sfQdVZgJitypWgVSTuaqFPzI?=
 =?us-ascii?Q?8mCsuv0XKoBukxRYV2WcomYhLwcSWMFeztDVOBBazBPLh5SN+y2aPZiK452i?=
 =?us-ascii?Q?0kDDEwnMxGsfECj54FufEUD6jBItA3s+QQo57ttCWdXU9SRKFtY2TEz/xu8D?=
 =?us-ascii?Q?O4CyLJpFkz13npazLS4Yg8uvMEllTQ1wZ9tDzR+2Et4WdTPtkLGWoDd16VEp?=
 =?us-ascii?Q?O4BeaaS6lGzEpnFMjNivbI1h4/5fCz+83p28u5/1SmlNGvXZbM5kF31n8tJK?=
 =?us-ascii?Q?LdR3KF4vM+Mer/HVWo0JlrU9IA2NFrbuJvsK29+I/4QC+1Je6jJ3D+qePXG/?=
 =?us-ascii?Q?/37ok4Jrr43s2SUet/bfZc9hjchDC8Xq6n0QWWY7tG6Z2j9eA8BEiwynz2+i?=
 =?us-ascii?Q?rT85XxVSlt/6GqLZzOBkGUwZ249xV+OYf52VH3QAydWUViZl4i5l6R7QSpMG?=
 =?us-ascii?Q?y0lwW1J6SrryUqn6bpuE6Reu8QJ+sWREEGnL+Y0lmi6ycbAkTdJF0ykmK5vN?=
 =?us-ascii?Q?Nx7ssOf3D9ghR4xOFeTTcfeVnfKpSGfcTtzdnVs+/Ba0wjbqStpmIH5nC8Dm?=
 =?us-ascii?Q?Qo5u52JZQ7WxKoYcIxACPTUO87MS/Y/DuTe/TgR3P9ejGF8NvRPYBr+hmyJa?=
 =?us-ascii?Q?6ML8sgXX/4KG22GBkRvU/frnU8bX5en4OxhPL2B+dRgyqG27lf3zlrbD+xDH?=
 =?us-ascii?Q?7vElkFVAqfEUwX8zL+OktQwC0jjRoens?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(52116014)(376014)(366016)(1800799024)(13003099007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rSPA2mz4+z5jP2NRqfCB2CN8JCA8+6ZXchYKLPRKid7WGApbL6D4KKqu2aM6?=
 =?us-ascii?Q?VX0eQuzlJ040/8x2oLy5KZzuBc7typVwlQQQmO3DO1hGk2oEq9DqTvlPOAke?=
 =?us-ascii?Q?v0sb/xrIPLNK8VJ1/4BZ8sSDZ56ZIqIYir4hZRAFJhJDKoyS68heMDWKDLHS?=
 =?us-ascii?Q?WP23f/zU2i63GuE12hTOMS+HeP26mOBTSeAXuFT//qF7FJFPW8PCh0AeZQuG?=
 =?us-ascii?Q?T+aA+Wk/ZVVeJNs7fSB/gM61pEUCUrfaqXz2qa5FpMWMdkbga45rJgTKkrTA?=
 =?us-ascii?Q?u8XbciMI0WJkILF53qpJEhDAbNIh7TW+DUXt4pXYrkOuiPkZ9gsk1HWx8QTu?=
 =?us-ascii?Q?zbFjIwgfXCj8RZ6nh/h4RUxBbGk8y316PJc7/9QTIxRmp4Z31za7rDia6Hm0?=
 =?us-ascii?Q?oHX/uqagKoqyIbZemVdsMreV7GeM4uenUNVS3AxLiEHhjwuUSQR70eFooaZO?=
 =?us-ascii?Q?tWgCOju34KfpwqfDQWmb31RloXwPI5F9SXYhfPP6Pa92KIZQTV+XcMjY6837?=
 =?us-ascii?Q?DYb0ksLyieSAom1wh7vIS8ct0hjbzbFlgX+Ft3D6PGXh61WaF4xuYlmXtFtZ?=
 =?us-ascii?Q?VXyO/j9EqUdTABrB4DOdx0PY68DCKxwie0qZ+tB3YUw4fgGj5cW2nlo8d0Qf?=
 =?us-ascii?Q?NCPx1PX0jXA1AQMiH9lYDU+nWEWHU1MFAsa4tRMrEogC80UWKfPzXhlJuyzq?=
 =?us-ascii?Q?+7thuMZTgprIa3WuHv3WsPx7f33i5kzH5MYFh5X5zvJzXvEqoENK6v/UqPXC?=
 =?us-ascii?Q?tgtyKFEMSVo56ahB4c+jyWFHYWDImlWEpkFjdKtljGFUzRsDdPXdzxd2ckkt?=
 =?us-ascii?Q?kGiOq908V7VTZ9JOisr3q2QezWZ5fI9a4iPShaDb+RaF+RUMGk8mpUkCnJiZ?=
 =?us-ascii?Q?qSVV0b0ZtF1OeMgfNQFnyN40zNBxPwmt3JDooxHHWqnAZABzytEMLFTIXu29?=
 =?us-ascii?Q?SevcoQC9JHQFSRH34POW5LcDBpGHMOvNelMh3ZtE3qQbLff1KBSYGLvoDVGJ?=
 =?us-ascii?Q?yV226eYM8Y6pdpL2Jhe2Dxzf5euMyveSoemI5YrlpyXKpM0N0ZMkikT9F65R?=
 =?us-ascii?Q?Knug3B9SoOP7jrfet0GesZISliywFsZ3Ee4mrluUTAwDqDUKcDOJR+SThQ0H?=
 =?us-ascii?Q?TbXcXJJAcoSHPkSveXeUiVkWs1XEUYHJ7wZawEgp5mJiYzfSpRxJ5PI8IIFu?=
 =?us-ascii?Q?KXsOL2utUKywPheG7MCErnV+e7D0ZIoUIPu4jdkEKv++4Cjrmt5m95DMN/x0?=
 =?us-ascii?Q?eAswWpn0+c8zB61+pmglOGhyc7W/I4K8ypGixPleGNnz6q8rTe8HRGg+1S1k?=
 =?us-ascii?Q?Rmt+y8ocS58Usq4m3aPHIRhsyqrvDkZ0liOyI7DQg+10r121KQ+jk3HvAPN6?=
 =?us-ascii?Q?97acscndGOQF193CNhLm/QXKEKaqb0Q/l0xIwVbK5eNOl6usVt9QNFD3Ka71?=
 =?us-ascii?Q?KRLS3aIX631z0I/GpfpyBEcQMw+kBQPS3ukvdJDWJpm0jqMMLP7oLDYKI6Uc?=
 =?us-ascii?Q?Vesm87gnnzAPZYe0R9yrg33HuxYkAzEiojNlbv5yvFJpp9qHlCAruggNaMYo?=
 =?us-ascii?Q?ylnt2+VGu06Vr5AMyAda87VihPVcFBC+WaXf3zPQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6917c52-8824-48f0-c662-08ddf505d99d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 09:46:03.4841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D3xWA8sqOnuWXnK254sBHWxgXscxVPUAJ9p1Iel9loRQHsr6jigsNFVFPuv8U6ERGA7f0v0HvJBD1y9o4Gksrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9391
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

From: Ye Li <ye.li@nxp.com>

Add board-level code and defconfig for the i.MX943 EVK board, supporting
multiple SOM variants: 19x19 LPDDR5, 19x19 LPDDR4 and 15x15 LPDDR4.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Acked-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
---
 arch/arm/mach-imx/Makefile              |   2 +-
 arch/arm/mach-imx/imx9/Kconfig          |   8 ++
 board/freescale/imx94_evk/Kconfig       |  12 +++
 board/freescale/imx94_evk/MAINTAINERS   |   6 ++
 board/freescale/imx94_evk/Makefile      |  11 +++
 board/freescale/imx94_evk/imx94_evk.c   |  41 +++++++++
 board/freescale/imx94_evk/imx94_evk.env | 101 +++++++++++++++++++++
 board/freescale/imx94_evk/spl.c         |  81 +++++++++++++++++
 configs/imx943_evk_defconfig            | 115 ++++++++++++++++++++++++
 doc/board/nxp/imx943_evk.rst            | 112 +++++++++++++++++++++++
 doc/board/nxp/index.rst                 |   1 +
 include/configs/imx94_evk.h             |  24 +++++
 12 files changed, 513 insertions(+), 1 deletion(-)
 create mode 100644 board/freescale/imx94_evk/Kconfig
 create mode 100644 board/freescale/imx94_evk/MAINTAINERS
 create mode 100644 board/freescale/imx94_evk/Makefile
 create mode 100644 board/freescale/imx94_evk/imx94_evk.c
 create mode 100644 board/freescale/imx94_evk/imx94_evk.env
 create mode 100644 board/freescale/imx94_evk/spl.c
 create mode 100644 configs/imx943_evk_defconfig
 create mode 100644 doc/board/nxp/imx943_evk.rst
 create mode 100644 include/configs/imx94_evk.h

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index fa2cdaba144..1efe690e876 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -223,7 +223,7 @@ endif
 
 ifeq ($(CONFIG_ARCH_IMX9)$(CONFIG_ARCH_IMX8ULP), y)
 
-ifneq ($(and $(CONFIG_IMX95),$(CONFIG_BINMAN)),)
+ifneq ($(and $(CONFIG_BINMAN),$(or $(CONFIG_IMX95),$(CONFIG_IMX94))),)
 SPL: spl/u-boot-spl.bin FORCE
 	$(call if_changed,mkimage)
 else
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index f2011448c23..48f458fa55c 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -106,6 +106,13 @@ config TARGET_IMX95_19X19_EVK
 	imply BOOTSTD_FULL
 	imply OF_UPSTREAM
 
+config TARGET_IMX943_EVK
+	bool "imx943_evk"
+	select IMX94
+	imply BOOTSTD_BOOTCOMMAND
+	imply BOOTSTD_FULL
+	imply OF_UPSTREAM
+
 endchoice
 
 source "board/freescale/imx91_evk/Kconfig"
@@ -114,6 +121,7 @@ source "board/freescale/imx93_frdm/Kconfig"
 source "board/freescale/imx93_qsb/Kconfig"
 source "board/phytec/phycore_imx93/Kconfig"
 source "board/variscite/imx93_var_som/Kconfig"
+source "board/freescale/imx94_evk/Kconfig"
 source "board/freescale/imx95_evk/Kconfig"
 
 endif
diff --git a/board/freescale/imx94_evk/Kconfig b/board/freescale/imx94_evk/Kconfig
new file mode 100644
index 00000000000..a4237244ace
--- /dev/null
+++ b/board/freescale/imx94_evk/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_IMX943_EVK
+
+config SYS_BOARD
+	default "imx94_evk"
+
+config SYS_VENDOR
+	default "freescale"
+
+config SYS_CONFIG_NAME
+	default "imx94_evk"
+
+endif
diff --git a/board/freescale/imx94_evk/MAINTAINERS b/board/freescale/imx94_evk/MAINTAINERS
new file mode 100644
index 00000000000..95309430734
--- /dev/null
+++ b/board/freescale/imx94_evk/MAINTAINERS
@@ -0,0 +1,6 @@
+i.MX94 EVK BOARD
+M:	Alice Guo <alice.guo@nxp.com>
+S:	Maintained
+F:	board/freescale/imx94_evk/
+F:	include/configs/imx94_evk.h
+F:	configs/imx943_evk_defconfig
diff --git a/board/freescale/imx94_evk/Makefile b/board/freescale/imx94_evk/Makefile
new file mode 100644
index 00000000000..ca31602f6ba
--- /dev/null
+++ b/board/freescale/imx94_evk/Makefile
@@ -0,0 +1,11 @@
+#
+# Copyright 2025 NXP
+#
+# SPDX-License-Identifier:      GPL-2.0+
+#
+
+obj-y += imx94_evk.o
+
+ifdef CONFIG_SPL_BUILD
+obj-y += spl.o
+endif
diff --git a/board/freescale/imx94_evk/imx94_evk.c b/board/freescale/imx94_evk/imx94_evk.c
new file mode 100644
index 00000000000..28d512ac5f3
--- /dev/null
+++ b/board/freescale/imx94_evk/imx94_evk.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ */
+
+#include <asm/arch/clock.h>
+#include <asm/gpio.h>
+#include <asm/mach-imx/sys_proto.h>
+#include <env.h>
+#include <fdt_support.h>
+
+int board_early_init_f(void)
+{
+	init_uart_clk(0);
+	return 0;
+}
+
+int board_init(void)
+{
+	return 0;
+}
+
+int board_late_init(void)
+{
+	if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC))
+		board_late_mmc_env_init();
+
+	env_set("sec_boot", "no");
+
+	if (IS_ENABLED(CONFIG_AHAB_BOOT))
+		env_set("sec_boot", "yes");
+
+	return 0;
+}
+
+int board_phys_sdram_size(phys_size_t *size)
+{
+	*size = PHYS_SDRAM_SIZE + PHYS_SDRAM_2_SIZE;
+
+	return 0;
+}
diff --git a/board/freescale/imx94_evk/imx94_evk.env b/board/freescale/imx94_evk/imx94_evk.env
new file mode 100644
index 00000000000..272f4434481
--- /dev/null
+++ b/board/freescale/imx94_evk/imx94_evk.env
@@ -0,0 +1,101 @@
+#ifdef CONFIG_AHAB_BOOT
+sec_boot=yes
+#else
+sec_boot=no
+#endif
+
+jh_root_dtb=imx943-evk-root.dtb
+jh_mmcboot=setenv fdtfile ${jh_root_dtb};
+	setenv jh_clk kvm.enable_virt_at_load=false cpuidle.off=1 clk_ignore_unused kvm-arm.mode=nvhe;
+	setenv jh_root_mem 0x60000000@0x90000000,0x100000000@0x100000000;
+	if run loadimage; then
+		run mmcboot;
+	else run jh_netboot; fi;
+jh_netboot=setenv fdtfile ${jh_root_dtb};
+	setenv jh_root_mem 0x60000000@0x90000000,0x100000000@0x100000000;
+	setenv jh_clk kvm.enable_virt_at_load=false cpuidle.off=1 clk_ignore_unused kvm-arm.mode=nvhe; run netboot;
+
+initrd_addr=0x93800000
+initrd_high=0xffffffffffffffff
+emmc_dev=0
+sd_dev=1
+scriptaddr=0x93500000
+kernel_addr_r=CONFIG_SYS_LOAD_ADDR
+image=Image
+splashimage=0xA0000000
+console=ttyLP0,115200 earlycon
+fdt_addr_r=0x93000000
+fdt_addr=0x93000000
+cntr_addr=0xA8000000
+cntr_file=os_cntr_signed.bin
+boot_fit=no
+fdtfile=CONFIG_DEFAULT_FDT_FILE
+bootm_size=0x10000000
+mmcdev=CONFIG_SYS_MMC_ENV_DEV
+mmcautodetect=yes
+mmcargs=setenv bootargs ${jh_clk} ${mcore_args} console=${console} root=${mmcroot}
+prepare_mcore=setenv mcore_args pd_ignore_unused;
+loadbootscript=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${script};
+bootscript=echo Running bootscript from mmc ...; source
+loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
+loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
+loadcntr=fatload mmc ${mmcdev}:${mmcpart} ${cntr_addr} ${cntr_file}
+auth_os=booti ${cntr_addr}
+boot_os=booti ${loadaddr} - ${fdt_addr_r};
+mmcboot=echo Booting from mmc ...;
+		run mmcargs;
+		if test ${sec_boot} = yes; then
+			run auth_os;
+		else
+			if test ${boot_fit} = yes || test ${boot_fit} = try; then
+				bootm ${loadaddr};
+			else
+				if run loadfdt; then
+					run boot_os;
+				else
+					echo WARN: Cannot load the DT;
+				fi;
+			fi;
+		fi;
+netargs=setenv bootargs ${jh_clk} ${mcore_args} console=${console} root=/dev/nfs
+		ip=dhcp nfsroot=${serverip}:${nfsroot},v3,tcp
+netboot=echo Booting from net ...;
+		run netargs;
+		if test ${ip_dyn} = yes; then
+			setenv get_cmd dhcp;
+		else
+			setenv get_cmd tftp;
+		fi;
+		if test ${sec_boot} = yes; then
+			${get_cmd} ${cntr_addr} ${cntr_file};
+			run auth_os;
+		else
+			${get_cmd} ${loadaddr} ${image};
+			if test ${boot_fit} = yes || test ${boot_fit} = try; then
+				bootm ${loadaddr};
+			else
+				if ${get_cmd} ${fdt_addr_r} ${fdtfile}; then
+					run boot_os;
+				else
+					echo WARN: Cannot load the DT;
+				fi;
+			fi;
+		fi;
+bsp_bootcmd=echo Running BSP bootcmd ...;
+			mmc dev ${mmcdev}; if mmc rescan; then
+			if run loadbootscript; then
+				run bootscript;
+			else
+				if test ${sec_boot} = yes; then
+					if run loadcntr; then
+						run mmcboot;
+					else run netboot;
+					fi;
+				else
+					if run loadimage; then
+						run mmcboot;
+					else run netboot;
+					fi;
+				fi;
+			fi;
+		fi;
diff --git a/board/freescale/imx94_evk/spl.c b/board/freescale/imx94_evk/spl.c
new file mode 100644
index 00000000000..341b165b3c8
--- /dev/null
+++ b/board/freescale/imx94_evk/spl.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ */
+
+#include <asm/arch/clock.h>
+#include <asm/arch/mu.h>
+#include <asm/arch/sys_proto.h>
+#include <asm/gpio.h>
+#include <asm/mach-imx/boot_mode.h>
+#include <asm/mach-imx/ele_api.h>
+#include <asm/sections.h>
+#include <hang.h>
+#include <init.h>
+#include <spl.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int spl_board_boot_device(enum boot_device boot_dev_spl)
+{
+	switch (boot_dev_spl) {
+	case SD1_BOOT:
+	case MMC1_BOOT:
+		return BOOT_DEVICE_MMC1;
+	case SD2_BOOT:
+	case MMC2_BOOT:
+		return BOOT_DEVICE_MMC2;
+	case USB_BOOT:
+		return BOOT_DEVICE_BOARD;
+	case QSPI_BOOT:
+		return BOOT_DEVICE_SPI;
+	default:
+		return BOOT_DEVICE_NONE;
+	}
+}
+
+void spl_board_init(void)
+{
+	int ret;
+
+	puts("Normal Boot\n");
+
+	ret = ele_start_rng();
+	if (ret)
+		printf("Fail to start RNG: %d\n", ret);
+}
+
+/* SCMI support by default */
+void board_init_f(ulong dummy)
+{
+	int ret;
+
+	/* Clear the BSS. */
+	memset(__bss_start, 0, __bss_end - __bss_start);
+
+	if (IS_ENABLED(CONFIG_SPL_RECOVER_DATA_SECTION) &&
+	    IS_ENABLED(CONFIG_SPL_BUILD))
+		spl_save_restore_data();
+
+	timer_init();
+
+	spl_early_init();
+
+	/* Need enable SCMI drivers and ELE driver before enabling console */
+	ret = imx9_probe_mu();
+	if (ret)
+		hang(); /* if MU not probed, nothing can output, just hang here */
+
+	arch_cpu_init();
+
+	board_early_init_f();
+
+	preloader_console_init();
+
+	debug("SOC: 0x%x\n", gd->arch.soc_rev);
+	debug("LC: 0x%x\n", gd->arch.lifecycle);
+
+	get_reset_reason(true, false);
+
+	board_init_r(NULL, 0);
+}
diff --git a/configs/imx943_evk_defconfig b/configs/imx943_evk_defconfig
new file mode 100644
index 00000000000..27230ed3207
--- /dev/null
+++ b/configs/imx943_evk_defconfig
@@ -0,0 +1,115 @@
+CONFIG_ARM=y
+CONFIG_ARCH_IMX9=y
+CONFIG_TEXT_BASE=0x90200000
+CONFIG_SYS_MALLOC_LEN=0x2000000
+CONFIG_SYS_MALLOC_F_LEN=0x10000
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_ENV_SOURCE_FILE="imx94_evk"
+CONFIG_ENV_SIZE=0x4000
+CONFIG_ENV_OFFSET=0x700000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx943-evk"
+CONFIG_TARGET_IMX943_EVK=y
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_SYS_MONITOR_LEN=524288
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_TEXT_BASE=0x20480000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x204d6000
+CONFIG_SPL_BSS_MAX_SIZE=0x2000
+CONFIG_SYS_LOAD_ADDR=0x90400000
+CONFIG_SPL=y
+CONFIG_SPL_RECOVER_DATA_SECTION=y
+CONFIG_PCI=y
+CONFIG_OF_BOARD_FIXUP=y
+CONFIG_SYS_MEMTEST_START=0x90000000
+CONFIG_SYS_MEMTEST_END=0xA0000000
+CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_BOOTCOMMAND="bootflow scan -l; run bsp_bootcmd"
+CONFIG_DEFAULT_FDT_FILE="imx943-evk.dtb"
+CONFIG_SYS_CBSIZE=2048
+CONFIG_SYS_PBSIZE=2074
+CONFIG_BOARD_EARLY_INIT_F=y
+CONFIG_BOARD_LATE_INIT=y
+CONFIG_SPL_MAX_SIZE=0x30000
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_LOAD_IMX_CONTAINER=y
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x93200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1040
+CONFIG_SPL_DM_MAILBOX=y
+CONFIG_SPL_POWER_DOMAIN=y
+CONFIG_SPL_THERMAL=y
+CONFIG_SPL_WATCHDOG=y
+CONFIG_SYS_PROMPT="u-boot=> "
+CONFIG_CMD_ERASEENV=y
+CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CRC32_VERIFY=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_DFU=y
+CONFIG_CMD_FUSE=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_POWEROFF=y
+CONFIG_CMD_SNTP=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_EFIDEBUG=y
+CONFIG_CMD_RTC=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_GETTIME=y
+CONFIG_CMD_TIMER=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_HASH=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_NOWHERE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_SPL_DM=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_REGMAP=y
+CONFIG_SYSCON=y
+CONFIG_SPL_OF_TRANSLATE=y
+CONFIG_CLK=y
+CONFIG_SPL_CLK=y
+CONFIG_SPL_CLK_CCF=y
+CONFIG_CLK_CCF=y
+CONFIG_CLK_SCMI=y
+CONFIG_SPL_CLK_SCMI=y
+CONFIG_SPL_FIRMWARE=y
+# CONFIG_SCMI_AGENT_SMCCC is not set
+CONFIG_IMX_RGPIO2P=y
+CONFIG_IMX_MU_MBOX=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_FSL_USDHC=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PINCTRL_IMX_SCMI=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_SCMI_POWER_DOMAIN=y
+CONFIG_DM_REGULATOR=y
+CONFIG_SPL_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_RTC=y
+CONFIG_DM_SERIAL=y
+CONFIG_FSL_LPUART=y
+CONFIG_ULP_WATCHDOG=y
diff --git a/doc/board/nxp/imx943_evk.rst b/doc/board/nxp/imx943_evk.rst
new file mode 100644
index 00000000000..651db08a0f7
--- /dev/null
+++ b/doc/board/nxp/imx943_evk.rst
@@ -0,0 +1,112 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+imx943_evk
+=======================
+
+U-Boot for the NXP i.MX943 19x19 EVK board
+
+Quick Start
+-----------
+
+- Get ahab-container.img
+- Get DDR PHY Firmware Images
+- Get and Build OEI Images
+- Get and Build System Manager Image
+- Get and Build the ARM Trusted Firmware
+- Build the Bootloader Image
+- Boot
+
+Get ahab-container.img
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+
+.. code-block:: bash
+
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-ele-imx-2.0.2-89161a8.bin
+   $ sh firmware-ele-imx-2.0.2-89161a8.bin --auto-accept
+   $ cp firmware-ele-imx-2.0.2-89161a8/mx943a0-ahab-container.img $(srctree)
+
+Get DDR PHY Firmware Images
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+
+.. code-block:: bash
+
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.28-994fa14.bin
+   $ sh firmware-imx-8.28-994fa14.bin --auto-accept
+   $ cp firmware-imx-8.28-994fa14/firmware/ddr/synopsys/lpddr5*v202409.bin $(srctree)
+
+Get and Build OEI Images
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+Get OEI from: https://github.com/nxp-imx/imx-oei
+branch: master
+
+.. code-block:: bash
+
+   $ sudo apt -y install make gcc g++-multilib srecord
+   $ wget https://developer.arm.com/-/media/Files/downloads/gnu/13.3.rel1/binrel/arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
+   $ tar xvf arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
+   $ export TOOLS=$PWD
+   $ git clone -b master https://github.com/nxp-imx/imx-oei.git
+   $ cd imx-oei
+   $ make board=mx943lp5-19 oei=ddr DEBUG=1 all
+   $ cp build/mx943lp5-19/ddr/oei-m33-ddr.bin $(srctree)
+
+Get and Build System Manager Image
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+Get System Manager from: https://github.com/nxp-imx/imx-sm
+branch: master
+
+.. code-block:: bash
+
+   $ sudo apt -y install make gcc g++-multilib srecord
+   $ wget https://developer.arm.com/-/media/Files/downloads/gnu/13.3.rel1/binrel/arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
+   $ tar xvf arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
+   $ export TOOLS=$PWD
+   $ git clone -b master https://github.com/nxp-imx/imx-sm.git
+   $ cd imx-sm
+   $ make config=mx94evk all
+   $ cp build/mx94evk/m33_image.bin $(srctree)
+
+Get and Build the ARM Trusted Firmware
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+Get ATF from: https://github.com/nxp-imx/imx-atf/
+branch: lf_v2.12
+
+.. code-block:: bash
+
+   $ export CROSS_COMPILE=aarch64-poky-linux-
+   $ unset LDFLAGS
+   $ unset AS
+   $ git clone -b lf_v2.12 https://github.com/nxp-imx/imx-atf.git
+   $ cd imx-atf
+   $ make PLAT=imx94 bl31
+   $ cp build/imx94/release/bl31.bin $(srctree)
+
+Build the Bootloader Image
+--------------------------
+
+.. code-block:: bash
+
+   $ export CROSS_COMPILE=aarch64-poky-linux-
+   $ make imx943_evk_defconfig
+   $ make
+
+Copy flash.bin to the MicroSD card:
+
+.. code-block:: bash
+
+   $ sudo dd if=flash.bin of=/dev/sd[x] bs=1k seek=32 conv=fsync
+
+Boot
+----
+
+Set i.MX943 boot device to MicroSD card
diff --git a/doc/board/nxp/index.rst b/doc/board/nxp/index.rst
index aa7d857346d..670501164b5 100644
--- a/doc/board/nxp/index.rst
+++ b/doc/board/nxp/index.rst
@@ -16,6 +16,7 @@ NXP Semiconductors
    imx93_9x9_qsb
    imx93_11x11_evk
    imx93_frdm
+   imx943_evk
    imx95_evk
    imxrt1020-evk
    imxrt1050-evk
diff --git a/include/configs/imx94_evk.h b/include/configs/imx94_evk.h
new file mode 100644
index 00000000000..f93c3c4e4a8
--- /dev/null
+++ b/include/configs/imx94_evk.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2025 NXP
+ */
+
+#ifndef __IMX94_EVK_H
+#define __IMX94_EVK_H
+
+#include <linux/sizes.h>
+#include <linux/stringify.h>
+#include <asm/arch/imx-regs.h>
+
+#define CFG_SYS_INIT_RAM_ADDR	0x90000000
+#define CFG_SYS_INIT_RAM_SIZE	0x200000
+
+#define CFG_SYS_SDRAM_BASE           0x90000000
+#define PHYS_SDRAM                   0x90000000
+#define PHYS_SDRAM_SIZE			     0x70000000UL /* 2GB  - 256MB DDR */
+#define PHYS_SDRAM_2_SIZE	             0x180000000 /* 8GB */
+
+/* Using ULP WDOG for reset */
+#define WDOG_BASE_ADDR          WDG3_BASE_ADDR
+
+#endif
-- 
2.43.0

