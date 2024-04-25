Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2918C4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 00:06:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56D0B88727;
	Thu, 25 Apr 2024 02:06:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="XtBXBF8q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A2BB8869A; Thu, 25 Apr 2024 02:06:13 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02E128872A
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 02:06:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=greg.malysa@timesys.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-61ac45807cbso4520577b3.1
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 17:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1714003568; x=1714608368;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lK7+HXgZAY8A1uOn5CUAh80GUURLUwWHjlaI1meDwCM=;
 b=XtBXBF8qNivmrVPTsqN3euEwIO3TKCGLxOx9FetRX1tYpY1weZsPIwQBZ8cxI2tzOU
 CS4TFq7ElJYXMtpsEe5Ju7W+XU2320T563AjVt+B+AAp8HivZZoJ3mBxEIBJXc5MewWk
 u31r5A9/JKCTgDMXWH2UFo472pIK9Kb0OkIRNtH1MnxBn8TrncKuRFOB2cxZT9jrEw0/
 3zKpt/84pHaI+wzuZpTNiaZ0/UgjlbyShZD7QoFiEi+Ru2JkTgob7jS5mxZTxy+iyy7P
 E/MZRoXKbr4/kqvmiWTG7CEoJsEflRqquETc03heASYBoUzQ6NYQRL5lJFeQX6n/NxWz
 HGgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714003568; x=1714608368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lK7+HXgZAY8A1uOn5CUAh80GUURLUwWHjlaI1meDwCM=;
 b=INW9tc0vbu4jk63Ew6Mr/8OWQ9hHdJmzSv4CS6NLCFiEATvjWruo7KxR7UEwQx0+YW
 uq7aAnyjjDMDWhhnq9qP8woloksB6zS9hQN8VhYstmmyRxm1UXTSIHUvo8zf5t5zozg+
 oxtwnXA4ajTHsGw3OEQGaE7Ea7N+Tm1fYpnbIfhgi0rhep8kirpUzVcGLESMVchkaEmR
 bnoUTUk09h+jmbE4JYtzHT+izL7tQor9rVi/476/rEY5uei2mFmm+GcjM9pCjeIdMKGY
 99cvktOrDmVNBeQb6gbvV33K8ndJ6RoERYWFJft1PqmBGeNMRBgPrpJFVgBjaPjwJ9Jl
 q1QA==
X-Gm-Message-State: AOJu0Yyws/6+P5i/4noUgxXnPIiBZSXnTx1Vv9KU4TUZOmgdh7LKHTTl
 HX/xFHd1Rlc4TGGOVq4UDbD7Kxux0S3zFB4qFvClOU/+W7stfsZPoFWn22gfdxE2bzggwLaMNnA
 3vQ==
X-Google-Smtp-Source: AGHT+IHonIb3ofRw9XSHxqqlBgv5yVPYLzDYbCpmY1iWhdWPJSEXzqdqbLSG/K/Rm/SISyZ6WcCDAw==
X-Received: by 2002:a05:690c:8:b0:61b:1a4f:158b with SMTP id
 bc8-20020a05690c000800b0061b1a4f158bmr4810499ywb.6.1714003567763; 
 Wed, 24 Apr 2024 17:06:07 -0700 (PDT)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 t201-20020a8183d2000000b0061870c6e41csm3291753ywf.6.2024.04.24.17.06.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 17:06:06 -0700 (PDT)
From: Greg Malysa <greg.malysa@timesys.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Matthew McClintock <Matthew.Mcclintock@analog.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Angelo Dureghello <angelo.dureghello@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Bin Meng <bmeng@tinylab.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kuan Lim Lee <kuanlim.lee@starfivetech.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rick Chen <rick@andestech.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Samuel Holland <samuel@sholland.org>, Simon Glass <sjg@chromium.org>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>
Subject: [PATCH v2 4/4] drivers: timer: Add in driver support for ADI
 SC5XX-family GP timer peripheral
Date: Wed, 24 Apr 2024 20:04:03 -0400
Message-ID: <20240425000515.21896-5-greg.malysa@timesys.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240425000515.21896-1-greg.malysa@timesys.com>
References: <20240425000515.21896-1-greg.malysa@timesys.com>
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

Co-developed-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Co-developed-by: Angelo Dureghello <angelo.dureghello@timesys.com>
Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
Co-developed-by: Ian Roberts <ian.roberts@timesys.com>
Signed-off-by: Ian Roberts <ian.roberts@timesys.com>
Signed-off-by: Greg Malysa <greg.malysa@timesys.com>

---

Changes in v2:
- Added gptimer driver to this series because a minimal system can't
  boot without it


---
 MAINTAINERS                     |   1 +
 drivers/timer/Kconfig           |   8 ++
 drivers/timer/Makefile          |   1 +
 drivers/timer/adi_sc5xx_timer.c | 145 ++++++++++++++++++++++++++++++++
 4 files changed, 155 insertions(+)
 create mode 100644 drivers/timer/adi_sc5xx_timer.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 74310c8f9d..eddd4f2c23 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -611,6 +611,7 @@ F:	arch/arm/include/asm/arch-adi/
 F:	arch/arm/mach-sc5xx/
 F:	drivers/clk/adi/
 F:	drivers/serial/serial_adi_uart4.c
+F:	drivers/timer/adi_sc5xx_timer.c
 F:	include/env/adi/
 
 ARM SNAPDRAGON
diff --git a/drivers/timer/Kconfig b/drivers/timer/Kconfig
index 60519c3b53..6b1de82ae3 100644
--- a/drivers/timer/Kconfig
+++ b/drivers/timer/Kconfig
@@ -50,6 +50,14 @@ config TIMER_EARLY
 	  use an early timer. These functions must be supported by your timer
 	  driver: timer_early_get_count() and timer_early_get_rate().
 
+config ADI_SC5XX_TIMER
+	bool "ADI ADSP-SC5xx Timer Support"
+	depends on TIMER && (SC57X || SC58X || SC59X || SC59X_64)
+	help
+	  gptimer based timer support on ADI's ADSP-SC5xx platforms. Available
+	  but not required on sc59x-64-based platforms (598 and similar).
+	  Required on 32-bit platforms (sc57x, sc58x, sc594 and earlier).
+
 config ALTERA_TIMER
 	bool "Altera timer support"
 	depends on TIMER
diff --git a/drivers/timer/Makefile b/drivers/timer/Makefile
index b93145e8d4..fb95c8899e 100644
--- a/drivers/timer/Makefile
+++ b/drivers/timer/Makefile
@@ -3,6 +3,7 @@
 # Copyright (C) 2015 Thomas Chou <thomas@wytron.com.tw>
 
 obj-y += timer-uclass.o
+obj-$(CONFIG_ADI_SC5XX_TIMER) += adi_sc5xx_timer.o
 obj-$(CONFIG_ALTERA_TIMER)	+= altera_timer.o
 obj-$(CONFIG_$(SPL_)ANDES_PLMT_TIMER) += andes_plmt_timer.o
 obj-$(CONFIG_ARC_TIMER)	+= arc_timer.o
diff --git a/drivers/timer/adi_sc5xx_timer.c b/drivers/timer/adi_sc5xx_timer.c
new file mode 100644
index 0000000000..11c098434a
--- /dev/null
+++ b/drivers/timer/adi_sc5xx_timer.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2022 - Analog Devices, Inc.
+ *
+ * Written and/or maintained by Timesys Corporation
+ *
+ * Converted to driver model by Nathan Barrett-Morrison
+ *
+ * Author: Greg Malysa <greg.malysa@timesys.com>
+ * Additional Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
+ *
+ * dm timer implementation for ADI ADSP-SC5xx SoCs
+ *
+ */
+
+#include <clk.h>
+#include <dm.h>
+#include <timer.h>
+#include <asm/io.h>
+#include <dm/device_compat.h>
+#include <linux/compiler_types.h>
+
+/*
+ * Timer Configuration Register Bits
+ */
+#define TIMER_OUT_DIS       0x0800
+#define TIMER_PULSE_HI      0x0080
+#define TIMER_MODE_PWM_CONT 0x000c
+
+#define __BFP(m) u16 m; u16 __pad_##m
+
+struct gptimer3 {
+	__BFP(config);
+	u32 counter;
+	u32 period;
+	u32 width;
+	u32 delay;
+};
+
+struct gptimer3_group_regs {
+	__BFP(run);
+	__BFP(enable);
+	__BFP(disable);
+	__BFP(stop_cfg);
+	__BFP(stop_cfg_set);
+	__BFP(stop_cfg_clr);
+	__BFP(data_imsk);
+	__BFP(stat_imsk);
+	__BFP(tr_msk);
+	__BFP(tr_ie);
+	__BFP(data_ilat);
+	__BFP(stat_ilat);
+	__BFP(err_status);
+	__BFP(bcast_per);
+	__BFP(bcast_wid);
+	__BFP(bcast_dly);
+};
+
+#define MAX_TIM_LOAD	0xFFFFFFFF
+
+struct adi_gptimer_priv {
+	struct gptimer3_group_regs __iomem *timer_group;
+	struct gptimer3 __iomem *timer_base;
+	u32 prev;
+	u64 upper;
+};
+
+static u64 adi_gptimer_get_count(struct udevice *udev)
+{
+	struct adi_gptimer_priv *priv = dev_get_priv(udev);
+
+	u32 now = readl(&priv->timer_base->counter);
+
+	if (now < priv->prev)
+		priv->upper += (1ull << 32);
+
+	priv->prev = now;
+
+	return (priv->upper + (u64)now);
+}
+
+static const struct timer_ops adi_gptimer_ops = {
+	.get_count = adi_gptimer_get_count,
+};
+
+static int adi_gptimer_probe(struct udevice *udev)
+{
+	struct timer_dev_priv *uc_priv = dev_get_uclass_priv(udev);
+	struct adi_gptimer_priv *priv = dev_get_priv(udev);
+	struct clk clk;
+	u16 imask;
+	int ret;
+
+	priv->timer_group = dev_remap_addr_index(udev, 0);
+	priv->timer_base = dev_remap_addr_index(udev, 1);
+	priv->upper = 0;
+	priv->prev = 0;
+
+	if (!priv->timer_group || !priv->timer_base) {
+		dev_err(udev, "Missing timer_group or timer_base reg entries\n");
+		return -ENODEV;
+	}
+
+	ret = clk_get_by_index(udev, 0, &clk);
+	if (ret < 0) {
+		dev_err(udev, "Missing clock reference for timer\n");
+		return ret;
+	}
+
+	ret = clk_enable(&clk);
+	if (ret) {
+		dev_err(udev, "Failed to enable clock\n");
+		return ret;
+	}
+
+	uc_priv->clock_rate = clk_get_rate(&clk);
+
+	/* Enable timer */
+	writew(TIMER_OUT_DIS | TIMER_MODE_PWM_CONT | TIMER_PULSE_HI,
+	       &priv->timer_base->config);
+	writel(MAX_TIM_LOAD, &priv->timer_base->period);
+	writel(MAX_TIM_LOAD - 1, &priv->timer_base->width);
+
+	/* We only use timer 0 in uboot */
+	imask = readw(&priv->timer_group->data_imsk);
+	imask &= ~(1 << 0);
+	writew(imask, &priv->timer_group->data_imsk);
+	writew((1 << 0), &priv->timer_group->enable);
+
+	return 0;
+}
+
+static const struct udevice_id adi_gptimer_ids[] = {
+	{ .compatible = "adi,sc5xx-gptimer" },
+	{ },
+};
+
+U_BOOT_DRIVER(adi_gptimer) = {
+	.name = "adi_gptimer",
+	.id = UCLASS_TIMER,
+	.of_match = adi_gptimer_ids,
+	.priv_auto = sizeof(struct adi_gptimer_priv),
+	.probe = adi_gptimer_probe,
+	.ops = &adi_gptimer_ops,
+};
-- 
2.43.2

