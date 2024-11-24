Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB52E6780A
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 20:29:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BB0B8975F;
	Sun, 24 Nov 2024 21:27:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FR5GJZsY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C24C899F0; Sun, 24 Nov 2024 21:27:51 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4C928984B
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 21:27:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-aa53a971480so160779566b.1
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 12:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732480068; x=1733084868; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=thN/khZQ9me8m+hpsVTJZeTK/Rz76hksTe+ynG5ko24=;
 b=FR5GJZsYEMnylmZ8M47rUAbqOJwHPdU1ifECUzctOqqtFE+UEwoaW2A0/1axadj+pz
 wS85Vyfc17dLF9PXJ5aKVU2voEWCLv7kuJMnUaS3/DXSk7/cbAL5hwvu4fyIBwnvadN6
 6L73pi3NPokHNhbIx+fYd86l1crTuLJZ6x1+g1xUXXTaUbVqF08D/HjY2LDtNxgfnhIA
 2LFUs79hdFpkz8xdBpYH/MCBGjvNvsQAAuFs17nf2xsqCdH/zdbxuDjCI82R3OezhKG6
 voaNb6r0Xhbg99zk1Nyo3C6me+W7XnHExpHZYDijeC3Pi1QfSPEUwQhG1DB6ZG8TOQwP
 8u7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732480068; x=1733084868;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=thN/khZQ9me8m+hpsVTJZeTK/Rz76hksTe+ynG5ko24=;
 b=c+UzBqL+1JuvSZpe+zM/EvpncgRKZk1IGelwd2CxXX+iZn8x0tikN7hkaezbcojHL2
 +rALCeqIXyrR63I3l34IZ5N+qPHRXcMoV0v5SGUU7UPgpQlJGxyBZf7xvfwvS9qSobG9
 2vSyEq9MGAIgbU78lsYeJIjEmMz90W50lugVQ/A8zRogo9HYhz7SNvVDaVN4YfbU76T8
 Xa3aOg+U2BEAhMkOjzAPpW54i67P6EDGYGPBHQMK3xp6rM+chzF2Yu4YcgQAY5iyfAs2
 zNaY6+1WU1ZjcrcPSpcJhAw4d2/PMvF2nA7jj8F3NUs87hkgHvaNiIqzMNM5UnCJtthT
 zpwg==
X-Gm-Message-State: AOJu0Yw69IYiSjUWMscC44z8TcG1UGiyoMR83HePoHuArPybVRO+qHeN
 ifPDVaFGkTMayq6gRM2HRQVbMMlBfsVJ+IAfVbaZCbpbi7B3RnP3J4LWSi+PjRA=
X-Gm-Gg: ASbGncuK2TEWZa9VNzGZ/RYh1wWrctWUNjuBAhhJHg6TLndAfiwzMJqABMx/ifBTR8b
 WquVu7PNmxUeUY3ZQRsLyD/Sqbe4YX2wNtLc61ixIFZfAUlSpxwB0CaMZl9IMKiP+k3nFMh0p1p
 1ceYjEsq6FZQu5D3fihPpbw2anfJP2CNa6BRNRGTLXmAva+woXhg4O5sD5+d8q//nYNwAaUIs8w
 LpHmNYJo8tXIcs54ekdgJCjaZ1FcdoguJbYsTE7pIdDzg0rte5p7g5WdxlOharb0HOj
X-Google-Smtp-Source: AGHT+IHe+KUrB3MSjqD6RLm64N0WHx+vG/m/ux6t+eEDH8Vjm/LparIdjdTbPskpxK5NfJGohwilEQ==
X-Received: by 2002:a17:906:2182:b0:aa5:391e:cad5 with SMTP id
 a640c23a62f3a-aa5391eccd8mr454386266b.33.1732480067556; 
 Sun, 24 Nov 2024 12:27:47 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa50b28cda1sm378720666b.9.2024.11.24.12.27.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 12:27:47 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Sun, 24 Nov 2024 21:27:08 +0100
Subject: [PATCH RFC 12/14] pinctrl: qcom: Add X1E80100 pinctrl driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241124-b4-efistub-arm64-v1-12-3e33f0340071@linaro.org>
References: <20241124-b4-efistub-arm64-v1-0-3e33f0340071@linaro.org>
In-Reply-To: <20241124-b4-efistub-arm64-v1-0-3e33f0340071@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Anatolij Gustschin <agust@denx.de>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4374;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=65+jiBy/TyEPJUhmejdTXgoUM88VGiBPdFOD2CWResA=;
 b=kA0DAAgReTBFn7kwMhcByyZiAGdDjDKigTLC6rFPS9y1aa0DHpqm9H0KkVyBGw/8nzeGsC5FC
 Ih1BAARCAAdFiEEF8imOYKt0z8ot6DQeTBFn7kwMhcFAmdDjDIACgkQeTBFn7kwMhdpdAEAhGQw
 wXCh5uPW6EO2Y8tL5ui43f2MRpKF7kGjCZMgpR8A/0TSGx5L3Q50OgPKQ+09SYnGyfkG8u5WvBg
 kobE2GXOb
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

From: Neil Armstrong <neil.armstrong@linaro.org>

Add pinctrl driver for the TLMM block found in the X1E80100 SoC.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/pinctrl/qcom/Kconfig            |   7 +++
 drivers/pinctrl/qcom/Makefile           |   1 +
 drivers/pinctrl/qcom/pinctrl-x1e80100.c | 100 ++++++++++++++++++++++++++++++++
 3 files changed, 108 insertions(+)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 4f93a34281d5..d3eb69985510 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -82,7 +82,14 @@ config PINCTRL_QCOM_SM8650
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon SM8650 SoC,
 	  as well as the associated GPIO driver.
 
+config PINCTRL_QCOM_X1E80100
+	bool "Qualcomm X1E80100 GCC"
+	select PINCTRL_QCOM
+	help
+	  Say Y here to enable support for pinctrl on the Snapdragon X1E80100 SoC,
+	  as well as the associated GPIO driver.
+
 endmenu
 
 endif
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
index 43d0dd292225..06d3c95f93a6 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -13,4 +13,5 @@ obj-$(CONFIG_PINCTRL_QCOM_SM6115) += pinctrl-sm6115.o
 obj-$(CONFIG_PINCTRL_QCOM_SM8150) += pinctrl-sm8150.o
 obj-$(CONFIG_PINCTRL_QCOM_SM8250) += pinctrl-sm8250.o
 obj-$(CONFIG_PINCTRL_QCOM_SM8550) += pinctrl-sm8550.o
 obj-$(CONFIG_PINCTRL_QCOM_SM8650) += pinctrl-sm8650.o
+obj-$(CONFIG_PINCTRL_QCOM_X1E80100) += pinctrl-x1e80100.o
diff --git a/drivers/pinctrl/qcom/pinctrl-x1e80100.c b/drivers/pinctrl/qcom/pinctrl-x1e80100.c
new file mode 100644
index 000000000000..2e2f5093272c
--- /dev/null
+++ b/drivers/pinctrl/qcom/pinctrl-x1e80100.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Qualcomm x1e80100 pinctrl
+ *
+ * (C) Copyright 2024 Linaro Ltd.
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
+	{"qup2_se5", 1},
+	{"gpio", 0},
+};
+
+#define SDC_QDSD_PINGROUP(pg_name, ctl, pull, drv)	\
+	{					        \
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
+#define UFS_RESET(pg_name, ctl)				\
+	{					        \
+		.name = pg_name,			\
+		.ctl_reg = ctl,				\
+		.io_reg = ctl + 0x4,			\
+		.pull_bit = 3,				\
+		.drv_bit = 0,				\
+		.oe_bit = -1,				\
+		.in_bit = -1,				\
+		.out_bit = 0,				\
+	}
+
+static const struct msm_special_pin_data msm_special_pins_data[] = {
+	[0] = UFS_RESET("ufs_reset", 0xf9000),
+	[1] = SDC_QDSD_PINGROUP("sdc2_clk", 0xf2000, 14, 6),
+	[2] = SDC_QDSD_PINGROUP("sdc2_cmd", 0xf2000, 11, 3),
+	[3] = SDC_QDSD_PINGROUP("sdc2_data", 0xf2000, 9, 0),
+};
+
+static const char *x1e80100_get_function_name(struct udevice *dev,
+					      unsigned int selector)
+{
+	return msm_pinctrl_functions[selector].name;
+}
+
+static const char *x1e80100_get_pin_name(struct udevice *dev,
+					 unsigned int selector)
+{
+	if (selector >= 238 && selector <= 241)
+		snprintf(pin_name, MAX_PIN_NAME_LEN,
+			 msm_special_pins_data[selector - 238].name);
+	else
+		snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
+
+	return pin_name;
+}
+
+static unsigned int x1e80100_get_function_mux(__maybe_unused unsigned int pin,
+					      unsigned int selector)
+{
+	return msm_pinctrl_functions[selector].val;
+}
+
+static struct msm_pinctrl_data x1e80100_data = {
+	.pin_data = {
+		.pin_count = 242,
+		.special_pins_start = 238,
+		.special_pins_data = msm_special_pins_data,
+	},
+	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
+	.get_function_name = x1e80100_get_function_name,
+	.get_function_mux = x1e80100_get_function_mux,
+	.get_pin_name = x1e80100_get_pin_name,
+};
+
+static const struct udevice_id msm_pinctrl_ids[] = {
+	{ .compatible = "qcom,x1e80100-tlmm", .data = (ulong)&x1e80100_data },
+	{ /* Sentinel */ }
+};
+
+U_BOOT_DRIVER(pinctrl_x1e80100) = {
+	.name		= "pinctrl_x1e80100",
+	.id		= UCLASS_NOP,
+	.of_match	= msm_pinctrl_ids,
+	.ops		= &msm_pinctrl_ops,
+	.bind		= msm_pinctrl_bind,
+};
+

-- 
2.47.0

