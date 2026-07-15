Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2948C44501
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 01:04:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 044B584D3A;
	Thu, 16 Jul 2026 03:03:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="qArw4EYw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86B6184BB3; Wed, 15 Jul 2026 17:17:54 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35B3484C0F
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 17:17:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c167bda216fso139988266b.2
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 08:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1784128672; x=1784733472; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Wl44XAKTDpECrTaKQx4nKhWfnUcxJJjKVAS0wdtlfco=;
 b=qArw4EYwF3AWuEhXCZLomP2dT2CgsJWhRketQYMl0ze70PLm7YZfmdCmwgXREK4yM3
 t41SZHL/nqcS/BudZAmSSTL6457xqPfCGYg7JpRpLg13rlaelargN9lzEr2miX4C3fcZ
 /a6ZiaVrn2MJRO4/CJShOxe2BEky4Vcz6kUFawBhZYoGehmO+LU7vSUBjbksNgk7Hk0X
 K7p1gEif6avUDKL7Krmf+TE7mE5Ou7XSBJAQfecZ45q3TQJjXx530KHJ1ijoVPp3DmnZ
 +nZ5NkVM4ZKJINKdDalvMGvGncUbTLVHlGNLMlHnht/7Zpj3+eBAMBISj922BI+rsCmS
 92BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784128672; x=1784733472;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Wl44XAKTDpECrTaKQx4nKhWfnUcxJJjKVAS0wdtlfco=;
 b=MxpoQ3wgrLQ7rMel1tEXjUxJkLgtIhsBuqJy1CG4cyIUnNw4yl+JeMpljF+R/3+6qj
 Z1NKW71J35Nue6L7XvSF2RdUPHBj6NLrD60QuNXM6ti0VY1e75+OACE5z93ad0qkaM8a
 8aQy2xy1fBTCwKnhA8o6oSEL7Gdrg74S0rqnGPQLmn7iEfnJty5N1w3TdO/ZPLPII2Y0
 A2Qp2zRhnKMe7hw5StCXmqf8P6UT8q4QbsthoA7ZVc8bGSJ/H7HSgjy3Mtqau5Qbtu/t
 vW9XR2pMCQkNb9yAvdOruqZNrxtC+WE8A1/9xgLX5v5RBtbgI95GnNmYpQAW7He8XUX5
 mUlA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqsgbJoBZmeZh6m07SqDYSc9dUTvjOHJyUwWOi1Ih6tLYYQtyG/P2JnlWDcQbZCec+aZlJwFP4=@lists.denx.de
X-Gm-Message-State: AOJu0YzjMKXkQkiP3EI14RAmXi9HVG33yr+uRUGQjSK5cxCHdmtrxQML
 J3W6LI3/c2j/gl01zN4MAB4FTCsYpN1unOYjXX8mjnLRgmsYAWH+wpUrrv3r7hQ6VJg=
X-Gm-Gg: AfdE7cnSmzhKRr1YXAdvWnRLZx3btxjo23t1YFcq83/Fx4POruzl/Xn4OTz+cLZWnsA
 lFrIc0KdHxbpXt7wCjUKQyzV4laxgY5T876/vMpx8N4MOia5IYFgTBj6CnvHQua51UGSOR3G1f6
 umIQEFKlkfMyA02ZpFoDwKoIpP8nEBBCnXNiBHJO7gXylVhKiC8Ru/X05C5e7Ae13kDtExbWQQP
 lH2WIvbk1/LdRMW3Q6kyHSab84y/jFhddgxEwmN8AMCh/INrZTfhvRkPu+stDPSZhr9lkUdcNf3
 hBjVnNnhXLY37pLfiXHNqu2dyk4VRjZivsQXt4y7BM0HG0VufKD6INhsNz87l9BCIdngTC5ROQC
 6SZf1QaEGhAHbz1pui2PlrFLRNahCLc388Ep/kjnXH0rST5SZrIq5WaII/aVBRgYnynvGA4MwtR
 KzvFs6lEgjQGx9yinpWAefZpIWut8ySeFndGZN4k4PWx4+A3ytKESzVGBgJepq5jlE0LLIr6ld6
 F+3uQ==
X-Received: by 2002:a17:907:1604:b0:c16:9bd:39cb with SMTP id
 a640c23a62f3a-c161f3b31e8mr859554866b.52.1784128671526; 
 Wed, 15 Jul 2026 08:17:51 -0700 (PDT)
Received: from [172.16.240.102] (144-178-202-142.static.ef-service.nl.
 [144.178.202.142]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c168716f6dbsm59145766b.15.2026.07.15.08.17.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 08:17:51 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 15 Jul 2026 17:17:42 +0200
Subject: [PATCH 3/4] drivers: pinctrl: Add Qualcomm MSM8953 TLMM driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-msm8953-basic-v1-3-bc4cb5099d8e@fairphone.com>
References: <20260715-msm8953-basic-v1-0-bc4cb5099d8e@fairphone.com>
In-Reply-To: <20260715-msm8953-basic-v1-0-bc4cb5099d8e@fairphone.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Biswapriyo Nath <nathbappai@gmail.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Johan Jonker <jbx6244@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Antony Kurniawan Soemardi <linux@smankusors.com>, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784128669; l=3921;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=MLTatwKO60cg2hVN7YA+sgY3ChPepna+mYisRh9UXLI=;
 b=WlZQGpCd1iUbyMDU2PKXADAPtEIGGQ0W05eSx373x93CA6ZduJP3rJA5dkvIDeU19N84oHDf1
 IKVv6980DsbB+tbOal0eazp5Lpjpkg/WcwVmb2p+02/q4f7o4NfKBjZ
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Thu, 16 Jul 2026 03:03:52 +0200
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
on MSM8953 SoC.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/pinctrl/qcom/Kconfig           |  8 ++++
 drivers/pinctrl/qcom/Makefile          |  1 +
 drivers/pinctrl/qcom/pinctrl-msm8953.c | 80 ++++++++++++++++++++++++++++++++++
 3 files changed, 89 insertions(+)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 0bea461fcc3..21e735a2b99 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -62,6 +62,14 @@ config PINCTRL_QCOM_MILOS
 	  Say Y here to enable support for pinctrl on the Snapdragon Milos SoC,
 	  as well as the associated GPIO driver.
 
+config PINCTRL_QCOM_MSM8953
+	bool "Qualcomm MSM8953 Pinctrl"
+	default y if PINCTRL_QCOM_GENERIC
+	select PINCTRL_QCOM
+	help
+	  Say Y here to enable support for pinctrl on the MSM8953 SoC,
+	  as well as the associated GPIO driver.
+
 config PINCTRL_QCOM_QCM2290
 	bool "Qualcomm QCM2290 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
index 87cb128c4d4..064c75207cf 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_PINCTRL_QCOM_IPQ5424) += pinctrl-ipq5424.o
 obj-$(CONFIG_PINCTRL_QCOM_IPQ9574) += pinctrl-ipq9574.o
 obj-$(CONFIG_PINCTRL_QCOM_APQ8096) += pinctrl-apq8096.o
 obj-$(CONFIG_PINCTRL_QCOM_MILOS) += pinctrl-milos.o
+obj-$(CONFIG_PINCTRL_QCOM_MSM8953) += pinctrl-msm8953.o
 obj-$(CONFIG_PINCTRL_QCOM_QCM2290) += pinctrl-qcm2290.o
 obj-$(CONFIG_PINCTRL_QCOM_QCS404) += pinctrl-qcs404.o
 obj-$(CONFIG_PINCTRL_QCOM_QCS615) += pinctrl-qcs615.o
diff --git a/drivers/pinctrl/qcom/pinctrl-msm8953.c b/drivers/pinctrl/qcom/pinctrl-msm8953.c
new file mode 100644
index 00000000000..0c51461183c
--- /dev/null
+++ b/drivers/pinctrl/qcom/pinctrl-msm8953.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Qualcomm MSM8953 pinctrl
+ *
+ * (C) Copyright 2026 Luca Weiss <luca.weiss@fairphone.com>
+ *
+ */
+
+#include <dm.h>
+
+#include "pinctrl-qcom.h"
+
+#define MAX_PIN_NAME_LEN 32
+static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
+static const char * const msm_pinctrl_pins[] = {
+	"qdsd_clk",
+	"qdsd_cmd",
+	"qdsd_data0",
+	"qdsd_data1",
+	"qdsd_data2",
+	"qdsd_data3",
+	"sdc1_clk",
+	"sdc1_cmd",
+	"sdc1_data",
+	"sdc1_rclk",
+	"sdc2_clk",
+	"sdc2_cmd",
+	"sdc2_data",
+};
+
+static const struct pinctrl_function msm_pinctrl_functions[] = {
+	{"blsp_uart2", 2},
+};
+
+static const char *msm8953_get_function_name(struct udevice *dev,
+					     unsigned int selector)
+{
+	return msm_pinctrl_functions[selector].name;
+}
+
+static const char *msm8953_get_pin_name(struct udevice *dev,
+					unsigned int selector)
+{
+	if (selector < 142) {
+		snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
+		return pin_name;
+	} else {
+		return msm_pinctrl_pins[selector - 142];
+	}
+}
+
+static int msm8953_get_function_mux(__maybe_unused unsigned int pin,
+				    unsigned int selector)
+{
+	return msm_pinctrl_functions[selector].val;
+}
+
+static const struct msm_pinctrl_data msm8953_data = {
+	.pin_data = {
+		.pin_count = 155,
+		.special_pins_start = 142,
+	},
+	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
+	.get_function_name = msm8953_get_function_name,
+	.get_function_mux = msm8953_get_function_mux,
+	.get_pin_name = msm8953_get_pin_name,
+};
+
+static const struct udevice_id msm_pinctrl_ids[] = {
+	{ .compatible = "qcom,msm8953-pinctrl", .data = (ulong)&msm8953_data },
+	{ /* Sentinel */ }
+};
+
+U_BOOT_DRIVER(pinctrl_msm8953) = {
+	.name		= "pinctrl_msm8953",
+	.id		= UCLASS_NOP,
+	.of_match	= msm_pinctrl_ids,
+	.ops		= &msm_pinctrl_ops,
+	.bind		= msm_pinctrl_bind,
+};

-- 
2.55.0

