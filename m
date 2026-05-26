Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6184ACD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 00:26:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F400F84928;
	Tue, 26 May 2026 02:26:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="FC4tjN2i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83A6584926; Tue, 26 May 2026 02:26:04 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B28184928
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 02:26:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RROFfMDS+WOGiSoIA67tt+L240QyEC/hIcr061mheA9COH5uYfjBRM0Zx+w9d/UcmslTv+ktlkh0wUEv5DzQ+ir2KenL0Hf5xZI63tJNhR1I3BV7I2Xnqpn99Ij1j7sCtjA1brcwL7bJmajVcAWPciZH/xEwZg59CwwdlXpx+ZVnTb8lTdj1XNFsbDEDeEwwGSuNc55Nm3+O9hevciwBI7AusJ0wGqbHQ8SgfU2DEgeA6yjCbnkNmhezyRiZowl5Yp3QrP6dIrVRNDFxKfGyE3VxkcdHJadwvqM45XPfGRyq4oyFpnUVFAQoedmEjfWlk4iTtOgCCBnXFO1EmYEWbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwGtMN9Os7jyoHslScncDC+cMQd/0IbRVAK0rBi5rg0=;
 b=WDNe3gFX2+ltwaBfq7ELyMlekvoRdDW3dq9vxmOmuOc+9dLS+XiMZ0+GM0TpTiJY739EdBXlmZTZmAv0hM1lqvjUMyPQSJktJok+svD0xXKEgDtjNQkXlG5W9tQUySC7GG4sjWABwncdSUgZZRvHKyjfv6ehbEchaOz7SgcAqHHIC1OJYZkxvJzpgz/3gWuuoPbOW6Qt9oK+C8KVp4lm7CZ28v+L8EAHjz8H1SML2YKeSl/uE0d2DzVB7PDrN3gNLqAt2bGaBJDGa4VfanSUzAudCAG+gnFLkOCGpPl7848ezTih4S+2ba83fbVHEf1JVEjgukPj70A/pWXH4zzIug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwGtMN9Os7jyoHslScncDC+cMQd/0IbRVAK0rBi5rg0=;
 b=FC4tjN2ijlMC6Vbd9csYKQfILw4L9XkUfrcW4mVP1TGzRa5ek2ldAjI+1lFRiM4uyKkrYOSUHrBhY+N/5Wri0qCwvoy/2upwV3DoHDQlqOKVQQZhbPTwS3blZOBHesjy3+talLkg+4lDKd+PKIZxzQZAETufJJpHzh12oPrbakLqGjXlWzNzW7COCXgsHE9m1sdnf1dWEPtGHCKgGH08EwLdw+KZityae83/Y2Ohwye+0K1R4gg4NsofxQrbROCFC2xw/axDI/wTchT4jw3R74xybAXvuLsYRjWmjj3DEb5Yh82bKjdgqyj06Qbp2ajZH6p+Z22SWvgvACZuqaHldA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV1PR08MB7682.eurprd08.prod.outlook.com (2603:10a6:150:61::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 00:25:58 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 00:25:58 +0000
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
Subject: [PATCH v10 04/12] pinctrl: add more pinconf/pinctrl definitions
Date: Tue, 26 May 2026 03:25:26 +0300
Message-ID: <20260526002534.898340-5-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: a5935b50-6587-45e5-9917-08debabd5be2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|366016|1800799024|11063799006|6133799003|18002099003|22082099003|56012099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info: tokBmum1/1qppUc6tRuFH5ERkTR/d3jujyvxD9CGSRGjWFChLmM5Jozk8bnHNcVHFEeuHFgY7h4dtJrrXP2o0SRrs4w8n0uVvf06d65qqwGmmspZjprCluK2YwBXGjkqjjVYGrT39lo6kPuqG+8nZ5SVgU6d/To2IeoldQmGvksPm1puBDbWjbFmIQRjmTCSjj+7qqszzHnuYO/kUKV39jCcgrqmeRQBXzSx15euJHtMwKRaW1D7WDsTDetHyuypy1+t+vZdUdsP+NQx/iyutE9dO9S7YB7OtkppRZfNHKPOoXA1bO02h4BUuep07JdiEjFGPtPVynmg+i9v5CiIR3nXT2B3is9dt1anSaKGyLjsGlmimOD8ckuVEEAoqMmg/hHeOrJPfC7TR02biWum0JL9GYpS76HMGnsd6Bl2eLLNlTy41zf/Dyul7dXTeyzWdllCaq27FrQTRh17bOjru4cFQL1Ma5NHdkotIuX3Bwql47NxZ3FNJFX+TIkweUcq4cp5zrQIESOIj/sdGMghwssFqZ0T+E+pJAWhmSbgRl2m9XdPahRM90MIjCECuwNtG3awYxR9Ltlj3NdOGLx2GJnl76gBNVQe0iOfG+WQh8Gm+C+6PQuxJOB6TAOV9GXuGvvOcjE9TtVQ+jVESBKZ9wzs20gI5+ZeQjVCFwL77+7IPi+oxcGuX9onYE7ZAvhLfML5pfBD7UMEfOW++lovq/C9xfwNaI7wZddIICmOfKhnKyip5jDLPbqfTC71YhV/hrcVqpZqaqPLTGqDiP+UcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(11063799006)(6133799003)(18002099003)(22082099003)(56012099003)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6sFsVVSnl+2McITgPfWOVZcNOHHRvWCAPX3VnBXbdb5l9M+PjOfawTVldsH/?=
 =?us-ascii?Q?amQkseQseWohtrE9Qf6cvBv1+vXe8n8vE5iSkkpGA8MnylxzFNBLpwNF+3QO?=
 =?us-ascii?Q?QZXllohUpiM0/4p/1fN01s1a/7thogxYAq8NiaWRocEGNKSEwPRMziluGgfc?=
 =?us-ascii?Q?AsB+p7uwR9Po24Ay40p1KF/I397ibhFEHCGYw+74v8vHYlXBeM2fR3EB+vuF?=
 =?us-ascii?Q?DArSFUK7uQod5HDctm9fXmpAmANtTF1Mb/lLL5fu3QoQXPdtIPPMXKe2xk0O?=
 =?us-ascii?Q?6Gb31gtbwSoEaqXJIg8Fr0SqMcfurokvud4OiWuqJ8Z8flbV8p/DDSNcfKD9?=
 =?us-ascii?Q?YzIGLhCzS5q9smpja+TTn61tMTtUUyU+CGsjAw/MLzDoDZRdhdcQ8eoEKHTy?=
 =?us-ascii?Q?KvgSNxBNXkqhGGHDVJyL/UGvNN/1AJurLzNdFZUosIExPHJ/6QwpSatpDWZv?=
 =?us-ascii?Q?XJEp2XbpFg5Sqzlx2lEE1LmKFh+qZsrixu0QI3XcIHMv5wWBsTPAUhf9J82c?=
 =?us-ascii?Q?RKtVcjhSuPjvOcKF9cVVfKtZWR4H5q77Y3yR+AN39tq57xpl+QubSX0BDIMF?=
 =?us-ascii?Q?dsYv3yIu8UFRKShHeU8J7Bp1483czfsXAz/z6gJMd9haUy9qIOzmZRl9cxBX?=
 =?us-ascii?Q?HfFsubYeaG4owcmdftPF4eTVI/RYhWBn+rYHTRY6XAsmHg+BC+VX8A+J5AoH?=
 =?us-ascii?Q?KUvhqCfppBUtyVgsxTpxjV7QcJZ/cnZCD+cmRL8BxLoso7qk3HxtfhndU7nQ?=
 =?us-ascii?Q?hgJlEQOrsdP5rHO/JOXvd1HTYLc4ClprRBeRs/+kNPNnThGWCZVd4PDq5bz+?=
 =?us-ascii?Q?BZW75EGuV/qD5aux4RPbReFj1ftCK7ilIr9UkbFFhc2DezJqLcIO1ewkNjwX?=
 =?us-ascii?Q?EGHrlo5L+HK7N8fKpene9x4yAt4a6CKW+KGagiSLuwRnW3FdTYJXST6WfZO9?=
 =?us-ascii?Q?+HWr50h77znaP/H1BsZCU/ppfwwfRnnqZRuyHOLocmC/SBIpph2p1pQD0OrP?=
 =?us-ascii?Q?VMhdgHrEZK3Z+ZWRN/Cbn/C11Sv56QanR4KkNgzpCvGsKcjOXu3Kz+/pXkMz?=
 =?us-ascii?Q?DVxVY/H/E42sbWh1J80hWVy4ZQn6e5yNa55916VdOdvmo+OwLNJBnWTe5hZN?=
 =?us-ascii?Q?rJtlM4hVDZeb8+dkqV6gMk3qyUUQlz42mSN/9gpv+wnA0flYcC37GC99Eq4B?=
 =?us-ascii?Q?fEXK7oLVIvqhoX2gtkQc5ty7mU0xDTqhSxSHrfCpPYN+r5YUNFleqhgrhOgt?=
 =?us-ascii?Q?URFoVcbzeYm8WxbtiIF+UMg0mJfnfrXSZ2Ag/n6TWg3Wtoryt6dRdI/O0Pmr?=
 =?us-ascii?Q?ZfM3QxjUJpX2bb46TDGwZoL1986tqMZP2SntZtdSsA1xFRiSb0hr5fadpQ+/?=
 =?us-ascii?Q?vnV8AAu6emtXbnRfA9aRclRxhWHXAptFHZnMm/pBcouOLr2C344pirOo/hrS?=
 =?us-ascii?Q?UIeQenxpEHeDXi9tX7L5YVhIoKv/rF+tpriTQnKcPW6UF1Amfde+vBrUrTOk?=
 =?us-ascii?Q?Job4MigVS6+H7VKApr15roXqo6w94G7INPpFkKDqJyaKhO/FcX58K9aoWkcX?=
 =?us-ascii?Q?xz8CvI25mbO6MjRP4GDF5yrykDSK73TaKQ/ryaqZ+WCNkiVh+QIXC3V2lccn?=
 =?us-ascii?Q?diMh38wXWIRuxcb3dR76MeiuN1Gtp3OWKngARcrgWeslW+8jy3mqQ/H/5Caa?=
 =?us-ascii?Q?iIa3L6KXtRgZcCwvkNjLaOVlN4ldCocaT0neZKj++DTtrG1BRw3rSquUbmyB?=
 =?us-ascii?Q?9IKGrorWT6dY1Af1/Nv7V8wA0mbkugA=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a5935b50-6587-45e5-9917-08debabd5be2
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 00:25:58.8342 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tHA6hbLZsvfZMSAKusYvR8S7EJrJJoSOe27NqIXGtohDlJAn7nlzxnef8lusg84+Fv//6wsGFS0nmgjWpgAXfFVVazFJhidyBAlG7iOc0Vc=
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

