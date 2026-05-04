Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA88DFF886F
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 13:03:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA73E8468B;
	Mon,  4 May 2026 15:03:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="UP2tRAsG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA6D2846A5; Mon,  4 May 2026 15:03:26 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDF2884666
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 15:03:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JEl7oE4DGF6Tp24i/dhnSuYq8L/XvHg6J0l6WsPqtzydmgq56Mp/A668ORe+tpNXC9eV3ZTyCdhgYOCraV3HlrrNIAATR2J+Khuk58phnweFgoe8DKV6GjgeZTM8MbNOA49IRdTWs+G3l1rqhNxlrst0P2wmIoZ309I2iozPL70BtiK5fyTmZhJxG+rP8peErPYoo2Udr7WS9sVUwwNeFCrzZzHy+zRrS8emj+aQnaN6kUlYKCe68q4MtScgoyQf0W7+hsE3T4wxjq0j09h8iDkuzt/Zw4ORdlNr1WyrkerNU4YQQhelmB6rF4Uv8Yez01M2h52RCsCIec9PPnDyXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81mIX4A5l8chV4yjp/FNxXOsXcyzxT8V4QMyBmdXwRE=;
 b=hOliXoKzeS9a1ury9czRVILFwJD7zS1NomP6M0KpdObhGMYrrOFG0zrhr0Iz6OO46Xd6Zv6NetoZGpxN+fXqLFWU7WiIotbzjo9DNGIMlCK3pYs2QBf6JBR2ZMwOwtk4MoadPSK3rHerzGbZbu5kF8TqZUCNX8vr/wNiwY31mXIFOSEMiTS78xhE8oLU+UDmuJyt0Lrl3AJNYkdFR9J35D8HUbtClGPEwhMCPrJ5KjwShB1SO3PUItBSt72/+S12N2dqhmbTeWg92CqojirbW7UDAiJv1bDCMbm+tAQsHd35fnNDDbEckiF+TS0kyG3ag2z16FMetYEXOt0LcitN5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81mIX4A5l8chV4yjp/FNxXOsXcyzxT8V4QMyBmdXwRE=;
 b=UP2tRAsGSNE7l/1BWNLXh6DclkbOzOEUEA1CgV88h18kGo6SyT/khXnv0oc/6AmyP9KU3SbkiBRIH+GnmdlDpnKPQOCae0khRpgLHMtn3NvSHB8fYZ7jqtLrVb3eW2N1suqXqQsGGVzI+zFf1qttzGFspSYF8brGeqUaWkV1hxiBh2kQ8ZRIM1fJIdM15p6XID4E6l/Ygeb1O4C+GFTa+JFbpHE46Y1o849WuQo9uAl1kiID/CchzrpG5Ifd7T6KB09F8oY0zq6+2IUr/nvoQS+JhsPKtqjvm2Nsw0hzYQY7Y4RSmuVI9fSVKVD29CBr2k21j5LU428ME32juzsAlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV2PR08MB8098.eurprd08.prod.outlook.com (2603:10a6:150:76::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 13:03:19 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 13:03:19 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 Anis Chali <chalianis1@gmail.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>, Crt Mori <cmo@melexis.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, u-boot@lists.denx.de,
 David Lechner <dlechner@baylibre.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 2/9] pinctrl: add more pinconf/pinctrl definitions
Date: Mon,  4 May 2026 16:02:59 +0300
Message-ID: <20260504130306.2764862-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504130306.2764862-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260504130306.2764862-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0017.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:a::6)
 To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV2PR08MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: 27330b4b-5d78-4d33-58b0-08dea9dd83af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|52116014|7416014|22082099003|56012099003|18002099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info: M+Saqf72MFKZNc9a4xAxPDpJXNkDl2IJYC8kepJAhv0S/jakE7ZM2WBAUmGfvSegweebRXMFq+GcS1BYB+amM1b0P2/xQhD8wCbXQbdM1vANStX3ZREMIZ+MRj9r9sUKEYV4FCVIFWZfRmvlXY59Cup0qAROCoC+gAYtBTgZY9RGD0f/8+fNuwtUGVFz8ROfEl/NhXbxxGDDw8iH6FY1VMDFjz6Zzx19+2tvnNOll/QjHqEDAHXDteGjCBpOJhhU7+/nfwcX/XghEwbYU6mT9SkVOSD+FYNRkxoO3FptODd7t1juWg3JRNZyKe3kGT2oyBOYes5JcHUGrONVAUsOYewWDxAatS7qiK+tyNmpGXgGupCpatUsYsx9xGfEUSxG1ZisttQXv5JNldDwWZip0irwBK/6PJoFfw/fQbcZWbzNYKHlfaGmDctzzzEM7GTSjV5EGboKHsx8FaGhgnJd0iZThNQPIzsnwXWeTJBmQf6GjYCMGU2HyKg4ddBJYrRaWNgGE/0JF01Xy5Speni9HLn5yHFv08w5t/ndSVlih/GRxsqdYHMQOE25ZhthlY4ULt/dz9ojifTT1eIptBAAn5TY3HlCArAqCaoMgnxfQozXYLP1SS5eUpH3Ga2Aw0mDrSgLwZnivlkbHAlqxy8K6cb7giWd1yYgdJngoiiy/j9FsjG0Ed7mI37zHZKyvCoaoMc0umtsrWBMYkO06vSv/zPi47TWxuoR0FvTJ+LJ+INCClLR2bRkFLnrJ9zcZBhD39fisyAv3dH17t2FXv4j0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(52116014)(7416014)(22082099003)(56012099003)(18002099003)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yG9eHfV1eE3A1PbIn4pwUdL5oz5ZtSIkxUQGGNSp57ajbkE/1AxUjlLpe0mk?=
 =?us-ascii?Q?tW03jRqVe9uQ6Rq+/quH1/wibakO9S9oNTk/u3pSnFnx1NrUVVMiHrP8HCAw?=
 =?us-ascii?Q?AH3mXrmU24tv/NDxbPtD0ylzDo3edwUsPeew+4jYPkB2YhWp/iOzVsYPy+G7?=
 =?us-ascii?Q?J+Gwp/35uJ676f4h22Fg76Wh7kfMCsuFUaMF7oQA1+jWg/OIu2YFscTHwZ1P?=
 =?us-ascii?Q?pZ7K5tpfyHZwiclnS/37FFbEmWM7VYq0PT1XsFnXdPIdc84tPtjFF0MXBjOu?=
 =?us-ascii?Q?urSKHRGlKlG3R8/Veua+4ypv6azvehKPcCJ28Jv1uBjVqrn6PqUE3vL61Dsp?=
 =?us-ascii?Q?sDAk8/q/MfF7wFI2+PTLqd9xjzmXX5yeiqoXnUmNHjCI7au9AXMymqe3yfRU?=
 =?us-ascii?Q?tFrGpCEPAYRbemf2W3+v3xhBlQ/EfqfxLp/Y5AZFdIcukR23bYZ56oLpd+Vx?=
 =?us-ascii?Q?ZS8IQbmeVe0Cn3k3bc7eGxQc/FW1TonFmK3H5PJFZU++DdTnvNKOcxATWQhK?=
 =?us-ascii?Q?wC6g/jG5JR0t9CuLm1lVLFZJvTwxH+Jd2JTbJtDNHAtlfTv9546SNp6BO/0a?=
 =?us-ascii?Q?vJrPS5/RQ4v+0KaeRlXxvQTn2Lh43ijDledZYTHGSLc+ZOwo5693fTs/EtPe?=
 =?us-ascii?Q?p27iCsTnMdTFwhZWLmZH86DbkIgrfZhk1xqKMi5HalSn7ELC7drv8Xb4NBwI?=
 =?us-ascii?Q?ON3dCkZZwW0y/g1V++aqdreK95+wVyO2/l4/BoPt8X4kfsNASBA8A3Ejh8iw?=
 =?us-ascii?Q?/GXaa6OrXncGROw1BBNQR7rNytXZxE7wY+Li++vObUQHo3KyNn732+PG6+6h?=
 =?us-ascii?Q?i/GQEc+hboCy6qgVzDV1eI2CDMsCeo+nKSEZ3DFJZ636IyOcAfINrhahpoe8?=
 =?us-ascii?Q?qg32yedgDP66oIC6pTdEVBIdMUWJN5v3VTKM4HfDzAZmGMMhOpD8XR1fjzvc?=
 =?us-ascii?Q?HSZuYM4fFTTwxM2bPET3cmfDetK162/UI451q0wRSfe0nIrB9ywwlLiV6Khj?=
 =?us-ascii?Q?W68MSAVJPSRPVTz+k5tsVX5VVhp/I52NSj0YzEkWJfKXfZUTGEwAAOAjbVgW?=
 =?us-ascii?Q?EF6hUwrEGYnZoB0Yg6cFi58PE8Svy5HEyeGz/WbbRLDtfBSrYhqpAZ4agrOG?=
 =?us-ascii?Q?Tu192PyYk0ju1C8quAqEqO8VkKRicN6NI1SNeb1YK1L6uHJIJ5cgg0gQP/kw?=
 =?us-ascii?Q?bkBHFtzTlgfzLmKNLstYZw96i12klPQy9GiiTzPhWJ1EcSSKxKcKst2bmF1B?=
 =?us-ascii?Q?7DZAEJfSfkStkoZWLvxqlhkkakXY5kzAREAgsl2BX4hhylDdBEh8+npIgR8T?=
 =?us-ascii?Q?AzgVbY/gg0mn3Oep0SEsHz7ZGj8k6I6ht/2Qhb6P7s4H5/ZzFbCZRad5pVjA?=
 =?us-ascii?Q?u16+aSqgrRWIYu4ehiZvw/b/G+fRfGe9BjJqZfu/kDwrwmKYydZn4ef7//lA?=
 =?us-ascii?Q?I8nX/AeZ3yGDEr7B3TUJrsYWTYwWK77QzhzZrVr/d/80WVnIbqoxB1IgOKB+?=
 =?us-ascii?Q?Hirei9a/CrG/uU4+j53yVCGkp1sVx2+3d1KNXxzBgIx8zTrsAAjKsDbTa18h?=
 =?us-ascii?Q?qMLdjveXDHpX6CviQpSCFOxRb/6X0xE9mAkBoW29yNQctsLNmQv4JFsprCH5?=
 =?us-ascii?Q?Q35oDUaZvistuYof7ihJKKYBb+7AOe8bvVEUcRmiimIx8la88IqU55SnhEjn?=
 =?us-ascii?Q?NNtyyXaQP39yA9Kq7PPOjz5CueHPlhDsb4+/JwXv4lIL9Lp9XiEzGCr7Z6kn?=
 =?us-ascii?Q?UU4mNTUMxcnDNLx5RVILquLQRcqoxrM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 27330b4b-5d78-4d33-58b0-08dea9dd83af
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 13:03:19.7185 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X0F8dx+ySoKCp8PguG9pzK4+ASl8B8WQl29mCU0Lz1uZqQ6wESRdhyh94W9lUanTzGm2QmT54EtVBP659eVswgG0BWmX2T7HRbbzA9xEI/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8098
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

