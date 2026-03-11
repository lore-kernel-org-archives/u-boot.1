Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA676FD0651
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 14:24:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 286A68415C;
	Wed, 11 Mar 2026 15:23:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="hBhCrvFD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71D1F840BE; Wed, 11 Mar 2026 15:20:50 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6011684057
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 15:20:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-660a293515fso15589765a12.1
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 07:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1773238847; x=1773843647; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=E+HnqfMOTEnKZPzblz9UE57YWZGwQmR7OEPdlGwaick=;
 b=hBhCrvFDhGy6HHrS9ihREMmQCwsGCEn6Meo/5MnvUHRHsWPMSEKgl/X/48XVQL5+hF
 OmTMSw6JSJgQb1/czTiy66rwvwQ2irvehCayNx6be7ISIjqjH/34rP4CdIgoCSNr3p2f
 QeFUYpfSrlHzDVSm088x1MUwa76B+3pi5HLlce2QdjWl9xpku+9c/yW6nES8ADIrnKp8
 q3/8wRLXESkh4G3Gu+VonKC/+QlDb+aRWUajm0vcxsSd4Sc+TzzVFncBnkRCfxCXxHTX
 dvyK77BkI4Jjq/UEtzr/pUWkUIjzG4bdjR1se6jNgLJ9F+PeoRmEbDORFLNnjwoHcVmd
 Gnig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773238847; x=1773843647;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=E+HnqfMOTEnKZPzblz9UE57YWZGwQmR7OEPdlGwaick=;
 b=kLZ/hrBs1G9denI+MDdpJge7l2xJNrZrhMVCjtYbF5BPthhxv5vNr0abgmUZDyPstU
 M0JxB/60oDD4I8sfa61tM3he1w9R9G9uZRQXZb9tohjJw5/tvY3skU0UMRUZ/y/YuNBL
 pOgLIpIBhJR7jWonEl9jJZK+UyFoaGmjWGdPAszLhvGMz3lqUHpkSPmc7pcvQwwkIw8n
 kCPZWMcLA6pOOffUy/o3UGB9/1REnRjH7MCjX34F389G5132JKtTTNenfWU0w9P4jFKD
 FxP7ZsqkSxMbXhFlc75k0mJPsNE7K4yQygbon2xJu/SCAWx+ni2VPQ6iAZ/u1Ysuh8fZ
 kAbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9/WBhL6bphQlO+7JxWpWgitzXgTK4s7D0rEpNBGFtUQhnqn2gDDjpO+gkyJtCclOvp+Sn2Jk=@lists.denx.de
X-Gm-Message-State: AOJu0Yx7HwvM+NJwgpr4EiHfTEvyTxZBhgwbLSgp5XfIfj+ZBJSgcaUc
 yxxPg1qeoTPz/7HYHT7N7PAfUmlf6wg1+eOS9hpOUeKItGLYMOCijX7Rbdn3A5UyPSs=
X-Gm-Gg: ATEYQzyso6F+016bhPSm4qkTKYlvUt5dXR1h1HRgWze4sS7XfZaSq+5FZOYXhSSAgX7
 eXbMG0Cy3pTD+X3eBPPX72f/JBa9cbAxJnd3PYyf7IXR5z6R63dtZgogSYtYINaJ3v4yeGoY0YE
 ZuTNqCmYy+JQVp5+Z8fN0jRoPK7rOJ5LPAj1UFjc/fWHyTcWZkJs7tU0ikb5EHZ10FGzhtmzxEw
 jvNuUgWlMofFvIK/wY2yK024qXjlxIhXTEyE8eYlZ2jIWxC437U1IraO52tiozAnJDOdrx6PhkE
 dXcfIqqU9yFag+B1tm/2V/mjWzum0CDschtWHTRIYweNC4tfIBcOxN1lBdTiZ9lr1EZAAEeHZvv
 jTuGq0M+k5PaL668nGC625Y8eUcMrGGP/u2xgG7Cxyn6XMH9rWIviJPy195xS6E+wimnQbKbOJz
 2Zm/BpiVkEFWUEj5HZvC9R4yXx87nh5AcmaRuv3iDzMA7urM6X65ASXOobX3dN/JoLuVD5oqlS7
 fAxAQ==
X-Received: by 2002:a05:6402:3511:b0:65b:e788:5de0 with SMTP id
 4fb4d7f45d1cf-663194cbd79mr1500510a12.7.1773238846706; 
 Wed, 11 Mar 2026 07:20:46 -0700 (PDT)
Received: from [172.16.240.100] (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6631503c903sm543467a12.20.2026.03.11.07.20.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 07:20:46 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 11 Mar 2026 15:20:41 +0100
Subject: [PATCH 1/7] drivers: pinctrl: Add Qualcomm Milos TLMM driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-milos-bringup-v1-1-eb905c467f10@fairphone.com>
References: <20260311-milos-bringup-v1-0-eb905c467f10@fairphone.com>
In-Reply-To: <20260311-milos-bringup-v1-0-eb905c467f10@fairphone.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Danila Tikhonov <danila@jiaxyga.com>, 
 David Wronek <david.wronek@mainlining.org>, 
 Alexey Minnekhanov <alexeymin@postmarketos.org>, 
 Lukasz Majewski <lukma@denx.de>, Aelin Reidel <aelin@mainlining.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Rui Miguel Silva <rui.silva@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Sam Day <me@samcday.com>, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773238844; l=4773;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=tEvgrlKGwdeo3BfxOnGj1rTArw/syIy97kqpVEDzWvI=;
 b=O8G7bTXsI8IOvXyJPA96kMFtdFY0/+eXZuvfXMkO+KmRCNaoisSPG7wNJVHKtv3gsHcAklGTH
 M469lh+i2R0CbIIGaVNX+dYoKv7pO/S6hcr0QnJgs9Y6odrlNXYNvws
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 11 Mar 2026 15:23:27 +0100
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
on Milos SoC, with support for special pins.

Correct pin configuration is required for working debug UART and eMMC/SD
cards.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/pinctrl/qcom/Kconfig         |   8 +++
 drivers/pinctrl/qcom/Makefile        |   1 +
 drivers/pinctrl/qcom/pinctrl-milos.c | 104 +++++++++++++++++++++++++++++++++++
 3 files changed, 113 insertions(+)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 580308621b1..11e6763b5f3 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -54,6 +54,14 @@ config PINCTRL_QCOM_IPQ9574
 	  Say Y here to enable support for pinctrl on the IPQ9574 SoC,
 	  as well as the associated GPIO driver.
 
+config PINCTRL_QCOM_MILOS
+	bool "Qualcomm Milos Pinctrl"
+	default y if PINCTRL_QCOM_GENERIC
+	select PINCTRL_QCOM
+	help
+	  Say Y here to enable support for pinctrl on the Snapdragon Milos SoC,
+	  as well as the associated GPIO driver.
+
 config PINCTRL_QCOM_QCM2290
 	bool "Qualcomm QCM2290 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
index b5a111605ed..4096c1aa491 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_PINCTRL_QCOM_IPQ4019) += pinctrl-ipq4019.o
 obj-$(CONFIG_PINCTRL_QCOM_IPQ5424) += pinctrl-ipq5424.o
 obj-$(CONFIG_PINCTRL_QCOM_IPQ9574) += pinctrl-ipq9574.o
 obj-$(CONFIG_PINCTRL_QCOM_APQ8096) += pinctrl-apq8096.o
+obj-$(CONFIG_PINCTRL_QCOM_MILOS) += pinctrl-milos.o
 obj-$(CONFIG_PINCTRL_QCOM_QCM2290) += pinctrl-qcm2290.o
 obj-$(CONFIG_PINCTRL_QCOM_QCS404) += pinctrl-qcs404.o
 obj-$(CONFIG_PINCTRL_QCOM_QCS615) += pinctrl-qcs615.o
diff --git a/drivers/pinctrl/qcom/pinctrl-milos.c b/drivers/pinctrl/qcom/pinctrl-milos.c
new file mode 100644
index 00000000000..974c1a7d594
--- /dev/null
+++ b/drivers/pinctrl/qcom/pinctrl-milos.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Qualcomm Milos pinctrl
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
+	{"qup0_se5", 1},
+	{"sdc2_clk", 1},
+	{"sdc2_cmd", 1},
+	{"sdc2_data", 1},
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
+#define UFS_RESET(pg_name, ctl, io)			\
+	{					        \
+		.name = pg_name,			\
+		.ctl_reg = ctl,				\
+		.io_reg = io,				\
+		.pull_bit = 3,				\
+		.drv_bit = 0,				\
+		.oe_bit = -1,				\
+		.in_bit = -1,				\
+		.out_bit = 0,				\
+	}
+
+static const struct msm_special_pin_data msm_special_pins_data[] = {
+	[0] = UFS_RESET("ufs_reset", 0xb4004, 0xb5000),
+	[1] = SDC_QDSD_PINGROUP("sdc2_clk", 0xab000, 0, 6),
+	[2] = SDC_QDSD_PINGROUP("sdc2_cmd", 0xab000, 12, 3),
+	[3] = SDC_QDSD_PINGROUP("sdc2_data", 0xab000, 9, 0),
+};
+
+static const char *milos_get_function_name(struct udevice *dev,
+					   unsigned int selector)
+{
+	return msm_pinctrl_functions[selector].name;
+}
+
+static const char *milos_get_pin_name(struct udevice *dev,
+				      unsigned int selector)
+{
+	if (selector >= 167 && selector <= 170)
+		snprintf(pin_name, MAX_PIN_NAME_LEN,
+			 msm_special_pins_data[selector - 167].name);
+	else
+		snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
+
+	return pin_name;
+}
+
+static int milos_get_function_mux(__maybe_unused unsigned int pin,
+				  unsigned int selector)
+{
+	return msm_pinctrl_functions[selector].val;
+}
+
+static struct msm_pinctrl_data milos_data = {
+	.pin_data = {
+		.pin_count = 171,
+		.special_pins_start = 167,
+		.special_pins_data = msm_special_pins_data,
+	},
+	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
+	.get_function_name = milos_get_function_name,
+	.get_function_mux = milos_get_function_mux,
+	.get_pin_name = milos_get_pin_name,
+};
+
+static const struct udevice_id msm_pinctrl_ids[] = {
+	{ .compatible = "qcom,milos-tlmm", .data = (ulong)&milos_data },
+	{ /* Sentinel */ }
+};
+
+U_BOOT_DRIVER(pinctrl_milos) = {
+	.name		= "pinctrl_milos",
+	.id		= UCLASS_NOP,
+	.of_match	= msm_pinctrl_ids,
+	.ops		= &msm_pinctrl_ops,
+	.bind		= msm_pinctrl_bind,
+};
+

-- 
2.53.0

