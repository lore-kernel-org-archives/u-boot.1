Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A725FE7542B
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 06:41:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9612387458;
	Tue,  3 Oct 2023 08:41:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mEA7fyHX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66D3287281; Tue,  3 Oct 2023 08:41:00 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60D238724B
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 08:40:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-50585357903so637230e87.2
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 23:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696315258; x=1696920058; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wDtpUUYtfQ5U4Ru6oIE+PA3oyci5cweXQOOhYy7Y7eo=;
 b=mEA7fyHX76ITRr2vcoWV6QLkDIr0n5tjojD/R3+jyAQ/scxPPEvSs5u8RhierrznG9
 V3IzmrOg3lc4PBlE60Pc7ogwfVLGHGHkjnaQcLpyBsVhQGnLoAEvhMb5f6iOenGzMR/L
 zNYSNIViuzLfyVdY8rXMCTbBzPEMeuMPuE8tFNfIguaaRVA99PmcGpdVqKlu3HvClW+5
 kB4iGUhpd3BXQkizKwiJ3Ip+3jwl9zwcc9PrrLNY5E+QR9Wy5mg3fJM84wTYcXZKMt1p
 MMDRwSzCgdi+dpzZBLL1HZzLclhg6NGZ9clZuIvV6YCMEK4kcSazdVTtPp5bioX286NH
 n8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696315258; x=1696920058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wDtpUUYtfQ5U4Ru6oIE+PA3oyci5cweXQOOhYy7Y7eo=;
 b=tdYDwoXdA6VYlI37Ai9Fs9hrSStAtI15m7+yJW5OH5PHKsqeBUIKREjy37dgqSiv2m
 YVL5/8xKWXKaSisBLcsuWMKqO+W7fF9UU7yEi4KY0XsY+SxIDCErd7rvJVy6QO8XzHQj
 RWf+BdInFwvH+XItxA8WXX7z1sNqAkIZmQMd8E1mPYwy2bEcVV33/lyRxPVFJ17xGEYd
 fIfaxmJjfQF4q064oawysMabESoNFEhUeY5TXwR/rrTPbm/zNoKBLEXdMlP7Y1K69mS1
 BzdcYnKJg73+1tYpe92hMrC4sPeqzhX7d2SwJ7emLW0vxNq8w6iW2SUpmo9tInuAoBXP
 gNLA==
X-Gm-Message-State: AOJu0YzmpckTA//zmS1MiGOYlO8r9fgbSt6GkAY9zSQeV5CjZ40SnCKQ
 mQRE/DigBSZBRPRx4xksIzU=
X-Google-Smtp-Source: AGHT+IFt1yyH0kDly3gi8VXxxtefiyc29VALnwf5uQIJlAXY/3KbuuYdmzF8mIviLEkVhLI1+Grn+g==
X-Received: by 2002:a05:6512:110f:b0:500:99a9:bc40 with SMTP id
 l15-20020a056512110f00b0050099a9bc40mr13669990lfg.69.1696315257482; 
 Mon, 02 Oct 2023 23:40:57 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 x12-20020ac25dcc000000b004fe202a5c7csm79730lfq.135.2023.10.02.23.40.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 23:40:57 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 5/6] sysreset: implement TPS65910 sysreset functions
Date: Tue,  3 Oct 2023 09:40:41 +0300
Message-Id: <20231003064042.43201-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003064042.43201-1-clamor95@gmail.com>
References: <20231003064042.43201-1-clamor95@gmail.com>
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

