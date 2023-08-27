Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB0BC83F01
	for <u-boot@archiver.kernel.org>; Sun, 27 Aug 2023 08:22:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C68C852DB;
	Sun, 27 Aug 2023 10:21:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jrlQSZRz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5DD484B20; Sun, 27 Aug 2023 10:21:34 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEEF1852DB
 for <u-boot@lists.denx.de>; Sun, 27 Aug 2023 10:21:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-99c3d3c3db9so281635666b.3
 for <u-boot@lists.denx.de>; Sun, 27 Aug 2023 01:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693124490; x=1693729290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V0s7IluXy0RtCLJccliKO61miFWonYR4B66GnTJxdGc=;
 b=jrlQSZRzaRCZoN7suve3sc4budcxdARRV8699/DlGWch1HkmiBFZ9levYYemlAKc9G
 +UQX60KF9x30hWdfVZ8VYhHwQMqf2ixnt+mjRiKkaKA8DQ/67Qm2vqQo0rhsECrdC3gM
 N3lk3+Xtk2csxE0SU54izKX897iccCUQAtDC9UCDfhjqZ06nC+tPYDH/U2BnFs5xn54t
 yXwZqka0QwpLXcvMLnRqICaNChtw03PRN96ovxNBs7/7hm+jghxrI3oBmicvQnmHmqpG
 A+qqnH9nl29QclsavhjfbyVUSe+OvY3s1uM4gxdx03oBd4DlA4WpUepcAZzV5s58GMrW
 SiPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693124490; x=1693729290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V0s7IluXy0RtCLJccliKO61miFWonYR4B66GnTJxdGc=;
 b=aoX8uAlMkKec2+rUesApjtfBS5yeCxsxaWp2LhG+fh5Mp5w4Nid3sqFQE81+63Rhwv
 loJzB/lkDQZIPekDPTU3q35CUYrirKfqkmHHToREHf0v/qCDokB74/6jswsrckBNvWBf
 iUn7Fb0w7Kf5kaOR1xdXndytU5gaTW0I+0fFKJANgZxKvWFTzdHTXDOPQRkzqudPRePo
 yHJ3Wz5eOXrhhOb1FNn1EayhTBJdNbU5Tgva8v/s0mLwurphoKV80WfbjuX3cgNzbRe7
 Cwsd0C2yutaHevSth6zAalN+GQ+s62D9kevF9+I0lT7MzyR7y00vj+0OzbG64JVkGapA
 /nsA==
X-Gm-Message-State: AOJu0YxHYOK9a27gUgIzXj0M/1eedtt0lXnX15SR+a2H+zg/qX6sk57K
 pz4t6msVtej/cJcCsc2rLB4=
X-Google-Smtp-Source: AGHT+IFHEFiHFwEXjuSScc/PaRQUbKdPhwR1xFXz1hIfUqxdch/7A3/Ar1Fp7s6KymI2NWXW+muspw==
X-Received: by 2002:a17:906:76d0:b0:9a1:bd82:de1c with SMTP id
 q16-20020a17090676d000b009a1bd82de1cmr11212930ejn.41.1693124490224; 
 Sun, 27 Aug 2023 01:21:30 -0700 (PDT)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 i10-20020a170906250a00b0099b5a71b0bfsm3153433ejb.94.2023.08.27.01.21.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Aug 2023 01:21:29 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 3/6] sysreset: implement MAX77663 sysreset functions
Date: Sun, 27 Aug 2023 11:21:03 +0300
Message-Id: <20230827082106.6255-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230827082106.6255-1-clamor95@gmail.com>
References: <20230827082106.6255-1-clamor95@gmail.com>
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

MAX77663 PMIC has embedded poweroff function used by some
device to initiane device power off. Implement it as sysreset
driver.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/power/pmic/max77663.c        | 12 ++++++-
 drivers/sysreset/Kconfig             |  7 ++++
 drivers/sysreset/Makefile            |  1 +
 drivers/sysreset/sysreset_max77663.c | 53 ++++++++++++++++++++++++++++
 include/power/max77663.h             |  5 +++
 5 files changed, 77 insertions(+), 1 deletion(-)
 create mode 100644 drivers/sysreset/sysreset_max77663.c

diff --git a/drivers/power/pmic/max77663.c b/drivers/power/pmic/max77663.c
index 4070235d3c..e333c8dcf5 100644
--- a/drivers/power/pmic/max77663.c
+++ b/drivers/power/pmic/max77663.c
@@ -9,6 +9,7 @@
 #include <dm.h>
 #include <i2c.h>
 #include <log.h>
+#include <dm/lists.h>
 #include <power/pmic.h>
 #include <power/regulator.h>
 #include <power/max77663.h>
@@ -49,7 +50,16 @@ static int max77663_read(struct udevice *dev, uint reg, uint8_t *buff, int len)
 static int max77663_bind(struct udevice *dev)
 {
 	ofnode regulators_node;
-	int children;
+	int children, ret;
+
+	if (IS_ENABLED(CONFIG_SYSRESET_MAX77663)) {
+		ret = device_bind_driver(dev, MAX77663_RST_DRIVER,
+					 "sysreset", NULL);
+		if (ret) {
+			log_err("cannot bind SYSRESET (ret = %d)\n", ret);
+			return ret;
+		}
+	}
 
 	regulators_node = dev_read_subnode(dev, "regulators");
 	if (!ofnode_valid(regulators_node)) {
diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
index eab556c349..bc35896101 100644
--- a/drivers/sysreset/Kconfig
+++ b/drivers/sysreset/Kconfig
@@ -74,6 +74,13 @@ config SYSRESET_GPIO
 	  example on Microblaze where reset logic can be controlled via GPIO
 	  pin which triggers cpu reset.
 
+config SYSRESET_MAX77663
+	bool "Enable support for MAX77663 PMIC System Reset"
+	depends on DM_PMIC_MAX77663
+	select SYSRESET_CMD_POWEROFF if CMD_POWEROFF
+	help
+	  Enable system power management functions found in MAX77663 PMIC.
+
 config SYSRESET_MICROBLAZE
 	bool "Enable support for Microblaze soft reset"
 	depends on MICROBLAZE
diff --git a/drivers/sysreset/Makefile b/drivers/sysreset/Makefile
index a9ac123754..c31f51c581 100644
--- a/drivers/sysreset/Makefile
+++ b/drivers/sysreset/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_ARCH_STI) += sysreset_sti.o
 obj-$(CONFIG_SANDBOX) += sysreset_sandbox.o
 obj-$(CONFIG_POWEROFF_GPIO) += poweroff_gpio.o
 obj-$(CONFIG_SYSRESET_GPIO) += sysreset_gpio.o
+obj-$(CONFIG_$(SPL_TPL_)SYSRESET_MAX77663) += sysreset_max77663.o
 obj-$(CONFIG_SYSRESET_MPC83XX) += sysreset_mpc83xx.o
 obj-$(CONFIG_SYSRESET_MICROBLAZE) += sysreset_microblaze.o
 obj-$(CONFIG_SYSRESET_OCTEON) += sysreset_octeon.o
diff --git a/drivers/sysreset/sysreset_max77663.c b/drivers/sysreset/sysreset_max77663.c
new file mode 100644
index 0000000000..4a2a2275df
--- /dev/null
+++ b/drivers/sysreset/sysreset_max77663.c
@@ -0,0 +1,53 @@
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
+#include <power/max77663.h>
+
+static int max77663_sysreset_request(struct udevice *dev,
+				     enum sysreset_t type)
+{
+	int val;
+
+	val = pmic_reg_read(dev->parent, MAX77663_REG_ONOFF_CFG1);
+	if (val < 0)
+		return val;
+
+	/* clear both bits */
+	val &= ~ONOFF_SFT_RST;
+	val &= ~ONOFF_PWR_OFF;
+
+	switch (type) {
+	case SYSRESET_POWER:
+		/* MAX77663: SFT_RST > ONOFF_CFG1 */
+		pmic_reg_write(dev->parent, MAX77663_REG_ONOFF_CFG1,
+			       val | ONOFF_SFT_RST);
+		break;
+	case SYSRESET_POWER_OFF:
+		/* MAX77663: PWR_OFF > ONOFF_CFG1 */
+		pmic_reg_write(dev->parent, MAX77663_REG_ONOFF_CFG1,
+			       val | ONOFF_PWR_OFF);
+		break;
+	default:
+		return -EPROTONOSUPPORT;
+	}
+
+	return -EINPROGRESS;
+}
+
+static struct sysreset_ops max77663_sysreset = {
+	.request = max77663_sysreset_request,
+};
+
+U_BOOT_DRIVER(sysreset_max77663) = {
+	.id	= UCLASS_SYSRESET,
+	.name	= MAX77663_RST_DRIVER,
+	.ops	= &max77663_sysreset,
+};
diff --git a/include/power/max77663.h b/include/power/max77663.h
index 0f764bcbcc..b3ae3dabf4 100644
--- a/include/power/max77663.h
+++ b/include/power/max77663.h
@@ -12,6 +12,7 @@
 /* Drivers name */
 #define MAX77663_LDO_DRIVER		"max77663_ldo"
 #define MAX77663_SD_DRIVER		"max77663_sd"
+#define MAX77663_RST_DRIVER		"max77663_rst"
 
 /* Step-Down (SD) Regulator calculations */
 #define SD_STATUS_MASK			0x30
@@ -39,4 +40,8 @@
 
 #define LDO_VOLT_BASE			800000
 
+#define MAX77663_REG_ONOFF_CFG1		0x41
+#define   ONOFF_SFT_RST			BIT(7)
+#define   ONOFF_PWR_OFF			BIT(1)
+
 #endif /* _MAX77663_H_ */
-- 
2.39.2

