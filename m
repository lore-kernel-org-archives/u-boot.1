Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085FCC00A8F
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 07:49:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18F048714E;
	Tue, 24 Oct 2023 09:49:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P98ulQEn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE21187159; Tue, 24 Oct 2023 09:49:29 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20C0687141
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 09:49:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-507c91582fdso6142794e87.2
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 00:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698133764; x=1698738564; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BSNYImZ+6x42mOnLRUPZUyMatggRfflCcWQ6vewDBZQ=;
 b=P98ulQEnMOyu/XnzVy4hhTZuDMHupHir9y5pSs95QNTYPUqi+Sighh34jafhhpy0Tk
 M4LOF109VN8KyHTLFH1QFRZnJ4JxTOEHkEv7XHazhnHWTCBirCxGZx1HZptXISkgm1+q
 yfXssibCB2xZ6LrQVHGQu9WMq4IwcwT7PTzTVZzKLk31AyGS2+ecZr+YVK0WgX3tbjoU
 QFtqEjESNMeHyrYfjrUzX07A60/JZNrAPPTGVIgnsfk/RpWlW+jy0FIN9jJ6s1jFado4
 5PCoLbjVRFmhkPjjh18bZ/Bn7dVYmAvDqMQSX4n26AVCbm2dHsMYjyndmxMu74uYXoau
 Iwsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698133764; x=1698738564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BSNYImZ+6x42mOnLRUPZUyMatggRfflCcWQ6vewDBZQ=;
 b=qeuOBL3CrRwcH2DMvFGn4Wgl1fJYXPUNuATNOsS0w4NUmmo+PiSRC9bjN4w7vaqS1B
 W5cVF5nzRwlP/HzOg1JcMg1NRG3azAEH+WC6IYyuuKMb89YTJj5Dz265cAK5n5YFVyd3
 AC1hM+epHJu5/Tq92az6QGMUptJ0rFurGU9OTb6p8Gg+8XV6dfVjmR0EVDu4ann1ADp0
 zH3H/nySPXB+TUEnieEUQuqVIGZY+H9MwmuTrRWb0fcU4R7XcuCctDa3+2tkgMi4aBpX
 Pcfry5QxhDC4Krb4kwmWlNF0KaxO2kJPWhhNW62RlB4lbag+fYFBqzIvfODGptIda7Lz
 I74Q==
X-Gm-Message-State: AOJu0Yyw+ylyjpPDvI7uNdVz+Mz/GhfpJIA1bKOVKiI/J7XS8wc3TDNc
 S6g6hE98WUSBuTsSIQYVFU4=
X-Google-Smtp-Source: AGHT+IGOnTHppzOHFFpJUbtnPK/2ohPuykNCt3WetDHoJiZ920F0o/+qSOS/HTpj2mfi5F2grotImA==
X-Received: by 2002:ac2:5a0a:0:b0:4f8:7772:3dfd with SMTP id
 q10-20020ac25a0a000000b004f877723dfdmr7754952lfn.11.1698133764369; 
 Tue, 24 Oct 2023 00:49:24 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 v25-20020ac25939000000b00507a89ef9bbsm2011741lfi.166.2023.10.24.00.49.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 00:49:23 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v4 1/6] sysreset: tegra: create arch specific sysreset driver
Date: Tue, 24 Oct 2023 10:49:03 +0300
Message-Id: <20231024074908.199903-2-clamor95@gmail.com>
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

