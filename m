Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE2ACD4F21
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 02:56:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EB14846C6;
	Thu, 14 May 2026 04:56:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="Q8gwZR14";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCCE7846C1; Thu, 14 May 2026 04:56:06 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4210F846BD
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 04:56:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eec+3o98nfRCLXxCcjW3rSN6iCM3LuMNGbvnI6cU6SxmObvJjwsapPfbbXspYYLujEJatTRYcGDWrW+GHZ8NvHoH7ImZNgs2QZPq5lJX5Rq8AzrKWSMYIdQC9LQnt36tWL0eb0omxVrsWm99s2sFApzYz1n4Xr5GPYtR1JleOWURUuHImvd0gxu7x0RkSh1NsNriNufpf9RY/XSIgZl2O6DsWt9nbf5QMESsk7Rx8OkqBI7Z5PeTwIxWYk5F6BHF9C+xG11yxWGY97uOxm+przX7juQSaVX6HLdNZABW0pvOq/48fpJ59v2xfF9YEVnrvNWio6vJwcgBpY/WqBSvJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwGtMN9Os7jyoHslScncDC+cMQd/0IbRVAK0rBi5rg0=;
 b=mO1viI7tNsuPFyW499gjCSUreEb1UqBJM65+CAZsKb0P2lRfl3t+J0lsKTdoywmFXwU7BG9IafuaVTQrcIkWrFcnemUl6wCt93bGSfrhhAsP8lB2PDhNp50Le4Tu1gHQwlp5n3qVTCaUKjJ3UTBmOXtSXbJ+Rvlx5J6zftSL3aB1MXAhGuAVbKpCFR4VCWhIXlR7kGIYr60vRIAYpkBh7+0N6F1QGTuQcTLStXYHgG0zBbG2KGTczysiy04S7f9nHWAaAInU82JRBBcDPpgUuUGn4EgOIsqZwRN15Lhcne2HyAfXLIn111d5GJtfk9y9rAOd0jHGbkuqoqXThbZ+Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwGtMN9Os7jyoHslScncDC+cMQd/0IbRVAK0rBi5rg0=;
 b=Q8gwZR14nh5ov7RYhuYFFomP7G1Xfio3/PIifbj9lhwzXY7BGgTQQko79i31S++JFlptgjZnXYIERfi56StgkY1lmjCUh4UgCadag+vaxy9GKHezZyBMedcV3jSQh4KCaLgWYDC84DR8T9+ZIDtrOO/P2i36nR+hDvNk1jPIj39pNAxzjBu+Q0z1624m4MQU0c6VqndD5UiIKdo7l2YrbdMzLYgSiRZyZpwWdFo7pudsWpahpjbto20aKwxz1zs225hKai2ARt97bmvNqJzbnfDicuC89iXsFVNvkI8BuubuMEmEi4vlvD6DA4Y8XZRmkFGHdC2b0wB8f6QCkPwrzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PR3PR08MB5786.eurprd08.prod.outlook.com (2603:10a6:102:85::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Thu, 14 May
 2026 02:56:01 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 02:56:01 +0000
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
Subject: [PATCH v6 04/12] pinctrl: add more pinconf/pinctrl definitions
Date: Thu, 14 May 2026 05:55:34 +0300
Message-ID: <20260514025542.398469-5-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 559369a8-f887-46d5-b53f-08deb164552b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|52116014|921020|38350700014|18002099003|56012099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info: uOtpxwgOntl3mIMqTbf/84+QyuVWmzVLx9hUmBLqVhUKwbmgf37CNH/CUs+C3sCZWF8ef2+Fw5TTe/8p0w/na2BUTK9Ju8IWNU3ddKJ9w75U39Jldaf7eYxBO08KAq1a6OYbDNndqWGNytOSaiARisY0Kt5H7+o39OADJaVtLmW6UIhduAV7WbJfL0ecU9m68ZLtNeL2PFf1ApASWOy8GmLs2IQ+DH2S95h3Kpc59uQXKcZYHB76fY26xNwoXFTW5BZeP4ik7iFQbY4XIwEYKtEIlp/BnPAaRwunHq3Vpsweyd9Auk2zXcd1ITgNTRQGrcWuqIU1rxjExFxnk+rr/ERVktb/ujb4PAkFa3bp9IO/WZshAWXyQ/mWe+zUrwQvVVGZMMrkfmjhvLSqfGLBdeSnA2/M3zBjRDrUsSS0fal6TvW0vn9yihA4dtGg+WycduGQJ4TJk0Qe9/gUpRZM2uHfVo3m1cWuzLDP5uBBG+MD9ulAx74zgPH5Ws6fzmG4OWuw6KJPV7YrvgF8BsUEqWDXn08e/YsQiLVyjXWuPeT3D9DlxRhrkXfpVvNiHJVB0+f8RGndRPBQnoDO2H5u6yLUc9HMuzuG/qEKmfDrbytyeTlL/RAOrIQV0d/mae9uZ86wV1GMdvOl5k9iKPt0raXxVx/BmP1/eNv7Jq4I7+t6YDVW6TQ/CIVazOZXD3vy9l28h/tTHidtDWdJB5PfY5JELnrRqf5e6dM/D9MMyT/7jPEet2nzNLWXyMkvugHskgUWeeYS4/ho8aGYBEq1GA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(52116014)(921020)(38350700014)(18002099003)(56012099003)(22082099003)(11063799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A8HNjO1IeyTBT4ifuOjjto2ECu34U7Lk++4I/g1h7bJ7cCY6Uy4d7YtJP2KH?=
 =?us-ascii?Q?MJx6U6k8KmfhjGwXhwnhqgdm7BO5CpJDed5ymDayn8cjq5YBgBdriCHaBox1?=
 =?us-ascii?Q?PIPC1XVzI79AnQJ8EoAzRNy6r097iZePvmNuoo1ICFc1OBJjnaupkBfmbb+G?=
 =?us-ascii?Q?etrFV3qNx6AVF+5yCryc/pENxMcj8XplAndWBQMP5BlEZxsxcI0LtlWxhJ+4?=
 =?us-ascii?Q?OWSIRamAyJAgbkPqGW6iCUNqfCf2Tb6f+/dhbADamHUahRhBpGcsHRL1je74?=
 =?us-ascii?Q?GsI7U3Z5kzwoFL137F3MSdGGjX2xGOvV5gNQP17jQzXrh3R1ju19vI5l9loz?=
 =?us-ascii?Q?ruR9M5fUNUnujeOsQjB3Oc61UWlk3cB/d7f+UaOlYcgowe1yC6RXAv9eDQ8i?=
 =?us-ascii?Q?uRMW56okN6aI+6HjU1k+iVZpyj/YU/fuwNy1xrX2WKAdxL4dzWemWadBpfnQ?=
 =?us-ascii?Q?ejEwm70eJEG9WYCuVOBrLBwtLwuK7QVD3iTafDzGm9QvApIVh9xS1lJUILOA?=
 =?us-ascii?Q?28zTI36oUpSOinyUELKDmJekhTk4OInWHwnCuAI/MrjkZ/QDS+85RE/2ETIb?=
 =?us-ascii?Q?2Mp8F3r1ePqr+IGzSctl4HCDeE8Em85U20tGbDn/Cv9EEuJHcWkP8xzdHRpP?=
 =?us-ascii?Q?r/Aqx16i+2wk6F5kVwZV5pQpMC4h8ksEgcVpePDfiVJwqxy52HKPURuJy4pR?=
 =?us-ascii?Q?rU/W9xspKu7TQdaHfZyTiRJavIZ0qC+SrQ8CzM3CQHeGieQapku+Ku2InAwn?=
 =?us-ascii?Q?NoHLQtrSjAy15bOH1Jl4smXAprEt9XYuZhp90z/hz54VH82FhX6DCI/rojW4?=
 =?us-ascii?Q?47OHC/CEXvsMiLk6N1393WCnt8HN9eB0DU1tpLhsiLZV3/+QIYqoug+7ts68?=
 =?us-ascii?Q?HZImni9zhJZuw5ia35Q5SLRD3EbAKddOtdNnujIYdtBoQvI8cT2mS9eehJbr?=
 =?us-ascii?Q?sWgXHHuXrpD6EJ5GaIcmgoO/trzUr2LryEOfvRRDjd+WdMdfDz6aNiBo00ax?=
 =?us-ascii?Q?OjZ6867p8g8FAqJT8BfA42gdPyEr3fmskJTKrPBSZqJye24Wc8kyrm4NjKdJ?=
 =?us-ascii?Q?gi1l3c1bHfUZE3r6KACV8kOUAzS0ideIPJbliixDgta8fJL+u6XsbvpFcK6N?=
 =?us-ascii?Q?g2L7jO28ex8FIj8pB+QEzEwf8Q2iw8iGvwSFGhVH0gMD168uoIV5qeUjqoNJ?=
 =?us-ascii?Q?ooEFNkhyDEAZ5soc2qtTjqCSZYe/EMI9Qbk8gf90E/E5isizwW49MQu1hmW+?=
 =?us-ascii?Q?Kv7ZySHKDnfPktrr7/LDJiwtCMVSwztLROh238/vYloQ9aGfoJJmVgh3MB/d?=
 =?us-ascii?Q?l53fgWtWUd8D+Qn1fewuA2aBTz79uR05Nq6v2bnIZsIMgLAlfFac1uLn0nLr?=
 =?us-ascii?Q?JogkSQgA4LX/1iU3twoLmdvclEvlehWQKTIIlZos15ngvkEqzUXwDL1GPlAe?=
 =?us-ascii?Q?XGqNnERflI8BbyQeXpxAAXJHbrWyIHLSV0B0OerocfgfDZhQtKVr9RmvREbB?=
 =?us-ascii?Q?GkSK2iYsc5Fg5WZWoQzEqivNUtSdScbTv5vdOsywXW/V92nbz94QIM8ZU60Q?=
 =?us-ascii?Q?aLzu/6qyRXnUrfm6A3vwwW6J4foodgJybeZfvCfnJcQ7fo7+MGz2dIj4t/OU?=
 =?us-ascii?Q?DBZPdQ/NPzw9Hy1/ns4dl9KfhYyfrRP+sEPtq+cr1t+hiypWSBDpwmZNC8A0?=
 =?us-ascii?Q?sHKNk8IfGbrmRYQGdINOCeHenEtDHdVZwLX+i15JH2i0yC5DQGqWi6kss+X4?=
 =?us-ascii?Q?rGvqTVKPGQ/1YBufT2aWt4gRMK+DLxg=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 559369a8-f887-46d5-b53f-08deb164552b
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 02:56:01.8329 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0k2wgweLCMuPDey2f2APIvAvaqjHmI00mEJ0QYB5dCFRIPT57Yo/6gScNS0WNNV174p06Ej1gAB+uJF15QpFzkmE+lC+mixbS/AL8mHKX/Q=
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

