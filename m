Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF106CD4F21
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 02:57:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EE6D846DD;
	Thu, 14 May 2026 04:56:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="ytO9DN7C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 780D1846CE; Thu, 14 May 2026 04:56:18 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40B08846C3
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 04:56:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UOzKnq1aF7OWl4JOXrmmsZqYECIWIN5vpr0EJtoVWmERnLR5dy4gd2Yhfu3+GRNAsyXGWiOjaFhKia7AZu8gUOwocmTB1BECJgoopu6/d5ripox/HM9Yw648JyTQnnoCrOTLbXkLGWJ08Xp7odYXEFSHBWDBoHQ/w+fmn6j4Vy18lWCVYGJF+KWwnDcGwB/chqEw7ksaI/a+GvhLZZApeGkRbNzFkHJb18vNZKGq65vBWBcHlpThLXmr9eEYQjS0wtcHTZ2SRPLLmu7TVP5zKMSclGXSCkvlPoPvzakckVDBeT/rYPDaSY0m9MdZnjVhQ/zKskEzzt0ktCUOU6d8VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9mY1FO8TKU1i5ZASETfzbs+bWJJbWr9/6oYlOLhn/s=;
 b=K/3mBh78YdLt3mRluZap2vAJFMzxVqWcV/bIYQLFDY7ZDGyeugnWsqTpajRQSnwu+BnyisuxnZ1A8vEOMzzZarEBKTN6gWniWvLr26ijeYJnWl4o5aYBtIHPqjRtZeJwXrUXEuTEPcamI5PYnk6v/LIPDcnwovVRzPKnzz1gEa5azFYxWGR5EujCcXtOplDi7DojAjGEc+bqBURRPPm8a1lNanY/OHLE2gNmI4uSmhzFHyUmWaE1NLGqV0Ksfx1VFaYQ41Z5WS0Pq6jpZx0HaCtkUX0Ozje6KmNggs8ta0ypuQ/XW7Xdwr96mPOT64DtP6NXUIUcMSVsq61CMMQADw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9mY1FO8TKU1i5ZASETfzbs+bWJJbWr9/6oYlOLhn/s=;
 b=ytO9DN7CUxtTJYOuvgh5GDL8UcLBcwPb+hXvz6MKe6DI2d3KwKaeO5k6T14Q/QoHDxiCMoxy40mkgZrUDk3F+Q8mophrQb6t7gquSyAOQLu9WypGoSM6xy/dH8sIBLyHRs7FuSxaD/qm/GXHGO+Xdoe4qgS0b5yRJ29kEsKvWsOUwiP9B8o+Gaz4X66AeJOSkeUgpJUfAaQOwPmSvBBdOJCP6L9ZJkBrVMFFS+yh0PkSpM9JXwnlq36l5bHMZj59jwGKzyxpLiFgjoA1dDHG74lmSg168TaJgP38chh6HPCqNlZqCG6AzIVEBcG7bnRoYFbOub/Kyd/DCiB+hVwPUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PR3PR08MB5786.eurprd08.prod.outlook.com (2603:10a6:102:85::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Thu, 14 May
 2026 02:56:13 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 02:56:13 +0000
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
Subject: [PATCH v6 09/12] pinctrl: airoha: add pin controller and gpio driver
 for EN7523 SoC
Date: Thu, 14 May 2026 05:55:39 +0300
Message-ID: <20260514025542.398469-10-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 2eeaaee3-c5f9-4b73-a7e1-08deb1645c21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|52116014|921020|38350700014|18002099003|56012099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info: /6Ia2sD4yLsqKtGPhkWyofkOq5ZnLm3Gjy6utpph34BB48HcW8Bg91eZxAQFtV93KyE45Mfmv+aQTebxucwCqyywhG2TAIGkp/0E4X5sAc2PJPHk4tIQdhcLa14GLGN1iB8xhaTCl89sQztCIXe82SU6tj9sNJMoxpGF3YbkbNQIA8Ye6Asi5HWnj1wdz8m1sj1AT9PBkhHkCid8Et2dSdvMWLemUjJmeDThZDgCs+Tscn9RVmrcqGDlCzJgLdPAysoJjqX78wYmdqORcJVdGcl+xh/MgaROZM8hkQFmQZvQio1JG8yvj3ggrERkWKq/cmRSJ4AlVs9iFmC4hRX0U4lV/HVK5HE1uaZTLFdTJG8Rv/qTrAULDnoYzAzrGbVtMWhRkAoIMqWAoiLqlbA+HrUZb7UDu/bJneG9BTwGPUiwrPJJ2AzNh4QRq3qz3F0TanwZKpzp6+OavQ6WqjA8UizWBGBRK2MXDB336rH5Z3xHNlXH5XohbzMNgo4TtIMtNuriSTbFHyASuc1mM6Xf/QEIrHw4yOWv17PEZlWbY1YmugVcCv2VyNClDMR0yfJKPM3PwDPh6zyGF1l1vyrGevMPR8TeVcb89PTsz5Xtry2Ot00G+Wt9gPtnOak+nboD5RF6/+5YNvbu9TkHYnsB1RLjmoy/nSNar3ixaeljpGrDD8avHE/r+7hy9LT6WjrtZ+JeMgNNDXVJITWGyilbn0GofDyqJSL6pJLNxDrbd3wkixARyxKfP6FPA3MkRJ14W58NS3wLYtjNJ3mLn4SdfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(52116014)(921020)(38350700014)(18002099003)(56012099003)(22082099003)(11063799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nVqK5lggsqMZoEjF3v8FYSQD1l1yfGSdHeKiHfsJ7v3MO8V5OM78A21yRXJK?=
 =?us-ascii?Q?K+kjh4kmE8Yhy0X1VZIaDVM25s9361pLD56IcdgZvAOYUp+nJY0+WG8fxUa+?=
 =?us-ascii?Q?/wK5+TYDq5x4PDLrycTyBL4ZAMzQ56pFzEm35VUMGnb5Xe8eznT/CGPFrBWJ?=
 =?us-ascii?Q?uj5S9KtJR/wbJoXXJxREOGVJuquCkfwvgxvFCha77TjebhIeQxr59KvsPAl3?=
 =?us-ascii?Q?74rrvx1SXNlodwnfB4AyYOggNfm7Rdzs9/t8HiNQe4JvuUrBhypnNjeod6+W?=
 =?us-ascii?Q?cx25yutez1Xb7Dp3VCSMvxFRPc3qDmGVgZH8brPjTOjCz8WqblZNrfFPLf0k?=
 =?us-ascii?Q?pb2eY411u0ZExhyTbX3XAD2o7aoWFN98Nd2rhqyqfkdOl5Ka5oZOcRuniPtP?=
 =?us-ascii?Q?78cII7YJyyvmhzpuM9FEqwyAn9U8+tivorxVSYTebCuzURPnwWYkshIMjDz5?=
 =?us-ascii?Q?vcMT/aG3Rc7nmqpSy7tdijYEdX2zPxeuW71IhdahdUiTktfLI0yEQ4etkkmj?=
 =?us-ascii?Q?+PxToRNY8rI+zyf9pBkfVGrNyKMZM95e670HliYxaP+G/6D7UAqg8Lg1DjgL?=
 =?us-ascii?Q?6x5ZI/91OACsqAxJLaVDnoofG4NNxNdH6453Xx7W5bDAPKcZ4QX5xC2vG5yb?=
 =?us-ascii?Q?f8NnqgbuCTVwZrQJ54mOOb/1sgT5zyIcGu8eN//t0Yj1x2kMsdFZHcd9jdVf?=
 =?us-ascii?Q?GCFH4dKibwkuPcAS+GOTcM7QicBPYzvKn5pd1xT7iYrd1TaAB0vw50uWTwO5?=
 =?us-ascii?Q?PGPzKbbX4tGiOfVYzzEyBZ6eqpok2z7AQYs6EndCJDN1zIh7+fNwwE76G6Bm?=
 =?us-ascii?Q?AsEY4+stRHxKde2CurkA5h2edlMpHXP2MCfm6U+6exuiA11nxabOmE8QIgWL?=
 =?us-ascii?Q?2IAZcFYWYHEJbSmAlVc7XTzvt5HWfThSyPwPIwcRuhoPfjtvuoEXGt6+ctCg?=
 =?us-ascii?Q?e8+CjOIPEa8lV+URJ3dxhO7S/zFngK8O0+00clI8blxcv/xWH+It85ttnAQx?=
 =?us-ascii?Q?2Dvd9arjhCN/ZoDXJpMRyburjzHSVBCmYL1I7usyvFDKdSXrfLBm4NJTA5Sk?=
 =?us-ascii?Q?ZRYFd+yw8OqD4I8xTsdCRYEZexBI4nC1K2N7sr7MrL57TL/5K4T+JnEHvrUC?=
 =?us-ascii?Q?T+/dDcM9Q13Dl9KphKef0zbRmNNuClMfENA/MKcJXgYPj0PQiyviFwJ7NIRy?=
 =?us-ascii?Q?nm5xwLhtISrnL4A3AsOTOHiCsuAMQJBq8xT33SygEgIbas7CiSWytFC3XX0P?=
 =?us-ascii?Q?eyPI9unzcFxH+FMRD5F3cNvNQM36S82m4Xuc8WkUANQd+xGolWoXivjMRiSK?=
 =?us-ascii?Q?qPzuyeiw/MOmctNPhm8Yt+Ups4d44EV/8VQTkf2n4fIJYbqDh/bnjB2XxLd7?=
 =?us-ascii?Q?+e7WoSqBnNhaPL8N2bycPlIpMI9BogfQdYpmaNafZhjLxKdr1M2P9on1Ve4p?=
 =?us-ascii?Q?DydkmMpnBX/IdkWPo/qm7dmR1MJ5/fPlbrHbp+X/2mbIvUGeX8agl4tv4ywB?=
 =?us-ascii?Q?xHTntaGSytgWKBOURbAKPXKXEuX3EYUSiLUldjDxCQxW9QOVwzgVoPkVRWHP?=
 =?us-ascii?Q?slEiZBtAzDQWUsCNvvTws8Nc9srE7K0O10lYv35jyCCeKpsQq6ns66Kas6mL?=
 =?us-ascii?Q?f6jBeabsTwhChB3Yu546Ji12gZ+OASas3Q0UDN3vfpf/6D7Eio2nB06Yj8YR?=
 =?us-ascii?Q?fNgH5ANivLEE4Z9byNgcOeR3EWZfvGwOFMFfXILB+1Pn8tP0ZhU3CB2lNrry?=
 =?us-ascii?Q?ycAMUSgQvEQo24/oCR6hIQVg6mR3gOY=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eeaaee3-c5f9-4b73-a7e1-08deb1645c21
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 02:56:13.5388 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iYdmiS6D3qJknSxgIc1PU37MHJpWZF+0unjZq5jJhMwpGwLApxVIBtxTOUj4jdFwEC3MBWr8v7AY7xYw9T/HvhzkvR+uO+9/xIHI0lfqX4M=
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

This patch adds U-Boot pin controller and gpio driver for Airoha EN7523 SoC.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
 drivers/pinctrl/airoha/Kconfig          |   5 +
 drivers/pinctrl/airoha/Makefile         |   1 +
 drivers/pinctrl/airoha/pinctrl-en7523.c | 648 ++++++++++++++++++++++++
 3 files changed, 654 insertions(+)
 create mode 100644 drivers/pinctrl/airoha/pinctrl-en7523.c

diff --git a/drivers/pinctrl/airoha/Kconfig b/drivers/pinctrl/airoha/Kconfig
index 5d3e29c8fd6..f5d948b27eb 100644
--- a/drivers/pinctrl/airoha/Kconfig
+++ b/drivers/pinctrl/airoha/Kconfig
@@ -10,6 +10,11 @@ config PINCTRL_AIROHA
 	select SYSCON
 	bool
 
+config PINCTRL_AIROHA_EN7523
+	bool "Airoha EN7523 pin controller and gpio driver"
+	depends on TARGET_EN7523
+	select PINCTRL_AIROHA
+
 config PINCTRL_AIROHA_AN7581
 	bool "Airoha AN7581 pin controller and gpio driver"
 	depends on TARGET_AN7581
diff --git a/drivers/pinctrl/airoha/Makefile b/drivers/pinctrl/airoha/Makefile
index c8c99dd22f8..b90bd180591 100644
--- a/drivers/pinctrl/airoha/Makefile
+++ b/drivers/pinctrl/airoha/Makefile
@@ -2,5 +2,6 @@
 
 obj-$(CONFIG_PINCTRL_AIROHA)		+= pinctrl-airoha.o
 
+obj-$(CONFIG_PINCTRL_AIROHA_EN7523)	+= pinctrl-en7523.o
 obj-$(CONFIG_PINCTRL_AIROHA_AN7581)	+= pinctrl-an7581.o
 obj-$(CONFIG_PINCTRL_AIROHA_AN7583)	+= pinctrl-an7583.o
diff --git a/drivers/pinctrl/airoha/pinctrl-en7523.c b/drivers/pinctrl/airoha/pinctrl-en7523.c
new file mode 100644
index 00000000000..a72e860f2db
--- /dev/null
+++ b/drivers/pinctrl/airoha/pinctrl-en7523.c
@@ -0,0 +1,648 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Author: Lorenzo Bianconi <lorenzo@kernel.org>
+ * Author: Benjamin Larsson <benjamin.larsson@genexis.eu>
+ * Author: Markus Gothe <markus.gothe@genexis.eu>
+ * Author: Matheus Sampaio Queiroga <srherobrine20@gmail.com>
+ */
+#include "airoha-common.h"
+
+static const int en7523_uart2_pins[] = { 8, 9 };
+static const int en7523_smi_mdio_pins[] = { 8, 9 };
+static const int en7523_i2c_slave_pins[] = { 2, 3 };
+static const int en7523_jtag_pins[] = { 22, 23, 24, 25, 26 };
+static const int en7523_sipo_pins[] = { 1, 18, 26 };
+static const int en7523_pcm1_pins[] = { 12, 13, 14, 15 };
+static const int en7523_pcm2_pins[] = { 4, 5, 6, 7 };
+static const int en7523_pcm_rst_pins[] = { 2 };
+static const int en7523_pcm_int_pins[] = { 3 };
+static const int en7523_slic_spi_cs1_pins[] = { 10 };
+static const int en7523_slic_spi_cs2_pins[] = { 27 };
+static const int en7523_slic_spi_cs3_pins[] = { 8 };
+static const int en7523_slic_spi_cs4_pins[] = { 11 };
+static const int en7523_pcie_reset0_pins[] = { 28 };
+static const int en7523_pcie_reset1_pins[] = { 29 };
+static const int en7523_gpio0_pins[] = { 0 };
+static const int en7523_gpio1_pins[] = { 1 };
+static const int en7523_gpio2_pins[] = { 2 };
+static const int en7523_gpio3_pins[] = { 3 };
+static const int en7523_gpio4_pins[] = { 4 };
+static const int en7523_gpio5_pins[] = { 5 };
+static const int en7523_gpio6_pins[] = { 6 };
+static const int en7523_gpio7_pins[] = { 7 };
+static const int en7523_gpio8_pins[] = { 8 };
+static const int en7523_gpio9_pins[] = { 9 };
+static const int en7523_gpio10_pins[] = { 10 };
+static const int en7523_gpio11_pins[] = { 11 };
+static const int en7523_gpio12_pins[] = { 12 };
+static const int en7523_gpio13_pins[] = { 13 };
+static const int en7523_gpio14_pins[] = { 14 };
+static const int en7523_gpio15_pins[] = { 15 };
+static const int en7523_gpio16_pins[] = { 16 };
+static const int en7523_gpio17_pins[] = { 17 };
+static const int en7523_gpio18_pins[] = { 18 };
+static const int en7523_gpio19_pins[] = { 19 };
+static const int en7523_gpio20_pins[] = { 20 };
+static const int en7523_gpio21_pins[] = { 21 };
+static const int en7523_gpio22_pins[] = { 22 };
+static const int en7523_gpio23_pins[] = { 23 };
+static const int en7523_gpio24_pins[] = { 24 };
+static const int en7523_gpio25_pins[] = { 25 };
+static const int en7523_gpio26_pins[] = { 26 };
+static const int en7523_gpio27_pins[] = { 27 };
+static const int en7523_gpio28_pins[] = { 28 };
+static const int en7523_gpio29_pins[] = { 29 };
+
+static struct pinctrl_pin_desc en7523_pinctrl_pins[] = {
+	PINCTRL_PIN(0, "gpio0"),
+	PINCTRL_PIN(1, "gpio1"),
+	PINCTRL_PIN(2, "gpio2"),
+	PINCTRL_PIN(3, "gpio3"),
+	PINCTRL_PIN(4, "gpio4"),
+	PINCTRL_PIN(5, "gpio5"),
+	PINCTRL_PIN(6, "gpio6"),
+	PINCTRL_PIN(7, "gpio7"),
+	PINCTRL_PIN(8, "gpio8"),
+	PINCTRL_PIN(9, "gpio9"),
+	PINCTRL_PIN(10, "gpio10"),
+	PINCTRL_PIN(11, "gpio11"),
+	PINCTRL_PIN(12, "zsync"),
+	PINCTRL_PIN(13, "zclk"),
+	PINCTRL_PIN(14, "zmosi"),
+	PINCTRL_PIN(15, "zmiso"),
+	PINCTRL_PIN(16, "gpio16"),
+	PINCTRL_PIN(17, "gpio17"),
+	PINCTRL_PIN(18, "gpio18"),
+	PINCTRL_PIN(19, "gpio19"),
+	PINCTRL_PIN(20, "gpio20"),
+	PINCTRL_PIN(21, "gpio21"),
+	PINCTRL_PIN(22, "gpio22"),
+	PINCTRL_PIN(23, "gpio23"),
+	PINCTRL_PIN(24, "gpio24"),
+	PINCTRL_PIN(25, "gpio25"),
+	PINCTRL_PIN(26, "gpio26"),
+	PINCTRL_PIN(27, "gpio27"),
+	PINCTRL_PIN(28, "pcie_reset0"),
+	PINCTRL_PIN(29, "pcie_reset1"),
+	PINCTRL_PIN(30, "gpio30"),
+	PINCTRL_PIN(31, "gpio31"),
+	PINCTRL_PIN(32, "gpio32"),
+	PINCTRL_PIN(33, "gpio33"),
+	PINCTRL_PIN(34, "gpio34"),
+	PINCTRL_PIN(35, "gpio35"),
+	PINCTRL_PIN(36, "gpio36"),
+	PINCTRL_PIN(37, "gpio37"),
+	PINCTRL_PIN(38, "gpio38"),
+	PINCTRL_PIN(39, "gpio39"),
+	PINCTRL_PIN(40, "gpio40"),
+	PINCTRL_PIN(41, "gpio41"),
+	PINCTRL_PIN(42, "gpio42"),
+	PINCTRL_PIN(43, "gpio43"),
+	PINCTRL_PIN(44, "gpio44"),
+	PINCTRL_PIN(45, "gpio45"),
+	PINCTRL_PIN(46, "gpio46"),
+	PINCTRL_PIN(47, "gpio47"),
+	PINCTRL_PIN(48, "gpio48"),
+	PINCTRL_PIN(49, "gpio49"),
+	PINCTRL_PIN(50, "gpio50"),
+	PINCTRL_PIN(51, "gpio51"),
+	PINCTRL_PIN(52, "gpio52"),
+	PINCTRL_PIN(53, "gpio53"),
+	PINCTRL_PIN(54, "gpio54"),
+	PINCTRL_PIN(55, "gpio55"),
+	PINCTRL_PIN(56, "gpio56"),
+	PINCTRL_PIN(57, "gpio57"),
+};
+
+static const char *const en7523_uart2_groups[] = { "uart2" };
+static const char *const en7523_smi_mdio_groups[] = { "mdio" };
+static const char *const en7523_i2c_slave_groups[] = { "i2c_slave" };
+static const char *const en7523_jtag_groups[] = { "jtag" };
+static const char *const en7523_pcie_reset_groups[] = {
+	"pcie_reset0", "pcie_reset1"
+};
+static const char *const en7523_sipo_groups[] = { "sipo" };
+static const char *const en7523_pcm_groups[] = {
+	"pcm1", "pcm2", "pcm_rst", "pcm_int"
+};
+static const char *const en7523_slic_spi_groups[] = {
+	"slic_spi_cs1", "slic_spi_cs2", "slic_spi_cs3", "slic_spi_cs4"
+};
+static const char *const en7523_pwm_groups[] = {
+	"gpio0",  "gpio1",  "gpio2",  "gpio3",  "gpio4",  "gpio5",  "gpio6",
+	"gpio7",  "gpio8",  "gpio9",  "gpio10", "gpio11", "gpio12", "gpio13",
+	"gpio14", "gpio15", "gpio16", "gpio17", "gpio18", "gpio19", "gpio20",
+	"gpio21", "gpio22", "gpio23", "gpio24", "gpio25", "gpio26", "gpio27",
+	"gpio28", "gpio29",
+};
+static const char *const en7523_phy1_led0_groups[] = {
+	"gpio22", "gpio23", "gpio24", "gpio25"
+};
+static const char *const en7523_phy2_led0_groups[] = {
+	"gpio22", "gpio23", "gpio24", "gpio25"
+};
+static const char *const en7523_phy3_led0_groups[] = {
+	"gpio22", "gpio23", "gpio24", "gpio25"
+};
+static const char *const en7523_phy4_led0_groups[] = {
+	"gpio22", "gpio23", "gpio24", "gpio25"
+};
+static const char *const en7523_phy1_led1_groups[] = {
+	"gpio7", "gpio6", "gpio5", "gpio4"
+};
+static const char *const en7523_phy2_led1_groups[] = {
+	"gpio7", "gpio6", "gpio5", "gpio4"
+};
+static const char *const en7523_phy3_led1_groups[] = {
+	"gpio7", "gpio6", "gpio5", "gpio4"
+};
+static const char *const en7523_phy4_led1_groups[] = {
+	"gpio7", "gpio6", "gpio5", "gpio4"
+};
+
+static const struct airoha_pinctrl_func_group en7523_uart2_func_group[] = {
+	{
+		.name = "uart2",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_GPIO_PON_MODE,
+			       GPIO_UART2_MODE_MASK, GPIO_UART2_MODE_MASK },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group en7523_smi_mdio_func_group[] = {
+	{
+		.name = "mdio",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_GPIO_2ND_I2C_MODE,
+			       GPIO_MDC_IO_MASTER_MODE_MODE,
+			       GPIO_MDC_IO_MASTER_MODE_MODE },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group en7523_i2c_slave_func_group[] = {
+	{
+		.name = "i2c_slave",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_GPIO_2ND_I2C_MODE,
+			       GPIO_I2C_SLAVE_MODE_MODE,
+			       GPIO_I2C_SLAVE_MODE_MODE },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group en7523_jtag_func_group[] = {
+	{
+		.name = "jtag",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_NPU_UART_EN,
+			       JTAG_UDI_EN_MASK, JTAG_UDI_EN_MASK },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group en7523_pcie_reset_func_group[] = {
+	{
+		.name = "pcie_reset0",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_GPIO_PON_MODE,
+			       GPIO_PCIE_RESET0_MASK, GPIO_PCIE_RESET0_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "pcie_reset1",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_GPIO_PON_MODE,
+			       GPIO_PCIE_RESET1_MASK, GPIO_PCIE_RESET1_MASK },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group en7523_sipo_func_group[] = {
+	{
+		.name = "sipo",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_GPIO_PON_MODE,
+			       GPIO_SIPO_MODE_MASK, GPIO_SIPO_MODE_MASK },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group en7523_pcm_func_group[] = {
+	{
+		.name = "pcm1",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_GPIO_SPI_CS1_MODE,
+			       GPIO_PCM1_MODE_MASK, GPIO_PCM1_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "pcm2",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_GPIO_SPI_CS1_MODE,
+			       GPIO_PCM2_MODE_MASK, GPIO_PCM2_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "pcm_rst",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_GPIO_SPI_CS1_MODE,
+			       GPIO_PCM_RESET_MODE_MASK, GPIO_PCM_RESET_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "pcm_int",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_GPIO_SPI_CS1_MODE,
+			       GPIO_PCM_INT_MODE_MASK, GPIO_PCM_INT_MODE_MASK },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group en7523_slic_spi_func_group[] = {
+	{
+		.name = "slic_spi_cs1",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_GPIO_SPI_CS1_MODE,
+			       GPIO_PCM_SPI_CS1_MODE_MASK, GPIO_PCM_SPI_CS1_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "slic_spi_cs2",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_GPIO_SPI_CS1_MODE,
+			       GPIO_PCM_SPI_CS2_MODE_P128_MASK,
+			       GPIO_PCM_SPI_CS2_MODE_P128_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "slic_spi_cs3",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_GPIO_SPI_CS1_MODE,
+			       GPIO_PCM_SPI_CS3_MODE_MASK, GPIO_PCM_SPI_CS3_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "slic_spi_cs4",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_GPIO_SPI_CS1_MODE,
+			       GPIO_PCM_SPI_CS4_MODE_MASK, GPIO_PCM_SPI_CS4_MODE_MASK },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group en7523_pwm_func_group[] = {
+	AIROHA_PINCTRL_PWM("gpio0", GPIO0_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM("gpio1", GPIO1_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM("gpio2", GPIO2_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM("gpio3", GPIO3_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM("gpio4", GPIO4_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM("gpio5", GPIO5_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM("gpio6", GPIO6_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM("gpio7", GPIO7_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM("gpio8", GPIO8_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM("gpio9", GPIO9_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM("gpio10", GPIO10_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM("gpio11", GPIO11_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM("gpio12", GPIO12_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM("gpio13", GPIO13_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM("gpio14", GPIO14_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM("gpio15", GPIO15_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio16", GPIO16_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio17", GPIO17_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio18", GPIO18_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio19", GPIO19_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio20", GPIO20_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio21", GPIO21_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio22", GPIO22_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio23", GPIO23_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio24", GPIO24_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio25", GPIO25_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio26", GPIO26_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio27", GPIO27_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio28", GPIO28_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio29", GPIO29_FLASH_MODE_CFG),
+};
+
+static const struct airoha_pinctrl_func_group en7523_phy1_led0_func_group[] = {
+	AIROHA_PINCTRL_PHY_LED0(EN7523, "gpio22", GPIO_LAN0_LED0_MODE_MASK,
+				LAN0_LED_MAPPING_MASK, LAN0_PHY_LED_MAP(0)),
+	AIROHA_PINCTRL_PHY_LED0(EN7523, "gpio23", GPIO_LAN1_LED0_MODE_MASK,
+				LAN1_LED_MAPPING_MASK, LAN1_PHY_LED_MAP(0)),
+	AIROHA_PINCTRL_PHY_LED0(EN7523, "gpio24", GPIO_LAN2_LED0_MODE_MASK,
+				LAN2_LED_MAPPING_MASK, LAN2_PHY_LED_MAP(0)),
+	AIROHA_PINCTRL_PHY_LED0(EN7523, "gpio25", GPIO_LAN3_LED0_MODE_MASK,
+				LAN3_LED_MAPPING_MASK, LAN3_PHY_LED_MAP(0)),
+};
+
+static const struct airoha_pinctrl_func_group en7523_phy2_led0_func_group[] = {
+	AIROHA_PINCTRL_PHY_LED0(EN7523, "gpio22", GPIO_LAN0_LED0_MODE_MASK,
+				LAN0_LED_MAPPING_MASK, LAN0_PHY_LED_MAP(1)),
+	AIROHA_PINCTRL_PHY_LED0(EN7523, "gpio23", GPIO_LAN1_LED0_MODE_MASK,
+				LAN1_LED_MAPPING_MASK, LAN1_PHY_LED_MAP(1)),
+	AIROHA_PINCTRL_PHY_LED0(EN7523, "gpio24", GPIO_LAN2_LED0_MODE_MASK,
+				LAN2_LED_MAPPING_MASK, LAN2_PHY_LED_MAP(1)),
+	AIROHA_PINCTRL_PHY_LED0(EN7523, "gpio25", GPIO_LAN3_LED0_MODE_MASK,
+				LAN3_LED_MAPPING_MASK, LAN3_PHY_LED_MAP(1)),
+};
+
+static const struct airoha_pinctrl_func_group en7523_phy3_led0_func_group[] = {
+	AIROHA_PINCTRL_PHY_LED0(EN7523, "gpio22", GPIO_LAN0_LED0_MODE_MASK,
+				LAN0_LED_MAPPING_MASK, LAN0_PHY_LED_MAP(2)),
+	AIROHA_PINCTRL_PHY_LED0(EN7523, "gpio23", GPIO_LAN1_LED0_MODE_MASK,
+				LAN1_LED_MAPPING_MASK, LAN1_PHY_LED_MAP(2)),
+	AIROHA_PINCTRL_PHY_LED0(EN7523, "gpio24", GPIO_LAN2_LED0_MODE_MASK,
+				LAN2_LED_MAPPING_MASK, LAN2_PHY_LED_MAP(2)),
+	AIROHA_PINCTRL_PHY_LED0(EN7523, "gpio25", GPIO_LAN3_LED0_MODE_MASK,
+				LAN3_LED_MAPPING_MASK, LAN3_PHY_LED_MAP(2)),
+};
+
+static const struct airoha_pinctrl_func_group en7523_phy4_led0_func_group[] = {
+	AIROHA_PINCTRL_PHY_LED0(EN7523, "gpio22", GPIO_LAN0_LED0_MODE_MASK,
+				LAN0_LED_MAPPING_MASK, LAN0_PHY_LED_MAP(3)),
+	AIROHA_PINCTRL_PHY_LED0(EN7523, "gpio23", GPIO_LAN1_LED0_MODE_MASK,
+				LAN1_LED_MAPPING_MASK, LAN1_PHY_LED_MAP(3)),
+	AIROHA_PINCTRL_PHY_LED0(EN7523, "gpio24", GPIO_LAN2_LED0_MODE_MASK,
+				LAN2_LED_MAPPING_MASK, LAN2_PHY_LED_MAP(3)),
+	AIROHA_PINCTRL_PHY_LED0(EN7523, "gpio25", GPIO_LAN3_LED0_MODE_MASK,
+				LAN3_LED_MAPPING_MASK, LAN3_PHY_LED_MAP(3)),
+};
+
+static const struct airoha_pinctrl_func_group en7523_phy1_led1_func_group[] = {
+	AIROHA_PINCTRL_PHY_LED1(EN7523, "gpio7", GPIO_LAN0_LED1_MODE_MASK,
+				LAN0_LED_MAPPING_MASK, LAN0_PHY_LED_MAP(0)),
+	AIROHA_PINCTRL_PHY_LED1(EN7523, "gpio6", GPIO_LAN1_LED1_MODE_MASK,
+				LAN1_LED_MAPPING_MASK, LAN1_PHY_LED_MAP(0)),
+	AIROHA_PINCTRL_PHY_LED1(EN7523, "gpio5", GPIO_LAN2_LED1_MODE_MASK,
+				LAN2_LED_MAPPING_MASK, LAN2_PHY_LED_MAP(0)),
+	AIROHA_PINCTRL_PHY_LED1(EN7523, "gpio4", GPIO_LAN3_LED1_MODE_MASK,
+				LAN3_LED_MAPPING_MASK, LAN3_PHY_LED_MAP(0)),
+};
+
+static const struct airoha_pinctrl_func_group en7523_phy2_led1_func_group[] = {
+	AIROHA_PINCTRL_PHY_LED1(EN7523, "gpio7", GPIO_LAN0_LED1_MODE_MASK,
+				LAN0_LED_MAPPING_MASK, LAN0_PHY_LED_MAP(1)),
+	AIROHA_PINCTRL_PHY_LED1(EN7523, "gpio6", GPIO_LAN1_LED1_MODE_MASK,
+				LAN1_LED_MAPPING_MASK, LAN1_PHY_LED_MAP(1)),
+	AIROHA_PINCTRL_PHY_LED1(EN7523, "gpio5", GPIO_LAN2_LED1_MODE_MASK,
+				LAN2_LED_MAPPING_MASK, LAN2_PHY_LED_MAP(1)),
+	AIROHA_PINCTRL_PHY_LED1(EN7523, "gpio4", GPIO_LAN3_LED1_MODE_MASK,
+				LAN3_LED_MAPPING_MASK, LAN3_PHY_LED_MAP(1)),
+};
+
+static const struct airoha_pinctrl_func_group en7523_phy3_led1_func_group[] = {
+	AIROHA_PINCTRL_PHY_LED1(EN7523, "gpio7", GPIO_LAN0_LED1_MODE_MASK,
+				LAN0_LED_MAPPING_MASK, LAN0_PHY_LED_MAP(2)),
+	AIROHA_PINCTRL_PHY_LED1(EN7523, "gpio6", GPIO_LAN1_LED1_MODE_MASK,
+				LAN1_LED_MAPPING_MASK, LAN1_PHY_LED_MAP(2)),
+	AIROHA_PINCTRL_PHY_LED1(EN7523, "gpio5", GPIO_LAN2_LED1_MODE_MASK,
+				LAN2_LED_MAPPING_MASK, LAN2_PHY_LED_MAP(2)),
+	AIROHA_PINCTRL_PHY_LED1(EN7523, "gpio4", GPIO_LAN3_LED1_MODE_MASK,
+				LAN3_LED_MAPPING_MASK, LAN3_PHY_LED_MAP(2)),
+};
+
+static const struct airoha_pinctrl_func_group en7523_phy4_led1_func_group[] = {
+	AIROHA_PINCTRL_PHY_LED1(EN7523, "gpio7", GPIO_LAN0_LED1_MODE_MASK,
+				LAN0_LED_MAPPING_MASK, LAN0_PHY_LED_MAP(3)),
+	AIROHA_PINCTRL_PHY_LED1(EN7523, "gpio6", GPIO_LAN1_LED1_MODE_MASK,
+				LAN1_LED_MAPPING_MASK, LAN1_PHY_LED_MAP(3)),
+	AIROHA_PINCTRL_PHY_LED1(EN7523, "gpio5", GPIO_LAN2_LED1_MODE_MASK,
+				LAN2_LED_MAPPING_MASK, LAN2_PHY_LED_MAP(3)),
+	AIROHA_PINCTRL_PHY_LED1(EN7523, "gpio4", GPIO_LAN3_LED1_MODE_MASK,
+				LAN3_LED_MAPPING_MASK, LAN3_PHY_LED_MAP(3)),
+};
+
+static const struct pingroup en7523_pinctrl_groups[] = {
+	PINCTRL_PIN_GROUP("uart2", en7523_uart2),
+	PINCTRL_PIN_GROUP("mdio", en7523_smi_mdio),
+	PINCTRL_PIN_GROUP("i2c_slave", en7523_i2c_slave),
+	PINCTRL_PIN_GROUP("jtag", en7523_jtag),
+	PINCTRL_PIN_GROUP("sipo", en7523_sipo),
+	PINCTRL_PIN_GROUP("pcm1", en7523_pcm1),
+	PINCTRL_PIN_GROUP("pcm2", en7523_pcm2),
+	PINCTRL_PIN_GROUP("pcm_rst", en7523_pcm_rst),
+	PINCTRL_PIN_GROUP("pcm_int", en7523_pcm_int),
+	PINCTRL_PIN_GROUP("slic_spi_cs1", en7523_slic_spi_cs1),
+	PINCTRL_PIN_GROUP("slic_spi_cs2", en7523_slic_spi_cs2),
+	PINCTRL_PIN_GROUP("slic_spi_cs3", en7523_slic_spi_cs3),
+	PINCTRL_PIN_GROUP("slic_spi_cs4", en7523_slic_spi_cs4),
+	PINCTRL_PIN_GROUP("pcie_reset0", en7523_pcie_reset0),
+	PINCTRL_PIN_GROUP("pcie_reset1", en7523_pcie_reset1),
+	PINCTRL_PIN_GROUP("gpio0", en7523_gpio0),
+	PINCTRL_PIN_GROUP("gpio1", en7523_gpio1),
+	PINCTRL_PIN_GROUP("gpio2", en7523_gpio2),
+	PINCTRL_PIN_GROUP("gpio3", en7523_gpio3),
+	PINCTRL_PIN_GROUP("gpio4", en7523_gpio4),
+	PINCTRL_PIN_GROUP("gpio5", en7523_gpio5),
+	PINCTRL_PIN_GROUP("gpio6", en7523_gpio6),
+	PINCTRL_PIN_GROUP("gpio7", en7523_gpio7),
+	PINCTRL_PIN_GROUP("gpio8", en7523_gpio8),
+	PINCTRL_PIN_GROUP("gpio9", en7523_gpio9),
+	PINCTRL_PIN_GROUP("gpio10", en7523_gpio10),
+	PINCTRL_PIN_GROUP("gpio11", en7523_gpio11),
+	PINCTRL_PIN_GROUP("gpio12", en7523_gpio12),
+	PINCTRL_PIN_GROUP("gpio13", en7523_gpio13),
+	PINCTRL_PIN_GROUP("gpio14", en7523_gpio14),
+	PINCTRL_PIN_GROUP("gpio15", en7523_gpio15),
+	PINCTRL_PIN_GROUP("gpio16", en7523_gpio16),
+	PINCTRL_PIN_GROUP("gpio17", en7523_gpio17),
+	PINCTRL_PIN_GROUP("gpio18", en7523_gpio18),
+	PINCTRL_PIN_GROUP("gpio19", en7523_gpio19),
+	PINCTRL_PIN_GROUP("gpio20", en7523_gpio20),
+	PINCTRL_PIN_GROUP("gpio21", en7523_gpio21),
+	PINCTRL_PIN_GROUP("gpio22", en7523_gpio22),
+	PINCTRL_PIN_GROUP("gpio23", en7523_gpio23),
+	PINCTRL_PIN_GROUP("gpio24", en7523_gpio24),
+	PINCTRL_PIN_GROUP("gpio25", en7523_gpio25),
+	PINCTRL_PIN_GROUP("gpio26", en7523_gpio26),
+	PINCTRL_PIN_GROUP("gpio27", en7523_gpio27),
+	PINCTRL_PIN_GROUP("gpio28", en7523_gpio28),
+	PINCTRL_PIN_GROUP("gpio29", en7523_gpio29),
+};
+
+static const struct airoha_pinctrl_func en7523_pinctrl_funcs[] = {
+	PINCTRL_FUNC_DESC("uart", en7523_uart2),
+	PINCTRL_FUNC_DESC("mdio", en7523_smi_mdio),
+	PINCTRL_FUNC_DESC("i2c", en7523_i2c_slave),
+	PINCTRL_FUNC_DESC("jtag", en7523_jtag),
+	PINCTRL_FUNC_DESC("pcie_reset", en7523_pcie_reset),
+	PINCTRL_FUNC_DESC("sipo", en7523_sipo),
+	PINCTRL_FUNC_DESC("pcm", en7523_pcm),
+	PINCTRL_FUNC_DESC("slic_spi", en7523_slic_spi),
+	PINCTRL_FUNC_DESC("pwm", en7523_pwm),
+	PINCTRL_FUNC_DESC("phy1_led0", en7523_phy1_led0),
+	PINCTRL_FUNC_DESC("phy1_led1", en7523_phy1_led1),
+	PINCTRL_FUNC_DESC("phy2_led0", en7523_phy2_led0),
+	PINCTRL_FUNC_DESC("phy2_led1", en7523_phy2_led1),
+	PINCTRL_FUNC_DESC("phy3_led0", en7523_phy3_led0),
+	PINCTRL_FUNC_DESC("phy3_led1", en7523_phy3_led1),
+	PINCTRL_FUNC_DESC("phy4_led0", en7523_phy4_led0),
+	PINCTRL_FUNC_DESC("phy4_led1", en7523_phy4_led1),
+};
+
+static const struct airoha_pinctrl_conf en7523_pinctrl_pullup_conf[] = {
+	PINCTRL_CONF_DESC(0, REG_GPIO_L_PU, BIT(0)),
+	PINCTRL_CONF_DESC(1, REG_GPIO_L_PU, BIT(1)),
+	PINCTRL_CONF_DESC(2, REG_GPIO_L_PU, BIT(2)),
+	PINCTRL_CONF_DESC(3, REG_GPIO_L_PU, BIT(3)),
+	PINCTRL_CONF_DESC(4, REG_GPIO_L_PU, BIT(4)),
+	PINCTRL_CONF_DESC(5, REG_GPIO_L_PU, BIT(5)),
+	PINCTRL_CONF_DESC(6, REG_GPIO_L_PU, BIT(6)),
+	PINCTRL_CONF_DESC(7, REG_GPIO_L_PU, BIT(7)),
+	PINCTRL_CONF_DESC(8, REG_GPIO_L_PU, BIT(8)),
+	PINCTRL_CONF_DESC(9, REG_GPIO_L_PU, BIT(9)),
+	PINCTRL_CONF_DESC(10, REG_GPIO_L_PU, BIT(10)),
+	PINCTRL_CONF_DESC(11, REG_GPIO_L_PU, BIT(11)),
+	PINCTRL_CONF_DESC(12, REG_GPIO_L_PU, BIT(12)),
+	PINCTRL_CONF_DESC(13, REG_GPIO_L_PU, BIT(13)),
+	PINCTRL_CONF_DESC(14, REG_GPIO_L_PU, BIT(14)),
+	PINCTRL_CONF_DESC(15, REG_GPIO_L_PU, BIT(15)),
+	PINCTRL_CONF_DESC(16, REG_GPIO_L_PU, BIT(16)),
+	PINCTRL_CONF_DESC(17, REG_GPIO_L_PU, BIT(17)),
+	PINCTRL_CONF_DESC(18, REG_GPIO_L_PU, BIT(18)),
+	PINCTRL_CONF_DESC(19, REG_GPIO_L_PU, BIT(19)),
+	PINCTRL_CONF_DESC(20, REG_GPIO_L_PU, BIT(20)),
+	PINCTRL_CONF_DESC(21, REG_GPIO_L_PU, BIT(21)),
+	PINCTRL_CONF_DESC(22, REG_GPIO_L_PU, BIT(22)),
+	PINCTRL_CONF_DESC(23, REG_GPIO_L_PU, BIT(23)),
+	PINCTRL_CONF_DESC(24, REG_GPIO_L_PU, BIT(24)),
+	PINCTRL_CONF_DESC(25, REG_GPIO_L_PU, BIT(25)),
+	PINCTRL_CONF_DESC(26, REG_GPIO_L_PU, BIT(26)),
+	PINCTRL_CONF_DESC(27, REG_GPIO_L_PU, BIT(27)),
+	PINCTRL_CONF_DESC(28, REG_I2C_SDA_PU, PCIE0_RESET_PU_MASK),
+	PINCTRL_CONF_DESC(29, REG_I2C_SDA_PU, PCIE1_RESET_PU_MASK),
+};
+
+static const struct airoha_pinctrl_conf en7523_pinctrl_pulldown_conf[] = {
+	PINCTRL_CONF_DESC(0, REG_GPIO_L_PD, BIT(0)),
+	PINCTRL_CONF_DESC(1, REG_GPIO_L_PD, BIT(1)),
+	PINCTRL_CONF_DESC(2, REG_GPIO_L_PD, BIT(2)),
+	PINCTRL_CONF_DESC(3, REG_GPIO_L_PD, BIT(3)),
+	PINCTRL_CONF_DESC(4, REG_GPIO_L_PD, BIT(4)),
+	PINCTRL_CONF_DESC(5, REG_GPIO_L_PD, BIT(5)),
+	PINCTRL_CONF_DESC(6, REG_GPIO_L_PD, BIT(6)),
+	PINCTRL_CONF_DESC(7, REG_GPIO_L_PD, BIT(7)),
+	PINCTRL_CONF_DESC(8, REG_GPIO_L_PD, BIT(8)),
+	PINCTRL_CONF_DESC(9, REG_GPIO_L_PD, BIT(9)),
+	PINCTRL_CONF_DESC(10, REG_GPIO_L_PD, BIT(10)),
+	PINCTRL_CONF_DESC(11, REG_GPIO_L_PD, BIT(11)),
+	PINCTRL_CONF_DESC(12, REG_GPIO_L_PD, BIT(12)),
+	PINCTRL_CONF_DESC(13, REG_GPIO_L_PD, BIT(13)),
+	PINCTRL_CONF_DESC(14, REG_GPIO_L_PD, BIT(14)),
+	PINCTRL_CONF_DESC(15, REG_GPIO_L_PD, BIT(15)),
+	PINCTRL_CONF_DESC(16, REG_GPIO_L_PD, BIT(16)),
+	PINCTRL_CONF_DESC(17, REG_GPIO_L_PD, BIT(17)),
+	PINCTRL_CONF_DESC(18, REG_GPIO_L_PD, BIT(18)),
+	PINCTRL_CONF_DESC(19, REG_GPIO_L_PD, BIT(19)),
+	PINCTRL_CONF_DESC(20, REG_GPIO_L_PD, BIT(20)),
+	PINCTRL_CONF_DESC(21, REG_GPIO_L_PD, BIT(21)),
+	PINCTRL_CONF_DESC(22, REG_GPIO_L_PD, BIT(22)),
+	PINCTRL_CONF_DESC(23, REG_GPIO_L_PD, BIT(23)),
+	PINCTRL_CONF_DESC(24, REG_GPIO_L_PD, BIT(24)),
+	PINCTRL_CONF_DESC(25, REG_GPIO_L_PD, BIT(25)),
+	PINCTRL_CONF_DESC(26, REG_GPIO_L_PD, BIT(26)),
+	PINCTRL_CONF_DESC(27, REG_GPIO_L_PD, BIT(27)),
+	PINCTRL_CONF_DESC(28, REG_I2C_SDA_PD, PCIE0_RESET_PD_MASK),
+	PINCTRL_CONF_DESC(29, REG_I2C_SDA_PD, PCIE1_RESET_PD_MASK),
+};
+
+static const struct airoha_pinctrl_conf en7523_pinctrl_drive_e2_conf[] = {
+	PINCTRL_CONF_DESC(0, REG_GPIO_L_E2, BIT(0)),
+	PINCTRL_CONF_DESC(1, REG_GPIO_L_E2, BIT(1)),
+	PINCTRL_CONF_DESC(2, REG_GPIO_L_E2, BIT(2)),
+	PINCTRL_CONF_DESC(3, REG_GPIO_L_E2, BIT(3)),
+	PINCTRL_CONF_DESC(4, REG_GPIO_L_E2, BIT(4)),
+	PINCTRL_CONF_DESC(5, REG_GPIO_L_E2, BIT(5)),
+	PINCTRL_CONF_DESC(6, REG_GPIO_L_E2, BIT(6)),
+	PINCTRL_CONF_DESC(7, REG_GPIO_L_E2, BIT(7)),
+	PINCTRL_CONF_DESC(8, REG_GPIO_L_E2, BIT(8)),
+	PINCTRL_CONF_DESC(9, REG_GPIO_L_E2, BIT(9)),
+	PINCTRL_CONF_DESC(10, REG_GPIO_L_E2, BIT(10)),
+	PINCTRL_CONF_DESC(11, REG_GPIO_L_E2, BIT(11)),
+	PINCTRL_CONF_DESC(12, REG_GPIO_L_E2, BIT(12)),
+	PINCTRL_CONF_DESC(13, REG_GPIO_L_E2, BIT(13)),
+	PINCTRL_CONF_DESC(14, REG_GPIO_L_E2, BIT(14)),
+	PINCTRL_CONF_DESC(15, REG_GPIO_L_E2, BIT(15)),
+	PINCTRL_CONF_DESC(16, REG_GPIO_L_E2, BIT(16)),
+	PINCTRL_CONF_DESC(17, REG_GPIO_L_E2, BIT(17)),
+	PINCTRL_CONF_DESC(18, REG_GPIO_L_E2, BIT(18)),
+	PINCTRL_CONF_DESC(19, REG_GPIO_L_E2, BIT(19)),
+	PINCTRL_CONF_DESC(20, REG_GPIO_L_E2, BIT(20)),
+	PINCTRL_CONF_DESC(21, REG_GPIO_L_E2, BIT(21)),
+	PINCTRL_CONF_DESC(22, REG_GPIO_L_E2, BIT(22)),
+	PINCTRL_CONF_DESC(23, REG_GPIO_L_E2, BIT(23)),
+	PINCTRL_CONF_DESC(24, REG_GPIO_L_E2, BIT(24)),
+	PINCTRL_CONF_DESC(25, REG_GPIO_L_E2, BIT(25)),
+	PINCTRL_CONF_DESC(26, REG_GPIO_L_E2, BIT(26)),
+	PINCTRL_CONF_DESC(27, REG_GPIO_L_E2, BIT(27)),
+	PINCTRL_CONF_DESC(28, REG_I2C_SDA_E2, PCIE0_RESET_E2_MASK),
+	PINCTRL_CONF_DESC(29, REG_I2C_SDA_E2, PCIE1_RESET_E2_MASK),
+};
+
+static const struct airoha_pinctrl_conf en7523_pinctrl_drive_e4_conf[] = {
+	PINCTRL_CONF_DESC(0, REG_GPIO_L_E4, BIT(0)),
+	PINCTRL_CONF_DESC(1, REG_GPIO_L_E4, BIT(1)),
+	PINCTRL_CONF_DESC(2, REG_GPIO_L_E4, BIT(2)),
+	PINCTRL_CONF_DESC(3, REG_GPIO_L_E4, BIT(3)),
+	PINCTRL_CONF_DESC(4, REG_GPIO_L_E4, BIT(4)),
+	PINCTRL_CONF_DESC(5, REG_GPIO_L_E4, BIT(5)),
+	PINCTRL_CONF_DESC(6, REG_GPIO_L_E4, BIT(6)),
+	PINCTRL_CONF_DESC(7, REG_GPIO_L_E4, BIT(7)),
+	PINCTRL_CONF_DESC(13, REG_GPIO_L_E4, BIT(0)),
+	PINCTRL_CONF_DESC(14, REG_GPIO_L_E4, BIT(1)),
+	PINCTRL_CONF_DESC(15, REG_GPIO_L_E4, BIT(2)),
+	PINCTRL_CONF_DESC(16, REG_GPIO_L_E4, BIT(3)),
+	PINCTRL_CONF_DESC(17, REG_GPIO_L_E4, BIT(4)),
+	PINCTRL_CONF_DESC(18, REG_GPIO_L_E4, BIT(5)),
+	PINCTRL_CONF_DESC(19, REG_GPIO_L_E4, BIT(6)),
+	PINCTRL_CONF_DESC(20, REG_GPIO_L_E4, BIT(7)),
+	PINCTRL_CONF_DESC(21, REG_GPIO_L_E4, BIT(8)),
+	PINCTRL_CONF_DESC(22, REG_GPIO_L_E4, BIT(9)),
+	PINCTRL_CONF_DESC(23, REG_GPIO_L_E4, BIT(10)),
+	PINCTRL_CONF_DESC(24, REG_GPIO_L_E4, BIT(11)),
+	PINCTRL_CONF_DESC(25, REG_GPIO_L_E4, BIT(12)),
+	PINCTRL_CONF_DESC(26, REG_GPIO_L_E4, BIT(13)),
+	PINCTRL_CONF_DESC(27, REG_GPIO_L_E4, BIT(14)),
+	PINCTRL_CONF_DESC(28, REG_I2C_SDA_E4, PCIE0_RESET_E4_MASK),
+	PINCTRL_CONF_DESC(29, REG_I2C_SDA_E4, PCIE1_RESET_E4_MASK),
+};
+
+static const struct airoha_pinctrl_conf en7523_pinctrl_pcie_rst_od_conf[] = {
+	PINCTRL_CONF_DESC(28, REG_PCIE_RESET_OD, PCIE0_RESET_OD_MASK),
+	PINCTRL_CONF_DESC(29, REG_PCIE_RESET_OD, PCIE1_RESET_OD_MASK),
+};
+
+static const struct airoha_pinctrl_match_data en7523_pinctrl_match_data = {
+	.gpio_offs = 0,
+	.gpio_pin_cnt = 58,
+	.pins = en7523_pinctrl_pins,
+	.num_pins = ARRAY_SIZE(en7523_pinctrl_pins),
+	.grps = en7523_pinctrl_groups,
+	.num_grps = ARRAY_SIZE(en7523_pinctrl_groups),
+	.funcs = en7523_pinctrl_funcs,
+	.num_funcs = ARRAY_SIZE(en7523_pinctrl_funcs),
+	.confs_info = {
+		[AIROHA_PINCTRL_CONFS_PULLUP] = {
+			.confs = en7523_pinctrl_pullup_conf,
+			.num_confs = ARRAY_SIZE(en7523_pinctrl_pullup_conf),
+		},
+		[AIROHA_PINCTRL_CONFS_PULLDOWN] = {
+			.confs = en7523_pinctrl_pulldown_conf,
+			.num_confs = ARRAY_SIZE(en7523_pinctrl_pulldown_conf),
+		},
+		[AIROHA_PINCTRL_CONFS_DRIVE_E2] = {
+			.confs = en7523_pinctrl_drive_e2_conf,
+			.num_confs = ARRAY_SIZE(en7523_pinctrl_drive_e2_conf),
+		},
+		[AIROHA_PINCTRL_CONFS_DRIVE_E4] = {
+			.confs = en7523_pinctrl_drive_e4_conf,
+			.num_confs = ARRAY_SIZE(en7523_pinctrl_drive_e4_conf),
+		},
+		[AIROHA_PINCTRL_CONFS_PCIE_RST_OD] = {
+			.confs = en7523_pinctrl_pcie_rst_od_conf,
+			.num_confs = ARRAY_SIZE(en7523_pinctrl_pcie_rst_od_conf),
+		},
+	},
+};
+
+static const struct udevice_id airoha_pinctrl_of_match[] = {
+	{ .compatible = "airoha,en7523-pinctrl",
+	  .data = (uintptr_t)&en7523_pinctrl_match_data },
+	{ /* sentinel */ }
+};
+
+U_BOOT_DRIVER(airoha_en7523_pinctrl) = {
+	.name = "airoha-en7523-pinctrl",
+	.id = UCLASS_PINCTRL,
+	.of_match = of_match_ptr(airoha_pinctrl_of_match),
+	.probe = airoha_pinctrl_probe,
+	.bind = airoha_pinctrl_bind,
+	.priv_auto = sizeof(struct airoha_pinctrl),
+	.ops = &airoha_pinctrl_ops,
+};
-- 
2.53.0

