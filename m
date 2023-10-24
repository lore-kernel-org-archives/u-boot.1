Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD5CEC07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 07:49:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAECB87141;
	Tue, 24 Oct 2023 09:49:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XZzYcFin";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3B5687032; Tue, 24 Oct 2023 09:49:31 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D34A87166
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 09:49:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-507c8316abcso5625909e87.1
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 00:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698133767; x=1698738567; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/4EjHTWrrMZAr/nbcIg7G9BYFDFhy0nomMgZ1Ak+ebE=;
 b=XZzYcFinj0GGeRuuJIQF+B7BbO7X74OfveMlDAnhZ4w35IWolxYzdXJEcozZTPrs/l
 gZQg9/A/GXzuWLYpGko3tdqftNcVRWTka1wHATHUG9Ac2VHQ/WeHqF6iPXRGrXLPSekA
 u7oXO/OjYNHgpKWDEu2OHjI6nPUHrWTdMar9MuLXCXUvhgGz5BvWt4yZ+p0aPOmPYpqW
 mnL1pFc2mPtsLDsAfZqS+tInesxHrxzorunCUE10QzKQcTEq31RywW/i6q8mPbx2UUFk
 YhzjMDQeEHxlrpkD0m/INat0mywZk+pwuv77VgO8+MCVogMZgaWqoaEX5qFAqqoKYFdp
 juTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698133767; x=1698738567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/4EjHTWrrMZAr/nbcIg7G9BYFDFhy0nomMgZ1Ak+ebE=;
 b=YFro/hPMePCCgBH8AkyntyS3ly6udDkwBcc7O/6pFP9F02YJJqS/fYfkXAiTY9CROF
 B4ohyv9ycyVl+wNmC+fPX0AJGq4y+9Tza3sIlOXKnFA8YFQNh6klcaCaurfq1aX4ZtTm
 dYqziUGtHdz9omKjDmPEa+T2SV7oPxaSXMuKei/eAXGihaBZbNW6fUDY9Vow5pM6YrES
 LQpZmJouuAt+wKy/55u485J9bbLGLEAF9tZfAZWCh+Edr7zZWRTtJMkE3JNX/AABJXA4
 3zFv+Fd+E4AbyvUA0QmsoMpbEOr2PQ3D55h/S7aDmyAO0LYpalw0bFjJSHy8f5R85yyh
 KqKA==
X-Gm-Message-State: AOJu0YzetwGDMQTOmAgI9zLM/JIrpxv9qtvGW0kkxguKPW+1XdsDZPxd
 mTBJKqoaNOuFSG+yiv5XyNs=
X-Google-Smtp-Source: AGHT+IEUkWMSnFaQviU3muzQA87N0faw46lod7Lu9rNNjm7hCIxRHMGY1JabSFVLnZ3YbROxbWx/nA==
X-Received: by 2002:a19:914a:0:b0:507:9b4a:21c0 with SMTP id
 y10-20020a19914a000000b005079b4a21c0mr7421221lfj.42.1698133767127; 
 Tue, 24 Oct 2023 00:49:27 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 v25-20020ac25939000000b00507a89ef9bbsm2011741lfi.166.2023.10.24.00.49.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 00:49:26 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v4 4/6] sysreset: implement TPS80031 sysreset functions
Date: Tue, 24 Oct 2023 10:49:06 +0300
Message-Id: <20231024074908.199903-5-clamor95@gmail.com>
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

