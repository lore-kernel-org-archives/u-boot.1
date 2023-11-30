Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54248C4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 20:14:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 242A5875FE;
	Thu, 30 Nov 2023 21:14:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tlm8eNwv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DC50876C2; Thu, 30 Nov 2023 21:14:00 +0100 (CET)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D34AA8757B
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 21:13:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-58a7d13b00bso776110eaf.1
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 12:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701375236; x=1701980036; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kvk1SlQL6OnKuY6/TY15o9HNW/wvtBYCQKSY7DZLrhs=;
 b=tlm8eNwvZVltOO5I+YzTgcZq8F6bLwFRLdT7jNzTZJ1Do8IlSJ+Wu+NzKVAzJPDP60
 C4UfdAJz2UXiVKF4OorM3ooAMA/TPV2fP32AdlOZRcKo6RtZdG92+HIqkfilcw3flHqi
 ILrx3PudDuNf4WdfNPMuCjRe0EsoFM2J4Q3ICigUdJbqhyp9DDimTFxqZBQEYKeArglf
 ntPh+/Tau9BOHN0hXZQU6+HjuRP47jsm2AtvUTQ8oRitMWQhw6syuYi4kxmyllNJ85ft
 Ppqinr1qhKdOKSI+XebOiBKGqou79Qi8dSIHOOkOfz+NSBMngfURdwZYZGFM63JucXaZ
 FsyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701375236; x=1701980036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kvk1SlQL6OnKuY6/TY15o9HNW/wvtBYCQKSY7DZLrhs=;
 b=WkwSXfcmLSxLksKqa798n14GwtxMfqS7726pruKGRhBgSvkx7LfZOAOASIFKJuX8BP
 EUW5gXTFBXCV0SgwSw6/bmITe64mgxfCCSU+BkpEuUF40pO4Rl4LGq1sdueE0xicDWGT
 3mOlvmjhrtROnzAPUTOO6BkBDWaY6BT6MLP8eQUtavG088FZRLF/0ekzit2VCiwhawp4
 SaQMBE0OqLioza8SE2Oeu8JELIouf6fwcqtbGCLGimlVxL8DjvXCFDy5Po85ffv2kU0z
 SZ/FT/FUqf8LwykcTlwZr5LrrAUt8udvmU3spvavAbDD4rUx+S/3wpIUmsWIf789vmGA
 2XtA==
X-Gm-Message-State: AOJu0YxrH84C5fF9Zaa0us+Fbpy+COxqjONZBtQDAT9WXH/9O6Qp7fBx
 ePGzdDK5oyfLPleNPKEFD746XQ==
X-Google-Smtp-Source: AGHT+IGv8BRlxmJiDwVFo+X//AgSqeUwfGiBRDWpYLibES9HnMuAs/Z4dMiDjgKc54yvlqxv45Z2LQ==
X-Received: by 2002:a4a:761d:0:b0:57b:6c85:972 with SMTP id
 t29-20020a4a761d000000b0057b6c850972mr655636ooc.0.1701375236216; 
 Thu, 30 Nov 2023 12:13:56 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 k29-20020a4a851d000000b0058cbbf9b4e4sm295456ooh.48.2023.11.30.12.13.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 12:13:55 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <promsoft@gmail.com>,
	Tom Rini <trini@konsulko.com>
Cc: Andre Przywara <andre.przywara@arm.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: [PATCH 4/7] pinctrl: exynos: Support different register types in pin
 banks
Date: Thu, 30 Nov 2023 14:13:49 -0600
Message-Id: <20231130201352.6379-5-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231130201352.6379-1-semen.protsenko@linaro.org>
References: <20231130201352.6379-1-semen.protsenko@linaro.org>
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

Get rid of hard-coded register offsets and widths. Instead provide a way
for pinctrl drivers to specify different pin bank register offsets and
widths. This in turn makes it possible to add support for new SoCs that
have registers with offset/width values different than generic ones
already available in pinctrl-exynos driver.

Offset constants (now unused in pinctrl-exynos.c) are moved to
pinctrl-exynos7420 driver, which is the single user of those constants.

The design of this patch follows Linux kernel pinctrl-exynos driver
design, in terms of added data structures and types. This patch doesn't
add support for any new SoCs and shouldn't introduce any functional
changes.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/pinctrl/exynos/pinctrl-exynos.c     | 42 ++++++++++++++-------
 drivers/pinctrl/exynos/pinctrl-exynos.h     | 34 +++++++++++++++--
 drivers/pinctrl/exynos/pinctrl-exynos7420.c |  2 +
 3 files changed, 61 insertions(+), 17 deletions(-)

diff --git a/drivers/pinctrl/exynos/pinctrl-exynos.c b/drivers/pinctrl/exynos/pinctrl-exynos.c
index d908927135b6..9a51653be864 100644
--- a/drivers/pinctrl/exynos/pinctrl-exynos.c
+++ b/drivers/pinctrl/exynos/pinctrl-exynos.c
@@ -15,6 +15,12 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+/* CON, DAT, PUD, DRV */
+const struct samsung_pin_bank_type bank_type_alive = {
+	.fld_width = { 4, 1, 2, 2, },
+	.reg_offset = { 0x00, 0x04, 0x08, 0x0c, },
+};
+
 /**
  * exynos_pinctrl_setup_peri: setup pinctrl for a peripheral.
  * conf: soc specific pin configuration data array
@@ -81,6 +87,22 @@ static const struct samsung_pin_bank_data *get_bank(struct udevice *dev,
 	return NULL;
 }
 
+static void exynos_pinctrl_set_pincfg(unsigned long reg_base, u32 pin_num,
+				      u32 val, enum pincfg_type pincfg,
+				      const struct samsung_pin_bank_type *type)
+{
+	u32 width = type->fld_width[pincfg];
+	u32 reg_offset = type->reg_offset[pincfg];
+	u32 mask = (1 << width) - 1;
+	u32 shift = pin_num * width;
+	u32 data;
+
+	data = readl(reg_base + reg_offset);
+	data &= ~(mask << shift);
+	data |= val << shift;
+	writel(data, reg_base + reg_offset);
+}
+
 /**
  * exynos_pinctrl_set_state: configure a pin state.
  * dev: the pinctrl device to be configured.
@@ -93,7 +115,7 @@ int exynos_pinctrl_set_state(struct udevice *dev, struct udevice *config)
 	int node = dev_of_offset(config);
 	unsigned int count, idx, pin_num;
 	unsigned int pinfunc, pinpud, pindrv;
-	unsigned long reg, value;
+	unsigned long reg;
 	const char *name;
 
 	/*
@@ -120,24 +142,18 @@ int exynos_pinctrl_set_state(struct udevice *dev, struct udevice *config)
 		reg = priv->base + bank->offset;
 
 		if (pinfunc != -1) {
-			value = readl(reg + PIN_CON);
-			value &= ~(0xf << (pin_num << 2));
-			value |= (pinfunc << (pin_num << 2));
-			writel(value, reg + PIN_CON);
+			exynos_pinctrl_set_pincfg(reg, pin_num, pinfunc,
+						  PINCFG_TYPE_FUNC, bank->type);
 		}
 
 		if (pinpud != -1) {
-			value = readl(reg + PIN_PUD);
-			value &= ~(0x3 << (pin_num << 1));
-			value |= (pinpud << (pin_num << 1));
-			writel(value, reg + PIN_PUD);
+			exynos_pinctrl_set_pincfg(reg, pin_num, pinpud,
+						  PINCFG_TYPE_PUD, bank->type);
 		}
 
 		if (pindrv != -1) {
-			value = readl(reg + PIN_DRV);
-			value &= ~(0x3 << (pin_num << 1));
-			value |= (pindrv << (pin_num << 1));
-			writel(value, reg + PIN_DRV);
+			exynos_pinctrl_set_pincfg(reg, pin_num, pindrv,
+						  PINCFG_TYPE_DRV, bank->type);
 		}
 	}
 
diff --git a/drivers/pinctrl/exynos/pinctrl-exynos.h b/drivers/pinctrl/exynos/pinctrl-exynos.h
index 6b19f196bc3a..743bb5573091 100644
--- a/drivers/pinctrl/exynos/pinctrl-exynos.h
+++ b/drivers/pinctrl/exynos/pinctrl-exynos.h
@@ -8,25 +8,51 @@
 #ifndef __PINCTRL_EXYNOS_H_
 #define __PINCTRL_EXYNOS_H_
 
-#define PIN_CON		0x00	/* Offset of pin function register */
-#define PIN_DAT		0x04	/* Offset of pin data register */
-#define PIN_PUD		0x08	/* Offset of pin pull up/down config register */
-#define PIN_DRV		0x0C	/* Offset of pin drive strength register */
+/**
+ * enum pincfg_type - possible pin configuration types supported.
+ * @PINCFG_TYPE_FUNC: Function configuration.
+ * @PINCFG_TYPE_DAT: Pin value configuration.
+ * @PINCFG_TYPE_PUD: Pull up/down configuration.
+ * @PINCFG_TYPE_DRV: Drive strength configuration.
+ */
+enum pincfg_type {
+	PINCFG_TYPE_FUNC,
+	PINCFG_TYPE_DAT,
+	PINCFG_TYPE_PUD,
+	PINCFG_TYPE_DRV,
+
+	PINCFG_TYPE_NUM
+};
+
+/**
+ * struct samsung_pin_bank_type: pin bank type description
+ * @fld_width: widths of configuration bitfields (0 if unavailable)
+ * @reg_offset: offsets of configuration registers (don't care of width is 0)
+ */
+struct samsung_pin_bank_type {
+	u8 fld_width[PINCFG_TYPE_NUM];
+	u8 reg_offset[PINCFG_TYPE_NUM];
+};
 
 /**
  * struct samsung_pin_bank_data: represent a controller pin-bank data.
+ * @type: type of the bank (register offsets and bitfield widths)
  * @offset: starting offset of the pin-bank registers.
  * @nr_pins: number of pins included in this bank.
  * @name: name to be prefixed for each pin in this pin bank.
  */
 struct samsung_pin_bank_data {
+	const struct samsung_pin_bank_type *type;
 	u32		offset;
 	u8		nr_pins;
 	const char	*name;
 };
 
+extern const struct samsung_pin_bank_type bank_type_alive;
+
 #define EXYNOS_PIN_BANK(pins, reg, id)			\
 	{						\
+		.type		= &bank_type_alive,	\
 		.offset		= reg,			\
 		.nr_pins	= pins,			\
 		.name		= id			\
diff --git a/drivers/pinctrl/exynos/pinctrl-exynos7420.c b/drivers/pinctrl/exynos/pinctrl-exynos7420.c
index 07870b7f51a5..77d510d8f600 100644
--- a/drivers/pinctrl/exynos/pinctrl-exynos7420.c
+++ b/drivers/pinctrl/exynos/pinctrl-exynos7420.c
@@ -16,6 +16,8 @@
 #include "pinctrl-exynos.h"
 
 #define	GPD1_OFFSET	0xc0
+#define PIN_CON		0x00	/* Offset of pin function register */
+#define PIN_PUD		0x08	/* Offset of pin pull up/down config register */
 
 static struct exynos_pinctrl_config_data serial2_conf[] = {
 	{
-- 
2.39.2

