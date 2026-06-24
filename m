Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A8ACDE000
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 08:12:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5308849BB;
	Wed, 24 Jun 2026 10:12:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="LCH4Lk6s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3B05849C5; Wed, 24 Jun 2026 10:12:42 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9852084995
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 10:12:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ew8ZsMd28DJIbhA/snAHztChy8Rgfb6seevA3ZbwwefLgRQyWph7VFDjgC8FZBejQjs3L7Nkvt0XXPSdWzZe1UXa14AXcwS3V0NWEO+yzwpRQVe7Rtun8jmg9s1NoaY2Nc+6jWuvvvEaXegmJ6RHbv2Gx5Pez2mw8t+xQfs1dTKIEQ2wf52EUs0zyMByxhALlFxzCvtCE+aZGPoKoVMNgPGGW6SElhWE7UXb25Q5zCyE0wREFIjUGTUoXypJmyvgcR3Lw1r3K81Bcz35gBzAOJcLENM5MeLIq6dIqVaAwcze7+apjnDslyb4OR/qqiuR2nrELRPIrFwcPqEGsTEKHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11SqeTWZM0ZEGd4gaPQJc9/i+/Eg+eF2e3fDXvK5Tsw=;
 b=nHag5zu9/0JB/pj16wNLW+Hwiy92AeeTC5KdUz6N4cIB7cO5haNSORr5gd0mk0cGUXkFRMFe7X4sJyvLWtTOVh4hidLGJweMaZRJYlqsKUUIJLF7eW2fG9kr7vQnKI9n1tsbA6u3YmoUbniGRWyKJp+VnGDxhpvWovUbXmsIGgnujxzp+6UMRPzr+/yNlgZCf1SDbkgyMDu/uF4qmGfyOFk01rcoGWCDbGYhfLJs07Y6vtsrfUADDZ7iEJiNn9QbuRtHkuIDXwp06h51Qd2Pr9UmJl52x396Y8o36CVomov++lwVVKPxKZX5gY8LGSBHtA/keGUpEt4netxLbIIHgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11SqeTWZM0ZEGd4gaPQJc9/i+/Eg+eF2e3fDXvK5Tsw=;
 b=LCH4Lk6sHF/YEqNIL+NTrRDITPE/yVE0WbgsIL6I3A51RExBS5eHMwchMfudtc2thHon0S0ek0zLM+iD/HUBBdWFklKlFiiecWpAKFP6fNAvKPtoOmJeIKofWUOGBzcfd86z1jXqn/cAepWSnxEaM6Iy6UxfF0gfMUtUT+cnRFQT+XxWR5+wa6M/inNWULYqkx92EvrL1pBdTog61pkmOGXSp1H376/oztwwS32Qe/UPLjNVT4pZtvktap9DF15bBc+zHkLPff9OcqqSXrofvckBY7PtM869WNXaaDlwtIV2QTEymQPkutqmdVHFwQkRuDQsIPnJ/P+Do6lxUZJR2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by GV4PR04MB11402.eurprd04.prod.outlook.com (2603:10a6:150:295::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Wed, 24 Jun
 2026 08:12:37 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Wed, 24 Jun 2026
 08:12:37 +0000
Date: Wed, 24 Jun 2026 16:15:57 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Raymond Mao <raymondmaoca@gmail.com>
Cc: u-boot@lists.denx.de, uboot@riscstar.com, u-boot-spacemit@groups.io,
 raymond.mao@riscstar.com, rick@andestech.com, ycliang@andestech.com,
 trini@konsulko.com, lukma@denx.de, hs@nabladev.com,
 jh80.chung@samsung.com, peng.fan@nxp.com, xypron.glpk@gmx.de,
 randolph@andestech.com, dlan@gentoo.org, junhui.liu@pigmoral.tech,
 neil.armstrong@linaro.org, quentin.schulz@cherry.de,
 samuel@sholland.org, Guodong Xu <guodong@riscstar.com>
Subject: Re: [PATCH 2/8] mmc: k1: add sdhci platform driver
Message-ID: <ajuSPftsQnAQdzBD@shlinux89>
References: <20260612201901.73657-1-raymondmaoca@gmail.com>
 <20260612201901.73657-3-raymondmaoca@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612201901.73657-3-raymondmaoca@gmail.com>
X-ClientProxiedBy: MA5PR01CA0068.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b7::7) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|GV4PR04MB11402:EE_
X-MS-Office365-Filtering-Correlation-Id: b49a6cfc-d2d1-41f2-e911-08ded1c85a6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|23010399003|1800799024|376014|7416014|6133799003|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: waHQ/TueNhumpltKyzrRSkRGPnVq2V71snOAmPsER6vIS5fA8qDJLXJoeX4P3SFmsrWpvp8FrqTYgq9Ukln2yPexbxvfLbIwVKnaN6A2F4tK7cXOLvjzZCFG2+pvhkIHo29xMvH7yvCvi5vvwZ+PJPH8RSBqDkiWd8I7r5Xv9GEMoS9BJWZSszsFEYjrJZ7cyBBJT7lkOeMmqzklBK/tJJLwALVoI4HlC08Rww5653NaDqbGp1zDGyNWiobzKvGROCrmQna3FK9pItyCe4C9Zufo5Rl+/aTVpMVLrBw0SJAJ8Gp3sAfojgQ8i2/Y7bN3f+Gf7T20asUR/rW6Hv7L0OUfPyjiHRXh2Kwecr+8BZnYZi1pJscm/G9Kll+ckXcVQ+3HZ01p3wwuc2G17JPMwTZFraDe4QkIgtEs3tueOSX5GBUlRSiMw+k7C1QHhIcBseMW3GtmP8t/094s8Jnk9P8iZ17oZ9KDtnVrPL34BKG5w5FsedFLTwYFZcSGx92cnMf+6zEeINpdRpZNAEVl+OhCczsJk5KV2K7BdaanIRb4fKFcFlfF06EkeSYUV4xsQsb0sDiJzvCa2L8w0dEjHafeCgL0eyKlxBE1XARAufzxjL3qK3tuMOIIuoK1AhvAX/COIaDkdB9SNMWaFuuIJIcDkRFBJmjXbCzNFidKdOo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(23010399003)(1800799024)(376014)(7416014)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CViLDdh1lp/TW7DyP5MZsiDLXoYiBzKr063JXumo3SUc1xWASBf6jlFpsCuO?=
 =?us-ascii?Q?R9HaPYmEAHy/jmFozaErW9608HDXaUtZcO0kr4MnNn9w0zCqODgwbP5K4fgc?=
 =?us-ascii?Q?pXov8VK3lrgRK6T6LvyyZ7RR/RqPKGaCxckG8066OlC8IRo/mt4arwtFMK3y?=
 =?us-ascii?Q?lyUmyBI1AmJQVVI4fGR1fg2UVT8y+Ws1EwA3+psm0hoe0Daa9/vANsuIZtpW?=
 =?us-ascii?Q?R23qe9+rfGHblaZsZB+v/5lWRAU5f2Gu9YqTtEFBlhKqQqES2LCS7Y3ZmDcl?=
 =?us-ascii?Q?WIXzcD/30E5N+4SqyznpuzN/LF+ww9mzS6+JecFJ7LYTHwh4G+W/CyhzmnRq?=
 =?us-ascii?Q?jSICd8KdgE7YlnGgiAATg930MvfGcI1JdBfO9obPZwwTUb3Ko1j50g0isiAe?=
 =?us-ascii?Q?FZUWf1pC6P6+IcWTUGKrTtrFQP0vBIOAKTZloVLZVUlhVxwr+SoWk2LHfsCx?=
 =?us-ascii?Q?gNC84sCEfkKVRihvXKZVmS1OfjN4xAiiS01rt1ifWxd25ss56x2U5UqgsGzY?=
 =?us-ascii?Q?6OtCh3R2G3Of0HxxpqYdlXE428X1tF4ttT4HkJgC9RGWDxEb25QBodhxACrr?=
 =?us-ascii?Q?Dymsm2hgbp5GqwJLv14BuU0Ve/gVEMCtJX5wz1L3qfOpeauO5dKuRUhkg1SM?=
 =?us-ascii?Q?QGUdcJzaamqD8N8htptm8m05vfidKk3+cGuWV8nlaTP78eUCU98JcSjpk/ou?=
 =?us-ascii?Q?bbnRNvS5z6UkUDjJDLOa9P/1XkuFLk65pgJspDTYWHCEeE+9ir0NioeHGyWL?=
 =?us-ascii?Q?Rqrku6SB90kPyAAWRaIJzrLuS4WO7zvTz1ZnsnX7uhNYoUtqV3YvlPIjlpZI?=
 =?us-ascii?Q?SbJIytxwbIREOiamempk5caeUC4WogiDNC33ItPg20J584FIv1wN2gUIPXJg?=
 =?us-ascii?Q?4ZXy7Z8l5dF5Vd05Q+47so7i4ZbtEkV/oMMqo1fy/so6ijOXf1KSPCpulF4j?=
 =?us-ascii?Q?eGtx2WrsHeI0NLphk/AxiH0By/zjLxITUwoLrX/KgyyG0xOLihP1qfcBHGml?=
 =?us-ascii?Q?04+lMB9dfD/XF12ppAhrzfMJ1cdDSseLZ9iK1i+F9C2xXF3nrmUDZrOD7Bha?=
 =?us-ascii?Q?D9PeEeu9gdfxzl7fH/ttFTKXrzV8Lt9scwnfNDeDOLJatK96so02KMqyfixW?=
 =?us-ascii?Q?+EQu9/XLY/mXGb0G4FjKE/LGOTpQbOMh0+1Wuztjy2al06Xw2Pe7U/SgR+5g?=
 =?us-ascii?Q?6HC13EXGc76RD0am2uuaP3MpId4LqBl3wmr6YGV2Y4DcVW3GpTNpGdJwErFM?=
 =?us-ascii?Q?0PGP1E7Z8D6RA8+SQxy+YqwiJh2IzSIkTdxSn4xvsLjp/fFWh2RKI8+9I60B?=
 =?us-ascii?Q?IPbEtGMzVgf3xhWqec67NAt0YGxZEiqvveQ+Se1YTxA/ICAdHg98CSmRDvT8?=
 =?us-ascii?Q?LUsY8KL/omQt/raf9U+WFA4es4gh2u/mIAzDCV9z6ACXnzTan7h3PYeHc9x+?=
 =?us-ascii?Q?Wr69cFZfDV1gQ07F1TgiRJUSBxUAhrk5Uu/z7/W2aIO0Sce8Rp38wNKzagak?=
 =?us-ascii?Q?esKLdivje8X3IIP/rv+XSERtRd2LHMLW0//0Gep0K/rMk/js3yWaVXY1CEAL?=
 =?us-ascii?Q?TgmEyowCqXoYZRsj98G8AR2YuRgXZ3GSfLSyCSjf9W3LprZw+zgeBlQY+51h?=
 =?us-ascii?Q?Y0HjVcFBbaNjXL73CpZaeUBd2/48Q977X3GtcG1vZ4sHTEE8OvQ/30ro0gXp?=
 =?us-ascii?Q?KDXScNZWCsVJHVhFGobx9NlmT1SWVZsOWoH81HjIKFlkBdeawzjTqS/pPOhO?=
 =?us-ascii?Q?ptyAKcyP0n28ht56VWWKnDJ+MQ1nepSq4sVBU5RcpzttpwXKCx7F?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b49a6cfc-d2d1-41f2-e911-08ded1c85a6a
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 08:12:37.5312 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nP478qlatFs0r9/SwXrcUlVBNhInSPMOqyfZpBc7aPvR/nIwcj+V9yVdukaHgzhwW/DFFxfeAU6WuWxGMxoXOiZOREyWJl45C+MXDLxJBVc74ZNwfeMSdUSNHLuL4lyG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11402
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

On Fri, Jun 12, 2026 at 04:18:55PM -0400, Raymond Mao wrote:
>From: Guodong Xu <guodong@riscstar.com>
>
>Add SDHCI platform driver support for SpacemiT K1 SoC. This driver
>implements the necessary platform-specific operations for the SDHCI
>controller, enabling MMC/SD card functionality on K1-based platforms.
>
>Signed-off-by: Guodong Xu <guodong@riscstar.com>
>Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
>---
>+
>+#define LOG_CATEGORY UCLASS_MMC
>+
>+#include <clk.h>
>+#include <dm.h>
>+#include <dm/pinctrl.h>
>+#include <fdtdec.h>
>+#include <linux/libfdt.h>
>+#include <linux/delay.h>
>+#include <log.h>
>+#include <malloc.h>
>+#include <sdhci.h>
>+#include <reset-uclass.h>
>+#include <power/regulator.h>
>+#include <mapmem.h>

See doc/develop/codingstyle.rst regarding "Include files"

>+
>+/* SDH register definitions */
>+#define SDHC_OP_EXT_REG			0x108
>+#define OVRRD_CLK_OEN			0x0800
>+#define FORCE_CLK_ON			0x1000
>+
>+#define SDHC_LEGACY_CTRL_REG		0x10C

Not used.

>+#define GEN_PAD_CLK_ON			0x0040
>+
>+#define SDHC_MMC_CTRL_REG		0x114
>+#define MISC_INT_EN			0x0002
>+#define MISC_INT			0x0004
>+#define ENHANCE_STROBE_EN		0x0100
>+#define MMC_HS400			0x0200
>+#define MMC_HS200			0x0400
>+#define MMC_CARD_MODE			0x1000

Use BIT(x) and GENMASK for register bits, and other places.

>+
>+#define SDHC_RX_CFG_REG			0x118
>+#define RX_SDCLK_SEL0_MASK		0x03
>+#define RX_SDCLK_SEL0_SHIFT		0x00
>+#define RX_SDCLK_SEL0			0x02
>+#define RX_SDCLK_SEL1_MASK		0x03
>+#define RX_SDCLK_SEL1_SHIFT		0x02
>+#define RX_SDCLK_SEL1			0x01
>+
>+#define SDHC_TX_CFG_REG			0x11C
>+#define TX_INT_CLK_SEL			0x40000000
>+#define TX_MUX_SEL			0x80000000
>+
>+#define SDHC_DLINE_CTRL_REG		0x130
>+#define DLINE_PU			0x01
>+#define RX_DLINE_CODE_MASK		0xFF
>+#define RX_DLINE_CODE_SHIFT		0x10
>+#define TX_DLINE_CODE_MASK		0xFF
>+#define TX_DLINE_CODE_SHIFT		0x18
>+
>+#define SDHC_DLINE_CFG_REG		0x134
>+#define RX_DLINE_REG_MASK		0xFF
>+#define RX_DLINE_REG_SHIFT		0x00
>+#define RX_DLINE_GAIN_MASK		0x1
>+#define RX_DLINE_GAIN_SHIFT		0x8
>+#define RX_DLINE_GAIN			0x1
>+#define TX_DLINE_REG_MASK		0xFF
>+#define TX_DLINE_REG_SHIFT		0x10
>+
>+#define SDHC_PHY_CTRL_REG		0x160
>+#define PHY_FUNC_EN			0x0001
>+#define PHY_PLL_LOCK			0x0002
>+#define HOST_LEGACY_MODE		0x80000000
>+
>+#define SDHC_PHY_FUNC_REG		0x164
>+#define PHY_TEST_EN			0x0080
>+#define HS200_USE_RFIFO			0x8000
>+
>+#define SDHC_PHY_DLLCFG			0x168
>+#define DLL_PREDLY_NUM			0x04
>+#define DLL_FULLDLY_RANGE		0x10
>+#define DLL_VREG_CTRL			0x40
>+#define DLL_ENABLE			0x80000000
>+#define DLL_REFRESH_SWEN_SHIFT		0x1C
>+#define DLL_REFRESH_SW_SHIFT		0x1D
>+
>+#define SDHC_PHY_DLLCFG1		0x16C
>+#define DLL_REG2_CTRL			0x0C
>+#define DLL_REG3_CTRL_MASK		0xFF
>+#define DLL_REG3_CTRL_SHIFT		0x10
>+#define DLL_REG2_CTRL_MASK		0xFF
>+#define DLL_REG2_CTRL_SHIFT		0x08
>+#define DLL_REG1_CTRL			0x92
>+#define DLL_REG1_CTRL_MASK		0xFF
>+#define DLL_REG1_CTRL_SHIFT		0x00
>+
>+#define SDHC_PHY_DLLSTS			0x170
>+#define DLL_LOCK_STATE			0x01
>+
>+#define SDHC_PHY_DLLSTS1		0x174
>+#define DLL_MASTER_DELAY_MASK		0xFF
>+#define DLL_MASTER_DELAY_SHIFT		0x10
>+
>+#define SDHC_PHY_PADCFG_REG		0x178
>+#define RX_BIAS_CTRL_SHIFT		0x5
>+#define PHY_DRIVE_SEL_SHIFT		0x0
>+#define PHY_DRIVE_SEL_MASK		0x7
>+#define PHY_DRIVE_SEL_DEFAULT		0x4
>+
>+#define MMC1_IO_V18EN			0x04
>+#define AKEY_ASFAR			0xBABA
>+#define AKEY_ASSAR			0xEB10
>+
>+#define SDHC_RX_TUNE_DELAY_MIN		0x0
>+#define SDHC_RX_TUNE_DELAY_MAX		0xFF
>+#define SDHC_RX_TUNE_DELAY_STEP		0x1
>+
>+#define CANDIDATE_WIN_NUM		3
>+#define SELECT_DELAY_NUM		9
>+#define WINDOW_1ST			0
>+#define WINDOW_2ND			1
>+#define WINDOW_3RD			2
>+
>+#define RX_TUNING_WINDOW_THRESHOLD	80
>+#define RX_TUNING_DLINE_REG		0x09
>+#define TX_TUNING_DLINE_REG		0x00
>+#define TX_TUNING_DELAYCODE		127
...
>+
>+static int spacemit_sdhci_send_tuning_cmd(struct sdhci_host *host, u32 opcode)
>+{
>+	int err = 0;
>+
>+	err = spacemit_sdhci_send_tuning(host, opcode, NULL);
>+	if (err) {
>+		log_warning("%s: send tuning err:%d\n", host->name, err);
>+		return err;
>+	}
>+
>+	err = spacemit_sdhci_tuning_pattern_check(host);
>+	return err;

return spacemit_sdhci_tuning_pattern_check(host);

>+}
>+
>+static void spacemit_sdhci_clear_tuned_clk(struct sdhci_host *host)
>+{
>+	u16 ctrl;
>+
>+	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>+	ctrl &= ~(SDHCI_CTRL_TUNED_CLK | SDHCI_CTRL_EXEC_TUNING);
>+	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
>+}
>+
...
>+
>+
>+	/* Enable DLL */
>+	reg = sdhci_readl(host, SDHC_PHY_DLLCFG);
>+	reg |= DLL_ENABLE;
>+	sdhci_writel(host, reg, SDHC_PHY_DLLCFG);
>+
>+	/* Wait for DLL lock */
>+	i = 0;
>+	while (i++ < 100) {
>+		if (sdhci_readl(host, SDHC_PHY_DLLSTS) & DLL_LOCK_STATE)
>+			break;
>+		udelay(10);
>+	}

Use readx_poll_sleep_timeout?

>+	if (i == 100) {
>+		log_err("%s: phy dll lock timeout\n", host->name);
>+		return -ETIMEDOUT;
>+	}
>+
>+	return 0;
>+}
>+
>+static int spacemit_sdhci_hs400_enhanced_strobe(struct sdhci_host *host)
>+{
>+	u32 reg;
>+
>+	reg = sdhci_readl(host, SDHC_MMC_CTRL_REG);
>+	reg |= ENHANCE_STROBE_EN;
>+	sdhci_writel(host, reg, SDHC_MMC_CTRL_REG);
>+
>+	return spacemit_sdhci_phy_dll_init(host);
>+}
>+#endif
>+
>+const struct sdhci_ops spacemit_sdhci_ops = {
>+	.set_control_reg		= spacemit_sdhci_set_control_reg,
>+	.platform_execute_tuning	= spacemit_sdhci_execute_tuning,
>+#if CONFIG_IS_ENABLED(MMC_HS400_ES_SUPPORT)
>+	.set_enhanced_strobe		= spacemit_sdhci_hs400_enhanced_strobe,
>+#endif
>+};
>+
>+static struct dm_mmc_ops spacemit_mmc_ops;
>+
>+static int spacemit_sdhci_probe(struct udevice *dev)
>+{
>+	struct mmc_uclass_priv *upriv = dev_get_uclass_priv(dev);
>+	struct spacemit_sdhci_priv *priv = dev_get_priv(dev);
>+	struct spacemit_sdhci_plat *plat = dev_get_plat(dev);
>+	struct sdhci_host *host = &priv->host;
>+	struct clk clk;
>+	int ret = 0;
>+
>+	host->mmc = &plat->mmc;
>+	host->mmc->priv = host;
>+	host->mmc->dev = dev;
>+	upriv->mmc = host->mmc;
>+
>+	spacemit_mmc_ops = sdhci_ops;
>+	spacemit_mmc_ops.wait_dat0 = spacemit_sdhci_wait_dat0;
>+
>+	ret = clk_get_bulk(dev, &plat->clks);
>+	if (ret) {
>+		log_err("Can't get clk: %d\n", ret);
>+		return ret;
>+	}
>+
>+	ret = clk_enable_bulk(&plat->clks);
>+	if (ret) {
>+		log_err("Failed to enable clk: %d\n", ret);
>+		return ret;
>+	}
>+
>+	ret = reset_get_bulk(dev, &plat->resets);
>+	if (ret) {
>+		log_err("Can't get reset: %d\n", ret);
>+		return ret;
>+	}
>+
>+	ret = reset_deassert_bulk(&plat->resets);
>+	if (ret) {
>+		log_err("Failed to reset: %d\n", ret);
>+		return ret;
>+	}
>+
>+	ret = clk_get_by_index(dev, 1, &clk);
>+	if (ret) {
>+		log_err("Can't get io clk: %d\n", ret);
>+		return ret;
>+	}
>+
>+	ret = clk_set_rate(&clk, plat->cfg.f_max);
>+	if (ret) {
>+		log_err("Failed to set io clk: %d\n", ret);
>+		return ret;
>+	}
>+
>+	/* Set quirks */
>+	if (IS_ENABLED(CONFIG_SPL_BUILD))

CONFIG_XPL_BUILD

>+		host->quirks = SDHCI_QUIRK_WAIT_SEND_CMD;
>+	else
>+		host->quirks = SDHCI_QUIRK_WAIT_SEND_CMD |
>+				SDHCI_QUIRK_32BIT_DMA_ADDR;

Regards
Peng
