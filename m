Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA102CD98D2
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 05:32:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 344D0848BA;
	Tue, 16 Jun 2026 07:31:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="sziMA4VD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A0D0848BA; Tue, 16 Jun 2026 07:31:29 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32AEB848BA
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 07:31:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IfCQKpb7v9qG9q0txvXSkliusnbdPYslGA3YFPN49E7EBRPKMuAUoalcVh6FAdqywdT3isi90lz7kQ7uUKwdZdqvF2kEODj/I1Ug1Qm1M+IfgWtdfIqLY1+3r0kghNV3NTtMRbAnICo+Qc+HKhgR54ZaowNUzI9ZVt5yDBLo9bPDq3+Mw+I8bxXBQyqaGXDvga1pGGu7JN6zp1REL0A65iwOyEllvj9dbp2dqvoLdLZF2HOzScj62hrXgFxDZL2xKrFkHGiZV6PeFjKQuU9vtZwJgV6u1NENhSZA1F+Q8kWsc5uy+dwt5J9XXYbImzvIdu6y6Rd1mNHXiEz0WGRNIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwGtMN9Os7jyoHslScncDC+cMQd/0IbRVAK0rBi5rg0=;
 b=jJnSHBhY/cVnBPFtJRRxX/rMsmzBafvtmm8Vk/8ySKujfjeci1tNhQwFJ77P6cqUdfPuZr6tfUFyPy3QhvWoC8Qbr69EVjZt347W31jXStkwUQzgKJsPS81BrcYp+Db5TEH3QxJMEMac6sfJaUVQ9b448orxPiowSPEm7VLMQZmAJDoW0dF4ku2+AokS+pmm0eZ5nkYfF32xx1Z9QxCaFh2BAAWyu3Y3P6nsszCSvtvkeQCE6bmA8UeAruO7fsSc1NAW6juxDdMjQZay60pNNdPEMNUgWgD8AJ7ANKF+rlkCtwoHLjqY4BzEM1QBjaj143mYOjefMQb3yUw++tntow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwGtMN9Os7jyoHslScncDC+cMQd/0IbRVAK0rBi5rg0=;
 b=sziMA4VD88GszXcczA5dTXF6WAQoXL3dStZzUBY47f4h7zV6BOJ4pJiPip01wtIbrXWb918Egwm+CIPof7g6YBRvvV3/Q7TNKBuQnZ4vUyeFm5s5yA5vnF6EjIAFstmvlYz9ZCDNPoGMXURuo3GuxPfMr8UqaqOPCvlgHQQrN4GbRqc1ZD0EbkqwNgJ8IjZQ+j3zWs8CyRBw47EYqWdeeVhIxJnvUZIwr8QFkxRoJvsGROr//9ZPxYOXr1kK0z62btfEScx7U+eY0RKiTxm6o6fyTSoO++CbKCoocXNh0KS8LCzdJKoINw5ZywQqHh8OpZYBqptKbH7ybImtD1j6Gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by AS8PR08MB8996.eurprd08.prod.outlook.com (2603:10a6:20b:5b1::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 05:31:25 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0113.013; Tue, 16 Jun 2026
 05:31:25 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Yao Zi <me@ziyao.cc>,
 Sean Anderson <sean.anderson@linux.dev>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Crt Mori <cmo@melexis.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Benjamin Larsson <benjamin.larsson@genexis.eu>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v12 04/12] pinctrl: add more pinconf/pinctrl definitions
Date: Tue, 16 Jun 2026 08:30:58 +0300
Message-ID: <20260616053106.2623475-5-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616053106.2623475-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260616053106.2623475-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0014.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::23) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|AS8PR08MB8996:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a4b4900-f40f-446f-cc70-08decb6881e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|23010399003|376014|18002099003|22082099003|38350700014|921020|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: pxGy76Swxjl3moxuyvMc2mpEJyaBTvHxO8EWsX9OKFdaI8LkpLHDF4dGzdHtCbElMe6LmPQfOU7mLemwwxUYva8klwFaoXDrl55sKB+9p11+9wcM/cg6yYbCEwqSRr7Mniu3VyMdArTZrxOv8P6EPs86f9jmr/E58Ie7nSTpAEN5slsp2Nr2bdV1tQyS9PUQYb0POGGv+xkBKNFToeaDNYSv6uRVE+w8I3jMsLjVv+bpR+VXjK8ZiWM3IB+d8dvd3iSsGEpJT47YsoEXMGra9G8A6BWD2bXXIgB+9edQCPbyFDzhc2tTIb4OsjIiUm9RIEKrDHi47p1GIqbIzmaUgfD3YbNKODLu3S3B+NZKDi4cvNJ9vI+/1hIbpjWIzTu3cLohj0HU+azT5PaVVenPLB7srJGaXwiGLnw06gnMHiPbpT9ZvAEs8qPCycSOqA7fMJG3zG9DLjoGwRRHFbjH7T3ZzWIersCvLN0w5xqP2qswpBFEctPGqakQYbaCCOD/oPHLLak45Fl8k8SKojcG9r/NuCjBWc1IKmzbLwI2xttBRTVbJ/FSlHjYeQxUl0QuhPb/9jf0OFDaTfF4g6J64Yngo/zwavl5j8rA7GZ1OXIDKKG1vQP2dMjguZHt+oj5pf2FZeFvR4RRG7LcYKhv+fR6xK2aWdaLr6Zy5u+KvuQexMRf3dWmKUfLEoKgIA+Xku/pvvWkfo+hz6uI+g+vxqMrqPK0qAgsJoGemhS8pMKWPRdaLhg532RCF4PNfgW+4P4ReMb/vlBWwnMkW0j8YA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(23010399003)(376014)(18002099003)(22082099003)(38350700014)(921020)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sfrlIh48A7VwGvvaJa+X3wjk8iVnAnv8Y/9QcMgMyekJsHpFgQS61XQhul74?=
 =?us-ascii?Q?SSP6PT0v4QfsOFvllyRc8Fm1IuLipaP6rFyLomz+Wg3iymLMfMyaoIb1E+xz?=
 =?us-ascii?Q?gaGIJG+DWPedLen8443yeUUXCjOIWzKz6BA2Pkz1PjuDZzkEBLagoiwUzweE?=
 =?us-ascii?Q?bnwkh9pQxgnlYfw3nVyRr2oPsozKrS9Icz9Rhy3/nZWNhFmP2JLT1c8VwA8o?=
 =?us-ascii?Q?2gtIB0s+cNnCLEqHT6fx8Ro9EvBmYkuvrTyr17iZ4uToCkP6KejaGX3zcZ9J?=
 =?us-ascii?Q?UnQUNzlpZF3cU9OAFyjW/JvVdKYoSy+RKF/cmyfD1puz3RxXrc76m883G6KQ?=
 =?us-ascii?Q?YsGAP4V7v2gUjlEfHnsDFn98yvwq/U2Mdb5ItSc600b+H+ANsJy/sJE+J6cz?=
 =?us-ascii?Q?MTZgfv9wAU0uxCX1q9KDBcfgFU2Th/Kny1nnigYEwcLdD5ieuxtSwlKlu9NB?=
 =?us-ascii?Q?ZjFQmidU03+S8qd6RBpN0xEF9824bOoc0IxzJLwBFslxnkqcKaRGkhDdixFG?=
 =?us-ascii?Q?t7KPiPcc/PDiMy2hAf1KrxLz33SVT9Kiu+TmICY9v7xh+k3BQqZQRgZBMvuI?=
 =?us-ascii?Q?gI1jYs6RzY0OtN+QHx7BFYCCrwMfQYTkMG88FAutqMFOrWWeiUsi3ui7ZvoP?=
 =?us-ascii?Q?DQ7VlLDhYDv1ACnsH1D8U9/tfMkKFQW0XQj5UBvLr3TLQ+saNSgpmCJsKPNY?=
 =?us-ascii?Q?eXaVHwEnaLZpvDZ0VxANw++i9khW+q/CGpfiHO2aHxeDjRwGmf4sTyXY1LI/?=
 =?us-ascii?Q?wzg3bjtLl6hPDaKQIZseB+DWb18LaTUPwNZJMbT75VdUSMzED90oX1AtcvxX?=
 =?us-ascii?Q?J9YseyaEJk9FWIoaOaLxxZ/UVkannth67S7AZ3eXKa9yq8SSfMvBXWoqAMsm?=
 =?us-ascii?Q?cxa/gPuKXz1ljmI+7dUNDONfSts41w2OmJHIhuiVoLbPDhJMAgV7baVP8f16?=
 =?us-ascii?Q?AQbjhGgv6jJrayvwhoMDNNiJnuwBd+KCtmuPnolly/utBG2RgRaT66TD3ymc?=
 =?us-ascii?Q?nm/GCZeR1ytNLPOKfE+SlRm1UV5pK8tb/z6QMP/uke8MeQg5CXAY/3m+6o6W?=
 =?us-ascii?Q?mqRSEYovyHMLczll0UW2pV0gpPSOqbpFX76Q4qXBYPjMUEV6D3lQKEnaQRF7?=
 =?us-ascii?Q?c5dBmCCnWRXHg+oP8Hc9K7ccDG88+ZI2ekQIhBc1KrdmVHP80hotgv8DfEkv?=
 =?us-ascii?Q?B4DwlAfGpL96IaUKOv78N/u6Ay9bCdv4I7uJaAM9j2X8RSHKOZpXFZv1/EYX?=
 =?us-ascii?Q?RypT2DZeKFeP6wHJBiWC6In44k4xSy45hP1nLhWjSWVGoB92suxyTy6E0RTZ?=
 =?us-ascii?Q?Ipji71HiDBPZG/8+Woj/R6ucl8GJbprudys2wuXjSd7srGbFV5al3aRJCKkH?=
 =?us-ascii?Q?BB4pWn6ACQSZXYx/EumyRMoP3qork/k1Sqtjhlf//A2/nmyOt/p01+mNR9xt?=
 =?us-ascii?Q?tuuOTxj/s3hMQb5lLyNe9AuRySu4YBBUYeqp3SdND0Zdt+PsX5Rqb2G3S3qi?=
 =?us-ascii?Q?M5A7OwKoJSx4QEYcbaEHdfHcUw/92pp7jjDR3js+ZajKMRpe7jy9B0JtwNKY?=
 =?us-ascii?Q?YKwHn1d/z8E/ehJu4HqNAMiJXQw5x1MT+lYZVvm2reSJ7BHJjU0bTcTf3DMt?=
 =?us-ascii?Q?Cq33r7CcTYDtHdKKxpXQLZXrqy+cC2Eb/OsnGZfPPJCs1xB1Un0DmuLTDz+M?=
 =?us-ascii?Q?3tQsIN64Auj264sQYQU6hfOl1pbrd3ga+lGvVuEICMqrHejzq5O78BsfyLCX?=
 =?us-ascii?Q?+G42nLfnrNmbMv8E02zQbyscU64Aj3Y=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4b4900-f40f-446f-cc70-08decb6881e1
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 05:31:25.0763 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FHfvm4FczYRai3hE9N+475qFHKkehrSTReLMRva0B+OH2DQKZnY+ttfcTk/p+QD6rGnN354ZBLoOxEHa3hr81Q2z9acNszwfsvwOBd//IT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8996
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

