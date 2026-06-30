Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 357F8C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 02:49:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 723E1849F3;
	Tue, 30 Jun 2026 04:49:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="vZ/mW6NZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2910584AB7; Tue, 30 Jun 2026 04:49:36 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12085849C5
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 04:49:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l3zq/hGlkjJLYISteJN4VVbO2GVLJZMnWLIgXK4hbu8JXq4IKIbqn+Dwj3tjHrXeG3rb1GtqFL9mQeCyVQjcSJQGDO0spETbeMGgz3ew+bO/3lKOinjcI6zH3eAFcyAftur86YRWhWQ6B4pj6bE1n8qCl6SPmkJHqW8YoFIck0aEyC2y0R3K1ANBjfkKpQ4+0iGvi40ndbcYFctl/IervGITlT2D9nvUuDC6UxMDs65ub4j2VaWF6Npb9REI36mV/uWK/7ZjC5ZyBJ+U84hjDvVzZtQXDqY92T/mhzJOc1fyUbBBSWyH9PeNuJJSyRlpj4Xc6Qw/2zeGeugys2/GOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hG6ms8bM3c//t206jyyA22aJs4Nw0DcRjWx74tL9hdw=;
 b=SGfGwfXA4aL8ChqbA1UJ8n/bkWFvmzYF7KRLoOyVMpyxsKp6k9X1whamJayVu4Ian7l0Hq6f2/Ffwh2JyCHcYO9MwvPl0FcHI9nIoewDE57S6dycLjxfWiMKOzwzb/+BirvvJFZEugdw5DzlxgEABJBVs+Sn3xy4znoDW6VIQuTKOgzRxZX+l1WPWmMng9pks5QZvukqbt14/q23VpH+7v1US+fJq4RZKpESl9/n0dKEyj9gqGHiJFrzc+dqJXigMU8s3uYJjicBTAePoEZJsu1EraPEf8ZPHVaj843AUijSir482PPCpycZhQQ/lFL7lbEdO8sM6R8K1S14zA3eTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hG6ms8bM3c//t206jyyA22aJs4Nw0DcRjWx74tL9hdw=;
 b=vZ/mW6NZBESqsYEWPqBQLKRcU0XthYw6jwLiPyENe9qn3kiqQ4tjILXd5u/8uA4GmJV4O4w/tmIOHb7cVTWssOHdKY10AWjG4kDC4glc4PbfvT6+YJZKZIMtRiIHS5CCB8oZ502jpmx9Egm2G5va/ISN4FkfVs5sWkQ3/F63s0zMFIAWpXTrBLLNRatT2Q19AJ9tzL7i5biq1KbHCr4/NdXD6MoUd7W7zwdy11YXWvDAZoNSs4tTziMUB/x4O9gFx2s+/hPB+stzYEZEoiHeBUGxzFNWFEqNbwfhvFfEbu/hNTQ/dZTHX8jLUKIuGtQVGN7AUctx0GX4L9N/xMFkhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by VE1PR04MB7373.eurprd04.prod.outlook.com (2603:10a6:800:1ab::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 02:49:31 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Tue, 30 Jun 2026
 02:49:30 +0000
Date: Tue, 30 Jun 2026 10:52:55 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Eric Chung <eric.chung@riscstar.com>
Cc: u-boot-spacemit@groups.io, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Han Xu <han.xu@nxp.com>, Yanir Levin <yanir.levin@tandemg.com>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>,
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Johan Jonker <jbx6244@gmail.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Guodong Xu <guodong.xu@riscstar.com>
Subject: Re: [PATCH v2 v2 3/8] mmc: k1: add sdhci platform driver
Message-ID: <akMvh1LxFlNBgT9u@shlinux89>
References: <20260629-m4-v2-0-cbc91c6b83d8@riscstar.com>
 <20260629-m4-v2-3-cbc91c6b83d8@riscstar.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629-m4-v2-3-cbc91c6b83d8@riscstar.com>
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|VE1PR04MB7373:EE_
X-MS-Office365-Filtering-Correlation-Id: 13355a8b-123a-4461-c2f0-08ded6523590
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|19092799006|7416014|18002099003|22082099003|11063799006|4143699003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: A/NdDzcPa3iPYJDLrurc2X/n85tIKnr95IbHeyqRQh8iXgAaYWAUr/NZNhSpDFhV2spmGz0TvBQyAupjcqqDVgcAZJlrgRs5OVIJtk4Rx/RdhIHhmkQoy1NyNMaZgjzKIYL3YHidTxG5R0P/DB0OmNClpaWQgkk4G4qJ6TdmKlnPend2F7y+lFOUGlflHOfRj0427vpmLFZAg2lp0JUm1Ms+uMyNh6CM0h0LzNbVBj2J6VtQa2C1N46rXoNiqpBovERGoroG7YQ44QP6LY4HgJM03oGZQU+iL/4wVnCPWUWi5P8iJMelPnVtv+APfCkH2g548cw03QXDNVe5W31vd+MsYXmx7r8jN4mxjpUDZQqVd4jxBrkDrVGqKxeaE4dw+RpFhxgww2vvI9c1FP/pGEUBM14rRgTxA+QR1TA83MphlovrlKNNdVH4t40INPjouqSkPdvQO8xI3iFUuaYGpaSId24dX/RLSky40g0o+68BSH3jxUQWVuiALv2Y9qLWcSY50iOycglMJs1gc+3q8Di7f/rUgbdYJaQWc8M7t6bN52lLygEG0BuDvFwWasaV0EU47qrqvIK+FWPnREUoXpqo42CK9qmkhQ1QueZqlfwc/xg5JfXeV4yEF7Dm7CUmGRDjD7NPWs3+Snh68aApScnMzc1hW6ebNE2S9LJKWU8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(19092799006)(7416014)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/YPSFE/REB2RrCyLzvG+xRYVfSttNlTzkxULLmfI/r9RVWtn2FmSXVIF0Wdv?=
 =?us-ascii?Q?ppoAaW6wk/bGBRC1tLnJusw/F2GalOhdZAVbIgX6+3aOhteqU4CpRhNlbaqb?=
 =?us-ascii?Q?m+4/VjbVO5KwNQkgbMIDW3FUTah8iI1eW0pbeYF0Efs7Guxl5BbQQtsARcJg?=
 =?us-ascii?Q?harcI4ot9YbLPBqNe13Tgz9tJAZuZpYY/dSOWa9+xEw9VzWt8fpagMuZY+ZC?=
 =?us-ascii?Q?SZgMxwRvOw6m1e+LqOF2Ya58gh9Nrk2oDeFQIYM3ZHB1695CvF9tzZYRnYVc?=
 =?us-ascii?Q?D5B1M8539JjA74a5KvZXaWjQmZJHyADW+bQ0stEDbluYSfRIBGKsT8L+kZ1k?=
 =?us-ascii?Q?9Bv3QdYcRXHbWJrGRx1AyyP/ga6s7uHfa2L7jAWaNJLkDotGzaJg2JhI35ua?=
 =?us-ascii?Q?PvM3pXYA9UNZ9LRrywqZ+G5Bkn1DFP3zSzHDNsT4DUJNfWckWCNJHZsVXKHT?=
 =?us-ascii?Q?KOKZFZcfmn2MqET3+OrH2WEC8RGemKxQzhsEYDl6NK5AYEbcXv1tFdejuBZX?=
 =?us-ascii?Q?XO2KGuxc8KbptmRaJSfcDSqVjWQtpctHS7JC4j48O/CwEOWf4rfln2nwm3NU?=
 =?us-ascii?Q?PrU5oFGTh1bbg1b3lF+612T2TIs+aB3DMBJM4msduTtzvCUUqPKImKRSZIzZ?=
 =?us-ascii?Q?rnwv1pRkrMhMLWAOU6pI6UKhE/KL72r8HXPIsrioNPQl8HOxjNKkXBjEus1k?=
 =?us-ascii?Q?qGkObs2aGRO4gOYhbFgSUbIZlpDpIeuXQ/I+IQHh7YKYjwirS115v/EIxQO3?=
 =?us-ascii?Q?vYmHHCWXk3Kp4om2cDK25Cj1oL0Dtsd4ieymZagdtjpQk3hxIdsDeYyJjnwf?=
 =?us-ascii?Q?OPJkVKAMwvBfOq4ccYyGN/+k4hB/xFph3bWk6a2i4/H3z7W8SFpV2x6tFfji?=
 =?us-ascii?Q?E0l+PzUdnwRFqqFiYDtyNihs0WtjD0vz+LOa9kitY9xbvbx1/tglSajW1dBl?=
 =?us-ascii?Q?/reVbdxS+Gr6vo04/OqPx+4f+QM0z4CDMzy77eopMdWkgiCyQAlYYzFyktPJ?=
 =?us-ascii?Q?G5o4pXlMrSxaKKylM0xD+R5kQR9TMW5r5uOIlBdy8y2/UQL1XNlUSeRfReWb?=
 =?us-ascii?Q?sJO4AL7kWSRp0+GPkeKNLT6MetpBX6gMC9qf1CtkhzQuE1Fj0RBW/sdC0Ver?=
 =?us-ascii?Q?VpfPHvbWim4coUrqrHyQ5nw/1KTH5VYiC7yUxsn3ZhnWBb3aYPx7p2vpSAGk?=
 =?us-ascii?Q?t0jwcqx0CyjuaZgt4nDvLFZVE+SkpO0L6FbnUI/AnMwHtBADF2wrPNiQ4iHB?=
 =?us-ascii?Q?EJvpUmqwWzm6Qx33hzNW+8n4FgrJiHjbEZklJH/yqIopnOrLO5sNZEu6EGum?=
 =?us-ascii?Q?GJ4Hj1Z9AYhrrhfxpsMmCSa6AGjRGqM8nnoo0Rp+wkJHuoAGFCxYkDXUmJ/0?=
 =?us-ascii?Q?ZOgZrC5Sq4fvNLu6BA2IcJn2ciwslMA1JwR1RFwcLC0tNgyAVnQNhF3b+ukU?=
 =?us-ascii?Q?lFz8Js2/lmUfNB2VdOokq6M/Emx8YYLhuOqJIV39aMA3Fn7qUxd5arzavRUC?=
 =?us-ascii?Q?AB4IYLLRefTwAD1tLmQfYetcs7QKJzi+RCnsY6F+CXD7w5040pQS1ATFwNGB?=
 =?us-ascii?Q?iT0UsRxmENq2Blb0VzQr33JnlLgzEvXq3jRRWu2AbdDto7Hu2rWoLbnDK9Hb?=
 =?us-ascii?Q?GIByl49KyCSmjlLTXXPTC7/PZrgAyUjrnPY+pLJxBfgcvKTmox6Nfuek/OLD?=
 =?us-ascii?Q?TlcIlePzWO9yvwsRKdKgASGvMVmNVDJsSAxHkVKr1AtUWy2QxdCXCg0HoSDp?=
 =?us-ascii?Q?FfD+TgQdZuoS4s7LZwFyaRMUAFKI5US0J7C9RUDEge2EQOrvDX3E?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13355a8b-123a-4461-c2f0-08ded6523590
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 02:49:30.8942 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MUExwHHPcI0HfD11/pXWWd2WwXD4+0qKkJyMifMMEl8mL/qvEHwWLkB7PF5BRPqLBsvsnfQVfmzW564CY+drpeq7CatDHAIux8eNqiRLvOG307JVR4mpbT/ABGLNlzdo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7373
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

On Mon, Jun 29, 2026 at 11:51:17PM +0800, Eric Chung wrote:
>Add SDHCI platform driver support for SpacemiT K1 SoC. This driver
>implements the necessary platform-specific operations for the SDHCI
>controller, enabling MMC/SD card functionality on K1-based platforms.
>
>Signed-off-by: Eric Chung <eric.chung@riscstar.com>
>
>---
>v2:
>- Enable ADMA mode support.
>- Use CMD23 for multi-block read/write.
>- Move ASR/AIB register into pinctrl driver.
>- Correct pinctrl state from "fast" to "uhs".
>- Migrate tuning support from the spacemit linux driver.
>---
> drivers/mmc/Kconfig          |   7 +
> drivers/mmc/Makefile         |   1 +
> drivers/mmc/spacemit_sdhci.c | 681 +++++++++++++++++++++++++++++++++++++++++++
> 3 files changed, 689 insertions(+)
>
>diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
>index 131be3106a1..f05b376ab72 100644
>--- a/drivers/mmc/Kconfig
>+++ b/drivers/mmc/Kconfig
>@@ -722,6 +722,13 @@ config MMC_SDHCI_SNPS
> 
> 	  If unsure, say N.
> 
>+config MMC_SDHCI_SPACEMIT
>+	bool "Spacemit SDHCI controller"
>+	depends on MMC_SDHCI
>+	help
>+	  Support for Secure Digital Host Controller Interface (SDHCI) on
>+	  Spacemit K1 SoC.
>+
> config MMC_SDHCI_STI
> 	bool "SDHCI support for STMicroelectronics SoC"
> 	depends on MMC_SDHCI && OF_CONTROL && ARCH_STI
>diff --git a/drivers/mmc/Makefile b/drivers/mmc/Makefile
>index a23336d7d8d..aa05cec23be 100644
>--- a/drivers/mmc/Makefile
>+++ b/drivers/mmc/Makefile
>@@ -71,6 +71,7 @@ obj-$(CONFIG_MMC_SDHCI_ROCKCHIP)	+= rockchip_sdhci.o
> obj-$(CONFIG_MMC_SDHCI_ADI)		+= adi_sdhci.o
> obj-$(CONFIG_MMC_SDHCI_S5P)		+= s5p_sdhci.o
> obj-$(CONFIG_MMC_SDHCI_SNPS)		+= snps_sdhci.o
>+obj-$(CONFIG_MMC_SDHCI_SPACEMIT)	+= spacemit_sdhci.o
> obj-$(CONFIG_MMC_SDHCI_STI)		+= sti_sdhci.o
> obj-$(CONFIG_MMC_SDHCI_TANGIER)		+= tangier_sdhci.o
> obj-$(CONFIG_MMC_SDHCI_TEGRA)		+= tegra_mmc.o
>diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/spacemit_sdhci.c
>new file mode 100644
>index 00000000000..c905c33b2af
>--- /dev/null
>+++ b/drivers/mmc/spacemit_sdhci.c
>@@ -0,0 +1,681 @@
>+// SPDX-License-Identifier: GPL-2.0+
>+/*
>+ * Driver for Spacemit K1 Mobile Storage Host Controller
>+ *
>+ * Copyright (C) 2023-2026 Spacemit Inc.
>+ * Copyright (C) 2026 RISCstar Ltd.
>+ */
>+
>+#define LOG_CATEGORY UCLASS_MMC
>+
>+#include <clk.h>
>+#include <dm.h>
>+#include <fdtdec.h>
>+#include <log.h>
>+#include <malloc.h>
>+#include <sdhci.h>
>+#include <reset-uclass.h>
>+#include <mapmem.h>
>+#include <dm/pinctrl.h>
>+#include <linux/libfdt.h>
>+#include <linux/delay.h>
>+#include <power/regulator.h>
>+
>+#define FIELD_PREP(mask, val)		(((val) << __ffs(mask)) & (mask))

Please use the one in bitfield.h

>+
>+
>+struct spacemit_sdhci_plat {
>+	struct mmc_config cfg;
>+	struct mmc mmc;
>+	struct reset_ctl_bulk resets;
>+	struct clk_bulk clks;
>+};
>+
>+struct spacemit_sdhci_priv {
>+	struct sdhci_host host;
>+};
>+
...
>+
>+	/* Wait for DLL lock */
>+	i = 0;
>+	while (i++ < 100) {
>+		if (sdhci_readl(host, SPACEMIT_SDHC_PHY_DLLSTS) & SDHC_DLL_LOCK_STATE)
>+			break;
>+		udelay(10);

Please use poll timeout.

>+	}
>+	if (i == 100) {
>+		log_err("%s: phy dll lock timeout\n", host->name);
>+		return -ETIMEDOUT;
>+	}
>+}
>+
>+static const struct udevice_id spacemit_sdhci_ids[] = {
>+	{
>+		.compatible = "spacemit,k1-sdhci",
>+		.data = 0,

No need set .data as 0.

>+	}, {
>+	}
>+};

Regards
Peng
