Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33609EE0208
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 17:13:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04CA7892DF;
	Wed, 11 Sep 2024 19:13:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=devpi.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=devpi.de header.i=@devpi.de header.b="iSn2EEN2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF3A3892E0; Wed, 11 Sep 2024 19:13:24 +0200 (CEST)
Received: from smtp052.goneo.de (smtp052.goneo.de [85.220.129.60])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC717892DD
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 19:13:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=devpi.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lehmanju@devpi.de
Received: from hub1.goneo.de (hub1.goneo.de [85.220.129.52])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by smtp5.goneo.de (Postfix) with ESMTPS id 9BCFC240E92;
 Wed, 11 Sep 2024 19:13:20 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by hub1.goneo.de (Postfix) with ESMTPS id EE0CE240565;
 Wed, 11 Sep 2024 19:13:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devpi.de; s=DKIM001;
 t=1726074799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RdcvqbcZ4efAXUSDyZ7re6iiXjuUklb7nww5Z0Z0A/A=;
 b=iSn2EEN2Ad4XlOHtV4u3NwN5rafOSWvEvIREFjLtibdtWz5kbRKo6gY+J6mm9MNrQUK7JE
 eeDnZgCwXWxCcgfFN1u1eLZPAvIFiXTSNzNt1bVT1jBoLkHbmlgZjriNNIJyGNovVpl5zC
 WNic0v5k3raSQXZerqvZklWGXI1pnU3r9tUvc0dLJ7weBNAw5xlDu87fBTAvoAqbbrnv5S
 jYYXWn8ZzN572f7t4dvbF4rvpANIeYCxOoXdstXLjweJvnixz0RhrWCnnV7RxLxRxA23oj
 x1jBh4Y13VPKB4n0A/wAbmLQelkMVOLXbBN3OjlpRDVMwBeaiDFsJ1F8IZwODQ==
Received: from p200300cbef0698100000000000000193.dip0.t-ipconnect.de
 (p200300cbef0698100000000000000193.dip0.t-ipconnect.de
 [IPv6:2003:cb:ef06:9810::193])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by hub1.goneo.de (Postfix) with ESMTPSA id 98023240562;
 Wed, 11 Sep 2024 19:13:18 +0200 (CEST)
From: Julius Lehmann <lehmanju@devpi.de>
Date: Wed, 11 Sep 2024 19:13:10 +0200
Subject: [PATCH v3 2/3] pinctrl: qcom: add driver for SM8150 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-sm8150-patches-v3-2-d9164b71316f@devpi.de>
References: <20240911-sm8150-patches-v3-0-d9164b71316f@devpi.de>
In-Reply-To: <20240911-sm8150-patches-v3-0-d9164b71316f@devpi.de>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Julius Lehmann <lehmanju@devpi.de>, 
 Volodymyr Babchuk <volodymyr_babchuk@epam.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8305; i=lehmanju@devpi.de;
 h=from:subject:message-id; bh=PMR6i8iSSU4+YX4PbP8S6zYcIaG0U/QMPyUNGr+PKvE=;
 b=owEBbQKS/ZANAwAKARK2S7xC0EEDAcsmYgBm4c+tmB3stq7ILlhyIE4btsVLvnSVq9HiJyPDJ
 ET+loOOyqiJAjMEAAEKAB0WIQTCqoxFzEvlxm0XalUStku8QtBBAwUCZuHPrQAKCRAStku8QtBB
 A+mqD/9YzHFU/gH/7/SoBln/eR6up6uB60G9pFlUQv8N9ryITmDCJvDAVTjk+DMervLLy3LgxFb
 zIowHeezpBM0KSw2tK9sTB6XWZ2ilpKLXSDR3Ont3foEGN8Gpf1D0eRfMS6Nv3zzmtfeUppbnRD
 o7hPdiR9h2sigl4CVsX+dWLVVeJaaBYtWswoTMHBWYTKsIMvTQv2+T95L6mCkR8X5M/a10X+L1M
 QIgVbgi+ijn6nH0zSBYIx547mbMZI1gnlCzRVq9/7HPVeFLyJXYMegYVGL86X5l49Q7iQhf6HAh
 mhYW+2rQQdZugHXtYnI61kWCNu5uutj9E9HH/HMqNBIRy7k3+fSzFyMWXAZRS0CJrnP1wb4+2d/
 vFaBDfdDwpwp1gCCKgpTRfSnbdhmQEGMZMXJW/7YLRaHsoCnH1iQDtCqi6lR7nybqj90Eldlbfw
 207pcncii2XE9LR+Pgkq1mgqElT03j0tkYlXRJIJHQpnn2+XAFK6LXtyAVxM3klSssFZxXKstVt
 ShedNhkNJwKJbf9rPhl+ptCZCT36Hpnw+968NE52SM8gT26+nqkGXWmlrKViSYcdFx1t11Hi67Q
 rZD/B3o+9ddfDyQ77kJ+Jlbn1x+DoBwtimVvg59fYjvUewkRAPlBnjy+tPHV7GCgVtoBrmOBXSH
 kPGJKhT8vUn6FEw==
X-Developer-Key: i=lehmanju@devpi.de; a=openpgp;
 fpr=C2AA8C45CC4BE5C66D176A5512B64BBC42D04103
X-Rspamd-UID: 039f34
X-Rspamd-UID: 6fae7c
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

Add pinctrl and GPIO driver for SM8150. Driver code is based on the
similar U-Boot drivers. All constants are taken from the corresponding
Linux driver. This drivers differs from the similar U-Boot drivers,
because SM8150 SoC have different function IDs for the same functions
on different pins.

Co-authored-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
Signed-off-by: Julius Lehmann <lehmanju@devpi.de>
---
 drivers/pinctrl/qcom/Kconfig          |   8 ++
 drivers/pinctrl/qcom/Makefile         |   1 +
 drivers/pinctrl/qcom/pinctrl-sm8150.c | 156 ++++++++++++++++++++++++++++++++++
 3 files changed, 165 insertions(+)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index b326fa8514..4f93a34281 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -55,6 +55,13 @@ config PINCTRL_QCOM_SM6115
 	  Say Y here to enable support for pinctrl on the Snapdragon SM6115 SoC,
 	  as well as the associated GPIO driver.
 
+config PINCTRL_QCOM_SM8150
+	bool "Qualcomm SM8150 GCC"
+	select PINCTRL_QCOM
+	help
+	  Say Y here to enable support for pinctrl on the Snapdragon SM8150 SoC,
+	  as well as the associated GPIO driver.
+
 config PINCTRL_QCOM_SM8250
 	bool "Qualcomm SM8250 GCC"
 	select PINCTRL_QCOM
@@ -74,6 +81,7 @@ config PINCTRL_QCOM_SM8650
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon SM8650 SoC,
+	  as well as the associated GPIO driver.
 
 endmenu
 
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
index 4f1d96787b..43d0dd2922 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_PINCTRL_QCOM_QCM2290) += pinctrl-qcm2290.o
 obj-$(CONFIG_PINCTRL_QCOM_QCS404) += pinctrl-qcs404.o
 obj-$(CONFIG_PINCTRL_QCOM_SDM845) += pinctrl-sdm845.o
 obj-$(CONFIG_PINCTRL_QCOM_SM6115) += pinctrl-sm6115.o
+obj-$(CONFIG_PINCTRL_QCOM_SM8150) += pinctrl-sm8150.o
 obj-$(CONFIG_PINCTRL_QCOM_SM8250) += pinctrl-sm8250.o
 obj-$(CONFIG_PINCTRL_QCOM_SM8550) += pinctrl-sm8550.o
 obj-$(CONFIG_PINCTRL_QCOM_SM8650) += pinctrl-sm8650.o
diff --git a/drivers/pinctrl/qcom/pinctrl-sm8150.c b/drivers/pinctrl/qcom/pinctrl-sm8150.c
new file mode 100644
index 0000000000..1fb2ffb959
--- /dev/null
+++ b/drivers/pinctrl/qcom/pinctrl-sm8150.c
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Qualcomm SM8150 pinctrl and GPIO driver
+ *
+ * Volodymyr Babchuk <volodymyr_babchuk@epam.com>
+ * Copyright (c) 2024 EPAM Systems.
+ *
+ * (C) Copyright 2024 Julius Lehmann <lehmanju@devpi.de>
+ *
+ * Based on similar U-Boot drivers. Constants were taken from the Linux driver
+ */
+
+#include <dm.h>
+
+#include "pinctrl-qcom.h"
+
+#define WEST	0x100000
+#define EAST	0x500000
+#define NORTH	0x900000
+#define SOUTH	0xd00000
+
+#define MAX_PIN_NAME_LEN 32
+static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
+
+static const struct pinctrl_function msm_pinctrl_functions[] = {
+	{ "qup2", 1 },
+	{ "gpio", 0 },
+};
+
+static const unsigned int sm8150_pin_offsets[] = {
+	[0]   = SOUTH, [1]   = SOUTH, [2]   = SOUTH, [3]   = SOUTH,
+	[4]   = SOUTH, [5]   = SOUTH, [6]   = SOUTH, [7]   = SOUTH,
+	[8]   = NORTH, [9]   = NORTH, [10]  = NORTH, [11]  = NORTH,
+	[12]  = NORTH, [13]  = NORTH, [14]  = NORTH, [15]  = NORTH,
+	[16]  = NORTH, [17]  = NORTH, [18]  = NORTH, [19]  = NORTH,
+	[20]  = NORTH, [21]  = EAST,  [22]  = EAST,  [23]  = EAST,
+	[24]  = EAST,  [25]  = EAST,  [26]  = EAST,  [27]  = EAST,
+	[28]  = EAST,  [29]  = EAST,  [30]  = EAST,  [31]  = NORTH,
+	[32]  = NORTH, [33]  = NORTH, [34]  = NORTH, [35]  = NORTH,
+	[36]  = NORTH, [37]  = NORTH, [38]  = SOUTH, [39]  = NORTH,
+	[40]  = NORTH, [41]  = NORTH, [42]  = NORTH, [43]  = EAST,
+	[44]  = EAST,  [45]  = EAST,  [46]  = EAST,  [47]  = EAST,
+	[48]  = EAST,  [49]  = EAST,  [50]  = EAST,  [51]  = SOUTH,
+	[52]  = SOUTH, [53]  = SOUTH, [54]  = SOUTH, [55]  = SOUTH,
+	[56]  = SOUTH, [57]  = SOUTH, [58]  = SOUTH, [59]  = SOUTH,
+	[60]  = SOUTH, [61]  = SOUTH, [62]  = SOUTH, [63]  = SOUTH,
+	[64]  = SOUTH, [65]  = SOUTH, [66]  = SOUTH, [67]  = SOUTH,
+	[68]  = SOUTH, [69]  = SOUTH, [70]  = SOUTH, [71]  = SOUTH,
+	[72]  = SOUTH, [73]  = SOUTH, [74]  = SOUTH, [75]  = SOUTH,
+	[76]  = SOUTH, [77]  = SOUTH, [78]  = SOUTH, [79]  = SOUTH,
+	[80]  = SOUTH, [81]  = SOUTH, [82]  = SOUTH, [83]  = NORTH,
+	[84]  = NORTH, [85]  = NORTH, [86]  = NORTH, [87]  = EAST,
+	[88]  = NORTH, [89]  = NORTH, [90]  = NORTH, [91]  = NORTH,
+	[92]  = NORTH, [93]  = NORTH, [94]  = NORTH, [95]  = NORTH,
+	[96]  = NORTH, [97]  = NORTH, [98]  = SOUTH, [99]  = SOUTH,
+	[100] = SOUTH, [101] = SOUTH, [102] = NORTH, [103] = NORTH,
+	[104] = NORTH, [105] = WEST,  [106] = WEST,  [107] = WEST,
+	[108] = WEST,  [109] = WEST,  [110] = WEST,  [111] = WEST,
+	[112] = WEST,  [113] = WEST,  [114] = SOUTH, [115] = SOUTH,
+	[116] = SOUTH, [117] = SOUTH, [118] = SOUTH, [119] = SOUTH,
+	[120] = SOUTH, [121] = SOUTH, [122] = SOUTH, [123] = SOUTH,
+	[124] = SOUTH, [125] = WEST,  [126] = SOUTH, [127] = SOUTH,
+	[128] = SOUTH, [129] = SOUTH, [130] = SOUTH, [131] = SOUTH,
+	[132] = SOUTH, [133] = SOUTH, [134] = SOUTH, [135] = SOUTH,
+	[136] = SOUTH, [137] = SOUTH, [138] = SOUTH, [139] = SOUTH,
+	[140] = SOUTH, [141] = SOUTH, [142] = SOUTH, [143] = SOUTH,
+	[144] = SOUTH, [145] = SOUTH, [146] = SOUTH, [147] = SOUTH,
+	[148] = SOUTH, [149] = SOUTH, [150] = SOUTH, [151] = SOUTH,
+	[152] = SOUTH, [153] = SOUTH, [154] = SOUTH, [155] = WEST,
+	[156] = WEST,  [157] = WEST,  [158] = WEST,  [159] = WEST,
+	[160] = WEST,  [161] = WEST,  [162] = WEST,  [163] = WEST,
+	[164] = WEST,  [165] = WEST,  [166] = WEST,  [167] = WEST,
+	[168] = WEST,  [169] = NORTH, [170] = NORTH, [171] = NORTH,
+	[172] = NORTH, [173] = NORTH, [174] = NORTH,
+};
+
+#define SDC_QDSD_PINGROUP(pg_name, ctl, pull, drv)	\
+	{						\
+		.name = pg_name,			\
+		.ctl_reg = ctl,				\
+		.io_reg = 0,				\
+		.pull_bit = pull,			\
+		.drv_bit = drv,				\
+		.oe_bit = -1,				\
+		.in_bit = -1,				\
+		.out_bit = -1,				\
+	}
+
+#define UFS_RESET(pg_name, offset)        \
+	{                                 \
+		.name = pg_name,	  \
+		.ctl_reg = offset,	  \
+		.io_reg = offset + 0x04,  \
+		.pull_bit = 3,		  \
+		.drv_bit = 0,             \
+		.oe_bit = -1,             \
+		.in_bit = -1,             \
+		.out_bit = 0,             \
+	}
+
+static const struct msm_special_pin_data msm_special_pins_data[] = {
+	[0] = UFS_RESET("ufs_reset", SOUTH + 0xb6000),
+	[1] = SDC_QDSD_PINGROUP("sdc2_clk", NORTH + 0xb2000, 14, 6),
+	[2] = SDC_QDSD_PINGROUP("sdc2_cmd", NORTH + 0xb2000, 11, 3),
+	[3] = SDC_QDSD_PINGROUP("sdc2_data", NORTH + 0xb2000, 9, 0),
+};
+
+static const char *sm8150_get_function_name(struct udevice *dev,
+					    unsigned int selector)
+{
+	return msm_pinctrl_functions[selector].name;
+}
+
+static const char *sm8150_get_pin_name(struct udevice *dev,
+				       unsigned int selector)
+{
+	if (selector >= 175 && selector <= 178)
+		snprintf(pin_name, MAX_PIN_NAME_LEN,
+			 msm_special_pins_data[selector - 175].name);
+	else
+		snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
+
+	return pin_name;
+}
+
+static unsigned int sm8150_get_function_mux(__maybe_unused unsigned int pin,
+					    unsigned int selector)
+{
+	return msm_pinctrl_functions[selector].val;
+}
+
+static struct msm_pinctrl_data sm8150_data = {
+	.pin_data = {
+		.pin_offsets = sm8150_pin_offsets,
+		.pin_count = 179,
+		.special_pins_start = 175,
+		.special_pins_data = msm_special_pins_data,
+	},
+	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
+	.get_function_name = sm8150_get_function_name,
+	.get_function_mux = sm8150_get_function_mux,
+	.get_pin_name = sm8150_get_pin_name,
+};
+
+static const struct udevice_id msm_pinctrl_ids[] = {
+	{ .compatible = "qcom,sm8150-pinctrl", .data = (ulong)&sm8150_data },
+	{ /* Sentinel */ }
+};
+
+U_BOOT_DRIVER(pinctrl_sm8150) = {
+	.name		= "pinctrl_sm8150",
+	.id		= UCLASS_NOP,
+	.of_match	= msm_pinctrl_ids,
+	.ops		= &msm_pinctrl_ops,
+	.bind		= msm_pinctrl_bind,
+};

-- 
2.46.0

