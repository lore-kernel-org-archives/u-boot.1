Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B79DBCD128A
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 17:53:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68F7F881D3;
	Wed, 10 Apr 2024 19:53:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d0H0I1R5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C634B88149; Wed, 10 Apr 2024 19:53:35 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B36DF86FCE
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 19:53:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-516c97ddcd1so8496450e87.2
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 10:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712771613; x=1713376413; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+v0NuUtLJa4zqPS0sk3oEFPqZQe14YCYdTlzDnGa/Rg=;
 b=d0H0I1R5/ohJmi5HnZEJvIhZp2fHAFCLMh/u+dAdw6HDAiGFF82DvV2cyvfA+4WNU/
 hALjPzYVn//ZDZHb35+rOupDvKeiBiPbWPzI7dhGybhbmBvRQFDcArXqAWUzcOTi0unK
 OHrTRgtqxK9KjbIpXHvjzO8USnyJ4aoxEtiMwUPdPNGA45bL8CxWCE8yKUme1sSsAYil
 nHlgpswWGTFsI1OB4ZeouRJDbWAMw+xEjuI8hhcdZ4Isl3YROeaZztMZ6MydD2u259xY
 aixwoAjRme+xPeps5KsPa5zaQwmUiHIfD30OMjxCN97abxHRYmNTP1TKGOx/irIGBnwa
 11QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712771613; x=1713376413;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+v0NuUtLJa4zqPS0sk3oEFPqZQe14YCYdTlzDnGa/Rg=;
 b=f75PLrQWyI5qjPWlzDuy797nXHntfcHZpoQsV6ZulwAj2QK7ScwKjrLz7pbEaCAkOj
 7a3vaH8TOzOS5FKxu5M4Fm5dHzIo9xSuyfElWjXElCuSlcUYpTR+wc6zY9a4OhF1gnPV
 UL93/TA9zuolqCnE21p8qd8WkrexJf5UV27VTKuYYqhXZAAwwWxnMBgw3uvMCfVpFULU
 VxnafA3yodPiDgN67xVNHmlHiMdy4dVzdWdCRP7laQ7fm4Q/w8ZwmIStzHbEcoJVc5nQ
 l56Ugvj9CAtk8YggYt9Q4JgHBPPxDvQ0qAFRMULfhv1eLcHYCX15nGNG60FlsT068iOB
 aRMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3xHabMZjDXTj6qenUHLVwI2hH+XopXe1AlR234U0wx2BDb85MVhaKaYh3eGF+SrxuuhK6bgqMOosqHW83EL3fLA6Qbw==
X-Gm-Message-State: AOJu0YyamjAXebPzE2qBgfEo3VYgKtoW+sntmltsOxvOORaesBx1997Y
 AR7T/phnpo/IFz6M9H/uOVoeJDdp420YzpWGtNkfBKfkSKCCKh/UAUW63mvEVqk=
X-Google-Smtp-Source: AGHT+IHlYpzIlDMGkjsXpBmwy54fKbxAjEcZpW0ps/eQ1oKqXuutmLnv+5hSfpnP+tHftbTKjydfVQ==
X-Received: by 2002:a05:6512:45b:b0:517:10d0:5a30 with SMTP id
 y27-20020a056512045b00b0051710d05a30mr2087156lfk.32.1712771612917; 
 Wed, 10 Apr 2024 10:53:32 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::4716])
 by smtp.gmail.com with ESMTPSA id
 w1-20020a056402128100b0056e2b351956sm6543599edv.22.2024.04.10.10.53.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Apr 2024 10:53:32 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 10 Apr 2024 19:52:37 +0200
Subject: [PATCH v2 2/4] pinctrl: qcom: add sm6115 pinctrl driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-b4-qcom-rbx-soc-v2-2-5120a9c7f6ce@linaro.org>
References: <20240410-b4-qcom-rbx-soc-v2-0-5120a9c7f6ce@linaro.org>
In-Reply-To: <20240410-b4-qcom-rbx-soc-v2-0-5120a9c7f6ce@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5749;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=11Ev4gnfFwyfYbdYZyDyGXoMBJDq/0ytW2uBh5a7gNA=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmFtIZcktuPbIYUThf9JbUepuHtiUpirNVwHFo1
 +CiHgV7p0SJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZhbSGQAKCRAFgzErGV9k
 th1XD/4seCgE1vHUoffHs/nRs7uYUD2s9q4hfgG3Utuv5kP5iCIhTYTRIJVArCKYi2DZdLdBh7M
 z0BWL36RQObzLpLUk5dZ+YQd0wT3N4rnvbGtYkemvKpqbwA/zm8sDqsF1npMhvZLXA4P1SC5Kr+
 LE+M/baJxGXkUyxZZNLKgQboIGppYDvq6uUSpS/MlcpPawAVwG6GtpjiBQd+JFWamjlTLs6hIYk
 dUDABBDxwP+ZCORJgCmYYJXK/vbzYw7gm2pwtgxmpGo9TJhKDsO7j3GUa30GFFO2klnA1zLfjCk
 GeE0zxAxrz/isH75eFlK3xkg25VAbRJcy6zK6X9rH8P1XSFoM+WsSIZ0ddaU4BWQigFPZiuVxZO
 XoUUT0ySt6oe+bhFi6pGaj5ujEfGCzDIqQnJWAvdB0jCw2PsAMgAQAcnAyxeaxrcxQ/kvyrs+XW
 g6/IiTw8BFknmSxlXetvWBOGKc/kszt3duYhSMF4kk0/nnftpI4DpXGwvFqfhwguDr4HJy5hkaC
 3xFQ5J6/b+AtfHg4ydClriIDqvYgRDrEMCt/gy9kgJQAbSPqoyxs3uh6MNnuYtcu8zkAUt5mgAy
 cxvv6Arr83v2VhYraQomKnra4AJcPQ7gv/ygHLhocFD53HjhKYHNNPHfMxlRSUzCGRdumrOBgQp
 vtE+MUvSfMlaI4A==
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

This SoC features a pinctrl block with west, east, and south tiles.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/pinctrl/qcom/Kconfig          |   7 ++
 drivers/pinctrl/qcom/Makefile         |   1 +
 drivers/pinctrl/qcom/pinctrl-sm6115.c | 200 ++++++++++++++++++++++++++++++++++
 3 files changed, 208 insertions(+)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 35140efd5b62..e7a9853ce47a 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -47,7 +47,14 @@ config PINCTRL_QCOM_SDM845
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon 845 SoC,
 	  as well as the associated GPIO driver.
 
+config PINCTRL_QCOM_SM6115
+	bool "Qualcomm SM6115 GCC"
+	select PINCTRL_QCOM
+	help
+	  Say Y here to enable support for pinctrl on the Snapdragon SM6115 SoC,
+	  as well as the associated GPIO driver.
+
 endmenu
 
 endif
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
index 0b1d610ea3e8..f00c4e6e10cc 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -8,4 +8,5 @@ obj-$(CONFIG_PINCTRL_QCOM_IPQ4019) += pinctrl-ipq4019.o
 obj-$(CONFIG_PINCTRL_QCOM_APQ8096) += pinctrl-apq8096.o
 obj-$(CONFIG_PINCTRL_QCOM_QCM2290) += pinctrl-qcm2290.o
 obj-$(CONFIG_PINCTRL_QCOM_QCS404) += pinctrl-qcs404.o
 obj-$(CONFIG_PINCTRL_QCOM_SDM845) += pinctrl-sdm845.o
+obj-$(CONFIG_PINCTRL_QCOM_SM6115) += pinctrl-sm6115.o
diff --git a/drivers/pinctrl/qcom/pinctrl-sm6115.c b/drivers/pinctrl/qcom/pinctrl-sm6115.c
new file mode 100644
index 000000000000..f07f39f4ac30
--- /dev/null
+++ b/drivers/pinctrl/qcom/pinctrl-sm6115.c
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Qualcomm sm6115 pinctrl
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
+#define EAST 0x00800000
+
+#define MAX_PIN_NAME_LEN 32
+static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
+
+static const struct pinctrl_function msm_pinctrl_functions[] = {
+	{ "qup4", 1 },
+	{ "gpio", 0 },
+};
+
+static const unsigned int sm6115_pin_offsets[] = {
+	[0] = WEST,
+	[1] = WEST,
+	[2] = WEST,
+	[3] = WEST,
+	[4] = WEST,
+	[5] = WEST,
+	[6] = WEST,
+	[7] = WEST,
+	[8] = EAST,
+	[9] = EAST,
+	[10] = EAST,
+	[11] = EAST,
+	[12] = WEST,
+	[13] = WEST,
+	[14] = WEST,
+	[15] = WEST,
+	[16] = WEST,
+	[17] = WEST,
+	[18] = EAST,
+	[19] = EAST,
+	[20] = EAST,
+	[21] = EAST,
+	[22] = EAST,
+	[23] = EAST,
+	[24] = EAST,
+	[25] = EAST,
+	[26] = EAST,
+	[27] = EAST,
+	[28] = EAST,
+	[29] = EAST,
+	[30] = EAST,
+	[31] = EAST,
+	[32] = EAST,
+	[33] = EAST,
+	[34] = EAST,
+	[35] = EAST,
+	[36] = EAST,
+	[37] = EAST,
+	[38] = EAST,
+	[39] = EAST,
+	[40] = EAST,
+	[41] = EAST,
+	[42] = EAST,
+	[43] = EAST,
+	[44] = EAST,
+	[45] = EAST,
+	[46] = EAST,
+	[47] = EAST,
+	[48] = EAST,
+	[49] = EAST,
+	[50] = EAST,
+	[51] = EAST,
+	[52] = EAST,
+	[53] = EAST,
+	[54] = EAST,
+	[55] = EAST,
+	[56] = EAST,
+	[57] = EAST,
+	[58] = EAST,
+	[59] = EAST,
+	[60] = EAST,
+	[61] = EAST,
+	[62] = EAST,
+	[63] = EAST,
+	[64] = EAST,
+	[65] = WEST,
+	[66] = WEST,
+	[67] = WEST,
+	[68] = WEST,
+	[69] = WEST,
+	[70] = WEST,
+	[71] = WEST,
+	[72] = SOUTH,
+	[73] = SOUTH,
+	[74] = SOUTH,
+	[75] = SOUTH,
+	[76] = SOUTH,
+	[77] = SOUTH,
+	[78] = SOUTH,
+	[79] = SOUTH,
+	[80] = WEST,
+	[81] = WEST,
+	[82] = WEST,
+	[83] = WEST,
+	[84] = WEST,
+	[85] = WEST,
+	[86] = WEST,
+	[87] = EAST,
+	[88] = EAST,
+	[89] = WEST,
+	[90] = EAST,
+	[91] = EAST,
+	[92] = WEST,
+	[93] = WEST,
+	[94] = WEST,
+	[95] = WEST,
+	[96] = WEST,
+	[97] = WEST,
+	[98] = SOUTH,
+	[99] = SOUTH,
+	[100] = SOUTH,
+	[101] = SOUTH,
+	[102] = SOUTH,
+	[103] = SOUTH,
+	[104] = SOUTH,
+	[105] = SOUTH,
+	[106] = SOUTH,
+	[107] = SOUTH,
+	[108] = SOUTH,
+	[109] = SOUTH,
+	[110] = SOUTH,
+	[111] = SOUTH,
+	[112] = SOUTH,
+	/* Special pins */
+	[113] = 0,
+	[114] = 0,
+	[115] = 0,
+	[116] = 0,
+	[117] = 0,
+	[118] = 0,
+	[119] = 0,
+	[120] = 0,
+};
+
+static const char *sm6115_get_function_name(struct udevice *dev, unsigned int selector)
+{
+	return msm_pinctrl_functions[selector].name;
+}
+
+static const char *sm6115_get_pin_name(struct udevice *dev, unsigned int selector)
+{
+	static const char *special_pins_names[] = {
+		"ufs_reset", "sdc1_rclk", "sdc1_clk", "sdc1_cmd",
+		"sdc1_data", "sdc2_clk",  "sdc2_cmd", "sdc2_data",
+	};
+
+	if (selector >= 113 && selector <= 120)
+		snprintf(pin_name, MAX_PIN_NAME_LEN, special_pins_names[selector - 113]);
+	else
+		snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
+
+	return pin_name;
+}
+
+static unsigned int sm6115_get_function_mux(__maybe_unused unsigned int pin, unsigned int selector)
+{
+	return msm_pinctrl_functions[selector].val;
+}
+
+struct msm_pinctrl_data sm6115_data = {
+	.pin_data = {
+		.pin_offsets = sm6115_pin_offsets,
+		.pin_count = ARRAY_SIZE(sm6115_pin_offsets),
+		.special_pins_start = 113,
+	},
+	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
+	.get_function_name = sm6115_get_function_name,
+	.get_function_mux = sm6115_get_function_mux,
+	.get_pin_name = sm6115_get_pin_name,
+};
+
+static const struct udevice_id msm_pinctrl_ids[] = {
+	{
+		.compatible = "qcom,sm6115-tlmm",
+		.data = (ulong)&sm6115_data
+	},
+	{ /* Sentinel */ } };
+
+U_BOOT_DRIVER(pinctrl_sm6115) = {
+	.name = "pinctrl_sm6115",
+	.id = UCLASS_NOP,
+	.of_match = msm_pinctrl_ids,
+	.ops = &msm_pinctrl_ops,
+	.bind = msm_pinctrl_bind,
+};

-- 
2.44.0

