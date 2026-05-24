Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 287F2CD5BB1
	for <u-boot@archiver.kernel.org>; Sun, 24 May 2026 20:01:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98BAC848B0;
	Sun, 24 May 2026 22:01:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="h58Wypic";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1FC3848BB; Sun, 24 May 2026 22:00:58 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 814708489D
 for <u-boot@lists.denx.de>; Sun, 24 May 2026 22:00:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ddspE9xNHeLWAUY+krerobWIl9UtGt8Kd/Et0/L3oi4T3jkJd8Rx4dZ2LnQ46NIHGz2r23EuvXL5mFE62NQc6vPyThVPm0tE/4ATd2r5OU3ukOQrkei2QEOpDRfdzdX87Fqe+GurWPOnlq/ttli/BuQOYBXCB+LjhNaTLTWDqmXEWCfCzG4uJIw4xPQCr+FOk9vTxTCZFIChmNwPZMwoL2XL5cRdS0RyjnfPqXFnQk/8cI8mD/nd8/ZfLs8+2HBXz4Ytnhbdd09mHN05Rv4ynGzmDOLL6HThPbA1pUX+JJMwx9AFdbt+vAZjJShdXyFUYBUyM0C5xnBkKXdTUFTO/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwGtMN9Os7jyoHslScncDC+cMQd/0IbRVAK0rBi5rg0=;
 b=K4m+fRCz2GFw7Fpa+UcikdFnmynJpmAof0oXv1bEibj3fxgBGGlRtPVNVxqyQZ031AEUlUv0FFe6cr6mXxoTxWouEi4n2S9poiemk3ab6sNK7POjzbPDKiFzBL06y9UcNNl4+usVr1L/qIsKA+1AZqN1LC6XdpvnZoNh/bK8k2mUJ5m/a96m71/PkArnRAW2OcmSt7xejdKfF9dFYFeZTygUOI0AKC2K4ubyu8AZgRNzz5ALoJ5UI6uRkC/aplCjxmgSdLSbpMtDth5XrB/IeRX4BedEnfQqxlDGQCYG7hCvqi/RAHRJSruP0MZJyTQVWn14ePayaVWRekl1AJovPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwGtMN9Os7jyoHslScncDC+cMQd/0IbRVAK0rBi5rg0=;
 b=h58Wypic3+I0Nb1KEtI/S/pMhCjxP72GqYwmk9rT9qMuiBI5polnNdHzEu+t9ij2CAe4Y1RHfKgNet1j08ou8IQPiEeutwExe/CBmrC104r+sZQZwCOy7Qz4NczcL26ieJ5J+g1nLYE6TqxG/VHOIQNvm3+2LBq8Cu/QYVCCoZkPm6Lg5EIK8LFG8TRGOmm+2w6zRDDTGw/fv5yDNNkJVHQFjG7mgb8/JuUZ8232cZj2KNP+6pQdc5MLE4Xwg6DZ+/czJ2xdw+I9RtJvJcmYXlbeTuNynobSgW5AZnzD+3Tz0vvFDBOw0BtXjxCjHixOdOUeEsfwJINcdsjtfFVJ4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by AS2PR08MB10266.eurprd08.prod.outlook.com (2603:10a6:20b:62f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sun, 24 May
 2026 20:00:54 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 20:00:54 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 David Lechner <dlechner@baylibre.com>, Peng Fan <peng.fan@nxp.com>,
 Anis Chali <chalianis1@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Yao Zi <me@ziyao.cc>,
 Sean Anderson <sean.anderson@linux.dev>,
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
Subject: [PATCH v9 4/9] pinctrl: add more pinconf/pinctrl definitions
Date: Sun, 24 May 2026 23:00:33 +0300
Message-ID: <20260524200038.47826-5-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260524200038.47826-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260524200038.47826-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0147.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::10) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|AS2PR08MB10266:EE_
X-MS-Office365-Filtering-Correlation-Id: 32b1ad53-85dc-4363-5144-08deb9cf29e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|376014|7416014|1800799024|18002099003|22082099003|56012099003|38350700014|921020|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: A6Fyfd5AjddXmE+kBu3vdZDs3FkptqEQL5tA7q29t8dLfYTw+kQ/YELPLjsW8JUZch9EImSplb1EQYLrxnUTPFco5UkxMMnM8bBcdPQJWfd7HCE9NYd++Wfz/nj66GAouYVlctxcqWEMcc9UcCj8MDyK4D1SPNcbIb8g7WLVU2VeGVH++iTol2+/roT3UQEdNVFu/Wg72UdOIg0Fbit2UtcE//AwNYfBt81aFCvvOXaX94hcnvO6jOBMmDEF41mV8hqvGeGfNkEjkvpdDDs2yk37JjCT+gFg/REDSblYdyRK9TdJ4M/0c33JdjoBPaQt1+sTGrXRTT7GDTfHhp2fN8wuGDQvPF6w/47KSpfYY0+lpQFncMEGW/Z66n+so5OWFvFSQ6R/2api9pQTVqXsGz0vRrTOpvjDUcz+HX4lm6ijm8MXYr+oAu5UPxJV/eHq4O2MEIwmoa0c4SLsV/xNA4QI5wJrDFCqA92RRKb8x93M8pfNInXzgA/N2rnmU4jdEuSzXWfdI0lpf/PWqQw02y3d0Md+Wf5YnYFTNI9cwq9lbH1puzmFVZAfHCh6jZWy/G9fACqxU3Uw0P0fI/NzcKXlsKAQcTZiA8H6tRNXgpzc5/IoRHQjRsDHQc9T1GAUw/LMookGv61VZulXkosH+Oy7VP5Bek5ZMRXbr0M0XX54aa3nbDxz0o5vV6y/xrHCN8r+MubVCuQfmy6nGTxubsjmsSPx+O/MaVZAmzUJ0X0LDE/S38NGHnh+rOWbp/R0IrOBjhnoXqXTDK5iBz9eeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(376014)(7416014)(1800799024)(18002099003)(22082099003)(56012099003)(38350700014)(921020)(6133799003)(11063799006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eeqd0SQCVdttSQ/KtqGyYrI9YFNAcTO7IdD5BuadD1peG9naWTtsp9kRtLow?=
 =?us-ascii?Q?Rj26UbJEH4jAIKUn73Rb1YQ/gQ5bIS6LVa1iLERW/qLNLSgYQgHrEsDf77K+?=
 =?us-ascii?Q?YFiGHp0AOQ9hlp85/TZ+g6DOw2nfRXjF16m9MTwnU7WbOz7Jwfv4P4YS8m7W?=
 =?us-ascii?Q?zD12PZFvYuvON9CpDeykDlQVZy//Py5igku5v3N1re4mrssCqui+L3pM+5zQ?=
 =?us-ascii?Q?oPbS2k67Lkpn+xHbtIVVuhV9Qfu+Z4rt8ZSJYPlDT+yjFmpantxTlxGDrKM+?=
 =?us-ascii?Q?VBWKlZNA+V/cLvzTOHXVo/AFKK/fwykrXw+e9M6++ODhTFu55uZJdBWUNSdt?=
 =?us-ascii?Q?zDrk8F7lxw15+sdx85tFxUEz5n6jbahnczu2zq3zevcRW/Y+ZUyY3pHa5k4w?=
 =?us-ascii?Q?4qs8KiK+SI2+JmHzDjtkndjBqGYU+A3WYGL4g+Uwc8HOx02hXsg4eu02W3Xp?=
 =?us-ascii?Q?LyvfH2pIdigTF42ICQkwbkFr+GwztovFksxb3K3FkrDjJxqz49Ssyi8k/85n?=
 =?us-ascii?Q?e0H1rm81qDZ7kF1ozj9yEvBaIcUbHErZpJSL3ZZTpTJEc/VvHubLiiAfhcKk?=
 =?us-ascii?Q?T1vdEEhdTsZ+9fHdNldzIf2hFadpkdYcfTqLFo5BREfQP7MLs4X0UPJFdGoa?=
 =?us-ascii?Q?BFVXEvYjTnYdKNjz7blFoIBwE2CsB00Jw+MTKtJieCZGMwTCd2gHsmSsPyak?=
 =?us-ascii?Q?CUvwYaCEaROnCdagkgCSpJxlDiLViUt4r80BSKCgtzstYwZ+NBWHt7MjDy8/?=
 =?us-ascii?Q?x0tFKjdZ995pkfQQYO/8gtvCpAupNGXj+pZekmyQd0cCjgvZ1J/GAZIz7mj/?=
 =?us-ascii?Q?fmfiMCsKCoUYiG83BPaYfrL28P1sqaPyQ7hQmWqfRjwI0k3Q9p11YjEwTer6?=
 =?us-ascii?Q?k/7lsTlL1RUXWGlRLHXjkg5JmF6hdPTfrxGIFMYN+VkzGmtLPiBYPtse8fKR?=
 =?us-ascii?Q?m1YlPyStFMXwl+hM/UwtzSnN/msYBR6ymUz1/Y+zmxXFGVgiEBkbMNvuRHXR?=
 =?us-ascii?Q?UfyKZyHF3aHj312UfHIP9pYokLSsmTgAiHKJaggyNN0kiQSeQMXGazPVDAtZ?=
 =?us-ascii?Q?c7KkJtfAMXwDXZoS+YSSb/jptpg4HdoISOiDlOR3yz5No0zFjhulHJ+aBoG2?=
 =?us-ascii?Q?AFcE8Juhu8nIL4RWl08engY68zYlarbq+wySzqLITgYDICUtY90jcwQV0ysX?=
 =?us-ascii?Q?BWYJ5XdZk+dle/n7/++43Ki0RwMUUgWmQ0DCYnNKH+wlXhRK9jMV/p8SmDZB?=
 =?us-ascii?Q?x1n97XwjUMzJuVfi8kaKnbgAX955zO4apmmGToaeZQ3xSslckQD20ykNdkON?=
 =?us-ascii?Q?cMSKgSdnLbl4/mgehzn36O4VuFSbp9Oq4YU4J6t6MJ6Q/8w8vEOIzZQwvlUb?=
 =?us-ascii?Q?hw+XrY8/jj0/g0N3NEDWGEpGB4XC6mHzv6nYE/+kYXrpr2dgwzyknGEMOZek?=
 =?us-ascii?Q?Dt1DICYZ0sEGx9BJMMVzX1bdvu8Jv8yOoJwWa10oJxO83P/8T0YJnDCjhS63?=
 =?us-ascii?Q?n9nRt25kAhKAwivv+3nRnT2Q2tt1GL+vxhjx12g/KgyebQS3WgMNJ26kd2MT?=
 =?us-ascii?Q?SeqypRtwtTYklA+pnH2nY7jwVdGViwxohbRE2zg8QM54giLN2bjfLt5uembr?=
 =?us-ascii?Q?qpJZT5Cmuri0+LT4oP/B8bKa1whyTTdV13JZK6WdxiNI9Abyr6cvvc+Fa4dg?=
 =?us-ascii?Q?vhBsK6z2MqvRC+zAYyw97qud5qlUHqupECdZbHHNJmQBzxWd0O9kTyAsFr62?=
 =?us-ascii?Q?DkCv/t4LKgSPVzzyjsSu1i9K/VriH3c=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b1ad53-85dc-4363-5144-08deb9cf29e4
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 20:00:54.6984 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bjloz3yAA3UcGCGc+LQVHkvRAE5aTFoPDuTaYA4iFQ/XPx22a8oM+ORtXeRFEB9Fi99qT9vcQNsu6xGeab/R7403nVoZ9kXQfzIpOtQPYKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10266
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

