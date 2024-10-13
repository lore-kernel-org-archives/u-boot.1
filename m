Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E39ACF259F
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 02:45:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D024D88DA0;
	Mon, 14 Oct 2024 04:44:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UatDPcF4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2E2288F0C; Sun, 13 Oct 2024 16:32:50 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A94E88F20
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 16:32:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c94c0bf354so531142a12.1
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 07:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728829959; x=1729434759; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PhllRc8Q5gq1L5SXWifrJa+iqvbAu5z8p2u+eIt0QWU=;
 b=UatDPcF4xUDwfcHmKT5A1HVZ2Iz2kysGwJcD4SU9a3atiTZY6qxtYoPv3h2PXKSbd0
 c3M6C61V4bHYhzc2IBeNWt6jy5anQW2ljVCjORX/ER3v4wLA6FQ1lWQU93FIylyaj8if
 lFDVt/21oDt9UuhX9PX+Abo/D96TGF6sL2wNkuXZcRLSLu4DzFRrj+9NEchmUB0hgZ9p
 6tFxPIPeaPpElmbqnQlIhZEGuPtTlaIbdq82qsPUNxHnOXh35T/OIUNL1bqiukB4W+Wu
 10UcHaz1o8DzFRAGs2LpvQz3g55fUMu2+xQjGxZrqYAcOXDFoQgFHkiV8tc2YpCbB6qo
 NmTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728829959; x=1729434759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PhllRc8Q5gq1L5SXWifrJa+iqvbAu5z8p2u+eIt0QWU=;
 b=ROfGOlr2Z12aUZeU65maeAyPI7+1c51Xam6inY4fKpFIRZD6T2GlWJK11kq0zLSfKR
 ElyaeJEr/DHI2l6ew22m57MooJ/tl6mXPCbfBdqnI8GGS3h2jgkSggPw2yj9HdXiaGeb
 24CkNiz/6FM9d4IbeSZmzw60XjlJzhIiCYgVIOxyNSCypsVs7Ws+IXbb+2ILYLxnSs4J
 2Ms5DDp+Sw7w+8+leDA/TRXG2Hw62vewEkkOJRrvq3DZvJw6W6V8HL2AEYhlNaDQWiXQ
 awYSQL3H6kwcz8ECFVKq7fLArS5FMmzTdRSkbhvRC6pHsVd4C6RgCOGvj34uKFx31Ewa
 x1IA==
X-Gm-Message-State: AOJu0YwQOttn8IaRg2RKrcTgjdln8FaieAtmMwuyk4w8KJaTfVUbdoPx
 ETuqqvaTaCuMQgDgDN51v7SAoyGisaZjma7BEMquPoZzIhFQXq7xdA1APQ==
X-Google-Smtp-Source: AGHT+IGPe1ixU0J9xxhuK7iXz7rb+pkC1VeJKQh08EQTb4kWulcJA2NPkAmJw4dy3UTq1rE4otOpAg==
X-Received: by 2002:a17:907:948b:b0:a80:f54c:ad68 with SMTP id
 a640c23a62f3a-a99b93d4a85mr371478766b.2.1728829959064; 
 Sun, 13 Oct 2024 07:32:39 -0700 (PDT)
Received: from e8ff02ae9b18.v.cablecom.net (84-72-156-211.dclient.hispeed.ch.
 [84.72.156.211]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99efcf15d1sm189886266b.102.2024.10.13.07.32.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 07:32:38 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: u-boot@lists.denx.de, trini@konsulko.com, marex@denx.de,
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sumit.garg@linaro.org
Cc: sjg@chromium.org, xypron.glpk@gmx.de, michal.simek@amd.com,
 jit.loon.lim@intel.com, barnas@google.com, l.rubusch@gmail.com
Subject: [PATCH 03/10] ARM: dts: socfpga: add Mercury+ AA1 for u-boot dts
Date: Sun, 13 Oct 2024 14:32:25 +0000
Message-Id: <20241013143232.2090645-4-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241013143232.2090645-1-l.rubusch@gmail.com>
References: <20241013143232.2090645-1-l.rubusch@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Oct 2024 04:44:22 +0200
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

Introduce u-boot specific device-tree files for Enclustra Mercury+ AA1
SoMs (Intel/arria10).

Generic device-tree fragments for linux and U-boot shall be provided in
dts/upstream. The selection of the generic device-tree fragments depends
on a selected boot-mode and a selected carrier board.

On Intel/Arria10 a handoff setup is needed for initialization of
various clock / pinmux / DRAM settings only used by U-Boot provided by
the current patch.

Signed-off-by: Andreas Buerkler <andreas.buerkler@enclustra.com>
Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 .../socfpga_arria10_enclustra_mercury_aa1.dts |  86 +++++
 .../socfpga_arria10_mercury_aa1-u-boot.dtsi   |  19 ++
 .../dts/socfpga_arria10_mercury_aa1_handoff.h | 305 ++++++++++++++++++
 board/enclustra/mercury_aa1/Kconfig           |  37 +++
 board/enclustra/mercury_aa1/MAINTAINERS       |   2 +
 5 files changed, 449 insertions(+)
 create mode 100644 arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1.dts
 create mode 100644 arch/arm/dts/socfpga_arria10_mercury_aa1_handoff.h

diff --git a/arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1.dts b/arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1.dts
new file mode 100644
index 0000000000..1b29ab9358
--- /dev/null
+++ b/arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1.dts
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/dts-v1/;
+
+/* The arria10 family */
+#include "socfpga/socfpga_arria10_mercury_aa1.dtsi"
+
+/ {
+	aliases {
+		ethernet0 = &gmac0;
+		serial0 = &uart0;
+		serial1 = &uart1;
+		i2c0 = &i2c1;
+		i2c1 = &i2c0;
+		spi0 = &qspi;
+	};
+};
+
+&qspi {
+	bootph-all;
+	status = "okay";
+	flash0: s25fl512s@0 {
+		bootph-all;
+
+		cdns,page-size = <256>;
+		cdns,block-size = <16>;
+
+		cdns,tshsl-ns = <200>;
+		cdns,tsd2d-ns = <255>;
+		cdns,tchsh-ns = <20>;
+		cdns,tslch-ns = <20>;
+	};
+};
+
+/* Carrier board support */
+#if IS_ENABLED(CONFIG_ENCLUSTRA_PE1)
+# include "socfpga/socfpga_enclustra_mercury_pe1.dtsi"
+#elif IS_ENABLED(CONFIG_ENCLUSTRA_PE3)
+# include "socfpga/socfpga_enclustra_mercury_pe3.dtsi"
+#elif IS_ENABLED(CONFIG_ENCLUSTRA_ST1)
+# include "socfpga/socfpga_enclustra_mercury_st1.dtsi"
+#endif
+
+/* Arria10 handoff (u-boot) */
+#include "socfpga_arria10_mercury_aa1_handoff.h"
+#include "socfpga_arria10-handoff.dtsi"
+#include "socfpga_arria10_handoff_u-boot.dtsi"
+#include "socfpga_arria10_mercury_aa1-u-boot.dtsi"
+
+/* Specific boot-mode (u-boot) */
+#if IS_ENABLED(CONFIG_ENCLUSTRA_SDMMC) || IS_ENABLED(CONFIG_ENCLUSTRA_EMMC)
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
+	altr,bitstream = "fpga.itb";
+};
+
+#elif IS_ENABLED(CONFIG_ENCLUSTRA_QSPI)
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
+
+#endif
diff --git a/arch/arm/dts/socfpga_arria10_mercury_aa1-u-boot.dtsi b/arch/arm/dts/socfpga_arria10_mercury_aa1-u-boot.dtsi
index 8866df3ddd..ad5b5a87e0 100644
--- a/arch/arm/dts/socfpga_arria10_mercury_aa1-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_arria10_mercury_aa1-u-boot.dtsi
@@ -33,6 +33,21 @@
 	bootph-all;
 };
 
+&l4_main_clk {
+	bootph-all;
+};
+
+&qspi_clk {
+	bootph-all;
+};
+
+&qspi {
+	bootph-all;
+	flash0: s25fl512s@0 {
+		bootph-all;
+	};
+};
+
 &mmc {
 	bootph-all;
 };
@@ -52,3 +67,7 @@
 &uart1 {
 	bootph-all;
 };
+
+&watchdog1 {
+	bootph-all;
+};
diff --git a/arch/arm/dts/socfpga_arria10_mercury_aa1_handoff.h b/arch/arm/dts/socfpga_arria10_mercury_aa1_handoff.h
new file mode 100644
index 0000000000..b7cdb74792
--- /dev/null
+++ b/arch/arm/dts/socfpga_arria10_mercury_aa1_handoff.h
@@ -0,0 +1,305 @@
+/* SPDX-License-Identifier: BSD-3-Clause */
+/*
+ * Intel Arria 10 SoCFPGA configuration
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
diff --git a/board/enclustra/mercury_aa1/Kconfig b/board/enclustra/mercury_aa1/Kconfig
index 40c7cb2687..a5f3c2a051 100644
--- a/board/enclustra/mercury_aa1/Kconfig
+++ b/board/enclustra/mercury_aa1/Kconfig
@@ -12,4 +12,41 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "socfpga_mercury_aa1"
 
+choice
+	prompt "Mercury+ AA1 base-board"
+	default ENCLUSTRA_PE1
+	help
+	  Select the base-board for Mercury+ AA1.
+
+config ENCLUSTRA_PE1
+	bool "Mercury+ PE1"
+
+config ENCLUSTRA_PE3
+	bool "Mercury+ PE3"
+
+config ENCLUSTRA_ST1
+	bool "Mercury+ ST1"
+
+config ENCLUSTRA_CUSTOM_BASE
+	bool "Customized base-board"
+
+endchoice
+
+choice
+	prompt "Mercury+ AA1 boot-mode"
+	default ENCLUSTRA_SDMMC
+	help
+	  Select the boot-mode for the Mercury+ AA1 setup.
+
+config ENCLUSTRA_SDMMC
+	bool "SD card"
+
+config ENCLUSTRA_EMMC
+	bool "eMMC"
+
+config ENCLUSTRA_QSPI
+	bool "QSPI flash"
+
+endchoice
+
 endif
diff --git a/board/enclustra/mercury_aa1/MAINTAINERS b/board/enclustra/mercury_aa1/MAINTAINERS
index 80fcda639a..118968126a 100644
--- a/board/enclustra/mercury_aa1/MAINTAINERS
+++ b/board/enclustra/mercury_aa1/MAINTAINERS
@@ -1,6 +1,8 @@
 Enclustra Mercury+ AA1
 M:	Lothar Rubusch <l.rubusch@gmail.com>
 S:	Maintained
+F:	arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1.dts
+F:	arch/arm/dts/socfpga_arria10_mercury_aa1_handoff.h
 F:	board/enclustra/mercury_aa1/
 F:	board/enclustra/common/
 F:	configs/socfpga_enclustra_mercury_aa1_defconfig
-- 
2.25.1

