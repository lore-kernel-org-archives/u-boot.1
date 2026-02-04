Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92540E9D408
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 16:12:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E30F783AAD;
	Wed,  4 Feb 2026 17:11:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VC8HobDT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23E8780086; Wed,  4 Feb 2026 17:11:28 +0100 (CET)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8E3A83015
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 17:11:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nathbappai@gmail.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-34f634dbfd6so5494026a91.2
 for <u-boot@lists.denx.de>; Wed, 04 Feb 2026 08:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770221484; x=1770826284; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZCrsvmAS+OLPpnJV1+z0kPBZKrCM3yjT7wlDsV0XIsY=;
 b=VC8HobDTLiScXCko43ZzfacClMuk5wAd2eGw7tlSHXyLO0/SoT+KYkkwBtvae4c3UW
 XHq/T6RvOQBLGx6F8KyQD6zomssL571zm+zZ8zWh+Z7sSPB6oPMtVPQJ6oT3NrWm581i
 1apKw3MAqcnrqi9gwGukVsed18Zm0Veq4tfKYciEtx208t3uqlPs2SJQcvUcJGyH0Fc+
 bKSmEwauApvumETMY4NiAWULn+epCeWmUokHfd+nCrJprfP0F/lKNbrjWJoqCpPzKIGs
 y49uD1RA5PiIjvawGSTanQPNO92I4c0wzZZ3+DwT438j7dQb0QAUAC3faAvNFWdqoiC6
 WKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770221484; x=1770826284;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZCrsvmAS+OLPpnJV1+z0kPBZKrCM3yjT7wlDsV0XIsY=;
 b=Qny2Edlz/T7MTzv9BO+Pu7hi3c2Lw8wZxjcVwuICpkl80tDmyxylz5HSdQLv16hpuo
 Rtc9ULnC7lOcMTQGMl+SIjZY38uiyfLq5aeom5lf6/N2/6aIiTeoW72NTzdOfFmf0MZ+
 EphszFDGn9v7ZqzbG8OAN1z22DEBReQsSJOvyjbpMJKNG4pfV5RqPvIv+k5daNiogPl6
 /Tg3rIGuJuUUmt7PGUDgK0Pif80Rdxs5Eh5FMUd3CKfPnFFARDWd8uZSFs0vpzHSSkb6
 cwV2deAlIZ13HD9Zx3kLi07sKDGBZhs+/gxBtZV0ziRun7oN9nh7HaQL5BMxRMwrpNXD
 lA4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCsQ46nI/vofi8PnXjCizG3LHRayhRDTIDTyxeH0zLpz5FIhx2hqKNILrBmFviyWhJ4iNgzGw=@lists.denx.de
X-Gm-Message-State: AOJu0Yze35N9mTCa+e7fO+w2DJ9gWaLhDY1raC49LyqEUqh1wKfSlflS
 dtEi5EQQ3kV0Pt0yBqkqBoaOuORzU61G+Dm4cCohuKyptl0USTxczq0L
X-Gm-Gg: AZuq6aI38ko4n7jEnpTXNI7pvgd9CkTu3oHG9oz+9xbpMaVTmz1Y3Gf2rjtC+kEI5WW
 tEAXxNTfNxj8KmtDhSiEBmyGmm8B6jVlZouWPUTJB4W8jHQOyPqejiYUp7ufyIOkfb/NPttbyYO
 X+9oIqrtVecSeKWsouFVxE5iBbHNYOnOlEDify8fzDh0pPW4DuUrObRUUB20b3SuuQM3S1/sBTK
 f9JD2cVCGHY6DdKC5yiICA+7QF5mKUQX0pAWcG7IV3J3vwjjiim8WbDJ7wgCej3VgrCg1lmyTp7
 qD1dhRR5BebfQuD3M/EPE0vg8u482Z3m1M9J6sLUaue0k5JP4lGhxmGqg2BKgTX5tE6yJes65ka
 zS2/CTlp5tKM/f2id72RwoP8giFL1aZh2x87KxLAe5orGMkIwWZ42croAXgHBHmnQrhnLQ/nS9h
 5qAU94n/RsBqPiRnr4
X-Received: by 2002:a17:90b:5384:b0:347:5ddd:b2d1 with SMTP id
 98e67ed59e1d1-354871bd57emr2877196a91.27.1770221483989; 
 Wed, 04 Feb 2026 08:11:23 -0800 (PST)
Received: from [192.168.0.103] ([43.226.31.128])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-35485efa3d5sm2968364a91.17.2026.02.04.08.11.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 08:11:23 -0800 (PST)
From: Biswapriyo Nath <nathbappai@gmail.com>
Date: Wed, 04 Feb 2026 16:10:54 +0000
Subject: [PATCH RFC 3/3] drivers: pinctrl: Add Qualcomm SM6125 TLMM driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-sm6125-clk-pinctrl-v1-3-9cf4c556557a@gmail.com>
References: <20260204-sm6125-clk-pinctrl-v1-0-9cf4c556557a@gmail.com>
In-Reply-To: <20260204-sm6125-clk-pinctrl-v1-0-9cf4c556557a@gmail.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Bryan Brattlof <bb@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Biswapriyo Nath <nathbappai@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770221464; l=7511;
 i=nathbappai@gmail.com; s=20260118; h=from:subject:message-id;
 bh=PRPZlb2/V2+r6uT6TVOt8PrCSjZe46ml0+Hws3/UChA=;
 b=1G2dQvUutfUUQZJVuEdLSzDO3OgYAJkBPgkJXrDHMGGd3OXE1pHlZGMMKd1ddHMHZBhY22ow/
 YqX+IwNoYDeAOIX3JKALJgMiCHdcT1xOTNShjtxzTzJgsh4ssij5MTK
X-Developer-Key: i=nathbappai@gmail.com; a=ed25519;
 pk=slmb/9yXbet+KTiT3EYLCp0p0MEOYa3EdjUXP+HXfjg=
X-Mailman-Approved-At: Wed, 04 Feb 2026 17:11:52 +0100
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

Add support for TLMM pin controller block (Top Level Mode Multiplexer)
on SM6125 SoC, with support for special pins.

Signed-off-by: Biswapriyo Nath <nathbappai@gmail.com>
---
 drivers/pinctrl/qcom/Kconfig          |   8 ++
 drivers/pinctrl/qcom/Makefile         |   1 +
 drivers/pinctrl/qcom/pinctrl-sm6125.c | 147 ++++++++++++++++++++++++++++++++++
 3 files changed, 156 insertions(+)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 580308621..d1c762891 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -125,6 +125,14 @@ config PINCTRL_QCOM_SM6115
 	  Say Y here to enable support for pinctrl on the Snapdragon SM6115 SoC,
 	  as well as the associated GPIO driver.
 
+config PINCTRL_QCOM_SM6125
+	bool "Qualcomm SM6125 Pinctrl"
+	default y if PINCTRL_QCOM_GENERIC
+	select PINCTRL_QCOM
+	help
+	  Say Y here to enable support for pinctrl on the Snapdragon SM6125 SoC,
+	  as well as the associated GPIO driver.
+
 config PINCTRL_QCOM_SM6350
 	bool "Qualcomm SM6350 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
index b5a111605..1844f37ed 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_PINCTRL_QCOM_SDM660) += pinctrl-sdm660.o
 obj-$(CONFIG_PINCTRL_QCOM_SDM670) += pinctrl-sdm670.o
 obj-$(CONFIG_PINCTRL_QCOM_SDM845) += pinctrl-sdm845.o
 obj-$(CONFIG_PINCTRL_QCOM_SM6115) += pinctrl-sm6115.o
+obj-$(CONFIG_PINCTRL_QCOM_SM6125) += pinctrl-sm6125.o
 obj-$(CONFIG_PINCTRL_QCOM_SM6350) += pinctrl-sm6350.o
 obj-$(CONFIG_PINCTRL_QCOM_SM7150) += pinctrl-sm7150.o
 obj-$(CONFIG_PINCTRL_QCOM_SM8150) += pinctrl-sm8150.o
diff --git a/drivers/pinctrl/qcom/pinctrl-sm6125.c b/drivers/pinctrl/qcom/pinctrl-sm6125.c
new file mode 100644
index 000000000..82f8972ff
--- /dev/null
+++ b/drivers/pinctrl/qcom/pinctrl-sm6125.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Pinctrl driver for Qualcomm SM6125
+ *
+ * (C) Copyright 2026 Biswapriyo Nath <nathbappai@gmail.com>
+ *
+ * Based on Linux Kernel driver
+ */
+
+#include <dm.h>
+
+#include "pinctrl-qcom.h"
+
+#define TLMM_BASE 0x00500000
+#define WEST (0x00500000 - TLMM_BASE) /* 0x0 */
+#define SOUTH (0x00900000 - TLMM_BASE) /* 0x400000 */
+#define EAST (0x00d00000 - TLMM_BASE) /* 0x800000 */
+
+#define MAX_PIN_NAME_LEN 32
+static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
+
+static const struct pinctrl_function msm_pinctrl_functions[] = {
+	{ "qup04", 1 },
+	{ "gpio", 0 },
+};
+
+#define SDC_QDSD_PINGROUP(pg_name, ctl, pull, drv) \
+	{                                          \
+		.name = pg_name,                   \
+		.ctl_reg = ctl,                    \
+		.io_reg = 0,                       \
+		.pull_bit = pull,                  \
+		.drv_bit = drv,                    \
+		.oe_bit = -1,                      \
+		.in_bit = -1,                      \
+		.out_bit = -1,                     \
+	}
+
+#define UFS_RESET(pg_name, offset)      \
+	{                               \
+		.name = pg_name,        \
+		.ctl_reg = offset,      \
+		.io_reg = offset + 0x4, \
+		.pull_bit = 3,          \
+		.drv_bit = 0,           \
+		.oe_bit = -1,           \
+		.in_bit = -1,           \
+		.out_bit = 0,           \
+	}
+
+static const struct msm_special_pin_data msm_special_pins_data[] = {
+	[0] = UFS_RESET("ufs_reset", 0x190000),
+	[1] = SDC_QDSD_PINGROUP("sdc1_rclk", WEST + 0x18d000, 15, 0),
+	[2] = SDC_QDSD_PINGROUP("sdc1_clk", WEST + 0x18d000, 13, 6),
+	[3] = SDC_QDSD_PINGROUP("sdc1_cmd", WEST + 0x18d000, 11, 3),
+	[4] = SDC_QDSD_PINGROUP("sdc1_data", WEST + 0x18d000, 9, 0),
+	[5] = SDC_QDSD_PINGROUP("sdc2_clk", SOUTH + 0x58b000, 14, 6),
+	[6] = SDC_QDSD_PINGROUP("sdc2_cmd", SOUTH + 0x58b000, 11, 3),
+	[7] = SDC_QDSD_PINGROUP("sdc2_data", SOUTH + 0x58b000, 9, 0),
+};
+
+static const unsigned int sm6125_pin_offsets[] = {
+	[0] = WEST,    [1] = WEST,    [2] = WEST,    [3] = WEST,
+	[4] = WEST,    [5] = WEST,    [6] = WEST,    [7] = WEST,
+	[8] = WEST,    [9] = WEST,    [10] = EAST,   [11] = EAST,
+	[12] = EAST,   [13] = EAST,   [14] = WEST,   [15] = WEST,
+	[16] = WEST,   [17] = WEST,   [18] = EAST,   [19] = EAST,
+	[20] = EAST,   [21] = EAST,   [22] = WEST,   [23] = WEST,
+	[24] = WEST,   [25] = WEST,   [26] = WEST,   [27] = WEST,
+	[28] = WEST,   [29] = WEST,   [30] = WEST,   [31] = WEST,
+	[32] = WEST,   [33] = WEST,   [34] = SOUTH,  [35] = SOUTH,
+	[36] = SOUTH,  [37] = SOUTH,  [38] = EAST,   [39] = EAST,
+	[40] = EAST,   [41] = EAST,   [42] = EAST,   [43] = EAST,
+	[44] = SOUTH,  [45] = SOUTH,  [46] = SOUTH,  [47] = SOUTH,
+	[48] = SOUTH,  [49] = SOUTH,  [50] = SOUTH,  [51] = SOUTH,
+	[52] = SOUTH,  [53] = SOUTH,  [54] = SOUTH,  [55] = SOUTH,
+	[56] = SOUTH,  [57] = SOUTH,  [58] = SOUTH,  [59] = SOUTH,
+	[60] = SOUTH,  [61] = SOUTH,  [62] = SOUTH,  [63] = SOUTH,
+	[64] = SOUTH,  [65] = SOUTH,  [66] = SOUTH,  [67] = SOUTH,
+	[68] = SOUTH,  [69] = SOUTH,  [70] = SOUTH,  [71] = SOUTH,
+	[72] = SOUTH,  [73] = SOUTH,  [74] = SOUTH,  [75] = SOUTH,
+	[76] = SOUTH,  [77] = SOUTH,  [78] = SOUTH,  [79] = SOUTH,
+	[80] = SOUTH,  [81] = SOUTH,  [82] = SOUTH,  [83] = SOUTH,
+	[84] = SOUTH,  [85] = SOUTH,  [86] = SOUTH,  [87] = WEST,
+	[88] = WEST,   [89] = WEST,   [90] = WEST,   [91] = WEST,
+	[92] = WEST,   [93] = WEST,   [94] = SOUTH,  [95] = SOUTH,
+	[96] = SOUTH,  [97] = SOUTH,  [98] = SOUTH,  [99] = SOUTH,
+	[100] = SOUTH, [101] = SOUTH, [102] = SOUTH, [103] = SOUTH,
+	[104] = EAST,  [105] = EAST,  [106] = EAST,  [107] = EAST,
+	[108] = EAST,  [109] = EAST,  [110] = EAST,  [111] = EAST,
+	[112] = EAST,  [113] = EAST,  [114] = EAST,  [115] = EAST,
+	[116] = EAST,  [117] = SOUTH, [118] = SOUTH, [119] = SOUTH,
+	[120] = SOUTH, [121] = EAST,  [122] = EAST,  [123] = EAST,
+	[124] = EAST,  [125] = EAST,  [126] = EAST,  [127] = EAST,
+	[128] = EAST,  [129] = SOUTH, [130] = SOUTH, [131] = SOUTH,
+	[132] = SOUTH,
+};
+
+static const char *sm6125_get_function_name(struct udevice *dev,
+					    unsigned int selector)
+{
+	return msm_pinctrl_functions[selector].name;
+}
+
+static const char *sm6125_get_pin_name(struct udevice *dev,
+				       unsigned int selector)
+{
+	if (selector >= 133 && selector <= 140)
+		snprintf(pin_name, MAX_PIN_NAME_LEN,
+			 msm_special_pins_data[selector - 133].name);
+	else
+		snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
+
+	return pin_name;
+}
+
+static int sm6125_get_function_mux(__maybe_unused unsigned int pin,
+				   unsigned int selector)
+{
+	return msm_pinctrl_functions[selector].val;
+}
+
+static struct msm_pinctrl_data sm6125_data = {
+	.pin_data = {
+		.pin_offsets = sm6125_pin_offsets,
+		.pin_count = 141,
+		.special_pins_start = 133,
+		.special_pins_data = msm_special_pins_data,
+	},
+	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
+	.get_function_name = sm6125_get_function_name,
+	.get_function_mux = sm6125_get_function_mux,
+	.get_pin_name = sm6125_get_pin_name,
+};
+
+static const struct udevice_id msm_pinctrl_ids[] = {
+	{ .compatible = "qcom,sm6125-tlmm", .data = (ulong)&sm6125_data },
+	{ /* sentinel */ }
+};
+
+U_BOOT_DRIVER(pinctrl_sm6125) = {
+	.name = "pinctrl_sm6125",
+	.id = UCLASS_NOP,
+	.of_match = msm_pinctrl_ids,
+	.ops = &msm_pinctrl_ops,
+	.bind = msm_pinctrl_bind,
+};

-- 
2.53.0

