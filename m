Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9EA6C19F2E
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 09:49:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D601C8118B;
	Thu, 27 Feb 2025 10:49:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Oh+qoL1e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFDB7807FB; Thu, 27 Feb 2025 10:49:32 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 952B480F12
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 10:49:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rui.silva@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-390df0138beso368280f8f.0
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 01:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740649770; x=1741254570; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ItIVN/+KCDXhAvBXHfGKjc5Nx01t07WxpKIMElmE6lE=;
 b=Oh+qoL1ekClkJL06OdjzNaxljyRMWU+ty2ugncanascF4DqF1lInZelhHNPp1bJvsT
 k1OWTpWMFWxhMjdRAyyBLaXZShL3McpSIlpYZGMdlc8RBmEfDVPCT4nHJHDburJv4rYS
 BD3WozV6mKn8sejUnZgldP04UsfPX4w+fO1SXfz05EEbcdUiHFqkmJ/mw4tn+b37lopz
 Uy56Fq1B8G3FoqzS2/NXORc+yEcmmk9/ZQSCwKJIxoKzzAtbNlQvAjP6ibi1WmhpBPCh
 EGuxbRRHc4FWZU0jH/gSYptMgmS6DMSK9PWPwaL/9WjEv4Sr8rb3x+nVU4EOeBxtvn4i
 SXIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740649770; x=1741254570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ItIVN/+KCDXhAvBXHfGKjc5Nx01t07WxpKIMElmE6lE=;
 b=FYLtmGOY+lT8ZuG3VVPEPBbWeevTsoRs2E3s+B23FasNrX0XVVm5VKI2JX6BoEPjK2
 xKdujfHDdjzWMPsfcLQnrdwEUsbopZn1xdtzYPBz+K3wwZoqEgeV6CEjxUnqIEsgD9BC
 5oWJS/l+NRWFGIghJlPlHSMZVfDfD6kttw2GqGjNZOVO8uqmSNRxboit4L4FV2+Ybcqw
 SWVkJWqtotkF3pe8pKgGAMkwo1GTVLnwfuw8DPo0z+kJrBGmmSAUiJiCFYGdxYT/tT4P
 TIeJSXBbE57eb5AKRGYUaF4S8T6xH8HP4cs9qTKRpLFtG/vDzqBDkHrk+pfhDR0xlpOt
 QiiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSUKHOV7SQ/n2NONjUsvQXhIgWaq6OMXG+xVeMveoN95UJVVwnKODiuWWSHy57eT09652xNd0=@lists.denx.de
X-Gm-Message-State: AOJu0YxiVvetCxpkttmc6SmcafGkUFWUl+E1jaG7p1/mRqLNH6WczEYE
 UIKYzd4SMT7zrkF35M31k5sSYP87T9UhYsmElu9ARgxse/VCcifesYECR0sMGDI=
X-Gm-Gg: ASbGncsppYZEwpZAtV/n1ULLvZyPRHyvrahpAHVpaj8kZ9px7UTKhXBbSRFhlqQCOyp
 SojkQukHwerbRgyQy2xVTPxGJ5fqdXkPCESuQsY4YGmNazwfTZH66R2FC2I7xEJWNjTfQN6c6uE
 iGzaBCLxnmcYjEd6vlA/0Kw3hA/yvmjzOBlYqCebEPrDuH3OHKDYAhkT707w2DhCiqspBSNolqZ
 YMbPBZJ9ig624QenKPpQBeyqabTKiDWZG4yclGkiYQZPcjhIbbt6OVjRksBl4FCduWAdjVOfv6v
 guAG+XmtZw928tgpRp8uzRzYX10eQGNxi0fwHjpCLonfJOrRzt5J9HNpbxkymqM=
X-Google-Smtp-Source: AGHT+IGGNjjsxpZbAbtrdkLr/frFfvlGvSAYp9GLTbIPneGUbRwbsUyzHDKMCeCfj+MA5me68a6hIg==
X-Received: by 2002:a05:6000:1a87:b0:390:dfe9:1866 with SMTP id
 ffacd0b85a97d-390dfe91c49mr2090002f8f.4.1740649770002; 
 Thu, 27 Feb 2025 01:49:30 -0800 (PST)
Received: from arch-thunder.local (a109-49-32-45.cpe.netcabo.pt.
 [109.49.32.45]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47a6a4asm1506162f8f.34.2025.02.27.01.49.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 01:49:29 -0800 (PST)
From: Rui Miguel Silva <rui.silva@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Rui Miguel Silva <rui.silva@linaro.org>
Subject: [PATCH 2/2] power: regulator: add qcom-usb-vbus
Date: Thu, 27 Feb 2025 09:45:50 +0000
Message-ID: <20250227094911.497219-3-rui.silva@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227094911.497219-1-rui.silva@linaro.org>
References: <20250227094911.497219-1-rui.silva@linaro.org>
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

Add regulator driver that allow some Qualcomm PMIC to
feed VBUS output to peripherals that are connected.

Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
---
 drivers/power/regulator/Kconfig               |   7 ++
 drivers/power/regulator/Makefile              |   1 +
 .../power/regulator/qcom_usb_vbus_regulator.c | 111 ++++++++++++++++++
 3 files changed, 119 insertions(+)
 create mode 100644 drivers/power/regulator/qcom_usb_vbus_regulator.c

diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
index 958f337c7e73..558133e09bf8 100644
--- a/drivers/power/regulator/Kconfig
+++ b/drivers/power/regulator/Kconfig
@@ -224,6 +224,13 @@ config DM_REGULATOR_QCOM_RPMH
 	  implements get/set api for a limited set of regulators used
 	  by u-boot.
 
+config DM_REGULATOR_QCOM_USB_VBUS
+	bool "Enable driver model for Qualcomm USB vbus regulator"
+	depends on DM_REGULATOR
+	---help---
+	  Enable support for the Qualcomm USB Vbus regulator. The driver
+	  implements get/set api for the regulator to be used by u-boot.
+
 config SPL_DM_REGULATOR_GPIO
 	bool "Enable Driver Model for GPIO REGULATOR in SPL"
 	depends on DM_REGULATOR_GPIO && SPL_GPIO
diff --git a/drivers/power/regulator/Makefile b/drivers/power/regulator/Makefile
index ca6c89d13b5c..a4191b9302b1 100644
--- a/drivers/power/regulator/Makefile
+++ b/drivers/power/regulator/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_$(XPL_)DM_REGULATOR_COMMON) += regulator_common.o
 obj-$(CONFIG_$(XPL_)DM_REGULATOR_FIXED) += fixed.o
 obj-$(CONFIG_$(XPL_)DM_REGULATOR_GPIO) += gpio-regulator.o
 obj-$(CONFIG_DM_REGULATOR_QCOM_RPMH) += qcom-rpmh-regulator.o
+obj-$(CONFIG_DM_REGULATOR_QCOM_USB_VBUS) += qcom_usb_vbus_regulator.o
 obj-$(CONFIG_$(PHASE_)REGULATOR_RK8XX) += rk8xx.o
 obj-$(CONFIG_DM_REGULATOR_S2MPS11) += s2mps11_regulator.o
 obj-$(CONFIG_REGULATOR_S5M8767) += s5m8767.o
diff --git a/drivers/power/regulator/qcom_usb_vbus_regulator.c b/drivers/power/regulator/qcom_usb_vbus_regulator.c
new file mode 100644
index 000000000000..2d58ef5e111e
--- /dev/null
+++ b/drivers/power/regulator/qcom_usb_vbus_regulator.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2025, Linaro Limited
+ */
+#define pr_fmt(fmt) "qcom_usb_vbus: " fmt
+
+#include <bitfield.h>
+#include <errno.h>
+#include <dm.h>
+#include <fdtdec.h>
+#include <log.h>
+#include <asm/gpio.h>
+#include <linux/bitops.h>
+#include <linux/printk.h>
+#include <power/pmic.h>
+#include <power/regulator.h>
+
+#define CMD_OTG				0x50
+#define OTG_EN				BIT(0)
+// The 0 bit in this register's bit field is undocumented
+#define OTG_CFG				0x56
+#define OTG_EN_SRC_CFG			BIT(1)
+
+struct qcom_usb_vbus_priv {
+	phys_addr_t base;
+};
+
+static int qcom_usb_vbus_regulator_of_to_plat(struct udevice *dev)
+{
+	struct qcom_usb_vbus_priv *priv = dev_get_priv(dev);
+
+	priv->base = dev_read_addr(dev);
+	if (priv->base == FDT_ADDR_T_NONE)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int qcom_usb_vbus_regulator_get_enable(struct udevice *dev)
+{
+	struct qcom_usb_vbus_priv *priv = dev_get_priv(dev);
+	int otg_en_reg = priv->base + CMD_OTG;
+	int ret;
+
+	ret = pmic_reg_read(dev->parent, otg_en_reg);
+	if (ret < 0)
+		log_err("failed to read usb vbus: %d\n", ret);
+	else
+		ret &= OTG_EN;
+
+	return ret;
+}
+
+static int qcom_usb_vbus_regulator_set_enable(struct udevice *dev, bool enable)
+{
+	struct qcom_usb_vbus_priv *priv = dev_get_priv(dev);
+	int otg_en_reg = priv->base + CMD_OTG;
+	int ret;
+
+	if (enable) {
+		ret = pmic_clrsetbits(dev->parent, otg_en_reg, 0, OTG_EN);
+		if (ret < 0) {
+			log_err("error enabling: %d\n", ret);
+			return ret;
+		}
+	} else {
+		ret = pmic_clrsetbits(dev->parent, otg_en_reg, OTG_EN, 0);
+		if (ret < 0) {
+			log_err("error disabling: %d\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int qcom_usb_vbus_regulator_probe(struct udevice *dev)
+{
+	struct qcom_usb_vbus_priv *priv = dev_get_priv(dev);
+	int otg_cfg_reg = priv->base + OTG_CFG;
+	int ret;
+
+	/* Disable HW logic for VBUS enable */
+	ret = pmic_clrsetbits(dev->parent, otg_cfg_reg, OTG_EN_SRC_CFG, 0);
+	if (ret < 0) {
+		log_err("error setting EN_SRC_CFG: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct dm_regulator_ops qcom_usb_vbus_regulator_ops = {
+	.get_enable = qcom_usb_vbus_regulator_get_enable,
+	.set_enable = qcom_usb_vbus_regulator_set_enable,
+};
+
+static const struct udevice_id qcom_usb_vbus_regulator_ids[] = {
+	{ .compatible = "qcom,pm8150b-vbus-reg"},
+	{ },
+};
+
+U_BOOT_DRIVER(qcom_usb_vbus_regulator) = {
+	.name = "qcom-usb-vbus-regulator",
+	.id = UCLASS_REGULATOR,
+	.of_match = qcom_usb_vbus_regulator_ids,
+	.of_to_plat = qcom_usb_vbus_regulator_of_to_plat,
+	.ops = &qcom_usb_vbus_regulator_ops,
+	.probe = qcom_usb_vbus_regulator_probe,
+	.priv_auto = sizeof(struct qcom_usb_vbus_priv),
+};
-- 
2.48.1

