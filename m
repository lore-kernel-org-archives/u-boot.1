Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D889C5CFC1
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 19:30:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EBC4B60708;
	Fri, 14 Aug 2026 19:30:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9HWonlFYEWlH; Fri, 14 Aug 2026 19:30:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0AF5460617
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786735831;
	bh=7WAIdJxi1vWFGrwecLMr4P1U4Ex+otZsCEefxTNrXM4=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nrD8Y1SEG8A2oSER4v+/r0cdgLFMvo4PHdIWeN+QFIv7VHdL/Lf+JTgm5qFfjGx2K
	 cjHnWJR5GOTwqJ8eq6IqPqGuXwfbca5WCOQ73yT1+4uS2vTRVC1X8qlvUGvwoWAK8C
	 WFiD46Rx1qYWkmdK3rlRLoa/vouH8P8raJreKjXdiHm8CabnC8DiEu7UkkO6L3AJi2
	 ccVdtPpi8W711WOHA7kx5DrVcnC2JJJlTh6SHb7MX7ZdLFS1PzKBvzka/Ht8Izv+b1
	 v55VKJo+ekAUYjy8Z8BWRXi+0mSm+6OZh8hrHPgsRP6ZeW4+eb66Ly/FEjuNg6V+Lf
	 UYbg/d2gCiP6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0AF5460617;
	Fri, 14 Aug 2026 19:30:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5EEAC23F
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 19:30:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 50FA140809
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 19:30:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d768Avin_b-v for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 19:30:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c36; helo=mail-oo1-xc36.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 3691A400D5
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3691A400D5
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=gX+8BoaA
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3691A400D5
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 19:30:27 +0000 (UTC)
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-6ae5baaef5dso1070516eaf.1
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 12:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786735826; x=1787340626;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7WAIdJxi1vWFGrwecLMr4P1U4Ex+otZsCEefxTNrXM4=;
 b=gX+8BoaAwzcZGI4yQ1HZvuj1DjFeUDy6Qnq+FzV3zVuQpwgmnrGGEBrvlSNtXYSYBx
 WgibJc6B5KqoYtxlJn5wS4kh3mDCSiyz+f0wQz/JBeGQQ/0ROnVsYLOlrp11ai10KtTZ
 SajaOxtPGD/eYwltPC32RdH4p5wTrsrwPTd/kx3SIZwDz2yiGofoMPdEexi07n+n0iA0
 DTsg8kHb0nf2VfowHeT89oLQB4vxy/tUjGNutqrAZw5vE9Pp57bydK1X6B3ZzYAWCVv7
 DYaiZW12VcSZmh2xiCmCpGdlTdgUFlngR4fiVQiqfEfwprK/F6wFFeWED3eEm2On31kE
 zNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786735826; x=1787340626;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7WAIdJxi1vWFGrwecLMr4P1U4Ex+otZsCEefxTNrXM4=;
 b=o9T9SQrmTODEy2kSkdMi8TMwTcWOtZnGgPnr9/7l9WuMRjJE/NViP96/tmxruc5PTT
 qgFGnKSq/WfxwWqrzGOuXhU2GC9oQ6SULvTwasch41tcct2iQkV20vtA6B1aKql/pmwp
 8Xcny9X2lK0FgCD59sUlGbv0XzRFb4zZx9U8o7R7LF52+u4uNZ6rIS8VF5dTVVQI1dd1
 y8PtkIfzIJQhe7DvwU7oH5DlUKKhjdh3NhzgCdCkfZ+AKzwhUrfkV8+dwpou8TSLW37U
 qXguG+vd4uJWtWDyD2pCxXxMcs0fL8peNuYAFm0SVf8Komd6x/Comd1BKPkvIR9dBZQN
 CO1A==
X-Gm-Message-State: AOJu0Yw93zxLysEXbOFGiEv4cGKhpB0Wy0vk8++3FLq7j4bmf6eph6yb
 I9KOJCLtG9DDtlS+Sx9Tufq0fM6aT+AQZfL95QqO7ssdxNXxukvyjB5BdWSTErPqbk0rzoE9L18
 VtgOUYeo=
X-Gm-Gg: AR+sD12Gk4PH3eaBOWH7G+/Xa22qkOPrWJrBIf1I3HJITqYNaOM2kLU2Xe2/hVQx1WG
 dqBwGtFNwP8RYZB3Ck1hRB0aIChpFrnH2ZURuU6i4XYQ3Ul7+fCtyyqKoEoE2wel7+CA+JVmHxN
 BQzG9eLrIZPiOpJ8Rzv6i57V/NZBpRqrL9nn7lNv/3hrGta2+RdF5VZN8HO9jgta853YL2KyvuC
 P1N7VeSG3126mZNoJEHd69Be2AZWwz+7oAcUWBbDI+sO/raGEJRPAif+Mi1z6xwacMAVhwKS9RO
 fqa0B6HZpNLdZOAOPbfjmoQaURxWizgE+Nl9VCDQy1KziETyNTyULW+n8ThjpmlquRb+w4X2p0F
 EZ1gYh00h1MkhYyhprkjRfsOHOPnXFnBUjxVkNKJuRbSAFHe0UM9YhmrHgMPvddJZ9k1ji8QqRj
 SVwkX9CqOPLbB60I57gdBl+ptTDGyzhSc6wVjfYgtR0oN+hqKtfJr+OzZp2VyWfHGNOg==
X-Received: by 2002:a05:6820:190b:b0:6ae:47e0:be1b with SMTP id
 006d021491bc7-6b0d7c599b5mr4663774eaf.6.1786735826217; 
 Fri, 14 Aug 2026 12:30:26 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7124:5000:3b37:b131])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b0d96643a7sm2761221eaf.8.2026.08.14.12.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 12:30:25 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 14 Aug 2026 14:30:15 -0500
Subject: [PATCH] pwm: add MediaTek display PWM driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-mtk-pwm-disp-backlight-v1-1-847992f0b815@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBBA0auQWTsJBa3iVQyLtgwwIth0CpoQ7
 m6F5Vv8v4JQYBK4ZysEWlj4PSWoUwauN1NHyE0yFHmh85s64xgH9J8RGxaP1rjhxV0fsawuypC
 ttG6vkGIfqOXvPn7Uh2W2T3Lxf4Nt+wE47R2HegAAAA==
X-Change-ID: 20260814-mtk-pwm-disp-backlight-3951aeb966f7
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6698; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=UvEbUtI8VjPf9PuKll2vW6OQafAHQ8kqsNA0DiwjwPM=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqf2zKRCqF8YMA73vPpMC3EWwyVb7jORIhLw/cf
 XuUa0Md04yJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCan9syhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AE28H/iptr8zZHujtMJhhfjC971Tl4jx0N/b98trrzrl
 UPr/Az2kw9C9TQTu2fs6enrJM7pLAG7DY3L7DT8/CN2LGnG+bqMq2jWXbXlTd/Cbjw9TBSuCCvp
 OTNLtny5cVuo2poNIryrPgQTkHfHVZ6UsKhHwnrMdM6oyjOFzTm6zItYXLh3Q9op6Aq3ODPXdFL
 Cd/8++5Z1pU4V+pzd/3K+NyvWe2jKnTY4zzqd/HX9CG1DXsO3OlihEhw4RhN3gN/7sh5Y/yrpmq
 mVVLtksEF+A1xp5sq2BUU7OLfl+X9AR1rsEG72skEVWDpdt813luw5IEZp62f+EcZs38ipqPxld
 uzD0=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add a new driver for MediaTek display PWM controller. This is generally
used for backlight control on MediaTek SoCs.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
This driver will be used by MediaTek Genio 360 EVK that we are currently
working on bringing up.
---
 drivers/pwm/Kconfig        |   8 ++
 drivers/pwm/Makefile       |   1 +
 drivers/pwm/pwm-mtk-disp.c | 178 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 187 insertions(+)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index a69fe37caff..8a2b140fe97 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -74,6 +74,14 @@ config PWM_MTK
 	  This PWM is found on MT7622, MT7623, and MT7629. It supports a
 	  programmable period and duty cycle.
 
+config PWM_MTK_DISP
+	bool "Enable support for MediaTek display PWM"
+	depends on ARCH_MEDIATEK
+	help
+	  This PWM is found on the display subsystem of several MediaTek
+	  SoCs (e.g. MT8183, MT8366). It is typically used to drive the
+	  backlight of a display panel.
+
 config PWM_ROCKCHIP
 	bool "Enable support for the Rockchip PWM"
 	depends on ARCH_ROCKCHIP
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 2682c536c6f..7c409c3c620 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_PWM_EXYNOS)	+= exynos_pwm.o
 obj-$(CONFIG_PWM_IMX)		+= pwm-imx.o
 obj-$(CONFIG_PWM_MESON)		+= pwm-meson.o
 obj-$(CONFIG_PWM_MTK)		+= pwm-mtk.o
+obj-$(CONFIG_PWM_MTK_DISP)	+= pwm-mtk-disp.o
 obj-$(CONFIG_PWM_ROCKCHIP)	+= rk_pwm.o
 obj-$(CONFIG_PWM_SANDBOX)	+= sandbox_pwm.o
 obj-$(CONFIG_PWM_SIFIVE)	+= pwm-sifive.o
diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
new file mode 100644
index 00000000000..540539e6167
--- /dev/null
+++ b/drivers/pwm/pwm-mtk-disp.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MediaTek display pulse-width-modulation controller driver.
+ *
+ * Copyright (c) 2015 MediaTek Inc.
+ * Copyright (C) 2026 BayLibre, SAS
+ */
+
+#include <clk.h>
+#include <dm.h>
+#include <pwm.h>
+#include <asm/io.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/errno.h>
+#include <linux/time.h>
+
+#define DISP_PWM_EN		0x00
+
+#define PWM_CLKDIV_MASK		GENMASK(25, 16)
+
+#define PWM_PERIOD_BIT_WIDTH	12
+#define PWM_PERIOD_MASK		GENMASK(PWM_PERIOD_BIT_WIDTH - 1, 0)
+
+#define PWM_HIGH_WIDTH_MASK	GENMASK(28, 16)
+
+struct mtk_disp_pwm_data {
+	u32 enable_mask;
+	u32 con0;
+	u32 con0_sel;
+	u32 con1;
+	bool has_commit;
+	u32 commit;
+	u32 commit_mask;
+	u32 bls_debug;
+	u32 bls_debug_mask;
+};
+
+struct mtk_disp_pwm_priv {
+	void __iomem *base;
+	struct clk clk_main;
+	struct clk clk_mm;
+	const struct mtk_disp_pwm_data *data;
+};
+
+static void mtk_disp_pwm_update_bits(void __iomem *base, u32 offset, u32 mask, u32 data)
+{
+	u32 value = readl(base + offset);
+
+	value &= ~mask;
+	value |= data;
+
+	writel(value, base + offset);
+}
+
+static void mtk_disp_pwm_set_bits(void __iomem *base, u32 offset, u32 mask)
+{
+	mtk_disp_pwm_update_bits(base, offset, mask, mask);
+}
+
+static void mtk_disp_pwm_clear_bits(void __iomem *base, u32 offset, u32 mask)
+{
+	mtk_disp_pwm_update_bits(base, offset, mask, 0);
+}
+
+static int mtk_disp_pwm_set_config(struct udevice *dev, u32 channel,
+				   u32 period_ns, u32 duty_ns)
+{
+	struct mtk_disp_pwm_priv *priv = dev_get_priv(dev);
+	const struct mtk_disp_pwm_data *data = priv->data;
+	u64 rate, div, clk_div, period, high_width;
+
+	rate = clk_get_rate(&priv->clk_main);
+
+	/*
+	 * period_ns = 10^9 * (clk_div + 1) * (period + 1) / rate
+	 * duty_ns = 10^9 * (clk_div + 1) * high_width / rate
+	 */
+	clk_div = (((u64)period_ns * rate) / NSEC_PER_SEC) >> PWM_PERIOD_BIT_WIDTH;
+	if (!FIELD_FIT(PWM_CLKDIV_MASK, clk_div))
+		return -EINVAL;
+
+	div = NSEC_PER_SEC * (clk_div + 1);
+	period = ((u64)period_ns * rate) / div;
+	if (period > 0)
+		period--;
+
+	high_width = ((u64)duty_ns * rate) / div;
+
+	if (data->bls_debug && !data->has_commit) {
+		/* Disable double buffer and select manual mode before writing */
+		mtk_disp_pwm_set_bits(priv->base, data->bls_debug, data->bls_debug_mask);
+		mtk_disp_pwm_set_bits(priv->base, data->con0, data->con0_sel);
+	}
+
+	mtk_disp_pwm_update_bits(priv->base, data->con0, PWM_CLKDIV_MASK,
+				 FIELD_PREP(PWM_CLKDIV_MASK, clk_div));
+	mtk_disp_pwm_update_bits(priv->base, data->con1,
+				 PWM_PERIOD_MASK | PWM_HIGH_WIDTH_MASK,
+				 FIELD_PREP(PWM_PERIOD_MASK, period) |
+				 FIELD_PREP(PWM_HIGH_WIDTH_MASK, high_width));
+
+	if (data->has_commit) {
+		mtk_disp_pwm_set_bits(priv->base, data->commit, data->commit_mask);
+		mtk_disp_pwm_clear_bits(priv->base, data->commit, data->commit_mask);
+	}
+
+	return 0;
+}
+
+static int mtk_disp_pwm_set_enable(struct udevice *dev, u32 channel, bool enable)
+{
+	struct mtk_disp_pwm_priv *priv = dev_get_priv(dev);
+
+	mtk_disp_pwm_update_bits(priv->base, DISP_PWM_EN, priv->data->enable_mask,
+				 field_prep(priv->data->enable_mask, enable));
+
+	return 0;
+}
+
+static int mtk_disp_pwm_probe(struct udevice *dev)
+{
+	struct mtk_disp_pwm_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	priv->data = (const void *)dev_get_driver_data(dev);
+
+	priv->base = dev_read_addr_ptr(dev);
+	if (!priv->base)
+		return -EINVAL;
+
+	ret = clk_get_by_name(dev, "main", &priv->clk_main);
+	if (ret)
+		return ret;
+
+	ret = clk_get_by_name(dev, "mm", &priv->clk_mm);
+	if (ret)
+		return ret;
+
+	ret = clk_enable(&priv->clk_main);
+	if (ret)
+		return ret;
+
+	ret = clk_enable(&priv->clk_mm);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct pwm_ops mtk_disp_pwm_ops = {
+	.set_config = mtk_disp_pwm_set_config,
+	.set_enable = mtk_disp_pwm_set_enable,
+};
+
+static const struct mtk_disp_pwm_data mt8183_pwm_data = {
+	.enable_mask = BIT(0),
+	.con0 = 0x18,
+	.con0_sel = 0x0,
+	.con1 = 0x1c,
+	.has_commit = false,
+	.bls_debug = 0x80,
+	.bls_debug_mask = GENMASK(1, 0),
+};
+
+static const struct udevice_id mtk_disp_pwm_ids[] = {
+	{ .compatible = "mediatek,mt8183-disp-pwm", .data = (ulong)&mt8183_pwm_data },
+	{ }
+};
+
+U_BOOT_DRIVER(mtk_disp_pwm) = {
+	.name		= "mtk_disp_pwm",
+	.id		= UCLASS_PWM,
+	.of_match	= mtk_disp_pwm_ids,
+	.ops		= &mtk_disp_pwm_ops,
+	.probe		= mtk_disp_pwm_probe,
+	.priv_auto	= sizeof(struct mtk_disp_pwm_priv),
+};

---
base-commit: d3e8597e46b635ec556a057bc42f0b0859654bdf
change-id: 20260814-mtk-pwm-disp-backlight-3951aeb966f7

Best regards,
--  
David Lechner <dlechner@baylibre.com>

