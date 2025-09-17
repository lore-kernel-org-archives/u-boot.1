Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8809CCAC59A
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 16:23:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2770B836D1;
	Wed, 17 Sep 2025 18:22:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="jve2UDfy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 467B8835A2; Wed, 17 Sep 2025 14:47:54 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DADBF835B2
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 14:47:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-62f4273a404so1792224a12.0
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 05:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1758113271; x=1758718071; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+Tr7wmdgviGaaG2iJV8juJGMZEEQCHXOI24fVa58J3A=;
 b=jve2UDfyh9OTPRjYf70Am8Zq83EkQrpO/Iq8+FLvRCOtb52S57r09pMnv+5EEi7X+4
 5rHnJmLYSOagGn9BMR7Nq7X7+nZgiu1JyaEwCg9z3RqpLLpBamnb4vaUqzNfF1zD+JGe
 S0d8B/gGIQzGWXTsJu1WQuKI1nKM/l9/Pzot2qwsxkMgnnQ040ZITiiXZkBpx+cvwijl
 CHu3RyDHrDfnaRjJQDeqyKLlGw+u3nBZjSSTX6NSIbyesChkbR6U+I+7HKz/mvNiH/l2
 17qpCHBlNYXcW2+AnetnHbqiYaw5b/cAkUawbvVRzCstJZdBpXMn8I33V+DrDSMSz1WW
 qdcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758113271; x=1758718071;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Tr7wmdgviGaaG2iJV8juJGMZEEQCHXOI24fVa58J3A=;
 b=AHiM0ZTR+48ldU20/MkeE2goN+rfguA3zD2taVAyjka8pkIaKrRAdea+7WiLSNMytQ
 nQVBbqgCTJMsHcZdWUFoHSa7htE+jGTstn5PDIBANktmZXMF0CBlS1VbHFw4rWiG/n2z
 zaursOGCA6aQU/TsmAoUy4cRvsOauI/qOsch70M+CC8hYf5SJwPxQdYVj3p3Mtyyz2j1
 h9F3yKx+pnoaKKH9H2B+Y4VxWxEX7cp1CeuTb6fEbENksFWFnBMfAJsqHfdISVy99Gqw
 Za9ER4iT6aTTS5oHWATCGsGq/bHClRct4dFLc3wS1PbrzHriwb+B5k5I5MC+7tor0LKz
 R5kg==
X-Gm-Message-State: AOJu0Yw1YNa/Sv9pj6e18Y/lfQ73AKdp74rJHvBUzvWdpUDx2dbrXHHQ
 c45E4hTp+obEkX/VcEii892KTtedS2soSBj/N3RNs98YH+D6wq3c83I401WxLnKwF3w=
X-Gm-Gg: ASbGncvZcpXGUokR/tApqoq0Lf20bMio+RfJEl4N/9Y5XChp3wuS+iGzDAk4rziS27G
 Y300XTRHAkR7DItnbZ9cHAxlE2VQR91qQ04JwH87R9vxGPGD+7zNTOc7HsKT8IXFz8GzH32mV76
 cGgnwUYjVSE7TZiyIz0fyWbyXXxMfhTMd51iMYd+Jk7VW9r4R2aR5V1BvfsoGlWkIj7ttSlIE7v
 Z2b8rXfV99Qtopb1T8oc9huAxooZQUYIyxg0UxWrv3bkp31wFz2+V2iyBau8Mvm/Akin+BrHg/S
 2CsasRpyTlIMXkCQP9RhODXVpMjWZdfZeDoiHPiS3zz3O6PhBqOKD2UyA9cW614L2FJjqbnf9Yi
 wfqpeKilGRwyqc8DjHzxOwZeqHYa5veEAzmZQpJA+/MP3LDD2GeG76eXm220pw9R4Rxju4Q==
X-Google-Smtp-Source: AGHT+IEURgcqjFCzSjNLov7RoIEzPcA+nqsR4GACaksOmxTQmY9yrhzdxh+S1wfBWqRcThcoOCoy8A==
X-Received: by 2002:a17:907:d16:b0:afe:6648:a243 with SMTP id
 a640c23a62f3a-b167deddbbemr730821066b.3.1758113271213; 
 Wed, 17 Sep 2025 05:47:51 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b08cab32303sm937441866b.72.2025.09.17.05.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Sep 2025 05:47:50 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 17 Sep 2025 14:47:36 +0200
Subject: [PATCH v2 3/9] drivers: pinctrl: Add Qualcomm SM6350 TLMM driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-sm6350-bringup-v2-3-13346fc2a2f6@fairphone.com>
References: <20250917-sm6350-bringup-v2-0-13346fc2a2f6@fairphone.com>
In-Reply-To: <20250917-sm6350-bringup-v2-0-13346fc2a2f6@fairphone.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758113268; l=5097;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=cG2PdIANBnEqOpyMSsRev+TJBwQ7AK5DVf5FgAN9fwM=;
 b=ZQbDvOgbZr/rRXbM92V04nFByiyvbDVbMMMKwU9MB1CeYjFSR9oJLmZ91qgOM28WM5LjOLk6t
 X5Q7BRE2JHxB0Xp9wnDPvoECEMty9cbco1BdYS84i8v7eq7uF8eiPe2
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 17 Sep 2025 18:22:41 +0200
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
on SM6350 SoC, with support for special pins.

Correct pin configuration is required for working debug UART and eMMC/SD
cards.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/pinctrl/qcom/Kconfig          |   7 +++
 drivers/pinctrl/qcom/Makefile         |   1 +
 drivers/pinctrl/qcom/pinctrl-sm6350.c | 104 ++++++++++++++++++++++++++++++++++
 3 files changed, 112 insertions(+)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 21f81b6609910c06b83941633481d69c7b0a491f..3f11d26f70ea699da716052ab6e566a0021abdd9 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -89,6 +89,13 @@ config PINCTRL_QCOM_SM6115
 	  Say Y here to enable support for pinctrl on the Snapdragon SM6115 SoC,
 	  as well as the associated GPIO driver.
 
+config PINCTRL_QCOM_SM6350
+	bool "Qualcomm SM6350 Pinctrl"
+	select PINCTRL_QCOM
+	help
+	  Say Y here to enable support for pinctrl on the Snapdragon SM6350 SoC,
+	  as well as the associated GPIO driver.
+
 config PINCTRL_QCOM_SM8150
 	bool "Qualcomm SM8150 Pinctrl"
 	select PINCTRL_QCOM
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
index 6cb53838e71b8075b359cf7890e5174223d54b5c..7779dc635f06d1fa718f15595200e63603b44bc3 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_PINCTRL_QCOM_SC7280) += pinctrl-sc7280.o
 obj-$(CONFIG_PINCTRL_QCOM_SDM660) += pinctrl-sdm660.o
 obj-$(CONFIG_PINCTRL_QCOM_SDM845) += pinctrl-sdm845.o
 obj-$(CONFIG_PINCTRL_QCOM_SM6115) += pinctrl-sm6115.o
+obj-$(CONFIG_PINCTRL_QCOM_SM6350) += pinctrl-sm6350.o
 obj-$(CONFIG_PINCTRL_QCOM_SM8150) += pinctrl-sm8150.o
 obj-$(CONFIG_PINCTRL_QCOM_SM8250) += pinctrl-sm8250.o
 obj-$(CONFIG_PINCTRL_QCOM_SM8550) += pinctrl-sm8550.o
diff --git a/drivers/pinctrl/qcom/pinctrl-sm6350.c b/drivers/pinctrl/qcom/pinctrl-sm6350.c
new file mode 100644
index 0000000000000000000000000000000000000000..1cbed77b55f28ce5f644173dfb3cba5398db504f
--- /dev/null
+++ b/drivers/pinctrl/qcom/pinctrl-sm6350.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Qualcomm sm6350 pinctrl
+ *
+ * (C) Copyright 2024 Linaro Ltd.
+ * (C) Copyright 2025 Luca Weiss <luca.weiss@fairphone.com>
+ *
+ */
+
+#include <dm.h>
+
+#include "pinctrl-qcom.h"
+
+#define MAX_PIN_NAME_LEN 32
+static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
+
+static const struct pinctrl_function msm_pinctrl_functions[] = {
+	{"qup13_f2", 1},
+	{"gpio", 0},
+};
+
+#define SDC_PINGROUP(pg_name, ctl, pull, drv)		\
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
+#define UFS_RESET(pg_name, offset)			\
+	{						\
+		.name = pg_name,			\
+		.ctl_reg = offset,			\
+		.io_reg = offset + 0x4,			\
+		.pull_bit = 3,				\
+		.drv_bit = 0,				\
+		.oe_bit = -1,				\
+		.in_bit = -1,				\
+		.out_bit = 0,				\
+	}
+
+static const struct msm_special_pin_data sm6350_special_pins_data[] = {
+	[0] = UFS_RESET("ufs_reset", 0xae000),
+	[1] = SDC_PINGROUP("sdc1_rclk", 0xa1000, 15, 0),
+	[2] = SDC_PINGROUP("sdc1_clk", 0xa0000, 13, 6),
+	[3] = SDC_PINGROUP("sdc1_cmd", 0xa0000, 11, 3),
+	[4] = SDC_PINGROUP("sdc1_data", 0xa0000, 9, 0),
+	[5] = SDC_PINGROUP("sdc2_clk", 0xa2000, 14, 6),
+	[6] = SDC_PINGROUP("sdc2_cmd", 0xa2000, 11, 3),
+	[7] = SDC_PINGROUP("sdc2_data", 0xa2000, 9, 0),
+};
+
+static const char *sm6350_get_function_name(struct udevice *dev,
+					    unsigned int selector)
+{
+	return msm_pinctrl_functions[selector].name;
+}
+
+static const char *sm6350_get_pin_name(struct udevice *dev,
+				       unsigned int selector)
+{
+	if (selector >= 156 && selector <= 163)
+		snprintf(pin_name, MAX_PIN_NAME_LEN,
+			 sm6350_special_pins_data[selector - 156].name);
+	else
+		snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
+
+	return pin_name;
+}
+
+static int sm6350_get_function_mux(__maybe_unused unsigned int pin,
+				   unsigned int selector)
+{
+	return msm_pinctrl_functions[selector].val;
+}
+
+static struct msm_pinctrl_data sm6350_data = {
+	.pin_data = {
+		.pin_count = 164,
+		.special_pins_start = 156,
+		.special_pins_data = sm6350_special_pins_data,
+	},
+	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
+	.get_function_name = sm6350_get_function_name,
+	.get_function_mux = sm6350_get_function_mux,
+	.get_pin_name = sm6350_get_pin_name,
+};
+
+static const struct udevice_id msm_pinctrl_ids[] = {
+	{ .compatible = "qcom,sm6350-tlmm", .data = (ulong)&sm6350_data },
+	{ /* Sentinel */ }
+};
+
+U_BOOT_DRIVER(pinctrl_sm6350) = {
+	.name		= "pinctrl_sm6350",
+	.id		= UCLASS_NOP,
+	.of_match	= msm_pinctrl_ids,
+	.ops		= &msm_pinctrl_ops,
+	.bind		= msm_pinctrl_bind,
+};

-- 
2.51.0

