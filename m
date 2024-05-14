Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46BEEC04FFE
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 10:15:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA25087971;
	Tue, 14 May 2024 12:15:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="IkiS88b4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2723882C4; Tue, 14 May 2024 12:15:30 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9F68877AF
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 12:15:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a599a298990so1341911966b.2
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 03:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1715681728; x=1716286528; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BZjrJdQFgJ42/hX+fDwUJlK2pK7Ui54AZgy3OOBCCoE=;
 b=IkiS88b4wv7vcgaujeEN+GrmxJ5hQDBqhqViAcjluq/+BuV7P9anylL8q7jqWhzzZu
 nFG9ybTV7CE5nTrjHSIdxS94FSmEgFbYMbyz4AwTxAx0sKRhQ8UZBzj4fcyB3CZ3AuwI
 yp/T8QmVBNgcBqPDQWFgut+9xRF71UlVmOge4f0hON3ut5gfO2lTeRcHOuGuzJ2S0bNK
 JNRjp+HgsuNOpLM1YTPfQLZHc1jr21d+eL725MshRt3Xw03vzdY+jJkeLSrbwVpEAWbC
 EdJeFPqbqo69jBy2ta9R6790i5zhozBqAi20aXDJU4BlF3s1dqBH30d/x+5pkxSCNfeD
 jN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715681728; x=1716286528;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BZjrJdQFgJ42/hX+fDwUJlK2pK7Ui54AZgy3OOBCCoE=;
 b=n76kddlMGbTO1BBGXgcNBrnHwJDvkUFyGC3RXFnpxqqz7FVuoaJQRKQt8pSLCOPKIw
 tCPdaH8QFr/FEVMZOBTcQSSMSYSOlmEVNjEdnTmn8xasxcsYrDsuWVBZcDhg3uWtsThS
 7kB5K6uNUKC6ttAwkPBKjGy7cNPYBlhkvjU1k/7SaGkte400ManGN2D1v3lNU3Er3sHS
 22c8sJYe+W/hAx0PWX0UzR2cUK6G/ohMN5rBDGZ5SMQV104kyLYVa95hOjAdCgq4Bn0j
 5uHS/3c584betwIu5ygLjKUPe44SWuyNFwY+L7EE9YbTOE7U0w3VEqLciAXOyACeMarc
 OTCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9p9LRLKsZKwu3SIDYWd6oOIH4T/6EoGKi3vSoir6W3crKKQ/K1GDD+Bg+GVQyDq+K/i0sL8Wupp5/gEirMNFmCAcS6w==
X-Gm-Message-State: AOJu0YxlkUSLQP1F7x+Ue1Sg9hH3c5QuMr8NWNzQWJONQY/z5BQ/sQQw
 GUYjQb71/4FfEsKv+3KhBwrvCpiygdYAFrN5KtOkXEEH5JcEKHxCY87b8u3L8HIgEuhdI0TSeWP
 0
X-Google-Smtp-Source: AGHT+IFJ4oxy/umNL8E9tp+QH/R87HXMQlsoZkzYWpKW7ujF730jg1nYeYwjmyHhjtg3J69HVZrRWw==
X-Received: by 2002:a50:bb42:0:b0:56e:2cfc:1d3d with SMTP id
 4fb4d7f45d1cf-5734d5c0daamr8558570a12.16.1715681728199; 
 Tue, 14 May 2024 03:15:28 -0700 (PDT)
Received: from fedora.. (cpe-188-129-44-220.dynamic.amis.hr. [188.129.44.220])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-574b6f6c53asm4245539a12.16.2024.05.14.03.15.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 May 2024 03:15:27 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: trini@konsulko.com, caleb.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@linaro.org, u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: j.beck@linefinity.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v3] sysreset: add Qualcomm PSHOLD reset driver
Date: Tue, 14 May 2024 12:15:02 +0200
Message-ID: <20240514101524.23607-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.45.0
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

Number of Qualcomm ARMv7 SoC-s did not use PSCI but rather used PSHOLD
(Qualcomm Power Supply Hold Reset) bit to trigger reset or poweroff.

Qualcomm IPQ40XX is one of them, so provide a simple sysreset driver based
on the upstream Linux one, it is DT compatible as well.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
---
Changes in v3:
* Drop <common.h>

Changes in v2:
* Use QCOM instead of MSM naming

 drivers/sysreset/Kconfig                |  6 +++
 drivers/sysreset/Makefile               |  1 +
 drivers/sysreset/sysreset_qcom-pshold.c | 55 +++++++++++++++++++++++++
 3 files changed, 62 insertions(+)
 create mode 100644 drivers/sysreset/sysreset_qcom-pshold.c

diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
index b64bfadb20..121194e441 100644
--- a/drivers/sysreset/Kconfig
+++ b/drivers/sysreset/Kconfig
@@ -240,6 +240,12 @@ config SYSRESET_RAA215300
 	help
 	  Add support for the system reboot via the Renesas RAA215300 PMIC.
 
+config SYSRESET_QCOM_PSHOLD
+	bool "Support sysreset for Qualcomm SoCs via PSHOLD"
+	depends on ARCH_IPQ40XX
+	help
+	  Add support for the system reboot on Qualcomm SoCs via PSHOLD.
+
 endif
 
 endmenu
diff --git a/drivers/sysreset/Makefile b/drivers/sysreset/Makefile
index d59299aa31..a6a0584585 100644
--- a/drivers/sysreset/Makefile
+++ b/drivers/sysreset/Makefile
@@ -29,4 +29,5 @@ obj-$(CONFIG_SYSRESET_RESETCTL) += sysreset_resetctl.o
 obj-$(CONFIG_$(SPL_TPL_)SYSRESET_AT91) += sysreset_at91.o
 obj-$(CONFIG_$(SPL_TPL_)SYSRESET_X86) += sysreset_x86.o
 obj-$(CONFIG_SYSRESET_RAA215300) += sysreset_raa215300.o
+obj-$(CONFIG_SYSRESET_QCOM_PSHOLD) += sysreset_qcom-pshold.o
 obj-$(CONFIG_TARGET_XTFPGA) += sysreset_xtfpga.o
diff --git a/drivers/sysreset/sysreset_qcom-pshold.c b/drivers/sysreset/sysreset_qcom-pshold.c
new file mode 100644
index 0000000000..4529047853
--- /dev/null
+++ b/drivers/sysreset/sysreset_qcom-pshold.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Qualcomm PSHOLD reset driver
+ *
+ * Copyright (c) 2024 Sartura Ltd.
+ *
+ * Author: Robert Marko <robert.marko@sartura.hr>
+ * Based on the Linux msm-poweroff driver.
+ *
+ */
+
+#include <dm.h>
+#include <sysreset.h>
+#include <asm/io.h>
+#include <linux/delay.h>
+
+struct qcom_pshold_priv {
+	phys_addr_t base;
+};
+
+static int qcom_pshold_request(struct udevice *dev, enum sysreset_t type)
+{
+	struct qcom_pshold_priv *priv = dev_get_priv(dev);
+
+	writel(0, priv->base);
+	mdelay(10000);
+
+	return 0;
+}
+
+static struct sysreset_ops qcom_pshold_ops = {
+	.request = qcom_pshold_request,
+};
+
+static int qcom_pshold_probe(struct udevice *dev)
+{
+	struct qcom_pshold_priv *priv = dev_get_priv(dev);
+
+	priv->base = dev_read_addr(dev);
+	return priv->base == FDT_ADDR_T_NONE ? -EINVAL : 0;
+}
+
+static const struct udevice_id qcom_pshold_ids[] = {
+	{ .compatible = "qcom,pshold", },
+	{ /* sentinel */ }
+};
+
+U_BOOT_DRIVER(qcom_pshold) = {
+	.name 		= "qcom_pshold",
+	.id 		= UCLASS_SYSRESET,
+	.of_match 	= qcom_pshold_ids,
+	.probe 		= qcom_pshold_probe,
+	.priv_auto	= sizeof(struct qcom_pshold_priv),
+	.ops 		= &qcom_pshold_ops,
+};
-- 
2.45.0

