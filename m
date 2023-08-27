Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 473CAC83F01
	for <u-boot@archiver.kernel.org>; Sun, 27 Aug 2023 08:21:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A67A8608A;
	Sun, 27 Aug 2023 10:21:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NIcWy7GW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14AD080726; Sun, 27 Aug 2023 10:21:32 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CAA98470A
 for <u-boot@lists.denx.de>; Sun, 27 Aug 2023 10:21:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-52a069edca6so3243139a12.3
 for <u-boot@lists.denx.de>; Sun, 27 Aug 2023 01:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693124489; x=1693729289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BSNYImZ+6x42mOnLRUPZUyMatggRfflCcWQ6vewDBZQ=;
 b=NIcWy7GWxlPwsIjnOrR86ynNfrI/5jY5WeacIqsrfK8PLzBp3vXrut4HJ+cXE9zT99
 I3P/vyFIbAaEOpP6hhqFYDBIEkH+eGktJJyzJ4mH0mGdEwlW/bkAr9Iv9o4ZTVmqKR2+
 Dc0h6tacrtSjUBFrHcZxreA8sYMb32o6rFQadmYLYejfi9jDV7l/RqdccaJBoFZGgGGP
 zEU+t3v0up4Q1ZI4XOSQFDRgqHzjXIIGe6VqAl45p2WstrnmF1noc9nG4qqn/5Sk4C5a
 zhdtkcmvXVL6cQUFmt23tZiSqK1V3t2N3ff+gsP729OBRbdGQjOP9CL1SWtoZSNKGNJM
 7Tng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693124489; x=1693729289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BSNYImZ+6x42mOnLRUPZUyMatggRfflCcWQ6vewDBZQ=;
 b=bmH/8RFV4ckjt5J+fK3XGScj76zwHQ084Zdm65UtVzCgyHUa2KJjYJ593Is1Sod5ue
 kuxWiDnYMN95kfTJM4XY3b5yjSm6tjHQPfvMfe6vfVnuuflMXMJIGhU6dl1EIyhXrw2j
 HF8bO0hqqESiYSA7gOi4u8JGmQM/LggsM0JBunBADqP9fODkd9KsjGRSbq3lmr5+tbWO
 LPZACymz5nM4S9fYS6g6r7ekPzaerhUEZSozfte/SCuqYrtm+GlwxYCt6qHz4JSsBFhX
 B9BgJlm0ThonRt4dK0bAbQH3FfUCB9vpbeulvLF7EcFTexKPhjcu5UuQXB63Tt07/R+q
 L80A==
X-Gm-Message-State: AOJu0Yyl0AqnysRm1sWFay1KBlc81XYiWwuRJnFLFm3TZypfrPZvz+7j
 xPgdBTV+57fK/T3NAAHWQfc=
X-Google-Smtp-Source: AGHT+IGttXp0+y/vZbR+20MYH6LLkEoOmWrW1u7T8C17kDLkHsorPMhM7cmEbI9M5tcfHdRc4mm96A==
X-Received: by 2002:a17:906:519b:b0:9a1:fa4e:ca83 with SMTP id
 y27-20020a170906519b00b009a1fa4eca83mr9139320ejk.65.1693124488550; 
 Sun, 27 Aug 2023 01:21:28 -0700 (PDT)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 i10-20020a170906250a00b0099b5a71b0bfsm3153433ejb.94.2023.08.27.01.21.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Aug 2023 01:21:28 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 1/6] sysreset: tegra: create arch specific sysreset driver
Date: Sun, 27 Aug 2023 11:21:01 +0300
Message-Id: <20230827082106.6255-2-clamor95@gmail.com>
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

Tegra uses built in Power Management Controller (PMC) to perform
CPU reset. Code to perform this was located in mach-tegra, so lest
create DM driver to handle this.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/sysreset/Kconfig          |  6 ++++
 drivers/sysreset/Makefile         |  1 +
 drivers/sysreset/sysreset_tegra.c | 46 +++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+)
 create mode 100644 drivers/sysreset/sysreset_tegra.c

diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
index bdbe2a9536..eab556c349 100644
--- a/drivers/sysreset/Kconfig
+++ b/drivers/sysreset/Kconfig
@@ -137,6 +137,12 @@ config SYSRESET_SOCFPGA_SOC64
 	  This enables the system reset driver support for Intel SOCFPGA
 	  SoC64 SoCs.
 
+config SYSRESET_TEGRA
+	bool "Tegra PMC system reset driver"
+	depends on ARCH_TEGRA
+	help
+	  This enables the system reset ability of PMC used in Tegra SoCs.
+
 config SYSRESET_TI_SCI
 	bool "TI System Control Interface (TI SCI) system reset driver"
 	depends on TI_SCI_PROTOCOL
diff --git a/drivers/sysreset/Makefile b/drivers/sysreset/Makefile
index 40c876764a..a9ac123754 100644
--- a/drivers/sysreset/Makefile
+++ b/drivers/sysreset/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_SYSRESET_PSCI) += sysreset_psci.o
 obj-$(CONFIG_SYSRESET_SBI) += sysreset_sbi.o
 obj-$(CONFIG_SYSRESET_SOCFPGA) += sysreset_socfpga.o
 obj-$(CONFIG_SYSRESET_SOCFPGA_SOC64) += sysreset_socfpga_soc64.o
+obj-$(CONFIG_SYSRESET_TEGRA) += sysreset_tegra.o
 obj-$(CONFIG_SYSRESET_TI_SCI) += sysreset-ti-sci.o
 obj-$(CONFIG_SYSRESET_SYSCON) += sysreset_syscon.o
 obj-$(CONFIG_SYSRESET_WATCHDOG) += sysreset_watchdog.o
diff --git a/drivers/sysreset/sysreset_tegra.c b/drivers/sysreset/sysreset_tegra.c
new file mode 100644
index 0000000000..ee95826a29
--- /dev/null
+++ b/drivers/sysreset/sysreset_tegra.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright(C) 2023 Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#include <common.h>
+#include <dm.h>
+#include <errno.h>
+#include <sysreset.h>
+#include <linux/err.h>
+#include <asm/arch-tegra/pmc.h>
+
+static int tegra_sysreset_request(struct udevice *dev,
+				  enum sysreset_t type)
+{
+	u32 value;
+
+	switch (type) {
+	case SYSRESET_WARM:
+	case SYSRESET_COLD:
+		/* resets everything but scratch 0 and reset status */
+		value = tegra_pmc_readl(PMC_CNTRL);
+		value |= PMC_CNTRL_MAIN_RST;
+		tegra_pmc_writel(value, PMC_CNTRL);
+		break;
+	default:
+		return -EPROTONOSUPPORT;
+	}
+
+	return -EINPROGRESS;
+}
+
+static struct sysreset_ops tegra_sysreset = {
+	.request = tegra_sysreset_request,
+};
+
+U_BOOT_DRIVER(sysreset_tegra) = {
+	.id	= UCLASS_SYSRESET,
+	.name	= "sysreset_tegra",
+	.ops	= &tegra_sysreset,
+};
+
+/* Link to Tegra PMC once there is a driver */
+U_BOOT_DRVINFO(sysreset_tegra) = {
+	.name = "sysreset_tegra"
+};
-- 
2.39.2

