Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C10C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 05:59:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 571A884CAB;
	Thu,  2 Jul 2026 07:58:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="icSSun8J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53AE484CB2; Thu,  2 Jul 2026 07:58:35 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48C8284CC2
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 07:58:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GazaHwJr2n82riX+/7Cw0QLGAr5/VJ0nG94lKhNGeEXUEqA5VTRvzQytIz7eFYwqDdunq6G0C6Kzz2qCHDU0WNeHeabpigIsvzclYC0LDS7KR9pou3lNfd5v28vbz1f2Eb3nQhjRcYvZe7n6zAbrECgerdMFXS0wd7rSkqdRYXwZ2CKc1x7TGuhIywjeaDpTKPEr2W0ObPHrwb8jmuwfVaLcd4hNfDVxDU9SY2DUe/Wlu1xAKwpgocriIFOWWH1IdpiPIow8+mi0eBlrEUZKiJrZ0XGUE+uyOd5mqOPb9ZM+mmFcZBF7vo7wP7xr64nm3h4quX2EuQPyKraqXUv6eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ow5YaK+fGlzYgUVwxCmSj6Eb4wxCzWsOWpTum8nnnK0=;
 b=tyijBRnVI18g0e7olju0JgMQk9GMqX9vL79Pyp4wpR/POT0WiljoELESk/K8QF9czonbWTrBIXfND9/ZDZWQM+91u+XI4vFPPDgyPV7OXTIF/QYSjrT1xVjEqUZsBet2hBIu4niwrkoQjV0XU3y1X99Nmkw3XQZK+hGmANWpEZoOgUAx2/AvQv4HPSn/diIoVEYFEHKsgN/f4xn2ub27YuWsE/9wAOdf9fwWnRbQbP4fH1LO4xVGHFwN6FcjXhaW+T7DvKaMqJ9l302rWgckDBINFiDTWk3hjncTEfFzjavYLUGOg5km1pyAmjxw2hiFykt6loac5sf27TkPnWZ+BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ow5YaK+fGlzYgUVwxCmSj6Eb4wxCzWsOWpTum8nnnK0=;
 b=icSSun8JP5AyDud7p6JlbQRWNNuPgFK7XObNnTIkQDpoceWx7V5pzZfzGLaVyWYnfJUOGSMbjv+BU999sPvEbalkwLj/jKWU3oiuiz1OKM+5qbZ4saeQrZSzsuoNOzhz2CUQXacgys1Gs7XhUnqOF9SzBXDwe2wY1em7kwtWROTSGhWUMzFvPuLB5WUvnyd2H8wdUmdmyFYrzvnmaJrojHdkBLgyJFOSLDUpvsI5hq6nKFcCum9ID1v6ed7nnW4Wj+ly7Jub/qV9ZVRIbYKjvmOii9RJZZ+nDA2PFpgilJmzzNmHahSlUIjfdTxDTxhSB7bkv01SUqrXWpcD3mTjsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PAWPR08MB9543.eurprd08.prod.outlook.com (2603:10a6:102:2f1::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 05:58:25 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0159.018; Thu, 2 Jul 2026
 05:58:25 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Stefan Roese <stefan.roese@mailbox.org>, Simon Glass <sjg@chromium.org>,
 David Lechner <dlechner@baylibre.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v14 12/18] pinctrl: airoha: add shared pinctrl code
Date: Thu,  2 Jul 2026 08:57:38 +0300
Message-ID: <20260702055744.2164975-13-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702055744.2164975-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260702055744.2164975-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::16) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|PAWPR08MB9543:EE_
X-MS-Office365-Filtering-Correlation-Id: ce9d6b4f-7f5c-4a91-c432-08ded7feee3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|23010399003|1800799024|366016|18002099003|56012099006|3023799007|11063799006|6133799003|921020|38350700014|22082099003;
X-Microsoft-Antispam-Message-Info: MeYcWliJ8TM4LIhf7T9Pq5peIpJhuCqcQWiWSVdxiUNLQEz6GXhLDOQ0g5fKpgLF/tle7DmAjUnOIy6lZmiMbiblk4jXg9Kvhx3eStPZPLvhc4z7i9Llf9qTgbXH0Gg4habdc7JVAaoMUBUo9QeI9HIiZU/cZBdWJgwoMiD9Q2ovJZO/Qy6DFGopEQSecmgB9dstyO5rwSYiUPNeXfVM6SR4fJvjo7MMflcjFJ2zLIrtHfTaHzQ+YHAHp9m3im5ESXTZwc3sJZiF02jOSvf8SXaq/ARQ6gPkzTPSr7MyWKbMbD2OVjyveSSiAEwQL+4mfXd/AliykzUtFsqAkfmXoQ8uHwQXpOACfe+Z2EJ9kcSPhLe8M+g8XJ6RhOtCMutAhF4MGPfHEkLAbFBBz/kLtGtYe/yzTPHGwVtfThKTP+3VslbdMZjBXsgCPKonW67CgO3tNIRl9KEH/3Y9XaLuKwHp+C5t9nok/Bx1fOVkLT9iKGKHDM8tiEf30ehSTl5cImdkIQf0agAaehMW+d0y0KEwLZM3bJIm3SFDGGCFzF+RLWmhYWPAU48V1J7Of80slGuUNcQBMpNcGStgqnDORYfLHEF6LTHroHCUn2BbhQ1kMb/FHBtDv0A9Y6JI3EU/q4+BzYjyGFx29J0X5HvTkQl1DSHPSCYV6nKt2+Nz/0q3id4MrsEfo0asV6ZqURFl9T2crDy6zWt021BFu9qOsuSHuY77Ln8vPG0XDV+wfakYE1Yvd7HJp1w+Xd+cOLK8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(23010399003)(1800799024)(366016)(18002099003)(56012099006)(3023799007)(11063799006)(6133799003)(921020)(38350700014)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/DZG7WZGBWIe94d/7Mfvmqd6eTUF/4xCtmdoxVvvrUCEOcZUT455pIgUfagp?=
 =?us-ascii?Q?BEckV6yewIfFwgBxsDMZ+wE5umPdMf919tM7RUCkycSGStGW2oJ0uzaCBelC?=
 =?us-ascii?Q?M27CmBYZ3DFFMqeSDP8SRPxLI0c9zvMpCtvD2lggn1wShEgVl6ZKWmsGtXmX?=
 =?us-ascii?Q?P6HZUuwHMGN/UpkcKxV825PTSHO6nNXf1PCqMiByOK+Xhax1CccIgPip2LZG?=
 =?us-ascii?Q?EYcs26UwUEaheZ3nMIp6v5YBQ16pQoALCGh4uVcTaFCcCdc2ZTMx/JTNw5rI?=
 =?us-ascii?Q?ov69HaXop6rsK250JCwRy7OyOAN4/fSpSJxRZP+ycOsN3Tyz5LRLXzrInh9c?=
 =?us-ascii?Q?jwoytSeKMWXUlrEp+F9D8AlumroQX1FDgpf+md8knghgVcm/Bse6rqd4lHF/?=
 =?us-ascii?Q?UexRBMMxX3+3sjqxYQ9n3Pbknf7LBiX0AM0rPkUR7CLilHs4NUIlcDr/EeuX?=
 =?us-ascii?Q?Iu3vf9j9LeIH4cYtTlsIN1juaQoOFDWhmBhflcTYAO3L4QTP6Fx9lRaD5eS/?=
 =?us-ascii?Q?ekd/L32zD2luBgLr5jJrBli4Lsuxs4Hmvv/k7Ovp9jlpb6R0xk6E9BQtbzRv?=
 =?us-ascii?Q?PJWiPa+KVG1T3DOWe2iWtIY3NKI9ia/mc+6RnYWDZaXgkqmxaORWNfpPIdDu?=
 =?us-ascii?Q?0rTAG75ZUkNSAKYAHdyrtqRKesN7q20fxZ8cCowJ0aX5i6oUIynrLliQgryN?=
 =?us-ascii?Q?OYH/OUW0icqw13FdpBEdHpAthDxvh/LMmPdyzxaixQaNDfYNP5umPwZxp2Ui?=
 =?us-ascii?Q?N+OplkElRL55dur0pR3Y9KYDeKA9vsi5axhG8/T/x+vnD8iKaE0sJWuJUQZv?=
 =?us-ascii?Q?h4vN4UoFUIV449/19nNveEH0dOAnRxIQbDOf0GPOSmpOIGeCyuuuvLTNCH1s?=
 =?us-ascii?Q?FdGOMcQjBSIJgbcScRQyWij3HC3kjfnkKATJP2ObFv8aArDpSftpnrCGUVdv?=
 =?us-ascii?Q?7t3y4Ii3DbUrhmOWdNJN/9ZUy78E1uX4zIZArYoynEwe+M+dK0Py27ZPMNWs?=
 =?us-ascii?Q?A1QZn4hFTOLB6WB3CtB0j1Oabac7SLrDVkEk5kfKfqDw8h9SXsCq/BfAJ7Ds?=
 =?us-ascii?Q?+67ei1Aoe+BuPqWNgMQaLi72eA/A3eFn2o4DaznXUH4jQ7zMfYWYuWRzVw/I?=
 =?us-ascii?Q?kNLNIsnt4J/Tk4//vT5YJFHs6VrjSb1dxvTh3Y56y3ko8xZc2assegseC781?=
 =?us-ascii?Q?qBXBEd15QNfrbgH+hjAeIpDhzq370WdoiEFdb9K/uzY66l8mLUB3RhGH9/uZ?=
 =?us-ascii?Q?+HS+XK0DwzChxobbeUCIY/Vl+kc9+z+h4hvlvMUUTUD75SkNEI9736MaAa5j?=
 =?us-ascii?Q?v4w9zlvz322MnJCIc9JnL6PpzzErcEy+8PEItHZ36Rf/LNAqrrNZ8aDN7GbE?=
 =?us-ascii?Q?8TIE7SU+al0TQ9yB1UtizsBAdbwhEpQ037i4BSZFjJbdQnHdGbUkcVD9kc+E?=
 =?us-ascii?Q?DUdiCvfWSXC5IcMhJI1J+MpgLYv5rvIrD36euzmSZQVcbLOyCwzVjtkv52BV?=
 =?us-ascii?Q?0zdqo4kiWTfkRXEWmnmtjN0qbAJAmygdFigauF6GNyXM4JvFGSravaVBkGhv?=
 =?us-ascii?Q?g3/qy5vDrwdcqZTEVmXDIXB2lWMDMsmwLDyvIuzdP0GjxJ4GhwKCE9q9eTFq?=
 =?us-ascii?Q?4ghG1fZ78w/5/kznMDkxZx5RDlv9UWNAqDhTxUxRJzjiYwilsqZ/KaKWFdCi?=
 =?us-ascii?Q?2Pi6L3EJn90IfcmAY+ZH9c2aXSpm4T+lBQ4vsyRofnICwbBAVLg38lOEDEWi?=
 =?us-ascii?Q?/k3hWFY4JVRpSEW/3tZTrIcjD1Mqv5c=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ce9d6b4f-7f5c-4a91-c432-08ded7feee3b
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 05:58:25.5011 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IUDyNLjJi4arhOs0wxlSaOn0JkkD84JbdaRXYa2nR0x/CzeBX0i6xyUZRVf4Ca2E3kBqZvMC95XVVDqt8DWLJs5fww9cI49T6DBIo13ezbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9543
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

This patch introduce shared Airoha pinctrl code.
Also it sorts contents of pinctrl makefile.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
 drivers/pinctrl/Kconfig                 |   1 +
 drivers/pinctrl/Makefile                |   1 +
 drivers/pinctrl/airoha/Kconfig          |  11 +
 drivers/pinctrl/airoha/Makefile         |   3 +
 drivers/pinctrl/airoha/airoha-common.h  | 144 ++++
 drivers/pinctrl/airoha/pinctrl-airoha.c | 958 ++++++++++++++++++++++++
 6 files changed, 1118 insertions(+)
 create mode 100644 drivers/pinctrl/airoha/Kconfig
 create mode 100644 drivers/pinctrl/airoha/Makefile
 create mode 100644 drivers/pinctrl/airoha/airoha-common.h
 create mode 100644 drivers/pinctrl/airoha/pinctrl-airoha.c

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 578edbf8168..46a95a1ab6b 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -405,6 +405,7 @@ config SPL_PINCTRL_ZYNQMP
 
 endif
 
+source "drivers/pinctrl/airoha/Kconfig"
 source "drivers/pinctrl/broadcom/Kconfig"
 source "drivers/pinctrl/exynos/Kconfig"
 source "drivers/pinctrl/intel/Kconfig"
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index df52c6db8c2..6c6e8b59122 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_ARCH_NPCM)			+= nuvoton/
 obj-$(CONFIG_ARCH_RENESAS)		+= renesas/
 
 obj-$(CONFIG_PINCTRL_ADI)		+= pinctrl-adi-adsp.o
+obj-$(CONFIG_PINCTRL_AIROHA)		+= airoha/
 obj-$(CONFIG_PINCTRL_APPLE)		+= pinctrl-apple.o
 obj-$(CONFIG_PINCTRL_AT91)		+= pinctrl-at91.o
 obj-$(CONFIG_PINCTRL_AT91PIO4)		+= pinctrl-at91-pio4.o
diff --git a/drivers/pinctrl/airoha/Kconfig b/drivers/pinctrl/airoha/Kconfig
new file mode 100644
index 00000000000..eb87afbb374
--- /dev/null
+++ b/drivers/pinctrl/airoha/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config PINCTRL_AIROHA
+	depends on ARCH_AIROHA
+	select PINCTRL_FULL
+	select PINCTRL_GENERIC
+	select PINMUX
+	select PINCONF
+	select REGMAP
+	select SYSCON
+	bool
diff --git a/drivers/pinctrl/airoha/Makefile b/drivers/pinctrl/airoha/Makefile
new file mode 100644
index 00000000000..a25b744dd7a
--- /dev/null
+++ b/drivers/pinctrl/airoha/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_PINCTRL_AIROHA)		+= pinctrl-airoha.o
diff --git a/drivers/pinctrl/airoha/airoha-common.h b/drivers/pinctrl/airoha/airoha-common.h
new file mode 100644
index 00000000000..4354b0eb6b4
--- /dev/null
+++ b/drivers/pinctrl/airoha/airoha-common.h
@@ -0,0 +1,144 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __AIROHA_COMMON_HEADER__
+#define __AIROHA_COMMON_HEADER__
+
+#include <linux/types.h>
+#include <linux/bitops.h>
+#include <linux/bitfield.h>
+#include <linux/pinctrl/pinctrl.h>
+
+#include <dm/device.h>
+#include <dm/pinctrl.h>
+
+/* GPIOs */
+#define REG_GPIO_CTRL				0x0000
+#define REG_GPIO_DATA				0x0004
+#define REG_GPIO_INT				0x0008
+#define REG_GPIO_INT_EDGE			0x000c
+#define REG_GPIO_INT_LEVEL			0x0010
+#define REG_GPIO_OE				0x0014
+#define REG_GPIO_CTRL1				0x0020
+#define REG_GPIO_CTRL2				0x0060
+#define REG_GPIO_CTRL3				0x0064
+#define REG_GPIO_DATA1				0x0070
+#define REG_GPIO_OE1				0x0078
+#define REG_GPIO_INT1				0x007c
+#define REG_GPIO_INT_EDGE1			0x0080
+#define REG_GPIO_INT_EDGE2			0x0084
+#define REG_GPIO_INT_EDGE3			0x0088
+#define REG_GPIO_INT_LEVEL1			0x008c
+#define REG_GPIO_INT_LEVEL2			0x0090
+#define REG_GPIO_INT_LEVEL3			0x0094
+
+#define AIROHA_NUM_PINS				64
+#define AIROHA_PIN_BANK_SIZE			(AIROHA_NUM_PINS / 2)
+#define AIROHA_REG_GPIOCTRL_NUM_PIN		(AIROHA_NUM_PINS / 4)
+
+#define PINCTRL_PIN_GROUP(id, table)					\
+	PINCTRL_PINGROUP(id, table##_pins, ARRAY_SIZE(table##_pins))
+
+#define PINCTRL_FUNC_DESC(id, table)					\
+	{								\
+		.desc = PINCTRL_PINFUNCTION(id, table##_groups,	\
+					    ARRAY_SIZE(table##_groups)),\
+		.groups = table##_func_group,				\
+		.group_size = ARRAY_SIZE(table##_func_group),		\
+	}
+
+#define PINCTRL_CONF_DESC(p, offset, mask)				\
+	{								\
+		.pin = p,						\
+		.reg = { offset, mask },				\
+	}
+
+struct airoha_pinctrl_reg {
+	u32 offset;
+	u32 mask;
+};
+
+enum airoha_pinctrl_mux_func {
+	AIROHA_FUNC_MUX,
+	AIROHA_FUNC_PWM_MUX,
+	AIROHA_FUNC_PWM_EXT_MUX,
+};
+
+struct airoha_pinctrl_func_group {
+	const char *name;
+	struct {
+		enum airoha_pinctrl_mux_func mux;
+		u32 offset;
+		u32 mask;
+		u32 val;
+	} regmap[2];
+	int regmap_size;
+};
+
+struct airoha_pinctrl_func {
+	const struct pinfunction desc;
+	const struct airoha_pinctrl_func_group *groups;
+	u8 group_size;
+};
+
+struct airoha_pinctrl_conf {
+	u32 pin;
+	struct airoha_pinctrl_reg reg;
+};
+
+struct airoha_pinctrl_gpiochip {
+	/* gpio */
+	const u32 *data;
+	const u32 *dir;
+	const u32 *out;
+	/* irq */
+	const u32 *status;
+	const u32 *level;
+	const u32 *edge;
+
+	u32 irq_type[AIROHA_NUM_PINS];
+};
+
+struct airoha_pinctrl_confs_info {
+	const struct airoha_pinctrl_conf *confs;
+	unsigned int num_confs;
+};
+
+enum airoha_pinctrl_confs_type {
+	AIROHA_PINCTRL_CONFS_PULLUP,
+	AIROHA_PINCTRL_CONFS_PULLDOWN,
+	AIROHA_PINCTRL_CONFS_DRIVE_E2,
+	AIROHA_PINCTRL_CONFS_DRIVE_E4,
+	AIROHA_PINCTRL_CONFS_PCIE_RST_OD,
+
+	AIROHA_PINCTRL_CONFS_MAX
+};
+
+struct airoha_pinctrl {
+	struct udevice *dev;
+
+	struct regmap *chip_scu;
+	struct regmap *regmap;
+
+	struct airoha_pinctrl_match_data *data;
+
+	struct airoha_pinctrl_gpiochip gpiochip;
+};
+
+struct airoha_pinctrl_match_data {
+	const int gpio_offs;
+	const int gpio_pin_cnt;
+	const char *chip_scu_compatible;
+	const struct pinctrl_pin_desc *pins;
+	const unsigned int num_pins;
+	const struct pingroup *grps;
+	const unsigned int num_grps;
+	const struct airoha_pinctrl_func *funcs;
+	const unsigned int num_funcs;
+	const struct airoha_pinctrl_confs_info confs_info[AIROHA_PINCTRL_CONFS_MAX];
+};
+
+extern const struct pinctrl_ops airoha_pinctrl_ops;
+
+int airoha_pinctrl_probe(struct udevice *dev);
+int airoha_pinctrl_bind(struct udevice *dev);
+
+#endif
diff --git a/drivers/pinctrl/airoha/pinctrl-airoha.c b/drivers/pinctrl/airoha/pinctrl-airoha.c
new file mode 100644
index 00000000000..60c48c0960c
--- /dev/null
+++ b/drivers/pinctrl/airoha/pinctrl-airoha.c
@@ -0,0 +1,958 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Author: Lorenzo Bianconi <lorenzo@kernel.org>
+ * Author: Benjamin Larsson <benjamin.larsson@genexis.eu>
+ * Author: Markus Gothe <markus.gothe@genexis.eu>
+ * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
+ */
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dm/device-internal.h>
+#include <dm/lists.h>
+#include <dm/ofnode.h>
+#include <asm-generic/gpio.h>
+#include <asm/arch/scu-regmap.h>
+#include <dt-bindings/pinctrl/mt65xx.h>
+#include <regmap.h>
+#include <syscon.h>
+
+#include "airoha-common.h"
+
+#define airoha_pinctrl_get_pullup_conf(pinctrl, pin, val)			\
+	airoha_pinctrl_get_conf((pinctrl), AIROHA_PINCTRL_CONFS_PULLUP,		\
+				(pin), (val))
+#define airoha_pinctrl_get_pulldown_conf(pinctrl, pin, val)			\
+	airoha_pinctrl_get_conf((pinctrl), AIROHA_PINCTRL_CONFS_PULLDOWN,	\
+				(pin), (val))
+#define airoha_pinctrl_get_drive_e2_conf(pinctrl, pin, val)			\
+	airoha_pinctrl_get_conf((pinctrl), AIROHA_PINCTRL_CONFS_DRIVE_E2,	\
+				(pin), (val))
+#define airoha_pinctrl_get_drive_e4_conf(pinctrl, pin, val)			\
+	airoha_pinctrl_get_conf((pinctrl), AIROHA_PINCTRL_CONFS_DRIVE_E4,	\
+				(pin), (val))
+#define airoha_pinctrl_get_pcie_rst_od_conf(pinctrl, pin, val)			\
+	airoha_pinctrl_get_conf((pinctrl), AIROHA_PINCTRL_CONFS_PCIE_RST_OD,	\
+				(pin), (val))
+#define airoha_pinctrl_set_pullup_conf(pinctrl, pin, val)			\
+	airoha_pinctrl_set_conf((pinctrl), AIROHA_PINCTRL_CONFS_PULLUP,		\
+				(pin), (val))
+#define airoha_pinctrl_set_pulldown_conf(pinctrl, pin, val)			\
+	airoha_pinctrl_set_conf((pinctrl), AIROHA_PINCTRL_CONFS_PULLDOWN,	\
+				(pin), (val))
+#define airoha_pinctrl_set_drive_e2_conf(pinctrl, pin, val)			\
+	airoha_pinctrl_set_conf((pinctrl), AIROHA_PINCTRL_CONFS_DRIVE_E2,	\
+				(pin), (val))
+#define airoha_pinctrl_set_drive_e4_conf(pinctrl, pin, val)			\
+	airoha_pinctrl_set_conf((pinctrl), AIROHA_PINCTRL_CONFS_DRIVE_E4,	\
+				(pin), (val))
+#define airoha_pinctrl_set_pcie_rst_od_conf(pinctrl, pin, val)			\
+	airoha_pinctrl_set_conf((pinctrl), AIROHA_PINCTRL_CONFS_PCIE_RST_OD,	\
+				(pin), (val))
+
+static const u32 gpio_data_regs[] = {
+	REG_GPIO_DATA,
+	REG_GPIO_DATA1
+};
+
+static const u32 gpio_out_regs[] = {
+	REG_GPIO_OE,
+	REG_GPIO_OE1
+};
+
+static const u32 gpio_dir_regs[] = {
+	REG_GPIO_CTRL,
+	REG_GPIO_CTRL1,
+	REG_GPIO_CTRL2,
+	REG_GPIO_CTRL3
+};
+
+static const u32 irq_status_regs[] = {
+	REG_GPIO_INT,
+	REG_GPIO_INT1
+};
+
+static const u32 irq_level_regs[] = {
+	REG_GPIO_INT_LEVEL,
+	REG_GPIO_INT_LEVEL1,
+	REG_GPIO_INT_LEVEL2,
+	REG_GPIO_INT_LEVEL3
+};
+
+static const u32 irq_edge_regs[] = {
+	REG_GPIO_INT_EDGE,
+	REG_GPIO_INT_EDGE1,
+	REG_GPIO_INT_EDGE2,
+	REG_GPIO_INT_EDGE3
+};
+
+static int pin_in_group(unsigned int pin, const struct pingroup *grp)
+{
+	for (int i = 0; i < grp->npins; i++) {
+		if (grp->pins[i] == pin)
+			return 1;
+	}
+
+	return 0;
+}
+
+static int pin_to_gpio(struct airoha_pinctrl *pinctrl, unsigned int pin)
+{
+	struct airoha_pinctrl_match_data *data = pinctrl->data;
+
+	if (pin < data->gpio_offs ||
+	    pin >= data->gpio_offs + data->gpio_pin_cnt)
+		return -EINVAL;
+
+	return pin - data->gpio_offs;
+}
+
+/* gpio callbacks */
+static int airoha_gpio_set(struct airoha_pinctrl *pinctrl, unsigned int gpio,
+			   int value)
+{
+	u32 offset = gpio % AIROHA_PIN_BANK_SIZE;
+	u8 index = gpio / AIROHA_PIN_BANK_SIZE;
+
+	return regmap_update_bits(pinctrl->regmap,
+				  pinctrl->gpiochip.data[index],
+				  BIT(offset), value ? BIT(offset) : 0);
+}
+
+static int airoha_gpio_get(struct airoha_pinctrl *pinctrl, unsigned int gpio)
+{
+	u32 val, pin = gpio % AIROHA_PIN_BANK_SIZE;
+	u8 index = gpio / AIROHA_PIN_BANK_SIZE;
+	int err;
+
+	err = regmap_read(pinctrl->regmap,
+			  pinctrl->gpiochip.data[index], &val);
+
+	return err ? err : !!(val & BIT(pin));
+}
+
+static int airoha_gpio_get_direction(struct airoha_pinctrl *pinctrl, unsigned int gpio)
+{
+	u32 mask, index, val;
+	int err, field_shift;
+
+	field_shift = 2 * (gpio % AIROHA_REG_GPIOCTRL_NUM_PIN);
+	mask = GENMASK(field_shift + 1, field_shift);
+	index = gpio / AIROHA_REG_GPIOCTRL_NUM_PIN;
+
+	err = regmap_read(pinctrl->regmap,
+			  pinctrl->gpiochip.dir[index], &val);
+	if (err)
+		return err;
+
+	if ((val & mask) > BIT(field_shift))
+		return -EINVAL;
+
+	return (val & mask) ? GPIOF_OUTPUT : GPIOF_INPUT;
+}
+
+static int airoha_gpio_set_direction(struct airoha_pinctrl *pinctrl,
+				     unsigned int gpio, bool input)
+{
+	u32 mask, index;
+	int err, field_shift;
+
+	/* set output enable */
+	mask = BIT(gpio % AIROHA_PIN_BANK_SIZE);
+	index = gpio / AIROHA_PIN_BANK_SIZE;
+	err = regmap_update_bits(pinctrl->regmap, pinctrl->gpiochip.out[index],
+				 mask, !input ? mask : 0);
+	if (err)
+		return err;
+
+	/* set direction */
+	field_shift = 2 * (gpio % AIROHA_REG_GPIOCTRL_NUM_PIN);
+	mask = GENMASK(field_shift + 1, field_shift);
+	index = gpio / AIROHA_REG_GPIOCTRL_NUM_PIN;
+
+	return regmap_update_bits(pinctrl->regmap,
+				  pinctrl->gpiochip.dir[index],
+				  mask, !input ? BIT(field_shift) : 0);
+}
+
+/* pinmux callbacks */
+static int airoha_pinmux_set_mux(struct airoha_pinctrl *pinctrl,
+				 unsigned int func_selector,
+				 unsigned int group_selector)
+{
+	const struct airoha_pinctrl_func *func;
+	const struct pingroup *grp;
+	int i;
+
+	func = &pinctrl->data->funcs[func_selector];
+	grp = &pinctrl->data->grps[group_selector];
+
+	dev_dbg(pinctrl->dev, "enable function %s group %s\n",
+		func->desc.name, grp->name);
+
+	for (i = 0; i < func->group_size; i++) {
+		const struct airoha_pinctrl_func_group *group;
+		int j;
+
+		group = &func->groups[i];
+		if (strcmp(group->name, grp->name))
+			continue;
+
+		for (j = 0; j < group->regmap_size; j++) {
+			switch (group->regmap[j].mux) {
+			case AIROHA_FUNC_PWM_EXT_MUX:
+			case AIROHA_FUNC_PWM_MUX:
+				regmap_update_bits(pinctrl->regmap,
+						   group->regmap[j].offset,
+						   group->regmap[j].mask,
+						   group->regmap[j].val);
+				break;
+			default:
+				regmap_update_bits(pinctrl->chip_scu,
+						   group->regmap[j].offset,
+						   group->regmap[j].mask,
+						   group->regmap[j].val);
+				break;
+			}
+		}
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int airoha_pinmux_set_direction(struct airoha_pinctrl *pinctrl,
+				       unsigned int p, bool input)
+{
+	int gpio;
+
+	gpio = pin_to_gpio(pinctrl, p);
+	if (gpio < 0)
+		return gpio;
+
+	return airoha_gpio_set_direction(pinctrl, gpio, input);
+}
+
+/* pinconf callbacks */
+static const struct airoha_pinctrl_reg *
+airoha_pinctrl_get_conf_reg(const struct airoha_pinctrl_conf *conf,
+			    int conf_size, int pin)
+{
+	int i;
+
+	for (i = 0; i < conf_size; i++) {
+		if (conf[i].pin == pin)
+			return &conf[i].reg;
+	}
+
+	return NULL;
+}
+
+static int airoha_pinctrl_get_conf(struct airoha_pinctrl *pinctrl,
+				   enum airoha_pinctrl_confs_type conf_type,
+				   int pin, u32 *val)
+{
+	const struct airoha_pinctrl_confs_info *confs_info;
+	const struct airoha_pinctrl_reg *reg;
+
+	confs_info = &pinctrl->data->confs_info[conf_type];
+
+	reg = airoha_pinctrl_get_conf_reg(confs_info->confs,
+					  confs_info->num_confs,
+					  pin);
+	if (!reg)
+		return -EINVAL;
+
+	if (regmap_read(pinctrl->chip_scu, reg->offset, val))
+		return -EINVAL;
+
+	*val = field_get(reg->mask, *val);
+
+	return 0;
+}
+
+static int airoha_pinctrl_set_conf(struct airoha_pinctrl *pinctrl,
+				   enum airoha_pinctrl_confs_type conf_type,
+				   int pin, u32 val)
+{
+	const struct airoha_pinctrl_confs_info *confs_info;
+	const struct airoha_pinctrl_reg *reg = NULL;
+
+	confs_info = &pinctrl->data->confs_info[conf_type];
+
+	reg = airoha_pinctrl_get_conf_reg(confs_info->confs,
+					  confs_info->num_confs,
+					  pin);
+	if (!reg)
+		return -EINVAL;
+
+	if (regmap_update_bits(pinctrl->chip_scu, reg->offset, reg->mask,
+			       field_prep(reg->mask, val)))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int airoha_pinconf_get_direction(struct airoha_pinctrl *pinctrl, u32 p)
+{
+	int gpio;
+
+	gpio = pin_to_gpio(pinctrl, p);
+	if (gpio < 0)
+		return gpio;
+
+	return airoha_gpio_get_direction(pinctrl, gpio);
+}
+
+static int airoha_pinconf_get(struct airoha_pinctrl *pinctrl,
+			      unsigned int pin, unsigned long *config)
+{
+	enum pin_config_param param = pinconf_to_config_param(*config);
+	u32 arg;
+
+	switch (param) {
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+	case PIN_CONFIG_BIAS_DISABLE:
+	case PIN_CONFIG_BIAS_PULL_UP: {
+		u32 pull_up, pull_down;
+
+		if (airoha_pinctrl_get_pullup_conf(pinctrl, pin, &pull_up) ||
+		    airoha_pinctrl_get_pulldown_conf(pinctrl, pin, &pull_down))
+			return -EINVAL;
+
+		if (param == PIN_CONFIG_BIAS_PULL_UP &&
+		    !(pull_up && !pull_down))
+			return -EINVAL;
+		else if (param == PIN_CONFIG_BIAS_PULL_DOWN &&
+			 !(pull_down && !pull_up))
+			return -EINVAL;
+		else if (pull_up || pull_down)
+			return -EINVAL;
+
+		arg = 1;
+		break;
+	}
+	case PIN_CONFIG_DRIVE_STRENGTH: {
+		u32 e2, e4;
+
+		if (airoha_pinctrl_get_drive_e2_conf(pinctrl, pin, &e2) ||
+		    airoha_pinctrl_get_drive_e4_conf(pinctrl, pin, &e4))
+			return -EINVAL;
+
+		arg = e4 << 1 | e2;
+		break;
+	}
+	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+		if (airoha_pinctrl_get_pcie_rst_od_conf(pinctrl, pin, &arg))
+			return -EINVAL;
+		break;
+	case PIN_CONFIG_OUTPUT_ENABLE:
+	case PIN_CONFIG_INPUT_ENABLE:
+		arg = airoha_pinconf_get_direction(pinctrl, pin);
+		if ((param != PIN_CONFIG_OUTPUT_ENABLE || arg != GPIOF_OUTPUT) &&
+		    (param != PIN_CONFIG_INPUT_ENABLE || arg != GPIOF_INPUT))
+			return -EINVAL;
+
+		arg = 1;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	*config = pinconf_to_config_packed(param, arg);
+
+	return 0;
+}
+
+static int airoha_pinconf_set_pin_value(struct airoha_pinctrl *pinctrl,
+					unsigned int p, bool value)
+{
+	int gpio;
+
+	gpio = pin_to_gpio(pinctrl, p);
+	if (gpio < 0)
+		return gpio;
+
+	return airoha_gpio_set(pinctrl, gpio, value);
+}
+
+static int airoha_pinconf_set(struct airoha_pinctrl *pinctrl,
+			      unsigned int pin, unsigned long *configs,
+			      unsigned int num_configs)
+{
+	int i, err;
+
+	for (i = 0; i < num_configs; i++) {
+		u32 param = pinconf_to_config_param(configs[i]);
+		u32 arg = pinconf_to_config_argument(configs[i]);
+
+		switch (param) {
+		case PIN_CONFIG_BIAS_DISABLE:
+			err = airoha_pinctrl_set_pulldown_conf(pinctrl, pin, 0);
+			if (err)
+				return err;
+
+			err = airoha_pinctrl_set_pullup_conf(pinctrl, pin, 0);
+			if (err)
+				return err;
+
+			break;
+
+		case PIN_CONFIG_BIAS_PULL_UP:
+			err = airoha_pinctrl_set_pulldown_conf(pinctrl, pin, 0);
+			if (err)
+				return err;
+
+			err = airoha_pinctrl_set_pullup_conf(pinctrl, pin, 1);
+			if (err)
+				return err;
+
+			break;
+
+		case PIN_CONFIG_BIAS_PULL_DOWN:
+			err = airoha_pinctrl_set_pulldown_conf(pinctrl, pin, 1);
+			if (err)
+				return err;
+
+			err = airoha_pinctrl_set_pullup_conf(pinctrl, pin, 0);
+			if (err)
+				return err;
+
+			break;
+
+		case PIN_CONFIG_DRIVE_STRENGTH: {
+			u32 e2 = 0, e4 = 0;
+
+			switch (arg) {
+			case MTK_DRIVE_2mA:
+				break;
+			case MTK_DRIVE_4mA:
+				e2 = 1;
+				break;
+			case MTK_DRIVE_6mA:
+				e4 = 1;
+				break;
+			case MTK_DRIVE_8mA:
+				e2 = 1;
+				e4 = 1;
+				break;
+			default:
+				return -EINVAL;
+			}
+
+			err = airoha_pinctrl_set_drive_e2_conf(pinctrl, pin, e2);
+			if (err)
+				return err;
+
+			err = airoha_pinctrl_set_drive_e4_conf(pinctrl, pin, e4);
+			if (err)
+				return err;
+
+			break;
+		}
+		case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+			err = airoha_pinctrl_set_pcie_rst_od_conf(pinctrl, pin, !!arg);
+			if (err)
+				return err;
+
+			break;
+
+		case PIN_CONFIG_OUTPUT_ENABLE:
+		case PIN_CONFIG_INPUT_ENABLE:
+		case PIN_CONFIG_OUTPUT: {
+			bool input = param == PIN_CONFIG_INPUT_ENABLE;
+
+			err = airoha_pinmux_set_direction(pinctrl, pin, input);
+			if (err)
+				return err;
+
+			if (param == PIN_CONFIG_OUTPUT) {
+				err = airoha_pinconf_set_pin_value(pinctrl,
+								   pin, !!arg);
+				if (err)
+					return err;
+			}
+
+			break;
+		}
+		default:
+			return -EOPNOTSUPP;
+		}
+	}
+
+	return 0;
+}
+
+static int airoha_pinconf_group_set(struct airoha_pinctrl *pinctrl,
+				    unsigned int group, unsigned long *configs,
+				    unsigned int num_configs)
+{
+	int i;
+
+	for (i = 0; i < pinctrl->data->grps[group].npins; i++) {
+		int err;
+
+		err = airoha_pinconf_set(pinctrl,
+					 pinctrl->data->grps[group].pins[i],
+					 configs, num_configs);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int func_grp_active(struct airoha_pinctrl *pinctrl,
+			   const struct airoha_pinctrl_func *func,
+			   const char *grp_name)
+{
+	const struct airoha_pinctrl_func_group *func_grp;
+	u32 val, match;
+	int ret;
+
+	for (int i = 0; i < func->group_size; i++) {
+		if (strcmp(func->groups[i].name, grp_name))
+			continue;
+
+		match = 0;
+		func_grp = &func->groups[i];
+		for (int j = 0; j < func_grp->regmap_size; j++) {
+			switch (func_grp->regmap[j].mux) {
+			case AIROHA_FUNC_PWM_EXT_MUX:
+			case AIROHA_FUNC_PWM_MUX:
+				ret = regmap_read(pinctrl->regmap,
+						  func_grp->regmap[j].offset,
+						  &val);
+				break;
+			default:
+				ret = regmap_read(pinctrl->chip_scu,
+						  func_grp->regmap[j].offset,
+						  &val);
+				break;
+			}
+
+			if (ret)
+				break;
+
+			if ((val & func_grp->regmap[j].mask) !=
+			    func_grp->regmap[j].val)
+				break;
+
+			match++;
+		}
+
+		return match == func->groups[i].regmap_size;
+	}
+
+	return 0;
+}
+
+/***********************
+ * gpio driver interface
+ ***********************/
+static int airoha_pinctrl_gpio_set(struct udevice *dev, unsigned int gpio,
+				   int value)
+{
+	return airoha_gpio_set(dev_get_priv(dev->parent), gpio, value);
+}
+
+static int airoha_pinctrl_gpio_get(struct udevice *dev, unsigned int gpio)
+{
+	return airoha_gpio_get(dev_get_priv(dev->parent), gpio);
+}
+
+static int airoha_pinctrl_gpio_get_direction(struct udevice *dev,
+					     unsigned int gpio)
+{
+	return airoha_gpio_get_direction(dev_get_priv(dev->parent), gpio);
+}
+
+static int airoha_pinctrl_gpio_direction_input(struct udevice *dev,
+					       unsigned int gpio)
+{
+	return airoha_gpio_set_direction(dev_get_priv(dev->parent),
+					 gpio, true);
+}
+
+static int airoha_pinctrl_gpio_direction_output(struct udevice *dev,
+						unsigned int gpio, int val)
+{
+	struct airoha_pinctrl *pinctrl = dev_get_priv(dev->parent);
+	int err;
+
+	err = airoha_gpio_set_direction(pinctrl, gpio, false);
+	if (err)
+		return err;
+
+	return airoha_gpio_set(pinctrl, gpio, val);
+}
+
+static int airoha_pinctrl_gpio_probe(struct udevice *dev)
+{
+	struct airoha_pinctrl *pinctrl = dev_get_priv(dev->parent);
+	struct gpio_dev_priv *uc_priv;
+
+	uc_priv = dev_get_uclass_priv(dev);
+	uc_priv->bank_name = "airoha";
+	uc_priv->gpio_count = pinctrl->data->gpio_pin_cnt;
+
+	return 0;
+}
+
+static int airoha_pinctrl_gpio_bind(struct udevice *dev)
+{
+	dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
+
+	return 0;
+}
+
+static const struct dm_gpio_ops airoha_pinctrl_gpio_ops = {
+	.set_value = airoha_pinctrl_gpio_set,
+	.get_value = airoha_pinctrl_gpio_get,
+	.get_function = airoha_pinctrl_gpio_get_direction,
+	.direction_input = airoha_pinctrl_gpio_direction_input,
+	.direction_output = airoha_pinctrl_gpio_direction_output,
+};
+
+static struct driver airoha_pinctrl_gpio_driver = {
+	.name = "airoha_pinctrl_gpio",
+	.id = UCLASS_GPIO,
+	.probe = airoha_pinctrl_gpio_probe,
+	.bind = airoha_pinctrl_gpio_bind,
+	.ops = &airoha_pinctrl_gpio_ops,
+};
+
+static int airoha_pinctrl_gpio_register(struct udevice *parent)
+{
+	struct uclass_driver *drv;
+	ofnode node;
+	int ret;
+
+	drv = lists_uclass_lookup(UCLASS_GPIO);
+	if (!drv)
+		return -ENOENT;
+
+	/*
+	 * Support upstream linux DTSI that define gpio-controller
+	 * in the root node (instead of a dedicated subnode)
+	 */
+	if (dev_read_bool(parent, "gpio-controller")) {
+		/* upstream DTSI, use current node */
+		node = dev_ofnode(parent);
+	} else {
+		/* legacy DTSI, search for gpio-controller subnode */
+		ret = -ENOENT;
+		dev_for_each_subnode(node, parent)
+			if (ofnode_read_bool(node, "gpio-controller")) {
+				ret = 0;
+				break;
+			}
+
+		if (ret)
+			return ret;
+	}
+
+	return device_bind_with_driver_data(parent,
+					    &airoha_pinctrl_gpio_driver,
+					    "airoha_pinctrl_gpio",
+					    0, node, NULL);
+}
+
+/**************************
+ * pinctrl driver interface
+ **************************/
+static int airoha_get_pins_count(struct udevice *dev)
+{
+	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
+
+	return pinctrl->data->num_pins;
+}
+
+static const char *airoha_get_pin_name(struct udevice *dev,
+				       unsigned int selector)
+{
+	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
+
+	return pinctrl->data->pins[selector].name;
+}
+
+static int airoha_get_groups_count(struct udevice *dev)
+{
+	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
+
+	return pinctrl->data->num_grps;
+}
+
+static const char *airoha_get_group_name(struct udevice *dev,
+					 unsigned int selector)
+{
+	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
+
+	return pinctrl->data->grps[selector].name;
+}
+
+static int airoha_get_funcs_count(struct udevice *dev)
+{
+	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
+
+	return pinctrl->data->num_funcs;
+}
+
+static const char *airoha_get_func_name(struct udevice *dev,
+					unsigned int selector)
+{
+	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
+
+	return pinctrl->data->funcs[selector].desc.name;
+}
+
+static int airoha_pinmux_group_set(struct udevice *dev,
+				   unsigned int group_selector,
+				   unsigned int func_selector)
+{
+	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
+
+	dev_dbg(dev, "enabling %s function for pin group %s\n",
+		airoha_get_func_name(dev, func_selector),
+		airoha_get_group_name(dev, group_selector));
+
+	return airoha_pinmux_set_mux(pinctrl, func_selector, group_selector);
+}
+
+static int airoha_pinmux_set(struct udevice *dev,
+			     unsigned int pin_selector,
+			     unsigned int func_selector)
+{
+	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
+	const struct airoha_pinctrl_match_data *data = pinctrl->data;
+	const char *pin_name;
+	unsigned int selector;
+
+	pin_name = data->pins[pin_selector].name;
+
+	/* find group matching the pin_name */
+	for (selector = 0; selector < data->num_grps; selector++) {
+		if (!strcmp(pin_name, data->grps[selector].name))
+			return airoha_pinmux_group_set(dev, selector,
+						       func_selector);
+	}
+
+	return -ENOENT;
+}
+
+static const struct pinconf_param airoha_pinconf_params[] = {
+	{ "bias-disable",     PIN_CONFIG_BIAS_DISABLE,     0 },
+	{ "bias-pull-up",     PIN_CONFIG_BIAS_PULL_UP,     1 },
+	{ "bias-pull-down",   PIN_CONFIG_BIAS_PULL_DOWN,   1 },
+	{ "drive-strength",   PIN_CONFIG_DRIVE_STRENGTH,   0 },
+	{ "drive-open-drain", PIN_CONFIG_DRIVE_OPEN_DRAIN, 0 },
+	{ "output-enable",    PIN_CONFIG_OUTPUT_ENABLE,    1 },
+	{ "input-enable",     PIN_CONFIG_INPUT_ENABLE,     1 },
+};
+
+static const char *airoha_pinconf_param_name(unsigned int param)
+{
+	for (int i = 0; i < ARRAY_SIZE(airoha_pinconf_params); i++) {
+		if (airoha_pinconf_params[i].param == param)
+			return airoha_pinconf_params[i].property;
+	}
+
+	return NULL;
+}
+
+static int airoha_pinconf_set_handler(struct udevice *dev,
+				      unsigned pin_selector,
+				      unsigned int param,
+				      unsigned int argument)
+{
+	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
+	unsigned long configs[1] = { pinconf_to_config_packed(param, argument) };
+	unsigned int pin = pinctrl->data->pins[pin_selector].number;
+
+	dev_dbg(dev, "enabling %s=%d property for pin %s\n",
+		airoha_pinconf_param_name(param), argument,
+		airoha_get_pin_name(dev, pin_selector));
+
+	return airoha_pinconf_set(pinctrl, pin, configs,
+				  ARRAY_SIZE(configs));
+}
+
+static int airoha_pinconf_group_set_handler(struct udevice *dev,
+					    unsigned int group_selector,
+					    unsigned int param,
+					    unsigned int argument)
+{
+	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
+	unsigned long configs[1] = { pinconf_to_config_packed(param, argument) };
+
+	dev_dbg(dev, "enabling %s=%d property for pin group %s\n",
+		airoha_pinconf_param_name(param), argument,
+		airoha_get_group_name(dev, group_selector));
+
+	return airoha_pinconf_group_set(pinctrl, group_selector,
+					configs, ARRAY_SIZE(configs));
+}
+
+static int airoha_get_pin_muxing(struct udevice *dev, unsigned int selector,
+				 char *buf, int size)
+{
+	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
+	struct airoha_pinctrl_match_data *data = pinctrl->data;
+	const char *name, *type;
+	int ret, gpio, found = 0;
+	unsigned long config;
+	unsigned int param, pin;
+	u32 val;
+
+	pin = data->pins[selector].number;
+	for (int i = 0; i < data->num_grps; i++) {
+		if (!pin_in_group(pin, &data->grps[i]))
+			continue;
+
+		name = data->grps[i].name;
+		for (int j = 0; j < data->num_funcs; j++) {
+			if (!func_grp_active(pinctrl, &data->funcs[j], name))
+				continue;
+
+			ret = scnprintf(buf, size, "%s(%s)",
+					data->funcs[j].desc.name, name);
+			if (ret < 0)
+				return -ENOSPC;
+
+			found = 1;
+			buf += ret;
+			size -= ret;
+			break;
+		}
+
+		if (found)
+			break;
+	}
+
+	if (!found) {
+		gpio = pin_to_gpio(pinctrl, pin);
+		if (gpio < 0) {
+			/*
+			 * WARNING: non-gpio pin with unknown function.
+			 *
+			 * This should not have happened, the function group
+			 * tables are incomplete. Please fix ASAP.
+			 */
+			ret = scnprintf(buf, size, "default");
+		} else {
+			/* assume gpio */
+			val = airoha_gpio_get(pinctrl, gpio);
+			switch (airoha_gpio_get_direction(pinctrl, gpio)) {
+			case GPIOF_INPUT:
+				type = "input";
+				break;
+			case GPIOF_OUTPUT:
+				type = "output";
+				break;
+			default:
+				type = "unknown";
+				break;
+			};
+			ret = scnprintf(buf, size, "gpio%d, %s(%d)",
+					gpio, type, val);
+		}
+
+		if (ret < 0)
+			return -ENOSPC;
+
+		buf += ret;
+		size -= ret;
+	}
+
+	for (int i = 0; i < ARRAY_SIZE(airoha_pinconf_params); i++) {
+		param = airoha_pinconf_params[i].param;
+		config = pinconf_to_config_packed(param, 0);
+		ret = airoha_pinconf_get(pinctrl, pin, &config);
+		if (ret < 0)
+			continue;
+
+		name = airoha_pinconf_params[i].property;
+		switch (param) {
+		case PIN_CONFIG_BIAS_DISABLE:
+		case PIN_CONFIG_BIAS_PULL_UP:
+		case PIN_CONFIG_BIAS_PULL_DOWN:
+			ret = scnprintf(buf, size, ", %s", name);
+			break;
+
+		case PIN_CONFIG_DRIVE_STRENGTH:
+		case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+			val = pinconf_to_config_argument(config);
+			ret = scnprintf(buf, size, ", %s(%d)", name, val);
+			break;
+
+		default:
+			break;
+		}
+
+		if (ret < 0)
+			return -ENOSPC;
+
+		buf += ret;
+		size -= ret;
+	}
+
+	return 0;
+}
+
+const struct pinctrl_ops airoha_pinctrl_ops = {
+	.get_pins_count		= airoha_get_pins_count,
+	.get_pin_name		= airoha_get_pin_name,
+	.get_groups_count	= airoha_get_groups_count,
+	.get_group_name		= airoha_get_group_name,
+	.get_functions_count	= airoha_get_funcs_count,
+	.get_function_name	= airoha_get_func_name,
+	.pinmux_set		= airoha_pinmux_set,
+	.pinmux_group_set	= airoha_pinmux_group_set,
+
+	.pinconf_num_params	= ARRAY_SIZE(airoha_pinconf_params),
+	.pinconf_params		= airoha_pinconf_params,
+	.pinconf_set		= airoha_pinconf_set_handler,
+	.pinconf_group_set	= airoha_pinconf_group_set_handler,
+
+	.set_state		= pinctrl_generic_set_state,
+	.get_pin_muxing		= airoha_get_pin_muxing,
+};
+
+int airoha_pinctrl_probe(struct udevice *dev)
+{
+	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
+
+	pinctrl->dev = dev;
+	pinctrl->data = (struct airoha_pinctrl_match_data *)dev_get_driver_data(dev);
+
+	pinctrl->regmap = syscon_node_to_regmap(dev_ofnode(dev->parent));
+	if (IS_ERR(pinctrl->regmap))
+		return PTR_ERR(pinctrl->regmap);
+
+	pinctrl->chip_scu = airoha_get_chip_scu_regmap();
+	if (IS_ERR(pinctrl->chip_scu))
+		return PTR_ERR(pinctrl->chip_scu);
+
+	pinctrl->gpiochip.data   = gpio_data_regs;
+	pinctrl->gpiochip.dir    = gpio_dir_regs;
+	pinctrl->gpiochip.out    = gpio_out_regs;
+	pinctrl->gpiochip.status = irq_status_regs;
+	pinctrl->gpiochip.level  = irq_level_regs;
+	pinctrl->gpiochip.edge   = irq_edge_regs;
+
+	return 0;
+}
+
+int airoha_pinctrl_bind(struct udevice *dev)
+{
+	if (airoha_pinctrl_gpio_register(dev))
+		debug("Warning: can't bind gpio driver with device node\n");
+
+	/*
+	 * Make sure that the pinctrl driver gets probed after binding,
+	 * otherwise GPIO interface driver will not be probed as well.
+	 * GPIOs of non-probed driver can't be used.
+	 */
+	dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
+
+	return 0;
+}
-- 
2.53.0

