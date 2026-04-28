Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 708AFFF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 15:35:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81C29843D4;
	Tue, 28 Apr 2026 17:35:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="qgId7s8l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D94984605; Tue, 28 Apr 2026 17:35:05 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A0B98426E
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 17:35:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nIERwPAP8186xkf1//oODerdQI2JKbBcMdsKn422flsQUXQyi8ujn2uakPR66uZWtaXN31O/imUIkH+c4KM2KANQ6Q5M2391L2x1cOk9W8hiUhFHiQ+zE04x4+eePuf8s6XYC2RWpCX/KHOtZ9BPegwioH7HPIUmZLr99T2vfyHi+nqDL0IM5/dzSCmhM4QQsUWKwEe+xql022fo9+QOaERI0uLt+pZabNEGp24BqmiSFsX1mHBLhZdFTvt29xsabbjJrHF1S1Fkvz2MpAOtDMlOgB7odNEqOsaU/AkJkeN6qI2TbKC3KohUskC0WOtZjxm5IOMsiN7hLEHl2SiSxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jS1OMvRLFgeFb1d5XZEmq0MIIflUA4UlylOxNmmYhV8=;
 b=aq6dpehgkYKd08DHaW2QYnoyiV3ElZCVJHn8T3ZozhagBymUSxIVvRYUi11gRISzx7Glygpvi+weB5U1+vQAe132JX0hPZrhRduLqoKna1QKb2DI+nWaGYxGZy909bq4SDc3+Y+o3eBa0KzbfYZwvep9CXPXJlKu/qucbs/MbW+UIZT/CWPO/uKZHJB5iyCsuh7vRiLFI5DG1n7ukIcjr/DMewsqKoLX/KTiJAupZko8CdcnurNkUaF845bU9OfVqKbTQDArS5Qyc+nKPJhQCLRjQIoA1G4bWfPUijv0vlIcorByLKCykh0UlA7GVUvGQhBOjawYh3SH4U4rjemdkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jS1OMvRLFgeFb1d5XZEmq0MIIflUA4UlylOxNmmYhV8=;
 b=qgId7s8lEe640UHI3jz1k1mn1Qe0D48eBez/2h5vdKVMUdGmju0PYl6GuJSlyxEwCiOQvak/vnlnocb0XTGLqSdvgBUkDBHSJeAAQfoLfoGUv0SsAAjh8pps0KPqpUwUeFBgBmGl7hf3a2AE20d+NDQ6OuIyjX7wHfKswvA4k38kFjiPTSB8R0B1wJ/TPcmjJ2linblgQdOO5u6RwymlyKbuTu1Tf/61pW0PkGNEAAG7VGMaxENF3mtdAEG4okHxBRCUOJno3Zf6/9pjaPYrNSeG7DlTtSYW6VS6sm4+18UavmV14eRB7XXPfDKbudYwFWmUyOiUFAjbLe4a79bhQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PAXPR08MB6720.eurprd08.prod.outlook.com (2603:10a6:102:130::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 15:34:58 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 15:34:58 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 Michal Simek <michal.simek@amd.com>, Anis Chali <chalianis1@gmail.com>,
 u-boot@lists.denx.de, Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>,
 David Lechner <dlechner@baylibre.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 1/6] pinctrl: add missed pinconf/pinctrl definitions
Date: Tue, 28 Apr 2026 18:34:43 +0300
Message-ID: <20260428153448.980150-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428153448.980150-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260428153448.980150-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::17) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|PAXPR08MB6720:EE_
X-MS-Office365-Filtering-Correlation-Id: c51f8a06-eea9-4ba2-6c31-08dea53bb43d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|52116014|56012099003|18002099003|22082099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info: mt3CnNTzBvUkppho/zmzoezQvbpU+4iigtihaWFa67bmVmbyMXmADQDD5vsm4igC7yTC3cjnfT6RkkFvpOMa2v/aLF5I1snm7vRZiazDoVibIBnwo6rvu8ifuTvc85irSEDuKFcnlm9ZKdUQDOJkrCBi9nrGtNUUzaKfNHOG9uiwRM8uf+jm9uyvXV3m1rLezp8IoaUGNJR+i41BWNvue75agNyh/0Q6HJayonu9zB3FMPYzQc6chZzE+xrrK8gwDNYOKXfvnDrnw4KxFxJAxh2V4qQ6wZjk/uW8vb7DEvvN+Yk9x+QGrE4YeL7k3JIV063aHE1bR6A+TjmNAWYmSffD/LwN/rhZtqJC4ut2h4idHIUS/KXejlUmG/tLpExxIA5BuypbcZKik2LryxKuglI19xQmzM867Y7FP/ipsVCH2PzOn0Ot5LqPciA6QoG4avurWGrqGQVzSYbTbLQ/7m87kDC65azHLh5uv8NENYhAHCGLeCdJGLUN/Y6wkyQ3Q5F19+DcsuFKqYwmJFzkB7lgAsBJrBma5LrZneizj9FHCRYRe+rqqkehs1DMaQ2fv/nXn9hZyoQnHUcpLTvHajs7XFZdP2zUwSoZC5OPrhc0I7vS36Giyy6g356JLJqHiKA0U5a/qF08BiYaGj0uvAXcpBGbGN8HfV8mtS2OOpskg+Bi3881CoNJactT/iPGb+ZkstTqA1HZ4sETrhesk6wzHGHswYEpQnzluErU/2n7TKR1q0JqLrVxoQQvAAe8g6Kuqt31/zs98pHJi9IeNLz9KsugHa0azjqeb6pQQbeCDSzCxzjHtTtWo+DsK5S+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(56012099003)(18002099003)(22082099003)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5bwieUyJWFfCDTtziTq9MSfMp6mOhui3x9PRuDySL5UFaTqxiSO2iQyBStkq?=
 =?us-ascii?Q?vrnUWZ8h8TvF6DMwuW6nIbzZaFW2TAxk7OL8WTN8m5JFP4dYZ2EHkxLGiKrW?=
 =?us-ascii?Q?gkR4VnbEE67/A9ZSgRMC/z9mtMV8EuItM9e0fylsgtTFHGHKdywl0NsLv55t?=
 =?us-ascii?Q?BYPDpXOwRvOziK/gLdtUcpeu7yxb3f2b9E0xOsV94q1yRGKwfRD/7BnTDUjk?=
 =?us-ascii?Q?NTXt0FCDWRwbCssVdTlkMKwuQBIKdbDP4mn5aLhBuoLKY9s8fJC02ca7UrQD?=
 =?us-ascii?Q?yFCw5h6gkEabSe1YfJCAaHDnwqvQQGFRY7YwHttKr/BQUhdZkhFSv+y6NEme?=
 =?us-ascii?Q?GOLZsJ66KjRqwlpxIKTFO5ohNqZz/R0z6az94wDimMrWDe0vrgdzfJuw4qXT?=
 =?us-ascii?Q?2eLBRR+TlhhES34fDIudwElPhnlVP3DcCHdh5OhxXLT599QVcS03GqdmFVKj?=
 =?us-ascii?Q?LqBEIrWqloXCRdUzqATYftwAz1QR44GDlXLzcZJyrpkewx3iA4qpQFPU1amo?=
 =?us-ascii?Q?PtbHM40vLc3rQ1tFl/05+jVm0u5e9HwQguJ7kwLPy32RoWGoNwa+KtZ63JBy?=
 =?us-ascii?Q?fTJpz8XP0VHBzTLQkARtDckydVVHJSa2YGVutJsLBa5KyHek2762oq7kr1ka?=
 =?us-ascii?Q?Evtvr9Rd9HHzxdWgq86y2kpQIYIYx70SKPwhh5HB/E5ittW9UyvbWb2ry7jo?=
 =?us-ascii?Q?9G6Rs7z6JoFjsKzP5o1qg0SdqRMED9jtUnM2VXp3i3ENKj1ov7jQDganSwyJ?=
 =?us-ascii?Q?eEcTs4B7U0MUpYLInoxOWw9ORb4rlX+URI2+hMetRqEz/QWeJP1MwTVksw75?=
 =?us-ascii?Q?HTvDGVcbd9hCzVfkCpfpTdswTHAQmNgqyoUHmDzK32+JH5UsRCN6lB3xQ/oo?=
 =?us-ascii?Q?Ohvwr+kVQzNumsKDoARE5qZcDzmkG2EEddVfo+Y68RikHp7g1LHeRwwC3EGp?=
 =?us-ascii?Q?ikx1yxtxYd2ChJiBSo41G/GPkwo+vbhoc4mMNngjRsPUseuiMfzSErouz0yv?=
 =?us-ascii?Q?MO/ki45oLvu5RlKrsCspOhjPVL+RoZYZceWypLScXNPVDSQrKjBYG8P0sc3d?=
 =?us-ascii?Q?seGmHfwL+Jkn+8BZErvMEjVwzW1hLhAOuGyeb0Tjt5QAOVIaUOd+D46keLJW?=
 =?us-ascii?Q?hCtnbPaI+jHtRb6W8+CPqwxZHKArg9L3fVwfzi1yH8oliJ3HVpX+Cmbh5ElA?=
 =?us-ascii?Q?H/CeFW1vhuyA3L7xNMWIiaykwzKVY1zL3h5Bz8GraiRCisOQDsryy5u2mByx?=
 =?us-ascii?Q?xKYVOT1DzN2hgZchuohgomDuqkLMNRCjw9DoRZqZxw9mFy4IGrJfazQvntlj?=
 =?us-ascii?Q?5BOKkU2PQkKYrTuTqEEEeliNrMbALTRy3NYE4eV9UL5D1mhI4UzUvPLsdNjA?=
 =?us-ascii?Q?nzYbYYGJswNDEcrEGoHNnEzKBRL3NiH/X6s67MDTA9vHWgEJ1MY5Py3gjBEp?=
 =?us-ascii?Q?zluH3tCrCgojVDNLoXWq3XpbOddixkuBNy4LHb4EiKO6JsY5lq3m6NYyRgkj?=
 =?us-ascii?Q?VlBRDOWBWgJqjweSTPOLZAs+jZA4NDRb/UuekbbCPguSywsFH1LRX7o4gpTn?=
 =?us-ascii?Q?VxhqlpB0EOoTQuYN2shgZkXJhxRMubit7fzyZnRFUD8vKMA99l/xl3iEFsDh?=
 =?us-ascii?Q?SwCQg5S4j1BeqV1HQwHr5ZyX9L/BQAyeejExJ4/VsHRkwSRiPyHuwVZYjCmT?=
 =?us-ascii?Q?7h0A4PBVEOHyVczerafloeUGWiWfUwvEO7e0SjSWiGtch4fEFF69C1cw8aIt?=
 =?us-ascii?Q?rtTd4cb0h1prHHS1VnDbSsQRBlS3syI=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c51f8a06-eea9-4ba2-6c31-08dea53bb43d
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 15:34:58.0167 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FdK0uawfjy/jgYVTMeeQPCU1MOuSq6LmyxZ1ajsnQ4xTgSUxFirItrLg+CDYen54Gf9VM3JuZx0Qe3QC0SXXxssQD7EO+PkJF54oGYpDhb0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6720
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

The code was taken from linux-7.0

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

