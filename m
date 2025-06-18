Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1715C71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 14:46:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 142FD82E20;
	Wed, 18 Jun 2025 16:45:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="i1IYfTh2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6108282CF4; Wed, 18 Jun 2025 16:25:34 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2542982D21
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 16:25:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-adb2bd27c7bso1039843866b.2
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 07:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1750256730; x=1750861530; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ajjSPZEZTzwJF57Mpg7E33aXCoNcckNd8cRUQDNuSaQ=;
 b=i1IYfTh2N+8F9AXUs4Ll7LYXg37TGvFLJF8KdjLyqy5Fq4IRYPY91Eg8JUmMNCqW3u
 cG5b1IRGKcDbMcO5ROW5drrxW6XKSkvvh2SrJwP9/lMlSGUM4TNXdxRadLciU6KN9ZSn
 GmXYRBs4csG/afYb2KDNI81IwP9skWG/pOLvdkP0dnXf8mCH6956WmU3ldBMbX1vX3JC
 utjFtgQyD2KpLB4u0ARSF1ymZIoFh+657Wc1xfFTHAj34D6RxNW7qWwjszupeRSTRtp2
 Bn3g7RZyIrtE/fpMBu9ByHVQUS+x8kpfIvGwbxjwBgb3ukSBrL3fiUQPo7+3/J9kDXK4
 yEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750256730; x=1750861530;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ajjSPZEZTzwJF57Mpg7E33aXCoNcckNd8cRUQDNuSaQ=;
 b=hBVYvzyay7d9GUH/UhMuDcF9f3QvbSjfAwJZYGP9eQavSjougyFeG4iKkt2Abo+xOa
 txeEUQLrx/5jborEZ99OFnyquwNKurK4G6vHL104mLZJ5W1MqLjuHikCuM0z3sMYhM7B
 5H+iZ/H3ZhpW9U5d1WqZveCjdb/a7iGX04O3LHaF3LpXSyaxxGZea3ky/qQUHDC+BaLr
 Aapk5JSKp1edSTYJ0nQAj7uGvFgakeUXDqcGWfpkilSrH7guttFh9Gny2geHzjHcEr2w
 zsf+CvTkxR4HLQ46LpnxJRfYsHs2Xii4nInWTuY+KAHrHQs95k5CSMZEFpbe7V05aeIY
 Vr4w==
X-Gm-Message-State: AOJu0YwByk8b/+x5EFGdsWru7kYcTL0FcJVOuZ2LEdujyvghVTejjPK3
 U1dH4xr2mKbFkH0oWaOqL0VbLeR+o/Pp0fC9o9UT8xkDH4OVZcnU1GvZdVsUPMTVLHvo9K1fIzl
 +IHPG
X-Gm-Gg: ASbGncsuKbe1MIqDVa+Bg8azl9oHoP41zOubbmxWvaf1kePv07gYTl7e+FhDC+imP/h
 ULg9Wt/PsAR7sV5enYHEel1B3YiLFoVUfUb07VuLSKdoCHDJ1YcjOqV534Gj+UYwHPfmnvmBopV
 nfdgqPHSYZy66aGZzBuaV4ORYnCrqQdc28k4v/Ts+ouwPM22kvvsKfQH11lSaSnI7jpAxdk5EbS
 fULXhIcPscovXtPNQ5IBnb+Vdn26IGFnL5zbzX7Gkw3fhIV9vK5uKUeat7gblQKXClGE3Tywnad
 92LyuEp5IkTW2YXqupfg/xmXI8E29smQ71waTTZ/JxFZo19blFT3kIjtISc0v11JbKcq+Ut1TU4
 qzM67Ovldy5C1Kt8iMkhKa3vwnKBuqSWx
X-Google-Smtp-Source: AGHT+IE9UfB8hfIDkOav6+/mDtTotr7U2m14v5FSlVp6c3lDUIS/PNRhf6pT5QqFUtSH9GKdHgB1TQ==
X-Received: by 2002:a17:906:f597:b0:ad1:e7f0:d8e5 with SMTP id
 a640c23a62f3a-adfad31a6b6mr1901021066b.16.1750256730492; 
 Wed, 18 Jun 2025 07:25:30 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-adec8159e19sm1056733866b.4.2025.06.18.07.25.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Jun 2025 07:25:30 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 18 Jun 2025 16:25:19 +0200
Subject: [PATCH 3/8] drivers: pinctrl: Add Qualcomm SM6350 TLMM driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-sm6350-bringup-v1-3-3cc22aab7a7a@fairphone.com>
References: <20250618-sm6350-bringup-v1-0-3cc22aab7a7a@fairphone.com>
In-Reply-To: <20250618-sm6350-bringup-v1-0-3cc22aab7a7a@fairphone.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750256728; l=5040;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=nIf3f/mdR/z02pCd435n6msDKuiYzKJOYIv8esN806A=;
 b=HQao+bsJVirk77jXkhSo4CGqH51F8YJO0PeQW1R3l3HPFNpczm5yzOHqn0vuzfh/jzhboKzTC
 s1UsCJ65iJMDQKezhu08HyKDoSi+aAVYEpNXeNd7FRmD58oxvcjxvzt
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 18 Jun 2025 16:45:31 +0200
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

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/pinctrl/qcom/Kconfig          |   7 +++
 drivers/pinctrl/qcom/Makefile         |   1 +
 drivers/pinctrl/qcom/pinctrl-sm6350.c | 104 ++++++++++++++++++++++++++++++++++
 3 files changed, 112 insertions(+)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index e567cb113a316592c6cfb9f42350fc60291772bc..bfda968299d694ba7db9796e561799ab0195328a 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -82,6 +82,13 @@ config PINCTRL_QCOM_SM6115
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
index 6ffc6d48c1553a21bdf6aecdaee41c76251fae2d..8a3ad5d39f7869f2dabecc829961a5d7fe9cc596 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_PINCTRL_QCOM_SC7280) += pinctrl-sc7280.o
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
2.50.0

