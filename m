Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6DBCD343F
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 23:52:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67510846CE;
	Tue, 19 May 2026 01:51:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="BWG0f4RD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EEA3846FA; Tue, 19 May 2026 01:51:36 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58B99846E9
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 01:51:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nQB/uk3sP1UL7IJjbUCuIaxVAfQKeZ1gB4r8d6HKCwj4NcZCvxO+helXmkDZT13xHIOcM4HEauxSroJrCjhcO67OcbSM+EKNwk72W7nFKNsGlhbko3nHfUtyQpHFv8HrgltI3UgDbN4fVVq3xAafnc4u+4KBOCZsH3VOmBgzCcwjb4e2wWwro4G1arZXEz/qQwb9of++30MqnTHnjRZrK/pM1q1uq2dAHwHy/5mkuXTQxrcDDyMrBL7unbDB/4guUcGCADSxq6JpaIxCCFuQIvpujXuaqqyvWOaxaArtAC16K6WUNgPawXGymeyZv0r7w5PlI18ECY7cIxH4nl178Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CTuSEJtUONRqJV+obdsb4ncvj1FKSUiAO0dNj6Vmt8=;
 b=cIfAwau1x2gqgGERWXV8t/qjoGg8hMPbPmMvqWHmQkRgl1KF+zqfzlQC+0+Jlo4yP5nS57jFZsZ9wra/pI7sog9KxVNODTcDHdDEFqv0hvqGqi1JOIz5/+xuv36gpUQ3FXs8KP9xcrAhpe8m/M/fpCfybkmChO8aQErJgwDhIjNFNtkRTPzdbuXZX2W5cXUStd90rm4ilpQFL4KYPd0GgU0nyezANTIxXP506SImWDl/mYLEZEK1Trb1YdNAw2TEqYBTcckvQ9lUiXTnNLaqrIpeHPtz6DWu0wRKrPhCxzpkIIpl3oM8S5/C9Tw2Ng/m4rFEi0W6OpuA/JqnOVAlLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CTuSEJtUONRqJV+obdsb4ncvj1FKSUiAO0dNj6Vmt8=;
 b=BWG0f4RD0d3Ks+Zk2DJ46YG3rmHodvldTzEp4s4Io/g6knaADxUaiQTUuLfbKiUGhIuhhbSOEVoWstNP61eH5K87bcmWCDZPe/VmZnD3B2u3KY0by4V4Bgvl4TfYDh1aV9uPenxicrjnN9tH/7ChccAuaTMJNSfgBZXWtPZlUU1CTWA18YOgYudePETYHYGZpWpTGT0V/D9s5gFPUIoJVrp8ePPVXFLeriKTuBWeZN4eAlfuaCo7ABOvvAPbmXW7mrX0pfd6iPnHxGgZvmdoUjp3CdOfAZNh4VLxJBQKsmJugDoGEqnBLMafSwKm5mi0m0bs+zxGSsWwkcGeOCYr7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DB9PR08MB7794.eurprd08.prod.outlook.com (2603:10a6:10:399::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Mon, 18 May
 2026 23:51:32 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0025.020; Mon, 18 May 2026
 23:51:32 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Yao Zi <me@ziyao.cc>, Dan Carpenter <dan.carpenter@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Anis Chali <chalianis1@gmail.com>, Sean Anderson <sean.anderson@linux.dev>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Richard Genoud <richard.genoud@bootlin.com>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Heiko Schocher <hs@nabladev.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v8 05/12] pinctrl: sort and format the contents of the makefile
Date: Tue, 19 May 2026 02:51:08 +0300
Message-ID: <20260518235116.2664557-6-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518235116.2664557-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260518235116.2664557-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::6) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DB9PR08MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d479074-7fd1-4c9c-7ffe-08deb5386384
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|52116014|22082099003|18002099003|56012099003|38350700014|921020|11063799003;
X-Microsoft-Antispam-Message-Info: UEEsD0GJrUSPJtGx/HLhP37Nqm09kfPaqMuzvYjoi1tUTAEuIWP6ie83zhpI3FQcJOXR9g7J/xEY3GsmOXdYCLj3L6qtfqenYAF59PeIIzw6zn04dqnMHzR1kOlpmAAhQG0WRDyVFYPPn4ArZ9m07C9pJBTBJPo7mUuySa/PRdWOaoHLRJjBJmIqKr65ggSksHtEEw34/N0VFAMvydD8f1boTkhpFdC4hL7L+Sbw2939/suXT4zcPf/HRbW0vvXECn+jW6Alp0uBMe/Y+UzUTF+qWE2C4Dxy9DrHe6ajp73G2RdqN2tcLgZttZX9kbBDo53bHxDtF/PtAIb/GCpcYOGzqZqoiw0VmXeuJjUEBP1pVyggwstyfHzm61Haw0AHH5ZO0GRhcjJFa0T9+1p0uwVH+38QHk6gK4A+LiU1iYtG43qVDztZmPRWd576ZfXCcdoSrAKqbWD2xrU4AAoSXGoj7iuBni0dIAM71VbleZWSV6YgggCT1Q0phIiil2FrkvClcLscpFRwREuXhaqYn1eezYtnvp1OBfCDzU55w86qtAaa/wBisseBYo0zvDbil6UlOs4nzLndq93QeOn0nV53OTXdHDLgabCY4YW1urIers3qVIjlotZSfNl4TXGxynlRVv1FP1WXDiss1CFVA0E5qKU+ZexMu3gxdfAdKsJDJXzvVNMLS9Rtde1SrsXUm0bt0G1fWVlNqriCxwCP+UL73LcIez+ZYMdfs1q7R0yfGtsvAY19jqgiUEd+xdp/EFwG8VukoqX2i5Ea+3aHxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(22082099003)(18002099003)(56012099003)(38350700014)(921020)(11063799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?StCNUAjdaYuJqXaTK3jxTTz1bKanHOFeHMN4XRRS2lQDaYiA0wC4wAYl+RWr?=
 =?us-ascii?Q?iLBtR0OsEuIXRkt3k2wfzmURrZCShSjyUT2HVR5LZ/JugYuQkS+pjWYPAKBc?=
 =?us-ascii?Q?XnGH6ncGVezaej7ooigsRCxSfxifvRYX/YPNC3rVMJkz/vZGyuIP4e7YFjjy?=
 =?us-ascii?Q?VwwdUUb7UjT/poZh9c/+b1ucw6oBf6DOS8LsHYhF02Zst8IWdpd2RPJX+rF9?=
 =?us-ascii?Q?NzbtA2dU+AtGCE2M72ZoP/t47jLaeadU6/urKy0RKZM2lGwzZpEoyR4bfh4H?=
 =?us-ascii?Q?ppQ1Vdlc8QeXRwlMBRMm3BYPvGdMw2N/ux0LhO6wLtEDd1JBH761CX3dXKny?=
 =?us-ascii?Q?eMHV0zJe12INAV0+9uI1ZVUH6FVB3QlGwzrEFpOvdJFVdYTCwXnTk5BEp8FQ?=
 =?us-ascii?Q?CNvarTrTGgLoY/pwIc5WrA8GtjNqKvB8FPbhloG8j/tQ42jrP0R40fTHsgyU?=
 =?us-ascii?Q?DGzDYZWahKOQruoW5MGzlmyGNhuR+F0ZIiiQcanm53AbPHakd4KAcIpY3SX4?=
 =?us-ascii?Q?N2xnhpxQj/qG3vn2Dpi0TmPSvmwwJsiV7QoL6sAcyX1g7QZ1CTAQ+D1ucVjG?=
 =?us-ascii?Q?kGGYSIJ9SR6IYTC4SslKFaU43qoNNYPt5oUPb3iWj5n12HcVdDnTLq0C5J2l?=
 =?us-ascii?Q?LE6o9sWfSnY1hWMmGuMl9JNczznqMdltrPd1AD22R5moKfVVrzmper1eLDay?=
 =?us-ascii?Q?J2oB6OId5+YQOqpWF45I5QlYYBdo7fNiCAKdl74ukRYr7/gbt4tsPwQy6aC5?=
 =?us-ascii?Q?BswR08uB2IfWV8kGs/zmr/r+jWAI8sxKMCPDB0hlXJUC1ABuks6AwK0m3fdA?=
 =?us-ascii?Q?CiOpeFTt4K/PvyoEl2r/Gfu4b93EX7aNqu1aV3rrP76M9NpLjtqpIOMPT419?=
 =?us-ascii?Q?Zh/4SNoPdLWARdwzYJMH2rG67ezkPG097yKgALW/nTkKyIgRhmRiqjWXiPL9?=
 =?us-ascii?Q?B7F430/8YvIXSOWa1yXEb+EDudQIMfEToqEmkux3XOqImAW831FZ+0IzliJx?=
 =?us-ascii?Q?4p2Qw68s0uwuZKT2FLneDhf7VVv+weRHpPx+gjQdr6QuJ1Bi1l4G0fGPou8G?=
 =?us-ascii?Q?SNTG3DYqzYq2KHwbBdIMgwcOwncGZ/MTcBlFPHyxaq/a1ZVrrJV86Na82x5F?=
 =?us-ascii?Q?GbORLOhzc9EkS9doF8BmdruYOXUaDK9bOQRAkvDKYZGgfvN7qq3xfRtbGDYq?=
 =?us-ascii?Q?fdm7fT0Ng1TfdjGltTLHqyiRR61XPzBMmDyLXM0BcNT3I7Mv9Pziq7Vax+W4?=
 =?us-ascii?Q?RJR0YrMUMFPxaPE8D/MZyEbur8fHxozh676ipLtgRNBtE2bsRQ03AQiq1/Q4?=
 =?us-ascii?Q?0JaMoUfqarfn485vM65ND40z+xCOolkLtE1J3WvXr9a9qRkEb5PYbKA3EgD7?=
 =?us-ascii?Q?fYUk0cHQzTrVnryfuqclqYtLl+Fb+yPRxuzfBMjaxz2i16o/qpQ6iPz5bx0A?=
 =?us-ascii?Q?jY4ihi2RJgP0BOUZC5NcX4XzX3aiz/4z3W77yXXeqzX+O2lDRDQ9iNWWWvTm?=
 =?us-ascii?Q?AxrfQXBvQd2eDxmT2xn6KdU0eem8jAQJP38n6Zq8wMU8YMhypZ2kT+tjilkB?=
 =?us-ascii?Q?7uBfMlFkgWmlJN3EWAdf5LwKNW1EUd49gJurHx+/uQ1cn7v/qmmQv6B4tppe?=
 =?us-ascii?Q?4TELnv/CfXh2IVGM4Zn3IdFzs3vMqNaZbibLs7j+pewLSPxlKif6eR3AK2/W?=
 =?us-ascii?Q?/BCfJHSijkn+ZNw1qhQmWDPl3OvVWQmDt493x+sXFI0ye/ZrKFy0XOI4wD7C?=
 =?us-ascii?Q?khJxZSkvzZBrH+s+4bzvE0KSGG7gXGk=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d479074-7fd1-4c9c-7ffe-08deb5386384
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 23:51:32.6651 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ydY/Ubpxtm0VNjHwCqbJXEo/oMYsCBZ7bbtkQZeo/4HuDcd7oZBOo8LJlp/yR9fuDh478ny8d0KM46ypWq+yhaUGGl3/HdjT6yS5pe0/bK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7794
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

