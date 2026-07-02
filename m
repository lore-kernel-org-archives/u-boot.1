Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4F2C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 05:59:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AAFF84CA4;
	Thu,  2 Jul 2026 07:58:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="fAXD5xrF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8226184C9A; Thu,  2 Jul 2026 07:58:24 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85AB084C6D
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 07:58:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e17BMy9dpSSTW7ZFbAQpkkyfHE0PHlDnjIDMOI/go5cdar5+yaPkOyyAsinQJ31Nli/1P0XhceK2IEdasXJg+T9IO4LO56gwDf0HISsGBkeeU7njYBU4s6KScPka0N2+GYkju5LakExTqauRC+ZqDTtVOLV0Pl/S7TJlLB9zeLjALR6UppFTvdcBnzIiDB8UlmtTzG5xXYpO7KAt19AMzksQrBAJG1YgNAvlRy96N1OC8FMueGRqLjgIlNCy9r1u1FZL59TPCKnZ4C3X2De9rftNbJW4oEaKItq4NdZaUh28JTufGyByxVgFo4Lh6RuJsEdsXUDnHMHT/BlG9DKTLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwGtMN9Os7jyoHslScncDC+cMQd/0IbRVAK0rBi5rg0=;
 b=R/pNOd39rONJ4c0ThORHPbFtWUiNF+kjzVbbTF0z4npKN7vNfyrlyOnmbl/bHgJiIclXMCddipwILBMbVkMzmu2BJIsF7CCNOU19cTnxMmAupGhS7HU39G9eH6E9J+ZbFbSWbV3oCrsam3D7NMfuVyvyHKKpPUv2+pYSuOvd6mnG8rD0Oil1lMaxzO+wi4n5C6/8cKgGx31uk1WRBJcCVM4ECwrutpoJwpwayRfTM9gDBjKMV9ACP3hbolnJI3u269RSknXuhnBXcunet03Ua98v63l1kZ/S6VDGQ3R8uvauYmFo5+LrRt6AaLkozlKOVN8Bf+G4xocDaXAdsxYU4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwGtMN9Os7jyoHslScncDC+cMQd/0IbRVAK0rBi5rg0=;
 b=fAXD5xrFjP0UP1kmXLobr8auPcBWJY8ldP2mT111xPKOd1UUavUdT7xoya7CJY5gn0KuGDcH4nx81SENf4QJlX2n081ZPlZkiPxR65Cq3pZQOIjsAPHl4VXZkbQtZ2OBzeqE88Tl7ODBRuNnO56xejxl+LrQNf6xGh9QY70mr/2e/5IkVrDnJfSNbQojfWsBEip3FvSHKLLy+uTwl1j40DXSjMIYD9cbOJuA8ijw2TL/ipXmJVZvUpN2BVbDaZBwbrdRoqE9+z1LjVfU1NV+iDUmZJ38jmchADM5sDYXHNSeD0RDMk0jHAzs3o3Z/KAongZnDv4xNwRKo1+JpblRyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DBBPR08MB10433.eurprd08.prod.outlook.com (2603:10a6:10:52f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Thu, 2 Jul 2026
 05:58:20 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0159.018; Thu, 2 Jul 2026
 05:58:20 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Stefan Roese <stefan.roese@mailbox.org>, Simon Glass <sjg@chromium.org>,
 David Lechner <dlechner@baylibre.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v14 10/18] pinctrl: add more pinconf/pinctrl definitions
Date: Thu,  2 Jul 2026 08:57:36 +0300
Message-ID: <20260702055744.2164975-11-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702055744.2164975-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260702055744.2164975-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::16) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DBBPR08MB10433:EE_
X-MS-Office365-Filtering-Correlation-Id: 5712dffb-1752-4585-3f23-08ded7feeb59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|1800799024|23010399003|366016|921020|38350700014|11063799006|18002099003|22082099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: 9Fc23+DK9L9u+9F6PATk3fM5ngpfxPKAXQqW0i6aOZLpdmnjNyz8WZr3iv3QLSpmrW0mWfgESAc3BQZgthJ791EpDLN26O6qdOtWHrehxajwKOqBgXLerwodsvnjdc+nUUR/7yd/P5cWuypXpGC1cfnn6El5P7aXu3zZAZpKbqE2o/TeaItJzKrbqYxllDKI3877kkU8yBqwK5FHVer4CJ3mk44RVcV9nhWarGoJycAG27X3evdkSkZ7yEblahMWv4f6pHOvzWxUSxEK0xlss6MT93vN4z3JFkpJY3t7o2rCHxkeDrrQNaSm4hQN+kXxTegfLSB2aAilCUqHzf84kzL3mKNn6eqSTOWxminLSaXw4YZBzo+EY0A9bTMAKGj2nmW/Mn5Dt24DUh6GnjMAjuv7bhLRQQo16CGUk74iyXkEC/9dk7rjVFsEwV6Tv5JBCHXDk2wg4b5J3BAR+kSK1rdQRMyGpOa8YcU6mXRQ9iuGLcDo+xwpjHGnJh3c8bZNRDnMq3ux1/Tumrn3CJRDQZpoxA0yV7yDm9DJm3EfSwEkXfSOnnZwP2gqYYeE1OfoQu35RuhBOAJBYPL5oZo4MYOPM3YoVy8MZlEuh7Ru48tUlN8OgAQpdOUq4mohKgE0E6TbPmiBvc6/rMCZCVCC5e+Q8WB9Fy9VPwTerfuLMHZnNGVTB9pIhyPnELFvEC3eY9Jg7SMl+whpvqQVRgWWV0cGS5VTSE37f9U+eZjm0oPCOjxxL2HDjUEdeL7/B07W
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(23010399003)(366016)(921020)(38350700014)(11063799006)(18002099003)(22082099003)(56012099006)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3g2IdoBnzizLF5Wl0J1nEBS3CuBG2/ahgYRngCHkHSQrKdkvosSQgeGYtaqS?=
 =?us-ascii?Q?M9G1mOwh7ZUocIrdcByF2CBSsCWPdJ21QoXah5zvks0on+cIMUP1nEZz89ir?=
 =?us-ascii?Q?9m+zAnaW7Rpe+JTZUgKgiBgYgDuGFkL36Nj+/VMABUmemWVcDYIqk73enDt7?=
 =?us-ascii?Q?2HW8CYc4K8JSLjd3lNRNUoC3KAer3zuTsTkDiBpHzMSPioyzlWZkqGqLco1D?=
 =?us-ascii?Q?8QzSDBlIH7o+lPayeCmg6cMkERGtGME4CX2soqEmu4MJ1XFCk66Q6TC6VV5m?=
 =?us-ascii?Q?w5PA1jlNHUytnqrBqKjV8YjPu8pN/RywlY1kSDOhDtL8PMezLYsMTXaI6sNa?=
 =?us-ascii?Q?ka9uO4AhExzYmXe3wP59grO8lbcgrQNP6ZhAh87MiJjSPU2qOaxTOdOCGxfm?=
 =?us-ascii?Q?oDJAlFgqDK27C3xlqE3zzYrmiQa1GN13+iZehu9gdnJAmbxSuynPjkP7ffHC?=
 =?us-ascii?Q?LwTdqjGUKN5DYrboZjnz/Kw1ng+WPjEjwFSFOtW+/mt8gy7r7SOkgHQerSUP?=
 =?us-ascii?Q?SAUkR45mTp+tpKLdmCqXqwYFz8AY0ozIa5wLeDySk6Yq49ngQtmm8h6fg/+M?=
 =?us-ascii?Q?9XqJwr8s896q3IXHkwlzhxMJmMPUrcHBLDSUln2JfPFA+q4/GoFEXzpGwJ+2?=
 =?us-ascii?Q?dIE9XXx35NDDg/0NZHdWemYAfPRQ7WdtieOp/QZAgnoZAPMw/2Q9ztCM9Dy3?=
 =?us-ascii?Q?qukB9YdL6fjnHKqBSlQjJVM8ozbD/Fkk/8Drit4/AWApyugiSNIiVZHrjPjD?=
 =?us-ascii?Q?fh+OOvdFQXaRrDuqIjvmJwAj7ny28hH6d3QSlshOKYi5dbcukrsvi8440zSx?=
 =?us-ascii?Q?z8r5Lj3sESXpqHwXH+GXnBSDNXyJhd7auBtaIdEvQcWKnAwEDLVf7iK5Wm0j?=
 =?us-ascii?Q?e2ilKUHRRiPS6mhB7Zfo+xrQWIlFiTtF21HwLgUNzozbiFsE3dhyRxQKLHz5?=
 =?us-ascii?Q?72r6s3RktwKeIkzv/1sYT6Av7DehYDl40D6bfcKVmfvcO4fm7zVfCSFTv1Yq?=
 =?us-ascii?Q?VUD3MFo4lBvXxnOtdGbgpOBwuA/VD9UyMVy4My03KdHzUN+/vKVDAvPisQrI?=
 =?us-ascii?Q?aUap1cs9jLZFzaM5VyxFi8A/VBDFmJxz01Qs9KDaKymxhJb+GU+p6l0Hmwzi?=
 =?us-ascii?Q?DbHKKCU3Qs2U9kMftfJ+eEbZvmh9wN/3vd0A7cH4hYr2zn1i5Tco6R9Da/UY?=
 =?us-ascii?Q?5V+AtRrf9vqrYi5V/CAbvxzyXRRBZyaOJf34vvYU4D6MDx6+Znuz1dQwzwLh?=
 =?us-ascii?Q?+rI1zYORYnT4xC80pLxnlL6J7txqjRr488a/PLXMIXbCYJE+qvFBGcSgzck5?=
 =?us-ascii?Q?0tpzQmfT19t07+p8Gwy3b/fX/DVFei2pzBL8olipzzC48hpGlit0Wgwjo8cO?=
 =?us-ascii?Q?GxNsK4U3FpekiYRA+ISahuGkIOeIJOWDQrhMR8h1bJDyQajVFHXDkiEXov6L?=
 =?us-ascii?Q?f0qboej3ilubnZ38fvGt+AaMX9bTOpfZ1awfM0t9/CRl7o5E2JDCT2WpOw39?=
 =?us-ascii?Q?kezMqXLdU4djchYLQx3dBnu0VA6Nbus65CJXRUlQuQDjJH60/hdJNTHfTVAx?=
 =?us-ascii?Q?4Vyjvi46plS2sEtdimc6n1iYqVU0zip0uyKZwqh7svh4xPkPoc+trD1JwN/Z?=
 =?us-ascii?Q?Ctf468ByAE2JtiYfM0WCtX+NYxg43zrNFTpPVUAKtFshXY25Ju8riEn0CiqW?=
 =?us-ascii?Q?oLHKFFYLsUSWKgUKXqNjuSFkERgctVOMtpzdB7oxhoxL2S5YdkFetzNXvlOJ?=
 =?us-ascii?Q?utczgt7ZwmGWFwpIW5fMjo9qegDHVLo=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5712dffb-1752-4585-3f23-08ded7feeb59
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 05:58:20.4958 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: thvYN9bb2rtQV9anR4ezmZEajMKp9wnmnf/DJTJzpohJwPPuw1vKQgWzasqfV86iOOkfof9IcYF0iIeBYC9rG4xt6VjVh/ZzhtDajWDNgl8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10433
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

