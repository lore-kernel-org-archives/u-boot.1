Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E603C10F15
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 12:45:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07CBD887A7;
	Wed, 24 Apr 2024 14:45:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="Zwo3ZhUS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3643F887A4; Wed, 24 Apr 2024 14:45:06 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54D408872B
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 14:45:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a55bf737cecso332417266b.0
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 05:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1713962703; x=1714567503; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=s1sZUceg7pNaDks6BtX36K/4C9Hwa4z+UoQSLbotcMM=;
 b=Zwo3ZhUSbUh/vhCl60yMQZpmj6y0wIQv4bsZj53+OJL7aprVi/lXjLab6N5f3xSW1Q
 +2l0RBe/5t5EKYc9E+ifaYrxOOFukUmMDIpBkPtTniog1RKMNCSU3Vo9rBJTnxxC1eYp
 AuBsrHbcLwGPnMf8vkP23LdKFbgDjURPrMsDP01D+PDKUE32oYDO3Ujdn7t9IU/cJc6u
 RdauYhen0fv889sBWVrbv3KsNqC2dNXEX8QYSiTsl6FkbNHYSX1K51SfuagVL8i5iqyB
 lsNaeqaDcVRzKxrce/cjhBVlOA9NQdOpqe2YxxETdGGXMI3oPKLPglqD9UgtjtYvA2mw
 dOzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713962703; x=1714567503;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s1sZUceg7pNaDks6BtX36K/4C9Hwa4z+UoQSLbotcMM=;
 b=SaWyfnFj5NPj6jnvJjxZrnqqWcEGEmms1sAB4dJnOjIW1QDC4u+CugHpxGjyYwNapg
 F0ItSbHYyLGsxhl+Dnr+vS44qObYO1OeghsSBWJBS2NzY71PuQxu34JhgQaYLyGBxWmO
 fnMwTZe1U9jc0iBurSfEuKqpbUv+teMxlBzCKzASO3WE8uutkdpBLrCupji+R2BzVJAB
 PrtvxhSpvYUsJuqfWTRfuFtQ1sFHtvya9KGPAUrwFCDDaw60V1Y/sOVxM+Fh1etuDdoB
 TGE53FtKWUilAqflie/u9jhSoHSLzlvd3u5Cv+gF5DB3WRREMNX6b2m+qkQrALs/MRY1
 bqgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgQWimJ+5GKatI4JvvboF8u3BbI5WqyMGWtOKUll1NX03FcwKu7amCisaCGb23YeoOXwQ//hM07W6oQ8A9UYh8TmsUbw==
X-Gm-Message-State: AOJu0YxTIWLUv/IyCLzRCJ4xoQZZSAXteIjf6M+FxWsYZT85MvuFCpeu
 azZssvDxnF/n5h9xp8yBjJQUfAdluvOSTB4mMDCxPWLm0JIX++u7hZ4hn52cBNf5rhzVFOFvv4J
 n
X-Google-Smtp-Source: AGHT+IEfNOFgL/DWgebwFUHj3KFYZL9KpAf5+y7EvW2g57mEpuVjplL86LNswHjF5l5zDfi11JozTg==
X-Received: by 2002:a17:906:7f10:b0:a58:8432:69c0 with SMTP id
 d16-20020a1709067f1000b00a58843269c0mr1253496ejr.67.1713962702561; 
 Wed, 24 Apr 2024 05:45:02 -0700 (PDT)
Received: from fedora.. (cpe-188-129-47-40.dynamic.amis.hr. [188.129.47.40])
 by smtp.googlemail.com with ESMTPSA id
 u3-20020a170906b10300b00a52552a8605sm8304857ejy.159.2024.04.24.05.45.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 05:45:02 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: trini@konsulko.com, caleb.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@linaro.org, u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: j.beck@linefinity.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2] sysreset: add Qualcomm PSHOLD reset driver
Date: Wed, 24 Apr 2024 14:44:33 +0200
Message-ID: <20240424124500.391735-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.44.0
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
Changes in v2:
* Use QCOM instead of MSM naming

 drivers/sysreset/Kconfig                |  6 +++
 drivers/sysreset/Makefile               |  1 +
 drivers/sysreset/sysreset_qcom-pshold.c | 56 +++++++++++++++++++++++++
 3 files changed, 63 insertions(+)
 create mode 100644 drivers/sysreset/sysreset_qcom-pshold.c

diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
index 49c0787b26..920dceb70b 100644
--- a/drivers/sysreset/Kconfig
+++ b/drivers/sysreset/Kconfig
@@ -235,6 +235,12 @@ config SYSRESET_RAA215300
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
index e0e732205d..f0620c391e 100644
--- a/drivers/sysreset/Makefile
+++ b/drivers/sysreset/Makefile
@@ -28,4 +28,5 @@ obj-$(CONFIG_SYSRESET_RESETCTL) += sysreset_resetctl.o
 obj-$(CONFIG_$(SPL_TPL_)SYSRESET_AT91) += sysreset_at91.o
 obj-$(CONFIG_$(SPL_TPL_)SYSRESET_X86) += sysreset_x86.o
 obj-$(CONFIG_SYSRESET_RAA215300) += sysreset_raa215300.o
+obj-$(CONFIG_SYSRESET_QCOM_PSHOLD) += sysreset_qcom-pshold.o
 obj-$(CONFIG_TARGET_XTFPGA) += sysreset_xtfpga.o
diff --git a/drivers/sysreset/sysreset_qcom-pshold.c b/drivers/sysreset/sysreset_qcom-pshold.c
new file mode 100644
index 0000000000..25231cf5e2
--- /dev/null
+++ b/drivers/sysreset/sysreset_qcom-pshold.c
@@ -0,0 +1,56 @@
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
+#include <common.h>
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
2.44.0

