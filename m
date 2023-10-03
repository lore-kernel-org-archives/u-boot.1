Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD54E75428
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 06:41:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 276368748F;
	Tue,  3 Oct 2023 08:41:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XO2k6xGE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84B0C8747D; Tue,  3 Oct 2023 08:40:59 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85F3E87256
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 08:40:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5041cc983f9so596527e87.3
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 23:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696315257; x=1696920057; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/4EjHTWrrMZAr/nbcIg7G9BYFDFhy0nomMgZ1Ak+ebE=;
 b=XO2k6xGE1I9cjqhjkhC1bDJWSa4XjI6SEOqqAeZo9TADOQyEOo/s9bcAR+AFtNMckp
 NE+xeZv89n4Y/9R8ZXzodNRdzV841UZKevGy9ctGghRrjKixUziCwTqDbsZDtpttVbYQ
 vUyMf7jzgEWiSzEDqaKJhGPT1XJxEW4CNWlMMkTBXcwQDMqCE6tvf7UIstd7l/LhP8+K
 aJdOC4jy9XKPit3VZbUOwFkDThkT70ipWndLl83FKZ/hpcln5CW5ubLiAELSzMmg2968
 XFa4jVB9kTHDmN+JC6xndObjPazZo51YjlvtSdLHECr2/ANyFBaypwXQYwLWV/rlDndU
 C6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696315257; x=1696920057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/4EjHTWrrMZAr/nbcIg7G9BYFDFhy0nomMgZ1Ak+ebE=;
 b=JePjXmyeoPJA1FAlIbwwRAoHUnPoG+XhjL/FeobEdscTkmBCqHnNZPTNy4YU0o0kcl
 721O09qrytsSbdiEuaZopNScVYssoTsxmGirp7R+cy3H8JKU5QEVrcfFQxutw6Ih3Rdw
 4dioPjioSymKLGPHhx5Zp1bx6vHOPm0NY0C1X3EyXAMjwyB4qZx7PdKK4rAkZOgaYx91
 zFQHnoDKfGQkIlfVhd1DrPXc9WvSdSkCbVVueQ3twAeeprwJvgjdeiJq+MdqTznk/nG6
 okKRLViNc4pdOgp1e0oBokyAg8qYxfQdF+Rqiii7h7St5q7ms7Pbbc50MJU0rOJKc1dq
 F9Fg==
X-Gm-Message-State: AOJu0Yzal0FEGadmiMzjQqGuQzYI1GKax0TjHEat8DW1/Hh8yuAoFauS
 +IYMS+JGEbpc0TvmwOiogdg8tp1Wejg=
X-Google-Smtp-Source: AGHT+IHN8+du7WYw4uVGrBVJfycjrHHekmpdDK+ijIu+r+RYpFl8KGTgvozkRMtrgEJQwy2sxN4heA==
X-Received: by 2002:a05:6512:234a:b0:500:7fc1:414b with SMTP id
 p10-20020a056512234a00b005007fc1414bmr12930097lfu.25.1696315256765; 
 Mon, 02 Oct 2023 23:40:56 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 x12-20020ac25dcc000000b004fe202a5c7csm79730lfq.135.2023.10.02.23.40.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 23:40:56 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 4/6] sysreset: implement TPS80031 sysreset functions
Date: Tue,  3 Oct 2023 09:40:40 +0300
Message-Id: <20231003064042.43201-5-clamor95@gmail.com>
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

TPS80031/TPS80032 PMICs have embedded power control functions
used by some device to initiane device power off. Implement it as
sysreset driver.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/power/pmic/tps80031.c        | 12 +++++++-
 drivers/sysreset/Kconfig             |  8 ++++++
 drivers/sysreset/Makefile            |  1 +
 drivers/sysreset/sysreset_tps80031.c | 41 ++++++++++++++++++++++++++++
 include/power/tps80031.h             |  5 ++++
 5 files changed, 66 insertions(+), 1 deletion(-)
 create mode 100644 drivers/sysreset/sysreset_tps80031.c

diff --git a/drivers/power/pmic/tps80031.c b/drivers/power/pmic/tps80031.c
index c2b04fffdf..45e89ba5c9 100644
--- a/drivers/power/pmic/tps80031.c
+++ b/drivers/power/pmic/tps80031.c
@@ -9,6 +9,7 @@
 #include <dm.h>
 #include <i2c.h>
 #include <log.h>
+#include <dm/lists.h>
 #include <power/pmic.h>
 #include <power/regulator.h>
 #include <power/tps80031.h>
@@ -49,7 +50,16 @@ static int tps80031_read(struct udevice *dev, uint reg, uint8_t *buff, int len)
 static int tps80031_bind(struct udevice *dev)
 {
 	ofnode regulators_node;
-	int children;
+	int children, ret;
+
+	if (IS_ENABLED(CONFIG_SYSRESET_TPS80031)) {
+		ret = device_bind_driver(dev, TPS80031_RST_DRIVER,
+					 "sysreset", NULL);
+		if (ret) {
+			log_err("cannot bind SYSRESET (ret = %d)\n", ret);
+			return ret;
+		}
+	}
 
 	regulators_node = dev_read_subnode(dev, "regulators");
 	if (!ofnode_valid(regulators_node)) {
diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
index bc35896101..cdb4ae2bb1 100644
--- a/drivers/sysreset/Kconfig
+++ b/drivers/sysreset/Kconfig
@@ -157,6 +157,14 @@ config SYSRESET_TI_SCI
 	  This enables the system reset driver support over TI System Control
 	  Interface available on some new TI's SoCs.
 
+config SYSRESET_TPS80031
+	bool "Enable support for TPS80031/TPS80032 PMIC System Reset"
+	depends on DM_PMIC_TPS80031
+	select SYSRESET_CMD_POWEROFF if CMD_POWEROFF
+	help
+	  Enable system power management functions found in TPS80031/TPS80032
+	  PMICs.
+
 config SYSRESET_SYSCON
 	bool "Enable support for mfd syscon reboot driver"
 	select REGMAP
diff --git a/drivers/sysreset/Makefile b/drivers/sysreset/Makefile
index c31f51c581..f62db899da 100644
--- a/drivers/sysreset/Makefile
+++ b/drivers/sysreset/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_SYSRESET_SOCFPGA) += sysreset_socfpga.o
 obj-$(CONFIG_SYSRESET_SOCFPGA_SOC64) += sysreset_socfpga_soc64.o
 obj-$(CONFIG_SYSRESET_TEGRA) += sysreset_tegra.o
 obj-$(CONFIG_SYSRESET_TI_SCI) += sysreset-ti-sci.o
+obj-$(CONFIG_$(SPL_TPL_)SYSRESET_TPS80031) += sysreset_tps80031.o
 obj-$(CONFIG_SYSRESET_SYSCON) += sysreset_syscon.o
 obj-$(CONFIG_SYSRESET_WATCHDOG) += sysreset_watchdog.o
 obj-$(CONFIG_SYSRESET_RESETCTL) += sysreset_resetctl.o
diff --git a/drivers/sysreset/sysreset_tps80031.c b/drivers/sysreset/sysreset_tps80031.c
new file mode 100644
index 0000000000..ea35f48ebd
--- /dev/null
+++ b/drivers/sysreset/sysreset_tps80031.c
@@ -0,0 +1,41 @@
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
+#include <power/tps80031.h>
+
+static int tps80031_sysreset_request(struct udevice *dev,
+				     enum sysreset_t type)
+{
+	switch (type) {
+	case SYSRESET_POWER:
+		/* TPS80031: SW_RESET > PHOENIX_DEV_ON */
+		pmic_reg_write(dev->parent, TPS80031_PHOENIX_DEV_ON, SW_RESET);
+		break;
+	case SYSRESET_POWER_OFF:
+		/* TPS80031: DEVOFF > PHOENIX_DEV_ON */
+		pmic_reg_write(dev->parent, TPS80031_PHOENIX_DEV_ON, DEVOFF);
+		break;
+	default:
+		return -EPROTONOSUPPORT;
+	}
+
+	return -EINPROGRESS;
+}
+
+static struct sysreset_ops tps80031_sysreset = {
+	.request = tps80031_sysreset_request,
+};
+
+U_BOOT_DRIVER(sysreset_tps80031) = {
+	.id	= UCLASS_SYSRESET,
+	.name	= TPS80031_RST_DRIVER,
+	.ops	= &tps80031_sysreset,
+};
diff --git a/include/power/tps80031.h b/include/power/tps80031.h
index c80692a8af..983c841bfe 100644
--- a/include/power/tps80031.h
+++ b/include/power/tps80031.h
@@ -12,6 +12,7 @@
 /* Drivers name */
 #define TPS80031_LDO_DRIVER		"tps80031_ldo"
 #define TPS80031_SMPS_DRIVER		"tps80031_smps"
+#define TPS80031_RST_DRIVER		"tps80031_rst"
 
 #define TPS80031_SMPS_OFFSET		0xe0
 #define TPS80031_OFFSET_FLAG		BIT(0)
@@ -35,6 +36,10 @@
 #define LDO_VOLT_MIN			1018000
 #define LDO_VOLT_BASE			916000
 
+#define TPS80031_PHOENIX_DEV_ON		0x25
+#define   SW_RESET			BIT(6)
+#define   DEVOFF			BIT(0)
+
 /* register groups */
 enum {
 	CTRL,
-- 
2.39.2

