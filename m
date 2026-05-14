Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C1FACD37AC
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 02:56:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFC09846BD;
	Thu, 14 May 2026 04:56:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="wF8Z/zp4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB575846D1; Thu, 14 May 2026 04:56:08 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1B19846B1
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 04:56:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HsHGHTu6jqOOI/y2Z1fMCFyErXxdigEGJohWckET1OFLP/fCuHSiJEw/12qkTjrPd5Xs1C9iBNZnmqYjJIykfmNEOy4Ab+9JSWpTwiIDXE0qbjiByT/JDDvDoLmz/6K+q0sMpGFbiGnISVhLCuF4r5e0sdhQdEP0xz+5dGyZRNEG6oB3r0IPYfDHCzIOvZCE6t/j0+nS8U22e33RKp5FNoQgwPayR1y5hSkzZgMNDWjCv/jTcw8mcPAccMOAnHgnab47jroPFmom7oug1aFJ98lGhNyj9W+uGaDeL++QWBK7YsDJeDQcOAVrKtdvf2kVQwLKjiYaYuOl+JDlAGA/bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CTuSEJtUONRqJV+obdsb4ncvj1FKSUiAO0dNj6Vmt8=;
 b=XjDUD/hWmyuBOLn4X0Qh6HH+qHohwaRrHN6qCfeSLVdf9iaEOs7q8HDkc6yuMdMjwS9MO2Wkui3BCwiz5VbGJ9IPAfoKvDEv+UnF8avdp1kPwdUnneSQ3EZSC5nHPWJmzxe8fUQEFj49XEn/jPj6d/KK1LCo+WrUbftnnnAbnKvLJqEm/d4+Q1qRRrsZVezlSimaDiKd87ebzS1SKHCqb4d4DukDfrnXZHMZnH0KCjVO8tzqSrNvR0lH/c2CQgMXnC6eyQEn3PcBixK5xUdM3bOqOwdt7odipNK9pwZBsQPvmrre/ZJ7aW4wV6wi40IoUM84WJbjNWQL3m4nLlG+dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CTuSEJtUONRqJV+obdsb4ncvj1FKSUiAO0dNj6Vmt8=;
 b=wF8Z/zp4ks32viKFyqg8TczeOFdd224PRFtYHWb2dDc/RiP9J2yyOiAIL0Yx1JJABQERIMYK1Gc6JM2/xdfRsfAHe5uuBl1N8+1Tih5pCgltpmmkaaC3V/58ZX7ecNW1A0VJCv7pJvuK1tvDg7STS+7A2fLkI6IpApQ1J6EHIi235oRlU5WnnzCBv3+gFXHVoUyNOLbHcRZgT553F3BsbDbkuKmGe8R+UHSlNjbFw/SNGfbN0WjjenMe9q1D6dXWATLhJNdY4Jc6DDY4Nxcc5rc7VE6ziqpJ1fgwIbI1cjUw2zQda2qzfci8LhNu5f7ZMRXuWZvck20vlXWLP9sbIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PR3PR08MB5786.eurprd08.prod.outlook.com (2603:10a6:102:85::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Thu, 14 May
 2026 02:56:04 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 02:56:04 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <sean.anderson@linux.dev>,
 Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Anis Chali <chalianis1@gmail.com>, Yao Zi <me@ziyao.cc>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v6 05/12] pinctrl: sort and format the contents of the makefile
Date: Thu, 14 May 2026 05:55:35 +0300
Message-ID: <20260514025542.398469-6-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260514025542.398469-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260514025542.398469-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2PEPF00000B7B.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::411) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|PR3PR08MB5786:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fae1a90-0237-4780-e3d7-08deb164568b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|52116014|921020|38350700014|18002099003|56012099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info: XDq2cc30rb6qFKeb8l2EJsfyq2EfymuWw4LLnNmjDmIjbxkcS/7CP9KhntsjOXIHUK9yEsne0uAMb+sJeETe5sMmKT9MttgG2uZHoSdL7Fbrx+NlHKGM89r7CaKfQbXMdeU31NZYjpExqwUMAHXN6tTDL0bfj8KMr6Ag0EVwXfX+65l56JCRY74oJ8FLpKDajOOO87JgNQ6jztHXMQ/UAStZb2EVfBNec3ZhQDlMfDeBBuQgv5VyZ14qaecK7sle2UBlxnVNqMy1CcxkwVkNNtZUqY6/CUOxZodbYCNxx9mUoAbHZa8i5ailOL0no9bzTMg+hjqFH6mJGhSrSSlfPC/zcV1nmX7edylp9u4jcLplVRIPXSA72ZI+wmcmOhUtgkbet8ch9sJWqaYNwAVdRg2/0stUe5vF9/R8tJD6z7Mobt1MvcAGieefp23FnSiYdlGyKAbrQsZq6q/dEAkqsndyPOLxoDH4TzwN1rF0/70bfol06w+XrICuPn1yvvud4SEqfhunSDShVMIZzczzfvOyY4A5V9jb2iL1baNbwal3yo2+H/lsZfEHpF6vlBa2wHTyfQY1g1I5NUlqp2tcBJggd8dFiHq1Nb2ZUni/jApXgkimnfLaC9gx8FJcafnMnfXQrfG7Mx3fAvZTuT5RfxXN4osJOpY+miGtbbWuiB7ouG9QFS4rVm8Wdwb+Q8BQk/LEHRw/nfazjwMYz7ev5WSXA25uGkN4BJoCyEx8nbYxoMsO/GyWKwwq1gLZSBnfkk0ZVISFQkYQB4hCg83ahA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(52116014)(921020)(38350700014)(18002099003)(56012099003)(22082099003)(11063799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S742tADCLnyND9wRSiE++OvdDXvMjeXSVktSZJqlnEix7quRANM047Rx3snl?=
 =?us-ascii?Q?sa+BvAAMbvhYijY5lR433xKYLXsdJaluugycFyW0Hr3RnUJU3vkbLxGFupqX?=
 =?us-ascii?Q?2fwWOeTtXvdYU6KAbJtQV/PvuNHpOIVQ4tnGkQSVwZQxwAuL/3Sv/QpT6faz?=
 =?us-ascii?Q?BiWkW3GIgKaq/e2XbClkCFH7wM+oQcQdbpiRYVOMF/VLIheN6O/cGVuYlKTM?=
 =?us-ascii?Q?XTG1sF1a3mDc0ev2ttxokFYsUop3igdAIgA2BPuhySzvQaT4QKVa6AOyyJkj?=
 =?us-ascii?Q?tVUI2o14guhMBQauiaFoRS3VUZYaLVo4d50R6uUHVR1Qv3qLeIuqiMrgjAkv?=
 =?us-ascii?Q?Nhet4y+s3xflb9l+aLvvZw0aPotoesxW0+VvK99FsfHGq4ALNUXGKgrtu430?=
 =?us-ascii?Q?h4D0a01/h7Nq6e7+8NRini7nBEVWTCpDvxKpcIB/JI3ObXul8LuZmtWyQQWV?=
 =?us-ascii?Q?PWaZPEnWuzM/m6dSZCcdWCrsa8kJlJ2zr3iuDwUfKMKdvdUAQlcbZRHF+zqO?=
 =?us-ascii?Q?rQWjtcm5tIwlnz+xnwWq/36OSCZlvNs3z3x8BmItGMu/OmGFBGexja99g3gm?=
 =?us-ascii?Q?dJeDTBjHwvnQmCgb73dWcfGPFzQbYT+rQHKwRi4BcqRkblyWbX1e1/We/hF+?=
 =?us-ascii?Q?6y30kpkOKPM2QNxMYaZdNm7yhWHRSX4mefQRzfDc/MS1+yruSE/91b8xQsnB?=
 =?us-ascii?Q?XyjEsxllPrI0gW29ufCS90NtsDPEI9eG8QfC9u6ufWw5MzLc30oRCX4L0G+V?=
 =?us-ascii?Q?JBhRUTa4ZmqcocW9XmIiUD3Kzmsd+u8ioqrTFEro0Q2vbxdlY3tz1cAuT8LX?=
 =?us-ascii?Q?LZLzXNx8bb36FxQ2JwPcJFQAPFDENc9RnAUVwm1lP9hIajz+HbcLu/fMmRI6?=
 =?us-ascii?Q?o8MeivwBygUv7szgXvV5tfx/ZVnG+ziaQM51pKutSZ7jhfrcZgCdsnjDwws+?=
 =?us-ascii?Q?lXrlodJ2J6OCwJL1dBjLk8iX+IftYSYmr5HYpuYFBTeeGXBYw7hZY6ZJB9Pk?=
 =?us-ascii?Q?g7nfww9V8sUv6EfFkAwyr8Zd6DPjsWj/qhscCh72jGYIJyqUbO2ExNQmDK/W?=
 =?us-ascii?Q?CncyUhLxlr4G9Xu04/w7otO2nmf5nDupAj9U7jPzu0ms2NTayULFpOfGAfnw?=
 =?us-ascii?Q?S1eDU6tx6lOefpQVwIDGo1UeQq3AoRbs9K8Av0PaSAdTAGrRh4oIfYV6jDf9?=
 =?us-ascii?Q?5SUDbNaNGMTDtWI380VYf/gMJf4DO4CI0mIAzMDDYG/jbzSGBf9MEIDTjXAX?=
 =?us-ascii?Q?yUxuEidsYfSZJnhwypHffIdByno8GI37KHX7Wa+muGiK1yVIDwiQdFmys/98?=
 =?us-ascii?Q?zNe2qkxRi3Jdo9hZ2Aljy20AqYgfjNYZj4tMKEFc0yX7iQzvCznBQaxkIfar?=
 =?us-ascii?Q?5pfi5IUgLK5LZUc94RdO7WilQu2HCF2P0563WdcopdhX6xP2VPdGrrFct2Ax?=
 =?us-ascii?Q?ZSXmZtq1jq1o0FNW9PQ40nmL3Pc4H45MArFbvBWKBqn7yxX1yzWYS8r2vh2Y?=
 =?us-ascii?Q?IrLGU0DRvp/UcBl1kWrmk/lfMby7Pws+GJFkjTJEdzlzl6sANLitdKHwiUhM?=
 =?us-ascii?Q?F9vebm0nB5fNTHdLrvf0yYKsqPDD4ivMFaYZW613Xhx1OS1vWF2+JgHBvyB5?=
 =?us-ascii?Q?2+K1w+8WLvuZ6K7S1PwbOhlaYC5S5rqU+ZoKnz1UexXXBBC6zib5tsP+Up4U?=
 =?us-ascii?Q?HZvm8zFp71EO2Ut9BH5BGOsZDddV1chpx7Itrj2k3d3111sUbrLUEpkHeiJt?=
 =?us-ascii?Q?2CJHq19yz7+2tgAn8YwVgchnlrkAhrw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fae1a90-0237-4780-e3d7-08deb164568b
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 02:56:04.1609 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jS7/0QH2TnQVrAlFJDt97sr/RuXN0x3CB/uAsLfSAYKIlyCiIHVSPc5AxNa5qOH/6c5qk87SxQndJ2EbNqt/ndZ2IA7CSuP7E0ghsKOB+e4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5786
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

