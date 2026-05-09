Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE37ECD3447
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 11:13:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A772484D1F;
	Sat,  9 May 2026 13:12:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="wJb9+hPs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9FCA84D1F; Sat,  9 May 2026 13:12:25 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD66084CD2
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 13:12:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gU4o0D1BNsnIjCJ6m1Nqn/BCWXPg01R0AvngTyWuaL1fKg6bc7dXQnhGllRJiBCOnqC7xFvHCGDLCWCXsFEW7gOkAhBdeyqMMzzrYPZkwqS8mN1Fx/ISXL1M4XQWkaXbXzMcGyhZNz/diIYjRzWI61OlhM+9cVsdsU+qb+KEle5bL6ba1P5hMfMnO8wXpvRTo3ZnGhw+tNIj9vCrPhJB+Saq2sLCg2Zp6f5br7NinA2pB/pigAbDW66cHqjAuXTuuqppeQ1VVyvqkgMG4F66u+GhWavPsz/Zdk6ijmOf9VTqopWAaE4I6x8EvhGnix5GI1D+zGBBwN+oonuHC9kr3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qHeAH3qoptHsV+JNZwhpiSLWOJKaNyIYo0C5dqROIvk=;
 b=wVRkJ4OJLk3+Xe0kREjbF/zSSsbMgvRUzviVf2+XvhNlog8O63KUuwVl8snEZnF/axaO+ZEi0IUk0fxHwDeUZF2o+p1uXlKYRkcNNqwQitECPzmaRl5U0+Jp/0g++0iDJh+6IL9O+UU/kaCg5bI/ouOWnhWye9BMpT0HbcexLGdd++mOztEY6FUzOmnZd2qgo3vh9UJtkX1iMTin9wyPscwIm5+H7leOOH7jLMiXgfmY7McjBGylD0OyDV5VCfXyDxXD4n34p/Pqwf/qcbRWx0f1O7goVfd+veWzLwheqQb3F+muCxZYS2IbZ+p6NXL8Bodd/QU2YcR8loy3AOtLkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHeAH3qoptHsV+JNZwhpiSLWOJKaNyIYo0C5dqROIvk=;
 b=wJb9+hPsw2QpRk8qA+phuGSa+RXvhrMm2TSYY8uLoeh0NWM91AYY7JtDTf5YYynr5eQnAw8PanwOnLbYSD1aMlyiN/wHzn0eK9wAJT/CcEQofJrK4Z+vYwRW4K9TtmWwCVq6zf6eUk+kldEvm0QiLWpog2PhmWxPpzEiVZkSxLZ84cGaIJ5udO+B/JXAoj9IrEmPM0gexf3OKU7eFmZVEO5TDeDEXEwbZAV2SRnluRoWvNaBHdx0qhLZTdcTphy0EEDUNGhXuyrrZd2W6WHcAtuJ/xtgbEqUJrJ+IoCGKQrtn9VbKAN5wOuxGofdwh4Wn84EfWeu9WcguBRS//Y+Cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV1PR08MB8617.eurprd08.prod.outlook.com (2603:10a6:150:81::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Sat, 9 May
 2026 11:12:20 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.20.9891.019; Sat, 9 May 2026
 11:12:20 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Anis Chali <chalianis1@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Yao Zi <me@ziyao.cc>,
 Sean Anderson <sean.anderson@linux.dev>,
 Michal Simek <michal.simek@amd.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 David Lechner <dlechner@baylibre.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v5 05/11] pinctrl: airoha: add shared pinctrl code
Date: Sat,  9 May 2026 14:11:51 +0300
Message-ID: <20260509111157.4039434-6-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260509111157.4039434-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260509111157.4039434-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0004.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:273::9) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV1PR08MB8617:EE_
X-MS-Office365-Filtering-Correlation-Id: f694eee3-a9e6-4e84-0ac5-08deadbbd668
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014|3023799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: nIUSS15biCzxYZ9PE3M6s8k4DjF9NGN0kdvwKKxu/MRThe3uYvE658mB6k6h4/bV1rhXz9B3lj5FfbTLrkgoCpULvUp3ln7soF7T1NoW5kxtQfxaBIKEp31k2BxTwRsO/YioJOIf9o69apnP604sADKbsshS8wJO9g5EdP+IxoayphlKdQqGFn8t11uLc/aQVwp6hJpn+GaT8KNjZ8SHt5fkOQ+qPVaEkb1XVGDwsoBQKwCvoJ2nSwQtdXhzIDJCXIFd9ZhTTVCIEOevrjXE0Z90ngCXt7pZdlRIFe5Ilo5DAx2IqAfZy3nDwuAUM8xLL/P2Z2hC5ZFkCqIZrtkGBoX5sKVPaDCiciBvt1MyIxQ51BzRRLHABgpy7X358ZE+TGr35ZBCGdjURhfwWZmBFKe9HmDJJk8rtoxXfjrOhIdSRTbGRvZKPPGFhZz1OR/Crwd1V0UlBOVJsG8uSkWj5jwlaLgxRBsBJTo+m769eQq5ggwzKEIjxsOh2Dv3Fz+lTtwToeDwK7E79O/IyszGiNe1eSgscF2N6J99TOrgKffl6nLDNtJL6hIWI+ljdJSTwJKZdJ6IWpQSljB0vsdu7R6Ighq//HplC+sYLEEcsXfJXok3KoJnDkV1TD1oRo061dkzf1xqTpZJMtZq0QX5j59OQGndnJvSVmnQomJxnhFh9Gkpp1l1EP+gcQfZj5dqx5JmJfXEeUfFpQy74MtsUslUXdixaHT++mRLbHVDYlJWjT4SnjJqKScOgWVlVHwD7ukBC+TAoaVyT/6YzOIokQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014)(3023799003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7nYiqqSQz+v2moZePmRlQ+CxDURNKm36W2FqiWPfrF0He/Z1vaLd+QtbVJ1U?=
 =?us-ascii?Q?QmGxRQbOsj02nY3MY1B/TBWmuDfm51zTSd6WVmMhChOjiwtK6nUX0uyjKWqk?=
 =?us-ascii?Q?wBIYJ1dthwZSWEQsb20d4pVSLFAqz5dDzsLfAV/9w91Te/QNB0R5ZCZ6hMwO?=
 =?us-ascii?Q?tlg32Ar0CVZwg4yHUY4Eaa27w9aoeFSC9BaEFurYKvkSz7AU4AaEUwnkcN8x?=
 =?us-ascii?Q?Wv+BZZPYz5dWieQuTwdHT2n0a0fUAaUj9b3RETCywGDeijhuI2Vu6H+ITYuA?=
 =?us-ascii?Q?ApAXR4ARAuaJx4Vtdltok4y4uDHzpEIIz/uTBv90Z8KMVssjCEMb/zXi3rZ8?=
 =?us-ascii?Q?7dsdiYl4cyVZgU01yUlnS60bINsXbB4LzlQ7vycZbyQRNcIMz9dK97M5qK5J?=
 =?us-ascii?Q?8R8DqUj2skBNDTz/fw+BcUxglisd+UanTC4Fn8KhK1ELn+tJXCRiFrkZC3mW?=
 =?us-ascii?Q?sc/CkO3EOrYGHPOEoQJoEa2+5DAyF+2M2ci+YYyEfji7NQofyPAX+MJipPNd?=
 =?us-ascii?Q?d5POhnfuwZPKmIu8lMpE9KP+ZOxLAFazINb5mnNJDLug+CHDCX/68iJNftRA?=
 =?us-ascii?Q?4OGnnORNbHADuZ7v9dTplOCVNSHdSH0/UYomQwV1TWmjFjc90PHnboZrobDF?=
 =?us-ascii?Q?37ukcF49zASTJpCTd8NlA9Yjkm30OGN5Qx6Mq26877/XYIdGVqUgclohxBWR?=
 =?us-ascii?Q?sBEexPRvcfV9jXa35HoH4SNRA9d+lUtMaFO1+sFKkNKra3JLog6Ez8O+IZwb?=
 =?us-ascii?Q?gW2Mqf3bBO1gvJtyg+9C0F2j5psHe5atjWDjL3G60/FSBX/byfKHvBWwu1Yb?=
 =?us-ascii?Q?cwVk/yAs6NfUKKaSeTVG/6/GX5v1hMvr/AsiRD4kS2tZK9sZTiXWRyeFX2kD?=
 =?us-ascii?Q?cF5JBHJoWedThX3NB82dQb+B6VCQCIz8JiiiSmOECPRuBhYzoxjQzGnAEi0R?=
 =?us-ascii?Q?TLYEc/LStiX9P3Z8+c9A2KRMzd9BpOFqRCHrs4MyNCpyS4vKpCBdxa5B/YCy?=
 =?us-ascii?Q?6STganpTFQmUn4x/htr0RoAhF1VpwWOPkaXTczy+bdUOKkBnL7NeBdaRza2Z?=
 =?us-ascii?Q?qf2rRrQDGRSkpNzQNaghX+Q2ovQte6qrKAJQlDtWviTZ0lntZxLfNyGdCw0r?=
 =?us-ascii?Q?drU8UX3e9lIJRyTHZrhIkVSv1A09BhTzcyMeQ5ZIiMX8LwxI6SYiI9mddoUy?=
 =?us-ascii?Q?S/dvDml2thieYFTS7dVX3gPeT+4gLqlynay1ypKi+jPO8zcJnVPUFKAuObdc?=
 =?us-ascii?Q?r/I98pUCwsA2jGvrwIWEIA3usOGlYpD980RCBP9PJ7WIi5yA5rvleIih7SII?=
 =?us-ascii?Q?XJ2pp40Che8wkzFG2Se2OJVq3Ve8Pv6r4lzELdd1g1kFKPsuYYVBjZzWPOCv?=
 =?us-ascii?Q?7GNEIvhm0z73a3MTocSnvqxrUK4RACua9yRX/bXWwSoxQiyXOG4ICUk4TSrS?=
 =?us-ascii?Q?iwCFIj3dd+uZX4a8fnjyD2M5s/ELcLc9AiSX3XEXgx/kOjS+87f47tAowDhv?=
 =?us-ascii?Q?zwcpQVoI/Rrx1OuT+Ewy3C5GM/ut1/3aLZ+42CHj+ukZ2130fCckz0loG7xZ?=
 =?us-ascii?Q?H025a5R+QD3TZcevbYSz9nXS4vm8oxYDMG/5ftVaVDpApO6YJ2nRRrd/Mc3z?=
 =?us-ascii?Q?V6aBwShzdGLwBmcdJHWVJpf8MG4z1ifOUuaadGGZAlkvQd7eefq8Y9L/CVEA?=
 =?us-ascii?Q?ewdAb/YORWGLLt+kzUDQD6SaLBW+N8CzTBULv/565aJ24yFZ9NktdI/yks93?=
 =?us-ascii?Q?KpsQrKL2dtny41rksbyg0fv9oj9onhU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f694eee3-a9e6-4e84-0ac5-08deadbbd668
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 11:12:20.3753 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l04QScFr49jo8yekIYBotRLh/CVjWNOwJZeMmyHvGqQdXVCbGwwjJR2TxrtGiwS6EKVgL1asucQt6lgBz+udQC31CcpTcma2qM80w+gsYl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8617
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
---
 drivers/pinctrl/Kconfig                 |   1 +
 drivers/pinctrl/Makefile                |  61 +-
 drivers/pinctrl/airoha/Kconfig          |  11 +
 drivers/pinctrl/airoha/Makefile         |   3 +
 drivers/pinctrl/airoha/airoha-common.h  | 476 ++++++++++++
 drivers/pinctrl/airoha/pinctrl-airoha.c | 927 ++++++++++++++++++++++++
 6 files changed, 1450 insertions(+), 29 deletions(-)
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
index 29fb9b484d0..6c6e8b59122 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -3,39 +3,42 @@
 obj-y					+= pinctrl-uclass.o
 obj-$(CONFIG_$(PHASE_)PINCTRL_GENERIC)	+= pinctrl-generic.o
 
+obj-y					+= broadcom/
+obj-y					+= nxp/
+
+obj-$(CONFIG_ARCH_ASPEED)		+= aspeed/
+obj-$(CONFIG_ARCH_ATH79)		+= ath79/
+obj-$(CONFIG_ARCH_MTMIPS)		+= mtmips/
+obj-$(CONFIG_ARCH_MVEBU)		+= mvebu/
+obj-$(CONFIG_ARCH_NEXELL)		+= nexell/
+obj-$(CONFIG_ARCH_NPCM)			+= nuvoton/
+obj-$(CONFIG_ARCH_RENESAS)		+= renesas/
+
 obj-$(CONFIG_PINCTRL_ADI)		+= pinctrl-adi-adsp.o
+obj-$(CONFIG_PINCTRL_AIROHA)		+= airoha/
 obj-$(CONFIG_PINCTRL_APPLE)		+= pinctrl-apple.o
 obj-$(CONFIG_PINCTRL_AT91)		+= pinctrl-at91.o
 obj-$(CONFIG_PINCTRL_AT91PIO4)		+= pinctrl-at91-pio4.o
-obj-y					+= nxp/
+obj-$(CONFIG_PINCTRL_EXYNOS)		+= exynos/
+obj-$(CONFIG_PINCTRL_INTEL)		+= intel/
+obj-$(CONFIG_PINCTRL_K210)		+= pinctrl-k210.o
+obj-$(CONFIG_PINCTRL_MESON)		+= meson/
+obj-$(CONFIG_PINCTRL_MSCC)		+= mscc/
+obj-$(CONFIG_PINCTRL_MTK)		+= mediatek/
+obj-$(CONFIG_PINCTRL_PIC32)		+= pinctrl_pic32.o
+obj-$(CONFIG_PINCTRL_QCOM)		+= qcom/
+obj-$(CONFIG_PINCTRL_QE)		+= pinctrl-qe-io.o
 obj-$(CONFIG_$(PHASE_)PINCTRL_ROCKCHIP)	+= rockchip/
-obj-$(CONFIG_ARCH_ASPEED) += aspeed/
-obj-$(CONFIG_ARCH_ATH79) += ath79/
-obj-$(CONFIG_PINCTRL_INTEL) += intel/
-obj-$(CONFIG_ARCH_MTMIPS) += mtmips/
-obj-$(CONFIG_ARCH_NPCM)         += nuvoton/
-obj-$(CONFIG_PINCTRL_QCOM) += qcom/
-obj-$(CONFIG_ARCH_RENESAS) += renesas/
-obj-$(CONFIG_PINCTRL_SANDBOX)	+= pinctrl-sandbox.o
-obj-$(CONFIG_PINCTRL_SUNXI)	+= sunxi/
-obj-$(CONFIG_$(PHASE_)PINCTRL_TEGRA)	+= tegra/
-obj-$(CONFIG_PINCTRL_UNIPHIER)	+= uniphier/
-obj-$(CONFIG_PINCTRL_PIC32)	+= pinctrl_pic32.o
-obj-$(CONFIG_PINCTRL_EXYNOS)	+= exynos/
-obj-$(CONFIG_PINCTRL_K210)	+= pinctrl-k210.o
-obj-$(CONFIG_PINCTRL_MESON)	+= meson/
-obj-$(CONFIG_PINCTRL_MTK)	+= mediatek/
-obj-$(CONFIG_PINCTRL_MSCC)	+= mscc/
-obj-$(CONFIG_ARCH_MVEBU)	+= mvebu/
-obj-$(CONFIG_ARCH_NEXELL)	+= nexell/
-obj-$(CONFIG_PINCTRL_QE)	+= pinctrl-qe-io.o
-obj-$(CONFIG_PINCTRL_SCMI)	+= pinctrl-scmi.o
-obj-$(CONFIG_PINCTRL_SINGLE)	+= pinctrl-single.o
-obj-$(CONFIG_PINCTRL_STI)	+= pinctrl-sti.o
-obj-$(CONFIG_PINCTRL_STM32)	+= pinctrl_stm32.o
-obj-$(CONFIG_$(PHASE_)PINCTRL_SX150X) += pinctrl-sx150x.o
+obj-$(CONFIG_PINCTRL_SANDBOX)		+= pinctrl-sandbox.o
+obj-$(CONFIG_PINCTRL_SCMI)		+= pinctrl-scmi.o
+obj-$(CONFIG_PINCTRL_SINGLE)		+= pinctrl-single.o
+obj-$(CONFIG_PINCTRL_STARFIVE)		+= starfive/
+obj-$(CONFIG_PINCTRL_STI)		+= pinctrl-sti.o
+obj-$(CONFIG_PINCTRL_STM32)		+= pinctrl_stm32.o
 obj-$(CONFIG_$(PHASE_)PINCTRL_STMFX)	+= pinctrl-stmfx.o
-obj-$(CONFIG_PINCTRL_TH1520)	+= pinctrl-th1520.o
-obj-y				+= broadcom/
+obj-$(CONFIG_PINCTRL_SUNXI)		+= sunxi/
+obj-$(CONFIG_$(PHASE_)PINCTRL_SX150X)	+= pinctrl-sx150x.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_TEGRA)	+= tegra/
+obj-$(CONFIG_PINCTRL_TH1520)		+= pinctrl-th1520.o
+obj-$(CONFIG_PINCTRL_UNIPHIER)		+= uniphier/
 obj-$(CONFIG_$(PHASE_)PINCTRL_ZYNQMP)	+= pinctrl-zynqmp.o
-obj-$(CONFIG_PINCTRL_STARFIVE)	+= starfive/
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
index 00000000000..1b3b5281aac
--- /dev/null
+++ b/drivers/pinctrl/airoha/airoha-common.h
@@ -0,0 +1,476 @@
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
+/* MUX */
+#define AN7581_REG_GPIO_2ND_I2C_MODE	0x0214
+#define EN7523_REG_GPIO_2ND_I2C_MODE	0x0210
+#define GPIO_MDC_IO_MASTER_MODE_MODE	BIT(14)
+#define GPIO_I2C_MASTER_MODE_MODE	BIT(13)
+#define GPIO_I2S_MODE_MASK		BIT(12)
+#define GPIO_I2C_SLAVE_MODE_MODE	BIT(11)
+#define GPIO_LAN3_LED1_MODE_MASK	BIT(10)
+#define GPIO_LAN3_LED0_MODE_MASK	BIT(9)
+#define GPIO_LAN2_LED1_MODE_MASK	BIT(8)
+#define GPIO_LAN2_LED0_MODE_MASK	BIT(7)
+#define GPIO_LAN1_LED1_MODE_MASK	BIT(6)
+#define GPIO_LAN1_LED0_MODE_MASK	BIT(5)
+#define GPIO_LAN0_LED1_MODE_MASK	BIT(4)
+#define GPIO_LAN0_LED0_MODE_MASK	BIT(3)
+#define PON_TOD_1PPS_MODE_MASK		BIT(2)
+#define GSW_TOD_1PPS_MODE_MASK		BIT(1)
+#define GPIO_2ND_I2C_MODE_MASK		BIT(0)
+#define NPU_UART_MODE_MASK		BIT(2)
+
+#define REG_GPIO_SPI_CS1_MODE		0x0218
+#define EN7523_REG_GPIO_SPI_CS1_MODE	0x0214
+
+#define GPIO_PCM_SPI_CS4_MODE_MASK		BIT(21)
+#define GPIO_PCM_SPI_CS3_MODE_MASK		BIT(20)
+#define GPIO_PCM_SPI_CS2_MODE_P156_MASK		BIT(19)
+#define GPIO_PCM_SPI_CS2_MODE_P128_MASK		BIT(18)
+#define AN7583_GPIO_PCM_SPI_CS2_MODE_MASK	BIT(18)
+#define GPIO_PCM_SPI_CS1_MODE_MASK		BIT(17)
+#define GPIO_PCM_SPI_MODE_MASK			BIT(16)
+#define GPIO_PCM2_MODE_MASK			BIT(13)
+#define GPIO_PCM1_MODE_MASK			BIT(12)
+#define GPIO_PCM_INT_MODE_MASK			BIT(9)
+#define GPIO_PCM_RESET_MODE_MASK		BIT(8)
+#define GPIO_SPI_QUAD_MODE_MASK			BIT(4)
+#define GPIO_SPI_CS4_MODE_MASK			BIT(3)
+#define GPIO_SPI_CS3_MODE_MASK			BIT(2)
+#define GPIO_SPI_CS2_MODE_MASK			BIT(1)
+#define GPIO_SPI_CS1_MODE_MASK			BIT(0)
+
+#define REG_GPIO_PON_MODE			0x021c
+#define EN7523_REG_GPIO_PON_MODE		0x0218
+#define GPIO_PARALLEL_NAND_MODE_MASK		BIT(14)
+#define GPIO_SGMII_MDIO_MODE_MASK		BIT(13)
+#define GPIO_PCIE_RESET2_MASK			BIT(12)
+#define SIPO_RCLK_MODE_MASK			BIT(11)
+#define GPIO_PCIE_RESET1_MASK			BIT(10)
+#define GPIO_PCIE_RESET0_MASK			BIT(9)
+#define GPIO_UART5_MODE_MASK			BIT(8)
+#define GPIO_UART4_MODE_MASK			BIT(7)
+#define GPIO_HSUART_CTS_RTS_MODE_MASK		BIT(6)
+#define GPIO_HSUART_MODE_MASK			BIT(5)
+#define GPIO_UART2_CTS_RTS_MODE_MASK		BIT(4)
+#define GPIO_UART2_MODE_MASK			BIT(3)
+#define GPIO_SIPO_MODE_MASK			BIT(2)
+#define GPIO_EMMC_MODE_MASK			BIT(1)
+#define GPIO_PON_MODE_MASK			BIT(0)
+
+#define REG_NPU_UART_EN			0x0224
+#define EN7523_REG_NPU_UART_EN		0x0220
+#define JTAG_UDI_EN_MASK		BIT(4)
+#define JTAG_DFD_EN_MASK		BIT(3)
+
+#define REG_FORCE_GPIO_EN		0x0228
+#define FORCE_GPIO_EN(n)		BIT(n)
+
+/* LED MAP */
+#define REG_LAN_LED0_MAPPING		0x027c
+#define REG_LAN_LED1_MAPPING		0x0280
+
+#define LAN4_LED_MAPPING_MASK		GENMASK(18, 16)
+#define LAN4_PHY_LED_MAP(_n)		FIELD_PREP_CONST(LAN4_LED_MAPPING_MASK, (_n))
+
+#define LAN3_LED_MAPPING_MASK		GENMASK(14, 12)
+#define LAN3_PHY_LED_MAP(_n)		FIELD_PREP_CONST(LAN3_LED_MAPPING_MASK, (_n))
+
+#define LAN2_LED_MAPPING_MASK		GENMASK(10, 8)
+#define LAN2_PHY_LED_MAP(_n)		FIELD_PREP_CONST(LAN2_LED_MAPPING_MASK, (_n))
+
+#define LAN1_LED_MAPPING_MASK		GENMASK(6, 4)
+#define LAN1_PHY_LED_MAP(_n)		FIELD_PREP_CONST(LAN1_LED_MAPPING_MASK, (_n))
+
+#define LAN0_LED_MAPPING_MASK		GENMASK(2, 0)
+#define LAN0_PHY_LED_MAP(_n)		FIELD_PREP_CONST(LAN0_LED_MAPPING_MASK, (_n))
+
+/* CONF */
+#define REG_I2C_SDA_E2			0x001c
+#define AN7583_I2C1_SCL_E2_MASK		BIT(16)
+#define AN7583_I2C1_SDA_E2_MASK		BIT(15)
+#define SPI_MISO_E2_MASK		BIT(14)
+#define SPI_MOSI_E2_MASK		BIT(13)
+#define SPI_CLK_E2_MASK			BIT(12)
+#define SPI_CS0_E2_MASK			BIT(11)
+#define EN7523_SPI_MISO_E2_MASK		BIT(13)
+#define EN7523_SPI_MOSI_E2_MASK		BIT(12)
+#define EN7523_SPI_CLK_E2_MASK		BIT(11)
+#define EN7523_SPI_CS0_E2_MASK		BIT(10)
+#define PCIE2_RESET_E2_MASK		BIT(10)
+#define PCIE1_RESET_E2_MASK		BIT(9)
+#define PCIE0_RESET_E2_MASK		BIT(8)
+#define AN7583_MDIO_0_E2_MASK		BIT(5)
+#define AN7583_MDC_0_E2_MASK		BIT(4)
+#define UART1_RXD_E2_MASK		BIT(3)
+#define UART1_TXD_E2_MASK		BIT(2)
+#define I2C_SCL_E2_MASK			BIT(1)
+#define I2C_SDA_E2_MASK			BIT(0)
+
+#define REG_I2C_SDA_E4			0x0020
+#define AN7583_I2C1_SCL_E4_MASK		BIT(16)
+#define AN7583_I2C1_SDA_E4_MASK		BIT(15)
+#define SPI_MISO_E4_MASK		BIT(14)
+#define SPI_MOSI_E4_MASK		BIT(13)
+#define SPI_CLK_E4_MASK			BIT(12)
+#define SPI_CS0_E4_MASK			BIT(11)
+#define EN7523_SPI_MISO_E4_MASK		BIT(13)
+#define EN7523_SPI_MOSI_E4_MASK		BIT(12)
+#define EN7523_SPI_CLK_E4_MASK		BIT(11)
+#define EN7523_SPI_CS0_E4_MASK		BIT(10)
+#define PCIE2_RESET_E4_MASK		BIT(10)
+#define PCIE1_RESET_E4_MASK		BIT(9)
+#define PCIE0_RESET_E4_MASK		BIT(8)
+#define AN7583_MDIO_0_E4_MASK		BIT(5)
+#define AN7583_MDC_0_E4_MASK		BIT(4)
+#define UART1_RXD_E4_MASK		BIT(3)
+#define UART1_TXD_E4_MASK		BIT(2)
+#define I2C_SCL_E4_MASK			BIT(1)
+#define I2C_SDA_E4_MASK			BIT(0)
+
+#define REG_GPIO_L_E2			0x0024
+#define REG_GPIO_L_E4			0x0028
+#define REG_GPIO_H_E2			0x002c
+#define REG_GPIO_H_E4			0x0030
+
+#define REG_I2C_SDA_PU			0x0044
+#define AN7583_I2C1_SCL_PU_MASK		BIT(16)
+#define AN7583_I2C1_SDA_PU_MASK		BIT(15)
+#define SPI_MISO_PU_MASK		BIT(14)
+#define SPI_MOSI_PU_MASK		BIT(13)
+#define SPI_CLK_PU_MASK			BIT(12)
+#define SPI_CS0_PU_MASK			BIT(11)
+#define EN7523_SPI_MISO_PU_MASK		BIT(13)
+#define EN7523_SPI_MOSI_PU_MASK		BIT(12)
+#define EN7523_SPI_CLK_PU_MASK		BIT(11)
+#define EN7523_SPI_CS0_PU_MASK		BIT(10)
+#define PCIE2_RESET_PU_MASK		BIT(10)
+#define PCIE1_RESET_PU_MASK		BIT(9)
+#define PCIE0_RESET_PU_MASK		BIT(8)
+#define AN7583_MDIO_0_PU_MASK		BIT(5)
+#define AN7583_MDC_0_PU_MASK		BIT(4)
+#define UART1_RXD_PU_MASK		BIT(3)
+#define UART1_TXD_PU_MASK		BIT(2)
+#define I2C_SCL_PU_MASK			BIT(1)
+#define I2C_SDA_PU_MASK			BIT(0)
+
+#define REG_I2C_SDA_PD			0x0048
+#define AN7583_I2C1_SDA_PD_MASK		BIT(16)
+#define AN7583_I2C1_SCL_PD_MASK		BIT(15)
+#define SPI_MISO_PD_MASK		BIT(14)
+#define SPI_MOSI_PD_MASK		BIT(13)
+#define SPI_CLK_PD_MASK			BIT(12)
+#define SPI_CS0_PD_MASK			BIT(11)
+#define EN7523_SPI_MISO_PD_MASK		BIT(13)
+#define EN7523_SPI_MOSI_PD_MASK		BIT(12)
+#define EN7523_SPI_CLK_PD_MASK		BIT(11)
+#define EN7523_SPI_CS0_PD_MASK		BIT(10)
+#define PCIE2_RESET_PD_MASK		BIT(10)
+#define PCIE1_RESET_PD_MASK		BIT(9)
+#define PCIE0_RESET_PD_MASK		BIT(8)
+#define AN7583_MDIO_0_PD_MASK		BIT(5)
+#define AN7583_MDC_0_PD_MASK		BIT(4)
+#define UART1_RXD_PD_MASK		BIT(3)
+#define UART1_TXD_PD_MASK		BIT(2)
+#define I2C_SCL_PD_MASK			BIT(1)
+#define I2C_SDA_PD_MASK			BIT(0)
+
+#define REG_GPIO_L_PU			0x004c
+#define REG_GPIO_L_PD			0x0050
+#define REG_GPIO_H_PU			0x0054
+#define REG_GPIO_H_PD			0x0058
+
+#define REG_PCIE_RESET_OD		0x018c
+#define PCIE2_RESET_OD_MASK		BIT(2)
+#define PCIE1_RESET_OD_MASK		BIT(1)
+#define PCIE0_RESET_OD_MASK		BIT(0)
+
+/* GPIOs */
+#define REG_GPIO_CTRL		0x0000
+#define REG_GPIO_DATA		0x0004
+#define REG_GPIO_INT		0x0008
+#define REG_GPIO_INT_EDGE	0x000c
+#define REG_GPIO_INT_LEVEL	0x0010
+#define REG_GPIO_OE		0x0014
+#define REG_GPIO_CTRL1		0x0020
+
+/* PWM MODE CONF */
+#define REG_GPIO_FLASH_MODE_CFG		0x0034
+#define GPIO15_FLASH_MODE_CFG		BIT(15)
+#define GPIO14_FLASH_MODE_CFG		BIT(14)
+#define GPIO13_FLASH_MODE_CFG		BIT(13)
+#define GPIO12_FLASH_MODE_CFG		BIT(12)
+#define GPIO11_FLASH_MODE_CFG		BIT(11)
+#define GPIO10_FLASH_MODE_CFG		BIT(10)
+#define GPIO9_FLASH_MODE_CFG		BIT(9)
+#define GPIO8_FLASH_MODE_CFG		BIT(8)
+#define GPIO7_FLASH_MODE_CFG		BIT(7)
+#define GPIO6_FLASH_MODE_CFG		BIT(6)
+#define GPIO5_FLASH_MODE_CFG		BIT(5)
+#define GPIO4_FLASH_MODE_CFG		BIT(4)
+#define GPIO3_FLASH_MODE_CFG		BIT(3)
+#define GPIO2_FLASH_MODE_CFG		BIT(2)
+#define GPIO1_FLASH_MODE_CFG		BIT(1)
+#define GPIO0_FLASH_MODE_CFG		BIT(0)
+
+#define REG_GPIO_CTRL2	0x0060
+#define REG_GPIO_CTRL3	0x0064
+
+/* PWM MODE CONF EXT */
+#define REG_GPIO_FLASH_MODE_CFG_EXT	0x0068
+#define GPIO51_FLASH_MODE_CFG		BIT(31)
+#define GPIO50_FLASH_MODE_CFG		BIT(30)
+#define GPIO49_FLASH_MODE_CFG		BIT(29)
+#define GPIO48_FLASH_MODE_CFG		BIT(28)
+#define GPIO47_FLASH_MODE_CFG		BIT(27)
+#define GPIO46_FLASH_MODE_CFG		BIT(26)
+#define GPIO45_FLASH_MODE_CFG		BIT(25)
+#define GPIO44_FLASH_MODE_CFG		BIT(24)
+#define GPIO43_FLASH_MODE_CFG		BIT(23)
+#define GPIO42_FLASH_MODE_CFG		BIT(22)
+#define GPIO41_FLASH_MODE_CFG		BIT(21)
+#define GPIO40_FLASH_MODE_CFG		BIT(20)
+#define GPIO39_FLASH_MODE_CFG		BIT(19)
+#define GPIO38_FLASH_MODE_CFG		BIT(18)
+#define GPIO37_FLASH_MODE_CFG		BIT(17)
+#define GPIO36_FLASH_MODE_CFG		BIT(16)
+#define GPIO31_FLASH_MODE_CFG		BIT(15)
+#define GPIO30_FLASH_MODE_CFG		BIT(14)
+#define GPIO29_FLASH_MODE_CFG		BIT(13)
+#define GPIO28_FLASH_MODE_CFG		BIT(12)
+#define GPIO27_FLASH_MODE_CFG		BIT(11)
+#define GPIO26_FLASH_MODE_CFG		BIT(10)
+#define GPIO25_FLASH_MODE_CFG		BIT(9)
+#define GPIO24_FLASH_MODE_CFG		BIT(8)
+#define GPIO23_FLASH_MODE_CFG		BIT(7)
+#define GPIO22_FLASH_MODE_CFG		BIT(6)
+#define GPIO21_FLASH_MODE_CFG		BIT(5)
+#define GPIO20_FLASH_MODE_CFG		BIT(4)
+#define GPIO19_FLASH_MODE_CFG		BIT(3)
+#define GPIO18_FLASH_MODE_CFG		BIT(2)
+#define GPIO17_FLASH_MODE_CFG		BIT(1)
+#define GPIO16_FLASH_MODE_CFG		BIT(0)
+
+#define REG_GPIO_DATA1			0x0070
+#define REG_GPIO_OE1			0x0078
+#define REG_GPIO_INT1			0x007c
+#define REG_GPIO_INT_EDGE1		0x0080
+#define REG_GPIO_INT_EDGE2		0x0084
+#define REG_GPIO_INT_EDGE3		0x0088
+#define REG_GPIO_INT_LEVEL1		0x008c
+#define REG_GPIO_INT_LEVEL2		0x0090
+#define REG_GPIO_INT_LEVEL3		0x0094
+
+#define AIROHA_NUM_PINS			64
+#define AIROHA_PIN_BANK_SIZE		(AIROHA_NUM_PINS / 2)
+#define AIROHA_REG_GPIOCTRL_NUM_PIN	(AIROHA_NUM_PINS / 4)
+
+/* PWM */
+#define AIROHA_PINCTRL_PWM(gpio, mux_val)		\
+	{						\
+		.name = (gpio),				\
+		.regmap[0] = {				\
+			AIROHA_FUNC_PWM_MUX,		\
+			REG_GPIO_FLASH_MODE_CFG,	\
+			(mux_val),			\
+			(mux_val)			\
+		},					\
+		.regmap_size = 1,			\
+	}						\
+
+#define AIROHA_PINCTRL_PWM_EXT(gpio, mux_val)		\
+	{						\
+		.name = (gpio),				\
+		.regmap[0] = {				\
+			AIROHA_FUNC_PWM_EXT_MUX,	\
+			REG_GPIO_FLASH_MODE_CFG_EXT,	\
+			(mux_val),			\
+			(mux_val)			\
+		},					\
+		.regmap_size = 1,			\
+	}						\
+
+#define AIROHA_PINCTRL_PHY_LED0(variant, gpio, mux_val, map_mask, map_val)	\
+	{									\
+		.name = (gpio),							\
+		.regmap[0] = {							\
+			AIROHA_FUNC_MUX,					\
+			variant##_REG_GPIO_2ND_I2C_MODE,			\
+			(mux_val),						\
+			(mux_val),						\
+		},								\
+		.regmap[1] = {							\
+			AIROHA_FUNC_MUX,					\
+			REG_LAN_LED0_MAPPING,					\
+			(map_mask),						\
+			(map_val),						\
+		},								\
+		.regmap_size = 2,						\
+	}
+
+#define AIROHA_PINCTRL_PHY_LED1(variant, gpio, mux_val, map_mask, map_val)	\
+	{									\
+		.name = (gpio),							\
+		.regmap[0] = {							\
+			AIROHA_FUNC_MUX,					\
+			variant##_REG_GPIO_2ND_I2C_MODE,			\
+			(mux_val),						\
+			(mux_val),						\
+		},								\
+		.regmap[1] = {							\
+			AIROHA_FUNC_MUX,					\
+			REG_LAN_LED1_MAPPING,					\
+			(map_mask),						\
+			(map_val),						\
+		},								\
+		.regmap_size = 2,						\
+	}
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
index 00000000000..187c0fbf670
--- /dev/null
+++ b/drivers/pinctrl/airoha/pinctrl-airoha.c
@@ -0,0 +1,927 @@
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
+				 unsigned int selector,
+				 unsigned int group)
+{
+	const struct airoha_pinctrl_func *func;
+	const struct pingroup *grp;
+	int i;
+
+	func = &pinctrl->data->funcs[selector];
+	grp = &pinctrl->data->grps[group];
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

