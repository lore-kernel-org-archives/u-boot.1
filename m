Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43075FF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 00:36:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9E878467C;
	Mon,  4 May 2026 02:35:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="OWjaJt+D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1530184679; Mon,  4 May 2026 02:35:04 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B71084671
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 02:34:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nFEEoMYrR907iL5DtltdPm1DMXjBMxUxYG2Cj7cLE2OgK9zA0x0mJ+rnZzM5raoFJLSScwHdNWecJok3G6rBoBo+ug4D8QvwGEzGqDeKw52v+Owa3MFyS2GrV9AHaY8oFkTgIw5+Flv15rL+8bKHOHvpMAXtT5n1DLabt4MhqEv2/LusmM1qZBPX8o3Ta+c8Ta7KY6tfOWZhvIKWrmAPSdeSeddVWzzzn5r7Lq5+I8/Q0VBLlkg3IOHLT4q25S7sEZJoSO3OZbbSM8NTAyzQVY0dUgRle+evSH7ewzuSGq/YD0GOWmArZB6AMb5ipM7+6mLe1JgPArB4h2KCdjofCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6a+/t+1ZPQb7rSwddvp5elEkCVPW+Vq1ha77zanakA=;
 b=CruvrB7W7iNFOmVDuSW0aFxX1y/cxhf7EArc11iI+TRCVknNgQ+clNzA4AI3VX0rEVdjt/e0PWjaTEVtK7J9hRKXIABe8YN/HMMd1BvZH2qoSPAZUupPwDDpmt8XlgnjYWhfDlyjlLbQkAsIuZBkHa4vAkLsqMvBFnyLUBvE5xahShfGHeQB1KGHJseup4JUztjYDTyq500puYdP4ywrnTVwnpXxfGRdSfW1nBBYTykPX74T+UPzRk+xCzeqeHyRABnptVNLgC2b2vkQRoj6GQwotJtT2MEqz90z0SGnv3xWJ2AFBYnqj0rtPN/9Jq6O1dJgRC1Dg4t8OXPWS8+lLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6a+/t+1ZPQb7rSwddvp5elEkCVPW+Vq1ha77zanakA=;
 b=OWjaJt+D7uEF7GLaSn1KCnNSoNTylFkQX7biT4Jfp8mwO2xH8/GJ5FDpw8pTwbiHmyLEiINfJs84tyL2ABwEn3SbYPUJ1e5UqnB85kuEu9dWNvkBTnOVDPEgIJ3HgSndEA+x1T35gf8TTgKBUUD67dG821M1MGGUarkaak1PBkeTies/YMzDbZxjPlk7VRTzUEaYgofW8m4JkW6AJKtnpCv6zSORflMYblv0Vg8GM3WeB4GZAZupzTWt2f7aclUJiZywfVgcG4Ueo5f/OHoAwYj3IR9R6AbRp88oiECliEW/g0ZPaPvric7tbpkgpFf3/huNNHPgLkA0KLDwlXAuyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from VI1PR08MB10029.eurprd08.prod.outlook.com
 (2603:10a6:800:1c6::15) by DU0PR08MB8662.eurprd08.prod.outlook.com
 (2603:10a6:10:402::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 00:34:54 +0000
Received: from VI1PR08MB10029.eurprd08.prod.outlook.com
 ([fe80::5e67:2d67:644b:9681]) by VI1PR08MB10029.eurprd08.prod.outlook.com
 ([fe80::5e67:2d67:644b:9681%6]) with mapi id 15.20.9846.025; Mon, 4 May 2026
 00:34:54 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Anis Chali <chalianis1@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Crt Mori <cmo@melexis.com>, Richard Genoud <richard.genoud@bootlin.com>,
 u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 7/9] configs: airoha: an7581: enable pinctrl/gpio support
Date: Mon,  4 May 2026 03:34:19 +0300
Message-ID: <20260504003421.2545713-8-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504003421.2545713-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260504003421.2545713-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00023A03.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::2aa) To VI1PR08MB10029.eurprd08.prod.outlook.com
 (2603:10a6:800:1c6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR08MB10029:EE_|DU0PR08MB8662:EE_
X-MS-Office365-Filtering-Correlation-Id: bb108723-e8f3-47a8-270e-08dea974f651
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: s3IW5uMStPM9o2UcGGpZA00P0wbMAGlAaCNvEkxEk5R0jLsCi/iuVmYTL3gFx5zkDqSEyFWhjOOj/+mdUNybZ31nguqvQR3NT2NweGJw/Of3gLa5o46cIPY/9tM84bU0HWGQwVZq1TJEDghGPu7OTIxQVl6hxEFZpZMwjc7WS52re2XEMPwtKyoVoMjl0JCya6mWPsssBVtEe9SU20+PPO5Br9Gm0WCjFXWMfsD9rb7KSRvAJtkaPLcAp0GAIJ+oiSPfgLXYp0VKkzaxRnNlHknbI5UpOsR5mbn5OKsnl92FDYFvgTArmgtaVQAwVWcR0Dn2LHjcuLAbCwMrW4AbxCM3aOkbAcz/sgivbpPrkODiEAh6srnkT8PRtmGJKQDvsUPozjpUKXwTRka/PQczQsZGCbs7kG6zfdSnuUB0pahV7ITWk9rdwbojsdGSgcYw43Pqpert5cq742lcjbC5ny7D6Mtz3/gYQjViRc3n7YT88WhB9mJL8w/rancuo+2KhDRf7aFaviQyzR/19m9iNtrKGqPmqmudsprMQSQTJiPbcDtLjqwom+9JgW6m5Px+9BuYcradsje2cL4ozllFniQZBoBlJaAUng5HHRkLDGThxIhB+io5PHZAztFsHOYsWfYaogpZa5P2WjFLAvUEhhMEosfxvfje88cb2S62mIXoCJITxI2ZOrATeR7nhxKtJ4IKe4yVEjToyvrBc4aZifclF9P6bLo3j3oKjn8pUNE4i8JIumK9k/kSTEgbTzfLCI35aSwfdrgLfm6HEwTzFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB10029.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014)(921020)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V5cAUNe8XDjSfr9IYPIZXGmERgXz/mBFvo8ZYcgaIinDCYN2HlL8UZnuoMMM?=
 =?us-ascii?Q?LsFYGNcugIY3Pqh7Cu5ihSsAx01runTTA2FvKgqrae978BwX6Vq4Zqsa1Sw0?=
 =?us-ascii?Q?le3ggJvg/7lZeTubFC976vYoHIm4CO5l06vbI7eunYj+jiatV/736XG9xsTS?=
 =?us-ascii?Q?RTOyLAI8yN1km12H+tkJobXgV+lklcmJXcpcAoiKekRT4ISDxHlzMWhDujE+?=
 =?us-ascii?Q?3/talX6thK3FiV2VbDyl5kvuh8MD7Wd0hIjw9hnlRQd9JRfNKnWKOAwynSgk?=
 =?us-ascii?Q?I/RpaLM6Hy4tCa7Q5Y6Bul/tUPUZQ2WdaNMxWvE2dW2Q68u1swNTIHbrdg8T?=
 =?us-ascii?Q?jEe2T/QbmjiFndRZ4q+pgknj4fAMRFClpjzHIEXHGb/TkfXiI+aYZZLo6Cgt?=
 =?us-ascii?Q?FMtuRXik+bAZvEvai52RZNOowWzhp8Sijufsu7ncn/S/RjdP5YQgvMML0IWF?=
 =?us-ascii?Q?mSAwjByWenY9dnopkjCI5HvIBWbfNRT5DnLv+BMhPtrauLt0Ik4SJR2k81Hx?=
 =?us-ascii?Q?/xzqtnUcPGNcxe0AKXTocgkKM+xSEWarCvu8vBfznUNaQ40HIKB2yW6UvuqT?=
 =?us-ascii?Q?YDbvbmMmTLnJkiqyaDWLn2SLd3h0ifdWrdfRMnjnogc4TcxtK49D35nsM82G?=
 =?us-ascii?Q?we11ztLditPqkfWUXPAlTrbCc45C75agnKk4nB6z1PGBxx10eFp0nz4/VEFt?=
 =?us-ascii?Q?QkLRIyAH24UVlzx60WWEqpD0m37bLpzn84XgF03SVKXAGzMimetADehP+DdH?=
 =?us-ascii?Q?ymJqdHowCc1AuXRTyzcDrkED6KrEnOSu2xZWN5zR6cqvZki3hf3bJEikIl0X?=
 =?us-ascii?Q?28ii0AkAjrv8ZNN6VO68nZLZKhRqsFO0W3IHpVbdIso0xyxOrT5y8oszmZGf?=
 =?us-ascii?Q?JBAFZxcJdRQ49aG4Fi66Zb9kGObrdOouTsnc0iS+RkrKVrzzVLVnVMGYFifC?=
 =?us-ascii?Q?x6BKeZpcDNYwY2ioKyIk5E2bttuz2KR4ixXm+SVrlVD1bjUGFbH6cwR1DoSY?=
 =?us-ascii?Q?7mHjTIh3Mi3C3MWhXt3KWoTpeGBYXR2OO25r1yvQ8VX2y96R/ZNTa8dLCMRy?=
 =?us-ascii?Q?lgEGZs4AS0BhLonj1j349xHpv8/QDz7JKN0RzNcX413k+XYo0udoky+nLKIr?=
 =?us-ascii?Q?U/+2odDfeIepwr14ibjP0v5DR4PJ12QKr1LCJoPst5F2VtAn8BeZWQtKJKYz?=
 =?us-ascii?Q?1LHvf2dlDDtNEVmmgEE3/M2Qo5OMkxBCOh5nrWls3VX1tsONZ7O6/WiwyAh2?=
 =?us-ascii?Q?PCg6LdZWv/JH4GIQJRXN+vBgn7KxXyOYSx4xATrmGpBe4WfpboV/nfw18KDK?=
 =?us-ascii?Q?8mRQFZ4oz4fqobGeQEWeWE5+3AcuPI9O6JRjGbBzTpDiUHwfu/LHAQMhZ7mB?=
 =?us-ascii?Q?w9gR/QcCb6vE8mOYEFXW/U/c895+Bz+m8OM1Qs4jHgVndel+5/L1dVcFUcU+?=
 =?us-ascii?Q?gt/hT7ExSYPYOLq00a5czW3D9IuNcsYr2DXidT5nRBiJn+MDsz+H6T+H+PKD?=
 =?us-ascii?Q?7P7pJWeU2gIfNTNzh+IhahYqcMEnJgc9dD6XX+c4WsewesM2jBOGs0Akbgmb?=
 =?us-ascii?Q?1sqestyg2nsSVbJ5hNl7ufDWqkjqov4vJgqE2BQbh8OOKwp/te1ll0nkx9/G?=
 =?us-ascii?Q?kwTQKxu4gwPH3DUXeKDajqvfVW1197OoYy1/kWXTxFp0VG0eiF0CAMNn/DYh?=
 =?us-ascii?Q?TkGFfhH/JfxIL9HCRqBTJhdY80E9jfWTnBTSn8FphCCRofxI+2aa4jAKW/Tp?=
 =?us-ascii?Q?qRzmJNR2U9s/wAXw2E2eOSFEi92ok0w=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: bb108723-e8f3-47a8-270e-08dea974f651
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB10029.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 00:34:54.8850 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DECpkEqxqRHW7zkNPXH77oYplC9sMNs6TPj6+7HdXO7zXGd8e4wTWeMIkwVUxwkvY6JSx0MyZ3udNcp6iQN56dA2SSENZeqWJZFkgsJXUHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8662
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

This enables AN7581 pin controller and gpio driver.
Defconfig was minimized with 'make savedefconfig'.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 configs/an7581_evb_defconfig | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/configs/an7581_evb_defconfig b/configs/an7581_evb_defconfig
index a94730cf564..eb9623d6b47 100644
--- a/configs/an7581_evb_defconfig
+++ b/configs/an7581_evb_defconfig
@@ -46,8 +46,6 @@ CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SYS_RX_ETH_BUFFER=8
-CONFIG_REGMAP=y
-CONFIG_SYSCON=y
 CONFIG_CLK=y
 CONFIG_DMA=y
 CONFIG_LED=y
@@ -67,12 +65,11 @@ CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_FLASH_MTD=y
 CONFIG_DM_MDIO=y
-CONFIG_AIROHA_ETH=y
 CONFIG_PCS_AIROHA_AN7581=y
-CONFIG_PHYLIB=y
+CONFIG_AIROHA_ETH=y
 CONFIG_PHY=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
+CONFIG_PINCTRL_AIROHA_AN7581=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
-- 
2.53.0

