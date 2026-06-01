Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 787C4CD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 19:54:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5684848C6;
	Mon,  1 Jun 2026 21:53:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="fVw/iAne";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40F75801A9; Mon,  1 Jun 2026 21:53:32 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B768E848A6
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 21:53:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FdMpOnQwyBIZmGaM0je/NNeLqkArIwaSoqxLsGOLSAXo1735Q/so6JoiCid/TrU8bbhEywq6aZ2b5ztIfxUlEVnkiJoWy2StbGm2K58rAmBgU26XCvzdtoZ8WaLzb4zIKGKbKoEeoQ7TlzV5JK2NrNPrRB0RUqe4HCv99y2CJeDyi1p7VMjnO93pv/KHT+j2hzeytwcptoTu1BFJy2DXVkYWmJDmxpiXxHk2/XlG43jz1DbyzItpQlhKREEBy2KQvUvniDUbxWeM4+zV2krYgw18VxVjK4IDz6L+b3c5NZ6/cCSgbhwNXl3JRR3uFH1E6I88P25hikLZQGCSn43z4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwGtMN9Os7jyoHslScncDC+cMQd/0IbRVAK0rBi5rg0=;
 b=sljdpWQXMf4X/EqEp2dKVvCuZSljjnXMmEuryw1/WM12KQ18q3dYgJxmBOE1TftG1MWfqnSr+tn1vJ8YRM0+29ViOXSpvG3wlQWpba3nDfQQV7kfhKi593wyekqOISlEozphXGgvLMq+wBq+kBoXGCqI2Sc0cQz7FJdh7GjynVGGCLYuhuIBEJVBS483ookleO1X0/Y6w+DY+F/dgbsGPoOxNJ6VjHvNEP6ZfbIaT2Uz5i8EabsvRj5Chxkc7Zne62oNsCfy7cGgNNZMe4wpyDNJ4B1jrA2lVK+gXEEVwR7OYyAhcO+uIjzvMRdJ0XOam+iQkUCJpDLLoPC5d26MJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwGtMN9Os7jyoHslScncDC+cMQd/0IbRVAK0rBi5rg0=;
 b=fVw/iAnekKN3SralmfZ9wYZzrHRPQ9jbForzAcB4maI2GK5nAkX9xOCSpel4XBnl7RncxGy9H1gMsZoU5Jh6DLoSP+B/R5TTcYRUZET/PUb0zoAWjtqZD+UncbuO4I+Yh0+qL0jB8MI7+59gN2zdIjBnJ6kZvCPOGAeXuGkuvDYn5qOCSah/uRUnj2JI5VDQEC9HtoIsVASUA3Sf0vmYW6Zfl1Atg/hhiZPphl5oNGLm0tBgIQ7mTg4BDk3vQdZoN9Zs7ejXqyN9j8NFOpN00kWOjSQ97g30vQaDQGS18GJtFgGHOASFQdJirEyMkWZwjlHu+fQ3G8dKEB0Htd1WHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DBAPR08MB5653.eurprd08.prod.outlook.com (2603:10a6:10:1a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 19:53:28 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 19:53:27 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <sean.anderson@linux.dev>, Anis Chali <chalianis1@gmail.com>,
 Yao Zi <me@ziyao.cc>, Michal Simek <michal.simek@amd.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Crt Mori <cmo@melexis.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v11 04/12] pinctrl: add more pinconf/pinctrl definitions
Date: Mon,  1 Jun 2026 22:53:03 +0300
Message-ID: <20260601195311.2390473-5-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260601195311.2390473-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260601195311.2390473-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0025.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::35) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DBAPR08MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: 388d6555-e047-47c8-7957-08dec01772ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|52116014|7416014|38350700014|921020|22082099003|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 2UttR/9hAfInrFj8Mr880bk+0a0wbVJoodVNpai+vjgqkJgLVcScoym1B2LH/kwr+rhyCUCJpgKX2hL76Pm4k60oMyLHjcMpOgiTjRnys14ItUrSu7+LOZ936KK1ZNZKXS7FqYOiSxMOuM0gX4eUaEjEAk8E0I5hxJQZdVLTel+cTkavwQdHQPtpfLzqCdi922hFAHNbVoPFhpjyi6jgEHtJe/nIc/RcFZRITAzReUJn1huMDg2/rP5cdXNoLZRL9DkdHl4s1AXLotyofT8z8qgBc9ImMQ6zysi2/XI15RNwN46a4VNExDJY/hwKDEP/BToejf6bSbyTbi+SG8QCjFPzuqVT/7Uee9d3Qt+mpg4FAV+pTUoe6jM3mtoc0gUjUZf75CIeQSBWjkNXA508Ml8Zs83ZmYt1y3vuA5Ip1Rnmb3mkdeAHKC/DZBDXEwaGywpVm4sFJ2fdfmlfK2157/KAwAg7c93cKpeAzv+wi5fLqDPE+Z2hR95GQVPRkQHgm64yUWUZZK2LdTG8mDinr+1wfYtUuB5gb9SDtEkHgqGYk86YYpqMCaZlJPdBonIWUsuAH/4UVRw8yq2vMXFFRxoAyV1alLwGYPw5C2hapbVYkVMuje5xQyI/oL2DAj1BPr5LzS0PDPO4cKLSJKEBs35UtRbzmn0CTlFBl47fwn3vpWoD1HeHM6xoYr3VqENP8lOH54+PwSPh3zS/AUlAqeyNoqWMKk8z/cSG2ro/j28h+A7UANwhB62vOk7lCrgd6FAX1d89TJoVH8rCX5hXcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(52116014)(7416014)(38350700014)(921020)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DVFT0iWhCNpY5d2uGxJodnaVlp8QsUT/OA6w62vPrdPXlOSU4ik28Xpyyqlv?=
 =?us-ascii?Q?E1R7oUmNAfDi8YoOFQl2p8MXNRVas2t9DTD8hSjT9ZZ4kC7+93htZ8ngOums?=
 =?us-ascii?Q?nVVQduI4PjKddVTLyu88ISjVxi3dSTns/R4Lx7gFDYMMVWMlQLASk8ZpGVAR?=
 =?us-ascii?Q?bwpKRAy5jFrJY2O730IQ1uyVf8lBvMCEpKU7X8ZGbkCHD/GEopEt0xLrPcev?=
 =?us-ascii?Q?7/YCu9fVlSdy6IP40tCqxEt91/m4MqptGIIMDMTQl761JPu5Cw2ZtYQ/8U1m?=
 =?us-ascii?Q?x2x9szN01IZrP6+xH02VKnGT4Hgwh+r1V1D1ij+gkIdfNmFVsfv7EJPvzfvQ?=
 =?us-ascii?Q?Pu4RCGdvw+XCKZGisJa2breGMkyQ4goUCKWwhJfcuu3tC//thcVQWvNpsIF8?=
 =?us-ascii?Q?R8Kd2qEhZisrSRXbQJhKbRlSrpsAvhIWWEcDEVTerWM/1CPsGc0e0NWFFZZM?=
 =?us-ascii?Q?KGq0fEB+5eSylPOYNtvATGp2NunpgwGSH2GxlzABdpUYNdBMuTYWxy2qkFF7?=
 =?us-ascii?Q?kWGpaH68ZAuhwC6MwTTTtK3/50K1iRJaXyAAjrC8T8vKT+ZE7g9OFIhcnO0+?=
 =?us-ascii?Q?eBfBX/H2VRABW5Imeu0l0tBd0YH3Ily0dMR33Oy77yGUi86+DIeNL8Al/zAM?=
 =?us-ascii?Q?9gY4LEH/cWtd6xC/qltTF8osggyQulZCYLHw2sMlHoAm+elbgt2XXTsmTjfd?=
 =?us-ascii?Q?dmWgNzRB9+OIJj+5rdSyyGIACZqiVvKzuVG9WUIJkID72tOobz41WewUAuna?=
 =?us-ascii?Q?aXyk/Z8Aj/VQXac2dueFqJQPsq0GLa5m17EomeaKLfYMJOEzWSeF5dgxGBW8?=
 =?us-ascii?Q?zYrHJCB09HEYlMsQv3XYCurmZmICZ+bwgQxY0hvqEyFw/p+8TVjtB/RVXWL9?=
 =?us-ascii?Q?PpFlBw8sctRj7OjYh/gQ6KdmJ92pPdkkSNwRIW1Cj94sqoeOoz6W3iXJxFZM?=
 =?us-ascii?Q?/A62nWlr5duGqeYv4pFz+CQKOQunkZMb0hKtGJo6N+3dZDhm12j++UCV8mI4?=
 =?us-ascii?Q?gUESkMOgas0Q6PcFjTI07sm05JJf04z4ub5Xvc82PXEkUmWCettmLMmXg+y6?=
 =?us-ascii?Q?vwijAAUym55mjngB7PS3XoV/Fj+p5R/C/lfHR/orbc9WSoiDM61D+BOOIxGS?=
 =?us-ascii?Q?OkLFUcXGkh8FNk/taCRV1RrFk4xmhqlJgb4n/1kH3/POcYt24yo4wdmssN17?=
 =?us-ascii?Q?ED9Bi6PYc3GnEENSdqYRuCYS+42yYHlMN2xhy6W6RIc9DoGRlj2cGn7t9k65?=
 =?us-ascii?Q?sZG22S00dRmva10cT77zweYwSRNhY5+wU8Sc4HPHBKfVs1xu2p9iVxoNNil4?=
 =?us-ascii?Q?yk8YAeTKTruY5Ucqo2KNqqNE+ff7k+f8YlxjdFa0L4+TEbre7LBuYoy+0MUr?=
 =?us-ascii?Q?KNdTqrFZqaizbIYQchm+u/UkMxC42QJ6J2T+MX7w5whGc/wKpiUmlcuLvGQk?=
 =?us-ascii?Q?eocYlDpbmbOy/L7wEeWb8h/1Xo/kqxhUHssOP6ZPGYnyBU0upvK2FLmXk54Z?=
 =?us-ascii?Q?c7fuXJo0a7CK/M4z53qtdFIgvlyVHAa80flDX9430qUb9HefFhVwxd/eqFRK?=
 =?us-ascii?Q?LVUEdrL+yAjzDl3qhNE+RM+wZWP0NOk4MeijWzdEXAAmwpgZ140nJ049QAKa?=
 =?us-ascii?Q?ZzZG3dInsNxfUEXg9ZHI/95xTTR/8U/VRGL0s0vvtGDryH25an8bn4FY6j/j?=
 =?us-ascii?Q?wHbCQswzrAZb76WxevEoJ3Nw1jQiTNRTHWPRrZtQR2WTdKOgeGCFPI+SGbBd?=
 =?us-ascii?Q?+faFAPnHhGxIwaY3B/oKXxMTTcax2gE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 388d6555-e047-47c8-7957-08dec01772ea
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 19:53:27.9616 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UHuSVMZcN3C0iuUbdjfgSRyolqS0iqon+L45pthOC4KjgikH5ySXKH97WuTeEO1zkYjhDO92MIo2Qc9nBFTUwJzxP27j8zVd28vRqGAVmsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5653
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

