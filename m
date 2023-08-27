Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6526BC83F10
	for <u-boot@archiver.kernel.org>; Sun, 27 Aug 2023 08:22:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B540185C98;
	Sun, 27 Aug 2023 10:21:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PKMfgpib";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C703E80726; Sun, 27 Aug 2023 10:21:35 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D70D785C98
 for <u-boot@lists.denx.de>; Sun, 27 Aug 2023 10:21:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-99bcc0adab4so287490866b.2
 for <u-boot@lists.denx.de>; Sun, 27 Aug 2023 01:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693124491; x=1693729291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/4EjHTWrrMZAr/nbcIg7G9BYFDFhy0nomMgZ1Ak+ebE=;
 b=PKMfgpib9oYXmonAtIyIdReQ2HJQynwHtvdeu2gb+WbBVcgwJvcTR+GQWwj5XmqrWB
 bD2sSsxSML7EyFUU98K5PhaifWdrhVHp534ISDplADCNYHB6jSbaFYVTfPIgea3EsADd
 26tLNOTNOLUPDza/unvn0KwSZKjHhCZA1G+tqUwPDD7mMIsdAtGJ3kriBz8r6Y97sUXf
 F9C1FuznrMclwOWqyoU/nnwS45PY/kRMrz4Rn0n9BscR+uQbyq0cmXjaB3YOpdNVUHQl
 hJ/AT4JwZVvehx62oZdw6h7oFwnhb0HYH2DHW4/Wf3Hbh9b0xorlNevUDj19CQG/6jCT
 7CMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693124491; x=1693729291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/4EjHTWrrMZAr/nbcIg7G9BYFDFhy0nomMgZ1Ak+ebE=;
 b=SIR0P88NVa+RDkxAjgsX9ko49qWwHnaC5KWYNQ5bzqRkks3eqaRpbm3aGrausNXppg
 gSY57Pp7Sax0IouUeHfHagpzi1eIVIKd5qp3MgvArEJ2Tg6qbD+vr7c/t8JBOIndoHoi
 0UufLz0XGc18aQlXmrvCzramyXFHnVVBTCR+EUBuwIK70VfO5ePZbLv6dj+4HM+WpT5l
 ReRJtXbg+/mzF8hxRDLIN9GjKXcrxTHcXDAMlYXpRZWkoib+vGDTeYfxLRE3jsj5Z3HT
 uWTxJMzMRvpUQe2WSsSSlZNpNbE/ZzxoAad2kgzpoZUYbBEMSG84im6ytPolArIbDY9o
 jy1A==
X-Gm-Message-State: AOJu0Yyq7dhAlUvmbCGYK0Mx8e2t8Bz7wdXTznP5Skv5hEGkSxESEFML
 Mm37/tZVB4FuiLS3guH4F7g=
X-Google-Smtp-Source: AGHT+IEam0PTbFTlcjwEarbuG9axVqAlv21PXm5RigCxAxl82I6cXkq8EU4p6mDCS76dNii3fdWamg==
X-Received: by 2002:a17:906:225c:b0:9a1:c376:9d7b with SMTP id
 28-20020a170906225c00b009a1c3769d7bmr9795309ejr.32.1693124491262; 
 Sun, 27 Aug 2023 01:21:31 -0700 (PDT)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 i10-20020a170906250a00b0099b5a71b0bfsm3153433ejb.94.2023.08.27.01.21.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Aug 2023 01:21:30 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 4/6] sysreset: implement TPS80031 sysreset functions
Date: Sun, 27 Aug 2023 11:21:04 +0300
Message-Id: <20230827082106.6255-5-clamor95@gmail.com>
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

