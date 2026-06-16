Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20648CD8CA8
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 05:32:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72621848D1;
	Tue, 16 Jun 2026 07:31:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="wLTFTQLo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02035848D1; Tue, 16 Jun 2026 07:31:32 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1233A846CF
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 07:31:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lPEtynnmNdZyelr/KYaanFBBCOgE2d9mFGArPt3TA0bt9iYBXlwKFFuVVF2qej8rucw5urljXHzPTa+HtHJfRu7WpPwgiHUzvJc8XhoVpFyY0PdfC08DsZ7UpB4PIqIeGihINe4otqMLnXem5fAq9G3AtJFhsXPzUW+IQvvwgqaC1l7bChxUys8w0E8mblF70h6xxdBidXXS/TfrBRTtQatyAKR+i0+0STkb9yE67QhqZflHEyWxPp01fbL3sj6f1xl6vp3e1W8QUucAytmuth1G6Czl1rwWBQKXoc8FyJPBl7R15vFdqYuho1jdjrljDzZvWh2CXPBvltXUHoWH2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CTuSEJtUONRqJV+obdsb4ncvj1FKSUiAO0dNj6Vmt8=;
 b=sNU8loUW4jX2/p9iBOahKanPwQSWCjTMOwwlaVanqB+eRWzPHL3gCucBPqVLGPI3zAYbKl1HQNsBZGelH9fCkjSM56TSkl8zAdu1pdXiZWgjTmcaWdRVbCcC6jsBUCaDT770GnKi56vJzRcNbdrnha6NmIYl+5LD2fyPv2sC3ZVgUY0CprvB1LzXaaOHekRIA2+PtGpo0wjs2xne5Rvilh7QlSBZ1hrz0kakVYZ+euPlq1cVTOGicWp1G9610ZNtzk86m+/UCm45+AEsFfzPvMORiWSCvoUbL4YSj9FjvWhR640IHrEbZ0/f3ui/09K1j8YY+aR0LUEXOzN2p6r3KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CTuSEJtUONRqJV+obdsb4ncvj1FKSUiAO0dNj6Vmt8=;
 b=wLTFTQLojz7/5ebXJEhnBsNgzTMPuSbU8NU5xi+DwPWdluaDIK0B1xDSHD5wlA5SvZ8xXb8dhRe+Fq7tQ/zoRZN0/KPFaiMCyQ7YMIxNcENliIu9LJc/WjJxjcUKDJmXr8TcA5xzgffKNBXha+SXpiQjwpWt6jW9vq6r6yZb2BCnXOX2KOtaPr7DtzDSk3/iaRclyRDEzRgqe/6026ye5DzfTlYLpiYGgPTTM3xBW6O9zL+n6Hy6zftw0ZPdXLVPu74/vTyOwOBlCHg3e/Owqx7/XGQ17I2NEzVsm+bu0WNLFXHOTNrZzwW1h1NVsaobD92VcZ6us4rLzk655mMuCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DU2PR08MB10160.eurprd08.prod.outlook.com (2603:10a6:10:496::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Tue, 16 Jun
 2026 05:31:26 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0113.013; Tue, 16 Jun 2026
 05:31:26 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Yao Zi <me@ziyao.cc>,
 Sean Anderson <sean.anderson@linux.dev>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Crt Mori <cmo@melexis.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Benjamin Larsson <benjamin.larsson@genexis.eu>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v12 05/12] pinctrl: sort and format the contents of the
 makefile
Date: Tue, 16 Jun 2026 08:30:59 +0300
Message-ID: <20260616053106.2623475-6-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616053106.2623475-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260616053106.2623475-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0014.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::23) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DU2PR08MB10160:EE_
X-MS-Office365-Filtering-Correlation-Id: 953b2407-3558-48d3-da9b-08decb6882c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|7416014|52116014|22082099003|18002099003|38350700014|921020|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: EU5sLBIaQEBpKxgJtkCvMPbp2B+d2tfkauAy/6HhTKEMoEb+MmGiL48OcRgY23xmjQQHQRwGsnLwQhIEeOTdRTY7v1eikjYp518J9C2D/QNtg1mJrlhaCJeznD7QkOQQoUvTTUU2yk8H4rYzvGzX/5T5372W0kt7P6Exyw7P08LpTSxtpC8HRniO/iVdaoj3w6+a1qd8Rv0Gh2DA9vSKJq/F8bflQ7XqUNmsAfv1tBYp4jofNCdEqidvnEl7E/lPCC2c1XcyYpWOZMykl1YPBhEsJHCGA3aauWqRjgy9EzeChvmil1l69iPAERjog/WRyYLW6gVbb2J+NMBr3V6bQHpV0FG/NKFGAbmYZlCk3nCMt++hDDZU8KKc2cqJMpEAi+yi39aPbPvna6kN9XaeDTwY7vOcNRxlL+OM1WVYWY5iiwf2cMwvCJ7KvPmfXNp+SUsZvcbNq1KCR4GUu2JDjMH7bxNfHcn252wOtJTe+4OU03zuybuI1o414e7aTn6NQYl1f6aPOElRUDLtwILWGyArWGXBGjil/yoPzTmouoh1cZy0sXt5toH3gQjKv3rjN6fSqeJ8mrQBevCN3jcx0BBTimd4tLUHo/AWrN/TZZ38n6ddSC2ex8AFLI/BfMhAhnWnmWnDuvHdn0hiFt/7Mv0P267739TQxUPzH2wfCfpBMDa+Ecrkn8+/dxS5xkvIWtWlmr48d7Eps2ZLDkqDaN9bnPdVJetJsU1YgR5Oa1EUOCcCQ21ge/TzytfK1iKhFbCxFGjrBoyzPzcCXDR6bg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(7416014)(52116014)(22082099003)(18002099003)(38350700014)(921020)(56012099006)(11063799006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3LqVSnWmkdBFhOskyBk0x70gm4o7vFIL9xNVttRYLXZN03pQx9WFjJ6t+OJW?=
 =?us-ascii?Q?XmbAETp6kecNU9HsD/3HktkjMfecja4TuskDXH2aaL2BeGoEPu1mggvLYteu?=
 =?us-ascii?Q?+8E8TSFyvuzbtj31FE9DZi5V/2u1YkQPw1rfMMWxxiKAJPTeU5Q9HJzjJlZ4?=
 =?us-ascii?Q?4wk3dw9BCpayOTjIatXlCJuXNKK2lsbHvuBl3UCfsxv7/xXv+M9l3tyvnGUJ?=
 =?us-ascii?Q?qX92sQ3R4mKqVGv6dQv+FnlJAmbGrdzXkBbXaEQAPtESrFB4LA2vRxuFQ4qz?=
 =?us-ascii?Q?LvwlR5Ki23FZzMBQeF3j6GDrX7Dx5gYAgsqq/G3Q3y7bGRTV45QIhpe3bNd1?=
 =?us-ascii?Q?WSk+eyClGRusLGLbvt3ah3jvf6MH+iEqurygAevD9e/V88D2avqLkTvJftGc?=
 =?us-ascii?Q?Sy/B9MFSHhSGAEhzjtSbloI202qekjnWcAaRFYTBQYmoY878gmgaTA0QtInR?=
 =?us-ascii?Q?DxtHnIdI+UfMIg7e5AXPY0JaCNQEtKVmWtgbO4oFvgz9Q8pSoTk15TqIddsz?=
 =?us-ascii?Q?Udpyb4RRlGcVOen/SKVM1d9cUwkI5EVRQF3CP+G0F1zLJMDOtPeryHlrxuHb?=
 =?us-ascii?Q?6EUGuWGOTfSQ/8S5MiAtyhFbvCLp6I/XSUsSkeWDkm+PwFMHgB+stHF6MVyA?=
 =?us-ascii?Q?O3++IuY1N1/GiDbV5k8I1mf+XoegIJ7WtbVt3DAuGC11u4VKaIdXlcMCKbQJ?=
 =?us-ascii?Q?CVlDpyG8BdO7N+wRyGB06Fp+2MCV6U7LqzvNLlMF4xmWz9O8UNdDBAVAZzAk?=
 =?us-ascii?Q?9koTXDUVQwWRtDFRla/FvojXlfToyU1pLzUmapVTTLcPQDn3AVOSNnec/3IU?=
 =?us-ascii?Q?In69kGXrfVmbMGd4bUKD3Tdp8O3vqw/3f27CtQ3NJth4XDEAYwI2ILJ4T74y?=
 =?us-ascii?Q?SLb5rndqqhs/R2EnRECWY3Lllsi9sKpTW7+Yu+iMMQhANNF2y1aV89us36HT?=
 =?us-ascii?Q?BOTi6Iu+lLnwWtR7niquRwBHFe6VJm1FyeTCb1+T90sPREh4IUgXnHjygKV/?=
 =?us-ascii?Q?O2/qFjbBIwuXYSTm2G/Jd77vm0fd75oQ3GioERDpLyXoP1EjflMCoeBwwXxJ?=
 =?us-ascii?Q?xTVpZ8C2b0yUD6LRJauav+hVyK1Ec0bl96ZmL1ItXJZUdKs1CGthg36fJQKT?=
 =?us-ascii?Q?vJfUr3AL7gOp8xxS/VhfND/SFZAswQjWqrFXqTN+tiz0YZWB/RpCiZra7xAE?=
 =?us-ascii?Q?NR1cesvSYV2xio90w3+W+lOJ+uSVm9ZX0QqWDG/0jGNZ0Oao9p9CVBcD8/8E?=
 =?us-ascii?Q?7F5vBtqTUkyP+Fkb56/J/ucPBbSxTL4DKbuRHwoyUi1HxZlcsGF9N78wNefc?=
 =?us-ascii?Q?8q+QIWdkXy3/MHkKrLrIA8j/G83qz6fHCCEe8ueMj9NJvojHLhoZuSjG3CrP?=
 =?us-ascii?Q?LWqjovdn3pr5PmE9BnBFZUyev7X6M8mcNffhEl0YzaUlT7i2NDQPt4Q0S2z8?=
 =?us-ascii?Q?X3azSq/ONxhRSdxr4JI0qXaV0uO3rNm7x9x5PaNaiJCnvKF5qYoT2ttOEaWW?=
 =?us-ascii?Q?ip/LGT8zMRiiYFb4JchzkdNTNTF+b8Nl1AXLplppTUagUaLuqaLSfh4ztAS6?=
 =?us-ascii?Q?ntJ+otSACaeOEf0Zz2BnCVye68osMThtG6Bke28w6MOaBrIzQJ48/zH7JjNq?=
 =?us-ascii?Q?oj3B5T6kzphikQijN8EhoCOju4h2MuBjZ1RE2N0h5ctQEXlZpvbcCimn4VS/?=
 =?us-ascii?Q?J2lrnh/Jp9wjaH/HO8WBlYqhB52dRVCqvIKcp/glMKHbLlALEeADqk4Ph/jW?=
 =?us-ascii?Q?gShintcYtz6pHuzZ3jwI0inn471BYOw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 953b2407-3558-48d3-da9b-08decb6882c1
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 05:31:26.5162 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: muudXhruo2SRZgywtCo1VTEMHF5QCdBHO3ETPlvxwcTX5CiPALFueij0cosVwYdHmOZwM0zkIPzXtvsUoc/GhDlyd7APcBy6qwRn9v2OtOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10160
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

