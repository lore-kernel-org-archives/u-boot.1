Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F690C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 03:18:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6FA5877D7;
	Wed, 13 Dec 2023 04:17:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Eg+80k+R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03B1587838; Wed, 13 Dec 2023 04:17:05 +0100 (CET)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DB2187808
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 04:16:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-20306782371so658644fac.1
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 19:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702437416; x=1703042216; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o1J6qIzTig9qb3eDgofK9oHcpHK5zeXCofzzH4dLRSQ=;
 b=Eg+80k+RaKBOevoUzvEhMZu8gUNvVu9Eq8Kc06b+oxqAgw22Z2bsnfHfLspQ+x1zn2
 rfKbNBgZyID6tE8gyuI61TYhx+qWeU/ueTEF4jYYzU0mflnHWdSZpFVAmh8YciVkcO6x
 cKAyiNT1UDiltCel7I6ITqICF+cCES8O30ZkuJZAr/asj38/D8BzRxCeteJq1xkFzgh9
 9lUQTn3gTiD9SjKEtqPjaSyBk6YXAbSVYIBtbVub8vIzNW1Zel83XJTC/9bQjfVCxBMP
 ni5dxO4nYl2VyoWup3e55SftWbAgjSzf+F+QtZan2iBpMSSxujKo95k5msWmvrfK7QPv
 Q87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702437416; x=1703042216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o1J6qIzTig9qb3eDgofK9oHcpHK5zeXCofzzH4dLRSQ=;
 b=Amlb5Ho9/naUBM/w2JbHZRCaLucBWh9BX+GsOi3RLTMD49tjgULV6UfMz7HxkU+0Lr
 AtPMJo7FArgMHulLenXDaACYgIm6cIM5sNHZufthq1nMiU6sj4IuSggDkYwCcbolcyAR
 iXe/hqW+Px6kwXcbn1RmKcYfpGmyFUM8gkGu0mo1Zk+Qyz4J6aXzFpEOnd97V0dHdopF
 N8f5aDrgdNoe0pbnXVVCTh9r2Pe1U+lFxboBwhWkh/QVp9Yhz9HlNjF1rktkS/Asj2O8
 hta7qEm9dWRVUnYCtwwTsBr6AzUksX2eQBYq6daEavPw8pvm9/guCXGmUXA1wGIVnqXY
 oKVQ==
X-Gm-Message-State: AOJu0Yyy1zu5B3t4jfI/mjbyfA+lKo2sUgRV35bA3DJNN5aAlkuhMUa1
 doe/ZrgsU8vE2jQTlpM8IixKBA==
X-Google-Smtp-Source: AGHT+IEwQxtVQA9e31afcm/TLg9XVrzxhLhRdfkynQgxdyrf/UiifueixwH9E+YPwGDxxnKgowkI8Q==
X-Received: by 2002:a05:6870:9a8f:b0:1fa:25d8:46a8 with SMTP id
 hp15-20020a0568709a8f00b001fa25d846a8mr9426412oab.32.1702437415860; 
 Tue, 12 Dec 2023 19:16:55 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 mp23-20020a056871329700b001fb634b546dsm3703709oac.14.2023.12.12.19.16.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Dec 2023 19:16:55 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 u-boot@lists.denx.de
Subject: [PATCH 09/13] pinctrl: exynos: Add pinctrl support for Exynos850
Date: Tue, 12 Dec 2023 21:16:42 -0600
Message-Id: <20231213031646.28828-10-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231213031646.28828-1-semen.protsenko@linaro.org>
References: <20231213031646.28828-1-semen.protsenko@linaro.org>
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
---
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
index 000000000000..2445dd752ea8
--- /dev/null
+++ b/drivers/pinctrl/exynos/pinctrl-exynos850.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 Linaro Ltd.
+ * Author: Sam Protsenko <semen.protsenko@linaro.org>
+ *
+ * Samsung Exynos USI driver (Universal Serial Interface).
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

