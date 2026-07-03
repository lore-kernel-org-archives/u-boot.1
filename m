Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8775C43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 11:58:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90DB684B37;
	Fri,  3 Jul 2026 13:57:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="APSCIvQF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFD8F84AEB; Fri,  3 Jul 2026 13:57:43 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C72C84AC9
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 13:57:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SsGXorgeVuKgGu2kpaSweQX3c8/PUJrfMxA9OIIL5CJAfHlp5AGbuxdxiee97PYA9aBcPwG99HoFWcDoMFgYxLHDqQGQWRt5iIxeWszrgk7fSdrSuwWek5U+k7DfO9YdXhFqnv5OU07ukV+V7lmTo4LjmOIx3zW8jAsKYO45dZ+y2twIOEN3hbtkOwFHgNNK6bm8JwK4U+kBMlQNEgtfnYICMWUtGmLP31tIa9DnCh4TNtZm47s1d95qv6cXwi5B5qHoEP9WeXhn3TevsI9f7uQEfkXjmqPSv166e0yVEPGPamVBqy5rV0q61PWJC4LGEjnsKGUtV3A9CVX12O5q/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwGtMN9Os7jyoHslScncDC+cMQd/0IbRVAK0rBi5rg0=;
 b=CXs9YdhuhnDXRKhxCO8wxQnzTjIoTSPrFwXt6ixtZBAXr+VqpFpijXhjnQ47qmI+gCqWCl2CWPGBzchfxunduHl36ZE/Od7M57pCUu4JCf6OSgrDd8lpxM6jo+Y2simBLovnwO4jbmtZVunQ5J4ob0f2ooYzHudRHVNfCwnLNjXDSCCteBlYRQ6TL8jcl7Z5cuHlXKaIMMTJsITOOKJluabtjJ/ZTlrkjTDxw/Kns6qxVGK6wU2bwCLdpX8kBIdXrn0b4CPZ+uulY059BT1lV3cvYlArosYPn0IKXVCrxUHYFgshpbSYLPS+Ph1QIfkVJ4/uspnq4lqquexZJsiH1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwGtMN9Os7jyoHslScncDC+cMQd/0IbRVAK0rBi5rg0=;
 b=APSCIvQFW9WaUjkWBY+nuPLUFNp6QMdPRrys2kOIiG8FcIDA0fNX2uaYklv5WYmK0LNryyOB4J3hB6kD0a16Ds1GI1PVG7Vw+z5YJdpG4LvIldiqXlq/SJMh/oGUFTLLocqP99WzUok0oXSZ31ch2WZhDbxy8bNU0uesF+FEqAif19BRWro89C9aDuyc0KeXwtrN8tjyQPKXCJ+rou5lMb4fHr6oALCzk267qEWKEZdTndaJPQG7p0PqUf7Gw4GtG0HLsUZM5MgT1QjLvQvJuS0tYR712ppQAcL+CzqLs8IqqdMyvxwhJ/1egISang8ySHCSMcR36xZi6Sqo1l30Ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV2PR08MB8172.eurprd08.prod.outlook.com (2603:10a6:150:7c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 11:57:25 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0159.018; Fri, 3 Jul 2026
 11:57:25 +0000
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
 Michal Simek <michal.simek@amd.com>,
 Sean Anderson <sean.anderson@linux.dev>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v15 16/24] pinctrl: add more pinconf/pinctrl definitions
Date: Fri,  3 Jul 2026 14:56:19 +0300
Message-ID: <20260703115627.2317120-17-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703115627.2317120-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260703115627.2317120-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0194.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::18) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV2PR08MB8172:EE_
X-MS-Office365-Filtering-Correlation-Id: de417343-9fee-45c1-7c4a-08ded8fa3fa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|52116014|23010399003|56012099006|11063799006|6133799003|18002099003|22082099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info: RVUbd9arL3GV31RU96+pHpzMTlFHbXrDliNJou3HTQlbUo5nw7Uw6pGmuIQLXAC/swx+nWNun2D8I4WmB0UCi621xUq+Vmf3npM2CQIR4MYktSzEsMUboysQ/ZvytgZ9Xyeg0irnFzPVTAOh4uQr2lg3ar+1Csdx91gBo5SCZhGhgn5JLWeu8AAjLlTbsKO6HmCCm7gZtxLpiRgctcdflD7RDqsDDCTgvXbVuqN31Lf9YULccdM5mFOfanN1w1fjDHeEAj7onTAmxT/8JW2E4JIcc1nuOvQp/iFlU5QIuQMFODtxxOGJ4sNurQOtLYv28zilNlNSREqPgZCSnYm7x7hpO+4y5B6wzfC+pePCkWKNWoVv/XiZtIVcSI/ZlTBJ6LaNyyKDncPZS11cZsbaxpBN4VNFHhNmAbJijtWWyTCRqp0HvLpbR0EJAI2wbKgb+M8f7KoVXkZB4/0YecIYxqCGXmPC3Mzn3Twj0jtj0W/PvkocFd6i6rG8UEknE3F5txff1ny+6lwt/WUE8FYlTQYvYSj7yEfk5o0gwZBYm2CBFRL7PxCpTklH/a+JeJpD1EltrVnVhq4lLSvnkC3IUB+MccT7/JkKPXejhsKY3hGPbscbgterYgF1H//Eyu2z73rH9B8ww3PMXY+f7ASAYVXyhSWHtwQwnREH+6rAFDA+Rx8SJff/G1xf2M81sg2vZawDZEgOuLYfRQutCQmgZTjXCFpcsH2tPxwbazcRA4bO2OM0VKB73i0KM8T8J8s9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(23010399003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?skMjiKOSHOPOYYbtrEcWu/sGfQTjHRFbk+NZLIoKQwRuskBFKXsw4cf7GDVn?=
 =?us-ascii?Q?U2mb4uHQ6nFSRcqahrIzx9ktcfKNKo5htw8PdEgDB6APEzHr0wwrS/6NIjkO?=
 =?us-ascii?Q?Xii0TwH44nVyFZbIEKdyvVyXlRgsdNNvH0CEcBmLX7j29Cv+nO7PmtJS1xqz?=
 =?us-ascii?Q?LuZ0/+4IeW1NphKoCpaWDtcPbSABaqeO3XJ8DaGn1DsTAVVzqfquXfFMNY5/?=
 =?us-ascii?Q?KTm5MGuOkDo6BQc/vnCnKj12DMtdoGe0E0BOk2D3JhmZ2BesRkVTmZWyHVB8?=
 =?us-ascii?Q?1g62g4WzUKbsJphDC7X4w5R1+GYf7aGk/e3Bxd58TyLwrNMA+NL+cWE23SVR?=
 =?us-ascii?Q?xcQ25ysX1vgQD2srx60vDS7bNMN4HTkDR9GyHzYr5LLrz1RSF0Hmrg0E3xC7?=
 =?us-ascii?Q?8HbjXuQHuv26PYnYasx2B1uzrMNZHWF32zkylTRHokaH4ceq9uuuOoBTjYkN?=
 =?us-ascii?Q?b86C6nroqlsT7lxXRZHD1S9LjhuUfO3pXrGUUJjvKhdibmFkyAvDj1Q/HTBW?=
 =?us-ascii?Q?G8Z2ouaBaziuZQT1H9Q1zY+Pq1i7GM3t1ngMqHlCgqocWaBI9X5HX8N3X3+r?=
 =?us-ascii?Q?3VmRMvMaycUuiKnv9SH15/pf96BI5lusmbbslkNtNOQWDy8IMCNa7Hff4NPe?=
 =?us-ascii?Q?dp7GO+JSV0tfYGJYo/vb0FFc3p9iyU6r7kMA7BXrc+EoO0dKZf1j9KZ5le0+?=
 =?us-ascii?Q?iUgS6J//Ufh3Ww/BDX7Z2eCB+PZP8Go6rpAQA6XaESVIhw+ev0dscne5UdxT?=
 =?us-ascii?Q?p2Ls/86HWUkt4D3DsASmVkP6NPTjqH73ftd1J51jrs2ZchMQ4da6qkbErkqx?=
 =?us-ascii?Q?/Jgxo2UQvGligizGcUU19HTmcIom3eSKtQAZ6D0DKYYT8P5A8ff7/7zHFtdK?=
 =?us-ascii?Q?UPPNWJYH0F/MOwQyNszCyNvevnR4Hz1GTZdju80NsPHJD5ev/NByKIp1duvW?=
 =?us-ascii?Q?3DDLLUnOPdnoTHZF616/RjDJKoVRbp974GXp6GP6LjWngz+a0Exj8mVAUvvm?=
 =?us-ascii?Q?a1/DOAfy4fW3EYjFmYSeL7toE4K9DZxqhzEi88cN0g6mWvLZ7jcFt1Z8KCEh?=
 =?us-ascii?Q?r3PkHOpxat4eiFojDcNxEjyzoZRT9x8uhX6nukv2oD8kByh5eagHNN4GgA20?=
 =?us-ascii?Q?67JBd+n8Fl6qclaiqPetROFtJlGC/Zc54To4dxL4iPyBjJ+hNCR5FYjcghz4?=
 =?us-ascii?Q?oGKQrVzOqFhuxZxc3uqpKFwXit1p85FgChElHclvZVbpRZZfpwNh9YM+a0ZU?=
 =?us-ascii?Q?8F1Qlr+kLm30lNu+F+rNNSCaiEroTrOmSHITryFA5reObRZWkKmU6f+uPR24?=
 =?us-ascii?Q?/ShxFgJF6zWui53nKPYzhgqxkLkShfTmx1dDMLpV3FGdkl4CjEzJGPZH4CkZ?=
 =?us-ascii?Q?7ZeHnrP1IYTw+CSXhYzofxP9H0SUfxY0g1EitVDvK5J7eZIfD9bh8M5QGE/0?=
 =?us-ascii?Q?hp5Muss3+g2z03D2nHT4JfeiiC0qmuzcbf0VhuVe9rDP9z4PfDf4MsR8278L?=
 =?us-ascii?Q?Ywt+rHDfGq1MFVd+g0IQ962w1lpf1E4+aRKRJ8saXXNQqBuzAPkNSOfjLskt?=
 =?us-ascii?Q?+0caBhaO/6hGLhUdj/a66U13psBLUy31d14A9ZI4CH6IugpnOncTlt3OQAb1?=
 =?us-ascii?Q?MKPfTnSC0kgDiZj4/AWhxxHQW/Pn7hsgoXTVuRMk2C6TzWxMpJv5hFc94OLA?=
 =?us-ascii?Q?hNGuwe0+mX08USgPAfvFSBzg/JEE8JQp5douFOO1ZGlCuvNKx2gNZLj/HV/J?=
 =?us-ascii?Q?x/38WogYwjbjgQ2WtxOKqDkQmW5cI9g=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: de417343-9fee-45c1-7c4a-08ded8fa3fa7
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 11:57:25.6697 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fXgwee30YPwL2zvTUgmsmKseS3xntPZYKivzs4+VBATxUOaFK1ka218CVm55eumzPMenlN5PUJbVW3SkPUDcNoJsusER9zNrfUwD3IWF47g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8172
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

