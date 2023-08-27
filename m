Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBBC7C83F10
	for <u-boot@archiver.kernel.org>; Sun, 27 Aug 2023 08:22:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70D368620C;
	Sun, 27 Aug 2023 10:21:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TQlMHCkK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B41584B20; Sun, 27 Aug 2023 10:21:35 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87C0080726
 for <u-boot@lists.denx.de>; Sun, 27 Aug 2023 10:21:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-99d937b83efso287457466b.3
 for <u-boot@lists.denx.de>; Sun, 27 Aug 2023 01:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693124492; x=1693729292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=StnoIU3cb0ZvDVEiq/IpcJGjq7MVSOr0kMTAEH7njfw=;
 b=TQlMHCkKL54MjYiXwI+KhcQiqMVSasUjUaQIQlaZ4c+JBOgFrdTBYFuJ6MY2ODGhPn
 3M8QBi5UUKv2lWN5N/OS3WoxFmAYXI5f9l6ghjGlaNlLl5u8NCnfTFSBwMXP4jSpIA8p
 MaIDt/c8o1EL/Oqr0MDsYZFjk43KzKel3BRM/LjVDSfS2kNBbf9U0iKTGSqoLl68saWM
 05XbjSMl4McXXp/E2+WRrLJfTyiKL6ds24n6j9k44EY3jqc85d8uQxhlXVxgX8coamWB
 lFfsmnK+UdfjnbM7QC9+4V93/B2FmbgQwZasw6xzTnzEIrl5ajt5aqAvLlo0Wo8nvqzX
 PVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693124492; x=1693729292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=StnoIU3cb0ZvDVEiq/IpcJGjq7MVSOr0kMTAEH7njfw=;
 b=UoURUlgT5VPkDoaJf0Hd3+EsXnI/+CQDU1GHyoXCRZwJYs4GVahXQHtiNBmMuU6sHh
 8/dFdKdnCSm9ENXctVONLOqn0KJrSQ3HBfP0VxFmx0f88c3WlMBWTvZUIA/cN2z5vBsz
 AzYoYMB1nhMEZzFBLk7CLf/kG9OMyiI2sRCrA8BkOlt2nqokzbDdnkI8viJiVRi+zjjA
 S8Sbu9aQlnEtEsAyMQrzSHzarEIeYpLHY9X9/tnxXP+TYsbQmkfqNPCe4rTL3BLQAeCK
 3g6627HDuBR7IWYdmn3xnNEG6cNiqxDpYfiGuJ8m5zOe+VcSo7s/mGnRpT3E/bV2P60s
 BR2w==
X-Gm-Message-State: AOJu0YygfVv/MYihKyuZSPSDCQnhAWCFCi7vceamTavHU3zPFtdGUGrs
 0rNrMJPizSKMwVC0fHS5ftg=
X-Google-Smtp-Source: AGHT+IGfw32E3qRFJr42gAI5S4wxy29GgMMo87G4qJn5v0ywo1N3Src6F9+3KSnVjFzmiUzMWKPiRw==
X-Received: by 2002:a17:906:4ca:b0:99b:c038:fdac with SMTP id
 g10-20020a17090604ca00b0099bc038fdacmr16959461eja.20.1693124491982; 
 Sun, 27 Aug 2023 01:21:31 -0700 (PDT)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 i10-20020a170906250a00b0099b5a71b0bfsm3153433ejb.94.2023.08.27.01.21.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Aug 2023 01:21:31 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 5/6] sysreset: implement TPS65910 sysreset functions
Date: Sun, 27 Aug 2023 11:21:05 +0300
Message-Id: <20230827082106.6255-6-clamor95@gmail.com>
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
index 53af3171cc..b9c2326d5b 100644
--- a/drivers/power/pmic/pmic_tps65910_dm.c
+++ b/drivers/power/pmic/pmic_tps65910_dm.c
@@ -7,6 +7,7 @@
 #include <dm.h>
 #include <i2c.h>
 #include <log.h>
+#include <dm/lists.h>
 #include <power/pmic.h>
 #include <power/regulator.h>
 #include <power/tps65910_pmic.h>
@@ -58,7 +59,16 @@ static int pmic_tps65910_bind(struct udevice *dev)
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

