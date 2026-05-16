Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD44ECD4851
	for <u-boot@archiver.kernel.org>; Sat, 16 May 2026 01:01:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97BBD848AA;
	Sat, 16 May 2026 03:01:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="pVUggEtl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9B2B848A9; Sat, 16 May 2026 03:00:59 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6F9184713
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 03:00:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hJRYhLHN7F+easyzLkh4o3R5Sae74N1rgckfBMB/+ffIopc2wd9VidvIcIW3DkaEWTmqWkvRmKsWSt7s8oyfqMPN8rhhfXNIt2xR4nTdkcUCRqDMqhFQvSU0zJWT2OLpPBrTtiItwcPf31lOpa7EDIOPCaqAprbfFm8fmeMU5lRf4OhzZLIrnR0bp3ZuU4lp30c4dm68yRXWIRvFOYBTggeTWCWcpkevzU1QlWi/jTXZFsRvXp4o42FqkSXszyNBH/MhZPW+pe01deGRnKA9OA1f86fDlkttqUpfHDZE6jnrQalvtj9xnlrbiJWvzPCTvOtOPzF7/jPqntcstZgNBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwGtMN9Os7jyoHslScncDC+cMQd/0IbRVAK0rBi5rg0=;
 b=ODai2jmvf+ZbXiYb6PHY5eBNI+ITWgZliSwKmvMni93i5o2DGCi5ynbJAODyMrjBJYOxVapW/SIi/P2P8p0bBLp66YfdVuk/E0Q2weaeHcCE4WjYfRkXf77B53rlFLLq81GnfCTQ+vmmR21Hns3oyzFEoSUnBJZxADlFt1tmRdU0qjlbGudEC6bqE8JuKrnPmLWEVt+tBREj8XRo4VfsgamAMbKpps3Qhc3qVW4v9frv9EJaZvR4olP4PTxDn1iQ45xc7Q75zNH3KbaHPigvW687aB9VufV8226kChPSPoKFQkbFGFFrIU6ZhEmcjqBgIBmwDhxI1xXeTSFL0PiXyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwGtMN9Os7jyoHslScncDC+cMQd/0IbRVAK0rBi5rg0=;
 b=pVUggEtlvdngQpM7fnQSMldZsbXL9UPTtH6kJ92GX9HZkGuCgN9N3QhLjRh72w/Hw0ECgFAJ5e3Rke+SKSb8/P0H1RDpQcUkTPrVJGPKp7E1TjJn0LtnLz6OmdxY52sjvhSU3VRhK91+DB4DGcyWtGmoHPrG0CjnZ5sqBi3s5GMWo+oepkJ4L3YLNIm7q/Q8hl4CtYuMi+vlzpLDfjIOMn1RaIiLgDLGgE8ZlDRAcToeH34H8LqiJxPN6I2x5iuNK2hZwVcdMqSOipJ+Tton66UUTgRpPj06zICJcXoLyWak+AcUyoD4NR1XRbUVoDyp4kgHS3vsLjkOZLyibKF8Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by AS8PR08MB7917.eurprd08.prod.outlook.com (2603:10a6:20b:538::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Sat, 16 May
 2026 01:00:55 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0025.016; Sat, 16 May 2026
 01:00:55 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Anis Chali <chalianis1@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Heiko Schocher <hs@nabladev.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v7 04/12] pinctrl: add more pinconf/pinctrl definitions
Date: Sat, 16 May 2026 04:00:27 +0300
Message-ID: <20260516010036.1034352-5-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260516010036.1034352-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260516010036.1034352-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF0001DBD3.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6a5) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|AS8PR08MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: f5003634-09d7-464a-1005-08deb2e6959d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|7416014|376014|366016|56012099003|921020|11063799003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: X8Kzjectq6pyQ7nCho9ZdddbZUqklYwWY2vrbLbZokTf4KnTo/+apTxMW8fGNnBYLmIm3pdJqQYJ02n2hhunsoa2l/MqfOI9H/YNfT2THDyqFwdaBcsBQLkxRCn+qtH8hefNIjIDH3wHy6Qy0vi2q402xLzZ2OxBh4icF0lQ5UL6ihMbI54XmUGotlPbcTmwHEb1ScSp+Szk/xHnhygC6E5DGxYzuTB6aK3x4GkckEvkb9PvBu1PDM79oIy6YOaPDlZSgd7LSj8qS06J9mhMhiJqiDg1FB1X3MD5+7JJe1W/DCA0g0BDwbxXIZ3nIZTKXbJYYypyk02ZQ+wLgAoA6JYmncCD5WROzwgO/rffHP/DWPVrsomrIz+q1Qe0WCsjnp8wKHmsgrLhZQscZ4LelrJ39YpNZ7vcw0peO6ZCSqST8b79OQ/GK374GWMVmIF4w8zl1lhFr5DcPbsSapz5aTHXWiXSeVKn0YiUOROB9/8vVF1OL/BZt6JtNn49AeM+XcPUgg6iEcEA8GcDa3/YBy1ijZF9uyF1dTBfmPFMeNjJ/bRm0pyCNupW4ZEHEkFi8Xo7xT3FCAf1Xdo/ndCrtyfwHvHQk9qmNqBaJHH1oG+VyVQ9a+iRt6wf5AH8vMMr6WgsZz0Yv6KmaOqnP90tn4V7qGXbHSwTRgmkSjjcXGrWhzeYqN+1dJbl4cozi6gQfwknqkhXqDgwfMA965jZxQKRandNMzPZp5BoGMLIRSx6iwUps5K1Kzc4AGRJLWzYfKl4NzSbCDq2jaJ4yCd2Ew==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(56012099003)(921020)(11063799003)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L+MuxDedjIEP16843LpGoS1qkREFbme4Q9oFr3Bai2YXzV4TQb9mOPj72QQ2?=
 =?us-ascii?Q?70NXGAPqFo69Fd4MEW2v8ojya9MrUWYNVUySdBprbp2SjW3P+ia6n5K0ck81?=
 =?us-ascii?Q?btlwbFbj2jPf2DyS0H9cOLeLxnbao7VdIYosVgnyv18MMOtamtnTtBxN4eNq?=
 =?us-ascii?Q?K5T39PQvQioCe5BWB7hpUjoX6YJhWeCl2YmfYphBXo2yaeIbxVXTlQ6NTSiG?=
 =?us-ascii?Q?hGANMWU4ydHFv2NrJl1wLMu5RpxKbjFJ3m6HWdM7+9ZY2q9HFvDRAQhDERl9?=
 =?us-ascii?Q?Ta04GGf6J5S7YasS60LCATwolKsF9Oc15ExwJTD7BQN7sAv+ofITMiMXw5ED?=
 =?us-ascii?Q?8m/z+ZSqBjLobrn5YRo0VDQfC4Sn/Ol1nMXTYPBeAGKwyc7XBtyYnngIyBZ1?=
 =?us-ascii?Q?YcPaUho9sWPBRNziWtuT81uO6wb2sf2h1tj/6NivX5SX1TZxjCToLldf9Olx?=
 =?us-ascii?Q?cTW7+pWDRg/xWDSspoRBhJBhU1F2Excm8pkPPWHHXQOE1Vmnr/chVo+YzaKJ?=
 =?us-ascii?Q?RD4dRi4LtpUHz3Mh/PPOMWbkyfawJY2hzdjVHU1wGJBiTdlyNQ3F9peXX/Hv?=
 =?us-ascii?Q?5dqwWGDQFlqD1BgW5BTYyYybyYE9I+ogbupwcdoGZapOQXVYPjaMF7JFdOKq?=
 =?us-ascii?Q?WN8i6YanyLPKfKE/ltmBGutDWeKCYQ0CdflBkUH3FQ8N5X4g352MJ2MWlqid?=
 =?us-ascii?Q?TUxSug0QFFG3UVNnUvhigTxutza29xSPXOeUKv726RwBumhYHLLSFPYJGV5v?=
 =?us-ascii?Q?hzE31CT+OzeHm2pShghEDnpZd3rTB+O2EeHwMxtquARUUojqZedH4iartF25?=
 =?us-ascii?Q?nO5qNIMCYERKJwAIxZYwWRrSL/LpkdOyLedjVkKO69WIws/Xv5kgw/0dX9J7?=
 =?us-ascii?Q?axJ3OrOaQUmD8ezfSOAltfDfSI9oO+AFaOziSAuxuk9wMTdJVZhu9roT3V1Q?=
 =?us-ascii?Q?KcmPdPLEmdsM5xfNMGTyIXENR+z50fmrnGOfpy9rOnT7+iOgEdEIyvcI4FKB?=
 =?us-ascii?Q?i8kxiLgHwpxcJRSZNQAGbc0B7Vs3N9rM3Vz+v0r6iGaqz8BFYZvYhu3T2dEZ?=
 =?us-ascii?Q?ysyY90ccGhkwHZH8FnyELI43L6AQNtZi3Xg60IcswOijKtz5SppDRwhNz/BW?=
 =?us-ascii?Q?oWYxsNG6RDJYNkqDRoSImaUYVvXR3ZuJ31HcW6V5YkH9HP4ANAEZHS0YL8x1?=
 =?us-ascii?Q?3lXZhWwtIbxqtcZHxt9LcaTomTJ0VcXTrC5Ij4VPm90VlnNIV5sGDDC/uY5F?=
 =?us-ascii?Q?b3PJdBEcqMyM+gdut+HU4KvTQrWMkDMD4DxI4kNx/s1zVpOY7VTvM/bi3yT8?=
 =?us-ascii?Q?P9iIs4XdwjlG+TnKwdEmF7I/3IJRMODAytlHCVrYpSKlA6JD5URtZHs2+1ya?=
 =?us-ascii?Q?/OC1B/i/tADbksm+N2jQTKMSU+HiicCm7E829XGeMfv45c1Gx0AKv4NUW4XE?=
 =?us-ascii?Q?Ezoq/J4KMmYMeA8jI2eL71YFSJ+9dyWvrp5ifo+WiE3Kp03znzNO9BlmD40i?=
 =?us-ascii?Q?pkt6oZkYPSu69u8iKhJUEfV4pwNL9RMNUyCxLmMc4qPHssYzp6l5HVUR0mAR?=
 =?us-ascii?Q?ypNEAj8IOaF59s4dPLm5EoHeqSksTDIJ2ipJlbLm/mn6AwgkLqSUdaaAVZPe?=
 =?us-ascii?Q?nitElh3HGf4f/9etqJ7dLpdyk/xsRjjvIXWNrT3vwRKv5QTL2Lo5V3zwJcMh?=
 =?us-ascii?Q?9Ona3HcJ12EZi4nCpWXDxlxyvdTaRlNsYzUYFUbmIILEwF70DWZDSXCgiXRp?=
 =?us-ascii?Q?IskunSky8Aa9/g/TCgiQWMdzZtxX/GY=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f5003634-09d7-464a-1005-08deb2e6959d
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2026 01:00:55.7226 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bHhmTy/2ZYEC2HuBdi2sx3gQLUavEe4GdozUmtepGeiVuHtkmIkcjiwIpBP0bdaY0hbaNouU4jGslDzSrUPMhrSCuQ3XuQpCLze8TFiC8uI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7917
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

