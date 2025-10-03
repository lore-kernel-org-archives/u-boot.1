Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9853ACCA471
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 12:49:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B12E8383E;
	Fri,  3 Oct 2025 14:48:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mainlining.org header.i=@mainlining.org header.b="FafUWGHt";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="KPyJc+os";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DC2F836B4; Fri,  3 Oct 2025 12:09:29 +0200 (CEST)
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47BAB8366F
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 12:09:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=david.wronek@mainlining.org
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=To:Message-Id:Subject:Date:From; t=1759485671; bh=DN8/fMM+8mMltSL8HhCttHq
 Y+1h0olVVDAvD+GiDSJ4=; b=FafUWGHte/SxMAyJlQnf1kK8bvyD+/yx+fgIFtJRMjKviizaug
 M7DmyngnMFmLpe1uA2RPHQQo9UvMw+R1WdDTF8kW+HoKgJVmj2l/CjzP9N8k5clFhMWVvPm2QMc
 TUBLVz6IE9eoy9w/JsxuSyQb2/R2GwJZJ6f7vm9PE51zLsLNXAsYB+R5oaKN70rVfOVQvG/cgR+
 LelE25UuqiXjuXN2czotKbbRParHJhDxcs12Vdw4B3/TRQiUs+XR5ATIcZrdaSaYoLG9iqq8KXd
 VwnEvH6+9ufgPz0GgS8ATjjTCOV+OOy1ubFBt2IdiTcffoT3fOEGkVwOMgjHmmEXrgQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=To:Message-Id:Subject:Date:From; t=1759485671; bh=DN8/fMM+8mMltSL8HhCttHq
 Y+1h0olVVDAvD+GiDSJ4=; b=KPyJc+osZ7hn3qZ8H+CjVF4Pau4RWW+PO8ED2lF+wfAgoDkyxH
 0hZsCl/3Qmfb+8C2ruukhaC2gedA5uLOc0DA==;
From: David Wronek <david.wronek@mainlining.org>
Date: Fri, 03 Oct 2025 12:01:11 +0200
Subject: [PATCH v2 3/5] pinctrl: qcom: add sdm670 pinctrl driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-sdm670-v2-3-52c0fa481286@mainlining.org>
References: <20251003-sdm670-v2-0-52c0fa481286@mainlining.org>
In-Reply-To: <20251003-sdm670-v2-0-52c0fa481286@mainlining.org>
To: Alexey Minnekhanov <alexeymin@postmarketos.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Christopher Obbard <christopher.obbard@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Julius Lehmann <lehmanju@devpi.de>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Rui Miguel Silva <rui.silva@linaro.org>, Sam Day <me@samcday.com>, 
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Tom Rini <trini@konsulko.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: linux@mainlining.org, ~postmarketos/upstreaming@lists.sr.ht, 
 u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 David Wronek <david.wronek@mainlining.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759485669; l=7383;
 i=david.wronek@mainlining.org; s=20250914; h=from:subject:message-id;
 bh=Qj6bZQ6Hxd8H34LVARUWoBC6bYgGf/sikMBbV5IbKRI=;
 b=8jvFDgNKOShKlaD9cs5JuFd9fU9hTZsz6PK/p/Nf9j7mUHt3UjCne9mZqfhvlTTfflwwzSCaT
 jxMmI/4+zaECQknQWt9gTJOb2GtLlmdW70GogiUWDtj3MT1KoLPNCVN
X-Developer-Key: i=david.wronek@mainlining.org; a=ed25519;
 pk=NtKhS1PfXjRIaJwWcYTu7JS0cX3GEmccZo+a6erVTfU=
X-Mailman-Approved-At: Fri, 03 Oct 2025 14:48:13 +0200
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

Add a pinctrl driver for the TLMM block found in the SDM670 SoC.

Signed-off-by: David Wronek <david.wronek@mainlining.org>
---
 drivers/pinctrl/qcom/Kconfig          |   7 +
 drivers/pinctrl/qcom/Makefile         |   1 +
 drivers/pinctrl/qcom/pinctrl-sdm670.c | 247 ++++++++++++++++++++++++++++++++++
 3 files changed, 255 insertions(+)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 21f81b66099..45f900e9383 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -68,6 +68,13 @@ config PINCTRL_QCOM_SC7280
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon SC7280 SoC,
 
+config PINCTRL_QCOM_SDM670
+	bool "Qualcomm SDM670 Pinctrl"
+	select PINCTRL_QCOM
+	help
+	  Say Y here to enable support for pinctrl on the Snapdragon SDM670 SoC,
+	  as well as the associated GPIO driver.
+
 config PINCTRL_QCOM_SDM660
 	bool "Qualcomm SDM630/660 Pinctrl"
 	select PINCTRL_QCOM
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
index 6cb53838e71..f43868363d6 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_PINCTRL_QCOM_QCS404) += pinctrl-qcs404.o
 obj-$(CONFIG_PINCTRL_QCOM_SA8775P) += pinctrl-sa8775p.o
 obj-$(CONFIG_PINCTRL_QCOM_SC7280) += pinctrl-sc7280.o
 obj-$(CONFIG_PINCTRL_QCOM_SDM660) += pinctrl-sdm660.o
+obj-$(CONFIG_PINCTRL_QCOM_SDM670) += pinctrl-sdm670.o
 obj-$(CONFIG_PINCTRL_QCOM_SDM845) += pinctrl-sdm845.o
 obj-$(CONFIG_PINCTRL_QCOM_SM6115) += pinctrl-sm6115.o
 obj-$(CONFIG_PINCTRL_QCOM_SM8150) += pinctrl-sm8150.o
diff --git a/drivers/pinctrl/qcom/pinctrl-sdm670.c b/drivers/pinctrl/qcom/pinctrl-sdm670.c
new file mode 100644
index 00000000000..830fe7d826f
--- /dev/null
+++ b/drivers/pinctrl/qcom/pinctrl-sdm670.c
@@ -0,0 +1,247 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Qualcomm SDM670 pinctrl
+ *
+ * (C) Copyright 2025 David Wronek <david.wronek@mainlining.org>
+ */
+
+#include <dm.h>
+#include "pinctrl-qcom.h"
+
+#define NORTH	0x00500000
+#define SOUTH	0x00900000
+#define WEST	0x00100000
+
+#define MAX_PIN_NAME_LEN 32
+static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
+
+static const struct pinctrl_function sdm670_pinctrl_functions[] = {
+	{ "gpio", 0 },
+	{ "blsp_uart2", 3 }, /* gpio 4 and 5, used for debug uart */
+};
+
+static const unsigned int sdm670_pin_offsets[] = {
+	[0] = SOUTH,
+	[1] = SOUTH,
+	[2] = SOUTH,
+	[3] = SOUTH,
+	[4] = NORTH,
+	[5] = NORTH,
+	[6] = NORTH,
+	[7] = NORTH,
+	[8] = WEST,
+	[9] = WEST,
+	[10] = NORTH,
+	[11] = NORTH,
+	[12] = SOUTH,
+	[13] = WEST,
+	[14] = WEST,
+	[15] = WEST,
+	[16] = WEST,
+	[17] = WEST,
+	[18] = WEST,
+	[19] = WEST,
+	[20] = WEST,
+	[21] = WEST,
+	[22] = WEST,
+	[23] = WEST,
+	[24] = WEST,
+	[25] = WEST,
+	[26] = WEST,
+	[27] = WEST,
+	[28] = WEST,
+	[29] = WEST,
+	[30] = WEST,
+	[31] = WEST,
+	[32] = WEST,
+	[33] = WEST,
+	[34] = WEST,
+	[35] = NORTH,
+	[36] = NORTH,
+	[37] = NORTH,
+	[38] = NORTH,
+	[39] = NORTH,
+	[40] = NORTH,
+	[41] = SOUTH,
+	[42] = SOUTH,
+	[43] = SOUTH,
+	[44] = SOUTH,
+	[45] = SOUTH,
+	[46] = SOUTH,
+	[47] = SOUTH,
+	[48] = SOUTH,
+	[49] = NORTH,
+	[50] = NORTH,
+	[51] = NORTH,
+	[52] = NORTH,
+	[53] = NORTH,
+	[54] = NORTH,
+	[55] = NORTH,
+	[56] = NORTH,
+	[57] = NORTH,
+	[65] = NORTH,
+	[66] = NORTH,
+	[67] = NORTH,
+	[68] = NORTH,
+	[75] = NORTH,
+	[76] = NORTH,
+	[77] = NORTH,
+	[78] = NORTH,
+	[79] = NORTH,
+	[80] = NORTH,
+	[81] = NORTH,
+	[82] = NORTH,
+	[83] = NORTH,
+	[84] = NORTH,
+	[85] = SOUTH,
+	[86] = SOUTH,
+	[87] = SOUTH,
+	[88] = SOUTH,
+	[89] = SOUTH,
+	[90] = SOUTH,
+	[91] = SOUTH,
+	[92] = SOUTH,
+	[93] = SOUTH,
+	[94] = SOUTH,
+	[95] = SOUTH,
+	[96] = SOUTH,
+	[97] = WEST,
+	[98] = WEST,
+	[99] = NORTH,
+	[100] = WEST,
+	[101] = WEST,
+	[102] = WEST,
+	[103] = WEST,
+	[105] = NORTH,
+	[106] = NORTH,
+	[107] = NORTH,
+	[108] = NORTH,
+	[109] = NORTH,
+	[110] = NORTH,
+	[111] = NORTH,
+	[112] = NORTH,
+	[113] = NORTH,
+	[114] = WEST,
+	[115] = WEST,
+	[116] = SOUTH,
+	[117] = NORTH,
+	[118] = NORTH,
+	[119] = NORTH,
+	[120] = NORTH,
+	[121] = NORTH,
+	[122] = NORTH,
+	[123] = NORTH,
+	[124] = NORTH,
+	[125] = NORTH,
+	[126] = NORTH,
+	[127] = WEST,
+	[128] = WEST,
+	[129] = WEST,
+	[130] = WEST,
+	[131] = WEST,
+	[132] = WEST,
+	[133] = NORTH,
+	[134] = NORTH,
+	[135] = WEST,
+	[136] = WEST,
+	[137] = WEST,
+	[138] = WEST,
+	[139] = WEST,
+	[140] = WEST,
+	[141] = WEST,
+	[142] = WEST,
+	[143] = WEST,
+	[144] = SOUTH,
+	[145] = SOUTH,
+	[146] = WEST,
+	[147] = WEST,
+	[148] = WEST,
+	[149] = WEST,
+};
+
+#define SDC_QDSD_PINGROUP(pg_name, ctl, pull, drv)	\
+{							\
+	.name = pg_name,				\
+	.ctl_reg = ctl,					\
+	.io_reg = 0,					\
+	.pull_bit = pull,				\
+	.drv_bit = drv,					\
+	.oe_bit = -1,					\
+	.in_bit = -1,					\
+	.out_bit = -1,					\
+}
+
+#define UFS_RESET(pg_name, offset)			\
+{							\
+	.name = pg_name,				\
+	.ctl_reg = offset,				\
+	.io_reg = offset + 0x4,				\
+	.pull_bit = 3,					\
+	.drv_bit = 0,					\
+	.oe_bit = -1,					\
+	.in_bit = -1,					\
+	.out_bit = 0,					\
+}
+
+static const struct msm_special_pin_data sdm670_special_pins_data[] = {
+	UFS_RESET("ufs_reset", 0x99d000),
+	SDC_QDSD_PINGROUP("sdc1_rclk", NORTH + 0x99000, 15, 0),
+	SDC_QDSD_PINGROUP("sdc1_clk",  NORTH + 0x99000, 13, 6),
+	SDC_QDSD_PINGROUP("sdc1_cmd",  NORTH + 0x99000, 11, 3),
+	SDC_QDSD_PINGROUP("sdc1_data", NORTH + 0x99000, 9,  0),
+	SDC_QDSD_PINGROUP("sdc2_clk",  NORTH + 0x9a000, 14, 6),
+	SDC_QDSD_PINGROUP("sdc2_cmd",  NORTH + 0x9a000, 11, 3),
+	SDC_QDSD_PINGROUP("sdc2_data", NORTH + 0x9a000, 9,  0),
+};
+
+static const char *sdm670_get_function_name(struct udevice *dev, unsigned int selector)
+{
+	return sdm670_pinctrl_functions[selector].name;
+}
+
+static const char *sdm670_get_pin_name(struct udevice *dev, unsigned int selector)
+{
+	if (selector >= 150 && selector <= 157)
+		snprintf(pin_name, MAX_PIN_NAME_LEN,
+			 sdm670_special_pins_data[selector - 150].name);
+	else
+		snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
+
+	return pin_name;
+}
+
+static int sdm670_get_function_mux(__maybe_unused unsigned int pin, unsigned int selector)
+{
+	if (selector >= 0 && selector < ARRAY_SIZE(sdm670_pinctrl_functions))
+		return sdm670_pinctrl_functions[selector].val;
+	return -EINVAL;
+}
+
+struct msm_pinctrl_data sdm670_data = {
+	.pin_data = {
+		.pin_offsets = sdm670_pin_offsets,
+		.pin_count = ARRAY_SIZE(sdm670_pin_offsets) + ARRAY_SIZE(sdm670_special_pins_data),
+		.special_pins_start = 150,
+		.special_pins_data = sdm670_special_pins_data,
+	},
+	.functions_count = ARRAY_SIZE(sdm670_pinctrl_functions),
+	.get_function_name = sdm670_get_function_name,
+	.get_function_mux = sdm670_get_function_mux,
+	.get_pin_name = sdm670_get_pin_name,
+};
+
+static const struct udevice_id msm_pinctrl_ids[] = {
+	{
+		.compatible = "qcom,sdm670-tlmm",
+		.data = (ulong)&sdm670_data
+	},
+	{ /* Sentinel */ }
+};
+
+U_BOOT_DRIVER(pinctrl_ssdm670) = {
+	.name = "pinctrl_sdm670",
+	.id = UCLASS_NOP,
+	.of_match = msm_pinctrl_ids,
+	.ops = &msm_pinctrl_ops,
+	.bind = msm_pinctrl_bind,
+};

-- 
2.51.0

