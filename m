Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9633ECD98E1
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 05:30:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A68578493A;
	Wed, 17 Jun 2026 07:30:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="6K3lZ+oy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD932848E2; Wed, 17 Jun 2026 07:30:09 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3E7284894
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 07:30:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GfRSQDsssULuetcih10Uu7pifLNgtRzTStpAdybq0tfDZrOAc1rmc6PP++m5YxdDJoAxOz7vcbuS8opDHi+HAf8341+ATkMzVDo8ZFt4dvH2Hpz2tq0yOfPqvKV/RFxcNzPJf5FDXWuLNXqsKZSQq6clRw9HI78FCUYP+U8unotDVx1Syw9wVD6eLgOMeD0iK15bTrsbh6lm4JZLLCx5/Ehv4X1OYvniY7KCnisLkOj5QjnMVmRN069qQspXTGBKpJ0PrGXTaZOkNuM5AT/rXyxDPnWW8UO4l8B5ipoALqDh3BEj7H/MqhWZnGI5LbfzK5d/BxnNgjcLhkD8XxvRfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwGtMN9Os7jyoHslScncDC+cMQd/0IbRVAK0rBi5rg0=;
 b=qn/C0M+hP/nrHwOOZq1w+tAseA9eGRN7m9DMMOq6tdL9oerCJN1HGm0KrNZjfbkFWDMoAZSNMpWPRLcoz2xFn3wlrCkRFydomYy7t00fkY/T5WjSXFmudeSQhqbRyn965QGxnJNXcmf4sNyusePWaPmCgAho+1SVzRFilJ5lSt2droaMnmIYDylNBDPLQoQ+yM5O8LpyZQjRBh46rxjC11WKUKqTkbf/s3PxwpDg+c3972hzSRul6wMoYXZpzurvDbCIJbSgvj8iGsq2egWEwK7qDv3rFFDRep7jTH2eO+2jbbRDBIxyy3W4FPxzSw7yslitxhf/TAvvzTFOuspyJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwGtMN9Os7jyoHslScncDC+cMQd/0IbRVAK0rBi5rg0=;
 b=6K3lZ+oyt810huMJZtYJ2Zi09oKgexwxDJhBSsz/gb4PCXJMiSi88Xub9oQXpsF0ziH+SOXXvpqHr+PPW5xPgzHPJun54P4WlePPoJbuVgJpEUQhqQWHTo0Nd/Oc5lm79INvujK4q+gsOaeFkkvwNcUMY1W+94ADh1KhEsvK+XfZwfuqgdeVMJwwrR/lpzZAuVhfG6yGUXkwnQgLX0CR6yv8P0ln8OEvcxdkEY15MVMOn1yjkUMOTMSZjoX/MNXWmnn6+AAcB+B/RjNdpLLt9gKdpXGM2WSpE3umEDE/9Kt1A3zq2M8J1fyUbjoLUi1MBRcK//gE0UU7FKtexCs9Aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DU0PR08MB9653.eurprd08.prod.outlook.com (2603:10a6:10:449::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 05:30:06 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0113.013; Wed, 17 Jun 2026
 05:30:06 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Crt Mori <cmo@melexis.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Benjamin Larsson <benjamin.larsson@genexis.eu>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v13 04/12] pinctrl: add more pinconf/pinctrl definitions
Date: Wed, 17 Jun 2026 08:29:40 +0300
Message-ID: <20260617052948.2815870-5-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617052948.2815870-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260617052948.2815870-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0222.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::18) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DU0PR08MB9653:EE_
X-MS-Office365-Filtering-Correlation-Id: 54b8a69a-8c17-4ee4-76a6-08decc317d17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|7416014|23010399003|921020|38350700014|22082099003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: iFn3fUJA823zCCToMF2pYz3u5Hu+P442Cm+2G3aPYa8ENgvIIuJw8yFh6zQd4zL9Wp9OaeaXxdyyJKve+fR8i7brs2ATawgJH6Jqqk4MHid0UNFRIVW1YQL8X0ilzXddUXer6lHwJVo5mNnzxnT7piLq8Dz7JH4j3lWBIWPzXrKJJi7F/N8sgrAvxp2haa0XM5jVj2NhUs6+X+nCXZa8uwqM1+TuTon0S/whv1QYqmNgXww+HgTez2ahPEfCneIQDOq+5CHRPXuYWpnUARUIyF1I1Az4jKDCTdCaKRmugdWPkX+hpsMR3ip3vBabDq+9368yi6daq856u5TvevizVodUIjevCn3PqWIzXqrzO+kHxOGH/bGSSpt1yx/Xr1hYKC+26E0P9dSwSYzYnZgPfvwzHVpO7egDzZJUNwEnAqCpCnQsL1AJPJUeHGxhr/wvXsvTj11IdviAOGo0eO1itEv06QZ8cPimBtZWzuEgyJHBJXxLpuuqxVQSpOP3T/QpLTkJ/L5FI8K9JJOqa69wd5rEz2RJHm6JVhruX2O7qKILYZRjVgI5E0yKSq/pIzF3lqJPzp8a3BkwkIfjb1dmRr96aE7oUwAusmg3R0o2o6Hs3P2CKGIU0muis8fM/akuKbOigOeaQG5eRTlpcRKRhFW/5egqdl+2STo2wwFcrIRhNEgfg3P+OAkEPyL3NpxIZN2CsQTa8j1h+bOBlmAoiC4kJXQPGP1UpafkJZAjb62yl+/fm+Vs6t5xOdC+Zy+W4idoaZyb1lYNnfeaDGefSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(7416014)(23010399003)(921020)(38350700014)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kmUWlImIGmgJOjqDay7K8JsDyUholWKGX9sfdS7GJi2K2TsYjhBa68UjquHT?=
 =?us-ascii?Q?OKfZ8/QFlJvxftYIk1tMItnC0J4yHIz3TqhngbC2OOxiQ8RaPhGJ2q/u9XFa?=
 =?us-ascii?Q?iMs2OmuqoTI3xMbfyE/7w9klpg5/DlYwGWktZnAKo4DcWDBFqlyUDbxwOb5D?=
 =?us-ascii?Q?egWK9u32Xud6EJ9embsESVhXRexG73ch5FpqWXE0gs+lEJtbH1LSCsO0AYZ5?=
 =?us-ascii?Q?w9asSCZ91YMwRRF6hxNnWa+4v6pGGfTju6Sqyse605YHcoCFDDo4zcdsSuS6?=
 =?us-ascii?Q?5qUcQQ+G8GU4La2ESb49iGYQUkmAQBIDNpnYovgrqaHqZrBBGCxIs1gQpccx?=
 =?us-ascii?Q?r1zdxgZ8lXUVFkPdVToLT/JKp6X+V04CfwhAU7GPrrzD6o/i10rcruBouRRc?=
 =?us-ascii?Q?zozCgRH1MKe8In5CmtS4O34g+PPHqmOpys3jtQihXJF+kHxNSStw5SV6w+b+?=
 =?us-ascii?Q?CTCflWKGqzf4Cg8JRBp8K7TdhElo85hBdKSsvxDZz0y0dITOdQsB/Fs9EPwa?=
 =?us-ascii?Q?tamaVbAM4IAcstcfI5Ue+Db8vDJgR33gV2b1nS3hriD085+sQ6Tm61F2qGwH?=
 =?us-ascii?Q?6tAA/QCCITG1gn1Eem1192Bw/VMdBdrRhjO3nVv2LZ7nSdaPqgdCHtqEW2Kj?=
 =?us-ascii?Q?t5Ho2n0gou7hirAqLgjDCnheREyfpa2vgglHCX3ZdDqMIbozNibL+CSIOxSg?=
 =?us-ascii?Q?2Xmu4LlfS5HPJc+y2O3K5dyfhhOGaQNjtr1v6RJhreTbSrGK9/LdMKi4I0cH?=
 =?us-ascii?Q?zZPr8FsjOIFJwRYFZ0FS2SqCAswVUbEiPZDErhNchzr+Ojop6fMKO/8jDwmQ?=
 =?us-ascii?Q?Uh1mjhAIriokfcrdbHfaXl4T+ry4C3elylX8wRtlAloN9gOTcndx3QjKC5eq?=
 =?us-ascii?Q?cT77UJslr8iO/yOK166eOG+qo1L+9C6TZAJ/AM2DZTn+9U8kaiCrrj8mihmP?=
 =?us-ascii?Q?C1ISWi8nl6RyRrMzqvKEjp9fvbPPYePF7qfy+jTcXSL4xv35ceVmkEdJjyLx?=
 =?us-ascii?Q?dYPZrv3Bq7iOH/8ES1fPmPwvtUX9jquYN149y1aBl+IfutLEmi83ydY2ieKd?=
 =?us-ascii?Q?eBXxS1ZcPTki2Y0d3f7dRoLGiCIbuf39GHOUuyeAHNBRZllku1QKrfQOTFXf?=
 =?us-ascii?Q?cI4xD7Yxzep2D/OCgpCXGuG2SRTpbMyckgQ8rnTRZINa2Dd1PesR9k8t6Zow?=
 =?us-ascii?Q?0kfGcNBpLLGJeGCP8zG0R4/Yl4W81C7mX/lKvIPzbjSgx8b0KeE+2ii/llzV?=
 =?us-ascii?Q?KDDP3UBUzIvuTlc2urGGcir8d2frUeDFeWIplib2NSAYzbP972LxrV98yxox?=
 =?us-ascii?Q?AU+weqYlmgj7nEljucQOhFh6mLU0c7zqlmL6bkGA66c65VwVTJHe5Nw7wrWr?=
 =?us-ascii?Q?i/xt+4EqFDcO7W/JCwIfR6UlNlQ5gtLMdoElyumT+6oMkQR/kK6L5PmqzshD?=
 =?us-ascii?Q?qdPQBKFYKQMviczar203UCmwxhmRLW2zJIajgjUhiXewUTJhjAEPbtRYtA7E?=
 =?us-ascii?Q?CnfgZPIkHAkJO0i8BDObh+LryIXqt9ukuSxHmRkanuASboc7D5ieY6TNIO66?=
 =?us-ascii?Q?HPk3TuQd1ehR1wkw22satjYDwfusjWjqv8fy2eT1WFmkwi1ZqNAvT8dvFKs9?=
 =?us-ascii?Q?1mztQ5iDVniUnqBzM3BE5Mhqau8se7ZCZMfe31Xqhz2q1GrKpm/DRw0LVWFt?=
 =?us-ascii?Q?dmlZdntiSvQecrtia0eQWrZdofQR4gtTIRYMIfiZNCv61lVxcmjae16DIIWB?=
 =?us-ascii?Q?ZYNiA+mCGnXSprxgQTUYYiiumSHoOoE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b8a69a-8c17-4ee4-76a6-08decc317d17
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 05:30:05.9207 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ru+tV9ui3E4oLExmCXO9HTIIOu3LVo3S92vmQxSvRlSz0TWdBZkem8NL0gfCTOG/sN11cVrRSEkqSnYpLpOOX9PLLuGOCYvyZFqYeCNhu6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9653
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

