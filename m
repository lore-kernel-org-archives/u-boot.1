Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F3D9CD4851
	for <u-boot@archiver.kernel.org>; Sat, 16 May 2026 01:01:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBEBA848B6;
	Sat, 16 May 2026 03:01:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="WluP+PGO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1B198488F; Sat, 16 May 2026 03:01:01 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E032E84713
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 03:00:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nt3rVhZP50dtkM8tmqbQJDbMK7ruftnNIod90dzRPYxV9eC/LS8Lpucsf6uNdUxoPUmfCJgOkDTjElOvKoG2J8JV5AzJde6u73izdvHVnappgyZHJ7AL1aCrILfyTB7Iulj4YsJuo3UclB4zv4xOSeTCUVfWZLPH4SREhRTJRm0HrU/wSstg1R9KD5vBoVR+cvG3uNkcFgwISSBHoNEHjOOS8G0yMr9/en5HrZj8f2JWjqoLD3YpwqCHWgzI6s2ghbyR36FQ2+BdT1wr6q+UjNl/7LX00HYAAUmXNBBYmRGTRU6/utbtfThK8tdLpLRGqm27Uo0MzRpArRrVff5ksg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CTuSEJtUONRqJV+obdsb4ncvj1FKSUiAO0dNj6Vmt8=;
 b=VrINKK3uKXWw6K9E4faz5zKC/CWL/RuH14hyeFEGlC8UqD8mb6oOVJItAXu0Ou5JHGsW8ETfA8B6xaVaqCpxz5gw1GjMEuJ1ysjSRGQhNvNzM5or/TYRDEmo0ppAOUNtwA/AnKks4ZEU0HLLQiBP6aR9Z5DRD7wKBSXx/B0upARwUS4xeIYP+5B0ZzgPg/3yX547ApZW1WTngHWt+RAoUtawu4bpE6j8DcrAaqkiDE8ulqiBHcSa/7Mz1BRQ9D+DLKXk0a61OCFrzA/HDb4RK3AeLmPqtKiys4mp24wT0oFXEtQ8Jt/B+u84WLrkKGigcAFu5WFFJplqWiQKipBhJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CTuSEJtUONRqJV+obdsb4ncvj1FKSUiAO0dNj6Vmt8=;
 b=WluP+PGOnQYvbT7rxqq//Hf6oErYXtknU1T5qVn+0yxMm3pBMGnkcTwVIIIzonxcaQIpYZHxxvUpteydlv8dohqnEe8BfnK6Wl9Dre/MC/gx6CSzYA4tc0vcUIbbCjkoD5h7m42inJa5RB/KZoVo7fdS4z8MSB/cHXHU3Ey4rJvBqoKOVCnQ1wgX9rMnUi5T0gzN1Gxal1iEYsgjggJlNLZXdLLaSAtLZSngF7RO0NxZbiNzE0a8A+Uti1Gb5duYOzuNY3WFex8tti7uKRFxkeRwxdMSkbW090rwzcuQAICgyWvVakAAvYbKqUxrQOhBqsySx6PCxyx9QyjOExRMwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by AS8PR08MB7917.eurprd08.prod.outlook.com (2603:10a6:20b:538::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Sat, 16 May
 2026 01:00:58 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0025.016; Sat, 16 May 2026
 01:00:58 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Anis Chali <chalianis1@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Heiko Schocher <hs@nabladev.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v7 05/12] pinctrl: sort and format the contents of the makefile
Date: Sat, 16 May 2026 04:00:28 +0300
Message-ID: <20260516010036.1034352-6-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260516010036.1034352-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260516010036.1034352-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF0001DBD3.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6a5) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|AS8PR08MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c17c0e3-2476-44b3-e248-08deb2e69708
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|7416014|376014|366016|56012099003|921020|11063799003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: YG+gqR2nx3sO5oIF8q7yVt+6SHTjtKCoU1wGwfqGN372iQ9/gdciuaJNDJyzh3euJSN/b1J2nhs5pSScz9ifaiZxCFYUePTrhNpoRHkp0Dqo57OZ8cN8oimJZHe7tmuFt5Jrj6e9WLFrozwYHl9mIyBL2SSnnK7SeF9mmNZWstQ5lCLVtouw2KJ+lwBK9qGi7AWP1aVXTch0GSEEo7r1F70UdQUIT/PUg93F7FcD5jafpbOA+tTUZvBwHFThcMdZBO23OY3ZprLo5EfOx2W1B8fWo+3E3x/0uLSUeLMVpaeWIgDvPB4YKJLtaXzFO29zwO1DfVrRzSGN0Gi3fQXKCyT573TjeHq2ImfbytHHEr8Xh8OmFooCeYVvfPK4J1sc0FiSc6eu2aRatH3lLuXWpxrRdOLx5RWs0oqksJL6CVmyPoMSSkrCMGuTRpXGFvFO2QNVGaHbCeS6iElgBQbiTuNQ0kzJdXE7sAefPvEJZ0QtV3ZEGZmTkza19+P4PUaAr3kC3DajNl8NlKAxpggLKu55BwL7ZyutOfmDChNVi689DNp4Mm4qHS7sz/5Hwn0vvIPN+se97iMMNovXsoZHeVbNEWSCkSQKbR5PYk25AYHO3Yob+CZpWDPNR3LTvcI6lHs13pxEc24cu/KGRH8FPCAbwlAkIS0fVFS/EvOwQeOA1c3IrWEA5sVbp1PjEPploZkzvoo0tpwg827Rn9x/MWfZDDHq3mL9tymw+Lqom7yDP+4mKK1RZ5RjcbCP/tvM0/K8DvdQ7uh/bFYRC/FDpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(56012099003)(921020)(11063799003)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K5FdsttgHxpR4DOqpjjCHDgVDTR1NPj70OG22JBtOdfgVW4KIpoE206cRzrk?=
 =?us-ascii?Q?cf1Ze51m8jdfilHJebf25UaT4nWSypf7DShgTnmN+H8RY480BzBl8dpzVmte?=
 =?us-ascii?Q?5pEboZz1E8g+QzG99P/l0uE8HpIzCBzy63oFLIj0nvfcSHJzMF1/RGHHxyFP?=
 =?us-ascii?Q?G8GIeqbW60aeyVsAJNSVKq3SJq6aLL0lbKQ5DDyh9iZQtMc/642wHuiFMsRX?=
 =?us-ascii?Q?WjpQLG9okAubcjUMIsZ8c8deiHm/6COmRNIO+ertpcoQi4XRQZkswHVNmaGw?=
 =?us-ascii?Q?D7A0oGFyXfVWfdJuS4FcK8LFnRWR5lRieu1Iec/XtjA1021vWAa7ZFcGWrBK?=
 =?us-ascii?Q?CCvAV7XcpBsFLci/CXgAMdgj/dl4IWRTl3LRQEXVjtjeJS3fDWsosR5CCx2D?=
 =?us-ascii?Q?jjtfUAdhhGu3SGGczRttC57HKFY1eFdPvNnCntdL0apKYIbI1L+PMuckPOpi?=
 =?us-ascii?Q?WC7DJQdrASqY6HGcU72ENwKMAEig3VT6UB+OEL04VAOH1kNGxxk0oKIxuadS?=
 =?us-ascii?Q?Uf/z1Cq/CbLhiWb1Mes+MwiWe1ZEc/SPTBgEbaVSH5SRWmohnwOnLw7n0dgZ?=
 =?us-ascii?Q?UkGwlJtipmeOU2qYM+oXIsj/ybp8PkFwqPInRsYeEkZ+dBdsEU8hOtr64lXy?=
 =?us-ascii?Q?AVWo8iVPagrCkxWA33ZRu0bEl5yfl25fq7ggWUDmIX/RuPferH7i7YrLXo0V?=
 =?us-ascii?Q?hkNr2mtH35dy2/LfG6FbMHUcPMZ2a7Sgrw/9TIK/uF+Gji5XvhM364/oLvn7?=
 =?us-ascii?Q?nteP4rZ0ECniJBG66dptR3Jf47fnjenroIN4jJ53Cl5O8THvobWBHkc8Hvu5?=
 =?us-ascii?Q?Pgui/jjV/mcXOF35tDWrdRYCjSWwvq11cJh59EgcIA3LDQ8fGoYkmNFx4yUS?=
 =?us-ascii?Q?xgvDvpGjLyND7r6cGormekdVCssCj04D7ggLsz9DXECqcgAGdc6HdUD/vNnD?=
 =?us-ascii?Q?VCz1iq4DAk03t1N0W7YwsT75u/ss1cST/mZsLOW3ai3CIf1KToNl8SLtaIyX?=
 =?us-ascii?Q?tyjICKQTUjtowx+d9s4Fr5u8Lz4dvgCoqyvLAIzfgQgBitC+7Togiqv4C1Fb?=
 =?us-ascii?Q?wYhDA8gK/QHh7Q1g14/8gQmK1JRHhImbMj7BdDc/+smJnbU08YxGSk3uCF4g?=
 =?us-ascii?Q?4dTEV0HeHXsmmZ/G1Xa3nuul5k/RqDNTwiM8dA+0qCYgmtem08JCy97oqn4r?=
 =?us-ascii?Q?4rOozYRACLaAqlKPdMySRY0IqXq3c7aiGgvKRm8AVvwiNzb0lEYvL7+WGNiI?=
 =?us-ascii?Q?E763LblB/LDGDJNZi6WczhFc7XAOzahqqnvJVgjmAPiSFyVagDqk5ebhAVOC?=
 =?us-ascii?Q?bVCeMGrDUw6eXepOOcZqM48Awm3AIqKXXwNk9dQyN8sKdH6STfvKTMleMK7P?=
 =?us-ascii?Q?+8J1jI9Rugj4nNHUTgXLvtc3MFI7dSA1fziLUelNdy58fYtwwXzEaYak04Bo?=
 =?us-ascii?Q?DLXDHhlMtRGGnzX1XuM0+0R3S/pwGnQsGhIrwMTk5ItjkD99wfFCqYLfv6ut?=
 =?us-ascii?Q?yd30OtsrAiLRRReDZq4GtVAaB4kUbOfFoqlkV+8Xc3ws3d7g7QeHFu7Gh+Yv?=
 =?us-ascii?Q?7WKO2bjXjKyLS2JyM9zVejanPrxfXdA95JKDm7NzmIsuuxgFoSe1D4KMuPgy?=
 =?us-ascii?Q?iMaNd8ksvxYdhcxkIz8Cz7N9wDcxfK9EPN8zmpvItvkGl6OuBB19P5O6obPR?=
 =?us-ascii?Q?4iE6cDARENYIPD868tClcq4tAWYrC06VFZPZpfl3RNJ9EXVzN9bqQhPKW8Qt?=
 =?us-ascii?Q?AcXCXBSAXxelhcLzC7gSjyo3y734M0M=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c17c0e3-2476-44b3-e248-08deb2e69708
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2026 01:00:58.0824 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xHOKkqJvYd2Blw9XqJcGIqstqzgMKX+HK/e8hW8uU98IlMKo9Rq9tBX1B1r8kjZ6csN7kwNZkghTKQsS7p2zxDdYUPI9frcAxqU79ACoBNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7917
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

