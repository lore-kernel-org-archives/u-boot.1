Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83978C36011
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 09:45:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C536681F59;
	Sun, 30 Mar 2025 11:45:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IWfpAB9x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 203F281E72; Sun, 30 Mar 2025 11:45:40 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E789081E5A
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 11:45:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ac28e66c0e1so521246566b.0
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 02:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743327934; x=1743932734; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PehGZ7J9XJAbE3BoOdn+WUwzx08M4RWQ+0T8POJkTZY=;
 b=IWfpAB9x9DujdAf3ycgj+WZv85JbCyw2KjV5u5c69CpyqLIcbuKeZbZeuq7w+RM/zc
 7qd49hOjFeJ6RlM6nM9omvc6IEPZfuZll2ke86tLxBxM1LkhVkNeGOpviE7ylFZjMYXu
 yGOt3/kA8RjmlPKO2w8lTXGimilgA/n9IzKrl/6K8niAJ2LiolQhnd8WX1CK4Tf+4LUF
 1Vc8DPTcYjlVYgqZ1STkEWZtGOfjk/jxzjY9gZsjKoIUch80bsKCWYd4O/iAfRtaeI3q
 6LmpswAALUWfSPV1+TPjVRgdbBn8enwCMpxwS2SDBPT1B8zNS9rqa1YEw5b4FU1Cv9O9
 Li/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743327934; x=1743932734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PehGZ7J9XJAbE3BoOdn+WUwzx08M4RWQ+0T8POJkTZY=;
 b=YSfbe062NdW/yTFoj8X2M6lnTW5D5TwL3cQeoxKIJm7LMqeJp6hVAJhH04n44JL6IJ
 DoRcG+AzS52L37UELANrOQmg6coXHSsqVGOii+PjRC58z5aoDxKTx9U0vXQYbHx6s3tp
 avL0m7f3U3zPvP5kaqfBGz70gvMYxW0dwKaApUYfiaeywiGdEoienTIQ2RlC8uBMlUgD
 OCCnbEk/dyxGdP+fsCrrd47hh/e/ndtNuMLQxuG6SLrtQdRm4ysckbh7gnGEadhQyRAe
 dALdZ+tzhDBXaj2SmKQeRBC9E2CgdG4QrzuMn0Fup96QFy7F0zfYEiSZoEgkc/u+XIFm
 sz4Q==
X-Gm-Message-State: AOJu0YxZV5wYB5zs2SbYdh68ncNT8ANdisO4oSvsROztLupOsupsbCl8
 BC1vNcAFiQN1KhrWkUinPdFGcPnlb3yUZ5xb33ROioFiIQIhP2s9
X-Gm-Gg: ASbGncsNj9JYzxDHKRBrC9ulZyPVeAmirHRHrOmkF9PHMgumIOJf2a2gm7rZymWZeN4
 Vr6KU97lboMMLr1xuD6RUl6yjM5513s426P1gvAgNB6V0pDNs9wXF00qpqQ65prZUr75pSn5X3R
 YjwgrHsj2iqdTPv5l5hufI8m2CpIbS42Jz16+7D1p4wklE3lQQ2pNqPbv4e/FfBwe74VYTrQLIP
 UNteJHfVughla4/VIeJ8/JU9wbGbSP0vQRG44XhkK0/wCFcdjLD87A0NWJNTX7zf/BZ3+StY7dP
 ZRHx+vzOJPuwpwhohQwKpwpOOEHFkiyCViUc
X-Google-Smtp-Source: AGHT+IGAIhN0uYdCM5guqMdxv2JO7OlPSBq6rWpjgML4eziFi4Y01LudOf2oHPgo+51WskkhqED/+g==
X-Received: by 2002:a17:907:c1b:b0:ac3:48e4:f8bb with SMTP id
 a640c23a62f3a-ac738be3d13mr430130366b.41.1743327934146; 
 Sun, 30 Mar 2025 02:45:34 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac71927b175sm463235866b.61.2025.03.30.02.45.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Mar 2025 02:45:33 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 Sumit Garg <sumit.garg@kernel.org>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Fabio Estevam <festevam@denx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Peter Geis <pgwipeout@gmail.com>, Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Anton Bambura <jenneron@protonmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 3/6] input: add support for CPCAP power button
Date: Sun, 30 Mar 2025 12:45:09 +0300
Message-ID: <20250330094515.11359-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250330094515.11359-1-clamor95@gmail.com>
References: <20250330094515.11359-1-clamor95@gmail.com>
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

CPCAP has a dedicated interrupt for power button. Implement this to have
more input control over the devices.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/input/Kconfig           |   6 ++
 drivers/input/Makefile          |   1 +
 drivers/input/cpcap_pwrbutton.c | 134 ++++++++++++++++++++++++++++++++
 3 files changed, 141 insertions(+)
 create mode 100644 drivers/input/cpcap_pwrbutton.c

diff --git a/drivers/input/Kconfig b/drivers/input/Kconfig
index c2b365af11d..c09f0ae795e 100644
--- a/drivers/input/Kconfig
+++ b/drivers/input/Kconfig
@@ -55,6 +55,12 @@ config BUTTON_KEYBOARD
 	  dt node to define button-event mapping.
 	  For example, an arrows and enter may be implemented to navigate boot menu.
 
+config CPCAP_POWER_BUTTON
+	bool "Enable power button of CPCAP PMIC support"
+	depends on DM_KEYBOARD && DM_PMIC_CPCAP
+	help
+	  Enable support for a dedicated power button of the CPCAP PMIC.
+
 config CROS_EC_KEYB
 	bool "Enable Chrome OS EC keyboard support"
 	depends on INPUT
diff --git a/drivers/input/Makefile b/drivers/input/Makefile
index 8d4107b8848..1303fcdb0b7 100644
--- a/drivers/input/Makefile
+++ b/drivers/input/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_$(PHASE_)CROS_EC_KEYB) += cros_ec_keyb.o
 obj-$(CONFIG_$(PHASE_)OF_CONTROL) += key_matrix.o
 obj-$(CONFIG_$(PHASE_)DM_KEYBOARD) += input.o keyboard-uclass.o
 obj-$(CONFIG_BUTTON_KEYBOARD) += button_kbd.o
+obj-$(CONFIG_CPCAP_POWER_BUTTON) += cpcap_pwrbutton.o
 
 ifndef CONFIG_XPL_BUILD
 
diff --git a/drivers/input/cpcap_pwrbutton.c b/drivers/input/cpcap_pwrbutton.c
new file mode 100644
index 00000000000..c8ad39d33ca
--- /dev/null
+++ b/drivers/input/cpcap_pwrbutton.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  Copyright(C) 2025 Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#include <stdlib.h>
+#include <dm.h>
+#include <input.h>
+#include <keyboard.h>
+#include <power/pmic.h>
+#include <power/cpcap.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/input.h>
+
+static const unsigned int cpcpap_to_reg[] = {
+	CPCAP_REG_INT1,
+	CPCAP_REG_INT2,
+	CPCAP_REG_INT3,
+	CPCAP_REG_INT4,
+};
+
+/**
+ * struct cpcap_pwrbutton_priv
+ *
+ * @bank: id of interrupt bank co-responding to an IRQ register
+ * @id: id of interrupt pin co-responding to the bit in IRQ register
+ * @keycode: linux key code
+ * @old_state: holder of last button state
+ * @skip: holder of keycode skip state. This is required since both pressing
+ *        and releasing generate same event and cause key send duplication.
+ */
+struct cpcap_pwrbutton_priv {
+	u32 bank;
+	u32 id;
+
+	u32 keycode;
+
+	bool old_state;
+	bool skip;
+};
+
+static int cpcap_pwrbutton_read_keys(struct input_config *input)
+{
+	struct udevice *dev = input->dev;
+	struct cpcap_pwrbutton_priv *priv = dev_get_priv(dev);
+	u32 value, state_changed;
+	bool state;
+
+	value = pmic_reg_read(dev->parent, cpcpap_to_reg[priv->bank]) &
+			      BIT(priv->id);
+
+	/* Interrupt bit is cleared by writing it to interrupt reg */
+	pmic_reg_write(dev->parent, cpcpap_to_reg[priv->bank], BIT(priv->id));
+
+	state = value >> priv->id;
+	state_changed = state != priv->old_state;
+
+	if (state_changed && !priv->skip) {
+		priv->old_state = state;
+		input_add_keycode(input, priv->keycode, state);
+	}
+
+	if (state)
+		priv->skip = !priv->skip;
+
+	return 0;
+}
+
+static int cpcap_pwrbutton_of_to_plat(struct udevice *dev)
+{
+	struct cpcap_pwrbutton_priv *priv = dev_get_priv(dev);
+	ofnode irq_parent;
+	u32 irq_desc;
+	int ret;
+
+	/* Check interrupt parent, driver supports only CPCAP as parent */
+	irq_parent = ofnode_parse_phandle(dev_ofnode(dev), "interrupt-parent", 0);
+	if (!ofnode_device_is_compatible(irq_parent, "motorola,cpcap"))
+		return -EINVAL;
+
+	ret = dev_read_u32(dev, "interrupts", &irq_desc);
+	if (ret)
+		return ret;
+
+	/* IRQ registers are 16 bit wide */
+	priv->bank = irq_desc / 16;
+	priv->id = irq_desc % 16;
+
+	ret = dev_read_u32(dev, "linux,code", &priv->keycode);
+	if (ret)
+		return ret;
+
+	priv->old_state = false;
+	priv->skip = false;
+	return 0;
+}
+
+static int cpcap_pwrbutton_probe(struct udevice *dev)
+{
+	struct keyboard_priv *uc_priv = dev_get_uclass_priv(dev);
+	struct stdio_dev *sdev = &uc_priv->sdev;
+	struct input_config *input = &uc_priv->input;
+	int ret;
+
+	input_init(input, false);
+	input_add_tables(input, false);
+
+	/* Register the device */
+	input->dev = dev;
+	input->read_keys = cpcap_pwrbutton_read_keys;
+	strcpy(sdev->name, "cpcap-pwrbutton");
+	ret = input_stdio_register(sdev);
+	if (ret) {
+		log_debug("%s: input_stdio_register() failed\n", __func__);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct udevice_id cpcap_pwrbutton_ids[] = {
+	{ .compatible = "motorola,cpcap-pwrbutton" },
+	{ }
+};
+
+U_BOOT_DRIVER(cpcap_pwrbutton) = {
+	.name		= "cpcap_pwrbutton",
+	.id		= UCLASS_KEYBOARD,
+	.of_match	= cpcap_pwrbutton_ids,
+	.of_to_plat	= cpcap_pwrbutton_of_to_plat,
+	.probe		= cpcap_pwrbutton_probe,
+	.priv_auto	= sizeof(struct cpcap_pwrbutton_priv),
+};
-- 
2.43.0

