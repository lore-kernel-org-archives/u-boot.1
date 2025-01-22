Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80329C02182
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 15:03:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC3C38082D;
	Wed, 22 Jan 2025 16:03:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WDv0Wmoh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5237280763; Wed, 22 Jan 2025 16:03:08 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34FD9807F9
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 16:03:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5d647d5df90so11806727a12.2
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 07:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737558186; x=1738162986; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=B8U3u759Hf1GBo6gLCA8+XvQ9L/xtoNFexU8uCTIV3o=;
 b=WDv0WmohSIkK8COKhqjxm4cw878iSfPVfs1k3BEXOdmgbKobAOf5G0aW0BCMXlAzlk
 Xs57hc2BIU54DCmHgZSIqEZfHDsoJAYKc6b636JaaqdRmScr5Sydl1ZoXwyQwsjDxyyJ
 7XEX0fUICixsbdsloFsJroaeLNBTcya2pOTnAhQQJkx6YxmrB/mlMTslzVZayq3UUCDy
 BjhH0R9g0da9ECOW1g8aLURdTBnReY6QWw/he/L8cXL7G4kk36pJkQ/YBjJJgSJwPh25
 OjEAnc/kMqE56SiTs0p6opyxVvPr/3UZHLUPsdzaolv1U70yeZJmYhQR/MS/kTT3D5NT
 B88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737558186; x=1738162986;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B8U3u759Hf1GBo6gLCA8+XvQ9L/xtoNFexU8uCTIV3o=;
 b=SCox9drF1w0GGVhvKpaekPEKk93tmmVfUrbeRz97Cc1y4h2jkR0qEW/rxc61+11MrC
 qscZmcZ4DW88ozvEhJo23ND7HWj8WeTDfTIJyK8P8HvD7/Epy0IoZxlkXErmoaQtZ8mM
 tgNzMC6gf6FLyG2Tmw+9ObwUXcCRdpQV3H6FyarqlEQdF1XnVF1pviQt3+Nznde6Otal
 cRTwmHOO6SMLkabr9aLn72tB8JS5xxu0wq3LlSy6J9Xy0uaHYgKYy7MA0PhPMU9GDqxq
 9eiMDls6v92K8i5/tp86MIBT629iqrm61tAV+kkQVe/2JFbffzjfCE2AKPjYM60xPD1F
 Wg8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtJpMGUwlrjuUDujsQ8FoIRC0y+4p6wzcCF1tzpG0B/wa/16GhqITiRv7fbW1tAgOaZ12jouU=@lists.denx.de
X-Gm-Message-State: AOJu0YzMLZxAt7OgBfI3nW3wdZP5Bfo8lRQE5CPX9tvoRzVAX+27i9CW
 TLp8NnZC1bzSlNBh0hHInot0KtnHWbWlVFwhWW4UV1qgg/vv3jNI/qRpoZHoD2k=
X-Gm-Gg: ASbGncvI52g74PbrcLgzocSXBH8GVf7TZLVd3v0/uO9WLHmjAsusAcw+7oSDYRrKFJF
 4IAlODh4YExYqHyryYaAv33E7TvRNtmiUKyNt9mxpxk/A4/ldy/bv6vLRivdyTg3kbT+cX+jnvW
 TYEwitohonj24B2QQUM0joqdF8BTtiHy9+2kKfrtoVlvn8vQzkoinJs8XCwYf5xAJgX5t+81feq
 j8AL2j7dz1LRMkmWuDbzz5BTkogtIjhTapnd3zm5zEkpg5c+BCvSpLUDlY5vEpR3Z9swuA7oze1
 Jzen8pTjkdN7
X-Google-Smtp-Source: AGHT+IFhOMI1Uueo2AMh+b6i4H8zNke8bYle5NnHBxMAps4Fo4WUTGyzEuhfKl2fOzlxm+F9bEqSoQ==
X-Received: by 2002:a17:907:783:b0:ab3:64dd:bc89 with SMTP id
 a640c23a62f3a-ab38b1100d9mr1657306766b.20.1737558185255; 
 Wed, 22 Jan 2025 07:03:05 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384f223fesm930214166b.105.2025.01.22.07.03.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 07:03:04 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 22 Jan 2025 16:02:51 +0100
Subject: [PATCH 1/2] pinctrl: qcom: add sc7280 pinctrl driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250122-pinctrl-sc7280-v1-1-8bdba72e6366@linaro.org>
References: <20250122-pinctrl-sc7280-v1-0-8bdba72e6366@linaro.org>
In-Reply-To: <20250122-pinctrl-sc7280-v1-0-8bdba72e6366@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: Markus Bauer <Markus.Bauer2@tria-technologies.com>, 
 u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4955;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=swXnFPJK9Y9yCdTln+KIoZEOyvi1bANpK3zYsNS9YVQ=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhvSJHMuq9IU+aHP0vj7RNDeqbf1kvd1OF36ZG047FVzzh
 C0k+ChLRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZiI8HOG/ym3rj/XmBZhcOaO
 cY3QXZni21FB76Yc/jVvk+lxr13PfGIZ/jtt2Z7vr6Z0da3E0ocPdZfMlvqwL/5AYE6p14bnbTt
 Lom4BAA==
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

Introduce a pinctrl driver for SC7280/QCM6490, this is used by the RB3
Gen 2, FairPhone 5 and other devices.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/pinctrl/qcom/Kconfig          |   7 +++
 drivers/pinctrl/qcom/Makefile         |   1 +
 drivers/pinctrl/qcom/pinctrl-sc7280.c | 106 ++++++++++++++++++++++++++++++++++
 3 files changed, 114 insertions(+)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 4f93a34281d5..1d510908d834 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -40,8 +40,15 @@ config PINCTRL_QCOM_QCS404
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon QCS404 SoC,
 	  as well as the associated GPIO driver.
 
+config PINCTRL_QCOM_SC7280
+	bool "Qualcomm SC7280/QCM6490 GCC"
+	select PINCTRL_QCOM
+	help
+	  Say Y here to enable support for pinctrl on the Snapdragon SC7280 SoC,
+	  as well as the associated GPIO driver.
+
 config PINCTRL_QCOM_SDM845
 	bool "Qualcomm SDM845 GCC"
 	select PINCTRL_QCOM
 	help
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
index 43d0dd292225..8ed41b2e1d99 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -7,8 +7,9 @@ obj-$(CONFIG_PINCTRL_QCOM_APQ8016) += pinctrl-apq8016.o
 obj-$(CONFIG_PINCTRL_QCOM_IPQ4019) += pinctrl-ipq4019.o
 obj-$(CONFIG_PINCTRL_QCOM_APQ8096) += pinctrl-apq8096.o
 obj-$(CONFIG_PINCTRL_QCOM_QCM2290) += pinctrl-qcm2290.o
 obj-$(CONFIG_PINCTRL_QCOM_QCS404) += pinctrl-qcs404.o
+obj-$(CONFIG_PINCTRL_QCOM_SC7280) += pinctrl-sc7280.o
 obj-$(CONFIG_PINCTRL_QCOM_SDM845) += pinctrl-sdm845.o
 obj-$(CONFIG_PINCTRL_QCOM_SM6115) += pinctrl-sm6115.o
 obj-$(CONFIG_PINCTRL_QCOM_SM8150) += pinctrl-sm8150.o
 obj-$(CONFIG_PINCTRL_QCOM_SM8250) += pinctrl-sm8250.o
diff --git a/drivers/pinctrl/qcom/pinctrl-sc7280.c b/drivers/pinctrl/qcom/pinctrl-sc7280.c
new file mode 100644
index 000000000000..9aff9c81bc5f
--- /dev/null
+++ b/drivers/pinctrl/qcom/pinctrl-sc7280.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Qualcomm sc7280 pinctrl
+ *
+ * (C) Copyright 2024 Linaro Ltd.
+ *
+ */
+
+#include <dm.h>
+
+#include "pinctrl-qcom.h"
+
+#define WEST 0x00000000
+#define SOUTH 0x00400000
+#define NORTH 0x00800000
+
+#define MAX_PIN_NAME_LEN 32
+static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
+
+static const struct pinctrl_function msm_pinctrl_functions[] = {
+	{ "qup05", 1 },
+	{ "gpio", 0 },
+	{ "pcie1_clkreqn", 3},
+};
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
+static const struct msm_special_pin_data sc7280_special_pins_data[] = {
+	[0] = UFS_RESET("ufs_reset", SOUTH + 0xbe000),
+	[1] = SDC_PINGROUP("sdc1_rclk", 0xb3004, 0, 6),
+	[2] = SDC_PINGROUP("sdc1_clk", 0xb3000, 13, 6),
+	[3] = SDC_PINGROUP("sdc1_cmd", 0xb3000, 11, 3),
+	[4] = SDC_PINGROUP("sdc1_data", 0xb3000, 9, 0),
+	[5] = SDC_PINGROUP("sdc2_clk", 0xb4000, 14, 6),
+	[6] = SDC_PINGROUP("sdc2_cmd", 0xb4000, 11, 3),
+	[7] = SDC_PINGROUP("sdc2_data", 0xb4000, 9, 0),
+};
+
+static const char *sc7280_get_function_name(struct udevice *dev, unsigned int selector)
+{
+	return msm_pinctrl_functions[selector].name;
+}
+
+static const char *sc7280_get_pin_name(struct udevice *dev, unsigned int selector)
+{
+	if (selector >= 175 && selector <= 182)
+		snprintf(pin_name, MAX_PIN_NAME_LEN,
+			 sc7280_special_pins_data[selector - 175].name);
+	else
+		snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
+
+	return pin_name;
+}
+
+static unsigned int sc7280_get_function_mux(__maybe_unused unsigned int pin, unsigned int selector)
+{
+	return msm_pinctrl_functions[selector].val;
+}
+
+static struct msm_pinctrl_data sc7280_data = {
+	.pin_data = {
+		.pin_count = 183,
+		.special_pins_start = 175,
+		.special_pins_data = sc7280_special_pins_data,
+	},
+	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
+	.get_function_name = sc7280_get_function_name,
+	.get_function_mux = sc7280_get_function_mux,
+	.get_pin_name = sc7280_get_pin_name,
+};
+
+static const struct udevice_id msm_pinctrl_ids[] = {
+	{
+		.compatible = "qcom,sc7280-pinctrl",
+		.data = (ulong)&sc7280_data
+	},
+	{ /* Sentinel */ } };
+
+U_BOOT_DRIVER(pinctrl_sc7280) = {
+	.name = "pinctrl_sc7280",
+	.id = UCLASS_NOP,
+	.of_match = msm_pinctrl_ids,
+	.ops = &msm_pinctrl_ops,
+	.bind = msm_pinctrl_bind,
+};

-- 
2.48.0

