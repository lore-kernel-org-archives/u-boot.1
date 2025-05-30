Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 860B4C5B543
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 21:23:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6762E82C67;
	Fri, 30 May 2025 23:23:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Tu/ZTch6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 634F4833FC; Fri, 30 May 2025 23:23:12 +0200 (CEST)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 358A582C38
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 23:23:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sbellary@baylibre.com
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-b26f01c638fso2375051a12.1
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 14:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748640187; x=1749244987;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LuHjdtCCKQ3BArrf1gnTFbqkDLHEpKJjiueQ6M7XvjY=;
 b=Tu/ZTch6KdW6GaY9Iv8XGKgUYnzERdM6UUTSkiv9N2oYotE8da8IRy7gb5eoNn7YnY
 H1imYBO7JkLc2fHgWMqNT5logvpMCbkPbOq4apC3edqvhGNWFpS8EU/r7MM/lse5ZD+m
 qHO3wtdfFJvaMU32B1czTgt+WD7xG7GIBSU9hGCpIPYMxNXOBr9wdx+mXZdvXGeed2J1
 0iIkA+F3q0qZkh77JnxSQ9zH6rUZjX9lx93PZRn4Jp95FY5HKdxTVSU06aU1MWtokSe3
 DGP60tvcayZZUzeOVd0PlEC/u/+hE9UvEgWJkZEV8H96qCSBmv2/bZFTSDU89PnaO3Qd
 sTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748640187; x=1749244987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LuHjdtCCKQ3BArrf1gnTFbqkDLHEpKJjiueQ6M7XvjY=;
 b=Sv5Yg4wJpHN8A0f5jX8UgRh6zEDaZLacjZJNWnikvlThvnSkcag3RLYknqnSRxF273
 AIoTl5f+7Syo8dZeGTP/T/RTAA2ttmZHha+ixeJ2sgspFecVW6Jm1FD4H5ZBg+SLMzum
 dKhoE+VBh0VrG/fNgomc13jtg9VJKFqs7vshI+U1MrnmgOHUMbUoSlkowoyWEV4wvdPx
 6OP/XIHUlg9d3bkgzDp2ZBdh0/Km9RmErotGvtX4qSVDCyfM5cZ5b8CwkDpKopKkpq+d
 kSfG3u/kZeR87XS/Qeg//fNNqDZNxA4TYakmL9tY1GbB65cwWYYXx+KCI/pfzuuYRUAD
 QVFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWELRKxaFg1guqUh02taE70g6yNjbV39rBxoCrg7q2cRToe7HDHX0HQVHfjTbhsuLCrxLH5P9U=@lists.denx.de
X-Gm-Message-State: AOJu0YysRLcclz/C9Raac4DsVM6SNghQ4E02uabBu3sPand6yxmwuU/8
 1QoWre0rvKADjHr77JWXcYf9TFYXRD1vZaeNlCpDeTMwh8pxrBep7KP0Zg6Cao7RXeo=
X-Gm-Gg: ASbGnctQJ+vqotZpuPkjNHXWZWeDSlL8S+LxWJ16zzMGN9JJBGja1loxLJUSqZWE/+E
 ipMJiOSPdrRFMRCbyZiz1TOW3XYj7N/QJAwp9OyUqpAnp4s7fL7AVTH1s/nv/RmdreeKa9ii+qD
 3c06MPWKN6ugSOwEk4U8aHGnSnwx9LaK7wXAGYYrLJgWMc3xoniQ+KR4dH7TxfqbxcoqtMlfijh
 aO69Afm13L34i74v6X/v8jXDre1YgbmZSjqP0ddXvUeM+e/e7pbKnsJvm+Pv86kd3Ld2hTDBLVw
 0vdMU/ReQekRfLk04AdURjpz4xWRiMOCsZaS625+Sx4gm8QQWKGo/IUsjx/HHuVFtEMcKmUtFsO
 y2TJeTXwuOKdG9zuMoGRtn3av
X-Google-Smtp-Source: AGHT+IEit9C2wE3nK9no4F6nzrf1TCp9XHypdvxhw2D/oIyqKAqUpg3AYQFTulug4UIcOj/hkdnUUQ==
X-Received: by 2002:a05:6a20:d045:b0:216:1ea0:a51e with SMTP id
 adf61e73a8af0-21ad98f960fmr8163657637.41.1748640187580; 
 Fri, 30 May 2025 14:23:07 -0700 (PDT)
Received: from dev-linux.. (syn-076-088-115-008.res.spectrum.com.
 [76.88.115.8]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-747affadf7bsm3594039b3a.108.2025.05.30.14.23.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 14:23:07 -0700 (PDT)
From: Sukrut Bellary <sbellary@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: Sukrut Bellary <sbellary@baylibre.com>,
 Kevin Hilman <khilman@baylibre.com>, Bajjuri Praneeth <praneeth@ti.com>,
 Raghavendra Vignesh <vigneshr@ti.com>, u-boot@lists.denx.de
Subject: [PATCH v2 1/3] pwm: ti: am33xx: Enable Auxiliary PWM using eCAP
Date: Fri, 30 May 2025 14:22:30 -0700
Message-Id: <20250530212232.1686613-2-sbellary@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250530212232.1686613-1-sbellary@baylibre.com>
References: <20250530212232.1686613-1-sbellary@baylibre.com>
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

In am33xx SoC[1], enhanced capture (eCAP) supports auxiliary PWM (APWM).
This series adds the PWM driver support for the APWM feature for eCAP on
AM33xx.

eCAP HW also supports the capture mode. Currently, this driver only
supports APWM.

This is based on the Linux kernel driver -> drivers/pwm/pwm-tiecap.c
Version: v6.12

Tested on AM335x EVM[2].

[1] AM335x TRM - https://www.ti.com/lit/ug/spruh73q/spruh73q.pdf
[2] AM335x EVM - https://www.ti.com/tool/TMDXEVM3358

Signed-off-by: Sukrut Bellary <sbellary@baylibre.com>
---
 drivers/pwm/Kconfig      |   6 ++
 drivers/pwm/Makefile     |   1 +
 drivers/pwm/pwm-tiecap.c | 198 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 205 insertions(+)
 create mode 100644 drivers/pwm/pwm-tiecap.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index de3126567467..e4c676d75c2b 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -126,3 +126,9 @@ config PWM_TI_EHRPWM
 	default y
 	help
 	  PWM driver support for the EHRPWM controller found on TI SOCs.
+
+config PWM_TI_ECAP
+	bool "Enable support for ECAP PWM"
+	depends on DM_PWM && ARCH_OMAP2PLUS
+	help
+	  PWM driver support for the ECAP controller found on TI SOCs.
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 76305b93bc96..2682c536c6f3 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -25,3 +25,4 @@ obj-$(CONFIG_PWM_TEGRA)		+= tegra_pwm.o
 obj-$(CONFIG_PWM_STM32)		+= pwm-stm32.o
 obj-$(CONFIG_PWM_SUNXI)		+= sunxi_pwm.o
 obj-$(CONFIG_PWM_TI_EHRPWM)	+= pwm-ti-ehrpwm.o
+obj-$(CONFIG_PWM_TI_ECAP)	+= pwm-tiecap.o
diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
new file mode 100644
index 000000000000..cfd6c871b574
--- /dev/null
+++ b/drivers/pwm/pwm-tiecap.c
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * ECAP PWM driver
+ *
+ * Copyright (C) 2025 BayLibre, SAS
+ * Author: Sukrut Bellary <sbellary@baylibre.com>
+ */
+
+#include <clk.h>
+#include <div64.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <pwm.h>
+#include <asm/io.h>
+
+/* eCAP module registers */
+#define ECAP_PWM_CAP1			0x08
+#define ECAP_PWM_CAP2			0x0C
+#define ECAP_PWM_CAP3			0x10
+#define ECAP_PWM_CAP4			0x14
+
+#define ECAP_PWM_ECCTL2			0x2A
+#define ECAP_PWM_ECCTL2_APWM_POL_LOW	BIT(10)
+#define ECAP_PWM_ECCTL2_APWM_MODE	BIT(9)
+#define ECAP_PWM_ECCTL2_TSCTR_FREERUN	BIT(4)
+#define ECAP_PWM_ECCTL2_SYNC_SEL_DISA	(BIT(7) | BIT(6))
+
+#define NSEC_PER_SEC			1000000000L
+
+enum tiecap_pwm_polarity {
+	TIECAP_PWM_POLARITY_NORMAL,
+	TIECAP_PWM_POLARITY_INVERSED
+};
+
+enum tiecap_pwm_state {
+	TIECAP_APWM_DISABLED,
+	TIECAP_APWM_ENABLED
+};
+
+struct tiecap_pwm_priv {
+	fdt_addr_t regs;
+	u32 clk_rate;
+	enum tiecap_pwm_state pwm_state;
+};
+
+static int tiecap_pwm_set_config(struct udevice *dev, uint channel,
+				 uint period_ns, uint duty_ns)
+{
+	struct tiecap_pwm_priv *priv = dev_get_priv(dev);
+	u32 period_cycles, duty_cycles;
+	unsigned long long c;
+	u16 value;
+
+	c = priv->clk_rate;
+	c = c * period_ns;
+	do_div(c, NSEC_PER_SEC);
+	period_cycles = (u32)c;
+
+	if (period_cycles < 1) {
+		period_cycles = 1;
+		duty_cycles = 1;
+	} else {
+		c = priv->clk_rate;
+		c = c * duty_ns;
+		do_div(c, NSEC_PER_SEC);
+		duty_cycles = (u32)c;
+	}
+
+	value = readw(priv->regs + ECAP_PWM_ECCTL2);
+
+	/* Configure APWM mode & disable sync option */
+	value |= ECAP_PWM_ECCTL2_APWM_MODE | ECAP_PWM_ECCTL2_SYNC_SEL_DISA;
+
+	writew(value, priv->regs + ECAP_PWM_ECCTL2);
+
+	if (priv->pwm_state == TIECAP_APWM_DISABLED) {
+		/* Update active registers */
+		writel(duty_cycles, priv->regs + ECAP_PWM_CAP2);
+		writel(period_cycles, priv->regs + ECAP_PWM_CAP1);
+	} else {
+		/* Update shadow registers to configure period and
+		 * compare values. This helps current pwm period to
+		 * complete on reconfiguring.
+		 */
+		writel(duty_cycles, priv->regs + ECAP_PWM_CAP4);
+		writel(period_cycles, priv->regs + ECAP_PWM_CAP3);
+	}
+
+	return 0;
+}
+
+static int tiecap_pwm_set_enable(struct udevice *dev, uint channel, bool enable)
+{
+	struct tiecap_pwm_priv *priv = dev_get_priv(dev);
+	u16 value;
+
+	value = readw(priv->regs + ECAP_PWM_ECCTL2);
+
+	if (enable) {
+		/*
+		 * Enable 'Free run Time stamp counter mode' to start counter
+		 * and  'APWM mode' to enable APWM output
+		 */
+		value |= ECAP_PWM_ECCTL2_TSCTR_FREERUN | ECAP_PWM_ECCTL2_APWM_MODE;
+		priv->pwm_state = TIECAP_APWM_ENABLED;
+	} else {
+		/* Disable 'Free run Time stamp counter mode' to stop counter
+		 * and 'APWM mode' to put APWM output to low
+		 */
+		value &= ~(ECAP_PWM_ECCTL2_TSCTR_FREERUN | ECAP_PWM_ECCTL2_APWM_MODE);
+		priv->pwm_state = TIECAP_APWM_DISABLED;
+	}
+
+	writew(value, priv->regs + ECAP_PWM_ECCTL2);
+
+	return 0;
+}
+
+static int tiecap_pwm_set_invert(struct udevice *dev, uint channel,
+				 bool polarity)
+{
+	struct tiecap_pwm_priv *priv = dev_get_priv(dev);
+	u16 value;
+
+	value = readw(priv->regs + ECAP_PWM_ECCTL2);
+
+	if (polarity == TIECAP_PWM_POLARITY_INVERSED)
+		/* Duty cycle defines LOW period of PWM */
+		value |= ECAP_PWM_ECCTL2_APWM_POL_LOW;
+	else
+		/* Duty cycle defines HIGH period of PWM */
+		value &= ~ECAP_PWM_ECCTL2_APWM_POL_LOW;
+
+	writew(value, priv->regs + ECAP_PWM_ECCTL2);
+
+	return 0;
+}
+
+static int tiecap_pwm_of_to_plat(struct udevice *dev)
+{
+	struct tiecap_pwm_priv *priv = dev_get_priv(dev);
+
+	priv->regs = dev_read_addr(dev);
+	if (priv->regs == FDT_ADDR_T_NONE) {
+		dev_err(dev, "invalid address\n");
+		return -EINVAL;
+	}
+
+	dev_dbg(dev, "regs=0x%08x\n", priv->regs);
+
+	return 0;
+}
+
+static int tiecap_pwm_probe(struct udevice *dev)
+{
+	struct tiecap_pwm_priv *priv = dev_get_priv(dev);
+	struct clk clk;
+	int err;
+
+	err = clk_get_by_name(dev, "fck", &clk);
+	if (err) {
+		dev_err(dev, "failed to get clock\n");
+		return err;
+	}
+
+	priv->clk_rate = clk_get_rate(&clk);
+	if (IS_ERR_VALUE(priv->clk_rate) || !priv->clk_rate) {
+		dev_err(dev, "failed to get clock rate\n");
+		if (IS_ERR_VALUE(priv->clk_rate))
+			return priv->clk_rate;
+
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct pwm_ops tiecap_pwm_ops = {
+	.set_config     = tiecap_pwm_set_config,
+	.set_enable     = tiecap_pwm_set_enable,
+	.set_invert     = tiecap_pwm_set_invert,
+};
+
+static const struct udevice_id tiecap_pwm_ids[] = {
+	{ .compatible = "ti,am3352-ecap" },
+	{ .compatible = "ti,am33xx-ecap" },
+	{ }
+};
+
+U_BOOT_DRIVER(tiecap_pwm) = {
+	.name   = "tiecap_pwm",
+	.id     = UCLASS_PWM,
+	.of_match = tiecap_pwm_ids,
+	.ops    = &tiecap_pwm_ops,
+	.probe  = tiecap_pwm_probe,
+	.of_to_plat     = tiecap_pwm_of_to_plat,
+	.priv_auto      = sizeof(struct tiecap_pwm_priv),
+};
-- 
2.34.1

