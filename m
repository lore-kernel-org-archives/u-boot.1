Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 025FCC25B47
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 07:50:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF501875AF;
	Tue, 24 Oct 2023 09:49:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YYaGZ3fw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D29E687141; Tue, 24 Oct 2023 09:49:34 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBF0087182
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 09:49:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-507d7b73b74so6055988e87.3
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 00:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698133768; x=1698738568; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wDtpUUYtfQ5U4Ru6oIE+PA3oyci5cweXQOOhYy7Y7eo=;
 b=YYaGZ3fwvL7E/mqW+EvHSHvdJmDxzGP2R/t/T6RWuHJUhJXhUdnao986JICO2jl3cR
 S0e4w7W1j4QetHbZcVHT+NagmIYN5sT25Y28JUHW+XAM50BcnSSIxRxhdXNBEGVsyYGu
 vXDiEsL7vKedNdNRoYwsrAP7WTLGP0i7Io42o0VdOI3g6sLeqJkAVfLauXld9auf8DLY
 E1S9BNIqW6v6eDXlgWd0ZJNmv9cDcd/fh7dYwuaZVtdF6O7Ai1B82nsY+mskH0+b5e/7
 fXWB1agn73ALKXaATHTifAm+PC6jF8YNqc8ajgLkqnf6OSoL9U8YbvxO+lFQulWBDv7a
 ySYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698133768; x=1698738568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wDtpUUYtfQ5U4Ru6oIE+PA3oyci5cweXQOOhYy7Y7eo=;
 b=oQqDGqS9hIQ/J7rJJLAGcGf7LSc42K4qf/I9RlzL079a6Y/ZX7mhxCdK/JrG6V1tNh
 9NDy4+bre8hQ9MtkGhvgS3TTBFiWNhfWF+U6mD3fo5g+Bgt1ZE39KMukCP8n9bbgF5d0
 U6zqFxiLpFba7XPxPn1/UkLxuoeLoqPvHClfbJvCpxqbtHtQgPSNYVh2Rv8ahAyEoU80
 4GkCZxuDdWGGK/DZYy1/GiZ5N73B8Y8LosrkNlQMarTVuY5xH6yv8jFxnTgesGACN6X6
 DcPH/oXN4AeQTTGEm1yCYPDO0/cScaASmqTPINeKtUywZApn7aHZ8kksH4HokkD7GUY5
 vtiw==
X-Gm-Message-State: AOJu0YyhWuvUkXsf3jms2wlg8nPaMD9/V4TKOMIiy7TfMCxRE2pEb8Gx
 w1gq2InI7wH2t0KLWImNlGg=
X-Google-Smtp-Source: AGHT+IHVGwwtHOAO1GIUsDhYMuxxhF2VostU8i6jH3m73ltAN05gWRY8o49DKm6JO+usYDaivlsV1g==
X-Received: by 2002:a05:6512:4019:b0:507:a620:6b96 with SMTP id
 br25-20020a056512401900b00507a6206b96mr9989084lfb.57.1698133768049; 
 Tue, 24 Oct 2023 00:49:28 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 v25-20020ac25939000000b00507a89ef9bbsm2011741lfi.166.2023.10.24.00.49.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 00:49:27 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v4 5/6] sysreset: implement TPS65910 sysreset functions
Date: Tue, 24 Oct 2023 10:49:07 +0300
Message-Id: <20231024074908.199903-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231024074908.199903-1-clamor95@gmail.com>
References: <20231024074908.199903-1-clamor95@gmail.com>
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

TPS65910/TPS65911 PMICs have embedded power control functions
used by some device to initiane device power off. Implement it as
sysreset driver.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/power/pmic/pmic_tps65910_dm.c | 12 +++++-
 drivers/sysreset/Kconfig              |  8 ++++
 drivers/sysreset/Makefile             |  1 +
 drivers/sysreset/sysreset_tps65910.c  | 55 +++++++++++++++++++++++++++
 include/power/tps65910_pmic.h         |  7 ++++
 5 files changed, 82 insertions(+), 1 deletion(-)
 create mode 100644 drivers/sysreset/sysreset_tps65910.c

diff --git a/drivers/power/pmic/pmic_tps65910_dm.c b/drivers/power/pmic/pmic_tps65910_dm.c
index 0a4911cef6..ecf836eb0e 100644
--- a/drivers/power/pmic/pmic_tps65910_dm.c
+++ b/drivers/power/pmic/pmic_tps65910_dm.c
@@ -5,6 +5,7 @@
 
 #include <common.h>
 #include <dm.h>
+#include <dm/lists.h>
 #include <i2c.h>
 #include <log.h>
 #include <linux/printk.h>
@@ -59,7 +60,16 @@ static int pmic_tps65910_bind(struct udevice *dev)
 	const struct pmic_child_info *tps6591x_children_info =
 			(struct pmic_child_info *)dev_get_driver_data(dev);
 	ofnode regulators_node;
-	int children;
+	int children, ret;
+
+	if (IS_ENABLED(CONFIG_SYSRESET_TPS65910)) {
+		ret = device_bind_driver(dev, TPS65910_RST_DRIVER,
+					 "sysreset", NULL);
+		if (ret) {
+			log_err("cannot bind SYSRESET (ret = %d)\n", ret);
+			return ret;
+		}
+	}
 
 	regulators_node = dev_read_subnode(dev, "regulators");
 	if (!ofnode_valid(regulators_node)) {
diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
index cdb4ae2bb1..659170d156 100644
--- a/drivers/sysreset/Kconfig
+++ b/drivers/sysreset/Kconfig
@@ -157,6 +157,14 @@ config SYSRESET_TI_SCI
 	  This enables the system reset driver support over TI System Control
 	  Interface available on some new TI's SoCs.
 
+config SYSRESET_TPS65910
+	bool "Enable support for TPS65910/TPS65911 PMIC System Reset"
+	depends on DM_PMIC_TPS65910
+	select SYSRESET_CMD_POWEROFF if CMD_POWEROFF
+	help
+	  Enable system power management functions found in TPS65910/TPS65911
+	  PMICs.
+
 config SYSRESET_TPS80031
 	bool "Enable support for TPS80031/TPS80032 PMIC System Reset"
 	depends on DM_PMIC_TPS80031
diff --git a/drivers/sysreset/Makefile b/drivers/sysreset/Makefile
index f62db899da..0d96a204a9 100644
--- a/drivers/sysreset/Makefile
+++ b/drivers/sysreset/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_SYSRESET_SOCFPGA) += sysreset_socfpga.o
 obj-$(CONFIG_SYSRESET_SOCFPGA_SOC64) += sysreset_socfpga_soc64.o
 obj-$(CONFIG_SYSRESET_TEGRA) += sysreset_tegra.o
 obj-$(CONFIG_SYSRESET_TI_SCI) += sysreset-ti-sci.o
+obj-$(CONFIG_$(SPL_TPL_)SYSRESET_TPS65910) += sysreset_tps65910.o
 obj-$(CONFIG_$(SPL_TPL_)SYSRESET_TPS80031) += sysreset_tps80031.o
 obj-$(CONFIG_SYSRESET_SYSCON) += sysreset_syscon.o
 obj-$(CONFIG_SYSRESET_WATCHDOG) += sysreset_watchdog.o
diff --git a/drivers/sysreset/sysreset_tps65910.c b/drivers/sysreset/sysreset_tps65910.c
new file mode 100644
index 0000000000..1a362dea0d
--- /dev/null
+++ b/drivers/sysreset/sysreset_tps65910.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  Copyright(C) 2023 Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#include <common.h>
+#include <dm.h>
+#include <i2c.h>
+#include <errno.h>
+#include <sysreset.h>
+#include <power/pmic.h>
+#include <power/tps65910_pmic.h>
+
+static int tps65910_sysreset_request(struct udevice *dev,
+				     enum sysreset_t type)
+{
+	int val;
+
+	val = pmic_reg_read(dev->parent, TPS65910_REG_DEVICE_CTRL);
+	if (val < 0)
+		return val;
+
+	/* define power-off to be sequential */
+	val |= PWR_OFF_SEQ;
+	pmic_reg_write(dev->parent, TPS65910_REG_DEVICE_CTRL, val);
+
+	val &= ~DEV_ON;
+
+	switch (type) {
+	case SYSRESET_POWER:
+		/* TPS65910: DEV_OFF_RST > DEVICE_CTRL */
+		pmic_reg_write(dev->parent, TPS65910_REG_DEVICE_CTRL,
+			       val | DEV_OFF_RST);
+		break;
+	case SYSRESET_POWER_OFF:
+		/* TPS65910: DEV_OFF > DEVICE_CTRL */
+		pmic_reg_write(dev->parent, TPS65910_REG_DEVICE_CTRL,
+			       val | DEV_OFF);
+		break;
+	default:
+		return -EPROTONOSUPPORT;
+	}
+
+	return -EINPROGRESS;
+}
+
+static struct sysreset_ops tps65910_sysreset = {
+	.request = tps65910_sysreset_request,
+};
+
+U_BOOT_DRIVER(sysreset_tps65910) = {
+	.id	= UCLASS_SYSRESET,
+	.name	= TPS65910_RST_DRIVER,
+	.ops	= &tps65910_sysreset,
+};
diff --git a/include/power/tps65910_pmic.h b/include/power/tps65910_pmic.h
index 7d6545abdf..2026ec2f42 100644
--- a/include/power/tps65910_pmic.h
+++ b/include/power/tps65910_pmic.h
@@ -17,6 +17,12 @@
 #define TPS65910_SUPPLY_STATE_OFF	0x0
 #define TPS65910_SUPPLY_STATE_ON	0x1
 
+/* TPS65910 DEVICE_CTRL bits */
+#define   PWR_OFF_SEQ			BIT(7)
+#define   DEV_OFF_RST			BIT(3)
+#define   DEV_ON			BIT(2)
+#define   DEV_OFF			BIT(0)
+
 /* i2c registers */
 enum {
 	TPS65910_REG_RTC_SEC			= 0x00,
@@ -125,6 +131,7 @@ struct tps65910_regulator_pdata {
 #define TPS65910_BUCK_DRIVER	"tps65910_buck"
 #define TPS65910_BOOST_DRIVER	"tps65910_boost"
 #define TPS65910_LDO_DRIVER	"tps65910_ldo"
+#define TPS65910_RST_DRIVER	"tps65910_rst"
 
 /* tps65911 i2c registers */
 enum {
-- 
2.39.2

