Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3BC2C4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 11:34:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFDBE88348;
	Tue, 23 Apr 2024 13:34:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="SeRa1kJF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3392288349; Tue, 23 Apr 2024 13:34:43 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30E7687D8D
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 13:34:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a519e1b0e2dso623744266b.2
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 04:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1713872080; x=1714476880; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qca/HfxybFfYcO9p8+34XaGObrWCc2mtg6ghduv+F6s=;
 b=SeRa1kJFPEkGYvqbER2WeF85RmT0qBYpoWg0grc0ZPXeUKChv/tgc6YiTQwAUVGeqi
 qQw9n8zrxMXPu0JxEE+BAxhDM/zVNuyOYIgDl/XZ9iEQ96RJAVpaWkDudf+yeti4BoQe
 D664Zaeab8X8Txu8dblr9WNnqratoAyVy1DwPEualcc2/hNv77uKh0PAKkLw7A+F2K56
 OoeINtMADl7i9ryzEp250oOGyDUtCr/JqIpVRIcxDl7FcvSEB7Tg8ORSBiAjt2dPNlW5
 u5Eu/yefvabDG/pgfNSc/DyBfqSVtnB+tvVu5tc7mGD05hmw2DgsT0bNA/rNJ7HRYuhe
 2/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713872080; x=1714476880;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qca/HfxybFfYcO9p8+34XaGObrWCc2mtg6ghduv+F6s=;
 b=wvgmOIGsFTCmsSOEFSrekWlXJWCNzKYYwEbfNy9IPrL+IqO+v8BpAt9RI2O1Bawz6F
 ZtyOrzciCf9KKCgciyYAEL3vBbjFKhjscTg1sHTKegh5ypMpzIKBSKlwciWFsPorA49X
 M41Qmhyj7Lztz6rH3SLDUmXjgQhgZ94lHMaTEsMmWDMNSccLjh/nIjSSlMOEgo9PjYsp
 uentmiCzBXCLxw6ZIFWXTVx0zvQdepswIqcBJh/8Ox9XBVagP4azoNb+IbhMbjtZcByR
 6QYcVpchf/FtxLg6FHq7IWS00y4Q+UIKhTzsZ120MF8h/FOsxNX7zHvdNyYeIdJEWuQ9
 GauA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5VLgU+3yCSBEfXDFnstDbd0tsq6rJMAiNfAv63EfDlzK0WC0UTpLkR8tlLflskJ+zwN10L3BHZ6gjguwtVUdXx6Wrog==
X-Gm-Message-State: AOJu0YxNDJaC91c790DJpCKwvMszsJphsU+ftNLBT695f5IFOMal96CW
 eFjTWe0GbC4FhoH8B7moPBlIjBf7o7CAnDIADI5tDb6NsESzfzpDKp9MxTW9i/M=
X-Google-Smtp-Source: AGHT+IHqd8upZ7Mi9ln2bnRjat6D5Tz4ZIeiYKIYL+033vZYoQj76RE1W4iHRaoXjvxB7L6XACeXaQ==
X-Received: by 2002:a17:906:c212:b0:a55:67b1:7815 with SMTP id
 d18-20020a170906c21200b00a5567b17815mr9190467ejz.41.1713872080316; 
 Tue, 23 Apr 2024 04:34:40 -0700 (PDT)
Received: from fedora.. (cpe-188-129-47-121.dynamic.amis.hr. [188.129.47.121])
 by smtp.googlemail.com with ESMTPSA id
 mm7-20020a170906cc4700b00a5872f75cfdsm1227389ejb.49.2024.04.23.04.34.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 04:34:39 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: trini@konsulko.com, u-boot@lists.denx.de, caleb.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@linaro.org
Cc: j.beck@linefinity.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH] sysreset: add Qualcomm PSHOLD reset driver
Date: Tue, 23 Apr 2024 13:33:46 +0200
Message-ID: <20240423113437.84339-1-robert.marko@sartura.hr>
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
---
 drivers/sysreset/Kconfig               |  6 +++
 drivers/sysreset/Makefile              |  1 +
 drivers/sysreset/sysreset_msm-pshold.c | 56 ++++++++++++++++++++++++++
 3 files changed, 63 insertions(+)
 create mode 100644 drivers/sysreset/sysreset_msm-pshold.c

diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
index 49c0787b26..30ff9e576d 100644
--- a/drivers/sysreset/Kconfig
+++ b/drivers/sysreset/Kconfig
@@ -235,6 +235,12 @@ config SYSRESET_RAA215300
 	help
 	  Add support for the system reboot via the Renesas RAA215300 PMIC.
 
+config SYSRESET_MSM_PSHOLD
+	bool "Support sysreset for Qualcomm SoCs via PSHOLD"
+	depends on ARCH_IPQ40XX
+	help
+	  Add support for the system reboot on Qualcomm SoCs via PSHOLD.
+
 endif
 
 endmenu
diff --git a/drivers/sysreset/Makefile b/drivers/sysreset/Makefile
index e0e732205d..da61dca8e2 100644
--- a/drivers/sysreset/Makefile
+++ b/drivers/sysreset/Makefile
@@ -28,4 +28,5 @@ obj-$(CONFIG_SYSRESET_RESETCTL) += sysreset_resetctl.o
 obj-$(CONFIG_$(SPL_TPL_)SYSRESET_AT91) += sysreset_at91.o
 obj-$(CONFIG_$(SPL_TPL_)SYSRESET_X86) += sysreset_x86.o
 obj-$(CONFIG_SYSRESET_RAA215300) += sysreset_raa215300.o
+obj-$(CONFIG_SYSRESET_MSM_PSHOLD) += sysreset_msm-pshold.o
 obj-$(CONFIG_TARGET_XTFPGA) += sysreset_xtfpga.o
diff --git a/drivers/sysreset/sysreset_msm-pshold.c b/drivers/sysreset/sysreset_msm-pshold.c
new file mode 100644
index 0000000000..d25a412954
--- /dev/null
+++ b/drivers/sysreset/sysreset_msm-pshold.c
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
+struct msm_pshold_priv {
+	phys_addr_t base;
+};
+
+static int msm_pshold_request(struct udevice *dev, enum sysreset_t type)
+{
+	struct msm_pshold_priv *priv = dev_get_priv(dev);
+
+	writel(0, priv->base);
+	mdelay(10000);
+
+	return 0;
+}
+
+static struct sysreset_ops msm_pshold_ops = {
+	.request = msm_pshold_request,
+};
+
+static int msm_pshold_probe(struct udevice *dev)
+{
+	struct msm_pshold_priv *priv = dev_get_priv(dev);
+
+	priv->base = dev_read_addr(dev);
+	return priv->base == FDT_ADDR_T_NONE ? -EINVAL : 0;
+}
+
+static const struct udevice_id msm_pshold_ids[] = {
+	{ .compatible = "qcom,pshold", },
+	{ /* sentinel */ }
+};
+
+U_BOOT_DRIVER(msm_pshold) = {
+	.name 		= "msm_pshold",
+	.id 		= UCLASS_SYSRESET,
+	.of_match 	= msm_pshold_ids,
+	.probe 		= msm_pshold_probe,
+	.priv_auto	= sizeof(struct msm_pshold_priv),
+	.ops 		= &msm_pshold_ops,
+};
-- 
2.44.0

