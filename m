Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A8AC369A2
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 06:01:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1503681FFC;
	Mon, 14 Apr 2025 08:01:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JwjlIXPk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C47C81FDE; Mon, 14 Apr 2025 08:01:08 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3495B81F7E
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 08:01:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-aca99fc253bso604668266b.0
 for <u-boot@lists.denx.de>; Sun, 13 Apr 2025 23:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744610465; x=1745215265; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tRrwIUmOPlc/z21JrTIdJZFu08SGFZPbX+h3ggGfbHE=;
 b=JwjlIXPkZVMjFyNz68zkg7vFku55obYnQcQZ2UxZRYp4CkM8OKZCu17Ptxp4QImWNC
 CeVk/y3V+jl572Bu+L5zEC6unHaAlAzjNSGCMIDqCp52RXhub+SaSlal8ycZB+nbY2kY
 dXsz2zZpaGWkUcqObU/igSznpStUQnw520vep1jPtZz9NBTPGnvGMLwr51Gywoq9vLKQ
 6s3L5TK5OIMZxufU2lQXp0q7I4OoTVR8k9iEKT/LiOdUPdn9hj7LTNvlfONdi9f7lkM4
 HCXAx817xoSggXDvZekfH77gth/pz5GdUnmUvmob24y7uKQ8iRLjkBeOX1sMY72xYb1A
 TpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744610465; x=1745215265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tRrwIUmOPlc/z21JrTIdJZFu08SGFZPbX+h3ggGfbHE=;
 b=j889VmEWZw00EuFAaJdXfb8v9IfqiRny2+EnhiOAhEgZ+o7feZp4pyDKPV7NjuMe6F
 78I/95vRTDEIz/7XQnNJcWdhLHF2NmKWpHZ/2EK631lfybd8qy63vi8S3v5TOm5WEjgI
 EvYw5Lbmdk71HOFotXcn1Uk1AVmL6DYMH11BbHIt1G1Hm+O8pjNO/n1Je2g96ByYh2ih
 u4no/P9bKgVUJg34rGI3ypi2121dYpxNjE/x2OM0EtB6Kx+ykvdaxFuIV2fypXRmMPTD
 7sBvEsiBAx2oQZoClLuGGi9Fcqilt4Z+kITlbYVDaSIXzBrJ7p+pu+ZB+HYHXEHrdALu
 OYZQ==
X-Gm-Message-State: AOJu0YycuZKLgR7Xg2xd7OEdP+sPoCpqfLDQwS2z0NPH+swAQ9SZ1TQa
 QsEpvuPfr91MIsfGmUqz7B8T6xaZhZdjLH9xLxxTsqx/zbWr72M0
X-Gm-Gg: ASbGncs042FoW2d88gir5lAMT3zLffGcR06NvKO/Ijvyx6xXn/w+zSVy9Bo+UhGomrm
 yqSbCkbfeMeNwEJaNVp2k3vFFsc8dmZhhqRvDA8B4McxnZhDxstrg1JUBvbIUbfwAfAzHLliq6H
 foi2V9MV8/5SeuPlM/7AVKdttsKi0CNbiWBqe6RlHKPg7w0kZQYhtBzIVeJIXSIcFsiJ9LybsoA
 TjVLOZSIKb0TPTpXkS36yWTV3hLd8P8kq15tdm7firZKRIBEZmlPgprx3k2WYTFW3veozxALMaj
 PjojPFe4xQfQtZRrob6wMvTtacRO+Scx
X-Google-Smtp-Source: AGHT+IEuGD+NVK+QAEZHuvTS7YOA194Cc0RyTJhQh6KOnHbXGCVfQYgkVhg8atF7t4OkEcAzsfoBeg==
X-Received: by 2002:a17:907:1b21:b0:abf:a387:7e35 with SMTP id
 a640c23a62f3a-acad36d4c16mr901359566b.53.1744610465374; 
 Sun, 13 Apr 2025 23:01:05 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acaa1ce7fd1sm838050466b.168.2025.04.13.23.01.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Apr 2025 23:01:05 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Thierry Reding <treding@nvidia.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Ion Agorria <ion@agorria.com>, Artur Kowalski <arturkow2000@gmail.com>,
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 2/9] power: pmic: add the base MAX8907 PMIC support
Date: Mon, 14 Apr 2025 09:00:12 +0300
Message-ID: <20250414060021.14545-3-clamor95@gmail.com>
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

Add basic i2c based read/write functions to access PMIC registers.

Tested-by: Ion Agorria <ion@agorria.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/power/pmic/Kconfig   |  9 ++++++
 drivers/power/pmic/Makefile  |  1 +
 drivers/power/pmic/max8907.c | 53 ++++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+)
 create mode 100644 drivers/power/pmic/max8907.c

diff --git a/drivers/power/pmic/Kconfig b/drivers/power/pmic/Kconfig
index 5a61cd45b8c..ec7ccc3a63f 100644
--- a/drivers/power/pmic/Kconfig
+++ b/drivers/power/pmic/Kconfig
@@ -184,6 +184,15 @@ config SPL_DM_PMIC_PFUZE100
 	This config enables implementation of driver-model pmic uclass features
 	for PMIC PFUZE100 in SPL. The driver implements read/write operations.
 
+config DM_PMIC_MAX8907
+	bool "Enable Driver Model for PMIC MAX8907"
+	---help---
+	This config enables implementation of driver-model pmic uclass features
+	for PMIC MAX8907. The driver implements read/write operations.
+	This is a Power Management IC with a decent set of peripherals from which
+	3 DC-to-DC Step-Down (SD) Regulators, 20 Low-Dropout Linear (LDO) Regulators,
+	Real-Time Clock (RTC) and more with I2C Compatible Interface.
+
 config DM_PMIC_MAX77663
 	bool "Enable Driver Model for PMIC MAX77663"
 	---help---
diff --git a/drivers/power/pmic/Makefile b/drivers/power/pmic/Makefile
index 2210b1a64ae..6bebffb05a6 100644
--- a/drivers/power/pmic/Makefile
+++ b/drivers/power/pmic/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_$(PHASE_)DM_PMIC) += pmic-uclass.o
 obj-$(CONFIG_$(PHASE_)DM_PMIC_FAN53555) += fan53555.o
 obj-$(CONFIG_$(PHASE_)DM_PMIC_DA9063) += da9063.o
 obj-$(CONFIG_$(PHASE_)DM_PMIC_MAX77663) += max77663.o
+obj-$(CONFIG_$(PHASE_)DM_PMIC_MAX8907) += max8907.o
 obj-$(CONFIG_DM_PMIC_MAX77686) += max77686.o
 obj-$(CONFIG_DM_PMIC_MAX8998) += max8998.o
 obj-$(CONFIG_DM_PMIC_MC34708) += mc34708.o
diff --git a/drivers/power/pmic/max8907.c b/drivers/power/pmic/max8907.c
new file mode 100644
index 00000000000..aeb6fe734e6
--- /dev/null
+++ b/drivers/power/pmic/max8907.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  Copyright(C) 2024 Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#include <dm.h>
+#include <dm/lists.h>
+#include <power/pmic.h>
+
+static int max8907_write(struct udevice *dev, uint reg, const uint8_t *buff, int len)
+{
+	int ret;
+
+	ret = dm_i2c_write(dev, reg, buff, len);
+	if (ret) {
+		log_debug("%s: write error to device: %p register: %#x!\n",
+			  __func__, dev, reg);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int max8907_read(struct udevice *dev, uint reg, uint8_t *buff, int len)
+{
+	int ret;
+
+	ret = dm_i2c_read(dev, reg, buff, len);
+	if (ret) {
+		log_debug("%s: read error from device: %p register: %#x!\n",
+			  __func__, dev, reg);
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct dm_pmic_ops max8907_ops = {
+	.read = max8907_read,
+	.write = max8907_write,
+};
+
+static const struct udevice_id max8907_ids[] = {
+	{ .compatible = "maxim,max8907" },
+	{ }
+};
+
+U_BOOT_DRIVER(pmic_max8907) = {
+	.name = "max8907_pmic",
+	.id = UCLASS_PMIC,
+	.of_match = max8907_ids,
+	.ops = &max8907_ops,
+};
-- 
2.43.0

