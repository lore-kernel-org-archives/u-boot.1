Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 240B0CD6E55
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 19:54:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78FF68488F;
	Mon,  1 Jun 2026 21:53:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="3oGwvtaE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B37BA84855; Mon,  1 Jun 2026 21:53:34 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB6DE8488F
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 21:53:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VWoiWWQjSEhj5V3+ZC+AVtYWQzccmRH3ffA5A9KVNGTfM4y/6dKhuq8jnb0oDjnmWFbLr0kYQgHduMSBos2nUhOybpgcQ2AJVlPiUjp3IRiAevSFYZjS7EwxnMbdJkG/ov8zSi3jVI2UFsXGExmEK8VbPCOE/Ij4+XFcOBvjI2hkfskOkE1zXHIu+y8/Q6YP1UypcKxcBrugCRxDWdWAIufyLQLdHPuxMs/B6ZhSWM88Yd9gYhmB7dWbHAGFxaac5PbV0Fb8ciChCcpLcwYtRVakzF/sg3RIODuYX0doDRNLkovI6I2TA2iyFQhmHGQ8sfFj8QpzLClvQ4NKuXCGTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CTuSEJtUONRqJV+obdsb4ncvj1FKSUiAO0dNj6Vmt8=;
 b=EHptRRPIluKdam7oufGAqAvMcf55sUehzZbRD9OwgkqDO+17h/Mg2Sa6hNugFPwIovLf0SV/kX8hsKzDnKYZ4SFK0Wrj3/tMOKJ+DpNVBpPJV2zS5+CKmgqHcDsEI14cPy6NP0ANLY8qV11Lmb8rYjcbxcF34yRVwI3u90lQLYM1uWFMo5NLtKDrrZvkGydvHOAPG3OZ6F0heX9oXc7dfXK8mJq0mmZbPLyENdTEDaJfM5kX+GJr1vTBjeIBY23RwKu1sazT/UGVA57ZSfYOrKutSqMgFInNYumKGV1u733KxPBmTHMrWyh9V8y8qDNNHJTDI2/QSD3+LipU2OFIpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CTuSEJtUONRqJV+obdsb4ncvj1FKSUiAO0dNj6Vmt8=;
 b=3oGwvtaEER5r8v0DmrmJgewPhl1/vfq1HhpZ+PhfJwCT0nN0lR3kJnB18GF6XXyLGzrNlwHzjOmcqUufg7mrP3qP+GILiiBKNvInf+dntVqrYGUdiR+QshAsiDLyldB0ziUoXG+wWv4VUahBG6mMPzlgUmIYSBBZScebCaR8lCxnwoULJr+mCHoUX6NrCM//2UYtrlWIEBO/EVk1Q/Hg2F5QTV+8p/O5Jqp0mFk+Jd+g2pFYMUpaCnK+kn+MBXMpaPAiPVp1Zh4Jrg1qkkWETiN6N2QKzgB5Rsu2XfbBmJ6TGg/NEx/ezptoJoVrTRQXEdwmZbfteHx1P3fuNbKg/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DBAPR08MB5653.eurprd08.prod.outlook.com (2603:10a6:10:1a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 19:53:29 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 19:53:29 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <sean.anderson@linux.dev>, Anis Chali <chalianis1@gmail.com>,
 Yao Zi <me@ziyao.cc>, Michal Simek <michal.simek@amd.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Crt Mori <cmo@melexis.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v11 05/12] pinctrl: sort and format the contents of the
 makefile
Date: Mon,  1 Jun 2026 22:53:04 +0300
Message-ID: <20260601195311.2390473-6-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260601195311.2390473-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260601195311.2390473-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0025.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::35) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DBAPR08MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: edb98a15-b9a5-432d-d27b-08dec017740b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|52116014|7416014|38350700014|921020|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: d/5KznPvS212nXmUzIkhrowVlOqljvo1HPDi9u1xTya7Codk+7rhFACnWshWsByHl3Wuy7CcVKUdhyTcnmvKOWjigaslyZiYcA0H6USM40Y/KtB5qBrZmD6DhEbVJL4tMI8OkSeQq+0FgQle9IB1ZMnGzoohxSh9bJk+Glex65t0jL2B3nbJwVGh4IQqU7XbVtjqFIlOzxzcmpH6A+c8nnUBD5JpHaMaZ9biJ24Bi2j1VLahGheNU98trjZNY99ILC3KYfoBOWWv/ioZ61LXf5Iw3Zqgaon9x5Fs7Y6o246tUMsYLK15yPYvPWQHTb9X+jHnUvt7CyCnQmRtxDxw7JAuguHjvYuXsLptKG/j20zWBti7W/QhE/BqZo1KAKZR8+R1CWSdtGsMQxOtxeHF1gpLoPApXDHhIwy07m3wQtkk8sKMwqT9fpOSq21qoQEKr6CapHNNE6GshU8vQvwAbYT5Dx1Get0RmJ0jE7XB5NIDOHeCPRmk3W5GKV+GRv+3I7jo0XCfrwTUmWImHN0KSRjF6GF5HIydE91FKsvPMyCEs3oQiQY+ZcEMxpIj6z6U0YjxKwVB3xN/jlFqqdTyevot6Rzrxw7pcdfusmq7zHl5C3Cs/qPwz3PM4BthkHO6SlUSm8+pR6i1y+l8ea66FOSCQQeV2kakYuhAhhmowkSpq9zDF8XhvQRp6Mbybf+z8DWjmtiZVR+coMRDr9/58hjzDoJvnP2ApvXUZ43GfldL85yuTQQGyZPk2jZXmQObLl8NpSpBD2FC6egQaKKdNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(52116014)(7416014)(38350700014)(921020)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tKXwnURJJ/T9sK6QypUnH8eV/7I6CHDSIpDcluK+XAEU88kJ7jRPXgilANf+?=
 =?us-ascii?Q?enZTt4Py69I2TuPu9gliETJEtrJCxOS4y9maSVGXRHEtQk6ud36MCvTdFOX5?=
 =?us-ascii?Q?G5vDc5E43rE6Db7+Es1pq7I2B6BqAb7c8nOyrXrMFC3lhmwxG+USagdQ35vs?=
 =?us-ascii?Q?7AoAlPyKNIT5mQqzXtAbBIXfPt6rvrLpR9ZbBwO8x5NSnT12odD2CzBe8F81?=
 =?us-ascii?Q?O5Io3Pm7qQbqI9+O3IqGN1rzHQU6EDggwyPo20ouZ8B3oEvDKIXPGpMN+hOf?=
 =?us-ascii?Q?nBKuylGUviNcLK6zli00CnQyv9DFAJ7celWpvs1heHyJHny7YzgH5MUFv4XU?=
 =?us-ascii?Q?I5FuLj312rMZU6lcOsaRz+FMQogL37QDbIeOfCiKRiOmYskg4rTXTZKFJ74l?=
 =?us-ascii?Q?KHZEiwHHi0vhK0a4RUtANkkOtZ4p+Fp9ac3IGGcJDHLxITRZ1haVoD8pSVQA?=
 =?us-ascii?Q?Y/BhC3HrbHK0/i5vNrpDxzc5fffblM/lRP430+5qnaBApo9+RMQa4jEW7aGd?=
 =?us-ascii?Q?YHqLoh2tvZko/kvX6Hv01ouIwRh/IOdXMtm92IwPflPDXe/0VOwPP/6FcmUE?=
 =?us-ascii?Q?9E7A9pQZ7P6gszsiBoX5XkgsX8N6Pfo/KDitSHK0zHfUopSCodFTUvJ5xtZd?=
 =?us-ascii?Q?Vk/H9zmmBDY+tLYhXE4Xea6opZgApTJ5wYoon3vpmPGEQVcXIyzHldDTMzM8?=
 =?us-ascii?Q?S4gbaX7TPFsRiUMv75MXUz4rzpkS6RYabgj1LXYWl4UmCglTJzNCXIBEGtqf?=
 =?us-ascii?Q?gZOGP/3sydEMVQmFIkChdD1V8swXHUheGt94dAXizZcttKZGIVZvoSQeIcsA?=
 =?us-ascii?Q?woj8Qi6IN6SnNQZVIsKLW6+3GqNeAvoFGwqmV7oIcTvWKifF78lU6/Le5el5?=
 =?us-ascii?Q?EjeG7BeukmYuVhvGgRucEJ3nSgwqDXAP63kJTkBRc8FgtdtFdMOZ/QEdlIP8?=
 =?us-ascii?Q?VoYBbL5Fgnvji0KQ/Y3Qd5RIt+2FfcJRW3mdRSNLlT1tPTIeXAxiS1MgUAqi?=
 =?us-ascii?Q?Sy0pb2OwpsgRJtOcUG/Yv6o6H4D7H300efiLDGVSKsZcsamixfOQILB+LK2A?=
 =?us-ascii?Q?SVabCm65At595PaFk0hsKi2LJCakyAUSRMB4IGEXuAk+uMs3SghBg9zl4miW?=
 =?us-ascii?Q?NJqBR3HNe5DIvmeDM0G6XoGLkNDWMFBQ6YjWL0EWcyWDU1BAcwcnHfeGVAlH?=
 =?us-ascii?Q?KKrjFuuc+GEd7MCENqvjxhXve4dpt9dANV+gS6s2vLIXQAeiGX/ASRbiXKVx?=
 =?us-ascii?Q?H6vOdPg1BiNxY7JwDZsxc74qwNuiXThakTgt/j/qn6EBFMzOTrcYmYIsgNJR?=
 =?us-ascii?Q?7nGPUCKBKtzgaAPKai3LwI9cNt/dhmCMLYufhllwatCuPsaHChLpCA+BwQc8?=
 =?us-ascii?Q?atcYsgcbTWf/y6TF8cCpyZtyPsCHSrmwh0XL6Uf3O3uasl268C434VjccdFz?=
 =?us-ascii?Q?8iyTZm0ETbo93JsiP6qXSFw8IukR5Lx9bxxlyLjSd2xE2mUh9jJpyfsmZSet?=
 =?us-ascii?Q?SEieivB5UlYmZ3so32FNGZ2PMJx6BirD0Y+pYvVQcJlsZYFv17Ax0eGv+uYr?=
 =?us-ascii?Q?2V2MEiKpqGFo4HEeJ/7KxaeZ3f5RFBndYsteGjkYjEMC50Yuk0ypDR+ebyb2?=
 =?us-ascii?Q?iJdeCo/WbcV9WzXuvkxaO6j+M8SKzkFAy1s8I5tzURIt48+ndLWjXIIYdYJc?=
 =?us-ascii?Q?ml8Lpeop1VHzQ7LphwGNM2pEhACMuVzJGyhpv5otTxZfpiPqVHXmynlc36EP?=
 =?us-ascii?Q?V9oi5DwmPTdZB1zlO9Pzw00vQJYSPs0=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: edb98a15-b9a5-432d-d27b-08dec017740b
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 19:53:29.8252 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8NT3jxas5TFtu1zSoIBBg3qWQSh/iMZABEMUbQUzg6jDX1H7fmADIdmrSCKW4sGNQkKjsiv6PZ2Pl4LTQFRX5dJP2e7t2fLcURwaTOMKqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5653
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

