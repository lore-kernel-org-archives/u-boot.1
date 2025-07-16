Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E3DC83F1B
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 07:21:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E612D832BE;
	Wed, 16 Jul 2025 09:19:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="L5SELXZD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A56B583192; Wed, 16 Jul 2025 09:09:44 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::601])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A57F682E37
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 09:09:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WsgFBtOT49k8eZ8bqlaHyDBwYyPWOBwob72F97T0EgvEGLDf2jHEtJGzW31BzryKjDZLI7EUZlX0RV5zNILLQ94uQNNt2Fp1D+2rWRFCRSgbosc33I8Bx4e3FpMzNYkjgbiIp+2OGSViTiuVQPeZRDxLvfIEVFOBdPb8B28tCpws03xRQfhKtl+htxt74fOqYOOcJ0spmhF7GLRREldCBZ4T49ZBa3KYLwGTo1h7pmfFTLKbD/6ngSJ6aIspVzVN7pLf8gzILtncuJ96NF1061ATkGgnF9MAkjL3G31/HpSv8tQGAhKX9uJ0CE99BQCz9qwfEsexQiI5fW8REAJZeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVVSGD1ofmaYVBq6Y0Lx8x2581dT1Wn6SWTLRFi+Er8=;
 b=bGx4IAPgz13MYlLaN3aU+N7t4rgPLnchQP2kAmABUDSnF8mQKsoFps82kiQdoy6JkzVdenOU+gHfGfWhN8JoWiwtCpejBjBZv1HiMQQ0Gtj4DNot1r0+F9iGUtuns/nJvauNzWHgZD4jtchDgEuJVSllFbR4YfoDiDAEjKeyrrbv6EiH2PHg2UzzErrhrU8wQZdH++w4dz/UR6xPyEF11e/Epp2hJ4E0HK3/xVPOxhRMaxCWU05/wQZJ/aiiBuPi4fj1s09j0rXUhZlkXYutTtKJtT5CrSuVJqluMjnZrXh17iWMxbZnRKDC2vCWdrLiavQD9L3HpwNaaIKMuAJFpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVVSGD1ofmaYVBq6Y0Lx8x2581dT1Wn6SWTLRFi+Er8=;
 b=L5SELXZDvem1yYCS54sZENhZFvXgFqlxoKtrXgfX4N5/26I3YpOo+z8FDKzgAldC5AvHBgho2oQdhAs7t0jBs6s3tMBQL4fC93SWCLlOY/FG1NwrpCjAPYIV+vci+A5GET1SAVwCi5b4nHcdz8fUaNtDIIKT8kFq/D469oKRbB0zvDVX7FYkTXSbf8f+3AwioAffYSMvz5RNSI9I7DQIc0PVpcvRh4+Zc4cmgbwdrvzwvyHCwVNqDBPdv5MR96V5DBvkO7RBMIcvx7dZfIpHpofciYHPsp/es05jD5sR8at0hZYuZ4KUDJKHi1CqOo1n8lyXnvwhuBSwHRX+K2HvdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by PH7PR03MB7170.namprd03.prod.outlook.com (2603:10b6:510:241::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Wed, 16 Jul
 2025 07:09:38 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 07:09:38 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Heiko Schocher <hs@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>
Subject: [PATCH v6 12/12] configs: agilex5_defconfig: Enable i3c configs for
 agilex5
Date: Wed, 16 Jul 2025 15:08:10 +0800
Message-Id: <20250716070810.8030-13-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250716070810.8030-1-dinesh.maniyam@altera.com>
References: <20250716070810.8030-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0048.prod.exchangelabs.com (2603:10b6:a03:94::25)
 To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|PH7PR03MB7170:EE_
X-MS-Office365-Filtering-Correlation-Id: a4acd9c9-7a24-4d08-6f80-08ddc437ba2c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XidEiJaY4K35B1ojo8VhEMezvuit+J3gRQxh6Nrd+psxp602eaTnpnOrcofh?=
 =?us-ascii?Q?uis1ANx4P0QR49K1GWDO9Ani9g2gsAk5PpYdP9iauMFyyBwMcgEhDVvu8Wo/?=
 =?us-ascii?Q?f6hsZ+7oHh5liJP5oC4yjfi2PF9F+JFbnj2aWlAEOk++gVf0vC0Wgx6DG19E?=
 =?us-ascii?Q?Jy1JIu8AYw9N+mOHmXxlMTojWwJYq8jnCh/7yHjT2VtmYAcsQ1aQkPksXOWn?=
 =?us-ascii?Q?/bAehTRJ8cnC93uXQUtt2OtHtNLRZCDX8FE0qPZ9Bon46N/3d8IM/tnwefs1?=
 =?us-ascii?Q?HWsHbssVklcynkzSUXjy2ObAa1hKKsibo4QrDK8ZFQDLr3yp4nczqowYRr3y?=
 =?us-ascii?Q?gWwTja0Grj1cUh6HNMjael9RPqGSW/0Qg3m4VgVt8G7v4I4lg14NY3KYZNj4?=
 =?us-ascii?Q?aq0SATVSxP/Q/9tz0TFYUpxwN0AWeisAhzuz5KdROCbAGxzQ/yZFoMpnugHh?=
 =?us-ascii?Q?GY6XGPGvffmcJ6Vshyh5oAHDL0EaxEs2maw5SSwBfnhl4yDPDTtn+m95Uox9?=
 =?us-ascii?Q?tCRQrIfb8P7mKyOk/PJYBTOBMX2sAMHFvEs5ui2hb5par8OI2OLueNCJfeYx?=
 =?us-ascii?Q?xzIpTxzrRG6VsCUYYD2cwYJFpYPg2tF/KMImyYd8eRXlLKVeoHlFiX4VTcpK?=
 =?us-ascii?Q?GE25/1aoNFFtzcGnMLPVa/VY3EslTRLMd9WtIXE15JTdq4FN/Lu1A0FBjbBm?=
 =?us-ascii?Q?SXT5el7wVB4qdsRT9UXCbEjdvk9Ozn8kL2BUYPB2j0tXkBmt2tCn/2ahTb7x?=
 =?us-ascii?Q?mbYcZtaPCj4AoV6Kl44aloWBuKqcdUBCO/fEtrCGBPvSU5xHQYn1UuE/xYDp?=
 =?us-ascii?Q?VVgZjj/y6IcrlTHQKTivYKsDwK0jIxxpGKKrHNEFMxcDprTNjbM0Hrjfmxe9?=
 =?us-ascii?Q?XbzWXh7G763uN1ZqschGAmpDqe+7ZjBDYM3sZMW/lNuld4NX0frWYZZEmkxB?=
 =?us-ascii?Q?WqQojmdQT/OK8ZXJbaPL8G+APB1F4jPUOfMad38hUmD10ZI3WQbEFywB7+Va?=
 =?us-ascii?Q?ePx7N8QNNKXlNxRfOD04qFpWqbq88w/+mtRNxLp/7s5f02UEPJS0oIW2jL/u?=
 =?us-ascii?Q?YTF9gWeI0oNMliQLryOe6eCSDQRbDvqM8vuy4CprXb1uw6ECcMAOxApYUc6+?=
 =?us-ascii?Q?rQ9M1c1r+5c3U8JmrBdc3aE2fJ4GoalbDo1ull8xr2vNnFBe/teOSojtEQo9?=
 =?us-ascii?Q?M0+qTj3Sjv1coZrqZ/I3mw+D4EkgiJfQmgZGEP3KDos5fqnLxRPsYPTMBCBP?=
 =?us-ascii?Q?7/s+nwBOWnGAN+aDc8irzjFDI4oLhPN97CBo+zu/MLwDWBnobpzg+axB8+p6?=
 =?us-ascii?Q?LXTdhrxST0wYEpbDdoj4hzAEJhqtVKLPlAEF7Q2o+f9yu/4oWshMxmA/TbTV?=
 =?us-ascii?Q?BDtDXfN1fxrziY14xm4OyalkoR7NTOFA822lugT8Zfo19ehgtNM+7ZhsjQ9J?=
 =?us-ascii?Q?5aBcwVrbI34=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fCvxtl2TF4RgkhAT1Ozgm92tDfvJwegYzig1pQn1gRgWLOnfaWjaxtjMYsid?=
 =?us-ascii?Q?eVftwLoHHd2dnrYM2RdwyBR9XCPoEOAtxxsJtK/oSukEp7v8Rri1sA0dH+n8?=
 =?us-ascii?Q?2LbqC+GsrPatmfpYKsm6PY4RqG90G1FfxjvZQmLT1ksgVSXJjrNpib6iGlat?=
 =?us-ascii?Q?YqSyaz+AkiiADl+BKjEh04Q8xO3tL26fDwPiCndSuextzjK6a49EMP1u7ZJZ?=
 =?us-ascii?Q?8HdqsRKCMgp0wjOOhf7oGrx/Ka7bkKfmp9wucGBQeGE+8N19FrIcSj5D5IQ7?=
 =?us-ascii?Q?AzZzf2G1jIDvDKOf0st474HfJ61QEXalYwLjHnwpOXmeDSHftdbR2NbKEkFx?=
 =?us-ascii?Q?uoMsC29nBASVFcsoxGE/RaM4BdY2zxqJF8PkUKH0hMgJJjg21F9ATJ85xtce?=
 =?us-ascii?Q?NZJ34xgacQyAoxRWXzzIiGM+ua21035X+96vkVoMiyzlRlggl2BiPfsv8ZAy?=
 =?us-ascii?Q?uQbBkWGELPgaJmXi+D9O+lqLuK/33PekI6lcXgBZVI4lLETVvEdYAW1L+Cdc?=
 =?us-ascii?Q?LHQkNNBoQ3chrsuvv/MzgF3xRc+muwUoutH3cHeNgBtsUdU7iYSUTK2UcvlO?=
 =?us-ascii?Q?9rThgj6GC+m93Wk6y6DRFJbcgWKo6vukNb+r2HlcXRXDW94itNGy25dkHm9Z?=
 =?us-ascii?Q?mnNlLpxt2NQsUKdEoz5oEKuwS1aATqfI0WpURH0MUgYbgPPRSdAv/8DSsmo7?=
 =?us-ascii?Q?7WsisDRlI4tBjVPAAUINzYhAi0EoE0zUaGVF0r5BoVFs5jOC6t6KBq7mpDNu?=
 =?us-ascii?Q?P9s6sHHGD1LJG/MDzcvu69HM0GpYzhXQtcEk32AfVfE7ipwL6/lICyPIgNSi?=
 =?us-ascii?Q?COy6tVw/82bu4HcoAjIP6sv1RIL9R4AhHEaFk2C5Ses5BMDph1jE6jYDA/5f?=
 =?us-ascii?Q?ADBPtjwV8ttTl5V3FsYfq1PIucp3wWwtH/+4OeyVPOu2SxLI1xIhUT+cE1gl?=
 =?us-ascii?Q?q4xx87lSccmkzFsCg3XXxsHhcQSytfa36JP60GwbSDewIH1AyYTRcRBpe+Q1?=
 =?us-ascii?Q?OByuBvUfOZvIsPJ+ycCT8Jbp8TaQy89lVbMOacxQwirI5phoXsrWc18KUTF5?=
 =?us-ascii?Q?SWqXDLKbsy/b/6Q6Wc9wy3WRJmpw73aM95o6E53MJ163GxdBQFa47ekaK4HZ?=
 =?us-ascii?Q?JXfy5F+gpaRg4s2uh5TimdvBq4SgQsjNPMJwq5vdtELS9OZv03eCuWkd2Efw?=
 =?us-ascii?Q?8/AGh11c0UzakZJya3QXMgj1A5t5jW8ZRAN8oQ5e+feaRbFCHithk0T/Y9nC?=
 =?us-ascii?Q?JZ9g3OV2BHdXF+bANZoQqvqfBqsjE6HWttO83+Tt/wsnSq7aviOLn2t22ZrW?=
 =?us-ascii?Q?gtGuoqda1ogbjCNDinxQXcL13fxUxi/ycWq+FDYrwpj/E3oKVHOWBOx7Bwia?=
 =?us-ascii?Q?w61b6IrukkswP7Z6xIkahMon+6TYbc4gsxQlvEVLsrKnI8ZMwZfwZ3gOohj8?=
 =?us-ascii?Q?lvMSuuqFoXSudqP9BNK5q+W1/491vRKColFYvkpaWkYycXskThDqknT+5ngG?=
 =?us-ascii?Q?6LXcNbxMs9fZ3/XBZ5Hb8IEpPPfp/+uHrIdqvA7lcF4gYr8iJwHnCaoL8tfk?=
 =?us-ascii?Q?FwzQwMM3c6s3G89vTafLk7WUAkBVW/Z3jyuB2HHSFO4XnfwO1lcoGJy8F5o+?=
 =?us-ascii?Q?9w=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4acd9c9-7a24-4d08-6f80-08ddc437ba2c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:09:38.5533 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 35zwSw0qgBZhhvzb5sCh1AZXC/+poDccXHXOX8NFfpOzJn8JR9Or+XPmDGXzAO7XmNsBXsT5w6ePxSTsh6k7/pzVcYP2iQIE2oH6gHW15Cc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7170
X-Mailman-Approved-At: Wed, 16 Jul 2025 09:18:59 +0200
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Enable configs for i3c in agilex5.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 configs/socfpga_agilex5_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
index 8577ac610c2..87febc9f4ce 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -44,6 +44,7 @@ CONFIG_CMD_NVEDIT_SELECT=y
 CONFIG_CMD_MEMTEST=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
+CONFIG_CMD_I3C=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
@@ -66,6 +67,8 @@ CONFIG_SPL_ALTERA_SDRAM=y
 CONFIG_DWAPB_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_DW=y
+CONFIG_I3C=y
+CONFIG_DW_I3C_MASTER=y
 CONFIG_MISC=y
 CONFIG_DM_MTD=y
 CONFIG_SPI_FLASH_SPANSION=y
-- 
2.35.3

