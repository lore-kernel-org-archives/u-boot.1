Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E39A4C4707B
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 03:11:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F41EF87B04;
	Thu, 11 Jan 2024 04:09:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pBwI2MVU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2E6787613; Thu, 11 Jan 2024 04:09:30 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 257FE87AC9
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 04:09:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-20451bc39b1so3073977fac.1
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 19:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704942560; x=1705547360; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MG4e0ucyozZyaMKAPmykBi+fgVMgXa+3BtZ/TcSt97o=;
 b=pBwI2MVUIs3jPVT+p3+Lbnm8poJxEthOnsCMmjTZpAMaSN0wBlcYJdOZdVHhRGH0GU
 3xpFDm8N+unc9vGMTALlE9469z3a5qqRdlzjMW3l1qtVfziqu6BEjFHWl1/vXvEZ4BvV
 tpyWFQH2CzqbTq49sZUhPJzohuzZhSZOCy7BO4TQK8ZpqX/chrJMBHiltJd0NFQqCr2C
 VU94L5wbxf+waBUOTNvcQHrJ+nIlnPqE0HcaUxaNWbj7Xql/BpL84aKLEvBSQyUTdx/6
 mivjNYMVZf2PRTycQsZq+bnDO+EiSqaIMoMGBCHWD2ToVc11asod1SVTHokm6c80WeGP
 K4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704942560; x=1705547360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MG4e0ucyozZyaMKAPmykBi+fgVMgXa+3BtZ/TcSt97o=;
 b=Ss/yC1myNIdNqO4lpAdHw/hIxD3HB6uNDnBg3l7pEcrkp/tUQLLrYyZcK/V39o5AlI
 yR8SMUsKJphQM/hSDvfgH0xnrk0+u1EJLfLbHp7qmqseDkfeFGhu6zI16KtmLF0fruil
 nQn8baec2gzwd+bBIbw2uGRcVGL3wyVoXLkqrwAewW5VxAi4uKrMJ9qbJGeRS/vmoDI3
 Muq43367pnFAuhi7lkWgN0ySE6ncuLgu2Qf2L/Hy3GMpOFwsAswEJFIt/H16zi/Woegb
 nsjzGGL551fL7T6sEFGW9VLkZXmI8jIdG/KxF+9jl6g77uw++IQMumK/VyOzao3KWVjf
 9OCQ==
X-Gm-Message-State: AOJu0YyqgY+UiNT/sBBP2bIcnS8SVlqxFiOU6Cr58pdQyhZwm9xwhQ7U
 ovay+C+Mf+j2U6yInrGzoJz49mabemWbrA==
X-Google-Smtp-Source: AGHT+IFKUpsGajSSDX9NFy0NSUC/kwiBcttx7q/yBKpvoxzY2Y25VB7W2sEcBzxvU1ra3tSctnS3xA==
X-Received: by 2002:a05:6871:7586:b0:204:5026:c9f5 with SMTP id
 nz6-20020a056871758600b002045026c9f5mr632816oac.91.1704942560267; 
 Wed, 10 Jan 2024 19:09:20 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 pk3-20020a0568704c0300b00206892f8a80sm4662oab.48.2024.01.10.19.09.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 19:09:19 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Chanho Park <chanho61.park@samsung.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Subject: [PATCH v2 09/13] pinctrl: exynos: Add pinctrl support for Exynos850
Date: Wed, 10 Jan 2024 21:09:05 -0600
Message-Id: <20240111030909.27373-10-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240111030909.27373-1-semen.protsenko@linaro.org>
References: <20240111030909.27373-1-semen.protsenko@linaro.org>
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

Add pinctrl support for Exynos850 SoC. It was mostly extracted from
corresponding Linux kernel code [1]. Power down modes and external
interrupt data were removed while converting the code for U-Boot, but
everything else was kept almost unchanged.

[1] drivers/pinctrl/samsung/pinctrl-exynos-arm64.c

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Chanho Park <chanho61.park@samsung.com>
---
Changes in v2:
  - Fixed driver description in the comment
  - Added R-b tag

 drivers/pinctrl/exynos/Kconfig             |   8 ++
 drivers/pinctrl/exynos/Makefile            |   1 +
 drivers/pinctrl/exynos/pinctrl-exynos850.c | 125 +++++++++++++++++++++
 3 files changed, 134 insertions(+)
 create mode 100644 drivers/pinctrl/exynos/pinctrl-exynos850.c

diff --git a/drivers/pinctrl/exynos/Kconfig b/drivers/pinctrl/exynos/Kconfig
index a60f49869b45..1b7fb62bc4ba 100644
--- a/drivers/pinctrl/exynos/Kconfig
+++ b/drivers/pinctrl/exynos/Kconfig
@@ -16,3 +16,11 @@ config PINCTRL_EXYNOS78x0
 	help
 	  Support pin multiplexing and pin configuration control on
 	  Samsung's Exynos78x0 SoC.
+
+config PINCTRL_EXYNOS850
+	bool "Samsung Exynos850 pinctrl driver"
+	depends on ARCH_EXYNOS && PINCTRL_FULL
+	select PINCTRL_EXYNOS
+	help
+	  Support pin multiplexing and pin configuration control on
+	  Samsung's Exynos850 SoC.
diff --git a/drivers/pinctrl/exynos/Makefile b/drivers/pinctrl/exynos/Makefile
index 07db970ca942..3abe1226eb74 100644
--- a/drivers/pinctrl/exynos/Makefile
+++ b/drivers/pinctrl/exynos/Makefile
@@ -6,3 +6,4 @@
 obj-$(CONFIG_PINCTRL_EXYNOS)		+= pinctrl-exynos.o
 obj-$(CONFIG_PINCTRL_EXYNOS7420)	+= pinctrl-exynos7420.o
 obj-$(CONFIG_PINCTRL_EXYNOS78x0)	+= pinctrl-exynos78x0.o
+obj-$(CONFIG_PINCTRL_EXYNOS850)		+= pinctrl-exynos850.o
diff --git a/drivers/pinctrl/exynos/pinctrl-exynos850.c b/drivers/pinctrl/exynos/pinctrl-exynos850.c
new file mode 100644
index 000000000000..3ec2636e0d87
--- /dev/null
+++ b/drivers/pinctrl/exynos/pinctrl-exynos850.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 Linaro Ltd.
+ * Author: Sam Protsenko <semen.protsenko@linaro.org>
+ *
+ * Exynos850 pinctrl driver.
+ */
+
+#include <dm.h>
+#include <dm/pinctrl.h>
+#include "pinctrl-exynos.h"
+
+#define EXYNOS850_PIN_BANK(pins, reg, id)		\
+	{						\
+		.type		= &exynos850_bank_type,	\
+		.offset		= reg,			\
+		.nr_pins	= pins,			\
+		.name		= id			\
+	}
+
+/* CON, DAT, PUD, DRV */
+static const struct samsung_pin_bank_type exynos850_bank_type = {
+	.fld_width = { 4, 1, 4, 4, },
+	.reg_offset = { 0x00, 0x04, 0x08, 0x0c, },
+};
+
+static const struct pinctrl_ops exynos850_pinctrl_ops = {
+	.set_state = exynos_pinctrl_set_state
+};
+
+/* pin banks of exynos850 pin-controller 0 (ALIVE) */
+static const struct samsung_pin_bank_data exynos850_pin_banks0[] = {
+	EXYNOS850_PIN_BANK(8, 0x000, "gpa0"),
+	EXYNOS850_PIN_BANK(8, 0x020, "gpa1"),
+	EXYNOS850_PIN_BANK(8, 0x040, "gpa2"),
+	EXYNOS850_PIN_BANK(8, 0x060, "gpa3"),
+	EXYNOS850_PIN_BANK(4, 0x080, "gpa4"),
+	EXYNOS850_PIN_BANK(3, 0x0a0, "gpq0"),
+};
+
+/* pin banks of exynos850 pin-controller 1 (CMGP) */
+static const struct samsung_pin_bank_data exynos850_pin_banks1[] = {
+	EXYNOS850_PIN_BANK(1, 0x000, "gpm0"),
+	EXYNOS850_PIN_BANK(1, 0x020, "gpm1"),
+	EXYNOS850_PIN_BANK(1, 0x040, "gpm2"),
+	EXYNOS850_PIN_BANK(1, 0x060, "gpm3"),
+	EXYNOS850_PIN_BANK(1, 0x080, "gpm4"),
+	EXYNOS850_PIN_BANK(1, 0x0a0, "gpm5"),
+	EXYNOS850_PIN_BANK(1, 0x0c0, "gpm6"),
+	EXYNOS850_PIN_BANK(1, 0x0e0, "gpm7"),
+};
+
+/* pin banks of exynos850 pin-controller 2 (AUD) */
+static const struct samsung_pin_bank_data exynos850_pin_banks2[] = {
+	EXYNOS850_PIN_BANK(5, 0x000, "gpb0"),
+	EXYNOS850_PIN_BANK(5, 0x020, "gpb1"),
+};
+
+/* pin banks of exynos850 pin-controller 3 (HSI) */
+static const struct samsung_pin_bank_data exynos850_pin_banks3[] = {
+	EXYNOS850_PIN_BANK(6, 0x000, "gpf2"),
+};
+
+/* pin banks of exynos850 pin-controller 4 (CORE) */
+static const struct samsung_pin_bank_data exynos850_pin_banks4[] = {
+	EXYNOS850_PIN_BANK(4, 0x000, "gpf0"),
+	EXYNOS850_PIN_BANK(8, 0x020, "gpf1"),
+};
+
+/* pin banks of exynos850 pin-controller 5 (PERI) */
+static const struct samsung_pin_bank_data exynos850_pin_banks5[] = {
+	EXYNOS850_PIN_BANK(2, 0x000, "gpg0"),
+	EXYNOS850_PIN_BANK(6, 0x020, "gpp0"),
+	EXYNOS850_PIN_BANK(4, 0x040, "gpp1"),
+	EXYNOS850_PIN_BANK(4, 0x060, "gpp2"),
+	EXYNOS850_PIN_BANK(8, 0x080, "gpg1"),
+	EXYNOS850_PIN_BANK(8, 0x0a0, "gpg2"),
+	EXYNOS850_PIN_BANK(1, 0x0c0, "gpg3"),
+	EXYNOS850_PIN_BANK(3, 0x0e0, "gpc0"),
+	EXYNOS850_PIN_BANK(6, 0x100, "gpc1"),
+};
+
+static const struct samsung_pin_ctrl exynos850_pin_ctrl[] = {
+	{
+		/* pin-controller instance 0 ALIVE data */
+		.pin_banks	= exynos850_pin_banks0,
+		.nr_banks	= ARRAY_SIZE(exynos850_pin_banks0),
+	}, {
+		/* pin-controller instance 1 CMGP data */
+		.pin_banks	= exynos850_pin_banks1,
+		.nr_banks	= ARRAY_SIZE(exynos850_pin_banks1),
+	}, {
+		/* pin-controller instance 2 AUD data */
+		.pin_banks	= exynos850_pin_banks2,
+		.nr_banks	= ARRAY_SIZE(exynos850_pin_banks2),
+	}, {
+		/* pin-controller instance 3 HSI data */
+		.pin_banks	= exynos850_pin_banks3,
+		.nr_banks	= ARRAY_SIZE(exynos850_pin_banks3),
+	}, {
+		/* pin-controller instance 4 CORE data */
+		.pin_banks	= exynos850_pin_banks4,
+		.nr_banks	= ARRAY_SIZE(exynos850_pin_banks4),
+	}, {
+		/* pin-controller instance 5 PERI data */
+		.pin_banks	= exynos850_pin_banks5,
+		.nr_banks	= ARRAY_SIZE(exynos850_pin_banks5),
+	},
+	{/* list terminator */}
+};
+
+static const struct udevice_id exynos850_pinctrl_ids[] = {
+	{ .compatible = "samsung,exynos850-pinctrl",
+		.data = (ulong)exynos850_pin_ctrl },
+	{ }
+};
+
+U_BOOT_DRIVER(pinctrl_exynos850) = {
+	.name		= "pinctrl_exynos850",
+	.id		= UCLASS_PINCTRL,
+	.of_match	= exynos850_pinctrl_ids,
+	.priv_auto	= sizeof(struct exynos_pinctrl_priv),
+	.ops		= &exynos850_pinctrl_ops,
+	.probe		= exynos_pinctrl_probe,
+};
-- 
2.39.2

