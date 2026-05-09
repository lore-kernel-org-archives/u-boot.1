Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1108CD343F
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 11:12:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 621BF84CF4;
	Sat,  9 May 2026 13:12:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="wGq/4egr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8B5F84CD2; Sat,  9 May 2026 13:12:22 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5430884CEC
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 13:12:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y8LWzbNsPIBe1x5S3EhA6L1aBQzE2sVgoVzWCvcvGF7NzzVHvLQ4+yKJ/GCqGjJcmtdx0lfxv5yVigcrl6hWHVj2p46RADkbDIs5ZVJgEGPNlf97GFQC0+nJ6TBic1lNm9agg7No2wKzpODunz2M7yX+LxMWkaX4BP3TZ1dRDbb7er1U2ZRkfIjUnLi/bHrxEqCOe/6SHOEd3eDRaXK67YKRU7UmWHRpwN5s8VjvkGrYg8L8KjFdFyrI1E+JIah1IaHIwXBJWQTev56ZlD3V/0na0reXlXQjiHd9V9SHAjP7nHTtR1ZQsC6J4gPL80mJhNgh7qaTL+u1M8RkyQ09Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81mIX4A5l8chV4yjp/FNxXOsXcyzxT8V4QMyBmdXwRE=;
 b=xIDvVnUB9SJRVKmi7xZDZIzIjwthqBBk5afAxg7Le/g4THnL3b8WuWWpcUGF7AOWMc+V46IkyCFQwv45FJIymJM2EpP2ueB8FHQ99Hf6HVtaXhuoSOLC5M/65G3PIoV2yvAMaGHSvEOYhSieYvqnTEvyViPLPWQGp4rfFw+XDHqyNg9SzB0SBR+V64rqenBLKbF9CoO30SdkCY90sM7nZrrN7vpOeyEpyX7nwGr8D/EpjwcELrREJZlPPvXScinjvAtT2y+nyv/YjtnvsKStWJ6pBIH+Zkr/s8jymQnjLjYbBDEvKebuwOEozJWycPfzFoboLE0AqhAza+GGntbd/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81mIX4A5l8chV4yjp/FNxXOsXcyzxT8V4QMyBmdXwRE=;
 b=wGq/4egrIrW5WzrqcT671rmItdgYN0Kie5Dmrv0YcmvDzNNquAYSC27jzr6F8WnGbQr2YQ8R+raFZ9IBsjntlJ0OOi61OwZCZJ7bWgN40WwgoydG4p+SJNPhSQ/mnSFG3DEZzgJ1D1mGyLLL9NN0jKrzWzqg+c/oDykbPpUC2GSAG8G9SnwXr5xhBZt8vRgOgHjkI/q6u+TWdkysNkf0r/6n1Q7Elg8lcrbzkSk/8Q3+Rn9LKZxY3/6DstXVzDUDKLz7+vfR3Yrx+qbk9nAzK16PynSxJYx+NEY8SuJ1shb4ktGujUVU5ml7vRtukDNf5wHR1Df5Ba2vjNRNxZwGVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV1PR08MB8617.eurprd08.prod.outlook.com (2603:10a6:150:81::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Sat, 9 May
 2026 11:12:17 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.20.9891.019; Sat, 9 May 2026
 11:12:17 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Anis Chali <chalianis1@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Yao Zi <me@ziyao.cc>,
 Sean Anderson <sean.anderson@linux.dev>,
 Michal Simek <michal.simek@amd.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 David Lechner <dlechner@baylibre.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v5 04/11] pinctrl: add more pinconf/pinctrl definitions
Date: Sat,  9 May 2026 14:11:50 +0300
Message-ID: <20260509111157.4039434-5-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260509111157.4039434-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260509111157.4039434-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0004.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:273::9) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV1PR08MB8617:EE_
X-MS-Office365-Filtering-Correlation-Id: 134ea890-8331-4335-8a69-08deadbbd4e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 6kyW2Obqgm8L7GsP5iyMaop6rwRwKYp0M2M6nEYar6gEMeWpv/IbQiBWH21wiTE09AqsKyomCsAF6Hebjmm9ilJSDYKAoExlyiezZ3fabefdqrPYmPMCg3nEeYJR8DMvC7D3/Xm/XKRN5ew6L1rYY7/6VAwMg0yYE+3jwHA2lH+Ivs7t9K//yOnDFWSU5YnJS2pkPKWjWpqNuBMS2mCJhuL3I/TUzzjPCOoKfgfblQOSgWyW1l0lOy/4rdDO3mkwgshnOmIWr3HgeRF6h8P0/msNFOw7kkM0vP5lpm86B5edgb69bxlBAvZ9owqzvJ0JBPM9Q/woI+N/U/RPskupr7r6jKUVfIxVjZDH7q4knWPV9eOsHsA/ylNVPxlCgOdWtMD09s7Zhb+e2dkQDWbJ8KAXGOL5RSOjdPPu1JhuMYwFy7nCAsBdMxJEnp1Zn2XWq3eeDShulZ6eEc3sF4oR2bBDM059HUzONMhxtblAfjsoLoR3M6zKuJyofs1MXDikVu+CpEUayETQ89J/u37LeC5ma9nVjvEdLf7rnXFGPmIWAWvbESIn0u5AxMR+y41y2cPe62eiVnycR+dQXFY78k7iIswGP2elDaMx10xBYkpxp7c+qGiMop0T2ah3cP3F43Vbk50guSP9RxxZx++D2cHdT11io6/KbTSFDNQRbIyPT5Xfub51NsrVqajngwOFce7XAgGvAzApKWGije7wpMUK8wOwPorMRuZFpywOq0o+RgKCx1GGwwQ6T++GeWyTPRFiR/U1mvwly1Q7NuBPxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hT+Itv9P6xnehl2O20aY2jy/DK5ibT25ATXrbz7nRaDN/jhOg3dD+514TlFP?=
 =?us-ascii?Q?4Ng37kyLZyYr/PRfM13WtyqKuRrmnOyDgTUUZvPySwRiOIV8MJr+pDJDeYOD?=
 =?us-ascii?Q?KNdQOHA6LBd5ET9j1vxkXxHovTicoFCd8o1rg8iV8bbeeSct746zLi+Jltup?=
 =?us-ascii?Q?EYxAc6rkauos9HYev7nyqZUMF5M0bFO4TQTPHTeu8vhpcDVaGJnkaASRxh0P?=
 =?us-ascii?Q?mgLsEu5aMXRzllUhf0eHUUclhRodEt1sVBmloGo6gnSSYyu8W3FJmEO6SKAj?=
 =?us-ascii?Q?4O/6gWXtxtss83s/0zB/Le6yHKr7EzwIudwVKDqtAHlKT3s1Q66ZOSe6DhGT?=
 =?us-ascii?Q?1+ePYx7l64+wzbnrzWDclQNY2Yv76nGWLMV+L0PaxjX71ZPtnB+J7jVaxMXr?=
 =?us-ascii?Q?V7QczBLOHwEA0VRGuKBMFE6R2OPkcrqYuAKdswNFviOtuAqzCDyWzVQH3gfL?=
 =?us-ascii?Q?V/+KDhMTp4Jd9dHYOf2WbQRmUC+lMHmVaASfwgHsB9TYfsy9eCYmiuHcE791?=
 =?us-ascii?Q?hxm6mpzlpfHbbgcT4nf4pyyA1mhQwnwmBCc1LG4XnMfxKwa1hyRz/bSEsvP6?=
 =?us-ascii?Q?nvHgKDU2rulsI8X1IdWPC84N2XVP3Jxvh1soGrPqCNlLHnnFHJ/3rl3PGdMx?=
 =?us-ascii?Q?pVNTU6kWjFgPvqV169ZrWmrCCv8ATL+Zu6Msaue7nluFHe0I8djeuFJBHQKd?=
 =?us-ascii?Q?CKhggGb7spX8gbsFHu1K3NdUaJLOUr8BI4I+hZ0Av5jncLG/QMqoFjf/vJ61?=
 =?us-ascii?Q?L+IEo9VIk9c0f1H0G89TKYp8IFDDgXDY1h0hQMWhvn+bCSxtn34tv+kedh7I?=
 =?us-ascii?Q?pOPUDXBQ7PH7AnA5QfLniStq4b7n2VkRQS6SDzQcycdnt1ftDPWVbrpn1E17?=
 =?us-ascii?Q?+RrnQPoL7iik7dN8xhh/HZwJ5o6NF8KtxFX0Hc10AKpLELV0qf74DW+SxitT?=
 =?us-ascii?Q?GlTqT/y0D92Yxr6j57gxM7JMbs5RgjTjJ/5z+p/o8OpPgw++5WMMu79c9Xly?=
 =?us-ascii?Q?WlqvU+JvKBTqUTtlr3EuZghh75L3M0rtf9nPOJTa8Vt+2WLr9GmUqhpj1Vbs?=
 =?us-ascii?Q?PJRGwtf7XoDAnKX5PSdOjDlB0xztmifzdRtQNz737it2JtfGpajGQ1Yi7Li/?=
 =?us-ascii?Q?SqEzJ7YW+WHSofmxAk/pUQGtq6HY+gQnTFnQvrJKo9tsP4fQhKFAmHZHd9bF?=
 =?us-ascii?Q?YXu+XJgilHYxbzD9p4QOzuzb+Zuv7DbezSQZol6eB0HeVvrVq73Txg/J2+Lf?=
 =?us-ascii?Q?DMu6PwUoS7HBZl0vj3zUTNX7s7DQXwWYHmawVw9m5WFyNPbryeKvqeCaLtVQ?=
 =?us-ascii?Q?XLdpeveVnG1K5QmYekoBAf8mb0OMpDn9pn1YBoK48FpgmX1YcUdaf83xHtaD?=
 =?us-ascii?Q?2u4ar2Nn8+xXNshftnjeqA8ODr7I54YKl0SAMWNRs2qAkjmisNzyg+SfuRes?=
 =?us-ascii?Q?Lrfbjexlr7FoC51JNA1Ll/uK5T9Td7Q+6EhgPhJ+dXJ+GGFNmARYUJeTRJRH?=
 =?us-ascii?Q?QthEim9estTVDtfKZoGell0SfGHZb7ASO+9/KPZWidEUOly5sXcutzybGVVp?=
 =?us-ascii?Q?Ov9+gaPwgUjgTJOp6TgqDTYFcFgvcU6Xedra64jVcqZr8ljbf1vRyFV9DkPY?=
 =?us-ascii?Q?ccxwmdo8Ovzc3PD8C+HJByBlOPLxgDhW5H3zR6kwUGT1GdfO7hjzUOQIx+N/?=
 =?us-ascii?Q?cUZUPgvsWdEtz5oKq8RbP8lnVJZVTwADggrztDaBtG5qm1RYbVV80T7oTzBA?=
 =?us-ascii?Q?0Xkb6R39bxGlgNNqw9TQ0EgroOD73Ko=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 134ea890-8331-4335-8a69-08deadbbd4e2
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 11:12:17.6860 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a4+yOt5WykBSUJOOERLFBWOobHJc1m+029LvBkbJ8HzKfyHJAUCoJt+euZpeweDbUwHr5niwtuQ3ddmS9W1gVLq0j8n/M6bdc+m17qz3xys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8617
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

