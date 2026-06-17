Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B868CCD98EE
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 05:30:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E828D8494B;
	Wed, 17 Jun 2026 07:30:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="rp1Vc/AM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D37B84942; Wed, 17 Jun 2026 07:30:12 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25A2284704
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 07:30:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RLyIRV31A9xLAtPhdsXjhKUsLBu/dudwGp5I81ReL0aX/qLx0FV2+FKBiiZUNyi1VoDPwzYGts37UImAZEGsybbYljv3RZFck2jAGRmmWq9jo3u/RkWTxKS7U7Qn0k6vpDtX31vpUb51zC9H4saqxM8gI2Lkdx0girNlmSFpBCmB8KCl+MV1hI1DbPnGWuCq3icWv2Xep1xgr+crsk26EM76ccG0hFCbTLQPdIINFF6dssfxy9CTOA3I21ZCjOcuzUieiKE9L3lPB4hw3cBC4J7VjdFwivsebhERmnqiVZvGoJz8TGwSBgtIQ7c4IKXzCKAtSqK1tX/AKB+qXWENBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CTuSEJtUONRqJV+obdsb4ncvj1FKSUiAO0dNj6Vmt8=;
 b=Dan8gNPfStTmVoiw8MRt7t8wAgaJePfthElMkYcMGa0Wck+nUBFB94KT5sv+1PJkhn5K0jFUe2gHsNWdxPVz3aFPHX+39xuvhMwwE+ZKjBxyFeRTulPol4ut1wPs9Dr5GIN7jBcnNChjoa+yTh86eh2LmHN9oILVRLKtVwQCApNowMku4w4Gh+lhNE2rFj7FXbvFRf7BK/2+K+TXINhsa7Y4XG/BMn6COWcmrXUsifkn97g+PU+aKEqFdU7YOJHzMKbEbMbOhj68rww1JWQQusK1j0lDlJzprkzX4egbRYEcfglq27wKUGThty57Q2kltB9q0mxj6XAfot8dVrZYVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CTuSEJtUONRqJV+obdsb4ncvj1FKSUiAO0dNj6Vmt8=;
 b=rp1Vc/AM0+kvlQLhQI/k//Xupsgo8y9zzS60EINGdogSgMOU5ur+15ICFcWSjGUNMxk4Nrg6s550uWRnFMmrPB/dJTkobhqCRH1hnVFouFXqs/K2Z4UZHlo/aMG7Sb0f1Aq/zGvf9iFLkHpCVuIqEIEsDgg9qA/GUuPerSsUYv1ni0aDfzWRTyZsDt5j6l/oWCyYu1xbwCOi9rsHVuk6RKZpzgRICcpZNa6VgE/eUNz2uSwHJlDnJAEzj/3LbeJOqGK2CgPVbuXzKzuZtYdT/Z9vFaNsIyRL96dhDFzCBzki6Cl69bn8QiPrCSqJ1kqDhZ4eSvPdbw+MzvPyJJHS0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DU0PR08MB9653.eurprd08.prod.outlook.com (2603:10a6:10:449::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 05:30:08 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0113.013; Wed, 17 Jun 2026
 05:30:08 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Crt Mori <cmo@melexis.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Benjamin Larsson <benjamin.larsson@genexis.eu>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v13 05/12] pinctrl: sort and format the contents of the
 makefile
Date: Wed, 17 Jun 2026 08:29:41 +0300
Message-ID: <20260617052948.2815870-6-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617052948.2815870-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260617052948.2815870-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0222.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::18) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DU0PR08MB9653:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e260775-b45f-423e-540b-08decc317e78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|7416014|23010399003|921020|38350700014|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: H5bxSYzwdnzvuLaqt7N7YUYA0XDC9t3fBAkFw+M0U7XyumQ9Mdr5ASG+RVN1rsd5eGsYq97jC/vPd2EaEK2MkYyVwd201MLLqzrvOkCOZgHs8Ivx31Y2f8//t2Gsnnw+J+636f3Vrf7b/S90rZ1Rc87GOYWQIfuJ2xHJ9EPj4KcYmdyELm2Ul7f52QKdP91hEzmXNPJHmEhV/3x0Kgt+eKiUWMMTBdPDCfLgRrFYyLPwJyRFjM4AaiiWvQ0ZjuN3oPFAhkidrmDYKbmM7uCW7J2vxI9IJM2b1/Az+y5fCqStsTPdm3hVrFt31zAoeofaZkWo3BDA3pPNZHH303L0/qhgbTlOPSOSHg94jZaLN1WXsCGd4YJ70BTVmgr1CL7j2GS/8GRg+COxlP3BF98BNwswXthoGP6ff9Ipt3fth5naYBvst3s7AINoL77ccIYSUGy+WcvkLp7HY4y4NT+YoRVtcVAc3hK3kmjS747vHh8Bk0DTdzDIGmgl2NIbUAI5jNr9lgXw8q3Jl0LilaxaQ7SbG20bEZbGTSpAss/WSVKX3iNAG7nVWUSDASxwzLIHepf5Jqt56GndgFF7SMAbE+JS1A0OKYBXWG5RJ9U5iGbnb24H+d5TvAS5+SzaaIHFy+U7wbIUHDfMkXVBn+GYn4uR1xEOuSE/QtqpiEs6q7D4fRXI5izIg93FVvnKvfw8HOzBQdyN2PoNAasUCW1lyc3RbhZpo6Z0016dku+k6SfRzx+vSnUISiYF5U/zKAdJvmITNduab4kZComSnKqveA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(7416014)(23010399003)(921020)(38350700014)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c2JTnWAukyp0quLa56PUr1ifLIYzsbQI8CD5WaB4SOMygQlEVfmFRsdc5IOU?=
 =?us-ascii?Q?DF7ZZ1RX+JbtV4hA8pdrl0aWrAesESp+uInvpqdJJuHjnppBO7qpXMGnf7Yz?=
 =?us-ascii?Q?dVqX//3qYML3ZX/DSNNwO/w1aFBOmJpUHuSEYYsCti90M2zr3xueVnt32fEz?=
 =?us-ascii?Q?QSPBvWdQOrbCB0QZP9hBCc3ZgSpz7LecSVSuvOPGjDnVEAb5U7Kg85Tua8iS?=
 =?us-ascii?Q?Co2LhOjXauP3sALd/JxRfXKZ+v8SsF8xDfMlIGBVcWWKnANXtXwviVHe116O?=
 =?us-ascii?Q?WZjPuQ2o2EjJHE7ig7ZhYT0wNSdZak2zCldxcUWL9Cl6P2iPIUp22zs60y5q?=
 =?us-ascii?Q?B+EvHOAegJroXf1C0PavHAr2bz4sByJDibPrxMy9ri4046Ll58j32omotsEi?=
 =?us-ascii?Q?EAX3aPVHKh2vZR/QnVfQohIAbmOsZsd/B+Gemla1S+/VDSML2CSMBH5cMwGW?=
 =?us-ascii?Q?T1MV78lcmHx17/6qGy+CcZ9YKfn3Sax3b+EzfYv7b7bFKsN3gFgGCBFXuF5Y?=
 =?us-ascii?Q?CsQNS+rL429U2qpj0Iza9dHvqHYe3KLXZLCR/nEgl+6dEAszRNz/rbU2Catb?=
 =?us-ascii?Q?Ms8JUhHVmQA/q4WjgivZVvDyVGg6sFZQe3gGuyrou8cG1RtTCV0aY6fwh4zy?=
 =?us-ascii?Q?xF4qSMlK8x2QOCN0XCyWS0XE8dNkbbziRx8nlVEluMpxIjsISJf/c42JFrVy?=
 =?us-ascii?Q?nwGvWhn2bPKhe7Ex+KKrjKFNT9So5+ltccPvmpKz/o+JgSSE7rPCn40anZFB?=
 =?us-ascii?Q?4/rjNBS71Ix+nnQcwMrhVCPx//XMtBxSuitGFWKVP2sZtW8PBVnMF3s/2GSF?=
 =?us-ascii?Q?QrulhGSxfkd8M0xV8lCIgdanBSG7/WjbbvbA0uxDSSPlYMOTXovB/mue6OF2?=
 =?us-ascii?Q?W1Sfspx0K7r0rlwwLCThCVRPMx651nT99kb7mjdUCUUp6/a7evxhod1cdE1W?=
 =?us-ascii?Q?tHTG0qvM6KiN9DQgktLeEQuKa6xRbl8T5vxhO3VWBVyGWrXaL4r4Q9uPNNk5?=
 =?us-ascii?Q?2GrkhIob0vGX1FNvN9iPAORQwLfCduk9SjPgj7usebEkxrKoKU8JjcHu1Gpw?=
 =?us-ascii?Q?JG2eWkZnFc+/zxrRpxDmPgN9iF7XgGT/FRkT/SMCPQ4TbHaCV7UMpchBDNf3?=
 =?us-ascii?Q?mR3VMuP/gQml/w5HBV4+Bzozwzct3G/diFS5u+FKL0hrgPYzgfmrei/p3s0s?=
 =?us-ascii?Q?+ZdLctZ0fkbs7IhCiAm7mwi1FDVOQUb62w489deSq8uBwk3l0kBftj/0G906?=
 =?us-ascii?Q?3QQUP2HqSeyhKXxOYuTZjY4sGS7AvFaozChpWqRQREr1Kwn/+2GUUFN5rpKs?=
 =?us-ascii?Q?YpX2QAhKOjpI6X6w8NrHEH6ywfY4uWOWGd1liTZ8dN3M9RXgOQgEta3DMMQW?=
 =?us-ascii?Q?pnLKqEb6SdFl3cjBSGnM9XllfLGco7YH2GzdU6uT7rcihTBclsj3SVIl/PKR?=
 =?us-ascii?Q?lPgQwzyX6Ml7R0RMibgn0VsgjujdPkwhGsi3dA/5qE3FAq3TW2cvHSPAv44E?=
 =?us-ascii?Q?cMoVh+EKBvSs/AyDaYikgqMYP0sDsicgT1PavoXqtbD/oCKwfsQah8ACk4Hb?=
 =?us-ascii?Q?mla20wzmt49d5/6jTf4sVO6+bbuJvM3bZS9rnVd30sO73RAxZX71zuyBIc3B?=
 =?us-ascii?Q?/L4RMZC3SAZJ99n2hPEzYo5mMSUuHrKyp2pE6APbjENDlBfNyzvxspaigQp8?=
 =?us-ascii?Q?I86bh7GVVw9VFWlkiP5N7PAGgupW/RtvIIZxcRZ2b7D9tSfrj6voQ4vTIduV?=
 =?us-ascii?Q?xWciD4L0KfuhntOf+O4Lrjaaafq0MmM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e260775-b45f-423e-540b-08decc317e78
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 05:30:08.2367 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 57gcceKuybL1EleQ/1eMrB/wqDf69AFCs9XVwZj7cEwCRJM9hqx3zV23fbfZ33Q9ihyoLhIvb3+GprW35aYimMP0+DXWRtjn7HeGo28a30c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9653
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

