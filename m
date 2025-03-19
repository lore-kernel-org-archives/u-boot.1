Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6EFFC35FFB
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 20:25:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9BCF81C64;
	Wed, 19 Mar 2025 21:25:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JMv+ZC14";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A678F81A0E; Wed, 19 Mar 2025 21:25:25 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0C3181101
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 21:25:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sbellary@baylibre.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22403cbb47fso140801225ad.0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 13:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742415921; x=1743020721;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZpKcCOPt3W2gEydPOLcDYc8W71Xw7Mb4WLeBSXEjixE=;
 b=JMv+ZC14t/Xev9rCCUWw/lfWiTqXiLkLknP5upZuNtMfwQXbn42devkUwUyDREZIAr
 Z7Bmh4Z42I6cby6lNlkx5G12U+Fh+W2oO78lVoRGC/xWvF2/G35I3eHdiOzWGaDLZvi8
 t5uN/rlM1oKiskL10bbedRX58QEfw/yGQeTP3znyjKB9xUaK/CgCuYp7fkQ4wI3r1fC2
 NgaItPEL3X6+KBzIjCazyTai096wvpWjJgvdmwLHG1elRySTHl6F1gq2f+2c7cJq0nv1
 wsl+LakhhbPT8g/5C67jMnT60zFM4C8sCwsNnKqWGPwVa8NIpZ7K5zZ781uUMZfce84v
 po4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742415921; x=1743020721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZpKcCOPt3W2gEydPOLcDYc8W71Xw7Mb4WLeBSXEjixE=;
 b=uhPVfsQ8ynrMXTh+iJazfUM4H7SLNRgVM9dZpDbafV1FkgXAd+4SkvBhOt+Tt4prPD
 Un6HemZtrDKaYAVsBfPzckP9GRgmCJuF09Muq1obDrkiJ9niN5KYv/KTtsobAFq7o1R+
 7tKG3EvJoL2hnZjqDPfs7sZxsOSgEU8fwZawQC9TFwQQqONU0kKbVafRbwiTp2qTl/Mf
 TU4yrzcDXdogg8Erjhjng4WC9RTawiO3AW/w/yFeDYPTXrvSE4115ru3Q0AKhZ1CH4Sb
 NU+0+RZn18jPLuAOAd8sepRjTFu0mLZfuD11/3+JvbczbdekxWoBb6qAx6Pj7Q8KbbdY
 wJvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwMIA95wFqWR8a5vzDqwgOug+hXYLle4wbgQnPvqH3YMywMlanJlSzVoTntTavTq0G4jyHdu4=@lists.denx.de
X-Gm-Message-State: AOJu0YwJ+fXrGykhXLNIMgE2kZzJPsrPnWKEOs4AO9XpWlOPj5BP+cp6
 q35Sgq7gOz/5fXjidi8lSSWpvVmsYbmwXU/DKEJv9D1G5uIdflZPLyVuX80FvbM=
X-Gm-Gg: ASbGncvDOjSGS+n2WvIbph3xSaNR0u4n/0WWwkr8+mJurqNR04VQHjheICkNXRqyA90
 TQZz5kZt97SovyCwHergZQbxTXx2FKHEcq2ip6y62F8LJEU37r08qLwYyKQN/EMKiTyH76QavV9
 ql4wIPsJinhOLZqljEy7yFLllZNoT7ltqcVjdE9rH6wfuH9GTkc7yH41YevrfFMuOcT96hSsNYJ
 DFbnxdwIq1vPUcCblbaBMS0VfyRmnbhKcLG7EEK+FMwCsw/Z3XtXpl3j6o4cqMa/85TAZgMv0aj
 Uyum+W3Xl0xjkSSXg/lCD86EEwV4hbuBpmtnlj1j+Bbg0CBjEoIQQb4NnGKCDKhznsP1Jse0JN5
 MspKMI6N7iF4yWZIT+Q==
X-Google-Smtp-Source: AGHT+IHBn4rSa1LKkiwvF+PiDrOvlIrcLegVo9oLdQbtM+rE/hnkua5fxvdaSvitRcMJFbni4FN6IA==
X-Received: by 2002:a05:6a00:1ad4:b0:736:32d2:aa93 with SMTP id
 d2e1a72fcca58-7377aa4dc65mr1054398b3a.20.1742415921326; 
 Wed, 19 Mar 2025 13:25:21 -0700 (PDT)
Received: from dev-linux.. (syn-076-088-115-008.res.spectrum.com.
 [76.88.115.8]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73730ca057csm8886757b3a.48.2025.03.19.13.25.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 13:25:20 -0700 (PDT)
From: Sukrut Bellary <sbellary@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: Sukrut Bellary <sbellary@baylibre.com>,
 Kevin Hilman <khilman@baylibre.com>, Bajjuri Praneeth <praneeth@ti.com>,
 Raghavendra Vignesh <vigneshr@ti.com>, u-boot@lists.denx.de
Subject: [PATCH 1/3] pwm: ti: am33xx: Enable Auxiliary PWM using eCAP
Date: Wed, 19 Mar 2025 13:25:14 -0700
Message-Id: <20250319202516.3300444-2-sbellary@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250319202516.3300444-1-sbellary@baylibre.com>
References: <20250319202516.3300444-1-sbellary@baylibre.com>
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

In am33xx SOC[1], enhanced capture (eCAP) supports auxiliary PWM (APWM).
This series adds the PWM driver support for the APWM feature for eCAP on
AM33xx.

eCAP HW also supports the capture mode. Currently, this driver only
supports APWM.

This is based on the Linux kernel driver -> drivers/pwm/pwm-tiecap.c
Version: v6.12

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
index 6e79868d0efc..cbdc87bfccc6 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -118,3 +118,9 @@ config PWM_TI_EHRPWM
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
index e4d10c8dc3ef..5bd9837014da 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -24,3 +24,4 @@ obj-$(CONFIG_PWM_SIFIVE)	+= pwm-sifive.o
 obj-$(CONFIG_PWM_TEGRA)		+= tegra_pwm.o
 obj-$(CONFIG_PWM_SUNXI)		+= sunxi_pwm.o
 obj-$(CONFIG_PWM_TI_EHRPWM)	+= pwm-ti-ehrpwm.o
+obj-$(CONFIG_PWM_TI_ECAP)	+= pwm-tiecap.o
diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
new file mode 100644
index 000000000000..13cf50aa2843
--- /dev/null
+++ b/drivers/pwm/pwm-tiecap.c
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * ECAP PWM driver
+ *
+ * Copyright (C) 2024 BayLibre, SAS
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
+	dev_dbg(dev, "regs=0x%08lx\n", priv->regs);
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

