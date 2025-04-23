Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC62DC369D3
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 08:43:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4449E8091A;
	Wed, 23 Apr 2025 10:43:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="irGU2D+D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAAA9809D4; Wed, 23 Apr 2025 10:42:59 +0200 (CEST)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E9A180944
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 10:42:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sbellary@baylibre.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22401f4d35aso67837145ad.2
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 01:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745397775; x=1746002575;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LuHjdtCCKQ3BArrf1gnTFbqkDLHEpKJjiueQ6M7XvjY=;
 b=irGU2D+D++MyWZG8/Su5HV1IEEbETTdzNez0wJeuLExklqk1lQcUUDs3U8aUS53pbn
 U3BpWiOu3988i+hoREmRTAnCXBzlwP+PAR000kFiexiqUl1dw2L2P4T2heJPBsVvhxc+
 dDzACu/xUH0pyN5cEccFn4VbzPf6OCY9TVWwHx0FL2l+LfuNp7QqRZgZz3C1k+4O+RX2
 xOVK6AxZRib9Oy38Wi927ZFzt7YdkXS4Al/js6b7ZjTVtDAnv0GdiY1ZqjhhFYBmetf+
 SPpd4ZcZ9nkQMg1HuiOTSG9lvbRr7GxhBDZV7lC/J8MfsXgEVGSOjyqX397J2LaA5gfl
 wwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745397775; x=1746002575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LuHjdtCCKQ3BArrf1gnTFbqkDLHEpKJjiueQ6M7XvjY=;
 b=taXPVWtFwKud6Rl4uEIfc08AA1bGG1kpmN0nIUztIWw2A1wEvNkQd4pq1e5N0vRHTO
 87v3LQJb0eQFw09r33DXotKvIvFxhZ3xtoZEflHgDGJCk3csBhu8ET6CDmZFcrrdUWx5
 vSr/PQXRoL1z7r1qURl9i0td+6G2eWHkcIC6KKG6p3hcinYAZxdZDhHpduLQMENcve25
 WvrLEPGCClzUNzAp0CGVznxOD93ZqTaxlzjhAu0H8j6gpS+wDKRYhN3xCk+2NgQqNCgV
 oxsThcLelagAbSUbQ5k1sy7vok3GSCIPXDfXJl3x4A4aEyXt3ydULR6TI/wOqHE9SLcw
 87cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUt3iIQXq7Kr363qAmPaW+V2F9fLT+rzpzFmcghjM+H3VgJvGFwpNxn+yz0Vf9kNYaBhbJhvxE=@lists.denx.de
X-Gm-Message-State: AOJu0YyUYl3aVJNGTf9IbPX6xlpWxr6sN+L0CYV65WyJhq9D76Nik9ms
 urxMpPBxQcb4C5Ck6I6Q0GAlyxagd4VEjsdE0AmYxVD74Em1DlbPJk5AqZ87R/oTg0r7r22hokx
 d
X-Gm-Gg: ASbGncvIPg9nC2HoJAkSbY//sRdcvBc+LcWzhFkpuL3puUuPyUn8t5Ze1NL2f/3tIj5
 1cIKLAHs1Bxdjb0CYO3aUAEGpLB7EPaR3fFT12iCCjIbaf4IDUeWakOquEdWdjACP90eTQDzivi
 yc6tUXEJRqPCu8qzox9hxSLESbm/9vz8Pe9Yxrcg3pIdXUnbP4s2ifjcDoRiLxwGvyde7+cX3tK
 P1oGttyIwecp3gW+doqMUqpHlOZHk0HRl6or034cUX9Nl3HOKnt1n3c8ygPyz8cUJ47sw5CP5Ss
 xsBXmT+KIlDgZGDFVOUqGNE7mKWXVCfFh2R8n3oaCBzRWkxeFZoqJA7yzkIJCScHLN5ABuXVlpl
 keIQ=
X-Google-Smtp-Source: AGHT+IFXOYmLBhSUmrmHtcoMlsAmbE61XnsD/VHNpkl06pwFdDhhJ7RI7EdTvKxCD3bErOFn9Rw0zg==
X-Received: by 2002:a17:902:ea09:b0:21f:522b:690f with SMTP id
 d9443c01a7336-22c5361fd28mr274873395ad.46.1745397775473; 
 Wed, 23 Apr 2025 01:42:55 -0700 (PDT)
Received: from dev-linux.. (syn-076-088-115-008.res.spectrum.com.
 [76.88.115.8]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bdae69sm98860085ad.1.2025.04.23.01.42.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 01:42:54 -0700 (PDT)
From: Sukrut Bellary <sbellary@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: Sukrut Bellary <sbellary@baylibre.com>,
 Kevin Hilman <khilman@baylibre.com>, Bajjuri Praneeth <praneeth@ti.com>,
 Raghavendra Vignesh <vigneshr@ti.com>, u-boot@lists.denx.de
Subject: [PATCH 1/3] pwm: ti: am33xx: Enable Auxiliary PWM using eCAP
Date: Wed, 23 Apr 2025 01:42:47 -0700
Message-Id: <20250423084249.197101-2-sbellary@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423084249.197101-1-sbellary@baylibre.com>
References: <20250423084249.197101-1-sbellary@baylibre.com>
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

