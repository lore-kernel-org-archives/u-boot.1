Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D7EBEE57C7
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 06:13:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71B0E88DC4;
	Thu, 12 Sep 2024 08:13:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z75Jj76f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9763788DBB; Thu, 12 Sep 2024 08:06:57 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B944188D70
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 08:06:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a8a765f980dso7001966b.1
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 23:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726121214; x=1726726014; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XuXUBbV1hZTsObqmbjXXCuUwHIF3eQ3REbQ/6WwkCvs=;
 b=Z75Jj76fWUhu/TJ5f2YO4YmsS8IJxf2a/pfunefh3VjbnuypBsXH9vIbyGCKoqwdpv
 8OZStbi2U6xS9uq8iPzUPLhOg2kJiMMKNeSo4v4NKlRz/vZ/ZnCCZsRWwh8rotVOH1+G
 Led8uZZ3SFh6KPDv955txYHjsXr063Gy8+0J8ffSCNZdk1Y9zGu9hpGXWicJcni6HmDu
 SlMHe1svhG89mFPC+qTKZVk3s5MYZ+CG19vmgBhnDo49PaR/tzx/ykeEOf35TzT5C4Bp
 A/NV0TJs3Uy5XfXN+9zfN0zxrKZYlXMZ/SUb2cw0A0440uSS5wKrdKPDdcXN+q4kkXBB
 +g5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726121214; x=1726726014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XuXUBbV1hZTsObqmbjXXCuUwHIF3eQ3REbQ/6WwkCvs=;
 b=mbKJ7UgL0HPsM3WTriM4CGFpmGA+gEYYGW8L4NpcwUMmD1YT/zzUSkUcw2manSYcMN
 Ie9Ghhi2JymCBvo+ILlCu3ZvQhC1cDz0wkaILyVuhYyQvdzL8GaLFUHGRMT0FAob9fdW
 gCMP3qTazD2eh6nDTMwjdafhD0pGpzY4+nsRl2uWLtxVlw3VL9gdoGMgN2Yr9rAOO62g
 in7HYWhOp6I/kEbo7d3w8gXCz92i98WdFkfsWQxWGLcGP2qK0zv0DW/wHKOOT3Q9n59A
 qtufMn4AuXoirgG6sSqEytDCGuw9jCyIEtWAqP/LBz2kG74tnpst2LCtJG3KCqZmjdwg
 53wA==
X-Gm-Message-State: AOJu0YxBrUbUmESRWBgRB46rKUpZzsag1BuVOd8i4XhgxDdRcQt4hiI+
 uIojYGemDt9WvLqJkpI4YxmpxpYt3UAGQpuZwZPaOl5CwG9cobTTXNb4Qw==
X-Google-Smtp-Source: AGHT+IHk/P+BMAegJ1xfuihoT1y7sFqbyCcL2J55THL1wV+e3utKz5iQkv2me76+gMOQNMBuvILYtA==
X-Received: by 2002:a17:907:97c8:b0:a90:17fc:3f60 with SMTP id
 a640c23a62f3a-a902949aeacmr64853066b.8.1726121213017; 
 Wed, 11 Sep 2024 23:06:53 -0700 (PDT)
Received: from 77c10117340a.v.cablecom.net (84-72-156-211.dclient.hispeed.ch.
 [84.72.156.211]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d2598b844sm698112866b.76.2024.09.11.23.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 23:06:52 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: u-boot@lists.denx.de, trini@konsulko.com, marex@denx.de,
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com
Cc: l.rubusch@gmail.com
Subject: [PATCH 2/9] ARM: dts: socfpga: add Enclustra Intel AA1
Date: Thu, 12 Sep 2024 06:06:42 +0000
Message-Id: <20240912060649.190-3-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240912060649.190-1-l.rubusch@gmail.com>
References: <20240912060649.190-1-l.rubusch@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 12 Sep 2024 08:13:00 +0200
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

Introduce device-tree files for Enclustra Intel AA1 SoMs and related
support.

- Mercury AA1

The setup depends on a selected boot mode. Various fragments for SD/MMC
and QSPI flash boot are provided.

In combination, the following Enclustra carrier boards are supported:

- ST1
- PE1
- PE3

Signed-off-by: Andreas Buerkler <andreas.buerkler@enclustra.com>
Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 arch/arm/dts/ME-AA1-270-2I2-D11E-NFX3.dtsi    |  14 +
 arch/arm/dts/ME-AA1-270-3E4-D11E-NFX3.dtsi    |  14 +
 arch/arm/dts/ME-AA1-480-2I3-D12E-NFX3.dtsi    |  15 +
 arch/arm/dts/Makefile                         |   2 +
 arch/arm/dts/enclustra-aa1.dts                |  32 ++
 .../dts/socfpga_arria10_mercury_aa1_handoff.h | 307 ++++++++++++++++++
 .../dts/socfpga_enclustra_mercury_aa1.dtsi    | 179 ++++++++++
 ...cfpga_enclustra_mercury_aa1_qspi_boot.dtsi |  18 +
 ...fpga_enclustra_mercury_aa1_sdmmc_boot.dtsi |  18 +
 .../dts/socfpga_enclustra_mercury_pe1.dtsi    |   7 +
 .../dts/socfpga_enclustra_mercury_pe3.dtsi    |   8 +
 .../dts/socfpga_enclustra_mercury_st1.dtsi    |   8 +
 12 files changed, 622 insertions(+)
 create mode 100644 arch/arm/dts/ME-AA1-270-2I2-D11E-NFX3.dtsi
 create mode 100644 arch/arm/dts/ME-AA1-270-3E4-D11E-NFX3.dtsi
 create mode 100644 arch/arm/dts/ME-AA1-480-2I3-D12E-NFX3.dtsi
 create mode 100644 arch/arm/dts/enclustra-aa1.dts
 create mode 100644 arch/arm/dts/socfpga_arria10_mercury_aa1_handoff.h
 create mode 100644 arch/arm/dts/socfpga_enclustra_mercury_aa1.dtsi
 create mode 100644 arch/arm/dts/socfpga_enclustra_mercury_aa1_qspi_boot.dtsi
 create mode 100644 arch/arm/dts/socfpga_enclustra_mercury_aa1_sdmmc_boot.dtsi
 create mode 100644 arch/arm/dts/socfpga_enclustra_mercury_pe1.dtsi
 create mode 100644 arch/arm/dts/socfpga_enclustra_mercury_pe3.dtsi
 create mode 100644 arch/arm/dts/socfpga_enclustra_mercury_st1.dtsi

diff --git a/arch/arm/dts/ME-AA1-270-2I2-D11E-NFX3.dtsi b/arch/arm/dts/ME-AA1-270-2I2-D11E-NFX3.dtsi
new file mode 100644
index 0000000000..75550a77c9
--- /dev/null
+++ b/arch/arm/dts/ME-AA1-270-2I2-D11E-NFX3.dtsi
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/ {
+	model = "Enclustra Mercury+ AA1";
+
+	memory@0 {
+		name = "memory";
+		device_type = "memory";
+		reg = <0x0 0x80000000>; /* 2GB */
+	};
+};
diff --git a/arch/arm/dts/ME-AA1-270-3E4-D11E-NFX3.dtsi b/arch/arm/dts/ME-AA1-270-3E4-D11E-NFX3.dtsi
new file mode 100644
index 0000000000..75550a77c9
--- /dev/null
+++ b/arch/arm/dts/ME-AA1-270-3E4-D11E-NFX3.dtsi
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/ {
+	model = "Enclustra Mercury+ AA1";
+
+	memory@0 {
+		name = "memory";
+		device_type = "memory";
+		reg = <0x0 0x80000000>; /* 2GB */
+	};
+};
diff --git a/arch/arm/dts/ME-AA1-480-2I3-D12E-NFX3.dtsi b/arch/arm/dts/ME-AA1-480-2I3-D12E-NFX3.dtsi
new file mode 100644
index 0000000000..9ba850a84b
--- /dev/null
+++ b/arch/arm/dts/ME-AA1-480-2I3-D12E-NFX3.dtsi
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/ {
+	model = "Enclustra Mercury+ AA1";
+
+	/* The module is equipped with 4Gbyte RAM but U-Boot limits the size to 2 Gbyte */
+	memory@0 {
+		name = "memory";
+		device_type = "memory";
+		reg = <0x0 0x80000000>; /* 2GB */
+	};
+};
diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 64007a20e6..2fcc4512ef 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -414,6 +414,8 @@ dtb-$(CONFIG_ARCH_SOCFPGA) +=				\
 	socfpga_n5x_socdk.dtb				\
 	socfpga_stratix10_socdk.dtb
 
+dtb-$(CONFIG_TARGET_SOCFPGA_ENCLUSTRA_MERCURY_AA1) += enclustra-aa1.dtb
+
 dtb-$(CONFIG_TARGET_DRA7XX_EVM) += dra72-evm.dtb dra7-evm.dtb	\
 	dra72-evm-revc.dtb dra71-evm.dtb dra76-evm.dtb
 dtb-$(CONFIG_TARGET_AM57XX_EVM) += am57xx-beagle-x15.dtb \
diff --git a/arch/arm/dts/enclustra-aa1.dts b/arch/arm/dts/enclustra-aa1.dts
new file mode 100644
index 0000000000..09df8c846a
--- /dev/null
+++ b/arch/arm/dts/enclustra-aa1.dts
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/dts-v1/;
+
+/* arria10 family - NB: keep the order of the includes */
+#include "socfpga_arria10.dtsi"
+#include "socfpga_arria10-u-boot.dtsi"
+
+/* The generated handoff.h goes here */
+#include "socfpga_arria10_mercury_aa1_handoff.h"
+
+/* Generic arria10 glue */
+#include "socfpga_arria10-handoff.dtsi"
+#include "socfpga_arria10_handoff_u-boot.dtsi"
+#include "socfpga_enclustra_mercury_aa1.dtsi"
+
+/* Select the boot mode: sd/mmc or qspi */
+//#include "socfpga_enclustra_mercury_aa1_qspi_boot.dtsi"
+#include "socfpga_enclustra_mercury_aa1_sdmmc_boot.dtsi"
+
+/* Select the carrier board */
+//#include "socfpga_enclustra_mercury_st1.dtsi"
+#include "socfpga_enclustra_mercury_pe1.dtsi"
+//#include "socfpga_enclustra_mercury_pe3.dtsi"
+
+/* Select the type of AA1 module */
+//#include "ME-AA1-270-2I2-D11E-NFX3.dtsi"
+//#include "ME-AA1-270-3E4-D11E-NFX3.dtsi"
+#include "ME-AA1-480-2I3-D12E-NFX3.dtsi"
diff --git a/arch/arm/dts/socfpga_arria10_mercury_aa1_handoff.h b/arch/arm/dts/socfpga_arria10_mercury_aa1_handoff.h
new file mode 100644
index 0000000000..46e7e3c18b
--- /dev/null
+++ b/arch/arm/dts/socfpga_arria10_mercury_aa1_handoff.h
@@ -0,0 +1,307 @@
+/* SPDX-License-Identifier: BSD-3-Clause */
+/*
+ * Intel Arria 10 SoCFPGA configuration
+ *
+ * Copyright (C) 2024 Enclustra GmbH
+ */
+
+#ifndef __SOCFPGA_ARRIA10_CONFIG_H__
+#define __SOCFPGA_ARRIA10_CONFIG_H__
+
+/* Clocks */
+#define CB_INTOSC_LS_CLK_HZ 60000000
+#define EMAC0_CLK_HZ 250000000
+#define EMAC1_CLK_HZ 250000000
+#define EMAC2_CLK_HZ 250000000
+#define EOSC1_CLK_HZ 33333000
+#define F2H_FREE_CLK_HZ 200000000
+#define H2F_USER0_CLK_HZ 100000000
+#define H2F_USER1_CLK_HZ 50000000
+#define L3_MAIN_FREE_CLK_HZ 400000000
+#define SDMMC_CLK_HZ 200000000
+#define TPIU_CLK_HZ 100000000
+#define MAINPLLGRP_CNTR15CLK_CNT 900
+#define MAINPLLGRP_CNTR2CLK_CNT 900
+#define MAINPLLGRP_CNTR3CLK_CNT 900
+#define MAINPLLGRP_CNTR4CLK_CNT 900
+#define MAINPLLGRP_CNTR5CLK_CNT 900
+#define MAINPLLGRP_CNTR6CLK_CNT 9
+#define MAINPLLGRP_CNTR7CLK_CNT 19
+#define MAINPLLGRP_CNTR7CLK_SRC 0
+#define MAINPLLGRP_CNTR8CLK_CNT 39
+#define MAINPLLGRP_CNTR9CLK_CNT 900
+#define MAINPLLGRP_CNTR9CLK_SRC 0
+#define MAINPLLGRP_MPUCLK_CNT 0
+#define MAINPLLGRP_MPUCLK_SRC 0
+#define MAINPLLGRP_NOCCLK_CNT 0
+#define MAINPLLGRP_NOCCLK_SRC 0
+#define MAINPLLGRP_NOCDIV_CSATCLK 0
+#define MAINPLLGRP_NOCDIV_CSPDBGCLK 1
+#define MAINPLLGRP_NOCDIV_CSTRACECLK 0
+#define MAINPLLGRP_NOCDIV_L4MAINCLK 0
+#define MAINPLLGRP_NOCDIV_L4MPCLK 1
+#define MAINPLLGRP_NOCDIV_L4SPCLK 2
+#define MAINPLLGRP_VCO0_PSRC 0
+#define MAINPLLGRP_VCO1_DENOM 32
+#define MAINPLLGRP_VCO1_NUMER 1980
+#define PERPLLGRP_CNTR2CLK_CNT 7
+#define PERPLLGRP_CNTR2CLK_SRC 1
+#define PERPLLGRP_CNTR3CLK_CNT 900
+#define PERPLLGRP_CNTR3CLK_SRC 1
+#define PERPLLGRP_CNTR4CLK_CNT 19
+#define PERPLLGRP_CNTR4CLK_SRC 1
+#define PERPLLGRP_CNTR5CLK_CNT 499
+#define PERPLLGRP_CNTR5CLK_SRC 1
+#define PERPLLGRP_CNTR6CLK_CNT 900
+#define PERPLLGRP_CNTR6CLK_SRC 0
+#define PERPLLGRP_CNTR7CLK_CNT 900
+#define PERPLLGRP_CNTR8CLK_CNT 900
+#define PERPLLGRP_CNTR8CLK_SRC 0
+#define PERPLLGRP_CNTR9CLK_CNT 900
+#define PERPLLGRP_EMACCTL_EMAC0SEL 0
+#define PERPLLGRP_EMACCTL_EMAC1SEL 0
+#define PERPLLGRP_EMACCTL_EMAC2SEL 0
+#define PERPLLGRP_GPIODIV_GPIODBCLK 32000
+#define PERPLLGRP_VCO0_PSRC 0
+#define PERPLLGRP_VCO1_DENOM 32
+#define PERPLLGRP_VCO1_NUMER 1980
+#define CLKMGR_TESTIOCTRL_DEBUGCLKSEL 16
+#define CLKMGR_TESTIOCTRL_MAINCLKSEL 8
+#define CLKMGR_TESTIOCTRL_PERICLKSEL 8
+#define ALTERAGRP_MPUCLK_MAINCNT 1
+#define ALTERAGRP_MPUCLK_PERICNT 900
+#define ALTERAGRP_NOCCLK_MAINCNT 4
+#define ALTERAGRP_NOCCLK_PERICNT 900
+#define ALTERAGRP_MPUCLK ((ALTERAGRP_MPUCLK_PERICNT << 16) | \
+	(ALTERAGRP_MPUCLK_MAINCNT))
+#define ALTERAGRP_NOCCLK ((ALTERAGRP_NOCCLK_PERICNT << 16) | \
+	(ALTERAGRP_NOCCLK_MAINCNT))
+
+/* Pin Mux Configuration */
+#define CONFIG_IO_10_INPUT_BUF_EN 1
+#define CONFIG_IO_10_PD_DRV_STRG 10
+#define CONFIG_IO_10_PD_SLW_RT 1
+#define CONFIG_IO_10_PU_DRV_STRG 8
+#define CONFIG_IO_10_PU_SLW_RT 1
+#define CONFIG_IO_10_RTRIM 1
+#define CONFIG_IO_10_WK_PU_EN 0
+#define CONFIG_IO_11_INPUT_BUF_EN 1
+#define CONFIG_IO_11_PD_DRV_STRG 10
+#define CONFIG_IO_11_PD_SLW_RT 1
+#define CONFIG_IO_11_PU_DRV_STRG 8
+#define CONFIG_IO_11_PU_SLW_RT 1
+#define CONFIG_IO_11_RTRIM 1
+#define CONFIG_IO_11_WK_PU_EN 0
+#define CONFIG_IO_12_INPUT_BUF_EN 1
+#define CONFIG_IO_12_PD_DRV_STRG 10
+#define CONFIG_IO_12_PD_SLW_RT 1
+#define CONFIG_IO_12_PU_DRV_STRG 8
+#define CONFIG_IO_12_PU_SLW_RT 1
+#define CONFIG_IO_12_RTRIM 1
+#define CONFIG_IO_12_WK_PU_EN 0
+#define CONFIG_IO_13_INPUT_BUF_EN 1
+#define CONFIG_IO_13_PD_DRV_STRG 10
+#define CONFIG_IO_13_PD_SLW_RT 1
+#define CONFIG_IO_13_PU_DRV_STRG 8
+#define CONFIG_IO_13_PU_SLW_RT 1
+#define CONFIG_IO_13_RTRIM 1
+#define CONFIG_IO_13_WK_PU_EN 0
+#define CONFIG_IO_14_INPUT_BUF_EN 1
+#define CONFIG_IO_14_PD_DRV_STRG 10
+#define CONFIG_IO_14_PD_SLW_RT 1
+#define CONFIG_IO_14_PU_DRV_STRG 8
+#define CONFIG_IO_14_PU_SLW_RT 1
+#define CONFIG_IO_14_RTRIM 1
+#define CONFIG_IO_14_WK_PU_EN 0
+#define CONFIG_IO_15_INPUT_BUF_EN 1
+#define CONFIG_IO_15_PD_DRV_STRG 10
+#define CONFIG_IO_15_PD_SLW_RT 1
+#define CONFIG_IO_15_PU_DRV_STRG 8
+#define CONFIG_IO_15_PU_SLW_RT 1
+#define CONFIG_IO_15_RTRIM 1
+#define CONFIG_IO_15_WK_PU_EN 0
+#define CONFIG_IO_16_INPUT_BUF_EN 0
+#define CONFIG_IO_16_PD_DRV_STRG 10
+#define CONFIG_IO_16_PD_SLW_RT 1
+#define CONFIG_IO_16_PU_DRV_STRG 8
+#define CONFIG_IO_16_PU_SLW_RT 1
+#define CONFIG_IO_16_RTRIM 1
+#define CONFIG_IO_16_WK_PU_EN 0
+#define CONFIG_IO_17_INPUT_BUF_EN 1
+#define CONFIG_IO_17_PD_DRV_STRG 10
+#define CONFIG_IO_17_PD_SLW_RT 1
+#define CONFIG_IO_17_PU_DRV_STRG 8
+#define CONFIG_IO_17_PU_SLW_RT 1
+#define CONFIG_IO_17_RTRIM 1
+#define CONFIG_IO_17_WK_PU_EN 0
+#define CONFIG_IO_1_INPUT_BUF_EN 1
+#define CONFIG_IO_1_PD_DRV_STRG 10
+#define CONFIG_IO_1_PD_SLW_RT 0
+#define CONFIG_IO_1_PU_DRV_STRG 8
+#define CONFIG_IO_1_PU_SLW_RT 0
+#define CONFIG_IO_1_RTRIM 1
+#define CONFIG_IO_1_WK_PU_EN 1
+#define CONFIG_IO_2_INPUT_BUF_EN 1
+#define CONFIG_IO_2_PD_DRV_STRG 10
+#define CONFIG_IO_2_PD_SLW_RT 0
+#define CONFIG_IO_2_PU_DRV_STRG 8
+#define CONFIG_IO_2_PU_SLW_RT 0
+#define CONFIG_IO_2_RTRIM 1
+#define CONFIG_IO_2_WK_PU_EN 1
+#define CONFIG_IO_3_INPUT_BUF_EN 1
+#define CONFIG_IO_3_PD_DRV_STRG 10
+#define CONFIG_IO_3_PD_SLW_RT 0
+#define CONFIG_IO_3_PU_DRV_STRG 8
+#define CONFIG_IO_3_PU_SLW_RT 0
+#define CONFIG_IO_3_RTRIM 1
+#define CONFIG_IO_3_WK_PU_EN 1
+#define CONFIG_IO_4_INPUT_BUF_EN 1
+#define CONFIG_IO_4_PD_DRV_STRG 10
+#define CONFIG_IO_4_PD_SLW_RT 1
+#define CONFIG_IO_4_PU_DRV_STRG 8
+#define CONFIG_IO_4_PU_SLW_RT 1
+#define CONFIG_IO_4_RTRIM 1
+#define CONFIG_IO_4_WK_PU_EN 0
+#define CONFIG_IO_5_INPUT_BUF_EN 1
+#define CONFIG_IO_5_PD_DRV_STRG 10
+#define CONFIG_IO_5_PD_SLW_RT 1
+#define CONFIG_IO_5_PU_DRV_STRG 8
+#define CONFIG_IO_5_PU_SLW_RT 1
+#define CONFIG_IO_5_RTRIM 1
+#define CONFIG_IO_5_WK_PU_EN 0
+#define CONFIG_IO_6_INPUT_BUF_EN 0
+#define CONFIG_IO_6_PD_DRV_STRG 10
+#define CONFIG_IO_6_PD_SLW_RT 1
+#define CONFIG_IO_6_PU_DRV_STRG 8
+#define CONFIG_IO_6_PU_SLW_RT 1
+#define CONFIG_IO_6_RTRIM 1
+#define CONFIG_IO_6_WK_PU_EN 0
+#define CONFIG_IO_7_INPUT_BUF_EN 1
+#define CONFIG_IO_7_PD_DRV_STRG 10
+#define CONFIG_IO_7_PD_SLW_RT 1
+#define CONFIG_IO_7_PU_DRV_STRG 8
+#define CONFIG_IO_7_PU_SLW_RT 1
+#define CONFIG_IO_7_RTRIM 1
+#define CONFIG_IO_7_WK_PU_EN 0
+#define CONFIG_IO_8_INPUT_BUF_EN 1
+#define CONFIG_IO_8_PD_DRV_STRG 10
+#define CONFIG_IO_8_PD_SLW_RT 1
+#define CONFIG_IO_8_PU_DRV_STRG 8
+#define CONFIG_IO_8_PU_SLW_RT 1
+#define CONFIG_IO_8_RTRIM 1
+#define CONFIG_IO_8_WK_PU_EN 0
+#define CONFIG_IO_9_INPUT_BUF_EN 1
+#define CONFIG_IO_9_PD_DRV_STRG 10
+#define CONFIG_IO_9_PD_SLW_RT 1
+#define CONFIG_IO_9_PU_DRV_STRG 8
+#define CONFIG_IO_9_PU_SLW_RT 1
+#define CONFIG_IO_9_RTRIM 1
+#define CONFIG_IO_9_WK_PU_EN 0
+#define CONFIG_IO_BANK_VOLTAGE_SEL_CLKRST_IO 1
+#define CONFIG_IO_BANK_VOLTAGE_SEL_PERI_IO 1
+#define PINMUX_DEDICATED_IO_10_SEL 15
+#define PINMUX_DEDICATED_IO_11_SEL 15
+#define PINMUX_DEDICATED_IO_12_SEL 15
+#define PINMUX_DEDICATED_IO_13_SEL 15
+#define PINMUX_DEDICATED_IO_14_SEL 15
+#define PINMUX_DEDICATED_IO_15_SEL 15
+#define PINMUX_DEDICATED_IO_16_SEL 13
+#define PINMUX_DEDICATED_IO_17_SEL 13
+#define PINMUX_DEDICATED_IO_4_SEL 8
+#define PINMUX_DEDICATED_IO_5_SEL 8
+#define PINMUX_DEDICATED_IO_6_SEL 8
+#define PINMUX_DEDICATED_IO_7_SEL 8
+#define PINMUX_DEDICATED_IO_8_SEL 8
+#define PINMUX_DEDICATED_IO_9_SEL 8
+#define PINMUX_I2C0_USEFPGA_SEL 0
+#define PINMUX_I2C1_USEFPGA_SEL 0
+#define PINMUX_I2CEMAC0_USEFPGA_SEL 0
+#define PINMUX_I2CEMAC1_USEFPGA_SEL 0
+#define PINMUX_I2CEMAC2_USEFPGA_SEL 0
+#define PINMUX_NAND_USEFPGA_SEL 0
+#define PINMUX_PLL_CLOCK_OUT_USEFPGA_SEL 0
+#define PINMUX_QSPI_USEFPGA_SEL 0
+#define PINMUX_RGMII0_USEFPGA_SEL 0
+#define PINMUX_RGMII1_USEFPGA_SEL 0
+#define PINMUX_RGMII2_USEFPGA_SEL 0
+#define PINMUX_SDMMC_USEFPGA_SEL 0
+#define PINMUX_SHARED_IO_Q1_10_SEL 8
+#define PINMUX_SHARED_IO_Q1_11_SEL 8
+#define PINMUX_SHARED_IO_Q1_12_SEL 8
+#define PINMUX_SHARED_IO_Q1_1_SEL 8
+#define PINMUX_SHARED_IO_Q1_2_SEL 8
+#define PINMUX_SHARED_IO_Q1_3_SEL 8
+#define PINMUX_SHARED_IO_Q1_4_SEL 8
+#define PINMUX_SHARED_IO_Q1_5_SEL 8
+#define PINMUX_SHARED_IO_Q1_6_SEL 8
+#define PINMUX_SHARED_IO_Q1_7_SEL 8
+#define PINMUX_SHARED_IO_Q1_8_SEL 8
+#define PINMUX_SHARED_IO_Q1_9_SEL 8
+#define PINMUX_SHARED_IO_Q2_10_SEL 4
+#define PINMUX_SHARED_IO_Q2_11_SEL 4
+#define PINMUX_SHARED_IO_Q2_12_SEL 4
+#define PINMUX_SHARED_IO_Q2_1_SEL 4
+#define PINMUX_SHARED_IO_Q2_2_SEL 4
+#define PINMUX_SHARED_IO_Q2_3_SEL 4
+#define PINMUX_SHARED_IO_Q2_4_SEL 4
+#define PINMUX_SHARED_IO_Q2_5_SEL 4
+#define PINMUX_SHARED_IO_Q2_6_SEL 4
+#define PINMUX_SHARED_IO_Q2_7_SEL 4
+#define PINMUX_SHARED_IO_Q2_8_SEL 4
+#define PINMUX_SHARED_IO_Q2_9_SEL 4
+#define PINMUX_SHARED_IO_Q3_10_SEL 15
+#define PINMUX_SHARED_IO_Q3_11_SEL 1
+#define PINMUX_SHARED_IO_Q3_12_SEL 1
+#define PINMUX_SHARED_IO_Q3_1_SEL 15
+#define PINMUX_SHARED_IO_Q3_2_SEL 15
+#define PINMUX_SHARED_IO_Q3_3_SEL 15
+#define PINMUX_SHARED_IO_Q3_4_SEL 15
+#define PINMUX_SHARED_IO_Q3_5_SEL 15
+#define PINMUX_SHARED_IO_Q3_6_SEL 15
+#define PINMUX_SHARED_IO_Q3_7_SEL 0
+#define PINMUX_SHARED_IO_Q3_8_SEL 0
+#define PINMUX_SHARED_IO_Q3_9_SEL 15
+#define PINMUX_SHARED_IO_Q4_10_SEL 15
+#define PINMUX_SHARED_IO_Q4_11_SEL 15
+#define PINMUX_SHARED_IO_Q4_12_SEL 15
+#define PINMUX_SHARED_IO_Q4_1_SEL 10
+#define PINMUX_SHARED_IO_Q4_2_SEL 10
+#define PINMUX_SHARED_IO_Q4_3_SEL 10
+#define PINMUX_SHARED_IO_Q4_4_SEL 10
+#define PINMUX_SHARED_IO_Q4_5_SEL 10
+#define PINMUX_SHARED_IO_Q4_6_SEL 10
+#define PINMUX_SHARED_IO_Q4_7_SEL 15
+#define PINMUX_SHARED_IO_Q4_8_SEL 15
+#define PINMUX_SHARED_IO_Q4_9_SEL 15
+#define PINMUX_SPIM0_USEFPGA_SEL 0
+#define PINMUX_SPIM1_USEFPGA_SEL 0
+#define PINMUX_SPIS0_USEFPGA_SEL 0
+#define PINMUX_SPIS1_USEFPGA_SEL 0
+#define PINMUX_UART0_USEFPGA_SEL 0
+#define PINMUX_UART1_USEFPGA_SEL 0
+#define PINMUX_USB0_USEFPGA_SEL 0
+#define PINMUX_USB1_USEFPGA_SEL 0
+
+/* Bridge Configuration */
+#define F2H_AXI_SLAVE 0
+#define F2SDRAM0_AXI_SLAVE 0
+#define F2SDRAM1_AXI_SLAVE 0
+#define F2SDRAM2_AXI_SLAVE 0
+#define H2F_AXI_MASTER 1
+#define LWH2F_AXI_MASTER 1
+
+/* Voltage Select for Config IO */
+#define CONFIG_IO_BANK_VSEL \
+	(((CONFIG_IO_BANK_VOLTAGE_SEL_CLKRST_IO & 0x3) << 8) | \
+	(CONFIG_IO_BANK_VOLTAGE_SEL_PERI_IO & 0x3))
+
+/* Macro for Config IO bit mapping */
+#define CONFIG_IO_MACRO(NAME) (((NAME ## _RTRIM & 0x7) << 19) | \
+	((NAME ## _INPUT_BUF_EN & 0x3) << 17) | \
+	((NAME ## _WK_PU_EN & 0x1) << 16) | \
+	((NAME ## _PU_SLW_RT & 0x1) << 13) | \
+	((NAME ## _PU_DRV_STRG & 0x1f) << 8) | \
+	((NAME ## _PD_SLW_RT & 0x1) << 5) | \
+	(NAME ## _PD_DRV_STRG & 0x1f))
+
+#endif /* __SOCFPGA_ARRIA10_CONFIG_H__ */
diff --git a/arch/arm/dts/socfpga_enclustra_mercury_aa1.dtsi b/arch/arm/dts/socfpga_enclustra_mercury_aa1.dtsi
new file mode 100644
index 0000000000..c3d468b01e
--- /dev/null
+++ b/arch/arm/dts/socfpga_enclustra_mercury_aa1.dtsi
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/ {
+	compatible = "altr,socfpga-arria10", "altr,socfpga";
+
+	aliases {
+		serial0 = &uart1;
+		ethernet0 = &gmac0;
+		spi0 = &qspi;
+		i2c0 = &i2c1;
+		i2c1 = &i2c0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	/* define i2c label to be used in baseboard dtsi */
+	soc {
+		i2c_encl: i2c@ffc02300 {
+		};
+		i2c_encl_fpga: i2c@ffc02200 {
+		};
+	};
+
+};
+
+&osc1 {
+	clock-frequency = <33330000>;
+};
+
+&l4_main_clk {
+	bootph-all;
+};
+
+&qspi_clk {
+	bootph-all;
+};
+
+&main_sdmmc_clk {
+	bootph-all;
+};
+
+&sdmmc_clk {
+	bootph-all;
+};
+
+&sdmmc_free_clk {
+	bootph-all;
+};
+
+&peri_sdmmc_clk {
+	bootph-all;
+};
+
+&uart1 {
+	bootph-all;
+	status = "okay";
+};
+
+&gpio1 {
+	status = "okay";
+};
+
+&gpio2 {
+	status = "okay";
+};
+
+&i2c_encl {
+	i2c-sda-hold-time-ns = <300>;
+	status = "okay";
+
+	clock-frequency = <100000>;
+
+	atsha204a: atsha204a@64 {
+		status = "okay";
+		compatible = "atmel,atsha204a";
+		reg = <0x64>;
+	};
+};
+
+&i2c_encl_fpga {
+	i2c-sda-hold-time-ns = <300>;
+	status = "disabled";
+};
+
+&mmc {
+	bootph-all;
+	status = "okay";
+	cap-sd-highspeed;
+	broken-cd;
+	bus-width = <4>;
+};
+
+&eccmgr {
+	sdmmca-ecc@ff8c2c00 {
+		compatible = "altr,socfpga-sdmmc-ecc";
+		reg = <0xff8c2c00 0x400>;
+		altr,ecc-parent = <&mmc>;
+		interrupts = <15 IRQ_TYPE_LEVEL_HIGH>,
+					 <47 IRQ_TYPE_LEVEL_HIGH>,
+					 <16 IRQ_TYPE_LEVEL_HIGH>,
+					 <48 IRQ_TYPE_LEVEL_HIGH>;
+	};
+};
+
+&qspi {
+	bootph-all;
+	status = "okay";
+
+	flash0: s25fl512s@0 {
+		bootph-all;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "spansion,s25fl512s", "jedec,spi-nor";
+		reg = <0>;
+
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
+		spi-max-frequency = <10000000>;
+
+		page-size = <256>;
+		block-size = <16>; /* 2^16, 64KB */
+		cdns,page-size = <256>;
+		cdns,block-size = <16>;
+		cdns,tshsl-ns = <200>;
+		cdns,tsd2d-ns = <255>;
+		cdns,tchsh-ns = <20>;
+		cdns,tslch-ns = <20>;
+	};
+};
+
+&watchdog1 {
+	bootph-all;
+	status = "disabled";
+};
+
+&gmac0 {
+	status = "okay";
+	/delete-property/ mac-address;
+	phy-mode = "rgmii";
+	phy-addr = <3>;
+	phy-handle = <&phy3>;
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+
+		phy3: ethernet-phy@3 {
+			reg = <3>;
+
+			/* Add 2ns RX clock delay (1.2ns + 0.78ns)*/
+			rxc-skew-ps = <1680>;
+			rxd0-skew-ps = <420>;
+			rxd1-skew-ps = <420>;
+			rxd2-skew-ps = <420>;
+			rxd3-skew-ps = <420>;
+			rxdv-skew-ps = <420>;
+
+			/* Add 1.38ns TX clock delay (0.96ns + 0.42ns)*/
+			txc-skew-ps = <1860>;
+			txd0-skew-ps = <0>;
+			txd1-skew-ps = <0>;
+			txd2-skew-ps = <0>;
+			txd3-skew-ps = <0>;
+			txen-skew-ps = <0>;
+		};
+	};
+};
+
+&usb0 {
+	status = "okay";
+	dr_mode = "host";
+};
+
diff --git a/arch/arm/dts/socfpga_enclustra_mercury_aa1_qspi_boot.dtsi b/arch/arm/dts/socfpga_enclustra_mercury_aa1_qspi_boot.dtsi
new file mode 100644
index 0000000000..f51dc7c55f
--- /dev/null
+++ b/arch/arm/dts/socfpga_enclustra_mercury_aa1_qspi_boot.dtsi
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/ {
+	fs_loader0: fs-loader {
+		bootph-all;
+		compatible = "u-boot,fs-loader";
+		sfconfig = <0 0 50000000 3>;
+	};
+};
+
+&fpga_mgr {
+	bootph-all;
+	firmware-loader = <&fs_loader0>;
+	altr,bitstream = "300000";
+};
diff --git a/arch/arm/dts/socfpga_enclustra_mercury_aa1_sdmmc_boot.dtsi b/arch/arm/dts/socfpga_enclustra_mercury_aa1_sdmmc_boot.dtsi
new file mode 100644
index 0000000000..052726e318
--- /dev/null
+++ b/arch/arm/dts/socfpga_enclustra_mercury_aa1_sdmmc_boot.dtsi
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/ {
+	fs_loader0: fs-loader {
+		bootph-all;
+		compatible = "u-boot,fs-loader";
+		phandlepart = <&mmc 1>;
+	};
+};
+
+&fpga_mgr {
+	bootph-all;
+	firmware-loader = <&fs_loader0>;
+	altr,bitstream = "bitstream.itb";
+};
diff --git a/arch/arm/dts/socfpga_enclustra_mercury_pe1.dtsi b/arch/arm/dts/socfpga_enclustra_mercury_pe1.dtsi
new file mode 100644
index 0000000000..e39474f443
--- /dev/null
+++ b/arch/arm/dts/socfpga_enclustra_mercury_pe1.dtsi
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/ {
+};
diff --git a/arch/arm/dts/socfpga_enclustra_mercury_pe3.dtsi b/arch/arm/dts/socfpga_enclustra_mercury_pe3.dtsi
new file mode 100644
index 0000000000..85d5050bb1
--- /dev/null
+++ b/arch/arm/dts/socfpga_enclustra_mercury_pe3.dtsi
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+&i2c_encl_fpga {
+	status = "okay";
+};
diff --git a/arch/arm/dts/socfpga_enclustra_mercury_st1.dtsi b/arch/arm/dts/socfpga_enclustra_mercury_st1.dtsi
new file mode 100644
index 0000000000..85d5050bb1
--- /dev/null
+++ b/arch/arm/dts/socfpga_enclustra_mercury_st1.dtsi
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+&i2c_encl_fpga {
+	status = "okay";
+};
-- 
2.25.1

