Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A28C8C43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 11:59:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAC0C84B36;
	Fri,  3 Jul 2026 13:57:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="WfZ1OHk9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58F2184AF6; Fri,  3 Jul 2026 13:57:48 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B395A84B02
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 13:57:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4MKwtUWpqm4IiTjEyCFjqT3H71ZNMPew9szK3SEoVYsn4aHMa+v5cp7g0+D19qPQtdRc8Ia8JPBvIp1VfrvJ1bsdPRIdHVO5xqaMEMTHc43VYYCvagVc4AiCEckGOw+eIIvP3NbPl8N8bz5+04EOmg6ZNyXfFT6aJcZMMwdLAm7IvZDBqDnfZLa9sQO73Sq65s/x9OUNUd8oO4PhZDvVyOx7Ef8mGWN2Vg2dtX5mX3oKek8JhTNcowv4vk7iO2T9KnPG8NxbuZPw3oBtja7gpUx5Z528ToEn+DC+IarnTrhvH08N7haPyFc1x2pdqnRXbPkUCbMaqQWbjyAmuOTjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CTuSEJtUONRqJV+obdsb4ncvj1FKSUiAO0dNj6Vmt8=;
 b=jBZA7J84piMfzjQTFfhd8c8UtytvSeexBAMWCr1xLvjP0X7R/HFicLBKHqamLdi7HwyZfGOlPojQ0RQt4igMTlngnGsxGVWiiuOLGk+E74m8xjvnP9GQEWy++eud/ppodLFh/EfwAp5xlZzjurJJ2Yj7K9hDQhcTSBDt3TXHMM1Mnrr8JS+dl7w1oDzA6fY8mHGfX8Flq4LbW8N6b/cHXlfBpuqkkVBT+/wK34TtqVzwvEt5od8KTQbEtDz6u3/q26d2lylsSRj1Ub/xxFlhmiYIta1mgXDuT5NbwUGPzmGEgFiB0UyfYoMJnLKQ3TasH9nVl7iBbItiY0JbFMIfgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CTuSEJtUONRqJV+obdsb4ncvj1FKSUiAO0dNj6Vmt8=;
 b=WfZ1OHk90ps4t8+NHmtpqWBjtdF1e7267SrPnhenH59HQwFyq+5dFhIDvCbL8rJ54YoNhAqrN/hnq9GZ3gEd5Pb/RL+GIGvRsqO9jvxByF4XpTLD0LMW/gIQBiTffJ8gGUGGWiEs606owJfC2m8wD9VwqHQoTBJNGg78Uq+0RiLd/Xb2lB3Ur8THWt0Pe+zsoZxxV+snYx9F9+lPkLNHWDxarw7wdd00Xve/LgrYImpE5l+nWntpsTk597EgpSABUBY0i/F7oWMDtrhCpeKi9ViXfw1JJKoyB5oXTAYSarvc4Sdd7LWBJgbrevoxSSdVV1g0Bgko+5ahzp7UQ9weVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV2PR08MB8172.eurprd08.prod.outlook.com (2603:10a6:150:7c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 11:57:28 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0159.018; Fri, 3 Jul 2026
 11:57:28 +0000
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
 Michal Simek <michal.simek@amd.com>,
 Sean Anderson <sean.anderson@linux.dev>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v15 17/24] pinctrl: sort and format the contents of the
 makefile
Date: Fri,  3 Jul 2026 14:56:20 +0300
Message-ID: <20260703115627.2317120-18-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703115627.2317120-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260703115627.2317120-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0194.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::18) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV2PR08MB8172:EE_
X-MS-Office365-Filtering-Correlation-Id: a3f7e8cb-7513-446b-b651-08ded8fa415f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|52116014|23010399003|56012099006|11063799006|18002099003|22082099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info: dHng3DRZT10KRXaT/ezERh+VOiPPGz2qzrnOBivfJkuKl8R3J7tT5U9l3qIn5jZvt6RcOmToRRp3vE7+g9gxtG6Z8BLxbkP6cKV5eDE1G6fn9OnZNRv41QGQFb+M4a++dHI+MnTaHOLkEKYfjPJ4RQU1Qok3bgyeUvF64hSf9cH4I8RpytTCJ2cqhHzo+F3nuAyj5N2vPffl2iJU1/a3SFujUVB8jvhFY6ak7nfFVwx8W17qpHPvLmzTu3rQ0oSSeQfmYdReDg1yucdt/F867vYLLAvWmQD+m09ENrsLDPukP/v/bQ2YaUxiUbn7bHPQicZ8Fe9Xp8cnw1w/zPv0J+OFTCpmAtCi6mx4KBjTpcoTRZSCgQkTBwBPcdghUMqi2moD3I/giASQXUBBMEd+8hwskzUoLUKFAjWKbRd7rxZHe95Qmyi+AyxNs08h416PaDRwi3YdBcH6LGKqwTPXhfMQ+U4WWT8xM3QGquIkqG8Kvc72IqUnDu3bl//fuLgpPMrtsXbGlutkESQwl34g63hFa/iulp4i/T/oT2b8vRqFz4EfiXdevZf+OHwX8QLMzPQnneT42FhTcV2jIvuMeHrdZnM+LvwRD59KDaEpmwAQvQxcmro0wJU/Lqiiu5tWaacKRcRSTee61hFqBB7c9IuH16Dr00MXsYi3n6s6qaRg2yoaIzkQbruOJEJCCVYQ/tmNoFrdL64yEGlA34BSK5gtQLSkMiCKFjg8a0p0iXcnl8QwA5TIBBW77RCsFrCL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(23010399003)(56012099006)(11063799006)(18002099003)(22082099003)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eoMkj8F0PNe7wigVCOTrXPthPbg8IpXKq/60oFn5F+HL32xt5c1MnDjZcYfo?=
 =?us-ascii?Q?CLNpbJdYXVnsxTuVW/KrlLl1gIDIE4vMlvJPX/GIhNRvM7SUtbZEzmPGkKlO?=
 =?us-ascii?Q?tVUZsWRwk/xpCO3QTckHLR/Dpsq3i0DQp/oGszii62EmkfD//kML/j7lt5r8?=
 =?us-ascii?Q?VrGde6lIXPFG0vtvPkbmYxSekkJxONQ3i0UsIkH2pu+7oayboBC8wd0rLp3J?=
 =?us-ascii?Q?JaXXtMW8YPA4aUGU8m+cpa6uFs+QTJIAdMlKLinBXYrZ1QouxgL57cBJLjtT?=
 =?us-ascii?Q?C8WopFgwFUwun6YUrdxuoe+d4ELHlov+IWyeL0mAJrp+elMHnQbMjElAJK0m?=
 =?us-ascii?Q?+V7IYey3V0We4BhrVD0vy16yHIdMJwRNaQjKVi1mG1oHeYw9YT3085Ts2Ub2?=
 =?us-ascii?Q?BufpwLf/9TktT+452M3IFJxC+AfLUG2FmYU1glqOSCuLpgaK+YW3IaGXF11w?=
 =?us-ascii?Q?yosQEH8nkj4NbasdMAPo6Iy+eCCjFXf6+Z65Pu8cq05FYw3p4RhFQjhMX+Qr?=
 =?us-ascii?Q?RqcCkGy1lcN+xCbUDQia7RHur/UQVTTuYsV2wuX2JpZwMx6RK6UIK2WqWNq7?=
 =?us-ascii?Q?j5dqo360tawnhD07r4QRGwtV+tbwK1YsefZU9XNFDXdHMVD5r5S9VLHzRyN6?=
 =?us-ascii?Q?AhS7DZNSPZSBRGjeN/NI1vt2AgbpBZdURovYBkAgMUNipfoDeycuVDG19FU0?=
 =?us-ascii?Q?3oo/KLbKq7/plEVFeBS98dKdfRKrQaMMa+1JrkhzOJTqIToOJZHU0mkDdxQe?=
 =?us-ascii?Q?UhNJa8xpoqOKmLEMzKF9/gaPmzMh3PoSpwtAkacuF5pNPhM6mSyMzMToZxpV?=
 =?us-ascii?Q?AXCJCG2XcChGgJfjAFlWw1nCqumgyjyGSQ84RxV1KUVMb+z27lEj04MfUVxf?=
 =?us-ascii?Q?fGkGKKbycvxu/hv8k5fTKvv+0m8HhyOvLxshv9gtWcNcL8HCZpBo6SB87d0+?=
 =?us-ascii?Q?dUZ7LhAoVdaG8C5m4pNz1hwQ7MArJbrjCID+ooN4eUzcEanHV+Ahjx9JwzN1?=
 =?us-ascii?Q?Tsh1hq5Ea0SYxSD7ex1Gb9ZSy3RQ02XfqjTq879IDuIRROKeSlFuQsYXjAkt?=
 =?us-ascii?Q?SnbUxcueQDsVXAUjSMEQNa0Ugx7N6EyMhhjiV+lxFEKlaPt9gQsrK/lk3Qjf?=
 =?us-ascii?Q?2A3Tbk+CiDIwYC/UcRV48u5LAPSWEq9pr9ugWSYPbfaT+uEyJvAzrwJMVCuE?=
 =?us-ascii?Q?KCXhF5V6dRd5UAlAVGIu1DD+KXr0Jmi+0xPXKujtfsyHqE6kxKOr/DhspIBd?=
 =?us-ascii?Q?5g0JCL+n6uSo0Zj1OjZQq2jU67TYUyZ/t/Wo86no12Dm3xC6Wwb5hgUTJCnq?=
 =?us-ascii?Q?sD6IWv2xC4W4Af52vC5Iln0jdhqYRmOykxrLNtqt2cAUt7aHyd021qjBPBC0?=
 =?us-ascii?Q?apsb98inPXjvUMzRHFHRgZtH6ajGoafxgJP1e6Muitjtrv9D1NmzLGvbZ+Qh?=
 =?us-ascii?Q?Y3nVdEtEq/kK7MFjXKeayg7NaQiroH7PeUdC4NjGWFedwr2AaGgHCrCxg5br?=
 =?us-ascii?Q?AzmOJrkcIuT6LW+jliujvcsMIxVQ2Gx4d5Y5Ze+pJMFqu2mLGl/tcnVAQlFp?=
 =?us-ascii?Q?eqsKF9C1f/yt3SkCxG1uonZpGJHw76VpJbcx/xx4j6LhYJtoyPOUljO0JgnE?=
 =?us-ascii?Q?3OlmsnTIE+KEIJuCj9QiuLJW6oW/X+pSpfnzgD5XUaSLvmtvx0JgULSw3L+2?=
 =?us-ascii?Q?5aZKD1ljF4+y/SmrSFMEjR7On3xaQ7plq+hbLXXl+tF8tkuxOGrIJ/LaJfSi?=
 =?us-ascii?Q?HrlVCCPIUUrL8WR/DU7xtyrGmNsTawQ=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f7e8cb-7513-446b-b651-08ded8fa415f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 11:57:28.4936 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zFIu7GM2a5QKzheWkFutoxwwxjQW0oVNYhA4RvHWPifGhpsUN9YaBG/DHZhqvzU304nw742QSQLzBQpSQkfZgjrUe9P3GxDMc2FaLtqBbdc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8172
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

sorting rules:
 * rules for generic pinctrl files placed first,
 * obj-y rules,
 * obj-$(CONFIG_ARCH_something) rules
 * obj-$(CONFIG_PINCTRL_something) rules

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
 drivers/pinctrl/Makefile | 60 +++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 29fb9b484d0..df52c6db8c2 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -3,39 +3,41 @@
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
-- 
2.53.0

