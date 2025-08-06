Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFAB2C87FCB
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 22:28:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E496B83B22;
	Thu,  7 Aug 2025 00:27:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="X5A2AJJ/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0782B83457; Thu,  7 Aug 2025 00:27:36 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B76883AF6
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 00:27:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-30b6bd0a352so358069fac.1
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 15:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754519235; x=1755124035; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OcGFEdiY5kHNfMXPa5mJXB4ejgcsS2ALH23sQLOlC2Q=;
 b=X5A2AJJ/0GkW7LFqlwEahyAHzhBJXDyqRRPpgk6mMj2uaQzrv7MqlyZ8vYuyPx3x58
 LiU87l+03GYOy400s18PXqGP68+FoLH0YDpNihD6Rek6QXIBY++j5KSyRIIC8fj9Tz4+
 D5fDasFG1tQ1IsnqUhmAP5jXbF5ZgRcJ/Y3CbnwJHrbUUt+71x5Ir+NjR0cuEoTj3dUt
 xiVKheBSTN2pwK0iJjz0Gy8cmGsjpwhwY41sCo8VcLOfMa0gCzmL2URVppyRj+gCdp0f
 wPS7j4j6llXVoNUqKtqQZCyiCif5+QHzbNhUuc3OBaEr+tTYzXPc53UkYjcIeG9O8M5z
 H3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754519235; x=1755124035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OcGFEdiY5kHNfMXPa5mJXB4ejgcsS2ALH23sQLOlC2Q=;
 b=qAN2JiwcCQ7sB0ricHfRBZFQB7+DuEPMNoACGPfeoRGPGljqTFskI4pw5zr7l+1qzp
 fANVIQmefLGc5URG7Cr2Okx1gDtSf3h2Hc5HW0/62iUch8FXMP8TUpMZYEv+69f6pj9G
 cG5VaR7UhvdlAr+gXm34CqC//M22yMYeP384NlelpP4YZFOIVuutOXl6qXdBOlfqjoyd
 B2tkpPFKZ0bdD24gmnyXCwnujBXuKtnxm+bb8HbhomYa17QKCmBgFLnNsFCgnU67hE0F
 1aiiEFQkRVady0BHNiLLLi9eI0sYzwz9F0A/mont7HiR3FxOowcf2N1ce9XNibwM/NaQ
 qgVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUK30nJZNLaij6g5IL6ECK788ACFQb7c+qTSM0jParbFBXM42FimZ8v1iS2iCP2fT0UXe02/xA=@lists.denx.de
X-Gm-Message-State: AOJu0YwkXQV8VnpHIIBSzSOWbCTM7re6cgY2q7oG3BOFrQFiA6y7CEY9
 Vr2BXK4Cm7RYWlnFvoWxdWZIR3L7LGaGssifs9FpRbNUIfFFMKagigOllkTedtz7v1o=
X-Gm-Gg: ASbGncs19ykom75rMSo+lgXRtia/Z721d7ScLmqE/TqkLhKpF5k/8nTIEry+u7GwJB5
 ifaPOBE1z/bCz8C8/otQ84gl18/woL5NEux5/03tZHfZSusGf+roKLXdch6oGNCdRV7Or4+9C4n
 zsZcc1Jz4Rdm64mQ6E4pRY/bnyTFUZUsdOdfnt2j/270ZSQLHu25NKgKet0+/+dxCdz+4qf25/2
 RA3CwrgWb6v7jyIT0tII4RJrG5BSoI8XaZlsqhEGDnR38e7SQI1GrVAt8Kk3FB/PkU1DgW0hV8F
 ihmCJF5zg9IgdlqKEYNfT9za3VaJruk5BP/TPxEmHdcKbQJR9V6B0GTlv7n3t42tG3yCxHQiMGg
 g1ZRDXNAcuxYJbDWBY0/H4v5/ng==
X-Google-Smtp-Source: AGHT+IFaPpE6nU5L/SCzgqVwso+Bo/7/OwpaiznS5yS9ulobNzzB4AEyDd19EQ/IfvHa5/Wocfsf5g==
X-Received: by 2002:a05:6870:9d88:b0:301:2bc7:61e7 with SMTP id
 586e51a60fabf-30be2bf8b48mr3439977fac.26.1754519235088; 
 Wed, 06 Aug 2025 15:27:15 -0700 (PDT)
Received: from localhost ([136.49.61.16]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7418bee2201sm3449108a34.18.2025.08.06.15.27.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 15:27:14 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: Minkyu Kang <promsoft@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH 04/10] board: samsung: e850-96: Add PMIC code
Date: Wed,  6 Aug 2025 17:27:04 -0500
Message-Id: <20250806222710.23773-5-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250806222710.23773-1-semen.protsenko@linaro.org>
References: <20250806222710.23773-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add functions for configuring voltage regulators on S2MPU12 PMIC chip
for E850-96 board. The chip is accessed by commanding APM core (via
ACPM IPC protocol) to perform corresponding transfers over I3C bus.

The most important regulator being set up is LDO24 used for LAN9514 chip
power. As LAN9514 implements USB hub and Ethernet controller
functionality, it's crucial to enable and configure LDO24 to be able to
use it further. While at it, configure the rest of regulators that might
be needed later, both in the bootloader and in kernel.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 board/samsung/e850-96/Makefile |   2 +-
 board/samsung/e850-96/pmic.c   | 144 +++++++++++++++++++++++++++++++++
 board/samsung/e850-96/pmic.h   |  14 ++++
 3 files changed, 159 insertions(+), 1 deletion(-)
 create mode 100644 board/samsung/e850-96/pmic.c
 create mode 100644 board/samsung/e850-96/pmic.h

diff --git a/board/samsung/e850-96/Makefile b/board/samsung/e850-96/Makefile
index 08eb8dca5bf7..76b8d47994e8 100644
--- a/board/samsung/e850-96/Makefile
+++ b/board/samsung/e850-96/Makefile
@@ -3,4 +3,4 @@
 # Copyright (C) 2024, Linaro Limited
 # Sam Protsenko <semen.protsenko@linaro.org>
 
-obj-y := e850-96.o fw.o acpm.o
+obj-y := e850-96.o fw.o acpm.o pmic.o
diff --git a/board/samsung/e850-96/pmic.c b/board/samsung/e850-96/pmic.c
new file mode 100644
index 000000000000..037fd4844c54
--- /dev/null
+++ b/board/samsung/e850-96/pmic.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2025 Linaro Ltd.
+ * Author: Sam Protsenko <semen.protsenko@linaro.org>
+ *
+ * This file contains functions for S2MPU12 PMIC regulators configuration.
+ *
+ * Example of voltage calculation for LDO24 and LDO32:
+ *   - V_min = 1800 mV
+ *   - V_step = 25 mV
+ *   - V_wanted = 3300 mV
+ *   - register value: (V_wanted - V_min) / V_step = 60 = 0x3c
+ *
+ * NOTE: 0x3c value might mean different voltage for other LDOs.
+ */
+
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include "pmic.h"
+
+/* PMIC definitions */
+#define S2MPU12_CHANNEL			0	/* I3C bus number of PMIC */
+#define S2MPU12_PM_ADDR			0x1	/* I3C slave addr of PM part */
+
+/* PMIC I3C registers */
+#define S2MPU12_PM_LDO1_CTRL		0x2b
+#define S2MPU12_PM_LDO_CTRL(n)		(S2MPU12_PM_LDO1_CTRL + (n) - 1)
+
+/* LDOx_CTRL values */
+#define S2MPU12_LDO_CTRL_OUT_MASK	(0x3 << 6)
+#define S2MPU12_LDO_CTRL_OUT_ALWAYS_ON	(0x3 << 6)
+
+struct pmic_ldo {
+	u8 num;	/* LDO number */
+	u8 en;	/* "enable" bits value in LDOx_CTRL register */
+	u8 out;	/* "output voltage" bits value in LDOx_CTRL register */
+};
+
+/* List of LDOs to enable only */
+static u8 pmic_ldos_en[] = {
+	2,	/* 1.8V/450mA:	multiple lines */
+	11,	/* 3.0V/150mA:	AVDD33_USB20 */
+	23,	/* 2.85V/800mA:	VDD_EMMC_2P85 */
+	27,	/* 3.0V/150mA:	MIPI_SWITCH_3V3 */
+	28,	/* 1.8V/150mA:	HDMI_CONV_1V8 */
+	30,	/* 1.8V/150mA:	NPU_VDD18 */
+};
+
+/* List of LDOs to enable and set output voltage */
+static struct pmic_ldo pmic_ldos_en_out[] = {
+	{
+		.num	= 24, /* 3.0V/800mA:	VDD_LAN (LAN9514) */
+		.en	= S2MPU12_LDO_CTRL_OUT_ALWAYS_ON,
+		.out	= 0x3c, /* means 3.3V for LDO24 */
+	}, {
+		.num	= 32, /* 3.3V/300mA:	CAM_VDD (RPi camera module) */
+		.en	= S2MPU12_LDO_CTRL_OUT_ALWAYS_ON,
+		.out	= 0x3c, /* means 3.3V for LDO32 */
+	},
+};
+
+/* Enable specified LDO */
+static int pmic_ldo_set_en(struct acpm *acpm, u8 ldo)
+{
+	const u8 reg = S2MPU12_PM_LDO_CTRL(ldo);
+	u8 val;
+	int err;
+
+	err = acpm_i3c_read(acpm, S2MPU12_CHANNEL, S2MPU12_PM_ADDR, reg, &val);
+	if (err)
+		return err;
+
+	val &= ~S2MPU12_LDO_CTRL_OUT_MASK;
+	val |= S2MPU12_LDO_CTRL_OUT_ALWAYS_ON;
+
+	return acpm_i3c_write(acpm, S2MPU12_CHANNEL, S2MPU12_PM_ADDR, reg, val);
+}
+
+/* Enable specified LDO and set its voltage to 0xc0 value */
+static int pmic_ldo_set_en_out(struct acpm *acpm, struct pmic_ldo *ldo)
+{
+	const u8 reg = S2MPU12_PM_LDO_CTRL(ldo->num);
+	const u8 val = ldo->en | ldo->out;
+
+	return acpm_i3c_write(acpm, S2MPU12_CHANNEL, S2MPU12_PM_ADDR, reg, val);
+}
+
+#ifdef DEBUG
+static void pmic_trace_ldo(struct acpm *acpm, u8 ldo)
+{
+	const u8 reg = S2MPU12_PM_LDO_CTRL(ldo);
+	u8 val;
+	int err;
+
+	err = acpm_i3c_read(acpm, S2MPU12_CHANNEL, S2MPU12_PM_ADDR, reg, &val);
+	if (err)
+		printf("  S2MPU12_PM_LDO%u_CTRL: Read error!\n", ldo);
+	else
+		printf("  S2MPU12_PM_LDO%u_CTRL: 0x%x\n", ldo, val);
+}
+
+static void pmic_trace_ldos(struct acpm *acpm)
+{
+	size_t i;
+
+	printf("Tracing LDOs...\n");
+	for (i = 0; i < ARRAY_SIZE(pmic_ldos_en); ++i)
+		pmic_trace_ldo(acpm, pmic_ldos_en[i]);
+	for (i = 0; i < ARRAY_SIZE(pmic_ldos_en_out); ++i)
+		pmic_trace_ldo(acpm, pmic_ldos_en_out[i].num);
+}
+#endif
+
+/**
+ * pmic_init() - Enable power regulators in S2MPU12 PMIC.
+ * @acpm: Data for I3C communication with PMIC over ACPM protocol
+ *
+ * Enable LDOs needed for devices used in the bootloader and kernel.
+ *
+ * Return: 0 on success or non-zero code on error.
+ */
+int pmic_init(struct acpm *acpm)
+{
+	size_t i;
+	int err;
+
+	for (i = 0; i < ARRAY_SIZE(pmic_ldos_en); ++i) {
+		err = pmic_ldo_set_en(acpm, pmic_ldos_en[i]);
+		if (err)
+			return -EIO;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(pmic_ldos_en_out); ++i) {
+		err = pmic_ldo_set_en_out(acpm, &pmic_ldos_en_out[i]);
+		if (err)
+			return -EIO;
+	}
+
+#ifdef DEBUG
+	pmic_trace_ldos(acpm);
+#endif
+
+	return 0;
+}
diff --git a/board/samsung/e850-96/pmic.h b/board/samsung/e850-96/pmic.h
new file mode 100644
index 000000000000..46624c2ebd46
--- /dev/null
+++ b/board/samsung/e850-96/pmic.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2025 Linaro Ltd.
+ * Sam Protsenko <semen.protsenko@linaro.org>
+ */
+
+#ifndef __E850_96_PMIC_H
+#define __E850_96_PMIC_H
+
+#include "acpm.h"
+
+int pmic_init(struct acpm *acpm);
+
+#endif /* __E850_96_PMIC_H */
-- 
2.39.5

