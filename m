Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61651C3601E
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 06:01:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF25F820E1;
	Mon, 14 Apr 2025 08:01:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iG6Aex0w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0B8D81FC0; Mon, 14 Apr 2025 08:01:10 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9106681F7E
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 08:01:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-abec8b750ebso681140966b.0
 for <u-boot@lists.denx.de>; Sun, 13 Apr 2025 23:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744610468; x=1745215268; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ybh7qxR1lHJvoYMxMA1LzSO4FnwKvTUwKKhx38qzjbU=;
 b=iG6Aex0wWX4ZJ9nF1OXYmUHIu8bD8wlQMwKVTvKhTEeyiom+O/ujVdaSDbQIzvjTUH
 2+MsGw5BRfrbQCcXSjr1GmLno+bkZpDRCGR9vxKVhu+EuENp5XtRuDxmBDNgBVhRqQIP
 iRnvutHZO/SG+Rsl0YHFKbsYKaQwrJUYMPdOVJOVK419dwXXygnBwB/kpW8JArBzkb6B
 6BV58ir9Qqi2CKfAHiHmUler9kAftviIlFZ4OG6w4uyGFSH/BRUux3lMr17wzsP0u4xu
 iS7T4vWey7X3p5yTuUBAaMWRE5rcIcMPI9100JEr3ogZ6UZvM12Hz5z10UzFs0w9G6I6
 e7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744610468; x=1745215268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ybh7qxR1lHJvoYMxMA1LzSO4FnwKvTUwKKhx38qzjbU=;
 b=udSka7ehiSy2/WZk+GlHujSqz83Uzf8Vc1C6Uwfa12bWaTJo0P75YMh3CABkAwjyv9
 KJGj+fyh8ZeF72PWUuh9jXtmABgIbOGle9Rreg0Orx1lu6LR8Rq5J9jQin5flitQxsu8
 24/DZP/Oy9XHK3J+d47SME8QwP9OASkltHmuPW0DAzYMbB5/N6MGlDfLuICh7NYVS1pv
 PvfWGxGmf7YaZe5OFhDjNXxVV0oAyJ/HWprz88kaVgDjMOws4R8Oimc0ESzle2PknDF3
 IcMiXlV5lJPj1AehiQVwZy3MJ84HAeNAzeGN37zJuPJB4Ffbdm0+xAoEWaqs6tXPwAsO
 kTLg==
X-Gm-Message-State: AOJu0Yzloe5K7oqCqoMUoi1OLFpQ+J9J81M43kt8tBDt2vbXOV78S6up
 CmEigxPXzvG9RMXzk30m90xnFlqYT9PvIgE1UhRehRi7RsBBwFND
X-Gm-Gg: ASbGncsywFhQoC7LH/fVOrFp9E3o9OntUpsE37bEw5Rq6qrtwNJGIQd+RaYyzAiK4zw
 56gpqWcBjclsubK/518BH2basBEEkSNfD0nBmmn8owdNr6BhRFsTjfpMzPm7qXV/1VMCBqsyuOy
 ELOeAj0Ov+o8uy+EShSDe8Pkjm+yqif/G2/D+PldRiHmTv5sRNPyFxS0FOU3DRd1yNnPetQrzfy
 3WtU2daS5on+G6KTxqBE4/d5ponNbpm3tUmn8F+e0b9P/hvuik9s5+RL7Q4DnNluiSZEyMjztDL
 dwv7ogCvO74jhdYa2tslUkGdj6NPmY9672N6/TVcRfY=
X-Google-Smtp-Source: AGHT+IGgfzxOH4bzrIZFEpv0t/rgcmiR/zxjWrK1qoSZTqOFNi6t28M0Xbu7F8Pi+3Y+k1WmskbtJA==
X-Received: by 2002:a17:907:6e8f:b0:ac4:3d1:e664 with SMTP id
 a640c23a62f3a-acad36a5dabmr938496066b.46.1744610467726; 
 Sun, 13 Apr 2025 23:01:07 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acaa1ce7fd1sm838050466b.168.2025.04.13.23.01.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Apr 2025 23:01:07 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Thierry Reding <treding@nvidia.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Ion Agorria <ion@agorria.com>, Artur Kowalski <arturkow2000@gmail.com>,
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 4/9] sysreset: implement MAX9807 sysreset functions
Date: Mon, 14 Apr 2025 09:00:14 +0300
Message-ID: <20250414060021.14545-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250414060021.14545-1-clamor95@gmail.com>
References: <20250414060021.14545-1-clamor95@gmail.com>
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

MAX8907 PMIC has embedded poweroff function used by some device to initiane
device power off. Implement it as optional sysreset driver guarded by
kconfig option and system-power-controller device tree property.

Tested-by: Ion Agorria <ion@agorria.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/power/pmic/max8907.c        | 14 ++++++++++-
 drivers/sysreset/Kconfig            |  7 ++++++
 drivers/sysreset/Makefile           |  1 +
 drivers/sysreset/sysreset_max8907.c | 37 +++++++++++++++++++++++++++++
 include/power/max8907.h             |  4 ++++
 5 files changed, 62 insertions(+), 1 deletion(-)
 create mode 100644 drivers/sysreset/sysreset_max8907.c

diff --git a/drivers/power/pmic/max8907.c b/drivers/power/pmic/max8907.c
index 5d35957bf40..a7ef70177de 100644
--- a/drivers/power/pmic/max8907.c
+++ b/drivers/power/pmic/max8907.c
@@ -45,7 +45,19 @@ static int max8907_read(struct udevice *dev, uint reg, uint8_t *buff, int len)
 static int max8907_bind(struct udevice *dev)
 {
 	ofnode regulators_node;
-	int children;
+	int children, ret;
+
+	if (IS_ENABLED(CONFIG_SYSRESET_MAX8907) &&
+	    dev_read_bool(dev, "maxim,system-power-controller")) {
+		ret = device_bind_driver_to_node(dev, MAX8907_RST_DRIVER,
+						 "sysreset", dev_ofnode(dev),
+						 NULL);
+		if (ret) {
+			log_debug("%s: cannot bind SYSRESET (ret = %d)\n",
+				  __func__, ret);
+			return ret;
+		}
+	}
 
 	regulators_node = dev_read_subnode(dev, "regulators");
 	if (!ofnode_valid(regulators_node)) {
diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
index 4972905482a..aa83073c96a 100644
--- a/drivers/sysreset/Kconfig
+++ b/drivers/sysreset/Kconfig
@@ -131,6 +131,13 @@ config SYSRESET_MAX77663
 	help
 	  Enable system power management functions found in MAX77663 PMIC.
 
+config SYSRESET_MAX8907
+	bool "Enable support for MAX8907 PMIC System Reset"
+	depends on DM_PMIC_MAX8907
+	select SYSRESET_CMD_POWEROFF if CMD_POWEROFF
+	help
+	  Enable system power management functions found in MAX8907 PMIC.
+
 config SYSRESET_MICROBLAZE
 	bool "Enable support for Microblaze soft reset"
 	depends on MICROBLAZE
diff --git a/drivers/sysreset/Makefile b/drivers/sysreset/Makefile
index ded91a4d325..f5c78b25896 100644
--- a/drivers/sysreset/Makefile
+++ b/drivers/sysreset/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_SYSRESET_CV1800B) += sysreset_cv1800b.o
 obj-$(CONFIG_$(PHASE_)POWEROFF_GPIO) += poweroff_gpio.o
 obj-$(CONFIG_$(PHASE_)SYSRESET_GPIO) += sysreset_gpio.o
 obj-$(CONFIG_$(PHASE_)SYSRESET_MAX77663) += sysreset_max77663.o
+obj-$(CONFIG_$(PHASE_)SYSRESET_MAX8907) += sysreset_max8907.o
 obj-$(CONFIG_SYSRESET_MPC83XX) += sysreset_mpc83xx.o
 obj-$(CONFIG_SYSRESET_MICROBLAZE) += sysreset_microblaze.o
 obj-$(CONFIG_SYSRESET_OCTEON) += sysreset_octeon.o
diff --git a/drivers/sysreset/sysreset_max8907.c b/drivers/sysreset/sysreset_max8907.c
new file mode 100644
index 00000000000..6f62af9bffe
--- /dev/null
+++ b/drivers/sysreset/sysreset_max8907.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  Copyright(C) 2024 Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#include <dm.h>
+#include <i2c.h>
+#include <errno.h>
+#include <sysreset.h>
+#include <power/pmic.h>
+#include <power/max8907.h>
+
+static int max8907_sysreset_request(struct udevice *dev, enum sysreset_t type)
+{
+	switch (type) {
+	case SYSRESET_POWER:
+	case SYSRESET_POWER_OFF:
+		/* MAX8907: PWR_OFF > RESET_CNFG */
+		pmic_clrsetbits(dev->parent, MAX8907_REG_RESET_CNFG,
+				MASK_POWER_OFF, MASK_POWER_OFF);
+		break;
+	default:
+		return -EPROTONOSUPPORT;
+	}
+
+	return -EINPROGRESS;
+}
+
+static struct sysreset_ops max8907_sysreset = {
+	.request = max8907_sysreset_request,
+};
+
+U_BOOT_DRIVER(sysreset_max8907) = {
+	.id	= UCLASS_SYSRESET,
+	.name	= MAX8907_RST_DRIVER,
+	.ops	= &max8907_sysreset,
+};
diff --git a/include/power/max8907.h b/include/power/max8907.h
index a19b25f44c0..a6e558e582c 100644
--- a/include/power/max8907.h
+++ b/include/power/max8907.h
@@ -12,6 +12,7 @@
 /* Drivers name */
 #define MAX8907_LDO_DRIVER		"max8907_ldo"
 #define MAX8907_SD_DRIVER		"max8907_sd"
+#define MAX8907_RST_DRIVER		"max8907_rst"
 
 /* MAX8907 register map */
 #define MAX8907_REG_SDCTL1		0x04
@@ -39,6 +40,9 @@
 #define MAX8907_REG_LDOCTL18		0x72
 #define MAX8907_REG_LDOCTL20		0x9C
 
+#define MAX8907_REG_RESET_CNFG		0x0F
+#define   MASK_POWER_OFF		BIT(6)
+
 /* MAX8907 configuration values */
 #define MAX8907_CTL			0
 #define MAX8907_SEQCNT			1
-- 
2.43.0

