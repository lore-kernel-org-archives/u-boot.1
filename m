Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 984A9FF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 00:35:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2837E84656;
	Mon,  4 May 2026 02:34:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="ng45EHDe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F35028464D; Mon,  4 May 2026 02:34:45 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F419884605
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 02:34:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SzfaorUpwVAjjbNqYRrsrAolH04g5OkSWT5GJ6kp6iZF9IsklNRgNb/l5FKm5tun9HTmC7U9XulGOXUQvoK76HqbpmuX+K+sw1jGlrDKnOrKYzRYfMP3pZVtCSfrFFKjFDjYxDQlZhK8aSUMe7C6ZfUjdvty0YeLxfFMIDi+YlEuI+o1BHV7tqACS/O/hbTdTUpZ1gwIsg2811n9Nxc26Tlp2+Ac6gov1QYr2XGPTNeMEdIRJ/D9fSZpq7euluQOkbyW6gD6ga6TXOpv9EaVhuojPlvMHjc4S9/YomWfnLbEgER4f6+PSxpkaW2Qm1RiZ/kxQPSp3++Xc9K3pSc20g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81mIX4A5l8chV4yjp/FNxXOsXcyzxT8V4QMyBmdXwRE=;
 b=gID+2q0YP/TGLEFIZhnytUzLOIgxm+vSUVCl3kqbNgCCABwngp5Wc942OTRi91nxMEZ/GrkJJqn7RM3/PqDwEmNeA/QhfqQ3F+t3XsKUFyuj9aLFukJVj0fNGiMPz1akbHNQ6x47DYtRbgLtbU6rWOb+L0v08daGa5Qfkr+lASmYB88FHUc1h7WAcNVcV/Y6rhIOZYDESqbP1h2cKmQep2f+1de5JKKyajokpMp1CniKeZToRoEoLp5ZGumzvBdbvl/nqCGLjrvPxcz8axnrYqi6DY7guESYUJZ1nXzMVNAxNj4Lp3hmMASuxKZHoiibyyZumgolOafjLyJj1/Op1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81mIX4A5l8chV4yjp/FNxXOsXcyzxT8V4QMyBmdXwRE=;
 b=ng45EHDex/AiVJG5u1cqv0SSf4f1r0CTfZxvSW02YnxF81KlraHRSTiuCtR5SW//N5FZDmmgBzrGDL+U7egXhNLj1LXeaPlJ/B3v+n5/UH8hcdPqFlaTXN7y/eMECghRQSj1j7nRKGzQEhY3D2QF5rkX+kHLnaM+UlghM8zxkh9JGVqLgV+S5cciwtBXRbhiUgdR5UD7/5NtGha/Tkgfx2qZr3tsCx+BosmdzXcKVpKjaM+jJ27sTOC6WOpOelCqWxlVCrjmBn9v1FxjduLbH+TuzHjdJiOgzdQlhRXi3KRGyU2h834/ZqHrZvYvMfGQmwiN40WDQj9/WaG+8bYqWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from VI1PR08MB10029.eurprd08.prod.outlook.com
 (2603:10a6:800:1c6::15) by DU0PR08MB8662.eurprd08.prod.outlook.com
 (2603:10a6:10:402::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 00:34:42 +0000
Received: from VI1PR08MB10029.eurprd08.prod.outlook.com
 ([fe80::5e67:2d67:644b:9681]) by VI1PR08MB10029.eurprd08.prod.outlook.com
 ([fe80::5e67:2d67:644b:9681%6]) with mapi id 15.20.9846.025; Mon, 4 May 2026
 00:34:42 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Anis Chali <chalianis1@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Crt Mori <cmo@melexis.com>, Richard Genoud <richard.genoud@bootlin.com>,
 u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 2/9] pinctrl: add more pinconf/pinctrl definitions
Date: Mon,  4 May 2026 03:34:14 +0300
Message-ID: <20260504003421.2545713-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504003421.2545713-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260504003421.2545713-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00023A03.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::2aa) To VI1PR08MB10029.eurprd08.prod.outlook.com
 (2603:10a6:800:1c6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR08MB10029:EE_|DU0PR08MB8662:EE_
X-MS-Office365-Filtering-Correlation-Id: ff34b7a9-1757-4edd-ab7c-08dea974eeac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: lym0JghsFysdFku/1feSR6qBrYn8aB5Bsd0lzfjt2TQQiIxCtC+fNlxh/43C431lxeqWMzWXVLh1vGAO8VR+y90AgLVTybYcelVTOUemrCuD00vJDE9FvHSiNKYpH7ldjvD59MSSzg0OaY6HY68UjAg5ACeK2EC+0uZaooEOwVIHmjEJPTLHukDk8/ELbw567/VcRVwP7Td1fBHt9wMTlRtbHf9975khZhrbCNeWKkCx8m4InnDY03doF/JYyDJ8fN9Sy5U17RDigeea+N8mVzc/kZwSoz0u92qyfkafyJBG/gmfsngLlazJ/2aKokswlNSj/UuMJT+0LalXOtSIdG5PTTEH0m56letwr0irf8EWC8Ae3xmtTZYnpUv+PjGrN7izoRWIkk8h4BmaJFyYC+mzlCOrvapl0/LvuZRjXgmwC7ccqXA8FMYc5iHCy+ZlrAskA5smafTkDnqyxy+tzXRelDn0KAxT/jUMA/aP4lGQ3Q+r7uaCSFM/970ZngoTTjcTN1IoImVjS9+SeJQF/qDlS4cSJEVZ5/yovGbHyzJFbHQBnsp4Qe/R7GnRs5C18HZ17yxCf/6iYYjSz/NmjSmo1EyHtJU7nl9Gkvthqu8BestyANoGMFY07Miz4AtkAmt8AqSlK53Jpyf/4zEBVjqbvunWrrROXBouBpTgVF+U2AQ3AzrxN95d84B4eV/jpUlDYYFJ/zL4RR8WpIs+o3UHUBv8+EWJaKYOhoHpI1sGgGPgR/3CbbjgwUBeUGo/Tb+he/zPkMRXZu9G/Yr6bw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB10029.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014)(921020)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JACpzjoJRnOovDF/UbGIvQivl8BigRZsnnbVzq1V4cSTJXs0KaSQwt6iw0AD?=
 =?us-ascii?Q?W5EWsKmKihno6/pe2WkCDqFPePBAJSQsqlzI2LEvWh6rdhrVlSknP9oDeKbv?=
 =?us-ascii?Q?0ym4ytJrMBmat8bOurasf953o1cnZi54ZSFM0yAooZCzxfY7qnCbkh0xRYV/?=
 =?us-ascii?Q?Qe6SkQPIZZCpW6o6etjHkveqkfytkpbSLNhoOZCOu8xAEsUSxF/oGvXk3TT8?=
 =?us-ascii?Q?qJvKEJ2e/sGduy0PxT8cC8ml8SXEK1MlrlH0iR7nU/LAwm2NFcV5PBgwyMpt?=
 =?us-ascii?Q?yHAxtwLbV3QvltuGPMJXRjO4Z5dp5ndqsIlqOOlNdjrH27S1Q8FHqT1Ox9OP?=
 =?us-ascii?Q?Bztb+RFB14Q69Oy8xvFyYX1IsNNslv2y7pIN27K24o2K3dXhTIG1aYdPwOdR?=
 =?us-ascii?Q?zqXLILK46UTcqhiKMH3SbVKKgI66nebqrDvIf6anFEKW0pEqE9Yhki51yXLa?=
 =?us-ascii?Q?zw9TyzPtylPYa31/cUx3dI+IpkAjzjCQjrrZ/a6Ka8djiGE1RtYFmfal9Jiy?=
 =?us-ascii?Q?qGgaAqipwG1O4fvXnqjcChXujmwwLhcfWVA90mM1glyX2mneJUfGqUuwjS/a?=
 =?us-ascii?Q?WSsIPt5pLwch8GjgRj8aIQjR4HqbrH1jAE1HicQX4a9yc+QZrMuFQkKqRFPp?=
 =?us-ascii?Q?T/OQJOgNeKfMgGT7MqcZSj4xOWvyC+lnhxOVejyNP3f+cqleKiXMrpxkI50l?=
 =?us-ascii?Q?ZrN7NQYgsIIVYXV4ZAmWtiRL0N3625ZF+4Ph3342QWSI3bMVAfT0f/a+k5AF?=
 =?us-ascii?Q?5pOX5nUExdGoYHWF9WLwRjh83DwJnDWQssB/D0PHowLQR++euFPY2NWqSkvj?=
 =?us-ascii?Q?FufQMAtxz6otg2dawMoIDrnZH2v2cbc4UYOk744A7QWCx/mRZw1rDjG9O0iH?=
 =?us-ascii?Q?Npfso8LxAFUCFZ381yEBbigrxfTn2gui6MfubqKMGqoLrKD21bljfSrdfMnN?=
 =?us-ascii?Q?gLlY0MkUd2o5VLgQEeeQ1Pz+BieSigWtiKp8Z3mOz7z1HMQrL9DUbEBfKnQB?=
 =?us-ascii?Q?eZ6xMjUANwQ9hdoWlSsnfe7gFXu8zzWVYWrqly8/nDXsIhCj4AfotuLguPCQ?=
 =?us-ascii?Q?xo5MSkRmEF9DXrR4RRtiC662Yf7rdwgaGLIN9khMj3TccjoYp6c5I/cdKIY3?=
 =?us-ascii?Q?tQJip/BXGqin4+WJbPNETA0+YKfE5DC/T8fvR/bLiDwh6i2zVfVMEhcfBPVY?=
 =?us-ascii?Q?43D/DTVv/3ug4kubTRueKAhxfa9iaeTtjsI1mPbP88Qg56ZP6buvSowJeQsD?=
 =?us-ascii?Q?hVOsQk/3D0CNEzI0HdoW6vhQKVdJD5VJkg3dBK3yaWPmEqT6h5N/nxYWrPfh?=
 =?us-ascii?Q?vbTMWaPmJnE8XSaREeiLHdx1WB8gwYdzG0xWIv8Hldur2651GDA6RNygk836?=
 =?us-ascii?Q?jOZebel0M/SfLobXRCEAU0XFEaMqc1YLsu69w8jILBHLxURsMKUzlJoZYXtw?=
 =?us-ascii?Q?iRkY8PkvzQyy1k5+vtUDg0qlJFQCeUxYKKtSsto3ioDbWLK1st2JKvBSG3Xg?=
 =?us-ascii?Q?TWxbt+DrhbwuGYphFHDMmLQHfQ/k9GeTlhwig3Khr3omM/SPLbvv3T8TAraV?=
 =?us-ascii?Q?rhqZ9Cr0LlASMQF403azWcAPbZ5PkS+URJ13bp7b3arm0bRLAK++tOnGJ2Gt?=
 =?us-ascii?Q?yRtEIAmEQBNaIKT7sbi1sYBWP94BYshgLU/tsWTOtQcuD629SjNXg7No2Aeg?=
 =?us-ascii?Q?3NbnewlAo8jwQliqHurj4stygwCpNXgtmf6UJ2OgVpH4fFTFWG8X6lIofe2h?=
 =?us-ascii?Q?ulR1QksEBYfJRiYDSQpEYeYpd7Zhm8A=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ff34b7a9-1757-4edd-ab7c-08dea974eeac
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB10029.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 00:34:42.0997 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ARYWxZSOF4jHJxgbpKW1gwYfbVz2gOSL4d+lm/eC/6TDFB+8QMxaUP98ypQG2yQ8dL06YXyjFU89BuOiuJ7vpN+guFUJ4z4rKeUgpIVfeJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8662
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

