Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA571076382
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 14:34:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48F998412A;
	Wed,  1 Apr 2026 16:34:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KVX9oB/c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8080284109; Wed,  1 Apr 2026 16:34:18 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39C7A840AB
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 16:34:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48558d6ef83so70099265e9.3
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 07:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775054055; x=1775658855; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OCnS3ZlhvvW3XbeEgO9yZIoCnqN7iRGngRVh2eKOPzw=;
 b=KVX9oB/ck6mn3WNQwUFtPzPxhjAz+GczSidHDOo3LoxU0LLbaFvxIIN6IH1wZnh3s4
 NdRSKRKBhQnYSnJPgAjag36MZHMHtMeggZPxGtnBvPLVkGeWmMAHvR5uv2wdcXgmTXMV
 e7S67eFH1nDolAMY4IWEKcfen2O2Cg7v+3msea6fl2wG6i5r3ThcORQTRDZ1aklper/M
 if7G69kYbdBBQvZr2hBFTMLY4efFcFDANZ1KI7uKCmZfVjD3E/kA9s+pjZFXFDMkI16P
 Kp7v8TAKaHxt33fKJhDF2P7eQN+eihu0xhLzEZsH7X7C2fS8T8gvrBjALtj54HzoI0dS
 otAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775054055; x=1775658855;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OCnS3ZlhvvW3XbeEgO9yZIoCnqN7iRGngRVh2eKOPzw=;
 b=lWRKG6uSRTbuXc2ZwsK8hghSP6uKgcnCehOWox/JmFTsmVmYyRGjy/OP2nJ9HBN8qV
 wknTISS+A40E3EkJoF2uzI1YxnYvGsFzb5jv03qtqjsVCHeDgZ8yfruY4TDmSWQRgmM5
 wxbrxGU7cr7UGZMzsoCDMSGFiscpjmSWVMYRQoAx0m3xZBIsZq4XyFYHmLMTvEMzVPzB
 n/j5ZN4KlwHb5LaruhMEkMdwMqqdDN9bM24/MAUHzVa8dq+gKyJISbOCPBkgavZBoN65
 TQkL/Nv+feXwZMtcMBR2k5A1T7VTz38iNn/QzNKiZ5fS1WO2tKv2uv656FE3zbXy3s65
 bLtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/0UOTzardB/cF4lkYc+DTlH2UngzfU3+sJ4Vm3Q/suYPTDw3bY0KcaSwnxApIh8RO2HTMf+c=@lists.denx.de
X-Gm-Message-State: AOJu0Yxu/kbIjn2JaOJx6PJpx2k4hfUnKxqxmMNTW5i7iQS7b/K29hG/
 +2zYJ6eWJfuooWKesVhoAPShTSS3FblBSBAApDxFuia/hwXRVJjgpI78g88X6o3cOec=
X-Gm-Gg: ATEYQzwH5T3Rqu6/e70g9uDnlJfbR3eeuIws82i5nH4iI2LNRtOergwACH5K89715GO
 sxPFTysUcOenYPSBp7bdP1B/Myvyc1NAhHLGmp4efgYBGWmuOndmh+dt5f77HTGGFicY1jLv15h
 ixUjTKPRjrIEsa7mYu2WpRRIvndRaCIFZTH71s61akYOGotdFE4UWaFRxIl3C+fzRpnfYNY+SPw
 cLk6+fOQEoHm3ScvHBF4gTt2oLfKECITsCvd67lvQsmtEBGR5SG0gIdni6nTVklX6Ou0Qul0/Nn
 uIIClshxUhn9lzky/ceZNGdtL4V39QV2HLjGTVaI9DsV0DOJWndlYXQCL8l1xS+Uy7vpqPOpr7j
 mbf5uR/nlOX8COXm/sJnCx1W2Vpt2D2O5H+FS35HOIBJPS0Pih4+2P7Fd12kypN6iVI+awm8wWZ
 DCQiFxolUEJjF3te//pxuBpG7rLXKb/vcPuuqk+7l7KTEJ5Fs1usbBT+gRI4i1MY1QmUmC
X-Received: by 2002:a05:600d:8:b0:486:ffa3:594 with SMTP id
 5b1f17b1804b1-488835b760amr57222135e9.23.1775054055029; 
 Wed, 01 Apr 2026 07:34:15 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e80a63esm161821795e9.3.2026.04.01.07.34.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 07:34:14 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Wed, 01 Apr 2026 16:34:03 +0200
Subject: [PATCH v2 2/7] clk: move U-Boot CCF to clk/uccf
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-casey-ccf-clk-prep-v2-2-16a78c8c62da@linaro.org>
References: <20260401-casey-ccf-clk-prep-v2-0-16a78c8c62da@linaro.org>
In-Reply-To: <20260401-casey-ccf-clk-prep-v2-0-16a78c8c62da@linaro.org>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marex@denx.de>
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, u-boot-qcom@groups.io
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=9240;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=/RAbNGoLPbHbhn8quS6iAUljDwLpWmzJA+HtFCQI1Qk=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsyzOo/2HEm18d9l41qb89ejsib5SFZxWFt3pUNrL4f6U
 dfp4tc6SlkYBDkYZMUUWcRPLLNsWnvZXmP7ggswc1iZQIYwcHEKwETSGhj+J588eaNvw6r159WW
 5hvMS0nRmpKhefiN0o5uh9+S6akz4xn+u/XaJu7JK605Mun6+etTfKtXOUz55a1ussD8LsPl1i3
 FYgA=
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Prepare for the introduction of full CCF support by moving the existing
U-Boot CCF support to a uccf subdirectory.

Due to a number of incompatibilities it won't be possible to support
existing U-Boot CCF clocks with the full CCF, this allows us to support
both. While it may make sense to remove U-Boot CCF in the future, it may
be necessary to continue supporting it to meet space/memory requirements
in SPL for some platforms.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/clk/Kconfig                                | 51 +++++++---------------
 drivers/clk/Makefile                               |  7 ++-
 drivers/clk/uccf/Kconfig                           | 22 ++++++++++
 drivers/clk/uccf/Makefile                          | 11 +++++
 drivers/clk/{ => uccf}/clk-composite.c             |  0
 drivers/clk/{ => uccf}/clk-divider.c               |  0
 drivers/clk/{ => uccf}/clk-fixed-factor.c          |  0
 drivers/clk/{ => uccf}/clk-gate.c                  |  0
 drivers/clk/{ => uccf}/clk-mux.c                   |  0
 drivers/clk/{ => uccf}/clk.c                       |  0
 .../{clk_sandbox_ccf.c => uccf/clk_sandbox_uccf.c} |  2 +-
 include/sandbox-clk.h                              |  2 +-
 12 files changed, 54 insertions(+), 41 deletions(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index c88931c8ec4d..5cc76cd55cc8 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -10,8 +10,24 @@ config CLK
 	  a particular clock rate and check on available clocks. Clocks can
 	  feed into other clocks in a tree structure, with multiplexers to
 	  choose the source for each clock.
 
+source "drivers/clk/uccf/Kconfig"
+
+config SANDBOX_CLK_CCF
+	bool "Sandbox U-Boot Common Clock Framework [uCCF] support"
+	depends on SANDBOX && (CLK_CCF || CLK_CCF_FULL)
+	help
+	  Enable this option if you want to test the Linux kernel's Common
+	  Clock Framework [CCF] code in U-Boot's Sandbox clock driver.
+
+config CLK_COMPOSITE_CCF
+	bool "Common Clock Framework [CCF] composite clk support"
+	depends on CLK_CCF || CLK_CCF_FULL
+	help
+	  Enable this option if you want to (re-)use the Linux kernel's Common
+	  Clock Framework [CCF] composite code in U-Boot's clock driver.
+
 config CLK_AUTO_ID
 	bool "Enable support of an unique clock id with several provider"
 	depends on CLK
 	help
@@ -66,35 +82,8 @@ config CLK_BOSTON
 	select SYSCON
 	help
 	  Enable this to support the clocks
 
-config SPL_CLK_CCF
-	bool "SPL Common Clock Framework [CCF] support"
-	depends on SPL
-	help
-	  Enable this option if you want to (re-)use the Linux kernel's Common
-	  Clock Framework [CCF] code in U-Boot's SPL.
-
-config SPL_CLK_COMPOSITE_CCF
-	bool "SPL Common Clock Framework [CCF] composite clk support"
-	depends on SPL_CLK_CCF
-	help
-	  Enable this option if you want to (re-)use the Linux kernel's Common
-	  Clock Framework [CCF] composite code in U-Boot's SPL.
-
-config CLK_CCF
-	bool "Common Clock Framework [CCF] support"
-	help
-	  Enable this option if you want to (re-)use the Linux kernel's Common
-	  Clock Framework [CCF] code in U-Boot's clock driver.
-
-config CLK_COMPOSITE_CCF
-	bool "Common Clock Framework [CCF] composite clk support"
-	depends on CLK_CCF
-	help
-	  Enable this option if you want to (re-)use the Linux kernel's Common
-	  Clock Framework [CCF] composite code in U-Boot's clock driver.
-
 config CLK_GPIO
 	bool "GPIO-controlled clock gate driver"
 	depends on CLK
 	help
@@ -180,16 +169,8 @@ config CLK_OCTEON
 	default y
 	help
 	  Enable this to support the clocks on Octeon MIPS platforms.
 
-config SANDBOX_CLK_CCF
-	bool "Sandbox Common Clock Framework [CCF] support"
-	depends on SANDBOX
-	select CLK_CCF
-	help
-	  Enable this option if you want to test the Linux kernel's Common
-	  Clock Framework [CCF] code in U-Boot's Sandbox clock driver.
-
 config CLK_SCMI
 	bool "Enable SCMI clock driver"
 	depends on CLK
 	depends on SCMI_FIRMWARE
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index f96d57a3223a..30991e9f55d7 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -6,14 +6,14 @@
 
 obj-$(CONFIG_$(PHASE_)CLK) += clk-uclass.o
 obj-$(CONFIG_$(PHASE_)CLK) += clk_fixed_rate.o
 obj-$(CONFIG_$(PHASE_)CLK) += clk_fixed_factor.o
-obj-$(CONFIG_$(PHASE_)CLK_CCF) += clk.o clk-divider.o clk-mux.o clk-gate.o
-obj-$(CONFIG_$(PHASE_)CLK_CCF) += clk-fixed-factor.o
-obj-$(CONFIG_$(PHASE_)CLK_COMPOSITE_CCF) += clk-composite.o
 obj-$(CONFIG_$(PHASE_)CLK_GPIO) += clk-gpio.o
 obj-$(CONFIG_$(PHASE_)CLK_STUB) += clk-stub.o
 
+# U-Boot/IMX "micro" CCF port
+obj-$(CONFIG_$(PHASE_)CLK_CCF) += uccf/
+
 obj-y += adi/
 obj-y += airoha/
 obj-y += analogbits/
 obj-$(CONFIG_$(PHASE_)MACH_IMX) += imx/
@@ -57,7 +57,6 @@ obj-$(CONFIG_CLK_XLNX_CLKWZRD) += clk-xlnx-clock-wizard.o
 obj-$(CONFIG_CLK_ZYNQ) += clk_zynq.o
 obj-$(CONFIG_CLK_ZYNQMP) += clk_zynqmp.o
 obj-$(CONFIG_CLK_ICS8N3QV01) += ics8n3qv01.o
 obj-$(CONFIG_MACH_PIC32) += clk_pic32.o
-obj-$(CONFIG_SANDBOX_CLK_CCF) += clk_sandbox_ccf.o
 obj-$(CONFIG_SANDBOX) += clk_sandbox.o
 obj-$(CONFIG_SANDBOX) += clk_sandbox_test.o
diff --git a/drivers/clk/uccf/Kconfig b/drivers/clk/uccf/Kconfig
new file mode 100644
index 000000000000..bf4a634a403f
--- /dev/null
+++ b/drivers/clk/uccf/Kconfig
@@ -0,0 +1,22 @@
+
+
+config SPL_CLK_CCF
+	bool "SPL U-Boot Common Clock Framework [uCCF] support"
+	depends on SPL
+	help
+	  Enable this option if you want to (re-)use the Linux kernel's Common
+	  Clock Framework [CCF] code in U-Boot's SPL.
+
+config SPL_CLK_COMPOSITE_CCF
+	bool "SPL U-Boot Common Clock Framework [uCCF] composite clk support"
+	depends on SPL_CLK_CCF
+	help
+	  Enable this option if you want to (re-)use the Linux kernel's Common
+	  Clock Framework [CCF] composite code in U-Boot's SPL.
+
+config CLK_CCF
+	bool "U-Boot Common Clock Framework [uCCF] support"
+	help
+	  Enable this option if you want to (re-)use the Linux kernel's Common
+	  Clock Framework [CCF] code in U-Boot's clock driver.
+
diff --git a/drivers/clk/uccf/Makefile b/drivers/clk/uccf/Makefile
new file mode 100644
index 000000000000..02440b5e322c
--- /dev/null
+++ b/drivers/clk/uccf/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (c) 2015 Google, Inc
+# Wolfgang Denk, DENX Software Engineering, wd@denx.de.
+#
+
+obj-$(CONFIG_$(PHASE_)CLK_CCF) += clk.o clk-divider.o clk-mux.o clk-gate.o
+obj-$(CONFIG_$(PHASE_)CLK_CCF) += clk-fixed-factor.o
+obj-$(CONFIG_$(PHASE_)CLK_COMPOSITE_CCF) += clk-composite.o
+
+obj-$(CONFIG_SANDBOX_CLK_CCF) += clk_sandbox_uccf.o
diff --git a/drivers/clk/clk-composite.c b/drivers/clk/uccf/clk-composite.c
similarity index 100%
rename from drivers/clk/clk-composite.c
rename to drivers/clk/uccf/clk-composite.c
diff --git a/drivers/clk/clk-divider.c b/drivers/clk/uccf/clk-divider.c
similarity index 100%
rename from drivers/clk/clk-divider.c
rename to drivers/clk/uccf/clk-divider.c
diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/uccf/clk-fixed-factor.c
similarity index 100%
rename from drivers/clk/clk-fixed-factor.c
rename to drivers/clk/uccf/clk-fixed-factor.c
diff --git a/drivers/clk/clk-gate.c b/drivers/clk/uccf/clk-gate.c
similarity index 100%
rename from drivers/clk/clk-gate.c
rename to drivers/clk/uccf/clk-gate.c
diff --git a/drivers/clk/clk-mux.c b/drivers/clk/uccf/clk-mux.c
similarity index 100%
rename from drivers/clk/clk-mux.c
rename to drivers/clk/uccf/clk-mux.c
diff --git a/drivers/clk/clk.c b/drivers/clk/uccf/clk.c
similarity index 100%
rename from drivers/clk/clk.c
rename to drivers/clk/uccf/clk.c
diff --git a/drivers/clk/clk_sandbox_ccf.c b/drivers/clk/uccf/clk_sandbox_uccf.c
similarity index 98%
rename from drivers/clk/clk_sandbox_ccf.c
rename to drivers/clk/uccf/clk_sandbox_uccf.c
index 9b8036d41aac..9c74ed940acd 100644
--- a/drivers/clk/clk_sandbox_ccf.c
+++ b/drivers/clk/uccf/clk_sandbox_uccf.c
@@ -112,9 +112,9 @@ static const struct clk_ops clk_gate2_ops = {
 	.disable = clk_gate2_disable,
 	.get_rate = clk_generic_get_rate,
 };
 
-struct clk *sandbox_clk_register_gate2(struct device *dev, const char *name,
+struct clk *sandbox_clk_register_gate2(struct udevice *dev, const char *name,
 				       const char *parent_name,
 				       unsigned long flags, void __iomem *reg,
 				       u8 bit_idx, u8 cgr_val,
 				       u8 clk_gate2_flags)
diff --git a/include/sandbox-clk.h b/include/sandbox-clk.h
index c2616c27a44a..eb02a474c741 100644
--- a/include/sandbox-clk.h
+++ b/include/sandbox-clk.h
@@ -57,9 +57,9 @@ static inline struct clk *sandbox_clk_gate(const char *name, const char *parent,
 	return clk_register_gate(NULL, name, parent, CLK_SET_RATE_PARENT,
 				 reg, bit_idx, clk_gate_flags, NULL);
 }
 
-struct clk *sandbox_clk_register_gate2(struct device *dev, const char *name,
+struct clk *sandbox_clk_register_gate2(struct udevice *dev, const char *name,
 				       const char *parent_name,
 				       unsigned long flags,
 				       void __iomem *reg, u8 bit_idx,
 				       u8 cgr_val, u8 clk_gate_flags);

-- 
2.51.0

