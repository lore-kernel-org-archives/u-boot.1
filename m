Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 519BACD11C2
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 17:53:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9100B8815B;
	Wed, 10 Apr 2024 19:53:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ADnmbC5V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05448881BA; Wed, 10 Apr 2024 19:53:35 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C7D08817B
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 19:53:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-56c5d05128dso7927393a12.0
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 10:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712771612; x=1713376412; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=t4tp7JqwmbMUxN7p5YL0DZ2IpXooONJoFqd+rR5KZls=;
 b=ADnmbC5VzDGpuRtHwXOGOfZWTys+k3d2pgfFfUZKZ4ZKlCEU53voQo2H9ujCNNiVOf
 iCSKs/SgOp4hpaW1V5FP+2P7u/vLtZfsg5It6Kb317ol1Q8CM5FoOW5mNT/GAFtZBhLh
 jNJW2P2VMgRKsYDJnCqPvi2CR3Z6i77XpSHOo01wOmQMGuS41slxKg5Bo8hsd9Bp4Qmf
 RFTrBOYDJJxCttea5D9weO8/CKuCIVZs/uBO43p2NhichTk3Ii3ET0QC4EhfPM8FviSF
 KXPpncjXD5/SSQl1smmUB9MNA1WL+JJyO5HaZNq7vf5WxpsmNBZEgznboDHrEwsLMPf7
 B2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712771612; x=1713376412;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t4tp7JqwmbMUxN7p5YL0DZ2IpXooONJoFqd+rR5KZls=;
 b=W3ZC7WfaiIE3PSc+wK/jMXP5c9yUPwOO5e57JQjwE4arcB2kwi4dURRBZm0p7NbAHB
 velZXZhWJ4AyRIIfTvuynNenOwqRrlqV69d2DkOBs42HODhMt9AucNx5J3wbQYucjqO0
 ytqYOmm2zh4KTT0EBfjT5nsDqykUT/UM800I4BSJnFSEjCRHQI+lL/e3HEG7akvbWO7x
 f78MoAW8agQMY3Qb/Kr4/FSaVlcNCoLU9X63bD1MT0+b2IRoS43ecWhf69zQIrzrm/Z1
 lq4/p2JZe+S/5PJa8vqd3/Ear6NO8VLCgNF4H5lHKnSiCmHbsVXZ2DNDBPMmGSSkNk4f
 SJiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpKUMxzutee5ax6j0VaMTbgL/L/AEbqM82e1HFPqAO4PjrpMw7uXNECl8xEKJlNGObYM/lAJXRpJ6WOvVPD9XBKgq5jA==
X-Gm-Message-State: AOJu0YztKjxrfYYbxgm8TVGJualEOCKKmLTquKFnYYnDSzy+Iq/E+f9Q
 JfTmSay4Mc5LOxtUIx1LHbB5yhGun7NruWzFNV+Br46S1lS87wIg7BK2puMSMiQ=
X-Google-Smtp-Source: AGHT+IErLVSPWbOGsvwoqnvkLQjHxnxV5eek1kbO5dQ2m5Iz00yQ7QPmBvpFYdjA+SN6sjTGjTu84g==
X-Received: by 2002:a50:ab18:0:b0:56d:c4eb:6328 with SMTP id
 s24-20020a50ab18000000b0056dc4eb6328mr2183220edc.29.1712771611891; 
 Wed, 10 Apr 2024 10:53:31 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::4716])
 by smtp.gmail.com with ESMTPSA id
 w1-20020a056402128100b0056e2b351956sm6543599edv.22.2024.04.10.10.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Apr 2024 10:53:31 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 10 Apr 2024 19:52:36 +0200
Subject: [PATCH v2 1/4] pinctrl: qcom: add qcm2290 pinctrl driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-b4-qcom-rbx-soc-v2-1-5120a9c7f6ce@linaro.org>
References: <20240410-b4-qcom-rbx-soc-v2-0-5120a9c7f6ce@linaro.org>
In-Reply-To: <20240410-b4-qcom-rbx-soc-v2-0-5120a9c7f6ce@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3680;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=wIhtbCK00y80rWMGbvITilPUuGZfCoQErVGMDMJBYc4=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmFtIZF2m7qYS1f17of0mqAAbQtJOrR4nh1+mPa
 zAG57FIvOCJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZhbSGQAKCRAFgzErGV9k
 tn5RD/0bKVsP91Ol/sETUr11ixMxd9IBxEQFkG75CiPNXlzgFDGUoIZ7waWLPvyG1yA+uAaLUjB
 F0wtY7mhUEC7MqzW/6HqwElrIF3X82fgHV/vdIPnjpgVGHlowsnkGxWK4V8bBUSj84GgUrl9vZJ
 80VimVXg1KyMfuOYEnUSZMxYdros72k7OpZVR2Q8J7x/aqmI8fF0sGYUTRu1GrHkftLHthdCZHo
 Kw7V7pHY0Ix1vbji9Zw0GRmXUT+WabuFaFTqm/nvnI8kOGkB30NbK6YcKqZD58OnNgAxGKPRMck
 CvthkTv5AYZ1RS9RYE+GDnuD3S5WMV4uA2PK6aAxmdK9A07Xve5WQwE2JeyLFwELpT8+2EQcd6H
 iaDumXD66JH0JI4mOM+45y9UdsRNOnX1EiGgRIT60JwXV2bxm707uOfDEwDwC8b9nsAR4Bz5IKz
 d4F7zcz7yCq04CrsIvmTC8HHsCxCwnn99Szi2W8T44EbQgBUBEv/F2NpYjVQcJmj+JMbgcyZCf7
 IgvC5UpJssauq/rhHp5IDpGn4ZFip3VIG0c8q/qJwPN9W8ie7kg5MuxhHKt1JOx7IaIQ4zdovsk
 YbP9/eyi+BIi0F5YYGZJpFSGnoePIRnpywLWL9nK/gr51nvT1qwUd79dCi5+LPwIPLkUNcCKVaw
 tOSsrsHhwmq69YA==
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

This SoC has a basic pinctrl block with no tiles.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/pinctrl/qcom/Kconfig           |  7 ++++
 drivers/pinctrl/qcom/Makefile          |  1 +
 drivers/pinctrl/qcom/pinctrl-qcm2290.c | 70 ++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 2fe639814785..35140efd5b62 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -26,8 +26,15 @@ config PINCTRL_QCOM_IPQ4019
 	help
 	  Say Y here to enable support for pinctrl on the IPQ4019 SoC,
 	  as well as the associated GPIO driver.
 
+config PINCTRL_QCOM_QCM2290
+	bool "Qualcomm QCM2290 GCC"
+	select PINCTRL_QCOM
+	help
+	  Say Y here to enable support for pinctrl on the Snapdragon QCM2290 SoC,
+	  as well as the associated GPIO driver.
+
 config PINCTRL_QCOM_QCS404
 	bool "Qualcomm QCS404 GCC"
 	select PINCTRL_QCOM
 	help
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
index 6d9aca6d7b7e..0b1d610ea3e8 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -5,6 +5,7 @@
 obj-$(CONFIG_PINCTRL_QCOM) += pinctrl-qcom.o
 obj-$(CONFIG_PINCTRL_QCOM_APQ8016) += pinctrl-apq8016.o
 obj-$(CONFIG_PINCTRL_QCOM_IPQ4019) += pinctrl-ipq4019.o
 obj-$(CONFIG_PINCTRL_QCOM_APQ8096) += pinctrl-apq8096.o
+obj-$(CONFIG_PINCTRL_QCOM_QCM2290) += pinctrl-qcm2290.o
 obj-$(CONFIG_PINCTRL_QCOM_QCS404) += pinctrl-qcs404.o
 obj-$(CONFIG_PINCTRL_QCOM_SDM845) += pinctrl-sdm845.o
diff --git a/drivers/pinctrl/qcom/pinctrl-qcm2290.c b/drivers/pinctrl/qcom/pinctrl-qcm2290.c
new file mode 100644
index 000000000000..af969e177d73
--- /dev/null
+++ b/drivers/pinctrl/qcom/pinctrl-qcm2290.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Qualcomm qcm2290 pinctrl
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
+	{ "qup4", 1 },
+	{ "gpio", 0 },
+};
+
+static const char *qcm2290_get_function_name(struct udevice *dev, unsigned int selector)
+{
+	return msm_pinctrl_functions[selector].name;
+}
+
+static const char *qcm2290_get_pin_name(struct udevice *dev, unsigned int selector)
+{
+	static const char *const special_pins_names[] = {
+		"sdc1_rclk", "sdc1_clk", "sdc1_cmd",  "sdc1_data",
+		"sdc2_clk",  "sdc2_cmd", "sdc2_data",
+	};
+
+	if (selector >= 127 && selector <= 133)
+		snprintf(pin_name, MAX_PIN_NAME_LEN, special_pins_names[selector - 127]);
+	else
+		snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
+
+	return pin_name;
+}
+
+static unsigned int qcm2290_get_function_mux(__maybe_unused unsigned int pin, unsigned int selector)
+{
+	return msm_pinctrl_functions[selector].val;
+}
+
+struct msm_pinctrl_data qcm2290_data = {
+	.pin_data = {
+		.pin_count = 133,
+		.special_pins_start = 127,
+	},
+	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
+	.get_function_name = qcm2290_get_function_name,
+	.get_function_mux = qcm2290_get_function_mux,
+	.get_pin_name = qcm2290_get_pin_name,
+};
+
+static const struct udevice_id msm_pinctrl_ids[] = {
+	{
+		.compatible = "qcom,qcm2290-tlmm",
+		.data = (ulong)&qcm2290_data
+	},
+	{ /* Sentinel */ } };
+
+U_BOOT_DRIVER(pinctrl_qcm2290) = {
+	.name = "pinctrl_qcm2290",
+	.id = UCLASS_NOP,
+	.of_match = msm_pinctrl_ids,
+	.ops = &msm_pinctrl_ops,
+	.bind = msm_pinctrl_bind,
+};

-- 
2.44.0

