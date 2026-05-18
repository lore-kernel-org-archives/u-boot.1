Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B56A4CD343F
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 23:52:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94D2F847C5;
	Tue, 19 May 2026 01:51:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="g6MHy012";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D08E6846E9; Tue, 19 May 2026 01:51:42 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D042084707
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 01:51:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gkA4AnlsCUp+Q2pnGQpAepnX4SJ0DwsIyFN5CAX/jZ8gAJzb9r34UxVHaiJrigHw8rKrpYGGh7wObzqgI+/5pTe30h3QUn6tgjiUGqD3qKuCsdgDAjITMkv2WQPAgB8K1NQ/4m8+A7HyRnOY429vWTACG2u3zvqsUFY3bPuRn9++PTvoLxQUWs3LjBENJwTm/960qB6V7jgKh1zinGQt0+jJldvRm1dzuTDwylMCw8RMXcjl1cLGKvQxfAQThkaF49AL0/GaM3tomRGJ8C6530CdYGWMwejWx9sK5nml7Y30j3zO58NtzqBF8WZkQcn6dNshUU8cgJhfzCUiod770g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzeRHmvv0MFfuEXREBtdscmTN9JmoMCeCMoVK5PvLzU=;
 b=Ui8yx0jc7xekXbjIlijlVK53++f1r3h1ZupLkVsIzAUg0B0qrK8f0laDbwF6shpdDXv0+630vAGKP2qDedzzaGE7ljTThqOJ7Y2fjBAmViCz+vMLAGcgSLfeSosSmDZHwNRPy8jxrdvedNIF9NJKA9yUMyBgkY7OzLZhGjdzYHLpMOH6pZw8YEjd/Unaj/OAi1lgYvcIGd3B/nwUHGyRlTK7ZwQC/g7Rc2mqMlCwg0pIMbByTzgpOoN2AI65HwmSkSagushoAplAv5OHH4EG+HGEmeETo/aIzySWOsNUiVmnHAv2aiUyBAbc/9Kda567qNBLTOLyicEsy11f0FodfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzeRHmvv0MFfuEXREBtdscmTN9JmoMCeCMoVK5PvLzU=;
 b=g6MHy012ElcdrDqcpjPCtGGTDo2z3w0zMR0aea9BshPGsWTeBaA38q+VI6I9rJ35SxDLV2f31zhQGM/uDd0gtX7zy+nImo9q5N3a67JoV3Gc/ebfAd0z9VNsRQ7xNlnK1eg0g7Utz97Uo9PQ2Ri6R4UL813Hf5yujGwJVuDwH3d8rUAx0DwiB+HpZH8Rb16qPEbqiZGAApm1WH3fh8H1nFapIIlx9f5g1W0Q+i94e28NM7Tr2XeJprl5VPg7Wco5V+2hH/f6KMYfGaCJNOhhBMjg20LNF0c/VdrWvKHhwhsn7ABLdzn1zgd0GQ0eUSO5i9+TyuarqjH1ZfuyuHzWWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DB9PR08MB7794.eurprd08.prod.outlook.com (2603:10a6:10:399::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Mon, 18 May
 2026 23:51:38 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0025.020; Mon, 18 May 2026
 23:51:38 +0000
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
Subject: [PATCH v8 08/12] pinctrl: airoha: add pin controller and gpio driver
 for AN7583 SoC
Date: Tue, 19 May 2026 02:51:11 +0300
Message-ID: <20260518235116.2664557-9-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 8e35b073-a987-4799-f776-08deb53866a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|52116014|22082099003|18002099003|56012099003|38350700014|921020|11063799003;
X-Microsoft-Antispam-Message-Info: TxgZTl2FT6zO5+ApuerY6rnnCTwi7I96nn98rLS1C9h101lF3fnYpHZ1fBiUksYX5/FuUmiSiECSuuiu2B9jwFdNvs5xxxoCoyKk0Yw/qQFOp7j6ePEtnnw/2QYcLj1EVr04dnb23q+uLn9ae5SQ41SOEU03sAkKu+0PeC74qYjvqJLhXAv6N2Gm+0rPJfIGlJnXIA9DMuQWdAgOFkiWgWebluHz2Rre7CrSAdL/xvPnydQuZHjyxrDL9eflxB56wvKrCSPXcwOthICqbbr8FXqKqCoU98fsJIwZ7qI5Q4efVeAcuSvOiaqmDY8njYBjI5FomhqPXyLCIkH3CZ1IedQJNtfHEbNNV2jOmz8veJnHla4qD4XrOFDxT4mS+lF1xcnus7wEKlHrdi1mLYIIkek8Dezj0J3Usw2ZhwJVHl2QGuZmAkbS0x8V/Zm/skphNajWnvPxuS9Nq90VioNMU8CyVTvuEx6WZGMngawjzaNUyyppz3T4Eff/x7VA6IzKi3CBI0Ykc/bVsnTDtqWwi97ljUYd2Qu/wLnAgyPx5nng5yh29Ie/yHMNFOI0sMHkIdExrVNmf4hbSPyQR7L7c3OZW2I64/mUx+xv91NXVYRGjR38NEOQhq7fCB3euWlmcFl4IV8KWgJs9Jqr+0UfHV7dYN5S/vepbBuV8rBNsWHxfCirZThBk83mXkrdRbuXn5fn+NeDQ79+fUsq+y3kvP7ayq0mTJDfmjnLozB1zkL+l8z2UZVsefcWzYjxNOk/46EzjAzKOaNuj+JpNgHlkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(22082099003)(18002099003)(56012099003)(38350700014)(921020)(11063799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zV0F6vhAF/Sf3THwtkHSBXLrCmjayCgmBlgxl3jf8B7WviAum0TB6CIbU1Ac?=
 =?us-ascii?Q?w2Fv3mZ11UDQlpQX+e6F4AKIe/XfwPHW4Yr7rc9jHSz2QfO4LPh2rXU7EY0g?=
 =?us-ascii?Q?WLlONv6Hual3K2t5KZNDIMzfb31IEPGCKUM2OLQ2dOmQAsUi06eea3Jg5Z5Z?=
 =?us-ascii?Q?InOhTFTct+XUTroSC6vV7gISh518PRoenaWCnl01FiZuO9wrLeiFMHQ0YDdf?=
 =?us-ascii?Q?56o/K1QZdvSeyEJoz1BhwA+kJyDIInifuDm9d0ZU94zsfcl43fq/vy2cO4uX?=
 =?us-ascii?Q?j+5lVZOaGUzJZCPueWqheu/qGfu4MbEf8lydIr3Yu1M9r3sC4t/nBLE7VCUv?=
 =?us-ascii?Q?wrh9iHhOFrwtU385nhbZvu3ZF8JW+Vmp80W8vofrzUxhq/uWGyx609NfN2jE?=
 =?us-ascii?Q?mDO9ljzoKRCa0JTNHrQHlS+tOaPZBUz7S+KFXzIea9hJd+5gkl47VGf8F7Rb?=
 =?us-ascii?Q?ZAMfiupisQFDSUD52XY5cQTMxX+DntDa5lGwM6cRZIza8reYDVO2RbmUwbRF?=
 =?us-ascii?Q?cxM0N4an1AMFO1GWFUT4hXQnYocJTwabgA1H35kylbhbttTLVsk43ejXv/8v?=
 =?us-ascii?Q?wL2xlqdvz4dTDVfBYB+ZzdrypyZ6tG6Bd0A6AsdP3+BaVChbS/lyDUE8Wbvs?=
 =?us-ascii?Q?nFnJqGShxABVkgnVOtnKtAgy7GiosiEoD3Mf5xVUARjPeqgmuIUBxlFn7/7C?=
 =?us-ascii?Q?d/IXWPkkHO+CIJiQLrQNd1CLxMljNSxmewHrRQxpIUxF2Tr5jXp3tbiPk1/q?=
 =?us-ascii?Q?OtGCXyBdXhBCgvJUSk0WiYTBeBmhV4T6kP3B7rqxS8iQwADKr83E2q8eMDZr?=
 =?us-ascii?Q?ZLkCM2HIXFMwn+mupIdjxctgFXEHjNS2zZMski/iMRk5dcmFw4n3xZ/peGQT?=
 =?us-ascii?Q?XJ+wP41M3Bg/juKHa5AJkGuX2j8pwbV0SEOdAM1lMe7KNBgRSDgvbNn7f6zi?=
 =?us-ascii?Q?Tfama+YQeoRwBurOXAjrrjPu49pL6HnMbflMocEW48KfWbPhSnGGWsPCuHFC?=
 =?us-ascii?Q?EkOAzQwohj5orJJvBzebDsXCjW6X8LNwaelt4n8GveqkIMnPiTI1b0JWijJF?=
 =?us-ascii?Q?IcTDqvIVmXPlenz5fj6DhtO5Qd7/A89qaoGAevIRBZ+/pI1nQT/MSmRcXbCS?=
 =?us-ascii?Q?iizw3kXNQx+tRwuDW1DkFtnDzZZybLYj+JyHdln5fa+3nn+fT/IC+6wZ4ZJ1?=
 =?us-ascii?Q?WlpMwpUvPU7uWx+43hR7G1Yf7cX8tcyx/ceMQGvOLndgS11Qdu/0IPIAY5Vs?=
 =?us-ascii?Q?fQjz/GLOk0kI3HvU0B2j9+7GAVpmJjDG/rvDdKWMju75OP8HNodH7ILjzaDc?=
 =?us-ascii?Q?roF31rWX93EAvmdQGJRs4diMRhQ9N9+APdT46/gOb2REITFKBDfkgN2dE9AM?=
 =?us-ascii?Q?zJx3wZ6fR2IcE/RpqoMSwc5NloUdDv04wv2fq6pO+XiHyO4oPC+wJXsf+X4+?=
 =?us-ascii?Q?Tiz4TPwfE2xscPnMt+8IdAAzW0XxJ4sajqkoDwVaFvaPKWiUJTVvVO0o3jK8?=
 =?us-ascii?Q?eUcQkykkhs2N8gYmP9RHKYMfzHyZ5P0ENs8bdeyhiIFIA564D+jtlHU62Lqh?=
 =?us-ascii?Q?WYcE6GEU5NLTJ5FljdcTC/Z+ZSwJ4CePa7wYxmhxd1goCJmExUMWKghvn4oF?=
 =?us-ascii?Q?qojTAqIhSi9P8Srvawkw9N776nu9yPp7ipWwin1rMIerCcgozzFblw/lttqr?=
 =?us-ascii?Q?4jFFPJBrA8ncGKVhofQjJdblwjrl0YGcpxI5guqXv98yN1dLeQrVKFJpM6id?=
 =?us-ascii?Q?7ecY/A5/IFLC32nrTE2rLJYhXlpMm1s=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e35b073-a987-4799-f776-08deb53866a2
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 23:51:38.0505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fFqJP1h0WxD0wkcVY+aRPibX1tV1cdhYqH4WysvsmSs51pYKLML099WJyoejjSKacsvw6Ex9GpIjFHqjtl7DgExm4EzQmFn5u3d+RbVbyeI=
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

This patch adds U-Boot pin controller and gpio driver for Airoha AN7583 SoC.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
 drivers/pinctrl/airoha/Kconfig          |   5 +
 drivers/pinctrl/airoha/Makefile         |   1 +
 drivers/pinctrl/airoha/pinctrl-an7583.c | 980 ++++++++++++++++++++++++
 3 files changed, 986 insertions(+)
 create mode 100644 drivers/pinctrl/airoha/pinctrl-an7583.c

diff --git a/drivers/pinctrl/airoha/Kconfig b/drivers/pinctrl/airoha/Kconfig
index ae387f70b22..5d3e29c8fd6 100644
--- a/drivers/pinctrl/airoha/Kconfig
+++ b/drivers/pinctrl/airoha/Kconfig
@@ -14,3 +14,8 @@ config PINCTRL_AIROHA_AN7581
 	bool "Airoha AN7581 pin controller and gpio driver"
 	depends on TARGET_AN7581
 	select PINCTRL_AIROHA
+
+config PINCTRL_AIROHA_AN7583
+	bool "Airoha AN7583 pin controller and gpio driver"
+	depends on TARGET_AN7583
+	select PINCTRL_AIROHA
diff --git a/drivers/pinctrl/airoha/Makefile b/drivers/pinctrl/airoha/Makefile
index 909bd9a04d9..c8c99dd22f8 100644
--- a/drivers/pinctrl/airoha/Makefile
+++ b/drivers/pinctrl/airoha/Makefile
@@ -3,3 +3,4 @@
 obj-$(CONFIG_PINCTRL_AIROHA)		+= pinctrl-airoha.o
 
 obj-$(CONFIG_PINCTRL_AIROHA_AN7581)	+= pinctrl-an7581.o
+obj-$(CONFIG_PINCTRL_AIROHA_AN7583)	+= pinctrl-an7583.o
diff --git a/drivers/pinctrl/airoha/pinctrl-an7583.c b/drivers/pinctrl/airoha/pinctrl-an7583.c
new file mode 100644
index 00000000000..2942fe29d80
--- /dev/null
+++ b/drivers/pinctrl/airoha/pinctrl-an7583.c
@@ -0,0 +1,980 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Author: Lorenzo Bianconi <lorenzo@kernel.org>
+ * Author: Benjamin Larsson <benjamin.larsson@genexis.eu>
+ * Author: Markus Gothe <markus.gothe@genexis.eu>
+ */
+#include "airoha-common.h"
+
+static const int an7583_pon_pins[] = { 15, 16, 17, 18, 19, 20 };
+static const int an7583_pon_tod_1pps_pins[] = { 32 };
+static const int an7583_gsw_tod_1pps_pins[] = { 32 };
+static const int an7583_sipo_pins[] = { 34, 35 };
+static const int an7583_sipo_rclk_pins[] = { 34, 35, 33 };
+static const int an7583_mdio_pins[] = { 43, 44 };
+static const int an7583_uart2_pins[] = { 34, 35 };
+static const int an7583_uart2_cts_rts_pins[] = { 32, 33 };
+static const int an7583_hsuart_pins[] = { 30, 31 };
+static const int an7583_hsuart_cts_rts_pins[] = { 28, 29 };
+static const int an7583_npu_uart_pins[] = { 7, 8 };
+static const int an7583_uart4_pins[] = { 7, 8 };
+static const int an7583_uart5_pins[] = { 23, 24 };
+static const int an7583_i2c0_pins[] = { 41, 42 };
+static const int an7583_i2c1_pins[] = { 43, 44 };
+static const int an7583_jtag_udi_pins[] = { 23, 24, 22, 25, 26 };
+static const int an7583_jtag_dfd_pins[] = { 23, 24, 22, 25, 26 };
+static const int an7583_pcm1_pins[] = { 10, 11, 12, 13, 14 };
+static const int an7583_pcm2_pins[] = { 28, 29, 30, 31, 24 };
+static const int an7583_spi_pins[] = { 28, 29, 30, 31 };
+static const int an7583_spi_quad_pins[] = { 25, 26 };
+static const int an7583_spi_cs1_pins[] = { 27 };
+static const int an7583_pcm_spi_pins[] = { 28, 29, 30, 31, 10, 11, 12, 13 };
+static const int an7583_pcm_spi_rst_pins[] = { 14 };
+static const int an7583_pcm_spi_cs1_pins[] = { 24 };
+static const int an7583_emmc_pins[] = {
+	7, 8, 9, 22, 23, 24, 25, 26, 45, 46, 47
+};
+static const int an7583_pnand_pins[] = {
+	7, 8, 9, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 45, 46, 47, 48
+};
+static const int an7583_gpio0_pins[] = { 2 };
+static const int an7583_gpio1_pins[] = { 3 };
+static const int an7583_gpio2_pins[] = { 4 };
+static const int an7583_gpio3_pins[] = { 5 };
+static const int an7583_gpio4_pins[] = { 6 };
+static const int an7583_gpio5_pins[] = { 7 };
+static const int an7583_gpio6_pins[] = { 8 };
+static const int an7583_gpio7_pins[] = { 9 };
+static const int an7583_gpio8_pins[] = { 10 };
+static const int an7583_gpio9_pins[] = { 11 };
+static const int an7583_gpio10_pins[] = { 12 };
+static const int an7583_gpio11_pins[] = { 13 };
+static const int an7583_gpio12_pins[] = { 14 };
+static const int an7583_gpio13_pins[] = { 15 };
+static const int an7583_gpio14_pins[] = { 16 };
+static const int an7583_gpio15_pins[] = { 17 };
+static const int an7583_gpio16_pins[] = { 18 };
+static const int an7583_gpio17_pins[] = { 19 };
+static const int an7583_gpio18_pins[] = { 20 };
+static const int an7583_gpio19_pins[] = { 21 };
+static const int an7583_gpio20_pins[] = { 22 };
+static const int an7583_gpio21_pins[] = { 23 };
+static const int an7583_gpio22_pins[] = { 24 };
+static const int an7583_gpio23_pins[] = { 25 };
+static const int an7583_gpio24_pins[] = { 26 };
+static const int an7583_gpio25_pins[] = { 27 };
+static const int an7583_gpio26_pins[] = { 28 };
+static const int an7583_gpio27_pins[] = { 29 };
+static const int an7583_gpio28_pins[] = { 30 };
+static const int an7583_gpio29_pins[] = { 31 };
+static const int an7583_gpio30_pins[] = { 32 };
+static const int an7583_gpio31_pins[] = { 33 };
+static const int an7583_gpio32_pins[] = { 34 };
+static const int an7583_gpio33_pins[] = { 35 };
+static const int an7583_gpio34_pins[] = { 36 };
+static const int an7583_gpio35_pins[] = { 37 };
+static const int an7583_gpio36_pins[] = { 38 };
+static const int an7583_gpio37_pins[] = { 39 };
+static const int an7583_gpio38_pins[] = { 40 };
+static const int an7583_gpio39_pins[] = { 41 };
+static const int an7583_gpio40_pins[] = { 42 };
+static const int an7583_gpio41_pins[] = { 43 };
+static const int an7583_gpio42_pins[] = { 44 };
+static const int an7583_gpio43_pins[] = { 45 };
+static const int an7583_gpio44_pins[] = { 46 };
+static const int an7583_gpio45_pins[] = { 47 };
+static const int an7583_gpio46_pins[] = { 48 };
+static const int an7583_gpio47_pins[] = { 49 };
+static const int an7583_gpio48_pins[] = { 50 };
+static const int an7583_pcie_reset0_pins[] = { 51 };
+static const int an7583_pcie_reset1_pins[] = { 52 };
+
+static struct pinctrl_pin_desc an7583_pinctrl_pins[] = {
+	PINCTRL_PIN(2, "gpio0"),
+	PINCTRL_PIN(3, "gpio1"),
+	PINCTRL_PIN(4, "gpio2"),
+	PINCTRL_PIN(5, "gpio3"),
+	PINCTRL_PIN(6, "gpio4"),
+	PINCTRL_PIN(7, "gpio5"),
+	PINCTRL_PIN(8, "gpio6"),
+	PINCTRL_PIN(9, "gpio7"),
+	PINCTRL_PIN(10, "gpio8"),
+	PINCTRL_PIN(11, "gpio9"),
+	PINCTRL_PIN(12, "gpio10"),
+	PINCTRL_PIN(13, "gpio11"),
+	PINCTRL_PIN(14, "gpio12"),
+	PINCTRL_PIN(15, "gpio13"),
+	PINCTRL_PIN(16, "gpio14"),
+	PINCTRL_PIN(17, "gpio15"),
+	PINCTRL_PIN(18, "gpio16"),
+	PINCTRL_PIN(19, "gpio17"),
+	PINCTRL_PIN(20, "gpio18"),
+	PINCTRL_PIN(21, "gpio19"),
+	PINCTRL_PIN(22, "gpio20"),
+	PINCTRL_PIN(23, "gpio21"),
+	PINCTRL_PIN(24, "gpio22"),
+	PINCTRL_PIN(25, "gpio23"),
+	PINCTRL_PIN(26, "gpio24"),
+	PINCTRL_PIN(27, "gpio25"),
+	PINCTRL_PIN(28, "gpio26"),
+	PINCTRL_PIN(29, "gpio27"),
+	PINCTRL_PIN(30, "gpio28"),
+	PINCTRL_PIN(31, "gpio29"),
+	PINCTRL_PIN(32, "gpio30"),
+	PINCTRL_PIN(33, "gpio31"),
+	PINCTRL_PIN(34, "gpio32"),
+	PINCTRL_PIN(35, "gpio33"),
+	PINCTRL_PIN(36, "gpio34"),
+	PINCTRL_PIN(37, "gpio35"),
+	PINCTRL_PIN(38, "gpio36"),
+	PINCTRL_PIN(39, "gpio37"),
+	PINCTRL_PIN(40, "gpio38"),
+	PINCTRL_PIN(41, "i2c0_scl"),
+	PINCTRL_PIN(42, "i2c0_sda"),
+	PINCTRL_PIN(43, "i2c1_scl"),
+	PINCTRL_PIN(44, "i2c1_sda"),
+	PINCTRL_PIN(45, "spi_clk"),
+	PINCTRL_PIN(46, "spi_cs"),
+	PINCTRL_PIN(47, "spi_mosi"),
+	PINCTRL_PIN(48, "spi_miso"),
+	PINCTRL_PIN(49, "uart_txd"),
+	PINCTRL_PIN(50, "uart_rxd"),
+	PINCTRL_PIN(51, "pcie_reset0"),
+	PINCTRL_PIN(52, "pcie_reset1"),
+	PINCTRL_PIN(53, "mdc_0"),
+	PINCTRL_PIN(54, "mdio_0"),
+};
+
+static const char *const pon_groups[] = { "pon" };
+static const char *const tod_1pps_groups[] = { "pon_tod_1pps", "gsw_tod_1pps" };
+static const char *const sipo_groups[] = { "sipo", "sipo_rclk" };
+
+static const char *const uart_groups[] = {
+	"uart2", "uart2_cts_rts", "hsuart", "hsuart_cts_rts", "uart4", "uart5"
+};
+static const char *const i2c_groups[] = { "i2c1" };
+static const char *const jtag_groups[] = { "jtag_udi", "jtag_dfd" };
+static const char *const pcm_groups[] = { "pcm1", "pcm2" };
+static const char *const spi_groups[] = { "spi_quad", "spi_cs1" };
+
+static const char *const emmc_groups[] = { "emmc" };
+static const char *const pnand_groups[] = { "pnand" };
+static const char *const pwm_groups[] = {
+	"gpio0",  "gpio1",  "gpio2",  "gpio3",  "gpio4",  "gpio5",  "gpio6",
+	"gpio7",  "gpio8",  "gpio9",  "gpio10", "gpio11", "gpio12", "gpio13",
+	"gpio14", "gpio15", "gpio16", "gpio17", "gpio18", "gpio19", "gpio20",
+	"gpio21", "gpio22", "gpio23", "gpio24", "gpio25", "gpio26", "gpio27",
+	"gpio28", "gpio29", "gpio30", "gpio31", "gpio36", "gpio37", "gpio38",
+	"gpio39", "gpio40", "gpio41", "gpio42", "gpio43", "gpio44", "gpio45",
+	"gpio46", "gpio47"
+};
+
+static const char *const an7583_mdio_groups[] = { "mdio" };
+static const char *const an7583_pcm_spi_groups[] = {
+	"pcm_spi",     "pcm_spi_int", "pcm_spi_rst", "pcm_spi_cs1",
+	"pcm_spi_cs2", "pcm_spi_cs3", "pcm_spi_cs4"
+};
+static const char *const an7583_pcie_reset_groups[] = {
+	"pcie_reset0", "pcie_reset1"
+};
+static const char *const an7583_phy1_led0_groups[] = {
+	"gpio1", "gpio2", "gpio3", "gpio4"
+};
+static const char *const an7583_phy2_led0_groups[] = {
+	"gpio1", "gpio2", "gpio3", "gpio4"
+};
+static const char *const an7583_phy3_led0_groups[] = {
+	"gpio1", "gpio2", "gpio3", "gpio4"
+};
+static const char *const an7583_phy4_led0_groups[] = {
+	"gpio1", "gpio2", "gpio3", "gpio4"
+};
+static const char *const an7583_phy1_led1_groups[] = {
+	"gpio8", "gpio9", "gpio10", "gpio11"
+};
+static const char *const an7583_phy2_led1_groups[] = {
+	"gpio8", "gpio9", "gpio10", "gpio11"
+};
+static const char *const an7583_phy3_led1_groups[] = {
+	"gpio8", "gpio9", "gpio10", "gpio11"
+};
+static const char *const an7583_phy4_led1_groups[] = {
+	"gpio8", "gpio9", "gpio10", "gpio11"
+};
+
+static const struct airoha_pinctrl_func_group pon_func_group[] = {
+	{
+		.name = "pon",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_PON_MODE,
+			       GPIO_PON_MODE_MASK, GPIO_PON_MODE_MASK },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group tod_1pps_func_group[] = {
+	{
+		.name = "pon_tod_1pps",
+		.regmap[0] = { AIROHA_FUNC_MUX, AN7581_REG_GPIO_2ND_I2C_MODE,
+			       PON_TOD_1PPS_MODE_MASK, PON_TOD_1PPS_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "gsw_tod_1pps",
+		.regmap[0] = { AIROHA_FUNC_MUX, AN7581_REG_GPIO_2ND_I2C_MODE,
+			       GSW_TOD_1PPS_MODE_MASK, GSW_TOD_1PPS_MODE_MASK },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group sipo_func_group[] = {
+	{
+		.name = "sipo",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_PON_MODE,
+			       GPIO_SIPO_MODE_MASK | SIPO_RCLK_MODE_MASK,
+			       GPIO_SIPO_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "sipo_rclk",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_PON_MODE,
+			       GPIO_SIPO_MODE_MASK | SIPO_RCLK_MODE_MASK,
+			       GPIO_SIPO_MODE_MASK | SIPO_RCLK_MODE_MASK },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group uart_func_group[] = {
+	{
+		.name = "uart2",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_PON_MODE,
+			       GPIO_UART2_MODE_MASK, GPIO_UART2_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "uart2_cts_rts",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_PON_MODE,
+			       GPIO_UART2_MODE_MASK |
+				       GPIO_UART2_CTS_RTS_MODE_MASK,
+			       GPIO_UART2_MODE_MASK |
+				       GPIO_UART2_CTS_RTS_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "hsuart",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_PON_MODE,
+			       GPIO_HSUART_MODE_MASK |
+				       GPIO_HSUART_CTS_RTS_MODE_MASK,
+			       GPIO_HSUART_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "hsuart_cts_rts",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_PON_MODE,
+			       GPIO_HSUART_MODE_MASK |
+				       GPIO_HSUART_CTS_RTS_MODE_MASK,
+			       GPIO_HSUART_MODE_MASK |
+				       GPIO_HSUART_CTS_RTS_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "uart4",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_PON_MODE,
+			       GPIO_UART4_MODE_MASK, GPIO_UART4_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "uart5",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_PON_MODE,
+			       GPIO_UART5_MODE_MASK, GPIO_UART5_MODE_MASK },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group i2c_func_group[] = {
+	{
+		.name = "i2c1",
+		.regmap[0] = { AIROHA_FUNC_MUX, AN7581_REG_GPIO_2ND_I2C_MODE,
+			       GPIO_2ND_I2C_MODE_MASK, GPIO_2ND_I2C_MODE_MASK },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group jtag_func_group[] = {
+	{
+		.name = "jtag_udi",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_NPU_UART_EN,
+			       JTAG_UDI_EN_MASK, JTAG_UDI_EN_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "jtag_dfd",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_NPU_UART_EN,
+			       JTAG_DFD_EN_MASK, JTAG_DFD_EN_MASK },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group pcm_func_group[] = {
+	{
+		.name = "pcm1",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_SPI_CS1_MODE,
+			       GPIO_PCM1_MODE_MASK, GPIO_PCM1_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "pcm2",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_SPI_CS1_MODE,
+			       GPIO_PCM2_MODE_MASK, GPIO_PCM2_MODE_MASK },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group spi_func_group[] = {
+	{
+		.name = "spi_quad",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_SPI_CS1_MODE,
+			       GPIO_SPI_QUAD_MODE_MASK,
+			       GPIO_SPI_QUAD_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "spi_cs1",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_SPI_CS1_MODE,
+			       GPIO_SPI_CS1_MODE_MASK, GPIO_SPI_CS1_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "spi_cs2",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_SPI_CS1_MODE,
+			       GPIO_SPI_CS2_MODE_MASK, GPIO_SPI_CS2_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "spi_cs3",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_SPI_CS1_MODE,
+			       GPIO_SPI_CS3_MODE_MASK, GPIO_SPI_CS3_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "spi_cs4",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_SPI_CS1_MODE,
+			       GPIO_SPI_CS4_MODE_MASK, GPIO_SPI_CS4_MODE_MASK },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group emmc_func_group[] = {
+	{
+		.name = "emmc",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_PON_MODE,
+			       GPIO_EMMC_MODE_MASK, GPIO_EMMC_MODE_MASK },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group pnand_func_group[] = {
+	{
+		.name = "pnand",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_PON_MODE,
+			       GPIO_PARALLEL_NAND_MODE_MASK,
+			       GPIO_PARALLEL_NAND_MODE_MASK },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group pwm_func_group[] = {
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
+	AIROHA_PINCTRL_PWM_EXT("gpio30", GPIO30_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio31", GPIO31_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio36", GPIO36_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio37", GPIO37_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio38", GPIO38_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio39", GPIO39_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio40", GPIO40_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio41", GPIO41_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio42", GPIO42_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio43", GPIO43_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio44", GPIO44_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio45", GPIO45_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio46", GPIO46_FLASH_MODE_CFG),
+	AIROHA_PINCTRL_PWM_EXT("gpio47", GPIO47_FLASH_MODE_CFG),
+};
+
+static const struct airoha_pinctrl_func_group an7583_mdio_func_group[] = {
+	{
+		.name = "mdio",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_PON_MODE,
+			       GPIO_SGMII_MDIO_MODE_MASK,
+			       GPIO_SGMII_MDIO_MODE_MASK },
+		.regmap[1] = { AIROHA_FUNC_MUX, REG_GPIO_SPI_CS1_MODE,
+			       GPIO_MDC_IO_MASTER_MODE_MODE,
+			       GPIO_MDC_IO_MASTER_MODE_MODE },
+		.regmap_size = 2,
+	},
+};
+
+static const struct airoha_pinctrl_func_group an7583_pcm_spi_func_group[] = {
+	{
+		.name = "pcm_spi",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_SPI_CS1_MODE,
+			       GPIO_PCM_SPI_MODE_MASK, GPIO_PCM_SPI_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "pcm_spi_int",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_SPI_CS1_MODE,
+			       GPIO_PCM_INT_MODE_MASK, GPIO_PCM_INT_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "pcm_spi_rst",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_SPI_CS1_MODE,
+			       GPIO_PCM_RESET_MODE_MASK,
+			       GPIO_PCM_RESET_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "pcm_spi_cs1",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_SPI_CS1_MODE,
+			       GPIO_PCM_SPI_CS1_MODE_MASK,
+			       GPIO_PCM_SPI_CS1_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "pcm_spi_cs2",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_SPI_CS1_MODE,
+			       AN7583_GPIO_PCM_SPI_CS2_MODE_MASK,
+			       AN7583_GPIO_PCM_SPI_CS2_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "pcm_spi_cs3",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_SPI_CS1_MODE,
+			       GPIO_PCM_SPI_CS3_MODE_MASK,
+			       GPIO_PCM_SPI_CS3_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "pcm_spi_cs4",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_SPI_CS1_MODE,
+			       GPIO_PCM_SPI_CS4_MODE_MASK,
+			       GPIO_PCM_SPI_CS4_MODE_MASK },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group an7583_pcie_reset_func_group[] = {
+	{
+		.name = "pcie_reset0",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_PON_MODE,
+			       GPIO_PCIE_RESET0_MASK, GPIO_PCIE_RESET0_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "pcie_reset1",
+		.regmap[0] = { AIROHA_FUNC_MUX, REG_GPIO_PON_MODE,
+			       GPIO_PCIE_RESET1_MASK, GPIO_PCIE_RESET1_MASK },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group an7583_phy1_led0_func_group[] = {
+	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio1", GPIO_LAN0_LED0_MODE_MASK,
+				LAN0_LED_MAPPING_MASK, LAN0_PHY_LED_MAP(0)),
+	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio2", GPIO_LAN1_LED0_MODE_MASK,
+				LAN1_LED_MAPPING_MASK, LAN1_PHY_LED_MAP(0)),
+	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio3", GPIO_LAN2_LED0_MODE_MASK,
+				LAN2_LED_MAPPING_MASK, LAN2_PHY_LED_MAP(0)),
+	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio4", GPIO_LAN3_LED0_MODE_MASK,
+				LAN3_LED_MAPPING_MASK, LAN3_PHY_LED_MAP(0)),
+};
+
+static const struct airoha_pinctrl_func_group an7583_phy2_led0_func_group[] = {
+	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio1", GPIO_LAN0_LED0_MODE_MASK,
+				LAN0_LED_MAPPING_MASK, LAN0_PHY_LED_MAP(1)),
+	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio2", GPIO_LAN1_LED0_MODE_MASK,
+				LAN1_LED_MAPPING_MASK, LAN1_PHY_LED_MAP(1)),
+	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio3", GPIO_LAN2_LED0_MODE_MASK,
+				LAN2_LED_MAPPING_MASK, LAN2_PHY_LED_MAP(1)),
+	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio4", GPIO_LAN3_LED0_MODE_MASK,
+				LAN3_LED_MAPPING_MASK, LAN3_PHY_LED_MAP(1)),
+};
+
+static const struct airoha_pinctrl_func_group an7583_phy3_led0_func_group[] = {
+	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio1", GPIO_LAN0_LED0_MODE_MASK,
+				LAN0_LED_MAPPING_MASK, LAN0_PHY_LED_MAP(2)),
+	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio2", GPIO_LAN1_LED0_MODE_MASK,
+				LAN1_LED_MAPPING_MASK, LAN1_PHY_LED_MAP(2)),
+	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio3", GPIO_LAN2_LED0_MODE_MASK,
+				LAN2_LED_MAPPING_MASK, LAN2_PHY_LED_MAP(2)),
+	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio4", GPIO_LAN3_LED0_MODE_MASK,
+				LAN3_LED_MAPPING_MASK, LAN3_PHY_LED_MAP(2)),
+};
+
+static const struct airoha_pinctrl_func_group an7583_phy4_led0_func_group[] = {
+	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio1", GPIO_LAN0_LED0_MODE_MASK,
+				LAN0_LED_MAPPING_MASK, LAN0_PHY_LED_MAP(3)),
+	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio2", GPIO_LAN1_LED0_MODE_MASK,
+				LAN1_LED_MAPPING_MASK, LAN1_PHY_LED_MAP(3)),
+	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio3", GPIO_LAN2_LED0_MODE_MASK,
+				LAN2_LED_MAPPING_MASK, LAN2_PHY_LED_MAP(3)),
+	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio4", GPIO_LAN3_LED0_MODE_MASK,
+				LAN3_LED_MAPPING_MASK, LAN3_PHY_LED_MAP(3)),
+};
+
+static const struct airoha_pinctrl_func_group an7583_phy1_led1_func_group[] = {
+	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio8", GPIO_LAN0_LED1_MODE_MASK,
+				LAN0_LED_MAPPING_MASK, LAN0_PHY_LED_MAP(0)),
+	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio9", GPIO_LAN1_LED1_MODE_MASK,
+				LAN1_LED_MAPPING_MASK, LAN1_PHY_LED_MAP(0)),
+	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio10", GPIO_LAN2_LED1_MODE_MASK,
+				LAN2_LED_MAPPING_MASK, LAN2_PHY_LED_MAP(0)),
+	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio1", GPIO_LAN3_LED1_MODE_MASK,
+				LAN3_LED_MAPPING_MASK, LAN3_PHY_LED_MAP(0)),
+};
+
+static const struct airoha_pinctrl_func_group an7583_phy2_led1_func_group[] = {
+	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio8", GPIO_LAN0_LED1_MODE_MASK,
+				LAN0_LED_MAPPING_MASK, LAN0_PHY_LED_MAP(1)),
+	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio9", GPIO_LAN1_LED1_MODE_MASK,
+				LAN1_LED_MAPPING_MASK, LAN1_PHY_LED_MAP(1)),
+	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio10", GPIO_LAN2_LED1_MODE_MASK,
+				LAN2_LED_MAPPING_MASK, LAN2_PHY_LED_MAP(1)),
+	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio11", GPIO_LAN3_LED1_MODE_MASK,
+				LAN3_LED_MAPPING_MASK, LAN3_PHY_LED_MAP(1)),
+};
+
+static const struct airoha_pinctrl_func_group an7583_phy3_led1_func_group[] = {
+	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio8", GPIO_LAN0_LED1_MODE_MASK,
+				LAN0_LED_MAPPING_MASK, LAN0_PHY_LED_MAP(2)),
+	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio9", GPIO_LAN1_LED1_MODE_MASK,
+				LAN1_LED_MAPPING_MASK, LAN1_PHY_LED_MAP(2)),
+	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio10", GPIO_LAN2_LED1_MODE_MASK,
+				LAN2_LED_MAPPING_MASK, LAN2_PHY_LED_MAP(2)),
+	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio11", GPIO_LAN3_LED1_MODE_MASK,
+				LAN3_LED_MAPPING_MASK, LAN3_PHY_LED_MAP(2)),
+};
+
+static const struct airoha_pinctrl_func_group an7583_phy4_led1_func_group[] = {
+	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio8", GPIO_LAN0_LED1_MODE_MASK,
+				LAN0_LED_MAPPING_MASK, LAN0_PHY_LED_MAP(3)),
+	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio9", GPIO_LAN1_LED1_MODE_MASK,
+				LAN1_LED_MAPPING_MASK, LAN1_PHY_LED_MAP(3)),
+	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio10", GPIO_LAN2_LED1_MODE_MASK,
+				LAN2_LED_MAPPING_MASK, LAN2_PHY_LED_MAP(3)),
+	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio11", GPIO_LAN3_LED1_MODE_MASK,
+				LAN3_LED_MAPPING_MASK, LAN3_PHY_LED_MAP(3)),
+};
+
+static const struct pingroup an7583_pinctrl_groups[] = {
+	PINCTRL_PIN_GROUP("pon", an7583_pon),
+	PINCTRL_PIN_GROUP("pon_tod_1pps", an7583_pon_tod_1pps),
+	PINCTRL_PIN_GROUP("gsw_tod_1pps", an7583_gsw_tod_1pps),
+	PINCTRL_PIN_GROUP("sipo", an7583_sipo),
+	PINCTRL_PIN_GROUP("sipo_rclk", an7583_sipo_rclk),
+	PINCTRL_PIN_GROUP("mdio", an7583_mdio),
+	PINCTRL_PIN_GROUP("uart2", an7583_uart2),
+	PINCTRL_PIN_GROUP("uart2_cts_rts", an7583_uart2_cts_rts),
+	PINCTRL_PIN_GROUP("hsuart", an7583_hsuart),
+	PINCTRL_PIN_GROUP("hsuart_cts_rts", an7583_hsuart_cts_rts),
+	PINCTRL_PIN_GROUP("npu_uart", an7583_npu_uart),
+	PINCTRL_PIN_GROUP("uart4", an7583_uart4),
+	PINCTRL_PIN_GROUP("uart5", an7583_uart5),
+	PINCTRL_PIN_GROUP("i2c0", an7583_i2c0),
+	PINCTRL_PIN_GROUP("i2c1", an7583_i2c1),
+	PINCTRL_PIN_GROUP("jtag_udi", an7583_jtag_udi),
+	PINCTRL_PIN_GROUP("jtag_dfd", an7583_jtag_dfd),
+	PINCTRL_PIN_GROUP("pcm1", an7583_pcm1),
+	PINCTRL_PIN_GROUP("pcm2", an7583_pcm2),
+	PINCTRL_PIN_GROUP("spi", an7583_spi),
+	PINCTRL_PIN_GROUP("spi_quad", an7583_spi_quad),
+	PINCTRL_PIN_GROUP("spi_cs1", an7583_spi_cs1),
+	PINCTRL_PIN_GROUP("pcm_spi", an7583_pcm_spi),
+	PINCTRL_PIN_GROUP("pcm_spi_rst", an7583_pcm_spi_rst),
+	PINCTRL_PIN_GROUP("pcm_spi_cs1", an7583_pcm_spi_cs1),
+	PINCTRL_PIN_GROUP("emmc", an7583_emmc),
+	PINCTRL_PIN_GROUP("pnand", an7583_pnand),
+	PINCTRL_PIN_GROUP("gpio0", an7583_gpio0),
+	PINCTRL_PIN_GROUP("gpio1", an7583_gpio1),
+	PINCTRL_PIN_GROUP("gpio2", an7583_gpio2),
+	PINCTRL_PIN_GROUP("gpio3", an7583_gpio3),
+	PINCTRL_PIN_GROUP("gpio4", an7583_gpio4),
+	PINCTRL_PIN_GROUP("gpio5", an7583_gpio5),
+	PINCTRL_PIN_GROUP("gpio6", an7583_gpio6),
+	PINCTRL_PIN_GROUP("gpio7", an7583_gpio7),
+	PINCTRL_PIN_GROUP("gpio8", an7583_gpio8),
+	PINCTRL_PIN_GROUP("gpio9", an7583_gpio9),
+	PINCTRL_PIN_GROUP("gpio10", an7583_gpio10),
+	PINCTRL_PIN_GROUP("gpio11", an7583_gpio11),
+	PINCTRL_PIN_GROUP("gpio12", an7583_gpio12),
+	PINCTRL_PIN_GROUP("gpio13", an7583_gpio13),
+	PINCTRL_PIN_GROUP("gpio14", an7583_gpio14),
+	PINCTRL_PIN_GROUP("gpio15", an7583_gpio15),
+	PINCTRL_PIN_GROUP("gpio16", an7583_gpio16),
+	PINCTRL_PIN_GROUP("gpio17", an7583_gpio17),
+	PINCTRL_PIN_GROUP("gpio18", an7583_gpio18),
+	PINCTRL_PIN_GROUP("gpio19", an7583_gpio19),
+	PINCTRL_PIN_GROUP("gpio20", an7583_gpio20),
+	PINCTRL_PIN_GROUP("gpio21", an7583_gpio21),
+	PINCTRL_PIN_GROUP("gpio22", an7583_gpio22),
+	PINCTRL_PIN_GROUP("gpio23", an7583_gpio23),
+	PINCTRL_PIN_GROUP("gpio24", an7583_gpio24),
+	PINCTRL_PIN_GROUP("gpio25", an7583_gpio25),
+	PINCTRL_PIN_GROUP("gpio26", an7583_gpio26),
+	PINCTRL_PIN_GROUP("gpio27", an7583_gpio27),
+	PINCTRL_PIN_GROUP("gpio28", an7583_gpio28),
+	PINCTRL_PIN_GROUP("gpio29", an7583_gpio29),
+	PINCTRL_PIN_GROUP("gpio30", an7583_gpio30),
+	PINCTRL_PIN_GROUP("gpio31", an7583_gpio31),
+	PINCTRL_PIN_GROUP("gpio32", an7583_gpio32),
+	PINCTRL_PIN_GROUP("gpio33", an7583_gpio33),
+	PINCTRL_PIN_GROUP("gpio34", an7583_gpio34),
+	PINCTRL_PIN_GROUP("gpio35", an7583_gpio35),
+	PINCTRL_PIN_GROUP("gpio36", an7583_gpio36),
+	PINCTRL_PIN_GROUP("gpio37", an7583_gpio37),
+	PINCTRL_PIN_GROUP("gpio38", an7583_gpio38),
+	PINCTRL_PIN_GROUP("gpio39", an7583_gpio39),
+	PINCTRL_PIN_GROUP("gpio40", an7583_gpio40),
+	PINCTRL_PIN_GROUP("gpio41", an7583_gpio41),
+	PINCTRL_PIN_GROUP("gpio42", an7583_gpio42),
+	PINCTRL_PIN_GROUP("gpio43", an7583_gpio43),
+	PINCTRL_PIN_GROUP("gpio44", an7583_gpio44),
+	PINCTRL_PIN_GROUP("gpio45", an7583_gpio45),
+	PINCTRL_PIN_GROUP("gpio46", an7583_gpio46),
+	PINCTRL_PIN_GROUP("gpio47", an7583_gpio47),
+	PINCTRL_PIN_GROUP("gpio48", an7583_gpio48),
+	PINCTRL_PIN_GROUP("pcie_reset0", an7583_pcie_reset0),
+	PINCTRL_PIN_GROUP("pcie_reset1", an7583_pcie_reset1),
+};
+
+static const struct airoha_pinctrl_func an7583_pinctrl_funcs[] = {
+	PINCTRL_FUNC_DESC("pon", pon),
+	PINCTRL_FUNC_DESC("tod_1pps", tod_1pps),
+	PINCTRL_FUNC_DESC("sipo", sipo),
+	PINCTRL_FUNC_DESC("mdio", an7583_mdio),
+	PINCTRL_FUNC_DESC("uart", uart),
+	PINCTRL_FUNC_DESC("i2c", i2c),
+	PINCTRL_FUNC_DESC("jtag", jtag),
+	PINCTRL_FUNC_DESC("pcm", pcm),
+	PINCTRL_FUNC_DESC("spi", spi),
+	PINCTRL_FUNC_DESC("pcm_spi", an7583_pcm_spi),
+	PINCTRL_FUNC_DESC("emmc", emmc),
+	PINCTRL_FUNC_DESC("pnand", pnand),
+	PINCTRL_FUNC_DESC("pcie_reset", an7583_pcie_reset),
+	PINCTRL_FUNC_DESC("pwm", pwm),
+	PINCTRL_FUNC_DESC("phy1_led0", an7583_phy1_led0),
+	PINCTRL_FUNC_DESC("phy2_led0", an7583_phy2_led0),
+	PINCTRL_FUNC_DESC("phy3_led0", an7583_phy3_led0),
+	PINCTRL_FUNC_DESC("phy4_led0", an7583_phy4_led0),
+	PINCTRL_FUNC_DESC("phy1_led1", an7583_phy1_led1),
+	PINCTRL_FUNC_DESC("phy2_led1", an7583_phy2_led1),
+	PINCTRL_FUNC_DESC("phy3_led1", an7583_phy3_led1),
+	PINCTRL_FUNC_DESC("phy4_led1", an7583_phy4_led1),
+};
+
+static const struct airoha_pinctrl_conf an7583_pinctrl_pullup_conf[] = {
+	PINCTRL_CONF_DESC(2, REG_GPIO_L_PU, BIT(0)),
+	PINCTRL_CONF_DESC(3, REG_GPIO_L_PU, BIT(1)),
+	PINCTRL_CONF_DESC(4, REG_GPIO_L_PU, BIT(2)),
+	PINCTRL_CONF_DESC(5, REG_GPIO_L_PU, BIT(3)),
+	PINCTRL_CONF_DESC(6, REG_GPIO_L_PU, BIT(4)),
+	PINCTRL_CONF_DESC(7, REG_GPIO_L_PU, BIT(5)),
+	PINCTRL_CONF_DESC(8, REG_GPIO_L_PU, BIT(6)),
+	PINCTRL_CONF_DESC(9, REG_GPIO_L_PU, BIT(7)),
+	PINCTRL_CONF_DESC(10, REG_GPIO_L_PU, BIT(8)),
+	PINCTRL_CONF_DESC(11, REG_GPIO_L_PU, BIT(9)),
+	PINCTRL_CONF_DESC(12, REG_GPIO_L_PU, BIT(10)),
+	PINCTRL_CONF_DESC(13, REG_GPIO_L_PU, BIT(11)),
+	PINCTRL_CONF_DESC(14, REG_GPIO_L_PU, BIT(12)),
+	PINCTRL_CONF_DESC(15, REG_GPIO_L_PU, BIT(13)),
+	PINCTRL_CONF_DESC(16, REG_GPIO_L_PU, BIT(14)),
+	PINCTRL_CONF_DESC(17, REG_GPIO_L_PU, BIT(15)),
+	PINCTRL_CONF_DESC(18, REG_GPIO_L_PU, BIT(16)),
+	PINCTRL_CONF_DESC(19, REG_GPIO_L_PU, BIT(17)),
+	PINCTRL_CONF_DESC(20, REG_GPIO_L_PU, BIT(18)),
+	PINCTRL_CONF_DESC(21, REG_GPIO_L_PU, BIT(19)),
+	PINCTRL_CONF_DESC(22, REG_GPIO_L_PU, BIT(20)),
+	PINCTRL_CONF_DESC(23, REG_GPIO_L_PU, BIT(21)),
+	PINCTRL_CONF_DESC(24, REG_GPIO_L_PU, BIT(22)),
+	PINCTRL_CONF_DESC(25, REG_GPIO_L_PU, BIT(23)),
+	PINCTRL_CONF_DESC(26, REG_GPIO_L_PU, BIT(24)),
+	PINCTRL_CONF_DESC(27, REG_GPIO_L_PU, BIT(25)),
+	PINCTRL_CONF_DESC(28, REG_GPIO_L_PU, BIT(26)),
+	PINCTRL_CONF_DESC(29, REG_GPIO_L_PU, BIT(27)),
+	PINCTRL_CONF_DESC(30, REG_GPIO_L_PU, BIT(28)),
+	PINCTRL_CONF_DESC(31, REG_GPIO_L_PU, BIT(29)),
+	PINCTRL_CONF_DESC(32, REG_GPIO_L_PU, BIT(30)),
+	PINCTRL_CONF_DESC(33, REG_GPIO_L_PU, BIT(31)),
+	PINCTRL_CONF_DESC(34, REG_GPIO_H_PU, BIT(0)),
+	PINCTRL_CONF_DESC(35, REG_GPIO_H_PU, BIT(1)),
+	PINCTRL_CONF_DESC(36, REG_GPIO_H_PU, BIT(2)),
+	PINCTRL_CONF_DESC(37, REG_GPIO_H_PU, BIT(3)),
+	PINCTRL_CONF_DESC(38, REG_GPIO_H_PU, BIT(4)),
+	PINCTRL_CONF_DESC(39, REG_GPIO_H_PU, BIT(5)),
+	PINCTRL_CONF_DESC(40, REG_GPIO_H_PU, BIT(6)),
+	PINCTRL_CONF_DESC(41, REG_I2C_SDA_PU, I2C_SCL_PU_MASK),
+	PINCTRL_CONF_DESC(42, REG_I2C_SDA_PU, I2C_SDA_PU_MASK),
+	PINCTRL_CONF_DESC(43, REG_I2C_SDA_PU, AN7583_I2C1_SCL_PU_MASK),
+	PINCTRL_CONF_DESC(44, REG_I2C_SDA_PU, AN7583_I2C1_SDA_PU_MASK),
+	PINCTRL_CONF_DESC(45, REG_I2C_SDA_PU, SPI_CLK_PU_MASK),
+	PINCTRL_CONF_DESC(46, REG_I2C_SDA_PU, SPI_CS0_PU_MASK),
+	PINCTRL_CONF_DESC(47, REG_I2C_SDA_PU, SPI_MOSI_PU_MASK),
+	PINCTRL_CONF_DESC(48, REG_I2C_SDA_PU, SPI_MISO_PU_MASK),
+	PINCTRL_CONF_DESC(49, REG_I2C_SDA_PU, UART1_TXD_PU_MASK),
+	PINCTRL_CONF_DESC(50, REG_I2C_SDA_PU, UART1_RXD_PU_MASK),
+	PINCTRL_CONF_DESC(51, REG_I2C_SDA_PU, PCIE0_RESET_PU_MASK),
+	PINCTRL_CONF_DESC(52, REG_I2C_SDA_PU, PCIE1_RESET_PU_MASK),
+	PINCTRL_CONF_DESC(53, REG_I2C_SDA_PU, AN7583_MDC_0_PU_MASK),
+	PINCTRL_CONF_DESC(54, REG_I2C_SDA_PU, AN7583_MDIO_0_PU_MASK),
+};
+
+static const struct airoha_pinctrl_conf an7583_pinctrl_pulldown_conf[] = {
+	PINCTRL_CONF_DESC(2, REG_GPIO_L_PD, BIT(0)),
+	PINCTRL_CONF_DESC(3, REG_GPIO_L_PD, BIT(1)),
+	PINCTRL_CONF_DESC(4, REG_GPIO_L_PD, BIT(2)),
+	PINCTRL_CONF_DESC(5, REG_GPIO_L_PD, BIT(3)),
+	PINCTRL_CONF_DESC(6, REG_GPIO_L_PD, BIT(4)),
+	PINCTRL_CONF_DESC(7, REG_GPIO_L_PD, BIT(5)),
+	PINCTRL_CONF_DESC(8, REG_GPIO_L_PD, BIT(6)),
+	PINCTRL_CONF_DESC(9, REG_GPIO_L_PD, BIT(7)),
+	PINCTRL_CONF_DESC(10, REG_GPIO_L_PD, BIT(8)),
+	PINCTRL_CONF_DESC(11, REG_GPIO_L_PD, BIT(9)),
+	PINCTRL_CONF_DESC(12, REG_GPIO_L_PD, BIT(10)),
+	PINCTRL_CONF_DESC(13, REG_GPIO_L_PD, BIT(11)),
+	PINCTRL_CONF_DESC(14, REG_GPIO_L_PD, BIT(12)),
+	PINCTRL_CONF_DESC(15, REG_GPIO_L_PD, BIT(13)),
+	PINCTRL_CONF_DESC(16, REG_GPIO_L_PD, BIT(14)),
+	PINCTRL_CONF_DESC(17, REG_GPIO_L_PD, BIT(15)),
+	PINCTRL_CONF_DESC(18, REG_GPIO_L_PD, BIT(16)),
+	PINCTRL_CONF_DESC(19, REG_GPIO_L_PD, BIT(17)),
+	PINCTRL_CONF_DESC(20, REG_GPIO_L_PD, BIT(18)),
+	PINCTRL_CONF_DESC(21, REG_GPIO_L_PD, BIT(19)),
+	PINCTRL_CONF_DESC(22, REG_GPIO_L_PD, BIT(20)),
+	PINCTRL_CONF_DESC(23, REG_GPIO_L_PD, BIT(21)),
+	PINCTRL_CONF_DESC(24, REG_GPIO_L_PD, BIT(22)),
+	PINCTRL_CONF_DESC(25, REG_GPIO_L_PD, BIT(23)),
+	PINCTRL_CONF_DESC(26, REG_GPIO_L_PD, BIT(24)),
+	PINCTRL_CONF_DESC(27, REG_GPIO_L_PD, BIT(25)),
+	PINCTRL_CONF_DESC(28, REG_GPIO_L_PD, BIT(26)),
+	PINCTRL_CONF_DESC(29, REG_GPIO_L_PD, BIT(27)),
+	PINCTRL_CONF_DESC(30, REG_GPIO_L_PD, BIT(28)),
+	PINCTRL_CONF_DESC(31, REG_GPIO_L_PD, BIT(29)),
+	PINCTRL_CONF_DESC(32, REG_GPIO_L_PD, BIT(30)),
+	PINCTRL_CONF_DESC(33, REG_GPIO_L_PD, BIT(31)),
+	PINCTRL_CONF_DESC(34, REG_GPIO_H_PD, BIT(0)),
+	PINCTRL_CONF_DESC(35, REG_GPIO_H_PD, BIT(1)),
+	PINCTRL_CONF_DESC(36, REG_GPIO_H_PD, BIT(2)),
+	PINCTRL_CONF_DESC(37, REG_GPIO_H_PD, BIT(3)),
+	PINCTRL_CONF_DESC(38, REG_GPIO_H_PD, BIT(4)),
+	PINCTRL_CONF_DESC(39, REG_GPIO_H_PD, BIT(5)),
+	PINCTRL_CONF_DESC(40, REG_GPIO_H_PD, BIT(6)),
+	PINCTRL_CONF_DESC(41, REG_I2C_SDA_PD, I2C_SCL_PD_MASK),
+	PINCTRL_CONF_DESC(42, REG_I2C_SDA_PD, I2C_SDA_PD_MASK),
+	PINCTRL_CONF_DESC(43, REG_I2C_SDA_PD, AN7583_I2C1_SCL_PD_MASK),
+	PINCTRL_CONF_DESC(44, REG_I2C_SDA_PD, AN7583_I2C1_SDA_PD_MASK),
+	PINCTRL_CONF_DESC(45, REG_I2C_SDA_PD, SPI_CLK_PD_MASK),
+	PINCTRL_CONF_DESC(46, REG_I2C_SDA_PD, SPI_CS0_PD_MASK),
+	PINCTRL_CONF_DESC(47, REG_I2C_SDA_PD, SPI_MOSI_PD_MASK),
+	PINCTRL_CONF_DESC(48, REG_I2C_SDA_PD, SPI_MISO_PD_MASK),
+	PINCTRL_CONF_DESC(49, REG_I2C_SDA_PD, UART1_TXD_PD_MASK),
+	PINCTRL_CONF_DESC(50, REG_I2C_SDA_PD, UART1_RXD_PD_MASK),
+	PINCTRL_CONF_DESC(51, REG_I2C_SDA_PD, PCIE0_RESET_PD_MASK),
+	PINCTRL_CONF_DESC(52, REG_I2C_SDA_PD, PCIE1_RESET_PD_MASK),
+	PINCTRL_CONF_DESC(53, REG_I2C_SDA_PD, AN7583_MDC_0_PD_MASK),
+	PINCTRL_CONF_DESC(54, REG_I2C_SDA_PD, AN7583_MDIO_0_PD_MASK),
+};
+
+static const struct airoha_pinctrl_conf an7583_pinctrl_drive_e2_conf[] = {
+	PINCTRL_CONF_DESC(2, REG_GPIO_L_E2, BIT(0)),
+	PINCTRL_CONF_DESC(3, REG_GPIO_L_E2, BIT(1)),
+	PINCTRL_CONF_DESC(4, REG_GPIO_L_E2, BIT(2)),
+	PINCTRL_CONF_DESC(5, REG_GPIO_L_E2, BIT(3)),
+	PINCTRL_CONF_DESC(6, REG_GPIO_L_E2, BIT(4)),
+	PINCTRL_CONF_DESC(7, REG_GPIO_L_E2, BIT(5)),
+	PINCTRL_CONF_DESC(8, REG_GPIO_L_E2, BIT(6)),
+	PINCTRL_CONF_DESC(9, REG_GPIO_L_E2, BIT(7)),
+	PINCTRL_CONF_DESC(10, REG_GPIO_L_E2, BIT(8)),
+	PINCTRL_CONF_DESC(11, REG_GPIO_L_E2, BIT(9)),
+	PINCTRL_CONF_DESC(12, REG_GPIO_L_E2, BIT(10)),
+	PINCTRL_CONF_DESC(13, REG_GPIO_L_E2, BIT(11)),
+	PINCTRL_CONF_DESC(14, REG_GPIO_L_E2, BIT(12)),
+	PINCTRL_CONF_DESC(15, REG_GPIO_L_E2, BIT(13)),
+	PINCTRL_CONF_DESC(16, REG_GPIO_L_E2, BIT(14)),
+	PINCTRL_CONF_DESC(17, REG_GPIO_L_E2, BIT(15)),
+	PINCTRL_CONF_DESC(18, REG_GPIO_L_E2, BIT(16)),
+	PINCTRL_CONF_DESC(19, REG_GPIO_L_E2, BIT(17)),
+	PINCTRL_CONF_DESC(20, REG_GPIO_L_E2, BIT(18)),
+	PINCTRL_CONF_DESC(21, REG_GPIO_L_E2, BIT(19)),
+	PINCTRL_CONF_DESC(22, REG_GPIO_L_E2, BIT(20)),
+	PINCTRL_CONF_DESC(23, REG_GPIO_L_E2, BIT(21)),
+	PINCTRL_CONF_DESC(24, REG_GPIO_L_E2, BIT(22)),
+	PINCTRL_CONF_DESC(25, REG_GPIO_L_E2, BIT(23)),
+	PINCTRL_CONF_DESC(26, REG_GPIO_L_E2, BIT(24)),
+	PINCTRL_CONF_DESC(27, REG_GPIO_L_E2, BIT(25)),
+	PINCTRL_CONF_DESC(28, REG_GPIO_L_E2, BIT(26)),
+	PINCTRL_CONF_DESC(29, REG_GPIO_L_E2, BIT(27)),
+	PINCTRL_CONF_DESC(30, REG_GPIO_L_E2, BIT(28)),
+	PINCTRL_CONF_DESC(31, REG_GPIO_L_E2, BIT(29)),
+	PINCTRL_CONF_DESC(32, REG_GPIO_L_E2, BIT(30)),
+	PINCTRL_CONF_DESC(33, REG_GPIO_L_E2, BIT(31)),
+	PINCTRL_CONF_DESC(34, REG_GPIO_H_E2, BIT(0)),
+	PINCTRL_CONF_DESC(35, REG_GPIO_H_E2, BIT(1)),
+	PINCTRL_CONF_DESC(36, REG_GPIO_H_E2, BIT(2)),
+	PINCTRL_CONF_DESC(37, REG_GPIO_H_E2, BIT(3)),
+	PINCTRL_CONF_DESC(38, REG_GPIO_H_E2, BIT(4)),
+	PINCTRL_CONF_DESC(39, REG_GPIO_H_E2, BIT(5)),
+	PINCTRL_CONF_DESC(40, REG_GPIO_H_E2, BIT(6)),
+	PINCTRL_CONF_DESC(41, REG_I2C_SDA_E2, I2C_SCL_E2_MASK),
+	PINCTRL_CONF_DESC(42, REG_I2C_SDA_E2, I2C_SDA_E2_MASK),
+	PINCTRL_CONF_DESC(43, REG_I2C_SDA_E2, AN7583_I2C1_SCL_E2_MASK),
+	PINCTRL_CONF_DESC(44, REG_I2C_SDA_E2, AN7583_I2C1_SDA_E2_MASK),
+	PINCTRL_CONF_DESC(45, REG_I2C_SDA_E2, SPI_CLK_E2_MASK),
+	PINCTRL_CONF_DESC(46, REG_I2C_SDA_E2, SPI_CS0_E2_MASK),
+	PINCTRL_CONF_DESC(47, REG_I2C_SDA_E2, SPI_MOSI_E2_MASK),
+	PINCTRL_CONF_DESC(48, REG_I2C_SDA_E2, SPI_MISO_E2_MASK),
+	PINCTRL_CONF_DESC(49, REG_I2C_SDA_E2, UART1_TXD_E2_MASK),
+	PINCTRL_CONF_DESC(50, REG_I2C_SDA_E2, UART1_RXD_E2_MASK),
+	PINCTRL_CONF_DESC(51, REG_I2C_SDA_E2, PCIE0_RESET_E2_MASK),
+	PINCTRL_CONF_DESC(52, REG_I2C_SDA_E2, PCIE1_RESET_E2_MASK),
+	PINCTRL_CONF_DESC(53, REG_I2C_SDA_E2, AN7583_MDC_0_E2_MASK),
+	PINCTRL_CONF_DESC(54, REG_I2C_SDA_E2, AN7583_MDIO_0_E2_MASK),
+};
+
+static const struct airoha_pinctrl_conf an7583_pinctrl_drive_e4_conf[] = {
+	PINCTRL_CONF_DESC(2, REG_GPIO_L_E4, BIT(0)),
+	PINCTRL_CONF_DESC(3, REG_GPIO_L_E4, BIT(1)),
+	PINCTRL_CONF_DESC(4, REG_GPIO_L_E4, BIT(2)),
+	PINCTRL_CONF_DESC(5, REG_GPIO_L_E4, BIT(3)),
+	PINCTRL_CONF_DESC(6, REG_GPIO_L_E4, BIT(4)),
+	PINCTRL_CONF_DESC(7, REG_GPIO_L_E4, BIT(5)),
+	PINCTRL_CONF_DESC(8, REG_GPIO_L_E4, BIT(6)),
+	PINCTRL_CONF_DESC(9, REG_GPIO_L_E4, BIT(7)),
+	PINCTRL_CONF_DESC(10, REG_GPIO_L_E4, BIT(8)),
+	PINCTRL_CONF_DESC(11, REG_GPIO_L_E4, BIT(9)),
+	PINCTRL_CONF_DESC(12, REG_GPIO_L_E4, BIT(10)),
+	PINCTRL_CONF_DESC(13, REG_GPIO_L_E4, BIT(11)),
+	PINCTRL_CONF_DESC(14, REG_GPIO_L_E4, BIT(12)),
+	PINCTRL_CONF_DESC(15, REG_GPIO_L_E4, BIT(13)),
+	PINCTRL_CONF_DESC(16, REG_GPIO_L_E4, BIT(14)),
+	PINCTRL_CONF_DESC(17, REG_GPIO_L_E4, BIT(15)),
+	PINCTRL_CONF_DESC(18, REG_GPIO_L_E4, BIT(16)),
+	PINCTRL_CONF_DESC(19, REG_GPIO_L_E4, BIT(17)),
+	PINCTRL_CONF_DESC(20, REG_GPIO_L_E4, BIT(18)),
+	PINCTRL_CONF_DESC(21, REG_GPIO_L_E4, BIT(19)),
+	PINCTRL_CONF_DESC(22, REG_GPIO_L_E4, BIT(20)),
+	PINCTRL_CONF_DESC(23, REG_GPIO_L_E4, BIT(21)),
+	PINCTRL_CONF_DESC(24, REG_GPIO_L_E4, BIT(22)),
+	PINCTRL_CONF_DESC(25, REG_GPIO_L_E4, BIT(23)),
+	PINCTRL_CONF_DESC(26, REG_GPIO_L_E4, BIT(24)),
+	PINCTRL_CONF_DESC(27, REG_GPIO_L_E4, BIT(25)),
+	PINCTRL_CONF_DESC(28, REG_GPIO_L_E4, BIT(26)),
+	PINCTRL_CONF_DESC(29, REG_GPIO_L_E4, BIT(27)),
+	PINCTRL_CONF_DESC(30, REG_GPIO_L_E4, BIT(28)),
+	PINCTRL_CONF_DESC(31, REG_GPIO_L_E4, BIT(29)),
+	PINCTRL_CONF_DESC(32, REG_GPIO_L_E4, BIT(30)),
+	PINCTRL_CONF_DESC(33, REG_GPIO_L_E4, BIT(31)),
+	PINCTRL_CONF_DESC(34, REG_GPIO_H_E4, BIT(0)),
+	PINCTRL_CONF_DESC(35, REG_GPIO_H_E4, BIT(1)),
+	PINCTRL_CONF_DESC(36, REG_GPIO_H_E4, BIT(2)),
+	PINCTRL_CONF_DESC(37, REG_GPIO_H_E4, BIT(3)),
+	PINCTRL_CONF_DESC(38, REG_GPIO_H_E4, BIT(4)),
+	PINCTRL_CONF_DESC(39, REG_GPIO_H_E4, BIT(5)),
+	PINCTRL_CONF_DESC(40, REG_GPIO_H_E4, BIT(6)),
+	PINCTRL_CONF_DESC(41, REG_I2C_SDA_E4, I2C_SCL_E4_MASK),
+	PINCTRL_CONF_DESC(42, REG_I2C_SDA_E4, I2C_SDA_E4_MASK),
+	PINCTRL_CONF_DESC(43, REG_I2C_SDA_E4, AN7583_I2C1_SCL_E4_MASK),
+	PINCTRL_CONF_DESC(44, REG_I2C_SDA_E4, AN7583_I2C1_SDA_E4_MASK),
+	PINCTRL_CONF_DESC(45, REG_I2C_SDA_E4, SPI_CLK_E4_MASK),
+	PINCTRL_CONF_DESC(46, REG_I2C_SDA_E4, SPI_CS0_E4_MASK),
+	PINCTRL_CONF_DESC(47, REG_I2C_SDA_E4, SPI_MOSI_E4_MASK),
+	PINCTRL_CONF_DESC(48, REG_I2C_SDA_E4, SPI_MISO_E4_MASK),
+	PINCTRL_CONF_DESC(49, REG_I2C_SDA_E4, UART1_TXD_E4_MASK),
+	PINCTRL_CONF_DESC(50, REG_I2C_SDA_E4, UART1_RXD_E4_MASK),
+	PINCTRL_CONF_DESC(51, REG_I2C_SDA_E4, PCIE0_RESET_E4_MASK),
+	PINCTRL_CONF_DESC(52, REG_I2C_SDA_E4, PCIE1_RESET_E4_MASK),
+	PINCTRL_CONF_DESC(53, REG_I2C_SDA_E4, AN7583_MDC_0_E4_MASK),
+	PINCTRL_CONF_DESC(54, REG_I2C_SDA_E4, AN7583_MDIO_0_E4_MASK),
+};
+
+static const struct airoha_pinctrl_conf an7583_pinctrl_pcie_rst_od_conf[] = {
+	PINCTRL_CONF_DESC(51, REG_PCIE_RESET_OD, PCIE0_RESET_OD_MASK),
+	PINCTRL_CONF_DESC(52, REG_PCIE_RESET_OD, PCIE1_RESET_OD_MASK),
+};
+
+static const struct airoha_pinctrl_match_data an7583_pinctrl_match_data = {
+	.gpio_offs = 2,
+	.gpio_pin_cnt = 51,
+	.pins = an7583_pinctrl_pins,
+	.num_pins = ARRAY_SIZE(an7583_pinctrl_pins),
+	.grps = an7583_pinctrl_groups,
+	.num_grps = ARRAY_SIZE(an7583_pinctrl_groups),
+	.funcs = an7583_pinctrl_funcs,
+	.num_funcs = ARRAY_SIZE(an7583_pinctrl_funcs),
+	.confs_info = {
+		[AIROHA_PINCTRL_CONFS_PULLUP] = {
+			.confs = an7583_pinctrl_pullup_conf,
+			.num_confs = ARRAY_SIZE(an7583_pinctrl_pullup_conf),
+		},
+		[AIROHA_PINCTRL_CONFS_PULLDOWN] = {
+			.confs = an7583_pinctrl_pulldown_conf,
+			.num_confs = ARRAY_SIZE(an7583_pinctrl_pulldown_conf),
+		},
+		[AIROHA_PINCTRL_CONFS_DRIVE_E2] = {
+			.confs = an7583_pinctrl_drive_e2_conf,
+			.num_confs = ARRAY_SIZE(an7583_pinctrl_drive_e2_conf),
+		},
+		[AIROHA_PINCTRL_CONFS_DRIVE_E4] = {
+			.confs = an7583_pinctrl_drive_e4_conf,
+			.num_confs = ARRAY_SIZE(an7583_pinctrl_drive_e4_conf),
+		},
+		[AIROHA_PINCTRL_CONFS_PCIE_RST_OD] = {
+			.confs = an7583_pinctrl_pcie_rst_od_conf,
+			.num_confs = ARRAY_SIZE(an7583_pinctrl_pcie_rst_od_conf),
+		},
+	},
+};
+
+static const struct udevice_id airoha_pinctrl_of_match[] = {
+	{ .compatible = "airoha,an7583-pinctrl",
+	  .data = (uintptr_t)&an7583_pinctrl_match_data },
+	{ /* sentinel */ }
+};
+
+U_BOOT_DRIVER(airoha_an7583_pinctrl) = {
+	.name = "airoha-an7583-pinctrl",
+	.id = UCLASS_PINCTRL,
+	.of_match = of_match_ptr(airoha_pinctrl_of_match),
+	.probe = airoha_pinctrl_probe,
+	.bind = airoha_pinctrl_bind,
+	.priv_auto = sizeof(struct airoha_pinctrl),
+	.ops = &airoha_pinctrl_ops,
+};
-- 
2.53.0

