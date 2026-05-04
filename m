Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE9BFF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 13:04:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20510846C3;
	Mon,  4 May 2026 15:03:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="WONNkfn1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51A8D846C6; Mon,  4 May 2026 15:03:37 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49DC784692
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 15:03:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wdvsdZyy5pOfoRiBOEQNxRGZsv2buV1hNDqolr4HSlHgYOiSXNQNFU1lb0W7lS12U6+Iv5O5jN1/7dho1bl9QPkxNeu/wRLP9OYwmQ3JMgMhvDHENY+njDiEM/k/oK3LTAcWEPCNFVyToB5fcRB6OYYK2QLYw5I0EOLCG6H9s0s0D0kmtUATqGYpn8qKkj+5uEQDYJ4RzYlqRIhNhgmGR3VtMVWIEc8+MoRqyShyY84egaSr4mIHhx08tW7AH6aEt/m5XkX58WQdPQ56Q30X0/cuhAFxHaoJEHvWZpa93d5GsTdxgIBw8qURxgxB5jNeIrq/fnxNLI4M5NXu7ZnHYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQ/p2VJ5wGw144PYwP700WD0CX8ySgrRbmsOHjcFJJw=;
 b=TIy89ExSyJPOHE2BWsuojCynouasnpF9OMYwTi0Q24h7f0Ye6f6wIgBIMLcmoHi8sNYtJB8Im2ti0xYZMzpJINQRyBWiO+kRI52v3IZAhj069YEPb4X2sU/Pdxajg3KkR7by4OP+7e/MIwIEBbkCm9CKcEJngiGATwlAzVxQrYsYx4B3RdUXoJ/ViZt4xEDUy5TKwty3JfBjMSN9hMreqE3Oznu65p9E0HAdvaK7yUkelKRf3FZAUCC99Pafup9KmAlQ1tkdI/nsmXosgSq2Sr6gaiidjtwJvCORIc1vnKPVK+EuJPDm2TN7SUVb3nIxm+qBmbQcjPjx9mCvk/HuVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQ/p2VJ5wGw144PYwP700WD0CX8ySgrRbmsOHjcFJJw=;
 b=WONNkfn1jTkk4mrv7Rb7KyVqg3bVfNWAxtAPc8SoJoRmhWCDlgZZTV3xWLO+Y2NOnEzWHvzNCoAxMQlZ8Bd7U0f9IAYTRfvwnbNX7olQ82Zm3bpe9JmUFePTZpt1AYxxoBgX9gP+/Q7I+4phgxHufJanIZDgF6PHJcFE3P7HUfNah6YRvbZDYV6M2hEXyqIW69Bsp/w56sZqhihTYpL0DrFTjk9F/LIcJpVasyuBH2YtsVIxZqsOCJxaYvE5MjpJhP8pf8LPC/qD9AZiUCeFQ2toX8vvKOeN4ED8yfeKdSeLVU7zjDitEm6gfW2FkTYcqGhv5DB8fAC4X4iA9QziBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV2PR08MB8098.eurprd08.prod.outlook.com (2603:10a6:150:76::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 13:03:32 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 13:03:32 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 Anis Chali <chalianis1@gmail.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>, Crt Mori <cmo@melexis.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, u-boot@lists.denx.de,
 David Lechner <dlechner@baylibre.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 8/9] configs: airoha: en7523: enable pinctrl/gpio support
Date: Mon,  4 May 2026 16:03:05 +0300
Message-ID: <20260504130306.2764862-9-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504130306.2764862-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260504130306.2764862-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0017.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:a::6)
 To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV2PR08MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: 5616f782-34dd-40b3-25ca-08dea9dd8b52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|52116014|7416014|22082099003|56012099003|18002099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info: mmNOBHSrz1RPz4dv6Mjf5xGOmvElmRz+D0JC0xoRUh8FgWb912cPpmJT+cyaBBZ6NB7CRd5jXRXoKxy8oRQfzKBAgibfeUYQLYkxRMztTU3FAOVoTf6QdqynauKvFt7MuqcrQg/3soFmtpp09QBkZ6k4f5SE9+m+8H4HoWLAOighZgefPxwIpHgMmCCu8FKeYhIgz06yry3gCIKdeh6hOlpNITNNEsAVHEhY6tdgTZOlf1fVXHRFgmNTXfvjfiYGvpxXuDQEkIG/XqqMnKtiZO2zHpK99a8vJh1s3T4ynBLmqF0A2NGHIyQoWOb3ewB3RI6O2lP8lKvOBOzotRPkl1vx5EjNtLCWgDfKms+EvzOAldT8V1dU6T35s9kXVERuEw2LeHt8Wp/9p9zrHam1ymPjAGPid+EqFij3xS7WmyIRmhVMCIJtvDU4pLaEnLtW7S2/T8vi5Gtxefc0VbOTjbOfmTNaI1BnrKE+4H29y+CyGG8f05vn6DdsldNFATIcDaKWB6MKscur7xacP5CbuZ8tre0M5WtbgPTJ7FPfp9S69hyWnrxieD3P8J3fAvbFMLHKB1J2p+rf+QAsgwI7y4/4ExG0eiQMWsW8aDbigXqKgwOX2O7yjWOXMQLoc0nYJ5icss4lejUr5u0t7Fp7ZYqzX7JEDhJ8OnYVOHXFSYAe0HYN1HtVurgLqwEddugBi//jvycoQJnwKWTWuVhq22jEzuiKef2EfixHR65vGLZw1ZA5TaD4SHNoJPCnsBqg/K/Bs1PNNeEMfsRto6EVlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(52116014)(7416014)(22082099003)(56012099003)(18002099003)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c7j6ulFWSAY8fewTJrUWsWAzkzXl41kYwgri98rU3vEFxRga8B40wbBvU3p9?=
 =?us-ascii?Q?2TcTYUz6d3f19sZzxWkLdgASSssghV/oC5fqIJNNZQx6EEvZ6uv/1ezl09WF?=
 =?us-ascii?Q?tvAPbMnT3UFJWPPkY1qxFtqY0UkiUI2BQvW6ZjW6IOde9eAL2kXukPfx/5Qj?=
 =?us-ascii?Q?1A0RXplRFFaiGMyJwvSNSETTctOOfnZ7hho5D9jmo+F7WHaqZRj8LClDh+x/?=
 =?us-ascii?Q?6M8ZtUm+ibVyZKscUEty6C7d5CWdQRKZVp6LSUMMzqWFe0yg7OXlA47mqSrr?=
 =?us-ascii?Q?drRHiTIYaJdzeLDSUt9uxo0a6oS/qO9ucrnyGw1aVbD1HnSHqooi9ODf5IyK?=
 =?us-ascii?Q?85gJwd3FXDo998dBQEi1PsbG3RMSk5m/edPEQk15TZvZPC2dIj3tz1tKUec4?=
 =?us-ascii?Q?ajsv3gMY4j35UrtnamqNEOqHMXM2SnO+h5JaivITNVNbc+65vaxrnkeM5k4a?=
 =?us-ascii?Q?PGCgiCRAJCwTcXNda5eUl4uoUbfDVqHCB29wdodiSMAg0OriT1zdgcGhpQlS?=
 =?us-ascii?Q?980o0TIlE4rxwugzB/9071oNpEuZN723hReMso6btE4hChf/KrwGnLAMob0u?=
 =?us-ascii?Q?KEmJUJ1n/1cqhxzzsBmL6UCgzXUt3yP4/ZEHKyiqRxx74BWEeBedyutBbKmF?=
 =?us-ascii?Q?vIhzSlm4iIhwPpFyNPDF1ZjbuhzQBjlTPVcBRmBafnAwr2vtioSCkgbNeeoa?=
 =?us-ascii?Q?X3hyM2cl+x1SgGO8v7G4P90hNHQBfk4YGzMXWCaTUN+UflquNP3EzQkSxYfn?=
 =?us-ascii?Q?J68i+kexEaKbOTPmDfRAWMmtzsdCORf5qVHMvmQQHoAE0nzSTPyqTwxPEJMc?=
 =?us-ascii?Q?VEVBrXwPcP1ZMzyf69XKzxvMuEpuloz4QWfjGDlI+jXBPQCmVo4lvAHleisM?=
 =?us-ascii?Q?O7exW83MqoFu1lQnvWWJYC8WAJjBKRH7xbD3t+9HvPJ4jNoMtu+pP9TR1Ppl?=
 =?us-ascii?Q?uCB/yKu6lE2OthU2WaC35SApQw30243M+Iu9U3ZdAE0udp0F69KXtX11qZK7?=
 =?us-ascii?Q?tTt2eeFhtsUDgfnAZWFMh5PwIEEK57Eh3wvjF+ix534zvXA52xnHbgHugFsm?=
 =?us-ascii?Q?x8ui/FyUMkFk3/29OdmlaeBLsd84PyM4BAWMMIt7LlcdLAEiIsk9S6wDkxLF?=
 =?us-ascii?Q?V3MJLaf5FcXMaAXuRZ5UFgmZSOOXRiFwLhMKW/CEOw62NgcBmVj+N2x1UeZe?=
 =?us-ascii?Q?kDz7J1RBCzVNFpAl/HFFHnIJuznIM94lQes8BBxNmgqIRe1NY5yX0LvHrTpN?=
 =?us-ascii?Q?AvvWsnRS/dNSP+fjgLVJ611TVFHx349N9D9e5ugCrPgvTVZiSpj5Z2MVM1gB?=
 =?us-ascii?Q?lVsyRBvdAEGAfgCZdhmYt/pZoLVILE0nbr2bZ+y6ozhUOd8UEIV3Kr+nl0kx?=
 =?us-ascii?Q?HYy01IUULDKYqiBaKVkSvz4xRbVQU0LVuAEle35gcGkbeLGAfVbuMCIAm0Az?=
 =?us-ascii?Q?SWR8b8M+ioM+NzdvPbqgLSGpF+atnm0SyCH/1EdVf1DCsUYv5v5zmY6Gbdl4?=
 =?us-ascii?Q?XgYcdIFjFfmhFM7rhXAG3pnpnpAijEsmftCFqYfmTR5bEvgkP10LIzSBlGyI?=
 =?us-ascii?Q?JM052E+7gsGXvtSXz5FU+JMA3DzVS8AhSKjavthP0Wc6KQ3ok3oYWgZ4uw8Q?=
 =?us-ascii?Q?jDiBXz1+jEdPg2PQV4iigNC0+BltYGn0Z4WQwNs2rO0xspKx8qZIeWWugHI9?=
 =?us-ascii?Q?+OgQ1h+jEKhF4GAAC8l+2LivoFDSoL4KRwasjOsUKO/qhqETx0EVCDaE85tw?=
 =?us-ascii?Q?lsaz7oOuHf0uuuZPRHq93TcVof1zJfY=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5616f782-34dd-40b3-25ca-08dea9dd8b52
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 13:03:32.5253 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WL0PAcsKYNkmvkmZI4ERhQ8xpZ+6jRXfZo3zdNfEO4s7RFTNstiBTv/h/xSmLc0QXdBY3KgsYnaw9AP4V4rnCvNR4pW3LFrVccoBxg+wqeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8098
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

This enables EN7523 pin controller and gpio driver.
Defconfig was minimized with 'make savedefconfig'.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 configs/en7523_evb_defconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/configs/en7523_evb_defconfig b/configs/en7523_evb_defconfig
index 381d5d05616..8b1f3c71e9b 100644
--- a/configs/en7523_evb_defconfig
+++ b/configs/en7523_evb_defconfig
@@ -42,7 +42,6 @@ CONFIG_ENV_MTD_DEV="spi-nand0"
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SYS_RX_ETH_BUFFER=8
-CONFIG_REGMAP=y
 CONFIG_CLK=y
 CONFIG_DMA=y
 CONFIG_LED=y
@@ -55,7 +54,7 @@ CONFIG_DM_MDIO=y
 CONFIG_AIROHA_ETH=y
 CONFIG_PHY=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
+CONFIG_PINCTRL_AIROHA_EN7523=y
 CONFIG_RAM=y
 CONFIG_DM_SERIAL=y
 CONFIG_SYS_NS16550=y
-- 
2.53.0

