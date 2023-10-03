Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74826E7542B
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 06:41:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3AF58747E;
	Tue,  3 Oct 2023 08:41:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aeGWtWm7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A085D87461; Tue,  3 Oct 2023 08:40:58 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B57A86A3C
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 08:40:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-50435a9f800so605953e87.2
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 23:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696315256; x=1696920056; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V0s7IluXy0RtCLJccliKO61miFWonYR4B66GnTJxdGc=;
 b=aeGWtWm7wGo2xqclTLnYhe+66OzZr0UffGB5pVU2KpuTph9o/YC2D/seMMjXA2EAtl
 zn6674kdzw3jW7wBj0L5UTmO6qONwe3FUILn61iCDynvFOp7YTJAOk2psXsyf4CKXD0R
 fPv4q86yb6LrpBaRSsFp7yOeJQYfe6H3ijF2oaexeNVoT287RR4wknghcDzPFpDTt+It
 FXTCqS2aoMw5qOimOVQnR1pbqGMIf7jnnGWZrGZjUJ8XQLNV6lbDgm7UdZP/bX8crPMj
 rRtF+ASza2btyvj55MN6Q/nQUq80SqmvM4oCjpv7lH+awLhvSvfsLmjGqqxBFnQTFVAN
 xc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696315256; x=1696920056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V0s7IluXy0RtCLJccliKO61miFWonYR4B66GnTJxdGc=;
 b=OKRY/ak6qwYLWX/HopPtT+Hee48PWBkPD1qMDf+zTFExpnkV+0LAj1JG9mMgANhEXV
 9nXwPuw8nfmWj2zfhdZRbZ7qT6SeBPB1RJUavVxbU5+75HYGyw7LMfqzn3PlhI7cevoJ
 pwVIyEO6+nQ1SAzFuvkgqwIj0iJwRRjuCwqE4zHvAwuYF/FcaoaLLTNdZvZLIAerHyWO
 BCuzCaW+971psTsqJjhp02MfkGQGMMGIeItmw7OG4ysUHQmKnTJeIeO/i04f9R6jvQp6
 /C3B2ZUc5KhcwFIypovjczr6IBbUaSrmbADxpygKBxKGttWFsm/ce7VCHUHAwcOqRMnZ
 SJKg==
X-Gm-Message-State: AOJu0Yz5RPdkE0aKZGwXSB8uD9aKyyS7bbIomXxYVgoAGRf45NC2IBOE
 /ivp55PFrqSRB33Xp9iRAgU=
X-Google-Smtp-Source: AGHT+IFyYrPkKpaqWPgKp0WBk040cg8RC6ZlJSXHg4Dybn/bts7WosmMw5tlz0v6hsZtySIQ0Tk8rA==
X-Received: by 2002:a05:6512:3608:b0:4f9:54f0:b6db with SMTP id
 f8-20020a056512360800b004f954f0b6dbmr9536339lfs.13.1696315255930; 
 Mon, 02 Oct 2023 23:40:55 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 x12-20020ac25dcc000000b004fe202a5c7csm79730lfq.135.2023.10.02.23.40.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 23:40:55 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 3/6] sysreset: implement MAX77663 sysreset functions
Date: Tue,  3 Oct 2023 09:40:39 +0300
Message-Id: <20231003064042.43201-4-clamor95@gmail.com>
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

