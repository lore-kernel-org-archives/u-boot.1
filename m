Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4703CD5BC9
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 00:27:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EA3584979;
	Tue, 26 May 2026 02:26:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="Ng9KTuE5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84D5384972; Tue, 26 May 2026 02:26:21 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC74E84926
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 02:26:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e6845qaXPt1M6zGZRmqympz2JxhMhFBJHcwYTvDXxd3Tepja1QuQH6CsyN4UGlaepGpeOapd306fei5RMG1dqyPl7yEYPaJl14pWdAnz2cdxesSTlPcXOkBnKZLwdG+guauLetjW5eMNhLEfLAzQgJZ8QFDZb0O59Q5jLHmd5QDk8hg3YYQ2C+S9I9D1GcpRcr/cMEvHFSQfyd5+bxYchLJnma87K+i32RzbU7KgkSQQFK0l34NRMFi6aEXVKrOo2KjcJ7ihfq5YpCmMCLd95MdCeJyW6jkGaR4aCXTti0QgjnHm7v5V4tM1Ta9y3HUSVvqgXDVajSGRi2OsD2lmoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6faxEqv8tRppk5dREu0gvT8NiKURHsuzFX5U9BkG4m0=;
 b=GXm+BsjL/qw+Cm5q278HZpX9tCxue0U/KtY5+HdLzi5iEv+6H2Uh9sdnc+WNV9N4J2bRCXJUJBsGV6XqdR78+nDaLvyE+YUEL/JQaz/5pVAK7z5HYScEzI6Hilha/Y2CBaS5qUuJyuBPG8XpCCLObm/q2YsCLZyK+pwV8qBquaexb91EJOZrJ53T4bS3v0ZIoX72EFw8oVGRPzJB2phyjb4KJ5aFKQVDHlwlqtn5CdonxG9DkbzxczFtkW9uaoxTJLgk8jQc2daQthlo0LyAB4UA900mshH8jRvalKrDTUnI939QgvD+8I3mDT4H/Ab5XcTg37zZtcmLg/iTWG+qug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6faxEqv8tRppk5dREu0gvT8NiKURHsuzFX5U9BkG4m0=;
 b=Ng9KTuE50wPXag65/E+aUgN/zhqv+Q7viFXhzFgT56G93IDsVNZtrhO7IT4L/zEpBqtTO8MQcjhPaTlQhWwLTrppRLTV6VAC7emtgZMTAJIxRd8c0nitvCYIgoho8J+hzuFlU0b68xPD8bR+L2a6cD1qBySOsu5EmfxCZ2Q/gYQ1kDMjbpy2YaZgaaOZ4mN7uzCGvmeHR9Y3q61YJpViYpVLLFlzY0wrBlSpaMbTgDGHFlnW+zeB3Eg56r7cy00zgS7zbXyqyJydIj/UeaP57PsqCyLS/x/IqTouUaHk/ypV86rjy46AZHbrFS71i7yD4m7Bax58Fk4Ptkp6oeoGQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV1PR08MB7682.eurprd08.prod.outlook.com (2603:10a6:150:61::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 00:26:16 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 00:26:16 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 Anis Chali <chalianis1@gmail.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v10 09/12] pinctrl: airoha: add pin controller and gpio driver
 for EN7523 SoC
Date: Tue, 26 May 2026 03:25:31 +0300
Message-ID: <20260526002534.898340-10-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526002534.898340-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260526002534.898340-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0039.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::15) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV1PR08MB7682:EE_
X-MS-Office365-Filtering-Correlation-Id: 2413c65b-7077-4420-7b0d-08debabd6650
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|366016|1800799024|11063799006|18002099003|22082099003|56012099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info: cDCyxfOoc5fGp2ODlIshM4KWT6jz0soQswDQyZBXZQDYuSYnulZd6ioelwT0+81nY6nWj9bkOrRut+a59O6HU4HEQMXnPeMV9V30/QQ//h5X/P2bOSEhunM4KZ70/ROXqimKDLufB9w/UfwXMzJqyj+ui131mz/qDEv/wPSO+J1xxe04+fFiaCjieKoIvNj6d5yXzb0QxsCAf9AiGxikJS2fuSlAjeOzaPcHnlHoiwwhYk/NKOGeBviiErQOQXwputVcRDMy7mfyELYn2YNI8u9wnqYTN+ksJi0o9Wlseb4EYjueg1UowSL2EkZGs2LvwPmTyvhxqNAhG0p/TSm/DCS6ik3t3tfzlI8Kp6szYvDKiUCNTbO124b0ye7X+CgbyGoNHdDgQfPjLUpE80kki3xYNZ2tm+YsVmCLN+LPlXm79qz67f0e93CSLKCm4qGZuXr/5ZuXpzfkUKKz0WvR0eQp2Na/l6ifFYWziGo2N3kbmbPL/8/RkgN+vnbes/m8eP5U/lgj3L2FSg4zDWslE8QQHUO9j3o4Tqcr1X8EsU3pouLHjPi7X9Y+f/43YeliBfmtRDunbA7rw8whbNBhAkU+fL7RJkUjLOxpQqF0dHaK8Ud69S4qkii4OomrzSu4SIa5fIGfOIi1/lEkg2u/NruVyEDkGMb7X0gKIewjubWe6r4cItPSNdcFM5ttoXmeE8v3yKy3BRDzSQoXUEOYU0/Hmz5ZYfBxo4t8lKRS1GFn6EOvTURtnRakWix5l4525mq4FQ3k+SpL+PAA2Q83XA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(11063799006)(18002099003)(22082099003)(56012099003)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bjtXUKQYubfQY4KxiZYFDDYUpvxkreef+gJSLmkt5UsHJ3+CxsMezNHgSaCY?=
 =?us-ascii?Q?TvmGP474icjNdUAws3JGH8blib2kl3jh3IcnbEzRiK+8Suea9aZS/d1DdRrQ?=
 =?us-ascii?Q?ur7SnVK6bQB8FdWV7LcKQNkFV+KdVQ7yZx+YYY/eVCUsxjQy2ZcoU2bJ5bkq?=
 =?us-ascii?Q?AzV3cXQe0ZsTdWh7GIwW3f+pbYCuqJS9eksWNhlH+0mTJtULgTEeWQaU9tMd?=
 =?us-ascii?Q?eia7TPgPtaAOm8Vg3GDDYhfEKt0cmKD/zBGHaYtHi+XlemRpTkeGjNUKkXpe?=
 =?us-ascii?Q?OE1DvR8irp8Fnt7rj/0z/K0CgKhwoO3Z++QZbVnOTFxI4qDZMYuDCW+fmtA/?=
 =?us-ascii?Q?MWrx6JHjMKYX18Im7Sd82CK2LFLWIxPDoy/cWKt/geyZ9sqS/zY7WeR+YN1K?=
 =?us-ascii?Q?nG+FEBXW6SyYNrGn+DpUS8fwqtL4NTuwSPHJV764nGnr7Vpr1b3YSLUjNRxJ?=
 =?us-ascii?Q?d3vUFyPLFMVgUNrolcAZUO9yQNBjv5W4sr3kfZj05ILoC9odUPx+oYSVX8rD?=
 =?us-ascii?Q?J1C4LN2BN++DTjq4Du/kczhlEbHpumolKutog8qWAVTSrIVz8cOeGW9WrAlV?=
 =?us-ascii?Q?uwXR5UKu9l0PDf2MdF8r7C++1JPzgDWTMtWu6Vd+TtMK3ZZLwYGcuYIEmG7B?=
 =?us-ascii?Q?ii2+ltMynZFIzDhJ7YpavVxVwWM9SJDhZqKZ2y3+jz/Ji6oFf+aCFQnxrynR?=
 =?us-ascii?Q?4wXnR1kw/8DJXYSqMB5L9w3B/H+e5Ti0Cnnr8BsWpR3f4RT4kbO+kYIpXOpf?=
 =?us-ascii?Q?y21r7l9D8quA4xmNaRpZB0AB32/tQFQTZz6cJ5L13ALllNunjNBWQUbHzm7A?=
 =?us-ascii?Q?lE8quvcW+Oix0BKQYRC6jdpF2XbLZIK5lltSCDcEPhGXPzKgufuT7HiQvq5P?=
 =?us-ascii?Q?BidPOr524mz4p8N9gw1mpnWUI0f1FvCJWT7dGssFKbBguoFz9mjSKic/J/7i?=
 =?us-ascii?Q?dTl/nrCq2K3RQIKs5RNtP5FE6MGP0DhIeXFxtKxxkADrLhegdSFJYQByf3ol?=
 =?us-ascii?Q?Lu9x+WM9ldJBedkFjD5unyDDZ7tmJSCw7WxOnk774ElQAnVAG+q78uYjZ2X1?=
 =?us-ascii?Q?zg6xi3pvGEp3Jg1evURvLySpcx5fBgfbIz0xrBOk91GstF3vdx4NIUocQq5F?=
 =?us-ascii?Q?whGXSYVdFVHTYlrACRa3KhcGH0gX5QNTEGQYPWc3IbN6MIm+/YXE0Z2rOrwL?=
 =?us-ascii?Q?fK7HnZ/YVku4AZ04UMK7OiGm19O+hzTPy1/nhLEHt5TCvqTQtHjYoUr5BWL4?=
 =?us-ascii?Q?CEtlBp2LiR9p1QMeyO9l2uU01EsMxTq5+XWQyJm/i+VFm7c6kVV0voXmCEgs?=
 =?us-ascii?Q?BgTYfd8A+KJfFaNZR+RAVOkXw5J9/JtwoKjwHGIg+05I5Ct0ZPixHQmFWPuf?=
 =?us-ascii?Q?mwrcYkwP/c0akit4OVakwixuqt0c8d5jBLZekxBAlRQQbdYzuSvP/M2CSHwu?=
 =?us-ascii?Q?RWv/Q/Q42ibgOviDX2bvohf1DpVF/K61rnkLnNntBz4jX0qm90cQxGvHn3R8?=
 =?us-ascii?Q?g5RTreFOtLQDPDSKZa+hlW0jmVFNr/XPGos6RhUOJMHPUZwqV34nOy4U1zCz?=
 =?us-ascii?Q?HYLWjoy8FG38qnb3S0CFzjCEelvFTajLvuEcJghJICQ9p3Iar1dAqg0MUMhf?=
 =?us-ascii?Q?PCMSrYLEeM5KdEc7bfiJtQTuWnqe0izb8+4/COdsl+QsIc3yC9L5vp89rBEM?=
 =?us-ascii?Q?Vn7zrGqkAJTPQEQLJfdOEiNjLWTyWDbgIV/4axV0Ly9ZLPPjrrxeK8Enu6w8?=
 =?us-ascii?Q?PF1QjHSwrnB6F3wAgGU61kwCHaWBhFE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2413c65b-7077-4420-7b0d-08debabd6650
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 00:26:16.3286 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8OH+msBJzqDhK8vaLyyHQ3szMk9MQ3C0aiRojFZzCcN0ejkGwh6LMUygnPwNBT4NTcFUS32RFA9q/DNhs7NPjOSikkAOdg49htKFL72QK8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7682
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
 drivers/pinctrl/airoha/pinctrl-en7523.c | 762 ++++++++++++++++++++++++
 3 files changed, 768 insertions(+)
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
index 00000000000..347be36ef58
--- /dev/null
+++ b/drivers/pinctrl/airoha/pinctrl-en7523.c
@@ -0,0 +1,762 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Author: Lorenzo Bianconi <lorenzo@kernel.org>
+ * Author: Benjamin Larsson <benjamin.larsson@genexis.eu>
+ * Author: Markus Gothe <markus.gothe@genexis.eu>
+ * Author: Matheus Sampaio Queiroga <srherobrine20@gmail.com>
+ * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
+ */
+#include "airoha-common.h"
+
+static const int pon_pins[] = { 28, 29, 30, 31, 32, 33 };
+static const int pon_tod_1pps_pins[] = { 21 };
+static const int gsw_tod_1pps_pins[] = { 21 };
+static const int sipo_pins[] = { 13, 38 };
+static const int sipo_rclk_pins[] = { 13, 30, 38 };
+static const int mdio_pins[] = { 20, 21 };
+static const int uart2_pins[] = { 20, 21 };
+static const int npu_uart_pins[] = { 13, 38 };
+static const int i2c0_pins[] = { 2, 3 };
+static const int i2c1_pins[] = { 14, 15 };
+static const int jtag_udi_pins[] = { 34, 35, 36, 37, 38 };
+static const int jtag_dfd_pins[] = { 34, 35, 36, 37, 38 };
+static const int i2s_pins[] = { 16, 17, 18, 19 };
+static const int pcm1_pins[] = { 24, 25, 26, 27 };
+static const int pcm2_pins[] = { 16, 17, 18, 19 };
+static const int spi_pins[] = { 4, 5, 6, 7 };
+static const int spi_quad_pins[] = { 14, 15 };
+static const int spi_cs1_pins[] = { 21 };
+static const int pcm_spi_pins[] = { 16, 17, 18, 19, 24, 25, 26, 27 };
+static const int pcm_spi_int_pins[] = { 15 };
+static const int pcm_spi_rst_pins[] = { 14 };
+static const int pcm_spi_cs1_pins[] = { 22 };
+static const int pcm_spi_cs2_pins[] = { 39 };
+static const int pcm_spi_cs3_pins[] = { 20 };
+static const int pcm_spi_cs4_pins[] = { 23 };
+
+static const int gpio0_pins[] = { 12 };
+static const int gpio1_pins[] = { 13 };
+static const int gpio2_pins[] = { 14 };
+static const int gpio3_pins[] = { 15 };
+static const int gpio4_pins[] = { 16 };
+static const int gpio5_pins[] = { 17 };
+static const int gpio6_pins[] = { 18 };
+static const int gpio7_pins[] = { 19 };
+static const int gpio8_pins[] = { 20 };
+static const int gpio9_pins[] = { 21 };
+static const int gpio10_pins[] = { 22 };
+static const int gpio11_pins[] = { 23 };
+static const int gpio12_pins[] = { 24 };
+static const int gpio13_pins[] = { 25 };
+static const int gpio14_pins[] = { 26 };
+static const int gpio15_pins[] = { 27 };
+static const int gpio16_pins[] = { 28 };
+static const int gpio17_pins[] = { 29 };
+static const int gpio18_pins[] = { 30 };
+static const int gpio19_pins[] = { 31 };
+static const int gpio20_pins[] = { 32 };
+static const int gpio21_pins[] = { 33 };
+static const int gpio22_pins[] = { 34 };
+static const int gpio23_pins[] = { 35 };
+static const int gpio24_pins[] = { 36 };
+static const int gpio25_pins[] = { 37 };
+static const int gpio26_pins[] = { 38 };
+static const int gpio27_pins[] = { 39 };
+static const int pcie_reset0_pins[] = { 40 };
+static const int pcie_reset1_pins[] = { 41 };
+
+static struct pinctrl_pin_desc pinctrl_pins[] = {
+	PINCTRL_PIN(2, "i2c_sda"),
+	PINCTRL_PIN(3, "i2c_scl"),
+	PINCTRL_PIN(4, "spi_cs0"),
+	PINCTRL_PIN(5, "spi_clk"),
+	PINCTRL_PIN(6, "spi_mosi"),
+	PINCTRL_PIN(7, "spi_miso"),
+	PINCTRL_PIN(8, "uart1_txd"),
+	PINCTRL_PIN(9, "uart1_rxd"),
+	PINCTRL_PIN(12, "gpio0"),
+	PINCTRL_PIN(13, "gpio1"),
+	PINCTRL_PIN(14, "gpio2"),
+	PINCTRL_PIN(15, "gpio3"),
+	PINCTRL_PIN(16, "gpio4"),
+	PINCTRL_PIN(17, "gpio5"),
+	PINCTRL_PIN(18, "gpio6"),
+	PINCTRL_PIN(19, "gpio7"),
+	PINCTRL_PIN(20, "gpio8"),
+	PINCTRL_PIN(21, "gpio9"),
+	PINCTRL_PIN(22, "gpio10"),
+	PINCTRL_PIN(23, "gpio11"),
+	PINCTRL_PIN(24, "gpio12"),
+	PINCTRL_PIN(25, "gpio13"),
+	PINCTRL_PIN(26, "gpio14"),
+	PINCTRL_PIN(27, "gpio15"),
+	PINCTRL_PIN(28, "gpio16"),
+	PINCTRL_PIN(29, "gpio17"),
+	PINCTRL_PIN(30, "gpio18"),
+	PINCTRL_PIN(31, "gpio19"),
+	PINCTRL_PIN(32, "gpio20"),
+	PINCTRL_PIN(33, "gpio21"),
+	PINCTRL_PIN(34, "gpio22"),
+	PINCTRL_PIN(35, "gpio23"),
+	PINCTRL_PIN(36, "gpio24"),
+	PINCTRL_PIN(37, "gpio25"),
+	PINCTRL_PIN(38, "gpio26"),
+	PINCTRL_PIN(39, "gpio27"),
+	PINCTRL_PIN(40, "pcie_reset0"),
+	PINCTRL_PIN(41, "pcie_reset1"),
+};
+
+static const char *const pon_groups[] = { "pon" };
+static const char *const tod_1pps_groups[] = { "pon_tod_1pps", "gsw_tod_1pps" };
+static const char *const sipo_groups[] = { "sipo", "sipo_rclk" };
+static const char *const mdio_groups[] = { "mdio" };
+
+static const char *const uart_groups[] = { "uart2", "npu_uart" };
+static const char *const i2c_groups[] = { "i2c1" };
+static const char *const jtag_groups[] = { "jtag_udi", "jtag_dfd" };
+static const char *const pcm_groups[] = { "pcm1", "pcm2" };
+static const char *const spi_groups[] = { "spi_quad", "spi_cs1" };
+static const char *const pcm_spi_groups[] = {
+	"pcm_spi",     "pcm_spi_int", "pcm_spi_rst", "pcm_spi_cs1",
+	"pcm_spi_cs2", "pcm_spi_cs3", "pcm_spi_cs4"
+};
+
+static const char *const i2s_groups[] = { "i2s" };
+static const char *const pcie_reset_groups[] = {
+	"pcie_reset0", "pcie_reset1"
+};
+
+static const char *const pwm_groups[] = {
+	"gpio0",  "gpio1",  "gpio2",  "gpio3",  "gpio4",  "gpio5",  "gpio6",
+	"gpio7",  "gpio8",  "gpio9",  "gpio10", "gpio11", "gpio12", "gpio13",
+	"gpio14", "gpio15", "gpio16", "gpio17", "gpio18", "gpio19", "gpio20",
+	"gpio21", "gpio22", "gpio23", "gpio24", "gpio25", "gpio26", "gpio27"
+};
+
+static const char *const phy1_led0_groups[] = {
+	"gpio22", "gpio23", "gpio24", "gpio25"
+};
+static const char *const phy2_led0_groups[] = {
+	"gpio22", "gpio23", "gpio24", "gpio25"
+};
+static const char *const phy3_led0_groups[] = {
+	"gpio22", "gpio23", "gpio24", "gpio25"
+};
+static const char *const phy4_led0_groups[] = {
+	"gpio22", "gpio23", "gpio24", "gpio25"
+};
+static const char *const phy1_led1_groups[] = {
+	"gpio7", "gpio6", "gpio5", "gpio4"
+};
+static const char *const phy2_led1_groups[] = {
+	"gpio7", "gpio6", "gpio5", "gpio4"
+};
+static const char *const phy3_led1_groups[] = {
+	"gpio7", "gpio6", "gpio5", "gpio4"
+};
+static const char *const phy4_led1_groups[] = {
+	"gpio7", "gpio6", "gpio5", "gpio4"
+};
+
+static const struct airoha_pinctrl_conf pinctrl_drive_e2_conf[] = {
+	PINCTRL_CONF_DESC(12, REG_GPIO_L_E2, BIT(0)),
+	PINCTRL_CONF_DESC(13, REG_GPIO_L_E2, BIT(1)),
+	PINCTRL_CONF_DESC(14, REG_GPIO_L_E2, BIT(2)),
+	PINCTRL_CONF_DESC(15, REG_GPIO_L_E2, BIT(3)),
+	PINCTRL_CONF_DESC(16, REG_GPIO_L_E2, BIT(4)),
+	PINCTRL_CONF_DESC(17, REG_GPIO_L_E2, BIT(5)),
+	PINCTRL_CONF_DESC(18, REG_GPIO_L_E2, BIT(6)),
+	PINCTRL_CONF_DESC(19, REG_GPIO_L_E2, BIT(7)),
+	PINCTRL_CONF_DESC(20, REG_GPIO_L_E2, BIT(8)),
+	PINCTRL_CONF_DESC(21, REG_GPIO_L_E2, BIT(9)),
+	PINCTRL_CONF_DESC(22, REG_GPIO_L_E2, BIT(10)),
+	PINCTRL_CONF_DESC(23, REG_GPIO_L_E2, BIT(11)),
+	PINCTRL_CONF_DESC(24, REG_GPIO_L_E2, BIT(12)),
+	PINCTRL_CONF_DESC(25, REG_GPIO_L_E2, BIT(13)),
+	PINCTRL_CONF_DESC(26, REG_GPIO_L_E2, BIT(14)),
+	PINCTRL_CONF_DESC(27, REG_GPIO_L_E2, BIT(15)),
+	PINCTRL_CONF_DESC(28, REG_GPIO_L_E2, BIT(16)),
+	PINCTRL_CONF_DESC(29, REG_GPIO_L_E2, BIT(17)),
+	PINCTRL_CONF_DESC(30, REG_GPIO_L_E2, BIT(18)),
+	PINCTRL_CONF_DESC(31, REG_GPIO_L_E2, BIT(19)),
+	PINCTRL_CONF_DESC(32, REG_GPIO_L_E2, BIT(20)),
+	PINCTRL_CONF_DESC(33, REG_GPIO_L_E2, BIT(21)),
+	PINCTRL_CONF_DESC(34, REG_GPIO_L_E2, BIT(22)),
+	PINCTRL_CONF_DESC(35, REG_GPIO_L_E2, BIT(23)),
+	PINCTRL_CONF_DESC(36, REG_GPIO_L_E2, BIT(24)),
+	PINCTRL_CONF_DESC(37, REG_GPIO_L_E2, BIT(25)),
+	PINCTRL_CONF_DESC(38, REG_GPIO_L_E2, BIT(26)),
+	PINCTRL_CONF_DESC(39, REG_GPIO_L_E2, BIT(27)),
+	PINCTRL_CONF_DESC(40, REG_GPIO_L_E2, BIT(28)),
+	PINCTRL_CONF_DESC(41, REG_GPIO_L_E2, BIT(29)),
+};
+
+static const struct airoha_pinctrl_conf pinctrl_drive_e4_conf[] = {
+	PINCTRL_CONF_DESC(12, REG_GPIO_L_E4, BIT(0)),
+	PINCTRL_CONF_DESC(13, REG_GPIO_L_E4, BIT(1)),
+	PINCTRL_CONF_DESC(14, REG_GPIO_L_E4, BIT(2)),
+	PINCTRL_CONF_DESC(15, REG_GPIO_L_E4, BIT(3)),
+	PINCTRL_CONF_DESC(16, REG_GPIO_L_E4, BIT(4)),
+	PINCTRL_CONF_DESC(17, REG_GPIO_L_E4, BIT(5)),
+	PINCTRL_CONF_DESC(18, REG_GPIO_L_E4, BIT(6)),
+	PINCTRL_CONF_DESC(19, REG_GPIO_L_E4, BIT(7)),
+	PINCTRL_CONF_DESC(20, REG_GPIO_L_E4, BIT(8)),
+	PINCTRL_CONF_DESC(21, REG_GPIO_L_E4, BIT(9)),
+	PINCTRL_CONF_DESC(22, REG_GPIO_L_E4, BIT(10)),
+	PINCTRL_CONF_DESC(23, REG_GPIO_L_E4, BIT(11)),
+	PINCTRL_CONF_DESC(24, REG_GPIO_L_E4, BIT(12)),
+	PINCTRL_CONF_DESC(25, REG_GPIO_L_E4, BIT(13)),
+	PINCTRL_CONF_DESC(26, REG_GPIO_L_E4, BIT(14)),
+	PINCTRL_CONF_DESC(27, REG_GPIO_L_E4, BIT(15)),
+	PINCTRL_CONF_DESC(28, REG_GPIO_L_E4, BIT(16)),
+	PINCTRL_CONF_DESC(29, REG_GPIO_L_E4, BIT(17)),
+	PINCTRL_CONF_DESC(30, REG_GPIO_L_E4, BIT(18)),
+	PINCTRL_CONF_DESC(31, REG_GPIO_L_E4, BIT(19)),
+	PINCTRL_CONF_DESC(32, REG_GPIO_L_E4, BIT(20)),
+	PINCTRL_CONF_DESC(33, REG_GPIO_L_E4, BIT(21)),
+	PINCTRL_CONF_DESC(34, REG_GPIO_L_E4, BIT(22)),
+	PINCTRL_CONF_DESC(35, REG_GPIO_L_E4, BIT(23)),
+	PINCTRL_CONF_DESC(36, REG_GPIO_L_E4, BIT(24)),
+	PINCTRL_CONF_DESC(37, REG_GPIO_L_E4, BIT(25)),
+	PINCTRL_CONF_DESC(38, REG_GPIO_L_E4, BIT(26)),
+	PINCTRL_CONF_DESC(39, REG_GPIO_L_E4, BIT(27)),
+	PINCTRL_CONF_DESC(40, REG_GPIO_L_E4, BIT(28)),
+	PINCTRL_CONF_DESC(41, REG_GPIO_L_E4, BIT(29)),
+};
+
+static const struct airoha_pinctrl_conf pinctrl_pcie_rst_od_conf[] = {
+	PINCTRL_CONF_DESC(40, REG_PCIE_RESET_OD, PCIE0_RESET_OD_MASK),
+	PINCTRL_CONF_DESC(41, REG_PCIE_RESET_OD, PCIE1_RESET_OD_MASK),
+};
+
+static const struct airoha_pinctrl_func_group pon_func_group[] = {
+	{
+		.name = "pon",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_GPIO_PON_MODE,
+			       GPIO_PON_MODE_MASK, GPIO_PON_MODE_MASK },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group tod_1pps_func_group[] = {
+	{
+		.name = "pon_tod_1pps",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_GPIO_2ND_I2C_MODE,
+			       PON_TOD_1PPS_MODE_MASK, PON_TOD_1PPS_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "gsw_tod_1pps",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_GPIO_2ND_I2C_MODE,
+			       GSW_TOD_1PPS_MODE_MASK, GSW_TOD_1PPS_MODE_MASK },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group sipo_func_group[] = {
+	{
+		.name = "sipo",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_GPIO_PON_MODE,
+			       GPIO_SIPO_MODE_MASK | SIPO_RCLK_MODE_MASK,
+			       GPIO_SIPO_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "sipo_rclk",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_GPIO_PON_MODE,
+			       GPIO_SIPO_MODE_MASK | SIPO_RCLK_MODE_MASK,
+			       GPIO_SIPO_MODE_MASK | SIPO_RCLK_MODE_MASK },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group mdio_func_group[] = {
+	{
+		.name = "mdio",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_GPIO_PON_MODE,
+			       GPIO_SGMII_MDIO_MODE_MASK,
+			       GPIO_SGMII_MDIO_MODE_MASK },
+		.regmap[1] = { AIROHA_FUNC_MUX, EN7523_REG_GPIO_SPI_CS1_MODE,
+			       GPIO_MDC_IO_MASTER_MODE_MODE,
+			       GPIO_MDC_IO_MASTER_MODE_MODE },
+		.regmap_size = 2,
+	},
+};
+
+static const struct airoha_pinctrl_func_group uart_func_group[] = {
+	{
+		.name = "uart2",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_GPIO_PON_MODE,
+			       GPIO_UART2_MODE_MASK, GPIO_UART2_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "npu_uart",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_NPU_UART_EN,
+			       NPU_UART_EN_MASK, NPU_UART_EN_MASK },
+		.regmap_size = 1,
+	}
+};
+
+static const struct airoha_pinctrl_func_group i2c_func_group[] = {
+	{
+		.name = "i2c1",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_GPIO_2ND_I2C_MODE,
+			       GPIO_2ND_I2C_MODE_MASK, GPIO_2ND_I2C_MODE_MASK },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group jtag_func_group[] = {
+	{
+		.name = "jtag_udi",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_NPU_UART_EN,
+			       JTAG_UDI_EN_MASK, JTAG_UDI_EN_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "jtag_dfd",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_NPU_UART_EN,
+			       JTAG_DFD_EN_MASK, JTAG_DFD_EN_MASK },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group pcm_func_group[] = {
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
+};
+
+static const struct airoha_pinctrl_func_group spi_func_group[] = {
+	{
+		.name = "spi_quad",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_GPIO_SPI_CS1_MODE,
+			       GPIO_SPI_QUAD_MODE_MASK,
+			       GPIO_SPI_QUAD_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "spi_cs1",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_GPIO_SPI_CS1_MODE,
+			       GPIO_SPI_CS1_MODE_MASK, GPIO_SPI_CS1_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "spi_cs2",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_GPIO_SPI_CS1_MODE,
+			       GPIO_SPI_CS2_MODE_MASK, GPIO_SPI_CS2_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "spi_cs3",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_GPIO_SPI_CS1_MODE,
+			       GPIO_SPI_CS3_MODE_MASK, GPIO_SPI_CS3_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "spi_cs4",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_GPIO_SPI_CS1_MODE,
+			       GPIO_SPI_CS4_MODE_MASK, GPIO_SPI_CS4_MODE_MASK },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group pcm_spi_func_group[] = {
+	{
+		.name = "pcm_spi",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_GPIO_SPI_CS1_MODE,
+			       GPIO_PCM_SPI_MODE_MASK, GPIO_PCM_SPI_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "pcm_spi_int",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_GPIO_SPI_CS1_MODE,
+			       GPIO_PCM_INT_MODE_MASK, GPIO_PCM_INT_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "pcm_spi_rst",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_GPIO_SPI_CS1_MODE,
+			       GPIO_PCM_RESET_MODE_MASK,
+			       GPIO_PCM_RESET_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "pcm_spi_cs1",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_GPIO_SPI_CS1_MODE,
+			       GPIO_PCM_SPI_CS1_MODE_MASK,
+			       GPIO_PCM_SPI_CS1_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "pcm_spi_cs2",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_GPIO_SPI_CS1_MODE,
+			       AN7583_GPIO_PCM_SPI_CS2_MODE_MASK,
+			       AN7583_GPIO_PCM_SPI_CS2_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "pcm_spi_cs3",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_GPIO_SPI_CS1_MODE,
+			       GPIO_PCM_SPI_CS3_MODE_MASK,
+			       GPIO_PCM_SPI_CS3_MODE_MASK },
+		.regmap_size = 1,
+	},
+	{
+		.name = "pcm_spi_cs4",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_GPIO_SPI_CS1_MODE,
+			       GPIO_PCM_SPI_CS4_MODE_MASK,
+			       GPIO_PCM_SPI_CS4_MODE_MASK },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group i2s_func_group[] = {
+	{
+		.name = "i2s",
+		.regmap[0] = { AIROHA_FUNC_MUX, EN7523_REG_GPIO_2ND_I2C_MODE,
+			       GPIO_I2S_MODE_MASK, GPIO_I2S_MODE_MASK },
+		.regmap_size = 1,
+	},
+};
+
+static const struct airoha_pinctrl_func_group pcie_reset_func_group[] = {
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
+};
+
+static const struct airoha_pinctrl_func_group phy1_led0_func_group[] = {
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
+static const struct airoha_pinctrl_func_group phy2_led0_func_group[] = {
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
+static const struct airoha_pinctrl_func_group phy3_led0_func_group[] = {
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
+static const struct airoha_pinctrl_func_group phy4_led0_func_group[] = {
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
+static const struct airoha_pinctrl_func_group phy1_led1_func_group[] = {
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
+static const struct airoha_pinctrl_func_group phy2_led1_func_group[] = {
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
+static const struct airoha_pinctrl_func_group phy3_led1_func_group[] = {
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
+static const struct airoha_pinctrl_func_group phy4_led1_func_group[] = {
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
+static const struct pingroup pinctrl_groups[] = {
+	PINCTRL_PIN_GROUP("pon", pon),
+	PINCTRL_PIN_GROUP("pon_tod_1pps", pon_tod_1pps),
+	PINCTRL_PIN_GROUP("gsw_tod_1pps", gsw_tod_1pps),
+	PINCTRL_PIN_GROUP("sipo", sipo),
+	PINCTRL_PIN_GROUP("sipo_rclk", sipo_rclk),
+	PINCTRL_PIN_GROUP("mdio", mdio),
+	PINCTRL_PIN_GROUP("uart2", uart2),
+	PINCTRL_PIN_GROUP("npu_uart", npu_uart),
+	PINCTRL_PIN_GROUP("i2c0", i2c0),
+	PINCTRL_PIN_GROUP("i2c1", i2c1),
+	PINCTRL_PIN_GROUP("jtag_udi", jtag_udi),
+	PINCTRL_PIN_GROUP("jtag_dfd", jtag_dfd),
+	PINCTRL_PIN_GROUP("i2s", i2s),
+	PINCTRL_PIN_GROUP("pcm1", pcm1),
+	PINCTRL_PIN_GROUP("pcm2", pcm2),
+	PINCTRL_PIN_GROUP("spi", spi),
+	PINCTRL_PIN_GROUP("spi_quad", spi_quad),
+	PINCTRL_PIN_GROUP("spi_cs1", spi_cs1),
+	PINCTRL_PIN_GROUP("pcm_spi", pcm_spi),
+	PINCTRL_PIN_GROUP("pcm_spi_int", pcm_spi_int),
+	PINCTRL_PIN_GROUP("pcm_spi_rst", pcm_spi_rst),
+	PINCTRL_PIN_GROUP("pcm_spi_cs1", pcm_spi_cs1),
+	PINCTRL_PIN_GROUP("pcm_spi_cs2", pcm_spi_cs2),
+	PINCTRL_PIN_GROUP("pcm_spi_cs3", pcm_spi_cs3),
+	PINCTRL_PIN_GROUP("pcm_spi_cs4", pcm_spi_cs4),
+	PINCTRL_PIN_GROUP("gpio0", gpio0),
+	PINCTRL_PIN_GROUP("gpio1", gpio1),
+	PINCTRL_PIN_GROUP("gpio2", gpio2),
+	PINCTRL_PIN_GROUP("gpio3", gpio3),
+	PINCTRL_PIN_GROUP("gpio4", gpio4),
+	PINCTRL_PIN_GROUP("gpio5", gpio5),
+	PINCTRL_PIN_GROUP("gpio6", gpio6),
+	PINCTRL_PIN_GROUP("gpio7", gpio7),
+	PINCTRL_PIN_GROUP("gpio8", gpio8),
+	PINCTRL_PIN_GROUP("gpio9", gpio9),
+	PINCTRL_PIN_GROUP("gpio10", gpio10),
+	PINCTRL_PIN_GROUP("gpio11", gpio11),
+	PINCTRL_PIN_GROUP("gpio12", gpio12),
+	PINCTRL_PIN_GROUP("gpio13", gpio13),
+	PINCTRL_PIN_GROUP("gpio14", gpio14),
+	PINCTRL_PIN_GROUP("gpio15", gpio15),
+	PINCTRL_PIN_GROUP("gpio16", gpio16),
+	PINCTRL_PIN_GROUP("gpio17", gpio17),
+	PINCTRL_PIN_GROUP("gpio18", gpio18),
+	PINCTRL_PIN_GROUP("gpio19", gpio19),
+	PINCTRL_PIN_GROUP("gpio20", gpio20),
+	PINCTRL_PIN_GROUP("gpio21", gpio21),
+	PINCTRL_PIN_GROUP("gpio22", gpio22),
+	PINCTRL_PIN_GROUP("gpio23", gpio23),
+	PINCTRL_PIN_GROUP("gpio24", gpio24),
+	PINCTRL_PIN_GROUP("gpio25", gpio25),
+	PINCTRL_PIN_GROUP("gpio26", gpio26),
+	PINCTRL_PIN_GROUP("gpio27", gpio27),
+	PINCTRL_PIN_GROUP("pcie_reset0", pcie_reset0),
+	PINCTRL_PIN_GROUP("pcie_reset1", pcie_reset1),
+};
+
+static const struct airoha_pinctrl_func pinctrl_funcs[] = {
+	PINCTRL_FUNC_DESC("pon", pon),
+	PINCTRL_FUNC_DESC("tod_1pps", tod_1pps),
+	PINCTRL_FUNC_DESC("sipo", sipo),
+	PINCTRL_FUNC_DESC("mdio", mdio),
+	PINCTRL_FUNC_DESC("uart", uart),
+	PINCTRL_FUNC_DESC("i2c", i2c),
+	PINCTRL_FUNC_DESC("jtag", jtag),
+	PINCTRL_FUNC_DESC("pcm", pcm),
+	PINCTRL_FUNC_DESC("spi", spi),
+	PINCTRL_FUNC_DESC("pcm_spi", pcm_spi),
+	PINCTRL_FUNC_DESC("i2s", i2s),
+	PINCTRL_FUNC_DESC("pcie_reset", pcie_reset),
+	PINCTRL_FUNC_DESC("pwm", pwm),
+	PINCTRL_FUNC_DESC("phy1_led0", phy1_led0),
+	PINCTRL_FUNC_DESC("phy1_led1", phy1_led1),
+	PINCTRL_FUNC_DESC("phy2_led0", phy2_led0),
+	PINCTRL_FUNC_DESC("phy2_led1", phy2_led1),
+	PINCTRL_FUNC_DESC("phy3_led0", phy3_led0),
+	PINCTRL_FUNC_DESC("phy3_led1", phy3_led1),
+	PINCTRL_FUNC_DESC("phy4_led0", phy4_led0),
+	PINCTRL_FUNC_DESC("phy4_led1", phy4_led1),
+};
+
+static const struct airoha_pinctrl_conf pinctrl_pullup_conf[] = {
+	PINCTRL_CONF_DESC(12, REG_GPIO_L_PU, BIT(0)),
+	PINCTRL_CONF_DESC(13, REG_GPIO_L_PU, BIT(1)),
+	PINCTRL_CONF_DESC(14, REG_GPIO_L_PU, BIT(2)),
+	PINCTRL_CONF_DESC(15, REG_GPIO_L_PU, BIT(3)),
+	PINCTRL_CONF_DESC(16, REG_GPIO_L_PU, BIT(4)),
+	PINCTRL_CONF_DESC(17, REG_GPIO_L_PU, BIT(5)),
+	PINCTRL_CONF_DESC(18, REG_GPIO_L_PU, BIT(6)),
+	PINCTRL_CONF_DESC(19, REG_GPIO_L_PU, BIT(7)),
+	PINCTRL_CONF_DESC(20, REG_GPIO_L_PU, BIT(8)),
+	PINCTRL_CONF_DESC(21, REG_GPIO_L_PU, BIT(9)),
+	PINCTRL_CONF_DESC(22, REG_GPIO_L_PU, BIT(10)),
+	PINCTRL_CONF_DESC(23, REG_GPIO_L_PU, BIT(11)),
+	PINCTRL_CONF_DESC(24, REG_GPIO_L_PU, BIT(12)),
+	PINCTRL_CONF_DESC(25, REG_GPIO_L_PU, BIT(13)),
+	PINCTRL_CONF_DESC(26, REG_GPIO_L_PU, BIT(14)),
+	PINCTRL_CONF_DESC(27, REG_GPIO_L_PU, BIT(15)),
+	PINCTRL_CONF_DESC(28, REG_GPIO_L_PU, BIT(16)),
+	PINCTRL_CONF_DESC(29, REG_GPIO_L_PU, BIT(17)),
+	PINCTRL_CONF_DESC(30, REG_GPIO_L_PU, BIT(18)),
+	PINCTRL_CONF_DESC(31, REG_GPIO_L_PU, BIT(19)),
+	PINCTRL_CONF_DESC(32, REG_GPIO_L_PU, BIT(20)),
+	PINCTRL_CONF_DESC(33, REG_GPIO_L_PU, BIT(21)),
+	PINCTRL_CONF_DESC(34, REG_GPIO_L_PU, BIT(22)),
+	PINCTRL_CONF_DESC(35, REG_GPIO_L_PU, BIT(23)),
+	PINCTRL_CONF_DESC(36, REG_GPIO_L_PU, BIT(24)),
+	PINCTRL_CONF_DESC(37, REG_GPIO_L_PU, BIT(25)),
+	PINCTRL_CONF_DESC(38, REG_GPIO_L_PU, BIT(26)),
+	PINCTRL_CONF_DESC(39, REG_GPIO_L_PU, BIT(27)),
+	PINCTRL_CONF_DESC(40, REG_GPIO_L_PU, BIT(28)),
+	PINCTRL_CONF_DESC(41, REG_GPIO_L_PU, BIT(29)),
+};
+
+static const struct airoha_pinctrl_conf pinctrl_pulldown_conf[] = {
+	PINCTRL_CONF_DESC(12, REG_GPIO_L_PD, BIT(0)),
+	PINCTRL_CONF_DESC(13, REG_GPIO_L_PD, BIT(1)),
+	PINCTRL_CONF_DESC(14, REG_GPIO_L_PD, BIT(2)),
+	PINCTRL_CONF_DESC(15, REG_GPIO_L_PD, BIT(3)),
+	PINCTRL_CONF_DESC(16, REG_GPIO_L_PD, BIT(4)),
+	PINCTRL_CONF_DESC(17, REG_GPIO_L_PD, BIT(5)),
+	PINCTRL_CONF_DESC(18, REG_GPIO_L_PD, BIT(6)),
+	PINCTRL_CONF_DESC(19, REG_GPIO_L_PD, BIT(7)),
+	PINCTRL_CONF_DESC(20, REG_GPIO_L_PD, BIT(8)),
+	PINCTRL_CONF_DESC(21, REG_GPIO_L_PD, BIT(9)),
+	PINCTRL_CONF_DESC(22, REG_GPIO_L_PD, BIT(10)),
+	PINCTRL_CONF_DESC(23, REG_GPIO_L_PD, BIT(11)),
+	PINCTRL_CONF_DESC(24, REG_GPIO_L_PD, BIT(12)),
+	PINCTRL_CONF_DESC(25, REG_GPIO_L_PD, BIT(13)),
+	PINCTRL_CONF_DESC(26, REG_GPIO_L_PD, BIT(14)),
+	PINCTRL_CONF_DESC(27, REG_GPIO_L_PD, BIT(15)),
+	PINCTRL_CONF_DESC(28, REG_GPIO_L_PD, BIT(16)),
+	PINCTRL_CONF_DESC(29, REG_GPIO_L_PD, BIT(17)),
+	PINCTRL_CONF_DESC(30, REG_GPIO_L_PD, BIT(18)),
+	PINCTRL_CONF_DESC(31, REG_GPIO_L_PD, BIT(19)),
+	PINCTRL_CONF_DESC(32, REG_GPIO_L_PD, BIT(20)),
+	PINCTRL_CONF_DESC(33, REG_GPIO_L_PD, BIT(21)),
+	PINCTRL_CONF_DESC(34, REG_GPIO_L_PD, BIT(22)),
+	PINCTRL_CONF_DESC(35, REG_GPIO_L_PD, BIT(23)),
+	PINCTRL_CONF_DESC(36, REG_GPIO_L_PD, BIT(24)),
+	PINCTRL_CONF_DESC(37, REG_GPIO_L_PD, BIT(25)),
+	PINCTRL_CONF_DESC(38, REG_GPIO_L_PD, BIT(26)),
+	PINCTRL_CONF_DESC(39, REG_GPIO_L_PD, BIT(27)),
+	PINCTRL_CONF_DESC(40, REG_GPIO_L_PD, BIT(28)),
+	PINCTRL_CONF_DESC(41, REG_GPIO_L_PD, BIT(29)),
+};
+
+static const struct airoha_pinctrl_match_data pinctrl_match_data = {
+	.gpio_offs = 12,
+	.gpio_pin_cnt = 28,
+	.pins = pinctrl_pins,
+	.num_pins = ARRAY_SIZE(pinctrl_pins),
+	.grps = pinctrl_groups,
+	.num_grps = ARRAY_SIZE(pinctrl_groups),
+	.funcs = pinctrl_funcs,
+	.num_funcs = ARRAY_SIZE(pinctrl_funcs),
+	.confs_info = {
+		[AIROHA_PINCTRL_CONFS_PULLUP] = {
+			.confs = pinctrl_pullup_conf,
+			.num_confs = ARRAY_SIZE(pinctrl_pullup_conf),
+		},
+		[AIROHA_PINCTRL_CONFS_PULLDOWN] = {
+			.confs = pinctrl_pulldown_conf,
+			.num_confs = ARRAY_SIZE(pinctrl_pulldown_conf),
+		},
+		[AIROHA_PINCTRL_CONFS_DRIVE_E2] = {
+			.confs = pinctrl_drive_e2_conf,
+			.num_confs = ARRAY_SIZE(pinctrl_drive_e2_conf),
+		},
+		[AIROHA_PINCTRL_CONFS_DRIVE_E4] = {
+			.confs = pinctrl_drive_e4_conf,
+			.num_confs = ARRAY_SIZE(pinctrl_drive_e4_conf),
+		},
+		[AIROHA_PINCTRL_CONFS_PCIE_RST_OD] = {
+			.confs = pinctrl_pcie_rst_od_conf,
+			.num_confs = ARRAY_SIZE(pinctrl_pcie_rst_od_conf),
+		},
+	},
+};
+
+static const struct udevice_id pinctrl_of_match[] = {
+	{ .compatible = "airoha,en7523-pinctrl",
+	  .data = (uintptr_t)&pinctrl_match_data },
+	{ /* sentinel */ }
+};
+
+U_BOOT_DRIVER(airoha_en7523_pinctrl) = {
+	.name = "airoha-en7523-pinctrl",
+	.id = UCLASS_PINCTRL,
+	.of_match = of_match_ptr(pinctrl_of_match),
+	.probe = airoha_pinctrl_probe,
+	.bind = airoha_pinctrl_bind,
+	.priv_auto = sizeof(struct airoha_pinctrl),
+	.ops = &airoha_pinctrl_ops,
+};
-- 
2.53.0

