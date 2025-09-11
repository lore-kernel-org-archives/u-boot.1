Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E93E1CA1016
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 12:16:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B055A834B4;
	Thu, 11 Sep 2025 14:15:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="ZPC4GDiK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA5158331B; Thu, 11 Sep 2025 11:59:25 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 070288331F
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 11:59:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jMZF+fa/YnZsxPXPmTCdQNdbf6OkWciJa+gnFFZBJWXAujbcSn+1CLGyxf696KPq6kpfx2ar/l5ZU821nHE7gYHXihg0YEA1pXhxMKLuMH16L4cE/Ka3tEb/PTRWn05l0U8uH0ZYLO0+CDjOPQah8VIVsMWYuTSPlYrUmPZZtjj+8esQ766oG8ihMH4wgFskZHvwqchiiHiXTS7ZeWs3KSzBkndibhn/Tbnhe0ZLMaMTcgNdhc70oGaqGujNZKuPY+CX7bZeknujUG/kl1Yh4XhF9QunyNwcyG/73pJr0A++jMrwYZy4VYiOfVZBtuiOLakwr8aXaN0u0QfVAGAHjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSn0kqj+eggWJ53kcwvRlllhaIN9EUYQ7Udn6QedjAo=;
 b=shh5eSMdOS4MXmVULmKAXEjsG+hcKlP2IPkKzi2aSn2KdKUO2dwcRuyA9UPG/VQB8dXzF84xcyUqvT2ZElfMLsQC7Xf9UmtIcex4J1/5aOsAPGfm9d5pK+ecnvl+YO9sFi1hKoIWMyvGMr8v2aauFYvb7VmJ0T1KbmaF9vt2hzzYFxX8S8c3PXcy6ANGOM5ifq+b77LUoYZThAr68ydFKA1RNnz82QMbBgXYh9Po/mFjNbLNOgbvbBEO3n246og5k/d+xFn+IdMizDUy/JYDSMCo3tsO+9zIPUnPwPeRzCmogoZOirgCkKj6DBeKYnWZ7/joywi1uCIv39rBK7VQOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSn0kqj+eggWJ53kcwvRlllhaIN9EUYQ7Udn6QedjAo=;
 b=ZPC4GDiK0fE6ZjBwVgmQoGuCzGZWYH6kmPJmaE1K35jexZhlCXs0JxXPxyFPUHMd364sdtNGiSLj2eROTECp24UJCa7Fztb94nLnHs11fUSl1cRcGiiEozunX/H64jDQ2fFSnJsOEAWoMeUwQIWsIsw7aWx7pZzoFNIjIJEPFfpzLZ66snIGPIxQiNFZeUN5j7g6ZY3Jd6qzNhvKUqsqujiyWNfZol5+i5WcQQdQ5eqqAVNBSV1F8oLlM8SjU/NDKLIuEcm4QYWKBhTghEW709BH7kMA+XVf7LeKDAVql0uPzr7YI1XcCt+VpaF9wK8RTf7mV3n0OHPBEGxrAmpSkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by PAXPR04MB8490.eurprd04.prod.outlook.com (2603:10a6:102:1de::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.16; Thu, 11 Sep
 2025 09:59:22 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%7]) with mapi id 15.20.9115.010; Thu, 11 Sep 2025
 09:59:22 +0000
From: Ye Li <ye.li@nxp.com>
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, festevam@gmail.com, uboot-imx@nxp.com, alice.guo@nxp.com,
 ye.li@oss.nxp.com, tharvey@gateworks.com, sumit.garg@linaro.org
Subject: [PATCH 6/8] arm: dts: imx95: Assign HSIOPLL_VCO as HSIOPLL parent
 clock
Date: Thu, 11 Sep 2025 17:58:39 +0800
Message-Id: <20250911095841.3659022-7-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250911095841.3659022-1-ye.li@nxp.com>
References: <20250911095841.3659022-1-ye.li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0123.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::27) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|PAXPR04MB8490:EE_
X-MS-Office365-Filtering-Correlation-Id: 47c7d8d8-ce5f-4142-0515-08ddf119e1eb
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|376014|52116014|42112799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5M5wzq5IcSiEi/+5eABLTR9S5zaPrDvOVCud8jokqXHS8sDKkX9DtJUk4/c1?=
 =?us-ascii?Q?gDbtQyDcwXAAAmct4heNwYFJixO8vvqMMX46ww4T1eWDrakqYhJVoukJuIWj?=
 =?us-ascii?Q?fB2cKayPHSLPWGemI2OlKU2S+h+uLADfI7IYsvLzeWe2SSrfUXQ/O4ETv1qc?=
 =?us-ascii?Q?IrjHSGn2wte3NkkIj4l7mMAajUT4Dhndm32gNWL6Ha77Yk9tD3pcnzRZ9wgA?=
 =?us-ascii?Q?EzDH3NZFyFDvVoPiX+thrKgTegP11/dmwAtgeVSboei+1KYNn+/VmG4luK9l?=
 =?us-ascii?Q?3eQQSb5iQ5Mp0L7S1kcKtl+LI/JxFFRkOp1flqvx03U0hZadBJ1odho5xkOq?=
 =?us-ascii?Q?XcR2uJu94j9iEvfYOFpcL7ealdkfCIuiOYvzhTFmZqofHcOfgTVbG4FnaVQ4?=
 =?us-ascii?Q?8qewLMptBRxVeH/y91bXVnfvt6Z+CcOrSmR5Yp9OaAEWwXr+JydJu7GfKYG3?=
 =?us-ascii?Q?ckVZctzjiK9MANB+GrOHQ+rihxGbmKtHBTytnAsQsA/3WmYyd2HH7Z8bsaFC?=
 =?us-ascii?Q?ahgiJuZKDSH4O9poCY+mo3GNLYl57RPpBUXjpT0+AaaiojAIfbxsQDdOC68P?=
 =?us-ascii?Q?qsnEfZzfKiH1klsjzNNVNLw+k8yb/TfgJThli3u5grHkx/n0MymlCpj7P9/p?=
 =?us-ascii?Q?yahthfIQ80g5JoaB2YZDuzFar/V/ao463dFFSKbkDLP9COYDeR2l6WMvIh4d?=
 =?us-ascii?Q?ME2r2KDKTGTGBgUU8hXc6F2biGQ7JhsrwQiD7Nq6RcZ0QKZkB3o8QmgxL92r?=
 =?us-ascii?Q?t8cti6YaND+y3Q+C38kF7YIganBimXYwM+GQCZ4YvHPNlSfEgDj/PBoU7FEH?=
 =?us-ascii?Q?L+utukbg7fg4oystJP0gq/+pnyG8t7XTs4LO18giUCeEI16gvBBFuYRJn0TW?=
 =?us-ascii?Q?uXTdp0eRTaxJvV0b8jxqJrOLdMYm8alExcUsozjMXvfsaJ8u/I5F79Xd21LS?=
 =?us-ascii?Q?A4xZp0e/KeXv5x58owuQD9X1kYLTY8uTEwec7iyIuAy5v5uU6Tj+Y2DBZxPz?=
 =?us-ascii?Q?pTbnaJ1+YewFjNqKq3blpfKkfSSiM2A6l7/Zi7F2t4f5c5MSoXVVen4BaYL1?=
 =?us-ascii?Q?cGt669NIsaIUJSJikZRE8pZ6byGKtGoPbUpocH0tk9OJIx7reQgIu5d96x6Z?=
 =?us-ascii?Q?bBalEwxewAChxW29Sywd81xdseKjZ9gWL3zAG+uWfGHu/ZKpjTVoUt4HZeQL?=
 =?us-ascii?Q?+DAmJK7J8I5SX8jiCbsH1gN5EonPxIa878rLlcYlMVNMCTxL8yMUrJVTbOP5?=
 =?us-ascii?Q?2wdKZtTTfiOq7j/foDaEYMSQi5F0zeTYXudnhnAWo1OwcoAxBuBiWTbm0+8W?=
 =?us-ascii?Q?88rKMlquHnyxzoJFptE71Xh8AAhOC+5g38vCWy/q71ihfv26pQQaIzeP335Q?=
 =?us-ascii?Q?lIoWt0RoljTC4sOQ7C3FCOMhnMwrlBeNNHcIq22nHNFxkkqq+mD8E/iLNz0K?=
 =?us-ascii?Q?QMK4JwI0ZrHBFvxdJeYuIt84LBc4j5HQvF8MlVXDcq1LH0ppXGqWWw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(42112799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+bru/mnWJ7JhgCI0e9dMyQ2iQTaWlxhhBhzhi/oNLQNs1Hgw3vq7QAHSkVGt?=
 =?us-ascii?Q?Mk3rPYvilAqLjAXt9m58Oe1+kkjSMNehaPKrjteEiMJn/PQiUCTM9aPwEFKK?=
 =?us-ascii?Q?yQ4Ko9K5CYwzjTORbJsHngIjR87ddC102iyAHybBWE/c2U5UYFmzAHPuFfNk?=
 =?us-ascii?Q?xLbLwtn3xAehRKXeKuaLKT/+AM//YTWoJDKosK4EOCXnB1NBF7EIndRgYdM6?=
 =?us-ascii?Q?PHI/knTPgwS0h671LZ7Acxk+5uha5P2OJE1L2k1u23zMH7R3yHtc3uRmXnvb?=
 =?us-ascii?Q?z5SJNSVzfgpovtqpnzxf98RFd53lfaOXsdfn2M0ScS0b0kPgFiYTWWoBLUgG?=
 =?us-ascii?Q?38s7XjbUe61D4iE4WWwSfw8op08KcRPoCgjcN734C0PLZPw5DCBOX1Z5ony8?=
 =?us-ascii?Q?vrVnhL/2z/LCDix/ljD+knTCAnUsKChMJ6t+V9rA4CGson4u/QMiSkph/l7H?=
 =?us-ascii?Q?uyxOfEG7RSimF5dtXj06e1+N+TJQj7y++/JgazRVLmOgJ/PVU3ldobYoRf9p?=
 =?us-ascii?Q?0iQOebe8UklcVmbGTGIgCXJAQHwje2YpeodD2jym6CjHRK04Ku9kd45eGsMU?=
 =?us-ascii?Q?cezkqCNcXwWOPFcn8703W1LkSXzI1HFvc2OGJs/gzeHwWWIB7ehCoI3XXDuk?=
 =?us-ascii?Q?84a4GJNoL1Na3Oe9wU7GARO/Ib9KYR0V/ymoxvPxnI7V1/uqZ3RI82X2CPL1?=
 =?us-ascii?Q?uQG5BjbGFLzAGoEHIDBsU7016KzIuiWxh9LhuQYk9ZoM0lNmR7qo9cR9k4aF?=
 =?us-ascii?Q?UzJa9+g44yOXADrY81UiGZcN9eC2e/7LCzV8Yt+1wYEsUhTFsBFZmxbEMAgJ?=
 =?us-ascii?Q?zOhXRWRyFMaT5B+AebYigT5l2Vlt5btl/usICoOWP6DlIKUNugqJROCeb35o?=
 =?us-ascii?Q?u5RNMEJHENf5kpeRbMRKliwJF7N/sztBfA4yTFHtJnTVRifdvMnEPnyrJdqw?=
 =?us-ascii?Q?pIqZZqINwOvpaRtE/WzgYGcFOyWvpm6bqss5rZRT0/wRTeEFfBC/S/Lnfo9N?=
 =?us-ascii?Q?6dljjZS19cYr/mlKHzftahDI/23WvvyH9jECucurNGLFxaKsMUyIONYckHx4?=
 =?us-ascii?Q?9QqzJdsX7LwxPx6rTGJEtxg5X2nUamGzmVrp4SJkZDRVKitd+iRsbV06EVa7?=
 =?us-ascii?Q?5DdixRkakj+LfM2PDylKB6iFYKivZb9+7GgMI4zCNHANXaWu0Hd71zd7XzT1?=
 =?us-ascii?Q?1bWL0J9WtnEdxQ1GgDyNsRQUgDHOqEGPKzeiehkFdzU5vGzH6bYsgR2MDqG8?=
 =?us-ascii?Q?KZ+JX+hBfNwq8nEOEszApOhGnBEjmSGITjlEV0I5Rg9qvWa7VMbLG7PduFKs?=
 =?us-ascii?Q?pvvkbL1akhfUuTFr9kdAx9slJeug3xfVOKfFZk+K7l4l4OG72vsv69ryzWjO?=
 =?us-ascii?Q?gRX8VK6dubEYNAMcRA4NYZDvHeDcgnPPVv1tIMWxsqo6HKsiug6yvyDvwXoZ?=
 =?us-ascii?Q?sbJnpyPZbBsLAds0t5KYvE+X9VSAguD5iTstZiyZkNpOW5z7LkXSEVmQB+KT?=
 =?us-ascii?Q?k7bzWsTrFz0h1BGsTD9ah+hFEPdSt56SDBFpVlP2KgqBUR8oBD3yqa8/RT4v?=
 =?us-ascii?Q?FyFnw2HOf0ypvW+KfoI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c7d8d8-ce5f-4142-0515-08ddf119e1eb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 09:59:22.7195 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y9MOEOvZOPpVRjcMgn344ZF9/BQFqtjgtsjO64iWsFYhpbNF/0RBO6oErxBO21yu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8490
X-Mailman-Approved-At: Thu, 11 Sep 2025 14:15:16 +0200
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

We have to explicitly assign HSIOPLL_VCO as HSIOPLL parent. So when
enabling HSIOPLL, its parent HSIOPLL_VCO will be enabled firstly.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/dts/imx95-u-boot.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/dts/imx95-u-boot.dtsi b/arch/arm/dts/imx95-u-boot.dtsi
index 9bf8f9834c9e..27f8209b19ca 100644
--- a/arch/arm/dts/imx95-u-boot.dtsi
+++ b/arch/arm/dts/imx95-u-boot.dtsi
@@ -170,6 +170,22 @@
 	bootph-all;
 };
 
+&pcie0 {
+	assigned-clocks =<&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
+					 <&scmi_clk IMX95_CLK_HSIOPLL>,
+					 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
+	assigned-clock-parents = <0>, <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
+				 <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
+};
+
+&pcie1 {
+	assigned-clocks =<&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
+					 <&scmi_clk IMX95_CLK_HSIOPLL>,
+					 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
+	assigned-clock-parents = <0>, <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
+				 <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
+};
+
 &{/soc} {
 	bootph-all;
 };
-- 
2.7.4

