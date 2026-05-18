Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED889CD4F4A
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 23:52:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A38F846DD;
	Tue, 19 May 2026 01:51:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="UrtRTKZc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7FAC846F1; Tue, 19 May 2026 01:51:34 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF232846CE
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 01:51:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ra+jH3wz340t82ImCeInU4z+CUU0mEwF+ZK0q/UhYTYqCCPPmKYydGzwW8bsVLqRvg5YCd3REIQmALaWzkeBpGDCOqA/8IugQOSY+S74l4lPnRlNvGxKI2Fn6wSm2OnJo+g0742rAP/eWcmdZobhBpl6vLzGWa/sInUiF8mOBfgAvm4lgGnqS5Vc43cSjGK4IwYBfjJLIiBtcN+n8oJhcat+OUx53d5Uo+74NPj4gSHR4Jbs+2m+X/qyO3o3KdwXzOcME3Qy6F/g0GbIxpZ+fM4Bnc9a5QbhFxL++Xh5FINyHWlcV8hhJ7uotTabdn+hZVZoqftSrPVroGGQ7rq7Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwGtMN9Os7jyoHslScncDC+cMQd/0IbRVAK0rBi5rg0=;
 b=cPC0VgrVql4mGFtNhadeWrZ7qo6sd19b2ALBsRyD3SOVMXs3kAi7DF5Ig5IvsLahvN/LZcFYaMGVZYCdOmqkLUf5X4CDY9tzR6iAvGlxC3E7hIxGtgM6O+zsS9XxQAydRxQMXjJezKgcKvM7Ztqmy258NCoDW3XehKGgjr3aR1oaFEriXr5GhJYSIdCp8vvhTIev7CXd41oZU+FUTrGLhnS4/j3p1cpiVU762W7SnruAjBl0/hqLBWh08v9ywutpohZRv/ASCMjIxwLbTjsRTYOnhluA4kvt3VdvbHCXb8uYRw4DOptuxdpVAI/f+uaxa7I0nYeK9S7kJ19SwtC3Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwGtMN9Os7jyoHslScncDC+cMQd/0IbRVAK0rBi5rg0=;
 b=UrtRTKZc1WsHUbpEw+yxzpdrqsRI+c2TCZjBsM4Gpf0FPCfbUXhnNy3vzug8XKtQ0x3NPsPYgcndq1G1uAlaXGW402OY8SM8R6rQJsBIKY7yi8Xq0bxGOomrTY+WxRbMhFrIG1HOvAXriyUH8UAekO34YYhoM92+0dtdaMqScvS4dmq6SKlDW3vptnNG8DX28k9+wqCxqNgXU2n4OvTTzkvD1jeLT7jLUydIUA1n4yFppiiHBMxcMMwiSTORRBNPYk2REykR6iUc4rb1+TntisobZed9Q9iDXnzPkpGYB7KmWOvLT0yPHTDxq2455/jjzBK2reZwiEq+AcKNQBsXzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DB9PR08MB7794.eurprd08.prod.outlook.com (2603:10a6:10:399::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Mon, 18 May
 2026 23:51:31 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0025.020; Mon, 18 May 2026
 23:51:31 +0000
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
Subject: [PATCH v8 04/12] pinctrl: add more pinconf/pinctrl definitions
Date: Tue, 19 May 2026 02:51:07 +0300
Message-ID: <20260518235116.2664557-5-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 96d2341c-1388-4097-8db3-08deb5386284
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|52116014|22082099003|18002099003|56012099003|38350700014|921020|11063799003;
X-Microsoft-Antispam-Message-Info: HNKLiWfcKRVufCSMqoc7WL8D2QCLEiSihvThEZCr7bKCx6lQ4MUjshT47Oty3juLPrL7c+c9gPndCOH/m39FnL7i17jxocU8qYlLPppyBlZR9nTaiwq8hwFyWodNIqigL28Nswwbl6hnazuqewoEt+kewBG2Wy+p3AFtVU2+Yj17jfWa2LDIYr9S/QeLGeVQjdYmSjj3klxE0HQmAAU3mJteZ7xYvKXpunLwVsyIvEzGGIQBjjUQtGZz1vTGZR1mU9em9goXv1uNaH/6psMtf+CV0rkxo8A9i5THZqvMLHSCC5FXC2/xZ8mWtQ/VX2WtTXcgp2M1QYeD+xuHkX6zfa9ol8CBVYQ5Iww/N07QjdPidOMHTsmBsXj8IWWBsncmCfRQpTTH5DfpLBogUyuxtNTP9jvKkJlnixUIVVj0V7WKu2G0o/um4J0Yw8OVHjcV/FfRFW4Uk6JmLaw5UHshDO/JB2EQJbBrxoCnfCeqx3Z6M+i9vlqLWbbuljiPSIYUVR7LMFcNjnJecMG/L8UJqvdhJC8xumNgDZ1lqlG/MN0UmqkHPAPqtwIbgKFpwz9dgqAYCGnHhv8I24FoyE13v/42lGrJ8Sbui67uxIFhkbRR+q0NsYiTiwfVSkWwyqFLqnl6wpo96+x9Xq7LyWM48iY28NyX9P0nPusJOyY1ue6ZDYzT2ddfbwof5ky1PiUm/KmoulRJlZYRKCRhUCbIxILtGaFhIi9bF0eLdlHdHEHXTKX4cJEjG22XpsDIM9h0YXo1QN5X/MyqEvJ6nvMHRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(22082099003)(18002099003)(56012099003)(38350700014)(921020)(11063799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g/+gNmtweGtGYhxwIs2Pak0Fj07Iu5kWacHXSIT9vZwB9mfRZZfRRh3cywqf?=
 =?us-ascii?Q?LKoZYBT+Cn5Xnw0moZZQaiif8evsOOgUfD894inkDTP40Fug+zR+Yy9yxG1P?=
 =?us-ascii?Q?avMDYgvFZHfdGYfn5BH0QR5LIzdMZAfflKCMg0HtFCjOLxJBuMXhqFfPZZwP?=
 =?us-ascii?Q?MRatvnrkg7YueL8eE+eUicxQ8xnV5F1Q6f6xLUvGIpOxISBZwxXbt0BBG3JQ?=
 =?us-ascii?Q?bywXunSosHkAIYOqmwSW8LlRuP/rbFlypm/m7uSaB9I87U75G7sV9U0hFkc/?=
 =?us-ascii?Q?wAmuW+NPoBtNHY1BJWBPyFOSTzjRjY4ro6/e66TccGcKQavHLwc3BOp0b8jJ?=
 =?us-ascii?Q?SbtNEnBxuwPGW/F2RjAGr6JNfY24i9gKJmUpqE3miFOBUoPw0YFqNKZgIMGr?=
 =?us-ascii?Q?b8o13hw9Bnd3M5Dq16ranW0SdP/8iL/pldIB4f+SxkYJoxWEcy1inazY8Ybr?=
 =?us-ascii?Q?oGC6MNziSldJ6MYU0nA78tXAnbBY69713xVTMuhlQfN7cRwoqA6AoQ7rqjvS?=
 =?us-ascii?Q?dzmpbhdg+QCCjUn5fXxDyrbv+C2UJYYdA3PtYxfJJ8w0n+UETbpOR/qO+qd1?=
 =?us-ascii?Q?Zp8K0U/QT66EIVfxgtZnupDlF9W9jZNXXWBkkom5u7+2deIDMFGvtvVmqP+n?=
 =?us-ascii?Q?41W8Qg3ExjKA/15byWnO1Ah6Pefe3RHCcdEmWngyyL3s4mkZjTXtOT2rY074?=
 =?us-ascii?Q?bcQX1r5uR0Cl39GwBgV0DlY9aciXeFqa6lc7OAANK2IkP3z8Wk1psdl5LiUb?=
 =?us-ascii?Q?jBlDpOluW+MX2oQj06xLdvFLBqHcg/8TBF9H7R5OzLEYXpmSCK0M4PRU9NV/?=
 =?us-ascii?Q?aQBsBcexU2YnDeTd9pEl52hlzP8z9EmE4FUlKc4SG02aFkKYwqb9tpwI8XYD?=
 =?us-ascii?Q?jFGUpNY/sPyhovaTQt4C6FxQb33aWprEz7DRw7JwOhs5b8NgHTm+/vA5c432?=
 =?us-ascii?Q?lwRYBJIqi6i+5IsmzyxqKC7QCaHZaVwH3n1H7O+A1sZ2s+il2T68mV2bL07O?=
 =?us-ascii?Q?HOdI5omI1ddbv5sPzbQnpIlSGZD8YkDo0aJ1ik8OjtACGiS64K13AN0dzrqo?=
 =?us-ascii?Q?v3rGGqZyntPFE8Fd+gcxKdrEVpIt9j9A9Ff0unrPR9PlYKOBzUqlrqQaBPCo?=
 =?us-ascii?Q?G0gbC8+d2WqHui+t1etDdQn0N5oO8Vc8PWEF60Kyp4xQcG51Bm1s2j7FILu8?=
 =?us-ascii?Q?mZCMzujZGiUjT3J4AW1YW3OYfzkiffiHvKCQ0hGLwvTS0qdpLMviDuTlDF6A?=
 =?us-ascii?Q?enn6XZ/fDlH+B1wcF7Xwbye0d1KmdQm4F2ic+IfFQUUjCKFlKyUddkJGVr10?=
 =?us-ascii?Q?9NvAW0oZcNQR0XMuF7tg8wH2Io9Gr+2IWFSo0dSVj80wDWU9r4GjgjXZiKxL?=
 =?us-ascii?Q?Ig4+HbEYUQmDBS1WagiXscQulh9cLE0roH7dQbCRtfGTlZSMwBTJ/znqCCcI?=
 =?us-ascii?Q?8EoOsbZaKO+IqJsI5fq7JY4ZXYKP1WCetwISYWsql9WSrDRQnPvzZyHSKDTl?=
 =?us-ascii?Q?zs3N0DCqOCMmrvvx2zfGa9ZOxHMQGxVIBqGhPBJHzYQDur/5/cSAbWPxuqDg?=
 =?us-ascii?Q?Q3WsearKL+H7m+gvtIqMM5ImBK3l5+92mZhLSHFUoRzVmrbTveWmmJI89v5H?=
 =?us-ascii?Q?ZsUegfgGDoo05xpQ/kD91ucyRksY3ZCNrh0MknLLrIUgLO60ughlAvarWW5n?=
 =?us-ascii?Q?1yLqkEeD4rjuZxLTahPkPQ4CQq3hk9q7YoV2qcv4Ly1PDctAv5q63HgP9Zyo?=
 =?us-ascii?Q?mtw/DsZBteHgI7YQ5yG9KzqaxMUAgVI=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d2341c-1388-4097-8db3-08deb5386284
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 23:51:31.0053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NjvVNmcp3s8Lmte2Eh4efu6Wjn6U39Vqj5o2PFLBenEFyZmgGQBkqpu+oH2qRb9tP8TLZpXxf6+vyvOmDKZDTRKa7WWXf08BbT7qUBVNtQY=
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

These pinconf/pinctrl definitions will be used by the next patches.

The definitions was taken from public headers of linux-7.0. It's used
by several linux pinctrl drivers, so it might be helpful for U-Boot as
well.

Pinconf definitions are placed near the corresponding U-Boot definitions
in file include/dm/pinctrl.h. Pin/group/function definitions stored within
the same path as in linux (include/linux/pinctrl/pinctrl.h).

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
 include/dm/pinctrl.h            | 28 +++++++++++++
 include/linux/pinctrl/pinctrl.h | 74 +++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+)
 create mode 100644 include/linux/pinctrl/pinctrl.h

diff --git a/include/dm/pinctrl.h b/include/dm/pinctrl.h
index e41baea6200..36db47802c7 100644
--- a/include/dm/pinctrl.h
+++ b/include/dm/pinctrl.h
@@ -481,6 +481,34 @@ enum pin_config_param {
 	PIN_CONFIG_MAX = 255, /* 0xFF */
 };
 
+/*
+ * Helpful configuration macro to be used in tables etc.
+ */
+#define PIN_CONF_PACKED(p, a) ((a << 8) | ((unsigned long) p & 0xffUL))
+
+/*
+ * The following inlines stuffs a configuration parameter and data value
+ * into and out of an unsigned long argument, as used by the generic pin config
+ * system. We put the parameter in the lower 8 bits and the argument in the
+ * upper 24 bits.
+ */
+
+static inline enum pin_config_param pinconf_to_config_param(unsigned long config)
+{
+	return (enum pin_config_param) (config & 0xffUL);
+}
+
+static inline u32 pinconf_to_config_argument(unsigned long config)
+{
+	return (u32) ((config >> 8) & 0xffffffUL);
+}
+
+static inline unsigned long pinconf_to_config_packed(enum pin_config_param param,
+			     u32 argument)
+{
+	return PIN_CONF_PACKED(param, argument);
+}
+
 #if CONFIG_IS_ENABLED(PINCTRL_GENERIC)
 /**
  * pinctrl_generic_set_state() - Generic set_state operation
diff --git a/include/linux/pinctrl/pinctrl.h b/include/linux/pinctrl/pinctrl.h
new file mode 100644
index 00000000000..32b56e0ab18
--- /dev/null
+++ b/include/linux/pinctrl/pinctrl.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __LINUX_PINCTRL_PINCTRL_H
+#define __LINUX_PINCTRL_PINCTRL_H
+
+#include <linux/types.h>
+
+/**
+ * struct pingroup - provides information on pingroup
+ * @name: a name for pingroup
+ * @pins: an array of pins in the pingroup
+ * @npins: number of pins in the pingroup
+ */
+struct pingroup {
+	const char *name;
+	const unsigned int *pins;
+	size_t npins;
+};
+
+/* Convenience macro to define a single named or anonymous pingroup */
+#define PINCTRL_PINGROUP(_name, _pins, _npins)	\
+(struct pingroup) {				\
+	.name = _name,				\
+	.pins = _pins,				\
+	.npins = _npins,			\
+}
+
+/**
+ * struct pinctrl_pin_desc - boards/machines provide information on their
+ * pins, pads or other muxable units in this struct
+ * @number: unique pin number from the global pin number space
+ * @name: a name for this pin
+ * @drv_data: driver-defined per-pin data. pinctrl core does not touch this
+ */
+struct pinctrl_pin_desc {
+	unsigned int number;
+	const char *name;
+	void *drv_data;
+};
+
+/* Convenience macro to define a single named or anonymous pin descriptor */
+#define PINCTRL_PIN(_number, _name)		\
+(struct pinctrl_pin_desc) {			\
+	.number = _number,			\
+	.name = _name,				\
+}
+
+#define PINCTRL_PIN_ANON(_number)		\
+(struct pinctrl_pin_desc) {			\
+	.number = _number,			\
+}
+
+/**
+ * struct pinfunction - Description about a function
+ * @name: Name of the function
+ * @groups: An array of groups for this function
+ * @ngroups: Number of groups in @groups
+ * @flags: Additional pin function flags
+ */
+struct pinfunction {
+	const char *name;
+	const char * const *groups;
+	size_t ngroups;
+};
+
+/* Convenience macro to define a single named pinfunction */
+#define PINCTRL_PINFUNCTION(_name, _groups, _ngroups)	\
+(struct pinfunction) {					\
+	.name = (_name),				\
+	.groups = (_groups),				\
+	.ngroups = (_ngroups),				\
+}
+
+#endif /* __LINUX_PINCTRL_PINCTRL_H */
-- 
2.53.0

