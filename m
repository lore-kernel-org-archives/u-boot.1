Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF8ABC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 05:59:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88A3884CBD;
	Thu,  2 Jul 2026 07:58:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="HJSza8Al";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DA8884C6D; Thu,  2 Jul 2026 07:58:27 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A79A84CA3
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 07:58:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=koX7X3Ih9HHgPyaUa4AYAbdgkDLsm5vefteNFu/Sj5zSGRgVEHrNIH71aKiKmsWtVBGviahURvG6KiRanKEwt+pIETBXHYVHbSn4RHBpjEqJ9nVjPKU2v2fL/uObkR4p3TH/AqXy6unVJfkga7idLY2fW7fgh2QMhxtxMqoMR0gKQOeJSFlidraqLt8YHb6mFPy2u6uKSK04kAPpSPALxM1ct6CQ+ykPu7SzwTGQ5bUjPlp2lXIzB0of1qR2naKcULrQqRsQD/WSpvsF7pa83VaDRBG6UYgqHrd6DBUgoa1A83M1X6D+tkEGZ4WBeR3rOBQ1R9U0zbDFEqPwAJlcNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CTuSEJtUONRqJV+obdsb4ncvj1FKSUiAO0dNj6Vmt8=;
 b=iNCD5eH1cbzyQ+OoZGdHNlEI4FMDHevnurDB6soEijdWmsmeZFlwc0/nvo+iuw/pxUpcMcvpPgUSEgufx8stpNOpiO5xuh9Yi3DdcpMlmacNhZ7K+AeJjXuonuaMuUO+0GEb0FtjoSDR3k/vTMlZjAa0MDzsOfvEz5ddZqCoH1ioLq2yVYchFDgB647YHht9WilurPVNL3HWXcaczv5Y8DY/V/g7baIHyA5+tIGOafytvu85i/TZEkxv5xnH21VQx40hP+YV4ndUXb0HWJ32Wbm1StPpeQ+LJDIgbn51NrbIgTHSzt4XHPBwamEENILnmMZHRsBUM7/kQxMwqhFQRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CTuSEJtUONRqJV+obdsb4ncvj1FKSUiAO0dNj6Vmt8=;
 b=HJSza8Al6BJZEYv3fw8h30/i5gluiQcyRunFDuN6S9cLnVmTC2qEyoS11tdsV/Vs8DYfrWkVjy4X59YMxy98bWEhMAxkYbRBZ7mUvy/GFr8kvPZ8/J6RSnyJrIusBP2dTk725FxFHomNCR+sRJhUlQxkYKk6FoZTs2sG6AUOMNHMT/BtnqZtj0OsrWXRnjcIH/3dD/qeJbIwhczEtsOBoSIZYOw38nXhwCjYHtwJwijPcBXmh9wPo4uMo43kaZfrgk0tAqmDizvkR6C0t7Noc2Q1SeSTZIQ0j5iZc/5W9uuEqSOnmjt8aLbQJ8OdeMsi/ruZ+6cCGCzwwebtJfTWOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DBBPR08MB10433.eurprd08.prod.outlook.com (2603:10a6:10:52f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Thu, 2 Jul 2026
 05:58:23 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0159.018; Thu, 2 Jul 2026
 05:58:23 +0000
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
Subject: [PATCH v14 11/18] pinctrl: sort and format the contents of the
 makefile
Date: Thu,  2 Jul 2026 08:57:37 +0300
Message-ID: <20260702055744.2164975-12-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DBBPR08MB10433:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a20b315-d5b2-4f3f-927a-08ded7feecce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|1800799024|23010399003|366016|921020|38350700014|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: PhbtkJHPUn9uU3lMdovtsnG/RVdkrQajDALsuzW4vZ90FtWuDgMVJhMbGpewOv/V4TTRUlHM6tKeSRwMUeRODekW3gNzyrFJh+k0Vvjg9Ij86VkoctQ6TB9v0KkWHgxDr+LruWFUmaRTEAEEO2bY82u8iXYLEd6i6Vf/oDUczex6vU5jTFV0DfYEzFICQI1k5l25dFOy6fp0LWaT9NXuuoTC5lvWDphsw05WFda4umBszZ9AXdiYbZbRkiMuUJUsM16nsA9HcGHhn0HBa0ZII3lbRAm4JbCLoEMZLq7eRzbzSQNkX3QWno2nyjQdRkNJ2EzdjPnU3c8KZLpyVgrbj9nymamTRw4M8rr1XoErqcQJJXpkBf/vka7z1lcB8T+FbbQgFMlgK7Za6fxKnmW0bFGWHSbh8brsHrfyoUCqTrUGx+fYS3bdMkQHnGi/l4yeEs2ZPRtHRi3mcknZ2RxCEm20mUjfwvfGL//Q1aEPY6NNMM2lyBw6n+Ko+9nHJSs2PJ+OqR1nriReQ7z8IcLUT4C4iF7k59gl5fxr4VvfYBU/beiX+/kEIWtWEMufGvAV3/wPICsD+MoM8FwOnpavl10dmQwn05AEEu4KEquo8SC7XN29B6ukJTI9z/aofbDLf+r2pFi+KDtwK15UHif5qKAIqWEW/KdMOSAxEVhGR/3m4IIbYTTaOb4J5qSMPyIk3PX/4yyKNho7ZbFoqF+EXIT9n0xnR43Ddh+I1laSQdOwxfwGuQ5bvzOyjK9t0VZL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(23010399003)(366016)(921020)(38350700014)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/zgnxAQ2L6drny1eUfqVFCTbY6gYGjl9xojw/q6v7YUGVKCy5c6LbQoHORqX?=
 =?us-ascii?Q?Si7ZkVTKSaHklk8BQ4ZyNP1xX4YscW0kP2v57FB/aur4LclliyjFMyGrRHmR?=
 =?us-ascii?Q?8lNonTki2rrOHIoU9J7Lx0NotU3+pySTcInGqOJHvqylTHN9Kmjtvms83c4J?=
 =?us-ascii?Q?pXvuQ+fmWJqAbP10yaC6xGuyhDNmGRcEBWDqo8Mw3MwA6iGI60/CSj/bslrR?=
 =?us-ascii?Q?oNYpjivxOV/XqFtYlQHcY3HALibcXnEIt1rGLkxg4LqhRXzr/p6WXMj+6ZaY?=
 =?us-ascii?Q?IU5Cvs9wxPBiYw+QY6V8FyJeqcYawqcO78dcKVDquZqFfmw9CoIOJ/QNil2D?=
 =?us-ascii?Q?Z9lgFHxnKla0hz7FDoIFk7JvVuH/THYWif/lZitGLWC9BgBrO3A8x0ZKuBc/?=
 =?us-ascii?Q?2oEBcKzf63Sqzv/eQNRcRvIMkgdsYAaNHq9BE9xRyVI3ZSgVNu3t6TYkVfa5?=
 =?us-ascii?Q?4LamIO6hlK0F8B8jFB14EZBAD3orT4FwXzbv3vvYyXT9aH18QJKBsWlB47aJ?=
 =?us-ascii?Q?yAJoeUoc8RdvoTOK4TjplfQl1/ZqBIOMiOvrIWviYV0fLLcdSBSaZ/rYy2KK?=
 =?us-ascii?Q?cvHv9CXNlSjxHijqIX8eBb6dxSS5eoPQxzC5pYtPVr7FstzyPfS5/BaysTT0?=
 =?us-ascii?Q?5v95u9mN704eNuS2YIx/1JW/SqL7WC6NCpc/q+wpht1nRsQXtsDkcQ2bddQ3?=
 =?us-ascii?Q?BhbwMRoBHePDOiHaIrGgXLULMiqnPoOZmfOt1sDmGNsUsdQl3uQkn5Yz9A4F?=
 =?us-ascii?Q?EVQvXWD0WeqNTWeRR5T7ko/bH43TZuZdboac6IjYqzBUOL11T4Tbvvkw4p45?=
 =?us-ascii?Q?69MSPnZC7UewA2jE8vEp0qRZIqWjGLG8Y3QtzQGWtVk8Z5+z0kKpRI4ZAws5?=
 =?us-ascii?Q?u5lHyiAH3ak5RBJiBNJnq0oN1VGUUR6gISGYdqHizIq3M7ONc1aBvlHBY82t?=
 =?us-ascii?Q?9BVrrUIEI2iSiQDr7ILLa1Kz5usjvrC2JBhXiPZXNN1Q+jOMMOk+STMPWOJR?=
 =?us-ascii?Q?BLxkVos1pkXztzawHi2gR0kHjBT5TBuvyX7lPbvMC9c757jBauEyZQTCDd0I?=
 =?us-ascii?Q?bwdXPMtHIzY80P6EgQemZHoErAXU6Aq0y1bvL24NL0J22wRmhp7Wr9IPwjH5?=
 =?us-ascii?Q?BvmAa2ivwYTkhUqkZh55ZLfPoGqXwP27X3rFBTWGl+xqIAr4QH74YM2U5Rhr?=
 =?us-ascii?Q?h8AMAnebM0+b5rXuPv3pTrW9UDvKOw1NBDzUxHMWS7rkVqixyyReQQ/UdP/M?=
 =?us-ascii?Q?PvkPb67kDGEZrsW8ycdG6/EFwWnGW70PJ+6h0NZqkDm6Ti+tDqISUBnOOoim?=
 =?us-ascii?Q?n1TSZPzSq8dir2SoDPY6CgiETdvrosi5J7fqwrHHu+58WQtjRv3qoGNfEJZn?=
 =?us-ascii?Q?knh14hQ8pdPgJHF9kQHJ4TYQvd9AF/Ipl8b9TKLh9ixFG82smnbkjnJlR2hn?=
 =?us-ascii?Q?fGAmaH3UdynORTFArSxPg60jmhrzasaXLYJqnxRmgsg4ZQerVcP6vXHB46gY?=
 =?us-ascii?Q?EDQzpdaZ8ZnpyguPzNNXXIvioW8s2wBhkLZbBtQBlHCUb8zmv3LSlzv3fmq3?=
 =?us-ascii?Q?sRxBVKdmDWpTVfYXYXItbhnZ3FHZ2wagofIRqQyAMqzk+U9NQpFA9uUj+cJa?=
 =?us-ascii?Q?vobFMmRwqPLCNZ9sTLNs3XReALzr2q5tjsawp9V7HtSh6Lmvp8QzygMK1p7H?=
 =?us-ascii?Q?azqomFnaftzJOj/UuUSz2Lw4t0LiDehfg7g1QqaxpB3uXI/8T5nc/Cf892FY?=
 =?us-ascii?Q?SV0l2FJJcrvlGt83l4hUF37NgJzgMxo=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a20b315-d5b2-4f3f-927a-08ded7feecce
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 05:58:22.9365 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n5C2hAbvMwBtvss/km0cXtycfgprD6i5k7idINkwhiG9AlKq0t6BNmA4+HRIcU2x3XMR5eZEVpUpYtcvXgChVIatkoNHChVSWNlcEFPUX6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10433
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

