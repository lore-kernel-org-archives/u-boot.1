Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 791D2103E18F
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 14:44:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38D2283FC0;
	Wed, 18 Mar 2026 15:44:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="MCwyLiOx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 541988415D; Wed, 18 Mar 2026 13:46:59 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CAE58419E
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 13:46:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b8f97c626aaso118361466b.2
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 05:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1773838016; x=1774442816; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fiZzficzMAxK6ed/r9yudHR5B+pCBXaQdEmiO0CXx7U=;
 b=MCwyLiOxN59VQGrsv7LmiFyox72dxncwSM1Ldtd+elajCmChhTVCqeU3za7GRiqZgo
 qwPvBvI7mRfGGEWmRid33jteqpRNW2BHjllIcmUab6yBDe2oMtCCJeSRub32YcSmKyr4
 yvY6P8b6s2uztCS7PyHypeESMHqmg4W03uzbwamoytj1fGWcEuUiLSTFPRfMtxkrA1uV
 DzXf6Qfgts4O0ugKBaiExJRETBKtNU62pDlPaKFYmF3u4EiJdPuCZw/bNCdTgJcYdHKr
 Vl5cfOprJAiaVBjvYl9iEXOyPPvSbMsxp1I6+cxpkZ9X3ngWhUfbprRmwXCzWjGgfKng
 AzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773838016; x=1774442816;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fiZzficzMAxK6ed/r9yudHR5B+pCBXaQdEmiO0CXx7U=;
 b=jvln734XNLaRyNU3CY7IjCBXFey5DKOZGtFCjAOur+kdJD8//dNskTWn83eEyRvP7k
 FDvRJ93Esp2dcG+GUaEX/2QuMV6BLC4jo2qqFaIhP1d8kN6bG2082qoCgg0hkuJ0ius7
 7B8F0TCMkoslpWyvFotY8/ofrp8BKUWquE+Jc08386lCJu57JS6xCS7dhfP7fmtxQxFj
 M23PR51rJO0pVb79uRwxdAhLzunC11nAAeWry/BwAJHdceMZtmf4fwfYFuY7kIadHaI0
 VP8ML4+lFkj9/99lGqyWp7VBMYxZa7nZ1/y1EQfhNevPYhG5fkmHD1LJdx2Lz47TWzyz
 Z86A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXnbFLcVLShfJbj+uQwZwz9pkytItiobrkRzSdoVlMjDP5ZTJn5bBbgznq37ApAy3oVWVHrTc=@lists.denx.de
X-Gm-Message-State: AOJu0YxwZ+8ByxljhtVDCBCSn5hFMLpnHdnC+1ZTFt/gWLmW0jes36lK
 4PDbGQfAZa4kxPcFxQLNwmmyxy+2X2YcXSWWLCCQmeaMLc6JSuYQ4ULMDeR67acISfA=
X-Gm-Gg: ATEYQzyo+60yH1CL0k7OVFufck8B1PJIsnI0zPQZ35/s5k45izxC2mF6QEMgzhSk1GQ
 ISfeDTNuHwwXLNcpSswUyGrv2Kp4OuhnjRf/JvQwC00Hxxr2/9KbdJUSRNPj5nzURJTXOldDSMs
 RPjjRLwftvn6ThNcvQa3vAx/vR1m/ff3ToAOQUAdfoMRFU5qYmcOlEDIKIJo5mjiVKNMgVsVc+h
 IrhCKAV5Az2eNSsQW8tOahQDU4L1FacGu+BW3w2jNK3Ez4nCcO48hrqfWdRmEikIUvXB2FJsNUn
 xlvDPi8CUI1Rv6DIyIGdR9zA62XY5SBIQK3FfwI3K+Hy3XrB2jy2wD8D+MuuHnJf9VcFwiBVL1B
 XMHyEXIPuok2PMto4yUrbdRQ4ZBLrVb2ppqeS4GkmPD3f8UtLjxTUhiKQCVlEyWjb82N82EHNAU
 I4bErgeehXmSZ1t87sz7rPWcCN2RN3FUMGzLYburcfAqd63OCqfYher9bbUCQWQhn2Nnq9Rs0uV
 HDRjw==
X-Received: by 2002:a17:907:1608:b0:b97:554:f100 with SMTP id
 a640c23a62f3a-b97f49407bemr199182966b.20.1773838016391; 
 Wed, 18 Mar 2026 05:46:56 -0700 (PDT)
Received: from [172.16.220.101] (144-178-202-139.static.ef-service.nl.
 [144.178.202.139]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b97f142cf16sm206080366b.20.2026.03.18.05.46.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 05:46:55 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 18 Mar 2026 13:46:27 +0100
Subject: [PATCH v2 1/7] drivers: pinctrl: Add Qualcomm Milos TLMM driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-milos-bringup-v2-1-650b91dd75d8@fairphone.com>
References: <20260318-milos-bringup-v2-0-650b91dd75d8@fairphone.com>
In-Reply-To: <20260318-milos-bringup-v2-0-650b91dd75d8@fairphone.com>
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
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773838014; l=4825;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=F+2IyTcgXAMZacfzUdn+mHeq8A8Yf+yGEYWB5AfAQR0=;
 b=O75HEmmNVvxA1Zx2L8FKn+xttWZFS+0cv5kKvPh2bw+fsbqtwesPcp4Gl2bbagyfJ2eteHbkL
 262qJsm9sS8A1y9uUXV5f0gOdtdBVxwqC8cpXgBIO+KztsHB/UDoqnk
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 18 Mar 2026 15:44:14 +0100
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

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/pinctrl/qcom/Kconfig         |   8 +++
 drivers/pinctrl/qcom/Makefile        |   1 +
 drivers/pinctrl/qcom/pinctrl-milos.c | 103 +++++++++++++++++++++++++++++++++++
 3 files changed, 112 insertions(+)

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
index 00000000000..4f958fbfbf3
--- /dev/null
+++ b/drivers/pinctrl/qcom/pinctrl-milos.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Qualcomm Milos pinctrl
+ *
+ * (C) Copyright 2024 Linaro Ltd.
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

-- 
2.53.0

