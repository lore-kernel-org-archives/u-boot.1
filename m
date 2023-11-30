Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37DADC4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 20:23:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B9778770A;
	Thu, 30 Nov 2023 21:22:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FKCZ6/Lu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE26B87707; Thu, 30 Nov 2023 21:22:52 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CD60876C2
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 21:22:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-50bc36725bbso1978822e87.2
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 12:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701375769; x=1701980569; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zgcoUT+Zc4QgmXmNW9cHlA6q8iu1ITaaahJMciZTmO0=;
 b=FKCZ6/Lu8ZIAjdE6dmMISinzm+A12zIqqovaHJqb7/dXMLuyiWuUqs5IkAh45yAEwd
 GTuX4rXo+HedkiHKx06W48bVLhTaAiINTyDBclFnjYGqELoInsn6grDG/lgWAOVQuO4y
 1NMg4WpHVJ5x/u1Se1nEbiAhR711B4oWqIO+hmW2z49GbsCr/rEtF7joUzMqchTxBUMR
 X9NgVrReO2hw14buyo7WCDVcWrSzfDTmYBdrIp5se+0/x0z+76xenHRWIvZ2za+wH0/Q
 TvcqGlqJUVOT5J6muEn35nOl11LCjcDLp2Jik6gKVb8SYHP83+7j/TKvuD0V6ccxEWoG
 7Sgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701375769; x=1701980569;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zgcoUT+Zc4QgmXmNW9cHlA6q8iu1ITaaahJMciZTmO0=;
 b=INkFLnYHDzk5upvl6tHxWHr2Uljlj2uhGm+E/AX1/H9xob8T1JiZqqdUd5yR+Z4WSP
 GMLDWaEPg9T9DPpukuNBuoX77mv8dof1rbtZI6p1WwPWnxYsu6jHBchXKR8Zobchyyk2
 sRWgDN+Zw0Fpud/u+o8ryIIHqdvXKUVy/Bi8N7O98n7SX3xNn7ISQevwvkwkr8taNN0z
 O7t8MIGmpbvKNjJHNIkeTbbr81N+5TYhAAfTnPyBOHOpcSe/2qLhttdjzmofbZ9PLpoF
 iXukdaChy2NxC1SQIcU9lLtkCI/+GdISVgVzbocNN3OseBN+zOtCTJEC0DTo5Wtc9NqX
 SUIg==
X-Gm-Message-State: AOJu0Yzvq2EQpriccvWyLCrHWQBz3HaZBVhFIJAAKTUqqjtjlkEpsPRn
 BLa21AKSfO8nPbF8Zmnkg1/PVg==
X-Google-Smtp-Source: AGHT+IGUzCKyhuyCIOy0cmKy9f4xdyvH75txh/havclhmqVykqrxiASRLLPdKE2M5/N1Y167F6G15A==
X-Received: by 2002:ac2:54a7:0:b0:50b:d763:fe50 with SMTP id
 w7-20020ac254a7000000b0050bd763fe50mr76406lfk.107.1701375769251; 
 Thu, 30 Nov 2023 12:22:49 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 fa23-20020a05600c519700b003fee6e170f9sm3028900wmb.45.2023.11.30.12.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 12:22:48 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 30 Nov 2023 20:22:26 +0000
Subject: [PATCH v5 2/9] button: qcom-pmic: introduce Qualcomm PMIC button
 driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231130-b4-qcom-dt-compat-v5-2-41500e237ad0@linaro.org>
References: <20231130-b4-qcom-dt-compat-v5-0-41500e237ad0@linaro.org>
In-Reply-To: <20231130-b4-qcom-dt-compat-v5-0-41500e237ad0@linaro.org>
To: Ramon Fried <rfried.dev@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=6578;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=MBLaL/Ij2NF87CUXfrcUkkQ4TJVPsOTTWwizWJlKvX4=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSM96KTp6w/NmWZ78xHc/fP987ouBDtFuTlLnK181SF7
 slCw4/LO0pZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBEZu1n+MP568qdjecSrn/a
 fnDrpeW7Jy+65fLH+Yb7t63L/Otkjml3Mvwv8rm39tavBiGbaYsvsk0o1fup6Tj5n6J19QnzgOs
 8O00KAA==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Qualcomm PMICs include a "pon" function which handles two buttons, the
power button and "resin" button (usually volume down). Introduce a new
driver following upstream Linux DT to enable these and map them to Enter
and Down respectively to enable use in boot menus.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 MAINTAINERS                       |   1 +
 drivers/button/Kconfig            |   9 +++
 drivers/button/Makefile           |   1 +
 drivers/button/button-qcom-pmic.c | 165 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 176 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f6d63c8ab563..8cd102eaa070 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -572,6 +572,7 @@ M:	Neil Armstrong <neil.armstrong@linaro.org>
 R:	Sumit Garg <sumit.garg@linaro.org>
 S:	Maintained
 F:	arch/arm/mach-snapdragon/
+F:	drivers/button/button-qcom-pmic.c
 F:	drivers/clk/qcom/
 F:	drivers/gpio/msm_gpio.c
 F:	drivers/mmc/msm_sdhci.c
diff --git a/drivers/button/Kconfig b/drivers/button/Kconfig
index 8ce2de37d62a..097b05f822e7 100644
--- a/drivers/button/Kconfig
+++ b/drivers/button/Kconfig
@@ -27,4 +27,13 @@ config BUTTON_GPIO
 	  The GPIO driver must used driver model. Buttons are configured using
 	  the device tree.
 
+config BUTTON_QCOM_PMIC
+	bool "Qualcomm power button"
+	depends on BUTTON
+	depends on PMIC_QCOM
+	help
+	  Enable support for the power and "resin" (usually volume down) buttons
+	  on Qualcomm SoCs. These will be configured as the Enter and Down keys
+	  respectively, allowing navigation of bootmenu with buttons on device.
+
 endmenu
diff --git a/drivers/button/Makefile b/drivers/button/Makefile
index bbd18af14940..68555081a47a 100644
--- a/drivers/button/Makefile
+++ b/drivers/button/Makefile
@@ -5,3 +5,4 @@
 obj-$(CONFIG_BUTTON) += button-uclass.o
 obj-$(CONFIG_BUTTON_ADC) += button-adc.o
 obj-$(CONFIG_BUTTON_GPIO) += button-gpio.o
+obj-$(CONFIG_BUTTON_QCOM_PMIC) += button-qcom-pmic.o
\ No newline at end of file
diff --git a/drivers/button/button-qcom-pmic.c b/drivers/button/button-qcom-pmic.c
new file mode 100644
index 000000000000..34a976d1e6c6
--- /dev/null
+++ b/drivers/button/button-qcom-pmic.c
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Qualcomm generic pmic gpio driver
+ *
+ * (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
+ * (C) Copyright 2023 Linaro Ltd.
+ */
+
+#include <button.h>
+#include <dt-bindings/input/linux-event-codes.h>
+#include <dm.h>
+#include <dm/device-internal.h>
+#include <dm/lists.h>
+#include <log.h>
+#include <power/pmic.h>
+#include <spmi/spmi.h>
+#include <linux/bitops.h>
+
+#define REG_TYPE		0x4
+#define REG_SUBTYPE		0x5
+
+struct qcom_pmic_btn_priv {
+	u32 base;
+	u32 status_bit;
+	int code;
+	struct udevice *pmic;
+};
+
+#define PON_INT_RT_STS                        0x10
+#define KPDPWR_ON_INT_BIT                     0
+#define RESIN_ON_INT_BIT                      1
+
+#define NODE_IS_PWRKEY(node) (!strncmp(ofnode_get_name(node), "pwrkey", strlen("pwrkey")))
+#define NODE_IS_RESIN(node) (!strncmp(ofnode_get_name(node), "resin", strlen("resin")))
+
+static enum button_state_t qcom_pwrkey_get_state(struct udevice *dev)
+{
+	struct qcom_pmic_btn_priv *priv = dev_get_priv(dev);
+
+	int reg = pmic_reg_read(priv->pmic, priv->base + PON_INT_RT_STS);
+
+	if (reg < 0)
+		return 0;
+
+	return (reg & BIT(priv->status_bit)) != 0;
+}
+
+static int qcom_pwrkey_get_code(struct udevice *dev)
+{
+	struct qcom_pmic_btn_priv *priv = dev_get_priv(dev);
+
+	return priv->code;
+}
+
+static int qcom_pwrkey_probe(struct udevice *dev)
+{
+	struct button_uc_plat *uc_plat = dev_get_uclass_plat(dev);
+	struct qcom_pmic_btn_priv *priv = dev_get_priv(dev);
+	ofnode node = dev_ofnode(dev);
+	int ret;
+	u64 base;
+
+	/* Ignore the top-level pon node */
+	if (!uc_plat->label)
+		return 0;
+
+	/* the pwrkey and resin nodes are children of the "pon" node, get the
+	 * PMIC device to use in pmic_reg_* calls.
+	 */
+	priv->pmic = dev->parent->parent;
+
+	/* Get the address of the parent pon node */
+	base = dev_read_addr(dev->parent);
+	if (base == FDT_ADDR_T_NONE) {
+		printf("%s: Can't find address\n", dev->name);
+		return -EINVAL;
+	}
+
+	priv->base = base;
+
+	/* Do a sanity check */
+	ret = pmic_reg_read(priv->pmic, priv->base + REG_TYPE);
+	if (ret != 0x1 && ret != 0xb) {
+		printf("%s: unexpected PMIC function type %d\n", dev->name, ret);
+		return -ENXIO;
+	}
+
+	ret = pmic_reg_read(priv->pmic, priv->base + REG_SUBTYPE);
+	if ((ret & 0x7) == 0) {
+		printf("%s: unexpected PMCI function subtype %d\n", dev->name, ret);
+		return -ENXIO;
+	}
+
+	if (NODE_IS_PWRKEY(node)) {
+		priv->status_bit = 0;
+		priv->code = KEY_ENTER;
+	} else if (NODE_IS_RESIN(node)) {
+		priv->status_bit = 1;
+		priv->code = KEY_DOWN;
+	} else {
+		/* Should not get here! */
+		printf("Invalid pon node '%s' should be 'pwrkey' or 'resin'\n",
+		       ofnode_get_name(node));
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int button_qcom_pmic_bind(struct udevice *parent)
+{
+	struct udevice *dev;
+	ofnode node;
+	int ret;
+
+	dev_for_each_subnode(node, parent) {
+		struct button_uc_plat *uc_plat;
+		const char *label;
+
+		if (!ofnode_is_enabled(node))
+			continue;
+
+		ret = device_bind_driver_to_node(parent, "qcom_pwrkey",
+						 ofnode_get_name(node),
+						 node, &dev);
+		if (ret) {
+			printf("Failed to bind %s! %d\n", label, ret);
+			return ret;
+		}
+		uc_plat = dev_get_uclass_plat(dev);
+		if (NODE_IS_PWRKEY(node)) {
+			uc_plat->label = "pwrkey";
+		} else if (NODE_IS_RESIN(node)) {
+			uc_plat->label = "vol_down";
+		} else {
+			printf("Unknown button node '%s' should be 'pwrkey' or 'resin'\n",
+			       ofnode_get_name(node));
+			device_unbind(dev);
+		}
+	}
+
+	return 0;
+}
+
+static const struct button_ops button_qcom_pmic_ops = {
+	.get_state	= qcom_pwrkey_get_state,
+	.get_code	= qcom_pwrkey_get_code,
+};
+
+static const struct udevice_id qcom_pwrkey_ids[] = {
+	{ .compatible = "qcom,pm8916-pon" },
+	{ .compatible = "qcom,pm8941-pon" },
+	{ .compatible = "qcom,pm8998-pon" },
+	{ }
+};
+
+U_BOOT_DRIVER(qcom_pwrkey) = {
+	.name = "qcom_pwrkey",
+	.id = UCLASS_BUTTON,
+	.of_match = qcom_pwrkey_ids,
+	.bind = button_qcom_pmic_bind,
+	.probe = qcom_pwrkey_probe,
+	.ops = &button_qcom_pmic_ops,
+	.priv_auto = sizeof(struct qcom_pmic_btn_priv),
+};

-- 
2.42.1

