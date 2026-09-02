Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 411F7C61DD6
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 14:44:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EB0466070B;
	Wed,  2 Sep 2026 14:44:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DEyB7FLiIngc; Wed,  2 Sep 2026 14:44:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788360289;
	bh=7CQGVltOvm37zihBgs4NmO3xTDwyCEcPlhNLc9MYBx4=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PdRHZpLtZ8WzygcRVxl5Rysj6lQ+Pvsss6ux7Fv/nDN83kLIOV1dIYyop5URuAa65
	 KJv9nXuO8e2db9Spd9ZSZ1+zj4OtoJyiT7mCr0Z7GJ9+vG5wH8H05Xp3p2GsdD1jg5
	 79KGEY2/Hkss1BZUv1lnu74lHAo2NIldad7VYysxm2giuOnaQYjhPmADHH6pb7/Lc6
	 QHxi5Ebst9YjKnqcaa2GhbQile3j3d1at2mP32NG3VDNVoEGss9EUshmekLZ5TBB4t
	 TFCqZuURxjMEVv6mbrtaRfdc2JTxtGi0/oFOOIDO+3LCUZfgJeapOkmSxzAsKDzDxu
	 288TK/GP+6M3w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 97085606A7;
	Wed,  2 Sep 2026 14:44:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D45D9127
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:44:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BAB1B40191
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:44:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ty_R3R8mOZo3 for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 14:44:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::230; helo=mail-oi1-x230.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=jopdji6j
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EB25840096
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:44:45 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-4b3a61bdf22so567626b6e.3
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 07:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788360284; x=1788965084;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7CQGVltOvm37zihBgs4NmO3xTDwyCEcPlhNLc9MYBx4=;
 b=jopdji6jNg42OUeG/mBQPqDORKjeYqMeCEmn3C81FnEzetMrSVReloonuZ4To18gru
 k7KalZHu2TJ972Ke2o+g1G4qZhTF2F2dfzASEXe5xnCs4KYDXcsJFhUsLdC/WrHOGaSP
 Gu6b+yACYc7EH88bg3vQ+Q4Ef40Y1YN868FTgTtYlu3nvhtHrbrhR2WNBC07bASx617J
 1wtbaoHI/EPhRbtxkdHKCQlnLOB9dfN5taiYiT/+eVYD7J5daiKVZwtCzxOl4cefExsb
 hv1rlYvQ9NpBbEi9UvSSypd4+XcusP80yxoTCCuVIUQ1jaU9ZdiWabx4HwQ8RWCmXFYI
 HkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788360284; x=1788965084;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7CQGVltOvm37zihBgs4NmO3xTDwyCEcPlhNLc9MYBx4=;
 b=aj79N2a5kiR2eqAiuiS3wzoygIqLRAC5PvXFuVG0y+JQUG0/pvcue8bvpbgS96N1Lz
 zrEYmYkBtvLnojyXEZa6yrhM1Y3+tojUX5qUcRbhBtyCAVBevJw+ffHcryKE3nV5lQGL
 eX43BJ4B44R4pSRddr7wzNZCtLVfqwUNQHa0gx/END/u0MnYdTOWgokyeeEAK4GTl3F8
 DzR+ZyF98gAYUCVfx6ACzgRqaa7IhrAY+9Ms5ngSDT7hYkgpCi9Yc85PB9rPfnXu6DZN
 dMfCNHvUisSY3XzHf5nm/BP+fdvSSHYIFKhlcIhK8Hs/lDBiAlLAdoK/wAFTH5cGLwLv
 rUfQ==
X-Gm-Message-State: AFuF++lyTz/foww6wjsCoQaW7vAdDfD7t3l8/cGh8NEgZad5yG1rsIjk
 yREfFGEOkAZNJsmkj47ajwN83eclDRGk2k30Oo2vF3FJn5K+HDntlRTnnNo93o/1StI=
X-Gm-Gg: AR+sD13G5SO6W2zbldTTd8NzaYsIh5Aul7IBVoO8dGyTA78/+6EiefkPBGrbQGNSEZn
 zgnag7Cr0mRYxteTKQJOQ7Xs/uJqOdS8Yt3CdlXGllXv+wRAfMuDFDeM7vUEhVfm4OzrtFruKV8
 Wq8aW/u/oSes2fRwsMEXXrYchnnmetU8/sAfwFpIx7EeImgc6M3Ck5t+rAKNK+WLcgY5QgUK3Dq
 s2Qli35o6GYqv16zIuqke0xvOZKJ5d56cHCg+YLaOq6s9QEfuDUbYghL9IXbfGAhV02sTmYdlYD
 oCUDys1moYrXwn+bA9AdzJGFbNMgX1XVKwSi0eM/Ka2eoqaZB+KHxDeuhJyksVG3P+pvlbz/eob
 7Dut1T5+R/nB3j1WUqCJCgH3wUOVQvQA0ALBZ2tvEgPTrpSAsZZ5ybtPzhogajmJjwE/YECECFt
 UeRVKfpbnF+MbB/02UaZqZPc6guQuX74fw0paaunK5GqQrDFdJ3bjjMTx9+uwf9rAntw==
X-Received: by 2002:a05:6808:1591:b0:4b5:b13a:9001 with SMTP id
 5614622812f47-4b6beb4a8bamr3864013b6e.14.1788360284086; 
 Wed, 02 Sep 2026 07:44:44 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:518a:9db8:615b:293f])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b698a34576sm2245109b6e.5.2026.09.02.07.44.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 07:44:43 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 02 Sep 2026 09:44:27 -0500
Subject: [PATCH v2] pwm: add MediaTek display PWM driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-mtk-pwm-disp-backlight-v2-1-e68c64d29bcd@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNSw6CMBRFt0I69hla+ZWR+zAM2vKAJ9+0FSWEv
 Qu4AIcnOffclTm0hI7lwcoszuRoHHYQl4CZRg01ApU7MxGKJMx4BL1vYXr3UJKbQCvTdlQ3Hm4
 y5gq1TJIqZft4sljR5ww/ih+7l36i8UftMBpyfrTL+Tzzw/t7MnPgkEWplKIKdcbju1ZLR9ri1
 Yw9K7Zt+wLta/vc0QAAAA==
X-Change-ID: 20260814-mtk-pwm-disp-backlight-3951aeb966f7
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7670; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=3sYlVd1Ct6BAo8FnPhyQE4Jl1Nc2OXm++D/GXr0NSXk=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqmDZSJDE+jgU1SPeCxVORM6ivgKiwXjcDoC5/m
 ZUoeLwRhu+JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCapg2UhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AlU0H/j0toxXwQ5iagsPlwakCiwTXumR/7sM88WUP3Id
 hlQAvMmmKuIpv47qKerRwwtHj28NNn+LbuTCJO9hbcnB0hmqC2ENNf/ky0L2JAP12p50ga3UFjU
 drZaO6k29ZgP9qgmaZUTxjDWAyIVVsCY482NSfcvWH4xDY9bVRO+1p7Z0wWCz6VHT1moythI8fV
 4SECKEvC1FKkAdM+wsJrqZBsY+0TBSL4T7v740oBdJYcdBSdCI2amdGg99GOQfF/sT/5cUNhEDt
 q38r6SRWBUQvtbxphvw9UUYBtisXtNan5dTV8geOwyBNC/9O2OWx8mFaYarXiWJ79y8Ay6SPJm9
 ofOo=
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

Add a new driver for MediaTek display PWM controller. This is generally
used for backlight control on MediaTek SoCs.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
This driver will be used by MediaTek Genio 360 EVK that we are currently
working on bringing up.
---
Changes in v2:
- Credit the original author of the Linux driver.
- Use uint instead of u32 for the ops parameters to match struct pwm_ops.
- Reject a non-zero channel number.
- Reject duty_ns greater than period_ns.
- Check the value returned by clk_get_rate().
- Use FIELD_MAX() instead of FIELD_FIT() to range-check clk_div since
  FIELD_FIT() truncates the 64-bit value on 32-bit builds.
- Use clrsetbits_le32() and friends instead of open-coded
  read-modify-write helpers.
- Move the double buffer/manual mode setup to probe() so that it does not
  depend on set_config() being called before set_enable().
- Disable the main clock if enabling the mm clock fails.
- Print an error message on the probe() failure paths.
- Link to v1: https://patch.msgid.link/20260814-mtk-pwm-disp-backlight-v1-1-847992f0b815@baylibre.com
---
 drivers/pwm/Kconfig        |   8 ++
 drivers/pwm/Makefile       |   1 +
 drivers/pwm/pwm-mtk-disp.c | 187 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 196 insertions(+)

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
index 00000000000..aeaae006a45
--- /dev/null
+++ b/drivers/pwm/pwm-mtk-disp.c
@@ -0,0 +1,187 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MediaTek display pulse-width-modulation controller driver.
+ *
+ * Copyright (c) 2015 MediaTek Inc.
+ * Author: YH Huang <yh.huang@mediatek.com>
+ *
+ * Copyright (C) 2026 BayLibre, SAS
+ */
+
+#include <clk.h>
+#include <dm.h>
+#include <pwm.h>
+#include <asm/io.h>
+#include <dm/device_compat.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/err.h>
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
+static int mtk_disp_pwm_set_config(struct udevice *dev, uint channel,
+				   uint period_ns, uint duty_ns)
+{
+	struct mtk_disp_pwm_priv *priv = dev_get_priv(dev);
+	const struct mtk_disp_pwm_data *data = priv->data;
+	u64 div, clk_div, period, high_width;
+	ulong rate;
+
+	if (channel)
+		return -EINVAL;
+
+	if (duty_ns > period_ns)
+		return -EINVAL;
+
+	rate = clk_get_rate(&priv->clk_main);
+	if (IS_ERR_VALUE(rate) || !rate)
+		return -EINVAL;
+
+	/*
+	 * period_ns = 10^9 * (clk_div + 1) * (period + 1) / rate
+	 * duty_ns = 10^9 * (clk_div + 1) * high_width / rate
+	 */
+	clk_div = (((u64)period_ns * rate) / NSEC_PER_SEC) >> PWM_PERIOD_BIT_WIDTH;
+	if (clk_div > FIELD_MAX(PWM_CLKDIV_MASK))
+		return -EINVAL;
+
+	div = NSEC_PER_SEC * (clk_div + 1);
+	period = ((u64)period_ns * rate) / div;
+	if (period > 0)
+		period--;
+
+	high_width = ((u64)duty_ns * rate) / div;
+
+	clrsetbits_le32(priv->base + data->con0, PWM_CLKDIV_MASK,
+			FIELD_PREP(PWM_CLKDIV_MASK, clk_div));
+	clrsetbits_le32(priv->base + data->con1,
+			PWM_PERIOD_MASK | PWM_HIGH_WIDTH_MASK,
+			FIELD_PREP(PWM_PERIOD_MASK, period) |
+			FIELD_PREP(PWM_HIGH_WIDTH_MASK, high_width));
+
+	if (data->has_commit) {
+		setbits_le32(priv->base + data->commit, data->commit_mask);
+		clrbits_le32(priv->base + data->commit, data->commit_mask);
+	}
+
+	return 0;
+}
+
+static int mtk_disp_pwm_set_enable(struct udevice *dev, uint channel, bool enable)
+{
+	struct mtk_disp_pwm_priv *priv = dev_get_priv(dev);
+
+	if (channel)
+		return -EINVAL;
+
+	clrsetbits_le32(priv->base + DISP_PWM_EN, priv->data->enable_mask,
+			field_prep(priv->data->enable_mask, enable));
+
+	return 0;
+}
+
+static int mtk_disp_pwm_probe(struct udevice *dev)
+{
+	struct mtk_disp_pwm_priv *priv = dev_get_priv(dev);
+	const struct mtk_disp_pwm_data *data;
+	int ret;
+
+	data = (const void *)dev_get_driver_data(dev);
+	priv->data = data;
+
+	priv->base = dev_read_addr_ptr(dev);
+	if (!priv->base) {
+		dev_err(dev, "failed to get base address\n");
+		return -EINVAL;
+	}
+
+	ret = clk_get_by_name(dev, "main", &priv->clk_main);
+	if (ret) {
+		dev_err(dev, "failed to get main clock: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_get_by_name(dev, "mm", &priv->clk_mm);
+	if (ret) {
+		dev_err(dev, "failed to get mm clock: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_enable(&priv->clk_main);
+	if (ret) {
+		dev_err(dev, "failed to enable main clock: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_enable(&priv->clk_mm);
+	if (ret) {
+		dev_err(dev, "failed to enable mm clock: %d\n", ret);
+		clk_disable(&priv->clk_main);
+		return ret;
+	}
+
+	if (data->bls_debug && !data->has_commit) {
+		/* Disable double buffer and select manual mode */
+		setbits_le32(priv->base + data->bls_debug, data->bls_debug_mask);
+		setbits_le32(priv->base + data->con0, data->con0_sel);
+	}
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

